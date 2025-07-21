Return-Path: <linux-kernel+bounces-739848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A373EB0CC03
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14D19544CC2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC0223C519;
	Mon, 21 Jul 2025 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdxiMJKZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C005A23B635
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 20:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130252; cv=none; b=RjC568F1UNNzdFI+fVRie2qjuYAyaDsJoRCKk1Mf8XZFhYGG/taSZ0UgR2VNv7ZZdPMltlGtsArxlWZe7bgPbNnXzsaxpRcn0WnKMBZkfi6NoJjo3nmoNbxy0ZMKHp9Hw9Ap2lpYnaUSGRwfF/fcD0ftXv1TavAGGrmfDlUzlnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130252; c=relaxed/simple;
	bh=zlh+6trSwOsIx+Ra1qmBqMt/wUeLR93rdLKmqKOL5Po=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ph711xG/7CU6rIGdkj462o1KBHcUZnqmOlzKuuV1ImqOu5OArsSk4qia15HRvQ1UA7CUWiDgNk8wkEdDWYAwcuMtAu7SNeNwlO8jXNUtoinY79dmqOWYvCRL2AxlH80T8xdBdgAob9JohROxiZs1EWSaZL2nxiUSxwLvqF4uLxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdxiMJKZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FF3C4CEF4;
	Mon, 21 Jul 2025 20:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753130252;
	bh=zlh+6trSwOsIx+Ra1qmBqMt/wUeLR93rdLKmqKOL5Po=;
	h=Date:From:To:Cc:Subject:References:From;
	b=pdxiMJKZbXAvpzsQ6z5e4ASdqV6YIbTQll2vxSySf9FIGE9+XKHFUc+gQyJOj1Dxh
	 qDw+HKuTJNiLCvyQVuEyL2Nr8vYgiMkDWvEhF2JkFsi2gtE6/Gc4cQ3Nykezcqf1w6
	 dCeqzoByBgwxAbQfr3HmmrWA/dxEuQ8d9AQtApSA93yXD7ga9UMAgQdby1n4exFPPU
	 siAI1b1TYMjYnHqqY/PRkqZPB0VpoR5aK/RWK1oPjuUtTlKgep4R8PiTZW1U9qs8nV
	 7NhcklfO+/SLrdZ91pAHe67RXBbuEVqHUAp14R9hV1acnd5VPHSmW3jHjeAkGfBfy9
	 z0F8dd5yTEikQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1udxGt-00000009p3a-1gX4;
	Mon, 21 Jul 2025 16:38:03 -0400
Message-ID: <20250721203803.253425737@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 21 Jul 2025 16:37:40 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
 Dhaval Giani <dhaval.giani@gmail.com>,
 Greg KH <gregkh@linuxfoundation.org>
Subject: [for-next][PATCH 1/5] ktest.pl: Add -D option to override options
References: <20250721203739.462938756@kernel.org>
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

Cc: "John Warthog9 Hawley" <warthog9@kernel.org>
Cc: Dhaval Giani <dhaval.giani@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/20250718202053.231478909@kernel.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 45 +++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index a5f7fdd0c1fb..16e20d4137b3 100755
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



