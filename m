Return-Path: <linux-kernel+bounces-787625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE40B378CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 05:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A831688304
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7069F309DC1;
	Wed, 27 Aug 2025 03:46:53 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA1126AA93
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756266412; cv=none; b=jD2iljq0L5gc3kdmWOzZwUABrxDy+yt/fGR3eirvB9qOhMllQokPlWjrtw8z665YyZ5vW95XoSWdXRwcIQN9vRyqo/6/4KVvX4aTL57lK6lxEkLlUP6z5EXVQ1udL/B3CyPBVtyzrteaQvdorp5m5qVTFoK0uc/bszWM//PHA4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756266412; c=relaxed/simple;
	bh=1EGFKOdRQiHZtbEzT9vpqFGvckNjsE2yKqM8q5qCTkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FMwZga5JH35kbQH7GJLky6CtdXOJFliY8JsfQoj/XpxyNui6XOOBRRzTrv9qU6X1fnDi1Tsky6uEZZh9Kl0CqkdfFxaQzLfOg2C1jVrfhSqP258qcfHXGhyr6jYhY+jL964MU9sBwS0VZGIaackdBErMapE5saMfoa0/oe2ib6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz7t1756266328ta198d932
X-QQ-Originating-IP: raY8x8OeB1Q3NzxLii4XB6Tq/XI1juZJQBRSROVdV6s=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 27 Aug 2025 11:45:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2742483740105347810
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
Subject: [PATCH net-next v8 2/5] net: rnpgbe: Add n500/n210 chip support
Date: Wed, 27 Aug 2025 11:45:06 +0800
Message-Id: <20250827034509.501980-3-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250827034509.501980-1-dong100@mucse.com>
References: <20250827034509.501980-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N0wq4UDXOmCwUXRHPObJJKcs01O+57/MFjD3SJjvy5p6+n+0F9UxWUtn
	4ZXkV4fY8njwNhXc/Toq57RsOmUs1b8dqgxmssVGiMEqF4qEnoMvApRh1SdoxDs3jcATxvi
	3g9B7GEIXPPW0KkjateRn80utvWXy9wLRCn/dkFbrH4yYQDj8JTuscQqG4b+Ezfh9f39Sy2
	3gMj5KPUEy0KmJbq3hSTaBOWR4zPUv1e0esRizsxOQCtaJQctgCDRdL5PjcxsWWEeIf5gZ9
	CMXVjk3uh32SwmR24UVZKgmX89UC1chqQ6urx5DCnASrUHGLo/FGbVjkrt2HRZlCTasu2IW
	pnTSD0Xo6+YXcSoWSZlDR5qLheiMNKw7SKZF51OPJ4mUbYzWMN2XKAla9gonmulKUxHMrNX
	lw09J2cPPgsvHsPOWST7oimCj5eAYgoEi7SYR1DJMbxa37T21edK8VjlzkQTSBFyOWsDhGc
	z1JP+57jbIOex6t6OFXLQhFSahC9dTynOvOrUaxzQ0xmBt9O0L/UJKwmST/VhQx9SsXgKDf
	372YAyPqVplcJeI8aJGsCT+/0nFBfIktlc7KK5+nWmcXkPvQ/vX9ARXtHX5lmyTxbiwo8o4
	PsASzTic/jjQNqTVc5Vy2RrPBSY8EEzyAv+Xjg9k0QPSWe+TdM9XF0PA9hBrZxzv/nNOgfn
	5fYbK127D0N9715yvfQpIuXGca5IlqTToxww6zJR3Ti7dQpKlLOEY9nC6UwQtlH9et5QUCE
	1VDJVf/cUApfs3b8HeupoD9yO9bwm2fIJM7ejfmZv9nQ3FwN5NaurJCfUMYhbsYHry0oWTw
	dNwfnJtdSej5qih7HK/Fuoaatq1aF0fQu8a6LFiu0k5plQh5pXGH75+Vfy1yPBYxo7v3VnC
	y5OoAJ6xmdGxhfqctGBgiKy+wEBHTsnuq09g0hSPsMUgjuJEWjH5E9fNIRW1jHI4HrsDW81
	LReowSdcsqhZyBSIwl7VMr+EyE+sx9WdvP+bIiUXK4GpPHMwJULGdw/dUd/dIkRBCFd57yf
	Czxq9qrVE4Y9HB8f5prx272KPJDP8phMeYVjLmj3fjfthzFARu4E8os32OIYqywSBfGIfca
	tJ2ZHiwnqR92IfDxo2OKqbL6SBe+K0oyg==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Initialize n500/n210 chip bar resource map and
dma, eth, mbx ... info for future use.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |  3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 34 ++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 68 +++++++++++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h | 16 ++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 85 +++++++++++++++++++
 5 files changed, 205 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h

diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
index 9df536f0d04c..42c359f459d9 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
+++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
@@ -5,4 +5,5 @@
 #
 
 obj-$(CONFIG_MGBE) += rnpgbe.o
-rnpgbe-objs := rnpgbe_main.o
+rnpgbe-objs := rnpgbe_main.o\
+	       rnpgbe_chip.o
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 64b2c093bc6e..9a86e67d6395 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -4,15 +4,49 @@
 #ifndef _RNPGBE_H
 #define _RNPGBE_H
 
+#include <linux/types.h>
+
+extern const struct rnpgbe_info rnpgbe_n500_info;
+extern const struct rnpgbe_info rnpgbe_n210_info;
+extern const struct rnpgbe_info rnpgbe_n210L_info;
+
 enum rnpgbe_boards {
 	board_n500,
 	board_n210,
 	board_n210L,
 };
 
+enum rnpgbe_hw_type {
+	rnpgbe_hw_n500 = 0,
+	rnpgbe_hw_n210,
+	rnpgbe_hw_n210L,
+	rnpgbe_hw_unknown
+};
+
+struct mucse_mbx_info {
+	/* fw <--> pf mbx */
+	u32 fw_pf_shm_base;
+	u32 pf2fw_mbox_ctrl;
+	u32 fw_pf_mbox_mask;
+	u32 fw2pf_mbox_vec;
+};
+
+struct mucse_hw {
+	void __iomem *hw_addr;
+	struct pci_dev *pdev;
+	enum rnpgbe_hw_type hw_type;
+	struct mucse_mbx_info mbx;
+};
+
 struct mucse {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
+	struct mucse_hw hw;
+};
+
+struct rnpgbe_info {
+	enum rnpgbe_hw_type hw_type;
+	void (*init)(struct mucse_hw *hw);
 };
 
 /* Device IDs */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
new file mode 100644
index 000000000000..179621ea09f3
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#include "rnpgbe.h"
+#include "rnpgbe_hw.h"
+
+/**
+ * rnpgbe_init_common - Setup common attribute
+ * @hw: hw information structure
+ **/
+static void rnpgbe_init_common(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	mbx->pf2fw_mbox_ctrl = GBE_PF2FW_MBX_MASK_OFFSET;
+	mbx->fw_pf_mbox_mask = GBE_FWPF_MBX_MASK;
+}
+
+/**
+ * rnpgbe_init_n500 - Setup n500 hw info
+ * @hw: hw information structure
+ *
+ * rnpgbe_init_n500 initializes all private
+ * structure, such as dma, eth, mac and mbx base on
+ * hw->hw_addr for n500
+ **/
+static void rnpgbe_init_n500(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	rnpgbe_init_common(hw);
+
+	mbx->fw2pf_mbox_vec = N500_FW2PF_MBX_VEC_OFFSET;
+	mbx->fw_pf_shm_base = N500_FWPF_SHM_BASE_OFFSET;
+}
+
+/**
+ * rnpgbe_init_n210 - Setup n210 hw info
+ * @hw: hw information structure
+ *
+ * rnpgbe_init_n210 initializes all private
+ * structure, such as dma, eth, mac and mbx base on
+ * hw->hw_addr for n210
+ **/
+static void rnpgbe_init_n210(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	rnpgbe_init_common(hw);
+
+	mbx->fw2pf_mbox_vec = N210_FW2PF_MBX_VEC_OFFSET;
+	mbx->fw_pf_shm_base = N210_FWPF_SHM_BASE_OFFSET;
+}
+
+const struct rnpgbe_info rnpgbe_n500_info = {
+	.hw_type = rnpgbe_hw_n500,
+	.init = &rnpgbe_init_n500,
+};
+
+const struct rnpgbe_info rnpgbe_n210_info = {
+	.hw_type = rnpgbe_hw_n210,
+	.init = &rnpgbe_init_n210,
+};
+
+const struct rnpgbe_info rnpgbe_n210L_info = {
+	.hw_type = rnpgbe_hw_n210L,
+	.init = &rnpgbe_init_n210,
+};
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
new file mode 100644
index 000000000000..746dca78f1df
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#ifndef _RNPGBE_HW_H
+#define _RNPGBE_HW_H
+
+/**************** MBX Resource ****************************/
+#define N500_FW2PF_MBX_VEC_OFFSET 0x28b00
+#define N500_FWPF_SHM_BASE_OFFSET 0x2d000
+#define GBE_PF2FW_MBX_MASK_OFFSET 0x5500
+#define GBE_FWPF_MBX_MASK 0x5700
+#define N210_FW2PF_MBX_VEC_OFFSET 0x29400
+#define N210_FWPF_SHM_BASE_OFFSET 0x2d900
+/**************** CHIP Resource ****************************/
+#define RNPGBE_MAX_QUEUES 8
+#endif /* _RNPGBE_HW_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 283c5efe86a7..dacb097424c9 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -4,10 +4,18 @@
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
 
 #include "rnpgbe.h"
+#include "rnpgbe_hw.h"
 
 static const char rnpgbe_driver_name[] = "rnpgbe";
+static const struct rnpgbe_info *rnpgbe_info_tbl[] = {
+	[board_n500] = &rnpgbe_n500_info,
+	[board_n210] = &rnpgbe_n210_info,
+	[board_n210L] = &rnpgbe_n210L_info,
+};
 
 /* rnpgbe_pci_tbl - PCI Device ID Table
  *
@@ -27,6 +35,56 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
 	{0, },
 };
 
+/**
+ * rnpgbe_add_adapter - Add netdev for this pci_dev
+ * @pdev: PCI device information structure
+ * @info: chip info structure
+ *
+ * rnpgbe_add_adapter initializes a netdev for this pci_dev
+ * structure. Initializes Bar map, private structure, and a
+ * hardware reset occur.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int rnpgbe_add_adapter(struct pci_dev *pdev,
+			      const struct rnpgbe_info *info)
+{
+	struct net_device *netdev;
+	void __iomem *hw_addr;
+	struct mucse *mucse;
+	struct mucse_hw *hw;
+	int err;
+
+	netdev = alloc_etherdev_mq(sizeof(struct mucse), RNPGBE_MAX_QUEUES);
+	if (!netdev)
+		return -ENOMEM;
+
+	SET_NETDEV_DEV(netdev, &pdev->dev);
+	mucse = netdev_priv(netdev);
+	mucse->netdev = netdev;
+	mucse->pdev = pdev;
+	pci_set_drvdata(pdev, mucse);
+
+	hw = &mucse->hw;
+	hw->hw_type = info->hw_type;
+	hw->pdev = pdev;
+	hw_addr = devm_ioremap(&pdev->dev,
+			       pci_resource_start(pdev, 2),
+			       pci_resource_len(pdev, 2));
+	if (!hw_addr) {
+		err = -EIO;
+		goto err_free_net;
+	}
+
+	hw->hw_addr = hw_addr;
+	info->init(hw);
+	return 0;
+
+err_free_net:
+	free_netdev(netdev);
+	return err;
+}
+
 /**
  * rnpgbe_probe - Device initialization routine
  * @pdev: PCI device information struct
@@ -39,6 +97,7 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
  **/
 static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
+	const struct rnpgbe_info *info = rnpgbe_info_tbl[id->driver_data];
 	int err;
 
 	err = pci_enable_device_mem(pdev);
@@ -65,6 +124,9 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		dev_err(&pdev->dev, "pci_save_state failed %d\n", err);
 		goto err_free_regions;
 	}
+	err = rnpgbe_add_adapter(pdev, info);
+	if (err)
+		goto err_free_regions;
 
 	return 0;
 err_free_regions:
@@ -74,6 +136,24 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return err;
 }
 
+/**
+ * rnpgbe_rm_adapter - Remove netdev for this mucse structure
+ * @pdev: PCI device information struct
+ *
+ * rnpgbe_rm_adapter remove a netdev for this mucse structure
+ **/
+static void rnpgbe_rm_adapter(struct pci_dev *pdev)
+{
+	struct mucse *mucse = pci_get_drvdata(pdev);
+	struct net_device *netdev;
+
+	if (!mucse)
+		return;
+	netdev = mucse->netdev;
+	mucse->netdev = NULL;
+	free_netdev(netdev);
+}
+
 /**
  * rnpgbe_remove - Device removal routine
  * @pdev: PCI device information struct
@@ -85,6 +165,7 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
  **/
 static void rnpgbe_remove(struct pci_dev *pdev)
 {
+	rnpgbe_rm_adapter(pdev);
 	pci_release_mem_regions(pdev);
 	pci_disable_device(pdev);
 }
@@ -95,6 +176,10 @@ static void rnpgbe_remove(struct pci_dev *pdev)
  **/
 static void rnpgbe_dev_shutdown(struct pci_dev *pdev)
 {
+	struct mucse *mucse = pci_get_drvdata(pdev);
+	struct net_device *netdev = mucse->netdev;
+
+	netif_device_detach(netdev);
 	pci_disable_device(pdev);
 }
 
-- 
2.25.1


