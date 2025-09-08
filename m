Return-Path: <linux-kernel+bounces-806814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CD4B49C12
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C93987B2758
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254FB31E0FA;
	Mon,  8 Sep 2025 21:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zVEbmIHu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mxmLGiM7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD3C31D755
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367141; cv=none; b=jY2/R9sLGvCed+sjTA50iXic0MdPTIdjV0GcaqGhhyB8El7ZdK+h+ZAi4axqVLqcO1UoBlwQ4CrfkB+TaoUktdKtgzZ+HLvI19CC9YEy5dUV9PJchmm8C6OPMLWXqROuNcyeKnIazSf6kllfh0zQd9WirE5RkQZx/hn6aXvejR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367141; c=relaxed/simple;
	bh=XB9Z/qtThv3vdedR9NcfJRvxD79OzDR45kJfSlLAM3Y=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=FZ2uu77Mp1+4/rzq02NJF4E7UShqwzVNxL/vUUWancr2b6zfFgmXF8xToVETnlxBUrSUuZzQK9l14Wrn/suRFf3KuzxeA3Y9UBCCwaVnr+A1y5QdlGciJglA0yYKrwHyT7Tg4U6U793tgl6Gi2m0JuPJg6EB9MfnfA4XGeqk30M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zVEbmIHu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mxmLGiM7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908212926.866534185@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757367138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=0tlq5jy80Pb5OHo3FvyEeuxkNrnz9qwcv/28ZAjrkfA=;
	b=zVEbmIHuZAohhTwBZnJrX0qComBKOKhpxP94yF9VrGf0xIvnaVeYvP3/aaRCLCc0zqVhrE
	rN/8n2VKiS/GQaoIdmHk+aUh/bYonmc5rzt+KAPTy9mF9Y46A+IHDv8ceNjhHN8DHkhCZc
	0vCA4e5M22l4rmNUEkBvrETgSDosgSmReSQ6YrBRbQLrCKqH50c+nXU9NVGmwoEr7U13Im
	xT+oGWBwTIEdk/2oq3Q4BpTy8sr+85eo3qob5OYVEELwnP5FywME6XK6VqOIQYauVfrsL3
	9ilYix2eHSfRTPEBBJ71Gi5H6YFPr2sOjOihgXJgPodwA2WL/BM9EZYPtiwDSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757367138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=0tlq5jy80Pb5OHo3FvyEeuxkNrnz9qwcv/28ZAjrkfA=;
	b=mxmLGiM7yvsTW30vpR5I73idgMAs09XnRuSf9BqT4O1ISmJKlnwz0I2FAy9fVyyFg9pPP+
	jzhtBzVNG2AoU6Bw==
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
Subject: [patch V4 25/36] rseq: Rework the TIF_NOTIFY handler
References: <20250908212737.353775467@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  8 Sep 2025 23:32:17 +0200 (CEST)

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
@@ -383,6 +383,35 @@ bool rseq_set_ids_get_csaddr(struct task
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
@@ -236,38 +230,15 @@ static bool rseq_handle_cs(struct task_s
 	return rseq_update_user_cs(t, regs, csaddr);
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
 
@@ -291,26 +262,45 @@ void __rseq_handle_notify_resume(struct
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


