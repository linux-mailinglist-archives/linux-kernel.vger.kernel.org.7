Return-Path: <linux-kernel+bounces-838364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D22D3BAF080
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C549B1942D80
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0706227EFEE;
	Wed,  1 Oct 2025 02:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4MCSfyz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC4927AC21
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759287293; cv=none; b=StxpILQRrykdj/Pd5Dx1wQxWR/K5B6fUVZBeDDmgUjvZmOk0V8xYTPIhRBTGKVGTbjf8QGQ5axNg375UExS0wL9gS9gRt2EkOq35OeFubxoXA53JBdhb0dj0BQfWX3MHv7CAaidOHynME0fLPxAsTI5HkvzWjOx8xOv4PkD7iJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759287293; c=relaxed/simple;
	bh=Bm1Rky4SqDIX2DDhUjvproP1XyUcq4gPtKHSlGNNq5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQVf/9BmjEBFFb2Il8BYIxslmz/iNpawX4yxg6mktwsQEBJ/pr74PF7GWKWwfDYzZwz09MqDqdxHtpFW//m93bUCDkU29BhypoKWrn/sp63JHbPXge40DbZWU6091fhYj2Y4hM+kVTHsyxbR8WWZMBJ8E5kfVFxiVkSawcqu91Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4MCSfyz; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759287292; x=1790823292;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bm1Rky4SqDIX2DDhUjvproP1XyUcq4gPtKHSlGNNq5w=;
  b=H4MCSfyz5Bu3Tp7DulQRtYQhA4sFxEjgwMBsa5uKYmWs3LCXsLoS6Zn8
   b1Um1P1yNW+XzSa71dyenAxmHr083aZX303fEruBvvRuUmDpKiRYgh1il
   W8j7FVp8DjX2I3yCpchiZ/BJ5JnwuwRQAS5/xbHZ3F3tGMS4W8m9aemev
   GW7a1nhuIhqfaAtljChuSoZ43vQ5p0V5ceMRfN+5mtwUD9Wt8CBbIIWzo
   vzI7gB80CP5PVocIKWRV3p4i6mzJ66nDfSqCQv9chV9xJhbDgh9SqeG9h
   Axa30KsP7yhrGSzPJaUTwZ8Vm2rz+r1YVUFBdjcNzPv02kcrgkcmCrgnn
   g==;
X-CSE-ConnectionGUID: tcEQGaO7RPaIqI9NU9E0aw==
X-CSE-MsgGUID: rs9EPoMbQZqpKU1/Gd6aoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61662208"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="61662208"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:54:50 -0700
X-CSE-ConnectionGUID: vAnsVhtyR16BsSuEgoGrGQ==
X-CSE-MsgGUID: PdnsPp/CRnCQox3bofkB0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="178629035"
Received: from 984fee019967.jf.intel.com ([10.165.54.94])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:54:49 -0700
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
	"Kirill A. Shutemov" <kas@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 02/21] x86/virt/tdx: Use %# prefix for hex values in SEAMCALL error messages
Date: Tue, 30 Sep 2025 19:52:46 -0700
Message-ID: <20251001025442.427697-3-chao.gao@intel.com>
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

"%#" format specifier automatically adds the "0x" prefix and has one less
character than "0x%".

For conciseness, replace "0x%" with "%#" when printing hexadecimal values
in SEAMCALL error messages.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
---
"0x%" is also used to print TDMR ranges. I didn't convert them to reduce
code churn, but if they should be converted for consistency, I'm happy
to do that.

v2: new
---
 arch/x86/virt/vmx/tdx/tdx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index e406edd28687..f429a5fdced2 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -62,16 +62,16 @@ typedef void (*sc_err_func_t)(u64 fn, u64 err, struct tdx_module_args *args);
 
 static inline void seamcall_err(u64 fn, u64 err, struct tdx_module_args *args)
 {
-	pr_err("SEAMCALL (%llu) failed: 0x%016llx\n", fn, err);
+	pr_err("SEAMCALL (%llu) failed: %#016llx\n", fn, err);
 }
 
 static inline void seamcall_err_ret(u64 fn, u64 err,
 				    struct tdx_module_args *args)
 {
 	seamcall_err(fn, err, args);
-	pr_err("RCX 0x%016llx RDX 0x%016llx R08 0x%016llx\n",
+	pr_err("RCX %#016llx RDX %#016llx R08 %#016llx\n",
 			args->rcx, args->rdx, args->r8);
-	pr_err("R09 0x%016llx R10 0x%016llx R11 0x%016llx\n",
+	pr_err("R09 %#016llx R10 %#016llx R11 %#016llx\n",
 			args->r9, args->r10, args->r11);
 }
 
-- 
2.47.3


