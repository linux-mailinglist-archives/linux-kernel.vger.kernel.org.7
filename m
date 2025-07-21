Return-Path: <linux-kernel+bounces-738590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DA2B0BAC9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 04:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976C3189D62C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 02:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8981EA80;
	Mon, 21 Jul 2025 02:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5n9IZMx"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6AD1F4C8C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 02:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064811; cv=none; b=K7tPVp392QH2On/WhuzKM4A6scMrq9fhNwPJIt1wtPOVlR/IlmrNoweQ4C/K0nWpDxkYhqfC9QuwIHy/ZicmDOpi2hBYTzt/bLuOJAoCcwgx9wsKMzDgDlOS9LTSrcwyp7/hZd+AVZ9nuI3H7/nVNw1u7spjhprRlXu9UuhZBDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064811; c=relaxed/simple;
	bh=bMjGgEysVE/rfK99VJhgpvx7HHTPp5oDGIsOIUCYUY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DKIWoZ9q9RyoL3BvEkUhZdCZ5RxEyU1Jxaf2ipbi533neJj0Xo9MaNhYWfb2gz9PdePKhSgXbhnRkqVXVKxC5xFdvO0gwnRG//vgCbRgg4giWHRsQWh157rZKUT8gGAFh0brrczY6v9awKIZzGLnCDHEF6npnu0aRLjhgKvkLJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5n9IZMx; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae0dad3a179so621735966b.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 19:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753064808; x=1753669608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGjc1nW4Cc5OITZmD2N+edfXPrO51/K5Xg0OJMciG/w=;
        b=L5n9IZMxudP6es5+NZg4xqYHmve2CeIuFYmLp1N9eq0ETWUgw6+6rBhUkyXxePHF34
         qvB9kTTjm03y1tlORVhqUy8fGT5+OrkNnF/+vr7PpbTAgWCA8fArLyatafluYurmf1Vh
         FUBW33mF3z4TdtRvaack8wyFwt6KzdSCd/z60AsHDtyrjUKsC2uSnp18R537w9hRekoz
         4OSqZ/ZKfCGJqxG8YFxsmuhNghzmOm634CZ/Vg2jGYoIESoZD2XwnlayCAcSZpdrngZC
         q1ilYblSCP7HfueVZIC6jTVc2kvgmtFUHudFZK/AT1Ox3LvLM2KvC/HRyi5kYCdCVdNQ
         gxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753064808; x=1753669608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGjc1nW4Cc5OITZmD2N+edfXPrO51/K5Xg0OJMciG/w=;
        b=c5HuuTEGmpNUKYTOESb4A1Ps4bEm2O1V+qFeVX6lNA9cP+X5GfkPqhvjEoEe+39RfL
         ezTOQw9yfFwddAZ3V9R4wfIJZmYR6lsEpsH5tWFWtVRz4TLwFvt6KNQQKg14AAX43Dpg
         PFbwAqxoB4gr1f8NYqfBXiFimU4bEmdGNDnIFiiw6AuoO6qEDbhgqddSMVw6E/PY9GKH
         lT7lbs4CTUANt/APBUypp2uUDtWDvz3EekdE2aXL0YuOkPvhmarx9VxQ3bMuroo5zn0F
         s98ngp4YcP+oBE/nVVen4Vc+xzMItM47WQrVgFSynf/yZF8z/hyShday5HszldihGWQm
         lSeg==
X-Forwarded-Encrypted: i=1; AJvYcCUYFTpHE7iwaV4fkzg6838JXgOutRhJYOAFqMcUYmC5cbKreZ3WtCE0fbYw5H9S6B3XjdvBKODoA/8Q2Hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpE2q5c5Bbb6IltfohB0V1JvulkHOBq2mXDHXegMV4c3kHrmfY
	/8l4vaVTC4Sd3njXhq/wX4BLGul8dZ+wtMb3PaLgosdv9RdoyjlXSlIc7CM4VlHl8ETG2cP9jJx
	iuyYvZo6pRhgsaeKckaSzdtje6qVLnhonTXSL2mo=
X-Gm-Gg: ASbGnctsmVEp0v9DAvFTWnA65bZ+dTgIrBRtLW4g2KsU5U3gigHjO1jC/EF4Cyaj++n
	oWwHMNMe4SB7vUsk/iCSRj5dj0Cmq+bW/fHHpFlSBJYFLd7XSiD2Asow0le3rduFwRrQt9r8PG3
	AmyIgC6nwD+Ws3rQDSfnXdyjGRAP8gDcuMP++JzsvjFczg70PZ5cSlRDUvy1RIVtR87M10HzRMl
	ly8jE/o
X-Google-Smtp-Source: AGHT+IEDUpT1Xx78AIPWL67dEpB4eIxQ3fz+bPuxIr06g5xZjwgMHVXt6Q1sCExWH2uKTKJ4HrLfyHm0JwtP3nM6emU=
X-Received: by 2002:a17:907:6d0d:b0:aca:c507:a4e8 with SMTP id
 a640c23a62f3a-aec4fad6584mr1391532166b.21.1753064807357; Sun, 20 Jul 2025
 19:26:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751617911.git.zhoubinbin@loongson.cn> <f4c546b0160294296c98b6b12b0ab1d2000dd44c.1751617911.git.zhoubinbin@loongson.cn>
 <20250710100323.GI1431498@google.com> <CAMpQs4LQME7oO8i2FWgUsAQqwThcp=R3jubPGqZ1Vr-pvEHvoA@mail.gmail.com>
 <20250718135246.GH11056@google.com>
In-Reply-To: <20250718135246.GH11056@google.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Mon, 21 Jul 2025 10:26:35 +0800
X-Gm-Features: Ac12FXxc2WjqZLXTQmDSK-50UX7FqHu8oM08yXDRNBdDN4rEogJ0JrBAyxDI7jY
Message-ID: <CAMpQs4+AOc2bkOFSWW_hX-+akyRT9vTBb6mFJGKpjt9fSsF7MQ@mail.gmail.com>
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

Thanks for your reply.


On Fri, Jul 18, 2025 at 9:52=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Fri, 11 Jul 2025, Binbin Zhou wrote:
>
> > Hi Lee:
> >
> > Thanks for your review.
> >
> > On Thu, Jul 10, 2025 at 6:03=E2=80=AFPM Lee Jones <lee@kernel.org> wrot=
e:
> > >
> > > On Fri, 04 Jul 2025, Binbin Zhou wrote:
> > >
> > > > Since the display is a sub-function of the Loongson-2K BMC, when th=
e
> > > > BMC reset, the entire BMC PCIe is disconnected, including the displ=
ay
> > > > which is interrupted.
> > > >
> > > > Quick overview of the entire LS2K BMC reset process:
> > > >
> > > > There are two types of reset methods: soft reset (BMC-initiated reb=
oot
> > > > of IPMI reset command) and BMC watchdog reset (watchdog timeout).
> > > >
> > > > First, regardless of the method, an interrupt is generated (PCIe in=
terrupt
> > > > for soft reset/GPIO interrupt for watchdog reset);
> > > >
> > > > Second, during the interrupt process, the system enters bmc_reset_w=
ork,
> > > > clears the bus/IO/mem resources of the LS7A PCI-E bridge, waits for=
 the BMC
> > > > reset to begin, then restores the parent device's PCI configuration=
 space,
> > > > waits for the BMC reset to complete, and finally restores the BMC P=
CI
> > > > configuration space.
> > > >
> > > > Display restoration occurs last.
> > > >
> > > > Co-developed-by: Chong Qiao <qiaochong@loongson.cn>
> > > > Signed-off-by: Chong Qiao <qiaochong@loongson.cn>
> > > > Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > Acked-by: Corey Minyard <corey@minyard.net>
> > > > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > > > ---
> > > >  drivers/mfd/ls2k-bmc-core.c | 328 ++++++++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 328 insertions(+)
> > > >
> > > > diff --git a/drivers/mfd/ls2k-bmc-core.c b/drivers/mfd/ls2k-bmc-cor=
e.c
> > > > index 50d560a4611c..1ae673f6a196 100644
> > > > --- a/drivers/mfd/ls2k-bmc-core.c
> > > > +++ b/drivers/mfd/ls2k-bmc-core.c
> > > > @@ -10,8 +10,12 @@
> > > >   */
> > > >
> > > >  #include <linux/aperture.h>
> > > > +#include <linux/bitfield.h>
> > > > +#include <linux/delay.h>
> > > >  #include <linux/errno.h>
> > > >  #include <linux/init.h>
> > > > +#include <linux/iopoll.h>
> > > > +#include <linux/kbd_kern.h>
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/mfd/core.h>
> > > >  #include <linux/module.h>
> > > > @@ -19,6 +23,8 @@
> > > >  #include <linux/pci_ids.h>
> > > >  #include <linux/platform_data/simplefb.h>
> > > >  #include <linux/platform_device.h>
> > > > +#include <linux/stop_machine.h>
> > > > +#include <linux/vt_kern.h>
> > > >
> > > >  /* LS2K BMC resources */
> > > >  #define LS2K_DISPLAY_RES_START               (SZ_16M + SZ_2M)
> > > > @@ -29,6 +35,48 @@
> > > >  #define LS2K_IPMI3_RES_START         (LS2K_IPMI2_RES_START + LS2K_=
IPMI_RES_SIZE)
> > > >  #define LS2K_IPMI4_RES_START         (LS2K_IPMI3_RES_START + LS2K_=
IPMI_RES_SIZE)
> > > >
> > > > +#define LS7A_PCI_CFG_SIZE            0x100
> > > > +
> > > > +/* LS7A bridge registers */
> > > > +#define LS7A_PCIE_PORT_CTL0          0x0
> > > > +#define LS7A_PCIE_PORT_STS1          0xC
> > > > +#define LS7A_GEN2_CTL                        0x80C
> > > > +#define LS7A_SYMBOL_TIMER            0x71C
> > > > +
> > > > +/* Bits of LS7A_PCIE_PORT_CTL0 */
> > > > +#define LS2K_BMC_PCIE_LTSSM_ENABLE   BIT(3)
> > > > +
> > > > +/* Bits of LS7A_PCIE_PORT_STS1 */
> > > > +#define LS2K_BMC_PCIE_LTSSM_STS              GENMASK(5, 0)
> > > > +#define LS2K_BMC_PCIE_CONNECTED              0x11
> > > > +
> > > > +#define LS2K_BMC_PCIE_DELAY_US               1000
> > > > +#define LS2K_BMC_PCIE_TIMEOUT_US     1000000
> > > > +
> > > > +/* Bits of LS7A_GEN2_CTL */
> > > > +#define LS7A_GEN2_SPEED_CHANG                BIT(17)
> > > > +#define LS7A_CONF_PHY_TX             BIT(18)
> > > > +
> > > > +/* Bits of LS7A_SYMBOL_TIMER */
> > > > +#define LS7A_MASK_LEN_MATCH          BIT(26)
> > > > +
> > > > +/* Interval between interruptions */
> > > > +#define LS2K_BMC_INT_INTERVAL                (60 * HZ)
> > > > +
> > > > +/* Maximum time to wait for U-Boot and DDR to be ready with ms. */
> > > > +#define LS2K_BMC_RESET_WAIT_TIME     10000
> > > > +
> > > > +/* It's an experience value */
> > > > +#define LS7A_BAR0_CHECK_MAX_TIMES    2000
> > > > +
> > > > +#define LS2K_BMC_RESET_GPIO          14
> > > > +#define LOONGSON_GPIO_REG_BASE               0x1FE00500
> > > > +#define LOONGSON_GPIO_REG_SIZE               0x18
> > > > +#define LOONGSON_GPIO_OEN            0x0
> > > > +#define LOONGSON_GPIO_FUNC           0x4
> > > > +#define LOONGSON_GPIO_INTPOL         0x10
> > > > +#define LOONGSON_GPIO_INTEN          0x14
> > > > +
> > > >  static struct resource ls2k_display_resources[] =3D {
> > > >       DEFINE_RES_MEM_NAMED(LS2K_DISPLAY_RES_START, SZ_4M, "simpledr=
m-res"),
> > > >  };
> > > > @@ -62,6 +110,273 @@ static struct mfd_cell ls2k_bmc_cells[] =3D {
> > > >       MFD_CELL_RES("ls2k-ipmi-si", ls2k_ipmi4_resources),
> > > >  };
> > > >
> > > > +/* Index of the BMC PCI configuration space to be restored at BMC =
reset. */
> > > > +struct ls2k_bmc_pci_data {
> > > > +     u32 pci_command;
> > > > +     u32 base_address0;
> > > > +     u32 interrupt_line;
> > > > +};
> > > > +
> > > > +/* Index of the parent PCI configuration space to be restored at B=
MC reset. */
> > > > +struct ls2k_bmc_bridge_pci_data {
> > > > +     u32 pci_command;
> > > > +     u32 base_address[6];
> > > > +     u32 rom_addreess;
> > > > +     u32 interrupt_line;
> > > > +     u32 msi_hi;
> > > > +     u32 msi_lo;
> > > > +     u32 devctl;
> > > > +     u32 linkcap;
> > > > +     u32 linkctl_sts;
> > > > +     u32 symbol_timer;
> > > > +     u32 gen2_ctrl;
> > > > +};
> > > > +
> > > > +struct ls2k_bmc_pdata {
> > > > +     struct device *dev;
> > > > +     struct work_struct bmc_reset_work;
> > > > +     struct ls2k_bmc_pci_data bmc_pci_data;
> > > > +     struct ls2k_bmc_bridge_pci_data bridge_pci_data;
> > > > +};
> > > > +
> > > > +static bool ls2k_bmc_bar0_addr_is_set(struct pci_dev *ppdev)
> > >
> > > Nit: This is usually called pdev.
> >
> > OK.
>
> Snip things you agree with please.
>
> [...]
>
> > > > +static void ls2k_bmc_events_fn(struct work_struct *work)
> > > > +{
> > > > +     struct ls2k_bmc_pdata *priv =3D container_of(work, struct ls2=
k_bmc_pdata, bmc_reset_work);
> > > > +
> > > > +     /*
> > > > +      * The PCI-E is lost when the BMC resets, at which point acce=
ss to the PCI-E
> > > > +      * from other CPUs is suspended to prevent a crash.
> > > > +      */
> > > > +     stop_machine(ls2k_bmc_recover_pci_data, priv, NULL);
> > > > +
> > > > +#ifdef CONFIG_VT
> > >
> > > #ifery in C-files is generally frowned upon.
> > >
> > > Is the any pieces of run-time data you can use instead?
> > >
> > > Or a stub which culminated in a no-op if !CONFIG_VT?
> >
> > Emm, I'm not sure if I understand correctly, but is the following way s=
uitable?
> >
> >         if (IS_ENABLED(CONFIG_VT))
>
> It's better than #if, but even better would be a stub in a header file.

Hmm... The declarations for vt_move_to_console()/set_console() are in
two VT-related header files [1]. Adding the relevant stub functions
involves the VT subsystem, which does not seem to be relevant to the
subject of our patch set.
Therefore, I think the above modification is more suitable for us.

[1]:
vt_move_to_console:
https://elixir.bootlin.com/linux/v6.15/source/include/linux/vt_kern.h#L141
set_console: https://elixir.bootlin.com/linux/v6.15/source/include/linux/kb=
d_kern.h#L69

>
> >                 /* Re-push the display due to previous PCI-E loss. */
> >                 set_console(vt_move_to_console(MAX_NR_CONSOLES - 1, 1))=
;
> >
> > >
> > > > +     /* Re-push the display due to previous PCI-E loss. */
> > > > +     set_console(vt_move_to_console(MAX_NR_CONSOLES - 1, 1));
> > > > +#endif
> > > > +}
> > > > +
> > > > +static irqreturn_t ls2k_bmc_interrupt(int irq, void *arg)
> > > > +{
> > > > +     struct ls2k_bmc_pdata *priv =3D arg;
> > > > +     static unsigned long last_jiffies;
> > > > +
> > > > +     if (system_state !=3D SYSTEM_RUNNING)
> > > > +             return IRQ_HANDLED;
> > > > +
> > > > +     /* Skip interrupt in LS2K_BMC_INT_INTERVAL */
> > > > +     if (time_after(jiffies, last_jiffies + LS2K_BMC_INT_INTERVAL)=
) {
> > > > +             schedule_work(&priv->bmc_reset_work);
> > > > +             last_jiffies =3D jiffies;
> > > > +     }
> > > > +
> > > > +     return IRQ_HANDLED;
> > > > +}
> > > > +
> > > > +/*
> > > > + * Saves the BMC parent device (LS7A) and its own PCI configuratio=
n space registers
> > > > + * that need to be restored after BMC reset.
> > > > + */
> > > > +static void ls2k_bmc_save_pci_data(struct pci_dev *pdev, struct ls=
2k_bmc_pdata *priv)
> > > > +{
> > > > +     struct pci_dev *parent =3D pdev->bus->self;
> > > > +     int base, i =3D 0;
> > > > +
> > > > +     pci_read_config_dword(parent, PCI_COMMAND, &priv->bridge_pci_=
data.pci_command);
> > > > +
> > > > +     for (base =3D PCI_BASE_ADDRESS_0; base <=3D PCI_BASE_ADDRESS_=
5; base +=3D 4, i++)
> > > > +             pci_read_config_dword(parent, base, &priv->bridge_pci=
_data.base_address[i]);
> > > > +
> > > > +     pci_read_config_dword(parent, PCI_ROM_ADDRESS, &priv->bridge_=
pci_data.rom_addreess);
> > > > +     pci_read_config_dword(parent, PCI_INTERRUPT_LINE, &priv->brid=
ge_pci_data.interrupt_line);
> > > > +
> > > > +     pci_read_config_dword(parent, parent->msi_cap + PCI_MSI_ADDRE=
SS_LO,
> > > > +                           &priv->bridge_pci_data.msi_lo);
> > > > +     pci_read_config_dword(parent, parent->msi_cap + PCI_MSI_ADDRE=
SS_HI,
> > > > +                           &priv->bridge_pci_data.msi_hi);
> > > > +
> > > > +     pci_read_config_dword(parent, parent->pcie_cap + PCI_EXP_DEVC=
TL,
> > > > +                           &priv->bridge_pci_data.devctl);
> > > > +     pci_read_config_dword(parent, parent->pcie_cap + PCI_EXP_LNKC=
AP,
> > > > +                           &priv->bridge_pci_data.linkcap);
> > > > +     pci_read_config_dword(parent, parent->pcie_cap + PCI_EXP_LNKC=
TL,
> > > > +                           &priv->bridge_pci_data.linkctl_sts);
> > > > +
> > > > +     pci_read_config_dword(parent, LS7A_GEN2_CTL, &priv->bridge_pc=
i_data.gen2_ctrl);
> > > > +     priv->bridge_pci_data.gen2_ctrl |=3D FIELD_PREP(LS7A_GEN2_SPE=
ED_CHANG, 0x1)
> > > > +                                     | FIELD_PREP(LS7A_CONF_PHY_TX=
, 0x0);
> > > > +
> > > > +     pci_read_config_dword(parent, LS7A_SYMBOL_TIMER, &priv->bridg=
e_pci_data.symbol_timer);
> > > > +     priv->bridge_pci_data.symbol_timer |=3D LS7A_MASK_LEN_MATCH;
> > > > +
> > > > +     pci_read_config_dword(pdev, PCI_COMMAND, &priv->bmc_pci_data.=
pci_command);
> > > > +     pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &priv->bmc_pc=
i_data.base_address0);
> > > > +     pci_read_config_dword(pdev, PCI_INTERRUPT_LINE, &priv->bmc_pc=
i_data.interrupt_line);
> > > > +}
> > > > +
> > > > +static int ls2k_bmc_pdata_initial(struct pci_dev *pdev, struct ls2=
k_bmc_pdata *priv)
> > > > +{
> > > > +     int gsi =3D 16 + (LS2K_BMC_RESET_GPIO & 7);
> > > > +     void __iomem *gpio_base;
> > > > +     int irq, ret;
> > > > +
> > > > +     ls2k_bmc_save_pci_data(pdev, priv);
> > > > +
> > > > +     INIT_WORK(&priv->bmc_reset_work, ls2k_bmc_events_fn);
> > > > +
> > > > +     ret =3D devm_request_irq(&pdev->dev, pdev->irq, ls2k_bmc_inte=
rrupt,
> > > > +                            IRQF_SHARED | IRQF_TRIGGER_FALLING, "l=
s2kbmc pcie", priv);
> > > > +     if (ret) {
> > > > +             dev_err(priv->dev, "LS2KBMC PCI-E request_irq(%d) fai=
led\n", pdev->irq);
> > >
> > > Please don't use function names in error messages.
> > >
> > > Make them human readable inclusive of non-kernel engineers.
> >
> > How about:
> >
> > dev_err(ddata->dev, "Failed to request LS2KBMC PCI-E IRQ %d.\n", pdev->=
irq);
> >
> > also, the error message regarding GPIO IRQ is as follows:
> >
> > dev_err(ddata->dev, "Failed to request LS2KBMC GPIO IRQ %d.\n", irq);
>
> Yes, much better.
>
> [...]
>
> > > > +     priv =3D devm_kzalloc(&dev->dev, sizeof(*priv), GFP_KERNEL);
> > > > +     if (IS_ERR(priv)) {
> > > > +             ret =3D -ENOMEM;
> > > > +             goto disable_pci;
> > > > +     }
> > > > +
> > > > +     priv->dev =3D &dev->dev;
> > > > +
> > > > +     ret =3D ls2k_bmc_pdata_initial(dev, priv);
> > >
> > > priv (ddata) already contains dev - you don't need both.
> >
> > Yes, we just pass priv(ddata), and
> >
> > struct pci_dev *pdev =3D to_pci_dev(ddata->dev);
>
> I would pass dev ... hold on, where do you store priv for reuse?

Sorry, I am not entirely sure I understand your question. It does not
appear that priv needs to be reused.
>
> > > > +     if (ret)
> > > > +             goto disable_pci;
> > > > +
> > > >       ret =3D ls2k_bmc_parse_mode(dev, &pd);
> > > >       if (ret)
> > > >               goto disable_pci;
> > > > --
> > > > 2.47.1
> > > >
> > >
> > > --
> > > Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> >
> > --
> > Thanks.
> > Binbin
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]

--
Thanks.
Binbin

