Return-Path: <linux-kernel+bounces-728068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA36DB02354
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2776617024A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50552EF2A8;
	Fri, 11 Jul 2025 18:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FQwzFBCb"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F60A2EAB92
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752257234; cv=none; b=NdItfIpLNB+xRwKbXIXPGd8cCpb07R8q9XcgQ0HsNdCXULdZMeTsbT15yPlBJyn8WSzY63ctAMetakjIOEKgBs4+fcJvHVFZnWCnIEweXxFSzJmd0GFWpXdXriSOn4Fya5Y/vBWXpxbmvbk1NqaCuep5WO+E0A0slhRJ4c+mkFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752257234; c=relaxed/simple;
	bh=yExFakHAJfI3qosFSAAl5RB1xxS2y15BsBL7kfeIt3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eA8AaOG8CilyluSj1rhTZFZvRz+0GS53ZFSyuFqfB1a0VLhhi4XGkRAVWzyHSXHoYjEbvCdOwI+7IHzvSQSL/olXUVrd7StKOftUuiCa5MpTi56wu8oy/O7/GLPP7shKQeJESAE+RWbZ6O5MkxL9VG7QGnAfViUr4VoZx4HY7Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FQwzFBCb; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32b553e33e6so18432121fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752257230; x=1752862030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nv3w+fmUK+KORgHTnerP5clwh8BNPjGSYNzQTi6VZkU=;
        b=FQwzFBCb4AjO/Z2QecOvAJhHUdUr6ikaoVpRID4LuKF7AOIijQzOYyu7LeXC9ecPLi
         UzvqHJ8oyGt1gZYW7NRM3cejh65tT2CBnMdurxkRziwQXKnTbDxK1jBNNGyGph26EoNB
         gF3tOkT73OW/NRcDkAeHrPs5SKS/jAD6rxnErxYX7WzVw3iS325TJKsj5M9ARPpHmSaI
         nXxqTdl6WxHbeu4Q15vu7/tTZ5KGx7vALBrftD51EGcL8rVkHqA8fwR6SRVgWh2zcan1
         2HDsuto7H36hgTSsVNH/w8TFX3Vh6DuKKkeCNoVZsOCoJDPCnnNkR6EuKwqi5BcXF0zc
         yatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752257230; x=1752862030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nv3w+fmUK+KORgHTnerP5clwh8BNPjGSYNzQTi6VZkU=;
        b=RD5I+RQo59HV3uvm1hyIpY6XR+sO+JKCyL42k1cmgjnF4s+PoINrk0BJcb4Q+I86NO
         Oq5srONRIt4p0T5Wx3kkxuxal9CScaotLviBRUTxHBTORiJGW0sC9hbpyowbpDeB9ERB
         L8ZODm5zOej/wpX6iZoO5rCo0BAfcpE+pz3KtB7gZRMMUBdeEY75sztBvZpu7fz5D90u
         C0vrpPfQb/QbGb9yhED7z3asdQQD8gxbEDUlqFECb6bY7qPXA1wG8CbKcmjsblwuoH7B
         ELq8MQUeA8Ky0qgT1MsqHjZE7AgNGZaFEkGOamUayaGXB+cXWvjkioKADjpfuTUr2J54
         ldWg==
X-Forwarded-Encrypted: i=1; AJvYcCVspDTKlIqyxXG5mnNOU4eSTaqYUeiogEk6x16lYZqZbiGA5UfTH1eHxeYRB9sBeFjcsCxLE5qFQYgUym4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTDPdWBz80DtoXR0rBZeEx3NCdZ2nf4E3V1WWQ///Bba1Tv0Xo
	Q0ZI2oZ9QQsdLqF3NLHoRDlk5lX9s2ocCwn3vVGobbM15AVnLcqSQT5aY9Vwz19+AvWtkwnNv9C
	zNqvKs+P2QUJAX0Sjw+TbjJEeW0CiTd4ThIDhGGttvQ==
X-Gm-Gg: ASbGncuzAiq8blIkG97fyIpJMvhPlAr19ubWv+9lWZb5YjodUNAiky18Zfk8qpfKB4f
	atYcLWRY2BSl34S1jY6OX7d14YTT4mxQdTuxfywjqn/BQ2i150jLsstSL6QDdRA2ha1XSK4TzLp
	VdItuBOm5vfMIxTZLQQkmHNfM3ctXDf4FmOGkVyLu4o9o+NiGbyBJjKl1vtZJ5TclQbO0GYz/KL
	rub86o=
X-Google-Smtp-Source: AGHT+IGIM1KxPQRBzMcvjUyIFovix8JCnhDiSC9t8kuenx33aIRcaw671XqV4qF75MRVLZo1ysDiT3HOSqWRKHB0f9E=
X-Received: by 2002:a2e:a592:0:b0:32a:5fe2:81bf with SMTP id
 38308e7fff4ca-33053411628mr14813671fa.24.1752257230460; Fri, 11 Jul 2025
 11:07:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709112658.1987608-1-ioana.ciornei@nxp.com>
 <20250709112658.1987608-5-ioana.ciornei@nxp.com> <0d0e9cee-2aaa-402d-a811-8c4704aadd74@lunn.ch>
 <CACRpkdYDTXA7+YN2zRCsQxu2AKEAwbDVq8-m27ah5XTw9iRNPw@mail.gmail.com> <55e7aeb5-565f-4452-bc11-55968dcc0a9e@lunn.ch>
In-Reply-To: <55e7aeb5-565f-4452-bc11-55968dcc0a9e@lunn.ch>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jul 2025 20:06:59 +0200
X-Gm-Features: Ac12FXzkmFH9ARMnDahmUtA_lkqp-uVRKNUJ3trz8WzNmuV5X5nO7f8132IvtH4
Message-ID: <CACRpkda+=A5R4vZZQZKmF3LnGd6xMYbNomahgTW+j9aX9swBFA@mail.gmail.com>
Subject: Re: [PATCH 4/9] gpio: regmap: add the .get_direction() callback
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Shawn Guo <shawnguo@kernel.org>, Michael Walle <mwalle@kernel.org>, 
	Lee Jones <lee@kernel.org>, Frank Li <Frank.Li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 7:45=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
> On Fri, Jul 11, 2025 at 07:43:13PM +0200, Linus Walleij wrote:
> > On Wed, Jul 9, 2025 at 5:09=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wro=
te:
> >
> > > This is not my area, so i will deffer to the GPIO
> > > Maintainers. However, it is not clear to me what get_direction()
> > > should return.
> >
> > This callback should return the current direction as set up
> > in the hardware.
> >
> > A major usecase is that this is called when the gpiochip is
> > registered to read out all the current directions of the GPIO
> > lines, so the kernel has a clear idea of the state of the
> > hardware.
> >
> > Calling this should ideally result in a read of the status from
> > a hardware register.
>
> O.K, so completely different to what is proposed in this patch.
>
> Maybe you can suggest a better name.

If the hardware only supports one direction, then .get_direction()
should return that direction.

What the patch does is to
read the direction from the hardware and use that in the
set_direction() callback, as if all regmapped hardware in the
world had fixed direction, that's wrong.

I'd just add something custom in gpio-regmap if this is
something reoccuring in regmapped GPIO drivers.

bool is_fixed_direction(struct gpio_regmap *gpio, unsigned int offset)

or so?

Then the core can use is_fixed_direction() together
with gpio_get_direction() to check if it can do
a certain set_direction().

Pseudocode:

mydir =3D get_direction(line)
if (is_fixed_direction(line) && (mydir !=3D requested_dir)
  return -ERROR;

Yours,
Linus Walleij

