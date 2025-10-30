Return-Path: <linux-kernel+bounces-878296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE064C2033B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D40793B8D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AB3307AFB;
	Thu, 30 Oct 2025 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JutMtQYx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345AD239581
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761830422; cv=none; b=sFv/u7p3ugfICq6/4/y/RSufnVLx6fexK3vGiIQoEp1ddDonoVvpdiF/KpWL+hQAAdQ6p0U2y55QhtrRK7mugoTNDgMsNGJEP5e4IyNCk2LFSnC29tNxajYNUnouguS86IuSfOHYrW3a5xfLo869Zb2kEXtv8Gokc4izYU1KsNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761830422; c=relaxed/simple;
	bh=t+VAbGP0izDtAZ+6eVeuOVCKXrQofbV//RSDU+DmLNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ek3clEjxEX4ENmyKGM7d044stWVzOXVWiBF3xiWnGdNxLOCc4kvAzgKj/s7WI+r9UJ6DGWesAvjIwiKdQ14mCEez8c/qU464qCBNwG2ypEaZb4e+f8WvtBo0NqTS0D/9lZ5/6HxLHawMYypSBVFxWrwqOUUiZJIH1RTSHIgiiqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JutMtQYx; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761830419; x=1793366419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t+VAbGP0izDtAZ+6eVeuOVCKXrQofbV//RSDU+DmLNM=;
  b=JutMtQYxFclqkUx5Kl94cLUmTGCfJkvxQ50ciGAsulPeLK3706PQzHlI
   IoK8qXnJoX0n5fG3ON/Vja56/I1FDffUbRckDKiiAd1f2X1nm0wpsgcMy
   BncrUaSS3tSlJln0PoBiGEZ5/gunlOp3eo5CADkz8+yqtWhXiVFNfPZ7b
   dMaSxUzYY5R1s/Oh0Fm0YflgUoY95g4FdByM2EmmNWiDXAQbD/zI4GavQ
   LKzAvRyFDcke42S2gs2L5Jwy5yY3nyq8HsqPo661IGIVi5uO1RWuchZvQ
   B+tToMkupKcg10pvLyKv1Xgr4CXcT58vE/AR3SBpFloSt0MsAE1yg/Sdr
   Q==;
X-CSE-ConnectionGUID: wdmnD7t3QMWB0bhm1U3gnQ==
X-CSE-MsgGUID: IUadHKvJR+mwLA3jVuPgwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="75318715"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="75318715"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 06:20:18 -0700
X-CSE-ConnectionGUID: F+MatMJpQnmEu6cQUWAFlA==
X-CSE-MsgGUID: BG6xEhI4Q2O0ijmKrQnihg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="185213892"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 30 Oct 2025 06:20:19 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6FA5F97; Thu, 30 Oct 2025 14:20:18 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 1/6] panic: sys_info: Capture si_bits_global before iterating over it
Date: Thu, 30 Oct 2025 12:44:17 +0100
Message-ID: <20251030132007.3742368-2-andriy.shevchenko@linux.intel.com>
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

The for-loop might re-read the content of the memory the si_bits_global
points to on each iteration. Instead, just capture it for the sake of
consistency and use that instead.

Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/sys_info.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/sys_info.c b/lib/sys_info.c
index 496f9151c9b6..d542a024406a 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -58,11 +58,11 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
 	char names[sizeof(sys_info_avail)];
 	struct ctl_table table;
 	unsigned long *si_bits_global;
+	unsigned long si_bits;
 
 	si_bits_global = ro_table->data;
 
 	if (write) {
-		unsigned long si_bits;
 		int ret;
 
 		table = *ro_table;
@@ -81,9 +81,12 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
 		char *delim = "";
 		int i, len = 0;
 
+		/* The access to the global value is not synchronized. */
+		si_bits = READ_ONCE(*si_bits_global);
+
 		names[0] = '\0';
 		for (i = 0; i < ARRAY_SIZE(si_names); i++) {
-			if (*si_bits_global & si_names[i].bit) {
+			if (si_bits & si_names[i].bit) {
 				len += scnprintf(names + len, sizeof(names) - len,
 					"%s%s", delim, si_names[i].name);
 				delim = ",";
-- 
2.50.1


