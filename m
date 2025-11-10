Return-Path: <linux-kernel+bounces-892729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1ACC45B14
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E25AD4E80F9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182973002C2;
	Mon, 10 Nov 2025 09:41:59 +0000 (UTC)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BD8268C40
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767718; cv=none; b=pjJlv4kAPiwsZVyfUbHGS0zSwdIbVf6EnNp4EskMBBGbwNy+4XceEDzkiuIa6tfYWvu854n8mxEDgpztkq11EWTrwAGNw8zbLfDNe9X/GYlz+qz/iPlhQxqlYfdMT9UMsmZPBbrIOKJDmUExPrD34WMB+vvf2XSXUNCeKUpK/fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767718; c=relaxed/simple;
	bh=SmCYeZZA+MZ4YAMzw1eRf/lethvMOqxmL8UnzEdKQB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBjaRkWuIRR+uG9vbk5VLxGes5Z7ERvRo+0AfFPJvSArwbiAEwhbd9VT3q2dxziGJGRt8d/trKiUihogMqRTozkO6l596nykB1YKqoyCF34bXnUS5SJ25tQ4DFPb/QLGipXDvmEyQIFWrAHnW8Z7zP0cx2n39VxIRTg2sOJsRiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-559836d04f6so1803530e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:41:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767715; x=1763372515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lsrcVDrEohRhH3DeIYD/Jz8ulaHSwnUzTLywFA/cyng=;
        b=PkYBUzxmKqIym/wt1WouNo6wrg+3P5H2IuCYMY3hfce9AxBHm44PrGeJLRwymcAx62
         NfeGUmGny85Wii/ftgwT1bzlaX1LWnS6QOcvzza+SLiPJ8A423x2bh9LrZornHh/2y5l
         8op+kZ2NI7GaJf2ayxDNWySA8t4nvrbcaLy+MJxuJnW30agJrNsb4TIIvJ5zmY3G7CCH
         zIPZ1yK7yLrx2auS3ZdGNwrAuznHlt/v14gpo4Uqq9B1esIqv5EHJLoYwRiFCX387lm9
         OzaTExiIcDAOlLKdt6qORuJAk08VivLAZnoJUr7ZHCQXAAodQrk7qgeb5qO3RS9xGuPG
         4ILw==
X-Forwarded-Encrypted: i=1; AJvYcCVIOrpSNiy3RuFf2Sl5BrfGj8nwYd1tYGkXXGkXKz/kmQ67G42JozryAQYx40lRsPJWYoxN+PIeMKdfiOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl0tpZ5ezuyWLMUBohvmmGCE1Gc7YsNfAvJp14DskN220b6gsG
	Kw7fcWElAwTB40491j5O5HhNqqflseKKamGsW1ggrSxg9n8EpHertzJ7gZxBSGjg
X-Gm-Gg: ASbGnctJNeHZELsxhw0+x+9sMGrGSsQV7lWOpo9wXhug2AJh0nnUc9PZBBbm7FrSoom
	zMVW3P7koO8ojaRCLgD8oGQzunxoW7yQVeV0rYfHEV40Mg5QOpoyMEFxceyGTDoEKq1cEdWDjTh
	Lz47yiIAgmsma8cqVZ7E6K1v2HEjHfB2MUWNiUPZGjcAuQ01E29yO16VtWyPqdVM1fIgVVccTec
	aSNuIBd0IxBkRnGcRCIh8szVwTmZRUjaFytE9mnuEf7OadV6XWs2mLyTCptmGSBAVvuuQzswt2j
	tMTZ1nDJqPa1E1IxMg9uGxC4KxG8h/13rQ3xfmR4x+KZ7kKmr8x2FTlR0LlKDQW4m7e/J+6WX3t
	R/HB6VRoR2pW1pw/6yMGQG7WFqkuP5cBLxOMw8S2f6FJx19guuMV8zD03ZsL9fkV8RHr8VjIZkA
	IZb2raIXf0VF9c8V260XI2GXjdwId1LlxBo4mFnBYnJDz9MMhsQXCK
X-Google-Smtp-Source: AGHT+IGCAY/5Iyet70Do4E5FXsB/67MD3oqEBO9UtykLNoM0DoyH+XIfwWYpNAXMm9OQJHXpVyMYcQ==
X-Received: by 2002:a05:6122:4b18:b0:559:60b8:fa81 with SMTP id 71dfb90a1353d-559b321b450mr2798665e0c.4.1762767715426;
        Mon, 10 Nov 2025 01:41:55 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-559958286c8sm6933729e0c.17.2025.11.10.01.41.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 01:41:55 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5ce093debf6so1964672137.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:41:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZDvWOX5lrdMowSdzeoN1XJoGknSMeMIjvEMgdV1CgPE9xaNVWver1BABFWDRZnsqAoorbATgeSOl2tKk=@vger.kernel.org
X-Received: by 2002:a05:6102:162a:b0:5dd:8a20:d6eb with SMTP id
 ada2fe7eead31-5ddc47517c6mr2576190137.25.1762767247552; Mon, 10 Nov 2025
 01:34:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1762435376.git.geert+renesas@glider.be> <cfc32f8530d5c0d4a7fb33c482a4bf549f26ec24.1762435376.git.geert+renesas@glider.be>
 <aQy0T2vUINze_6_q@smile.fi.intel.com> <CAMuHMdXVUJq36GvNUQE8FnHsX+=1jG4GOJ_034r=fgr_Rw4Djg@mail.gmail.com>
 <aQzIIqNnTY41giH_@smile.fi.intel.com> <CAMuHMdW8ndAdGnSHopYFMWvw7wk7wKz_7+N91M1jRHoqK1KBrg@mail.gmail.com>
 <c62eb5a727f149fb9d8b4a4c8d77418a@realtek.com> <CAHp75VeMqvywS20603yDSo-C3KCu+i+8vvDNuz3h9e8Ma9BOCw@mail.gmail.com>
In-Reply-To: <CAHp75VeMqvywS20603yDSo-C3KCu+i+8vvDNuz3h9e8Ma9BOCw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2025 10:33:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVUdey27RTX8mLsB5wsTfuW_mP_hF503AaF2QyS4awDcw@mail.gmail.com>
X-Gm-Features: AWmQ_bkW2UuenDn6w7Wole8ay3msAtk8Ugj-awLiClF7uVATEqk1c30upT0lUKU
Message-ID: <CAMuHMdVUdey27RTX8mLsB5wsTfuW_mP_hF503AaF2QyS4awDcw@mail.gmail.com>
Subject: Re: [PATCH v6 12/26] bitfield: Add less-checking __FIELD_{GET,PREP}()
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Yury Norov <yury.norov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
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
Content-Transfer-Encoding: quoted-printable

Hi Ady,

On Fri, 7 Nov 2025 at 09:00, Andy Shevchenko <andy.shevchenko@gmail.com> wr=
ote:
> On Fri, Nov 7, 2025 at 3:16=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> =
wrote:
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Thu, 6 Nov 2025 at 17:09, Andy Shevchenko
> > > <andriy.shevchenko@intel.com> wrote:
> > > > On Thu, Nov 06, 2025 at 03:49:03PM +0100, Geert Uytterhoeven wrote:
> > > > > On Thu, 6 Nov 2025 at 15:44, Andy Shevchenko
> > > > > <andriy.shevchenko@intel.com> wrote:
> > > > > > On Thu, Nov 06, 2025 at 02:34:00PM +0100, Geert Uytterhoeven wr=
ote:
> > > > > > > The BUILD_BUG_ON_MSG() check against "~0ull" works only with =
"unsigned
> > > > > > > (long) long" _mask types.  For constant masks, that condition=
 is usually
> > > > > > > met, as GENMASK() yields an UL value.  The few places where t=
he
> > > > > > > constant mask is stored in an intermediate variable were fixe=
d by
> > > > > > > changing the variable type to u64 (see e.g. [1] and [2]).
> > > > > > >
> > > > > > > However, for non-constant masks, smaller unsigned types shoul=
d be valid,
> > > > > > > too, but currently lead to "result of comparison of constant
> > > > > > > 18446744073709551615 with expression of type ... is always
> > > > > > > false"-warnings with clang and W=3D1.
> > > > > > >
> > > > > > > Hence refactor the __BF_FIELD_CHECK() helper, and factor out
> > > > > > > __FIELD_{GET,PREP}().  The later lack the single problematic =
check, but
> > > > > > > are otherwise identical to FIELD_{GET,PREP}(), and are intend=
ed to be
> > > > > > > used in the fully non-const variants later.
> > >
> > > > > > > +     BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >      =
         \
> > > > > > > +                      __bf_cast_unsigned(reg, ~0ull),       =
         \
> > > > > > > +                      pfx "type of reg too small for mask")
> > > > > >
> > > > > > Perhaps we may convert this (and others?) to static_assert():s =
at some point?
> > > > >
> > > > > Nick tried that before, without success:
> > > > > https://lore.kernel.org/all/CAKwvOdm_prtk1UQNJQGidZm44Lk582S3p=3D=
of0y46+rVjnSgXJg@mail.gmail.com
> > > >
> > > > Ah, this is unfortunate.
> > >
> > > Of course, it might be an actual bug in the i915 driver...
> > >
> > > The extra checking in field_prep() in case the compiler can
> > > determine that the mask is a constant already found a possible bug
> > > in drivers/net/wireless/realtek/rtw89/core.c:rtw89_roc_end():
> > >
> > >     rtw89_write32_mask(rtwdev, reg, B_AX_RX_FLTR_CFG_MASK, rtwdev->ha=
l.rx_fltr);
> > >
> > > drivers/net/wireless/realtek/rtw89/reg.h:
> > >
> > >     #define B_AX_RX_MPDU_MAX_LEN_MASK GENMASK(21, 16)
> > >     #define B_AX_RX_FLTR_CFG_MASK ((u32)~B_AX_RX_MPDU_MAX_LEN_MASK)
> > >
> > > so it looks like B_AX_RX_FLTR_CFG_MASK is not the proper mask for
> > > this operation...
> >
> > The purpose of the statements is to update values excluding bits of
> > B_AX_RX_MPDU_MAX_LEN_MASK. The use of B_AX_RX_FLTR_CFG_MASK is tricky, =
but
> > the operation is correct because bit 0 is set, so __ffs(mask) returns 0=
 in
> > rtw89_write32_mask(). Then, operation looks like
> >
> >    orig =3D read(reg);
> >    new =3D (orig & ~mask) | (data & mask);
> >    write(new);
> >
> > Since we don't use FIELD_{GET,PREP} macros with B_AX_RX_FLTR_CFG_MASK, =
how
> > can you find the problem? Please guide us. Thanks.
>
> Isn't FIELD_MODIFY() what you want to use?

FIELD_MODIFY() is a rather recent addition.
That is also the reason why I didn't add a non-const field_modify() yet
(I didn't want to risk delaying this series even more ;-)

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

