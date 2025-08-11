Return-Path: <linux-kernel+bounces-762262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B58E0B2042B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74570189168B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD0D1F5435;
	Mon, 11 Aug 2025 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vHjz+o3C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uQbYEL/C"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C7A1E9915
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905519; cv=none; b=ARNK4CcLIl9DHNxXXZI0PJLx313aouA/NDIecjnStYFpqmodBRG0pdWxqOKUVBojUaI+RBz6tyQBFZpfZNrSbiipVRz9o5umxpfH75kwX536z14l9uz76C5fbnPffXo4mqu1+KYmobFY+TB7JmqtidkFJiX5MZVZqxE9JxiHIUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905519; c=relaxed/simple;
	bh=sDU8afqpHwVJsU4z82pdkx0UmwRQL712KsRnoMBEkCY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dS9mx50D/q+P9gz2eUcAf4ubI+dMDLwKQqtYoPGreNvflmz3DSXhEFnIC5wAt2k5WQUB+7xglsOz4MUVOGL0i2jjWKNvDGI4c41pv1Y5TSHKtwEePM1Au109FsEQSNm4MufubLru+rsGqAZ72V3LIxqs4unevm7XAeic/sxJVI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vHjz+o3C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uQbYEL/C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754905512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xte3LCCt76o0/W2Aye/+ZGfvJQbbUeK/nJWp2UX8BWU=;
	b=vHjz+o3CpMIgTCTAuS7ffT5Lt8OiabtMORFJP1sCM2yrpJ+T40Y9rQpoldZqKdkUsUHbcr
	uEh2OURzgjHyTD3kOuoWU1QzC6/lIk8c3T05Q45w/q/TJnAO5Edhg2z1/UGW2/TK9f1BL+
	fCU5BUpYBJ1LsB2Dn20Dv8irOVQkpVGSy2QErjNfKmv02C/xl1lBVpiyVzQVfIiyxfkQ7d
	Raw9G2nQr1GUOblxHAtPXjPYsbMM3EwJEXw5kZGObs8muD0k9O36f0RM6fIZW/1fzgnLot
	Rh9rRuWYvPf5sy+nVrKgh9BY0TE/PS60OqquiUSSahssAMGZ7VXwmog7QhfKog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754905512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xte3LCCt76o0/W2Aye/+ZGfvJQbbUeK/nJWp2UX8BWU=;
	b=uQbYEL/CTD3FWpg1NdXY80blQIpWQqST4YCoT6UIdY8SQ+2oAekjH7ZZs9VA6Qfg+vrKOd
	YuNIoGU//1kR11Cg==
To: Prakash Sangappa <prakash.sangappa@oracle.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>, "rostedt@goodmis.org"
 <rostedt@goodmis.org>, "mathieu.desnoyers@efficios.com"
 <mathieu.desnoyers@efficios.com>, "bigeasy@linutronix.de"
 <bigeasy@linutronix.de>, "kprateek.nayak@amd.com"
 <kprateek.nayak@amd.com>, "vineethr@linux.ibm.com"
 <vineethr@linux.ibm.com>
Subject: Re: [PATCH V7 02/11] sched: Indicate if thread got rescheduled
In-Reply-To: <BF199244-10DF-4B84-99AF-DDA125F775E4@oracle.com>
References: <20250724161625.2360309-1-prakash.sangappa@oracle.com>
 <20250724161625.2360309-3-prakash.sangappa@oracle.com>
 <87a54bcmd7.ffs@tglx> <BF199244-10DF-4B84-99AF-DDA125F775E4@oracle.com>
Date: Mon, 11 Aug 2025 11:45:11 +0200
Message-ID: <87o6smb3a0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 07 2025 at 16:15, Prakash Sangappa wrote:
>> On Aug 7, 2025, at 6:06=E2=80=AFAM, Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>> rseq_preempt() sets RSEQ_EVENT_PREEMPT_BIT and TIF_NOTIFY_RESUME, which
>> causes exit to userspace to invoke __rseq_handle_notify_resume(). That's
>> the obvious place to handle this instead of inflicting it into the
>> scheduler hotpath.
>>=20
>> No?
>
> Sure, I will look at moving rseq_delay_resched_clear() call to __rseq_han=
dle_notify_resume().

I looked deeper into it and it does not completely solve the problem.

The approach of having a request bit and then a disconnected rescheduled
bit is not working. You need a proper contract between kernel and
userspace and you have to enforce it.

You gracefully avoided to provide an actual ABI description and a user
space test case for this....

You need two bits in rseq::flags: REQUEST and GRANTED

The flow is:

    local_set_bit(REQUEST, &rseq->flags);
    critical_section();
    if (!local_test_and_clear_bit(REQUEST, &rseq->flags)) {
    	if (local_test_bit(GRANTED, &rseq->flags))
        	sched_yield();
    }

local_set_bit() could be a simple

            rseq->flags |=3D REQUEST;

operation when and only when there is no other usage of rseq->flags than
this extension muck. Otherwise the resulting RMW would race against the
kernel updating flags.

If that's not guaranteed and it won't be because flags might be used for
other things later, then local_set_bit() must use a instruction which is
atomic on the local CPU vs. interrupts, e.g. ORB on X86. There is no
LOCK prefix required as there is no cross CPU concurrency possible due
to rseq being strictly thread local.

The only way to avoid that is to provide a distinct new rseq field for
this, but that's a different debate to be had.

local_test_and_clear_bit() on the other hand _must_ always be thread
local atomic to prevent the obvious RMW race. On X86 this is a simple
BTR without LOCK prefix. Only ALPHA, LONGARCH, MIPS, POWERPC and X86
provide such local operations, on everything else you need to fall back
to a full atomic.

local_test_bit() has no atomicity requirements as there is obviously a
race which cannot be avoided:

    	if (local_test_bit(GRANTED))
->=20=20=20=20=20=20=20=20
        	sched_yield();

If the interrupt hits between the test and the actual syscall entry,
then the kernel might reschedule and clear the grant.

And no, local_test_and_clear(GRANTED) does not help either because if
that evaluates to true, then the syscall has to be issued anyway to
reset the kernel state for the price of a brief period of inconsistent
state between kernel and user space, which is not an option at all.

The kernel side does in the NEED_RESCHED check:

    if (!tsk->state)
    	return false;

    if (tsk->state =3D=3D GRANTED) {
    	tsk->rseq->flags &=3D ~GRANTED;
        tsk->state =3D=3D ENABLED;
        return false;
    }

    if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL)
    	return false;

    if (tsk->rseq->flags & REQUEST)
    	return false;

    tsk->rseq->flags &=3D ~REQUEST;
    tsk->rseq->flags |=3D GRANTED;
    tsk->state =3D GRANTED;
    return true;

and sched_yield() does:

    if (tsk->state =3D=3D GRANTED) {
    	tsk->rseq->flags &=3D ~GRANTED;
        set_need_resched();
    }

This obviously needs some sanity checks, whether user space violated the
contract, but they are cheep because the operations on the user space
flags are RMW and the value is already loaded into a register.

Now taking the rseq event_mask into account the NEED_RESCHED side needs
additionally:

    if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL)
    	return false;

+    if (tsk->rseq_event_mask)
+    	return false;

    if (tsk->rseq->flags & REQUEST)
    	return false;

Because if that is set then the task was preempted, migrated, had a
signal delivered and then the slice extension is moot.

The sched_yield() abuse wants some sanity checking. The simplest way to
achieve that is to create SYSCALL_WORK for it.

When granted:=20
   set_task_syscall_work(t, SYSCALL_RSEQ_SLICE);

On reset
   clear_task_syscall_work(t, SYSCALL_RSEQ_SLICE);

Plus the corresponding syscall work function, which sets NEED_RESCHED
and clears the kernel and user space state. Along with state checks and
a check whether syscallnr =3D=3D sched_yield. If not, kill the beast.

You _CANNOT_ rely on user space behaving correctly, you need to enforce
it and inconsistent state is not an option. Look how strict the RSEQ
critical section code or the futex code is about that. There is no room
for assumptions.

It's still required to hook into __rseq_handle_notify_resume() to reset
the grant when event_mask is not empty. This handles the case where the
task is scheduled out in exit work e.g. through a cond_resched() or
blocking on a mutex. Then the subsequent iteration in the loop won't
have NEED_RESCHED set, but the GRANTED state is still there and makes no
sense anymore. In that case TIF_NOTIFY_RESUME is set, which ends up
calling into the rseq code.

TBH, my interest to stare at yet another variant of undocumented hacks,
which inflict pointless overhead into the hotpaths, is very close to
zero.

As I've already analyzed this in depth, I sat down for half a day
and converted the analysis into code.

See combo patch below. I still need to address a few details and write
change logs for the 17 patches, which introduce this gradually and in a
reviewable way. I'll send that out in the next days.

What's interesting is that the selftest does not expose a big advantage
vs. the rescheduled case.

 # Success        1491820
 # Yielded         123792
 # Raced                0
 # Scheduled           27

but that might depend on the actual scheduling interference pattern.

The Success number might be misleading as the kernel might still have
rescheduled without touching the user space bits, but enforcing an
update for that is just extra pointless overhead.

I wasn't able to trigger the sched_yield() race yet, but that's
obviously a question of interrupt and scheduling patterns as well.

Thanks,

        tglx
---
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -2,11 +2,12 @@
 #ifndef __LINUX_IRQENTRYCOMMON_H
 #define __LINUX_IRQENTRYCOMMON_H
=20
+#include <linux/context_tracking.h>
+#include <linux/kmsan.h>
+#include <linux/rseq.h>
 #include <linux/static_call_types.h>
 #include <linux/syscalls.h>
-#include <linux/context_tracking.h>
 #include <linux/tick.h>
-#include <linux/kmsan.h>
 #include <linux/unwind_deferred.h>
=20
 #include <asm/entry-common.h>
@@ -67,6 +68,7 @@ static __always_inline bool arch_in_rcu_
=20
 /**
  * enter_from_user_mode - Establish state when coming from user mode
+ * @regs:	Pointer to currents pt_regs
  *
  * Syscall/interrupt entry disables interrupts, but user mode is traced as
  * interrupts enabled. Also with NO_HZ_FULL RCU might be idle.
@@ -195,15 +197,13 @@ static __always_inline void arch_exit_to
  */
 void arch_do_signal_or_restart(struct pt_regs *regs);
=20
-/**
- * exit_to_user_mode_loop - do any pending work before leaving to user spa=
ce
- */
-unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
-				     unsigned long ti_work);
+/* Handle pending TIF work */
+unsigned long exit_to_user_mode_loop(struct pt_regs *regs, unsigned long t=
i_work, bool from_irq);
=20
 /**
  * exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
  * @regs:	Pointer to pt_regs on entry stack
+ * @from_irq:	Exiting to user space from an interrupt
  *
  * 1) check that interrupts are disabled
  * 2) call tick_nohz_user_enter_prepare()
@@ -211,7 +211,7 @@ unsigned long exit_to_user_mode_loop(str
  *    EXIT_TO_USER_MODE_WORK are set
  * 4) check that interrupts are still disabled
  */
-static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
+static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs=
, bool from_irq)
 {
 	unsigned long ti_work;
=20
@@ -222,16 +222,28 @@ static __always_inline void exit_to_user
=20
 	ti_work =3D read_thread_flags();
 	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
-		ti_work =3D exit_to_user_mode_loop(regs, ti_work);
+		ti_work =3D exit_to_user_mode_loop(regs, ti_work, from_irq);
=20
 	arch_exit_to_user_mode_prepare(regs, ti_work);
=20
+	rseq_exit_to_user_mode();
+
 	/* Ensure that kernel state is sane for a return to userspace */
 	kmap_assert_nomap();
 	lockdep_assert_irqs_disabled();
 	lockdep_sys_exit();
 }
=20
+static __always_inline void syscall_exit_to_user_mode_prepare(struct pt_re=
gs *regs)
+{
+	exit_to_user_mode_prepare(regs, false);
+}
+
+static __always_inline void irqentry_exit_to_user_mode_prepare(struct pt_r=
egs *regs)
+{
+	exit_to_user_mode_prepare(regs, true);
+}
+
 /**
  * exit_to_user_mode - Fixup state when exiting to user mode
  *
@@ -354,6 +366,7 @@ irqentry_state_t noinstr irqentry_enter(
  * Conditional reschedule with additional sanity checks.
  */
 void raw_irqentry_exit_cond_resched(void);
+
 #ifdef CONFIG_PREEMPT_DYNAMIC
 #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #define irqentry_exit_cond_resched_dynamic_enabled	raw_irqentry_exit_cond_=
resched
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -4,6 +4,7 @@
=20
 #ifdef CONFIG_RSEQ
=20
+#include <linux/jump_label.h>
 #include <linux/preempt.h>
 #include <linux/sched.h>
=20
@@ -61,6 +62,20 @@ static inline void rseq_migrate(struct t
 	rseq_set_notify_resume(t);
 }
=20
+static __always_inline void rseq_slice_extension_timer(void);
+
+static __always_inline void rseq_exit_to_user_mode(void)
+{
+	rseq_slice_extension_timer();
+	/*
+	 * Clear the event mask so it does not contain stale bits when
+	 * coming back from user space.
+	 */
+	current->rseq_event_mask =3D 0;
+}
+
+static inline void rseq_slice_fork(struct task_struct *t, bool inherit);
+
 /*
  * If parent process has a registered restartable sequences area, the
  * child inherits. Unregister rseq for a clone with CLONE_VM set.
@@ -72,11 +87,13 @@ static inline void rseq_fork(struct task
 		t->rseq_len =3D 0;
 		t->rseq_sig =3D 0;
 		t->rseq_event_mask =3D 0;
+		rseq_slice_fork(t, false);
 	} else {
 		t->rseq =3D current->rseq;
 		t->rseq_len =3D current->rseq_len;
 		t->rseq_sig =3D current->rseq_sig;
 		t->rseq_event_mask =3D current->rseq_event_mask;
+		rseq_slice_fork(t, true);
 	}
 }
=20
@@ -86,46 +103,127 @@ static inline void rseq_execve(struct ta
 	t->rseq_len =3D 0;
 	t->rseq_sig =3D 0;
 	t->rseq_event_mask =3D 0;
+	rseq_slice_fork(t, false);
 }
=20
-#else
+#else /* CONFIG_RSEQ */
+static inline void rseq_set_notify_resume(struct task_struct *t) { }
+static inline void rseq_handle_notify_resume(struct ksignal *ksig, struct =
pt_regs *regs) { }
+static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_reg=
s *regs) { }
+static inline void rseq_preempt(struct task_struct *t) { }
+static inline void rseq_migrate(struct task_struct *t) { }
+static inline void rseq_fork(struct task_struct *t, unsigned long clone_fl=
ags) { }
+static inline void rseq_execve(struct task_struct *t) { }
+static inline void rseq_exit_to_user_mode(void) { }
+#endif  /* !CONFIG_RSEQ */
=20
-static inline void rseq_set_notify_resume(struct task_struct *t)
-{
-}
-static inline void rseq_handle_notify_resume(struct ksignal *ksig,
-					     struct pt_regs *regs)
-{
-}
-static inline void rseq_signal_deliver(struct ksignal *ksig,
-				       struct pt_regs *regs)
+#ifdef CONFIG_RSEQ_SLICE_EXTENSION
+/*
+ * Constants for task::rseq_slice_extension:
+ *
+ * ENABLED is set when the task enables it via prctl()
+ * GRANTED is set when the kernel grants an extension on interrupt return
+ *	   to user space. Implies ENABLED
+ */
+#define RSEQ_SLICE_EXTENSION_ENABLED	0x1
+#define RSEQ_SLICE_EXTENSION_GRANTED	0x2
+
+DECLARE_STATIC_KEY_TRUE(rseq_slice_extension_key);
+
+static inline bool rseq_slice_extension_enabled(void)
 {
+	return static_branch_likely(&rseq_slice_extension_key);
 }
-static inline void rseq_preempt(struct task_struct *t)
+
+int rseq_slice_extension_prctl(unsigned long arg2, unsigned long arg3);
+bool rseq_syscall_enter_work(long syscall);
+void __rseq_slice_extension_timer(void);
+bool __rseq_grant_slice_extension(unsigned int slext);
+
+#ifdef CONFIG_PREEMPT_RT
+#define	RSEQ_TIF_DENY	(_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL | _TIF_NEED_RE=
SCHED)
+#else
+#define	RSEQ_TIF_DENY	(_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL)
+#endif
+
+static __always_inline bool rseq_grant_slice_extension(unsigned long ti_wo=
rk)
 {
+	unsigned int slext;
+
+	if (!rseq_slice_extension_enabled())
+		return false;
+
+	slext =3D current->rseq_slice_extension;
+	if (likely(!slext))
+		return false;
+
+	/*
+	 * Two quick check conditions where a grant is not possible:
+	 *  1) Signal is pending, which means the task will return
+	 *     to the signal handler and not to the interrupted code
+	 *
+	 *  2) On RT, when NEED_RESCHED is set. RT grants only when
+	 *     NEED_RESCHED_LAZY is set.
+	 *
+	 * In both cases __rseq_grant_slice_extension() has to be invoked
+	 * when the extension was already granted to clear it.
+	 */
+	if (ti_work & RSEQ_TIF_DENY && !(slext & RSEQ_SLICE_EXTENSION_GRANTED))
+		return false;
+	return __rseq_grant_slice_extension(slext);
+}
+
+static inline bool rseq_slice_extension_resched(void)
+{
+	if (!rseq_slice_extension_enabled())
+		return false;
+
+	if (unlikely(current->rseq_slice_extension & RSEQ_SLICE_EXTENSION_GRANTED=
)) {
+		set_tsk_need_resched(current);
+		return true;
+	}
+	return false;
 }
-static inline void rseq_migrate(struct task_struct *t)
+
+static __always_inline void rseq_slice_extension_timer(void)
 {
+	if (!rseq_slice_extension_enabled())
+		return;
+
+	if (unlikely(current->rseq_slice_extension & RSEQ_SLICE_EXTENSION_GRANTED=
))
+		__rseq_slice_extension_timer();
 }
-static inline void rseq_fork(struct task_struct *t, unsigned long clone_fl=
ags)
+
+static inline void rseq_slice_fork(struct task_struct *t, bool inherit)
 {
+	if (inherit)
+		t->rseq_slice_extension =3D current->rseq_slice_extension;
+	else
+		t->rseq_slice_extension =3D 0;
 }
-static inline void rseq_execve(struct task_struct *t)
+
+static inline void rseq_slice_extension_disable(void)
 {
+	current->rseq_slice_extension =3D 0;
 }
=20
-#endif
-
-#ifdef CONFIG_DEBUG_RSEQ
-
-void rseq_syscall(struct pt_regs *regs);
-
-#else
-
-static inline void rseq_syscall(struct pt_regs *regs)
+#else /* CONFIG_RSEQ_SLICE_EXTENSION */
+static inline bool rseq_slice_extension_enabled(void) { return false; }
+static inline bool rseq_slice_extension_resched(void) { return false; }
+static inline bool rseq_syscall_enter_work(long syscall) { return false; }
+static __always_inline void rseq_slice_extension_timer(void) { }
+static inline int rseq_slice_extension_prctl(unsigned long arg2, unsigned =
long arg3)
 {
+	return -EINVAL;
 }
+static inline void rseq_slice_fork(struct task_struct *t, bool inherit) { }
+static inline void rseq_slice_extension_disable(void) { }
+#endif /* !CONFIG_RSEQ_SLICE_EXTENSION */
=20
-#endif
+#ifdef CONFIG_DEBUG_RSEQ
+void rseq_debug_syscall_exit(struct pt_regs *regs);
+#else /* CONFIG_DEBUG_RSEQ */
+static inline void rseq_debug_syscall_exit(struct pt_regs *regs) { }
+#endif /* !CONFIG_DEBUG_RSEQ */
=20
 #endif /* _LINUX_RSEQ_H */
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -8,24 +8,36 @@
  * Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  */
=20
+#include <linux/prctl.h>
+#include <linux/ratelimit.h>
+#include <linux/rseq.h>
 #include <linux/sched.h>
-#include <linux/uaccess.h>
 #include <linux/syscalls.h>
-#include <linux/rseq.h>
+#include <linux/sysctl.h>
 #include <linux/types.h>
-#include <linux/ratelimit.h>
+#include <linux/uaccess.h>
+
 #include <asm/ptrace.h>
=20
+#include "sched/hrtick.h"
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/rseq.h>
=20
 /* The original rseq structure size (including padding) is 32 bytes. */
 #define ORIG_RSEQ_SIZE		32
=20
-#define RSEQ_CS_NO_RESTART_FLAGS (RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT | \
-				  RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL | \
+#define RSEQ_CS_NO_RESTART_FLAGS (RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT |	\
+				  RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL |	\
 				  RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE)
=20
+#ifdef CONFIG_RSEQ_SLICE_EXTENSION
+#define RSEQ_CS_VALID_FLAGS	 (RSEQ_CS_FLAG_SLICE_EXT_REQUEST |	\
+				  RSEQ_CS_FLAG_SLICE_EXT_GRANTED)
+#else
+#define RSEQ_CS_VALID_FLAGS	 (0)
+#endif
+
 #ifdef CONFIG_DEBUG_RSEQ
 static struct rseq *rseq_kernel_fields(struct task_struct *t)
 {
@@ -313,12 +325,12 @@ static bool rseq_warn_flags(const char *
 {
 	u32 test_flags;
=20
-	if (!flags)
+	if (!(flags & ~RSEQ_CS_VALID_FLAGS))
 		return false;
 	test_flags =3D flags & RSEQ_CS_NO_RESTART_FLAGS;
 	if (test_flags)
 		pr_warn_once("Deprecated flags (%u) in %s ABI structure", test_flags, st=
r);
-	test_flags =3D flags & ~RSEQ_CS_NO_RESTART_FLAGS;
+	test_flags =3D flags & ~(RSEQ_CS_NO_RESTART_FLAGS | RSEQ_CS_VALID_FLAGS);
 	if (test_flags)
 		pr_warn_once("Unknown flags (%u) in %s ABI structure", test_flags, str);
 	return true;
@@ -410,6 +422,8 @@ static int rseq_ip_fixup(struct pt_regs
 	return 0;
 }
=20
+static inline bool rseq_reset_slice_extension(struct task_struct *t);
+
 /*
  * This resume handler must always be executed between any of:
  * - preemption,
@@ -430,11 +444,16 @@ void __rseq_handle_notify_resume(struct
 		return;
=20
 	/*
-	 * regs is NULL if and only if the caller is in a syscall path.  Skip
-	 * fixup and leave rseq_cs as is so that rseq_sycall() will detect and
-	 * kill a misbehaving userspace on debug kernels.
+	 * If invoked from hypervisors or IO-URING @regs is a NULL pointer,
+	 * so fixup cannot be done. If the syscall which led to this
+	 * invocation was invoked inside a critical section, then it can
+	 * only be detected on a debug kernel in rseq_debug_syscall_exit(),
+	 * which will detect and kill a misbehaving userspace.
 	 */
 	if (regs) {
+		if (!rseq_reset_slice_extension(t))
+			goto error;
+
 		ret =3D rseq_ip_fixup(regs);
 		if (unlikely(ret < 0))
 			goto error;
@@ -454,7 +473,7 @@ void __rseq_handle_notify_resume(struct
  * Terminate the process if a syscall is issued within a restartable
  * sequence.
  */
-void rseq_syscall(struct pt_regs *regs)
+void rseq_debug_syscall_exit(struct pt_regs *regs)
 {
 	unsigned long ip =3D instruction_pointer(regs);
 	struct task_struct *t =3D current;
@@ -490,6 +509,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
 		ret =3D rseq_reset_rseq_cpu_node_id(current);
 		if (ret)
 			return ret;
+		rseq_slice_extension_disable();
 		current->rseq =3D NULL;
 		current->rseq_sig =3D 0;
 		current->rseq_len =3D 0;
@@ -571,3 +591,189 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
=20
 	return 0;
 }
+
+#ifdef CONFIG_RSEQ_SLICE_EXTENSION
+DEFINE_STATIC_KEY_TRUE(rseq_slice_extension_key);
+
+static unsigned int rseq_slice_ext_nsecs __read_mostly =3D 30 * NSEC_PER_U=
SEC;
+
+#ifdef CONFIG_SYSCTL
+static const unsigned int rseq_slice_ext_nsecs_min =3D 10 * NSEC_PER_USEC;
+static const unsigned int rseq_slice_ext_nsecs_max =3D 50 * NSEC_PER_USEC;
+
+static const struct ctl_table rseq_slice_ext_sysctl[] =3D {
+	{
+		.procname	=3D "rseq_slice_extension_nsec",
+		.maxlen		=3D sizeof(unsigned int),
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_douintvec_minmax,
+		.extra1		=3D (unsigned int *)&rseq_slice_ext_nsecs_min,
+		.extra2		=3D (unsigned int *)&rseq_slice_ext_nsecs_max,
+	},
+};
+
+static int __init rseq_sysctl_init(void)
+{
+	register_sysctl("kernel", rseq_slice_ext_sysctl);
+	return 0;
+}
+device_initcall(rseq_sysctl_init);
+#endif /* !CONFIG_SYSCTL */
+
+static inline bool rseq_clear_slice_granted(struct task_struct *curr, u32 =
rflags)
+{
+	/* Check whether user space violated the contract */
+	if (rflags & RSEQ_CS_FLAG_SLICE_EXT_REQUEST)
+		return false;
+	if (!(rflags & RSEQ_CS_FLAG_SLICE_EXT_GRANTED))
+		return false;
+
+	rflags &=3D ~RSEQ_CS_FLAG_SLICE_EXT_GRANTED;
+	return !put_user(rflags, &curr->rseq->flags);
+}
+
+static bool __rseq_reset_slice_extension(struct task_struct *curr)
+{
+	u32 rflags;
+
+	if (get_user(rflags, &curr->rseq->flags))
+		return false;
+	return rseq_clear_slice_granted(curr, rflags);
+}
+
+static inline bool rseq_reset_slice_extension(struct task_struct *curr)
+{
+	if (!rseq_slice_extension_enabled())
+		return true;
+
+	if (likely(!(curr->rseq_slice_extension & RSEQ_SLICE_EXTENSION_GRANTED)))
+		return true;
+	if (likely(!curr->rseq_event_mask))
+		return true;
+
+	clear_task_syscall_work(curr, SYSCALL_RSEQ_SLICE);
+	curr->rseq_slice_extension =3D RSEQ_SLICE_EXTENSION_ENABLED;
+
+	return __rseq_reset_slice_extension(curr);
+}
+
+/*
+ * Invoked from syscall entry if a time slice extension was granted and the
+ * kernel did not clear it before user space left the critical section.
+ */
+bool rseq_syscall_enter_work(long syscall)
+{
+	struct task_struct *curr =3D current;
+	unsigned int slext =3D curr->rseq_slice_extension;
+
+	clear_task_syscall_work(curr, SYSCALL_RSEQ_SLICE);
+	curr->rseq_slice_extension =3D RSEQ_SLICE_EXTENSION_ENABLED;
+
+	/*
+	 * Kernel internal state inconsistency. SYSCALL_RSEQ_SLICE can only
+	 * be set when state is GRANTED!
+	 */
+	if (WARN_ON_ONCE(slext !=3D RSEQ_SLICE_EXTENSION_GRANTED))
+		return false;
+
+	set_tsk_need_resched(curr);
+
+	if (unlikely(!__rseq_reset_slice_extension(curr) || syscall !=3D __NR_sch=
ed_yield))
+		force_sigsegv(0);
+
+	/* Abort syscall to reschedule immediately */
+	return true;
+}
+
+bool __rseq_grant_slice_extension(unsigned int slext)
+{
+	struct task_struct *curr =3D current;
+	u32 rflags;
+
+	if (unlikely(get_user(rflags, &curr->rseq->flags)))
+		goto die;
+
+	/*
+	 * Happens when exit_to_user_mode_loop() loops and has
+	 * TIF_NEED_RESCHED* set again. Clear the grant and schedule.
+	 */
+	if (unlikely(slext =3D=3D RSEQ_SLICE_EXTENSION_GRANTED)) {
+		curr->rseq_slice_extension =3D RSEQ_SLICE_EXTENSION_ENABLED;
+		clear_task_syscall_work(curr, SYSCALL_RSEQ_SLICE);
+		if (!rseq_clear_slice_granted(curr, rflags))
+			goto die;
+		return false;
+	}
+
+	/* User space set the flag. That's a violation of the contract. */
+	if (unlikely(rflags & RSEQ_CS_FLAG_SLICE_EXT_GRANTED))
+		goto die;
+
+	/* User space is not interrested. */
+	if (likely(!(rflags & RSEQ_CS_FLAG_SLICE_EXT_REQUEST)))
+		return false;
+
+	/*
+	 * Don't bother if the rseq event mask has bits pending. The task
+	 * was preempted.
+	 */
+	if (curr->rseq_event_mask)
+		return false;
+
+	/* Grant the request and update user space */
+	rflags &=3D ~RSEQ_CS_FLAG_SLICE_EXT_REQUEST;
+	rflags |=3D RSEQ_CS_FLAG_SLICE_EXT_GRANTED;
+	if (unlikely(put_user(rflags, &curr->rseq->flags)))
+		goto die;
+
+	curr->rseq_slice_extension =3D RSEQ_SLICE_EXTENSION_GRANTED;
+	set_task_syscall_work(curr, SYSCALL_RSEQ_SLICE);
+	clear_tsk_need_resched(curr);
+	return true;
+die:
+	force_sig(SIGSEGV);
+	return false;
+}
+
+void __rseq_slice_extension_timer(void)
+{
+	hrtick_extend_timeslice(rseq_slice_ext_nsecs);
+}
+
+int rseq_slice_extension_prctl(unsigned long arg2, unsigned long arg3)
+{
+	switch (arg2) {
+	case PR_RSEQ_SLICE_EXTENSION_GET:
+		if (arg3)
+			return -EINVAL;
+		return current->rseq_slice_extension ? PR_RSEQ_SLICE_EXT_ENABLE : 0;
+
+	case PR_RSEQ_SLICE_EXTENSION_SET:
+		if (arg3 & ~PR_RSEQ_SLICE_EXT_ENABLE)
+			return -EINVAL;
+		if (!rseq_slice_extension_enabled() || !current->rseq)
+			return -ENOTSUPP;
+		current->rseq_slice_extension =3D (arg3 & PR_RSEQ_SLICE_EXT_ENABLE) ?
+			RSEQ_SLICE_EXTENSION_ENABLED : 0;
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int __init rseq_slice_cmdline(char *str)
+{
+	bool on;
+
+	if (kstrtobool(str, &on))
+		return -EINVAL;
+
+	if (!on)
+		static_branch_disable(&rseq_slice_extension_key);
+	return 0;
+}
+__setup("rseq_slice_ext=3D", rseq_slice_cmdline);
+#else /* CONFIG_RSEQ_SLICE_EXTENSION */
+static inline bool rseq_reset_slice_extension(struct task_struct *t) { ret=
urn true; }
+#endif /* !CONFIG_RSEQ_SLICE_EXTENSION */
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -3,11 +3,11 @@
 #define __LINUX_ENTRYCOMMON_H
=20
 #include <linux/irq-entry-common.h>
+#include <linux/livepatch.h>
 #include <linux/ptrace.h>
+#include <linux/resume_user_mode.h>
 #include <linux/seccomp.h>
 #include <linux/sched.h>
-#include <linux/livepatch.h>
-#include <linux/resume_user_mode.h>
=20
 #include <asm/entry-common.h>
 #include <asm/syscall.h>
@@ -36,6 +36,7 @@
 				 SYSCALL_WORK_SYSCALL_EMU |		\
 				 SYSCALL_WORK_SYSCALL_AUDIT |		\
 				 SYSCALL_WORK_SYSCALL_USER_DISPATCH |	\
+				 SYSCALL_WORK_SYSCALL_RSEQ_SLICE |	\
 				 ARCH_SYSCALL_WORK_ENTER)
 #define SYSCALL_WORK_EXIT	(SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
 				 SYSCALL_WORK_SYSCALL_TRACE |		\
@@ -61,8 +62,7 @@
  */
 void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
=20
-long syscall_trace_enter(struct pt_regs *regs, long syscall,
-			 unsigned long work);
+long syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long=
 work);
=20
 /**
  * syscall_enter_from_user_mode_work - Check and handle work before invoki=
ng
@@ -162,7 +162,7 @@ static __always_inline void syscall_exit
 			local_irq_enable();
 	}
=20
-	rseq_syscall(regs);
+	rseq_debug_syscall_exit(regs);
=20
 	/*
 	 * Do one-time syscall specific work. If these work items are
@@ -172,7 +172,7 @@ static __always_inline void syscall_exit
 	if (unlikely(work & SYSCALL_WORK_EXIT))
 		syscall_exit_work(regs, work);
 	local_irq_disable_exit_to_user();
-	exit_to_user_mode_prepare(regs);
+	syscall_exit_to_user_mode_prepare(regs);
 }
=20
 /**
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -15,9 +15,10 @@ void __weak arch_do_signal_or_restart(st
  * exit_to_user_mode_loop - do any pending work before leaving to user spa=
ce
  * @regs:	Pointer to pt_regs on entry stack
  * @ti_work:	TIF work flags as read by the caller
+ * @from_irq:	Exiting to user space from an interrupt
  */
-__always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
-						     unsigned long ti_work)
+__always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,=
 unsigned long ti_work,
+						     bool from_irq)
 {
 	/*
 	 * Before returning to user space ensure that all pending work
@@ -27,8 +28,15 @@ void __weak arch_do_signal_or_restart(st
=20
 		local_irq_enable_exit_to_user(ti_work);
=20
-		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
-			schedule();
+		/*
+		 * FIXME: This should actually take the execution time
+		 *        of the rest of the loop into account and refuse
+		 *        the extension if there is other work to do.
+		 */
+		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY)) {
+			if (!from_irq || !rseq_grant_slice_extension(ti_work))
+				schedule();
+		}
=20
 		if (ti_work & _TIF_UPROBE)
 			uprobe_notify_resume(regs);
@@ -70,7 +78,7 @@ noinstr void irqentry_enter_from_user_mo
 noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
 {
 	instrumentation_begin();
-	exit_to_user_mode_prepare(regs);
+	irqentry_exit_to_user_mode_prepare(regs);
 	instrumentation_end();
 	exit_to_user_mode();
 }
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -21,6 +21,7 @@ System calls
    ebpf/index
    ioctl/index
    mseal
+   rseq
=20
 Security-related interfaces
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
--- /dev/null
+++ b/Documentation/userspace-api/rseq.rst
@@ -0,0 +1,92 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Restartable Sequences
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Restartable Sequences allow to register a per thread userspace memory area
+to be used as an ABI between kernel and user-space for three purposes:
+
+ * user-space restartable sequences
+
+ * quick access to read the current CPU number, node ID from user-space
+
+ * scheduler time slice extensions
+
+Restartable sequences (per-cpu atomics)
+---------------------------------------
+
+Restartables sequences allow user-space to perform update operations on
+per-cpu data without requiring heavy-weight atomic operations. The actual
+ABI is unfortunately only available in the code and selftests.
+
+Quick access to CPU number, node ID
+-----------------------------------
+
+Allows to implement per CPU data efficiently. Documentation is in code and
+selftests. :(
+
+Scheduler time slice extensions
+-------------------------------
+
+This allows a thread to request a time slice extension when it enters a
+critical section to avoid contention on a resource when the thread is
+scheduled out inside of the critical section.
+
+The prerequisites for this functionality are:
+
+    * Enabled in Kconfig
+
+    * Enabled at boot time (default is enabled)
+
+    * A rseq user space pointer has been registered for the thread
+
+The thread has to enable the functionality via prctl(2)::
+
+    prctl(PR_RSEQ_SLICE_EXTENSION, PR_RSEQ_SLICE_EXTENSION_SET,
+          PR_RSEQ_SLICE_EXT_ENABLE, 0, 0);
+
+If granted the thread can request a time slice extension by setting the
+``RSEQ_CS_FLAG_SLICE_EXT_REQUEST_BIT`` in the rseq::flags field. If the
+thread is interrupted and the interrupt results in a reschedule request in
+the kernel, then the kernel can grant a time slice extension and return to
+user space instead of scheduling out. The kernel indicates the grant by
+clearing ``RSEQ_CS_FLAG_SLICE_EXT_REQUEST_BIT`` and setting
+``RSEQ_CS_FLAG_SLICE_EXT_GRANTED_BIT`` in the rseq::flags field. If there
+is a reschedule of the thread after granting the extension, the kernel
+clears the granted bit to indicate that to user space.
+
+If the request bit is still set when the leaving the critical section, user
+space can clear it and continue.
+
+If the granted bit is set, then user space has to invoke sched_yield() when
+leaving the critical section to relinquish the CPU. The kernel enforces
+this by arming a timer to prevent misbehaving user space from abusing this
+mechanism.
+
+If both the request bit and the granted bit are false when leaving the
+critical section, then this indicates that a grant was revoked and no
+further action is required by user space.
+
+The required code flow is as follows::
+
+    local_set_bit(REQUEST, &rseq->flags);
+    critical_section();
+    if (!local_test_and_clear_bit(REQUEST, &rseq->flags)) {
+        if (local_test_bit(GRANTED, &rseq->flags))
+                sched_yield();
+    }
+
+The local bit operations on the flags, except for local_test_bit() have to
+be atomically versus the local CPU to prevent the obvious RMW race versus
+an interrupt. On X86 this can be achieved with ORB and BTRL without LOCK
+prefix. On architectures, which do not provide lightweight CPU local
+atomics this needs to be implemented with regular atomic operations.
+
+local_test_bit() has no atomicity requirements as there is obviously a
+race which cannot be avoided at all::
+
+        if (local_test_bit(GRANTED))
+	-> Interrupt results in schedule and grant revocation
+                sched_yield();
+
+The kernel enforces flag consistency and terminates the thread with SIGSEGV
+if it detects a violation.
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1408,7 +1408,10 @@ struct task_struct {
 	 * RmW on rseq_event_mask must be performed atomically
 	 * with respect to preemption.
 	 */
-	unsigned long rseq_event_mask;
+	unsigned long			rseq_event_mask;
+#ifdef CONFIG_RSEQ_SLICE_EXTENSION
+	unsigned int			rseq_slice_extension;
+#endif
 # ifdef CONFIG_DEBUG_RSEQ
 	/*
 	 * This is a place holder to save a copy of the rseq fields for
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -26,6 +26,8 @@ enum rseq_cs_flags_bit {
 	RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT	=3D 0,
 	RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT	=3D 1,
 	RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT	=3D 2,
+	RSEQ_CS_FLAG_SLICE_EXT_REQUEST_BIT	=3D 3,
+	RSEQ_CS_FLAG_SLICE_EXT_GRANTED_BIT	=3D 4,
 };
=20
 enum rseq_cs_flags {
@@ -35,6 +37,10 @@ enum rseq_cs_flags {
 		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT),
 	RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE	=3D
 		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
+	RSEQ_CS_FLAG_SLICE_EXT_REQUEST		=3D
+		(1U << RSEQ_CS_FLAG_SLICE_EXT_REQUEST_BIT),
+	RSEQ_CS_FLAG_SLICE_EXT_GRANTED		=3D
+		(1U << RSEQ_CS_FLAG_SLICE_EXT_GRANTED_BIT),
 };
=20
 /*
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1883,6 +1883,18 @@ config RSEQ
=20
 	  If unsure, say Y.
=20
+config RSEQ_SLICE_EXTENSION
+	bool "Enable rseq based time slice extension mechanism"
+	depends on RSEQ && SCHED_HRTICK
+	help
+          Allows userspace to request a limited time slice extension when
+	  returning from an interrupt to user space via the RSEQ shared
+	  data ABI. If granted, that allows to complete a critical section,
+	  so that other threads are not stuck on a conflicted resource,
+	  while the task is scheduled out.
+
+	  If unsure, say N.
+
 config DEBUG_RSEQ
 	default n
 	bool "Enable debugging of rseq() system call" if EXPERT
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -376,4 +376,14 @@ struct prctl_mm_map {
 # define PR_FUTEX_HASH_SET_SLOTS	1
 # define PR_FUTEX_HASH_GET_SLOTS	2
=20
+/* RSEQ time slice extensions */
+#define PR_RSEQ_SLICE_EXTENSION			79
+# define PR_RSEQ_SLICE_EXTENSION_GET		1
+# define PR_RSEQ_SLICE_EXTENSION_SET		2
+/*
+ * Bits for RSEQ_SLICE_EXTENSION_GET/SET
+ * PR_RSEQ_SLICE_EXT_ENABLE:	Enable
+ */
+# define PR_RSEQ_SLICE_EXT_ENABLE		0x01
+
 #endif /* _LINUX_PRCTL_H */
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -53,6 +53,7 @@
 #include <linux/time_namespace.h>
 #include <linux/binfmts.h>
 #include <linux/futex.h>
+#include <linux/rseq.h>
=20
 #include <linux/sched.h>
 #include <linux/sched/autogroup.h>
@@ -2805,6 +2806,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
 	case PR_FUTEX_HASH:
 		error =3D futex_hash_prctl(arg2, arg3, arg4);
 		break;
+	case PR_RSEQ_SLICE_EXTENSION:
+		if (arg4 || arg5)
+			return -EINVAL;
+		error =3D rseq_slice_extension_prctl(arg2, arg3);
+		break;
 	default:
 		trace_task_prctl_unknown(option, arg2, arg3, arg4, arg5);
 		error =3D -EINVAL;
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -90,6 +90,7 @@
 #include "stats.h"
=20
 #include "autogroup.h"
+#include "hrtick.h"
 #include "pelt.h"
 #include "smp.h"
=20
@@ -873,6 +874,10 @@ static enum hrtimer_restart hrtick(struc
=20
 	WARN_ON_ONCE(cpu_of(rq) !=3D smp_processor_id());
=20
+	// CHECKME: Is this correct?
+	if (rseq_slice_extension_resched())
+		return HRTIMER_NORESTART;
+
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
 	rq->donor->sched_class->task_tick(rq, rq->curr, 1);
@@ -902,6 +907,14 @@ static void __hrtick_start(void *arg)
 	rq_unlock(rq, &rf);
 }
=20
+void hrtick_extend_timeslice(ktime_t nsecs)
+{
+	struct rq *rq =3D this_rq();
+
+	guard(rq_lock_irqsave)(rq);
+	hrtimer_start(&rq->hrtick_timer, nsecs, HRTIMER_MODE_REL_PINNED_HARD);
+}
+
 /*
  * Called to set the hrtick timer state.
  *
--- /dev/null
+++ b/kernel/sched/hrtick.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _KERNEL_SCHED_HRTICK_H
+#define _KERNEL_SCHED_HRTICK_H
+
+/*
+ * Scheduler internal method to support time slice extensions,
+ * shared with rseq.
+ */
+void hrtick_extend_timeslice(ktime_t nsecs);
+
+#endif /* _KERNEL_SCHED_HRTICK_H */
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -46,15 +46,17 @@ enum syscall_work_bit {
 	SYSCALL_WORK_BIT_SYSCALL_AUDIT,
 	SYSCALL_WORK_BIT_SYSCALL_USER_DISPATCH,
 	SYSCALL_WORK_BIT_SYSCALL_EXIT_TRAP,
+	SYSCALL_WORK_BIT_SYSCALL_RSEQ_SLICE,
 };
=20
-#define SYSCALL_WORK_SECCOMP		BIT(SYSCALL_WORK_BIT_SECCOMP)
-#define SYSCALL_WORK_SYSCALL_TRACEPOINT	BIT(SYSCALL_WORK_BIT_SYSCALL_TRACE=
POINT)
-#define SYSCALL_WORK_SYSCALL_TRACE	BIT(SYSCALL_WORK_BIT_SYSCALL_TRACE)
-#define SYSCALL_WORK_SYSCALL_EMU	BIT(SYSCALL_WORK_BIT_SYSCALL_EMU)
-#define SYSCALL_WORK_SYSCALL_AUDIT	BIT(SYSCALL_WORK_BIT_SYSCALL_AUDIT)
-#define SYSCALL_WORK_SYSCALL_USER_DISPATCH BIT(SYSCALL_WORK_BIT_SYSCALL_US=
ER_DISPATCH)
-#define SYSCALL_WORK_SYSCALL_EXIT_TRAP	BIT(SYSCALL_WORK_BIT_SYSCALL_EXIT_T=
RAP)
+#define SYSCALL_WORK_SECCOMP			BIT(SYSCALL_WORK_BIT_SECCOMP)
+#define SYSCALL_WORK_SYSCALL_TRACEPOINT		BIT(SYSCALL_WORK_BIT_SYSCALL_TRAC=
EPOINT)
+#define SYSCALL_WORK_SYSCALL_TRACE		BIT(SYSCALL_WORK_BIT_SYSCALL_TRACE)
+#define SYSCALL_WORK_SYSCALL_EMU		BIT(SYSCALL_WORK_BIT_SYSCALL_EMU)
+#define SYSCALL_WORK_SYSCALL_AUDIT		BIT(SYSCALL_WORK_BIT_SYSCALL_AUDIT)
+#define SYSCALL_WORK_SYSCALL_USER_DISPATCH	BIT(SYSCALL_WORK_BIT_SYSCALL_US=
ER_DISPATCH)
+#define SYSCALL_WORK_SYSCALL_EXIT_TRAP		BIT(SYSCALL_WORK_BIT_SYSCALL_EXIT_=
TRAP)
+#define SYSCALL_WORK_SYSCALL_RSEQ_SLICE		BIT(SYSCALL_WORK_BIT_SYSCALL_RSEQ=
_SLICE)
 #endif
=20
 #include <asm/thread_info.h>
--- a/kernel/entry/syscall-common.c
+++ b/kernel/entry/syscall-common.c
@@ -17,8 +17,7 @@ static inline void syscall_enter_audit(s
 	}
 }
=20
-long syscall_trace_enter(struct pt_regs *regs, long syscall,
-				unsigned long work)
+long syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long=
 work)
 {
 	long ret =3D 0;
=20
@@ -32,6 +31,16 @@ long syscall_trace_enter(struct pt_regs
 			return -1L;
 	}
=20
+	/*
+	 * User space got a time slice extension granted and relinquishes
+	 * the CPU. Abort the syscall right away. If it's not sched_yield()
+	 * rseq_syscall_enter_work() sends a SIGSEGV.
+	 */
+	if (work & SYSCALL_WORK_SYSCALL_RSEQ_SLICE) {
+		if (rseq_syscall_enter_work(syscall))
+			return -1L;
+	}
+
 	/* Handle ptrace */
 	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
 		ret =3D ptrace_report_syscall_entry(regs);
--- a/tools/testing/selftests/rseq/.gitignore
+++ b/tools/testing/selftests/rseq/.gitignore
@@ -10,3 +10,4 @@ param_test_mm_cid
 param_test_mm_cid_benchmark
 param_test_mm_cid_compare_twice
 syscall_errors_test
+slice_test
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -17,7 +17,7 @@ OVERRIDE_TARGETS =3D 1
 TEST_GEN_PROGS =3D basic_test basic_percpu_ops_test basic_percpu_ops_mm_ci=
d_test param_test \
 		param_test_benchmark param_test_compare_twice param_test_mm_cid \
 		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice \
-		syscall_errors_test
+		syscall_errors_test slice_test
=20
 TEST_GEN_PROGS_EXTENDED =3D librseq.so
=20
@@ -59,3 +59,6 @@ include ../lib.mk
 $(OUTPUT)/syscall_errors_test: syscall_errors_test.c $(TEST_GEN_PROGS_EXTE=
NDED) \
 					rseq.h rseq-*.h
 	$(CC) $(CFLAGS) $< $(LDLIBS) -lrseq -o $@
+
+$(OUTPUT)/slice_test: slice_test.c $(TEST_GEN_PROGS_EXTENDED) rseq.h rseq-=
*.h
+	$(CC) $(CFLAGS) $< $(LDLIBS) -lrseq -o $@
--- /dev/null
+++ b/tools/testing/selftests/rseq/slice_test.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: LGPL-2.1
+#define _GNU_SOURCE
+#include <assert.h>
+#include <pthread.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <string.h>
+
+#include <linux/prctl.h>
+#include <sys/prctl.h>
+#include <sys/time.h>
+
+#include "rseq.h"
+
+#include "../kselftest_harness.h"
+
+#define BITS_PER_INT	32
+#define BITS_PER_BYTE	8
+
+#ifndef PR_RSEQ_SLICE_EXTENSION
+# define PR_RSEQ_SLICE_EXTENSION		79
+#  define PR_RSEQ_SLICE_EXTENSION_GET		1
+#  define PR_RSEQ_SLICE_EXTENSION_SET		2
+#  define PR_RSEQ_SLICE_EXT_ENABLE		0x01
+#endif
+
+#ifndef RSEQ_CS_FLAG_SLICE_EXT_REQUEST_BIT
+# define RSEQ_CS_FLAG_SLICE_EXT_REQUEST_BIT	3
+# define RSEQ_CS_FLAG_SLICE_EXT_GRANTED_BIT	4
+#endif
+
+#ifndef asm_inline
+# define asm_inline	asm __inline
+#endif
+
+#if defined(__x86_64__) || defined(__i386__)
+
+static __always_inline bool local_test_and_clear_bit(unsigned int bit,
+						     volatile unsigned int *addr)
+{
+	bool res;
+
+	asm inline volatile("btrl %[__bit], %[__addr]\n"
+			    : [__addr] "+m" (*addr), "=3D@cc" "c" (res)
+			    : [__bit] "Ir" (bit)
+			    : "memory");
+	return res;
+}
+
+static __always_inline void local_set_bit(unsigned int bit, volatile unsig=
ned int *addr)
+{
+	volatile char *caddr =3D (void *)(addr) + (bit / BITS_PER_BYTE);
+
+	asm inline volatile("orb %b[__bit],%[__addr]\n"
+			    : [__addr] "+m" (*caddr)
+			    : [__bit] "iq" (1U << (bit & (BITS_PER_BYTE - 1)))
+			    : "memory");
+}
+
+static __always_inline bool local_test_bit(unsigned int bit, const volatil=
e unsigned int *addr)
+{
+	return !!(addr[bit / BITS_PER_INT] & ((1U << (bit & (BITS_PER_INT - 1))))=
);
+}
+
+#else
+# error unsupported target
+#endif
+
+#define NSEC_PER_SEC	1000000000L
+#define NSEC_PER_USEC	      1000L
+
+struct noise_params {
+	int	noise_nsecs;
+	int	sleep_nsecs;
+	int	run;
+};
+
+FIXTURE(slice_ext)
+{
+	pthread_t		noise_thread;
+	struct noise_params	noise_params;
+};
+
+FIXTURE_VARIANT(slice_ext)
+{
+	int64_t	total_nsecs;
+	int	slice_nsecs;
+	int	noise_nsecs;
+	int	sleep_nsecs;
+};
+
+FIXTURE_VARIANT_ADD(slice_ext, n2_2_50)
+{
+	.total_nsecs	=3D  5 * NSEC_PER_SEC,
+	.slice_nsecs	=3D  2 * NSEC_PER_USEC,
+	.noise_nsecs    =3D  2 * NSEC_PER_USEC,
+	.sleep_nsecs	=3D 50 * NSEC_PER_USEC,
+};
+
+static inline bool elapsed(struct timespec *start, struct timespec *now,
+			   int64_t span)
+{
+	int64_t delta =3D now->tv_sec - start->tv_sec;
+
+	delta *=3D NSEC_PER_SEC;
+	delta +=3D now->tv_nsec - start->tv_nsec;
+	return delta >=3D span;
+}
+
+static void *noise_thread(void *arg)
+{
+	struct noise_params *p =3D arg;
+
+	while (RSEQ_READ_ONCE(p->run)) {
+		struct timespec ts_start, ts_now;
+
+		clock_gettime(CLOCK_MONOTONIC, &ts_start);
+		do {
+			clock_gettime(CLOCK_MONOTONIC, &ts_now);
+		} while (!elapsed(&ts_start, &ts_now, p->noise_nsecs));
+
+		ts_start.tv_sec =3D 0;
+		ts_start.tv_nsec =3D p->sleep_nsecs;
+		clock_nanosleep(CLOCK_MONOTONIC, 0, &ts_start, NULL);
+	}
+	return NULL;
+}
+
+FIXTURE_SETUP(slice_ext)
+{
+	cpu_set_t affinity;
+
+	ASSERT_EQ(sched_getaffinity(0, sizeof(affinity), &affinity), 0);
+
+	/* Pin it on a single CPU. Avoid CPU 0 */
+	for (int i =3D 1; i < CPU_SETSIZE; i++) {
+		if (!CPU_ISSET(i, &affinity))
+			continue;
+
+		CPU_ZERO(&affinity);
+		CPU_SET(i, &affinity);
+		ASSERT_EQ(sched_setaffinity(0, sizeof(affinity), &affinity), 0);
+		break;
+	}
+
+	ASSERT_EQ(rseq_register_current_thread(), 0);
+
+	ASSERT_EQ(prctl(PR_RSEQ_SLICE_EXTENSION, PR_RSEQ_SLICE_EXTENSION_SET,
+			PR_RSEQ_SLICE_EXT_ENABLE, 0, 0), 0);
+
+	self->noise_params.noise_nsecs =3D variant->noise_nsecs;
+	self->noise_params.sleep_nsecs =3D variant->sleep_nsecs;
+	self->noise_params.run =3D 1;
+
+	ASSERT_EQ(pthread_create(&self->noise_thread, NULL, noise_thread, &self->=
noise_params), 0);
+}
+
+FIXTURE_TEARDOWN(slice_ext)
+{
+	self->noise_params.run =3D 0;
+	pthread_join(self->noise_thread, NULL);
+}
+
+TEST_F(slice_ext, slice_test)
+{
+	unsigned long success =3D 0, yielded =3D 0, raced =3D 0, scheduled =3D 0;
+	struct rseq_abi *rs =3D rseq_get_abi();
+	struct timespec ts_start, ts_now;
+
+	ASSERT_NE(rs, NULL);
+
+	clock_gettime(CLOCK_MONOTONIC, &ts_start);
+	do {
+		struct timespec ts_cs;
+
+		clock_gettime(CLOCK_MONOTONIC, &ts_cs);
+
+		local_set_bit(RSEQ_CS_FLAG_SLICE_EXT_REQUEST_BIT, &rs->flags);
+		do {
+			clock_gettime(CLOCK_MONOTONIC, &ts_now);
+		} while (!elapsed(&ts_cs, &ts_now, variant->noise_nsecs));
+
+		if (!local_test_and_clear_bit(RSEQ_CS_FLAG_SLICE_EXT_REQUEST_BIT, &rs->f=
lags)) {
+			if (local_test_bit(RSEQ_CS_FLAG_SLICE_EXT_GRANTED_BIT, &rs->flags)) {
+				yielded++;
+				if (!sched_yield())
+					raced++;
+			} else {
+				scheduled++;
+			}
+		} else {
+			success++;
+		}
+
+		clock_gettime(CLOCK_MONOTONIC, &ts_now);
+	} while (!elapsed(&ts_start, &ts_now, variant->total_nsecs));
+
+	printf("# Success   %12ld\n", success);
+	printf("# Yielded   %12ld\n", yielded);
+	printf("# Raced     %12ld\n", raced);
+	printf("# Scheduled %12ld\n", scheduled);
+}
+
+TEST_HARNESS_MAIN





