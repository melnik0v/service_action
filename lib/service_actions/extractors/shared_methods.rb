require_relative '../service_object'

module ServiceActions
  module Extractors
    class SharedMethods < ServiceActions::ServiceObject
      param :controller
      option :shared, Array.method(:wrap), default: -> { [] }, as: :shared

      def call
        shared_method_names.each_with_object({}) do |method_name, array|
          next unless controller.respond_to? method_name

          controller.send(:method_name)
        end
      end

      private

      def shared_method_names
        ServiceActions.config.shared_methods + shared
      end
    end
  end
end
