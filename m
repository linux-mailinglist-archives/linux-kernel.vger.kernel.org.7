Return-Path: <linux-kernel+bounces-801760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372ADB4498F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D305670C0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F40343D70;
	Thu,  4 Sep 2025 22:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UJFM38Lt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hAlNNGwg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5688B3431E3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024483; cv=none; b=ktMnSBvz/HU2erzXVt6Vhz6OfbpWwf4+u7XljOGTJBswARSYi0KDifGUHMAF4d+6DFnqg685rR1VstWy13ehddGiDg76YLA7I9aR5uxgUXLSoW76O0wfeyNjYZHGXSA7+B7fEK4dGiQZL9WrBEDMF2PZo6UAbU7a6XoGpZe1M+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024483; c=relaxed/simple;
	bh=vJEjRecEfwMFasz57gKPWjT+fAyMEaz8jRGFOpYfNss=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=IBDemlMz6OS6mk8ElVA6gRR8eR/Pz+hPWy9gfZovRDw0hx52HfHN/lw7lRlbyI1W8KsTTFwYfylWo+rPRkL3wmyl0JMlipgI2LIh40JEFvnPgcurVJ+Ag8z8El4JUumPXzkzW16hTLvm6bIDTkyXxN3LGD7txpwrue15po2a5wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UJFM38Lt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hAlNNGwg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250904185720.650857527@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757024479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=WF9wG7rCldlUFtPWmYQLRMQ78KsP/Dkiq1REK6ueIMo=;
	b=UJFM38LtjyZEL8JJ453xiJamiFDLjiVvSimTBh5af3x1/7U1kHR6ygQ/zWBgwV32M/AOse
	sAU4YJ2Z8F8Zz8d76GC7p5mPZuIDLOTimf13sSxqSYOj9hneETolSuEPNeFdzp3cYfLLmX
	7S/qtAyzx6tpmspzjcNdqX7LaSEBYEw7oN5X8xkWuw9wIY9gsVp5kPQszy4Mk6bKg8Ge0K
	ablwy6Fa6FO+M8qazgq/nm+gXtriMXIBYQuoa73vF8vZzwzPD02KJyCkQWsZ6kXUGQa7Ji
	5GjglBQRXZadmiQFquRt88zJEbn5WN04jIC8yn+e/cGiMU8Bkb/AktELLRy66g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757024479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=WF9wG7rCldlUFtPWmYQLRMQ78KsP/Dkiq1REK6ueIMo=;
	b=hAlNNGwg5SqKp9YdHl1UmD/V1zYx0biHNpxLasF+7MEiBzH/BJvl2058nkiIwVrZCCP206
	lFSTg/lYIl/uaxCA==
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
Subject: [patch V3 24/37] rseq: Separate the signal delivery path
References: <20250904185336.943880027@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  5 Sep 2025 00:21:19 +0200 (CEST)

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


