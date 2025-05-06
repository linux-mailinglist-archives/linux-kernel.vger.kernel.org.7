Return-Path: <linux-kernel+bounces-635210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9CDAABA9C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 09:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693564E2F67
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 07:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB1B280008;
	Tue,  6 May 2025 05:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QDyR6YRU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r1gMDaMX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38C027FB31
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 05:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746507946; cv=none; b=O6P8X4wd6pGEN0tvnGKPkC3p1aubSx0wg+lpRnAHfPd+yNFD+4QaT+hE/wEPTew3YiaDR0PP0uzDSA6+2aBpfJduwd81e/JWnZAwi6cc9ZNT+65O3q2ciZ7ZbR47RXINizzBro4c5YS3ogOuq1c88pQcCJZsSyuJ1tVt4+vlnHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746507946; c=relaxed/simple;
	bh=1XN3phajobW15W2zFz3vmQIWRaHtliNoU9pIjl5O6t8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=InkriWCsbCH0ZL0/qIDRQE0CbXsol8WIikN34ynQbcRHTLcITYCOi9dl4CMPADmh331Y3o/lFYeYwOrdZcOmEp32zVHEaPFQG9QzMA/CS5Xwnct/0Hqe40J+AqCYNs3ClzdYnDW/JrACZUOKnXOkNh4TdpGC7T/4WRK94pBS4zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QDyR6YRU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r1gMDaMX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746507943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sd0POY+V33Qa9VXLCiDdOhKdkmDV4YC4IwROUD7bFpY=;
	b=QDyR6YRUSHdH9Fmqsr/xodjQ/bLHvUMpevHpZUtP4SBmN2NA2MZyRq/gT8eIAB3gEwPf1V
	3YERHnulhamik+fu699Tps+PWUrqk6tqcCcd7S80Ps/xl3J3JI5k17mQBtV2CBXNvKS/Rw
	Xax4zQGPP944i7rUjs1hzX90PS4P+JM5Dab2fgmrILG8oce2h+0OZTAvNqG5gHLQT9v3Od
	VZOdwXLGSs91tg/3Q2Q6u7Q8QKihj0/Xu/3c/kMUnnEOqzQW3cFfAbIhqAspyoOz7Js/lV
	MfnaZFftUUBboF1v1sMaLlIccYJ5BWVBE2ORzAW4IPJ4EMr/KNt98i4KEWeMLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746507943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sd0POY+V33Qa9VXLCiDdOhKdkmDV4YC4IwROUD7bFpY=;
	b=r1gMDaMX8yt2EkAK4kQfGTeqtO7O/We0bbo3c5tkbaXBldFeD6F0nXJpZQXeQItcOLFJrH
	EzvsvUatFXwI+2DA==
To: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 19/26] x86/cacheinfo: Use scanned CPUID(0x4)
Date: Tue,  6 May 2025 07:04:30 +0200
Message-ID: <20250506050437.10264-20-darwi@linutronix.de>
In-Reply-To: <20250506050437.10264-1-darwi@linutronix.de>
References: <20250506050437.10264-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the Intel CPUID(0x4) cacheinfo logic to use scanned CPUID access
instead of issuing direct CPUID queries.

Since scanned CPUID access requires a cpuinfo_x86 reference, propagate it
down from <linux/cacheinfo.h>'s populate_cache_leaves() to all the
relevant functions.

Use the scanned CPUID access macro:

    cpudata_cpuid_nr_entries(c, 0x4)

to determine the number of Intel CPUID(0x4) cache leaves instead of
calling find_num_cache_leaves(), which issues direct CPUID queries.

Given that find_num_cache_leaves() is no longer needed for Intel code
paths, make it AMD-specific.  Rename it to amd_find_num_cache_leaves()
and remove its Intel CPUID(0x4) logic.  Adjust AMD paths accordingly.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 40 ++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 665f3b187964..9de75c8b76ff 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -252,38 +252,35 @@ static int amd_fill_cpuid4_info(int index, struct _cpuid4_info *id4)
 	return cpuid4_info_fill_done(id4, eax, ebx, ecx);
 }
 
-static int intel_fill_cpuid4_info(int index, struct _cpuid4_info *id4)
+static int intel_fill_cpuid4_info(struct cpuinfo_x86 *c, int index, struct _cpuid4_info *id4)
 {
-	union _cpuid4_leaf_eax eax;
-	union _cpuid4_leaf_ebx ebx;
-	union _cpuid4_leaf_ecx ecx;
-	u32 ignored;
+	const struct cpuid_regs *regs = cpudata_cpuid_index_regs(c, 0x4, index);
 
-	cpuid_count(4, index, &eax.full, &ebx.full, &ecx.full, &ignored);
-
-	return cpuid4_info_fill_done(id4, eax, ebx, ecx);
+	return cpuid4_info_fill_done(id4,
+				     (union _cpuid4_leaf_eax)(regs->eax),
+				     (union _cpuid4_leaf_ebx)(regs->ebx),
+				     (union _cpuid4_leaf_ecx)(regs->ecx));
 }
 
-static int fill_cpuid4_info(int index, struct _cpuid4_info *id4)
+static int fill_cpuid4_info(struct cpuinfo_x86 *c, int index, struct _cpuid4_info *id4)
 {
 	u8 cpu_vendor = boot_cpu_data.x86_vendor;
 
 	return (cpu_vendor == X86_VENDOR_AMD || cpu_vendor == X86_VENDOR_HYGON) ?
 		amd_fill_cpuid4_info(index, id4) :
-		intel_fill_cpuid4_info(index, id4);
+		intel_fill_cpuid4_info(c, index, id4);
 }
 
-static int find_num_cache_leaves(struct cpuinfo_x86 *c)
+static int amd_find_num_cache_leaves(struct cpuinfo_x86 *c)
 {
-	unsigned int eax, ebx, ecx, edx, op;
+	unsigned int eax, ebx, ecx, edx;
 	union _cpuid4_leaf_eax cache_eax;
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
+		ci->num_leaves = cpudata_cpuid_nr_entries(c, 0x4);
 
 	if (!ci->num_leaves)
 		return false;
@@ -434,7 +431,7 @@ static bool intel_cacheinfo_0x4(struct cpuinfo_x86 *c)
 		struct _cpuid4_info id4 = {};
 		int ret;
 
-		ret = intel_fill_cpuid4_info(i, &id4);
+		ret = intel_fill_cpuid4_info(c, i, &id4);
 		if (ret < 0)
 			continue;
 
@@ -618,13 +615,14 @@ int populate_cache_leaves(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *ci = this_cpu_ci->info_list;
+	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	u8 cpu_vendor = boot_cpu_data.x86_vendor;
 	struct amd_northbridge *nb = NULL;
 	struct _cpuid4_info id4 = {};
 	int idx, ret;
 
 	for (idx = 0; idx < this_cpu_ci->num_leaves; idx++) {
-		ret = fill_cpuid4_info(idx, &id4);
+		ret = fill_cpuid4_info(c, idx, &id4);
 		if (ret)
 			return ret;
 
-- 
2.49.0


