Return-Path: <linux-kernel+bounces-742831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8E3B0F724
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23970179AE6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE930200132;
	Wed, 23 Jul 2025 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/z1oUoq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAB71F5827
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284963; cv=none; b=O5lsKgji+RmqwRNcU0KTkI/AfkuHgyEKOyXV56FSySxrOBM23jhHfY69WxkLydRitUB+QYSTnDkwCLBTdouR8ZoKqcDbzjDGazI7ChPvIWG8QlBTmyIJS6e+f0WRpJPpChTXY5t3Kg1RScGUgodZrb9hsEBJnLS7ZvJw61sNaqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284963; c=relaxed/simple;
	bh=MyJ++kcHYsc3TCfHXbv+NA4FXvwX5QEPx0gAXoTb3hY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=PjVvOwZVXuODVrhME2XPAvkAlaM8PMiUSDbaF3e9kP3ORcTghrDY4mTKMaUgpBoPmDvpx/n7Kxzdd68JgXfoLXOwZdyL9ohGLtVV10M+pwNJzXumwsuWDMjC9EMOTTX5MDsT39pgVTxoe5PCnRTj8fCge+eNXV8KyAAzhGkCtD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/z1oUoq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BB6C4CEF1;
	Wed, 23 Jul 2025 15:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753284962;
	bh=MyJ++kcHYsc3TCfHXbv+NA4FXvwX5QEPx0gAXoTb3hY=;
	h=Date:From:To:Cc:Subject:References:From;
	b=H/z1oUoqdE4mhVOrC6MhD8WXLFY2KK+JNvR4Umc7VhVsk6sFHUJq9as9Gs2rAW9gw
	 tmek4m+csrLGTiT/JQcu4X5Z74tzHSpMYIKrljVXszOAsaxzryjoP5How8/kBRSF3x
	 hHBVf5N7Bt8AlkPnk6/yAs9Ha4we6KSn6qD7jPXJdJHPyEsS7dgOqsFMWg0KfUYdDi
	 xfv86byfUFsTyTxjKVsbWy36q9xcHHP5pG+p+w0Nl/nID+STNUj1aFRtMKV4XnfSFW
	 3B0pb+ocdjM/r+zsh2zsnSIn7grPJfCnNNcUaE4gKLMUcBhxvJefm3U7K+Ln/PAqTI
	 /JJSsrSqdV/4Q==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ueame-00000000LRE-1LUB;
	Wed, 23 Jul 2025 10:49:28 -0400
Message-ID: <20250723144928.172299624@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 23 Jul 2025 10:49:12 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 5/8] tracing: Remove pointless memory barriers
References: <20250723144907.219256132@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

Memory barriers are useful to ensure memory accesses from one CPU appear in
the original order as seen by other CPUs.

Some smp_rmb() and smp_wmb() are used, but they are not ordering multiple
memory accesses.

Remove them.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Link: https://lore.kernel.org/20250626151940.1756398-1-namcao@linutronix.de
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/rv/rv.c | 6 ------
 kernel/trace/trace.c | 7 -------
 2 files changed, 13 deletions(-)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index e4077500a91d..c04a49da4328 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -675,8 +675,6 @@ static bool __read_mostly monitoring_on;
  */
 bool rv_monitoring_on(void)
 {
-	/* Ensures that concurrent monitors read consistent monitoring_on */
-	smp_rmb();
 	return READ_ONCE(monitoring_on);
 }
 
@@ -696,8 +694,6 @@ static ssize_t monitoring_on_read_data(struct file *filp, char __user *user_buf,
 static void turn_monitoring_off(void)
 {
 	WRITE_ONCE(monitoring_on, false);
-	/* Ensures that concurrent monitors read consistent monitoring_on */
-	smp_wmb();
 }
 
 static void reset_all_monitors(void)
@@ -713,8 +709,6 @@ static void reset_all_monitors(void)
 static void turn_monitoring_on(void)
 {
 	WRITE_ONCE(monitoring_on, true);
-	/* Ensures that concurrent monitors read consistent monitoring_on */
-	smp_wmb();
 }
 
 static void turn_monitoring_on_with_reset(void)
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 95ae7c4e5835..0dff4298fc0e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -936,7 +936,6 @@ int tracing_is_enabled(void)
 	 * return the mirror variable of the state of the ring buffer.
 	 * It's a little racy, but we don't really care.
 	 */
-	smp_rmb();
 	return !global_trace.buffer_disabled;
 }
 
@@ -1107,8 +1106,6 @@ void tracer_tracing_on(struct trace_array *tr)
 	 * important to be fast than accurate.
 	 */
 	tr->buffer_disabled = 0;
-	/* Make the flag seen by readers */
-	smp_wmb();
 }
 
 /**
@@ -1640,8 +1637,6 @@ void tracer_tracing_off(struct trace_array *tr)
 	 * important to be fast than accurate.
 	 */
 	tr->buffer_disabled = 1;
-	/* Make the flag seen by readers */
-	smp_wmb();
 }
 
 /**
@@ -2710,8 +2705,6 @@ void trace_buffered_event_enable(void)
 
 static void enable_trace_buffered_event(void *data)
 {
-	/* Probably not needed, but do it anyway */
-	smp_rmb();
 	this_cpu_dec(trace_buffered_event_cnt);
 }
 
-- 
2.47.2



