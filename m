Return-Path: <linux-kernel+bounces-864994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F5ABFC01D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9030819C5834
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92CA34EEF1;
	Wed, 22 Oct 2025 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YCRC+Bi5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="90UjjEyF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DC434B699
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137567; cv=none; b=dfa0kzrZSS7vNNBHybQhRm6ia2eQ2GtqKxTG28kTGaufnvGm53iEC9e2WGxaQGeJwvNC27HXX0hH9Jdc4pSEqmR7Zggkz3dJpgOkyUdPlDlsz9YWca3wy9DgjV2cClT6gAR2aE/8byQBT8Q/FJ48YoJZaGzfGvt855iokpbTn9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137567; c=relaxed/simple;
	bh=fSAYLVd5AqHucCuNHOo0vXpOkZl/dhTZKCK1EjF/s0U=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=OIjl5qfX1tw1poxpnA/FTcbe8S14wbCCfjxzJeYTWUWGdeljDdzJ2WkO8eVX71JfYic+7xeejFXfwBJrgoUvUhf9yzssr0KZ8bxVn9u/nHlppfXwee2mFilOkdur277WuJ4Dmt4bg3QCWyIJ45TlArOwbYGUi5kTr5M31ctAcgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YCRC+Bi5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=90UjjEyF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022121943.217839762@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=MC87nopEMMD6W1ICzJrXeQbGP0Yoxe/0UCOwm3vz4Qw=;
	b=YCRC+Bi5Tc09spdl3Oaa21T1QnQobgGdVlvP0fHRBCVvk9oQNAq0Ad85VgYBAi+tAzLol4
	5Iiim6M4TC1vciPt37ZsE5350NC0dmc6/QzGqPktv0fk822sukFDXbA7ilQS08Axx5xOvL
	ghDJSdFds+VBiSnjJkRWTueacd6An/Cc/cJjPbD/cqoA6oW5xvNw+b11cER8UAvWQsyCFb
	WNgqhxzoZnAQdWzZ4Qpi+Q6bJlWoyfo3uNNKxygxkrlpE/Kd2owiITay8e2cyafYtztP2k
	cX7U5LCeqSUTPN2bsOntYC0RhQ8aHgKdqGEmx/eTmRpVBQk/6++IxlM7k2gtYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=MC87nopEMMD6W1ICzJrXeQbGP0Yoxe/0UCOwm3vz4Qw=;
	b=90UjjEyFkCJLg4HoW7qKvqWiQDhsjEG/AMDIU2F5gTPkm5DgvapWCsw5jNXyOxe+u/E0Is
	Hv0ZMfaPYxq6FWAQ==
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
Subject: [patch V5 29/31] entry: Split up exit_to_user_mode_prepare()
References: <20251022121836.019469732@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:52:36 +0200 (CEST)

exit_to_user_mode_prepare() is used for both interrupts and syscalls, but
there is extra rseq work, which is only required for in the interrupt exit
case.

Split up the function and provide wrappers for syscalls and interrupts,
which allows to separate the rseq exit work in the next step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

---
 include/linux/entry-common.h     |    2 -
 include/linux/irq-entry-common.h |   42 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 38 insertions(+), 6 deletions(-)
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -156,7 +156,7 @@ static __always_inline void syscall_exit
 	if (unlikely(work & SYSCALL_WORK_EXIT))
 		syscall_exit_work(regs, work);
 	local_irq_disable_exit_to_user();
-	exit_to_user_mode_prepare(regs);
+	syscall_exit_to_user_mode_prepare(regs);
 }
 
 /**
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -201,7 +201,7 @@ void arch_do_signal_or_restart(struct pt
 unsigned long exit_to_user_mode_loop(struct pt_regs *regs, unsigned long ti_work);
 
 /**
- * exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
+ * __exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
  * @regs:	Pointer to pt_regs on entry stack
  *
  * 1) check that interrupts are disabled
@@ -209,8 +209,10 @@ unsigned long exit_to_user_mode_loop(str
  * 3) call exit_to_user_mode_loop() if any flags from
  *    EXIT_TO_USER_MODE_WORK are set
  * 4) check that interrupts are still disabled
+ *
+ * Don't invoke directly, use the syscall/irqentry_ prefixed variants below
  */
-static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
+static __always_inline void __exit_to_user_mode_prepare(struct pt_regs *regs)
 {
 	unsigned long ti_work;
 
@@ -224,15 +226,45 @@ static __always_inline void exit_to_user
 		ti_work = exit_to_user_mode_loop(regs, ti_work);
 
 	arch_exit_to_user_mode_prepare(regs, ti_work);
+}
 
-	rseq_exit_to_user_mode();
-
+static __always_inline void __exit_to_user_mode_validate(void)
+{
 	/* Ensure that kernel state is sane for a return to userspace */
 	kmap_assert_nomap();
 	lockdep_assert_irqs_disabled();
 	lockdep_sys_exit();
 }
 
+
+/**
+ * syscall_exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
+ * @regs:	Pointer to pt_regs on entry stack
+ *
+ * Wrapper around __exit_to_user_mode_prepare() to separate the exit work for
+ * syscalls and interrupts.
+ */
+static __always_inline void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
+{
+	__exit_to_user_mode_prepare(regs);
+	rseq_exit_to_user_mode();
+	__exit_to_user_mode_validate();
+}
+
+/**
+ * irqentry_exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
+ * @regs:	Pointer to pt_regs on entry stack
+ *
+ * Wrapper around __exit_to_user_mode_prepare() to separate the exit work for
+ * syscalls and interrupts.
+ */
+static __always_inline void irqentry_exit_to_user_mode_prepare(struct pt_regs *regs)
+{
+	__exit_to_user_mode_prepare(regs);
+	rseq_exit_to_user_mode();
+	__exit_to_user_mode_validate();
+}
+
 /**
  * exit_to_user_mode - Fixup state when exiting to user mode
  *
@@ -297,7 +329,7 @@ static __always_inline void irqentry_ent
 static __always_inline void irqentry_exit_to_user_mode(struct pt_regs *regs)
 {
 	instrumentation_begin();
-	exit_to_user_mode_prepare(regs);
+	irqentry_exit_to_user_mode_prepare(regs);
 	instrumentation_end();
 	exit_to_user_mode();
 }



