require 'httparty'
require 'Pry'

class FastSpringRequest
  def self.run(username, password, limit)
    new(username, password, limit).run
  end

  def run
    populate_orders

    doublecheck_orders

    binding.pry
  end

  def initialize(username, password, limit = 1000 )
    @username = username
    @password = password
    initial_request ||= set_baseline
    @total_orders = initial_request["total"]
    @limit = limit
    @pages_arr = Array(1..(@total_orders.to_f / @limit).ceil)
    @orders = []
  end

  private

  def doublecheck_orders
    if @orders.count != @total_orders
      populate_orders
      @orders.uniq
      doublecheck_orders
    end
  end

  def populate_orders
    @pages_arr.each do |page|
      @orders = @orders | fastspring_request(@limit, page)["orders"]
    end
  end

  def set_baseline
    fastspring_request
  end

  def fastspring_request(limit = 50, page = 1)
    conn({username: @username, password: @password }, limit, page)
  end

  def conn(auth, limit, page)
    HTTParty.get(
      "https://api.fastspring.com/orders?limit=#{limit}&page=#{page}",
      basic_auth: auth
    )
  end
end
