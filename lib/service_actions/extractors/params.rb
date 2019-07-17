require_relative '../service_object'

module ServiceActions
  module Extractors
    class Params < ServiceActions::ServiceObject
      param :params
      option :permit, Array.method(:wrap), default: -> { [] }, as: :params_to_permit, reader: :private
      option :require, default: -> { [] }, as: :params_to_require, reader: :private

      def call
        return {} if params_to_permit.blank? && params_to_require.blank?

        extracted_params.to_h
      end

      private

      attr_reader :params, :params_to_permit, :params_to_require

      def extracted_params
        required_params.permit(*params_to_permit)
      end

      def required_params
        return params if params_to_require.blank?

        params.require(params_to_require)
      end
    end
  end
end
