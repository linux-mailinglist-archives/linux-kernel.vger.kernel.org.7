Return-Path: <linux-kernel+bounces-873407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEBCC13DCD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB8258525C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81557304BA8;
	Tue, 28 Oct 2025 09:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="prLKEUFS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE40E20010A;
	Tue, 28 Oct 2025 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761644091; cv=none; b=tGcbVCKhP5DKVYNL3LeCdYy4nz+mUpt9Ud4dcrv75riCtw3w8JKKf2d4G1ZX8vhDGzSwH5167K5yIf5+Yj0PjIzBgC9aJoqoWtQsYN0PRRaIC6lSXvCKPO62BWstap6mCGvEmNX6dIi8eaY86mtHIWGR4RY/KBCSUXEuVbNRSmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761644091; c=relaxed/simple;
	bh=L9lNgr55ANumsILgGWhwxvlIwl0om32wQMHzK7ZhExY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hBo4Ey2jnN+AicPRpH1oXD8AMr8k9QA8Ir5eH/n3uIFQxKIraErMnxKijoOhUqcBFhKgZRmcC0mv8lQQOw/KY01Z/VPENOVWJ7jogFFCow3v4I1JQDM7HxMsOTUJ6Wpv8p45RWpJijGAPL4sb/yY0Fgj6bP4zNj2CavD7YWZJ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=prLKEUFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBE6C4CEE7;
	Tue, 28 Oct 2025 09:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761644091;
	bh=L9lNgr55ANumsILgGWhwxvlIwl0om32wQMHzK7ZhExY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=prLKEUFSFgbsrhe2453Je3WCYbwObHMZ+9DQNfk+FdC3+6fJOT5wlC1Wc8jnHuI48
	 XP2wnBAkeIamnF3s1wDtwDXeidokFM+MclfWSUhX8QBR7zTaFJK2VttyO1LeMVKvzl
	 fzZ43L4OKaf+VWOH9cemGUsVUOXHpWYKY3HVGQZFGhvvRz+yIyNJj4rbcWvR86n6s+
	 UUR7G606qNzguNBCmCIL3+ct8+HhBN4VSQedlPfK9xz5dFZQXW5TeZgkdXVqrHshI0
	 MPHlBaamjcmEVBHVf2D4sFSSCzjTvS+MULSC/Vs07t0TYvlVW1ux4Q7C+xtJJ3vt3M
	 1ZVvkQZndpIug==
Message-ID: <37667f90-7333-4316-8858-8445f8f81409@kernel.org>
Date: Tue, 28 Oct 2025 10:34:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86: int3472: Fix double free of GPIO device
 during unregister
To: Qiu Wenbo <qiuwenbo@gnome.org>, Daniel Scally <djrscally@gmail.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251024050537.92440-1-qiuwenbo@gnome.org>
 <20251028063009.289414-1-qiuwenbo@gnome.org>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20251028063009.289414-1-qiuwenbo@gnome.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 28-Oct-25 7:30 AM, Qiu Wenbo wrote:
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
> Cc: stable@vger.kernel.org
> Fixes: 1e5d088a52c2 ("platform/x86: int3472: Stop using devm_gpiod_get()")
> Signed-off-by: Qiu Wenbo <qiuwenbo@kylinsec.com.cn>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hansg@kernel.org>

Regards,

Hans



> ---
> Changes since V1:
>  - Add Reviewed-by: from Andy Shevchenko and Sakari Ailus
>  - Add Cc to stable@
>  - Remove the blank line after Fixes:
> 
>  drivers/platform/x86/intel/int3472/clk_and_regulator.c | 5 +----
>  include/linux/platform_data/x86/int3472.h              | 1 -
>  2 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/int3472/clk_and_regulator.c b/drivers/platform/x86/intel/int3472/clk_and_regulator.c
> index 476ec24d37020..9e052b164a1ab 100644
> --- a/drivers/platform/x86/intel/int3472/clk_and_regulator.c
> +++ b/drivers/platform/x86/intel/int3472/clk_and_regulator.c
> @@ -245,15 +245,12 @@ int skl_int3472_register_regulator(struct int3472_discrete_device *int3472,
>  	if (IS_ERR(regulator->rdev))
>  		return PTR_ERR(regulator->rdev);
>  
> -	int3472->regulators[int3472->n_regulator_gpios].ena_gpio = gpio;
>  	int3472->n_regulator_gpios++;
>  	return 0;
>  }
>  
>  void skl_int3472_unregister_regulator(struct int3472_discrete_device *int3472)
>  {
> -	for (int i = 0; i < int3472->n_regulator_gpios; i++) {
> +	for (int i = 0; i < int3472->n_regulator_gpios; i++)
>  		regulator_unregister(int3472->regulators[i].rdev);
> -		gpiod_put(int3472->regulators[i].ena_gpio);
> -	}
>  }
> diff --git a/include/linux/platform_data/x86/int3472.h b/include/linux/platform_data/x86/int3472.h
> index 1571e9157fa50..b1b837583d544 100644
> --- a/include/linux/platform_data/x86/int3472.h
> +++ b/include/linux/platform_data/x86/int3472.h
> @@ -100,7 +100,6 @@ struct int3472_gpio_regulator {
>  	struct regulator_consumer_supply supply_map[GPIO_REGULATOR_SUPPLY_MAP_COUNT * 2];
>  	char supply_name_upper[GPIO_SUPPLY_NAME_LENGTH];
>  	char regulator_name[GPIO_REGULATOR_NAME_LENGTH];
> -	struct gpio_desc *ena_gpio;
>  	struct regulator_dev *rdev;
>  	struct regulator_desc rdesc;
>  };


