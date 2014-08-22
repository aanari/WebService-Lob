use Test::Modern;

use t::Harness qw(lob);
plan skip_all => 'LOB_API_KEY not in ENV' unless defined lob();

subtest 'Testing get_states' => sub {
    my $states = lob->get_states;
    ok $states,
        "successfully retreived @{[~~@$states]} states"
        or diag explain $states;
};

subtest 'Testing get_countries' => sub {
    my $countries = lob->get_countries;
    ok $countries,
        "successfully retreived @{[~~@$countries]} countries"
        or diag explain $countries;
};

subtest 'Testing verify_address' => sub {
    like exception { lob->verify_address },
        qr/Not enough arguments for method/,
        'failed correctly on missing parameters';

    isa_ok exception { lob->verify_address(
        address_line1   => '370 Townsend St',
        address_city    => 'Boulder',
        address_state   => 'CO',
        address_zip     => '80305',
        address_country => 'US',
    )}, 'WebService::Lob::Exception::AddressNotFound';
    
    isa_ok exception { lob->verify_address(
        address_line1   => '1529 Queen Anne Ave N',
        address_city    => 'Seattle',
        address_state   => 'WA',
        address_zip     => '98109',
        address_country => 'US',
    )}, 'WebService::Lob::Exception::AddressMissingInformation';

    my $address = lob->verify_address(
        address_line1   => '370 Townsend St',
        address_city    => 'San Francisco',
        address_state   => 'CA',
        address_zip     => '94107',
        address_country => 'US',
    );

    cmp_deeply $address => {
            object          => 'address',
            address_line1   => '370 TOWNSEND ST',
            address_line2   => '',
            address_city    => 'SAN FRANCISCO',
            address_state   => 'CA',
            address_zip     => '94107-1607',
            address_country => 'US',
        }, 'successful simple address lookup'
        or diag explain $address;

    $address = lob->verify_address(
        address_line1   => '1109 9th St',
        address_line2   => '#123',
        address_city    => 'Phoenix',
        address_state   => 'AZ',
        address_zip     => '88888',
        address_country => 'US',
    );

    cmp_deeply $address => {
            object          => 'address',
            address_line1   => '1109 N 9TH ST',
            address_line2   => '# 123',
            address_city    => 'PHOENIX',
            address_state   => 'AZ',
            address_zip     => '85006-2734',
            address_country => 'US',
        }, 'successful corrective address lookup'
        or diag explain $address;
};

done_testing;
