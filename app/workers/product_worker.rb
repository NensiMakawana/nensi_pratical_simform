class ProductWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  require 'csv'
  def perform(filepath)
    if File.exist?(filepath)
      CSV.foreach(filepath, headers: true) do |product_row|
        Product.create(product_row.to_h)
      end
      File.delete(filepath)
    end
  end
end