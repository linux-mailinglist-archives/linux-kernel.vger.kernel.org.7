Return-Path: <linux-kernel+bounces-895028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59512C4CBD5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F2F189BF9E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAC22F361C;
	Tue, 11 Nov 2025 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSTDKRfu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3603D2D7398;
	Tue, 11 Nov 2025 09:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854224; cv=none; b=agMm57MKvgtp3Lb0gS/pzb3KZHYEaITaULVHZwd7Te+aezP7B1f/vBAk7Fve8xUinlpASgpMmaM6fiCwkwWR26FfMEVn2dTAkvVEPtAg/xHSoMrvRXDi1NMPTUgGSP7lUB7LoKEI/QnNRrfFbvAXlC0WWcG1V3UfvL/MWfBsjeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854224; c=relaxed/simple;
	bh=FAbNcGdRZ2BZlL+XAx4i735Jgte5T1dqnEhNRQbrtKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nCSRPKgrS4fqX2nUvWuKtK/684cVPU2CeiYzWZrecDsBeUOfPFUjHPrcxazuA93QI+7YANOfpV/9wzCU9ln5V3qmN3UtzsdX+SLXy7dV6ces5OLEJb4cHD5zVmZRvoaomtZ85UxDzROjlbu5m8t5VDC7gBe0K/9KStHh9x3HbmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSTDKRfu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6632CC2BCB2;
	Tue, 11 Nov 2025 09:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762854223;
	bh=FAbNcGdRZ2BZlL+XAx4i735Jgte5T1dqnEhNRQbrtKg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fSTDKRfuBoKKqQLAI4vv9CnzsAbsMMVdKlRVNShFLwRD6Lu/3UM7GgEwGKA6cG9oO
	 jgVJ3d0PU3g+tIbuujq/XnNQTRLIAxBesPj+mtvUqoFZNUJBPWCCNYkFPgIf0W2NOP
	 YV/wEKRbtVFZZoVKVyy7iT2yFHBlMhWjAcs3jcYQWXhPEMc6fHiCrVRijyZeZOPaK7
	 SPdrD8fKGJO8b096aUTc1LMgHGrWucgoR9W2qazVqiJ29+fa/oa5OnHX7OzWlV6I0k
	 wcdqSGruTUFH+wNUKzJwDy/VgsBdSpFMplFJrzsKoeIEX3f6/l2X80a7Rd93YV8Svw
	 NpnPgdUV1GGsw==
Message-ID: <d94dc0f4-5d81-4e95-b9e6-1c3940180c36@kernel.org>
Date: Tue, 11 Nov 2025 10:43:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clocksource: Add Realtek systimer as tick broadcast
 driver
To: Hao-Wen Ting <haowen.ting@realtek.com>, daniel.lezcano@linaro.org,
 tglx@linutronix.de
Cc: jinn.cheng@realtek.com, edwardwu@realtek.com, phelic@realtek.com,
 shawn.huang724@realtek.com, cy.huang@realtek.com, james.tai@realtek.com,
 cylee12@realtek.com, phinex@realtek.com, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251111092959.616089-1-haowen.ting@realtek.com>
 <20251111092959.616089-3-haowen.ting@realtek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251111092959.616089-3-haowen.ting@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/2025 10:29, Hao-Wen Ting wrote:
> Add a tick broadcast timer driver for Realtek SoCs.
> 
> On Realtek platforms, CPUs can enter deep idle states (C-states) where
> the local timer is stopped and powered off. Without a global tick
> broadcast timer, one CPU must remain awake to wake up the others,
> preventing all CPUs from entering deep idle simultaneously.
> 
> This driver provides a tick broadcast timer which remains active
> during deep idle states. This allows all CPUs to enter power-cut
> idle states simultaneously, significantly reducing overall power
> consumption.
> 
> The timer operates at 1MHz and supports oneshot mode.
> 
> Signed-off-by: Hao-Wen Ting <haowen.ting@realtek.com>
> ---
>  MAINTAINERS                         |   5 +
>  drivers/clocksource/Kconfig         |  10 ++
>  drivers/clocksource/Makefile        |   1 +
>  drivers/clocksource/timer-realtek.c | 173 ++++++++++++++++++++++++++++
>  4 files changed, 189 insertions(+)
>  create mode 100644 drivers/clocksource/timer-realtek.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c7a116b795d5..59dfd7543c39 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -28395,3 +28395,8 @@ S:	Buried alive in reporters
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>  F:	*
>  F:	*/
> +
> +REALTEK SYSTIMER DRIVER

Why are you adding to the end of the file? Did you look at this file at
all before changing this?

> +M:	Hao-Wen Ting <haowen.ting@realtek.com>
> +S:	Maintained
> +F:	drivers/clocksource/timer-realtek.c
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index ffcd23668763..e86905378f82 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -782,4 +782,14 @@ config NXP_STM_TIMER
>            Enables the support for NXP System Timer Module found in the
>            s32g NXP platform series.
>  
> +config RTK_SYSTIMER
> +	bool "Realtek SYSTIMER support"
> +	depends on OF
Missing depends on ARCH. Please don't send drivers which do not have any
possible user.

> +	select TIMER_OF
> +	help
> +	  This enables the global tick-broadcast timer on Realtek platforms.
> +	  If your Realtek platform supports power-cut level CPU idle states,
> +	  enabling this timer allows all CPUs to enter power-cut simultaneously
> +	  to achieve lower power consumption.
> +

...

> +
> +static int __init rtk_systimer_init(struct device_node *node)
> +{
> +	int ret;
> +
> +	ret = timer_of_init(node, &_to);
> +	if (ret)
> +		return ret;
> +
> +	systimer_base = timer_of_base(&_to);
> +	clockevents_config_and_register(&_to.clkevt, SYSTIMER_RATE,
> +					SYSTIMER_MIN_DELTA, SYSTIMER_MAX_DELTA);
> +
> +	pr_info("Realtek SYSTIMER registered\n");

Drop.

This does not look like useful printk message. Drivers should be silent
on success:
https://elixir.bootlin.com/linux/v6.15-rc7/source/Documentation/process/coding-style.rst#L913
https://elixir.bootlin.com/linux/v6.15-rc7/source/Documentation/process/debugging/driver_development_debugging_guide.rst#L79

> +	return 0;
> +}
> +
> +TIMER_OF_DECLARE(rtk_systimer, "realtek,systimer", rtk_systimer_init);


Best regards,
Krzysztof

