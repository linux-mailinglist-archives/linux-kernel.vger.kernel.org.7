Return-Path: <linux-kernel+bounces-875835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F203EC19EE7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E08151A21437
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5087F32AAD6;
	Wed, 29 Oct 2025 11:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ha/lOF8l"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE442E040E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736364; cv=none; b=QDm2kgkxcauTlslTqtXQ7V6r6Y9lAmLIDZ2Hkks99JBFSREPAcJYaHMvPkZAsvWF9ZmVgB+VAIBunFv5xgl50WfUTwwzqtqufPbTPlW9rITS5Ru1j3DEx4Ujlu/b41JYn820baG63K59RdBpQVzEf0Lz5smpWJhI88qyGpPSC0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736364; c=relaxed/simple;
	bh=uQkYVjDvlVcr5YXNo0uHdMAjbvEtqiEjOVaLBOSYEAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbHv8WddVX6I9e+u2EuxeVMjzzjURS4wFom+olrVIoHuR45xpwMZizgBW7LT0fX+La32JBRakSqgAWZOayW4JFdGOWEnKXa6I/HzpYUpFnSi01TZ/0eb1BJW36epXhzw9byl56aSyroGHbl2rsSbOnQGA6alZ6Sh0XXOFHcTNgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ha/lOF8l; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761736363; x=1793272363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uQkYVjDvlVcr5YXNo0uHdMAjbvEtqiEjOVaLBOSYEAA=;
  b=Ha/lOF8lzG1jsIkcHWhHW9TWNq3i7aM49aNQsqD76+ggvNiNR+HOyWFz
   Ej7ljyb48Ken0I/29451p6yVp1lwl9q4v9Qz3E5XEC1sdfxSwXJlN/6/y
   GjZNOydpQahRmnU7Orx4hhk6ZmnIVYCJ0/Z2tIhyQM+KxZIDzDyP/5jJf
   Kfx4Bx7j/jxjkjk7bsmdkppXkCzvEJavotPCldDJOprVYkwiErowF5hvB
   UrQY1elaA87rRlsBl7Hp8Eda10yzqFe1gwsyJrGSWt1g3KxAMcl5m9ErI
   NPBRNy/6oPag3Npoos5sOD2emlDdFbBgIrEYVRnXLqA06hf6949C//hSV
   Q==;
X-CSE-ConnectionGUID: Gjo2mMbhSICJ78r+cRRmLA==
X-CSE-MsgGUID: 7du/5QKGR32teefbW6y9TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11596"; a="63949446"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="63949446"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 04:12:42 -0700
X-CSE-ConnectionGUID: XYrDMqnlTqus2SqonZ4QRw==
X-CSE-MsgGUID: korAJy0QRd+qT2c7gkl5Zg==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 29 Oct 2025 04:12:40 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id E135297; Wed, 29 Oct 2025 12:12:39 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 2/6] panic: sys_info: Align constant definition names with parameters
Date: Wed, 29 Oct 2025 12:07:37 +0100
Message-ID: <20251029111202.3217870-4-andriy.shevchenko@linux.intel.com>
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
index 341c66948dcb..0d52210a9e2b 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -401,7 +401,7 @@ static void panic_trigger_all_cpu_backtrace(void)
  */
 static void panic_other_cpus_shutdown(bool crash_kexec)
 {
-	if (panic_print & SYS_INFO_ALL_CPU_BT)
+	if (panic_print & SYS_INFO_ALL_BT)
 		panic_trigger_all_cpu_backtrace();
 
 	/*
diff --git a/lib/sys_info.c b/lib/sys_info.c
index d542a024406a..6b0188b30227 100644
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
 
@@ -118,7 +118,7 @@ void sys_info(unsigned long si_mask)
 	if (si_mask & SYS_INFO_FTRACE)
 		ftrace_dump(DUMP_ALL);
 
-	if (si_mask & SYS_INFO_ALL_CPU_BT)
+	if (si_mask & SYS_INFO_ALL_BT)
 		trigger_all_cpu_backtrace();
 
 	if (si_mask & SYS_INFO_BLOCKED_TASKS)
-- 
2.50.1


