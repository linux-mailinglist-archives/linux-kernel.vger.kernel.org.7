Return-Path: <linux-kernel+bounces-838368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A918BAF08C
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C25C2A0EB5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2730278E47;
	Wed,  1 Oct 2025 02:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jtP7jKX8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCDA27B34A
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759287301; cv=none; b=KmN8NDTAf2nQqN/Mm4D1IIvQm78nxswYBxSdDWCLMVlveU/frjSR5X2YeG5eQnj+NDfpiRr72E++O/aLeCipw4aNnSSxmd03awA1AfHNbAXE5dlEWdcHVLzHgsWhsOHGeD6a5NJuaYQZHKgw7Qoy5W+VXYdu2Is5v7fpFLUYkPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759287301; c=relaxed/simple;
	bh=dXgFGVx1BY/YWNfSeJVbcKd5Xksg+AFq8R3EqWGkTD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNaknzCp5HOQgcpF4niLTRfFUik/NGcIXCbZL50Np9rDVIIWFM1Ulz7DscGx7r0ftdrIp4uFMCvRSsjpi2GZqjcrORBIYJQ1jaUKGdeuin60nIOdLO2bUYbfU+NwFoBC/YNf9VejwwqE+wkgY5b1cjAs57EOJ1vrauNTfi3nZpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jtP7jKX8; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759287300; x=1790823300;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dXgFGVx1BY/YWNfSeJVbcKd5Xksg+AFq8R3EqWGkTD0=;
  b=jtP7jKX8LkQTq7PonkUvgidj70AwGw3oO9bZAkX2wWSJRYoSLEqd3STy
   I0Nxp0Zt/eJuQNkZzFqLbMeKPSFOfE7FCMCnDNKzuPGHpPEde/+szzprd
   axs0Ei8C+PHnghTLgEkT2qFcu9CYernCk4/Pey/XxvndLsgU+ZPuNCJ17
   Gjk+tbukJNaipJMRKPvRaff+pWRbaNZr0K6XO++nLovMQs2e+0Xsw2XhM
   ldEkakRkXETXgNPvP8WC7i4PYtXs4xI1yn49sPiaW8uIYLtRsnMSiKggt
   zznUKKX/kyPW+uiMbiZV66qpfeD5xgHK6WRY5QcPRZFxAygPdKbK5t2xx
   Q==;
X-CSE-ConnectionGUID: 9zDfSxrwSy6B3/E1h86skg==
X-CSE-MsgGUID: ciz1/y4nQtytNLP/2mRxbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61662262"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="61662262"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:54:59 -0700
X-CSE-ConnectionGUID: 6Rjw4Kl1Q7GZHRM+tu8pQg==
X-CSE-MsgGUID: Ac6IyXQfRaGjY2J+V9O8qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="178629084"
Received: from 984fee019967.jf.intel.com ([10.165.54.94])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:54:59 -0700
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
	"Kirill A. Shutemov" <kas@kernel.org>
Subject: [PATCH v2 06/21] x86/virt/seamldr: Retrieve P-SEAMLDR information
Date: Tue, 30 Sep 2025 19:52:50 -0700
Message-ID: <20251001025442.427697-7-chao.gao@intel.com>
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

P-SEAMLDR returns its information e.g., version and supported features, in
response to the SEAMLDR.INFO SEAMCALL.

This information is useful for userspace. For example, the admin can decide
which TDX module versions are compatible with the P-SEAMLDR according to
the P-SEAMLDR version.

Add and export seamldr_get_info() which retrieves P-SEAMLDR information by
invoking SEAMLDR.INFO SEAMCALL in preparation for exposing P-SEAMLDR
version and other necessary information to userspace.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
---
 arch/x86/include/asm/seamldr.h  | 27 +++++++++++++++++++++++++++
 arch/x86/virt/vmx/tdx/seamldr.c | 17 ++++++++++++++++-
 2 files changed, 43 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/include/asm/seamldr.h

diff --git a/arch/x86/include/asm/seamldr.h b/arch/x86/include/asm/seamldr.h
new file mode 100644
index 000000000000..d1e9f6e16e8d
--- /dev/null
+++ b/arch/x86/include/asm/seamldr.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_SEAMLDR_H
+#define _ASM_X86_SEAMLDR_H
+
+#include <linux/types.h>
+
+struct seamldr_info {
+	u32	version;
+	u32	attributes;
+	u32	vendor_id;
+	u32	build_date;
+	u16	build_num;
+	u16	minor_version;
+	u16	major_version;
+	u16	update_version;
+	u8	reserved0[4];
+	u32	num_remaining_updates;
+	u8	reserved1[224];
+} __packed;
+
+#ifdef CONFIG_INTEL_TDX_MODULE_UPDATE
+const struct seamldr_info *seamldr_get_info(void);
+#else
+static inline const struct seamldr_info *seamldr_get_info(void) { return NULL; }
+#endif
+
+#endif
diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index b99d73f7bb08..08c2e3fe6071 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -9,9 +9,16 @@
 #include <linux/irqflags.h>
 #include <linux/types.h>
 
+#include <asm/seamldr.h>
+
 #include "seamcall.h"
 
-static __maybe_unused int seamldr_call(u64 fn, struct tdx_module_args *args)
+/* P-SEAMLDR SEAMCALL leaf function */
+#define P_SEAMLDR_INFO			0x8000000000000000
+
+static struct seamldr_info seamldr_info __aligned(256);
+
+static inline int seamldr_call(u64 fn, struct tdx_module_args *args)
 {
 	unsigned long flags;
 	u64 vmcs;
@@ -54,3 +61,11 @@ static __maybe_unused int seamldr_call(u64 fn, struct tdx_module_args *args)
 	WARN_ONCE(1, "Failed to save/restore the current VMCS");
 	return -EIO;
 }
+
+const struct seamldr_info *seamldr_get_info(void)
+{
+	struct tdx_module_args args = { .rcx = __pa(&seamldr_info) };
+
+	return seamldr_call(P_SEAMLDR_INFO, &args) ? NULL : &seamldr_info;
+}
+EXPORT_SYMBOL_GPL_FOR_MODULES(seamldr_get_info, "tdx-host");
-- 
2.47.3


