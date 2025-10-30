Return-Path: <linux-kernel+bounces-878297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED609C20346
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 164FB3BA850
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B357A31A7F0;
	Thu, 30 Oct 2025 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mR4yFvR1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F11623F26A
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761830423; cv=none; b=TCTC56iIaz7PLQ7WW8c5MJjRhdxOSst9uywIhUwOB0KIiCPctIyv6IyHRr+Et6PFs2cd66Lthp7dMsV929VkHsGGLEwHNntgt7t58pykeWiE4aryVeXa95fDMZWB1woYhz5n83ImeKBFGPa9U7zX72GKJWjb4hVBne/RroIt6kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761830423; c=relaxed/simple;
	bh=2BVQ+Utgl3MIvxAIbys54i5YDo2PSGETCCd/ZKN+Ves=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgEQZoy9npoveMBLFLyuA1VhJhXj++JvYzzqhZQ2R+1FhE5yzZYSFtJ0UpuZ8TmGJn1mZaP6f2eZG0dcMsQPivgeYKfZpqrimIviX22WJ/JIaLovXZW2SqkWonLyxnuEYo9yg3gzhMr9nCb0un1CGaNhacT4ezqsNTDrqyTHjnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mR4yFvR1; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761830421; x=1793366421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2BVQ+Utgl3MIvxAIbys54i5YDo2PSGETCCd/ZKN+Ves=;
  b=mR4yFvR1IGpYyXyd6llF+sHrCKy6F5UovUd25OOe9VuQvg4VOrrIWHz+
   hT0xzHVVTWPesxqkTTJb9C7JzFcZjDD9t9HSoKkwg64lRSG+PdJ9FgDN6
   TkOXXM5aH0i8s0gqR0cArMD6Oo7goA8wNEJxLuSHkYlg3iBP+A2IyMn5Y
   ElCXTwsLEuZcYm5XoglX8Tb7AHtgb1j4i0yE4JTa7KAjxPiSJmSGniAq2
   VE4MYZhlHsN8s1nhbGTOtZoHm2+lw50zh791r+D6FfmyhNyx9O2nbycHX
   Q4v0Zi2OlU/G6ZezkvRtmU9wVHU0P7MwS3CH6WgQ3VCjuY9FO8rWmhrMo
   A==;
X-CSE-ConnectionGUID: 0u6jSVWuRdqhLEz8KrQVDA==
X-CSE-MsgGUID: ztgD373QQ+erqRh5MTADow==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="89437050"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="89437050"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 06:20:20 -0700
X-CSE-ConnectionGUID: SvBEd8zPTP6E9MLTdnlfCg==
X-CSE-MsgGUID: cJHczWWHTAi/S9xSxuu6wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="190026363"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 30 Oct 2025 06:20:19 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 7839499; Thu, 30 Oct 2025 14:20:18 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 3/6] panic: sys_info: Replace struct sys_info_name with plain array of strings
Date: Thu, 30 Oct 2025 12:44:19 +0100
Message-ID: <20251030132007.3742368-4-andriy.shevchenko@linux.intel.com>
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

There is no need to keep a custom structure just for the need of
a plain array of strings. Replace struct sys_info_name with plain
array of strings.

With that done, simplify the code, in particular, naturally use
for_each_set_bit() when iterating over si_bits_global bitmap.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/sys_info.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/lib/sys_info.c b/lib/sys_info.c
index 6b0188b30227..29a63238b31d 100644
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
@@ -85,10 +81,10 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
 		si_bits = READ_ONCE(*si_bits_global);
 
 		names[0] = '\0';
-		for (i = 0; i < ARRAY_SIZE(si_names); i++) {
-			if (si_bits & si_names[i].bit) {
+		for_each_set_bit(i, &si_bits, ARRAY_SIZE(si_names)) {
+			if (*si_names[i]) {
 				len += scnprintf(names + len, sizeof(names) - len,
-					"%s%s", delim, si_names[i].name);
+						 "%s%s", delim, si_names[i]);
 				delim = ",";
 			}
 		}
-- 
2.50.1


