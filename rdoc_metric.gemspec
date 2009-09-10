Gem::Specification.new do |s|
  s.name = %q{rdoc_metric}
  s.version = "0.1.0"
 
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Chris Powers"]
  s.date = %q{2009-09-10}
  s.description = %q{RdocMetric analyzes the Rdoc coverage of Ruby files.}
  s.email = %q{chrisjpowers@gmail.com}
  s.executables << 'rdoc_metric'
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["LICENSE","README.rdoc","bin/rdoc_metric","lib/rdoc_metric.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/chrisjpowers/rdoc_metric}
  s.rdoc_options = ["--quiet", "--title", "RdocMetric documentation", "--opname", "index.html", "--line-numbers", "--main", "README.rdoc", "--inline-source"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{RdocMetric analyzes the Rdoc coverage of Ruby files.}
  s.test_files = []
 
  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3
 
    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end