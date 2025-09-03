Return-Path: <linux-kernel+bounces-798131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFCBB419D3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB68B4E1846
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C001C2F0666;
	Wed,  3 Sep 2025 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4/abkOq"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3CB32F76E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756891481; cv=none; b=cUnQa8DTRagUlpts/9ISpLYbvEVTAPeYJxMZrrcxPRydumclNfYy7t1oosdTUy3QxBR1O4mGDt16lZz5Vb05p7gPuZCC4oZ6EHws5lKwdnpuiGlqJj4VuuYUqspBXlnQH8sx/XxZ3WY3kLQaB9pywEoCq2tHyhjdIHCnprUFkWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756891481; c=relaxed/simple;
	bh=xBwk6w4AYXvH/WK0fOstPE9q9YnCGQqI+w7oQZcVQiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=st01F46xyOrRTQdza3Y/Ewv7uIvqOk7BIRLlqjsiRytgd3NYs06Hf8lLuKuWBsxmrtcIDkT8GlT1h5GNg9MFA7M1e6YGaeswZKFp8jgIO2wLTL2ahRE7HnF+HM5UlJZ6TLWX2wKA3Gog7bDtRAkPUrp50qUsEZXpTVF2CRYDyUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4/abkOq; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6188b72b7caso6816492a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 02:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756891478; x=1757496278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61iULmUas/w+ki0bHI/53L3mNbRcIzLVcQjd3QIQ8mA=;
        b=V4/abkOqsTd1FGsN/kPXwXFsLS5f7bCpnULbbbNkDWVcF+LziC/I82rmzT1GTnr+PQ
         cpVymxwc8k330fBLP3eraZms0EnYxxDVKErshYLzkT+DLBJUNCU1FNSXawwuspOFEE0u
         XS/m05HMMO6vmTEvu954qVR3inUd/xzWAyDw3wmSTH21dy8/yUGjj9yd/U6EyqNhnV7g
         RZzxqqlJVvatKQis6+ta5TCV2tN/derPJZAKZougrvoWK9qRNY3ueL+VSAO4WLmoJVYf
         4MKaYHVe2793Cu3TnlXVuaiWe0VAkI490eUQPP2ALDULlW5W7EUINSf4i78JAg6qJ2eC
         lyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756891478; x=1757496278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61iULmUas/w+ki0bHI/53L3mNbRcIzLVcQjd3QIQ8mA=;
        b=Zfox3AQkb1F2vNGeuxZTw1b3h4q1aw1Y02WvncVDPe4NUedbwkYwJhUTwhzZ+HAfAo
         iMpwW8KxQvsl0/CJaYr3RhEQ3brYO6CjvCHebx8IJ7/hWtm1BxSWeZqMiT7x0ZLiEedq
         4TFfeu83iAuQRl7dpIPoza91M5z3OmsNzkb0zq0UMbX2iajHbszXoLHGgwWDGfuCyUNu
         Lmk8Y5g9YNOn5oIgemWSJS8n3f8q7uaUZL9L1jyDaWdWPPGBVqhej+fhfHdAfQWKal0E
         RwbHS2ElrQCNJ+g5O2iwwKlaUbTKIxVhz0kHGpYgI9Co/EsU++kaiIiawvH+OkvTzFip
         PokQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV7MLotOndKO/R/JT/h/+MYWnPOSfP3oNd/F0gU4UEz0TAscXB1MNJqJTDHY4LoRchRgb/1Q9BQ/VKBD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhrqhyuvS+pjA+pfl+haEgoXzPcC9CFIAHZjOA9jPcyFxuvkLO
	T0bEQLr8ljLdzqPjvto76ewpf/03f6EH4X5bTPtJF4c+o14pB6rWW4U7VybGo/pVjqmt3xJav8v
	Dl8OHRkrkOGII+R6/yqbjr6+eq0iiOoA=
X-Gm-Gg: ASbGncteYXtLFNS4P9oVI8P6bSJsUTJx6YDsCVAJLbIMRlFmGRx5MajkO7PAXeTEwNH
	vUzm1owpCbp3rHVJKPR87xG5ijgeZQZSESPHFPLKyKoxngdkV5LXbwiQE8BYOaxlbJFv4ntZ9x/
	Uh+WzAKGJu42hOTKbgTiETStBcRSJUIQkNmLOJNQsi85pZEva3NT1DyjChmEPINSuIwR0HhdNMO
	61TAkdq/fzKxlV5GyYd
X-Google-Smtp-Source: AGHT+IG5w8xIO9s7ozFg+aqxkDl7u0BYBpZDTuYYJ0jSat8vNf19VtszjKY5txGRZAV6vMLpDPl5vWqyrOjhjkfSrIY=
X-Received: by 2002:a05:6402:35c4:b0:61e:9307:705f with SMTP id
 4fb4d7f45d1cf-61e930772b2mr10546912a12.7.1756891477309; Wed, 03 Sep 2025
 02:24:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755853480.git.zhoubinbin@loongson.cn> <8c67ace6b4b49725b0a2a7345e3683dbdf65e21c.1755853480.git.zhoubinbin@loongson.cn>
 <20250902144630.GS2163762@google.com>
In-Reply-To: <20250902144630.GS2163762@google.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Wed, 3 Sep 2025 17:24:25 +0800
X-Gm-Features: Ac12FXwdhHpYKrLEYOwLgD9i2h6nn3QMHqQQmhbny8EoRn02rW5coU0gqSc3yvg
Message-ID: <CAMpQs4KdzjhUe5NbrGS5SkuBJ3TUU3QpuMSANBzQKsdR+TD_HQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] mfd: ls2kbmc: Add Loongson-2K BMC reset function support
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

On Tue, Sep 2, 2025 at 10:46=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Fri, 22 Aug 2025, Binbin Zhou wrote:
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
> >  drivers/mfd/ls2k-bmc-core.c | 336 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 336 insertions(+)
>
> Couple of nits to finish up:
>
> > diff --git a/drivers/mfd/ls2k-bmc-core.c b/drivers/mfd/ls2k-bmc-core.c
> > index 39cc481d9ba1..fa7f1a822076 100644
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
> >  enum {
> >       LS2K_BMC_DISPLAY,
> >       LS2K_BMC_IPMI0,
> > @@ -95,6 +143,281 @@ static struct mfd_cell ls2k_bmc_cells[] =3D {
> >       },
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
>
> Drop the pdata part completely.
>
> pdata is something else.

Emm...
How about rename it as ls2k_bmc_priv? Otherwise, using ls2k_bmc as a
structure name seems a bit odd.

>
> > +     struct device *dev;
> > +     struct work_struct bmc_reset_work;
> > +     struct ls2k_bmc_pci_data bmc_pci_data;
> > +     struct ls2k_bmc_bridge_pci_data bridge_pci_data;
> > +};
> > +
> > +static bool ls2k_bmc_bar0_addr_is_set(struct pci_dev *pdev)
> > +{
> > +     u32 addr;
> > +
> > +     pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &addr);
> > +
> > +     return addr & PCI_BASE_ADDRESS_MEM_MASK ? true : false;
> > +}
> > +
> > +static bool ls2k_bmc_pcie_is_connected(struct pci_dev *parent, struct =
ls2k_bmc_pdata *ddata)
> > +{
> > +     void __iomem *base;
> > +     int val, ret;
> > +
> > +     base =3D pci_iomap(parent, 0, LS7A_PCI_CFG_SIZE);
> > +     if (!base)
> > +             return false;
> > +
> > +     val =3D readl(base + LS7A_PCIE_PORT_CTL0);
> > +     writel(val | LS2K_BMC_PCIE_LTSSM_ENABLE, base + LS7A_PCIE_PORT_CT=
L0);
> > +
> > +     ret =3D readl_poll_timeout_atomic(base + LS7A_PCIE_PORT_STS1, val=
,
> > +                                     (val & LS2K_BMC_PCIE_LTSSM_STS) =
=3D=3D LS2K_BMC_PCIE_CONNECTED,
> > +                                     LS2K_BMC_PCIE_DELAY_US, LS2K_BMC_=
PCIE_TIMEOUT_US);
> > +     if (ret) {
> > +             pci_iounmap(parent, base);
> > +             dev_err(ddata->dev, "PCI-E training failed status=3D0x%x\=
n", val);
> > +             return false;
> > +     }
> > +
> > +     pci_iounmap(parent, base);
> > +     return true;
> > +}
> > +
> > +static void ls2k_bmc_restore_bridge_pci_data(struct pci_dev *parent, s=
truct ls2k_bmc_pdata *ddata)
> > +{
> > +     int base, i =3D 0;
> > +
> > +     pci_write_config_dword(parent, PCI_COMMAND, ddata->bridge_pci_dat=
a.pci_command);
> > +
> > +     for (base =3D PCI_BASE_ADDRESS_0; base <=3D PCI_BASE_ADDRESS_5; b=
ase +=3D 4, i++)
>
> Define 4.
>
> > +             pci_write_config_dword(parent, base, ddata->bridge_pci_da=
ta.base_address[i]);
> > +
> > +     pci_write_config_dword(parent, PCI_ROM_ADDRESS, ddata->bridge_pci=
_data.rom_addreess);
> > +     pci_write_config_dword(parent, PCI_INTERRUPT_LINE, ddata->bridge_=
pci_data.interrupt_line);
> > +
> > +     pci_write_config_dword(parent, parent->msi_cap + PCI_MSI_ADDRESS_=
LO,
> > +                            ddata->bridge_pci_data.msi_lo);
> > +     pci_write_config_dword(parent, parent->msi_cap + PCI_MSI_ADDRESS_=
HI,
> > +                            ddata->bridge_pci_data.msi_hi);
> > +     pci_write_config_dword(parent, parent->pcie_cap + PCI_EXP_DEVCTL,
> > +                            ddata->bridge_pci_data.devctl);
> > +     pci_write_config_dword(parent, parent->pcie_cap + PCI_EXP_LNKCAP,
> > +                            ddata->bridge_pci_data.linkcap);
> > +     pci_write_config_dword(parent, parent->pcie_cap + PCI_EXP_LNKCTL,
> > +                            ddata->bridge_pci_data.linkctl_sts);
> > +
> > +     pci_write_config_dword(parent, LS7A_GEN2_CTL, ddata->bridge_pci_d=
ata.gen2_ctrl);
> > +     pci_write_config_dword(parent, LS7A_SYMBOL_TIMER, ddata->bridge_p=
ci_data.symbol_timer);
> > +}
> > +
> > +static int ls2k_bmc_recover_pci_data(void *data)
> > +{
> > +     struct ls2k_bmc_pdata *ddata =3D data;
> > +     struct pci_dev *pdev =3D to_pci_dev(ddata->dev);
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
> > +     ls2k_bmc_restore_bridge_pci_data(parent, ddata);
> > +
> > +     /* Check if PCI-E is connected */
> > +     if (!ls2k_bmc_pcie_is_connected(parent, ddata))
> > +             return false;
> > +
> > +     /* Waiting for U-Boot and DDR ready */
> > +     mdelay(LS2K_BMC_RESET_WAIT_TIME);
> > +     if (!ls2k_bmc_bar0_addr_is_set(parent))
> > +             return false;
> > +
> > +     /* Restore LS2K BMC PCI-E config data */
> > +     pci_write_config_dword(pdev, PCI_COMMAND, ddata->bmc_pci_data.pci=
_command);
> > +     pci_write_config_dword(pdev, PCI_BASE_ADDRESS_0, ddata->bmc_pci_d=
ata.base_address0);
> > +     pci_write_config_dword(pdev, PCI_INTERRUPT_LINE, ddata->bmc_pci_d=
ata.interrupt_line);
> > +
> > +     return 0;
> > +}
> > +
> > +static void ls2k_bmc_events_fn(struct work_struct *work)
> > +{
> > +     struct ls2k_bmc_pdata *ddata =3D container_of(work, struct ls2k_b=
mc_pdata, bmc_reset_work);
> > +
> > +     /*
> > +      * The PCI-E is lost when the BMC resets, at which point access t=
o the PCI-E
> > +      * from other CPUs is suspended to prevent a crash.
> > +      */
> > +     stop_machine(ls2k_bmc_recover_pci_data, ddata, NULL);
> > +
> > +     if (IS_ENABLED(CONFIG_VT)) {
> > +             /* Re-push the display due to previous PCI-E loss. */
> > +             set_console(vt_move_to_console(MAX_NR_CONSOLES - 1, 1));
> > +     }
> > +}
> > +
> > +static irqreturn_t ls2k_bmc_interrupt(int irq, void *arg)
> > +{
> > +     struct ls2k_bmc_pdata *ddata =3D arg;
> > +     static unsigned long last_jiffies;
> > +
> > +     if (system_state !=3D SYSTEM_RUNNING)
> > +             return IRQ_HANDLED;
> > +
> > +     /* Skip interrupt in LS2K_BMC_INT_INTERVAL */
> > +     if (time_after(jiffies, last_jiffies + LS2K_BMC_INT_INTERVAL)) {
> > +             schedule_work(&ddata->bmc_reset_work);
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
mc_pdata *ddata)
> > +{
> > +     struct pci_dev *parent =3D pdev->bus->self;
> > +     int base, i =3D 0;
> > +
> > +     pci_read_config_dword(parent, PCI_COMMAND, &ddata->bridge_pci_dat=
a.pci_command);
> > +
> > +     for (base =3D PCI_BASE_ADDRESS_0; base <=3D PCI_BASE_ADDRESS_5; b=
ase +=3D 4, i++)
> > +             pci_read_config_dword(parent, base, &ddata->bridge_pci_da=
ta.base_address[i]);
> > +
> > +     pci_read_config_dword(parent, PCI_ROM_ADDRESS, &ddata->bridge_pci=
_data.rom_addreess);
> > +     pci_read_config_dword(parent, PCI_INTERRUPT_LINE, &ddata->bridge_=
pci_data.interrupt_line);
> > +
> > +     pci_read_config_dword(parent, parent->msi_cap + PCI_MSI_ADDRESS_L=
O,
> > +                           &ddata->bridge_pci_data.msi_lo);
> > +     pci_read_config_dword(parent, parent->msi_cap + PCI_MSI_ADDRESS_H=
I,
> > +                           &ddata->bridge_pci_data.msi_hi);
> > +
> > +     pci_read_config_dword(parent, parent->pcie_cap + PCI_EXP_DEVCTL,
> > +                           &ddata->bridge_pci_data.devctl);
> > +     pci_read_config_dword(parent, parent->pcie_cap + PCI_EXP_LNKCAP,
> > +                           &ddata->bridge_pci_data.linkcap);
> > +     pci_read_config_dword(parent, parent->pcie_cap + PCI_EXP_LNKCTL,
> > +                           &ddata->bridge_pci_data.linkctl_sts);
> > +
> > +     pci_read_config_dword(parent, LS7A_GEN2_CTL, &ddata->bridge_pci_d=
ata.gen2_ctrl);
> > +     ddata->bridge_pci_data.gen2_ctrl |=3D FIELD_PREP(LS7A_GEN2_SPEED_=
CHANG, 0x1)
> > +                                     | FIELD_PREP(LS7A_CONF_PHY_TX, 0x=
0);
> > +
> > +     pci_read_config_dword(parent, LS7A_SYMBOL_TIMER, &ddata->bridge_p=
ci_data.symbol_timer);
> > +     ddata->bridge_pci_data.symbol_timer |=3D LS7A_MASK_LEN_MATCH;
> > +
> > +     pci_read_config_dword(pdev, PCI_COMMAND, &ddata->bmc_pci_data.pci=
_command);
> > +     pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &ddata->bmc_pci_d=
ata.base_address0);
> > +     pci_read_config_dword(pdev, PCI_INTERRUPT_LINE, &ddata->bmc_pci_d=
ata.interrupt_line);
> > +}
> > +
> > +static int ls2k_bmc_pdata_initial(struct ls2k_bmc_pdata *ddata)
>
> What are you actually doing here exactly.
>
> I don't think "pdata_initial" describes it.

Indeed, as the function expands, its name should be updated.
It now handles multiple tasks, such as GPIO initialization and
interrupt registration. Overall, it initializes the ls2k BMC device.

How about renaming it to ls2k_bmc_device_request()?
>
> > +{
> > +     struct pci_dev *pdev =3D to_pci_dev(ddata->dev);
> > +     int gsi =3D 16 + (LS2K_BMC_RESET_GPIO & 7);
>
> Define 16.
>
> > +     void __iomem *gpio_base;
> > +     int irq, ret, val;
> > +
> > +     ls2k_bmc_save_pci_data(pdev, ddata);
> > +
> > +     INIT_WORK(&ddata->bmc_reset_work, ls2k_bmc_events_fn);
> > +
> > +     ret =3D devm_request_irq(&pdev->dev, pdev->irq, ls2k_bmc_interrup=
t,
> > +                            IRQF_SHARED | IRQF_TRIGGER_FALLING, "ls2kb=
mc pcie", ddata);
> > +     if (ret) {
> > +             dev_err(ddata->dev, "Failed to request LS2KBMC PCI-E IRQ =
%d.\n", pdev->irq);
> > +             return ret;
> > +     }
> > +
> > +     /*
> > +      * Since gpio_chip->to_irq is not implemented in the Loongson-3 G=
PIO driver,
> > +      * acpi_register_gsi() is used to obtain the GPIO IRQ. The GPIO i=
nterrupt is a
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
> > +             ret =3D -ENOMEM;
> > +             goto acpi_failed;
> > +     }
> > +
> > +     /* Disable GPIO output */
> > +     val =3D readl(gpio_base + LOONGSON_GPIO_OEN);
> > +     writel(val | BIT(LS2K_BMC_RESET_GPIO), gpio_base + LOONGSON_GPIO_=
OEN);
> > +
> > +     /* Enable GPIO functionality */
> > +     val =3D readl(gpio_base + LOONGSON_GPIO_FUNC);
> > +     writel(val & ~BIT(LS2K_BMC_RESET_GPIO), gpio_base + LOONGSON_GPIO=
_FUNC);
> > +
> > +     /* Set GPIO interrupts to low-level active */
> > +     val =3D readl(gpio_base + LOONGSON_GPIO_INTPOL);
> > +     writel(val & ~BIT(LS2K_BMC_RESET_GPIO), gpio_base + LOONGSON_GPIO=
_INTPOL);
> > +
> > +     /* Enable GPIO interrupts */
> > +     val =3D readl(gpio_base + LOONGSON_GPIO_INTEN);
> > +     writel(val | BIT(LS2K_BMC_RESET_GPIO), gpio_base + LOONGSON_GPIO_=
INTEN);
> > +
> > +     ret =3D devm_request_irq(ddata->dev, irq, ls2k_bmc_interrupt,
> > +                            IRQF_SHARED | IRQF_TRIGGER_FALLING, "ls2kb=
mc gpio", ddata);
> > +     if (ret)
> > +             dev_err(ddata->dev, "Failed to request LS2KBMC GPIO IRQ %=
d.\n", irq);
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
> > @@ -134,6 +457,7 @@ static int ls2k_bmc_parse_mode(struct pci_dev *pdev=
, struct simplefb_platform_da
> >  static int ls2k_bmc_probe(struct pci_dev *dev, const struct pci_device=
_id *id)
> >  {
> >       struct simplefb_platform_data pd;
> > +     struct ls2k_bmc_pdata *ddata;
> >       resource_size_t base;
> >       int ret;
> >
> > @@ -141,6 +465,18 @@ static int ls2k_bmc_probe(struct pci_dev *dev, con=
st struct pci_device_id *id)
> >       if (ret)
> >               return ret;
> >
> > +     ddata =3D devm_kzalloc(&dev->dev, sizeof(*ddata), GFP_KERNEL);
> > +     if (IS_ERR(ddata)) {
> > +             ret =3D -ENOMEM;
> > +             goto disable_pci;
> > +     }
> > +
> > +     ddata->dev =3D &dev->dev;
> > +
> > +     ret =3D ls2k_bmc_pdata_initial(ddata);
> > +     if (ret)
> > +             goto disable_pci;
> > +
> >       ret =3D ls2k_bmc_parse_mode(dev, &pd);
> >       if (ret)
> >               goto disable_pci;
> > --
> > 2.47.3
> >
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]

--
Thanks.
Binbin

