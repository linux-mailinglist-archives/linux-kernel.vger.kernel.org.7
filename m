Return-Path: <linux-kernel+bounces-889979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6791DC3EFA1
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2214F3A3F41
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38643074AC;
	Fri,  7 Nov 2025 08:35:19 +0000 (UTC)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54527259C9C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504519; cv=none; b=JqrcuSkxLMvar0dJHvlQd7jOEt+bLyg4cofs0uFoNt303bYDB2j1179nZpv6xMzyr17nm0wzYAP6jlZ1V6jpt80/ICyVkGQeiIRRFPFHDQgKYSytL8EU+2LRFOJeWgKwYeN3zHlhFDdF7Ib8oe/Sv/RBxliyJNEe2FkmF3hZXDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504519; c=relaxed/simple;
	bh=9JcvPVILVy97hsdXJNb7VMxu6BBjGO1PhoJ8NRS9yLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+1RJXl37PL2iiGxXHh3VQe2mQix6cBAR3XC8vy8cfeZXnMDcGD7W6M1dqG7otEZ+4P9l0Srj6yHOUe0hDtJyQnv7JTjmXcPRrYcdmU7ybfcH+BM+oBeWlCHvYpkHuLBV7qh7W3okYOyyLLvK3PoRmEyXXDNJUrhh+QytYmKdpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5598e714938so330613e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:35:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762504516; x=1763109316;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsHZezS59+NExnNGIIdIy6ER8EF0CQG8kO0yNppcdcI=;
        b=nSYyi20vNILz/nMGcFk4lDTN/BvdoQQHpGwXFjZp4XBlDKCNrhK9LZS3FWFVrpZDPt
         qSDozj4C7KXc8SzXhAyLx/EhoxuiAmEYdb62EiqmRX20kXvxo9l+uA9HYRe/tIEQyXYV
         u5pkUSEWaPEiYV5edyPfO7zcmCxNMh9j4UCCT38EclBrlrcg89EM4Y3DKD/fufFirFV4
         Sdjn93P0saUZh/YeCBCVMNXGWOhR702SAiCvCxQRsw2t20Z8nbSUnaQDmfOO7VJT9A2r
         3b1J6Y7K/oYVPtMTvFCbsBFbgCFcW4Cu2kzSM97Q7cWqsC3eXpONcQZH28JfmQC81lKo
         2PhA==
X-Forwarded-Encrypted: i=1; AJvYcCUxX1RUbAh/Z3dCVw+gr4FcYOlyBfIs/Tj/su7CbtcsZuwG1/wysyOubn1YjfjpS3vZHbdSiXQG17WOALk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTZ7lPaBV1v2LZU3jmgrBJX912Kk77BSkJZN0iJvH5YWQhXPFH
	5nF5vFneDAS2rIq0maLVl73BxtyhTkndC0WNj3u11bBDqYZO14W/r4oGWtQlY8zUeU4=
X-Gm-Gg: ASbGnctCPs0qUsW+mfM4vI6PuqpjXwP19iK2l8OtyVZ4tMX8vaNBo8QuUsWcqHy6aIX
	qmvfSZl4KyFo+8wFFX9HLOxYB+T0LUlNTAZMShFOrP1+qgSXPUDJkN30rOw28qCqXL7WkNt/LRc
	/4mFF1Gt5EhS125EZBFqloNmYBqH1iQyvRAys0iGEMcEBGVsGOJGVyzmhjwTFh9CVVKIKSbBaeD
	UnIW/mT/PcmJxgFejvxUQO77Og/nYbohEP4bmIuQyb0OmN+pW9NnmdQda5y8Jaz5j6Q/XcqYxDX
	k8yuHTbVi3Qii8l+AabtJKmSE5lQ+H16K5AMoYdYSQ0gcAEbHGDzzLXwVyKeQQJgAi0ZA9JsRg6
	NAB4SeC3KPtcy2qdBaxOQTp4T2H27rU5mrs34wrGS2z2mUIt9la/XVoqDx4Zcn2G+amJHN+ev1l
	M26ABuA9axwbb4jv1+SrQdCxHRNGfZ0iOSA4wZMG90CWOTpadJWlEcTV9bRGo=
X-Google-Smtp-Source: AGHT+IHZFsGVlyMuhkQhqeFpYMoPl4Dwb/nnotfyu6iecgX64epnniWFG50jvFhERsbJBWQ5IqREpA==
X-Received: by 2002:a05:6102:374e:b0:5db:e885:6b0b with SMTP id ada2fe7eead31-5ddb9b2a4e8mr226365137.2.1762504515920;
        Fri, 07 Nov 2025 00:35:15 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dda1d79fddsm2092913137.8.2025.11.07.00.35.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 00:35:15 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5dbd8bb36fcso455344137.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:35:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWs/0sYdH4sVQdT5zl6wSkSPUaErDSCb07K50iLLWqc2GpUKEEla44o/JMNC6V+G+ddKKSy0twatOH0abU=@vger.kernel.org
X-Received: by 2002:a05:6102:4425:b0:5db:e32d:a3ff with SMTP id
 ada2fe7eead31-5ddb9e056aemr278996137.19.1762504514580; Fri, 07 Nov 2025
 00:35:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1762435376.git.geert+renesas@glider.be> <cfc32f8530d5c0d4a7fb33c482a4bf549f26ec24.1762435376.git.geert+renesas@glider.be>
 <aQy0T2vUINze_6_q@smile.fi.intel.com> <CAMuHMdXVUJq36GvNUQE8FnHsX+=1jG4GOJ_034r=fgr_Rw4Djg@mail.gmail.com>
 <aQzIIqNnTY41giH_@smile.fi.intel.com> <CAMuHMdW8ndAdGnSHopYFMWvw7wk7wKz_7+N91M1jRHoqK1KBrg@mail.gmail.com>
 <c62eb5a727f149fb9d8b4a4c8d77418a@realtek.com>
In-Reply-To: <c62eb5a727f149fb9d8b4a4c8d77418a@realtek.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Nov 2025 09:35:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU3hWDOWXxuOJcBA7tphBT7X-0H+g0-oq0tZdKw+O5W3A@mail.gmail.com>
X-Gm-Features: AWmQ_bkZe8xF0tkRpW5gVlylkcfm2r3jZb2Xa1XdOQVS8F7wx8KXagIs6XSHJvI
Message-ID: <CAMuHMdU3hWDOWXxuOJcBA7tphBT7X-0H+g0-oq0tZdKw+O5W3A@mail.gmail.com>
Subject: Re: [PATCH v6 12/26] bitfield: Add less-checking __FIELD_{GET,PREP}()
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Yury Norov <yury.norov@gmail.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
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
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, 
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "qat-linux@intel.com" <qat-linux@intel.com>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, 
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Ping-Ke,

On Fri, 7 Nov 2025 at 02:16, Ping-Ke Shih <pkshih@realtek.com> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > The extra checking in field_prep() in case the compiler can
> > determine that the mask is a constant already found a possible bug
> > in drivers/net/wireless/realtek/rtw89/core.c:rtw89_roc_end():
> >
> >     rtw89_write32_mask(rtwdev, reg, B_AX_RX_FLTR_CFG_MASK, rtwdev->hal.rx_fltr);
> >
> > drivers/net/wireless/realtek/rtw89/reg.h:
> >
> >     #define B_AX_RX_MPDU_MAX_LEN_MASK GENMASK(21, 16)
> >     #define B_AX_RX_FLTR_CFG_MASK ((u32)~B_AX_RX_MPDU_MAX_LEN_MASK)
> >
> > so it looks like B_AX_RX_FLTR_CFG_MASK is not the proper mask for
> > this operation...
>
> The purpose of the statements is to update values excluding bits of
> B_AX_RX_MPDU_MAX_LEN_MASK. The use of B_AX_RX_FLTR_CFG_MASK is tricky, but
> the operation is correct because bit 0 is set, so __ffs(mask) returns 0 in
> rtw89_write32_mask(). Then, operation looks like
>
>    orig = read(reg);
>    new = (orig & ~mask) | (data & mask);
>    write(new);

Thanks for your quick confirmation!
So the intention really is to clear bits 22-31, and write the rx_fltr
value to bits 0-15?

if the clearing is not needed, it would be better to use
#define B_AX_RX_FLTR_CFG_MASK GENMASK(15, 0)

If the clearing is needed, I still think it would be better to
change B_AX_RX_FLTR_CFG_MASK, and split the clearing off in a separate
operation, to make it more explicit and obvious for the casual reader.

> Since we don't use FIELD_{GET,PREP} macros with B_AX_RX_FLTR_CFG_MASK, how
> can you find the problem? Please guide us. Thanks.

I still have "[PATCH/RFC 17/17] rtw89: Use bitfield helpers"
https://lore.kernel.org/all/f7b81122f7596fa004188bfae68f25a68c2d2392.1637592133.git.geert+renesas@glider.be/
in my local tree, which started flagging the use of a discontiguous
mask with the improved checking in field_prep().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

