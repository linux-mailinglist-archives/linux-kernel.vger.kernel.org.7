Return-Path: <linux-kernel+bounces-801768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 695E3B44997
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96691C850D9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A774D34F489;
	Thu,  4 Sep 2025 22:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ulFuMzdj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wUwJe+AS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6020D34DCDA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024498; cv=none; b=cQJVY+NPmJk2rp4QLQlyLFdYCnip5l3CAvUjhgA8qPJVXmo50jlOip5YqThBfkt4ETEjDZyo5RDZaLg0i7y61oKBaV3bwf5u9SSnYR8+D8jkKV5Us9I2TeE8bb6E1R+U7s32S9pthO6M4ECjctfV0HILEvYt7x5Dbj40HWEQToI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024498; c=relaxed/simple;
	bh=Qd25ojoro6f9oZL++YMHIZMeXwsLY5lMNaOVawY4uiw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=deavZ2WQAVN2WZYKhebFGm8O4ziuS77SrsK/xtbWYGWNE4ef5HNsdGLpz5ciaJTNM8qHAQkCZtqr4glkw95KXlpnRiFFe7QW/AcJVmn5IiGWFQzjftVfKgXBbWHAb2ZaeR9r34zfwFNXcZV7/icgMllzYVXcoO8nCV9cUZy2POI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ulFuMzdj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wUwJe+AS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250904185721.164721223@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757024494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=TL3z3YOCrrBlWPtzN//NtHrQtnsZqHj+Stdoaeg20Is=;
	b=ulFuMzdjL/wU3H02+GoCy2zfMxU96SSsi7AZhDBOEL/1uwJsGaoEzY/RcomCv2R7tzRhWm
	mABsEuBNm1x5CjqlBe5L5yyan0c+4uL85tMerBYwTbdrzIwxynkXhFJ7r85B3Qz7hB5Ymn
	UY27kMy3FViT8H6cUCNgwmOtmU8n0qB7qBrCQ6lrXPLiofgFBlXj36CwsItFIfBpfps5bk
	KgLCl6qgPiLPNr0Q3kbHzbRhslhClyhXdcV6pEMTQCTWbAbDLnigrjs+ZVuwWWUCPb7lQD
	OnfRR4i3i6kehfBM17ztEuyt7js08E17fGcn3JeVSZD4ugxrANYDJuNibsUSNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757024494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=TL3z3YOCrrBlWPtzN//NtHrQtnsZqHj+Stdoaeg20Is=;
	b=wUwJe+ASROGM0qt0bwbI0hmhkrDbn1FJZkCTZ0jY+E73rX5VHE3F/zf+Wffq/DnefNmF0R
	Kh/z8hbE8o6vJ5BA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [patch V3 32/37] x86: Use generic TIF bits
References: <20250904185336.943880027@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  5 Sep 2025 00:21:33 +0200 (CEST)

No point in defining generic items and the upcoming RSEQ optimizations are
only available with this _and_ the generic entry infrastructure, which is
already used by x86. So no further action required here.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: x86@kernel.org

---
 arch/x86/Kconfig                   |    1 
 arch/x86/include/asm/thread_info.h |   74 +++++++++++++++----------------------
 2 files changed, 31 insertions(+), 44 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -239,6 +239,7 @@ config X86
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_EISA			if X86_32
 	select HAVE_EXIT_THREAD
+	select HAVE_GENERIC_TIF_BITS
 	select HAVE_GUP_FAST
 	select HAVE_FENTRY			if X86_64 || DYNAMIC_FTRACE
 	select HAVE_FTRACE_GRAPH_FUNC		if HAVE_FUNCTION_GRAPH_TRACER
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -80,56 +80,42 @@ struct thread_info {
 #endif
 
 /*
- * thread information flags
- * - these are process state flags that various assembly files
- *   may need to access
+ * Tell the generic TIF infrastructure which bits x86 supports
  */
-#define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
-#define TIF_SIGPENDING		2	/* signal pending */
-#define TIF_NEED_RESCHED	3	/* rescheduling necessary */
-#define TIF_NEED_RESCHED_LAZY	4	/* Lazy rescheduling needed */
-#define TIF_SINGLESTEP		5	/* reenable singlestep on user return*/
-#define TIF_SSBD		6	/* Speculative store bypass disable */
-#define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
-#define TIF_SPEC_L1D_FLUSH	10	/* Flush L1D on mm switches (processes) */
-#define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
-#define TIF_UPROBE		12	/* breakpointed or singlestepping */
-#define TIF_PATCH_PENDING	13	/* pending live patching update */
-#define TIF_NEED_FPU_LOAD	14	/* load FPU on return to userspace */
-#define TIF_NOCPUID		15	/* CPUID is not accessible in userland */
-#define TIF_NOTSC		16	/* TSC is not accessible in userland */
-#define TIF_NOTIFY_SIGNAL	17	/* signal notifications exist */
-#define TIF_MEMDIE		20	/* is terminating due to OOM killer */
-#define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
+#define HAVE_TIF_NEED_RESCHED_LAZY
+#define HAVE_TIF_POLLING_NRFLAG
+#define HAVE_TIF_SINGLESTEP
+
+#include <asm-generic/thread_info_tif.h>
+
+/* Architecture specific TIF space starts at 16 */
+#define TIF_SSBD		16	/* Speculative store bypass disable */
+#define TIF_SPEC_IB		17	/* Indirect branch speculation mitigation */
+#define TIF_SPEC_L1D_FLUSH	18	/* Flush L1D on mm switches (processes) */
+#define TIF_NEED_FPU_LOAD	19	/* load FPU on return to userspace */
+#define TIF_NOCPUID		20	/* CPUID is not accessible in userland */
+#define TIF_NOTSC		21	/* TSC is not accessible in userland */
 #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
 #define TIF_SPEC_FORCE_UPDATE	23	/* Force speculation MSR update in context switch */
 #define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
-#define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
+#define TIF_SINGLESTEP		25	/* reenable singlestep on user return*/
+#define TIF_BLOCKSTEP		26	/* set when we want DEBUGCTLMSR_BTF */
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
-#define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
+#define TIF_ADDR32		28	/* 32-bit address space on 64 bits */
 
-#define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
-#define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
-#define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
-#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
-#define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
-#define _TIF_SSBD		(1 << TIF_SSBD)
-#define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
-#define _TIF_SPEC_L1D_FLUSH	(1 << TIF_SPEC_L1D_FLUSH)
-#define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
-#define _TIF_UPROBE		(1 << TIF_UPROBE)
-#define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
-#define _TIF_NEED_FPU_LOAD	(1 << TIF_NEED_FPU_LOAD)
-#define _TIF_NOCPUID		(1 << TIF_NOCPUID)
-#define _TIF_NOTSC		(1 << TIF_NOTSC)
-#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
-#define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
-#define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
-#define _TIF_SPEC_FORCE_UPDATE	(1 << TIF_SPEC_FORCE_UPDATE)
-#define _TIF_FORCED_TF		(1 << TIF_FORCED_TF)
-#define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
-#define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
-#define _TIF_ADDR32		(1 << TIF_ADDR32)
+#define _TIF_SSBD		BIT(TIF_SSBD)
+#define _TIF_SPEC_IB		BIT(TIF_SPEC_IB)
+#define _TIF_SPEC_L1D_FLUSH	BIT(TIF_SPEC_L1D_FLUSH)
+#define _TIF_NEED_FPU_LOAD	BIT(TIF_NEED_FPU_LOAD)
+#define _TIF_NOCPUID		BIT(TIF_NOCPUID)
+#define _TIF_NOTSC		BIT(TIF_NOTSC)
+#define _TIF_IO_BITMAP		BIT(TIF_IO_BITMAP)
+#define _TIF_SPEC_FORCE_UPDATE	BIT(TIF_SPEC_FORCE_UPDATE)
+#define _TIF_FORCED_TF		BIT(TIF_FORCED_TF)
+#define _TIF_BLOCKSTEP		BIT(TIF_BLOCKSTEP)
+#define _TIF_SINGLESTEP		BIT(TIF_SINGLESTEP)
+#define _TIF_LAZY_MMU_UPDATES	BIT(TIF_LAZY_MMU_UPDATES)
+#define _TIF_ADDR32		BIT(TIF_ADDR32)
 
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW_BASE					\



