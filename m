Return-Path: <linux-kernel+bounces-838378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C21EBAF0AD
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706A32A0F81
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B849283C83;
	Wed,  1 Oct 2025 02:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3qwmEBm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7FC2D24BA
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759287327; cv=none; b=jrCSWrt0fRQd0xOP22O5iWjIp3swkWBpLNkZMztznbkOl/D4upnFgtlEOKVtx32SsWtDs1aPgWLj9fNeMLVUsTqxqUlMvupNe8vKvSdFbcaLc92vpfodBuyN2I04k52D9cnp10El7aoi/nTYz24d0GJsBH5Fal1l4C/ZgimqZ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759287327; c=relaxed/simple;
	bh=+8oiFznQZ9fwld9yKP5Xmw2AlOstCofjF71+bnTOYg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtQBK7ShxfQly2Hv2BCvQLiQRlaSCDJDLB3+iwmYJ5yjx3if520uvgoANvM2EUyXplX0XXgZeOJ0YqrCbdARmd93DgIrIfnUJAc+TiRdbQV1hKwwUch2tb3tjvQRfgkXQRt6VwPsGHcz3QHCrUsm1Gb0Vr+oiG7sA2PLRcBnuzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3qwmEBm; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759287326; x=1790823326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+8oiFznQZ9fwld9yKP5Xmw2AlOstCofjF71+bnTOYg8=;
  b=h3qwmEBmtvPWiykW+E1PEx9TGHPg4zE0mIN2Bd5mREA/TuTuOr46dCah
   BdiaPGfQutbYVb2z7ytdfXYw3VSREjH/j0q0CqgDJqzPb6L7y32LcVfYx
   NH6u2Lp3bN1pgD3+t7+4+Z3n0qjnvLSNuw0o5pdpWoZ35C0d2PXCI0Ii3
   NNJ+M0lnujHg/Bvz/fuMhqX+FAwLWWoD9vs4UB2H2Fa9k1JPcqc/t+mTz
   NzYW9228AKTybeGBbPHdniBw7B3mNvZClNmg/8qjgdImQ7uiL0Fl715UL
   cwFZDghEHfjuW7AL/nBLybUCFiccUbD/BhWKGs0+bm4J6iHlBmnNODcV4
   A==;
X-CSE-ConnectionGUID: 48fg3jkXS2ONPDQksslECg==
X-CSE-MsgGUID: nOqiaj34SuOawBfOP8s+xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61662376"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="61662376"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:55:25 -0700
X-CSE-ConnectionGUID: 7MSVOtR2QSKp08gI6MXf8A==
X-CSE-MsgGUID: ylnDmHplRPmZAF5dEpGKAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="178629245"
Received: from 984fee019967.jf.intel.com ([10.165.54.94])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:55:24 -0700
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
Subject: [PATCH v2 16/21] x86/virt/seamldr: Handle TDX Module update failures
Date: Tue, 30 Sep 2025 19:53:00 -0700
Message-ID: <20251001025442.427697-17-chao.gao@intel.com>
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

Failures encountered after a successful module shutdown are unrecoverable,
e.g., there is no way to restore the old TDX Module.

All subsequent SEAMCALLs to the TDX Module will fail and so TDs have to be
killed.

Report failures through sysfs attributes and log a message to clarify that
SEAMCALL errors are expected in this situation.

To prevent TDX Module update failures, admins are encouraged to use the
user space tool [1] that will perform compatibility and integrity checks
that guarantee TDX Module update success (unless the system's update limit
is exceeded, but the kernel will prevent an update attempt in this case).

Signed-off-by: Chao Gao <chao.gao@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Link: https://github.com/intel/tdx-module-binaries/blob/main/version_select_and_load.py # [1]
---
 arch/x86/virt/vmx/tdx/seamldr.c       | 15 ++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx.c           |  6 ++++++
 arch/x86/virt/vmx/tdx/tdx.h           |  1 +
 drivers/virt/coco/tdx-host/tdx-host.c |  4 ++++
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index b9daf11e1064..a5aff04a85b9 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -264,6 +264,14 @@ static void ack_state(void)
 	}
 }
 
+static void print_update_failure_message(void)
+{
+	static atomic_t printed = ATOMIC_INIT(0);
+
+	if (atomic_inc_return(&printed) == 1)
+		pr_err("update failed, SEAMCALLs will report failure until TDs killed\n");
+}
+
 /*
  * See multi_cpu_stop() from where this multi-cpu state-machine was
  * adopted, and the rationale for touch_nmi_watchdog()
@@ -293,8 +301,13 @@ static int do_seamldr_install_module(void *params)
 				break;
 			}
 
-			if (ret)
+			if (ret) {
 				atomic_inc(&tdp_data.failed);
+				if (curstate > TDP_SHUTDOWN) {
+					tdx_module_set_error();
+					print_update_failure_message();
+				}
+			}
 			ack_state();
 		} else {
 			touch_nmi_watchdog();
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 7019a149ec4b..26357be18fa9 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1219,6 +1219,12 @@ int tdx_module_shutdown(void)
 	return 0;
 }
 
+void tdx_module_set_error(void)
+{
+	/* Called from stop_machine(). no need to hold tdx_module_lock */
+	tdx_module_status = TDX_MODULE_ERROR;
+}
+
 static bool is_pamt_page(unsigned long phys)
 {
 	struct tdmr_info_list *tdmr_list = &tdx_tdmr_list;
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 1c4da9540ae0..5b9a2d63808c 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -120,5 +120,6 @@ struct tdmr_info_list {
 };
 
 int tdx_module_shutdown(void);
+void tdx_module_set_error(void);
 
 #endif
diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index 418e90797689..47c5ba115993 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -37,6 +37,10 @@ static ssize_t version_show(struct device *dev, struct device_attribute *attr,
 	const struct tdx_sys_info *tdx_sysinfo = tdx_get_sysinfo();
 	const struct tdx_sys_info_version *ver;
 
+	/*
+	 * Inform userspace that the TDX module isn't in a usable state,
+	 * possibly due to a failed update.
+	 */
 	if (!tdx_sysinfo)
 		return -ENXIO;
 
-- 
2.47.3


