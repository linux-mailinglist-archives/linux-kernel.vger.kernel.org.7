Return-Path: <linux-kernel+bounces-863438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2D5BF7DBC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95F824F6217
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8074234F25A;
	Tue, 21 Oct 2025 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PGS5qQSC"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE3D34D4D8
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067147; cv=none; b=e78c3OZAMRT8zBBw8MUnT4zmbo4W6YJJeHd68Pt6nRq4zBhISqIx0p9+HVMHEn0HS+z3zpyZz17trLlte6B5Z/5pNHyRZJSJ8hiN8VRJm0wP1qp54YdvKJzE4zEWjnhzO2zlo7UIikM1fjdugkz/JR/RBWDKfRublncGVo/OLCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067147; c=relaxed/simple;
	bh=eAraFzFKd/2hBsh1Z1QOrug1JI6HQy89UW8DH5jS/k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dc5AYkglPj8R3slQxpM2XL1EQVUlaQDix+7atvdr2Ko9of4RgsgR59XHr/SE+HxSmmCcm+Z4IKoGwJWfVEqTjXo5tUo1k7FuxGFuSUem/XBq54l7z0BKAe06rstYpT/QjXNguLWJMcRXp0APTNKzXdmDkhXon5rnGxC4cPicJJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PGS5qQSC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9lbDnbUdZ0lJct1J0xX76kLGxws30Il4RbOhn8FLNWI=; b=PGS5qQSCZRAVhTrTM/JTCLi2Ya
	JT0Dq7IfaFhpgt7gWz+DpfXNCN3v+4yS1sSY+3ndrF/L+fePLigwwZ1yBAa8JLZKwybmR1cgJd4eJ
	WmZIIeIknyNMFMWgymMarvnNUMP4kgTcnqMGemA9Yofwy4HDZlzUFXDIKQlndV1dMi8k7VTkYtYOl
	pzas3YzQYpMl0NnA7a61HfesEwrROfck9wsu0qsf7ZSJyNoBEovOnG7DeTWrxl08pkaQWa/z2CJKh
	bGHfjI9IA30qvVgbOcPkoCF/Mr2YZi1mINDy1vOevGZsngC1PRaAbO4ETJ8qbCHTtAhjBa4RgshFp
	2Xk53nWQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBG0a-0000000DsSf-2gYe;
	Tue, 21 Oct 2025 17:18:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5D1DA3030EF; Mon, 20 Oct 2025 17:01:33 +0200 (CEST)
Date: Mon, 20 Oct 2025 17:01:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 40/56] x86/alternative: Use sync_core_nmi_safe()
Message-ID: <20251020150133.GK3245006@noisy.programming.kicks-ass.net>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-41-david.kaplan@amd.com>
 <20251016103549.GD3289052@noisy.programming.kicks-ass.net>
 <DS0PR12MB9273D987B842D9E80081261A94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
 <20251016144730.GC3245006@noisy.programming.kicks-ass.net>
 <LV3PR12MB9265DFD04F0F17DE7AAF204994F5A@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV3PR12MB9265DFD04F0F17DE7AAF204994F5A@LV3PR12MB9265.namprd12.prod.outlook.com>

On Mon, Oct 20, 2025 at 02:49:56PM +0000, Kaplan, David wrote:

> Coming back to this, are you thinking we should just create something
> like 'text_poke_sync_core()' inside alternative.c and that can use:
>    1. SERIALIZE (if available)
>    2. MOV-CR2 (if re-patching)
>    3. Else, IRET
> 
> And maybe someday we put MFENCE into there too for AMD parts.
> 
> Right now, of course this is the only logic that would care about an
> NMI-safe sync_core().  So maybe this makes sense vs creating a generic
> version that nobody else is using?

I was thinking something fairly straight forward like the below. Yes,
there are a few more sync_core() callers out there, git tells me:

arch/x86/kernel/alternative.c:          sync_core();
arch/x86/kernel/alternative.c:noinstr void sync_core(void)
arch/x86/kernel/alternative.c:  sync_core();
arch/x86/kernel/cpu/mce/core.c: sync_core();
arch/x86/kernel/cpu/mce/core.c:         sync_core();
arch/x86/kernel/static_call.c:  sync_core();
drivers/misc/sgi-gru/grufault.c:                sync_core();
drivers/misc/sgi-gru/grufault.c:                sync_core();            /* make sure we are have current data */
drivers/misc/sgi-gru/gruhandles.c:      sync_core();
drivers/misc/sgi-gru/gruhandles.c:      sync_core();
drivers/misc/sgi-gru/grukservices.c:    sync_core();

But none of that seems like it cares about an extra few cycles, and why
complicate matters with another sync_core variant and all that.


diff --git a/arch/x86/include/asm/sync_core.h b/arch/x86/include/asm/sync_core.h
index 96bda43538ee..ef4508a03800 100644
--- a/arch/x86/include/asm/sync_core.h
+++ b/arch/x86/include/asm/sync_core.h
@@ -7,86 +7,7 @@
 #include <asm/cpufeature.h>
 #include <asm/special_insns.h>
 
-#ifdef CONFIG_X86_32
-static __always_inline void iret_to_self(void)
-{
-	asm volatile (
-		"pushfl\n\t"
-		"pushl %%cs\n\t"
-		"pushl $1f\n\t"
-		"iret\n\t"
-		"1:"
-		: ASM_CALL_CONSTRAINT : : "memory");
-}
-#else
-static __always_inline void iret_to_self(void)
-{
-	unsigned int tmp;
-
-	asm volatile (
-		"mov %%ss, %0\n\t"
-		"pushq %q0\n\t"
-		"pushq %%rsp\n\t"
-		"addq $8, (%%rsp)\n\t"
-		"pushfq\n\t"
-		"mov %%cs, %0\n\t"
-		"pushq %q0\n\t"
-		"pushq $1f\n\t"
-		"iretq\n\t"
-		"1:"
-		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
-}
-#endif /* CONFIG_X86_32 */
-
-/*
- * This function forces the icache and prefetched instruction stream to
- * catch up with reality in two very specific cases:
- *
- *  a) Text was modified using one virtual address and is about to be executed
- *     from the same physical page at a different virtual address.
- *
- *  b) Text was modified on a different CPU, may subsequently be
- *     executed on this CPU, and you want to make sure the new version
- *     gets executed.  This generally means you're calling this in an IPI.
- *
- * If you're calling this for a different reason, you're probably doing
- * it wrong.
- *
- * Like all of Linux's memory ordering operations, this is a
- * compiler barrier as well.
- */
-static __always_inline void sync_core(void)
-{
-	/*
-	 * The SERIALIZE instruction is the most straightforward way to
-	 * do this, but it is not universally available.
-	 */
-	if (static_cpu_has(X86_FEATURE_SERIALIZE)) {
-		serialize();
-		return;
-	}
-
-	/*
-	 * For all other processors, there are quite a few ways to do this.
-	 * IRET-to-self is nice because it works on every CPU, at any CPL
-	 * (so it's compatible with paravirtualization), and it never exits
-	 * to a hypervisor.  The only downsides are that it's a bit slow
-	 * (it seems to be a bit more than 2x slower than the fastest
-	 * options) and that it unmasks NMIs.  The "push %cs" is needed,
-	 * because in paravirtual environments __KERNEL_CS may not be a
-	 * valid CS value when we do IRET directly.
-	 *
-	 * In case NMI unmasking or performance ever becomes a problem,
-	 * the next best option appears to be MOV-to-CR2 and an
-	 * unconditional jump.  That sequence also works on all CPUs,
-	 * but it will fault at CPL3 (i.e. Xen PV).
-	 *
-	 * CPUID is the conventional way, but it's nasty: it doesn't
-	 * exist on some 486-like CPUs, and it usually exits to a
-	 * hypervisor.
-	 */
-	iret_to_self();
-}
+extern void sync_core(void);
 
 /*
  * Ensure that a core serializing instruction is issued before returning
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index e377b06e70e3..2a5daae3626b 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2687,6 +2687,87 @@ void *text_poke_set(void *addr, int c, size_t len)
 	return addr;
 }
 
+#ifdef CONFIG_X86_32
+static __always_inline void iret_to_self(void)
+{
+	asm volatile (
+		"pushfl\n\t"
+		"pushl %%cs\n\t"
+		"pushl $1f\n\t"
+		"iret\n\t"
+		"1:"
+		: ASM_CALL_CONSTRAINT : : "memory");
+}
+#else
+static __always_inline void iret_to_self(void)
+{
+	unsigned int tmp;
+
+	asm volatile (
+		"mov %%ss, %0\n\t"
+		"pushq %q0\n\t"
+		"pushq %%rsp\n\t"
+		"addq $8, (%%rsp)\n\t"
+		"pushfq\n\t"
+		"mov %%cs, %0\n\t"
+		"pushq %q0\n\t"
+		"pushq $1f\n\t"
+		"iretq\n\t"
+		"1:"
+		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
+}
+#endif /* CONFIG_X86_32 */
+
+/*
+ * This function forces the icache and prefetched instruction stream to
+ * catch up with reality in two very specific cases:
+ *
+ *  a) Text was modified using one virtual address and is about to be executed
+ *     from the same physical page at a different virtual address.
+ *
+ *  b) Text was modified on a different CPU, may subsequently be
+ *     executed on this CPU, and you want to make sure the new version
+ *     gets executed.  This generally means you're calling this in an IPI.
+ *
+ * If you're calling this for a different reason, you're probably doing
+ * it wrong.
+ *
+ * Like all of Linux's memory ordering operations, this is a
+ * compiler barrier as well.
+ */
+noinstr void sync_core(void)
+{
+	/*
+	 * The SERIALIZE instruction is the most straightforward way to
+	 * do this, but it is not universally available.
+	 */
+	if (static_cpu_has(X86_FEATURE_SERIALIZE)) {
+		serialize();
+		return;
+	}
+
+	/*
+	 * For all other processors, there are quite a few ways to do this.
+	 * IRET-to-self is nice because it works on every CPU, at any CPL
+	 * (so it's compatible with paravirtualization), and it never exits
+	 * to a hypervisor.  The only downsides are that it's a bit slow
+	 * (it seems to be a bit more than 2x slower than the fastest
+	 * options) and that it unmasks NMIs.  The "push %cs" is needed,
+	 * because in paravirtual environments __KERNEL_CS may not be a
+	 * valid CS value when we do IRET directly.
+	 *
+	 * In case NMI unmasking or performance ever becomes a problem,
+	 * the next best option appears to be MOV-to-CR2 and an
+	 * unconditional jump.  That sequence also works on all CPUs,
+	 * but it will fault at CPL3 (i.e. Xen PV).
+	 *
+	 * CPUID is the conventional way, but it's nasty: it doesn't
+	 * exist on some 486-like CPUs, and it usually exits to a
+	 * hypervisor.
+	 */
+	iret_to_self();
+}
+
 static void do_sync_core(void *info)
 {
 	sync_core();

