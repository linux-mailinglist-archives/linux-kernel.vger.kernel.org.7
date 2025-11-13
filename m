Return-Path: <linux-kernel+bounces-899929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B38BC592C0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8ACCA566B7F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227E3364E92;
	Thu, 13 Nov 2025 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lrx9Bw6q"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C878364E82
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053154; cv=none; b=uNu4MuP56qjNwF6S7i1PxglFSgKbtMD5OBEP2KGBsUnFbECdAA+JXgQUA5fQNJXYj6EZwzGXaPCazAV+/fi/k6A0S2ppZyvtzw9Wia0BIUwQ7N9Xr96UBxeky7CZuQox10jNZ6lIED29hOg2dTwcSOx09RGUxwH7dzAX8LmRlcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053154; c=relaxed/simple;
	bh=xbKveKZnMEV74izGFNst9sDTLVDcIA8bsSE/ScapJi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSaxFruBD/5Fwgu8eicmIPOvfa+nQuJ9rmuTwUAPDAbp72he56lWvMWVWYitSnSM3898rS46Ipm9bRkLWYCJriqhf76dsQEkXV9WI2sc6J/lXUy2Lbms7XOeEQ6y3W0HS+WU+6iJRtNp8mJAHy/347gvaDfxnqRzieDPUDPeK6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lrx9Bw6q; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so1546023a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763053148; x=1763657948; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nKGQCbFSZFfN1OMLvE+EkMUU0QXCTcfpOtpHJMHTRc0=;
        b=lrx9Bw6qpdH6H+eixVJo7Kmx80NYbIPWV3CZA0oLMasAs2uLHhFakqEzKubOYIxQrq
         EKJPO8tSKluoMyP5OP2WU6/Orx8bUgW12I1tzf/Ta+hicEMa9i7v5VBMJO8hwInbC6Fm
         mvGldX7zRaI6ry5+U3e59neunHpPnqUhRjoL6GHvA7yzjUgwOoX8w5AVf6lQ4Q15tEjy
         vG6NgrjmJyreiDsXiyO8kdcolOTWPWju5+JFoTQpxhjt2O0wpQ4FrvywuqwRiDsixZtp
         GTeUnBJemklSqeGz1FjFiyVhjtroEYfrSF/8Z8UChMTW4R+2UYMWGbraqIR8qKyI0E1S
         6R4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763053148; x=1763657948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKGQCbFSZFfN1OMLvE+EkMUU0QXCTcfpOtpHJMHTRc0=;
        b=a/LAT7AVoRJ1pWnwq1eetj1jxTSZdw+wEPIXt1sKn3GZ7amAGqUH4VA2cTilJ5e1LL
         vlLpFPMLs/W7KfX8+GAOirZB3hC0MDGZOZDPZ1L7N23QPOps5oA6uYn7lTiKYJD164IZ
         TcAG2XEXxP5yvcCgA5F2jHezOgG1yIjKrP200ChAU6mJf3YNtp9iNDU0HsOqnLNcr3bc
         BIquyXkL4yX5nq6ynnwntnQTphz5YAq76xlG4b4zuOpKkCqbN5avsYaOfEIhYneSIzTo
         2iVAnaE4BYSqbU11ydc746Uy6tulOMdjq/xET2sb5eM1HGQ4mNwhZmKy6sHMRI6cVGvo
         UXqw==
X-Forwarded-Encrypted: i=1; AJvYcCU+FmHXSpfAKk/oODKwc5GRY8HWrfu85nEuALnAAvbkuR/C4vpOywS3OoCZBNMc7a6JR08QxmiCyUIrLRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKhPMKiu/Tg/5hEXz9dYZksuws0737N3vVt1By+oiLEoBa2cVM
	6JI0CqQUyStLUJLjG4fO08qcB+S5KvvSJRfoT2lgYAwX8bKm7i+eABPiyduBRwZ0D0uZYHn2wi2
	NDW+irUsF0amKjJ7dM1GEaZ2zGzwHg84/hhsqFKXcBQ==
X-Gm-Gg: ASbGncs3rTil2URTCliXNYMnYNVwZBkhGpi5M3vASxZZTAn1//gzY92BsmEa84TUuvm
	todh9678hsUvA97HZQ2xBn5dJXkERU88qOJk+pwQZcyi0LJWSTEjjFSxoqZbRHF/XffEERtxRmX
	1Itl97alPHkV50JilNB5NX1YtM2UwI9OKzYvouUmEUhF4nFkU6+cM2M7vjavMRMW2jOxK/+Aayp
	QGDlzvNknfBt238Sz+sdNF90SISUtmVCWclSr2XfCIF/dpqImcPxAnjEg9fC7ZgTjQW5r/5hayT
	IVd4uIYF8EhN0Q==
X-Google-Smtp-Source: AGHT+IHNiNj5c6BzZKED1Z000ERZybmUuYkJX4r0ws3HcIoZwiOXufpN2vALmssDs7zOCU5+nbxIjpi4YX1O6qX0ouE=
X-Received: by 2002:a05:6402:254a:b0:63c:4da1:9a10 with SMTP id
 4fb4d7f45d1cf-6431a55e345mr6812988a12.31.1763053148461; Thu, 13 Nov 2025
 08:59:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110173334.234303-1-vincent.guittot@linaro.org>
 <20251110173334.234303-4-vincent.guittot@linaro.org> <aRI9T260bl9bok4W@lizhi-Precision-Tower-5810>
In-Reply-To: <aRI9T260bl9bok4W@lizhi-Precision-Tower-5810>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 13 Nov 2025 17:58:57 +0100
X-Gm-Features: AWmQ_bkUC0Olt3VIt07NPBKQfZFgoo8sTusuWbmfnXreuUvnA3jlm9GTd56XT6U
Message-ID: <CAKfTPtAFg-=k_Et8RMa4Ok1oBv87qpMrdiW+Xy9NixZAXUUm6w@mail.gmail.com>
Subject: Re: [PATCH 3/4 v4] PCI: s32g: Add initial PCIe support (RC)
To: Frank Li <Frank.li@nxp.com>
Cc: chester62515@gmail.com, mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, 
	s32@nxp.com, bhelgaas@google.com, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, 
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	cassel@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Nov 2025 at 20:30, Frank Li <Frank.li@nxp.com> wrote:
>
> On Mon, Nov 10, 2025 at 06:33:33PM +0100, Vincent Guittot wrote:
> > Add initial support of the PCIe controller for S32G Soc family. Only
> > host mode is supported.
> >
> > Co-developed-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> > Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> > Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> > Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> > Co-developed-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> > Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> > Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> > Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/Kconfig            |  10 +
> >  drivers/pci/controller/dwc/Makefile           |   1 +
> >  .../pci/controller/dwc/pcie-nxp-s32g-regs.h   |  27 ++
> >  drivers/pci/controller/dwc/pcie-nxp-s32g.c    | 435 ++++++++++++++++++
> >  4 files changed, 473 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h
> >  create mode 100644 drivers/pci/controller/dwc/pcie-nxp-s32g.c
> >
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > index 349d4657393c..e276956c3fca 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -256,6 +256,16 @@ config PCIE_TEGRA194_EP
> >         in order to enable device-specific features PCIE_TEGRA194_EP must be
> >         selected. This uses the DesignWare core.
> >
> > +config PCIE_NXP_S32G
> > +     tristate "NXP S32G PCIe controller (host mode)"
> > +     depends on ARCH_S32 || COMPILE_TEST
> > +     select PCIE_DW_HOST
> > +     help
> > +       Enable support for the PCIe controller in NXP S32G based boards to
> > +       work in Host mode. The controller is based on DesignWare IP and
> > +       can work either as RC or EP. In order to enable host-specific
> > +       features PCIE_NXP_S32G must be selected.
> > +
> >  config PCIE_DW_PLAT
> >       bool
> >
> > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> > index 7ae28f3b0fb3..3301bbbad78c 100644
> > --- a/drivers/pci/controller/dwc/Makefile
> > +++ b/drivers/pci/controller/dwc/Makefile
> > @@ -10,6 +10,7 @@ obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
> >  obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
> >  obj-$(CONFIG_PCIE_FU740) += pcie-fu740.o
> >  obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
> > +obj-$(CONFIG_PCIE_NXP_S32G) += pcie-nxp-s32g.o
> >  obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
> >  obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone.o
> >  obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
> > diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h b/drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h
> > new file mode 100644
> > index 000000000000..c264446a8f21
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h
> > @@ -0,0 +1,27 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright 2015-2016 Freescale Semiconductor, Inc.
> > + * Copyright 2016-2023, 2025 NXP
> > + */
> > +
> > +#ifndef PCIE_S32G_REGS_H
> > +#define PCIE_S32G_REGS_H
> > +
> > +/* PCIe controller Sub-System */
> > +
> > +/* PCIe controller 0 General Control 1 */
> > +#define PCIE_S32G_PE0_GEN_CTRL_1             0x50
> > +#define DEVICE_TYPE_MASK                     GENMASK(3, 0)
> > +#define SRIS_MODE                            BIT(8)
> > +
> > +/* PCIe controller 0 General Control 3 */
> > +#define PCIE_S32G_PE0_GEN_CTRL_3             0x58
> > +#define LTSSM_EN                             BIT(0)
> > +
> > +/* PCIe Controller 0 Link Debug 2 */
> > +#define PCIE_S32G_PE0_LINK_DBG_2             0xB4
> > +#define SMLH_LTSSM_STATE_MASK                        GENMASK(5, 0)
> > +#define SMLH_LINK_UP                         BIT(6)
> > +#define RDLH_LINK_UP                         BIT(7)
> > +
> > +#endif  /* PCI_S32G_REGS_H */
> > diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g.c b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> > new file mode 100644
> > index 000000000000..18bf0fe6f416
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> > @@ -0,0 +1,435 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PCIe host controller driver for NXP S32G SoCs
> > + *
> > + * Copyright 2019-2025 NXP
> > + */
> > +
> ...
> > +
> > +#define PCIE_LINKUP  (SMLH_LINK_UP | RDLH_LINK_UP)
> > +
> > +static bool s32g_has_data_phy_link(struct s32g_pcie *s32g_pp)
> > +{
> > +     u32 reg = s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_LINK_DBG_2);
> > +
> > +     if ((reg & PCIE_LINKUP) == PCIE_LINKUP) {
> > +             switch (FIELD_GET(SMLH_LTSSM_STATE_MASK, reg)) {
> > +             case DW_PCIE_LTSSM_L0:
> > +             case DW_PCIE_LTSSM_L0S:
> > +             case DW_PCIE_LTSSM_L1_IDLE:
> > +                     return true;
> > +             default:
> > +                     return false;
>
> Are you sure code can go here? I think IP set flag PCIE_LINKUP of
> PCIE_S32G_PE0_LINK_DBG_2 only after LTSSM in above states. Do you know
> which case PCIE_LINKUP is true, but LTSSM is not other state?
>
> I remember I asked if DEBUG0 register work? any conclusion?
>
> > +             }
> > +     }
> > +
> > +     return false;
> > +}
> > +
>
> ...
>
> > +
> > +static int s32g_pcie_parse_port(struct s32g_pcie *s32g_pp, struct device_node *node)
> > +{
> > +     struct device *dev = s32g_pp->pci.dev;
> > +     struct s32g_pcie_port *port;
> > +     int num_lanes;
> > +
> > +     port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> > +     if (!port)
> > +             return -ENOMEM;
> > +
> > +     port->phy = devm_of_phy_get(dev, node, NULL);
> > +     if (IS_ERR(port->phy))
> > +             return dev_err_probe(dev, PTR_ERR(port->phy),
> > +                             "Failed to get serdes PHY\n");
> > +
> > +     INIT_LIST_HEAD(&port->list);
> > +     list_add_tail(&port->list, &s32g_pp->ports);
> > +
> > +     /*
> > +      * The DWC core initialization code cannot parse yet the num-lanes
> > +      * attribute in the Root Port node. The S32G only supports one Root
> > +      * Port for now so its driver can parse the node and set the num_lanes
> > +      * field of struct dwc_pcie before calling dw_pcie_host_init().
> > +      */
> > +     if (!of_property_read_u32(node, "num-lanes", &num_lanes))
> > +             s32g_pp->pci.num_lanes = num_lanes;
>
> Can you add this to dwc core driver?

It has been agreed on v3 that I should handle this locally for now
until dwc core driver gets the support of root port nodes
https://lore.kernel.org/all/20251106173853.GA1959661@bhelgaas/

>
> Frank
>
> > +
> > +     return 0;
> > +}
> > +
> ...
> > --
> > 2.43.0
> >

