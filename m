Return-Path: <linux-kernel+bounces-802851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38186B45796
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33814174A64
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA53C35A28D;
	Fri,  5 Sep 2025 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ujxhTLcm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IlBGgObC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA793570DF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074613; cv=none; b=EULbyqibz6Ki+ZDhMbOc2LJBVldSkbaP8OKUEcty9Wad97Z6iLemHWazLr5DV6lTWBgVKz4rP/RqPt2wcgz1/eZlvZ/zCLYEOGkbo3HVT4B+1XbTtvuDMatbVvWjMeITJ4vb62O+ENHWlWxm7JnrMmdsFLbxbT7w9PayHgf5XeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074613; c=relaxed/simple;
	bh=O5cAbpiI+Tjmr4wDFGGhia3hX/6l83QzjiYacPX5AVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQ+BqDGOQJjrDlzZXhKKVKjbTezF08XVvXgXXIckvOiakVU0aS1ksnWEiIMKpU3a2wAJOxmb1JuFnZ2XoNtlJ6r8A9tBWu31U3sjhw2Z+eMzenfY2klQugRx0Cc6HpqcSfpddD/2TgQeqnrG6mea0dAuX8KF7bynoCQLtzwM2/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ujxhTLcm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IlBGgObC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757074610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cQoSw1nvlRzPsTiSlFXd+9t8QVcHNs1P2S1dYlYV6PQ=;
	b=ujxhTLcmZpFU3mTnbTnUoUZtVs02mmiudGxi9IVAMZoOK7EAmdbZ6/vOmWK+gws2nwBsdk
	s5T8fFZ8Dsf1SXrnVbIT6co8S/EzSFhfkpd5W2zFunH3BkjkOsPqhuYuR95Jcw1Ml0RuCt
	AHiN2hf/9FtsHQH/SjFv8ej0VPk78mKLjlJKpSnbf6K3C3cFtxvZPRBSVwl5xVK/WiaX9B
	M088P4l96N1Zj18mkZVE67OlXbWhnCF1lfr0l55B50xlhMp2bY+KUjmT+gztO55Bp9fpHD
	neNqyzJOCUYTXdoCTUbhjI3GZOltWS7MHmmcL9DCPxW71FKYA7Ahd7j1FfC1dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757074610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cQoSw1nvlRzPsTiSlFXd+9t8QVcHNs1P2S1dYlYV6PQ=;
	b=IlBGgObC4G10J1mwyAFMQkwZqfPLKf9tf4bC2w/mfbbt8rVzJ/YjTTqJexJT14xTzV5Gly
	/NV3mh8NzxOyEFDQ==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Sean Christopherson <seanjc@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v5 26/35] x86/cacheinfo: Use parsed CPUID(0x4)
Date: Fri,  5 Sep 2025 14:15:06 +0200
Message-ID: <20250905121515.192792-27-darwi@linutronix.de>
In-Reply-To: <20250905121515.192792-1-darwi@linutronix.de>
References: <20250905121515.192792-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the Intel cacheinfo code, use parsed CPUID(0x4) access instead of a
direct CPUID query.

Use the parsed CPUID API:

    cpuid_subleaf_count(c, 0x4)

to determine the number of CPUID(0x4) cache subleaves instead of calling
find_num_cache_leaves(), which uses direct CPUID(0x4) queries.

Since find_num_cache_leaves() is no longer needed for Intel code paths,
make it AMD-specific:

  - Rename it to amd_find_num_cache_leaves()
  - Remove its Intel CPUID(0x4) logic

Adjust the AMD code paths accordingly.

At intel_cacheinfo_0x4(), remove the max CPUID level check since
cpuid_subleaf_count(c, 0x4) will safely return zero if CPUID(0x4) is not
supported by the CPU.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 40 ++++++++++++++-------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index f6b093dd8416..76fa3a01a34b 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -252,16 +252,17 @@ static int amd_fill_cpuid4_info(int index, struct _cpuid4_info *id4)
 	return cpuid4_info_fill_done(id4, eax, ebx, ecx);
 }
 
-static int intel_fill_cpuid4_info(struct cpuinfo_x86 *unused, int index, struct _cpuid4_info *id4)
+static int intel_fill_cpuid4_info(struct cpuinfo_x86 *c, int index, struct _cpuid4_info *id4)
 {
-	union _cpuid4_leaf_eax eax;
-	union _cpuid4_leaf_ebx ebx;
-	union _cpuid4_leaf_ecx ecx;
-	u32 ignored;
+	const struct cpuid_regs *regs = cpuid_subleaf_n_raw(c, 0x4, index);
 
-	cpuid_count(4, index, &eax.full, &ebx.full, &ecx.full, &ignored);
+	if (!regs)
+		return -EIO;
 
-	return cpuid4_info_fill_done(id4, eax, ebx, ecx);
+	return cpuid4_info_fill_done(id4,
+				     (union _cpuid4_leaf_eax)(regs->eax),
+				     (union _cpuid4_leaf_ebx)(regs->ebx),
+				     (union _cpuid4_leaf_ecx)(regs->ecx));
 }
 
 static int fill_cpuid4_info(struct cpuinfo_x86 *c, int index, struct _cpuid4_info *id4)
@@ -273,17 +274,16 @@ static int fill_cpuid4_info(struct cpuinfo_x86 *c, int index, struct _cpuid4_inf
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
@@ -328,7 +328,7 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, u16 die_id)
 		 * Newer families: LLC ID is calculated from the number
 		 * of threads sharing the L3 cache.
 		 */
-		u32 llc_index = find_num_cache_leaves(c) - 1;
+		u32 llc_index = amd_find_num_cache_leaves(c) - 1;
 		struct _cpuid4_info id4 = {};
 
 		if (!amd_fill_cpuid4_info(llc_index, &id4))
@@ -353,7 +353,7 @@ void init_amd_cacheinfo(struct cpuinfo_x86 *c)
 	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(c->cpu_index);
 
 	if (boot_cpu_has(X86_FEATURE_TOPOEXT))
-		ci->num_leaves = find_num_cache_leaves(c);
+		ci->num_leaves = amd_find_num_cache_leaves(c);
 	else if (c->extended_cpuid_level >= 0x80000006)
 		ci->num_leaves = (cpuid_edx(0x80000006) & 0xf000) ? 4 : 3;
 }
@@ -362,7 +362,7 @@ void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
 {
 	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(c->cpu_index);
 
-	ci->num_leaves = find_num_cache_leaves(c);
+	ci->num_leaves = amd_find_num_cache_leaves(c);
 }
 
 static void intel_cacheinfo_done(struct cpuinfo_x86 *c, unsigned int l3,
@@ -426,15 +426,9 @@ static bool intel_cacheinfo_0x4(struct cpuinfo_x86 *c)
 	unsigned int l2_id = BAD_APICID, l3_id = BAD_APICID;
 	unsigned int l1d = 0, l1i = 0, l2 = 0, l3 = 0;
 
-	if (c->cpuid_level < 4)
-		return false;
-
-	/*
-	 * There should be at least one leaf. A non-zero value means
-	 * that the number of leaves has been previously initialized.
-	 */
+	/* Non-zero means that it has been previously initialized */
 	if (!ci->num_leaves)
-		ci->num_leaves = find_num_cache_leaves(c);
+		ci->num_leaves = cpuid_subleaf_count(c, 0x4);
 
 	if (!ci->num_leaves)
 		return false;
-- 
2.50.1


