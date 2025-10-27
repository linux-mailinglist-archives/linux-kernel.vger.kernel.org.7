Return-Path: <linux-kernel+bounces-871110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB5FC0C77B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F408404800
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B792F312834;
	Mon, 27 Oct 2025 08:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pEvomM0S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rky9C62P"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BB03128A9
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554711; cv=none; b=H26weZO78WKC1IzLppxYdfj8fPmJVNVqvwGBt2afWx8+ja23lWMsHTCAJSYRGHTKWfafg22aP3Xg3uj6G/BKKohrE+zrKLChgzplkLzvz8AXQ756aggXixWzXs+IeyAtYggVUJOa9V9m70on1rWM44m21ulu8W+ifnOel7vQe24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554711; c=relaxed/simple;
	bh=bPbzRdKi9rgjvSjUDEAF6P/eZSUApyAMpjWvEgf2IEE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Kc79dVKqW4F1/EtdhnX5wB4cT7XUYUMZ5P/Z+3freF3VOvx055lqgDlrp1oymFwM1SVdcFETwthXOc65NLVxZxesN58PbMU1gP0PdiUhCPViVqvTUhFie4MawrjecNfJlPQQDpl0Ye61b3kGX2qifsZFl8p3oUx++Rc/EgdU93I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pEvomM0S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rky9C62P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251027084307.333440475@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761554706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=oi2tDgCN5RQeyHe3kWjPPl5jVL1zsw6ax8RUhiC9WMA=;
	b=pEvomM0SuIMQ6js/40L9WTfBU79auvCOi8md4uWEQHb50Id9eV4S7VGNtvnLBm4hrZUlCb
	xF2vcc0tWiST4vM+Se9rKuZsHa/Xq5OMDNX5FeM/daVPIamgyQXdjL7k/QPFx981epD4MN
	r2g4vJ8KGTmt2CJs0oBrk3svNHBcQyB1PqqObbJNFA9SO3K3wVctDRsOtKDSUcuhYJ+P2y
	BAs9seX+0Iv3y3ciVNK89T0nilnFzzi777FbGiCtdCKLoq6x+BJcjSa9S5s8eektRT38mZ
	fytOEZtvHdH8e3dEnz+bUvK/TFerKpe6Pcr+w22NU7B3cJc7wx3orZOxSSVtsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761554706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=oi2tDgCN5RQeyHe3kWjPPl5jVL1zsw6ax8RUhiC9WMA=;
	b=Rky9C62Pg5//lMpgPey+qiCRrsdLjRYf6tS6x+pWAgaf/4622vWDSfJXlSlVM3EDibxfC2
	exFQ6sgoN8MTLdDA==
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
Subject: [patch V6 22/31] rseq: Use static branch for syscall exit debug when
 GENERIC_IRQ_ENTRY=y
References: <20251027084220.785525188@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Oct 2025 09:45:05 +0100 (CET)

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


