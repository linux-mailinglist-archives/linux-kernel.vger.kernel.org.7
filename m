Return-Path: <linux-kernel+bounces-782766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E21AB3251B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 00:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 326FEAC34A1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8872C2363;
	Fri, 22 Aug 2025 22:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ikqrQ93p"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A942E23505F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 22:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755902374; cv=none; b=GT3ZRDgwDXC2/yaqwYCVpVSPkW2PMDLgBcGWoZSt+EA7RfoEYKbJjicJqlM8jWb1gJuLHyX+CFjV/h9Wi7JsTY5FzmNHQXR6bLnz57ghJd+62B6+pIDOy8j2P2nkur0GXzEF+SMTP2kKpq+V8m5OoHgEUwr+GUQ9w0I0YukPoKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755902374; c=relaxed/simple;
	bh=lrTM1OaZCtPbgLTz46pJyWikxkY80TLQuvEvcUrUM+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASmXFIpINEmaw42MPL2l8hvToQ5VNl5zE8TGcYYrYCv2HxWni1TAErhtpHPJKV4tqqiu34lSjFmSsudcFNIK6OiRZ3jwzlCgVf94tJzYIAiqqVujQCEojrkpEB50iSuiYNIlWa/R+oyfUv+uEjVtM5vO1OY9rjd3rvf31TUwav0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ikqrQ93p; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755902373; x=1787438373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lrTM1OaZCtPbgLTz46pJyWikxkY80TLQuvEvcUrUM+g=;
  b=ikqrQ93pbCArPvM68wF28gglzG1tUBMh6u8rNhU+suDp32VjmPiPZLvE
   uRiiIDdrEdIkVTEpadY4vK8DoH+CixovzEXIfv6yidBSc+X1rymKyXIkO
   lxevaClqQHyMHjF+st3RusoNw5QqADCbVh5ZVeM7qi6+SlBxSu2oQ7G7u
   pHmw1D3e3O7YRYtpmwx6r1FlnelmsHuqIdgemlvndMiIUEGSor6CtLVhN
   M83EoQnUOJk5ggATXDqRRYa+vFvZmOpcB084juI5pP0gfjtcZXHDDdjSI
   hZjMkef76NSBtemc5xH63NRNqeZH0Xa7sCPR9woP4q6NoqxSkWP8o2oM1
   Q==;
X-CSE-ConnectionGUID: IifK6F6HTD6d3kk7jj6GKg==
X-CSE-MsgGUID: FJEzEdwnRcy2EKyguqzUNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="75800158"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="75800158"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 15:39:32 -0700
X-CSE-ConnectionGUID: NPU3C3FXR5CwGC12OgHOIw==
X-CSE-MsgGUID: acfT6cBoR0ScYM31DdQg7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168716205"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.135.148])
  by orviesa007.jf.intel.com with ESMTP; 22 Aug 2025 15:39:31 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	colinmitchell@google.com,
	chao.gao@intel.com,
	abusse@amazon.de,
	chang.seok.bae@intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/cpu/topology: Make primary thread mask available with SMP=n
Date: Fri, 22 Aug 2025 15:39:29 -0700
Message-ID: <20250822223929.12483-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <04cb59cb-e9ed-489c-b36f-6c6209b2e93f@intel.com>
References: <04cb59cb-e9ed-489c-b36f-6c6209b2e93f@intel.com>
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
This improvement was identified from feedback on a feature-enabling
series [*], where a user of this mask is introduced. It is posted here as
a standalone patch for clarity and self-containment. The next revision of
that series will depend on this.

[*] https://lore.kernel.org/lkml/20250813172649.15474-1-chang.seok.bae@intel.com/
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
index dcf05c64dd82..6a76caf813d6 100644
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


