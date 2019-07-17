require_relative 'service_object'

class ServiceActions::Action < ServiceActions::ServiceObject
  param :params, proc(&:presence)
  param :shared_methods, proc(&:presence)
  param :variable, proc(&:presence)
  param :handler

  def call
    handler.new(*handler_args).call
  end

  private

  def proc?
    handler.is_a? Proc
  end

  def handler_args
    return [variable] if proc?

    [variable, { shared: shared_methods, params: params }.compact].compact
  end
end
