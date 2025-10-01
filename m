Return-Path: <linux-kernel+bounces-838367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7F4BAF089
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FF874E0F32
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6FB28504D;
	Wed,  1 Oct 2025 02:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KK+BjZzz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4D728151C
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759287297; cv=none; b=TO2P/7pW1F3li0NSt6HDpYZHdFLxRzHgFilhMTZqbGebfvcn98lTvLfRSDFwao0knVAWYITGNVCpsaz78KskU4baD+nCix1W3WGWixIaB1AVl0N3J13l+7ojyi/6/VknM8dMGpj4BBMdpSLIiYip+kICoNO8THasmDqpOu+wWsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759287297; c=relaxed/simple;
	bh=J3W0K4fipOWHJ7SpK74rYo8nvs1cADQeyZLuvxDLcBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6FM020opVqpcEI0S1aSPGF62CSx5+oUh2hiQbhIsevSRfm5/wJYC2QYYLGvxUg+zBZ/97kc3RUqpfAewohz71ONBs6izlguKe7FpbF+GFWfzlk+MuaU5pn4OFG1KcigL1DUpW8/IoavkH6zNQyvzi1vxfvpYIHV0UVwpFdf6ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KK+BjZzz; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759287296; x=1790823296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J3W0K4fipOWHJ7SpK74rYo8nvs1cADQeyZLuvxDLcBo=;
  b=KK+BjZzzLO3FbmKAy58BKQfAta4e8mVQLqRRuSARyPCDfiUehWiajC97
   MF2lS6vPql1iA9C30qb0PfCAZoRX0PyNoNIbjs7ckIywYpIRNJNd2KozJ
   Ho0vsXw4RBHNrZlYXjM3pSxjWORJQquTCi3TEY43m0vI8bRuKDgMW6+AK
   /6VKqg7uPv2cuURI+Daizi/FEGb5rLqDheg6V5zoGY1LGN3npXIQ5gn2D
   c9Bb5R5iZXDZhxeeKWE+rR68vTwx6KMpjcEZTZCNyhoiBp7zuKIwikPzl
   qltR3UPxMNb2Konl/KeEbx845msuPrY2rAg9CCeXUE6UqDY8JO7iS9pkC
   g==;
X-CSE-ConnectionGUID: GfR+NUBORUKM4ic0YYp3jA==
X-CSE-MsgGUID: 5UMSGDa2QH+sR1cZGw2toQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61662243"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="61662243"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:54:55 -0700
X-CSE-ConnectionGUID: 8NWfn1+FRDavsOl9jWqbtg==
X-CSE-MsgGUID: vEe6Z6ScQdmWCDK05XrNsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="178629061"
Received: from 984fee019967.jf.intel.com ([10.165.54.94])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:54:54 -0700
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
Subject: [PATCH v2 05/21] x86/virt/seamldr: Introduce a wrapper for P-SEAMLDR SEAMCALLs
Date: Tue, 30 Sep 2025 19:52:49 -0700
Message-ID: <20251001025442.427697-6-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251001025442.427697-1-chao.gao@intel.com>
References: <20251001025442.427697-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Software needs to talk with P-SEAMLDR via P-SEAMLDR SEAMCALLs. So, add a
wrapper for P-SEAMLDR SEAMCALLs.

Save and restore the current VMCS using VMPTRST and VMPTRLD instructions
to avoid breaking KVM. Doing so is because P-SEAMLDR SEAMCALLs would
invalidate the current VMCS as documented in Intel® Trust Domain CPU
Architectural Extensions (May 2021 edition) Chapter 2.3 [1]:

  SEAMRET from the P-SEAMLDR clears the current VMCS structure pointed
  to by the current-VMCS pointer. A VMM that invokes the P-SEAMLDR using
  SEAMCALL must reload the current-VMCS, if required, using the VMPTRLD
  instruction.

Disable interrupts to prevent KVM code from interfering with P-SEAMLDR
SEAMCALLs. For example, if a vCPU is scheduled before the current VMCS is
restored, it may encounter an invalid current VMCS, causing its VMX
instruction to fail. Additionally, if KVM sends IPIs to invalidate a
current VMCS and the invalidation occurs right after the current VMCS is
saved, that VMCS will be reloaded after P-SEAMLDR SEAMCALLs, leading to
unexpected behavior.

NMIs are not a problem, as the only scenario where instructions relying on
the current-VMCS are used is during guest PMI handling in KVM. This occurs
immediately after VM exits with IRQ and NMI disabled, ensuring no
interference with P-SEAMLDR SEAMCALLs.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Link: https://cdrdv2.intel.com/v1/dl/getContent/733582 # [1]
---
v2:
 - don't create a new, inferior framework to save/restore VMCS
 - use human-friendly language, just "current VMCS" rather than
   SDM term "current-VMCS pointer"
 - don't mix guard() with goto
---
 arch/x86/Kconfig                | 10 ++++++
 arch/x86/virt/vmx/tdx/Makefile  |  1 +
 arch/x86/virt/vmx/tdx/seamldr.c | 56 +++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)
 create mode 100644 arch/x86/virt/vmx/tdx/seamldr.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890fe2100..6b47383d2958 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1905,6 +1905,16 @@ config INTEL_TDX_HOST
 
 	  If unsure, say N.
 
+config INTEL_TDX_MODULE_UPDATE
+	bool "Intel TDX module runtime update"
+	depends on TDX_HOST_SERVICES
+	help
+	  This enables the kernel to support TDX module runtime update. This
+	  allows the admin to update the TDX module to the same or any newer
+	  version without the need to terminate running TDX guests.
+
+	  If unsure, say N.
+
 config EFI
 	bool "EFI runtime service support"
 	depends on ACPI
diff --git a/arch/x86/virt/vmx/tdx/Makefile b/arch/x86/virt/vmx/tdx/Makefile
index 90da47eb85ee..26aea3531c36 100644
--- a/arch/x86/virt/vmx/tdx/Makefile
+++ b/arch/x86/virt/vmx/tdx/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y += seamcall.o tdx.o
+obj-$(CONFIG_INTEL_TDX_MODULE_UPDATE) += seamldr.o
diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
new file mode 100644
index 000000000000..b99d73f7bb08
--- /dev/null
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright(c) 2025 Intel Corporation.
+ *
+ * Intel TDX module runtime update
+ */
+#define pr_fmt(fmt)	"seamldr: " fmt
+
+#include <linux/irqflags.h>
+#include <linux/types.h>
+
+#include "seamcall.h"
+
+static __maybe_unused int seamldr_call(u64 fn, struct tdx_module_args *args)
+{
+	unsigned long flags;
+	u64 vmcs;
+	int ret;
+
+	if (!is_seamldr_call(fn))
+		return -EINVAL;
+
+	/*
+	 * SEAMRET from P-SEAMLDR invalidates the current VMCS.  Save/restore
+	 * the VMCS across P-SEAMLDR SEAMCALLs to avoid clobbering KVM state.
+	 * Disable interrupts as KVM is allowed to do VMREAD/VMWRITE in IRQ
+	 * context (but not NMI context).
+	 */
+	local_irq_save(flags);
+
+	asm goto("1: vmptrst %0\n\t"
+		 _ASM_EXTABLE(1b, %l[error])
+		 : "=m" (vmcs) : : "cc" : error);
+
+	ret = seamldr_prerr(fn, args);
+
+	/*
+	 * Restore the current VMCS pointer.  VMPTSTR "returns" all ones if the
+	 * current VMCS is invalid.
+	 */
+	if (vmcs != -1ULL) {
+		asm goto("1: vmptrld %0\n\t"
+			 "jna %l[error]\n\t"
+			 _ASM_EXTABLE(1b, %l[error])
+			 : : "m" (vmcs) : "cc" : error);
+	}
+
+	local_irq_restore(flags);
+	return ret;
+
+error:
+	local_irq_restore(flags);
+
+	WARN_ONCE(1, "Failed to save/restore the current VMCS");
+	return -EIO;
+}
-- 
2.47.3


