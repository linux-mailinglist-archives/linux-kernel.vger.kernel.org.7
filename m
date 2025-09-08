Return-Path: <linux-kernel+bounces-806800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A326AB49C02
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38C157A14A2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0CC2DF71F;
	Mon,  8 Sep 2025 21:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y36/l8cP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0SQ6AoZH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFC08528E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367111; cv=none; b=rsxFZ01liIa38CLZevr64hA4L28beGXnQw4L8PFFnGhl6muMeRJoG4aqtiHuHsdsSk7sOTQlsMceetXdad/dtkUPxBj0HInDTEGpK0WFuWFRqpXBWDE1jQ+Ix5PCFLpeaGtrS9TDe7nlhrVFhkNKztMpFZ+mL7/qPvh0jpz2EwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367111; c=relaxed/simple;
	bh=wu6hAxsKWPE7DY0S8ysZCgyOw4/tfRE7eiBN1EwRIn8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ahNObN7AB7yM7T1IPwq/+d9LRRKbJdjemN6yyJUHiUhyfAC7/gSColzpYg4DXCV1fMayTiAtfzrXLPfs4Rc+zOWCh3kfSdF6+ztbDk+dhuu4MiHU/P0sOHHkRxJyjdyGgynae4o5EwbYMEiVAd+KNxzKShBM32RMRuZLK5YwoYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y36/l8cP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0SQ6AoZH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908212925.969535895@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757367108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=W772ppsbVXrcXgg6JXtZ2z6RDHZDwt4/nIDNxAIJr7w=;
	b=y36/l8cPsROsi8S78ljTL/R2TH8p7SkKzcd9ak3OwVH7L3ry4LuQl5aRVBvYGZFegKi9Hz
	nL0x9NAQVsWHP042bmC5lxeftQmNFgPpxsC7ss1oUNnP7FhrK1gwwqEJzYPBFnxXCrSca0
	7NOXwBLAzwMMcS/jYHZcGAJ/SR53nxxIwq67SqHWtAmVr8nGad3qiLixjfTf1DUdrywcTv
	lEZpWr95g9tpgFZpUqsSJRcFjU7hIajdbSZEnFNY3ZxOQrlzTJDDOu0mgKF4h2OT9RlMIN
	zUB7+Boe13vtFBnmDo4PRl2GHskQoKdqNu5v1TjVcr9lqVr7q8MHljWiO+carw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757367108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=W772ppsbVXrcXgg6JXtZ2z6RDHZDwt4/nIDNxAIJr7w=;
	b=0SQ6AoZHUslud7ILRXLyT7tLlwL3lrdT6JOQiPtuzpzlOSXPfogZa/HzdnnqHAZmYWhJAr
	SujdOeF1NEbGskCA==
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
Subject: [patch V4 11/36] entry: Remove syscall_enter_from_user_mode_prepare()
References: <20250908212737.353775467@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  8 Sep 2025 23:31:47 +0200 (CEST)

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



