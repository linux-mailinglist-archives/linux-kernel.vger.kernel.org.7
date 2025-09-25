Return-Path: <linux-kernel+bounces-833169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB309BA154E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76FC1C23E99
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1852A31D739;
	Thu, 25 Sep 2025 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="E4xXJ/sk"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9BE2512FF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758831184; cv=none; b=je5FLU4mzgI5IP2GAHTSxA3Tofz/SJX7qgk/AKbFVi1wfieHKXYvzA01u2kKshGJXPXd0C3CEbm7vb37hHtBFkLsTo+KnpB2zgczwD1/+MqKIDJ1HxzdMGh+bK42XXtJ7I4ncg2+CQSx+b1AzdIsKQUogBSG1qiWybXf6EDrpXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758831184; c=relaxed/simple;
	bh=OPr4wd6wvakoXDFdLWCCUymjgV11dNs5Xp/NA419X0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DxZVwAiX0HK8fcfeu2seUeh3uWcF8cDP80zUHiIvG2jMma4p0qHC3UsNtrIH4MswLD4Aba53Val/PB1mU9/8EZVwKwTsILU6ka15eEIxh21ZcXeeQqfgQG85aeYTAhdfOPv6kMnwIK8DXsAq7dZTbLrGU6YOhZpr5KfCQlpzPng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=E4xXJ/sk; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b2e168f0a75so247241466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1758831180; x=1759435980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLjsdrb7kU47e3HE3GVEoXLGLRJiTUoQk+TEJ2IGyGo=;
        b=E4xXJ/sk9Pv2yw2VoemAcc4H+L4NoG6NvnX68S5CeKEqtCHxTxtT0Fjdok78pmbTGZ
         0OCrZ6Gf42BLAOY7MXwXtTcMT8kaYlVCngWFCZwqpf+brttlo3mqe9qbS4oZmIk2q/Nv
         SNGMWCF/ZBmT+A75XeRQisJRdCZ+POH63mMPcVkZSNDJJNEoW7ZT5F1Z4tCiO2YrSA/B
         oUDcvgnPtzSJMX+Vg3FOu64TeCxEIE/4YlJxEDJYRafZynB1iERXFWZebr6w809fF6NB
         61/Q4pzSWd2g0mRKguyvbshVv5FM7CgW9/tBAfogJPqGCHR2Goky4jhZLLQfFYJrV+kR
         wPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758831180; x=1759435980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLjsdrb7kU47e3HE3GVEoXLGLRJiTUoQk+TEJ2IGyGo=;
        b=bHTvhRqeGzyoMirCKwo/+JsxkGv6KrZ9BoBe5QK3CtVt8ZE/sxvqIDftu2NXSrFb0l
         q/VL2W8hcGTduj43pMUsXtM68sRJeh92n/UTH1/JF5up5kG0/rAdOlWyFDd+ZLnCQKl3
         zu/Ug6Zhzno8EwN2V85uwo2X3T+JTXejL9jskrtRMgvuzgGP8fBd1O6qF8ezywDd63rH
         PR/Q8TOQg9kWEpZzE+sDrzPDLs8sgh4KY8d8bOrJNXLYPnRmgURCuDj7EQMxpGHcZ6Zs
         B5Jej5oQulUvj6+rkM4QCpsNYtkOwVfNKRREBwwQDS7y+HbTA/mwiO7zrVStKxtfboWc
         pvuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiIXEb2OtMB6aRnqrM+81I/CwLqntE+UUePGgOi5NPldfFfPCz9IiQb4n8EfvPXC5j6/V/ThF7+WN9yzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8YvxLPGb7r7+VcvKxjTyHYKLURSsdPBm4M6gKONemNvgWVW0o
	CYXyBZStGF1eI32D4Wpo1Npt22kLM0op4onWYGcvoiXCImED9qtqJL5vHuOXcqiwsY5wPKXFaO6
	fZcHWxVYthDWpXu6fCB/xL+dIBy5oRTElvX1BrkH/aw==
X-Gm-Gg: ASbGnctvpqHadP3uYCp9/CI/JkMA+Wy4nJf5AsI7SZ5hKpg3A9g4/Gl82fibuHt20SB
	dtLPJNshNms8SE1tlOQwVpMW2iTqyrQQ0jdUwGu1bZJyIymwEahIxAihNAtOTTGRm/q7xSW3pHc
	naVGvFW4QinR75zvg2PecIvRZRySSBeZl+CXC0ZkCQaMZSNmMI5HJxLeg/jHb82AvyKAFUGZ4tg
	9ydB83Cqf6x7FJ1Muw=
X-Google-Smtp-Source: AGHT+IEpi7Wc/4pCcJuLv/6FrFXhrLYQdU1ecNgEGjclujLL3Yn39S9vkw9Cn/jIptsgq59J0PczgaOeUc8EmOuXdDA=
X-Received: by 2002:a17:907:3f98:b0:b04:4175:62f7 with SMTP id
 a640c23a62f3a-b34ba545295mr502805366b.33.1758831179513; Thu, 25 Sep 2025
 13:12:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924213027.1887516-1-robert.marko@sartura.hr>
 <f019dcef-afdd-4d18-b28c-b214fa14f1c8@roeck-us.net> <CA+HBbNFe+7XT3bSUEagsXiug-bmh=fBfLAW0d7WR73Di8-ozTA@mail.gmail.com>
 <357f9a92-df60-4e6c-9019-40a4adbf0702@roeck-us.net>
In-Reply-To: <357f9a92-df60-4e6c-9019-40a4adbf0702@roeck-us.net>
From: Robert Marko <robert.marko@sartura.hr>
Date: Thu, 25 Sep 2025 22:12:48 +0200
X-Gm-Features: AS18NWCKnUfh9WVkpM_OSxaxZf7VUhId85ZGgBMXi-ITxknGdPPRPS4QBkHAASE
Message-ID: <CA+HBbNHcO=NintKBz8CmYRruiuHM8EFU+wQjw0-JbGKMK2xv2g@mail.gmail.com>
Subject: Re: [PATCH] hwmon: sparx5: make it selectable for ARCH_MICROCHIP
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	daniel.machon@microchip.com, luka.perkov@sartura.hr, 
	benjamin.ryzman@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 5:33=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On Thu, Sep 25, 2025 at 11:15:52AM +0200, Robert Marko wrote:
> > On Thu, Sep 25, 2025 at 12:07=E2=80=AFAM Guenter Roeck <linux@roeck-us.=
net> wrote:
> > >
> > > On 9/24/25 14:30, Robert Marko wrote:
> > > > LAN969x uses the same sensor and driver, so make it selectable for
> > > > ARCH_MICROCHIP.
> > > >
> > > LAN969x _is_ the Ethernet switch driver for Sparx5, so this descripti=
on does
> > > not really make sense. Same as what ? Itself ?
> > >
> > > > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > > > ---
> > > >   drivers/hwmon/Kconfig | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > > > index 840d998f850a..ba2b7b2f6c44 100644
> > > > --- a/drivers/hwmon/Kconfig
> > > > +++ b/drivers/hwmon/Kconfig
> > > > @@ -632,7 +632,7 @@ config SENSORS_I5K_AMB
> > > >
> > > >   config SENSORS_SPARX5
> > > >       tristate "Sparx5 SoC temperature sensor"
> > > > -     depends on ARCH_SPARX5 || COMPILE_TEST
> > > > +     depends on ARCH_MICROCHIP || COMPILE_TEST
> > >
> > > ... and silently disable it for ARCH_SPARX5 at the same time ? That i=
s not what
> > > the description says, and is completely unacceptable unless explained=
.
> > >
> > > >       help
> > > >         If you say yes here you get support for temperature monitor=
ing
> > > >         with the Microchip Sparx5 SoC.
> > >
> > > ... and, on top of all that, still claim to support Sparx5 even that =
is
> > > no longer the case.
> > >
> > > Ah, I see, this patch depends on patches in linux-next. You might wan=
t to say that.
> > > Also, there is context missing: If the sensor is _only_ supported on =
Sparx5
> > > (which everything but the dependency suggests), it does not make sens=
e to extend
> > > the dependencies. Why make the sensor configurable for _all_ microchi=
p architectures
> > > if it is only supported on Sparx5 ? Maybe there is some other series =
explaining
> > > this, but this patch is all I got and it does not explain anything. I=
t is only
> > > confusing and does not make sense on its own.
> >
> > Hi Guenter,
> > I should have extended the description a bit.
> >
> > LAN969x uses the same sensor as SparX-5, and they both select ARCH_MICR=
OCHIP so
> > SparX-5 only configs can still select this driver.
>
> You mean ARCH_LAN969X (in contrast to ARCH_SPARX5 and LAN969X_SWITCH) ?

Both ARCH_LAN969X (Which is now in linux-next) and ARCH_SPARX5 select
ARCH_MICROCHIP
which was introduced to avoid the need to keep adding new ARCH symbols
to individual drivers.

LAN969X_SWITCH is just the switchdev driver for ARCH_LAN969X.

> That makes sense, but it really needs to be explained in the patch
> description. Also, since ARCH_MICROCHIP does not exist for arm64 in the
> upstream kernel, a note that this depends on other patches in linux-next
> would have been helpful. You may know that, and others may know that, but
> I don't, and digging through that cost me at least an hour of time which
> I don't have.

Yes, I should have pointed out that this depends on linux-next since
the prerequisite
Kconfig.platforms change for ARM64 is in linux-next, but it should
land in the regular ARM tree
if its not already there.

If there is need for a v2, I will make sure to expand the description.
Sorry for the confusion.

Regards,
Robert
>
> Guenter



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

