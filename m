Return-Path: <linux-kernel+bounces-857417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FE6BE6BF0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71EEF3A4C18
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9D030DD3F;
	Fri, 17 Oct 2025 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwccKLcY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69271D6187
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760683464; cv=none; b=SENRVsNkdMrdSpYApeDMbtv+NnnQ6kHUTxMtK7df9EkVNmithPuH1VLJuqMnkkPq/drQGjnHpHiVb8NLiQcqwvPB4wfwE9M3TJG8JnCrJFOgXPT7qvZO6s4jn72hkYuDCzlIFf+TJGIbbE/alKUGyBAI+C/rupKfoFSCiewwTY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760683464; c=relaxed/simple;
	bh=7P4jh6kluLcdpaCNJenQWmykCB2CsHxYxuiH71O7f8U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=kbD1jqD+uExzZ3XXNNLnxi3NHgLTyRycci5Ir1cC1iPE6JGroczdwORt1wBI2Dsb5WJlsMB4J1BUWO5DGWPmJbcSoSMOUvo2ODACTYUUHqjmfMgr6UjC70D+nPNrTwK+beNk2HmBBUJtdoB9YOrHiWVtpjIS+/h54/P9B1kXVHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwccKLcY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A2FC4CEF9;
	Fri, 17 Oct 2025 06:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760683463;
	bh=7P4jh6kluLcdpaCNJenQWmykCB2CsHxYxuiH71O7f8U=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=MwccKLcYN/pX/zuOJmFiMxLkdXV91iDq/NMuWvu79+cX6Urmuqgrq3fyqMRBYVr3q
	 AVfb8urT5KUy8SWL1ZemxNKEqyEECzYsk0QQwieDtvUtJx7dcyOWmJohUwTtrmoCtT
	 FueWx3yXWx5n0coD0oVYd+ZC5Z+yqLxBzhnacTZN49Y3pFUIkHyMbtzUdFacaTRAWM
	 2OOtm0nhgIWXaoD31QaON754lNuzQFBMdySQr/gK0o60bHTgX7MXinI33Bxs3Razdw
	 B4IpHyXDtqSjuDf9fc/NcK3xod9LEjUP/V13okNO4riM7r+qWwsU78PuS3paMSsftZ
	 o33a16Pctc3yA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=4fee797e4721044d08e9601b3b5e8700f6c06056cbf5c56b70d2e0a6e636;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 17 Oct 2025 08:44:18 +0200
Message-Id: <DDKE72QORJS2.29XWZ4U0T0K4I@kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: atmel: add at25dn011
Cc: "Marcus Folkesson" <marcus.folkesson@gmail.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Simon Richter" <simon@sinic.eu>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, <linux-mtd@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.0
References: <20251017060529.21169-1-simon@sinic.eu>
In-Reply-To: <20251017060529.21169-1-simon@sinic.eu>

--4fee797e4721044d08e9601b3b5e8700f6c06056cbf5c56b70d2e0a6e636
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Simon,

On Fri Oct 17, 2025 at 8:05 AM CEST, Simon Richter wrote:
> Add AT25DN011 with 1Mbit.
> Used on multiple custom boards and tested with this patch.

Could you add your testing to the next version of your patch (below
a "---" line). See also [1].

>
> Link: https://www.renesas.com/en/document/dst/at25dn011-datasheet?r=3D160=
8506

Newer flash and no SFDP :|

> Signed-off-by: Simon Richter <simon@sinic.eu>
> ---
>  drivers/mtd/spi-nor/atmel.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
> index 82c592f0a1e1..0c2908bce0bc 100644
> --- a/drivers/mtd/spi-nor/atmel.c
> +++ b/drivers/mtd/spi-nor/atmel.c
> @@ -171,6 +171,11 @@ static const struct flash_info atmel_nor_parts[] =3D=
 {
>  		.name =3D "at45db081d",
>  		.size =3D SZ_1M,
>  		.no_sfdp_flags =3D SECT_4K,
> +	}, {
> +		.id =3D SNOR_ID(0x1f, 0x42, 0x00),
> +		.name =3D "at25dn011",

No .name please, the ID is enough. We've deprecated the use of a
name.

> +		.size =3D SZ_128K,
> +		.no_sfdp_flags =3D SECT_4K | SPI_NOR_DUAL_READ

missing trailing comma.

-michael

>  	}, {
>  		.id =3D SNOR_ID(0x1f, 0x42, 0x16),
>  		.name =3D "at25sl321",

[1] https://docs.kernel.org/driver-api/mtd/spi-nor.html

--4fee797e4721044d08e9601b3b5e8700f6c06056cbf5c56b70d2e0a6e636
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaPHlwxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gmLwF+JiHyu3n9XMBIhiXLnXajztj5wG7/MjHp
WunFdtYCZ+VyTvOPA/DytJuplHSgtXWHAX42m2HDy4l8RGIG/10nc2uLX0iousfN
vFX+Y4mQhWsB9wyr8iYxD9fVyGdi8tzbF0w=
=w87x
-----END PGP SIGNATURE-----

--4fee797e4721044d08e9601b3b5e8700f6c06056cbf5c56b70d2e0a6e636--

