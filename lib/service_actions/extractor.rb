require_relative 'service_object'
require_relative 'action'
require_relative 'extractors/params'
require_relative 'extractors/shared_methods'
require_relative 'extractors/variable'
require_relative 'extractors/handler'

class ServiceActions::Extractor < ServiceActions::ServiceObject
  param :controller, reader: :private
  param :action_name, reader: :private
  param :settings, reader: :private

  def call
    ServiceActions::Action.new(params, shared_methods, variable, handler)
  end

  private

  def params
    ServiceActions::Extractors::Params.call(controller.params, settings)
  end

  def shared_methods
    ServiceActions::Extractors::SharedMethods.call(controller, settings)
  end

  def variable
    ServiceActions::Extractors::Variable.call(controller, settings)
  end

  def handler
    ServiceActions::Extractors::Handler.call(controller, settings)
  end
end
