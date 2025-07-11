Return-Path: <linux-kernel+bounces-727350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3688AB018CF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B34CCB47B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FBA27F18C;
	Fri, 11 Jul 2025 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EmT6PVkI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2965027E07B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227663; cv=none; b=IIIjGaWeXdYvw6dmI2i7gs1yWmh8ZINLZEi4qKzr4KTkqo0qk1focYY54YJfaaA1Iqff63UG5KFBGGC+Y32UXbPV//E4Owg1UCW+misyEZv5G8N56FGP9h6pAsCGPGyqSEyomq49NwCpetrmrW4tfica22vZTwnQPLNsiWntUA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227663; c=relaxed/simple;
	bh=9gCnuVhXd7LCipm/gA67/wb0kXZ/5WMqqt0mQZG9tbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXmUEYNOsS+D+B+B0ffSAA+IOFkNhDBMs4f7LYz9Ks6y0tVy4DyApqir84R0bRgjNhA0/cqbfohVVUpt/uhn397nvISSY6vjPXI8jQADmII1Sllzb5935VJ9S+m0il43rFRRv1s3c5Tx4Snw1tFmxWAWpBJ/N2zZnT4QmYU3J1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EmT6PVkI; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752227662; x=1783763662;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9gCnuVhXd7LCipm/gA67/wb0kXZ/5WMqqt0mQZG9tbI=;
  b=EmT6PVkIedWoJsjtmoHjkpoexTRHwlqrxb5+bd/GJOt1m5CPRWTeQOhe
   4SikvWmHy2IZMW2ZKUHU0NVJ94WwuTPPPUxHXmXeuPdfYks1cE3ajwtNY
   Xh3eHtsxPNZsDLPpb/wQ9WoTuDExi7oGH66UcFT8IvsvgUn2FVaFqaFoo
   pCkSclo3MC6oLebks1vKm8YDs40RbAYpbGlbJNezj0fVn8NKzbCbV0VS8
   ZUobbF5fX41Y9BElOPzVOW6L+zCZNl/N4EKrXl5uTN4vXuS+QLDdKN46x
   YuLc1FkvGWJy3IqmVed1wg1U8z+5GW/t3gpayN42lRNQSGkVylbfPuisw
   Q==;
X-CSE-ConnectionGUID: ndz3V8K5TIGDkLavUBRcRA==
X-CSE-MsgGUID: 73WzfG7sQZ29nyM6MNehTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="58332684"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="58332684"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 02:54:20 -0700
X-CSE-ConnectionGUID: PHZTSFSnQN6Xrf56eAhWmQ==
X-CSE-MsgGUID: Lo35J46GT7a/m3A2gnFA8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="156669848"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 11 Jul 2025 02:54:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5F689445; Fri, 11 Jul 2025 12:54:17 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v1 3/7] panic: sys_info: Capture si_bits_global before iterating over it
Date: Fri, 11 Jul 2025 12:51:09 +0300
Message-ID: <20250711095413.1472448-4-andriy.shevchenko@linux.intel.com>
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

The for-loop might re-read the content of the memory the si_bits_global
points to on each iteration. Instead, just capture it for the sake of
consistency and use that instead.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/sys_info.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/sys_info.c b/lib/sys_info.c
index 44bc6d96b702..5d98560f3f53 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -58,11 +58,11 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
 	char names[sizeof(sys_info_avail) + 1];
 	struct ctl_table table;
 	unsigned long *si_bits_global;
+	unsigned long si_bits;
 
 	si_bits_global = ro_table->data;
 
 	if (write) {
-		unsigned long si_bits;
 		int ret;
 
 		table = *ro_table;
@@ -81,8 +81,11 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
 		char *delim = "";
 		int i, len = 0;
 
+		/* The access to the global value is not synchronized. */
+		si_bits = READ_ONCE(*si_bits_global);
+
 		for (i = 0; i < ARRAY_SIZE(si_names); i++) {
-			if (*si_bits_global & si_names[i].bit) {
+			if (si_bits & si_names[i].bit) {
 				len += scnprintf(names + len, sizeof(names) - len,
 					"%s%s", delim, si_names[i].name);
 				delim = ",";
-- 
2.47.2


