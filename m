Return-Path: <linux-kernel+bounces-675012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F29BFACF7E6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 21:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946543A8317
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 19:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661722820D3;
	Thu,  5 Jun 2025 19:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t1Dee47B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rb5VgdgK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7692820C2
	for <linux-kernel@vger.kernel.org>; Thu,  5 Jun 2025 19:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749151515; cv=none; b=Sv3duJGCRnv/1SwSmAB1cvo8cJrb45iCKXCzZmnfol7Hgv4WP+ve5dDH3gR1KVK4xaO28ulUciD4kiFet3eu52MPF65/7IV+hmF3OxYCgML0nhGzjBbh2KFxiPut4Tz5i+UoiuMTNiPl96Mj2Tq1ye6zJx0ddBjYAnoEBYF1DI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749151515; c=relaxed/simple;
	bh=EbfwzJoyPeSWcXCnGLgeZ+nY1PlcXpzd7l86nm+NKwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2Z7T99TI/sQ8cQ5hzuXRZ8/2KbN8z6iJSozHm4V/QdhTPVhLv5iHU+AxUJP9PfzPAjoxeyTnZ4IcB0bFnb8ztqSHcinr3rKLMkKQI9wadziLK1YXSGO+CtDXRSnpgwqPjRlrXD6wIAJSyrAoQLlXdw709aV578v8QHVJEBnP1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t1Dee47B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rb5VgdgK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749151512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9tsVcjRsrmz5t1HharsE0QO5QjInb35V8lQCspKnDVw=;
	b=t1Dee47BGS7nDiyd4IRLmpCVvZmmvUfwghKYc3u1CoxB+B8nEgzhkfTY26h9d2/wTB4Bf6
	mIlj7SH0YHSRHuavSmX3pU2ApH7iNBMSydSmMY1h+ea/AqbN92Bv3GPq1M5qnsM3xpKT92
	EJz6KpVJ1yVNK09tjaPvuCAe0exiqn9FMtP/FcjeIGjiU1HQP2gTG8P785uvK4927n/2PN
	VGzPwcadNmwqFjf4e43/ttr4kro1Q8rfWWUHwUnzcty6UWS6FymX1mOv8zzhEyZiWbUDCd
	5sUvMpJ2Mj7WrnvqdlgqbGBr9jhqtjS55R56RMlrvLQ4z19LSPr54SD0z6yisw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749151512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9tsVcjRsrmz5t1HharsE0QO5QjInb35V8lQCspKnDVw=;
	b=rb5VgdgK9mL7xgMDoytHicFdi7dh3izRxqHCRaxgB8P0J7hAk4Zjxkw7zEls6RHBxeq9Ox
	/BqeqYktawEfTTBA==
To: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v2 20/27] x86/cacheinfo: Use parsed CPUID(0x4)
Date: Thu,  5 Jun 2025 21:23:49 +0200
Message-ID: <20250605192356.82250-21-darwi@linutronix.de>
In-Reply-To: <20250605192356.82250-1-darwi@linutronix.de>
References: <20250605192356.82250-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the Intel CPUID(0x4) cacheinfo logic to use parsed CPUID access
instead of issuing direct CPUID queries.

Use the parsed CPUID access macro:

    cpuid_subleaf_count(c, 0x4)

to determine the number of Intel CPUID(0x4) cache leaves instead of
calling find_num_cache_leaves(), which internally issues direct CPUID
queries.

Since find_num_cache_leaves() is no longer needed for Intel code paths,
make it AMD-specific.  Rename it to amd_find_num_cache_leaves() and
remove its Intel CPUID(0x4) logic.  Adjust the AMD paths accordingly.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 0ed5dd6d29ef..07f0883f9fbe 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -252,16 +252,14 @@ static int amd_fill_cpuid4_info(int index, struct _cpuid4_info *id4)
 	return cpuid4_info_fill_done(id4, eax, ebx, ecx);
 }
 
-static int intel_fill_cpuid4_info(struct cpuinfo_x86 *unused, int index, struct _cpuid4_info *id4)
+static int intel_fill_cpuid4_info(struct cpuinfo_x86 *c, int index, struct _cpuid4_info *id4)
 {
-	union _cpuid4_leaf_eax eax;
-	union _cpuid4_leaf_ebx ebx;
-	union _cpuid4_leaf_ecx ecx;
-	u32 ignored;
-
-	cpuid_count(4, index, &eax.full, &ebx.full, &ecx.full, &ignored);
+	const struct cpuid_regs *regs = cpuid_subleaf_index_regs(c, 0x4, index);
 
-	return cpuid4_info_fill_done(id4, eax, ebx, ecx);
+	return cpuid4_info_fill_done(id4,
+				     (union _cpuid4_leaf_eax)(regs->eax),
+				     (union _cpuid4_leaf_ebx)(regs->ebx),
+				     (union _cpuid4_leaf_ecx)(regs->ecx));
 }
 
 static int fill_cpuid4_info(struct cpuinfo_x86 *c, int index, struct _cpuid4_info *id4)
@@ -273,17 +271,16 @@ static int fill_cpuid4_info(struct cpuinfo_x86 *c, int index, struct _cpuid4_inf
 		intel_fill_cpuid4_info(c, index, id4);
 }
 
-static int find_num_cache_leaves(struct cpuinfo_x86 *c)
+static int amd_find_num_cache_leaves(struct cpuinfo_x86 *c)
 {
-	unsigned int eax, ebx, ecx, edx, op;
 	union _cpuid4_leaf_eax cache_eax;
+	unsigned int eax, ebx, ecx, edx;
 	int i = -1;
 
-	/* Do a CPUID(op) loop to calculate num_cache_leaves */
-	op = (c->x86_vendor == X86_VENDOR_AMD || c->x86_vendor == X86_VENDOR_HYGON) ? 0x8000001d : 4;
+	/* Do a CPUID(0x8000001d) loop to calculate num_cache_leaves */
 	do {
 		++i;
-		cpuid_count(op, i, &eax, &ebx, &ecx, &edx);
+		cpuid_count(0x8000001d, i, &eax, &ebx, &ecx, &edx);
 		cache_eax.full = eax;
 	} while (cache_eax.split.type != CTYPE_NULL);
 	return i;
@@ -313,7 +310,7 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, u16 die_id)
 		 * of threads sharing the L3 cache.
 		 */
 		u32 eax, ebx, ecx, edx, num_sharing_cache = 0;
-		u32 llc_index = find_num_cache_leaves(c) - 1;
+		u32 llc_index = amd_find_num_cache_leaves(c) - 1;
 
 		cpuid_count(0x8000001d, llc_index, &eax, &ebx, &ecx, &edx);
 		if (eax)
@@ -344,7 +341,7 @@ void init_amd_cacheinfo(struct cpuinfo_x86 *c)
 	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(c->cpu_index);
 
 	if (boot_cpu_has(X86_FEATURE_TOPOEXT))
-		ci->num_leaves = find_num_cache_leaves(c);
+		ci->num_leaves = amd_find_num_cache_leaves(c);
 	else if (c->extended_cpuid_level >= 0x80000006)
 		ci->num_leaves = (cpuid_edx(0x80000006) & 0xf000) ? 4 : 3;
 }
@@ -353,7 +350,7 @@ void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
 {
 	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(c->cpu_index);
 
-	ci->num_leaves = find_num_cache_leaves(c);
+	ci->num_leaves = amd_find_num_cache_leaves(c);
 }
 
 static void intel_cacheinfo_done(struct cpuinfo_x86 *c, unsigned int l3,
@@ -425,7 +422,7 @@ static bool intel_cacheinfo_0x4(struct cpuinfo_x86 *c)
 	 * that the number of leaves has been previously initialized.
 	 */
 	if (!ci->num_leaves)
-		ci->num_leaves = find_num_cache_leaves(c);
+		ci->num_leaves = cpuid_subleaf_count(c, 0x4);
 
 	if (!ci->num_leaves)
 		return false;
-- 
2.49.0


