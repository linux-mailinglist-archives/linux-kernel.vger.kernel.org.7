Return-Path: <linux-kernel+bounces-737332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A5BB0AB0B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 22:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A4481C239CF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE50F21B9CD;
	Fri, 18 Jul 2025 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jikutjqy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5853B11712
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752870029; cv=none; b=ed11NIikucZC9TFb8J4S/lspWWW/EDGR2qr17dZva9QIlOOXnzEYEEZdU0vj+bT3EiwAMBsNuTVof6qmKlCmcwRAM5plHOC2S6P5YK9ilR5/Nl0Dyq3ggqBDdVL0TPfqr6N/Uk+UEe8t92pe5rlR6yB2YvEbAcykrf80pSPX87E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752870029; c=relaxed/simple;
	bh=/R2ql7W1+e3579dR27SG6VrGFvEoDyaZ+gKAlEYsEcg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=U/4fZKXdbJpWUHIVBTGImVht4BtABCUoxzf0O2/jpJNjVJBysu8NYyBCt29Mgoa3o0ABADmJiFIdhJ/1WZxx1mH6HC7x/LsZJO1bGQGtTQc6zETadHfLMtaTa5KZTHfBcLp9DuqtxzMGXSdziP0+Bm9+tNztk8SSZyCqhOZEmg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jikutjqy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F198C4CEF5;
	Fri, 18 Jul 2025 20:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752870029;
	bh=/R2ql7W1+e3579dR27SG6VrGFvEoDyaZ+gKAlEYsEcg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=jikutjqyllPOAfUiHlM/jboq1tzn9Dva6oMgos0vwD6FHZHxqV7CSml+hueF2XKem
	 FHncWyy3D6BEi0riH5NsaPV4faCP9cIFmym1VQ1Oc0a+i0C/PzRakb87WG3J2/gf8s
	 UvcIGSV7SS0Utr1AUL6olAprx9uNXLHeFNMhktWV+Dx7ugtMyF4uVTz5/vSt1Ll/ej
	 9aYTXx3cpsBs0pb3L/RE7Iizyj09GcxheDkwmAlh0cUD4dJZyG7lqAExru6hfTb8DU
	 EI+TjZkbddc/I5yAtStzqgM0RIcIhes16h78aEMRFf7qdABI9wDC1UI0Gmq8xtynxs
	 NzfQEA8KQtoDA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ucrZd-00000007Qcc-1amE;
	Fri, 18 Jul 2025 16:20:53 -0400
Message-ID: <20250718202053.231478909@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 18 Jul 2025 16:18:41 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
 Dhaval Giani <dhaval.giani@gmail.com>,
 Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH 1/5] ktest.pl: Add -D option to override options
References: <20250718201840.714067501@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Add -D option that lets the user override options in the config.

For instance, if the config has: BUILD_NOCLEAN=1 which prevents mrproper
from being called before builds, and the user wants to call it once. The
user can run:

  ktest -D BUILD_NOCLEAN=0 config

And the default "BUILD_NOCLEAN" options will be disabled.

If the user wants to change the second test to do a build and not boot,
the user can run:

  ktest -D 'TEST_TYPE[2]=build' config

Where the '[#]' is for the test to assign the variable for. In the above
example, it will happen on test 2.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 45 +++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index a5f7fdd0c1fb..8fcc09893986 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -21,6 +21,7 @@ my %opt;
 my %repeat_tests;
 my %repeats;
 my %evals;
+my @command_vars;
 
 #default opts
 my %default = (
@@ -1286,6 +1287,19 @@ sub read_config {
 
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
 
@@ -4242,8 +4256,37 @@ sub cancel_test {
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
+	$command_vars[$#command_vars + 1] = $val;
+
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
-- 
2.47.2



