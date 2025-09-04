Return-Path: <linux-kernel+bounces-801743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89931B44977
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E022F189D326
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875072ED148;
	Thu,  4 Sep 2025 22:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h88t+Qxz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q1+eUwyf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB9C2EACE0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024451; cv=none; b=Wolq4jJ4tTNVO48YbyBg7Kwdk4p1zU2X0NvTZmxC2sHuTJHcH47tR4X18gTiC+CZeRviXEkgCMTLet3xcilEYd3MOEgkrAT2rB+pS4WamjDgH/2CNU9FCAndUwqhs3vaV9jFbvNFIebU9WkjcFJxI4DAb2Hy/ukhThUOEucWpxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024451; c=relaxed/simple;
	bh=zXn2Hilq7JgETAgS203r++Qk1ot5FmpXs+P3sB1JjNQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=SWnGh60dGKGGrrwl/ecWSieA2tFT92uW5LvSstc4dEhqNZPMGi473mgSX6UiJbWmU6e/ZEVKFnjtys6jyNxRiFiJyutBUbPPsaVtAYKIXhCulX6AgU5n3m8PBEMFV58OmoQeKmRdZC4J0S3RtKVr4wu1o1z36+TixKle0ODQlfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h88t+Qxz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q1+eUwyf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250904185719.583482000@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757024448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=lOGOdkGw6DvUuxW1WUVswtkbF/cVX7fdUrXI1TMFuQs=;
	b=h88t+Qxzotj/CgkNKxZ5/cOJQg2aeyKrv+EwcDD3wey8ZfUVqy8T2GP37cya1HpehVN0kK
	g4DYCgWGXwLSWTjAqKsRvJoiO9nQjhJ1HPMwikB/Z+gA+aXhCPqLv4MNnP9cm8WUjGWbtK
	1i5HyOa1cdICH0hhHA13w/TTbUih8W+veztp+N1uQbXOGDyJDP3jkShzd9WhOQO0Vl6E6e
	QD/L/+TrcPH61eEAwRyIqXmqnkT8dQvHJwirBZsyVQ4kuV8l7HzmDTV09fQcRGq31zooRh
	JF0SrgPfJrNVBA5PvFOAZxUdNN1hLnTZJCG/BEvbW1ffHyJZRKgPZhf6Ta21LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757024448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=lOGOdkGw6DvUuxW1WUVswtkbF/cVX7fdUrXI1TMFuQs=;
	b=Q1+eUwyfJ/i2m99RS/Hewh4JIMejPR9Dz46LXOsdm2oh36qjfB31xo1uD9T+8bPrZjccbO
	AsDCPZKi6pcjPKDA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [patch V3 07/37] rseq, virt: Retrigger RSEQ after vcpu_run()
References: <20250904185336.943880027@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  5 Sep 2025 00:20:47 +0200 (CEST)

Hypervisors invoke resume_user_mode_work() before entering the guest, which
clears TIF_NOTIFY_RESUME. The @regs argument is NULL as there is no user
space context available to them, so the rseq notify handler skips
inspecting the critical section, but updates the CPU/MM CID values
unconditionally so that the eventual pending rseq event is not lost on the
way to user space.

This is a pointless exercise as the task might be rescheduled before
actually returning to user space and it creates unnecessary work in the
vcpu_run() loops.

It's way more efficient to ignore that invocation based on @regs == NULL
and let the hypervisors re-raise TIF_NOTIFY_RESUME after returning from the
vcpu_run() loop before returning from the ioctl().

This ensures that a pending RSEQ update is not lost and the IDs are updated
before returning to user space.

Once the RSEQ handling is decoupled from TIF_NOTIFY_RESUME, this turns into
a NOOP.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
---
V3: Add the missing rseq.h include for HV - 0-day
---
 drivers/hv/mshv_root_main.c |    3 +
 include/linux/rseq.h        |   17 +++++++++
 kernel/rseq.c               |   76 +++++++++++++++++++++++---------------------
 virt/kvm/kvm_main.c         |    3 +
 4 files changed, 63 insertions(+), 36 deletions(-)

--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -28,6 +28,7 @@
 #include <linux/crash_dump.h>
 #include <linux/panic_notifier.h>
 #include <linux/vmalloc.h>
+#include <linux/rseq.h>
 
 #include "mshv_eventfd.h"
 #include "mshv.h"
@@ -585,6 +586,8 @@ static long mshv_run_vp_with_root_schedu
 		}
 	} while (!vp->run.flags.intercept_suspend);
 
+	rseq_virt_userspace_exit();
+
 	return ret;
 }
 
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -38,6 +38,22 @@ static __always_inline void rseq_exit_to
 }
 
 /*
+ * KVM/HYPERV invoke resume_user_mode_work() before entering guest mode,
+ * which clears TIF_NOTIFY_RESUME. To avoid updating user space RSEQ in
+ * that case just to do it eventually again before returning to user space,
+ * the entry resume_user_mode_work() invocation is ignored as the register
+ * argument is NULL.
+ *
+ * After returning from guest mode, they have to invoke this function to
+ * re-raise TIF_NOTIFY_RESUME if necessary.
+ */
+static inline void rseq_virt_userspace_exit(void)
+{
+	if (current->rseq_event_pending)
+		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
+}
+
+/*
  * If parent process has a registered restartable sequences area, the
  * child inherits. Unregister rseq for a clone with CLONE_VM set.
  */
@@ -68,6 +84,7 @@ static inline void rseq_execve(struct ta
 static inline void rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs) { }
 static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs) { }
 static inline void rseq_sched_switch_event(struct task_struct *t) { }
+static inline void rseq_virt_userspace_exit(void) { }
 static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags) { }
 static inline void rseq_execve(struct task_struct *t) { }
 static inline void rseq_exit_to_user_mode(void) { }
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -422,50 +422,54 @@ void __rseq_handle_notify_resume(struct
 {
 	struct task_struct *t = current;
 	int ret, sig;
+	bool event;
+
+	/*
+	 * If invoked from hypervisors before entering the guest via
+	 * resume_user_mode_work(), then @regs is a NULL pointer.
+	 *
+	 * resume_user_mode_work() clears TIF_NOTIFY_RESUME and re-raises
+	 * it before returning from the ioctl() to user space when
+	 * rseq_event.sched_switch is set.
+	 *
+	 * So it's safe to ignore here instead of pointlessly updating it
+	 * in the vcpu_run() loop.
+	 */
+	if (!regs)
+		return;
 
 	if (unlikely(t->flags & PF_EXITING))
 		return;
 
 	/*
-	 * If invoked from hypervisors or IO-URING, then @regs is a NULL
-	 * pointer, so fixup cannot be done. If the syscall which led to
-	 * this invocation was invoked inside a critical section, then it
-	 * will either end up in this code again or a possible violation of
-	 * a syscall inside a critical region can only be detected by the
-	 * debug code in rseq_syscall() in a debug enabled kernel.
+	 * Read and clear the event pending bit first. If the task
+	 * was not preempted or migrated or a signal is on the way,
+	 * there is no point in doing any of the heavy lifting here
+	 * on production kernels. In that case TIF_NOTIFY_RESUME
+	 * was raised by some other functionality.
+	 *
+	 * This is correct because the read/clear operation is
+	 * guarded against scheduler preemption, which makes it CPU
+	 * local atomic. If the task is preempted right after
+	 * re-enabling preemption then TIF_NOTIFY_RESUME is set
+	 * again and this function is invoked another time _before_
+	 * the task is able to return to user mode.
+	 *
+	 * On a debug kernel, invoke the fixup code unconditionally
+	 * with the result handed in to allow the detection of
+	 * inconsistencies.
 	 */
-	if (regs) {
-		/*
-		 * Read and clear the event pending bit first. If the task
-		 * was not preempted or migrated or a signal is on the way,
-		 * there is no point in doing any of the heavy lifting here
-		 * on production kernels. In that case TIF_NOTIFY_RESUME
-		 * was raised by some other functionality.
-		 *
-		 * This is correct because the read/clear operation is
-		 * guarded against scheduler preemption, which makes it CPU
-		 * local atomic. If the task is preempted right after
-		 * re-enabling preemption then TIF_NOTIFY_RESUME is set
-		 * again and this function is invoked another time _before_
-		 * the task is able to return to user mode.
-		 *
-		 * On a debug kernel, invoke the fixup code unconditionally
-		 * with the result handed in to allow the detection of
-		 * inconsistencies.
-		 */
-		bool event;
-
-		scoped_guard(RSEQ_EVENT_GUARD) {
-			event = t->rseq_event_pending;
-			t->rseq_event_pending = false;
-		}
+	scoped_guard(RSEQ_EVENT_GUARD) {
+		event = t->rseq_event_pending;
+		t->rseq_event_pending = false;
+	}
 
-		if (IS_ENABLED(CONFIG_DEBUG_RSEQ) || event) {
-			ret = rseq_ip_fixup(regs, event);
-			if (unlikely(ret < 0))
-				goto error;
-		}
+	if (IS_ENABLED(CONFIG_DEBUG_RSEQ) || event) {
+		ret = rseq_ip_fixup(regs, event);
+		if (unlikely(ret < 0))
+			goto error;
 	}
+
 	if (unlikely(rseq_update_cpu_node_id(t)))
 		goto error;
 	return;
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -49,6 +49,7 @@
 #include <linux/lockdep.h>
 #include <linux/kthread.h>
 #include <linux/suspend.h>
+#include <linux/rseq.h>
 
 #include <asm/processor.h>
 #include <asm/ioctl.h>
@@ -4466,6 +4467,8 @@ static long kvm_vcpu_ioctl(struct file *
 		r = kvm_arch_vcpu_ioctl_run(vcpu);
 		vcpu->wants_to_run = false;
 
+		rseq_virt_userspace_exit();
+
 		trace_kvm_userspace_exit(vcpu->run->exit_reason, r);
 		break;
 	}


