Return-Path: <linux-kernel+bounces-767145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CF8B24FD6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A415E188E2EF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BC82874FA;
	Wed, 13 Aug 2025 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ajUzUREQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4dtpvpeG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09856286D52
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102559; cv=none; b=P1efkFHPq5AETYrQapVZB7sQLqFSvu0PXylzG6MbQPnhqDPuYMDhcqy2I+ZilMFY7H/vz4T1oUjRFwDizcuxuLrFZe9D6VlwW/jnEcQY6FHd4BqXDwrucsbR8e/NN03b80LAkLOpXPBwZOr82pJpM0YIRZkPJmQeXb/MTRaICZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102559; c=relaxed/simple;
	bh=gD66lkZO5SYisEaAHjZR3BnveNJcWa8+rT/0CAAZS/s=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=iiB0pZIfFgZm496Lr3XVBpFTlKB1zB975701ZIljj+fPy0Puo9ra0E1MSyk2ZJILckpDMcMldmhPx2VpsTg72VSykAbrhM43eUYvV0e5m2riOpet7ETpVk+DtMNUW9/3jwscysTrlqvsvEq3OAuZAc5Lhtroc9Qa3CB+hRU5ss8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ajUzUREQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4dtpvpeG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250813162823.845026450@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755102556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ouOsjc5WDfUTdoifaPmYfBma6XPdw6qiHLc6d5Wjqzs=;
	b=ajUzUREQlLhF5TE5ssZoUAn0NXXANrscZO4m3VF48253P78e0pAf89LHTAm1A0eHph5Swl
	hPrA1nDzLNaJSLDlS7esZcmwUlrUbqy/wAp6zGGlQa9NUGthoOR5NJ6HVgHdKwbpN1TyLy
	V1eUV3tyD2a5rSklPUYBlY0D7chhv3yTzXs76vJFzhNjhToK6jldwj3MTujcOeMXzZwYWT
	x9J5zqoISsv3/kpvClRpr1rdjQlzSrD8sAYkSLU6ZvX4+6G8katkq5+FEc9g8BYPtAX7ak
	XJ/Iw+OyAjF9SEagdrMMUqcRWigzjl+inilEZ/i5ZtIKvenwk2WWVGcvjH5uIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755102556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ouOsjc5WDfUTdoifaPmYfBma6XPdw6qiHLc6d5Wjqzs=;
	b=4dtpvpeGJpnpEgziUwXIgE58JxaOSz7Aa0bdWVsRvy0wmz9SFJA2dYM9hzrFPYmLyg8NlH
	NaDYUkGNfGRgPQDQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Wei Liu <wei.liu@kernel.org>,
 Jens Axboe <axboe@kernel.dk>
Subject: [patch 01/11] rseq: Avoid pointless evaluation in
 __rseq_notify_resume()
References: <20250813155941.014821755@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 18:29:14 +0200 (CEST)

The RSEQ critical section mechanism only clears the event mask when a
critical section is registered, otherwise it is stale and collects
bits.

That means once a critical section is installed the first invocation of
that code when TIF_NOTIFY_RESUME is set will abort the critical section,
even when the TIF bit was not raised by the rseq preempt/migrate/signal
helpers.

This also has a performance implication because TIF_NOTIFY_RESUME is a
multiplexing TIF bit, which is utilized by quite some infrastructure. That
means every invocation of __rseq_notify_resume() goes unconditionally
through the heavy lifting of user space access and consistency checks even
if there is no reason to do so.

Keeping the stale event mask around when exiting to user space also
prevents it from being utilized by the upcoming time slice extension
mechanism.

Avoid this by reading and clearing the event mask before doing the user
space critical section access with preemption disabled, which ensures that
the read and clear operation is CPU local atomic versus scheduling.

This is correct as after re-enabling preemption any relevant event will set
the bit again and raise TIF_NOTIFY_RESUME, which makes the user space exit
code take another round of TIF bit clearing.

If the event mask was non-zero, invoke the slow path. On debug kernels the
slow path is invoked unconditionally and the result of the event mask
evaluation is handed in.

Add a exit path check after the TIF bit loop, which validates on debug
kernels that the event mask is zero before exiting to user space.

While at it reword the convoluted comment why the pt_regs pointer can be
NULL under certain circumstances.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/irq-entry-common.h |    7 ++--
 include/linux/rseq.h             |   10 +++++
 kernel/rseq.c                    |   66 ++++++++++++++++++++++++++-------------
 3 files changed, 58 insertions(+), 25 deletions(-)

--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -2,11 +2,12 @@
 #ifndef __LINUX_IRQENTRYCOMMON_H
 #define __LINUX_IRQENTRYCOMMON_H
 
+#include <linux/context_tracking.h>
+#include <linux/kmsan.h>
+#include <linux/rseq.h>
 #include <linux/static_call_types.h>
 #include <linux/syscalls.h>
-#include <linux/context_tracking.h>
 #include <linux/tick.h>
-#include <linux/kmsan.h>
 #include <linux/unwind_deferred.h>
 
 #include <asm/entry-common.h>
@@ -226,6 +227,8 @@ static __always_inline void exit_to_user
 
 	arch_exit_to_user_mode_prepare(regs, ti_work);
 
+	rseq_exit_to_user_mode();
+
 	/* Ensure that kernel state is sane for a return to userspace */
 	kmap_assert_nomap();
 	lockdep_assert_irqs_disabled();
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -66,6 +66,14 @@ static inline void rseq_migrate(struct t
 	rseq_set_notify_resume(t);
 }
 
+static __always_inline void rseq_exit_to_user_mode(void)
+{
+	if (IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
+		if (WARN_ON_ONCE(current->rseq && current->rseq_event_mask))
+			current->rseq_event_mask = 0;
+	}
+}
+
 /*
  * If parent process has a registered restartable sequences area, the
  * child inherits. Unregister rseq for a clone with CLONE_VM set.
@@ -118,7 +126,7 @@ static inline void rseq_fork(struct task
 static inline void rseq_execve(struct task_struct *t)
 {
 }
-
+static inline void rseq_exit_to_user_mode(void) { }
 #endif
 
 #ifdef CONFIG_DEBUG_RSEQ
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -324,9 +324,9 @@ static bool rseq_warn_flags(const char *
 	return true;
 }
 
-static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
+static int rseq_check_flags(struct task_struct *t, u32 cs_flags)
 {
-	u32 flags, event_mask;
+	u32 flags;
 	int ret;
 
 	if (rseq_warn_flags("rseq_cs", cs_flags))
@@ -339,17 +339,7 @@ static int rseq_need_restart(struct task
 
 	if (rseq_warn_flags("rseq", flags))
 		return -EINVAL;
-
-	/*
-	 * Load and clear event mask atomically with respect to
-	 * scheduler preemption and membarrier IPIs.
-	 */
-	scoped_guard(RSEQ_EVENT_GUARD) {
-		event_mask = t->rseq_event_mask;
-		t->rseq_event_mask = 0;
-	}
-
-	return !!event_mask;
+	return 0;
 }
 
 static int clear_rseq_cs(struct rseq __user *rseq)
@@ -380,7 +370,7 @@ static bool in_rseq_cs(unsigned long ip,
 	return ip - rseq_cs->start_ip < rseq_cs->post_commit_offset;
 }
 
-static int rseq_ip_fixup(struct pt_regs *regs)
+static int rseq_ip_fixup(struct pt_regs *regs, bool abort)
 {
 	unsigned long ip = instruction_pointer(regs);
 	struct task_struct *t = current;
@@ -398,9 +388,11 @@ static int rseq_ip_fixup(struct pt_regs
 	 */
 	if (!in_rseq_cs(ip, &rseq_cs))
 		return clear_rseq_cs(t->rseq);
-	ret = rseq_need_restart(t, rseq_cs.flags);
-	if (ret <= 0)
+	ret = rseq_check_flags(t, rseq_cs.flags);
+	if (ret < 0)
 		return ret;
+	if (!abort)
+		return 0;
 	ret = clear_rseq_cs(t->rseq);
 	if (ret)
 		return ret;
@@ -430,14 +422,44 @@ void __rseq_handle_notify_resume(struct
 		return;
 
 	/*
-	 * regs is NULL if and only if the caller is in a syscall path.  Skip
-	 * fixup and leave rseq_cs as is so that rseq_sycall() will detect and
-	 * kill a misbehaving userspace on debug kernels.
+	 * If invoked from hypervisors or IO-URING, then @regs is a NULL
+	 * pointer, so fixup cannot be done. If the syscall which led to
+	 * this invocation was invoked inside a critical section, then it
+	 * will either end up in this code again or a possible violation of
+	 * a syscall inside a critical region can only be detected by the
+	 * debug code in rseq_syscall() in a debug enabled kernel.
 	 */
 	if (regs) {
-		ret = rseq_ip_fixup(regs);
-		if (unlikely(ret < 0))
-			goto error;
+		/*
+		 * Read and clear the event mask first. If the task was not
+		 * preempted or migrated or a signal is on the way, there
+		 * is no point in doing any of the heavy lifting here on
+		 * production kernels. In that case TIF_NOTIFY_RESUME was
+		 * raised by some other functionality.
+		 *
+		 * This is correct because the read/clear operation is
+		 * guarded against scheduler preemption, which makes it CPU
+		 * local atomic. If the task is preempted right after
+		 * re-enabling preemption then TIF_NOTIFY_RESUME is set
+		 * again and this function is invoked another time _before_
+		 * the task is able to return to user mode.
+		 *
+		 * On a debug kernel, invoke the fixup code unconditionally
+		 * with the result handed in to allow the detection of
+		 * inconsistencies.
+		 */
+		u32 event_mask;
+
+		scoped_guard(RSEQ_EVENT_GUARD) {
+			event_mask = t->rseq_event_mask;
+			t->rseq_event_mask = 0;
+		}
+
+		if (IS_ENABLED(CONFIG_DEBUG_RSEQ) || event_mask) {
+			ret = rseq_ip_fixup(regs, !!event_mask);
+			if (unlikely(ret < 0))
+				goto error;
+		}
 	}
 	if (unlikely(rseq_update_cpu_node_id(t)))
 		goto error;


