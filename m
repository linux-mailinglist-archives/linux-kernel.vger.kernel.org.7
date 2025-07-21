Return-Path: <linux-kernel+bounces-739967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F3BB0CD9A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6573546847
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1C925228B;
	Mon, 21 Jul 2025 23:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiq9sk8W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BCC2459C8
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 23:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753139512; cv=none; b=YljH7D7qMFh2HaeFxS38BhLYrulH8N5eWFcvSdKjUKJmvJeDTQcqKfKK4/wdr4srFU/ZeVwWHmOH0r3PyYtplMo0P2ItMLL5Le7eFzY3BIHR5nv9ZlJ5pwnh8Qokwfl3v/efq6UcPZa4KF0aEdds5d1SBEeeevDlMhsPwBfsbUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753139512; c=relaxed/simple;
	bh=OXc56OnMbQDZY9QeTINDPjwJJzAhUbPy6eKEkpwRgYI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=d6KM7wTZ9jOZCBJXbaGWuFqTRWbMR4p2I0Mi6mRWUTPbQ26LKpdto2n4NnCR8Bm007fJqYWNv+RbQXgxUABwhrX3UcCbeZfSoVHGMqOkfmFoGBzEYPmwigHhDw2f7DIjXLp/CcVOcdMMDZsT1SmjyWfbyIJtKDdvMMT/xAZ8ipU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiq9sk8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44421C4CEFD;
	Mon, 21 Jul 2025 23:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753139512;
	bh=OXc56OnMbQDZY9QeTINDPjwJJzAhUbPy6eKEkpwRgYI=;
	h=Date:From:To:Cc:Subject:References:From;
	b=eiq9sk8WlaL2+sHj0ARoC+bF0KDAkqhxEFwLuKnH93bTe7RxbKn8hch2AiV/NR1ST
	 VhjUpTZw/llydODA969mAdt8GwTTNYOw2uJIInL8SEWPK2E0SF3wLszzU2sSQFQTCk
	 hy/LbC3R39Y7AdRuJldkw0HVSZWpxXXODM1U0Oulg71c+p+N2eWz17QPv5Zsa0SLT6
	 dt8G4kbQ2brQrm50EgLNA8OceIxcLqXQFiUQxcTy2Q9tiLcOm4U0mAgJ72Fcz/js7j
	 BNS8EP7qEjRdOI1jhjCPFdHmuUYVCFK33I83HtJUdZcDNnG6iYJ2/88EoQvDaRl+Vx
	 ZG7Pu47Ax1ElQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1udzgF-00000009vKq-2YSg;
	Mon, 21 Jul 2025 19:12:23 -0400
Message-ID: <20250721231223.465310898@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 21 Jul 2025 19:12:12 -0400
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
Subject: [for-next][PATCH 8/9] rtla/tests: Limit duration to maximum of 10s
References: <20250721231204.100737734@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

Many of the original rtla tests included durations of 1 minute and 30
seconds. Experience has shown this is unnecessary, since 10 seconds as
waiting time for samples to appear.

Change duration of all rtla tests to at most 10 seconds. This speeds up
testing significantly.

Before:
$ make check
All tests successful.
Files=3, Tests=54, 536 wallclock secs
( 0.03 usr  0.00 sys + 20.31 cusr 22.02 csys = 42.36 CPU)
Result: PASS

After:
$ make check
...
All tests successful.
Files=3, Tests=54, 196 wallclock secs
( 0.03 usr  0.01 sys + 20.28 cusr 20.68 csys = 41.00 CPU)
Result: PASS

Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Chang Yin <cyin@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>
Cc: Crystal Wood <crwood@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Link: https://lore.kernel.org/20250626123405.1496931-9-tglozar@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/tests/hwnoise.t  | 8 ++++----
 tools/tracing/rtla/tests/osnoise.t  | 4 ++--
 tools/tracing/rtla/tests/timerlat.t | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/tracing/rtla/tests/hwnoise.t b/tools/tracing/rtla/tests/hwnoise.t
index 5f71401a139e..448877564b8d 100644
--- a/tools/tracing/rtla/tests/hwnoise.t
+++ b/tools/tracing/rtla/tests/hwnoise.t
@@ -10,12 +10,12 @@ check "verify help page" \
 check "detect noise higher than one microsecond" \
 	"hwnoise -c 0 -T 1 -d 5s -q"
 check "set the automatic trace mode" \
-	"hwnoise -a 5 -d 30s" 2
+	"hwnoise -a 5 -d 10s" 2
 check "set scheduling param to the osnoise tracer threads" \
-	"hwnoise -P F:1 -c 0 -r 900000 -d 1M -q"
+	"hwnoise -P F:1 -c 0 -r 900000 -d 10s -q"
 check "stop the trace if a single sample is higher than 1 us" \
-	"hwnoise -s 1 -T 1 -t -d 30s" 2
+	"hwnoise -s 1 -T 1 -t -d 10s" 2
 check "enable a trace event trigger" \
-	"hwnoise -t -e osnoise:irq_noise trigger=\"hist:key=desc,duration:sort=desc,duration:vals=hitcount\" -d 1m"
+	"hwnoise -t -e osnoise:irq_noise trigger=\"hist:key=desc,duration:sort=desc,duration:vals=hitcount\" -d 10s"
 
 test_end
diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
index 44908fc01abf..6a4dfa31dc55 100644
--- a/tools/tracing/rtla/tests/osnoise.t
+++ b/tools/tracing/rtla/tests/osnoise.t
@@ -8,13 +8,13 @@ set_timeout 2m
 check "verify help page" \
 	"osnoise --help"
 check "verify the --priority/-P param" \
-	"osnoise top -P F:1 -c 0 -r 900000 -d 1M -q"
+	"osnoise top -P F:1 -c 0 -r 900000 -d 10s -q"
 check "verify the --stop/-s param" \
 	"osnoise top -s 30 -T 1 -t" 2
 check "verify the  --trace param" \
 	"osnoise hist -s 30 -T 1 -t" 2
 check "verify the --entries/-E param" \
-	"osnoise hist -P F:1 -c 0 -r 900000 -d 1M -b 10 -E 25"
+	"osnoise hist -P F:1 -c 0 -r 900000 -d 10s -b 10 -E 25"
 
 # Test setting default period by putting an absurdly high period
 # and stopping on threshold.
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index b354bacd78f8..2d59ee199c4d 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -25,9 +25,9 @@ check "verify help page" \
 check "verify -s/--stack" \
 	"timerlat top -s 3 -T 10 -t" 2
 check "verify -P/--priority" \
-	"timerlat top -P F:1 -c 0 -d 1M -q"
+	"timerlat top -P F:1 -c 0 -d 10s -q"
 check "test in nanoseconds" \
-	"timerlat top -i 2 -c 0 -n -d 30s" 2
+	"timerlat top -i 2 -c 0 -n -d 10s" 2
 check "set the automatic trace mode" \
 	"timerlat top -a 5 --dump-tasks" 2
 check "print the auto-analysis if hits the stop tracing condition" \
@@ -35,9 +35,9 @@ check "print the auto-analysis if hits the stop tracing condition" \
 check "disable auto-analysis" \
 	"timerlat top -s 3 -T 10 -t --no-aa" 2
 check "verify -c/--cpus" \
-	"timerlat hist -c 0 -d 30s"
+	"timerlat hist -c 0 -d 10s"
 check "hist test in nanoseconds" \
-	"timerlat hist -i 2 -c 0 -n -d 30s" 2
+	"timerlat hist -i 2 -c 0 -n -d 10s" 2
 
 # Actions tests
 check "trace output through -t" \
-- 
2.47.2



