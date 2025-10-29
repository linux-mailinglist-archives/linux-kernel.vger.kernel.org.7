Return-Path: <linux-kernel+bounces-875252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D5594C18858
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 58D44350E26
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5383090CE;
	Wed, 29 Oct 2025 06:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="F2TWoYjW"
Received: from mail-m3291.qiye.163.com (mail-m3291.qiye.163.com [220.197.32.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB44DDAB;
	Wed, 29 Oct 2025 06:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761720754; cv=none; b=HZrLQnCh06eYTzt3R+QRxS2emOlrgtVq0C9YRdXwTXT7Kaf9pLuHH+V2aSOQ8sIweYYAg5z+aYAiZ2anWixWOmqcSpU5JDmKJMu+SKDXhMUlPPVZFnVhxV2MVR7C6F7EHozXhFNedsuANTjXe6ZRDA0Tl2I2v5wMFG7EAjDTVBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761720754; c=relaxed/simple;
	bh=tL9huuj0lp11J3BNxg+GBpa/qQMQoaOviG2IhmdbrZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TlnvT8Thz1tl99ZnxR6JqWQwCZ+/uQisbpH3RXsvSY2Ahdc3nQ1Vfq3WGlzl6E/vJB+qymVTeYwf8j54l35ahVgaWCAGN/1jyYgXVtQT9xRNmW85fwkbtpLvqp1fNpSD2vvD1rlqcoTHM3pebPgmk55swLaYKaVPQRHHLbJmtIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=F2TWoYjW; arc=none smtp.client-ip=220.197.32.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 279245f00;
	Wed, 29 Oct 2025 11:23:08 +0800 (GMT+08:00)
From: Elaine Zhang <zhangqing@rock-chips.com>
To: zhangqing@rock-chips.com,
	mkl@pengutronix.de,
	kernel@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	cl@rock-chips.com
Cc: linux-can@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v8 2/4] net: can: rockchip: Refactor the rkcanfd_devtype_data structure
Date: Wed, 29 Oct 2025 11:23:00 +0800
Message-Id: <20251029032302.1238973-3-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029032302.1238973-1-zhangqing@rock-chips.com>
References: <20251029032302.1238973-1-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a2dfda1f903a3kunm7a63a81221faf9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkkZTFZNS0xOTEIYSUwZGkxWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=F2TWoYjW39o2eu4jrQ7YwBPPNeLGZK9OvZIMV38kJx/vN3XgWPiAeFB9hxRLDyM5828s8fNn+ycbMxvjfkE2m3QRugIBREA4a4wyataLeiZxiCauZBsab0DbufWPiOB3eQEg+98ztprb4aOUgcQz9qpFT+eyspfjW9NfXUmmkoc=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=qO5gjJMOC2KoZtAZHzit9KBiOeQ/Raj5W6HVLeYvZI4=;
	h=date:mime-version:subject:message-id:from;

Add new function pointer:
Encapsulate some hardware operation functions into
rkcanfd_devtype_data to provide differentiated implementations for
different models (such as RK3568v2/v3).

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 .../net/can/rockchip/rockchip_canfd-core.c    | 100 ++++++++++--------
 drivers/net/can/rockchip/rockchip_canfd.h     |  10 ++
 2 files changed, 68 insertions(+), 42 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 046f0a0ae4d4..761cb36148ff 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -24,32 +24,6 @@
 
 #include "rockchip_canfd.h"
 
-static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3568v2 = {
-	.model = RKCANFD_MODEL_RK3568V2,
-	.quirks = RKCANFD_QUIRK_RK3568_ERRATUM_1 | RKCANFD_QUIRK_RK3568_ERRATUM_2 |
-		RKCANFD_QUIRK_RK3568_ERRATUM_3 | RKCANFD_QUIRK_RK3568_ERRATUM_4 |
-		RKCANFD_QUIRK_RK3568_ERRATUM_5 | RKCANFD_QUIRK_RK3568_ERRATUM_6 |
-		RKCANFD_QUIRK_RK3568_ERRATUM_7 | RKCANFD_QUIRK_RK3568_ERRATUM_8 |
-		RKCANFD_QUIRK_RK3568_ERRATUM_9 | RKCANFD_QUIRK_RK3568_ERRATUM_10 |
-		RKCANFD_QUIRK_RK3568_ERRATUM_11 | RKCANFD_QUIRK_RK3568_ERRATUM_12 |
-		RKCANFD_QUIRK_CANFD_BROKEN,
-};
-
-/* The rk3568 CAN-FD errata sheet as of Tue 07 Nov 2023 11:25:31 +08:00
- * states that only the rk3568v2 is affected by erratum 5, but tests
- * with the rk3568v2 and rk3568v3 show that the RX_FIFO_CNT is
- * sometimes too high. In contrast to the errata sheet mark rk3568v3
- * as effected by erratum 5, too.
- */
-static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3568v3 = {
-	.model = RKCANFD_MODEL_RK3568V3,
-	.quirks = RKCANFD_QUIRK_RK3568_ERRATUM_1 | RKCANFD_QUIRK_RK3568_ERRATUM_2 |
-		RKCANFD_QUIRK_RK3568_ERRATUM_5 | RKCANFD_QUIRK_RK3568_ERRATUM_7 |
-		RKCANFD_QUIRK_RK3568_ERRATUM_8 | RKCANFD_QUIRK_RK3568_ERRATUM_10 |
-		RKCANFD_QUIRK_RK3568_ERRATUM_11 | RKCANFD_QUIRK_RK3568_ERRATUM_12 |
-		RKCANFD_QUIRK_CANFD_BROKEN,
-};
-
 static const char *__rkcanfd_get_model_str(enum rkcanfd_model model)
 {
 	switch (model) {
@@ -212,7 +186,7 @@ static int rkcanfd_get_berr_counter(const struct net_device *ndev,
 	if (err)
 		return err;
 
-	rkcanfd_get_berr_counter_corrected(priv, bec);
+	priv->devtype_data.get_berr_counter(priv, bec);
 
 	pm_runtime_put(ndev->dev.parent);
 
@@ -302,7 +276,7 @@ static void rkcanfd_chip_start(struct rkcanfd_priv *priv)
 
 	rkcanfd_set_bittiming(priv);
 
-	rkcanfd_chip_interrupts_disable(priv);
+	priv->devtype_data.interrupts_disable(priv);
 	rkcanfd_chip_set_work_mode(priv);
 
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
@@ -316,7 +290,7 @@ static void __rkcanfd_chip_stop(struct rkcanfd_priv *priv, const enum can_state
 	priv->can.state = state;
 
 	rkcanfd_chip_set_reset_mode(priv);
-	rkcanfd_chip_interrupts_disable(priv);
+	priv->devtype_data.interrupts_disable(priv);
 }
 
 static void rkcanfd_chip_stop(struct rkcanfd_priv *priv, const enum can_state state)
@@ -342,8 +316,8 @@ static int rkcanfd_set_mode(struct net_device *ndev,
 
 	switch (mode) {
 	case CAN_MODE_START:
-		rkcanfd_chip_start(priv);
-		rkcanfd_chip_interrupts_enable(priv);
+		priv->devtype_data.chip_start(priv);
+		priv->devtype_data.interrupts_enable(priv);
 		netif_wake_queue(ndev);
 		break;
 
@@ -537,7 +511,7 @@ static int rkcanfd_handle_error_int(struct rkcanfd_priv *priv)
 		if (cf) {
 			struct can_berr_counter bec;
 
-			rkcanfd_get_berr_counter_corrected(priv, &bec);
+			priv->devtype_data.get_berr_counter(priv, &bec);
 			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR | CAN_ERR_CNT;
 			cf->data[6] = bec.txerr;
 			cf->data[7] = bec.rxerr;
@@ -567,7 +541,7 @@ static int rkcanfd_handle_state_error_int(struct rkcanfd_priv *priv)
 	u32 timestamp;
 	int err;
 
-	rkcanfd_get_berr_counter_corrected(priv, &bec);
+	priv->devtype_data.get_berr_counter(priv, &bec);
 	can_state_get_by_berr_counter(ndev, &bec, &tx_state, &rx_state);
 
 	new_state = max(tx_state, rx_state);
@@ -581,7 +555,7 @@ static int rkcanfd_handle_state_error_int(struct rkcanfd_priv *priv)
 	can_change_state(ndev, cf, tx_state, rx_state);
 
 	if (new_state == CAN_STATE_BUS_OFF) {
-		rkcanfd_chip_stop(priv, CAN_STATE_BUS_OFF);
+		priv->devtype_data.chip_stop(priv, CAN_STATE_BUS_OFF);
 		can_bus_off(ndev);
 	}
 
@@ -620,7 +594,7 @@ rkcanfd_handle_rx_fifo_overflow_int(struct rkcanfd_priv *priv)
 	if (!skb)
 		return 0;
 
-	rkcanfd_get_berr_counter_corrected(priv, &bec);
+	priv->devtype_data.get_berr_counter(priv, &bec);
 
 	cf->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
 	cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
@@ -719,21 +693,21 @@ static int rkcanfd_open(struct net_device *ndev)
 	if (err)
 		goto out_close_candev;
 
-	rkcanfd_chip_start(priv);
+	priv->devtype_data.chip_start(priv);
 	can_rx_offload_enable(&priv->offload);
 
-	err = request_irq(ndev->irq, rkcanfd_irq, IRQF_SHARED, ndev->name, priv);
+	err = request_irq(ndev->irq, priv->devtype_data.irq, IRQF_SHARED, ndev->name, priv);
 	if (err)
 		goto out_rkcanfd_chip_stop;
 
-	rkcanfd_chip_interrupts_enable(priv);
+	priv->devtype_data.interrupts_enable(priv);
 
 	netif_start_queue(ndev);
 
 	return 0;
 
 out_rkcanfd_chip_stop:
-	rkcanfd_chip_stop_sync(priv, CAN_STATE_STOPPED);
+	priv->devtype_data.chip_stop_sync(priv, CAN_STATE_STOPPED);
 	pm_runtime_put(ndev->dev.parent);
 out_close_candev:
 	close_candev(ndev);
@@ -746,10 +720,10 @@ static int rkcanfd_stop(struct net_device *ndev)
 
 	netif_stop_queue(ndev);
 
-	rkcanfd_chip_interrupts_disable(priv);
+	priv->devtype_data.interrupts_disable(priv);
 	free_irq(ndev->irq, priv);
 	can_rx_offload_disable(&priv->offload);
-	rkcanfd_chip_stop_sync(priv, CAN_STATE_STOPPED);
+	priv->devtype_data.chip_stop_sync(priv, CAN_STATE_STOPPED);
 	close_candev(ndev);
 
 	pm_runtime_put(ndev->dev.parent);
@@ -818,7 +792,7 @@ static int rkcanfd_register(struct rkcanfd_priv *priv)
 	if (err)
 		goto out_pm_runtime_put_sync;
 
-	rkcanfd_register_done(priv);
+	priv->devtype_data.register_done(priv);
 
 	pm_runtime_put(ndev->dev.parent);
 
@@ -840,6 +814,48 @@ static inline void rkcanfd_unregister(struct rkcanfd_priv *priv)
 	pm_runtime_disable(ndev->dev.parent);
 }
 
+static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3568v2 = {
+	.model = RKCANFD_MODEL_RK3568V2,
+	.quirks = RKCANFD_QUIRK_RK3568_ERRATUM_1 | RKCANFD_QUIRK_RK3568_ERRATUM_2 |
+		RKCANFD_QUIRK_RK3568_ERRATUM_3 | RKCANFD_QUIRK_RK3568_ERRATUM_4 |
+		RKCANFD_QUIRK_RK3568_ERRATUM_5 | RKCANFD_QUIRK_RK3568_ERRATUM_6 |
+		RKCANFD_QUIRK_RK3568_ERRATUM_7 | RKCANFD_QUIRK_RK3568_ERRATUM_8 |
+		RKCANFD_QUIRK_RK3568_ERRATUM_9 | RKCANFD_QUIRK_RK3568_ERRATUM_10 |
+		RKCANFD_QUIRK_RK3568_ERRATUM_11 | RKCANFD_QUIRK_RK3568_ERRATUM_12 |
+		RKCANFD_QUIRK_CANFD_BROKEN,
+	.get_berr_counter = rkcanfd_get_berr_counter_corrected,
+	.interrupts_enable = rkcanfd_chip_interrupts_enable,
+	.interrupts_disable = rkcanfd_chip_interrupts_disable,
+	.chip_start = rkcanfd_chip_start,
+	.chip_stop = rkcanfd_chip_stop,
+	.chip_stop_sync = rkcanfd_chip_stop_sync,
+	.irq = rkcanfd_irq,
+	.register_done = rkcanfd_register_done,
+};
+
+/* The rk3568 CAN-FD errata sheet as of Tue 07 Nov 2023 11:25:31 +08:00
+ * states that only the rk3568v2 is affected by erratum 5, but tests
+ * with the rk3568v2 and rk3568v3 show that the RX_FIFO_CNT is
+ * sometimes too high. In contrast to the errata sheet mark rk3568v3
+ * as effected by erratum 5, too.
+ */
+static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3568v3 = {
+	.model = RKCANFD_MODEL_RK3568V3,
+	.quirks = RKCANFD_QUIRK_RK3568_ERRATUM_1 | RKCANFD_QUIRK_RK3568_ERRATUM_2 |
+		RKCANFD_QUIRK_RK3568_ERRATUM_5 | RKCANFD_QUIRK_RK3568_ERRATUM_7 |
+		RKCANFD_QUIRK_RK3568_ERRATUM_8 | RKCANFD_QUIRK_RK3568_ERRATUM_10 |
+		RKCANFD_QUIRK_RK3568_ERRATUM_11 | RKCANFD_QUIRK_RK3568_ERRATUM_12 |
+		RKCANFD_QUIRK_CANFD_BROKEN,
+	.get_berr_counter = rkcanfd_get_berr_counter_corrected,
+	.interrupts_enable = rkcanfd_chip_interrupts_enable,
+	.interrupts_disable = rkcanfd_chip_interrupts_disable,
+	.chip_start = rkcanfd_chip_start,
+	.chip_stop = rkcanfd_chip_stop,
+	.chip_stop_sync = rkcanfd_chip_stop_sync,
+	.irq = rkcanfd_irq,
+	.register_done = rkcanfd_register_done,
+};
+
 static const struct of_device_id rkcanfd_of_match[] = {
 	{
 		.compatible = "rockchip,rk3568v2-canfd",
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 93131c7d7f54..72f26b96add0 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -436,9 +436,19 @@ enum rkcanfd_model {
 	RKCANFD_MODEL_RK3568V3 = 0x35683,
 };
 
+struct rkcanfd_priv;
+
 struct rkcanfd_devtype_data {
 	enum rkcanfd_model model;
 	u32 quirks;
+	void (*get_berr_counter)(struct rkcanfd_priv *priv, struct can_berr_counter *bec);
+	void (*interrupts_enable)(const struct rkcanfd_priv *priv);
+	void (*interrupts_disable)(const struct rkcanfd_priv *priv);
+	void (*chip_start)(struct rkcanfd_priv *priv);
+	void (*chip_stop)(struct rkcanfd_priv *priv, const enum can_state state);
+	void (*chip_stop_sync)(struct rkcanfd_priv *priv, const enum can_state state);
+	irqreturn_t (*irq)(int irq, void *dev_id);
+	void (*register_done)(const struct rkcanfd_priv *priv);
 };
 
 struct rkcanfd_fifo_header {
-- 
2.34.1


