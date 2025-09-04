Return-Path: <linux-kernel+bounces-801772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9D4B4499D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144625A438C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7BF352090;
	Thu,  4 Sep 2025 22:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aIj/HDRB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VWSRrZIo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7192EAB7A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024507; cv=none; b=NXtJQq0RuyaQQYPYK2b18WM8bSbYRxtHlAn/lFmCQbA3bG8Td27OsgSYwFCU3/uHDIVM/e2lB0QeGCe8WALb20wB2htrJCL6ycpstfOLFZrdTCKau4IVsdeT81Q/+62NoR+VJ4vW2TUyWzVCUOrDEtiemeUQw4LwiLFU7z2fxDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024507; c=relaxed/simple;
	bh=gi4QA+E7X8gRHMteseWQM0vGpCiFkTUBuE28veCgAFg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=SrlGN5VmLtb+3irQP2HdN90LNe9PpLkJF0HHawYHAbjesVITbpxn/w6mzzhsyV3U+D0KBPwAZooqEoLnGKp6a/ey2VDvRlxMqaOJFFrxlRI6jrajnExfn1z9nxv3W5Tr9VvqBRpjPnh8JNFUZ/5awhmnAm+FK85NvabrOSrdAVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aIj/HDRB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VWSRrZIo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250904185721.416919626@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757024502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=iGRHp8U+3cFABv02FoWUQV2e6ITLdhAA+Ld2YUNF2dQ=;
	b=aIj/HDRB0vW0NiU8GD2fpkhC6JCdSmLndLkjhAmNeifsJ53xgoP0oONzuA/czROYjviiLB
	mv+pyatFhZCPn0kh+V2S1OPtd/MH7djxNFFHZ1NJzUM/L0EP1ldH7nFAc2uVlASAYfNHBD
	741PGiVgXJw+pvB0a00c0QJV4DUgwvh9BcvdnVeXUXv2urNyaVsc0WNgQrKHwUP77chsAz
	jncN6w3sicqWLNXbTb6xo6YxDjN9UYXK90XJEJPO/4hs565ycQ+YFjPJ/13N/7uUetbGeZ
	UvSFA41Shh1kgDtpu1oBQQP51LrLJ9t8w8V6VGv4V3K21yaYdU/58jT0jT3ybA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757024502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=iGRHp8U+3cFABv02FoWUQV2e6ITLdhAA+Ld2YUNF2dQ=;
	b=VWSRrZIoL/mZ6/ucTOEWD2e3g7Fw0lA/LQ61Dnoa0tHVDLyMAgXChch8lTn9BHeXRatY8A
	geXKuw9QHY4O4ADA==
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
Subject: [patch V3 36/37] rseq: Switch to TIF_RSEQ if supported
References: <20250904185336.943880027@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  5 Sep 2025 00:21:41 +0200 (CEST)

TIF_NOTIFY_RESUME is a multiplexing TIF bit, which is suboptimal especially
with the RSEQ fast path depending on it, but not really handling it.

Define a seperate TIF_RSEQ in the generic TIF space and enable the full
seperation of fast and slow path for architectures which utilize that.

That avoids the hassle with invocations of resume_user_mode_work() from
hypervisors, which clear TIF_NOTIFY_RESUME. It makes the therefore required
re-evaluation at the end of vcpu_run() a NOOP on architectures which
utilize the generic TIF space and have a seperate TIF_RSEQ.

The hypervisor TIF handling does not include the seperate TIF_RSEQ as there
is no point in doing so. The guest does neither know nor care about the VMM
host applications RSEQ state. That state is only relevant when the ioctl()
returns to user space.

The fastpath implementation still utilizes TIF_NOTIFY_RESUME for failure
handling, but this only happens within exit_to_user_mode_loop(), so
arguably the hypervisor ioctl() code is long done when this happens.

This allows further optimizations for blocking syscall heavy workloads in a
subsequent step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
V3: Updated the comment for rseq_virt_userspace_exit() - Sean
    Added a static assert for TIF_RSEQ != TIF_NOTIFY_RESUME - Sean
---
 include/asm-generic/thread_info_tif.h |    3 +++
 include/linux/irq-entry-common.h      |    2 +-
 include/linux/rseq.h                  |   32 +++++++++++++++++++++++---------
 include/linux/rseq_entry.h            |   24 ++++++++++++++++++++----
 include/linux/thread_info.h           |    5 +++++
 5 files changed, 52 insertions(+), 14 deletions(-)

--- a/include/asm-generic/thread_info_tif.h
+++ b/include/asm-generic/thread_info_tif.h
@@ -45,4 +45,7 @@
 # define _TIF_RESTORE_SIGMASK	BIT(TIF_RESTORE_SIGMASK)
 #endif
 
+#define TIF_RSEQ		11	// Run RSEQ fast path
+#define _TIF_RSEQ		BIT(TIF_RSEQ)
+
 #endif /* _ASM_GENERIC_THREAD_INFO_TIF_H_ */
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -30,7 +30,7 @@
 #define EXIT_TO_USER_MODE_WORK						\
 	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
 	 _TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY |			\
-	 _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |			\
+	 _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL | _TIF_RSEQ |		\
 	 ARCH_EXIT_TO_USER_MODE_WORK)
 
 /**
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -40,7 +40,7 @@ static inline void rseq_signal_deliver(s
 
 static inline void rseq_raise_notify_resume(struct task_struct *t)
 {
-	set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
+	set_tsk_thread_flag(t, TIF_RSEQ);
 }
 
 /* Invoked from context switch to force evaluation on exit to user */
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
-	if (current->rseq_event.sched_switch)
+	/*
+	 * The generic optimization for deferring RSEQ updates until the next
+	 * exit relies on having a dedicated TIF_RSEQ.
+	 */
+	if (!IS_ENABLED(CONFIG_HAVE_GENERIC_TIF_BITS) &&
+	    current->rseq_event.sched_switch)
 		rseq_raise_notify_resume(current);
 }
 
@@ -147,9 +154,16 @@ static inline void rseq_fork(struct task
 		/*
 		 * If it has rseq, force it into the slow path right away
 		 * because it is guaranteed to fault.
+		 *
+		 * Setting TIF_NOTIFY_RESUME is redundant but harmless for
+		 * architectures which do not have a seperate TIF_RSEQ, but
+		 * for those who do it's required to enforce the slow path
+		 * as the scheduler sets only TIF_RSEQ.
 		 */
-		if (t->rseq_event.has_rseq)
+		if (t->rseq_event.has_rseq) {
 			t->rseq_event.slowpath = true;
+			set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
+		}
 	}
 }
 
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -521,18 +521,34 @@ static __always_inline bool __rseq_exit_
 	return true;
 }
 
+#ifdef CONFIG_HAVE_GENERIC_TIF_BITS
+# define CHECK_TIF_RSEQ		_TIF_RSEQ
+static __always_inline void clear_tif_rseq(void)
+{
+	static_assert(TIF_RSEQ != TIF_NOTIFY_RESUME);
+	clear_thread_flag(TIF_RSEQ);
+}
+#else
+# define CHECK_TIF_RSEQ		0UL
+static inline void clear_tif_rseq(void) { }
+#endif
+
 static __always_inline unsigned long
 rseq_exit_to_user_mode_work(struct pt_regs *regs, unsigned long ti_work, const unsigned long mask)
 {
 	/*
 	 * Check if all work bits have been cleared before handling rseq.
+	 *
+	 * In case of a seperate TIF_RSEQ this checks for all other bits to
+	 * be cleared and TIF_RSEQ to be set.
 	 */
-	if ((ti_work & mask) != 0)
-		return ti_work;
-
-	if (likely(!__rseq_exit_to_user_mode_restart(regs)))
+	if ((ti_work & mask) != CHECK_TIF_RSEQ)
 		return ti_work;
 
+	if (likely(!__rseq_exit_to_user_mode_restart(regs))) {
+		clear_tif_rseq();
+		return ti_work & ~CHECK_TIF_RSEQ;
+	}
 	return ti_work | _TIF_NOTIFY_RESUME;
 }
 
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -67,6 +67,11 @@ enum syscall_work_bit {
 #define _TIF_NEED_RESCHED_LAZY _TIF_NEED_RESCHED
 #endif
 
+#ifndef TIF_RSEQ
+# define TIF_RSEQ	TIF_NOTIFY_RESUME
+# define _TIF_RSEQ	_TIF_NOTIFY_RESUME
+#endif
+
 #ifdef __KERNEL__
 
 #ifndef arch_set_restart_data


