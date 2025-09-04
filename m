Return-Path: <linux-kernel+bounces-801747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4CBB44980
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B31115A7BFC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D0F2F60AD;
	Thu,  4 Sep 2025 22:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="swcc0fn1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nYDjTZc3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475B62EAD1C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024458; cv=none; b=Fenli8vrJI1Wd6O47pYA2o8rJz2RtL9j9qbShslESvInZHBf/SFxJK6fegBEAiuZccuqJBLB6itrjXQOewekBQaqkcW7UYAlHW93+aZXVSEeAbjr5aJ6zoz/J3dasZ1sHj44wOk3Lvw50caMUgTPf5+9F4UFKnjwpiJQxdc//Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024458; c=relaxed/simple;
	bh=wu6hAxsKWPE7DY0S8ysZCgyOw4/tfRE7eiBN1EwRIn8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=PiDO+S+S/cy20RT8Td2Qbb8QuM1q6p1Z8/Pn+wbq9BZrhE/44ffvX0EhRnHwjhN5CoYlRk5W7YUc8fmCvFkQRtC+awfNsmzbpNJhDTLQ3mL9NwGI/syYRavq8wjp1BtxafD0jE3WBp9PT/WKzpfuz4v50veQXmQSFAm2b86s/iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=swcc0fn1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nYDjTZc3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250904185719.838878425@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757024455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=W772ppsbVXrcXgg6JXtZ2z6RDHZDwt4/nIDNxAIJr7w=;
	b=swcc0fn1FP7JSDiIjKHP1b9pRO6YNvW/ba54H5aiRtmQclzmR2jy0UoXK6UNUm7RwYJGww
	UBqY0CqYjL3N4fG1XEEzEFY8bfROEc1+iDDvp/xl+LoPiZ5182M/x8+j/xa8/1rtqnj8EK
	/LQi92amxFrQt/QfLXLK010oLFU4L5Alzle2JpDJ42PqlycuQn2tisOhdEKvDZV8PsrbkE
	kTIWRS2JRRKBUKUhutthWx+zEENwaHGTEaFOvq65WTat2dvK8UqBFm1uiYj1v8CDURLMlu
	Gfn3Xx81OFt8R4WpPZbGWOZcbxz0NoVIeJuu3tcgUjiq5ZUjzcNHqv6yiklObw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757024455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=W772ppsbVXrcXgg6JXtZ2z6RDHZDwt4/nIDNxAIJr7w=;
	b=nYDjTZc3t3zvvUekd52bhJvALPPkD/c6hiWNquAzBNh8yeEpTLlsFX7+lcoYYTrv3RURWb
	l/XIAh9d+DETAXDA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 x86@kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [patch V3 11/37] entry: Remove syscall_enter_from_user_mode_prepare()
References: <20250904185336.943880027@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  5 Sep 2025 00:20:54 +0200 (CEST)

Open code the only user in the x86 syscall code and reduce the zoo of
functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org

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



