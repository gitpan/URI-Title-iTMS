=head1 NAME

URI::Title::iTMS - Get titles from itms:// urls

=head1 DESCRIPTION

An add-on to L<URI::Title>, this module adds support for itms:// urls..

=head1 AUTHOR

Tom Insam <tom@jerakeen.org>

=cut

package URI::Title::iTMS;

our $VERSION = '0.5';

use warnings;
use strict;

use Net::iTMS;

sub types {(
  'itms',
)}

sub title {
  my ($self, $uri, $data, $type) = @_;
  $uri =~ s/^itms/http/;


  my $title;

  # check to see what version of Net::iTMS we have
  eval { require Net::iTMS::Request };

  # we must have the old version
  if ($@ ) {

    my $info = Net::iTMS->new->fetch_iTMS_info( $uri )
    or return "iTMS / Not an iTMS url";

    $title =
    eval { "iTMS / " . join(" / ", map { $_->{name} } @{ $info->Path } ) }
    || "iTMS / Error getting title";

  # it's the new version with the completely changed API
  } else {  

    my $r =  Net::iTMS::Request->new( debug => 0,  show_xml => 1  );
    my $info = $r->url($uri);
    my $path = $info->root->first_child('Path');
    $title =
        eval { "iTMS / " . join(" / ", map { $_->att('displayName') } $path->children('PathElement') ) }
        || "iTMS / Error getting title from $uri: $@";
  }
            
  return $title;
}

1;
