Return-Path: <linux-kernel+bounces-871114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E069C0C724
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9330C34BA8E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4F23128C3;
	Mon, 27 Oct 2025 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2wxda8+Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9SL1dc4q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA9831327F
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554719; cv=none; b=X9HSUy510gJinxTDzl4/jZRAMyQFkOKitN9yxPpg7qkDFGu/ROPtgbL0fDLTIkA2N2DStqvsozjDT8Dx0dTIO0c7LCr16wA7I8XE0KQlRIlx+8HgDMlOkUHBszsFWTaO6ruvBKnPSMgT7xYmjyB0tQcnwIG8w3cQK7UBWT6OamA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554719; c=relaxed/simple;
	bh=9LMXBBAxxTSh0Cak5VnRRSiVJ2tUu9kEJ+tOhuQHm/s=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=XQGlaaMepY5Uqr+/vsz9E2RcwUTMQ+hDwzsfp6zDH0/lonrXsrU54Y2zTTlvk5tlKepgv2VHqmHMGcJv34HUfS8+z/ghIg+Cx70RLtJvmbObKL+rdnbrlke9g2lcUs82885wQdwGVfMaQPgKX6FQn9ldpCJh59xXO32qesAw3Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2wxda8+Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9SL1dc4q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251027084307.578058898@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761554716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=fZ58n7hDIlsn/xa1KokOzN/ruflAy964N/XrMGvhoZc=;
	b=2wxda8+ZyouHdTS/DiGD4yqJcK8hyIA8o8KrdqQpyNfjch2Z1EmPwvqkS6I7l964z+iS+C
	rKwF9Fm98C5wONSQC2hDV5J/+btI84Qx1kdEcienF1n0lK7gu0bj2eICKsnsNjlkQC5L1Z
	36KHCgbc1KIkGOpTAJ0Kfej3iVmrdpV8j1IFJrIA1kzCYV0TYS/vwl6QEJ365o/gowA0Rf
	ZlmoAxI7WYGaGd3AFkrxFBZ+0iY+6qRBbOf6zBYSWUYoYotK9vwmJUJXpBHUiyDYRdTT1a
	0zO7m7jaFacqoTle68vOH2Ha/OfuURf1y3GAeAh1gF4k89uERjXXRt60L7kIGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761554716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=fZ58n7hDIlsn/xa1KokOzN/ruflAy964N/XrMGvhoZc=;
	b=9SL1dc4qZA8RU6Gv7XaLyO3tllIpdlE7fu7ocNr1JB/2j679O/U87y/UDhaQl1fmY5cC3t
	MtX7Zdgwm+E8T4Aw==
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
Subject: [patch V6 26/31] rseq: Optimize event setting
References: <20251027084220.785525188@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Oct 2025 09:45:14 +0100 (CET)

After removing the various condition bits earlier it turns out that one
extra information is needed to avoid setting event::sched_switch and
TIF_NOTIFY_RESUME unconditionally on every context switch.

The update of the RSEQ user space memory is only required, when either

  the task was interrupted in user space and schedules

or

  the CPU or MM CID changes in schedule() independent of the entry mode

Right now only the interrupt from user information is available.

Add a event flag, which is set when the CPU or MM CID or both change.

Evaluate this event in the scheduler to decide whether the sched_switch
event and the TIF bit need to be set.

It's an extra conditional in context_switch(), but the downside of
unconditionally handling RSEQ after a context switch to user is way more
significant. The utilized boolean logic minimizes this to a single
conditional branch.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 fs/exec.c                  |    2 -
 include/linux/rseq.h       |   81 +++++++++++++++++++++++++++++++++++++++++----
 include/linux/rseq_types.h |   11 +++++-
 kernel/rseq.c              |    2 -
 kernel/sched/core.c        |    7 +++
 kernel/sched/sched.h       |    5 ++
 6 files changed, 95 insertions(+), 13 deletions(-)
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1775,7 +1775,7 @@ static int bprm_execve(struct linux_binp
 		force_fatal_sig(SIGSEGV);
 
 	sched_mm_cid_after_execve(current);
-	rseq_sched_switch_event(current);
+	rseq_force_update();
 	current->in_execve = 0;
 
 	return retval;
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -11,7 +11,8 @@ void __rseq_handle_notify_resume(struct
 
 static inline void rseq_handle_notify_resume(struct pt_regs *regs)
 {
-	if (current->rseq.event.has_rseq)
+	/* '&' is intentional to spare one conditional branch */
+	if (current->rseq.event.sched_switch & current->rseq.event.has_rseq)
 		__rseq_handle_notify_resume(regs);
 }
 
@@ -33,12 +34,75 @@ static inline void rseq_signal_deliver(s
 	}
 }
 
-/* Raised from context switch and exevce to force evaluation on exit to user */
-static inline void rseq_sched_switch_event(struct task_struct *t)
+static inline void rseq_raise_notify_resume(struct task_struct *t)
 {
-	if (t->rseq.event.has_rseq) {
-		t->rseq.event.sched_switch = true;
-		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
+	set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
+}
+
+/* Invoked from context switch to force evaluation on exit to user */
+static __always_inline void rseq_sched_switch_event(struct task_struct *t)
+{
+	struct rseq_event *ev = &t->rseq.event;
+
+	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY)) {
+		/*
+		 * Avoid a boat load of conditionals by using simple logic
+		 * to determine whether NOTIFY_RESUME needs to be raised.
+		 *
+		 * It's required when the CPU or MM CID has changed or
+		 * the entry was from user space.
+		 */
+		bool raise = (ev->user_irq | ev->ids_changed) & ev->has_rseq;
+
+		if (raise) {
+			ev->sched_switch = true;
+			rseq_raise_notify_resume(t);
+		}
+	} else {
+		if (ev->has_rseq) {
+			t->rseq.event.sched_switch = true;
+			rseq_raise_notify_resume(t);
+		}
+	}
+}
+
+/*
+ * Invoked from __set_task_cpu() when a task migrates to enforce an IDs
+ * update.
+ *
+ * This does not raise TIF_NOTIFY_RESUME as that happens in
+ * rseq_sched_switch_event().
+ */
+static __always_inline void rseq_sched_set_task_cpu(struct task_struct *t, unsigned int cpu)
+{
+	t->rseq.event.ids_changed = true;
+}
+
+/*
+ * Invoked from switch_mm_cid() in context switch when the task gets a MM
+ * CID assigned.
+ *
+ * This does not raise TIF_NOTIFY_RESUME as that happens in
+ * rseq_sched_switch_event().
+ */
+static __always_inline void rseq_sched_set_task_mm_cid(struct task_struct *t, unsigned int cid)
+{
+	/*
+	 * Requires a comparison as the switch_mm_cid() code does not
+	 * provide a conditional for it readily. So avoid excessive updates
+	 * when nothing changes.
+	 */
+	if (t->rseq.ids.mm_cid != cid)
+		t->rseq.event.ids_changed = true;
+}
+
+/* Enforce a full update after RSEQ registration and when execve() failed */
+static inline void rseq_force_update(void)
+{
+	if (current->rseq.event.has_rseq) {
+		current->rseq.event.ids_changed = true;
+		current->rseq.event.sched_switch = true;
+		rseq_raise_notify_resume(current);
 	}
 }
 
@@ -55,7 +119,7 @@ static inline void rseq_sched_switch_eve
 static inline void rseq_virt_userspace_exit(void)
 {
 	if (current->rseq.event.sched_switch)
-		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
+		rseq_raise_notify_resume(current);
 }
 
 static inline void rseq_reset(struct task_struct *t)
@@ -91,6 +155,9 @@ static inline void rseq_fork(struct task
 static inline void rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs) { }
 static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs) { }
 static inline void rseq_sched_switch_event(struct task_struct *t) { }
+static inline void rseq_sched_set_task_cpu(struct task_struct *t, unsigned int cpu) { }
+static inline void rseq_sched_set_task_mm_cid(struct task_struct *t, unsigned int cid) { }
+static inline void rseq_force_update(void) { }
 static inline void rseq_virt_userspace_exit(void) { }
 static inline void rseq_fork(struct task_struct *t, u64 clone_flags) { }
 static inline void rseq_execve(struct task_struct *t) { }
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -11,20 +11,27 @@ struct rseq;
  * struct rseq_event - Storage for rseq related event management
  * @all:		Compound to initialize and clear the data efficiently
  * @events:		Compound to access events with a single load/store
- * @sched_switch:	True if the task was scheduled out
+ * @sched_switch:	True if the task was scheduled and needs update on
+ *			exit to user
+ * @ids_changed:	Indicator that IDs need to be updated
  * @user_irq:		True on interrupt entry from user mode
  * @has_rseq:		True if the task has a rseq pointer installed
  * @error:		Compound error code for the slow path to analyze
  * @fatal:		User space data corrupted or invalid
+ *
+ * @sched_switch and @ids_changed must be adjacent and the combo must be
+ * 16bit aligned to allow a single store, when both are set at the same
+ * time in the scheduler.
  */
 struct rseq_event {
 	union {
 		u64				all;
 		struct {
 			union {
-				u16		events;
+				u32		events;
 				struct {
 					u8	sched_switch;
+					u8	ids_changed;
 					u8	user_irq;
 				};
 			};
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -465,7 +465,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
 	 * are updated before returning to user-space.
 	 */
 	current->rseq.event.has_rseq = true;
-	rseq_sched_switch_event(current);
+	rseq_force_update();
 	return 0;
 
 efault:
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5118,7 +5118,6 @@ prepare_task_switch(struct rq *rq, struc
 	kcov_prepare_switch(prev);
 	sched_info_switch(rq, prev, next);
 	perf_event_task_sched_out(prev, next);
-	rseq_sched_switch_event(prev);
 	fire_sched_out_preempt_notifiers(prev, next);
 	kmap_local_sched_out();
 	prepare_task(next);
@@ -5316,6 +5315,12 @@ context_switch(struct rq *rq, struct tas
 	/* switch_mm_cid() requires the memory barriers above. */
 	switch_mm_cid(rq, prev, next);
 
+	/*
+	 * Tell rseq that the task was scheduled in. Must be after
+	 * switch_mm_cid() to get the TIF flag set.
+	 */
+	rseq_sched_switch_event(next);
+
 	prepare_lock_switch(rq, next, rf);
 
 	/* Here we just switch the register state and the stack. */
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2208,6 +2208,7 @@ static inline void __set_task_cpu(struct
 	smp_wmb();
 	WRITE_ONCE(task_thread_info(p)->cpu, cpu);
 	p->wake_cpu = cpu;
+	rseq_sched_set_task_cpu(p, cpu);
 #endif /* CONFIG_SMP */
 }
 
@@ -3808,8 +3809,10 @@ static inline void switch_mm_cid(struct
 		mm_cid_put_lazy(prev);
 		prev->mm_cid = -1;
 	}
-	if (next->mm_cid_active)
+	if (next->mm_cid_active) {
 		next->last_mm_cid = next->mm_cid = mm_cid_get(rq, next, next->mm);
+		rseq_sched_set_task_mm_cid(next, next->mm_cid);
+	}
 }
 
 #else /* !CONFIG_SCHED_MM_CID: */


