Return-Path: <linux-kernel+bounces-755493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F96EB1A6FB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC6453AFCE9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B5020A5EB;
	Mon,  4 Aug 2025 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIchdfId"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668CD13C8FF
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754323431; cv=none; b=V6gn1/MowR3732JuEgLgikDzKAjPE/Dy5FHIAyPwWzQWzgNoSdpEm4Wp6s5VeV1/mp9GHYamSb6A/PEFOkv7hosmrObKrqsffsdhTbozTG4H5eSUoBPAfpCb/WmtjlAcAAoUEl1qorgH7rALi2G/eu5bKM3TDetwrrRGjaHKTic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754323431; c=relaxed/simple;
	bh=ABrxbqiRO0WBYpmUIQKz/arwQvOoXvUcy6fScOKL9Uk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tM9b6e1XvJA+94DwbbufrXabiFIiY9o+xUiRRqzKhScBykTRedhMEOuANCOy4mYXnQK59HYz4jojdfpOfXyi4J06gX5o8FKtR5BvACDaheLuqcZDIAzqPp7aXG7N/vSNKcU7xXfLUDR6DIrAvwloCjdgp3OBd4Rgm/O7L9mDvSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIchdfId; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2403ceef461so28250465ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 09:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754323429; x=1754928229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EuLKrEo/38TeccYm6/Zrtps7StZfzswaxcTtPYrzP+U=;
        b=EIchdfIdmFZCd+SDUH29xib4JY9VIM8H0RYHIzYZCOHQnvrgNL2dvdl+R1x3osHlct
         WdDF0PV+yC8h0fw1wPcgzXGKQBDG9dqMT9BaUjeSLykG/W2QtWEkUh2TievCCGd0uWqp
         luyftZ5mKyVPCdlPXMK78OOlW61Uh2oFs286pEYZzu+gkjZJSPaP0KMchlBmlzTPCYAt
         VHwfylSUIHqmTSg3yG16L/ccyg9FZ15+aouoi/MarCPcGVK7sSs5NdyI2yezj3UIV9nD
         5t17I9Jw+cooP/ppaoai5YO/8EPaRP7VWTg3iICYUc8NHycihwoDspYmm3lcmhnrbFKl
         53mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754323429; x=1754928229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EuLKrEo/38TeccYm6/Zrtps7StZfzswaxcTtPYrzP+U=;
        b=dLvQaL+umRguw2Py7DV3jKAEutKZD9WlxEIf1nquUEeog2JGT6CbxxSdoytKfoJWNP
         a7LRrsTSQoXna/8zClO1Yf42wO1y0wXKCmWD+0twc/HWa34n+WkXkBi/wKWpZabfib+9
         IF8757+hYIjhVqCGgb85gLJF8gB9XANjOAU59x8zE4KN6P7baNPWPqbPKX6ShsW1dlup
         PNr6jztDZLqggjJJLxyd4j8d6BivimeZnTTcCd7ll0F+pRcbqVSOV6h0gS09Y+j9IhhP
         fRVD8bL0YCagvGwYKLGg/PvQnMtW0LWlFxp+UF0pR9Sn0+PGwrSt/0dXiIjdelcwU9BK
         ixRg==
X-Forwarded-Encrypted: i=1; AJvYcCWIHFw6SKh4XwScaZmVVjY0ll0YkF8vFIS4sCwPmqPG1eW8S6xp0FlhE22MPG5GG5qYN4r6coupphpLRbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk1unJ0F5XpYsB27W3GDDTEkLBZ5YEci8dYy7OHOBn8LbKNpf/
	sqN+5jAiG3Mn6qCYesJpm3DB0e78f4lsxprz6fHsB25R0xmPc4DfOvs2
X-Gm-Gg: ASbGnctyv0KH5heWhavsA8hUKZLVwHhiuk+EjydE4vs/k3ZtzC8ND6rB5/vW2z403Nu
	x2EfZfa6GTub7oNPwjESL8cnw9GBsAux+gt50KBdy0z1Yt2+ockw24Hlegsex5CeAjx7MHYy5md
	6/fdh1trEZrdligcGoYSb5ojiCbAX/AFzKJLgMvxQYV2aNj6tbl/rtULSbP5Z3GY3wgKP6Ka3Ux
	QINdzBCf2Nw555VqYgQFPKxXqdc5ZTTMfzzqrRG7RNsWy3rRgYHres39MucZic/XXx00gxk3VMC
	bn1wq/8Pn60Jtc9rXyHE/9NASSWW+YcarNljxShJnWKH1uqzsXiKIxXj/+TZpmpD8t7QnNs4vG6
	leRnR8zGrmIJ4MYzK2zN+72ACkyBXyfKcaWAxnknUG+d9la2UzcAGniwywS3aXSw98Mrqn1zkjQ
	7ho+lBVwtGkxZf66LWmjYcwIviNN056mhataw4wK5sYUCzjVgq7uTI5T5trg==
X-Google-Smtp-Source: AGHT+IFpFHly+Ozf0EOVxfTWjc4+nDDGQgtb7fAKJmSeMzRkWUAP4gN7GeK0k4+gfh2wEmGHwbVPbg==
X-Received: by 2002:a17:902:cecd:b0:240:2281:bd0e with SMTP id d9443c01a7336-24246f2d317mr137834605ad.2.1754323428265;
        Mon, 04 Aug 2025 09:03:48 -0700 (PDT)
Received: from localhost.localdomain (2001-b011-7005-5e00-dd65-4c2e-14df-36e2.dynamic-ip6.hinet.net. [2001:b011:7005:5e00:dd65:4c2e:14df:36e2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899adc3sm113990615ad.118.2025.08.04.09.03.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Aug 2025 09:03:47 -0700 (PDT)
From: Haru Zheng <towwy321@gmail.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	CK Hu <ck.hu@mediatek.com>,
	Guillaume Ranquet <granquet@baylibre.com>
Cc: Bo-Chen Chen <rex-bc.chen@mediatek.com>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Haru Zheng <towwy321@gmail.com>
Subject: [PATCH v2] drm/mediatek: dp: Fix suspend/resume training failure
Date: Tue,  5 Aug 2025 00:03:36 +0800
Message-Id: <20250804160336.7615-1-towwy321@gmail.com>
X-Mailer: git-send-email 2.23.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When suspending and resuming DisplayPort via Type-C,
link training will be fail.

This patch backports the software IRQ handling for DP,
as eDP uses hardware IRQ while DP uses software IRQ.
Additionally, cable_plugged_in is flipped in
mtk_dp_hpd_event to ensure correct hotplug detection
during resume.

These changes fix the DP training failure after suspend/resume.

Fixes: f70ac097a2cf ("drm/mediatek: Add MT8195 Embedded DisplayPort driver")
Signed-off-by: Haru Zheng <towwy321@gmail.com>

---

Changes since v1:
- Fixed indentation to use tabs
- Simplified swirq_enable() logic with ternary
- Removed unnecessary memset()
- Replaced dev_info() with dev_dbg()
- Add mtk_dp_bridge_hpd_notify() declaration to struct drm_bridge_funcs mtk_dp_bridge_funcs
- Removed IRQ enable from probe() to avoid enabling IRQ for eDP
- Corrected HW/SW IRQ logic:
  * eDP uses hardware IRQ, DP uses software IRQ
  * Previously some logic was reversed causing issues
- Fixed hotplug detection logic in mtk_dp_hpd_event:
  * cable_plugged_in flag inverted to ensure correct detection on resume

Code flow:
- On suspend, DP disables training and IRQs accordingly.
- On resume, IRQs for DP are re-enabled via software IRQ handler.
- HPD events are processed with correct plug/unplug state, ensuring training succeeds.

---
 drivers/gpu/drm/mediatek/mtk_dp.c     | 94 ++++++++++++++++++++++++---
 drivers/gpu/drm/mediatek/mtk_dp_reg.h |  3 +
 2 files changed, 87 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index bef6eeb30d3e..b0f96c7c279e 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -1012,6 +1012,12 @@ static u32 mtk_dp_swirq_get_clear(struct mtk_dp *mtk_dp)
 	return irq_status;
 }
 
+static void mtk_dp_swirq_enable(struct mtk_dp *mtk_dp, bool enable)
+{
+	mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_35C4, enable ? 0 : 0xFFFF,
+			   SW_IRQ_FINAL_STATUS_DP_TRANS_P0_MASK);
+}
+
 static u32 mtk_dp_hwirq_get_clear(struct mtk_dp *mtk_dp)
 {
 	u32 irq_status = (mtk_dp_read(mtk_dp, MTK_DP_TRANS_P0_3418) &
@@ -2031,8 +2037,8 @@ static irqreturn_t mtk_dp_hpd_event(int hpd, void *dev)
 	spin_unlock_irqrestore(&mtk_dp->irq_thread_lock, flags);
 
 	if (cable_sta_chg) {
-		if (!!(mtk_dp_read(mtk_dp, MTK_DP_TRANS_P0_3414) &
-		       HPD_DB_DP_TRANS_P0_MASK))
+		if (!(mtk_dp_read(mtk_dp, MTK_DP_TRANS_P0_3414) &
+		      HPD_DB_DP_TRANS_P0_MASK))
 			mtk_dp->train_info.cable_plugged_in = true;
 		else
 			mtk_dp->train_info.cable_plugged_in = false;
@@ -2252,7 +2258,7 @@ static ssize_t mtk_dp_aux_transfer(struct drm_dp_aux *mtk_aux,
 					     to_access, &msg->reply);
 
 		if (ret) {
-			dev_info(mtk_dp->dev,
+			dev_dbg(mtk_dp->dev,
 				 "Failed to do AUX transfer: %d\n", ret);
 			goto err;
 		}
@@ -2265,6 +2271,35 @@ static ssize_t mtk_dp_aux_transfer(struct drm_dp_aux *mtk_aux,
 	return ret;
 }
 
+static void mtk_dp_swirq_hpd(struct mtk_dp *mtk_dp, u8 conn)
+{
+	u32 data;
+
+	data = mtk_dp_read(mtk_dp, MTK_DP_TRANS_P0_3414);
+
+	mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_3414,
+			   HPD_OVR_EN_DP_TRANS_P0_MASK,
+			   HPD_OVR_EN_DP_TRANS_P0_MASK);
+
+	if (conn)
+		mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_3414,
+				   HPD_SET_DP_TRANS_P0_MASK,
+				   HPD_SET_DP_TRANS_P0_MASK);
+	else
+		mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_3414,
+				   0,
+				   HPD_SET_DP_TRANS_P0_MASK);
+}
+
+static void mtk_dp_swirq_hpd_interrupt_set(struct mtk_dp *mtk_dp, u8 status)
+{
+	dev_dbg(mtk_dp->dev, "[DPTX] status:%d [2:DISCONNECT, 4:CONNECT]\n", status);
+
+	mtk_dp_swirq_hpd(mtk_dp, status == MTK_DP_HPD_CONNECT ? TRUE : FALSE);
+	mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_35C0, status,
+			   SW_IRQ_SET_DP_TRANS_P0_MASK);
+}
+
 static int mtk_dp_poweron(struct mtk_dp *mtk_dp)
 {
 	int ret;
@@ -2326,7 +2361,13 @@ static int mtk_dp_bridge_attach(struct drm_bridge *bridge,
 	if (mtk_dp->bridge.type != DRM_MODE_CONNECTOR_eDP) {
 		irq_clear_status_flags(mtk_dp->irq, IRQ_NOAUTOEN);
 		enable_irq(mtk_dp->irq);
+		/* eDP does use HW IRQs */
 		mtk_dp_hwirq_enable(mtk_dp, true);
+		mtk_dp_swirq_enable(mtk_dp, false);
+	} else {
+		/* DP does use SW IRQs */
+		mtk_dp_hwirq_enable(mtk_dp, false);
+		mtk_dp_swirq_enable(mtk_dp, true);
 	}
 
 	return 0;
@@ -2534,7 +2575,7 @@ static int mtk_dp_bridge_atomic_check(struct drm_bridge *bridge,
 
 	dev_dbg(mtk_dp->dev, "input format 0x%04x, output format 0x%04x\n",
 		bridge_state->input_bus_cfg.format,
-		 bridge_state->output_bus_cfg.format);
+		bridge_state->output_bus_cfg.format);
 
 	if (input_bus_format == MEDIA_BUS_FMT_YUYV8_1X16)
 		mtk_dp->info.format = DP_PIXELFORMAT_YUV422;
@@ -2552,6 +2593,30 @@ static int mtk_dp_bridge_atomic_check(struct drm_bridge *bridge,
 	return 0;
 }
 
+static void mtk_dp_bridge_hpd_notify(struct drm_bridge *bridge,
+				     enum drm_connector_status status)
+{
+	struct mtk_dp *mtk_dp = mtk_dp_from_bridge(bridge);
+	struct mtk_dp_train_info *train_info = &mtk_dp->train_info;
+
+	if (mtk_dp->bridge.type != DRM_MODE_CONNECTOR_eDP) {
+		if (mtk_dp->hpd_state != status) {
+			if (status == connector_status_disconnected) {
+				train_info->cable_plugged_in = false;
+			} else {
+				mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_3414,
+						   HPD_OVR_EN_DP_TRANS_P0_MASK,
+						   HPD_OVR_EN_DP_TRANS_P0_MASK);
+				mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_3414,
+						   HPD_SET_DP_TRANS_P0_MASK,
+						   HPD_SET_DP_TRANS_P0_MASK);
+				train_info->cable_plugged_in = true;
+			}
+			mtk_dp->hpd_state = status;
+		}
+	}
+}
+
 static const struct drm_bridge_funcs mtk_dp_bridge_funcs = {
 	.atomic_check = mtk_dp_bridge_atomic_check,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
@@ -2566,6 +2631,7 @@ static const struct drm_bridge_funcs mtk_dp_bridge_funcs = {
 	.mode_valid = mtk_dp_bridge_mode_valid,
 	.edid_read = mtk_dp_edid_read,
 	.detect = mtk_dp_bdg_detect,
+	.hpd_notify = mtk_dp_bridge_hpd_notify,
 };
 
 static void mtk_dp_debounce_timer(struct timer_list *t)
@@ -2800,9 +2866,6 @@ static int mtk_dp_probe(struct platform_device *pdev)
 		mtk_dp_initialize_aux_settings(mtk_dp);
 		mtk_dp_power_enable(mtk_dp);
 
-		/* Disable HW interrupts: we don't need any for eDP */
-		mtk_dp_hwirq_enable(mtk_dp, false);
-
 		/*
 		 * Power on the AUX to allow reading the EDID from aux-bus:
 		 * please note that it is necessary to call power off in the
@@ -2861,10 +2924,15 @@ static int mtk_dp_suspend(struct device *dev)
 	struct mtk_dp *mtk_dp = dev_get_drvdata(dev);
 
 	mtk_dp_power_disable(mtk_dp);
-	if (mtk_dp->bridge.type != DRM_MODE_CONNECTOR_eDP)
+
+	if (mtk_dp->bridge.type == DRM_MODE_CONNECTOR_eDP) {
 		mtk_dp_hwirq_enable(mtk_dp, false);
-	pm_runtime_put_sync(dev);
+	} else {
+		mtk_dp_swirq_hpd_interrupt_set(mtk_dp, MTK_DP_HPD_DISCONNECT);
+		mtk_dp_swirq_enable(mtk_dp, false);
+	}
 
+	pm_runtime_put_sync(dev);
 	return 0;
 }
 
@@ -2874,8 +2942,14 @@ static int mtk_dp_resume(struct device *dev)
 
 	pm_runtime_get_sync(dev);
 	mtk_dp_init_port(mtk_dp);
-	if (mtk_dp->bridge.type != DRM_MODE_CONNECTOR_eDP)
+
+	if (mtk_dp->bridge.type == DRM_MODE_CONNECTOR_eDP) {
 		mtk_dp_hwirq_enable(mtk_dp, true);
+	} else {
+		mtk_dp_swirq_hpd_interrupt_set(mtk_dp, MTK_DP_HPD_CONNECT);
+		mtk_dp_swirq_enable(mtk_dp, true);
+	}
+
 	mtk_dp_power_enable(mtk_dp);
 
 	return 0;
diff --git a/drivers/gpu/drm/mediatek/mtk_dp_reg.h b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
index 8ad7a9cc259e..7c97e230be50 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp_reg.h
+++ b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
@@ -286,7 +286,10 @@
 #define POST_MISC_DATA_LANE1_OV_DP_TRANS_P0_MASK		BIT(9)
 #define POST_MISC_DATA_LANE2_OV_DP_TRANS_P0_MASK		BIT(10)
 #define POST_MISC_DATA_LANE3_OV_DP_TRANS_P0_MASK		BIT(11)
+#define MTK_DP_TRANS_P0_35C0				0x35c0
+#define MTK_DP_TRANS_P0_35C4				0x35c4
 #define MTK_DP_TRANS_P0_35C8				0x35c8
+#define SW_IRQ_SET_DP_TRANS_P0_MASK				GENMASK(15, 0)
 #define SW_IRQ_CLR_DP_TRANS_P0_MASK				GENMASK(15, 0)
 #define SW_IRQ_STATUS_DP_TRANS_P0_MASK				GENMASK(15, 0)
 #define MTK_DP_TRANS_P0_35D0				0x35d0
-- 
2.23.0


