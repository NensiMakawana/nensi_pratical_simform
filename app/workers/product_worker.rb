class ProductWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  require 'csv'
  def perform(filepath)
    CSV.foreach(filepath, headers: true) do |product|
      Product.create(
        name: product[0],
        price: product[1],
        description: product[2])
    end
  end
end