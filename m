Return-Path: <linux-kernel+bounces-838376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8438FBAF0A4
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14D86189E210
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC7A280329;
	Wed,  1 Oct 2025 02:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NSH4GSrt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC0F2C21ED
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759287322; cv=none; b=Dqtr4qRzBv69jZg9732tHJUVuY+I+Iic4alkVNVGm3vnAV85gX3KBPnTcvc4omuj2IhkOz3GLfNvfLPUGsyKD96Bp/A8mylxgaySSUY9kkGZ53MvjedbygPjo1HNnwjP84mGkOFOTbAmxZE0xjd/J0VFIOQjxO8oKWkojwkV7GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759287322; c=relaxed/simple;
	bh=nzCXNZTa8N2Vjrk3FfPnD8JhlWNEhb7UIR48hd5iWug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cN33RjCio8Eh7ARC+j1iNfhD0ziMW/3XEgeYvp7ccQiD17LgrNJ0dcbx6ymNBCYKGMUd7vbKUgqcd0bvISbIVTISZvlHslv9/auQ77PyOKqPWNSkFk2nFm9TO5p4xy5HAS9/jgHGVTYIMUx8ufQY4CoG4Ud1xpDjSouRuMujyco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NSH4GSrt; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759287321; x=1790823321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nzCXNZTa8N2Vjrk3FfPnD8JhlWNEhb7UIR48hd5iWug=;
  b=NSH4GSrtaVjyUIt5PZLIQQ7dIsfvimkCss70tckyTKZj+CXNXQggBLxg
   T76vG1czzVZwxCyVhc27gdojPekdmN0xdujorzxxhr2+Qj1rMS3IS1lS+
   0Pwi/h4i5zVtiy2EOYVczvT+yYsehhMOSfyps17k/WhlQ2y4NklYvNCju
   cVkwUGp39mwYD6ukGUnDNlTdg2Ff+kgtfK3Hu2CTsmOypzT6fLXkz/Ryw
   7sWx7FR72IF0oSb8iHZ6L//D8ud1IR7Gtces7DmAVHldV9OH/EKf0xoIy
   L7El0SL/aGtG9IdpIcHJ8+ZhziXcy4TBaF/NTv/Pjwr8PhTzASIsGve96
   Q==;
X-CSE-ConnectionGUID: Xh7l8UxfQGyTN4i5db/iIQ==
X-CSE-MsgGUID: alPb0VP6TAijpHDKzwYK+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61662363"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="61662363"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:55:20 -0700
X-CSE-ConnectionGUID: ntN6U0OpQWOrEXctx4qbJQ==
X-CSE-MsgGUID: tn38oSEGRuKC83Qy84j/uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="178629223"
Received: from 984fee019967.jf.intel.com ([10.165.54.94])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:55:20 -0700
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
Subject: [PATCH v2 15/21] x86/virt/tdx: Reset software states after TDX module shutdown
Date: Tue, 30 Sep 2025 19:52:59 -0700
Message-ID: <20251001025442.427697-16-chao.gao@intel.com>
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

The TDX module requires a one-time global initialization (TDH.SYS.INIT) and
per-CPU initialization (TDH.SYS.LP.INIT) before use. These initializations
are guarded by software flags to prevent repetition.

After TDX module updates, the new TDX module requires the same global and
per-CPU initializations, but the existing software flags prevent
re-initialization.

Reset all software flags guarding the initialization flows to allow the
global and per-CPU initializations to be triggered again after updates.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 89b51e270274..7019a149ec4b 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -54,6 +54,9 @@ static struct tdmr_info_list tdx_tdmr_list;
 static enum tdx_module_status_t tdx_module_status;
 static DEFINE_MUTEX(tdx_module_lock);
 
+static bool sysinit_done;
+static int sysinit_ret;
+
 /* All TDX-usable memory regions.  Protected by mem_hotplug_lock. */
 static LIST_HEAD(tdx_memlist);
 
@@ -68,8 +71,6 @@ static int try_init_module_global(void)
 {
 	struct tdx_module_args args = {};
 	static DEFINE_RAW_SPINLOCK(sysinit_lock);
-	static bool sysinit_done;
-	static int sysinit_ret;
 
 	lockdep_assert_irqs_disabled();
 
@@ -1194,6 +1195,7 @@ EXPORT_SYMBOL_GPL(tdx_enable);
 int tdx_module_shutdown(void)
 {
 	struct tdx_module_args args = {};
+	int ret, cpu;
 
 	/*
 	 * Shut down the TDX Module and prepare handoff data for the next
@@ -1204,7 +1206,17 @@ int tdx_module_shutdown(void)
 	 * hand-off version.
 	 */
 	args.rcx = tdx_sysinfo.handoff.module_hv;
-	return seamcall_prerr(TDH_SYS_SHUTDOWN, &args);
+	ret = seamcall_prerr(TDH_SYS_SHUTDOWN, &args);
+	if (ret)
+		return ret;
+
+	tdx_module_status = TDX_MODULE_UNINITIALIZED;
+	sysinit_done = false;
+	sysinit_ret = 0;
+
+	for_each_online_cpu(cpu)
+		per_cpu(tdx_lp_initialized, cpu) = false;
+	return 0;
 }
 
 static bool is_pamt_page(unsigned long phys)
-- 
2.47.3


