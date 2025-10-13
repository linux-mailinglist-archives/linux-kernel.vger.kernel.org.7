Return-Path: <linux-kernel+bounces-850181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3A6BD22B2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24811891737
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603DC2FBE1B;
	Mon, 13 Oct 2025 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yHoTsjjd"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CD92FB622
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760345753; cv=none; b=tstUkys9Uw0YoOmWF2v7PH9JuRU+tak9vSRTFwgDhYPzWFHPkaxPfDNrmBKjpe1m4d4DZInXls0hU5Wjy40DmIz6I457/RixNCz+8apP4HRhnfuB4vIMNwcqPrQYPjK2JiJiV4C/uFIDiEUXlJJ3ZJGPmq+5gkoY4+OLS0S1ocw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760345753; c=relaxed/simple;
	bh=aPV0KuIxCTXWbNGZkLEcxbshB79S+o1IdnN8zZ1ul6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lFJOpSkUxAZggvsNHvQ/IGikv5Q3Vd2xZRcfRXWDksAxgM91jICX2cu9S8DlbB4pqynYaOT+lp/iJ2MiAS1inWD36tPfLiGkeszCAzqEcyUHdV5hDlW5FA61oXD7uit1ZMEF12l95ZNtd3uNAg5xd8tX4cOqZZub78oBvBdDKWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yHoTsjjd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e6674caa5so19775545e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760345749; x=1760950549; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+s3SE4zp4gJNrXwzm2LtDr1Hi5y/USSWqn+FVGoYHw=;
        b=yHoTsjjdL5lbFWV/Hw8crIHbaeA7gbDWGHnqQvzB/jzfU+cLx/OUjFAdUQpB4tJzVf
         xxrDH+X5YwHqI4T4+5+gAGrJPwVBEBMDD1l3GDFcfdeRMXJw3Lz5WHBlpHQNF0YUzNIZ
         QBakJySW4VUJgwnBy0UH/BzG+bP1v1jXipeNZQeFfYlBGtIaZtFQPJK8q+f0HXlW3DOo
         XsM1CaHZYaHs6wqL/zuwV4CwQdtOFdwlSPYCtJ3JXSvMmzKMPztKqIvyr4XWUylL2lTt
         jva8KuliVKGqsLMTxnl8n2WVpTf0EOP/UTN1AUtHg6p9S5kfRnKFiKQCE6gQv1Cwp4nM
         DAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760345749; x=1760950549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+s3SE4zp4gJNrXwzm2LtDr1Hi5y/USSWqn+FVGoYHw=;
        b=VJiBPErHA99Bm5EVfXd7hsQkTt9YHJc2/IF8OwTD5zYaQ78f/XNWA+5aUmVwXx0iGI
         hjlWNGkEkv1x8977iTrcK7mBsl4YjRPM1brK1HEq05prIrIhJHP+a9m3DMpkSbiKAhwu
         jOR3nL+AsMSS7vJhyqPLUUBtV3chvHTr2kITvl4664IHAo1QQI8g+VVfSTcHpt+6cIF0
         NGCHCmwH2kfpq5DhO5kntO4UAtjNqCB8nqrnGTxuVHUa9hYqS1tQhoABoile6sDiPtoG
         a0DkNHVezzjlSgz8tTVierNH0uD8m4PuhX7HbedDoGkkvrWeHzwl9FaprQSxkVSYuJTz
         EoYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPlsBRNRUsOX/DO9AT+X7loweb1Q04ochGhEu20WuRrnLF8gwm28T5+GlGhmqf3JlBHVGMknzUvTAjmYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+FC5QVqFchey7rwUFunDaeS2OGDqqSEpH2UU/7yicUDssQpwb
	wswMs//bi/OtYd/iYM5T0F91HiD7OMfut8Ghg78JiBFJw5G+hAyt8UfYX9UY9oNe2mk=
X-Gm-Gg: ASbGncsBzimngM3XWhb0qlPnQLmrAguHHPKzaUm/W21OvOnwaTl9u1PtfUzLwp9th0v
	NuNAvNandtIMdz44lSiRgr5JtiBCgjKY846InaJkO+BCMxsrjziBruqC3xCzw3+jxDM5XHHu4JQ
	E84NLYHfSvteDxPgC49r+3aO6HD1qfU+Ym7bkOiY7bYpPlvDgrX4j9QZgkv/TBmAD2aHmY38LH3
	PbNWrRov/nrZr3CYjiyyDbwtD4wCU9lr9FEvfSuJavlFMj3PjTZ8z0E44eUlSmAGwuclKvXqTtY
	+gvl8j7mieTVBm4yi9j2MIki2qh3NKAqkHI0lg33xkH/ajXjwP9mhWW5oO4KLRXGvFbGmVGy+aV
	ndnMXNZOzEP24HPKK2DRtmNyalyI3Jm39EuBG5msXqW5tgOoZnnE6oMqX+E3jNynlrQ==
X-Google-Smtp-Source: AGHT+IF8zX+iEDLUhdo9DD2vye+splloAOH7RyP+gOGGF/Nj416E0M49/B5BB15Rg7A9cB8ueAZgJA==
X-Received: by 2002:a05:600c:83c6:b0:45d:dc10:a5ee with SMTP id 5b1f17b1804b1-46fa9ec7727mr141176015e9.15.1760345749332;
        Mon, 13 Oct 2025 01:55:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb482b99fsm180016185e9.3.2025.10.13.01.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 01:55:49 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 13 Oct 2025 10:55:45 +0200
Subject: [PATCH v6 2/3] phy: qcom: qmp-combo: get the USB3 & DisplayPort
 lanes mapping from DT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-topic-x1e80100-hdmi-v6-2-3a9c8f7506d6@linaro.org>
References: <20251013-topic-x1e80100-hdmi-v6-0-3a9c8f7506d6@linaro.org>
In-Reply-To: <20251013-topic-x1e80100-hdmi-v6-0-3a9c8f7506d6@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6667;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=aPV0KuIxCTXWbNGZkLEcxbshB79S+o1IdnN8zZ1ul6Y=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo7L6SVGqHqmAL9KVP4fwdspH2Ioag9satNKDmuN0z
 H/q13tmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaOy+kgAKCRB33NvayMhJ0ZOGD/
 9eWkIYFzgkEo4AiZwLzz34XG3CEZc4mZvzgcoW/skL8zoka9gFC7v6QyX1Pu7fPFRZteMzTpKi6H2e
 Kd4JHOXf4qJHSEd64zCCaWo/7omsugDsygzekqtkYFtW6aO3AjxCqHoILgtQ5p919KHgQsgRxfKLoq
 Fs4535tkf3kx5sc6+Gr8MycAoM8jpkk0Tt4mituPARdizgVVl9tlneReCCi7kR4/G0+bNEsoHZPGcL
 IDFGEogfQvJPRKbLU0P6zTHIKW6UTCBgwOwAQ2MTyfrfjbH47J5gzBtUiy9S4a9kJUI+s8L+Wz8MIk
 AxGiUx+0VAZJrbBmsz2+nij6YvuDfkyfJXvERRVMEKXQyfNr/f3UXT0dNjslzuEE/iL7CZ3qfrDHqa
 jqKaXuy/RmWd/Aaxcc4UbZ2rVxZqXKCHbdRGDYbDIFWrlhl4LmsPRqk8CuHjJxTuklOUp8OihvoRel
 N+4UjiOSkG4fgNesWHHQkwdyx0QTMQpqK4vlpHiHGY12nSwUuxpG89Lp5sxb4+r9zcFz43UJCq31/Y
 XXlY28GticpnuOzVe1ihU28NkzW5pHFczPSEXTWw91n7jATDLo8J6nJJK6tv6htfUap0rRrgbX5pHo
 1PooAPF2NLue7KVz6NQWuXUQyB/nL2VlwSg+rPtq7Kp+LcWPQS6BbeUzwneA==
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
Tested-by: Xilin Wu <sophon@radxa.com> # qcs6490-radxa-dragon-q6a
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 142 ++++++++++++++++++++++++++++--
 1 file changed, 134 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 7b5af30f1d028c592500e723ecd27b54ed554709..18321f441bafb36fd53ca3904d4fbe839412156d 100644
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
@@ -4117,6 +4138,84 @@ static struct phy *qmp_combo_phy_xlate(struct device *dev, const struct of_phand
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
+	struct device_node *ep __free(device_node) = NULL;
+	int ret;
+
+	ep = of_graph_get_endpoint_by_regs(dev->of_node, 0, endpoint);
+	if (!ep)
+		return -EINVAL;
+
+	ret = of_property_count_u32_elems(ep, "data-lanes");
+	if (ret < 0)
+		return ret;
+
+	*count = ret;
+	if (*count > max)
+		return -EINVAL;
+
+	return of_property_read_u32_array(ep, "data-lanes", data_lanes,
+					  min_t(unsigned int, *count, max));
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
@@ -4167,9 +4266,41 @@ static int qmp_combo_probe(struct platform_device *pdev)
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
@@ -4189,11 +4320,6 @@ static int qmp_combo_probe(struct platform_device *pdev)
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


