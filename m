Return-Path: <linux-kernel+bounces-886835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9C0C369B4
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9891A40C34
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1BC331A54;
	Wed,  5 Nov 2025 15:59:59 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD8E32936D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358398; cv=none; b=BTOvFmHYDvrroR8NEp+2XIT1X6ZK91wN2T3Krmg9ng9bcZFuodWTw+CGYz91dKtYAiDvKLeEbgQ35b84einMfAL76qo10NanYPWDkkCE9ua9SiPWOpXV1r+3HZigyNQ7pBqTWk2cXP2rLwUfSN2MtRzcaXrBxfvnWpzOUqvW3MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358398; c=relaxed/simple;
	bh=ktE4IhYWt1wVvNfWl1c8yWGTQIL8bEEHDZkBP60BHJ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SyP7mU4AGxk8UwcGUm0M04RiQcPKHvSB6mid/PveIqtGMcqwPdapmszaMzb4wCUg6aKhZE8kQxyoCE6yXBnrlk66g/KnNvImX+fLABHXC6PA9qbzUeFMaNvF3cah0aBK5rG8uEqyES8ddgZD15+9husr787u90tbYqseB+L4o8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vGfuv-0000Rf-LD; Wed, 05 Nov 2025 16:59:25 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vGfuu-007Djq-1i;
	Wed, 05 Nov 2025 16:59:24 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vGfuu-00000000CbV-1n3z;
	Wed, 05 Nov 2025 16:59:24 +0100
Message-ID: <180fcd1307af02eadc6136512ef78226bc7c00dd.camel@pengutronix.de>
Subject: Re: [PATCH v2 03/21] reset: rzv2h-usb2phy: Keep PHY clock enabled
 for entire device lifetime
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, 
	tomm.merciai@gmail.com
Cc: linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com, Vinod
 Koul	 <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob
 Herring	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley	 <conor+dt@kernel.org>, Fabrizio Castro
 <fabrizio.castro.jz@renesas.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Peter Rosin <peda@axentia.se>,
 Yoshihiro Shimoda	 <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>,  Magnus Damm <magnus.damm@gmail.com>, Arnd
 Bergmann <arnd@arndb.de>, Greg Kroah-Hartman	 <gregkh@linuxfoundation.org>,
 linux-phy@lists.infradead.org, 	devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 05 Nov 2025 16:59:24 +0100
In-Reply-To: <4b760e6e39679edd7f3d3a9a5b4babc7805ffe29.1762354366.git.tommaso.merciai.xr@bp.renesas.com>
References: <cover.1762354366.git.tommaso.merciai.xr@bp.renesas.com>
	 <4b760e6e39679edd7f3d3a9a5b4babc7805ffe29.1762354366.git.tommaso.merciai.xr@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
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

On Mi, 2025-11-05 at 16:38 +0100, Tommaso Merciai wrote:
> The driver was disabling the USB2 PHY clock immediately after register
> initialization in probe() and after each reset operation. This left the
> PHY unclocked even though it must remain active for USB functionality.
>=20
> The behavior appeared to work only when another driver
> (e.g., USB controller) had already enabled the clock, making operation
> unreliable and hardware-dependent. In configurations where this driver
> is the sole clock user, USB functionality would fail.
>=20
> Fix this by:
> - Enabling the clock once in probe() via pm_runtime_resume_and_get()
> - Removing all pm_runtime_put() calls from assert/deassert/status
> - Registering a devm cleanup action to release the clock at removal
> - Dropping the unnecessary rzv2h_usbphy_assert_helper() function
>=20
> This ensures the PHY clock remains enabled for the entire device lifetime=
,
> preventing instability and aligning with hardware requirements.
>=20
> Fixes: e3911d7f865b ("reset: Add USB2PHY port reset driver for Renesas RZ=
/V2H(P)")
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
> v1->v2:
>  - Improve commit body and commit msg
>  - Added Fixes tag
>  - Dropped unnecessary rzv2h_usbphy_assert_helper() function
>=20
>  drivers/reset/reset-rzv2h-usb2phy.c | 64 ++++++++---------------------
>  1 file changed, 18 insertions(+), 46 deletions(-)
>=20
> diff --git a/drivers/reset/reset-rzv2h-usb2phy.c b/drivers/reset/reset-rz=
v2h-usb2phy.c
> index ae643575b067..5bdd39274612 100644
> --- a/drivers/reset/reset-rzv2h-usb2phy.c
> +++ b/drivers/reset/reset-rzv2h-usb2phy.c
[...]
> @@ -175,14 +143,14 @@ static int rzv2h_usb2phy_reset_probe(struct platfor=
m_device *pdev)
>  	if (error)
>  		return dev_err_probe(dev, error, "pm_runtime_resume_and_get failed\n")=
;
> =20
> +	error =3D devm_add_action_or_reset(dev, rzv2h_usb2phy_reset_pm_runtime_=
put,
> +					 dev);
> +	if (error)
> +		return dev_err_probe(dev, error, "unable to register cleanup action\n"=
);
> +
>  	for (unsigned int i =3D 0; i < data->init_val_count; i++)
>  		writel(data->init_vals[i].val, priv->base + data->init_vals[i].reg);
> =20
> -	/* keep usb2phy in asserted state */
> -	rzv2h_usbphy_assert_helper(priv);

This change is not mentioned in the patch description.

Is initially asserting the reset not required after all?

regards
Philipp

