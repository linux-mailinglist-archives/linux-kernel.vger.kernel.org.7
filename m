Return-Path: <linux-kernel+bounces-761343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B257B1F897
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 08:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C4697A9E10
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 06:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F066221727;
	Sun, 10 Aug 2025 06:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXIXJm7c"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F488376
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 06:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754806800; cv=none; b=qo4GmAaa2XQMN/r4FSouN+6FZz0S0tcmccJU/AsJkTauB1AVF2UEWVnO/4JOA7zk+t1uIkGjh0hRtG5XtPvBaHBs5mvGCjUURzy5IcmGFHhVcgslauNdvBbbENo+MFs6dNip8/vS0iRVwaGG3qCox+rQ0q4uGRfa1HkCjg+RaFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754806800; c=relaxed/simple;
	bh=0DY9jqtMPwTGry93NUUeQnH/V2wrxjf1+a8gv75muj4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hoVdBZprPHVXKjp1HCeovq/mqHwIw8iHmeWUlo7y9fGOk3u6HcsZxvhTJij+U6octD3ASYXAPa5s0btQZXSS6ziMP6ygvTVelfSD0GnHAbOuRzYezTIt7cCE4N8qYCumgmOK28j1o/plfOaUjF6fN5yy9iALL6Gww3n29K2vPEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXIXJm7c; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b427f4a9652so3093062a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 23:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754806798; x=1755411598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iHiYD5TAx7oNSWd0V98bNdA/j3BdzqRXYpMd86EugcI=;
        b=lXIXJm7clmvs5kMB0NpuBUaoBCEJAU1VTAgw4c8eDS6A8h9n6CYz93Tq0MKjlGQ7to
         gF6vJ46PVuHyZKtg/XcQ9UGNsCpv8FLzYG6DbcWUeid+dSGTD+kNR2VWYkwXdKLigylQ
         lFUVeu7ZljBZY42LCzdHbgBj2vJ8BksymiAO3xish9cSmTfX6d13xDKfBsHH4ApyNqiI
         IPwONolLQxHtdiQ86gm569LgIWhVnXdXPEkVLGw+T3iXG7wMgZ7w8+7M3qgUFYn8K8Lg
         fziKVob2vM3docVspWWYfu+z5tydg8yG41QJhL+7H9+tKj/bM3eOfuI4lldiBs9ZwIK1
         M7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754806798; x=1755411598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iHiYD5TAx7oNSWd0V98bNdA/j3BdzqRXYpMd86EugcI=;
        b=P/TShO5Ac9GGwdTbXoGlMSdpEVnnW35KjOUJTNICvEEkjCZENflmGH2oej6juFNYcj
         kTCUPyX98IZmhbXcX9plH3Wf76lpJM5rmoxxBZeKNyp2N24NiZ+ou85jZfpDw7sCwOVc
         mFauw/IWfSNWXokyTe+2RzKYEkkWg7vsRV6fVdFaQo7v7aXs0j6m4pxfiBZYptHhptzZ
         PIRiMXKlyBqC02nEKjLLZeIQAIUoQzH2z4mb/0CEJiCB3R2f9dRH6O2s1Ja5akQseDDU
         9KoRy5Ap2+FgyWagzIxq9ClUFnmbW45agNsn8nMeJqJ1IUpYv8U39hD3DUCo8qHuvM6D
         JDqA==
X-Forwarded-Encrypted: i=1; AJvYcCXXnbZheBo7xtKD8d8JVTmBg6SoSv8LpQyFTwDa3MdWxpo/CsmBUI/mU8zdBUWk9z4oMgvbv4pHVzIFqbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKEUjK8KD2D1lxDepSZTcI36gM/m8wONs04EBpuwMyFgXmLT9U
	5YB0ldT1SLhShjozagPR8eZefN24AihdF2MxOf3d6LEZlikiyOlKyvDK
X-Gm-Gg: ASbGncsizwJJ3fBVtIqhi6ijDtPvrJXMgUEXel7plQISItDzHNAVE2ok6yGzju0HpBn
	vqB/iZ09gRYEW8ZAi/Q1LC0HK5rIQTDpHYoUdjFeOy+AXgXJnqoVv+GIuSyz9HgBir0L0UtwKtG
	ilrsRxQH5zP8LjMwvnqxiNma0MxvmhTVuP8rDc49CvmMArY7X4uBXGBFDuiF/Txw5Gzoabge+3w
	rnC3JASv/m9LVyz7q/CY+u4igk9SOTIMvpbiNzFao5jV5bikMn2WlZmnOIBYIwl32URDpvWInaN
	TTjVwwxQDkBduaoFu+C5XOzNhFGzahvmgxaP8drvwavVUyUGEhoBhMfuNOs5bGqX5utZhRA3A6c
	6GJm1SGGE4IY1aMX5BxqiZIjxYNaygQxKUJPZQPVPu803IgjKDuaGMrYbJEKtFpOU32UPgDXfKd
	Ch/6AiSnHNdy3KYWn//4WG2oR+qp8YZo/B8Tvn6Vn9I+vCwI6Gd+5PKEQ=
X-Google-Smtp-Source: AGHT+IENAQKQ8XTl+dkcliLFRwObtOaTyEJC19RE34RM0jlE+rwWy/8UzGyV6oZqdnLlbRj/GYf5Jw==
X-Received: by 2002:a17:902:ecd0:b0:234:d778:13fa with SMTP id d9443c01a7336-242c22a0364mr135754725ad.26.1754806798195;
        Sat, 09 Aug 2025 23:19:58 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e35c-3cf4-810c-15a2-7205-9994.emome-ip6.hinet.net. [2001:b400:e35c:3cf4:810c:15a2:7205:9994])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f36311sm28348371a91.34.2025.08.09.23.19.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Aug 2025 23:19:57 -0700 (PDT)
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
Subject: [PATCH v3] drm/mediatek: dp: Fix suspend/resume training failure
Date: Sun, 10 Aug 2025 14:17:38 +0800
Message-Id: <20250810061738.10977-1-towwy321@gmail.com>
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
- Corrected HW/SW IRQ logic for eDP and DP
- Fixed hotplug check logic in mtk_dp_hpd_event

Changes since v2:
- Dropped mtk_dp_bridge_hpd_notify() in favor of mtk_dp_altmode_hpd_notify()
- Removed IRQ enabling from probe() for eDP
- Restricted SW IRQ enabling to DP only, in bridge_attach()
- Corrected cable_plugged_in logic in mtk_dp_hpd_event()
- Cleaned up unused variables in mtk_dp_swirq_hpd()
- Updated comments to reflect eDP/DP IRQ separation
---
 drivers/gpu/drm/mediatek/mtk_dp.c     | 81 ++++++++++++++++++++++++---
 drivers/gpu/drm/mediatek/mtk_dp_reg.h |  5 ++
 2 files changed, 77 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 33cf9fe1ccde..5fdb319ec62c 100644
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
@@ -2265,6 +2271,31 @@ static ssize_t mtk_dp_aux_transfer(struct drm_dp_aux *mtk_aux,
 	return ret;
 }
 
+static void mtk_dp_swirq_hpd(struct mtk_dp *mtk_dp, u8 conn)
+{
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
@@ -2324,9 +2355,9 @@ static int mtk_dp_bridge_attach(struct drm_bridge *bridge,
 	mtk_dp->drm_dev = bridge->dev;
 
 	if (mtk_dp->bridge.type != DRM_MODE_CONNECTOR_eDP) {
-		irq_clear_status_flags(mtk_dp->irq, IRQ_NOAUTOEN);
-		enable_irq(mtk_dp->irq);
-		mtk_dp_hwirq_enable(mtk_dp, true);
+		/* DP does use SW IRQs */
+		mtk_dp_hwirq_enable(mtk_dp, false);
+		mtk_dp_swirq_enable(mtk_dp, true);
 	}
 
 	return 0;
@@ -2534,7 +2565,7 @@ static int mtk_dp_bridge_atomic_check(struct drm_bridge *bridge,
 
 	dev_dbg(mtk_dp->dev, "input format 0x%04x, output format 0x%04x\n",
 		bridge_state->input_bus_cfg.format,
-		bridge_state->output_bus_cfg.format);
+		 bridge_state->output_bus_cfg.format);
 
 	if (input_bus_format == MEDIA_BUS_FMT_YUYV8_1X16)
 		mtk_dp->info.format = DP_PIXELFORMAT_YUV422;
@@ -2552,6 +2583,30 @@ static int mtk_dp_bridge_atomic_check(struct drm_bridge *bridge,
 	return 0;
 }
 
+static void mtk_dp_altmode_hpd_notify(struct drm_bridge *bridge,
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
@@ -2566,6 +2621,7 @@ static const struct drm_bridge_funcs mtk_dp_bridge_funcs = {
 	.mode_valid = mtk_dp_bridge_mode_valid,
 	.edid_read = mtk_dp_edid_read,
 	.detect = mtk_dp_bdg_detect,
+	.hpd_notify = mtk_dp_altmode_hpd_notify,
 };
 
 static void mtk_dp_debounce_timer(struct timer_list *t)
@@ -2861,10 +2917,13 @@ static int mtk_dp_suspend(struct device *dev)
 	struct mtk_dp *mtk_dp = dev_get_drvdata(dev);
 
 	mtk_dp_power_disable(mtk_dp);
-	if (mtk_dp->bridge.type != DRM_MODE_CONNECTOR_eDP)
-		mtk_dp_hwirq_enable(mtk_dp, false);
-	pm_runtime_put_sync(dev);
 
+	if (mtk_dp->bridge.type != DRM_MODE_CONNECTOR_eDP) {
+		mtk_dp_swirq_hpd_interrupt_set(mtk_dp, MTK_DP_HPD_DISCONNECT);
+		mtk_dp_swirq_enable(mtk_dp, false);
+	}
+
+	pm_runtime_put_sync(dev);
 	return 0;
 }
 
@@ -2874,8 +2933,12 @@ static int mtk_dp_resume(struct device *dev)
 
 	pm_runtime_get_sync(dev);
 	mtk_dp_init_port(mtk_dp);
-	if (mtk_dp->bridge.type != DRM_MODE_CONNECTOR_eDP)
-		mtk_dp_hwirq_enable(mtk_dp, true);
+
+	if (mtk_dp->bridge.type != DRM_MODE_CONNECTOR_eDP) {
+		mtk_dp_swirq_hpd_interrupt_set(mtk_dp, MTK_DP_HPD_CONNECT);
+		mtk_dp_swirq_enable(mtk_dp, true);
+	}
+
 	mtk_dp_power_enable(mtk_dp);
 
 	return 0;
diff --git a/drivers/gpu/drm/mediatek/mtk_dp_reg.h b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
index 8ad7a9cc259e..c9a022ffd0ac 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp_reg.h
+++ b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
@@ -262,6 +262,8 @@
 #define HPD_DISC_THD_DP_TRANS_P0_MASK				GENMASK(11, 8)
 #define HPD_CONN_THD_DP_TRANS_P0_MASK				GENMASK(15, 12)
 #define MTK_DP_TRANS_P0_3414				0x3414
+#define HPD_OVR_EN_DP_TRANS_P0_MASK				BIT(0)
+#define HPD_SET_DP_TRANS_P0_MASK				BIT(1)
 #define HPD_DB_DP_TRANS_P0_MASK					BIT(2)
 #define MTK_DP_TRANS_P0_3418				0x3418
 #define IRQ_CLR_DP_TRANS_P0_MASK				GENMASK(3, 0)
@@ -286,7 +288,10 @@
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


