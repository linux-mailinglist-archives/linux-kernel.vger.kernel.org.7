Return-Path: <linux-kernel+bounces-790527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4BFB3A9C0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E121C81FF2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAB726F2AA;
	Thu, 28 Aug 2025 18:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YPFHsozX"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D948216E1B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756405071; cv=none; b=luK2F9LPXZAEFXc5Ns8GqCKU9a5GE3IaOb0jSRbG5+irGPQaBMvroT1q1VcpZNgbzJ4z9p/Y1q9k4Wa9qYFjGKJtx2vMgSA/olLQ/iLQAAanVpeS36SvTkHhO+Ah5O3tqmhJapGWtbdTzI2YhiC0LWQTg8SZ/npTUYq258UCt5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756405071; c=relaxed/simple;
	bh=AvMoe/f/O3Oh/h66U913l/k1DKROnTm2W5u/fWFpb+w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m3cMqmdRHQesWFHILIIvqN63zUSgwqpHQG/v75U0V8O0bVVTedMzH0fcm4vIqHrW3VWa5ZflHM+o7YC6LZFaO+Ur1+bOBZB3g2QYG9TeTSM67JQ0eWn5Nht1Sg3AOj6vtGYcGfDRvalfZcKcgqr8jJnmnwWa1rEyMB6PpMFbLt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YPFHsozX; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756405066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YqtJtL3fBEiMtwk9pStPuNnS2FkeUcvwr8He096wXA4=;
	b=YPFHsozXzH3UGPY5aplZqj4qSxRGfxYI34m1c9VsPbALCXAz5bkYHa02xVb0MGw+3qBBH9
	8JGk+rsJmYZ4HzGTJAsqRF7miHes9zvf2qo07Jurfe9aKH7KYruqNn+Ml7RuO/1c7F0kSg
	J9ptnYa2zRUD+xjgxEWnaXXpOexpFuU=
From: Sean Anderson <sean.anderson@linux.dev>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Mike Leach <mike.leach@linaro.org>,
	Linu Cherian <lcherian@marvell.com>,
	James Clark <james.clark@linaro.org>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH] coresight: Fix possible deadlock in coresight_panic_cb
Date: Thu, 28 Aug 2025 14:17:38 -0400
Message-Id: <20250828181738.1529289-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

coresight_panic_cb is called with interrupts disabled during panics.
However, bus_for_each_dev calls bus_to_subsys which takes
bus_kset->list_lock without disabling IRQs. This will cause a deadlock
if a panic occurs while one of the other coresight functions that uses
bus_for_each_dev is running.

Maintain a separate list of coresight devices to access during a panic.

Fixes: 46006ceb5d02 ("coresight: core: Add provision for panic callbacks")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/hwtracing/coresight/coresight-core.c | 40 ++++++++++----------
 include/linux/coresight.h                    |  1 +
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index fa758cc21827..1f1bf0e2bf92 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1315,6 +1315,9 @@ void coresight_release_platform_data(struct coresight_device *csdev,
 		coresight_remove_conns_sysfs_group(csdev);
 }
 
+static DEFINE_SPINLOCK(csdev_lock);
+static LIST_HEAD(csdev_list);
+
 struct coresight_device *coresight_register(struct coresight_desc *desc)
 {
 	int ret;
@@ -1374,11 +1377,16 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 		goto out_unlock;
 	}
 
+	scoped_guard(spinlock_irq, &csdev_lock)
+		list_add(&csdev->csdev_list, &csdev_list);
+
 	if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
 	    csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
 		ret = etm_perf_add_symlink_sink(csdev);
 
 		if (ret) {
+			scoped_guard(spinlock_irq, &csdev_lock)
+				list_del(&csdev->csdev_list);
 			device_unregister(&csdev->dev);
 			/*
 			 * As with the above, all resources are free'd
@@ -1427,6 +1435,8 @@ void coresight_unregister(struct coresight_device *csdev)
 	coresight_remove_conns(csdev);
 	coresight_clear_default_sink(csdev);
 	coresight_release_platform_data(csdev, csdev->dev.parent, csdev->pdata);
+	scoped_guard(spinlock_irq, &csdev_lock)
+		list_del(&csdev->csdev_list);
 	device_unregister(&csdev->dev);
 }
 EXPORT_SYMBOL_GPL(coresight_unregister);
@@ -1563,28 +1573,20 @@ const struct bus_type coresight_bustype = {
 	.name	= "coresight",
 };
 
-static int coresight_panic_sync(struct device *dev, void *data)
-{
-	int mode;
-	struct coresight_device *csdev;
-
-	/* Run through panic sync handlers for all enabled devices */
-	csdev = container_of(dev, struct coresight_device, dev);
-	mode = coresight_get_mode(csdev);
-
-	if ((mode == CS_MODE_SYSFS) || (mode == CS_MODE_PERF)) {
-		if (panic_ops(csdev))
-			panic_ops(csdev)->sync(csdev);
-	}
-
-	return 0;
-}
-
 static int coresight_panic_cb(struct notifier_block *self,
 			       unsigned long v, void *p)
 {
-	bus_for_each_dev(&coresight_bustype, NULL, NULL,
-				 coresight_panic_sync);
+	struct coresight_device *csdev;
+
+	guard(spinlock)(&csdev_lock);
+	list_for_each_entry(csdev, &csdev_list, csdev_list) {
+		/* Run through panic sync handlers for all enabled devices */
+		int mode = coresight_get_mode(csdev);
+
+		if ((mode == CS_MODE_SYSFS || mode == CS_MODE_PERF) &&
+		    panic_ops(csdev))
+			panic_ops(csdev)->sync(csdev);
+	}
 
 	return 0;
 }
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 4ac65c68bbf4..a5e62ebd03b5 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -302,6 +302,7 @@ struct coresight_device {
 	/* system configuration and feature lists */
 	struct list_head feature_csdev_list;
 	struct list_head config_csdev_list;
+	struct list_head csdev_list;
 	raw_spinlock_t cscfg_csdev_lock;
 	void *active_cscfg_ctxt;
 };
-- 
2.35.1.1320.gc452695387.dirty


