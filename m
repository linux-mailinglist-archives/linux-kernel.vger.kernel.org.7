Return-Path: <linux-kernel+bounces-864993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9277DBFC014
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D903560948
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3182434E750;
	Wed, 22 Oct 2025 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JCUSq1M8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YMYgaCnk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE6034C13E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137564; cv=none; b=NknHP+LWixzzzo800PfociUH7ScKDjU/ov2+8TtUJ/oMXZECP/qaQtOlgPXjmzOohN3P+YTuq2rsAken5IR+DeU99gskpsH+AtlpY7C3PxZzPwTHLy+2CmOOuHAXL50y4Zhnye00PglyXxBlHr9OG+q/7ycBBnALmLvLTzxOI38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137564; c=relaxed/simple;
	bh=jm6msT+Bt/GrGF63oPkH+76az26yVqh5iNls7RPovMY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=eiiOVSlyWZuZh6tX2I0x+SWHz+a3h937PQ+JpDPo+2ltKXxK0I1ffCQ2Gqg8mfGsrv9ckP1iNTWSBZhZEZCUDa9DZsmeEvz/EHI9qFX0RfWJShZmjlFtsa8aYcZDdryb7n6ZOmQ7kjryvQgmzEMa4O/ZwMPpJnSTg9cBCuBhha8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JCUSq1M8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YMYgaCnk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022121943.093817667@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=sNBPCHwRHsyuK/Ilqb/0j++6jWl5o9H1fUNHfO4Dpnk=;
	b=JCUSq1M871+KCpNOQ6lmP6CMNxoBkpi9JM/dAz/KOrH2Ck4uIRuL+TITC8HRBdYamJ/zHA
	wpwD7YujgtBZIG4+5L1CJ1Iisgj5rqbIz8JQt+3Pp4aPDoEfqClTahVQwONiVvG4dfUnGD
	ME523rGMYnlgLks81BjjpzNZlVbzKd+lqSaA3U+4Gs5/+AcdVabyEW5EQDS1MOo/SrsImO
	JZbN1f6FWDcujCvFopCT0NOh/ahPRFyVG8OfKzqOXjoNtlyhBuQOMwsfkmWkXd/9H7ndB3
	2PWntFldBFW9CFgzQrJQRzUezcU3LKKtLKnb/y7IpsV0ZMXyDVNval6S2JP86A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=sNBPCHwRHsyuK/Ilqb/0j++6jWl5o9H1fUNHfO4Dpnk=;
	b=YMYgaCnkr9hciFhyvfMakkL3dMaf5olh5F0RYyGN4k3ASQar8kT2/ADc2GWCJcU5/ZfaAW
	9EPY+j8TGL6+lsDQ==
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
Subject: [patch V5 27/31] rseq: Implement fast path for exit to user
References: <20251022121836.019469732@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:52:34 +0200 (CEST)

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
fork() when the memory is marked COW.

If the user memory inspection finds invalid data, the function returns
false as well and sets the fatal flag in the event struct along with
TIF_NOTIFY_RESUME. The slow path notify handler has to evaluate that flag
and terminate the task with SIGSEGV as documented.

The initial decision to invoke any of this is based on one flags in the
event struct: @sched_switch. The decision is in pseudo ASM:

      load	tsk::event::sched_switch
      jnz	inspect_user_space
      mov	$0, tsk::event::events
      ...
      leave

So for the common case where the task was not scheduled out, this really
boils down to three instructions before going out if the compiler is not
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
V5: Reduce the decision to event::sched_switch - Mathieu
---
 include/linux/rseq_entry.h |  131 +++++++++++++++++++++++++++++++++++++++++++--
 include/linux/rseq_types.h |    3 +
 kernel/rseq.c              |    2 
 3 files changed, 133 insertions(+), 3 deletions(-)
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
@@ -245,12 +246,13 @@ rseq_update_user_cs(struct task_struct *
 {
 	struct rseq_cs __user *ucs = (struct rseq_cs __user *)(unsigned long)csaddr;
 	unsigned long ip = instruction_pointer(regs);
+	unsigned long tasksize = TASK_SIZE;
 	u64 start_ip, abort_ip, offset;
 	u32 usig, __user *uc_sig;
 
 	rseq_stat_inc(rseq_stats.cs);
 
-	if (unlikely(csaddr >= TASK_SIZE)) {
+	if (unlikely(csaddr >= tasksize)) {
 		t->rseq.event.fatal = true;
 		return false;
 	}
@@ -287,7 +289,7 @@ rseq_update_user_cs(struct task_struct *
 		 * in TLS::rseq::rseq_cs. An RSEQ abort would then evade ROP
 		 * protection.
 		 */
-		if (abort_ip >= TASK_SIZE || abort_ip < sizeof(*uc_sig))
+		if (unlikely(abort_ip >= tasksize || abort_ip < sizeof(*uc_sig)))
 			goto die;
 
 		/* The address is guaranteed to be >= 0 and < TASK_SIZE */
@@ -397,6 +399,126 @@ static rseq_inline bool rseq_update_usr(
 	return rseq_update_user_cs(t, regs, csaddr);
 }
 
+/*
+ * If you want to use this then convert your architecture to the generic
+ * entry code. I'm tired of building workarounds for people who can't be
+ * bothered to make the maintenance of generic infrastructure less
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
+ *     - One 64-bit load to retrieve the signature
+ *     - One store to clear the critical section address
+ *
+ * The non-debug case implements only the minimal required checking. It
+ * provides protection against a rogue abort IP in kernel space, which
+ * would be exploitable at least on x86, and also against a rouge CS
+ * descriptor by checking the signature at the abort IP. Any fallout from
+ * invalid critical section descriptors is a user space problem. The debug
+ * case provides the full set of checks and terminates the task if a
+ * condition is not met.
+ *
+ * In case of a fault or an invalid value, this sets TIF_NOTIFY_RESUME and
+ * tells the caller to loop back into exit_to_user_mode_loop(). The rseq
+ * slow path there will handle the fail.
+ */
+static __always_inline bool rseq_exit_user_update(struct pt_regs *regs, struct task_struct *t)
+{
+	/*
+	 * Page faults need to be disabled as this is called with
+	 * interrupts disabled
+	 */
+	guard(pagefault)();
+	if (likely(!t->rseq.event.ids_changed)) {
+		struct rseq __user *rseq = t->rseq.usrptr;
+		/*
+		 * If IDs have not changed rseq_event::user_irq must be true
+		 * See rseq_sched_switch_event().
+		 */
+		u64 csaddr;
+
+		if (unlikely(!get_user_scoped(csaddr, &rseq->rseq_cs)))
+			return false;
+
+		if (static_branch_unlikely(&rseq_debug_enabled) || unlikely(csaddr)) {
+			if (unlikely(!rseq_update_user_cs(t, regs, csaddr)))
+				return false;
+		}
+		return true;
+	}
+
+	struct rseq_ids ids = {
+		.cpu_id = task_cpu(t),
+		.mm_cid = task_mm_cid(t),
+	};
+	u32 node_id = cpu_to_node(ids.cpu_id);
+
+	return rseq_update_usr(t, regs, &ids, node_id);
+}
+
+static __always_inline bool __rseq_exit_to_user_mode_restart(struct pt_regs *regs)
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
+	 * rseq_sched_switch_event() sets the rseq_event::sched_switch bit
+	 * only when rseq_event::has_rseq is true. That conditional is
+	 * required to avoid setting the TIF bit if RSEQ is not registered
+	 * for a task. rseq_event::sched_switch is cleared when RSEQ is
+	 * unregistered by a task so it's sufficient to check for the
+	 * sched_switch bit alone.
+	 *
+	 * A sane compiler requires three instructions for the nothing to do
+	 * case including clearing the events, but your mileage might vary.
+	 */
+	if (unlikely((t->rseq.event.sched_switch))) {
+		rseq_stat_inc(rseq_stats.fastpath);
+
+		if (unlikely(!rseq_exit_user_update(regs, t)))
+			return true;
+	}
+	/* Clear state so next entry starts from a clean slate */
+	t->rseq.event.events = 0;
+	return false;
+}
+
+static __always_inline bool rseq_exit_to_user_mode_restart(struct pt_regs *regs)
+{
+	if (unlikely(__rseq_exit_to_user_mode_restart(regs))) {
+		current->rseq.event.slowpath = true;
+		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
+		return true;
+	}
+	return false;
+}
+
+#endif /* CONFIG_GENERIC_ENTRY */
+
 static __always_inline void rseq_exit_to_user_mode(void)
 {
 	struct rseq_event *ev = &current->rseq.event;
@@ -421,9 +543,12 @@ static inline void rseq_debug_syscall_re
 	if (static_branch_unlikely(&rseq_debug_enabled))
 		__rseq_debug_syscall_return(regs);
 }
-
 #else /* CONFIG_RSEQ */
 static inline void rseq_note_user_irq_entry(void) { }
+static inline bool rseq_exit_to_user_mode_restart(struct pt_regs *regs)
+{
+	return false;
+}
 static inline void rseq_exit_to_user_mode(void) { }
 static inline void rseq_debug_syscall_return(struct pt_regs *regs) { }
 #endif /* !CONFIG_RSEQ */
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -18,6 +18,8 @@ struct rseq;
  * @has_rseq:		True if the task has a rseq pointer installed
  * @error:		Compound error code for the slow path to analyze
  * @fatal:		User space data corrupted or invalid
+ * @slowpath:		Indicator that slow path processing via TIF_NOTIFY_RESUME
+ *			is required
  *
  * @sched_switch and @ids_changed must be adjacent and the combo must be
  * 16bit aligned to allow a single store, when both are set at the same
@@ -42,6 +44,7 @@ struct rseq_event {
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


