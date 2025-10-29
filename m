Return-Path: <linux-kernel+bounces-875839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E507DC19EF9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D66E94F2FE5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D4B32ED5B;
	Wed, 29 Oct 2025 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WrdRN/yG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA58324B25
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736365; cv=none; b=LT7lsNcrHe3TcvpGUeeA4inhIThf8W/BnJakcmPm1v1XQTWzC5sQD13QPeeRX2WCmI19BwZSBgmZcZNjaczuDWSxTj+z8HQFl1vSz/0MWVnpcbqBUZ4M+udhp4QCsgyR+dI7t3E4X1Bbxgxqr+l1fWOaeAlnCxVaBqnevUZEz/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736365; c=relaxed/simple;
	bh=0uzXrShVPuyyihm9bQTA7lPbESHpuHws075tcEruaY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAySaEHq/jxQwJVLxhl6+SdBlhVunjBorwRtXI5VCFcu2m8MAG63A7UQu/jCneU8zEKgOyRMYeG1zu3YKV1m1O2S+SQUrQJNr9HkBVsIcs192pT/Gj+UwTg6MCC+zQmNB9Hkbl9v9bq7uKGU2A1bT7eTw28K46gBoke/bT75jug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WrdRN/yG; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761736364; x=1793272364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0uzXrShVPuyyihm9bQTA7lPbESHpuHws075tcEruaY4=;
  b=WrdRN/yGHuototwyxFVHw3tBHNhBv6M95IzKH0ljbKVMPIPDKd8SKKSU
   0Js+4nbQWBQe9Xwd9k2CkUHaSwSbZIa4f6OW/KfzIB7tnb9TO3163bYiM
   99Oum6I+UF8Ue9T7ZZjUOdNoUR4xv/GiEdE6cxm1HUbSnlWvRQI0kakDN
   XpdCnqbH+SlLDRJX98wIDQTm5XWlQcro4wo26p5WD3/9XykRU5w3a1tqb
   Bp3vfwkKlrF9qcCCuzo5nJQLPnIVHFVUuTRL+Md7a7Vw+UrGvEarY+biI
   YBuCGwdtm4tyBzDLvBMWnEq4qCNLr1xWHsIilEZq8r+q0O2JDNO5U/Nqm
   g==;
X-CSE-ConnectionGUID: bqijWOU3SCOqV5Vgi8cNtQ==
X-CSE-MsgGUID: pO+cO4rqT4yPCY7CaTQa7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11596"; a="63060495"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="63060495"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 04:12:43 -0700
X-CSE-ConnectionGUID: oxkUqQ9UQmmY+z9DtGyGow==
X-CSE-MsgGUID: 2l83DR6hRF2VfUGURAS9sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="186376726"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 29 Oct 2025 04:12:42 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id ED71C9A; Wed, 29 Oct 2025 12:12:39 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 5/6] panic: sys_info: Deduplicate local variable 'table; assignments
Date: Wed, 29 Oct 2025 12:07:40 +0100
Message-ID: <20251029111202.3217870-7-andriy.shevchenko@linux.intel.com>
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

The both handlers use the local 'table' variable and assign
the same data to it, deduplicate that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/sys_info.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/lib/sys_info.c b/lib/sys_info.c
index 027b2c432d07..c86f52644857 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -63,12 +63,13 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
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
@@ -91,9 +92,6 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
 			delim = ",";
 		}
 
-		table = *ro_table;
-		table.data = names;
-		table.maxlen = maxlen;
 		return proc_dostring(&table, write, buffer, lenp, ppos);
 	}
 }
-- 
2.50.1


