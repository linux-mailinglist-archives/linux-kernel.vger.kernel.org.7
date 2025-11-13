Return-Path: <linux-kernel+bounces-898911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEDBC5650C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 584754EA38F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10174331A42;
	Thu, 13 Nov 2025 08:33:16 +0000 (UTC)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787B033122A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763022795; cv=none; b=J1YblYnbMK1H4iHwkA8+g3fK0xzd7uNemOHS1HPw1QBUXjgX2g9V8S4bDKYIPJJdELOplHnFbsF+KT4OSTpEGNld9gqaaJwbGDggYc0isyh5Vb/J6sL0I2SkG6SPL/yrvVWskMzRYnMG9QDjnauew+0X/E5yfMARUwM58KiFWQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763022795; c=relaxed/simple;
	bh=WDZYAHbv5mBkU9poLMWuB4yiOD3mBOoF+sIIPyL8TvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ls151vQJo+bLOExGLYq8veMa2qvyf+2vnBVlGqlXxWZQH7XvrJ55RK+qGg61irv6WcwziiHtLI8v3kAK2glUGXRDTiTLsBPAuPvBS+iUPb3z+Ukxi4XghzcM7KThccP0YcTOzolwgRIFHY/nNgLApWZu4mK+oBTVXAEMPb98kOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-55ad466ad1eso160932e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:33:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763022791; x=1763627591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xfvAxBKuBN5aIubnwQ1QO1UY6mKrYpvn3C7gF7sZv8=;
        b=YXBBNKgC+TGXhWAgSKGw/VwM3DPxbW5xwWcdIutLi1vxiZIbQjqIBU6gQLQQpcQ94f
         FXtGd0XHMrN/2qIonEngEzlHJmZm1/q0PCJGjKJz1UjQ2yP5thUY+jvsEbW9E4aZfavs
         SO0Z5t6Sj6+Tdq8B2074g0tspVHknKq7Vu80hxtm+rPFgLTTzEUCnJC9NkB+xRQzg3Dl
         foO7bW83O6qcn/QHFVwvptKe1r3z6wmd7WuPRcVcU+lQXDrZLw1vx9nKy3luS/AjDPTe
         Qw4BpM3dsv6XQHqLyg0bHPyUldIcmbtDhEohrH35ASaqdi1lZkaHAFfVthcSrNwgU1uR
         LpCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWApv6Ru5Tm3lnYYpKIk0NsPcPbGWWL3Yqvn+U4PLwRZQobTGUobrHGmUcpF9t0MwzvdXhct7fegWJ3CU=@vger.kernel.org
X-Gm-Message-State: AOJu0YysTPyzuG45qgXjBKlpF2f5whs1D5UBDxJY5oFfAk2h4AYofzoD
	uFRh/nBpDggEYIx63yG0j3acMJO7/DG9HKj20HcyyliPY5V/pxfRKmYF6xfoJAogtSw=
X-Gm-Gg: ASbGnctU9/EaWHVwtodgdhrjYhUkNZqxk8vmxAbkKsRDV4pab+YiFXWoxN44MobLV0F
	bveP9ChnBM7OZNQBsuQUMne55TPj40BEEg69um2/9KRasfx+ZfOdpxrLA1f6yImX3GMycnR1qWd
	SoJbuOhqW4V3oYv1kAebSezFKJ7Xz6kFYqxAszQLIhlvZWt9xMMjc7NrslxCpkU6GFtDccK5v5i
	3cBFNnFecIOcTDt/Z8p1FBsMWYvDIIzncAksiVQz/u50x9ApjtZty8yZ/s05OtCowVAAAjgurI7
	hJyBpjUmOzcIlofrjdGiZLS5jwkCt/ncBCQDhvYm6pY/60TzLMIsHjyT5HADTH7AWDPG+dRC5B1
	RPb4fupbiC0oLW5q4HHbhw5qx95C309QHNDxg8kniz0/I5gXm9ZlxtBK5ICJqgBGpd3n064NFYG
	X8sEhbflneXTXrv4bguEd9gK64gOgK4EkbAFKbgA==
X-Google-Smtp-Source: AGHT+IEGtgR5KhEo60fIrVnXB5wL38nEIah0e4kjgkuC4DRboNzkhO7RBRw8UkMgj3XyRhGO8EGfFA==
X-Received: by 2002:a05:6122:3481:b0:54c:3fe6:627b with SMTP id 71dfb90a1353d-559e79bd4f5mr2209549e0c.3.1763022790926;
        Thu, 13 Nov 2025 00:33:10 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b0f49865fsm485130e0c.22.2025.11.13.00.33.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 00:33:10 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-9351ed45fb8so170369241.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:33:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQ05KKbwQwTJJVW9gWHUP8Uwvyg6e8igHx8V2+CGHTqSz5alhrMpF+m3ebweQIesnxyURot6UQmmnSDrU=@vger.kernel.org
X-Received: by 2002:a05:6102:290b:b0:5df:b3ed:2c8b with SMTP id
 ada2fe7eead31-5dfb3ed30cdmr825635137.38.1763022790257; Thu, 13 Nov 2025
 00:33:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008042526.3312597-1-claudiu.beznea.uj@bp.renesas.com>
 <20251008042526.3312597-3-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdXUqsU6MKh8WSO4EmrxCfUg8FZkrJKb7OH-KwMY4+iC4Q@mail.gmail.com> <aRTRshYq2MznnCYc@shikoro>
In-Reply-To: <aRTRshYq2MznnCYc@shikoro>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2025 09:32:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWkKCi848-jELO=XuNyyADRHJfVhUng4JWJ0CMhXRLYug@mail.gmail.com>
X-Gm-Features: AWmQ_blHht0AJ-x3GqfMcqWJKmRw1q0N88H_qFBWtcL7Np5xBSlxA2bfyasQ70I
Message-ID: <CAMuHMdWkKCi848-jELO=XuNyyADRHJfVhUng4JWJ0CMhXRLYug@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: renesas_sdhi: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS()
 and pm_ptr()
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Claudiu <claudiu.beznea@tuxon.dev>, ulf.hansson@linaro.org, 
	p.zabel@pengutronix.de, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Wolfram,

On Wed, 12 Nov 2025 at 19:28, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > > -#ifdef CONFIG_PM
> > >  int tmio_mmc_host_runtime_suspend(struct device *dev);
> > >  int tmio_mmc_host_runtime_resume(struct device *dev);
> > > -#endif
> >
> > This change is indeed needed, because RUNTIME_PM_OPS() now
> > references these two functions unconditionally...
> >
> > >
> > >  static inline u16 sd_ctrl_read16(struct tmio_mmc_host *host, int addr)
> > >  {
> > > diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> > > index 775e0d9353d5..8be642f737c7 100644
> > > --- a/drivers/mmc/host/tmio_mmc_core.c
> > > +++ b/drivers/mmc/host/tmio_mmc_core.c
> > > @@ -1286,7 +1286,6 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
> > >  }
> > >  EXPORT_SYMBOL_GPL(tmio_mmc_host_remove);
> > >
> > > -#ifdef CONFIG_PM
> > >  static int tmio_mmc_clk_enable(struct tmio_mmc_host *host)
> > >  {
> > >         if (!host->clk_enable)
> > > @@ -1331,7 +1330,6 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
> > >         return 0;
> > >  }
> > >  EXPORT_SYMBOL_GPL(tmio_mmc_host_runtime_resume);
> > > -#endif
> >
> > ... however, no actual code referencing them is emitted in the
> > CONFIG_PM=n case, as renesas_sdhi_internal_dmac_dev_pm_ops is not used
> > due to the use of pm_ptr().  Hence the changes to this file are needed.

Oops, I intended to write "are not needed"!

> > (verified with m68k allmodconfig/allyesconfig builds)
>
> Since you confirmed all this, did you forget a Rev-by? Or do you
> actually describe an issue which I am overlooking?

Thank you for pushing me to rethink why I didn't provide an Rb-tag!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

