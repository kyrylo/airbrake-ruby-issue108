# Be sure to restart your server when you modify this file.

module FilteredParameters
  def self.model_sensitive_attributes
    @@RAILS_FILTER_PARAMS ||=
      begin
        attr = []
        attr << :password << :headers << :httpMethod << :baz
                           # ^^ filtered ^^
      end
  end
end

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.filter_parameters += [:password]

Rails.application.config.filter_parameters << proc do |k,v| # <------------ PROC
  Rails.application.eager_load!
  if FilteredParameters.model_sensitive_attributes.include?(k.to_s)
    v.sub!(/.*/,"[Filtered]")
  end
  FilteredParameters.model_sensitive_attributes # <----------- NEW
end
