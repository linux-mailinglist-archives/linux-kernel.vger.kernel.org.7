Return-Path: <linux-kernel+bounces-899525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 732C3C58129
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C33E3A7811
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A580027FD40;
	Thu, 13 Nov 2025 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YdxRB4hM"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA24126ED5A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763045115; cv=none; b=jU9d8PPIXeo0qLBN2gQMkwvUQBiMDMqyRpb0sS17gvBf98yp6AjtWrO2Tr+bRYEDYqFtdVI/8P/iW80Htiv34U+KETyPL3mHqmNtm4tB9zfBCAX9445owVmSNep7c5V1BGT0YR0bHC9KrAESSyCNf0KZ1YxPvjzySfD8N/bSOOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763045115; c=relaxed/simple;
	bh=8WiMhuBKU7uISQx1WePYrV/nI54SOz4u0gi10cE+jSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GP4VE3bw/UclnletNVuquQMJelJugfjhWK2qbH3mXKcBW+1xJ4qCDM1lPp40CP91q7ErB9NKWVIk6PbJP81uLlcTkakdTs6XGA/UiBN8dCp2bhnmNyCu6VBDODYbw6DE+NoKUk80pF9BpQ8dou3XpXhOJ99UJ3iAsCQkesQ9bFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YdxRB4hM; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640ca678745so1769717a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763045112; x=1763649912; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m53OXX0FSEdVsD/HzcBlcWiZnahYMqqYD9/Rw82fxP8=;
        b=YdxRB4hM3WcPctqNqj59axi2UoJFTrgwueRSlVvey6kT1TEdma9Z9a1BizkBOkpj51
         PHeJ8UAfU9O6cQsFj4IhsxkqNRKIhI0J+ZeEr1MO+hYOOz3pSkU9wrJwJSC5Hl1234rO
         t9jc9Ji2vIvHy0Au22CUuOfQqTrbw+w9nt73iyQqVwZF2agpEG5XNPqDN/MxkkqIwAzy
         nSdtF6qSiCPI/oLn0uZYiB0xKWAMvD1OXFNyakhdmQtEdLftK1CoEPcPmvzV5ps7CbBC
         pwNQ2pRZMNBD3q43Sk/bOxxL5dyrnqBG2j9JQnLuVuyQa5jOsktE3zfPGnb7SLjkkcnk
         chIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763045112; x=1763649912;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m53OXX0FSEdVsD/HzcBlcWiZnahYMqqYD9/Rw82fxP8=;
        b=DCTlR/fnphncycUTSF1jbrWzKDzApARyBXnQETqpQXk60ijCfhz8bqZqDzX4X4wdc9
         LznpP4gwnS0+8rTctdrjU757NA5qw26ZzWAvAt8HBYyf4pe1Y9CX0sm3uuE5N6eelXc7
         1kk7x40fKMkit/GxfWir0tojjpbn0GlcTP8Ew7KnF3VTOUAuB/0Hb+nz5HmP4mTjk2ii
         +zsZ5iidqFAMP/K+vL05/rmYcmPVNZlCGBc/kmKSxLKX+7BllMPc4NEzI0lnXEO/sTR5
         d4Y3oY6ziIKFajMAAdzvBMY2juymiEOEtuhfwDyYnbyRMiMIn4A/IhAhq3923kO83QJL
         QpXA==
X-Forwarded-Encrypted: i=1; AJvYcCWiRPSBN6aN+bAlW7QOhiRLdKJNy6OpYWY6M+yb7oUBoVp4SYOkdhcCO6G0Gh0PcmzgTMQ+Df3e30TaSpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlN48E8HCF0NceHv65v1lcuKeKgSOTRSx3feIWg4tXoG1MEyD/
	PdsNyEahQhgw5JiBBMT5XFA7mqVLnMcz2AcvVRiHNpBGe30WKF4YgNwzCz6qsHdNoxyuUf/V8/Y
	afvUDktBBCvAh5pi/TIAtasqV4hLgek13cONf4Rw8EQ==
X-Gm-Gg: ASbGncseXXeSROd9OdZ+LFlTNYGr3j+yCwpWispiF7CdKtQCJ43QRIYd10ea/eRsryh
	pE8NE50EV0fvlack5xXm5WLlOSYUAm3ZU4/lb7LheahcPSp9JNc7Ssb3TmHPYn52FvWhI8QX1r7
	FQ+FlhD+mPCdoua7arTLu+fWN+ee+k4ElSSFZqUQMv6rZJlFlGFTUm9Kd5aWRZ7qpvEe17pK2T5
	vfHt5gf+piviSCU1ZDwX1rBqHmS3sN63AqAGAegc1s24xQ0+80E1xphDSrlJBdjSUjlegc785I4
	6ndB0MNr8JjLEg==
X-Google-Smtp-Source: AGHT+IH4jj6eVtxRt3wKbnn+UazVGdwbCJoI149sIZw96/aCkUMses1jDosEW0DIlhxtvuCWHuc2IKSjJmxjA9t2HMA=
X-Received: by 2002:a05:6402:42c8:b0:640:fb13:6b8 with SMTP id
 4fb4d7f45d1cf-6431a548655mr6370272a12.22.1763045111775; Thu, 13 Nov 2025
 06:45:11 -0800 (PST)
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
Date: Thu, 13 Nov 2025 15:44:58 +0100
X-Gm-Features: AWmQ_bkvZNjQ1Qh_dA2hcZ-2KrSCoqn4Hw9CqqUeyqhk9LfBW4EldGpwJgFMJrs
Message-ID: <CAKfTPtDCysLA6TLxUnP8-vsD4DwvPz2Ri6R5k6YE4ZtQY0uk8Q@mail.gmail.com>
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

I don't have access to such details but can't we have
DW_PCIE_LTSSM_L123_SEND_EIDLE or other transient state but PCIE_LINKUP
?

>
> I remember I asked if DEBUG0 register work? any conclusion?

I mentioned in the cover letter that I was still waiting feedback from
internal team before switching to DEBUG0 and DEBUG1 and remove
.get_ltssm() and .link_up()

I received the feedback earlier today that I can use DEBUG0 and
DEBUG1, so I don't need to implement .get_ltssm() and .link_up(). I
will remove them in the next version

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

