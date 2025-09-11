Return-Path: <linux-kernel+bounces-812417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA6EB537E1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D0CCAA2B96
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8030D350D77;
	Thu, 11 Sep 2025 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C37DQb3O"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DBB314A62
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 15:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604818; cv=none; b=QFBGNqZisHA45ykBehxLpS2qzZCrIqQD4fuOZzYsV85OGI4hT92CzKmDTz3C7iyFNVTmOKtkvGZvU1Ktdo0Soh/sOCGmson3dzJATKCsFQ+0i7TePX6hBt35wWHktt4tjK740K8qKFkQlkDkDHlIpc1/p+KIIAEr06VqHeN09XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604818; c=relaxed/simple;
	bh=eBaSEHFlOb+Sj2Ytt8kEDY7Z0F2L8DBgrNrEPL5tY/4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UAZc/w88h9Guh12qEPTtWubgb0L9h029C7srVRE/j67pGZUKFL0nRsHyLaEnKlFMUjzmEfanQLfntOOfNezNhu3iEYt3ykQ3mdWmTC0VorTVIb/QvIXS3SigeSp8cyqP3JGwiy2CenvEh++zny0QPO0JRCy1ut1AYcvM7bUMewg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C37DQb3O; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757604806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ff/wyuZO5UIQVkCR2N2KX4E1vX6xd5TgHmsu3ejak7Q=;
	b=C37DQb3OEJOJsqSu2+34RxAJXBOa8EL9L4biqD5chRL3DhDnVB9duDnfJvNl+Ip2kBMf+o
	W6h0neeBYXplrNbQuxWPsow9OirZjuPEsGMhg46k+mXfF82dQTipBWqLVlWwLWn79w8NVX
	33OYtb0xp0cVFt4l9QgolRLmDJTm8Y8=
From: Sean Anderson <sean.anderson@linux.dev>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mike Leach <mike.leach@linaro.org>,
	Linu Cherian <lcherian@marvell.com>,
	James Clark <james.clark@linaro.org>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v2] coresight: Fix possible deadlock in coresight_panic_cb
Date: Thu, 11 Sep 2025 11:33:15 -0400
Message-Id: <20250911153315.3607119-1-sean.anderson@linux.dev>
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

Changes in v2:
- Add a comment describing csdev_lock/list
- Consolidate list removal in coresight_device_release

 drivers/hwtracing/coresight/coresight-core.c | 43 +++++++++++---------
 include/linux/coresight.h                    |  1 +
 2 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index fa758cc21827..4e28e56f2e30 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1042,10 +1042,19 @@ static void coresight_clear_default_sink(struct coresight_device *csdev)
 	}
 }
 
+/*
+ * Dedicated list of devices for use by during panic (which may occur with
+ * interrupts disabled).
+ */
+static DEFINE_SPINLOCK(csdev_lock);
+static LIST_HEAD(csdev_list);
+
 static void coresight_device_release(struct device *dev)
 {
 	struct coresight_device *csdev = to_coresight_device(dev);
 
+	scoped_guard(spinlock_irq, &csdev_lock)
+		list_del(&csdev->csdev_list);
 	fwnode_handle_put(csdev->dev.fwnode);
 	free_percpu(csdev->perf_sink_id_map.cpu_map);
 	kfree(csdev);
@@ -1357,6 +1366,10 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 			goto err_out;
 		}
 	}
+
+	scoped_guard(spinlock_irq, &csdev_lock)
+		list_add(&csdev->csdev_list, &csdev_list);
+
 	/*
 	 * Make sure the device registration and the connection fixup
 	 * are synchronised, so that we don't see uninitialised devices
@@ -1563,28 +1576,20 @@ const struct bus_type coresight_bustype = {
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


