Return-Path: <linux-kernel+bounces-900071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FB2C59855
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CECB3341128
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671A8311C1B;
	Thu, 13 Nov 2025 18:39:39 +0000 (UTC)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A897262D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763059179; cv=none; b=u9H+qppg3mgxXqs7WryMj4mI1LmYx+cInDbKyAqQXLpcnfq1NdcR0+ERtA/ci5eVQTFSzCiFAB0iHZ7BEcHDf+AUsnZfzgktrpzrakHIsSiiMRVpGPvWJkLlyecCh5gXQepLma/P3H7wa+J8B43zNnUsReiG9Q13erwSrgNDu4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763059179; c=relaxed/simple;
	bh=3c0sAkDQu1qBVzE7td1x+QSCl8WUFk7pNS0yIvPZ3RM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lcYyS/+kNR8BQlrf7zEgVEm+oUIv/4voCRhAyehpoturYkyCY4cMTrh1KrRxIksPkJR6+kifPorJkUahTIfeUQBopbsz18LDZoyk1sbX4o+C16+1AZthIKpJWtRm/6RuLyDvJXjA+3AZutaVNiy4GZHJrWj94KsL7HMcWy3xl5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5d61f261ebfso418689137.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:39:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763059176; x=1763663976;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fn33ddPk9bS9PgY509eYuCfPPBWfLh0ylYRDGrpE/Zo=;
        b=WO/aAdQ9NnOg/ZoPG5Joa51oWlzDxuw6PJlZ7fL263HfxnY2trGdj+C+reRMORt0bg
         h+eYHZlYYFOEOdh8I/SKUeafJQHjEkojHCnlP59KdwHmIieDpVA5V13Ms1DZD2M0xGFD
         md5+Bj8ti6Y7juPem80Yh3aSGlJAI5gwrbfUjRf5mKfC31N3n0y5JAFGsm4WZ7tTZanH
         wuaNs2G6Dahn+m4m9tuT6ZZoPaC5VoxB73XdX/JSsQXRcxyNLEsPPGkXw0YBqblLoafL
         HKbW/86PZFqXPdbXgy0AyiBkdP6QwSuVfaLnF9kyhq1s5sspwMHp1PHJBGtKYWmtx/iJ
         rNqw==
X-Forwarded-Encrypted: i=1; AJvYcCUW3hlDp7pbLZmUSmrpTZyS/s05ydK8ZEHq0hfvuNz7NXex2aaFiJKAleZ28TDMzEgP+xOWhghphQRbk98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/dS4+wz2Px79st2ongMV2ehV7wA+z3sl8qAi4zuAyYoohwSns
	XIvJM4/8BY/k5HBF8XKknwo7QV3nLBkU5NzQlkWw9asWqyNSX1ynVNXcQAx7ZOiZzyY=
X-Gm-Gg: ASbGnctVO1tr+TBs7WYsPbB4EWXSTAfjynhGWf27WDr4k/xsi+ECHYiVOZnYAocMBtM
	chrHLFMuRiba9z5MD0cNka8E5MOt187jSNJ1SVbvfGrW3UFmDYvw0kWzQzQGQFdeK92Ti6KoSEN
	8hXNjINWd+l52/XkdCGUI/KFAX9NoLPU6A9Q2YDIxutsyM5i6Z9aJ1KS9X3JrD1nTOoKHjUiRkI
	RNjGmHaDA0LufD3/YprRmVz4uVk1/usltxbve4A4G9IgGXqrmGDkrU/RjLEyf2Am9e69YdFDxzM
	jKIulL8vOZfWycmJn0IxxBaxzQGYRI5wDWqk/+zyuqCN1DaBKqs/X2ZfxxXBCG2CUC4cgNQRUGu
	qpSyKURrPpjCulbTKC9MaWqJsDAE6MXRnYF4APJF4dOiUXr9CFEzOUNMOQgZLlfsLK5+bVEpXTS
	YptKvqBOEQE+YbGUXZM8zuqLHQW9RB1x3fSYQWmw==
X-Google-Smtp-Source: AGHT+IEs8r4aAqnjilut3Hs3+1wjd4vorbup6qSa5yuSS2eLaYjy5UcLjHryAQWzpgXDd/oCRGQTPQ==
X-Received: by 2002:a05:6102:3583:b0:5dd:85b8:d82b with SMTP id ada2fe7eead31-5dfc5546b3dmr375752137.14.1763059176104;
        Thu, 13 Nov 2025 10:39:36 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b0f4426a5sm918683e0c.12.2025.11.13.10.39.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 10:39:35 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5ddc5a5edfdso405508137.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:39:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXPiQhpSB8cdobQB96oy7nnBrMV/icVnkmmldd7f2wzesIGokDLXOPzXT3ljjS0eFWTuKUyT7o8RSJfjdw=@vger.kernel.org
X-Received: by 2002:a05:6102:4b88:b0:5db:eeb6:812c with SMTP id
 ada2fe7eead31-5dfc5b96e0amr374019137.43.1763059175404; Thu, 13 Nov 2025
 10:39:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105104151.1489281-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251105104151.1489281-2-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251105104151.1489281-2-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2025 19:39:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXEjnPWzwLF49ryooEUPNeLtXEuHDipcCMq=wsXN=zD_Q@mail.gmail.com>
X-Gm-Features: AWmQ_blsF688r-SQvCXnNFqKgHzgSK8u69yJh9wFop3IkqSYjXU8VHfHFzFl3OY
Message-ID: <CAMuHMdXEjnPWzwLF49ryooEUPNeLtXEuHDipcCMq=wsXN=zD_Q@mail.gmail.com>
Subject: Re: [PATCH v3 01/14] clk: renesas: r9a09g077: add SPI module clocks
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, linux-spi@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Cosmin,

On Wed, 5 Nov 2025 at 11:43, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have four SPI
> peripherals, each with their own clock divider, which divides PLL4 by
> either 24, 25, 30 or 32, similar to the SCI peripheral.
>
> The dividers feed into the usual module clocks.
>
> Add them all.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Thanks for your patch!

> --- a/drivers/clk/renesas/r9a09g077-cpg.c
> +++ b/drivers/clk/renesas/r9a09g077-cpg.c
> @@ -54,6 +54,11 @@
>  #define DIVSCI3ASYNC   CONF_PACK(SCKCR3, 12, 2)
>  #define DIVSCI4ASYNC   CONF_PACK(SCKCR3, 14, 2)
>
> +#define DIVSPI0ASYNC   CONF_PACK(SCKCR3, 0, 2)
> +#define DIVSPI1ASYNC   CONF_PACK(SCKCR3, 2, 2)
> +#define DIVSPI2ASYNC   CONF_PACK(SCKCR3, 4, 2)
> +#define DIVSPI3ASYNC   CONF_PACK(SCKCR2, 16, 2)

I'll move these up while applying, so all SCKCR2 and SCKCR3 definitions
are grouped and sorted.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

