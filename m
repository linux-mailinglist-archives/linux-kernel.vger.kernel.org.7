Return-Path: <linux-kernel+bounces-727354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13F1B018D4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C4158E2224
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D5D283C97;
	Fri, 11 Jul 2025 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YrJMENuc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3408727F19B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227665; cv=none; b=VnGAP+u+eV97TlPABk/qt7Dv0E2ikvrTyUupmj6dcmGMedCOJs+YUcyqA05K8v435MIFE7yb7IqIPW3wTVnSgmk/KKGRr6Plt+1c03JQ9hNva4+ADm50eUL+e6aHkVGJsyUMUbzmpyzPYYdpImyusyyHmkGg+wgtgxA1jiisad0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227665; c=relaxed/simple;
	bh=sPXQ28L2m6IBjCYr20bqC2fecFsA72jS43qusK/x+zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSUgNjgLnZHr8dtCIsNh92hmJTU1EiZ4sKUClD5jXhcsP9ceHWFyylfdn3yL/BGrcmAMW1bUUav4n8H6WTflxxeYrBi6qg1pgytUkEeLNTAhEVu0aV+f8HQSUpoFRCqvDzl/0AVrr+DOAF/97cfDwqAIUTN3Ez5yHT3r0xk8d/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YrJMENuc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752227664; x=1783763664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sPXQ28L2m6IBjCYr20bqC2fecFsA72jS43qusK/x+zc=;
  b=YrJMENucpY8g9zPrAOFe1sqcBXl7qk7v2ak9pFG/SPiM1kWuAC4AP7s8
   nndgvXoawjMHXlEu/G9n4sh7/Q1k+W+X5Rr71LwWvsctzlSmjjmqysGbJ
   Li6QMXeu1xzWBbUZxKvLhDbVby+uOcp7SNzS3SXVFrpTyUlgCgH+7W088
   dGnqgfuX0Dz9h2W/slLu4oaolRgwVrwCzIX6vNSWAePtdVWuF84DFD+Gz
   XXNGdfE9uLYx3fJHkSqtxECEPtunePeIyjny4kXvkD29vUG8YOXdYUzBn
   BfQV5FU4U3yiunqiTd3INoY2mnoN/NRIIrqKqByiJJXOOu7Ac7Eyg4ega
   w==;
X-CSE-ConnectionGUID: 2p3BNPD6RUyQOHvAmrU6DQ==
X-CSE-MsgGUID: s6Q4NELzQQi1u6kMg3SnOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="58332697"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="58332697"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 02:54:23 -0700
X-CSE-ConnectionGUID: hzDtAHmTSeeQcwXJvgxlNA==
X-CSE-MsgGUID: R8+Ov2tlRH+OmZyTMPJhXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="156669855"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 11 Jul 2025 02:54:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8DE816A8; Fri, 11 Jul 2025 12:54:17 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v1 7/7] panic: sys_info: Factor out read and write handlers
Date: Fri, 11 Jul 2025 12:51:13 +0300
Message-ID: <20250711095413.1472448-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250711095413.1472448-1-andriy.shevchenko@linux.intel.com>
References: <20250711095413.1472448-1-andriy.shevchenko@linux.intel.com>
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
index 7483b6e9b30b..32bf639c4de2 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -40,13 +40,52 @@ unsigned long sys_info_parse_param(char *str)
 }
 
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
 
@@ -64,33 +103,10 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
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
2.47.2


