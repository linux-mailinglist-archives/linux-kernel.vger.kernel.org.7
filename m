Return-Path: <linux-kernel+bounces-864972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5B4BFBFD5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4911A60342
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAC434B1BE;
	Wed, 22 Oct 2025 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zRJcpHhz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GJfFOnFv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077C23491E7
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137537; cv=none; b=o+KD1U9CX8HRsT0jhEmgN5XjCfaO8Mv6sqVYEwVfKZjPbMf0QjvALy5G9uwZLdV7dV+cuYqcKK1DJTFGBmGho6qHGA23sJUwaJv5owrNYhNk+VbmUvVmA2Lh7lbAUjeD7/z4n5N88e2fQ77wGx/2hGjvFT6TVsH96rAMIwXfemg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137537; c=relaxed/simple;
	bh=CpCTB1VqNEpuJXgSETrB9FSHCNY4H7uboFG5veyl0WE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=uQkCL5WkbIWB2M1Dkff1g89CiMfAn+OTi2Z6LF0yc0k/uPBeHqiAzylBF/NAqvRcwngD+2A1o49zPCFFmSp79iaTlUe6sxX2vG9rHcFZ9XiRf3dMerqidDHmOK/xszE9yArTFUOEYuTudWSPaPFcmXBAgWw626QKlxzhNXQY6mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zRJcpHhz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GJfFOnFv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022121941.822778677@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=VQmyoOet3ZH5HQRVE59iB+D2S5nx1PfyGcDowX85zMY=;
	b=zRJcpHhzQdNWPOsG1BrMXz9+3qrVug4lC2sNvPR1WRUt5hF8S9WZuaD7CvORNHIMZIFUot
	fjAHFOKzwok+3hDxqj6GeiLoKP2tVGqkGKlZroQN7nAxzdMpxagGnbq/svNz6Cd8Taopkn
	YqLsVe1ojHAqUrnvzHy5Nh4EhpE/IR+e8Y7TTOevw+dusnjFmSpiZDPIBza2dSB8jGispI
	Wus8h3HFDgxEfq19g05NH1BLsIHVCDzHN8QSCm+vsXPfkuUWxWTOmgFyDmkKdgke/Ww63d
	TXxDWsPsuJvOr257ux1c8fb8usgLbszgofRZXkXZo4A7v9+PzbN5sK/vXF84DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=VQmyoOet3ZH5HQRVE59iB+D2S5nx1PfyGcDowX85zMY=;
	b=GJfFOnFvmkk8CM+fMSBdAaB07V45ohHZVkIg/i81y20a08gn45Hu4xQfsuV04ZK6Oj1QBe
	oz1ILfBz0PWLEhCQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 x86@kernel.org,
 Sean Christopherson <seanjc@google.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [patch V5 07/31] rseq, virt: Retrigger RSEQ after vcpu_run()
References: <20251022121836.019469732@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:52:09 +0200 (CEST)

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
Acked-by: Sean Christopherson <seanjc@google.com>
---
V5: Add a comment that this is temporary - Sean
V3: Add the missing rseq.h include for HV - 0-day
---
 drivers/hv/mshv_root_main.c |    3 +
 include/linux/rseq.h        |   17 +++++++++
 kernel/rseq.c               |   76 +++++++++++++++++++++++---------------------
 virt/kvm/kvm_main.c         |    7 ++++
 4 files changed, 67 insertions(+), 36 deletions(-)
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -29,6 +29,7 @@
 #include <linux/crash_dump.h>
 #include <linux/panic_notifier.h>
 #include <linux/vmalloc.h>
+#include <linux/rseq.h>
 
 #include "mshv_eventfd.h"
 #include "mshv.h"
@@ -560,6 +561,8 @@ static long mshv_run_vp_with_root_schedu
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
 static inline void rseq_fork(struct task_struct *t, u64 clone_flags) { }
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
@@ -4476,6 +4477,12 @@ static long kvm_vcpu_ioctl(struct file *
 		r = kvm_arch_vcpu_ioctl_run(vcpu);
 		vcpu->wants_to_run = false;
 
+		/*
+		 * FIXME: Remove this hack once all KVM architectures
+		 * support the generic TIF bits, i.e. a dedicated TIF_RSEQ.
+		 */
+		rseq_virt_userspace_exit();
+
 		trace_kvm_userspace_exit(vcpu->run->exit_reason, r);
 		break;
 	}


