# sixer

Unofficial Ruby gem for [Cloud66 API](https://developers.cloud66.com/#introduction)

# Installation

Add sixer to your Gemfile

```
gem 'sixer'
```

And bundle install

```
bundle install
```

# Usage

```ruby
# A Cloud 66 Personal Access Token can be obtained here https://app.cloud66.com/oauth/authorized_applications
personal_access_token = ENV['CLOUD66_PERSONAL_ACCESS_TOKEN']

# Retrieve stacks
sixer = Sixer.new(personal_access_token)
stacks = sixer.stacks

# Print a stack's environment variables
acme_stack = stacks.all.detect { |stack| stack.name == "Acme" }.environment_variable
acme_stack.environment_variables.each_in_all_pages do |env_var|
  key, value = env_var.properties.values_at("key", "value")
  puts "#{key}=#{value}
end
```

# Todos

- Port rspecs here
- Modify sixer to obtain the personal access token the from the `CLOUD66_PERSONAL_ACCESS_TOKEN` environment variable if the environment variable is set
- Add support for more Cloud 66 API resources
- Add ability to update a resource's properties
- Add ability to create a resource
