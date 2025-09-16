Return-Path: <linux-kernel+bounces-818771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71442B59639
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142C11674E2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7268030E828;
	Tue, 16 Sep 2025 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SqVi+WEP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5298030CDA3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758025854; cv=none; b=ET0dTz9R7qxTsLMaSmzTrX5hmhIka4X01L2dVPq5B4UEdvi0g9Z53aNjKwZ6XgGaWbrl/2JA9BkunMck7mFE69+5NwtH6NvKLS3CjPW+c1bZFlkfR9TV0H8/EsOUqO+l8zrMyXYX63Ln+uQdx+kNNPOuqfWCiaJqX97Evx+0K3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758025854; c=relaxed/simple;
	bh=67qe2cHRWzRfMUP3ME91QmZPRdAfH2+ZYKLVwC5M8ik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U7YiColJmTk6GUaDi3WMB94WoIhRm/bGVmvwnKZlo4LZcV2tTKwR4zqp6lz0+RxMfjrzWReX4RKfYUMxNjueMIcBL0jaw8vAvMNSOJyvF4xVMUylv9qeJ+jMgtvmVZMS81+K70SU8Axhdk+K+tSu2TA3q9TGG6IKvyjPuIHm318=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SqVi+WEP; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758025854; x=1789561854;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=67qe2cHRWzRfMUP3ME91QmZPRdAfH2+ZYKLVwC5M8ik=;
  b=SqVi+WEPAi5HX1IZE/nzBn9ntFPIntBDqhCypgZTTuCf3jANUMhK+KlC
   JTUuuyMXt3TTPcldjID2aY0m96NUk1XRS8UAykfg1+ojpO8AHtTQHxzvM
   qjEhsj+HjGsPJ4BwEhNMN4E9B2s3VVU+dYh7kTXr5hEgWspLcbS0wjF3x
   16e58LdZKTrbbQLGwFGyr06UKAtDyEgJp/GYUTOpC2NVuU2I1wpPwZ2H8
   xbZPa00Q5RZRctcwlNcz+PMTKGiXqTuISybmINJsm1IEPaSXIXUEEFv6X
   ExRgniP702I7zsqhJ76jFStCf4idsVkpVttAo2KcQle1tig7E3eJQx0+b
   Q==;
X-CSE-ConnectionGUID: uzodPzsqSH2m2D3B2fhCIA==
X-CSE-MsgGUID: GZWCxYYoT6e34xIdbaWF6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="60446951"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="60446951"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 05:30:53 -0700
X-CSE-ConnectionGUID: 3aecjGYMT6O9Rv3FBnxrSw==
X-CSE-MsgGUID: nlm4VC3sQE+RrHtiECjVYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="175354079"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 16 Sep 2025 05:30:50 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 62F4194; Tue, 16 Sep 2025 14:30:49 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, grom@black.igk.intel.com,
	07110bfd5785d3bff71cebd710db42d6f5c4a643@black.igk.intel.com,
	Mon@black.igk.intel.com, Sep@black.igk.intel.com,
	17@black.igk.intel.com, "00:00:00"@black.igk.intel.com,
	2001@black.igk.intel.com,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 16 Sep 2025 14:29:49 +0200
Message-ID: <20250916123048.3058824-1-andriy.shevchenko@linux.intel.com>
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


