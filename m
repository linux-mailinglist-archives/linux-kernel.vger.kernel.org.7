Return-Path: <linux-kernel+bounces-831877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CEBB9DC7E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63834425C69
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240E22E9743;
	Thu, 25 Sep 2025 07:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kmJrYepc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329772EA72A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758783964; cv=none; b=npFw3tH7H0bNBN2Usi62QGmmfvu8x/U7b2wP5v5Gd3+VK7kBQ+aCNc3RtMFmNDJdVj61Xjbvgf4uycnJjUFBpKXaagbEEo8dSYrW4eXsyv+MTXgWyVTuC9ZTU3rAfxC1yNf1Rf2h36XH68OIjHi65iXR1l/vb4fA0mRyGdM+QH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758783964; c=relaxed/simple;
	bh=+AkB68Wj9yjCLoqOifYtk/INX+wMNK47OLvgYQCEpRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EsCSZn+rerxCb5xG6qDSJGbja3mVqdVxLwxOvtWnneVEKoIakE5ihvqzRqj87cuNZLy24iYyRQAKNb0ESDcnHYlMmoW/hagSM9QFlOoTzMF6s88kFp4veTDEch5t62NL7lSKgqLZq9g+u4wtfjXOxT3RNYlJhI6zTRWeeQAuW1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kmJrYepc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P1T9Ge029974
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l2Dojx1iD6RP3jObiZpJMfMDuav2jG6QC62uyxjC/fU=; b=kmJrYepcyraxxg7N
	j+2EGs2lwkgZtjaWYYePaRTkOj6zhuH1GqG2jz85KI4T4fiyGfqFK4EuWy4CK+Wf
	E0rqhcKK5evwVIvmyVcV/Ia0mGxkhrATR/v607A94Z88qUfV3MyZZ/FwHssJ/hk+
	fzmdqjiGvDCmpmhVW1fmSsX+pgxinJJpJyelYPTYJfuMfU6R5hQb/E/ukC/Wu2aG
	QyZU1Y1W7IDAebr4nTuhdXl4+YUfCVkUZcVtpzffA1T/oqP5VV8NoHVF/62mvxMX
	8InZ80aK9nB5uzEEXVXSlNFLNu7QQWIu8pLIuliGkJT/0aDsumHp1xHpNPQsr64R
	opolBA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fq13a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:06:02 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3327e438680so141497a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758783962; x=1759388762;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2Dojx1iD6RP3jObiZpJMfMDuav2jG6QC62uyxjC/fU=;
        b=UVCJPQMiFmwsYGIJJObst7o6wrLVOYwR3A85onrFBonVh/V/10fjC9EDPAodQnGmLR
         kMgxBIpkNMjcLKhTOzDCGnDtpyRFN96+ZiUTCRL3fih3r0T3m98moAAiPTbnWpWRN33M
         xB6Ie2iU9mqUy0Y+5QEzNZRzHHdDCPNvz7TMBhGnKtq2WxrmOfktKwQkjmf6mUycVzPo
         C2CGuqCzW8ENyrZVUgE6OddXEuAk6Lp68GV0618hB1uYYjgifUnvzdRH8GmIDIgchu3b
         0YVggNrlfMgnwUypp5Jbi2ZVmCSRlS66NWIWp1EF4lRj0CFZyCCdYbe+3CEwMdF8xDtX
         WHnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0SZJJjZg28QuzFWVMcPnaDF0JyXnXcihBt5nGWPgpnA5bPA3fMPbYk/s1fUvZjqFsoscD3Yk2p+kknIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyae8N7AuJ9fZBtKyoQS7lhg3p7POluKhe9r3A/ErR69yXOtIXy
	EUWoiNdVnpBbqMW9Lz4eLzCPMM/ttP2UrNutCL9dD3RdJpr7JyyioyNhIBcAnLRQ/c+6EciGBq5
	Kbw7nKssFttCHX49ftKztUAxdInB7uk86TsIKK7F/TDbdg8cIxF14fnjawG8TxgFyb9o=
X-Gm-Gg: ASbGnctYfFxsu7VGnPz2cAqwT8XMZsLqaXYg6amo9xyVg3OuG++/hj4xCjX7XxmN99P
	TdvAC4+aKifNKSLZS07QmD5ONFQy54ihNxdENWDltxFOf4ye/SjbU0tf9ynqvSdr5hOBDCOhgFr
	3cuo1U0w/o20hepsDAHOr6/d31OU6jJqyiSwhbTVMjqy5C2A2tqvHTID5yN5tm4tU6PldfBJ0NE
	Byp+OCsIRZwqAQ9jngsBSc2gOqOd37dbkc3sS1Uk9awqdXsXldyWYN0lXzJabXwSyDD4c0LM2HP
	CAhiWSLHIlEcWCsS/SxUAofOLzZa3hsPnpXjRUBpW6IxBscAk8Tqfrl9WVQGfCgOHOZj1djH3YE
	EXzzz16/JOGyNFrC3RxvkhiBCy9ipj8g11nLQQTcKg65NFA2PrDh0t1C6
X-Received: by 2002:a17:90b:1642:b0:32a:8b55:5b82 with SMTP id 98e67ed59e1d1-3342a138dafmr1621961a91.0.1758783961552;
        Thu, 25 Sep 2025 00:06:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElr6w5inT3JUY04JsRy9X7InvrTRIJJx9cbD5gtP+vhtRymbBAV5RoSaPsYX1MDOy1xD2xIg==
X-Received: by 2002:a17:90b:1642:b0:32a:8b55:5b82 with SMTP id 98e67ed59e1d1-3342a138dafmr1621939a91.0.1758783961036;
        Thu, 25 Sep 2025 00:06:01 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3342a2bd584sm914253a91.0.2025.09.25.00.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 00:06:00 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 15:04:52 +0800
Subject: [PATCH v6 06/14] phy: qcom: qmp-usbc: add DP link and vco_div
 clocks for DP PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-add-displayport-support-for-qcs615-platform-v6-6-419fe5963819@oss.qualcomm.com>
References: <20250925-add-displayport-support-for-qcs615-platform-v6-0-419fe5963819@oss.qualcomm.com>
In-Reply-To: <20250925-add-displayport-support-for-qcs615-platform-v6-0-419fe5963819@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758783910; l=8756;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=+AkB68Wj9yjCLoqOifYtk/INX+wMNK47OLvgYQCEpRs=;
 b=pb/30npFCgG+mf4VI5FI17Whq1da1fDr3EatW6LG6+CNgVg8c9XXvhtkqe+zGhtCeNGcxEJ1G
 ZMZmgrsvofPAi+/2cxHvbk+281Vz/O9Pc2R4hfTXX/LLyUXFkRhCMZk
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Proofpoint-ORIG-GUID: -EOy4RNrC3cxBe7yjDJ1nuH51V-ZmgPu
X-Proofpoint-GUID: -EOy4RNrC3cxBe7yjDJ1nuH51V-ZmgPu
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d4e9da cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=LV3rUWBglltBUjuJGHkA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX5ZJ//n76t9BB
 kUdzN/w4bwfPBILP3fMa7evk5IGJQ7OD/tuWe8h3WqbZ7CrvqXgvBo3x+981/YBmIqP8DDC698P
 PJyKrFsO4ZDyjFiy44hpDT+mKDKvrI7n4Ir+oQgwySShQXXWSUFsmhEZ0NJ23D2FTgIVmpBCY0v
 h67Lz92H9+MJR5fqz+O5xJlC+cJ2I1kOPejfgZc+R/UiHZGmhsTEAZ3xCF93FUgsRFRq42aGjNk
 M6NpOfVUbX5dfASgVmmUDhenqgwshkzBTdQI4RM6MoM8qp4FQlEXp5npbzssJwHVRQ/mhnnUPX1
 5DyMP2g0QyLHZVzD/OuapS1aHxaYCUDZTEIyKy3vsb4sWnUjycKe/cTJxdGdoWkVAoVnowEiAwX
 epMp6JkU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

USB3DP PHY requires link and vco_div clocks when operating in DP mode.
Extend qmp_usbc_register_clocks and the clock provider logic to register
these clocks along with the existing pipe clock, to support both USB and
DP configurations.

Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 210 ++++++++++++++++++++++++++++++-
 1 file changed, 204 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
index f9e20f43435c050e33e9490343a4693a339d692a..7139f4dab82fd7b0d1362dddefba178465e76fa4 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/usb/typec.h>
 #include <linux/usb/typec_mux.h>
+#include <dt-bindings/phy/phy-qcom-qmp.h>
 
 #include "phy-qcom-qmp-common.h"
 
@@ -851,9 +852,23 @@ static int qmp_usbc_clk_init(struct qmp_usbc *qmp)
 	return devm_clk_bulk_get_optional(dev, num, qmp->clks);
 }
 
-static void phy_clk_release_provider(void *res)
+static struct clk_hw *qmp_usbc_clks_hw_get(struct of_phandle_args *clkspec, void *data)
 {
-	of_clk_del_provider(res);
+	struct qmp_usbc *qmp = data;
+
+	if (clkspec->args_count == 0)
+		return &qmp->pipe_clk_fixed.hw;
+
+	switch (clkspec->args[0]) {
+	case QMP_USB43DP_USB3_PIPE_CLK:
+		return &qmp->pipe_clk_fixed.hw;
+	case QMP_USB43DP_DP_LINK_CLK:
+		return &qmp->dp_link_hw;
+	case QMP_USB43DP_DP_VCO_DIV_CLK:
+		return &qmp->dp_pixel_hw;
+	}
+
+	return ERR_PTR(-EINVAL);
 }
 
 /*
@@ -878,12 +893,14 @@ static int phy_pipe_clk_register(struct qmp_usbc *qmp, struct device_node *np)
 {
 	struct clk_fixed_rate *fixed = &qmp->pipe_clk_fixed;
 	struct clk_init_data init = { };
+	char name[64];
 	int ret;
 
 	ret = of_property_read_string(np, "clock-output-names", &init.name);
 	if (ret) {
-		dev_err(qmp->dev, "%pOFn: No clock-output-names\n", np);
-		return ret;
+		/* Clock name is not mandatory. */
+		snprintf(name, sizeof(name), "%s::pipe_clk", dev_name(qmp->dev));
+		init.name = name;
 	}
 
 	init.ops = &clk_fixed_rate_ops;
@@ -892,10 +909,184 @@ static int phy_pipe_clk_register(struct qmp_usbc *qmp, struct device_node *np)
 	fixed->fixed_rate = 125000000;
 	fixed->hw.init = &init;
 
-	ret = devm_clk_hw_register(qmp->dev, &fixed->hw);
+	return devm_clk_hw_register(qmp->dev, &fixed->hw);
+}
+
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
+	/* 5.4 is same link rate as 2.7GHz, i.e. div 4 */
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static unsigned long qmp_dp_pixel_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	const struct qmp_usbc *qmp;
+	const struct phy_configure_opts_dp *dp_opts;
+
+	qmp = container_of(hw, struct qmp_usbc, dp_pixel_hw);
+
+	dp_opts = &qmp->dp_opts;
+
+	switch (dp_opts->link_rate) {
+	case 1620:
+		return 1620000000UL / 2;
+	case 2700:
+		return 2700000000UL / 2;
+	case 5400:
+		return 5400000000UL / 4;
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
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static unsigned long qmp_dp_link_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	const struct qmp_usbc *qmp;
+	const struct phy_configure_opts_dp *dp_opts;
+
+	qmp = container_of(hw, struct qmp_usbc, dp_link_hw);
+	dp_opts = &qmp->dp_opts;
+
+	switch (dp_opts->link_rate) {
+	case 1620:
+	case 2700:
+	case 5400:
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
+static int phy_dp_clks_register(struct qmp_usbc *qmp, struct device_node *np)
+{
+	struct clk_init_data init = { };
+	char name[64];
+	int ret;
+
+	snprintf(name, sizeof(name), "%s::link_clk", dev_name(qmp->dev));
+	init.ops = &qmp_dp_link_clk_ops;
+	init.name = name;
+	qmp->dp_link_hw.init = &init;
+	ret = devm_clk_hw_register(qmp->dev, &qmp->dp_link_hw);
+	if (ret < 0) {
+		dev_err(qmp->dev, "link clk reg fail ret=%d\n", ret);
+		return ret;
+	}
+
+	snprintf(name, sizeof(name), "%s::vco_div_clk", dev_name(qmp->dev));
+	init.ops = &qmp_dp_pixel_clk_ops;
+	init.name = name;
+	qmp->dp_pixel_hw.init = &init;
+	ret = devm_clk_hw_register(qmp->dev, &qmp->dp_pixel_hw);
+	if (ret) {
+		dev_err(qmp->dev, "pxl clk reg fail ret=%d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void phy_clk_release_provider(void *res)
+{
+	of_clk_del_provider(res);
+}
+
+static int qmp_usbc_register_clocks(struct qmp_usbc *qmp, struct device_node *np)
+{
+	struct clk_fixed_rate *fixed = &qmp->pipe_clk_fixed;
+	int ret;
+
+	ret = phy_pipe_clk_register(qmp, np);
 	if (ret)
 		return ret;
 
+	if (qmp->dp_serdes != 0) {
+		ret = phy_dp_clks_register(qmp, np);
+		if (ret)
+			return ret;
+	}
+
+	if (np == qmp->dev->of_node)
+		return devm_of_clk_add_hw_provider(qmp->dev, qmp_usbc_clks_hw_get, qmp);
+
 	ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, &fixed->hw);
 	if (ret)
 		return ret;
@@ -1040,6 +1231,13 @@ static int qmp_usbc_parse_dt(struct qmp_usbc *qmp)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
+	if (offs->dp_serdes != 0) {
+		qmp->dp_serdes = base + offs->dp_serdes;
+		qmp->dp_tx = base + offs->dp_txa;
+		qmp->dp_tx2 = base + offs->dp_txb;
+		qmp->dp_dp_phy = base + offs->dp_dp_phy;
+	}
+
 	qmp->serdes = base + offs->serdes;
 	qmp->pcs = base + offs->pcs;
 	if (offs->pcs_misc)
@@ -1148,7 +1346,7 @@ static int qmp_usbc_probe(struct platform_device *pdev)
 	 */
 	pm_runtime_forbid(dev);
 
-	ret = phy_pipe_clk_register(qmp, np);
+	ret = qmp_usbc_register_clocks(qmp, np);
 	if (ret)
 		goto err_node_put;
 

-- 
2.34.1


