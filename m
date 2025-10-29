Return-Path: <linux-kernel+bounces-875838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66401C19EED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D343A3B6920
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC45732D43F;
	Wed, 29 Oct 2025 11:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EpML6vyC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B919C238C15
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736365; cv=none; b=kO+6BGUgAoxInrxsEUz3E2mY+nX9Rg+q668anTQyBfyAndoIA4OEFAeCh16bL2jf6Vnc8Ko88ZVX4hi++1jT6PbQ7Zhu23b2ODmXSfTWPTERhIMVvmBno+683pjKXScO5K5XETvNawHd46JAshF88oVViJ+CVylJTfM8OjeqTu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736365; c=relaxed/simple;
	bh=79EZrYHav2KM8e+2sNwtRiJvFGLeza7Clf+zUyt951g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9xMiR3fnsexlFm6lMYuncnlwwRC9DOgbnv03XTV/8QhhWNq8XrOAYbVPJzZwNBJGhbg7boWYA3s9PpWAjSshuKLZX1d2YnftUfVN6NOcUoYUHWuoRMmycF2dNLJJwIKKtbXDbkfUQzEbc5cU6Sk8smJAGCHSA/pXDGCxFQ1TK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EpML6vyC; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761736363; x=1793272363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=79EZrYHav2KM8e+2sNwtRiJvFGLeza7Clf+zUyt951g=;
  b=EpML6vyC6KcoO8JHMxoULMVd8MRIDMtz4IXg/yoJH40K8uyrpcgg//u0
   ubiiO00SmbAkI3ksWwNti9VqX5mVKs4he/Ag+E4cRlcN4EuRdzX08+3w5
   YyBvpif4Rk1YolTGOcoZ9ewjF3ChsnPptduZnBs7wuKpiA+xRE7oG0bj8
   QUWvVtM0+igjhWPwneanpfYfCqjNnQvq4PweQVJT1043wwS2RX895lOdF
   h4nGZNP1fjCGpcmqHWduwgFKZH9XfdwrCqCi857nrLf45F09AljgVegmW
   MY7dmd7cqZUTrNFyhY2lg5J9K60k5qhcmDOZWFusQvIKSrFxnwPs4f8dH
   g==;
X-CSE-ConnectionGUID: EIEVNfOvQ7+AEYhhMVM+pA==
X-CSE-MsgGUID: uA4xQzBERtq3GWfZGiY72g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63757584"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63757584"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 04:12:42 -0700
X-CSE-ConnectionGUID: tKzygAexS5yWP12M9x6CUw==
X-CSE-MsgGUID: Xh2d5YL5RCq+SUSCx9ZB+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="184816534"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 29 Oct 2025 04:12:40 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id E522D98; Wed, 29 Oct 2025 12:12:39 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 3/6] panic: sys_info: Replace struct sys_info_name with plain array of strings
Date: Wed, 29 Oct 2025 12:07:38 +0100
Message-ID: <20251029111202.3217870-5-andriy.shevchenko@linux.intel.com>
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

There is no need to keep a custom structure just for the need of
a plain array of strings. Replace struct sys_info_name with plain
array of strings.

With that done, simplify the code, in particular, naturally use
for_each_set_bit() when iterating over si_bits_global bitmap.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/sys_info.c | 48 +++++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/lib/sys_info.c b/lib/sys_info.c
index 6b0188b30227..5aecf4b6025f 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -1,30 +1,29 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include <linux/sched/debug.h>
+#include <linux/bitops.h>
 #include <linux/console.h>
+#include <linux/log2.h>
 #include <linux/kernel.h>
 #include <linux/ftrace.h>
-#include <linux/sysctl.h>
 #include <linux/nmi.h>
+#include <linux/sched/debug.h>
+#include <linux/string.h>
+#include <linux/sysctl.h>
 
 #include <linux/sys_info.h>
 
-struct sys_info_name {
-	unsigned long bit;
-	const char *name;
-};
-
 /*
  * When 'si_names' gets updated,  please make sure the 'sys_info_avail'
  * below is updated accordingly.
  */
-static const struct sys_info_name  si_names[] = {
-	{ SYS_INFO_TASKS,		"tasks" },
-	{ SYS_INFO_MEM,			"mem" },
-	{ SYS_INFO_TIMERS,		"timers" },
-	{ SYS_INFO_LOCKS,		"locks" },
-	{ SYS_INFO_FTRACE,		"ftrace" },
-	{ SYS_INFO_ALL_BT,		"all_bt" },
-	{ SYS_INFO_BLOCKED_TASKS,	"blocked_tasks" },
+static const char * const si_names[] = {
+	[ilog2(SYS_INFO_TASKS)]			= "tasks",
+	[ilog2(SYS_INFO_MEM)]			= "mem",
+	[ilog2(SYS_INFO_TIMERS)]		= "timers",
+	[ilog2(SYS_INFO_LOCKS)]			= "locks",
+	[ilog2(SYS_INFO_FTRACE)]		= "ftrace",
+	[ilog2(SYS_INFO_PANIC_CONSOLE_REPLAY)]	= "",
+	[ilog2(SYS_INFO_ALL_BT)]		= "all_bt",
+	[ilog2(SYS_INFO_BLOCKED_TASKS)]		= "blocked_tasks",
 };
 
 /* Expecting string like "xxx_sys_info=tasks,mem,timers,locks,ftrace,..." */
@@ -36,12 +35,9 @@ unsigned long sys_info_parse_param(char *str)
 
 	s = str;
 	while ((name = strsep(&s, ",")) && *name) {
-		for (i = 0; i < ARRAY_SIZE(si_names); i++) {
-			if (!strcmp(name, si_names[i].name)) {
-				si_bits |= si_names[i].bit;
-				break;
-			}
-		}
+		i = match_string(si_names, ARRAY_SIZE(si_names), name);
+		if (i >= 0)
+			__set_bit(i, &si_bits);
 	}
 
 	return si_bits;
@@ -85,12 +81,10 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
 		si_bits = READ_ONCE(*si_bits_global);
 
 		names[0] = '\0';
-		for (i = 0; i < ARRAY_SIZE(si_names); i++) {
-			if (si_bits & si_names[i].bit) {
-				len += scnprintf(names + len, sizeof(names) - len,
-					"%s%s", delim, si_names[i].name);
-				delim = ",";
-			}
+		for_each_set_bit(i, &si_bits, ARRAY_SIZE(si_names)) {
+			len += scnprintf(names + len, sizeof(names) - len,
+					 "%s%s", delim, si_names[i]);
+			delim = ",";
 		}
 
 		table = *ro_table;
-- 
2.50.1


