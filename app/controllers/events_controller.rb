class EventsController < ApplicationController
  def index
    gateway = Braintree::Gateway.new(
        :environment => :sandbox,
        :merchant_id => "pxjc4kcw3q9rsy96",
        :public_key => "79hktr396d87sdmc",
        :private_key => "5c5a9d7d3042103f43b3a13fbbb8ba65",
    )

    # @client_token = gateway.client_token.generate(:customer_id => 1)
    @client_token = gateway.client_token.generate
  end

  def client_token
    gateway = Braintree::Gateway.new(
        :environment => :sandbox,
        :merchant_id => "pxjc4kcw3q9rsy96",
        :public_key => "79hktr396d87sdmc",
        :private_key => "5c5a9d7d3042103f43b3a13fbbb8ba65",
        )

    nonce_from_the_client =  params[:payment_method_nonce]

    result = gateway.transaction.sale(
        :amount => "400.00",
        :payment_method_nonce => nonce_from_the_client,
        :options => {
            :submit_for_settlement => true
        }
    )
    render :json => result
    if result.success?
      puts "success!: #{result.transaction.id}"
    elsif result.transaction
      puts "Error processing transaction:"
      puts "  code: #{result.transaction.processor_response_code}"
      puts "  text: #{result.transaction.processor_response_text}"
    else
      p result.errors
    end
  end
end