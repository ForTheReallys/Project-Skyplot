<<<<<<< HEAD
require 'sketchup.rb'

require 'skyplot/debug'
require 'skyplot/html_ui'
require 'skyplot/input/textbox'
require 'skyplot/input/dropdown'
require 'skyplot/input/listbox'


module Example::HtmlInputBox

  unless file_loaded?(__FILE__)
    menu = UI.menu('Plugins').add_item('Skyplot') {
      self.custom_advanced  
    }
    # menu.add_item('HtmlUI.input - Without Options - Skyplot') {
    #   self.prompt_without_options
    # }
    # menu.add_item('HtmlUI.input - With Options - Skyplot') {
    #   self.prompt_with_options
    # }
    # menu.add_item('HtmlUI.input - Advanced - Skyplot') {
    #   self.prompt_advanced
    # }
    # menu.add_item('Project Skyplot - file input') {
    #   self.custom_advanced
    # }
    file_loaded(__FILE__)
  end

  # Simple example with similar calling signature as UI.inputbox.
  def self.prompt_without_options
    title = 'Tell me about yourself'
    prompts = ['What is your Name?', 'What is your Age?', 'Gender']
    defaults = ['Enter name', 42, 'Male']
    results = HtmlUI.inputbox(prompts, defaults, title)
    p results
  end

  # Simple example with similar calling signature as UI.inputbox.
  def self.prompt_with_options
    title = 'Tell me about yourself'
    prompts = ['What is your Name?', 'What is your Age?', 'Gender']
    defaults = ['Enter name', 42, 'Male']
    list = ['', '', 'Male|Female']
    results = HtmlUI.inputbox(prompts, defaults, list, title)
    p results
  end

  # Example of how more advanced inputs can be created.
  def self.prompt_advanced
    options = {
      title: 'HtmlDialog Options',
      accept_button: 'Ok',
      cancel_button: 'Cancel',
      inputs: [
        HtmlUI::Textbox.new('Name'),
        HtmlUI::Textbox.new('Age', 42),
        HtmlUI::Dropdown.new('Gender', 'Male', ['Male', 'Female']),
        HtmlUI::Listbox.new('Profession', 'Minion', [
          'None', 'Developer', 'Dictator', 'Minion'
        ]),
      ]
    }
    dialog = HtmlUI::InputBox.new(options)
    results = dialog.prompt
    p results
  end
  

  def self.custom_advanced
    #Sketchup.active_model.rendering_options["EdgeColorMode"] = 0
    model = Sketchup.active_model
    #model.rendering_options["ConstructionColor"] = 120, 22, 13
    #model.start_operation('Plot Asterism', true)
    entities = model.active_entities
    options = {
      title: 'Select a file or Enter in your coordinates',
      accept_button: 'Ok',
      cancel_button: 'Cancel',
      inputs: [
        HtmlUI::Textbox.new('RA Deg'),
        HtmlUI::Textbox.new('Dec Deg'),
        HtmlUI::Textbox.new('Light Years'),
        # HtmlUI::Listbox.new('Constellations', 'None', [
        #   'None', 'Orion', 'Scorpius', 'Cassiopeia', 'Taurus','Sagittarius'
        # ]),
      ]
    }
    dialog = HtmlUI::InputBox.new(options)
    results = dialog.prompt

    # p results
    radiansConstant = 180/Math::PI
    #90 = (90.0/180) * Math::PI
    oneEightyDegreesInRadians = (180.0/180) * Math::PI
    # = (270.0/180) * Math::PI
    i = 0
    j = 0
    g = 0
    ra = []
    dec = []
    d = []
    x = 0
    y = 0
    z = 0
    coords = []
    while i < results.length
        ra.push(results[i].to_f)
        dec.push(results[i+1].to_f)
        d.push(results[i+2].to_f)
        i+=3
    end

    while j < ra.length
        # dec[j] = (d[j]/180) * Math::PI
        # ra[j] = (ra[j]/180) * Math::PI 
        z = d[j] * (Math.sin(dec[j]))

    # account for different sectors
        if ra[j]>0 && ra[j] < 90
            x = (d[j] * Math.cos(dec[j])) * (Math.sin(ra[j]))
            y = 0-((d[j] * Math.cos(dec[j])) * (Math.sin(90 - ra[j]))).abs
            coords.push(x)
            coords.push(y)
            coords.push(z)
        elsif ra[j]>90 && ra[j]<180
            x = (d[j] * Math.cos(dec[j])) * (Math.sin(ra[j]))
            y = (d[j] * Math.cos(dec[j])) * (Math.sin(ra[j]-90))
            coords.push(x)
            coords.push(y)
            coords.push(z)
        elsif ra[j]>180 && ra[j]<270
            x = 0-((d[j] * Math.cos(dec[j])) * (Math.sin(ra[j]-180))).abs
            y = (d[j] * Math.cos(dec[j])) * (Math.sin(90 - ra[j]- 180))
            coords.push(x)
            coords.push(y)
            coords.push(z)
        elsif ra[j]>270 && ra[j]< 360
            x = 0-((d[j] * Math.cos(dec[j])) * (Math.sin(90 - ra[j] - 270))).abs
            y = 0-((d[j] * Math.cos(dec[j])) * (Math.sin(ra[j]- 270))).abs
            coords.push(x)
            coords.push(y)
            coords.push(z)
        else
            UI.messagebox("Improper right ascension value in row " + j)
        end
        j+=1
    end

    p coords
    #model.rendering_options["ConstructionColor"] = 1+rand(255), 1+rand(255), 1+rand(255)
    while g < coords.length
        #model.rendering_options["ConstructionColor"] = 1+rand(255), 1+rand(255), 1+rand(255)
        point1 = Geom::Point3d.new(0,0,0)
        point2 = Geom::Point3d.new(coords[g], coords[g+1], (coords[g+2]))
        constline = entities.add_line(point1, point2) 
        # entity = constline
        # entity.material = 'red'
        #constline.material.color = Sketchup::Color.new((1 + rand(255)), (1 + rand(255)), (1 + rand(255)))
        #vector = constline.direction
        g += 3
    end

    model.commit_operation

end

def radiansToDegrees(radians)
    result = radians * (180/Math::PI)
end

def degreesToRadians(degrees)
    floatDegrees = degrees.to_f
    result = (floatDegrees/180) * Math::PI
end
end # module
=======
require 'sketchup.rb'

require 'skyplot/debug'
require 'skyplot/html_ui'
require 'skyplot/input/textbox'
require 'skyplot/input/dropdown'
require 'skyplot/input/listbox'


module Example::HtmlInputBox

  unless file_loaded?(__FILE__)
    menu = UI.menu('Plugins').add_item('Skyplot') {
      self.custom_advanced  
    }
    # menu.add_item('HtmlUI.input - Without Options - Skyplot') {
    #   self.prompt_without_options
    # }
    # menu.add_item('HtmlUI.input - With Options - Skyplot') {
    #   self.prompt_with_options
    # }
    # menu.add_item('HtmlUI.input - Advanced - Skyplot') {
    #   self.prompt_advanced
    # }
    # menu.add_item('Project Skyplot - file input') {
    #   self.custom_advanced
    # }
    file_loaded(__FILE__)
  end

  # Simple example with similar calling signature as UI.inputbox.
  def self.prompt_without_options
    title = 'Tell me about yourself'
    prompts = ['What is your Name?', 'What is your Age?', 'Gender']
    defaults = ['Enter name', 42, 'Male']
    results = HtmlUI.inputbox(prompts, defaults, title)
    p results
  end

  # Simple example with similar calling signature as UI.inputbox.
  def self.prompt_with_options
    title = 'Tell me about yourself'
    prompts = ['What is your Name?', 'What is your Age?', 'Gender']
    defaults = ['Enter name', 42, 'Male']
    list = ['', '', 'Male|Female']
    results = HtmlUI.inputbox(prompts, defaults, list, title)
    p results
  end

  # Example of how more advanced inputs can be created.
  def self.prompt_advanced
    options = {
      title: 'HtmlDialog Options',
      accept_button: 'Ok',
      cancel_button: 'Cancel',
      inputs: [
        HtmlUI::Textbox.new('Name'),
        HtmlUI::Textbox.new('Age', 42),
        HtmlUI::Dropdown.new('Gender', 'Male', ['Male', 'Female']),
        HtmlUI::Listbox.new('Profession', 'Minion', [
          'None', 'Developer', 'Dictator', 'Minion'
        ]),
      ]
    }
    dialog = HtmlUI::InputBox.new(options)
    results = dialog.prompt
    p results
  end
  

  def self.custom_advanced
    #Sketchup.active_model.rendering_options["EdgeColorMode"] = 0
    model = Sketchup.active_model
    #model.rendering_options["ConstructionColor"] = 120, 22, 13
    #model.start_operation('Plot Asterism', true)
    entities = model.active_entities
    options = {
      title: 'Select a file or Enter in your coordinates',
      accept_button: 'Ok',
      cancel_button: 'Cancel',
      inputs: [
        HtmlUI::Textbox.new('RA Deg'),
        HtmlUI::Textbox.new('Dec Deg'),
        HtmlUI::Textbox.new('Light Years'),
        # HtmlUI::Listbox.new('Constellations', 'None', [
        #   'None', 'Orion', 'Scorpius', 'Cassiopeia', 'Taurus','Sagittarius'
        # ]),
      ]
    }
    dialog = HtmlUI::InputBox.new(options)
    results = dialog.prompt

    # p results
    radiansConstant = 180/Math::PI
    #90 = (90.0/180) * Math::PI
    oneEightyDegreesInRadians = (180.0/180) * Math::PI
    # = (270.0/180) * Math::PI
    i = 0
    j = 0
    g = 0
    ra = []
    dec = []
    d = []
    x = 0
    y = 0
    z = 0
    coords = []
    while i < results.length
        ra.push(results[i].to_f)
        dec.push(results[i+1].to_f)
        d.push(results[i+2].to_f)
        i+=3
    end

    while j < ra.length
        # dec[j] = (d[j]/180) * Math::PI
        # ra[j] = (ra[j]/180) * Math::PI 
        z = d[j] * (Math.sin(dec[j]))

    # account for different sectors
        if ra[j]>0 && ra[j] < 90
            x = (d[j] * Math.cos(dec[j])) * (Math.sin(ra[j]))
            y = 0-((d[j] * Math.cos(dec[j])) * (Math.sin(90 - ra[j]))).abs
            coords.push(x)
            coords.push(y)
            coords.push(z)
        elsif ra[j]>90 && ra[j]<180
            x = (d[j] * Math.cos(dec[j])) * (Math.sin(ra[j]))
            y = (d[j] * Math.cos(dec[j])) * (Math.sin(ra[j]-90))
            coords.push(x)
            coords.push(y)
            coords.push(z)
        elsif ra[j]>180 && ra[j]<270
            x = 0-((d[j] * Math.cos(dec[j])) * (Math.sin(ra[j]-180))).abs
            y = (d[j] * Math.cos(dec[j])) * (Math.sin(90 - ra[j]- 180))
            coords.push(x)
            coords.push(y)
            coords.push(z)
        elsif ra[j]>270 && ra[j]< 360
            x = 0-((d[j] * Math.cos(dec[j])) * (Math.sin(90 - ra[j] - 270))).abs
            y = 0-((d[j] * Math.cos(dec[j])) * (Math.sin(ra[j]- 270))).abs
            coords.push(x)
            coords.push(y)
            coords.push(z)
        else
            UI.messagebox("Improper right ascension value in row " + j)
        end
        j+=1
    end

    p coords
    #model.rendering_options["ConstructionColor"] = 1+rand(255), 1+rand(255), 1+rand(255)
    while g < coords.length
        #model.rendering_options["ConstructionColor"] = 1+rand(255), 1+rand(255), 1+rand(255)
        point1 = Geom::Point3d.new(0,0,0)
        point2 = Geom::Point3d.new(coords[g], coords[g+1], (coords[g+2]))
        constline = entities.add_line(point1, point2) 
        # entity = constline
        # entity.material = 'red'
        #constline.material.color = Sketchup::Color.new((1 + rand(255)), (1 + rand(255)), (1 + rand(255)))
        #vector = constline.direction
        g += 3
    end

    model.commit_operation

end

def radiansToDegrees(radians)
    result = radians * (180/Math::PI)
end

def degreesToRadians(degrees)
    floatDegrees = degrees.to_f
    result = (floatDegrees/180) * Math::PI
end
end # module
>>>>>>> b498f57db968744cc0cbd479f566e13702e1a470
