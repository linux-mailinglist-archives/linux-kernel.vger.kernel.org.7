Return-Path: <linux-kernel+bounces-783232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D5EB32AE7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B3B1BC78E5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB062E7BCD;
	Sat, 23 Aug 2025 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D7KXtvxb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gQdrW4xv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE88825D204
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755967154; cv=none; b=rm0bwBVKJNcksCFAn/1kbY7ICmnjPUmYAuUSekl4Dtrf5lNa3KYYjPeFZBeMVCOoxNN0DRjKPeos95N58OVydVLlOlw1+7BBst4ZEXvKUBC2hEuRVza3E0gHKc5ziPV8DHI8zFQImeHgYJO705Zh5t7lNUbQfZL7SgvAssFBzgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755967154; c=relaxed/simple;
	bh=HGCpG59G/OHWP2Db6yF1AhuivKTVORyZGDlxLPrBp5Q=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=IM5vvGFXB+cBIrVNH90MyMazL/iJZe9+xrPLOik+lw+bTBG9PMeXP4NhpFu/hdgXGBCDDCKSnuVvwtOazVlhwt7fU3azEeMQv1HIxBsxKw4CJ3ZInVSSxI85L+ObqU54x9tmhztvvO1eHPq05WE/FxeyjDFNmOnTh14StpEqRh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D7KXtvxb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gQdrW4xv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250823161653.387469844@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755967150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=TLyiqO9fhXUolGppUl/GktUryjsQJl4FtcKZ3sesbW8=;
	b=D7KXtvxbKzsbJ/cvGeDcZb7vczgI1afBKZtLXmysUPjcZInnVzP4SklnTFiCY7u+L/D9AL
	1yAXd/SrJfR1xjBJ3iIIfD567jAsttgYAfitSj50x+ZbDVDwj8wWB8o9TZbn9KMJGMC0Yn
	fnfFPOzXXiYWEuiQTfYdyUxj4ZxI0sSnSK3s6ACDGzpXKtzY2Hv29yBWfXZyLTU4MU+G04
	sMS4kyaOzjlDK0judKxfy+GQ6IcecAorcnM2HK3g2eCAwTTMPsbnGgAx+kZdZVjU0kWmL3
	bfTAMxehLlNtSO/plCKwTfP+xUZ4t92VmzxUog7eur3ftikchc4oLASYH3f94g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755967150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=TLyiqO9fhXUolGppUl/GktUryjsQJl4FtcKZ3sesbW8=;
	b=gQdrW4xv5LOz1MHyrEUPR6DAV8e9ovX/HTCYm9SLQfvDwWmLACr8HuFfiQlX/XOpsKMHW3
	DIhYLL9UiqMYRHDw==
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
Subject: [patch V2 02/37] rseq: Condense the inline stubs
References: <20250823161326.635281786@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 18:39:09 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

Scrolling over tons of pointless

{
}

lines to find the actual code is annoying at best.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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


