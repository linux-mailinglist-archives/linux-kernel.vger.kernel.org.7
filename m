Return-Path: <linux-kernel+bounces-871094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FD6C0C6CA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 020FB34BACD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5136D30F80B;
	Mon, 27 Oct 2025 08:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UwPjv6sS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v+gUqijw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C932230F536
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554673; cv=none; b=VUXVEOcttwsnZhIax9r01G4AAL9NUx6dVre9ExkkxfbWaaZlys8mDGSMxynhPPussn/EqUTSD56cR56Lrs+ohtvHEg3UVe8drX+edcnlLJxrxz4jvEOfgfkX8Ue7NXGiD0iSEDxeutI5cL6+W+pU5pZu2HLN7J9tv7nCwerUARY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554673; c=relaxed/simple;
	bh=CpCTB1VqNEpuJXgSETrB9FSHCNY4H7uboFG5veyl0WE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=eEwXRCLXzf2GaAFWPShWceW0ue+3/6JApG6APug/0twAia7jdQyNdwujBV4XzqdZ5Ko6xS9KCNP+EM815DojM/jWPTrc3kcxdlHkzq/8Suf2P7pWyKTf89cywfyczatT0ACgNQC3ag7uFy9agZLcKO3jdxBPOEVjA5MnZp1Sw14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UwPjv6sS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v+gUqijw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251027084306.399495855@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761554670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=VQmyoOet3ZH5HQRVE59iB+D2S5nx1PfyGcDowX85zMY=;
	b=UwPjv6sSrwsB8RF1Qcr0sFi73O1eE3YnhA986sf4OSx9QmQO0fS/CYlCDrXTxbSsk72wUz
	TGqZ22HvXQTsQNVXIEI4/FisxZv+DO6kV4OnP0IfP4ec8P7UkvBdQuNr/IZmLUMoSjLxNO
	Ot/7eux4ItfwJaNk2Head4/uFKrDCfh+vUmtZECe1JbBcsBe2LnTfSdkJaiCPhe4hguMfI
	9I3FZsLNUu6/BrKYe4Z2xAHXicv2gjL71u8fy82hteAZLmbGLHEwrhQB5TBalJdkLeytmE
	yvcF/HwOPR0CWBtfRamD5kC8M65Vd4R4OxBXntIWbDhWafEwk9n8sGuH/T6veQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761554670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=VQmyoOet3ZH5HQRVE59iB+D2S5nx1PfyGcDowX85zMY=;
	b=v+gUqijwotEMVMOnr8td4meGaiZxr9joh9T2iGEC6ayaXFcF3jk+r5dRfCyWeZyG0Erplm
	ZHiQceLiUz88OtBQ==
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
Subject: [patch V6 07/31] rseq, virt: Retrigger RSEQ after vcpu_run()
References: <20251027084220.785525188@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Oct 2025 09:44:28 +0100 (CET)

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


