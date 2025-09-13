Return-Path: <linux-kernel+bounces-815114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A87EB55FEE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 11:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE60E58852F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 09:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56AF2E8B7B;
	Sat, 13 Sep 2025 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivrUq5tj"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6088C29DB99
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757755761; cv=none; b=szlqhkdbjyeBm9m9PwQnl0bWIqNSWq0jedUEspzW4hiDpRyUZO76FReZCTMhQoBF8e7Mo/8FxrCQYF02FbHU62R9sm1uWBZeIR+/M1JD1KvbAr+zx+rXyI9Ghd9FyDhQzTspk8OSOufJIBpPfQsBkV1VZUBkVYquZkq5sLFmwvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757755761; c=relaxed/simple;
	bh=8KECooiguoFsg53E7rkhnQcrb+WVUBu+SlwPVT+sY7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMaYjajgLXMYT22OXgdcpmGi+nVQKGC7v1liKz/qHsoIQdJ51WiXUMZGIG+nfqPsEDGEK+ElaE4kRElkWT8+nawEcyq5maLDMVZzpBLtHwZInnMA0B+NHil39ihUcnVQtosVxLnrsE+fU9udDxW+hod7mWT720IhPS/RZv1dz3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivrUq5tj; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-890190c7912so743636241.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 02:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757755757; x=1758360557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hpXAGaVCNI8VKWlBxzDF3/2pMhCFKKzKfanUfijSGo=;
        b=ivrUq5tjk0dPjBxbzwCO35vyETBNaAMO5Yi0Y9QEsUNQKeQflt+OGhroGJdKgDeNhW
         1yY2WIcQnhUfJZAVse4Ih7pR2Dv/hC+2exXD0x70OUfm0TdqBbAqOIwBRri15R61d/+H
         W2zwG7n+gXeZIth9EzDOvm9m1P9bfl++Ruqcj+lgh+yhEP9FhycWOud+M3RqkCnoUg5E
         eVG5Z2+yk/NCASJELfHoiANvekLt1SEXB+xY4EMPp1znPbJRvAbut0fiLpPC8lbsx9rw
         K98IpXAGLd8Df04qbGkDdN1nefv4w3tz2ASZkPYeY2ZfujMfU+AleNZPotOVXLox4hpt
         lZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757755757; x=1758360557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hpXAGaVCNI8VKWlBxzDF3/2pMhCFKKzKfanUfijSGo=;
        b=hFSq7kzQMR0QZG60WKUjT81o/wMTsc5s1dlaYflGzGmp3CSM7jJ+XKtUVfUz9D4NIP
         wpIeTfoqxeWdqoKWGWcJy3L6IqIiK0LYE7/7/F2rBeYPiRxYJfHkpkBN2mG05hQ6xLBs
         V8eB7eIsDgs2m7UE2CM2qN4niApWszra1Mr/B5Js9jAjuWVDaJpuDVF7V/mBvvLsGHIq
         yO+RCS0tyf2EYXvmaz886Rlt6s39xANE1sMAY0Qwx94p1V1L2+lZtSwMsWe3X/OHiaqW
         spO6rL4IuM16Ja4etC1iWJGzgOiusC5JofxVabiv4amNlMXFfWlxCm6+3CDsE4ki1Ciy
         qWBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYW4TOyYeLSGx4JsNCXPYP6FxA6YeQHLOEMNiOlI91yB+EZJRcyBG9NAZ8ucsbJsxbHOOMWjldbdK6WKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk6cXvpjIoj2kfwBvOg/4egbCVQzLHj/pXuxV/FBHL/rj7/EXB
	gxqVMRpkgu6svCuFwhHYhySyUyOO+15tbu5h8RHZkx4i6f/PYbOD17uJbTKNhhbWic+vosG1dMp
	5SPzMeAC4xwrw225TOgp3bBSiLWOLt+A=
X-Gm-Gg: ASbGnctzxNWkM5srul8EZpYMuIAkwVKVtQtmkIw502J9sUAsBa3S4Px76gKVSw+2JOu
	yFquutoeXzXq+X7pubcFYFHV7Debv3Ao4XrDhvQMOAHSKnvXUiw7h541Z1gzqgBCsdo9ufjXEUW
	/s8/4uD3ninjZJ1pZDKjyO75AGuv0bO/KfJh0yulpImR0uXjPpqxwZjpOSfXGpLzqQMlsanwTl8
	4T3GP4=
X-Google-Smtp-Source: AGHT+IF1tpIgRKc0Kjd90cmIEFUZM2Fe4ziJOCTrd+iiCXW/77FmQOzrFrTYzgnyYA+0/gkm3WFMSyhFsQeg+Kodd1o=
X-Received: by 2002:a05:6102:d8d:b0:555:56e0:f372 with SMTP id
 ada2fe7eead31-5560908d470mr2397200137.2.1757755757060; Sat, 13 Sep 2025
 02:29:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911184528.1512543-1-rabenda.cn@gmail.com>
 <20250911184528.1512543-3-rabenda.cn@gmail.com> <20250912-gander-fox-d20c2e431816@spud>
In-Reply-To: <20250912-gander-fox-d20c2e431816@spud>
From: Han Gao <rabenda.cn@gmail.com>
Date: Sat, 13 Sep 2025 17:29:06 +0800
X-Gm-Features: AS18NWD-tBqk49KioxOmXqHDB8mXESNI-lFCAKSwfVB70oRBqo6Nz_fXy22ttJU
Message-ID: <CAAT7Ki_WD+X64oTPro=yn2de+Y_W9B2iDVE2cmRhV=TnQiUmPQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] riscv: dts: thead: add ziccrse for th1520
To: Conor Dooley <conor@kernel.org>
Cc: devicetree@vger.kernel.org, Drew Fustini <fustini@kernel.org>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Han Gao <gaohan@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 1:57=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Fri, Sep 12, 2025 at 02:45:27AM +0800, Han Gao wrote:
> > th1520 support Ziccrse ISA extension [1].
> >
> > Link: https://lore.kernel.org/all/20241103145153.105097-12-alexghiti@ri=
vosinc.com/ [1]
>
> I don't see what this link has to do with th1520 supporting the
> extension. The kernel supporting it has nothing to do with whether it
> should be in the dts or not. A useful link would substantiate your
> claim.

Existing rv64 hardware conforms to the rva20 profile.

Ziccrse is an additional extension required by the rva20 profile, so
th1520 has this extension.

Link: https://github.com/riscv/riscv-profiles/blob/main/src/profiles.adoc#5=
11-rva20u64-mandatory-base
[1]

>
> > Signed-off-by: Han Gao <rabenda.cn@gmail.com>
> > Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
>
> You only need to sign this off once.
>
> Cheers,
> Conor.
>
> > ---
> >  arch/riscv/boot/dts/thead/th1520.dtsi | 24 ++++++++++++++++--------
> >  1 file changed, 16 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dt=
s/thead/th1520.dtsi
> > index 59d1927764a6..7f07688aa964 100644
> > --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> > +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> > @@ -24,8 +24,10 @@ c910_0: cpu@0 {
> >                       device_type =3D "cpu";
> >                       riscv,isa =3D "rv64imafdc";
> >                       riscv,isa-base =3D "rv64i";
> > -                     riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c", "zicntr", "zicsr",
> > -                                            "zifencei", "zihpm", "xthe=
advector";
> > +                     riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c",
> > +                                            "ziccrse", "zicntr", "zics=
r",
> > +                                            "zifencei", "zihpm",
> > +                                            "xtheadvector";
> >                       thead,vlenb =3D <16>;
> >                       reg =3D <0>;
> >                       i-cache-block-size =3D <64>;
> > @@ -49,8 +51,10 @@ c910_1: cpu@1 {
> >                       device_type =3D "cpu";
> >                       riscv,isa =3D "rv64imafdc";
> >                       riscv,isa-base =3D "rv64i";
> > -                     riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c", "zicntr", "zicsr",
> > -                                            "zifencei", "zihpm", "xthe=
advector";
> > +                     riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c",
> > +                                            "ziccrse", "zicntr", "zics=
r",
> > +                                            "zifencei", "zihpm",
> > +                                            "xtheadvector";
> >                       thead,vlenb =3D <16>;
> >                       reg =3D <1>;
> >                       i-cache-block-size =3D <64>;
> > @@ -74,8 +78,10 @@ c910_2: cpu@2 {
> >                       device_type =3D "cpu";
> >                       riscv,isa =3D "rv64imafdc";
> >                       riscv,isa-base =3D "rv64i";
> > -                     riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c", "zicntr", "zicsr",
> > -                                            "zifencei", "zihpm", "xthe=
advector";
> > +                     riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c",
> > +                                            "ziccrse", "zicntr", "zics=
r",
> > +                                            "zifencei", "zihpm",
> > +                                            "xtheadvector";
> >                       thead,vlenb =3D <16>;
> >                       reg =3D <2>;
> >                       i-cache-block-size =3D <64>;
> > @@ -99,8 +105,10 @@ c910_3: cpu@3 {
> >                       device_type =3D "cpu";
> >                       riscv,isa =3D "rv64imafdc";
> >                       riscv,isa-base =3D "rv64i";
> > -                     riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c", "zicntr", "zicsr",
> > -                                            "zifencei", "zihpm", "xthe=
advector";
> > +                     riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c",
> > +                                            "ziccrse", "zicntr", "zics=
r",
> > +                                            "zifencei", "zihpm",
> > +                                            "xtheadvector";
> >                       thead,vlenb =3D <16>;
> >                       reg =3D <3>;
> >                       i-cache-block-size =3D <64>;
> > --
> > 2.47.3
> >

