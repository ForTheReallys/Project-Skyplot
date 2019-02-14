require 'sketchup.rb'
require 'extensions.rb'

module ProjectSkyplot
  module Skyplot

    unless file_loaded?(__FILE__)
      ex = SketchupExtension.new('Skyplot', 'skyplot/main')
      ex.description = 'Utility to plot the points in a constellation.'
      ex.version     = '1.0.0'
      ex.copyright   = 'Team Skyplot © 2018'
      ex.creator     = 'Andrew Miller'
      Sketchup.register_extension(ex, true)
      file_loaded(__FILE__)
    end

  end # module ProjectSkyplot
end # module Plotter
