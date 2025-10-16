Return-Path: <linux-kernel+bounces-856918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFFCBE572C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 221A91A66598
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8992DEA9B;
	Thu, 16 Oct 2025 20:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="hJywZz2S"
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EFD2580FF
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647787; cv=none; b=kwOAVW7QHDLvtY7Fku2CLrOybESQlhduLLFBbpaPlegV5RSxLPSzAeQ4zJHBOLviXKU3bItKSB0Fvw/tmsMDFeVjkQpejB1hALtv3xD6FuV/lZD71RsquRynhami4x0eh2+C4wzo6pMz1IXtj6PqPysHMoKPOcrFBojDXi1CeLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647787; c=relaxed/simple;
	bh=lVwUfcJjwqozg3yRAeO8p/S9+vytw+qaVahy2PtQA3I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WCndyZIpFmIxqe6Kf627KRAaRs6thKFmr19nrwg6bCPE7uvuERO+QDmhxuLvJOMBVQl00bl61ZDbQsP5LWuCyxzLf8cZIKMSB21FyJn3tFjsn+Hp4bEb/IDi+QXsTDVzaSYGDpo0dTmCMn3x69dqFDqNYyLhBHf3k5CL59sucXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=hJywZz2S; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Received: from [IPv6:2a02:1812:162c:8f00:1e2d:b404:3319:eba8] (2a02-1812-162c-8f00-1e2d-b404-3319-eba8.ip6.access.telenet.be [IPv6:2a02:1812:162c:8f00:1e2d:b404:3319:eba8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id 034F06866DD;
	Thu, 16 Oct 2025 22:49:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1760647783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lVwUfcJjwqozg3yRAeO8p/S9+vytw+qaVahy2PtQA3I=;
	b=hJywZz2SSkfy7C/wm0/M+7655s5mSuy4nrDHsqh/YAsOV+22R50eaELq40/zP1dyQrb1oH
	dIew+OBDdBH21Kafl10bRr1ds4usjaolnS7YGwZyABiPD1LkrF5MzK7omDbNw8FQ2kBUva
	n0+IRAQIYEEpbdNFxc6akGCRtRxu0a67wvu6b9IwACkzyZk8Klgg19M/w3HoTOHD4UAEbo
	HwuWW1cjsNcpGZTZLHc5NIwaG2CXdJYm8pc5tfyNYkkbU6VQTo/7oYEHoVQFqA193r0LO0
	rWbjiPZWmIbE5I9wyQT76DYOevco3bIpWrImbZRcPNpm9wQTpiMNINOJrSjpvQ==
Message-ID: <baaa378164ae45c43a521eca467b49e0eda38818.camel@svanheule.net>
Subject: Re: [PATCH v3] regmap: add cache validity to REGCACHE_FLAT
From: Sander Vanheule <sander@svanheule.net>
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	 <rafael@kernel.org>, linux-kernel@vger.kernel.org
Date: Thu, 16 Oct 2025 22:49:40 +0200
In-Reply-To: <143f0597-7cfa-4b16-ada9-72922f566284@sirena.org.uk>
References: <20250109180256.6269-1-sander@svanheule.net>
	 <a2f7e2c3-f072-40f7-a865-5693b82b636e@sirena.org.uk>
	 <0b2fa71f1ccd49d66ca02b6c44ba8fe2135e9b6f.camel@svanheule.net>
	 <ca528e3e-39f1-41cc-9f46-ad787af48a77@sirena.org.uk>
	 <187bc058ff944dbde0e876efa6e72046bcc2a124.camel@svanheule.net>
	 <143f0597-7cfa-4b16-ada9-72922f566284@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-16 at 14:55 +0100, Mark Brown wrote:
> On Thu, Oct 16, 2025 at 02:08:41PM +0200, Sander Vanheule wrote:
> > This difference in caching behavior isn't (wasn't) immediately clear to=
 me from
> > the documentation. Don't the different cache types exist to optimize sp=
eed or
> > memory for different use-cases? Because then I would only expect differ=
ences in
> > memory/speed, not in way the cache is initialized.
>=20
> The flat cache is a bit of a sharp edge, it's specifically there to be
> the absolute bare minimum cache.=C2=A0 It's there mainly for MMIO devices
> that are on the edge of being able to use regmap at all for performance
> reasons, and as a simple way of guaranteeing that we never do any
> allocations at runtime for things that do register access in hardirq
> context.
>=20
> The documentation could definitely use some improvement here.

The proposed patch also won't perform any allocations outside of the regmap
initialization. There is the additional overhead of checking a bitmap, yes,=
 but
that's probably not a huge problem if the main issue are the allocations?

A number of REGCACHE_FLAT users provide only num_reg_defaults_raw. That loo=
ked
strange to me, because why would a user provide a buffer size, but no buffe=
r?
This even conflicts with the documentation, as "Number of elements in
reg_defaults_raw" doesn't make sense if reg_defaults_raw is NULL. As you ar=
e
probably aware, this configuration causes the regmap init to read registers=
 from
the device to generate a default state, which is then used to fill the flat
cache. So this effectively replaces the (invalid) zero-initialization. What
feels problematic to me, is that only the flat cache requires this sort of
"hack" for it to contain values that correctly reflect the hardware state.

Some quick grepping turned up 35 drivers which use REGCACHE_FLAT without an=
y
cache initialization (see below), thus defaulting to the all-zero cache. Th=
is
includes the driver I think you found issues with on the pine64: sun8i-code=
c.c
If this driver (accidentally) relies on the zero-initialization, I would ex=
pect
the spurious interrupts to also pop up when switching to a maple cache, or =
when
using the num_reg_defaults_raw workaround.

drivers/clk/clk-si521xx.c
drivers/gpio/gpio-104-dio-48e.c
drivers/gpio/gpio-104-idio-16.c
drivers/gpio/gpio-gpio-mm.c
drivers/gpio/gpio-pcie-idio-24.c
drivers/gpio/gpio-pci-idio-16.c
drivers/gpio/gpio-ws16c48.c
drivers/gpu/drm/panel/panel-abt-y030xx067a.c
drivers/gpu/drm/panel/panel-novatek-nt39016.c
drivers/i2c/muxes/i2c-mux-ltc4306.c
drivers/iio/addac/stx104.c
drivers/iio/health/max30100.c
drivers/mfd/sec-i2c.c
drivers/platform/mellanox/mlxreg-dpu.c
drivers/pwm/pwm-fsl-ftm.c
sound/soc/atmel/mchp-pdmc.c
sound/soc/atmel/mchp-spdifrx.c
sound/soc/atmel/mchp-spdiftx.c
sound/soc/bcm/bcm63xx-i2s-whistler.c
sound/soc/codecs/msm8916-wcd-digital.c
sound/soc/loongson/loongson_i2s_pci.c
sound/soc/loongson/loongson_i2s_plat.c
sound/soc/qcom/lpass-cpu.c
sound/soc/rockchip/rockchip_spdif.c
sound/soc/soc-ops-test.c
sound/soc/stm/stm32_sai_sub.c
sound/soc/sunxi/sun8i-codec.c
sound/soc/tegra/tegra20_ac97.c
sound/soc/tegra/tegra20_das.c
sound/soc/tegra/tegra20_i2s.c
sound/soc/tegra/tegra20_spdif.c
sound/soc/tegra/tegra210_ahub.c
sound/soc/tegra/tegra30_ahub.c
sound/soc/tegra/tegra30_i2s.c
sound/soc/xtensa/xtfpga-i2s.c

