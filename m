Return-Path: <linux-kernel+bounces-864989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D9DBFC04D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 692325E5AC9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7F434A79E;
	Wed, 22 Oct 2025 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2LBif6sZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w+mSBosL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A360634BA57
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137560; cv=none; b=afxNxoz1e0axSlwwnaQkztkAEmkCatbQUjhZuBdVnhb1WPUeJ95gUlxqbXl+ENZ5UJhTBABJIvhizOxzPt5WyHwavN/gF4iyyF1n9fSebqTSM2n4cCoKODw63VRG0YRS+f2ueE0lK6dNX9cS/rp5asY4cF63lx6dXd7VrUVSkIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137560; c=relaxed/simple;
	bh=2Zj3waCszveTEMFoUIvLSqV4YexUg/nTnTiT5wFWriY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=A5yrtx+6tsvrfHv21LYTQpzVF51x+dbfVd7biH+4eZp23O3po8ZU3Q4ga9Ng5uABD+yv14uuKhlijMzixoS1mn3JFqoc+dSC0TPIcz4fjkz6uY7qRiE7XczuqBVBtmtzO/sn5uKpEl99D/8L7/En1KtDhZMi2JccLGNBlmOTuHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2LBif6sZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w+mSBosL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022121942.908615839@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=k/b5oAHgYseQeRcamBZeKNCvZQKGQvNU+ZVAgCvY8IU=;
	b=2LBif6sZ8v5FlzLnEeMSFV09r7KARb3itOHKYAshu0f50ClgOyOvu5cw5Pqrr969k0YXsu
	ROGa2Vc1z+aJT3iCZs4aQyEIqCQOu/o7crSVw8qNtg4Ihs2N+1fGpz8+ZqvtACB28eB4H6
	WXiAtUUXTKSWvRS1256fWjmfNhqnPeN9FPXTt20CxgRPcBhWw04C1pJnnDjsIoO24vxXKF
	Zph29BpIvs1QUDUrFsbwmE79RqsNUHIXt+3ctyJqJw88j8KzYTPJa5LICiqK6AEz4vg0Ze
	Guga39As+OourwkswI04ojNjJJtWKrpcsGDGv10gtFRbid5Z45cqkk1Uwfqt8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=k/b5oAHgYseQeRcamBZeKNCvZQKGQvNU+ZVAgCvY8IU=;
	b=w+mSBosLbnfEI4U8Fc3b5LRTs9fECM243vj1pd3WEDYOqX+G3lFcJscgSts2Dtapoju0OF
	EnECs29B5notctCQ==
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
Subject: [patch V5 24/31] rseq: Separate the signal delivery path
References: <20251022121836.019469732@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:52:30 +0200 (CEST)

Completely separate the signal delivery path from the notify handler as
they have different semantics versus the event handling.

The signal delivery only needs to ensure that the interrupted user context
was not in a critical section or the section is aborted before it switches
to the signal frame context. The signal frame context does not have the
original instruction pointer anymore, so that can't be handled on exit to
user space.

No point in updating the CPU/CID ids as they might change again before the
task returns to user space for real.

The fast path optimization, which checks for the 'entry from user via
interrupt' condition is only available for architectures which use the
generic entry code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
V3: Move rseq_update_usr() to the next patch - Mathieu
---
 include/linux/rseq.h |   21 ++++++++++++++++-----
 kernel/rseq.c        |   30 ++++++++++++++++++++++--------
 2 files changed, 38 insertions(+), 13 deletions(-)
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -7,22 +7,33 @@
 
 #include <uapi/linux/rseq.h>
 
-void __rseq_handle_notify_resume(struct ksignal *sig, struct pt_regs *regs);
+void __rseq_handle_notify_resume(struct pt_regs *regs);
 
 static inline void rseq_handle_notify_resume(struct pt_regs *regs)
 {
 	if (current->rseq.event.has_rseq)
-		__rseq_handle_notify_resume(NULL, regs);
+		__rseq_handle_notify_resume(regs);
 }
 
+void __rseq_signal_deliver(int sig, struct pt_regs *regs);
+
+/*
+ * Invoked from signal delivery to fixup based on the register context before
+ * switching to the signal delivery context.
+ */
 static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs)
 {
-	if (current->rseq.event.has_rseq) {
-		current->rseq.event.sched_switch = true;
-		__rseq_handle_notify_resume(ksig, regs);
+	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY)) {
+		/* '&' is intentional to spare one conditional branch */
+		if (current->rseq.event.has_rseq & current->rseq.event.user_irq)
+			__rseq_signal_deliver(ksig->sig, regs);
+	} else {
+		if (current->rseq.event.has_rseq)
+			__rseq_signal_deliver(ksig->sig, regs);
 	}
 }
 
+/* Raised from context switch and exevce to force evaluation on exit to user */
 static inline void rseq_sched_switch_event(struct task_struct *t)
 {
 	if (t->rseq.event.has_rseq) {
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -250,13 +250,12 @@ static bool rseq_handle_cs(struct task_s
  * respect to other threads scheduled on the same CPU, and with respect
  * to signal handlers.
  */
-void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
+void __rseq_handle_notify_resume(struct pt_regs *regs)
 {
 	struct task_struct *t = current;
 	struct rseq_ids ids;
 	u32 node_id;
 	bool event;
-	int sig;
 
 	/*
 	 * If invoked from hypervisors before entering the guest via
@@ -275,10 +274,7 @@ void __rseq_handle_notify_resume(struct
 	if (unlikely(t->flags & PF_EXITING))
 		return;
 
-	if (ksig)
-		rseq_stat_inc(rseq_stats.signal);
-	else
-		rseq_stat_inc(rseq_stats.slowpath);
+	rseq_stat_inc(rseq_stats.slowpath);
 
 	/*
 	 * Read and clear the event pending bit first. If the task
@@ -317,8 +313,26 @@ void __rseq_handle_notify_resume(struct
 	return;
 
 error:
-	sig = ksig ? ksig->sig : 0;
-	force_sigsegv(sig);
+	force_sig(SIGSEGV);
+}
+
+void __rseq_signal_deliver(int sig, struct pt_regs *regs)
+{
+	rseq_stat_inc(rseq_stats.signal);
+	/*
+	 * Don't update IDs, they are handled on exit to user if
+	 * necessary. The important thing is to abort a critical section of
+	 * the interrupted context as after this point the instruction
+	 * pointer in @regs points to the signal handler.
+	 */
+	if (unlikely(!rseq_handle_cs(current, regs))) {
+		/*
+		 * Clear the errors just in case this might survive
+		 * magically, but leave the rest intact.
+		 */
+		current->rseq.event.error = 0;
+		force_sigsegv(sig);
+	}
 }
 
 /*


