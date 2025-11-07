Return-Path: <linux-kernel+bounces-890214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE90C3F7F1
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 141644F6AED
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF18932ABD1;
	Fri,  7 Nov 2025 10:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DrmxX8XC"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F8832AAD7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511589; cv=none; b=UUnairP4n0CJu27GB/LJWNeA6QsjLxGI4oeYoQRIOdQIunJjM6vvPiif3az0G8kvwJARR0WPABTGb+G7qy3tjDecYHjfALd46nfzf7I3YDoxkEStIDP28Vu/A+z8QAQgpeHRjWm+8TdsMJSPWQX3wGipjgWqFhBxC2PefyXhYtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511589; c=relaxed/simple;
	bh=ekrma6VDIEDQdQowvD1YIFD7aFqh+2yqjc36N5YHdUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbosRsYBDaW8RbzGdnMyTh3qGdc/ng3T/gm8cGDD1fbQOMdL2/5mtNAVAdFnZ/fn0u5iPyjbBzkOKKEx4dkNsC9uAUM/tQEpL5pj3p7cCRIegBPAR7b51Id1hxweo4wEIup1t8i3WSzQ7nooY3ZTRhJDrzpi8pfQGcFkQW2Oc8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DrmxX8XC; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5942e61f001so536635e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 02:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762511584; x=1763116384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0SC5dtN/EI2PuuKztOZyox/MGIrIYy9hq7oU1yzaSE=;
        b=DrmxX8XC5no3w8yxuAbJ3vfdTGFTbpvv3Hw2bWdB7q3smfVfi9Dwda5VGvxpKh9z1g
         aNY94bE0+g3+G+3XCqUIWDgA6+FPR3+OpTYWE4tvse0KzxbzFnm8GqnAzJ//CA8ILDtu
         /RFfhBGvnL9a44TZBnGT8V8K3PBYSWRvVrr8ibHC/EcFk0vECzqv6opgfQslr8EJGArA
         RjgzPh0FZwChPCrVH6i4qr0WHrTjD2nWeAzt98batEjWNazGzkyd050Lh6VlYUuRjGw7
         JClPRok+c5WvuGnlFifkroJBKtCzUJ9xfes5EpFRNjrP1O+l/TFbicbe1i1hL47mqiHU
         C3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762511584; x=1763116384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u0SC5dtN/EI2PuuKztOZyox/MGIrIYy9hq7oU1yzaSE=;
        b=ZdmLyMxiIpgctDYit0cv9a/yOgLmWiV7HdanFYb/PS8I1fMXKIOYJo7pjhGB06D03n
         IkG+1IWzrClUOOox8MI86Nw4OfDpIaFnqemjLbBior0SYjEW+jFLnsNS1kxDeCPb/LHV
         zAmtDQgUBn+pFfxjk3VDXR/Q+xJfo29txrtANVLt5KNwASQTsdVxHXIllbCf1WXHU4Fr
         nCcBTUCu5s5pK7z5Ddi7S+aw/9XIx1YYDIdIo3zZ8d0vK3rIjx1K8URdD0xgUWYai0k1
         4MOWg+N7yh9P9gC3xl4Bu9CT9Z0fvbutaKQcJilEQdubeNUJ2eFMCcXe4yNtpAnzNxgR
         zTwA==
X-Forwarded-Encrypted: i=1; AJvYcCWeHDuqKGeyMBzlddxxirXPWvnjYCggKUoDXOBLUqPZYvURftBtG0PdXtgma7i5Sz7X5zZ6VYdoUyPSObw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzymW+bgL2uBkBKsWjmjB2B1ERqBO/StgcxV22rRbKLReIx9YTc
	1HAOP02ZWY7jn6l7awKI/4OR+07ube5x7pc0iYn0QkHKDxaEvnXI6ZZYVsDqRUfuDg5TkpvJeth
	+vtuujXeNh2hxWTJaVlOdeU/XiGlOecCPgMRiLqzNqA==
X-Gm-Gg: ASbGnctuqr0uhDDn6WoFmLUnegsEfOngbpM7/9uX2hHQCSJhlK7NyQhV6tUJa0hpBn9
	/Q2Mlw+b9CfKWRODWUbvwoiUKz+2RIQxj4G7v1W7D5J+GQqqM87KNZ3NEnr4dcRV+/PrNYQuH/6
	cwSgZDpOCXQ6FqvjYL2DFtH/pXDQgbBwe+uh46hq1ov1tA//K3hc+dYEY8dmc8GtuwuDkJP0nNQ
	KBHXV767dLlbT0kUeMBTupcx1khb0tO2ze01xZwwniD90s/TYlfcBnTgaUC5FHX5wk3Rus2mw++
	RkLJBHxKL3NFgd+KqH3CDENEfA==
X-Google-Smtp-Source: AGHT+IH/NaO2IV2PuSuT+uIy0ell6f4pEVJBNYisr1Il5Fm4JRWfx8ML7AoeEUzy6VOMfbvkcuWVGadITNGQPdN4yQA=
X-Received: by 2002:a05:6512:3a86:b0:591:eb00:9795 with SMTP id
 2adb3069b0e04-59456b5b60bmr827315e87.13.1762511583894; Fri, 07 Nov 2025
 02:33:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106-gpio-of-match-v1-0-50c7115a045e@linaro.org>
 <20251106-gpio-of-match-v1-2-50c7115a045e@linaro.org> <CAMRc=Mchtho0yDsSp+wwBt=yBGg1+3i8ifkUrip1MJaq-uk+0g@mail.gmail.com>
 <cf23070f-8a3c-4c13-a46c-dc95f044c936@linaro.org>
In-Reply-To: <cf23070f-8a3c-4c13-a46c-dc95f044c936@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 7 Nov 2025 11:32:52 +0100
X-Gm-Features: AWmQ_bk09Ua_9bvIZ5lzbEUjBii8ELdurCEnXHjZ0WSd4oyNENmk6WbdUM8c1Lw
Message-ID: <CAMRc=MeQk6BnKPGNxmFYP6Z=Qmo+PB0T8bBZGAbR3LP7xRzELA@mail.gmail.com>
Subject: Re: [PATCH 2/4] gpio: aspeed: Simplify with of_device_get_match_data()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Srinivas Neeli <srinivas.neeli@amd.com>, 
	Michal Simek <michal.simek@amd.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 8:13=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 06/11/2025 17:23, Bartosz Golaszewski wrote:
> > On Thu, Nov 6, 2025 at 5:16=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> Driver's probe function matches against driver's of_device_id table,
> >> where each entry has non-NULL match data, so of_match_node() can be
> >> simplified with of_device_get_match_data().
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  drivers/gpio/gpio-aspeed.c | 7 ++-----
> >>  1 file changed, 2 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> >> index 2e0ae953dd99..3d675b63936c 100644
> >> --- a/drivers/gpio/gpio-aspeed.c
> >> +++ b/drivers/gpio/gpio-aspeed.c
> >> @@ -1305,7 +1305,6 @@ MODULE_DEVICE_TABLE(of, aspeed_gpio_of_table);
> >>
> >>  static int aspeed_gpio_probe(struct platform_device *pdev)
> >>  {
> >> -       const struct of_device_id *gpio_id;
> >>         struct gpio_irq_chip *girq;
> >>         struct aspeed_gpio *gpio;
> >>         int rc, irq, i, banks, err;
> >> @@ -1323,8 +1322,8 @@ static int aspeed_gpio_probe(struct platform_dev=
ice *pdev)
> >>
> >>         raw_spin_lock_init(&gpio->lock);
> >>
> >> -       gpio_id =3D of_match_node(aspeed_gpio_of_table, pdev->dev.of_n=
ode);
> >> -       if (!gpio_id)
> >> +       gpio->config =3D of_device_get_match_data(&pdev->dev);
> >
> > If you're already doing it, just use device_get_match_data() here and
> > elsewhere in the series.
>
> That's not exactly equivalent, but I guess it does not matter if driver
> probes only via OF. Sure, I'll change it.
>

In this case, it probably doesn't matter but in almost all cases it's
better to go through the fwnode path, as it also checks potential
secondary nodes when retrieving properties. Not to mention better
portability of the driver if needed in the future.

Bart

