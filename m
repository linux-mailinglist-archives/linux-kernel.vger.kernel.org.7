Return-Path: <linux-kernel+bounces-804710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0461B47BE2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 16:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950613C2C96
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 14:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9932AF0A;
	Sun,  7 Sep 2025 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dOR9vFVN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C62280023
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757256750; cv=none; b=juX36+uj8qx8WWi7m0G8V4XNP7Fcc0arGCvLV56snOPwkg1Bfu7yv4fps7bYgKh4BdaDHHu7/21rCGpvffc1aQmo4MqnT4qxMedlhRimogPiA5g0Ayr1nEemN8hIx4jit4a9Az2wa6+xT0zqypoq8yRiTJNbVlw9Zh47Todg6t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757256750; c=relaxed/simple;
	bh=+lxZy5wSWHwn4dkXG8qEVFxp6y7sBJ88wefm48Ftm6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D51GKz6YWNQ6V1ejPh+wAWEvls/ADIJHW4KVlQPC8SN+pvCPGbTKId3rKH15VlYGrkusg3A5u2rnjBrEXjOKNCe1woCQRH/qpoHbvvaCQZ7dLpB3E5QPthBe0voBQPSDJ5ibB5RH1iYO/snlF4cpuznoQmZ6eJiNaQOcrZErjm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dOR9vFVN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587AeIDK026612
	for <linux-kernel@vger.kernel.org>; Sun, 7 Sep 2025 14:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jp17008N9EcjHAl9t0HpxgMYKb1MSuNaJ/ECZEHaOsI=; b=dOR9vFVNUXkIvFLZ
	MdOHB1REzE3CMiD4c6Es8COU9ElqQgJaBkKpUqdnSHLpmmQngdlAU+KamQXvf9TF
	CAeHDZ8de6fS2s+6Qduo2fsHdYPLRqRYToHVLhfnm0GpzRtz8sWQkGFmpyTtWlM5
	VvQd5l5gnfTiZakQLOaSk+H9QemqBu3FKM/h0detOWhf/0Z37FdFmcs0gkQDdpJX
	gEwcYL04WXmAP5OyLhX0s+hVPKNvbSrGYoR2M7R/00d5Wuo9EB4dZ6AZLS3OKdfi
	tSysHQkSfDBbiB0H1OHqnPx5rFYYxYHCuWxNLYWlAqAZGStFxuZIB+IIhgCaquEF
	z0iZJA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4kt4bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 14:52:26 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-72048b6e865so75967746d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 07:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757256744; x=1757861544;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jp17008N9EcjHAl9t0HpxgMYKb1MSuNaJ/ECZEHaOsI=;
        b=ohLiSZsjzZ7iQtTSG/DgzTUIFu9G0I8Q1k9X3ab1fFFQM7moZAhwSz/ynjHhfyru5i
         jyAGlay5x3w2TGgGNropNnfDQM+4nLnipJFzDp/TdbzwGFg3mnm/KCLdwVYdvwNCruPr
         Y4ZO0UzA8dIsa40ku8Io76194mCp/9LzHq7bqvxqGWwVrzXZXsIhGleUonnCSEqs2dph
         n1bRrFA6ADuFKxNiqRHBwCYPspzES/jx+PTVRX0JzNvFeoihQADvBXRR0Sb8SvZ0GaEt
         HeO/xwO0RlkGope3jIgHPS6Q2JcuWC83pUebQM8/n9xMRRj66SaxJcwrUQko/Go8Mqj7
         QuQg==
X-Forwarded-Encrypted: i=1; AJvYcCVCKKEB/vZQ5Wv52psqc3CgCn73EbwG77NaZ2zcbvUnu9UqoXx8WHjIvacwtaGIyB/d93zWkG2XCnqVPIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywup774BkLMs1DN4qWwbIfEi/ELFViZN2OZFO0RbUl7nQ/eHxEZ
	Jw9dQoFAoqdpaE0UKHbN7NaNiASmaO7pHnRnRyInkTwxWdE6i44RqSFpPAk2P8tzYfQALNiek3r
	bxT8pMtFdA4R9e50E+ujqlxRhJdLZI0lYNmZtf2ZwleBHvCPKUO6CKMx+ooervbVAtfYr8lWDYO
	Q=
X-Gm-Gg: ASbGncvSgZMq1T67Wou25XXCdyPNAhirwp9bxEFJghyz04uf3kEu8lNpOWf0B1mwVQU
	6CGtSfSbmqo6NNaDiSynv6mA6LHYBHTJVReosD7EikPoTycsVwJsZ3XtihlCbN0kRQJwd3r5gxy
	0TlsMxCjSQHooy017dde5u/ljic8/LWObc3JRk9jyqOo744hXBGkKSyThwWAisuIx19RzzXJXTM
	RtDQMJI21ufSADTI/Ei2LAsLQAJjRPknCTDpYXGcNDNDthRCrnWRcJYQVpyFFImAa/MV3G/kEe+
	0ws1MupvwcIt+e9VRjMKsidA4NvsM5nAriFo9HSmsG4fymacnE+M7thOfrLEf2vk7f8piAfi69h
	mzAU68gfv3YT2lwpNLFoYC2FXwIz88JOJQmEyGOs0AoauyAq+5CN+
X-Received: by 2002:a05:6214:1256:b0:725:cd10:3d1d with SMTP id 6a1803df08f44-7391f9bb4bbmr54357316d6.16.1757256743869;
        Sun, 07 Sep 2025 07:52:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEywULK/o5gerneWOtP1Ftmr2zD7HJNj5pRL52f8+t/P7CaGR9+Im7V1oAQiPv0G7huvf6Ujw==
X-Received: by 2002:a05:6214:1256:b0:725:cd10:3d1d with SMTP id 6a1803df08f44-7391f9bb4bbmr54357116d6.16.1757256743245;
        Sun, 07 Sep 2025 07:52:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ab939d5sm2936738e87.46.2025.09.07.07.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 07:52:21 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 07 Sep 2025 17:52:13 +0300
Subject: [PATCH 4/4] phy: qcom: extract common code for DP clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250907-qcom-dp-phy-v1-4-46634a6a980b@oss.qualcomm.com>
References: <20250907-qcom-dp-phy-v1-0-46634a6a980b@oss.qualcomm.com>
In-Reply-To: <20250907-qcom-dp-phy-v1-0-46634a6a980b@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=29309;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=+lxZy5wSWHwn4dkXG8qEVFxp6y7sBJ88wefm48Ftm6A=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBovZwf/x9GbApPNr7nxVQY7pgb/vVpLaJ/mLIzf
 PsvmV0CE5mJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaL2cHwAKCRCLPIo+Aiko
 1WUACACzu3HvaSE30G/lbXlO/P7/gengB+spGgEV1FxAiky/nLWnUfwoIYw0HbmT93+LPa90ha4
 4DlUSLYRPaQseDYH/YMvkI+VmGy1iGXX9USQ/Rhlf2AG/L9yv51e5el377e+sRVAJDIW0l8hcHm
 ifFPl9lPtn79QMzXpa3WHMypqzpG3pZ95LMq9KwUyZUG6tGGjTnvKbrjDDubmFzkp0kljYKQh2s
 c0oZ+0a3kpxmalVsUS+KAYE9LCRG8vnd6pZoym6hQe5iLdkieMjMpeje+qMl66lqYBCK0xKQ6+I
 2TNhBl3EK8qsv0SzzjUePoqJ/wyxKqoioBraMWvWeOsE1Sq7
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfX4TiBsfJZNnmX
 mE/GTA+J3P/+taHSqe/yyOGac/74L+HB8dYEnEN+jC22LD2jwZs1EaxPDw5kqQPKQkqo5aGJC5n
 wBBuJKlFf/zSFhQ0hSdTAHUlYoSZcAuduh1M60IHCw4oG3KMXztR6hYkHUo3+dkpK0xJ8qHjxFy
 vYxUDL5QTpPZSOy4HHzS/GlXocm0ncc3nFgwU0Sk4WHlJDTMBry8ywMtZmowpCIPqlBI7o8z+bj
 zS4eCcFqWzbsGyy8d++CCgICTwNK1Vw3+k2y7WaH/tuWbTpvBa65azsL2nk7/qHfhpmwKZLSF5g
 Bg6t6u2CHuwkPIlbYIB7xIB6Uly9awsIEdll7UyLXLW2igYBWFBx9ADbuPNLkG+iRBqHNteJROI
 tnMWGP/W
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68bd9c2a cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=nQ43Eca3DgWIm8wGIFMA:9
 a=co8bklLMP2XZkljK:21 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: rSVl6mecRtxMlcehDaGmNN4dBw42JYqE
X-Proofpoint-ORIG-GUID: rSVl6mecRtxMlcehDaGmNN4dBw42JYqE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

The combo QMP PHY and eDP PHY share DP clocks implementation. With the
USBC PHY gaining DP support it is going to get yet another copy of the
same code.

Extract common DP clock implementation to a separate module. In future
we might want to extract more common functions.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/phy/qualcomm/Kconfig              |   8 ++
 drivers/phy/qualcomm/Makefile             |   1 +
 drivers/phy/qualcomm/phy-qcom-dp-common.c | 164 ++++++++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-dp-common.h |  22 ++++
 drivers/phy/qualcomm/phy-qcom-edp.c       | 181 ++++------------------------
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 188 +++---------------------------
 6 files changed, 234 insertions(+), 330 deletions(-)

diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
index 60a0ead127fa9f08749e1bc686e15cc5eb341c28..a4da90124f57cf6260d24e1dd45033cfdfbeb087 100644
--- a/drivers/phy/qualcomm/Kconfig
+++ b/drivers/phy/qualcomm/Kconfig
@@ -18,12 +18,19 @@ config PHY_QCOM_APQ8064_SATA
 	depends on OF
 	select GENERIC_PHY
 
+config PHY_QCOM_DP_COMMON
+	tristate
+	help
+	  A library implementation of DP / eDP functions common to all Qualcomm
+	  DisplayPort / eDP PHYs
+
 config PHY_QCOM_EDP
 	tristate "Qualcomm eDP PHY driver"
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on OF
 	depends on COMMON_CLK
 	select GENERIC_PHY
+	select PHY_QCOM_DP_COMMON
 	help
 	  Enable this driver to support the Qualcomm eDP PHY found in various
 	  Qualcomm chipsets.
@@ -64,6 +71,7 @@ config PHY_QCOM_QMP_COMBO
 	select GENERIC_PHY
 	select MFD_SYSCON
 	select DRM_AUX_BRIDGE if DRM_BRIDGE
+	select PHY_QCOM_DP_COMMON
 	help
 	  Enable this to support the QMP Combo PHY transceiver that is used
 	  with USB3 and DisplayPort controllers on Qualcomm chips.
diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
index b71a6a0bed3f1489b1d07664ecd728f1db145986..1491348ed2139481634f8a540964194485126eb5 100644
--- a/drivers/phy/qualcomm/Makefile
+++ b/drivers/phy/qualcomm/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_PHY_ATH79_USB)		+= phy-ath79-usb.o
 obj-$(CONFIG_PHY_QCOM_APQ8064_SATA)	+= phy-qcom-apq8064-sata.o
 obj-$(CONFIG_PHY_QCOM_EDP)		+= phy-qcom-edp.o
+obj-$(CONFIG_PHY_QCOM_DP_COMMON)	+= phy-qcom-dp-common.o
 obj-$(CONFIG_PHY_QCOM_IPQ4019_USB)	+= phy-qcom-ipq4019-usb.o
 obj-$(CONFIG_PHY_QCOM_IPQ806X_SATA)	+= phy-qcom-ipq806x-sata.o
 obj-$(CONFIG_PHY_QCOM_M31_USB)		+= phy-qcom-m31.o
diff --git a/drivers/phy/qualcomm/phy-qcom-dp-common.c b/drivers/phy/qualcomm/phy-qcom-dp-common.c
new file mode 100644
index 0000000000000000000000000000000000000000..601f7bed956759367d1ebac8b24444f09b9e9e96
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-dp-common.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2017, 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Linaro Ltd.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/module.h>
+
+#include "phy-qcom-dp-common.h"
+
+/*
+ * Display Port PLL driver block diagram for branch clocks
+ *
+ *              +------------------------------+
+ *              |         DP_VCO_CLK           |
+ *              |                              |
+ *              |    +-------------------+     |
+ *              |    |   (DP PLL/VCO)    |     |
+ *              |    +---------+---------+     |
+ *              |              v               |
+ *              |   +----------+-----------+   |
+ *              |   | hsclk_divsel_clk_src |   |
+ *              |   +----------+-----------+   |
+ *              +------------------------------+
+ *                              |
+ *          +---------<---------v------------>----------+
+ *          |                                           |
+ * +--------v----------------+                          |
+ * |    dp_phy_pll_link_clk  |                          |
+ * |     link_clk            |                          |
+ * +--------+----------------+                          |
+ *          |                                           |
+ *          |                                           |
+ *          v                                           v
+ * Input to DISPCC block                                |
+ * for link clk, crypto clk                             |
+ * and interface clock                                  |
+ *                                                      |
+ *                                                      |
+ *      +--------<------------+-----------------+---<---+
+ *      |                     |                 |
+ * +----v---------+  +--------v-----+  +--------v------+
+ * | vco_divided  |  | vco_divided  |  | vco_divided   |
+ * |    _clk_src  |  |    _clk_src  |  |    _clk_src   |
+ * |              |  |              |  |               |
+ * |divsel_six    |  |  divsel_two  |  |  divsel_four  |
+ * +-------+------+  +-----+--------+  +--------+------+
+ *         |                 |                  |
+ *         v---->----------v-------------<------v
+ *                         |
+ *              +----------+-----------------+
+ *              |   dp_phy_pll_vco_div_clk   |
+ *              +---------+------------------+
+ *                        |
+ *                        v
+ *              Input to DISPCC block
+ *              for DP pixel clock
+ *
+ */
+static int qmp_dp_pixel_clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
+{
+	switch (req->rate) {
+	case 1620000000UL / 2:
+	case 2700000000UL / 2:
+	/* 5.4 and 8.1 GHz are same link rate as 2.7GHz, i.e. div 4 and div 6 */
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static unsigned long qmp_dp_pixel_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	const struct qcom_dp_common *common;
+	const struct phy_configure_opts_dp *dp_opts;
+
+	common = container_of(hw, struct qcom_dp_common, pixel_hw);
+	dp_opts = &common->dp_opts;
+
+	switch (dp_opts->link_rate) {
+	case 1620:
+		return 1620000000UL / 2;
+	case 2700:
+		return 2700000000UL / 2;
+	case 5400:
+		return 5400000000UL / 4;
+	case 8100:
+		return 8100000000UL / 6;
+	default:
+		return 0;
+	}
+}
+
+static const struct clk_ops qmp_dp_pixel_clk_ops = {
+	.determine_rate	= qmp_dp_pixel_clk_determine_rate,
+	.recalc_rate	= qmp_dp_pixel_clk_recalc_rate,
+};
+
+static int qmp_dp_link_clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
+{
+	switch (req->rate) {
+	case 162000000:
+	case 270000000:
+	case 540000000:
+	case 810000000:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static unsigned long qmp_dp_link_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	const struct qcom_dp_common *common;
+	const struct phy_configure_opts_dp *dp_opts;
+
+	common = container_of(hw, struct qcom_dp_common, link_hw);
+	dp_opts = &common->dp_opts;
+
+	switch (dp_opts->link_rate) {
+	case 1620:
+	case 2700:
+	case 5400:
+	case 8100:
+		return dp_opts->link_rate * 100000;
+	default:
+		return 0;
+	}
+}
+
+static const struct clk_ops qmp_dp_link_clk_ops = {
+	.determine_rate	= qmp_dp_link_clk_determine_rate,
+	.recalc_rate	= qmp_dp_link_clk_recalc_rate,
+};
+
+int devm_qcom_dp_clks_register(struct device *dev,
+			       struct qcom_dp_common *dp)
+{
+	struct clk_init_data init = { };
+	char name[64];
+	int ret;
+
+	snprintf(name, sizeof(name), "%s::link_clk", dev_name(dev));
+	init.ops = &qmp_dp_link_clk_ops;
+	init.name = name;
+	dp->link_hw.init = &init;
+	ret = devm_clk_hw_register(dev, &dp->link_hw);
+	if (ret)
+		return ret;
+
+	snprintf(name, sizeof(name), "%s::vco_div_clk", dev_name(dev));
+	init.ops = &qmp_dp_pixel_clk_ops;
+	init.name = name;
+	dp->pixel_hw.init = &init;
+	ret = devm_clk_hw_register(dev, &dp->pixel_hw);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_qcom_dp_clks_register);
diff --git a/drivers/phy/qualcomm/phy-qcom-dp-common.h b/drivers/phy/qualcomm/phy-qcom-dp-common.h
new file mode 100644
index 0000000000000000000000000000000000000000..3d176aafa243176b9f6f92c6e18519f53564efb2
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-dp-common.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef PHY_QCOM_QMP_DP_COMMON_H
+#define PHY_QCOM_QMP_DP_COMMON_H
+
+#include <linux/clk-provider.h>
+#include <linux/phy/phy-dp.h>
+
+struct qcom_dp_common {
+	struct phy_configure_opts_dp dp_opts;
+	struct clk_hw link_hw;
+	struct clk_hw pixel_hw;
+};
+
+int devm_qcom_dp_clks_register(struct device *dev,
+			       struct qcom_dp_common *dp);
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index f1b51018683d51df064f60440864c6031638670c..bf456b45bf8608127c7e702ab70ee8312f296af4 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -22,6 +22,8 @@
 
 #include <dt-bindings/phy/phy.h>
 
+#include "phy-qcom-dp-common.h"
+
 #include "phy-qcom-qmp-dp-phy.h"
 #include "phy-qcom-qmp-qserdes-com-v4.h"
 #include "phy-qcom-qmp-qserdes-com-v6.h"
@@ -98,10 +100,7 @@ struct qcom_edp {
 	void __iomem *tx1;
 	void __iomem *pll;
 
-	struct clk_hw dp_link_hw;
-	struct clk_hw dp_pixel_hw;
-
-	struct phy_configure_opts_dp dp_opts;
+	struct qcom_dp_common dp_common;
 
 	struct clk_bulk_data clks[2];
 	struct regulator_bulk_data supplies[2];
@@ -318,7 +317,7 @@ static int qcom_edp_phy_configure(struct phy *phy, union phy_configure_opts *opt
 	struct qcom_edp *edp = phy_get_drvdata(phy);
 	int ret = 0;
 
-	memcpy(&edp->dp_opts, dp_opts, sizeof(*dp_opts));
+	memcpy(&edp->dp_common.dp_opts, dp_opts, sizeof(*dp_opts));
 
 	if (dp_opts->set_voltages)
 		ret = qcom_edp_set_voltages(edp, dp_opts);
@@ -338,7 +337,7 @@ static int qcom_edp_configure_pll(const struct qcom_edp *edp)
 
 static int qcom_edp_set_vco_div(const struct qcom_edp *edp, unsigned long *pixel_freq)
 {
-	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
+	const struct phy_configure_opts_dp *dp_opts = &edp->dp_common.dp_opts;
 	u32 vco_div;
 
 	switch (dp_opts->link_rate) {
@@ -406,7 +405,7 @@ static int qcom_edp_com_bias_en_clkbuflr_v4(const struct qcom_edp *edp)
 
 static int qcom_edp_com_configure_ssc_v4(const struct qcom_edp *edp)
 {
-	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
+	const struct phy_configure_opts_dp *dp_opts = &edp->dp_common.dp_opts;
 	u32 step1;
 	u32 step2;
 
@@ -440,7 +439,7 @@ static int qcom_edp_com_configure_ssc_v4(const struct qcom_edp *edp)
 
 static int qcom_edp_com_configure_pll_v4(const struct qcom_edp *edp)
 {
-	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
+	const struct phy_configure_opts_dp *dp_opts = &edp->dp_common.dp_opts;
 	u32 div_frac_start2_mode0;
 	u32 div_frac_start3_mode0;
 	u32 dec_start_mode0;
@@ -591,7 +590,7 @@ static int qcom_edp_com_bias_en_clkbuflr_v6(const struct qcom_edp *edp)
 
 static int qcom_edp_com_configure_ssc_v6(const struct qcom_edp *edp)
 {
-	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
+	const struct phy_configure_opts_dp *dp_opts = &edp->dp_common.dp_opts;
 	u32 step1;
 	u32 step2;
 
@@ -625,7 +624,7 @@ static int qcom_edp_com_configure_ssc_v6(const struct qcom_edp *edp)
 
 static int qcom_edp_com_configure_pll_v6(const struct qcom_edp *edp)
 {
-	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
+	const struct phy_configure_opts_dp *dp_opts = &edp->dp_common.dp_opts;
 	u32 div_frac_start2_mode0;
 	u32 div_frac_start3_mode0;
 	u32 dec_start_mode0;
@@ -758,7 +757,7 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 	writel(0x00, edp->tx0 + TXn_LANE_MODE_1);
 	writel(0x00, edp->tx1 + TXn_LANE_MODE_1);
 
-	if (edp->dp_opts.ssc) {
+	if (edp->dp_common.dp_opts.ssc) {
 		ret = qcom_edp_configure_ssc(edp);
 		if (ret)
 			return ret;
@@ -818,13 +817,13 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 	writel(0x1f, edp->tx0 + TXn_TX_DRV_LVL);
 	writel(0x1f, edp->tx1 + TXn_TX_DRV_LVL);
 
-	if (edp->dp_opts.lanes == 1) {
+	if (edp->dp_common.dp_opts.lanes == 1) {
 		bias0_en = 0x01;
 		bias1_en = 0x00;
 		drvr0_en = 0x06;
 		drvr1_en = 0x07;
 		cfg1 = 0x1;
-	} else if (edp->dp_opts.lanes == 2) {
+	} else if (edp->dp_common.dp_opts.lanes == 2) {
 		bias0_en = 0x03;
 		bias1_en = 0x00;
 		drvr0_en = 0x04;
@@ -854,8 +853,8 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 	if (ret)
 		return ret;
 
-	clk_set_rate(edp->dp_link_hw.clk, edp->dp_opts.link_rate * 100000);
-	clk_set_rate(edp->dp_pixel_hw.clk, pixel_freq);
+	clk_set_rate(edp->dp_common.link_hw.clk, edp->dp_common.dp_opts.link_rate * 100000);
+	clk_set_rate(edp->dp_common.pixel_hw.clk, pixel_freq);
 
 	return 0;
 }
@@ -901,162 +900,22 @@ static const struct phy_ops qcom_edp_ops = {
 	.owner		= THIS_MODULE,
 };
 
-/*
- * Embedded Display Port PLL driver block diagram for branch clocks
- *
- *              +------------------------------+
- *              |        EDP_VCO_CLK           |
- *              |                              |
- *              |    +-------------------+     |
- *              |    |  (EDP PLL/VCO)    |     |
- *              |    +---------+---------+     |
- *              |              v               |
- *              |   +----------+-----------+   |
- *              |   | hsclk_divsel_clk_src |   |
- *              |   +----------+-----------+   |
- *              +------------------------------+
- *                              |
- *          +---------<---------v------------>----------+
- *          |                                           |
- * +--------v----------------+                          |
- * |   edp_phy_pll_link_clk  |                          |
- * |     link_clk            |                          |
- * +--------+----------------+                          |
- *          |                                           |
- *          |                                           |
- *          v                                           v
- * Input to DISPCC block                                |
- * for link clk, crypto clk                             |
- * and interface clock                                  |
- *                                                      |
- *                                                      |
- *      +--------<------------+-----------------+---<---+
- *      |                     |                 |
- * +----v---------+  +--------v-----+  +--------v------+
- * | vco_divided  |  | vco_divided  |  | vco_divided   |
- * |    _clk_src  |  |    _clk_src  |  |    _clk_src   |
- * |              |  |              |  |               |
- * |divsel_six    |  |  divsel_two  |  |  divsel_four  |
- * +-------+------+  +-----+--------+  +--------+------+
- *         |                 |                  |
- *         v---->----------v-------------<------v
- *                         |
- *              +----------+-----------------+
- *              |   edp_phy_pll_vco_div_clk  |
- *              +---------+------------------+
- *                        |
- *                        v
- *              Input to DISPCC block
- *              for EDP pixel clock
- *
- */
-static int qcom_edp_dp_pixel_clk_determine_rate(struct clk_hw *hw,
-						struct clk_rate_request *req)
-{
-	switch (req->rate) {
-	case 1620000000UL / 2:
-	case 2700000000UL / 2:
-	/* 5.4 and 8.1 GHz are same link rate as 2.7GHz, i.e. div 4 and div 6 */
-		return 0;
-
-	default:
-		return -EINVAL;
-	}
-}
-
-static unsigned long
-qcom_edp_dp_pixel_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
-{
-	const struct qcom_edp *edp = container_of(hw, struct qcom_edp, dp_pixel_hw);
-	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
-
-	switch (dp_opts->link_rate) {
-	case 1620:
-		return 1620000000UL / 2;
-	case 2700:
-		return 2700000000UL / 2;
-	case 5400:
-		return 5400000000UL / 4;
-	case 8100:
-		return 8100000000UL / 6;
-	default:
-		return 0;
-	}
-}
-
-static const struct clk_ops qcom_edp_dp_pixel_clk_ops = {
-	.determine_rate = qcom_edp_dp_pixel_clk_determine_rate,
-	.recalc_rate = qcom_edp_dp_pixel_clk_recalc_rate,
-};
-
-static int qcom_edp_dp_link_clk_determine_rate(struct clk_hw *hw,
-					       struct clk_rate_request *req)
-{
-	switch (req->rate) {
-	case 162000000:
-	case 270000000:
-	case 540000000:
-	case 810000000:
-		return 0;
-
-	default:
-		return -EINVAL;
-	}
-}
-
-static unsigned long
-qcom_edp_dp_link_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
-{
-	const struct qcom_edp *edp = container_of(hw, struct qcom_edp, dp_link_hw);
-	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
-
-	switch (dp_opts->link_rate) {
-	case 1620:
-	case 2700:
-	case 5400:
-	case 8100:
-		return dp_opts->link_rate * 100000;
-
-	default:
-		return 0;
-	}
-}
-
-static const struct clk_ops qcom_edp_dp_link_clk_ops = {
-	.determine_rate = qcom_edp_dp_link_clk_determine_rate,
-	.recalc_rate = qcom_edp_dp_link_clk_recalc_rate,
-};
-
 static int qcom_edp_clks_register(struct qcom_edp *edp, struct device_node *np)
 {
 	struct clk_hw_onecell_data *data;
-	struct clk_init_data init = { };
-	char name[64];
 	int ret;
 
+	ret = devm_qcom_dp_clks_register(edp->dev, &edp->dp_common);
+	if (ret)
+		return ret;
+
 	data = devm_kzalloc(edp->dev, struct_size(data, hws, 2), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 	data->num = 2;
 
-	snprintf(name, sizeof(name), "%s::link_clk", dev_name(edp->dev));
-	init.ops = &qcom_edp_dp_link_clk_ops;
-	init.name = name;
-	edp->dp_link_hw.init = &init;
-	ret = devm_clk_hw_register(edp->dev, &edp->dp_link_hw);
-	if (ret)
-		return ret;
-
-	snprintf(name, sizeof(name), "%s::vco_div_clk", dev_name(edp->dev));
-	init.ops = &qcom_edp_dp_pixel_clk_ops;
-	init.name = name;
-	edp->dp_pixel_hw.init = &init;
-	ret = devm_clk_hw_register(edp->dev, &edp->dp_pixel_hw);
-	if (ret)
-		return ret;
-
-	data->hws[0] = &edp->dp_link_hw;
-	data->hws[1] = &edp->dp_pixel_hw;
+	data->hws[0] = &edp->dp_common.link_hw;
+	data->hws[1] = &edp->dp_common.pixel_hw;
 
 	return devm_of_clk_add_hw_provider(edp->dev, of_clk_hw_onecell_get, data);
 }
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index baf25ae442478ac01a5428fa4268470e6b5211e3..8b6a27464b3303eb0d66b97f7d7cfb10687821e4 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -26,6 +26,8 @@
 
 #include <dt-bindings/phy/phy-qcom-qmp.h>
 
+#include "phy-qcom-dp-common.h"
+
 #include "phy-qcom-qmp-common.h"
 
 #include "phy-qcom-qmp.h"
@@ -1859,13 +1861,11 @@ struct qmp_combo {
 
 	struct phy *dp_phy;
 	unsigned int dp_aux_cfg;
-	struct phy_configure_opts_dp dp_opts;
 	unsigned int dp_init_count;
 	bool dp_powered_on;
 
 	struct clk_hw *pipe_clk_hw;
-	struct clk_hw dp_link_hw;
-	struct clk_hw dp_pixel_hw;
+	struct qcom_dp_common dp_common;
 
 	struct typec_switch_dev *sw;
 	enum typec_orientation orientation;
@@ -2515,7 +2515,7 @@ static int qmp_combo_dp_serdes_init(struct qmp_combo *qmp)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	void __iomem *serdes = qmp->dp_serdes;
-	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
+	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_common.dp_opts;
 
 	qmp_configure(qmp->dev, serdes, cfg->dp_serdes_tbl,
 		      cfg->dp_serdes_tbl_num);
@@ -2592,7 +2592,7 @@ static void qmp_v3_dp_aux_init(struct qmp_combo *qmp)
 
 static int qmp_combo_configure_dp_swing(struct qmp_combo *qmp)
 {
-	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
+	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_common.dp_opts;
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	unsigned int v_level = 0, p_level = 0;
 	u8 voltage_swing_cfg, pre_emphasis_cfg;
@@ -2629,7 +2629,7 @@ static int qmp_combo_configure_dp_swing(struct qmp_combo *qmp)
 
 static void qmp_v3_configure_dp_tx(struct qmp_combo *qmp)
 {
-	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
+	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_common.dp_opts;
 	u32 bias_en, drvr_en;
 
 	if (qmp_combo_configure_dp_swing(qmp) < 0)
@@ -2652,7 +2652,7 @@ static void qmp_v3_configure_dp_tx(struct qmp_combo *qmp)
 static bool qmp_combo_configure_dp_mode(struct qmp_combo *qmp)
 {
 	bool reverse = (qmp->orientation == TYPEC_ORIENTATION_REVERSE);
-	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
+	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_common.dp_opts;
 	u32 val;
 
 	val = DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
@@ -2675,7 +2675,7 @@ static bool qmp_combo_configure_dp_mode(struct qmp_combo *qmp)
 
 static int qmp_combo_configure_dp_clocks(struct qmp_combo *qmp)
 {
-	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
+	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_common.dp_opts;
 	u32 phy_vco_div;
 	unsigned long pixel_freq;
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
@@ -2703,8 +2703,8 @@ static int qmp_combo_configure_dp_clocks(struct qmp_combo *qmp)
 	}
 	writel(phy_vco_div, qmp->dp_dp_phy + cfg->regs[QPHY_DP_PHY_VCO_DIV]);
 
-	clk_set_rate(qmp->dp_link_hw.clk, dp_opts->link_rate * 100000);
-	clk_set_rate(qmp->dp_pixel_hw.clk, pixel_freq);
+	clk_set_rate(qmp->dp_common.link_hw.clk, dp_opts->link_rate * 100000);
+	clk_set_rate(qmp->dp_common.pixel_hw.clk, pixel_freq);
 
 	return 0;
 }
@@ -2891,7 +2891,7 @@ static int qmp_v4_configure_dp_phy(struct qmp_combo *qmp)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	bool reverse = (qmp->orientation == TYPEC_ORIENTATION_REVERSE);
-	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
+	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_common.dp_opts;
 	u32 bias0_en, drvr0_en, bias1_en, drvr1_en;
 	u32 status;
 	int ret;
@@ -2976,10 +2976,10 @@ static int qmp_combo_dp_configure(struct phy *phy, union phy_configure_opts *opt
 
 	mutex_lock(&qmp->phy_mutex);
 
-	memcpy(&qmp->dp_opts, dp_opts, sizeof(*dp_opts));
-	if (qmp->dp_opts.set_voltages) {
+	memcpy(&qmp->dp_common.dp_opts, dp_opts, sizeof(*dp_opts));
+	if (qmp->dp_common.dp_opts.set_voltages) {
 		cfg->configure_dp_tx(qmp);
-		qmp->dp_opts.set_voltages = 0;
+		qmp->dp_common.dp_opts.set_voltages = 0;
 	}
 
 	mutex_unlock(&qmp->phy_mutex);
@@ -3512,131 +3512,6 @@ static int qmp_combo_clk_init(struct qmp_combo *qmp)
 	return devm_clk_bulk_get_optional(dev, num, qmp->clks);
 }
 
-/*
- * Display Port PLL driver block diagram for branch clocks
- *
- *              +------------------------------+
- *              |         DP_VCO_CLK           |
- *              |                              |
- *              |    +-------------------+     |
- *              |    |   (DP PLL/VCO)    |     |
- *              |    +---------+---------+     |
- *              |              v               |
- *              |   +----------+-----------+   |
- *              |   | hsclk_divsel_clk_src |   |
- *              |   +----------+-----------+   |
- *              +------------------------------+
- *                              |
- *          +---------<---------v------------>----------+
- *          |                                           |
- * +--------v----------------+                          |
- * |    dp_phy_pll_link_clk  |                          |
- * |     link_clk            |                          |
- * +--------+----------------+                          |
- *          |                                           |
- *          |                                           |
- *          v                                           v
- * Input to DISPCC block                                |
- * for link clk, crypto clk                             |
- * and interface clock                                  |
- *                                                      |
- *                                                      |
- *      +--------<------------+-----------------+---<---+
- *      |                     |                 |
- * +----v---------+  +--------v-----+  +--------v------+
- * | vco_divided  |  | vco_divided  |  | vco_divided   |
- * |    _clk_src  |  |    _clk_src  |  |    _clk_src   |
- * |              |  |              |  |               |
- * |divsel_six    |  |  divsel_two  |  |  divsel_four  |
- * +-------+------+  +-----+--------+  +--------+------+
- *         |                 |                  |
- *         v---->----------v-------------<------v
- *                         |
- *              +----------+-----------------+
- *              |   dp_phy_pll_vco_div_clk   |
- *              +---------+------------------+
- *                        |
- *                        v
- *              Input to DISPCC block
- *              for DP pixel clock
- *
- */
-static int qmp_dp_pixel_clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
-{
-	switch (req->rate) {
-	case 1620000000UL / 2:
-	case 2700000000UL / 2:
-	/* 5.4 and 8.1 GHz are same link rate as 2.7GHz, i.e. div 4 and div 6 */
-		return 0;
-	default:
-		return -EINVAL;
-	}
-}
-
-static unsigned long qmp_dp_pixel_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
-{
-	const struct qmp_combo *qmp;
-	const struct phy_configure_opts_dp *dp_opts;
-
-	qmp = container_of(hw, struct qmp_combo, dp_pixel_hw);
-	dp_opts = &qmp->dp_opts;
-
-	switch (dp_opts->link_rate) {
-	case 1620:
-		return 1620000000UL / 2;
-	case 2700:
-		return 2700000000UL / 2;
-	case 5400:
-		return 5400000000UL / 4;
-	case 8100:
-		return 8100000000UL / 6;
-	default:
-		return 0;
-	}
-}
-
-static const struct clk_ops qmp_dp_pixel_clk_ops = {
-	.determine_rate	= qmp_dp_pixel_clk_determine_rate,
-	.recalc_rate	= qmp_dp_pixel_clk_recalc_rate,
-};
-
-static int qmp_dp_link_clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
-{
-	switch (req->rate) {
-	case 162000000:
-	case 270000000:
-	case 540000000:
-	case 810000000:
-		return 0;
-	default:
-		return -EINVAL;
-	}
-}
-
-static unsigned long qmp_dp_link_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
-{
-	const struct qmp_combo *qmp;
-	const struct phy_configure_opts_dp *dp_opts;
-
-	qmp = container_of(hw, struct qmp_combo, dp_link_hw);
-	dp_opts = &qmp->dp_opts;
-
-	switch (dp_opts->link_rate) {
-	case 1620:
-	case 2700:
-	case 5400:
-	case 8100:
-		return dp_opts->link_rate * 100000;
-	default:
-		return 0;
-	}
-}
-
-static const struct clk_ops qmp_dp_link_clk_ops = {
-	.determine_rate	= qmp_dp_link_clk_determine_rate,
-	.recalc_rate	= qmp_dp_link_clk_recalc_rate,
-};
-
 static struct clk_hw *qmp_dp_clks_hw_get(struct of_phandle_args *clkspec, void *data)
 {
 	struct qmp_combo *qmp = data;
@@ -3648,34 +3523,9 @@ static struct clk_hw *qmp_dp_clks_hw_get(struct of_phandle_args *clkspec, void *
 	}
 
 	if (idx == 0)
-		return &qmp->dp_link_hw;
-
-	return &qmp->dp_pixel_hw;
-}
-
-static int phy_dp_clks_register(struct qmp_combo *qmp, struct device_node *np)
-{
-	struct clk_init_data init = { };
-	char name[64];
-	int ret;
+		return &qmp->dp_common.link_hw;
 
-	snprintf(name, sizeof(name), "%s::link_clk", dev_name(qmp->dev));
-	init.ops = &qmp_dp_link_clk_ops;
-	init.name = name;
-	qmp->dp_link_hw.init = &init;
-	ret = devm_clk_hw_register(qmp->dev, &qmp->dp_link_hw);
-	if (ret)
-		return ret;
-
-	snprintf(name, sizeof(name), "%s::vco_div_clk", dev_name(qmp->dev));
-	init.ops = &qmp_dp_pixel_clk_ops;
-	init.name = name;
-	qmp->dp_pixel_hw.init = &init;
-	ret = devm_clk_hw_register(qmp->dev, &qmp->dp_pixel_hw);
-	if (ret)
-		return ret;
-
-	return 0;
+	return &qmp->dp_common.pixel_hw;
 }
 
 static struct clk_hw *qmp_combo_clk_hw_get(struct of_phandle_args *clkspec, void *data)
@@ -3686,9 +3536,9 @@ static struct clk_hw *qmp_combo_clk_hw_get(struct of_phandle_args *clkspec, void
 	case QMP_USB43DP_USB3_PIPE_CLK:
 		return qmp->pipe_clk_hw;
 	case QMP_USB43DP_DP_LINK_CLK:
-		return &qmp->dp_link_hw;
+		return &qmp->dp_common.link_hw;
 	case QMP_USB43DP_DP_VCO_DIV_CLK:
-		return &qmp->dp_pixel_hw;
+		return &qmp->dp_common.pixel_hw;
 	}
 
 	return ERR_PTR(-EINVAL);
@@ -3703,7 +3553,7 @@ static int qmp_combo_register_clocks(struct qmp_combo *qmp, struct device_node *
 	if (IS_ERR(qmp->pipe_clk_hw))
 		return PTR_ERR(qmp->pipe_clk_hw);
 
-	ret = phy_dp_clks_register(qmp, dp_np);
+	ret = devm_qcom_dp_clks_register(qmp->dev, &qmp->dp_common);
 	if (ret)
 		return ret;
 

-- 
2.47.3


