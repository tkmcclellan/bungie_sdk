# typed: true

module BungieSdk::Destiny2
  # Represents Destiny 2 items
  class Item < ApiAgent
    # Returns `Typhoeus::Request` for this item's definition.
    sig { returns Typhoeus::Request }
    def definition_request
      request = item_definition(id)
      request.on_success do |response|
        response           = process_response(response)
        data['definition'] = response.body
      end

      request
    end

    # This item's definition.
    sig { returns Hash }
    def definition
      if data['definition'].nil?
        definition_request.run
      end

      data['definition']
    end

    # Item costs.
    sig { returns T::Array[Hash] }
    def costs
      data['costs']
    end

    # Item hash
    sig { returns Integer }
    def id
      data['itemHash']
    end

    # Item name
    sig { returns String }
    def name
      definition['displayProperties']['name']
    end

    # Item type
    sig { returns String }
    def type
      definition['itemTypeDisplayName']
    end

    # Item type and tier
    sig { returns String }
    def type_and_tier
      definition['itemTypeAndTierDisplayName']
    end

    # Tests if this item is an instance item.
    sig { returns T::Boolean }
    def instance_item?
      definition['inventory']['isInstanceItem']
    end

    # This item's sockets.
    sig { returns T::Array[Hash] }
    def sockets
      item_sockets = definition['sockets']
      item_sockets.nil? ? [] : item_sockets['socketEntries']
    end

    # A list of the ids for this item's sockets.
    sig { returns T::Array[String] }
    def socket_ids
      return [] if sockets.empty?

      ids = sockets.map do |socket|
        [socket['singleInitialItemHash'], socket['reusablePlugItems'].map {|s| s['plugItemHash'] }]
      end

      ids.flatten.uniq.map(&:to_s)
    end
  end
end
