Return-Path: <linux-kernel+bounces-783255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EE6B32AFD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 136FE7A8C8F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8802EA47E;
	Sat, 23 Aug 2025 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DBoMFfY8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7Oa26scQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B552EA499
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755967213; cv=none; b=JkbQ+BFyuH53Z1Eh/f71MpFBfO61A4Li7SErfhPyMijFsxuVz+BLk4bx1XIsJqZZjut9Y3sBNWAs/LO7cI+MiytxxqHzBvF88OoEUICUAiFLK76oHYxDus4FFMmCd20A5F96Fr1QmIvG7OKyxVwocQR94zOKBS0A2IEjo1w3Z2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755967213; c=relaxed/simple;
	bh=JIO/8P1XZxdDWBrLrh41OLmkhf9i3/wHJLeNBSy0xA0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ZFK/vdwVubG8SjEgN6BVnvPT0+lssy0lhmUv5a1Y4Hl4SJExkwpER6hLoWdluOU3vU5Int20V7QzcjhHIO97ex2+neXzyxcuU3mhJTwbHEmaJulGa8+b6oUaJ1piAC5Sg7mqIH8XsaxLKaJWon5C+hIJEJyzDwFI8aCeo0YdMR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DBoMFfY8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7Oa26scQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250823161654.869197102@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755967210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=wmILpI4Ja998LxCNN22+E8ZtCKeqchcvcaXrbRm5AWw=;
	b=DBoMFfY8mFn1BtsjmohTdENncBqsWKa0ib7zpc5ujA1nPTfQBwEh8En7HfybyKQGqAllxa
	GlMGk7uhokniKRhVuSzfqo1x4GExco7Lv7jnC5iWKrvCWIjE5jhiQwxS+azYlDXgLcB3SM
	rwNkM2CQNg/UAHIe+crD1aSnj8wDhXEOizc/5vZh6xULtMQuMJbTxDu+kU/J4n38ehlre7
	Qy1cIGIohPs15b69ckFxqO+hj30xsisN3/4DntZEDP2duboXJLl7K4Wmxojy4AzO9dqda4
	QmJIsqxFpwK0m40SF/LNMDnQTeApLiUSImk4h1baaqXuNPqH+BWTe/eRlEZJFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755967210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=wmILpI4Ja998LxCNN22+E8ZtCKeqchcvcaXrbRm5AWw=;
	b=7Oa26scQM4Ij8PRXHud7b4aJU95D0svh98oiLmf2DiUsVvENwxfLqgGPiG292HlfQ1OgHd
	X3apGIJm52BRIPDg==
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
Subject: [patch V2 25/37] rseq: Rework the TIF_NOTIFY handler
References: <20250823161326.635281786@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 18:40:09 +0200 (CEST)

Replace the whole logic with the new implementation, which is shared with
signal delivery and the upcoming exit fast path.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/rseq.c |   78 +++++++++++++++++++++++++---------------------------------
 1 file changed, 34 insertions(+), 44 deletions(-)

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
-	if (!rseq_set_uids(t, &ids, node_id))
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


