Return-Path: <linux-kernel+bounces-584039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF1DA78285
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 20:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257373AE530
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 18:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D7520FA97;
	Tue,  1 Apr 2025 18:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MOPRjrKl"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED86020D51E
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 18:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743533893; cv=none; b=mf8wHAoYEIs25pfcArTD11q2X2gjoz+J5v1BoR/NpJZzuHqEi5zgHTsYZAUyJumTg7RZFwww/uJ7Dw4z7hSPFB5pFbmzRozO+Cb8PPDIwAUKLvoWn2EyYimoI80LvJItyHPqyNooGXRL6ApxLgPz3UwmQengIMJTg1l6PPVa7K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743533893; c=relaxed/simple;
	bh=3xGrIS00etRX5PAy4oAIqUkPW9mXC5XiwAjFy4PwkGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hh0rqvZegj6pzULkVXlI8ev8vPUT8E1yBn3/SmdXoocnjGM6CqXvFlxDOvyJgUDzU3jSpdyzmvYOB740yex+z+sgPnhK4laQfY4SyW756xumOfJErOxuUwCeKfbuwz8zn9WnMF2Gfk2gdsPJE6UystWPzjVbCZziB/SJAN9Tmso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MOPRjrKl; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30beedb99c9so53744121fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Apr 2025 11:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1743533889; x=1744138689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dniaGNnhqMrnq1Kup3/mUMxlGmopwwtZFxeJoiPPzL0=;
        b=MOPRjrKlbbYhebcS1MJury2Ro055MsvGRRaTKoMlBwy0RWTNX6kQlORiawPq2Q50Ar
         Psc4s3giVdV8Pd0dVETXUAcIw3abmSCN3UQLIr5B8vPfU+JfuM62vTZJLsNrQncWGWdd
         IvtJ58fzcIcOrNmqR65/Z3vr4DNF58FYkW8lmB0aI7jj/G639UW7YnWmN+UfOjWy624N
         YdHDbEdj36Woqm5ma9MSWbYyoZiBNyFUXleJXSunfgenNzEzdTSiZwX6H3ZyQ3QTwZ+O
         WqDS4EHg9cKtkXcijftpIlhfGgLlFb8HRLXvi2Fz8Sx9LMyE8eJbfwApn1cSLv9J4f5t
         mISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743533889; x=1744138689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dniaGNnhqMrnq1Kup3/mUMxlGmopwwtZFxeJoiPPzL0=;
        b=uLwL+wy07TC7jZoFirq1GkMVpsZJiWEBwkGNC8Y7W6zquL6Uf2oYH9M7KCnx6aocuj
         qcDNijMQe5hwHSmoLCP/KMG2fzY2khOW9RryKA/OSNe8laOhU29caTWiPFyeGRo/QePT
         SmozKgBgoKPneYZEui9U1LzZz/4IpGKUl9GqmbZkf9VPIJyc3jxfjSN9aRgwyTslLlWn
         S/dB12vcTyqEVVM1AIZM1wDp5zfbrQbjPL4ZUC8DM5Ahm7YV3yIQ+97oBDzeS/Rfzs4v
         e3FCJ8MSvdPRwZI/WBPV4eXHRCL96Ychg/gaZiQ8HO7zuUKWhqS5zcr1wRLNqTAzc4fA
         Wg5w==
X-Forwarded-Encrypted: i=1; AJvYcCWhidHwvm7/3ymFvoEeWSEopw5dOeDaF5MX4zmhA4DAU7ZX7QguT7NKHX0de78Hb+FUqpSeaSPRiDSi+OM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvsEXdRetHHVJf0PiOz100nAI8QlV8VB29iHT1Gy3neeYNc+H8
	WW8hX+sQPScvHelTALZkjiKl7hSCggvRmAnsPy11+hF1YMfKcAZeZMQfcqFcc6miET+N02Gpivo
	4NWChbBj+u9StzFy9yG10sykE0kzsxdaNQaa9lA==
X-Gm-Gg: ASbGncvj7qi3jPmW6p/lefYHdRdwl4bulTJnu7MZGn0xi8XTzsn+cKnXFTyD1WofSAv
	loBqaHmlXUfE3O7TUGnNNIvU8y6HjApscHJRIRVP+wa8u1vM3Jucd2ogddJcMW48h2V1I/2qI+p
	NbtSD2DaArNoSH2WYQBoytpgo2TX50r+vD4N7b6i+i8bTMggO5TAQY+LrUfHFYDfIowY8=
X-Google-Smtp-Source: AGHT+IG6ktNXFIZrOXTrCvp6EJ7YpV029u/YJWSm6BGpaWGXyLzUtCkfjZX246AyT2vLTjBoUc7orympX+Kwv1BRalM=
X-Received: by 2002:a05:651c:904:b0:30b:b9e4:13c5 with SMTP id
 38308e7fff4ca-30de021a838mr41284631fa.4.1743533888805; Tue, 01 Apr 2025
 11:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401-gpio-todo-remove-nonexclusive-v2-0-7c1380797b0d@linaro.org>
 <c8ca3c8a-3201-4dde-9050-69bc2c9152c4@sirena.org.uk> <CAMRc=Mcq9yag6yBswhW0OJ8MKzGBpscwo+UGpfCo2aha93LzXA@mail.gmail.com>
 <846010c0-7dc1-421c-8136-9ae2894c9acd@sirena.org.uk>
In-Reply-To: <846010c0-7dc1-421c-8136-9ae2894c9acd@sirena.org.uk>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 1 Apr 2025 20:57:56 +0200
X-Gm-Features: AQ5f1Jo1oiLIEUKZZ8kCA8-nNNtuHM_19P39PWi_yX4KA28Elb6UrkF6TDrSVEk
Message-ID: <CAMRc=Mff0TkeiHbM3TAJLJ2HYU_nnPFUpUjbWsdCnW6O4E=+gQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] gpio: deprecate and track the removal of GPIO
 workarounds for regulators
To: Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 6:00=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Tue, Apr 01, 2025 at 04:42:40PM +0200, Bartosz Golaszewski wrote:
> > On Tue, Apr 1, 2025 at 3:27=E2=80=AFPM Mark Brown <broonie@kernel.org> =
wrote:
> > > On Tue, Apr 01, 2025 at 02:46:41PM +0200, Bartosz Golaszewski wrote:
>
> > > > Let's deprecate both symbols officially, add them to the MAINTAINER=
S
> > > > keywords so that it pops up on our radars when used again, add a ta=
sk to
> > > > track it and I plan to use the power sequencing subsystem to handle=
 the
> > > > cases where non-exclusive access to GPIOs is required.
>
> > > What exactly is the plan here?  The regulator (and reset) usage seems
> > > like a reasonable one TBH - the real problem is having an API from th=
e
> > > GPIO subsystem to discover sharing, at the minute you can't resolve a
> > > binding enough to find out if there's sharing without actually
> > > requesting the GPIO.
>
> > Hard disagree on the reasonable usage. Let's consider the following:
>
> > You have two users and one goes gpiod_set_value(desc, 0), the other:
> > gpiod_set_value(desc, 1). Who is right? Depending on the timing the
> > resulting value may be either.
>
> That's why we need to figure out if there's sharing - the usage here is
> that we have some number of regulators all of which share the same GPIO
> and we want to know that this is the case, provide our own reference
> counting and use that to decide when to both update the GPIO and do the
> additional stuff like delays that are required.  When the API was number
> based we could look up the GPIO numbers for each regulator, compare them
> with other GPIOs we've already got to identify sharing and then request
> only once.
>

That's not a good design though either, is it? For one: it relies on
an implementation detail for which there's no API contract, namely the
idea that the address of the struct gpiod_descr handed out by the call
to gpiod_get() is the same for the same hardware offset on the same
chip. It does work like that at the moment but it's a fragile
assumption. The way pwrseq is implemented for instance, the
"descriptor" obtained from the call to pwrseq_get() is instantiated
per-user, meaning that each user of the same sequence has their own,
unique descriptor. I don't see why such an approach could not be used
in GPIOLIB one day. IOW: nobody ever said that there's a single struct
gpiod_desc per GPIO line.

> > For it to make sense, you'd have to add new interfaces:
> > gpiod_enable(desc) and gpiod_disable(), that would keep track of the
> > enable count. However you can't remove the hundreds of existing users
> > of gpiod_set_value() so the problem doesn't go away. But even if you
> > did introduce these new routines, what about
> > gpiod_direction_input/output()? My point is: the GPIO consumer API is
> > designed with exclusive usage in mind and it makes no sense to try to
> > ram shared GPIOs into the GPIO core.
>
> That's exactly what the regulator code was doing, as far as the GPIO API
> saw there was only ever one user at once.  Since we can't look up
> numbers any more what we now do is use non-exclusive requests and check
> to see if we already have the GPIO descriptor, if we do then we group
> together like we were doing based on the GPIO numbers.  The multiple
> gets are just there because that's how the gpiod API tells us if we've
> got two references to the same underlying GPIO, only one thing ever
> actually configures the GPIO.
>

That's not an unusual situation. For reset-gpios we now have the
implicit wrapper in the form of the reset-gpio.c driver. Unfortunately
we cannot just make it the fallback for all kinds of shared GPIOs so I
suggested a bit more generalized approach with pwrseq. In any case:
having this logic in the regulator core is not only wonky but also
makes it impossible to unduplicate similar use-cases in audio and
networking where shared GPIOs have nothing to do with regulators.

> > 1. Audit all users of GPIOD_FLAGS_BIT_NONEXCLUSIVE
>
> > Outside of drivers/regulator/ it seems that there are several users
> > who don't really needs this (especially under sound/) and where using
> > this flag is just a result of a copy-paste.
>
> The sound use cases are roughly the same one - there's a bunch of audio
> designs where we've got shared reset lines, they're not actually doing
> the reference counting since the use cases mean that practically
> speaking all the users will make the same change at the same time (or at
> least never have actively conflicting needs) so practically it all ends
> up working fine.  IIRC the long term plan was to move over to the reset
> API to clean this up rather than redoing the reference counting, if
> we're doing this properly we do want to get the thing the regulator API
> has where we know and can control when an actual transition happens.
>

If they actually exist as "reset-gpios" in DT then they could probably
use the reset-gpio.c driver. I will take a look.

> > 3. Use pwrseq where drivers really need non-exclusive GPIOs.
>
> > The power sequencing subsystem seems like a good candidate to fix the
> > issue. I imagine a faux_bus pwrseq driver that would plug into the
> > right places and provide pwrseq handles which the affected drivers
> > could either call directly via the pwrseq_get(), pwrseq_power_on/off()
> > interfaces, or we could have this pwrseq provider register as a GPIO
> > chip through which the gpiod_ calls from these consumers would go and
> > the sharing mediated by pwrseq.
>
> This seems complicated, and I'm not sure that obscuring the concrete
> thing we're dealing with isn't going to store up surprises for
> ourselves.

IMO It would be equally as obscured if you used a shared GPIO wrapped
in a reset driver.

>
> It's also not clear to me that pwrseq doesn't just have the same problem
> with trying to figure out if two GPIO properties are actually pointing
> to the same underlying GPIO that everything else does?  It seems like
> the base issue you've got here is that we can't figure out if we've got
> two things referencing the same GPIO without fully requesting it.

Whether that's feasible (I think it is but I'll have a definite answer
once I spend more time on this) is one question. Another is: do you
have anything against removing this flag given it's replaced with a
better solution? If not, then I'd still like to apply this series and
we can discuss the actual solution once I send out the code. I hope
this will at least start happening this release cycle.

Bart

