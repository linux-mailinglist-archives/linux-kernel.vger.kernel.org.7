Return-Path: <linux-kernel+bounces-770343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4ECB279CA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA465C7F1C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987FE2F60AB;
	Fri, 15 Aug 2025 07:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EEwjOhjR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0OU7cMKE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A432F5486
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755241604; cv=none; b=LGRr4Uq4PVxhWE5QvRIKljKbWqpr4rRBf7LTMsogqwE9zX1+mEt+MZyMcbUJbJsOLPZfEn/XL9ashnFPCXa1aRNhIuGUEAisOLxiYtTyt9IUUQDjyg4vnv8upHejypbS8bg2qqjKcrsMu8gEwYw4LtYr524umYM+FiA4EKOG9zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755241604; c=relaxed/simple;
	bh=x5qUMW4GdlHy0LzY544cVlmo8eWHiePuSyCNxjssRmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9E3sky/MVdun5dIPoD/EallcZjIH5nyyqHp8H4T+kSwMaFOIsRNXbMTGFaP2fYE5GYJySYNkuF3nrMpBdusvk6QR8EMnvfqTFzMcwZ9LRe5ZyEXo2R9cz59sBPWJov4/YR58MPiwEKZ4FhfPl1ULqRRrcPQ/aJud3OXRJQV8qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EEwjOhjR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0OU7cMKE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755241600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VI3pBTP8Fjxnacw5/XwagN7sVbZPPDUg06qzVEnLfao=;
	b=EEwjOhjRDun4/Op48j7WI2XghxYxX0ctzg4nUGO3ftmP9V4PIQMDYFAI9feHN4EjncezpZ
	xT2LBII85mqX+C9QOioCVl3GtJyOMV97F9NJiKg7OrF/oHLg5G/KMgIIS6UZribnuP3K3d
	OHiLvH6WMa5eHGGwK2X/iZYeHWbj3ACiXpSBGxHBghymgrGtCjTp2kes/eK7MtEoAcCb3t
	PWk3h46AcDZAokcQiWdTxJ+LB8cCze0LBabtVxWA2PiU6gGTPawAI7v/fjkt2G5IqN5NDY
	Yc59HB5+Zo03uP2Qtbg1/AkwtdVMjV/iCqIkNU1WatDswaEh4hD9R9wUawjJmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755241600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VI3pBTP8Fjxnacw5/XwagN7sVbZPPDUg06qzVEnLfao=;
	b=0OU7cMKEB6zIOfAVjVXIRau51vMk8fv5Y4+8rikQPqcTyzfWRy0U12pho+q4i2jR/yJbA1
	5aJHAVS99aEyQeCA==
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
Subject: [PATCH v4 30/34] x86/cpuid: Use parsed CPUID(0x80000006)
Date: Fri, 15 Aug 2025 09:02:23 +0200
Message-ID: <20250815070227.19981-31-darwi@linutronix.de>
In-Reply-To: <20250815070227.19981-1-darwi@linutronix.de>
References: <20250815070227.19981-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For cpuid_amd_hygon_has_l3_cache(), use parsed CPUID access instead of a
direct CPUID query.  The new API offers centralization benefits and
avoids bit fiddling at call sites.

For testing L3 cache availability, just check if the EDX.l3_assoc output
is not zero.  Per AMD manuals, an L3 associativity of zero implies the
absence of an L3 cache on the CPU.

Note, since this function is now using parsed CPUID API, move it under
the <cpuid/api.h> section: 'Convenience leaf-specific functions (using
parsed CPUID data)'

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/cpuid/api.h | 18 +++++++++---------
 arch/x86/kernel/amd_nb.c         |  2 +-
 arch/x86/kernel/cpu/cacheinfo.c  |  6 +++---
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index 146498d5dbfa..d4e50e394e0b 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -213,15 +213,6 @@ static inline u32 cpuid_base_hypervisor(const char *sig, u32 leaves)
 	return 0;
 }
 
-/*
- * CPUID(0x80000006) parsing:
- */
-
-static inline bool cpuid_amd_hygon_has_l3_cache(void)
-{
-	return cpuid_edx(0x80000006);
-}
-
 /*
  * 'struct cpuid_leaves' accessors:
  *
@@ -519,6 +510,15 @@ static inline bool cpuid_amd_hygon_has_l3_cache(void)
 	     _ptr < &((union leaf_0x2_regs *)(_regs))->desc[16] && (_desc = &cpuid_0x2_table[*_ptr]);\
 	     _ptr++)
 
+/*
+ * CPUID(0x80000006)
+ */
+
+static inline bool cpuid_amd_hygon_has_l3_cache(struct cpuinfo_x86 *c)
+{
+	return cpuid_leaf(c, 0x80000006)->l3_assoc;
+}
+
 /*
  * CPUID parser exported APIs:
  */
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index a8809778b208..a5d022e15a6b 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -94,7 +94,7 @@ static int amd_cache_northbridges(struct cpuinfo_x86 *c)
 	if (amd_gart_present())
 		amd_northbridges.flags |= AMD_NB_GART;
 
-	if (!cpuid_amd_hygon_has_l3_cache())
+	if (!cpuid_amd_hygon_has_l3_cache(c))
 		return 0;
 
 	/*
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index de8e7125eedd..dc28ffdbdc7f 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -210,7 +210,7 @@ static int fill_cpuid4_info(struct cpuinfo_x86 *c, int index, struct _cpuid4_inf
 
 void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, u16 die_id)
 {
-	if (!cpuid_amd_hygon_has_l3_cache())
+	if (!cpuid_amd_hygon_has_l3_cache(c))
 		return;
 
 	if (c->x86 < 0x17) {
@@ -241,7 +241,7 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, u16 die_id)
 
 void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c)
 {
-	if (!cpuid_amd_hygon_has_l3_cache())
+	if (!cpuid_amd_hygon_has_l3_cache(c))
 		return;
 
 	/*
@@ -257,7 +257,7 @@ void init_amd_cacheinfo(struct cpuinfo_x86 *c)
 
 	ci->num_leaves = boot_cpu_has(X86_FEATURE_TOPOEXT) ?
 		cpuid_subleaf_count(c, 0x8000001d) :
-		cpuid_leaf(c, 0x80000006)->l3_assoc ? 4 : 3;
+		cpuid_amd_hygon_has_l3_cache(c) ? 4 : 3;
 }
 
 void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
-- 
2.50.1


