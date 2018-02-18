#This is just basic script that reads an excel file
#and input the data into an array
require win32ole
module readEx
    excel=win32ole::new('excel.Application')
    workbook = excel.Workbooks.Open('C:\Users\Jmtran1216\Documents\GitHub\Project-Skyplot\pyxis star coords.xlsx')
    worksheet = workbook.Worksheets(1) #Positioning to the first sheet of the workbook
    data = worksheet.Range('a3:l3')['Value']
    