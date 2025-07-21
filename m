Return-Path: <linux-kernel+bounces-739156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF96B0C27D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBB4E188524B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB9228C014;
	Mon, 21 Jul 2025 11:16:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404981AA7BF;
	Mon, 21 Jul 2025 11:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753096599; cv=none; b=o1r5v5CVxaNYzjwZUYa/WriMwGx9XdYhsD4ggZ7qDDsYYnDL3AOQ0rTPfkDk9eLYyu0pLBIajnuhCj1f0aOZKUDYkWml65X3n5pDKi5Nt/357ZdmwyQzw8/feT+vvjX4jePfysgDs0B9T3xklEX3IkPwlOhE32htz4M44tfYODE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753096599; c=relaxed/simple;
	bh=jwBWJXy3jOUAeTbsSjCB5jDT5lQ67rpEeSgG8J7sCrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pH8VAdcjeRxfYJxMfIunOAmrSPHdOfIgcM9LDfvaxzk3KJwGLbuKPQ4ug9C1497eBdgWHa1lFx+Wa5JreR3KvyHQDbmQWoCW+Liah/wJS2E70m2bakuxV9fnprhRZjj/meb+kezQXoquV6jrfuIF7ilTm33ty0ETW2NHcYLwTSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0D41153B;
	Mon, 21 Jul 2025 04:16:31 -0700 (PDT)
Received: from [10.163.95.2] (unknown [10.163.95.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE1F43F6A8;
	Mon, 21 Jul 2025 04:16:33 -0700 (PDT)
Message-ID: <6fecd7d0-a5a5-4973-94ce-c63a3dff6bc7@arm.com>
Date: Mon, 21 Jul 2025 16:46:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] coresight: Fix a NULL vs IS_ERR() bug in probe
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Yuanfang Zhang <quic_yuanfang@quicinc.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Leo Yan <leo.yan@arm.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <7bd9fae8-a15f-412a-8800-ce47acf0b5ce@sabinyo.mountain>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <7bd9fae8-a15f-412a-8800-ce47acf0b5ce@sabinyo.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 17/07/25 1:08 AM, Dan Carpenter wrote:
> The devm_ioremap_resource() function returns error pointers on error.
> It never returns NULL.  Update the error checking to match.
> 
> Fixes: 26e20622a8ae ("coresight: add coresight Trace Network On Chip driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-tnoc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tnoc.c b/drivers/hwtracing/coresight/coresight-tnoc.c
> index 0e4164707eea..d542df46ea39 100644
> --- a/drivers/hwtracing/coresight/coresight-tnoc.c
> +++ b/drivers/hwtracing/coresight/coresight-tnoc.c
> @@ -183,8 +183,8 @@ static int trace_noc_probe(struct amba_device *adev, const struct amba_id *id)
>  	dev_set_drvdata(dev, drvdata);
>  
>  	drvdata->base = devm_ioremap_resource(dev, &adev->res);
> -	if (!drvdata->base)
> -		return -ENOMEM;
> +	if (IS_ERR(drvdata->base))
> +		return PTR_ERR(drvdata->base);
>  
>  	spin_lock_init(&drvdata->spinlock);
>  

Do we still have more similar instances in coresight ?


