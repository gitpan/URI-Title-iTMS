use warnings;
use strict;
use Test::More;
use lib 'lib';
use URI::Title qw(title);

require IO::Socket;
my $s = IO::Socket::INET->new(
  PeerAddr => "apple.com:80",
  Timeout  => 10,
);

if ($s) {
  close($s);
  plan tests => 1;
} else {
  plan skip_all => "no net connection available";
  exit;
}

is(
  title('itms://ax.phobos.apple.com.edgesuite.net/WebObjects/MZStore.woa/wa/viewAlbum?playlistId=13691671'),
  "iTMS / Pop / Faithless / Reverence",
  "got title for faithless / reverence");

