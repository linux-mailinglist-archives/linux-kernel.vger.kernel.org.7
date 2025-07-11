Return-Path: <linux-kernel+bounces-727353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE58B018D2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB0E3B7851
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D7128136E;
	Fri, 11 Jul 2025 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9/dJbxx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53BB27EFF7
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227665; cv=none; b=LVDIuZtd8x40qrXTUffbRDmwh1mZgcNTaAw7/M+md3iNmJdLW9Pxa8X6yaQMGrv8v5oZlPueVfgJLb05+AoV4iMOg1D4zgH1xy2aGrET4vG0fRMlzfDIsFXrlanAtK2easNN0GNx0xopYcLjHyt504hehyg5oz626BROLyfwq3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227665; c=relaxed/simple;
	bh=jggy00wSu6GI7ekpzyXARHk8GAzocK9Cbbq+5a08ySY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuyPDboGfBZm3hX4em/Bu3G0sdrawCg35D+aKr/HLfnFqB4+rOUuM5M8TnR2cDN9dUxCAxasnH9Zwli9hIGhQlVmFmQ1A8t00n8MxVrmsJaf3yTO3ZcnvFmIL0dhFLUjVCXdeFZ7aqE10Xe8NSg1UtDENnNlWJUtAU1paAF00zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9/dJbxx; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752227664; x=1783763664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jggy00wSu6GI7ekpzyXARHk8GAzocK9Cbbq+5a08ySY=;
  b=h9/dJbxxvmiqxPzAlAQS/ehljMHKOXGPJSjMPHaPVpEV+rq4oDCt8GEq
   PyuHP2BfKCnFiL/K61/NI1oEulkuATi89MHs9ATpI92Fdk+wK2Jqw0dXu
   9+2BBw47SVWy/N2Pp4XNtpu5b64+ioS68fXO/Jt2P9kLd+U60HzLarODa
   NR3+63FhIm+1Fh8xP0LftZOxHJVlVdi+nxKCjhvBAhTiszNnuk5ftPItF
   Bbda69Hja2cy1azG2L+GMRuJVw5W0F+Wnthw95omuJwqnxenkDYQ2IBkx
   tpB52KYGhUdJ9wcWmAUFgb8VeaO4Hrlc49zi8XP0VvAp+ua3dSKJ1thwJ
   A==;
X-CSE-ConnectionGUID: oXX0uenZTUqLWOWEwSPFfQ==
X-CSE-MsgGUID: KQy0YeDnQrC4ZAbOFuNrCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="58332680"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="58332680"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 02:54:20 -0700
X-CSE-ConnectionGUID: bRpjDiZlR3itHFnIDxixmA==
X-CSE-MsgGUID: 0bfJgWzdS/iTYryCZJx0Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="156669846"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 11 Jul 2025 02:54:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 52147377; Fri, 11 Jul 2025 12:54:17 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v1 2/7] panic: sys_info: Align constant definition names with parameters
Date: Fri, 11 Jul 2025 12:51:08 +0300
Message-ID: <20250711095413.1472448-3-andriy.shevchenko@linux.intel.com>
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

Align constant definition names with parameters to make it easier
to map. It's also better to maintain and extend the names while
keeping their uniqueness.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/sys_info.h | 2 +-
 kernel/panic.c           | 2 +-
 lib/sys_info.c           | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/sys_info.h b/include/linux/sys_info.h
index 89d77dc4f2ed..a5bc3ea3d44b 100644
--- a/include/linux/sys_info.h
+++ b/include/linux/sys_info.h
@@ -14,7 +14,7 @@
 #define SYS_INFO_LOCKS			0x00000008
 #define SYS_INFO_FTRACE			0x00000010
 #define SYS_INFO_PANIC_CONSOLE_REPLAY	0x00000020
-#define SYS_INFO_ALL_CPU_BT		0x00000040
+#define SYS_INFO_ALL_BT			0x00000040
 #define SYS_INFO_BLOCKED_TASKS		0x00000080
 
 void sys_info(unsigned long si_mask);
diff --git a/kernel/panic.c b/kernel/panic.c
index ccee04378d2e..1567f04a58fc 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -334,7 +334,7 @@ void check_panic_on_warn(const char *origin)
  */
 static void panic_other_cpus_shutdown(bool crash_kexec)
 {
-	if (panic_print & SYS_INFO_ALL_CPU_BT) {
+	if (panic_print & SYS_INFO_ALL_BT) {
 		/* Temporary allow non-panic CPUs to write their backtraces. */
 		panic_triggering_all_cpu_backtrace = true;
 		trigger_all_cpu_backtrace();
diff --git a/lib/sys_info.c b/lib/sys_info.c
index 46d6f4f1ad2a..44bc6d96b702 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -23,7 +23,7 @@ static const struct sys_info_name  si_names[] = {
 	{ SYS_INFO_TIMERS,		"timers" },
 	{ SYS_INFO_LOCKS,		"locks" },
 	{ SYS_INFO_FTRACE,		"ftrace" },
-	{ SYS_INFO_ALL_CPU_BT,		"all_bt" },
+	{ SYS_INFO_ALL_BT,		"all_bt" },
 	{ SYS_INFO_BLOCKED_TASKS,	"blocked_tasks" },
 };
 
@@ -114,7 +114,7 @@ void sys_info(unsigned long si_mask)
 	if (si_mask & SYS_INFO_FTRACE)
 		ftrace_dump(DUMP_ALL);
 
-	if (si_mask & SYS_INFO_ALL_CPU_BT)
+	if (si_mask & SYS_INFO_ALL_BT)
 		trigger_all_cpu_backtrace();
 
 	if (si_mask & SYS_INFO_BLOCKED_TASKS)
-- 
2.47.2


