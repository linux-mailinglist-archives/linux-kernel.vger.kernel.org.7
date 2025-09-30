Return-Path: <linux-kernel+bounces-838189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C4FBAEA13
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672482A2C7E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490B32C0F95;
	Tue, 30 Sep 2025 21:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nm9hHsHs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E7C257852
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 21:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759268718; cv=none; b=bwYF+SzG8nTJb+QggPrwypw7WMRBWBuaiKUMV4qjGx1wjMwX/Wo8fmIhTOHyZ7j3/a6w3M7dJz+wg1sKMDmLzYTG8UMeqhHBMCe2fQhl9tNx+dx4fGvcc7KPLnE9h5TAV6NgzggflTm7f2083W/CC4AtZTboZKkwpl45iRb0jLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759268718; c=relaxed/simple;
	bh=3StoqyMGT6v5eQNsTkgk+H1mGh93ioOe8+erb2QLPCY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=H9+Gu+6ZlH0uzfa3/t6ke4BGMzyPo9r6JdgRiSfaxoSunRy8MaqRbUdi8e7VX/bpF0YGtq++URV7fndlEZCHiwYiyBTkJmOOmh4h4eF6ue52ejYVeyH8cCr1p00+PY3Lz82m84MhwuKPd2XOsWA1Jh+9lKwvQW504HRRnQCOkMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nm9hHsHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7342C16AAE;
	Tue, 30 Sep 2025 21:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759268718;
	bh=3StoqyMGT6v5eQNsTkgk+H1mGh93ioOe8+erb2QLPCY=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Nm9hHsHs8iyuBv6PZTbPFXlhgnJ5hbB7bWmC55ManGtmk4eCg2k3bPwQHl3lM/fux
	 uZLHqnbywgNgQa80S2hEy9AL4/UlQM5iOJwxPFJszS+2pjwNbFc9Oe5EpZ7st10yQW
	 POM8/VvKjRtVigfd7U3haJl6/rrS213++ZBJ6Eaqrty9irVKDdkBOK3HX5+881GCdW
	 KsOAKcEu7F9aq9d8tcK8oaFjx0TikF7z41mvV0NC/6gJ0eFBihMQJZ8YsRM2qTyCvB
	 5mT0DIsTFREAaJL+eohcPSqA2Gk6/d0CvgfSdyN71CyJJvcnp7Qmky9IXZO1TMz1kE
	 siH3JjwPw4cIw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v3iBT-0000000DUwa-15b6;
	Tue, 30 Sep 2025 17:46:55 -0400
Message-ID: <20250930214655.111658900@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 30 Sep 2025 17:46:36 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Costa Shulyupin <costa.shul@redhat.com>,
 Crystal Wood <crwood@redhat.com>
Subject: [for-next][PATCH 6/7] tools/rtla: Add test engine support for unexpected output
References: <20250930214630.332381812@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Crystal Wood <crwood@redhat.com>

Add a check() parameter to indicate which text must not appear in the
output.

Simplify the code so that we can print failures as they happen rather
than trying to figure out what went wrong after printing "not ok".  This
also means that "not ok" gets printed after the info rather than before,
which seems more intuitive anyway.

Cc: John Kacur <jkacur@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>
Link: https://lore.kernel.org/20250907022325.243930-7-crwood@redhat.com
Reviewed-by: Tomas Glozar  <tglozar@redhat.com>
Signed-off-by: Crystal Wood <crwood@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/tests/engine.sh | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/tools/tracing/rtla/tests/engine.sh b/tools/tracing/rtla/tests/engine.sh
index a97d644ead99..c7de3d6ed6a8 100644
--- a/tools/tracing/rtla/tests/engine.sh
+++ b/tools/tracing/rtla/tests/engine.sh
@@ -43,6 +43,7 @@ check() {
 	tested_command=$1
 	expected_exitcode=${3:-0}
 	expected_output=$4
+	unexpected_output=$5
 	# Simple check: run rtla with given arguments and test exit code.
 	# If TEST_COUNT is set, run the test. Otherwise, just count.
 	ctr=$(($ctr + 1))
@@ -53,24 +54,33 @@ check() {
 		# Run rtla; in case of failure, include its output as comment
 		# in the test results.
 		result=$(eval stdbuf -oL $TIMEOUT "$RTLA" $2 2>&1); exitcode=$?
+		failbuf=''
+		fail=0
+
 		# Test if the results matches if requested
-		if [ -n "$expected_output" ]
+		if [ -n "$expected_output" ] && ! grep -qE "$expected_output" <<< "$result"
 		then
-			grep -E "$expected_output" <<< "$result" > /dev/null; grep_result=$?
-		else
-			grep_result=0
+			fail=1
+			failbuf+=$(printf "# Output match failed: \"%s\"" "$expected_output")
+			failbuf+=$'\n'
 		fi
 
-		if [ $exitcode -eq $expected_exitcode ] && [ $grep_result -eq 0 ]
+		if [ -n "$unexpected_output" ] && grep -qE "$unexpected_output" <<< "$result"
+		then
+			fail=1
+			failbuf+=$(printf "# Output non-match failed: \"%s\"" "$unexpected_output")
+			failbuf+=$'\n'
+		fi
+
+		if [ $exitcode -eq $expected_exitcode ] && [ $fail -eq 0 ]
 		then
 			echo "ok $ctr - $1"
 		else
-			echo "not ok $ctr - $1"
 			# Add rtla output and exit code as comments in case of failure
+			echo "not ok $ctr - $1"
+			echo -n "$failbuf"
 			echo "$result" | col -b | while read line; do echo "# $line"; done
 			printf "#\n# exit code %s\n" $exitcode
-			[ -n "$expected_output" ] && [ $grep_result -ne 0 ] && \
-				printf "# Output match failed: \"%s\"\n" "$expected_output"
 		fi
 	fi
 }
-- 
2.50.1



