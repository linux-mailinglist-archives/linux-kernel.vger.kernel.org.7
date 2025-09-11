Return-Path: <linux-kernel+bounces-811365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F9BB52818
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0CC81B24D10
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C099245019;
	Thu, 11 Sep 2025 05:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBSbu6Y7"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD4B329F29;
	Thu, 11 Sep 2025 05:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757567938; cv=none; b=c2aYhBxJku6878fWEkMbdMTzzh0hVzYnK/ZI9xlGBcmdqzVCIFtUoEQfZfJLzjlJOGuUurCb0nQBvBsNkJxtZEBj+ETVjivj3NaHAtmnCq0NjQaazI2aWblYmOhG+vhl/LDyzbp5a/C1qha4tY//Hd6BZ/+O/O7L+Cptn+dKbrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757567938; c=relaxed/simple;
	bh=GDABVtc1SrZwW/KBv1KVhhG1dyrsbhXtcJEha2zG47E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHZhrAEew8q7bKrIinwkthMkUHjw2F7qhTeACr2nLbNEynal5gXARWK59mCfAiYJpcyaZOHaFEB3yq53u30EsJ1U/A7MS2++Fj9nVuiRgwewH63ggVSwu9szxrdw56qjFuvbZi+Ad1K/qL6kqJCiVsEVMDJAFucYqv4m8QfCEc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBSbu6Y7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so269984b3a.0;
        Wed, 10 Sep 2025 22:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757567936; x=1758172736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ob6veE5AGYLeWVGWkM6V6DpcVgdW5QlZW6WW97o1lOQ=;
        b=aBSbu6Y7AzJJfJWWwprWvFhatwGWCmmL/b61aAwEVgbhWJKwuf+PzrsFI1a/M9Gic3
         I0rdiD6bF2PTar8Yzrlga7Ww0rZ2atw6y0e8aH83dRZdnQt/4UASkk9r2UnJ82jIcxEQ
         1SzLlwirHDqxy6vaobsaIrYps6xhDKNDZwipxotMY0zpH6Gv4zrNOrW1zmcrhwcEqUEz
         Og8EQi5+J6NBT6xNvSEUG3jEDl4kmBwRKV0dEdTjvgUgcOBQ6bzGRxdj0hMEqA3jYMVN
         pHmLUTNef0gv8oGMSKZnnto0bDPwkwFMFptl+VxmI1C4otU8OtytHhjqK2AdGqXAL6Ji
         HGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757567936; x=1758172736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ob6veE5AGYLeWVGWkM6V6DpcVgdW5QlZW6WW97o1lOQ=;
        b=BrbjAwz+eHpmlJ/LxLWGqzMa5dpSMltI267koDiNM6mM8uks2Ffmx2DocD61Io0Jig
         WvMeqRXMvvyASprh5Oyh9sIEqTYc3JTeL0NlcyURPEdj6a1Gi6ai5LWKFyHW2BvXAbMY
         sTEnao2oyLQcjoBvTN+gq9u8/ywDdV3gBZukwgFJyTXnWx0gXm2ZnIfTXMyN3eGbTO0t
         rG0OUdX8uTnltd/KJpgbkNqM8kiFhJ/5zCOft/isXHb2MzDrFGOufZtgF63VIlxOzTGb
         66E7RGo72LauoNiuytXSlRoLeAXmaZdstjIZBdU0Aa7TZKuKGGFBWCfu37Yeh3nxPpqr
         2DZw==
X-Forwarded-Encrypted: i=1; AJvYcCUsSTmQPFWwpGhxEWuF1HGconDnVP7vyJQ1UgzHVUAxLTn5g2L4E/hcX1+BSH7zeh4OSQCuXk5iHvhs@vger.kernel.org, AJvYcCXl+gJmx4E3WUR5Hrv2Hh2KIP7LWcG+w85rMAivhqOUQV9aiHjFRLhKOT+NE7y/nKpxPxJo1xwR0zcyZTT0@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc3lCSD9CXtV2ax94qJYfikcgV/VpTjEGCnCTLMxxoD0eov/KA
	8ucUdG3lY5KXWgxYkCPYkIkAu1lCgZ1FF3+F8tFnHawvt9IVeK18nXN0IqP27+abcXmtbVfbmjq
	mbbvdJwV6SOaOKXW1CAZerzJ0Sk9FTGc=
X-Gm-Gg: ASbGncvvvrh6RbmKTXjIzbS6A0Dog+9fQF9yrfzGRJSTiQGyasfA7pwN79yF8oxhcZa
	MFojLdT9LyIVJL46qb36pOpRZ7vfpr1ecqfOTt1A4K7A4+VQ9v7aCCHokS/lAcNvHgOjVldeqj+
	M0AhGsdPG3v5VmJbcrM8skPX9uWD00bIwkzPzYB7T4qeFKEHZSjqGfLBKlwjarOGT3I4WPMSqMg
	zZC8jViV4+UBfm2U1vY8cb5i1YjhXxxgEf7RP+b0X06rt1eJ03WlropRcigKNiYShksd3IuhUA1
	HwWXkw==
X-Google-Smtp-Source: AGHT+IFvk+5T2h+j0r3gYLbnPHEWNcHciv2c0Ary9jQiIrzK99D3uAB1gqkge8gs1Y0+2mp/CMujlAyHzCr0gEm6ljk=
X-Received: by 2002:a05:6a20:9146:b0:251:9f29:455d with SMTP id
 adf61e73a8af0-253446fd00amr25949069637.31.1757567936500; Wed, 10 Sep 2025
 22:18:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910030301.1368372-1-linchengming884@gmail.com>
 <20250910030301.1368372-4-linchengming884@gmail.com> <87qzwed62q.fsf@bootlin.com>
 <CAAyq3SamY9vjQubd0BjpLb7J_W6JfKyyd987y+UioMV7UQ=94Q@mail.gmail.com> <87ldmmd4nh.fsf@bootlin.com>
In-Reply-To: <87ldmmd4nh.fsf@bootlin.com>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Thu, 11 Sep 2025 13:15:53 +0800
X-Gm-Features: Ac12FXz7DjlstwmB7-EknEMwItQfSh6GLg3EVSPmH1V6HHVJA8K5qegErBCwtnQ
Message-ID: <CAAyq3SbX-gBH2vVrMnxDqvf_g4nt5CcT0Dcv9a1cx0Jw-CusSg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mtd: spi-nand: macronix: Add randomizer support
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: richard@nod.at, vigneshr@ti.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, tudor.ambarus@linaro.org, mmkurbanov@salutedevices.com, 
	Takahiro.Kuwano@infineon.com, pratyush@kernel.org, 
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alvinzhou@mxic.com.tw, 
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2025=E5=B9=B49=E6=9C=88=
10=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:43=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On 10/09/2025 at 17:26:13 +08, Cheng Ming Lin <linchengming884@gmail.com>=
 wrote:
>
> > Hi Miquel,
> >
> > Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2025=E5=B9=B49=E6=
=9C=8810=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:12=E5=AF=AB=E9=81=
=93=EF=BC=9A
> >>
> >>
> >> > +static int macronix_set_randomizer(struct spinand_device *spinand)
> >> > +{
> >> > +     struct spi_mem_op exec_op =3D SPINAND_PROG_EXEC_1S_1S_0_OP(0);
> >> > +     struct nand_device *nand =3D spinand_to_nand(spinand);
> >> > +     struct device_node *dn =3D nanddev_get_of_node(nand);
> >> > +     int randopt, ret;
> >> > +     u8 cfg, status;
> >> > +
> >> > +     ret =3D spinand_read_reg_op(spinand, MACRONIX_FEATURE_ADDR_RAN=
DOMIZER, &cfg);
> >> > +     if (ret)
> >> > +             return ret;
> >> > +     if (cfg)
> >> > +             return 0;
> >> > +
> >> > +     cfg =3D MACRONIX_CFG_ENPGM | MACRONIX_CFG_RANDEN;
> >> > +     randopt =3D of_property_read_bool(dn, "mxic,randopt");
> >>
> >> Isn't that a leftover?
> >
> > The property "mxic,randopt" corresponds to bit2 of the configuration
> > register 0x10. Its purpose is to control whether the randomizer also
> > covers the initial portion of the spare area.
>
> Do we need a DT property for that?
>
> In any case, it must be declared in the bindings (which I do not think
> it is?).
>
> > Since the randomizer feature is only documented in Macronix datasheets,
> > it is not clear whether the "randopt" bit is used by all vendors. For
> > this reason, the handling is placed inside macronix.c.
>
> Didn't we discuss in the past of a volatile version for SPI NAND
> devices? I thought we could use a volatile approach instead.

I think a DT property makes sense here. Once the randomizer feature is
enabled, the range it covers must be defined as well. If we rely on a
volatile approach, the randomizer coverage might change dynamically,
which I believe is less safe and harder to guarantee consistency.

>
> Thanks,
> Miqu=C3=A8l

Thanks,
Cheng Ming Lin

