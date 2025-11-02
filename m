Return-Path: <linux-kernel+bounces-882095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BE5C299E2
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 00:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B20E4E7192
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 23:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0167D29CE1;
	Sun,  2 Nov 2025 23:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="veGqDOkc"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1E7253957
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 23:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762125307; cv=none; b=Il+0Sv6b9KQzAoZP+1Ahbu4COgu85c/Mu5aJsr/cyFilJLOCpQBJH/EwKHuHrki0PVHJR+5UEg6Cw3TgP66x4zueurnldboLk6L3cUptWjIDqgfj1ElvfHTKZklM1Ta3Y/+kOW6jLxbfPiXkuvW4iEQPR7ZBcSiF2GdEKuS0cGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762125307; c=relaxed/simple;
	bh=gJ+z+fSwzGRoLTASac48Xt/red+jojCgmvvYT9GdSRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMJigBWv4oqASTfDDZKovm/N9vgVrR5j3m4+DpVHppiwfkazzK9wI8vR/E8aaeUvxk8U6eXiSmuVBAW3WtulWy02TZgM3QaLaO8rH+WDrRwFRcrknJ0iGpBS5GXQMHKPNK7xsDGDSVUhvWeX34bisFo8B2NzX1CZlfGMHdKpEEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=veGqDOkc; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37902f130e1so39803771fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 15:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762125301; x=1762730101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhefXJf25nlZX433BsR2ypBCZ8ChrLrkfTMoigu+ucU=;
        b=veGqDOkc2KbhhYjsZ6lnbXmmedGeZoZMglsu3m9z2Ag0Z0bdrOYId3GZuEWhYWx0wI
         QEl0Q9LXRGXaHhR55y8x6ETnqRedFkOF1K1RR49+BaYHgSdEqcTfNCnEhQt7o6Je59Cf
         KVvfDY/Kk/QDbmSmB9l2fTmu3WGrWtGh5AOzwj9esPRfhpfNIkiz3MlTjJg+M+N/ndpa
         geV2axmVI2rxVLB6HmhRYF8WTJ7KIFl1p7BcApKDg8NPbtSvw53jfFdBap4gPtbQ0+Hb
         QYdytI+Gj6ya4I1KUy/71GBHTtwcAGNq9roNc6o/vDW32qf0M8U5G9RKh2EfePP2Cxni
         qfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762125301; x=1762730101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhefXJf25nlZX433BsR2ypBCZ8ChrLrkfTMoigu+ucU=;
        b=YRunp5ot1iBlO9sX2tIYBZShA0x+vWDj1NU5xxX80HS8rNt1dEOuV2SV+lxA7A6EjR
         iRzlre0TQIvEFjC+juW3AdehS5/xuRDEMGKSxhev1LLTtprnX+PNaWBdyfS2hhjcU4d4
         elQPtS775KmNbwBkblAy+5KOG2jY+Rujo24HNMzNG6GiFXR4H91r8d0GKZNH3GhDdylZ
         HFd5g+MWAUXsFrYEvaBzJBSdgwia6U1j8JV1M6wikSCLWu6BjCXr27nNTAufqT4F+aSq
         T+Lm87ONBRSFHvtYXFAyrKH5IO3DSDyFWCno8+PcCggW+1JLkWFeZBVn+IIgByVvlVms
         kkvg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ/lSwuTjYJwTbNpTifV0xb31jD1pLPXNrMYHguHYPU4yopjRmy+MgwTys1DD35ry3ubP+PwQJVRWRlS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmrLuaiJAMsbxrtXQSt8debuYTMlJ23JPm3iyylBLcR2hZxldF
	LkqauRDTKcVBydj7hIyFqQxdEBhyqvNwlYEKcVFniiKTRWORQz//8IzgBtzdpBoGZMjCGPAFquw
	7aHySV/zJr3BZScaqVLvHyF6Caj7l6Yvd8S3GT+VsQA==
X-Gm-Gg: ASbGncvhF4MhtR4kzCGQ3sucUDajTTgA+QqvEywWIg1kKdgVaCypXKTsqhlAtNqaql2
	Aw0FFquUVRzHCIWU+bCbLL06h/GfGQYDquI89TzHfwkCDiP/68ooeLcIHunzuOFRBFvF685tKAb
	u03X/bN/+/I9LKQ/ET5KVyeGiKq3El/ao33lNwMIgGeMO3fUjiqUW3ZuG/xE4qVgaLnY766PzNu
	8bcSnCVWa+caN2kvVkynWEdZzZVnkbzlAtYHsct7eOWFfe6b2kxpH8T6mcQbB6WgnWe5Cc0bFJ8
	vBEl9g==
X-Google-Smtp-Source: AGHT+IHNOSftU4LA4kaZ2zit5fbsUjeer+Cqtnxd6HV9vMAwCSf0ZxvdazFj8kc8iFBA+Oyhy9hRt9pMH+krWfgjY8s=
X-Received: by 2002:a05:6512:1453:20b0:594:2646:2350 with SMTP id
 2adb3069b0e04-594264628f8mr1107502e87.21.1762125301355; Sun, 02 Nov 2025
 15:15:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761588465.git.geert+renesas@glider.be> <03a492c8af84a41e47b33c9a974559805d070d8d.1761588465.git.geert+renesas@glider.be>
 <CACRpkda6ykSZ0k9q4ChBW5NuPZvmjVjH2LPxyp3RB-=fJLBPFg@mail.gmail.com> <CAMuHMdWriu9eUHMSKcv7ojSqbquP3=z2oaquQZLx5nmN0EcGaA@mail.gmail.com>
In-Reply-To: <CAMuHMdWriu9eUHMSKcv7ojSqbquP3=z2oaquQZLx5nmN0EcGaA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 3 Nov 2025 00:14:50 +0100
X-Gm-Features: AWmQ_bkG07aYa3yfLgn8mo--U0KGtThYfcOHYFtKUjSupbZy0y5m0bQWTypUrbs
Message-ID: <CACRpkdbR+5jh+OqYAU4vyUP-aQSjgMG3RRBkUTWnWz=VEy2Oew@mail.gmail.com>
Subject: Re: [PATCH v5 07/23] pinctrl: ma35: #undef field_{get,prep}() before
 local definition
To: Geert Uytterhoeven <geert@linux-m68k.org>
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

On Wed, Oct 29, 2025 at 3:59=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Wed, 29 Oct 2025 at 15:20, Linus Walleij <linus.walleij@linaro.org> wr=
ote:
> > On Mon, Oct 27, 2025 at 7:43=E2=80=AFPM Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> >
> > > Prepare for the advent of globally available common field_get() and
> > > field_prep() macros by undefining the symbols before defining local
> > > variants.  This prevents redefinition warnings from the C preprocesso=
r
> > > when introducing the common macros later.
> > >
> > > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Do you want me to just merge this patch to the pinctrl tree or do
> > you have other plans?
>
> My plan (cfr. cover letter) was to take it myself, as this is a hard
> dependency for 11/23.

OK go ahead:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I see there are other review comments, I trust you will fix them up
and merge the result nicely.

Yours,
Linus Walleij

