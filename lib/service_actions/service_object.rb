require 'dry-initializer'

class ServiceActions::ServiceObject
  extend Dry::Initializer

  class << self
    def call(*args, &block)
      instance = new(*args)
      instance.call(&block)
    end

    def new(*args)
      args << args.pop.symbolize_keys if __keys_valid?(args)
      super(*args)
    end

    def dry_definitions
      dry_initializer.definitions
    end

    private

    def __keys_valid?(args)
      last_arg = args.last
      last_arg.is_a?(Hash) &&
        last_arg.keys.all? { |key| key.to_sym.in?(dry_definitions.keys) }
    end
  end

  protected

  def dry_options
    __extract_definition_value do
      self.class.dry_definitions.select { |_, definition| definition.option }.keys
    end
  end

  def dry_params
    __extract_definition_value do
      self.class.dry_definitions.reject { |_, definition| definition.option }.keys
    end
  end

  private

  def __extract_definition_value
    return {} unless block_given?

    yield.map { |name| [name, method(name).call] }.to_h
  end
end
