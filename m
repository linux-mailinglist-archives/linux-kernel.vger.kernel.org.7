Return-Path: <linux-kernel+bounces-871119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1E1C0C772
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 141654F6E43
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742E62F6910;
	Mon, 27 Oct 2025 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aQ7VYtha";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="99+iJSC2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB632F3C1A
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554732; cv=none; b=oAwoUx+3oajn47Q/yO1+jXKAjRPC04bXQLfc/4xCXWRx9CFEIUoCN3zIXl0jFHUbE0xB1g7a6lMlg+dceDdJrhPrtLLvhV6F5YDEB0orRs6/WpTA4tFva2o04i/EN2DhrC52qPLcyKHgsLexXhFe3pASk6XiYc9UVGYZoPBoZps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554732; c=relaxed/simple;
	bh=MLJlR5gDufQoHuLihUB41vDLrVPi96PJBglzaw+py24=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=VzXPHSY0brTezjYi2h9aRsSvmgnez/eBiVqSss4msjgGr4Cdae5Yqg3KmyEy7VI7gXKJtWlja45uJcaMGSss4KWWs1/ig6URe7548DX79OcaLgHPpRwY8MZhk8Q1ew9jtKPq2Z+4HMsoqq2IwvHzYojuoi4piixlK6ES2yy0W2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aQ7VYtha; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=99+iJSC2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251027084307.903622031@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761554727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=tSfZiFEU/OVr8nUKt3URejIK7nghCq2swoGI8UYKJ6w=;
	b=aQ7VYtha/J7Ywu1ewiv8XNXJLpra9q5WM6Wa0yBpuW4yfdT0TivTGmgxuzvBIYt2tCLBPn
	MYG8F7LVO/044FKcybgo7/PHAKkrkuUC5hq2+/DcMOg3mEPs03DvgUI6Z1gt7Q9zYG/CJ9
	yAxYOu1eeoEYhguZ8Jt9e+rF6VwpUdbOA164Pzl+XNVTgIuDE20E3Z/vpj/X4KLq1CXe7U
	HEHx7f0FZkFvHgecqMkQgyCldE1b/fb10GHx9LqG7yYtwxO0FzTk1Dnr6bAPX2ye+Iw7Kl
	zP7d9dCNM4X/PVuegOyn3wE0bLchz7Bi/hLpIv5C9lLsVVCXC93b8hpty7RJsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761554727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=tSfZiFEU/OVr8nUKt3URejIK7nghCq2swoGI8UYKJ6w=;
	b=99+iJSC2kim8Zb8jdzIUm4ScIVeLRLHxBuW1q22xF4MPd+gB7W2obGy7fUIbghGmwCKo2M
	ZrWC1kq3MTEx1KCg==
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
Subject: [patch V6 31/31] rseq: Switch to TIF_RSEQ if supported
References: <20251027084220.785525188@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Oct 2025 09:45:26 +0100 (CET)

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


