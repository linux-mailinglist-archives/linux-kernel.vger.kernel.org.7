Return-Path: <linux-kernel+bounces-883495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8867AC2D99E
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6A654EC798
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F281315D2C;
	Mon,  3 Nov 2025 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jwdf1mLw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560EE3054D4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762193393; cv=none; b=SwRDathQzld2JSJg7OcK/LoTi0enbwNUb7RF1sMZbOdu0AEU+sghcVt2oBm6NQtRosmLjvFK5jy4xqckyXBk1w7KdVeF0i8FyOQAhTKq5ywIbI20NtbG0ROK+rFPD5Wvibpu3etP7mmCjCsBHdhvCGoKs1CI2GM1OXIdFPv1ncU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762193393; c=relaxed/simple;
	bh=iXPfZ5FY+zUIYrHLJwoGCYyUEKkk49FEF+D5zZmcY8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RnJr0DOgdhHuwpzcJefMp+8N1qgnu5jPO8zlQzA/ECtDg+Luct/wUxVw1NSnnMcKK0Ul1NYoWY2+vpTTZgC/xq/+DG/TYcnDEbCJhd5ZiwDwut0nt10sIcRWojPY7d/e8cAaQ8KxdfkkicGWMHXFA+tULVMSQHvs6/jUKWjyswI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jwdf1mLw; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762193392; x=1793729392;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iXPfZ5FY+zUIYrHLJwoGCYyUEKkk49FEF+D5zZmcY8Y=;
  b=Jwdf1mLwtO4KOz/uczo6xflSfTeaFRzrFWuFlQPwj5/3sJhGJ60H2S9L
   co1UO7wdeHZ11XqBkwOp2ZItg3aCuLDNHBofrbvWdOkTCOCjpOHC6hUj+
   1y/P3B5BAkSYj0O9mIOgAe+Q+jlcGJfLRzT7N4WC5VfWRciaweIsFJLiC
   w5vARRrQQUigSmMU5a6mS/phaFnP3PusEfI//fkegou4mvNU8GWxPD05M
   ZnovK1J7SjCVCrMhj9DYNwD1gFzDUed4XzNkDT8ftxb0V2NnwK6CMAtZ6
   3qmrE/LL6ngdm7zd5IA0z7FgkP8n1KiALD/4Wz9FlHwa6lg6jAN1EiAbX
   g==;
X-CSE-ConnectionGUID: 6rvFmY4qQ5aRytZsr3p6hA==
X-CSE-MsgGUID: mU13AKjcQvWhx1zvpnACsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="67932148"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="67932148"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 10:09:51 -0800
X-CSE-ConnectionGUID: Owwezh3xSDSuJccpkl+PTQ==
X-CSE-MsgGUID: rdYlV66HSTW0GDa8LD5Ncw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="187247324"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 03 Nov 2025 10:09:49 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 9C25C95; Mon, 03 Nov 2025 19:09:48 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v1 1/1] regmap: i3c: Use ARRAY_SIZE()
Date: Mon,  3 Nov 2025 19:09:46 +0100
Message-ID: <20251103180946.604127-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use ARRAY_SIZE() instead of hard coded numbers to show the intention
and make code robust against potential changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regmap-i3c.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap-i3c.c b/drivers/base/regmap/regmap-i3c.c
index b5300b7c477e..6a0f6c826980 100644
--- a/drivers/base/regmap/regmap-i3c.c
+++ b/drivers/base/regmap/regmap-i3c.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
 
+#include <linux/array_size.h>
 #include <linux/regmap.h>
 #include <linux/i3c/device.h>
 #include <linux/i3c/master.h>
@@ -18,7 +19,7 @@ static int regmap_i3c_write(void *context, const void *data, size_t count)
 		},
 	};
 
-	return i3c_device_do_priv_xfers(i3c, xfers, 1);
+	return i3c_device_do_priv_xfers(i3c, xfers, ARRAY_SIZE(xfers));
 }
 
 static int regmap_i3c_read(void *context,
@@ -37,7 +38,7 @@ static int regmap_i3c_read(void *context,
 	xfers[1].len = val_size;
 	xfers[1].data.in = val;
 
-	return i3c_device_do_priv_xfers(i3c, xfers, 2);
+	return i3c_device_do_priv_xfers(i3c, xfers, ARRAY_SIZE(xfers));
 }
 
 static const struct regmap_bus regmap_i3c = {
-- 
2.50.1


