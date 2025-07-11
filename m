Return-Path: <linux-kernel+bounces-727352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1580B018D0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212AC1CA71FB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1840827FB28;
	Fri, 11 Jul 2025 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IlMybKh1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0550D27E7E1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227664; cv=none; b=hkAZwREkLI4WI9YYA0voxwhYpFBcP0JnYHFe4cvLKwe3o0XkfBiI/HSoUy8lpG2gwV+/gf6qG+YY6QefqGrumXfaQSXeHwUONFzcNkHoslvT4x7/ehCdDWlqtSW7viF/modP7sF7INl3kWDXfwVm/ORFkdkbVt/N4GGMTh0loew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227664; c=relaxed/simple;
	bh=5yyMHYSOnxlRtD1oDiidpGURuUrue6yvRXZ3UYzWOgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUtSZwWq7FJwdr4YsXzQc8+kmMYrZNtSf8OVaNKZ7533Muj+B2aoEkY1C1oitnfTftx2naFhbnqiVHtWLhLylSG7TO+V3R4f6BW0dY2Bx6/oFhzH6LG+BrGvXVcQ4SMQPXiEAbeJ6D5Vu7H6hmsbYaT/BDVCMeGN/GNO08kw0vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IlMybKh1; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752227663; x=1783763663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5yyMHYSOnxlRtD1oDiidpGURuUrue6yvRXZ3UYzWOgM=;
  b=IlMybKh11pck/DuXROeRRWicavCRjerHci4EMkX8JvUSs22sioL15Ay3
   y+LGvX4frqKkeXDWNgM0+kFsmuzewBCFqrlLkJqaixJkC3LENQlcVinh4
   OkA1m6LPKV/TJJp67k4mBJX1DCTDfldso46YCoTVnVEGZGXrLyTuA2HF9
   X/0iiuveOJ/Ucanp3j9PgoEO7E+OEaO4DnM9+ANDICwyKTvhems9yqGVK
   veTE7oiMjOCSi7NbMQJ58WgDjjPhGWNIgitj8kZulvApGK66ZZqDSp71z
   RbokhiccZRkJRGFAIXw/xmWqr63aXnFmKz3YrMbnSrwj7G2KQ8ijBluOq
   Q==;
X-CSE-ConnectionGUID: zqMkDeefRZOHC1+cSmqQZA==
X-CSE-MsgGUID: YDTocYfST/OjBhtnEqPRww==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="42153919"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="42153919"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 02:54:22 -0700
X-CSE-ConnectionGUID: IStz57GIRFOOB0lGPYEr2A==
X-CSE-MsgGUID: JUQUAlleQoKHeS7oOgpnnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="155746992"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 11 Jul 2025 02:54:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7A6AC4E5; Fri, 11 Jul 2025 12:54:17 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v1 6/7] panic: sys_info: Deduplicate local variable 'table; assignments
Date: Fri, 11 Jul 2025 12:51:12 +0300
Message-ID: <20250711095413.1472448-7-andriy.shevchenko@linux.intel.com>
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

The both handlers use the local 'table' variable and assign
the same data to it, deduplicate that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/sys_info.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/lib/sys_info.c b/lib/sys_info.c
index 08de4c5fcfca..7483b6e9b30b 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -60,12 +60,13 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
 	if (!names)
 		return -ENOMEM;
 
+	table = *ro_table;
+	table.data = names;
+	table.maxlen = maxlen;
+
 	if (write) {
 		int ret;
 
-		table = *ro_table;
-		table.data = names;
-		table.maxlen = maxlen;
 		ret = proc_dostring(&table, write, buffer, lenp, ppos);
 		if (ret)
 			return ret;
@@ -88,9 +89,6 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
 			delim = ",";
 		}
 
-		table = *ro_table;
-		table.data = names;
-		table.maxlen = maxlen;
 		return proc_dostring(&table, write, buffer, lenp, ppos);
 	}
 }
-- 
2.47.2


