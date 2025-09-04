Return-Path: <linux-kernel+bounces-801758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C06EFB4498A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498A21889535
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F84335BA5;
	Thu,  4 Sep 2025 22:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vJW6sf5Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vRtaB/I1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58632E9EA8
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024479; cv=none; b=XaxR5YekyEzVjfjQZyx2sHIHj853Fs/6D9WaBen11iT2QaEtcGKRLxZjnqAoDS7qbXdlm0b6EumuclHeWCJuSbMTLb6BR9ctiPQUaioLVFWf95mpyhA+C9r8/+Dnc4SKLSg7nAI3B9rwiBavIUA2p0TXb4tI0cnL1EKtGS3pvHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024479; c=relaxed/simple;
	bh=e8g7UdBhqrXKfk2gzjboAafceUj4gAwYFSFlErrzvSc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=dpRANsXJQP4d648K9J58TDhu593Pcu+VJ5wCtlkqTBbiVwpMqbwrphVhhpTd5nd+x11kG8ls7XYPJloYEsGWPWR8U1YZhEUlKbMinGpU99yFVuJoq6kwLmOnysxagAPPBg+e9SFDAIwicUvQ+uqt6BsfrYE/LGUR1JNMqeSaUAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vJW6sf5Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vRtaB/I1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250904185720.526220243@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757024476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=NSKUyyV86FuSpvpTInpZTwVe/DTQioaMYANjUCDRIuI=;
	b=vJW6sf5ZhUxG2vKeh5BLIfJWaLcnMScLLSaFTz1HImYch0cYszI1YF/neVmIx75BEtjJCN
	0vCRneG8I8ACRk61w3XBQm1URkNJFsxp8vzPe7FiEzVK+JHkMWBxvH+dnE1IM7CF7peUL2
	cMsGuJMUk4z/MD0vCCMR8skuIEVedhIxon0SB8MWJkiS7lsB7YxSfS0A2clEPwOChCU9JX
	MnJgvPj612eqNHFXTAPJVuKFlEn1aNCQGOA1cv1gdAZkeJDZVnrG95zK/UKrvKXMcgleTY
	OB7COTScd7VQuSyqHdussowTlW7qYbTEg9fT86eY5ZdbUHywvJ35atXdrnbaCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757024476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=NSKUyyV86FuSpvpTInpZTwVe/DTQioaMYANjUCDRIuI=;
	b=vRtaB/I1dmxdu5BVpTzhiVVfiox6Vx3fx6GC0zxuu+ikaFVrVmBWeu9hFoYjusJu9mAlkr
	JRJaYM4f74j9iMBQ==
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
Subject: [patch V3 22/37] rseq: Use static branch for syscall exit debug when
 GENERIC_IRQ_ENTRY=y
References: <20250904185336.943880027@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  5 Sep 2025 00:21:15 +0200 (CEST)

Make the syscall exit debug mechanism available via the static branch on
architectures which utilize the generic entry code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

---
 include/linux/entry-common.h |    2 +-
 include/linux/rseq_entry.h   |    9 +++++++++
 kernel/rseq.c                |   19 +++++++++++++------
 3 files changed, 23 insertions(+), 7 deletions(-)

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
@@ -286,9 +286,18 @@ static __always_inline void rseq_exit_to
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
@@ -470,12 +470,7 @@ void __rseq_handle_notify_resume(struct
 	force_sigsegv(sig);
 }
 
-#ifdef CONFIG_DEBUG_RSEQ
-/*
- * Terminate the process if a syscall is issued within a restartable
- * sequence.
- */
-void rseq_syscall(struct pt_regs *regs)
+void __rseq_debug_syscall_return(struct pt_regs *regs)
 {
 	struct task_struct *t = current;
 	u64 csaddr;
@@ -493,6 +488,18 @@ void rseq_syscall(struct pt_regs *regs)
 fail:
 	force_sig(SIGSEGV);
 }
+
+#ifdef CONFIG_DEBUG_RSEQ
+/*
+ * Kept around to keep GENERIC_ENTRY=n architectures supported.
+ *
+ * Terminate the process if a syscall is issued within a restartable
+ * sequence.
+ */
+void rseq_syscall(struct pt_regs *regs)
+{
+	__rseq_debug_syscall_return(regs);
+}
 #endif
 
 /*




