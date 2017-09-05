use strict;

use IO::All;

my $dir = '/_no_backup_/super_project/unused_figs';

my %seen;
for my $line (@{io('super_lattice_models_draft.pdf')}) {
	if ($line =~ m{/PTEX\.FileName \(\./(.*?\.pdf)\)}i) {
		++$seen{$1};
		print "seen: $1\n";
	}
	elsif ($line =~ m{\%\%Title: \(([^%()]*?\.pdf)\)}i) {
		++$seen{$1};
		print "   seen: $1\n";
	}
}

for my $file (grep {"$_" =~ m{/([^/]*\.pdf)}; !$seen{$1}} grep {"$_" =~ /\.pdf$/} @{io('.')}) {
	print "* moving: $file\n";
	system("git mv $file $dir");
}

__END__


