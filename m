Return-Path: <linux-kernel+bounces-801751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593E6B44984
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6EE580AB3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9779D2E8E0A;
	Thu,  4 Sep 2025 22:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EK5g/tB5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w69SAMsm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741C42F83A3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024466; cv=none; b=LpEVK/zJ8ZOxax2L1P2PUwcLMaNNJXDUzub4kycHu1mJhtBFxK8PLe5epslEVCBSaqlxHWUnNY9dnsP92tWfrfE5exaR6MHd2EBorPnTnLTtEnjoRWYKkXUgwMknAh747UcVi9j2MVHONK47tAVtNL9tTX4W4Qf7Q+lkDzLIH7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024466; c=relaxed/simple;
	bh=d+nPlo23jlJ3xhxt9gQtYafkI1GlBDoZlZK/ehufdIw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=JwzTJbhLW9/CqPXYy6Xvg7uDPs1aO7gQ5o80CG39WD+9ffTEjM7ju2hmrhh+nvIpehlN74x+Vh3IKxG0xc1BOAR1RLbqopefiOTXlSGmyyphFezXxJQPgGxZJ+pz45GXNnYiJ5uXgKtw0n+y/IFdXw7xDvfdoQOf+JYG7bUEPbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EK5g/tB5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w69SAMsm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250904185720.087689754@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757024462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=KA2d9h4jh4bj22uUQRFQsyaA2ITwuoGalkeKWc19FIg=;
	b=EK5g/tB5C0BPueoHSkssli5m5GO2qpKCkKXW8tgeQkZ9/0eQOGwIw5EOsj+wSrSC+YdWJm
	+22nS5TGqHdcKWCruGP9mt6VcNqu94zwQ9ED0yDna13nvoG3/XkStMxHnO/KxU7IymNGNI
	13dF5bXUt/v7Q4gqS3KuJZkDYC27gKH0X2wxHRHqv2wTPBKdH1PcbHkONOqxWQCkpXqRPN
	If7qEchZu46XBYKjBDqMdrrtE9YmyaVHZjJ9zzMaLo489tzeXJ6COULGJVn2oy2NPT+wVE
	spSvl2KOBL+JMt8ZgbSJUB8DS0DFaWLRpt+YLky4IFFDm4lmsci0iVXIJcL7UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757024462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=KA2d9h4jh4bj22uUQRFQsyaA2ITwuoGalkeKWc19FIg=;
	b=w69SAMsmpq/6HDqmwyiNHQxNdMVwh8xfgpTfommlZN3w5HLDe9f7ifU/Bgfi82AKmD1kYJ
	lriuMfpj03LgusDg==
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
Subject: [patch V3 15/37] rseq: Record interrupt from user space
References: <20250904185336.943880027@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  5 Sep 2025 00:21:02 +0200 (CEST)

For RSEQ the only relevant reason to inspect and eventually fixup (abort)
user space critical sections is when user space was interrupted and the
task was scheduled out.

If the user to kernel entry was from a syscall no fixup is required. If
user space invokes a syscall from a critical section it can keep the
pieces as documented.

This is only supported on architectures which utilize the generic entry
code. If your architecture does not use it, bad luck.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 include/linux/irq-entry-common.h |    3 ++-
 include/linux/rseq.h             |   16 +++++++++++-----
 include/linux/rseq_entry.h       |   18 ++++++++++++++++++
 include/linux/rseq_types.h       |    2 ++
 4 files changed, 33 insertions(+), 6 deletions(-)

--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -4,7 +4,7 @@
 
 #include <linux/context_tracking.h>
 #include <linux/kmsan.h>
-#include <linux/rseq.h>
+#include <linux/rseq_entry.h>
 #include <linux/static_call_types.h>
 #include <linux/syscalls.h>
 #include <linux/tick.h>
@@ -281,6 +281,7 @@ static __always_inline void exit_to_user
 static __always_inline void irqentry_enter_from_user_mode(struct pt_regs *regs)
 {
 	enter_from_user_mode(regs);
+	rseq_note_user_irq_entry();
 }
 
 /**
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -31,11 +31,17 @@ static inline void rseq_sched_switch_eve
 
 static __always_inline void rseq_exit_to_user_mode(void)
 {
-	if (IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
-		if (WARN_ON_ONCE(current->rseq_event.has_rseq &&
-				 current->rseq_event.events))
-			current->rseq_event.events = 0;
-	}
+	struct rseq_event *ev = &current->rseq_event;
+
+	if (IS_ENABLED(CONFIG_DEBUG_RSEQ))
+		WARN_ON_ONCE(ev->sched_switch);
+
+	/*
+	 * Ensure that event (especially user_irq) is cleared when the
+	 * interrupt did not result in a schedule and therefore the
+	 * rseq processing did not clear it.
+	 */
+	ev->events = 0;
 }
 
 /*
--- /dev/null
+++ b/include/linux/rseq_entry.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_RSEQ_ENTRY_H
+#define _LINUX_RSEQ_ENTRY_H
+
+#ifdef CONFIG_RSEQ
+#include <linux/rseq.h>
+
+static __always_inline void rseq_note_user_irq_entry(void)
+{
+	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY))
+		current->rseq_event.user_irq = true;
+}
+
+#else /* CONFIG_RSEQ */
+static inline void rseq_note_user_irq_entry(void) { }
+#endif /* !CONFIG_RSEQ */
+
+#endif /* _LINUX_RSEQ_ENTRY_H */
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -9,6 +9,7 @@
  * @all:		Compound to initialize and clear the data efficiently
  * @events:		Compound to access events with a single load/store
  * @sched_switch:	True if the task was scheduled out
+ * @user_irq:		True on interrupt entry from user mode
  * @has_rseq:		True if the task has a rseq pointer installed
  */
 struct rseq_event {
@@ -19,6 +20,7 @@ struct rseq_event {
 				u16		events;
 				struct {
 					u8	sched_switch;
+					u8	user_irq;
 				};
 			};
 


