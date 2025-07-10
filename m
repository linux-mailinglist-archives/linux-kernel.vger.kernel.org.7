Return-Path: <linux-kernel+bounces-725217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EA5AFFC18
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C65F77A3DEF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3213728C5AF;
	Thu, 10 Jul 2025 08:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9sv5aQh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498E828C01E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135851; cv=none; b=c5NEpt6WeqoUnW+g7JKilwdKQQMOY1sCsxN5WHEg6l3x5LCdssOCzy6mD3H/PxSA1R8N6vmO2adTuRm13vMl0bqiQzliHpSDwee0cmu489jpq1gAUZq2+WT1PA58ul/DPJQmRlWr+xYrbNWpglug2hs1Cn8LDHzFuiPM7ZpDP4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135851; c=relaxed/simple;
	bh=vbUCxBltSJvT9sv+FCrhP8pAConw986gj+9WibSkHYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mgj0KP3ep09kPKWnl6tXj93HsK+qvCzciIE03btAOzGC7eM9j6lqn1dwaNY6KOl7JBBnv32iy7jHwCYRNz5om5o0GeJc8+C/Rbc3vfiz2rXPO7nIuGUdJ/gGBDuf5axGJIIDL9S8yNjTf4Ds/R1QKDZbRzVq3Fm404bvVZJf88k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9sv5aQh; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752135850; x=1783671850;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vbUCxBltSJvT9sv+FCrhP8pAConw986gj+9WibSkHYw=;
  b=h9sv5aQhdIwzL6uoZJGR/r/1Oui6PJOx8zncSEjnfGGnshiuXYUmZ/yX
   pl7uSEQ0yjS7PSRY/OveTZxLv7cTeJvuRwhacf12SwPuxxI4ak3F8W9qm
   EmuRmrraI5H5G7sPTUnKYmu4mdNqMUaI96LwxfcxEAHkm4D6wrrYYpql/
   j4swz3rQyf7XBlTj7lF55z/40X4VJIgKftxttoE9TMpNpK7PeJcum0wj+
   ioRQWhH3RhEWMnVtSElzVaVN0hRyaNm/2qbE1WYY9sQHGrIP8p1TlYwdj
   FUlReVBh8zBigABGI9iTI8Re/I4ZM0XY/MeKxC4287quWbpKizxhyriPY
   g==;
X-CSE-ConnectionGUID: 9J+Dzo9rQa6SwEFYPkgSig==
X-CSE-MsgGUID: Ubg3Kh2PQkmor6X6U1nLHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54338715"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="54338715"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 01:24:10 -0700
X-CSE-ConnectionGUID: Pe+EUWy4R4Kgs/rea9H2bA==
X-CSE-MsgGUID: bmmXkvNARoa4Da6ifslW4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="161568414"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 10 Jul 2025 01:24:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B23A61B7; Thu, 10 Jul 2025 11:24:05 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] mm/hmm: Move pmd_to_hmm_pfn_flags() to the respective #ifdeffery
Date: Thu, 10 Jul 2025 11:23:53 +0300
Message-ID: <20250710082403.664093-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When pmd_to_hmm_pfn_flags() is unused, it prevents kernel builds with clang,
`make W=1` and CONFIG_TRANSPARENT_HUGEPAGE=n:

  mm/hmm.c:186:29: warning: unused function 'pmd_to_hmm_pfn_flags' [-Wunused-function]

Fix this by moving the function to the respective existing ifdeffery
for its the only user.

See also:

  6863f5643dd7 ("kbuild: allow Clang to find unused static inline functions for W=1 build")

Fixes: 9d3973d60f0a ("mm/hmm: cleanup the hmm_vma_handle_pmd stub")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: fixed Subject prefix

 mm/hmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index e8b26aa838b9..015ab243f081 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -183,6 +183,7 @@ static inline unsigned long hmm_pfn_flags_order(unsigned long order)
 	return order << HMM_PFN_ORDER_SHIFT;
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline unsigned long pmd_to_hmm_pfn_flags(struct hmm_range *range,
 						 pmd_t pmd)
 {
@@ -193,7 +194,6 @@ static inline unsigned long pmd_to_hmm_pfn_flags(struct hmm_range *range,
 	       hmm_pfn_flags_order(PMD_SHIFT - PAGE_SHIFT);
 }
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
 			      unsigned long end, unsigned long hmm_pfns[],
 			      pmd_t pmd)
-- 
2.47.2


