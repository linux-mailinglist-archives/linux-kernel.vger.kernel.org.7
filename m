Return-Path: <linux-kernel+bounces-876360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28436C1BB22
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADC56428B6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B272299A8F;
	Wed, 29 Oct 2025 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVwISxo1"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9888D2641FB
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748237; cv=none; b=ak6ubKQcRcOqslhm0IjcJlNyqs1iFG/FQq/8ejJhbT1TylNdHl8t1BRgQ7B2LxM054LH3VT63t4/gjJfCan0i9uM2TAX+u8zfPGAT7ZgeyI+QbIUuOuZjQ3eg8jBBJulxmccyfIk7sS6nfxt7GEe35wxHvNlIaNiGtB/v16HY2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748237; c=relaxed/simple;
	bh=7qSqb+8qhf4bmtYpSevPKgH9NpBXdJ7Y+QlL0CxIedM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfvhfMv1HRAgeJH11uCJGDPTxhyb6Qk2FdUs/OBgHfdX8w13rA7AZjFiLz8hgTgxpjrgJZZP1LC+Ji5vhHMTglHgQ518JDojivcxBVuZ/rN9txf7PThT1KuKYBuaVtJ8vuA2canfVrlsXsAAUKJgskyhkrrAByrujAVmTd07XjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVwISxo1; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4eba313770dso49600421cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761748233; x=1762353033; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JnpQqG3KsjO8HR5ITuKL9a0uCELInljqSPlsEDY9f3Y=;
        b=HVwISxo10QqmrSYJm8NEWiPwMQdAiacHa63OSUEAOSCJl5S1CA8h1XtfTBJ+HmBrua
         w0YVot9mWsIVPfNpcf5bUtJMJXLuR8HvqT4uo56qtjCKmLUSQiBatizK3mNSYFVNIqyT
         YawDnfkurMYiTvK7GaRIEg9H7V06d4KB0okYHxfQLUJ8A0wxiAMZLhq6yzxKrBJvE948
         ydDUTAKK8c26FesuIPJAp59RrcCTDy4fWxTiLBQNwkkz17hNB535tNRdNm6xv25uX473
         +duWPWlmevzjZB4BKgqyMhXV20EeZDWiiTFHXfrcKqcTmGlM9nxBaHBuIZ7w/752aBPM
         1Zmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761748233; x=1762353033;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JnpQqG3KsjO8HR5ITuKL9a0uCELInljqSPlsEDY9f3Y=;
        b=qpqkj7hIJRJ8QaO4d626GS9+8gNqYL8xoWaqFf3yygij9YQdrs3cSCuYUDHkQE5o7n
         NGylOJEnWNtWLu9iEq6ZuHNPHmQNEFnfDfW94CoS3PJzw1KlYmPpFRqKVocgBJcinHpu
         yXHYmwNMOp7O61hTBVIx2zwyv7WNHUSwZWSbaSamZsuuVfFrr+S05BvhFQ839Y7ru8NQ
         +raAw+L5FO1nmqUbzRwoneY2eTpPoiuZmHUjuCm2RH9m6yS1qOLJ/5YPqLa5k5SgLxea
         1y/zapoNlv3vo4mw7VJLl6gKjbdxFndaXAiNKpHtMZoP0z3MZMecL4BjzADj50zlUrSr
         yNkw==
X-Forwarded-Encrypted: i=1; AJvYcCUWn6vwUi1gvmweepwEcSE8OWvW55OBPRqY7wFv5q7NJWA7uLSEIPhL6QzRn011Hk9j3nrG/zb4yhrl2Ts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yway9ykWmm0BFqEUIXpRTezGnoevhMD3L0V+zrN5yAh/+pZ7ivf
	K2dAbwca02stu22m6gXQ4SGh276zvsKIrIQziPv1ubvBcZzMxVgL2YTw
X-Gm-Gg: ASbGncu5dLhc5M1cFJ4ZIhUEQpXB/YfFriJdxfvLxUuiE53mM1EaBLl/uKwS56xJcLc
	02n/hzJ0Qqw9pJ26/tHjwsY7TsHPBN8yvEE4xcds3w+6z0ueVGiMPCSXBtGA2riRC0rWPPx5ACc
	auk5Duw7BVLQxBEC8bjOjbm3qLG4K11jtQKV/RlwuCouqCOSm+owhsYImXfQGC7bhSRi+tHi3G4
	jLne/HaJmdhygf6WvtEoPk8nnI0i0Iz6ua/LGH14U+M98QuBzqtNY1mLxbYK3+dWX1wBa1en7ck
	s2SVpdjEK2DxIUzkNqW/8EYxgGI5Jt113k3N9BNp2ilczRnQQJkjNlcd8pILPyAlAYSq783w+cz
	YpHtvuY68VXUswJZjKAUmzMgvJfcmCNzFTlLT2kGerI1Kg3oGvPp2RJwdCbjwVIuTFipyjJym
X-Google-Smtp-Source: AGHT+IHd6ZEI/4efuxlvOLVTSJQH1JkXxxhkGirHmvwiRC9eDvjzIFKRpIZ05PrXMHCHH/Mrsnw0AA==
X-Received: by 2002:a05:622a:24a:b0:4e8:93fc:f8c9 with SMTP id d75a77b69052e-4ed15b53cd6mr36770551cf.15.1761748233098;
        Wed, 29 Oct 2025 07:30:33 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc51e3809sm96571096d6.26.2025.10.29.07.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 07:30:32 -0700 (PDT)
Date: Wed, 29 Oct 2025 10:30:31 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Miller <davem@davemloft.net>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Crt Mori <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>,
	David Laight <david.laight.linux@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jason Baron <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Jianping Shen <Jianping.Shen@de.bosch.com>,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-edac@vger.kernel.org, qat-linux@intel.com,
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	linux-iio@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 07/23] pinctrl: ma35: #undef field_{get,prep}() before
 local definition
Message-ID: <aQIlB8KLhVuSqQvt@yury>
References: <cover.1761588465.git.geert+renesas@glider.be>
 <03a492c8af84a41e47b33c9a974559805d070d8d.1761588465.git.geert+renesas@glider.be>
 <CACRpkda6ykSZ0k9q4ChBW5NuPZvmjVjH2LPxyp3RB-=fJLBPFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkda6ykSZ0k9q4ChBW5NuPZvmjVjH2LPxyp3RB-=fJLBPFg@mail.gmail.com>

On Wed, Oct 29, 2025 at 03:19:45PM +0100, Linus Walleij wrote:
> Hi Geert,
> 
> thanks for your patch!
> 
> On Mon, Oct 27, 2025 at 7:43 PM Geert Uytterhoeven
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

There's a couple nits from Andy, and also a clang W=1 warning to
address. So I think, v6 is needed.

But overlall, the series is OK, and I'd like to take it in bitmaps
branch as it's more related to bits rather than a particular
subsystem.

Thanks,
Yury

