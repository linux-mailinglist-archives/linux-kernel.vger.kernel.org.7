Return-Path: <linux-kernel+bounces-745941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EC5B120BB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249111C83C9F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30351C700D;
	Fri, 25 Jul 2025 15:21:54 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EF577111
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753456914; cv=none; b=UYA1/lyjLGQyk0eAa2B24Jvj6jLBcDhTp48gBkhse9QZ7l9Lfwf/iJ2F4EWFNGwDMwtmODkE8qxEA1MAoKFRiJRct7DW2YU5OiCUfxIo9An8vFT6T+WLg/uAFmcBsCCVatJypEDaj1VLjGpLlAbHwSDe0nz30d/1YZtxiWrN7Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753456914; c=relaxed/simple;
	bh=rO7nPZF9OoNeVpaU9JxZBg1sxIvcAx4x6Zx8bScQORo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GKsJo/YJKOmmfOLCFnnkbv6svB9UnSol1i8/+2EIFXz5P4vyA4/glMHFPKcmbFiRRMRJ/hJgS4qW9DpSjACyzwBkkGscHDeU08Ave0jFH9S4NICGDDxBzVbtpoHLq2Kk0CBIIKnB4k/Hqb+fTxDITqDjJWzob2B8X5ijov0tZpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 557AB1A07E6;
	Fri, 25 Jul 2025 15:21:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id B1F5860016;
	Fri, 25 Jul 2025 15:21:48 +0000 (UTC)
Date: Fri, 25 Jul 2025 11:21:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>, Dhaval Giani
 <dhaval.giani@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] ktest.pl: Add new PATCHCHECK_SKIP option to skip testing
 individual commits
Message-ID: <20250725112153.1dd06b84@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: yctqo439o3dft1t97g5h5fjqab5qsotz
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: B1F5860016
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19ZIUPJOI9WRMWrQ0JxM7aUBH+f2SrWAxs=
X-HE-Tag: 1753456908-56571
X-HE-Meta: U2FsdGVkX1/EvJ+BPmtdDhbLtRQPJp1R779C0AI1O0VOW8FakFob6qI9g90MWX3OSC5Yj3ng6Qcd2KxUm+thzN5jBx1+k0u2A9I3Ma0wgwgbYSnhAN8PP8UIjocXbTWwHsvj4ukGzrdMtUmj+ayYTeJdNezml4S9x5tOHmo6A5D5eV2nDv6x8/i2Pcb5a1QAxDH6zOkqrsVhEnSoboS61ia1JklKxe+I3CrjbcQrSYiCql+U362rp3f821gxm8hWV9k31UMt5A2gib2U6pTUI5Yka+c+A0ZHbBHOsFvsiD5r+LCNY5NYpOHaeMRdS66nKXpBOH9lz5czW4Rrwl/PYiIFrHnADSFfcZL+YOWoduCMQ3yrY++KrQ/x+tzy50Zr

From: Steven Rostedt <rostedt@goodmis.org>

When testing a series of commits that also includes changes to the Linux
tools directory, it is useless to test the changes in tools as they may
not affect the kernel itself. Doing tests on the kernel for changes that
do not affect the kernel is a waste of time.

Add a PATCHCHECK_SKIP that takes a series of shas that will be skipped
while doing the individual commit tests.

For example, the runtime verification may have a series of commits like:

$ git log --abbrev-commit --pretty=oneline fac5493251a6~1..HEAD
3d3800b4f7f4 rv: Remove rv_reactor's reference counter
3d3c376118b5 rv: Merge struct rv_reactor_def into struct rv_reactor
24cbfe18d55a rv: Merge struct rv_monitor_def into struct rv_monitor
b0c08dd5348d rv: Remove unused field in struct rv_monitor_def
58d5f0d437a8 (debiantesting-x86-64/trace/rv/core) rv: Return init error when registering monitors
560473f2e2d7 verification/rvgen: Organise Kconfig entries for nested monitors
9efcf590827c tools/dot2c: Fix generated files going over 100 column limit
1160ccaf772f tools/rv: Stop gracefully also on SIGTERM
f60227f34489 tools/rv: Do not skip idle in trace
f3735df6281e verification/rvgen: Do not generate unused variables
6fb37c2a27eb verification/rvgen: Generate each variable definition only once
8cfcf9b0e92f verification/rvgen: Support the 'next' operator
fac5493251a6 rv: Allow to configure the number of per-task monitor

Where the first commit touches the kernel followed by a series of commits
that do not, and ends with commits that do. Instead of having to add
multiple patchcheck tests to handle the gaps, just include the commits
that should not be tested:

$ git log --abbrev-commit --pretty=oneline fac5493251a6~1..HEAD |
  grep -e verification -e tools/ | cut -d' ' -f1 |
  while read a ; do echo -n "$a "; done
560473f2e2d7 9efcf590827c 1160ccaf772f f60227f34489 f3735df6281e 6fb37c2a27eb 8cfcf9b0e92f

Then set PATCHCHECK_SKIP to that, and those commits will be skipped.

 PATCHCHECK_SKIP = 560473f2e2d7 9efcf590827c 1160ccaf772f f60227f34489 f3735df6281e 6fb37c2a27eb 8cfcf9b0e92f

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl    | 33 +++++++++++++++++++++++++++++++++
 tools/testing/ktest/sample.conf |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 2d4ba097d510..001c4df9f7df 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -218,6 +218,7 @@ my $patchcheck_type;
 my $patchcheck_start;
 my $patchcheck_cherry;
 my $patchcheck_end;
+my $patchcheck_skip;
 
 my $build_time;
 my $install_time;
@@ -382,6 +383,7 @@ my %option_map = (
     "PATCHCHECK_START"		=> \$patchcheck_start,
     "PATCHCHECK_CHERRY"		=> \$patchcheck_cherry,
     "PATCHCHECK_END"		=> \$patchcheck_end,
+    "PATCHCHECK_SKIP"		=> \$patchcheck_skip,
 );
 
 # Options may be used by other options, record them.
@@ -3537,11 +3539,37 @@ sub patchcheck {
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
 
@@ -3556,6 +3584,11 @@ sub patchcheck {
 	my $sha1 = $item;
 	$sha1 =~ s/^([[:xdigit:]]+).*/$1/;
 
+	if (defined($skip_list{$sha1})) {
+	    doprint "\nSkipping \"$item\"\n\n";
+	    next;
+	}
+
 	doprint "\nProcessing commit \"$item\"\n\n";
 
 	run_command "git checkout $sha1" or
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
-- 
2.47.2


