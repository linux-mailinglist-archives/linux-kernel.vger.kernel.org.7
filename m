Return-Path: <linux-kernel+bounces-875836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD01BC19EEA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7201A22603
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6952D32C320;
	Wed, 29 Oct 2025 11:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ewCEd5nL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE84730BBBF
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736364; cv=none; b=t5LvozzHE64wIcZmYXBNMQnOd/yJwF4C7KlNjuCDF/0a8FPtrV8Xt7vSYRV+kEPCDE+V8lj7kvYyLWlK8ePp3HqcxgJo4cwlGJVWz2ClH49djfO37dMh0g/xR+IU86803hu7mRtVVAeRaXNdjh9wLUR8iInww2+B3D84Gb9tsFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736364; c=relaxed/simple;
	bh=q0veARx378rGN5WON51OKxYONBEe2s6rA5tw/JasIt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnH+RqaDXacEwlVg5xCsHAltB7YQwpzCxNrBB2q1YcwF2rkFRGgOLAIZKL02aMHyn2ZkMNIXcM1pqIoWHMHc0q1v4t+jMT/NSPGDVsz0p+slNPRsU+1zWz+kXTuxe4EN6KidSGuz4s7K8g+/khx9fO1YoQs/zMrBCC8HuuhdfA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ewCEd5nL; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761736362; x=1793272362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q0veARx378rGN5WON51OKxYONBEe2s6rA5tw/JasIt8=;
  b=ewCEd5nLxythStFTs58ewNAQIFJW6umZKetwDGowYGKn//pW9BzJ/iDu
   BBiFICo3Fq/N4A7oN/J6p7Ku65Hp4IKrcTlV7v1SRWb8rJ7k3uYTQJBzS
   zY5KUAWFntQDIP4CPimQCtL4Yicfu19J/iTVCNOUzBubZfOqQPcOex6Qh
   b3VRNtSiV8mCDyNkPn5VDmRo0HydIb4D/X+BdiO71TEUJmZ2lZ6uxVP1Q
   i9IjMlMxiWsPRhsEESA6v0UoOmnBVq0hePls/JxNaAZp7O0l49RjU3i2I
   fMFLQZ9izIDgEPIB7x3DeDt6r79FpKd4wgN864wcaKKxWWiYhzs9b9Ux8
   g==;
X-CSE-ConnectionGUID: gQNwjKjmQlWgYwZohFGlow==
X-CSE-MsgGUID: j1LRkY1NSCyK7oc67NSEOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11596"; a="75198538"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="75198538"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 04:12:42 -0700
X-CSE-ConnectionGUID: mwqmJZN9Q9S7wmvx+WBu9A==
X-CSE-MsgGUID: UFVVf9TdSW2edw5NEa+JsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="216286110"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 29 Oct 2025 04:12:41 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id E946499; Wed, 29 Oct 2025 12:12:39 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 4/6] panic: sys_info: Rewrite a fix for a compilation error (`make W=1`)
Date: Wed, 29 Oct 2025 12:07:39 +0100
Message-ID: <20251029111202.3217870-6-andriy.shevchenko@linux.intel.com>
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
index 5aecf4b6025f..027b2c432d07 100644
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
@@ -74,22 +79,21 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
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
2.50.1


