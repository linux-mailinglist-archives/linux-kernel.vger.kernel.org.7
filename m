Return-Path: <linux-kernel+bounces-727058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05381B01482
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD33480EBB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B716B1E834B;
	Fri, 11 Jul 2025 07:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjmN7JEJ"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE321E51FA
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 07:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218665; cv=none; b=QEXtbQ278k4RhH72+z0YrOBYS6qhBgREF0PtItu4AkP3V9IrUjUe1+AT1tdUQtwNAqyIKtM8idfPswoUQmgrvuFDpycQlH2ca5mlILYqXxR5fr6UTM3ij5hM0bfXLsI01nWQfunoadCBD/r5XDmEWKgmoFDTYUhCL9be/ekWPbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218665; c=relaxed/simple;
	bh=Cmv0sohwcpgbKyebY4AHdXHR/OuX+cfkmkFO7zjx050=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/fclNO1QIerhefXvZlDsubPvf7jZ9cBvJxrEuT4CpNRCz22tdQBpnghhbr/uSu8koGa+MTAah9MwGwcU9JGKgTnVO70yG1n7OGmNcxQVa2HZaeWDqVGY7bov94eUJ+X2q0DmBwdNe8Dq9ZhflX/BK7r5pojujRJv1ircbTLssU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjmN7JEJ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0dffaa8b2so353751066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 00:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752218662; x=1752823462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/hqZW9DPxug0ZFcJ8UGAasFcG1J9mWM8IJ7Yzp7JuQ=;
        b=TjmN7JEJ48r3oT+oodKUxiPyZh4GgnoAWDcK3+2v/H53u43uDNeCDBzH9L7SUr+5Ir
         SX3pCnkiRdyjwEFVHP5edmXq+YOurbvLxhBRR7wy6sUX88aTqYrEMowsOyUs1dm3LfsY
         h+9TB90D/23lEZW4xkI5vaILsz+PBj9bhF4OqbLT9VAYAe/MEVFbEsk1JxRDwh3z7mHi
         Llu/ZpoVlPjPyVfdcgqIuITABU2ljl/RGXtaBRYnXApqRz6AvocsKt+PxEG8YnZoSXkF
         ORf7GTTh32/wtNX2j9ZOE617fEHrtS23AF2vSKQYxokbQCPpMvpA87D2jr5MtcEqYAhd
         VRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752218662; x=1752823462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/hqZW9DPxug0ZFcJ8UGAasFcG1J9mWM8IJ7Yzp7JuQ=;
        b=WZG0Q+MPQVkSLWMa4pX0+6RIfL4F7NFtOtDRS1lmXDcTX+hEpZ+jPVzvDUZF2fJUtm
         lrd1kATClbzlzIf3uUVQ8y0qlkEfSmLxIjGmeO09x2SvQBI4hXSPREp4I9ytqzIiy/uD
         jKPijD064Wx7DwT2de4cOHAk7mGTm3LmkPB+UlPQGiib63MaehTKKDuJVIlpYXRGxbCI
         xbfG3m+/SBk8BiNjj1OBeQWgQWxsFQRyAhNCSnpd5kW9nHVMV4EJJEarSmd6OTi9IpYo
         pk7T6yiP1I0ZnP4iHCjC/aGiR7r8C1aBc59hqJsJEE9TQoq77btCOVus6+/OA5QsU8FO
         DPoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFT/SQP+8RvHCMkr3XJRrFwXeTjcWwTMhUzgsb1IgytbjHfV0A60hmfnHpfhbzTplqQyG+FDGGbqEOdn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF1pXCwA2JRiCqX/7i0ydewGUjsv4Y+gt/35SwRksf2CXVN6Nz
	jBZPprXf63knM+GZTQY26KuOqg+pRhx6LdT4FzYpi1g4bZSf+/aFQ4kD9DuQW+gNFDgRCll5l32
	iDxPl93nYmKdL0HKw28hAARVvSoU9/us=
X-Gm-Gg: ASbGncvfB3xoIIuJR0XCdjBmkDFRHakSTInOG742E4umLaDXH6l63WITNwZE8fDI8Fr
	ny6hF1neAgq+AYolJvQfalNTmL05gZ3x6Ak104OOUlPsFrtMMrKQGGJhZXRha1+tJO4EN9sg3Oh
	8qG3XeFERw33/JsjFF4I70bKAn6xnkq8Y3kvzoIwXZ8PmGYfdHK0UzC002pXSll0fZg+Jrdgr+e
	s4P6Hz3ZxllW9wY
X-Google-Smtp-Source: AGHT+IGW+KZpXpWrW1wbK2rH6wKFJzndPVegp2X2t3FnBTWH7n/psKv2guYkXzpAcmj2dFco3GPknhEBIuswGFhLP6I=
X-Received: by 2002:a17:907:fdcb:b0:ae6:c158:15cc with SMTP id
 a640c23a62f3a-ae6fc0edd42mr235545566b.53.1752218661235; Fri, 11 Jul 2025
 00:24:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751617911.git.zhoubinbin@loongson.cn> <f4c546b0160294296c98b6b12b0ab1d2000dd44c.1751617911.git.zhoubinbin@loongson.cn>
 <20250710100323.GI1431498@google.com>
In-Reply-To: <20250710100323.GI1431498@google.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Fri, 11 Jul 2025 15:24:08 +0800
X-Gm-Features: Ac12FXxWf2hb1NQk3MrP4tCNtLQA4BPgcFWd1IVvJ39GjJ6J4D1QkcCrGKmGRv0
Message-ID: <CAMpQs4LQME7oO8i2FWgUsAQqwThcp=R3jubPGqZ1Vr-pvEHvoA@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] mfd: ls2kbmc: Add Loongson-2K BMC reset function support
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

On Thu, Jul 10, 2025 at 6:03=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Fri, 04 Jul 2025, Binbin Zhou wrote:
>
> > Since the display is a sub-function of the Loongson-2K BMC, when the
> > BMC reset, the entire BMC PCIe is disconnected, including the display
> > which is interrupted.
> >
> > Quick overview of the entire LS2K BMC reset process:
> >
> > There are two types of reset methods: soft reset (BMC-initiated reboot
> > of IPMI reset command) and BMC watchdog reset (watchdog timeout).
> >
> > First, regardless of the method, an interrupt is generated (PCIe interr=
upt
> > for soft reset/GPIO interrupt for watchdog reset);
> >
> > Second, during the interrupt process, the system enters bmc_reset_work,
> > clears the bus/IO/mem resources of the LS7A PCI-E bridge, waits for the=
 BMC
> > reset to begin, then restores the parent device's PCI configuration spa=
ce,
> > waits for the BMC reset to complete, and finally restores the BMC PCI
> > configuration space.
> >
> > Display restoration occurs last.
> >
> > Co-developed-by: Chong Qiao <qiaochong@loongson.cn>
> > Signed-off-by: Chong Qiao <qiaochong@loongson.cn>
> > Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> > Acked-by: Corey Minyard <corey@minyard.net>
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >  drivers/mfd/ls2k-bmc-core.c | 328 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 328 insertions(+)
> >
> > diff --git a/drivers/mfd/ls2k-bmc-core.c b/drivers/mfd/ls2k-bmc-core.c
> > index 50d560a4611c..1ae673f6a196 100644
> > --- a/drivers/mfd/ls2k-bmc-core.c
> > +++ b/drivers/mfd/ls2k-bmc-core.c
> > @@ -10,8 +10,12 @@
> >   */
> >
> >  #include <linux/aperture.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/delay.h>
> >  #include <linux/errno.h>
> >  #include <linux/init.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/kbd_kern.h>
> >  #include <linux/kernel.h>
> >  #include <linux/mfd/core.h>
> >  #include <linux/module.h>
> > @@ -19,6 +23,8 @@
> >  #include <linux/pci_ids.h>
> >  #include <linux/platform_data/simplefb.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/stop_machine.h>
> > +#include <linux/vt_kern.h>
> >
> >  /* LS2K BMC resources */
> >  #define LS2K_DISPLAY_RES_START               (SZ_16M + SZ_2M)
> > @@ -29,6 +35,48 @@
> >  #define LS2K_IPMI3_RES_START         (LS2K_IPMI2_RES_START + LS2K_IPMI=
_RES_SIZE)
> >  #define LS2K_IPMI4_RES_START         (LS2K_IPMI3_RES_START + LS2K_IPMI=
_RES_SIZE)
> >
> > +#define LS7A_PCI_CFG_SIZE            0x100
> > +
> > +/* LS7A bridge registers */
> > +#define LS7A_PCIE_PORT_CTL0          0x0
> > +#define LS7A_PCIE_PORT_STS1          0xC
> > +#define LS7A_GEN2_CTL                        0x80C
> > +#define LS7A_SYMBOL_TIMER            0x71C
> > +
> > +/* Bits of LS7A_PCIE_PORT_CTL0 */
> > +#define LS2K_BMC_PCIE_LTSSM_ENABLE   BIT(3)
> > +
> > +/* Bits of LS7A_PCIE_PORT_STS1 */
> > +#define LS2K_BMC_PCIE_LTSSM_STS              GENMASK(5, 0)
> > +#define LS2K_BMC_PCIE_CONNECTED              0x11
> > +
> > +#define LS2K_BMC_PCIE_DELAY_US               1000
> > +#define LS2K_BMC_PCIE_TIMEOUT_US     1000000
> > +
> > +/* Bits of LS7A_GEN2_CTL */
> > +#define LS7A_GEN2_SPEED_CHANG                BIT(17)
> > +#define LS7A_CONF_PHY_TX             BIT(18)
> > +
> > +/* Bits of LS7A_SYMBOL_TIMER */
> > +#define LS7A_MASK_LEN_MATCH          BIT(26)
> > +
> > +/* Interval between interruptions */
> > +#define LS2K_BMC_INT_INTERVAL                (60 * HZ)
> > +
> > +/* Maximum time to wait for U-Boot and DDR to be ready with ms. */
> > +#define LS2K_BMC_RESET_WAIT_TIME     10000
> > +
> > +/* It's an experience value */
> > +#define LS7A_BAR0_CHECK_MAX_TIMES    2000
> > +
> > +#define LS2K_BMC_RESET_GPIO          14
> > +#define LOONGSON_GPIO_REG_BASE               0x1FE00500
> > +#define LOONGSON_GPIO_REG_SIZE               0x18
> > +#define LOONGSON_GPIO_OEN            0x0
> > +#define LOONGSON_GPIO_FUNC           0x4
> > +#define LOONGSON_GPIO_INTPOL         0x10
> > +#define LOONGSON_GPIO_INTEN          0x14
> > +
> >  static struct resource ls2k_display_resources[] =3D {
> >       DEFINE_RES_MEM_NAMED(LS2K_DISPLAY_RES_START, SZ_4M, "simpledrm-re=
s"),
> >  };
> > @@ -62,6 +110,273 @@ static struct mfd_cell ls2k_bmc_cells[] =3D {
> >       MFD_CELL_RES("ls2k-ipmi-si", ls2k_ipmi4_resources),
> >  };
> >
> > +/* Index of the BMC PCI configuration space to be restored at BMC rese=
t. */
> > +struct ls2k_bmc_pci_data {
> > +     u32 pci_command;
> > +     u32 base_address0;
> > +     u32 interrupt_line;
> > +};
> > +
> > +/* Index of the parent PCI configuration space to be restored at BMC r=
eset. */
> > +struct ls2k_bmc_bridge_pci_data {
> > +     u32 pci_command;
> > +     u32 base_address[6];
> > +     u32 rom_addreess;
> > +     u32 interrupt_line;
> > +     u32 msi_hi;
> > +     u32 msi_lo;
> > +     u32 devctl;
> > +     u32 linkcap;
> > +     u32 linkctl_sts;
> > +     u32 symbol_timer;
> > +     u32 gen2_ctrl;
> > +};
> > +
> > +struct ls2k_bmc_pdata {
> > +     struct device *dev;
> > +     struct work_struct bmc_reset_work;
> > +     struct ls2k_bmc_pci_data bmc_pci_data;
> > +     struct ls2k_bmc_bridge_pci_data bridge_pci_data;
> > +};
> > +
> > +static bool ls2k_bmc_bar0_addr_is_set(struct pci_dev *ppdev)
>
> Nit: This is usually called pdev.

OK.
>
> > +{
> > +     u32 addr;
> > +
> > +     pci_read_config_dword(ppdev, PCI_BASE_ADDRESS_0, &addr);
> > +
> > +     return addr & PCI_BASE_ADDRESS_MEM_MASK ? true : false;
> > +}
> > +
> > +static bool ls2k_bmc_pcie_is_connected(struct pci_dev *parent, struct =
ls2k_bmc_pdata *priv)
>
> Nit: Rename priv to ddata.

OK. I will check and rename all `priv` to `ddata`.
>
> > +{
> > +     void __iomem *base;
> > +     int sts, ret;
> > +
> > +     base =3D pci_iomap(parent, 0, LS7A_PCI_CFG_SIZE);
> > +     if (!base)
> > +             return false;
> > +
> > +     writel(readl(base + LS7A_PCIE_PORT_CTL0) | LS2K_BMC_PCIE_LTSSM_EN=
ABLE,
> > +            base + LS7A_PCIE_PORT_CTL0);
> > +
> > +     ret =3D readl_poll_timeout_atomic(base + LS7A_PCIE_PORT_STS1, sts=
,
> > +                                     (sts & LS2K_BMC_PCIE_LTSSM_STS) =
=3D=3D LS2K_BMC_PCIE_CONNECTED,
> > +                                     LS2K_BMC_PCIE_DELAY_US, LS2K_BMC_=
PCIE_TIMEOUT_US);
> > +     if (ret) {
> > +             pci_iounmap(parent, base);
> > +             dev_err(priv->dev, "PCIE train failed status=3D0x%x\n", s=
ts);
> > +             return false;
> > +     }
> > +
> > +     pci_iounmap(parent, base);
> > +     return true;
> > +}
> > +
> > +static void ls2k_bmc_restore_bridge_pci_data(struct pci_dev *parent, s=
truct ls2k_bmc_pdata *priv)
> > +{
> > +     int base, i =3D 0;
> > +
> > +     pci_write_config_dword(parent, PCI_COMMAND, priv->bridge_pci_data=
.pci_command);
> > +
> > +     for (base =3D PCI_BASE_ADDRESS_0; base <=3D PCI_BASE_ADDRESS_5; b=
ase +=3D 4, i++)
> > +             pci_write_config_dword(parent, base, priv->bridge_pci_dat=
a.base_address[i]);
> > +
> > +     pci_write_config_dword(parent, PCI_ROM_ADDRESS, priv->bridge_pci_=
data.rom_addreess);
> > +     pci_write_config_dword(parent, PCI_INTERRUPT_LINE, priv->bridge_p=
ci_data.interrupt_line);
> > +
> > +     pci_write_config_dword(parent, parent->msi_cap + PCI_MSI_ADDRESS_=
LO,
> > +                            priv->bridge_pci_data.msi_lo);
> > +     pci_write_config_dword(parent, parent->msi_cap + PCI_MSI_ADDRESS_=
HI,
> > +                            priv->bridge_pci_data.msi_hi);
> > +     pci_write_config_dword(parent, parent->pcie_cap + PCI_EXP_DEVCTL,
> > +                            priv->bridge_pci_data.devctl);
> > +     pci_write_config_dword(parent, parent->pcie_cap + PCI_EXP_LNKCAP,
> > +                            priv->bridge_pci_data.linkcap);
> > +     pci_write_config_dword(parent, parent->pcie_cap + PCI_EXP_LNKCTL,
> > +                            priv->bridge_pci_data.linkctl_sts);
> > +
> > +     pci_write_config_dword(parent, LS7A_GEN2_CTL, priv->bridge_pci_da=
ta.gen2_ctrl);
> > +     pci_write_config_dword(parent, LS7A_SYMBOL_TIMER, priv->bridge_pc=
i_data.symbol_timer);
> > +}
> > +
> > +static int ls2k_bmc_recover_pci_data(void *data)
> > +{
> > +     struct ls2k_bmc_pdata *priv =3D data;
> > +     struct pci_dev *pdev =3D to_pci_dev(priv->dev);
> > +     struct pci_dev *parent =3D pdev->bus->self;
> > +     u32 i;
> > +
> > +     /*
> > +      * Clear the bus, io and mem resources of the PCI-E bridge to zer=
o, so that
> > +      * the processor can not access the LS2K PCI-E port, to avoid cra=
shing due to
> > +      * the lack of return signal from accessing the LS2K PCI-E port.
> > +      */
> > +     pci_write_config_dword(parent, PCI_BASE_ADDRESS_2, 0);
> > +     pci_write_config_dword(parent, PCI_BASE_ADDRESS_3, 0);
> > +     pci_write_config_dword(parent, PCI_BASE_ADDRESS_4, 0);
> > +
> > +     /*
> > +      * When the LS2K BMC is reset, the LS7A PCI-E port is also reset,=
 and its PCI
> > +      * BAR0 register is cleared. Due to the time gap between the GPIO=
 interrupt
> > +      * generation and the LS2K BMC reset, the LS7A PCI BAR0 register =
is read to
> > +      * determine whether the reset has begun.
> > +      */
> > +     for (i =3D LS7A_BAR0_CHECK_MAX_TIMES; i > 0 ; i--) {
> > +             if (!ls2k_bmc_bar0_addr_is_set(parent))
> > +                     break;
> > +             mdelay(1);
> > +     };
> > +
> > +     if (i =3D=3D 0)
> > +             return false;
> > +
> > +     ls2k_bmc_restore_bridge_pci_data(parent, priv);
> > +
> > +     /* Check if PCI-E is connected */
> > +     if (!ls2k_bmc_pcie_is_connected(parent, priv))
> > +             return false;
> > +
> > +     /* Waiting for U-Boot and DDR ready */
> > +     mdelay(LS2K_BMC_RESET_WAIT_TIME);
> > +     if (!ls2k_bmc_bar0_addr_is_set(parent))
> > +             return false;
> > +
> > +     /* Restore LS2K BMC PCI-E config data */
> > +     pci_write_config_dword(pdev, PCI_COMMAND, priv->bmc_pci_data.pci_=
command);
> > +     pci_write_config_dword(pdev, PCI_BASE_ADDRESS_0, priv->bmc_pci_da=
ta.base_address0);
> > +     pci_write_config_dword(pdev, PCI_INTERRUPT_LINE, priv->bmc_pci_da=
ta.interrupt_line);
> > +
> > +     return 0;
> > +}
> > +
> > +static void ls2k_bmc_events_fn(struct work_struct *work)
> > +{
> > +     struct ls2k_bmc_pdata *priv =3D container_of(work, struct ls2k_bm=
c_pdata, bmc_reset_work);
> > +
> > +     /*
> > +      * The PCI-E is lost when the BMC resets, at which point access t=
o the PCI-E
> > +      * from other CPUs is suspended to prevent a crash.
> > +      */
> > +     stop_machine(ls2k_bmc_recover_pci_data, priv, NULL);
> > +
> > +#ifdef CONFIG_VT
>
> #ifery in C-files is generally frowned upon.
>
> Is the any pieces of run-time data you can use instead?
>
> Or a stub which culminated in a no-op if !CONFIG_VT?

Emm, I'm not sure if I understand correctly, but is the following way suita=
ble?

        if (IS_ENABLED(CONFIG_VT))
                /* Re-push the display due to previous PCI-E loss. */
                set_console(vt_move_to_console(MAX_NR_CONSOLES - 1, 1));

>
> > +     /* Re-push the display due to previous PCI-E loss. */
> > +     set_console(vt_move_to_console(MAX_NR_CONSOLES - 1, 1));
> > +#endif
> > +}
> > +
> > +static irqreturn_t ls2k_bmc_interrupt(int irq, void *arg)
> > +{
> > +     struct ls2k_bmc_pdata *priv =3D arg;
> > +     static unsigned long last_jiffies;
> > +
> > +     if (system_state !=3D SYSTEM_RUNNING)
> > +             return IRQ_HANDLED;
> > +
> > +     /* Skip interrupt in LS2K_BMC_INT_INTERVAL */
> > +     if (time_after(jiffies, last_jiffies + LS2K_BMC_INT_INTERVAL)) {
> > +             schedule_work(&priv->bmc_reset_work);
> > +             last_jiffies =3D jiffies;
> > +     }
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +/*
> > + * Saves the BMC parent device (LS7A) and its own PCI configuration sp=
ace registers
> > + * that need to be restored after BMC reset.
> > + */
> > +static void ls2k_bmc_save_pci_data(struct pci_dev *pdev, struct ls2k_b=
mc_pdata *priv)
> > +{
> > +     struct pci_dev *parent =3D pdev->bus->self;
> > +     int base, i =3D 0;
> > +
> > +     pci_read_config_dword(parent, PCI_COMMAND, &priv->bridge_pci_data=
.pci_command);
> > +
> > +     for (base =3D PCI_BASE_ADDRESS_0; base <=3D PCI_BASE_ADDRESS_5; b=
ase +=3D 4, i++)
> > +             pci_read_config_dword(parent, base, &priv->bridge_pci_dat=
a.base_address[i]);
> > +
> > +     pci_read_config_dword(parent, PCI_ROM_ADDRESS, &priv->bridge_pci_=
data.rom_addreess);
> > +     pci_read_config_dword(parent, PCI_INTERRUPT_LINE, &priv->bridge_p=
ci_data.interrupt_line);
> > +
> > +     pci_read_config_dword(parent, parent->msi_cap + PCI_MSI_ADDRESS_L=
O,
> > +                           &priv->bridge_pci_data.msi_lo);
> > +     pci_read_config_dword(parent, parent->msi_cap + PCI_MSI_ADDRESS_H=
I,
> > +                           &priv->bridge_pci_data.msi_hi);
> > +
> > +     pci_read_config_dword(parent, parent->pcie_cap + PCI_EXP_DEVCTL,
> > +                           &priv->bridge_pci_data.devctl);
> > +     pci_read_config_dword(parent, parent->pcie_cap + PCI_EXP_LNKCAP,
> > +                           &priv->bridge_pci_data.linkcap);
> > +     pci_read_config_dword(parent, parent->pcie_cap + PCI_EXP_LNKCTL,
> > +                           &priv->bridge_pci_data.linkctl_sts);
> > +
> > +     pci_read_config_dword(parent, LS7A_GEN2_CTL, &priv->bridge_pci_da=
ta.gen2_ctrl);
> > +     priv->bridge_pci_data.gen2_ctrl |=3D FIELD_PREP(LS7A_GEN2_SPEED_C=
HANG, 0x1)
> > +                                     | FIELD_PREP(LS7A_CONF_PHY_TX, 0x=
0);
> > +
> > +     pci_read_config_dword(parent, LS7A_SYMBOL_TIMER, &priv->bridge_pc=
i_data.symbol_timer);
> > +     priv->bridge_pci_data.symbol_timer |=3D LS7A_MASK_LEN_MATCH;
> > +
> > +     pci_read_config_dword(pdev, PCI_COMMAND, &priv->bmc_pci_data.pci_=
command);
> > +     pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &priv->bmc_pci_da=
ta.base_address0);
> > +     pci_read_config_dword(pdev, PCI_INTERRUPT_LINE, &priv->bmc_pci_da=
ta.interrupt_line);
> > +}
> > +
> > +static int ls2k_bmc_pdata_initial(struct pci_dev *pdev, struct ls2k_bm=
c_pdata *priv)
> > +{
> > +     int gsi =3D 16 + (LS2K_BMC_RESET_GPIO & 7);
> > +     void __iomem *gpio_base;
> > +     int irq, ret;
> > +
> > +     ls2k_bmc_save_pci_data(pdev, priv);
> > +
> > +     INIT_WORK(&priv->bmc_reset_work, ls2k_bmc_events_fn);
> > +
> > +     ret =3D devm_request_irq(&pdev->dev, pdev->irq, ls2k_bmc_interrup=
t,
> > +                            IRQF_SHARED | IRQF_TRIGGER_FALLING, "ls2kb=
mc pcie", priv);
> > +     if (ret) {
> > +             dev_err(priv->dev, "LS2KBMC PCI-E request_irq(%d) failed\=
n", pdev->irq);
>
> Please don't use function names in error messages.
>
> Make them human readable inclusive of non-kernel engineers.

How about:

dev_err(ddata->dev, "Failed to request LS2KBMC PCI-E IRQ %d.\n", pdev->irq)=
;

also, the error message regarding GPIO IRQ is as follows:

dev_err(ddata->dev, "Failed to request LS2KBMC GPIO IRQ %d.\n", irq);
>
> > +             return ret;
> > +     }
> > +
> > +     /*
> > +      * Since gpio_chip->to_irq is not implemented in the Loongson-3 G=
PIO driver,
> > +      * acpi_register_gsi() is used to obtain the GPIO irq. The GPIO i=
nterrupt is a
>
> "IRQ"
>
> > +      * watchdog interrupt that is triggered when the BMC resets.
> > +      */
> > +     irq =3D acpi_register_gsi(NULL, gsi, ACPI_EDGE_SENSITIVE, ACPI_AC=
TIVE_LOW);
> > +     if (irq < 0)
> > +             return irq;
> > +
> > +     gpio_base =3D ioremap(LOONGSON_GPIO_REG_BASE, LOONGSON_GPIO_REG_S=
IZE);
> > +     if (!gpio_base) {
> > +             ret =3D PTR_ERR(gpio_base);
> > +             goto acpi_failed;
> > +     }
> > +
> > +     writel(readl(gpio_base + LOONGSON_GPIO_OEN) | BIT(LS2K_BMC_RESET_=
GPIO),
> > +            gpio_base + LOONGSON_GPIO_OEN);
> > +     writel(readl(gpio_base + LOONGSON_GPIO_FUNC) & ~BIT(LS2K_BMC_RESE=
T_GPIO),
> > +            gpio_base + LOONGSON_GPIO_FUNC);
> > +     writel(readl(gpio_base + LOONGSON_GPIO_INTPOL) & ~BIT(LS2K_BMC_RE=
SET_GPIO),
> > +            gpio_base + LOONGSON_GPIO_INTPOL);
> > +     writel(readl(gpio_base + LOONGSON_GPIO_INTEN) | BIT(LS2K_BMC_RESE=
T_GPIO),
> > +            gpio_base + LOONGSON_GPIO_INTEN);
> > +
> > +     ret =3D devm_request_irq(priv->dev, irq, ls2k_bmc_interrupt,
> > +                            IRQF_SHARED | IRQF_TRIGGER_FALLING, "ls2kb=
mc gpio", priv);
> > +     if (ret)
> > +             dev_err(priv->dev, "LS2KBMC GPIO request_irq(%d) failed\n=
", irq);
> > +
> > +     iounmap(gpio_base);
> > +
> > +acpi_failed:
> > +     acpi_unregister_gsi(gsi);
> > +     return ret;
> > +}
> > +
> >  /*
> >   * Currently the Loongson-2K BMC hardware does not have an I2C interfa=
ce to adapt to the
> >   * resolution. We set the resolution by presetting "video=3D1280x1024-=
16@2M" to the BMC memory.
> > @@ -101,6 +416,7 @@ static int ls2k_bmc_parse_mode(struct pci_dev *pdev=
, struct simplefb_platform_da
> >  static int ls2k_bmc_probe(struct pci_dev *dev, const struct pci_device=
_id *id)
> >  {
> >       struct simplefb_platform_data pd;
> > +     struct ls2k_bmc_pdata *priv;
> >       resource_size_t base;
> >       int ret;
> >
> > @@ -108,6 +424,18 @@ static int ls2k_bmc_probe(struct pci_dev *dev, con=
st struct pci_device_id *id)
> >       if (ret)
> >               return ret;
> >
> > +     priv =3D devm_kzalloc(&dev->dev, sizeof(*priv), GFP_KERNEL);
> > +     if (IS_ERR(priv)) {
> > +             ret =3D -ENOMEM;
> > +             goto disable_pci;
> > +     }
> > +
> > +     priv->dev =3D &dev->dev;
> > +
> > +     ret =3D ls2k_bmc_pdata_initial(dev, priv);
>
> priv (ddata) already contains dev - you don't need both.

Yes, we just pass priv(ddata), and

struct pci_dev *pdev =3D to_pci_dev(ddata->dev);

>
> > +     if (ret)
> > +             goto disable_pci;
> > +
> >       ret =3D ls2k_bmc_parse_mode(dev, &pd);
> >       if (ret)
> >               goto disable_pci;
> > --
> > 2.47.1
> >
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]

--
Thanks.
Binbin

