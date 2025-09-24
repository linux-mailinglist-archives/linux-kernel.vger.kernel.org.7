Return-Path: <linux-kernel+bounces-829841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D82CFB9806C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 03:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652064A83E8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 01:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8473020126A;
	Wed, 24 Sep 2025 01:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmbGXOHh"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBA378C9C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 01:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758678464; cv=none; b=FQdr7adOvbtPHq/hT7wY2cWgCW3ITPkORyYThI9QAFaOavvgg5y4Y9l8+e9Yo87nD53AeZ9sjHNiHFgLYoNCS55HgK7gBetjiEWIQ4TmRh0H99Sxr5omO3fKlrqvfCTT4rJiBRJ/CKgGZSpHzSpxFmeclQjP+UHXxOsl7HXSj20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758678464; c=relaxed/simple;
	bh=y/x8B+ewK6v4dYgoVsbGDqM49RVsMdH/ggdy8onzgAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hgwpL5m9dQxOMThtuKzqRApJjqOmaIpVgQ0HNnw3vJSKmttqfVXDFhJwmlAZQhziL+I8AmwzKzqILIg1FzwdBMQEcoUjBO9TCLVBvLsJJoE2ej6KrrylwEto4ccWDkcD8wt+6qz9AZoEFM7ISwoK3w770zaboSXCJUBKdWCKM1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmbGXOHh; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4d142e9903fso22693761cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 18:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758678462; x=1759283262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLgOCUDCg3e15Xq9G1KQ1McYlea09igd4ZKI0Cxr/n0=;
        b=EmbGXOHh2YUEnhWeJ8VWhYDh2o49snz7Y4nGo0G+UBlg4wJIJ30pO2kBhoDFPOfVFV
         Mb67KsOAHLy0Q5ksUmqfUXhG7Cn+LkUZQZ9dg6zeTof/dakfwOpz1idVOozIC5L9f55Q
         z8UVWRBbQDJVTSd2+rs6+b6Mp+qladQb6WfbX5PVDBny3er0f9umqEdUwuoU+t8GFxq/
         Qp4L/Lcpic4uf70rcli34OddnMm1QwxHPCjGujVWz+bLX/64Frl1e5tjmDszmlvVFWZo
         sq1bz7Zck1enGuBLom4mYI9sFWPKreE8tHq2Z8z+U3iEcMs3qQWvOJhDswfUBnyMrdnK
         FMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758678462; x=1759283262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLgOCUDCg3e15Xq9G1KQ1McYlea09igd4ZKI0Cxr/n0=;
        b=RS2Sf1JBxnhszkflcBn1KfKAuWlBLBc7CCjukQUjcpkDSjm+c6qn4gRWgrf7PAXlbT
         uxsDc4nrJSe+ZddaPx0VJgH2Xqtz7g9Fj88dkJD/6mYmKDi090Du3w+eQB9pPrUcSjPI
         tDALt1EAzvMbHn1xfPAV8NCRW0i3atZPp+f2f14OvZcDbKxpT4OGCkpaRUsRzIGrsvsX
         NBqJSerCnNerxvA/aLQT3+xLNd0uj8+QbFcUQG5t2uA9wvfemkZv5q3g0W30lLk6msoZ
         dNlMq200yJdKSh+810D/Ws65K75Pfxl0odqi0lJUWX9bf+8Lg+FigJADnMmJsam90IhK
         GyIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw+z78drdwPV14fhlsbVq9GpkXiIzI7reUbDrneln5TNrhmpXnXkA4k9yUbdu0Xrij/sh1u1R1fYb8Cr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwAc7jU9C0uml5zvCZwJQvn1CDXXKhapDL5VNZ6r2DRfG7lBy4
	ENmDG6vd/uyF/iIIGLZ8Of7NQCdTPjmzxXh3V+eaRxm3kigt6C86wYfIqEekvnZtoPJI+Irc1P6
	o3VnUZ2XhyNlonje+X9vT57t5omNKj/o=
X-Gm-Gg: ASbGncu9uFIWRVD773q71O9Aov/Otj/ULbEv9ojgNMnLY7PYAlS3rCqJ1wuc0xq3D3e
	pL8c9GdP/7RxlTBddDMZtehq1H1kamR0gSpadtj7FcnmOEvWyvHNLODl1fB6OE7tE9pgzCn7TIV
	Vcb+RtAjFvFEnH+hOyu+lyM0bFvf8902CykhZbe7DqbD007XvVOFhQIwVwMMiIsIA/d96OK6Dyh
	wsDKy6bIoyZH/IQmRUnrJkFfEFjqqaA3t6D2nybaw==
X-Google-Smtp-Source: AGHT+IGIdRfHkiKs+mEVrqwOIqebc0C5zEl3UZbwuHFpU0JBMj41WZopp8n9Y9s727VjtGPa/Ul2Bjj4jr777iaGRvg=
X-Received: by 2002:ac8:5ccc:0:b0:4b6:299d:dfe4 with SMTP id
 d75a77b69052e-4d36b0ee114mr51190071cf.32.1758678461949; Tue, 23 Sep 2025
 18:47:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917101828.2589069-1-peteryin.openbmc@gmail.com>
 <20250917101828.2589069-4-peteryin.openbmc@gmail.com> <f76e867ca4dff82744958a8b555cf226139bcd78.camel@codeconstruct.com.au>
In-Reply-To: <f76e867ca4dff82744958a8b555cf226139bcd78.camel@codeconstruct.com.au>
From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Wed, 24 Sep 2025 09:47:31 +0800
X-Gm-Features: AS18NWC-njmIqq9F1PhVUvHcod54siZvcbKXObiObG8-iSHcZRG1G-1XqSgV-2s
Message-ID: <CAPSyxFSOBRT8muKmFbqc+_OkKZvO9YR9_bGvHVGaC2XP4yi=cg@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] ARM: dts: aspeed: harma: add sq52206 power monitor device
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andrew Jeffery <andrew@codeconstruct.com.au> =E6=96=BC 2025=E5=B9=B49=E6=9C=
=8822=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8811:36=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Wed, 2025-09-17 at 18:18 +0800, Peter Yin wrote:
> > Add the SQ52206 power monitor device and reorder the sequence.
> >
> > Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> > ---
> >  .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 28 +++++++++++------
> > --
> >  1 file changed, 17 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> > b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> > index bcef91e6eb54..fe72d47a7632 100644
> > --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> > @@ -353,14 +353,15 @@ eeprom@52 {
> >               reg =3D <0x52>;
> >       };
> >
> > -     power-monitor@69 {
> > -             compatible =3D "pmbus";
> > -             reg =3D <0x69>;
> > +     power-monitor@40 {
> > +             compatible =3D "infineon,xdp710";
> > +             reg =3D <0x40>;
> >       };
> >
> > -     temperature-sensor@49 {
> > -             compatible =3D "ti,tmp75";
> > -             reg =3D <0x49>;
> > +     power-monitor@41 {
> > +             compatible =3D "silergy,sq52206";
> > +             reg =3D <0x41>;
> > +             shunt-resistor =3D <500>;
> >       };
> >
> >       power-monitor@44 {
> > @@ -369,16 +370,21 @@ power-monitor@44 {
> >               shunt-resistor-micro-ohms =3D <250>;
> >       };
> >
> > -     power-monitor@40 {
> > -             compatible =3D "infineon,xdp710";
> > -             reg =3D <0x40>;
> > -     };
> > -
> >       power-monitor@45 {
> >               compatible =3D "ti,ina238";
> >               reg =3D <0x45>;
> >               shunt-resistor =3D <500>;
> >       };
> > +
> > +     power-monitor@69 {
> > +             compatible =3D "pmbus";
>
> I realise you're just moving this node, but I'm surprised it hasn't
> caused trouble otherwise. This happens to work due to a quirk of I2C
> device IDs in the kernel but it's not a documented compatible.
>
> Compatible strings need to represent the physical device. Can you
> please split out a patch either dropping this node, or replacing the
> compatible string with something appropriate?
>
> Andrew

Ok, but this device BMR350 is not in the pmbus_id[] list.
I will add BMR350 to the pmbus_id[] list, and then fix the DTS
compatible string.

