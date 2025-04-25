Return-Path: <linux-kernel+bounces-619814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65285A9C1D7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 10:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E197179E74
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 08:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EDA2367A1;
	Fri, 25 Apr 2025 08:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okvpYdTp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9620241693
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745570597; cv=none; b=n35PlRJoGiti6RyHvPU+3gevI1Be7rjPneNF3689n7uI4iQjC5UziuwP1FFcJVS+Ci/Jzcey5taxMZ8UMXkNKYGeOpf4w9LlPFKZZo6WleNsPlL85wSUbBro1H7GFvilH0Dn7ac8fXWPuqzWfBQ7baQsCVTqTiZnOTFilJ8g0HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745570597; c=relaxed/simple;
	bh=4BOgN3ZGLvm15Lktn6p3GX3xhrjfPUHGU9g1VpiBExw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ljU/pPEM2/GRrBFHtMjqGFTEVh4WO08x4iBhaQyXg5ZpB6O4YoQz49ci86sDmqIeTzLOq57fej8Kre2NELTIvxaidq6uInNrzA23roOLO8tEe7gKQSXZ39/2SjamZv4QisOTW7ubiv6SoZdxGSJmoVQgMl65S6q5eGeMLBfcfLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okvpYdTp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29726C4CEEC;
	Fri, 25 Apr 2025 08:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745570597;
	bh=4BOgN3ZGLvm15Lktn6p3GX3xhrjfPUHGU9g1VpiBExw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=okvpYdTpkZEWquxlNSLdVbUxd+l9PDLOcRyUHXUrCDPSfcZl6j8nAu2/BCXis+uWl
	 GaDLu1RBWl7bujYxAeJ57s6IKdcsi/kfl6VjDHJMCfVhCZlz6InzXKuQVALqDEtV6W
	 cGg8FvI42OKw7dWTC9zw+i4o7ooYxsL62JEeqoVGK+Co0nytvI5Dwtv/nEomfFuZpg
	 zhydiSPJVCQAHWCUxLBbVhZbFZcUG872y1Vi3Rrt3JBsXUGMBtnp3v9Ib91Xao4Ye2
	 vx34ZTcMecMKdZCdTl0h5Jqr5eH96P95/zSMNE2uXMuAZLNlt5qXvXqirSOxx/bvEF
	 XdMwvbCd5wp4w==
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"Ahmed S . Darwish" <darwi@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 15/15] x86/atomics: Remove !CONFIG_X86_CX8 methods
Date: Fri, 25 Apr 2025 10:42:12 +0200
Message-ID: <20250425084216.3913608-16-mingo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250425084216.3913608-1-mingo@kernel.org>
References: <20250425084216.3913608-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/asm-prototypes.h |   4 -
 arch/x86/include/asm/atomic64_32.h    |  17 +--
 arch/x86/include/asm/cmpxchg_32.h     |  86 +--------------
 arch/x86/lib/Makefile                 |   4 -
 arch/x86/lib/atomic64_386_32.S        | 195 ----------------------------------
 arch/x86/lib/cmpxchg8b_emu.S          |  97 -----------------
 lib/atomic64_test.c                   |   4 +-
 7 files changed, 6 insertions(+), 401 deletions(-)

diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index 11c6fecc3ad7..6ec680a36dea 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -16,10 +16,6 @@
 #include <asm/gsseg.h>
 #include <asm/nospec-branch.h>
 
-#ifndef CONFIG_X86_CX8
-extern void cmpxchg8b_emu(void);
-#endif
-
 #ifdef CONFIG_STACKPROTECTOR
 extern unsigned long __ref_stack_chk_guard;
 #endif
diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index ab838205c1c6..1ac093b89c43 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -48,29 +48,14 @@ static __always_inline s64 arch_atomic64_read_nonatomic(const atomic64_t *v)
 	ATOMIC64_EXPORT(atomic64_##sym)
 #endif
 
-#ifdef CONFIG_X86_CX8
 #define __alternative_atomic64(f, g, out, in, clobbers...)		\
 	asm volatile("call %c[func]"					\
-		     : ALT_OUTPUT_SP(out) \
+		     : ALT_OUTPUT_SP(out)				\
 		     : [func] "i" (atomic64_##g##_cx8)			\
 		       COMMA(in)					\
 		     : clobbers)
 
 #define ATOMIC64_DECL(sym) ATOMIC64_DECL_ONE(sym##_cx8)
-#else
-#define __alternative_atomic64(f, g, out, in, clobbers...)		\
-	alternative_call(atomic64_##f##_386, atomic64_##g##_cx8,	\
-			 X86_FEATURE_CX8, ASM_OUTPUT(out),		\
-			 ASM_INPUT(in), clobbers)
-
-#define ATOMIC64_DECL(sym) ATOMIC64_DECL_ONE(sym##_cx8); \
-	ATOMIC64_DECL_ONE(sym##_386)
-
-ATOMIC64_DECL_ONE(add_386);
-ATOMIC64_DECL_ONE(sub_386);
-ATOMIC64_DECL_ONE(inc_386);
-ATOMIC64_DECL_ONE(dec_386);
-#endif
 
 #define alternative_atomic64(f, out, in, clobbers...) \
 	__alternative_atomic64(f, f, ASM_OUTPUT(out), ASM_INPUT(in), clobbers)
diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index 371f7906019e..5902fa5af93b 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -69,88 +69,10 @@ static __always_inline bool __try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp,
 	return __arch_try_cmpxchg64(ptr, oldp, new,);
 }
 
-#ifdef CONFIG_X86_CX8
-
-#define arch_cmpxchg64 __cmpxchg64
-
-#define arch_cmpxchg64_local __cmpxchg64_local
-
-#define arch_try_cmpxchg64 __try_cmpxchg64
-
-#define arch_try_cmpxchg64_local __try_cmpxchg64_local
-
-#else
-
-/*
- * Building a kernel capable running on 80386 and 80486. It may be necessary
- * to simulate the cmpxchg8b on the 80386 and 80486 CPU.
- */
-
-#define __arch_cmpxchg64_emu(_ptr, _old, _new, _lock_loc, _lock)	\
-({									\
-	union __u64_halves o = { .full = (_old), },			\
-			   n = { .full = (_new), };			\
-									\
-	asm_inline volatile(						\
-		ALTERNATIVE(_lock_loc					\
-			    "call cmpxchg8b_emu",			\
-			    _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8)	\
-		: ALT_OUTPUT_SP("+a" (o.low), "+d" (o.high))		\
-		: "b" (n.low), "c" (n.high),				\
-		  [ptr] "S" (_ptr)					\
-		: "memory");						\
-									\
-	o.full;								\
-})
-
-static __always_inline u64 arch_cmpxchg64(volatile u64 *ptr, u64 old, u64 new)
-{
-	return __arch_cmpxchg64_emu(ptr, old, new, LOCK_PREFIX_HERE, "lock ");
-}
-#define arch_cmpxchg64 arch_cmpxchg64
-
-static __always_inline u64 arch_cmpxchg64_local(volatile u64 *ptr, u64 old, u64 new)
-{
-	return __arch_cmpxchg64_emu(ptr, old, new, ,);
-}
-#define arch_cmpxchg64_local arch_cmpxchg64_local
-
-#define __arch_try_cmpxchg64_emu(_ptr, _oldp, _new, _lock_loc, _lock)	\
-({									\
-	union __u64_halves o = { .full = *(_oldp), },			\
-			   n = { .full = (_new), };			\
-	bool ret;							\
-									\
-	asm_inline volatile(						\
-		ALTERNATIVE(_lock_loc					\
-			    "call cmpxchg8b_emu",			\
-			    _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8) \
-		CC_SET(e)						\
-		: ALT_OUTPUT_SP(CC_OUT(e) (ret),			\
-				"+a" (o.low), "+d" (o.high))		\
-		: "b" (n.low), "c" (n.high),				\
-		  [ptr] "S" (_ptr)					\
-		: "memory");						\
-									\
-	if (unlikely(!ret))						\
-		*(_oldp) = o.full;					\
-									\
-	likely(ret);							\
-})
-
-static __always_inline bool arch_try_cmpxchg64(volatile u64 *ptr, u64 *oldp, u64 new)
-{
-	return __arch_try_cmpxchg64_emu(ptr, oldp, new, LOCK_PREFIX_HERE, "lock ");
-}
-#define arch_try_cmpxchg64 arch_try_cmpxchg64
-
-static __always_inline bool arch_try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp, u64 new)
-{
-	return __arch_try_cmpxchg64_emu(ptr, oldp, new, ,);
-}
-#define arch_try_cmpxchg64_local arch_try_cmpxchg64_local
-
-#endif
+#define arch_cmpxchg64			__cmpxchg64
+#define arch_cmpxchg64_local		__cmpxchg64_local
+#define arch_try_cmpxchg64		__try_cmpxchg64
+#define arch_try_cmpxchg64_local	__try_cmpxchg64_local
 
 #define system_has_cmpxchg64()		boot_cpu_has(X86_FEATURE_CX8)
 
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 1c50352eb49f..59b513978d7e 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -58,10 +58,6 @@ ifeq ($(CONFIG_X86_32),y)
         lib-y += strstr_32.o
         lib-y += string_32.o
         lib-y += memmove_32.o
-        lib-y += cmpxchg8b_emu.o
-ifneq ($(CONFIG_X86_CX8),y)
-        lib-y += atomic64_386_32.o
-endif
 else
 ifneq ($(CONFIG_GENERIC_CSUM),y)
         lib-y += csum-partial_64.o csum-copy_64.o csum-wrappers_64.o
diff --git a/arch/x86/lib/atomic64_386_32.S b/arch/x86/lib/atomic64_386_32.S
deleted file mode 100644
index e768815e58ae..000000000000
--- a/arch/x86/lib/atomic64_386_32.S
+++ /dev/null
@@ -1,195 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * atomic64_t for 386/486
- *
- * Copyright © 2010  Luca Barbieri
- */
-
-#include <linux/linkage.h>
-#include <asm/alternative.h>
-
-/* if you want SMP support, implement these with real spinlocks */
-.macro IRQ_SAVE reg
-	pushfl
-	cli
-.endm
-
-.macro IRQ_RESTORE reg
-	popfl
-.endm
-
-#define BEGIN_IRQ_SAVE(op) \
-.macro endp; \
-SYM_FUNC_END(atomic64_##op##_386); \
-.purgem endp; \
-.endm; \
-SYM_FUNC_START(atomic64_##op##_386); \
-	IRQ_SAVE v;
-
-#define ENDP endp
-
-#define RET_IRQ_RESTORE \
-	IRQ_RESTORE v; \
-	RET
-
-#define v %ecx
-BEGIN_IRQ_SAVE(read)
-	movl  (v), %eax
-	movl 4(v), %edx
-	RET_IRQ_RESTORE
-ENDP
-#undef v
-
-#define v %esi
-BEGIN_IRQ_SAVE(set)
-	movl %ebx,  (v)
-	movl %ecx, 4(v)
-	RET_IRQ_RESTORE
-ENDP
-#undef v
-
-#define v  %esi
-BEGIN_IRQ_SAVE(xchg)
-	movl  (v), %eax
-	movl 4(v), %edx
-	movl %ebx,  (v)
-	movl %ecx, 4(v)
-	RET_IRQ_RESTORE
-ENDP
-#undef v
-
-#define v %ecx
-BEGIN_IRQ_SAVE(add)
-	addl %eax,  (v)
-	adcl %edx, 4(v)
-	RET_IRQ_RESTORE
-ENDP
-#undef v
-
-#define v %ecx
-BEGIN_IRQ_SAVE(add_return)
-	addl  (v), %eax
-	adcl 4(v), %edx
-	movl %eax,  (v)
-	movl %edx, 4(v)
-	RET_IRQ_RESTORE
-ENDP
-#undef v
-
-#define v %ecx
-BEGIN_IRQ_SAVE(sub)
-	subl %eax,  (v)
-	sbbl %edx, 4(v)
-	RET_IRQ_RESTORE
-ENDP
-#undef v
-
-#define v %ecx
-BEGIN_IRQ_SAVE(sub_return)
-	negl %edx
-	negl %eax
-	sbbl $0, %edx
-	addl  (v), %eax
-	adcl 4(v), %edx
-	movl %eax,  (v)
-	movl %edx, 4(v)
-	RET_IRQ_RESTORE
-ENDP
-#undef v
-
-#define v %esi
-BEGIN_IRQ_SAVE(inc)
-	addl $1,  (v)
-	adcl $0, 4(v)
-	RET_IRQ_RESTORE
-ENDP
-#undef v
-
-#define v %esi
-BEGIN_IRQ_SAVE(inc_return)
-	movl  (v), %eax
-	movl 4(v), %edx
-	addl $1, %eax
-	adcl $0, %edx
-	movl %eax,  (v)
-	movl %edx, 4(v)
-	RET_IRQ_RESTORE
-ENDP
-#undef v
-
-#define v %esi
-BEGIN_IRQ_SAVE(dec)
-	subl $1,  (v)
-	sbbl $0, 4(v)
-	RET_IRQ_RESTORE
-ENDP
-#undef v
-
-#define v %esi
-BEGIN_IRQ_SAVE(dec_return)
-	movl  (v), %eax
-	movl 4(v), %edx
-	subl $1, %eax
-	sbbl $0, %edx
-	movl %eax,  (v)
-	movl %edx, 4(v)
-	RET_IRQ_RESTORE
-ENDP
-#undef v
-
-#define v %esi
-BEGIN_IRQ_SAVE(add_unless)
-	addl %eax, %ecx
-	adcl %edx, %edi
-	addl  (v), %eax
-	adcl 4(v), %edx
-	cmpl %eax, %ecx
-	je 3f
-1:
-	movl %eax,  (v)
-	movl %edx, 4(v)
-	movl $1, %eax
-2:
-	RET_IRQ_RESTORE
-3:
-	cmpl %edx, %edi
-	jne 1b
-	xorl %eax, %eax
-	jmp 2b
-ENDP
-#undef v
-
-#define v %esi
-BEGIN_IRQ_SAVE(inc_not_zero)
-	movl  (v), %eax
-	movl 4(v), %edx
-	testl %eax, %eax
-	je 3f
-1:
-	addl $1, %eax
-	adcl $0, %edx
-	movl %eax,  (v)
-	movl %edx, 4(v)
-	movl $1, %eax
-2:
-	RET_IRQ_RESTORE
-3:
-	testl %edx, %edx
-	jne 1b
-	jmp 2b
-ENDP
-#undef v
-
-#define v %esi
-BEGIN_IRQ_SAVE(dec_if_positive)
-	movl  (v), %eax
-	movl 4(v), %edx
-	subl $1, %eax
-	sbbl $0, %edx
-	js 1f
-	movl %eax,  (v)
-	movl %edx, 4(v)
-1:
-	RET_IRQ_RESTORE
-ENDP
-#undef v
diff --git a/arch/x86/lib/cmpxchg8b_emu.S b/arch/x86/lib/cmpxchg8b_emu.S
deleted file mode 100644
index d4bb24347ff8..000000000000
--- a/arch/x86/lib/cmpxchg8b_emu.S
+++ /dev/null
@@ -1,97 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-
-#include <linux/export.h>
-#include <linux/linkage.h>
-#include <asm/percpu.h>
-#include <asm/processor-flags.h>
-
-.text
-
-#ifndef CONFIG_X86_CX8
-
-/*
- * Emulate 'cmpxchg8b (%esi)' on UP
- *
- * Inputs:
- * %esi : memory location to compare
- * %eax : low 32 bits of old value
- * %edx : high 32 bits of old value
- * %ebx : low 32 bits of new value
- * %ecx : high 32 bits of new value
- */
-SYM_FUNC_START(cmpxchg8b_emu)
-
-	pushfl
-	cli
-
-	cmpl	(%esi), %eax
-	jne	.Lnot_same
-	cmpl	4(%esi), %edx
-	jne	.Lnot_same
-
-	movl	%ebx, (%esi)
-	movl	%ecx, 4(%esi)
-
-	orl	$X86_EFLAGS_ZF, (%esp)
-
-	popfl
-	RET
-
-.Lnot_same:
-	movl	(%esi), %eax
-	movl	4(%esi), %edx
-
-	andl	$(~X86_EFLAGS_ZF), (%esp)
-
-	popfl
-	RET
-
-SYM_FUNC_END(cmpxchg8b_emu)
-EXPORT_SYMBOL(cmpxchg8b_emu)
-
-#endif
-
-#ifndef CONFIG_UML
-
-/*
- * Emulate 'cmpxchg8b %fs:(%rsi)'
- *
- * Inputs:
- * %esi : memory location to compare
- * %eax : low 32 bits of old value
- * %edx : high 32 bits of old value
- * %ebx : low 32 bits of new value
- * %ecx : high 32 bits of new value
- *
- * Notably this is not LOCK prefixed and is not safe against NMIs
- */
-SYM_FUNC_START(this_cpu_cmpxchg8b_emu)
-
-	pushfl
-	cli
-
-	cmpl	__percpu (%esi), %eax
-	jne	.Lnot_same2
-	cmpl	__percpu 4(%esi), %edx
-	jne	.Lnot_same2
-
-	movl	%ebx, __percpu (%esi)
-	movl	%ecx, __percpu 4(%esi)
-
-	orl	$X86_EFLAGS_ZF, (%esp)
-
-	popfl
-	RET
-
-.Lnot_same2:
-	movl	__percpu (%esi), %eax
-	movl	__percpu 4(%esi), %edx
-
-	andl	$(~X86_EFLAGS_ZF), (%esp)
-
-	popfl
-	RET
-
-SYM_FUNC_END(this_cpu_cmpxchg8b_emu)
-
-#endif
diff --git a/lib/atomic64_test.c b/lib/atomic64_test.c
index d726068358c7..352e811c99ce 100644
--- a/lib/atomic64_test.c
+++ b/lib/atomic64_test.c
@@ -254,10 +254,8 @@ static __init int test_atomics_init(void)
 	pr_info("passed for %s platform %s CX8 and %s SSE\n",
 #ifdef CONFIG_X86_64
 		"x86-64",
-#elif defined(CONFIG_X86_CX8)
-		"i586+",
 #else
-		"i386+",
+		"i586+",
 #endif
 	       boot_cpu_has(X86_FEATURE_CX8) ? "with" : "without",
 	       boot_cpu_has(X86_FEATURE_XMM) ? "with" : "without");
-- 
2.45.2


