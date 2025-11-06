Return-Path: <linux-kernel+bounces-888827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EF1C3C087
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EBD93B3EE8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16982266582;
	Thu,  6 Nov 2025 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gtl4Rgfk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C392475D0
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442457; cv=none; b=TTqcVQX0W6lC27P9akf62c9v9Mbo5Ten0ClfHG0DWHjbqjuv4hyXX73CtDnEtQROT0T0jyzpl6wlxnpPB1F9X14C00V/5q5Iu9qpPQDzQV4f6xiLqqe+IgDvpbXXKvvZI+qgnK2eYai90/1VHZH4idR6R4d0bwnBMdjdqCl7DTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442457; c=relaxed/simple;
	bh=bzFS3bRMMrYYlXOSRZ6YYXzzwOxNCRYCEcNMy9sHD2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=blYmkhW9dMBQGdkApy35b7kCRKpbwfIJrw4r2e62E9ZfSrzUFx819x09D3ipx3VDftTGDqMF8AaAe6ALEaGBn++VugJTzuztWTh/R17mztU9emXrhvdSlf22dlVGEugp5VF71P6/MiTEIH6G5xjkFbKfvu3BfzOQoWo2EhaSBQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gtl4Rgfk; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762442455; x=1793978455;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bzFS3bRMMrYYlXOSRZ6YYXzzwOxNCRYCEcNMy9sHD2Y=;
  b=Gtl4RgfkxyBzhiJ0Yxr0fNnRVyO7bqdNHXszNYC+RbRCYRkoLfVKji89
   Q5WwHMm4ihoJi+4F8z5abfaGFE5GS4f6FkD+m/ffPDRBGznKhNYga2TqI
   GIxph1AJEf/fzW+VoAVW/filiW+iI09qLWhzd3y0UOT7WSNxxAB1wbCBR
   PG828AYT5yiiPWKdUikN7Y2JOQaClOLCeZYcBc6iY0KyCeimwCo2wMp29
   c6K1F82TqXUQTuEDix3xvlc6RKrMAI9Xswq7EGln8NYc7qn86iGMNGBPL
   8f8FIEyFG+/uzVP+jjISHBYYgBet3PWmTKEm3cKFrDqp7clkAn+hy6Zt8
   w==;
X-CSE-ConnectionGUID: krsMfABSRU+NrQpPOM6J2A==
X-CSE-MsgGUID: m0hiOaYdROyAipekJC1D5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64464879"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="64464879"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 07:20:55 -0800
X-CSE-ConnectionGUID: lit7DOnwSDK+BlkMyS9N1w==
X-CSE-MsgGUID: 75XPaZbMQYmNB14lVVBKsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="192830939"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 06 Nov 2025 07:20:53 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 05CC096; Thu, 06 Nov 2025 16:20:53 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v1 1/1] math.h: Amend kernel-doc and add a note about signed type limits
Date: Thu,  6 Nov 2025 16:20:51 +0100
Message-ID: <20251106152051.2361551-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First of all, amend the existing kernel-doc so the description
of the function is decoupled with the parameter descriptions.
Second, add a note to explain behaviour for the signed types when
supplied value is the minimum (e.g., INT_MIN for int type).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/math.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/math.h b/include/linux/math.h
index 7fcb980677a0..c02cc5b9e6ae 100644
--- a/include/linux/math.h
+++ b/include/linux/math.h
@@ -180,11 +180,16 @@ __STRUCT_FRACT(u32)
 
 /**
  * abs - return absolute value of an argument
- * @x: the value.  If it is unsigned type, it is converted to signed type first.
- *     char is treated as if it was signed (regardless of whether it really is)
- *     but the macro's return type is preserved as char.
+ * @x: the value.
  *
- * Return: an absolute value of x.
+ * If it is unsigned type, @x is converted to signed type first.
+ * char is treated as if it was signed (regardless of whether it really is)
+ * but the macro's return type is preserved as char.
+ *
+ * NOTE, for signed type if @x is the minimum, the returned result is undefined
+ * as there is not enough bits to represent it as a positive number.
+ *
+ * Return: an absolute value of @x.
  */
 #define abs(x)	__abs_choose_expr(x, long long,				\
 		__abs_choose_expr(x, long,				\
-- 
2.50.1


