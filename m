Return-Path: <linux-kernel+bounces-727351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39BCB018D1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FAD8B46FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F5427FB0E;
	Fri, 11 Jul 2025 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FTQ8R+7s"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D47527E1D5
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227664; cv=none; b=i6YOjornKQoLqjYYNin8Q8y/h5HjVQ16ubDFgI8FdY6hn62kNX+TP959EDhFX4+ZVnzERpzwMGC+ahFjD2UpL9p9Fpf3tzwWtL/C9q65Jp8FnXDDQ2HfK5G6oNAAJx+iWOceLybPZcz4596nZQGZbLOG0Nt2avOzOVym8C0nu6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227664; c=relaxed/simple;
	bh=lo3PrLGp4mRxoe8qcwAaj0qOk19581q3yRYynl3U1VY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJlIWkugNqgmdbvyULeGYDOjApgGZeCHCakX5aTy4vWkHROclu4yjDmjzK/WjMfzta+wRvjvuoH3H4N1GB9m3xWhEsjp80KQo+WAqhG85TFZ+AmxCE6hZ2mSX2zcUJIYn2AjTo07DTayS1IZtSjoVC5zWaM2wy2iD6S0NLrjUZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FTQ8R+7s; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752227663; x=1783763663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lo3PrLGp4mRxoe8qcwAaj0qOk19581q3yRYynl3U1VY=;
  b=FTQ8R+7s+mijSsDAua/pRtC+nC7sC8dMOwKjdXgS3fYJVdm5XRHl7LEy
   kcItpzGrX7K5qs7ZYZgHVSYDA1wegpLhOl25sF30S9+3R4Wudl9qo8yBs
   Z5Ei4PDR56RdShzYR4SkY8nCVtJOkYVh0hACEAlaerWZyG2uF3YMy6/OU
   rZAbTJ8ECF9bxY+JpD04XZI4a7+/zOuVEyi9sdvjLstovy8bP4QUTqdpH
   OgfYlnwR/9ly35od9Cw0/j2LYfmeeUTx6rZi+iC13SKLe4etXbDoM4S64
   x8GBaFQLtLrsNksxbp1jc6opYvXQ96c9oiZf+EU6zXLZYyo6cCjS/3KmS
   g==;
X-CSE-ConnectionGUID: tHzq7u/GRP2NmafCX13HSQ==
X-CSE-MsgGUID: p4PQaExnRcyoMyCxtaPI3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="58332692"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="58332692"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 02:54:20 -0700
X-CSE-ConnectionGUID: fl65E6eSRJmdkM9IcM/Xzg==
X-CSE-MsgGUID: Gbw+C65kR6mXwDnjE89Rxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="156669847"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 11 Jul 2025 02:54:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 651F81BF; Fri, 11 Jul 2025 12:54:17 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v1 4/7] panic: sys_info: Replace struct sys_info_name with plain array of strings
Date: Fri, 11 Jul 2025 12:51:10 +0300
Message-ID: <20250711095413.1472448-5-andriy.shevchenko@linux.intel.com>
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

There is no need to keep a custom structure just for the need of
a plain array of strings. Replace struct sys_info_name with plain
array of strings.

With that done, simplify the code, in particular, naturally use
for_each_set_bit() when iterating over si_bits_global bitmap.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/sys_info.c | 47 ++++++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/lib/sys_info.c b/lib/sys_info.c
index 5d98560f3f53..7965984c6d67 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -1,30 +1,28 @@
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
+	[ilog2(SYS_INFO_TASKS)]		= "tasks",
+	[ilog2(SYS_INFO_MEM)]		= "mem",
+	[ilog2(SYS_INFO_TIMERS)]	= "timers",
+	[ilog2(SYS_INFO_LOCKS)]		= "locks",
+	[ilog2(SYS_INFO_FTRACE)]	= "ftrace",
+	[ilog2(SYS_INFO_ALL_BT)]	= "all_bt",
+	[ilog2(SYS_INFO_BLOCKED_TASKS)]	= "blocked_tasks",
 };
 
 /* Expecting string like "xxx_sys_info=tasks,mem,timers,locks,ftrace,..." */
@@ -36,12 +34,9 @@ unsigned long sys_info_parse_param(char *str)
 
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
@@ -84,12 +79,10 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
 		/* The access to the global value is not synchronized. */
 		si_bits = READ_ONCE(*si_bits_global);
 
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
2.47.2


