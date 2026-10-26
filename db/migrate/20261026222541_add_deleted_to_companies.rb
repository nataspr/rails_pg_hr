class AddDeletedToCompanies < ActiveRecord::Migration[7.1]
  def change
    #  колонка deleted со значением по умолчанию false
    add_column :companies, :deleted, :boolean, default: false
  end
end
