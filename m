Return-Path: <linux-kernel+bounces-864980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FF7BFC017
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6EF620E4B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A0534B689;
	Wed, 22 Oct 2025 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nz2epJMg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0fs2lI2f"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B3334B1A9
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137546; cv=none; b=gDsA1Q96PcvqK/N1dISyPRxIMZ0YyZUpcHema+CyAX2zoixG4ZQKr9ZcftwInhvu23ejBu0VpYyhI//nX+4v6Yts46Xs4QIVAPsJyhgMUwyDfFtrfxkSjkJD1B0ixRxzi0uWRISid3inP/2eGp9AEPyqwt+pwz/0eE+zn2Sz3bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137546; c=relaxed/simple;
	bh=mG/mijf3e8GCdPwtQiR1y4Srp7ryeFZjC90xvNQFqc4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=XIMbux/PqaXJCbTHGacClMU5elJk14eOnauuXce/r3jKumt1dRmacGTneJYuLsfNCICQ/NcD9VYwhkugaz0t5Ow4OQgyDOxHVWp3Q9Jyd8WM8NOwOVtxnQ5DiwcM3x/wXnNM3w4MJUOhkrzqrpySu2GK6N6ZTT2x6wuY08VkkPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nz2epJMg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0fs2lI2f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022121942.345885910@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=+aYqb4c1BNKTCmuXaTNh2fE6SLohTIVuFq1wCdsgTkU=;
	b=nz2epJMgpO/95Fyu60n3qfbIPXkJOENbG5CKHnrDG4cx66mhutRYvLC+lDcOXU5rvmyHWc
	Z3GYHN6Ywv7+QIEAT6Iy824fGcnnqPMRPLBGO6z3GBEU9Ggnywb3Dh23M1UjzP5PFH3/SW
	MC/EIrtGqu85oBx6pEIiGX0DL/TCeqjq9kvy4Peskv6BRql6EWrExK6aNWLfheMXtQCyLw
	NfUAjo01bOdAgyVL3xSI4Mr/wMnm+HQjhgfPjW3HKQU9qxFWmAK725dfKl2PqvR4+tBM1w
	M6ufJWPLfpwAONsrSfN4qhxqJR73pWaIya1BekPPhvfqXJ9B9XmRfXwBU4s8DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=+aYqb4c1BNKTCmuXaTNh2fE6SLohTIVuFq1wCdsgTkU=;
	b=0fs2lI2fdbtzWOau30ndJHkv3xIslRP0JcrSUdFCAe/yrFUUaldn9Xx6pX+wfE38mkWInE
	puas0HmRLNFvlIDg==
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
Subject: [patch V5 15/31] rseq: Record interrupt from user space
References: <20251022121836.019469732@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:52:19 +0200 (CEST)

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
 




