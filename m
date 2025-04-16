Return-Path: <linux-kernel+bounces-606967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF20A8B62F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 11:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC5783A39E1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 09:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9FA238179;
	Wed, 16 Apr 2025 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SFrD/OrF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47857238152;
	Wed, 16 Apr 2025 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744797413; cv=none; b=qv1R1bI+gRx11Z4qNeCgjb8cVCwJ97eLnCKcBlRgfKm6br95MSMTk25EuyTyMG305MIUAanjhZ+N8yRYvU58uU+jg4eu8tvu7YYtnVdD8caCMyq1r2IdiOtZpCS58C8V5qHM0LMtRuWXqJ/JyEi56TU9wXYsLJNev/uHotZxBV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744797413; c=relaxed/simple;
	bh=cX6Sn6odB3ha7kuWydmTl+RgZMLnKDiJ+oPgOg3cYJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gs33d4SHVq7GNqxp81emdFSYO5gLXloMGQJHIx032CBXUXvsJBkiuIv5M2zV36Yj2+/6p3RRlDT+a9Uxh0YxAaABLxyKMSGSyUp4LuApPV6GOnrGiPd8RopPKIIO/XNTTLbEyYyrmksc4cEPnI3TGgpTDRgiijMyCiXBKYi2bw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SFrD/OrF; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744797412; x=1776333412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cX6Sn6odB3ha7kuWydmTl+RgZMLnKDiJ+oPgOg3cYJ4=;
  b=SFrD/OrFORf4ujdPllAAnGS3MJ7WyePuBFAjlb4I3rZEwdknA3rCm/+Y
   sXsGnTv/M5zRYhMZKX+XvbEEA8y1+PFPERljvu3n4RJ+VhpjVuaRno7Z0
   iDNGQyhkiGuzu9ytWYa0+SCTx2f2IgUFYpXkp8nuqq53d/RZdftvtj5T+
   RI6Lbx2pj8TuStmCwMBsOnz/1wjP+Bw4iWDGWBacApxHl37CnmYY6kE8v
   Kfe7cmMB8IF+9w2a0CEg5qneyTeAYXz/xBLpx6cFan4rSpDHxzkLwzMEK
   Ka+QgTkqrEOy6H3KrDIdDv8VyannjRr1ATgzka4GZUY3x55OvgMSEf7GO
   A==;
X-CSE-ConnectionGUID: K4P/5yZ2QPmu9K9Ely9xZA==
X-CSE-MsgGUID: D0dJilwjSPCaEWJ+P+Dv/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="63743637"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="63743637"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 02:56:49 -0700
X-CSE-ConnectionGUID: VFIrXNGOSG2+VvHVl05kxg==
X-CSE-MsgGUID: O8x2L4sqSeynTnKPn+QqmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="131323320"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 16 Apr 2025 02:56:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E1026E0; Wed, 16 Apr 2025 12:56:46 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/8] gpiolib: Make taking gpio_lookup_lock consistent
Date: Wed, 16 Apr 2025 12:55:09 +0300
Message-ID: <20250416095645.2027695-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250416095645.2027695-1-andriy.shevchenko@linux.intel.com>
References: <20250416095645.2027695-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two ways to take a lock: plain call to the mutex_lock()
or using guard()() / scoped_guard(). The driver inconsistently uses
both. Make taking gpio_lookup_lock consistent.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index b8993d2d31e1..7d9cc1a9c535 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4363,12 +4363,10 @@ void gpiod_add_lookup_tables(struct gpiod_lookup_table **tables, size_t n)
 {
 	unsigned int i;
 
-	mutex_lock(&gpio_lookup_lock);
+	guard(mutex)(&gpio_lookup_lock);
 
 	for (i = 0; i < n; i++)
 		list_add_tail(&tables[i]->list, &gpio_lookup_list);
-
-	mutex_unlock(&gpio_lookup_lock);
 }
 
 /**
@@ -4427,11 +4425,9 @@ void gpiod_remove_lookup_table(struct gpiod_lookup_table *table)
 	if (!table)
 		return;
 
-	mutex_lock(&gpio_lookup_lock);
+	guard(mutex)(&gpio_lookup_lock);
 
 	list_del(&table->list);
-
-	mutex_unlock(&gpio_lookup_lock);
 }
 EXPORT_SYMBOL_GPL(gpiod_remove_lookup_table);
 
-- 
2.47.2


