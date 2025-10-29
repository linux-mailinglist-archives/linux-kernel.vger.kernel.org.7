Return-Path: <linux-kernel+bounces-875840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DF2C19EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 482153AF3FD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C10632F761;
	Wed, 29 Oct 2025 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ih58e1Zw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9DA323403
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736366; cv=none; b=OVXXn0LOoP/jHNCnksVc6lo3KKzdxtRpw1wxSIE3E0F5BVJePkVljuXsNk0ZaE1qGsyURejGNgC/jkHYR7qW6FafO0895PQ+EFdpUP4+xX7A2REGPThHrJnqlD1/t+kLGry0mxvUEUU67ftgVZwH3r7/Zx6dYv46EfMBcmQs2FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736366; c=relaxed/simple;
	bh=3pRP7yxnE+8iPkw51mswvJbqXQU4QWREKIulx3P8Fqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hg4FtP8mKDOSNoVb6EHIjo/LddCgOzn1k+lDyw8wquGg5qSrUCanGKZ0z9ef0OAwMRYSMpHpl7DMj52viMswh2RMuGkuxbF3EOwe8SvdMUyydoN/zMTdNRKZ/IX0++LhgNj7iEN7hG6AFGxF+HkC6hG0G64ckqgdNVEcWK8utG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ih58e1Zw; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761736364; x=1793272364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3pRP7yxnE+8iPkw51mswvJbqXQU4QWREKIulx3P8Fqc=;
  b=Ih58e1Zwik7WqRkQvRi9XkngdGpwSr5x2HhCg66CPXWLnIKHlE0ZbWXV
   l27ueCkedZFEmee9GFTLwElPBkjJIHGqd994mBEPJn2MIVkfJMqdN5uqT
   dF7AT+j5sFtFocS+CpEylbI8A7Qeea/8gqvd/vf3AemgMKJ22okXGO+Bi
   jWWwsAs+FM87PzjG7kBsbyHMKxMGwULXk9DN+mhaV1bE2vvs7odxP8+w0
   7S7/m9leBWGC7x4ema+V8gQWk/Hlz9J/lAn4o6Nl1Y6V5btz450e9gVxA
   zn4GQCkDbinC5Yx0Si6B/eU8PiLnE97SJiw4EP9iCRpH4NyJzPHOeavBt
   w==;
X-CSE-ConnectionGUID: KRRTvgh1SwyNt4etWrfVBw==
X-CSE-MsgGUID: 3ytxKmDHSqC/Md7r5toaaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63757587"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63757587"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 04:12:44 -0700
X-CSE-ConnectionGUID: PBCwiIR4T32FjLxNRsJNKg==
X-CSE-MsgGUID: GHUgm2+AQrqSDTQEHlSepg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="184816544"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 29 Oct 2025 04:12:42 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id F1B699B; Wed, 29 Oct 2025 12:12:39 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 6/6] panic: sys_info: Factor out read and write handlers
Date: Wed, 29 Oct 2025 12:07:41 +0100
Message-ID: <20251029111202.3217870-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251029111202.3217870-2-andriy.shevchenko@linux.intel.com>
References: <20251029111202.3217870-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the sake of the code readability and easier maintenance
factor out read and write sys_info handlers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/sys_info.c | 72 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 28 deletions(-)

diff --git a/lib/sys_info.c b/lib/sys_info.c
index c86f52644857..8ed3b4b55854 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -43,13 +43,52 @@ unsigned long sys_info_parse_param(char *str)
 
 #ifdef CONFIG_SYSCTL
 
+static int sys_info_write_handler(struct ctl_table *table,
+				  void *buffer, size_t *lenp, loff_t *ppos,
+				  unsigned long *si_bits_global)
+{
+	unsigned long si_bits;
+	int ret;
+
+	ret = proc_dostring(table, 1, buffer, lenp, ppos);
+	if (ret)
+		return ret;
+
+	si_bits = sys_info_parse_param(table->data);
+
+	/* The access to the global value is not synchronized. */
+	WRITE_ONCE(*si_bits_global, si_bits);
+
+	return 0;
+}
+
+static int sys_info_read_handler(struct ctl_table *table,
+				 void *buffer, size_t *lenp, loff_t *ppos,
+				 unsigned long *si_bits_global)
+{
+	unsigned long si_bits;
+	unsigned int len = 0;
+	char *delim = "";
+	unsigned int i;
+
+	/* The access to the global value is not synchronized. */
+	si_bits = READ_ONCE(*si_bits_global);
+
+	for_each_set_bit(i, &si_bits, ARRAY_SIZE(si_names)) {
+		len += scnprintf(table->data + len, table->maxlen - len,
+				 "%s%s", delim, si_names[i]);
+		delim = ",";
+	}
+
+	return proc_dostring(table, 0, buffer, lenp, ppos);
+}
+
 int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
 					  void *buffer, size_t *lenp,
 					  loff_t *ppos)
 {
 	struct ctl_table table;
 	unsigned long *si_bits_global;
-	unsigned long si_bits;
 	unsigned int i;
 	size_t maxlen;
 
@@ -67,33 +106,10 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
 	table.data = names;
 	table.maxlen = maxlen;
 
-	if (write) {
-		int ret;
-
-		ret = proc_dostring(&table, write, buffer, lenp, ppos);
-		if (ret)
-			return ret;
-
-		si_bits = sys_info_parse_param(names);
-		/* The access to the global value is not synchronized. */
-		WRITE_ONCE(*si_bits_global, si_bits);
-		return 0;
-	} else {
-		/* for 'read' operation */
-		unsigned int len = 0;
-		char *delim = "";
-
-		/* The access to the global value is not synchronized. */
-		si_bits = READ_ONCE(*si_bits_global);
-
-		for_each_set_bit(i, &si_bits, ARRAY_SIZE(si_names)) {
-			len += scnprintf(names + len, maxlen - len,
-					 "%s%s", delim, si_names[i]);
-			delim = ",";
-		}
-
-		return proc_dostring(&table, write, buffer, lenp, ppos);
-	}
+	if (write)
+		return sys_info_write_handler(&table, buffer, lenp, ppos, si_bits_global);
+	else
+		return sys_info_read_handler(&table, buffer, lenp, ppos, si_bits_global);
 }
 #endif
 
-- 
2.50.1


