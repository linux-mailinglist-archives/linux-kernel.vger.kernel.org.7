Return-Path: <linux-kernel+bounces-885490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07113C331DD
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 22:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75C34276B8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 21:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A6634679A;
	Tue,  4 Nov 2025 21:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MmODE4dk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1DB2D0617;
	Tue,  4 Nov 2025 21:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762293308; cv=none; b=XSWnUoY2+0P00Nz3EnCRDTAYWgLnV0V1OYL3NvbEeK4QV8UON0Uj812+RZOGjzGILkRT7gfIRNu4rDTWOpXSO3uJ+ISEh93pkLbOAxOx2EedXJB7P898wHtQ6FBqDI34BFWSYqDpcmgh3VhLJnaiIaX6KGYGssIGyAnB8CZQ554=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762293308; c=relaxed/simple;
	bh=XtFYIIdzImoWcfWI49kkoYxCnjoDIv5jlKYWuagcUxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bawoTdKjZKYvWGaZtLg716DhMG2SQ78ruENCra2aaM564gdKRmS9NvKtlx7Ar7i+bIpxrClT2jCrs9gTqyzBOHeRSmFGBwIvpXmWQGU6zZ45ktSWlF7pxIQQlQGpYHb5cSSJvrREcd8gqnP43hjks04NHXR5uvAi+B0sTkGZ6v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MmODE4dk; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762293306; x=1793829306;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XtFYIIdzImoWcfWI49kkoYxCnjoDIv5jlKYWuagcUxM=;
  b=MmODE4dkqTeGpWDzuZrh7mDuS+QYrWpf3j8rMMiP6GFW1wRNY7lBghh+
   FxP0IWdE7o0J/vHnTxPpEf4ZdUfBqq7H/moVjKDrVZMeEWtoVuvNvdoOi
   gu0Okoq5wyrXbyyNLRyJevTIMQ/eK3AAHSXrWwEFuVM2sEesax7tEtWn0
   SnZ46SrCpUjaaLK/Dj0JKCxYFgGBW/YMUpr1mBqO5r7HQ10v8zYaMMFB7
   EB6iBpk+CNvHhhrlHdOcbLcBYCNz5IB94DTmpn38uRa0gHACKPz2uziYe
   5S9UhCIBZc3rhX8MSqUSQV67DhmTMfYWcLRtFvHnlS4hPJCZpphro+2tN
   g==;
X-CSE-ConnectionGUID: mc8baPUgSyO/TOWqQdXnmg==
X-CSE-MsgGUID: csewYyAcSE2qGJ5TSaSyaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="89863761"
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="89863761"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 13:55:05 -0800
X-CSE-ConnectionGUID: 7QUg1VPAS3C0hKlbrYolOA==
X-CSE-MsgGUID: ofnpmQFWQyexajZy+TLJWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="187718953"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 04 Nov 2025 13:55:04 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 936CB95; Tue, 04 Nov 2025 22:55:03 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] kernel-doc: Issue warnings that were silently discarded
Date: Tue,  4 Nov 2025 22:55:02 +0100
Message-ID: <20251104215502.1049817-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When kernel-doc parses the sections for the documentation some errors
may occur. In many cases the warning is simply stored to the current
"entry" object. However, in the most of such cases this object gets
discarded and there is no way for the output engine to even know about
that. To avoid that, check if the "entry" is going to be discarded and
if there warnings have been collected, issue them to the current logger
as is and then flush the "entry". This fixes the problem that original
Perl implementation doesn't have.

As of Linux kernel v6.18-rc4 the reproducer can be:

$ scripts/kernel-doc -v -none -Wall include/linux/util_macros.h
...
Info: include/linux/util_macros.h:138 Scanning doc for function to_user_ptr
...

while with the proposed change applied it gives one more line:

$ scripts/kernel-doc -v -none -Wall include/linux/util_macros.h
...
Info: include/linux/util_macros.h:138 Scanning doc for function to_user_ptr
Warning: include/linux/util_macros.h:144 expecting prototype for to_user_ptr(). Prototype was for u64_to_user_ptr() instead
...

And with the original Perl script:

$ scripts/kernel-doc.pl -v -none -Wall include/linux/util_macros.h
...
include/linux/util_macros.h:139: info: Scanning doc for function to_user_ptr
include/linux/util_macros.h:149: warning: expecting prototype for to_user_ptr(). Prototype was for u64_to_user_ptr() instead
...

Fixes: 9cbc2d3b137b ("scripts/kernel-doc.py: postpone warnings to the output plugin")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 scripts/lib/kdoc/kdoc_parser.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index ee1a4ea6e725..f7dbb0868367 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -451,6 +451,13 @@ class KernelDoc:
         variables used by the state machine.
         """
 
+        #
+        # Flush the warnings out before we proceed further
+        #
+        if self.entry and self.entry not in self.entries:
+            for log_msg in self.entry.warnings:
+                self.config.log.warning(log_msg)
+
         self.entry = KernelEntry(self.config, self.fname, ln)
 
         # State flags
-- 
2.50.1


