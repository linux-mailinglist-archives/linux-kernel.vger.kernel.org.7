Return-Path: <linux-kernel+bounces-818904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2284BB597DC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2BF51624E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840C7313297;
	Tue, 16 Sep 2025 13:38:41 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C6331326B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758029921; cv=none; b=Sv7N5cDOCwHPZazkAaqs5RZmkeldPifOXtljAidlpkQZ5wVbrRVUg9Sga7jySdYv5AIhT4+CvfUA/YP1HWjP4t7+S28VOdCk40CH6/dkygvq6jkhjgsTvWQoxiwYeeFaOuoin5Iyw90N+CxE1DlwCSOK84EhJ7hZRYFsX0GZhAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758029921; c=relaxed/simple;
	bh=lRwGS+EzOykdHSjihfKZFNIAo3QDxUC71G1I5pU5mBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcEvUSV9LQq8dZRAoB8zwe5EyTLOYxYtbU2jCvwDSHfgK6hC+iL+GYXSpMNwSjCZo6L+MW/GKURKwE48++xLpJom1LUxarJj2mafYBqYGxPSL63SkmPt9m3cpkwXcwjrOcF+MfE90Jp7FH+25FK1DTGkskPWX1Mmb/HZcFkkfU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-77d253914d0so19262896d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758029918; x=1758634718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDQooxDkD5fz4sLWBIH6i0SDIPVUTbpTi303GssaIAI=;
        b=nlPDYsl62ZyB/KUiiFq3Wa7vShTg9nQ19bXNQoa1pcQtygdxsqxG/r7LYQxZmqI4Sh
         f6mwY+pAkz3N2PcARpzulEwGpuV59wqSLJYwwKZp8ldx/WovCuYYMhEHaFOoDeAN346N
         IFWC8tBK/3nq/vp04dc750vwGI21HZL2ixhpFTxzlZuCB8hOMLH0fYp9Nft8ahzjHyRM
         0IYQEcUOxNfRvIBomnZnH5AAXYWe3/ZHpL/aADw0Rvc6A4JownTuXk/xc6hL1Ov+/nC7
         NtRjFIzGZ4ujcQ1gqDXYhAaTMsVL+E+JOyQfpSXOasubz/s/pC+4pWc3FzE29jO6fOCO
         ycsg==
X-Forwarded-Encrypted: i=1; AJvYcCW5YPQNkfgxnW47U+8l7Ij+cPy2XuPB+Sxt1MpBiAjmTSfuhFbvfwpyLG/ElgF+rgAumZ/ewWCHl/A/tZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRo7wu0dyw36DXHPeDaEfRZz5tRElliEpv2SkzNwgVxEdtjnOY
	0dMlSBVQk8OzvRZqRRh/7Psubd5zfFVc4De3LyKYhOTy4WkpN4hc/uxtQs+aZcsE
X-Gm-Gg: ASbGnctXfQrtU70Qns3ZL1ziMLQ4shWLmAuotXnNgcQD3uSObS+gVa5FYvM2TfOKM1u
	NaeXh2ulsiSBtVCLAn4Y/sltctYA2FLuPQdOtoLKjpaliq40nGOKHKR5B0S6fpZDsk7Brldg0Jy
	U5ACxFn3hjx2yCUx+xon4r+UeMaI7HUKBemjpAVHSLRDYOu6TUn3rm87oEvcyUDORshioALa8EV
	3PeUciVLYKyzSifR4MF7MznH9aAHJ78d1PwJLkZKAa5JEmx9cGg56IYEAl3IeiuJUuMMe3HzJEI
	wuUAg/8Bk/ZVGo83TTo9yWf3s2mLMMgNbO8ubs9LX3zD3QxQkiqg7G3TiiZaNTfkwd4SaJUivI9
	VAcx6P8wEnKeTDOP7/1SMS707b0n54nSEs2lEj41mkqHUSF9fwsJYTaPjtxi1BtHV
X-Google-Smtp-Source: AGHT+IHni7ZsO0r3VLNIrZCFd35biqrcyPNh4ZM0ogaZXP+bS6NaWiYuUHgwb3DquAhp7RD8LCqGfQ==
X-Received: by 2002:a05:6214:400d:b0:786:d65c:1c3e with SMTP id 6a1803df08f44-786d65c1c6bmr77176846d6.30.1758029917964;
        Tue, 16 Sep 2025 06:38:37 -0700 (PDT)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com. [209.85.222.177])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-763b549866dsm94221736d6.19.2025.09.16.06.38.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 06:38:37 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-826311c1774so384090185a.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:38:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVe4O4VLkS1JZpGWABwq9/lpDcl88tTiby8aXi6uKsTnd0o98sk81vj1JYtUORxuvzjiG09EPMCMJ/OP8c=@vger.kernel.org
X-Received: by 2002:a05:6122:1d8c:b0:53b:174d:98f2 with SMTP id
 71dfb90a1353d-54a16b20009mr5200853e0c.3.1758029474999; Tue, 16 Sep 2025
 06:31:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908105901.3198975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20250908105901.3198975-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <aMlgg_QpJOEDGcEA@monster>
In-Reply-To: <aMlgg_QpJOEDGcEA@monster>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 16 Sep 2025 15:31:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXWVXd5FauMYNq0yXgQa87F4Z9HcGOu2O_ercQg48GNoQ@mail.gmail.com>
X-Gm-Features: AS18NWCih78Z1mvXR97O_iR6cJDURxsOD6O73Iub1rATQe0jxKnm2iY0iJuCAa8
Message-ID: <CAMuHMdXWVXd5FauMYNq0yXgQa87F4Z9HcGOu2O_ercQg48GNoQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] net: stmmac: dwmac-renesas-gbeth: Add
 support for RZ/T2H SoC
To: Anders Roxell <anders.roxell@linaro.org>
Cc: Prabhakar <prabhakar.csengg@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Richard Cochran <richardcochran@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Russell King <linux@armlinux.org.uk>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Anders,

On Tue, 16 Sept 2025 at 15:05, Anders Roxell <anders.roxell@linaro.org> wrote:
> On 2025-09-08 11:59, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Extend the Renesas GBETH stmmac glue driver to support the RZ/T2H SoC,
> > where the GMAC is connected through a MIIC PCS. Introduce a new
> > `has_pcs` flag in `struct renesas_gbeth_of_data` to indicate when PCS
> > handling is required.
> >
> > When enabled, the driver parses the `pcs-handle` phandle, creates a PCS
> > instance with `miic_create()`, and wires it into phylink. Proper cleanup
> > is done with `miic_destroy()`. New init/exit/select hooks are added to
> > `plat_stmmacenet_data` for PCS integration.
> >
> > Update Kconfig to select `PCS_RZN1_MIIC` when building the Renesas GBETH
> > driver so the PCS support is always available.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v2->v3:
> > - Dropped passing STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP flag in stmmac_flags
> >   as it is always set for all the SoCs.
> > - Updated Kconfig to include RZ/T2H and RZ/N2H.
> >
> > v1->v2:
> > - No changes.
>
> The following warning is seen when doing a defconfig build (make
> defconfig) for arm64 on the Linux next-20250915 tag.
>
> First seen on next-20250915
> Good: next-20250912
> Bad: next-20250915
>
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
>
> Build regression: WARNING: unmet direct dependencies detected for PCS_RZN1_MIIC
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> This is the build warning:
> WARNING: unmet direct dependencies detected for PCS_RZN1_MIIC
>   Depends on [n]: NETDEVICES [=y] && OF [=y] && (ARCH_RZN1 [=n] || COMPILE_TEST [=n])
>   Selected by [m]:
>   - DWMAC_RENESAS_GBETH [=m] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_STMICRO [=y] && STMMAC_ETH [=m] && STMMAC_PLATFORM [=m] && OF [=y] && (ARCH_RENESAS [=y] || COMPILE_TEST [=n])
>
> WARNING: unmet direct dependencies detected for PCS_RZN1_MIIC
>   Depends on [n]: NETDEVICES [=y] && OF [=y] && (ARCH_RZN1 [=n] || COMPILE_TEST [=n])
>   Selected by [m]:
>   - DWMAC_RENESAS_GBETH [=m] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_STMICRO [=y] && STMMAC_ETH [=m] && STMMAC_PLATFORM [=m] && OF [=y] && (ARCH_RENESAS [=y] || COMPILE_TEST [=n])
> I: config: PASS in 0:00:01.592356

Thanks for your report!

    config DWMAC_RENESAS_GBETH
        depends on OF && (ARCH_RENESAS || COMPILE_TEST)
        select PCS_RZN1_MIIC

    config PCS_RZN1_MIIC
        depends on ARCH_RZN1 || ARCH_R9A09G077 || ARCH_R9A09G087 || COMPILE_TEST

"ARCH_RENESAS" is wider than "ARCH_RZN1 || ARCH_R9A09G077 || ARCH_R9A09G087".
I would just change the latter to ARCH_RENESAS.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

