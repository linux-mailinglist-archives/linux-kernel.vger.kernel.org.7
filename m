Return-Path: <linux-kernel+bounces-900041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53991C596B1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F338F3500A4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CB92D978A;
	Thu, 13 Nov 2025 18:20:21 +0000 (UTC)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66F030DD05
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 18:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763058020; cv=none; b=ADwxAACdk+pAUTaheJPx8jushnaCHK7UXEXRnL+YqwtXxzG+waAEF2aZx59xHHidff/Z4KTvv4GIMZ1qAfJhwAYPDp0XauPdEconeT5SCGsxt7o/eyUejZ6DJ5Tll8Sabi3P5PQtUZsLdzpZNe6glttri1tOwtIgZJQleo/XFI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763058020; c=relaxed/simple;
	bh=q4Pni98XzUAF/l2bWun5gxCY4hAH8sNECZ2AvGITWiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bslY5YyUIshYuSCVnygcCG1GwoKpj2SeuZUQdUr11KYywHTLPRwgVEBKg2ZZligTN6U11GlEfVXSulctRUjfetlfxi1O93/JrABnmiFVURWiE8rQt/Zr9tOGou+YLmEQ2U3dxePpErLx1w9VM5WmgF+tHfSI2qXuMHQErJoZ8pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-9372149216bso712782241.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:20:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763058017; x=1763662817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uS/kxH5JVnFFcogceq0XBHqgyC93uzre0sinNeAFlM=;
        b=w7m9cnJE9tbFC7AsYSayqbMgouAj+KWMUiKiEAkNHlTzOsLqF5dhXfY1RiLV60/s4U
         b9W3Nf+SQzZsirjWJp+DZYiqQcKPqBM8Kk9qavlzVmBJM9gIHOV7jPXSB4v2P8iWmyId
         L0rQBUSW6z3o9hskw5VJ0+DRkUCcP+E/pm9QHDNrnwAMhelpkwAOTZg1zE6IdByOnQsM
         xuh6gfOKZFv7qvU+FL6Jy7wXTq5Hz4Jo61OZEAxY6PLYpQ/nhWBP9IDifUvtoN+MYP/4
         qTOrVa7/O1Kc0pUL9JkQpOZUZXB3nE/W3bqv4HF0XKq1Hw3O8kwrZUIYAEJFT6OhORsE
         lJVA==
X-Forwarded-Encrypted: i=1; AJvYcCXzm4H5CaRC+rtwpDoEQFhkpud7xMqBMN+RQxXJhNLo1LLrE1bIuq8NOG1nASOkN6S5lA6nLidyozpui0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztis7zzs0ysTJlsZv6cMC+LFuLGXuf/oe4vvXcfjH7es+DTPTr
	9J4gGtLZ3MKiQnZeXRYU7ztG5pFlewBqcZaGE/p2RacYB5EEP7Pz1+IB6+J7nZ1YXww=
X-Gm-Gg: ASbGncuhJiuHlAiOafI81V5VzRIadVljvXjzTKJnt2PQ+4VkQMt57+gIGQsmKrlucAr
	VA3lOXqWG3faR/awF18+A7Fs+Ir+I4eWLqhbER0cZxqvGtOn5eAiLPAHOxKCixKm+VpN3XT4liX
	/k561E2oRUlln6xGCVJeGLfPlOB2GFX/Fh/5NUkAlRsUfW8++6nxNOkRI/eVeJZnoWVEq8Gselg
	8aMx8NJm9JjE/yJOfIcNSF/eML/3oP1tnQWf0eGrsoa0wlNd8foFdik6AybFKad27aYhnlKkDQh
	fA/bjU61I7mrxcpc4aC7KpP2I3tVJzSU9o3KgnWfydqzwGeE0mugTtQF3o9W6tVKk9cPebQTD1k
	6ktsVZcQ8fHdM3H/+1SEdWjou1WQSrNlR6qO77+BftU+yIYaxPj22iz3dqGc4jSswcKvJCtPCPq
	JL7Qa7Smdr9h7A+eiw33MJYobc0LL78Dshmm6L7w==
X-Google-Smtp-Source: AGHT+IEdAARMuWjZd4jv6hrluAAALk/kXJGKeqLfP6ZFhn0Qv1uRHVIySJ6VmMaZ7IQ2b8VYTrcYEA==
X-Received: by 2002:a05:6102:38ce:b0:5db:9ab3:4291 with SMTP id ada2fe7eead31-5dfc5a687f8mr401784137.33.1763058017403;
        Thu, 13 Nov 2025 10:20:17 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93761104ee4sm820710241.5.2025.11.13.10.20.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 10:20:17 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5dfa9c01c54so673907137.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:20:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUKBVazp8w+XOnESuYdTr+tBFeSEc+6/bXDunAubV5Pf4dCULngbR57PkVzJKHKyuOUiRBbLZp2esnxKsM=@vger.kernel.org
X-Received: by 2002:a05:6102:94b:b0:5db:ef7e:8dc9 with SMTP id
 ada2fe7eead31-5dfc5651308mr396910137.22.1763058016686; Thu, 13 Nov 2025
 10:20:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027154615.115759-1-biju.das.jz@bp.renesas.com> <20251027154615.115759-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251027154615.115759-2-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2025 19:20:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX4YxaU4KQoAF+hhfOfqGtRH-xSRgNqLp8dyEU29z5z1g@mail.gmail.com>
X-Gm-Features: AWmQ_bleUQW3hiCX1KSxLvD3JgUUV41Fe_nAwW--UKlxTY2D9OsiAP6kBwTqJBI
Message-ID: <CAMuHMdX4YxaU4KQoAF+hhfOfqGtRH-xSRgNqLp8dyEU29z5z1g@mail.gmail.com>
Subject: Re: [PATCH 01/19] clk: renesas: r9a09g047: Add RSCI clocks/resets
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Mon, 27 Oct 2025 at 16:46, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Add RSCI clock and reset entries.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/clk/renesas/r9a09g047-cpg.c
> +++ b/drivers/clk/renesas/r9a09g047-cpg.c
> @@ -218,6 +224,106 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[] __initconst = {
>                                                 BUS_MSTOP(5, BIT(13))),
>         DEF_MOD("wdt_3_clk_loco",               CLK_QEXTAL, 5, 2, 2, 18,
>                                                 BUS_MSTOP(5, BIT(13))),
> +       DEF_MOD("rsci0_pclk",                   CLK_PLLCM33_DIV16, 5, 13, 2, 29,
> +                                               BUS_MSTOP(11, BIT(3))),
> +       DEF_MOD("rsci0_tclk",                   CLK_PLLCM33_DIV16, 5, 14, 2, 30,
> +                                               BUS_MSTOP(11, BIT(3))),

According to both the clock list and the clock system diagram, the
parent clock of rsciN_pclk and rsciN_tclk is CLK_PLLCLN_DIV16?

The rest LGTM, so with the above clarified:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

