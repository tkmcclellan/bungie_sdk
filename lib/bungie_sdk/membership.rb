# typed: true
module BungieSdk::Destiny2
  # Represents a Destiny 2 Membership
  class Membership < ApiAgent
    # Membership type
    sig { returns Integer }
    def type
      data['membershipType']
    end

    # Membership id
    sig { returns String }
    def id
      data['membershipId']
    end

    # Profile associated with this membership
    # - `components`: DestinyComponentType to be supplied to this API endpoint.
    sig { params(components: T::Array[T.any(Integer, String)]).returns(Profile) }
    def profile(components: [DestinyComponentType.Profiles])
      Profile.new(run(get(profile_url, params: { components: components.join(',') })).body)
    end

    private
    sig { returns String }
    def profile_url
      "#{destiny_url}/#{type}/Profile/#{id}"
    end
  end
end
