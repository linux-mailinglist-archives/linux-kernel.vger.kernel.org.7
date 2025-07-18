Return-Path: <linux-kernel+bounces-737334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2A8B0AB0D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 22:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E171C24673
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E5421CC4D;
	Fri, 18 Jul 2025 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lw9fJl3N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE49D21A92F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752870029; cv=none; b=R74eBz+QfHcjcatiNN9MpvuHhLkvL5wMpZoVA2hKzZlUmO6Pby86kz23WatIPBqcxEUNg6IHq59x//XGsFjUrTBaO+SAmmf3cwf2r7s1/FHLHIxYGTTUZZflpJ0J3cU2zeekryCnPrWc5wrk+ayD9t/fxdBespcOv23PAeNYcwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752870029; c=relaxed/simple;
	bh=rRg0o+hItQud96owWCmMg3FvtAzGw1eqcD4S/uWJRss=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=a1eLLWxHP/eZ6NGgACj/EKC7bIHHg8pAuyZUw98gQNjTiTYMHVlP6W7qYKz7GhSs87Js0ZA9e/rsVJZXeiqdqxJoainxams5e94BylrjfcjYdN7xs0NnOVXb6v1GknZ1vWP+w9VHcYyA11hCbNEbF8Bhd4Xk1AJNpau9ADM5cuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lw9fJl3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35999C4CEF6;
	Fri, 18 Jul 2025 20:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752870029;
	bh=rRg0o+hItQud96owWCmMg3FvtAzGw1eqcD4S/uWJRss=;
	h=Date:From:To:Cc:Subject:References:From;
	b=lw9fJl3Nu/ci5avNIubJzOTo0Plk3taRi+X7Go0041EdppoORSIthviROERD7Dvu6
	 lv0uYYJNJr8BLStDf8e6EMDB6iok2N2iEVFj1wTge+rLKUXZmXyNxmrxBSaSZHZRzD
	 St7po6YrlwCFgUAmhYE9L5vrkkvFW77r09Jly33EXTT3KQ1zisOUkIAJldeTd/kLq/
	 YVEdwAvAF7q7PmPAt4yM0P8fzLJ30sMKhIR7MI/MLEy6ew94DwpDgjJH9hiUl1NqI8
	 n04bKxIRy28umCSp9ORaTJCXBBCE0tj2ubOvmjNZCQGEcwZr7mk+MAfZ8KcHUNT5fm
	 HNn6yWnD5ZujA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ucrZd-00000007Qd6-2I7F;
	Fri, 18 Jul 2025 16:20:53 -0400
Message-ID: <20250718202053.399653933@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 18 Jul 2025 16:18:42 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
 Dhaval Giani <dhaval.giani@gmail.com>,
 Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH 2/5] ktest.pl: Allow command option -D to override temp variables
References: <20250718201840.714067501@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Currently -D only updates the persistent options that are defined with
"=". Allow it to also override all temp variables that are defined with
":=".

 ktest.pl -D 'USE_TEMP_DIR:=1' -D 'TEST_TYPE[2]=build' config

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 8fcc09893986..c441934f1def 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -22,6 +22,7 @@ my %repeat_tests;
 my %repeats;
 my %evals;
 my @command_vars;
+my %command_tmp_vars;
 
 #default opts
 my %default = (
@@ -901,14 +902,22 @@ sub set_eval {
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
@@ -4267,6 +4276,11 @@ ktest.pl version: $VERSION
                 -D TEST_TYPE[2]=build
                     Sets TEST_TYPE of test 2 to "build"
 
+	        It can also override all temp variables.
+                 -D USE_TEMP_DIR:=1
+                    Will override all variables that use
+                    "USE_TEMP_DIR="
+
 EOF
 ;
 }
@@ -4277,7 +4291,11 @@ while ( $#ARGV >= 0 ) {
 	die_usage if ($#ARGV < 1);
 	my $val = shift;
 
-	$command_vars[$#command_vars + 1] = $val;
+	if ($val =~ m/(.*?):=(.*)$/) {
+	    set_variable($1, $2, 1);
+	} else {
+	    $command_vars[$#command_vars + 1] = $val;
+	}
 
     } elsif ( $ARGV[0] eq "-h" ) {
 	die_usage;
-- 
2.47.2



