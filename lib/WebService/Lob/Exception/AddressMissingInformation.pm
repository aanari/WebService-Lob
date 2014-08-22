package WebService::Lob::Exception::AddressMissingInformation;
use Moo;
extends 'Throwable::Error';

has '+message' => ( default => 'The address you entered was found but more information is needed to match to a specific address.' );

1;
