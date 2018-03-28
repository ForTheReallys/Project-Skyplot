require 'sketchup.rb'

module ProjectSkyplot
  module Plotter

def self.plot_asterism #(coordinates)
  model = Sketchup.active_model
  model.start_operation('Plot Asterism', true)
  entities = model.active_entities

  # default coordinates array for testing purposes
  coordinates = [20, 20, 20, 50, 30, 40, 88, 99, 55]

  if(coordinates.length % 3 != 0)
    UI.messagebox("Improper coordinates array! There must be three values (x, y, z) for each point.")
  end

  # main counter
  i = 0
  # sub counter
  j = 0
  # sub arrays
  x = []
  y = []
  z = []

  # copy input array into x, y, and z arrays
  while i < coordinates.length
    x[j] = coordinates[i]
    i+=1
    y[j] = coordinates[i]
    i+=1
    z[j] = coordinates[i]
    i+=1
    j+=1
  end

  for num in 0..x.length
    point1 = Geom::Point3d.new(0,0,0)
    point2 = Geom::Point3d.new(x[num], y[num], z[num])
    constline = entities.add_cline(point1, point2)
    vector = constline.direction
  end

  model.commit_operation
end

unless file_loaded?(__FILE__)
  menu = UI.menu('Plugins')
  menu.add_item('Plot Asterism *Test*') {
    self.plot_asterism #(coordinates)
  }

  file_loaded(__FILE__)
end

  end # module ProjectSkyplot
end # module Plotter