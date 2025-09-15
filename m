Return-Path: <linux-kernel+bounces-816558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C34B5755E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B132A3A66C4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E002F9999;
	Mon, 15 Sep 2025 09:58:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0890B2F618F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930305; cv=none; b=SUubTlG0zosK+l6gfLZ4Lhjl3knY4PZcK/0JZLcLVm2HoHk24oT5nFSrEoo0gABp8Jg+sd+qk+PLO3MvPDEVuFGa0snbyJ/Nw7bTKonEW/iihaX0kGVbKrsg0MuCqK63rjvQRL4SYC1lHAhxkNZsKBDEeDNCwjPFiWTX1gx3YVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930305; c=relaxed/simple;
	bh=5QMc7USzLftbOU+EvIpzRNHKSYkYUlj7wX1voej0pPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyHQF5KXzBbn5I+srm/UP4BFqNmC1T5QYxH3IXkYYE4qiQ61H+EBrDi8cJabKm6YEf4gmTAi4Py/4zQw3U56T/n6ns00zLwlOp5PfcQX9+wlU4kG31bW4nkqn7d8en1oWwbCOkqJum8zQQTBxgioXJqC9paDpABveG8hZapoTq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F41012FC;
	Mon, 15 Sep 2025 02:58:14 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 091543F66E;
	Mon, 15 Sep 2025 02:58:21 -0700 (PDT)
Date: Mon, 15 Sep 2025 10:58:20 +0100
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
Message-ID: <20250915095820.GH12516@e132581.arm.com>
References: <20250912151314.3761026-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912151314.3761026-1-sean.anderson@linux.dev>

On Fri, Sep 12, 2025 at 11:13:14AM -0400, Sean Anderson wrote:
> coresight_panic_cb is called with interrupts disabled during panics.
> However, bus_for_each_dev calls bus_to_subsys which takes
> bus_kset->list_lock without disabling IRQs. This may cause a deadlock.

I would rephrase it to make it clearer for anyone reading it later:

  coresight_panic_cb() is called during panics, which can preempt a flow
  that triggers exceptions (such as data or instruction aborts).
  However, bus_for_each_dev() calls bus_to_subsys(), which takes
  'bus_kset->list_lock'. If a panic occurs after the lock has been
  acquired, it will cause a deadlock.

> Instead of adding a panic API for coresight devices, just have coresight
> drivers that need a panic callback register directly with the panic
> notifier.
> 
> Fixes: 46006ceb5d02 ("coresight: core: Add provision for panic callbacks")
> Fixes: 6dbcbcfc4496 ("coresight: tmc: Enable panic sync handling")

Let us fix the bug caused by the commit 46006ceb5d02. OTOH, I think we
should not touch change introduced in the commit 6dbcbcfc4496.

Please see details below.

> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
> Changes in v3:
> - Rewrite patch to remove the panic sync API entirely
> 
> Changes in v2:
> - Add a comment describing csdev_lock/list
> - Consolidate list removal in coresight_device_release
> 
>  drivers/hwtracing/coresight/coresight-core.c  | 42 -------------------
>  .../hwtracing/coresight/coresight-tmc-core.c  | 20 ++++++++-
>  .../hwtracing/coresight/coresight-tmc-etf.c   | 12 +++---
>  .../hwtracing/coresight/coresight-tmc-etr.c   | 12 +++---
>  drivers/hwtracing/coresight/coresight-tmc.h   | 10 ++++-
>  include/linux/coresight.h                     | 11 +----
>  6 files changed, 38 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index fa758cc21827..297af270bf3d 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -19,7 +19,6 @@
>  #include <linux/property.h>
>  #include <linux/delay.h>
>  #include <linux/pm_runtime.h>
> -#include <linux/panic_notifier.h>
>  
>  #include "coresight-etm-perf.h"
>  #include "coresight-priv.h"
> @@ -1563,36 +1562,6 @@ const struct bus_type coresight_bustype = {
>  	.name	= "coresight",
>  };
>  
> -static int coresight_panic_sync(struct device *dev, void *data)
> -{
> -	int mode;
> -	struct coresight_device *csdev;
> -
> -	/* Run through panic sync handlers for all enabled devices */
> -	csdev = container_of(dev, struct coresight_device, dev);
> -	mode = coresight_get_mode(csdev);
> -
> -	if ((mode == CS_MODE_SYSFS) || (mode == CS_MODE_PERF)) {
> -		if (panic_ops(csdev))
> -			panic_ops(csdev)->sync(csdev);
> -	}
> -
> -	return 0;
> -}
> -
> -static int coresight_panic_cb(struct notifier_block *self,
> -			       unsigned long v, void *p)
> -{
> -	bus_for_each_dev(&coresight_bustype, NULL, NULL,
> -				 coresight_panic_sync);
> -
> -	return 0;
> -}
> -
> -static struct notifier_block coresight_notifier = {
> -	.notifier_call = coresight_panic_cb,
> -};
> -
>  static int __init coresight_init(void)
>  {
>  	int ret;
> @@ -1605,20 +1574,11 @@ static int __init coresight_init(void)
>  	if (ret)
>  		goto exit_bus_unregister;
>  
> -	/* Register function to be called for panic */
> -	ret = atomic_notifier_chain_register(&panic_notifier_list,
> -					     &coresight_notifier);
> -	if (ret)
> -		goto exit_perf;
> -
>  	/* initialise the coresight syscfg API */
>  	ret = cscfg_init();
>  	if (!ret)
>  		return 0;
>  
> -	atomic_notifier_chain_unregister(&panic_notifier_list,
> -					     &coresight_notifier);
> -exit_perf:
>  	etm_perf_exit();
>  exit_bus_unregister:
>  	bus_unregister(&coresight_bustype);
> @@ -1628,8 +1588,6 @@ static int __init coresight_init(void)
>  static void __exit coresight_exit(void)
>  {
>  	cscfg_exit();
> -	atomic_notifier_chain_unregister(&panic_notifier_list,
> -					     &coresight_notifier);
>  	etm_perf_exit();
>  	bus_unregister(&coresight_bustype);
>  }

Removing panic notifier in coresight-core.c looks good to me.

> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> index 88afb16bb6be..012f76dbf7d3 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> @@ -16,6 +16,7 @@
>  #include <linux/fs.h>
>  #include <linux/miscdevice.h>
>  #include <linux/mutex.h>
> +#include <linux/panic_notifier.h>
>  #include <linux/property.h>
>  #include <linux/uaccess.h>
>  #include <linux/slab.h>
> @@ -834,6 +835,7 @@ static int __tmc_probe(struct device *dev, struct resource *res)
>  		desc.type = CORESIGHT_DEV_TYPE_SINK;
>  		desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM;
>  		desc.ops = &tmc_etr_cs_ops;
> +		drvdata->panic_notifier.notifier_call = tmc_panic_sync_etr;
>  		ret = tmc_etr_setup_caps(dev, devid, &desc.access);
>  		if (ret)
>  			goto out;
> @@ -847,6 +849,7 @@ static int __tmc_probe(struct device *dev, struct resource *res)
>  		desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
>  		desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_FIFO;
>  		desc.ops = &tmc_etf_cs_ops;
> +		drvdata->panic_notifier.notifier_call = tmc_panic_sync_etf;
>  		dev_list = &etf_devs;
>  		break;
>  	default:
> @@ -869,11 +872,18 @@ static int __tmc_probe(struct device *dev, struct resource *res)
>  	dev->platform_data = pdata;
>  	desc.pdata = pdata;
>  
> +	if (drvdata->panic_notifier.notifier_call) {
> +		ret = atomic_notifier_chain_register(&panic_notifier_list,
> +						     &drvdata->panic_notifier);
> +		if (ret)
> +			goto out;
> +	}

When I review this patch, I recognize we can consolidate panic notifier
in coresight-tmc-core.c, so we don't need to distribute the changes
into ETF and ETR drivers (sorry if I misled you in my previous reply).

How about we change like below? We still can keep the panic_ops
callback, and then register a common callback tmc_panic_cb(), which
still checks device state and invoke device's sync callback.

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index bd783c9dcb56..f7c175b3ae4c 100644
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
@@ -769,6 +770,22 @@ static void register_crash_dev_interface(struct tmc_drvdata *drvdata,
 			"Valid crash tracedata found\n");
 }
 
+static int tmc_panic_cb(struct notifier_block *nb, unsigned long v, void *p)
+{
+	struct tmc_drvdata *drvdata = container_of(nb, struct tmc_drvdata,
+						   panic_notifier);
+	struct coresight_device *csdev = drvdata->csdev;
+	int mode = coresight_get_mode(csdev);
+
+	if (mode == CS_MODE_DISABLED)
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
@@ -886,6 +903,12 @@ static int __tmc_probe(struct device *dev, struct resource *res)
 		goto out;
 	}
 
+        if (panic_ops(drvdata->csdev)) {
+		drvdata->panic_notifier.notifier_call = tmc_panic_cb;
+		atomic_notifier_chain_register(&panic_notifier_list,
+					       &drvdata->panic_notifier);
+	}
+
 out:
 	if (is_tmc_crashdata_valid(drvdata) &&
 	    !tmc_prepare_crashdata(drvdata))
@@ -930,6 +953,10 @@ static void __tmc_remove(struct device *dev)
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

