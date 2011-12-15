Generates a well-formed and unique URI from an array of strings.

Usage
-----

    Baptist.generate('Arthur Russell')                             => 'Arthur-Russell'
    Baptist.generate('Arthur Russell', :space => '_')              => 'Arthur_Russell'
    Baptist.generate(['Arthur Russell', 'Calling Out of Context']) => 'Arthur-Russell/Calling-Out-of-Context'

Percent encoding
----------------

Baptist will percent encode any character (except the delimiter characters explicitly added by Baptist) that is not an unreserved URI character according to RFC3986.

Uniqueness
----------

To guarantee the generated URI is unique:

    Baptist.generate('Arthur Russell', :multiplier => '*') do |uri|
      Resource.find_by_uri(uri)
    end

Will take the <code>:multiplier</code> character and multiply it for each time
the block returns <code>false</code> and add that to the end of the URI. So if
there were three name collisions when running the code above the resulting
URI would be <code>'Arthur-Russell-\*\*\*'</code>.

The default multiplier is simply the Integer 1, which will result in an
incrementing number being added to the end of the URI.

Options
-------

* <code>:space</code> - Space character (default: '-')
* <code>:separator</code> - Separator character (default: '/')
* <code>:multiplier</code> - The object to multiply with to find a unique URI (default: 1)
* <code>:encoding</code> - Force this encoding (default: 'UTF-8')

Author
------

Baptist was created by Niklas Holmgren (niklas@sutajio.se) and released under
the MIT license.