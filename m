Return-Path: <linux-kernel+bounces-829050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DB9B962A0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EDCE4A24C0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394B122D4E9;
	Tue, 23 Sep 2025 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8HgEnvb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894062036ED
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758636880; cv=none; b=Z16A1m52V43mlvuYk9t0/FtzFDhDkaX5D26EzfZeW9s+0wF7mztVxATBTTCrne5ONzO8WheenvomHqtQiHBDJA6U3F1ostH9Wf1WHFaCxEdqQ/UR52eBazT5B5xQmU4o/XPLBfZcLeN0vz21hTyboLo7FwtJroV0TSr38rQieZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758636880; c=relaxed/simple;
	bh=GsId992jcWwfjjUIb8bjkrYleLQcoqX35v2gB95uPmY=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=c6raqa8qk1WUMH46uvX9aLA2REqjvP4VPxEUK6BuAtDm43VLsqEQHoqUSWrpyV7EqJY8fD9F0sragTZyin0dXy/kCr5jzAmAaWNHujo2e3huvQGmGN3GWxFqr3bNkN8ZMyFPBMdT/x44bZqALspgYeb/zT8+7XTyDIRYlr16tzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8HgEnvb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FCEC4CEF5;
	Tue, 23 Sep 2025 14:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758636880;
	bh=GsId992jcWwfjjUIb8bjkrYleLQcoqX35v2gB95uPmY=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=f8HgEnvbgOCGTsOHquGZwL75SpBiNNuC/7tA9nL1gbOJPo+L9aYWwE4UQOQqRjMYx
	 /P3Hbl00Up5WvqM+amlSjqTG2NrvyUMVNKjwI/b14TcWRfhsxd6S3lu0MihTcz8C2H
	 E8Fi2ajqgDTs2dULIdoDcMS6cbIjcsypJcSHX3OdsFhahUKwRkRFbADtk+SbAjDxV2
	 vpdhFhDilVKiHMmYeG+szA7TtjxUO0Ww/00FAoFXBLIc1XaXVzva0qZitL2WgFiMy7
	 sK65V1upOR4xzlfZuakuVzvej/da9ixOrf8AjZrLSGMiZL4oQc+Z3KFnFtVwA03Mtt
	 6wxw2/owYW/Og==
Content-Type: multipart/signed;
 boundary=aabb0dfe20b3a499392939201ba7efacaa56da55352f09fddd9109a83a93;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 23 Sep 2025 16:14:35 +0200
Message-Id: <DD08QRGQSU2G.1GB9CNQJV82CW@kernel.org>
Subject: Re: [PATCH 2/2] mtd: spi-nor: macronix: use RDCR opcode 0x15
Cc: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Maarten Zanders" <maarten@zanders.be>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, "Boris Brezillon"
 <bbrezillon@kernel.org>
X-Mailer: aerc 0.16.0
References: <20250922155635.749975-1-maarten@zanders.be>
 <20250922155635.749975-3-maarten@zanders.be>
In-Reply-To: <20250922155635.749975-3-maarten@zanders.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--aabb0dfe20b3a499392939201ba7efacaa56da55352f09fddd9109a83a93
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Maarten,

On Mon Sep 22, 2025 at 5:56 PM CEST, Maarten Zanders wrote:
> Macronix devices use opcode 0x15 to read the configuration register (CR)
> instead of the default 0x35. On parts such as the MX25L12833F, reading
> the CR with 0x35 returns garbage values, which are then written back
> when updating the status register (SR). This may unintentionally program
> OTP bits (e.g. top/bottom block protection) and change other default
> values.
>
> Other Macronix parts avoid this issue because their SFDP data specifies
> that CR is not read (BFPT_DWORD15_QER_SR2_BIT1_NO_RD), and the driver
> assumes CR defaults to all zeroes which matches the hardware register.

Why isn't that also true for this device? It supports SFDP. Does it
have a wrong value there?

Could you dump please the SFDP and post it here, see [1].

> Set the RDCR opcode to 0x15 for Macronix flashes to avoid corrupt CR
> writes in cases where it is used.
>
> Note that for affected parts, the block protection mechanism might
> remain broken through the OTP bit: locking an upper block (which is the
> only one supported by the driver) is now locking the lower block in HW.
>
> Fixes: 10526d85e4c6 ("mtd: spi-nor: Move Macronix bits out of core.c")

I doubt that this is the correct Fixes tag as this only moves code
around.

But I'm also not convinced that we should fix it that way. I just
had a look at a random macronix flash MX25L12805D and it doesn't
have that opcode. Thus, just adding that to all the macronix flashes
doesn't make much sense. But it also doesn't seem to have a WRSR
command that takes 16bits.. and the core unconditonally set
SNOR_F_HAS_16BIT_SR. Hum.

So maybe just clear the SNOR_F_HAS_16BIT_SR or add SNOR_F_NO_READ_CR
for the macronix flashes by default as a fix. Not sure what's better
here. Then on top of that you might add the RDCR opcode, although
I'm not sure for what it is used then.

In any case, there seems to be another issue with your flash and the
SFDP tables.

-michael

[1] https://docs.kernel.org/driver-api/mtd/spi-nor.html

> Signed-off-by: Maarten Zanders <maarten@zanders.be>
> ---
>  drivers/mtd/spi-nor/macronix.c | 1 +
>  include/linux/mtd/spi-nor.h    | 3 +++
>  2 files changed, 4 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macroni=
x.c
> index e97f5cbd9aad..de3f3d963f86 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -322,6 +322,7 @@ static int macronix_nor_late_init(struct spi_nor *nor=
)
>  	if (!nor->params->set_4byte_addr_mode)
>  		nor->params->set_4byte_addr_mode =3D spi_nor_set_4byte_addr_mode_en4b_=
ex4b;
>  	nor->params->set_octal_dtr =3D macronix_nor_set_octal_dtr;
> +	nor->params->rdcr_opcode =3D SPINOR_OP_RDCR_MX;
> =20
>  	return 0;
>  }
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index cdcfe0fd2e7d..e35405b126c2 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -92,6 +92,9 @@
>  #define SPINOR_OP_RD_EVCR      0x65    /* Read EVCR register */
>  #define SPINOR_OP_WD_EVCR      0x61    /* Write EVCR register */
> =20
> +/* Used for Macronix flashes only. */
> +#define SPINOR_OP_RDCR_MX	0x15	/* Read configuration register */
> +
>  /* Used for GigaDevices and Winbond flashes. */
>  #define SPINOR_OP_ESECR		0x44	/* Erase Security registers */
>  #define SPINOR_OP_PSECR		0x42	/* Program Security registers */


--aabb0dfe20b3a499392939201ba7efacaa56da55352f09fddd9109a83a93
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaNKrTBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gjbgGAqQY+8il2FQeWpOZah7ITS9tO93JfQk7I
XMJRcYH6bdoQnQjd82rOZrTQpiBYbJ4OAYD3zPFzoH5g8CLv1OSfad3LZZ8YGnme
Q/jp4+Xyzp7TCpMVeIAxryCuioQ3uFzicYA=
=afNZ
-----END PGP SIGNATURE-----

--aabb0dfe20b3a499392939201ba7efacaa56da55352f09fddd9109a83a93--

