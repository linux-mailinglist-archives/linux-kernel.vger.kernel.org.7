Return-Path: <linux-kernel+bounces-878298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD2AC20337
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F304034EE78
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952C7354AF5;
	Thu, 30 Oct 2025 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WFKIns/G"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E9E239072
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761830423; cv=none; b=BCKVHRrFmd+f9cMobA7AZZFM9CvKD0AYBULANAsKaHj+NNk4rnnOCuf+bkkko6xcxDcOhSL64lM3+Jrj1buGeo5+JVU1iSnqaaZhVrS9OA2xspq1LvveTxJHMcQyqVoOLmtTMqMqtVyFn0Q14+VRq8ZriU9Llb6aUNVoQCVAWHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761830423; c=relaxed/simple;
	bh=pipPwBd5AyvREjP14OzA37kDTkYMiAbD24jynGRexI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+CUbTQwv1ArRnBbqZnMb3CohknSHPy5if52J0NocuUen95OX/ZmpndIALQ73NnLgJsXzkqPolQSfgtWcJV6j4uBYyPBK+pCVBSHUwYF+eGDW1ZCZsgzxG7uFTGurO2epsdIRlEXq2c0uCYthMl68Nc4Unop/cIpgbTN4uoOcwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WFKIns/G; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761830421; x=1793366421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pipPwBd5AyvREjP14OzA37kDTkYMiAbD24jynGRexI0=;
  b=WFKIns/GxqPPWWTo50pZl8dvWgoE57bUlS6n/h5mftlApwiuJiDC84IU
   YrpzQ1XtwNpQAXJ3Z5CkrNBzYzDgAWQrQ93DVgf07s9JfljnAyz9kNuRH
   J4CNxGwIbpfMwAqaXp6NzdVNAlM/0gkcW8hDZZ88cTPrxsqPKvlo3mBIR
   vLrnSDwuCx0MV45n1NQ1cJe+rOSlpnr3zreD7bybBE4blsyCMEaTa264d
   qZ0+Sy8Rj4J9w+SvJDNov18brY+iS7XMvWopcDtgJM7Gtz2+zdkawfse0
   Fw4PmEktfaMOMrpb9nUTeBIFgpOoedBTPG2suaTbGnwRux/EUK9HlrGgf
   w==;
X-CSE-ConnectionGUID: Sr++BTtgTvm3ALpstdr7CA==
X-CSE-MsgGUID: gbkOVWm2Tdi1NS7QXoIckg==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64067351"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="64067351"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 06:20:20 -0700
X-CSE-ConnectionGUID: t+UIWPqST/Sey8yQpZ7asw==
X-CSE-MsgGUID: PPbksveWReucsvYv7ujaOQ==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 30 Oct 2025 06:20:19 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 7BD7C9A; Thu, 30 Oct 2025 14:20:18 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 4/6] panic: sys_info: Rewrite a fix for a compilation error (`make W=1`)
Date: Thu, 30 Oct 2025 12:44:20 +0100
Message-ID: <20251030132007.3742368-5-andriy.shevchenko@linux.intel.com>
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

Compiler was not happy about dead variable in use:

lib/sys_info.c:52:19: error: variable 'sys_info_avail' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
   52 | static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
      |                   ^~~~~~~~~~~~~~

This was fixed by adding __maybe_unused attribute that just hides the issue
and didn't actually fix the root cause. Rewrite the fix by moving the local
variable from stack to a heap.

As a side effect this drops unneeded "synchronisation" of duplicative info
and also makes code ready for the further refactoring.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/sys_info.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/lib/sys_info.c b/lib/sys_info.c
index 29a63238b31d..eb5c1226bfc8 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/array_size.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/console.h>
 #include <linux/log2.h>
 #include <linux/kernel.h>
@@ -11,10 +13,6 @@
 
 #include <linux/sys_info.h>
 
-/*
- * When 'si_names' gets updated,  please make sure the 'sys_info_avail'
- * below is updated accordingly.
- */
 static const char * const si_names[] = {
 	[ilog2(SYS_INFO_TASKS)]			= "tasks",
 	[ilog2(SYS_INFO_MEM)]			= "mem",
@@ -45,25 +43,32 @@ unsigned long sys_info_parse_param(char *str)
 
 #ifdef CONFIG_SYSCTL
 
-static const char sys_info_avail[] __maybe_unused = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
-
 int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
 					  void *buffer, size_t *lenp,
 					  loff_t *ppos)
 {
-	char names[sizeof(sys_info_avail)];
 	struct ctl_table table;
 	unsigned long *si_bits_global;
 	unsigned long si_bits;
+	unsigned int i;
+	size_t maxlen;
 
 	si_bits_global = ro_table->data;
 
+	maxlen = 0;
+	for (i = 0; i < ARRAY_SIZE(si_names); i++)
+		maxlen += strlen(si_names[i]) + 1;
+
+	char *names __free(kfree) = kzalloc(maxlen, GFP_KERNEL);
+	if (!names)
+		return -ENOMEM;
+
 	if (write) {
 		int ret;
 
 		table = *ro_table;
 		table.data = names;
-		table.maxlen = sizeof(names);
+		table.maxlen = maxlen;
 		ret = proc_dostring(&table, write, buffer, lenp, ppos);
 		if (ret)
 			return ret;
@@ -74,16 +79,15 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
 		return 0;
 	} else {
 		/* for 'read' operation */
+		unsigned int len = 0;
 		char *delim = "";
-		int i, len = 0;
 
 		/* The access to the global value is not synchronized. */
 		si_bits = READ_ONCE(*si_bits_global);
 
-		names[0] = '\0';
 		for_each_set_bit(i, &si_bits, ARRAY_SIZE(si_names)) {
 			if (*si_names[i]) {
-				len += scnprintf(names + len, sizeof(names) - len,
+				len += scnprintf(names + len, maxlen - len,
 						 "%s%s", delim, si_names[i]);
 				delim = ",";
 			}
@@ -91,7 +95,7 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
 
 		table = *ro_table;
 		table.data = names;
-		table.maxlen = sizeof(names);
+		table.maxlen = maxlen;
 		return proc_dostring(&table, write, buffer, lenp, ppos);
 	}
 }
-- 
2.50.1


