Return-Path: <linux-kernel+bounces-801738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED342B44971
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C30B189F823
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1352E2E9ECD;
	Thu,  4 Sep 2025 22:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JFgrqhSR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3MLuI6hE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62F92E8DE9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024442; cv=none; b=F4IhLcNJsE4aKfpZlqOHIjdl58IpQI9xsgORv2TQz9s8/e93UcoPtODlxNHxH65iX6ZG5OrQZl0JTWwx6EgHMh10JMFxhOyIXJmAgHPy52gmOX8ucl1oMLTYaDoDAWCxOzEFlomTO1AN3WRPMjNtQe+b+TVWgMgQaPtfAOD//Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024442; c=relaxed/simple;
	bh=mLGmoy+8sQC4ByUNI23jaaR+os/SUOAVMkc9Uv/+ixc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=XWdthsmJAGnOQlmz6O0TyUga/FdvkNxJODm30OJccvPKIMn6Ubq33/xwz6I3Ng6gCGmO58ZAMxWbKYnzQy2A0NBEljcida6HNVjSiIFFURncVniiazHdtPVGGJG7ZiVnXG+F1SMfSiPlmzg1UoVVlPEfSGAoWb9ARmdee6jb6ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JFgrqhSR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3MLuI6hE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250904185719.261280930@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757024438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=B7vLQ2oonr5UpS/A0J8VoSxOKB10lfCLowOJpVJzgfY=;
	b=JFgrqhSRfuqZApQY6YMLIOW+vL1p/cE4wyt+GBpRUhGDgbOEfT2mYCnzVlHx0GFEze4l1I
	PYe4lyvmKOe5BYeibHqJGh3Z1XfKBN8NIZcDB94SEW1gyh0PyOdJ1VIlMRMtE2MZC9tzet
	CFlIc1YGDY1FhpU3HLD77ZLcAoxODc06/sIxy7A9s8siORMI0w3z8QrX969rD5S7E8UB/u
	CO+mk8y0LvSpR47a3hUb3M2NLlldoMTw0rBuyF+JAVKILlCbCTQeN5qymPTOH8BvF4Vd/k
	sMt4XD9UiBUkc/QCMII7ApMmlbAxX665Gt1gvkjmToS5VuOcbVtbK9EW4k08aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757024438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=B7vLQ2oonr5UpS/A0J8VoSxOKB10lfCLowOJpVJzgfY=;
	b=3MLuI6hEX4nWwwYc+VHpgap14HqcCbZSGK/UCr7NG1RkgOdXfQMGrzeK0T2uPosXTl0ZJM
	irul0oLbbw2lT0Cg==
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
Subject: [patch V3 02/37] rseq: Condense the inline stubs
References: <20250904185336.943880027@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  5 Sep 2025 00:20:37 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

Scrolling over tons of pointless

{
}

lines to find the actual code is annoying at best.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>


---
 include/linux/rseq.h |   47 ++++++++++++-----------------------------------
 1 file changed, 12 insertions(+), 35 deletions(-)
---

--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -101,44 +101,21 @@ static inline void rseq_execve(struct ta
 	t->rseq_event_mask = 0;
 }
 
-#else
-
-static inline void rseq_set_notify_resume(struct task_struct *t)
-{
-}
-static inline void rseq_handle_notify_resume(struct ksignal *ksig,
-					     struct pt_regs *regs)
-{
-}
-static inline void rseq_signal_deliver(struct ksignal *ksig,
-				       struct pt_regs *regs)
-{
-}
-static inline void rseq_preempt(struct task_struct *t)
-{
-}
-static inline void rseq_migrate(struct task_struct *t)
-{
-}
-static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
-{
-}
-static inline void rseq_execve(struct task_struct *t)
-{
-}
+#else /* CONFIG_RSEQ */
+static inline void rseq_set_notify_resume(struct task_struct *t) { }
+static inline void rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs) { }
+static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs) { }
+static inline void rseq_preempt(struct task_struct *t) { }
+static inline void rseq_migrate(struct task_struct *t) { }
+static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags) { }
+static inline void rseq_execve(struct task_struct *t) { }
 static inline void rseq_exit_to_user_mode(void) { }
-#endif
+#endif  /* !CONFIG_RSEQ */
 
 #ifdef CONFIG_DEBUG_RSEQ
-
 void rseq_syscall(struct pt_regs *regs);
-
-#else
-
-static inline void rseq_syscall(struct pt_regs *regs)
-{
-}
-
-#endif
+#else /* CONFIG_DEBUG_RSEQ */
+static inline void rseq_syscall(struct pt_regs *regs) { }
+#endif /* !CONFIG_DEBUG_RSEQ */
 
 #endif /* _LINUX_RSEQ_H */



