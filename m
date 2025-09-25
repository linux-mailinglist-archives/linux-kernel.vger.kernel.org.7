Return-Path: <linux-kernel+bounces-832064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03879B9E42C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F112E5B9D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBA52E8B94;
	Thu, 25 Sep 2025 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="QD573Isa"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5251E2E9EA6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758791769; cv=none; b=B+zngkO8v4b8QR4nUMUUweyMtNRwo6e5X9U2vyy2IdmzjYCQrBKYikaLFJEUtI6f4khHN+zADgqpBGF/LlFJ1TExrizOJs3MVgc24YXrW4WupFznMpOuh1XvWwh48pqf7ZZ0YA2MTshQxV/9fS6kYl1GXMue2u2hlSKKzPpwyCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758791769; c=relaxed/simple;
	bh=R6b2qrjJDoLl8JjJK1a1b6g2iWguvqkL8xGkWDqxDs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HLtckX+eRqqs8wJcvrEMBa3ufpTt4UnwZM2iqYeuotDdxGKqmjAOiimfaROtjWQqO+qvbwZsIOt4OxchfRxY8w1ETmeFFJVc+LtMPMhyuCHW0Xf8yVDCp3onY/YpMdDdElTKk3vEe7TR8UPQhgmaX58pJqHP2mgAchQJKlIWcgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=QD573Isa; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-62fc89cd68bso1458539a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1758791765; x=1759396565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfwIA2slikNrtiwNNvj+NlMW/ldb/AEMdOl3nm8LmqM=;
        b=QD573IsaEi2jQqil2YtjW7Jxl3u3XROIGN8MqvemzClU+9mvxnGL/JOjw5qH3eD8xy
         X6yfT5ijTXoWgfJW2RG5EaJHXwio3ziXV0I1ZtKgtf/H6k7ZxGLFLTQ3XVrOJRR5W3p0
         jVYGj6dnvKbR0PabmV7XNi7/qexHEASIrHJb+xkM7bjm+rs+NPL0bQEyUUr+Ediz4d8F
         HjyAtVPYosVgepmOC1oy7X0VgELfONwRF12DU+RU1Le30o4HJ6q1PtjcNYT65liN/5vJ
         2VQe9SOLIbJJWD1rD9vkhECalPj22HfrpLBIMTrZZLS9jOKlo4u3frJCXsQ8R/i4mdmZ
         PSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758791765; x=1759396565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LfwIA2slikNrtiwNNvj+NlMW/ldb/AEMdOl3nm8LmqM=;
        b=jjZFsHZDS2C/1UUZacy5p2o4Iey/y+y/AGS//x/z8wfnvZ6cybReOwmxTmFctS6Lt6
         lcVJf3IL7JG1H9yosO71Wn3zGE9sl+70bv9U4kke2CsxeZgigJ7zTvpBezCFy01sSE6k
         q8IM6xeaoPRxm1oZuVNpKoDLWYcjKmzVXtc9dlkh+JHzTDALeLrYlmu3b9pMVjeWJa/D
         g3PMkbkwotN/iXpXT9ArK/qkLYfRL7j2PLZbtildQi1lTv+HG9nSXaIAZT+v5igK7eEc
         IoVMT07Lmcj4yRUpscJRAFl+QQj4VJpB0Or6wAxXaW1CpNDsz9iUtlLxx5Xe+gtcp0Sp
         NM3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCy3D1R9nl12YzxCpme1pRhw/K+/VCjfpBsdgzk4UNfZjWIqT9pTrVwuPlgpk3XE5MyaDjJl8Q6kt857k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjP673agmw7/rQqRnYte8G1E6ClD6QxOD6Tc1QB66pbbs2QY1D
	3j5D2UoRCFUkkdG8pcGqWNyVrRbE8w2X5iWRskdSqVRYDnxb4AN5/DDaCV2SMhv0Op9q//u9hzc
	amx7LVJ+bNBBBabVWXBAD1loF60+AUN0Eo7+FrEDC9uRxu2PhO7RXKwY=
X-Gm-Gg: ASbGncuBmervTQ7pESwqifcnbPOemeznk/lOhR3p8LhtW3z08vIcmHpE/IkS4P1trsS
	4rVt1pu9CkSTMjn8+kRg3PodsWnTthlcVwaVdatTKv5J6jtjhSRlh78w2P8szo03xp5QyWiCk8s
	eggPnzaD/V1oxyya8h4DykhWg/IxxHxgt+VA0mos46TludDCsPg7vU3cg918AasPGM7yIaKrPbo
	6bOaVzR
X-Google-Smtp-Source: AGHT+IH9w0rQRH1Xdl8p6KeJ3RT0NiQtsRn5ud9cIpEwnBYA3yBXFW6rDCw8YS4Ajxey/LxrtrwFxA5aH+cYhT5GYYY=
X-Received: by 2002:a05:6402:5357:b0:62f:a3ae:ff0d with SMTP id
 4fb4d7f45d1cf-6349f9eef37mr1894435a12.14.1758791764570; Thu, 25 Sep 2025
 02:16:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924213027.1887516-1-robert.marko@sartura.hr> <f019dcef-afdd-4d18-b28c-b214fa14f1c8@roeck-us.net>
In-Reply-To: <f019dcef-afdd-4d18-b28c-b214fa14f1c8@roeck-us.net>
From: Robert Marko <robert.marko@sartura.hr>
Date: Thu, 25 Sep 2025 11:15:52 +0200
X-Gm-Features: AS18NWAQPVOYppZ1_b4enxd-K6lpZFgT-FBM-ttaaPmwezyFrJXb-irLkljRWpg
Message-ID: <CA+HBbNFe+7XT3bSUEagsXiug-bmh=fBfLAW0d7WR73Di8-ozTA@mail.gmail.com>
Subject: Re: [PATCH] hwmon: sparx5: make it selectable for ARCH_MICROCHIP
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	daniel.machon@microchip.com, luka.perkov@sartura.hr, 
	benjamin.ryzman@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 12:07=E2=80=AFAM Guenter Roeck <linux@roeck-us.net>=
 wrote:
>
> On 9/24/25 14:30, Robert Marko wrote:
> > LAN969x uses the same sensor and driver, so make it selectable for
> > ARCH_MICROCHIP.
> >
> LAN969x _is_ the Ethernet switch driver for Sparx5, so this description d=
oes
> not really make sense. Same as what ? Itself ?
>
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> >   drivers/hwmon/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 840d998f850a..ba2b7b2f6c44 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -632,7 +632,7 @@ config SENSORS_I5K_AMB
> >
> >   config SENSORS_SPARX5
> >       tristate "Sparx5 SoC temperature sensor"
> > -     depends on ARCH_SPARX5 || COMPILE_TEST
> > +     depends on ARCH_MICROCHIP || COMPILE_TEST
>
> ... and silently disable it for ARCH_SPARX5 at the same time ? That is no=
t what
> the description says, and is completely unacceptable unless explained.
>
> >       help
> >         If you say yes here you get support for temperature monitoring
> >         with the Microchip Sparx5 SoC.
>
> ... and, on top of all that, still claim to support Sparx5 even that is
> no longer the case.
>
> Ah, I see, this patch depends on patches in linux-next. You might want to=
 say that.
> Also, there is context missing: If the sensor is _only_ supported on Spar=
x5
> (which everything but the dependency suggests), it does not make sense to=
 extend
> the dependencies. Why make the sensor configurable for _all_ microchip ar=
chitectures
> if it is only supported on Sparx5 ? Maybe there is some other series expl=
aining
> this, but this patch is all I got and it does not explain anything. It is=
 only
> confusing and does not make sense on its own.

Hi Guenter,
I should have extended the description a bit.

LAN969x uses the same sensor as SparX-5, and they both select ARCH_MICROCHI=
P so
SparX-5 only configs can still select this driver.

It was suggested to me to use ARCH_MICROCHIP instead of adding new ARCH sym=
bols
one by one, but if you prefer, I could just add ARCH_LAN969X instead.

Regards,
Robert
>
> Guenter
>


--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

