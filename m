Return-Path: <linux-kernel+bounces-781160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A213B30E47
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAF793BA75E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 05:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8856A2E2DCE;
	Fri, 22 Aug 2025 05:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BUJqgqnW"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914902E1F07
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755841726; cv=none; b=EbeNJfZBZc2by5EZNAG55Qo36iLcq0FbEyKRo3SCwYq+OuTqlOEYRYln7JtM0C1kQieBSZenpTTz2DBACyIMeFqYSrzKkUloUFMvMr06C6MLjXCjQJPfjBAg115OD4S8KYLKHDW09DAIcrAuet48FvqOtIhGVlqwmmycS17tp90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755841726; c=relaxed/simple;
	bh=VvDF/q3zCaZ77aMVZ9htfP40TC1A+WQCr3bovyMHE70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g6TVV6iAStnTCr3QEt0OiXsMaH9BE3Szr0oPhIED9SGMAy5jdL9cN7oQfUB99jzbFjx3CEefa3i0lSO3eDYFbCcdkLM5vMbdjAGw5h9guHelZUzaRhNoGII+BCgAMxSjQj/d63Km/dArnhXyokIUsxAVWNBt665RbyGCrazEbmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BUJqgqnW; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55e041f6da0so1457519e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 22:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755841723; x=1756446523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoZdK50/K/LczwYuf75UT/ft4tdjCZI9J4+8Ndo+nls=;
        b=BUJqgqnW4+zlqVW21Qh4iq8oKIh2O/y9o578rP6Alko3Zh0TZx5p/beFT/SPyV9rND
         PxN2SY4jSaJp6HETsPRoCDurrGY9/JOVfEjnNvs22ZI0FsHSPFe0Wjyb2Y5LC8zeRomA
         0BZcmbSQcxKIcoAaq8SF4AUMTyeIl7twJ3lUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755841723; x=1756446523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JoZdK50/K/LczwYuf75UT/ft4tdjCZI9J4+8Ndo+nls=;
        b=fvm8qwNclEdXjetUqvmJR63IIMuNPsOBHJJYP6QRWHO/5NGSNt9q9ItonCVPKSHUJB
         e2d+H3QIW/xvRyldWxhWfPqK5UgphfuFiezYE8GQscIaKNg5u1g8Y1C4efy/X3klgKxY
         X4qIBrxWiUzsLGUUGdnaiqx8dI2L4ByEwrfNrMTnw5F8TsbBB1cXXDgzu8RFsiy0kPw0
         ZSej52Jt2Q8XYBoQ+D+6gEamSGkfM65f+xKNvPHiWrQvlOjqtpW68KCWtlDbnoSziVpv
         ocjQpLIXnQgaqQUuBPfP2K+141070G64Kj+TuG9ORPjxLlj/Fb9/2ZZHeQepRhZ7Q49o
         o9fQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3SinvCh2JJeuw9AvELIK54tfNwaoOIG/X/PnFQSgAxrpQpSagLe1H5gXNJE6PDTpS//Nr8BN8O5UoNsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEMbUB2TaqEY9/PwvukMBaAQC98uGKl76rc9+bjZ3kYXRB1U9I
	4CNKpdz3farEuCpt13zjZX7gT76MZBWNJZ+mMAS7emxfqXk0TB2HXM694BmgBK62gbaAts3zpzM
	njWHN41GTNRB+K4DUwzMjcYYN9SwpW/Gq1g/WvSZo
X-Gm-Gg: ASbGncvhNN1keYcSTVINlfPvdvWcjm8ZQ74C5nJXyR2JxTgLVPLtEOOhnlOwU/Tzysu
	ESva+EkTrFPd5YkJxTmeBidYJltEYTd+cf5VjB7JFkE3bJzT6VvnAOD5njsgzHhk9Eq6Tl5GeXg
	pov09cXNW2BfGR1oY5FaE7BBh6a8wj4CaMW4x9mPR1PUncpT806fgbeQLT9bTr350y2nCGQSoZ1
	1vXiUTFfqIx4xrjJbdBQIv9tmzF4sFT0Lw=
X-Google-Smtp-Source: AGHT+IEOuz9T18C75t4W7tyeC9lnODFUjUpRpgTCCiVHNHFZ4PPPT3oCCCaMJRon2fKjlUHHOi/9WQ3aPKorH0u9spA=
X-Received: by 2002:a05:6512:3186:b0:55b:9796:5d5a with SMTP id
 2adb3069b0e04-55f0cd0ab86mr647597e87.26.1755841722615; Thu, 21 Aug 2025
 22:48:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822021217.1598-1-jjian.zhou@mediatek.com> <20250822021217.1598-3-jjian.zhou@mediatek.com>
In-Reply-To: <20250822021217.1598-3-jjian.zhou@mediatek.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 22 Aug 2025 13:48:31 +0800
X-Gm-Features: Ac12FXyAx8hC-gVdNoD4NtkuABbLquAi1UhZ0eVGRrEels7y4nJgdo90ksrJ3Zs
Message-ID: <CAGXv+5GHSinkMHhBxRekfCxFK8my8JqeeRBsGXGuWDqH=MjmTQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] mailbox: mediatek: Add mtk-vcp-mailbox driver
To: Jjian Zhou <jjian.zhou@mediatek.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 10:12=E2=80=AFAM Jjian Zhou <jjian.zhou@mediatek.co=
m> wrote:
>
> Add mtk-vcp-mailbox driver to support the communication with
> VCP remote microprocessor.
>
> Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

A couple minor comments below.

> ---
>  drivers/mailbox/Kconfig                 |   9 ++
>  drivers/mailbox/Makefile                |   2 +
>  drivers/mailbox/mtk-vcp-mailbox.c       | 174 ++++++++++++++++++++++++
>  include/linux/mailbox/mtk-vcp-mailbox.h |  32 +++++
>  4 files changed, 217 insertions(+)
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
> index 000000000000..6f48215896d2
> --- /dev/null
> +++ b/drivers/mailbox/mtk-vcp-mailbox.c
> @@ -0,0 +1,174 @@
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
> +struct mtk_vcp_mbox_priv {
> +       void __iomem *base;
> +       struct device *dev;
> +       struct mbox_controller mbox;
> +       const struct mtk_vcp_mbox_cfg *cfg;
> +       struct mtk_ipi_info ipi_recv;
> +};
> +
> +struct mtk_vcp_mbox_cfg {
> +       u32 set_in;
> +       u32 clr_out;
> +};
> +
> +static inline struct mtk_vcp_mbox_priv *get_mtk_vcp_mbox_priv(struct mbo=
x_controller *mbox)
> +{
> +       return container_of(mbox, struct mtk_vcp_mbox_priv, mbox);
> +}
> +
> +static irqreturn_t mtk_vcp_mbox_irq_thread(int irq, void *data)
> +{
> +       struct mbox_chan *chan =3D data;
> +       struct mtk_vcp_mbox_priv *priv =3D get_mtk_vcp_mbox_priv(chan->mb=
ox);

Since there's only one mailbox, you can just pass the private data,
instead of passing the mbox_chan.

> +
> +       /* get irq status */
> +       priv->ipi_recv.irq_status =3D readl(priv->base + priv->cfg->clr_o=
ut);
> +
> +       __ioread32_copy(priv->ipi_recv.msg, priv->base, MBOX_SLOT_MAX_SIZ=
E / 4);
> +
> +       mbox_chan_received_data(chan, &priv->ipi_recv);
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
> +       return mbox->chans;
> +}
> +
> +static int mtk_vcp_mbox_send_data(struct mbox_chan *chan, void *data)
> +{
> +       struct mtk_vcp_mbox_priv *priv =3D get_mtk_vcp_mbox_priv(chan->mb=
ox);
> +       struct mtk_ipi_info *ipi_info =3D data;
> +       u32 status;
> +
> +       if (!ipi_info->msg) {
> +               dev_err(priv->dev, "msg buffer is NULL.\n");
> +               return -EINVAL;
> +       }
> +
> +       status =3D readl(priv->base + priv->cfg->set_in) & BIT(ipi_info->=
index);
> +       if (status) {
> +               dev_warn(priv->dev, "mailbox IPI %d is busy.\n", ipi_info=
->id);
> +               return -EBUSY;
> +       }
> +
> +       if (ipi_info->slot_ofs + ipi_info->len > MBOX_SLOT_MAX_SIZE)
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
> +       struct mtk_vcp_mbox_priv *priv =3D get_mtk_vcp_mbox_priv(chan->mb=
ox);
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
> +       struct mtk_vcp_mbox_priv *priv;
> +       struct mbox_controller *mbox;
> +       int ret, irq;
> +
> +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->dev =3D dev;
> +       mbox =3D &priv->mbox;
> +       mbox->dev =3D dev;
> +       mbox->ops =3D &mtk_vcp_mbox_chan_ops;
> +       mbox->txdone_irq =3D false;
> +       mbox->txdone_poll =3D true;
> +       mbox->of_xlate =3D mtk_vcp_mbox_xlate;
> +       mbox->num_chans =3D 1;
> +       mbox->chans =3D devm_kzalloc(dev, sizeof(*mbox->chans), GFP_KERNE=
L);
> +       if (!mbox->chans)
> +               return -ENOMEM;
> +
> +       priv->ipi_recv.msg =3D devm_kzalloc(dev, MBOX_SLOT_MAX_SIZE, GFP_=
KERNEL);
> +       if (!priv->ipi_recv.msg)
> +               return -ENOMEM;
> +
> +       priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(priv->base))
> +               return PTR_ERR(priv->base);
> +
> +       priv->cfg =3D of_device_get_match_data(dev);
> +       if (!priv->cfg)
> +               return -EINVAL;
> +
> +       irq =3D platform_get_irq(pdev, 0);
> +       if (irq < 0)
> +               return irq;
> +
> +       ret =3D devm_request_threaded_irq(dev, irq, NULL,
> +                                       mtk_vcp_mbox_irq_thread, IRQF_ONE=
SHOT,
> +                                       dev_name(dev), mbox->chans);
> +       if (ret < 0)
> +               return ret;
> +
> +       platform_set_drvdata(pdev, priv);
> +
> +       return devm_mbox_controller_register(dev, &priv->mbox);
> +}
> +
> +static const struct mtk_vcp_mbox_cfg mt8196_cfg =3D {
> +       .set_in         =3D 0x100,
> +       .clr_out        =3D 0x10C,

                                ^ use lowercase for hex numbers.

> +};
> +
> +static const struct of_device_id mtk_vcp_mbox_of_match[] =3D {
> +       { .compatible =3D "mediatek,mt8196-vcp-mbox", .data =3D &mt8196_c=
fg },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, mtk_vcp_mbox_of_match);
> +
> +static struct platform_driver mtk_vcp_mbox_driver =3D {
> +       .probe          =3D mtk_vcp_mbox_probe,
> +       .driver =3D {
> +               .name   =3D "mtk_vcp_mbox",
> +               .of_match_table =3D mtk_vcp_mbox_of_match,
> +       },
> +};
> +module_platform_driver(mtk_vcp_mbox_driver);
> +
> +MODULE_AUTHOR("Jjian Zhou <jjian.zhou@mediatek.com>");
> +MODULE_DESCRIPTION("MTK VCP Mailbox Controller");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mailbox/mtk-vcp-mailbox.h b/include/linux/mail=
box/mtk-vcp-mailbox.h
> new file mode 100644
> index 000000000000..143fb0d06e30
> --- /dev/null
> +++ b/include/linux/mailbox/mtk-vcp-mailbox.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + */
> +
> +#ifndef __MTK_VCP_MAILBOX_H__
> +#define __MTK_VCP_MAILBOX_H__
> +
> +#define MBOX_SLOT_MAX_SIZE     0x100 /* mbox max slot size */
> +
> +/**
> + * struct mtk_ipi_info - mailbox message info for mtk-vcp-mailbox
> + * @msg: The share buffer between IPC and mailbox driver
> + * @len: Message length
> + * @id: This is for identification purposes and not actually used
> + *     by the mailbox hardware.
> + * @index: The signal number of the mailbox message.
> + * @slot_ofs: Data slot offset.
> + * @irq_status: Captures incoming signals for the RX path.
> + *
> + * It is used between IPC with mailbox driver.
> + */
> +struct mtk_ipi_info {
> +       void *msg;
> +       u32 len;
> +       u32 id;
> +       u32 index;
> +       u32 slot_ofs;
> +       u32 irq_status;
> +};
> +
> +#endif
> --
> 2.46.0
>

