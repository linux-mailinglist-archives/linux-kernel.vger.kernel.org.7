Return-Path: <linux-kernel+bounces-826452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B1DB8E92B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 00:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6376D189B5A4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BEE2D0C8A;
	Sun, 21 Sep 2025 22:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eRdwbBV5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26A124BBE4
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 22:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758494928; cv=none; b=te9qm87zc/M4qkJtfhVrl/H2gPVlT3XF58d3EW1vaDt6DxoZNR943MVfuMHBCIO+oJ0sp5jfrQWIbWmpNYJR+j2kp+CDB2XIpAgaSL+vOZTGN51hdR6SzecZUydxdOV91B8j2IYFVGwIdTAMpnBSkK9uvYApgniUCqk25qqoKK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758494928; c=relaxed/simple;
	bh=pIkHPHzAQfoC0BmBJFfQc4zdmSkmM4xqhNCG7iomLxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qaY5XJXuQSRxog6VuZqkjOjv0FnRZ8VlkIzzqOZyVxGjSdKtwkEvH3t0leRYEsmU9h1ZuKEN05hSI+Do2wYfeBq8njgrWLEv8R5TKqY1C6O/RC7uMuSWNp6xO1Qa/IgVY6rBeJqX1ABKXexOtmqiTh/ybL+xLQdRIBeYKCQ4Vz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eRdwbBV5; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758494928; x=1790030928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pIkHPHzAQfoC0BmBJFfQc4zdmSkmM4xqhNCG7iomLxQ=;
  b=eRdwbBV5Lg7GULDzhLZ+wZWYSvNLLti7DE0/sk8A3zG8Z3rhKthC1AsF
   TQvP7mXKKMPxlO/h2CErDhXYx/z4dFItqB7KnlrKpgobaZ8OQVqSvTYC2
   C9138Vt2ltBUBwrwGpGTX7zJO48SxJRGvXzAWEhiVxr916SNRd4FyHI3I
   h2NpCunZtNrpWJzG8kArdT2luplm4XdPLWVHgyRm8aBGzHxVzxNOUfPsZ
   UTRx9KBiM7c0IIlqrlEJDvAI4rqPZZTD0p6IXUWywS8UD0N0j01+QON/q
   i7A9x7LZboGHeK6qnnmDNfTv8kwWz3TKexYRw0bHVyeJslihr9ar/yQYy
   A==;
X-CSE-ConnectionGUID: VzNpo9YqQBql9BQi+Gygkw==
X-CSE-MsgGUID: IkDM7nkiTBGxi33GGHcGwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64562336"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64562336"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2025 15:48:46 -0700
X-CSE-ConnectionGUID: 77Wb7snSS0e2Lxr2UwQqQw==
X-CSE-MsgGUID: +fgsqzqFTjKJTq69KW9vYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,283,1751266800"; 
   d="scan'208";a="177129782"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.135.148])
  by fmviesa010.fm.intel.com with ESMTP; 21 Sep 2025 15:48:44 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chao.gao@intel.com,
	abusse@amazon.de,
	tony.luck@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v6 1/7] x86/cpu/topology: Make primary thread mask available with SMP=n
Date: Sun, 21 Sep 2025 15:48:35 -0700
Message-ID: <20250921224841.3545-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250921224841.3545-1-chang.seok.bae@intel.com>
References: <20250921224841.3545-1-chang.seok.bae@intel.com>
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
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
V5 -> V6: Collect Tony's review tag
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
index eb289abece23..6b43417bf270 100644
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


