Return-Path: <linux-kernel+bounces-832710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B84ABA0241
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA943827AC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04362F6180;
	Thu, 25 Sep 2025 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JyqpvJj0"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCABD2E2665
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812651; cv=none; b=uW6KnwQE1TcjWuyn0yAlHbxC9sIPZMyoQjS1vSBIVktgWmQimmmF7itdPjDvBnHNrGURUDoN5pbf+NigGnBprKZbD/LHecJ0S8vhVamw+pDJLQoE//HQXuYdSusSmnhoebJtFsrngVAcyy4j6+ypr8tB6QbRMovJv5H0kXzUPZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812651; c=relaxed/simple;
	bh=3UPzGr2VB/rAfD5+8oPaVoN9X2KDA2+tATtdTBIfH+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SUeKHjtwduaNNxmKjpSy04Co9irWiLDoCHpUqmeR5xUdhJRqr+hz1X8LuDcbBMu9XV8wfu16V4bc9gQSCRuArJXCjZWT/BOI9WsrA7FguLIAoA6qvibUzl/JG2lFtLi/8rxJOnINTWCejnQrdVS/dWK6y4SL6ZqcdwPEyLVkcGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JyqpvJj0; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758812644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFsFtt/dYubWASJgvWs3g9b5WimRx2r0jDM0W9mimZ4=;
	b=JyqpvJj0isPclEJyeW7fLiPwKRipWqHOvgNoVwokn7yAbKMSE5TCY5PmT1etG8xI8ZCGSk
	RYaGfcnVN2eZsW4f7LlSsVQj5QpQSYhO0TAfEPPkUinvgfiB4SJskHiSCx4GhNjQ/IioWf
	PkNRCPYpEyuLxt1TcIj6/N83QfV+LfE=
From: Sean Anderson <sean.anderson@linux.dev>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Linu Cherian <lcherian@marvell.com>,
	Mike Leach <mike.leach@linaro.org>,
	linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v5 3/3] coresight: Fix possible deadlock in coresight_panic_cb
Date: Thu, 25 Sep 2025 11:03:42 -0400
Message-Id: <20250925150342.1845615-4-sean.anderson@linux.dev>
In-Reply-To: <20250925150342.1845615-1-sean.anderson@linux.dev>
References: <20250925150342.1845615-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Panics can occur at any time, so taking locks may cause a deadlock (such
as if the panicking CPU held the lock).  coresight_panic_cb uses
bus_for_each_dev, but that calls bus_to_subsys which takes
bus_kset->list_lock.

Instead of registering a single panic notifier and iterating over
coresight devices, register a panic notifier for each coresight device
that requires it (letting the atomic notifier list handle iteration).
atomic_notifier_chain_unregister will just return -ENOENT if a notifier
block isn't on the list, so it's safe to call when we haven't registered
a notifier.

Fixes: 46006ceb5d02 ("coresight: core: Add provision for panic callbacks")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v5:
- Check csdev mode before calling sync()

Changes in v4:
- Move the panic notifier into csdev and restore the panic sync API

Changes in v3:
- Rewrite patch to remove the panic sync API entirely

Changes in v2:
- Add a comment describing csdev_lock/list
- Consolidate list removal in coresight_device_release

 drivers/hwtracing/coresight/coresight-core.c | 67 ++++++++------------
 include/linux/coresight.h                    |  2 +
 2 files changed, 28 insertions(+), 41 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 305b1773cfbe..01303348fc0e 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1046,6 +1046,9 @@ static void coresight_device_release(struct device *dev)
 {
 	struct coresight_device *csdev = to_coresight_device(dev);
 
+	if (panic_ops(csdev))
+		atomic_notifier_chain_unregister(&panic_notifier_list,
+						 &csdev->panic_notifier);
 	free_percpu(csdev->perf_sink_id_map.cpu_map);
 	fwnode_handle_put(csdev->dev.fwnode);
 	kfree(csdev);
@@ -1315,6 +1318,18 @@ void coresight_release_platform_data(struct coresight_device *csdev,
 		coresight_remove_conns_sysfs_group(csdev);
 }
 
+static int coresight_panic_notifier(struct notifier_block *nb,
+				    unsigned long action, void *data)
+{
+	struct coresight_device *csdev =
+		container_of(nb, struct coresight_device, panic_notifier);
+	int mode = coresight_get_mode(csdev);
+
+	if (mode == CS_MODE_SYSFS || mode == CS_MODE_PERF)
+		panic_ops(csdev)->sync(csdev);
+	return NOTIFY_DONE;
+}
+
 struct coresight_device *coresight_register(struct coresight_desc *desc)
 {
 	int ret;
@@ -1357,6 +1372,17 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 			goto err_out;
 		}
 	}
+
+	if (panic_ops(csdev)) {
+		csdev->panic_notifier.notifier_call = coresight_panic_notifier;
+		ret = atomic_notifier_chain_register(&panic_notifier_list,
+						     &csdev->panic_notifier);
+		if (ret) {
+			coresight_device_release(&csdev->dev);
+			goto err_out;
+		}
+	}
+
 	/*
 	 * Make sure the device registration and the connection fixup
 	 * are synchronised, so that we don't see uninitialised devices
@@ -1563,36 +1589,6 @@ const struct bus_type coresight_bustype = {
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
-static int coresight_panic_cb(struct notifier_block *self,
-			       unsigned long v, void *p)
-{
-	bus_for_each_dev(&coresight_bustype, NULL, NULL,
-				 coresight_panic_sync);
-
-	return 0;
-}
-
-static struct notifier_block coresight_notifier = {
-	.notifier_call = coresight_panic_cb,
-};
-
 static int __init coresight_init(void)
 {
 	int ret;
@@ -1605,20 +1601,11 @@ static int __init coresight_init(void)
 	if (ret)
 		goto exit_bus_unregister;
 
-	/* Register function to be called for panic */
-	ret = atomic_notifier_chain_register(&panic_notifier_list,
-					     &coresight_notifier);
-	if (ret)
-		goto exit_perf;
-
 	/* initialise the coresight syscfg API */
 	ret = cscfg_init();
 	if (!ret)
 		return 0;
 
-	atomic_notifier_chain_unregister(&panic_notifier_list,
-					     &coresight_notifier);
-exit_perf:
 	etm_perf_exit();
 exit_bus_unregister:
 	bus_unregister(&coresight_bustype);
@@ -1628,8 +1615,6 @@ static int __init coresight_init(void)
 static void __exit coresight_exit(void)
 {
 	cscfg_exit();
-	atomic_notifier_chain_unregister(&panic_notifier_list,
-					     &coresight_notifier);
 	etm_perf_exit();
 	bus_unregister(&coresight_bustype);
 }
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 4ac65c68bbf4..a7aaf9d3d01d 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -280,6 +280,7 @@ struct coresight_trace_id_map {
  * @config_csdev_list:  List of system configurations added to the device.
  * @cscfg_csdev_lock:	Protect the lists of configurations and features.
  * @active_cscfg_ctxt:  Context information for current active system configuration.
+ * @panic_notifier: Notifier block used to clean up during a panic
  */
 struct coresight_device {
 	struct coresight_platform_data *pdata;
@@ -304,6 +305,7 @@ struct coresight_device {
 	struct list_head config_csdev_list;
 	raw_spinlock_t cscfg_csdev_lock;
 	void *active_cscfg_ctxt;
+	struct notifier_block panic_notifier;
 };
 
 /*
-- 
2.35.1.1320.gc452695387.dirty


