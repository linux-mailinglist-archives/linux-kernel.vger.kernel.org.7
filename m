Return-Path: <linux-kernel+bounces-727040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A222B01448
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D8ED3B7683
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237301EC01D;
	Fri, 11 Jul 2025 07:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxXEZau9"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F146B1EB5E1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 07:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218267; cv=none; b=Lb3Q5daH1QEvrkSzvSb2Skn+E9D1lAjI0CjxOFVQ+fE7DLarGgvW/nJyx11pSskA3QsI4Jl7FrNcmzOUNp/xkCZV0wDwG08XZ0O+HMLke2ss8XQTfJNl51VQRn5GWJTnFGf9HC4ULbJKYl2Cm45esOUuegH8GXEGGf6gX1g4CYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218267; c=relaxed/simple;
	bh=dU4Vxam6tmkoZD8X1nSniMjs5bLfpB3d6bX1PPf30bA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PF3bpsQO+siRF40iskd9qjhy/aRSryZIkl6YUEsnABeFVfMUC0FWxWSWPsY+UwtvQzzgPU7Qpw3wfNxrDXzM18dEKmyEgCDLtDI1p9B/la0dgI9lxN70DomYbtc3lxRP9egJUyesaom6fjWOoLTRqjQ+Jjb/mnQbmFO3wezk30s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxXEZau9; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae6f8d3bcd4so162970266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 00:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752218263; x=1752823063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWRc5pUaNh1O18bIqLW+j9CFRqzEifECzt47ktcRodQ=;
        b=LxXEZau996wQGc7uG0ABHsoh6QGuE0zzFMDhXbLwRphl+2We81BbwCRZejlIpbP2Lr
         MrBe4aCo7uSf7oO3cVCis++OnpnaYTTlYTLNHzYuThODXHTpK/FCW0/5fxPjvQ8RuQlB
         7Hkajoh72bwuKeyBwlntW2KhE4y4yM1VpD6uBZCW0Z8tbwCfLN0hgEL9ND37OcgNbjC3
         TAg6S4b/BZn7+klwpwFNoj/9QUSNMFjiDpnQu3/MNIY38Qy5+ILuVUYfl1spNyqjJg7w
         v1IyyEfTnTBlgtVCZdKLrGaGGavjREN0ZXptpfZWjjAfWKTLVexazt+hdCBOD0dj0SpC
         BKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752218263; x=1752823063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWRc5pUaNh1O18bIqLW+j9CFRqzEifECzt47ktcRodQ=;
        b=VRzHCRmMNxmsJON+08aMe8wTbi+pVqRUohB2ZDZZXOw4F8simwS+nux1dUg9Zje0OG
         i6uQZF99SC+G4bxPBDJOpb0yrcqOAXPjXdqoPqWFx0bpTD6RpQAbHjy8kWcfUWeF6+wM
         lUJIzCQVS4QMyjT7qP7aN0lht6jG1gBzeFlXuF/9tce8boZYCLwqDzlOGNgSxqJF656k
         mlr+K2Hd3W/ZYLk5t8TYMhVD2hWDYVJtT9rhwWxxNLprMkKr6TyENNxCLlUXbpF7vZi/
         6ppFdbKpjekTtrEmWaKj6t+BCcFvGIQnXWFPKgkDf9VmnAN7VRPmwz5MdnBJVtRoFmjF
         rvVw==
X-Forwarded-Encrypted: i=1; AJvYcCUeQIr56DeyiV3H3tBAD39WGj3eP1Nq+buno3hW+vMI5I6AWU1MMsZnpDO7U0I8UOcHJnNrpyCfhsi+9CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSvUAVGLUA7hGuNfChEKfNmSULJFWof5fThYti46ZVWrSQ5Eo7
	rsQPF/vr55wzrYHm2VrWYQUZ/bMDzrWXQmjWQAazoQ9vOks7MqCEQk+hLBj1B/jDO6Jmmxpz8U5
	fBehIP/jMDc3n8H4KXhZERMptXeTurFU=
X-Gm-Gg: ASbGnctgGtTn4bd7JRg56ODdTjUJi3FCdYWXKQLeKk7b3sguDQnLSQxg/vpQCahjlnE
	gp35LvWv3aJaUnnlSyN6vSu14elDSvrlVpIQX5J4Vt9d969a5Vi5uEbSm+kd+DxSX+I/do2zQob
	pSCvA9uhITbcz5kBR38VgyVJCGYb0MB5QYUaptImScPx2qnGvhXjMevrydtaPYwUTd24Jg40LBZ
	7ZERA==
X-Google-Smtp-Source: AGHT+IHpIX9V+TL1u6+R9yWg+ZCeKBpZavHgn72lKb+rrxX31vfCXHH6f7B8zJ2+gniGek6+ENa85LfXb8mZT1E9/nI=
X-Received: by 2002:a17:907:7b85:b0:ad5:5210:749c with SMTP id
 a640c23a62f3a-ae70114a7d3mr144281366b.22.1752218262693; Fri, 11 Jul 2025
 00:17:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751617911.git.zhoubinbin@loongson.cn> <2252dbc3970264371278182ebaf7669fe77d33a2.1751617911.git.zhoubinbin@loongson.cn>
 <20250710095629.GH1431498@google.com>
In-Reply-To: <20250710095629.GH1431498@google.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Fri, 11 Jul 2025 15:17:29 +0800
X-Gm-Features: Ac12FXyIj0PwTUdVcCo8GXPss6ZgMJPK6x5QPnR5rXAlwgg3Tj8tn_RVWkZ4FUQ
Message-ID: <CAMpQs4JccEmMAguB92jQriwD65Ra+hQKMZnjAsWhNOKhN_Om7A@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] mfd: ls2kbmc: Introduce Loongson-2K BMC core driver
To: Lee Jones <lee@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Corey Minyard <minyard@acm.org>, Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	openipmi-developer@lists.sourceforge.net, jeffbai@aosc.io, 
	kexybiscuit@aosc.io, wangyao@lemote.com, Chong Qiao <qiaochong@loongson.cn>, 
	Corey Minyard <corey@minyard.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lee:

Thanks for your review.

On Thu, Jul 10, 2025 at 5:56=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Fri, 04 Jul 2025, Binbin Zhou wrote:
>
> > The Loongson-2K Board Management Controller provides an PCIe interface
> > to the host to access the feature implemented in the BMC.
> >
> > The BMC is assembled on a server similar to the server machine with
> > Loongson-3 CPU. It supports multiple sub-devices like DRM and IPMI.
> >
> > Co-developed-by: Chong Qiao <qiaochong@loongson.cn>
> > Signed-off-by: Chong Qiao <qiaochong@loongson.cn>
> > Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> > Acked-by: Corey Minyard <corey@minyard.net>
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >  MAINTAINERS                 |   6 ++
> >  drivers/mfd/Kconfig         |  13 +++
> >  drivers/mfd/Makefile        |   2 +
> >  drivers/mfd/ls2k-bmc-core.c | 156 ++++++++++++++++++++++++++++++++++++
> >  4 files changed, 177 insertions(+)
> >  create mode 100644 drivers/mfd/ls2k-bmc-core.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0d053c45f7f9..4eb0f7b69d35 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14199,6 +14199,12 @@ S:   Maintained
> >  F:   Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.y=
aml
> >  F:   drivers/thermal/loongson2_thermal.c
> >
> > +LOONGSON-2K Board Management Controller (BMC) DRIVER
> > +M:   Binbin Zhou <zhoubinbin@loongson.cn>
> > +M:   Chong Qiao <qiaochong@loongson.cn>
> > +S:   Maintained
> > +F:   drivers/mfd/ls2k-bmc-core.c
> > +
> >  LOONGSON EDAC DRIVER
> >  M:   Zhao Qunqin <zhaoqunqin@loongson.cn>
> >  L:   linux-edac@vger.kernel.org
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index c635790afa75..47cc8ea9d2ef 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -2400,6 +2400,19 @@ config MFD_INTEL_M10_BMC_PMCI
> >         additional drivers must be enabled in order to use the function=
ality
> >         of the device.
> >
> > +config MFD_LS2K_BMC_CORE
> > +     bool "Loongson-2K Board Management Controller Support"
> > +     depends on PCI && ACPI_GENERIC_GSI
> > +     select MFD_CORE
> > +     help
> > +       Say yes here to add support for the Loongson-2K BMC which is a =
Board
> > +       Management Controller connected to the PCIe bus. The device sup=
ports
> > +       multiple sub-devices like display and IPMI. This driver provide=
s common
> > +       support for accessing the devices.
> > +
> > +       The display is enabled by default in the driver, while the IPMI=
 interface
> > +       is enabled independently through the IPMI_LS2K option in the IP=
MI section.
> > +
> >  config MFD_QNAP_MCU
> >       tristate "QNAP microcontroller unit core driver"
> >       depends on SERIAL_DEV_BUS
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index ca351cb0ddcc..675b4ec6ef4c 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -284,6 +284,8 @@ obj-$(CONFIG_MFD_INTEL_M10_BMC_CORE)   +=3D intel-m=
10-bmc-core.o
> >  obj-$(CONFIG_MFD_INTEL_M10_BMC_SPI)    +=3D intel-m10-bmc-spi.o
> >  obj-$(CONFIG_MFD_INTEL_M10_BMC_PMCI)   +=3D intel-m10-bmc-pmci.o
> >
> > +obj-$(CONFIG_MFD_LS2K_BMC_CORE)              +=3D ls2k-bmc-core.o
> > +
> >  obj-$(CONFIG_MFD_ATC260X)    +=3D atc260x-core.o
> >  obj-$(CONFIG_MFD_ATC260X_I2C)        +=3D atc260x-i2c.o
> >
> > diff --git a/drivers/mfd/ls2k-bmc-core.c b/drivers/mfd/ls2k-bmc-core.c
> > new file mode 100644
> > index 000000000000..50d560a4611c
> > --- /dev/null
> > +++ b/drivers/mfd/ls2k-bmc-core.c
> > @@ -0,0 +1,156 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Loongson-2K Board Management Controller (BMC) Core Driver.
> > + *
> > + * Copyright (C) 2024-2025 Loongson Technology Corporation Limited.
> > + *
> > + * Authors:
> > + *   Chong Qiao <qiaochong@loongson.cn>
> > + *   Binbin Zhou <zhoubinbin@loongson.cn>
> > + */
> > +
> > +#include <linux/aperture.h>
> > +#include <linux/errno.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/module.h>
> > +#include <linux/pci.h>
> > +#include <linux/pci_ids.h>
> > +#include <linux/platform_data/simplefb.h>
> > +#include <linux/platform_device.h>
> > +
> > +/* LS2K BMC resources */
> > +#define LS2K_DISPLAY_RES_START               (SZ_16M + SZ_2M)
> > +#define LS2K_IPMI_RES_SIZE           0x1C
> > +#define LS2K_IPMI0_RES_START         (SZ_16M + 0xF00000)
> > +#define LS2K_IPMI1_RES_START         (LS2K_IPMI0_RES_START + LS2K_IPMI=
_RES_SIZE)
> > +#define LS2K_IPMI2_RES_START         (LS2K_IPMI1_RES_START + LS2K_IPMI=
_RES_SIZE)
> > +#define LS2K_IPMI3_RES_START         (LS2K_IPMI2_RES_START + LS2K_IPMI=
_RES_SIZE)
> > +#define LS2K_IPMI4_RES_START         (LS2K_IPMI3_RES_START + LS2K_IPMI=
_RES_SIZE)
> > +
> > +static struct resource ls2k_display_resources[] =3D {
> > +     DEFINE_RES_MEM_NAMED(LS2K_DISPLAY_RES_START, SZ_4M, "simpledrm-re=
s"),
> > +};
> > +
> > +static struct resource ls2k_ipmi0_resources[] =3D {
> > +     DEFINE_RES_MEM_NAMED(LS2K_IPMI0_RES_START, LS2K_IPMI_RES_SIZE, "i=
pmi0-res"),
> > +};
> > +
> > +static struct resource ls2k_ipmi1_resources[] =3D {
> > +     DEFINE_RES_MEM_NAMED(LS2K_IPMI1_RES_START, LS2K_IPMI_RES_SIZE, "i=
pmi1-res"),
> > +};
> > +
> > +static struct resource ls2k_ipmi2_resources[] =3D {
> > +     DEFINE_RES_MEM_NAMED(LS2K_IPMI2_RES_START, LS2K_IPMI_RES_SIZE, "i=
pmi2-res"),
> > +};
> > +
> > +static struct resource ls2k_ipmi3_resources[] =3D {
> > +     DEFINE_RES_MEM_NAMED(LS2K_IPMI3_RES_START, LS2K_IPMI_RES_SIZE, "i=
pmi3-res"),
> > +};
> > +
> > +static struct resource ls2k_ipmi4_resources[] =3D {
> > +     DEFINE_RES_MEM_NAMED(LS2K_IPMI4_RES_START, LS2K_IPMI_RES_SIZE, "i=
pmi4-res"),
> > +};
> > +
> > +static struct mfd_cell ls2k_bmc_cells[] =3D {
> > +     MFD_CELL_RES("simple-framebuffer", ls2k_display_resources),
> > +     MFD_CELL_RES("ls2k-ipmi-si", ls2k_ipmi0_resources),
> > +     MFD_CELL_RES("ls2k-ipmi-si", ls2k_ipmi1_resources),
> > +     MFD_CELL_RES("ls2k-ipmi-si", ls2k_ipmi2_resources),
> > +     MFD_CELL_RES("ls2k-ipmi-si", ls2k_ipmi3_resources),
> > +     MFD_CELL_RES("ls2k-ipmi-si", ls2k_ipmi4_resources),
> > +};
> > +
> > +/*
> > + * Currently the Loongson-2K BMC hardware does not have an I2C interfa=
ce to adapt to the
> > + * resolution. We set the resolution by presetting "video=3D1280x1024-=
16@2M" to the BMC memory.
> > + */
> > +static int ls2k_bmc_parse_mode(struct pci_dev *pdev, struct simplefb_p=
latform_data *pd)
> > +{
> > +     char *mode;
> > +     int depth, ret;
> > +
> > +     /* The last 16M of PCI BAR0 is used to store the resolution strin=
g. */
> > +     mode =3D devm_ioremap(&pdev->dev, pci_resource_start(pdev, 0) + S=
Z_16M, SZ_16M);
> > +     if (!mode)
> > +             return -ENOMEM;
> > +
> > +     /* The resolution field starts with the flag "video=3D". */
> > +     if (!strncmp(mode, "video=3D", 6))
> > +             mode =3D mode + 6;
> > +
> > +     ret =3D kstrtoint(strsep(&mode, "x"), 10, &pd->width);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D kstrtoint(strsep(&mode, "-"), 10, &pd->height);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D kstrtoint(strsep(&mode, "@"), 10, &depth);
> > +     if (ret)
> > +             return ret;
> > +
> > +     pd->stride =3D pd->width * depth / 8;
> > +     pd->format =3D depth =3D=3D 32 ? "a8r8g8b8" : "r5g6b5";
> > +
> > +     return 0;
> > +}
> > +
> > +static int ls2k_bmc_probe(struct pci_dev *dev, const struct pci_device=
_id *id)
> > +{
> > +     struct simplefb_platform_data pd;
> > +     resource_size_t base;
> > +     int ret;
> > +
> > +     ret =3D pci_enable_device(dev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D ls2k_bmc_parse_mode(dev, &pd);
> > +     if (ret)
> > +             goto disable_pci;
> > +
> > +     ls2k_bmc_cells[0].platform_data =3D &pd;
> > +     ls2k_bmc_cells[0].pdata_size =3D sizeof(pd);
>
> This is fragile.
>
> Please identify the elements in ls2k_bmc_cells and use it to index here.
>
> See: `static struct mfd_cell as3711_subdevs`

How about this:

enum {
        LS2K_BMC_DISPLAY,
        LS2k_BMC_IPMI0,
        LS2k_BMC_IPMI1,
        LS2k_BMC_IPMI2,
        LS2k_BMC_IPMI3,
        LS2k_BMC_IPMI4,
};

static struct mfd_cell ls2k_bmc_cells[] =3D {
        [LS2K_BMC_DISPLAY] =3D {
                .name =3D "simple-framebuffer",
                .num_resources =3D ARRAY_SIZE(ls2k_display_resources),
                .resources =3D ls2k_display_resources
        },
        [LS2k_BMC_IPMI0] =3D {
                .name =3D "ls2k-ipmi-si",
                .num_resources =3D ARRAY_SIZE(ls2k_ipmi0_resources),
                .resources =3D ls2k_ipmi0_resources
        },
        [LS2k_BMC_IPMI1] =3D {
                .name =3D "ls2k-ipmi-si",
                .num_resources =3D ARRAY_SIZE(ls2k_ipmi1_resources),
                .resources =3D ls2k_ipmi1_resources
        },
        [LS2k_BMC_IPMI2] =3D {
                .name =3D "ls2k-ipmi-si",
                .num_resources =3D ARRAY_SIZE(ls2k_ipmi2_resources),
                .resources =3D ls2k_ipmi2_resources
        },
        [LS2k_BMC_IPMI3] =3D {
                .name =3D "ls2k-ipmi-si",
                .num_resources =3D ARRAY_SIZE(ls2k_ipmi3_resources),
                .resources =3D ls2k_ipmi3_resources
        },
        [LS2k_BMC_IPMI4] =3D {
                .name =3D "ls2k-ipmi-si",
                .num_resources =3D ARRAY_SIZE(ls2k_ipmi4_resources),
                .resources =3D ls2k_ipmi4_resources
        },
};

and

        ls2k_bmc_cells[LS2K_BMC_DISPLAY].platform_data =3D &pd;
        ls2k_bmc_cells[LS2K_BMC_DISPLAY].pdata_size =3D sizeof(pd);

>
> > +     base =3D dev->resource[0].start + LS2K_DISPLAY_RES_START;
> > +
> > +     /* Remove conflicting efifb device */
> > +     ret =3D aperture_remove_conflicting_devices(base, SZ_4M, "simple-=
framebuffer");
> > +     if (ret) {
> > +             dev_err(&dev->dev, "Failed to removed firmware framebuffe=
rs: %d\n", ret);
> > +             goto disable_pci;
> > +     }
> > +
> > +     return devm_mfd_add_devices(&dev->dev, PLATFORM_DEVID_AUTO,
> > +                                 ls2k_bmc_cells, ARRAY_SIZE(ls2k_bmc_c=
ells),
> > +                                 &dev->resource[0], 0, NULL);
> > +
> > +disable_pci:
> > +     pci_disable_device(dev);
> > +     return ret;
> > +}
> > +
> > +static void ls2k_bmc_remove(struct pci_dev *dev)
> > +{
> > +     pci_disable_device(dev);
> > +}
> > +
> > +static struct pci_device_id ls2k_bmc_devices[] =3D {
> > +     { PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, 0x1a05) },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(pci, ls2k_bmc_devices);
> > +
> > +static struct pci_driver ls2k_bmc_driver =3D {
> > +     .name =3D "ls2k-bmc",
> > +     .id_table =3D ls2k_bmc_devices,
> > +     .probe =3D ls2k_bmc_probe,
> > +     .remove =3D ls2k_bmc_remove,
> > +};
> > +module_pci_driver(ls2k_bmc_driver);
> > +
> > +MODULE_DESCRIPTION("Loongson-2K Board Management Controller (BMC) Core=
 driver");
> > +MODULE_AUTHOR("Loongson Technology Corporation Limited");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.47.1
> >
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]


--
Thanks.
Binbin

