Return-Path: <linux-kernel+bounces-764374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4374EB2223B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181C12A55B8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8A32E613C;
	Tue, 12 Aug 2025 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m/TumD0k"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EEA2E1C74
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988975; cv=none; b=lQfowLIYjNyqWUhq7Q7faGN7Y9w8/87HltZx7Cauae+3il6bpFMC2ShRS2t5xX21eF+gBIEebiy2PF+4xWI3ePjfBgpGBfblqBXIvfzUPTUjlBhQdPtn1xUtqPwJflrvGFfe3GsWD49r5zDnnixCSD6QL8P+XW0Jk5KeQatpu/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988975; c=relaxed/simple;
	bh=tobUolTXz0tDjm61FM5CSCCyx9QbzmoQTKqs+6i8Ypw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VMc5cwR5YOFDgNP2ENcmA77NMVnzxU4VVxw43+fvc0cBlQCtRgwjjnEypS4xc5haMCIefP+Q5uIbg8+4eBuCFt0CJCZS4VEMVfYHPqweEf4imdzw6pY357g+xcUDvP6wQRvgHXyiSsweYl13t7bNNRSRaoJAGSFRNIDkmbtM/HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m/TumD0k; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754988974; x=1786524974;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tobUolTXz0tDjm61FM5CSCCyx9QbzmoQTKqs+6i8Ypw=;
  b=m/TumD0kf1Fcxj5QNwgfODiHMhlVZZaWuSVAHTkn1CDJfAC07q3zXhkN
   zDgY7aIU9s/0z/ClohHP3cqBySJNvby9ObcVkUo12sMgx9kxAM1dI1UMu
   ON/PebijY3ZTxaRp5QZKruhvd906U2uv8VRuPdj9yDvYe1naxcC4WRTqR
   Mgm47zPTJsV1wkYXFamhgAM85gU9QdyDK3bstBwqCdg1xTHUEcaIOOaEG
   hJlOws9C0JgGm/CHLBAEuTLrmUtHyqxecK7BB19G0ODQ8dPo+fLdgMix8
   w/ZM0wePx0Z3u5VXc1JA3Hzyq2ntvWTrOKzmfyTVtd83xD0ik94sPPvco
   A==;
X-CSE-ConnectionGUID: F3VhlY82S1eNz522HQ2Gaw==
X-CSE-MsgGUID: jHEFmdmsStmm5FkHvXU9Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="61055786"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="61055786"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 01:56:13 -0700
X-CSE-ConnectionGUID: xsv+Lj+pS9mva4Vqo2sPvg==
X-CSE-MsgGUID: kuWNy6/VRVixM9Tnf42RWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="197146794"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.222.28])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 01:56:10 -0700
From: Kai Huang <kai.huang@intel.com>
To: dave.hansen@intel.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	bp@alien8.de,
	mingo@redhat.com,
	hpa@zytor.com
Cc: kas@kernel.org,
	rick.p.edgecombe@intel.com,
	pbonzini@redhat.com,
	seanjc@google.com,
	x86@kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] x86/virt/tdx: Further fix tdh_vp_enter() calls instrumentable code warning
Date: Tue, 12 Aug 2025 20:56:02 +1200
Message-ID: <20250812085602.149073-1-kai.huang@intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tdh_vp_enter() needs to be marked noinstr, which means it can't call any
non-inlined noinstr functions.  Commit e9f17038d814 ("x86/tdx: mark
tdh_vp_enter() as __flatten") tried to address a build warning caused by
tdx_tdvpr_pa() not getting inlined.  Unfortunately that commit didn't
fix the warning completely due to the inconsistent behavior of the
__flatten annotation.

There are two problems that can come up depending on the compiler and
config.  One is that tdx_tdvpr_pa() doesn't get inlined, the other is
that page_to_phys() doesn't get inlined.

The __flatten annotation makes the compiler inline all function calls
that the annotated function makes, and the aforementioned commit assumed
this is always honored, recursively.  But it turns out it's not always
true:

 - Gcc may ignore __flatten when CONFIG_CC_OPTIMIZE_FOR_SIZE=y.
 - Clang doesn't support recursive inlining for __flatten, which can
   trigger another similar warning when page_to_phys() calls pfn_valid()
   when CONFIG_DEBUG_VIRTUAL=y.

Therefore using __flatten is not the right fix.

To fix the first problem, remove the __flatten for tdh_vp_enter() and
instead annotate tdx_tdvpr_pa() with __always_inline to make sure it is
always inlined.

To fix the second problem, change tdx_tdvpr_pa() to use
PFN_PHYS(page_to_pfn()) instead of page_to_phys() so that there will be
no more function call inside tdx_tdvpr_pa()[*].

The TDVPR page is always an actual page out of page allocator, so the
additional warning around pfn_valid() check in page_to_phys() doesn't
help a lot anyway.  It's not worth complicating the code for such
warning when CONFIG_DEBUG_VIRTUAL=y.

[*] Since commit cba5d9b3e99d ("x86/mm/64: Make SPARSEMEM_VMEMMAP the
    only memory model") page_to_pfn() has been a simple macro without
    any function call.

Fixes: e9f17038d814 ("x86/tdx: mark tdh_vp_enter() as __flatten")
Cc: stable@vger.kernel.org
Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
v3 -> v4:

 - Add "Cc: stable@vger.kernel.org".
 - Re-generate based on today's tip/master.

v2 -> v3:
 - Add Kirill's Reviewed-by.
 - Re-generate based on today's tip/x86/tdx.

v1 -> v2:
 - Add Rick's Reviewed-by.
 - Re-generate based on today's tip/master.

---
 arch/x86/virt/vmx/tdx/tdx.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index c7a9a087ccaf..f92ceaea2726 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1502,9 +1502,14 @@ static inline u64 tdx_tdr_pa(struct tdx_td *td)
 	return page_to_phys(td->tdr_page);
 }
 
-static inline u64 tdx_tdvpr_pa(struct tdx_vp *td)
+static __always_inline u64 tdx_tdvpr_pa(struct tdx_vp *td)
 {
-	return page_to_phys(td->tdvpr_page);
+	/*
+	 * Don't use page_to_phys() because tdh_vp_enter() calls this
+	 * function from 'noinstr' code, and page_to_phys() can call
+	 * uninlined functions on some compiler/configs.
+	 */
+	return PFN_PHYS(page_to_pfn(td->tdvpr_page));
 }
 
 /*
@@ -1518,7 +1523,7 @@ static void tdx_clflush_page(struct page *page)
 	clflush_cache_range(page_to_virt(page), PAGE_SIZE);
 }
 
-noinstr __flatten u64 tdh_vp_enter(struct tdx_vp *td, struct tdx_module_args *args)
+noinstr u64 tdh_vp_enter(struct tdx_vp *td, struct tdx_module_args *args)
 {
 	args->rcx = tdx_tdvpr_pa(td);
 

base-commit: 4b6b14d20bc04dcab6dd3ad0d5a50a0f473d1c18
-- 
2.50.1


