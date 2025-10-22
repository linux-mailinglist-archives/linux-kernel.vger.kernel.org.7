Return-Path: <linux-kernel+bounces-864996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 285FABFC01A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 660A0560C6F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF7F34EF04;
	Wed, 22 Oct 2025 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ATo2pD3c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9vpSctq8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246A434B675
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137568; cv=none; b=qMekM0vJgGLMP4p+Rt5OTy5E6TChv7HPRvfwMD3km8G4M5FnQJ7Znodqcoikl7Fz5/YtYvGBjELh9VBBj9sH0DEznSklGR8mTgni5bu4BORPZ18W+VutOndlir3g/RYuwJTJliK0bzQE2Iq2sBFjp0U0Ur797N23lXaJzjvTh3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137568; c=relaxed/simple;
	bh=MLJlR5gDufQoHuLihUB41vDLrVPi96PJBglzaw+py24=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=FD22GC6yaxRgbuSzb17WVN+w4nUWSJFWuSm4ecoIEb/S6LKv85cKCRBUzgGctb6X1YFkNfWt7FSi83UnffDK+9sxX2Vi3EwR1gmkf440QMPTARTpbS65QBLIntS2WLFtIepXf+7LtcMTjd8kjvCn41qdubCZTi/+rAkI82rHSJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ATo2pD3c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9vpSctq8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022121943.350650141@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=tSfZiFEU/OVr8nUKt3URejIK7nghCq2swoGI8UYKJ6w=;
	b=ATo2pD3cc94Ve+92T/JJpNprDOhR/dU51r6nYYtULqbUaNsJLoIpRoE2V+kqGNyY9yhfHI
	nyS0mLBQnY6nHrAznneqCM1+eNahYsmA87INSnVEYZMs8pJTtgG2riEt1hLxonMSbauYzz
	0QWwluo2pSNwl3PSysis9vYz7aVti/ZZtInrOQ91HR4N8zIHGA9pGP/sEOXt02D214GYL3
	au20K249U23sl755R414jIZ7Zl71zo91a7awBPxzPwl3rnrTsB86JVeC1gt+OyTJR038+w
	IToJHNfG+RYdZ8fxlyiI4mxS56mQeAY2tRs7GLf29PBnoV9lzpQwWxX2rbL+ZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=tSfZiFEU/OVr8nUKt3URejIK7nghCq2swoGI8UYKJ6w=;
	b=9vpSctq8i+3gLEf90trcF39l4dRa0z/mBqwFRUB/kaI9Ljxw8N6/9t99QSAHnUQKKrsx5R
	wlw55TqQENW/yxAA==
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
Subject: [patch V5 31/31] rseq: Switch to TIF_RSEQ if supported
References: <20251022121836.019469732@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:52:39 +0200 (CEST)

TIF_NOTIFY_RESUME is a multiplexing TIF bit, which is suboptimal especially
with the RSEQ fast path depending on it, but not really handling it.

Define a seperate TIF_RSEQ in the generic TIF space and enable the full
seperation of fast and slow path for architectures which utilize that.

That avoids the hassle with invocations of resume_user_mode_work() from
hypervisors, which clear TIF_NOTIFY_RESUME. It makes the therefore required
re-evaluation at the end of vcpu_run() a NOOP on architectures which
utilize the generic TIF space and have a seperate TIF_RSEQ.

The hypervisor TIF handling does not include the seperate TIF_RSEQ as there
is no point in doing so. The guest does neither know nor care about the VMM
host applications RSEQ state. That state is only relevant when the ioctl()
returns to user space.

The fastpath implementation still utilizes TIF_NOTIFY_RESUME for failure
handling, but this only happens within exit_to_user_mode_loop(), so
arguably the hypervisor ioctl() code is long done when this happens.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

---
V4: Adjust it to the new outer loop mechanism

V3: Updated the comment for rseq_virt_userspace_exit() - Sean
    Added a static assert for TIF_RSEQ != TIF_NOTIFY_RESUME - Sean
---
 include/asm-generic/thread_info_tif.h |    3 +++
 include/linux/irq-entry-common.h      |    2 +-
 include/linux/rseq.h                  |   22 +++++++++++++++-------
 include/linux/rseq_entry.h            |   27 +++++++++++++++++++++++++--
 include/linux/thread_info.h           |    5 +++++
 kernel/entry/common.c                 |   10 ++++++++--
 6 files changed, 57 insertions(+), 12 deletions(-)
--- a/include/asm-generic/thread_info_tif.h
+++ b/include/asm-generic/thread_info_tif.h
@@ -45,4 +45,7 @@
 # define _TIF_RESTORE_SIGMASK	BIT(TIF_RESTORE_SIGMASK)
 #endif
 
+#define TIF_RSEQ		11	// Run RSEQ fast path
+#define _TIF_RSEQ		BIT(TIF_RSEQ)
+
 #endif /* _ASM_GENERIC_THREAD_INFO_TIF_H_ */
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -30,7 +30,7 @@
 #define EXIT_TO_USER_MODE_WORK						\
 	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
 	 _TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY |			\
-	 _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |			\
+	 _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL | _TIF_RSEQ |		\
 	 ARCH_EXIT_TO_USER_MODE_WORK)
 
 /**
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -42,7 +42,7 @@ static inline void rseq_signal_deliver(s
 
 static inline void rseq_raise_notify_resume(struct task_struct *t)
 {
-	set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
+	set_tsk_thread_flag(t, TIF_RSEQ);
 }
 
 /* Invoked from context switch to force evaluation on exit to user */
@@ -114,17 +114,25 @@ static inline void rseq_force_update(voi
 
 /*
  * KVM/HYPERV invoke resume_user_mode_work() before entering guest mode,
- * which clears TIF_NOTIFY_RESUME. To avoid updating user space RSEQ in
- * that case just to do it eventually again before returning to user space,
- * the entry resume_user_mode_work() invocation is ignored as the register
- * argument is NULL.
+ * which clears TIF_NOTIFY_RESUME on architectures that don't use the
+ * generic TIF bits and therefore can't provide a separate TIF_RSEQ flag.
  *
- * After returning from guest mode, they have to invoke this function to
- * re-raise TIF_NOTIFY_RESUME if necessary.
+ * To avoid updating user space RSEQ in that case just to do it eventually
+ * again before returning to user space, because __rseq_handle_slowpath()
+ * does nothing when invoked with NULL register state.
+ *
+ * After returning from guest mode, before exiting to userspace, hypervisors
+ * must invoke this function to re-raise TIF_NOTIFY_RESUME if necessary.
  */
 static inline void rseq_virt_userspace_exit(void)
 {
 	if (current->rseq.event.sched_switch)
+	/*
+	 * The generic optimization for deferring RSEQ updates until the next
+	 * exit relies on having a dedicated TIF_RSEQ.
+	 */
+	if (!IS_ENABLED(CONFIG_HAVE_GENERIC_TIF_BITS) &&
+	    current->rseq.event.sched_switch)
 		rseq_raise_notify_resume(current);
 }
 
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -507,13 +507,36 @@ static __always_inline bool __rseq_exit_
 	return false;
 }
 
-static __always_inline bool rseq_exit_to_user_mode_restart(struct pt_regs *regs)
+/* Required to allow conversion to GENERIC_ENTRY w/o GENERIC_TIF_BITS */
+#ifdef CONFIG_HAVE_GENERIC_TIF_BITS
+static __always_inline bool test_tif_rseq(unsigned long ti_work)
 {
+	return ti_work & _TIF_RSEQ;
+}
+
+static __always_inline void clear_tif_rseq(void)
+{
+	static_assert(TIF_RSEQ != TIF_NOTIFY_RESUME);
+	clear_thread_flag(TIF_RSEQ);
+}
+#else
+static __always_inline bool test_tif_rseq(unsigned long ti_work) { return true; }
+static __always_inline void clear_tif_rseq(void) { }
+#endif
+
+static __always_inline bool
+rseq_exit_to_user_mode_restart(struct pt_regs *regs, unsigned long ti_work)
+{
+	if (likely(!test_tif_rseq(ti_work)))
+		return false;
+
 	if (unlikely(__rseq_exit_to_user_mode_restart(regs))) {
 		current->rseq.event.slowpath = true;
 		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
 		return true;
 	}
+
+	clear_tif_rseq();
 	return false;
 }
 
@@ -557,7 +580,7 @@ static inline void rseq_debug_syscall_re
 }
 #else /* CONFIG_RSEQ */
 static inline void rseq_note_user_irq_entry(void) { }
-static inline bool rseq_exit_to_user_mode_restart(struct pt_regs *regs)
+static inline bool rseq_exit_to_user_mode_restart(struct pt_regs *regs, unsigned long ti_work)
 {
 	return false;
 }
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -67,6 +67,11 @@ enum syscall_work_bit {
 #define _TIF_NEED_RESCHED_LAZY _TIF_NEED_RESCHED
 #endif
 
+#ifndef TIF_RSEQ
+# define TIF_RSEQ	TIF_NOTIFY_RESUME
+# define _TIF_RSEQ	_TIF_NOTIFY_RESUME
+#endif
+
 #ifdef __KERNEL__
 
 #ifndef arch_set_restart_data
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -11,6 +11,12 @@
 /* Workaround to allow gradual conversion of architecture code */
 void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
 
+#ifdef CONFIG_HAVE_GENERIC_TIF_BITS
+#define EXIT_TO_USER_MODE_WORK_LOOP	(EXIT_TO_USER_MODE_WORK & ~_TIF_RSEQ)
+#else
+#define EXIT_TO_USER_MODE_WORK_LOOP	(EXIT_TO_USER_MODE_WORK)
+#endif
+
 static __always_inline unsigned long __exit_to_user_mode_loop(struct pt_regs *regs,
 							      unsigned long ti_work)
 {
@@ -18,7 +24,7 @@ static __always_inline unsigned long __e
 	 * Before returning to user space ensure that all pending work
 	 * items have been completed.
 	 */
-	while (ti_work & EXIT_TO_USER_MODE_WORK) {
+	while (ti_work & EXIT_TO_USER_MODE_WORK_LOOP) {
 
 		local_irq_enable_exit_to_user(ti_work);
 
@@ -68,7 +74,7 @@ static __always_inline unsigned long __e
 	for (;;) {
 		ti_work = __exit_to_user_mode_loop(regs, ti_work);
 
-		if (likely(!rseq_exit_to_user_mode_restart(regs)))
+		if (likely(!rseq_exit_to_user_mode_restart(regs, ti_work)))
 			return ti_work;
 		ti_work = read_thread_flags();
 	}


