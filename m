Return-Path: <linux-kernel+bounces-871102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ADACBC0C745
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 898224F2000
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60E231076C;
	Mon, 27 Oct 2025 08:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ph2DhUsx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dtBK5t3A"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FDC2F1FD5
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554692; cv=none; b=Kyoy8ma/bSSdwNO2zS/KrAMhZb9ESmKf9lMC+3itV6o3JWaAMb3S0kcWXJVNZQgfpOectV42HeIjQwnvshiFO45mno33W0EeZ4dW5+4n2eEx8h5EvROEi3ODHR7qUiODc5yg1SsnjGi249m22Khc6nMR292VYNgs+qpfxitc4G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554692; c=relaxed/simple;
	bh=SuhYVgyFQ4LoQjTWH6EJ7e/oahDD9nGT5aZupiSYXzc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=q0qTQzRs7ORmwDTzkHENd+75+E3tPzaoBRScgvTM8pyITm1s4UH8B6BBON11xBcM4b8sSpCMEMckxBGfEhFdPMf8mvoWEIR65suoYBhbAqJ6MbexcdwAdOEEIt0wdic93axD5iVRzY1mETf31qWuu8xu+qLorl6xr2sPaL7/DZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ph2DhUsx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dtBK5t3A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251027084306.905067101@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761554689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=+aYqb4c1BNKTCmuXaTNh2fE6SLohTIVuFq1wCdsgTkU=;
	b=Ph2DhUsxw4lWN4UzXPN7d5UZO0c40FD4eaSDKn3YunLn8gYXmMlIwLQV3UIEnHLD8p9rXr
	xcf8NiY/LP57em0uyE/wGVxC0hG5Rvb28Hn04nlPxIo4k09//NKUS+VscskGrSyCrYGjql
	mbWMGbyIDjD/2d3hg8HX/x/0kvVF6nnDh3v/WQi+0hzApD1DIKVB6hjZu2lHf6cdSos/1x
	9qqOfAx62rfkSYPLX49GTSF4ILi7T6C7zeLFKuI29JEIveNCRCGexZ9xm9GMtNuWT0vvoM
	CqjM+INGcXxSW2Lr3r3GQqdZ3V1unl9CZU4Tneve+/DD9VPD7wsry0NPiV3gpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761554689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=+aYqb4c1BNKTCmuXaTNh2fE6SLohTIVuFq1wCdsgTkU=;
	b=dtBK5t3A104CTbVIqBAJYUHDeATLZmqQbBne8F28Zao7zBzXMJa71bBJz63ZKcDiAy3T0h
	qqeqTQo3CTc922DQ==
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
Subject: [patch V6 15/31] rseq: Record interrupt from user space
References: <20251027084220.785525188@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Oct 2025 09:44:48 +0100 (CET)

For RSEQ the only relevant reason to inspect and eventually fixup (abort)
user space critical sections is when user space was interrupted and the
task was scheduled out.

If the user to kernel entry was from a syscall no fixup is required. If
user space invokes a syscall from a critical section it can keep the
pieces as documented.

This is only supported on architectures which utilize the generic entry
code. If your architecture does not use it, bad luck.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
-		if (WARN_ON_ONCE(current->rseq.event.has_rseq &&
-				 current->rseq.event.events))
-			current->rseq.event.events = 0;
-	}
+	struct rseq_event *ev = &current->rseq.event;
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
+		current->rseq.event.user_irq = true;
+}
+
+#else /* CONFIG_RSEQ */
+static inline void rseq_note_user_irq_entry(void) { }
+#endif /* !CONFIG_RSEQ */
+
+#endif /* _LINUX_RSEQ_ENTRY_H */
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -12,6 +12,7 @@ struct rseq;
  * @all:		Compound to initialize and clear the data efficiently
  * @events:		Compound to access events with a single load/store
  * @sched_switch:	True if the task was scheduled out
+ * @user_irq:		True on interrupt entry from user mode
  * @has_rseq:		True if the task has a rseq pointer installed
  */
 struct rseq_event {
@@ -22,6 +23,7 @@ struct rseq_event {
 				u16		events;
 				struct {
 					u8	sched_switch;
+					u8	user_irq;
 				};
 			};
 




