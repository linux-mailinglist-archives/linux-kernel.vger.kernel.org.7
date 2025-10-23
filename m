Return-Path: <linux-kernel+bounces-866870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F285C00E5B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F4F3A8BBA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB13C30E826;
	Thu, 23 Oct 2025 11:47:12 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1807130CD9E
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761220031; cv=none; b=bF1ujndlKGroRT8TMzVN0+WUqipy45mMJLO2PuKFHCRsclyj1x5MMiMCCfco2eRpbtO+XBowHpfmf+rmWm+pwZWJG2MlcVn4gVfDBytUijMAmo8v4SPlYNm+uhgK4miCZ3KpKWzWA/xnB7VDAWSTqWMegFMPNpaWFaUGHd61Abc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761220031; c=relaxed/simple;
	bh=t2b3ao92xy0ESrIeC6f3Ix11H+BajiEZp3Qjq0JyHMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJTUh8a67uAukCuLY0lshPI4klq2eWtUytGv/2ORaXkECvphfPUBBYtYUNRkxioBieiTv0aX//g+1OLB1gOYhe4sxPAvYd5F7czGekP+8I9ZZiDvQZ1myuH5bXUQUOFBYavVau9hPjBw1Sgzmt4/tGQL0r0hLkqe2QCHe7GgQE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-879b99b7ca8so7786286d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761220029; x=1761824829;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGr3v7S6fzDOU9nQBXt6OSyvvunrcw7Wuu74VRCbNxc=;
        b=ib6atF8nj9fcUsZY3N17pgYj8Pqf8TRZ9F6AIqz7lRrfNSlFWkN6wCmTxvxoVR0qhd
         ZsR/zmHwbYOlWfrmgMaBwmZOa0KWUrWETz8RBig/yWyeAS97x225VTDro8UsTnNPw31g
         GO6XjiJ2ek+XsUdbGctbNrjpVi5ToEPkvvQfP4DDohKgH93hJYnk/DKTBLbUgP+IKIUC
         9+Au3R7IEQKDLFYCE+1SA9KEzPhjUz3KaWOW8CUL+FiDiex2qt5LU3gixIj0XYBrG9EN
         eK23/X2KsdLrfgnd8Cwk1XLWHkNvXmtovsAyc/gsUc2Dllpxlrj3iRjHoSYtnU/gkS3L
         sNqg==
X-Forwarded-Encrypted: i=1; AJvYcCWL3y6nMqlWZb4WQRqmzj5lVgxB7o+mraG+X4ytRsNFDyQeg9T5ekJnh5bVZjjw+7tet4OODUs80lkHRwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3wG92NdUo5Qe7rjzflHYKu/kCcuXmQhLh94AguXQPxt2srd7+
	XtEzbJ4OA/KrOPC+Sy7cGtURXGYVdLZqDPXiNKmmHa5azZxz3xcEgb0+Z8EPsmfp
X-Gm-Gg: ASbGncvwU6ttfBms8PzUaF1GM5yFAW8AnZAbHlXdWgy7U6UNhk2FvqUnKiVd3saOoyC
	g5Bre4wyHlnNQaLBf+nI8D9M2BXTc3nUtoP4AplDLDLHaBZD0aFoTla9mpRnRrKvweFsXrFATKs
	3iXP4Jx3Ts0srKns9PrlvIYrYTQHYYnul3G5hRNpb9vPc04otEVxnIOOaWYYAyGf8H1KJ5E5mhC
	XpQ/CIo0e0gN/5BJWx0mQoYBBkHEx1r4lbNA10keyCVe34RrY8qUHMHImEMvktWsS3FL/5I2Mu4
	RUvqplMmp/kV42FSvONHJmfndHOOttXrqvbQ82Y2rp3JEPKWrjWrkQQ6JlYzbzUAe6BfwrIrzNU
	FzGDm4AzYhsUkguvpKTx2zghFZQFZmC2rXaiQBMZaKzRa2HyOhf944Z5AatxME/2JI8Slfg4dpC
	dEGptideJEoofXr8a9bfAOtLFbphkKO2KnSTmYwl1TdlSC+OTd
X-Google-Smtp-Source: AGHT+IHrU/jy+6uh1k9YTAmJ9hN7Rwyet8Q6RDA+oSVBs9C5/m/+Mi4xiYLYWrBcgx7u83CdE1qnJw==
X-Received: by 2002:a05:6214:5d02:b0:878:37eb:64af with SMTP id 6a1803df08f44-87c207df841mr268959286d6.42.1761220028611;
        Thu, 23 Oct 2025 04:47:08 -0700 (PDT)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com. [209.85.219.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87f9de80f1csm13612976d6.26.2025.10.23.04.47.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 04:47:08 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-87c237eca60so5540906d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:47:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWidLrUetT9DoPJd9bSWro/Yl7awvtAvfsN5wwh85nC277HWPvv0plVetfVba4s8BXUWDHu2IP70kc1p2A=@vger.kernel.org
X-Received: by 2002:a05:6102:c8b:b0:5db:350f:2c6b with SMTP id
 ada2fe7eead31-5db350f2f90mr173817137.38.1761219546544; Thu, 23 Oct 2025
 04:39:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760696560.git.geert+renesas@glider.be> <67c1998f144b3a21399672c8e4d58d3884ae2b3c.1760696560.git.geert+renesas@glider.be>
 <aPKQMdyMO-vrb30X@yury> <CAMuHMdXq7xubX4a6SZWcC1HX+_TsKeQigDVQrWvA=js5bhaUiQ@mail.gmail.com>
 <aPhbhQEWAel4aD9t@yury> <CAMuHMdUOX=ToDU_44fHrqKWUtee1LKpgisfTKOe4R33er9g+DA@mail.gmail.com>
 <aPj9Tu75OFenm7U0@yury>
In-Reply-To: <aPj9Tu75OFenm7U0@yury>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 Oct 2025 13:38:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX0dmJ_bEkKBZkzqXwM9m-Agwr_zMhMDXgdS+LSyoeG5w@mail.gmail.com>
X-Gm-Features: AWmQ_bkfy7WIJP3UTtd6EyoPnmrw_M6kCYJ9kC1xrPr1U7jSNAuuLhNrJ5p1ts4
Message-ID: <CAMuHMdX0dmJ_bEkKBZkzqXwM9m-Agwr_zMhMDXgdS+LSyoeG5w@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] bitfield: Add non-constant field_{prep,get}() helpers
To: Yury Norov <yury.norov@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
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
	Jianping Shen <Jianping.Shen@de.bosch.com>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org, qat-linux@intel.com, 
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-iio@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi Yury,

On Wed, 22 Oct 2025 at 17:50, Yury Norov <yury.norov@gmail.com> wrote:
> On Wed, Oct 22, 2025 at 12:01:37PM +0200, Geert Uytterhoeven wrote:
> > On Wed, 22 Oct 2025 at 06:20, Yury Norov <yury.norov@gmail.com> wrote:
> > > On Mon, Oct 20, 2025 at 03:00:24PM +0200, Geert Uytterhoeven wrote:
> > > > On Fri, 17 Oct 2025 at 20:51, Yury Norov <yury.norov@gmail.com> wrote:
> > > > > On Fri, Oct 17, 2025 at 12:54:10PM +0200, Geert Uytterhoeven wrote:
> > > > > > The existing FIELD_{GET,PREP}() macros are limited to compile-time
> > > > > > constants.  However, it is very common to prepare or extract bitfield
> > > > > > elements where the bitfield mask is not a compile-time constant.
> > > > > >
> > > > > > To avoid this limitation, the AT91 clock driver and several other
> > > > > > drivers already have their own non-const field_{prep,get}() macros.
> > > > > > Make them available for general use by consolidating them in
> > > > > > <linux/bitfield.h>, and improve them slightly:
> > > > > >   1. Avoid evaluating macro parameters more than once,
> > > > > >   2. Replace "ffs() - 1" by "__ffs()",
> > > > > >   3. Support 64-bit use on 32-bit architectures.
> > > > > >
> > > > > > This is deliberately not merged into the existing FIELD_{GET,PREP}()
> > > > > > macros, as people expressed the desire to keep stricter variants for
> > > > > > increased safety, or for performance critical paths.
> > > > > >
> > > > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > > > > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > > Acked-by: Crt Mori <cmo@melexis.com>
> > > > > > ---
> > > > > > v4:
> > > > > >   - Add Acked-by,
> > > > > >   - Rebase on top of commit 7c68005a46108ffa ("crypto: qat - relocate
> > > > > >     power management debugfs helper APIs") in v6.17-rc1,
> > > > > >   - Convert more recently introduced upstream copies:
> > > > > >       - drivers/edac/ie31200_edac.c
> > > > > >       - drivers/iio/dac/ad3530r.c
> > > > >
> > > > > Can you split out the part that actually introduces the new API?
> > > >
> > > > Unfortunately not, as that would cause build warnings/failures due
> > > > to conflicting redefinitions.
> > > > That is a reason why I want to apply this patch ASAP: new copies show
> > > > up all the time.
> > >
> > > In a preparation patch, for each driver:
> > >
> > >  +#ifndef field_prep
> > >  #define field_prep() ...
> > >  +#endif
> > >
> > > Or simply
> > >
> > >  +#undef field_prep
> > >  #define field_prep() ...
> > >
> > > Then add the generic field_prep() in a separate patch. Then you can drop
> > > ifdefery in the drivers.
> > >
> > > Yeah, more patches, but the result is cleaner.
> >
> > And we need 3 kernel releases, as the addition of the macros to
> > the header file now has a hard dependency on adding the #undefs?
> > Unless I still apply all of them to an immutable branch, but then what
> > is the point?
>
> Not sure what do you mean. You can do it in a single series, and you
> don't need and should not split the series across releases. Consider
> my recent cpumask_next_wrap() rework as an example:
>
> https://lore.kernel.org/all/20250128164646.4009-1-yury.norov@gmail.com/
>
> 1. #1-4 switch kernel users to alternative functions;
> 2. #5 deprecates cpumask_next_wrap(), making sure it's a pure renaming,
>    i.e. no-op.
> 3. #6 introduces the new nice implementation. It's the core-only patch,
>    no drivers are touched.
> 4. #7-12 switch the rest of codebase from old version to new.
> 5. #13 drops deprecated old function.
>
> This is the most common scheme. In you case you can cut the corners.
>
> The goals here are:
>
>  - keep core patches free of non-core code;
>  - switch drivers to the new functionality one-by-one in sake of
>    bisectability.

OK, I'll make it so...

> > > > > > --- a/include/linux/bitfield.h
> > > > > > +++ b/include/linux/bitfield.h
> > > > > > @@ -220,4 +220,40 @@ __MAKE_OP(64)
> > > > > >  #undef __MAKE_OP
> > > > > >  #undef ____MAKE_OP
> > > > > >
> > > > > > +/**
> > > > > > + * field_prep() - prepare a bitfield element
> > > > > > + * @mask: shifted mask defining the field's length and position
> > > > > > + * @val:  value to put in the field
> > > > > > + *
> > > > > > + * field_prep() masks and shifts up the value.  The result should be
> > > > > > + * combined with other fields of the bitfield using logical OR.
> > > > > > + * Unlike FIELD_PREP(), @mask is not limited to a compile-time constant.
> > > > > > + */
> > > > > > +#define field_prep(mask, val)                                                \
> > > > > > +     ({                                                              \
> > > > > > +             __auto_type __mask = (mask);                            \
> > > > > > +             typeof(mask) __val = (val);                             \
> > > > > > +             unsigned int __shift = sizeof(mask) <= 4 ?              \
> > > > > > +                                    __ffs(__mask) : __ffs64(__mask); \
> > > > > > +             (__val << __shift) & __mask;    \
> > > > >
> > > > > __ffs(0) is undef. The corresponding comment in
> > > > > include/asm-generic/bitops/__ffs.h explicitly says: "code should check
> > > > > against 0 first".
> > > >
> > > > An all zeroes mask is a bug in the code that calls field_{get,prep}().
> > >
> > > It's a bug in FIELD_GET() - for sure. Because it's enforced in
> > > __BF_FIELD_CHECK(). field_get() doesn't enforce it, doesn't even
> > > mention that in the comment.
> > >
> > > I'm not fully convinced that empty runtime mask should be a bug.
> >
> > Getting (and using) data from nowhere is a bug.

^^^ This is about field_get().

> > Storing data where there is no space to store is also a bug.

^^^ This is about field_prep().

> > I will add a comment.
> >
> > > Consider memcpy(dst, src, 0). This is a no-op, but not a bug as
> > > soon as the pointers are valid. If you _think_ it's a bug - please
> > > enforce it.
> >
> > memcpy() with a fixed size of zero is probably a bug.
> > memcpy() with a variable size is usually used to copy "as much as is
> > needed", so zero is usually not a bug.

^^^ These 3 lines are about memcpy().

> 5 lines above you say: "Getting (and using) data from nowhere is a bug".
> Now you're saying: "so zero is usually not a bug". So, is it a bug or
> not?

> > > > > I think mask = 0 is a sign of error here. Can you add a code catching
> > > > > it at compile time, and maybe at runtime too? Something like:
> > > > >
> > > > >  #define __field_prep(mask, val)
> > > > >  ({
> > > > >         unsigned __shift = sizeof(mask) <= 4 ? __ffs(mask) : __ffs64(mask);
> > > > >         (val << __shift) & mask;
> > > > >  })
> > > > >
> > > > >  #define field_prep(mask, val)
> > > > >  ({
> > > > >         unsigned int __shift;
> > > > >         __auto_type __mask = (mask), __ret = 0;
> > > > >         typeof(mask) __val = (val);
> > > > >
> > > > >         BUILD_BUG_ON_ZERO(const_true(mask == 0));
> > > >
> > > > Futile, as code with a constant mask should use FIELD_PREP() instead.
> > >
> > > It's a weak argument. Sometimes compiler is smart enough to realize
> > > that something is a constant, while people won't. Sometimes code gets
> > > refactored. Sometimes people build complex expressions that should
> > > work both in run-time and compile time cases. Sometimes variables are
> > > compile- or run-time depending on config (nr_cpu_ids is an example).
> > >
> > > The field_prep() must handle const case just as good as capitalized
> > > version does.
> >
> > OK, I will add the (build-time) check.
>
> If mask is compile-time, you can wire field_prep() to FIELD_PREP(), so
> it will do the work for you.

OK, I will look into it.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

