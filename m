Return-Path: <linux-kernel+bounces-878300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B153EC20349
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5E90B34EEE7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBE63563C5;
	Thu, 30 Oct 2025 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k26JlIjh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC627285042
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761830424; cv=none; b=jbtVK3zxSR1dxGrgQHK63uXmF5OXzwKpXJd2PbKtp9nkiK8bh+EjA2X5tViFyocHb7GTi0Ljd0s70SE7MAsQm9Cpx9BDKMfIKtubPctl2fkvZd6CIQeJcHFw42GYx9NkejZMX2ZzjuYlnTUpAVKGbCHc+pvEadD4+TeUqRg3Xy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761830424; c=relaxed/simple;
	bh=j3Iy5TsM+zh63y8DLtoL/2/mRZGYZJvZUQjdwpw7YJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBwDqu/1Ey5MIYBO1jlGaVWl/Th0sJ4tZjXqxLqGuSSEznOOANiIxwt03WbqiB+ddoBMtjUXIVAQW5Cuw5UBeWgJATOxKNG/hBIlM0/erTuBk8OEv+YOpUz+adKvDeBmyVyq5+OGEGIZP+dZt13PLp9Ak5genbUBAUs13SLbR1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k26JlIjh; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761830423; x=1793366423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j3Iy5TsM+zh63y8DLtoL/2/mRZGYZJvZUQjdwpw7YJQ=;
  b=k26JlIjhl6reGE/PJpQ+82k4fSNdSRqSA0iuqkjPbfrSBqwwG15Auhgr
   6OS2cgWe7o9AFA5CIg47p+2dxVTk5GaxwKGgR2NeGh634Oms83NC1RZlB
   UploCw4gIC7pVCYLtoFqZcB3EvYq1w8BmeEjI7vJmbWsin6jfYVgjbLAK
   rxMF9E4s0kJ/c0Kd4zM81a1sktADqOWdpF/BXdUAInwSP4uE7KfUaW9yC
   ZRSv2nF7Y+VYzi5e3rY4kjt00Z0tq4andiy74WLYXRvLO9v+ePO0biZH6
   HYwAcin5B/Zo5VOGyAcNe/8Gv3auEo/4AbwrKqNZxOR7ewblagrbD33GS
   g==;
X-CSE-ConnectionGUID: R61FqDgDTamysdvt0U6dhw==
X-CSE-MsgGUID: nmawhlYpQuyxWzdJQud0eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63875752"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63875752"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 06:20:23 -0700
X-CSE-ConnectionGUID: kSeavGr1TCCuFDP1H5GO6w==
X-CSE-MsgGUID: v05Xf2oQSNiZ3ZnKw4F+Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="190312797"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 30 Oct 2025 06:20:21 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 7FD139B; Thu, 30 Oct 2025 14:20:18 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 5/6] panic: sys_info: Deduplicate local variable 'table; assignments
Date: Thu, 30 Oct 2025 12:44:21 +0100
Message-ID: <20251030132007.3742368-6-andriy.shevchenko@linux.intel.com>
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

The both handlers use the local 'table' variable and assign
the same data to it, deduplicate that.

Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/sys_info.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/lib/sys_info.c b/lib/sys_info.c
index eb5c1226bfc8..94526de8482b 100644
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
@@ -93,9 +94,6 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
 			}
 		}
 
-		table = *ro_table;
-		table.data = names;
-		table.maxlen = maxlen;
 		return proc_dostring(&table, write, buffer, lenp, ppos);
 	}
 }
-- 
2.50.1


