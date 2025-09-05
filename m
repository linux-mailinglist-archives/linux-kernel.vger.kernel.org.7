Return-Path: <linux-kernel+bounces-802850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD0CB45794
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39A2EA60B19
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38EE34F467;
	Fri,  5 Sep 2025 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hhUYr5VZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nI5KapsW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863413570BE
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074610; cv=none; b=G24ZfyfqCdbB8R5oxOHIQ0545F0hGDjrn2cWGatGwpbTtr25A71Pbxco+d+NvWVPWbUu61+MObXmSf7jWRNAPvLpDNMupp/RpzzylkclLWF8kdf1Hjkh6EQzw8TrzrrX86XgktGRgk5FslZ9Egkqlc2JxjL6QAOb+V7HODMtxfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074610; c=relaxed/simple;
	bh=yNpYB8ZWbb+KQniL0ZjgQ/fa4iKBtyPmfBP0wwNfaj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTcUAS+Iz6ciNZmWNAfo66iUp9r2kzy42Zo3myrqP/8AIrClZ9vR/Jlbn2VdrldmLjeOPRCxQ+o2l61vP2OxBOdb/2+HcsvT0e4Sm1EKKmVRi7ZbN12lj3dyLe0NtBJyaN6emaUEhmxDmhF1VRW7uTELxpbDuWc68dw2SOGRCco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hhUYr5VZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nI5KapsW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757074607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qs37mBil5a1SU5iV5EX5mmOXYYZ7JEI/2oUycDoeqOI=;
	b=hhUYr5VZCTE+u1nYiJsIi1G1uw74k1+Iij6dvGUyJbd1HRye9llNzpgcDW3JfZB3IRh5wx
	i3kvG4UeAO+SOfZi5ogAKy14hhvqxmy84xMSYZ8SuJxKsESihYSU9TCHCoy3uwixi8XqH6
	ajEo4BGd5Y9BlkAl3bkp+G21RaIu6FYJg79e4fk4+2IJGI+n3e3vvkOqQh2X5iv6TlYwuq
	FZszPmQ6j/kSVafwYGnSHSePbh/zxCs6jLxJN33wQ5p2IT9isPcHPlLBg13PY0RROIMCov
	iyuIZQL7oOOT9631JFgNGVTOeCYX7/3UyqRdXSh7ShiIv3G3SI5eQ0Y82ix2YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757074607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qs37mBil5a1SU5iV5EX5mmOXYYZ7JEI/2oUycDoeqOI=;
	b=nI5KapsW9/tkpPt5pKRyxhoWA6LhI44HfJnbO83cJSekRDIzGUNjHfPV1BdkiF9pj30yWj
	RmMBhJftuJ6AcFDg==
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
Subject: [PATCH v5 25/35] x86/cacheinfo: Pass a 'struct cpuinfo_x86' refrence to CPUID(0x4) code
Date: Fri,  5 Sep 2025 14:15:05 +0200
Message-ID: <20250905121515.192792-26-darwi@linutronix.de>
In-Reply-To: <20250905121515.192792-1-darwi@linutronix.de>
References: <20250905121515.192792-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare the CPUID(0x4) cache topology code for using parsed CPUID APIs
instead of invoking direct CPUID queries.

Since such an API requires a 'struct cpuinfo_x86' reference, trickle it
from the <linux/cacheinfo.h>'s populate_cache_leaves() x86 implementation
down to fill_cpuid4_info() and its Intel-specific CPUID(0x4) code.

No functional change intended.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Link: https://lore.kernel.org/lkml/aBnEBbDATdE2LTGU@gmail.com
---
 arch/x86/kernel/cpu/cacheinfo.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index c09e7f96fa77..f6b093dd8416 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -252,7 +252,7 @@ static int amd_fill_cpuid4_info(int index, struct _cpuid4_info *id4)
 	return cpuid4_info_fill_done(id4, eax, ebx, ecx);
 }
 
-static int intel_fill_cpuid4_info(int index, struct _cpuid4_info *id4)
+static int intel_fill_cpuid4_info(struct cpuinfo_x86 *unused, int index, struct _cpuid4_info *id4)
 {
 	union _cpuid4_leaf_eax eax;
 	union _cpuid4_leaf_ebx ebx;
@@ -264,13 +264,13 @@ static int intel_fill_cpuid4_info(int index, struct _cpuid4_info *id4)
 	return cpuid4_info_fill_done(id4, eax, ebx, ecx);
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
 
 static int find_num_cache_leaves(struct cpuinfo_x86 *c)
@@ -443,7 +443,7 @@ static bool intel_cacheinfo_0x4(struct cpuinfo_x86 *c)
 		struct _cpuid4_info id4 = {};
 		int ret;
 
-		ret = intel_fill_cpuid4_info(i, &id4);
+		ret = intel_fill_cpuid4_info(c, i, &id4);
 		if (ret < 0)
 			continue;
 
@@ -612,17 +612,17 @@ int populate_cache_leaves(unsigned int cpu)
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *ci = this_cpu_ci->info_list;
 	u8 cpu_vendor = boot_cpu_data.x86_vendor;
-	u32 apicid = cpu_data(cpu).topo.apicid;
+	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	struct amd_northbridge *nb = NULL;
 	struct _cpuid4_info id4 = {};
 	int idx, ret;
 
 	for (idx = 0; idx < this_cpu_ci->num_leaves; idx++) {
-		ret = fill_cpuid4_info(idx, &id4);
+		ret = fill_cpuid4_info(c, idx, &id4);
 		if (ret)
 			return ret;
 
-		id4.id = get_cache_id(apicid, &id4);
+		id4.id = get_cache_id(c->topo.apicid, &id4);
 
 		if (cpu_vendor == X86_VENDOR_AMD || cpu_vendor == X86_VENDOR_HYGON)
 			nb = amd_init_l3_cache(idx);
-- 
2.50.1


