package t::lib::Harness;

use Exporter 'import';
use Memoize;
use WebService::Lob;

memoize 'lob';
sub lob {
    my $api_key = $ENV{LOB_API_KEY};
    WebService::Lob->new(api_key => $api_key) if $api_key;
}

@EXPORT_OK = qw(lob);

1;
