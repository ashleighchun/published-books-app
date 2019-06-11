require './config/environment'

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride #allows us to use patch and delete
use ReadersController
use BooksController
use PublishersController #synonym for use is 'mount' it mounts the controller
run ApplicationController
