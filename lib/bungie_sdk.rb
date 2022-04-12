# typed: true
require 'bungie_sdk/version'
Bundler.require(:default, :development)

# Module for all things Bungie SDK
module BungieSdk
  require 'launchy'
  require 'oauth2'
  require 'typhoeus'
  require 'sorbet-runtime'

  # Represents Bungie's Membership Types
  class BungieMembershipType
    class << self
      def none;        0;   end
      def xbox;        1;   end
      def playstation; 2;   end
      def steam;       3;   end
      def blizzard;    4;   end
      def stadia;      5;   end
      def demon;       10;  end
      def bungie;      254; end
    end
  end.freeze

  module Destiny2
    include BungieSdk

    # List of weapon names in Destiny 2
    WEAPON_TYPES = [
      'Hand Cannon',
      'Grenade Launcher',
      'Shotgun',
      'Sidearm',
      'Scout Rifle',
      'Pulse Rifle',
      'Sword',
      'Machine Gun',
      'Sniper Rifle',
      'Submachine Gun',
      'Linear Fusion Rifle',
      'Auto Rifle',
      'Combat Bow',
      'Fusion Rifle',
      'Rocket Launcher',
      'Trace Rifle',
      'Glaive'
    ].freeze

    # Represents Bungie's DestinyComponentType enum.
    class DestinyComponentType
      class << self
        # rubocop:disable Naming/MethodName
        def None;                 0;    end
        def Profiles;             100;  end
        def VendorReceipts;       101;  end
        def ProfileInventories;   102;  end
        def ProfileCurrencies;    103;  end
        def ProfileProgression;   104;  end
        def PlatformSilver;       105;  end
        def Characters;           200;  end
        def CharacterInventories; 201;  end
        def CharacterProgression; 202;  end
        def CharacterRenderData;  203;  end
        def CharacterActivities;  204;  end
        def CharacterEquipment;   205;  end
        def ItemInstances;        300;  end
        def ItemObjectives;       301;  end
        def ItemPerks;            302;  end
        def ItemRenderData;       303;  end
        def ItemStats;            304;  end
        def ItemSockets;          305;  end
        def ItemTalentGrids;      306;  end
        def ItemCommonData;       307;  end
        def ItemPlugStates;       308;  end
        def ItemPlugObjectives;   309;  end
        def ItemReusablePlugs;    310;  end
        def Vendors;              400;  end
        def VendorCategories;     401;  end
        def VendorSales;          402;  end
        def Kiosks;               500;  end
        def CurrencyLookups;      600;  end
        def PresentationNodes;    700;  end
        def Collectibles;         800;  end
        def Records;              900;  end
        def Transitory;           1000; end
        def Metrics;              1100; end
        def StringVariables;      1200; end
        def Craftables;           1300; end

        # rubocop:enable Naming/MethodName
      end
    end.freeze
  end

  require 'bungie_sdk/agent'
  require 'bungie_sdk/character'
  require 'bungie_sdk/client'
  require 'bungie_sdk/item'
  require 'bungie_sdk/membership'
  require 'bungie_sdk/profile'
  require 'bungie_sdk/token_manager'
  require 'bungie_sdk/vendor'
end
