Return-Path: <linux-kernel+bounces-770244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7031B278E7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2914F1CE201E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 06:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2865E218AAA;
	Fri, 15 Aug 2025 06:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XE6Aqgot"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F78921B9D9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 06:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755238402; cv=none; b=k4xD8EU4UXZxr774DkVAjSMH1tyU6zCXDT3LgDlc/Pkd1MqF72KkOjbqWOirvKbBUEQVcS3JKn9SBMTflYrPksrpCvmh6b28WjRAx5wnIfkfeeSflINiGkVaODEZJazbn6VoRJ6EWU2MP+weZdf8uj/mg6Qzm50HcJJxhts0NIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755238402; c=relaxed/simple;
	bh=vMrFQzr7OTiak+1lD6iO+FORdNYn5TfuuqQIRneeZjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ua/byZd6NH6zLJZt/X22LQsa/bmjFBxspfZ6TucrnqA8nkttwiC0/7cmrU3o8U9U2viKctmVj1x4Nw2rFSBz9erm1qGDKAsQYMSsRfkPz4cN8rcSanIQQXJUqr0YwwIPEcq2WiVMZY8upfB6xmt1qmWz59LjxtZA5t7NBU/AN3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XE6Aqgot; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55ce5268cb8so1602766e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 23:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755238398; x=1755843198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXrqAOGSKlkHkTRQ7lUZKBYVIpeSl7z2gePyrfHvoQU=;
        b=XE6Aqgot9/vP4IL3AV7sUSGvkROF2ehxGNeIsh1yCt83JXB/1HRv411+4O6wtq1gPK
         6ThjU4DjpsScxjpeW3UR03V8dOq6X74HhekBYQfE8Q+GjLz2MEfhKMz5v6L/gPFPIsJk
         xd5Vb2pOp2EQTFkcqdVVYv+bWFSlZhlSBo6KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755238398; x=1755843198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXrqAOGSKlkHkTRQ7lUZKBYVIpeSl7z2gePyrfHvoQU=;
        b=Rgk+7AQ6Qs1tIByb3Ha7CwM9lEhMmBcO9BT2HkrJFQ5bJHK6lML4yw2JLVx4I98Lpe
         COrjThPuyg3nor6pKUCD4C4qhUoxaFSy87mpdcvhQlK96y/LxMnR2YaG266HIO66xFIf
         KDqZGJrQuB7qhGBBIQKcA5eA9D3sgE927EoE4OyJ67A4q9iTfsY7u/3wXvmtPVUtA5Hs
         UOPDGT9dEw3NZFtzF92aAaE29PQ0GxWBOouum7T90dZ+1BuCHHvQ9I+lc6oIlsTvjCfj
         2tqpQH7x0uUd820VJTyjo2JmqXBf8ufXO9j99PtO1GL1kr1YTYkQZ5WL+fOrQ6jdziSV
         GG5A==
X-Forwarded-Encrypted: i=1; AJvYcCU9r4WM7NSUx4+9l1ySY+jypqNcrmHQ3SpIegv4F6VVZgehhVMD/0n8iraYRJ5kQTckZSrX6JaT95dBCQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHNd0np1IR6AzUHahd7R06SCV1uKaVI13qCj94QpIkUqCyn8Xu
	X5D4AHN9kAy39qgNOiBT+rv3IYQJmNnBb88wDn5BizQsFRBAIHzNsFRbmKGxd8U504KoiJGwk/0
	55atkoykLT7hECselo+Px2X17njS0ZkCEJEtWM29X
X-Gm-Gg: ASbGncv9RLkSlZtGMi4S+u6quUnSn8BuZxIIsz61Fuw1WGtukqQ1mVpT1Fl4W+r4BOO
	pCj0Gc3ILlx2b6jUJIQQqYiGYUinTshVkdkhmwnCccRxCEnMbVb++LKcId+3zLdcYKD/SMY09Yq
	R03/UEjZjDiu1pl+aM6+fE43Vu4F6y9asyeqLSo5JZGG7cwmuDMHrJeHbLoOGYzHcFqiBULUm1Z
	z0IqYukt76IlW6ag3DJKZSQPItq1chCoFcPYw==
X-Google-Smtp-Source: AGHT+IHgien6Ta30w9thH606OXZ37uev4E3SyZFiYtbUjF+ewjbtl9wYml18XdGcJArNMrSrqAKCEoyzfxTTcxLF8kw=
X-Received: by 2002:a05:6512:401a:b0:55c:e61c:6969 with SMTP id
 2adb3069b0e04-55ceeb8e474mr204360e87.45.1755238397730; Thu, 14 Aug 2025
 23:13:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805135447.149231-1-laura.nao@collabora.com> <20250805135447.149231-18-laura.nao@collabora.com>
In-Reply-To: <20250805135447.149231-18-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 15 Aug 2025 15:13:06 +0900
X-Gm-Features: Ac12FXzr5keexSM3h938Aqs72YKWpIyCvPBM6Nr2RSvEz3GKsQxqYO4KthSuqtA
Message-ID: <CAGXv+5EDxVe6k7FQM2HenDaHM1Rz7eEcQhVL1q1AqUFfr9apnA@mail.gmail.com>
Subject: Re: [PATCH v4 17/27] clk: mediatek: Add MT8196 I2C clock support
To: Laura Nao <laura.nao@collabora.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, p.zabel@pengutronix.de, 
	richardcochran@gmail.com, guangjie.song@mediatek.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	kernel@collabora.com, =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 10:55=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> Add support for the MT8196 I2C clock controller, which provides clock
> gate control for I2C.
>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>  drivers/clk/mediatek/Kconfig                  |   7 ++
>  drivers/clk/mediatek/Makefile                 |   1 +
>  .../clk/mediatek/clk-mt8196-imp_iic_wrap.c    | 117 ++++++++++++++++++
>  3 files changed, 125 insertions(+)
>  create mode 100644 drivers/clk/mediatek/clk-mt8196-imp_iic_wrap.c
>
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index c977719046a4..fe2697b64ef0 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -1010,6 +1010,13 @@ config COMMON_CLK_MT8196
>         help
>           This driver supports MediaTek MT8196 basic clocks.
>
> +config COMMON_CLK_MT8196_IMP_IIC_WRAP
> +       tristate "Clock driver for MediaTek MT8196 imp_iic_wrap"
> +       depends on COMMON_CLK_MT8196
> +       default COMMON_CLK_MT8196
> +       help
> +         This driver supports MediaTek MT8196 i2c clocks.
> +
>  config COMMON_CLK_MT8196_PEXTPSYS
>         tristate "Clock driver for MediaTek MT8196 pextpsys"
>         depends on COMMON_CLK_MT8196
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefil=
e
> index 88f7d8a229c2..241e7f5e7316 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -153,6 +153,7 @@ obj-$(CONFIG_COMMON_CLK_MT8195_WPESYS) +=3D clk-mt819=
5-wpe.o
>  obj-$(CONFIG_COMMON_CLK_MT8196) +=3D clk-mt8196-apmixedsys.o clk-mt8196-=
topckgen.o \
>                                    clk-mt8196-topckgen2.o clk-mt8196-vlpc=
kgen.o \
>                                    clk-mt8196-peri_ao.o
> +obj-$(CONFIG_COMMON_CLK_MT8196_IMP_IIC_WRAP) +=3D clk-mt8196-imp_iic_wra=
p.o
>  obj-$(CONFIG_COMMON_CLK_MT8196_PEXTPSYS) +=3D clk-mt8196-pextp.o
>  obj-$(CONFIG_COMMON_CLK_MT8196_UFSSYS) +=3D clk-mt8196-ufs_ao.o
>  obj-$(CONFIG_COMMON_CLK_MT8365) +=3D clk-mt8365-apmixedsys.o clk-mt8365.=
o
> diff --git a/drivers/clk/mediatek/clk-mt8196-imp_iic_wrap.c b/drivers/clk=
/mediatek/clk-mt8196-imp_iic_wrap.c
> new file mode 100644
> index 000000000000..98db1476e72c
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8196-imp_iic_wrap.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + *                    Guangjie Song <guangjie.song@mediatek.com>
> + * Copyright (c) 2025 Collabora Ltd.
> + *                    Laura Nao <laura.nao@collabora.com>
> + */
> +#include <dt-bindings/clock/mediatek,mt8196-clock.h>

Nit: add line for separation.

> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-gate.h"
> +#include "clk-mtk.h"
> +
> +static const struct mtk_gate_regs imp_cg_regs =3D {
> +       .set_ofs =3D 0xe08,
> +       .clr_ofs =3D 0xe04,
> +       .sta_ofs =3D 0xe00,
> +};
> +
> +#define GATE_IMP(_id, _name, _parent, _shift) {        \
> +               .id =3D _id,                              \
> +               .name =3D _name,                          \
> +               .parent_name =3D _parent,                 \
> +               .regs =3D &imp_cg_regs,                   \
> +               .shift =3D _shift,                        \
> +               .flags =3D CLK_OPS_PARENT_ENABLE,         \

So here it likely works because the parent for all the gates are the same,
which is the clock feeding this block.


Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

