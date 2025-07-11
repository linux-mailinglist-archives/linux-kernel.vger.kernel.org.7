Return-Path: <linux-kernel+bounces-727355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E29B018D3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927ED5C09E3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C447283FCF;
	Fri, 11 Jul 2025 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a5XB21Co"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F6827F4CA
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227665; cv=none; b=qZR+UJ1NPp4lt/6fsXAsT+7Ymn+1V8vSGDTIpTX4C96KFEsLSUBrsTVJwMkTtvcmqlkwcIGTHJn+syyr3bnqO2KvUCr2Qp833J79PAtHjZwrGDVE+HATDgmjfAegbaoP/V4kzwKKbERdYDC42nhPzNajOfGdBm8auBAxe1ole8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227665; c=relaxed/simple;
	bh=YadJ8hXt+b1YwyLCgZvgMxZb8stWI+VVpDM/3amT+Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwYG8QzbfNYGgJKMHsORqOP03b5YcSCtD6mupaeae76EtcRvmgvCztRBwERcT8lOKhiJcf7QenuDIbUO3uMMrJj7wmROYx7BHvvewueNBFDmQl8OoMZjmgEFqk0WaUT+CcZ8/J8liJvy967XbLoUkVYmcNdRT4iOi8s3TThnlA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a5XB21Co; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752227664; x=1783763664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YadJ8hXt+b1YwyLCgZvgMxZb8stWI+VVpDM/3amT+Vk=;
  b=a5XB21CouTpZHNPrFpNVVJvTxonldD4DpfzIbmnW47ijBPbnyv4q6ZFp
   wdTZMDEZMk2iKZKeEdiea8VcixvzMqxSoSs3TSkeuu9PDNfK/dMuboSIt
   0fKgy5CMK6mjj4HK3ly4lI36jBau4XaO3B+0j3ZD94FU4T98/b4TmsoZ1
   jMr5rGePPK/lp0wpCdEpY4NsXZmCfFJUU8IALNSU8cJcZrkgXI+5+NW1M
   meSF4wsVA8ItTJy9E2fIu2Z+VV0n/Oiz9hf8p9M1CWuoFLLNmWd07KwCX
   oKWzHpqDaUK+bLAyLVlwp2IfDUYEQ3tQaJRupZj7sYFsEZI5Q0fxKbw3S
   g==;
X-CSE-ConnectionGUID: /pkVVpS/To6sdpAlsV0byA==
X-CSE-MsgGUID: JyoXooibSv+fQnvv3LaLjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="58332701"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="58332701"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 02:54:23 -0700
X-CSE-ConnectionGUID: cnyk1UROTLaTYPTLuGSdrg==
X-CSE-MsgGUID: N2u+EAeGTVy+RDzuxK7DEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="156669854"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 11 Jul 2025 02:54:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 74CDB58E; Fri, 11 Jul 2025 12:54:17 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v1 5/7] panic: sys_info: Fix compilation error (`make W=1`)
Date: Fri, 11 Jul 2025 12:51:11 +0300
Message-ID: <20250711095413.1472448-6-andriy.shevchenko@linux.intel.com>
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

Compiler is not happy about the recently added code:

lib/sys_info.c:52:19: error: variable 'sys_info_avail' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
   52 | static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
      |                   ^~~~~~~~~~~~~~

Fix it by moving the local variable from stack to a heap.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/sys_info.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/lib/sys_info.c b/lib/sys_info.c
index 7965984c6d67..08de4c5fcfca 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/console.h>
 #include <linux/log2.h>
 #include <linux/kernel.h>
@@ -11,10 +12,6 @@
 
 #include <linux/sys_info.h>
 
-/*
- * When 'si_names' gets updated,  please make sure the 'sys_info_avail'
- * below is updated accordingly.
- */
 static const char * const si_names[] = {
 	[ilog2(SYS_INFO_TASKS)]		= "tasks",
 	[ilog2(SYS_INFO_MEM)]		= "mem",
@@ -43,26 +40,32 @@ unsigned long sys_info_parse_param(char *str)
 }
 
 #ifdef CONFIG_SYSCTL
-
-static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
-
 int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
 					  void *buffer, size_t *lenp,
 					  loff_t *ppos)
 {
-	char names[sizeof(sys_info_avail) + 1];
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
+	char *names __free(kfree) = kmalloc(maxlen, GFP_KERNEL);
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
@@ -73,21 +76,21 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
 		return 0;
 	} else {
 		/* for 'read' operation */
+		unsigned int len = 0;
 		char *delim = "";
-		int i, len = 0;
 
 		/* The access to the global value is not synchronized. */
 		si_bits = READ_ONCE(*si_bits_global);
 
 		for_each_set_bit(i, &si_bits, ARRAY_SIZE(si_names)) {
-			len += scnprintf(names + len, sizeof(names) - len,
+			len += scnprintf(names + len, maxlen - len,
 					 "%s%s", delim, si_names[i]);
 			delim = ",";
 		}
 
 		table = *ro_table;
 		table.data = names;
-		table.maxlen = sizeof(names);
+		table.maxlen = maxlen;
 		return proc_dostring(&table, write, buffer, lenp, ppos);
 	}
 }
-- 
2.47.2


