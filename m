Return-Path: <linux-kernel+bounces-802854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B88B4579F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA533ACC40
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC2D350D76;
	Fri,  5 Sep 2025 12:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zg1FJTkO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E8FxgQeM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA3735AAAF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074622; cv=none; b=c5VWkMo61HwI2DSJVeV+63PSqwxsRVKnaX1B9Ls3KUmOvtL59X2qoClfISDBfTZvcujMc4o01xD5I/HqK6tTZN1quqEkXnXLRKPe9WuptAzhNNzKUjzVE/NOkOF3N1Kt9pkAE5/PlhQZEf46aJFXaeg55wwA+uKXFeRZ3RS9CWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074622; c=relaxed/simple;
	bh=7anxj/W4ZTI/3qrsbFCOcCPIVBbKWTXedcy9YL2aHH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUF+6SvGFBLuNrltK2FgNCQYZXD7BaHnU5Z8jS1S0mw0Z8PTZQdtaJ/p6aelQ97G252W2AAeBjYirPpZl1jS6OWU3d0YtiXisW0dL3J//CKPbTA65w08cGUcDf6jMLW/gkYMtFD1mSgrjv16Odpdn7FlzKiqHHlQVk8FU1kyxms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zg1FJTkO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E8FxgQeM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757074619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sx4DffFKwZOMaQlBwx3uZ7KClJAls5rI47TU/h7xf5U=;
	b=Zg1FJTkOfyI7eHGp8ZIUJEcyJtN9kGs7mXOjInuVQn6fDgTJXqstcHfd9kf+GtWXDTpapE
	W+sv+voOXn9Z++mdR3Yt6OUXP3O/i08vv3/zNvCxbTpUnqh+aPXEoCzfLStArTvZ8kJmjR
	KtdnmvknyX2Hj/esz+rMfPG5k0opDSisg2t6VAgjbXSxoeNFLtCnGwMjqibG/baWKhAsit
	8YTZSc+UNqRxD82d2wzvTX5Z6EuSUdNtf9RVGb6X9adENXZ2kcLMSGMMuaPNTcnuiKj/jZ
	+3iEQr5fvWJc32HxCfQb6UDaTNU13rlvUCklnuqPyAwz4xxc7adGkSpRqI/IDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757074619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sx4DffFKwZOMaQlBwx3uZ7KClJAls5rI47TU/h7xf5U=;
	b=E8FxgQeM+AZH1wphj+h0fgpTyKjw7LXRkKXM4ilFoNvzeCnDYs9xqsdi3fu0kxnBfIkPom
	4aPWxWvP1jhyrnBQ==
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
Subject: [PATCH v5 29/35] x86/cacheinfo: Use auto-generated data types
Date: Fri,  5 Sep 2025 14:15:09 +0200
Message-ID: <20250905121515.192792-30-darwi@linutronix.de>
In-Reply-To: <20250905121515.192792-1-darwi@linutronix.de>
References: <20250905121515.192792-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the AMD CPUID(0x4) emulation logic, use the auto-generated
<asm/cpuid/leaf_types.h> data type:

    struct leaf_0x4_n

instead of the manually-defined:

    union _cpuid4_leaf_{eax,ebx,ecx}

ones.  Remove such unions entirely as they are no longer used.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Link: https://gitlab.com/x86-cpuid.org/x86-cpuid-db
---
 arch/x86/kernel/cpu/cacheinfo.c | 127 +++++++++++---------------------
 1 file changed, 42 insertions(+), 85 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 3e1ccab56e4c..8474d9047bad 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -41,39 +41,8 @@ enum _cache_type {
 	CTYPE_UNIFIED	= 3
 };
 
-union _cpuid4_leaf_eax {
-	struct {
-		enum _cache_type	type			:5;
-		unsigned int		level			:3;
-		unsigned int		is_self_initializing	:1;
-		unsigned int		is_fully_associative	:1;
-		unsigned int		reserved		:4;
-		unsigned int		num_threads_sharing	:12;
-		unsigned int		num_cores_on_die	:6;
-	} split;
-	u32 full;
-};
-
-union _cpuid4_leaf_ebx {
-	struct {
-		unsigned int		coherency_line_size	:12;
-		unsigned int		physical_line_partition	:10;
-		unsigned int		ways_of_associativity	:10;
-	} split;
-	u32 full;
-};
-
-union _cpuid4_leaf_ecx {
-	struct {
-		unsigned int		number_of_sets		:32;
-	} split;
-	u32 full;
-};
-
 struct _cpuid4_info {
-	union _cpuid4_leaf_eax eax;
-	union _cpuid4_leaf_ebx ebx;
-	union _cpuid4_leaf_ecx ecx;
+	struct leaf_0x4_n regs;
 	unsigned int id;
 	unsigned long size;
 };
@@ -148,17 +117,14 @@ static const unsigned short assocs[] = {
 static const unsigned char levels[] = { 1, 1, 2, 3 };
 static const unsigned char types[]  = { 1, 2, 3, 3 };
 
-static void legacy_amd_cpuid4(int index, union _cpuid4_leaf_eax *eax,
-			      union _cpuid4_leaf_ebx *ebx, union _cpuid4_leaf_ecx *ecx)
+static void legacy_amd_cpuid4(int index, struct leaf_0x4_n *regs)
 {
 	unsigned int dummy, line_size, lines_per_tag, assoc, size_in_kb;
 	union l1_cache l1i, l1d, *l1;
 	union l2_cache l2;
 	union l3_cache l3;
 
-	eax->full = 0;
-	ebx->full = 0;
-	ecx->full = 0;
+	*regs = (struct leaf_0x4_n){ };
 
 	cpuid(0x80000005, &dummy, &dummy, &l1d.val, &l1i.val);
 	cpuid(0x80000006, &dummy, &dummy, &l2.val, &l3.val);
@@ -204,71 +170,62 @@ static void legacy_amd_cpuid4(int index, union _cpuid4_leaf_eax *eax,
 		return;
 	}
 
-	eax->split.is_self_initializing		= 1;
-	eax->split.type				= types[index];
-	eax->split.level			= levels[index];
-	eax->split.num_threads_sharing		= 0;
-	eax->split.num_cores_on_die		= topology_num_cores_per_package();
+	regs->cache_self_init		= 1;
+	regs->cache_type		= types[index];
+	regs->cache_level		= levels[index];
+	regs->num_threads_sharing	= 0;
+	regs->num_cores_on_die		= topology_num_cores_per_package();
 
 	if (assoc == AMD_CPUID4_FULLY_ASSOCIATIVE)
-		eax->split.is_fully_associative = 1;
+		regs->fully_associative	= 1;
 
-	ebx->split.coherency_line_size		= line_size - 1;
-	ebx->split.ways_of_associativity	= assoc - 1;
-	ebx->split.physical_line_partition	= lines_per_tag - 1;
-	ecx->split.number_of_sets		= (size_in_kb * 1024) / line_size /
-		(ebx->split.ways_of_associativity + 1) - 1;
+	regs->cache_linesize		= line_size - 1;
+	regs->cache_nways		= assoc - 1;
+	regs->cache_npartitions		= lines_per_tag - 1;
+	regs->cache_nsets		= (size_in_kb * 1024) / line_size /
+		(regs->cache_nways + 1) - 1;
 }
 
-static int cpuid4_info_fill_done(struct _cpuid4_info *id4, union _cpuid4_leaf_eax eax,
-				 union _cpuid4_leaf_ebx ebx, union _cpuid4_leaf_ecx ecx)
+static int cpuid4_info_fill_done(struct _cpuid4_info *id4, const struct leaf_0x4_n *regs)
 {
-	if (eax.split.type == CTYPE_NULL)
+	if (regs->cache_type == CTYPE_NULL)
 		return -EIO;
 
-	id4->eax = eax;
-	id4->ebx = ebx;
-	id4->ecx = ecx;
-	id4->size = (ecx.split.number_of_sets          + 1) *
-		    (ebx.split.coherency_line_size     + 1) *
-		    (ebx.split.physical_line_partition + 1) *
-		    (ebx.split.ways_of_associativity   + 1);
+	id4->regs = *regs;
+	id4->size = (regs->cache_nsets	     + 1) *
+		    (regs->cache_linesize    + 1) *
+		    (regs->cache_npartitions + 1) *
+		    (regs->cache_nways	     + 1);
 
 	return 0;
 }
 
 static int amd_fill_cpuid4_info(struct cpuinfo_x86 *c, int index, struct _cpuid4_info *id4)
 {
-	union _cpuid4_leaf_eax eax;
-	union _cpuid4_leaf_ebx ebx;
-	union _cpuid4_leaf_ecx ecx;
+	struct leaf_0x4_n l_0x4_regs;
 
 	if (boot_cpu_has(X86_FEATURE_TOPOEXT) || boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
-		const struct cpuid_regs *regs = cpuid_subleaf_n_raw(c, 0x8000001d, index);
+		const struct leaf_0x8000001d_n *regs = cpuid_subleaf_n(c, 0x8000001d, index);
 
 		if (!regs)
 			return -EIO;
 
-		eax.full = regs->eax;
-		ebx.full = regs->ebx;
-		ecx.full = regs->ecx;
+		/* CPUID(0x8000001d) and CPUID(0x4) have the same bitfields */
+		l_0x4_regs = *(struct leaf_0x4_n *)regs;
 	} else
-		legacy_amd_cpuid4(index, &eax, &ebx, &ecx);
+		legacy_amd_cpuid4(index, &l_0x4_regs);
 
-	return cpuid4_info_fill_done(id4, eax, ebx, ecx);
+	return cpuid4_info_fill_done(id4, &l_0x4_regs);
 }
 
 static int intel_fill_cpuid4_info(struct cpuinfo_x86 *c, int index, struct _cpuid4_info *id4)
 {
-	const struct cpuid_regs *regs = cpuid_subleaf_n_raw(c, 0x4, index);
+	const struct leaf_0x4_n *regs = cpuid_subleaf_n(c, 0x4, index);
 
 	if (!regs)
 		return -EIO;
 
-	return cpuid4_info_fill_done(id4,
-				     (union _cpuid4_leaf_eax)(regs->eax),
-				     (union _cpuid4_leaf_ebx)(regs->ebx),
-				     (union _cpuid4_leaf_ecx)(regs->ecx));
+	return cpuid4_info_fill_done(id4, regs);
 }
 
 static int fill_cpuid4_info(struct cpuinfo_x86 *c, int index, struct _cpuid4_info *id4)
@@ -290,7 +247,7 @@ static unsigned int get_cache_id(u32 apicid, const struct _cpuid4_info *id4)
 	unsigned long num_threads_sharing;
 	int index_msb;
 
-	num_threads_sharing = 1 + id4->eax.split.num_threads_sharing;
+	num_threads_sharing = 1 + id4->regs.num_threads_sharing;
 	index_msb = get_count_order(num_threads_sharing);
 
 	return apicid >> index_msb;
@@ -406,7 +363,7 @@ static unsigned int calc_cache_topo_id(struct cpuinfo_x86 *c, const struct _cpui
 	unsigned int num_threads_sharing;
 	int index_msb;
 
-	num_threads_sharing = 1 + id4->eax.split.num_threads_sharing;
+	num_threads_sharing = 1 + id4->regs.num_threads_sharing;
 	index_msb = get_count_order(num_threads_sharing);
 	return c->topo.apicid & ~((1 << index_msb) - 1);
 }
@@ -432,11 +389,11 @@ static bool intel_cacheinfo_0x4(struct cpuinfo_x86 *c)
 		if (ret < 0)
 			continue;
 
-		switch (id4.eax.split.level) {
+		switch (id4.regs.cache_level) {
 		case 1:
-			if (id4.eax.split.type == CTYPE_DATA)
+			if (id4.regs.cache_type == CTYPE_DATA)
 				l1d = id4.size / 1024;
-			else if (id4.eax.split.type == CTYPE_INST)
+			else if (id4.regs.cache_type == CTYPE_INST)
 				l1i = id4.size / 1024;
 			break;
 		case 2:
@@ -497,7 +454,7 @@ static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 	} else if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
 		unsigned int apicid, nshared, first, last;
 
-		nshared = id4->eax.split.num_threads_sharing + 1;
+		nshared = id4->regs.num_threads_sharing + 1;
 		apicid = cpu_data(cpu).topo.apicid;
 		first = apicid - (apicid % nshared);
 		last = first + nshared - 1;
@@ -544,7 +501,7 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 	}
 
 	ci = this_cpu_ci->info_list + index;
-	num_threads_sharing = 1 + id4->eax.split.num_threads_sharing;
+	num_threads_sharing = 1 + id4->regs.num_threads_sharing;
 
 	cpumask_set_cpu(cpu, &ci->shared_cpu_map);
 	if (num_threads_sharing == 1)
@@ -571,13 +528,13 @@ static void ci_info_init(struct cacheinfo *ci, const struct _cpuid4_info *id4,
 {
 	ci->id				= id4->id;
 	ci->attributes			= CACHE_ID;
-	ci->level			= id4->eax.split.level;
-	ci->type			= cache_type_map[id4->eax.split.type];
-	ci->coherency_line_size		= id4->ebx.split.coherency_line_size + 1;
-	ci->ways_of_associativity	= id4->ebx.split.ways_of_associativity + 1;
+	ci->level			= id4->regs.cache_level;
+	ci->type			= cache_type_map[id4->regs.cache_type];
+	ci->coherency_line_size		= id4->regs.cache_linesize + 1;
+	ci->ways_of_associativity	= id4->regs.cache_nways + 1;
 	ci->size			= id4->size;
-	ci->number_of_sets		= id4->ecx.split.number_of_sets + 1;
-	ci->physical_line_partition	= id4->ebx.split.physical_line_partition + 1;
+	ci->number_of_sets		= id4->regs.cache_nsets + 1;
+	ci->physical_line_partition	= id4->regs.cache_npartitions + 1;
 	ci->priv			= nb;
 }
 
-- 
2.50.1


