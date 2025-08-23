Return-Path: <linux-kernel+bounces-783258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F494B32B01
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74FDE1C20445
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1652F39DC;
	Sat, 23 Aug 2025 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oSr2Kk+b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L+ncDQWq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB712F39B1
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755967221; cv=none; b=e2pGTL6d4OmTm+MKsh92NHTNrzeMrZW1nKlXNgl9aHXWPdJKjR5lZBafAPxF/HtzEhqYTOr6nLrxrVfUBYlAzFdbYQ8QLOZbx5W1zVZ/OkQpg4fykMSHaeza0V3x4bowOjS8viOf5PlOM0l2bzIfAmJD0rvdVqfQ6k+SX2QsPxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755967221; c=relaxed/simple;
	bh=TeIaKTx5oTOJNV8fm479T2XBhuJIhgU5GgVF2Z50ZTk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=RjE0oD9RiInhy1Elhp0wWyS1+OCCNV12s5gX2O2bNgDHiLlLTfbDpxLOWUGPu7nT96n+ldeCPTL22TLbyXmOk9yD6wi3ji6Ayw9gWQV3mtpH4L/L4LTG56B7KmW7Qi5m6Am2RME6RNIbolSWQrCnGOCz+JoRUHsfkIlqVDBTI1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oSr2Kk+b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L+ncDQWq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250823161655.063205235@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755967218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=yUaz1viKqpbNy5DnrHuMctWFZT//o6TCXkAtrD4Vqhk=;
	b=oSr2Kk+bKGtvAmYlasAqGhXp57h12L4vHek26GdjrOEOOzoD+1KSR8VWP7u/OR/Or9We7O
	cGAFXPYxsXebvb/cJIPDXu5jsRXHOZsQ0L5XgEPKgJz/cL6cqnQV1AiSCFr0XQXqpf/8uc
	GoJOxJoNBfoc2qFY5WaUklgWeXs9ohz/DMDnJkcD6i6YqpyD8ZbDDVx0cFv8GcKVvsPgO/
	1A2M2dnIBY4cyx15d9YfAAAcUL1Q68XpDr+OaeHCw7JH7gALez8yGUveQk2QlFDcV2SuJm
	w+DTd0SUIdqIWfnA7hcC1O1YL/2hxKJS5+Y6HqsyGZ1P3//BYNH1CnOB8aOC0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755967218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=yUaz1viKqpbNy5DnrHuMctWFZT//o6TCXkAtrD4Vqhk=;
	b=L+ncDQWqGUl8DH904hesdQyARJ49N1m1hoHX8hm5k1oh0Meioal8TYFHZF7PMCyNPKpOVV
	ZFZQ+HNtVl9ElRBg==
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
Subject: [patch V2 28/37] rseq: Switch to fast path processing on exit to user
References: <20250823161326.635281786@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 18:40:17 +0200 (CEST)

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
 include/linux/irq-entry-common.h |    7 ++-----
 include/linux/resume_user_mode.h |    2 +-
 include/linux/rseq.h             |   24 ++++++++++++++++++------
 include/linux/rseq_entry.h       |    2 +-
 init/Kconfig                     |    2 +-
 kernel/entry/common.c            |   17 ++++++++++++++---
 kernel/rseq.c                    |    8 ++++++--
 7 files changed, 43 insertions(+), 19 deletions(-)

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
-	if (current->rseq_event.sched_switch & current->rseq_event.has_rseq)
-		__rseq_handle_notify_resume(regs);
+	if (IS_ENABLED(CONFIG_GENERIC_ENTRY)) {
+		if (current->rseq_event.slowpath)
+			__rseq_handle_slowpath(regs);
+	} else {
+		/* '&' is intentional to spare one conditional branch */
+		if (current->rseq_event.sched_switch & current->rseq_event.has_rseq)
+			__rseq_handle_slowpath(regs);
+	}
 }
 
 void __rseq_signal_deliver(int sig, struct pt_regs *regs);
@@ -138,6 +144,12 @@ static inline void rseq_fork(struct task
 		t->rseq_sig = current->rseq_sig;
 		t->rseq_ids.cpu_cid = ~0ULL;
 		t->rseq_event = current->rseq_event;
+		/*
+		 * If it has rseq, force it into the slow path right away
+		 * because it is guaranteed to fault.
+		 */
+		if (t->rseq_event.has_rseq)
+			t->rseq_event.slowpath = true;
 	}
 }
 
@@ -151,7 +163,7 @@ static inline void rseq_execve(struct ta
 }
 
 #else /* CONFIG_RSEQ */
-static inline void rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs) { }
+static inline void rseq_handle_slowpath(struct pt_regs *regs) { }
 static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs) { }
 static inline void rseq_sched_switch_event(struct task_struct *t) { }
 static inline void rseq_sched_set_task_cpu(struct task_struct *t, unsigned int cpu) { }
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -433,7 +433,7 @@ static rseq_inline bool rseq_update_usr(
  * tells the caller to loop back into exit_to_user_mode_loop(). The rseq
  * slow path there will handle the fail.
  */
-static __always_inline bool rseq_exit_to_user_mode_restart(struct pt_regs *regs)
+static __always_inline bool __rseq_exit_to_user_mode_restart(struct pt_regs *regs)
 {
 	struct task_struct *t = current;
 
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
@@ -23,8 +23,7 @@ void __weak arch_do_signal_or_restart(st
 	 * Before returning to user space ensure that all pending work
 	 * items have been completed.
 	 */
-	while (ti_work & EXIT_TO_USER_MODE_WORK) {
-
+	do {
 		local_irq_enable_exit_to_user(ti_work);
 
 		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
@@ -56,7 +55,19 @@ void __weak arch_do_signal_or_restart(st
 		tick_nohz_user_enter_prepare();
 
 		ti_work = read_thread_flags();
-	}
+
+		/*
+		 * This returns the unmodified ti_work, when ti_work is not
+		 * empty. In that case it waits for the next round to avoid
+		 * multiple updates in case of rescheduling.
+		 *
+		 * When it handles rseq it returns either with empty work
+		 * on success or with TIF_NOTIFY_RESUME set on failure to
+		 * kick the handling into the slow path.
+		 */
+		ti_work = rseq_exit_to_user_mode_work(regs, ti_work, EXIT_TO_USER_MODE_WORK);
+
+	} while (ti_work & EXIT_TO_USER_MODE_WORK);
 
 	/* Return the latest work state for arch_exit_to_user_mode() */
 	return ti_work;
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


