Return-Path: <linux-kernel+bounces-844443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2C1BC1EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 17:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0A83A3A0C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 15:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E2E2E6CA0;
	Tue,  7 Oct 2025 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEJiXXUG"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17752E62BF
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759850896; cv=none; b=ZjPH9Y8oNOgWGCEy5RVCQb9NijAlLNyxL+ilJgydcek/tzO3zJmppbVpqH6FXNORrxVs/MORtkkfGxS8m3i7+ucwSNQYcS4Xwo4iBG07ttKQ2Zb1tNhpI/tPCrHxup1dFa7PvyfnT7bXt6+neUbtTnjw6K5+Q/oT9u3zoOgBjTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759850896; c=relaxed/simple;
	bh=kWXitx8WofhpxyiCGLF4fVh/bhkDwN8vVR0ngmxKw+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OXkbvOWMW8FtUNnpg8pMx/QMEouFPRbPMpgmIn2chiyvFsxfh6885YejkQ9rJWxnCoTJw0rLWBOkQs/56VozkWXtRj42Yw5E5yuQsDcwOa6dZ4e71HTH6SlHfWfFLQ/u582V8DuhYTfMSPZ/Y0J1d6Cx///+CsQN5uL6fTKF5kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEJiXXUG; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-646670c29dfso3309524eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 08:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759850894; x=1760455694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AtSgdu/zhEIwEp8jrIIUZRzuV/9W+89fOYn2ZCku1g=;
        b=jEJiXXUG2KQHvGXnPjLueqSKIZLtZuI4lNpCNC7hJdJVwG4bvX3FX3liXGXsdrwSFX
         WS2tQOrg8vwgiE5BG0xC/IxWvKjIbuuCY2Y9QoY+pc9WOdhlwFKNxpLFis9MkZKgknX9
         3E/qDsSGWmeqp0OCvcMuao/abHJiXu/soLzr2der2aAZkTi2dDaiUk/vqvPd+K6TjI7/
         81uDHCVucjZpebVOQqQ+C/IABnp9YGwWILYExWe/JFgBSHDMYuTfOkq7NmDmod+8Cq1W
         vw8JP9ZP9l0SZKM/F5SHnYJPba/lhQXWVfXsWvzN2Wd3UydXLybgsqKQGR/PHvo3SrkB
         1F5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759850894; x=1760455694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AtSgdu/zhEIwEp8jrIIUZRzuV/9W+89fOYn2ZCku1g=;
        b=HJl4DpcHaJugd4twJd1tojOCny4Ugc9zA0aJxauqkC6YS4oCGj2VxUb1EsURs0GItF
         cPpiZc5BAmX6K4r+lf7O0fKzC7qH+3U4tP3mpE/hF+wmI8iDWOESRl/TmYcld0cOGMiS
         av+fxp+LYlsRXTpqGu8K1m3d1r/sbY/CuHR9SqmTzaJhtEEWvQxXSFbmLTBALCSouiZt
         KdU5flAkyo1RLZyWxPYaNciJqUyC6VjBsq3HDyET8NQXz1mX9TKcAEb8EZGjFCCSWnw/
         w15iQqriiapkz5Ay4WqV0iy8ijHko57IiTTuiDXOqV/ZtojbWvaOMFuJr8xEQfTkP7bd
         ayIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVavmgJIXIXiV6yrHRQcC6AcdWPrkaaaLaCwAUUmweTdQAnFlRdMi7g/8yJ64Hvfqf+fur2gcLQ5hLHWU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqHYcIKa0U0b0dG3YQhxY0Um6M1WuQQPHluEQnJEiCL6pH0ojn
	MR/5ShxNPkgoFstsgY8sb86N9H0x3lpqiI11Its2wSB0Xfw6av2UQXSDcu03yWw8os71CCPs/u0
	mXcoZooMQ0EPJ6MFELjd1pdHoGFUx4XA=
X-Gm-Gg: ASbGnctuFc8abE2L7AktZXLB1ScOQb//K9fzhfDjcZZK7BAdE2ERtPYAjSVoceiQz4c
	bsotAVhj8BekdfQUkVa81PZtL7E7HkZpQKeqOaO4VBYVEISoyVs8VeNb30z70Q41Ob556kwMMfM
	0ErK897aRt5+NurO/Jje0jpB2dUVDV3nzyhIPty+TLyBOMcag8Qqj9FTksJQBwOfxi37jog45Pn
	RKChi9TC+vRNUuBcYScA7Oc8/zTW4kQytRVv8wQWdU=
X-Google-Smtp-Source: AGHT+IFFCD+05k/f2pnhMy8ZzAH383HR9gPRjWkOyfaj0oG6GpKVsVXnHQIOkpY8Be0wAaj5uUymmdOl4EjjYOj/MsA=
X-Received: by 2002:a05:6870:c1c6:b0:377:bbde:5278 with SMTP id
 586e51a60fabf-3b0fa24fd92mr9347675fac.37.1759850893884; Tue, 07 Oct 2025
 08:28:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002084204.15898-1-jjian.zhou@mediatek.com> <20251002084204.15898-3-jjian.zhou@mediatek.com>
In-Reply-To: <20251002084204.15898-3-jjian.zhou@mediatek.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Tue, 7 Oct 2025 10:28:00 -0500
X-Gm-Features: AS18NWA1zX6Oa-17YwjJlyhdpYlXfh240reFbRpuwEmWd3JTrDtYGE7kwX4p96A
Message-ID: <CABb+yY1Z+F=emOi2Q58bGv6AtKOMjY3qsNgRYqheNni+yN4_yQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] mailbox: mediatek: Add mtk-vcp-mailbox driver
To: Jjian Zhou <jjian.zhou@mediatek.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 3:42=E2=80=AFAM Jjian Zhou <jjian.zhou@mediatek.com>=
 wrote:
>
> Add mtk-vcp-mailbox driver to support the communication with
> VCP remote microprocessor.
>
> Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
> ---
>  drivers/mailbox/Kconfig                 |   9 ++
>  drivers/mailbox/Makefile                |   2 +
>  drivers/mailbox/mtk-vcp-mailbox.c       | 170 ++++++++++++++++++++++++
>  include/linux/mailbox/mtk-vcp-mailbox.h |  32 +++++
>  4 files changed, 213 insertions(+)
>  create mode 100644 drivers/mailbox/mtk-vcp-mailbox.c
>  create mode 100644 include/linux/mailbox/mtk-vcp-mailbox.h
>
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index 02432d4a5ccd..c28bdb855663 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -294,6 +294,15 @@ config MTK_CMDQ_MBOX
>           critical time limitation, such as updating display configuratio=
n
>           during the vblank.
>
> +config MTK_VCP_MBOX
> +       tristate "MediaTek VCP Mailbox Support"
> +       depends on ARCH_MEDIATEK || COMPILE_TEST
> +       help
> +         Say yes here to add support for the MediaTek VCP mailbox driver=
.
> +         The mailbox implementation provides access from the application
> +         processor to Video Companion Processor Unit.
> +         If unsure say N.
> +
>  config ZYNQMP_IPI_MBOX
>         tristate "Xilinx ZynqMP IPI Mailbox"
>         depends on ARCH_ZYNQMP && OF
> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> index 98a68f838486..07278871d254 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -63,6 +63,8 @@ obj-$(CONFIG_MTK_ADSP_MBOX)   +=3D mtk-adsp-mailbox.o
>
>  obj-$(CONFIG_MTK_CMDQ_MBOX)    +=3D mtk-cmdq-mailbox.o
>
> +obj-$(CONFIG_MTK_VCP_MBOX)     +=3D mtk-vcp-mailbox.o
> +
>  obj-$(CONFIG_ZYNQMP_IPI_MBOX)  +=3D zynqmp-ipi-mailbox.o
>
>  obj-$(CONFIG_SUN6I_MSGBOX)     +=3D sun6i-msgbox.o
> diff --git a/drivers/mailbox/mtk-vcp-mailbox.c b/drivers/mailbox/mtk-vcp-=
mailbox.c
> new file mode 100644
> index 000000000000..94dac59ca32b
> --- /dev/null
> +++ b/drivers/mailbox/mtk-vcp-mailbox.c
> @@ -0,0 +1,170 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 MediaTek Corporation. All rights reserved.
> + * Author: Jjian Zhou <jjian.zhou.@mediatek.com>
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/mailbox/mtk-vcp-mailbox.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +struct mtk_vcp_mbox {
> +       struct mbox_controller mbox;
> +       void __iomem *base;
> +       struct device *dev;
> +       const struct mtk_vcp_mbox_cfg *cfg;
> +       struct mtk_ipi_info ipi_recv;
> +       struct mbox_chan chans;
> +};
> +
> +struct mtk_vcp_mbox_cfg {
> +       u16 set_in;
> +       u16 clr_out;
> +};
> +
> +static irqreturn_t mtk_vcp_mbox_irq_thread(int irq, void *data)
> +{
> +       struct mtk_vcp_mbox *priv =3D data;
> +
> +       /* get irq status */
> +       priv->ipi_recv.irq_status =3D readl(priv->base + priv->cfg->clr_o=
ut);
> +
> +       __ioread32_copy(priv->ipi_recv.msg, priv->base,
> +                       MTK_VCP_MBOX_SLOT_MAX_SIZE / 4);
> +
> +       mbox_chan_received_data(&priv->chans, &priv->ipi_recv);
> +
> +       /* clear irq status */
> +       writel(priv->ipi_recv.irq_status, priv->base + priv->cfg->clr_out=
);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static struct mbox_chan *mtk_vcp_mbox_xlate(struct mbox_controller *mbox=
,
> +                                           const struct of_phandle_args =
*sp)
> +{
> +       if (sp->args_count)
> +               return NULL;
> +
> +       return &mbox->chans[0];
> +}
> +
> +static int mtk_vcp_mbox_send_data(struct mbox_chan *chan, void *data)
> +{
> +       struct mtk_vcp_mbox *priv =3D chan->con_priv;
> +       struct mtk_ipi_info *ipi_info =3D data;
> +       u32 status;
> +
> +       if (!ipi_info->msg) {
> +               dev_err(priv->dev, "msg buffer is NULL.\n");
> +               return -EINVAL;
> +       }
> +
> +       status =3D readl(priv->base + priv->cfg->set_in);
> +       if (status & BIT(ipi_info->index)) {
> +               dev_warn(priv->dev, "mailbox IPI %d is busy.\n", ipi_info=
->id);
> +               return -EBUSY;
> +       }
> +
> +       if (ipi_info->slot_ofs + ipi_info->len > MTK_VCP_MBOX_SLOT_MAX_SI=
ZE)
> +               return -EINVAL;
> +       __iowrite32_copy(priv->base + ipi_info->slot_ofs, ipi_info->msg,
> +                        ipi_info->len);
> +
> +       writel(BIT(ipi_info->index), priv->base + priv->cfg->set_in);
> +
> +       return 0;
> +}
> +
> +static bool mtk_vcp_mbox_last_tx_done(struct mbox_chan *chan)
> +{
> +       struct mtk_ipi_info *ipi_info =3D chan->active_req;
> +       struct mtk_vcp_mbox *priv =3D chan->con_priv;
> +
> +       return !(readl(priv->base + priv->cfg->set_in) & BIT(ipi_info->in=
dex));
> +}
> +
> +static const struct mbox_chan_ops mtk_vcp_mbox_chan_ops =3D {
> +       .send_data      =3D mtk_vcp_mbox_send_data,
> +       .last_tx_done   =3D mtk_vcp_mbox_last_tx_done,
> +};
> +
> +static int mtk_vcp_mbox_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct mtk_vcp_mbox *priv;
> +       struct mbox_controller *mbox;
> +       int ret, irq;
> +
> +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->dev =3D dev;
> +       priv->chans.con_priv =3D priv;
> +       mbox =3D &priv->mbox;
> +       mbox->dev =3D dev;
> +       mbox->ops =3D &mtk_vcp_mbox_chan_ops;
> +       mbox->txdone_irq =3D false;
> +       mbox->txdone_poll =3D true;
> +       mbox->of_xlate =3D mtk_vcp_mbox_xlate;
> +       mbox->num_chans =3D 1;
> +       mbox->chans =3D &priv->chans;
> +
> +       priv->ipi_recv.msg =3D devm_kzalloc(dev, MTK_VCP_MBOX_SLOT_MAX_SI=
ZE
> +                                         GFP_KERNEL);
>
Please compile-test at least before submitting. Dropping it, sorry.

-jassi

