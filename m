Return-Path: <linux-kernel+bounces-857914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED986BE8390
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9700E540812
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3690A32F748;
	Fri, 17 Oct 2025 11:01:29 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E7932ED3F
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698888; cv=none; b=TEs5G97j0mc9yJul1U/OM6qEDK1nAKHD8N9j/NBbGaJ4An1QnVAuKIooDuijDIxZQwrSQqp1VZ9nThqoUbFCup6Vyul2Cp1QhG+abzqu5sj9/USM0NfxjcbLsYtbvcN+NgyrG8sPkMNjcJFI4TZwNTgLUKNOD/vkBiBaUi7OJ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698888; c=relaxed/simple;
	bh=LrniXy6ZCFM530ZMtcnDRQn9pcEmCEynLCDVJ3AMIhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5gHeeu9RUbfwZgs9opmOGw3REXEjxADTjU4lG+3Oc5FaTqsybKmXPa+4/PihdVnvHgtWuvdax3PqYojORAYf/Vkh0Qa8HTi0OZ9OT/8SZE8sOeRA4i0FYS4ZASN3JmWSm4b8Pb5niC3dKVcJWgW75mnKUeOceD55Me4cr1UHh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-890521c116fso164886485a.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760698886; x=1761303686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XCpfZFAx3hiLnczCJXcXTR7Dek411X8RRc+fD4xQf5M=;
        b=CgbKVqD+FQ7cp6fCGzaz+4FTNmab7hLJAPHZ8wOjQmwgQ7DCrMQ3GQ/C+rm2jSiCXj
         hCew524QlYgybv0/PBM2fjVmZ0YpaPiotml3aVG5zBcTPVMs1oiq9iXY7KPBj/jMS8Hr
         Jmnl/s5sZ4WDEwX6CUQLe2fKUIGqx2dmnF1/nt6E1ucpLidgCkkha7CcDm+Y3O3zbs+C
         CZXXmhUh0gMqONT4lio+1NdWNz83PdSlW4EloCA0S97Xmy/vdPtpqEL15OH7yhmq2DSr
         cLlk9TsoPzt23CkvtGwE5EwXn7aTa72T28N1chUG8x3q1RwEmU57V90r5Fra76VblPZY
         Gs9A==
X-Forwarded-Encrypted: i=1; AJvYcCVuh8XgnCABgwecHnVPSNabIPM3ySZrqb75erO7p+SQUZPpXv0K9WfO6Sd22gM4w325RLU2FX2eCr3D8Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvpxPHroSsb5+3tMuv2P/R5PptHQCvkJpBEre2fpHKd/GlDRJI
	CcR0DefNNGMI8IVOp9m6ea4QiLR76OCOBxMHHXpyJ7MiN2HBhK+q5IL3+2c0FWYi
X-Gm-Gg: ASbGncuco4C9hCXvn0HxAlPbLdCwYMP6GUJrtIa6GQbw5XtwV43QzvcSzIpWbBh/AAa
	DLslA5auKzKGXsVihSvZZvDGwFOaKO/knXOM9UlNuc5GB4RgfpPYp8vgbCzYUgeGZSo8aduw1VB
	onBqzZNq8dYjzXaiDm1+eju0He0po5bDAuBTIR9CANMhGHb+5tvQbdzy6oTIa1RKQOfsQ0YJc0L
	vm3c5Z9CdrExNj8pnmKYLpzQMTe9bMm27EniCVBtQoP7cmriHTenuFBy7Z4o0779cu9yQofYf0B
	xFY4T+jxQhzUjm+Jv8nQOWsemz56p1S2RNIw+/j1CrDby9iTw3bsbSldwlOHk90sOtHTlutCpcr
	DVfQlEDlGM187tNJG4cPDdU2/kp49gwQWcyDmegsCh2R5ltUnTFPFkAuT7dzDlhOmolez8WMA6K
	taQd4EdBhgaSdJreWlwwsnWQNIViUEa1AyNUjq/A==
X-Google-Smtp-Source: AGHT+IF2n1AbMHwn/ujqwMrPyd2iVkMgDbLppks4f3wCQJy4OP+e1nMaCj79TGcJ2ukVRAroKqKRVQ==
X-Received: by 2002:a05:620a:4804:b0:808:bbc:df09 with SMTP id af79cd13be357-8907030cdaamr446430785a.56.1760698885741;
        Fri, 17 Oct 2025 04:01:25 -0700 (PDT)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com. [209.85.219.53])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-88f38bf2ecasm407238785a.62.2025.10.17.04.01.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 04:01:25 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-87c148fb575so28360066d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:01:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0bNpGLnOE2jXbjdQKovZFpMYLJ+1EYUrR4IyBUkptbNmLnLBOQR27xEuQfxqrir++K2QI8NC/kbvsZVs=@vger.kernel.org
X-Received: by 2002:a05:6102:c49:b0:5a1:f09f:524e with SMTP id
 ada2fe7eead31-5d7dd59bcd6mr1313646137.16.1760698511065; Fri, 17 Oct 2025
 03:55:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739540679.git.geert+renesas@glider.be> <2d30e5ffe70ce35f952b7d497d2959391fbf0580.1739540679.git.geert+renesas@glider.be>
 <20250214073402.0129e259@kernel.org>
In-Reply-To: <20250214073402.0129e259@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Oct 2025 12:55:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU+0HGG22FbO3wNmXtbUm9RhTopYrGghF6UrkFu-iww2A@mail.gmail.com>
X-Gm-Features: AS18NWCjFk9wo7Q1aPnnkBYJzaq6xcQVQAXawyeid30N8a2RlJlAbXrKkziomTs
Message-ID: <CAMuHMdU+0HGG22FbO3wNmXtbUm9RhTopYrGghF6UrkFu-iww2A@mail.gmail.com>
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

On Fri, 14 Feb 2025 at 16:34, Jakub Kicinski <kuba@kernel.org> wrote:
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
> I really really think that people should just use the static inline
> helpers if the field is not constant. And we should do something like
> below so that people can actually find them.
>
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 63928f173223..e02afcd7aeee 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -156,6 +156,80 @@
>                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
>         })
>
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
> +}

Unfortunately gcc emits actual divisions or __*div*() calls, and
multiplications in the non-constant case.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

