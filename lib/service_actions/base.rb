require_relative 'extractor'

module ServiceActions::Base
  module ClassMethods
    def service_action(action_name, action_parameters = {})
      attr_reader :service_action

      before_action only: action_name do |controller|
        @service_action = ServiceActions::Extractor.call(controller, action_name, action_parameters)
      end

      define_method action_name do
        render_response do
          service_action.call
        end
      end
    end
  end

  module InstanceMethods
    def render_response
      render json: { data: yield }, status: :ok
    rescue StandardError => e
      render json: { errors: e.message }, status: :internal_server_error
    end
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end
