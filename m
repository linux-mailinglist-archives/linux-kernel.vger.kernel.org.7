Return-Path: <linux-kernel+bounces-843029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAB7BBE3E3
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 15:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF911898F66
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 13:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CED82D480F;
	Mon,  6 Oct 2025 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cMLvpT2W"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83E72D3750
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759758917; cv=none; b=RO03Muj1y+kJn5IBvVqONrW2NxP7aecTAHJ8geGmcgiTGeAv4Xx2KyD7a1D+BDMoNmXrebYUFp6vjJNKzlT6a6F4x7Dj/Iq4f5eUM4EETgSgiANqW/lN5zP9/wyrua7y6GaT+FTTFLBVx6q+ywXOAj6w9ukUH4QrBozL2BXW4xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759758917; c=relaxed/simple;
	bh=Jvq57DphFi7wtmww07r08dRLu0LQHutOYqaDw8wnv1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LKsX4xrJ7V2VoBtDK5WhwdFKvpW0ZQG6FW84bJ/t1LQ2h9cHbFbDYfAWFgI3THK1vhawXWXI+Qg+Y6pSTKCIQ5F6/nTr4sBBHU6OOVaY9OkwgTCQkTNrZzEOLOFv1G2/giOfvGZg6xpGQt8PWDQYS/hnATOkZQaVJW88Bo3rpTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cMLvpT2W; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e42deffa8so51651635e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 06:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759758914; x=1760363714; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+3PwY2Su8FGUm8I2o7iZNHQaUPPiuR6Gy8cotqp3czU=;
        b=cMLvpT2WFGB+xfYwfvbGSxh50j9y00BKrLzeAFuuXMwxOePU2p3HgXbp2n9DYmswea
         LyZy37sK9HOdVXOI+sk1Kt/YB+9uJ5NRgdcEfawh72FOo+T67hJF1muVHAe3C+9EWUYc
         Gcqec8wDKAv58xxN3COICmoLWzb63DVnTs1hCWrM6J71ZYIzmkiKUlYXBzWdZNQAkcXL
         2r3zm9H1QXaeIKqecluFgKjyTV9AxP46LA3Y/Yy63YFEBj6bgQ2K7e05NzCUt8e1e3Vx
         iP2A6e5V2Zx5iPzE5Hi1Xw9hZeZHTNgqBREc57NY1edEb52+kt8EYY+u1Vi8RdUXHc4D
         GCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759758914; x=1760363714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3PwY2Su8FGUm8I2o7iZNHQaUPPiuR6Gy8cotqp3czU=;
        b=qFphKjuv2szSnCOkur2wUD8xrocrGoZBLlH939AZTF0Hptmmy6dD1ULxNMgdK0A8bO
         C8o0r/ZsGZfWZfxonT3QpKCu+JY3s2QA7flYSzm7hZNQIe/2O888wRJMo9QFl5WjHQ3s
         18WlbwzCmnak6pI+vw0g4C/MMEAvvl/j5rL9Es5OEOraN4P+uzjVq50onfln+SkIly32
         YkeqyQdlQpktvSFMYxj5t0YWQXDg0xze18hKBwQfUz+rQDGa7ZtjVocFPVgRbMCrFQtN
         pktHcvEOru7xgHqyOq6nahqyd9y/KPRXWBJYtIG0x8rA2TsDuHNwQGvRtcN8vsAJyHpo
         9LNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCtldChDPH8wYe8KODqzVuLEPKE2j/9b5VUNqt96xX2dxKIODoGDY0SuU7qWeChg6M/BxhC/GYa4R7/b4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUHFbBm8g4+S0jWMamKJiknpSVXHabvRJlIC2CirpuBsVHuhrV
	LJc9SS9lnak1bKo0KmYUCFWhxHVjAIplyAoUEiV49gC+ipcxiA6DypKdNPP5RoflyNHkzOKEA8b
	I6bxsX7U=
X-Gm-Gg: ASbGncvrVLwNmF2adWwnw7epCLuKoncEJX0MHXCp2Z6tGqnaIKXqOWudMPEqINutmC2
	aqFMSeLx4qmA0JMxiauNd6U8PdpexT8t9+va4ijaFdD2H2tcSL+rxzO4KWfIZioYHTmwHqp+j/x
	U7G+f9N1LWrxutE89byex7jn4lwgURkKIFHYM4cNpTIT6khY9zaFesZFYo2hUVuuiYfM8EoIPnq
	Xj1OzOn4Ibdi42rTQ7Alt1+zOErvmayix5wsoQeLcc6Vmz63WkWItDia2hHVdlneSk8MwWNA273
	sRtDuhn0+HwFiElyDNJnvZJKBgPL21fCEeqU+SKLxOoykSLJudFp/vdMTgv7yJvFSlOUFk7zmiC
	MwaT38q4+rnrGQr4sUWy6/Dn38ePdcpNvzUgWizZ0ZXN7k4T7yKsVY+e0J16Bq9njG6X/qik=
X-Google-Smtp-Source: AGHT+IE1WdC9uOmXoaHZ/kUEuDfuryRH8fzwZAqkoRcIFoX1p4U9e95Adhwxwb44aVahTYfD8Cr7jA==
X-Received: by 2002:a05:600c:621a:b0:46e:2801:84aa with SMTP id 5b1f17b1804b1-46e710b22a6mr88635645e9.0.1759758913732;
        Mon, 06 Oct 2025 06:55:13 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6daasm21291921f8f.7.2025.10.06.06.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 06:55:13 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 06 Oct 2025 15:55:04 +0200
Subject: [PATCH v5 2/3] phy: qcom: qmp-combo: get the USB3 & DisplayPort
 lanes mapping from DT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-topic-x1e80100-hdmi-v5-2-c006311d59d7@linaro.org>
References: <20251006-topic-x1e80100-hdmi-v5-0-c006311d59d7@linaro.org>
In-Reply-To: <20251006-topic-x1e80100-hdmi-v5-0-c006311d59d7@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Xilin Wu <sophon@radxa.com>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6594;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Jvq57DphFi7wtmww07r08dRLu0LQHutOYqaDw8wnv1Q=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo48o+eHZS3KJP3oymWX7K6DJ1dPPz7JTIdOLexb1y
 zSySfD+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaOPKPgAKCRB33NvayMhJ0crgD/
 9+vb85Pg/4YGgVWF3VdV7Cy5RDYLMQkd0TSxBpUqpjSbZ6mOsP+HfyQS8RLO0cjc8pNizXXbsQ/Eww
 jjCRocAOQJx4kz1rSuFE0jStlrU2Zgw5oJ3iksqMjJq5u84/ZO2Nkglvmmpb3b7ao15vtG3B5XdZPA
 7R9srTMGOLe++0MEFipAIoKG+V8Z/e3o0FteEVeQuwNz03OXOvWri5kFN+JG2tvKupd1PvMktWvEfh
 toU5/SAas4fmC1nmpWNK2XnNTGoajdSgafDrzKGkKB4o/Bd1aj1MCDnNpsFFlR7KjhXudWmDoqLtYt
 5aCgRhLsNQTPo1DDhWDmobPYgYPF/y55JvLmFJY6NAm9HcU0HiUJnF/iUD27i+j2bxubJzw2TCSj1H
 HM77gQ1FGUyo9pDL7d4HLgxoUcyLb7/hPfTnp3sTpzsKa7E6KButEz2GJO/r2KIxextHrQVZTkJLKc
 67JpyooC+5QKYcTaag8xO4SgnIuHi1iBdNLz4cD5uvBeEjeW+9jlXOLm1oBa7GI0S2cq5uGTxQHcV3
 DgRNDOrHP6GP2OBURBK3vregYSeTheiVkmYYCSqz9oy10iTs6Cm9k++tV3dUMAC2YHk/FB7iEe1HXS
 GqZak7w0bdZqbuy9VNxUphFKnvnjvT7BYD2HFlsZstMaddgCwNyhhvgTzM9g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The QMP USB3/DP Combo PHY hosts an USB3 phy and a DP PHY on top
of a combo glue to route either lanes to the 4 shared physical lanes.

The routing of the lanes can be:
- 2 DP + 2 USB3
- 4 DP
- 2 USB3

Get the lanes mapping from DT and stop registering the USB-C
muxes in favor of a static mode and orientation detemined
by the lanes mapping.

This allows supporting boards with direct connection of USB3 and
DisplayPort lanes to the QMP Combo PHY lanes, not using the
USB-C Altmode feature.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 145 ++++++++++++++++++++++++++++--
 1 file changed, 137 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 7b5af30f1d028c592500e723ecd27b54ed554709..da1823fa5daf316cdec72cdb03159f02961f8545 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_graph.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
@@ -1744,6 +1745,26 @@ static const u8 qmp_dp_v6_pre_emphasis_hbr_rbr[4][4] = {
 	{ 0x22, 0xff, 0xff, 0xff }
 };
 
+struct qmp_combo_lane_mapping {
+	unsigned int lanes_count;
+	enum typec_orientation orientation;
+	u32 lanes[4];
+};
+
+static const struct qmp_combo_lane_mapping usb3_data_lanes[] = {
+	{ 2, TYPEC_ORIENTATION_NORMAL, { 1, 0 }},
+	{ 2, TYPEC_ORIENTATION_REVERSE, { 2, 3 }},
+};
+
+static const struct qmp_combo_lane_mapping dp_data_lanes[] = {
+	{ 1, TYPEC_ORIENTATION_NORMAL, { 3 }},
+	{ 1, TYPEC_ORIENTATION_REVERSE, { 0 }},
+	{ 2, TYPEC_ORIENTATION_NORMAL, { 3, 2 }},
+	{ 2, TYPEC_ORIENTATION_REVERSE, { 0, 1 }},
+	{ 4, TYPEC_ORIENTATION_NORMAL, { 3, 2, 1, 0 }},
+	{ 4, TYPEC_ORIENTATION_REVERSE, { 0, 1, 2, 3 }},
+};
+
 struct qmp_combo;
 
 struct qmp_combo_offsets {
@@ -4117,6 +4138,87 @@ static struct phy *qmp_combo_phy_xlate(struct device *dev, const struct of_phand
 	return ERR_PTR(-EINVAL);
 }
 
+static void qmp_combo_find_lanes_orientation(const struct qmp_combo_lane_mapping *mapping,
+					     unsigned int mapping_count,
+					     u32 *lanes, unsigned int lanes_count,
+					     enum typec_orientation *orientation)
+{
+	int i;
+
+	for (i = 0; i < mapping_count; i++) {
+		if (mapping[i].lanes_count != lanes_count)
+			continue;
+		if (!memcmp(mapping[i].lanes, lanes, sizeof(u32) * lanes_count)) {
+			*orientation = mapping[i].orientation;
+			return;
+		}
+	}
+}
+
+static int qmp_combo_get_dt_lanes_mapping(struct device *dev, unsigned int endpoint,
+					  u32 *data_lanes, unsigned int max,
+					  unsigned int *count)
+{
+	struct device_node *ep;
+	int ret;
+
+	ep = of_graph_get_endpoint_by_regs(dev->of_node, 0, endpoint);
+	if (!ep)
+		return -EINVAL;
+
+	ret = of_property_count_u32_elems(ep, "data-lanes");
+	if (ret < 0)
+		goto err_node_put;
+
+	*count = ret;
+
+	ret = of_property_read_u32_array(ep, "data-lanes", data_lanes,
+					 max_t(unsigned int, *count, max));
+
+err_node_put:
+	of_node_put(ep);
+
+	return ret;
+}
+
+static int qmp_combo_get_dt_dp_orientation(struct device *dev,
+					     enum typec_orientation *orientation)
+{
+	unsigned int count;
+	u32 data_lanes[4];
+	int ret;
+
+	/* DP is described on the first endpoint of the first port */
+	ret = qmp_combo_get_dt_lanes_mapping(dev, 0, data_lanes, 4, &count);
+	if (ret < 0)
+		return ret == -EINVAL ? 0 : ret;
+
+	/* Search for a match and only update orientation if found */
+	qmp_combo_find_lanes_orientation(dp_data_lanes, ARRAY_SIZE(dp_data_lanes),
+					 data_lanes, count, orientation);
+
+	return 0;
+}
+
+static int qmp_combo_get_dt_usb3_orientation(struct device *dev,
+					     enum typec_orientation *orientation)
+{
+	unsigned int count;
+	u32 data_lanes[2];
+	int ret;
+
+	/* USB3 is described on the second endpoint of the first port */
+	ret = qmp_combo_get_dt_lanes_mapping(dev, 1, data_lanes, 2, &count);
+	if (ret < 0)
+		return ret == -EINVAL ? 0 : ret;
+
+	/* Search for a match and only update orientation if found */
+	qmp_combo_find_lanes_orientation(usb3_data_lanes, ARRAY_SIZE(usb3_data_lanes),
+					 data_lanes, count, orientation);
+
+	return 0;
+}
+
 static int qmp_combo_probe(struct platform_device *pdev)
 {
 	struct qmp_combo *qmp;
@@ -4167,9 +4269,41 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_node_put;
 
-	ret = qmp_combo_typec_register(qmp);
-	if (ret)
-		goto err_node_put;
+	qmp->qmpphy_mode = QMPPHY_MODE_USB3DP;
+
+	if (of_property_present(dev->of_node, "mode-switch") ||
+	    of_property_present(dev->of_node, "orientation-switch")) {
+		ret = qmp_combo_typec_register(qmp);
+		if (ret)
+			goto err_node_put;
+	} else {
+		enum typec_orientation dp_orientation = TYPEC_ORIENTATION_NONE;
+		enum typec_orientation usb3_orientation = TYPEC_ORIENTATION_NONE;
+
+		ret = qmp_combo_get_dt_dp_orientation(dev, &dp_orientation);
+		if (ret)
+			goto err_node_put;
+
+		ret = qmp_combo_get_dt_usb3_orientation(dev, &usb3_orientation);
+		if (ret)
+			goto err_node_put;
+
+		if (dp_orientation == TYPEC_ORIENTATION_NONE &&
+		    usb3_orientation != TYPEC_ORIENTATION_NONE) {
+			qmp->qmpphy_mode = QMPPHY_MODE_USB3_ONLY;
+			qmp->orientation = usb3_orientation;
+		} else if (usb3_orientation == TYPEC_ORIENTATION_NONE &&
+			 dp_orientation != TYPEC_ORIENTATION_NONE) {
+			qmp->qmpphy_mode = QMPPHY_MODE_DP_ONLY;
+			qmp->orientation = dp_orientation;
+		} else if (dp_orientation != TYPEC_ORIENTATION_NONE &&
+			 dp_orientation == usb3_orientation) {
+			qmp->qmpphy_mode = QMPPHY_MODE_USB3DP;
+			qmp->orientation = dp_orientation;
+		} else {
+			dev_warn(dev, "unable to determine orientation & mode from data-lanes");
+		}
+	}
 
 	ret = drm_aux_bridge_register(dev);
 	if (ret)
@@ -4189,11 +4323,6 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_node_put;
 
-	/*
-	 * The hw default is USB3_ONLY, but USB3+DP mode lets us more easily
-	 * check both sub-blocks' init tables for blunders at probe time.
-	 */
-	qmp->qmpphy_mode = QMPPHY_MODE_USB3DP;
 
 	qmp->usb_phy = devm_phy_create(dev, usb_np, &qmp_combo_usb_phy_ops);
 	if (IS_ERR(qmp->usb_phy)) {

-- 
2.34.1


