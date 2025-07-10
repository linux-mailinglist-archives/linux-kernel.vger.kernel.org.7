Return-Path: <linux-kernel+bounces-726611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BB7B00F3E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EACD1CA8395
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501582BE057;
	Thu, 10 Jul 2025 23:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="L/xqYAS5"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5284F291142
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752188893; cv=none; b=hWg+RwXb1y0bgZDZe74V1RvKKNnCJ2GAOFylCIpTNk0KbJSnwz3f2cAni3qCFBRTSgG5T+ICTAb9/GLyAZyuF5yG676aXQ0BYruGCW6Q+okVge5fQApKTfsbRC5MpLZVsuj//gOJBw5HCbGjLy3bjnM4Oqc/LjrC3j/IjmNWjVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752188893; c=relaxed/simple;
	bh=iwofFj9vnJTgG6ZxbacMhCtDKiXXM+9k4CEnOpTVI64=;
	h=From:References:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pt8QureeugqcPTHwVfA1EpZzT5A5uoz4uTYSBbn6Nnef0qqlU45jlmbaC78sneqvPHRpFlN3exfitSgLyiDPdHXDCv+dY1uZcAHD30FlCFAS/+snIwWUVUPHnVLuhlNlptZLvKXlBCugkZj05C4H1OaLWJ7doOu3hqn2LSLuFn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=L/xqYAS5; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-53164bd0df3so626588e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1752188890; x=1752793690; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Da0fx0O2+MKsGwXHrTiW7V5DVhj8maiOCP00MQF9xC8=;
        b=L/xqYAS5ZRlHoUCL23b7pp/7cyZGGdpVy71YF0NrA8+xuYkWu+vg0JG+8jag4t12/k
         t0E5x43KjzLar18WFl0jxMT2GrCoyPeJIMUEZ4DvymlgVXlO5U3R4nWir6jBztmrF+7g
         SPni0kvCd3+ZH1ygB1rrAy5Px601k4ekqHidk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752188890; x=1752793690;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Da0fx0O2+MKsGwXHrTiW7V5DVhj8maiOCP00MQF9xC8=;
        b=se4dQt8vqFs4wxUd2SQFN6yzpl45R4Ih3jvTlXWfhbuyeIKhWUF1bZQzyaFYJ7Bx5j
         9INR/5Mu7vQuAiJhBVj8dhEphSlfSMGqlBUYhNponn2g3yY3jWytTrkgycYncixF+b2G
         27BrrpZP/QSQ9VxMJDMCmQkkTHXI6JQThbgIuuXkzwm2kGmsHdqkWV+IVdCGu87bKJj7
         C1Gla4QvEtq75Xm01g/wyJCxG0TRwbM0gUJq4CgVPibPVUTjtoWPscDbKyOpiQ3zWX5c
         ZZxxkaPqL8C4q6E7JCrtbjYrZXsJ98X1hQY7Nu83ZRjzP6YdHDiTqaPg0EdAQNu+fQjI
         zHbQ==
X-Gm-Message-State: AOJu0YyZGZuxUE2e9mK1J0gW13FNiwc4+pMkEApG/S3cSHBlJ3akttek
	J7sdyQm/EyuZKTBMHtCMtmq1eCquV+dSUJZnfcbc6EWEjeFVy5qW4R6vcUmCkAJg3KPlBkrIvpc
	7+uqBQXxlx0jWpnD8jhRSkwRYISPhrBzmxCPCFMgh
X-Gm-Gg: ASbGncsQVVqYl2CvL/L4L8+J0qOw4roFMAu6FCCXwE+BBookHSsUFSWQlgOFIP3zK5Y
	E5dGNyPNevBR0r80rRw7/R0KfaOF41sdFx+zf3kZYbV/1f5G4oSOcAHYt2/JRf3snfzFQy9PL8a
	IW6hShTMwANmTphvionWEjZGsxqN/h34djHvdXjLJYsgyklkbAFr6PI5E=
X-Google-Smtp-Source: AGHT+IEIFSo1C/DLx1BPDxFaCSEqi1YK2B5wuwSLliwo26dQkKtqycbjUj4Dl4q7YposWET8jEHnUrbt1kvjV9CPkTo=
X-Received: by 2002:a05:6122:1d15:b0:530:65b3:4920 with SMTP id
 71dfb90a1353d-535f4727993mr713747e0c.5.1752188890036; Thu, 10 Jul 2025
 16:08:10 -0700 (PDT)
From: William Zhang <william.zhang@broadcom.com>
References: <20250703024719.2256470-1-dregan@broadcom.com> <CAHi4H7Ea38sfiUyOfo81avP4brxp+3b+SO3csGWdLU9+qohqGg@mail.gmail.com>
In-Reply-To: <CAHi4H7Ea38sfiUyOfo81avP4brxp+3b+SO3csGWdLU9+qohqGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIcFbq0Dv56Vymg8ftpkCiyVIbzaANWLhmJs5EByQA=
Date: Thu, 10 Jul 2025 16:08:08 -0700
X-Gm-Features: Ac12FXykVua_KvNwRH521rhyXFv2-WN4E-EeoA6FTHUeRrOxDbFQR5rH23lqLrM
Message-ID: <b7c0624d238429b04692e51c3df3dabc@mail.gmail.com>
Subject: RE: [PATCH v3] mtd: nand: brcmnand: fix mtd corrected bits stat
To: david regan <dregan@broadcom.com>, =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
	bcm-kernel-feedback-list@broadcom.com, Anand Gore <anand.gore@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Kamal Dasu <kamal.dasu@broadcom.com>, 
	Dan Beygelman <dan.beygelman@broadcom.com>, =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>, 
	rafal@milecki.pl, computersforpeace@gmail.com, frieder.schrempf@kontron.de, 
	vigneshr@ti.com, richard@nod.at, bbrezillon@kernel.org, kdasu.kdev@gmail.com, 
	jaimeliao.tw@gmail.com, kilobyte@angband.pl, jonas.gorski@gmail.com, 
	dgcbueu@gmail.com, dregan@mail.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000653f9b06399b4406"

--000000000000653f9b06399b4406
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: William Zhang <william.zhang@broadcom.com>
> Sent: Wednesday, July 2, 2025 9:26 PM
> To: david regan <dregan@broadcom.com>
> Cc: linux-kernel@vger.kernel.org; linux-mtd@lists.infradead.org;
> bcm-kernel-
> feedback-list@broadcom.com; anand.gore@broadcom.com;
> florian.fainelli@broadcom.com; kamal.dasu@broadcom.com;
> dan.beygelman@broadcom.com; Miqu=C3=A8l Raynal <miquel.raynal@bootlin.com=
>;
> =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>; rafal@milecki.pl;
> computersforpeace@gmail.com; frieder.schrempf@kontron.de;
> vigneshr@ti.com; richard@nod.at; bbrezillon@kernel.org;
> kdasu.kdev@gmail.com; jaimeliao.tw@gmail.com; kilobyte@angband.pl;
> jonas.gorski@gmail.com; dgcbueu@gmail.com; dregan@mail.com
> Subject: Re: [PATCH v3] mtd: nand: brcmnand: fix mtd corrected bits stat
>
> On Wed, Jul 2, 2025 at 7:47=E2=80=AFPM david regan <dregan@broadcom.com> =
wrote:
> >
> > From: David Regan <dregan@broadcom.com>
> >
> > Currently we attempt to get the amount of flipped bits from a hardware
> > location which is reset on every subpage. Instead obtain total flipped
> > bits stat from hardware accumulator. In addition identify the correct
> > maximum subpage corrected bits.
> >
> > Signed-off-by: David Regan <dregan@broadcom.com>
> > ---
> >  v3: Use brcmnand_corr_total to obtain maximum subpage flipped
> >      bits for further backwards compatibility.
> >
> >  v2: Add >=3D v4 NAND controller support as requested by Jonas.
> >      mtd->ecc_stats.corrected accumulates instead of set to total.
> >      Remove DMA specific flipped bits count.
> >
> > ---
> >  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 53 +++++++++++++++++-------
> >  1 file changed, 38 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > index 62bdda3be92f..b13f5f8f0eec 100644
> > --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > @@ -359,6 +359,7 @@ enum brcmnand_reg {
> >         BRCMNAND_CORR_THRESHOLD_EXT,
> >         BRCMNAND_UNCORR_COUNT,
> >         BRCMNAND_CORR_COUNT,
> > +       BRCMNAND_READ_ERROR_COUNT,
> >         BRCMNAND_CORR_EXT_ADDR,
> >         BRCMNAND_CORR_ADDR,
> >         BRCMNAND_UNCORR_EXT_ADDR,
> > @@ -389,6 +390,7 @@ static const u16 brcmnand_regs_v21[] =3D {
> >         [BRCMNAND_CORR_THRESHOLD_EXT]   =3D     0,
> >         [BRCMNAND_UNCORR_COUNT]         =3D     0,
> >         [BRCMNAND_CORR_COUNT]           =3D     0,
> > +       [BRCMNAND_READ_ERROR_COUNT]     =3D     0,
> >         [BRCMNAND_CORR_EXT_ADDR]        =3D  0x60,
> >         [BRCMNAND_CORR_ADDR]            =3D  0x64,
> >         [BRCMNAND_UNCORR_EXT_ADDR]      =3D  0x68,
> > @@ -419,6 +421,7 @@ static const u16 brcmnand_regs_v33[] =3D {
> >         [BRCMNAND_CORR_THRESHOLD_EXT]   =3D     0,
> >         [BRCMNAND_UNCORR_COUNT]         =3D     0,
> >         [BRCMNAND_CORR_COUNT]           =3D     0,
> > +       [BRCMNAND_READ_ERROR_COUNT]     =3D  0x80,
> >         [BRCMNAND_CORR_EXT_ADDR]        =3D  0x70,
> >         [BRCMNAND_CORR_ADDR]            =3D  0x74,
> >         [BRCMNAND_UNCORR_EXT_ADDR]      =3D  0x78,
> > @@ -449,6 +452,7 @@ static const u16 brcmnand_regs_v50[] =3D {
> >         [BRCMNAND_CORR_THRESHOLD_EXT]   =3D     0,
> >         [BRCMNAND_UNCORR_COUNT]         =3D     0,
> >         [BRCMNAND_CORR_COUNT]           =3D     0,
> > +       [BRCMNAND_READ_ERROR_COUNT]     =3D  0x80,
> >         [BRCMNAND_CORR_EXT_ADDR]        =3D  0x70,
> >         [BRCMNAND_CORR_ADDR]            =3D  0x74,
> >         [BRCMNAND_UNCORR_EXT_ADDR]      =3D  0x78,
> > @@ -479,6 +483,7 @@ static const u16 brcmnand_regs_v60[] =3D {
> >         [BRCMNAND_CORR_THRESHOLD_EXT]   =3D  0xc4,
> >         [BRCMNAND_UNCORR_COUNT]         =3D  0xfc,
> >         [BRCMNAND_CORR_COUNT]           =3D 0x100,
> > +       [BRCMNAND_READ_ERROR_COUNT]     =3D 0x104,
> >         [BRCMNAND_CORR_EXT_ADDR]        =3D 0x10c,
> >         [BRCMNAND_CORR_ADDR]            =3D 0x110,
> >         [BRCMNAND_UNCORR_EXT_ADDR]      =3D 0x114,
> > @@ -509,6 +514,7 @@ static const u16 brcmnand_regs_v71[] =3D {
> >         [BRCMNAND_CORR_THRESHOLD_EXT]   =3D  0xe0,
> >         [BRCMNAND_UNCORR_COUNT]         =3D  0xfc,
> >         [BRCMNAND_CORR_COUNT]           =3D 0x100,
> > +       [BRCMNAND_READ_ERROR_COUNT]     =3D 0x104,
> >         [BRCMNAND_CORR_EXT_ADDR]        =3D 0x10c,
> >         [BRCMNAND_CORR_ADDR]            =3D 0x110,
> >         [BRCMNAND_UNCORR_EXT_ADDR]      =3D 0x114,
> > @@ -539,6 +545,7 @@ static const u16 brcmnand_regs_v72[] =3D {
> >         [BRCMNAND_CORR_THRESHOLD_EXT]   =3D  0xe0,
> >         [BRCMNAND_UNCORR_COUNT]         =3D  0xfc,
> >         [BRCMNAND_CORR_COUNT]           =3D 0x100,
> > +       [BRCMNAND_READ_ERROR_COUNT]     =3D 0x104,
> >         [BRCMNAND_CORR_EXT_ADDR]        =3D 0x10c,
> >         [BRCMNAND_CORR_ADDR]            =3D 0x110,
> >         [BRCMNAND_UNCORR_EXT_ADDR]      =3D 0x114,
> > @@ -959,11 +966,11 @@ static inline u16 brcmnand_cs_offset(struct
> brcmnand_controller *ctrl, int cs,
> >         return offs_cs0 + cs * ctrl->reg_spacing + cs_offs;
> >  }
> >
> > -static inline u32 brcmnand_count_corrected(struct brcmnand_controller
> > *ctrl)
> > +static inline u32 brcmnand_corr_total(struct brcmnand_controller *ctrl=
)
> >  {
> > -       if (ctrl->nand_version < 0x0600)
> > -               return 1;
> > -       return brcmnand_read_reg(ctrl, BRCMNAND_CORR_COUNT);
> > +       if (ctrl->nand_version < 0x400)
> > +               return 0;
> > +       return brcmnand_read_reg(ctrl, BRCMNAND_READ_ERROR_COUNT);
> >  }
> >
> >  static void brcmnand_wr_corr_thresh(struct brcmnand_host *host, u8 val=
)
> > @@ -2066,15 +2073,20 @@ static int brcmnand_dma_trans(struct
> brcmnand_host *host, u64 addr, u32 *buf,
> >   */
> >  static int brcmnand_read_by_pio(struct mtd_info *mtd, struct nand_chip
> *chip,
> >                                 u64 addr, unsigned int trans, u32 *buf,
> > -                               u8 *oob, u64 *err_addr)
> > +                               u8 *oob, u64 *err_addr, unsigned int
> > *corr)
> >  {
> >         struct brcmnand_host *host =3D nand_get_controller_data(chip);
> >         struct brcmnand_controller *ctrl =3D host->ctrl;
> >         int i, ret =3D 0;
> > +       unsigned int prev_corr;
> > +
> > +       if (corr)
> > +               *corr =3D 0;
> >
> >         brcmnand_clear_ecc_addr(ctrl);
> >
> >         for (i =3D 0; i < trans; i++, addr +=3D FC_BYTES) {
> > +               prev_corr =3D brcmnand_corr_total(ctrl);
> >                 brcmnand_set_cmd_addr(mtd, addr);
> >                 /* SPARE_AREA_READ does not use ECC, so just use
> > PAGE_READ */
> >                 brcmnand_send_cmd(host, CMD_PAGE_READ);
> > @@ -2099,13 +2111,16 @@ static int brcmnand_read_by_pio(struct mtd_info
> *mtd, struct nand_chip *chip,
> >
> >                         if (*err_addr)
> >                                 ret =3D -EBADMSG;
> > -               }
> > +                       else {
> > +                               *err_addr =3D
> > brcmnand_get_correcc_addr(ctrl);
> >
> > -               if (!ret) {
> > -                       *err_addr =3D brcmnand_get_correcc_addr(ctrl);
> > +                               if (*err_addr) {
> > +                                       ret =3D -EUCLEAN;
> >
> > -                       if (*err_addr)
> > -                               ret =3D -EUCLEAN;
> > +                                       if (corr &&
> > (brcmnand_corr_total(ctrl) - prev_corr) >
> *corr)
> > +                                               *corr =3D
> > brcmnand_corr_total(ctrl) - prev_corr;
> > +                               }
> > +                       }
> >                 }
> >         }
> >
> > @@ -2173,6 +2188,8 @@ static int brcmnand_read(struct mtd_info *mtd,
> struct nand_chip *chip,
> >         int err;
> >         bool retry =3D true;
> >         bool edu_err =3D false;
> > +       unsigned int corrected =3D 0; /* max corrected bits per subpage=
 */
> > +       unsigned int prev_tot =3D brcmnand_corr_total(ctrl);
> >
> >         dev_dbg(ctrl->dev, "read %llx -> %p\n", (unsigned long
> > long)addr, buf);
> >
> > @@ -2200,9 +2217,11 @@ static int brcmnand_read(struct mtd_info *mtd,
> struct nand_chip *chip,
> >                         memset(oob, 0x99, mtd->oobsize);
> >
> >                 err =3D brcmnand_read_by_pio(mtd, chip, addr, trans, bu=
f,
> > -                                              oob, &err_addr);
> > +                                          oob, &err_addr, &corrected);
> >         }
> >
> > +       mtd->ecc_stats.corrected +=3D brcmnand_corr_total(ctrl) -
> > prev_tot;
> > +
> >         if (mtd_is_eccerr(err)) {
> >                 /*
> >                  * On controller version and 7.0, 7.1 , DMA read after =
a
> > @@ -2240,16 +2259,20 @@ static int brcmnand_read(struct mtd_info *mtd,
> struct nand_chip *chip,
> >         }
> >
> >         if (mtd_is_bitflip(err)) {
> > -               unsigned int corrected =3D brcmnand_count_corrected(ctr=
l);
> > -
> >                 /* in case of EDU correctable error we read again using
> > PIO */
> >                 if (edu_err)
> >                         err =3D brcmnand_read_by_pio(mtd, chip, addr,
> > trans, buf,
> > -                                                  oob, &err_addr);
> > +                                                  oob, &err_addr,
> > &corrected);
> >
> >                 dev_dbg(ctrl->dev, "corrected error at 0x%llx\n",
> >                         (unsigned long long)err_addr);
> > -               mtd->ecc_stats.corrected +=3D corrected;
> > +               /*
> > +                * if flipped bits accumulator is not supported but we
> > detected
> > +                * a correction, increase stat by 1 to match previous
> > behavior.
> > +                */
> > +               if (brcmnand_corr_total(ctrl) =3D=3D prev_tot)
> > +                       mtd->ecc_stats.corrected++;
> > +
> >                 /* Always exceed the software-imposed threshold */
> >                 return max(mtd->bitflip_threshold, corrected);
> >         }
> > --
> > 2.43.5
> >
> Reviewed-by: William Zhang <william.zhang@broadcom.com>

Hi Miquel,

I wonder if you get chance to take a look of this latest patch.  We believe
we addressed
all your concerns with the correct test results you requested(test results
were in the v2 patch
thread).  Let us know if there is anything else we need to update.

Thanks,
William

--000000000000653f9b06399b4406
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
YDZuuBJwnyCzevMoPtVYPharioL5H3BRnQi8YoTXH7/uRo33dewYFm474yFjwwnt82TFtveVZkVq
6h4WIQ4wTcwFfET8zMkELnGzS5SHCl8sPD+lNxxJ1JDZYwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRp3aWxsaWFtLnpoYW5nQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUq65GzwZxydFHjjYEU/9h
xHhPWlwwDQYJKoZIhvcNAQELBQADggEBAA2hGG3JPAdGPH0ZdohGUCIVjKz+U+EFuIDbS6A/5jqX
VhYAxZlzj7tSjUIM7G7IhyfqPC46GKJ/4x+Amz1Z6YxNGy71L68kYD6hIbBcA5AM42QBUufly6Oa
/ppSz3WoflVyFFQ5YXniZ+eU+2/cdnYZg4aVUnFjimOF5o3NfMLzOkhQNxbaDjFUfUYD8hKmU6v4
0vUBj8KZ9Gi1LIagLKUREn8jku0lcLsRbnJ5Ey5ScajC/FESPyYWasOW8j8/1EoJksmhbYGKNS6C
urb/KlmDGfVrIRYDbL0ckhGQIP5c6L+kSQZ2sHnQK0e0WgIaZYxaPYeY5u0GLCOze+3vyRMxggJg
MIICXAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwxuh2XG3FXRL1W
JOEwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIFyWkd72Xe9FnhiYYu6WkSGJeu7R
e+JTekjle9q43jFMMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1
MDcxMDIzMDgxMFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3
DQEBAQUABIIBAMYBUsk526reQOL1nL+PPts3gKu9zCiYnscOvWWL3HsokgiaNJY1uD1POF2VPbHX
eRXR2jfjUsjI/vZ5UzXps3KRSxdeLoHhColq8ZvpJOhsTlH2WE5o9hfZWxPw3DEN7R5Yp6sVoI5o
EHjAljC7+odWN+sFlO/qsd6kG75hSpR2i6A3jCoRupuORqxUQBDJzXN81i2o13VZ0AAqSQSCuOss
ler7/THlsT8hCsDdOj8IbdcF9Sr3kT/QJBx34G5DHEaBMvDa/RRlGiYtDavQ57OmzvhArIXvecs3
I2mgBeBAkca4Yvts0Jcfhj2Eb0cu7Sv3zHPrwqYWsGbnxjYaKmM=
--000000000000653f9b06399b4406--

