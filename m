Return-Path: <linux-kernel+bounces-806817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E54D5B49C1A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C423A5EAC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0140F31E0FB;
	Mon,  8 Sep 2025 21:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vHpvegS/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nrLNQRfs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6195F3203AE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367148; cv=none; b=LC7rXGyVN8DR2ljUwTWt8iOSL0sfpbosgDVeuMmWx7/JpNdPKv7xBvixhkarHzwRszqpJ/PogCiAmLWZC1jB4tu8P0x0o5M0Rq8H595H6UwLoR2B1lu3fccDLUKsCM7OdL+FFZDb9Zx6Vjc7FZ56WiFcm5FlQ4dlKN2btHhfMSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367148; c=relaxed/simple;
	bh=Ygg9kIrAQJ5R0bZWlgvKd1VNXTY7J5C9pTBv7Depxlw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=k+XGoN2yKKK3ZFK/KaFJXM4AJ2gaTH9EP2iwZYH0K14su4RSlaOIRW78GqSzTzxnR+833ER+rPhc7/HD0TXUg+HTQDxJhvGa7QH1GQxmGrgFvaNisZO+AyNXyi+SZORTlqTBWzV+0bt3wJrMO930sadLnJhUwukSDhV2a2zWfnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vHpvegS/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nrLNQRfs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908212927.058801648@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757367144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=8b8i7fV4BZNe1Eu1hRuUdIS8hdF3/91l0qc7kZ1Kw6w=;
	b=vHpvegS/dKA0clVhf1pOA3C6vxIDUlPZ7bHw2xj2zUAT1lBqUwdudTqYNbMkP+yB+V0Czk
	mHw3TMv2ZaNfeUEmVsqrFmBA7CzwwGsufJh094X+SgvJtARCnAt++Bf9u2em3HMYPfs1v0
	YM/SalxKYSZ4TPax67AAkVh01dj0894tGODy+b9QebZzuD9/w8LeEpFVlYx3whDebeteXT
	eBK9ozD4Z0lEceadnyXCuhC8cN/B0G9WjfgcQUgzVnYikWjzXfduAxMmobpvwzzK/NqCs5
	Mo3htcR7lMrahkIrnoiVpB3SYNoE46cfr2ysCgo7IaP9kP1tJzIDxQgBpjbnWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757367144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=8b8i7fV4BZNe1Eu1hRuUdIS8hdF3/91l0qc7kZ1Kw6w=;
	b=nrLNQRfs1Bkih70GHkhxYQ+SSYZWPN365Kr9mtYULYL9cnU+EMTrkqU5d3Rzi0rL4cwRcO
	IKJazFUKszFSGoBA==
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
Subject: [patch V4 28/36] rseq: Switch to fast path processing on exit to user
References: <20250908212737.353775467@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  8 Sep 2025 23:32:23 +0200 (CEST)

Now that all bits and pieces are in place, hook the RSEQ handling fast path
function into exit_to_user_mode_prepare() after the TIF work bits have been
handled. If case of fast path failure, TIF_NOTIFY_RESUME has been raised
and the caller needs to take another turn through the TIF handling slow
path.

This only works for architectures, which use the generic entry code.
Architectures, who still have their own incomplete hacks are not supported
and won't be.

This results in the following improvements:

  Kernel build	       Before		  After		      Reduction
		       
  exit to user         80692981		  80514451      
  signal checks:          32581		       121	       99%
  slowpath runs:        1201408   1.49%	       198 0.00%      100%
  fastpath runs:           	  	    675941 0.84%       N/A
  id updates:           1233989   1.53%	     50541 0.06%       96%
  cs checks:            1125366   1.39%	         0 0.00%      100%
    cs cleared:         1125366      100%	 0            100%
    cs fixup:                 0        0%	 0      

  RSEQ selftests      Before		  After		      Reduction

  exit to user:       386281778		  387373750       
  signal checks:       35661203		          0           100%
  slowpath runs:      140542396 36.38%	        100  0.00%    100%
  fastpath runs:           	  	    9509789  2.51%     N/A
  id updates:         176203599 45.62%	    9087994  2.35%     95%
  cs checks:          175587856 45.46%	    4728394  1.22%     98%
    cs cleared:       172359544   98.16%    1319307   27.90%   99% 
    cs fixup:           3228312    1.84%    3409087   72.10%

The 'cs cleared' and 'cs fixup' percentanges are not relative to the exit
to user invocations, they are relative to the actual 'cs check'
invocations.

While some of this could have been avoided in the original code, like the
obvious clearing of CS when it's already clear, the main problem of going
through TIF_NOTIFY_RESUME cannot be solved. In some workloads the RSEQ
notify handler is invoked more than once before going out to user
space. Doing this once when everything has stabilized is the only solution
to avoid this.

The initial attempt to completely decouple it from the TIF work turned out
to be suboptimal for workloads, which do a lot of quick and short system
calls. Even if the fast path decision is only 4 instructions (including a
conditional branch), this adds up quickly and becomes measurable when the
rate for actually having to handle rseq is in the low single digit
percentage range of user/kernel transitions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: Move the rseq handling into a separate loop to avoid gotos later on
---
 include/linux/irq-entry-common.h |    7 ++-----
 include/linux/resume_user_mode.h |    2 +-
 include/linux/rseq.h             |   23 +++++++++++++++++------
 init/Kconfig                     |    2 +-
 kernel/entry/common.c            |   26 +++++++++++++++++++-------
 kernel/rseq.c                    |    8 ++++++--
 6 files changed, 46 insertions(+), 22 deletions(-)

--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -197,11 +197,8 @@ static __always_inline void arch_exit_to
  */
 void arch_do_signal_or_restart(struct pt_regs *regs);
 
-/**
- * exit_to_user_mode_loop - do any pending work before leaving to user space
- */
-unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
-				     unsigned long ti_work);
+/* Handle pending TIF work */
+unsigned long exit_to_user_mode_loop(struct pt_regs *regs, unsigned long ti_work);
 
 /**
  * exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
--- a/include/linux/resume_user_mode.h
+++ b/include/linux/resume_user_mode.h
@@ -59,7 +59,7 @@ static inline void resume_user_mode_work
 	mem_cgroup_handle_over_high(GFP_KERNEL);
 	blkcg_maybe_throttle_current();
 
-	rseq_handle_notify_resume(regs);
+	rseq_handle_slowpath(regs);
 }
 
 #endif /* LINUX_RESUME_USER_MODE_H */
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -5,13 +5,19 @@
 #ifdef CONFIG_RSEQ
 #include <linux/sched.h>
 
-void __rseq_handle_notify_resume(struct pt_regs *regs);
+void __rseq_handle_slowpath(struct pt_regs *regs);
 
-static inline void rseq_handle_notify_resume(struct pt_regs *regs)
+/* Invoked from resume_user_mode_work() */
+static inline void rseq_handle_slowpath(struct pt_regs *regs)
 {
-	/* '&' is intentional to spare one conditional branch */
-	if (current->rseq.event.sched_switch & current->rseq.event.has_rseq)
-		__rseq_handle_notify_resume(regs);
+	if (IS_ENABLED(CONFIG_GENERIC_ENTRY)) {
+		if (current->rseq.event.slowpath)
+			__rseq_handle_slowpath(regs);
+	} else {
+		/* '&' is intentional to spare one conditional branch */
+		if (current->rseq.event.sched_switch & current->rseq.event.has_rseq)
+			__rseq_handle_slowpath(regs);
+	}
 }
 
 void __rseq_signal_deliver(int sig, struct pt_regs *regs);
@@ -142,11 +148,16 @@ static inline void rseq_fork(struct task
 	} else {
 		t->rseq = current->rseq;
 		t->rseq.ids.cpu_cid = ~0ULL;
+		/*
+		 * If it has rseq, force it into the slow path right away
+		 * because it is guaranteed to fault.
+		 */
+		t->rseq.event.slowpath = t->rseq.event.has_rseq;
 	}
 }
 
 #else /* CONFIG_RSEQ */
-static inline void rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs) { }
+static inline void rseq_handle_slowpath(struct pt_regs *regs) { }
 static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs) { }
 static inline void rseq_sched_switch_event(struct task_struct *t) { }
 static inline void rseq_sched_set_task_cpu(struct task_struct *t, unsigned int cpu) { }
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1911,7 +1911,7 @@ config RSEQ_DEBUG_DEFAULT_ENABLE
 config DEBUG_RSEQ
 	default n
 	bool "Enable debugging of rseq() system call" if EXPERT
-	depends on RSEQ && DEBUG_KERNEL
+	depends on RSEQ && DEBUG_KERNEL && !GENERIC_ENTRY
 	select RSEQ_DEBUG_DEFAULT_ENABLE
 	help
 	  Enable extra debugging checks for the rseq system call.
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -11,13 +11,8 @@
 /* Workaround to allow gradual conversion of architecture code */
 void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
 
-/**
- * exit_to_user_mode_loop - do any pending work before leaving to user space
- * @regs:	Pointer to pt_regs on entry stack
- * @ti_work:	TIF work flags as read by the caller
- */
-__always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
-						     unsigned long ti_work)
+static __always_inline unsigned long __exit_to_user_mode_loop(struct pt_regs *regs,
+							      unsigned long ti_work)
 {
 	/*
 	 * Before returning to user space ensure that all pending work
@@ -62,6 +57,23 @@ void __weak arch_do_signal_or_restart(st
 	return ti_work;
 }
 
+/**
+ * exit_to_user_mode_loop - do any pending work before leaving to user space
+ * @regs:	Pointer to pt_regs on entry stack
+ * @ti_work:	TIF work flags as read by the caller
+ */
+__always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
+						     unsigned long ti_work)
+{
+	for (;;) {
+		ti_work = __exit_to_user_mode_loop(regs, ti_work);
+
+		if (likely(!rseq_exit_to_user_mode_restart(regs)))
+			return ti_work;
+		ti_work = read_thread_flags();
+	}
+}
+
 noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 {
 	irqentry_state_t ret = {
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -234,7 +234,11 @@ static bool rseq_handle_cs(struct task_s
 
 static void rseq_slowpath_update_usr(struct pt_regs *regs)
 {
-	/* Preserve rseq state and user_irq state for exit to user */
+	/*
+	 * Preserve rseq state and user_irq state. The generic entry code
+	 * clears user_irq on the way out, the non-generic entry
+	 * architectures are not having user_irq.
+	 */
 	const struct rseq_event evt_mask = { .has_rseq = true, .user_irq = true, };
 	struct task_struct *t = current;
 	struct rseq_ids ids;
@@ -286,7 +290,7 @@ static void rseq_slowpath_update_usr(str
 	}
 }
 
-void __rseq_handle_notify_resume(struct pt_regs *regs)
+void __rseq_handle_slowpath(struct pt_regs *regs)
 {
 	/*
 	 * If invoked from hypervisors before entering the guest via


