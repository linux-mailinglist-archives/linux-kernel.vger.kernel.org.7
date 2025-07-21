Return-Path: <linux-kernel+bounces-739965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39684B0CD98
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0B7177991
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDA724C68B;
	Mon, 21 Jul 2025 23:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpTYrJII"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A8F245012
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 23:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753139512; cv=none; b=so0eusiC7dUu4sanSvS4/FfHUe0VlKYyjs4BEZkA/3XBLGHsN8tn+lisWqzFDUPNtHFJbkpCTEf3C2wvIoAXqatCrayz+KcQ+AbX1Catbo0x8rNgmjb7niJFzpibDt33N5+aIlCZt/bXEuYJwV99gL8OmexmtEOuXxzi4uo9zkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753139512; c=relaxed/simple;
	bh=AANbHkdKtPuXPJv6hdtAg/icWhXiXtfc0sKlkGGWgWw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=MntG+LqkYAk40f844ZJM07tPjuttkN6+hCn0nQeztDEvPCsHzCfTbXaR8Gm2tLufZxtJ4D9FQ424cJFrANpaSxVS6lXHdnWhB4pktzVALwukCrqUoRYSN5J0iAzxQngT+zQ7ObspcOWBBs8Lkaw/XB2R5xSuw0rUiLps60ZYYus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpTYrJII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D7DC4CEF9;
	Mon, 21 Jul 2025 23:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753139511;
	bh=AANbHkdKtPuXPJv6hdtAg/icWhXiXtfc0sKlkGGWgWw=;
	h=Date:From:To:Cc:Subject:References:From;
	b=VpTYrJIIvBcPAEnfEdNjdpAGc2hf8EBxjitTkB8z9Zu0jXsTTtc7xh0pTVuo03F8d
	 sd+arMNqrbZasXdJf4HMI1jzJdINAn3L/ktY4212CGyFb60KPvTHZrd5zsKNrn0AwC
	 e1yqeQk2AJxmNQrOwhsArUPdTsuiOFQ5Y5mxxQP43sfCalMFF6Xx7sEQuXDrZPFZ88
	 4hVqXROL+7kyZI4KQw2Qu13b/aY+0CuUJSOlaGxCNM4632QiSvpQxzNMcMMWxBTZ6L
	 Tnd93lFogfzQTP9jYtszC4C9x9iLd7zB933qhzEowAF26f+rvX3r/c1jdaR9ylWZ0/
	 YPcD5oFlkLt2g==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1udzgF-00000009vJq-1AGG;
	Mon, 21 Jul 2025 19:12:23 -0400
Message-ID: <20250721231223.127286852@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 21 Jul 2025 19:12:10 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Luis Goncalves <lgoncalv@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Chang Yin <cyin@redhat.com>,
 Costa Shulyupin <costa.shul@redhat.com>,
 Crystal Wood <crwood@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 6/9] rtla/tests: Check rtla output with grep
References: <20250721231204.100737734@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

Add argument to the check command in the test suite that takes a regular
expression that the output of rtla command is checked against. This
allows testing for specific information in rtla output in addition
to checking the return value.

Two minor improvements are included: running rtla with "eval" so that
arguments with spaces can be passed to it via shell quotations, and
the stdout of pushd and popd is suppressed to clean up the test output.

Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Chang Yin <cyin@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>
Cc: Crystal Wood <crwood@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Link: https://lore.kernel.org/20250626123405.1496931-7-tglozar@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/tests/engine.sh | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/rtla/tests/engine.sh b/tools/tracing/rtla/tests/engine.sh
index f2616a8e4179..64c5be4313de 100644
--- a/tools/tracing/rtla/tests/engine.sh
+++ b/tools/tracing/rtla/tests/engine.sh
@@ -11,7 +11,7 @@ test_begin() {
 reset_osnoise() {
 	# Reset osnoise options to default and remove any dangling instances created
 	# by improperly exited rtla runs.
-	pushd /sys/kernel/tracing || return 1
+	pushd /sys/kernel/tracing >/dev/null || return 1
 
 	# Remove dangling instances created by previous rtla run
 	echo 0 > tracing_thresh
@@ -35,11 +35,14 @@ reset_osnoise() {
 	echo 0 > stop_tracing_us
 	echo 1000 > timerlat_period_us
 
-	popd
+	popd >/dev/null
 }
 
 check() {
+	test_name=$0
+	tested_command=$1
 	expected_exitcode=${3:-0}
+	expected_output=$4
 	# Simple check: run rtla with given arguments and test exit code.
 	# If TEST_COUNT is set, run the test. Otherwise, just count.
 	ctr=$(($ctr + 1))
@@ -49,8 +52,16 @@ check() {
 		[ "$NO_RESET_OSNOISE" == 1 ] || reset_osnoise
 		# Run rtla; in case of failure, include its output as comment
 		# in the test results.
-		result=$(stdbuf -oL $TIMEOUT "$RTLA" $2 2>&1); exitcode=$?
-		if [ $exitcode -eq $expected_exitcode ]
+		result=$(eval stdbuf -oL $TIMEOUT "$RTLA" $2 2>&1); exitcode=$?
+		# Test if the results matches if requested
+		if [ -n "$expected_output" ]
+		then
+			grep -E "$expected_output" <<< "$result" > /dev/null; grep_result=$?
+		else
+			grep_result=0
+		fi
+
+		if [ $exitcode -eq $expected_exitcode ] && [ $grep_result -eq 0 ]
 		then
 			echo "ok $ctr - $1"
 		else
@@ -58,6 +69,8 @@ check() {
 			# Add rtla output and exit code as comments in case of failure
 			echo "$result" | col -b | while read line; do echo "# $line"; done
 			printf "#\n# exit code %s\n" $exitcode
+			[ -n "$expected_output" ] && \
+				printf "# Output match failed: \"%s\"\n" "$expected_output"
 		fi
 	fi
 }
-- 
2.47.2



