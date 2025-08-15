Return-Path: <linux-kernel+bounces-770336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A6BB279B9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971035C26AF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09DC2EAB65;
	Fri, 15 Aug 2025 07:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q3R4Lqnv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gt47JTJI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E672EAB8A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755241578; cv=none; b=r4EVCt3dlLv7CF44kYgsmKFCQk0TUuvg7J590SiKuQp/zGb6Idcbj3kDO3q8HKePLd6YiFDvZNL9JJvxeqE4Dj1Wh4Iasrq87rp9m/orRxwl6hUr9Ze7EssoiIScZ5tnGeDGrD5+dH03hS5uZ6d43JUtRjlnSKM3Vypct1MZ8KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755241578; c=relaxed/simple;
	bh=VhQ2AW4hu4vxzzPZy+wR50LC1QcmINnPfGV7bp1Vh4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0klkcqEq6qEwuyXnbd2oR5UjPBdYsNqp7LipHifBpPPvIbgOcdwJUeJKgJYHHs7A/3B70Oh/jwutFPVN4TxmwApE9y8pQ68Ulx72XKCrCJSs5GaavznaTQLyK0I1BLG7bawOXSQg0hBV9oxdrw8dNVwhnzNrvlUVowrhwO9InU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q3R4Lqnv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gt47JTJI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755241575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAW9Sb8AlpKe5ZB280Ci+exP+1Tn7RBgsZ7M89/kVXg=;
	b=Q3R4Lqnv7APBgrKJ3NQIjsW2q7b298OymgEhR8jhMokr5goxXlVS5MXXiOn9YdkGFSj7bD
	qatndoPEsfDFFFAo4WlbPpodOh4jZh8Zg2BHygcLT7rSzS7M5A799yrWngGcdIZZdsCjY3
	faB+KSgC1zUAKgRuxjIqnHLpVTFGcSvf5+Uud4dZkVQVk2mrXGSppU4KAhzcKm/9zQRAav
	VhkbuPdx7TMZ8uYDATO2PVIHlReh1ED+k15fvdTRnYm1rHm6LopXWX4vwP5hNOejaddxQ/
	LnJ3ns+BrNTzfRFaX6gU92RqY037Lnd4QLTC00/AI691ky66qLUu0IO9IqNB3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755241575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAW9Sb8AlpKe5ZB280Ci+exP+1Tn7RBgsZ7M89/kVXg=;
	b=gt47JTJIX04MH65sNj2FWKHfesoLryHEx8PebKIjIZuCuQ05xB3b3eJWqUUmYDY3JanFey
	IYy5S8O3Z5jXh0AQ==
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
Subject: [PATCH v4 23/34] x86/cacheinfo: Pass a 'struct cpuinfo_x86' refrence to CPUID(0x4) code
Date: Fri, 15 Aug 2025 09:02:16 +0200
Message-ID: <20250815070227.19981-24-darwi@linutronix.de>
In-Reply-To: <20250815070227.19981-1-darwi@linutronix.de>
References: <20250815070227.19981-1-darwi@linutronix.de>
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
 arch/x86/kernel/cpu/cacheinfo.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index f837ccdec116..0ed5dd6d29ef 100644
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
@@ -434,7 +434,7 @@ static bool intel_cacheinfo_0x4(struct cpuinfo_x86 *c)
 		struct _cpuid4_info id4 = {};
 		int ret;
 
-		ret = intel_fill_cpuid4_info(i, &id4);
+		ret = intel_fill_cpuid4_info(c, i, &id4);
 		if (ret < 0)
 			continue;
 
@@ -618,13 +618,14 @@ int populate_cache_leaves(unsigned int cpu)
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
2.50.1


