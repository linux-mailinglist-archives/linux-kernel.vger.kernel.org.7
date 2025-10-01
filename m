Return-Path: <linux-kernel+bounces-838379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACE1BAF0B0
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BEB92A0C7D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49D92C08CD;
	Wed,  1 Oct 2025 02:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CRnKx/nH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C23A2D29C7
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759287329; cv=none; b=W/WKiEjY/uojKYSsyjsQSgv1LwyZQOKkvvplCa0Et7RqYYc/g03DCoawMpi8ccfh/V8i7CkP6nNkypuTRMfGP1ray5hSdKJXJrtOdv5tJJxA/a+MbFE5d3ltfaSGO1EkDxJ8cMQ44cPEsYIY8mBOVb3U1expqWs3ozEfyQjx460=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759287329; c=relaxed/simple;
	bh=PeNpMG7ytKGm7nAoGehssroVVx6QgPfNqakoTe2BCEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rA53F2y42o4VRSswD5/kcN//ADz09obaQaKqdraBfvYx1JEqs/4dP4wTegQWT55rG7oG1kBdfu8NltKyF2u0YkUmNTDI/PRXHhSJ001M1eAE7CXsBeg8yeDBQb9QXmgbNC2r3pFvWhEZF9H0O6g1YHAv+BQwRhvymbaM6ZwAx3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CRnKx/nH; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759287327; x=1790823327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PeNpMG7ytKGm7nAoGehssroVVx6QgPfNqakoTe2BCEo=;
  b=CRnKx/nHuc9QS09DOob5ZpSUdeZ0YnDEZkviMlK2N56UT3zYcc0HVark
   jGuUHAJP7l3Zin736viLUkv+DVG5gxbABM6lKyMuUp04Di/oPalb/ajqa
   n3DGXzreqydMWX6PK1/tMyHjmOzha9bqEXsSip+eYsVa+R3OjHEEOR0qU
   JCyIQ9RLuOfyGFyDAm/5tcLnJdtcwA9ubXjX32nxbbyfovWMgKPxv5PXZ
   pCzvfzHI5ih1R//f7WdrnRE7w/rhQsv9tKHg8PPjkB0IOjJegeoa1vO/N
   FSQRCs6goVWkjQB5iHvlj5PPXMZPRFt4J4Mm862Ba9Kk2aXWw+uYe/ANs
   w==;
X-CSE-ConnectionGUID: Lk7xf38vTgWwLreB4L3k8w==
X-CSE-MsgGUID: uVjZzl6ZQI2NcZ76ncKK5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61662386"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="61662386"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:55:26 -0700
X-CSE-ConnectionGUID: ZKddDkwLQ5aTnVipd/DamA==
X-CSE-MsgGUID: wKAAagDCS0GofjVUVGTVAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="178629251"
Received: from 984fee019967.jf.intel.com ([10.165.54.94])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:55:25 -0700
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
Subject: [PATCH v2 17/21] x86/virt/seamldr: Install a new TDX Module
Date: Tue, 30 Sep 2025 19:53:01 -0700
Message-ID: <20251001025442.427697-18-chao.gao@intel.com>
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

After shutting down the running TDX module, the next step is to install the
new TDX Module supplied by userspace.

P-SEAMLDR provides the SEAMLDR.INSTALL SEAMCALL for that. The SEAMCALL
accepts the seamldr_params struct and should be called serially on all
CPUs.

Invoke the SEAMLDR.INSTALL SEAMCALL serially on all CPUs and add a new
spinlock to enforce serialization.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
---
 arch/x86/virt/vmx/tdx/seamldr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index a5aff04a85b9..1bb4ae5ccb0a 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -13,6 +13,7 @@
 #include <linux/mm.h>
 #include <linux/nmi.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/stop_machine.h>
 #include <linux/types.h>
 
@@ -23,6 +24,7 @@
 
 /* P-SEAMLDR SEAMCALL leaf function */
 #define P_SEAMLDR_INFO			0x8000000000000000
+#define P_SEAMLDR_INSTALL		0x8000000000000001
 
 /* P-SEAMLDR can accept up to 496 4KB pages for TDX module binary */
 #define SEAMLDR_MAX_NR_MODULE_4KB_PAGES	496
@@ -45,6 +47,7 @@ struct seamldr_params {
 } __packed;
 
 static struct seamldr_info seamldr_info __aligned(256);
+static DEFINE_RAW_SPINLOCK(seamldr_lock);
 
 static inline int seamldr_call(u64 fn, struct tdx_module_args *args)
 {
@@ -231,6 +234,7 @@ static struct seamldr_params *init_seamldr_params(const u8 *data, u32 size)
 enum tdp_state {
 	TDP_START,
 	TDP_SHUTDOWN,
+	TDP_CPU_INSTALL,
 	TDP_DONE,
 };
 
@@ -278,6 +282,7 @@ static void print_update_failure_message(void)
  */
 static int do_seamldr_install_module(void *params)
 {
+	struct tdx_module_args args = { .rcx = __pa(params) };
 	enum tdp_state newstate, curstate = TDP_START;
 	int cpu = smp_processor_id();
 	bool primary;
@@ -297,6 +302,10 @@ static int do_seamldr_install_module(void *params)
 				if (primary)
 					ret = tdx_module_shutdown();
 				break;
+			case TDP_CPU_INSTALL:
+				scoped_guard(raw_spinlock, &seamldr_lock)
+					ret = seamldr_call(P_SEAMLDR_INSTALL, &args);
+				break;
 			default:
 				break;
 			}
-- 
2.47.3


