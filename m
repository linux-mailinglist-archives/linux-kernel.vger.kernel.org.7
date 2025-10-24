Return-Path: <linux-kernel+bounces-869147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 048A3C071AF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5E061885A7E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562B232B99B;
	Fri, 24 Oct 2025 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vRNGdf0j"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28D62F5B
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761321235; cv=none; b=GeRIr+mA0Jo9RNcKB159+69CeB00QHmekAOlitWjepAMDXTuwf6wx6XFCjP7Uo/OB6MLuXEoq6v+m8/YqCLpZwBPuiRhWDYTG4FrT5Oh8f/Ta6vFuFeU/DVPHY+idLMvVyWGEZduBBI9PaDIWNZZWvQMj1BgKkLnvDyQJakW900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761321235; c=relaxed/simple;
	bh=iOEJ6Tb/qB8BEb5/0ltf3QMXGEv2/IZUm7vtqa4NrTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snWuPnLJPTLYmtjethRhDsFH4se53K6pkBl4wZIq6V/7SZc7iCbSboFUJ698iLRQGn0G3dsN4F8dtiPlvYnOWx1hsgbjqKZoNu3AtsQClXV1xL55/4UrpfmezPahB0G4wcAcOAiNPK2mX3yaVJAhqsQqgZsVcN3nh/uXLTi1ad0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vRNGdf0j; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b6ceba7c97eso2054405a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761321233; x=1761926033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ykchracw+64FV50znwUKIsNmGJUvAyGYO9sAVqRHDLE=;
        b=vRNGdf0jxqPHhRCQDdZ+x5myMVDSTc5V562Rga37JPwV7PflLDT7tHZHFhKBriGdW2
         oh28EN82vQYD6WYObWSCtEciJxC6NeHyD/pHq6+VW03ged8kJLkT1CHvx2tLcnYUcmoW
         KXzXAXx9lIVHc30bQmE2avA7IbIN68xnvcfuTWW4+r4MIUiwrYMk5jH5cZ01mTg8ttwC
         wZ4W1VCW/DKZQUGamX7a34OuMZBDZ0xdPuoTp6b7cc5CwhyjcVo7ko7uk3IbugQli7dq
         0OjlZ3AqeeQ3NR+2SyKO3FC6xugVNeOMdAmWodrxGLQ0bA16wzkGiPuIO/zrkUrxBXgE
         GUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761321233; x=1761926033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ykchracw+64FV50znwUKIsNmGJUvAyGYO9sAVqRHDLE=;
        b=UvYqAYV3wYcFoIGfwO18tEtpdkyRQYsPJHn7TEhQ+Sd8aUd2Jp1VWTvSC6PDKsRiQH
         /L05PZtqSpLZPaSaadBpgzDU+t/FOm32OxNnugd4GmxWuz1ZZrg1yRnQ/emzTgTqlzr/
         hpPWxRIYxZavPu9ADloAm/nfeFEcoNzPDeK+yg4aHNv/1Tv1BRm3ax5GMQ1Lr7rq8zzm
         8xFbWMiGEIQGuWQoYviX81cMKJKt9KAAiioBev8TROmIIuIzNYPFtpKybxlKdZ0ez6+l
         WjTPxZrZVI3A2OmOKsip+MXyvH/+s0+wUDrxlb0sBA1GQJYRD1WH8vnh3Wybl6ssBa+Q
         5KcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxezDATj9+X2px3Y4ZstlZq7TrcNy4Ye568NeK+KRN+OvuInmieurHJ36ouOzA81pRD1IG+Nyf+VdlWnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNevkfQrM8tTuRlOy+88ys3jZVVfD46MlBu7boozLd03czwCu8
	bPctMHgQ9H+iLBH/QCujqzaFmpJgXYbf2YP+1COffU3f/FRp/4akaZ1AtiASQDA7lQ==
X-Gm-Gg: ASbGnct7o7bJIWApPyWlM3BdReGuXmJK7w8z0iQmnPs19NxsJMZQ2/lL/sYg89Tcpuo
	CwBBjpgCtC2qJT9HF9KGIpQuBsz2hiIruCnJwqrQiBm1IDv8DLVgrh3jtaxHlEAPTrz6GhnBxF2
	s1r4s0beJW6vLymY4/BNQ3CKesSnPSeiPyZ8gs9VFMErTTSO9+kw+++TVrSIOMCKgO3kjSSdr2F
	xEhLCpRJOZ+jzmF+3UVOAOhfaAU2HFYFCL4VwXCLUnc7uEwFiVK0N2cdXmzHIyEAdHQhEb7zONb
	rPmvc3E/HUS68Lxwi4wPFshiR791gslkC2tUZjrcol9pJuhWLmBI9YS5GNAT2xk3uybX9v1iYfk
	dEvFvGTj3ypV84Vbz3n9d0FXgFlADFH3niM9712TjrNzOGXHl6mBoFc39egbYBhOvWcGJYKwl5e
	k7lSh7kOPnH3kKIOpkFgP4I325+MeS1a79a38PFABM59VmVvBZ4G95PVOmAig=
X-Google-Smtp-Source: AGHT+IE+x2HD+4rMk0jkd18ooIAbdLhaDO73LscS2bNI12WgQHcODQg8NS4kS+ef5tm44z2hD8HW3A==
X-Received: by 2002:a17:902:ce81:b0:294:918e:d230 with SMTP id d9443c01a7336-294918ed5edmr16496605ad.56.1761321232883;
        Fri, 24 Oct 2025 08:53:52 -0700 (PDT)
Received: from google.com (80.88.82.34.bc.googleusercontent.com. [34.82.88.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e241d65sm59444195ad.107.2025.10.24.08.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 08:53:52 -0700 (PDT)
Date: Fri, 24 Oct 2025 15:53:48 +0000
From: William McVicker <willmcvicker@google.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Youngmin Nam <youngmin.nam@samsung.com>,
	Donghoon Yu <hoony.yu@samsung.com>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	John Stultz <jstultz@google.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-samsung-soc@vger.kernel.org, kernel-team@android.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/7] clocksource/drivers/exynos_mct: Add module support
Message-ID: <aPuhDFKINM9iXOKb@google.com>
References: <20251023205257.2029526-1-willmcvicker@google.com>
 <CGME20251023205319eucas1p24eb9821bbcb2d59e2cb1e01c4366faab@eucas1p2.samsung.com>
 <20251023205257.2029526-7-willmcvicker@google.com>
 <40d3f3c9-7526-440b-9dbd-7ead22c8562a@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40d3f3c9-7526-440b-9dbd-7ead22c8562a@samsung.com>

On 10/24/2025, Marek Szyprowski wrote:
> On 23.10.2025 22:52, Will McVicker wrote:
> > From: Donghoon Yu <hoony.yu@samsung.com>
> >
> > On Arm64 platforms the Exynos MCT driver can be built as a module. On
> > boot (and even after boot) the arch_timer is used as the clocksource and
> > tick timer. Once the MCT driver is loaded, it can be used as the wakeup
> > source for the arch_timer.
> >
> > Signed-off-by: Donghoon Yu <hoony.yu@samsung.com>
> > Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
> > Signed-off-by: Will McVicker <willmcvicker@google.com>
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > [original commit from https://android.googlesource.com/kernel/gs/+/8a52a8288ec7d88ff78f0b37480dbb0e9c65bbfd]
> > Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com> # AOSP -> Linux port
> > Tested-by: Youngmin Nam <youngmin.nam@samsung.com> # AOSP -> Linux port
> > ---
> >   drivers/clocksource/Kconfig      |  3 +-
> >   drivers/clocksource/exynos_mct.c | 56 +++++++++++++++++++++++++++-----
> >   2 files changed, 49 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index ffcd23668763..9450cfaf982f 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -451,7 +451,8 @@ config ATMEL_TCB_CLKSRC
> >   	  Support for Timer Counter Blocks on Atmel SoCs.
> >   
> >   config CLKSRC_EXYNOS_MCT
> > -	bool "Exynos multi core timer driver" if COMPILE_TEST
> > +	tristate "Exynos multi core timer driver" if ARM64
> > +	default y if ARCH_EXYNOS || COMPILE_TEST
> >   	depends on ARM || ARM64
> >   	depends on ARCH_ARTPEC || ARCH_EXYNOS || COMPILE_TEST
> >   	help
> > diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> > index fece6bbc190e..a87caf3928ef 100644
> > --- a/drivers/clocksource/exynos_mct.c
> > +++ b/drivers/clocksource/exynos_mct.c
> > @@ -15,9 +15,11 @@
> >   #include <linux/cpu.h>
> >   #include <linux/delay.h>
> >   #include <linux/percpu.h>
> > +#include <linux/module.h>
> >   #include <linux/of.h>
> >   #include <linux/of_irq.h>
> >   #include <linux/of_address.h>
> > +#include <linux/platform_device.h>
> >   #include <linux/clocksource.h>
> >   #include <linux/sched_clock.h>
> >   
> > @@ -217,6 +219,7 @@ static struct clocksource mct_frc = {
> >   	.mask		= CLOCKSOURCE_MASK(32),
> >   	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> >   	.resume		= exynos4_frc_resume,
> > +	.owner		= THIS_MODULE,
> >   };
> >   
> >   /*
> > @@ -241,7 +244,7 @@ static cycles_t exynos4_read_current_timer(void)
> >   }
> >   #endif
> >   
> > -static int __init exynos4_clocksource_init(bool frc_shared)
> > +static int exynos4_clocksource_init(bool frc_shared)
> >   {
> >   	/*
> >   	 * When the frc is shared, the main processor should have already
> > @@ -336,6 +339,7 @@ static struct clock_event_device mct_comp_device = {
> >   	.set_state_oneshot	= mct_set_state_shutdown,
> >   	.set_state_oneshot_stopped = mct_set_state_shutdown,
> >   	.tick_resume		= mct_set_state_shutdown,
> > +	.owner			= THIS_MODULE,
> >   };
> >   
> >   static irqreturn_t exynos4_mct_comp_isr(int irq, void *dev_id)
> > @@ -476,6 +480,7 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
> >   	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
> >   			CLOCK_EVT_FEAT_PERCPU;
> >   	evt->rating = MCT_CLKEVENTS_RATING;
> > +	evt->owner = THIS_MODULE;
> >   
> >   	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
> >   
> > @@ -511,7 +516,7 @@ static int exynos4_mct_dying_cpu(unsigned int cpu)
> >   	return 0;
> >   }
> >   
> > -static int __init exynos4_timer_resources(struct device_node *np)
> > +static int exynos4_timer_resources(struct device_node *np)
> >   {
> >   	struct clk *mct_clk, *tick_clk;
> >   
> > @@ -539,7 +544,7 @@ static int __init exynos4_timer_resources(struct device_node *np)
> >    * @local_idx: array mapping CPU numbers to local timer indices
> >    * @nr_local: size of @local_idx array
> >    */
> > -static int __init exynos4_timer_interrupts(struct device_node *np,
> > +static int exynos4_timer_interrupts(struct device_node *np,
> >   					   unsigned int int_type,
> >   					   const u32 *local_idx,
> >   					   size_t nr_local)
> > @@ -653,7 +658,7 @@ static int __init exynos4_timer_interrupts(struct device_node *np,
> >   	return err;
> >   }
> >   
> > -static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
> > +static int mct_init_dt(struct device_node *np, unsigned int int_type)
> >   {
> >   	bool frc_shared = of_property_read_bool(np, "samsung,frc-shared");
> >   	u32 local_idx[MCT_NR_LOCAL] = {0};
> > @@ -701,15 +706,48 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
> >   	return exynos4_clockevent_init();
> >   }
> >   
> > -
> > -static int __init mct_init_spi(struct device_node *np)
> > +static int mct_init_spi(struct device_node *np)
> >   {
> >   	return mct_init_dt(np, MCT_INT_SPI);
> >   }
> >   
> > -static int __init mct_init_ppi(struct device_node *np)
> > +static int mct_init_ppi(struct device_node *np)
> >   {
> >   	return mct_init_dt(np, MCT_INT_PPI);
> >   }
> > -TIMER_OF_DECLARE(exynos4210, "samsung,exynos4210-mct", mct_init_spi);
> > -TIMER_OF_DECLARE(exynos4412, "samsung,exynos4412-mct", mct_init_ppi);
> > +
> > +static int exynos4_mct_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	int (*mct_init)(struct device_node *np);
> > +
> > +	mct_init = of_device_get_match_data(dev);
> > +	if (!mct_init)
> > +		return -EINVAL;
> > +
> > +	return mct_init(dev->of_node);
> > +}
> > +
> > +static const struct of_device_id exynos4_mct_match_table[] = {
> > +	{ .compatible = "samsung,exynos4210-mct", .data = &mct_init_spi, },
> > +	{ .compatible = "samsung,exynos4412-mct", .data = &mct_init_ppi, },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(of, exynos4_mct_match_table);
> > +
> > +static struct platform_driver exynos4_mct_driver = {
> > +	.probe		= exynos4_mct_probe,
> > +	.driver		= {
> > +		.name	= "exynos-mct",
> > +		.of_match_table = exynos4_mct_match_table,
> > +	},
> > +};
> > +
> > +static __init int exynos_mct_init(void)
> > +{
> > +  return platform_driver_register(&exynos4_mct_driver);
> > +}
> > +module_init(exynos_mct_init);
> > +
> > +MODULE_DESCRIPTION("Exynos Multi Core Timer Driver");
> > +MODULE_LICENSE("GPL");
> 
> Sorry, but this still won't work on legacy ARM 32bit systems with MCT as 
> the only clocksource, which needs a driver available very early (that's 
> why it used TIMER_OF_DECLAREmacro). You need to make it conditional 
> under CONFIG_ARM:

Can we rely on the bootloader to setup the MCT timer and then hand-off at boot
once the driver is initialized?

Daniel was working on a solution to transparently handle calling
TIMER_OF_DECLARE() when a timer driver can be configured as both a module or
built-in here:

  https://lore.kernel.org/all/20250625085715.889837-1-daniel.lezcano@linaro.org/

Daniel, do you have plans to finish that? In the meantime, can we go with the
`#if CONFIG_ARM` solution?

Thanks,
Will

<snip>

