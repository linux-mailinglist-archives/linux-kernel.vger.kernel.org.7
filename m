Return-Path: <linux-kernel+bounces-770338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D508EB279BD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9893B65AF1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22F12D372F;
	Fri, 15 Aug 2025 07:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OBYZpJHU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="alQYVgNu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A1A2F066F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755241585; cv=none; b=LgcaWVaDBGOYPnUCd2oOTJVOSR1FmpeDxtjKyUefJ2n1lwAcHmc1EBRftu1ZFW+9n/JCygFX2WjDbtFCw/ABw8vI3YbGRjn0V7JbJieZIAhsAitIx7KFeGNXfXpgMew15OKy+4VBgL2WbKITkDdgMhHSTiHvn0Q+8UGWuJ+Q01o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755241585; c=relaxed/simple;
	bh=DZaNyXZwF6QJrY7kYXtD41G19i6Aj2kj2FFuvkzGCtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EtsY6VRereQf+Dgew2gCyHsrIJIJ4HLkqd7G30YfASMTlqbCX++ie48Q1XAQ2ACowaz+3xjvgL4uBhkxVGGWnhiHwI2Da2RI4q9GMK5a2zK89whKAAC9H8TBT5xtM2ofGWuWnxw9trehNcQ6X80mbN7eXbCwNDg5asF+SVv/DpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OBYZpJHU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=alQYVgNu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755241581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ck8n2iu9wBuqWyXuhhdwn6cyyCj6+svMidjYuMlpF5Y=;
	b=OBYZpJHUI1FnXJRpJObZorINiU7mIxZC03F+c2C/mx2jYEq14Sb+6M45mWM0yjYpMPzjia
	3Us2AfoV8MUteowSD5UBq0Hs7FcHmIh2uRbb4tCL2kkVYmbCVq4X8WLTpVzbqcN4SNxusw
	oIZhwHDkXJgSgWWvsCLZ6/sZkGgsJ6KefltsC8qkCdd5f8TqEPpriblIMwRD6SLdpGS0K2
	SP14q/lHmT2wOkTg8If4dLALL0pEjILOImYDs09vpV1UhsA1y9jFnXdpnEcTgsg1G5KXFU
	QC5+7m1nuj97wPaldC/lY0mjSESu5jMjGq0GPunmg/KtaXadQIsDOS6R3XeXCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755241581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ck8n2iu9wBuqWyXuhhdwn6cyyCj6+svMidjYuMlpF5Y=;
	b=alQYVgNuG9QI/SJuWyZ0WPtE3vqeLWWzm+uKce090nXkNmF2J6UAv57CCbnWfSXRdvLPFz
	ReMGgtJUfFZOlyDw==
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
Subject: [PATCH v4 25/34] x86/cacheinfo: Use parsed CPUID(0x8000001d)
Date: Fri, 15 Aug 2025 09:02:18 +0200
Message-ID: <20250815070227.19981-26-darwi@linutronix.de>
In-Reply-To: <20250815070227.19981-1-darwi@linutronix.de>
References: <20250815070227.19981-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the AMD CPUID(0x8000001d) cacheinfo logic to use the parsed
CPUID API instead of issuing direct CPUID queries.

Beside CPUID data centralization benefits, this allows using the
auto-generated <cpuid/leaf_types.h> 'struct cpuid_0x8000001d_0' data type
with its full C99 bitfields instead of doing ugly bitwise operations.

Since parsed CPUID access requires a 'struct cpuinfo_x86' reference,
trickle it down to relevant functions.

Use the parsed CPUID API:

    cpuid_subleaf_count(c, 0x8000001d)

to find the number of cache leaves, thus replacing
amd_find_num_cache_leaves() and its direct CPUID queries.  Drop that
function entirely as it is no longer needed.

For now, keep using the 'union _cpuid4_leaf_eax/ebx/ecx' structures as
they are required by the AMD CPUID(0x4) emulation code paths.  A follow
up commit will replace them with <cpuid/leaf_types.h> equivalents.

Note, for below code:

    cpuid_count(0x8000001d, llc_index, &eax, &ebx, &ecx, &edx);
    if (eax)
        num_sharing_cache = ((eax >> 14) & 0xfff) + 1;

    if (num_sharing_cache) {
        int index_msb = get_count_order(num_sharing_cache);
        ...
    }

it is replaced with:

    const struct leaf_0x8000001d_0 *leaf =
        cpuid_subleaf_index(c, 0x8000001d, llc_index);

    if (leaf) {
        int index_msb = get_count_order(l->num_threads_sharing + 1);
        ...
    }

The "if (leaf)" check is sufficient since the parsed CPUID API returns
NULL if the leaf is out of range (> max CPU extended leaf) or if the
'llc_index' is out of range.  An out of range LLC index is equivalent to
"EAX.cache_type == 0" in the original code, making the logic match.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 47 +++++++++++----------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 07f0883f9fbe..05a3fbd0d849 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -237,16 +237,19 @@ static int cpuid4_info_fill_done(struct _cpuid4_info *id4, union _cpuid4_leaf_ea
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
+		const struct cpuid_regs *regs = cpuid_subleaf_index_regs(c, 0x8000001d, index);
+
+		eax.full = regs->eax;
+		ebx.full = regs->ebx;
+		ecx.full = regs->ecx;
+	} else
 		legacy_amd_cpuid4(index, &eax, &ebx, &ecx);
 
 	return cpuid4_info_fill_done(id4, eax, ebx, ecx);
@@ -267,25 +270,10 @@ static int fill_cpuid4_info(struct cpuinfo_x86 *c, int index, struct _cpuid4_inf
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
  * AMD/Hygon CPUs may have multiple LLCs if L3 caches exist.
  */
@@ -309,15 +297,12 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, u16 die_id)
 		 * Newer families: LLC ID is calculated from the number
 		 * of threads sharing the L3 cache.
 		 */
-		u32 eax, ebx, ecx, edx, num_sharing_cache = 0;
-		u32 llc_index = amd_find_num_cache_leaves(c) - 1;
-
-		cpuid_count(0x8000001d, llc_index, &eax, &ebx, &ecx, &edx);
-		if (eax)
-			num_sharing_cache = ((eax >> 14) & 0xfff) + 1;
+		u32 llc_index = cpuid_subleaf_count(c, 0x8000001d) - 1;
+		const struct leaf_0x8000001d_0 *leaf =
+			cpuid_subleaf_index(c, 0x8000001d, llc_index);
 
-		if (num_sharing_cache) {
-			int index_msb = get_count_order(num_sharing_cache);
+		if (leaf) {
+			int index_msb = get_count_order(leaf->num_threads_sharing + 1);
 
 			c->topo.llc_id = c->topo.apicid >> index_msb;
 		}
@@ -341,7 +326,7 @@ void init_amd_cacheinfo(struct cpuinfo_x86 *c)
 	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(c->cpu_index);
 
 	if (boot_cpu_has(X86_FEATURE_TOPOEXT))
-		ci->num_leaves = amd_find_num_cache_leaves(c);
+		ci->num_leaves = cpuid_subleaf_count(c, 0x8000001d);
 	else if (c->extended_cpuid_level >= 0x80000006)
 		ci->num_leaves = (cpuid_edx(0x80000006) & 0xf000) ? 4 : 3;
 }
@@ -350,7 +335,7 @@ void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
 {
 	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(c->cpu_index);
 
-	ci->num_leaves = amd_find_num_cache_leaves(c);
+	ci->num_leaves = cpuid_subleaf_count(c, 0x8000001d);
 }
 
 static void intel_cacheinfo_done(struct cpuinfo_x86 *c, unsigned int l3,
-- 
2.50.1


