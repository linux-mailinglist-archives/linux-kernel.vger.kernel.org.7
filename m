Return-Path: <linux-kernel+bounces-809810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEDFB5124D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526B2463E27
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2CC313E13;
	Wed, 10 Sep 2025 09:18:03 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE282877E9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757495883; cv=none; b=f8tmTam3+aVntIn8mv+nsK1pyPTTt7S5WLoz6MxyhEqaZNQBkZ6cCcJHSdDKDRrNJdKYHvmZln1R6Kse+P/oUTeniXNwxBepLFasYnuDOGbw9hzVgzGAUX9WhXMx5TK6oh8BWeuhrto6p/arm54sQ6NldYRXYyzAgqI+f3wTOG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757495883; c=relaxed/simple;
	bh=aX8Pf9ddMfci242FHyX4blRsVEE0teAgfojzmfOU8Vk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Eu9rdZe4jNU7phwJvaVjDXe4w54HwrsmiGNJDTpIkahJmxcHoePf/mKchoYhVtb3EWOwZx5R8pVrKQzDoEhytPgD+oOH+ooBYqTPt4FDz3DPZnrP3pM0VQt715dgupCW8I8D0fECwCDPWfuczyIids1dA7vZrMzOgadTj5BWvBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uwGxc-000560-GV; Wed, 10 Sep 2025 11:17:52 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uwGxb-000ZEw-2M;
	Wed, 10 Sep 2025 11:17:51 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uwGxb-0007LM-27;
	Wed, 10 Sep 2025 11:17:51 +0200
Message-ID: <94ce63da0edee178a49781b2c6ac9a863f13333f.camel@pengutronix.de>
Subject: Re: [PATCH v2 04/11] phy: renesas: Add Renesas RZ/G3E USB3.0 PHY
 driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Biju <biju.das.au@gmail.com>, Vinod Koul <vkoul@kernel.org>, Kishon
 Vijay Abraham I <kishon@kernel.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-renesas-soc@vger.kernel.org, Prabhakar
	Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Date: Wed, 10 Sep 2025 11:17:51 +0200
In-Reply-To: <20250909180803.140939-5-biju.das.jz@bp.renesas.com>
References: <20250909180803.140939-1-biju.das.jz@bp.renesas.com>
	 <20250909180803.140939-5-biju.das.jz@bp.renesas.com>
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

On Di, 2025-09-09 at 19:07 +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Add Renesas RZ/G3E USB3.0 PHY driver. This module is connected
> between USB3 Host and PHY module. The main functions of this
> module are:
>  1) Reset control
>  2) Control of PHY input pins
>  3) Monitoring of PHY output pins
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Replaced magic numbers with macros.
> ---
>  drivers/phy/renesas/Kconfig          |   7 +
>  drivers/phy/renesas/Makefile         |   1 +
>  drivers/phy/renesas/phy-rzg3e-usb3.c | 271 +++++++++++++++++++++++++++
>  3 files changed, 279 insertions(+)
>  create mode 100644 drivers/phy/renesas/phy-rzg3e-usb3.c
>=20
[...]
> diff --git a/drivers/phy/renesas/phy-rzg3e-usb3.c b/drivers/phy/renesas/p=
hy-rzg3e-usb3.c
> new file mode 100644
> index 000000000000..6463519b2c22
> --- /dev/null
> +++ b/drivers/phy/renesas/phy-rzg3e-usb3.c
> @@ -0,0 +1,271 @@
[...]
> +static int rzg3e_phy_usb3_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct phy_provider *provider;
> +	struct rz_usb3 *r;
> +	struct phy *phy;
> +	int ret;
> +
> +	r =3D devm_kzalloc(dev, sizeof(*r), GFP_KERNEL);
> +	if (!r)
> +		return -ENOMEM;
> +
> +	r->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(r->base))
> +		return PTR_ERR(r->base);
> +
> +	r->rstc =3D devm_reset_control_get_shared(dev, NULL);
> +	if (IS_ERR(r->rstc))
> +		return dev_err_probe(dev, PTR_ERR(r->rstc), "failed to get reset\n");
> +
> +	ret =3D reset_control_deassert(r->rstc);
> +	if (ret)
> +		return ret;

It looks like you should be able to use
devm_reset_control_get_shared_deasserted() and let devres handle reset
control assertion on error and driver removal.

As is, the driver is missing a reset_control_assert() in the probe
error paths.


regards
Philipp

