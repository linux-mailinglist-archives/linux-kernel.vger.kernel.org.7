Return-Path: <linux-kernel+bounces-827026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4FDB8FEB5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED91D422D51
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575D82FDC44;
	Mon, 22 Sep 2025 10:06:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FC01CAA92
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535619; cv=none; b=FLLxOVzOSnL/NIE4PyFxLY7NLkMPYBYiYLQ2xVQKuhQq7YZQ3GNKDySuv2M3VCUQh+QwngoSrJjtv6uaUSvBxU/x3MAYHY9f0siSNAQm9Kfkd+SVM24LSNgOIR/yGMwklHgMKQ+vWMs1LqP3G687Z93DSDBKtxKwdQMYnBJxVAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535619; c=relaxed/simple;
	bh=LgMMQgwUTwmnvWOlcbeZFBKWAokQKCrWBDrPiMOMYh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkLa3nvN06TagLeb4Q7YlTopMnCWBtfrxPNMAR8H1WiwL9Zi/WJRaIPPJBq2hiOBYMp38cjh1rR2/88TWUUxWYSAsxwrMYhU3QOdOt2dV695JRtmU9p0VwW7EfOiOgOM0QarX4TsdYKPxfrkwD89+v3fOOt3TZYvF9u4+iK1yJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F063B14BF;
	Mon, 22 Sep 2025 03:06:47 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEAB23F66E;
	Mon, 22 Sep 2025 03:06:55 -0700 (PDT)
Date: Mon, 22 Sep 2025 11:06:53 +0100
From: Leo Yan <leo.yan@arm.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Linu Cherian <lcherian@marvell.com>,
	Mike Leach <mike.leach@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] coresight: Fix fwnode leak in coresight_register
 error path
Message-ID: <20250922100653.GE516577@e132581.arm.com>
References: <20250919160653.507109-1-sean.anderson@linux.dev>
 <20250919160653.507109-2-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919160653.507109-2-sean.anderson@linux.dev>

On Fri, Sep 19, 2025 at 12:06:52PM -0400, Sean Anderson wrote:
> If registering the CPU map fails, we need to put the fwnode. free_percpu
> works when called with a NULL pointer, so just use
> coresight_device_release.
> 
> Fixes: 5ad628a76176 ("coresight: Use per-sink trace ID maps for Perf sessions")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

I have a patch that fixes the same issue:

https://lore.kernel.org/linux-arm-kernel/20250512154108.23920-2-leo.yan@arm.com/

The difference in my patch is about the sequence: first it allocates the
resource, then increases the fw node's reference count. During release,
it first decreases the reference count, and then safely releases the
resource.

After comparing your patch, I still think the above reason is valid.

That said, I agree we should put this fixing before the panic notifier
fix. This would be friendly for backporting.

Thanks,
Leo

> ---
> 
> Changes in v4:
> - New
> 
>  drivers/hwtracing/coresight/coresight-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index fa758cc21827..022c8384b98d 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1352,7 +1352,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>  		raw_spin_lock_init(&csdev->perf_sink_id_map.lock);
>  		csdev->perf_sink_id_map.cpu_map = alloc_percpu(atomic_t);
>  		if (!csdev->perf_sink_id_map.cpu_map) {
> -			kfree(csdev);
> +			coresight_device_release(&csdev->dev);
>  			ret = -ENOMEM;
>  			goto err_out;
>  		}
> -- 
> 2.35.1.1320.gc452695387.dirty
> 

