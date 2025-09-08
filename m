Return-Path: <linux-kernel+bounces-806812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E16AB49C10
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F09CC7B23BC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFEF31D757;
	Mon,  8 Sep 2025 21:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RDQOFUZL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I7Mslu7Q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C207631D741
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367139; cv=none; b=Sc4pG4DzyXRY/qLaVs5SmHRv9QqBrXs9CepClqomW7zJEY0c+ybFTyCfLin6Vffn3OxEbcy2048lHWCqRjoaZctnxlhr4sBEK9foxoY6e2Z55TjnYc9yx2muQqVBEW5bpeR1D/harZCrtB6pchFWeMox3pRNl16MXteBW5+LEsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367139; c=relaxed/simple;
	bh=J5qBSjvhM9P3t3fC3UcXnjJcK4FDznlbExnxUIxZQjc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=VXwaivPqTArR57Oykcmb98GrkUqwoiDaSaV3o6N8ocDJsaUmntVLDlVVTL4hs4t8qmBszokVFoyOW0sfANXyfEOGCaolQ2azNRNkSlnaeAxhOa1yS2vJwQZyOGL4OH/oGQVMQV2SUXGp/pCW79Dq5H8DWe37SfU1gyS14wT07IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RDQOFUZL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I7Mslu7Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908212926.802919847@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757367136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/T/Fh1XWax8BghXOyaazLlALkpqh5IrTwI7GnQMj0No=;
	b=RDQOFUZLzr+1HxLB1I1ldAGcLvK2pj5rDZt0f2JsY1Mh/xyQBCnMofvbxmFoHfhyJuGsqh
	sh2UeBCm1EE2kmkx/eTr1hXp6Jes7yNFu2uscNci8HnCN5IqluXFVe6GZtAWAC+C5Zf1AZ
	UorOcwsjEgXwXdNHlSrRGRRRzwF7snFoRY4Fz46WehoSmcP2k0BiNRjBu2JlX/fcY5JUkf
	+McselKhuj4CAbkkfNgrm0MMMemi5+7t+vqOBsZ4cVUasBvkEDo1T/FpZAYk7CKHPOnIHX
	YTMSq0TQTyVwpaBkVYXxV4mErEXOzphX6WHhtU0jZo4R2clwRVarFpoMq1RjPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757367136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/T/Fh1XWax8BghXOyaazLlALkpqh5IrTwI7GnQMj0No=;
	b=I7Mslu7Q8F0sfHJLLXvIxueQ4C2hhOAy+K+jZPLIjlFlU0BhyjhOTLrhjX5SvN1hWxOQ5h
	egaucoEwCgqQHvDQ==
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
Subject: [patch V4 24/36] rseq: Separate the signal delivery path
References: <20250908212737.353775467@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  8 Sep 2025 23:32:15 +0200 (CEST)

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
@@ -5,22 +5,33 @@
 #ifdef CONFIG_RSEQ
 #include <linux/sched.h>
 
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
+		current->rseq.event.error = 0;
+		force_sigsegv(sig);
+	}
 }
 
 void __rseq_debug_syscall_return(struct pt_regs *regs)


