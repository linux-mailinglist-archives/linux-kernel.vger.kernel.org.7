Return-Path: <linux-kernel+bounces-802829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78963B4577B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 112E87A17CF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0560834DCD3;
	Fri,  5 Sep 2025 12:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o4WJh9Zz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pEJXjxL4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFF734F497
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074539; cv=none; b=dA4yWfZnpXWXdkgy+HL6mGkRgon2g7HJS7itJll1CbDDuWzZ1Hu0FrLh5ql+vJgQSIDtk16ijyo0CWqKvURTUjRZgVCmEDf+z2mGVYWn2vUFuEB413y20wjoPGHAEmGWbRn5HJk1AnCiMaDKgMJU3MtsDOQFMArXQMRBH+GxaF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074539; c=relaxed/simple;
	bh=Ha8n4UGVQ8iAPIKbr1RkFgZ4t1VhsTiE1tiK68g30+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fU5zdfv+2XthOCRl+eSJ5Kkk/LgoSbuygf3ah1063qrHh/5knzGYJSY3go3ZfJ93GUWPxmJVWRY1CMk3x/tRIvaqQ0o6XSqh2+8hPA8RfOM6ZQhPfBTlphqvhv7p0bbfrhfcyVudnlvzmO6s+YIKIyp6TKUJ/DfL+7U2mD3I6Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o4WJh9Zz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pEJXjxL4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757074535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6fdxarbMldtZEadRNUal90N3QLS36tZpJv/UAmJIjwA=;
	b=o4WJh9Zzwkdho0yCpxmI/HSGuqVH8JPfMaasA9OMhI0AjyY/sCfcw4WvT9a/FGbeKdbczk
	I3f/j0cW8FqXJw+VO+KTlv2Al8KQlcBG+qLikNtEURsLsINN2J+XHnW03OFT0xaDVD5C1U
	Tf5ivg19vhBDHU3dsAXKhU9JrKckJWi+J5AwVOs800CkAgNgKvxx/RiJhI8kuj036itmHb
	DdvnU8mC063uAN6Gcc09Y+OaPt0HGmC8N3r4UrdYNdYs+occwDxqAmVKURsb3Ay1v42yR6
	qsc879LtOcSxGzTScwQnY9A98Sh8PxTzpOdVmgj92mV7HMZSfwvB3G7xNORZ8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757074535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6fdxarbMldtZEadRNUal90N3QLS36tZpJv/UAmJIjwA=;
	b=pEJXjxL4XU6/UYkR5NB1L/Q0ENOMrBRRl+6qlqtKA7Bm6mSZTEDJlKePAxkZa9vckd4W4T
	9WUaowkSNBS7N9CQ==
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
Subject: [PATCH v5 05/35] x86/cpu/cacheinfo: Simplify cacheinfo_amd_init_llc_id() using _cpuid4_info
Date: Fri,  5 Sep 2025 14:14:45 +0200
Message-ID: <20250905121515.192792-6-darwi@linutronix.de>
In-Reply-To: <20250905121515.192792-1-darwi@linutronix.de>
References: <20250905121515.192792-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: K Prateek Nayak <kprateek.nayak@amd.com>

struct _cpuid4_info has the same layout as the CPUID leaf 0x8000001d.
Use the encoded definition and amd_fill_cpuid4_info(), get_cache_id()
helpers instead of open coding masks and shifts to calculate the llc_id.

cacheinfo_amd_init_llc_id() is only called on AMD systems that support
X86_FEATURE_TOPOEXT and amd_fill_cpuid4_info() uses the information from
CPUID leaf 0x8000001d on all these systems which is consistent with the
current open coded implementation.

While at it, avoid reading  cpu_data() every time get_cache_id() is
called and instead pass the APIC ID necessary to return the
_cpuid4_info.id from get_cache_id().

No functional changes intended.

  [ bp: do what Ahmed suggests: merge into one patch, make id4 ptr
    const. ]

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Ahmed S. Darwish <darwi@linutronix.de>
Link: https://lore.kernel.org/20250821051910.7351-2-kprateek.nayak@amd.com
---
 arch/x86/kernel/cpu/cacheinfo.c | 48 +++++++++++++++------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index adfa7e8bb865..51a95b07831f 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -289,6 +289,22 @@ static int find_num_cache_leaves(struct cpuinfo_x86 *c)
 	return i;
 }
 
+/*
+ * The max shared threads number comes from CPUID(0x4) EAX[25-14] with input
+ * ECX as cache index. Then right shift apicid by the number's order to get
+ * cache id for this cache node.
+ */
+static unsigned int get_cache_id(u32 apicid, const struct _cpuid4_info *id4)
+{
+	unsigned long num_threads_sharing;
+	int index_msb;
+
+	num_threads_sharing = 1 + id4->eax.split.num_threads_sharing;
+	index_msb = get_count_order(num_threads_sharing);
+
+	return apicid >> index_msb;
+}
+
 /*
  * AMD/Hygon CPUs may have multiple LLCs if L3 caches exist.
  */
@@ -312,18 +328,11 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, u16 die_id)
 		 * Newer families: LLC ID is calculated from the number
 		 * of threads sharing the L3 cache.
 		 */
-		u32 eax, ebx, ecx, edx, num_sharing_cache = 0;
 		u32 llc_index = find_num_cache_leaves(c) - 1;
+		struct _cpuid4_info id4 = {};
 
-		cpuid_count(0x8000001d, llc_index, &eax, &ebx, &ecx, &edx);
-		if (eax)
-			num_sharing_cache = ((eax >> 14) & 0xfff) + 1;
-
-		if (num_sharing_cache) {
-			int index_msb = get_count_order(num_sharing_cache);
-
-			c->topo.llc_id = c->topo.apicid >> index_msb;
-		}
+		if (!amd_fill_cpuid4_info(llc_index, &id4))
+			c->topo.llc_id = get_cache_id(c->topo.apicid, &id4);
 	}
 }
 
@@ -598,27 +607,12 @@ int init_cache_level(unsigned int cpu)
 	return 0;
 }
 
-/*
- * The max shared threads number comes from CPUID(0x4) EAX[25-14] with input
- * ECX as cache index. Then right shift apicid by the number's order to get
- * cache id for this cache node.
- */
-static void get_cache_id(int cpu, struct _cpuid4_info *id4)
-{
-	struct cpuinfo_x86 *c = &cpu_data(cpu);
-	unsigned long num_threads_sharing;
-	int index_msb;
-
-	num_threads_sharing = 1 + id4->eax.split.num_threads_sharing;
-	index_msb = get_count_order(num_threads_sharing);
-	id4->id = c->topo.apicid >> index_msb;
-}
-
 int populate_cache_leaves(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *ci = this_cpu_ci->info_list;
 	u8 cpu_vendor = boot_cpu_data.x86_vendor;
+	u32 apicid = cpu_data(cpu).topo.apicid;
 	struct amd_northbridge *nb = NULL;
 	struct _cpuid4_info id4 = {};
 	int idx, ret;
@@ -628,7 +622,7 @@ int populate_cache_leaves(unsigned int cpu)
 		if (ret)
 			return ret;
 
-		get_cache_id(cpu, &id4);
+		id4.id = get_cache_id(apicid, &id4);
 
 		if (cpu_vendor == X86_VENDOR_AMD || cpu_vendor == X86_VENDOR_HYGON)
 			nb = amd_init_l3_cache(idx);
-- 
2.50.1


