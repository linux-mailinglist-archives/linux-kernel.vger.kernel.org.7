Return-Path: <linux-kernel+bounces-768591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EF8B262ED
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF17172CB5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207CF2F39A0;
	Thu, 14 Aug 2025 10:37:09 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224D92BDC2B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755167828; cv=none; b=S3uxL558Vamoa5Ax4TqtzmRjox9RQVDZq27mSRRj8psHBnAIMrRPY4yOtMfvpz7H4mCYZLblJ9kzC4FhhiK3dTrQXNRmiPHLSaizkiUpxgBPj1pQYZMzEBuRmJHOPtgSbWcL3ZPfmY7i/nfSWMqoq1yO4izRRFB/tz8VHpXgTXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755167828; c=relaxed/simple;
	bh=mtixfoi6sLuILNyQgWNCBpAeEhBntAaVb96j6pq/4d8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SRgHpWWmHqAavDARgm0rWOTZ/VgYGJsHY31MX3vy6lhYapW6SWF0Y6WuNVJicuqcLPKVKzHpws361O6+jzDmKWE1uWu8J6uBCZ9kSrjlFlPs7Z2uE8qADk9cBRehoVb1Kqnaq5G6Uv8Mp8oUr38TozghQLBNJwPXGZj+T1fl27k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umVKB-0007cz-7f; Thu, 14 Aug 2025 12:36:47 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umVK9-000Evw-1z;
	Thu, 14 Aug 2025 12:36:45 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umVK9-000Gbg-1f;
	Thu, 14 Aug 2025 12:36:45 +0200
Message-ID: <851f1c3d96988920a28412a26d5cd951b684c020.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] ASoC: spacemit: i2s: add support for K1 SoC
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>, Liam Girdwood
	 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, Jaroslav Kysela
	 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jinmei Wei <weijinmei@linux.spacemit.com>
Date: Thu, 14 Aug 2025 12:36:45 +0200
In-Reply-To: <20250814-k1-i2s-v1-2-c31149b29041@linux.spacemit.com>
References: <20250814-k1-i2s-v1-0-c31149b29041@linux.spacemit.com>
	 <20250814-k1-i2s-v1-2-c31149b29041@linux.spacemit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Do, 2025-08-14 at 16:54 +0800, Troy Mitchell wrote:
> Add ASoC platform driver for the SpacemiT K1 SoC full-duplex I2S
> controller.
>=20
> Co-developer: Jinmei Wei <weijinmei@linux.spacemit.com>
> Signed-off-by: Jinmei Wei <weijinmei@linux.spacemit.com>
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
>  sound/soc/Kconfig           |   1 +
>  sound/soc/Makefile          |   1 +
>  sound/soc/spacemit/Kconfig  |  14 ++
>  sound/soc/spacemit/Makefile |   5 +
>  sound/soc/spacemit/k1_i2s.c | 444 ++++++++++++++++++++++++++++++++++++++=
++++++
>  5 files changed, 465 insertions(+)
>=20
[...]
> diff --git a/sound/soc/spacemit/k1_i2s.c b/sound/soc/spacemit/k1_i2s.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..9e41525afbf3f08ab9a26b562=
772861d86f39cd7
> --- /dev/null
> +++ b/sound/soc/spacemit/k1_i2s.c
> @@ -0,0 +1,444 @@
[...]

> +static int spacemit_i2s_probe(struct platform_device *pdev)
> +{
> +	struct snd_soc_dai_driver *dai;
> +	struct spacemit_i2s_dev *i2s;
> +	struct resource *res;
> +	struct clk *clk;
> +	int ret;
> +
> +	i2s =3D devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
> +	if (!i2s)
> +		return -ENOMEM;
> +
> +	i2s->dev =3D &pdev->dev;
> +
> +	i2s->sysclk =3D devm_clk_get_enabled(i2s->dev, "sysclk");
> +	if (IS_ERR(i2s->sysclk))
> +		return dev_err_probe(i2s->dev, PTR_ERR(i2s->sysclk),
> +				     "failed to enable sysbase clock\n");
> +
> +	i2s->bclk =3D devm_clk_get_enabled(i2s->dev, "bclk");
> +	if (IS_ERR(i2s->bclk))
> +		return dev_err_probe(i2s->dev, PTR_ERR(i2s->bclk), "failed to enable b=
it clock\n");
> +
> +	clk =3D devm_clk_get_enabled(i2s->dev, "sspa_bus");
> +	if (IS_ERR(clk))
> +		return dev_err_probe(i2s->dev, PTR_ERR(clk), "failed to enable sspa_bu=
s clock\n");
> +
> +	i2s->sspa_clk =3D devm_clk_get_enabled(i2s->dev, "sspa");
> +	if (IS_ERR(clk))
> +		return dev_err_probe(i2s->dev, PTR_ERR(clk), "failed to enable sspa cl=
ock\n");
> +
> +	i2s->base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(i2s->base))
> +		return dev_err_probe(i2s->dev, PTR_ERR(i2s->base), "failed to map regi=
sters\n");
> +
> +	i2s->reset =3D  devm_reset_control_get(&pdev->dev, NULL);

Please use devm_reset_control_get_exclusive() directly.

> +	if (IS_ERR(i2s->reset))
> +		return dev_err_probe(i2s->dev, PTR_ERR(i2s->reset),
> +				     "failed to get reset control");
> +
> +	dev_set_drvdata(i2s->dev, i2s);
> +
> +	spacemit_i2s_init_dai(i2s, &dai, res->start + SSDATR);
> +
> +	ret =3D devm_snd_soc_register_component(i2s->dev,
> +					      &spacemit_i2s_component,
> +					      dai, 1);
> +	if (ret)
> +		return dev_err_probe(i2s->dev, ret, "failed to register component");
> +
> +	return devm_snd_dmaengine_pcm_register(&pdev->dev, &spacemit_dmaengine_=
pcm_config, 0);
> +}
> +
> +static void spacemit_i2s_remove(struct platform_device *pdev)
> +{
> +	struct spacemit_i2s_dev *i2s =3D dev_get_drvdata(&pdev->dev);
> +
> +	reset_control_assert(i2s->reset);

I'd move the reset_control_assert() be moved to snd_soc_dai_ops::remove
for symmetry.

regards
Philipp

