Return-Path: <linux-kernel+bounces-875844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4222FC19F26
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3DA74FC26E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E8F334C14;
	Wed, 29 Oct 2025 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SgS1t0d2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB81F334C0C
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736378; cv=none; b=fXDTNtShrVg7/GlgsZZouGYIQBkuDLDUO3slyrE0uq0Oq9/10dP0R5HBAaplY0ndHJJ9bG829+RUS2MxUzJ/ZwRSBn6vPYOuBU28P+zCRsvWxorZJX2LBkYJe6cv/zVbnqfvxYkZsaifq5wTLohXV8pTM3VnxQEWqncrki7B0gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736378; c=relaxed/simple;
	bh=CiKEL/wCcq8DeD8AleLPUan6BOR3bpukhekSM08MLL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flD5dDrxo0zfP99sEM6kHg4/FooQy1XFo9AoB936tyw76s4wUrc87rhwfHbbgX5/OYPP8LWhlXqmYNG7zV0z2v6gJUpPyNXvLIOXjb4aTOUtpvGpiP1y/bK02tVaNvKBawFtIkvhcaYg/iJpd3ilmp3zzsARFak467Xux5017FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SgS1t0d2; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761736377; x=1793272377;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CiKEL/wCcq8DeD8AleLPUan6BOR3bpukhekSM08MLL0=;
  b=SgS1t0d2NPucefSqPBmyJd+B/uVePejGBy09hthI12yT3cI+UW/RV4dy
   P+WA3iEch0vzBTL7jAn9HZwZYjBYLuCUr3UjSCJi2pdZLLO4gxDZyrzu7
   9McYF8IMR+tp3KSetXNQP1kuN5QRHmH7D/wtP2xMrFu3GpsONpsnQQiTM
   NKO/mgX2BxqEoxBF8LqnZwkLbFYLbfxcOZPMS5wVTs72uyFPWEO/u96Au
   ziPxzfe1qTM5SlEA+ZfL7QmZA73p47EvhHg8Gw5fzAW+UwUKHxf4do/SG
   Lfxio7ty3R34TNR79hEvn5lHw012/c+h58mNRBDn8/Z50eNLm6J72yw5d
   g==;
X-CSE-ConnectionGUID: XTDSF0nSQCSPztGQP0Zubg==
X-CSE-MsgGUID: /Le7D6WUT2K3QydIG4q2Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11596"; a="74971497"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="74971497"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 04:12:43 -0700
X-CSE-ConnectionGUID: PuzGh4FeTsKEehnlDaHBFw==
X-CSE-MsgGUID: AUdA28kdQrSU7u8NxPoR7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="185324851"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 29 Oct 2025 04:12:40 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id DD0D496; Wed, 29 Oct 2025 12:12:39 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 1/6] panic: sys_info: Capture si_bits_global before iterating over it
Date: Wed, 29 Oct 2025 12:07:36 +0100
Message-ID: <20251029111202.3217870-3-andriy.shevchenko@linux.intel.com>
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

The for-loop might re-read the content of the memory the si_bits_global
points to on each iteration. Instead, just capture it for the sake of
consistency and use that instead.

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


