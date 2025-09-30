Return-Path: <linux-kernel+bounces-837282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9A4BABDBC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E17A1925571
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D892BF012;
	Tue, 30 Sep 2025 07:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b4PK/guh"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFDB27F01D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759217997; cv=none; b=T6Ob+sofl4q2gvHr7uA2CJAN69Keiqz2UJt5IlG98ysO6Fc9gozdCCDBBbv280YEkZjXsjB3olmHRK+1G8ZJHKDMaMNjW8dKQWVO/MTrCSbFECR3eyudyo3uMCY2vvXcOXb0e0L7AzI7WnypGjoBPS1hn9Aa9yT1dxRfCBYdnPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759217997; c=relaxed/simple;
	bh=g7Iz7iBAofGT0xX6ovoXpuwBLIN329RO4dbf43CapJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c0oy2D0esCL9yVHF1tTAczoPLp8Dg+U2il324xV3ewN8htliEpUfVBbPIeSmiLfZBHFGmV1J84ksK+EBGFhFEYCfHG1avYyefiJHSFSl6KF+pZQRJMceJdAdIs5x4pXuj9aajAWCX9rJTy7G/HjXvG5OlWlTVM2VAk4whQZFLUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b4PK/guh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e317bc647so35526315e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759217994; x=1759822794; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/AW1ctYNPwGkF6JSa7A5Ncb8daKyZj2q8cgernXaO9g=;
        b=b4PK/guh1xeIdEnPHI3MdGUBIV6i7zKoN7JqS3K3/WUA/GGGEzEKmlmTilmhM0m4ae
         hCO8tk6Qwl6HL6T/rXyyT9CiAgGGY1Byj2G1p4ImAlqfE0ENjN2rVYDCbnNg5wrbVLpK
         c3KG6X9wpTlghNc14v5l+ejWNCm8Hh0m/84oKDDyn8h/xquc0KsAlijJ0+wRgv5cpjQx
         LfzXD8oU7i4/db8LPhHxG3Dck97rVM7AYKe0g1ai3B9udfDYb/I6qSVzqMnGoxuu+xNh
         w0ZRrZA8hgkD8AZCeZTxnvvZM5XrsDU/2zBr5w44LWHYXjpiC9L2Ln/zhE16kY+1Ln7R
         aFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759217994; x=1759822794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AW1ctYNPwGkF6JSa7A5Ncb8daKyZj2q8cgernXaO9g=;
        b=VJkKJBJWWMY+6pt3R47Uc93ZmZPfPYfYb1DfeSU82ADuP/I3ivIvaWsRlfH85F71jz
         h+sach3ZVxt0E+OhX8eSue8yLunsdWBCmQiHEW+fGjmf0b1MqiJBqekUkUZF124paIAH
         UNR26M8BcbCbVRBLCDH2F7tIdsMf2YuhI7h3VNqe9bC5mULi4ZO56uvw2yPzlo5HfqDg
         ZPR9SvoxWHpGU5O6VpXxCVceBVBXgEjJ0pZ5e/39zz3GpvMHASBq/3eJwl4dwSN1VKEb
         JOHLfRanx91rT+DFAIGYqdhM/ABHyQk+O7LJWVZyvNxvU5uVxgdIIO5mwATDxXEpbxIM
         t3RQ==
X-Forwarded-Encrypted: i=1; AJvYcCXt+FsseHCb4f22+t4X7V/kev0cNt+tAb+pH71TpBoJG08StqFIncXjcAXx78/uVyov+6S7UuiEs5nlg3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH/MSlDuj9+qQ/31NbHbniBGURuM4Yyi+kfN9K/7CPu8+7b3Sl
	7SdHzkajGzTPvCd0CZHJoyFRDxD3odfV68fzVAHhCcJXPL7rOyM77Y38srhC9A8JHYc=
X-Gm-Gg: ASbGncv81L29JBLaATiMV14efhBKXn0tyNNgR8y7IINIkgDRYz7tNL/A+r2R7dxyWSA
	uQBtjmsC3zG6Y7R8eUfIainXFdCYh6/3/q1eN2wXi3IY3Ig4QgjDAt05QJxSV2eR99SSjaIMVBB
	fyZ4jSnxVuU7FPlrc6lHloMU9tNH73K7u2aoWr36b+He/vmh/ctXf5FCXBqG+8ptQlaepGc6cP3
	8kwc0GcauhX8UsdJ2zmt58LD1Bjo16PQI/BVZlVhaUl6Tzapx+Lq1sEjJqCKAh5gVD9/IYZWx2G
	I/i1GJQQGWDRM20mekcFTWPg6VxVuErkc3vrZyY42ihVZbmvuWwdgDxPlqigZt4QjR8bx3nR1tn
	RbeE00AJvr13/GgtwjnQ4gi+B7MtRVBglO+gilCR5ICuR/Q06WbTS/cgX7u5nP5PctTk=
X-Google-Smtp-Source: AGHT+IF4R2tFVGWC8k6CkleH6cTeT4JKQD3pLYPkCezw13nelkfxE7mqemTy2JJ2K7xkMnrvBzINPw==
X-Received: by 2002:a05:600c:3403:b0:46e:2109:f435 with SMTP id 5b1f17b1804b1-46e329b5a44mr134176745e9.11.1759217993870;
        Tue, 30 Sep 2025 00:39:53 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5707c1e7sm44021125e9.21.2025.09.30.00.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:39:53 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 30 Sep 2025 09:39:48 +0200
Subject: [PATCH v4 2/3] phy: qcom: qmp-combo: get the USB3 & DisplayPort
 lanes mapping from DT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-topic-x1e80100-hdmi-v4-2-86a14e8a34ac@linaro.org>
References: <20250930-topic-x1e80100-hdmi-v4-0-86a14e8a34ac@linaro.org>
In-Reply-To: <20250930-topic-x1e80100-hdmi-v4-0-86a14e8a34ac@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Xilin Wu <sophon@radxa.com>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6533;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=g7Iz7iBAofGT0xX6ovoXpuwBLIN329RO4dbf43CapJA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo24lG4ldgPdjLTzi6xRfqW6o1HSf5B1jy/WLnnDmn
 Qx9LJoWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaNuJRgAKCRB33NvayMhJ0UEMD/
 9GFyG7hFNsu4PG1UkA3YQ5OpNiNMWxD8QSkMYHMuZYiDHFl1wyzQBIFn/DfBTtwIkarAI6cvHCZfwP
 apRo6hl1ffzH+LupV9GF5Qfu9ho5uuFnqtYKzbkE/69YSPQRra519E9hJmGxYBuVbxqDUkxybcCc0I
 ibnubWgKS1cZ41HNiJYG46nO4j+EVRLAzOOfFU57IqZkj7551KJBeywK9Ce+RrX06VRphDwsdd4141
 L8RHWDiLZRQyXv7T9As6++smzY8+A/hZIbLk9Fg4GNGfpqcNby/XDI8X9eKzbIJOJ2gpeEwPSfDySS
 71a9PnO4KiQ2r0LJANCcbiREfhOkHdz+MYs4/BL/Adl3pHI9DryVvWMY4YwS6/G1wNfD4JuQUuBcYs
 znOK+i5kOLfauX0hWTa2YLl9Ad72me1bx/zNVs+VbMkBcqjINV93N9SoFgIO2Pk6FDxkang/r/Eflv
 DtibepVswb6rVFimEDwuy9W/8EOVl6ZCC+psBsATdVZIojKssuR6dq/IVw06+mRScT14xSZmVbLD61
 49fz01hT01RumICcEgDfYVAAcacw+WB8zj8pHkWaeO2EwefjRAYXh2c0QeoG3cMdPWtiySb7V8Qgy1
 0OOE8siGeWOEWn2BAyvaJGka9pL/3sE7CRkg5QPOEQUzWiJEr04+uYCyuuCA==
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

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 145 ++++++++++++++++++++++++++++--
 1 file changed, 137 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 7b5af30f1d028c592500e723ecd27b54ed554709..3a100807448152d7a08b6d1086f4a415b00e5255 100644
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
+	{ 1, TYPEC_ORIENTATION_NORMAL, { 0 }},
+	{ 1, TYPEC_ORIENTATION_REVERSE, { 3 }},
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
+	if (of_find_property(dev->of_node, "mode-switch", NULL) ||
+	    of_find_property(dev->of_node, "orientation-switch", NULL)) {
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


