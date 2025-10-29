Return-Path: <linux-kernel+bounces-875837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28B5C19EEE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A6D3B67BA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04D932C941;
	Wed, 29 Oct 2025 11:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M9oF+iel"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B920E3081B1
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736365; cv=none; b=sDZJWkJ3vo5t6g17TtscbDEYTFxtneY8f1lcuTB0F36xvaxyDzV2MpLmxocP6jjnmNZetK8SSxMLgWSzWuuUytQm8PvuyVMBArLuQxqsM7I+534nBtIrRasXz4pFTP/0M+/jP3MmD2xxwQEiVh9xNkwZcAM6rGy2sayRlH2Gpuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736365; c=relaxed/simple;
	bh=xFl33NIH/VAcDUSw92p+mqeEbeloDRQiXjCeFH9+dSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XKo87JSoAXwslPhym6jQG8Kigxjw6jWsWxZP5pVgTW/qm/kU5+OWcKe8RHOwP1dBYnevCBDYfkumtC/suDkgS5IAXZ+0+aRlzEbf3/89NC4wNOxshdjia2RmZ23it7DTMJsWVVdi3WQ5u7o+FFx0SINTII3Pk0RpuOXkZ83PR5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M9oF+iel; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761736363; x=1793272363;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xFl33NIH/VAcDUSw92p+mqeEbeloDRQiXjCeFH9+dSk=;
  b=M9oF+ielORYpqD0fX7pY0VsqiNzJST181ssHobF2BzST9to51ryWn26N
   sQztaxSBgU5g3Wm9o49BSJ4ZiGgeMLCmViVyBA70U0j/6ejOEkFbe/Bmn
   kpPh8Ze2K22xdhu39MoWYtq0HLDxCEAWAUxoHsDL/Hy1eS6E4E/EBEVgX
   yrLQYfG2Z+q4lYOB1KjII6jYugUhqOZriBM9ob4kDCSzKwnO7BcU905l+
   TNJx9kTGbfrBvz8PUnJUSLultwpqzDY7qYp/yUhDA64H+sMGJocpwo5mk
   x34DoCVysxdDQ+V+jg9284Sp42XF8UXX8y5f87LdDSXQjfWvYSYRRWnCs
   Q==;
X-CSE-ConnectionGUID: /qTxJhEJT+yugx/fFfusUw==
X-CSE-MsgGUID: Xo2zdUOGS/+81fBf5ID4jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11596"; a="74143483"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="74143483"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 04:12:42 -0700
X-CSE-ConnectionGUID: DMrsxH46RjKUFwH7Brjtvg==
X-CSE-MsgGUID: 78qxAlMkRw6uOmgCN/Mvxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="184866617"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 29 Oct 2025 04:12:40 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id D97DC95; Wed, 29 Oct 2025 12:12:39 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 0/6] panic: sys_info: Refactor and fix a potential issue
Date: Wed, 29 Oct 2025 12:07:35 +0100
Message-ID: <20251029111202.3217870-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While targeting the compilation issue due to dangling variable,
I have noticed more opportunities for refactoring that helps to
avoid above mentioned compilation issue in a cleaner way and
also fixes a potential problem with global variable access.
Please, give it a try.

Changelog v2:
- rebased on top of the current codebase
- addressed an issue when converting to match_string() (Feng)
- Cc'ed to Petr (requested by Feng)

v1: https://lore.kernel.org/r/20250711095413.1472448-1-andriy.shevchenko@linux.intel.com

Andy Shevchenko (6):
  panic: sys_info: Capture si_bits_global before iterating over it
  panic: sys_info: Align constant definition names with parameters
  panic: sys_info: Replace struct sys_info_name with plain array of
    strings
  panic: sys_info: Rewrite a fix for a compilation error (`make W=1`)
  panic: sys_info: Deduplicate local variable 'table; assignments
  panic: sys_info: Factor out read and write handlers

 include/linux/sys_info.h |   2 +-
 kernel/panic.c           |   2 +-
 lib/sys_info.c           | 133 ++++++++++++++++++++++-----------------
 3 files changed, 76 insertions(+), 61 deletions(-)

-- 
2.50.1


