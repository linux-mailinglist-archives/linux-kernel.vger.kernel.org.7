Return-Path: <linux-kernel+bounces-767147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1750B24FDA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95FFB1892CF0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3506286D6B;
	Wed, 13 Aug 2025 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zizFNKF2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fo53kI+G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78412877F7
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102564; cv=none; b=KUWxu/XoZly1llvfeVYO8/Gm5O/1t6IWPvrkLq9wDuA4xpCcEaiUI0kcA/ACjD5n8cuHmO+4tMK8wrgQDDkMSHRzF/GO6bU7lfu2Dzjsl4q0Mrisi+Qb5jH5tO9+n62eWtJKqhUD/UIdpX3/Q0nO3mjW5UxYGGHCDRW0ARTPypU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102564; c=relaxed/simple;
	bh=O+ygg52PIQiWANL8HujuilX/IklZioqj6FH+YBMvJ84=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Okwy2rVmDPzlTnuwl9z/NzpJwmZ4nnKKmFk94ixsMKkCYXWMQklzokJ/jh5bsbvoSDnfTVVw8Jo9GrUuMJNX4879lsetJfH/cIyosKicPF+ymruCR0FG9nBz7YC+w8v0en5p+2xQD7oEDr7SdjUD00rzD7fV+tovkSxab/BTEpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zizFNKF2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fo53kI+G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250813162823.972744605@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755102561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=McYOjH3pRC85xYVfVYL6bZ0T+rBBg/9+RCapZBZZnk0=;
	b=zizFNKF2dSVrMoEtWGzrIM10AfMnqW5OYTsmTFgTvafffWaOXJGlUod94lhB04ACe3VZ76
	O5DkEip0ethgFhZtC5eZFifjBmUxovQ/se+5Bkghj2BwjQHNXNSxsB9+/tmGsXrv56OYIz
	n6c/e1ONhFJ6RHTL9dJ8xHM2KVuuJKNeU8pJfZFjQf0uW9Ky28mAAX1CklTAprmuHvXIHO
	vApG/+HCV5HSNHgNm5Qf+6nEcmSqwjJDYSEORcKahZjZzl557WdoNWWNtw9LlfyZJVv2cn
	uBUxK22qYciSxKsXBzKa1xczAvI36GxvjyZlQ0SAJRRWiy3wbeGX4Mo7/4TwOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755102561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=McYOjH3pRC85xYVfVYL6bZ0T+rBBg/9+RCapZBZZnk0=;
	b=fo53kI+G78MaaWDw8Z4NIYq0/OowuT6lAA/itDQ8GWkIwSWXUwn397U1rlC1lru2muHiFr
	/jrDp5MBD6xad5DQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Wei Liu <wei.liu@kernel.org>,
 Jens Axboe <axboe@kernel.dk>
Subject: [patch 03/11] rseq: Rename rseq_syscall() to
 rseq_debug_syscall_exit()
References: <20250813155941.014821755@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 18:29:19 +0200 (CEST)

rseq_syscall() is a debug function, which is invoked before the syscall
exit work is handled. Name it so it's clear what it does.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/entry-common.h |    2 +-
 include/linux/rseq.h         |    4 ++--
 kernel/rseq.c                |    5 +++--
 3 files changed, 6 insertions(+), 5 deletions(-)

--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -162,7 +162,7 @@ static __always_inline void syscall_exit
 			local_irq_enable();
 	}
 
-	rseq_syscall(regs);
+	rseq_debug_syscall_exit(regs);
 
 	/*
 	 * Do one-time syscall specific work. If these work items are
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -113,9 +113,9 @@ static inline void rseq_exit_to_user_mod
 #endif  /* !CONFIG_RSEQ */
 
 #ifdef CONFIG_DEBUG_RSEQ
-void rseq_syscall(struct pt_regs *regs);
+void rseq_debug_syscall_exit(struct pt_regs *regs);
 #else /* CONFIG_DEBUG_RSEQ */
-static inline void rseq_syscall(struct pt_regs *regs) { }
+static inline void rseq_debug_syscall_exit(struct pt_regs *regs) { }
 #endif /* !CONFIG_DEBUG_RSEQ */
 
 #endif /* _LINUX_RSEQ_H */
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -427,7 +427,8 @@ void __rseq_handle_notify_resume(struct
 	 * this invocation was invoked inside a critical section, then it
 	 * will either end up in this code again or a possible violation of
 	 * a syscall inside a critical region can only be detected by the
-	 * debug code in rseq_syscall() in a debug enabled kernel.
+	 * debug code in rseq_debug_syscall_exit() in a debug enabled
+	 * kernel.
 	 */
 	if (regs) {
 		/*
@@ -476,7 +477,7 @@ void __rseq_handle_notify_resume(struct
  * Terminate the process if a syscall is issued within a restartable
  * sequence.
  */
-void rseq_syscall(struct pt_regs *regs)
+void rseq_debug_syscall_exit(struct pt_regs *regs)
 {
 	unsigned long ip = instruction_pointer(regs);
 	struct task_struct *t = current;


