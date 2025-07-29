Return-Path: <linux-kernel+bounces-749451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB65AB14E8E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8CB61896002
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8952819CD17;
	Tue, 29 Jul 2025 13:41:18 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F52288CC
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753796478; cv=none; b=S8AJ7tKGK9B87N4/lllz412/0Vd92KyQR24ROlSoxZ+g498EQucXbxZEaLNu5IS4JOWI/prMe4nccKNQxb5BYcarkVBiY84O9Ght4nJ1MRshTeFBHWV7Jlnh35QpPn1it500A0HCmdnHkXZJ7tmpJ8At51H2Ug1sgkI96QOQ9j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753796478; c=relaxed/simple;
	bh=v6LYpD593a2s5Gz5W9U8KvEET6dykYzuqCoN2dRe59Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=slpuffpmeyKcG5SwSpM4UT+xTm1k18w6kwi9oH6ACG0WRoLdMi3F6tDQZXF57qaGAAeJcbOFrOqabWLq5CtCsQS3Zowz2C6sFDKJmqeuboBjsJkydOwvj+UltjBQDiSH9ohRVTggN99/qS5U4K8DjfWp54Htod4d1IRFS9T5uv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id EB7FE59F6B;
	Tue, 29 Jul 2025 13:41:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 648DA20013;
	Tue, 29 Jul 2025 13:41:05 +0000 (UTC)
Date: Tue, 29 Jul 2025 09:41:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, John 'Warthog9' Hawley
 <warthog9@kernel.org>, Dhaval Giani <dhaval.giani@gmail.com>
Subject: [GIT PULL] ktest.pl: Updates for v6.17
Message-ID: <20250729094119.575dd6de@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: d9g9s96sgstu58f7dy1xy95cod4144w6
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 648DA20013
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/uCIDuxpeU/YwGAKESnOltDLnaHR5654E=
X-HE-Tag: 1753796465-745967
X-HE-Meta: U2FsdGVkX1+LVRlfGuJVdmKO35KFQmJyJpbVJN16X96N8c1duGsrQ74Ij8yEaIug4lz10N1LlA8L52pCLQLxqVvR2PE3dcKiJ1z9Bv8Qx3IsHgAPOKoH/IPyAOGoXf89Sk3fDPVcrzRa9eKoXbNSukZKG4PI/qAVgViuiiTUMo7iqdG4KgLWCvGAKzpmLHkNauSREm0W98ldhd+AXEzfER+TDcuv415bUXLwls6utqzvv1CsXETq+gH8/OEIdExrEMT4ZKiuVkGtL7NZcMSxSrflCxM3jq6JV5gPbZ4oDcZDTvbsTq2FBfN3XpQV6VQpaYk/btSiOApoWha/sMwsg8/Agc+5UEiCtaXN85b3lxjKAOZXFufk/w==



Linus,

ktest updates for v6.17

- Add new -D option that allows to override variables and options

  For example:

    ./ktest.pl -DPATCH_START:=HEAD~1 -DOUTPUT_DIR=/work/build/urgent config

  The above sets the variable "PATCH_START" to HEAD~1 and the OUTPUT_DIR
  option to "/work/build/urgent".

  This is useful because currently the only way to make a slight change to a
  config file is by modifying that config file. For one time changes, this
  can be annoying. Having a way to do a one time override from the command
  line simplifies the workflow.

  Temp variables (PATCH_START) will override every temp variable in the
  config file,  whereas options will act like a normal OVERRIDE option and
  will only affect the session they define.

     -DBUILD_OUTPUT=/work/git/linux.git

  Replaces the default BUILD_OUTPUT option.

     '-DBUILD_OUTPUT[2]=/work/git/linux.git'

  Only replaces the BUILD_OUTPUT variable for test #2.

- If an option contains itself, just drop it instead of going into an
  infinite loop and failing to parse (it doesn't crash, it detects the
  recursion after 100 iterations anyway).

  Some configs may define a variable with the same name as the option:

     ADD_CONFIG := $(ADD_CONFIG)

  But if the option doesn't exist, it the above will fail to parse. In these
  cases, just ignore evaluating the option inside the definition of another
  option if it has the same name.

- Display the BUILD_DIR and OUTPUT_DIR options at the start of every test

  It is useful to know which kernel source and what destination a test is
  using when it starts, in case a mistake is made. This makes it easier to
  abort the test if the wrong source or destination is being used instead of
  waiting until the test completes.

- Add new PATCHCHECK_SKIP option

  When testing a series of commits that also includes changes to the Linux
  tools directory, it is useless to test the changes in tools as they may
  not affect the kernel itself. Doing tests on the kernel for changes that
  do not affect the kernel is a waste of time.

  Add a PATCHCHECK_SKIP that takes a series of shas that will be skipped
  while doing the individual commit tests.


Please pull the latest ktest-v6.17 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
ktest-v6.17

Tag SHA1: a186966a350781466d86f07ed7385058ab8a0a8c
Head SHA1: a5e71638ddd7f1dc0b9f3a5ac8ab8bef48b9f0ee


Steven Rostedt (6):
      ktest.pl: Add -D option to override options
      ktest.pl: Allow command option -D to override temp variables
      ktest.pl: Have -D option work without a space
      ktest.pl: Prevent recursion of default variable options
      ktest.pl: Always display BUILD_DIR and OUTPUT_DIR at the start of tests
      ktest.pl: Add new PATCHCHECK_SKIP option to skip testing individual commits

----
 tools/testing/ktest/ktest.pl    | 116 ++++++++++++++++++++++++++++++++++++++--
 tools/testing/ktest/sample.conf |   2 +
 2 files changed, 115 insertions(+), 3 deletions(-)
---------------------------
diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index a5f7fdd0c1fb..001c4df9f7df 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -21,6 +21,8 @@ my %opt;
 my %repeat_tests;
 my %repeats;
 my %evals;
+my @command_vars;
+my %command_tmp_vars;
 
 #default opts
 my %default = (
@@ -216,6 +218,7 @@ my $patchcheck_type;
 my $patchcheck_start;
 my $patchcheck_cherry;
 my $patchcheck_end;
+my $patchcheck_skip;
 
 my $build_time;
 my $install_time;
@@ -380,6 +383,7 @@ my %option_map = (
     "PATCHCHECK_START"		=> \$patchcheck_start,
     "PATCHCHECK_CHERRY"		=> \$patchcheck_cherry,
     "PATCHCHECK_END"		=> \$patchcheck_end,
+    "PATCHCHECK_SKIP"		=> \$patchcheck_skip,
 );
 
 # Options may be used by other options, record them.
@@ -900,14 +904,22 @@ sub set_eval {
 }
 
 sub set_variable {
-    my ($lvalue, $rvalue) = @_;
+    my ($lvalue, $rvalue, $command) = @_;
 
+    # Command line variables override all others
+    if (defined($command_tmp_vars{$lvalue})) {
+	return;
+    }
     if ($rvalue =~ /^\s*$/) {
 	delete $variable{$lvalue};
     } else {
 	$rvalue = process_variables($rvalue);
 	$variable{$lvalue} = $rvalue;
     }
+
+    if (defined($command)) {
+	$command_tmp_vars{$lvalue} = 1;
+    }
 }
 
 sub process_compare {
@@ -1286,6 +1298,19 @@ sub read_config {
 
     $test_case = __read_config $config, \$test_num;
 
+    foreach my $val (@command_vars) {
+	chomp $val;
+	my %command_overrides;
+	if ($val =~ m/^\s*([A-Z_\[\]\d]+)\s*=\s*(.*?)\s*$/) {
+	    my $lvalue = $1;
+	    my $rvalue = $2;
+
+	    set_value($lvalue, $rvalue, 1, \%command_overrides, "COMMAND LINE");
+	} else {
+	    die "Invalid option definition '$val'\n";
+	}
+    }
+
     # make sure we have all mandatory configs
     get_mandatory_configs;
 
@@ -1371,7 +1396,10 @@ sub __eval_option {
 	# If a variable contains itself, use the default var
 	if (($var eq $name) && defined($opt{$var})) {
 	    $o = $opt{$var};
-	    $retval = "$retval$o";
+	    # Only append if the default doesn't contain itself
+	    if ($o !~ m/\$\{$var\}/) {
+		$retval = "$retval$o";
+	    }
 	} elsif (defined($opt{$o})) {
 	    $o = $opt{$o};
 	    $retval = "$retval$o";
@@ -3511,11 +3539,37 @@ sub patchcheck {
 	@list = reverse @list;
     }
 
+    my %skip_list;
+    my $will_skip = 0;
+
+    if (defined($patchcheck_skip)) {
+	foreach my $s (split /\s+/, $patchcheck_skip) {
+	    $s = `git log --pretty=oneline $s~1..$s`;
+	    $s =~ s/^(\S+).*/$1/;
+	    chomp $s;
+	    $skip_list{$s} = 1;
+	    $will_skip++;
+	}
+    }
+
     doprint("Going to test the following commits:\n");
     foreach my $l (@list) {
+	my $sha1 = $l;
+	$sha1 =~ s/^([[:xdigit:]]+).*/$1/;
+	next if (defined($skip_list{$sha1}));
 	doprint "$l\n";
     }
 
+    if ($will_skip) {
+	doprint("\nSkipping the following commits:\n");
+	foreach my $l (@list) {
+	    my $sha1 = $l;
+	    $sha1 =~ s/^([[:xdigit:]]+).*/$1/;
+	    next if (!defined($skip_list{$sha1}));
+	    doprint "$l\n";
+	}
+    }
+
     my $save_clean = $noclean;
     my %ignored_warnings;
 
@@ -3530,6 +3584,11 @@ sub patchcheck {
 	my $sha1 = $item;
 	$sha1 =~ s/^([[:xdigit:]]+).*/$1/;
 
+	if (defined($skip_list{$sha1})) {
+	    doprint "\nSkipping \"$item\"\n\n";
+	    next;
+	}
+
 	doprint "\nProcessing commit \"$item\"\n\n";
 
 	run_command "git checkout $sha1" or
@@ -4242,8 +4301,55 @@ sub cancel_test {
     die "\nCaught Sig Int, test interrupted: $!\n"
 }
 
-$#ARGV < 1 or die "ktest.pl version: $VERSION\n   usage: ktest.pl [config-file]\n";
+sub die_usage {
+    die << "EOF"
+ktest.pl version: $VERSION
+   usage: ktest.pl [options] [config-file]
+    [options]:
+       -D value: Where value can act as an option override.
+                -D BUILD_NOCLEAN=1
+                    Sets global BUILD_NOCLEAN to 1
+                -D TEST_TYPE[2]=build
+                    Sets TEST_TYPE of test 2 to "build"
+
+	        It can also override all temp variables.
+                 -D USE_TEMP_DIR:=1
+                    Will override all variables that use
+                    "USE_TEMP_DIR="
+
+EOF
+;
+}
+
+while ( $#ARGV >= 0 ) {
+    if ( $ARGV[0] eq "-D" ) {
+	shift;
+	die_usage if ($#ARGV < 1);
+	my $val = shift;
+
+	if ($val =~ m/(.*?):=(.*)$/) {
+	    set_variable($1, $2, 1);
+	} else {
+	    $command_vars[$#command_vars + 1] = $val;
+	}
+
+    } elsif ( $ARGV[0] =~ m/^-D(.*)/) {
+	my $val = $1;
+	shift;
+
+	if ($val =~ m/(.*?):=(.*)$/) {
+	    set_variable($1, $2, 1);
+	} else {
+	    $command_vars[$#command_vars + 1] = $val;
+	}
+    } elsif ( $ARGV[0] eq "-h" ) {
+	die_usage;
+    } else {
+	last;
+    }
+}
 
+$#ARGV < 1 or die_usage;
 if ($#ARGV == 0) {
     $ktest_config = $ARGV[0];
     if (! -f $ktest_config) {
@@ -4466,6 +4572,10 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
 
     doprint "RUNNING TEST $i of $opt{NUM_TESTS}$name with option $test_type $run_type$installme\n\n";
 
+    # Always show which build directory and output directory is being used
+    doprint "BUILD_DIR=$builddir\n";
+    doprint "OUTPUT_DIR=$outputdir\n\n";
+
     if (defined($pre_test)) {
 	my $ret = run_command $pre_test;
 	if (!$ret && defined($pre_test_die) &&
diff --git a/tools/testing/ktest/sample.conf b/tools/testing/ktest/sample.conf
index f43477a9b857..9c4c449a8f3e 100644
--- a/tools/testing/ktest/sample.conf
+++ b/tools/testing/ktest/sample.conf
@@ -1017,6 +1017,8 @@
 #      Note, PATCHCHECK_CHERRY requires PATCHCHECK_END to be defined.
 #      (default 0)
 #
+#  PATCHCHECK_SKIP is an optional list of shas to skip testing
+#
 #  PATCHCHECK_TYPE is required and is the type of test to run:
 #      build, boot, test.
 #

