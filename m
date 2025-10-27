Return-Path: <linux-kernel+bounces-871113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAE3C0C766
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54F6C4F28BE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA1F313E0B;
	Mon, 27 Oct 2025 08:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e2zcVOFn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AbnEhz3X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24F031327E
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554716; cv=none; b=s097uAuxOqKfY1rCDk/QQsyuY56lC/cXkVa7/WuJ2i9SC5u2vyKzce1U5ALgMl79TmAiclPrjU1jU6RNYUtApLhDTJq3OnJ2EQAIpG8lt5sg448mqcJ0Tdtj7/A/TJ9TgXY2Ua2DY3uvXGbHWH9Y2GPJdZAUFlnSjQqy7X6G0yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554716; c=relaxed/simple;
	bh=3PhBLyTlrhkvBwd4mig2A9RBw4fvZO5xaVEOcq/0L0U=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=luuUzIHBStny9KZ5oJ1uF6rukx4WIacRZpfMm3HuJluCd35oet8yDsueVPiM7cMiLKcCf+Ft1W9D5FO3YmrtxgBHqDXesxi6suYWBUGiftl0FkMzPDM1BoahZMnxsZRvj/F4MfPHabSE8PegYB/s6wUEknXdAhQgv3OTlqn1DmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e2zcVOFn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AbnEhz3X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251027084307.517640811@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761554713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=xXKcj91o+zsQ3OLhiveaxKGYk1C4AbcDINlzrFOKBuY=;
	b=e2zcVOFnJ+mur1BbopccwftTeDzdymiZvzikg0rYxMvLJsSLMvLjRstSUMw6LC/A/iYAE4
	xgqOPVHQWzDnzJ5fEG7naRYrLVMdUVxYYIc2ye1PyMPhr9Mkt1j4ymgsDxkE/zv0qsqK65
	bY/XQHj2VtwsaSNOYiw3dhNBEOCR5g4j+YK/r9aeKtMjMn5kngKmHdlIfZaE5oyLwI6B2t
	kumi87un/L9tLftCeyyxVSwe97TxJLgpGRhqUl5Nl0atkswHn7O7aiYdr5IsJBj40JGDiq
	YG76XN6dpc/CRgeq5nfNXlfr5E/9OPIjue1AjQTgMXInS/GvcftZcIBiMSM28g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761554713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=xXKcj91o+zsQ3OLhiveaxKGYk1C4AbcDINlzrFOKBuY=;
	b=AbnEhz3XAUFdTfMigZBvI3jEWIXY6M9oq/QZxKu5i8tmuC9HwxKYat/GFgaFEmg/riaelG
	K/QUp7mSx2TsagCw==
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
Subject: [patch V6 25/31] rseq: Rework the TIF_NOTIFY handler
References: <20251027084220.785525188@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Oct 2025 09:45:12 +0100 (CET)

Replace the whole logic with a new implementation, which is shared with
signal delivery and the upcoming exit fast path.

Contrary to the original implementation, this ignores invocations from
KVM/IO-uring, which invoke resume_user_mode_work() with the @regs argument
set to NULL.

The original implementation updated the CPU/Node/MM CID fields, but that
was just a side effect, which was addressing the problem that this
invocation cleared TIF_NOTIFY_RESUME, which in turn could cause an update
on return to user space to be lost.

This problem has been addressed differently, so that it's not longer
required to do that update before entering the guest.

That might be considered a user visible change, when the hosts thread TLS
memory is mapped into the guest, but as this was never intentionally
supported, this abuse of kernel internal implementation details is not
considered an ABI break.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

---
V3: Moved rseq_update_usr() to this one - Mathieu
    Documented the KVM visible change - Sean
---
 include/linux/rseq_entry.h |   29 +++++++++++++++++
 kernel/rseq.c              |   76 +++++++++++++++++++--------------------------
 2 files changed, 62 insertions(+), 43 deletions(-)
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -368,6 +368,35 @@ bool rseq_set_ids_get_csaddr(struct task
 	return false;
 }
 
+/*
+ * Update user space with new IDs and conditionally check whether the task
+ * is in a critical section.
+ */
+static rseq_inline bool rseq_update_usr(struct task_struct *t, struct pt_regs *regs,
+					struct rseq_ids *ids, u32 node_id)
+{
+	u64 csaddr;
+
+	if (!rseq_set_ids_get_csaddr(t, ids, node_id, &csaddr))
+		return false;
+
+	/*
+	 * On architectures which utilize the generic entry code this
+	 * allows to skip the critical section when the entry was not from
+	 * a user space interrupt, unless debug mode is enabled.
+	 */
+	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY)) {
+		if (!static_branch_unlikely(&rseq_debug_enabled)) {
+			if (likely(!t->rseq.event.user_irq))
+				return true;
+		}
+	}
+	if (likely(!csaddr))
+		return true;
+	/* Sigh, this really needs to do work */
+	return rseq_update_user_cs(t, regs, csaddr);
+}
+
 static __always_inline void rseq_exit_to_user_mode(void)
 {
 	struct rseq_event *ev = &current->rseq.event;
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -82,12 +82,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/rseq.h>
 
-#ifdef CONFIG_MEMBARRIER
-# define RSEQ_EVENT_GUARD	irq
-#else
-# define RSEQ_EVENT_GUARD	preempt
-#endif
-
 DEFINE_STATIC_KEY_MAYBE(CONFIG_RSEQ_DEBUG_DEFAULT_ENABLE, rseq_debug_enabled);
 
 static inline void rseq_control_debug(bool on)
@@ -239,38 +233,15 @@ static bool rseq_handle_cs(struct task_s
 	return false;
 }
 
-/*
- * This resume handler must always be executed between any of:
- * - preemption,
- * - signal delivery,
- * and return to user-space.
- *
- * This is how we can ensure that the entire rseq critical section
- * will issue the commit instruction only if executed atomically with
- * respect to other threads scheduled on the same CPU, and with respect
- * to signal handlers.
- */
-void __rseq_handle_notify_resume(struct pt_regs *regs)
+static void rseq_slowpath_update_usr(struct pt_regs *regs)
 {
+	/* Preserve rseq state and user_irq state for exit to user */
+	const struct rseq_event evt_mask = { .has_rseq = true, .user_irq = true, };
 	struct task_struct *t = current;
 	struct rseq_ids ids;
 	u32 node_id;
 	bool event;
 
-	/*
-	 * If invoked from hypervisors before entering the guest via
-	 * resume_user_mode_work(), then @regs is a NULL pointer.
-	 *
-	 * resume_user_mode_work() clears TIF_NOTIFY_RESUME and re-raises
-	 * it before returning from the ioctl() to user space when
-	 * rseq_event.sched_switch is set.
-	 *
-	 * So it's safe to ignore here instead of pointlessly updating it
-	 * in the vcpu_run() loop.
-	 */
-	if (!regs)
-		return;
-
 	if (unlikely(t->flags & PF_EXITING))
 		return;
 
@@ -294,26 +265,45 @@ void __rseq_handle_notify_resume(struct
 	 * with the result handed in to allow the detection of
 	 * inconsistencies.
 	 */
-	scoped_guard(RSEQ_EVENT_GUARD) {
+	scoped_guard(irq) {
 		event = t->rseq.event.sched_switch;
-		t->rseq.event.sched_switch = false;
+		t->rseq.event.all &= evt_mask.all;
 		ids.cpu_id = task_cpu(t);
 		ids.mm_cid = task_mm_cid(t);
 	}
 
-	if (!IS_ENABLED(CONFIG_DEBUG_RSEQ) && !event)
+	if (!event)
 		return;
 
-	if (!rseq_handle_cs(t, regs))
-		goto error;
-
 	node_id = cpu_to_node(ids.cpu_id);
-	if (!rseq_set_ids(t, &ids, node_id))
-		goto error;
-	return;
 
-error:
-	force_sig(SIGSEGV);
+	if (unlikely(!rseq_update_usr(t, regs, &ids, node_id))) {
+		/*
+		 * Clear the errors just in case this might survive magically, but
+		 * leave the rest intact.
+		 */
+		t->rseq.event.error = 0;
+		force_sig(SIGSEGV);
+	}
+}
+
+void __rseq_handle_notify_resume(struct pt_regs *regs)
+{
+	/*
+	 * If invoked from hypervisors before entering the guest via
+	 * resume_user_mode_work(), then @regs is a NULL pointer.
+	 *
+	 * resume_user_mode_work() clears TIF_NOTIFY_RESUME and re-raises
+	 * it before returning from the ioctl() to user space when
+	 * rseq_event.sched_switch is set.
+	 *
+	 * So it's safe to ignore here instead of pointlessly updating it
+	 * in the vcpu_run() loop.
+	 */
+	if (!regs)
+		return;
+
+	rseq_slowpath_update_usr(regs);
 }
 
 void __rseq_signal_deliver(int sig, struct pt_regs *regs)


