Return-Path: <linux-kernel+bounces-814072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A79E7B54EF6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AEB17AD54D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0188C30DEDA;
	Fri, 12 Sep 2025 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHc8scHI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEEB30DEA5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682736; cv=none; b=ILuiEhFL5IrvvuJrQAJGbpUjL7sK6kk8swy1SE758TsQzhE8GZhV+PQZ9eBXASlX8OksDw3MTTJNNhG/Fa9UQUTAsEt714C4WxZgM2BT31tecC0Pi4xS9QAKGRKD5HUz4y0Hx58lMKv5tOjT+8MfO08ib1J4ffGMhhcKAtzHjCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682736; c=relaxed/simple;
	bh=VfDkX6jFWhGms/gHH3TyVYc/59lNVQnDLRjWQOcT/rI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5pubdBPA0QwVY08r21WQT2LJwe4VEye/1iMg4utOM0OE76y1rlx2PVVAveFbjT1rC81aSRn4o4lGyz12jicQ653364XhHu8txFOMzjPU0X/P34MZHXXZSljiyMnlQCnXWde3yFRjdOlAcYzM8axk0xP66zmIcz2jsmn7kVWhgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHc8scHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56212C4CEF4;
	Fri, 12 Sep 2025 13:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757682735;
	bh=VfDkX6jFWhGms/gHH3TyVYc/59lNVQnDLRjWQOcT/rI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aHc8scHIluXDPVv/gAmywHqNnwSFNeyNL7eeKQuetGxhvxHsG1fVTaRKEXhc6gWzd
	 35Df4ysGGpVXwQ/DvYuL4AA7QD1Pq/wIeTgGrqvLmAHWXXF15bqpl+Lzvs8++HSx+A
	 c8OgBe5dvqOW42Hzi5GYpmY5aXHvsCY3YUm+dz8Bb9MryPzioPJbtHuKv4GnhDMMvG
	 4VM7UmWltvHPIg9BFHdiGl+4m3egqZrmkEseJphPkg7bBr8VmIzb6Mj52PgrtztbKx
	 tdEvdx5DE4iwFSHxatvhlsYokFHSNqfv4Q1246iffb/uJJHYD2k093+q8BO/dOGDTn
	 LpLPGss56dmGQ==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 1/3] slimbus: qcom: remove unused qcom controller driver
Date: Fri, 12 Sep 2025 14:12:00 +0100
Message-ID: <20250912131202.303026-2-srini@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250912131202.303026-1-srini@kernel.org>
References: <20250912131202.303026-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Qcom Slimbus controller driver is totally unused and dead code, there is
no point in keeping this driver in the kernel without users.

This patch removes the driver along with device tree bindings.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 .../bindings/slimbus/qcom,slim.yaml           |  86 --
 .../devicetree/bindings/slimbus/slimbus.yaml  |  13 +-
 drivers/slimbus/Kconfig                       |   7 -
 drivers/slimbus/Makefile                      |   3 -
 drivers/slimbus/qcom-ctrl.c                   | 735 ------------------
 5 files changed, 4 insertions(+), 840 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/slimbus/qcom,slim.yaml
 delete mode 100644 drivers/slimbus/qcom-ctrl.c

diff --git a/Documentation/devicetree/bindings/slimbus/qcom,slim.yaml b/Documentation/devicetree/bindings/slimbus/qcom,slim.yaml
deleted file mode 100644
index 883bda58ca97..000000000000
--- a/Documentation/devicetree/bindings/slimbus/qcom,slim.yaml
+++ /dev/null
@@ -1,86 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/slimbus/qcom,slim.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Qualcomm SoC SLIMbus controller
-
-maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
-  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
-
-description:
-  SLIMbus controller used when applications processor controls SLIMbus master
-  component.
-
-allOf:
-  - $ref: slimbus.yaml#
-
-properties:
-  compatible:
-    items:
-      - enum:
-          - qcom,apq8064-slim
-      - const: qcom,slim
-
-  reg:
-    items:
-      - description: Physical address of controller register blocks
-      - description: SLEW RATE register
-
-  reg-names:
-    items:
-      - const: ctrl
-      - const: slew
-
-  clocks:
-    items:
-      - description: Interface clock for this controller
-      - description: Interrupt for controller core's BAM
-
-  clock-names:
-    items:
-      - const: iface
-      - const: core
-
-  interrupts:
-    maxItems: 1
-
-required:
-  - compatible
-  - reg
-  - reg-names
-  - clocks
-  - clock-names
-  - interrupts
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/clock/qcom,gcc-msm8960.h>
-    #include <dt-bindings/clock/qcom,lcc-msm8960.h>
-    #include <dt-bindings/interrupt-controller/arm-gic.h>
-
-    soc {
-        #address-cells = <1>;
-        #size-cells = <1>;
-        ranges;
-
-        slim@28080000 {
-            compatible = "qcom,apq8064-slim", "qcom,slim";
-            reg = <0x28080000 0x2000>, <0x80207c 4>;
-            reg-names = "ctrl", "slew";
-            interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
-            clocks = <&lcc SLIMBUS_SRC>, <&lcc AUDIO_SLIMBUS_CLK>;
-            clock-names = "iface", "core";
-            #address-cells = <2>;
-            #size-cells = <0>;
-
-            audio-codec@1,0 {
-                compatible = "slim217,60";
-                reg = <1 0>;
-            };
-        };
-    };
diff --git a/Documentation/devicetree/bindings/slimbus/slimbus.yaml b/Documentation/devicetree/bindings/slimbus/slimbus.yaml
index 3b8cae9d1016..89017d9cda10 100644
--- a/Documentation/devicetree/bindings/slimbus/slimbus.yaml
+++ b/Documentation/devicetree/bindings/slimbus/slimbus.yaml
@@ -68,8 +68,6 @@ additionalProperties: true
 
 examples:
   - |
-    #include <dt-bindings/clock/qcom,gcc-msm8960.h>
-    #include <dt-bindings/clock/qcom,lcc-msm8960.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     soc {
@@ -78,17 +76,14 @@ examples:
         ranges;
 
         slim@28080000 {
-            compatible = "qcom,apq8064-slim", "qcom,slim";
-            reg = <0x28080000 0x2000>, <0x80207c 4>;
-            reg-names = "ctrl", "slew";
-            interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
-            clocks = <&lcc SLIMBUS_SRC>, <&lcc AUDIO_SLIMBUS_CLK>;
-            clock-names = "iface", "core";
+            compatible = "qcom,slim-ngd-v1.5.0";
+            reg = <0x091c0000 0x2c000>;
+            interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
             #address-cells = <2>;
             #size-cells = <0>;
 
             audio-codec@1,0 {
-                compatible = "slim217,60";
+                compatible = "slim217,1a0";
                 reg = <1 0>;
             };
         };
diff --git a/drivers/slimbus/Kconfig b/drivers/slimbus/Kconfig
index a0fdf9d792cb..60b0dcbc0ebb 100644
--- a/drivers/slimbus/Kconfig
+++ b/drivers/slimbus/Kconfig
@@ -13,13 +13,6 @@ menuconfig SLIMBUS
 if SLIMBUS
 
 # SLIMbus controllers
-config SLIM_QCOM_CTRL
-	tristate "Qualcomm SLIMbus Manager Component"
-	depends on HAS_IOMEM
-	help
-	  Select driver if Qualcomm's SLIMbus Manager Component is
-	  programmed using Linux kernel.
-
 config SLIM_QCOM_NGD_CTRL
 	tristate "Qualcomm SLIMbus Satellite Non-Generic Device Component"
 	depends on HAS_IOMEM && DMA_ENGINE && NET
diff --git a/drivers/slimbus/Makefile b/drivers/slimbus/Makefile
index d9aa011b6804..3cfb41c3b592 100644
--- a/drivers/slimbus/Makefile
+++ b/drivers/slimbus/Makefile
@@ -6,8 +6,5 @@ obj-$(CONFIG_SLIMBUS)			+= slimbus.o
 slimbus-y				:= core.o messaging.o sched.o stream.o
 
 #Controllers
-obj-$(CONFIG_SLIM_QCOM_CTRL)		+= slim-qcom-ctrl.o
-slim-qcom-ctrl-y			:= qcom-ctrl.o
-
 obj-$(CONFIG_SLIM_QCOM_NGD_CTRL)	+= slim-qcom-ngd-ctrl.o
 slim-qcom-ngd-ctrl-y			:= qcom-ngd-ctrl.o
diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
deleted file mode 100644
index ab344f7472f2..000000000000
--- a/drivers/slimbus/qcom-ctrl.c
+++ /dev/null
@@ -1,735 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2011-2017, The Linux Foundation
- */
-
-#include <linux/irq.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/io.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/delay.h>
-#include <linux/clk.h>
-#include <linux/of.h>
-#include <linux/pm_runtime.h>
-#include "slimbus.h"
-
-/* Manager registers */
-#define	MGR_CFG		0x200
-#define	MGR_STATUS	0x204
-#define	MGR_INT_EN	0x210
-#define	MGR_INT_STAT	0x214
-#define	MGR_INT_CLR	0x218
-#define	MGR_TX_MSG	0x230
-#define	MGR_RX_MSG	0x270
-#define	MGR_IE_STAT	0x2F0
-#define	MGR_VE_STAT	0x300
-#define	MGR_CFG_ENABLE	1
-
-/* Framer registers */
-#define	FRM_CFG		0x400
-#define	FRM_STAT	0x404
-#define	FRM_INT_EN	0x410
-#define	FRM_INT_STAT	0x414
-#define	FRM_INT_CLR	0x418
-#define	FRM_WAKEUP	0x41C
-#define	FRM_CLKCTL_DONE	0x420
-#define	FRM_IE_STAT	0x430
-#define	FRM_VE_STAT	0x440
-
-/* Interface registers */
-#define	INTF_CFG	0x600
-#define	INTF_STAT	0x604
-#define	INTF_INT_EN	0x610
-#define	INTF_INT_STAT	0x614
-#define	INTF_INT_CLR	0x618
-#define	INTF_IE_STAT	0x630
-#define	INTF_VE_STAT	0x640
-
-/* Interrupt status bits */
-#define	MGR_INT_TX_NACKED_2	BIT(25)
-#define	MGR_INT_MSG_BUF_CONTE	BIT(26)
-#define	MGR_INT_RX_MSG_RCVD	BIT(30)
-#define	MGR_INT_TX_MSG_SENT	BIT(31)
-
-/* Framer config register settings */
-#define	FRM_ACTIVE	1
-#define	CLK_GEAR	7
-#define	ROOT_FREQ	11
-#define	REF_CLK_GEAR	15
-#define	INTR_WAKE	19
-
-#define SLIM_MSG_ASM_FIRST_WORD(l, mt, mc, dt, ad) \
-		((l) | ((mt) << 5) | ((mc) << 8) | ((dt) << 15) | ((ad) << 16))
-
-#define SLIM_ROOT_FREQ 24576000
-#define QCOM_SLIM_AUTOSUSPEND 1000
-
-/* MAX message size over control channel */
-#define SLIM_MSGQ_BUF_LEN	40
-#define QCOM_TX_MSGS 2
-#define QCOM_RX_MSGS	8
-#define QCOM_BUF_ALLOC_RETRIES	10
-
-#define CFG_PORT(r, v) ((v) ? CFG_PORT_V2(r) : CFG_PORT_V1(r))
-
-/* V2 Component registers */
-#define CFG_PORT_V2(r) ((r ## _V2))
-#define	COMP_CFG_V2		4
-#define	COMP_TRUST_CFG_V2	0x3000
-
-/* V1 Component registers */
-#define CFG_PORT_V1(r) ((r ## _V1))
-#define	COMP_CFG_V1		0
-#define	COMP_TRUST_CFG_V1	0x14
-
-/* Resource group info for manager, and non-ported generic device-components */
-#define EE_MGR_RSC_GRP	(1 << 10)
-#define EE_NGD_2	(2 << 6)
-#define EE_NGD_1	0
-
-struct slim_ctrl_buf {
-	void		*base;
-	spinlock_t	lock;
-	int		head;
-	int		tail;
-	int		sl_sz;
-	int		n;
-};
-
-struct qcom_slim_ctrl {
-	struct slim_controller  ctrl;
-	struct slim_framer	framer;
-	struct device		*dev;
-	void __iomem		*base;
-	void __iomem		*slew_reg;
-
-	struct slim_ctrl_buf	rx;
-	struct slim_ctrl_buf	tx;
-
-	struct completion	**wr_comp;
-	int			irq;
-	struct workqueue_struct *rxwq;
-	struct work_struct	wd;
-	struct clk		*rclk;
-	struct clk		*hclk;
-};
-
-static void qcom_slim_queue_tx(struct qcom_slim_ctrl *ctrl, void *buf,
-			       u8 len, u32 tx_reg)
-{
-	int count = (len + 3) >> 2;
-
-	__iowrite32_copy(ctrl->base + tx_reg, buf, count);
-
-	/* Ensure Oder of subsequent writes */
-	mb();
-}
-
-static void *slim_alloc_rxbuf(struct qcom_slim_ctrl *ctrl)
-{
-	unsigned long flags;
-	int idx;
-
-	spin_lock_irqsave(&ctrl->rx.lock, flags);
-	if ((ctrl->rx.tail + 1) % ctrl->rx.n == ctrl->rx.head) {
-		spin_unlock_irqrestore(&ctrl->rx.lock, flags);
-		dev_err(ctrl->dev, "RX QUEUE full!");
-		return NULL;
-	}
-	idx = ctrl->rx.tail;
-	ctrl->rx.tail = (ctrl->rx.tail + 1) % ctrl->rx.n;
-	spin_unlock_irqrestore(&ctrl->rx.lock, flags);
-
-	return ctrl->rx.base + (idx * ctrl->rx.sl_sz);
-}
-
-static void slim_ack_txn(struct qcom_slim_ctrl *ctrl, int err)
-{
-	struct completion *comp;
-	unsigned long flags;
-	int idx;
-
-	spin_lock_irqsave(&ctrl->tx.lock, flags);
-	idx = ctrl->tx.head;
-	ctrl->tx.head = (ctrl->tx.head + 1) % ctrl->tx.n;
-	spin_unlock_irqrestore(&ctrl->tx.lock, flags);
-
-	comp = ctrl->wr_comp[idx];
-	ctrl->wr_comp[idx] = NULL;
-
-	complete(comp);
-}
-
-static irqreturn_t qcom_slim_handle_tx_irq(struct qcom_slim_ctrl *ctrl,
-					   u32 stat)
-{
-	int err = 0;
-
-	if (stat & MGR_INT_TX_MSG_SENT)
-		writel_relaxed(MGR_INT_TX_MSG_SENT,
-			       ctrl->base + MGR_INT_CLR);
-
-	if (stat & MGR_INT_TX_NACKED_2) {
-		u32 mgr_stat = readl_relaxed(ctrl->base + MGR_STATUS);
-		u32 mgr_ie_stat = readl_relaxed(ctrl->base + MGR_IE_STAT);
-		u32 frm_stat = readl_relaxed(ctrl->base + FRM_STAT);
-		u32 frm_cfg = readl_relaxed(ctrl->base + FRM_CFG);
-		u32 frm_intr_stat = readl_relaxed(ctrl->base + FRM_INT_STAT);
-		u32 frm_ie_stat = readl_relaxed(ctrl->base + FRM_IE_STAT);
-		u32 intf_stat = readl_relaxed(ctrl->base + INTF_STAT);
-		u32 intf_intr_stat = readl_relaxed(ctrl->base + INTF_INT_STAT);
-		u32 intf_ie_stat = readl_relaxed(ctrl->base + INTF_IE_STAT);
-
-		writel_relaxed(MGR_INT_TX_NACKED_2, ctrl->base + MGR_INT_CLR);
-
-		dev_err(ctrl->dev, "TX Nack MGR:int:0x%x, stat:0x%x\n",
-			stat, mgr_stat);
-		dev_err(ctrl->dev, "TX Nack MGR:ie:0x%x\n", mgr_ie_stat);
-		dev_err(ctrl->dev, "TX Nack FRM:int:0x%x, stat:0x%x\n",
-			frm_intr_stat, frm_stat);
-		dev_err(ctrl->dev, "TX Nack FRM:cfg:0x%x, ie:0x%x\n",
-			frm_cfg, frm_ie_stat);
-		dev_err(ctrl->dev, "TX Nack INTF:intr:0x%x, stat:0x%x\n",
-			intf_intr_stat, intf_stat);
-		dev_err(ctrl->dev, "TX Nack INTF:ie:0x%x\n",
-			intf_ie_stat);
-		err = -ENOTCONN;
-	}
-
-	slim_ack_txn(ctrl, err);
-
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t qcom_slim_handle_rx_irq(struct qcom_slim_ctrl *ctrl,
-					   u32 stat)
-{
-	u32 *rx_buf, pkt[10];
-	bool q_rx = false;
-	u8 mc, mt, len;
-
-	pkt[0] = readl_relaxed(ctrl->base + MGR_RX_MSG);
-	mt = SLIM_HEADER_GET_MT(pkt[0]);
-	len = SLIM_HEADER_GET_RL(pkt[0]);
-	mc = SLIM_HEADER_GET_MC(pkt[0]>>8);
-
-	/*
-	 * this message cannot be handled by ISR, so
-	 * let work-queue handle it
-	 */
-	if (mt == SLIM_MSG_MT_CORE && mc == SLIM_MSG_MC_REPORT_PRESENT) {
-		rx_buf = (u32 *)slim_alloc_rxbuf(ctrl);
-		if (!rx_buf) {
-			dev_err(ctrl->dev, "dropping RX:0x%x due to RX full\n",
-					pkt[0]);
-			goto rx_ret_irq;
-		}
-		rx_buf[0] = pkt[0];
-
-	} else {
-		rx_buf = pkt;
-	}
-
-	__ioread32_copy(rx_buf + 1, ctrl->base + MGR_RX_MSG + 4,
-			DIV_ROUND_UP(len, 4));
-
-	switch (mc) {
-
-	case SLIM_MSG_MC_REPORT_PRESENT:
-		q_rx = true;
-		break;
-	case SLIM_MSG_MC_REPLY_INFORMATION:
-	case SLIM_MSG_MC_REPLY_VALUE:
-		slim_msg_response(&ctrl->ctrl, (u8 *)(rx_buf + 1),
-				  (u8)(*rx_buf >> 24), (len - 4));
-		break;
-	default:
-		dev_err(ctrl->dev, "unsupported MC,%x MT:%x\n",
-			mc, mt);
-		break;
-	}
-rx_ret_irq:
-	writel(MGR_INT_RX_MSG_RCVD, ctrl->base +
-		       MGR_INT_CLR);
-	if (q_rx)
-		queue_work(ctrl->rxwq, &ctrl->wd);
-
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t qcom_slim_interrupt(int irq, void *d)
-{
-	struct qcom_slim_ctrl *ctrl = d;
-	u32 stat = readl_relaxed(ctrl->base + MGR_INT_STAT);
-	int ret = IRQ_NONE;
-
-	if (stat & MGR_INT_TX_MSG_SENT || stat & MGR_INT_TX_NACKED_2)
-		ret = qcom_slim_handle_tx_irq(ctrl, stat);
-
-	if (stat & MGR_INT_RX_MSG_RCVD)
-		ret = qcom_slim_handle_rx_irq(ctrl, stat);
-
-	return ret;
-}
-
-static int qcom_clk_pause_wakeup(struct slim_controller *sctrl)
-{
-	struct qcom_slim_ctrl *ctrl = dev_get_drvdata(sctrl->dev);
-
-	clk_prepare_enable(ctrl->hclk);
-	clk_prepare_enable(ctrl->rclk);
-	enable_irq(ctrl->irq);
-
-	writel_relaxed(1, ctrl->base + FRM_WAKEUP);
-	/* Make sure framer wakeup write goes through before ISR fires */
-	mb();
-	/*
-	 * HW Workaround: Currently, slave is reporting lost-sync messages
-	 * after SLIMbus comes out of clock pause.
-	 * Transaction with slave fail before slave reports that message
-	 * Give some time for that report to come
-	 * SLIMbus wakes up in clock gear 10 at 24.576MHz. With each superframe
-	 * being 250 usecs, we wait for 5-10 superframes here to ensure
-	 * we get the message
-	 */
-	usleep_range(1250, 2500);
-	return 0;
-}
-
-static void *slim_alloc_txbuf(struct qcom_slim_ctrl *ctrl,
-			      struct slim_msg_txn *txn,
-			      struct completion *done)
-{
-	unsigned long flags;
-	int idx;
-
-	spin_lock_irqsave(&ctrl->tx.lock, flags);
-	if (((ctrl->tx.head + 1) % ctrl->tx.n) == ctrl->tx.tail) {
-		spin_unlock_irqrestore(&ctrl->tx.lock, flags);
-		dev_err(ctrl->dev, "controller TX buf unavailable");
-		return NULL;
-	}
-	idx = ctrl->tx.tail;
-	ctrl->wr_comp[idx] = done;
-	ctrl->tx.tail = (ctrl->tx.tail + 1) % ctrl->tx.n;
-
-	spin_unlock_irqrestore(&ctrl->tx.lock, flags);
-
-	return ctrl->tx.base + (idx * ctrl->tx.sl_sz);
-}
-
-
-static int qcom_xfer_msg(struct slim_controller *sctrl,
-			 struct slim_msg_txn *txn)
-{
-	struct qcom_slim_ctrl *ctrl = dev_get_drvdata(sctrl->dev);
-	DECLARE_COMPLETION_ONSTACK(done);
-	void *pbuf = slim_alloc_txbuf(ctrl, txn, &done);
-	unsigned long ms = txn->rl + HZ;
-	u8 *puc;
-	int ret = 0, retries = QCOM_BUF_ALLOC_RETRIES;
-	unsigned long time_left;
-	u8 la = txn->la;
-	u32 *head;
-	/* HW expects length field to be excluded */
-	txn->rl--;
-
-	/* spin till buffer is made available */
-	if (!pbuf) {
-		while (retries--) {
-			usleep_range(10000, 15000);
-			pbuf = slim_alloc_txbuf(ctrl, txn, &done);
-			if (pbuf)
-				break;
-		}
-	}
-
-	if (retries < 0 && !pbuf)
-		return -ENOMEM;
-
-	puc = (u8 *)pbuf;
-	head = (u32 *)pbuf;
-
-	if (txn->dt == SLIM_MSG_DEST_LOGICALADDR) {
-		*head = SLIM_MSG_ASM_FIRST_WORD(txn->rl, txn->mt,
-						txn->mc, 0, la);
-		puc += 3;
-	} else {
-		*head = SLIM_MSG_ASM_FIRST_WORD(txn->rl, txn->mt,
-						txn->mc, 1, la);
-		puc += 2;
-	}
-
-	if (slim_tid_txn(txn->mt, txn->mc))
-		*(puc++) = txn->tid;
-
-	if (slim_ec_txn(txn->mt, txn->mc)) {
-		*(puc++) = (txn->ec & 0xFF);
-		*(puc++) = (txn->ec >> 8) & 0xFF;
-	}
-
-	if (txn->msg && txn->msg->wbuf)
-		memcpy(puc, txn->msg->wbuf, txn->msg->num_bytes);
-
-	qcom_slim_queue_tx(ctrl, head, txn->rl, MGR_TX_MSG);
-	time_left = wait_for_completion_timeout(&done, msecs_to_jiffies(ms));
-
-	if (!time_left) {
-		dev_err(ctrl->dev, "TX timed out:MC:0x%x,mt:0x%x", txn->mc,
-					txn->mt);
-		ret = -ETIMEDOUT;
-	}
-
-	return ret;
-
-}
-
-static int qcom_set_laddr(struct slim_controller *sctrl,
-				struct slim_eaddr *ead, u8 laddr)
-{
-	struct qcom_slim_ctrl *ctrl = dev_get_drvdata(sctrl->dev);
-	struct {
-		__be16 manf_id;
-		__be16 prod_code;
-		u8 dev_index;
-		u8 instance;
-		u8 laddr;
-	} __packed p;
-	struct slim_val_inf msg = {0};
-	DEFINE_SLIM_EDEST_TXN(txn, SLIM_MSG_MC_ASSIGN_LOGICAL_ADDRESS,
-			      10, laddr, &msg);
-	int ret;
-
-	p.manf_id = cpu_to_be16(ead->manf_id);
-	p.prod_code = cpu_to_be16(ead->prod_code);
-	p.dev_index = ead->dev_index;
-	p.instance = ead->instance;
-	p.laddr = laddr;
-
-	msg.wbuf = (void *)&p;
-	msg.num_bytes = 7;
-	ret = slim_do_transfer(&ctrl->ctrl, &txn);
-
-	if (ret)
-		dev_err(ctrl->dev, "set LA:0x%x failed:ret:%d\n",
-				  laddr, ret);
-	return ret;
-}
-
-static int slim_get_current_rxbuf(struct qcom_slim_ctrl *ctrl, void *buf)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&ctrl->rx.lock, flags);
-	if (ctrl->rx.tail == ctrl->rx.head) {
-		spin_unlock_irqrestore(&ctrl->rx.lock, flags);
-		return -ENODATA;
-	}
-	memcpy(buf, ctrl->rx.base + (ctrl->rx.head * ctrl->rx.sl_sz),
-				ctrl->rx.sl_sz);
-
-	ctrl->rx.head = (ctrl->rx.head + 1) % ctrl->rx.n;
-	spin_unlock_irqrestore(&ctrl->rx.lock, flags);
-
-	return 0;
-}
-
-static void qcom_slim_rxwq(struct work_struct *work)
-{
-	u8 buf[SLIM_MSGQ_BUF_LEN];
-	u8 mc, mt;
-	int ret;
-	struct qcom_slim_ctrl *ctrl = container_of(work, struct qcom_slim_ctrl,
-						 wd);
-
-	while ((slim_get_current_rxbuf(ctrl, buf)) != -ENODATA) {
-		mt = SLIM_HEADER_GET_MT(buf[0]);
-		mc = SLIM_HEADER_GET_MC(buf[1]);
-		if (mt == SLIM_MSG_MT_CORE &&
-			mc == SLIM_MSG_MC_REPORT_PRESENT) {
-			struct slim_eaddr ea;
-			u8 laddr;
-
-			ea.manf_id = be16_to_cpup((__be16 *)&buf[2]);
-			ea.prod_code = be16_to_cpup((__be16 *)&buf[4]);
-			ea.dev_index = buf[6];
-			ea.instance = buf[7];
-
-			ret = slim_device_report_present(&ctrl->ctrl, &ea,
-							 &laddr);
-			if (ret < 0)
-				dev_err(ctrl->dev, "assign laddr failed:%d\n",
-					ret);
-		} else {
-			dev_err(ctrl->dev, "unexpected message:mc:%x, mt:%x\n",
-				mc, mt);
-		}
-	}
-}
-
-static void qcom_slim_prg_slew(struct platform_device *pdev,
-				struct qcom_slim_ctrl *ctrl)
-{
-	if (!ctrl->slew_reg) {
-		/* SLEW RATE register for this SLIMbus */
-		ctrl->slew_reg = devm_platform_ioremap_resource_byname(pdev, "slew");
-		if (IS_ERR(ctrl->slew_reg))
-			return;
-	}
-
-	writel_relaxed(1, ctrl->slew_reg);
-	/* Make sure SLIMbus-slew rate enabling goes through */
-	wmb();
-}
-
-static int qcom_slim_probe(struct platform_device *pdev)
-{
-	struct qcom_slim_ctrl *ctrl;
-	struct slim_controller *sctrl;
-	int ret, ver;
-
-	ctrl = devm_kzalloc(&pdev->dev, sizeof(*ctrl), GFP_KERNEL);
-	if (!ctrl)
-		return -ENOMEM;
-
-	ctrl->hclk = devm_clk_get(&pdev->dev, "iface");
-	if (IS_ERR(ctrl->hclk))
-		return PTR_ERR(ctrl->hclk);
-
-	ctrl->rclk = devm_clk_get(&pdev->dev, "core");
-	if (IS_ERR(ctrl->rclk))
-		return PTR_ERR(ctrl->rclk);
-
-	ret = clk_set_rate(ctrl->rclk, SLIM_ROOT_FREQ);
-	if (ret) {
-		dev_err(&pdev->dev, "ref-clock set-rate failed:%d\n", ret);
-		return ret;
-	}
-
-	ctrl->irq = platform_get_irq(pdev, 0);
-	if (ctrl->irq < 0)
-		return ctrl->irq;
-
-	sctrl = &ctrl->ctrl;
-	sctrl->dev = &pdev->dev;
-	ctrl->dev = &pdev->dev;
-	platform_set_drvdata(pdev, ctrl);
-	dev_set_drvdata(ctrl->dev, ctrl);
-
-	ctrl->base = devm_platform_ioremap_resource_byname(pdev, "ctrl");
-	if (IS_ERR(ctrl->base))
-		return PTR_ERR(ctrl->base);
-
-	sctrl->set_laddr = qcom_set_laddr;
-	sctrl->xfer_msg = qcom_xfer_msg;
-	sctrl->wakeup =  qcom_clk_pause_wakeup;
-	ctrl->tx.n = QCOM_TX_MSGS;
-	ctrl->tx.sl_sz = SLIM_MSGQ_BUF_LEN;
-	ctrl->rx.n = QCOM_RX_MSGS;
-	ctrl->rx.sl_sz = SLIM_MSGQ_BUF_LEN;
-	ctrl->wr_comp = kcalloc(QCOM_TX_MSGS, sizeof(struct completion *),
-				GFP_KERNEL);
-	if (!ctrl->wr_comp)
-		return -ENOMEM;
-
-	spin_lock_init(&ctrl->rx.lock);
-	spin_lock_init(&ctrl->tx.lock);
-	INIT_WORK(&ctrl->wd, qcom_slim_rxwq);
-	ctrl->rxwq = create_singlethread_workqueue("qcom_slim_rx");
-	if (!ctrl->rxwq) {
-		dev_err(ctrl->dev, "Failed to start Rx WQ\n");
-		return -ENOMEM;
-	}
-
-	ctrl->framer.rootfreq = SLIM_ROOT_FREQ / 8;
-	ctrl->framer.superfreq =
-		ctrl->framer.rootfreq / SLIM_CL_PER_SUPERFRAME_DIV8;
-	sctrl->a_framer = &ctrl->framer;
-	sctrl->clkgear = SLIM_MAX_CLK_GEAR;
-
-	qcom_slim_prg_slew(pdev, ctrl);
-
-	ret = devm_request_irq(&pdev->dev, ctrl->irq, qcom_slim_interrupt,
-				IRQF_TRIGGER_HIGH, "qcom_slim_irq", ctrl);
-	if (ret) {
-		dev_err(&pdev->dev, "request IRQ failed\n");
-		goto err_request_irq_failed;
-	}
-
-	ret = clk_prepare_enable(ctrl->hclk);
-	if (ret)
-		goto err_hclk_enable_failed;
-
-	ret = clk_prepare_enable(ctrl->rclk);
-	if (ret)
-		goto err_rclk_enable_failed;
-
-	ctrl->tx.base = devm_kcalloc(&pdev->dev, ctrl->tx.n, ctrl->tx.sl_sz,
-				     GFP_KERNEL);
-	if (!ctrl->tx.base) {
-		ret = -ENOMEM;
-		goto err;
-	}
-
-	ctrl->rx.base = devm_kcalloc(&pdev->dev,ctrl->rx.n, ctrl->rx.sl_sz,
-				     GFP_KERNEL);
-	if (!ctrl->rx.base) {
-		ret = -ENOMEM;
-		goto err;
-	}
-
-	/* Register with framework before enabling frame, clock */
-	ret = slim_register_controller(&ctrl->ctrl);
-	if (ret) {
-		dev_err(ctrl->dev, "error adding controller\n");
-		goto err;
-	}
-
-	ver = readl_relaxed(ctrl->base);
-	/* Version info in 16 MSbits */
-	ver >>= 16;
-	/* Component register initialization */
-	writel(1, ctrl->base + CFG_PORT(COMP_CFG, ver));
-	writel((EE_MGR_RSC_GRP | EE_NGD_2 | EE_NGD_1),
-				ctrl->base + CFG_PORT(COMP_TRUST_CFG, ver));
-
-	writel((MGR_INT_TX_NACKED_2 |
-			MGR_INT_MSG_BUF_CONTE | MGR_INT_RX_MSG_RCVD |
-			MGR_INT_TX_MSG_SENT), ctrl->base + MGR_INT_EN);
-	writel(1, ctrl->base + MGR_CFG);
-	/* Framer register initialization */
-	writel((1 << INTR_WAKE) | (0xA << REF_CLK_GEAR) |
-		(0xA << CLK_GEAR) | (1 << ROOT_FREQ) | (1 << FRM_ACTIVE) | 1,
-		ctrl->base + FRM_CFG);
-	writel(MGR_CFG_ENABLE, ctrl->base + MGR_CFG);
-	writel(1, ctrl->base + INTF_CFG);
-	writel(1, ctrl->base + CFG_PORT(COMP_CFG, ver));
-
-	pm_runtime_use_autosuspend(&pdev->dev);
-	pm_runtime_set_autosuspend_delay(&pdev->dev, QCOM_SLIM_AUTOSUSPEND);
-	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_mark_last_busy(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
-
-	dev_dbg(ctrl->dev, "QCOM SB controller is up:ver:0x%x!\n", ver);
-	return 0;
-
-err:
-	clk_disable_unprepare(ctrl->rclk);
-err_rclk_enable_failed:
-	clk_disable_unprepare(ctrl->hclk);
-err_hclk_enable_failed:
-err_request_irq_failed:
-	destroy_workqueue(ctrl->rxwq);
-	return ret;
-}
-
-static void qcom_slim_remove(struct platform_device *pdev)
-{
-	struct qcom_slim_ctrl *ctrl = platform_get_drvdata(pdev);
-
-	pm_runtime_disable(&pdev->dev);
-	slim_unregister_controller(&ctrl->ctrl);
-	clk_disable_unprepare(ctrl->rclk);
-	clk_disable_unprepare(ctrl->hclk);
-	destroy_workqueue(ctrl->rxwq);
-}
-
-/*
- * If PM_RUNTIME is not defined, these 2 functions become helper
- * functions to be called from system suspend/resume.
- */
-#ifdef CONFIG_PM
-static int qcom_slim_runtime_suspend(struct device *device)
-{
-	struct qcom_slim_ctrl *ctrl = dev_get_drvdata(device);
-	int ret;
-
-	dev_dbg(device, "pm_runtime: suspending...\n");
-	ret = slim_ctrl_clk_pause(&ctrl->ctrl, false, SLIM_CLK_UNSPECIFIED);
-	if (ret) {
-		dev_err(device, "clk pause not entered:%d", ret);
-	} else {
-		disable_irq(ctrl->irq);
-		clk_disable_unprepare(ctrl->hclk);
-		clk_disable_unprepare(ctrl->rclk);
-	}
-	return ret;
-}
-
-static int qcom_slim_runtime_resume(struct device *device)
-{
-	struct qcom_slim_ctrl *ctrl = dev_get_drvdata(device);
-	int ret = 0;
-
-	dev_dbg(device, "pm_runtime: resuming...\n");
-	ret = slim_ctrl_clk_pause(&ctrl->ctrl, true, 0);
-	if (ret)
-		dev_err(device, "clk pause not exited:%d", ret);
-	return ret;
-}
-#endif
-
-#ifdef CONFIG_PM_SLEEP
-static int qcom_slim_suspend(struct device *dev)
-{
-	int ret = 0;
-
-	if (!pm_runtime_enabled(dev) ||
-		(!pm_runtime_suspended(dev))) {
-		dev_dbg(dev, "system suspend");
-		ret = qcom_slim_runtime_suspend(dev);
-	}
-
-	return ret;
-}
-
-static int qcom_slim_resume(struct device *dev)
-{
-	if (!pm_runtime_enabled(dev) || !pm_runtime_suspended(dev)) {
-		int ret;
-
-		dev_dbg(dev, "system resume");
-		ret = qcom_slim_runtime_resume(dev);
-		if (!ret) {
-			pm_runtime_mark_last_busy(dev);
-			pm_request_autosuspend(dev);
-		}
-		return ret;
-
-	}
-	return 0;
-}
-#endif /* CONFIG_PM_SLEEP */
-
-static const struct dev_pm_ops qcom_slim_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(qcom_slim_suspend, qcom_slim_resume)
-	SET_RUNTIME_PM_OPS(
-			   qcom_slim_runtime_suspend,
-			   qcom_slim_runtime_resume,
-			   NULL
-	)
-};
-
-static const struct of_device_id qcom_slim_dt_match[] = {
-	{ .compatible = "qcom,slim", },
-	{}
-};
-MODULE_DEVICE_TABLE(of, qcom_slim_dt_match);
-
-static struct platform_driver qcom_slim_driver = {
-	.probe = qcom_slim_probe,
-	.remove = qcom_slim_remove,
-	.driver	= {
-		.name = "qcom_slim_ctrl",
-		.of_match_table = qcom_slim_dt_match,
-		.pm = &qcom_slim_dev_pm_ops,
-	},
-};
-module_platform_driver(qcom_slim_driver);
-
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("Qualcomm SLIMbus Controller");
-- 
2.50.0


