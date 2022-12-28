class Book < Sequel::Model

  STATUSES = {
    finished: 'Finished',
    bookshelf: 'Bookshelf',
    in_progress: 'In Progress',
    want: 'Want'
  }.freeze

  STATUS_TAGS = {
    finished: 'success',
    bookshelf: 'danger',
    in_progress: 'warning',
    want: 'primary'
  }.freeze

  TYPES = {
    fiction: 'Fiction',
    non_fiction: 'Non-fiction'
  }.freeze

end
