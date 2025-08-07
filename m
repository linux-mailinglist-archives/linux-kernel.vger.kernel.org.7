Return-Path: <linux-kernel+bounces-758622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1830CB1D1AF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 06:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32B96263E6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 04:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816CF1EB5FE;
	Thu,  7 Aug 2025 04:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsQY+AXa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0E9155A4D;
	Thu,  7 Aug 2025 04:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754541880; cv=none; b=ENYBlOYsJ+fAjeOTXtB5myIdP+RqTs/ocWCf7MP3oqhPF7QzEhf1yAqElvhF/O1cKPA2Px02FmcGuTtZvH5jlqtOaPJMnjrTILFpQ4T/r8sOVX+1cqx3uUIoJRBAtzDYBrNlF/KMczqZRZ7HXAMWDQTEVdcLJfisV7KHkKLBO48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754541880; c=relaxed/simple;
	bh=H2tz/jiA0ySaOi8+9h3NVAk+KJNOv1IwQWCmPAnIpvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KxzBFNYZUyuDAH5uT6TgLAtmtmRk2JtqtjPRuS5ZYh89Nj0z6iMWYTUpi56WaFN0dbim4PjHkdOyQTkbSbkSKQ1dy4e1ZYLzZODkCI+xdor+vaXFa3WEtOsehOJTSE36mASfotKbsAYx7dWwYXOQM9pLa0ZMgrxdCYWQBjHXlQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsQY+AXa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C253C4AF09;
	Thu,  7 Aug 2025 04:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754541880;
	bh=H2tz/jiA0ySaOi8+9h3NVAk+KJNOv1IwQWCmPAnIpvM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dsQY+AXaEPRTDdf6GuzqvlmG46Y5WTRpNX1/FLoDUejwmCCNoa0HoR7TaLkYdDFiT
	 NyLcrY27wC55XqynM/rbChPZWhv7yfcEZzGanaOp+K3RqRiUoEWAU3HkvIJGUL2WwI
	 GX/IPGceIEQKcvDqHZOuJTdB4UQ1c6EP39r87RMEtcBWrNqhToEm2wN79OhEFPuxlv
	 EOoZbOccDcLq3LMqRBcKC5Z5aXVtE3oCvZA3Tqj/QJ5pc27YvpEQXzFHdRvW8vIROF
	 Mo1MFXvXsBGUZXUmp3JDwbpBWjGIutY1ox8O2YeKhRoGUkMCp+gdYwoxMNlnX283IE
	 Y2enPLFj2eW1g==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-615d1865b2dso889587a12.0;
        Wed, 06 Aug 2025 21:44:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEmicS2mIJrlBKUJoGiuSTMbDLSMal740irIbtyhIVt0yoTDmcZgEl7TlINAZKOg5N48cvTE/VvS+d@vger.kernel.org, AJvYcCWKY7FZhnGEHjLivlVRBD6Ju7yYqFjOQupI7CC6VHpgQCsbQdDVQknHKbQdyNBKUj0iFwqbzfgmqJQG@vger.kernel.org, AJvYcCWLryBpCrR13oMqQ3ieKEt4QXjzAVUGsFb/XdGkqtQP++xuP9Qf82cBcwKAB86Js2rPZqgKYIKbJycdrGiC@vger.kernel.org
X-Gm-Message-State: AOJu0Yysev8sLd1gHOqm2rAtAwEOV073JvQTWH0IldHW43xNGTfry3Z7
	W/fNh05PTODxnXpQAi9txEEg9E84hP3l0Z1E8xS5vuJp0wYDJvJ1cN5ajWemNTHpBKLondE6m3s
	tOArtbOMkAwJwx+TYrlC4F8AHXBfxlkk=
X-Google-Smtp-Source: AGHT+IGrRybApbhNW9KNFV1klMF1FbM4yZ9LSK2e6/JLza8lZpqw+tjFKRayB7UvCmU5B3pVnX5yE0d0pNEIITo4YpU=
X-Received: by 2002:a17:907:d11:b0:ae0:aa0d:7bfa with SMTP id
 a640c23a62f3a-af990483abdmr455142266b.50.1754541878858; Wed, 06 Aug 2025
 21:44:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805150147.25909-1-ziyao@disroot.org> <20250805150147.25909-2-ziyao@disroot.org>
 <CAAhV-H6fDjVFX_gyT3m39j09RWFu4O89FVdEumyV-dzUnU9Wig@mail.gmail.com> <aJNK2uI4HTIV99vz@pie>
In-Reply-To: <aJNK2uI4HTIV99vz@pie>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 7 Aug 2025 12:44:27 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5XQ9+dL+QE50aO3XNZ4ic9QqA5frMi8y+eMb83Dv0Gyw@mail.gmail.com>
X-Gm-Features: Ac12FXyDeYGtDiwcXXZ0oUtKVa2wU9cPPsmgheTY7V8BNGDo1iUsYwV9AEaMBY0
Message-ID: <CAAhV-H5XQ9+dL+QE50aO3XNZ4ic9QqA5frMi8y+eMb83Dv0Gyw@mail.gmail.com>
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

On Wed, Aug 6, 2025 at 8:30=E2=80=AFPM Yao Zi <ziyao@disroot.org> wrote:
>
> On Wed, Aug 06, 2025 at 04:36:50PM +0800, Huacai Chen wrote:
> > On Tue, Aug 5, 2025 at 11:03=E2=80=AFPM Yao Zi <ziyao@disroot.org> wrot=
e:
> > >
> > > Document the clock controller shipped in Loongson 2K0300 SoC, which
> > > generates various clock signals for SoC peripherals.
> > >
> > > Differing from previous generations of SoCs, 2K0300 requires a 120MHz
> > > external clock input, and a separate dt-binding header is used for
> > > cleanness.
> > >
> > > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > > ---
> > >  .../bindings/clock/loongson,ls2k-clk.yaml     | 21 ++++++--
> > >  MAINTAINERS                                   |  1 +
> > >  .../dt-bindings/clock/loongson,ls2k0300-clk.h | 54 +++++++++++++++++=
++
> > >  3 files changed, 72 insertions(+), 4 deletions(-)
> > >  create mode 100644 include/dt-bindings/clock/loongson,ls2k0300-clk.h
> > >
>
> ...
>
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 4912b8a83bbb..7960e65d7dfc 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -14365,6 +14365,7 @@ S:      Maintained
> > >  F:     Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yam=
l
> > >  F:     drivers/clk/clk-loongson2.c
> > >  F:     include/dt-bindings/clock/loongson,ls2k-clk.h
> > > +F:     include/dt-bindings/clock/loongson,ls2k0300-clk.h
> > I think ls2k0300-clk.h can be merged into ls2k-clk.h
>
> Honestly I think a separate header makes the purpose more clear, and
> follows the convention that name of binding header matches the
> compatible, but I'm willing to change if you really consider merging
> them together is better and dt-binding maintainer agrees on this.
I think merging is better, because:
1, loongson,ls2k-clk.h has already contains ls2k500, ls2k1000,
ls2k2000, so ls2k300 is not special.
2, ls2k500, ls2k1000, ls2k2000 and ls2k300 use the same driver
(drivers/clk/clk-loongson2.c), it is not necessary to include two
headers.

And moreover, existing code uses NODE_PLL/DDR_PLL naming, ls2k300 uses
PLL_NODE/PLL_DDR is not so good.


Huacai

>
> > Huacai
>
> Thanks,
> Yao Zi
>
> > >
> > >  LOONGSON SPI DRIVER
> > >  M:     Yinbo Zhu <zhuyinbo@loongson.cn>
> > > diff --git a/include/dt-bindings/clock/loongson,ls2k0300-clk.h b/incl=
ude/dt-bindings/clock/loongson,ls2k0300-clk.h
> > > new file mode 100644
> > > index 000000000000..5e8f7b2f33f2
> > > --- /dev/null
> > > +++ b/include/dt-bindings/clock/loongson,ls2k0300-clk.h
> > > @@ -0,0 +1,54 @@
> > > +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
> > > +/*
> > > + * Copyright (C) 2025 Yao Zi <ziyao@disroot.org>
> > > + */
> > > +#ifndef _DT_BINDINGS_CLK_LOONGSON_LS2K300_H_
> > > +#define _DT_BINDINGS_CLK_LOONGSON_LS2K300_H_
> > > +
> > > +/* Derivied from REFCLK */
> > > +#define LS2K0300_CLK_STABLE                    0
> > > +#define LS2K0300_PLL_NODE                      1
> > > +#define LS2K0300_PLL_DDR                       2
> > > +#define LS2K0300_PLL_PIX                       3
> > > +#define LS2K0300_CLK_THSENS                    4
> > > +
> > > +/* Derived from PLL_NODE */
> > > +#define LS2K0300_CLK_NODE_DIV                  5
> > > +#define LS2K0300_CLK_NODE_PLL_GATE             6
> > > +#define LS2K0300_CLK_NODE_SCALE                        7
> > > +#define LS2K0300_CLK_NODE_GATE                 8
> > > +#define LS2K0300_CLK_GMAC_DIV                  9
> > > +#define LS2K0300_CLK_GMAC_GATE                 10
> > > +#define LS2K0300_CLK_I2S_DIV                   11
> > > +#define LS2K0300_CLK_I2S_SCALE                 12
> > > +#define LS2K0300_CLK_I2S_GATE                  13
> > > +
> > > +/* Derived from PLL_DDR */
> > > +#define LS2K0300_CLK_DDR_DIV                   14
> > > +#define LS2K0300_CLK_DDR_GATE                  15
> > > +#define LS2K0300_CLK_NET_DIV                   16
> > > +#define LS2K0300_CLK_NET_GATE                  17
> > > +#define LS2K0300_CLK_DEV_DIV                   18
> > > +#define LS2K0300_CLK_DEV_GATE                  19
> > > +
> > > +/* Derived from PLL_PIX */
> > > +#define LS2K0300_CLK_PIX_DIV                   20
> > > +#define LS2K0300_CLK_PIX_PLL_GATE              21
> > > +#define LS2K0300_CLK_PIX_SCALE                 22
> > > +#define LS2K0300_CLK_PIX_GATE                  23
> > > +#define LS2K0300_CLK_GMACBP_DIV                        24
> > > +#define LS2K0300_CLK_GMACBP_GATE               25
> > > +
> > > +/* Derived from CLK_DEV */
> > > +#define LS2K0300_CLK_USB_SCALE                 26
> > > +#define LS2K0300_CLK_USB_GATE                  27
> > > +#define LS2K0300_CLK_APB_SCALE                 28
> > > +#define LS2K0300_CLK_APB_GATE                  29
> > > +#define LS2K0300_CLK_BOOT_SCALE                        30
> > > +#define LS2K0300_CLK_BOOT_GATE                 31
> > > +#define LS2K0300_CLK_SDIO_SCALE                        32
> > > +#define LS2K0300_CLK_SDIO_GATE                 33
> > > +
> > > +#define LS2K0300_CLK_GMAC_IN                   34
> > > +
> > > +#endif // _DT_BINDINGS_CLK_LOONGSON_LS2K300_H_
> > > --
> > > 2.50.1
> > >
> >
>

