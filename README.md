# Code Citations

Finding citations of open scientific software. Currently works for R packages, using the PLoS and Europe PMC sources.

## Installation

Add this line to your application's Gemfile:

    gem 'code_citations'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install code_citations

## Usage

```
require 'code_citations'
=> true

CodeCitations.for('ggplot2')
=> ["10.1542/peds.2012-2182",
 "10.1371/journal.pone.0059624",
 "10.1080/87565641.2011.614979",
 "10.1186/1471-2105-11-45",
 "10.1186/1471-2350-11-9",
 "10.1111/j.1360-0443.2009.02574.x",
 "10.1371/journal.pgen.1000928",
 "10.1289/ehp.0800376",
 "10.1242/dev.030866"]

CodeCitations.for('marmap')
=> ["10.1371/journal.pone.0073051"]

CodeCitations.for('raster')
=> ["10.1371/journal.pone.0073051",
 "10.1371/journal.pone.0074918",
 "10.1371/journal.pntd.0002327",
 "10.1371/journal.pone.0012060",
 "10.1371/journal.pone.0085555",
 "10.1371/journal.pone.0070260",
 "10.1371/journal.pone.0049230",
 "10.1371/journal.pone.0043627",
 "10.1371/journal.pone.0035954",
 "10.1371/journal.pone.0075363",
 "10.1371/journal.pone.0080563"]
```

## Contributing

1. Fork it ( http://github.com/ScienceToolbox/code_citations/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
