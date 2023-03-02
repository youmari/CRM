require 'csv'


def csv_file_path
  @csv_file_path ||= File.read('CRM_data.csv')
end

def csv
  @csv ||= CSV.parse(csv_file_path, col_sep: ",", row_sep: :auto, skip_blanks: true, headers: true)
end

csv.each do |row|
  unless Company.find_by(name: row[5]) || !row[5]
    Company.create!(name: row[5])
  end

  Employee.create!(first_name: row[0], last_name: row[1], email: row[2], 
                stage:row[3], phone_number: row[4], 
                company: Company.find_by(name: row[5]), 
                probability: row[6] || 0 )
end

p 'done!!!'