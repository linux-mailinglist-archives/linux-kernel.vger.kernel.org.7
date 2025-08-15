Return-Path: <linux-kernel+bounces-770333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A971CB279B6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63EC2AC5576
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507832D3742;
	Fri, 15 Aug 2025 07:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eKZ3G/V/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XC/1PxJi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE3E2D3726
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755241572; cv=none; b=pNTb7BZFuciwGST3oh7vwIyE5EvXdUNPkPhcV4FWrIk69orzh2zEVWxUAnbc84HVjhUVkBBtttQCvYR3l9IOP0VzsIwGBzWL2+FcWC88YOxFELWUrTaqP5EWNRYB9//qTT3nwH3hQJnuNDJyz7d0qBlX1Lmx6KZTyT19JCGp8Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755241572; c=relaxed/simple;
	bh=WnfbRPGtzLUFs3KRv7m7E97+zrD4D9mfA4GQ+6CbflM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtMfSYZqKJH8CheGXjPw/7yIbrxMe0Lb8h2nBVcDFwqIvjJZRpR7RTpHFQV91McJu1mQXcJypzui+kKHo0TGiKdFM5zzBdpYXXw2Ai8BM0I7vmHS9YwvfxoiSfJ7DsUku9i9Oi6E4YMCccavamR9BNPWNEWaAcLdKhtIMjpb4JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eKZ3G/V/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XC/1PxJi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755241569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ckafa6qGRrSy2xIMkp0+kG6pmMOuCSppcj32NSzi0cw=;
	b=eKZ3G/V/vQbaPb4PtmAdXlt0qWbc4jmeg17oSfgXrdDVpN2FEwFrTXGGjSFb56cnU1nqTs
	hREy7kfv5y7I7lVj4+JrnRDAHBioJGe/UYjCo2/YfJO73oxO1qdU/6J8SfgCM4iJKjakWx
	IDPICgoGcwvKBh1ymUhkl2PGVcO4ErKVClirVvzcQIIj8FX7dmINh72AegQNq3ws0QuU0r
	KyggVP1e4Fc9VCFUFDFvyY2qLxdgQuXYx5TvnhXSm3Ubwy8t4a6ZN6/jAoRSNEeHJfU/oO
	qnZ1fRClN15lcN8aXdlzpWL/0sm9S1PvSU1gED79SQG/yyVDhLo6eako8RVEtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755241569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ckafa6qGRrSy2xIMkp0+kG6pmMOuCSppcj32NSzi0cw=;
	b=XC/1PxJi6pEk24M49ucDRDiYuU+4sgYQYD3SqfUjgWTgCOUt+Vk8f2gd2lU0K/oGlmqZnR
	Q7ufXGCVsjecwjCg==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v4 21/34] x86/cpuid: Remove direct CPUID(0x2) query API
Date: Fri, 15 Aug 2025 09:02:14 +0200
Message-ID: <20250815070227.19981-22-darwi@linutronix.de>
In-Reply-To: <20250815070227.19981-1-darwi@linutronix.de>
References: <20250815070227.19981-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All call sites at x86/cpu and x86/cacheinfo has been switched from direct
CPUID(0x2) access to parsed CPUID access.  Remove the direct CPUID(0x2)
query APIs at <asm/cpuid/api.h>:

    cpuid_leaf_0x2()
    for_each_cpuid_0x2_desc()

Rename the iterator macro:

    for_each_parsed_cpuid_0x2_desc()

back to:

    for_each_cpuid_0x2_desc()

since the "for_each_parsed_.." name and was just chosen to accommodate
the transition from direct CPUID(0x2) access to parsed access.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/cpuid/api.h | 75 ++------------------------------
 arch/x86/kernel/cpu/cacheinfo.c  |  2 +-
 arch/x86/kernel/cpu/intel.c      |  2 +-
 3 files changed, 5 insertions(+), 74 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index b125e492d239..146498d5dbfa 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -213,75 +213,6 @@ static inline u32 cpuid_base_hypervisor(const char *sig, u32 leaves)
 	return 0;
 }
 
-/*
- * CPUID(0x2) parsing:
- */
-
-/**
- * cpuid_leaf_0x2() - Return sanitized CPUID(0x2) register output
- * @regs:	Output parameter
- *
- * Query CPUID(0x2) and store its output in @regs.  Force set any
- * invalid 1-byte descriptor returned by the hardware to zero (the NULL
- * cache/TLB descriptor) before returning it to the caller.
- *
- * Use for_each_cpuid_0x2_desc() to iterate over the register output in
- * parsed form.
- */
-static inline void cpuid_leaf_0x2(union leaf_0x2_regs *regs)
-{
-	cpuid_read(0x2, regs);
-
-	/*
-	 * All Intel CPUs must report an iteration count of 1.	In case
-	 * of bogus hardware, treat all returned descriptors as NULL.
-	 */
-	if (regs->desc[0] != 0x01) {
-		for (int i = 0; i < 4; i++)
-			regs->regv[i] = 0;
-		return;
-	}
-
-	/*
-	 * The most significant bit (MSB) of each register must be clear.
-	 * If a register is invalid, replace its descriptors with NULL.
-	 */
-	for (int i = 0; i < 4; i++) {
-		if (regs->reg[i].invalid)
-			regs->regv[i] = 0;
-	}
-}
-
-/**
- * for_each_cpuid_0x2_desc() - Iterator for parsed CPUID(0x2) descriptors
- * @_regs:	CPUID(0x2) register output, as returned by cpuid_leaf_0x2()
- * @_ptr:	u8 pointer, for macro internal use only
- * @_desc:	Pointer to the parsed CPUID(0x2) descriptor at each iteration
- *
- * Loop over the 1-byte descriptors in the passed CPUID(0x2) output registers
- * @_regs.  Provide the parsed information for each descriptor through @_desc.
- *
- * To handle cache-specific descriptors, switch on @_desc->c_type.  For TLB
- * descriptors, switch on @_desc->t_type.
- *
- * Example usage for cache descriptors::
- *
- *	const struct leaf_0x2_table *desc;
- *	union leaf_0x2_regs regs;
- *	u8 *ptr;
- *
- *	cpuid_leaf_0x2(&regs);
- *	for_each_cpuid_0x2_desc(regs, ptr, desc) {
- *		switch (desc->c_type) {
- *			...
- *		}
- *	}
- */
-#define for_each_cpuid_0x2_desc(_regs, _ptr, _desc)				\
-	for (_ptr = &(_regs).desc[1];						\
-	     _ptr < &(_regs).desc[16] && (_desc = &cpuid_0x2_table[*_ptr]);	\
-	     _ptr++)
-
 /*
  * CPUID(0x80000006) parsing:
  */
@@ -554,7 +485,7 @@ static inline bool cpuid_amd_hygon_has_l3_cache(void)
  */
 
 /**
- * for_each_parsed_cpuid_0x2_desc() - Iterator for parsed CPUID(0x2) descriptors
+ * for_each_cpuid_0x2_desc() - Iterator for parsed CPUID(0x2) descriptors
  * @_regs:   Leaf 0x2 register output, as returned by cpuid_leaf_regs()
  * @_ptr:  u8 pointer, for macro internal use only
  * @_desc:  Pointer to parsed descriptor information at each iteration
@@ -576,13 +507,13 @@ static inline bool cpuid_amd_hygon_has_l3_cache(void)
  *		// Handle error
  *	}
  *
- *	for_each_parsed_cpuid_0x2_desc(regs, ptr, desc) {
+ *	for_each_cpuid_0x2_desc(regs, ptr, desc) {
  *		switch (desc->c_type) {
  *			...
  *		}
  *	}
  */
-#define for_each_parsed_cpuid_0x2_desc(_regs, _ptr, _desc)				\
+#define for_each_cpuid_0x2_desc(_regs, _ptr, _desc)					\
 	for (({ static_assert(sizeof(*_regs) == sizeof(union leaf_0x2_regs)); }),	\
 	     _ptr = &((union leaf_0x2_regs *)(_regs))->desc[1];				\
 	     _ptr < &((union leaf_0x2_regs *)(_regs))->desc[16] && (_desc = &cpuid_0x2_table[*_ptr]);\
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 39cd6db4f702..f837ccdec116 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -389,7 +389,7 @@ static void intel_cacheinfo_0x2(struct cpuinfo_x86 *c)
 	if (!regs)
 		return;
 
-	for_each_parsed_cpuid_0x2_desc(regs, ptr, desc) {
+	for_each_cpuid_0x2_desc(regs, ptr, desc) {
 		switch (desc->c_type) {
 		case CACHE_L1_INST:	l1i += desc->c_size; break;
 		case CACHE_L1_DATA:	l1d += desc->c_size; break;
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 5eab9135b144..06c249110c8b 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -717,7 +717,7 @@ static void intel_detect_tlb(struct cpuinfo_x86 *c)
 	if (!regs)
 		return;
 
-	for_each_parsed_cpuid_0x2_desc(regs, ptr, desc)
+	for_each_cpuid_0x2_desc(regs, ptr, desc)
 		intel_tlb_lookup(desc);
 }
 
-- 
2.50.1


