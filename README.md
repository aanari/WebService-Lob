# NAME

WebService::Lob

# VERSION

version 0.0104

# SYNOPSIS

    use WebService::Lob;

    my $lob = WebService::Lob->new( api_key => 'abc123' );

    $lob->get_countries();

# DESCRIPTION

This module provides bindings for the
[Lob](https://www.lob.com/docs) API.

# METHODS

## new

Instantiates a new WebService::Lob client object.

    my $lob = WebService::Lob->new(
        api_key  => $api_key,
        base_url => $domain,     # optional
        timeout  => $retries,    # optional
        retries  => $retries,    # optional
    );

__Parameters__

- \- `api_key`

    _Required_&#10; &#8;

    A valid Lob api key for your account.

- \- `base_url`

    _Optional_&#10; &#8;

    The Lob base url to make API calls against.  Defaults to [https://api.lob.com](https://api.lob.com).

- \- `timeout`

    _Optional_&#10; &#8;

    The number of seconds to wait per request until timing out.  Defaults to `10`.

- \- `retries`

    _Optional_&#10; &#8;

    The number of times to retry requests in cases when Lob returns a 5xx response.  Defaults to `0`.

## get\_states

Returns a list of all US states.

__Request:__

    get_states();

__Response:__

    [{
        name       => 'Alabama',
        short_name => 'AL',
        object     => 'state',
    },
    {
        name       => 'Alaska',
        short_name => 'AK',
        object     => 'state',
    },
    ...
    {
        name       => 'Wisconsin',
        short_name => 'WI',
        object     => 'state',
    },
    {
        name       => 'Wyoming',
        short_name => 'WY',
        object     => 'state',
    }]

## get\_countries

Returns a list of all currently supported countries.

__Request:__

    get_countries();

__Response:__

    [{
        name       => 'United States',
        short_name => 'US',
        object     => 'country',
    },
    {
        name       => 'Afghanistan',
        short_name => 'AF',
        object     => 'country',
    },
    ...
    {
        name       => 'Zambia',
        short_name => 'ZM',
        object     => 'country',
    },
    {
        name       => 'Zimbabwe',
        short_name => 'ZW',
        object     => 'country',
    }]

## verify\_address

Validates an address given.

__Request:__

    verify_address(
        address_line1   => '370 Townsend St',
        address_city    => 'San Francisco',
        address_state   => 'CA',
        address_zip     => '94107',
        address_country => 'US',
    );

__Response:__

    {
        object          => 'address',
        address_line1   => '370 TOWNSEND ST',
        address_line2   => '',
        address_city    => 'SAN FRANCISCO',
        address_state   => 'CA',
        address_zip     => '94107-1607',
        address_country => 'US',
    }

__Exceptions:__

- \- `WebService::Lob::Exception::AddressNotFound`

    Address Not Found.

- \- `WebService::Lob::Exception::AddressMissingInformation`

    The address you entered was found but more information is needed to match to a specific address.

# AUTHOR

Ali Anari <ali@anari.me>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Ali Anari.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
