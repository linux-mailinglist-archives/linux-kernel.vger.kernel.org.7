Return-Path: <linux-kernel+bounces-783250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9664DB32AF6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0A71C20482
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891822F068A;
	Sat, 23 Aug 2025 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1OwiNDf3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5U5uDl7G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F722F0C50
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755967200; cv=none; b=svkn3wbJpxf7e4fhq/EBac+bNma7MUYw7ux4geXMYrJMTEpSXPPiGXq4miT87V78fOTxZ11ftyKauSSYKfl9NveMYuy9Kayq0J5PrMZPpbwNbgJ/sW3Tsdpg7QvxaIg0i3ozA8yJ+ZB5EUN87Xvbr3gQ1a4qrLFaU9/zbJLkICY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755967200; c=relaxed/simple;
	bh=jxWfc4ZGF7gMUH+9j9atldUYMU8wuTOf7zgFXjl82tc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Uz8jWn7kJBR6yFH6JIWnOoEop9joVx8AT5PdV+z2ZNJScxP6QHPOJqhHIVthHzR8D00Ns2jUSul+XfUSTaH2XK6IlMdFLzL6ZZXfEd07v3Vmz97WHZ7CHc+8VuvSCfURgahsagyc6YwLR3JS/PJRvJ2u7wKS5+F5aX3RqR9VgiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1OwiNDf3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5U5uDl7G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250823161654.547589855@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755967197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=rq8NUAnUcbySGYLgiYD+HlneHsCvVdZ5Dsg0Eo8YCp4=;
	b=1OwiNDf3Slrb38P5fclYHsVg2ljS9fO7udIQcwUeTU7+4wx2kqOcRlvxE8XRR2T9hPCLhl
	79e2XyAnhxf8t9SAmLH9aMi6VWIUPJW5NDQZ3vlLAqLEto5t9JIe/Un4X6evYIGiqCp7gF
	DLdiJi7yT/2WZVZDl/bnqx5i5UgCNYXpmZ+4BxohXAUquY8hYv149dsUG7lAfCofUJiMl6
	Sz+h2jwaRuN6INRg1nHIYnKDci3kM/y+QGDnyQhvklDc6r1apeRz0YMv4NUgJoIqBxutUY
	WjvxTFxHA7eheqoF143WNuH1Zpamn3XrV1BzPSxcFQij6ay8MaCe8AP+B37kxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755967197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=rq8NUAnUcbySGYLgiYD+HlneHsCvVdZ5Dsg0Eo8YCp4=;
	b=5U5uDl7G8XP7f2QUEaQaD8Pe922doZJIG48oLdUAgh0lsMuMn06Wdg1OYAw2kmJ9V7HcVN
	hhOAwhp6bxrsv6AA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
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
Subject: [patch V2 20/37] rseq: Replace the debug crud
References: <20250823161326.635281786@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 18:39:56 +0200 (CEST)

Just utilize the new infrastructure and put the original one to rest.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/rseq.c |   80 ++++++++--------------------------------------------------
 1 file changed, 12 insertions(+), 68 deletions(-)

--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -472,83 +472,27 @@ void __rseq_handle_notify_resume(struct
 
 #ifdef CONFIG_DEBUG_RSEQ
 /*
- * Unsigned comparison will be true when ip >= start_ip, and when
- * ip < start_ip + post_commit_offset.
- */
-static bool in_rseq_cs(unsigned long ip, struct rseq_cs *rseq_cs)
-{
-	return ip - rseq_cs->start_ip < rseq_cs->post_commit_offset;
-}
-
-/*
- * If the rseq_cs field of 'struct rseq' contains a valid pointer to
- * user-space, copy 'struct rseq_cs' from user-space and validate its fields.
- */
-static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
-{
-	struct rseq_cs __user *urseq_cs;
-	u64 ptr;
-	u32 __user *usig;
-	u32 sig;
-	int ret;
-
-	if (get_user_masked_u64(&ptr, &t->rseq->rseq_cs))
-		return -EFAULT;
-
-	/* If the rseq_cs pointer is NULL, return a cleared struct rseq_cs. */
-	if (!ptr) {
-		memset(rseq_cs, 0, sizeof(*rseq_cs));
-		return 0;
-	}
-	/* Check that the pointer value fits in the user-space process space. */
-	if (ptr >= TASK_SIZE)
-		return -EINVAL;
-	urseq_cs = (struct rseq_cs __user *)(unsigned long)ptr;
-	if (copy_from_user(rseq_cs, urseq_cs, sizeof(*rseq_cs)))
-		return -EFAULT;
-
-	if (rseq_cs->start_ip >= TASK_SIZE ||
-	    rseq_cs->start_ip + rseq_cs->post_commit_offset >= TASK_SIZE ||
-	    rseq_cs->abort_ip >= TASK_SIZE ||
-	    rseq_cs->version > 0)
-		return -EINVAL;
-	/* Check for overflow. */
-	if (rseq_cs->start_ip + rseq_cs->post_commit_offset < rseq_cs->start_ip)
-		return -EINVAL;
-	/* Ensure that abort_ip is not in the critical section. */
-	if (rseq_cs->abort_ip - rseq_cs->start_ip < rseq_cs->post_commit_offset)
-		return -EINVAL;
-
-	usig = (u32 __user *)(unsigned long)(rseq_cs->abort_ip - sizeof(u32));
-	ret = get_user(sig, usig);
-	if (ret)
-		return ret;
-
-	if (current->rseq_sig != sig) {
-		printk_ratelimited(KERN_WARNING
-			"Possible attack attempt. Unexpected rseq signature 0x%x, expecting 0x%x (pid=%d, addr=%p).\n",
-			sig, current->rseq_sig, current->pid, usig);
-		return -EINVAL;
-	}
-	return 0;
-}
-
-/*
  * Terminate the process if a syscall is issued within a restartable
  * sequence.
  */
 void rseq_syscall(struct pt_regs *regs)
 {
-	unsigned long ip = instruction_pointer(regs);
 	struct task_struct *t = current;
-	struct rseq_cs rseq_cs;
+	u64 csaddr;
 
-	if (!t->rseq)
+	if (!t->rseq_event.has_rseq)
+		return;
+	if (get_user_masked_u64(&csaddr, &t->rseq->rseq_cs))
+		goto fail;
+	if (likely(!csaddr))
 		return;
-	if (rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs))
-		force_sig(SIGSEGV);
+	if (unlikely(csaddr >= TASK_SIZE))
+		goto fail;
+	if (rseq_debug_update_user_cs(t, regs, csaddr))
+		return;
+fail:
+	force_sig(SIGSEGV);
 }
-
 #endif
 
 /*


