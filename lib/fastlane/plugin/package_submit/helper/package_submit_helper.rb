require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class PackageSubmitHelper
      # class methods that you define here become available in your action
      # as `Helper::PackageSubmitHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the package_submit plugin helper!")
      end
    end
  end
end
