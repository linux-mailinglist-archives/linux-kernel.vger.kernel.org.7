Return-Path: <linux-kernel+bounces-838377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3D0BAF0A7
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7266F4E2044
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CD72D062A;
	Wed,  1 Oct 2025 02:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kLjiBl3/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BC82C08CD
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759287322; cv=none; b=sZ1BJ3eu9uJrvvTl63wOtcKxWFCdIZMAimJAEY4hxK9t/EnBgnyugObqarhz9/RFo74e9wh8sVBuh2doy3XYbGanWKTqcZi+sddUmKNRsunm8XO+XObf2sSslZ9bigH85Jmw9l9iDm+8Nmxhpcl2HYqj/+4yalxgIfrH9RDdcmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759287322; c=relaxed/simple;
	bh=gOZl08xistsEVX4pEJ3Cv/6TjlFIW9xUdtZd1G6N6uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQ30O+qbv0SnRjoiOTD2VP1nqbJQxyVivE6c/T8rAESs5/XG2ykodqt2ISvrmpLJbSLflrDVKuiciem49J7wz20hXnAj+wpnYq/prdrW+hY9WkVUzIc1KoCErUfGEHeU92zN7csZf6ii2x+tbZzwTk4zqzGnMMuuADXNaB9nQyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kLjiBl3/; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759287320; x=1790823320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gOZl08xistsEVX4pEJ3Cv/6TjlFIW9xUdtZd1G6N6uA=;
  b=kLjiBl3/7wpChsKxWJ0m7JGmS8wQmElRQ0T5XM0XGFEOJWj0fRc3ccVb
   xrsc45byesYkkRBAVasOJize7OYaE/+vdsFpIhvmDTwuy5ES03fAa2iNa
   Z/fzqRRJXGlc1ZOzHvhZmHpO6e7aB4KoizLBPA+mFzQRW2n6hQHXf4lOz
   kifyOy8yMyle2NMrj6Tq9sDQeSzj1Rxiv7ZwTmqvFZM1Xubr3iuEOObsh
   JKdix+EpI35zHlcaVZu4qPCGaZOxeWmaJWKGdSKmw7FC/ZjroxxSnXHaU
   ZwQrSLeIu/2w7NGFvRkLLSsBzOsj90dcf073kTe7bVJQHzzZnRZqFxtlX
   A==;
X-CSE-ConnectionGUID: TlN1x0oGTwKMQk+Cs18fxQ==
X-CSE-MsgGUID: UwsRKhWBR9yJanGwOFa9+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61662352"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="61662352"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:55:20 -0700
X-CSE-ConnectionGUID: K7RwYJE2S4O6chRpPbbfsQ==
X-CSE-MsgGUID: WIvb16QIT0+7mVEuedXloQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="178629217"
Received: from 984fee019967.jf.intel.com ([10.165.54.94])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:55:19 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	reinette.chatre@intel.com,
	ira.weiny@intel.com,
	kai.huang@intel.com,
	dan.j.williams@intel.com,
	yilun.xu@linux.intel.com,
	sagis@google.com,
	vannapurve@google.com,
	paulmck@kernel.org,
	nik.borisov@suse.com
Cc: Chao Gao <chao.gao@intel.com>,
	Farrah Chen <farrah.chen@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v2 14/21] x86/virt/seamldr: Shut down the current TDX module
Date: Tue, 30 Sep 2025 19:52:58 -0700
Message-ID: <20251001025442.427697-15-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251001025442.427697-1-chao.gao@intel.com>
References: <20251001025442.427697-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TDX Module updates request shutting down the existing TDX module.
During this shutdown, the module generates hand-off data, which captures
the module's states essential for preserving running TDs. The new TDX
Module can utilize this hand-off data to establish its states.

Invoke the TDH_SYS_SHUTDOWN SEAMCALL on one CPU to perform the shutdown.
This SEAMCALL requires a hand-off module version. Use the module's own
hand-off version, as it is the highest version the module can produce and
is more likely to be compatible with new modules as new modules likely have
higher hand-off version.

Generate changes to tdx_global_metadata.{hc} by following the
instructions detailed in [1], after adding the following section to the
tdx.py script:

    "handoff": [
       "MODULE_HV",
    ],

Manually add a check in get_tdx_sys_info_handoff() to guard reading the
"module_hv" field with TDX Module update support as otherwise the field
doesn't exist.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Link: https://lore.kernel.org/kvm/20250226181453.2311849-12-pbonzini@redhat.com/ # [1]
---
v2:
 - add a comment about how handoff version is chosen.
 - remove the first !ret in get_tdx_sys_info_handoff() as we edited the
   auto-generated code anyway
 - remove !! when determining whether a CPU is the primary one
 - remove unnecessary if-break nesting in TDP_SHUTDOWN
---
 arch/x86/include/asm/tdx_global_metadata.h  |  5 +++++
 arch/x86/virt/vmx/tdx/seamldr.c             | 10 ++++++++++
 arch/x86/virt/vmx/tdx/tdx.c                 | 16 ++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx.h                 |  3 +++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 13 +++++++++++++
 5 files changed, 47 insertions(+)

diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/asm/tdx_global_metadata.h
index 40689c8dc67e..8a9ebd895e70 100644
--- a/arch/x86/include/asm/tdx_global_metadata.h
+++ b/arch/x86/include/asm/tdx_global_metadata.h
@@ -40,12 +40,17 @@ struct tdx_sys_info_td_conf {
 	u64 cpuid_config_values[128][2];
 };
 
+struct tdx_sys_info_handoff {
+	u16 module_hv;
+};
+
 struct tdx_sys_info {
 	struct tdx_sys_info_version version;
 	struct tdx_sys_info_features features;
 	struct tdx_sys_info_tdmr tdmr;
 	struct tdx_sys_info_td_ctrl td_ctrl;
 	struct tdx_sys_info_td_conf td_conf;
+	struct tdx_sys_info_handoff handoff;
 };
 
 #endif
diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index fca558b90f72..b9daf11e1064 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -19,6 +19,7 @@
 #include <asm/seamldr.h>
 
 #include "seamcall.h"
+#include "tdx.h"
 
 /* P-SEAMLDR SEAMCALL leaf function */
 #define P_SEAMLDR_INFO			0x8000000000000000
@@ -229,6 +230,7 @@ static struct seamldr_params *init_seamldr_params(const u8 *data, u32 size)
  */
 enum tdp_state {
 	TDP_START,
+	TDP_SHUTDOWN,
 	TDP_DONE,
 };
 
@@ -269,8 +271,12 @@ static void ack_state(void)
 static int do_seamldr_install_module(void *params)
 {
 	enum tdp_state newstate, curstate = TDP_START;
+	int cpu = smp_processor_id();
+	bool primary;
 	int ret = 0;
 
+	primary = cpumask_first(cpu_online_mask) == cpu;
+
 	do {
 		/* Chill out and ensure we re-read tdp_data. */
 		cpu_relax();
@@ -279,6 +285,10 @@ static int do_seamldr_install_module(void *params)
 		if (newstate != curstate) {
 			curstate = newstate;
 			switch (curstate) {
+			case TDP_SHUTDOWN:
+				if (primary)
+					ret = tdx_module_shutdown();
+				break;
 			default:
 				break;
 			}
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index b367bb1d94ed..89b51e270274 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1191,6 +1191,22 @@ int tdx_enable(void)
 }
 EXPORT_SYMBOL_GPL(tdx_enable);
 
+int tdx_module_shutdown(void)
+{
+	struct tdx_module_args args = {};
+
+	/*
+	 * Shut down the TDX Module and prepare handoff data for the next
+	 * TDX Module. This SEAMCALL requires a hand-off module version.
+	 * Use the module's own hand-off version, as it is the highest
+	 * version the module can produce and is more likely to be
+	 * compatible with new modules as new modules likely have higher
+	 * hand-off version.
+	 */
+	args.rcx = tdx_sysinfo.handoff.module_hv;
+	return seamcall_prerr(TDH_SYS_SHUTDOWN, &args);
+}
+
 static bool is_pamt_page(unsigned long phys)
 {
 	struct tdmr_info_list *tdmr_list = &tdx_tdmr_list;
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 82bb82be8567..1c4da9540ae0 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -46,6 +46,7 @@
 #define TDH_PHYMEM_PAGE_WBINVD		41
 #define TDH_VP_WR			43
 #define TDH_SYS_CONFIG			45
+#define TDH_SYS_SHUTDOWN		52
 
 /*
  * SEAMCALL leaf:
@@ -118,4 +119,6 @@ struct tdmr_info_list {
 	int max_tdmrs;	/* How many 'tdmr_info's are allocated */
 };
 
+int tdx_module_shutdown(void);
+
 #endif
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index 0454124803f3..3fdd5cbc21d8 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -100,6 +100,18 @@ static int get_tdx_sys_info_td_conf(struct tdx_sys_info_td_conf *sysinfo_td_conf
 	return ret;
 }
 
+static int get_tdx_sys_info_handoff(struct tdx_sys_info_handoff *sysinfo_handoff)
+{
+	int ret = 0;
+	u64 val;
+
+	if (tdx_supports_runtime_update(&tdx_sysinfo) &&
+	    !(ret = read_sys_metadata_field(0x8900000100000000, &val)))
+		sysinfo_handoff->module_hv = val;
+
+	return ret;
+}
+
 static int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 {
 	int ret = 0;
@@ -109,6 +121,7 @@ static int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 	ret = ret ?: get_tdx_sys_info_tdmr(&sysinfo->tdmr);
 	ret = ret ?: get_tdx_sys_info_td_ctrl(&sysinfo->td_ctrl);
 	ret = ret ?: get_tdx_sys_info_td_conf(&sysinfo->td_conf);
+	ret = ret ?: get_tdx_sys_info_handoff(&sysinfo->handoff);
 
 	return ret;
 }
-- 
2.47.3


