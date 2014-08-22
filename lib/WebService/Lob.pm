package WebService::Lob;
use Moo;
with 'WebService::BaseClientRole';

use aliased;
my $exc = prefix('WebService::Lob::Exception');

use Function::Parameters ':strict';

has '+base_url'   => ( default => 'https://api.lob.com/v1' );
has api_key       => ( is => 'ro', required => 1           );
has states_uri    => ( is => 'ro', default => '/states'    );
has countries_uri => ( is => 'ro', default => '/countries' );
has verify_uri    => ( is => 'ro', default => '/verify'    );

method BUILD {
    $self->ua->credentials('api.lob.com:443', '', $self->api_key, '');
}

method get_states {
    my $result = $self->get($self->states_uri);
    return $result->{data} if $result;
}

method get_countries {
    my $result = $self->get($self->countries_uri);
    return $result->{data} if $result;
}

method verify_address(
    Str :$address_line1,
    Str :$address_line2 = '',
    Str :$address_city,
    Str :$address_state,
    Str :$address_zip,
    Str :$address_country
) {
    my $result = $self->post($self->verify_uri, {
        address_line1   => $address_line1,
        address_line2   => $address_line2,
        address_city    => $address_city,
        address_state   => $address_state,
        address_zip     => $address_zip,
        address_country => $address_country,
    });

    $exc->('AddressNotFound')->throw unless $result;
    $exc->('AddressMissingInformation')->throw(message => $result->{message})
        if $result->{message};
    return $result->{address};
}

1;
