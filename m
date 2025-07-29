Return-Path: <linux-kernel+bounces-750001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96B0B155BD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB5C3178D22
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97655284B57;
	Tue, 29 Jul 2025 23:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIbhssgZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ADE27FD52
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 23:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753830719; cv=none; b=MiM+1xOVkoog850YgmQkcEudDxLZ6hBrdIMkfunjvF54lGmE984efN3KAamgWn/rj5VEGY53n8hSbhg/TMsYg1MMjHKTHy3VQOakH+1X/XMzG5FJsZ2JLONGGHdxynXMQwFfATht2l67kpjhRaL2rF1Y3bZaJi5XgRmNnyUIKE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753830719; c=relaxed/simple;
	bh=qeqWr+5CFM8kfIaWbcmNXhke27HYh1Kx9tPy5RgZ8qg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=P5dLIji9gFP6BXuG1kxYpZ69ULmS0VRU3ytgx3hgq+TiLid6pqj153VQamqK8Pn9cZ18P3pMtO4h8vHqtsvBYlrTF8HOz6xEgI3uM89iit2QyD8XOYoorAVJ4esAPlU/7+xm2ViHiNL8b5SlxNGbjIX4NUmTN3WtvX4dCpNsty8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIbhssgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9567CC4CEF7;
	Tue, 29 Jul 2025 23:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753830718;
	bh=qeqWr+5CFM8kfIaWbcmNXhke27HYh1Kx9tPy5RgZ8qg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=eIbhssgZJN5/TaQqQBdSKkKmLoufS05iHVZnMrtXLTWbDlyLlyRIt6u36r13niUQh
	 23MmPqVLE7TpxhpimrOg6YSb6yQXYUGw/K/aHNLuLAT6ABQzvbUJydhJccmpmIiBHs
	 bsR4It2y5seLKODb22glxg2bKvT4AXCF2ICvWDPb2c7xviihR6hsuZkWhyBIR35KGC
	 gYHk4H4sPxfzRuIZM7VCteTvi2J77lT0KPJA9k79vQf5/40Vl4lUOWWGiTDkIkoMg1
	 TuuulO/byDPeC6cS6SYPHPEnOBZmBA7ptT0Ql8OctsfjoPekEt2vsZfvHyh7QOtF5j
	 rteZL+ULtObdA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ugtUT-00000005K9j-3LQH;
	Tue, 29 Jul 2025 19:12:13 -0400
Message-ID: <20250729231213.654134958@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 29 Jul 2025 19:11:59 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Luis Goncalves <lgoncalv@redhat.com>,
 Chang Yin <cyin@redhat.com>,
 Costa Shulyupin <costa.shul@redhat.com>
Subject: [for-next][PATCH 2/2] rtla/tests: Test timerlat -P option using actions
References: <20250729231157.059587961@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

The -P option is used to set priority of osnoise and timerlat threads.

Extend the test for -P with --on-threshold calling a script that looks
for running timerlat threads and checks if their priority is set
correctly.

As --on-threshold is only supported by timerlat at the moment, this is
only implemented there so far.

Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Cc: Chang Yin <cyin@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>
Link: https://lore.kernel.org/20250725133817.59237-3-tglozar@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/tests/engine.sh                 | 2 +-
 tools/tracing/rtla/tests/scripts/check-priority.sh | 8 ++++++++
 tools/tracing/rtla/tests/timerlat.t                | 3 ++-
 3 files changed, 11 insertions(+), 2 deletions(-)
 create mode 100755 tools/tracing/rtla/tests/scripts/check-priority.sh

diff --git a/tools/tracing/rtla/tests/engine.sh b/tools/tracing/rtla/tests/engine.sh
index 64c5be4313de..a97d644ead99 100644
--- a/tools/tracing/rtla/tests/engine.sh
+++ b/tools/tracing/rtla/tests/engine.sh
@@ -69,7 +69,7 @@ check() {
 			# Add rtla output and exit code as comments in case of failure
 			echo "$result" | col -b | while read line; do echo "# $line"; done
 			printf "#\n# exit code %s\n" $exitcode
-			[ -n "$expected_output" ] && \
+			[ -n "$expected_output" ] && [ $grep_result -ne 0 ] && \
 				printf "# Output match failed: \"%s\"\n" "$expected_output"
 		fi
 	fi
diff --git a/tools/tracing/rtla/tests/scripts/check-priority.sh b/tools/tracing/rtla/tests/scripts/check-priority.sh
new file mode 100755
index 000000000000..79b702a34a96
--- /dev/null
+++ b/tools/tracing/rtla/tests/scripts/check-priority.sh
@@ -0,0 +1,8 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+pids="$(pgrep ^$1)" || exit 1
+for pid in $pids
+do
+  chrt -p $pid | cut -d ':' -f 2 | head -n1 | grep "^ $2\$" >/dev/null
+  chrt -p $pid | cut -d ':' -f 2 | tail -n1 | grep "^ $3\$" >/dev/null
+done && echo "Priorities are set correctly"
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index db263dc90a2d..c71aed5534bf 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -25,7 +25,8 @@ check "verify help page" \
 check "verify -s/--stack" \
 	"timerlat top -s 3 -T 10 -t" 2 "Blocking thread stack trace"
 check "verify -P/--priority" \
-	"timerlat top -P F:1 -c 0 -d 10s -q"
+	"timerlat top -P F:1 -c 0 -d 10s -q -T 1 --on-threshold shell,command=\"tests/scripts/check-priority.sh timerlatu/ SCHED_FIFO 1\"" \
+	2 "Priorities are set correctly"
 check "test in nanoseconds" \
 	"timerlat top -i 2 -c 0 -n -d 10s" 2 "ns"
 check "set the automatic trace mode" \
-- 
2.47.2



