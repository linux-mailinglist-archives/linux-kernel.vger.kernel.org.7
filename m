Return-Path: <linux-kernel+bounces-866173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A8ABFF109
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 23369357CA5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 04:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECC52877CF;
	Thu, 23 Oct 2025 04:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Ok4/9Xmw"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228CF2741D1
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761192415; cv=none; b=URzg4dq8VYSZhE7Sh9+8Rdw4LGzX/GoipH8245zG9C+n6VtzaJVHoR38UJoBRXRwhZJzDiDwnVj0WGWG2XPM7UCA+9y3zpbLhsTbcyM4C08afvdIgS3qgYM1NU1HTgHEIpGayhQRpp9roz+xr/xc4UzRGLpTyruaA9km9u0Sfnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761192415; c=relaxed/simple;
	bh=neu0sMf02RKmw4o/eH09G0DNJ0J9AWDS6oOm4k1NROs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6tf0Dn9uxrUjNR7gEZUzAbp/Zpkdh1WWHM+Aqhr2dMPk7o7HZhneplYeUe/N+/9mLroJPsiV8XdeTLuYpcDCx+IIy5I0n76kh9sh22GOXgos9TjfWdJ+eP6Pyjgnehk0AJqLCnH3F8B/YyPHQATp6szuE1OrLlP7D1nLlZgZLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Ok4/9Xmw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47118259fd8so1795575e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 21:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1761192410; x=1761797210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l9LmGzf8lZ8AA4pnml32k/4kEpS62XT9jc9VmDFNvb0=;
        b=Ok4/9XmwJG7tQ0gbEI2lXpwqaT0tlkUcyR/CEu7SYNDUcF99ZVXaybh7ZDA/V15Bt0
         iRUL7mAtB1/ctQuh6exyMzorlQ5CON8d9VB6WePQO0+u0VebNzGuz8rpgkKEUyAg4Y2m
         PaH6iJ3ke9vUQODyaCCqAQ6KlxD2K2kJkoRrzdDz6YS5023DGI4dFhXUgBzqvH+SKziP
         FPNJ9DL+upRzIG3bT+kiKTBMYLYFIdoJy2fP4iEbswoN9XeBRDgWtfxmLyBFYTwvaUjY
         vEjSqqNyAWoZxCAms3HGESC5wvWnLAnC2ChwAkH1c47qdUQhmwrkF6pLPcoJ7QtNi/+z
         +wKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761192410; x=1761797210;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9LmGzf8lZ8AA4pnml32k/4kEpS62XT9jc9VmDFNvb0=;
        b=ttuh0EJyRs7xYyRBX4v4cdkv4vwnog1BLv2HsLnq8rYdmYfGhzXLE3pCowoESyZzWq
         sq3UR45SBz7X6OObgeBV/jawZ9/awCv4FMbIpfAAPZjoCxECIPL9iGHjf4qVwBp0r5ZV
         4tW+gr2XZiHs0M0Gnc0JFjd3cn6J1W9SuTVCpLxAqbpZ2zLZU195l+sUAmRqEfdfMGpr
         OH1eDiJ3BzmH27Mf4ep/GkQbr1M7mb/ofDfxAqKqza8JOed8yjUsPTOc3ceQ7Qhag9NK
         /2VG0TshGcMNoZVv3TbSjKqbzJ/xScA+DxrqVexwrJJ1HlFLdjDG+CCq2HR0SAkxGwsI
         mLTA==
X-Forwarded-Encrypted: i=1; AJvYcCVNj95A+wxflPPrRKwOwY6FVdtYsO6If1j9GocOJ7conBVmAtb7lMXjgV6eYfqQVTRBTru50Ooc8NIUxWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOYFl8TvljFGytMT3ZlnMlFAbzIKO5dqO2mUGdH1eS9CdN8qsx
	Efw4PThUpGuLaAtvFnmmJguJNuzKQBsiuLKLPsG76lzorDk/5Ee3J4Ae5Fxrcvbu+gMGwpi3Wln
	rwWm8
X-Gm-Gg: ASbGncucQsmY2bme6THbpXUM2Ec3Bjy3wpFg0fI8L9aeEFybiGaHZKIH/rj3EL5FoO+
	fgAk9fdk+pARoxX/Zs5H/7HfhR8rrK2AOIOf5pxHx2YPqc6+x6CElgn+9JNosRvPt4AlTWvOa3+
	8yukn/XioZfTe73MYUOscLqffgoYxBAkDrW7dUzDe0XymLt0P2YHVdmdHrP6Ff/3id7Im1DVA1V
	cBFjpUWYlHSev6NPNS+J4HK7NCjMdun3vrMf2MVy5A6sHetZ0tVz7MVDN+L807g9ke7dmSQjjw4
	MbS6v9UWEw94/L0efn3QEsYG4PTFJi76P3GylG1hcn2pjHK+l6H3eOdDHS5b0wnaMMKm8V54xs3
	UCXt3p0//F0fKDsxQ/+o4yDnuUGTT/fjfsOGiNcc7TrB3HV3snWy7lzxX41JUNKE7vzi+a8omc1
	jcuy9oRW9G
X-Google-Smtp-Source: AGHT+IHLzTiBpHfQjhvlWTJj5VKysMH/PyHRD3J5uwhQAkstbuvehGbVgVMmpZfM+iZPn2D+iNdjkA==
X-Received: by 2002:a05:6000:3113:b0:427:7ad:466f with SMTP id ffacd0b85a97d-42707ad4680mr15906098f8f.39.1761192410406;
        Wed, 22 Oct 2025 21:06:50 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898ccc60sm1657768f8f.34.2025.10.22.21.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 21:06:49 -0700 (PDT)
Message-ID: <60544429-3eeb-41df-b42c-613da651b4a1@tuxon.dev>
Date: Thu, 23 Oct 2025 07:06:48 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] reset: mpfs: add non-auxiliary bus probing
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Daire McNamara <daire.mcnamara@microchip.com>,
 pierre-henry.moussay@microchip.com, valentina.fernandezalanis@microchip.com,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-riscv@lists.infradead.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251013-album-bovine-faf9f5ebc5d4@spud>
 <20251013-crane-utilize-cff9298291a4@spud>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20251013-crane-utilize-cff9298291a4@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Conor,

On 10/13/25 20:45, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> While the auxiliary bus was a nice bandaid, and meant that re-writing
> the representation of the clock regions in devicetree was not required,
> it has run its course. The "mss_top_sysreg" region that contains the
> clock and reset regions, also contains pinctrl and an interrupt
> controller, so the time has come rewrite the devicetree and probe the
> reset controller from an mfd devicetree node, rather than implement
> those drivers using the auxiliary bus. Wanting to avoid propagating this
> naive/incorrect description of the hardware to the new pic64gx SoC is a
> major motivating factor here.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> v4:
> - Only use driver specific lock for non-regmap writes
> 
> v2:
> - Implement the request to use regmap_update_bits(). I found that I then
>   hated the read/write helpers since they were just bloat, so I ripped
>   them out. I replaced the regular spin_lock_irqsave() stuff with a
>   guard(spinlock_irqsave), since that's a simpler way of handling the two
>   different paths through such a trivial pair of functions.
> ---
>  drivers/reset/reset-mpfs.c | 83 ++++++++++++++++++++++++++++++--------
>  1 file changed, 66 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/reset/reset-mpfs.c b/drivers/reset/reset-mpfs.c
> index f6fa10e03ea8..8e5ed4deecf3 100644
> --- a/drivers/reset/reset-mpfs.c
> +++ b/drivers/reset/reset-mpfs.c
> @@ -7,13 +7,16 @@
>   *
>   */
>  #include <linux/auxiliary_bus.h>
> +#include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
> +#include <linux/mfd/syscon.h>

Should you add a depends on MFD_SYSCON ?

>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> -#include <linux/slab.h>
> +#include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> +#include <linux/slab.h>
>  #include <dt-bindings/clock/microchip,mpfs-clock.h>
>  #include <soc/microchip/mpfs.h>
>  
> @@ -27,11 +30,14 @@
>  #define MPFS_SLEEP_MIN_US	100
>  #define MPFS_SLEEP_MAX_US	200
>  
> +#define REG_SUBBLK_RESET_CR	0x88u
> +
>  /* block concurrent access to the soft reset register */
>  static DEFINE_SPINLOCK(mpfs_reset_lock);
>  
>  struct mpfs_reset {
>  	void __iomem *base;
> +	struct regmap *regmap;
>  	struct reset_controller_dev rcdev;
>  };
>  
> @@ -46,41 +52,50 @@ static inline struct mpfs_reset *to_mpfs_reset(struct reset_controller_dev *rcde
>  static int mpfs_assert(struct reset_controller_dev *rcdev, unsigned long id)
>  {
>  	struct mpfs_reset *rst = to_mpfs_reset(rcdev);
> -	unsigned long flags;
>  	u32 reg;
>  
> -	spin_lock_irqsave(&mpfs_reset_lock, flags);
> +	if (rst->regmap) {
> +		regmap_update_bits(rst->regmap, REG_SUBBLK_RESET_CR, BIT(id), BIT(id));
> +		return 0;

You can:
		return regmap_update_bits();

> +	}
> +
> +	guard(spinlock_irqsave)(&mpfs_reset_lock);
>  
>  	reg = readl(rst->base);
>  	reg |= BIT(id);
>  	writel(reg, rst->base);
>  
> -	spin_unlock_irqrestore(&mpfs_reset_lock, flags);
> -
>  	return 0;
>  }
>  
>  static int mpfs_deassert(struct reset_controller_dev *rcdev, unsigned long id)
>  {
>  	struct mpfs_reset *rst = to_mpfs_reset(rcdev);
> -	unsigned long flags;
>  	u32 reg;
>  
> -	spin_lock_irqsave(&mpfs_reset_lock, flags);
> +	if (rst->regmap) {
> +		regmap_update_bits(rst->regmap, REG_SUBBLK_RESET_CR, BIT(id), 0);
> +		return 0;
> +	}
> +
> +	guard(spinlock_irqsave)(&mpfs_reset_lock);
>  
>  	reg = readl(rst->base);
>  	reg &= ~BIT(id);
>  	writel(reg, rst->base);
>  
> -	spin_unlock_irqrestore(&mpfs_reset_lock, flags);
> -
>  	return 0;
>  }
>  
>  static int mpfs_status(struct reset_controller_dev *rcdev, unsigned long id)
>  {
>  	struct mpfs_reset *rst = to_mpfs_reset(rcdev);
> -	u32 reg = readl(rst->base);
> +	u32 reg;
> +
> +	if (rst->regmap)
> +		regmap_read(rst->regmap, REG_SUBBLK_RESET_CR, &reg);
> +	else
> +		reg = readl(rst->base);
>  
>  	/*
>  	 * It is safe to return here as MPFS_NUM_RESETS makes sure the sign bit
> @@ -130,11 +145,45 @@ static int mpfs_reset_xlate(struct reset_controller_dev *rcdev,
>  	return index - MPFS_PERIPH_OFFSET;
>  }
>  
> -static int mpfs_reset_probe(struct auxiliary_device *adev,
> -			    const struct auxiliary_device_id *id)
> +static int mpfs_reset_mfd_probe(struct platform_device *pdev)
>  {
> -	struct device *dev = &adev->dev;
>  	struct reset_controller_dev *rcdev;
> +	struct device *dev = &pdev->dev;
> +	struct mpfs_reset *rst;
> +
> +	rst = devm_kzalloc(dev, sizeof(*rst), GFP_KERNEL);
> +	if (!rst)
> +		return -ENOMEM;
> +
> +	rcdev = &rst->rcdev;
> +	rcdev->dev = dev;
> +	rcdev->ops = &mpfs_reset_ops;
> +
> +	rcdev->of_node = pdev->dev.parent->of_node;
> +	rcdev->of_reset_n_cells = 1;
> +	rcdev->of_xlate = mpfs_reset_xlate;
> +	rcdev->nr_resets = MPFS_NUM_RESETS;
> +
> +	rst->regmap = device_node_to_regmap(pdev->dev.parent->of_node);
> +	if (IS_ERR(rst->regmap))
> +		dev_err_probe(dev, PTR_ERR(rst->regmap), "Failed to find syscon regmap\n");
> +
> +	return devm_reset_controller_register(dev, rcdev);
> +}
> +
> +static struct platform_driver mpfs_reset_mfd_driver = {
> +	.probe		= mpfs_reset_mfd_probe,
> +	.driver = {
> +		.name = "mpfs-reset",
> +	},
> +};
> +module_platform_driver(mpfs_reset_mfd_driver);
> +
> +static int mpfs_reset_adev_probe(struct auxiliary_device *adev,
> +				 const struct auxiliary_device_id *id)
> +{
> +	struct reset_controller_dev *rcdev;
> +	struct device *dev = &adev->dev;
>  	struct mpfs_reset *rst;
>  
>  	rst = devm_kzalloc(dev, sizeof(*rst), GFP_KERNEL);
> @@ -145,8 +194,8 @@ static int mpfs_reset_probe(struct auxiliary_device *adev,
>  
>  	rcdev = &rst->rcdev;
>  	rcdev->dev = dev;
> -	rcdev->dev->parent = dev->parent;
>  	rcdev->ops = &mpfs_reset_ops;
> +
>  	rcdev->of_node = dev->parent->of_node;
>  	rcdev->of_reset_n_cells = 1;
>  	rcdev->of_xlate = mpfs_reset_xlate;
> @@ -176,12 +225,12 @@ static const struct auxiliary_device_id mpfs_reset_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(auxiliary, mpfs_reset_ids);
>  
> -static struct auxiliary_driver mpfs_reset_driver = {
> -	.probe		= mpfs_reset_probe,
> +static struct auxiliary_driver mpfs_reset_aux_driver = {
> +	.probe		= mpfs_reset_adev_probe,
>  	.id_table	= mpfs_reset_ids,
>  };
>  
> -module_auxiliary_driver(mpfs_reset_driver);
> +module_auxiliary_driver(mpfs_reset_aux_driver);
>  
>  MODULE_DESCRIPTION("Microchip PolarFire SoC Reset Driver");
>  MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");


