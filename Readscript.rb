#This is just basic script that reads an excel file
#and input the data into an array
require 'roo' 
module ReadEx
  workbook = Roo::Spreadsheet.open 'C:\Users\Jmtran1216\Documents\GitHub\Project-Skyplot\pyxis star coords.xlsx'
  worksheets = workbook.sheets
  i = 0
  j = 0
  coords =[]
  puts "Found #{worksheets.count} worksheets"
  worksheets.each do |worksheet|
        puts "Reading: #{worksheet}"
        num_rows = 0
        workbook.sheet(worksheet).each_row_streaming do |row|
        row_cells = row.map { |cell| cell.value }
        coords[i]= row_cells
        j+=1
        num_rows +=1
      end
      puts "Read #{num_rows} rows" 
    end
  while i<coords.length
    puts coords[i]
    i+=1
    end
end