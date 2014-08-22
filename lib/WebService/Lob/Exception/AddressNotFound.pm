package WebService::Lob::Exception::AddressNotFound;
use Moo;
extends 'Throwable::Error';

has '+message' => ( default => 'Address Not Found.' );

1;
