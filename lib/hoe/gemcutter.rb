require 'rake'

class Hoe
  module Gemcutter
    def define_gemcutter_tasks
      desc "Push gem to gemcutter."
      task :release_to_gemcutter => [:clean, :package, :release_sanity] do
        pkg   = "pkg/#{spec.name}-#{spec.version}"
        gems  = Dir["#{pkg}*.gem"]
        gems.each do |g|
          # TODO - once gemcutter supports command invocation, use it.
          # We could still fail here due to --format executable
          sh Gem.ruby, "-S", "gem", "push", g
        end
      end

      task :release_to => :release_to_gemcutter
    end
  end unless defined? Gemcutter # HACK - tests force load twice
end
