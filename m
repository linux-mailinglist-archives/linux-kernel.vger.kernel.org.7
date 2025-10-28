Return-Path: <linux-kernel+bounces-873317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A298C13A73
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD0EB5E1D82
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAB02D7DD8;
	Tue, 28 Oct 2025 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="tdIrXFFz"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0042201278;
	Tue, 28 Oct 2025 08:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641716; cv=none; b=S7LWOAN4hcEZBIpEWh7w41RFg3G28X2g9kbfye3PapQaxB0WwU0goV5HxzYGNZogHqOvQxbWXe7yangwJ6T10Urhmo2Slo97wNOX8y/KY+7BtczLlI0ize2L5jcb4EVnnKyC8kMeYhBSbfvA+EDqbYEQpuAQ1aO3UY0O09A4ap8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641716; c=relaxed/simple;
	bh=bD4dr4LXgOZ9UVzUXqm+hbb9ze0hLHOpaVbch+nIL/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iltrVhI7pLGRc7wjEQPGS0lj9vVzWE2VMwnO3dr6lhKpkpWP3fjeNSl/LdRlVssRmLWH2toFQdh3/CgTF6KY1YL7IG93UnmO3Lj1C7Mmrbks9JJk51q4ccT2mOvDeR/DNT5SHcOi+20kUuNdOIpeVBSvSe55lAmKqOXu3ui545I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=tdIrXFFz; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.0.43] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id BE5A91AED;
	Tue, 28 Oct 2025 09:53:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761641603;
	bh=bD4dr4LXgOZ9UVzUXqm+hbb9ze0hLHOpaVbch+nIL/0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tdIrXFFzNt9XsTbNwqju1+RZcg2vtREq6q2F2Frb2/fvWF9f3hIecRsWLaMEqkfSD
	 KimCqFYPclwjwigvsipwSEqKO+nUKV8bnvaKM8LtlESPV1gctTpHd7IY/uESvLh6NZ
	 RBGhHbID74BASeCfiCLHECM0I+pMcIQ+vmKyN5rU=
Message-ID: <5007d7f0-76ff-41fd-a371-05922c97f8ef@ideasonboard.com>
Date: Tue, 28 Oct 2025 08:55:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: int3472: Fix double free of GPIO device
 during unregister
To: Qiu Wenbo <qiuwenbo@gnome.org>, Daniel Scally <djrscally@gmail.com>,
 Hans de Goede <hansg@kernel.org>
Cc: Qiu Wenbo <qiuwenbo@kylinsec.com.cn>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>
References: <20251024050537.92440-1-qiuwenbo@gnome.org>
Content-Language: en-US
From: Dan Scally <dan.scally@ideasonboard.com>
In-Reply-To: <20251024050537.92440-1-qiuwenbo@gnome.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Qiu

On 24/10/2025 06:05, Qiu Wenbo wrote:
> From: Qiu Wenbo <qiuwenbo@kylinsec.com.cn>
> 
> regulator_unregister() already frees the associated GPIO device. On
> ThinkPad X9 (Lunar Lake), this causes a double free issue that leads to
> random failures when other drivers (typically Intel THC) attempt to
> allocate interrupts. The root cause is that the reference count of the
> pinctrl_intel_platform module unexpectedly drops to zero when this
> driver defers its probe.
> 
> This behavior can also be reproduced by unloading the module directly.
> 
> Fix the issue by removing the redundant release of the GPIO device
> during regulator unregistration.
> 
> Fixes: 1e5d088a52c2 ("platform/x86: int3472: Stop using devm_gpiod_get()")
> 
> Signed-off-by: Qiu Wenbo <qiuwenbo@kylinsec.com.cn>
> ---

The change looks good to me, so:

Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>

However the Fixes tag I wonder about; devm_gpiod_get() will also result in a call to gpiod_put() 
when the module is unloaded; doesn't that mean that the same issue  will occur before that commit?

Thanks
Dan



>   drivers/platform/x86/intel/int3472/clk_and_regulator.c | 5 +----
>   include/linux/platform_data/x86/int3472.h              | 1 -
>   2 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/int3472/clk_and_regulator.c b/drivers/platform/x86/intel/int3472/clk_and_regulator.c
> index 476ec24d37020..9e052b164a1ab 100644
> --- a/drivers/platform/x86/intel/int3472/clk_and_regulator.c
> +++ b/drivers/platform/x86/intel/int3472/clk_and_regulator.c
> @@ -245,15 +245,12 @@ int skl_int3472_register_regulator(struct int3472_discrete_device *int3472,
>   	if (IS_ERR(regulator->rdev))
>   		return PTR_ERR(regulator->rdev);
>   
> -	int3472->regulators[int3472->n_regulator_gpios].ena_gpio = gpio;
>   	int3472->n_regulator_gpios++;
>   	return 0;
>   }
>   
>   void skl_int3472_unregister_regulator(struct int3472_discrete_device *int3472)
>   {
> -	for (int i = 0; i < int3472->n_regulator_gpios; i++) {
> +	for (int i = 0; i < int3472->n_regulator_gpios; i++)
>   		regulator_unregister(int3472->regulators[i].rdev);
> -		gpiod_put(int3472->regulators[i].ena_gpio);
> -	}
>   }
> diff --git a/include/linux/platform_data/x86/int3472.h b/include/linux/platform_data/x86/int3472.h
> index 1571e9157fa50..b1b837583d544 100644
> --- a/include/linux/platform_data/x86/int3472.h
> +++ b/include/linux/platform_data/x86/int3472.h
> @@ -100,7 +100,6 @@ struct int3472_gpio_regulator {
>   	struct regulator_consumer_supply supply_map[GPIO_REGULATOR_SUPPLY_MAP_COUNT * 2];
>   	char supply_name_upper[GPIO_SUPPLY_NAME_LENGTH];
>   	char regulator_name[GPIO_REGULATOR_NAME_LENGTH];
> -	struct gpio_desc *ena_gpio;
>   	struct regulator_dev *rdev;
>   	struct regulator_desc rdesc;
>   };




