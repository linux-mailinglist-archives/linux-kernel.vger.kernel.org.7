Return-Path: <linux-kernel+bounces-871090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 005A5C0C715
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F45D401485
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A313F30E85F;
	Mon, 27 Oct 2025 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yM9NhHVu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nt6ecdxR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9B130DEA0
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554665; cv=none; b=RkZDrQr0sQpjiBEozUJgZKVN/sQUCN2EVcaZDZg1zpoE1u08VTUNziANbGdbwKkgS2UlMS7xCA2ZHx+YaC8BkC9kLoMzt1N7Rff+TI39Bfxr1a7NcuKcH6m3BwUMaLSC5BNwGpY4cuNpEECJgezyAX8p2jyvjBySxo0qUoE9KOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554665; c=relaxed/simple;
	bh=8lzjY6YlJ932iRievx3IRBGtJrp7aRUMI+C8bgmdaGw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=fx/2hxro3fQF1Ri+bZknDMr9XCVqqv6d1wgvJn+r7MX0iiGJ7FyQNPOxfOb17nD88mX29gvrg2zGdeNfC7F818/BBiluJxz2bz5zPDShpzOmTp9Jb4DG0HteaSb+LQH+zkLxgmxFQ0kLHZGHvWWCuXGAYa1hyD6aQF96AyPsZFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yM9NhHVu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nt6ecdxR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251027084306.149519580@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761554661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=M/1Ul6W9ursLNumrrGapkMgfrRi7zwPJZgpAY0HcHII=;
	b=yM9NhHVuog9kheqpErLlxXwxq5JZbEmgLCy8LUPROB2l9eOsotetStR0siej3ZyxVs2k3T
	X59QBOpU4QARXdT0R1gnmCegQfsY2ZVNih6DExsZ6wsl19bwVgE5fGLw5c2EGURX2neSGb
	EKt7nMX65/fUqR0L0N33f7jbyexu/wUSY/SApoWAg63LmNlFbMjeWHlZ4vPtsB7GPOMaAG
	Hm9fhvsNCZVwPuJ18+3Crlw+j6OH5TrMEqe0eGEBsBAfX+4cDMRTUknbcqqV21BVYiLFhu
	gjSM3/6p4CCXa0j+pXqEEo0CeGIsCTv/NxUObTht738wSW7lcDDJ3vuQbEZJ+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761554661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=M/1Ul6W9ursLNumrrGapkMgfrRi7zwPJZgpAY0HcHII=;
	b=nt6ecdxRwD1Ip/5eAAMvHAECaJ0OMFnILOY0fK99erjlpXjqKct3k0ecWPqwN5iXk3u7NT
	19ANRqiIy0jPTTBw==
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
Subject: [patch V6 03/31] rseq: Move algorithm comment to top
References: <20251027084220.785525188@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Oct 2025 09:44:20 +0100 (CET)

Move the comment which documents the RSEQ algorithm to the top of the file,
so it does not create horrible diffs later when the actual implementation
is fed into the mincer.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

---
 kernel/rseq.c |  119 ++++++++++++++++++++++++++++------------------------------
 1 file changed, 59 insertions(+), 60 deletions(-)
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -8,6 +8,65 @@
  * Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  */
 
+/*
+ * Restartable sequences are a lightweight interface that allows
+ * user-level code to be executed atomically relative to scheduler
+ * preemption and signal delivery. Typically used for implementing
+ * per-cpu operations.
+ *
+ * It allows user-space to perform update operations on per-cpu data
+ * without requiring heavy-weight atomic operations.
+ *
+ * Detailed algorithm of rseq user-space assembly sequences:
+ *
+ *                     init(rseq_cs)
+ *                     cpu = TLS->rseq::cpu_id_start
+ *   [1]               TLS->rseq::rseq_cs = rseq_cs
+ *   [start_ip]        ----------------------------
+ *   [2]               if (cpu != TLS->rseq::cpu_id)
+ *                             goto abort_ip;
+ *   [3]               <last_instruction_in_cs>
+ *   [post_commit_ip]  ----------------------------
+ *
+ *   The address of jump target abort_ip must be outside the critical
+ *   region, i.e.:
+ *
+ *     [abort_ip] < [start_ip]  || [abort_ip] >= [post_commit_ip]
+ *
+ *   Steps [2]-[3] (inclusive) need to be a sequence of instructions in
+ *   userspace that can handle being interrupted between any of those
+ *   instructions, and then resumed to the abort_ip.
+ *
+ *   1.  Userspace stores the address of the struct rseq_cs assembly
+ *       block descriptor into the rseq_cs field of the registered
+ *       struct rseq TLS area. This update is performed through a single
+ *       store within the inline assembly instruction sequence.
+ *       [start_ip]
+ *
+ *   2.  Userspace tests to check whether the current cpu_id field match
+ *       the cpu number loaded before start_ip, branching to abort_ip
+ *       in case of a mismatch.
+ *
+ *       If the sequence is preempted or interrupted by a signal
+ *       at or after start_ip and before post_commit_ip, then the kernel
+ *       clears TLS->__rseq_abi::rseq_cs, and sets the user-space return
+ *       ip to abort_ip before returning to user-space, so the preempted
+ *       execution resumes at abort_ip.
+ *
+ *   3.  Userspace critical section final instruction before
+ *       post_commit_ip is the commit. The critical section is
+ *       self-terminating.
+ *       [post_commit_ip]
+ *
+ *   4.  <success>
+ *
+ *   On failure at [2], or if interrupted by preempt or signal delivery
+ *   between [1] and [3]:
+ *
+ *       [abort_ip]
+ *   F1. <failure>
+ */
+
 #include <linux/sched.h>
 #include <linux/uaccess.h>
 #include <linux/syscalls.h>
@@ -98,66 +157,6 @@ static int rseq_validate_ro_fields(struc
 	unsafe_put_user(value, &t->rseq->field, error_label)
 #endif
 
-/*
- *
- * Restartable sequences are a lightweight interface that allows
- * user-level code to be executed atomically relative to scheduler
- * preemption and signal delivery. Typically used for implementing
- * per-cpu operations.
- *
- * It allows user-space to perform update operations on per-cpu data
- * without requiring heavy-weight atomic operations.
- *
- * Detailed algorithm of rseq user-space assembly sequences:
- *
- *                     init(rseq_cs)
- *                     cpu = TLS->rseq::cpu_id_start
- *   [1]               TLS->rseq::rseq_cs = rseq_cs
- *   [start_ip]        ----------------------------
- *   [2]               if (cpu != TLS->rseq::cpu_id)
- *                             goto abort_ip;
- *   [3]               <last_instruction_in_cs>
- *   [post_commit_ip]  ----------------------------
- *
- *   The address of jump target abort_ip must be outside the critical
- *   region, i.e.:
- *
- *     [abort_ip] < [start_ip]  || [abort_ip] >= [post_commit_ip]
- *
- *   Steps [2]-[3] (inclusive) need to be a sequence of instructions in
- *   userspace that can handle being interrupted between any of those
- *   instructions, and then resumed to the abort_ip.
- *
- *   1.  Userspace stores the address of the struct rseq_cs assembly
- *       block descriptor into the rseq_cs field of the registered
- *       struct rseq TLS area. This update is performed through a single
- *       store within the inline assembly instruction sequence.
- *       [start_ip]
- *
- *   2.  Userspace tests to check whether the current cpu_id field match
- *       the cpu number loaded before start_ip, branching to abort_ip
- *       in case of a mismatch.
- *
- *       If the sequence is preempted or interrupted by a signal
- *       at or after start_ip and before post_commit_ip, then the kernel
- *       clears TLS->__rseq_abi::rseq_cs, and sets the user-space return
- *       ip to abort_ip before returning to user-space, so the preempted
- *       execution resumes at abort_ip.
- *
- *   3.  Userspace critical section final instruction before
- *       post_commit_ip is the commit. The critical section is
- *       self-terminating.
- *       [post_commit_ip]
- *
- *   4.  <success>
- *
- *   On failure at [2], or if interrupted by preempt or signal delivery
- *   between [1] and [3]:
- *
- *       [abort_ip]
- *   F1. <failure>
- */
-
 static int rseq_update_cpu_node_id(struct task_struct *t)
 {
 	struct rseq __user *rseq = t->rseq;


