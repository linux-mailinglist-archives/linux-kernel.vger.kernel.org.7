Return-Path: <linux-kernel+bounces-819279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F614B59DD7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7651D7AB534
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F05B31E89B;
	Tue, 16 Sep 2025 16:38:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4641231E897
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040725; cv=none; b=qnovGhbRFduJrmY9zSlLn/LbKbtb6o/WT50zHa5YTpJf4re4OCJONr2qMBG9Ftm+TXp0oDyVk4ED5EoIzyaI+od5HxXSWXlNcnJ2CPNEEtZ0ezAfPovF75laFNrlcNUTfrIPgY/3TmcrJWzMj8lpk7JvSCS8VeVzzYQqBTZxobI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040725; c=relaxed/simple;
	bh=PoTVvggiROfWNEJSThjnLv9ekjzvrfBZULelyEsQE1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qa3jhtNWg6f/r4wE5lKvv0VkkzbFixXp0pkK3XDf+mF9caJODWxG6wpNqaUWTjJ5suFO0VEmJKLs8c8mMUyj1rBICjpV6L/guP13y3SYLLWPoL2iitYqOcVZ4iICQxpAYs4fvBarozkXHMAMzG0E52bIX/OXBC/r2n5tCJXFv5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C8D41063;
	Tue, 16 Sep 2025 09:38:34 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14B4C3F673;
	Tue, 16 Sep 2025 09:38:41 -0700 (PDT)
Date: Tue, 16 Sep 2025 17:38:40 +0100
From: Leo Yan <leo.yan@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Sean Anderson <sean.anderson@linux.dev>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Linu Cherian <lcherian@marvell.com>, linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v3] coresight: Fix possible deadlock in coresight_panic_cb
Message-ID: <20250916163840.GL12516@e132581.arm.com>
References: <20250912151314.3761026-1-sean.anderson@linux.dev>
 <20250915095820.GH12516@e132581.arm.com>
 <3e618117-96bd-44f3-bede-7cadfe0264dd@linux.dev>
 <20250916160027.GK12516@e132581.arm.com>
 <6fbd24b2-3315-45e6-bff2-2c39e899e8f5@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fbd24b2-3315-45e6-bff2-2c39e899e8f5@arm.com>

On Tue, Sep 16, 2025 at 05:09:01PM +0100, Suzuki Kuruppassery Poulose wrote:

[...]

> >  From ea78dd22cbdd97f709c5991d5bd3be97be6e137e Mon Sep 17 00:00:00 2001
> > From: Sean Anderson <sean.anderson@linux.dev>
> > Date: Tue, 16 Sep 2025 16:03:58 +0100
> > Subject: [PATCH] coresight: Fix possible deadlock in coresight_panic_cb()
> > 
> > coresight_panic_cb() is called during a panic. It invokes
> > bus_for_each_dev(), which then calls bus_to_subsys() and takes the
> > 'bus_kset->list_lock'. If a panic occurs after the lock has been
> > acquired, it can lead to a deadlock.
> > 
> > Instead of using a common panic notifier to iterate the bus, this commit
> > directly registers the TMC device's panic notifier. This avoids bus
> > iteration and effectively eliminates the race condition that could cause
> > the deadlock.
> 
> Well, if you are going that far, why not register the notifier from
> coresight-core ?

I have thought this but gave up.

When register a panic's notifier, it does not provide an argument for
passing a private data. So the code below uses container_of() to convert
notifier block pointer to the TMC driver data, as a result, the code is
specific to TMC driver.

I searched the kernel but did not find a case for passing private data
for panic notifier (note, this should be only an issue for panic
notifier but not for common notifiers).

> We could always check the panic_ops->sync, and
> then register/unregister the callback. Add the notifer to the csdev.
> Otherwise, there is no point in keeping the panic_ops in
> coresight_device, it is just for the TMC device.

ETF and ETR devices both support panic, this is why I think keeping
`panic_ops` callbacks can benefit code consolidation in
coresight-tmc-core.c (you could see the difference between my proposed
change and Sean's v3 patch).

But it is fine for me to drop `panic_ops` in coresight_device. At
least, this is much better than adding lock and list in patch v2.

Thanks,
Leo

> > Fixes: 46006ceb5d02 ("coresight: core: Add provision for panic callbacks")
> > Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > ---
> >   drivers/hwtracing/coresight/coresight-core.c  | 42 -------------------
> >   .../hwtracing/coresight/coresight-tmc-core.c  | 26 ++++++++++++
> >   drivers/hwtracing/coresight/coresight-tmc.h   |  2 +
> >   3 files changed, 28 insertions(+), 42 deletions(-)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> > index 3267192f0c1c..cb0cc8d77056 100644
> > --- a/drivers/hwtracing/coresight/coresight-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-core.c
> > @@ -21,7 +21,6 @@
> >   #include <linux/property.h>
> >   #include <linux/delay.h>
> >   #include <linux/pm_runtime.h>
> > -#include <linux/panic_notifier.h>
> >   #include "coresight-etm-perf.h"
> >   #include "coresight-priv.h"
> > @@ -1566,36 +1565,6 @@ const struct bus_type coresight_bustype = {
> >   	.name	= "coresight",
> >   };
> > -static int coresight_panic_sync(struct device *dev, void *data)
> > -{
> > -	int mode;
> > -	struct coresight_device *csdev;
> > -
> > -	/* Run through panic sync handlers for all enabled devices */
> > -	csdev = container_of(dev, struct coresight_device, dev);
> > -	mode = coresight_get_mode(csdev);
> > -
> > -	if ((mode == CS_MODE_SYSFS) || (mode == CS_MODE_PERF)) {
> > -		if (panic_ops(csdev))
> > -			panic_ops(csdev)->sync(csdev);
> > -	}
> > -
> > -	return 0;
> > -}
> > -
> > -static int coresight_panic_cb(struct notifier_block *self,
> > -			       unsigned long v, void *p)
> > -{
> > -	bus_for_each_dev(&coresight_bustype, NULL, NULL,
> > -				 coresight_panic_sync);
> > -
> > -	return 0;
> > -}
> > -
> > -static struct notifier_block coresight_notifier = {
> > -	.notifier_call = coresight_panic_cb,
> > -};
> > -
> >   static int __init coresight_init(void)
> >   {
> >   	int ret;
> > @@ -1608,20 +1577,11 @@ static int __init coresight_init(void)
> >   	if (ret)
> >   		goto exit_bus_unregister;
> > -	/* Register function to be called for panic */
> > -	ret = atomic_notifier_chain_register(&panic_notifier_list,
> > -					     &coresight_notifier);
> > -	if (ret)
> > -		goto exit_perf;
> > -
> >   	/* initialise the coresight syscfg API */
> >   	ret = cscfg_init();
> >   	if (!ret)
> >   		return 0;
> > -	atomic_notifier_chain_unregister(&panic_notifier_list,
> > -					     &coresight_notifier);
> > -exit_perf:
> >   	etm_perf_exit();
> >   exit_bus_unregister:
> >   	bus_unregister(&coresight_bustype);
> > @@ -1631,8 +1591,6 @@ static int __init coresight_init(void)
> >   static void __exit coresight_exit(void)
> >   {
> >   	cscfg_exit();
> > -	atomic_notifier_chain_unregister(&panic_notifier_list,
> > -					     &coresight_notifier);
> >   	etm_perf_exit();
> >   	bus_unregister(&coresight_bustype);
> >   }
> > diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> > index 36599c431be6..108ed9daf56d 100644
> > --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> > @@ -21,6 +21,7 @@
> >   #include <linux/slab.h>
> >   #include <linux/dma-mapping.h>
> >   #include <linux/spinlock.h>
> > +#include <linux/panic_notifier.h>
> >   #include <linux/pm_runtime.h>
> >   #include <linux/of.h>
> >   #include <linux/of_address.h>
> > @@ -769,6 +770,21 @@ static void register_crash_dev_interface(struct tmc_drvdata *drvdata,
> >   			"Valid crash tracedata found\n");
> >   }
> > +static int tmc_panic_cb(struct notifier_block *nb, unsigned long v, void *p)
> > +{
> > +	struct tmc_drvdata *drvdata = container_of(nb, struct tmc_drvdata,
> > +						   panic_notifier);
> > +	struct coresight_device *csdev = drvdata->csdev;
> > +
> > +	if (coresight_get_mode(csdev) == CS_MODE_DISABLED)
> > +		return 0;
> > +
> > +	if (panic_ops(csdev))
> > +		panic_ops(csdev)->sync(csdev);
> > +
> > +	return 0;
> > +}
> > +
> >   static int __tmc_probe(struct device *dev, struct resource *res)
> >   {
> >   	int ret = 0;
> > @@ -885,6 +901,12 @@ static int __tmc_probe(struct device *dev, struct resource *res)
> >   		goto out;
> >   	}
> > +	if (panic_ops(drvdata->csdev)) {
> > +		drvdata->panic_notifier.notifier_call = tmc_panic_cb;
> > +		atomic_notifier_chain_register(&panic_notifier_list,
> > +					       &drvdata->panic_notifier);
> > +	}
> > +
> >   out:
> >   	if (is_tmc_crashdata_valid(drvdata) &&
> >   	    !tmc_prepare_crashdata(drvdata))
> > @@ -929,6 +951,10 @@ static void __tmc_remove(struct device *dev)
> >   {
> >   	struct tmc_drvdata *drvdata = dev_get_drvdata(dev);
> > +	if (panic_ops(drvdata->csdev))
> > +		atomic_notifier_chain_unregister(&panic_notifier_list,
> > +						 &drvdata->panic_notifier);
> > +
> >   	/*
> >   	 * Since misc_open() holds a refcount on the f_ops, which is
> >   	 * etb fops in this case, device is there until last file
> > diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> > index cbb4ba439158..873c5427673c 100644
> > --- a/drivers/hwtracing/coresight/coresight-tmc.h
> > +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> > @@ -243,6 +243,7 @@ struct tmc_resrv_buf {
> >    *		(after crash) by default.
> >    * @crash_mdata: Reserved memory for storing tmc crash metadata.
> >    *		 Used by ETR/ETF.
> > + * @panic_notifier: Notifier used to clean up during a panic
> >    */
> >   struct tmc_drvdata {
> >   	struct clk		*atclk;
> > @@ -273,6 +274,7 @@ struct tmc_drvdata {
> >   	struct etr_buf		*perf_buf;
> >   	struct tmc_resrv_buf	resrv_buf;
> >   	struct tmc_resrv_buf	crash_mdata;
> > +	struct notifier_block	panic_notifier;
> >   };
> >   struct etr_buf_operations {
> 

