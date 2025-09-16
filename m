Return-Path: <linux-kernel+bounces-819196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F4FB59CC2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D863B3828
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEBA233D9C;
	Tue, 16 Sep 2025 16:00:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CD0246799
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038433; cv=none; b=m0jMH5FXQRaD3YbwXF1eeGo6tRZcy0Buetnb6R3udFWy5NVwWZrL+NiMmzIeXGpnvVHA/WggzbGKYAZe/AaIk9h5fpozMN7wE5Sk15FMTZSJWb3HCmH3f3eDJT0ck3eeNkLYAGy8UWADbXfdYsCSGngIgGkqcoV3DvRToL6UrT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038433; c=relaxed/simple;
	bh=BhZJlhriJI5xtI2Vczs1gw2PZ2KiT+5OWGOxoOjcSgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXdM/hMkSABV/OgCdsoRzI5lCk4v3IwRxChVpRos4GqfhJM7hUe73ZCm6xvEwF7zQ9pUD2RDON5pH2i0Idzept54qDBo10KZ5FmdCQ0Z/6//AiThrPoP7W9/mjtwz7ddJzWk5q2q4zCMndsvPVMueg3n9QTPJgEyJDyNVIIFpB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7ABDE2F;
	Tue, 16 Sep 2025 09:00:21 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53B833F673;
	Tue, 16 Sep 2025 09:00:29 -0700 (PDT)
Date: Tue, 16 Sep 2025 17:00:27 +0100
From: Leo Yan <leo.yan@arm.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Linu Cherian <lcherian@marvell.com>, linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v3] coresight: Fix possible deadlock in coresight_panic_cb
Message-ID: <20250916160027.GK12516@e132581.arm.com>
References: <20250912151314.3761026-1-sean.anderson@linux.dev>
 <20250915095820.GH12516@e132581.arm.com>
 <3e618117-96bd-44f3-bede-7cadfe0264dd@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e618117-96bd-44f3-bede-7cadfe0264dd@linux.dev>

On Mon, Sep 15, 2025 at 10:31:24AM -0400, Sean Anderson wrote:
> On 9/15/25 05:58, Leo Yan wrote:
> > On Fri, Sep 12, 2025 at 11:13:14AM -0400, Sean Anderson wrote:
> >> coresight_panic_cb is called with interrupts disabled during panics.
> >> However, bus_for_each_dev calls bus_to_subsys which takes
> >> bus_kset->list_lock without disabling IRQs. This may cause a deadlock.
> > 
> > I would rephrase it to make it clearer for anyone reading it later:
> > 
> >   coresight_panic_cb() is called during panics, which can preempt a flow
> >   that triggers exceptions (such as data or instruction aborts).
> 
> I don't see what exceptions have to do with it. You can also panic
> during a regular interrupt.

The commit mentioned "without disabling IRQs" gives the impression that
the deadlock is caused by IRQ-unsafe locking, which might mislead into
thinking why the issue cannot be fixed with IRQ-safe locking.

Regardless of whether IRQs are disabled, and regardless of the context
(interrupt, bottom-half, or normal thread), the conditions for the
deadlock are only about:

  (a) The bus lock has been acquired;
  (b) A panic is triggered to try to acquire the same lock.

[...]

> > When I review this patch, I recognize we can consolidate panic notifier
> > in coresight-tmc-core.c, so we don't need to distribute the changes
> > into ETF and ETR drivers (sorry if I misled you in my previous reply).
> 
> And this kind of thing is why I went with the straightforward fix
> initially. I do not want to bikeshed the extent that this gets removed.
> IMO the whole "panic ops" stuff should be done directly with the panic
> notifier, hence this patch. If you do not agree with that, then ack v2
> and send a follow up of your own to fix it how you see fit.

I would fix it in one go.

I agree with you that "the whole panic ops stuff should be done directly
with the panic". The only difference between us is that I would keep the
`panic_ops` callback. To me, this encapsulates panic callbacks into
different modules, to make the code more general.

Could you check if the drafted patch below looks good to you? If so, I
will send out a formal patch.

---8<---

From ea78dd22cbdd97f709c5991d5bd3be97be6e137e Mon Sep 17 00:00:00 2001
From: Sean Anderson <sean.anderson@linux.dev>
Date: Tue, 16 Sep 2025 16:03:58 +0100
Subject: [PATCH] coresight: Fix possible deadlock in coresight_panic_cb()

coresight_panic_cb() is called during a panic. It invokes
bus_for_each_dev(), which then calls bus_to_subsys() and takes the
'bus_kset->list_lock'. If a panic occurs after the lock has been
acquired, it can lead to a deadlock.

Instead of using a common panic notifier to iterate the bus, this commit
directly registers the TMC device's panic notifier. This avoids bus
iteration and effectively eliminates the race condition that could cause
the deadlock.

Fixes: 46006ceb5d02 ("coresight: core: Add provision for panic callbacks")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-core.c  | 42 -------------------
 .../hwtracing/coresight/coresight-tmc-core.c  | 26 ++++++++++++
 drivers/hwtracing/coresight/coresight-tmc.h   |  2 +
 3 files changed, 28 insertions(+), 42 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 3267192f0c1c..cb0cc8d77056 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -21,7 +21,6 @@
 #include <linux/property.h>
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
-#include <linux/panic_notifier.h>
 
 #include "coresight-etm-perf.h"
 #include "coresight-priv.h"
@@ -1566,36 +1565,6 @@ const struct bus_type coresight_bustype = {
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
@@ -1608,20 +1577,11 @@ static int __init coresight_init(void)
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
@@ -1631,8 +1591,6 @@ static int __init coresight_init(void)
 static void __exit coresight_exit(void)
 {
 	cscfg_exit();
-	atomic_notifier_chain_unregister(&panic_notifier_list,
-					     &coresight_notifier);
 	etm_perf_exit();
 	bus_unregister(&coresight_bustype);
 }
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 36599c431be6..108ed9daf56d 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
 #include <linux/spinlock.h>
+#include <linux/panic_notifier.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -769,6 +770,21 @@ static void register_crash_dev_interface(struct tmc_drvdata *drvdata,
 			"Valid crash tracedata found\n");
 }
 
+static int tmc_panic_cb(struct notifier_block *nb, unsigned long v, void *p)
+{
+	struct tmc_drvdata *drvdata = container_of(nb, struct tmc_drvdata,
+						   panic_notifier);
+	struct coresight_device *csdev = drvdata->csdev;
+
+	if (coresight_get_mode(csdev) == CS_MODE_DISABLED)
+		return 0;
+
+	if (panic_ops(csdev))
+		panic_ops(csdev)->sync(csdev);
+
+	return 0;
+}
+
 static int __tmc_probe(struct device *dev, struct resource *res)
 {
 	int ret = 0;
@@ -885,6 +901,12 @@ static int __tmc_probe(struct device *dev, struct resource *res)
 		goto out;
 	}
 
+	if (panic_ops(drvdata->csdev)) {
+		drvdata->panic_notifier.notifier_call = tmc_panic_cb;
+		atomic_notifier_chain_register(&panic_notifier_list,
+					       &drvdata->panic_notifier);
+	}
+
 out:
 	if (is_tmc_crashdata_valid(drvdata) &&
 	    !tmc_prepare_crashdata(drvdata))
@@ -929,6 +951,10 @@ static void __tmc_remove(struct device *dev)
 {
 	struct tmc_drvdata *drvdata = dev_get_drvdata(dev);
 
+	if (panic_ops(drvdata->csdev))
+		atomic_notifier_chain_unregister(&panic_notifier_list,
+						 &drvdata->panic_notifier);
+
 	/*
 	 * Since misc_open() holds a refcount on the f_ops, which is
 	 * etb fops in this case, device is there until last file
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index cbb4ba439158..873c5427673c 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -243,6 +243,7 @@ struct tmc_resrv_buf {
  *		(after crash) by default.
  * @crash_mdata: Reserved memory for storing tmc crash metadata.
  *		 Used by ETR/ETF.
+ * @panic_notifier: Notifier used to clean up during a panic
  */
 struct tmc_drvdata {
 	struct clk		*atclk;
@@ -273,6 +274,7 @@ struct tmc_drvdata {
 	struct etr_buf		*perf_buf;
 	struct tmc_resrv_buf	resrv_buf;
 	struct tmc_resrv_buf	crash_mdata;
+	struct notifier_block	panic_notifier;
 };
 
 struct etr_buf_operations {
-- 
2.34.1


