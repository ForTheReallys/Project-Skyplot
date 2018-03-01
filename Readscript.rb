#This is just basic script that reads an excel file

require 'roo' 
#require 'sketchup.rb'
#require 'extensions.rb'

module ReadEx
  workbook = Roo::Spreadsheet.open 'C:\Users\Jmtran1216\Documents\GitHub\Project-Skyplot\pyxis star coords.xlsx'
  worksheets = workbook.sheets
  i = 0
  j = 0
  coords =Array.new
  puts "Found #{worksheets.count} worksheets"
  worksheets.each do |worksheet|
        puts "Reading: #{worksheet}"
        num_rows = 0
        workbook.sheet(worksheet).each_row_streaming do |row|
        row_cells = row.map { |cell| cell.value }
        coords[num_rows]= row_cells
        num_rows +=1
      end
      puts "Read #{num_rows} rows" 
    end
  while i<coords.length
    puts coords[i]
    i+=1
    end
end