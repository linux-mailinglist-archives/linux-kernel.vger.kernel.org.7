Return-Path: <linux-kernel+bounces-817370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 689D2B5815C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C2151768E2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ED322D792;
	Mon, 15 Sep 2025 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VIZjdQMX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154A0191F89
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951750; cv=none; b=eGcwKlHMFwtatXD+Wya3S9/lIuyQ2ddoe/WYHvUKMzKY98i5ywMd1SI40FJmWr3lEvBMzYbJjadmEPRB4ricnUrCcmau88xGgZA/7m7j2li1Z5kukNdjvof40fgcRXpLqAAzZiD69VOviM4/pcTo4BNUT07KnlrqaKhfismCSPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951750; c=relaxed/simple;
	bh=XSaTVE69Y82izKbCX7lEZ0n9v5yXDvhPB5ubZ5Z3Ya8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IBwnS7D954m7RWghCnXzjjjI98BIuA9Yhxq+d+H/hJCOJaV2BgIyxBi9j/Sa7OHdsP+B2fqJs/vvX79pVkA5JVyEUIxp1xvAmM/F/3Jy6PABDB8XCd8UoTq0TyXbhtX4aP0iUwUnRA75HtvCDUh7/N1A4+35CiuT95SVe0GTbsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VIZjdQMX; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757951748; x=1789487748;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XSaTVE69Y82izKbCX7lEZ0n9v5yXDvhPB5ubZ5Z3Ya8=;
  b=VIZjdQMXW1ou0vnoAw5I4aXDB9SGBH+EvWH43vbpYF57Kuf6zCQ3m4ut
   g4NjgUenDt6Ge/hLmmm7jdBJyYoYPkgqTR/fK1PwzeLiY79H87Mxruamk
   DGiE+SMv2liMCPI3uOyOuf9SPMdURnoyTeuBM3jEygnY6UzvV+KAV9zCe
   0gPnbjR+/6ZATzb6byMbzfhAC80BU9AZ45LD8YUWBbVuiT7Cl5MmRFZRg
   yDi+ShrwU+nSuXLL2ixAF0WqQXETDZ5ncpKuKfzsg8UHncYlPCZOEuXML
   N6uJ2X+mOnUTa8XsZdd7JE+7jFJARvVkN/it53dT6NHsprPK68/Gw/9rt
   g==;
X-CSE-ConnectionGUID: cBp0+7czSmG2yQTF8cocnw==
X-CSE-MsgGUID: jV/v/VElQXi8cVVGs2XfGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="62846008"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="62846008"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 08:55:47 -0700
X-CSE-ConnectionGUID: aDkoebD3TCmck7IT51wYUg==
X-CSE-MsgGUID: Xf2A40I4R7K9ggmEzCL6WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="175095835"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 15 Sep 2025 08:55:45 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5E6C694; Mon, 15 Sep 2025 17:55:44 +0200 (CEST)
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
Subject: [PATCH v1 1/1] kexec: Remove unused code in kimage_load_cma_segment()
Date: Mon, 15 Sep 2025 17:55:43 +0200
Message-ID: <20250915155543.2912469-1-andriy.shevchenko@linux.intel.com>
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

Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
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


