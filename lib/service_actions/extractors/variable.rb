require_relative '../service_object'

module ServiceActions
  module Extractors
    class Variable < ServiceActions::ServiceObject
      param :controller
      option :variable, optional: true

      def call
        case variable
        when String, Symbol
          instance_by_method_name
        when Class
          instance_by_class_and_id
        when Proc
          variable.call
        end
      end

      private

      def instance_by_method_name
        return unless controller.respond_to?(variable, true)

        controller.send(variable)
      end

      def instance_by_class_and_id
        variable.find(controller.params[:id])
      end
    end
  end
end
