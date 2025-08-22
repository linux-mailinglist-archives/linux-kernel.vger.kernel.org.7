Return-Path: <linux-kernel+bounces-780979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED77AB30BE4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B883A7A09
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 02:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3BB1A2C0B;
	Fri, 22 Aug 2025 02:36:49 +0000 (UTC)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8E719C558
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755830208; cv=none; b=q/0Ogxw3KVhFfOoCrzjBJuKtMpp76J+UPQ88umlI+MGe5edQMc1yDctnH1fbChLEDSRtBfMJgghCQkaLn9dEWBXHDDGTtl9WVSxXFKdH4zGt187XsMHxI5+Jp34embiXFqXbimRqO3LvtsVNMGN1IG05RhV3Va7Y4BFt2JrZP8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755830208; c=relaxed/simple;
	bh=UvmZLFsxUQ5788yl4B7j086wVbPkoxwwSUeLV+OEevo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dqotz6u66T7dOioMqWjNWqYoCv07XdaBkKYIT0zA3ghhIG35J+h6rkrW7Bvrawyr7s1mHbDkj7Rr0+p6ffDoDQMiGCtd8ppkhpKyWrH/JYzAryr2fTAJ6qGbo9VLeUr6XPxL8aJP+TmHFoq24H0lLwONOeL0gXo1wLMspFtqD3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz14t1755830124t8801b2ec
X-QQ-Originating-IP: Z5fUOHY0rEu87NoVUGeLFqE9t6QSV4g6i+pAfKNdUb4=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 22 Aug 2025 10:35:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4022437291746701167
EX-QQ-RecipientCnt: 26
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	gur.stavi@huawei.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	danishanwar@ti.com,
	lee@trager.us,
	gongfan1@huawei.com,
	lorenzo@kernel.org,
	geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com,
	richardcochran@gmail.com,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v7 5/5] net: rnpgbe: Add register_netdev
Date: Fri, 22 Aug 2025 10:34:53 +0800
Message-Id: <20250822023453.1910972-6-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250822023453.1910972-1-dong100@mucse.com>
References: <20250822023453.1910972-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MtRooIZ2Z9ixY7xGSZv4bzUYjqpRuVUukQcjE1JJ1W2z8Ifkb/aNreFu
	b4KE/RyoHyhYQ2ixYDTTHPIULTQLIBL45Us27o68WclD2jlXx/d5nOumYgtXJA3vieGoCDW
	E/U+nG6e8fnvTq8hl6Sb3F5TE7dUtIY6ZgPxqhTUGXJPW9hGamsqBlUlV0mIOOOyv09zMmR
	8/TVJNmFW1DLE8nwONnQe58VNQR0W0OoljLeEZEZP0CcuXiUAb4C28eQ+mfemtEqvo1symw
	kpL87dWZ+7EW/A943Tp2SCL7NrGbAFt//Z19ZVNOhTv/7tqz7EjKxqur9MDf4KoKY8y95Eb
	yC5agk+Wtr1Ic1QH5p0o/zog918Dt0lHeMAXo0jSOu3svZW88UO94tRREftOaFNXEUlUECV
	nfxebfYP2ojK6GgUMLRBV9Xrq63uZ3LnenlokoUndkovrxlH9Ubsc1VKrWOehY0Ro2KOmlx
	s2k/hLHgSE/KxApN6g2XQI6Hov/lBBJhTG56J8Z98Cq58Ll5YqTmJlZzHjdxv76GGgj0XQ/
	yjvlfiWQ/k+6JQaHaOsRGZKS56hDDmMyGZnWedEmoJx4MRG5JrsLMN6wNGXsoAX7xghB+n6
	1USUACfCwwFJQwacAure7B3aTchV04cdNjLJEPVmEnZ/fAO1NdNtvOhTgjGnnnBbComP77Q
	zPdGbYj5QK7mDqScYfYUt1OK0bsd9mnkTgmEX6AaUVZAreJWLwMcUPX0+cRJoBAEcAVxX1Y
	RTsoevlb3DnGwJIiTf2Umqo7Zs7x/KQOKtmsOOmzCnOUChxvbQiFdHAhH0+V5YrVfZhQLZH
	WanGuTirRVZbKs2sT5YQhkMTwAa4tSpQVX4q/9eP2fH4eyX7LH4rq2XLLXHlMzFLjchOH4f
	aet1n1LXZFW1SczvXDfj6j5CVbp+cDXPNmS9QALJhq10eFLYIGFtfczW5h0LaUz17bYtRDj
	icYEvNSQh7QvoLY5gcmNwhHB51xHXu9zXgYud8Rf4+N+nsMGqvX30jbfbGIzcRaLulMe/JV
	j3h2scU1C9J4IKKFyhJPLyG3KoUcJcT+JJRHpwYLNloyfRJbe99SVNlcmdzrQWZtcNTFoYE
	Iwy3wEumqK4
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Initialize get mac from hw, register the netdev.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 23 ++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 82 +++++++++++++++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  2 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 75 +++++++++++++++++
 4 files changed, 182 insertions(+)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index a32419a34d75..44b581b8d45c 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -6,6 +6,7 @@
 
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <linux/netdevice.h>
 
 extern const struct rnpgbe_info rnpgbe_n500_info;
 extern const struct rnpgbe_info rnpgbe_n210_info;
@@ -24,6 +25,10 @@ enum rnpgbe_hw_type {
 	rnpgbe_hw_unknown
 };
 
+struct mucse_dma_info {
+	void __iomem *dma_base_addr;
+};
+
 struct mucse_mbx_stats {
 	u32 msgs_tx;
 	u32 msgs_rx;
@@ -48,12 +53,27 @@ struct mucse_mbx_info {
 	u32 fw2pf_mbox_vec;
 };
 
+struct mucse_hw;
+
+struct mucse_hw_operations {
+	int (*reset_hw)(struct mucse_hw *hw);
+	void (*driver_status)(struct mucse_hw *hw, bool enable, int mode);
+};
+
+enum {
+	mucse_driver_insmod,
+};
+
 struct mucse_hw {
 	void __iomem *hw_addr;
 	struct pci_dev *pdev;
 	enum rnpgbe_hw_type hw_type;
 	u8 pfvfnum;
+	const struct mucse_hw_operations *ops;
+	struct mucse_dma_info dma;
 	struct mucse_mbx_info mbx;
+	int port;
+	u8 perm_addr[ETH_ALEN];
 };
 
 struct mucse {
@@ -73,4 +93,7 @@ struct rnpgbe_info {
 #define PCI_DEVICE_ID_N500_DUAL_PORT 0x8318
 #define PCI_DEVICE_ID_N210 0x8208
 #define PCI_DEVICE_ID_N210L 0x820a
+
+#define rnpgbe_dma_wr32(dma, reg, val) \
+	writel((val), (dma)->dma_base_addr + (reg))
 #endif /* _RNPGBE_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index f38daef752a3..40c29411fe09 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -1,11 +1,87 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2020 - 2025 Mucse Corporation. */
 
+#include <linux/pci.h>
 #include <linux/string.h>
+#include <linux/etherdevice.h>
 
 #include "rnpgbe.h"
 #include "rnpgbe_hw.h"
 #include "rnpgbe_mbx.h"
+#include "rnpgbe_mbx_fw.h"
+
+/**
+ * rnpgbe_get_permanent_mac - Get permanent mac
+ * @hw: hw information structure
+ * @mac_addr: pointer to store mac
+ *
+ * rnpgbe_get_permanent_mac tries to get mac from hw.
+ * It use eth_random_addr if failed.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int rnpgbe_get_permanent_mac(struct mucse_hw *hw,
+				    u8 *mac_addr)
+{
+	struct device *dev = &hw->pdev->dev;
+	int err;
+
+	err = mucse_fw_get_macaddr(hw, hw->pfvfnum, mac_addr, hw->port);
+	if (err) {
+		dev_err(dev, "Failed to get MAC from FW %d\n", err);
+		return err;
+	}
+
+	if (!is_valid_ether_addr(mac_addr)) {
+		dev_err(dev, "Failed to get valid MAC from FW\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * rnpgbe_reset_hw_ops - Do a hardware reset
+ * @hw: hw information structure
+ *
+ * rnpgbe_reset_hw_ops calls fw to do a hardware
+ * reset, and cleans some regs to default.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int rnpgbe_reset_hw_ops(struct mucse_hw *hw)
+{
+	struct mucse_dma_info *dma = &hw->dma;
+	int err;
+
+	rnpgbe_dma_wr32(dma, RNPGBE_DMA_AXI_EN, 0);
+	err = mucse_mbx_fw_reset_phy(hw);
+	if (err)
+		return err;
+	return rnpgbe_get_permanent_mac(hw, hw->perm_addr);
+}
+
+/**
+ * rnpgbe_driver_status_hw_ops - Echo driver status to hw
+ * @hw: hw information structure
+ * @enable: true or false status
+ * @mode: status mode
+ **/
+static void rnpgbe_driver_status_hw_ops(struct mucse_hw *hw,
+					bool enable,
+					int mode)
+{
+	switch (mode) {
+	case mucse_driver_insmod:
+		mucse_mbx_ifinsmod(hw, enable);
+		break;
+	}
+}
+
+static const struct mucse_hw_operations rnpgbe_hw_ops = {
+	.reset_hw = &rnpgbe_reset_hw_ops,
+	.driver_status = &rnpgbe_driver_status_hw_ops,
+};
 
 /**
  * rnpgbe_init_common - Setup common attribute
@@ -13,10 +89,16 @@
  **/
 static void rnpgbe_init_common(struct mucse_hw *hw)
 {
+	struct mucse_dma_info *dma = &hw->dma;
 	struct mucse_mbx_info *mbx = &hw->mbx;
 
+	dma->dma_base_addr = hw->hw_addr;
+
 	mbx->pf2fw_mbox_ctrl = GBE_PF2FW_MBX_MASK_OFFSET;
 	mbx->fw_pf_mbox_mask = GBE_FWPF_MBX_MASK;
+
+	hw->ops = &rnpgbe_hw_ops;
+	hw->port = 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index 746dca78f1df..0ab2c328c9e9 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -11,6 +11,8 @@
 #define GBE_FWPF_MBX_MASK 0x5700
 #define N210_FW2PF_MBX_VEC_OFFSET 0x29400
 #define N210_FWPF_SHM_BASE_OFFSET 0x2d900
+/**************** DMA Registers ****************************/
+#define RNPGBE_DMA_AXI_EN 0x0010
 /**************** CHIP Resource ****************************/
 #define RNPGBE_MAX_QUEUES 8
 #endif /* _RNPGBE_HW_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 6992a3c0e58a..947d0ca2101d 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -9,6 +9,8 @@
 
 #include "rnpgbe.h"
 #include "rnpgbe_hw.h"
+#include "rnpgbe_mbx.h"
+#include "rnpgbe_mbx_fw.h"
 
 static const char rnpgbe_driver_name[] = "rnpgbe";
 static const struct rnpgbe_info *rnpgbe_info_tbl[] = {
@@ -35,6 +37,55 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
 	{0, },
 };
 
+/**
+ * rnpgbe_open - Called when a network interface is made active
+ * @netdev: network interface device structure
+ *
+ * The open entry point is called when a network interface is made
+ * active by the system (IFF_UP).
+ *
+ * @return: 0 on success, negative value on failure
+ **/
+static int rnpgbe_open(struct net_device *netdev)
+{
+	return 0;
+}
+
+/**
+ * rnpgbe_close - Disables a network interface
+ * @netdev: network interface device structure
+ *
+ * The close entry point is called when an interface is de-activated
+ * by the OS.
+ *
+ * @return: 0, this is not allowed to fail
+ **/
+static int rnpgbe_close(struct net_device *netdev)
+{
+	return 0;
+}
+
+/**
+ * rnpgbe_xmit_frame - Send a skb to driver
+ * @skb: skb structure to be sent
+ * @netdev: network interface device structure
+ *
+ * @return: NETDEV_TX_OK or NETDEV_TX_BUSY
+ **/
+static netdev_tx_t rnpgbe_xmit_frame(struct sk_buff *skb,
+				     struct net_device *netdev)
+{
+	dev_kfree_skb_any(skb);
+	netdev->stats.tx_dropped++;
+	return NETDEV_TX_OK;
+}
+
+static const struct net_device_ops rnpgbe_netdev_ops = {
+	.ndo_open = rnpgbe_open,
+	.ndo_stop = rnpgbe_close,
+	.ndo_start_xmit = rnpgbe_xmit_frame,
+};
+
 /**
  * rnpgbe_add_adapter - Add netdev for this pci_dev
  * @pdev: PCI device information structure
@@ -78,6 +129,27 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 
 	hw->hw_addr = hw_addr;
 	info->init(hw);
+	mucse_init_mbx_params_pf(hw);
+	/* echo fw driver insmod to control hw */
+	hw->ops->driver_status(hw, true, mucse_driver_insmod);
+	err = mucse_mbx_get_capability(hw);
+	if (err) {
+		dev_err(&pdev->dev,
+			"mucse_mbx_get_capability failed! %d\n",
+			err);
+		goto err_free_net;
+	}
+	netdev->netdev_ops = &rnpgbe_netdev_ops;
+	netdev->watchdog_timeo = 5 * HZ;
+	err = hw->ops->reset_hw(hw);
+	if (err) {
+		dev_err(&pdev->dev, "Hw reset failed %d\n", err);
+		goto err_free_net;
+	}
+	eth_hw_addr_set(netdev, hw->perm_addr);
+	err = register_netdev(netdev);
+	if (err)
+		goto err_free_net;
 	return 0;
 
 err_free_net:
@@ -141,12 +213,15 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 static void rnpgbe_rm_adapter(struct pci_dev *pdev)
 {
 	struct mucse *mucse = pci_get_drvdata(pdev);
+	struct mucse_hw *hw = &mucse->hw;
 	struct net_device *netdev;
 
 	if (!mucse)
 		return;
 	netdev = mucse->netdev;
+	unregister_netdev(netdev);
 	mucse->netdev = NULL;
+	hw->ops->driver_status(hw, false, mucse_driver_insmod);
 	free_netdev(netdev);
 }
 
-- 
2.25.1


