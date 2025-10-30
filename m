Return-Path: <linux-kernel+bounces-878294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3B5C2032F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 859ED34ED72
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360F32E427F;
	Thu, 30 Oct 2025 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q+bcsbAu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D5D238C2F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761830422; cv=none; b=pRmQVNhfjWJ+Gy/vUz3TCUuG5YOmpWv4BkelFw9fPcaXPMjyJbosCkLtOMwMW/KCI9dXQZpS41o26ywZUO58rIgH8udpBzUabtPmnTXjiP4A9PWRVFndh2pT+DcmEsItO/SVEcQeDN3z/y2xWDowdyt6vXTdyPImwnZgNp3FoqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761830422; c=relaxed/simple;
	bh=rP1zcVjnh0mDF57RTRqyJzzrJqRl3/5VbJO1YClko/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zby3qBTuTFxcXmf+WTNdlx/b2ejUgDGxKtigh6GPwd97d5Uo6P6BfDZXTFvpR4OghpKa0WAkkjxhTR22sR/491VIjRWgY8BtEfMMWCUulC06fh2tIwIVbZ/T3U9EvWBoZUcd3H3Xf3y57cfIpJA+RDw1Rnpx+qYiEZavYC8khrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q+bcsbAu; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761830421; x=1793366421;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rP1zcVjnh0mDF57RTRqyJzzrJqRl3/5VbJO1YClko/k=;
  b=Q+bcsbAu998VkdmGDhqSfURjXwkuoVEHxEyOoKATkL7w5WJdA4odCpxx
   aoZ4vNPfetsVtL5IXH1XqdBm5y8AI6xbRj6Om0xcENLIcL8drqBxKzjT/
   WlNna0UyURwG1hQbVhaX9ObhTrr4t4tfgHn6s+KtT87gszj3tXXOF3awO
   xw5BIW1dSy+tU8OLnukBTyIkT+t+DvmidkrN7L9g4k749gl/le6lSkSIH
   /izwohaZnF/l+LKZrjhD1wQOruAoYtV9mp33Z1khDaWY5fB0ZweLfHsxM
   2/dQadniMp24jhCTx8pt30zDjCs8AJErPoMK9LNJrTTDK/itbNOjQWnKE
   A==;
X-CSE-ConnectionGUID: SXQGTRPYRpOT8ypkQaJHEg==
X-CSE-MsgGUID: SGqeSBlKTTukPDkayjqsPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63899808"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63899808"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 06:20:21 -0700
X-CSE-ConnectionGUID: 9cMM3Em6SW6znlRuv2hz1A==
X-CSE-MsgGUID: vXXKuPrQQLC04x7hm0dDRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="209532358"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 30 Oct 2025 06:20:19 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6CBBF96; Thu, 30 Oct 2025 14:20:18 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 0/6] panic: sys_info: Refactor and fix a potential issue
Date: Thu, 30 Oct 2025 12:44:16 +0100
Message-ID: <20251030132007.3742368-1-andriy.shevchenko@linux.intel.com>
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

Changelog v3:
- addressed an issue with empty parameter returned (Feng)
- gathered tags (Feng)

Changelog v2:
v2: https://lore.kernel.org/r/20251029111202.3217870-2-andriy.shevchenko@linux.intel.com
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
 lib/sys_info.c           | 138 +++++++++++++++++++++------------------
 3 files changed, 78 insertions(+), 64 deletions(-)

-- 
2.50.1


