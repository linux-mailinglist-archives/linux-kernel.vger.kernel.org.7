Return-Path: <linux-kernel+bounces-727348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D569B018CE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5628DB471C3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E31D27E1C5;
	Fri, 11 Jul 2025 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fiuYa43g"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5181207E1D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227662; cv=none; b=sGzEk8k6v/25yJtKkxCACqP0nP+wpVb3J3fjsRHccFMNMMALbqHI65xIo827HLmoUQhRoSl3o4v1A/BLuy79epvbWATHcov5PAFhgyXojTztyugmLYPwbIuXk++1yVgbrDxe8JOlDgNOcsPQruLiVdjj/IfZqlNkZxYv9zRZgrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227662; c=relaxed/simple;
	bh=WSnjFxJmqKREQeZQX8pei+i2kLCc1PDoxkhUNvNKgkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DRI+Keq9DBdXGe0LQ4cM/sCxdzfI9tSs88kebmW0icQvclE9M+/TAvut2wFGQMtOFr+e+r5oS9OjcA2vUkbYwQl15bGpcNH1G/AYnu+wR5TFp7dmUAKiThM7/X7YIO/lTzpHCbvguYHlezTH2QPBGazmeni/jDqoYAN2d4BqAlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fiuYa43g; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752227661; x=1783763661;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WSnjFxJmqKREQeZQX8pei+i2kLCc1PDoxkhUNvNKgkk=;
  b=fiuYa43g4PmsBjGREAk2XxIx6EfscwOdsH5pfrE4+9TTcVrOu1uZjeuf
   BWQSNFqo0a8YH7Rbbmn12HHp9Siy+aSRO+xp+5FLBbpJZZ0cC1lHeijtk
   H3SaKV84+q5tsjbE0el+vZHIW02C1nkoa8bS7IFUcZlv2pHG9/3bv4GzM
   us4cSdVouzgidNckEuLmTurQKpGdxXwZg6DhnaFvj98NDdrWK598nRCbk
   vg5QjvkS5KwUkCHodgdEqnFqeQsTTjThF0rLYMZ+n7uhsV7eYOBKxd/bf
   qJAcM/z5qAlSNMnqc8RqeE5rpEQiZUERuvhXqugiK1ALS0lTYGhBrrt8k
   Q==;
X-CSE-ConnectionGUID: 2M3zMjoNS82rZ2rcWhNm9Q==
X-CSE-MsgGUID: 4Q1rY51KS76XzVgU1GcYOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="58332688"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="58332688"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 02:54:20 -0700
X-CSE-ConnectionGUID: DPZ8bF+/SpatUK+YnaQd6A==
X-CSE-MsgGUID: e2mDkCt7T22sp8ar2bmJbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="156669849"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 11 Jul 2025 02:54:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 382151A1; Fri, 11 Jul 2025 12:54:17 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [rft, PATCH v1 0/7] panic: sys_info: Refactor and fix a compilation issue
Date: Fri, 11 Jul 2025 12:51:06 +0300
Message-ID: <20250711095413.1472448-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While targeting the compilation issue due to dangling variable,
I have noticed more opportunities for refactoring that helps to
avoid above mentioned compilation issue and make code cleaner in
general. Please, give it a try.

I put a revert as the first patch of the previous solution, but I believe
the previous solution may be pulled out without a problem.

Andy Shevchenko (7):
  Revert "panic: fix compilation error (`make W=1`)"
  panic: sys_info: Align constant definition names with parameters
  panic: sys_info: Capture si_bits_global before iterating over it
  panic: sys_info: Replace struct sys_info_name with plain array of
    strings
  panic: sys_info: Fix compilation error (`make W=1`)
  panic: sys_info: Deduplicate local variable 'table; assignments
  panic: sys_info: Factor out read and write handlers

 include/linux/sys_info.h |   2 +-
 kernel/panic.c           |   2 +-
 lib/sys_info.c           | 129 ++++++++++++++++++++++-----------------
 3 files changed, 74 insertions(+), 59 deletions(-)

-- 
2.47.2


