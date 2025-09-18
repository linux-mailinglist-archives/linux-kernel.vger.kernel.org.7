Return-Path: <linux-kernel+bounces-795919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D06A9B3F96E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C7848029F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEF91F948;
	Tue,  2 Sep 2025 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="veoiFrQh"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC7A2EA17B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803641; cv=none; b=jAshWOfi0BxEYQYgKqgZY/HSQuOpzT8XKq/prq4B98peKdY6ujOLpyzdMCAm3VwNOPJFqzoLpAbptsdxA3afahiWcSEvkORPMJiUemt5fTbIXzWuF5zaFDAQqRGHkUhV5ufUPhJeIHLaPNxAxti78KDEUE9+ymseZQnk9f6ajU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803641; c=relaxed/simple;
	bh=R+bIubWm0CbZM++7XjFU57IsDC7CloYPz/RJjoqOA9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hCxvd2pCzi2phoUUKU8k8VZZqA7IvATeDZx/uUkfUZ2PyMJidG0GyWy6b800oenAvB6Qe2VGei9SVKKj2Jh6YPWkB1DrqMSgjGm94GL6FSnNvcjlT1/E1v73xwEGqe2M9/iPaVtzsDn8X4FTCpLhR4Yea0HD4wTvB37hEAMTM6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=veoiFrQh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b8b7ac427so11659615e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756803637; x=1757408437; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uG2Ow/KrfUPau7cUdJ1kjwBZjHHiJIe47jnJYV0FS6M=;
        b=veoiFrQhxhIsWYQwfeqa08r2CZloWX+HFYC/QwTQSm43U6XonhxBInWypsxM1jzpYx
         G2ibUp/mslTlmhw9ueR96gel2Kvhlq+bJqvr2BSXMRB0EKQ9X0c+ynKyRTeZ5W75Ep1V
         waj7GDdqcmXDMbUT4bcH6T/nhq3ca8Ec50sDOHlUzxcdgYNfpfBddUl8o+na7uNIxJ9G
         2nRXEpnAldYTs9oe8lchpzEsmF/NkTiVFqT3R8//jm2jclDv0Nvena7qPJJzDBCbbDQJ
         bODPeQGNuInbsC3ReYikG5KVjRR/VUFc48zK4e36zB9IgcrHJ/fgjiC7ucWMQB/BYDNH
         NZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756803637; x=1757408437;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uG2Ow/KrfUPau7cUdJ1kjwBZjHHiJIe47jnJYV0FS6M=;
        b=prG7xgfj14u5tpzwb2geWVvkN+66c8Ihq+pgQrxmmpnt1PfMP9zsTVd8aYuUVehqMf
         AHCEk50AMB5gkUzWdVhThwZOG+8Bdx5bFoQVaTgA7W6ntKrSuJjCNYNpuF2Fp62QFuvC
         zerK8HuSHjegY9xr9o8O490EzOL3ysgxSaXck0lqtddNvAlOhvp1w06f2w03elMCpvxx
         /bT2J9AFNAfKEfxhVsr9LqdfrGQ0Mjb9piG7z38NdpaeSbVknrgV0yxzdRZAb5eEvElu
         +hrZLs/ltOjLyzG+wOBzLoYq8s00y4P0Fl/PgI6speLzfKBLmVyC7DHMWU0Xzd8517dq
         9ApA==
X-Forwarded-Encrypted: i=1; AJvYcCWxPqwzEXHaLzBTg18K0vXdejcqC2CTFwxug1Re763cQorMIT44ESmWp2hLSh+stCMgbtpY92La3MkRwto=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4bugDQObUv/ulMku/OUhsoV02p5WzYbd2ueLqz/E+H/aJRLZD
	gOEyAPTtq3SA6KWnhPZwdtri+Y1jzsujLo+lRkgTDpvnJK+rB23QeANTXPFgMDdeDys5AgbEPR+
	mgZj8MAY=
X-Gm-Gg: ASbGncs0C7mE7uIu6wpo+WEq7j30LDRjRPijzRZroQNghrTBsI7z7ePx8h1w+1Ea/YC
	NUpxQ0RsHtwcKE2/dD+ckvb9C4WtISs50Y4MKdNFdmHfl55MZ1+iqy4jShcSiU2bgxXXfPlVUMm
	3ID/p/WNz4kNmfpKF0WRuYO3p/FpgPaFzlyDBc/0ykdkcz7R/DQQQ1S87E5TUr6vfOn7UdVN5GZ
	pLdF4rWP+MxpRrgU8+BUBjGcVGZFqQIXRXHzf1l/gT7B7V9yh1zKw/kyKTG/Bd/4S9lN/iTPVKz
	Lhsq8ys10OrJZSzxA1381yOlCDXP6f5sz5Bt2lh7u6eMwiFQDDWKxf17ERW/5oJ4kW1a7+MAbFk
	FaIMS9D7LKn+CU3+2tqFjmSPMLXtw0vgm2f5hNk9Csd4=
X-Google-Smtp-Source: AGHT+IFar9tnrVzNvRWv4vs9RDcwWH8x6/oKpKs9B26t/CVh/B1GNcOENkRhKdPDKrLb8eWA4C7nKg==
X-Received: by 2002:a05:600c:4fcd:b0:45b:7185:9e5 with SMTP id 5b1f17b1804b1-45b85525cddmr94188905e9.5.1756803637260;
        Tue, 02 Sep 2025 02:00:37 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7271cd01sm261112045e9.23.2025.09.02.02.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 02:00:36 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 02 Sep 2025 11:00:31 +0200
Subject: [PATCH v2 4/5] phy: qcom: qmp-combo: get the static lanes mapping
 from DT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-topic-x1e80100-hdmi-v2-4-f4ccf0ef79ab@linaro.org>
References: <20250902-topic-x1e80100-hdmi-v2-0-f4ccf0ef79ab@linaro.org>
In-Reply-To: <20250902-topic-x1e80100-hdmi-v2-0-f4ccf0ef79ab@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5509;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=R+bIubWm0CbZM++7XjFU57IsDC7CloYPz/RJjoqOA9w=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBotrIvrkSdnqOJO70/0vuXWzbieSL0D81n8KBphRed
 tj4KjvyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaLayLwAKCRB33NvayMhJ0RTeD/
 90ggmuB07LjRwlGik2gYLD72R3CEE3SrAzufyoqTQI+x9T3fvDYPHXUp/A0ta9zvEyAhWpKNnq2Mdt
 53lO9z69AYW1LZDM+32RjlC4he5WSPgwq+pMJmgLY70Xtg1CRi8b3DTByIFW5aWkmUpZPKI6Ri5xgp
 nmhe3r9f/o4k7eIaaQxbrQLHPBK14myFoK+GbQ+AkmUKy+PvWbcqULQqWRVuifz1IE1qr+cYDB6NpF
 IwICHTosvb1DH2pfJGR2j2pu2vD50T6Eo2HnjmBcfviNkznIqD5hIBquQ/8iZU8BQFiInEguT/T0c7
 ETm8lJcCJaQnOjuHmdeg9ab3UPHMA5grQcUiQMYKjy03lZi3Tm5aNZ2I/O943EfXrbFd9PjsMfDyWO
 pueWSoOlE7ItK2P/vV2POhuiACjdU3XXtNOqfwSVKzFpkagxo1Caf7S5SYrcIxg0ZyXbRDtLkMVfVf
 Tgpc2FK2NMYDQPvP1hhUDafXx39BjHH4QEAH9yADof3hIw5Vkn1qdh8eVsEnrEobGCdbwHFf8q6Kpk
 Do6QuVIl/SYEgOCM8/wjOoo83y5Q1ML6M4fDpW+zUBlrdeodZu4OshAjavWlG+/kNsL6dhtUzcJAi4
 fnSHrb5HAbSTLf9/1FjfXG/mBcHk1RcYd3KoW6rpzP8oRWHE9X2BKO23x35Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The QMP USB3/DP Combo PHY hosts an USB3 phy and a DP PHY on top
of a combo glue to route either lanes to the 4 shared physical lanes.

The routing of the lanes can be:
- 2 DP + 2 USB3
- 4 DP
- 2 USB3

Get the static lanes mapping from DT and stop registering the
USB-C muxes in favor of a static mode and orientation detemined
by the mapping.

This allows supporting boards with direct connection of USB3 and
DisplayPort lanes to the QMP Combo PHY lanes, not using the
USB-C Altmode feature.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 118 +++++++++++++++++++++++++++---
 1 file changed, 109 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 7b5af30f1d028c592500e723ecd27b54ed554709..9a121a61e77ed8a839fa0fb588ec379382fb63b2 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -24,6 +24,7 @@
 
 #include <drm/bridge/aux-bridge.h>
 
+#include <dt-bindings/phy/phy.h>
 #include <dt-bindings/phy/phy-qcom-qmp.h>
 
 #include "phy-qcom-qmp-common.h"
@@ -1744,6 +1745,85 @@ static const u8 qmp_dp_v6_pre_emphasis_hbr_rbr[4][4] = {
 	{ 0x22, 0xff, 0xff, 0xff }
 };
 
+static struct qmp_lanes_mapping {
+	u32 map[4];
+	enum qmpphy_mode mode;
+	enum typec_orientation orientation;
+} const qmpphy_lanes_mapping[] = {
+	/* No lanes connected, set 'safe' USB3 mode */
+	{
+		.map = {PHY_NONE, PHY_NONE, PHY_NONE, PHY_NONE},
+		.mode = QMPPHY_MODE_USB3_ONLY,
+		.orientation = TYPEC_ORIENTATION_NONE,
+	},
+	/* USB3 Only */
+	{
+		.map = {PHY_TYPE_USB3, PHY_TYPE_USB3, PHY_NONE, PHY_NONE},
+		.mode = QMPPHY_MODE_USB3_ONLY,
+		.orientation = TYPEC_ORIENTATION_NORMAL,
+	},
+	/* USB3 Only, reverted */
+	{
+		.map = {PHY_NONE, PHY_NONE, PHY_TYPE_USB3, PHY_TYPE_USB3},
+		.mode = QMPPHY_MODE_USB3_ONLY,
+		.orientation = TYPEC_ORIENTATION_REVERSE,
+	},
+	/* USB3 and DP single lane */
+	{
+		.map = {PHY_TYPE_USB3, PHY_TYPE_USB3, PHY_NONE, PHY_TYPE_DP},
+		.mode = QMPPHY_MODE_USB3DP,
+		.orientation = TYPEC_ORIENTATION_NORMAL,
+	},
+	/* USB3 and DP */
+	{
+		.map = {PHY_TYPE_USB3, PHY_TYPE_USB3, PHY_TYPE_DP, PHY_TYPE_DP},
+		.mode = QMPPHY_MODE_USB3DP,
+		.orientation = TYPEC_ORIENTATION_NORMAL,
+	},
+	/* DP single lane and USB3 */
+	{
+		.map = {PHY_TYPE_DP, PHY_NONE, PHY_TYPE_USB3, PHY_TYPE_USB3},
+		.mode = QMPPHY_MODE_USB3DP,
+		.orientation = TYPEC_ORIENTATION_REVERSE,
+	},
+	/* DP and USB3 */
+	{
+		.map = {PHY_TYPE_DP, PHY_TYPE_DP, PHY_TYPE_USB3, PHY_TYPE_USB3},
+		.mode = QMPPHY_MODE_USB3DP,
+		.orientation = TYPEC_ORIENTATION_REVERSE,
+	},
+	/* DP single lane */
+	{
+		.map = {PHY_TYPE_DP, PHY_NONE, PHY_NONE, PHY_NONE},
+		.mode = QMPPHY_MODE_DP_ONLY,
+		.orientation = TYPEC_ORIENTATION_REVERSE,
+	},
+	/* DP 2 lanes */
+	{
+		.map = {PHY_TYPE_DP, PHY_TYPE_DP, PHY_NONE, PHY_NONE},
+		.mode = QMPPHY_MODE_DP_ONLY,
+		.orientation = TYPEC_ORIENTATION_REVERSE,
+	},
+	/* DP 4 lanes */
+	{
+		.map = {PHY_TYPE_DP, PHY_TYPE_DP, PHY_TYPE_DP, PHY_TYPE_DP},
+		.mode = QMPPHY_MODE_DP_ONLY,
+		.orientation = TYPEC_ORIENTATION_NORMAL,
+	},
+	/* DP 2 lanes, reverted */
+	{
+		.map = {PHY_NONE, PHY_NONE, PHY_TYPE_DP, PHY_TYPE_DP},
+		.mode = QMPPHY_MODE_DP_ONLY,
+		.orientation = TYPEC_ORIENTATION_NORMAL,
+	},
+	/* DP single lane, reverted */
+	{
+		.map = {PHY_NONE, PHY_NONE, PHY_NONE, PHY_TYPE_DP},
+		.mode = QMPPHY_MODE_DP_ONLY,
+		.orientation = TYPEC_ORIENTATION_NORMAL,
+	},
+};
+
 struct qmp_combo;
 
 struct qmp_combo_offsets {
@@ -4123,7 +4203,7 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *dp_np, *usb_np;
 	struct phy_provider *phy_provider;
-	int ret;
+	int ret, i;
 
 	qmp = devm_kzalloc(dev, sizeof(*qmp), GFP_KERNEL);
 	if (!qmp)
@@ -4167,9 +4247,34 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_node_put;
 
-	ret = qmp_combo_typec_register(qmp);
-	if (ret)
-		goto err_node_put;
+	qmp->qmpphy_mode = QMPPHY_MODE_USB3DP;
+
+	if (of_find_property(dev->of_node, "qcom,static-lanes-mapping", NULL)) {
+		u32 mapping[4];
+
+		ret = of_property_read_u32_array(dev->of_node, "qcom,static-lanes-mapping",
+						 mapping, 4);
+		if (ret) {
+			dev_err(dev, "failed to read static lanes mapping: %d\n", ret);
+			goto err_node_put;
+		}
+
+		for (i = 0; i < ARRAY_SIZE(qmpphy_lanes_mapping); ++i) {
+			if (memcmp(mapping, &qmpphy_lanes_mapping[i].map, sizeof(mapping)))
+				continue;
+
+			qmp->qmpphy_mode = qmpphy_lanes_mapping[i].mode;
+			qmp->orientation = qmpphy_lanes_mapping[i].orientation;
+
+			break;
+		}
+		if (i == ARRAY_SIZE(qmpphy_lanes_mapping))
+			dev_warn(dev, "invalid qcom,static-lanes-mapping, keeping default\n");
+	} else {
+		ret = qmp_combo_typec_register(qmp);
+		if (ret)
+			goto err_node_put;
+	}
 
 	ret = drm_aux_bridge_register(dev);
 	if (ret)
@@ -4189,11 +4294,6 @@ static int qmp_combo_probe(struct platform_device *pdev)
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


