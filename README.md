# RStub

[![Build Status](https://travis-ci.org/jusjmkim/rstub.svg?branch=master)](https://travis-ci.org/jusjmkim/rstub)
[![Coverage Status](https://coveralls.io/repos/jusjmkim/rstub/badge.svg?branch=master)](https://coveralls.io/r/jusjmkim/rstub?branch=master)

## Install
Run `gem install rstub`

## About
RStub was created for [CIS 196](http://www.seas.upenn.edu/~cis196/) to generate
boilerplate homework for students to fill out. It was inspired from the
[Stubbify](https://github.com/isibner/stubbify) module.

## Usage
Running `rstub homework.rb studentHW` on homework.rb, which has the following
code:
```ruby
def add (a, b)
  # add the two input variables
  # STUB
  a + b
  # ENDSTUB
end
```

Then, the stubs will be removed.
```ruby
def add (a, b)
  # add the two input variables
end
```

Any number of files can be provided, and files can be glob patterns like `*/*.rb`.
The last argument must be the test directory.

RStub preserves the relative paths of the stubbed files, so `./foo/bar.rb` will
be copied and stubbed into `./targetDir/foo/bar.rb`.

```
$ rstub rb/homeworkFile1.rb rb/homeworkFile2.rb rb/util/homeworkUtil.rb student-homework
$ rstub "rb/**/*.rb" student-homework # equivalent with glob pattern
$ tree .
.
├── rb
│   ├── homeworkFile1.rb
│   ├── homeworkFile2.rb
│   └── util
│       └── homeworkUtil.rb
└── student-homework
    └── rb
        ├── homeworkFile1.rb
        ├── homeworkFile2.rb
        └── util
            └── homeworkUtil.rb
```

