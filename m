Return-Path: <linux-kernel+bounces-739850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E26B0CC05
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCEC9160B12
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8829123D2B6;
	Mon, 21 Jul 2025 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gH4Lr73G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D3535973
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 20:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130253; cv=none; b=cd2hDYM2kFPZFaHTgoXyjzBU/eh0Vq0HHhxyqaP7/ZKnSWIZujcsy+DIpBgyZ+kpXFryw5hcw0uqjh+snqSVrjuECsva6Wf2azq3YH8BGLwsDPA4z0aLQLbpvk+71mtFLX8I+HQO9u+tBMANB464EMA0KVgL+JugeSSBAgBiUaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130253; c=relaxed/simple;
	bh=gc/tiouEgPfMaWrG2V9g+sCvkq8+ChO2L6JjUxXoeq4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=CsF9E9ap13YI+iMU9Oh0b11/av4f5NpXHuPKlb1CWqXGqwy5FWFz97B85RPnZf8Bb7HkUap/lMIZD6QpMTMl96tpPhIDRIEId3JWLpS1oA+JkxpjjbicaOepJI6PfKUAeL1JEI2s4NYR5WEJJYamasIU/yXBd1MVUqqatwnuOdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gH4Lr73G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83635C4CEF9;
	Mon, 21 Jul 2025 20:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753130252;
	bh=gc/tiouEgPfMaWrG2V9g+sCvkq8+ChO2L6JjUxXoeq4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=gH4Lr73GVha9tvXVTB5WV3O/LBWXL37vE5JoTGcDFhtGE1hLwKwgUlMmQ2Hl9fn/E
	 zgmucYbVv9QVxgWVOgBY8QYbarmTikCAURmzHq6GjxBRhm/IRAMc4V7Oad0c+6qPcF
	 tHW2xDm1JOoIGMjXd76jV1wfgX2LMIlusLx+40MapDQBJqj5JOq69jo2y1ihsSJ0gE
	 VO4XEoLZXU8jcVp7ZumBK4wgYAK+0jsqNlTsRTY2tz4VWy0Q0urZ9hHhbubBxfLnLH
	 /+NJwu6gFirW/18PRyHCpaMWc64KdfmhdG240rnbQ+Ijt0lt6PuRhERpbio05+Ke3L
	 gIFDsmet0ON3A==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1udxGt-00000009p44-2OMD;
	Mon, 21 Jul 2025 16:38:03 -0400
Message-ID: <20250721203803.422398121@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 21 Jul 2025 16:37:41 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
 Dhaval Giani <dhaval.giani@gmail.com>,
 Greg KH <gregkh@linuxfoundation.org>
Subject: [for-next][PATCH 2/5] ktest.pl: Allow command option -D to override temp variables
References: <20250721203739.462938756@kernel.org>
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

Cc: "John Warthog9 Hawley" <warthog9@kernel.org>
Cc: Dhaval Giani <dhaval.giani@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/20250718202053.399653933@kernel.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 16e20d4137b3..7b94b9b83ee7 100755
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



