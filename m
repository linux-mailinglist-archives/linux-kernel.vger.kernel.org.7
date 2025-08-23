Return-Path: <linux-kernel+bounces-783257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09810B32B02
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61DEBAA2DBC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1752F2F39BD;
	Sat, 23 Aug 2025 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p5wQcMZ3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ewfstKNU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9F02F39A1
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755967219; cv=none; b=uJ4ZBQav3HDmedmcpzXXL2UwqgPh4UBigqRVlBClqNMYeiW1zAqJ8BAyLHyYjEK2sOtAEG8ORslsB/Jpu3KKy7Al1IaJ8uhR3o3BLEQtuAQSauU/NMc4WRDc1boliCVzexYDbd+9TzxQ9UkeFJcShp3QPlF3X5ZO5/oliJRIims=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755967219; c=relaxed/simple;
	bh=2PyWNB1UVf6D3ZAAuI5VPtSHwwaQ75GIXfowJJ0YalE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=IQczvnZ4FA8TOMOyc0TkpA4BaPzgQ2HuhFKibnjsEBebRfN2TO6wmcsZbK+bpaIkyioa3mOUoYKuUIrhI/SaDfq97NeQSroueLvkVsdknulOyeYygQjkF13RG8gNuR3uuKLl2qUUG6WhASSpwSrhYIWG6SVz8ivDK1QDBcINBNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p5wQcMZ3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ewfstKNU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250823161655.000005616@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755967215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=vzSWhwtjgZNJAeze0LFqDC26Jo5lUIslDEzgumuo/Kg=;
	b=p5wQcMZ3SRXXOKsbtOpI9xEFY5xqGKBCs/NDO7sFfvHcnFMNmqlfQ4Mi9MR8ybd4kDRt3y
	DyIhTXYEh2lHljLKqOZW67oPAkYVZobbUAX+cNS9fwQneJnRR+MLGxaFdPWmAiN1iIgz9u
	MngvO4kmnvaHuCR6yROaUs9XcwjY83g3g+JtxgdJIEZqJd5btupbziUxZJyM66TRHxXjr+
	Dg9PrcCnVBW4DJXyNFhxRMSZRRBC7FwvoWlM2L0JhQLWNTSXmVVLlApR4+M42TieX8Pne+
	7sufaQndc1f3rO//aRy6c4vGDj+we3kGOO+bzvZK0z7B/pMKsJUl7VyQtp0zyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755967215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=vzSWhwtjgZNJAeze0LFqDC26Jo5lUIslDEzgumuo/Kg=;
	b=ewfstKNURCwfxMo1SN2QIgZeP76vffjPyFfJ353CrzsmmaVoy1GV1Va4dJrLzcpQ2yk5SP
	5ZzOHilaZu5j1BCw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
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
Subject: [patch V2 27/37] rseq: Implement fast path for exit to user
References: <20250823161326.635281786@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 18:40:14 +0200 (CEST)

Implement the actual logic for handling RSEQ updates in a fast path after
handling the TIF work and at the point where the task is actually returning
to user space.

This is the right point to do that because at this point the CPU and the MM
CID are stable and cannot longer change due to yet another reschedule.
That happens when the task is handling it via TIF_NOTIFY_RESUME in
resume_user_mode_work(), which is invoked from the exit to user mode work
loop.

The function is invoked after the TIF work is handled and runs with
interrupts disabled, which means it cannot resolve page faults. It
therefore disables page faults and in case the access to the user space
memory faults, it:

  - notes the fail in the event struct
  - raises TIF_NOTIFY_RESUME
  - returns false to the caller

The caller has to go back to the TIF work, which runs with interrupts
enabled and therefore can resolve the page faults. This happens mostly on
fork() when the memory is marked COW. That will be optimized by setting the
failure flag and raising TIF_NOTIFY_RESUME right on fork to avoid the
otherwise unavoidable round trip.

If the user memory inspection finds invalid data, the function returns
false as well and sets the fatal flag in the event struct along with
TIF_NOTIFY_RESUME. The slow path notify handler has to evaluate that flag
and terminate the task with SIGSEGV as documented.

The initial decision to invoke any of this is based on two flags in the
event struct: @has_rseq and @sched_switch. The decision is in pseudo ASM:

      load	tsk::event::has_rseq
      and	tsk::event::sched_switch
      jnz	inspect_user_space
      mov	$0, tsk::event::events
      ...
      leave

So for the common case where the task was not scheduled out, this really
boils down to four instructions before going out if the compiler is not
completely stupid (and yes, some of them are).

If the condition is true, then it checks, whether CPU ID or MM CID have
changed. If so, then the CPU/MM IDs have to be updated and are thereby
cached for the next round. The update unconditionally retrieves the user
space critical section address to spare another user*begin/end() pair.  If
that's not zero and tsk::event::user_irq is set, then the critical section
is analyzed and acted upon. If either zero or the entry came via syscall
the critical section analysis is skipped.

If the comparison is false then the critical section has to be analyzed
because the event flag is then only true when entry from user was by
interrupt.

This is provided without the actual hookup to let reviewers focus on the
implementation details. The hookup happens in the next step.

Note: As with quite some other optimizations this depends on the generic
entry infrastructure and is not enabled to be sucked into random
architecture implementations.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rseq_entry.h |  137 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/rseq_types.h |    3 
 kernel/rseq.c              |    2 
 3 files changed, 139 insertions(+), 3 deletions(-)

--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -10,6 +10,7 @@ struct rseq_stats {
 	unsigned long	exit;
 	unsigned long	signal;
 	unsigned long	slowpath;
+	unsigned long	fastpath;
 	unsigned long	ids;
 	unsigned long	cs;
 	unsigned long	clear;
@@ -204,8 +205,8 @@ bool rseq_debug_update_user_cs(struct ta
 
 /*
  * On debug kernels validate that user space did not mess with it if
- * DEBUG_RSEQ is enabled, but don't on the first exit to user space. In
- * that case cpu_cid is ~0. See fork/execve.
+ * debugging is enabled, but don't do that on the first exit to user
+ * space. In that case cpu_cid is ~0. See fork/execve.
  */
 bool rseq_debug_validate_uids(struct task_struct *t)
 {
@@ -393,6 +394,131 @@ static rseq_inline bool rseq_update_usr(
 	return rseq_update_user_cs(t, regs, csaddr);
 }
 
+/*
+ * If you want to use this then convert your architecture to the generic
+ * entry code. I'm tired of building workarounds for people who can't be
+ * bothered to make the maintainence of generic infrastructure less
+ * burdensome. Just sucking everything into the architecture code and
+ * thereby making others chase the horrible hacks and keep them working is
+ * neither acceptable nor sustainable.
+ */
+#ifdef CONFIG_GENERIC_ENTRY
+
+/*
+ * This is inlined into the exit path because:
+ *
+ * 1) It's a one time comparison in the fast path when there is no event to
+ *    handle
+ *
+ * 2) The access to the user space rseq memory (TLS) is unlikely to fault
+ *    so the straight inline operation is:
+ *
+ *	- Four 32-bit stores only if CPU ID/ MM CID need to be updated
+ *	- One 64-bit load to retrieve the critical section address
+ *
+ * 3) In the unlikely case that the critical section address is != NULL:
+ *
+ *     - One 64-bit load to retrieve the start IP
+ *     - One 64-bit load to retrieve the offset for calculating the end
+ *     - One 64-bit load to retrieve the abort IP
+ *     - One store to clear the critical section address
+ *
+ * The non-debug case implements only the minimal required checking and
+ * protection against a rogue abort IP in kernel space, which would be
+ * exploitable at least on x86. Any fallout from invalid critical section
+ * descriptors is a user space problem. The debug case provides the full
+ * set of checks and terminates the task if a condition is not met.
+ *
+ * In case of a fault or an invalid value, this sets TIF_NOTIFY_RESUME and
+ * tells the caller to loop back into exit_to_user_mode_loop(). The rseq
+ * slow path there will handle the fail.
+ */
+static __always_inline bool rseq_exit_to_user_mode_restart(struct pt_regs *regs)
+{
+	struct task_struct *t = current;
+
+	/*
+	 * If the task did not go through schedule or got the flag enforced
+	 * by the rseq syscall or execve, then nothing to do here.
+	 *
+	 * CPU ID and MM CID can only change when going through a context
+	 * switch.
+	 *
+	 * This can only be done when rseq_event::has_rseq is true.
+	 * rseq_sched_switch_event() sets rseq_event::sched unconditionally
+	 * true to avoid a load of rseq_event::has_rseq in the context
+	 * switch path.
+	 *
+	 * This check uses a '&' and not a '&&' to force the compiler to do
+	 * an actual AND operation instead of two seperate conditionals.
+	 *
+	 * A sane compiler requires four instructions for the nothing to do
+	 * case including clearing the events, but your milage might vary.
+	 */
+	if (likely(!(t->rseq_event.sched_switch & t->rseq_event.has_rseq)))
+		goto done;
+
+	rseq_stat_inc(rseq_stats.fastpath);
+
+	pagefault_disable();
+
+	if (likely(!t->rseq_event.ids_changed)) {
+		/*
+		 * If IDs have not changed rseq_event::user_irq must be true
+		 * See rseq_sched_switch_event().
+		 */
+		u64 csaddr;
+
+		if (unlikely(get_user_masked_u64(&csaddr, &t->rseq->rseq_cs)))
+			goto fail;
+
+		if (static_branch_unlikely(&rseq_debug_enabled) || unlikely(csaddr)) {
+			if (unlikely(!rseq_update_user_cs(t, regs, csaddr)))
+				goto fail;
+		}
+	} else {
+		struct rseq_ids ids = {
+			.cpu_id = task_cpu(t),
+			.mm_cid = task_mm_cid(t),
+		};
+		u32 node_id = cpu_to_node(ids.cpu_id);
+
+		if (unlikely(!rseq_update_usr(t, regs, &ids, node_id)))
+			goto fail;
+	}
+
+	pagefault_enable();
+
+done:
+	/* Clear state so next entry starts from a clean slate */
+	t->rseq_event.events = 0;
+	return false;
+
+fail:
+	pagefault_enable();
+	/* Force it into the slow path. Don't clear the state! */
+	t->rseq_event.slowpath = true;
+	set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
+	return true;
+}
+
+static __always_inline unsigned long
+rseq_exit_to_user_mode_work(struct pt_regs *regs, unsigned long ti_work, const unsigned long mask)
+{
+	/*
+	 * Check if all work bits have been cleared before handling rseq.
+	 */
+	if ((ti_work & mask) != 0)
+		return ti_work;
+
+	if (likely(!__rseq_exit_to_user_mode_restart(regs)))
+		return ti_work;
+
+	return ti_work | _TIF_NOTIFY_RESUME;
+}
+
+#endif /* !CONFIG_GENERIC_ENTRY */
+
 static __always_inline void rseq_exit_to_user_mode(void)
 {
 	struct rseq_event *ev = &current->rseq_event;
@@ -417,8 +543,13 @@ static inline void rseq_debug_syscall_re
 	if (static_branch_unlikely(&rseq_debug_enabled))
 		__rseq_debug_syscall_return(regs);
 }
-
 #else /* CONFIG_RSEQ */
+static inline unsigned long rseq_exit_to_user_mode_work(struct pt_regs *regs,
+							unsigned long ti_work,
+							const unsigned long mask)
+{
+	return ti_work;
+}
 static inline void rseq_note_user_irq_entry(void) { }
 static inline void rseq_exit_to_user_mode(void) { }
 static inline void rseq_debug_syscall_return(struct pt_regs *regs) { }
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -17,6 +17,8 @@ struct rseq;
  * @has_rseq:		True if the task has a rseq pointer installed
  * @error:		Compound error code for the slow path to analyze
  * @fatal:		User space data corrupted or invalid
+ * @slowpath:		Indicator that slow path processing via TIF_NOTIFY_RESUME
+ *			is required
  *
  * @sched_switch and @ids_changed must be adjacent and the combo must be
  * 16bit aligned to allow a single store, when both are set at the same
@@ -41,6 +43,7 @@ struct rseq_event {
 				u16		error;
 				struct {
 					u8	fatal;
+					u8	slowpath;
 				};
 			};
 		};
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -133,6 +133,7 @@ static int rseq_stats_show(struct seq_fi
 		stats.exit	+= data_race(per_cpu(rseq_stats.exit, cpu));
 		stats.signal	+= data_race(per_cpu(rseq_stats.signal, cpu));
 		stats.slowpath	+= data_race(per_cpu(rseq_stats.slowpath, cpu));
+		stats.fastpath	+= data_race(per_cpu(rseq_stats.fastpath, cpu));
 		stats.ids	+= data_race(per_cpu(rseq_stats.ids, cpu));
 		stats.cs	+= data_race(per_cpu(rseq_stats.cs, cpu));
 		stats.clear	+= data_race(per_cpu(rseq_stats.clear, cpu));
@@ -142,6 +143,7 @@ static int rseq_stats_show(struct seq_fi
 	seq_printf(m, "exit:   %16lu\n", stats.exit);
 	seq_printf(m, "signal: %16lu\n", stats.signal);
 	seq_printf(m, "slowp:  %16lu\n", stats.slowpath);
+	seq_printf(m, "fastp:  %16lu\n", stats.fastpath);
 	seq_printf(m, "ids:    %16lu\n", stats.ids);
 	seq_printf(m, "cs:     %16lu\n", stats.cs);
 	seq_printf(m, "clear:  %16lu\n", stats.clear);


