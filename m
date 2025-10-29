Return-Path: <linux-kernel+bounces-876152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FA3C1B0E3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0ED8587342
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CD527877B;
	Wed, 29 Oct 2025 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QRdQSWtx"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEB1277818
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743971; cv=none; b=d52kxNwYv7B12+pk4qyPN8sXp+yWfX8Ang0TkreezYoyBho1ciSKcGq6IjaHFSL09iFA+XDJEjWvwlFGh1viZbDbArlT/gDAHE1zVN8CMLVXfiHPP/dBsPFoCScnK5oNni2QyoGurgRfw649ibNE2gGDHRGzbU67uou7tMAMRr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743971; c=relaxed/simple;
	bh=5qpTR2oYTbgD5TBux+eB/2ftXVOVUsAhm9/BBxaVk10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJ6Ve8FitMl0p8wDS82sfbhx+yeOKgKVvyCHlPhtVm2KTIRcftSrcbuSGESEYLM9VDgJ3fEOdfvkIw4eNou1EvDpoGBD/SBqJnR1PZVz7hCR/eVLp7ObL5nxi52BcW5ZEharSLDdzIrlvXQg4BiPn3DMXdJtgOuV6o9P6mdE94Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QRdQSWtx; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59052926cf9so3355122e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761743967; x=1762348767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qpTR2oYTbgD5TBux+eB/2ftXVOVUsAhm9/BBxaVk10=;
        b=QRdQSWtxQDFOefbPwxyGfp5NXzRgztAWp3Q4UlqZC0YSVBWoIS3MCsbN7gk6CTsWYX
         nzLPeTtKcIyiXLmNWypl1/ivBzp033JhDLiSvYfnvWAu1RqIBRAU0B++VfxGzZI/u4pG
         /KN+QbKRNBbKSSmh//o8qR/zC7Wtl7rN9ui/8pXOKuTXyFNo6+wiO7Qt+JS1LYpf8p8s
         ytyVxYL24oiD9BCW0LTkQRG8qI9O+9TfNESZhZp+X1YGPCkYoLkABqt2GTHRl+hQT0ke
         doQQio4sxxH4uWE1eBuQK76P6f8fKV26/3SHXY4m2QjSA7s8/fKuUlAi61YFvOOIXfqO
         Ip4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761743967; x=1762348767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qpTR2oYTbgD5TBux+eB/2ftXVOVUsAhm9/BBxaVk10=;
        b=tu5RfuaFH6LK+lxP7/T+50e8QOscvrPlGwTStUv5gj0Q0FMTDtBLLVBZQyWrfnYCS/
         djGrT+GNNeRSo0EfPuZuOFWOqSgv9S3SLYebS/VX6/3cak3R6mt+g34nlzrSkhknCaIC
         zeIqhTmwxmy1b6rt/VodMdlh7EX1aiPHA67o9wXaZQ53b+n7aczzYCwpOPG4J49azhvv
         w3TlE9LKVziIEKtYLf1VCPzpdKp9aqqzrwJfM0643OUSXHNqE1aM1CJphJMJESB98Nqq
         /2BvmQJaaxZ6ZQxfXL9Os9uZVARxCXM4MsKAjiWhW+lSLlh3+t7YLF9hU0mEqAVYhVXe
         iGtg==
X-Forwarded-Encrypted: i=1; AJvYcCVjBUL58aMfs9hoJngPdsVKjTKIYa0+5OkYP/NTB5FuX2N1g6fKr24EnsTyT4w9hYT/ifJYUCieuw+t0xI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVfPXa7Ies6gC79pVIsxdhxdLTHZAqFAwty7P/cZmB1VVuu3wi
	QifR8m12qZIxjgANZCTTeSZd4EalOb5rG1AS90O7gsnft179IbjV7w2QbcmECbYT0YwYk40RKUA
	yuSFJDyw0RGXFVbTEa810TCw9sEmqS31H+uZ0eUI8Qg==
X-Gm-Gg: ASbGncsxegCTByO3k6K1VsHKUe20vwLpuicumOrlyD6kvKp+yJJmzMfbSOkuahmS6hx
	P9dIjZYtxalAdhTjA9Dgq0b+t67mBVyYFIWcj8XmsEL4nXX936ZQj882kyUnp0INSsbDUJMq0IH
	aPtF2eSln3mOsLq3yhVw7/A4ak0SqqHjQSy66oQUtyF6AxrZHiYXYgSgJaqsSX0p04YP7tD7vd8
	n3Yra8mob3Q05XRp1LqOfYyc1pEf5d7ttR4+2HZP2x674dKsfXjTeitVT5DMmiADzgmqpAqxojt
	bQbacoGPMxJEBHC4
X-Google-Smtp-Source: AGHT+IE3KmYDFGeVP8vm6lY3xdcGUVy3w95tHVkpZ6gECTYHrhRU9cn+mn6vdK2o/wGFbA/KoklGqT3oyauzcDjh3so=
X-Received: by 2002:a05:6512:3d15:b0:592:f54d:8647 with SMTP id
 2adb3069b0e04-59412c42487mr1007961e87.30.1761743967499; Wed, 29 Oct 2025
 06:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org> <0b8ec641c76b39f6a96863c16e5f758451641849.camel@pengutronix.de>
In-Reply-To: <0b8ec641c76b39f6a96863c16e5f758451641849.camel@pengutronix.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 Oct 2025 14:19:15 +0100
X-Gm-Features: AWmQ_bkjxtg2FXNoc-CZ-J0YudbBfWqhJfw98u15uzEr2iaJoxlwIVFcuMlgKKI
Message-ID: <CAMRc=Mc7GTwXUw2PWMtSMRPf45feizfZkAWhO3NBm7OCh0Pj2g@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] reset: rework reset-gpios handling
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

On Wed, Oct 29, 2025 at 2:16=E2=80=AFPM Philipp Zabel <p.zabel@pengutronix.=
de> wrote:
>
> On Mi, 2025-10-29 at 13:28 +0100, Bartosz Golaszewski wrote:
> > Machine GPIO lookup is a nice, if a bit clunky, mechanism when we have
> > absolutely no idea what the GPIO provider is or when it will be created=
.
> > However in the case of reset-gpios, we not only know if the chip is
> > there - we also already hold a reference to its firmware node.
> >
> > In this case using fwnode lookup makes more sense. However, since the
> > reset provider is created dynamically, it doesn't have a corresponding
> > firmware node (in this case: an OF-node). That leaves us with software
> > nodes which currently cannot reference other implementations of the
> > fwnode API, only other struct software_node objects. This is a needless
> > limitation as it's imaginable that a dynamic auxiliary device (with a
> > software node attached) would want to reference a real device with an O=
F
> > node.
> >
> > This series does three things: extends the software node implementation=
,
> > allowing its properties to reference not only static software nodes but
> > also existing firmware nodes, updates the GPIO property interface to us=
e
> > the reworked swnode macros and finally makes the reset-gpio code the
> > first user by converting the GPIO lookup from machine to swnode.
> >
> > Another user of the software node changes in the future could become th=
e
> > shared GPIO modules that's in the works in parallel[1].
> >
> > Merging strategy: the series is logically split into three parts: drive=
r
> > core, GPIO and reset respectively. However there are build-time
> > dependencies between all three parts so I suggest the reset tree as the
> > right one to take it upstream with an immutable branch provided to
> > driver core and GPIO.
>
> Should that branch include the reset changes, or only up to patch 6?
>

I was thinking about it containing the entire series, somewhat similar
to what Lee Jones does with MFD changes.

Bartosz

