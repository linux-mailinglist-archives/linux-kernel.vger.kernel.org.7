Return-Path: <linux-kernel+bounces-802852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DC8B45798
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85AF23A3541
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD38735A2A4;
	Fri,  5 Sep 2025 12:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qbkCzjYh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z5zpEl1+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A5A35A292
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074616; cv=none; b=UpA4kjfOgBrIZZhzJ66ja5ZVdkeksAiwWx8/MxyRMVHYPctvez+JWtpP6MZ094SsuzorqxUFDF35nUObMRyOF4/vfKLbSjk05Y/rl/qhote/w+6t6jJ9vFoDqtPz5qOdRR+BQDNYaY5MLnT7Dpf4hOwoNh0SgSUntwtLwcA0LtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074616; c=relaxed/simple;
	bh=rl+gbmlu1pyJb67mFYgrlr5iqNCPYrnKVRwsxOXXLyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CA8EjueZdu8O+Ev9IL6Ry0OydFwyC5YNDUCXfEFaPSAlEAnpkV3GegUOHLYRUM27GnW6sGqyjMLW7R2ct4fQ+/3FMbOer6jhT7kJSkSInm9bO7d35ncvMEUdFof5OkKWXA3AzZwi7q7bazQEvTzlM+pH48j9jhtXoBvcVYVM8Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qbkCzjYh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z5zpEl1+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757074613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LVDTwm7Ah9FpA/qSB7MLWK6yLm0D5mM1+yK2R8vnyDs=;
	b=qbkCzjYhVkIgyms/ETYOqRcPJGxHYtPP//5+pcT3B4pqPiz/vv4TBLcsEUkZAGQJDMmhUC
	mR0le1Qtam6ABGSOFXRfrtJFLWqe/cGWNGY7lawiCH3O1MvIvxe9RCQvQX80tAMP+XgR4Y
	WSFDyZBDRN40SEqNst5ggfIqxcAnPjqaFRCPGrWuKCdiEjfMpYXRavU2LxvRo1fZAf3lg9
	vi+gmjExOaRONaz/J+LNwpheW4k/nSiEHsvFo0NSVFZ3HTS1lr55rpPw2B52Oj3QNmuMCS
	AV4CIF2sLXJdErnGoOQG0rUM8RRfrm6ALVTjVCEPHZKzsxrGwd+8uypzApAIlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757074613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LVDTwm7Ah9FpA/qSB7MLWK6yLm0D5mM1+yK2R8vnyDs=;
	b=Z5zpEl1+eIxie4ScE4+ki0QH8Q+x7iejJdlG1Tv61V8XOExwXRA0LvF8Ycoo3hwGHCZ4Pn
	ROQ/Be5D1+Y9RaDg==
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
Subject: [PATCH v5 27/35] x86/cacheinfo: Use parsed CPUID(0x8000001d)
Date: Fri,  5 Sep 2025 14:15:07 +0200
Message-ID: <20250905121515.192792-28-darwi@linutronix.de>
In-Reply-To: <20250905121515.192792-1-darwi@linutronix.de>
References: <20250905121515.192792-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the AMD cacheinfo code, use parsed CPUID(0x8000001d) access instead of
issuing direct CPUID queries.

Beside the CPUID parser centralization benefits, this allows using the
auto-generated <asm/cpuid/leaf_types.h> data types, and their full C99
bitfields, instead of doing ugly bitwise operations on CPUID register
output.

Since parsed CPUID access requires a 'struct cpuinfo_x86' reference,
trickle it down to relevant functions.

Use the parsed CPUID API:

    cpuid_subleaf_count(c, 0x8000001d)

to find the number of cache leaves, replacing amd_find_num_cache_leaves()
and its direct CPUID queries.  Drop that function completely as it is no
longer needed.

For now, keep using the 'union _cpuid4_leaf_eax/ebx/ecx' structures as
they are required by the AMD CPUID(0x4) emulation code paths.  A follow
up commit will replace them with their auto-generated equivalents.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 41 +++++++++++++--------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 76fa3a01a34b..3e1ccab56e4c 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -237,16 +237,22 @@ static int cpuid4_info_fill_done(struct _cpuid4_info *id4, union _cpuid4_leaf_ea
 	return 0;
 }
 
-static int amd_fill_cpuid4_info(int index, struct _cpuid4_info *id4)
+static int amd_fill_cpuid4_info(struct cpuinfo_x86 *c, int index, struct _cpuid4_info *id4)
 {
 	union _cpuid4_leaf_eax eax;
 	union _cpuid4_leaf_ebx ebx;
 	union _cpuid4_leaf_ecx ecx;
-	u32 ignored;
 
-	if (boot_cpu_has(X86_FEATURE_TOPOEXT) || boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
-		cpuid_count(0x8000001d, index, &eax.full, &ebx.full, &ecx.full, &ignored);
-	else
+	if (boot_cpu_has(X86_FEATURE_TOPOEXT) || boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
+		const struct cpuid_regs *regs = cpuid_subleaf_n_raw(c, 0x8000001d, index);
+
+		if (!regs)
+			return -EIO;
+
+		eax.full = regs->eax;
+		ebx.full = regs->ebx;
+		ecx.full = regs->ecx;
+	} else
 		legacy_amd_cpuid4(index, &eax, &ebx, &ecx);
 
 	return cpuid4_info_fill_done(id4, eax, ebx, ecx);
@@ -270,25 +276,10 @@ static int fill_cpuid4_info(struct cpuinfo_x86 *c, int index, struct _cpuid4_inf
 	u8 cpu_vendor = boot_cpu_data.x86_vendor;
 
 	return (cpu_vendor == X86_VENDOR_AMD || cpu_vendor == X86_VENDOR_HYGON) ?
-		amd_fill_cpuid4_info(index, id4) :
+		amd_fill_cpuid4_info(c, index, id4) :
 		intel_fill_cpuid4_info(c, index, id4);
 }
 
-static int amd_find_num_cache_leaves(struct cpuinfo_x86 *c)
-{
-	union _cpuid4_leaf_eax cache_eax;
-	unsigned int eax, ebx, ecx, edx;
-	int i = -1;
-
-	/* Do a CPUID(0x8000001d) loop to calculate num_cache_leaves */
-	do {
-		++i;
-		cpuid_count(0x8000001d, i, &eax, &ebx, &ecx, &edx);
-		cache_eax.full = eax;
-	} while (cache_eax.split.type != CTYPE_NULL);
-	return i;
-}
-
 /*
  * The max shared threads number comes from CPUID(0x4) EAX[25-14] with input
  * ECX as cache index. Then right shift apicid by the number's order to get
@@ -328,10 +319,10 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, u16 die_id)
 		 * Newer families: LLC ID is calculated from the number
 		 * of threads sharing the L3 cache.
 		 */
-		u32 llc_index = amd_find_num_cache_leaves(c) - 1;
+		u32 llc_index = cpuid_subleaf_count(c, 0x8000001d) - 1;
 		struct _cpuid4_info id4 = {};
 
-		if (!amd_fill_cpuid4_info(llc_index, &id4))
+		if (!amd_fill_cpuid4_info(c, llc_index, &id4))
 			c->topo.llc_id = get_cache_id(c->topo.apicid, &id4);
 	}
 }
@@ -353,7 +344,7 @@ void init_amd_cacheinfo(struct cpuinfo_x86 *c)
 	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(c->cpu_index);
 
 	if (boot_cpu_has(X86_FEATURE_TOPOEXT))
-		ci->num_leaves = amd_find_num_cache_leaves(c);
+		ci->num_leaves = cpuid_subleaf_count(c, 0x8000001d);
 	else if (c->extended_cpuid_level >= 0x80000006)
 		ci->num_leaves = (cpuid_edx(0x80000006) & 0xf000) ? 4 : 3;
 }
@@ -362,7 +353,7 @@ void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
 {
 	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(c->cpu_index);
 
-	ci->num_leaves = amd_find_num_cache_leaves(c);
+	ci->num_leaves = cpuid_subleaf_count(c, 0x8000001d);
 }
 
 static void intel_cacheinfo_done(struct cpuinfo_x86 *c, unsigned int l3,
-- 
2.50.1


