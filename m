Return-Path: <linux-kernel+bounces-892644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4C7C4586A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF8D3A268C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5581B233723;
	Mon, 10 Nov 2025 09:06:28 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5D62EB859
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762765587; cv=none; b=Pgj/p6SmsCmgd8LPSmEp97BUT51cG7cTHw3eBSgAU2c9NPs7y0p2gIMuGd5RCuEfTFxA/TRsnEJRU/e66JywbtFETlvyzpA8Bc3nZxZtO1Ps3Vows1cATLmO5SM1VUnGqG5tho+RnDGDPSA/Mn+0jko2aus4N2erGZQTVgR14Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762765587; c=relaxed/simple;
	bh=JRmjklDdMnXYPa/YzcCMj4xR0iBgS1Ed7pmHd076aaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/su2xq4lC5XESDVwU5TjrW3j7HN3vXHuz4qMiMJvbC3v2J8P22RHVWMuifhl40qMvG/ibpNQjNuUeoF5HgDQhKfA51gOzirYnzyYEYGe/BaYpISUBTQfLCjpOT8TIpraiEkLgu+BNvih/VXPsFp0yMUeV8ItUqQExaZ6e9D+QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7833765433cso3159514b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:06:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762765585; x=1763370385;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuaR1c68u39/qbD5w07qCJ9IxeheIz5/8CL8hB/l6OE=;
        b=YHIZW16atHkCuhfS0TmODAf1HYaZnhWAMMvF9MlKZqSESxUA7PPjh/wcDhm9ealxg4
         KkLSX+q90vQ8Kp1utThZY7K97pZAvZZBLwMozL9OaloUOlKZ3UN4TXbwxKf1bAmqFknv
         vt/bYeiwwQSPgQxpjH9ZS/dE3/TlRY8RT/uitwl0VDkD+CX8hTPQMh8ESrFKhBGtoCXl
         6KSkDvNu7cnkro01JcnvZOqO7u0M3KcH6NBOTFPfjWoz3uwjmdSsZMvXBpK2NNkH5y6a
         OEqDyXIHUM3Cvw1nI38fG+vYxyZi5WDlVjdtyDnwsKarEi0GiNbN0Ou9Z7Qs2PwtQDWX
         GFbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIx/B/2vJnhU9/TH9JXnIyReyEdO66lb2dGX1tsEUtm3y09x1SddI6BteTxy3NMLAAhkLqFqE75Ww6gsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4YUOhXa8bG/Y0eswFl9Y4nAs7umSwEXqFWZ3gLGTyge5pLmdQ
	mn9Kssfz8jA+CgX+sIHKORHFSWdJM13JopNe26DoVAYeLhsWM1Cj4Kw9FSPKxzcP
X-Gm-Gg: ASbGnctusKVQTEv+fdhWi2CeioakvhbnRpNSddPfpXo97I53bqoQt4igFZegETO+1IN
	64nfQEm7q9D5bIXceaGk0ErwYc9xUWUbJcFLztk6NDJUjem//pXTRo2AsQsip7ecd7ezZRk6K6N
	BaNKzQcETxOiQ2OvpI0L80EqqW44SC5f6uINQ9TTGS3h/flU+gY4If1hmrn38kiePRwnsKwFBd7
	RBTgWbmmoyqKB7nwwe08P03xIhZMjQxDvQTozX54UavChVeUYL7IslwalSZKruJOy+VCXO2prb3
	lYZMCeTZxjdUbziNFfKT1KBjX/sfzqAlF3+F7n2icTeBNGk34z1zXEGAmfy0P3RjWkiDxkupmd5
	J6CxggTOuzKhN3vNewbi4GVy/vlXfhYNkRQjPJkNldw0t8m+oVcNdlA1Vd778B+9Yy4YHUpHZGB
	XpaQMnJ44bvzV1KlGcfVM9RL2CK+PfFo6HzSr+6L3lklWhCw==
X-Google-Smtp-Source: AGHT+IEjjtQiqrGttVSSoRBY5c1aL+DYg9lN9/4EFra2QhrOYwKgbZhpN1Ic3mbPOpOJ2/P/187z8A==
X-Received: by 2002:a05:6a00:124d:b0:7ad:564:bf92 with SMTP id d2e1a72fcca58-7b226f8de8emr9758502b3a.27.1762765585246;
        Mon, 10 Nov 2025 01:06:25 -0800 (PST)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com. [209.85.210.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17b0c4sm11148389b3a.48.2025.11.10.01.06.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 01:06:25 -0800 (PST)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77f67ba775aso3302408b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:06:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXRIdYh9ybHiy7JCCWOWmJeWqktyTZr/GJEMHU6I8os3bIpjOrmMOaHkOHt6EX65Zs/Fx/MM6ML/Zwr7Po=@vger.kernel.org
X-Received: by 2002:a05:6102:950:b0:5db:fb4c:3a89 with SMTP id
 ada2fe7eead31-5ddc471358fmr2304047137.19.1762765185596; Mon, 10 Nov 2025
 00:59:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761588465.git.geert+renesas@glider.be> <97549838f28a1bb7861cfb42ee687f832942b13a.1761588465.git.geert+renesas@glider.be>
 <20251102104326.0f1db96a@jic23-huawei> <CAMuHMdUkm2hxSW1yeKn8kZkSrosr8V-QTrHKSMkY2CPJ8UH_BQ@mail.gmail.com>
 <20251109125956.106c9a1a@jic23-huawei>
In-Reply-To: <20251109125956.106c9a1a@jic23-huawei>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2025 09:59:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX8c1VkBuPDpJ5mpCcRH+zEX4F1bQKFf_V8N9ZZtCYqxA@mail.gmail.com>
X-Gm-Features: AWmQ_bmD7LCstBufqr7pTwqKUhf3WnheTdaFZy-l1C13xKAmQ3xomq2Nqy5MxZo
Message-ID: <CAMuHMdX8c1VkBuPDpJ5mpCcRH+zEX4F1bQKFf_V8N9ZZtCYqxA@mail.gmail.com>
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

On Sun, 9 Nov 2025 at 14:01, Jonathan Cameron <jic23@kernel.org> wrote:
> On Mon, 3 Nov 2025 11:09:36 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Sun, 2 Nov 2025 at 11:43, Jonathan Cameron <jic23@kernel.org> wrote:
> > > On Mon, 27 Oct 2025 19:41:44 +0100
> > > Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > >
> > > > Prepare for the advent of globally available common field_get() and
> > > > field_prep() macros by undefining the symbols before defining local
> > > > variants.  This prevents redefinition warnings from the C preprocessor
> > > > when introducing the common macros later.
> > > >
> > > > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >
> > > So this is going to make a mess of merging your series given this is
> > > queued up for next merge window.
> > >
> > > I can pick this one up perhaps and we loop back to the replacement of
> > > these in a future patch?  Or perhaps go instead with a rename
> > > of these two which is probably nicer in the intermediate state than
> > > undefs.
> >
> > Renaming would mean a lot of churn.
> > Just picking up the #undef patch should be simple and safe? The
> > removal of the underf and redef can be done in the next cycle.
> > Thanks!
>
> Only 1 call of each of these in the driver, so churn is small either way.
>
> To avoid a bisection problem if your tree merges first I need to modify
> this stuff in the original patch or leave it for Linus to deal with as
> a merge conflict resolution which is mess I'd rather do without.

If you add the #undef, there won't be any bisection problem?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

