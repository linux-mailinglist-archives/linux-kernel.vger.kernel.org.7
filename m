Return-Path: <linux-kernel+bounces-744487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAECB10D92
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6B21684CE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21182E11CA;
	Thu, 24 Jul 2025 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="RAbgc+7H"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D641E2DE719
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367075; cv=none; b=H2VZpK83VRwQbMpEgHOWEP4uVR+jYCYx1cu7nwEupVq7p2OZuwA2K6aXAtfO1MlQQzfJOUISH51pYy3yhwHiF0ZD6UYY7lsPcbhMWirZyp15iR0eUn/T8WBH7pjuUeu1KKi9mgGwJLyypT6gpfZLR3YoDID4z0HPyEFoVTrYKEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367075; c=relaxed/simple;
	bh=LkC1cgJKGtDvQAhjzwy5MpcSRJdsTaL50a5baAXwX38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gyp+oHWRJF/fMUHVU2BMRZIyJmuNKbwbb8OWvBRRqreG5fwMVBGAuyq+NBCom4ANxvRmUuzmNycPZqxKg+H+lIofTqdCvZpyCpyVIR0cIz1PVPjMyvvoH44085/0uyhWdo80bi9ltHwNxPcnWWPOMVeTijaeuaMxTkVZAI59qpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RAbgc+7H; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-556373661aaso942180e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753367072; x=1753971872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uYFs6ImUzbg3uQ5rpuYkRYPBY5IeIE5OmGuHU/2KXc=;
        b=RAbgc+7H5KfZEMl3vOi6yjMsH9VcEbEVNUXo6waOWRmYSvzlbUKHYD0MhljgyA5C7n
         blyg6L4o2dNWj4HZvwHnQzT99oiTOhtLc3aJ6lEHUIE75k4aHH4IyCxaWXaNIKy2TrlZ
         5ko2Xv5yWq+WOXI8jF4oT5/PC6JioPsoUSot6zN7r9lpaav5bV0J9GBnrthLkoUgwcNE
         JsW4PSsrouffI/MTzrwolbeA8oh2PoNCvAwz2G0suv4xJJknx/XIEoXMxedays+oEVVd
         7ecVfqPBNv6OXtNFaWoXYjhWmv1dsvWN9stqjRpdCf5Y8UqpI0SIiRY3gj7Oh/KgtYrE
         lIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753367072; x=1753971872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uYFs6ImUzbg3uQ5rpuYkRYPBY5IeIE5OmGuHU/2KXc=;
        b=bQRty6Xwegl+eVuYpW4kvwkRxYLXspRuKMH3IZxWzs2/SBcxZ5xfQDKzXLvN6E7Rxc
         xgTRPeUS4MR3TW9o7ARCyXYq5z/YGJ9F+Y7iSH8fjVM35ZgzfNEId42F4aBRGX9Xd3+B
         dVQl+N5Dzd8CIHaBhY3ylkwPTS4hLcW0WXj49w2cyeN+xvtVXb6GDESXnFkZSK6cmJao
         L6VQtdOlKKVayrdUoLKw8tIUK0W3fiO8S6ZAX4z6OomC2YzMqm8DbDYrpSj2mbTmevth
         qxUi00hr6ANSAGIQ7j757mIcYff4CJKvdrV9kDHOGyobAg2U+mICHDcVWY8LHEvy48Jl
         ct7w==
X-Forwarded-Encrypted: i=1; AJvYcCXmpQUxuRjg+DWV9lnnX6s4LH9Th6P30icWVgZiTv855QvXR0Bp/4PnAFpRHt3inwWQmpII/oyRo2O2Tvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz89n+Sf8Z1NrfbNXHGdngS/r8tRiX9j2gVJbvNo/wIsiu/noET
	d/lTGN4vWpIg6DCwZkRHqtNNACQHTePy1RxpLJGixOsAL/GMfHGYbUuzm236908i2niJsxvU3Jp
	xQ5tynhocoyGAg6l7q+T2g71dMoT5MP8VHasqz6rHtw==
X-Gm-Gg: ASbGncsjMFKAH1pBmCdfYD24bNXQ0hwBuKbl1ckUDD50Hy6t63BeR2u/PurXKyS5Jy1
	FQls6pgTN8UDMhIYC6MO5j19ZBMnDbSIfku6zaOxttxnevRLyzatn2z4sdqmnlu6rteI0HxH50d
	N7PN1qOuk5mDsFk7pT9AIFh55i2jS6yYfRuJCosX+WG4WMKf/mXMy7xhQwHul7ViXBGzhLhqYqh
	qyPRbJeNC2SruA12N0flzag/XZMVC/h8X34DWY=
X-Google-Smtp-Source: AGHT+IEjwXFB7CZ/N5EXNvwHZZzddVKutYpP2ET2ny/nwGsfmJfNYNi3SOVPdhlxjJcNdBxyefwRwGoXwjpYGshc1FA=
X-Received: by 2002:a05:6512:683:b0:553:aadd:1987 with SMTP id
 2adb3069b0e04-55a513bf637mr2308389e87.30.1753367071796; Thu, 24 Jul 2025
 07:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722153634.3683927-1-arnd@kernel.org> <CAMRc=Mejnr8UzN93X=CWcV5jDTt9-U+Nxcm3qb=6uVV0PMiZVQ@mail.gmail.com>
 <c9d9eeca-b62a-4105-b65c-bf78158c42df@app.fastmail.com>
In-Reply-To: <c9d9eeca-b62a-4105-b65c-bf78158c42df@app.fastmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 24 Jul 2025 16:24:17 +0200
X-Gm-Features: Ac12FXySjq2DCPp7nTSI_XCm4U1HSCz6foMhOKdxkvw-uj6diG2D0UDnGBdWXp4
Message-ID: <CAMRc=MfxD+qGjamV+rCg766GyuMwVDUe_uOrUGGe=kr83v6Fsg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: make legacy interfaces optional
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Peng Fan <peng.fan@nxp.com>, Lee Jones <lee@kernel.org>, 
	Koichiro Den <koichiro.den@canonical.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Alexander Sverdlin <alexander.sverdlin@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 4:22=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Wed, Jul 23, 2025, at 10:39, Bartosz Golaszewski wrote:
> > On Tue, Jul 22, 2025 at 5:36=E2=80=AFPM Arnd Bergmann <arnd@kernel.org>=
 wrote:
>
> >>  #include <linux/types.h>
> >> +#ifdef CONFIG_GPIOLIB
> >> +#include <linux/gpio/consumer.h>
> >
> > I want to queue this ASAP but do we really need this guard here?
> > consumer.h already guards against !CONFIG_GPIOLIB internally, right?
>
> I was trying to not change the behavior here. linux/gpio/consumer.h has
> an #ifdef check but has the #else portion with empty stubs that can
> be used by any driver that includes it, while drivers that include
> linux/gpio.h never saw the stub version.
>
>      Arnd

Ok, fair enough, let me queue this and we can change it later if needed.

Bart

