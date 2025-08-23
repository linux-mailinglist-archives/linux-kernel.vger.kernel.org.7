Return-Path: <linux-kernel+bounces-783266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A889B32B08
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340A71C21DF3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F93126C39E;
	Sat, 23 Aug 2025 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4zYojfpK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hUShs27G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FB82F549B
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755967244; cv=none; b=mv0wu5tp4al4J+jd5/GEpIB05jqP8pGF1mSV6+cx7hoZRnyUpUogfIE9XNn5/VwgX3IoNGgsksLg/JBFsSuS/nxPQaBKIuvrtmItxd4L1VNEWtV60tv4SfboliPS18NssOd8IN66/dw90GAvkTJNosAY6lTdenHqtx0WnB1ttLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755967244; c=relaxed/simple;
	bh=Kebqi7zs68suX4hBibbGKFsJnoYojzyioIExTFP5qvQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=FpZZka+PKrc/S0m8ffTAXPhlTfVuKij7f+rEplwFrx7aJgveIMLAS4P5L3h6Sol2zn8QzBDO1FuXVQJwh9fBPqHhIkbp7JcRIpj2keUmY7hwJnkqACzjAjtKn8rDcTbsncR0ekEEExG2WSkWJX8ijQS1+b0v7fXG2AUMuC7Pr7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4zYojfpK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hUShs27G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250823161655.586695263@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755967240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=G3mvqN4QOI2mGVfxb8vMPb13HQ+DT9JFumag0CQ44Us=;
	b=4zYojfpKPS54S4XIH/Ty/IUs8fAXIKktmfFB8K8kfrObTBaw4W4G8n2dZy+8iyEFw9AaZW
	670Ib5b1mnTuZc6cFMd/+rRM3Zgvbx2PLJBum9XaffTgto6b5Qogkq8i6qTYdfMNZcIAgn
	5XY10T4bKpAAIh0e78OgpVigUD+Toz88gft18J9YAFyxZXjqk4T8DWCcwRLQvbrB9gwJLd
	VL4vb5ilM77eX43YNKODVJnP7yRiqOCJ8qsZA+cELbUysxtiWqtb99150n9j3mV8sSJLEf
	3eKhsmoY7WsfF83HotK/TXpfw3+oTMOBrcF9Cg8Se9qk9oQdzJPQ7/0FwHndlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755967240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=G3mvqN4QOI2mGVfxb8vMPb13HQ+DT9JFumag0CQ44Us=;
	b=hUShs27G5EKOpHtYdqguCAnHCiGOXlwokkuJaU1ZwSHWzDyMX0VGK2sxiWz2NuOXhJ0htE
	2wfiwsPT/tFXTNAA==
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
Subject: [patch V2 36/37] rseq: Switch to TIF_RSEQ if supported
References: <20250823161326.635281786@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 18:40:39 +0200 (CEST)

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
---
 include/asm-generic/thread_info_tif.h |    3 +++
 include/linux/irq-entry-common.h      |    2 +-
 include/linux/rseq.h                  |   13 ++++++++++---
 include/linux/rseq_entry.h            |   23 +++++++++++++++++++----
 include/linux/thread_info.h           |    5 +++++
 5 files changed, 38 insertions(+), 8 deletions(-)

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
@@ -122,7 +122,7 @@ static inline void rseq_force_update(voi
  */
 static inline void rseq_virt_userspace_exit(void)
 {
-	if (current->rseq_event.sched_switch)
+	if (!IS_ENABLED(CONFIG_HAVE_GENERIC_TIF_BITS) && current->rseq_event.sched_switch)
 		rseq_raise_notify_resume(current);
 }
 
@@ -147,9 +147,16 @@ static inline void rseq_fork(struct task
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
@@ -502,18 +502,33 @@ static __always_inline bool __rseq_exit_
 	return true;
 }
 
+#ifdef CONFIG_HAVE_GENERIC_TIF_BITS
+# define CHECK_TIF_RSEQ		_TIF_RSEQ
+static __always_inline void clear_tif_rseq(void)
+{
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


