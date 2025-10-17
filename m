Return-Path: <linux-kernel+bounces-857902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 696AFBE8393
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A426E8322
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABEF32AAC6;
	Fri, 17 Oct 2025 10:55:20 +0000 (UTC)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7634A328B74
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698519; cv=none; b=RO8utvEU00m8j44xtxZE/+EcUwhP1B8euDyzbrMwcUOTpwbOmjzOCoK5gf/iNsu59/Tft9fj1s2ca0utINQwQNfo9WWer2ZGd0u8emmqo98icZMl6mPs2VcLWwDYqe9VyHPVVNXn2KIfSD2pjlLDtKR1Ms5cMNE54BDbAwoNcPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698519; c=relaxed/simple;
	bh=7roeWK5AtO/7ZwDK0dlN3Uu9wiMocaa5toCTUlYqJaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iOvuBTpgg10q2oMhXI9iYCf7BL08K4M5KeMlCq2sIBmRIYQ/luooaOL+WzdGevOGcJi3j3Ce0R5sffg9yjukALWluqmqmJZXyUM7JEqBhGb9gzHvMjNBbLClyo+AC8RZN0I3UUVFO2zQKzOUDHYRTx2sii/qwBHi3Zo8+sYFc+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-9310a7b2668so382688241.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 03:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760698516; x=1761303316;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zPE9WHNZsdRI3QmdRcH/wWeYzKksV+R5Ry8aWltKbjU=;
        b=h+fLs/nZBNivSQBBacr+Ubvy10p6B+CycgpZw0XJm/G7G1zb9mO7S9oMJSpKCmJt9J
         YpnfK/AzZEhI7YO0AVblUJYRYbI45kTlzE/hRVmg2NxNUX9xT10fk07FCzgdtukZsUzA
         lta9O/P6OQBZYDBUKvGe8Qn50IXBN4uRyFU3TBPg+QpeiaQY4xoul3JDSdPZnClgF4DP
         M5+glLU4EUixwrdXG7IDB7BfWr9a+R+NIxtYHCwuBpTRsroKT73BZdr6UA/IgL23dXQG
         VQEGtwRp7hP3wHgg1GUdqCu7ZrWwfrWAcoM7bgNaiXNOQn+z5iH5CvWFdK4tu9hIph5h
         tPNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgtOr+ZB4x0pnPJjxIiI1z5NIKEdzn45T9bmi+Pke1z6NSc21NXK6ohuU7uaRmzF3H64xZ1cgJ+Tb31JQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKSVIh/+/kY+i0FhLM5t36rjW6io4oUHYvARecW2rdqXEgJRR5
	/9yyGxZcPzR25FT78wPdr3P5Ozph+Qqa3vW9zlanX85wQgFHLjbIQYnINn6l+GQ3
X-Gm-Gg: ASbGnct64y82mtVwiJi+KYlaBOZOdX9tJua2Z+3j+wIvWGPO+I39RG841A1UhdWfBHA
	uAH477Qmkcye8bL6CT9PpqCh8R2isF0mA4iKd8gaLYUxPTqXc6WtJkRB9Qmyi1g4IzENoyuCviD
	dAoDLi4U1wZvVMPrz21DEorwGTWPxl0U5Zbzlcc2fL2YYHkSpaUe9CFZniYZVOSobLMWhUXIMaj
	2+/CblRIyHD9/PyRdJJUt9lBHvUyPT/g7uUxvL4bzZ6Y3dhqlUnx3W1CH0vnT2kBWrYbpD+4Kyd
	KGD2kyduhHR2VWKjnRYEUHx+bGd249eqYi6fArwY6igddbOn0J7Q/19i8DGcrSHCkPZTgQVQGqX
	ka8L+qDSsuBEeweXkeEjCevmNiifxYpiaFuItbfTD+CSRUhBiDztE85TXZU0FXyJcsu9VA2BArC
	wclzvmyRp+9E/UdW0yJCr8yOiL1Gv0GzTf2Zm4OnCy7mQlXJDu
X-Google-Smtp-Source: AGHT+IEedJIWpEFoiaUcNsR4//QsnnhoSAxM/V7kq2REnRy7X4z4m0Ya3UdKle038duGjA7Y7OHYbA==
X-Received: by 2002:a05:6102:6c6:b0:5d3:fef5:8c08 with SMTP id ada2fe7eead31-5d7dd6a51dfmr1207187137.21.1760698515644;
        Fri, 17 Oct 2025 03:55:15 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d6347977d6sm3328042137.2.2025.10.17.03.55.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 03:55:14 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-580a1f1f187so701544137.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 03:55:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKycRrkZqgra9X23GWD45hfL4On2vTuJBvbzP+aCzVM4F3fDzb90/A6vvCI3IADuxRMroBk1x/79DVao4=@vger.kernel.org
X-Received: by 2002:a05:6102:5111:b0:5d5:f766:333e with SMTP id
 ada2fe7eead31-5d7dd5934demr1126362137.15.1760698513447; Fri, 17 Oct 2025
 03:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739540679.git.geert+renesas@glider.be> <2d30e5ffe70ce35f952b7d497d2959391fbf0580.1739540679.git.geert+renesas@glider.be>
 <20250214073402.0129e259@kernel.org> <20250214164614.29bbc620@pumpkin>
In-Reply-To: <20250214164614.29bbc620@pumpkin>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Oct 2025 12:55:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXost7vL5uTocMGtrqhEk5AY3QUWvyP5w7_hBtf3MkMfA@mail.gmail.com>
X-Gm-Features: AS18NWAcP6voBjoIoEi-7RxJ0pdmzXqhfe5FdHBNP60R0y-DyUBofdEL44euygw
Message-ID: <CAMuHMdXost7vL5uTocMGtrqhEk5AY3QUWvyP5w7_hBtf3MkMfA@mail.gmail.com>
Subject: Re: [PATCH treewide v3 2/4] bitfield: Add non-constant
 field_{prep,get}() helpers
To: David Laight <david.laight.linux@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Alex Elder <elder@ieee.org>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, qat-linux@intel.com, linux-gpio@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi David,

On Fri, 14 Feb 2025 at 17:46, David Laight <david.laight.linux@gmail.com> wrote:
> On Fri, 14 Feb 2025 07:34:02 -0800
> Jakub Kicinski <kuba@kernel.org> wrote:
> > On Fri, 14 Feb 2025 14:55:51 +0100 Geert Uytterhoeven wrote:
> > > The existing FIELD_{GET,PREP}() macros are limited to compile-time
> > > constants.  However, it is very common to prepare or extract bitfield
> > > elements where the bitfield mask is not a compile-time constant.
> > >
> > > To avoid this limitation, the AT91 clock driver and several other
> > > drivers already have their own non-const field_{prep,get}() macros.
> > > Make them available for general use by consolidating them in
> > > <linux/bitfield.h>, and improve them slightly:
> > >   1. Avoid evaluating macro parameters more than once,
> > >   2. Replace "ffs() - 1" by "__ffs()",
> > >   3. Support 64-bit use on 32-bit architectures.
> > >
> > > This is deliberately not merged into the existing FIELD_{GET,PREP}()
> > > macros, as people expressed the desire to keep stricter variants for
> > > increased safety, or for performance critical paths.
> >
> > I really really think that people should just use the static inline
> > helpers if the field is not constant. And we should do something like
> > below so that people can actually find them.
>
> Especially since you really don't want to be calling ffs() on variables.

It is not that bad, as most temporary architectures have an instruction
for that.

> Much better to have saved the low bit and field width/mask.

While that would allow some space saving (only 10 or 12 bits needed to
store low + width), gcc would generate quite some code to create the
mask (even on PowerPC, where I expected a single instruction would
do ;-).


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

