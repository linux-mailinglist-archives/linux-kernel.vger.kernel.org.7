Return-Path: <linux-kernel+bounces-740934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE5CB0DBC7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A31D5659AC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729DF2EA480;
	Tue, 22 Jul 2025 13:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEdeGY+i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CA22EA140
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192308; cv=none; b=tTRDzOxyiR8Lwp9XeLM7Y0wQBsU+wEyAWbOtx0Q+ymDgPClmA4w/655m3H8deYovO9O967KEZM6jIpNsHHjor8h+0C1CyYFEeUfvdD+zRUuclTOlwS1wskzw/09glF9JFIsVuWPpJB0/3fb/Yt4B3tXbYfjBGwUMI/1WsrMy6oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192308; c=relaxed/simple;
	bh=VakZKKnUbpQ2tyJo/9Ti6S/BvWQx1CCmjdif3cutG1k=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=ei+HlwNay1h9WTwFvoGDAOAYedFMB59Ppgt+hASNbWKvIQz/YWd7GhwaKvHJiExUsm4T124WFxlgXwn6eQRF7osCMm3bxX0LQ/6W5ZxkftCTZtadjQQwrxWLSqAi5cXu2HVyBO2ruNauQt1h9ZmkWDjeRkJTvVuvR4c8oZGd5sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEdeGY+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD205C4CEEB;
	Tue, 22 Jul 2025 13:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753192308;
	bh=VakZKKnUbpQ2tyJo/9Ti6S/BvWQx1CCmjdif3cutG1k=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=IEdeGY+idZh/JlTGJu8q6FLSKR0gOHCv784m9e3X6/GVU/3SQp9pitmRRal9jZBdr
	 fVuJUe+LzZX6WF695Df7YB1OCgPYOxScmN+MGhSZ2MPmnBnOR/K+UakP5x+fzCJdgG
	 krxjKGwQYQp5XbriXYl/jSxVKX+HnQlf3UmV96IyiOitwtw/icoNtxPukzvxqzlTHI
	 dYJscgEPsa9Jm5UgWOSFyJfNjLj8ZOo4b57dlrpbpKodsoQwEPU6c4TYFrkF7ixvlh
	 uOjUSeIh9xGQaTQhK8FrI0YhOepk284kuC7I/AcAdXBsUm6pIljl/UgqoGBZLBMiYH
	 Y2Ss+3RrNzETw==
Content-Type: multipart/signed;
 boundary=f39008052706824fb663390bc6caa983138aaa342a0ed11310985f88e26e;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 22 Jul 2025 15:51:44 +0200
Message-Id: <DBIMSXRWMT9X.1030Q3NLFE83Y@kernel.org>
Subject: Re: [PATCH v2] mtd: spi-nor: winbond: Add support for W77Q51NW
Cc: <linux-mtd@lists.infradead.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Pratyush Yadav" <pratyush@kernel.org>,
 "Richard Weinberger" <richard@nod.at>, "Vignesh Raghavendra"
 <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Marek Vasut"
 <marek.vasut+renesas@mailbox.org>
X-Mailer: aerc 0.16.0
References: <20250721202257.83936-1-marek.vasut+renesas@mailbox.org>
 <9eabfe619554cbdd493086dcffef8f44@kernel.org>
 <c13f39b5-020d-4553-a79f-e22a0cbd1dfa@linaro.org>
In-Reply-To: <c13f39b5-020d-4553-a79f-e22a0cbd1dfa@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--f39008052706824fb663390bc6caa983138aaa342a0ed11310985f88e26e
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jul 22, 2025 at 11:37 AM CEST, Tudor Ambarus wrote:
>
>
> On 7/22/25 9:43 AM, Michael Walle wrote:
> > Hi Marek,
> >=20
> >> --- a/drivers/mtd/spi-nor/winbond.c
> >> +++ b/drivers/mtd/spi-nor/winbond.c
> >> @@ -343,6 +343,10 @@ static const struct flash_info winbond_nor_parts[=
] =3D {
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
>
> Any of you interested in adding testing requirements and examples for otp=
?

Let's add this to my pile of "things to do when I'm having time
again" :)

>
> > you wouldn't need that entry at all, right? Or is it because of the
> > winbond_nor_late_init() which will be called as a manufacturer fixup?
>
> M,
>
> the overwrite of set_4byte_addr_mode in winbond_nor_late_init() seems a
> little trashy, we assume that winbond will always use
> spi_nor_set_4byte_addr_mode_en4b_ex4b(), apart of the extra ops that we'r=
e
> doing there. Aren't we better without this generalization?

Not sure where that comes from originally. But we are overwriting
what SFDP is figuring out, correct? Maybe we should do the same as
in macronix.c; just set it when it is not set. If the SFDP doesn't
specify the method, I'd say it is a fair assumption that any (older)
winbond flash use that stateful method to enter 4 byte addressing
mode. Newer flashes probably features SFDP.

For the extra ops.. I'm not sure if that is/was just a quirk for
that particular flash or if any winbond flash has that problem.

-michael

>
> > In that case we could do the same as in commit afe1ea1344bb ("mtd: spi-=
nor:
> > add support for Macronix Octal flash").
> >=20
> > -michael


--f39008052706824fb663390bc6caa983138aaa342a0ed11310985f88e26e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaH+XcBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/jWEAGApIIE/MDSnt49pTFVFfBPqz+IVUUv0NFs
R9B/CUoXpRWElmRovIj3JjSnrWZ4pCmGAX46gfSJ4fAieQXaP+fczayZQzhnwM2k
Kpzz9aPnEHLQJUsvcHvNUv59l9ampSC/L6M=
=GoqN
-----END PGP SIGNATURE-----

--f39008052706824fb663390bc6caa983138aaa342a0ed11310985f88e26e--

