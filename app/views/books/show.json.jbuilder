json.books Book.all do |book|
  json.extract! book, :id, :name, :price, :created_at
end