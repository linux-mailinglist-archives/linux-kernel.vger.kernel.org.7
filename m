Return-Path: <linux-kernel+bounces-867970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 130A5C0408C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11291A01E32
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 01:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D70E1C9DE5;
	Fri, 24 Oct 2025 01:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYLmSNKB"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA49738FA6
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761270180; cv=none; b=Kr8BHfV0p5iiSC8AHafg9HsCMdej6fcmvjLnE6D+qpp5iGifabZlBZJoGVA8dgLka+kllsgrLzaiyOUZUKQ25J2SVxOkv1vQ6VnxrQFoB9yegwfh8pGtfFReT9KfqKzTVzzHO5oWOYaZtT+vtZFa76M3DiVBKXp109xQGzLmCAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761270180; c=relaxed/simple;
	bh=Gp2UP6WPoEHKVVhOqyaK/3ITaNQsf40VL330L1MeraI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l61xmaLbf5MG1XoacnW9p+0/A71wKVk4OtHIC3eQ0z1dO+6Ej+ZUbpfN/f0oixxE5PqcSXjwSNCSSk0MBrO/enXtcSfGgrmTCPSJ5n3Rcr0JKJYfJbC6qr8CScgxM/K54KerIwdnMr7Kro1bG9Ld2XxkS30Xt2a5lvCmDw7Ol5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYLmSNKB; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3c9b5ce8297so1399322fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761270178; x=1761874978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAbS/I/ENAzCitCydMxMmGwL+5iHoTPGPWV8yBVNDn0=;
        b=UYLmSNKBj2NbLQsPcFUuGXfinEhYfQAitTaR8e7Vzt20/C9J2PE0TpSkGo0OkmndYV
         yJ89cJSdfSmBAdWP2JPtR48FtrYt8UfI73QtGMkLGy7DsSnN16GwGAgVEWc2KdeoSSBI
         lhH4l/a9ljJ3QES/rzZMfBpoGZrpekV0DzDzH61pybyqQvc6NjhrILOX8ZVQk1ZlF513
         l5r1SoM7vCQQrfOe9E8+wo+CLgiqLI0KM7ApZsA0z2EAW//lKR8S3wFtgYKfVbFifCG+
         a3xokd57Hl8Ej90yOecXGAzrSLQmgA6ZmfskzpUFTTTo8hg3zio5/brr4QgvJ6zDHA6D
         mtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761270178; x=1761874978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAbS/I/ENAzCitCydMxMmGwL+5iHoTPGPWV8yBVNDn0=;
        b=NpL8NGSb7x6Get00FlKN+UNsdjE9ew4PUkWTHHrzHQjvLoZPkbFrX8cbySzgGvLmU7
         Epz9144qFGQEdcG3gqSIuPtw3UWjAnDKQP7ILtHoNeeap3Q3HYLLdycqNuJVNdy2qqMd
         R9taH39MF2KlM4XD1fufsQZZb6+9YkeaX+LM3fmqs3D1kUHSMWooT1IZafaw700MBeJR
         Z2a4Hv7dnGYyemiSHgY46pNh7gJE28j1TFS6Y3+EDmwIh6vD+fnZKMF/QPnheo1ljhDV
         iVfBNo46InprTiIfBZvRUargZ2i6H8+IxitMNqjfZrodko6JZGYwOJVH/klqvYYn3jWS
         aQSw==
X-Forwarded-Encrypted: i=1; AJvYcCVJAlZLoBUIm3V0+b7OkofU2ng/ANXKhmgsIfi5GSPPLPPyRu73Py3absS4h52C9GjF4idNWoCHm8EH3sw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo/EwUmLZSxpSOb8lK7cMXjfojOP6UNZiHYgGT1O+z70YXZjgW
	NAjhGJdesj/p8KhUJa5OZak1Fuju86ZUi2dBcynta5UUmoaXXGqPulK8sbBBA+ui6f4iOtUW1dM
	r937BFVeDMI8V2r4OgWXPTpmUYZ4Zwe8=
X-Gm-Gg: ASbGncvGhJTfyoU1Ir6xjsnN5h84wWdV4n2gloQTBb8/SFNmIu/dTtkpezl5VKlqY0D
	iL/YsqfdQsHShj9obToz1jeephrFIk/d8iqW/2a/xYdcLRI+8WrapNYtd9o+ALXoY7DJ8puFml0
	lf2A2m2axG5KKF5acHwriLnccYbh2d9ZwibsC8UczUb3Iw1w1IDaxg/mCGPi6DRIHUPga4KpTTr
	8VFhuSIBy0UbjI0SUnQAl+of7tbGj/RPePfiAdBsZTPPHtrZ4cnGxB71yyr1rDTpenWDA==
X-Google-Smtp-Source: AGHT+IFOrs3kAu333i9kjtC7Z4VNGNTt0EV9dP15noDMl6HW4uB2m9tABAka0QntVdtaXJk8/BQlYI7Rv8qX6VpdwoU=
X-Received: by 2002:a05:6870:194f:b0:3c9:77fb:dc3b with SMTP id
 586e51a60fabf-3d173332ebbmr410914fac.18.1761270177796; Thu, 23 Oct 2025
 18:42:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022030840.956589-1-Wenhua.Lin@unisoc.com>
 <CAAfSe-uq6GszSLgtM+UBuwJ6V1Bt0_1Ard8cb6e9MMCsdpJPqw@mail.gmail.com> <CAB9BWhdKd93kJxPJv10X5uZ00O8d5NugoehX3_QtjmXQOMhDig@mail.gmail.com>
In-Reply-To: <CAB9BWhdKd93kJxPJv10X5uZ00O8d5NugoehX3_QtjmXQOMhDig@mail.gmail.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Fri, 24 Oct 2025 09:42:20 +0800
X-Gm-Features: AS18NWC32uQ6w5HtSVr1L-03d5RGkfSam7lucV4ocAv1EGY-5LX2aClPYLicTtY
Message-ID: <CAAfSe-sTUC=mW-iO+NK+mq2i8GEv1RaNPvCGgQwb23dOFBigXQ@mail.gmail.com>
Subject: Re: [PATCH] serial: sprd: Return -EPROBE_DEFER when uart clock is not ready
To: wenhua lin <wenhua.lin1994@gmail.com>
Cc: Wenhua Lin <Wenhua.Lin@unisoc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Cixi Geng <cixi.geng@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>, Zhaochen Su <Zhaochen.Su@unisoc.com>, 
	Zhirong Qiu <Zhirong.Qiu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wenhua,

On Thu, 23 Oct 2025 at 10:10, wenhua lin <wenhua.lin1994@gmail.com> wrote:
>
> On Wed, Oct 22, 2025 at 2:55=E2=80=AFPM Chunyan Zhang <zhang.lyra@gmail.c=
om> wrote:
> >
> > On Wed, 22 Oct 2025 at 11:09, Wenhua Lin <Wenhua.Lin@unisoc.com> wrote:
> > >
> > > In sprd_clk_init(), when devm_clk_get() returns -EPROBE_DEFER
> > > for either uart or source clock, we should propagate the
> > > error instead of just warning and continuing with NULL clocks.
> > >
> > > Currently the driver only emits a warning when clock acquisition
> > > fails and proceeds with NULL clock pointers. This can lead to
> > > issues later when the clocks are actually needed. More importantly,
> > > when the clock provider is not ready yet and returns -EPROBE_DEFER,
> > > we should return this error to allow deferred probing.
> > >
> > > This change adds explicit checks for -EPROBE_DEFER after both:
> > > 1. devm_clk_get(uport->dev, uart)
> > > 2. devm_clk_get(uport->dev, source)
> > >
> > > When -EPROBE_DEFER is encountered, the function now returns
> > > -EPROBE_DEFER to let the driver framework retry probing
> > > later when the clock dependencies are resolved.
> > >
> > > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> > > ---
> > >  drivers/tty/serial/sprd_serial.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sp=
rd_serial.c
> > > index 8c9366321f8e..092755f35683 100644
> > > --- a/drivers/tty/serial/sprd_serial.c
> > > +++ b/drivers/tty/serial/sprd_serial.c
> > > @@ -1133,6 +1133,9 @@ static int sprd_clk_init(struct uart_port *upor=
t)
> > >
> > >         clk_uart =3D devm_clk_get(uport->dev, "uart");
> > >         if (IS_ERR(clk_uart)) {
> > > +               if (PTR_ERR(clk_uart) =3D=3D -EPROBE_DEFER)
> > > +                       return -EPROBE_DEFER;
> > > +
> >
> > You are making this clock mandatory, sprd_serial driver could work as
> > serial ports for logs output without this "uart" clock.
>
> Hi chunyan:
>    Thank you very much for your review.
>    This clock is actually mandatory now=EF=BC=8Csome SPRD project use def=
ault 26M clock,
>    some new SPRD project use default 24M clock.  If driver can't parse

Oh I see, then you can set a different default clock according to the
compatible string, that's saying make SPRD_DEFAULT_SOURCE_CLK to be an
element of "of_device_id.data".

Thanks,
Chunyan

> this clock correctly,
>    driver will configure wrong baudrate and make the log garbled.
>
> Thanks
>
> >
> > >                 dev_warn(uport->dev, "uart%d can't get uart clock\n",
> > >                          uport->line);
> > >                 clk_uart =3D NULL;
> > > @@ -1140,6 +1143,9 @@ static int sprd_clk_init(struct uart_port *upor=
t)
> > >
> > >         clk_parent =3D devm_clk_get(uport->dev, "source");
> > >         if (IS_ERR(clk_parent)) {
> > > +               if (PTR_ERR(clk_parent) =3D=3D -EPROBE_DEFER)
> > > +                       return -EPROBE_DEFER;
> > > +
> > >                 dev_warn(uport->dev, "uart%d can't get source clock\n=
",
> > >                          uport->line);
> > >                 clk_parent =3D NULL;
> > > --
> > > 2.34.1
> > >

