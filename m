Return-Path: <linux-kernel+bounces-814366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C70B55340
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45FF5B61F0D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83058310774;
	Fri, 12 Sep 2025 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JcwoWp/E"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023942264CD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690016; cv=none; b=rztQc3JoizA8wPH8Er9nd+yjWvjJC2LfhAP+dUjqocCiz/Ge62C8doqjtiR+ZVoEb4/sx1xIfBpiQd/4DkREDyVQRmiIVL+wV65nrN7N0gTijX7C8xM/PZIxDIYnJ/+uuNGSfHeTx0IyNEapU0e8IJLk5llpARQSBuAtd8RM2WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690016; c=relaxed/simple;
	bh=IxDLl3uE34pPM71SKuBCbGnHLLNKZNW1DHxkuu3h5PQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K+j5Rqgq9eP1ZvkBwIy8ub8lUTn2GCxy/TOpxYHAkR/ncI2957D8FMX5yHyWsA9ZZoN8K7JF22kvzuYrRe0dKUwMKMOtUj2ExBYQ77g8ut//ZPpKybxCK1YBkGuiHwjNJzLFPu9eRyDqkaC5gz6naB10cDmEnDc9/S5pbwfnXZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JcwoWp/E; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757690007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L6XGDr7h20As/O/9U2MCpFBO1J1PqKsbwcqGb04Zg5g=;
	b=JcwoWp/EdkPkmY5/BW9/DBSgB5MjBvrr3Zdrn+nBtNwTpRMhh5zAekm2PmguRKNXK55+O1
	djAHjuk4EmSsI8VazO8d85U6ReIjhiarj4uQptFv7sVBOxivQ9NkwRhYRKEHxGHNmW+Ypy
	eAgGX3F/1J7l4ioAKWhpneGTUC+r2ZE=
From: Sean Anderson <sean.anderson@linux.dev>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Cc: Yeoreum Yun <yeoreum.yun@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@arm.com>,
	Linu Cherian <lcherian@marvell.com>,
	linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v3] coresight: Fix possible deadlock in coresight_panic_cb
Date: Fri, 12 Sep 2025 11:13:14 -0400
Message-Id: <20250912151314.3761026-1-sean.anderson@linux.dev>
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
bus_kset->list_lock without disabling IRQs. This may cause a deadlock.

Instead of adding a panic API for coresight devices, just have coresight
drivers that need a panic callback register directly with the panic
notifier.

Fixes: 46006ceb5d02 ("coresight: core: Add provision for panic callbacks")
Fixes: 6dbcbcfc4496 ("coresight: tmc: Enable panic sync handling")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v3:
- Rewrite patch to remove the panic sync API entirely

Changes in v2:
- Add a comment describing csdev_lock/list
- Consolidate list removal in coresight_device_release

 drivers/hwtracing/coresight/coresight-core.c  | 42 -------------------
 .../hwtracing/coresight/coresight-tmc-core.c  | 20 ++++++++-
 .../hwtracing/coresight/coresight-tmc-etf.c   | 12 +++---
 .../hwtracing/coresight/coresight-tmc-etr.c   | 12 +++---
 drivers/hwtracing/coresight/coresight-tmc.h   | 10 ++++-
 include/linux/coresight.h                     | 11 +----
 6 files changed, 38 insertions(+), 69 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index fa758cc21827..297af270bf3d 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -19,7 +19,6 @@
 #include <linux/property.h>
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
-#include <linux/panic_notifier.h>
 
 #include "coresight-etm-perf.h"
 #include "coresight-priv.h"
@@ -1563,36 +1562,6 @@ const struct bus_type coresight_bustype = {
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
@@ -1605,20 +1574,11 @@ static int __init coresight_init(void)
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
@@ -1628,8 +1588,6 @@ static int __init coresight_init(void)
 static void __exit coresight_exit(void)
 {
 	cscfg_exit();
-	atomic_notifier_chain_unregister(&panic_notifier_list,
-					     &coresight_notifier);
 	etm_perf_exit();
 	bus_unregister(&coresight_bustype);
 }
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 88afb16bb6be..012f76dbf7d3 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -16,6 +16,7 @@
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
 #include <linux/mutex.h>
+#include <linux/panic_notifier.h>
 #include <linux/property.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
@@ -834,6 +835,7 @@ static int __tmc_probe(struct device *dev, struct resource *res)
 		desc.type = CORESIGHT_DEV_TYPE_SINK;
 		desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM;
 		desc.ops = &tmc_etr_cs_ops;
+		drvdata->panic_notifier.notifier_call = tmc_panic_sync_etr;
 		ret = tmc_etr_setup_caps(dev, devid, &desc.access);
 		if (ret)
 			goto out;
@@ -847,6 +849,7 @@ static int __tmc_probe(struct device *dev, struct resource *res)
 		desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
 		desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_FIFO;
 		desc.ops = &tmc_etf_cs_ops;
+		drvdata->panic_notifier.notifier_call = tmc_panic_sync_etf;
 		dev_list = &etf_devs;
 		break;
 	default:
@@ -869,11 +872,18 @@ static int __tmc_probe(struct device *dev, struct resource *res)
 	dev->platform_data = pdata;
 	desc.pdata = pdata;
 
+	if (drvdata->panic_notifier.notifier_call) {
+		ret = atomic_notifier_chain_register(&panic_notifier_list,
+						     &drvdata->panic_notifier);
+		if (ret)
+			goto out;
+	}
+
 	coresight_clear_self_claim_tag(&desc.access);
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev)) {
 		ret = PTR_ERR(drvdata->csdev);
-		goto out;
+		goto err;
 	}
 
 	drvdata->miscdev.name = desc.name;
@@ -882,7 +892,10 @@ static int __tmc_probe(struct device *dev, struct resource *res)
 	ret = misc_register(&drvdata->miscdev);
 	if (ret) {
 		coresight_unregister(drvdata->csdev);
-		goto out;
+err:
+		if (drvdata->panic_notifier.notifier_call)
+			atomic_notifier_chain_unregister(&panic_notifier_list,
+							 &drvdata->panic_notifier);
 	}
 
 out:
@@ -944,6 +957,9 @@ static void __tmc_remove(struct device *dev)
 	if (drvdata->crashdev.fops)
 		misc_deregister(&drvdata->crashdev);
 	coresight_unregister(drvdata->csdev);
+	if (drvdata->panic_notifier.notifier_call)
+		atomic_notifier_chain_unregister(&panic_notifier_list,
+						 &drvdata->panic_notifier);
 }
 
 static void tmc_remove(struct amba_device *adev)
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 0f45ab5e5249..9c8dfd5436ab 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -601,11 +601,14 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 	return to_read;
 }
 
-static int tmc_panic_sync_etf(struct coresight_device *csdev)
+int tmc_panic_sync_etf(struct notifier_block *nb, unsigned long action,
+		       void *data)
 {
 	u32 val;
 	struct tmc_crash_metadata *mdata;
-	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct tmc_drvdata *drvdata = container_of(nb, struct tmc_drvdata,
+						   panic_notifier);
+	struct coresight_device *csdev = drvdata->csdev;
 
 	mdata = (struct tmc_crash_metadata *)drvdata->crash_mdata.vaddr;
 
@@ -689,10 +692,6 @@ static const struct coresight_ops_link tmc_etf_link_ops = {
 	.disable	= tmc_disable_etf_link,
 };
 
-static const struct coresight_ops_panic tmc_etf_sync_ops = {
-	.sync		= tmc_panic_sync_etf,
-};
-
 const struct coresight_ops tmc_etb_cs_ops = {
 	.sink_ops	= &tmc_etf_sink_ops,
 };
@@ -700,7 +699,6 @@ const struct coresight_ops tmc_etb_cs_ops = {
 const struct coresight_ops tmc_etf_cs_ops = {
 	.sink_ops	= &tmc_etf_sink_ops,
 	.link_ops	= &tmc_etf_link_ops,
-	.panic_ops	= &tmc_etf_sync_ops,
 };
 
 int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index b07fcdb3fe1a..91061462cd92 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1824,11 +1824,14 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
 	return 0;
 }
 
-static int tmc_panic_sync_etr(struct coresight_device *csdev)
+int tmc_panic_sync_etr(struct notifier_block *nb, unsigned long action,
+		       void *data)
 {
 	u32 val;
 	struct tmc_crash_metadata *mdata;
-	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct tmc_drvdata *drvdata = container_of(nb, struct tmc_drvdata,
+						   panic_notifier);
+	struct coresight_device *csdev = drvdata->csdev;
 
 	mdata = (struct tmc_crash_metadata *)drvdata->crash_mdata.vaddr;
 
@@ -1900,13 +1903,8 @@ static const struct coresight_ops_sink tmc_etr_sink_ops = {
 	.free_buffer	= tmc_free_etr_buffer,
 };
 
-static const struct coresight_ops_panic tmc_etr_sync_ops = {
-	.sync		= tmc_panic_sync_etr,
-};
-
 const struct coresight_ops tmc_etr_cs_ops = {
 	.sink_ops	= &tmc_etr_sink_ops,
-	.panic_ops	= &tmc_etr_sync_ops,
 };
 
 int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 6541a27a018e..d8e6bf5526c6 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -242,6 +242,7 @@ struct tmc_resrv_buf {
  *		(after crash) by default.
  * @crash_mdata: Reserved memory for storing tmc crash metadata.
  *		 Used by ETR/ETF.
+ * @panic_notifier: Notifier block used to clean up during a panic
  */
 struct tmc_drvdata {
 	struct clk		*pclk;
@@ -271,6 +272,7 @@ struct tmc_drvdata {
 	struct etr_buf		*perf_buf;
 	struct tmc_resrv_buf	resrv_buf;
 	struct tmc_resrv_buf	crash_mdata;
+	struct notifier_block	panic_notifier;
 };
 
 struct etr_buf_operations {
@@ -322,18 +324,24 @@ void tmc_disable_hw(struct tmc_drvdata *drvdata);
 u32 tmc_get_memwidth_mask(struct tmc_drvdata *drvdata);
 int tmc_read_prepare_crashdata(struct tmc_drvdata *drvdata);
 
+struct notifier_block;
+
 /* ETB/ETF functions */
 int tmc_read_prepare_etb(struct tmc_drvdata *drvdata);
 int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata);
+int tmc_panic_sync_etf(struct notifier_block *nb, unsigned long action,
+		       void *data);
 extern const struct coresight_ops tmc_etb_cs_ops;
 extern const struct coresight_ops tmc_etf_cs_ops;
-
 ssize_t tmc_etb_get_sysfs_trace(struct tmc_drvdata *drvdata,
 				loff_t pos, size_t len, char **bufpp);
+
 /* ETR functions */
 int tmc_read_prepare_etr(struct tmc_drvdata *drvdata);
 int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata);
 void tmc_etr_disable_hw(struct tmc_drvdata *drvdata);
+int tmc_panic_sync_etr(struct notifier_block *nb, unsigned long action,
+		       void *data);
 extern const struct coresight_ops tmc_etr_cs_ops;
 ssize_t tmc_etr_get_sysfs_trace(struct tmc_drvdata *drvdata,
 				loff_t pos, size_t len, char **bufpp);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 4ac65c68bbf4..64e12ffd507b 100644
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
@@ -427,15 +428,6 @@ struct coresight_ops_helper {
 };
 
 
-/**
- * struct coresight_ops_panic - Generic device ops for panic handing
- *
- * @sync	: Sync the device register state/trace data
- */
-struct coresight_ops_panic {
-	int (*sync)(struct coresight_device *csdev);
-};
-
 struct coresight_ops {
 	int (*trace_id)(struct coresight_device *csdev, enum cs_mode mode,
 			struct coresight_device *sink);
@@ -443,7 +435,6 @@ struct coresight_ops {
 	const struct coresight_ops_link *link_ops;
 	const struct coresight_ops_source *source_ops;
 	const struct coresight_ops_helper *helper_ops;
-	const struct coresight_ops_panic *panic_ops;
 };
 
 static inline u32 csdev_access_relaxed_read32(struct csdev_access *csa,
-- 
2.35.1.1320.gc452695387.dirty


