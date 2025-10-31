Return-Path: <linux-kernel+bounces-879592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDB2C23886
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16447402EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C95329367;
	Fri, 31 Oct 2025 07:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MlGTlh8H"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1883332936A
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761895223; cv=none; b=OlnjIw+BsihQY+Cj6fB98OqOw5zs9A84vr0k1GR5g9MuwVb0yjUoLNupVP3sjbU9teiE4uSr7mk1/HEzb5G9WR9gY2M8KML9+Por5vOk4WRJAwJ1kQ9A+ZHxb9q2lXW5iaGXj+r/naSwlbbEmHK7mI05PoDvLMnv76g6QD9Z4/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761895223; c=relaxed/simple;
	bh=mMqYgeH0UeWOZ3VddzUW82YN8pgLCvc0+QOH5FcuQZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jVAHBLLmaAObWpRD7dfD4JClLD1kVdF8Fd4gMEpwBqreOUuDxOVH89/PFOraMMolMdG4GkSgjn5TuafnrIMFC1zeiq8sZEwJgjynCUfl369IqT0+xDkQm62/KMV2WYN3VE9ggetCD/kobTnlxjKs25tZtwT5WaMQEoHKVVUyqQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=MlGTlh8H; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-421851bcb25so1094268f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1761895219; x=1762500019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c6jwEFLJ69MPfiwc21mJzxfsviakHrUqtdfEeBD68fU=;
        b=MlGTlh8HtbGjg1KsOvbgFVC/CY85a3wgucZZ+tICTarzcjGzQ81jwGuSL/20Waikjk
         ZOLuCmZucuYxu0mbzrEXy1U1fc8P1yCa4MDU/ktgHnDGjUtrIf+xLOlOhC1NraRNfA/8
         PthQaH/2KtwRpHIy1PC90zf8P1W8N3ikn7aq3C4RKhvCU2wAontHEXC+qikfJAY8ln59
         hio84PduTWYeLrzHZglmOA2dW+vuHGsgL/yiuNQ9LqTg+49PPDE0CnsHBKPCObDQeL/U
         kv3CwTHUT/gbWyjga4i71jLFFzrko+xkR5dlCmAE6729/ZitBSZPE0A4uyUobeI+fLHY
         M12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761895219; x=1762500019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6jwEFLJ69MPfiwc21mJzxfsviakHrUqtdfEeBD68fU=;
        b=vP1Oxil+12kNFFF3fHCMMYNxa4Fgi/DalCZ6gZYvqFSFi9g5QZB3QiUYji/uG8cN/O
         bS+J/e5QFYZz9M+7Qy8LKIGZUbYNFGMr0cLxTDVzIMYKUuhgluzfmHNYeBlTbNpxvXXN
         N13Dzc1iLwAg4FUGIA1eyozSvPBNpUKfPdZpBO9uEmzl2EQDi46dGFsduV4ID4gpDovC
         ObMlbYeyJfQoQQnIOPASPpRAkCZywX2OQowvy/WIuwJXS+HLDcOigUXK7ZWxmg1vYB0g
         aFuovLmeKigKqy+c/6gclW0hecgn94OhKKJoRcPSZKgQf9Gu0TQRU5qfdKOKfwV9Hh6U
         nbKw==
X-Forwarded-Encrypted: i=1; AJvYcCUbRXP1JfmLAoxMNu8zkgYGuj79ghFUc2nBkRL1RUGRqtn4639+1EXje+8AnFo7xfksLmyhNFcr2iKoRV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHRJDVLhTVes9KP+R2ILDgLi0R1VqM08rh1oBinAs1JZfFXIP3
	hQp7BjhH4+yy693rLnpJqySrvQE7T8YJD36rMIR23O0nBa8jAiVwfpuiEHlpSx4tVIxS3QSG4si
	sXQ7I
X-Gm-Gg: ASbGncuT0dbSQnMNJ34hwdb8EfFbWX3eFtLpVeMcml/psMUIt1dzJRSGsOUhcsIlSOQ
	m81igI98WqMZ93v91OEe0+btgjG+umSXVwaabW1MWEOV8EPrzsMSp3a0sNC9sQRB84ZHCJmlo4x
	531Z/ILGJHaYSmNKZkh3HlxfV4O4xxl8R23fMjOgUu2oJv+GFYJzpZSKPifcog9vK7gyAABPGeZ
	hAFR4cVHLYZcw+D5ACoRbUaS6tMLP/tUweyB14B6d/1QDYrdud8/0pFWeL+ErSRAyK4G/fVtXG/
	XVvJ4eJjHWF3FqFilMrW80l/d3PhSMfxeJVF+MY1vkLiouB5cXohpG15GghXPS4k6C3AemYOvDB
	SPT+6v6TwB+zXFPpZDpW7myHBgHaOUybWy7rlCQigrqQdphJW0cidMOYxY6UMVEszsBzLM6fv32
	7jMhHdd/92IJcMvooB2w==
X-Google-Smtp-Source: AGHT+IESPn1B27UDKqe6BRuoLyrklQLHzvgJJAtmUoGoNQEqfAcuNcYhohI3pcW3sVc+wl9uzkERfw==
X-Received: by 2002:a05:6000:2908:b0:3e7:5f26:f1e5 with SMTP id ffacd0b85a97d-429bd680e96mr1864170f8f.23.1761895219281;
        Fri, 31 Oct 2025 00:20:19 -0700 (PDT)
Received: from [10.31.13.216] ([82.77.28.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13f192fsm1969656f8f.38.2025.10.31.00.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 00:20:18 -0700 (PDT)
Message-ID: <a996e76e-8201-4b72-b4fa-0ea9ac62e6b1@tuxon.dev>
Date: Fri, 31 Oct 2025 09:20:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/7] reset: mpfs: add non-auxiliary bus probing
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
References: <20251029-chewing-absolve-c4e6acfe0fa4@spud>
 <20251029-macarena-neglector-318431fec367@spud>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251029-macarena-neglector-318431fec367@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Conor,

On 10/29/25 18:11, Conor Dooley wrote:
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
> v6:
> - depend on MFD_SYSCON
> - return regmap_update_bits() result directly instead of an additional
>    return 0
> 
> v4:
> - Only use driver specific lock for non-regmap writes
> 
> v2:
> - Implement the request to use regmap_update_bits(). I found that I then
>    hated the read/write helpers since they were just bloat, so I ripped
>    them out. I replaced the regular spin_lock_irqsave() stuff with a
>    guard(spinlock_irqsave), since that's a simpler way of handling the two
>    different paths through such a trivial pair of functions.
> ---
>   drivers/reset/Kconfig      |  1 +
>   drivers/reset/reset-mpfs.c | 79 ++++++++++++++++++++++++++++++--------
>   2 files changed, 63 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 78b7078478d4..0ec4b7cd08d6 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -200,6 +200,7 @@ config RESET_PISTACHIO
>   config RESET_POLARFIRE_SOC
>   	bool "Microchip PolarFire SoC (MPFS) Reset Driver"
>   	depends on MCHP_CLK_MPFS
> +	depends on MFD_SYSCON
>   	select AUXILIARY_BUS
>   	default MCHP_CLK_MPFS
>   	help
> diff --git a/drivers/reset/reset-mpfs.c b/drivers/reset/reset-mpfs.c
> index f6fa10e03ea8..25de7df55301 100644
> --- a/drivers/reset/reset-mpfs.c
> +++ b/drivers/reset/reset-mpfs.c
> @@ -7,13 +7,16 @@
>    *
>    */
>   #include <linux/auxiliary_bus.h>
> +#include <linux/cleanup.h>
>   #include <linux/delay.h>
>   #include <linux/io.h>
> +#include <linux/mfd/syscon.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/platform_device.h>
> -#include <linux/slab.h>
> +#include <linux/regmap.h>
>   #include <linux/reset-controller.h>
> +#include <linux/slab.h>
>   #include <dt-bindings/clock/microchip,mpfs-clock.h>
>   #include <soc/microchip/mpfs.h>
>   
> @@ -27,11 +30,14 @@
>   #define MPFS_SLEEP_MIN_US	100
>   #define MPFS_SLEEP_MAX_US	200
>   
> +#define REG_SUBBLK_RESET_CR	0x88u
> +
>   /* block concurrent access to the soft reset register */
>   static DEFINE_SPINLOCK(mpfs_reset_lock);
>   
>   struct mpfs_reset {
>   	void __iomem *base;
> +	struct regmap *regmap;
>   	struct reset_controller_dev rcdev;
>   };
>   
> @@ -46,41 +52,46 @@ static inline struct mpfs_reset *to_mpfs_reset(struct reset_controller_dev *rcde
>   static int mpfs_assert(struct reset_controller_dev *rcdev, unsigned long id)
>   {
>   	struct mpfs_reset *rst = to_mpfs_reset(rcdev);
> -	unsigned long flags;
>   	u32 reg;
>   
> -	spin_lock_irqsave(&mpfs_reset_lock, flags);
> +	if (rst->regmap)
> +		return regmap_update_bits(rst->regmap, REG_SUBBLK_RESET_CR, BIT(id), BIT(id));
> +
> +	guard(spinlock_irqsave)(&mpfs_reset_lock);
>   
>   	reg = readl(rst->base);
>   	reg |= BIT(id);
>   	writel(reg, rst->base);
>   
> -	spin_unlock_irqrestore(&mpfs_reset_lock, flags);
> -
>   	return 0;
>   }
>   
>   static int mpfs_deassert(struct reset_controller_dev *rcdev, unsigned long id)
>   {
>   	struct mpfs_reset *rst = to_mpfs_reset(rcdev);
> -	unsigned long flags;
>   	u32 reg;
>   
> -	spin_lock_irqsave(&mpfs_reset_lock, flags);
> +	if (rst->regmap)
> +		return regmap_update_bits(rst->regmap, REG_SUBBLK_RESET_CR, BIT(id), 0);
> +
> +	guard(spinlock_irqsave)(&mpfs_reset_lock);
>   
>   	reg = readl(rst->base);
>   	reg &= ~BIT(id);
>   	writel(reg, rst->base);
>   
> -	spin_unlock_irqrestore(&mpfs_reset_lock, flags);
> -
>   	return 0;
>   }
>   
>   static int mpfs_status(struct reset_controller_dev *rcdev, unsigned long id)
>   {
>   	struct mpfs_reset *rst = to_mpfs_reset(rcdev);
> -	u32 reg = readl(rst->base);
> +	u32 reg;
> +
> +	if (rst->regmap)
> +		regmap_read(rst->regmap, REG_SUBBLK_RESET_CR, &reg);
> +	else
> +		reg = readl(rst->base);
>   
>   	/*
>   	 * It is safe to return here as MPFS_NUM_RESETS makes sure the sign bit
> @@ -130,11 +141,45 @@ static int mpfs_reset_xlate(struct reset_controller_dev *rcdev,
>   	return index - MPFS_PERIPH_OFFSET;
>   }
>   
> -static int mpfs_reset_probe(struct auxiliary_device *adev,
> -			    const struct auxiliary_device_id *id)
> +static int mpfs_reset_mfd_probe(struct platform_device *pdev)
>   {
> -	struct device *dev = &adev->dev;
>   	struct reset_controller_dev *rcdev;
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

Do you want to continue registering the reset controller here? rcdev->base is 
NULL, thus the reset controller ops will fail, if I'm not wrong.

Thank you,
Claudiu


