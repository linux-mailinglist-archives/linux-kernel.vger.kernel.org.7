Return-Path: <linux-kernel+bounces-783254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AF6B32AFC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37C241C205F3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77FD2F3600;
	Sat, 23 Aug 2025 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Iu3y26zA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kKLBv5Xr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378F22F0693
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755967211; cv=none; b=MeA7vpsyLod/tQ8NabKUeKrmwrrVEmU7la7a9c/jZ53OzAzIRbiP5MBiM4TEUhJw/k1SGomxcYvnp5PwlamH2pwk5r9gSXLRb2Bh2h3oBBo0EaItBPVlcXJl1pmxtStkx9CjoNMlwQpAWDsbQV1MW0woXTM/2if7pK/ZaOVlqq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755967211; c=relaxed/simple;
	bh=9dpfNEBd4IIEBWj4Bpxoq7yWO/NN/RtWzmPAtxC+pDg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=olzreFQGhWFvq+Ea98vQ6brV9k6OpuSOCbHHxgpjj2butMB7GUa8ccokUXO0WtYFx4fNRG9cuH0CWAX9QZ7HA1YROLfxY+kr8pEmqlq+hKxxcjlHo+NdU2BvxrorvXTFsu1nbhT91rGqz5QDxO0npaT54JOyMt5mSmg9AArQP+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Iu3y26zA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kKLBv5Xr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250823161654.805274429@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755967207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Q+9W5yt61VATLXuYO6rsssXAZcRUaqXzZwLBPp6glFU=;
	b=Iu3y26zA9DxsCPQ3q0Uk5YfkBWAUGMhnBsgPAyP+wClViW1P8sPe/yXaLnrkXMnp1t47Nt
	DDJQQjYID83bQ94mizF4DOEZfivlNm6H4/A7GOrpJQg3n1U4fUUpQGqZ32GI/Am9XTiYGH
	bgqubdChN2uLdNNexLp06orjEvLpy9SNMi0jSROxmRQ2ODQdZz/O9/25+zeTg0tv+BByL2
	Scl+udWCOzXk4JUSA53UMaX3lVMYoxtKjmBlgTvkaqnUsOuEaoHJNRw24qOc4L+tsPBogx
	ECZrlR1i25H+QThjca5c64KV+KwJn6Z/wKefG1v5gOFzZfjDml4wv6loJWrKog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755967207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Q+9W5yt61VATLXuYO6rsssXAZcRUaqXzZwLBPp6glFU=;
	b=kKLBv5Xr12Yz7zdPFomJuU5pltGoaye+xCFE0KqjHWyMZtUEc4fWhxudu8J9ddDSBMADrx
	tkg+X59kgGLPIqBg==
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
Subject: [patch V2 24/37] rseq: Seperate the signal delivery path
References: <20250823161326.635281786@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 18:40:06 +0200 (CEST)

Completely seperate the signal delivery path from the notify handler as
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
 include/linux/rseq.h       |   21 ++++++++++++++++-----
 include/linux/rseq_entry.h |   29 +++++++++++++++++++++++++++++
 kernel/rseq.c              |   30 ++++++++++++++++++++++--------
 3 files changed, 67 insertions(+), 13 deletions(-)

--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -5,22 +5,33 @@
 #ifdef CONFIG_RSEQ
 #include <linux/sched.h>
 
-void __rseq_handle_notify_resume(struct ksignal *sig, struct pt_regs *regs);
+void __rseq_handle_notify_resume(struct pt_regs *regs);
 
 static inline void rseq_handle_notify_resume(struct pt_regs *regs)
 {
 	if (current->rseq_event.has_rseq)
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
-	if (current->rseq_event.has_rseq) {
-		current->rseq_event.sched_switch = true;
-		__rseq_handle_notify_resume(ksig, regs);
+	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY)) {
+		/* '&' is intentional to spare one conditional branch */
+		if (current->rseq_event.has_rseq & current->rseq_event.user_irq)
+			__rseq_signal_deliver(ksig->sig, regs);
+	} else {
+		if (current->rseq_event.has_rseq)
+			__rseq_signal_deliver(ksig->sig, regs);
 	}
 }
 
+/* Raised from context switch and exevce to force evaluation on exit to user */
 static inline void rseq_sched_switch_event(struct task_struct *t)
 {
 	if (t->rseq_event.has_rseq) {
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -364,6 +364,35 @@ bool rseq_set_uids_get_csaddr(struct tas
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
+	if (!rseq_set_uids_get_csaddr(t, ids, node_id, &csaddr))
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
@@ -247,13 +247,12 @@ static bool rseq_handle_cs(struct task_s
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
@@ -272,10 +271,7 @@ void __rseq_handle_notify_resume(struct
 	if (unlikely(t->flags & PF_EXITING))
 		return;
 
-	if (ksig)
-		rseq_stat_inc(rseq_stats.signal);
-	else
-		rseq_stat_inc(rseq_stats.slowpath);
+	rseq_stat_inc(rseq_stats.slowpath);
 
 	/*
 	 * Read and clear the event pending bit first. If the task
@@ -314,8 +310,26 @@ void __rseq_handle_notify_resume(struct
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
+		current->rseq_event.error = 0;
+		force_sigsegv(sig);
+	}
 }
 
 void __rseq_debug_syscall_return(struct pt_regs *regs)


