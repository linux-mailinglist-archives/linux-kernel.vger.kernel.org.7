Return-Path: <linux-kernel+bounces-864910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 327C5BFBCFB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA136188FB40
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCEC341AD7;
	Wed, 22 Oct 2025 12:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xAv5oXoK"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA9334165E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761135489; cv=none; b=BQIhuasPjtYKmu2N3Xyg7DSj7tYGdXILVlJL71XG0IGFxmxHZtvgeErCA3Q9nWQQY5B0qY50R8Lzvcz0iluN2y52XOxpJtSJQITjw7XaWRvWR8owUCuBhtU12kkYicJFZRV8f6fh0ECoEFPIY37pda8lgJQhnCtwqp0+dNgMaGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761135489; c=relaxed/simple;
	bh=WBrGicdJ7vJmFD7ULLVAtRjwv/BXxswDEpGZGdImK50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKoL4RyXTvohwcamFkuJ/RuuoXEpV2r30K1rwCFhfFOUNiGz7WK5Ws97HaPqseGqipk3x4UQFmS6sMpYWxpsM2whNGph896yzeqW8DrcPlzKlwlkWQ83axqFNLd8rgeympEcyeh+QJK18/HAiuM3p9m5YUTf8q/B4vSoHDMzYEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xAv5oXoK; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57992ba129eso8029276e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761135486; x=1761740286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBrGicdJ7vJmFD7ULLVAtRjwv/BXxswDEpGZGdImK50=;
        b=xAv5oXoKfbVVGAdLjEvtVPWEgV3x5Pvth28fyWj8XT99aP3h1JGqI53/ETWjYdhM22
         AEUlAVuEK6kO90RcDw8uvYpsiTJ+1haXJu059RYWMFhCpGOO63zgJg0A59NfgjicHi79
         8aQfMB6RqnoVOMB5gkSc/rg/amESUiBVaFuM1pp29pi0VHBbFGCnftpmUtsJlEKeKBju
         iP33FyuJbRP1SJZ68JzrDBgW9YomyAkR2RkmvMv1dzSuYfTUTjZoUfB2uvambnnaJrsr
         1jPDBQJ/mSWTMUhITVVBuV457GRLUQQ3OqJa+KMZBiwjaziPAHyNXutnsc1O6IgXGSoE
         4yDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761135486; x=1761740286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBrGicdJ7vJmFD7ULLVAtRjwv/BXxswDEpGZGdImK50=;
        b=Y/PGgz1On+kcG+eJrFnWYQg6Q78i1BOCBXYDzP/myCnZBnz3zbFILXKuhQVy+l4Kbj
         4RvRPorufldbuyUn6jz479jRXXNAKTTMeuODuhrh1wkC5St1M7EjlEHezxCpHNzmKHgv
         zn2GAn96IjIDGBsFqvqFwEp5A/CuT1FNU7Iyj2h9Q9sKhN8TzmryXdwfXNdSOrLWpy/M
         qf2UC33ww+kJsnDcpLRf4/XIPO2y5otOgzKBXIb5ScddxlN32294TMHljEOC3leQI4xa
         V0aC8CnWO9lN8EfBI8sCs/ksadmdynixceJa3WVe+A2DeMPQXhiujgMjQlD8eC7afxfa
         UIHg==
X-Forwarded-Encrypted: i=1; AJvYcCUWI5C8b0mwxpySk0pbhtD+EQHZt+m4/DfqM6fiMwwbpJ+Ivj69i4SuSGhZdhjdXdc2b9qMKcVBREi+3Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIl3+GTmVUaiOLb02dwy8ISG9kKMJojixe6lbKMN9jXfhnos6U
	usMBhxRa504hDKk6Baw2V0l9gyrTvn86kAu92UTYbt08V/9q9R4c/+osyQDsEnEnJpSTI6yEgQu
	XfXFl3MkgrVGrtp2CY2L8JJB5ULK58buToZo/eyTFurV7Pla8BpKLpBHm7A==
X-Gm-Gg: ASbGncuN1zAcpg0PGH000mHxA3ZMZ65QWz3btH3Ly4/kqCy6SV3sfgV0Jb5F4j1lSYl
	D1B5lJRbU5rxLSWpWERAOm4rCUJsd7NP+rYhGEpcyTp3n+wdB0TnA4+fH/2id35XsviDDF00aba
	EmhHILfkvJfGS0avYGh8rETcqwfmmuSAf9sUw/DohVWxavb+YUZI32cgjOH8yrNFL7lJgK/GfQN
	TapOGbPW0/xnjwfObclWkYAB2BkNlCU2FvWd2zx/2sac26o8QkB671UTDfSXujpfLGbWDGY9VrO
	z2uUrXQdCJiZUw/V
X-Google-Smtp-Source: AGHT+IHdFjD1upF60QNrKQiPHb0EuLyjig0EXitYcomcOh2LTKy2vCTOo5wwpoP3zGRv3ACq4Fw6m6AiGSWjUoYZbaI=
X-Received: by 2002:a05:6512:1115:b0:591:c2f8:9a5a with SMTP id
 2adb3069b0e04-591d8595e35mr6051681e87.35.1761135485542; Wed, 22 Oct 2025
 05:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-reset-gpios-swnodes-v1-7-6d3325b9af42@linaro.org>
 <95bbec130437846d4b902ce4161ccf0f33c26c59.camel@pengutronix.de>
 <CAMRc=Md_-mO=HqfncD-vJS6XzPJ+aTcBjSjtkxLH_h1=pNjCcg@mail.gmail.com>
 <075a4511a6ae4b047599757d41b559c6b7cf9d0f.camel@pengutronix.de>
 <CAMRc=Md4DUSuwv07EuBVDJbY1Uzezq+TONxyCvLtOHD=iFXrcQ@mail.gmail.com>
 <050d74d7619bdfdf5ca81d8914a2a8836a0d4e2e.camel@pengutronix.de>
 <CAMRc=MfPqRLFHPW988oMry7vVoTgtQHrxxND4=nr_40dOa5owg@mail.gmail.com>
 <aPeexuA1nu-7Asws@smile.fi.intel.com> <aPegyVyONkPWRgi9@smile.fi.intel.com>
 <CAMRc=McPpFEmg7dpfiYWJaPR4yMynOaU5Hp37E7rTzWSCNxBuA@mail.gmail.com>
 <aPerDcMFdbWecGEv@smile.fi.intel.com> <804b4b8cf23444fe5dc9400ac1de3a738a77e09e.camel@pengutronix.de>
In-Reply-To: <804b4b8cf23444fe5dc9400ac1de3a738a77e09e.camel@pengutronix.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 22 Oct 2025 14:17:53 +0200
X-Gm-Features: AS18NWCQ7ANfnKQl00uAA5vEojJxMGPQi1isAnxjQuec18eN_PhBUMwxJKrcpO8
Message-ID: <CAMRc=Md-KuNp1o6GLA0WTbknbN-qtt8YJqy5fJs0P0EyE7KY3Q@mail.gmail.com>
Subject: Re: [PATCH 7/9] reset: make the provider of reset-gpios the parent of
 the reset device
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 10:39=E2=80=AFAM Philipp Zabel <p.zabel@pengutronix=
.de> wrote:
>
> On Di, 2025-10-21 at 18:47 +0300, Andy Shevchenko wrote:
> > On Tue, Oct 21, 2025 at 05:23:33PM +0200, Bartosz Golaszewski wrote:
> > > On Tue, Oct 21, 2025 at 5:03=E2=80=AFPM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Tue, Oct 21, 2025 at 05:55:02PM +0300, Andy Shevchenko wrote:
> > > > > On Tue, Oct 21, 2025 at 11:39:41AM +0200, Bartosz Golaszewski wro=
te:
> > > > > > On Tue, Oct 21, 2025 at 11:31=E2=80=AFAM Philipp Zabel <p.zabel=
@pengutronix.de> wrote:
> > > > > > > On Di, 2025-10-21 at 11:27 +0200, Bartosz Golaszewski wrote:
> >
> > [...]
> >
> > > > > > > No need to convert all existing drivers right away, but I'd l=
ike to see
> > > > > > > a user that benefits from the conversion.
> > > > > > >
> > > > > >
> > > > > > The first obvious user will be the reset-gpio driver which will=
 see
> > > > > > its core code simplified as we won't need to cast between OF an=
d
> > > > > > fwnodes.
> > > > >
> > > > > +1 to Bart's work. reset-gpio in current form is useless in all m=
y cases
> > > > > (it's OF-centric in 2025! We should not do that in a new code).
> > > > >
> > > > > More over, conversion to reset-gpio from open coded GPIO APIs is =
a clear
> > > > > regression and I want to NAK all those changes (if any already do=
ne) for
> > > > > the discrete components that may be used outside of certainly OF-=
only niche of
> > > > > the platforms.
> > > >
> > > > To be clear, the conversion that's done while reset-gpio is kept OF=
-centric.
> > > > I'm in favour of using it, but we need to make it agnostic.
> > >
> > > As of now, the whole reset framework is completely OF-centric, I don'=
t
> > > know what good blocking any such conversions would bring? I intend to
> > > convert the reset core but not individual drivers.
> >
> > Blocking making new regressions?
> >
> > Otherwise as long as reset framework and reset-gpio are agnostic, I'm p=
retty
> > much fine with the idea and conversion.
>
> I think we might be talking about different "conversions" and different
> "blocking" here?
>
> 1) Conversion of the reset core from of_node to fwnode.
> 2) Conversion of reset controller drivers from of_node to fwnode.
> 3) Conversion of consumer drivers from gpiod to reset_control API.
>
> My understanding is:
>
> Bartosz would like to convert the reset core to fwnode (1) but not
> convert all the individual reset controller drivers (2). He doesn't
> like blocking (1) - this statement was partially in reaction to me
> bringing up a previous attempt that didn't go through.
>
> Andy would like to block consumer driver conversions from gpiod to
> reset_control API (3) while the reset-gpio driver only works on OF
> platforms.
>
> Please correct me if and where I misunderstood.
>

I think Andy is afraid that people will convert drivers that are used
in the fwnode world to reset-gpio which only works with OF. I don't
think that anyone's trying to do it though.

> I think fwnode conversion of the reset controller framework core is a
> good idea, I'd just like to see a use case accompanying the conversion.
> It seems like enabling the reset-gpio driver to be used on non-OF
> platforms could be that. Andy, do you have an actual case in mind?
>

I'd say converting the reset core to fwnode has merits on its own. We
should typically use the highest available abstraction layer (which is
fwnode in this case) unless we absolutely have no choice (for
instance: using some very OF-specific APIs).

That being said: the reset-gpio driver will be able to work with any
firmware node once we do the conversion which is a good first
use-case.

Bartosz

