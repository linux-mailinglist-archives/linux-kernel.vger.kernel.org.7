Return-Path: <linux-kernel+bounces-687889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4498BADAA84
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 10:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266393B083F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 08:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A1226D4E5;
	Mon, 16 Jun 2025 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhV+NdKf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AA31BF33F;
	Mon, 16 Jun 2025 08:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750061824; cv=none; b=SR4k24q+tAzL/6SMMdzAJm2ADbjHNl8GeYK7wTPpsADGg/qfhsZTSX1uNQsEeKL7jMUz9GxMR+IRfhXMtv4tPMxtQjiakoEboO7yNKy2R+qNYLyVbkAAx1KzvgzuOORJMq+Nwl0McH8octSRlmlnN/4lmd9TYkhRmL3vp9QPmEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750061824; c=relaxed/simple;
	bh=Pv+qRkMsv9lRRwPOjtQx71ZyCSusRSw8Q6iZKmn358g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHsNmkGBrFAb9A6tIJ7JVPbqkDJTr/EUF7vv/rDnq/yDi11F9UFs2IvhCNIaos3j3+FwuypwKiArNGap6tLIOzjRmNDdl65slPMTbqIULzzjowov5AfZlwxhnsoX5kvhZ3DbBxOYMpYgQKvM4HqfiV/tajre9T0i+0zaDPr5sGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhV+NdKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF3AC4CEEA;
	Mon, 16 Jun 2025 08:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750061823;
	bh=Pv+qRkMsv9lRRwPOjtQx71ZyCSusRSw8Q6iZKmn358g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fhV+NdKfZ+tv9iKOkcX2Fd/stsEHXlDLgbZZ1aubgk+935jgjOEEqSk2W9BrwD/OR
	 6teDMlggVHffNW4Jm5wlNJ2W4lhC+fBpKnDcwBn8gUMp25sUGGYvJwssbLFIMaldEh
	 rBM1XkrKFROhYfMBBWfssLhA8im15DlDYFes0JdtdhE3TaoKU5s7MVHi11hRDTSlYt
	 wM1rgqK1Z1MctNHjdj8mX6nB2323Z8utUD4RFbt4pGX3Md9S5aDGam+S6vASYAZyXn
	 8/WtLhVc3Aobu9fB1lf3fA9TzR5henk8IPvX1zTD2Q0+2VeM3rMmGQcsIINcksIkuT
	 U+K5g7h9GRLdA==
Date: Mon, 16 Jun 2025 10:17:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Pritam Manohar Sutar <pritam.sutar@samsung.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, kauschluss@disroot.org, 
	ivo.ivanov.ivanov1@gmail.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, rosa.pila@samsung.com, 
	dev.tailor@samsung.com, faraz.ata@samsung.com, muhammed.ali@samsung.com, 
	selvarasu.g@samsung.com
Subject: Re: [PATCH v3 5/9] phy: exyons5-usbdrd: support HS combo phy for
 ExynosAutov920
Message-ID: <20250616-proud-statuesque-polecat-616eaf@kuoka>
References: <20250613055613.866909-1-pritam.sutar@samsung.com>
 <CGME20250613055053epcas5p377269bcc2c8567c00a2298d86c0d26a4@epcas5p3.samsung.com>
 <20250613055613.866909-6-pritam.sutar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250613055613.866909-6-pritam.sutar@samsung.com>

On Fri, Jun 13, 2025 at 11:26:09AM GMT, Pritam Manohar Sutar wrote:
> +static const struct
> +exynos5_usbdrd_phy_config usbdrd_hsphy_cfg_exynosautov920[] = {
> +	{
> +		.id		= EXYNOS5_DRDPHY_UTMI,
> +		.phy_init	= exynosautov920_usbdrd_utmi_init,
> +	},
> +};
> +
> +static const struct exynos5_usbdrd_phy_drvdata exynosautov920_usbdrd_hsphy = {
> +	.phy_cfg		= usbdrd_hsphy_cfg_exynosautov920,
> +	.phy_ops		= &exynosautov920_usb31drd_phy_ops,
> +	.clk_names		= exynos5_clk_names,
> +	.n_clks			= ARRAY_SIZE(exynos5_clk_names),
> +	.core_clk_names		= exynos5_core_clk_names,
> +	.n_core_clks		= ARRAY_SIZE(exynos5_core_clk_names),
> +};

Same questions: where are all other fields and resources?

Best regards,
Krzysztof


