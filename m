Return-Path: <linux-kernel+bounces-801745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5F1B4497C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729265A21B2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3374F2F28F5;
	Thu,  4 Sep 2025 22:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nIpXpB1S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6LU8uE33"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12372EACF8
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024455; cv=none; b=YHCaCAAFa3HuNC6k203oxlea9IDiv3/nUuutADwLqEDqb0D+5QbpgfEwMVG0f5hK8DMIaowPnkO3oTHXXONEFXp75+9acj4fv/E1B/49oaBAWvvnVO5M/QuSkN7/bS9D3n6nEdo9FXUg9v7+I5i+tJE12kVJLDZHi3d328RWYRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024455; c=relaxed/simple;
	bh=B/JsU/fykU6QQwkt4xSyRyvbLicSKBqa82fttrYAX8g=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=d6OqqLNJUiCAjFicWA0/zXGymhvDe+sxOdk2zucup/XQpWjvyP60cMDp4VIqEzKMfHBrQjLFZg7M2JuTjZWEtNbbWWR8vRFWM2US2x02YZPlnrXv70xoi5ukedGiPexLJdsF44k49IsKoo06h8/cVaMcVsmA1IG+9C+ogdIQClA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nIpXpB1S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6LU8uE33; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250904185719.712792803@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757024451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=zpMI59K2CzaimADZL0uMf3KBLaAEukUsDrQaaskMXS4=;
	b=nIpXpB1S/1LxthvwjdH5iFeBoPSpm5PTCtbYWHsNYtGEnhLkRoUw7R4QtJvyil15LNj/yJ
	pNonAxqlZH4y7pYB+x3F1urePBker8OVObDdJ18GykBTgPq9s61u2cXNBzKz0kPWb7kjdh
	yhSrdSCFHGKa64KYXgAyLX/J6pI39lAva/4h8+/DXZRIq0TS9VNEEJH77Oivr7+9QZc5cG
	IsYi0J0XUHpxB4YcHiZM9lxZlz6t3U2iyg/Yw6hEZ1mXVW/EN4367RLCuttyKGv8O4cjJ2
	618FR514qaMdyqUkNse33g5GM74gX/oNXewQsd/r9miObd7JE4MjRHNtbgnSIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757024451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=zpMI59K2CzaimADZL0uMf3KBLaAEukUsDrQaaskMXS4=;
	b=6LU8uE33KVR5Tk9rdySityufIpVoD+3S0A3CMj8umczwI2Bkw9ZwDFHgLSy11Kl6iHQ6lO
	MA16wcrZweppSIAw==
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
Subject: [patch V3 09/37] rseq: Introduce struct rseq_event
References: <20250904185336.943880027@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  5 Sep 2025 00:20:50 +0200 (CEST)

In preparation for a major rewrite of this code, provide a data structure
for event management.

Put the sched_switch event and a indicator for RSEQ on a task into it as a
start. That uses a union, which allows to mask and clear the whole lot
efficiently.

The indicators are explicitly not a bit field. Bit fields generate abysmal
code.

The boolean members are defined as u8 as that actually guarantees that it
fits. There seem to be strange architecture ABIs which need more than 8 bits
for a boolean.

The has_rseq member is redundant vs. task::rseq, but it turns out that
boolean operations and quick checks on the union generate better code than
fiddling with separate entities and data types.

This struct will be extended over time to carry more information.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 include/linux/rseq.h       |   23 ++++++++++++-----------
 include/linux/rseq_types.h |   30 ++++++++++++++++++++++++++++++
 include/linux/sched.h      |    7 ++-----
 kernel/rseq.c              |    6 ++++--
 4 files changed, 48 insertions(+), 18 deletions(-)

--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -9,22 +9,22 @@ void __rseq_handle_notify_resume(struct
 
 static inline void rseq_handle_notify_resume(struct pt_regs *regs)
 {
-	if (current->rseq)
+	if (current->rseq_event.has_rseq)
 		__rseq_handle_notify_resume(NULL, regs);
 }
 
 static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs)
 {
-	if (current->rseq) {
-		current->rseq_event_pending = true;
+	if (current->rseq_event.has_rseq) {
+		current->rseq_event.sched_switch = true;
 		__rseq_handle_notify_resume(ksig, regs);
 	}
 }
 
 static inline void rseq_sched_switch_event(struct task_struct *t)
 {
-	if (t->rseq) {
-		t->rseq_event_pending = true;
+	if (t->rseq_event.has_rseq) {
+		t->rseq_event.sched_switch = true;
 		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
 	}
 }
@@ -32,8 +32,9 @@ static inline void rseq_sched_switch_eve
 static __always_inline void rseq_exit_to_user_mode(void)
 {
 	if (IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
-		if (WARN_ON_ONCE(current->rseq && current->rseq_event_pending))
-			current->rseq_event_pending = false;
+		if (WARN_ON_ONCE(current->rseq_event.has_rseq &&
+				 current->rseq_event.events))
+			current->rseq_event.events = 0;
 	}
 }
 
@@ -49,7 +50,7 @@ static __always_inline void rseq_exit_to
  */
 static inline void rseq_virt_userspace_exit(void)
 {
-	if (current->rseq_event_pending)
+	if (current->rseq_event.sched_switch)
 		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
 }
 
@@ -63,12 +64,12 @@ static inline void rseq_fork(struct task
 		t->rseq = NULL;
 		t->rseq_len = 0;
 		t->rseq_sig = 0;
-		t->rseq_event_pending = false;
+		t->rseq_event.all = 0;
 	} else {
 		t->rseq = current->rseq;
 		t->rseq_len = current->rseq_len;
 		t->rseq_sig = current->rseq_sig;
-		t->rseq_event_pending = current->rseq_event_pending;
+		t->rseq_event = current->rseq_event;
 	}
 }
 
@@ -77,7 +78,7 @@ static inline void rseq_execve(struct ta
 	t->rseq = NULL;
 	t->rseq_len = 0;
 	t->rseq_sig = 0;
-	t->rseq_event_pending = false;
+	t->rseq_event.all = 0;
 }
 
 #else /* CONFIG_RSEQ */
--- /dev/null
+++ b/include/linux/rseq_types.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_RSEQ_TYPES_H
+#define _LINUX_RSEQ_TYPES_H
+
+#include <linux/types.h>
+
+/*
+ * struct rseq_event - Storage for rseq related event management
+ * @all:		Compound to initialize and clear the data efficiently
+ * @events:		Compound to access events with a single load/store
+ * @sched_switch:	True if the task was scheduled out
+ * @has_rseq:		True if the task has a rseq pointer installed
+ */
+struct rseq_event {
+	union {
+		u32				all;
+		struct {
+			union {
+				u16		events;
+				struct {
+					u8	sched_switch;
+				};
+			};
+
+			u8			has_rseq;
+		};
+	};
+};
+
+#endif
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -41,6 +41,7 @@
 #include <linux/task_io_accounting.h>
 #include <linux/posix-timers_types.h>
 #include <linux/restart_block.h>
+#include <linux/rseq_types.h>
 #include <uapi/linux/rseq.h>
 #include <linux/seqlock_types.h>
 #include <linux/kcsan.h>
@@ -1404,11 +1405,7 @@ struct task_struct {
 	struct rseq __user		*rseq;
 	u32				rseq_len;
 	u32				rseq_sig;
-	/*
-	 * RmW on rseq_event_pending must be performed atomically
-	 * with respect to preemption.
-	 */
-	bool				rseq_event_pending;
+	struct rseq_event		rseq_event;
 # ifdef CONFIG_DEBUG_RSEQ
 	/*
 	 * This is a place holder to save a copy of the rseq fields for
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -460,8 +460,8 @@ void __rseq_handle_notify_resume(struct
 	 * inconsistencies.
 	 */
 	scoped_guard(RSEQ_EVENT_GUARD) {
-		event = t->rseq_event_pending;
-		t->rseq_event_pending = false;
+		event = t->rseq_event.sched_switch;
+		t->rseq_event.sched_switch = false;
 	}
 
 	if (!IS_ENABLED(CONFIG_DEBUG_RSEQ) && !event)
@@ -523,6 +523,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
 		current->rseq = NULL;
 		current->rseq_sig = 0;
 		current->rseq_len = 0;
+		current->rseq_event.all = 0;
 		return 0;
 	}
 
@@ -595,6 +596,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
 	 * registered, ensure the cpu_id_start and cpu_id fields
 	 * are updated before returning to user-space.
 	 */
+	current->rseq_event.has_rseq = true;
 	rseq_sched_switch_event(current);
 
 	return 0;


