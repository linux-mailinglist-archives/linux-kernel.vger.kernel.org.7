Return-Path: <linux-kernel+bounces-893624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6672DC47EDB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B703A5169
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442DE27586C;
	Mon, 10 Nov 2025 16:16:45 +0000 (UTC)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F23274659
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762791404; cv=none; b=iF4Xoa42Lto1O/amWcoSPV7wAI6TfHhAOtRXVHgffPyENZ2txobVrNbj4rhrCSOFwMc4DAtSQ7um88Mgpm5Tbi4vY4UX75UWWJDNMtSRSOwAtr1PgDT3435L13kdpYQ7XB+beu7bA+qFnnKQFuIcgotYDku3bUQG4DRtewtmJtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762791404; c=relaxed/simple;
	bh=Oj+MACFttgL4DFd5A7ViUQbdwBnwgGwGclfbbcanDRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFvbB8MCognaGDDZxPeH5HWCe5yl7rYiJoI6u/rCbqBaGbFufBw/96ebwvFZs8X6se/lt36yLTQVV6yL3GTTcoZex1wESbElK9GyeA7VZpvZJ/wVGZicQG4vYhlhw4kbIPH/+jc6a97T0qhC4YtLuK8qMnLI9Bg3VdvY1W9Su7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5dd83dec0b3so1077915137.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:16:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762791399; x=1763396199;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/lLSXjoHK4s9dqtzRhXw91kDvxvE9lMfjhCOgxWsIE=;
        b=R9gdW8S4EUPViBu2UWnMRwVfw9RuyuRQSCt6D0Z0/il6naaOSS4b7On5t038RL8Vtl
         yjX4gWOyGmM+DmPcOWrKFWshhSdRNpXvAzFfg0lC9dh8cX5RIOpyoeLIYYizmfkxb2wp
         EWLq77qFbBssLrVdoXN/uYsEClxTboKAfSSdYqgnB9H2d7Tf+2Z8BFb2QDSKeYwxIlei
         XQlNfmEyQ4I9kvx2rvG248tNLlealUqqdMb4O7ykMdczmNU26Tb3tbp9Tjf52KnAhzYW
         J6e2U9H6yGpHtW++GtxoVxZL/DhRn4zBUoKpGsCCMVPTb3C9X03vPHnd0TyJcdevH+xj
         /HlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsJabghm0rev7cUpEyIjb6xOBAxdL0MOfuGMqaxvqXbJowUNIR5GZQRvAFqYMaOxVqj1b2uR0jOKLNYlY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8k8oIsiTKCTJPZTWu0WUcMd4KhD3+Vlb3dmhWst8zY3VD+9Rp
	tNbCVXqIRthddsRb5nhwTZnAVNuf/r3pU6cERjQsO1q5fNRU9Au5byz3mRVyxYY0
X-Gm-Gg: ASbGncvXyvWDkFJlZy/lPyWwHpjTaVF4CPdWV8FmW5K8ccgcOiT3twljaQRVdEruqb1
	7O2iK1Xvg9xuivivxM0E98SsvRCU5cuEI43WHSlLiHsYKAEtxQQJ9czKv3L2ijeo4O6jSp5eHCW
	I3YbeTk1l2Scjybj8H0GNrmJ5IsbzQuYH/mHYNV0ONuXC4sKmBqyZ9618Gov5OPgsN2cICgjxqS
	U0os9+BOK/HvqbUqA+72/QSmxlFsQ87K7CLF7BJ4krgrOxWS2s2wad1ey54baY4x+6ZbZiXL5SG
	kYxTVnblcuA5jLKEpLo8mme8U0Ew0/hmY0JDSG8pgcGUDuLa9nWDuyN2zs9iCoy1E7rkMkBd4OK
	tyQOmVhJmsg2zYYUs+y/QHaobGtLyaJQWLPU6ejbAgTMyFz92UygBOdyXQcjCFNIrT5Y5StIL93
	ROtx71xYRazk4wqJhlRYBllSgjEv+as9ZS62xGtA==
X-Google-Smtp-Source: AGHT+IF37kxSnPyJmh+h1If5kTzpanXRC3sMh19WRSwypZoR/t0iItkakbUtB8JdbQ/AIuwZFWTK0w==
X-Received: by 2002:a05:6102:3584:b0:5dd:8819:e68a with SMTP id ada2fe7eead31-5ddc477e66fmr2606800137.36.1762791398795;
        Mon, 10 Nov 2025 08:16:38 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93708522abcsm6063712241.0.2025.11.10.08.16.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 08:16:38 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5dbe6304b79so1245124137.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:16:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUxDrtKYYm93ruTgw5z3rlx6ssW+hzWKy/kBEW0W78T+0H7XGAwm6ZoXleqz3I/T+PLeFXpXK0/MeGzo4U=@vger.kernel.org
X-Received: by 2002:a05:6102:3706:b0:5db:debf:658f with SMTP id
 ada2fe7eead31-5ddc4677cafmr2517889137.19.1762791398206; Mon, 10 Nov 2025
 08:16:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028175458.1037397-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251028175458.1037397-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251028175458.1037397-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2025 17:16:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU4YTdy7zCiTyYbTY_t84q_xjjf0+XpDcyuGqB-zv6r5g@mail.gmail.com>
X-Gm-Features: AWmQ_bnUV9390k-yS-D893D2ukJvmbPbtHpKrPkw-Xw6URCIb2kBicAa71zpzl8
Message-ID: <CAMuHMdU4YTdy7zCiTyYbTY_t84q_xjjf0+XpDcyuGqB-zv6r5g@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: renesas: rzt2h-n2h-evk: Enable
 Ethernet support
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Prabhakar,

On Tue, 28 Oct 2025 at 18:55, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Enable Ethernet support on the RZ/T2H and RZ/N2H EVKs.
>
> Configure the MIIC converter in mode 0x6:
>   Port 0 <-> ETHSW Port 0
>   Port 1 <-> ETHSW Port 1
>   Port 2 <-> GMAC2
>   Port 3 <-> GMAC1
>
> Enable the ETHSS, GMAC1 and GMAC2 nodes. ETHSW support will be added
> once the switch driver is available.
>
> Configure the MIIC converters to map ports according to the selected
> switching mode, with converters 0 and 1 mapped to switch ports and
> converters 2 and 3 mapped to GMAC ports.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

I found the mapping between GMACx, ETHy, PHYz, and board connector
rather hard to follow.  Some suggestions for improvement are included
below...

> --- a/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
> +++ b/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
> @@ -149,7 +149,77 @@ &i2c1 {
>         status = "okay";
>  };
>
> +&phy2 {
> +       /*
> +        * PHY2 Reset Configuration:
> +        *
> +        * SW6[1] = OFF; SW6[2] = ON; SW6[3] = OFF;
> +        * P17_5 is used as GMAC_RESETOUT2#
> +        */
> +       reset-gpios = <&pinctrl RZT2H_GPIO(17, 5) GPIO_ACTIVE_LOW>;
> +};
> +
> +&phy3 {
> +       reset-gpios = <&pinctrl RZT2H_GPIO(32, 3) GPIO_ACTIVE_LOW>;
> +};
> +
>  &pinctrl {
> +       /*
> +        * ETH2 Pin Configuration:
> +        *
> +        * SW2[6] = OFF: MDC and MDIO of Ethernet port 2 are connected to GMAC2
> +        * SW2[7] = ON:  Pins P29_1-P29_7, P30_0-P30_4, and P31_2-P31_5 are used for Ethernet port 2

Please split this long line.

> +        */
> +       eth2_pins: eth2-pins {

Perhaps s/eth2/gmac2/, to make the mapping easier to follow?

> +               pinmux = <RZT2H_PORT_PINMUX(29, 1, 0xf)>, /* ETH2_TXCLK */
> +                        <RZT2H_PORT_PINMUX(29, 2, 0xf)>, /* ETH2_TXD[0] */
> +                        <RZT2H_PORT_PINMUX(29, 3, 0xf)>, /* ETH2_TXD[1] */
> +                        <RZT2H_PORT_PINMUX(29, 4, 0xf)>, /* ETH2_TXD[2] */
> +                        <RZT2H_PORT_PINMUX(29, 5, 0xf)>, /* ETH2_TXD[3] */

The documentation doesn't use square brackets in the signal names.

> +                        <RZT2H_PORT_PINMUX(29, 6, 0xf)>, /* ETH2_TXEN */
> +                        <RZT2H_PORT_PINMUX(29, 7, 0xf)>, /* ETH2_RXCLK */
> +                        <RZT2H_PORT_PINMUX(30, 0, 0xf)>, /* ETH2_RXD[0] */
> +                        <RZT2H_PORT_PINMUX(30, 1, 0xf)>, /* ETH2_RXD[1] */
> +                        <RZT2H_PORT_PINMUX(30, 2, 0xf)>, /* ETH2_RXD[2] */
> +                        <RZT2H_PORT_PINMUX(30, 3, 0xf)>, /* ETH2_RXD[3] */
> +                        <RZT2H_PORT_PINMUX(30, 4, 0xf)>, /* ETH2_RXDV */
> +                        <RZT2H_PORT_PINMUX(31, 2, 0xf)>, /* ETH2_TXER */
> +                        <RZT2H_PORT_PINMUX(31, 3, 0xf)>, /* ETH2_RXER */
> +                        <RZT2H_PORT_PINMUX(31, 4, 0xf)>, /* ETH2_CRS */
> +                        <RZT2H_PORT_PINMUX(31, 5, 0xf)>, /* ETH2_COL */
> +                        <RZT2H_PORT_PINMUX(30, 5, 0x10)>, /* ETH2_MDC */
> +                        <RZT2H_PORT_PINMUX(30, 6, 0x10)>, /* ETH2_MDIO */

The documentation calls these GMAC2_{MDC,MDIO}.

> +                        <RZT2H_PORT_PINMUX(31, 0, 0x02)>; /* ETH2_REFCLK */

Please settle on a common convention for formatting pinmux settings:
either use 0x2 here (no leading zero), or 0x0f in the other entries.

> +       };
> +
> +       /*
> +        * ETH3 Pin Configuration:
> +        *
> +        * SW2[8] = ON, P27_2, P33_2-P33_7, P34_0-P34_5, P34_7 and P35_0-P35_5

P27_2 and P35_3-P35_5 don't seem to be muxed by SW2[8]?

> +        * are used for Ethernet port 3
> +        */
> +       eth3_pins: eth3-pins {
> +               pinmux = <RZT2H_PORT_PINMUX(33, 2, 0xf)>, /* ETH3_TXCLK */
> +                        <RZT2H_PORT_PINMUX(33, 3, 0xf)>, /* ETH3_TXD[0] */
> +                        <RZT2H_PORT_PINMUX(33, 4, 0xf)>, /* ETH3_TXD[1] */
> +                        <RZT2H_PORT_PINMUX(33, 5, 0xf)>, /* ETH3_TXD[2] */
> +                        <RZT2H_PORT_PINMUX(33, 6, 0xf)>, /* ETH3_TXD[3] */
> +                        <RZT2H_PORT_PINMUX(33, 7, 0xf)>, /* ETH3_TXEN */
> +                        <RZT2H_PORT_PINMUX(34, 0, 0xf)>, /* ETH3_RXCLK */
> +                        <RZT2H_PORT_PINMUX(34, 1, 0xf)>, /* ETH3_RXD[0] */
> +                        <RZT2H_PORT_PINMUX(34, 2, 0xf)>, /* ETH3_RXD[1] */
> +                        <RZT2H_PORT_PINMUX(34, 3, 0xf)>, /* ETH3_RXD[2] */
> +                        <RZT2H_PORT_PINMUX(34, 4, 0xf)>, /* ETH3_RXD[3] */
> +                        <RZT2H_PORT_PINMUX(34, 5, 0xf)>, /* ETH3_RXDV */
> +                        <RZT2H_PORT_PINMUX(34, 7, 0xf)>, /* ETH3_TXER */
> +                        <RZT2H_PORT_PINMUX(35, 0, 0xf)>, /* ETH3_RXER */
> +                        <RZT2H_PORT_PINMUX(35, 1, 0xf)>, /* ETH3_CRS */
> +                        <RZT2H_PORT_PINMUX(35, 2, 0xf)>, /* ETH3_COL */
> +                        <RZT2H_PORT_PINMUX(26, 1, 0x10)>, /* ETH3_MDC */
> +                        <RZT2H_PORT_PINMUX(26, 2, 0x10)>, /* ETH3_MDIO */
> +                        <RZT2H_PORT_PINMUX(34, 6, 0x02)>; /* ETH3_REFCLK */
> +       };
> +
>         /*
>          * I2C0 Pin Configuration:
>          * ------------------------
> diff --git a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
> index d698b6368ee7..7ebc89bafaf1 100644
> --- a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
> +++ b/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
> @@ -186,7 +186,86 @@ &i2c1 {
>         status = "okay";
>  };
>
> +&phy2 {
> +       /*
> +        * PHY2 Reset Configuration:
> +        *
> +        * DSW8[1] = ON; DSW8[2] = OFF
> +        * DSW12[7] = OFF; DSW12[8] = ON
> +        * P03_1 is used as GMAC_RESETOUT2#
> +        */
> +       reset-gpios = <&pinctrl RZT2H_GPIO(3, 1) GPIO_ACTIVE_LOW>;
> +};
> +
> +&phy3 {
> +       /*
> +        * PHY3 Reset Configuration:
> +        *
> +        * DSW12[5] = OFF; DSW12[6] = ON
> +        * P03_2 is used as GMAC_RESETOUT3#
> +        */
> +       reset-gpios = <&pinctrl RZT2H_GPIO(3, 2) GPIO_ACTIVE_LOW>;
> +};
> +
>  &pinctrl {
> +       /*
> +        * ETH2 Pin Configuration:
> +        *
> +        * DSW5[6] = OFF, P21_4-P21_5 are used for Ethernet port 2

MDC and MDIO of Ethernet port 2 are connected to GMAC2

> +        * DSW5[7] = ON, P29_1-P29_7, P30_0-P30_4, P30_7, P31_2, P31_4
> +        * and P31_5 are used for Ethernet port 2
> +        */
> +       eth2_pins: eth2-pins {

Perhaps s/eth2/gmac2/, to make the mapping easier to follow?

> +               pinmux = <RZT2H_PORT_PINMUX(29, 1, 0xf)>, /* ETH2_TXCLK */
> +                        <RZT2H_PORT_PINMUX(29, 2, 0xf)>, /* ETH2_TXD[0] */
> +                        <RZT2H_PORT_PINMUX(29, 3, 0xf)>, /* ETH2_TXD[1] */
> +                        <RZT2H_PORT_PINMUX(29, 4, 0xf)>, /* ETH2_TXD[2] */
> +                        <RZT2H_PORT_PINMUX(29, 5, 0xf)>, /* ETH2_TXD[3] */
> +                        <RZT2H_PORT_PINMUX(29, 6, 0xf)>, /* ETH2_TXEN */
> +                        <RZT2H_PORT_PINMUX(29, 7, 0xf)>, /* ETH2_RXCLK */
> +                        <RZT2H_PORT_PINMUX(30, 0, 0xf)>, /* ETH2_RXD[0] */
> +                        <RZT2H_PORT_PINMUX(30, 1, 0xf)>, /* ETH2_RXD[1] */
> +                        <RZT2H_PORT_PINMUX(30, 2, 0xf)>, /* ETH2_RXD[2] */
> +                        <RZT2H_PORT_PINMUX(30, 3, 0xf)>, /* ETH2_RXD[3] */
> +                        <RZT2H_PORT_PINMUX(30, 4, 0xf)>, /* ETH2_RXDV */
> +                        <RZT2H_PORT_PINMUX(31, 2, 0xf)>, /* ETH2_TXER */
> +                        <RZT2H_PORT_PINMUX(31, 3, 0xf)>, /* ETH2_RXER */

31, 1, 0xf

> +                        <RZT2H_PORT_PINMUX(31, 4, 0xf)>, /* ETH2_CRS */
> +                        <RZT2H_PORT_PINMUX(31, 5, 0xf)>, /* ETH2_COL */
> +                        <RZT2H_PORT_PINMUX(30, 5, 0x10)>, /* ETH2_MDC */
> +                        <RZT2H_PORT_PINMUX(30, 6, 0x10)>, /* ETH2_MDIO */

The documentation calls these GMAC2_{MDC,MDIO}.

> +                        <RZT2H_PORT_PINMUX(31, 0, 0x02)>; /* ETH2_REFCLK */

> +
> +       };
> +
> +       /*
> +        * ETH3 Pin Configuration:
> +        *
> +        * DSW5[8] = ON, P00_0-P00_2, P33_2-P33_7, P34_0-P34_6, are used for Ethernet port 3
> +        * DSW12[1] = OFF;DSW12[2] = ON, P00_3 is used for Ethernet port 3
> +        */
> +       eth3_pins: eth3-pins {

Perhaps s/eth3/gmac1/, to make the mapping easier to follow?

> +               pinmux = <RZT2H_PORT_PINMUX(33, 2, 0xf)>, /* ETH3_TXCLK */
> +                        <RZT2H_PORT_PINMUX(33, 3, 0xf)>, /* ETH3_TXD[0] */
> +                        <RZT2H_PORT_PINMUX(33, 4, 0xf)>, /* ETH3_TXD[1] */
> +                        <RZT2H_PORT_PINMUX(33, 5, 0xf)>, /* ETH3_TXD[2] */
> +                        <RZT2H_PORT_PINMUX(33, 6, 0xf)>, /* ETH3_TXD[3] */
> +                        <RZT2H_PORT_PINMUX(33, 7, 0xf)>, /* ETH3_TXEN */
> +                        <RZT2H_PORT_PINMUX(34, 0, 0xf)>, /* ETH3_RXCLK */
> +                        <RZT2H_PORT_PINMUX(34, 1, 0xf)>, /* ETH3_RXD[0] */
> +                        <RZT2H_PORT_PINMUX(34, 2, 0xf)>, /* ETH3_RXD[1] */
> +                        <RZT2H_PORT_PINMUX(34, 3, 0xf)>, /* ETH3_RXD[2] */
> +                        <RZT2H_PORT_PINMUX(34, 4, 0xf)>, /* ETH3_RXD[3] */
> +                        <RZT2H_PORT_PINMUX(34, 5, 0xf)>, /* ETH3_RXDV */
> +                        <RZT2H_PORT_PINMUX(0, 0, 0xf)>, /* ETH3_TXER */
> +                        <RZT2H_PORT_PINMUX(0, 1, 0xf)>, /* ETH3_RXER */
> +                        <RZT2H_PORT_PINMUX(0, 2, 0xf)>, /* ETH3_CRS */
> +                        <RZT2H_PORT_PINMUX(0, 3, 0xf)>, /* ETH3_COL */
> +                        <RZT2H_PORT_PINMUX(26, 1, 0x10)>, /* ETH3_MDC */
> +                        <RZT2H_PORT_PINMUX(26, 2, 0x10)>, /* ETH3_MDIO */

The documentation calls these GMAC1_{MDC,MDIO}.

> +                        <RZT2H_PORT_PINMUX(34, 6, 0x02)>; /* ETH3_REFCLK */
> +       };
> +
>         /*
>          * I2C0 Pin Configuration:
>          * ------------------------
> diff --git a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
> index 924a38c6cb0f..c608d97586ff 100644
> --- a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
> @@ -7,10 +7,14 @@
>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/leds/common.h>
> +#include <dt-bindings/net/mscc-phy-vsc8531.h>
> +#include <dt-bindings/net/renesas,r9a09g077-pcs-miic.h>
>  #include <dt-bindings/pinctrl/renesas,r9a09g077-pinctrl.h>
>
>  / {
>         aliases {
> +               ethernet0 = &gmac1;

Is this the port labeled "Ethernet(ETH3) Connector" in the Board's
User Manual?  Shouldn't that be "ethernet3"?

> +               ethernet1 = &gmac2;

Is this the port labeled "Ethernet(ETH2) Connector" in the Board's
User Manual?  Shouldn't that be "ethernet2"?

>                 i2c0 = &i2c0;
>                 i2c1 = &i2c1;
>                 mmc0 = &sdhi0;
> @@ -70,10 +74,34 @@ &ehci {
>         status = "okay";
>  };
>
> +&ethss {
> +       status = "okay";
> +
> +       renesas,miic-switch-portin = <ETHSS_GMAC0_PORT>;
> +};
> +
>  &extal_clk {
>         clock-frequency = <25000000>;
>  };
>
> +&gmac1 {
> +       pinctrl-0 = <&eth3_pins>;
> +       pinctrl-names = "default";
> +       phy-handle = <&phy3>;
> +       phy-mode = "rgmii-id";
> +       pcs-handle = <&mii_conv3>;
> +       status = "okay";
> +};
> +
> +&gmac2 {
> +       pinctrl-0 = <&eth2_pins>;
> +       pinctrl-names = "default";
> +       phy-handle = <&phy2>;
> +       phy-mode = "rgmii-id";
> +       pcs-handle = <&mii_conv2>;
> +       status = "okay";
> +};
> +
>  &hsusb {
>         dr_mode = "otg";
>         status = "okay";
> @@ -87,6 +115,48 @@ eeprom: eeprom@50 {
>         };
>  };
>
> +&mdio1 {
> +       phy3: ethernet-phy@3 {

Ah, the "3" corresponds to the PHY address in this mdio node...
Perhaps "mdio1_phy", to make it easier to match mdio and phy nodes?

> +               compatible = "ethernet-phy-id0007.0772", "ethernet-phy-ieee802.3-c22";
> +               reg = <3>;
> +               vsc8531,led-0-mode = <VSC8531_LINK_ACTIVITY>;

VSC8531_ACTIVITY?

> +               vsc8531,led-1-mode = <VSC8531_LINK_ACTIVITY>;
> +               reset-assert-us = <2000>;
> +               reset-deassert-us = <15000>;
> +       };
> +};
> +
> +&mdio2 {
> +       phy2: ethernet-phy@2 {

mdio2_phy?

> +               compatible = "ethernet-phy-id0007.0772", "ethernet-phy-ieee802.3-c22";
> +               reg = <2>;
> +               vsc8531,led-0-mode = <VSC8531_LINK_ACTIVITY>;

VSC8531_ACTIVITY?

> +               vsc8531,led-1-mode = <VSC8531_LINK_ACTIVITY>;
> +               reset-assert-us = <2000>;
> +               reset-deassert-us = <15000>;
> +       };
> +};
> +
> +&mii_conv0 {
> +       renesas,miic-input = <ETHSS_ETHSW_PORT0>;
> +       status = "okay";
> +};
> +
> +&mii_conv1 {
> +       renesas,miic-input = <ETHSS_ETHSW_PORT1>;
> +       status = "okay";
> +};
> +
> +&mii_conv2 {
> +       renesas,miic-input = <ETHSS_GMAC2_PORT>;
> +       status = "okay";
> +};
> +
> +&mii_conv3 {
> +       renesas,miic-input = <ETHSS_GMAC1_PORT>;
> +       status = "okay";
> +};
> +
>  &ohci {
>         dr_mode = "otg";
>         status = "okay";

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

