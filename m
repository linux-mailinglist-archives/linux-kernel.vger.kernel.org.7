Return-Path: <linux-kernel+bounces-871116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCB8C0C76C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AC054F2C6D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53D2313552;
	Mon, 27 Oct 2025 08:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pRGQunpo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AFPa6HmB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589B02F3629
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554724; cv=none; b=XQ0UnQMxXgIP1x1QfB5f8PwkbfwUDhzbJzqrQDABOvWo6sxgMCk/eqmk1r6oxzVdBuuFvVF9rhemNorwJ4cs2BP4wgWvVjC6vz5ukbA9E7UIau3X1qaMlejT6/8HGCpISmf/groibdbSwCecW5lu87LypD7eJKvHfVQR3ychYyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554724; c=relaxed/simple;
	bh=stuvbCCRHen5rU0h5kcU2gH7NuE3Tvr4q3SxvtDpVe8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=eApwy6Mpn4gqG0ACccWZ5D1TxgngLfoEa8Koa/UHtflUdqcq7k5YjauAhPzhAaXsMqzs0GNDsa4QYrySNJ6I9Wi5s2uj00buKRdB+vhbzkpsM4wQfEiF9Ux+N/YR8VmhmP2Av9ENm4gCHQdpLCVj+RLzoUEf1we0IQOQeGblOVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pRGQunpo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AFPa6HmB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251027084307.701201365@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761554721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Rj4rBVjacSEtwLc/Ezk5zbbwdTGsIv5IIEIqDrCdNqE=;
	b=pRGQunpo5DbWZ4SKYYnWeRTpnBqtARMycQc1M3VNVrkDls8htmzxBWrCqCIe0zgBt7IDIK
	ylH86lJE/RJFUC96cUczxC5tXQfFI/ODMM3lHuy/NYkBz+BGfuxOnLLM9+uTGiAMGKInul
	UXUDOYL/3QXksh7JKasvvkZ6lviccAAHeaRszDnzeUVk5HiUafTgJ3bIH445FtYZ07kqXf
	NKZWH/cBfjnuPFF05JzaJim1jXIpg5mmLF4TnOzHL0MhLy6e6MMUV0f2O5nXRNmkJYl7/k
	8kwagbP0jIiJEUaJ9tWFsTHVKO57IzHJPMvDWlkJvoqs6eNgT56rM1duMej/pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761554721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Rj4rBVjacSEtwLc/Ezk5zbbwdTGsIv5IIEIqDrCdNqE=;
	b=AFPa6HmB8XrhzzLjzRAGhnc/2b9Tvrv8rNOruuO9jo6BVHeeUGRREci+9wToTI41TnlAOz
	Ptaxfrz6Auou0rBw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 x86@kernel.org,
 Sean Christopherson <seanjc@google.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [patch V6 28/31] rseq: Switch to fast path processing on exit to user
References: <20251027084220.785525188@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Oct 2025 09:45:19 +0100 (CET)

Now that all bits and pieces are in place, hook the RSEQ handling fast path
function into exit_to_user_mode_prepare() after the TIF work bits have been
handled. If case of fast path failure, TIF_NOTIFY_RESUME has been raised
and the caller needs to take another turn through the TIF handling slow
path.

This only works for architectures which use the generic entry code.
Architectures who still have their own incomplete hacks are not supported
and won't be.

This results in the following improvements:

  Kernel build	       Before		  After		      Reduction
		       
  exit to user         80692981		  80514451      
  signal checks:          32581		       121	       99%
  slowpath runs:        1201408   1.49%	       198 0.00%      100%
  fastpath runs:           	  	    675941 0.84%       N/A
  id updates:           1233989   1.53%	     50541 0.06%       96%
  cs checks:            1125366   1.39%	         0 0.00%      100%
    cs cleared:         1125366      100%	 0            100%
    cs fixup:                 0        0%	 0      

  RSEQ selftests      Before		  After		      Reduction

  exit to user:       386281778		  387373750       
  signal checks:       35661203		          0           100%
  slowpath runs:      140542396 36.38%	        100  0.00%    100%
  fastpath runs:           	  	    9509789  2.51%     N/A
  id updates:         176203599 45.62%	    9087994  2.35%     95%
  cs checks:          175587856 45.46%	    4728394  1.22%     98%
    cs cleared:       172359544   98.16%    1319307   27.90%   99% 
    cs fixup:           3228312    1.84%    3409087   72.10%

The 'cs cleared' and 'cs fixup' percentages are not relative to the exit to
user invocations, they are relative to the actual 'cs check' invocations.

While some of this could have been avoided in the original code, like the
obvious clearing of CS when it's already clear, the main problem of going
through TIF_NOTIFY_RESUME cannot be solved. In some workloads the RSEQ
notify handler is invoked more than once before going out to user
space. Doing this once when everything has stabilized is the only solution
to avoid this.

The initial attempt to completely decouple it from the TIF work turned out
to be suboptimal for workloads, which do a lot of quick and short system
calls. Even if the fast path decision is only 4 instructions (including a
conditional branch), this adds up quickly and becomes measurable when the
rate for actually having to handle rseq is in the low single digit
percentage range of user/kernel transitions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
V4: Move the rseq handling into a separate loop to avoid gotos later on
---
 include/linux/irq-entry-common.h |    7 ++-----
 include/linux/resume_user_mode.h |    2 +-
 include/linux/rseq.h             |   18 ++++++++++++------
 init/Kconfig                     |    2 +-
 kernel/entry/common.c            |   26 +++++++++++++++++++-------
 kernel/rseq.c                    |    8 ++++++--
 6 files changed, 41 insertions(+), 22 deletions(-)
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -197,11 +197,8 @@ static __always_inline void arch_exit_to
  */
 void arch_do_signal_or_restart(struct pt_regs *regs);
 
-/**
- * exit_to_user_mode_loop - do any pending work before leaving to user space
- */
-unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
-				     unsigned long ti_work);
+/* Handle pending TIF work */
+unsigned long exit_to_user_mode_loop(struct pt_regs *regs, unsigned long ti_work);
 
 /**
  * exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
--- a/include/linux/resume_user_mode.h
+++ b/include/linux/resume_user_mode.h
@@ -59,7 +59,7 @@ static inline void resume_user_mode_work
 	mem_cgroup_handle_over_high(GFP_KERNEL);
 	blkcg_maybe_throttle_current();
 
-	rseq_handle_notify_resume(regs);
+	rseq_handle_slowpath(regs);
 }
 
 #endif /* LINUX_RESUME_USER_MODE_H */
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -7,13 +7,19 @@
 
 #include <uapi/linux/rseq.h>
 
-void __rseq_handle_notify_resume(struct pt_regs *regs);
+void __rseq_handle_slowpath(struct pt_regs *regs);
 
-static inline void rseq_handle_notify_resume(struct pt_regs *regs)
+/* Invoked from resume_user_mode_work() */
+static inline void rseq_handle_slowpath(struct pt_regs *regs)
 {
-	/* '&' is intentional to spare one conditional branch */
-	if (current->rseq.event.sched_switch & current->rseq.event.has_rseq)
-		__rseq_handle_notify_resume(regs);
+	if (IS_ENABLED(CONFIG_GENERIC_ENTRY)) {
+		if (current->rseq.event.slowpath)
+			__rseq_handle_slowpath(regs);
+	} else {
+		/* '&' is intentional to spare one conditional branch */
+		if (current->rseq.event.sched_switch & current->rseq.event.has_rseq)
+			__rseq_handle_slowpath(regs);
+	}
 }
 
 void __rseq_signal_deliver(int sig, struct pt_regs *regs);
@@ -152,7 +158,7 @@ static inline void rseq_fork(struct task
 }
 
 #else /* CONFIG_RSEQ */
-static inline void rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs) { }
+static inline void rseq_handle_slowpath(struct pt_regs *regs) { }
 static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs) { }
 static inline void rseq_sched_switch_event(struct task_struct *t) { }
 static inline void rseq_sched_set_task_cpu(struct task_struct *t, unsigned int cpu) { }
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1941,7 +1941,7 @@ config RSEQ_DEBUG_DEFAULT_ENABLE
 config DEBUG_RSEQ
 	default n
 	bool "Enable debugging of rseq() system call" if EXPERT
-	depends on RSEQ && DEBUG_KERNEL
+	depends on RSEQ && DEBUG_KERNEL && !GENERIC_ENTRY
 	select RSEQ_DEBUG_DEFAULT_ENABLE
 	help
 	  Enable extra debugging checks for the rseq system call.
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -11,13 +11,8 @@
 /* Workaround to allow gradual conversion of architecture code */
 void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
 
-/**
- * exit_to_user_mode_loop - do any pending work before leaving to user space
- * @regs:	Pointer to pt_regs on entry stack
- * @ti_work:	TIF work flags as read by the caller
- */
-__always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
-						     unsigned long ti_work)
+static __always_inline unsigned long __exit_to_user_mode_loop(struct pt_regs *regs,
+							      unsigned long ti_work)
 {
 	/*
 	 * Before returning to user space ensure that all pending work
@@ -62,6 +57,23 @@ void __weak arch_do_signal_or_restart(st
 	return ti_work;
 }
 
+/**
+ * exit_to_user_mode_loop - do any pending work before leaving to user space
+ * @regs:	Pointer to pt_regs on entry stack
+ * @ti_work:	TIF work flags as read by the caller
+ */
+__always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
+						     unsigned long ti_work)
+{
+	for (;;) {
+		ti_work = __exit_to_user_mode_loop(regs, ti_work);
+
+		if (likely(!rseq_exit_to_user_mode_restart(regs)))
+			return ti_work;
+		ti_work = read_thread_flags();
+	}
+}
+
 noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 {
 	irqentry_state_t ret = {
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -237,7 +237,11 @@ static bool rseq_handle_cs(struct task_s
 
 static void rseq_slowpath_update_usr(struct pt_regs *regs)
 {
-	/* Preserve rseq state and user_irq state for exit to user */
+	/*
+	 * Preserve rseq state and user_irq state. The generic entry code
+	 * clears user_irq on the way out, the non-generic entry
+	 * architectures are not having user_irq.
+	 */
 	const struct rseq_event evt_mask = { .has_rseq = true, .user_irq = true, };
 	struct task_struct *t = current;
 	struct rseq_ids ids;
@@ -289,7 +293,7 @@ static void rseq_slowpath_update_usr(str
 	}
 }
 
-void __rseq_handle_notify_resume(struct pt_regs *regs)
+void __rseq_handle_slowpath(struct pt_regs *regs)
 {
 	/*
 	 * If invoked from hypervisors before entering the guest via


