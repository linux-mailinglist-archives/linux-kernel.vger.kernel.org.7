Return-Path: <linux-kernel+bounces-878295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 180A3C20334
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B7C7B34EDE2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F6D2EC088;
	Thu, 30 Oct 2025 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bnPXwAsf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4505238C1A
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761830422; cv=none; b=uTzSzov3EWXUc2jjWt3mHHguvBhet+KIMChuRLfbZVCjVwkkkJKi2I+EgL18q8c6sCAQCl6GfG0xMYNk2Yvz/FG2QManKL1/4kXhf1XR+tNYDMGOHBOh7yZF+8bbwHwOahl1RxQG1WjYxYPB9ihAJW6oF9t1C0LPx+lWX69rS1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761830422; c=relaxed/simple;
	bh=A6aFzq7aWb1ouGnLNfuHinjTz+8h8YEe3xtoATyHhlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tb3Fpw4WnskSjm1Yrw80x7ygvfOa0+eF/Qi06Fb8ElmWHTmWw+iI1vyt20DGjXG0wslQxor81TLeS/G5Q0+5v7/N8U1O0JprmQZIT7vgrAHhIF8tgkmRnLf0f7ey12qv3ahFCVrojzmvbIH5ALrAgYo3ix7bXATWNND46qqoIlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bnPXwAsf; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761830421; x=1793366421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A6aFzq7aWb1ouGnLNfuHinjTz+8h8YEe3xtoATyHhlk=;
  b=bnPXwAsfO/39ZzmhpN9gzigi4Dt1v7SkAS1h1Kl7ZL12F6lTIUsPqH8Q
   kXeLbGGbuNbR8QXX7lVnEWpONchSRcDpH1Idcv/fhnJe8/6Qz5jA4unAV
   J2EaN7OXAM4whTRJKuwXmYAuPMdu9TDFy8O/EZqkWdpvHO64HR4JdAK2j
   xQSoj8FZtKoEUiFHr6p9vAhajbU0yVJhQF4GY4wvtjW9SMiP004yPN3Nx
   skrcp1USfNro+RXkfyIAVnsNKidjXuuYqOIMrXa7g72DAnsT0W2seosGc
   LcWr8UFvHRWzFif+PeQ/nHeN5e8xwTbt303zpcgk2XsZla3SQ5g7lZz0a
   w==;
X-CSE-ConnectionGUID: 8jBn/2TKQgWs+hdHscXg6w==
X-CSE-MsgGUID: nynXspdGRWC3sw9HobM8FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63875748"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63875748"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 06:20:21 -0700
X-CSE-ConnectionGUID: HBW2v6KOTIm5vKEKJA5mBA==
X-CSE-MsgGUID: w5yYLgcEQxGIbYxNaInhwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="191093198"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 30 Oct 2025 06:20:17 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 73ED798; Thu, 30 Oct 2025 14:20:18 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 2/6] panic: sys_info: Align constant definition names with parameters
Date: Thu, 30 Oct 2025 12:44:18 +0100
Message-ID: <20251030132007.3742368-3-andriy.shevchenko@linux.intel.com>
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

Align constant definition names with parameters to make it easier
to map. It's also better to maintain and extend the names while
keeping their uniqueness.

Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>
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


