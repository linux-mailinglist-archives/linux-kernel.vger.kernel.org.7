Return-Path: <linux-kernel+bounces-694072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C71AE0791
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 15:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA7915A01F2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 13:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA9328AB0B;
	Thu, 19 Jun 2025 13:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="jQcBGJRu"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF84727FD52;
	Thu, 19 Jun 2025 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750340095; cv=pass; b=SovCxEw6M2dQW3oiNotPUji9nropae7EIE7N4mGYx3ZL/UPZAdBAnU7fVLSzhP2oDFHjOhZ+TFy0306CbcbOuKY4XO2ylepMPAS8lxO4fD9SCoimSmZbzlsssixFGGLCcRGs0nFoLmMImInE5TMqgXRztYs2rmfCBbdkJnxBPt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750340095; c=relaxed/simple;
	bh=443Z6E4g/QcpNFZCPHQalahwOSfhqo9xI2hsDri6FUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXoCxNwin4s+bgWNAw5ru7U1bOdT8u8inLT519pLHnYZ0hEecvAb58w0/R5p6GOBHvtKfhKiDrKnVs6B+Y14sHnYiK5i6G84PYkT4xa8czL0uqBx9Fsna8mnptopImQBu6ijBbHStIBoIPi8zt2iOAlJZIdNKjiUBfqolWvoFMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=jQcBGJRu; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750340072; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QQsSrN4Dkjsu5zTv7CLcp2MysHYWKvRp55QFeGAgNKlql/zQHvYu+AOh6QPwWftbJAaGpfLXJ+8cv+/Zx7hr+mLBEeqZuuAYI3lRV5RbePLXFMEMnYbHdbLeHiYuxrBZwUGS/kv5MTwgZohm57t7sHcIuT2+7dCf6Bop4+FJEGc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750340072; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qWNEcMBoxu8wUH3B/aSwOcDmxt4JxKtTOFWBvNpr6T4=; 
	b=PMEQKHu0UwJn5LBzFo6dwmsa5MR8YiXKxeNBEE7DabwhaSeycq5JZ5oqjb/bOVQZDQ1vLQ3YQsGjgymzf+rrrBsMm4LfQc2S2txvZInKbVBYWA4dDncjM1vmEd1qNY6EsfGsxgUtES72mIj9Srj4nmFU3IIVET99W+UjDKhsl8c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750340072;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=qWNEcMBoxu8wUH3B/aSwOcDmxt4JxKtTOFWBvNpr6T4=;
	b=jQcBGJRu6QaEZqEhNDwkfp6y3DPalwwRYLWgZ9K0i5BdSEbx21Q5gEYmVhs3T4u4
	7QJn22A1cC/OX06PNaGMlEtwlSdtc+0hFIHZOoAhmPG/pMH4+MYcpjMVfyrBSHxbKJk
	mC/bC5LVD/D3DSSoNJwBG+Xbcjb4DH2bRLQireBI=
Received: by mx.zohomail.com with SMTPS id 1750340070603195.6541748579583;
	Thu, 19 Jun 2025 06:34:30 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id E8BE21805A8; Thu, 19 Jun 2025 15:34:26 +0200 (CEST)
Date: Thu, 19 Jun 2025 15:34:26 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Andy Yan <andyshrk@163.com>
Cc: neil.armstrong@linaro.org, conor+dt@kernel.org, 
	quic_jesszhan@quicinc.com, krzk+dt@kernel.org, robh@kernel.org, tzimmermann@suse.de, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH 2/2] drivers/panel: raydium-rm67200: Make reset-gpio
 optional
Message-ID: <ydqx6qhm53m5p7g3ust7jsdaftqugdfp65m223zoo6awy5qsgb@s4fzof6e3oh2>
References: <20250616070536.670519-1-andyshrk@163.com>
 <20250616070536.670519-2-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bguhyq47rfsodvla"
Content-Disposition: inline
In-Reply-To: <20250616070536.670519-2-andyshrk@163.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/250.326.2
X-ZohoMailClient: External


--bguhyq47rfsodvla
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] drivers/panel: raydium-rm67200: Make reset-gpio
 optional
MIME-Version: 1.0

Hi,

On Mon, Jun 16, 2025 at 03:05:17PM +0800, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
>=20
> Although the datasheet of the panel module describes that it has a
> reset pin, in the actual hardware design, we often use an RC circuit
> to control the reset, and rarely use GPIO to control the reset. This
> is the way it is done on our numerous development boards (such as
> RK3568/RK3576 EVB).
>=20
> So make the reset-gpio optional.
>=20
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

>=20
>  drivers/gpu/drm/panel/panel-raydium-rm67200.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panel/panel-raydium-rm67200.c b/drivers/gpu/=
drm/panel/panel-raydium-rm67200.c
> index 205273163cb97..add6099ae8a64 100644
> --- a/drivers/gpu/drm/panel/panel-raydium-rm67200.c
> +++ b/drivers/gpu/drm/panel/panel-raydium-rm67200.c
> @@ -36,12 +36,14 @@ static inline struct raydium_rm67200 *to_raydium_rm67=
200(struct drm_panel *panel
> =20
>  static void raydium_rm67200_reset(struct raydium_rm67200 *ctx)
>  {
> -	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> -	msleep(60);
> -	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> -	msleep(60);
> -	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> -	msleep(60);
> +	if (ctx->reset_gpio) {
> +		gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +		msleep(60);
> +		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +		msleep(60);
> +		gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +		msleep(60);
> +	}
>  }
> =20
>  static void raydium_rm67200_write(struct mipi_dsi_multi_context *ctx,
> @@ -412,7 +414,7 @@ static int raydium_rm67200_probe(struct mipi_dsi_devi=
ce *dsi)
>  	if (ret < 0)
>  		return ret;
> =20
> -	ctx->reset_gpio =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +	ctx->reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW=
);
>  	if (IS_ERR(ctx->reset_gpio))
>  		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
>  				     "Failed to get reset-gpios\n");
> --=20
> 2.43.0
>=20
> base-commit: 8c98c2c9ebeaa472e742d664b714aed5ab7c6f53
> branch: rk356x_rk3588_rk3576_dsi
>=20

--bguhyq47rfsodvla
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmhUEd4ACgkQ2O7X88g7
+poOug//apfY0XCMcV2DAO++NpXT0RHAyq8Aj7isCoLxs4sNs+S5ig+hPf0Fa139
fIkh8M6UcsNxlxu5/0nDTkf3tVtqANFjWaoCNoPnM8XJpISGJKXnuBKBIIh/kfLs
TbqXX2+Yg1l6lhDcSkDmahIp2zCg2Cz9t4vlbCKesgXb50paD0KRoHnWEcC6rK5N
0NayI5m7a9k12Ptdxkdy6vOz0YIa3JmzbAHH38zOHswNaIXNRJUqh43vIWXwZ/pg
A0Px1vXXnjqxxnbd6HFqMJUtWwiQ8BtxIyQ4uY8A1EtCHvEIMTsIRXIkM44dg83r
5s324sv3xeNh8nffl4oUVg+imgDi4PC3yWq9BygwmCp/0wgze+Wbgjhc5IL2HCu0
tzrl5nuN2zYIp8gJoqZBiEFcb2KyjPPVgKWAbYCbEhJawSOZSiiyg5n7+8WMG2Np
dUKzUGsjkGOk4fGA4gGPP4jRoaiKmHwahTLYQ01UFZdWI5fUg6JSmnXhkbKclruX
kQWLzjDwlGXdzdoB/NfJ0yZJa5cwp/P2nvUhSGHRWVY3uQCW6Op93m7E5WwsKUm3
b/50D1hN1gihDWoF4INM/JfQqXVwnMO5Fh/Y30d3Wo6+dYtZ4aqe/f1kodwDFW3A
FunJeIG7TCAcXTVSMLWc2zL0vuUfH4Ba6U3Yf+buu40nmstgbmQ=
=Rm48
-----END PGP SIGNATURE-----

--bguhyq47rfsodvla--

