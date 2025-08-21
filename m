Return-Path: <linux-kernel+bounces-779528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41340B2F53B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 826087BBEB1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B042A2FF140;
	Thu, 21 Aug 2025 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RVOvnaOK"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDFA2F4A14
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755771757; cv=none; b=LQKBRhmoJYpf8jRkEswp7Ua9DrHjBkxubZ1ZY4kdN9TNEncxiaKpVqg88FpE0D/E60280kft3EwPWxPsCEm1bE4BL5/ZtzRAQO3hO8Lkk2iNf+0GUgduYyPIbi8a3xb6NKZs9D7zMVk7B3GGa8uPf6D7G2r3Q+86sgUB+Bp2UJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755771757; c=relaxed/simple;
	bh=Xoy55CwU4giBJll8gjCN19iyVwh+OG2OUEkfJgm/bdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0deRCwCnhCActZr3Y1MFnPRhyCE6hDqWshWX6ZqWP2K59Kd0tMWt7GuMBEBfdYi/SbTv2yoH5cNXRP+PudU7G+AEtrncKz6Hq+u26NsWcgdSI/2Fsfq3C7Pet492jW5bcoZbtRZVhMr4Pb8OSUP0qzoW/k0ZeZr6SCh4DZ5iD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RVOvnaOK; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7991540E0232;
	Thu, 21 Aug 2025 10:22:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QTrnAPh8V5It; Thu, 21 Aug 2025 10:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755771746; bh=dFiMOwXbOUT9pc81mZWQSd7wt3VW9jkYyN3t4XQgQgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RVOvnaOKtbfUqdcpknJ+954WamjS2NvodihJIXMyWUarqIy63KRh3R4w+FwmLfZwW
	 Pk4xnk0s+pRuyoy/e4I8o2gXYCs7wG32tPQPctdhpxguU4cL4YfmZ1S12QUoQaNM3r
	 m9m7mN3AE5nLr5yDrQRn7A6LgrrXca9dHX0zJY2PabJL2+ml9LvHq4IJbSyQPF4glZ
	 85d9RcJRRB2ExSAhVJzn9NtVJ77LQnv0fs5MAS+FEQvcmYwYb3j08jdBXDD8bD7SxN
	 BMnxEZ/oPf7VRH04xtg5iiLFvrkk92Nl9EFb4GtPKx9PQJrt6VTr2x2t1Afvyc9gXm
	 vTumjao9lAb7fenFyzSkTbdG53D42qQR9GCjwj7Jx5F2ojwCxeoebi0Fo9IkiyofgA
	 OHL9GL74HS9PKuaqRek+6E4QknBNvSF6/PT+9FKYLZyaP6Qiu8/RG7y7tKYSufCvzY
	 L3cp2kS5q6h2WmXenapSwLL7C8afsGagreUXpZ5mVyw3w+ObEifvcKXtzweCggKosD
	 AS45d7TmqduC72FbjLIvL6mDeEEtOJlOHWEyD5HygaH/dvhZfrNHEqFPOVXATu6WxB
	 FXWTk88T7ii5ji6oh3XGRgyWGiIR/sQ76jG6bK362oj7ImQpoI+258GpbG/EmdodzT
	 b7VyqKOz0OJtVcDuk/m6YOXA=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 363F240E01AB;
	Thu, 21 Aug 2025 10:22:18 +0000 (UTC)
Date: Thu, 21 Aug 2025 12:22:13 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 0/2] x86/cpu/cacheinfo: Simplify llc_id calculation on
 AMD platforms
Message-ID: <20250821102213.GBaKbzVWCNgEZbaxv8@fat_crate.local>
References: <20250821051910.7351-1-kprateek.nayak@amd.com>
 <aKbspRcrEWBiox8c@lx-t490>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aKbspRcrEWBiox8c@lx-t490>

On Thu, Aug 21, 2025 at 11:53:41AM +0200, Ahmed S. Darwish wrote:
> Since you don't write to 'id4' anymore, please make the pointer constant.
> It helps with code comprehension: from a quick glance, one knows that the
> function does not write to the passed structure.
> 
> Other than that, and possibly merging the two patches (if you want to):
> 
> Acked-by: Ahmed S. Darwish <darwi@linutronix.de>
> 
> Thanks!

Makes sense, final result still looks readable:

From: K Prateek Nayak <kprateek.nayak@amd.com>
Date: Thu, 21 Aug 2025 05:19:09 +0000
Subject: [PATCH] x86/cpu/cacheinfo: Simplify cacheinfo_amd_init_llc_id() using
 _cpuid4_info

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
2.51.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

