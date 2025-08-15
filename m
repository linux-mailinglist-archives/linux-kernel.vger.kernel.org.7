Return-Path: <linux-kernel+bounces-770337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A294CB279BC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF405C5F64
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA452EAB8A;
	Fri, 15 Aug 2025 07:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k3a/CrTB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aDzYZi+C"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7F82ECEBD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755241581; cv=none; b=RLzIVmJRgw02a+cMiWFQxX2Au7mTtjihjLlBWVEXt+V/y5MHMz2Xu34AVlAaUTIrx2z5mGfn/EacNwDp3u00t8k7i8TYt5MhWpq3TFn9HI80ieE+xcIw5Q5vYF4EuAo9+l0tmLYPKJvGO3YLfte7ekZex3+7nCORRY8aG9vNC1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755241581; c=relaxed/simple;
	bh=1bQLfxXqh1CwSbXgVMwxFWBKJRDveyXkZBq3qbFKTzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g39qVESxmt5t8GO71xiQH+TsI6NrifdnRXli687hwmSf327wETlF+LbQaOQA/BpCZrQkCUB7D1V9Zv0grvwvi1yeI0ifR1029j5hVi4uNk+zerK5jTQmxWGG9sEFjjDlUExVXLm8T/LnDKwfka+YeEq8IGj+Wo+Lz+Rl8yuT7CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k3a/CrTB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aDzYZi+C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755241578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Noe1a4ffiSo4b1qvItz/7pAR08IUgOzYvkqRHJ67WY=;
	b=k3a/CrTBn9EUD2azdQbHPg8mSERZxNi7ZOB8U/L5f3y1bsWWWGrDccFMynIGU+o1PEhA/b
	54txAeMvyH/vKiAsxCzI3aGwxsYyPASn07Iqt6Y1Q1h9eDvmGEouhDnEPikcVk34ZLoImM
	DH1eDrXwsAl6EFhq6zNYqqbXd/jjIHSuutd+I4N592EkFjBxoOSNGi/691GHsly7RTFpn4
	rnG2Jh1xX9laWJUneiTx2VF5lanf6HhPE9ExLVHiP0vrurX9vIAqrHuToDT7o0wY+V9AHZ
	xKioJ8Z24G7lLP7iyrXsfmXnvyL5y95ezmsvRHIj2yTnLDVZH1hJIIUQLwGGQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755241578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Noe1a4ffiSo4b1qvItz/7pAR08IUgOzYvkqRHJ67WY=;
	b=aDzYZi+ClVBy/8mscwbmxf6coLB8zjFYwnvrGt2j8mKORzYlMbuTBn1thPzPY9lMrgWdvO
	8WVzicliv6WbmDAw==
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
Subject: [PATCH v4 24/34] x86/cacheinfo: Use parsed CPUID(0x4)
Date: Fri, 15 Aug 2025 09:02:17 +0200
Message-ID: <20250815070227.19981-25-darwi@linutronix.de>
In-Reply-To: <20250815070227.19981-1-darwi@linutronix.de>
References: <20250815070227.19981-1-darwi@linutronix.de>
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
2.50.1


