Return-Path: <linux-kernel+bounces-658059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70108ABFC36
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 19:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E98C1BC78B6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 17:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70913283120;
	Wed, 21 May 2025 17:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CaeEL8MM"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824CE22DF92
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747848305; cv=none; b=Oi5Tux1ChGGquWOQSCj7ulGV/b6qkv3OqzMT8IhgF/k1M6UozExVs6UtDXR1P6NKIR0K8IEnG80lxDDuDQUr35yILlKlT/ogxyqTvtB5mgyVkRdvd3G1VR9KpwcT/ooizPQTZH7Ui+wQPLlEJYYFr1qewk5fMlBUuX6nN4bLfLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747848305; c=relaxed/simple;
	bh=ri7jv3SFyemBIP70ZzDMrsll2ldSdL6G9aqQ6nx88bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OX8I+LTk5IgZuxSP6ZIxzaXTbeS4S1akPNZUtj72MTMAqd9sXt/5uinrg6QeK/9ixZA71+Z/ih1SP+R1G4PrQcu8RPeCxAcdzMnkxvVszY+ubVlI5WeQly1KjsExxPLQYRjFDc/++j81vZUoN6EXuNQ6EVufOt0t35B8wyGx5Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CaeEL8MM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-442f4a3a4d6so45972505e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 10:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747848302; x=1748453102; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QQIoOwFVzAyIQl84tG3BZfFLX9/CoM/ZjsK30GrWEu8=;
        b=CaeEL8MMRWOQQT+KWMZqHpH3G3gd17IJZJ93PJ1QQNyW7+Se5G90K84F6bjX/GLxLm
         YJoxCW9BBzFYRhJGnI6yA4LSA4tBb7RvK9x9zOBHf8aZfeMd2Pc8wvYL7q7sXmHE8id2
         hox5ja4KwdLsJYU6bWD4aKZbneLbMZsBdoFJqRU18RNcfyas0WZUc8JlyzBdw0H+nlUS
         Y7fsEf4gHTZMbt0NZGfuYmye3vKqFi/ZWGxxXHn4KvUWCVvJnp8s94AazV9+OAt75jtn
         oEQfVXNeT0Symcfvknnix7Vv4nrHIC3Aif+JUjdrCsCf5s2GxdMW/dsAWZ1hYfhtaXxd
         +Ndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747848302; x=1748453102;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QQIoOwFVzAyIQl84tG3BZfFLX9/CoM/ZjsK30GrWEu8=;
        b=KyD4sBjarIUWve8ktuNfuxiFH6JybGHo/Tv5/moJOeNcdiWgY1iNbtkA42/kn3PfzS
         Ua5MJcUcmKsPxizR3nnZFzoVuBpl6qyb+rhlI048POe1WLFNE6eeXt1bc1uaVEl37DRu
         RLxngHL8+fsWsEJysTREcw+HUk6RduPv/ajOSZCEymFR/MZOUfB2zVxq8690f/LimAcR
         OVp4MnMs1N+Q9p92FxZbzEAf8d0LYfLQ9qQWKLZg96ZlbK1j1tX633h1bk+HLhxeEo/c
         u8fcofAvdPqcZevI6YoKBuE8FoDAxjjcx3/g9OdqJr12iEM+fPRiZe2deOhgOHjHDh2q
         3YMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA4LJQXgN2raqIvIVBv+VO5UufEoVp0MmF2yv+EhFd2Jyzk222y55ZiP/K+TcNOgF68kjmu4wt2LRr8xY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3OBbZoFapXm+vOWfkm47R1aiTTi4HLPEVWg28PIPCPUO23eEI
	yU/UaY8ajS1Kc8rnvUdBtFtl2K/YK3QlUWnmvyXOGYRHBDk2un+sK3SDCnar+YoYMbM=
X-Gm-Gg: ASbGncuosGj6ynUwiNWAf8UoKGdSATffLmpuenQF9qHyXwLEN8ilNKc3PS9qSpqpr+N
	8WvpzRmcAgCDB7kDyFmSqZH744bT4qbe0vdIahwSn/2utip91W1NoVThFKg7XLT6ahEfO7TVFwu
	0dw6artPDdRKkMF20oCuPRhKj25A0ZonbhPyxXADiboJllxltmvD44qZFZNYoV1SpkjVHWbIk/S
	U9aUJQ72wVwI2Tem/rKslFdxrLx2dWDDEbpFjxsa6jTAl2VzUXUF+ClzhVa193NDqFYzVo1hMOc
	sboOdfefIi0bS8RpHg6IV8FiPXwK6HmCV0wbMsYx4iDg5+9VT0KaH1n89kU/oNP8gWWnqGWiQy6
	pKLidbpFtTnxN7n+H809YSKKe
X-Google-Smtp-Source: AGHT+IHI4AxUxw+mdSEmbv3bxgCkVYGSjBYcBB0DvjMGh+B3X3aUNDr0IHkVD7jkRU6tYB30LfZlag==
X-Received: by 2002:a05:600c:a40a:b0:43b:c592:7e16 with SMTP id 5b1f17b1804b1-442f84c2092mr230085065e9.3.1747848301738;
        Wed, 21 May 2025 10:25:01 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f73d25b8sm79414855e9.17.2025.05.21.10.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 10:25:01 -0700 (PDT)
Date: Wed, 21 May 2025 19:24:59 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v5 3/4] clocksource/drivers/timer-vt8500: Prepare for
 watchdog functionality
Message-ID: <aC4Ma3E461XMBig0@mai.linaro.org>
References: <20250521-vt8500-timer-updates-v5-0-7e4bd11df72e@gmail.com>
 <20250521-vt8500-timer-updates-v5-3-7e4bd11df72e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250521-vt8500-timer-updates-v5-3-7e4bd11df72e@gmail.com>

On Wed, May 21, 2025 at 05:00:11PM +0400, Alexey Charkov wrote:
> VIA/WonderMedia system timer can generate a watchdog reset when its
> clocksource counter matches the value in the match register 0 and
> watchdog function is enabled. For this to work, obvously the clock event
> device must use a different match register (1~3) and respective interrupt.
> 
> Check if at least two interrupts are provided by the device tree, then use
> match register 1 for system clock events and reserve match register 0 for
> the watchdog. Instantiate an auxiliary device for the watchdog
> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
>  MAINTAINERS                        |   1 +
>  drivers/clocksource/Kconfig        |   1 +
>  drivers/clocksource/timer-vt8500.c | 111 ++++++++++++++++++++++++++++++++++---
>  include/linux/vt8500-timer.h       |  18 ++++++

It should endup in include/clocksource/vt8500-timer.h

>  4 files changed, 122 insertions(+), 9 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 783e5ee6854b69cca87b6f0763844d28b4b2213f..5362095240627f613638197fda275db6edc16cf7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3447,6 +3447,7 @@ F:	drivers/tty/serial/vt8500_serial.c
>  F:	drivers/video/fbdev/vt8500lcdfb.*
>  F:	drivers/video/fbdev/wm8505fb*
>  F:	drivers/video/fbdev/wmt_ge_rops.*
> +F:	include/linux/vt8500-timer.h
>  
>  ARM/ZYNQ ARCHITECTURE
>  M:	Michal Simek <michal.simek@amd.com>
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 487c8525996724fbf9c6e9726dabb478d86513b9..92f071aade10b7c0f0bba4b47dc6228a5e50360f 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -178,6 +178,7 @@ config TEGRA186_TIMER
>  config VT8500_TIMER
>  	bool "VT8500 timer driver" if COMPILE_TEST
>  	depends on HAS_IOMEM
> +	select AUXILIARY_BUS
>  	help
>  	  Enables support for the VT8500 driver.
>  
> diff --git a/drivers/clocksource/timer-vt8500.c b/drivers/clocksource/timer-vt8500.c
> index 9f28f30dcaf83ab4e9c89952175b0d4c75bd6b40..cdea5245f8e41d65b8b9bebad3fe3a55f43a18fa 100644
> --- a/drivers/clocksource/timer-vt8500.c
> +++ b/drivers/clocksource/timer-vt8500.c
> @@ -11,6 +11,7 @@
>   * Alexey Charkov. Minor changes have been made for Device Tree Support.
>   */
>  
> +#include <linux/auxiliary_bus.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
>  #include <linux/interrupt.h>
> @@ -22,9 +23,6 @@
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  
> -#define VT8500_TIMER_OFFSET	0x0100
> -#define VT8500_TIMER_HZ		3000000
> -
>  #define TIMER_MATCH_REG(x)	(4 * (x))
>  #define TIMER_COUNT_REG		0x0010	 /* clocksource counter */
>  
> @@ -53,8 +51,14 @@
>  #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
>  
>  #define MIN_OSCR_DELTA		16
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/vt8500-timer.h>
>  
>  static void __iomem *regbase;
> +static unsigned int sys_timer_ch;	 /* which match register to use
> +					  * for the system timer
> +					  */

The comment format is a bit odd. It would be nicer on top of the
variable.

/*
 * Which match register to use for the system timer
 */

>  static u64 vt8500_timer_read(struct clocksource *cs)
>  {
> @@ -75,21 +79,26 @@ static struct clocksource clocksource = {
>  	.flags          = CLOCK_SOURCE_IS_CONTINUOUS,
>  };
>  
> +static u64 vt8500_timer_next(u64 cycles)
> +{
> +	return clocksource.read(&clocksource) + cycles;
> +}
> +
>  static int vt8500_timer_set_next_event(unsigned long cycles,
>  				    struct clock_event_device *evt)
>  {
>  	int loops = msecs_to_loops(10);
> -	u64 alarm = clocksource.read(&clocksource) + cycles;
> +	u64 alarm = vt8500_timer_next(cycles);
>  
> -	while (readl(regbase + TIMER_ACC_STS_REG) & TIMER_ACC_WR_MATCH(0)
> +	while (readl(regbase + TIMER_ACC_STS_REG) & TIMER_ACC_WR_MATCH(sys_timer_ch)
>  	       && --loops)
>  		cpu_relax();
> -	writel((unsigned long)alarm, regbase + TIMER_MATCH_REG(0));
> +	writel((unsigned long)alarm, regbase + TIMER_MATCH_REG(sys_timer_ch));
>  
>  	if ((signed)(alarm - clocksource.read(&clocksource)) <= MIN_OSCR_DELTA)
>  		return -ETIME;
>  
> -	writel(TIMER_INT_EN_MATCH(0), regbase + TIMER_INT_EN_REG);
> +	writel(TIMER_INT_EN_MATCH(sys_timer_ch), regbase + TIMER_INT_EN_REG);
>  
>  	return 0;
>  }
> @@ -131,7 +140,9 @@ static int __init vt8500_timer_init(struct device_node *np)
>  		return -ENXIO;
>  	}
>  
> -	timer_irq = irq_of_parse_and_map(np, 0);

It may be worth to repeat part of what is said in the changelog

> +	sys_timer_ch = of_irq_count(np) > 1 ? 1 : 0;
> +
> +	timer_irq = irq_of_parse_and_map(np, sys_timer_ch);
>  	if (!timer_irq) {
>  		pr_err("%s: Missing irq description in Device Tree\n",
>  								__func__);
> @@ -140,7 +151,7 @@ static int __init vt8500_timer_init(struct device_node *np)
>  
>  	writel(TIMER_CTRL_ENABLE, regbase + TIMER_CTRL_REG);
>  	writel(TIMER_STATUS_CLEARALL, regbase + TIMER_STATUS_REG);
> -	writel(~0, regbase + TIMER_MATCH_REG(0));
> +	writel(~0, regbase + TIMER_MATCH_REG(sys_timer_ch));
>  
>  	ret = clocksource_register_hz(&clocksource, VT8500_TIMER_HZ);
>  	if (ret) {
> @@ -166,4 +177,86 @@ static int __init vt8500_timer_init(struct device_node *np)
>  	return 0;
>  }
>  
> +static void vt8500_timer_aux_uninit(void *data)
> +{
> +	auxiliary_device_uninit(data);
> +}
> +
> +static void vt8500_timer_aux_delete(void *data)
> +{
> +	auxiliary_device_delete(data);
> +}
> +
> +static void vt8500_timer_aux_release(struct device *dev)
> +{
> +	struct auxiliary_device *aux;
> +
> +	aux = container_of(dev, struct auxiliary_device, dev);
> +	kfree(aux);

That will result in a double kfree because the data belongs to the
wdt_info structure. It is not a pointer allocated. So when the
wdt_info will be freed, it will free the area already freed by this
function.

Please note, a timer should never be unloaded, so not sure if the wdt
should handle the case.

> +}
> +
> +/*
> + * This probe gets called after the timer is already up and running. This will
> + * create the watchdog device as a child since the registers are shared.
> + */
> +static int vt8500_timer_probe(struct platform_device *pdev)
> +{
> +	struct vt8500_wdt_info *wdt_info;
> +	struct device *dev = &pdev->dev;
> +	int ret;

>>>>>

> +	if (!sys_timer_ch) {
> +		dev_info(dev, "Not enabling watchdog: only one irq was given");
> +		return 0;
> +	}
> +
> +	if (!regbase)
> +		return dev_err_probe(dev, -ENOMEM,
> +			"Timer not initialized, cannot create watchdog");

The block above seems to be a bit wobbly as it relies on
vt8500_timer_init() to have succeeded.

Why not have vt8500_timer_probe() called by vt8500_timer_init() (with
a proper name like vt8500_timer_wdt_init()) ?

<<<<<

> +	wdt_info = kzalloc(sizeof(*wdt_info), GFP_KERNEL);

devm_kzalloc()

> +	if (!wdt_info)
> +		return dev_err_probe(dev, -ENOMEM,
> +			"Failed to allocate vt8500-wdt info");

Is it possible kzalloc to return -EPROBE_DEFER ?

> +
> +	wdt_info->timer_next = &vt8500_timer_next;
> +	wdt_info->wdt_en = regbase + TIMER_WATCHDOG_EN_REG;
> +	wdt_info->wdt_match = regbase + TIMER_MATCH_REG(0);

The two fields above can be merged into one : wdt_info->regbase

Move TIMER_WATCHDOG_EN_REG to the watchdog driver code.

And as TIMER_MATCH_REG(__channel) == 4 * (__channel),
then TIMER_MATCH_REG == 0, so regbase + 0 == regbase

> +	wdt_info->auxdev.name = "vt8500-wdt";
> +	wdt_info->auxdev.dev.parent = dev;
> +	wdt_info->auxdev.dev.release = &vt8500_timer_aux_release;
> +
> +	ret = auxiliary_device_init(&wdt_info->auxdev);
> +	if (ret) {
> +		kfree(wdt_info);

Remove kfree because of devm_kzalloc

> +		return ret;
> +	}

nit: add line

> +	ret = devm_add_action_or_reset(dev, vt8500_timer_aux_uninit,
> +				       &wdt_info->auxdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = auxiliary_device_add(&wdt_info->auxdev);
> +	if (ret)
> +		return ret;

nit: add line

> +	return devm_add_action_or_reset(dev, vt8500_timer_aux_delete,
> +					&wdt_info->auxdev);
> +}
> +
> +static const struct of_device_id vt8500_timer_of_match[] = {
> +	{ .compatible = "via,vt8500-timer", },
> +	{},
> +};
> +
> +static struct platform_driver vt8500_timer_driver = {
> +	.probe  = vt8500_timer_probe,
> +	.driver = {
> +		.name = "vt8500-timer",
> +		.of_match_table = vt8500_timer_of_match,
> +		.suppress_bind_attrs = true,
> +	},
> +};
> +
> +builtin_platform_driver(vt8500_timer_driver);
>
>
>  TIMER_OF_DECLARE(vt8500, "via,vt8500-timer", vt8500_timer_init);
> diff --git a/include/linux/vt8500-timer.h b/include/linux/vt8500-timer.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..b8e9000495c509e9c8e8f4098d6bd33de27b3ec4
> --- /dev/null
> +++ b/include/linux/vt8500-timer.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef LINUX_VT8500_TIMER_H_
> +#define LINUX_VT8500_TIMER_H_
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/io.h>
> +#include <linux/types.h>
> +
> +#define VT8500_TIMER_HZ		3000000
> +
> +struct vt8500_wdt_info {
> +	struct auxiliary_device auxdev;
> +	u64 (*timer_next)(u64 cycles);
> +	void __iomem *wdt_en;
> +	void __iomem *wdt_match;
> +};
> +
> +#endif /* LINUX_VT8500_TIMER_H_ */
> 
> -- 
> 2.49.0
> 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

