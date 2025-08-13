Return-Path: <linux-kernel+bounces-767155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D092B24FEA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC891AA1278
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A63B286D7C;
	Wed, 13 Aug 2025 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VkG0rcW9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m8V7XmA9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A8228D8D8
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102576; cv=none; b=kMOZGKGN3dGFQRqN3KOWloPMwPSwYTGIH1Tz9v31d03B9dl37T3S3rgBgeyGIz5p8jF9iu4PZ4ulwq66bxv4hyPjrH7mEoKtbjioxJS3gNcr8G/G19odXPcX15r2q4cP1O2ceELg3AG0oZjUOe+gxtOagEuZgrRIa8rvVA9J/vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102576; c=relaxed/simple;
	bh=3e83nG6p4d5uN3wwhpJuJqLbKSHLqHMSvS35UkZUuag=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=F0odlcDVs8LvY/6GDR3mvBiprrrh1zufoRysNRWAnAy0PAE7B6Pd/YziCyez3Ejj617hzbeNH2ri6Gd3Gu95e+JkZpy6lpS4PcCy1g2emD8brQvBGY8zTlqIMsmGXVf2AHr7XQk6G4D8ybmhuTZ35zyBak1zPlNaOAaHs2+pObQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VkG0rcW9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m8V7XmA9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250813162824.292368751@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755102573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=DglVt0e/OnUdWnQ50KHsL8OGNpVNZbUOXHH6mXMI3gU=;
	b=VkG0rcW901+phFfCGgTjwYsBO9bqaaAtdSiSkPnFFq+r8KbcRqC34tdkWtI8LIWqf3JhjG
	dnfbFRBh9u+zFGkZcd8xZ86/M/ty+l21uVl7SlXZyf/3e/nN+F+zsqHMZMdDvDaggxHWYO
	Dum7SrFrStfGfe3bOn5bRNoqofheMxT5Ej8lAzjo6oOWtSu8R5SbtmdTf/GhlNlKkjDPyn
	Dt4oS8Pxf5a3LbZXLYYLsTU6ZT3m19yyT5Vt2nboW1z1DrENAa2T9WU71UVUx9lmfn2T1f
	SjbyFYiqosk8Xj/jkPCtNBBKTxGGIwFMfkC5xQpKO3n9GX9M1CwGVZD6WQ7ahw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755102573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=DglVt0e/OnUdWnQ50KHsL8OGNpVNZbUOXHH6mXMI3gU=;
	b=m8V7XmA9tJnTL0oVY638DsvBbchm36No6fimaPWbqLCbLrOFgmDGD6KRqTzRrZuo0nVCkP
	Lv9DODcf4mXDPCAg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Wei Liu <wei.liu@kernel.org>,
 Jens Axboe <axboe@kernel.dk>
Subject: [patch 08/11] entry: Distinguish between syscall and interrupt exit
References: <20250813155941.014821755@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 18:29:31 +0200 (CEST)

The upcoming time slice extension mechanism needs to know whether
enter_from_user_mode() is invoked from a syscall or from an interrupt
because time slice extensions are only granted on exit to user more from an
interrupt.

Add a function argument and provide wrappers so the call sites don't end up
with incomprehensible true/false arguments.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/entry-common.h     |    2 +-
 include/linux/irq-entry-common.h |   22 +++++++++++++++-------
 kernel/entry/common.c            |    7 ++++---
 3 files changed, 20 insertions(+), 11 deletions(-)

--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -172,7 +172,7 @@ static __always_inline void syscall_exit
 	if (unlikely(work & SYSCALL_WORK_EXIT))
 		syscall_exit_work(regs, work);
 	local_irq_disable_exit_to_user();
-	exit_to_user_mode_prepare(regs);
+	syscall_exit_to_user_mode_prepare(regs);
 }
 
 /**
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -197,15 +197,13 @@ static __always_inline void arch_exit_to
  */
 void arch_do_signal_or_restart(struct pt_regs *regs);
 
-/**
- * exit_to_user_mode_loop - do any pending work before leaving to user space
- */
-unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
-				     unsigned long ti_work);
+/* Handle pending TIF work */
+unsigned long exit_to_user_mode_loop(struct pt_regs *regs, unsigned long ti_work, bool from_irq);
 
 /**
  * exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
  * @regs:	Pointer to pt_regs on entry stack
+ * @from_irq:	Exiting to user space from an interrupt
  *
  * 1) check that interrupts are disabled
  * 2) call tick_nohz_user_enter_prepare()
@@ -213,7 +211,7 @@ unsigned long exit_to_user_mode_loop(str
  *    EXIT_TO_USER_MODE_WORK are set
  * 4) check that interrupts are still disabled
  */
-static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
+static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs, bool from_irq)
 {
 	unsigned long ti_work;
 
@@ -224,7 +222,7 @@ static __always_inline void exit_to_user
 
 	ti_work = read_thread_flags();
 	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
-		ti_work = exit_to_user_mode_loop(regs, ti_work);
+		ti_work = exit_to_user_mode_loop(regs, ti_work, from_irq);
 
 	arch_exit_to_user_mode_prepare(regs, ti_work);
 
@@ -236,6 +234,16 @@ static __always_inline void exit_to_user
 	lockdep_sys_exit();
 }
 
+static __always_inline void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
+{
+	exit_to_user_mode_prepare(regs, false);
+}
+
+static __always_inline void irqentry_exit_to_user_mode_prepare(struct pt_regs *regs)
+{
+	exit_to_user_mode_prepare(regs, true);
+}
+
 /**
  * exit_to_user_mode - Fixup state when exiting to user mode
  *
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -15,9 +15,10 @@ void __weak arch_do_signal_or_restart(st
  * exit_to_user_mode_loop - do any pending work before leaving to user space
  * @regs:	Pointer to pt_regs on entry stack
  * @ti_work:	TIF work flags as read by the caller
+ * @from_irq:	Exiting to user space from an interrupt
  */
-__always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
-						     unsigned long ti_work)
+__always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs, unsigned long ti_work,
+						     bool from_irq)
 {
 	/*
 	 * Before returning to user space ensure that all pending work
@@ -70,7 +71,7 @@ noinstr void irqentry_enter_from_user_mo
 noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
 {
 	instrumentation_begin();
-	exit_to_user_mode_prepare(regs);
+	irqentry_exit_to_user_mode_prepare(regs);
 	instrumentation_end();
 	exit_to_user_mode();
 }


