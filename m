Return-Path: <linux-kernel+bounces-622583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5300CA9E949
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 09:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF304164B2C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 07:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D141D9688;
	Mon, 28 Apr 2025 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mL383CIl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69542BE67
	for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 07:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745825264; cv=none; b=n/NuZxah9GLaSUROcEe61SFLXb45of5M1o4RO+5KMoQocr2udhY0AhLIsMgABqcXUaxBv+vdFfO4gAqzUJBlcnbQDuADV4qU/0AAcYF25vWYOE4VU5jMjjLuIuYJgsR56yUjb2dRtLaMPAn0HuCL8NHahGePLNOAnkZ8m+UsFKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745825264; c=relaxed/simple;
	bh=uuLa9PuejMEFVOYGkNw6Lcd+L7bwy0itJA8DqgQSQgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pn9EXr6wdrH5yyTPZrMNTxmgIQ3Rv83zPhORhTjHnXxFDBkbK2fcRYp5eSxD3csZV56nAHE+GCHGYdMxlIp0MGop3Qp/VrCu6zeHFbOjK8vhqnFPB0oqHhFIhOmO/t9BBMJAjxbo4Gpm2m9Y80A5bbj+yFoXb21PQt0SXgwoKHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mL383CIl; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745825262; x=1777361262;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uuLa9PuejMEFVOYGkNw6Lcd+L7bwy0itJA8DqgQSQgY=;
  b=mL383CIl1Mr60rh52R9b10vyC5pQ0fNU7DLtbd49Kcnv9pARmUQJzgob
   5OFKXL9xGGbRMJY42+IrR4rKSISYW4Kw0wGD8IJ6gHdfatqGUuk4nZ/rK
   rSqiCwxvH9HXp9n851y1Oq/Z0FIQbypusjANsKlco1t7hZqehljAPUr9u
   iK1p/a4rWEdKVEW+1fidQFCs/0IpWU0tfNyspwiS2zMmIOVyQoEuu1Psl
   3smsBXSfl2c/FTaHn00FE9DFLS93pCGEJBCup/7WH434vtLjndjxSGO2n
   SBZWuwiTUhRlehT/dhFIkX3zfATlc2eoDINQY3Jp0qDmnzICr6iwWBJYF
   g==;
X-CSE-ConnectionGUID: hPZIj3UtSISboYDBxpWyDg==
X-CSE-MsgGUID: YL45whFeRvu4FRx+RrbBUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="50057663"
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="50057663"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 00:27:41 -0700
X-CSE-ConnectionGUID: 4LPoyNkFQJScsbv4qtUoFg==
X-CSE-MsgGUID: qwBAkmC7SSeEXoJEOGrBwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="133328525"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 28 Apr 2025 00:27:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 16B7E1BC; Mon, 28 Apr 2025 10:27:38 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Alexandru Ardelean <aardelean@baylibre.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH, resend v1 1/1] util_macros.h: Fix the reference in kernel-doc
Date: Mon, 28 Apr 2025 10:27:37 +0300
Message-ID: <20250428072737.3265239-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In PTR_IF() description the text refers to the parameter as (ptr)
while the kernel-doc format asks for @ptr. Fix this accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/util_macros.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/util_macros.h b/include/linux/util_macros.h
index 93b30c1dce60..dcb836ef0cc3 100644
--- a/include/linux/util_macros.h
+++ b/include/linux/util_macros.h
@@ -88,7 +88,7 @@
  * @ptr: A pointer to assign if @cond is true.
  *
  * PTR_IF(IS_ENABLED(CONFIG_FOO), ptr) evaluates to @ptr if CONFIG_FOO is set
- * to 'y' or 'm', or to NULL otherwise. The (ptr) argument must be a pointer.
+ * to 'y' or 'm', or to NULL otherwise. The @ptr argument must be a pointer.
  *
  * The macro can be very useful to help compiler dropping dead code.
  *
-- 
2.47.2


