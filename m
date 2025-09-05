Return-Path: <linux-kernel+bounces-802856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40D8B457A0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E54CB5C3A87
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A90534DCFB;
	Fri,  5 Sep 2025 12:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dqTViZY5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WrRW7DsB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF0635CEA6
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074628; cv=none; b=qCK98tSyiEOHg7YEZrLG18nx/fgWVoa01Syg6wqTiwpWX2YjYFWG4GNcxmsuvRvMeu/fUF5EvVk8BFxopXxwsb8psAL+SaQZL+MrYwcgKalhWwGFO2088jbuz3Kb/wMGPCag018DQffIYDPtgh1GR1vcODFDl3DDU9Ai3JF4UBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074628; c=relaxed/simple;
	bh=pBJyRvgNQt474dIEuzA+OkD8yRjaAJyG8hxAgB4pNug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ipd7tScFUpDBUu6np9svzgkxJ0AFt0rD3gITR5WBFHCBI0VZpcVwYojKF4BH4SEH7TSohoocxHa9Jsmt3lvM85JPLr5EqRN+6lLYtbnYCYe+ymjsB3IX4+syjTLmU/UJvTDndaUNnDk0tOfEj4UHh0HjVpFhnwFGzueNoNB+6Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dqTViZY5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WrRW7DsB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757074625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7UH1ADx+oQa8Ha42YGFE8ArA8CIpjZUSmClZmRcsp1s=;
	b=dqTViZY5Rhg+4dxm6j6eTDrDRZxJobGKPEC5f6m105ViKQk5ihdBxBOVGZS+wnV/nnlJnq
	HlU8nooKUrlDLbtRN4x0YlRxsqIc1PsMXurE8hNPEozddY1FDkiDvRZIXZSOvEgoVZKaDT
	K9UTh1Hwz7rkkmXo0q/CbhmYfoeY/Sm0AwdEMVFCfFLALXH3uU6/V5K7FBUBQ+VO/nbN4z
	W13C99vHEmbJcpJOMLhRSEsAqTo1FTM1skZdAAhBW3HFX+KnadSl4CZRjGWHKZ2css3bUO
	jBxnnhqOGxXfDfDNODB7YOKUSbFIwza1b5DXU4/0Uch3Lej5HPBJxY1JQTd1zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757074625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7UH1ADx+oQa8Ha42YGFE8ArA8CIpjZUSmClZmRcsp1s=;
	b=WrRW7DsBgKI+GwACfML25UaaF/wj1wMrn4TtUBR8T68yGei/KbPg6AHdkJAf/9ZNnQe/Jy
	Uk6vDXlfoNnR+jCg==
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
Subject: [PATCH v5 31/35] x86/cacheinfo: Use parsed CPUID(0x80000006)
Date: Fri,  5 Sep 2025 14:15:11 +0200
Message-ID: <20250905121515.192792-32-darwi@linutronix.de>
In-Reply-To: <20250905121515.192792-1-darwi@linutronix.de>
References: <20250905121515.192792-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the AMD cacheinfo logic, use parsed CPUID(0x80000006) access instead
of a direct CPUID query.

Beside the CPUID parser centralization benefits, this allows using the
auto-generated <asm/cpuid/leaf_types.h> data types, and their full C99
bitfields, instead of doing ugly bitwise operations on CPUID register
output.

For testing L3 cache availability, just check if CPUID(0x80000006) EDX
l3_assoc output is not zero.  Per AMD manuals, an L3 associativity of
zero implies the absence of an L3 cache on the CPU.

Since cpuid_amd_hygon_has_l3_cache() is now using the CPUID parser API,
move its definition under the header file section: "Convenience leaf
specific functions (using parsed CPUID data)"

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/cpuid/api.h | 18 +++++++++---------
 arch/x86/kernel/amd_nb.c         |  3 ++-
 arch/x86/kernel/cpu/cacheinfo.c  |  6 +++---
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index 2989a0c83ab0..c8efbd013504 100644
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
  * 'struct cpuid_leaves' accessors (without sanity checks):
  *
@@ -538,6 +529,15 @@ static inline bool cpuid_amd_hygon_has_l3_cache(void)
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
index c1acead6227a..04a1965f10fe 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -16,6 +16,7 @@
 
 #include <asm/amd/nb.h>
 #include <asm/cpuid/api.h>
+#include <asm/processor.h>
 
 static u32 *flush_words;
 
@@ -93,7 +94,7 @@ static int amd_cache_northbridges(void)
 	if (amd_gart_present())
 		amd_northbridges.flags |= AMD_NB_GART;
 
-	if (!cpuid_amd_hygon_has_l3_cache())
+	if (!cpuid_amd_hygon_has_l3_cache(&boot_cpu_data))
 		return 0;
 
 	/*
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 7033baa94276..c5c6b0740e0d 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -235,7 +235,7 @@ static unsigned int get_cache_id(u32 apicid, const struct _cpuid4_info *id4)
 
 void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, u16 die_id)
 {
-	if (!cpuid_amd_hygon_has_l3_cache())
+	if (!cpuid_amd_hygon_has_l3_cache(c))
 		return;
 
 	if (c->x86 < 0x17) {
@@ -262,7 +262,7 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, u16 die_id)
 
 void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c)
 {
-	if (!cpuid_amd_hygon_has_l3_cache())
+	if (!cpuid_amd_hygon_has_l3_cache(c))
 		return;
 
 	/*
@@ -278,7 +278,7 @@ void init_amd_cacheinfo(struct cpuinfo_x86 *c)
 
 	ci->num_leaves = boot_cpu_has(X86_FEATURE_TOPOEXT) ?
 		cpuid_subleaf_count(c, 0x8000001d) :
-		cpuid_leaf(c, 0x80000006)->l3_assoc ? 4 : 3;
+		cpuid_amd_hygon_has_l3_cache(c) ? 4 : 3;
 }
 
 void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
-- 
2.50.1


