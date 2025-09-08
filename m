Return-Path: <linux-kernel+bounces-806818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B53B49C15
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EE457B59CB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769BA320CB6;
	Mon,  8 Sep 2025 21:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4owem+DP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/QfregFy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF2E2E228D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367149; cv=none; b=dd+sVbx9cDsbpi8UkpbpbLvg4l10SAUI4z5djKyw85Hc9WDLqEIGUrCebcHLj7Ar9gIj7mKFz4sUxB2TcEbEx5yLiG1rNmBaxynIXV8STewI+FztwtGBzz7Oq/gaRSnDtxFLQBUJUOZ4pmGZgm1BU6V9Nqp1q9kXTqWxQ/WFt2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367149; c=relaxed/simple;
	bh=j/2KYHKwMUKHzSF9eJA6I9CmNXA9iNyyoRgUC+QBP0I=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=bNBWMRicxxf5pQXNu03OigJBvqH1eqsnMc21yD8Vn67aiHnzNlJa3ZJT33TdJ0GIbf4TwTXHmi9IBWkyPsyf40DusN3pT/fBrgK5ZxXv0J1LrdAlfae1mMmAZzbmeC59NP5KcYwkU/AzeLev9CEAQrtbilfcnJTP4QFLh1FDZoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4owem+DP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/QfregFy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908212927.122992794@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757367146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=uEpXb4MYm4+O+MxEi6/Nv49MCNNEk4A00lo72YqNxnw=;
	b=4owem+DPsAERQ0QyT9rTbqvOZd5CRlKBnSo81czoks444BqEp5HQm4kSIQC0XFdKr1ref9
	P6ExJpG/feZ+9rtC/IA4TGoddchSCnUrSNebpcI0Ws/6hylkMQGciJsJsIkXXhay7Cz/Aq
	s1XibNbyX20sJaWgs34e4hnNCGtZyN2emv1yRp9f+DfNPKcx+fBF976K5aRZKjz270ff8x
	bAJgoVUIn19l5KAHlnyHzkIO2QdEtuZZf/h4rgmC4ecJVeFrnhnMucDrd1LCLRtumRXRJe
	/f7TBwQTmbgVR3+Xb9pNP6sU2ls/1E1nQa34UH3X99hfxil5KNliUFw6tYbJbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757367146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=uEpXb4MYm4+O+MxEi6/Nv49MCNNEk4A00lo72YqNxnw=;
	b=/QfregFyqTNkYwOKIMddI9oVmZGfkzlKOZNMQHAanb31AOm+DKFNbDNMuR1kvyWmZ680Z3
	stDCOph34DwLM0BA==
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
Subject: [patch V4 29/36] entry: Split up exit_to_user_mode_prepare()
References: <20250908212737.353775467@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  8 Sep 2025 23:32:25 +0200 (CEST)

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


