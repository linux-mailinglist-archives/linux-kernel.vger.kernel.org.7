Return-Path: <linux-kernel+bounces-865112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE45BFC3FF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E56655684F1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A87347BCF;
	Wed, 22 Oct 2025 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qIN4bdNE"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFD42FC866
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140389; cv=none; b=Sti2dueIWeGpSU3Bd6Q0SlqwYkZJSZ4nsm/GfzZG6MlG7heF7hLS09CKk5jwILXEu4CvFlWac1F7Ij4sRO3TJh1zt7T6SwGJW+kJvx5zJqJiBmxyQ7mPui9HCfZ3d+1MNUS1q+Br+w7MGRQJz4wIGandK+dW/n4pOo8OZejhoEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140389; c=relaxed/simple;
	bh=720MS7OZS4cEmCVDZv82hVmGLIegWTyzoRiUNl8+iv8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oBRI0kiDGayC+tfpcqiLskS/7rdWl56MpEv0iDevSohF/MymuKrJRsXLu7Ppnk3feP2RPdMWrGXVwB2exwmHECma6XKetDNdcwpPGtC/WXucnC16lLtZMree9Fpk+/FYl5EZvEGNVT6yF4SXsZV3cO7xyU68v6SnEzlFLgR+hq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qIN4bdNE; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id F200D4E41278;
	Wed, 22 Oct 2025 13:39:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C7D76606DC;
	Wed, 22 Oct 2025 13:39:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7CD3D102F242F;
	Wed, 22 Oct 2025 15:39:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761140381; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yr4VH+Yj7+1IWVKMwzrK588Y4t7EvKEaaAZKq6WNrcY=;
	b=qIN4bdNEZWAQ1AUR3KXxFWp5S2C/02EvT8z9RmzKEUN9CMSKXwaNy1zihsKU0IL5YJWmCi
	v0ccZG2qONTB9PbRRSQRLYRayYVJYOyflxJ13YbZ7O5f+Y8VTC3GPMFE4oMbnXyh4Y1Dm3
	CnYGYiCAdSwuFkvgXsAXmklHZigaeOA5+33laRmzV6KtYt9486IHAmWccNIdwJX80TVooS
	Sm2MTL2zDqboDMh9TCW+5QT+SWr1HUFZaTkgboxPMHV+mAmvaVqkE+BNv8wO/r1sMsJh7e
	r5HJdm0heK2KZynPXHVLzoI5ciXgNdIKL0Jp1cpsUdbz/L2C5VAUz1RrLyCJwg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Elad Nachman <enachman@marvell.com>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v0] mtd: rawnand: marvell: fix 8bit ECC layouts
In-Reply-To: <20251022013752.2381694-1-aryan.srivastava@alliedtelesis.co.nz>
	(Aryan Srivastava's message of "Wed, 22 Oct 2025 14:37:52 +1300")
References: <20251022013752.2381694-1-aryan.srivastava@alliedtelesis.co.nz>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 22 Oct 2025 15:39:27 +0200
Message-ID: <87qzuvrr74.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 22/10/2025 at 14:37:52 +13, Aryan Srivastava <aryan.srivastava@alliedtel=
esis.co.nz> wrote:

> These were modified to appease a check in nand_scan_tail. This change led
> to the last spare bytes never being written to or read from.
>
> Modify the fix by restoring the layouts and setting ecc->steps to the
> full_chunk_cnt value in the 8 bit ECC cases (4k and 8k page size). This
> allows the driver to continue reading/writing all chunks while also
> passing the check in nand_scan_tail.
>
> Fixes: e6a30d0c48a1 ("mtd: rawnand: marvell: fix layouts")
> Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
> ---
>  drivers/mtd/nand/raw/marvell_nand.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/m=
arvell_nand.c
> index 303b3016a070..c20feacbaca8 100644
> --- a/drivers/mtd/nand/raw/marvell_nand.c
> +++ b/drivers/mtd/nand/raw/marvell_nand.c
> @@ -292,10 +292,10 @@ static const struct marvell_hw_ecc_layout marvell_n=
fc_layouts[] =3D {
>  	MARVELL_LAYOUT( 2048,   512,  8,  2,  1, 1024,  0, 30,1024,64, 30),
>  	MARVELL_LAYOUT( 2048,   512,  16, 4,  4, 512,   0, 30,  0, 32, 30),
>  	MARVELL_LAYOUT( 4096,   512,  4,  2,  2, 2048, 32, 30,  0,  0,  0),
> -	MARVELL_LAYOUT( 4096,   512,  8,  4,  4, 1024,  0, 30,  0, 64, 30),
> +	MARVELL_LAYOUT( 4096,   512,  8,  5,  4, 1024,  0, 30,  0, 64, 30),
>  	MARVELL_LAYOUT( 4096,   512,  16, 8,  8, 512,   0, 30,  0, 32, 30),
>  	MARVELL_LAYOUT( 8192,   512,  4,  4,  4, 2048,  0, 30,  0,  0,  0),
> -	MARVELL_LAYOUT( 8192,   512,  8,  8,  8, 1024,  0, 30,  0, 160, 30),
> +	MARVELL_LAYOUT( 8192,   512,  8,  9,  8, 1024,  0, 30,  0, 160, 30),
>  	MARVELL_LAYOUT( 8192,   512,  16, 16, 16, 512,  0, 30,  0,  32,
> 30),
>  };
>=20=20
> @@ -2286,7 +2286,16 @@ static int marvell_nand_hw_ecc_controller_init(str=
uct mtd_info *mtd,
>  	}
>=20=20
>  	mtd_set_ooblayout(mtd, &marvell_nand_ooblayout_ops);
> -	ecc->steps =3D l->nchunks;
> +
> +	/* Validity checks in nand_scan_tail assume even sized chunks, but in t=
he case of 8bit
> +	 * ECC with 4k/8k page size the last chunk is spare data, which is not =
sized to the data
> +	 * chunks. Overwrite the ecc->steps to pass this validity check, while =
maintaining the
> +	 * correct number of chunks in-driver.
> +	 */

I am not a big fan of this approach, I wonder whether we should relax
the check in nand_scan_tail() or not. Maybe we could avoid the error in
the core by just printing a warning, this way the drivers would not need
to lie to the core.

What I would suggest, now that I properly understood the problem, is to:
1. Revert Elad's patchset *entirely* (including the revert of
   existing/valid but with little use layouts).
2. Relax the check in the core.

Thanks,
Miqu=C3=A8l

