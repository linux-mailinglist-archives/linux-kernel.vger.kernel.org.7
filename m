Return-Path: <linux-kernel+bounces-838380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77493BAF0AA
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2BF188A4BC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E044283FF1;
	Wed,  1 Oct 2025 02:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ANLxStxt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98AB283FD4
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759287329; cv=none; b=d683f5kzHYKMRCX2PybGZUmfBf+crVIi24lHQZXOQ/7WUAM7BZ2KcGG55LbBQL5RKWyj7nq/h67D9KPPN4O3khWOzP2+CC6GLpJpg3Xo+XM5pn1e8fW+1Eb22LMXyjpLI7UPXEh3suBx5ONwNG8FgeGPu9n7xCI8ZcwJUDirv8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759287329; c=relaxed/simple;
	bh=BC4Zro2fVNDXj3htnYcwR82Ii9j7SNQ7ta0nQBLTK60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJXGLtYKbTF+a/5R6/M0BJYOSwmz2aJsy+QtZmqEk5//2XwVFPd2ZAYmV/KpX6NUk8aqlIJ1jp1PQfUWUMgoc0O9UmIqEWXNbmPWe6/huO6POljWxaK0FdInpIQaH1cDRx+M1lGgrw7gQeZ4GHud9Jighv3N7fTxYMPBk7JXFYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ANLxStxt; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759287328; x=1790823328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BC4Zro2fVNDXj3htnYcwR82Ii9j7SNQ7ta0nQBLTK60=;
  b=ANLxStxtodfppOom9T7ETCPvqq/76b6+J6/hubnF3/7qV840J1rOxsmE
   TJWZYp0rxSHnofN64uBRQekpV5z0is9rT4wnWMWB1ou33LeuuuYitsfLM
   Et64+58o21YPInZyVCUQ2YssNsdc+30j3PzB0i/pjlIhxuH96tesm7coa
   E0uUIf7Vvh/nDTqxBdhu0hIDf7szwnvsRN9zaNeDN0NuTtsBQznjq3rbY
   VQ/0QfmUTeawx6Y8zwZjt22dAUrnr5yDF3FtgyLm9r+FbBzL2Mab6Jgqq
   KPLX5ZFFpOnGuGx83naCPChBmNOstPjTD7+3b8auiJV9FxIcV6rvCcRss
   Q==;
X-CSE-ConnectionGUID: rNYv2gxGRlusOKtMocOJVw==
X-CSE-MsgGUID: Z2NqUjUIQqmD36DYpUKSTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61662395"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="61662395"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:55:27 -0700
X-CSE-ConnectionGUID: tT2APZjqTOmohqsFKmVSCw==
X-CSE-MsgGUID: SeBglYPrSkSB/eowgyxc6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="178629257"
Received: from 984fee019967.jf.intel.com ([10.165.54.94])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:55:26 -0700
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
Subject: [PATCH v2 18/21] x86/virt/seamldr: Do TDX per-CPU initialization after updates
Date: Tue, 30 Sep 2025 19:53:02 -0700
Message-ID: <20251001025442.427697-19-chao.gao@intel.com>
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

After installing the new TDX module, each CPU should be initialized
again to make the CPU ready to run any other SEAMCALLs. So, call
tdx_cpu_enable() on all CPUs.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
---
 arch/x86/virt/vmx/tdx/seamldr.c | 4 ++++
 arch/x86/virt/vmx/tdx/tdx.c     | 2 +-
 arch/x86/virt/vmx/tdx/tdx.h     | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 1bb4ae5ccb0a..75bb650d8a16 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -235,6 +235,7 @@ enum tdp_state {
 	TDP_START,
 	TDP_SHUTDOWN,
 	TDP_CPU_INSTALL,
+	TDP_CPU_INIT,
 	TDP_DONE,
 };
 
@@ -306,6 +307,9 @@ static int do_seamldr_install_module(void *params)
 				scoped_guard(raw_spinlock, &seamldr_lock)
 					ret = seamldr_call(P_SEAMLDR_INSTALL, &args);
 				break;
+			case TDP_CPU_INIT:
+				ret = tdx_cpu_enable();
+				break;
 			default:
 				break;
 			}
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 26357be18fa9..280c2a9f3211 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -106,7 +106,7 @@ static int try_init_module_global(void)
  *
  * Return 0 on success, otherwise errors.
  */
-static int tdx_cpu_enable(void)
+int tdx_cpu_enable(void)
 {
 	struct tdx_module_args args = {};
 	int ret;
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 5b9a2d63808c..b903e479e46a 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -121,5 +121,6 @@ struct tdmr_info_list {
 
 int tdx_module_shutdown(void);
 void tdx_module_set_error(void);
+int tdx_cpu_enable(void);
 
 #endif
-- 
2.47.3


