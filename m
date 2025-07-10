Return-Path: <linux-kernel+bounces-725392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A63AFFE6C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EFDE5A2805
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA752D3EF5;
	Thu, 10 Jul 2025 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ib8qLE+/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561892D3EEC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752140904; cv=none; b=Ao59Ay6lwbrMlihcyN+HelBv7YSjTnywjgu4g2yhQuLEBIYX68rjKl92+SEVMfXvmxRDCsjkuGJf8BSx846Xc8orZwVMRcAm1e1tvVb6esVw92wNSoROlNy/mCx+pc7lZoEDVdGyUuLFhmeUtLJ4M57uJAC/IV0Rh5CJjxcLMKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752140904; c=relaxed/simple;
	bh=nnatc4TkPpgAsm+c5K7fBNRo0375E+ISMdEkvNj5f8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JrK940bVVLKFwIulxdmIodj/EqHnXG4a5hE46JzJeL7+wCxj6dEsnDylPTfDNCGQaKC6zNVLE/OxMzDz3xFqOTf7KrBzvsQghY3mzFfYC2eOyklLP2RBl4tVEsVLLTOkONv9l9SEQd4Y/cMM45iqvpPKS/abHEXjON3zFyMPRs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ib8qLE+/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752140904; x=1783676904;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nnatc4TkPpgAsm+c5K7fBNRo0375E+ISMdEkvNj5f8M=;
  b=ib8qLE+/FMpsrgsMKcrzkSMBxv7PA1BHLY8NupHhQYfMvkfgsqs7MDIl
   18wdfKog4JhooNYOc7g7qjlE/s0d5Cth/TyBkp5HvRJXe7cS/3B0auje7
   1U9oRt27rQGIXeVwremV76pGC19yKS6MG2au7QUr81c0EPE5/s/MCs0Au
   LIqVpVuzTxxgmRzMOy0hEZv9nBp9hTSiucfukJTeM9JObidebyIn0vLGd
   x0pPXerlQBPMBJIby4xa+4q36A0GCYgtfxZLffwbCHt2YCfx6I+q/lCTV
   42GMyeYFB88P0uRfqDs5OTjPnVjI3L+JmhadSS8l+R71F5X8uNsS8zh7o
   Q==;
X-CSE-ConnectionGUID: s006nQj1TZG+zNk8lsU/yA==
X-CSE-MsgGUID: ZJBlpKu+Tc+492cK+0gA2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="72001044"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="72001044"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 02:48:23 -0700
X-CSE-ConnectionGUID: S7N+VwO2S/2Q2y7my9Fx0g==
X-CSE-MsgGUID: vdA9EImIRueliBfdpyr6zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="156759633"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 10 Jul 2025 02:48:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 17E941B7; Thu, 10 Jul 2025 12:48:19 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 1/1] panic: Fix compilation error (`make W=1`)
Date: Thu, 10 Jul 2025 12:48:16 +0300
Message-ID: <20250710094816.771656-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compiler is not happy about the recently added code:

lib/sys_info.c:52:19: error: variable 'sys_info_avail' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
   52 | static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
      |                   ^~~~~~~~~~~~~~

Fix it in the same way how, for example, lib/vsprintf.c does in the similar
cases, i.e. by using string literal directly as sizeof() parameter.

Fixes: 9b5072c04c46 ("panic: add 'panic_sys_info' sysctl to take human readable string parameter")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/sys_info.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/sys_info.c b/lib/sys_info.c
index 46d6f4f1ad2a..779f8725b194 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -49,13 +49,11 @@ unsigned long sys_info_parse_param(char *str)
 
 #ifdef CONFIG_SYSCTL
 
-static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
-
 int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
 					  void *buffer, size_t *lenp,
 					  loff_t *ppos)
 {
-	char names[sizeof(sys_info_avail) + 1];
+	char names[sizeof("tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks") + 1];
 	struct ctl_table table;
 	unsigned long *si_bits_global;
 
-- 
2.47.2


