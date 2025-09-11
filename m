Return-Path: <linux-kernel+bounces-811628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E36B52BBA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65EEDA82098
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F172E424F;
	Thu, 11 Sep 2025 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUoQQ2CP"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE922E2DDD;
	Thu, 11 Sep 2025 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757579597; cv=none; b=CksXEG/fe6fFFZN0DLh62ASDmi79yfV3WSdWOEQLn/hnE8Ny+f3mW2Kt6AmBFMj9dTAmGCS96OaONNsOwpQIklbNMS6AzE9fUT/T4Erce/EroC9WPju9/B53t6Fk+rDLcCCt6HmrFLDy12676r2gMo0SGgDR1O6Bu/BRlUck8Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757579597; c=relaxed/simple;
	bh=3y4YlpQgFOakANmVtupNUaNj8c4aAn46gSngVpASFVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gI9/dMSws6nxklvxyd7BnFyEqnSzaD10G+4spbLGZmwLq2dAPhmMcJ2tL3aGKb2FrvDpMC3LtCUeR+MQMKZaOjuwYHPIOILEVQWpkoePVCD1VORReJoEH+C4pBgyyFZ3Ks96YAUZhtu6oh+Y6myX0BLgw+njYTmdkCweIOeJgxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUoQQ2CP; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4cb3367d87so309535a12.3;
        Thu, 11 Sep 2025 01:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757579595; x=1758184395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnbArWoU2ISWToPXD7OZnOf0opXllax5l5gFXhrBoAQ=;
        b=PUoQQ2CP6hykwyhO5EFLAI0HDVtWMtRXnVmf7l2H/qnz6SOB7hANGBmnXaAdBB0H9d
         gg86EpW4LMIuFiTSf+RzTlIuG0TMCYSZOStiLRrwVuSuhsnyGMEmIW7iVT3Ys2Cwbzmw
         YyErOG7v9kyJWXKvA+eVhmaGY/teg65WPsNzAmyVmwgP5ZfMlRUwdxkh4GWrqlv70Nqf
         OYYNMUWz4jMDXYd0aspf2XX5+ikSKLTfW6iAoVicYpk1fBHYcUkMRnWPpqYshr4KQA9o
         poPJIe48rF10iT+E3BB/u8JX0Zb1g538hilDFcmIh96XNa4R8ml+vdZd5JRxs4NOCQ9E
         tNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757579595; x=1758184395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnbArWoU2ISWToPXD7OZnOf0opXllax5l5gFXhrBoAQ=;
        b=SWfeA6T+OypugYmsOMbXcasi4YBFgFlhSDLdsRxM1DvNsNtNXXb/8xzXDHdCykSFqr
         IPMbYgjczkuQeoNqHy7OPuQOA7paGODYbYATeB/TFievsrMImKFrC+rFQLEtUwWx0JbS
         dQEyvLcPYXSqriq3hw3jhFiEa2Gm7OZNTgb0X+vB9rKbZOXyPLn0BZUph7vmBtnxwmgQ
         L2m1icT6TX3KMnyU0q7w8IMr35hJ2KsLjMXIi6d2oT3s9FmAN4uJpC7xfdd0Kt5IdB5I
         M/4Zs5Sh11uJ6WACqNSNymQMzqEhcAGk2IkLQ2/N/MEgEz6wbSV9FeSiinoZIoHPn421
         7TRA==
X-Forwarded-Encrypted: i=1; AJvYcCUa4fppSICuSe4r4V+3IBrEeVRVJvCuT0V7vd5h2wiBtnX1YAiTcY8GFmEFLSlaYgtnpYuCSyDnji5O@vger.kernel.org, AJvYcCUho2qGvpCTGkeE1j10f8UkM0N50OrCmSjbakVkUZPiC9SkIa/cIXVHDwoqOJb/YXva9egQH7Et+fEw4U7W@vger.kernel.org
X-Gm-Message-State: AOJu0Ywebhr95dBVoDfaCn4vQS5J8F4582Zwt/dhz/KSLtj/ZwGvJeN/
	k1sOr6ZDeJyeKs2UkeotydeArLYmWsC0DlYvJFsIKiBxguIZYTXg5KnKk3XCmNhx/nL0t9wzWS0
	s42Jot1YBeOv/1VdjTkfQGY4hQWBdZZc=
X-Gm-Gg: ASbGnctqJJ3ufC9nh0hQAcevszwFGaQUotOngUitEjasTW8ehFF9sVk3aY+Pt3nKn1M
	Noj5+Bd2vQ3sT7D4pgWyjCjVHX5kInPkHdXx5RmXerMDwqSQ2TZwZkPsAyrXuVeH969jB8eD0W1
	8tlIl0Pqz9njXSSbWO9p1y76jOBLiqdOJXVIOxjENHEgi/lErSFMA3GKtc2MgRZk6oDQ6NpkeFg
	pyUAbQmwHSC3+8pMaHfZFuCHw+PegWrhQWvX+EldI5ohZPx2FyEQfeRyWawgjKaloPVIzLoHzRd
	Ub58JovKPGwKLlga0qjAPrHgVvU=
X-Google-Smtp-Source: AGHT+IG8BtdFSE6kHeYKfIZq6jZS1X581jssKQmKNroJamTHQzuwuaMV6i/iYNhQS+YaIVe1y2TXQfivk4+BrAk94fU=
X-Received: by 2002:a17:903:ac8:b0:24d:1f99:713a with SMTP id
 d9443c01a7336-251715f32demr276729255ad.31.1757579594694; Thu, 11 Sep 2025
 01:33:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910030301.1368372-1-linchengming884@gmail.com>
 <20250910030301.1368372-2-linchengming884@gmail.com> <87wm66d67k.fsf@bootlin.com>
 <CAAyq3SbXiPUjZE7OCAe1=uw4h82bFN7DSU4bLx1dhKe_XFtu=w@mail.gmail.com> <878qilbes9.fsf@bootlin.com>
In-Reply-To: <878qilbes9.fsf@bootlin.com>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Thu, 11 Sep 2025 16:30:11 +0800
X-Gm-Features: Ac12FXwhYnAHezSNyjRb8gyVR6NYH3foWyjyBMaPAVIUSYBpDcXrbIGyMsdT4nU
Message-ID: <CAAyq3SZUToRjWVgAX_=We7cMFjVjuGLvFYBSpOG=M_e_MD6aeQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: spi-nand: Add
 enable-randomizer-otp property
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
11=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=883:59=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi Cheng Ming,
>
> On 11/09/2025 at 15:24:35 +08, Cheng Ming Lin <linchengming884@gmail.com>=
 wrote:
>
> > Hi Miquel,
> >
> > Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2025=E5=B9=B49=E6=
=9C=8810=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:10=E5=AF=AB=E9=81=
=93=EF=BC=9A
> >>
> >> Hello Cheng Ming,
> >>
> >> On 10/09/2025 at 11:02:59 +08, Cheng Ming Lin <linchengming884@gmail.c=
om> wrote:
> >>
> >> > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >> >
> >> > Add a new boolean property "enable-randomizer-otp" to enable the
> >> > randomizer feature on supported SPI-NAND devices.
> >> >
> >> > Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >> > ---
> >> >  Documentation/devicetree/bindings/mtd/spi-nand.yaml | 4 ++++
> >> >  1 file changed, 4 insertions(+)
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/mtd/spi-nand.yaml b/D=
ocumentation/devicetree/bindings/mtd/spi-nand.yaml
> >> > index 77a8727c7..432bc79e9 100644
> >> > --- a/Documentation/devicetree/bindings/mtd/spi-nand.yaml
> >> > +++ b/Documentation/devicetree/bindings/mtd/spi-nand.yaml
> >> > @@ -21,6 +21,10 @@ properties:
> >> >      description: Encode the chip-select line on the SPI bus
> >> >      maxItems: 1
> >> >
> >> > +  enable-randomizer-otp:
> >>
> >> This is a NAND wide feature, so we should probably add a prefix, such =
as
> >> "nand,".
> >>
> >> Now, what about this "otp" suffix? Many (if not all) chips have a
> >> volatile setting for that. About the naming, "otp" often reflects to t=
he
> >> OTP area, which is not what you imply here, as you want to insist
> >> (rightfully) on the fact that this feature cannot be disabled.
> >
> > Yes, my intention is that once the randomizer feature is enabled, it
> > should not be disabled again.
>
> I believe the motivation behind this choice is incorrect and does not
> fit such an OS as Linux. We want to give the system administrator the
> choice to select and unselect features as it sees fit. So if there is a
> volatile way to enable something, we should go for it and we will pay
> the extra penalty of a set_feature() (or whatever) command after each
> boot. Making this type of change permanent makes development and
> debugging much more painful. There are plenty of configurations that we
> refuse to apply with non volatile configurations. In general, stateful
> modes are problematic if they are kept after a reboot and we try our
> best to avoid them.
>
> Once this feature is enabled, for the lifetime of "a product", it does
> not make sense to disable it indeed. And the DT must remain correct, if
> it is changed in a non compatible way, that's the administrator
> responsibility.
>
> So are there ways to enable this feature in a way that returns to the
> default state after a reset?

Thank you for the detailed feedback. I understand and agree with the
principle of favoring volatile configurations to give administrators
more control and simplify debugging.

Yes, it is possible to enable this feature in a way that it returns
to the default state after a reset.

We can use the standard set_feature command to set the RANDEN bit to 1,
which enables the randomizer. This configuration is volatile and will
not persist through a power cycle. The feature will remain disabled by
default on each boot unless it is explicitly enabled again.

I will update the patch to implement this volatile approach.

>
> > You are correct that this bit does not
> > belong to the OTP area, but rather to the v2 volatile register. The v2
> > volatile register has a default value that can be changed through a
> > special OTP configuration register program operation. Regarding the
> > "otp" suffix, I will remove it to avoid misunderstanding.
> >
> >>
> >> Also, this is a per-chip configuration, while I would have welcomed a
> >> per-partition configuration. I can easily imagine two cases:
> >>
> >> - The boot ROM, for longevity purposes, expects the first blocks
> >>   containing the bootloader to be scrambled. However the rest of the
> >>   system does not really care and disables randomization.
> >>
> >> - The boot ROM is not capable of de-scrambling, however the rest of th=
e
> >>   system relies on the (probably) more robust scrambling feature.
> >>
> >> In both cases a chip wide variable is not relevant.
> >
> > The scrambling and descrambling are handled by the NAND flash hardware
> > itself. Therefore, the boot ROM does not need to support a descrambling
> > feature.
> >
> > In the case of Macronix parts, the randomizer is controlled through a
> > configuration register, and once it is enabled it covers the entire chi=
p
> > (main and/or spare depending on the randopt bit). There is no hardware
> > mechanism to enable it only on certain ranges.
>
> After thinking once again, I am no longer aligned with myself from the
> past. This is perhaps too Macronix specific in the end and if it is a
> fully transparent feature, then why not.
>
> Are there any ways we can read the raw data (unscrambled) once
> scrambling has been enabled? (I mean, without changing the user default
> OTP state). Maybe one big difference with the raw NAND world that needs
> to be taken into account is that the chip itself always return
> unscrambled data, hence we probably do not care much, from a Linux
> perspective.

Unfortunately, there is no way to do this. If a user decides to use the
randomizer feature, they must enable it before programming the user OTP
area. If the randomizer is not enabled before the user OTP is programmed,
any subsequent reads will result in corrupted data.

Marconix raw NAND chip itself does not always return unscrambled data.

The ability to read unscrambled data is dependent on whether the
randomizer feature was enabled and configured correctly. When the
randomizer is turned on, the chip's internal hardware automatically
handles the unscrambling process. If the feature is not enabled, the
data read from the memory will be the raw, scrambled information, which
is unusable without the correct key and algorithm. In other words, the
chip only returns unscrambled data if randomizer feature is enabled.

>
> Thanks,
> Miqu=C3=A8l

Thanks,
Cheng Ming Lin

