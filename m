Return-Path: <linux-kernel+bounces-694805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96926AE10E4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 04:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C2D64A10DA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 02:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E083313F434;
	Fri, 20 Jun 2025 02:06:56 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113B78828
	for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 02:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750385216; cv=none; b=cyI3eofhUGeDkYjYYNSBDqvN+pzFFOcYbJjXFnRnBQJx+lImvJ2w3t81zKfdL/DJ29KKkPjLquh2fmZl4wFhvUoHxXYp57+mp31dsZ59Q5l/Dn5QJs3v3IiEMtJlEgtVASbjWTbtNf/5WgvdjMOWY/q359LEi5VqqfWySuDnOG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750385216; c=relaxed/simple;
	bh=LuxIuT+q0GEsOU9J0ZNtdgdMWnh9a9VDQ58kfiEpnLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5Dfy/w0yXo68lbBBvQxs4rgCGhdZTiuZpKFuXxKe/EpzR+ZTanuGhYhZQUqQUABG3d3D/lsJhneEssRnus06Uj/jbPVX8dI0iGPeOBDr1H3AeBatxhtLO4zGNteXSaW1ciess7Jy3EhEeAsApNWC9bq9fTtXBmurIZuvgENOgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.149])
	by gateway (Coremail) with SMTP id _____8Axz3M6wlRoYyMaAQ--.59203S3;
	Fri, 20 Jun 2025 10:06:50 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.149])
	by front1 (Coremail) with SMTP id qMiowMCx7MQuwlRodNIhAQ--.36930S4;
	Fri, 20 Jun 2025 10:06:48 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Lee Jones <lee@kernel.org>,
	Corey Minyard <minyard@acm.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	jeffbai@aosc.io,
	kexybiscuit@aosc.io,
	wangyao@lemote.com,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Chong Qiao <qiaochong@loongson.cn>
Subject: [PATCH v5 2/3] mfd: ls2kbmc: Add Loongson-2K BMC reset function support
Date: Fri, 20 Jun 2025 10:06:28 +0800
Message-ID: <174677c13e41140e19a62dd01b9502aaa7fae669.1750301674.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1750301674.git.zhoubinbin@loongson.cn>
References: <cover.1750301674.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCx7MQuwlRodNIhAQ--.36930S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9fXoW3tF4DXrW3KFWDJF47tw17twc_yoW8GFWrWo
	WfuFyfZw18Jr17AayftF17Ka4UW3y0qas3Aws7CryqgFyxAasrJFy5GanrZw1fZr4fK345
	Zr95W3WxAFW3tr17l-sFpf9Il3svdjkaLaAFLSUrUUUUnb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYA7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUZVWUtwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU14v3UUUUUU==

Since the display is a sub-function of the Loongson-2K BMC, when the
BMC reset, the entire BMC PCIe is disconnected, including the display
which is interrupted.

Quick overview of the entire LS2K BMC reset process:

There are two types of reset methods: soft reset (BMC-initiated reboot
of IPMI reset command) and BMC watchdog reset (watchdog timeout).

First, regardless of the method, an interrupt is generated (PCIe interrupt
for soft reset/GPIO interrupt for watchdog reset);

Second, during the interrupt process, the system enters bmc_reset_work,
clears the bus/IO/mem resources of the LS7A PCI-E bridge, waits for the BMC
reset to begin, then restores the parent device's PCI configuration space,
waits for the BMC reset to complete, and finally restores the BMC PCI
configuration space.

Display restoration occurs last.

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Co-developed-by: Chong Qiao <qiaochong@loongson.cn>
Signed-off-by: Chong Qiao <qiaochong@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mfd/ls2k-bmc-core.c | 329 ++++++++++++++++++++++++++++++++++++
 1 file changed, 329 insertions(+)

diff --git a/drivers/mfd/ls2k-bmc-core.c b/drivers/mfd/ls2k-bmc-core.c
index 9ee1edf286e7..f86c062c851e 100644
--- a/drivers/mfd/ls2k-bmc-core.c
+++ b/drivers/mfd/ls2k-bmc-core.c
@@ -10,8 +10,12 @@
  */
 
 #include <linux/aperture.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/iopoll.h>
+#include <linux/kbd_kern.h>
 #include <linux/kernel.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
@@ -19,6 +23,8 @@
 #include <linux/pci_ids.h>
 #include <linux/platform_data/simplefb.h>
 #include <linux/platform_device.h>
+#include <linux/stop_machine.h>
+#include <linux/vt_kern.h>
 
 /* LS2K BMC resources */
 #define LS2K_DISPLAY_RES_START		(SZ_16M + SZ_2M)
@@ -29,6 +35,48 @@
 #define LS2K_IPMI3_RES_START		(LS2K_IPMI2_RES_START + LS2K_IPMI_RES_SIZE)
 #define LS2K_IPMI4_RES_START		(LS2K_IPMI3_RES_START + LS2K_IPMI_RES_SIZE)
 
+#define LS7A_PCI_CFG_SIZE		0x100
+
+/* LS7A bridge registers */
+#define LS7A_PCIE_PORT_CTL0		0x0
+#define LS7A_PCIE_PORT_STS1		0xC
+#define LS7A_GEN2_CTL			0x80C
+#define LS7A_SYMBOL_TIMER		0x71C
+
+/* Bits of LS7A_PCIE_PORT_CTL0 */
+#define LS2K_BMC_PCIE_LTSSM_ENABLE	BIT(3)
+
+/* Bits of LS7A_PCIE_PORT_STS1 */
+#define LS2K_BMC_PCIE_LTSSM_STS		GENMASK(5, 0)
+#define LS2K_BMC_PCIE_CONNECTED		0x11
+
+#define LS2K_BMC_PCIE_DELAY_US		1000
+#define LS2K_BMC_PCIE_TIMEOUT_US	1000000
+
+/* Bits of LS7A_GEN2_CTL */
+#define LS7A_GEN2_SPEED_CHANG		BIT(17)
+#define LS7A_CONF_PHY_TX		BIT(18)
+
+/* Bits of LS7A_SYMBOL_TIMER */
+#define LS7A_MASK_LEN_MATCH		BIT(26)
+
+/* Interval between interruptions */
+#define LS2K_BMC_INT_INTERVAL		(60 * HZ)
+
+/* Maximum time to wait for U-Boot and DDR to be ready with ms. */
+#define LS2K_BMC_RESET_WAIT_TIME	10000
+
+/* It's an experience value */
+#define LS7A_BAR0_CHECK_MAX_TIMES	2000
+
+#define LS2K_BMC_RESET_GPIO		14
+#define LOONGSON_GPIO_REG_BASE		0x1FE00500
+#define LOONGSON_GPIO_REG_SIZE		0x18
+#define LOONGSON_GPIO_OEN		0x0
+#define LOONGSON_GPIO_FUNC		0x4
+#define LOONGSON_GPIO_INTPOL		0x10
+#define LOONGSON_GPIO_INTEN		0x14
+
 static struct resource ls2k_display_resources[] = {
 	DEFINE_RES_MEM_NAMED(LS2K_DISPLAY_RES_START, SZ_4M, "simpledrm-res"),
 };
@@ -62,6 +110,274 @@ static struct mfd_cell ls2k_bmc_cells[] = {
 	MFD_CELL_RES("ls2k-ipmi-si", ls2k_ipmi4_resources),
 };
 
+/* Index of the BMC PCI configuration space to be restored at BMC reset. */
+struct ls2k_bmc_pci_data {
+	u32 pci_command;
+	u32 base_address0;
+	u32 interrupt_line;
+};
+
+/* Index of the parent PCI configuration space to be restored at BMC reset. */
+struct ls2k_bmc_bridge_pci_data {
+	u32 pci_command;
+	u32 base_address[6];
+	u32 rom_addreess;
+	u32 interrupt_line;
+	u32 msi_hi;
+	u32 msi_lo;
+	u32 devctl;
+	u32 linkcap;
+	u32 linkctl_sts;
+	u32 symbol_timer;
+	u32 gen2_ctrl;
+};
+
+struct ls2k_bmc_pdata {
+	struct device *dev;
+	struct work_struct bmc_reset_work;
+	struct ls2k_bmc_pci_data bmc_pci_data;
+	struct ls2k_bmc_bridge_pci_data bridge_pci_data;
+};
+
+static bool ls2k_bmc_bar0_addr_is_set(struct pci_dev *ppdev)
+{
+	u32 addr;
+
+	pci_read_config_dword(ppdev, PCI_BASE_ADDRESS_0, &addr);
+
+	return addr & PCI_BASE_ADDRESS_MEM_MASK ? true : false;
+}
+
+static bool ls2k_bmc_pcie_is_connected(struct pci_dev *parent, struct ls2k_bmc_pdata *priv)
+{
+	void __iomem *base;
+	int sts, ret;
+
+	base = pci_iomap(parent, 0, LS7A_PCI_CFG_SIZE);
+	if (!base)
+		return false;
+
+	writel(readl(base + LS7A_PCIE_PORT_CTL0) | LS2K_BMC_PCIE_LTSSM_ENABLE,
+	       base + LS7A_PCIE_PORT_CTL0);
+
+	ret = readl_poll_timeout_atomic(base + LS7A_PCIE_PORT_STS1, sts,
+					(sts & LS2K_BMC_PCIE_LTSSM_STS) == LS2K_BMC_PCIE_CONNECTED,
+					LS2K_BMC_PCIE_DELAY_US, LS2K_BMC_PCIE_TIMEOUT_US);
+	if (ret) {
+		pci_iounmap(parent, base);
+		dev_err(priv->dev, "PCIE train failed status=0x%x\n", sts);
+		return false;
+	}
+
+	pci_iounmap(parent, base);
+	return true;
+}
+
+static void ls2k_bmc_restore_bridge_pci_data(struct pci_dev *parent, struct ls2k_bmc_pdata *priv)
+{
+	int base, i = 0;
+
+	pci_write_config_dword(parent, PCI_COMMAND, priv->bridge_pci_data.pci_command);
+
+	for (base = PCI_BASE_ADDRESS_0; base <= PCI_BASE_ADDRESS_5; base += 4, i++)
+		pci_write_config_dword(parent, base, priv->bridge_pci_data.base_address[i]);
+
+	pci_write_config_dword(parent, PCI_ROM_ADDRESS, priv->bridge_pci_data.rom_addreess);
+	pci_write_config_dword(parent, PCI_INTERRUPT_LINE, priv->bridge_pci_data.interrupt_line);
+
+	pci_write_config_dword(parent, parent->msi_cap + PCI_MSI_ADDRESS_LO,
+			       priv->bridge_pci_data.msi_lo);
+	pci_write_config_dword(parent, parent->msi_cap + PCI_MSI_ADDRESS_HI,
+			       priv->bridge_pci_data.msi_hi);
+	pci_write_config_dword(parent, parent->pcie_cap + PCI_EXP_DEVCTL,
+			       priv->bridge_pci_data.devctl);
+	pci_write_config_dword(parent, parent->pcie_cap + PCI_EXP_LNKCAP,
+			       priv->bridge_pci_data.linkcap);
+	pci_write_config_dword(parent, parent->pcie_cap + PCI_EXP_LNKCTL,
+			       priv->bridge_pci_data.linkctl_sts);
+
+	pci_write_config_dword(parent, LS7A_GEN2_CTL, priv->bridge_pci_data.gen2_ctrl);
+	pci_write_config_dword(parent, LS7A_SYMBOL_TIMER, priv->bridge_pci_data.symbol_timer);
+}
+
+static int ls2k_bmc_recover_pci_data(void *data)
+{
+	struct ls2k_bmc_pdata *priv = data;
+	struct pci_dev *pdev = to_pci_dev(priv->dev);
+	struct pci_dev *parent = pdev->bus->self;
+	u32 i;
+
+	/*
+	 * Clear the bus, io and mem resources of the PCI-E bridge to zero, so that
+	 * the processor can not access the LS2K PCI-E port, to avoid crashing due to
+	 * the lack of return signal from accessing the LS2K PCI-E port.
+	 */
+	pci_write_config_dword(parent, PCI_BASE_ADDRESS_2, 0);
+	pci_write_config_dword(parent, PCI_BASE_ADDRESS_3, 0);
+	pci_write_config_dword(parent, PCI_BASE_ADDRESS_4, 0);
+
+	/*
+	 * When the LS2K BMC is reset, the LS7A PCI-E port is also reset, and its PCI
+	 * BAR0 register is cleared. Due to the time gap between the GPIO interrupt
+	 * generation and the LS2K BMC reset, the LS7A PCI BAR0 register is read to
+	 * determine whether the reset has begun.
+	 */
+	for (i = LS7A_BAR0_CHECK_MAX_TIMES; i > 0 ; i--) {
+		if (!ls2k_bmc_bar0_addr_is_set(parent))
+			break;
+		mdelay(1);
+	};
+
+	if (i == 0)
+		return false;
+
+	ls2k_bmc_restore_bridge_pci_data(parent, priv);
+
+	/* Check if PCI-E is connected */
+	if (!ls2k_bmc_pcie_is_connected(parent, priv))
+		return false;
+
+	/* Waiting for U-Boot and DDR ready */
+	mdelay(LS2K_BMC_RESET_WAIT_TIME);
+	if (!ls2k_bmc_bar0_addr_is_set(parent))
+		return false;
+
+	/* Restore LS2K BMC PCI-E config data */
+	pci_write_config_dword(pdev, PCI_COMMAND, priv->bmc_pci_data.pci_command);
+	pci_write_config_dword(pdev, PCI_BASE_ADDRESS_0, priv->bmc_pci_data.base_address0);
+	pci_write_config_dword(pdev, PCI_INTERRUPT_LINE, priv->bmc_pci_data.interrupt_line);
+
+	return 0;
+}
+
+static void ls2k_bmc_events_fn(struct work_struct *work)
+{
+	struct ls2k_bmc_pdata *priv = container_of(work, struct ls2k_bmc_pdata, bmc_reset_work);
+
+	/*
+	 * The PCI-E is lost when the BMC resets, at which point access to the PCI-E
+	 * from other CPUs is suspended to prevent a crash.
+	 */
+	stop_machine(ls2k_bmc_recover_pci_data, priv, NULL);
+
+#ifdef CONFIG_VT
+	/* Re-push the display due to previous PCI-E loss. */
+	set_console(vt_move_to_console(MAX_NR_CONSOLES - 1, 1));
+#endif
+}
+
+static irqreturn_t ls2k_bmc_interrupt(int irq, void *arg)
+{
+	struct ls2k_bmc_pdata *priv = arg;
+	static unsigned long last_jiffies;
+
+	if (system_state != SYSTEM_RUNNING)
+		return IRQ_HANDLED;
+
+	/* Skip interrupt in LS2K_BMC_INT_INTERVAL */
+	if (time_after(jiffies, last_jiffies + LS2K_BMC_INT_INTERVAL)) {
+		schedule_work(&priv->bmc_reset_work);
+		last_jiffies = jiffies;
+	}
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Saves the BMC parent device (LS7A) and its own PCI configuration space registers
+ * that need to be restored after BMC reset.
+ */
+static void ls2k_bmc_save_pci_data(struct pci_dev *pdev, struct ls2k_bmc_pdata *priv)
+{
+	struct pci_dev *parent = pdev->bus->self;
+	int base, i = 0;
+
+	pci_read_config_dword(parent, PCI_COMMAND, &priv->bridge_pci_data.pci_command);
+
+	for (base = PCI_BASE_ADDRESS_0; base <= PCI_BASE_ADDRESS_5; base += 4, i++)
+		pci_read_config_dword(parent, base, &priv->bridge_pci_data.base_address[i]);
+
+	pci_read_config_dword(parent, PCI_ROM_ADDRESS, &priv->bridge_pci_data.rom_addreess);
+	pci_read_config_dword(parent, PCI_INTERRUPT_LINE, &priv->bridge_pci_data.interrupt_line);
+
+	pci_read_config_dword(parent, parent->msi_cap + PCI_MSI_ADDRESS_LO,
+			      &priv->bridge_pci_data.msi_lo);
+	pci_read_config_dword(parent, parent->msi_cap + PCI_MSI_ADDRESS_HI,
+			      &priv->bridge_pci_data.msi_hi);
+
+	pci_read_config_dword(parent, parent->pcie_cap + PCI_EXP_DEVCTL,
+			      &priv->bridge_pci_data.devctl);
+	pci_read_config_dword(parent, parent->pcie_cap + PCI_EXP_LNKCAP,
+			      &priv->bridge_pci_data.linkcap);
+	pci_read_config_dword(parent, parent->pcie_cap + PCI_EXP_LNKCTL,
+			      &priv->bridge_pci_data.linkctl_sts);
+
+	pci_read_config_dword(parent, LS7A_GEN2_CTL, &priv->bridge_pci_data.gen2_ctrl);
+	priv->bridge_pci_data.gen2_ctrl |= FIELD_PREP(LS7A_GEN2_SPEED_CHANG, 0x1)
+					| FIELD_PREP(LS7A_CONF_PHY_TX, 0x0);
+
+	pci_read_config_dword(parent, LS7A_SYMBOL_TIMER, &priv->bridge_pci_data.symbol_timer);
+	priv->bridge_pci_data.symbol_timer |= LS7A_MASK_LEN_MATCH;
+
+	pci_read_config_dword(pdev, PCI_COMMAND, &priv->bmc_pci_data.pci_command);
+	pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &priv->bmc_pci_data.base_address0);
+	pci_read_config_dword(pdev, PCI_INTERRUPT_LINE, &priv->bmc_pci_data.interrupt_line);
+}
+
+static int ls2k_bmc_pdata_initial(struct pci_dev *pdev, struct ls2k_bmc_pdata *priv)
+{
+	int gsi = 16 + (LS2K_BMC_RESET_GPIO & 7);
+	void __iomem *gpio_base;
+	int irq, ret;
+
+	ls2k_bmc_save_pci_data(pdev, priv);
+
+	INIT_WORK(&priv->bmc_reset_work, ls2k_bmc_events_fn);
+
+	ret = devm_request_irq(&pdev->dev, pdev->irq, ls2k_bmc_interrupt,
+			       IRQF_SHARED | IRQF_TRIGGER_FALLING, "ls2kbmc pcie", priv);
+	if (ret) {
+		dev_err(priv->dev, "LS2KBMC PCI-E request_irq(%d) failed\n", pdev->irq);
+		return ret;
+	}
+
+	/*
+	 * Since Loongson-3 hardware does not support GPIO interrupt cascade,
+	 * chip->gpio_to_irq() cannot be implemented, here acpi_register_gsi() is used
+	 * to get the GPIO irq.
+	 * The GPIO interrupt is a watchdog interrupt that is triggered when the BMC resets.
+	 */
+	irq = acpi_register_gsi(NULL, gsi, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW);
+	if (irq < 0)
+		return irq;
+
+	gpio_base = ioremap(LOONGSON_GPIO_REG_BASE, LOONGSON_GPIO_REG_SIZE);
+	if (!gpio_base) {
+		ret = PTR_ERR(gpio_base);
+		goto acpi_failed;
+	}
+
+	writel(readl(gpio_base + LOONGSON_GPIO_OEN) | BIT(LS2K_BMC_RESET_GPIO),
+	       gpio_base + LOONGSON_GPIO_OEN);
+	writel(readl(gpio_base + LOONGSON_GPIO_FUNC) & ~BIT(LS2K_BMC_RESET_GPIO),
+	       gpio_base + LOONGSON_GPIO_FUNC);
+	writel(readl(gpio_base + LOONGSON_GPIO_INTPOL) & ~BIT(LS2K_BMC_RESET_GPIO),
+	       gpio_base + LOONGSON_GPIO_INTPOL);
+	writel(readl(gpio_base + LOONGSON_GPIO_INTEN) | BIT(LS2K_BMC_RESET_GPIO),
+	       gpio_base + LOONGSON_GPIO_INTEN);
+
+	ret = devm_request_irq(priv->dev, irq, ls2k_bmc_interrupt,
+			       IRQF_SHARED | IRQF_TRIGGER_FALLING, "ls2kbmc gpio", priv);
+	if (ret)
+		dev_err(priv->dev, "LS2KBMC GPIO request_irq(%d) failed\n", irq);
+
+	iounmap(gpio_base);
+
+acpi_failed:
+	acpi_unregister_gsi(gsi);
+	return ret;
+}
+
 /*
  * Currently the Loongson-2K BMC hardware does not have an I2C interface to adapt to the
  * resolution. We set the resolution by presetting "video=1280x1024-16@2M" to the BMC memory.
@@ -101,6 +417,7 @@ static int ls2k_bmc_parse_mode(struct pci_dev *pdev, struct simplefb_platform_da
 static int ls2k_bmc_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct simplefb_platform_data pd;
+	struct ls2k_bmc_pdata *priv;
 	resource_size_t base;
 	int ret;
 
@@ -108,6 +425,18 @@ static int ls2k_bmc_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (ret)
 		return ret;
 
+	priv = devm_kzalloc(&dev->dev, sizeof(*priv), GFP_KERNEL);
+	if (IS_ERR(priv)) {
+		ret = -ENOMEM;
+		goto disable_pci;
+	}
+
+	priv->dev = &dev->dev;
+
+	ret = ls2k_bmc_pdata_initial(dev, priv);
+	if (ret)
+		goto disable_pci;
+
 	ret = ls2k_bmc_parse_mode(dev, &pd);
 	if (ret)
 		goto disable_pci;
-- 
2.47.1


