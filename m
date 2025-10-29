Return-Path: <linux-kernel+bounces-876361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2602CC1B4CC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C2A71AA14A7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D33D2C3277;
	Wed, 29 Oct 2025 14:30:44 +0000 (UTC)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FA62BE7B8
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748244; cv=none; b=NHFXuwl1SXeEkP/4wZhCk/9ewexyGIC4uykBYL1YbmSEPlSFXeGc81eg0+hE+YLNI3+QejAumgldWGOKfHlnRu1zLTtpgN9Taho6BbtXrnufnw8wJeUWnEIqYAmZbEyzgQXgEv5KcziPDR9bAqFux/W5EguQVbSX2kPMS1sJhIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748244; c=relaxed/simple;
	bh=RiCdWEkCDNsJiKATmU0RbHd3Kb5B/0yb//UgjVnVdPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZaZv61N+zUuK6gmEwlZ/6PYtmnygOI1RgfW72LNLD/4D97l+jY/VE7a2myyztb5lGRkyVllFEliPzqgg7jL0iwx1pYv1NBmwGHqIdLpaaqVCRwRgkGOHOd1/3uYRF3s+Bo/Q/IdiqVm5Ke9uB/uLdjJ+CFosEdkIHPjpT+DwqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5db469a92f7so2056258137.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761748241; x=1762353041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmTxX9Lp/E6iQMSfd9sSFodFiE1yd68ZDUJdx86zE5s=;
        b=YxmtlKGcE/p2O38FEyWclBcy2LZ0IWTw8BZFUHdOohPb7c+x5nx/viiAir+yGBXbIr
         RZVL1cjq5KeCieDBwbYN5z2VOCFD0y84H22teJamKt/FtH0O7ONksRDjtLbadFTZ7tHA
         Nu8kZqw1qyPvqlchzYD93W+2L6JVzX2DLQZy+l1OXSbwPhdSpQNGrbYPPEizEHLdFRvm
         /8QUOYdA/wO8xM4kmAbNwtS78W6Opltda6uxkUUOcPTH3c9GPDi5kCDDkTfzQphvhMdP
         +a0Fydy3D+ucJF+JhpNgec3t4Y+TwcrqG+uI83pBs2sW9vyDfiH8nJifu53OQTV4hPAm
         n4HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsON/xCjfKZOnt1yw6zdnna2wjhdAwvO0l4ptCsDemCvQNHdMNKH37UbcgKlraEkw8WNy6IJqZmXNRCz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWtJa0T7GIm8vSsNryprRC4SxlzzoqLuw7XBZdrpC3NgD6Upli
	bbfSro0UMxCpX3toOI5d5l/z2eLAceLQUVyf16s+pVQ+/2lDCTVDSpoeUrMOgBXU
X-Gm-Gg: ASbGncs3Lx7MGvdDLNhx1gTLGXc/FmeCnh0i/7DHXnMPELXtHt0VuaBd6n93Z2BUiee
	G28gEQO+1qQz3zU3OGjuqQSbbDjF2Idr3scGlqZf5TNTS71YNzy9MPFxJ74Dhj293uTIDSqQ4d+
	uAujB8juAVEeWWtxAnZTTB4nFHP+tCyHTlZSlpLXoA3BxJss4HWGM3yyBw87R6d8cIb2B+kfc43
	qDuSaldvThpC5j0xnPy9RwVPJa9dnX3VCsy7TitgkLQuBHyeQaYLHBLy/Zd7Hvy4Kt3tRYFAqdv
	kDm9C/b6sXmbkJrISXR+TJjRleWAYfavsLrXiDNOnnpviAsAAKX51gXPJBtOSb3woGRxgLOOpVG
	rsChIZtjn5e+Wd34vwyeGPGqA9FwWwd7425BIocuE6K038KqNc6b2w8hqOdwn/xj/nHYjlZtLHI
	hHNWs65+w7iP+1DuErsBtIWjMFXtcl+TeV5uSTNmoAqojsTQ==
X-Google-Smtp-Source: AGHT+IFRt7EdWir2H7fpHT9ci3K+vyz2cdoR6ndGGb+LRISmqhZOKWowk5h2dEuE9HJx+ynIjZk2GA==
X-Received: by 2002:a05:6102:1488:b0:5db:28a5:2b0c with SMTP id ada2fe7eead31-5db9065362emr1066549137.28.1761748240913;
        Wed, 29 Oct 2025 07:30:40 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557ddac18dbsm5503388e0c.2.2025.10.29.07.30.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 07:30:39 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-55716c1ffeeso2078108e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:30:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWFN3Nr/ghZrGdD4n0u4FCK8agaoLoYHtU09tIVkpNdQe9O1l+OIZaJIzRlYzWqcTJhaVhb7OFrz3YT6uw=@vger.kernel.org
X-Received: by 2002:a05:6102:3e95:b0:5db:38a1:213b with SMTP id
 ada2fe7eead31-5db90656011mr932905137.27.1761748238614; Wed, 29 Oct 2025
 07:30:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761588465.git.geert+renesas@glider.be> <03a492c8af84a41e47b33c9a974559805d070d8d.1761588465.git.geert+renesas@glider.be>
 <CACRpkda6ykSZ0k9q4ChBW5NuPZvmjVjH2LPxyp3RB-=fJLBPFg@mail.gmail.com>
In-Reply-To: <CACRpkda6ykSZ0k9q4ChBW5NuPZvmjVjH2LPxyp3RB-=fJLBPFg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Oct 2025 15:30:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWriu9eUHMSKcv7ojSqbquP3=z2oaquQZLx5nmN0EcGaA@mail.gmail.com>
X-Gm-Features: AWmQ_blleyKJMjc4oETFxToQhJJ0bdzSdD1fdMmRWAHt71coVgn8wIHcAFgDdM8
Message-ID: <CAMuHMdWriu9eUHMSKcv7ojSqbquP3=z2oaquQZLx5nmN0EcGaA@mail.gmail.com>
Subject: Re: [PATCH v5 07/23] pinctrl: ma35: #undef field_{get,prep}() before
 local definition
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

On Wed, 29 Oct 2025 at 15:20, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
> On Mon, Oct 27, 2025 at 7:43=E2=80=AFPM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>
> > Prepare for the advent of globally available common field_get() and
> > field_prep() macros by undefining the symbols before defining local
> > variants.  This prevents redefinition warnings from the C preprocessor
> > when introducing the common macros later.
> >
> > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Do you want me to just merge this patch to the pinctrl tree or do
> you have other plans?

My plan (cfr. cover letter) was to take it myself, as this is a hard
dependency for 11/23.
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

