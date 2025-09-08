Return-Path: <linux-kernel+bounces-806798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FDCB49C00
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4FCA7B542E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3893B2DF6F7;
	Mon,  8 Sep 2025 21:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="34ZmMKdY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9dZw9tOI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F1C2E9EB5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367108; cv=none; b=SigcrrhQTgE786Hpc96MkTxOsy2mYOGwu2k/9n7upJwsP7Nft9aFl4aTOkYqqJi7Ac6hvuSbwf3BFyCL9D02ZSg0vwdSq8A4p4L4hvnKO6DUMqMCJgM7qucPJNSeB+ZIFCdMOjtaOA4NvVkhW6KOGx32Xpcj+3MifMp9ZI2PuIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367108; c=relaxed/simple;
	bh=TcjF9wUqX8sDoEnJo1lQUT4nlC/+n9UGYIPoCG/SsXE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Cd2dW5CEDRo2D3Zi2AHE+K7uVvTJ9pWIt53ZzK4pmH9ijTgjF67LKY5Q35LeO+a1gPUN+tAe1LGMdfzDv18fzITpfRd7NK9KNL3j7GVC2T97gLoySGCCKQB3xT3n79CALVPHjhabGzLVc4j1HpnGzSokEbjcJ56UNzww5QsI9bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=34ZmMKdY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9dZw9tOI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908212925.841373090@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757367104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=HT40kZklFfYP6mwW9DtgXf2414urJmnKniN/xawKXsw=;
	b=34ZmMKdYAPQopsLhe4MrCDAfXXJ4cC1fpkJtyisjjs9vrXBHq+Bn6D+gl7P+skpmQqUDW4
	dhSpH2mqP4zGPn4GNPAKKp7wlvov8Mv1GpS1ZGR0RfgbRhSc/Wv2Jo+Gy36LfR/JgzpBZK
	BvCstY+/1/BK7ljfCGHyP3Wmx1uUi3aUEhPqf7grtcnDe8oKRiaOz3yPCD1qkG5XdkByzP
	inYZeOqt/4TOjW/41Lx76w/bwucZ7j8c/yVUtXXEixcj0eAAp20mIq/6Q7EDoe2eNtDH6g
	sU65aXndXIPsDcLF+DQZCO4KKrRt7uf0CCvC1sdoN5x9mqAYrfS3yPs/wott1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757367104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=HT40kZklFfYP6mwW9DtgXf2414urJmnKniN/xawKXsw=;
	b=9dZw9tOI781fkfZ3wSzhSZsJcuC9hBjD3U5ogcpU+nsB37zbqgu9xvJ86iRZr4yEi0hckK
	pmlngfTBrGf9/gDQ==
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
Subject: [patch V4 09/36] rseq: Introduce struct rseq_data
References: <20250908212737.353775467@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  8 Sep 2025 23:31:43 +0200 (CEST)

In preparation for a major rewrite of this code, provide a data structure
for rseq management.

Put all the rseq related data into it (except for the debug part), which
allows to simplify fork/execve by using memset() and memcpy() instead of
adding new fields to initialize over and over.

Create a storage struct for event management as well and put the
sched_switch event and a indicator for RSEQ on a task into it as a
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
V4: Move all rseq related data into a dedicated umbrella struct
---
 include/linux/rseq.h       |   48 +++++++++++++++-------------------
 include/linux/rseq_types.h |   51 ++++++++++++++++++++++++++++++++++++
 include/linux/sched.h      |   14 ++--------
 kernel/ptrace.c            |    6 ++--
 kernel/rseq.c              |   63 ++++++++++++++++++++++-----------------------
 5 files changed, 110 insertions(+), 72 deletions(-)

--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -9,22 +9,22 @@ void __rseq_handle_notify_resume(struct
 
 static inline void rseq_handle_notify_resume(struct pt_regs *regs)
 {
-	if (current->rseq)
+	if (current->rseq.event.has_rseq)
 		__rseq_handle_notify_resume(NULL, regs);
 }
 
 static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs)
 {
-	if (current->rseq) {
-		current->rseq_event_pending = true;
+	if (current->rseq.event.has_rseq) {
+		current->rseq.event.sched_switch = true;
 		__rseq_handle_notify_resume(ksig, regs);
 	}
 }
 
 static inline void rseq_sched_switch_event(struct task_struct *t)
 {
-	if (t->rseq) {
-		t->rseq_event_pending = true;
+	if (t->rseq.event.has_rseq) {
+		t->rseq.event.sched_switch = true;
 		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
 	}
 }
@@ -32,8 +32,9 @@ static inline void rseq_sched_switch_eve
 static __always_inline void rseq_exit_to_user_mode(void)
 {
 	if (IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
-		if (WARN_ON_ONCE(current->rseq && current->rseq_event_pending))
-			current->rseq_event_pending = false;
+		if (WARN_ON_ONCE(current->rseq.event.has_rseq &&
+				 current->rseq.event.events))
+			current->rseq.event.events = 0;
 	}
 }
 
@@ -49,35 +50,30 @@ static __always_inline void rseq_exit_to
  */
 static inline void rseq_virt_userspace_exit(void)
 {
-	if (current->rseq_event_pending)
+	if (current->rseq.event.sched_switch)
 		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
 }
 
+static inline void rseq_reset(struct task_struct *t)
+{
+	memset(&t->rseq, 0, sizeof(t->rseq));
+}
+
+static inline void rseq_execve(struct task_struct *t)
+{
+	rseq_reset(t);
+}
+
 /*
  * If parent process has a registered restartable sequences area, the
  * child inherits. Unregister rseq for a clone with CLONE_VM set.
  */
 static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
 {
-	if (clone_flags & CLONE_VM) {
-		t->rseq = NULL;
-		t->rseq_len = 0;
-		t->rseq_sig = 0;
-		t->rseq_event_pending = false;
-	} else {
+	if (clone_flags & CLONE_VM)
+		rseq_reset(t);
+	else
 		t->rseq = current->rseq;
-		t->rseq_len = current->rseq_len;
-		t->rseq_sig = current->rseq_sig;
-		t->rseq_event_pending = current->rseq_event_pending;
-	}
-}
-
-static inline void rseq_execve(struct task_struct *t)
-{
-	t->rseq = NULL;
-	t->rseq_len = 0;
-	t->rseq_sig = 0;
-	t->rseq_event_pending = false;
 }
 
 #else /* CONFIG_RSEQ */
--- /dev/null
+++ b/include/linux/rseq_types.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_RSEQ_TYPES_H
+#define _LINUX_RSEQ_TYPES_H
+
+#include <linux/types.h>
+
+#ifdef CONFIG_RSEQ
+struct rseq;
+
+/**
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
+/**
+ * struct rseq_data - Storage for all rseq related data
+ * @usrptr:	Pointer to the registered user space RSEQ memory
+ * @len:	Length of the RSEQ region
+ * @sig:	Signature of critial section abort IPs
+ * @event:	Storage for event management
+ */
+struct rseq_data {
+	struct rseq __user		*usrptr;
+	u32				len;
+	u32				sig;
+	struct rseq_event		event;
+};
+
+#else /* CONFIG_RSEQ */
+struct rseq_data { };
+#endif /* !CONFIG_RSEQ */
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
@@ -1400,16 +1401,8 @@ struct task_struct {
 	unsigned long			numa_pages_migrated;
 #endif /* CONFIG_NUMA_BALANCING */
 
-#ifdef CONFIG_RSEQ
-	struct rseq __user		*rseq;
-	u32				rseq_len;
-	u32				rseq_sig;
-	/*
-	 * RmW on rseq_event_pending must be performed atomically
-	 * with respect to preemption.
-	 */
-	bool				rseq_event_pending;
-# ifdef CONFIG_DEBUG_RSEQ
+	struct rseq_data		rseq;
+#ifdef CONFIG_DEBUG_RSEQ
 	/*
 	 * This is a place holder to save a copy of the rseq fields for
 	 * validation of read-only fields. The struct rseq has a
@@ -1417,7 +1410,6 @@ struct task_struct {
 	 * directly. Reserve a size large enough for the known fields.
 	 */
 	char				rseq_fields[sizeof(struct rseq)];
-# endif
 #endif
 
 #ifdef CONFIG_SCHED_MM_CID
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -793,9 +793,9 @@ static long ptrace_get_rseq_configuratio
 					  unsigned long size, void __user *data)
 {
 	struct ptrace_rseq_configuration conf = {
-		.rseq_abi_pointer = (u64)(uintptr_t)task->rseq,
-		.rseq_abi_size = task->rseq_len,
-		.signature = task->rseq_sig,
+		.rseq_abi_pointer = (u64)(uintptr_t)task->rseq.usrptr,
+		.rseq_abi_size = task->rseq.len,
+		.signature = task->rseq.sig,
 		.flags = 0,
 	};
 
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -103,13 +103,13 @@ static int rseq_validate_ro_fields(struc
 				      DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
 	u32 cpu_id_start, cpu_id, node_id, mm_cid;
-	struct rseq __user *rseq = t->rseq;
+	struct rseq __user *rseq = t->rseq.usrptr;
 
 	/*
 	 * Validate fields which are required to be read-only by
 	 * user-space.
 	 */
-	if (!user_read_access_begin(rseq, t->rseq_len))
+	if (!user_read_access_begin(rseq, t->rseq.len))
 		goto efault;
 	unsafe_get_user(cpu_id_start, &rseq->cpu_id_start, efault_end);
 	unsafe_get_user(cpu_id, &rseq->cpu_id, efault_end);
@@ -147,10 +147,10 @@ static int rseq_validate_ro_fields(struc
  * Update an rseq field and its in-kernel copy in lock-step to keep a coherent
  * state.
  */
-#define rseq_unsafe_put_user(t, value, field, error_label)		\
-	do {								\
-		unsafe_put_user(value, &t->rseq->field, error_label);	\
-		rseq_kernel_fields(t)->field = value;			\
+#define rseq_unsafe_put_user(t, value, field, error_label)			\
+	do {									\
+		unsafe_put_user(value, &t->rseq.usrptr->field, error_label);	\
+		rseq_kernel_fields(t)->field = value;				\
 	} while (0)
 
 #else
@@ -160,12 +160,12 @@ static int rseq_validate_ro_fields(struc
 }
 
 #define rseq_unsafe_put_user(t, value, field, error_label)		\
-	unsafe_put_user(value, &t->rseq->field, error_label)
+	unsafe_put_user(value, &t->rseq.usrptr->field, error_label)
 #endif
 
 static int rseq_update_cpu_node_id(struct task_struct *t)
 {
-	struct rseq __user *rseq = t->rseq;
+	struct rseq __user *rseq = t->rseq.usrptr;
 	u32 cpu_id = raw_smp_processor_id();
 	u32 node_id = cpu_to_node(cpu_id);
 	u32 mm_cid = task_mm_cid(t);
@@ -176,7 +176,7 @@ static int rseq_update_cpu_node_id(struc
 	if (rseq_validate_ro_fields(t))
 		goto efault;
 	WARN_ON_ONCE((int) mm_cid < 0);
-	if (!user_write_access_begin(rseq, t->rseq_len))
+	if (!user_write_access_begin(rseq, t->rseq.len))
 		goto efault;
 
 	rseq_unsafe_put_user(t, cpu_id, cpu_id_start, efault_end);
@@ -201,7 +201,7 @@ static int rseq_update_cpu_node_id(struc
 
 static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 {
-	struct rseq __user *rseq = t->rseq;
+	struct rseq __user *rseq = t->rseq.usrptr;
 	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED, node_id = 0,
 	    mm_cid = 0;
 
@@ -211,7 +211,7 @@ static int rseq_reset_rseq_cpu_node_id(s
 	if (rseq_validate_ro_fields(t))
 		goto efault;
 
-	if (!user_write_access_begin(rseq, t->rseq_len))
+	if (!user_write_access_begin(rseq, t->rseq.len))
 		goto efault;
 
 	/*
@@ -272,7 +272,7 @@ static int rseq_get_rseq_cs(struct task_
 	u32 sig;
 	int ret;
 
-	ret = rseq_get_rseq_cs_ptr_val(t->rseq, &ptr);
+	ret = rseq_get_rseq_cs_ptr_val(t->rseq.usrptr, &ptr);
 	if (ret)
 		return ret;
 
@@ -305,10 +305,10 @@ static int rseq_get_rseq_cs(struct task_
 	if (ret)
 		return ret;
 
-	if (current->rseq_sig != sig) {
+	if (current->rseq.sig != sig) {
 		printk_ratelimited(KERN_WARNING
 			"Possible attack attempt. Unexpected rseq signature 0x%x, expecting 0x%x (pid=%d, addr=%p).\n",
-			sig, current->rseq_sig, current->pid, usig);
+			sig, current->rseq.sig, current->pid, usig);
 		return -EINVAL;
 	}
 	return 0;
@@ -338,7 +338,7 @@ static int rseq_check_flags(struct task_
 		return -EINVAL;
 
 	/* Get thread flags. */
-	ret = get_user(flags, &t->rseq->flags);
+	ret = get_user(flags, &t->rseq.usrptr->flags);
 	if (ret)
 		return ret;
 
@@ -392,13 +392,13 @@ static int rseq_ip_fixup(struct pt_regs
 	 * Clear the rseq_cs pointer and return.
 	 */
 	if (!in_rseq_cs(ip, &rseq_cs))
-		return clear_rseq_cs(t->rseq);
+		return clear_rseq_cs(t->rseq.usrptr);
 	ret = rseq_check_flags(t, rseq_cs.flags);
 	if (ret < 0)
 		return ret;
 	if (!abort)
 		return 0;
-	ret = clear_rseq_cs(t->rseq);
+	ret = clear_rseq_cs(t->rseq.usrptr);
 	if (ret)
 		return ret;
 	trace_rseq_ip_fixup(ip, rseq_cs.start_ip, rseq_cs.post_commit_offset,
@@ -460,8 +460,8 @@ void __rseq_handle_notify_resume(struct
 	 * inconsistencies.
 	 */
 	scoped_guard(RSEQ_EVENT_GUARD) {
-		event = t->rseq_event_pending;
-		t->rseq_event_pending = false;
+		event = t->rseq.event.sched_switch;
+		t->rseq.event.sched_switch = false;
 	}
 
 	if (!IS_ENABLED(CONFIG_DEBUG_RSEQ) && !event)
@@ -492,7 +492,7 @@ void rseq_syscall(struct pt_regs *regs)
 	struct task_struct *t = current;
 	struct rseq_cs rseq_cs;
 
-	if (!t->rseq)
+	if (!t->rseq.usrptr)
 		return;
 	if (rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs))
 		force_sig(SIGSEGV);
@@ -511,33 +511,31 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
 		if (flags & ~RSEQ_FLAG_UNREGISTER)
 			return -EINVAL;
 		/* Unregister rseq for current thread. */
-		if (current->rseq != rseq || !current->rseq)
+		if (current->rseq.usrptr != rseq || !current->rseq.usrptr)
 			return -EINVAL;
-		if (rseq_len != current->rseq_len)
+		if (rseq_len != current->rseq.len)
 			return -EINVAL;
-		if (current->rseq_sig != sig)
+		if (current->rseq.sig != sig)
 			return -EPERM;
 		ret = rseq_reset_rseq_cpu_node_id(current);
 		if (ret)
 			return ret;
-		current->rseq = NULL;
-		current->rseq_sig = 0;
-		current->rseq_len = 0;
+		rseq_reset(current);
 		return 0;
 	}
 
 	if (unlikely(flags))
 		return -EINVAL;
 
-	if (current->rseq) {
+	if (current->rseq.usrptr) {
 		/*
 		 * If rseq is already registered, check whether
 		 * the provided address differs from the prior
 		 * one.
 		 */
-		if (current->rseq != rseq || rseq_len != current->rseq_len)
+		if (current->rseq.usrptr != rseq || rseq_len != current->rseq.len)
 			return -EINVAL;
-		if (current->rseq_sig != sig)
+		if (current->rseq.sig != sig)
 			return -EPERM;
 		/* Already registered. */
 		return -EBUSY;
@@ -586,15 +584,16 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
 	 * Activate the registration by setting the rseq area address, length
 	 * and signature in the task struct.
 	 */
-	current->rseq = rseq;
-	current->rseq_len = rseq_len;
-	current->rseq_sig = sig;
+	current->rseq.usrptr = rseq;
+	current->rseq.len = rseq_len;
+	current->rseq.sig = sig;
 
 	/*
 	 * If rseq was previously inactive, and has just been
 	 * registered, ensure the cpu_id_start and cpu_id fields
 	 * are updated before returning to user-space.
 	 */
+	current->rseq.event.has_rseq = true;
 	rseq_sched_switch_event(current);
 
 	return 0;


