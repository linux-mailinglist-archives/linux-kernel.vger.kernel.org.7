Return-Path: <linux-kernel+bounces-862538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B075BF58E3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F604460552
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FF62ECD13;
	Tue, 21 Oct 2025 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Hy+aycos"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA062E6CAD
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039597; cv=none; b=JCBFXqaGYo0O55MayP/EvtkiRhAGGsQmi8rOEf2oRfyZTKcuI/VNXLA5oO2opLjdEAAPMzJKZj9DfPY4t8mlJgveeDxOkbK648FTvL2IC0PWfoCwEK7bX4l50a97+MONLweM6xUjNu+vkcSm97IrAScaIdHoVgP1jf9DyDJXQik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039597; c=relaxed/simple;
	bh=SbwSE0eaGZLqdl1Y98QCAxRyFY0MQhw0U73vrBGwDCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOn7Cy0X+4yziPQA2cRgkabc2L+NZeDCj7AVHnU0MU+5ivTu/FmMWdW3Fo/hfgnU9sZyDGMJTThRCUFdnc88H2Xx2ZxC2IVixqezBf7U0pgQ4Xoo4hq1Rh8Z5lGjLvH3IOoRh6jDoZeV5uO+0+NpfERZVfNXRsozjhwu+zc0UQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Hy+aycos; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-591ec0e4b3fso434161e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761039593; x=1761644393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbwSE0eaGZLqdl1Y98QCAxRyFY0MQhw0U73vrBGwDCE=;
        b=Hy+aycos+dzzLA+6O1T8vyh1quN8ragPBL0epIdibqoZZznzbb8eq88XWcGH0/jWvJ
         jMXjtuB983rhtMNE5OfI/eCY++yUyFIIiKpMgSirT6aBR/PnxMvPUglgDIwjpUsWuL8f
         U0vpS3X+bpy0GEJmaYk0NoPdkKiKf2ybCDqIALKt3C9Ufi+LBrikdOoc9jlAQzXw6+90
         CBwFvP8vP1UBgSavH5xhlaoMvuJ3NzbSUOLUdID98qJ8+2zgqxFKal7N+Hd6RKcKcZGj
         qnmygZxmHIYAFMmXpSoCJeA53P5ykhheOxwPIpPFeaCUZLJCMIhIdQdoruWLhnIwZaOU
         wskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761039593; x=1761644393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbwSE0eaGZLqdl1Y98QCAxRyFY0MQhw0U73vrBGwDCE=;
        b=oBW8QdxjeVZoqgO+ojyxQIgcjF6YpqkYRGRpCubWtMFEREPl1Q1AhJvBDzvPUjLMMi
         bVsvor6hV113Ynd7gyozGSvysu0P2pUr0m9ZZalHJfA4OXfrrHie3LjX2WQ1CJJTBv2T
         VbEe6d1vwxPkQhYxXvBVRwR4ZSn4sJG/c13smZ2o7FAuyK+785OQhz89+d88iJaHyi/g
         AgqoSUlCkxk8o4JvjHNHo89AIuIxCsZ3P6oV7w20x6FBmGcld7mzWvlWzWTTjU7Gw6A3
         6+kFtiATCTTKEWfjLX/2pJ3hGjCFP066brOBQjDf29OPkzPX21GusjtcZAvMbodLxgKI
         XxSA==
X-Forwarded-Encrypted: i=1; AJvYcCWjIAnINcm7DKX2pFRUa+Evvx7ecHJ5X4ua45S0pw4DUCgBufw4c+4hIYwoz53r8O3g1rq+sXAJABsdL4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1cpOnijB3HtAZf9zRF2k1FuRqM0p3dYZ0ZcMgCoqa/rBw/+jp
	aOVaFDODrqMu2qXkUwU+Jb/caZBXDBOTC004mHu5NZDeiZhG6Dlzk7EIQvhwP3W7oBUYM8iB7gh
	DCXGDeELfkIBsK4TvlyABrOHqMOc7lkHE83gOh5pWmQ==
X-Gm-Gg: ASbGncuYrr2oSgnzIG7wUY5GmFpQw8QwEUVtSBJsBz0IefzG6HWn6ObIsMLNLn5/64C
	mWI2IGxByG/ynSQuy487g9vUBGCzYs3oPXjWXJEnFWQUthGXc86wEgjamNnLOVLa8ecxHPzpQl3
	Uxor9aaqZkXUKftsu3CrGIkr3AeZvp/XbVFo7dZONGzrR0oWBWDIU+JSd9twiQW6XUypHBXfmgG
	ciSfLZ1OoH8mxGnPbTsCe1+YZq7qFgcRjal879KwFkQWtL6JMxL/zS7By1FLjWZayElnyYsjrdy
	k9RiwuXQYnoMvp8CSjmkrfIEfh8=
X-Google-Smtp-Source: AGHT+IFcaFEo/qZQspCXEfaZ9asrhR7AsXRlzRs90EgrMOz4+xmyfUEQn+pkgPSIrP9iTrJOQF2z9EmxBKSKd4EW2d0=
X-Received: by 2002:a05:6512:e8d:b0:57a:311:3234 with SMTP id
 2adb3069b0e04-591d856f103mr5546707e87.55.1761039593310; Tue, 21 Oct 2025
 02:39:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
 <20251006-reset-gpios-swnodes-v1-7-6d3325b9af42@linaro.org>
 <95bbec130437846d4b902ce4161ccf0f33c26c59.camel@pengutronix.de>
 <CAMRc=Md_-mO=HqfncD-vJS6XzPJ+aTcBjSjtkxLH_h1=pNjCcg@mail.gmail.com>
 <075a4511a6ae4b047599757d41b559c6b7cf9d0f.camel@pengutronix.de>
 <CAMRc=Md4DUSuwv07EuBVDJbY1Uzezq+TONxyCvLtOHD=iFXrcQ@mail.gmail.com> <050d74d7619bdfdf5ca81d8914a2a8836a0d4e2e.camel@pengutronix.de>
In-Reply-To: <050d74d7619bdfdf5ca81d8914a2a8836a0d4e2e.camel@pengutronix.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 21 Oct 2025 11:39:41 +0200
X-Gm-Features: AS18NWDLZhvxp2462wbLcsyKarFFiAj7m0dCchf3HriAjmdsiNckscvHC1N6jtM
Message-ID: <CAMRc=MfPqRLFHPW988oMry7vVoTgtQHrxxND4=nr_40dOa5owg@mail.gmail.com>
Subject: Re: [PATCH 7/9] reset: make the provider of reset-gpios the parent of
 the reset device
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 11:31=E2=80=AFAM Philipp Zabel <p.zabel@pengutronix=
.de> wrote:
>
> On Di, 2025-10-21 at 11:27 +0200, Bartosz Golaszewski wrote:
> > On Tue, Oct 21, 2025 at 11:17=E2=80=AFAM Philipp Zabel <p.zabel@pengutr=
onix.de> wrote:
> > >
> > > On Mo, 2025-10-20 at 17:25 +0200, Bartosz Golaszewski wrote:
> > > > On Mon, Oct 6, 2025 at 5:19=E2=80=AFPM Philipp Zabel <p.zabel@pengu=
tronix.de> wrote:
> > > > > [...] could you take this
> > > > > opportunity to prepend a patch that splits the part under guard()=
 into
> > > > > a separate function?
> > > >
> > > > If I'm being honest, I'd just make everything else use __free() as
> > > > well. Except for IDA, it's possible.
> > > >
> > > > That being said: I have another thing in the works, namely converti=
ng
> > > > the OF code to fwnode in reset core. I may address this there as I'=
ll
> > > > be moving stuff around. Does this make sense?
> > >
> > > Yes. There was already a previous attempt at fwnode support [1], but =
we
> > > abandoned that when there was no use case anymore.
> > >
> > > [1] https://lore.kernel.org/r/20220323095022.453708-3-clement.leger@b=
ootlin.com
> > >
> >
> > Ah, what was the exact reason for abandoning this? It's not clear from
> > the email thread.
> >
> > To be clear: I think that we can convert the core reset code to fwnode
> > without necessarily converting all the drivers right away.
>
> The use case vanished in patch review.
>
> No need to convert all existing drivers right away, but I'd like to see
> a user that benefits from the conversion.
>

The first obvious user will be the reset-gpio driver which will see
its core code simplified as we won't need to cast between OF and
fwnodes.

Bartosz

