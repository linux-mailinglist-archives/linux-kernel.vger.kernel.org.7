Return-Path: <linux-kernel+bounces-876421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA1DC1B735
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7FD1A27A65
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EB333C520;
	Wed, 29 Oct 2025 14:41:54 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4BC33A026
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748913; cv=none; b=lOCAKqj25MQKXYVqjNZRm+ySYyXQQLTxP0zGJyZMa+pdbsJ+AiuWihBh6u1GCSej+hxHjHWhGRsutmymA18C61dqZDkeLabtOdo7ooN9XErlqJDGVavOmDXVAVEz8Kaa9Dy3ac5rYzzKwa3fEesAPcXZqLpdP+K6ZjToORv7PbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748913; c=relaxed/simple;
	bh=FbqavNtq8VJC+dwAXLJIaCG9l+pt4WVO7NOuPi3OYaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sksYP0KIEqmCap/QPLcrAocaXsy+gHU7Kfz8cfA4AYE9U9rhLWboaQ/MSvmDx1PjBPhkKBO4PlMC2lagNG5oms2RpxAUWdRjfoYKPgQMtNc2NoDaPX1Nq3xgncR9F3OvWR+HCx0zOSsY339cjL5/KniX9/5j2ZM8xuV5D8q+Xtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4e89ac45e61so69174061cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761748911; x=1762353711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNDkhDDabcFgtYSzLRibzijDMaquJ035sDb5A+sIiAE=;
        b=nVWJbRZEh/eHfufIOOKzNoXlDCzM6JMV/RtA6yWphmE0qzUL/6OORGYwRDLmM5y5YY
         l8Yspf/mUGQuFhMgOAYOYBbcejsxSECKi/osLLA798Ac43Nm2lN0HfHAbrG2k1b4fh+H
         yW1Z8jjUKFSxgEmLOeWkq6WSq8ygmJt0f/MYNVDYmeJ+E+YkKqYDBFBe1eqmJAZFrK6d
         x9TKdh3i4ezDnCzcH60bxhNwZecjeB8f+EBuf3YMr/CgdbvnPwKG3BNa07XZ2S6D4fdo
         pgDl0cCqTMFXX/UrEI3Mp58pLbFiTEUSGFZiELnhXARdUju3r9sRgsZ+0Kd4Dx+dCdHo
         5a5g==
X-Forwarded-Encrypted: i=1; AJvYcCV5YtcrAkWWRuemBNWJBzBmOWDKsiy503Vj1u34bu9ZROjQtW1TFUi0UsMkshGMbNui9eDEUNwXX9NH36U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww0K8aQVsnIaBPPSqNHVOwiqq0o+eKgYiZ/f/fHHpgin7wJ4yh
	wCyv7A2TupN9SAi5dbIpgcOZhx9Pm0BuOGMw8wsCRiwqeMHabZepYWNb7jwYJwrU
X-Gm-Gg: ASbGncsguu/xLLHeOXR9cocpb+7kNLAc/FtmYLIXj6m4EGiVAV+JgaN5VimNLBClxzA
	Vmgd3L9SO9QZ1Adr+gJlVGxb4vx2PEYib0GpNfvpnjYXeRY9CxTsz3ay+Ul/GVKHPhWgVIZMoNC
	IHyUIaV9S6j/vltIbCV7P3gApuDAyKRgOk1dNcDW4yIPPjVAXl2vwOKeklUFy122ANYmwx4RHi3
	gVnpyr3tIy6ZywWTS/G00AO7/7Zr8Pu67IT5Bx1pjsvczvmAoylvfQYvSk3RHT8cdQEQsw8q4dX
	Fmgpg4XXyzUaBjMXBC52fRIxKaawuexMPfWDa3G5LXDwgv07NDzgN2Rwk3LPGwabmDWZloypgMM
	XbDhJOgiB9ShmM8nziNlc0D5nB90oA1YCF+RNgTsz5UUSzXN1w/tq1mDEhBcKeChhTHX0ZtDEDh
	Bt6gEvIwkMfnpN8NQOLqtk0iYATSAVvvEkUlUhs6aHhbO2qw==
X-Google-Smtp-Source: AGHT+IG8zFFoPvLaGlH+zY9P63mQtrbGw/FHe7mn/hVhmPEACVDBL0cf0exVSlpJUNv9vMiUx2G3CA==
X-Received: by 2002:a05:622a:4c8f:b0:4e8:a359:b798 with SMTP id d75a77b69052e-4ed15c3587amr49384401cf.67.1761748911124;
        Wed, 29 Oct 2025 07:41:51 -0700 (PDT)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba37b441fsm93388071cf.2.2025.10.29.07.41.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 07:41:50 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-89ec7919c71so547559085a.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:41:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXnacdnEz+7rxzCnPwrhd4Tri2JGaRIIhCKsGce6SG9D+frlsMkF3IUDbIZrWGiL6vRQA6/0zFluMbl95s=@vger.kernel.org
X-Received: by 2002:a05:6102:26d3:b0:5d6:156f:fedb with SMTP id
 ada2fe7eead31-5db90694687mr933346137.36.1761748440676; Wed, 29 Oct 2025
 07:34:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761588465.git.geert+renesas@glider.be> <03a492c8af84a41e47b33c9a974559805d070d8d.1761588465.git.geert+renesas@glider.be>
 <CACRpkda6ykSZ0k9q4ChBW5NuPZvmjVjH2LPxyp3RB-=fJLBPFg@mail.gmail.com> <aQIlB8KLhVuSqQvt@yury>
In-Reply-To: <aQIlB8KLhVuSqQvt@yury>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Oct 2025 15:33:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUTR2VnQ++j_ccUN3-GzKmSzS3H3QNyYqZNacfOBXD50Q@mail.gmail.com>
X-Gm-Features: AWmQ_blqiXGJheNiHtKi_cJSwq0gfFP8sAonrx_tsjN_f5pUMr0aiWqvAOsiPck
Message-ID: <CAMuHMdUTR2VnQ++j_ccUN3-GzKmSzS3H3QNyYqZNacfOBXD50Q@mail.gmail.com>
Subject: Re: [PATCH v5 07/23] pinctrl: ma35: #undef field_{get,prep}() before
 local definition
To: Yury Norov <yury.norov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
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
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yury,

On Wed, 29 Oct 2025 at 15:30, Yury Norov <yury.norov@gmail.com> wrote:
> On Wed, Oct 29, 2025 at 03:19:45PM +0100, Linus Walleij wrote:
> > On Mon, Oct 27, 2025 at 7:43=E2=80=AFPM Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
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
> There's a couple nits from Andy, and also a clang W=3D1 warning to
> address. So I think, v6 is needed.

Indeed....

> But overlall, the series is OK, and I'd like to take it in bitmaps
> branch as it's more related to bits rather than a particular
> subsystem.

OK, fine for me (if I can still get an immutable branch ;-)

Note that as of today there are two more to fix in next:
commit d21b4338159ff7d7 ("mtd: rawnand: sunxi: introduce ecc_mode_mask
in sunxi_nfc_caps") in next-20251029
commit 6fc2619af1eb6f59 ("mtd: rawnand: sunxi: rework pattern found
registers") in next-20251029

Thanks!

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

