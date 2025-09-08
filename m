Return-Path: <linux-kernel+bounces-806815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D08B49C14
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF46F4E8116
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A892E1EF8;
	Mon,  8 Sep 2025 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QuVOLxNM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZrGc7kIy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE6831E0FB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367143; cv=none; b=SHoj3fE2QNuT9DfFq8luJSu7pJcv4PiPmiv9LbI3QrRfXAOhswbupnjsL+UmQvbAcLfRL2vaOdYZaRMa268hozoW//QoAP11DeUJJqsXK1bMrE7waDkTjSGXtW9QA3kBW7rIBCxTcuZaFERTAHW1MVph2odSFD5uZj22BIP6heA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367143; c=relaxed/simple;
	bh=vKxtL+J44DulhzzibWbziZ80QTOPCP2aHvpG2WsDPn4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=WXsVknQ9Xezl4awSSsH14vri26O1notf7AG7SWwOh3t6Y05brS026X8sUl7fU69wjyVS9Vy7ZjeGuESc0jjT1vgQb3nwsjJezbbhxkK3q/P1Q8kdnbfA+NQSM92jvT0az07fh/YEUKfK03H5wNrtdNaDSxSAViH2tSFClYI7D4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QuVOLxNM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZrGc7kIy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908212926.929787629@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757367140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=rY41R3ZIhE2X0kuKLXcm/o700ml/k8IwWeLUJN7fZqc=;
	b=QuVOLxNMCCZUc1W4CQqXgrmKAZK06NPF61Bs4d7qm3JhNs7AFURN9/Oo0S13lAyNjhFq8q
	J9ZlPjYiYhWtc554SsJ+lwnaNMKO0w6Bl+ybJquNHhoMsswewfIGlCCPN54/yK/ZxLK3Li
	t4cdeH+ewvcL4lrirw9Umjmlky6kIpvq2P8Eklf9q/b60erGmNS06cNhnvrVDjnMX1YYuO
	BmtyuV6RSXlemBbdwZyGaIgTNAgAnO06krUz2kKKMfcCTK0iqjWa1mV8fY85zu/1LNGOjn
	SCzEeoDYSuhjCDiMPSesuQPZOQhoDHEuku5qovqIGVAYVa28XW09z4NWflmr2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757367140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=rY41R3ZIhE2X0kuKLXcm/o700ml/k8IwWeLUJN7fZqc=;
	b=ZrGc7kIyUJ0EwR4oGypMb0y1Wr00bz3KNwvL93IahbFpSQSTpMQhnwZBfVsA+t6fqrZQZF
	ZlbOvupPpn3n/nDA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [patch V4 26/36] rseq: Optimize event setting
References: <20250908212737.353775467@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  8 Sep 2025 23:32:19 +0200 (CEST)

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
@@ -9,7 +9,8 @@ void __rseq_handle_notify_resume(struct
 
 static inline void rseq_handle_notify_resume(struct pt_regs *regs)
 {
-	if (current->rseq.event.has_rseq)
+	/* '&' is intentional to spare one conditional branch */
+	if (current->rseq.event.sched_switch & current->rseq.event.has_rseq)
 		__rseq_handle_notify_resume(regs);
 }
 
@@ -31,12 +32,75 @@ static inline void rseq_signal_deliver(s
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
 
@@ -53,7 +117,7 @@ static inline void rseq_sched_switch_eve
 static inline void rseq_virt_userspace_exit(void)
 {
 	if (current->rseq.event.sched_switch)
-		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
+		rseq_raise_notify_resume(current);
 }
 
 static inline void rseq_reset(struct task_struct *t)
@@ -85,6 +149,9 @@ static inline void rseq_fork(struct task
 static inline void rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs) { }
 static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs) { }
 static inline void rseq_sched_switch_event(struct task_struct *t) { }
+static inline void rseq_sched_set_task_cpu(struct task_struct *t, unsigned int cpu) { }
+static inline void rseq_sched_set_task_mm_cid(struct task_struct *t, unsigned int cid) { }
+static inline void rseq_force_update(void) { }
 static inline void rseq_virt_userspace_exit(void) { }
 static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags) { }
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
@@ -456,7 +456,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
 	 * are updated before returning to user-space.
 	 */
 	current->rseq.event.has_rseq = true;
-	rseq_sched_switch_event(current);
+	rseq_force_update();
 
 	return 0;
 }
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5150,7 +5150,6 @@ prepare_task_switch(struct rq *rq, struc
 	kcov_prepare_switch(prev);
 	sched_info_switch(rq, prev, next);
 	perf_event_task_sched_out(prev, next);
-	rseq_sched_switch_event(prev);
 	fire_sched_out_preempt_notifiers(prev, next);
 	kmap_local_sched_out();
 	prepare_task(next);
@@ -5348,6 +5347,12 @@ context_switch(struct rq *rq, struct tas
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
@@ -2181,6 +2181,7 @@ static inline void __set_task_cpu(struct
 	smp_wmb();
 	WRITE_ONCE(task_thread_info(p)->cpu, cpu);
 	p->wake_cpu = cpu;
+	rseq_sched_set_task_cpu(p, cpu);
 #endif /* CONFIG_SMP */
 }
 
@@ -3778,8 +3779,10 @@ static inline void switch_mm_cid(struct
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


