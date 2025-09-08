Return-Path: <linux-kernel+bounces-806799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE5FB49C01
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB164E2002
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE242DF6E3;
	Mon,  8 Sep 2025 21:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mggKKJBp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GGvYyhKd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E6F2EA166
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367109; cv=none; b=jgMuTSxSXpFH4TAmACBel2ulC3girbKacNLb7pl4VVyPpldXS31/5dYjL2AX4YOZizmpxKZBdzW1kGohyXwoSJGeU1QiLkQfl/r0n94skv5MLwxV1sencyHOY/bhoiTPouCyOKBkXBSR2tCYBo2zZx44Uh9uIGozqQC1T34UePs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367109; c=relaxed/simple;
	bh=VRCH+3S1nYLtsVP5wT5GRsIb5J5+wL3+Y5fgdPoc/gs=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=YnQwvp0WmUn6i4O0Nbs/vOmatmUZ+Vwgpk1yktfhmTQ4e9SMlVTmGckoGRyVmNbvs6azgieMc4etUvgkNvV2I5xzIO5jwtAtyjDBBl/ccrwKnrcM5YiruvT2+ktY9OWUX3/rFZ0IKnpnQAWyHYUeVizmcGhhRpKOFPRCR+lnUqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mggKKJBp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GGvYyhKd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908212925.906204537@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757367106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=hkDPRPHuDwYKtAirw1GKBU+66QpeUXopf/S0l+gqCv8=;
	b=mggKKJBp5Nq6COvo89BBeXHubL5w7Hcc4j3A9xhEUQzweQZNeeZMn5YOy/ll+cZyERSrwo
	TlaoM0zflZCRsyp5OKj1jf8CSQCf0NtVSoFTfnqSrf+rqlhPB9oBdj3GwOpVzXEEw73vkI
	nVqais5Vkwk1zTZQwhbu8RZRnpuh2xPsPKnbriPToBjVxTFPaP0zqJhGAWVkq7+gnKQydk
	18AqGH40ouCDu0eVotKcTQ0vzgUHxTlpzvQYro7ySxGO7baYI772AWG8WNXXOLDTBsezm1
	TyUy6NEiGp19W1iJonyV24/orAZwyrsKPHeqtACIHhUe5RNWM0xAOO9b52959A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757367106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=hkDPRPHuDwYKtAirw1GKBU+66QpeUXopf/S0l+gqCv8=;
	b=GGvYyhKdzY66s0mFO0JbzgorHXrApVa1mzBEosixxlkHUsbCEM0BDhijSOoBQZvjksdj9R
	kPhc5L0DibhR2bCA==
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
Subject: [patch V4 10/36] entry: Cleanup header
References: <20250908212737.353775467@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  8 Sep 2025 23:31:45 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

Cleanup the include ordering, kernel-doc and other trivialities before
making further changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>


---
 include/linux/entry-common.h     |    8 ++++----
 include/linux/irq-entry-common.h |    2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)
---

--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -3,11 +3,11 @@
 #define __LINUX_ENTRYCOMMON_H
 
 #include <linux/irq-entry-common.h>
+#include <linux/livepatch.h>
 #include <linux/ptrace.h>
+#include <linux/resume_user_mode.h>
 #include <linux/seccomp.h>
 #include <linux/sched.h>
-#include <linux/livepatch.h>
-#include <linux/resume_user_mode.h>
 
 #include <asm/entry-common.h>
 #include <asm/syscall.h>
@@ -37,6 +37,7 @@
 				 SYSCALL_WORK_SYSCALL_AUDIT |		\
 				 SYSCALL_WORK_SYSCALL_USER_DISPATCH |	\
 				 ARCH_SYSCALL_WORK_ENTER)
+
 #define SYSCALL_WORK_EXIT	(SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
 				 SYSCALL_WORK_SYSCALL_TRACE |		\
 				 SYSCALL_WORK_SYSCALL_AUDIT |		\
@@ -61,8 +62,7 @@
  */
 void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
 
-long syscall_trace_enter(struct pt_regs *regs, long syscall,
-			 unsigned long work);
+long syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long work);
 
 /**
  * syscall_enter_from_user_mode_work - Check and handle work before invoking
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -68,6 +68,7 @@ static __always_inline bool arch_in_rcu_
 
 /**
  * enter_from_user_mode - Establish state when coming from user mode
+ * @regs:	Pointer to currents pt_regs
  *
  * Syscall/interrupt entry disables interrupts, but user mode is traced as
  * interrupts enabled. Also with NO_HZ_FULL RCU might be idle.
@@ -357,6 +358,7 @@ irqentry_state_t noinstr irqentry_enter(
  * Conditional reschedule with additional sanity checks.
  */
 void raw_irqentry_exit_cond_resched(void);
+
 #ifdef CONFIG_PREEMPT_DYNAMIC
 #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #define irqentry_exit_cond_resched_dynamic_enabled	raw_irqentry_exit_cond_resched



