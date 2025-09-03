Return-Path: <linux-kernel+bounces-799058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7CCB42671
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3DB216CE00
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D85F2C027C;
	Wed,  3 Sep 2025 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="G419lWI3"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEFE1F0995
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916187; cv=none; b=K8qpQEzA0HMHyE8a7NCn+VtGtxYNZeuFgn6B1SNuHNN7qNdPDizEHtIjUoL5r5ObnxH+qllmMdmRniaB6yWdocxWcXWLvxEYFEq/ouIkim7IPeZQDFPdNhLuXpYg0MGZBSM6y36Xsp97JbHgnXIWcVoZVHpb27kohZ4qEMI1D7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916187; c=relaxed/simple;
	bh=hLXU68EmiKde5eoDFzNCp09vveg2XPWuKlf9ZhrCMzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4OuxSWHBj6H+SirHa3S2Ejir70gBFDg0KodndHcLRXWxuW21DdYO72WRibcnx7JTvY9p4JqJdr2VqRHg98D5LTqn15wt8Js45eWUSwtRoN5OiLWC8pDPtg5g+4fmuRllYqHwqyCC+/f7P6wWXauPCnHgXrhcLT5PoWqWty+yTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=G419lWI3; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55f7ad815ceso3845085e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 09:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756916184; x=1757520984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnuUgpoxqT/R2cHiZvXGYBC70wBbE5DG9KP+Z3Sy5do=;
        b=G419lWI3AZjnT0kK7L8vEpE/UTOz5T2VhGkKP52qFwcdPJpt50L7xzgLNX2vmt8bIc
         AuRcW8fNKLncIxSQJAZCHnEjX9UXM8/iKu3OmvahGfEy2jKrCwnVokWW/KCiMVksRbeP
         jTdtGnAOQVltnUku2tro+ilSyofPi+hX06uYsI+3DreayPWT/+ekXdEpSad7AP0iGy2M
         YzScFJtZVS0M4D3L/plJU4zU4k4OQKoO4+akZ9DNMtrlchiankGeFjbumExsEuSU6jMq
         XjqdsumvYELViRkMIg6Gjnm1DFtrGzOTZks4aWjybg20DeePsacHUAQfkVwjpGgLCWg8
         HghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756916184; x=1757520984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JnuUgpoxqT/R2cHiZvXGYBC70wBbE5DG9KP+Z3Sy5do=;
        b=bX9y0q5cI7hv/6j5b6ECucQliwxvU5q1MdcCKof9DM+v8Wx5P08Qjan0u9P8wMw9YI
         WJ5ckNztv4nS8Zz97iEhq2rGoO562NAETEEE5gbgVkyW87Ruqy3eZsVSNk1h9MeztSkT
         PR0o/oRzGRQBvyqZEu2m1l5uXFTjatm2EPaJ9Ulb7YJJjZ6LDQHXK2mpLXrzCLB37dgG
         3oGRwiuxOj947ecHLTBGUmhZJiTpDMp0Wi54Urp6Uwmz1sHa3D+YJAEdF+xp75lXabtj
         YgOQ3JSu4ZX7gvwFTIbEYU71P/3lHTK6lQqwfV8E9fLTRaOXVN3ghUjuOODNO4iRWiZa
         75gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLrRMfRM0Q1s/7Y5KQM5R83gDIUxtejf+xMOti7cFKK1ogqdXztm02X3VkB7CoHW1OHybrkRojrQIZe2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj0C+AHb2vInWt3ojcGRWvEFUjysGg/WxTSKu1ICLYjZO1lYxO
	ZvW5Gf0nilnnqlSCTUytwVw88uc4y95ZlrCFpUqEwcfpc+1Zihs+lybQejn7WOqj51kDFcaKCSL
	xE0To22yEWWEQl739dRAhSQgSRKDTzPSpPyb5WFdJAg==
X-Gm-Gg: ASbGncufD/kVF00IkMWwdVZQzbCL6JHKD7WYpw3cMPtPpFBHfrtrQsl5yuTC6hb5la3
	JJ7ssWi/2d/aygnXLLv1BpwmMJCuJ3ffQuhS/HAma57gn0zGwO6JUCxI083lv71DCC6t1jLp2us
	oMljIqvkVnAPqzzqZss6z34IkUGmUSzHoUJ+Gr5pc+UEWsmPgsR0iWhMK12HoFzBjyBjtdBwLKY
	BW3CI2ecxKWLSkyMOlFDKjyg7ojAt1vFdyTN4ILAlucbrtyoQ==
X-Google-Smtp-Source: AGHT+IETvnuci7NX/iSfBNiVm70fb0ED1MLT3AMRYWYzaOQPVbLN1BKnBTrWBjGhb7WJoLmVGbMIstEEvAOjYxu1SWQ=
X-Received: by 2002:a05:6512:4608:b0:55f:639b:8057 with SMTP id
 2adb3069b0e04-55f708b33b2mr4219335e87.4.1756916183991; Wed, 03 Sep 2025
 09:16:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825-gpio-mmio-gpio-conv-v1-0-356b4b1d5110@linaro.org>
 <20250825-gpio-mmio-gpio-conv-v1-9-356b4b1d5110@linaro.org> <aLhj6xsR-NepfRx0@black.igk.intel.com>
In-Reply-To: <aLhj6xsR-NepfRx0@black.igk.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 3 Sep 2025 18:16:12 +0200
X-Gm-Features: Ac12FXy4hHxwtV529JMcJlTzXuQUmxOxLYAQnOsq8scl9FcZoY_Q3ary9lE1izM
Message-ID: <CAMRc=MdDmPumdsrJ0ELPSgRB9UBzW8LcGBRSt5N71eZy21oDAA@mail.gmail.com>
Subject: Re: [PATCH RESEND 09/14] gpio: dwapb: use new generic GPIO chip API
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
	Hoan Tran <hoan@os.amperecomputing.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Yang Shen <shenyang39@huawei.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-unisoc@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 5:51=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Aug 25, 2025 at 11:48:50AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Convert the driver to using the new generic GPIO chip interfaces from
> > linux/gpio/generic.h.
>
> ...
>
> > +static inline struct dwapb_gpio *to_dwapb_gpio(struct gpio_chip *gc)
> > +{
> > +     return container_of(to_gpio_generic_chip(gc),
> > +                         struct dwapb_gpio_port, chip)->gpio;
> > +}
>
> Since it's not a macro anymore it can be done better:
>
>         struct dwapb_gpio_port *port;
>
>         port =3D container_of(to_gpio_generic_chip(gc), struct dwapb_gpio=
_port, chip);
>         return port->gpio;
>

Sure. I already applied it so can you send a follow-up?

> Also, have you checked the bloat-o-meter before and after, wondering if w=
e gain
> something with this.
>

Not yet we don't but we will move the gpio-mmio-specific fields out of
struct gpio_chip so we'll gain several fields worth of memory per
non-generic chip system-wide.

Bart

