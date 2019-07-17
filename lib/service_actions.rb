require_relative 'service_actions/base'

module ServiceActions
  @config = ::OpenStruct.new(default_handler: :service, shared_methods: [])

  class << self
    def configure
      yield @config
    end

    def config
      @config
    end
  end
end
