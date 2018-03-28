require 'sketchup.rb'
require 'extensions.rb'

module ProjectSkyplot
  module Plotter

    unless file_loaded?(__FILE__)
      ex = SketchupExtension.new('Plotter', 'plotter/main')
      ex.description = 'Utility to plot the soints in a constellation.'
      ex.version     = '1.0.0'
      ex.copyright   = 'Team Skyplot © 2018'
      ex.creator     = 'Voidlight'
      Sketchup.register_extension(ex, true)
      file_loaded(__FILE__)
    end

  end # module ProjectSkyplot
end # module Plotter