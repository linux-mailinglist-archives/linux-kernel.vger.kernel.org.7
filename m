Return-Path: <linux-kernel+bounces-729207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8343FB03351
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 00:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CAA01893F38
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 22:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C63A1F5858;
	Sun, 13 Jul 2025 22:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="emgs4NJ3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D8818CC13
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 22:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752446057; cv=none; b=AmTQFeQEKYhLonWzlItSGCZg3GtE6frXOp+dP0Bw4k5IODbwB/e7T6Brkx9xE5EaV8RCr7u+16awA/39nSPhdi3g9uaMVFgBRN3JZxYWYn5z1K8hHnLIPPTK8rhffMqsYLi3ZSm6KvewpQTyDc4mECw4Q74lxk76KlQnKj/Uy0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752446057; c=relaxed/simple;
	bh=j4L1eyqmF6qUNnrQ8KGkbfMqReyCQVFQgy/IgZ5DNwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IUvJWqSuKNMFnJ7TtYBQZJJ7OHysI4wpNoxWm5e8nQ1c9U+07F4eWsKTMmqF7FUkTo+0fikW5EdHui28X3wLUsM1Um8aP8XxkclgN9ajDGDSQYu2CmSH3lM3vfYpxINSRlGPw2UGPCgZGO18z9fq07hlDC3ir9mJVGPA05OrArE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=emgs4NJ3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752446056; x=1783982056;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j4L1eyqmF6qUNnrQ8KGkbfMqReyCQVFQgy/IgZ5DNwY=;
  b=emgs4NJ39ivraTqX/Gqo0uwWeng/1UDC3PxxFNqV9vHMXioSWk1Lq0dM
   RpgzLd64YpIDF1p9nxyCWV7XD+Yb1zWwBsfmVWcmRBvvH6qZnS5W9iPay
   1041YjL4bVTYPT5KlY6Dbx5hJrBFh90YflBfUXrPFDpvMmGTsyTy2SNOL
   QgtaJQGufAHQa1J5HoTgLkG6Lx/lz5nd8l34msnEct0hUrahe+M/L0ox/
   UVJ8vLbzIVoeaUhOBsJlOYk5RfplDQ+Kn2O3GU7e3E3y9VhQvwML7E5fj
   5pIcxcLe/J0Y5t/Xl33lNmFK4sIzVx5viYlx7i9SHPMer85nmfB7UTqRV
   w==;
X-CSE-ConnectionGUID: 7VCBuiVxQn2HDTrm1SV53A==
X-CSE-MsgGUID: Xd8JbaPMRmCTXmbrixEXcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65340321"
X-IronPort-AV: E=Sophos;i="6.16,309,1744095600"; 
   d="scan'208";a="65340321"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 15:34:15 -0700
X-CSE-ConnectionGUID: +WY7Qn+oQAq44ZcMQandvg==
X-CSE-MsgGUID: +xh/bPzRRzCFoY1Nw5cNUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,309,1744095600"; 
   d="scan'208";a="161102529"
Received: from gpacheco-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.223.7])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 15:34:11 -0700
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
Subject: [PATCH v3] x86/virt/tdx: Further fix tdh_vp_enter() calls instrumentable code warning
Date: Mon, 14 Jul 2025 10:34:03 +1200
Message-ID: <20250713223403.157062-1-kai.huang@intel.com>
X-Mailer: git-send-email 2.50.0
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
Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---

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
 

base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
-- 
2.50.0


