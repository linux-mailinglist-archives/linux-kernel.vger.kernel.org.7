Return-Path: <linux-kernel+bounces-725410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A64FAFFEAD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED12562D0D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4472D5433;
	Thu, 10 Jul 2025 10:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oV39LIG9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7977A1A3178;
	Thu, 10 Jul 2025 10:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752141809; cv=none; b=kXpe0lPgxWyXVFAcha4n4UYoAQiM93sPM9TGV6ccjN+lFaqeB+EWu4KmvOQwy/q4ikEib6u7nevHgjZz2i2tui8zTiqce9cOnXlcRG9sU/Z6oXPmV55TAxy1ITt2+u8cmrR3VMdHuK9iN+oVBbTmNxOJlljLoMIdLlPSq8t2mpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752141809; c=relaxed/simple;
	bh=zLZnCIMwNyGnue7Kg1aE52kN1SQQJ2ui7irq3DdDTQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DI5RPxVCw8c2znatXwdIlUDQ3N8GFyYCLyyG4asodN6CKfnRO35/zfIU9vAal/SNh73AQ0Rodry0l7GT60qUce146TZjWXKcmqed4x23Uja04Ut1MZnU0zBBTaPBnMqmiA9COF6E3YEN2JXwkpOMbXkY8YVXMwweQXyLMTVgWx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oV39LIG9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F07CC4CEF1;
	Thu, 10 Jul 2025 10:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752141809;
	bh=zLZnCIMwNyGnue7Kg1aE52kN1SQQJ2ui7irq3DdDTQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oV39LIG9DmXAAOQMgUWCZz2S0AHsV8CSmQRpk+NS9L7bovLqPGUz/a9P1F9vlicL9
	 yZe4GY6Dgzd65EEvGLc0na3D3OfSoBewQNNCDbI1q+R+dGi8XxxYEX3jLXOonVvFr1
	 PsP7X0qFJji1MQzmXBw3b/Y1rlMM6Hk5YtA5QbgjKENw93Gij9qY62ljOUAezTxZdN
	 DkIhqoBeh3YpX8MWT4EcxduXDSCSyvNFpQLTYL43CZxEMvuKbLpKLg78JwWyrmwtl6
	 mHVlq8IY01dHm/t2twGbYhnjhQlN/Kb7+BfOFJdC8Y0sk1uycftJZ3dd15fX/pf4pr
	 a960dp3VnVpfg==
Date: Thu, 10 Jul 2025 11:03:23 +0100
From: Lee Jones <lee@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
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
Message-ID: <20250710100323.GI1431498@google.com>
References: <cover.1751617911.git.zhoubinbin@loongson.cn>
 <f4c546b0160294296c98b6b12b0ab1d2000dd44c.1751617911.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4c546b0160294296c98b6b12b0ab1d2000dd44c.1751617911.git.zhoubinbin@loongson.cn>

On Fri, 04 Jul 2025, Binbin Zhou wrote:

> Since the display is a sub-function of the Loongson-2K BMC, when the
> BMC reset, the entire BMC PCIe is disconnected, including the display
> which is interrupted.
> 
> Quick overview of the entire LS2K BMC reset process:
> 
> There are two types of reset methods: soft reset (BMC-initiated reboot
> of IPMI reset command) and BMC watchdog reset (watchdog timeout).
> 
> First, regardless of the method, an interrupt is generated (PCIe interrupt
> for soft reset/GPIO interrupt for watchdog reset);
> 
> Second, during the interrupt process, the system enters bmc_reset_work,
> clears the bus/IO/mem resources of the LS7A PCI-E bridge, waits for the BMC
> reset to begin, then restores the parent device's PCI configuration space,
> waits for the BMC reset to complete, and finally restores the BMC PCI
> configuration space.
> 
> Display restoration occurs last.
> 
> Co-developed-by: Chong Qiao <qiaochong@loongson.cn>
> Signed-off-by: Chong Qiao <qiaochong@loongson.cn>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> Acked-by: Corey Minyard <corey@minyard.net>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  drivers/mfd/ls2k-bmc-core.c | 328 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 328 insertions(+)
> 
> diff --git a/drivers/mfd/ls2k-bmc-core.c b/drivers/mfd/ls2k-bmc-core.c
> index 50d560a4611c..1ae673f6a196 100644
> --- a/drivers/mfd/ls2k-bmc-core.c
> +++ b/drivers/mfd/ls2k-bmc-core.c
> @@ -10,8 +10,12 @@
>   */
>  
>  #include <linux/aperture.h>
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
>  #include <linux/errno.h>
>  #include <linux/init.h>
> +#include <linux/iopoll.h>
> +#include <linux/kbd_kern.h>
>  #include <linux/kernel.h>
>  #include <linux/mfd/core.h>
>  #include <linux/module.h>
> @@ -19,6 +23,8 @@
>  #include <linux/pci_ids.h>
>  #include <linux/platform_data/simplefb.h>
>  #include <linux/platform_device.h>
> +#include <linux/stop_machine.h>
> +#include <linux/vt_kern.h>
>  
>  /* LS2K BMC resources */
>  #define LS2K_DISPLAY_RES_START		(SZ_16M + SZ_2M)
> @@ -29,6 +35,48 @@
>  #define LS2K_IPMI3_RES_START		(LS2K_IPMI2_RES_START + LS2K_IPMI_RES_SIZE)
>  #define LS2K_IPMI4_RES_START		(LS2K_IPMI3_RES_START + LS2K_IPMI_RES_SIZE)
>  
> +#define LS7A_PCI_CFG_SIZE		0x100
> +
> +/* LS7A bridge registers */
> +#define LS7A_PCIE_PORT_CTL0		0x0
> +#define LS7A_PCIE_PORT_STS1		0xC
> +#define LS7A_GEN2_CTL			0x80C
> +#define LS7A_SYMBOL_TIMER		0x71C
> +
> +/* Bits of LS7A_PCIE_PORT_CTL0 */
> +#define LS2K_BMC_PCIE_LTSSM_ENABLE	BIT(3)
> +
> +/* Bits of LS7A_PCIE_PORT_STS1 */
> +#define LS2K_BMC_PCIE_LTSSM_STS		GENMASK(5, 0)
> +#define LS2K_BMC_PCIE_CONNECTED		0x11
> +
> +#define LS2K_BMC_PCIE_DELAY_US		1000
> +#define LS2K_BMC_PCIE_TIMEOUT_US	1000000
> +
> +/* Bits of LS7A_GEN2_CTL */
> +#define LS7A_GEN2_SPEED_CHANG		BIT(17)
> +#define LS7A_CONF_PHY_TX		BIT(18)
> +
> +/* Bits of LS7A_SYMBOL_TIMER */
> +#define LS7A_MASK_LEN_MATCH		BIT(26)
> +
> +/* Interval between interruptions */
> +#define LS2K_BMC_INT_INTERVAL		(60 * HZ)
> +
> +/* Maximum time to wait for U-Boot and DDR to be ready with ms. */
> +#define LS2K_BMC_RESET_WAIT_TIME	10000
> +
> +/* It's an experience value */
> +#define LS7A_BAR0_CHECK_MAX_TIMES	2000
> +
> +#define LS2K_BMC_RESET_GPIO		14
> +#define LOONGSON_GPIO_REG_BASE		0x1FE00500
> +#define LOONGSON_GPIO_REG_SIZE		0x18
> +#define LOONGSON_GPIO_OEN		0x0
> +#define LOONGSON_GPIO_FUNC		0x4
> +#define LOONGSON_GPIO_INTPOL		0x10
> +#define LOONGSON_GPIO_INTEN		0x14
> +
>  static struct resource ls2k_display_resources[] = {
>  	DEFINE_RES_MEM_NAMED(LS2K_DISPLAY_RES_START, SZ_4M, "simpledrm-res"),
>  };
> @@ -62,6 +110,273 @@ static struct mfd_cell ls2k_bmc_cells[] = {
>  	MFD_CELL_RES("ls2k-ipmi-si", ls2k_ipmi4_resources),
>  };
>  
> +/* Index of the BMC PCI configuration space to be restored at BMC reset. */
> +struct ls2k_bmc_pci_data {
> +	u32 pci_command;
> +	u32 base_address0;
> +	u32 interrupt_line;
> +};
> +
> +/* Index of the parent PCI configuration space to be restored at BMC reset. */
> +struct ls2k_bmc_bridge_pci_data {
> +	u32 pci_command;
> +	u32 base_address[6];
> +	u32 rom_addreess;
> +	u32 interrupt_line;
> +	u32 msi_hi;
> +	u32 msi_lo;
> +	u32 devctl;
> +	u32 linkcap;
> +	u32 linkctl_sts;
> +	u32 symbol_timer;
> +	u32 gen2_ctrl;
> +};
> +
> +struct ls2k_bmc_pdata {
> +	struct device *dev;
> +	struct work_struct bmc_reset_work;
> +	struct ls2k_bmc_pci_data bmc_pci_data;
> +	struct ls2k_bmc_bridge_pci_data bridge_pci_data;
> +};
> +
> +static bool ls2k_bmc_bar0_addr_is_set(struct pci_dev *ppdev)

Nit: This is usually called pdev.

> +{
> +	u32 addr;
> +
> +	pci_read_config_dword(ppdev, PCI_BASE_ADDRESS_0, &addr);
> +
> +	return addr & PCI_BASE_ADDRESS_MEM_MASK ? true : false;
> +}
> +
> +static bool ls2k_bmc_pcie_is_connected(struct pci_dev *parent, struct ls2k_bmc_pdata *priv)

Nit: Rename priv to ddata.

> +{
> +	void __iomem *base;
> +	int sts, ret;
> +
> +	base = pci_iomap(parent, 0, LS7A_PCI_CFG_SIZE);
> +	if (!base)
> +		return false;
> +
> +	writel(readl(base + LS7A_PCIE_PORT_CTL0) | LS2K_BMC_PCIE_LTSSM_ENABLE,
> +	       base + LS7A_PCIE_PORT_CTL0);
> +
> +	ret = readl_poll_timeout_atomic(base + LS7A_PCIE_PORT_STS1, sts,
> +					(sts & LS2K_BMC_PCIE_LTSSM_STS) == LS2K_BMC_PCIE_CONNECTED,
> +					LS2K_BMC_PCIE_DELAY_US, LS2K_BMC_PCIE_TIMEOUT_US);
> +	if (ret) {
> +		pci_iounmap(parent, base);
> +		dev_err(priv->dev, "PCIE train failed status=0x%x\n", sts);
> +		return false;
> +	}
> +
> +	pci_iounmap(parent, base);
> +	return true;
> +}
> +
> +static void ls2k_bmc_restore_bridge_pci_data(struct pci_dev *parent, struct ls2k_bmc_pdata *priv)
> +{
> +	int base, i = 0;
> +
> +	pci_write_config_dword(parent, PCI_COMMAND, priv->bridge_pci_data.pci_command);
> +
> +	for (base = PCI_BASE_ADDRESS_0; base <= PCI_BASE_ADDRESS_5; base += 4, i++)
> +		pci_write_config_dword(parent, base, priv->bridge_pci_data.base_address[i]);
> +
> +	pci_write_config_dword(parent, PCI_ROM_ADDRESS, priv->bridge_pci_data.rom_addreess);
> +	pci_write_config_dword(parent, PCI_INTERRUPT_LINE, priv->bridge_pci_data.interrupt_line);
> +
> +	pci_write_config_dword(parent, parent->msi_cap + PCI_MSI_ADDRESS_LO,
> +			       priv->bridge_pci_data.msi_lo);
> +	pci_write_config_dword(parent, parent->msi_cap + PCI_MSI_ADDRESS_HI,
> +			       priv->bridge_pci_data.msi_hi);
> +	pci_write_config_dword(parent, parent->pcie_cap + PCI_EXP_DEVCTL,
> +			       priv->bridge_pci_data.devctl);
> +	pci_write_config_dword(parent, parent->pcie_cap + PCI_EXP_LNKCAP,
> +			       priv->bridge_pci_data.linkcap);
> +	pci_write_config_dword(parent, parent->pcie_cap + PCI_EXP_LNKCTL,
> +			       priv->bridge_pci_data.linkctl_sts);
> +
> +	pci_write_config_dword(parent, LS7A_GEN2_CTL, priv->bridge_pci_data.gen2_ctrl);
> +	pci_write_config_dword(parent, LS7A_SYMBOL_TIMER, priv->bridge_pci_data.symbol_timer);
> +}
> +
> +static int ls2k_bmc_recover_pci_data(void *data)
> +{
> +	struct ls2k_bmc_pdata *priv = data;
> +	struct pci_dev *pdev = to_pci_dev(priv->dev);
> +	struct pci_dev *parent = pdev->bus->self;
> +	u32 i;
> +
> +	/*
> +	 * Clear the bus, io and mem resources of the PCI-E bridge to zero, so that
> +	 * the processor can not access the LS2K PCI-E port, to avoid crashing due to
> +	 * the lack of return signal from accessing the LS2K PCI-E port.
> +	 */
> +	pci_write_config_dword(parent, PCI_BASE_ADDRESS_2, 0);
> +	pci_write_config_dword(parent, PCI_BASE_ADDRESS_3, 0);
> +	pci_write_config_dword(parent, PCI_BASE_ADDRESS_4, 0);
> +
> +	/*
> +	 * When the LS2K BMC is reset, the LS7A PCI-E port is also reset, and its PCI
> +	 * BAR0 register is cleared. Due to the time gap between the GPIO interrupt
> +	 * generation and the LS2K BMC reset, the LS7A PCI BAR0 register is read to
> +	 * determine whether the reset has begun.
> +	 */
> +	for (i = LS7A_BAR0_CHECK_MAX_TIMES; i > 0 ; i--) {
> +		if (!ls2k_bmc_bar0_addr_is_set(parent))
> +			break;
> +		mdelay(1);
> +	};
> +
> +	if (i == 0)
> +		return false;
> +
> +	ls2k_bmc_restore_bridge_pci_data(parent, priv);
> +
> +	/* Check if PCI-E is connected */
> +	if (!ls2k_bmc_pcie_is_connected(parent, priv))
> +		return false;
> +
> +	/* Waiting for U-Boot and DDR ready */
> +	mdelay(LS2K_BMC_RESET_WAIT_TIME);
> +	if (!ls2k_bmc_bar0_addr_is_set(parent))
> +		return false;
> +
> +	/* Restore LS2K BMC PCI-E config data */
> +	pci_write_config_dword(pdev, PCI_COMMAND, priv->bmc_pci_data.pci_command);
> +	pci_write_config_dword(pdev, PCI_BASE_ADDRESS_0, priv->bmc_pci_data.base_address0);
> +	pci_write_config_dword(pdev, PCI_INTERRUPT_LINE, priv->bmc_pci_data.interrupt_line);
> +
> +	return 0;
> +}
> +
> +static void ls2k_bmc_events_fn(struct work_struct *work)
> +{
> +	struct ls2k_bmc_pdata *priv = container_of(work, struct ls2k_bmc_pdata, bmc_reset_work);
> +
> +	/*
> +	 * The PCI-E is lost when the BMC resets, at which point access to the PCI-E
> +	 * from other CPUs is suspended to prevent a crash.
> +	 */
> +	stop_machine(ls2k_bmc_recover_pci_data, priv, NULL);
> +
> +#ifdef CONFIG_VT

#ifery in C-files is generally frowned upon.

Is the any pieces of run-time data you can use instead?

Or a stub which culminated in a no-op if !CONFIG_VT?

> +	/* Re-push the display due to previous PCI-E loss. */
> +	set_console(vt_move_to_console(MAX_NR_CONSOLES - 1, 1));
> +#endif
> +}
> +
> +static irqreturn_t ls2k_bmc_interrupt(int irq, void *arg)
> +{
> +	struct ls2k_bmc_pdata *priv = arg;
> +	static unsigned long last_jiffies;
> +
> +	if (system_state != SYSTEM_RUNNING)
> +		return IRQ_HANDLED;
> +
> +	/* Skip interrupt in LS2K_BMC_INT_INTERVAL */
> +	if (time_after(jiffies, last_jiffies + LS2K_BMC_INT_INTERVAL)) {
> +		schedule_work(&priv->bmc_reset_work);
> +		last_jiffies = jiffies;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * Saves the BMC parent device (LS7A) and its own PCI configuration space registers
> + * that need to be restored after BMC reset.
> + */
> +static void ls2k_bmc_save_pci_data(struct pci_dev *pdev, struct ls2k_bmc_pdata *priv)
> +{
> +	struct pci_dev *parent = pdev->bus->self;
> +	int base, i = 0;
> +
> +	pci_read_config_dword(parent, PCI_COMMAND, &priv->bridge_pci_data.pci_command);
> +
> +	for (base = PCI_BASE_ADDRESS_0; base <= PCI_BASE_ADDRESS_5; base += 4, i++)
> +		pci_read_config_dword(parent, base, &priv->bridge_pci_data.base_address[i]);
> +
> +	pci_read_config_dword(parent, PCI_ROM_ADDRESS, &priv->bridge_pci_data.rom_addreess);
> +	pci_read_config_dword(parent, PCI_INTERRUPT_LINE, &priv->bridge_pci_data.interrupt_line);
> +
> +	pci_read_config_dword(parent, parent->msi_cap + PCI_MSI_ADDRESS_LO,
> +			      &priv->bridge_pci_data.msi_lo);
> +	pci_read_config_dword(parent, parent->msi_cap + PCI_MSI_ADDRESS_HI,
> +			      &priv->bridge_pci_data.msi_hi);
> +
> +	pci_read_config_dword(parent, parent->pcie_cap + PCI_EXP_DEVCTL,
> +			      &priv->bridge_pci_data.devctl);
> +	pci_read_config_dword(parent, parent->pcie_cap + PCI_EXP_LNKCAP,
> +			      &priv->bridge_pci_data.linkcap);
> +	pci_read_config_dword(parent, parent->pcie_cap + PCI_EXP_LNKCTL,
> +			      &priv->bridge_pci_data.linkctl_sts);
> +
> +	pci_read_config_dword(parent, LS7A_GEN2_CTL, &priv->bridge_pci_data.gen2_ctrl);
> +	priv->bridge_pci_data.gen2_ctrl |= FIELD_PREP(LS7A_GEN2_SPEED_CHANG, 0x1)
> +					| FIELD_PREP(LS7A_CONF_PHY_TX, 0x0);
> +
> +	pci_read_config_dword(parent, LS7A_SYMBOL_TIMER, &priv->bridge_pci_data.symbol_timer);
> +	priv->bridge_pci_data.symbol_timer |= LS7A_MASK_LEN_MATCH;
> +
> +	pci_read_config_dword(pdev, PCI_COMMAND, &priv->bmc_pci_data.pci_command);
> +	pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &priv->bmc_pci_data.base_address0);
> +	pci_read_config_dword(pdev, PCI_INTERRUPT_LINE, &priv->bmc_pci_data.interrupt_line);
> +}
> +
> +static int ls2k_bmc_pdata_initial(struct pci_dev *pdev, struct ls2k_bmc_pdata *priv)
> +{
> +	int gsi = 16 + (LS2K_BMC_RESET_GPIO & 7);
> +	void __iomem *gpio_base;
> +	int irq, ret;
> +
> +	ls2k_bmc_save_pci_data(pdev, priv);
> +
> +	INIT_WORK(&priv->bmc_reset_work, ls2k_bmc_events_fn);
> +
> +	ret = devm_request_irq(&pdev->dev, pdev->irq, ls2k_bmc_interrupt,
> +			       IRQF_SHARED | IRQF_TRIGGER_FALLING, "ls2kbmc pcie", priv);
> +	if (ret) {
> +		dev_err(priv->dev, "LS2KBMC PCI-E request_irq(%d) failed\n", pdev->irq);

Please don't use function names in error messages.

Make them human readable inclusive of non-kernel engineers.

> +		return ret;
> +	}
> +
> +	/*
> +	 * Since gpio_chip->to_irq is not implemented in the Loongson-3 GPIO driver,
> +	 * acpi_register_gsi() is used to obtain the GPIO irq. The GPIO interrupt is a

"IRQ"

> +	 * watchdog interrupt that is triggered when the BMC resets.
> +	 */
> +	irq = acpi_register_gsi(NULL, gsi, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW);
> +	if (irq < 0)
> +		return irq;
> +
> +	gpio_base = ioremap(LOONGSON_GPIO_REG_BASE, LOONGSON_GPIO_REG_SIZE);
> +	if (!gpio_base) {
> +		ret = PTR_ERR(gpio_base);
> +		goto acpi_failed;
> +	}
> +
> +	writel(readl(gpio_base + LOONGSON_GPIO_OEN) | BIT(LS2K_BMC_RESET_GPIO),
> +	       gpio_base + LOONGSON_GPIO_OEN);
> +	writel(readl(gpio_base + LOONGSON_GPIO_FUNC) & ~BIT(LS2K_BMC_RESET_GPIO),
> +	       gpio_base + LOONGSON_GPIO_FUNC);
> +	writel(readl(gpio_base + LOONGSON_GPIO_INTPOL) & ~BIT(LS2K_BMC_RESET_GPIO),
> +	       gpio_base + LOONGSON_GPIO_INTPOL);
> +	writel(readl(gpio_base + LOONGSON_GPIO_INTEN) | BIT(LS2K_BMC_RESET_GPIO),
> +	       gpio_base + LOONGSON_GPIO_INTEN);
> +
> +	ret = devm_request_irq(priv->dev, irq, ls2k_bmc_interrupt,
> +			       IRQF_SHARED | IRQF_TRIGGER_FALLING, "ls2kbmc gpio", priv);
> +	if (ret)
> +		dev_err(priv->dev, "LS2KBMC GPIO request_irq(%d) failed\n", irq);
> +
> +	iounmap(gpio_base);
> +
> +acpi_failed:
> +	acpi_unregister_gsi(gsi);
> +	return ret;
> +}
> +
>  /*
>   * Currently the Loongson-2K BMC hardware does not have an I2C interface to adapt to the
>   * resolution. We set the resolution by presetting "video=1280x1024-16@2M" to the BMC memory.
> @@ -101,6 +416,7 @@ static int ls2k_bmc_parse_mode(struct pci_dev *pdev, struct simplefb_platform_da
>  static int ls2k_bmc_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  {
>  	struct simplefb_platform_data pd;
> +	struct ls2k_bmc_pdata *priv;
>  	resource_size_t base;
>  	int ret;
>  
> @@ -108,6 +424,18 @@ static int ls2k_bmc_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	if (ret)
>  		return ret;
>  
> +	priv = devm_kzalloc(&dev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (IS_ERR(priv)) {
> +		ret = -ENOMEM;
> +		goto disable_pci;
> +	}
> +
> +	priv->dev = &dev->dev;
> +
> +	ret = ls2k_bmc_pdata_initial(dev, priv);

priv (ddata) already contains dev - you don't need both.

> +	if (ret)
> +		goto disable_pci;
> +
>  	ret = ls2k_bmc_parse_mode(dev, &pd);
>  	if (ret)
>  		goto disable_pci;
> -- 
> 2.47.1
> 

-- 
Lee Jones [李琼斯]

