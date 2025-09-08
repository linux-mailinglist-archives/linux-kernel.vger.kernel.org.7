Return-Path: <linux-kernel+bounces-806789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD181B49BF6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3445C4E1767
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6692DCC1C;
	Mon,  8 Sep 2025 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SUp553WC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JbM7T2oi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544B94A06
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367090; cv=none; b=cWkTjpp5LHL0XG9LtNGsYOy289x+wvtefU+Dx1O9Zuwh3JcoZYMsQ1dluXNajySWQ3PCyRa4a8ap1Y0XtyG0goBzyaX7PXJraWMiQtncxRc1pmczcUdKwcJDZk/ATJVMYv3zOGsykVhorZ1QKZeMyqXIj/UdqhdN5OdzUpehzPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367090; c=relaxed/simple;
	bh=yiloecYIBoSHKm9cL09eKeU1V8CH2wZzo4K1Of9cAL0=;
	h=Message-ID:From:To:Cc:Subject:Date; b=FUgzKwtaQ1EHZrDI1R+AFg49LAAdtu03bMvd7agBPVsPn4QBfuku3e6UOvABhTaFAbj/9iOxYYrAdT13WMCjfN79/+CzJgtgwMEpiDyv22b1yvDrauXMwkfkfZSpEQw2WUg1NMs4vxTQXKPsBhOgq9lYK0TRaLxVsJRNLckLNqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SUp553WC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JbM7T2oi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908212737.353775467@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757367085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=ZKDRYrZxv9tLlXHuKTVXZ5P+UZbRfHXNy1XlJbf4bRc=;
	b=SUp553WC8OXlwpjQPmyZKZPDEud6QH3DKaySrl54ENvtSAuXr4GNtwwPiVMHccKX3w/74W
	1herQi4/OjeWl50L2YIQ2gvMgyAwuRfbz4nF9eugxC06n2ReUeZRbBhwOdKygYkKzJcf2z
	8xKD7ZKyCF+Y/KQgsDuEArZKgbzPZDBSEoH5ULLWv1Uo0w1YUI30buaojmaGqnZb+/hbKk
	6XGz0KOKlADkHyBEnPHdrL+Z6OfgEkv5YBYcta0jtBFc31Mw4JnbyJQ7bLSmaaWCGhFdkq
	fnKcQLz/NGAb70otf+SU6RO9IiL8yfAlbGjVdkHiiVHOENsA5ihbVnm8GF+knA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757367085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=ZKDRYrZxv9tLlXHuKTVXZ5P+UZbRfHXNy1XlJbf4bRc=;
	b=JbM7T2oij9NmAs9MgvMANN+ObZB7I7AFWhyJHv6AHiWbnxbIjX3GIzgDs2CgKFdyWH2l3Z
	EJCmCRQ5kbCIwAAg==
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
Subject: [patch V4 00/36] rseq: Optimize exit to user space
Date: Mon,  8 Sep 2025 23:31:23 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is a follow up on the V3 series, which can be found here:

   https://lore.kernel.org/all/20250904185336.943880027@linutronix.de

The V2 posting contains a detailed list of the addressed problems. TLDR:

    - A significant amount of pointless RSEQ operations on exit to user
      space, which have been reported by people as measurable impact after
      glibc switched to use RSEQ

    - Suboptimal hotpath handling both in the scheduler and on exit to user
      space.

This series addresses these issues by:

  1) Limiting the RSEQ work to the actual conditions where it is
     required. The full benefit is only available for architectures using
     the generic entry infrastructure. All others get at least the basic
     improvements.

  2) Re-implementing the whole user space handling based on proper data
     structures and by actually looking at the impact it creates in the
     fast path.

  3) Moving the actual handling of RSEQ out to the latest point in the exit
     path, where possible. This is fully inlined into the fast path to keep
     the impact confined.

Changes vs. V3:

  1) Move _all_ RSEQ related data into a umbrella data structure

     When trying to adopt the time slice extension PoC to the rework, I
     noticed that just moving the event and IDs into a data structure is
     dumb.

     Moving all rseq related data into an umbrella struct allows to
     simplify fork/exec by reducing them to memset/memcpy() plus minimal
     extra work, which pretty much avoids to copy or reset further
     additions later on.

     That's a purely mechanical change done with coccinelle on top of V3
     and then gradually folded back with scripting into the series.

  2) Further simplification of the exit_to_user_mode() integration.

     The games with ti_work returned by rseq_exit_to_user_mode() are not
     necessary at all and just complicate things.

     The point is that the RSEQ code is only invoked when all other TIF
     bits except TIF_RSEQ have been processed. So moving the handling out
     of the exit_to_user_mode() loop into a surrounding loop makes it way
     simpler and the resulting ASM is more straight forward. The unlikely
     error case is just looping back once more into the inner loop.

     That elimitates the extra TIF_RSEQ optimization of the previous series
     (patch 37/37) as it now comes for free immediately when hooking up
     TIF_RSEQ. That means the related helper and the ugly goto are gone
     too.

Delta patch to V3 is below.

As for the previous version these patches have a pile of dependencies:

The series depends on the separately posted rseq bugfix:

   https://lore.kernel.org/lkml/87o6sj6z95.ffs@tglx/

and the uaccess generic helper series:

   https://lore.kernel.org/lkml/20250813150610.521355442@linutronix.de/

and a related futex fix in

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent

The combination of all of them and some other related fixes (rseq
selftests) are available here:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/base

For your convenience all of it is also available as a conglomerate from
git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/perf

Thanks,

	tglx
---
 Documentation/admin-guide/kernel-parameters.txt |    4 
 arch/Kconfig                                    |    4 
 arch/loongarch/Kconfig                          |    1 
 arch/loongarch/include/asm/thread_info.h        |   76 +-
 arch/riscv/Kconfig                              |    1 
 arch/riscv/include/asm/thread_info.h            |   31 -
 arch/s390/Kconfig                               |    1 
 arch/s390/include/asm/thread_info.h             |   44 -
 arch/x86/Kconfig                                |    1 
 arch/x86/entry/syscall_32.c                     |    3 
 arch/x86/include/asm/thread_info.h              |   76 +-
 drivers/hv/mshv_root_main.c                     |    3 
 fs/binfmt_elf.c                                 |    2 
 fs/exec.c                                       |    2 
 include/asm-generic/thread_info_tif.h           |   51 +
 include/linux/entry-common.h                    |   38 -
 include/linux/irq-entry-common.h                |   68 ++
 include/linux/mm.h                              |   25 
 include/linux/resume_user_mode.h                |    2 
 include/linux/rseq.h                            |  235 +++++----
 include/linux/rseq_entry.h                      |  607 +++++++++++++++++++++++
 include/linux/rseq_types.h                      |   93 +++
 include/linux/sched.h                           |   48 +
 include/linux/thread_info.h                     |    5 
 include/trace/events/rseq.h                     |    4 
 include/uapi/linux/rseq.h                       |   21 
 init/Kconfig                                    |   28 +
 kernel/entry/common.c                           |   39 -
 kernel/entry/syscall-common.c                   |    8 
 kernel/ptrace.c                                 |    6 
 kernel/rseq.c                                   |  623 +++++++++---------------
 kernel/sched/core.c                             |   10 
 kernel/sched/membarrier.c                       |    8 
 kernel/sched/sched.h                            |    5 
 virt/kvm/kvm_main.c                             |    3 
 35 files changed, 1450 insertions(+), 726 deletions(-)

---
Delta to V3:

diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index 2f166e93f016..b8ea95011ec3 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -11,11 +11,11 @@ void __rseq_handle_slowpath(struct pt_regs *regs);
 static inline void rseq_handle_slowpath(struct pt_regs *regs)
 {
 	if (IS_ENABLED(CONFIG_GENERIC_ENTRY)) {
-		if (current->rseq_event.slowpath)
+		if (current->rseq.event.slowpath)
 			__rseq_handle_slowpath(regs);
 	} else {
 		/* '&' is intentional to spare one conditional branch */
-		if (current->rseq_event.sched_switch & current->rseq_event.has_rseq)
+		if (current->rseq.event.sched_switch & current->rseq.event.has_rseq)
 			__rseq_handle_slowpath(regs);
 	}
 }
@@ -30,10 +30,10 @@ static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *reg
 {
 	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY)) {
 		/* '&' is intentional to spare one conditional branch */
-		if (current->rseq_event.has_rseq & current->rseq_event.user_irq)
+		if (current->rseq.event.has_rseq & current->rseq.event.user_irq)
 			__rseq_signal_deliver(ksig->sig, regs);
 	} else {
-		if (current->rseq_event.has_rseq)
+		if (current->rseq.event.has_rseq)
 			__rseq_signal_deliver(ksig->sig, regs);
 	}
 }
@@ -46,7 +46,7 @@ static inline void rseq_raise_notify_resume(struct task_struct *t)
 /* Invoked from context switch to force evaluation on exit to user */
 static __always_inline void rseq_sched_switch_event(struct task_struct *t)
 {
-	struct rseq_event *ev = &t->rseq_event;
+	struct rseq_event *ev = &t->rseq.event;
 
 	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY)) {
 		/*
@@ -64,7 +64,7 @@ static __always_inline void rseq_sched_switch_event(struct task_struct *t)
 		}
 	} else {
 		if (ev->has_rseq) {
-			t->rseq_event.sched_switch = true;
+			t->rseq.event.sched_switch = true;
 			rseq_raise_notify_resume(t);
 		}
 	}
@@ -79,7 +79,7 @@ static __always_inline void rseq_sched_switch_event(struct task_struct *t)
  */
 static __always_inline void rseq_sched_set_task_cpu(struct task_struct *t, unsigned int cpu)
 {
-	t->rseq_event.ids_changed = true;
+	t->rseq.event.ids_changed = true;
 }
 
 /*
@@ -96,16 +96,16 @@ static __always_inline void rseq_sched_set_task_mm_cid(struct task_struct *t, un
 	 * provide a conditional for it readily. So avoid excessive updates
 	 * when nothing changes.
 	 */
-	if (t->rseq_ids.mm_cid != cid)
-		t->rseq_event.ids_changed = true;
+	if (t->rseq.ids.mm_cid != cid)
+		t->rseq.event.ids_changed = true;
 }
 
 /* Enforce a full update after RSEQ registration and when execve() failed */
 static inline void rseq_force_update(void)
 {
-	if (current->rseq_event.has_rseq) {
-		current->rseq_event.ids_changed = true;
-		current->rseq_event.sched_switch = true;
+	if (current->rseq.event.has_rseq) {
+		current->rseq.event.ids_changed = true;
+		current->rseq.event.sched_switch = true;
 		rseq_raise_notify_resume(current);
 	}
 }
@@ -124,15 +124,27 @@ static inline void rseq_force_update(void)
  */
 static inline void rseq_virt_userspace_exit(void)
 {
+	if (current->rseq.event.sched_switch)
 	/*
 	 * The generic optimization for deferring RSEQ updates until the next
 	 * exit relies on having a dedicated TIF_RSEQ.
 	 */
 	if (!IS_ENABLED(CONFIG_HAVE_GENERIC_TIF_BITS) &&
-	    current->rseq_event.sched_switch)
+	    current->rseq.event.sched_switch)
 		rseq_raise_notify_resume(current);
 }
 
+static inline void rseq_reset(struct task_struct *t)
+{
+	memset(&t->rseq, 0, sizeof(t->rseq));
+	t->rseq.ids.cpu_cid = ~0ULL;
+}
+
+static inline void rseq_execve(struct task_struct *t)
+{
+	rseq_reset(t);
+}
+
 /*
  * If parent process has a registered restartable sequences area, the
  * child inherits. Unregister rseq for a clone with CLONE_VM set.
@@ -140,17 +152,10 @@ static inline void rseq_virt_userspace_exit(void)
 static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
 {
 	if (clone_flags & CLONE_VM) {
-		t->rseq = NULL;
-		t->rseq_len = 0;
-		t->rseq_sig = 0;
-		t->rseq_ids.cpu_cid = ~0ULL;
-		t->rseq_event.all = 0;
+		rseq_reset(t);
 	} else {
 		t->rseq = current->rseq;
-		t->rseq_len = current->rseq_len;
-		t->rseq_sig = current->rseq_sig;
-		t->rseq_ids.cpu_cid = ~0ULL;
-		t->rseq_event = current->rseq_event;
+		t->rseq.ids.cpu_cid = ~0ULL;
 		/*
 		 * If it has rseq, force it into the slow path right away
 		 * because it is guaranteed to fault.
@@ -160,22 +165,13 @@ static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
 		 * for those who do it's required to enforce the slow path
 		 * as the scheduler sets only TIF_RSEQ.
 		 */
-		if (t->rseq_event.has_rseq) {
-			t->rseq_event.slowpath = true;
+		if (t->rseq.event.has_rseq) {
+			t->rseq.event.slowpath = true;
 			set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
 		}
 	}
 }
 
-static inline void rseq_execve(struct task_struct *t)
-{
-	t->rseq = NULL;
-	t->rseq_len = 0;
-	t->rseq_sig = 0;
-	t->rseq_ids.cpu_cid = ~0ULL;
-	t->rseq_event.all = 0;
-}
-
 #else /* CONFIG_RSEQ */
 static inline void rseq_handle_slowpath(struct pt_regs *regs) { }
 static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs) { }
diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index fe6b3cc54d54..ce1ad66c48c3 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -11,7 +11,6 @@ struct rseq_stats {
 	unsigned long	signal;
 	unsigned long	slowpath;
 	unsigned long	fastpath;
-	unsigned long	quicktif;
 	unsigned long	ids;
 	unsigned long	cs;
 	unsigned long	clear;
@@ -65,7 +64,7 @@ static inline void rseq_trace_ip_fixup(unsigned long ip, unsigned long start_ip,
 }
 
 #else /* CONFIG_TRACEPOINT */
-static inline void rseq_trace_update(struct task_struct *t) { }
+static inline void rseq_trace_update(struct task_struct *t, struct rseq_ids *ids) { }
 static inline void rseq_trace_ip_fixup(unsigned long ip, unsigned long start_ip,
 				       unsigned long offset, unsigned long abort_ip) { }
 #endif /* !CONFIG_TRACEPOINT */
@@ -84,7 +83,7 @@ bool rseq_debug_validate_ids(struct task_struct *t);
 static __always_inline void rseq_note_user_irq_entry(void)
 {
 	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY))
-		current->rseq_event.user_irq = true;
+		current->rseq.event.user_irq = true;
 }
 
 /*
@@ -172,17 +171,17 @@ bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsi
 	/* abort_ip - 4 is >= 0. See abort_ip check above */
 	uc_sig = (u32 __user *)(unsigned long)(abort_ip - sizeof(*uc_sig));
 	unsafe_get_user(usig, uc_sig, fail);
-	if (unlikely(usig != t->rseq_sig))
+	if (unlikely(usig != t->rseq.sig))
 		goto die;
 
 	/* rseq_event.user_irq is only valid if CONFIG_GENERIC_IRQ_ENTRY=y */
 	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY)) {
 		/* If not in interrupt from user context, let it die */
-		if (unlikely(!t->rseq_event.user_irq))
+		if (unlikely(!t->rseq.event.user_irq))
 			goto die;
 	}
 
-	unsafe_put_user(0ULL, &t->rseq->rseq_cs, fail);
+	unsafe_put_user(0ULL, &t->rseq.usrptr->rseq_cs, fail);
 	user_access_end();
 
 	instruction_pointer_set(regs, (unsigned long)abort_ip);
@@ -191,12 +190,12 @@ bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsi
 	rseq_trace_ip_fixup(ip, start_ip, offset, abort_ip);
 	return true;
 clear:
-	unsafe_put_user(0ULL, &t->rseq->rseq_cs, fail);
+	unsafe_put_user(0ULL, &t->rseq.usrptr->rseq_cs, fail);
 	user_access_end();
 	rseq_stat_inc(rseq_stats.clear);
 	return true;
 die:
-	t->rseq_event.fatal = true;
+	t->rseq.event.fatal = true;
 fail:
 	user_access_end();
 	return false;
@@ -209,23 +208,23 @@ bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsi
  */
 bool rseq_debug_validate_ids(struct task_struct *t)
 {
-	struct rseq __user *rseq = t->rseq;
+	struct rseq __user *rseq = t->rseq.usrptr;
 	u32 cpu_id, uval, node_id;
 
-	if (t->rseq_ids.cpu_cid == ~0)
+	if (t->rseq.ids.cpu_cid == ~0)
 		return true;
 
 	/*
 	 * Look it up outside of the user access section as cpu_to_node()
 	 * can end up in debug code.
 	 */
-	node_id = cpu_to_node(t->rseq_ids.cpu_id);
+	node_id = cpu_to_node(t->rseq.ids.cpu_id);
 
 	if (!user_read_masked_begin(rseq))
 		return false;
 
 	unsafe_get_user(cpu_id, &rseq->cpu_id_start, efault);
-	if (cpu_id != t->rseq_ids.cpu_id)
+	if (cpu_id != t->rseq.ids.cpu_id)
 		goto die;
 	unsafe_get_user(uval, &rseq->cpu_id, efault);
 	if (uval != cpu_id)
@@ -234,12 +233,12 @@ bool rseq_debug_validate_ids(struct task_struct *t)
 	if (uval != node_id)
 		goto die;
 	unsafe_get_user(uval, &rseq->mm_cid, efault);
-	if (uval != t->rseq_ids.mm_cid)
+	if (uval != t->rseq.ids.mm_cid)
 		goto die;
 	user_access_end();
 	return true;
 die:
-	t->rseq_event.fatal = true;
+	t->rseq.event.fatal = true;
 efault:
 	user_access_end();
 	return false;
@@ -263,7 +262,7 @@ rseq_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long c
 	rseq_stat_inc(rseq_stats.cs);
 
 	if (unlikely(csaddr >= tasksize)) {
-		t->rseq_event.fatal = true;
+		t->rseq.event.fatal = true;
 		return false;
 	}
 
@@ -307,11 +306,11 @@ rseq_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long c
 	/* The address is guaranteed to be >= 0 and < TASK_SIZE */
 	uc_sig = (u32 __user *)(unsigned long)(abort_ip - sizeof(*uc_sig));
 	unsafe_get_user(usig, uc_sig, fail);
-	if (unlikely(usig != t->rseq_sig))
+	if (unlikely(usig != t->rseq.sig))
 		goto die;
 
 	/* Invalidate the critical section */
-	unsafe_put_user(0ULL, &t->rseq->rseq_cs, fail);
+	unsafe_put_user(0ULL, &t->rseq.usrptr->rseq_cs, fail);
 	user_access_end();
 
 	/* Update the instruction pointer */
@@ -321,12 +320,12 @@ rseq_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long c
 	rseq_trace_ip_fixup(ip, start_ip, offset, abort_ip);
 	return true;
 clear:
-	unsafe_put_user(0ULL, &t->rseq->rseq_cs, fail);
+	unsafe_put_user(0ULL, &t->rseq.usrptr->rseq_cs, fail);
 	user_access_end();
 	rseq_stat_inc(rseq_stats.clear);
 	return true;
 die:
-	t->rseq_event.fatal = true;
+	t->rseq.event.fatal = true;
 fail:
 	user_access_end();
 	return false;
@@ -358,7 +357,7 @@ static rseq_inline
 bool rseq_set_ids_get_csaddr(struct task_struct *t, struct rseq_ids *ids,
 			     u32 node_id, u64 *csaddr)
 {
-	struct rseq __user *rseq = t->rseq;
+	struct rseq __user *rseq = t->rseq.usrptr;
 
 	if (static_branch_unlikely(&rseq_debug_enabled)) {
 		if (!rseq_debug_validate_ids(t))
@@ -377,7 +376,7 @@ bool rseq_set_ids_get_csaddr(struct task_struct *t, struct rseq_ids *ids,
 	user_access_end();
 
 	/* Cache the new values */
-	t->rseq_ids.cpu_cid = ids->cpu_cid;
+	t->rseq.ids.cpu_cid = ids->cpu_cid;
 	rseq_stat_inc(rseq_stats.ids);
 	rseq_trace_update(t, ids);
 	return true;
@@ -405,7 +404,7 @@ static rseq_inline bool rseq_update_usr(struct task_struct *t, struct pt_regs *r
 	 */
 	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY)) {
 		if (!static_branch_unlikely(&rseq_debug_enabled)) {
-			if (likely(!t->rseq_event.user_irq))
+			if (likely(!t->rseq.event.user_irq))
 				return true;
 		}
 	}
@@ -476,21 +475,21 @@ static __always_inline bool __rseq_exit_to_user_mode_restart(struct pt_regs *reg
 	 * A sane compiler requires four instructions for the nothing to do
 	 * case including clearing the events, but your milage might vary.
 	 */
-	if (likely(!(t->rseq_event.sched_switch & t->rseq_event.has_rseq)))
+	if (likely(!(t->rseq.event.sched_switch & t->rseq.event.has_rseq)))
 		goto done;
 
 	rseq_stat_inc(rseq_stats.fastpath);
 
 	pagefault_disable();
 
-	if (likely(!t->rseq_event.ids_changed)) {
+	if (likely(!t->rseq.event.ids_changed)) {
 		/*
 		 * If IDs have not changed rseq_event::user_irq must be true
 		 * See rseq_sched_switch_event().
 		 */
 		u64 csaddr;
 
-		if (unlikely(get_user_masked_u64(&csaddr, &t->rseq->rseq_cs)))
+		if (unlikely(get_user_masked_u64(&csaddr, &t->rseq.usrptr->rseq_cs)))
 			goto fail;
 
 		if (static_branch_unlikely(&rseq_debug_enabled) || unlikely(csaddr)) {
@@ -512,61 +511,55 @@ static __always_inline bool __rseq_exit_to_user_mode_restart(struct pt_regs *reg
 
 done:
 	/* Clear state so next entry starts from a clean slate */
-	t->rseq_event.events = 0;
+	t->rseq.event.events = 0;
 	return false;
 
 fail:
 	pagefault_enable();
 	/* Force it into the slow path. Don't clear the state! */
-	t->rseq_event.slowpath = true;
+	t->rseq.event.slowpath = true;
 	set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
 	return true;
 }
 
+/*
+ * Required to allow conversion to GENERIC_ENTRY w/o GENERIC_TIF_BITS
+ * as that's not upstream yet.
+ */
 #ifdef CONFIG_HAVE_GENERIC_TIF_BITS
-# define CHECK_TIF_RSEQ		_TIF_RSEQ
+static __always_inline bool test_tif_rseq(unsigned long ti_work)
+{
+	return ti_work & _TIF_RSEQ;
+}
+
 static __always_inline void clear_tif_rseq(void)
 {
 	static_assert(TIF_RSEQ != TIF_NOTIFY_RESUME);
 	clear_thread_flag(TIF_RSEQ);
 }
 #else
-# define CHECK_TIF_RSEQ		0UL
-static inline void clear_tif_rseq(void) { }
+static __always_inline bool test_tif_rseq(unsigned long ti_work) { return true; }
+static __always_inline void clear_tif_rseq(void) { }
 #endif
 
-static __always_inline unsigned long
-rseq_exit_to_user_mode_work(struct pt_regs *regs, unsigned long ti_work, const unsigned long mask)
+static __always_inline bool
+rseq_exit_to_user_mode_restart(struct pt_regs *regs, unsigned long ti_work)
 {
-	/*
-	 * Check if all work bits have been cleared before handling rseq.
-	 *
-	 * In case of a seperate TIF_RSEQ this checks for all other bits to
-	 * be cleared and TIF_RSEQ to be set.
-	 */
-	if ((ti_work & mask) != CHECK_TIF_RSEQ)
-		return ti_work;
+	if (likely(!test_tif_rseq(ti_work)))
+		return false;
 
-	if (likely(!__rseq_exit_to_user_mode_restart(regs))) {
-		clear_tif_rseq();
-		return ti_work & ~CHECK_TIF_RSEQ;
-	}
-	return ti_work | _TIF_NOTIFY_RESUME;
-}
+	if (unlikely(__rseq_exit_to_user_mode_restart(regs)))
+		return true;
 
-static __always_inline bool
-rseq_exit_to_user_mode_early(unsigned long ti_work, const unsigned long mask)
-{
-	if (IS_ENABLED(CONFIG_HAVE_GENERIC_TIF_BITS))
-		return (ti_work & mask) == CHECK_TIF_RSEQ;
+	clear_tif_rseq();
 	return false;
 }
 
-#endif /* !CONFIG_GENERIC_ENTRY */
+#endif /* CONFIG_GENERIC_ENTRY */
 
 static __always_inline void rseq_syscall_exit_to_user_mode(void)
 {
-	struct rseq_event *ev = &current->rseq_event;
+	struct rseq_event *ev = &current->rseq.event;
 
 	rseq_stat_inc(rseq_stats.exit);
 
@@ -579,7 +572,7 @@ static __always_inline void rseq_syscall_exit_to_user_mode(void)
 
 static __always_inline void rseq_irqentry_exit_to_user_mode(void)
 {
-	struct rseq_event *ev = &current->rseq_event;
+	struct rseq_event *ev = &current->rseq.event;
 
 	rseq_stat_inc(rseq_stats.exit);
 
@@ -601,18 +594,11 @@ static inline void rseq_debug_syscall_return(struct pt_regs *regs)
 		__rseq_debug_syscall_return(regs);
 }
 #else /* CONFIG_RSEQ */
-static inline unsigned long rseq_exit_to_user_mode_work(struct pt_regs *regs,
-							unsigned long ti_work,
-							const unsigned long mask)
-{
-	return ti_work;
-}
-
-static inline bool rseq_exit_to_user_mode_early(unsigned long ti_work, const unsigned long mask)
+static inline void rseq_note_user_irq_entry(void) { }
+static inline bool rseq_exit_to_user_mode_restart(struct pt_regs *regs)
 {
 	return false;
 }
-static inline void rseq_note_user_irq_entry(void) { }
 static inline void rseq_syscall_exit_to_user_mode(void) { }
 static inline void rseq_irqentry_exit_to_user_mode(void) { }
 static inline void rseq_debug_syscall_return(struct pt_regs *regs) { }
diff --git a/include/linux/rseq_types.h b/include/linux/rseq_types.h
index 68dfc215bbff..9c7a34154de8 100644
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -3,10 +3,11 @@
 #define _LINUX_RSEQ_TYPES_H
 
 #include <linux/types.h>
-/* Forward declaration for sched.h */
+
+#ifdef CONFIG_RSEQ
 struct rseq;
 
-/*
+/**
  * struct rseq_event - Storage for rseq related event management
  * @all:		Compound to initialize and clear the data efficiently
  * @events:		Compound to access events with a single load/store
@@ -50,7 +51,7 @@ struct rseq_event {
 	};
 };
 
-/*
+/**
  * struct rseq_ids - Cache for ids, which need to be updated
  * @cpu_cid:	Compound of @cpu_id and @mm_cid to make the
  *		compiler emit a single compare on 64-bit
@@ -69,4 +70,24 @@ struct rseq_ids {
 	};
 };
 
+/**
+ * struct rseq_data - Storage for all rseq related data
+ * @usrptr:	Pointer to the registered user space RSEQ memory
+ * @len:	Length of the RSEQ region
+ * @sig:	Signature of critial section abort IPs
+ * @event:	Storage for event management
+ * @ids:	Storage for cached CPU ID and MM CID
+ */
+struct rseq_data {
+	struct rseq __user		*usrptr;
+	u32				len;
+	u32				sig;
+	struct rseq_event		event;
+	struct rseq_ids			ids;
+};
+
+#else /* CONFIG_RSEQ */
+struct rseq_data { };
+#endif /* !CONFIG_RSEQ */
+
 #endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5ba86a668980..857ed17d443b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1400,13 +1400,7 @@ struct task_struct {
 	unsigned long			numa_pages_migrated;
 #endif /* CONFIG_NUMA_BALANCING */
 
-#ifdef CONFIG_RSEQ
-	struct rseq __user		*rseq;
-	u32				rseq_len;
-	u32				rseq_sig;
-	struct rseq_event		rseq_event;
-	struct rseq_ids			rseq_ids;
-#endif
+	struct rseq_data		rseq;
 
 #ifdef CONFIG_SCHED_MM_CID
 	int				mm_cid;		/* Current cid in mm */
diff --git a/include/trace/events/rseq.h b/include/trace/events/rseq.h
index a6ec3f0c8ae7..ce85d650bf4b 100644
--- a/include/trace/events/rseq.h
+++ b/include/trace/events/rseq.h
@@ -21,9 +21,9 @@ TRACE_EVENT(rseq_update,
 	),
 
 	TP_fast_assign(
-		__entry->cpu_id = t->rseq_ids.cpu_id;
+		__entry->cpu_id = t->rseq.ids.cpu_id;
 		__entry->node_id = cpu_to_node(__entry->cpu_id);
-		__entry->mm_cid = t->rseq_ids.mm_cid;
+		__entry->mm_cid = t->rseq.ids.mm_cid;
 	),
 
 	TP_printk("cpu_id=%d node_id=%d mm_cid=%d", __entry->cpu_id,
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 73028b98aa6a..cca17016c5da 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -11,26 +11,21 @@
 /* Workaround to allow gradual conversion of architecture code */
 void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
 
-/**
- * exit_to_user_mode_loop - do any pending work before leaving to user space
- * @regs:	Pointer to pt_regs on entry stack
- * @ti_work:	TIF work flags as read by the caller
- */
-__always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
-						     unsigned long ti_work)
+#ifdef CONFIG_HAVE_GENERIC_TIF_BITS
+#define EXIT_TO_USER_MODE_WORK_LOOP	(EXIT_TO_USER_MODE_WORK & ~_TIF_RSEQ)
+#else
+#define EXIT_TO_USER_MODE_WORK_LOOP	(EXIT_TO_USER_MODE_WORK)
+#endif
+
+static __always_inline unsigned long __exit_to_user_mode_loop(struct pt_regs *regs,
+							      unsigned long ti_work)
 {
 	/*
 	 * Before returning to user space ensure that all pending work
 	 * items have been completed.
-	 *
-	 * Optimize for TIF_RSEQ being the only bit set.
 	 */
-	if (rseq_exit_to_user_mode_early(ti_work, EXIT_TO_USER_MODE_WORK)) {
-		rseq_stat_inc(rseq_stats.quicktif);
-		goto do_rseq;
-	}
+	while (ti_work & EXIT_TO_USER_MODE_WORK_LOOP) {
 
-	do {
 		local_irq_enable_exit_to_user(ti_work);
 
 		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
@@ -62,26 +57,29 @@ __always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 		tick_nohz_user_enter_prepare();
 
 		ti_work = read_thread_flags();
-
-	do_rseq:
-		/*
-		 * This returns the unmodified ti_work, when ti_work is not
-		 * empty (except for TIF_RSEQ). In that case it waits for
-		 * the next round to avoid multiple updates in case of
-		 * rescheduling.
-		 *
-		 * When it handles rseq it returns either with empty work
-		 * on success or with TIF_NOTIFY_RESUME set on failure to
-		 * kick the handling into the slow path.
-		 */
-		ti_work = rseq_exit_to_user_mode_work(regs, ti_work, EXIT_TO_USER_MODE_WORK);
-
-	} while (ti_work & EXIT_TO_USER_MODE_WORK);
+	}
 
 	/* Return the latest work state for arch_exit_to_user_mode() */
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
+		if (likely(!rseq_exit_to_user_mode_restart(regs, ti_work)))
+			return ti_work;
+		ti_work = read_thread_flags();
+	}
+}
+
 noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 {
 	irqentry_state_t ret = {
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 75a84efad40f..392ec2f75f01 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -793,9 +793,9 @@ static long ptrace_get_rseq_configuration(struct task_struct *task,
 					  unsigned long size, void __user *data)
 {
 	struct ptrace_rseq_configuration conf = {
-		.rseq_abi_pointer = (u64)(uintptr_t)task->rseq,
-		.rseq_abi_size = task->rseq_len,
-		.signature = task->rseq_sig,
+		.rseq_abi_pointer = (u64)(uintptr_t)task->rseq.usrptr,
+		.rseq_abi_size = task->rseq.len,
+		.signature = task->rseq.sig,
 		.flags = 0,
 	};
 
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 01c7402d13a3..52b276a5e004 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -134,7 +134,6 @@ static int rseq_stats_show(struct seq_file *m, void *p)
 		stats.signal	+= data_race(per_cpu(rseq_stats.signal, cpu));
 		stats.slowpath	+= data_race(per_cpu(rseq_stats.slowpath, cpu));
 		stats.fastpath	+= data_race(per_cpu(rseq_stats.fastpath, cpu));
-		stats.quicktif	+= data_race(per_cpu(rseq_stats.quicktif, cpu));
 		stats.ids	+= data_race(per_cpu(rseq_stats.ids, cpu));
 		stats.cs	+= data_race(per_cpu(rseq_stats.cs, cpu));
 		stats.clear	+= data_race(per_cpu(rseq_stats.clear, cpu));
@@ -145,7 +144,6 @@ static int rseq_stats_show(struct seq_file *m, void *p)
 	seq_printf(m, "signal: %16lu\n", stats.signal);
 	seq_printf(m, "slowp:  %16lu\n", stats.slowpath);
 	seq_printf(m, "fastp:  %16lu\n", stats.fastpath);
-	seq_printf(m, "quickt: %16lu\n", stats.quicktif);
 	seq_printf(m, "ids:    %16lu\n", stats.ids);
 	seq_printf(m, "cs:     %16lu\n", stats.cs);
 	seq_printf(m, "clear:  %16lu\n", stats.clear);
@@ -227,7 +225,7 @@ static bool rseq_handle_cs(struct task_struct *t, struct pt_regs *regs)
 {
 	u64 csaddr;
 
-	if (get_user_masked_u64(&csaddr, &t->rseq->rseq_cs))
+	if (get_user_masked_u64(&csaddr, &t->rseq.usrptr->rseq_cs))
 		return false;
 	if (likely(!csaddr))
 		return true;
@@ -271,10 +269,10 @@ static void rseq_slowpath_update_usr(struct pt_regs *regs)
 	 * inconsistencies.
 	 */
 	scoped_guard(irq) {
+		event = t->rseq.event.sched_switch;
+		t->rseq.event.all &= evt_mask.all;
 		ids.cpu_id = task_cpu(t);
 		ids.mm_cid = task_mm_cid(t);
-		event = t->rseq_event.sched_switch;
-		t->rseq_event.all &= evt_mask.all;
 	}
 
 	if (!event)
@@ -287,7 +285,7 @@ static void rseq_slowpath_update_usr(struct pt_regs *regs)
 		 * Clear the errors just in case this might survive magically, but
 		 * leave the rest intact.
 		 */
-		t->rseq_event.error = 0;
+		t->rseq.event.error = 0;
 		force_sig(SIGSEGV);
 	}
 }
@@ -325,7 +323,7 @@ void __rseq_signal_deliver(int sig, struct pt_regs *regs)
 		 * Clear the errors just in case this might survive
 		 * magically, but leave the rest intact.
 		 */
-		current->rseq_event.error = 0;
+		current->rseq.event.error = 0;
 		force_sigsegv(sig);
 	}
 }
@@ -335,9 +333,9 @@ void __rseq_debug_syscall_return(struct pt_regs *regs)
 	struct task_struct *t = current;
 	u64 csaddr;
 
-	if (!t->rseq_event.has_rseq)
+	if (!t->rseq.event.has_rseq)
 		return;
-	if (get_user_masked_u64(&csaddr, &t->rseq->rseq_cs))
+	if (get_user_masked_u64(&csaddr, &t->rseq.usrptr->rseq_cs))
 		goto fail;
 	if (likely(!csaddr))
 		return;
@@ -393,33 +391,30 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len, int, flags, u32
 		if (flags & ~RSEQ_FLAG_UNREGISTER)
 			return -EINVAL;
 		/* Unregister rseq for current thread. */
-		if (current->rseq != rseq || !current->rseq)
+		if (current->rseq.usrptr != rseq || !current->rseq.usrptr)
 			return -EINVAL;
-		if (rseq_len != current->rseq_len)
+		if (rseq_len != current->rseq.len)
 			return -EINVAL;
-		if (current->rseq_sig != sig)
+		if (current->rseq.sig != sig)
 			return -EPERM;
 		if (!rseq_reset_ids())
 			return -EFAULT;
-		current->rseq = NULL;
-		current->rseq_sig = 0;
-		current->rseq_len = 0;
-		current->rseq_event.all = 0;
+		rseq_reset(current);
 		return 0;
 	}
 
 	if (unlikely(flags))
 		return -EINVAL;
 
-	if (current->rseq) {
+	if (current->rseq.usrptr) {
 		/*
 		 * If rseq is already registered, check whether
 		 * the provided address differs from the prior
 		 * one.
 		 */
-		if (current->rseq != rseq || rseq_len != current->rseq_len)
+		if (current->rseq.usrptr != rseq || rseq_len != current->rseq.len)
 			return -EINVAL;
-		if (current->rseq_sig != sig)
+		if (current->rseq.sig != sig)
 			return -EPERM;
 		/* Already registered. */
 		return -EBUSY;
@@ -457,16 +452,16 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len, int, flags, u32
 	 * Activate the registration by setting the rseq area address, length
 	 * and signature in the task struct.
 	 */
-	current->rseq = rseq;
-	current->rseq_len = rseq_len;
-	current->rseq_sig = sig;
+	current->rseq.usrptr = rseq;
+	current->rseq.len = rseq_len;
+	current->rseq.sig = sig;
 
 	/*
 	 * If rseq was previously inactive, and has just been
 	 * registered, ensure the cpu_id_start and cpu_id fields
 	 * are updated before returning to user-space.
 	 */
-	current->rseq_event.has_rseq = true;
+	current->rseq.event.has_rseq = true;
 	rseq_force_update();
 
 	return 0;




