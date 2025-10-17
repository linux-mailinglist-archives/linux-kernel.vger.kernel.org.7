Return-Path: <linux-kernel+bounces-858364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFDBBEA96E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 440515A90C4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A082F330B2E;
	Fri, 17 Oct 2025 16:01:01 +0000 (UTC)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CAF25D540
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716861; cv=none; b=B+/cHKP3oAvSUL6DBPeM/2NdJqmESwq6tpb2ySi2XiN+hF+kp7QnLeOwKFUiFpPVrx3onr2O2xgK1UtVTCCAfQt2EgNS7c2pZlhObWlEOggHnqFFJ6FlkEHyueBxaTdzbX/JVfn/1N4vYFvUXfyZ2XmijPbebrwRR+Vi4NB7iCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716861; c=relaxed/simple;
	bh=5UuF/HjwkQMRQp3toEpBUcYrHBj825aq+Tc6Itk11zY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ruq6YnvZuGsclaw/ziXdROJ3zchQ3ue9Epd+kWQs1nWdw6XuDjk8DT9kYsVV1OxLQnv4XMI0X1uWA0bOwCKL7j7zwG4zK87wMS02cWWCFuelVam/1BzD/D0K4mI8InmFE2JeY1DRRgVCzxqJo9coPoexRAhAEyjdFRqZi2Pjbz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-54aa0792200so1499031e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760716857; x=1761321657;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4mf9FdrvOGmLornKgNki0gXD9BcM6SCmzEl3gfV4Zs=;
        b=p8IvacmU+8mSzSFMpamR7tHEG1WbHRVbv0QKpj/vHIV8/GkGyoseGpCrYP+mOdUzzl
         teSIdxnKjZe9zYNbfClb1eUEaP7c6ebUTn/ZtXIcTzT7bGBkBWyK/sYyxXj7aHxjORv1
         v3TsTnRFNhYQef0jxWtsfGrVSmBY+IzvPrTPsVJ+vMyt7Qq9bOFR+SH5EBliQ7MCQ43r
         Mnuyqr3WCaz3cR5921XQ0J0t3DCQi/vdBj15l/dge/MSkZ+3K+SQkNzfmFzU9pdIdT9g
         ox1d/WyMAkpVJhWWwu5BL3NatJYivLesYLX+DLz5vp+813OlbA25IUhJ2F6pSQiuf5il
         8eCA==
X-Forwarded-Encrypted: i=1; AJvYcCUSL8sCAHBCPdpj9liAuHdrLlwObMrDRxX0QLLMegtXB+9pitdzwB4Bg0qW8MnWT2sXxZl6VPl09v40B6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKQWUVzItWBgzlRwBU6vGtRb8aQq94nBbonb3AcShT1ALM6Awh
	+UkRre2vnWNs0MU7qh8Tm8H8hpVBFOxlPT6fEJNCFB7HvoNYf2Ug3Xo2B7vF12bV
X-Gm-Gg: ASbGncu1gos2dkYHdsvK2eVZ6aFpRFItTalyl2dRvO/h8L/i4shjWb8r3Te6amFscVw
	jRbhzj5X1G9LuQ1Mrcm+pDmj5q9uQSEAdYpqNGJe6r9cvyEgD2gTpMUVHEe2y18xMvvwUtrg3NL
	QJCAtwOQ5/XomsQndUNJ8K5oLwgaiy6DJVi8ebRZxoAeMNqhi/Lj/GtO/9ncvvGwOLEh0OIhVFm
	7jIWIua1n/3CqWBQ9OnI58MDurIfxIz1aRa61igTAosyjJtwsF9roxPmkCdT0C09XkBHN+1o2HO
	8EOgTBRcCZA0ULV1rTVRoBE4AzA5vuX8l+uGGif3LwZPjdx0NsV+pCwNsxSYGJPkaf95Ud19jHa
	g+mIPBIvluve6FYmw6DoSAMsf8/7+ywk43rS70H74oK7jxMc3KpCNsvIBTlTNaikKMRQ7L3k0Xj
	Ux4gVTIu2ZzEJX2kSZQd4p3J4lnAKv3VlMR8kczgfkI0rMcCu5
X-Google-Smtp-Source: AGHT+IHrigPzWvKZH5GLNO4IM1Nu5Cy2CgashHaQJ7os/gJbbYHCqhXFIVGe7jjSMeV/c9mt/1ER1g==
X-Received: by 2002:a05:6122:469d:b0:544:79bd:f937 with SMTP id 71dfb90a1353d-5564ef7fe75mr1904996e0c.15.1760716855742;
        Fri, 17 Oct 2025 09:00:55 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d8109b5csm7032130e0c.25.2025.10.17.09.00.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 09:00:53 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5d967b67003so301933137.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:00:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVhAs4zjarU+Vt5FLdbLQK48hDW/5li2CduVfTZSsHQIBBCyMYlt4VCby+1S0w1AomX6sb0hYk+36C4x/w=@vger.kernel.org
X-Received: by 2002:a05:6102:40c6:10b0:5d7:dec6:389a with SMTP id
 ada2fe7eead31-5d7dec64177mr1309355137.9.1760716852567; Fri, 17 Oct 2025
 09:00:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739540679.git.geert+renesas@glider.be> <2d30e5ffe70ce35f952b7d497d2959391fbf0580.1739540679.git.geert+renesas@glider.be>
 <20251017081912.2ad26705@kernel.org>
In-Reply-To: <20251017081912.2ad26705@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Oct 2025 18:00:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVS5KmVkv_pmc+R-EXik-Z1_7nuiHM=vm1Cu8v91wmLBQ@mail.gmail.com>
X-Gm-Features: AS18NWD4CQztq7yi6j63q-9XtnW0otWo2wOw8z0_Fp7R-6z_qrlZWB5IqFYEbBg
Message-ID: <CAMuHMdVS5KmVkv_pmc+R-EXik-Z1_7nuiHM=vm1Cu8v91wmLBQ@mail.gmail.com>
Subject: Re: [PATCH treewide v3 2/4] bitfield: Add non-constant
 field_{prep,get}() helpers
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Alex Elder <elder@ieee.org>, 
	David Laight <david.laight.linux@gmail.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	qat-linux@intel.com, linux-gpio@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi Jakub,

On Fri, 17 Oct 2025 at 17:19, Jakub Kicinski <kuba@kernel.org> wrote:
> On Fri, 14 Feb 2025 14:55:51 +0100 Geert Uytterhoeven wrote:
> > The existing FIELD_{GET,PREP}() macros are limited to compile-time
> > constants.  However, it is very common to prepare or extract bitfield
> > elements where the bitfield mask is not a compile-time constant.
> >
> > To avoid this limitation, the AT91 clock driver and several other
> > drivers already have their own non-const field_{prep,get}() macros.
> > Make them available for general use by consolidating them in
> > <linux/bitfield.h>, and improve them slightly:
> >   1. Avoid evaluating macro parameters more than once,
> >   2. Replace "ffs() - 1" by "__ffs()",
> >   3. Support 64-bit use on 32-bit architectures.
> >
> > This is deliberately not merged into the existing FIELD_{GET,PREP}()
> > macros, as people expressed the desire to keep stricter variants for
> > increased safety, or for performance critical paths.
>
> We already have helpers for this, please just don't know they exist :/
>
> The "const" version of the helpers are specifically defined to work
> on masks generated with BIT() and GENMASK(). If the mask is not
> constant we should expect it to have a well defined width.
>
> I strongly prefer that we do this instead and convert the users to
> the fixed-width version:
>
> ---->8----------------
>
> Subject: bitfield: open code the fixed-width non-const helpers so that people see them
>
> There is a number of useful helpers defined in bitfield.h but
> they are mostly invisible to the reader because they are all
> generated by macros. Open code the 32b versions (which are
> most commonly used) to give developers a chance to discover them.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks, but this is more or less the same code which you suggested
before [1], and to which I just replied[2] after looking at the
generated assembler output on various architectures.

> @@ -188,6 +193,81 @@ static __always_inline u64 field_mask(u64 field)
>         return field / field_multiplier(field);
>  }
>  #define field_max(field)       ((typeof(field))field_mask(field))
> +
> +/**
> + * u32_encode_bits() - prepare a u32 bitfield element (non-const)
> + * @v: value to put in the field
> + * @field: shifted mask defining the field's length and position
> + *
> + * Equivalent of FIELD_PREP() for u32, field does not have to be constant.
> + *
> + * Note that the helper is available for other field widths (generated below).
> + */
> +static __always_inline __u32 u32_encode_bits(u32 v, u32 field)
> +{
> +       if (__builtin_constant_p(v) && (v & ~field_mask(field)))
> +               __field_overflow();
> +       return ((v & field_mask(field)) * field_multiplier(field));

Unfortunately gcc emits actual divisions or __*div*() calls, and
multiplications in the non-constant case.

So I don't think this is suitable as-is.

> +}

[1] https://lore.kernel.org/all/20250214073402.0129e259@kernel.org
[2] https://lore.kernel.org/all/CAMuHMdU+0HGG22FbO3wNmXtbUm9RhTopYrGghF6UrkFu-iww2A@mail.gmail.com

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

