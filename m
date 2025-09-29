Return-Path: <linux-kernel+bounces-836139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 939FEBA8D6F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469321C09FD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181902FB614;
	Mon, 29 Sep 2025 10:15:31 +0000 (UTC)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D1824676A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759140930; cv=none; b=Ve8cTkkbPL66ap6jgNw5Z0UedelG5rEOhDDxTh4cQToSkC+o21sWPY6yn2u7iwcEgHeEqp2YYtIdKxhf2zwES2gziX6KNA4ZaLLt3iTQ0GrGBSbYRaf54mlgHP88jvZyLoxUgPYWZCsSIKJUqCe+oIoPaeUkAa4zwY7P0GOXztQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759140930; c=relaxed/simple;
	bh=VKeWPwCthMHrv46cS6qePKsRD0r2j4FUJoWvmC+PJk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qxWjoOncsYJjmOe1iYwY1dG5VWlw4iVenFO/acTDEWptvQR6IQIw0tpzHzPxRwInMXpgFAm1ySFj2XItHmMzWjlDm9XnAgPlX2ZNc0Fq4pMMSgW0ZyDXN38kzVrxx7mT4kMQz++17Bz/Lv6xjYY81jBmMUERzyUlWaY9IsTGTzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-8e3239afdf2so2691204241.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759140927; x=1759745727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CLywH616puogHM/w7g0w5lgJ4MaYI93I5ro3ENJXEGs=;
        b=JTSVyaM534XjM8DARUXjz4p9qiz3wLRaoNDgmy1Ma7PlmVTi4/VMmuT5IBngI/aU8J
         49w2bjjntboOBzJdPnq9VMJo+tik3KGnlk7mrDSeGWCdwgF+JsJkwNZ/0T8Dwmo2FB89
         8259x5ARI4l4p9Zq3ngOARmWEABQpbVGGkaAr57v79sawzQG6LQ+uRKShRbnQ7aheqsx
         drn0F+FdG+cS8CyT1cj0pKnbJnFLcI7ZMUK6I+4MLAheHdjI9RKAYzgS6MuG8gFCuFPx
         recIBrMbIRavJJR6787Rhj6Y2XoFxL/IQYCWpQRAs0iljdetQHHQoAqan/ig9aEkMjI7
         8z7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHh9GIjgaLKjFGiMQRxGZ/lZKPynxTbRh8Xyzu1FqXUK3VV374WCC7Ti5RtPiOBZFxPMq67ECo9Nje+jA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2hZxvDwHHaxqPSUQLNkmaFwu06vZeshqBFWfo7GKPoCt6Emip
	ul96m/1X0WKemLEC+MisYfeVtR0bNe4j4LFRF657pcACwqKJ2++JCX2dqQYUm72R
X-Gm-Gg: ASbGnctRDHJxpzriNZAYFGe5IfeXD1MBYkx+GkyEIaG9XudrKr8rVtAF9FugiwcwmG4
	p7LCNqtEETwSJ2DcON04nOS1oVYm9n7WTCypxanAzrALz1IkWMEkQwhFCUAAa7j3NCDfHlQPMBG
	ewLw35FjnckNmNnPss93TXINMtyOuQ5ZnPB7Pgtl61RzhiuXfikIZP6VQV5UkOm8TxHmqs9K/Eo
	31WLSxu41qJ0j1uiw9XOgJgYpH66q1sq7CocAdHn++iQoXKdRSr6I1QAjiIuGoB3ex1odPROjCM
	tTkn3Rli2znrEnnrhCzozziIMbkj2ZFkmRFDNCbTZZ1sofzCVzVMwJTTHRSUiWM0vuVWtd/2Avh
	PzaSkaKqZt7cbvK/cNT48Vc2IEV78fmyVuVy0B4w/xGHg/r4nQT9Yed9486jhE0KSh7t2ifg=
X-Google-Smtp-Source: AGHT+IH03+Wu61dJRVijdTfQBUnYUi4cPNm1ySpK2p/rXGcLhi+fwYcuwkP/HJSk+FslpmQ6k83Zfg==
X-Received: by 2002:a05:6102:510e:b0:527:d1de:893b with SMTP id ada2fe7eead31-5acd4639ad5mr6453048137.18.1759140927626;
        Mon, 29 Sep 2025 03:15:27 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-916d1518f84sm2371668241.6.2025.09.29.03.15.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 03:15:27 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5a218470faaso3472184137.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:15:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXtL/nsnO0HNPfWYG82eJsN0T0jLp4B1sWxXPrlgX3oP4Lmgi8928aDEJAxS2eKmPos4O42531tac4rbqc=@vger.kernel.org
X-Received: by 2002:a05:6102:f11:b0:5a3:d554:8409 with SMTP id
 ada2fe7eead31-5acd634005dmr6695044137.25.1759140926458; Mon, 29 Sep 2025
 03:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929-gpio-aggregator-fix-set-config-callback-v1-1-39046e1da609@bootlin.com>
In-Reply-To: <20250929-gpio-aggregator-fix-set-config-callback-v1-1-39046e1da609@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Sep 2025 12:15:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX5HXx2HSAHP-H1EEKO-csBku_cMm-OaacE7GZLXwBxOg@mail.gmail.com>
X-Gm-Features: AS18NWCqCPvheA4EHmzGW4vCHywVYoZXOJht6RqD_H4VpVYB8jhcuEiZQ8v1G8I
Message-ID: <CAMuHMdX5HXx2HSAHP-H1EEKO-csBku_cMm-OaacE7GZLXwBxOg@mail.gmail.com>
Subject: Re: [PATCH] gpio: aggregator: restore the set_config operation
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

On Mon, 29 Sept 2025 at 12:03, Thomas Richard
<thomas.richard@bootlin.com> wrote:
> Restore the set_config operation, as it was lost during the refactoring of
> the gpio-aggregator driver while creating the gpio forwarder library.
>
> Fixes: b31c68fd851e7 ("gpio: aggregator: handle runtime registration of gpio_desc in gpiochip_fwd")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202509281206.a7334ae8-lkp@intel.com
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>

Thanks for your patch!

> --- a/drivers/gpio/gpio-aggregator.c
> +++ b/drivers/gpio/gpio-aggregator.c
> @@ -723,6 +723,7 @@ struct gpiochip_fwd *devm_gpiochip_fwd_alloc(struct device *dev,
>         chip->get_multiple = gpio_fwd_get_multiple_locked;
>         chip->set = gpio_fwd_set;
>         chip->set_multiple = gpio_fwd_set_multiple_locked;
> +       chip->set_config = gpio_fwd_set_config;
>         chip->to_irq = gpio_fwd_to_irq;
>         chip->base = -1;
>         chip->ngpio = ngpios;
>

Is there any specific reason why you are doing this unconditionally,
instead of only when any of its parents support .set_config(), like
was done before?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

