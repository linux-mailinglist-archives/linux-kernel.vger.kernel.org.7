Return-Path: <linux-kernel+bounces-864987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611E1BFC032
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB2A5E55E4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689B934CFAF;
	Wed, 22 Oct 2025 12:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WY3TfmLU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KoKBY9hz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC703491CB
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137558; cv=none; b=I2uxcBS0n1VL+u++txUanqz64U8vAzOQWkXLM+XN6v2+OEHBbocQiWiLQwPXpKjunyXtHii7eqE2l+ntk5Eovr/+WkwXUn2eFcgKz949hxllj6KH2m9tb1K8dPZzZYvKkvDJoyv1WBOL4sLDLIAhXTVq1ypLvqsnkespCEHre/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137558; c=relaxed/simple;
	bh=bPbzRdKi9rgjvSjUDEAF6P/eZSUApyAMpjWvEgf2IEE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=LfNwzv7fFKsdDgTGyXGc9V0q8TO3OS3UZX7wr6F9rVTE57ovHlf1IrNoudrZn3ylxbwjPNWhUTP1alAAYKfF5NuIxmO/JT08XkSqyN3v2QHhAsxu1du0oXSZNLO8+k+s/ps33MW7jDdLRDy3IhavnoIDxZfrAyumyP94in8lJgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WY3TfmLU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KoKBY9hz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022121942.786322453@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=oi2tDgCN5RQeyHe3kWjPPl5jVL1zsw6ax8RUhiC9WMA=;
	b=WY3TfmLUXRajglwa3XlTPzmDeFDD8Frvug2kzHwO+Wy7LstnntM2Vw1MlAi0gPcASUvmhx
	LtO1NTeDREaKHzQ2a7JL6wedszlzvkU9wkNohCB+kDoWzDZ3UMi8mpeVxcAisrlT1TEJg/
	oWiVOqMS4G7qZCvlrInck7k8lEN2u+zLw7pCbwEirzcz7xDT0IrPr6w3bpeVSfvZa2XYuL
	wVTKzjlXjnbvmSZRPq6MaCw9vmAHGFI7RmbNME60uweKUDmasaXJuLid60ESnaM5Yu68/A
	YigKrIYCQq7L76oYj2Vs43hSqu+LTVqz/rQWbmuUqKfDK3SiAsJ0/m6w1wG29Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=oi2tDgCN5RQeyHe3kWjPPl5jVL1zsw6ax8RUhiC9WMA=;
	b=KoKBY9hzx0FVsRHE6btqeWZgBVU+iVivFe15W210PzXRl46gMpauN9gmoOVAVpkMmd0P80
	mGLwCIzD5vL8jgDQ==
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
Subject: [patch V5 22/31] rseq: Use static branch for syscall exit debug when
 GENERIC_IRQ_ENTRY=y
References: <20251022121836.019469732@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:52:28 +0200 (CEST)

Make the syscall exit debug mechanism available via the static branch on
architectures which utilize the generic entry code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

---
 include/linux/entry-common.h |    2 +-
 include/linux/rseq_entry.h   |    9 +++++++++
 kernel/rseq.c                |   10 ++++++++--
 3 files changed, 18 insertions(+), 3 deletions(-)
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -146,7 +146,7 @@ static __always_inline void syscall_exit
 			local_irq_enable();
 	}
 
-	rseq_syscall(regs);
+	rseq_debug_syscall_return(regs);
 
 	/*
 	 * Do one-time syscall specific work. If these work items are
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -296,9 +296,18 @@ static __always_inline void rseq_exit_to
 	ev->events = 0;
 }
 
+void __rseq_debug_syscall_return(struct pt_regs *regs);
+
+static inline void rseq_debug_syscall_return(struct pt_regs *regs)
+{
+	if (static_branch_unlikely(&rseq_debug_enabled))
+		__rseq_debug_syscall_return(regs);
+}
+
 #else /* CONFIG_RSEQ */
 static inline void rseq_note_user_irq_entry(void) { }
 static inline void rseq_exit_to_user_mode(void) { }
+static inline void rseq_debug_syscall_return(struct pt_regs *regs) { }
 #endif /* !CONFIG_RSEQ */
 
 #endif /* _LINUX_RSEQ_ENTRY_H */
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -473,12 +473,11 @@ void __rseq_handle_notify_resume(struct
 	force_sigsegv(sig);
 }
 
-#ifdef CONFIG_DEBUG_RSEQ
 /*
  * Terminate the process if a syscall is issued within a restartable
  * sequence.
  */
-void rseq_syscall(struct pt_regs *regs)
+void __rseq_debug_syscall_return(struct pt_regs *regs)
 {
 	struct task_struct *t = current;
 	u64 csaddr;
@@ -496,6 +495,13 @@ void rseq_syscall(struct pt_regs *regs)
 fail:
 	force_sig(SIGSEGV);
 }
+
+#ifdef CONFIG_DEBUG_RSEQ
+/* Kept around to keep GENERIC_ENTRY=n architectures supported. */
+void rseq_syscall(struct pt_regs *regs)
+{
+	__rseq_debug_syscall_return(regs);
+}
 #endif
 
 /*


