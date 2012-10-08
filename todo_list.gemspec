# coding: utf-8
Gem::Specification.new do |gem|
  gem.authors       = ['Elia Schito']
  gem.email         = ['elia@schito.me']
  gem.description   = %q{A CLI todo list}
  gem.summary       = %q{A Cool Todo List!}
  gem.homepage      = ''

  # gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files -- lib/apps-dashboard*`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'cool-todo-list'
  gem.require_paths = ['lib']
  gem.version       = '1.0'
end
