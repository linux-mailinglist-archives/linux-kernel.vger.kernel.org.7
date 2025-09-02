Return-Path: <linux-kernel+bounces-796815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B6BB4077A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B790E3ACD1F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B604C2DEA82;
	Tue,  2 Sep 2025 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZsRbNEC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81E427B356;
	Tue,  2 Sep 2025 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824396; cv=none; b=eV9HmBXPtwqW8e6lT2O43qcnrBqgMD9Mejs/3C+GARx5mpbaWYMbgmGrIcCl57NTJBMv8VM3HEnumGYpvATHQteZEcxODO7ZdLTEIKU29mvktZynhdMpkBwZi7s0TUWW7LmKYMeThaPssps0s/0luqsPDf+NBCIxV6p42vnsRc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824396; c=relaxed/simple;
	bh=kaBG2w9TksfL1dOZ8czdQ8x5eGNez7ihzCL6BkbFWsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKx2DjrG4pk2LJEozcRbFacDvjZ4xAJ3D7WBK2x6R4Ufh4lcJl2s8ADKmOum+OTNq8WLaNrIvSo8SNFLLAEnqfzLB2bGwQlkFJdKMP36SnHMeBniLdCEsKNafiygKKV865GF5OD5s3DQbc6EnPsdHP8SQHt64gmtu5sXtdzZfD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZsRbNEC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8196DC4CEF6;
	Tue,  2 Sep 2025 14:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756824396;
	bh=kaBG2w9TksfL1dOZ8czdQ8x5eGNez7ihzCL6BkbFWsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FZsRbNEC1gzGZIPwADzQSqvfIJI/SfW2hkB6PK2D+eLyK9o1jxfiZBP1+Cf6dN9ka
	 jL8pXHp3AQDGFCvNqrJeHVF6uX3MW6VB9ZxQhudsfGkxsK2StWAjXpmmzVhWDjPJ/J
	 BOrlPv7LQHfTCqRg1CC6IIjnglyJsEYJC+E8LkwysImD5RZ97MWJXYTR74ERWm2np2
	 xJrJQDLfMBVbXzWy0DXWU1US/yI9egPmqdessTMkzOgdqQztvvS5QKJyksnMZcaNoW
	 t/vNqkNNV5s9NFmmceScTT+v7DfMfwhMR+J/wBxgPfnKoMdT+zYblXK5LKZ/p1PkM0
	 0uDfTsEBBrrIQ==
Date: Tue, 2 Sep 2025 15:46:30 +0100
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
Subject: Re: [PATCH v10 2/3] mfd: ls2kbmc: Add Loongson-2K BMC reset function
 support
Message-ID: <20250902144630.GS2163762@google.com>
References: <cover.1755853480.git.zhoubinbin@loongson.cn>
 <8c67ace6b4b49725b0a2a7345e3683dbdf65e21c.1755853480.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c67ace6b4b49725b0a2a7345e3683dbdf65e21c.1755853480.git.zhoubinbin@loongson.cn>

On Fri, 22 Aug 2025, Binbin Zhou wrote:

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
>  drivers/mfd/ls2k-bmc-core.c | 336 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 336 insertions(+)

Couple of nits to finish up:

> diff --git a/drivers/mfd/ls2k-bmc-core.c b/drivers/mfd/ls2k-bmc-core.c
> index 39cc481d9ba1..fa7f1a822076 100644
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
>  enum {
>  	LS2K_BMC_DISPLAY,
>  	LS2K_BMC_IPMI0,
> @@ -95,6 +143,281 @@ static struct mfd_cell ls2k_bmc_cells[] = {
>  	},
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

Drop the pdata part completely.

pdata is something else.

> +	struct device *dev;
> +	struct work_struct bmc_reset_work;
> +	struct ls2k_bmc_pci_data bmc_pci_data;
> +	struct ls2k_bmc_bridge_pci_data bridge_pci_data;
> +};
> +
> +static bool ls2k_bmc_bar0_addr_is_set(struct pci_dev *pdev)
> +{
> +	u32 addr;
> +
> +	pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &addr);
> +
> +	return addr & PCI_BASE_ADDRESS_MEM_MASK ? true : false;
> +}
> +
> +static bool ls2k_bmc_pcie_is_connected(struct pci_dev *parent, struct ls2k_bmc_pdata *ddata)
> +{
> +	void __iomem *base;
> +	int val, ret;
> +
> +	base = pci_iomap(parent, 0, LS7A_PCI_CFG_SIZE);
> +	if (!base)
> +		return false;
> +
> +	val = readl(base + LS7A_PCIE_PORT_CTL0);
> +	writel(val | LS2K_BMC_PCIE_LTSSM_ENABLE, base + LS7A_PCIE_PORT_CTL0);
> +
> +	ret = readl_poll_timeout_atomic(base + LS7A_PCIE_PORT_STS1, val,
> +					(val & LS2K_BMC_PCIE_LTSSM_STS) == LS2K_BMC_PCIE_CONNECTED,
> +					LS2K_BMC_PCIE_DELAY_US, LS2K_BMC_PCIE_TIMEOUT_US);
> +	if (ret) {
> +		pci_iounmap(parent, base);
> +		dev_err(ddata->dev, "PCI-E training failed status=0x%x\n", val);
> +		return false;
> +	}
> +
> +	pci_iounmap(parent, base);
> +	return true;
> +}
> +
> +static void ls2k_bmc_restore_bridge_pci_data(struct pci_dev *parent, struct ls2k_bmc_pdata *ddata)
> +{
> +	int base, i = 0;
> +
> +	pci_write_config_dword(parent, PCI_COMMAND, ddata->bridge_pci_data.pci_command);
> +
> +	for (base = PCI_BASE_ADDRESS_0; base <= PCI_BASE_ADDRESS_5; base += 4, i++)

Define 4.

> +		pci_write_config_dword(parent, base, ddata->bridge_pci_data.base_address[i]);
> +
> +	pci_write_config_dword(parent, PCI_ROM_ADDRESS, ddata->bridge_pci_data.rom_addreess);
> +	pci_write_config_dword(parent, PCI_INTERRUPT_LINE, ddata->bridge_pci_data.interrupt_line);
> +
> +	pci_write_config_dword(parent, parent->msi_cap + PCI_MSI_ADDRESS_LO,
> +			       ddata->bridge_pci_data.msi_lo);
> +	pci_write_config_dword(parent, parent->msi_cap + PCI_MSI_ADDRESS_HI,
> +			       ddata->bridge_pci_data.msi_hi);
> +	pci_write_config_dword(parent, parent->pcie_cap + PCI_EXP_DEVCTL,
> +			       ddata->bridge_pci_data.devctl);
> +	pci_write_config_dword(parent, parent->pcie_cap + PCI_EXP_LNKCAP,
> +			       ddata->bridge_pci_data.linkcap);
> +	pci_write_config_dword(parent, parent->pcie_cap + PCI_EXP_LNKCTL,
> +			       ddata->bridge_pci_data.linkctl_sts);
> +
> +	pci_write_config_dword(parent, LS7A_GEN2_CTL, ddata->bridge_pci_data.gen2_ctrl);
> +	pci_write_config_dword(parent, LS7A_SYMBOL_TIMER, ddata->bridge_pci_data.symbol_timer);
> +}
> +
> +static int ls2k_bmc_recover_pci_data(void *data)
> +{
> +	struct ls2k_bmc_pdata *ddata = data;
> +	struct pci_dev *pdev = to_pci_dev(ddata->dev);
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
> +	ls2k_bmc_restore_bridge_pci_data(parent, ddata);
> +
> +	/* Check if PCI-E is connected */
> +	if (!ls2k_bmc_pcie_is_connected(parent, ddata))
> +		return false;
> +
> +	/* Waiting for U-Boot and DDR ready */
> +	mdelay(LS2K_BMC_RESET_WAIT_TIME);
> +	if (!ls2k_bmc_bar0_addr_is_set(parent))
> +		return false;
> +
> +	/* Restore LS2K BMC PCI-E config data */
> +	pci_write_config_dword(pdev, PCI_COMMAND, ddata->bmc_pci_data.pci_command);
> +	pci_write_config_dword(pdev, PCI_BASE_ADDRESS_0, ddata->bmc_pci_data.base_address0);
> +	pci_write_config_dword(pdev, PCI_INTERRUPT_LINE, ddata->bmc_pci_data.interrupt_line);
> +
> +	return 0;
> +}
> +
> +static void ls2k_bmc_events_fn(struct work_struct *work)
> +{
> +	struct ls2k_bmc_pdata *ddata = container_of(work, struct ls2k_bmc_pdata, bmc_reset_work);
> +
> +	/*
> +	 * The PCI-E is lost when the BMC resets, at which point access to the PCI-E
> +	 * from other CPUs is suspended to prevent a crash.
> +	 */
> +	stop_machine(ls2k_bmc_recover_pci_data, ddata, NULL);
> +
> +	if (IS_ENABLED(CONFIG_VT)) {
> +		/* Re-push the display due to previous PCI-E loss. */
> +		set_console(vt_move_to_console(MAX_NR_CONSOLES - 1, 1));
> +	}
> +}
> +
> +static irqreturn_t ls2k_bmc_interrupt(int irq, void *arg)
> +{
> +	struct ls2k_bmc_pdata *ddata = arg;
> +	static unsigned long last_jiffies;
> +
> +	if (system_state != SYSTEM_RUNNING)
> +		return IRQ_HANDLED;
> +
> +	/* Skip interrupt in LS2K_BMC_INT_INTERVAL */
> +	if (time_after(jiffies, last_jiffies + LS2K_BMC_INT_INTERVAL)) {
> +		schedule_work(&ddata->bmc_reset_work);
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
> +static void ls2k_bmc_save_pci_data(struct pci_dev *pdev, struct ls2k_bmc_pdata *ddata)
> +{
> +	struct pci_dev *parent = pdev->bus->self;
> +	int base, i = 0;
> +
> +	pci_read_config_dword(parent, PCI_COMMAND, &ddata->bridge_pci_data.pci_command);
> +
> +	for (base = PCI_BASE_ADDRESS_0; base <= PCI_BASE_ADDRESS_5; base += 4, i++)
> +		pci_read_config_dword(parent, base, &ddata->bridge_pci_data.base_address[i]);
> +
> +	pci_read_config_dword(parent, PCI_ROM_ADDRESS, &ddata->bridge_pci_data.rom_addreess);
> +	pci_read_config_dword(parent, PCI_INTERRUPT_LINE, &ddata->bridge_pci_data.interrupt_line);
> +
> +	pci_read_config_dword(parent, parent->msi_cap + PCI_MSI_ADDRESS_LO,
> +			      &ddata->bridge_pci_data.msi_lo);
> +	pci_read_config_dword(parent, parent->msi_cap + PCI_MSI_ADDRESS_HI,
> +			      &ddata->bridge_pci_data.msi_hi);
> +
> +	pci_read_config_dword(parent, parent->pcie_cap + PCI_EXP_DEVCTL,
> +			      &ddata->bridge_pci_data.devctl);
> +	pci_read_config_dword(parent, parent->pcie_cap + PCI_EXP_LNKCAP,
> +			      &ddata->bridge_pci_data.linkcap);
> +	pci_read_config_dword(parent, parent->pcie_cap + PCI_EXP_LNKCTL,
> +			      &ddata->bridge_pci_data.linkctl_sts);
> +
> +	pci_read_config_dword(parent, LS7A_GEN2_CTL, &ddata->bridge_pci_data.gen2_ctrl);
> +	ddata->bridge_pci_data.gen2_ctrl |= FIELD_PREP(LS7A_GEN2_SPEED_CHANG, 0x1)
> +					| FIELD_PREP(LS7A_CONF_PHY_TX, 0x0);
> +
> +	pci_read_config_dword(parent, LS7A_SYMBOL_TIMER, &ddata->bridge_pci_data.symbol_timer);
> +	ddata->bridge_pci_data.symbol_timer |= LS7A_MASK_LEN_MATCH;
> +
> +	pci_read_config_dword(pdev, PCI_COMMAND, &ddata->bmc_pci_data.pci_command);
> +	pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &ddata->bmc_pci_data.base_address0);
> +	pci_read_config_dword(pdev, PCI_INTERRUPT_LINE, &ddata->bmc_pci_data.interrupt_line);
> +}
> +
> +static int ls2k_bmc_pdata_initial(struct ls2k_bmc_pdata *ddata)

What are you actually doing here exactly.

I don't think "pdata_initial" describes it.

> +{
> +	struct pci_dev *pdev = to_pci_dev(ddata->dev);
> +	int gsi = 16 + (LS2K_BMC_RESET_GPIO & 7);

Define 16.

> +	void __iomem *gpio_base;
> +	int irq, ret, val;
> +
> +	ls2k_bmc_save_pci_data(pdev, ddata);
> +
> +	INIT_WORK(&ddata->bmc_reset_work, ls2k_bmc_events_fn);
> +
> +	ret = devm_request_irq(&pdev->dev, pdev->irq, ls2k_bmc_interrupt,
> +			       IRQF_SHARED | IRQF_TRIGGER_FALLING, "ls2kbmc pcie", ddata);
> +	if (ret) {
> +		dev_err(ddata->dev, "Failed to request LS2KBMC PCI-E IRQ %d.\n", pdev->irq);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Since gpio_chip->to_irq is not implemented in the Loongson-3 GPIO driver,
> +	 * acpi_register_gsi() is used to obtain the GPIO IRQ. The GPIO interrupt is a
> +	 * watchdog interrupt that is triggered when the BMC resets.
> +	 */
> +	irq = acpi_register_gsi(NULL, gsi, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW);
> +	if (irq < 0)
> +		return irq;
> +
> +	gpio_base = ioremap(LOONGSON_GPIO_REG_BASE, LOONGSON_GPIO_REG_SIZE);
> +	if (!gpio_base) {
> +		ret = -ENOMEM;
> +		goto acpi_failed;
> +	}
> +
> +	/* Disable GPIO output */
> +	val = readl(gpio_base + LOONGSON_GPIO_OEN);
> +	writel(val | BIT(LS2K_BMC_RESET_GPIO), gpio_base + LOONGSON_GPIO_OEN);
> +
> +	/* Enable GPIO functionality */
> +	val = readl(gpio_base + LOONGSON_GPIO_FUNC);
> +	writel(val & ~BIT(LS2K_BMC_RESET_GPIO), gpio_base + LOONGSON_GPIO_FUNC);
> +
> +	/* Set GPIO interrupts to low-level active */
> +	val = readl(gpio_base + LOONGSON_GPIO_INTPOL);
> +	writel(val & ~BIT(LS2K_BMC_RESET_GPIO), gpio_base + LOONGSON_GPIO_INTPOL);
> +
> +	/* Enable GPIO interrupts */
> +	val = readl(gpio_base + LOONGSON_GPIO_INTEN);
> +	writel(val | BIT(LS2K_BMC_RESET_GPIO), gpio_base + LOONGSON_GPIO_INTEN);
> +
> +	ret = devm_request_irq(ddata->dev, irq, ls2k_bmc_interrupt,
> +			       IRQF_SHARED | IRQF_TRIGGER_FALLING, "ls2kbmc gpio", ddata);
> +	if (ret)
> +		dev_err(ddata->dev, "Failed to request LS2KBMC GPIO IRQ %d.\n", irq);
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
> @@ -134,6 +457,7 @@ static int ls2k_bmc_parse_mode(struct pci_dev *pdev, struct simplefb_platform_da
>  static int ls2k_bmc_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  {
>  	struct simplefb_platform_data pd;
> +	struct ls2k_bmc_pdata *ddata;
>  	resource_size_t base;
>  	int ret;
>  
> @@ -141,6 +465,18 @@ static int ls2k_bmc_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	if (ret)
>  		return ret;
>  
> +	ddata = devm_kzalloc(&dev->dev, sizeof(*ddata), GFP_KERNEL);
> +	if (IS_ERR(ddata)) {
> +		ret = -ENOMEM;
> +		goto disable_pci;
> +	}
> +
> +	ddata->dev = &dev->dev;
> +
> +	ret = ls2k_bmc_pdata_initial(ddata);
> +	if (ret)
> +		goto disable_pci;
> +
>  	ret = ls2k_bmc_parse_mode(dev, &pd);
>  	if (ret)
>  		goto disable_pci;
> -- 
> 2.47.3
> 

-- 
Lee Jones [李琼斯]

