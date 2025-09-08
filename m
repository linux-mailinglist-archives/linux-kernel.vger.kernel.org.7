Return-Path: <linux-kernel+bounces-806792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F684B49BF9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4A11B28413
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91102E0904;
	Mon,  8 Sep 2025 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y5Yl9rMM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oowg7Iz1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CDD2DFF13
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367095; cv=none; b=m/MlNvAKEsI7xihUnE4ZwY3rwD06VwAA1M1dKNGoA5Cj+mIx1YUUW/QdvViaQnfzQonezmzbdPea3jVn2vbE/LJodwO3NIxUlsp7dM4bjlyTMK06kYtK7qnc2N/4C8mSNjT2+bNeyUhTUF2I+YJatj/cBsrD/+eQ2a0wuJTDA/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367095; c=relaxed/simple;
	bh=1xSC5YtfTpwnmtwwGCFqEXBAHGQs7cR6itG5X0MRowQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Pc+z8Hi78HEg2EsFKC0O2tNJmKtXvupoF7b1qQT+8MiVHmOUT56hmcUqHhI4oSZx6Px/w4rAjGPoTpJtOV1FR7nGks2iIFP8hgm4SVMU86kV8w4p7mamhmk6E9uSB1mmMV8E1/HzKR6adi//1OUlQJ1w4xyN0psZYHpUf04J9zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y5Yl9rMM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oowg7Iz1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908212925.453479676@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757367091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=pdn4t/2ynllKNIsn5zTbArAyv3rBjQUvYlpSz4wte3Q=;
	b=y5Yl9rMMtgUX1JwEo+IJymT3xBupcIE8pO7EP7ZNgZrcvGptZ4UPP0iZqKlcVwa/GP2zd3
	OabR13G/P+p7sOhhWQDDZLpgJO1T/ci+ujloAynpQAaGm/9o6N2LKjiWnwYsU3j9/dJ6Uj
	9LwB+IMDaJTvUb1Qo2yXouqHgRpwjtK2OFQR77nX1yHbWIN/2ytwiL0W/18vCHqY4ZiGld
	cBg6fx9omiTN8RsX4ZfdrEGt1VTN05IzQTViFzm399xhetFdqaxAJ4N9iYT3QCtLT1Xfzf
	L9Fa+xXiLL5QJODuDSexcnYJaSEAsYqIwrDOjysk9JZTK0pZ486imFUeO26eMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757367091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=pdn4t/2ynllKNIsn5zTbArAyv3rBjQUvYlpSz4wte3Q=;
	b=oowg7Iz1f5dxI9it40MDqGVwHFfDL+65+DDYjrhYxeI0GdzpYf1MNrZEH/Cu0MkzNtHEWv
	AAg/E8go1ja/QoDg==
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
Subject: [patch V4 03/36] rseq: Move algorithm comment to top
References: <20250908212737.353775467@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  8 Sep 2025 23:31:30 +0200 (CEST)

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




