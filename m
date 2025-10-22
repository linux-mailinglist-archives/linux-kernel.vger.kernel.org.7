Return-Path: <linux-kernel+bounces-864995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D204BBFC068
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A05B624346
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB7034EF1D;
	Wed, 22 Oct 2025 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RAtV22y+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nwkeuh74"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC76B34C816
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137567; cv=none; b=F8ndg5aw7loGBJzR0wr1k/KbMJJCVK6C7tp4tgsMt2AvR2S6bz3YHQcEWZm9GXTxYj9snLrhJU1OI3iRmK8kyHTNVrDTqFroeDLqWOoOKzw90EA/CMMavFd+9jCq/p6ooPspGJF/JkIo8WI48nACL3G7PsQfD1H3aWqUJ/Xis2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137567; c=relaxed/simple;
	bh=stuvbCCRHen5rU0h5kcU2gH7NuE3Tvr4q3SxvtDpVe8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=tDlOSVRWRAdNotCNHK3PW0ufgeXue7a2jmbEeSJRsQ+4bAedLWe4R5HWU79kas0S664iRebRUyB/Pb8RtpHd72Q2/AClneostm+NYpeCdHvXmezOlNHEqHxd9i3+V90WQI0CpfaK5KGVHsPBB1kwyRubPiPJY/ikbc8zqcKiqI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RAtV22y+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nwkeuh74; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022121943.156913457@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Rj4rBVjacSEtwLc/Ezk5zbbwdTGsIv5IIEIqDrCdNqE=;
	b=RAtV22y+p39RiZTSpfOfqPwa3eKpR+EneHiyrT7kZo87BP3PJ40v8muA8LwCBgs1vdAzfR
	ClivuPT6Ut7I3yflzNVlDwOZerVrJQdFieZwe8erHXh04JDilfgbsgaxRBmDKI2m+7MHTE
	/CjcdLLGj37kUDA0SpjcFpqF538aduJpHJGAjYB+LiWOMSBR7iOzLgN6UrZp2tQQWywtGs
	2Mm2H4czxo/fKNfpLjhkgZ/HQqq/35th3l5kS5Fom12DfwuhjPL0B9q/jkjWFb1cye94D3
	dZVyANdLglmN5FjI1542DVo6lVnfSy2MSVc2BS3dS3nbWm2NTMKxRnROg0dcKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Rj4rBVjacSEtwLc/Ezk5zbbwdTGsIv5IIEIqDrCdNqE=;
	b=Nwkeuh741o46x9CkDAspy/L0xiTn5ZqMLfQMIBBgjvwx+6+It7fBa5g4drUkVUTI9fuH2i
	dc8a0ipbVeSqwRBA==
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
Subject: [patch V5 28/31] rseq: Switch to fast path processing on exit to user
References: <20251022121836.019469732@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:52:35 +0200 (CEST)

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


