Return-Path: <linux-kernel+bounces-757449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC1BB1C244
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7937618A81BB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376592877F9;
	Wed,  6 Aug 2025 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNXN/SdR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C312882BD;
	Wed,  6 Aug 2025 08:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754469424; cv=none; b=j6ePp+Kb+qU6gnXTh541K/ltRRuRYO4VHPmLiQyfNvnz5rlXWfg4oR3ltBI00/GbXqIlqn6kDqibMBQT1yAvtLCwCvAuTuANt94cr4qfOMFPjTM8DjSAtMecVFZnzkeZHm85sZ93jVBnyK6d+yPKQkHZdzAFujLiEjeenRP0yDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754469424; c=relaxed/simple;
	bh=+tM2U507y50uxCWotBt15DsJaGyXiGHGD85A7mY1xPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A05A0LYSvcoVjfer0+JsQ2tVfk80p3JF22bsvjxgid7lRoUWvf/WU9V7J/EM1EN5/ZLBFgU8mLMCFLakVmTofX1Rx7t5RN13QOvUSSNoNHUV75DsdLFwqeZj6qNXER5aU2enqPEaf/3g+ECrYipO6H0aOW9VCqfy7hJM+bfDvIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNXN/SdR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D76C4CEFE;
	Wed,  6 Aug 2025 08:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754469424;
	bh=+tM2U507y50uxCWotBt15DsJaGyXiGHGD85A7mY1xPI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SNXN/SdRx334pPkXDTT/iLUXKF1sMojvcJGySR0DNPHw+SiQGHTxvJbwOnYJRlP5f
	 1wD6i6ImPvAd/YKHkHvmUkM+KQL8ur1wEl0O7Pr/WfYGI3g1fao5ON6Ic+7SQ+uIb2
	 lqQYJECvMCC83zxpGv8Ba3TRf7ttoiGXaXbr3FXiJB6Pfl0H2pqdVfoSiETLxVrGt6
	 +D1tD62+uo/Jw8NuCXqPOoLhn4417KdcDD0ODuqpyNm5VtppXPCw4XycMg5LE0LEi9
	 mOcwa+S7VRdMNP5sF5XZYdo2cLaOHjLluweuRdvpCcivdpJxg+u+NULUPohHlODphS
	 8R02bgFmkfdMw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6153a19dddfso10081678a12.1;
        Wed, 06 Aug 2025 01:37:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUP2NFF0GsCla+gTi5py7Pr+e93MExCtTCNckPx+tPdewA+pCDQNG0rihPY2MkWsye6/fwr7mhfYwjS@vger.kernel.org, AJvYcCUzRKP3gtSjdzwF1X6P5wU/mNXXletrXkwb4Xl535gTW3zqH1GOVx/jQTWaPQ8JpHAIqBFL3bvuoVvP@vger.kernel.org, AJvYcCXdh3qvBoZ4LkucZnAj94O2Ap+nTF73jb3UsTb+ieGonT0an9GhcjApBfM+liLZBr396CCRzKXSCCYeFrSq@vger.kernel.org
X-Gm-Message-State: AOJu0YzrjLd7SbwuT+cDLbpSAm48l1fk7TtuzSHfXJxFPgjVz7tA0dke
	vuujmqitB7hoDJB679dponMWgU5+CVUvQIdF4/PSyImcLHnAO+6U6ItCuwX+5cBnT0x5P1c7Qf2
	nxzerXgPOzgoDtwr+UX6sNB+s09OH1D0=
X-Google-Smtp-Source: AGHT+IFl/Ho99IKjMDHObXC2WzdxXQ2KiWP4Lf4SzO5H9RulUyOOzsY0NvycU94uedohVUFGDJcCDKUwO86IwS3WXW0=
X-Received: by 2002:a50:cd48:0:b0:615:b9cf:ef3b with SMTP id
 4fb4d7f45d1cf-617961c7fb2mr1192544a12.34.1754469422424; Wed, 06 Aug 2025
 01:37:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805150147.25909-1-ziyao@disroot.org> <20250805150147.25909-2-ziyao@disroot.org>
In-Reply-To: <20250805150147.25909-2-ziyao@disroot.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 6 Aug 2025 16:36:50 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6fDjVFX_gyT3m39j09RWFu4O89FVdEumyV-dzUnU9Wig@mail.gmail.com>
X-Gm-Features: Ac12FXwsHY949EROGQFtheK1q58kJXA_--J_SpsB9oSiHp4or_ne-v3DwX_FsEE
Message-ID: <CAAhV-H6fDjVFX_gyT3m39j09RWFu4O89FVdEumyV-dzUnU9Wig@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: clock: loongson2: Add Loongson 2K0300 compatible
To: Yao Zi <ziyao@disroot.org>
Cc: Yinbo Zhu <zhuyinbo@loongson.cn>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 11:03=E2=80=AFPM Yao Zi <ziyao@disroot.org> wrote:
>
> Document the clock controller shipped in Loongson 2K0300 SoC, which
> generates various clock signals for SoC peripherals.
>
> Differing from previous generations of SoCs, 2K0300 requires a 120MHz
> external clock input, and a separate dt-binding header is used for
> cleanness.
>
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  .../bindings/clock/loongson,ls2k-clk.yaml     | 21 ++++++--
>  MAINTAINERS                                   |  1 +
>  .../dt-bindings/clock/loongson,ls2k0300-clk.h | 54 +++++++++++++++++++
>  3 files changed, 72 insertions(+), 4 deletions(-)
>  create mode 100644 include/dt-bindings/clock/loongson,ls2k0300-clk.h
>
> diff --git a/Documentation/devicetree/bindings/clock/loongson,ls2k-clk.ya=
ml b/Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml
> index 4f79cdb417ab..47eb6c0f85bc 100644
> --- a/Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml
> +++ b/Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml
> @@ -16,6 +16,7 @@ description: |
>  properties:
>    compatible:
>      enum:
> +      - loongson,ls2k0300-clk
>        - loongson,ls2k0500-clk
>        - loongson,ls2k-clk  # This is for Loongson-2K1000
>        - loongson,ls2k2000-clk
> @@ -24,8 +25,7 @@ properties:
>      maxItems: 1
>
>    clocks:
> -    items:
> -      - description: 100m ref
> +    maxItems: 1
>
>    clock-names:
>      items:
> @@ -36,13 +36,26 @@ properties:
>      description:
>        The clock consumer should specify the desired clock by having the =
clock
>        ID in its "clocks" phandle cell. See include/dt-bindings/clock/loo=
ngson,ls2k-clk.h
> -      for the full list of Loongson-2 SoC clock IDs.
> +      and include/dt-bindings/clock/loongson,ls2k0300-clk.h for the full=
 list of
> +      Loongson-2 SoC clock IDs.
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: loongson,ls2k0300-clk
> +    then:
> +      properties:
> +        clock-names: false
> +    else:
> +      required:
> +        - clock-names
>
>  required:
>    - compatible
>    - reg
>    - clocks
> -  - clock-names
>    - '#clock-cells'
>
>  additionalProperties: false
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4912b8a83bbb..7960e65d7dfc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14365,6 +14365,7 @@ S:      Maintained
>  F:     Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml
>  F:     drivers/clk/clk-loongson2.c
>  F:     include/dt-bindings/clock/loongson,ls2k-clk.h
> +F:     include/dt-bindings/clock/loongson,ls2k0300-clk.h
I think ls2k0300-clk.h can be merged into ls2k-clk.h

Huacai

>
>  LOONGSON SPI DRIVER
>  M:     Yinbo Zhu <zhuyinbo@loongson.cn>
> diff --git a/include/dt-bindings/clock/loongson,ls2k0300-clk.h b/include/=
dt-bindings/clock/loongson,ls2k0300-clk.h
> new file mode 100644
> index 000000000000..5e8f7b2f33f2
> --- /dev/null
> +++ b/include/dt-bindings/clock/loongson,ls2k0300-clk.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
> +/*
> + * Copyright (C) 2025 Yao Zi <ziyao@disroot.org>
> + */
> +#ifndef _DT_BINDINGS_CLK_LOONGSON_LS2K300_H_
> +#define _DT_BINDINGS_CLK_LOONGSON_LS2K300_H_
> +
> +/* Derivied from REFCLK */
> +#define LS2K0300_CLK_STABLE                    0
> +#define LS2K0300_PLL_NODE                      1
> +#define LS2K0300_PLL_DDR                       2
> +#define LS2K0300_PLL_PIX                       3
> +#define LS2K0300_CLK_THSENS                    4
> +
> +/* Derived from PLL_NODE */
> +#define LS2K0300_CLK_NODE_DIV                  5
> +#define LS2K0300_CLK_NODE_PLL_GATE             6
> +#define LS2K0300_CLK_NODE_SCALE                        7
> +#define LS2K0300_CLK_NODE_GATE                 8
> +#define LS2K0300_CLK_GMAC_DIV                  9
> +#define LS2K0300_CLK_GMAC_GATE                 10
> +#define LS2K0300_CLK_I2S_DIV                   11
> +#define LS2K0300_CLK_I2S_SCALE                 12
> +#define LS2K0300_CLK_I2S_GATE                  13
> +
> +/* Derived from PLL_DDR */
> +#define LS2K0300_CLK_DDR_DIV                   14
> +#define LS2K0300_CLK_DDR_GATE                  15
> +#define LS2K0300_CLK_NET_DIV                   16
> +#define LS2K0300_CLK_NET_GATE                  17
> +#define LS2K0300_CLK_DEV_DIV                   18
> +#define LS2K0300_CLK_DEV_GATE                  19
> +
> +/* Derived from PLL_PIX */
> +#define LS2K0300_CLK_PIX_DIV                   20
> +#define LS2K0300_CLK_PIX_PLL_GATE              21
> +#define LS2K0300_CLK_PIX_SCALE                 22
> +#define LS2K0300_CLK_PIX_GATE                  23
> +#define LS2K0300_CLK_GMACBP_DIV                        24
> +#define LS2K0300_CLK_GMACBP_GATE               25
> +
> +/* Derived from CLK_DEV */
> +#define LS2K0300_CLK_USB_SCALE                 26
> +#define LS2K0300_CLK_USB_GATE                  27
> +#define LS2K0300_CLK_APB_SCALE                 28
> +#define LS2K0300_CLK_APB_GATE                  29
> +#define LS2K0300_CLK_BOOT_SCALE                        30
> +#define LS2K0300_CLK_BOOT_GATE                 31
> +#define LS2K0300_CLK_SDIO_SCALE                        32
> +#define LS2K0300_CLK_SDIO_GATE                 33
> +
> +#define LS2K0300_CLK_GMAC_IN                   34
> +
> +#endif // _DT_BINDINGS_CLK_LOONGSON_LS2K300_H_
> --
> 2.50.1
>

