Return-Path: <linux-kernel+bounces-886684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AE2C36488
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CC1A4FD141
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7E5331A59;
	Wed,  5 Nov 2025 15:11:04 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FAA330B08
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355463; cv=none; b=gKPpI+4REHKEAjm19vCOt/OdhbfnQcn9rucS5lWPauxG5ipOKwBvSSV1u099idIg9qjp/+Ua3F8A0Bg2xR52lUWa3n2JbbLHGTxCSloF+q+FhsW++a9rz65heObLRWayWPdB+g5w+G8QQT+TcBM6OQEFnI/o8kX4Hk/jqL8C9JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355463; c=relaxed/simple;
	bh=d3PzBjpBc3NrY6lwFKuYJbSYNap7NQmfNsDB6KvX/OQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hVP92Eb099Axk0r89LplSM7yUADvbwDCihkPKskQL/xlgWxHsm2m0pWnL+0mgAk0rsTVhKUcgbo8epxcZ/aSAZpyqv7qsGuZnwsqr0AdlFMi8qtfftXb8FJ0OuzpeeZVRboC2ao90DK1jn1DNRVAD4R0hB8l2hAgvcgRhyh+Alc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vGf9m-0000mp-DL; Wed, 05 Nov 2025 16:10:42 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vGf9m-007Dbc-0b;
	Wed, 05 Nov 2025 16:10:42 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vGf9m-00000000BTa-0L37;
	Wed, 05 Nov 2025 16:10:42 +0100
Message-ID: <5922965da5a0dc1ff976bcbc1efcc9a7baa32934.camel@pengutronix.de>
Subject: Re: [PATCH v4 5/8] reset: imx8mp-audiomix: Switch to using regmap
 API
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>, Abel Vesa	
 <abelvesa@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen
 Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley	 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Fabio
 Estevam	 <festevam@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>,
 Shengjiu Wang	 <shengjiu.wang@nxp.com>, Frank Li <Frank.Li@nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev,
 devicetree@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,  Pengutronix Kernel Team	
 <kernel@pengutronix.de>
Date: Wed, 05 Nov 2025 16:10:41 +0100
In-Reply-To: <20251104120301.913-6-laurentiumihalcea111@gmail.com>
References: <20251104120301.913-1-laurentiumihalcea111@gmail.com>
	 <20251104120301.913-6-laurentiumihalcea111@gmail.com>
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

On Di, 2025-11-04 at 04:02 -0800, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>=20
> Switch to using the regmap API to allow performing register operations
> under the same lock. This is needed for cases such as i.MX8ULP's SIM LPAV
> where clock gating, reset control and MUX-ing is performed via the same
> register (i.e. SYSCTRL0) and different subsystem APIs.
>=20
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  drivers/reset/reset-imx8mp-audiomix.c | 93 +++++++++++++++++----------
>  1 file changed, 58 insertions(+), 35 deletions(-)
>=20
> diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-=
imx8mp-audiomix.c
> index e9643365a62c..18a7f68aa59f 100644
> --- a/drivers/reset/reset-imx8mp-audiomix.c
> +++ b/drivers/reset/reset-imx8mp-audiomix.c
> @@ -11,6 +11,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> =20
>  #define IMX8MP_AUDIOMIX_EARC_RESET_OFFSET	0x200
> @@ -42,8 +43,7 @@ static const struct imx8mp_reset_map reset_map[] =3D {
> =20
>  struct imx8mp_audiomix_reset {
>  	struct reset_controller_dev rcdev;
> -	spinlock_t lock; /* protect register read-modify-write cycle */
> -	void __iomem *base;
> +	struct regmap *regmap;
>  };
> =20
>  static struct imx8mp_audiomix_reset *to_imx8mp_audiomix_reset(struct res=
et_controller_dev *rcdev)
> @@ -55,26 +55,15 @@ static int imx8mp_audiomix_update(struct reset_contro=
ller_dev *rcdev,
>  				  unsigned long id, bool assert)
>  {
>  	struct imx8mp_audiomix_reset *priv =3D to_imx8mp_audiomix_reset(rcdev);
> -	void __iomem *reg_addr =3D priv->base;
> -	unsigned int mask, offset, active_low;
> -	unsigned long reg, flags;
> +	unsigned int mask, offset, active_low, shift, val;
> =20
>  	mask =3D reset_map[id].mask;
>  	offset =3D reset_map[id].offset;
>  	active_low =3D reset_map[id].active_low;
> +	shift =3D ffs(mask) - 1;
> +	val =3D (active_low ^ assert) << shift;

If you store the bit offset in the reset map, this can become

	mask =3D BIT(reset_map[id].bit);
	/* ... */
	val =3D (active_low ^ assert) << reset_map[id].bit;
=20

regards
Philipp

