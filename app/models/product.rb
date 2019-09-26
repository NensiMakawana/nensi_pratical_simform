class Product < ApplicationRecord
 
  def self.import(filepath)
    spreadsheet = Roo::Spreadsheet.open(filepath.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = find_by(id: row["id"]) || new
      product.attributes = row.to_hash
      byebug
      product.save!
    end
  end  

  def self.open_spreadsheet(filepath)
    case File.extname(filepath.path)
     when '.csv' then Roo::Csv.new(filepath.path, nil, :ignore)
     when '.xls' then Roo::Excel.new(filepath.path, nil, :ignore)
     when '.xlsx' then Roo::Excelx.new(filepath.path, nil, :ignore)
     else raise "Unknown file type: #{filepath.path}"
    end
  end
end
