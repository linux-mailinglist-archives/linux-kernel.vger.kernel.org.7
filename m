Return-Path: <linux-kernel+bounces-801742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8621DB44973
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B60B4E23E1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972572ECE9E;
	Thu,  4 Sep 2025 22:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rCc0EzO5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VSSh5QP7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3E32EC0AA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024450; cv=none; b=u3sqfm9mybZifs/dM5soLJZFm0BF8yRK1ee1rVpskSXr3rYLx/DLLuf+DvHUrEHsiWDTPHqZM4IVhzqps7+OeBZCICAaoURk2/WMyYgy0O3yajfV3JYaLToQ7i489cBearVJ+L1fLZy2PhnSwIRD9vkjuyqLXxa9HCodCLZ1iag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024450; c=relaxed/simple;
	bh=OnNhKFHS8ExljFGf/qn0pfZKo1fwWWRCS0cWZQEGLTg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Ge9fpwPjeURWdeEW27OYlBP520Fbo33qkLn4EA1u6eBxUiMVf5BGHqY3zaqm1zKg5/O2XaTqDNFw90kTXhhNLP+tMegz69aXN1k85nhJQfxYc6WhSgytoBQXYMQUio77CPxl7M8auqN2TRcDH5q8x0r65jSX6F/lJBBqNpylv28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rCc0EzO5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VSSh5QP7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250904185719.519152349@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757024446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=aOPpVZaoUmKKJP/fZcARIMUhQ8WMbifcNeVHtFmqu/g=;
	b=rCc0EzO50U7I8ETgQiTxfzm/JiuLFdv/PD8jjuTGeOb28E7RRwmtN+AnFbqWipb1/IwDsI
	u5nraplojhS4WnLdyhnC0tPzxfkaYdSLHf9Dut0CYtLQUO5ZCX38dnPdivr02DMdQU3wnb
	sYOx/zCQcRyeAEerMfGJYQ4XDP47ZoyQZ0+y/GOBgAdmzVuW+xtrqadUH+BgkPQivcDSnT
	XldIT40Yu9ILtjrbIh/dhD8w1pyvu/TJLxwxmL5VMflOhrd1oyMTZCfETY7D6owFaJrV9g
	tr3yJweOCmEXqVewABGJ0STB8+yDzobiSvCQZaL31nGVmt2cNySdm/xlwTX/UQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757024446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=aOPpVZaoUmKKJP/fZcARIMUhQ8WMbifcNeVHtFmqu/g=;
	b=VSSh5QP7UXc6oEpf6lLmQ5mKHIJ2w3tGjsS9HQdK5i7GmsFEoKMZCqwM+faRUIsheixWgo
	+DuMDYH/BHpF1lAw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
Subject: [patch V3 06/37] rseq: Simplify the event notification
References: <20250904185336.943880027@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  5 Sep 2025 00:20:45 +0200 (CEST)

Since commit 0190e4198e47 ("rseq: Deprecate RSEQ_CS_FLAG_NO_RESTART_ON_*
flags") the bits in task::rseq_event_mask are meaningless and just extra
work in terms of setting them individually.

Aside of that the only relevant point where an event has to be raised is
context switch. Neither the CPU nor MM CID can change without going through
a context switch.

Collapse them all into a single boolean which simplifies the code a lot and
remove the pointless invocations which have been sprinkled all over the
place for no value.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>

---
V2: Reduce it to the sched switch event.
---
 fs/exec.c                 |    2 -
 include/linux/rseq.h      |   66 +++++++++-------------------------------------
 include/linux/sched.h     |   10 +++---
 include/uapi/linux/rseq.h |   21 ++++----------
 kernel/rseq.c             |   28 +++++++++++--------
 kernel/sched/core.c       |    5 ---
 kernel/sched/membarrier.c |    8 ++---
 7 files changed, 48 insertions(+), 92 deletions(-)
---

--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1775,7 +1775,7 @@ static int bprm_execve(struct linux_binp
 		force_fatal_sig(SIGSEGV);
 
 	sched_mm_cid_after_execve(current);
-	rseq_set_notify_resume(current);
+	rseq_sched_switch_event(current);
 	current->in_execve = 0;
 
 	return retval;
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -3,38 +3,8 @@
 #define _LINUX_RSEQ_H
 
 #ifdef CONFIG_RSEQ
-
-#include <linux/preempt.h>
 #include <linux/sched.h>
 
-#ifdef CONFIG_MEMBARRIER
-# define RSEQ_EVENT_GUARD	irq
-#else
-# define RSEQ_EVENT_GUARD	preempt
-#endif
-
-/*
- * Map the event mask on the user-space ABI enum rseq_cs_flags
- * for direct mask checks.
- */
-enum rseq_event_mask_bits {
-	RSEQ_EVENT_PREEMPT_BIT	= RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT,
-	RSEQ_EVENT_SIGNAL_BIT	= RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT,
-	RSEQ_EVENT_MIGRATE_BIT	= RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT,
-};
-
-enum rseq_event_mask {
-	RSEQ_EVENT_PREEMPT	= (1U << RSEQ_EVENT_PREEMPT_BIT),
-	RSEQ_EVENT_SIGNAL	= (1U << RSEQ_EVENT_SIGNAL_BIT),
-	RSEQ_EVENT_MIGRATE	= (1U << RSEQ_EVENT_MIGRATE_BIT),
-};
-
-static inline void rseq_set_notify_resume(struct task_struct *t)
-{
-	if (t->rseq)
-		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
-}
-
 void __rseq_handle_notify_resume(struct ksignal *sig, struct pt_regs *regs);
 
 static inline void rseq_handle_notify_resume(struct pt_regs *regs)
@@ -43,35 +13,27 @@ static inline void rseq_handle_notify_re
 		__rseq_handle_notify_resume(NULL, regs);
 }
 
-static inline void rseq_signal_deliver(struct ksignal *ksig,
-				       struct pt_regs *regs)
+static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs)
 {
 	if (current->rseq) {
-		scoped_guard(RSEQ_EVENT_GUARD)
-			__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
+		current->rseq_event_pending = true;
 		__rseq_handle_notify_resume(ksig, regs);
 	}
 }
 
-/* rseq_preempt() requires preemption to be disabled. */
-static inline void rseq_preempt(struct task_struct *t)
+static inline void rseq_sched_switch_event(struct task_struct *t)
 {
-	__set_bit(RSEQ_EVENT_PREEMPT_BIT, &t->rseq_event_mask);
-	rseq_set_notify_resume(t);
-}
-
-/* rseq_migrate() requires preemption to be disabled. */
-static inline void rseq_migrate(struct task_struct *t)
-{
-	__set_bit(RSEQ_EVENT_MIGRATE_BIT, &t->rseq_event_mask);
-	rseq_set_notify_resume(t);
+	if (t->rseq) {
+		t->rseq_event_pending = true;
+		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
+	}
 }
 
 static __always_inline void rseq_exit_to_user_mode(void)
 {
 	if (IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
-		if (WARN_ON_ONCE(current->rseq && current->rseq_event_mask))
-			current->rseq_event_mask = 0;
+		if (WARN_ON_ONCE(current->rseq && current->rseq_event_pending))
+			current->rseq_event_pending = false;
 	}
 }
 
@@ -85,12 +47,12 @@ static inline void rseq_fork(struct task
 		t->rseq = NULL;
 		t->rseq_len = 0;
 		t->rseq_sig = 0;
-		t->rseq_event_mask = 0;
+		t->rseq_event_pending = false;
 	} else {
 		t->rseq = current->rseq;
 		t->rseq_len = current->rseq_len;
 		t->rseq_sig = current->rseq_sig;
-		t->rseq_event_mask = current->rseq_event_mask;
+		t->rseq_event_pending = current->rseq_event_pending;
 	}
 }
 
@@ -99,15 +61,13 @@ static inline void rseq_execve(struct ta
 	t->rseq = NULL;
 	t->rseq_len = 0;
 	t->rseq_sig = 0;
-	t->rseq_event_mask = 0;
+	t->rseq_event_pending = false;
 }
 
 #else /* CONFIG_RSEQ */
-static inline void rseq_set_notify_resume(struct task_struct *t) { }
 static inline void rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs) { }
 static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs) { }
-static inline void rseq_preempt(struct task_struct *t) { }
-static inline void rseq_migrate(struct task_struct *t) { }
+static inline void rseq_sched_switch_event(struct task_struct *t) { }
 static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags) { }
 static inline void rseq_execve(struct task_struct *t) { }
 static inline void rseq_exit_to_user_mode(void) { }
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1401,14 +1401,14 @@ struct task_struct {
 #endif /* CONFIG_NUMA_BALANCING */
 
 #ifdef CONFIG_RSEQ
-	struct rseq __user *rseq;
-	u32 rseq_len;
-	u32 rseq_sig;
+	struct rseq __user		*rseq;
+	u32				rseq_len;
+	u32				rseq_sig;
 	/*
-	 * RmW on rseq_event_mask must be performed atomically
+	 * RmW on rseq_event_pending must be performed atomically
 	 * with respect to preemption.
 	 */
-	unsigned long rseq_event_mask;
+	bool				rseq_event_pending;
 # ifdef CONFIG_DEBUG_RSEQ
 	/*
 	 * This is a place holder to save a copy of the rseq fields for
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -114,20 +114,13 @@ struct rseq {
 	/*
 	 * Restartable sequences flags field.
 	 *
-	 * This field should only be updated by the thread which
-	 * registered this data structure. Read by the kernel.
-	 * Mainly used for single-stepping through rseq critical sections
-	 * with debuggers.
-	 *
-	 * - RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT
-	 *     Inhibit instruction sequence block restart on preemption
-	 *     for this thread.
-	 * - RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL
-	 *     Inhibit instruction sequence block restart on signal
-	 *     delivery for this thread.
-	 * - RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
-	 *     Inhibit instruction sequence block restart on migration for
-	 *     this thread.
+	 * This field was initialy intended to allow event masking for for
+	 * single-stepping through rseq critical sections with debuggers.
+	 * The kernel does not support this anymore and the relevant bits
+	 * are checked for being always false:
+	 *	- RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT
+	 *	- RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL
+	 *	- RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
 	 */
 	__u32 flags;
 
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -78,6 +78,12 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/rseq.h>
 
+#ifdef CONFIG_MEMBARRIER
+# define RSEQ_EVENT_GUARD	irq
+#else
+# define RSEQ_EVENT_GUARD	preempt
+#endif
+
 /* The original rseq structure size (including padding) is 32 bytes. */
 #define ORIG_RSEQ_SIZE		32
 
@@ -430,11 +436,11 @@ void __rseq_handle_notify_resume(struct
 	 */
 	if (regs) {
 		/*
-		 * Read and clear the event mask first. If the task was not
-		 * preempted or migrated or a signal is on the way, there
-		 * is no point in doing any of the heavy lifting here on
-		 * production kernels. In that case TIF_NOTIFY_RESUME was
-		 * raised by some other functionality.
+		 * Read and clear the event pending bit first. If the task
+		 * was not preempted or migrated or a signal is on the way,
+		 * there is no point in doing any of the heavy lifting here
+		 * on production kernels. In that case TIF_NOTIFY_RESUME
+		 * was raised by some other functionality.
 		 *
 		 * This is correct because the read/clear operation is
 		 * guarded against scheduler preemption, which makes it CPU
@@ -447,15 +453,15 @@ void __rseq_handle_notify_resume(struct
 		 * with the result handed in to allow the detection of
 		 * inconsistencies.
 		 */
-		u32 event_mask;
+		bool event;
 
 		scoped_guard(RSEQ_EVENT_GUARD) {
-			event_mask = t->rseq_event_mask;
-			t->rseq_event_mask = 0;
+			event = t->rseq_event_pending;
+			t->rseq_event_pending = false;
 		}
 
-		if (IS_ENABLED(CONFIG_DEBUG_RSEQ) || event_mask) {
-			ret = rseq_ip_fixup(regs, !!event_mask);
+		if (IS_ENABLED(CONFIG_DEBUG_RSEQ) || event) {
+			ret = rseq_ip_fixup(regs, event);
 			if (unlikely(ret < 0))
 				goto error;
 		}
@@ -584,7 +590,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
 	 * registered, ensure the cpu_id_start and cpu_id fields
 	 * are updated before returning to user-space.
 	 */
-	rseq_set_notify_resume(current);
+	rseq_sched_switch_event(current);
 
 	return 0;
 }
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3364,7 +3364,6 @@ void set_task_cpu(struct task_struct *p,
 		if (p->sched_class->migrate_task_rq)
 			p->sched_class->migrate_task_rq(p, new_cpu);
 		p->se.nr_migrations++;
-		rseq_migrate(p);
 		sched_mm_cid_migrate_from(p);
 		perf_event_task_migrate(p);
 	}
@@ -4795,7 +4794,6 @@ int sched_cgroup_fork(struct task_struct
 		p->sched_task_group = tg;
 	}
 #endif
-	rseq_migrate(p);
 	/*
 	 * We're setting the CPU for the first time, we don't migrate,
 	 * so use __set_task_cpu().
@@ -4859,7 +4857,6 @@ void wake_up_new_task(struct task_struct
 	 * as we're not fully set-up yet.
 	 */
 	p->recent_used_cpu = task_cpu(p);
-	rseq_migrate(p);
 	__set_task_cpu(p, select_task_rq(p, task_cpu(p), &wake_flags));
 	rq = __task_rq_lock(p, &rf);
 	update_rq_clock(rq);
@@ -5153,7 +5150,7 @@ prepare_task_switch(struct rq *rq, struc
 	kcov_prepare_switch(prev);
 	sched_info_switch(rq, prev, next);
 	perf_event_task_sched_out(prev, next);
-	rseq_preempt(prev);
+	rseq_sched_switch_event(prev);
 	fire_sched_out_preempt_notifiers(prev, next);
 	kmap_local_sched_out();
 	prepare_task(next);
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -199,7 +199,7 @@ static void ipi_rseq(void *info)
 	 * is negligible.
 	 */
 	smp_mb();
-	rseq_preempt(current);
+	rseq_sched_switch_event(current);
 }
 
 static void ipi_sync_rq_state(void *info)
@@ -407,9 +407,9 @@ static int membarrier_private_expedited(
 		 * membarrier, we will end up with some thread in the mm
 		 * running without a core sync.
 		 *
-		 * For RSEQ, don't rseq_preempt() the caller.  User code
-		 * is not supposed to issue syscalls at all from inside an
-		 * rseq critical section.
+		 * For RSEQ, don't invoke rseq_sched_switch_event() on the
+		 * caller.  User code is not supposed to issue syscalls at
+		 * all from inside an rseq critical section.
 		 */
 		if (flags != MEMBARRIER_FLAG_SYNC_CORE) {
 			preempt_disable();




