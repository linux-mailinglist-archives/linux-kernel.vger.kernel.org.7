Return-Path: <linux-kernel+bounces-895262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430E6C4D61C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E543A5CAD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D673559C1;
	Tue, 11 Nov 2025 11:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cny9TFof"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABB935580C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762859976; cv=none; b=riSOtl7p8dttznIhfOAi3hVg550EOuRhE+MXR+s9VB7Gn/s3zVptor4Nzb1ZIYQt+iaxhMveu1vYubo/OkQSOvJ/MdvsWDBXmEzF9pAi6l5JhBfcra+1wfCufdvYp/pPbWB2YCSa1O+RheslIU7JPgP5nmmN4VLswXZDQrBNKog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762859976; c=relaxed/simple;
	bh=9T0WYmDAOm7giXvF1mgj/3D0HBRvqmglFqNtm8BgpMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFumFB4MxyCEYjc7oTOZ/XV7DV8UAGcC7r9CUMtKRxvwDu2aqpsfcd/Q9YGGIzskj69ezestTj0DJTpZ8budzrAPE6wHDwZFFmDHVGCFz/yi9yKbadiLCblwYUvHI0EDeMrovs0HntzjPvWosv+g3nEOcIsJZqTjFGNRrCdKsUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cny9TFof; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762859973; x=1794395973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9T0WYmDAOm7giXvF1mgj/3D0HBRvqmglFqNtm8BgpMI=;
  b=cny9TFof5ruHmctx08FmcOatfM+rCK+5kTp7gBoEXJOnHmT7IzaASjiL
   uu4XxNFKRZ6iX5pzW0pKVMlZ1+h+e+gm3BdAznD8cgMch9nH/GzmGU8mN
   BpRVK91tS7GsYvP8C/PMlkiqZZibnDgeaXmoXtxUmL/YUi6+KX0fX9Neu
   nnwog0sKXU4uMBu8wTzuJAfandR1Ybc0ILYqi5nHXg+fRjuBAUSYjzD2q
   0WfGX2W0M+IFyRX7qVy2BVlclcLF15KmMwrXht12Q1/1YVhfeWM3FJPd8
   3hbHVw82qe4u8pWzRLNZZbmFa4X9xquduryCZhQEaa1R3AuNcYRk2XVAh
   w==;
X-CSE-ConnectionGUID: uoTRvaTZTBOs3lTISRCGJg==
X-CSE-MsgGUID: zBRzguvlSRavWCepY8l1ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="63922916"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="63922916"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 03:19:32 -0800
X-CSE-ConnectionGUID: 7KRySQPbRYeXDo4od8bOMg==
X-CSE-MsgGUID: dkfo88vgSVqNB4eYiK/VeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="226200394"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 11 Nov 2025 03:19:33 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 802FC98; Tue, 11 Nov 2025 12:19:31 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Cc: Yixun Lan <dlan@gentoo.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] mfd: simple-mfd-i2c: don't use "proxy" headers
Date: Tue, 11 Nov 2025 12:18:36 +0100
Message-ID: <20251111111930.796837-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251111111930.796837-1-andriy.shevchenko@linux.intel.com>
References: <20251111111930.796837-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use) principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/simple-mfd-i2c.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index 5fd0ef3fa44a..8b751d8e3b5a 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -15,12 +15,18 @@
  * will be subsequently registered.
  */
 
+#include <linux/array_size.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
 #include <linux/i2c.h>
-#include <linux/kernel.h>
 #include <linux/mfd/core.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/stddef.h>
 
 #include "simple-mfd-i2c.h"
 
-- 
2.50.1


