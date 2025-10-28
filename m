Return-Path: <linux-kernel+bounces-873950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A54C15282
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044B3460D9F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F7C3370FF;
	Tue, 28 Oct 2025 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="uIBa1ecY"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BA9335BA6
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761661230; cv=none; b=L+IuLbqmUvFxHq1tPzuh2+OsfAxsdfFvU30TJDEVcYq3WmhnPINBIck6mVt8K17rzZ7kPCVIHpGsgmj7+cDg/Qk7Wd+Ua/mKZMYQZjVTxGYVh5KRZYXeVrfds5/3D9FghydsfeSAuPg/q/8l3sGaP4neui/tbIlL3iSUl+YY4ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761661230; c=relaxed/simple;
	bh=pP8FTV47DQsaScTl4AKuec/C6HsHLvvn5JrdlNFvXF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rok61aCXaTHwrXqFgUUh54SFSYLVVehKQpK2kZY+Sk1/kyt2McVHvjVwoWnb/wXvNKXAGZ8pr63fKEv9tWUWtTJfYUuMyTJtWO1QODjvlfchnNK3cr8v9oCLtmNrSl+6LQ/DWpJr8G1bCCBv6TOfQz9tcJgUrTJ3+0Dyk9UL3k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=uIBa1ecY; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-376466f1280so90823211fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761661227; x=1762266027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOmSiTMyA8cqAorOzkSzQ5xujNoDEMVqXsbHnkkNM1c=;
        b=uIBa1ecYcS0SjQasgAEKQr/pVNdcH2s+vv+Ivq8X+TvJlZm3PK4XkoOKj+ySjsss6V
         0g8VjUJ/7QVvEAWpyHMqMetwZu3/zoN1N9yyXtB0KFxrE/rVPaA1Wla9t4UuOGIAw/wn
         tLvnxdxSdn4y9ZLZkoqvs3/uknC8cTF+ohyHp0eXubW+fJwQrXlNVOsgxyt8mMbBy66D
         1uC4SKbYh7kSu4m2DIPdoiKVO+xnGkWcrG1i+y3Uwm1SYSS1wzr0PjgOSFofFE0v8Jnx
         uh6w6swnMKwZGoMtYXUS13Dhkpdcfv4aAkZJJYWpnhecHmYQWvg4zllIFHM+xQPboquJ
         uIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761661227; x=1762266027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOmSiTMyA8cqAorOzkSzQ5xujNoDEMVqXsbHnkkNM1c=;
        b=aBrcWG41+KAoCY7irB/ov7k8ZtRqXGwaYcSia+Am+fOcK92TnuI6RO9TVUaM9Z1sEl
         uiNtWbqlqi5dceG/mxK/4eyR4frFI48qtfqecvn7EO2DqsHoVhvBaa0cg0sWR7cn7GOm
         1o+5dJZJ+XvNtG7sovfcqlRdptDDVonplQ3Z791ifaX27A8GKuL+3JeAulRvXb7tNbz4
         ivn4tkzBuKJuh3J56HdAvZZ+E+GlWXwNmftjKlEdUTBUDd+jJ7qGjobeo4CkWkEoKca/
         FwCyeRI8oXfegofs2wzKOkP84fpBvrCbHSMbhs673iTCgTgGP4YoLzdyys1xbQsIQ1Fm
         mrdg==
X-Forwarded-Encrypted: i=1; AJvYcCXo9M7ukzGvhc1H1d5Ya1pTT5Y/IeAvXSisL3voAU5XYVkBGIwKppjwNHysMRkuZTJVU1SWEXrIh+D9XQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/9Byd3pV0IDl3hiV+giWGlFPpD+F7mStqFdAP3A9RdOevSWWp
	+sDAJlkttuvm7Cz/DMYoHxXYYorcDUM3CxZfTKvzDT4q0a3qHGGWPs22DvlkAgJ5+NguO3v8xXn
	WRvBk6b0iy1EhOMqADDG2u8X2nFdUjo4KLUt3KFyqTA==
X-Gm-Gg: ASbGncsPMVOIIWlzaWzTYpy/mte5LuKBf75xpC3cCwmEqxLdoEY5e0EM6yZYLGymZVh
	7EKFujsjS1BVgwUr0f3Gwpaclnf/U6oXSIpf2hnZnITqVyfLwRGzw40G/oPuJdwHdL9IWukIUGj
	X5+i1C3r61W755cIcVgk8OFB9uyG1LcvaYsDaqTa43MdAhgtbyFRLpZRUNvDqvWD9bfMIgcFS9c
	BQOdhBy7G2G+U/PVPkGU0XBIigitKNxUjoW4a6bRHLG29TiCkupiOxJ/+IlW0zND71JEAR7PwRc
	Tef3HWbUZMUlLFZSAq0S3bJwtd0=
X-Google-Smtp-Source: AGHT+IEa9/49xzFtkrl2WuFSbF2nGR0Ee3sa2JYGGK47IcVnnhS7gaKd3pqPtDHg3v3/2iaUnvbb9dKc2W6cTL8KA/s=
X-Received: by 2002:a05:651c:2354:10b0:351:62e3:95d6 with SMTP id
 38308e7fff4ca-3790773c607mr10303011fa.28.1761661226962; Tue, 28 Oct 2025
 07:20:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761588465.git.geert+renesas@glider.be> <76ac5587c5ff3aae3c23f7b41e2f3eacb32ebd21.1761588465.git.geert+renesas@glider.be>
In-Reply-To: <76ac5587c5ff3aae3c23f7b41e2f3eacb32ebd21.1761588465.git.geert+renesas@glider.be>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 28 Oct 2025 15:20:13 +0100
X-Gm-Features: AWmQ_bkGEmC8OCwW4QksGegCfgNPPWl_EjVB0knvBjv-hfBoqYq6hENcwtWJ0QE
Message-ID: <CAMRc=MdcH-56_cJ7oDUhHRsJRnDqbss5ET-3yGrBffGmEK_ieQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/23] gpio: aspeed: #undef field_{get,prep}() before
 local definition
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
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

On Mon, Oct 27, 2025 at 7:42=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Prepare for the advent of globally available common field_get() and
> field_prep() macros by undefining the symbols before defining local
> variants.  This prevents redefinition warnings from the C preprocessor
> when introducing the common macros later.
>
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> --
> v5:
>   - New.
> ---
>  drivers/gpio/gpio-aspeed.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index 7953a9c4e36d7550..ef4ccaf74a5b379e 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -32,7 +32,9 @@
>  #include "gpiolib.h"
>
>  /* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
> +#undef field_get
>  #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> +#undef field_prep
>  #define field_prep(_mask, _val)        (((_val) << (ffs(_mask) - 1)) & (=
_mask))
>
>  #define GPIO_G7_IRQ_STS_BASE 0x100
> --
> 2.43.0
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

