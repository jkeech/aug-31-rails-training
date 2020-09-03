class UpdateDefaultColorFormatTypeForMovie < ActiveRecord::Migration[6.0]
  def change
    change_column_default :movies, :color_format, from: nil, to: 0
  end
end
