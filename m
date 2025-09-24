Return-Path: <linux-kernel+bounces-830189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E66AB99034
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346892E3939
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B93627EFE1;
	Wed, 24 Sep 2025 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zanders.be header.i=@zanders.be header.b="cDbNq5x+"
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [94.124.121.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE701143C69
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758704426; cv=none; b=Dao6oplRZc4uOXS5L+AsracTMxuKvlmMA9SeGtGjz+17msefuZbZrl5GcRnVeG3tJiBUpu+AZGsW2UDaXmsRJSQSkb1rcQuEV3mRzTdzQnE7dmj+7tJpuZXKZbl6X0X1kuLXRQGL1mQa+y6M24f15m1y5xWp1l1KbAhgM648Kc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758704426; c=relaxed/simple;
	bh=KREqzAh+jF5y03UYPBqSwDgkT2GBym1KTxnXoZ8xOhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChE5KZakzKJz1yekKzsh/Wo/LQ0wXWDSoQj9yUFih7CIK/RK45Iau6BYPanBa8KzcqA440h7sToa23J3W7ui9A1f+IQ9FK+sgEWSQEMl64ag840nbOyF/T8Dx+sEZhoTRCU1uGtfCeFqVd9wcfQfA8K0zDGY0oqddNTy/TIkwEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zanders.be; spf=pass smtp.mailfrom=zanders.be; dkim=pass (2048-bit key) header.d=zanders.be header.i=@zanders.be header.b=cDbNq5x+; arc=none smtp.client-ip=94.124.121.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zanders.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zanders.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=zanders.be; s=202002;
	h=content-type:cc:to:subject:message-id:date:from:in-reply-to:references:
	 mime-version:from;
	bh=N2Vf72GOQ2rBbqeUFPI+Xp3IghKEqRQVXfDsNjYoGAk=;
	b=cDbNq5x+fmA6hbs5aFEvdRh8DGzoDLBnNasm34n/waknU96ls8i6qWKOX3E0xeGe0lADafbhiqzaE
	 CfUW5YOhqZTRcTwnmIuAKEv5F4E94mEbkYpEwfbrqpeioVV3LTAfKhTG2wwv9GdfDmMSKP+3bxJhmt
	 NbreDH5J+5C4deIlvA4f2ROGkQ/0MhruOt9+HUjJp7Qn/RcyPrOjIuts9zzk/mDRISnQkUHFu9JWXf
	 FVu0Bf2NmpiIWTM4cCXKMHfjsbFw6SOMM3v7Pxp4BGnscQ2HbIaa1SWLvK9h8mp7ww4jU7yVDIvk1k
	 FNLN9tGHHI6GcZ1sRsKxPL8WFn1kz0w==
X-MSG-ID: e1c1b5c8-9924-11f0-9d6a-00505681446f
X-Forwarded-Encrypted: i=1; AJvYcCXONe4heeecJ2sCTdctl/2giv+PJWRjFMexHbALk6g1JFA9WkmpHY+gUj8y9otFxWrMzG65C8Bt4MbkIP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydfjo3uYBgWLe4OtG2XC00LOp0LfOre/ViZmjus0kyR+li5q7T
	G8PtZe2vBOoZSQrUMtwJ803gKVY1Qr03cT8W+yfPtC0DgFtYtNE2FIy2vU4O9+ZC0YmxnNIO6uE
	50H1cPDfpRG2V7PEZZPViLpEC1CYfIHU=
X-Google-Smtp-Source: AGHT+IEt2Po3Zh8TWxmaqm1I069rKBI2qYFkrIMdeYUdpiFn2AcDDTB4HVUmDo7RlxKe6UfsvRaIqWHN6n4DrO+OxlQ=
X-Received: by 2002:a05:690c:930e:10b0:72a:86fb:b436 with SMTP id
 00721157ae682-758a246a801mr38421997b3.25.1758704412978; Wed, 24 Sep 2025
 02:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922155635.749975-1-maarten@zanders.be> <20250922155635.749975-3-maarten@zanders.be>
 <DD08QRGQSU2G.1GB9CNQJV82CW@kernel.org>
In-Reply-To: <DD08QRGQSU2G.1GB9CNQJV82CW@kernel.org>
From: Maarten Zanders <maarten@zanders.be>
Date: Wed, 24 Sep 2025 11:00:02 +0200
X-Gmail-Original-Message-ID: <CAPB_pELazUPccKa72_m7vb80Z7wLRO+PpgfeY-afDHSgg4eVNg@mail.gmail.com>
X-Gm-Features: AS18NWAGL9X1sJYkTcifCnTT5NHwoBx9uBcyAzc1C4e3__AXI1BfaLZ_b9jOvOU
Message-ID: <CAPB_pELazUPccKa72_m7vb80Z7wLRO+PpgfeY-afDHSgg4eVNg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mtd: spi-nor: macronix: use RDCR opcode 0x15
To: Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav <pratyush@kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Boris Brezillon <bbrezillon@kernel.org>, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, chengminglin@mxic.com.tw
Content-Type: text/plain; charset="UTF-8"

Hi Michael,

> Why isn't that also true for this device? It supports SFDP. Does it
> have a wrong value there?

You're right. I started working on this issue in an older kernel and
didn't check the full error path again on the most recent version. I
noted that the CR opcode was still wrong and went ahead forward
porting my patches without checking the erroneous behavior in the
latest kernel. My bad!

My particular part (MX25L12833F) has been working (by doing 8 bit SR
writes) since 947c86e481a0 ("mtd: spi-nor: macronix: Drop the
redundant flash info fields", 2025-04-07). This ensures that SFDP data
is read and behavior after that is OK. Before that commit, the SFDP
data wouldn't be read because the .size was filled in (and before that
because of .no_sfdp_flags). That in turn triggered the 16 bit writes.

> But I'm also not convinced that we should fix it that way. I just
> had a look at a random macronix flash MX25L12805D and it doesn't
> have that opcode. Thus, just adding that to all the macronix flashes
> doesn't make much sense. But it also doesn't seem to have a WRSR
> command that takes 16bits.. and the core unconditonally set
> SNOR_F_HAS_16BIT_SR. Hum.

Yes. That part (MX25L12805D) has the same ID code whilst it is not
supporting SFDP, RDCR or 16 bit SR writes (according to the
datasheet).
With the current flash info & logic in core.c, it will no longer work
at all as spi_nor_parse_sfdp() fails.

Consider a different example: 8M devices MX25L6433F, MX25L6436F and
MX25L6473F. The ID for these is 0xC22017. Flash info for this contains
a .size field (probably because of the legacy MX25L6405D) so SFDP will
not be parsed and we're falling back on the defaults - so it will do
16 bit SR writes. CR will get corrupted due to wrong CR read opcode.

So I believe this first problem boils down to the same ID representing
both flashes with and without SFDP. If we want to keep supporting the
old non-SFDP devices, the .size should be filled in for those ID's. Or
we drop support for them altogether and make SFDP a hard requirement
(solving the other issues in one go). But it should be consistent
across the different sizes.

> So maybe just clear the SNOR_F_HAS_16BIT_SR or add SNOR_F_NO_READ_CR
> for the macronix flashes by default as a fix. Not sure what's better
> here.

SNOR_F_NO_READ_CR doesn't help: this will write all 0's to the CR in a
16 bit SR write, which is not the default state of some parts
mentioned earlier.
Clearing SNOR_F_HAS_16BIT_SR could indeed be a solution for letting
these parts work properly in this non-sfdp mode. But we probably
shouldn't do it for *all* Macronix flashes?

> Then on top of that you might add the RDCR opcode, although
> I'm not sure for what it is used then.

There wouldn't be a real use until someone starts actually
implementing the features in the Macronix CR (like top/bottom SWP). Or
untill someone else is changing SNOR_F_HAS_16BIT_SR logic due to
additional SFDP/BFPT parsing. Which I still consider a risk due to the
weak link.

> > Fixes: 10526d85e4c6 ("mtd: spi-nor: Move Macronix bits out of core.c")
>
> I doubt that this is the correct Fixes tag as this only moves code
> around.

Essentially, I meant 'since the beginning of macronix introduction'.
In such a case, should we dig further through file renames & stale
LTS's?

Thanks for your input,
Maarten

>
> In any case, there seems to be another issue with your flash and the
> SFDP tables.
>
> -michael
>
> [1] https://docs.kernel.org/driver-api/mtd/spi-nor.html
>
> > Signed-off-by: Maarten Zanders <maarten@zanders.be>
> > ---
> >  drivers/mtd/spi-nor/macronix.c | 1 +
> >  include/linux/mtd/spi-nor.h    | 3 +++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> > index e97f5cbd9aad..de3f3d963f86 100644
> > --- a/drivers/mtd/spi-nor/macronix.c
> > +++ b/drivers/mtd/spi-nor/macronix.c
> > @@ -322,6 +322,7 @@ static int macronix_nor_late_init(struct spi_nor *nor)
> >       if (!nor->params->set_4byte_addr_mode)
> >               nor->params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_en4b_ex4b;
> >       nor->params->set_octal_dtr = macronix_nor_set_octal_dtr;
> > +     nor->params->rdcr_opcode = SPINOR_OP_RDCR_MX;
> >
> >       return 0;
> >  }
> > diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> > index cdcfe0fd2e7d..e35405b126c2 100644
> > --- a/include/linux/mtd/spi-nor.h
> > +++ b/include/linux/mtd/spi-nor.h
> > @@ -92,6 +92,9 @@
> >  #define SPINOR_OP_RD_EVCR      0x65    /* Read EVCR register */
> >  #define SPINOR_OP_WD_EVCR      0x61    /* Write EVCR register */
> >
> > +/* Used for Macronix flashes only. */
> > +#define SPINOR_OP_RDCR_MX    0x15    /* Read configuration register */
> > +
> >  /* Used for GigaDevices and Winbond flashes. */
> >  #define SPINOR_OP_ESECR              0x44    /* Erase Security registers */
> >  #define SPINOR_OP_PSECR              0x42    /* Program Security registers */
>

