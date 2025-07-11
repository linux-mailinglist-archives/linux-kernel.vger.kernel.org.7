Return-Path: <linux-kernel+bounces-727349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E589B018CD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4B05A7BB2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5AB27EFEC;
	Fri, 11 Jul 2025 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eCWIk2TN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6443727D782
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227662; cv=none; b=WQ1QOfrW1+FU/ppNhYGCHo+dc+xnzCoxqKW5FEMMYZjOvzVLqkpCrEqB5Mceem7zj1rHkghyerhUHUE/l2AqnVGPxsx2HqnurVNPAxx1WetMEU7dKSBCYwUFNG2oM2dnX399K0TT8WhMdqIKEba8UNHgzTMGo5lE5faZ6ZC9Z8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227662; c=relaxed/simple;
	bh=rDQsJWK/+pi3UfhJ9aofcYax70wDXPUM2p4h0K9ZSrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HlhFnosVKSKhvz3TYKw807m0CO2DaGxX3MPcf5co02FnaGxa+0oycK0etkDS/NJX/TALmFPRRwrfK8h6LDDjdxCM1WsCeJ6DbVdnZDuUIqA4O2IB4RTMCKE3PZSlrjvpi/kCHG12c9Z8Dro295DgU0fQJ20vflgW0J7k9BBA45M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eCWIk2TN; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752227661; x=1783763661;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rDQsJWK/+pi3UfhJ9aofcYax70wDXPUM2p4h0K9ZSrU=;
  b=eCWIk2TNgcjaPE8+SN3wM6czfX7sxGdx+jCKKJrqVU9mHmLpfNJm9kle
   6a2OPJveWQyJYWSKPtwn0Y22qc5wtKZMtdFSnfpQqwmqZMBLA2wXMnnaG
   Wa8aDPI+h5CiZ4s7eAH6jun1MRrS0V3fGUVrPYwft0vg+JalZETCp4jtZ
   3/emYmyE/d8Qz2KhAVo2Xhzld2IechQPVUNysAw5qeT/1YZrK+hqviXFO
   QiDg0GYgHXaBCzKfrEoN0YhvL7JXlSU0qxzAXRWrrbvR6BIommWe/BbGD
   GjmmWzkpm5QyG9pLFFEtHDDaox+RIzBMHGUHDEH7g++GrVTCE7ztFQiBI
   A==;
X-CSE-ConnectionGUID: yvztUHouS+WfUsrq+eG8AQ==
X-CSE-MsgGUID: Uc3Kx5P8SnOrCK77Oiw1sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="42153915"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="42153915"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 02:54:20 -0700
X-CSE-ConnectionGUID: qias/e+3SAyLQPVW34oXUw==
X-CSE-MsgGUID: KTtIVIdpSHqUL1zxma5a2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="155746985"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 11 Jul 2025 02:54:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 450BA108; Fri, 11 Jul 2025 12:54:17 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v1 1/7] Revert "panic: fix compilation error (`make W=1`)"
Date: Fri, 11 Jul 2025 12:51:07 +0300
Message-ID: <20250711095413.1472448-2-andriy.shevchenko@linux.intel.com>
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

This reverts commit d66eaf0a73fbe3dfbe95c473ef12c68d582e5ce2.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/sys_info.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/sys_info.c b/lib/sys_info.c
index 779f8725b194..46d6f4f1ad2a 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -49,11 +49,13 @@ unsigned long sys_info_parse_param(char *str)
 
 #ifdef CONFIG_SYSCTL
 
+static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
+
 int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
 					  void *buffer, size_t *lenp,
 					  loff_t *ppos)
 {
-	char names[sizeof("tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks") + 1];
+	char names[sizeof(sys_info_avail) + 1];
 	struct ctl_table table;
 	unsigned long *si_bits_global;
 
-- 
2.47.2


