Return-Path: <linux-kernel+bounces-818801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D71E8B596A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FFB71BC7E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D752421CC59;
	Tue, 16 Sep 2025 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nkMGbB8S"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C906521B918
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758027112; cv=none; b=Q0cMjXV4EG/7OilwFruhC2CgmqvXwcgDPfv5hGqiZdgpkeicb9PY+uXqB/kZ6KUpoYpjKer+Ao6eGPC2utbGcd2xX28WIaQzG8qv2bHbKM7ycYo3g7z49KTIzDrsc9QNRMC4NGQiz9o+VYYjtpmrWPDW4wouGJIsXJYNem785N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758027112; c=relaxed/simple;
	bh=67qe2cHRWzRfMUP3ME91QmZPRdAfH2+ZYKLVwC5M8ik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aryGNV1fcamtQI/rcQJ8smiK4U+qj9eYlnNhlLaxgZx31l3x69YC0NDYbf3KxJsRe/vp8uXrppYNdSVnhQiBH5SKgd23RH+bCQ3fBOg4bMR5JXtRcR23GFSb2N0P8k46XnDyTmjl6m2R4/AoOTavD61aDiJB9WExKpeRdoxAs9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nkMGbB8S; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758027111; x=1789563111;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=67qe2cHRWzRfMUP3ME91QmZPRdAfH2+ZYKLVwC5M8ik=;
  b=nkMGbB8SHUzTs4Pi0IrLU6UHlsRCpWi3lrRmsPF8WHQ4a6EiWw0uU1kP
   /bi/55KjH0WfC1M6Efx2qRTqGtYqtP5y42Q6jkNNHK9JzsgxMNwJaV7ug
   U2cWO6ciLLyqTl7+JnoFxaloztycQhYV6fB/bi1pj8Z34lGj9cu9CKKzK
   cdW3vA858hRKql74/xcX23ERyCUR9AqJKXvur5KwiAxiBPyfy9152mnWR
   MIXP3nx1E5PHl2qDTqib+aKC0nq/KTpgIItPnpoKjtd/bs42ebqMGbcdA
   ab92HBGLB8pFEMYmMe13lYf+v6bqtANOLGuESSaNU6NzkJGF7DWAFBTiZ
   g==;
X-CSE-ConnectionGUID: ZHVHZsvSSASlNcxBx+W5ww==
X-CSE-MsgGUID: lxTjqcw2RyuWJ41gvmWKxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60364100"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60364100"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 05:51:50 -0700
X-CSE-ConnectionGUID: h8Lkt1NbTRqMIpPbxHGW6Q==
X-CSE-MsgGUID: 7PQfZTs0R2W/sucx0zx+gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174537453"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 16 Sep 2025 05:51:46 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 83F2895; Tue, 16 Sep 2025 14:51:45 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [resend, PATCH v2 1/1] kexec: Remove unused code in kimage_load_cma_segment()
Date: Tue, 16 Sep 2025 14:51:09 +0200
Message-ID: <20250916125124.3094021-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clang is not happy about set but unused variable:

kernel/kexec_core.c:745:16: error: variable 'maddr' set but not used [-Werror,-Wunused-but-set-variable]
  745 |         unsigned long maddr;
      |                       ^
1 error generated.

Fix the compilation breakage (`make W=1` build) by removing unused variable.

As Nathan noted, GCC 16 produces the similar warning;

Fixes: f4fecb50d6e1 ("kexec_core: remove superfluous page offset handling in segment loading")
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: fixed Fixes (Nathan), added a note about GCC (Nathan), added tag (Nathan)

 kernel/kexec_core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 5357ed39e9d1..32722926bc7e 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -742,7 +742,6 @@ static int kimage_load_cma_segment(struct kimage *image, int idx)
 	struct kexec_segment *segment = &image->segment[idx];
 	struct page *cma = image->segment_cma[idx];
 	char *ptr = page_address(cma);
-	unsigned long maddr;
 	size_t ubytes, mbytes;
 	int result = 0;
 	unsigned char __user *buf = NULL;
@@ -754,7 +753,6 @@ static int kimage_load_cma_segment(struct kimage *image, int idx)
 		buf = segment->buf;
 	ubytes = segment->bufsz;
 	mbytes = segment->memsz;
-	maddr = segment->mem;
 
 	/* Then copy from source buffer to the CMA one */
 	while (mbytes) {
@@ -782,7 +780,6 @@ static int kimage_load_cma_segment(struct kimage *image, int idx)
 		}
 
 		ptr    += mchunk;
-		maddr  += mchunk;
 		mbytes -= mchunk;
 
 		cond_resched();
-- 
2.50.1


