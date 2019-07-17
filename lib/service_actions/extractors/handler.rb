require_relative '../service_object'

module ServiceActions
  module Extractors
    class Handler < ServiceActions::ServiceObject
      param :controller
      option :handler, default: -> { ServiceActions.config.default_handler }
      option :action_name, default: -> { controller.action_name }

      def call
        case handler
        when Proc, Class
          handler
        when :service
          extract_service
        end
      end

      private

      def extract_service
        namespace = controller.class.name.sub('Controller', '')
        service_name = "#{namespace}::#{action_name.to_s.camelize}"
        Object.const_get(service_name)
      rescue NameError
        message = <<~TEXT
          Seems like you forgot to define service object for "#{action_name}".
          Make sure that #{service_name} is exists.
        TEXT
        Rails.logger.error message
        raise NameError, message
      end
    end
  end
end
