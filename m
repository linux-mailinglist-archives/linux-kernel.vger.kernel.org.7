Return-Path: <linux-kernel+bounces-878299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DABC2035D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B30E4EBA12
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451843563C8;
	Thu, 30 Oct 2025 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n9beZm6+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D557248898
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761830424; cv=none; b=hkIWXkhwhIDmRhTbE9jmi+LPE3cSloVmzbTGt6o/wkJlX6xFFfuhKzrc7YWW/QQVvCbEV18ewJHPEFzjWPKoZA7MG8SiFhf6+fwUrhZ2nF+kS9WuKhJ7RqtPPxnh0K3347n+g4KblF5VZGucN50KtxwVqwzOHo1kklZYJavdHCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761830424; c=relaxed/simple;
	bh=iWlei57EODHFejhXUBF8taQYMWzeXgAy5ZeOWJpOW/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyw4nTz+wBcE7wxPb0qebwuZX34GCFHAFEWrTfMt4PhCx4jsyTt/v/YsJNM/e4KNSXDemDSTQQSTYfBmX5ObisBIdfAEyETGIbnhlvHu5bzSLIdtPtsLX3JweV/++o11JdqwJYZ9zaxPyhT4Q10m0hIqFscBKiB3iCMpdLs3g78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n9beZm6+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761830423; x=1793366423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iWlei57EODHFejhXUBF8taQYMWzeXgAy5ZeOWJpOW/k=;
  b=n9beZm6+1RLBsTR5zsqE4IH7MfUmk37YRCIZRJ+ZHerItoX6+5WV2DbC
   y9wl3EXk8mPJCahT4auiP3N/JLfl7L2R6SrnQs9U47me8H1GMT7xn7Fhh
   v01o2nF394P3a99ipYrieOtrdpuhKAIEmGh/uvXJd83KMW60GCbSCg/vX
   HovKOBvgjHcBUImp/tS/eQL/5SnUV08xWjx9G8peBukv+8PwGXv9RI4eR
   B21MWEnfFGe0Iz93eLvHixzwSxIq/RwD5lwhR7Bg5W84qYZ9DOnmsTC4u
   4vkmwjk3zo65XphWcRrMJj8Eo+3njMzm3U8EjpDBtg94PAqFIPUA67pro
   Q==;
X-CSE-ConnectionGUID: pVV6FEt6QimLhBAPJPalqQ==
X-CSE-MsgGUID: yupXkVsUSn6cFc/HL0NaTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="86597428"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="86597428"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 06:20:22 -0700
X-CSE-ConnectionGUID: TSCf+tGuQCuZv1bxsMhFqw==
X-CSE-MsgGUID: RPbAXf6UTyGZNjzutw5Mqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="185154316"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 30 Oct 2025 06:20:21 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 83A819C; Thu, 30 Oct 2025 14:20:18 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 6/6] panic: sys_info: Factor out read and write handlers
Date: Thu, 30 Oct 2025 12:44:22 +0100
Message-ID: <20251030132007.3742368-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251030132007.3742368-1-andriy.shevchenko@linux.intel.com>
References: <20251030132007.3742368-1-andriy.shevchenko@linux.intel.com>
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
 lib/sys_info.c | 79 +++++++++++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 33 deletions(-)

diff --git a/lib/sys_info.c b/lib/sys_info.c
index 94526de8482b..874b9471a068 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -43,18 +43,56 @@ unsigned long sys_info_parse_param(char *str)
 
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
+		if (*si_names[i]) {
+			len += scnprintf(table->data + len, table->maxlen - len,
+					 "%s%s", delim, si_names[i]);
+			delim = ",";
+		}
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
-	unsigned long *si_bits_global;
-	unsigned long si_bits;
 	unsigned int i;
 	size_t maxlen;
 
-	si_bits_global = ro_table->data;
-
 	maxlen = 0;
 	for (i = 0; i < ARRAY_SIZE(si_names); i++)
 		maxlen += strlen(si_names[i]) + 1;
@@ -67,35 +105,10 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
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
-			if (*si_names[i]) {
-				len += scnprintf(names + len, maxlen - len,
-						 "%s%s", delim, si_names[i]);
-				delim = ",";
-			}
-		}
-
-		return proc_dostring(&table, write, buffer, lenp, ppos);
-	}
+	if (write)
+		return sys_info_write_handler(&table, buffer, lenp, ppos, ro_table->data);
+	else
+		return sys_info_read_handler(&table, buffer, lenp, ppos, ro_table->data);
 }
 #endif
 
-- 
2.50.1


