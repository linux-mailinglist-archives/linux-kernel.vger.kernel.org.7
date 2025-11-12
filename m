Return-Path: <linux-kernel+bounces-896786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9E5C5135C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DDEC1887C06
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744F92F90D3;
	Wed, 12 Nov 2025 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ey6FdFtt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AB72FD1D5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937549; cv=none; b=IlCLave6gfq0B1fO2Yxwy1h+D+nv3PfwWMhhsXFsapg5fd44goGPppANBEUggaijoBigX5Ftg+btRqgShQpM+Jc06jiGNs/pT0cEAbb/GCkih1GOsTIGQ170wr+80cV1ZMqIBLDbCud8OFVG9oKAs1AFS3bTdpzXXT3YENGKwok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937549; c=relaxed/simple;
	bh=/HupXrEtviHKeYqFWD2xOuGaa1w8dBZFeGJomcGBZZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iC/aIzDnpQgNqwrcXaJrEVAyg6boszA5RRU73+pD8sshrEhwe9UxsKFHhJ+BhVAXZbg7//rDGpZIbJ1d5UPVXM0MaZjum0bNigrS+OCfQWhPy7lzINRpkOllaR9i7TQnSAB4pDOexWUr5XKFCYMYFfWGm2BJOd1CxW/vIl+IUTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ey6FdFtt; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762937547; x=1794473547;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/HupXrEtviHKeYqFWD2xOuGaa1w8dBZFeGJomcGBZZ8=;
  b=Ey6FdFtt5tGy3GGU38CiF6gePomlLwHo15YNRD1BYn2Ud73Ug1K/CCmf
   r+rOGS1JalwIrXm7RCfvHzAWZYJYA644VLA2hfC397bmGfjZzND+q4t6H
   IC08Af4NU0U+Ew+vwP+YAq0U2vD01JKCkv0fNlPO9SnV0UJRgbHUdDXsZ
   r7g8vj/eCb3SiLmhplzUhn58PNumQ6yMIASeS+SFU6hKYkUyYTAjp8+mQ
   YQh3BHZI06SAfC4RUphUo6ccWRTiKkjqb3LIASwKg6pPo6paWEdyRj9Zl
   jrmAAwQThkFIFt4r55FCUGpNKTMBx+zOPfA+eR8HVXtgc4RVHX2EGz0d6
   w==;
X-CSE-ConnectionGUID: g+jbIm0FQwOgWW+RWS1fLQ==
X-CSE-MsgGUID: /ndqca4JSqKr8wYW+wp29Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="64900539"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="64900539"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 00:52:26 -0800
X-CSE-ConnectionGUID: PlNl9rPYTWWXs8v5DozB/g==
X-CSE-MsgGUID: Yx4G9kIMTnG3StpM5ARJhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="219894591"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 12 Nov 2025 00:52:25 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4E2F295; Wed, 12 Nov 2025 09:52:24 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Inochi Amaoto <inochiama@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-phy@lists.infradead.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v1 1/1] phy: sophgo: Remove unused of_gpio.h
Date: Wed, 12 Nov 2025 09:52:20 +0100
Message-ID: <20251112085220.1452530-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_gpio.h is deprecated and subject to remove.
The driver doesn't use it, simply remove the unused header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/phy/sophgo/phy-cv1800-usb2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/sophgo/phy-cv1800-usb2.c b/drivers/phy/sophgo/phy-cv1800-usb2.c
index 64f8e37b4b52..6fe846534e9c 100644
--- a/drivers/phy/sophgo/phy-cv1800-usb2.c
+++ b/drivers/phy/sophgo/phy-cv1800-usb2.c
@@ -11,7 +11,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/phy/phy.h>
 #include <linux/regmap.h>
-- 
2.50.1


