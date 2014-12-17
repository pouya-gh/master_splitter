# MasterSplitter

A simple file splitter and joiner.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'master_splitter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install master_splitter

## Usage

You can use executables 'master_join' and 'master_split'. 
For more imformation just use them with a -h flag.
You can also include it as a library and use it's methods 
directly, like this:

```ruby
include MasterSplitter

standard_split("path/to/file.pdf", 5)
# splits the file to 5 slices.

standard_join("path/to/slice.pdf.001")
```


## Contributing

The best way you can contribute now is to teach me a way
to write specs for file interactions. Or you can help as the following:

1. Fork it ( https://github.com/psparabara/master_splitter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
