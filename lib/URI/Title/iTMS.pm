=head1 NAME

URI::Title::iTMS - Get titles from itms:// urls

=head1 DESCRIPTION

An add-on to L<URI::Title>, this module adds support for itms:// urls..

=head1 AUTHOR

Tom Insam <tom@jerakeen.org>

=cut

package URI::Title::iTMS;

our $VERSION = '0.4';

use warnings;
use strict;

use Net::iTMS;

sub types {(
  'itms',
)}

sub title {
  my ($self, $uri, $data, $type) = @_;
  $uri =~ s/^itms/http/;
  
  my $info = Net::iTMS->new->fetch_iTMS_info( $uri )
    or return "iTMS / Not an iTMS url";

  my $title =
    eval { "iTMS / " . join(" / ", map { $_->{name} } @{ $info->Path } ) }
    || "iTMS / Error getting title from $uri: $@";

            
  return $title;
}

1;
