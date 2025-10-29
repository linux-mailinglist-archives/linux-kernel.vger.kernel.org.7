Return-Path: <linux-kernel+bounces-876423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 08540C1B665
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A890E349C36
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767E833F8BC;
	Wed, 29 Oct 2025 14:43:06 +0000 (UTC)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9A337A3BD
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748985; cv=none; b=kR94Ib48bz9netFmqKDKPFLOydZQJ7f48r8rnlxwL9y2GzaXgY1RBegv8ihsUQiNK+2X66zZLThr6aSGVryovQUr1obuMaJOsTj6HXF6OrmyNY/A2zVTmvGBajapCmlUeqwyd49sXd6zoi8vXwrUWyObKzcREppNmZhW7zoLAPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748985; c=relaxed/simple;
	bh=QXFJ9Wye89l5k56IzhXHnCZ5vP4dVOGIaGxaTnibrdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9NvFEFZCSJxfuM6oMEmrt34tKLxvorRzwUrLse6tBEeAQEbpZkQoWjDGKLGy2AW9REq5yJUvqfjH4+kOgima8G71pxQhgCX25QGHMLUV6PL7RL1ljKTCqHWiLw6bg84rmDxp5qX1C6HB6lad2Ih4C3ZHulSPU49yspgEHOTFzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5563c36f6d4so1121159e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761748983; x=1762353783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohi/8MFIs+pUNYTuSKDH5KUVpFMJO5wn0YyhdMa7QIc=;
        b=dO8mRkg/DnoeLAAcJvbdQNHXFZ48iADFSZFWF5Xgje9XCW3dfr3r7xtFCK3qN4k5k+
         EbQaMRVGB9jDYRhodGYeYGew+t1YeE24ZvA9roRKM8r12xT4wtSKERYrWzUPOhao+lLE
         gN5chy/6Vj7WNL/cc3X7ylyQS/bD3YWX8uX+2yVymosuGSVFwr02zDZ+AUzBrU5NRhie
         e4zlgZs+9NsY1ze62wE/rj9tx+sxGy44SknjkWnjO7BoXCQbPc+6E5hy+eFIBcMscJ60
         tz1fLdmezHvVgWYE1oyI5hX6s3sG1qciKNXEXn1H4rtCTqqVbXjf9yLUmx2z9XZiSY96
         esgw==
X-Forwarded-Encrypted: i=1; AJvYcCVahzKUMYD8B0+d7+RYDjb2hYy1jLP6+rV5+3X7XRbyjxzVJm09pBv+tyQA4iG2qc5TPIyRyj4QlMSH3es=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw3RxRw4mJQjUpgqwpNWiyr+kA4Jycsq/9hZpeUMadqZDyfXT7
	yUvyYZyGmW1AFDzCGy3mao4t34Vz9Aj4zsp7uT3Y8J1p6vdaNKUx8D6jhlAlezya
X-Gm-Gg: ASbGnct2LGOlPlTjtnv2uEb/RHd+0VHxAMvOpIjv330bGDp/0HhmzukKAszTLOSYu6G
	PD0PdGBTVPgi3vr2OQ+sDHzar5O1pXGPelrN+uIwRqSrYoc/pYQq8ASKO+duaVjNQ1jX56C3Qoh
	XZoFWtzcYjCvfy5Di8ef+R5fFL6/pOaxaITKUffwpRAwIdAcUsTHdBZrEaQ07wN9p1Fgs8/xwFM
	mcK9CAZeHLIOGfwcgidhh+KoxGnq1Sq3Krn3nrpGFhdfYZeP7Z15Ej7XL1XPzW3BJD4DL7kFl4j
	5kQMmRyxCghCRUCz+wC67+hCF4uVlltsffYMv12mF6NuhjQ8ov7q37jEX8gmiGd+OVHyNFKSupL
	1kYXPTsvlT2xJrFi3WJ2u+yfclYrmyNVzy0Xmcact58bcQQysojh2cY9Ka+ZdnHQW3+14/KLAaI
	Wv1HPcEW6QHr7UL6/NdkFf71Ms03pU02QWhq5K+5V+8g==
X-Google-Smtp-Source: AGHT+IFeM0wP/q6OgYbBa4rrKsKupjj/n3wSmRTppwF4OSSQ/5U+lByHMdj/18xOKr7HBzI6m/Tc5w==
X-Received: by 2002:a05:6122:45a7:b0:557:c734:ee5 with SMTP id 71dfb90a1353d-55813d0e3a0mr1171712e0c.8.1761748983084;
        Wed, 29 Oct 2025 07:43:03 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557ddb06260sm5564203e0c.5.2025.10.29.07.43.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 07:43:02 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-932c428442aso1029488241.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:43:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW4CKpQiEyz2XE5X7LpP4wP3OlSxRHr+UZpp97F32IvKNlc7YvhzkGq3KPkRQa9STLa8uSwdaspnZuixpE=@vger.kernel.org
X-Received: by 2002:a05:6102:2acd:b0:5db:9b88:1fec with SMTP id
 ada2fe7eead31-5db9b88219emr535412137.9.1761748503547; Wed, 29 Oct 2025
 07:35:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761588465.git.geert+renesas@glider.be> <ac3e718c5de6a23375055dd3c2e4ed6daf7542d5.1761588465.git.geert+renesas@glider.be>
 <CACRpkdYMv+R-NJ5R4+UyhK1+DJia0z72kZgt45+0eubXMuGpEw@mail.gmail.com>
In-Reply-To: <CACRpkdYMv+R-NJ5R4+UyhK1+DJia0z72kZgt45+0eubXMuGpEw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Oct 2025 15:34:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUvLH-8yNRoqBdTB+mcmOUedwVGpJ_HGdq8sqgLNB4dvw@mail.gmail.com>
X-Gm-Features: AWmQ_blZ8dUVr2aBwtWAAkAOaE93AtUSPNFDpslgvmXepFfW4tMWIOUWnRJkksY
Message-ID: <CAMuHMdUvLH-8yNRoqBdTB+mcmOUedwVGpJ_HGdq8sqgLNB4dvw@mail.gmail.com>
Subject: Re: [PATCH v5 18/23] pinctrl: ma35: Convert to common
 field_{get,prep}() helpers
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>, 
	David Laight <david.laight.linux@gmail.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Jason Baron <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Kim Seer Paller <kimseer.paller@analog.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Richard Genoud <richard.genoud@bootlin.com>, 
	Cosmin Tanislav <demonsingur@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Jianping Shen <Jianping.Shen@de.bosch.com>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org, qat-linux@intel.com, 
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-iio@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Wed, 29 Oct 2025 at 15:21, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
> On Mon, Oct 27, 2025 at 7:44=E2=80=AFPM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>
> > Drop the driver-specific field_get() and field_prep() macros, in favor
> > of the globally available variants from <linux/bitfield.h>.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > v5:
> >   - Extracted from "bitfield: Add non-constant field_{prep,get}()
> >     helpers".
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!

> I guess this needs to go with the rest of the patches?

There is no hard requirement for that, but if 07/23 goes in, why not
include this one, too?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

