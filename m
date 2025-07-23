Return-Path: <linux-kernel+bounces-741924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0E0B0EAB3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1EFC3A7BAE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79C126E6E7;
	Wed, 23 Jul 2025 06:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5QrpDDF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45887185E4A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753252614; cv=none; b=RHKoGaftW6xCnVKOeVXv+As69ozPNvX/8CxuU5kDOjJB2M4EX58+2oRomtSnmvAEdeekRRJWyJMSX/hnVD8DAFKRqSmQN53ubc+m4wdwm2o3aysKIZJGcInNdoG9Ea5NYIpjYN7uFiFMT6UxNh9q14eZA6hCuQVlpbSv0N5h5eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753252614; c=relaxed/simple;
	bh=SpBNyaoMaktj6TidG8FVS9exfWquRDq+PSURzu8oQfg=;
	h=Content-Type:Date:Message-Id:From:To:Subject:Cc:References:
	 In-Reply-To; b=lS+wacvD3ANN8VBO6DUacSBB+Eyd79x51lDymqIvVupTxwHZ5yTudz4dfIW2tj99Nvt8pC9JYZDpzLbZwtVTieqbgIAYmEielKzRdJLFZjorootFMs6aN2O6LkK9SnU2nXKBinYE5t0zNijhq28OxFqRBYpTXz9YamFTxNYu0G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5QrpDDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9CDC4CEE7;
	Wed, 23 Jul 2025 06:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753252612;
	bh=SpBNyaoMaktj6TidG8FVS9exfWquRDq+PSURzu8oQfg=;
	h=Date:From:To:Subject:Cc:References:In-Reply-To:From;
	b=e5QrpDDFhMS1RlvKRBjCwzQblD/CjH0/h2xRNK8X/W/TPQQpNU1ghx9Getdo5JQ24
	 XB4ZL33goG264Un6VOha7odaeoYCVzUlCkmgc4OMHgaCGjLaUj1KUBpQzFsKOJzx3Y
	 ZuZD8MLZxKehV3cGqiA7bT/xKfAZNwpRmSBdIwQ8x6QnqKeiNgwaItP26OSuz5qekT
	 Kfs4EyOELARsr2p3gixIlcpZo1WN2yupjl+cohzokWobSj5cY36kwHulspYcfnYkFI
	 9kVGRqnnmrRFSh1qhpJ+QJ+GyhwC+HJTlXwahWfyIrGWuU3FgQXyQS6UB0Wa2sVKma
	 /CDZ7A75YZ/tQ==
Content-Type: multipart/signed;
 boundary=54f52f5a30941d8da38b7bcc7265a56981a08648e7187f9a304e8ae4e366;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 23 Jul 2025 08:36:48 +0200
Message-Id: <DBJ86H8MDFNX.2Y6T55E0NH63R@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Marek Vasut" <marek.vasut@mailbox.org>, "Marek Vasut"
 <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2] mtd: spi-nor: winbond: Add support for W77Q51NW
Cc: <linux-mtd@lists.infradead.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Pratyush Yadav" <pratyush@kernel.org>,
 "Richard Weinberger" <richard@nod.at>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Vignesh Raghavendra" <vigneshr@ti.com>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.16.0
References: <20250721202257.83936-1-marek.vasut+renesas@mailbox.org>
 <9eabfe619554cbdd493086dcffef8f44@kernel.org>
 <62383ff7-0a14-4f15-818b-f5e5c56332c5@mailbox.org>
In-Reply-To: <62383ff7-0a14-4f15-818b-f5e5c56332c5@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--54f52f5a30941d8da38b7bcc7265a56981a08648e7187f9a304e8ae4e366
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jul 22, 2025 at 4:28 PM CEST, Marek Vasut wrote:
> On 7/22/25 10:43 AM, Michael Walle wrote:
> > Hi Marek,
>
> Hi,
>
> >> --- a/drivers/mtd/spi-nor/winbond.c
> >> +++ b/drivers/mtd/spi-nor/winbond.c
> >> @@ -343,6 +343,10 @@ static const struct flash_info=20
> >> winbond_nor_parts[] =3D {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .id =3D SNOR_ID(0xef,=
 0x80, 0x20),
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "w25q512nwm=
",
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .otp =3D SNOR_OTP(256=
, 3, 0x1000, 0x1000),
> >> +=C2=A0=C2=A0=C2=A0 }, {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* W77Q51NW */
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .id =3D SNOR_ID(0xef, 0x8a=
, 0x1a),
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .otp =3D SNOR_OTP(256, 3, =
0x1000, 0x1000),
> >=20
> > Did you also test the OTP read and write? I'd guess so, because otherwi=
se
> > you wouldn't need that entry at all, right? Or is it because of the
> > winbond_nor_late_init() which will be called as a manufacturer fixup?
> > In that case we could do the same as in commit afe1ea1344bb ("mtd: spi-=
nor:
> > add support for Macronix Octal flash").
>
> I have limited supply of these devices, so OTP is untested. The flash=20
> does have OTP registers, that's why the .otp entry is there. Why should=
=20
> I remove it if the OTP registers are in the chip ?

We only add tested features. I'm just the messenger here :o. Anyway,
OTP is not really one-time-programmable here, you can write and
erase it again as long as you don't lock it, if that was your
concern.

But my main question was whether this chip is working without
this entry (if you don't use the OTP bits) or if there is still
something missing. IOW, with this patch you are just adding the
OTP feature.

-michael

--54f52f5a30941d8da38b7bcc7265a56981a08648e7187f9a304e8ae4e366
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaICDARIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gj1wF/UMLZxv1icrZLxLiZBYXeWkKZ61dXbaZN
D5qvBDH4ZrrJ6g/271jQlWHI6z24fntLAYD5tvjT9xZYqoSaAgPL7A5QhVprASBZ
YJzhF5FRzbWW/PYVDaD9Z62JrM29DUrsLHY=
=Ecie
-----END PGP SIGNATURE-----

--54f52f5a30941d8da38b7bcc7265a56981a08648e7187f9a304e8ae4e366--

