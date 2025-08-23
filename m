Return-Path: <linux-kernel+bounces-783240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B63EEB32AF2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9E53AEE56
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005D92ECE98;
	Sat, 23 Aug 2025 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zUBvPX3L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TX/j17TQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D782E7BAC
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755967174; cv=none; b=KtTQtX7BTtxcDzduBQ3DK1Pvd8SCrSatJc1lz6snPg9BETluoNN1dwpCJTP+4TF18a94paoiU8tMEVb3XNzFZ+hOjs0Frjsz/cn+vIfjknjsq9hEzIzh+uVtr+ZYh6+c1Qs0eNHRKrQKSCW/h/0a3NJNyyCJCh0e3ftlPS2/xcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755967174; c=relaxed/simple;
	bh=+zlItehC5oeBmZec4e/XUR5hjHWD0Fzmqplkgt8Dst4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=n9rJqg8crZj0WyNBWYM9yl6N3Osm1vMVFfBHRnyA8vE6V4OVfCTf8CPoqraS3y8VS/dIXb46XW3sJxQfhNLZfVorIdxe95mHJpH/xK20yA8GSqL9nNo22fdtWikYqOZX0kEONmmk227+QlYYHbHuAaTfAZEQa0/AHDraPOGLidk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zUBvPX3L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TX/j17TQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250823161653.907872775@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755967170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=4xQpSE03ORBdDfdjJuV6wcaPcbGOF7qlWXG2nsTAmDs=;
	b=zUBvPX3L94rAzOivqXbgTsE/jWxVLwioK3id0hcb1UqTsE9/soeSlp9T6AoEKTxQ75eZab
	lwTuH1XVsQcuMLhpBai6GI1LxMY3kQ/bQaBsusaT+6E0ppa0/Jo6Wda9Ar3Arf0BhNwe+0
	lcqJTJovsYZ9QA+r8g9KCmOfecAg24Q+RT291y0WBsdfWQIBw3TPFbyf3M92+vDRZOG9Uv
	hKbNw3Pi3V6DcGx3vh898Beg2QNN2Kc5QXC1DjlwYKi8JLphEEsYZ6n4W6waCKC5jyg77O
	7EK/pRjdYWuu7NtD0jNFw2E06q7VyfjXoitUzulMDhMGCd+7/5SN8cYujkCmtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755967170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=4xQpSE03ORBdDfdjJuV6wcaPcbGOF7qlWXG2nsTAmDs=;
	b=TX/j17TQF6nO8p12WP4CRzEX9Qz8ZJfh/LJpPhpKHRzOr2VEQFqTpg5L/PuMWBj5Yr8nt8
	rY3dWwJwHxgI49Cg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
Subject: [patch V2 10/37] entry: Cleanup header
References: <20250823161326.635281786@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 18:39:29 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

Cleanup the include ordering, kernel-doc and other trivialities before
making further changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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


