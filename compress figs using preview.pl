use strict;

use IO::All;

my $indir = '/_no_backup_/super_project';
my $outdir = '/_no_backup_/super_project/arxiv_v1b';

my $count = 0;
for my $file (grep {"$_" !~ /super_lattice_models/} grep {"$_" =~ /\.pdf$/} @{io('.')}) {
	#last if ($count++ > 10);
	my ($fname) = "$file" =~ m{/([^/]*$)};
	next if (-e "$outdir/$fname");
	print "$fname...\n";
	my $as = <<EE;
tell application "Preview"
	activate
	open POSIX file "$indir/$fname"
	delay 0.3
	tell application "System Events" to keystroke "s" using {command down, shift down}
	delay 0.3
	save front document in POSIX file "$outdir/$fname"
	-- delay 0.3
	close front document
	-- delay 0.3
	close front document
end tell
EE

	open OSAS, "| osascript"
		or die "can't fork: $!";
	local $SIG{PIPE} = sub { die "osas pipe broke" };
	print OSAS $as;
	close OSAS or die "bad spool: $! $?";

	#sleep 1;
}

__END__


tell application "Preview"
	activate
	open POSIX file "/Users/kw/Desktop/temp2/VertexTypes.pdf"
	delay 0.3
	tell application "System Events" to keystroke "s" using {command down, shift down}
	delay 0.3
	save front document in POSIX file "/Users/kw/Desktop/VertexTypes.pdf"
	delay 0.3
	close front document
	delay 0.3
	close front document
end tell
