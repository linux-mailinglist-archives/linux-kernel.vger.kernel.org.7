Return-Path: <linux-kernel+bounces-802411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211E6B45229
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2EF7A473C9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10A830BBA0;
	Fri,  5 Sep 2025 08:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TSfiqTAv"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250B5267B90
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062424; cv=none; b=lvHF2XCml3z/I6AX+L8ZjFFpYOqB+SXY4NN9A3tJ+B0x4HxB8J+reVxkaqaGFwblxpaE0MkNcHRKyR9xDqyJ9zVsdZCltZgObKqqb6T1YXZPhDpF0HyGu+aEeEGNPJH/8P5qj2sMl8pibHe1sSf2OBxAchheZHvkK+tWZwKiqyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062424; c=relaxed/simple;
	bh=s1H95DzZ47/Gv87gSW5XfSmmnQ9iM2HST1opScL1BwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pTzUvnmqKEwG+SjVlt9q9Ipjf1uhh1WgaB6XsQ1IFm8ZjUYfLA4RrVFppmj/jG//aVmzFWjfdV8sj6Ml2lOd2tsdwRIAUfSoXPIl0KSPZszUKDYFna6pxWdTZvGdOCFNNggvb9ke0CBoaHWGfg0lHCZRw9VNgmSeA87uXAQAxno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TSfiqTAv; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55f72452a8eso2299711e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 01:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757062420; x=1757667220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vZ3W53+NBzM1/YoocDMpt9TAql3h7i1DOTAYBcde+k=;
        b=TSfiqTAvn3TzZa11wBRPVN3tVHumyx5moTKZz9AkTpVlPAqyzCsvOqzO2Sf60N8xcR
         HUm7VT2iTTrWO4PiO2AQBSsC+KKfpxvMiII/Px1H7BXd7aqHSm4tD2aB2uvySZraWudI
         fjLe26pHFQbvDiTtSBCkUXN396CvwYgEngg7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062420; x=1757667220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vZ3W53+NBzM1/YoocDMpt9TAql3h7i1DOTAYBcde+k=;
        b=LWGlD4Yj8ULRv/hTQsSgahidBIluPOK7jNqNFX4KsStW1VDj+L6KTi/jxSWu5FHXIm
         +iKQ8p6Upe10HfFCrNmJVwBtnU78GfIAVOxVOUS1mwVTsAPG9KPqw0OoFeyyNdazkvYD
         iBagqn0k28/tAiHxIm08sPYEKEGQ618N/aLq6cisvIDdaHwkVpz1NAJXQ5Mk3m8+k9LR
         2kC+KY06i7rSTUxLsK6WxoTEr9+L0lvaVGKL4q7ffUsbHwKaITjofYCQrAHVKUW26G7V
         VsNZRCAeTAUlnod+w+ILee6EBgkUyNyhWV9Q9RPyaL2LNhzsoe1hZHNYLZ4TSJp0EGtl
         Rrzw==
X-Forwarded-Encrypted: i=1; AJvYcCWAJsXAvGxUnAd4OWX/XJCP3CCB6oqE6p8EiTEBz9QL7invLUoF2IHeedvsRE5QZieD8ICncWl1CVu32oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMKEBPzjVMDPbeEWoznSgkQeZvacAf2YF4hzIGN9MZKtgMtrGk
	IEqKNAIEgyPpaAQyTJBOmpZ5RniJ8A7YhYdPuUY1h3HhihxNvjRkipSZvvX06uO07771kDBGm0O
	r9DlQ6QMcBa7oq8PxPfBb1R+dGiPjtWw5u0UvM3AX
X-Gm-Gg: ASbGncvAFaAyPKGVAqviDVh3NS0EjhYsIkDYnWlUslAwRpyV72ece/loMTKHnC1drj4
	BjrqkvXUOl/mQ1dxjRChdw0DTlA4DqS4CqMOf4LllU1LSSbWBISnFTj/v8ugTXbqF2UK7K8tWrF
	u5viMKY4ClNz7ADW53gQwMp4in4/xAI2EQ7KJzHnviQmOsR+lLxt44Gy2qZhujDl6vdSi77Ga/o
	Dra75+wCzPMszx73js6oQqoUJufkF2sZgWz9g==
X-Google-Smtp-Source: AGHT+IEjHV/T1RYYsuzHLdjnxHEKIYfNZ8/LU3RE2sLPGxb+l+/MTplgH0fgFpzDm7aF6IX2eRbQMv8bMFW6xshxSss=
X-Received: by 2002:a05:6512:3b10:b0:561:70f1:e3ec with SMTP id
 2adb3069b0e04-56170f1e54amr557993e87.30.1757062420258; Fri, 05 Sep 2025
 01:53:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829091913.131528-1-laura.nao@collabora.com>
 <20250829091913.131528-20-laura.nao@collabora.com> <0e6592b7-6f6d-4291-992c-ff321c920381@collabora.com>
In-Reply-To: <0e6592b7-6f6d-4291-992c-ff321c920381@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 5 Sep 2025 16:53:29 +0800
X-Gm-Features: Ac12FXznPHud9uxEoezJCyg2AXmAKQakPZkEkl_DvIt-_2nZkd2YLz6bIWoFjWA
Message-ID: <CAGXv+5GFaudGqm4C9CY-_spiXcyWk7OvWHTdkehsyrV4sO1Ndw@mail.gmail.com>
Subject: Re: [PATCH v5 19/27] clk: mediatek: Add MT8196 mdpsys clock support
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Laura Nao <laura.nao@collabora.com>, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, p.zabel@pengutronix.de, richardcochran@gmail.com, 
	guangjie.song@mediatek.com, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	netdev@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 4:39=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 29/08/25 11:19, Laura Nao ha scritto:
> > Add support for the MT8196 mdpsys clock controller, which provides cloc=
k
> > gate control for MDP.
> >
> > Signed-off-by: Laura Nao <laura.nao@collabora.com>
> > ---
> >   drivers/clk/mediatek/Kconfig             |   7 +
> >   drivers/clk/mediatek/Makefile            |   1 +
> >   drivers/clk/mediatek/clk-mt8196-mdpsys.c | 186 ++++++++++++++++++++++=
+
> >   3 files changed, 194 insertions(+)
> >   create mode 100644 drivers/clk/mediatek/clk-mt8196-mdpsys.c
> >
> > diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfi=
g
> > index 8e5cdae80748..68ac08cf8e82 100644
> > --- a/drivers/clk/mediatek/Kconfig
> > +++ b/drivers/clk/mediatek/Kconfig
> > @@ -1024,6 +1024,13 @@ config COMMON_CLK_MT8196_MCUSYS
> >       help
> >         This driver supports MediaTek MT8196 mcusys clocks.
> >
> > +config COMMON_CLK_MT8196_MDPSYS
> > +     tristate "Clock driver for MediaTek MT8196 mdpsys"
> > +     depends on COMMON_CLK_MT8196
> > +     default COMMON_CLK_MT8196
> > +     help
> > +       This driver supports MediaTek MT8196 mdpsys clocks.
> > +
> >   config COMMON_CLK_MT8196_PEXTPSYS
> >       tristate "Clock driver for MediaTek MT8196 pextpsys"
> >       depends on COMMON_CLK_MT8196
> > diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makef=
ile
> > index 46358623c3e5..d2d8bc43e45b 100644
> > --- a/drivers/clk/mediatek/Makefile
> > +++ b/drivers/clk/mediatek/Makefile
> > @@ -155,6 +155,7 @@ obj-$(CONFIG_COMMON_CLK_MT8196) +=3D clk-mt8196-apm=
ixedsys.o clk-mt8196-topckgen.o
> >                                  clk-mt8196-peri_ao.o
> >   obj-$(CONFIG_COMMON_CLK_MT8196_IMP_IIC_WRAP) +=3D clk-mt8196-imp_iic_=
wrap.o
> >   obj-$(CONFIG_COMMON_CLK_MT8196_MCUSYS) +=3D clk-mt8196-mcu.o
> > +obj-$(CONFIG_COMMON_CLK_MT8196_MDPSYS) +=3D clk-mt8196-mdpsys.o
> >   obj-$(CONFIG_COMMON_CLK_MT8196_PEXTPSYS) +=3D clk-mt8196-pextp.o
> >   obj-$(CONFIG_COMMON_CLK_MT8196_UFSSYS) +=3D clk-mt8196-ufs_ao.o
> >   obj-$(CONFIG_COMMON_CLK_MT8365) +=3D clk-mt8365-apmixedsys.o clk-mt83=
65.o
> > diff --git a/drivers/clk/mediatek/clk-mt8196-mdpsys.c b/drivers/clk/med=
iatek/clk-mt8196-mdpsys.c
> > new file mode 100644
> > index 000000000000..a46b1627f1f3
> > --- /dev/null
> > +++ b/drivers/clk/mediatek/clk-mt8196-mdpsys.c
> > @@ -0,0 +1,186 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2025 MediaTek Inc.
> > + *                    Guangjie Song <guangjie.song@mediatek.com>
> > + * Copyright (c) 2025 Collabora Ltd.
> > + *                    Laura Nao <laura.nao@collabora.com>
> > + */
> > +#include <dt-bindings/clock/mediatek,mt8196-clock.h>
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include "clk-gate.h"
> > +#include "clk-mtk.h"
> > +
> > +static const struct mtk_gate_regs mdp0_cg_regs =3D {
> > +     .set_ofs =3D 0x104,
> > +     .clr_ofs =3D 0x108,
> > +     .sta_ofs =3D 0x100,
> > +};
> > +
> > +static const struct mtk_gate_regs mdp1_cg_regs =3D {
> > +     .set_ofs =3D 0x114,
> > +     .clr_ofs =3D 0x118,
> > +     .sta_ofs =3D 0x110,
> > +};
> > +
> > +static const struct mtk_gate_regs mdp2_cg_regs =3D {
> > +     .set_ofs =3D 0x124,
> > +     .clr_ofs =3D 0x128,
> > +     .sta_ofs =3D 0x120,
> > +};
> > +
> > +#define GATE_MDP0(_id, _name, _parent, _shift) {     \
> > +             .id =3D _id,                              \
> > +             .name =3D _name,                          \
> > +             .parent_name =3D _parent,                 \
> > +             .regs =3D &mdp0_cg_regs,                  \
> > +             .shift =3D _shift,                        \
> > +             .flags =3D CLK_OPS_PARENT_ENABLE,         \
>
> Why would MDP0 and MDP2 be different, as in why would MDP1 be so special =
to not
> need CLK_OPS_PARENT_ENABLE while the others do?
>
> Either they all do, or they all don't.
>
> I guess they all don't, but I'm not sure how you tested that at all, sinc=
e the
> only way to test this is downstream (and upstream will very likely be dif=
ferent
> from that).
>
> Even though I think they don't need that - please add back CLK_OPS_PARENT=
_ENABLE
> to GATE_MDP1 to be safe, as in (all) MediaTek SoCs the multimedia subsyst=
em is
> kinda separate from the rest.

That kind of doesn't fly since the parent of mdp_f26m is clk26m, not the
mdp clock. So either this block doesn't need a clock for register access
or this clock is going to be broken.

This is why I raised the question about the validity of the flag in the
first place.

> +       GATE_MDP1(CLK_MDP_F26M, "mdp_f26m", "clk26m", 27),

> Once MT8196 MDP support is upstreamed, we will be able to run a number of=
 tests
> to evaluate whether this flag is really needed or not.
>
> After all, if it turns out we can remove it, it's going to be a 3 lines p=
atch,
> not a big deal.

That also works. Though IMO it makes the error harder to notice.

ChenYu

> > +             .ops =3D &mtk_clk_gate_ops_setclr,        \
> > +     }
> > +
> > +#define GATE_MDP1(_id, _name, _parent, _shift) {     \
> > +             .id =3D _id,                              \
> > +             .name =3D _name,                          \
> > +             .parent_name =3D _parent,                 \
> > +             .regs =3D &mdp1_cg_regs,                  \
> > +             .shift =3D _shift,                        \
> > +             .ops =3D &mtk_clk_gate_ops_setclr,        \
> > +     }
> > +
> > +#define GATE_MDP2(_id, _name, _parent, _shift) {     \
> > +             .id =3D _id,                              \
> > +             .name =3D _name,                          \
> > +             .parent_name =3D _parent,                 \
> > +             .regs =3D &mdp2_cg_regs,                  \
> > +             .shift =3D _shift,                        \
> > +             .flags =3D CLK_OPS_PARENT_ENABLE,         \
> > +             .ops =3D &mtk_clk_gate_ops_setclr,        \
> > +     }
> > +
>
> ..snip..
>
> > +
> > +static const struct mtk_clk_desc mdp_mcd =3D {
> > +     .clks =3D mdp_clks,
> > +     .num_clks =3D ARRAY_SIZE(mdp_clks),
> > +     .need_runtime_pm =3D true,
> > +};
> > +
> > +static const struct of_device_id of_match_clk_mt8196_mdpsys[] =3D {
> > +     { .compatible =3D "mediatek,mt8196-mdpsys1", .data =3D &mdp1_mcd =
},
> > +     { .compatible =3D "mediatek,mt8196-mdpsys0", .data =3D &mdp_mcd }=
,
>
> 0 comes before 1, swap those entries please.
>
> After applying the proposed fixes
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
>
> > +     { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, of_match_clk_mt8196_mdpsys);
> > +
> > +static struct platform_driver clk_mt8196_mdpsys_drv =3D {
> > +     .probe =3D mtk_clk_simple_probe,
> > +     .remove =3D mtk_clk_simple_remove,
> > +     .driver =3D {
> > +             .name =3D "clk-mt8196-mdpsys",
> > +             .of_match_table =3D of_match_clk_mt8196_mdpsys,
> > +     },
> > +};
> > +module_platform_driver(clk_mt8196_mdpsys_drv);
> > +
> > +MODULE_DESCRIPTION("MediaTek MT8196 Multimedia Data Path clocks driver=
");
> > +MODULE_LICENSE("GPL");
>

