Return-Path: <linux-kernel+bounces-801736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B5BB44970
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115A1189A485
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDC52E8DF4;
	Thu,  4 Sep 2025 22:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uw/ITK9w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pKwJ+922"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FB52E88B0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024439; cv=none; b=EQEh4avjcHAvnb2cF8VdQJubG+IENyMtKV4JsUZeaPdERvZiyzckuXK1D78n6h9R0p1oSFeZRjPlld+4KNoY43NTlx5HzkLYEqlz8kw6dNkQO+X2T5hh96CF44+BaevTMXdG4f0x0tWzASRVGRxh20UyQcKEuFjcEa4N5h7KuH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024439; c=relaxed/simple;
	bh=d++7RuAAPgPbMLMyVdP0Oq865J74tYNYdO9HzBQKdoM=;
	h=Message-ID:From:To:Cc:Subject:Date; b=P+mX7J6mOoxqGC7WQVd2zsJ+pAcoW0LNTKR9Y1+uYqb/n3vP+f8sOS7Ai/9oN7L63Wf6+IGk7tgPjU+NiQKoEE/WeuEIAax8VK7sBU8x+Md1NdjC4/Cm7fORMim7b1B5BIgwAVOOKtDr8UB/DrJqtz7DyyBBNpMv796DpMSswfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uw/ITK9w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pKwJ+922; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250904185336.943880027@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757024435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=YNvKHITnE8XMefNX5sM44ZRpl+PuKaeXaHZoS6Gn5DQ=;
	b=uw/ITK9w1iImnNgRZ1w0l2e80fPjmcUXkhepf17tvNqBSG1UUndX9B7b/3IVhyjLcSyu7K
	1DtCsHOebyJpYa++pV5CMDGcqCPoh6/1FNB8h4rfUvAnsl6QSbKeULaTEnT1Qnv5s+XMAA
	b0PRR6PysvG6uf4HOX+aQI6Peb1faNHi/LlVbUICxqT3YjkZLnbjzKo9JY4cNZP+Ospftk
	E+zlNik3IumoojRxgNGF5o+gpoA8B/YNH0ys1ZPny+BkYlEwMlm10XcId0Xe6cTgTijGmd
	Xf2zwbvSAxXqGwwU4FM5Am4KTufCY/ANJU4Op+/ELk520qMt44KaUY9BF7sKHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757024435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=YNvKHITnE8XMefNX5sM44ZRpl+PuKaeXaHZoS6Gn5DQ=;
	b=pKwJ+922gae0Pzvod2gyhdk9/qtgXxezPj9dECfZ/8DEG6HBfZAed8J5VKfNSxKseL9lHc
	Ovp62TpSXMHyotCA==
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
Subject: [patch V3 00/37] rseq: Optimize exit to user space
Date: Fri,  5 Sep 2025 00:20:33 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is a follow up on the V2 series, which can be found here:

   https://lore.kernel.org/all/20250823161326.635281786@linutronix.de

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

Changes vs. V2:

  - Bring back the ROP protection - Mathieu

  - Document the guest visible change when host TLS is mapped into guest - Sean

  - Document the TIF_RSEQ optimization for virt - Sean

  - Fix the __setup() return value - Michael

  - Add the missing include in HV - 0-day

  - Rename *uids to *ids - Mathieu

  - Spelling and grammar fixes in comments and change logs - Mathieu

  - Picked up tags where appropriate

Delta patch to V2 is below.

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
 include/linux/rseq.h                            |  223 +++++---
 include/linux/rseq_entry.h                      |  621 ++++++++++++++++++++++++
 include/linux/rseq_types.h                      |   72 ++
 include/linux/sched.h                           |   50 +
 include/linux/thread_info.h                     |    5 
 include/trace/events/rseq.h                     |    4 
 include/uapi/linux/rseq.h                       |   21 
 init/Kconfig                                    |   28 +
 kernel/entry/common.c                           |   37 -
 kernel/entry/syscall-common.c                   |    8 
 kernel/rseq.c                                   |  604 +++++++++--------------
 kernel/sched/core.c                             |   10 
 kernel/sched/membarrier.c                       |    8 
 kernel/sched/sched.h                            |    5 
 virt/kvm/kvm_main.c                             |    3 
 34 files changed, 1433 insertions(+), 699 deletions(-)
---
Delta to V2:

--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -28,6 +28,7 @@
 #include <linux/crash_dump.h>
 #include <linux/panic_notifier.h>
 #include <linux/vmalloc.h>
+#include <linux/rseq.h>
 
 #include "mshv_eventfd.h"
 #include "mshv.h"
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -241,7 +241,7 @@ static __always_inline void __exit_to_us
  * syscall_exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
  * @regs:	Pointer to pt_regs on entry stack
  *
- * Wrapper around __exit_to_user_mode_prepare() to seperate the exit work for
+ * Wrapper around __exit_to_user_mode_prepare() to separate the exit work for
  * syscalls and interrupts.
  */
 static __always_inline void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
@@ -255,7 +255,7 @@ static __always_inline void syscall_exit
  * irqentry_exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
  * @regs:	Pointer to pt_regs on entry stack
  *
- * Wrapper around __exit_to_user_mode_prepare() to seperate the exit work for
+ * Wrapper around __exit_to_user_mode_prepare() to separate the exit work for
  * syscalls and interrupts.
  */
 static __always_inline void irqentry_exit_to_user_mode_prepare(struct pt_regs *regs)
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -112,17 +112,24 @@ static inline void rseq_force_update(voi
 
 /*
  * KVM/HYPERV invoke resume_user_mode_work() before entering guest mode,
- * which clears TIF_NOTIFY_RESUME. To avoid updating user space RSEQ in
- * that case just to do it eventually again before returning to user space,
- * the entry resume_user_mode_work() invocation is ignored as the register
- * argument is NULL.
+ * which clears TIF_NOTIFY_RESUME on architectures that don't use the
+ * generic TIF bits and therefore can't provide a separate TIF_RSEQ flag.
  *
- * After returning from guest mode, they have to invoke this function to
- * re-raise TIF_NOTIFY_RESUME if necessary.
+ * To avoid updating user space RSEQ in that case just to do it eventually
+ * again before returning to user space, because __rseq_handle_slowpath()
+ * does nothing when invoked with NULL register state.
+ *
+ * After returning from guest mode, before exiting to userspace, hypervisors
+ * must invoke this function to re-raise TIF_NOTIFY_RESUME if necessary.
  */
 static inline void rseq_virt_userspace_exit(void)
 {
-	if (!IS_ENABLED(CONFIG_HAVE_GENERIC_TIF_BITS) && current->rseq_event.sched_switch)
+	/*
+	 * The generic optimization for deferring RSEQ updates until the next
+	 * exit relies on having a dedicated TIF_RSEQ.
+	 */
+	if (!IS_ENABLED(CONFIG_HAVE_GENERIC_TIF_BITS) &&
+	    current->rseq_event.sched_switch)
 		rseq_raise_notify_resume(current);
 }
 
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -53,10 +53,8 @@ void __rseq_trace_ip_fixup(unsigned long
 
 static inline void rseq_trace_update(struct task_struct *t, struct rseq_ids *ids)
 {
-	if (tracepoint_enabled(rseq_update)) {
-		if (ids)
-			__rseq_trace_update(t);
-	}
+	if (tracepoint_enabled(rseq_update) && ids)
+		__rseq_trace_update(t);
 }
 
 static inline void rseq_trace_ip_fixup(unsigned long ip, unsigned long start_ip,
@@ -81,7 +79,7 @@ DECLARE_STATIC_KEY_MAYBE(CONFIG_RSEQ_DEB
 #endif
 
 bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long csaddr);
-bool rseq_debug_validate_uids(struct task_struct *t);
+bool rseq_debug_validate_ids(struct task_struct *t);
 
 static __always_inline void rseq_note_user_irq_entry(void)
 {
@@ -209,14 +207,20 @@ bool rseq_debug_update_user_cs(struct ta
  * debugging is enabled, but don't do that on the first exit to user
  * space. In that case cpu_cid is ~0. See fork/execve.
  */
-bool rseq_debug_validate_uids(struct task_struct *t)
+bool rseq_debug_validate_ids(struct task_struct *t)
 {
-	u32 cpu_id, uval, node_id = cpu_to_node(task_cpu(t));
 	struct rseq __user *rseq = t->rseq;
+	u32 cpu_id, uval, node_id;
 
 	if (t->rseq_ids.cpu_cid == ~0)
 		return true;
 
+	/*
+	 * Look it up outside of the user access section as cpu_to_node()
+	 * can end up in debug code.
+	 */
+	node_id = cpu_to_node(t->rseq_ids.cpu_id);
+
 	if (!user_read_masked_begin(rseq))
 		return false;
 
@@ -252,11 +256,13 @@ rseq_update_user_cs(struct task_struct *
 {
 	struct rseq_cs __user *ucs = (struct rseq_cs __user *)(unsigned long)csaddr;
 	unsigned long ip = instruction_pointer(regs);
+	unsigned long tasksize = TASK_SIZE;
 	u64 start_ip, abort_ip, offset;
+	u32 usig, __user *uc_sig;
 
 	rseq_stat_inc(rseq_stats.cs);
 
-	if (unlikely(csaddr >= TASK_SIZE)) {
+	if (unlikely(csaddr >= tasksize)) {
 		t->rseq_event.fatal = true;
 		return false;
 	}
@@ -281,15 +287,28 @@ rseq_update_user_cs(struct task_struct *
 		goto clear;
 
 	/*
-	 * Force it to be in user space as x86 IRET would happily return to
-	 * the kernel. Can't use TASK_SIZE as a mask because that's not
-	 * necessarily a power of two. Just make sure it's in the user
-	 * address space. Let the pagefault handler sort it out.
+	 * Two requirements for @abort_ip:
+	 *   - Must be in user space as x86 IRET would happily return to
+	 *     the kernel.
+	 *   - The four bytes preceeding the instruction at @abort_ip must
+	 *     contain the signature.
+	 *
+	 * The latter protects against the following attack vector:
 	 *
-	 * Use LONG_MAX and not LLONG_MAX to keep it correct for 32 and 64
-	 * bit architectures.
+	 * An attacker with limited abilities to write, creates a critical
+	 * section descriptor, sets the abort IP to a library function or
+	 * some other ROP gadget and stores the address of the descriptor
+	 * in TLS::rseq::rseq_cs. An RSEQ abort would then evade ROP
+	 * protection.
 	 */
-	abort_ip &= (u64)LONG_MAX;
+	if (unlikely(abort_ip >= tasksize || abort_ip < sizeof(*uc_sig)))
+		goto die;
+
+	/* The address is guaranteed to be >= 0 and < TASK_SIZE */
+	uc_sig = (u32 __user *)(unsigned long)(abort_ip - sizeof(*uc_sig));
+	unsafe_get_user(usig, uc_sig, fail);
+	if (unlikely(usig != t->rseq_sig))
+		goto die;
 
 	/* Invalidate the critical section */
 	unsafe_put_user(0ULL, &t->rseq->rseq_cs, fail);
@@ -306,7 +325,8 @@ rseq_update_user_cs(struct task_struct *
 	user_access_end();
 	rseq_stat_inc(rseq_stats.clear);
 	return true;
-
+die:
+	t->rseq_event.fatal = true;
 fail:
 	user_access_end();
 	return false;
@@ -335,13 +355,13 @@ rseq_update_user_cs(struct task_struct *
  * faults in task context are fatal too.
  */
 static rseq_inline
-bool rseq_set_uids_get_csaddr(struct task_struct *t, struct rseq_ids *ids,
-			      u32 node_id, u64 *csaddr)
+bool rseq_set_ids_get_csaddr(struct task_struct *t, struct rseq_ids *ids,
+			     u32 node_id, u64 *csaddr)
 {
 	struct rseq __user *rseq = t->rseq;
 
 	if (static_branch_unlikely(&rseq_debug_enabled)) {
-		if (!rseq_debug_validate_uids(t))
+		if (!rseq_debug_validate_ids(t))
 			return false;
 	}
 
@@ -375,7 +395,7 @@ static rseq_inline bool rseq_update_usr(
 {
 	u64 csaddr;
 
-	if (!rseq_set_uids_get_csaddr(t, ids, node_id, &csaddr))
+	if (!rseq_set_ids_get_csaddr(t, ids, node_id, &csaddr))
 		return false;
 
 	/*
@@ -507,6 +527,7 @@ static __always_inline bool __rseq_exit_
 # define CHECK_TIF_RSEQ		_TIF_RSEQ
 static __always_inline void clear_tif_rseq(void)
 {
+	static_assert(TIF_RSEQ != TIF_NOTIFY_RESUME);
 	clear_thread_flag(TIF_RSEQ);
 }
 #else
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -3,13 +3,13 @@
 #define _LINUX_RSEQ_TYPES_H
 
 #include <linux/types.h>
-/* Forward declaration for the sched.h */
+/* Forward declaration for sched.h */
 struct rseq;
 
 /*
  * struct rseq_event - Storage for rseq related event management
  * @all:		Compound to initialize and clear the data efficiently
- * @events:		Compund to access events with a single load/store
+ * @events:		Compound to access events with a single load/store
  * @sched_switch:	True if the task was scheduled and needs update on
  *			exit to user
  * @ids_changed:	Indicator that IDs need to be updated
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -99,7 +99,7 @@ static int __init rseq_setup_debug(char
 	if (kstrtobool(str, &on))
 		return -EINVAL;
 	rseq_control_debug(on);
-	return 0;
+	return 1;
 }
 __setup("rseq_debug=", rseq_setup_debug);
 
@@ -218,9 +218,9 @@ static int __init rseq_debugfs_init(void
 __initcall(rseq_debugfs_init);
 #endif /* CONFIG_DEBUG_FS */
 
-static bool rseq_set_uids(struct task_struct *t, struct rseq_ids *ids, u32 node_id)
+static bool rseq_set_ids(struct task_struct *t, struct rseq_ids *ids, u32 node_id)
 {
-	return rseq_set_uids_get_csaddr(t, ids, node_id, NULL);
+	return rseq_set_ids_get_csaddr(t, ids, node_id, NULL);
 }
 
 static bool rseq_handle_cs(struct task_struct *t, struct pt_regs *regs)
@@ -374,7 +374,7 @@ static bool rseq_reset_ids(void)
 	 * stupid state as exit to user space will try to fixup the ids
 	 * again.
 	 */
-	if (rseq_set_uids(current, &ids, 0))
+	if (rseq_set_ids(current, &ids, 0))
 		return true;
 
 	force_sig(SIGSEGV);



