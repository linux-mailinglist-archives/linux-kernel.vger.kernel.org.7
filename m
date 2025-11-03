Return-Path: <linux-kernel+bounces-882640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B81C1C2AFA0
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2BA4734444C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853FE2FDC21;
	Mon,  3 Nov 2025 10:17:16 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C5B2FD1B1
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165032; cv=none; b=rFBU8NuHfuGLmpEEZlmao50C59ta89tYTF9exewCdSm9B901q0is64BNy8chAUi7VMqEkt/EXHlQoxAta4G9N3WFmCQyxa1gHEB7pTuq2mBzfRIxMcvozf+x3/27HJu4FegOsXSCC7C5f+Zg2YMz4J9zW9jfmCKnxUXkCf1bMFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165032; c=relaxed/simple;
	bh=mTHQRbPtXcLW9RC24UimP00dT4bpQ240D8TduWco7Ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ku6243TtoAnkR+EoxojCO3ZN7zAY+ksEM7/Vgh5G98tWMa260vrifqfr8/eASOyNJz7JGYHfeWeG2bNxCeXteYlMfaW58co10TwjaBEiBI+fZJmge3O451jkBsz1B5a9VKhlWWx9RBEvJNWjc+u9fh99nNcgfc2nhzllSg68HjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so52392125ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 02:17:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762165028; x=1762769828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WN9rH9/69UaI2zM1r1sL3pcOf4U1LH9TZ13cniByZO0=;
        b=JpIHnP0+GqGPCNyMvtWZtvn/R+xo2TMrmYHBUKpdtmMoFgzHitHBzHLqjf7Mjd7jp6
         QGA1jnSmlL97ixy2DFF0z0DEZKuamHPSFyPGq0KcTSLq6UCAkejYN6CB3jbwEOGlgew1
         Aacqttxs7Dr9LI0BHaOrcX6HgPNzVisZEYAhG7HFvFBPchgBORnghikfFlHlZh38BglE
         doMg8NIGM+1xybjrP/qwCqXkO8qHb7SYkFYgoI7PU/9q/l9aEcAyrBz2DgvKTGDpNqdi
         3znLVoaU62cgxEperUwWLiJAr7imp2/qptqcQm5fG4ZA1xq2wnHVlpM33K8r195mi0sy
         CKSw==
X-Forwarded-Encrypted: i=1; AJvYcCVdGeRUiyCS4Yf2zY3h86G/sJIbS0No/LfaPRFH4bkeCfKizyMQXdrEfzcGyMQRAQOfbXitUtVBjJc0gGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEKMoCRNeTSKH0tx7BgJCfrUhLNx8F/mViJTCHDuCWf4bNcc0G
	5JXt6T51E8I0E2VUSuOgb2fTD01U9bf4inLX6AAHM+20+93QehG6vZ+im/605qtb
X-Gm-Gg: ASbGncuC8Qyvm0lPvJ80KXYzw8Dm5326l+qFJCi+3iDCKOtAbZqwpjchTddRt/UrhqR
	4rR1qKTrmMPr1+ilDjPdJ1QWr3VuwCD+YG02ms8u4X/Kwd1T0PocutxUnpr1DKdR+7LA5k9p7yT
	peRbYzdDTlhDXHo8naxWtrOVt5d8Im9I6G56bRVdgzWJYDq2gRGVvyR91Gfd5c2JeK2YIbwF4pR
	SS6/8uAJULcFps4T49np1W6oy+OJlI6CcgVVENoPV7NjH7WG/ewuUP28GME+T/tgcASDptuEtJM
	JtmGokVjHA/gKqkFfKYQyp8ARZKmjTqqNRr7Rm6h6ZFhZXGyKkXNwxMvLS2wpO6BbcD+Bh88kb9
	QYrcTYJ4QuvXAH8nuTB6t0Sd6ZRYEzsjspHtqp8AiGK0gCvkkOAupXD1IPLzycg6APPdq0dCo9k
	+WymE0fvCdl5EivemNzlVPbaGTupxPI7Jt6Pem1UOIJSiizJPkXJkZ77K3
X-Google-Smtp-Source: AGHT+IGd9KVxjKoWxRuUv5wy/LzCACp+gnjPCdJ8h64kb4LLbvxCNvo/jSpr+UdGgwC3x0GMEBIWiQ==
X-Received: by 2002:a17:903:94e:b0:28b:4ca5:d522 with SMTP id d9443c01a7336-2951a496d09mr174202875ad.39.1762165027668;
        Mon, 03 Nov 2025 02:17:07 -0800 (PST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com. [209.85.210.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268ca9fdsm114820335ad.42.2025.11.03.02.17.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 02:17:07 -0800 (PST)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7aab7623f42so1058541b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 02:17:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUu+LWK4Z1T7lhB3om4+k4SE+TGKcxd7EmAi99YAV8Jo7zTtxf4LGuNxQ4lGAiFyZGnNC1JmWLE/F3pyGE=@vger.kernel.org
X-Received: by 2002:a05:6102:418d:b0:5db:f031:84ce with SMTP id
 ada2fe7eead31-5dbf031902dmr85155137.29.1762164587067; Mon, 03 Nov 2025
 02:09:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761588465.git.geert+renesas@glider.be> <97549838f28a1bb7861cfb42ee687f832942b13a.1761588465.git.geert+renesas@glider.be>
 <20251102104326.0f1db96a@jic23-huawei>
In-Reply-To: <20251102104326.0f1db96a@jic23-huawei>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 3 Nov 2025 11:09:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUkm2hxSW1yeKn8kZkSrosr8V-QTrHKSMkY2CPJ8UH_BQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmxzzzgoIljXMDy5wJmHF15bg4ZKICGjY8c2_gWom3ME9XAPzMw0ghLXn4
Message-ID: <CAMuHMdUkm2hxSW1yeKn8kZkSrosr8V-QTrHKSMkY2CPJ8UH_BQ@mail.gmail.com>
Subject: Re: [PATCH -next v5 10/23] iio: imu: smi330: #undef
 field_{get,prep}() before definition
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
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

Hi Jonathan,

On Sun, 2 Nov 2025 at 11:43, Jonathan Cameron <jic23@kernel.org> wrote:
> On Mon, 27 Oct 2025 19:41:44 +0100
> Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>
> > Prepare for the advent of globally available common field_get() and
> > field_prep() macros by undefining the symbols before defining local
> > variants.  This prevents redefinition warnings from the C preprocessor
> > when introducing the common macros later.
> >
> > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> So this is going to make a mess of merging your series given this is
> queued up for next merge window.
>
> I can pick this one up perhaps and we loop back to the replacement of
> these in a future patch?  Or perhaps go instead with a rename
> of these two which is probably nicer in the intermediate state than
> undefs.

Renaming would mean a lot of churn.
Just picking up the #undef patch should be simple and safe? The
removal of the underf and redef can be done in the next cycle.
Thanks!

> > --- a/drivers/iio/imu/smi330/smi330_core.c
> > +++ b/drivers/iio/imu/smi330/smi330_core.c
> > @@ -68,7 +68,9 @@
> >  #define SMI330_SOFT_RESET_DELAY 2000
> >
> >  /* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
> > +#undef field_get
> >  #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> > +#undef field_prep
> >  #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
> >
> >  #define SMI330_ACCEL_CHANNEL(_axis) {                                        \

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

