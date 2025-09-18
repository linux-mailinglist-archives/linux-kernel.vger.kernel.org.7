Return-Path: <linux-kernel+bounces-801761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E60B44990
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA371888150
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20C83451C2;
	Thu,  4 Sep 2025 22:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jsta+RYM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="07Nr7XpZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20996343207
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024485; cv=none; b=LR2TUDmgRX2SbUuVN4T8xrj4CmfGcOHvi0RvdEDHLuldHYEnJc0h7ZYbzettdrqQlyuCNY2TzAb6zWkVlTTCJF1Ov5HWr6kFLCFFt29730bRld/rNpD9aeTGnF8flm6oNXwP0W94lcZbGdu4QwcElgeDp4KXaaNRNKjIcnhYfEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024485; c=relaxed/simple;
	bh=q7DidBcOvUySyC2JFf36eh5WqPx9sHCDZWnCaKglxio=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=oOjnk48YitxxobZvDDT11GU6oxatlh2+8h6mSyAbh6inRKiPJ25OVBQpEemTzt/5lMaANheU3desSXWMP4UUUFG/sJ38IbOhtRGXQeZImX+P0eZ2K423tlI/VJCyIxX1LxRyumfk5+9KRFLGTqkq43cV6tmXTqJQYsWE3EASZ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jsta+RYM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=07Nr7XpZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250904185720.713592313@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757024481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=JqCLwhVZFI4dVBhs7Q0U1m7+4pnNlSpdI3tr0L1C1PU=;
	b=jsta+RYMBpg2N8v2jOG2J9NCCgBCraRVcQ5Exoi2Azrq/tq6ly68jWEUlKHed65/j+J4fD
	CE13sTUGH8P0wQdkgKCwJdo08wrj7W5PaIbhD8EgacTBdkvg/ZCOAjWmkPvxBH7XuJV/CG
	jr7OBqtq4cKFhUTH2wNVjgG22S8T+bHlrgDthB8959rWsWLSCkGmr7fr/l9N2V//m+Wzis
	gPJQlAhvuyUp7lBaW32ZD76k0VlDSENBAGvdJCzrL1YAcRdkRaob9DnKVrKtI44cNdlEkl
	wRZo1tXHluCtMs2p4qp0M/eYuar3+LA+qFG/vJPnOQJ30Xh3XVXmMora4s4A+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757024481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=JqCLwhVZFI4dVBhs7Q0U1m7+4pnNlSpdI3tr0L1C1PU=;
	b=07Nr7XpZtZjC2ucyjzvHeQdif7yvYYHDnZSuPafflANFWcf3QnhkwRRvou6aWTuK7ZFsvz
	JjyF4jF4Ei3icJBA==
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
Subject: [patch V3 25/37] rseq: Rework the TIF_NOTIFY handler
References: <20250904185336.943880027@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  5 Sep 2025 00:21:21 +0200 (CEST)

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
 include/linux/rseq_entry.h |   29 ++++++++++++++++
 kernel/rseq.c              |   78 +++++++++++++++++++--------------------------
 2 files changed, 63 insertions(+), 44 deletions(-)

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
+			if (likely(!t->rseq_event.user_irq))
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
 	struct rseq_event *ev = &current->rseq_event;
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
-		event = t->rseq_event.sched_switch;
-		t->rseq_event.sched_switch = false;
+	scoped_guard(irq) {
 		ids.cpu_id = task_cpu(t);
 		ids.mm_cid = task_mm_cid(t);
+		event = t->rseq_event.sched_switch;
+		t->rseq_event.all &= evt_mask.all;
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
+		t->rseq_event.error = 0;
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


