Return-Path: <linux-kernel+bounces-838363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02920BAF07D
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 336A01942B35
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C81278E47;
	Wed,  1 Oct 2025 02:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NaH+9oQc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA56627A927
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759287292; cv=none; b=DOQbLupVWtchkqoxtf2/g6e5xSvCFEhMWVHBfQCe8vBSJszZ5dgewzPS1yIWlBkFthVpdJKowWSMV4XrBCFiS9mZuq5bWcXLKECkk45pOyDUN2JR73r1XOb80wHo18fd82Qcu18ZZHOEVPIy7vDiZbjXoi06VbZkYlJLrlWJlnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759287292; c=relaxed/simple;
	bh=yzXsG45V6hDY5JoOy9A7+02aECqQ79Pt6rGJt6bu3fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hh9qwXTv85ULJEycMmXDf55b6QTiK9gzssbuGA9o/PmKqifOFWqiYhBlPLlT585GHh61x04jnE4Mwy5mz7jpwCaXekxOF+QkFjoEF9bdGCeICsV3hpySCmyxTjXG6JMrH0nidLfsNXXljJ9zo2DiFYTf+i/ycYIYID1BoWCcAfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NaH+9oQc; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759287291; x=1790823291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yzXsG45V6hDY5JoOy9A7+02aECqQ79Pt6rGJt6bu3fw=;
  b=NaH+9oQcWhD1jpDbg/kSGH+PJKb1wB7xEvMdGRTpl9RT+WLRjLsagqWV
   ohyYzwTVjQmG6eQofvSB8y50BxE1UR6/JqFhj7Z9LO7IMrO7gMZVNwfp6
   DYvrktmcLllVWPZdzeCRyd91X29HLoeluGnzkXn7zl7jJh3+uR7utCBK1
   PeITrlvQXvq/daN1reDdIUmLwuflHHQ90qgI+BXz1pXzmZ6gzrFuQASrC
   SoWSJHKnzKVBzwoUQlikJa5wTnJ+qcJUmSvY1/8OgkzvC3qvfVEiaa24g
   WGVFLX256S9oVwtu8vN/kp3pX/wXpcUNvtvOTdfzJIC3ZcdXrVMSAqZZl
   w==;
X-CSE-ConnectionGUID: Ga9Vh3jeTa2wwHPF8PwxlA==
X-CSE-MsgGUID: 48f7RWn+Ro2ribqlsQxJeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61662199"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="61662199"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:54:49 -0700
X-CSE-ConnectionGUID: Svg5KCFMQYy8fx0wjCFHbg==
X-CSE-MsgGUID: azAPzeZzTNKGpMY4cQfWfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="178629025"
Received: from 984fee019967.jf.intel.com ([10.165.54.94])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:54:48 -0700
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
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Farrah Chen <farrah.chen@intel.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 01/21] x86/virt/tdx: Print SEAMCALL leaf numbers in decimal
Date: Tue, 30 Sep 2025 19:52:45 -0700
Message-ID: <20251001025442.427697-2-chao.gao@intel.com>
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

Both TDX spec and kernel defines SEAMCALL leaf numbers as decimal. Printing
them in hex makes no sense. Correct it.

Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
---
v2:
 - print leaf numbers with %llu
---
 arch/x86/virt/vmx/tdx/tdx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index ada2fd4c2d54..e406edd28687 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -62,7 +62,7 @@ typedef void (*sc_err_func_t)(u64 fn, u64 err, struct tdx_module_args *args);
 
 static inline void seamcall_err(u64 fn, u64 err, struct tdx_module_args *args)
 {
-	pr_err("SEAMCALL (0x%016llx) failed: 0x%016llx\n", fn, err);
+	pr_err("SEAMCALL (%llu) failed: 0x%016llx\n", fn, err);
 }
 
 static inline void seamcall_err_ret(u64 fn, u64 err,
-- 
2.47.3


