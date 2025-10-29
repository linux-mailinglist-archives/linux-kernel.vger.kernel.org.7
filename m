Return-Path: <linux-kernel+bounces-877014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F188BC1CFD3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 30DDF4E1FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D022305E02;
	Wed, 29 Oct 2025 19:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="OYMw0sCH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PW6/T/Bo"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839532F0C6D;
	Wed, 29 Oct 2025 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761765670; cv=none; b=jp+9U/T9BUCE31cwIXdmN3OGmD9bFmvpPTe2tD4tNWzdIGSyQouXggdWKWrEeCebM9ewUV7+XtHjXxC9l0TVsSeM/V6Sd3gGqOj0HhvIOQ2RoI2tnzj3SuTyo5hu2BzBHfMqAI21xC3hni3TGG6iHFC+BPLCMvLYlnF6xMOx5us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761765670; c=relaxed/simple;
	bh=/lZWQ8dQnrk+7cil2nPb5OVfOQ/bThjdz+4WcFo8DS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daqOCN4A+6E5ImrkfugHzpUCZlF7qF8JSmQny0bA9iHwFUGLWUmvOOlVimRFqY+d8FAyfjjXQ5bn9xHnThTmHRrQV93CEVGmMv2mkRwO2rK5bHYDsLWQAmxI8aUFylAUVcHBfx3u89lIDfpp+JDpxFKb7i7rrUSOKrWe8esG5WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=OYMw0sCH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PW6/T/Bo; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id BAE7BEC0216;
	Wed, 29 Oct 2025 15:21:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 29 Oct 2025 15:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761765664; x=1761852064; bh=jem23dYJdF
	RhHLUSEWq8tu+ibq6sWJqXQQzANvsStpY=; b=OYMw0sCHij1zJaRlTY4YrR4JL+
	aekjErUkcj4MYndWo86jBl5sr3A4VGbafACxivi3A77xvglutrG3himNHGHsM/cJ
	h63Jz/C0wvMrNiN8eNXfiWPdQa2O8seVGMMqsK8Opq4/5DxWv7FsNSs3d8MBOtf1
	LQJxO/1fJUIpN5eLwBHNeJp0qbmUSBdRVGz2emWzbKDx2esVqLy0BdT664W9jn0z
	jic9fuDw7ThInXUkyw7B8lVqJNBE3kvIZpEPSoI4B5D1sX5p3rzW3fqT+U44XiLD
	h1PJWTjCvxF4wwVNDzNhkfdRdrgzrLdY3FNPeIvDWQBJu6Oa7F3uLItIcmWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761765664; x=1761852064; bh=jem23dYJdFRhHLUSEWq8tu+ibq6sWJqXQQz
	ANvsStpY=; b=PW6/T/BobTSrujnjEzRH2re4C+q8SOtvPVnXWrJm3MOpWtEMHTc
	pHq08V22b8fO/IFhpodR6NScUdy4/6T4Y/Tjm53tUDobp8nAfcEtSm9xsv0i+Jy6
	MMDtsUMTYIIE29YZyLQZTLDaVlgsDYjhWvUwHePKaFE/o1riq55Z4zLbhEbgYY/I
	zUTB8MKlqyzhU1pmUwCBLOke1mohnVkkew4fStOaSDoRljOi62Mlk64I02OP8sXC
	jeoIl+mlNO4pWayZwMKuDmCl3wtgZP06R5YahGSy85OD7JlvWCB2YdbSXSWvLgaP
	2zE7R9pYmMKBNWQJS2VU3Cufiub9l0JPmXg==
X-ME-Sender: <xms:H2kCaTdvuR0Quaz_Wa7neXmxc2yCbsoUhbUEpKuVZPBN3rxfVXE0bQ>
    <xme:H2kCaTnZyAG8DvX8Pu6MD5IAIUT8hkNaaMAip_s4V5mBLwHA0Js4GunpHLHeI8b7t
    Q7e8sAO1Ks3kmRb9U0Mry2St9hi9kB3LLITQTCeSy9y2S2NUY2RwCQ>
X-ME-Received: <xmr:H2kCaSpTAJF-us1M4W0Zzv-w8F7V5BdN3nB0GeSuh-v-TdKPp_dtSTGaSDSzpbHHPgNo5Zbd4zIcFxIqif-DlBpAuI_3UAt2LwY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieegheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomheplfgrnhhnvgcu
    ifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpefgvd
    ffveelgedujeeffeehheekheelheefgfejffeftedugeethfeuudefheefteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruh
    drnhgvthdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsvhgvnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvrghlsehgohhmph
    grrdguvghvpdhrtghpthhtohepvhhkohhulheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepkhhishhhohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprd
    iirggsvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegrshgrhhhisehl
    ihhsthhsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:H2kCaQFJ-jlPTf321gWn7Ew0QtFozD-QEP9H0RpWgKVsxbJjB4_uhQ>
    <xmx:H2kCaYQAP0zaeNvQOkcDooS1okPvh1ZolGl5OpviAFEGdPPVicVwhA>
    <xmx:H2kCaWNDpDaB4ehDJBvCjoycEcXE51rVm0JvXlYD5S1OZah-b9h2lg>
    <xmx:H2kCaVkTozJx0mtR3rat_6VW88AtmdNYGQ_pvk5Fmb12aYWjq8c_ww>
    <xmx:IGkCaXHxT7V8XajSIX1xktYOLXAnFQiuscZ5xiV8m9ksndsw1qA8lfb0>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 15:21:02 -0400 (EDT)
Date: Wed, 29 Oct 2025 20:21:01 +0100
From: Janne Grunau <j@jannau.net>
To: Sven Peter <sven@kernel.org>
Cc: Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH 1/3] soc: apple: Add hardware tunable support
Message-ID: <20251029192101.GA458701@robin.jannau.net>
References: <20251026-b4-atcphy-v1-0-f81b1225f9c6@kernel.org>
 <20251026-b4-atcphy-v1-1-f81b1225f9c6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251026-b4-atcphy-v1-1-f81b1225f9c6@kernel.org>

Hej,

On Sun, Oct 26, 2025 at 01:52:01PM +0000, Sven Peter wrote:
> Various hardware, like the Type-C PHY or the Thunderbolt/USB4 NHI,
> present on Apple SoCs need machine-specific tunables passed from our
> bootloader m1n1 to the device tree. Add generic helpers so that we
> don't have to duplicate this across multiple drivers.
> 
> Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Sven Peter <sven@kernel.org>
> ---
>  drivers/soc/apple/Kconfig         |  4 +++
>  drivers/soc/apple/Makefile        |  3 ++
>  drivers/soc/apple/tunable.c       | 71 +++++++++++++++++++++++++++++++++++++++
>  include/linux/soc/apple/tunable.h | 60 +++++++++++++++++++++++++++++++++
>  4 files changed, 138 insertions(+)
> 
> diff --git a/drivers/soc/apple/Kconfig b/drivers/soc/apple/Kconfig
> index ad67368892311bed5a94d358288390a6fb8b3b4a..d0ff32182a2b4a10c98cb96c70a03bea8c650f84 100644
> --- a/drivers/soc/apple/Kconfig
> +++ b/drivers/soc/apple/Kconfig
> @@ -38,6 +38,10 @@ config APPLE_SART
>  
>  	  Say 'y' here if you have an Apple SoC.
>  
> +config APPLE_TUNABLE
> +	tristate
> +	depends on ARCH_APPLE || COMPILE_TEST
> +
>  endmenu
>  
>  endif
> diff --git a/drivers/soc/apple/Makefile b/drivers/soc/apple/Makefile
> index 4d9ab8f3037b7159771d8817fa507ba29f99ae10..0b85ab61aefe131349a67d0aa80204edd8e89925 100644
> --- a/drivers/soc/apple/Makefile
> +++ b/drivers/soc/apple/Makefile
> @@ -8,3 +8,6 @@ apple-rtkit-y = rtkit.o rtkit-crashlog.o
>  
>  obj-$(CONFIG_APPLE_SART) += apple-sart.o
>  apple-sart-y = sart.o
> +
> +obj-$(CONFIG_APPLE_TUNABLE) += apple-tunable.o
> +apple-tunable-y = tunable.o
> diff --git a/drivers/soc/apple/tunable.c b/drivers/soc/apple/tunable.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..c54da8ef28cef16118c518c761f95e8dd9f78002
> --- /dev/null
> +++ b/drivers/soc/apple/tunable.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Apple Silicon hardware tunable support
> + *
> + * Each tunable is a list with each entry containing a offset into the MMIO
> + * region, a mask of bits to be cleared and a set of bits to be set. These
> + * tunables are passed along by the previous boot stages and vary from device
> + * to device such that they cannot be hardcoded in the individual drivers.
> + *
> + * Copyright (C) The Asahi Linux Contributors
> + */
> +
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/soc/apple/tunable.h>
> +
> +struct apple_tunable *devm_apple_tunable_parse(struct device *dev,
> +					       struct device_node *np,
> +					       const char *name)
> +{
> +	struct apple_tunable *tunable;
> +	struct property *prop;
> +	const __be32 *p;
> +	size_t sz;
> +	int i;
> +
> +	prop = of_find_property(np, name, NULL);
> +	if (!prop)
> +		return ERR_PTR(-ENOENT);
> +
> +	if (prop->length % (3 * sizeof(u32)))
> +		return ERR_PTR(-EINVAL);
> +	sz = prop->length / (3 * sizeof(u32));
> +
> +	tunable = devm_kzalloc(dev,
> +			       sizeof(*tunable) + sz * sizeof(*tunable->values),

There is a struct_size macro in linux/overflow.h for this calculation.
We do not have to care about overflows as as struct property.length
remains (signed) int. I would expect there is a much smaller limit for of
properties in place anyway. The macro looks nicer though:

struct_size(tunable, values, sz)

> +			       GFP_KERNEL);
> +	if (!tunable)
> +		return ERR_PTR(-ENOMEM);
> +	tunable->sz = sz;
> +
> +	for (i = 0, p = NULL; i < tunable->sz; ++i) {
> +		p = of_prop_next_u32(prop, p, &tunable->values[i].offset);

Does it make sense to add an size argument either here or in
apple_tunable_apply() to check that the offset is within the expect MMIO
region? Not really important but might catch a bug someday.

> +		p = of_prop_next_u32(prop, p, &tunable->values[i].mask);
> +		p = of_prop_next_u32(prop, p, &tunable->values[i].value);
> +	}
> +
> +	return tunable;
> +}
> +EXPORT_SYMBOL(devm_apple_tunable_parse);
> +
> +void apple_tunable_apply(void __iomem *regs, struct apple_tunable *tunable)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < tunable->sz; ++i) {
> +		u32 val, old_val;
> +
> +		val = old_val = readl_relaxed(regs + tunable->values[i].offset);
> +		val &= ~tunable->values[i].mask;
> +		val |= tunable->values[i].value;
> +		if (val != old_val)
> +			writel_relaxed(val, regs + tunable->values[i].offset);
> +	}
> +}
> +EXPORT_SYMBOL(apple_tunable_apply);
> +
> +MODULE_LICENSE("Dual MIT/GPL");
> +MODULE_AUTHOR("Sven Peter <sven@kernel.org>");
> +MODULE_DESCRIPTION("Apple Silicon hardware tunable support");
> diff --git a/include/linux/soc/apple/tunable.h b/include/linux/soc/apple/tunable.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..7e74e81b32e56c9a8ce94cb64bb340b007bac8da
> --- /dev/null
> +++ b/include/linux/soc/apple/tunable.h
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
> +/*
> + * Apple Silicon hardware tunable support
> + *
> + * Each tunable is a list with each entry containing a offset into the MMIO
> + * region, a mask of bits to be cleared and a set of bits to be set. These
> + * tunables are passed along by the previous boot stages and vary from device
> + * to device such that they cannot be hardcoded in the individual drivers.
> + *
> + * Copyright (C) The Asahi Linux Contributors
> + */
> +
> +#ifndef _LINUX_SOC_APPLE_TUNABLE_H_
> +#define _LINUX_SOC_APPLE_TUNABLE_H_
> +
> +#include <linux/device.h>
> +#include <linux/types.h>
> +
> +/**
> + * Struct to store an Apple Silicon hardware tunable.
> + *
> + * Each tunable is a list with each entry containing a offset into the MMIO
> + * region, a mask of bits to be cleared and a set of bits to be set. These
> + * tunables are passed along by the previous boot stages and vary from device
> + * to device such that they cannot be hardcoded in the individual drivers.
> + *
> + * @param sz Number of [offset, mask, value] tuples stored in values.
> + * @param values [offset, mask, value] array.
> + */
> +struct apple_tunable {
> +	size_t sz;
> +	struct {
> +		u32 offset;
> +		u32 mask;
> +		u32 value;
> +	} values[] __counted_by(sz);
> +};
> +
> +/**
> + * Parse an array of hardware tunables from the device tree.
> + *
> + * @dev: Device node used for devm_kzalloc internally.
> + * @np: Device node which contains the tunable array.
> + * @name: Name of the device tree property which contains the tunables.
> + *
> + * @return: devres allocated struct on success or PTR_ERR on failure.
> + */
> +struct apple_tunable *devm_apple_tunable_parse(struct device *dev,
> +					       struct device_node *np,
> +					       const char *name);
> +
> +/**
> + * Apply a previously loaded hardware tunable.
> + *
> + * @param regs: MMIO to which the tunable will be applied.
> + * @param tunable: Pointer to the tunable.
> + */
> +void apple_tunable_apply(void __iomem *regs, struct apple_tunable *tunable);
> +
> +#endif

Reviewed-by: Janne Grunau <j@jannau.net>

Janne

