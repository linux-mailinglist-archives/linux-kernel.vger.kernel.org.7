Return-Path: <linux-kernel+bounces-871118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E9CC0C7C6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5001E405990
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC28A314B76;
	Mon, 27 Oct 2025 08:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MSljGMgA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zfv5hlcs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5DB314B65
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554729; cv=none; b=GP2fIzq7qRQH6A+CWDJVMk/l6+zbKGmh0YqJQVPrJ0oZbUaOJzqP6Jm0vR2c28he/eQxfxoVgK0xZ6JXzIOm31Aor9U/EgYUSM7BPTsUusPoDGZJliWlZTeuR67fkI2PlMS18OgT/8F32ij3g6XCVOY/LLX+s7GqFR7QbNKr6tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554729; c=relaxed/simple;
	bh=fSAYLVd5AqHucCuNHOo0vXpOkZl/dhTZKCK1EjF/s0U=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=SpxIu5rSK5WvKnNWV+/zIojyzjShBoEYUlH2sQT8oBLmYEXvZI3vUBmgYjDSLknl9Aqxrk/VYGD5SjBm7V5hibCBqcEMVgsavgIj+k/eUD+AHKwtWx8Lkycsnvj2e1G6EO7ve5k6AXGRtnrm1SNQCVUDp6AP3svWcyTikzEcd6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MSljGMgA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zfv5hlcs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251027084307.782234789@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761554723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=MC87nopEMMD6W1ICzJrXeQbGP0Yoxe/0UCOwm3vz4Qw=;
	b=MSljGMgAymDco8oA1Hp3kyWOtbrX9bhRH97qzKXArx6Q/c/OFRCYLpDN3OEt36S9g3rMFZ
	yjnMO62slu0Q6gS5z44zCohUTgQrClvzlGR/6mRwNw0Nv0EaHcqu72f0vRObtUvv6TmqJU
	PdEV0E6Zw4pNvvVf52+Fpp3OVT6GGTU9nhHVYqUs7XAVXL2fYFsbKR4jGaAfVlaTmk271e
	8RbcSMmBcsm8pXYuGFh+xKu8I9p8lHIjHLlCGMGFKm0OEPcpuAgliuvE/22HSUix+gEsjf
	3vqWv7hSr+uN0JiIRDR4KWhuOIyoL4tL4DraCWazmtsobwtzJ8P9TSyHJFQsmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761554723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=MC87nopEMMD6W1ICzJrXeQbGP0Yoxe/0UCOwm3vz4Qw=;
	b=zfv5hlcsWcGj/ez9RCuzgKEZAKWd4UlKBZO3ZbIT7vgoTWUPzfrmESumNwS49ehWKQ4Ltz
	kwzIJcbFkEleL5BQ==
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
Subject: [patch V6 29/31] entry: Split up exit_to_user_mode_prepare()
References: <20251027084220.785525188@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Oct 2025 09:45:21 +0100 (CET)

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



