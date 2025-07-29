Return-Path: <linux-kernel+bounces-749117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A97BB14A5A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE7B1AA026A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5A4286408;
	Tue, 29 Jul 2025 08:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZL3e/k2R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VtJJHsmn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F1A27F003
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753778772; cv=none; b=VT7rYmHu+ycsg5XEuTbC/EXklHDPwwmedb4LIPo76ar5WJsI2RSEhFFuAkQY58WguWkBhol2TQJjkNkrwNVFBy+F3RAL69wo6xh3isTP1sX5Jum51c/lzo8OMgJJKWjID4hHbBuUGGFEadOKtO92VLT9xyeseG3xy9QRHvuM7jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753778772; c=relaxed/simple;
	bh=OK71wQqfRt289sciD1SJ0ibFUnIcJyy9+uXFqXhzVvQ=;
	h=From:To:Cc:Subject:Message-ID:Content-Type:MIME-Version:Date; b=biuiN7wggBNwlTRQ/GSCyAy891Mytlff6nQwJzD+bS+jkJ8i913rcWNkTKcT7VZh/mHV1C6IP+YqWndhqfXMwyVi10YFjI0OXnVOEuqqpftv7OpMBEfHMcmX952D727TD3jIkzAQyqo4XYCegQSy2u9SCnn6ibhhdGa9CmRwCbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZL3e/k2R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VtJJHsmn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753778766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UMmRz5VqK/i9Ftw1nJRierjKQT0+0j5CNYydRsnH52Y=;
	b=ZL3e/k2R0P4dXxi8O0u0+nhyutP/7wfjrQnmnCMIgjGGqs78nPIq6PR/csmZbFQXcje7ms
	f9qP8L6RJt6AqWt9NTGvKvjn6JuYYBdlNTnrqY67Qe/2JD5jTf8mO3PekocLgoJDJR0Zv1
	M/YYSbsiqRTVu2HFbzOhRv5OoBH/o6aWfzYjc/GdAaboIA2RALO7zeoYOerR5o8J+NDWQJ
	l3N2zA962a1oc6YKJ5+0c5udMqHNoknQXj9taX4TnqYbfsXGCdVlZKeSskcekfk3CiMuFJ
	GmyXIZ+Y3JfrmkgjZWzELC+/ERVqhj0kWjUrfAdKIWr1DiN8g5xxN/E5jciR5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753778766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UMmRz5VqK/i9Ftw1nJRierjKQT0+0j5CNYydRsnH52Y=;
	b=VtJJHsmnn0pJ4OC8Rtb5pUAGbAXvdDdfwEnSz4Af7Lzmdvx+aUtcp919aniLQ1L43XqCTa
	wes2GV/RBu/KQLCA==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/entry for v6.17-rc1
Message-ID: 
 <175377875455.620102.9417697212609201411.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 29 Jul 2025 10:46:05 +0200 (CEST)

Linus,

please pull the latest core/entry branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-entry-2025-=
07-29

up to:  5173ac2dc8c0: Merge tag 'entry-split-for-arm' into core/entry


Updates for the generic entry code:

  - Split the code into syscall and exception/interrupt parts to ease the
    conversion of ARM[64] to the generic entry infrastructure

  - Extend syscall user dispatching to support a single intercepted range
    instead of the default single non-intercepted range. That allows
    monitoring/analysis of a specific executable range, e.g. a library, and
    also provides flexibility for sandboxing scenarios.

  - Cleanup and extend the user dispatch selftest

Note: This results in a trivial merge conflict against the tip sched/core
      pull request. The core/entry version needs to replace the sched/core
      one.

Thanks,

	tglx

------------------>
Dmitry Vyukov (3):
      selftests: Fix errno checking in syscall_user_dispatch test
      syscall_user_dispatch: Add PR_SYS_DISPATCH_INCLUSIVE_ON
      selftests: Add tests for PR_SYS_DISPATCH_INCLUSIVE_ON

Jinjie Ruan (1):
      entry: Split generic entry into generic exception and syscall entry


 .../admin-guide/syscall-user-dispatch.rst          |  23 +-
 MAINTAINERS                                        |   1 +
 arch/Kconfig                                       |   9 +
 include/linux/entry-common.h                       | 382 +-------------------
 include/linux/irq-entry-common.h                   | 389 +++++++++++++++++++=
++
 include/uapi/linux/prctl.h                         |   7 +-
 kernel/entry/Makefile                              |   3 +-
 kernel/entry/common.c                              | 113 +-----
 kernel/entry/syscall-common.c                      | 112 ++++++
 kernel/entry/syscall_user_dispatch.c               |  36 +-
 kernel/sched/core.c                                |   8 +-
 tools/include/uapi/linux/prctl.h                   |   7 +-
 .../selftests/syscall_user_dispatch/sud_test.c     | 140 +++++---
 13 files changed, 665 insertions(+), 565 deletions(-)
 create mode 100644 include/linux/irq-entry-common.h
 create mode 100644 kernel/entry/syscall-common.c

diff --git a/Documentation/admin-guide/syscall-user-dispatch.rst b/Documentat=
ion/admin-guide/syscall-user-dispatch.rst
index e3cfffef5a63..c1768d9e80fa 100644
--- a/Documentation/admin-guide/syscall-user-dispatch.rst
+++ b/Documentation/admin-guide/syscall-user-dispatch.rst
@@ -53,20 +53,25 @@ following prctl:
=20
   prctl(PR_SET_SYSCALL_USER_DISPATCH, <op>, <offset>, <length>, [selector])
=20
-<op> is either PR_SYS_DISPATCH_ON or PR_SYS_DISPATCH_OFF, to enable and
-disable the mechanism globally for that thread.  When
-PR_SYS_DISPATCH_OFF is used, the other fields must be zero.
-
-[<offset>, <offset>+<length>) delimit a memory region interval
-from which syscalls are always executed directly, regardless of the
-userspace selector.  This provides a fast path for the C library, which
-includes the most common syscall dispatchers in the native code
-applications, and also provides a way for the signal handler to return
+<op> is either PR_SYS_DISPATCH_EXCLUSIVE_ON/PR_SYS_DISPATCH_INCLUSIVE_ON
+or PR_SYS_DISPATCH_OFF, to enable and disable the mechanism globally for
+that thread.  When PR_SYS_DISPATCH_OFF is used, the other fields must be zer=
o.
+
+For PR_SYS_DISPATCH_EXCLUSIVE_ON [<offset>, <offset>+<length>) delimit
+a memory region interval from which syscalls are always executed directly,
+regardless of the userspace selector.  This provides a fast path for the
+C library, which includes the most common syscall dispatchers in the native
+code applications, and also provides a way for the signal handler to return
 without triggering a nested SIGSYS on (rt\_)sigreturn.  Users of this
 interface should make sure that at least the signal trampoline code is
 included in this region. In addition, for syscalls that implement the
 trampoline code on the vDSO, that trampoline is never intercepted.
=20
+For PR_SYS_DISPATCH_INCLUSIVE_ON [<offset>, <offset>+<length>) delimit
+a memory region interval from which syscalls are dispatched based on
+the userspace selector. Syscalls from outside of the range are always
+executed directly.
+
 [selector] is a pointer to a char-sized region in the process memory
 region, that provides a quick way to enable disable syscall redirection
 thread-wide, without the need to invoke the kernel directly.  selector
diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa16..e92292a0e480 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10052,6 +10052,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry
 F:	include/linux/entry-common.h
 F:	include/linux/entry-kvm.h
+F:	include/linux/irq-entry-common.h
 F:	kernel/entry/
=20
 GENERIC GPIO I2C DRIVER
diff --git a/arch/Kconfig b/arch/Kconfig
index a3308a220f86..9233fbfd8dd3 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -64,8 +64,17 @@ config HOTPLUG_PARALLEL
 	bool
 	select HOTPLUG_SPLIT_STARTUP
=20
+config GENERIC_IRQ_ENTRY
+	bool
+
+config GENERIC_SYSCALL
+	bool
+	depends on GENERIC_IRQ_ENTRY
+
 config GENERIC_ENTRY
 	bool
+	select GENERIC_IRQ_ENTRY
+	select GENERIC_SYSCALL
=20
 config KPROBES
 	bool "Kprobes"
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index f94f3fdf15fc..7177436f0f9e 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -2,28 +2,16 @@
 #ifndef __LINUX_ENTRYCOMMON_H
 #define __LINUX_ENTRYCOMMON_H
=20
-#include <linux/static_call_types.h>
+#include <linux/irq-entry-common.h>
 #include <linux/ptrace.h>
-#include <linux/syscalls.h>
 #include <linux/seccomp.h>
 #include <linux/sched.h>
-#include <linux/context_tracking.h>
 #include <linux/livepatch.h>
 #include <linux/resume_user_mode.h>
-#include <linux/tick.h>
-#include <linux/kmsan.h>
=20
 #include <asm/entry-common.h>
 #include <asm/syscall.h>
=20
-/*
- * Define dummy _TIF work flags if not defined by the architecture or for
- * disabled functionality.
- */
-#ifndef _TIF_PATCH_PENDING
-# define _TIF_PATCH_PENDING		(0)
-#endif
-
 #ifndef _TIF_UPROBE
 # define _TIF_UPROBE			(0)
 #endif
@@ -56,69 +44,6 @@
 				 SYSCALL_WORK_SYSCALL_EXIT_TRAP	|	\
 				 ARCH_SYSCALL_WORK_EXIT)
=20
-/*
- * TIF flags handled in exit_to_user_mode_loop()
- */
-#ifndef ARCH_EXIT_TO_USER_MODE_WORK
-# define ARCH_EXIT_TO_USER_MODE_WORK		(0)
-#endif
-
-#define EXIT_TO_USER_MODE_WORK						\
-	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
-	 _TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY |			\
-	 _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |			\
-	 ARCH_EXIT_TO_USER_MODE_WORK)
-
-/**
- * arch_enter_from_user_mode - Architecture specific sanity check for user m=
ode regs
- * @regs:	Pointer to currents pt_regs
- *
- * Defaults to an empty implementation. Can be replaced by architecture
- * specific code.
- *
- * Invoked from syscall_enter_from_user_mode() in the non-instrumentable
- * section. Use __always_inline so the compiler cannot push it out of line
- * and make it instrumentable.
- */
-static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs);
-
-#ifndef arch_enter_from_user_mode
-static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs) =
{}
-#endif
-
-/**
- * enter_from_user_mode - Establish state when coming from user mode
- *
- * Syscall/interrupt entry disables interrupts, but user mode is traced as
- * interrupts enabled. Also with NO_HZ_FULL RCU might be idle.
- *
- * 1) Tell lockdep that interrupts are disabled
- * 2) Invoke context tracking if enabled to reactivate RCU
- * 3) Trace interrupts off state
- *
- * Invoked from architecture specific syscall entry code with interrupts
- * disabled. The calling code has to be non-instrumentable. When the
- * function returns all state is correct and interrupts are still
- * disabled. The subsequent functions can be instrumented.
- *
- * This is invoked when there is architecture specific functionality to be
- * done between establishing state and enabling interrupts. The caller must
- * enable interrupts before invoking syscall_enter_from_user_mode_work().
- */
-static __always_inline void enter_from_user_mode(struct pt_regs *regs)
-{
-	arch_enter_from_user_mode(regs);
-	lockdep_hardirqs_off(CALLER_ADDR0);
-
-	CT_WARN_ON(__ct_state() !=3D CT_STATE_USER);
-	user_exit_irqoff();
-
-	instrumentation_begin();
-	kmsan_unpoison_entry_regs(regs);
-	trace_hardirqs_off_finish();
-	instrumentation_end();
-}
-
 /**
  * syscall_enter_from_user_mode_prepare - Establish state and enable interru=
pts
  * @regs:	Pointer to currents pt_regs
@@ -203,170 +128,6 @@ static __always_inline long syscall_enter_from_user_mod=
e(struct pt_regs *regs, l
 	return ret;
 }
=20
-/**
- * local_irq_enable_exit_to_user - Exit to user variant of local_irq_enable()
- * @ti_work:	Cached TIF flags gathered with interrupts disabled
- *
- * Defaults to local_irq_enable(). Can be supplied by architecture specific
- * code.
- */
-static inline void local_irq_enable_exit_to_user(unsigned long ti_work);
-
-#ifndef local_irq_enable_exit_to_user
-static inline void local_irq_enable_exit_to_user(unsigned long ti_work)
-{
-	local_irq_enable();
-}
-#endif
-
-/**
- * local_irq_disable_exit_to_user - Exit to user variant of local_irq_disabl=
e()
- *
- * Defaults to local_irq_disable(). Can be supplied by architecture specific
- * code.
- */
-static inline void local_irq_disable_exit_to_user(void);
-
-#ifndef local_irq_disable_exit_to_user
-static inline void local_irq_disable_exit_to_user(void)
-{
-	local_irq_disable();
-}
-#endif
-
-/**
- * arch_exit_to_user_mode_work - Architecture specific TIF work for exit
- *				 to user mode.
- * @regs:	Pointer to currents pt_regs
- * @ti_work:	Cached TIF flags gathered with interrupts disabled
- *
- * Invoked from exit_to_user_mode_loop() with interrupt enabled
- *
- * Defaults to NOOP. Can be supplied by architecture specific code.
- */
-static inline void arch_exit_to_user_mode_work(struct pt_regs *regs,
-					       unsigned long ti_work);
-
-#ifndef arch_exit_to_user_mode_work
-static inline void arch_exit_to_user_mode_work(struct pt_regs *regs,
-					       unsigned long ti_work)
-{
-}
-#endif
-
-/**
- * arch_exit_to_user_mode_prepare - Architecture specific preparation for
- *				    exit to user mode.
- * @regs:	Pointer to currents pt_regs
- * @ti_work:	Cached TIF flags gathered with interrupts disabled
- *
- * Invoked from exit_to_user_mode_prepare() with interrupt disabled as the l=
ast
- * function before return. Defaults to NOOP.
- */
-static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
-						  unsigned long ti_work);
-
-#ifndef arch_exit_to_user_mode_prepare
-static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
-						  unsigned long ti_work)
-{
-}
-#endif
-
-/**
- * arch_exit_to_user_mode - Architecture specific final work before
- *			    exit to user mode.
- *
- * Invoked from exit_to_user_mode() with interrupt disabled as the last
- * function before return. Defaults to NOOP.
- *
- * This needs to be __always_inline because it is non-instrumentable code
- * invoked after context tracking switched to user mode.
- *
- * An architecture implementation must not do anything complex, no locking
- * etc. The main purpose is for speculation mitigations.
- */
-static __always_inline void arch_exit_to_user_mode(void);
-
-#ifndef arch_exit_to_user_mode
-static __always_inline void arch_exit_to_user_mode(void) { }
-#endif
-
-/**
- * arch_do_signal_or_restart -  Architecture specific signal delivery functi=
on
- * @regs:	Pointer to currents pt_regs
- *
- * Invoked from exit_to_user_mode_loop().
- */
-void arch_do_signal_or_restart(struct pt_regs *regs);
-
-/**
- * exit_to_user_mode_loop - do any pending work before leaving to user space
- */
-unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
-				     unsigned long ti_work);
-
-/**
- * exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
- * @regs:	Pointer to pt_regs on entry stack
- *
- * 1) check that interrupts are disabled
- * 2) call tick_nohz_user_enter_prepare()
- * 3) call exit_to_user_mode_loop() if any flags from
- *    EXIT_TO_USER_MODE_WORK are set
- * 4) check that interrupts are still disabled
- */
-static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
-{
-	unsigned long ti_work;
-
-	lockdep_assert_irqs_disabled();
-
-	/* Flush pending rcuog wakeup before the last need_resched() check */
-	tick_nohz_user_enter_prepare();
-
-	ti_work =3D read_thread_flags();
-	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
-		ti_work =3D exit_to_user_mode_loop(regs, ti_work);
-
-	arch_exit_to_user_mode_prepare(regs, ti_work);
-
-	/* Ensure that kernel state is sane for a return to userspace */
-	kmap_assert_nomap();
-	lockdep_assert_irqs_disabled();
-	lockdep_sys_exit();
-}
-
-/**
- * exit_to_user_mode - Fixup state when exiting to user mode
- *
- * Syscall/interrupt exit enables interrupts, but the kernel state is
- * interrupts disabled when this is invoked. Also tell RCU about it.
- *
- * 1) Trace interrupts on state
- * 2) Invoke context tracking if enabled to adjust RCU state
- * 3) Invoke architecture specific last minute exit code, e.g. speculation
- *    mitigations, etc.: arch_exit_to_user_mode()
- * 4) Tell lockdep that interrupts are enabled
- *
- * Invoked from architecture specific code when syscall_exit_to_user_mode()
- * is not suitable as the last step before returning to userspace. Must be
- * invoked with interrupts disabled and the caller must be
- * non-instrumentable.
- * The caller has to invoke syscall_exit_to_user_mode_work() before this.
- */
-static __always_inline void exit_to_user_mode(void)
-{
-	instrumentation_begin();
-	trace_hardirqs_on_prepare();
-	lockdep_hardirqs_on_prepare();
-	instrumentation_end();
-
-	user_enter_irqoff();
-	arch_exit_to_user_mode();
-	lockdep_hardirqs_on(CALLER_ADDR0);
-}
-
 /**
  * syscall_exit_work - Handle work before returning to user mode
  * @regs:	Pointer to current pt_regs
@@ -451,145 +212,4 @@ static __always_inline void syscall_exit_to_user_mode(s=
truct pt_regs *regs)
 	exit_to_user_mode();
 }
=20
-/**
- * irqentry_enter_from_user_mode - Establish state before invoking the irq h=
andler
- * @regs:	Pointer to currents pt_regs
- *
- * Invoked from architecture specific entry code with interrupts disabled.
- * Can only be called when the interrupt entry came from user mode. The
- * calling code must be non-instrumentable.  When the function returns all
- * state is correct and the subsequent functions can be instrumented.
- *
- * The function establishes state (lockdep, RCU (context tracking), tracing)
- */
-void irqentry_enter_from_user_mode(struct pt_regs *regs);
-
-/**
- * irqentry_exit_to_user_mode - Interrupt exit work
- * @regs:	Pointer to current's pt_regs
- *
- * Invoked with interrupts disabled and fully valid regs. Returns with all
- * work handled, interrupts disabled such that the caller can immediately
- * switch to user mode. Called from architecture specific interrupt
- * handling code.
- *
- * The call order is #2 and #3 as described in syscall_exit_to_user_mode().
- * Interrupt exit is not invoking #1 which is the syscall specific one time
- * work.
- */
-void irqentry_exit_to_user_mode(struct pt_regs *regs);
-
-#ifndef irqentry_state
-/**
- * struct irqentry_state - Opaque object for exception state storage
- * @exit_rcu: Used exclusively in the irqentry_*() calls; signals whether the
- *            exit path has to invoke ct_irq_exit().
- * @lockdep: Used exclusively in the irqentry_nmi_*() calls; ensures that
- *           lockdep state is restored correctly on exit from nmi.
- *
- * This opaque object is filled in by the irqentry_*_enter() functions and
- * must be passed back into the corresponding irqentry_*_exit() functions
- * when the exception is complete.
- *
- * Callers of irqentry_*_[enter|exit]() must consider this structure opaque
- * and all members private.  Descriptions of the members are provided to aid=
 in
- * the maintenance of the irqentry_*() functions.
- */
-typedef struct irqentry_state {
-	union {
-		bool	exit_rcu;
-		bool	lockdep;
-	};
-} irqentry_state_t;
-#endif
-
-/**
- * irqentry_enter - Handle state tracking on ordinary interrupt entries
- * @regs:	Pointer to pt_regs of interrupted context
- *
- * Invokes:
- *  - lockdep irqflag state tracking as low level ASM entry disabled
- *    interrupts.
- *
- *  - Context tracking if the exception hit user mode.
- *
- *  - The hardirq tracer to keep the state consistent as low level ASM
- *    entry disabled interrupts.
- *
- * As a precondition, this requires that the entry came from user mode,
- * idle, or a kernel context in which RCU is watching.
- *
- * For kernel mode entries RCU handling is done conditional. If RCU is
- * watching then the only RCU requirement is to check whether the tick has
- * to be restarted. If RCU is not watching then ct_irq_enter() has to be
- * invoked on entry and ct_irq_exit() on exit.
- *
- * Avoiding the ct_irq_enter/exit() calls is an optimization but also
- * solves the problem of kernel mode pagefaults which can schedule, which
- * is not possible after invoking ct_irq_enter() without undoing it.
- *
- * For user mode entries irqentry_enter_from_user_mode() is invoked to
- * establish the proper context for NOHZ_FULL. Otherwise scheduling on exit
- * would not be possible.
- *
- * Returns: An opaque object that must be passed to idtentry_exit()
- */
-irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
-
-/**
- * irqentry_exit_cond_resched - Conditionally reschedule on return from inte=
rrupt
- *
- * Conditional reschedule with additional sanity checks.
- */
-void raw_irqentry_exit_cond_resched(void);
-#ifdef CONFIG_PREEMPT_DYNAMIC
-#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
-#define irqentry_exit_cond_resched_dynamic_enabled	raw_irqentry_exit_cond_re=
sched
-#define irqentry_exit_cond_resched_dynamic_disabled	NULL
-DECLARE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resch=
ed);
-#define irqentry_exit_cond_resched()	static_call(irqentry_exit_cond_resched)=
()
-#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
-DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
-void dynamic_irqentry_exit_cond_resched(void);
-#define irqentry_exit_cond_resched()	dynamic_irqentry_exit_cond_resched()
-#endif
-#else /* CONFIG_PREEMPT_DYNAMIC */
-#define irqentry_exit_cond_resched()	raw_irqentry_exit_cond_resched()
-#endif /* CONFIG_PREEMPT_DYNAMIC */
-
-/**
- * irqentry_exit - Handle return from exception that used irqentry_enter()
- * @regs:	Pointer to pt_regs (exception entry regs)
- * @state:	Return value from matching call to irqentry_enter()
- *
- * Depending on the return target (kernel/user) this runs the necessary
- * preemption and work checks if possible and required and returns to
- * the caller with interrupts disabled and no further work pending.
- *
- * This is the last action before returning to the low level ASM code which
- * just needs to return to the appropriate context.
- *
- * Counterpart to irqentry_enter().
- */
-void noinstr irqentry_exit(struct pt_regs *regs, irqentry_state_t state);
-
-/**
- * irqentry_nmi_enter - Handle NMI entry
- * @regs:	Pointer to currents pt_regs
- *
- * Similar to irqentry_enter() but taking care of the NMI constraints.
- */
-irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs);
-
-/**
- * irqentry_nmi_exit - Handle return from NMI handling
- * @regs:	Pointer to pt_regs (NMI entry regs)
- * @irq_state:	Return value from matching call to irqentry_nmi_enter()
- *
- * Last action before returning to the low level assembly code.
- *
- * Counterpart to irqentry_nmi_enter().
- */
-void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_st=
ate);
-
 #endif
diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-commo=
n.h
new file mode 100644
index 000000000000..8af374331900
--- /dev/null
+++ b/include/linux/irq-entry-common.h
@@ -0,0 +1,389 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_IRQENTRYCOMMON_H
+#define __LINUX_IRQENTRYCOMMON_H
+
+#include <linux/static_call_types.h>
+#include <linux/syscalls.h>
+#include <linux/context_tracking.h>
+#include <linux/tick.h>
+#include <linux/kmsan.h>
+
+#include <asm/entry-common.h>
+
+/*
+ * Define dummy _TIF work flags if not defined by the architecture or for
+ * disabled functionality.
+ */
+#ifndef _TIF_PATCH_PENDING
+# define _TIF_PATCH_PENDING		(0)
+#endif
+
+/*
+ * TIF flags handled in exit_to_user_mode_loop()
+ */
+#ifndef ARCH_EXIT_TO_USER_MODE_WORK
+# define ARCH_EXIT_TO_USER_MODE_WORK		(0)
+#endif
+
+#define EXIT_TO_USER_MODE_WORK						\
+	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
+	 _TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY |			\
+	 _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |			\
+	 ARCH_EXIT_TO_USER_MODE_WORK)
+
+/**
+ * arch_enter_from_user_mode - Architecture specific sanity check for user m=
ode regs
+ * @regs:	Pointer to currents pt_regs
+ *
+ * Defaults to an empty implementation. Can be replaced by architecture
+ * specific code.
+ *
+ * Invoked from syscall_enter_from_user_mode() in the non-instrumentable
+ * section. Use __always_inline so the compiler cannot push it out of line
+ * and make it instrumentable.
+ */
+static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs);
+
+#ifndef arch_enter_from_user_mode
+static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs) =
{}
+#endif
+
+/**
+ * enter_from_user_mode - Establish state when coming from user mode
+ *
+ * Syscall/interrupt entry disables interrupts, but user mode is traced as
+ * interrupts enabled. Also with NO_HZ_FULL RCU might be idle.
+ *
+ * 1) Tell lockdep that interrupts are disabled
+ * 2) Invoke context tracking if enabled to reactivate RCU
+ * 3) Trace interrupts off state
+ *
+ * Invoked from architecture specific syscall entry code with interrupts
+ * disabled. The calling code has to be non-instrumentable. When the
+ * function returns all state is correct and interrupts are still
+ * disabled. The subsequent functions can be instrumented.
+ *
+ * This is invoked when there is architecture specific functionality to be
+ * done between establishing state and enabling interrupts. The caller must
+ * enable interrupts before invoking syscall_enter_from_user_mode_work().
+ */
+static __always_inline void enter_from_user_mode(struct pt_regs *regs)
+{
+	arch_enter_from_user_mode(regs);
+	lockdep_hardirqs_off(CALLER_ADDR0);
+
+	CT_WARN_ON(__ct_state() !=3D CT_STATE_USER);
+	user_exit_irqoff();
+
+	instrumentation_begin();
+	kmsan_unpoison_entry_regs(regs);
+	trace_hardirqs_off_finish();
+	instrumentation_end();
+}
+
+/**
+ * local_irq_enable_exit_to_user - Exit to user variant of local_irq_enable()
+ * @ti_work:	Cached TIF flags gathered with interrupts disabled
+ *
+ * Defaults to local_irq_enable(). Can be supplied by architecture specific
+ * code.
+ */
+static inline void local_irq_enable_exit_to_user(unsigned long ti_work);
+
+#ifndef local_irq_enable_exit_to_user
+static inline void local_irq_enable_exit_to_user(unsigned long ti_work)
+{
+	local_irq_enable();
+}
+#endif
+
+/**
+ * local_irq_disable_exit_to_user - Exit to user variant of local_irq_disabl=
e()
+ *
+ * Defaults to local_irq_disable(). Can be supplied by architecture specific
+ * code.
+ */
+static inline void local_irq_disable_exit_to_user(void);
+
+#ifndef local_irq_disable_exit_to_user
+static inline void local_irq_disable_exit_to_user(void)
+{
+	local_irq_disable();
+}
+#endif
+
+/**
+ * arch_exit_to_user_mode_work - Architecture specific TIF work for exit
+ *				 to user mode.
+ * @regs:	Pointer to currents pt_regs
+ * @ti_work:	Cached TIF flags gathered with interrupts disabled
+ *
+ * Invoked from exit_to_user_mode_loop() with interrupt enabled
+ *
+ * Defaults to NOOP. Can be supplied by architecture specific code.
+ */
+static inline void arch_exit_to_user_mode_work(struct pt_regs *regs,
+					       unsigned long ti_work);
+
+#ifndef arch_exit_to_user_mode_work
+static inline void arch_exit_to_user_mode_work(struct pt_regs *regs,
+					       unsigned long ti_work)
+{
+}
+#endif
+
+/**
+ * arch_exit_to_user_mode_prepare - Architecture specific preparation for
+ *				    exit to user mode.
+ * @regs:	Pointer to currents pt_regs
+ * @ti_work:	Cached TIF flags gathered with interrupts disabled
+ *
+ * Invoked from exit_to_user_mode_prepare() with interrupt disabled as the l=
ast
+ * function before return. Defaults to NOOP.
+ */
+static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
+						  unsigned long ti_work);
+
+#ifndef arch_exit_to_user_mode_prepare
+static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
+						  unsigned long ti_work)
+{
+}
+#endif
+
+/**
+ * arch_exit_to_user_mode - Architecture specific final work before
+ *			    exit to user mode.
+ *
+ * Invoked from exit_to_user_mode() with interrupt disabled as the last
+ * function before return. Defaults to NOOP.
+ *
+ * This needs to be __always_inline because it is non-instrumentable code
+ * invoked after context tracking switched to user mode.
+ *
+ * An architecture implementation must not do anything complex, no locking
+ * etc. The main purpose is for speculation mitigations.
+ */
+static __always_inline void arch_exit_to_user_mode(void);
+
+#ifndef arch_exit_to_user_mode
+static __always_inline void arch_exit_to_user_mode(void) { }
+#endif
+
+/**
+ * arch_do_signal_or_restart -  Architecture specific signal delivery functi=
on
+ * @regs:	Pointer to currents pt_regs
+ *
+ * Invoked from exit_to_user_mode_loop().
+ */
+void arch_do_signal_or_restart(struct pt_regs *regs);
+
+/**
+ * exit_to_user_mode_loop - do any pending work before leaving to user space
+ */
+unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
+				     unsigned long ti_work);
+
+/**
+ * exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
+ * @regs:	Pointer to pt_regs on entry stack
+ *
+ * 1) check that interrupts are disabled
+ * 2) call tick_nohz_user_enter_prepare()
+ * 3) call exit_to_user_mode_loop() if any flags from
+ *    EXIT_TO_USER_MODE_WORK are set
+ * 4) check that interrupts are still disabled
+ */
+static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
+{
+	unsigned long ti_work;
+
+	lockdep_assert_irqs_disabled();
+
+	/* Flush pending rcuog wakeup before the last need_resched() check */
+	tick_nohz_user_enter_prepare();
+
+	ti_work =3D read_thread_flags();
+	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
+		ti_work =3D exit_to_user_mode_loop(regs, ti_work);
+
+	arch_exit_to_user_mode_prepare(regs, ti_work);
+
+	/* Ensure that kernel state is sane for a return to userspace */
+	kmap_assert_nomap();
+	lockdep_assert_irqs_disabled();
+	lockdep_sys_exit();
+}
+
+/**
+ * exit_to_user_mode - Fixup state when exiting to user mode
+ *
+ * Syscall/interrupt exit enables interrupts, but the kernel state is
+ * interrupts disabled when this is invoked. Also tell RCU about it.
+ *
+ * 1) Trace interrupts on state
+ * 2) Invoke context tracking if enabled to adjust RCU state
+ * 3) Invoke architecture specific last minute exit code, e.g. speculation
+ *    mitigations, etc.: arch_exit_to_user_mode()
+ * 4) Tell lockdep that interrupts are enabled
+ *
+ * Invoked from architecture specific code when syscall_exit_to_user_mode()
+ * is not suitable as the last step before returning to userspace. Must be
+ * invoked with interrupts disabled and the caller must be
+ * non-instrumentable.
+ * The caller has to invoke syscall_exit_to_user_mode_work() before this.
+ */
+static __always_inline void exit_to_user_mode(void)
+{
+	instrumentation_begin();
+	trace_hardirqs_on_prepare();
+	lockdep_hardirqs_on_prepare();
+	instrumentation_end();
+
+	user_enter_irqoff();
+	arch_exit_to_user_mode();
+	lockdep_hardirqs_on(CALLER_ADDR0);
+}
+
+/**
+ * irqentry_enter_from_user_mode - Establish state before invoking the irq h=
andler
+ * @regs:	Pointer to currents pt_regs
+ *
+ * Invoked from architecture specific entry code with interrupts disabled.
+ * Can only be called when the interrupt entry came from user mode. The
+ * calling code must be non-instrumentable.  When the function returns all
+ * state is correct and the subsequent functions can be instrumented.
+ *
+ * The function establishes state (lockdep, RCU (context tracking), tracing)
+ */
+void irqentry_enter_from_user_mode(struct pt_regs *regs);
+
+/**
+ * irqentry_exit_to_user_mode - Interrupt exit work
+ * @regs:	Pointer to current's pt_regs
+ *
+ * Invoked with interrupts disabled and fully valid regs. Returns with all
+ * work handled, interrupts disabled such that the caller can immediately
+ * switch to user mode. Called from architecture specific interrupt
+ * handling code.
+ *
+ * The call order is #2 and #3 as described in syscall_exit_to_user_mode().
+ * Interrupt exit is not invoking #1 which is the syscall specific one time
+ * work.
+ */
+void irqentry_exit_to_user_mode(struct pt_regs *regs);
+
+#ifndef irqentry_state
+/**
+ * struct irqentry_state - Opaque object for exception state storage
+ * @exit_rcu: Used exclusively in the irqentry_*() calls; signals whether the
+ *            exit path has to invoke ct_irq_exit().
+ * @lockdep: Used exclusively in the irqentry_nmi_*() calls; ensures that
+ *           lockdep state is restored correctly on exit from nmi.
+ *
+ * This opaque object is filled in by the irqentry_*_enter() functions and
+ * must be passed back into the corresponding irqentry_*_exit() functions
+ * when the exception is complete.
+ *
+ * Callers of irqentry_*_[enter|exit]() must consider this structure opaque
+ * and all members private.  Descriptions of the members are provided to aid=
 in
+ * the maintenance of the irqentry_*() functions.
+ */
+typedef struct irqentry_state {
+	union {
+		bool	exit_rcu;
+		bool	lockdep;
+	};
+} irqentry_state_t;
+#endif
+
+/**
+ * irqentry_enter - Handle state tracking on ordinary interrupt entries
+ * @regs:	Pointer to pt_regs of interrupted context
+ *
+ * Invokes:
+ *  - lockdep irqflag state tracking as low level ASM entry disabled
+ *    interrupts.
+ *
+ *  - Context tracking if the exception hit user mode.
+ *
+ *  - The hardirq tracer to keep the state consistent as low level ASM
+ *    entry disabled interrupts.
+ *
+ * As a precondition, this requires that the entry came from user mode,
+ * idle, or a kernel context in which RCU is watching.
+ *
+ * For kernel mode entries RCU handling is done conditional. If RCU is
+ * watching then the only RCU requirement is to check whether the tick has
+ * to be restarted. If RCU is not watching then ct_irq_enter() has to be
+ * invoked on entry and ct_irq_exit() on exit.
+ *
+ * Avoiding the ct_irq_enter/exit() calls is an optimization but also
+ * solves the problem of kernel mode pagefaults which can schedule, which
+ * is not possible after invoking ct_irq_enter() without undoing it.
+ *
+ * For user mode entries irqentry_enter_from_user_mode() is invoked to
+ * establish the proper context for NOHZ_FULL. Otherwise scheduling on exit
+ * would not be possible.
+ *
+ * Returns: An opaque object that must be passed to idtentry_exit()
+ */
+irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
+
+/**
+ * irqentry_exit_cond_resched - Conditionally reschedule on return from inte=
rrupt
+ *
+ * Conditional reschedule with additional sanity checks.
+ */
+void raw_irqentry_exit_cond_resched(void);
+#ifdef CONFIG_PREEMPT_DYNAMIC
+#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
+#define irqentry_exit_cond_resched_dynamic_enabled	raw_irqentry_exit_cond_re=
sched
+#define irqentry_exit_cond_resched_dynamic_disabled	NULL
+DECLARE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resch=
ed);
+#define irqentry_exit_cond_resched()	static_call(irqentry_exit_cond_resched)=
()
+#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
+void dynamic_irqentry_exit_cond_resched(void);
+#define irqentry_exit_cond_resched()	dynamic_irqentry_exit_cond_resched()
+#endif
+#else /* CONFIG_PREEMPT_DYNAMIC */
+#define irqentry_exit_cond_resched()	raw_irqentry_exit_cond_resched()
+#endif /* CONFIG_PREEMPT_DYNAMIC */
+
+/**
+ * irqentry_exit - Handle return from exception that used irqentry_enter()
+ * @regs:	Pointer to pt_regs (exception entry regs)
+ * @state:	Return value from matching call to irqentry_enter()
+ *
+ * Depending on the return target (kernel/user) this runs the necessary
+ * preemption and work checks if possible and required and returns to
+ * the caller with interrupts disabled and no further work pending.
+ *
+ * This is the last action before returning to the low level ASM code which
+ * just needs to return to the appropriate context.
+ *
+ * Counterpart to irqentry_enter().
+ */
+void noinstr irqentry_exit(struct pt_regs *regs, irqentry_state_t state);
+
+/**
+ * irqentry_nmi_enter - Handle NMI entry
+ * @regs:	Pointer to currents pt_regs
+ *
+ * Similar to irqentry_enter() but taking care of the NMI constraints.
+ */
+irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs);
+
+/**
+ * irqentry_nmi_exit - Handle return from NMI handling
+ * @regs:	Pointer to pt_regs (NMI entry regs)
+ * @irq_state:	Return value from matching call to irqentry_nmi_enter()
+ *
+ * Last action before returning to the low level assembly code.
+ *
+ * Counterpart to irqentry_nmi_enter().
+ */
+void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_st=
ate);
+
+#endif
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 43dec6eed559..9785c1d49f05 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -255,7 +255,12 @@ struct prctl_mm_map {
 /* Dispatch syscalls to a userspace handler */
 #define PR_SET_SYSCALL_USER_DISPATCH	59
 # define PR_SYS_DISPATCH_OFF		0
-# define PR_SYS_DISPATCH_ON		1
+/* Enable dispatch except for the specified range */
+# define PR_SYS_DISPATCH_EXCLUSIVE_ON	1
+/* Enable dispatch for the specified range */
+# define PR_SYS_DISPATCH_INCLUSIVE_ON	2
+/* Legacy name for backwards compatibility */
+# define PR_SYS_DISPATCH_ON		PR_SYS_DISPATCH_EXCLUSIVE_ON
 /* The control values for the user space selector when dispatch is enabled */
 # define SYSCALL_DISPATCH_FILTER_ALLOW	0
 # define SYSCALL_DISPATCH_FILTER_BLOCK	1
diff --git a/kernel/entry/Makefile b/kernel/entry/Makefile
index d4b8bd0af79b..77fcd83dd663 100644
--- a/kernel/entry/Makefile
+++ b/kernel/entry/Makefile
@@ -12,5 +12,6 @@ ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) +=3D -DDISABLE_BRA=
NCH_PROFILING
 CFLAGS_REMOVE_common.o	 =3D -fstack-protector -fstack-protector-strong
 CFLAGS_common.o		+=3D -fno-stack-protector
=20
-obj-$(CONFIG_GENERIC_ENTRY) 		+=3D common.o syscall_user_dispatch.o
+obj-$(CONFIG_GENERIC_IRQ_ENTRY) 	+=3D common.o
+obj-$(CONFIG_GENERIC_SYSCALL) 		+=3D syscall-common.o syscall_user_dispatch.o
 obj-$(CONFIG_KVM_XFER_TO_GUEST_WORK)	+=3D kvm.o
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index a8dd1f27417c..b82032777310 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -1,84 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
=20
-#include <linux/context_tracking.h>
-#include <linux/entry-common.h>
+#include <linux/irq-entry-common.h>
 #include <linux/resume_user_mode.h>
 #include <linux/highmem.h>
 #include <linux/jump_label.h>
 #include <linux/kmsan.h>
 #include <linux/livepatch.h>
-#include <linux/audit.h>
 #include <linux/tick.h>
=20
-#include "common.h"
-
-#define CREATE_TRACE_POINTS
-#include <trace/events/syscalls.h>
-
-static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
-{
-	if (unlikely(audit_context())) {
-		unsigned long args[6];
-
-		syscall_get_arguments(current, regs, args);
-		audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
-	}
-}
-
-long syscall_trace_enter(struct pt_regs *regs, long syscall,
-				unsigned long work)
-{
-	long ret =3D 0;
-
-	/*
-	 * Handle Syscall User Dispatch.  This must comes first, since
-	 * the ABI here can be something that doesn't make sense for
-	 * other syscall_work features.
-	 */
-	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
-		if (syscall_user_dispatch(regs))
-			return -1L;
-	}
-
-	/* Handle ptrace */
-	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
-		ret =3D ptrace_report_syscall_entry(regs);
-		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
-			return -1L;
-	}
-
-	/* Do seccomp after ptrace, to catch any tracer changes. */
-	if (work & SYSCALL_WORK_SECCOMP) {
-		ret =3D __secure_computing();
-		if (ret =3D=3D -1L)
-			return ret;
-	}
-
-	/* Either of the above might have changed the syscall number */
-	syscall =3D syscall_get_nr(current, regs);
-
-	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT)) {
-		trace_sys_enter(regs, syscall);
-		/*
-		 * Probes or BPF hooks in the tracepoint may have changed the
-		 * system call number as well.
-		 */
-		syscall =3D syscall_get_nr(current, regs);
-	}
-
-	syscall_enter_audit(regs, syscall);
-
-	return ret ? : syscall;
-}
-
-noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
-{
-	enter_from_user_mode(regs);
-	instrumentation_begin();
-	local_irq_enable();
-	instrumentation_end();
-}
-
 /* Workaround to allow gradual conversion of architecture code */
 void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
=20
@@ -133,46 +62,6 @@ __always_inline unsigned long exit_to_user_mode_loop(stru=
ct pt_regs *regs,
 	return ti_work;
 }
=20
-/*
- * If SYSCALL_EMU is set, then the only reason to report is when
- * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
- * instruction has been already reported in syscall_enter_from_user_mode().
- */
-static inline bool report_single_step(unsigned long work)
-{
-	if (work & SYSCALL_WORK_SYSCALL_EMU)
-		return false;
-
-	return work & SYSCALL_WORK_SYSCALL_EXIT_TRAP;
-}
-
-void syscall_exit_work(struct pt_regs *regs, unsigned long work)
-{
-	bool step;
-
-	/*
-	 * If the syscall was rolled back due to syscall user dispatching,
-	 * then the tracers below are not invoked for the same reason as
-	 * the entry side was not invoked in syscall_trace_enter(): The ABI
-	 * of these syscalls is unknown.
-	 */
-	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
-		if (unlikely(current->syscall_dispatch.on_dispatch)) {
-			current->syscall_dispatch.on_dispatch =3D false;
-			return;
-		}
-	}
-
-	audit_syscall_exit(regs);
-
-	if (work & SYSCALL_WORK_SYSCALL_TRACEPOINT)
-		trace_sys_exit(regs, syscall_get_return_value(current, regs));
-
-	step =3D report_single_step(work);
-	if (step || work & SYSCALL_WORK_SYSCALL_TRACE)
-		ptrace_report_syscall_exit(regs, step);
-}
-
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
 {
 	enter_from_user_mode(regs);
diff --git a/kernel/entry/syscall-common.c b/kernel/entry/syscall-common.c
new file mode 100644
index 000000000000..66e6ba7fa80c
--- /dev/null
+++ b/kernel/entry/syscall-common.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/audit.h>
+#include <linux/entry-common.h>
+#include "common.h"
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/syscalls.h>
+
+static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
+{
+	if (unlikely(audit_context())) {
+		unsigned long args[6];
+
+		syscall_get_arguments(current, regs, args);
+		audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
+	}
+}
+
+long syscall_trace_enter(struct pt_regs *regs, long syscall,
+				unsigned long work)
+{
+	long ret =3D 0;
+
+	/*
+	 * Handle Syscall User Dispatch.  This must comes first, since
+	 * the ABI here can be something that doesn't make sense for
+	 * other syscall_work features.
+	 */
+	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
+		if (syscall_user_dispatch(regs))
+			return -1L;
+	}
+
+	/* Handle ptrace */
+	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
+		ret =3D ptrace_report_syscall_entry(regs);
+		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
+			return -1L;
+	}
+
+	/* Do seccomp after ptrace, to catch any tracer changes. */
+	if (work & SYSCALL_WORK_SECCOMP) {
+		ret =3D __secure_computing();
+		if (ret =3D=3D -1L)
+			return ret;
+	}
+
+	/* Either of the above might have changed the syscall number */
+	syscall =3D syscall_get_nr(current, regs);
+
+	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT)) {
+		trace_sys_enter(regs, syscall);
+		/*
+		 * Probes or BPF hooks in the tracepoint may have changed the
+		 * system call number as well.
+		 */
+		syscall =3D syscall_get_nr(current, regs);
+	}
+
+	syscall_enter_audit(regs, syscall);
+
+	return ret ? : syscall;
+}
+
+noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
+{
+	enter_from_user_mode(regs);
+	instrumentation_begin();
+	local_irq_enable();
+	instrumentation_end();
+}
+
+/*
+ * If SYSCALL_EMU is set, then the only reason to report is when
+ * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
+ * instruction has been already reported in syscall_enter_from_user_mode().
+ */
+static inline bool report_single_step(unsigned long work)
+{
+	if (work & SYSCALL_WORK_SYSCALL_EMU)
+		return false;
+
+	return work & SYSCALL_WORK_SYSCALL_EXIT_TRAP;
+}
+
+void syscall_exit_work(struct pt_regs *regs, unsigned long work)
+{
+	bool step;
+
+	/*
+	 * If the syscall was rolled back due to syscall user dispatching,
+	 * then the tracers below are not invoked for the same reason as
+	 * the entry side was not invoked in syscall_trace_enter(): The ABI
+	 * of these syscalls is unknown.
+	 */
+	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
+		if (unlikely(current->syscall_dispatch.on_dispatch)) {
+			current->syscall_dispatch.on_dispatch =3D false;
+			return;
+		}
+	}
+
+	audit_syscall_exit(regs);
+
+	if (work & SYSCALL_WORK_SYSCALL_TRACEPOINT)
+		trace_sys_exit(regs, syscall_get_return_value(current, regs));
+
+	step =3D report_single_step(work);
+	if (step || work & SYSCALL_WORK_SYSCALL_TRACE)
+		ptrace_report_syscall_exit(regs, step);
+}
diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user=
_dispatch.c
index 5340c5aa89e7..a9055eccb27e 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -78,7 +78,7 @@ static int task_set_syscall_user_dispatch(struct task_struc=
t *task, unsigned lon
 		if (offset || len || selector)
 			return -EINVAL;
 		break;
-	case PR_SYS_DISPATCH_ON:
+	case PR_SYS_DISPATCH_EXCLUSIVE_ON:
 		/*
 		 * Validate the direct dispatcher region just for basic
 		 * sanity against overflow and a 0-sized dispatcher
@@ -87,30 +87,40 @@ static int task_set_syscall_user_dispatch(struct task_str=
uct *task, unsigned lon
 		 */
 		if (offset && offset + len <=3D offset)
 			return -EINVAL;
-
+		break;
+	case PR_SYS_DISPATCH_INCLUSIVE_ON:
+		if (len =3D=3D 0 || offset + len <=3D offset)
+			return -EINVAL;
 		/*
-		 * access_ok() will clear memory tags for tagged addresses
-		 * if current has memory tagging enabled.
-
-		 * To enable a tracer to set a tracees selector the
-		 * selector address must be untagged for access_ok(),
-		 * otherwise an untagged tracer will always fail to set a
-		 * tagged tracees selector.
+		 * Invert the range, the check in syscall_user_dispatch()
+		 * supports wrap-around.
 		 */
-		if (selector && !access_ok(untagged_addr(selector), sizeof(*selector)))
-			return -EFAULT;
-
+		offset =3D offset + len;
+		len =3D -len;
 		break;
 	default:
 		return -EINVAL;
 	}
=20
+	/*
+	 * access_ok() will clear memory tags for tagged addresses
+	 * if current has memory tagging enabled.
+	 *
+	 * To enable a tracer to set a tracees selector the
+	 * selector address must be untagged for access_ok(),
+	 * otherwise an untagged tracer will always fail to set a
+	 * tagged tracees selector.
+	 */
+	if (mode !=3D PR_SYS_DISPATCH_OFF && selector &&
+		!access_ok(untagged_addr(selector), sizeof(*selector)))
+		return -EFAULT;
+
 	task->syscall_dispatch.selector =3D selector;
 	task->syscall_dispatch.offset =3D offset;
 	task->syscall_dispatch.len =3D len;
 	task->syscall_dispatch.on_dispatch =3D false;
=20
-	if (mode =3D=3D PR_SYS_DISPATCH_ON)
+	if (mode !=3D PR_SYS_DISPATCH_OFF)
 		set_task_syscall_work(task, SYSCALL_USER_DISPATCH);
 	else
 		clear_task_syscall_work(task, SYSCALL_USER_DISPATCH);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dce50fa57471..e6269e7954f3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -69,8 +69,8 @@
 #include <linux/livepatch_sched.h>
=20
 #ifdef CONFIG_PREEMPT_DYNAMIC
-# ifdef CONFIG_GENERIC_ENTRY
-#  include <linux/entry-common.h>
+# ifdef CONFIG_GENERIC_IRQ_ENTRY
+#  include <linux/irq-entry-common.h>
 # endif
 #endif
=20
@@ -7427,8 +7427,8 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
=20
 #ifdef CONFIG_PREEMPT_DYNAMIC
=20
-#ifdef CONFIG_GENERIC_ENTRY
-#include <linux/entry-common.h>
+#ifdef CONFIG_GENERIC_IRQ_ENTRY
+#include <linux/irq-entry-common.h>
 #endif
=20
 /*
diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prct=
l.h
index 43dec6eed559..9785c1d49f05 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -255,7 +255,12 @@ struct prctl_mm_map {
 /* Dispatch syscalls to a userspace handler */
 #define PR_SET_SYSCALL_USER_DISPATCH	59
 # define PR_SYS_DISPATCH_OFF		0
-# define PR_SYS_DISPATCH_ON		1
+/* Enable dispatch except for the specified range */
+# define PR_SYS_DISPATCH_EXCLUSIVE_ON	1
+/* Enable dispatch for the specified range */
+# define PR_SYS_DISPATCH_INCLUSIVE_ON	2
+/* Legacy name for backwards compatibility */
+# define PR_SYS_DISPATCH_ON		PR_SYS_DISPATCH_EXCLUSIVE_ON
 /* The control values for the user space selector when dispatch is enabled */
 # define SYSCALL_DISPATCH_FILTER_ALLOW	0
 # define SYSCALL_DISPATCH_FILTER_BLOCK	1
diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools=
/testing/selftests/syscall_user_dispatch/sud_test.c
index d975a6767329..2eb2c06303f2 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
@@ -10,6 +10,8 @@
 #include <sys/sysinfo.h>
 #include <sys/syscall.h>
 #include <signal.h>
+#include <stdbool.h>
+#include <stdlib.h>
=20
 #include <asm/unistd.h>
 #include "../kselftest_harness.h"
@@ -17,11 +19,15 @@
 #ifndef PR_SET_SYSCALL_USER_DISPATCH
 # define PR_SET_SYSCALL_USER_DISPATCH	59
 # define PR_SYS_DISPATCH_OFF	0
-# define PR_SYS_DISPATCH_ON	1
 # define SYSCALL_DISPATCH_FILTER_ALLOW	0
 # define SYSCALL_DISPATCH_FILTER_BLOCK	1
 #endif
=20
+#ifndef PR_SYS_DISPATCH_EXCLUSIVE_ON
+# define PR_SYS_DISPATCH_EXCLUSIVE_ON	1
+# define PR_SYS_DISPATCH_INCLUSIVE_ON	2
+#endif
+
 #ifndef SYS_USER_DISPATCH
 # define SYS_USER_DISPATCH	2
 #endif
@@ -65,7 +71,7 @@ TEST_SIGNAL(dispatch_trigger_sigsys, SIGSYS)
 	ret =3D sysinfo(&info);
 	ASSERT_EQ(0, ret);
=20
-	ret =3D prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &sel);
+	ret =3D prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_EXCLUSIVE_ON, 0=
, 0, &sel);
 	ASSERT_EQ(0, ret) {
 		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
 	}
@@ -79,6 +85,21 @@ TEST_SIGNAL(dispatch_trigger_sigsys, SIGSYS)
 	}
 }
=20
+static void prctl_valid(struct __test_metadata *_metadata,
+			unsigned long op, unsigned long off,
+			unsigned long size, void *sel)
+{
+	EXPECT_EQ(0, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, off, size, sel));
+}
+
+static void prctl_invalid(struct __test_metadata *_metadata,
+			  unsigned long op, unsigned long off,
+			  unsigned long size, void *sel, int err)
+{
+	EXPECT_EQ(-1, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, off, size, sel));
+	EXPECT_EQ(err, errno);
+}
+
 TEST(bad_prctl_param)
 {
 	char sel =3D SYSCALL_DISPATCH_FILTER_ALLOW;
@@ -86,57 +107,54 @@ TEST(bad_prctl_param)
=20
 	/* Invalid op */
 	op =3D -1;
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0, 0, &sel);
-	ASSERT_EQ(EINVAL, errno);
+	prctl_invalid(_metadata, op, 0, 0, &sel, EINVAL);
=20
 	/* PR_SYS_DISPATCH_OFF */
 	op =3D PR_SYS_DISPATCH_OFF;
=20
 	/* offset !=3D 0 */
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x1, 0x0, 0);
-	EXPECT_EQ(EINVAL, errno);
+	prctl_invalid(_metadata, op, 0x1, 0x0, 0, EINVAL);
=20
 	/* len !=3D 0 */
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0xff, 0);
-	EXPECT_EQ(EINVAL, errno);
+	prctl_invalid(_metadata, op, 0x0, 0xff, 0, EINVAL);
=20
 	/* sel !=3D NULL */
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x0, &sel);
-	EXPECT_EQ(EINVAL, errno);
+	prctl_invalid(_metadata, op, 0x0, 0x0, &sel, EINVAL);
=20
 	/* Valid parameter */
-	errno =3D 0;
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x0, 0x0);
-	EXPECT_EQ(0, errno);
+	prctl_valid(_metadata, op, 0x0, 0x0, 0x0);
=20
-	/* PR_SYS_DISPATCH_ON */
-	op =3D PR_SYS_DISPATCH_ON;
+	/* PR_SYS_DISPATCH_EXCLUSIVE_ON */
+	op =3D PR_SYS_DISPATCH_EXCLUSIVE_ON;
=20
 	/* Dispatcher region is bad (offset > 0 && len =3D=3D 0) */
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x1, 0x0, &sel);
-	EXPECT_EQ(EINVAL, errno);
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, -1L, 0x0, &sel);
-	EXPECT_EQ(EINVAL, errno);
+	prctl_invalid(_metadata, op, 0x1, 0x0, &sel, EINVAL);
+	prctl_invalid(_metadata, op, -1L, 0x0, &sel, EINVAL);
=20
 	/* Invalid selector */
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x1, (void *) -1);
-	ASSERT_EQ(EFAULT, errno);
+	prctl_invalid(_metadata, op, 0x0, 0x1, (void *) -1, EFAULT);
=20
 	/*
 	 * Dispatcher range overflows unsigned long
 	 */
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 1, -1L, &sel);
-	ASSERT_EQ(EINVAL, errno) {
-		TH_LOG("Should reject bad syscall range");
-	}
+	prctl_invalid(_metadata, PR_SYS_DISPATCH_EXCLUSIVE_ON, 1, -1L, &sel, EINVAL=
);
=20
 	/*
 	 * Allowed range overflows usigned long
 	 */
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, -1L, 0x1, &sel);
-	ASSERT_EQ(EINVAL, errno) {
-		TH_LOG("Should reject bad syscall range");
-	}
+	prctl_invalid(_metadata, PR_SYS_DISPATCH_EXCLUSIVE_ON, -1L, 0x1, &sel, EINV=
AL);
+
+	/* 0 len should fail for PR_SYS_DISPATCH_INCLUSIVE_ON */
+	prctl_invalid(_metadata, PR_SYS_DISPATCH_INCLUSIVE_ON, 1, 0, 0, EINVAL);
+
+	/* Range wrap-around should fail */
+	prctl_invalid(_metadata, PR_SYS_DISPATCH_INCLUSIVE_ON, -1L, 2, 0, EINVAL);
+
+	/* Normal range shouldn't fail */
+	prctl_valid(_metadata, PR_SYS_DISPATCH_INCLUSIVE_ON, 2, 3, 0);
+
+	/* Invalid selector */
+	prctl_invalid(_metadata, PR_SYS_DISPATCH_INCLUSIVE_ON, 2, 3, (void *) -1, E=
FAULT);
 }
=20
 /*
@@ -147,11 +165,13 @@ char glob_sel;
 int nr_syscalls_emulated;
 int si_code;
 int si_errno;
+unsigned long syscall_addr;
=20
 static void handle_sigsys(int sig, siginfo_t *info, void *ucontext)
 {
 	si_code =3D info->si_code;
 	si_errno =3D info->si_errno;
+	syscall_addr =3D (unsigned long)info->si_call_addr;
=20
 	if (info->si_syscall =3D=3D MAGIC_SYSCALL_1)
 		nr_syscalls_emulated++;
@@ -174,31 +194,34 @@ static void handle_sigsys(int sig, siginfo_t *info, voi=
d *ucontext)
 #endif
 }
=20
-TEST(dispatch_and_return)
+int setup_sigsys_handler(void)
 {
-	long ret;
 	struct sigaction act;
 	sigset_t mask;
=20
-	glob_sel =3D 0;
-	nr_syscalls_emulated =3D 0;
-	si_code =3D 0;
-	si_errno =3D 0;
-
 	memset(&act, 0, sizeof(act));
 	sigemptyset(&mask);
-
 	act.sa_sigaction =3D handle_sigsys;
 	act.sa_flags =3D SA_SIGINFO;
 	act.sa_mask =3D mask;
+	return sigaction(SIGSYS, &act, NULL);
+}
=20
-	ret =3D sigaction(SIGSYS, &act, NULL);
-	ASSERT_EQ(0, ret);
+TEST(dispatch_and_return)
+{
+	long ret;
+
+	glob_sel =3D 0;
+	nr_syscalls_emulated =3D 0;
+	si_code =3D 0;
+	si_errno =3D 0;
+
+	ASSERT_EQ(0, setup_sigsys_handler());
=20
 	/* Make sure selector is good prior to prctl. */
 	SYSCALL_DISPATCH_OFF(glob_sel);
=20
-	ret =3D prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &glob=
_sel);
+	ret =3D prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_EXCLUSIVE_ON, 0=
, 0, &glob_sel);
 	ASSERT_EQ(0, ret) {
 		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
 	}
@@ -254,7 +277,7 @@ TEST_SIGNAL(bad_selector, SIGSYS)
 	/* Make sure selector is good prior to prctl. */
 	SYSCALL_DISPATCH_OFF(glob_sel);
=20
-	ret =3D prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &glob=
_sel);
+	ret =3D prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_EXCLUSIVE_ON, 0=
, 0, &glob_sel);
 	ASSERT_EQ(0, ret) {
 		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
 	}
@@ -278,7 +301,7 @@ TEST(disable_dispatch)
 	struct sysinfo info;
 	char sel =3D 0;
=20
-	ret =3D prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &sel);
+	ret =3D prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_EXCLUSIVE_ON, 0=
, 0, &sel);
 	ASSERT_EQ(0, ret) {
 		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
 	}
@@ -310,7 +333,7 @@ TEST(direct_dispatch_range)
 	 * Instead of calculating libc addresses; allow the entire
 	 * memory map and lock the selector.
 	 */
-	ret =3D prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, -1L, &se=
l);
+	ret =3D prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_EXCLUSIVE_ON, 0=
, -1L, &sel);
 	ASSERT_EQ(0, ret) {
 		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
 	}
@@ -323,4 +346,35 @@ TEST(direct_dispatch_range)
 	}
 }
=20
+static void test_range(struct __test_metadata *_metadata,
+		       unsigned long op, unsigned long off,
+		       unsigned long size, bool dispatch)
+{
+	nr_syscalls_emulated =3D 0;
+	SYSCALL_DISPATCH_OFF(glob_sel);
+	EXPECT_EQ(0, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, off, size, &glob_sel));
+	SYSCALL_DISPATCH_ON(glob_sel);
+	if (dispatch) {
+		EXPECT_EQ(syscall(MAGIC_SYSCALL_1), MAGIC_SYSCALL_1);
+		EXPECT_EQ(nr_syscalls_emulated, 1);
+	} else {
+		EXPECT_EQ(syscall(MAGIC_SYSCALL_1), -1);
+		EXPECT_EQ(nr_syscalls_emulated, 0);
+	}
+}
+
+TEST(dispatch_range)
+{
+	ASSERT_EQ(0, setup_sigsys_handler());
+	test_range(_metadata, PR_SYS_DISPATCH_EXCLUSIVE_ON, 0, 0, true);
+	test_range(_metadata, PR_SYS_DISPATCH_EXCLUSIVE_ON, syscall_addr, 1, false);
+	test_range(_metadata, PR_SYS_DISPATCH_EXCLUSIVE_ON, syscall_addr-100, 200, =
false);
+	test_range(_metadata, PR_SYS_DISPATCH_EXCLUSIVE_ON, syscall_addr+1, 100, tr=
ue);
+	test_range(_metadata, PR_SYS_DISPATCH_EXCLUSIVE_ON, syscall_addr-100, 100, =
true);
+	test_range(_metadata, PR_SYS_DISPATCH_INCLUSIVE_ON, syscall_addr, 1, true);
+	test_range(_metadata, PR_SYS_DISPATCH_INCLUSIVE_ON, syscall_addr-1, 1, fals=
e);
+	test_range(_metadata, PR_SYS_DISPATCH_INCLUSIVE_ON, syscall_addr+1, 1, fals=
e);
+	SYSCALL_DISPATCH_OFF(glob_sel);
+}
+
 TEST_HARNESS_MAIN


