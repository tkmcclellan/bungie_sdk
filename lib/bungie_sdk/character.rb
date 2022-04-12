# typed: true

module BungieSdk::Destiny2
  # Class representing characters in Destiny 2
  class Character < ApiAgent

    # Character hash
    sig { returns String }
    def id
      data['characterId']
    end

    # Destiny2 Membership Type
    sig { returns Integer }
    def membership_type
      data['membershipType']
    end

    # Destiny2 Membership Id
    sig { returns String }
    def membership_id
      data['membershipId']
    end

    # Returns `Vendor`s associated with this character.
    # - `can_purchase`: filters for vendors with purchasable items.
    # - `enabled`: filters for vendors that are enabled.
    # - `components`: a list of components to be returned with this API request.
    # The result of this request is memoized, so a new `Character` object will need to
    # be created to retrieve new results.
    sig do
      params(can_purchase: T::Boolean,
             enabled:      T::Boolean,
             components:   T::Array[T.any(Integer, String)])
        .returns(T::Array[Vendor])
    end
    def vendors(can_purchase: true,
                enabled:      true,
                components:   [DestinyComponentType.Vendors, DestinyComponentType.VendorSales])
      return @vendors unless @vendors.nil?

      vendor_data = run(get("#{character_url}/Vendors",
                            params: { components: components.join(',') })).body

      vendor_ids = [vendor_data['vendors']['data'].keys, vendor_data['sales']['data'].keys]
        .flatten
        .uniq

      vendor_hashes = vendor_ids.map do |id|
        {
          'vendorData' => vendor_data['vendors']['data'][id],
          'sales'      => vendor_data['sales']['data'][id]
        }
      end.select do |vendor|
        if vendor['vendorData'].nil?
          false
        else
          vendor['vendorData']['canPurchase'] == can_purchase &&
            vendor['vendorData']['enabled'] == enabled
        end
      end

      hydra    = Typhoeus::Hydra.new
      response = vendor_hashes.map do |hash|
        vendor = Vendor.new(hash)
        hydra.queue vendor.definition_request

        vendor
      end

      hydra.run

      @vendors = response
    end

    private
    sig { returns String }
    def character_url
      "#{destiny_url}/#{membership_type}/Profile/#{membership_id}/Character/#{id}"
    end
  end
end
