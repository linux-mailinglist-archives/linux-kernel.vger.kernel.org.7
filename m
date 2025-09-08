Return-Path: <linux-kernel+bounces-806804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A42B49C06
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA224E7FBC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AECE30B534;
	Mon,  8 Sep 2025 21:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Iul5XWsC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4nuWCfjG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1CD303A27
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367119; cv=none; b=mRwG0aLk0Rq9Hie0So/VCRW04mP/naaHtVpXJ6BdrZrN0XHI7cmDG6xXZmd/Va9tazCbuxglCrzLeCyB3vY4vmuFZWHtilJYef/Y3gj26Ro2xZsXfMhgzpRUQqNZHVWE8/BImbOl533PaJUM20AtP/Ih6VBxhF9LB/LVh5dUK4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367119; c=relaxed/simple;
	bh=ErdK34fBtKD5KonMjP1X9krQsI8oNg8EieHf+pWu8rM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=YbGnWsj9OsqS28d9SwYBZpb/QAx9CLcYx+UH8wiFrmPKRYaYFZCSKfZcQqFCYj/Hyf1zOmYFctShLjoXIeU5ZrVAMHnZuan3PlIAr9tjqSlaD3SqfckmaA4bzZBkMpjWCfBGNlrqY9smBiaCX8EwhIUp1/j+gWCW/Qky4srHcOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Iul5XWsC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4nuWCfjG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908212926.225746125@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757367116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=f/lTKzIpIJEAOvGcLDPNZ55Ime02CxqPWulY5ZadACQ=;
	b=Iul5XWsCEjl4+fb2yA10xP4+Hx0GOqB/NSAosxbsYpnPIJ6z3h8GSv5//mbQLX/nFN/QKd
	KKeDD0apU/KkwuZFuQwCzcH1zyDchvSNTdE4jDWlQ7kFvykyOXm9rzV58TMAhA70bINkCC
	VtkDoCJuEqCAWusOdiohZwMgtQI3NlkKyFuN2LqJAl4sYxcEcFKlHuiVj6qvo+LPWDp1Op
	pCMYLvXZ1bxOQCiinkG34YaIZmPT+l3O+L/b1IJOK2+NwdtaomP59A1h636BWse6yRlLyC
	LBb/U2j2kR6+8gqnKtBF6FEXEcW0ZaZkHeoOAMykUPFWTiNIEv2upY42WG+btQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757367116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=f/lTKzIpIJEAOvGcLDPNZ55Ime02CxqPWulY5ZadACQ=;
	b=4nuWCfjG4CfdYKDL+kSDF00/EDkhZ6N764KUFjeWQUF41he9yBdIRzPzZHSjjsozfATFPH
	fNjj4qOi+AOI7iCg==
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
Subject: [patch V4 15/36] rseq: Record interrupt from user space
References: <20250908212737.353775467@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  8 Sep 2025 23:31:55 +0200 (CEST)

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
 


