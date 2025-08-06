Return-Path: <linux-kernel+bounces-757715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77775B1C5DC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9382856349C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE7328BA91;
	Wed,  6 Aug 2025 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="EW9Iebdd"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A9D28B7C6;
	Wed,  6 Aug 2025 12:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754483442; cv=none; b=HoLBAk528Cgf1Ss3wH8xaWDoG0rBmWhJXAkPiuufsbSUUFFuc61C6J+bEEccuS3sT9CxyUUdEOXhyAvJxtQgo2M7MTpw7PWIVkTSJgMTrr/x4WkVr/nfGNt869B4ybn+a2AeO+RE/ZNAuiuvg2I83vawx9vGN0DsnQ56S1Gbn+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754483442; c=relaxed/simple;
	bh=mSYUh+T5LKyYNPZakKmsiXm0B30JrcVYTIzk5jrro4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Geu+Bq8iQTTc1L9OjZ6NRVTo+nlKoOpJWHnWQEKfyx+D1oBArBFH72dvXc1kzhkZF002Hv19D3q6pBx2kf6tD03IvOZ9MjxJvCcAsMhaVWfXE0SWqjEORAiXovovyDl/i7ofwVAaYwDzW+1/E9k2Spoxt7n9s87/Q5piBGz7GFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=EW9Iebdd; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 08CFA2578E;
	Wed,  6 Aug 2025 14:30:37 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4fCJ_2J-kINn; Wed,  6 Aug 2025 14:30:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754483435; bh=mSYUh+T5LKyYNPZakKmsiXm0B30JrcVYTIzk5jrro4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EW9IebddAIj6oJPaTxR3Luvi4SbR+tvpbpNMG4Xj3dp25aspX/Uy9BxH+402f6UaE
	 Amy73reDlzOr7ogRTw8hdC/8nYocyT3fwYS+06foQVMca4qzGcPv+r6gTDSJjq8yz5
	 tJV4IHOyYZ7bKOn8tYLXdDXN17B1zEDlrypVJamaeuPwrYTvvXz0zFPdRgZqsq9qTQ
	 e+IDPelK0nsSE42p4lWLeL2Ak0pOe6Wb8lLl6P2tNp9n67rluJtdgfLWrUUqP6gBAj
	 5eDP4HJNC/5YmisBT/FaBKOGvN8G1XNZSshtDlFdLxQ1aJU7arFmE+fxRQzStfjDJV
	 yF3dYv5OFCsQg==
Date: Wed, 6 Aug 2025 12:30:18 +0000
From: Yao Zi <ziyao@disroot.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Yinbo Zhu <zhuyinbo@loongson.cn>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>
Subject: Re: [PATCH v3 1/8] dt-bindings: clock: loongson2: Add Loongson
 2K0300 compatible
Message-ID: <aJNK2uI4HTIV99vz@pie>
References: <20250805150147.25909-1-ziyao@disroot.org>
 <20250805150147.25909-2-ziyao@disroot.org>
 <CAAhV-H6fDjVFX_gyT3m39j09RWFu4O89FVdEumyV-dzUnU9Wig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H6fDjVFX_gyT3m39j09RWFu4O89FVdEumyV-dzUnU9Wig@mail.gmail.com>

On Wed, Aug 06, 2025 at 04:36:50PM +0800, Huacai Chen wrote:
> On Tue, Aug 5, 2025 at 11:03 PM Yao Zi <ziyao@disroot.org> wrote:
> >
> > Document the clock controller shipped in Loongson 2K0300 SoC, which
> > generates various clock signals for SoC peripherals.
> >
> > Differing from previous generations of SoCs, 2K0300 requires a 120MHz
> > external clock input, and a separate dt-binding header is used for
> > cleanness.
> >
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> >  .../bindings/clock/loongson,ls2k-clk.yaml     | 21 ++++++--
> >  MAINTAINERS                                   |  1 +
> >  .../dt-bindings/clock/loongson,ls2k0300-clk.h | 54 +++++++++++++++++++
> >  3 files changed, 72 insertions(+), 4 deletions(-)
> >  create mode 100644 include/dt-bindings/clock/loongson,ls2k0300-clk.h
> >

...

> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 4912b8a83bbb..7960e65d7dfc 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14365,6 +14365,7 @@ S:      Maintained
> >  F:     Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml
> >  F:     drivers/clk/clk-loongson2.c
> >  F:     include/dt-bindings/clock/loongson,ls2k-clk.h
> > +F:     include/dt-bindings/clock/loongson,ls2k0300-clk.h
> I think ls2k0300-clk.h can be merged into ls2k-clk.h

Honestly I think a separate header makes the purpose more clear, and
follows the convention that name of binding header matches the
compatible, but I'm willing to change if you really consider merging
them together is better and dt-binding maintainer agrees on this.

> Huacai

Thanks,
Yao Zi

> >
> >  LOONGSON SPI DRIVER
> >  M:     Yinbo Zhu <zhuyinbo@loongson.cn>
> > diff --git a/include/dt-bindings/clock/loongson,ls2k0300-clk.h b/include/dt-bindings/clock/loongson,ls2k0300-clk.h
> > new file mode 100644
> > index 000000000000..5e8f7b2f33f2
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/loongson,ls2k0300-clk.h
> > @@ -0,0 +1,54 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
> > +/*
> > + * Copyright (C) 2025 Yao Zi <ziyao@disroot.org>
> > + */
> > +#ifndef _DT_BINDINGS_CLK_LOONGSON_LS2K300_H_
> > +#define _DT_BINDINGS_CLK_LOONGSON_LS2K300_H_
> > +
> > +/* Derivied from REFCLK */
> > +#define LS2K0300_CLK_STABLE                    0
> > +#define LS2K0300_PLL_NODE                      1
> > +#define LS2K0300_PLL_DDR                       2
> > +#define LS2K0300_PLL_PIX                       3
> > +#define LS2K0300_CLK_THSENS                    4
> > +
> > +/* Derived from PLL_NODE */
> > +#define LS2K0300_CLK_NODE_DIV                  5
> > +#define LS2K0300_CLK_NODE_PLL_GATE             6
> > +#define LS2K0300_CLK_NODE_SCALE                        7
> > +#define LS2K0300_CLK_NODE_GATE                 8
> > +#define LS2K0300_CLK_GMAC_DIV                  9
> > +#define LS2K0300_CLK_GMAC_GATE                 10
> > +#define LS2K0300_CLK_I2S_DIV                   11
> > +#define LS2K0300_CLK_I2S_SCALE                 12
> > +#define LS2K0300_CLK_I2S_GATE                  13
> > +
> > +/* Derived from PLL_DDR */
> > +#define LS2K0300_CLK_DDR_DIV                   14
> > +#define LS2K0300_CLK_DDR_GATE                  15
> > +#define LS2K0300_CLK_NET_DIV                   16
> > +#define LS2K0300_CLK_NET_GATE                  17
> > +#define LS2K0300_CLK_DEV_DIV                   18
> > +#define LS2K0300_CLK_DEV_GATE                  19
> > +
> > +/* Derived from PLL_PIX */
> > +#define LS2K0300_CLK_PIX_DIV                   20
> > +#define LS2K0300_CLK_PIX_PLL_GATE              21
> > +#define LS2K0300_CLK_PIX_SCALE                 22
> > +#define LS2K0300_CLK_PIX_GATE                  23
> > +#define LS2K0300_CLK_GMACBP_DIV                        24
> > +#define LS2K0300_CLK_GMACBP_GATE               25
> > +
> > +/* Derived from CLK_DEV */
> > +#define LS2K0300_CLK_USB_SCALE                 26
> > +#define LS2K0300_CLK_USB_GATE                  27
> > +#define LS2K0300_CLK_APB_SCALE                 28
> > +#define LS2K0300_CLK_APB_GATE                  29
> > +#define LS2K0300_CLK_BOOT_SCALE                        30
> > +#define LS2K0300_CLK_BOOT_GATE                 31
> > +#define LS2K0300_CLK_SDIO_SCALE                        32
> > +#define LS2K0300_CLK_SDIO_GATE                 33
> > +
> > +#define LS2K0300_CLK_GMAC_IN                   34
> > +
> > +#endif // _DT_BINDINGS_CLK_LOONGSON_LS2K300_H_
> > --
> > 2.50.1
> >
> 

