Return-Path: <linux-kernel+bounces-620437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7870AA9CAAA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 15:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FFD94C156C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 13:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3AB2580EA;
	Fri, 25 Apr 2025 13:39:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7998253952
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745588384; cv=none; b=qw1xcYq8EP0uL9ovsVijHb4Ko0K5DVHrAnYLq4OQqYm6qBGJ7mzLUcDRV7DVjcBmtW8kVAplwuK2HcSpL/0bk4ecBR7yQIVUDEfDMSuKcdMK74pfsQ+citYSJAqHjxaaRkSTgjBRMh/BOHJIk4+HRNVa3gdRxF2ER4e0PcaIMJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745588384; c=relaxed/simple;
	bh=JrLYW5I44SyEiqR5ilKyklAoMUVR3W+20vXQAyNqT7I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gg8ntK3sjB3yM/3QOdJTvdEp4uaruJgMa83uNbFibH1MhzG6LnskJdxu1pdlGUWCVboH2/qNiT65tHgTiRsUY66KPiuo4eDwDGKbhBlCs9hTyKcPjIirZiGL5UfMJ5J8CJocbBV5+7Obc9++wq0WvmS/p6jEYod/1QAcBLP5EkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 942DB1007;
	Fri, 25 Apr 2025 06:39:36 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 03EA33F59E;
	Fri, 25 Apr 2025 06:39:40 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org,
	Russell King <linux@armlinux.org.uk>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Will McVicker <willmcvicker@google.com>
Subject: [PATCH] amba: Fix driver_managed_dma check
Date: Fri, 25 Apr 2025 14:39:26 +0100
Message-Id: <20250425133929.646493-1-robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since it's not currently safe to take device_lock() in the IOMMU probe
path, that can race against really_probe() setting dev->driver before
attempting to bind. The race itself isn't so bad, since we're only
concerned with dereferencing dev->driver itself anyway, but sadly my
attempt to implement the check with minimal churn leads to a kind of
TOCTOU issue, where dev->driver becomes valid after to_amba_driver(NULL)
is already computed, and thus the check fails to work as intended.

Will and I both hit this with the platform bus, but the pattern here is
the same, so fix it for correctness too.

Reported-by: Will McVicker <willmcvicker@google.com>
Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/amba/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 71482d639a6d..84bc788663e6 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -353,7 +353,7 @@ static void amba_shutdown(struct device *dev)
 
 static int amba_dma_configure(struct device *dev)
 {
-	struct amba_driver *drv = to_amba_driver(dev->driver);
+	const struct device_driver *drv = READ_ONCE(dev->driver);
 	enum dev_dma_attr attr;
 	int ret = 0;
 
@@ -365,7 +365,7 @@ static int amba_dma_configure(struct device *dev)
 	}
 
 	/* @drv may not be valid when we're called from the IOMMU layer */
-	if (!ret && dev->driver && !drv->driver_managed_dma) {
+	if (!ret && drv && !to_amba_driver(drv)->driver_managed_dma) {
 		ret = iommu_device_use_default_domain(dev);
 		if (ret)
 			arch_teardown_dma_ops(dev);
-- 
2.39.2.101.g768bb238c484.dirty


