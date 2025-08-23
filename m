Return-Path: <linux-kernel+bounces-783131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4696B329DD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 17:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569329E83F6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 15:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9122E92C5;
	Sat, 23 Aug 2025 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YyXFlKDB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D9723E352
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964343; cv=none; b=S2HP/p9R7JBIUmvRrRLUV25urphNPDWQ2oJ4HkL8fyytwVCKX88CbysMplbtrCbTHF3QlY2ZMauWMorTWfktLN11u8juFIJOVDoSoB5Dq/XOjXzZr3PoVa+LIIBmyuaIf9o6ZEADc3kIsL73WabGUDazHBO9si6YXjPjZxV8wpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964343; c=relaxed/simple;
	bh=Gg34nZmCyvn+O83V3Yqh6+BSEaUXFq4f9DlM0O6eqFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Srhng9xBl6qSH4shjb2srC8Ytug0RsfPXdAVJcz3vAVZgySEb/BoLOfCzmmQWhscqTOV7q8lpoSXM/QOKcTQP8Mg5T1Bn/i7UWU5xaG8D+EVzHeECEztNJqAIJ8tuAPZJL6KanhTbQx5+CS/qOUsGmYeIgV3Lg/AY9yqeRwdtR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YyXFlKDB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755964342; x=1787500342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gg34nZmCyvn+O83V3Yqh6+BSEaUXFq4f9DlM0O6eqFU=;
  b=YyXFlKDBeM/epjv5IYRTD3rRSeEFeiM1Pn80EZtUX5N5hCv2dpslmR2A
   tsjLGkHySP4Xz01Ih7hDw5Cf+kULyWvTWIolBNKg42JbFwUW5SuRPMFw6
   nGreoPOBqYgeod01b+T683VpxJi5NQ/JXd/XhwHyvXOQ/kpNtmL/DdCsD
   p25zT5tXwsQaxOpBFQPHEIf45nVBgCa/kU66OxLO6S7gWVaUtIezmvBLW
   ogKJ+WVTzMF1VncXtleXwjnv5X5pbMea6JmHj2aupvi1BmEfy9HF9jSGf
   AZUtdJfj5X0/yoYIwvU50Xq52TdJjsnS9pUW7obkotwCoWxmvSRWUal4C
   w==;
X-CSE-ConnectionGUID: NkORsQ6LTNuQcn+btXQmBw==
X-CSE-MsgGUID: ih1D6oroQYOOw75faWknFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="75832792"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="75832792"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 08:52:20 -0700
X-CSE-ConnectionGUID: 5V5DUiA4TXSQoM4RkzWDjw==
X-CSE-MsgGUID: 4R9D6fTwQ5u1VYOHagap2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="169748223"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.85.190])
  by fmviesa010.fm.intel.com with ESMTP; 23 Aug 2025 08:52:18 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chao.gao@intel.com,
	abusse@amazon.de,
	chang.seok.bae@intel.com
Subject: [PATCH v5 1/7] x86/cpu/topology: Make primary thread mask available with SMP=n
Date: Sat, 23 Aug 2025 08:52:04 -0700
Message-ID: <20250823155214.17465-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250823155214.17465-1-chang.seok.bae@intel.com>
References: <20250813172649.15474-1-chang.seok.bae@intel.com>
 <20250823155214.17465-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpu_primary_thread_mask is only defined when CONFIG_SMP=y. However, even
in UP kernels there is always exactly one CPU, which can reasonably be
treated as the primary thread.

Historically, topology_is_primary_thread() always returned true with
CONFIG_SMP=n. A recent commit:

  4b455f59945aa ("cpu/SMT: Provide a default topology_is_primary_thread()")

replaced it with a generic implementation with the note:

  "When disabling SMT, the primary thread of the SMT will remain
   enabled/active. Architectures that have a special primary thread (e.g.
   x86) need to override this function. ..."

For consistency and clarity, make the primary thread mask available
regardless of SMP, similar to cpu_possible_mask and cpu_present_mask.

Move __cpu_primary_thread_mask into common code to prevent build issues.
Let cpu_mark_primary_thread() configure the mask even for UP kernels,
alongside other masks. Then, topology_is_primary_thread() can
consistently reference it.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V4 -> V5: New patch

Preparatory patch to set up the mask correctly before its new use in
patch3.
---
 arch/x86/include/asm/topology.h       | 12 ++++++------
 arch/x86/kernel/cpu/topology.c        |  4 ----
 arch/x86/kernel/cpu/topology_common.c |  3 +++
 arch/x86/kernel/smpboot.c             |  3 ---
 4 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 6c79ee7c0957..281252af6e9d 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -218,6 +218,12 @@ static inline unsigned int topology_amd_nodes_per_pkg(void)
 	return __amd_nodes_per_pkg;
 }
 
+#else /* CONFIG_SMP */
+static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0; }
+static inline int topology_max_smt_threads(void) { return 1; }
+static inline unsigned int topology_amd_nodes_per_pkg(void) { return 1; }
+#endif /* !CONFIG_SMP */
+
 extern struct cpumask __cpu_primary_thread_mask;
 #define cpu_primary_thread_mask ((const struct cpumask *)&__cpu_primary_thread_mask)
 
@@ -231,12 +237,6 @@ static inline bool topology_is_primary_thread(unsigned int cpu)
 }
 #define topology_is_primary_thread topology_is_primary_thread
 
-#else /* CONFIG_SMP */
-static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0; }
-static inline int topology_max_smt_threads(void) { return 1; }
-static inline unsigned int topology_amd_nodes_per_pkg(void) { return 1; }
-#endif /* !CONFIG_SMP */
-
 static inline void arch_fix_phys_package_id(int num, u32 slot)
 {
 }
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index e35ccdc84910..f083023f7dd9 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -75,15 +75,11 @@ bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
 	return phys_id == (u64)cpuid_to_apicid[cpu];
 }
 
-#ifdef CONFIG_SMP
 static void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid)
 {
 	if (!(apicid & (__max_threads_per_core - 1)))
 		cpumask_set_cpu(cpu, &__cpu_primary_thread_mask);
 }
-#else
-static inline void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid) { }
-#endif
 
 /*
  * Convert the APIC ID to a domain level ID by masking out the low bits
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index b5a5e1411469..71625795d711 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -16,6 +16,9 @@ EXPORT_SYMBOL_GPL(x86_topo_system);
 unsigned int __amd_nodes_per_pkg __ro_after_init;
 EXPORT_SYMBOL_GPL(__amd_nodes_per_pkg);
 
+/* CPUs which are the primary SMT threads */
+struct cpumask __cpu_primary_thread_mask __read_mostly;
+
 void topology_set_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
 		      unsigned int shift, unsigned int ncpus)
 {
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 33e166f6ab12..7804175d2d87 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -103,9 +103,6 @@ EXPORT_PER_CPU_SYMBOL(cpu_core_map);
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_die_map);
 EXPORT_PER_CPU_SYMBOL(cpu_die_map);
 
-/* CPUs which are the primary SMT threads */
-struct cpumask __cpu_primary_thread_mask __read_mostly;
-
 /* Representing CPUs for which sibling maps can be computed */
 static cpumask_var_t cpu_sibling_setup_mask;
 
-- 
2.48.1


