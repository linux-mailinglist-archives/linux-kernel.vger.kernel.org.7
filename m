Return-Path: <linux-kernel+bounces-838382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EAABAF0B3
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2463B19442E3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BD22D3EF2;
	Wed,  1 Oct 2025 02:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A7rqX/R9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC0D2D322E
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759287331; cv=none; b=nUZYJYAdzCBIMqjKiZTOX9+4tvSpsRnvQ1U0UM+C4H162QUc+0Z4BjE/8GZarW0Fcmexbyrk/5oWcWqt6LnsBWCvMafct02jcOepAenDB0loiNENrsrGHRHzxWmUDAzVBSiEUVXkPBxrxqBwIhRKQYxyj6tR6X45q5yweCG0IZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759287331; c=relaxed/simple;
	bh=R1N6ZO22N35zpImTc/SKCF7m0x1qzhG+Jw9Z6fTFvVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMKAex0acs5W79UqN8/NY2ZPa6cr4qqP4UVMqCSYrxtNL923J+zIKBwOgWHT3gV9eMr57XRfDnQ+RH45JThZ0JnpTBNXPB16NyYp73aPdVwYmUm9aVBVTjCANZ8ddPoWKqMAP/EvYg8Fth1CzdwSl8P6yxXVmdXDHKwrJ9ziF90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A7rqX/R9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759287329; x=1790823329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R1N6ZO22N35zpImTc/SKCF7m0x1qzhG+Jw9Z6fTFvVw=;
  b=A7rqX/R9uKI3kfdjzDT0svUvHX/DcMxUt/7BHrHEAuzYkNhKPmCM1VM3
   D9UrujQwKEB3oiwpFbWYuqPJkWCGo8Wo4jafzqr6k7Y5CPTk7guTAbSxq
   mCWgejA6buTXwqDLQhJJ7fJYYXsI2FDDDSmxIMBj/0vKe1kCsD3kA7y8M
   1INCP5vQP5dB3bT6Ywd+comCvcDttc7GF5+ZO4JuNDpE0c2tt7V7wu0Bz
   iKYw8odZcK/iPd+1y73Qu3J3hsV6IkUZXolIzDtc4M3ey8MSoqaoAoijt
   LWQyjm5UXIpY06rjRRZZwmA1kKVbPCa6DD9ODc17GxfHSWPryyA/e18Z5
   g==;
X-CSE-ConnectionGUID: zU7ifFu2ROaPxG3J5Pk9Dg==
X-CSE-MsgGUID: KfO7B5wPRkCZfFcvpabOYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61662414"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="61662414"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:55:29 -0700
X-CSE-ConnectionGUID: MFkBaBF3TWOrhtRoAtJh4A==
X-CSE-MsgGUID: wes74529Q+e/VOq6FD/qHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="178629272"
Received: from 984fee019967.jf.intel.com ([10.165.54.94])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:55:28 -0700
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
	"Kirill A. Shutemov" <kas@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 20/21] x86/virt/tdx: Update tdx_sysinfo and check features post-update
Date: Tue, 30 Sep 2025 19:53:04 -0700
Message-ID: <20251001025442.427697-21-chao.gao@intel.com>
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

tdx_sysinfo contains all metadata of the active TDX module, including
versions, supported features, and TDMR/TDCS/TDVPS information. These
elements may change over updates. Blindly refreshing the entire tdx_sysinfo
could disrupt running software, as it may subtly rely on the previous state
unless proven otherwise.

Adopt a conservative approach, like microcode updates, by only refreshing
version information that does not affect functionality, while ignoring
all other changes. This is acceptable as new modules are required to
maintain backward compatibility.

Any updates to metadata beyond versions should be justified and reviewed on
a case-by-case basis.

Note that preallocating a tdx_sys_info buffer before updates is to avoid
having to handle -ENOMEM when updating tdx_sysinfo after a successful
update.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
---
v2:
 - don't add a separate function for version and feature checks. Do them
   directly in tdx_module_post_update()
 - add a comment about preallocating a tdx_sys_info buffer in
   seamldr_install_module().
---
 arch/x86/virt/vmx/tdx/seamldr.c | 12 ++++++++-
 arch/x86/virt/vmx/tdx/tdx.c     | 47 +++++++++++++++++++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx.h     |  2 ++
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index a8ca6966beac..a72f6b0b27e9 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -350,6 +350,16 @@ int seamldr_install_module(const u8 *data, u32 size)
 	if (!info->num_remaining_updates)
 		return -ENOSPC;
 
+	/*
+	 * Preallocating a tdx_sys_info buffer before updates is to avoid having to
+	 * handle -ENOMEM when updating tdx_sysinfo after a successful update.
+	 */
+	struct tdx_sys_info *sysinfo __free(kfree) = kzalloc(sizeof(*sysinfo),
+							     GFP_KERNEL);
+	if (!sysinfo)
+		return -ENOMEM;
+
+
 	struct seamldr_params *params __free(free_seamldr_params) =
 						init_seamldr_params(data, size);
 	if (IS_ERR(params))
@@ -367,6 +377,6 @@ int seamldr_install_module(const u8 *data, u32 size)
 	if (ret)
 		return ret;
 
-	return 0;
+	return tdx_module_post_update(sysinfo);
 }
 EXPORT_SYMBOL_GPL_FOR_MODULES(seamldr_install_module, "tdx-host");
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 7613fd16a0ce..128e6ffba736 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1241,6 +1241,53 @@ int tdx_module_run_update(void)
 	return 0;
 }
 
+/*
+ * Update tdx_sysinfo and check if any TDX module features changed after
+ * updates
+ */
+int tdx_module_post_update(struct tdx_sys_info *info)
+{
+	struct tdx_sys_info_version *cur, *new;
+	int ret;
+
+	/* Shouldn't fail as the update has succeeded */
+	ret = get_tdx_sys_info(info);
+	if (ret) {
+		WARN_ONCE(1, "version retrieval failed after update, replace TDX Module\n");
+		return ret;
+	}
+
+	guard(mutex)(&tdx_module_lock);
+
+	cur = &tdx_sysinfo.version;
+	new = &info->version;
+	pr_info("version %u.%u.%02u -> %u.%u.%02u\n", cur->major_version,
+						      cur->minor_version,
+						      cur->update_version,
+						      new->major_version,
+						      new->minor_version,
+						      new->update_version);
+
+	/*
+	 * Blindly refreshing the entire tdx_sysinfo could disrupt running
+	 * software, as it may subtly rely on the previous state unless
+	 * proven otherwise.
+	 *
+	 * Only refresh version information (including handoff version)
+	 * that does not affect functionality, and ignore all other
+	 * changes.
+	 */
+	tdx_sysinfo.version	= info->version;
+	tdx_sysinfo.handoff	= info->handoff;
+
+	if (!memcmp(&tdx_sysinfo, info, sizeof(*info)))
+		return 0;
+
+	pr_info("TDX module features have changed after updates, but might not take effect.\n");
+	pr_info("Please consider a potential BIOS update.\n");
+	return 0;
+}
+
 static bool is_pamt_page(unsigned long phys)
 {
 	struct tdmr_info_list *tdmr_list = &tdx_tdmr_list;
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 983c01c6949a..ca76126880ee 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -3,6 +3,7 @@
 #define _X86_VIRT_TDX_H
 
 #include <linux/bits.h>
+#include <asm/tdx_global_metadata.h>
 
 /*
  * This file contains both macros and data structures defined by the TDX
@@ -124,5 +125,6 @@ int tdx_module_shutdown(void);
 void tdx_module_set_error(void);
 int tdx_cpu_enable(void);
 int tdx_module_run_update(void);
+int tdx_module_post_update(struct tdx_sys_info *info);
 
 #endif
-- 
2.47.3


