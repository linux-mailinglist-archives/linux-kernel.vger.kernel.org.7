Return-Path: <linux-kernel+bounces-888907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5B5C3C3DC
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E8DE4F8D4B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FFE3093DB;
	Thu,  6 Nov 2025 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqFUfg9s"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA43233DEF3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444905; cv=none; b=j9p31YERFYF4oPEVkVBeBAC3APx0XTnpXyN+mets0Kz+8mZlx02VxRzvFi8pexKc29Wi0Cij1teaTiJmPRp6vkXalkM+gWGc6ISHU4xawWLX123irDHlMSbf6FIRkIqO1WUy45Fh08G0Z2lqKiXBK0CsRn6tsWjlFEt2sf6Zvgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444905; c=relaxed/simple;
	bh=T9dOCjt5CSMA8b/M7JLaYkgOskmgR2ygjFafGQfTcfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twlt5HwSJ9G2l8vXgd6GcrhuOhROH2bMTCw9XitKhHnj0s5u6+dlwpISe0HWH8Tc1igJokyLmxKgVmzVBqQMChpM9jLr4niNjdG/xFPrcJfo1iQ2e+DSV7xa3dlLNxHVcu9X7Y2hcJ8R/fDWuECeUw5FvjQiuqNGNA5K4+fxAKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqFUfg9s; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7864cef1976so32906777b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762444902; x=1763049702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uDqvdpSXd7EVG4K3GSPuN1+lwa+x8rxJ7aM50JiFwXE=;
        b=TqFUfg9sdXxypsXTeE5BSr5Qkw8tO2/cIJTGInEFiTFfU5cxawi9hpV918beskopTK
         /6SnOKWCg0fYbXrnhClN6h/ZIDJ4hKq5K80QFj6VxjsZGVVErM0AHnnIBpSHYHq1r1pS
         8Yxk9b6xcmhTp/sTdYFZaoEoARZJ8pcFux2xGerbAVMQqtK8XqjLNHMhF4PzVwrtHAdm
         R+CiwBInxL+6ZNI3IyjxHEyzQQMDawko9u6NiKv8LZfJbo+iN8UPF14mSG3wTNjFoQoz
         v26N7sZ2QU8jlslhMel0AWHK42O5moBUO2mtG/6vNATPQxCZ2Y2TIM2PntMcOdpJXv3F
         /zpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762444902; x=1763049702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDqvdpSXd7EVG4K3GSPuN1+lwa+x8rxJ7aM50JiFwXE=;
        b=SQjxBYCKvKbPJrUoAxZQkibMaogAvZ7UWWg5VXENCWfcbZ+sz1b6blI0LsIWCuDeXb
         3lTmUPSjwsAEKYRTi6dIC2CjXnS3nt+ZxJ0mi+ubQK+QKahg4fQJnT878kY+UsDzAW6b
         xPaVLYd+ldQq2LTmApYC5DotpvEzA/9xon3T+c3ny7lcYA1W59epL2GUwjPkfrL0CuqK
         Iu/5seOs2UMEQbHf3Z/jAZcKxa9GaTp3ER1MSe3HMfNmf1KihLoi5SEeke10gtGS4nQn
         XVrI1nmMaWmE8m/ggRRrkKtQduRf6nDOyfhSU/iNBnIa1vZN1jykUKWSCIow4vMfBa+K
         nzPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKODHOQmRuhpRewUV4b2nQyd69AOBm7BnMnXSIIf5nbErSFzkEzjrAOMSXLzTasF/44/FVB+mH5gye3s4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze2z9isGc+IRYDGWbJHVAE7vGCwX7VPa2Fm8nEZh5IXB59Lmas
	7pbeDKD2/0L/qsLQrG9tj7ZIasi6aWZf6cJ7kM7YQ4U2tyxuCIZzZVq8
X-Gm-Gg: ASbGncthzsjhRyduRg16FFp+IbXQrxbNYFGo6DW4SFWAHYIFfBMiG9Z/sPu/gUfeZqr
	EwvzSG1pIS6lm8bkeu9TrBaAFy5m3+Skp7U2XzXKS5uM41/BlDFcDR1d3MgXVhUZkTN29mU6tHF
	L0XzjTlJZQBq+h/AgKs45E6UUq/H83sPgfM9z08GvXZZW0IcotU8xEiZ4eQd8z7qs6KRY696wyo
	2RBiD6eAuN2vGbyp9kweJ15rmqInmj+dWpVHOSfRkk8Uag3yTN19gzy3WSS+/DR2cSuTOE7ipyI
	MrbgIuPKUBHfIZNj7jS5prIgsmiMHgh23I5j/1Pdo2a0spd4GJfD7D3sH9DnV/N6d8EGa0lCBQq
	BNEmcOn/uN3YDCw+4kW3Zy38ugNlFnytl+DKOcOswJr/pTEchn9ouOrYuf8Pi32oKtSjRp+M9Vu
	Swxf3DG1wZd2Q5FxmD4UJtjVmNX6Zs+qYe
X-Google-Smtp-Source: AGHT+IHH1OiCGEbzPId419SmPeowjgjZvd2uwuBPgu14uOeMTfnhF3EzyBaZ3Vf1fe9K5qAqRN9gOQ==
X-Received: by 2002:a05:690e:2405:b0:63f:b1fd:3850 with SMTP id 956f58d0204a3-640c3b56ae5mr33952d50.33.1762444901924;
        Thu, 06 Nov 2025 08:01:41 -0800 (PST)
Received: from localhost (c-73-105-0-253.hsd1.fl.comcast.net. [73.105.0.253])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b15d6379sm9121887b3.45.2025.11.06.08.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:01:40 -0800 (PST)
Date: Thu, 6 Nov 2025 11:01:39 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Miller <davem@davemloft.net>,
	Linus Walleij <linus.walleij@linaro.org>,
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
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-edac@vger.kernel.org, qat-linux@intel.com,
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	linux-iio@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 12/26] bitfield: Add less-checking __FIELD_{GET,PREP}()
Message-ID: <aQzGY4AKiMQpuL0R@yury>
References: <cover.1762435376.git.geert+renesas@glider.be>
 <cfc32f8530d5c0d4a7fb33c482a4bf549f26ec24.1762435376.git.geert+renesas@glider.be>
 <aQy0T2vUINze_6_q@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQy0T2vUINze_6_q@smile.fi.intel.com>

On Thu, Nov 06, 2025 at 04:44:31PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 06, 2025 at 02:34:00PM +0100, Geert Uytterhoeven wrote:
> > The BUILD_BUG_ON_MSG() check against "~0ull" works only with "unsigned
> > (long) long" _mask types.  For constant masks, that condition is usually
> > met, as GENMASK() yields an UL value.  The few places where the
> > constant mask is stored in an intermediate variable were fixed by
> > changing the variable type to u64 (see e.g. [1] and [2]).
> > 
> > However, for non-constant masks, smaller unsigned types should be valid,
> > too, but currently lead to "result of comparison of constant
> > 18446744073709551615 with expression of type ... is always
> > false"-warnings with clang and W=1.
> > 
> > Hence refactor the __BF_FIELD_CHECK() helper, and factor out
> > __FIELD_{GET,PREP}().  The later lack the single problematic check, but
> > are otherwise identical to FIELD_{GET,PREP}(), and are intended to be
> > used in the fully non-const variants later.
> > 
> > [1] commit 5c667d5a5a3ec166 ("clk: sp7021: Adjust width of _m in
> >     HWM_FIELD_PREP()")
> > [2] commit cfd6fb45cfaf46fa ("crypto: ccree - avoid out-of-range
> >     warnings from clang")
> 
> 
> Also can be made as
> 
> Link: https://git.kernel.org/torvalds/c/5c667d5a5a3ec166 [1]
> 
> The positive effect that one may click that on Git Web.
> Ideally, of course, would be an additional parses on Git Web kernel.org uses to
> parse that standard "commit ...()" notation to add the respective HREF link.

Those flying over Atlantic or cruising cross Caribbean would disagree. :)
 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> ...
> 
> > +	BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >		\
> > +			 __bf_cast_unsigned(reg, ~0ull),		\
> > +			 pfx "type of reg too small for mask")
> 
> Perhaps we may convert this (and others?) to static_assert():s at some point?
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 

