class ChangeColumnToRest < ActiveRecord::Migration[5.1]
  # 変更内容
  def up
    change_column :rests, :id, :string
  end

  # 変更前の状態
  def down
    change_column :users, :id, :integer
  end
end
