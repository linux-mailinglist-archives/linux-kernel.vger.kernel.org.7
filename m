Return-Path: <linux-kernel+bounces-783264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAEBB32B06
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5FDB1890EF8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A8D2EBB9E;
	Sat, 23 Aug 2025 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aO+KRuzL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SHuvRO1X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D912F548A
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755967239; cv=none; b=NS9llMIgf6ipuJfH+JYo6KUCEalNWOL8hLyMlpvMTRrhCjzjZAB6JGb2VEBE/DlWrBtVaNv6LV03R/LBG9C1n8E3053VMvd6PGm0pIalZBW34Dyde5DugzOc1EFruA40TWYatiGLp1lbcPO/lR1W4W9OrQ721k3mduUREmBDtU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755967239; c=relaxed/simple;
	bh=6q7HEZLKfmTXbEmY9x/E2H4E9vXEkamTuN2cqF3N604=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=m83/tuBEsOlrnysRQqjP6gXo2/8vlQSY3psXcGJj66qXeFxp3BbyL8I9BtkzKlhYoACwcovPstaG14tXGNWnezuh/SgArRFXKehCJHs9MHEOYirWATu4O9JuMQEN+NGu1c9WxdUmeXzy52aD18fvLPVVO0zlouADOgeHbM3YK+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aO+KRuzL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SHuvRO1X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250823161655.449079233@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755967235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=+FYMDW4FdA8VymarwR6vPBcMwNS91wQ8ykWchiw/6OE=;
	b=aO+KRuzL7SUAiVrECWRk16dRmPDqoh7D0o3Nz9ruu+RaKK1DFzZ0j1hYNtRzy5ViOEbtwB
	XC2/x//H2Rr99Z07HAI877AzF7QJA080MFBNRU1CNef4NrAje0ezPbVp2Bgxwe0TFOBI1X
	R6mrpjqTq6UJOWIa0cEol+KSTZ/170ldbaK+PeO8fAyUBzZfPNiMKSLb4tiNTAOorY6kZj
	Z2SNxLdpKYZserYYLJ47bFubZpNFFZcUqaI0X2BSzw4JPgHePyrnbQh+wj7cfblG4HFW90
	zN1kp3IeSwJxRAgzM3JgVQPQL+8WucZKGtuk99RbhvgE5jAWWqGr3YZIoSKp7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755967235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=+FYMDW4FdA8VymarwR6vPBcMwNS91wQ8ykWchiw/6OE=;
	b=SHuvRO1Xl0GcTWp/IMDYy4za2kv7GlxfEwKzgbMGdlZvWa8znTU+9a9GsK3xVs2cCGj6bX
	08RHOc9/PAPUCKBQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
 Huacai Chen <chenhuacai@kernel.org>,
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
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [patch V2 34/37] loongarch: Use generic TIF bits
References: <20250823161326.635281786@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 18:40:33 +0200 (CEST)

No point in defining generic items and the upcoming RSEQ optimizations are
only available with this _and_ the generic entry infrastructure, which is
already used by loongarch. So no further action required here.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Huacai Chen <chenhuacai@kernel.org>
---
 arch/loongarch/Kconfig                   |    1 
 arch/loongarch/include/asm/thread_info.h |   76 +++++++++++++------------------
 2 files changed, 35 insertions(+), 42 deletions(-)

--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -140,6 +140,7 @@ config LOONGARCH
 	select HAVE_EBPF_JIT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if !ARCH_STRICT_ALIGN
 	select HAVE_EXIT_THREAD
+	select HAVE_GENERIC_TIF_BITS
 	select HAVE_GUP_FAST
 	select HAVE_FTRACE_GRAPH_FUNC
 	select HAVE_FUNCTION_ARG_ACCESS_API
--- a/arch/loongarch/include/asm/thread_info.h
+++ b/arch/loongarch/include/asm/thread_info.h
@@ -65,50 +65,42 @@ register unsigned long current_stack_poi
  *   access
  * - pending work-to-be-done flags are in LSW
  * - other flags in MSW
+ *
+ * Tell the generic TIF infrastructure which special bits loongarch supports
  */
-#define TIF_NEED_RESCHED	0	/* rescheduling necessary */
-#define TIF_NEED_RESCHED_LAZY	1	/* lazy rescheduling necessary */
-#define TIF_SIGPENDING		2	/* signal pending */
-#define TIF_NOTIFY_RESUME	3	/* callback before returning to user */
-#define TIF_NOTIFY_SIGNAL	4	/* signal notifications exist */
-#define TIF_RESTORE_SIGMASK	5	/* restore signal mask in do_signal() */
-#define TIF_NOHZ		6	/* in adaptive nohz mode */
-#define TIF_UPROBE		7	/* breakpointed or singlestepping */
-#define TIF_USEDFPU		8	/* FPU was used by this task this quantum (SMP) */
-#define TIF_USEDSIMD		9	/* SIMD has been used this quantum */
-#define TIF_MEMDIE		10	/* is terminating due to OOM killer */
-#define TIF_FIXADE		11	/* Fix address errors in software */
-#define TIF_LOGADE		12	/* Log address errors to syslog */
-#define TIF_32BIT_REGS		13	/* 32-bit general purpose registers */
-#define TIF_32BIT_ADDR		14	/* 32-bit address space */
-#define TIF_LOAD_WATCH		15	/* If set, load watch registers */
-#define TIF_SINGLESTEP		16	/* Single Step */
-#define TIF_LSX_CTX_LIVE	17	/* LSX context must be preserved */
-#define TIF_LASX_CTX_LIVE	18	/* LASX context must be preserved */
-#define TIF_USEDLBT		19	/* LBT was used by this task this quantum (SMP) */
-#define TIF_LBT_CTX_LIVE	20	/* LBT context must be preserved */
-#define TIF_PATCH_PENDING	21	/* pending live patching update */
+#define HAVE_TIF_NEED_RESCHED_LAZY
+#define HAVE_TIF_RESTORE_SIGMASK
 
-#define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
-#define _TIF_NEED_RESCHED_LAZY	(1<<TIF_NEED_RESCHED_LAZY)
-#define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
-#define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
-#define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
-#define _TIF_NOHZ		(1<<TIF_NOHZ)
-#define _TIF_UPROBE		(1<<TIF_UPROBE)
-#define _TIF_USEDFPU		(1<<TIF_USEDFPU)
-#define _TIF_USEDSIMD		(1<<TIF_USEDSIMD)
-#define _TIF_FIXADE		(1<<TIF_FIXADE)
-#define _TIF_LOGADE		(1<<TIF_LOGADE)
-#define _TIF_32BIT_REGS		(1<<TIF_32BIT_REGS)
-#define _TIF_32BIT_ADDR		(1<<TIF_32BIT_ADDR)
-#define _TIF_LOAD_WATCH		(1<<TIF_LOAD_WATCH)
-#define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
-#define _TIF_LSX_CTX_LIVE	(1<<TIF_LSX_CTX_LIVE)
-#define _TIF_LASX_CTX_LIVE	(1<<TIF_LASX_CTX_LIVE)
-#define _TIF_USEDLBT		(1<<TIF_USEDLBT)
-#define _TIF_LBT_CTX_LIVE	(1<<TIF_LBT_CTX_LIVE)
-#define _TIF_PATCH_PENDING	(1<<TIF_PATCH_PENDING)
+#include <asm-generic/thread_info_tif.h>
+
+/* Architecture specific bits */
+#define TIF_NOHZ		16	/* in adaptive nohz mode */
+#define TIF_USEDFPU		17	/* FPU was used by this task this quantum (SMP) */
+#define TIF_USEDSIMD		18	/* SIMD has been used this quantum */
+#define TIF_FIXADE		10	/* Fix address errors in software */
+#define TIF_LOGADE		20	/* Log address errors to syslog */
+#define TIF_32BIT_REGS		21	/* 32-bit general purpose registers */
+#define TIF_32BIT_ADDR		22	/* 32-bit address space */
+#define TIF_LOAD_WATCH		23	/* If set, load watch registers */
+#define TIF_SINGLESTEP		24	/* Single Step */
+#define TIF_LSX_CTX_LIVE	25	/* LSX context must be preserved */
+#define TIF_LASX_CTX_LIVE	26	/* LASX context must be preserved */
+#define TIF_USEDLBT		27	/* LBT was used by this task this quantum (SMP) */
+#define TIF_LBT_CTX_LIVE	28	/* LBT context must be preserved */
+
+#define _TIF_NOHZ		BIT(TIF_NOHZ)
+#define _TIF_USEDFPU		BIT(TIF_USEDFPU)
+#define _TIF_USEDSIMD		BIT(TIF_USEDSIMD)
+#define _TIF_FIXADE		BIT(TIF_FIXADE)
+#define _TIF_LOGADE		BIT(TIF_LOGADE)
+#define _TIF_32BIT_REGS		BIT(TIF_32BIT_REGS)
+#define _TIF_32BIT_ADDR		BIT(TIF_32BIT_ADDR)
+#define _TIF_LOAD_WATCH		BIT(TIF_LOAD_WATCH)
+#define _TIF_SINGLESTEP		BIT(TIF_SINGLESTEP)
+#define _TIF_LSX_CTX_LIVE	BIT(TIF_LSX_CTX_LIVE)
+#define _TIF_LASX_CTX_LIVE	BIT(TIF_LASX_CTX_LIVE)
+#define _TIF_USEDLBT		BIT(TIF_USEDLBT)
+#define _TIF_LBT_CTX_LIVE	BIT(TIF_LBT_CTX_LIVE)
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_THREAD_INFO_H */


