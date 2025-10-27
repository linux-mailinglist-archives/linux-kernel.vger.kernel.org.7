Return-Path: <linux-kernel+bounces-871097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE6CC0C72D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDE414F6E4F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F0930F95B;
	Mon, 27 Oct 2025 08:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z4Uzu52B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dN0kEZkt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB122F6912
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554680; cv=none; b=cBtywS/egDtnN/IcTi6LHPVhdvF971eVknd2uV+AWLseVyEqbHb5BSUBIrjbibnddc1Kc1NcvxCCAi18qxBxBQq5jnaznXTAuvEq/XkQIb5SzsSGq2Y30DxKSDmfpzreXEc1rQUBEim4o70SwYF/ag2EJFf2FwYYcjZAy96YPf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554680; c=relaxed/simple;
	bh=Lb/w3BhjRzrsXCvCUDFGzCIOxidEz3RzuOjuQTkrykE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=MCUs+paS8p0D+6k7C+u7hq5fl42iAhJnL1SpDnZHDbNKTxvCAWwcuiEkdvUbjuNyF4lAQLJ1gc4MNyIoCnCYFhdzUDiUQ6Xic0WRqV5zwn4o5kutoWCzA1jCPw5ubvdtxt2oOisF0aL1YvBRp7zZuJhArHLiRMAATPKZboIqmDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z4Uzu52B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dN0kEZkt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251027084306.590338411@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761554677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=mhjj3z5Xu0lm96OOzRXu+oa1LeUseXOmoNzKxGmeiPM=;
	b=z4Uzu52Bnq9f/JYto2R5Ms5JztVrkq2bPSmJazZLeWeHOovART1ShAGC6U9qs0BoaUDkvA
	i2hyOw/8dz4A/clIjPkD+n0CfQweEcuM4yDnpZTeW4+SJtkh2vzykI6+srKIBBIQujaUp5
	A6xM/mIzA+wFKqAH8sbVUlnIBo4Ch6ciLzf7opfwBdAGT2yhWCIudmEFyyNLuVsufUdVvn
	74/GC0r8TflP66SZZXbsr7codOsosGxyoOPIpfeR7Z3N6f6hUxPV0K5QR9lxgIB8wQ/8Ky
	kLBpfUlXnS304GovRf9roaO5sJXhMqR7Qf0TEon0RvHRXT2E3lLGRi9PRzZsCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761554677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=mhjj3z5Xu0lm96OOzRXu+oa1LeUseXOmoNzKxGmeiPM=;
	b=dN0kEZktgTibErCi80ksdonRM2mqiTnXlXshOjLZkqmoiApqNGU4LoGquJEbAd0XYSQ7IR
	GXCSWiMtSu80T0Bg==
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
Subject: [patch V6 10/31] entry: Cleanup header
References: <20251027084220.785525188@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Oct 2025 09:44:36 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Cleanup the include ordering, kernel-doc and other trivialities before
making further changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

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




