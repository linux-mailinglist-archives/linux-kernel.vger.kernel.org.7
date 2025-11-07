Return-Path: <linux-kernel+bounces-890908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB9DC415BB
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 19:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B5A3A7AD6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 18:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945CD33B97B;
	Fri,  7 Nov 2025 18:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdoTi6BG"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00220335095
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 18:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541736; cv=none; b=h4nW97SL9m58foT3+qQQ4SOMXNBa04OmCCM93zMu5hWG1ZIMnEA9Y+8cd6UukTCRmXq99De7R/aIZSrkjE2F8+zeroxpprAyUc3gyGIZazB+xuDT6j+TjLGR9/vWyafIPEUe1vHHmruRmifny7zuenutG6uQcwa5ttZMrIFG5uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541736; c=relaxed/simple;
	bh=IdtM5FvAG0CA3/E9xLGv8ZkSNkz0C6s2910O2wI6WPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1uI4LJjnkheoxMZaoOVa/B1FMbQYRHaSjz7xuNMi0jcOhaNq36u0jm/QbwrPomH3A/HQquYvWGrmAeis5+Xw1j7xNAkOxHWBC/r9X3V5WxeI9QPBeJezASbFR4OO/IiklVGCJ4Xl1u8w4SpVtdevKqsW3BWbTwP//TBRBbDa1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdoTi6BG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4710683a644so7229645e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 10:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541732; x=1763146532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYOFjOauC9uTwp6iLyWT9D/OqXU3tri/WbPZz+gGnEI=;
        b=XdoTi6BGPJHgh8HuCKKgiZgd+1b066E9SePyQ9tPFBGkk0fnKYhhuk6u5VYahSojLD
         zX8xHiO7Z7fm376QDK4qsL+gYRzffUIPcXLKmKb9OnD4poYo7F0NZJssI7Iz5Dfzpbyl
         4kDM6dnd4Dy4qYUeNKv8jTLIHPiSmMnxstIGcz8lQKwxTjgWW/XYY7YptDmSfrialHN7
         D+A42kfndtnO0UUd5wxuq+ocD+/ZA28QqmM10DsVzRwoVEBgRgHAZ1WTFAwql1Ehenxk
         a2FlJL/AL3YYhNJIaUtNCn7wgJ1BZ3dZn/jhUzZwE+PkjsGFAgcVMOkxqzU6MB0o1BlR
         wxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541732; x=1763146532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HYOFjOauC9uTwp6iLyWT9D/OqXU3tri/WbPZz+gGnEI=;
        b=saXyYqJfy+hGRZKs2VS/BxpiJ+im+Sgz8XGfk8n9tH6IloJQ5DV7RKVro1w7t5SxwJ
         /mis3Xzs73di/WAPMIUrtTK3uXxj3tJ4+KNlD6KxXniYejKHGLfejU2elPmL481CRLgL
         boYCfob7zkoTtzAI0c146CmjGat5RFb7T+pzmGz1gjQvwSQ8/KqpVOsWTNFLyIE0ZHmI
         bmyKI7PX0xbnTMdNR65dewMqhHqMg9m5tsyj7TwVvjeCrPj8xJpwvrOOUJdvHxHV3s0B
         8aF4seJg7kHw/3ibQE+qsU5hq3ZmRa5vUOE2xqMq6xR65Vd9ARdiiqxTxXnOGaKn0Qk4
         r5MA==
X-Forwarded-Encrypted: i=1; AJvYcCVT/g0k5ZoBo85iPPb4tzOY5gRQyXOA0QDzgkm87gmf74m1kAtHjeM/sGNiTmNKG0sosdTyvJQ/wCIJ7WU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDyI9G+odphySBgXEcIm5v1oqbp9z3ZdjTJM8Hw4FaQLJgWm2x
	N3hYFZEAou5MDr8IqN4UphZ3cfMfvSqq7EODntI2aQEpVtSTsTz9+TV//EsKBSEL6qNdiuFp6HM
	XiYD69xeX8J4YPFL0HIZzcEq1X112a9A=
X-Gm-Gg: ASbGncuBKK9JqTU+hjp6tJFVjKNOrzfVs8dA3nkJM60Q/z3wQ4aPePIfT51lmeqeepf
	2iopTD35pELJ13E8uA5Y+2O20P8E25fXbcC67qpLxmbcz4Zsz3+1wj4BLokKdgeqaOPjXHQUfuN
	7iN3YeJmLuxv9iDI+ijO3MJIFFXXysMjfbAzxS27BABK06YryeU4dkwoN7/C7356E+fa3QCzGxf
	CFnmGcqJrOhItLEklwhHPVJftINw8rM32wD4uAl6aiUzzrjADnFtMBZN70x
X-Google-Smtp-Source: AGHT+IHRiq8LOI7XDfcnPBif5Be5tlbEofXfFjh2SF9CKa5iZ2LCl/Y697lC6+uXYXH4qXNN3Gqe5tbSe6dhD42hJjI=
X-Received: by 2002:a05:600c:1d0d:b0:477:bf1:8c82 with SMTP id
 5b1f17b1804b1-47772dfba72mr4536435e9.15.1762541732159; Fri, 07 Nov 2025
 10:55:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106200309.1096131-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ee6a79ae-4857-44e4-b8e9-29cdd80d828f@lunn.ch> <CA+V-a8vFEHr+3yR7=JAki3YDe==dAUv3m4PrD-nWhVg8hXgJcQ@mail.gmail.com>
 <2dabb0d5-f28f-4fdc-abeb-54119ab1f2cf@lunn.ch>
In-Reply-To: <2dabb0d5-f28f-4fdc-abeb-54119ab1f2cf@lunn.ch>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 7 Nov 2025 18:55:05 +0000
X-Gm-Features: AWmQ_bnn3KbAT4rF9IvIcF36WFZWDqZECyk5JzQF2JLVOWx3xWwFfMtNq7cdMzE
Message-ID: <CA+V-a8uk-9pUrpXF3GDjwuDJBxpASpW8g5pHNBkd44JhF8AEew@mail.gmail.com>
Subject: Re: [PATCH net-next] net: phy: mscc: Add support for PHY LEDs on VSC8541
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, Nov 7, 2025 at 1:14=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > > @@ -2343,6 +2532,26 @@ static int vsc85xx_probe(struct phy_device *=
phydev)
> > > >       if (!vsc8531->stats)
> > > >               return -ENOMEM;
> > > >
> > > > +     phy_id =3D phydev->drv->phy_id & phydev->drv->phy_id_mask;
> > > > +     if (phy_id =3D=3D PHY_ID_VSC8541) {
> > >
> > > The VSC8541 has its own probe function, vsc8514_probe(). Why is this
> > > needed?
> > >
> > vsc85xx_probe() is used for other PHYs along with VSC8541 hence this
> > check, vsc8514_probe() is for 8514 PHY.
>
> Ah, sorry. I was looking at 8514, not 8541. So yes, this is needed.
>
> However, i think all the current probe functions could do with some
> cleanup. There is a lot of repeated code. That could all be moved into
> a vsc85xx_probe_common(), and then a vsc8514_probe() added, which uses
> this common function to do most of the work, and then handles LEDs.
>
Certainly the probes can be simplified into a single function. I'll
create a patch for this.

> Also, is the LED handling you are adding here specific to the 8541? If
> you look at the datasheets for the other devices, are any the same?
>
Looking at the below datasheets the LED handlings seem to be the same.
Do you want me to add this for all the PHYs? Note I can only test this
on 8541 PHY only.

VSC8541: https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/Pro=
ductDocuments/DataSheets/VMDS-10496.pdf
VSC8502: https://ww1.microchip.com/downloads/en/DeviceDoc/VSC8502-03_Datash=
eet_60001742B.pdf
VSC8514: https://ww1.microchip.com/downloads/en/DeviceDoc/VMDS-10446.pdf
VSC8501: https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/Pro=
ductDocuments/DataSheets/VSC8501-03_Datasheet_60001741B.pdf
VSC8504: https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/Pro=
ductDocuments/DataSheets/60001810A.pdf
VSC8530: https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/Pro=
ductDocuments/DataSheets/VMDS-10516.pdf
VSC8584: https://ww1.microchip.com/downloads/en/DeviceDoc/VMDS-10455.pdf
VSC8582: https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/Pro=
ductDocuments/DataSheets/VMDS-10421.pdf
VSC8575: https://ww1.microchip.com/downloads/en/DeviceDoc/VMDS-10457.pdf
VSC8574: https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/Pro=
ductDocuments/DataSheets/60001807A.pdf
VSC8572: https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/Pro=
ductDocuments/DataSheets/60001808A.pdf
VSC8562: https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/Pro=
ductDocuments/DataSheets/VMDS-10475.pdf
VSC8552: https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/Pro=
ductDocuments/DataSheets/60001809A.pdf

Cheers,
Prabhakar

