Return-Path: <linux-kernel+bounces-783252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFF1B32AF9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDE961C200E1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD742F0C6D;
	Sat, 23 Aug 2025 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JlVmszf6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BH9vQR+Q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1F82F0C50
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755967206; cv=none; b=a5OXhnsi7dY9eU04aopEGSSDvig6RJJig60iQNQLQmnXLNCNwqHzhVssHVFjqoZ53fKfCePd2SxVfg/b3riZv/iPAoXoRwCHvs+ajloMYeceGctoxl+IIVVIoM+9J1touLygWGSuCS99v/kd4P+I/ZQEpljToUoGuVbHtlsRBNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755967206; c=relaxed/simple;
	bh=aHyYhrngWqwek+zL2LXHM/m7IygoiX4dvSyBLnV+pro=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=lXBmVYaufN+Otzy2SZMc1StPNq+7kc/ZXnlDXGaB9rU4QSxgpkFGoAEeNV7np4UGvvEs70XoqGh70c7IkHp7REk80QLjdmWhOt9ofHEew7CxiuiIoifZGnYMrZZDMYlVXwY0UVIX53to4K1CeD3OBhu9w+PD2r/re3oRqZi1L0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JlVmszf6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BH9vQR+Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250823161654.677961303@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755967202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=w6iXRrtymKNRLhlRnwTuItMwaWaIGSiBnDPpk0Weh9Q=;
	b=JlVmszf6zuLa558wwGwXfsGer34qAWJgk4Io4gI4Hi7UQHBaySGe7ETrrzvPeD3tV22SOw
	9aQMn7iLlyTBMzB4t9Wl+WiW8XrLAQmNBx/8jkygSYHpbs2xwdfC16/QLAEPzQA/0xPTUO
	QG9tUVGpIv3nDqo1BKJz0ytFoHZ0IonotzgD2KbtiLjs1SH0Yw1XsZUj1KQ/xia5j0tmGu
	sQkKs9MDeOO3NRfmWeAdfKAL1pnxkHv+aFyKCXV5xRneybb1T574STRPspaxx/+aME59lt
	KxpQzSk1Ddri4SGXC+cjnDlcgNp3NTZg9eaNRlJOQo4CorE/U6JoDTseFOYHfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755967202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=w6iXRrtymKNRLhlRnwTuItMwaWaIGSiBnDPpk0Weh9Q=;
	b=BH9vQR+Qa4g0mmwNxUL2Axhqar7ElTUzcJmwtQoKv5dlRRO9dq4RqjAhCJzqKh+khhjw1V
	tblihcYN0GmnkGDw==
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
Subject: [patch V2 22/37] rseq: Use static branch for syscall exit debug when
 GENERIC_IRQ_ENTRY=y
References: <20250823161326.635281786@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 18:40:01 +0200 (CEST)

Make the syscall exit debug mechanism available via the static branch on
architectures which utilize the generic entry code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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


