Return-Path: <linux-kernel+bounces-885360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA37C32AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8423A4E88BA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3237833343E;
	Tue,  4 Nov 2025 18:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aK4VdqlG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EAE381C4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281522; cv=none; b=aKwciRZWYbP2EkOd4GWAqv4lHKndBja7V1hFxyo2BNy3cQLa7F7IIS+D0KIwTcsDjQB3i25oC2E0cJNDkjdKjSgZMoKcED4z7DiykU/GM/7rrnSG6rwKp1gENn5J2KSs9Fq6Y9q4CyvrdZyC1Hn/f/+tAyWOm6nlVtUyps7n3VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281522; c=relaxed/simple;
	bh=cht6nHeLCOiPAeXjK6UTXyfo5wHYPv31b9F2JiiCjzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NnToF6GTXrtTntxIbcwU2JYbpkl7yuR+fYJOlIzhelUC+38OiGs3jRTmAOVpKiSMb8gzaI/zrLL8085wr69mO/B2bG3o2lxxWbBiN20YJzlXSOS9uEdlLsHMFeka8NFJXDYRT6G+br673dUJVP/kJDVP8puS9xcGb/Rp8OWhUEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aK4VdqlG; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762281521; x=1793817521;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cht6nHeLCOiPAeXjK6UTXyfo5wHYPv31b9F2JiiCjzI=;
  b=aK4VdqlGAqX4705amHDeSUuQ2C4ZuRnDVlDf+Zz1akk3jOT5HmUO+x3Y
   INNT8fzjVyhuHMElFsJMED6hNkJA82GLb7+AwYcdmG3/k/jJWEAP15tze
   LdDMjWzR5q0xYAwqjrrs2ZygS4rNiq5fHpZ6yUIMN1MtnZb0zLszez8vL
   zgaaOKjBXKhpoTLq94pjZh7YQRimysQ5NMa0DX0ZD7HWoXFqzHx0V/e3z
   z8qBqvyOqwRome7Y3RFd2Jci4RuW46TUJW3J9mPsP7x7WuHznMs9xD8ws
   Te69aLQffeaJKNILcpJMEtVM6I89T1E5SIA9TY+nPlKY1t9AvE+krXdqI
   g==;
X-CSE-ConnectionGUID: IpfjeNZhShiK0NyjU6oqyw==
X-CSE-MsgGUID: +hMnDmsrTnu8S48YW/ewWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="75735875"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="75735875"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 10:38:40 -0800
X-CSE-ConnectionGUID: yor9Sf+xTvy/LOSYVZGVrA==
X-CSE-MsgGUID: PwT0Fe8rRnyEAd3kLBwOYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="191588455"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 04 Nov 2025 10:38:39 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 43A5695; Tue, 04 Nov 2025 19:38:38 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Alexandru Ardelean <aardelean@baylibre.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 1/1] util_macros.h: Fix kernel-doc for u64_to_user_ptr()
Date: Tue,  4 Nov 2025 19:38:34 +0100
Message-ID: <20251104183834.1046584-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The added documentation to u64_to_user_ptr() misspelled the function name.
Fix it.

Fixes: 029c896c4105 ("kernel.h: move PTR_IF() and u64_to_user_ptr() to util_macros.h")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/util_macros.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/util_macros.h b/include/linux/util_macros.h
index 9373962aade9..2eb528058d0d 100644
--- a/include/linux/util_macros.h
+++ b/include/linux/util_macros.h
@@ -136,10 +136,10 @@
 #define PTR_IF(cond, ptr)	((cond) ? (ptr) : NULL)
 
 /**
- * to_user_ptr - cast a pointer passed as u64 from user space to void __user *
+ * u64_to_user_ptr - cast a pointer passed as u64 from user space to void __user *
  * @x: The u64 value from user space, usually via IOCTL
  *
- * to_user_ptr() simply casts a pointer passed as u64 from user space to void
+ * u64_to_user_ptr() simply casts a pointer passed as u64 from user space to void
  * __user * correctly. Using this lets us get rid of all the tiresome casts.
  */
 #define u64_to_user_ptr(x)		\
-- 
2.50.1


