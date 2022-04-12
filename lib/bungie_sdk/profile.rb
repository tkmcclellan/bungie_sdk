# typed: true
module BungieSdk::Destiny2
  # Represents a Destiny2 profile
  class Profile < ApiAgent
    # Returns the characters associated with this profile.
    # - `components`: DestinyComponentType to be supplied to this API endpoint.
    sig do
      params(components: T::Array[T.any(Integer, String)])
        .returns(T::Array[Character])
    end
    def characters(components: [DestinyComponentType.Characters])
      characters = run(get(profile_url, params: { components: components.join(',') })).body
      characters['characters']['data'].map do |_, character|
        Character.new(character)
      end
    end

    # Profile's membership id
    sig { returns String }
    def membership_id
      data['profile']['data']['userInfo']['membershipId']
    end

    # Profile's membership type
    sig { returns Integer }
    def membership_type
      data['profile']['data']['userInfo']['membershipType']
    end

    private
    sig { returns String }
    def profile_url
      "#{destiny_url}/#{membership_type}/Profile/#{membership_id}"
    end
  end
end
