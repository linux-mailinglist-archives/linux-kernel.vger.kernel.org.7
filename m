Return-Path: <linux-kernel+bounces-838381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4944DBAF0B6
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97E64A82C3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBAB2D3A86;
	Wed,  1 Oct 2025 02:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OlsYRZY4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A050C2D320E
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759287330; cv=none; b=Vws9WkjCF05RjaKNG7ResOtukzuo8VXqoEuyWP/QraaT67WhNNh5gTjsWwKUeslXxwzoC/TByrhGj1sioizM3386sDZ/KQWJWu/mB+OOC/lPStjeMD5bZflarYe08P4vl7KBQCF8Hs42RCW0Un4gTC/kVo2lr0IHFXNXmfcEpc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759287330; c=relaxed/simple;
	bh=vADsV89PSmvJZOoaBeDe/Vak6cLIKJ6PGY9nGPDgAYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cc9JrX7lPIgSX1eWa39w9E0sHXUSD3DgcRceAlLysmST6Pvu2l0W8nZgtpNQpUbGUUWXOlaPMdzPXjQ+KBwSU2yaQD32khZ5JQmCM6gPU/RSUngs8aAT4JjVCC4OT8wsPbyiPXbGUVOQMbDoH21lxpomHsMhfio1K3NoNVTcCzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OlsYRZY4; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759287329; x=1790823329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vADsV89PSmvJZOoaBeDe/Vak6cLIKJ6PGY9nGPDgAYw=;
  b=OlsYRZY4izcJM37b0JkDw+H1CQR4TK1HeS004KzIOlS5zgCoPQt9fHWN
   T81oz1r1AbQR2eGdet0WosD5Kmkd9JpIFltn7ZF8r3vzSXe332fo5I301
   vsqH5Khg1bNpHdmS5/IrfA/ofnPZyVmxDQjbPLShY8Vp4cPfeT6VMk3In
   VofH+BWCO1sn2ZObAgQUeh4qAgUtpJ8Iuxjcmbk3ngCxaWjbIkYQ+LwtE
   JfcMir6CP0IdxybkWNSEMQydGXgiRdRqXvG7NOUMmBPK5Bqcfl/eL625h
   2XuZm3bugpBHi5O6e7i273nCcKA2kXe2XPSm4T4V6xWI3irshy09bghpm
   w==;
X-CSE-ConnectionGUID: dk1hrcRZQhqF79FKGntv6w==
X-CSE-MsgGUID: TnBigeeoQjSZ+V3swg+2/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61662404"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="61662404"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:55:28 -0700
X-CSE-ConnectionGUID: Ygo/JPnLTUSYx8mEOBB9fQ==
X-CSE-MsgGUID: CRJU+fg4TNObl/3Kp/z9qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="178629263"
Received: from 984fee019967.jf.intel.com ([10.165.54.94])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:55:27 -0700
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
Subject: [PATCH v2 19/21] x86/virt/tdx: Establish contexts for the new TDX Module
Date: Tue, 30 Sep 2025 19:53:03 -0700
Message-ID: <20251001025442.427697-20-chao.gao@intel.com>
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

After being installed, the new TDX Module shouldn't re-configure the
global HKID, TDMRs or PAMTs. Instead, to preserve running TDs, it should
import the handoff data from the old module to establish all necessary
contexts.

Once the import is done, the TDX Module update is complete, and the new
module is ready to handle requests from the VMM and guests.

Call the TDH.SYS.UPDATE SEAMCALL to import the handoff data from the old
module.

Note that the location and the format of handoff data is defined by the
TDX Module. The new module knows where to get the handoff data and how to
parse it. The kernel doesn't need to provide its location, format etc.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
---
 arch/x86/virt/vmx/tdx/seamldr.c |  5 +++++
 arch/x86/virt/vmx/tdx/tdx.c     | 16 ++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx.h     |  2 ++
 3 files changed, 23 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 75bb650d8a16..a8ca6966beac 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -236,6 +236,7 @@ enum tdp_state {
 	TDP_SHUTDOWN,
 	TDP_CPU_INSTALL,
 	TDP_CPU_INIT,
+	TDP_RUN_UPDATE,
 	TDP_DONE,
 };
 
@@ -310,6 +311,10 @@ static int do_seamldr_install_module(void *params)
 			case TDP_CPU_INIT:
 				ret = tdx_cpu_enable();
 				break;
+			case TDP_RUN_UPDATE:
+				if (primary)
+					ret = tdx_module_run_update();
+				break;
 			default:
 				break;
 			}
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 280c2a9f3211..7613fd16a0ce 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1225,6 +1225,22 @@ void tdx_module_set_error(void)
 	tdx_module_status = TDX_MODULE_ERROR;
 }
 
+int tdx_module_run_update(void)
+{
+	struct tdx_module_args args = {};
+	int ret;
+
+	ret = seamcall(TDH_SYS_UPDATE, &args);
+	if (ret) {
+		tdx_module_status = TDX_MODULE_ERROR;
+		pr_info("module update failed: %d\n", ret);
+		return ret;
+	}
+
+	tdx_module_status = TDX_MODULE_INITIALIZED;
+	return 0;
+}
+
 static bool is_pamt_page(unsigned long phys)
 {
 	struct tdmr_info_list *tdmr_list = &tdx_tdmr_list;
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index b903e479e46a..983c01c6949a 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -47,6 +47,7 @@
 #define TDH_VP_WR			43
 #define TDH_SYS_CONFIG			45
 #define TDH_SYS_SHUTDOWN		52
+#define TDH_SYS_UPDATE		53
 
 /*
  * SEAMCALL leaf:
@@ -122,5 +123,6 @@ struct tdmr_info_list {
 int tdx_module_shutdown(void);
 void tdx_module_set_error(void);
 int tdx_cpu_enable(void);
+int tdx_module_run_update(void);
 
 #endif
-- 
2.47.3


