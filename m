Return-Path: <linux-kernel+bounces-888793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8482AC3BEC6
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA6B560461
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68359346E69;
	Thu,  6 Nov 2025 14:54:42 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16022346A0E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440881; cv=none; b=G4k7/QaURQeIeLfHJTLxv7qE7Z3TxhR+Rg71bSa4/YDk5V4FokHvv4wY+JiDObMKlbCrNpwne1436tvrHpIa73wOYBvIwCkmr5uVfbkAeNi8VQwRqE+ZZDPIAy46y5b29HWSjEo28MtxSQ867+nLJkgThZy2Ue9TFZ0Kt4d+q6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440881; c=relaxed/simple;
	bh=HaefBq/9gx/xpe6H9SR+jXE6I2U49/Bi4dkyZMOckp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4sVZbTP2pLAJv9TnpVSxO47djKt3jySnWH8u32VM4olW62OL2m0v94ps/vHECS+xqAASpQv6jtS1TaE/n6eiUkkiK+HmUOJRHrcY34j2O7zTtR+oup8Z7b7z8hcA705j1ZW6jf1L/FrGzKJaI/7ls9y8Dm6ogbifhea799vzUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59431cce798so1164215e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:54:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762440878; x=1763045678;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxZVtMOHoNocoyXPFvfejRTHivuCeFc8a9lYqiVNw1Y=;
        b=mVBCDcpbf0mimpiMyiGUnEETWHilIdEpg0VIDxlYlkrnI4auwnXvzoONWseE00yD+e
         zFRCnOkjAIRj7EF14M/NExQOm+Fiv1KaNylPhGLhE9/57qNiriCHwh2w3rwJOBAEPaIm
         c+pDFxP9a+wdoKp9f1TwVR8GtePRPMerSWOUXhgKFzGXUWZaM424rPuctXnctO+UdI/u
         XZ+thtqwIQ8wTOGfIABXwkJJF6zyENDoT166V9vb9+d4nQXTv7h8miRK1GzSmbzfR0yJ
         P0E8R1o/NuLRve8wGYsLYDtEpPNBK3Wfr9QrLXWMTJxINc5LG49GWFVjRw9CONNdJb4n
         Negw==
X-Forwarded-Encrypted: i=1; AJvYcCWEdnr8cK3jzn66IMN+j8uqcVqGLaZjxOba7KXjW7vytNd8NDfCRMMlqp937wzK3Lmm9sFw6CtJe+I2Z9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5tgbnyVktqJeYyCwBjucomPUnzo0764g0AHYS0/Zu6oA2+tc9
	vyGJekQRobD10CvkoYGhQDHMdyuYXM899GuKHc0XA1TmkcvJpyXdmPmEwC1h9Yp6aEY=
X-Gm-Gg: ASbGncsHL/qM6h6BONGEi0/91YG1h6Z4d+VgUI8p9ibtBhmukcgGkSY98lQGR71F4fz
	Z43qofIkFt+BDQibuzD0gf2F1sIcLgMxHp+yK6GxSel9mzo1Yz3JBzZi85ky6M9vRwdAyW8Nkri
	mwmOSIxC93t7jKGQOVulrMno98AbmNIRX7ILefXJ7iVziqF4mG2dnkeOKWzpaTxaynrGrf6tQzh
	xaR+kuZeoN+iKLCEd2lIv6FDjuXUtd3IZEx5c63ZFOSI1vOC4Mt3OZoaD9nuOtWMjdezQPLRivF
	eo0oVCfJ/Uu3vbj6O1rb9FcE3wQYv9NBvvWU4y9wc6vzLzQZc688HzM9Ksk1EF4+8acvsrV2LVr
	OF2apOi6B0yDfRmytY2LR2PEFGDx9YuDK+tz6tdAIAxXGuabkaao7nYVnkHHsI1iPr3Ej62lIcR
	Z8kbBv/ygGvMPwkkHhN2PKT7V80UiuGTvMeHqCDA==
X-Google-Smtp-Source: AGHT+IG6EWMpOunInV+41Q8+/9N7BdS/1f5bGEzAI5VL1qKsdhbwPx81YmWAEREZxFzuXY5AePZfbQ==
X-Received: by 2002:a05:6512:3ca0:b0:592:fc68:5b9e with SMTP id 2adb3069b0e04-5943d751fb7mr2401508e87.19.1762440877541;
        Thu, 06 Nov 2025 06:54:37 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a0344ffsm773610e87.47.2025.11.06.06.54.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 06:54:35 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59431cce798so1164061e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:54:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWZZMzFBgmgGTjDc6eKgPZGo8ivSTGOIh6JM6eA0hubA6Hz3S3SBgNgL/ZXDcGf4aNreviKDJfs06rXx0Q=@vger.kernel.org
X-Received: by 2002:a05:6402:1ed5:b0:640:b643:f3c5 with SMTP id
 4fb4d7f45d1cf-641058cf323mr7301623a12.16.1762440555932; Thu, 06 Nov 2025
 06:49:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1762435376.git.geert+renesas@glider.be> <cfc32f8530d5c0d4a7fb33c482a4bf549f26ec24.1762435376.git.geert+renesas@glider.be>
 <aQy0T2vUINze_6_q@smile.fi.intel.com>
In-Reply-To: <aQy0T2vUINze_6_q@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Nov 2025 15:49:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXVUJq36GvNUQE8FnHsX+=1jG4GOJ_034r=fgr_Rw4Djg@mail.gmail.com>
X-Gm-Features: AWmQ_bnZOzLGAFcWzxKh1EIKjH4MNs7moeVCtN8xGb6mN65nYBliBYrABdUBf0M
Message-ID: <CAMuHMdXVUJq36GvNUQE8FnHsX+=1jG4GOJ_034r=fgr_Rw4Djg@mail.gmail.com>
Subject: Re: [PATCH v6 12/26] bitfield: Add less-checking __FIELD_{GET,PREP}()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Yury Norov <yury.norov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>, 
	David Laight <david.laight.linux@gmail.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Jason Baron <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Kim Seer Paller <kimseer.paller@analog.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Richard Genoud <richard.genoud@bootlin.com>, 
	Cosmin Tanislav <demonsingur@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Jianping Shen <Jianping.Shen@de.bosch.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org, qat-linux@intel.com, 
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-iio@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

On Thu, 6 Nov 2025 at 15:44, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> On Thu, Nov 06, 2025 at 02:34:00PM +0100, Geert Uytterhoeven wrote:
> > The BUILD_BUG_ON_MSG() check against "~0ull" works only with "unsigned
> > (long) long" _mask types.  For constant masks, that condition is usually
> > met, as GENMASK() yields an UL value.  The few places where the
> > constant mask is stored in an intermediate variable were fixed by
> > changing the variable type to u64 (see e.g. [1] and [2]).
> >
> > However, for non-constant masks, smaller unsigned types should be valid,
> > too, but currently lead to "result of comparison of constant
> > 18446744073709551615 with expression of type ... is always
> > false"-warnings with clang and W=1.
> >
> > Hence refactor the __BF_FIELD_CHECK() helper, and factor out
> > __FIELD_{GET,PREP}().  The later lack the single problematic check, but
> > are otherwise identical to FIELD_{GET,PREP}(), and are intended to be
> > used in the fully non-const variants later.
> >
> > [1] commit 5c667d5a5a3ec166 ("clk: sp7021: Adjust width of _m in
> >     HWM_FIELD_PREP()")
> > [2] commit cfd6fb45cfaf46fa ("crypto: ccree - avoid out-of-range
> >     warnings from clang")
>
> Also can be made as
>
> Link: https://git.kernel.org/torvalds/c/5c667d5a5a3ec166 [1]

Nooooh... torvalds might click on it, and complain ;-)

> > +     BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >               \
> > +                      __bf_cast_unsigned(reg, ~0ull),                \
> > +                      pfx "type of reg too small for mask")
>
> Perhaps we may convert this (and others?) to static_assert():s at some point?

Nick tried that before, without success:
https://lore.kernel.org/all/CAKwvOdm_prtk1UQNJQGidZm44Lk582S3p=of0y46+rVjnSgXJg@mail.gmail.com

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

