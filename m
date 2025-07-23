Return-Path: <linux-kernel+bounces-742043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDB9B0EC4B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E726C1C249CA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9744B272E61;
	Wed, 23 Jul 2025 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqmUo9BC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A0B248F5F;
	Wed, 23 Jul 2025 07:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753256880; cv=none; b=Kp6jtv+jtYneVSzvFjst0/KEKMM23/2IoklKSf+kPDUN7MihCaytl0piQeGtEa0Kt5vviG66mufO2Ef/F9K4+Ay0nWNAfLhTiz4ePxEA80f+ADjEfRI9z3ChbyUkhr2SFbfBgRvHYJQpjW5ELe3q5kcZ3VfABPqN5kYzfS22XV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753256880; c=relaxed/simple;
	bh=KKn1BH2pU5ZMIp/brMQbOxv6/eE2JB3+FPK/EVwTJEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mg+SPfTBsr3qJgVo+tKV5R3h9Rt+aLLXtHPsBEwm9il+rFY+Dy+i0LaqPTVkArdrVwnMHX/4hj4T9mf9Te7G+gY7bX94o/yG41KSaziuf2lI+k3JjUqa2LyK109JAnLJhv3ggwspPbMPb/ZwPnTEwMvyB1cQYsKcqxyEfuPWI2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqmUo9BC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CF4C4CEE7;
	Wed, 23 Jul 2025 07:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753256879;
	bh=KKn1BH2pU5ZMIp/brMQbOxv6/eE2JB3+FPK/EVwTJEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pqmUo9BC2wb+EIBkEj8YcSNMz6GCFUmCrc/X+6TbLnXqwuG2OKYA8oFA15SguPS+j
	 MAVtyLPjoQZJmRYejaeYEXCPsiCL5JLtfD/GtS/gGyTrJtH0Rabg72Mheklyh750PG
	 6f97AynZ9MvkAXWSYEiVjEa9Z7lSNgRxjA5AG1nTmnuBmR3vek8kVlBFkmkJPSvE1j
	 Ii2/ZCsl0Rqnr2yayr3BX7b/8wAr/DEj4Tq/5Mw7a53di50DSTJfs/nzLRgcYOacU7
	 ozH30cEGU4Xmy+4bocX68Nvanhfcwwlsn2mLtgNZ9R88YAojlIg2zLFqveVFZAn243
	 eWi48zyMYS2xQ==
Date: Wed, 23 Jul 2025 09:47:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: muhammed.efecetin.67@gmail.com
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de, neil.armstrong@linaro.org, lee@kernel.org, 
	rafael@kernel.org, efectn@protonmail.com, daniel.lezcano@linaro.org
Subject: Re: [PATCH v2 3/5] mfd: add Khadas Edge 2 registers to khadas-mcu.
Message-ID: <20250723-adamant-smiling-markhor-a8ebee@kuoka>
References: <cover.1753179491.git.efectn@protonmail.com>
 <41993cb8130fc206ee6820866154baef7db804e8.1753179491.git.efectn@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41993cb8130fc206ee6820866154baef7db804e8.1753179491.git.efectn@protonmail.com>

On Tue, Jul 22, 2025 at 03:38:13PM +0300, muhammed.efecetin.67@gmail.com wrote:
>  	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> @@ -94,7 +130,11 @@ static int khadas_mcu_probe(struct i2c_client *client)
>  
>  	ddata->dev = dev;
>  
> -	ddata->regmap = devm_regmap_init_i2c(client, &khadas_mcu_regmap_config);
> +	if (of_device_is_compatible(dev->of_node, "khadas,mcu-v2"))

This does not scale. Use device match data for exactly this purpose.

> +		regmap_config = &khadas_mcu_regmap_config_v2;
> +	else
> +		regmap_config = &khadas_mcu_regmap_config;
> +	ddata->regmap = devm_regmap_init_i2c(client, regmap_config);
>  	if (IS_ERR(ddata->regmap)) {
>  		ret = PTR_ERR(ddata->regmap);
>  		dev_err(dev, "Failed to allocate register map: %d\n", ret);
> @@ -113,6 +153,7 @@ static int khadas_mcu_probe(struct i2c_client *client)
>  #ifdef CONFIG_OF
>  static const struct of_device_id khadas_mcu_of_match[] = {
>  	{ .compatible = "khadas,mcu", },
> +	{ .compatible = "khadas,mcu-v2", },

So devices are 100% compatible? Empty match data suggests that...

Best regards,
Krzysztof


