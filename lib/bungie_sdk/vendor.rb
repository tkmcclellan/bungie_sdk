# typed: true

module BungieSdk::Destiny2
  # Represents vendors in Destiny 2
  class Vendor < ApiAgent
    # Signifies if the definition request has failed
    sig { returns T::Boolean }
    attr_reader :failed_definition

    # Vendor id
    sig { returns Integer }
    def id
      data['vendorData']['vendorHash']
    end

    # Vendor name
    sig { returns String }
    def name
      definition['displayProperties']['name'] rescue ''
    end

    # Vendor sales
    sig { returns T::Array[Hash] }
    def sales
      data['sales']['saleItems'].values
    end

    # Request for vendor's definition
    sig { returns Typhoeus::Request }
    def definition_request
      request = vendor_definition(data['vendorData']['vendorHash'])
      request.on_success do |response|
        response           = process_response(response)
        data['definition'] = response.body
      end

      request.on_failure {|_| @failed_definition = true }

      request
    end

    # Vendor definition
    sig { returns Hash }
    def definition
      return {} if @failed_definition

      if data['definition'].nil?
        definition_request.run
      end

      data['definition']
    end

    # Vendor items
    sig { returns T::Array[Item] }
    def items
      sales.map {|sale| Item.new(sale) }
    end
  end
end
