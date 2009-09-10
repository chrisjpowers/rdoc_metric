# Developed by Chris Powers (http://github.com/chrisjpowers)
# Version 0.1 -- September 10, 2009
# 
# The RdocMetric class parses through ruby files and determines how 
# well documented they are. It looks for a comment on the line before
# each class, module, method, attribute and constant declaration to
# determine if documentation exists.
# 
# Calling the #to_s method will output a list of all the parsed files,
# displaying how many of each declaration were documented, along with
# an overall percentage of coverage.
# 
# Currently there is no weight given to classes vs. methods vs. constants,
# the percentage is simply based on the overall entity count.
# 
class RdocMetric
  
  # Accepts a path that is sent to Dir.glob
  # 
  # Ex: <tt>RdocMetric.new("/apps/my_app/**/*.rb")
  def initialize(path)
    files = Dir.glob(path)
    @files = files.map {|f| RdocFile.new(f) }
  end
  
  # The overall percentage of coverage as an integer
  def score
    @files.inject(0) {|sum, file| sum += file.score } / @files.length
  end
  
  # Outputs the full listing of rdoc coverage for all parsed files.
  def to_s
    out = "* * * Total Rdoc Coverage: #{score}% * * *\n\n"
    return out + @files.map(&:to_s).join("\n") + "\n" + out
  end
  
  
  # models a single parsed file
  class RdocFile
    def initialize(filepath)
      @filepath = filepath
      @methods = []
      @classes = []
      @modules = []
      @attrs = []
      @constants = []
      parse_file!
    end
    
    # Percentage of rdoc coverage for this file as an Integer
    def score
      total = 0
      docs = 0
      [@classes, @modules, @methods, @constants, @attrs].each do |collection|
        collection.each do |item|
          total += 1
          docs += 1 if item
        end
      end
      return 100 if total == 0
      return ((docs.to_f / total) * 100).to_i
    end
    
    # Outputs the coverage breakdown message for this file.
    def to_s
      out  = "Rdoc Coverage for #{@filepath}: #{score}%\n"
      out += "  Classes: #{@classes.select{|c| c }.length}/#{@classes.length}\n" unless @classes.empty?
      out += "  Modules: #{@modules.select{|c| c }.length}/#{@modules.length}\n" unless @modules.empty?
      out += "  Methods: #{@methods.select{|c| c }.length}/#{@methods.length}\n" unless @methods.empty?
      out += "  Attributes: #{@attrs.select{|c| c }.length}/#{@attrs.length}\n" unless @attrs.empty?
      out += "  Constants: #{@constants.select{|c| c }.length}/#{@constants.length}\n" unless @constants.empty?
      out
    end
    
    private
    
    # Parses through file, adds true or false entries into collections
    # as it encounters documented and undocumented declarations, respectively
    def parse_file!
      File.open(@filepath, 'r') do |f|
        last_line = ''
        while this_line = f.gets
          coll = case this_line
            when /^\s*def /     : @methods
            when /^\s*class /   : @classes
            when /^\s*module /  : @modules
            when /^\s*(attr_reader|attr_accessor|attr_writer) / : @attrs
            when /^\s*[^a-z =]+\s*=/ : @constants
            else nil
          end
          # add a true entry if comment precedes declaration or follows on same line
          coll << is_comment?(last_line) || has_comment?(this_line) if coll
          last_line = this_line
        end
      end
    end
    
    # Does the line start with a # ?
    def is_comment?(line)
      line =~ /^\s*#/
    end
    
    # Does the line have a # anywhere on it?
    def has_comment?(line)
      line =~ /#[^{]/
    end
  end
end