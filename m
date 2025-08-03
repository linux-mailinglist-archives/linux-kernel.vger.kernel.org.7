Return-Path: <linux-kernel+bounces-754369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 164F8B19376
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 12:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D57554E022E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 10:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8498118786A;
	Sun,  3 Aug 2025 10:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+/6aoKS"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A8425776
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 10:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754217190; cv=none; b=gvhb5oKEs31FhAIB3mCDKZiQdcT962A3JfMDYQLFuAdngL60O0HAVp6nGU6g10Q8PhzzomS/tqS8/G4tXsN9q/c5l0cJ6akFEZSjboFonksG82EZmPkG0mSpZVsRoGh8VUftPajMPQ0HBNY2yv0eqB+yrCgjjf8x7JoJ9Tz15MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754217190; c=relaxed/simple;
	bh=wpLTRM4pv0Bwd4+EuEF//nrd2cM3Z6xIcUysX/wm9QQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DGtyRUtTpDwwRirDbkj8yi2qRb4KhOxFUM6Uxj3Hi7uywYPF1CJighRdc6hKMfc0mvxixExMgBwexP37kTA0Uz/upf/1UlC+BR5+8l4IKN35MGd7uYUZlw0McwgbAsiO+4mli6WZsnqSGb5lFfv/iL5DclRkfyaf+f2+F9mfh94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+/6aoKS; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-af66f444488so430204366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 03:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754217187; x=1754821987; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4oRnuP4jSrdJzDgvqaR3lx1iHlupn4sHr1B/8K6MSts=;
        b=W+/6aoKSBSqDRflydAzyQ3g38r1hFS3yqMwHF3V6U1spV1dQ/xW5NSaFtph5X8LL1B
         4IGFLxM3RDVsSa/m4n4+wILwQOBZbfl3zGnVs3uboiP/0B2K+W+wRXXPFhcTVukOsvjH
         gk1oLa7/q8cVUXJKnhZuDGXI1547xN8DaXCucgZ8/H7fshlgc8e1Pzyk92hyF7K9vlpz
         oUy05T46f3tPBctQ+83mgcYUcKuZVAsF5m+TRO09vi6MaXsmwI2w8/jfwfN1Y3qo3LxZ
         nbOqKi+ty3RzuvjTvuCDyqEwE4DvmIQskV7UQDr3nZn4q0XHHc9fDQoSxZSJ0f2W8OJf
         Zp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754217187; x=1754821987;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4oRnuP4jSrdJzDgvqaR3lx1iHlupn4sHr1B/8K6MSts=;
        b=oYM7NqM08VqcWUQr/3kz+bjRuAZkQX5bcGTw7y+LATxsRpBjw6pjUH9AlBOGPlTh0j
         Z/MYpAR92V0ePAwe43D7Fz/zGHDHEXfzdk7iR0uEXMuPbBvfYVFTPuL12GBYMYz/YlHi
         iSuBkqvGVSD0qved+3wpBGPs5fLWRKC8W5qwJCMGMc841wQr4zB6hOgzcpJFj2k4/Tth
         luovaqCkQpzj8Ue7x6Ha9Uy6uBFzqSuuZa/VOlEavdBL2AIJQm0u5DdunJ35rxVAcjBZ
         yZa9fB7ihXhcqpqMiBrn5qRajvj/DhWW6qhaFt+dGdojJ2LFl8qntm9nYssaX0Qwd9xW
         ddPg==
X-Forwarded-Encrypted: i=1; AJvYcCVeAk5y4WFs1soVKixV22EhYnMo8rOoCKYmlcLvnOID5krzJUKJYqtTdHxIVxBz2Bypeiau1CRUrGxkse0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaGsaNzNzfa0wihKUFL7f/+yFylaKQPA7HohAdWbuskuojAHP2
	gyVHnUo6LYywW6Er+XxUw6vsOhbRbSBlCxlBpRYJkymG/dkaO2HKFZ+f/TOfoAgpV3soO0/YfVK
	arVTkJX4D21YuUAkCpn0nafK5fDoEZas=
X-Gm-Gg: ASbGncuH0fnr5ErG+ZiJ99LTTiSVZFRS94/NftQeLP56N+Wc+pRb2oj0VPNKb5hzNjm
	xlncurWZyVYgJOy8bwijtWTZM0SzMZxATxgxQIxsTr/zAPFhD0rszzBBAk3gegWQdxOyuBTpkSb
	CPDDCAZvYhnyrEqQrSf1tfr1GQISJUoFzH9w8FbxknANiLA0YV9yl9i1jRnoeadSycFKcfyxtTv
	MbwtENwEE7Yjb+/HRItK2+Bc85G7F52EtYcj+v/Pw==
X-Google-Smtp-Source: AGHT+IEsiLjMRyXYhncxuci92btZ+xh5rvmcRX5wKkTyopgH/WMz7bhDERZr/gb2/fxeD2QWq8Haa1xO8DxrAysRNyE=
X-Received: by 2002:a17:907:7fa3:b0:af9:3d0a:f38f with SMTP id
 a640c23a62f3a-af93fd64bf3mr624693166b.0.1754217186911; Sun, 03 Aug 2025
 03:33:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Haru Zheng <towwy321@gmail.com>
Date: Sun, 3 Aug 2025 18:32:55 +0800
X-Gm-Features: Ac12FXzIOcl_0A4Ih1a8nY3gchgr3V34vE8-EiuwlXia7lYUBWk08DLPwS9N9FI
Message-ID: <CACw2aoTa8KU-KkxqA10OeVK+yV7t-B94KDa4Odi1sbpY6qAENg@mail.gmail.com>
Subject: [PATCH] drm/mediatek: dp: Fix suspend/resume training failure
To: granquet@baylibre.com, "ck.hu@mediatek.com" <ck.hu@mediatek.com>, 
	"msp@baylibre.com" <msp@baylibre.com>, 
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>, 
	"airlied@gmail.com" <airlied@gmail.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, chunkuang.hu@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	rex-bc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"

From 4919bd858cd9cba8e4aadba7c3d1fd434ef3b09e Mon Sep 17 00:00:00 2001
From: Haru Zheng <towwy321@gmail.com>
Date: Wed, 18 Jun 2025 11:28:37 +0800
Subject: [PATCH] drm/mediatek: dp: Fix suspend/resume training failure

When suspending and resuming DisplayPort via Type-C,
link training may fail.

This patch backports the software IRQ handling for DP,
as eDP uses hardware IRQ while DP uses software IRQ.
Additionally, cable_plugged_in is flipped in
mtk_dp_hpd_event to ensure correct hotplug detection
during resume.

These changes fix the DP training failure after suspend/resume.

Fixes: f70ac097a2cf ("drm/mediatek: Add MT8195 Embedded DisplayPort driver")
Tested-on: Genio G700 EVK
Signed-off-by: Haru Zheng <towwy321@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c     | 100 ++++++++++++++++++++++++--
 drivers/gpu/drm/mediatek/mtk_dp_reg.h |   3 +
 2 files changed, 96 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c
b/drivers/gpu/drm/mediatek/mtk_dp.c
index bef6eeb30d3e..0cfe792bc36d 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -1012,6 +1012,16 @@ static u32 mtk_dp_swirq_get_clear(struct mtk_dp *mtk_dp)
  return irq_status;
 }

+static void mtk_dp_swirq_enable(struct mtk_dp *mtk_dp, bool enable)
+{
+ if (enable)
+ mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_35C4, 0,
+    SW_IRQ_FINAL_STATUS_DP_TRANS_P0_MASK);
+ else
+ mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_35C4, 0xFFFF,
+    SW_IRQ_FINAL_STATUS_DP_TRANS_P0_MASK);
+}
+
 static u32 mtk_dp_hwirq_get_clear(struct mtk_dp *mtk_dp)
 {
  u32 irq_status = (mtk_dp_read(mtk_dp, MTK_DP_TRANS_P0_3418) &
@@ -1751,6 +1761,8 @@ static int mtk_dp_parse_capabilities(struct
mtk_dp *mtk_dp)
      mtk_dp->train_info.sink_ssc)
  return 0;

+ memset(mtk_dp->rx_cap, 0, DP_RECEIVER_CAP_SIZE);
+
  ret = drm_dp_read_dpcd_caps(&mtk_dp->aux, mtk_dp->rx_cap);
  if (ret < 0)
  return ret;
@@ -2031,8 +2043,8 @@ static irqreturn_t mtk_dp_hpd_event(int hpd, void *dev)
  spin_unlock_irqrestore(&mtk_dp->irq_thread_lock, flags);

  if (cable_sta_chg) {
- if (!!(mtk_dp_read(mtk_dp, MTK_DP_TRANS_P0_3414) &
-        HPD_DB_DP_TRANS_P0_MASK))
+ if (!(mtk_dp_read(mtk_dp, MTK_DP_TRANS_P0_3414) &
+       HPD_DB_DP_TRANS_P0_MASK))
  mtk_dp->train_info.cable_plugged_in = true;
  else
  mtk_dp->train_info.cable_plugged_in = false;
@@ -2265,6 +2277,41 @@ static ssize_t mtk_dp_aux_transfer(struct
drm_dp_aux *mtk_aux,
  return ret;
 }

+static void mtk_dp_swirq_hpd(struct mtk_dp *mtk_dp, u8 conn)
+{
+ u32 data;
+
+ data = mtk_dp_read(mtk_dp, MTK_DP_TRANS_P0_3414);
+
+ mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_3414,
+    HPD_OVR_EN_DP_TRANS_P0_MASK,
+    HPD_OVR_EN_DP_TRANS_P0_MASK);
+
+ if (conn)
+ mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_3414,
+    HPD_SET_DP_TRANS_P0_MASK,
+    HPD_SET_DP_TRANS_P0_MASK);
+ else
+ mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_3414,
+    0,
+    HPD_SET_DP_TRANS_P0_MASK);
+}
+
+static void mtk_dp_swirq_hpd_interrupt_set(struct mtk_dp *mtk_dp, u8 status)
+{
+ dev_info(mtk_dp->dev, "[DPTX] status:%d [2:DISCONNECT, 4:CONNECT]\n", status);
+
+ if (status == MTK_DP_HPD_CONNECT) {
+ mtk_dp_init_port(mtk_dp);
+ mtk_dp_swirq_hpd(mtk_dp, TRUE);
+ } else {
+ mtk_dp_swirq_hpd(mtk_dp, FALSE);
+ }
+
+ mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_35C0, status,
+    SW_IRQ_SET_DP_TRANS_P0_MASK);
+}
+
 static int mtk_dp_poweron(struct mtk_dp *mtk_dp)
 {
  int ret;
@@ -2534,7 +2581,7 @@ static int mtk_dp_bridge_atomic_check(struct
drm_bridge *bridge,

  dev_dbg(mtk_dp->dev, "input format 0x%04x, output format 0x%04x\n",
  bridge_state->input_bus_cfg.format,
- bridge_state->output_bus_cfg.format);
+ bridge_state->output_bus_cfg.format);

  if (input_bus_format == MEDIA_BUS_FMT_YUYV8_1X16)
  mtk_dp->info.format = DP_PIXELFORMAT_YUV422;
@@ -2552,6 +2599,30 @@ static int mtk_dp_bridge_atomic_check(struct
drm_bridge *bridge,
  return 0;
 }

+static void mtk_dp_bridge_hpd_notify(struct drm_bridge *bridge,
+      enum drm_connector_status status)
+{
+ struct mtk_dp *mtk_dp = mtk_dp_from_bridge(bridge);
+ struct mtk_dp_train_info *train_info = &mtk_dp->train_info;
+
+ if (mtk_dp->bridge.type != DRM_MODE_CONNECTOR_eDP) {
+ if (mtk_dp->hpd_state != status) {
+ if (status == connector_status_disconnected) {
+ train_info->cable_plugged_in = false;
+ } else {
+ mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_3414,
+    HPD_OVR_EN_DP_TRANS_P0_MASK,
+    HPD_OVR_EN_DP_TRANS_P0_MASK);
+ mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_3414,
+    HPD_SET_DP_TRANS_P0_MASK,
+    HPD_SET_DP_TRANS_P0_MASK);
+ train_info->cable_plugged_in = true;
+ }
+ mtk_dp->hpd_state = status;
+ }
+ }
+}
+
 static const struct drm_bridge_funcs mtk_dp_bridge_funcs = {
  .atomic_check = mtk_dp_bridge_atomic_check,
  .atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
@@ -2801,7 +2872,8 @@ static int mtk_dp_probe(struct platform_device *pdev)
  mtk_dp_power_enable(mtk_dp);

  /* Disable HW interrupts: we don't need any for eDP */
- mtk_dp_hwirq_enable(mtk_dp, false);
+ mtk_dp_hwirq_enable(mtk_dp, true);
+ mtk_dp_swirq_enable(mtk_dp, false);

  /*
  * Power on the AUX to allow reading the EDID from aux-bus:
@@ -2829,6 +2901,9 @@ static int mtk_dp_probe(struct platform_device *pdev)
  }
  }
  } else {
+ mtk_dp_swirq_enable(mtk_dp, false);
+ mtk_dp_hwirq_enable(mtk_dp, false);
+ mtk_dp_swirq_enable(mtk_dp, true);
  mtk_dp->bridge.ops = DRM_BRIDGE_OP_DETECT |
       DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_HPD;
  ret = devm_drm_bridge_add(dev, &mtk_dp->bridge);
@@ -2861,10 +2936,15 @@ static int mtk_dp_suspend(struct device *dev)
  struct mtk_dp *mtk_dp = dev_get_drvdata(dev);

  mtk_dp_power_disable(mtk_dp);
- if (mtk_dp->bridge.type != DRM_MODE_CONNECTOR_eDP)
+
+ if (mtk_dp->bridge.type == DRM_MODE_CONNECTOR_eDP) {
  mtk_dp_hwirq_enable(mtk_dp, false);
- pm_runtime_put_sync(dev);
+ } else {
+ mtk_dp_swirq_hpd_interrupt_set(mtk_dp, MTK_DP_HPD_DISCONNECT);
+ mtk_dp_swirq_enable(mtk_dp, false);
+ }

+ pm_runtime_put_sync(dev);
  return 0;
 }

@@ -2874,8 +2954,14 @@ static int mtk_dp_resume(struct device *dev)

  pm_runtime_get_sync(dev);
  mtk_dp_init_port(mtk_dp);
- if (mtk_dp->bridge.type != DRM_MODE_CONNECTOR_eDP)
+
+ if (mtk_dp->bridge.type == DRM_MODE_CONNECTOR_eDP) {
  mtk_dp_hwirq_enable(mtk_dp, true);
+ } else {
+ mtk_dp_swirq_hpd_interrupt_set(mtk_dp, MTK_DP_HPD_CONNECT);
+ mtk_dp_swirq_enable(mtk_dp, true);
+ }
+
  mtk_dp_power_enable(mtk_dp);

  return 0;
diff --git a/drivers/gpu/drm/mediatek/mtk_dp_reg.h
b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
index 8ad7a9cc259e..7c97e230be50 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp_reg.h
+++ b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
@@ -286,7 +286,10 @@
 #define POST_MISC_DATA_LANE1_OV_DP_TRANS_P0_MASK BIT(9)
 #define POST_MISC_DATA_LANE2_OV_DP_TRANS_P0_MASK BIT(10)
 #define POST_MISC_DATA_LANE3_OV_DP_TRANS_P0_MASK BIT(11)
+#define MTK_DP_TRANS_P0_35C0 0x35c0
+#define MTK_DP_TRANS_P0_35C4 0x35c4
 #define MTK_DP_TRANS_P0_35C8 0x35c8
+#define SW_IRQ_SET_DP_TRANS_P0_MASK GENMASK(15, 0)
 #define SW_IRQ_CLR_DP_TRANS_P0_MASK GENMASK(15, 0)
 #define SW_IRQ_STATUS_DP_TRANS_P0_MASK GENMASK(15, 0)
 #define MTK_DP_TRANS_P0_35D0 0x35d0
-- 
2.45.2

