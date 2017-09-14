class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items, dependent: :destroy
  has_many :items, through: :line_items
  def total
    amt = 0
    self.line_items.each do |line_item|
      amt += (line_item.item.price * line_item.quantity)
    end
    return amt
  end

  def add_item(item_id)
    line_item = self.line_items.find_by(item_id: item_id)
    if line_item
      line_item.quantity += 1
      line_item
    else
      self.line_items.build(item_id: item_id, quantity: 1)
    end
  end

  def checkout
    self.status = "submitted"
    self.line_items.each do |line_item|
      line_item.item.inventory -= line_item.quantity
      line_item.item.save
    end
    self.save
  end

end
