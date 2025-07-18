Return-Path: <linux-kernel+bounces-736950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6FAB0A599
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD515A37E6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D592BDC1D;
	Fri, 18 Jul 2025 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksFS0xyd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA80E15E5C2;
	Fri, 18 Jul 2025 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752846772; cv=none; b=QeClece6oD/CShu4VDg5wA/kinTlGkFn1xney6hVFxqWRVY+HKJKK+0zHR98j2KWCLxkwB0VLyBxaah0XkKizDVmHB8+8+9l+05FrLbw5pEiUSdXldoVLaTjssjCAoRII5eYyVbsSMOwJ0ewo5G9r/Vz7m3+7xRLVB4t2DZmGdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752846772; c=relaxed/simple;
	bh=CSEJD8D3oT43XCl/3u8vFt7jei+0Iru4A9uRkvyZIxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4V7F32bdvj6loKLc3v4zKThZ4P8vK06c/koewEH185s+Ap0JbZh8kpqWNEO81hLZ7TlV1W3QJPfk2aaICjB2oWIgBnfn0WINSXAR9stg3WMA1aFhOfJIu4BlyTTNVZNPfu98H6w0zA6mcYlnu8RejNG+D3abvpQli9oJo5QIzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksFS0xyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D17C4CEEB;
	Fri, 18 Jul 2025 13:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752846772;
	bh=CSEJD8D3oT43XCl/3u8vFt7jei+0Iru4A9uRkvyZIxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ksFS0xydz9uZ//hk/ReloPIYjNruOr7BcXQBDgkPT4ujIK1wX7nB6Q3hMHhMTKVGf
	 CO+yqbOZ0txZ3JJROJpUZJ5C8+02Hl/AGA+LLeJsuzWD19LO960PJjytZJVblKUZNx
	 DVWscoTSebbXyva8jgvmzu1N7IlYt6YXuHs+ZPVB8ozVpqn+j47I5J3UR1iyYKTt1N
	 Hm48VwGxzzVu2/e6R51toLkuyJC8AN0YilVL0R85C1OnXjCwQ+xFr/xs1psairoRnf
	 gzQW3L3agv5+ijTxr6o6n88epcATNIz1ScXuF34V1+sqR3Vgy2E/oCvfpiLwVJrGox
	 7TvYYqAz47cgg==
Date: Fri, 18 Jul 2025 14:52:46 +0100
From: Lee Jones <lee@kernel.org>
To: Binbin Zhou <zhoubb.aaron@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Corey Minyard <minyard@acm.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net, jeffbai@aosc.io,
	kexybiscuit@aosc.io, wangyao@lemote.com,
	Chong Qiao <qiaochong@loongson.cn>,
	Corey Minyard <corey@minyard.net>
Subject: Re: [PATCH v7 2/3] mfd: ls2kbmc: Add Loongson-2K BMC reset function
 support
Message-ID: <20250718135246.GH11056@google.com>
References: <cover.1751617911.git.zhoubinbin@loongson.cn>
 <f4c546b0160294296c98b6b12b0ab1d2000dd44c.1751617911.git.zhoubinbin@loongson.cn>
 <20250710100323.GI1431498@google.com>
 <CAMpQs4LQME7oO8i2FWgUsAQqwThcp=R3jubPGqZ1Vr-pvEHvoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpQs4LQME7oO8i2FWgUsAQqwThcp=R3jubPGqZ1Vr-pvEHvoA@mail.gmail.com>

On Fri, 11 Jul 2025, Binbin Zhou wrote:

> Hi Lee:
> 
> Thanks for your review.
> 
> On Thu, Jul 10, 2025 at 6:03 PM Lee Jones <lee@kernel.org> wrote:
> >
> > On Fri, 04 Jul 2025, Binbin Zhou wrote:
> >
> > > Since the display is a sub-function of the Loongson-2K BMC, when the
> > > BMC reset, the entire BMC PCIe is disconnected, including the display
> > > which is interrupted.
> > >
> > > Quick overview of the entire LS2K BMC reset process:
> > >
> > > There are two types of reset methods: soft reset (BMC-initiated reboot
> > > of IPMI reset command) and BMC watchdog reset (watchdog timeout).
> > >
> > > First, regardless of the method, an interrupt is generated (PCIe interrupt
> > > for soft reset/GPIO interrupt for watchdog reset);
> > >
> > > Second, during the interrupt process, the system enters bmc_reset_work,
> > > clears the bus/IO/mem resources of the LS7A PCI-E bridge, waits for the BMC
> > > reset to begin, then restores the parent device's PCI configuration space,
> > > waits for the BMC reset to complete, and finally restores the BMC PCI
> > > configuration space.
> > >
> > > Display restoration occurs last.
> > >
> > > Co-developed-by: Chong Qiao <qiaochong@loongson.cn>
> > > Signed-off-by: Chong Qiao <qiaochong@loongson.cn>
> > > Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> > > Acked-by: Corey Minyard <corey@minyard.net>
> > > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > > ---
> > >  drivers/mfd/ls2k-bmc-core.c | 328 ++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 328 insertions(+)
> > >
> > > diff --git a/drivers/mfd/ls2k-bmc-core.c b/drivers/mfd/ls2k-bmc-core.c
> > > index 50d560a4611c..1ae673f6a196 100644
> > > --- a/drivers/mfd/ls2k-bmc-core.c
> > > +++ b/drivers/mfd/ls2k-bmc-core.c
> > > @@ -10,8 +10,12 @@
> > >   */
> > >
> > >  #include <linux/aperture.h>
> > > +#include <linux/bitfield.h>
> > > +#include <linux/delay.h>
> > >  #include <linux/errno.h>
> > >  #include <linux/init.h>
> > > +#include <linux/iopoll.h>
> > > +#include <linux/kbd_kern.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/mfd/core.h>
> > >  #include <linux/module.h>
> > > @@ -19,6 +23,8 @@
> > >  #include <linux/pci_ids.h>
> > >  #include <linux/platform_data/simplefb.h>
> > >  #include <linux/platform_device.h>
> > > +#include <linux/stop_machine.h>
> > > +#include <linux/vt_kern.h>
> > >
> > >  /* LS2K BMC resources */
> > >  #define LS2K_DISPLAY_RES_START               (SZ_16M + SZ_2M)
> > > @@ -29,6 +35,48 @@
> > >  #define LS2K_IPMI3_RES_START         (LS2K_IPMI2_RES_START + LS2K_IPMI_RES_SIZE)
> > >  #define LS2K_IPMI4_RES_START         (LS2K_IPMI3_RES_START + LS2K_IPMI_RES_SIZE)
> > >
> > > +#define LS7A_PCI_CFG_SIZE            0x100
> > > +
> > > +/* LS7A bridge registers */
> > > +#define LS7A_PCIE_PORT_CTL0          0x0
> > > +#define LS7A_PCIE_PORT_STS1          0xC
> > > +#define LS7A_GEN2_CTL                        0x80C
> > > +#define LS7A_SYMBOL_TIMER            0x71C
> > > +
> > > +/* Bits of LS7A_PCIE_PORT_CTL0 */
> > > +#define LS2K_BMC_PCIE_LTSSM_ENABLE   BIT(3)
> > > +
> > > +/* Bits of LS7A_PCIE_PORT_STS1 */
> > > +#define LS2K_BMC_PCIE_LTSSM_STS              GENMASK(5, 0)
> > > +#define LS2K_BMC_PCIE_CONNECTED              0x11
> > > +
> > > +#define LS2K_BMC_PCIE_DELAY_US               1000
> > > +#define LS2K_BMC_PCIE_TIMEOUT_US     1000000
> > > +
> > > +/* Bits of LS7A_GEN2_CTL */
> > > +#define LS7A_GEN2_SPEED_CHANG                BIT(17)
> > > +#define LS7A_CONF_PHY_TX             BIT(18)
> > > +
> > > +/* Bits of LS7A_SYMBOL_TIMER */
> > > +#define LS7A_MASK_LEN_MATCH          BIT(26)
> > > +
> > > +/* Interval between interruptions */
> > > +#define LS2K_BMC_INT_INTERVAL                (60 * HZ)
> > > +
> > > +/* Maximum time to wait for U-Boot and DDR to be ready with ms. */
> > > +#define LS2K_BMC_RESET_WAIT_TIME     10000
> > > +
> > > +/* It's an experience value */
> > > +#define LS7A_BAR0_CHECK_MAX_TIMES    2000
> > > +
> > > +#define LS2K_BMC_RESET_GPIO          14
> > > +#define LOONGSON_GPIO_REG_BASE               0x1FE00500
> > > +#define LOONGSON_GPIO_REG_SIZE               0x18
> > > +#define LOONGSON_GPIO_OEN            0x0
> > > +#define LOONGSON_GPIO_FUNC           0x4
> > > +#define LOONGSON_GPIO_INTPOL         0x10
> > > +#define LOONGSON_GPIO_INTEN          0x14
> > > +
> > >  static struct resource ls2k_display_resources[] = {
> > >       DEFINE_RES_MEM_NAMED(LS2K_DISPLAY_RES_START, SZ_4M, "simpledrm-res"),
> > >  };
> > > @@ -62,6 +110,273 @@ static struct mfd_cell ls2k_bmc_cells[] = {
> > >       MFD_CELL_RES("ls2k-ipmi-si", ls2k_ipmi4_resources),
> > >  };
> > >
> > > +/* Index of the BMC PCI configuration space to be restored at BMC reset. */
> > > +struct ls2k_bmc_pci_data {
> > > +     u32 pci_command;
> > > +     u32 base_address0;
> > > +     u32 interrupt_line;
> > > +};
> > > +
> > > +/* Index of the parent PCI configuration space to be restored at BMC reset. */
> > > +struct ls2k_bmc_bridge_pci_data {
> > > +     u32 pci_command;
> > > +     u32 base_address[6];
> > > +     u32 rom_addreess;
> > > +     u32 interrupt_line;
> > > +     u32 msi_hi;
> > > +     u32 msi_lo;
> > > +     u32 devctl;
> > > +     u32 linkcap;
> > > +     u32 linkctl_sts;
> > > +     u32 symbol_timer;
> > > +     u32 gen2_ctrl;
> > > +};
> > > +
> > > +struct ls2k_bmc_pdata {
> > > +     struct device *dev;
> > > +     struct work_struct bmc_reset_work;
> > > +     struct ls2k_bmc_pci_data bmc_pci_data;
> > > +     struct ls2k_bmc_bridge_pci_data bridge_pci_data;
> > > +};
> > > +
> > > +static bool ls2k_bmc_bar0_addr_is_set(struct pci_dev *ppdev)
> >
> > Nit: This is usually called pdev.
> 
> OK.

Snip things you agree with please.

[...]

> > > +static void ls2k_bmc_events_fn(struct work_struct *work)
> > > +{
> > > +     struct ls2k_bmc_pdata *priv = container_of(work, struct ls2k_bmc_pdata, bmc_reset_work);
> > > +
> > > +     /*
> > > +      * The PCI-E is lost when the BMC resets, at which point access to the PCI-E
> > > +      * from other CPUs is suspended to prevent a crash.
> > > +      */
> > > +     stop_machine(ls2k_bmc_recover_pci_data, priv, NULL);
> > > +
> > > +#ifdef CONFIG_VT
> >
> > #ifery in C-files is generally frowned upon.
> >
> > Is the any pieces of run-time data you can use instead?
> >
> > Or a stub which culminated in a no-op if !CONFIG_VT?
> 
> Emm, I'm not sure if I understand correctly, but is the following way suitable?
> 
>         if (IS_ENABLED(CONFIG_VT))

It's better than #if, but even better would be a stub in a header file.

>                 /* Re-push the display due to previous PCI-E loss. */
>                 set_console(vt_move_to_console(MAX_NR_CONSOLES - 1, 1));
> 
> >
> > > +     /* Re-push the display due to previous PCI-E loss. */
> > > +     set_console(vt_move_to_console(MAX_NR_CONSOLES - 1, 1));
> > > +#endif
> > > +}
> > > +
> > > +static irqreturn_t ls2k_bmc_interrupt(int irq, void *arg)
> > > +{
> > > +     struct ls2k_bmc_pdata *priv = arg;
> > > +     static unsigned long last_jiffies;
> > > +
> > > +     if (system_state != SYSTEM_RUNNING)
> > > +             return IRQ_HANDLED;
> > > +
> > > +     /* Skip interrupt in LS2K_BMC_INT_INTERVAL */
> > > +     if (time_after(jiffies, last_jiffies + LS2K_BMC_INT_INTERVAL)) {
> > > +             schedule_work(&priv->bmc_reset_work);
> > > +             last_jiffies = jiffies;
> > > +     }
> > > +
> > > +     return IRQ_HANDLED;
> > > +}
> > > +
> > > +/*
> > > + * Saves the BMC parent device (LS7A) and its own PCI configuration space registers
> > > + * that need to be restored after BMC reset.
> > > + */
> > > +static void ls2k_bmc_save_pci_data(struct pci_dev *pdev, struct ls2k_bmc_pdata *priv)
> > > +{
> > > +     struct pci_dev *parent = pdev->bus->self;
> > > +     int base, i = 0;
> > > +
> > > +     pci_read_config_dword(parent, PCI_COMMAND, &priv->bridge_pci_data.pci_command);
> > > +
> > > +     for (base = PCI_BASE_ADDRESS_0; base <= PCI_BASE_ADDRESS_5; base += 4, i++)
> > > +             pci_read_config_dword(parent, base, &priv->bridge_pci_data.base_address[i]);
> > > +
> > > +     pci_read_config_dword(parent, PCI_ROM_ADDRESS, &priv->bridge_pci_data.rom_addreess);
> > > +     pci_read_config_dword(parent, PCI_INTERRUPT_LINE, &priv->bridge_pci_data.interrupt_line);
> > > +
> > > +     pci_read_config_dword(parent, parent->msi_cap + PCI_MSI_ADDRESS_LO,
> > > +                           &priv->bridge_pci_data.msi_lo);
> > > +     pci_read_config_dword(parent, parent->msi_cap + PCI_MSI_ADDRESS_HI,
> > > +                           &priv->bridge_pci_data.msi_hi);
> > > +
> > > +     pci_read_config_dword(parent, parent->pcie_cap + PCI_EXP_DEVCTL,
> > > +                           &priv->bridge_pci_data.devctl);
> > > +     pci_read_config_dword(parent, parent->pcie_cap + PCI_EXP_LNKCAP,
> > > +                           &priv->bridge_pci_data.linkcap);
> > > +     pci_read_config_dword(parent, parent->pcie_cap + PCI_EXP_LNKCTL,
> > > +                           &priv->bridge_pci_data.linkctl_sts);
> > > +
> > > +     pci_read_config_dword(parent, LS7A_GEN2_CTL, &priv->bridge_pci_data.gen2_ctrl);
> > > +     priv->bridge_pci_data.gen2_ctrl |= FIELD_PREP(LS7A_GEN2_SPEED_CHANG, 0x1)
> > > +                                     | FIELD_PREP(LS7A_CONF_PHY_TX, 0x0);
> > > +
> > > +     pci_read_config_dword(parent, LS7A_SYMBOL_TIMER, &priv->bridge_pci_data.symbol_timer);
> > > +     priv->bridge_pci_data.symbol_timer |= LS7A_MASK_LEN_MATCH;
> > > +
> > > +     pci_read_config_dword(pdev, PCI_COMMAND, &priv->bmc_pci_data.pci_command);
> > > +     pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &priv->bmc_pci_data.base_address0);
> > > +     pci_read_config_dword(pdev, PCI_INTERRUPT_LINE, &priv->bmc_pci_data.interrupt_line);
> > > +}
> > > +
> > > +static int ls2k_bmc_pdata_initial(struct pci_dev *pdev, struct ls2k_bmc_pdata *priv)
> > > +{
> > > +     int gsi = 16 + (LS2K_BMC_RESET_GPIO & 7);
> > > +     void __iomem *gpio_base;
> > > +     int irq, ret;
> > > +
> > > +     ls2k_bmc_save_pci_data(pdev, priv);
> > > +
> > > +     INIT_WORK(&priv->bmc_reset_work, ls2k_bmc_events_fn);
> > > +
> > > +     ret = devm_request_irq(&pdev->dev, pdev->irq, ls2k_bmc_interrupt,
> > > +                            IRQF_SHARED | IRQF_TRIGGER_FALLING, "ls2kbmc pcie", priv);
> > > +     if (ret) {
> > > +             dev_err(priv->dev, "LS2KBMC PCI-E request_irq(%d) failed\n", pdev->irq);
> >
> > Please don't use function names in error messages.
> >
> > Make them human readable inclusive of non-kernel engineers.
> 
> How about:
> 
> dev_err(ddata->dev, "Failed to request LS2KBMC PCI-E IRQ %d.\n", pdev->irq);
> 
> also, the error message regarding GPIO IRQ is as follows:
> 
> dev_err(ddata->dev, "Failed to request LS2KBMC GPIO IRQ %d.\n", irq);

Yes, much better.

[...]

> > > +     priv = devm_kzalloc(&dev->dev, sizeof(*priv), GFP_KERNEL);
> > > +     if (IS_ERR(priv)) {
> > > +             ret = -ENOMEM;
> > > +             goto disable_pci;
> > > +     }
> > > +
> > > +     priv->dev = &dev->dev;
> > > +
> > > +     ret = ls2k_bmc_pdata_initial(dev, priv);
> >
> > priv (ddata) already contains dev - you don't need both.
> 
> Yes, we just pass priv(ddata), and
> 
> struct pci_dev *pdev = to_pci_dev(ddata->dev);

I would pass dev ... hold on, where do you store priv for reuse?

> > > +     if (ret)
> > > +             goto disable_pci;
> > > +
> > >       ret = ls2k_bmc_parse_mode(dev, &pd);
> > >       if (ret)
> > >               goto disable_pci;
> > > --
> > > 2.47.1
> > >
> >
> > --
> > Lee Jones [李琼斯]
> 
> --
> Thanks.
> Binbin

-- 
Lee Jones [李琼斯]

