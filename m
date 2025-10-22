Return-Path: <linux-kernel+bounces-864976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 360E3BFC008
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF52620538
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6995C34B434;
	Wed, 22 Oct 2025 12:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uKYPQ7f5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+RUYqsLA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FD43491E5
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137543; cv=none; b=csf+8LBH2ysjysYsWuy0CSyvZp8sQvT3RO6HowHVYEJKTLjL0PnF/CRfaYEleAHCX/yKrob9eWNuGYTbpDhXaOd4/3j53NqA9XGtlFEdQm87mWxMRnikzJlN2jUxZ9qcQRcmCoeTrkPJ2d0HtNhz4GNTYnWGxMOxUxfrruayBSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137543; c=relaxed/simple;
	bh=SeZPdTmCe4v+WYd34OKEanmX+1ItPZGmEBGQa4R02iw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=O5IvZjjxKZQgMF8qQT4XuSgZhdCcGEk1gK+fbKdi/DyRu/KVXbhvoVgIp6dyCpDghi+I56PEA55Bs2w3df17XHZDbQxDAUqzaSGCojqa9lO6MisyKYPA95VtjrXreaTjUesJph9eAIgoxdHK0mDVrd8SEcZTk4NM9/bzdXicFPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uKYPQ7f5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+RUYqsLA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022121942.089707275@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Wc6dWcdga2mtG0gAvqUcpS69T+Kix6UflFrDQXjtfs0=;
	b=uKYPQ7f5cpOH6iYvFH3xkHWsrfKyEcUI9E5vQQzpiBeqqgXoRfs67v0Ss5e19xQK6o4wqu
	MX/Pd5qu6NZQcmBBcJtWQwH2TdW0M7+wrcbbOfBKT8ToMf9FF+h54S0W69SsFn/myXauQS
	cHUHlLhH1gBA/2FsMxROUPkzqft6ooLD6mU3lg7YGJ00mO27h0AWwJ5dQYba6Z/xqEXgAG
	I9905TrsS3Y6+AHPCvTy7/0sIDv9CsfUCl9QsvJ1ElTKPQCW78hTAkuoduxpMy1lIESPry
	YF+Q3hCqNwqGoEgA9kvBi1UH3ZAhseTgBMfFZopMIJS9K2k/e7n5KzjC1HHJRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Wc6dWcdga2mtG0gAvqUcpS69T+Kix6UflFrDQXjtfs0=;
	b=+RUYqsLAs+MRdmeK3oqBKGkDhzPDmkDMF6CmMlKuTGEcNCseS21c8i4fx0lx4sPrgTWX1J
	HVMlF/aB/QoIn0AQ==
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
Subject: [patch V5 11/31] entry: Remove syscall_enter_from_user_mode_prepare()
References: <20251022121836.019469732@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:52:14 +0200 (CEST)

Open code the only user in the x86 syscall code and reduce the zoo of
functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

---
 arch/x86/entry/syscall_32.c   |    3 ++-
 include/linux/entry-common.h  |   26 +++++---------------------
 kernel/entry/syscall-common.c |    8 --------
 3 files changed, 7 insertions(+), 30 deletions(-)
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -274,9 +274,10 @@ static noinstr bool __do_fast_syscall_32
 	 * fetch EBP before invoking any of the syscall entry work
 	 * functions.
 	 */
-	syscall_enter_from_user_mode_prepare(regs);
+	enter_from_user_mode(regs);
 
 	instrumentation_begin();
+	local_irq_enable();
 	/* Fetch EBP from where the vDSO stashed it. */
 	if (IS_ENABLED(CONFIG_X86_64)) {
 		/*
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -45,23 +45,6 @@
 				 SYSCALL_WORK_SYSCALL_EXIT_TRAP	|	\
 				 ARCH_SYSCALL_WORK_EXIT)
 
-/**
- * syscall_enter_from_user_mode_prepare - Establish state and enable interrupts
- * @regs:	Pointer to currents pt_regs
- *
- * Invoked from architecture specific syscall entry code with interrupts
- * disabled. The calling code has to be non-instrumentable. When the
- * function returns all state is correct, interrupts are enabled and the
- * subsequent functions can be instrumented.
- *
- * This handles lockdep, RCU (context tracking) and tracing state, i.e.
- * the functionality provided by enter_from_user_mode().
- *
- * This is invoked when there is extra architecture specific functionality
- * to be done between establishing state and handling user mode entry work.
- */
-void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
-
 long syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long work);
 
 /**
@@ -71,8 +54,8 @@ long syscall_trace_enter(struct pt_regs
  * @syscall:	The syscall number
  *
  * Invoked from architecture specific syscall entry code with interrupts
- * enabled after invoking syscall_enter_from_user_mode_prepare() and extra
- * architecture specific work.
+ * enabled after invoking enter_from_user_mode(), enabling interrupts and
+ * extra architecture specific work.
  *
  * Returns: The original or a modified syscall number
  *
@@ -108,8 +91,9 @@ static __always_inline long syscall_ente
  * function returns all state is correct, interrupts are enabled and the
  * subsequent functions can be instrumented.
  *
- * This is combination of syscall_enter_from_user_mode_prepare() and
- * syscall_enter_from_user_mode_work().
+ * This is the combination of enter_from_user_mode() and
+ * syscall_enter_from_user_mode_work() to be used when there is no
+ * architecture specific work to be done between the two.
  *
  * Returns: The original or a modified syscall number. See
  * syscall_enter_from_user_mode_work() for further explanation.
--- a/kernel/entry/syscall-common.c
+++ b/kernel/entry/syscall-common.c
@@ -63,14 +63,6 @@ long syscall_trace_enter(struct pt_regs
 	return ret ? : syscall;
 }
 
-noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
-{
-	enter_from_user_mode(regs);
-	instrumentation_begin();
-	local_irq_enable();
-	instrumentation_end();
-}
-
 /*
  * If SYSCALL_EMU is set, then the only reason to report is when
  * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall





