Return-Path: <linux-kernel+bounces-833690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D36DBA2BA7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C823277B1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CAA28C862;
	Fri, 26 Sep 2025 07:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MUO36ulx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BB528934D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758871596; cv=none; b=UzfqNNwNyOsmGqkL7sABc+K+B00MKhONnTMxi3tpbY+BmFzSEr64TjjApd6M7MGFr1LHZAw8j7IcD2dvdwqP8Mf9B9lDJjzC+K8m+fy4JkEdM+vFfEfJzMocXncyeqbYztI+aQhLO9I+eK+dZhjk6rGNSmM0Xhnz2q32KAvGejs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758871596; c=relaxed/simple;
	bh=V+bmwYjKfMRV9O7yUHq5omi3q3vjjg0Qz8GTgu2JE4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WD1gk95Ik4TDgflOwOdXh0Ru8qiUBddxD1JwhjHUhPUSPMsTJXWwRhtHftRCsR5KEhT5eIuYKUlquFkNtdIrbXv2DNtJsDYx1G8Ecqrk+C71QDJ5NlXUkgV21kbw+3xHEmisOX7a/H6NmyLGVL2M8lGHn2xudbrWgib1r+zv3Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MUO36ulx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q6ocZ6011374
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xaxo68cQZZrWEEivhuCOX2owVkj5hniZ5EATwBZwjNk=; b=MUO36ulxe97L2OD9
	1BqLZ//oeJKZlzPBFOMEWw0RJNvdw6Pf21HW9DNvxjAfqTZxX9lXGyjuCQOHTFqo
	Cgtxr9MURwmFGZMKjyP0sJ4AquEbrh2DoLj8M3GJ02OwcnvseyJfgH6amDgUSh++
	SjJNEmhjL1cgfJG5odETXojel1Hs2Yewrcdsk23PxhoadICDqTXCNFgxtdAFi+o5
	ixs0t+uhHIfw5b2pb3cgg315fB4f/+O8MUmvDkXxiY8YZYHfBJzyZN+kIudbBWET
	oBjXnOa1EJM4Uoje0/ngN90OBmzBlr1h66aond7InW7AA8Bc+ymf201AVd//d5uw
	fiYfDA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0q1w1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:26:34 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-269b2d8af0cso4284755ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 00:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758871593; x=1759476393;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaxo68cQZZrWEEivhuCOX2owVkj5hniZ5EATwBZwjNk=;
        b=rHfrqCKLb4Wnf3DVOTSBzQBz5Aw7L7Qs1+GX1A15rvY8QdE+d0KJl+j2N/lNnxlg/a
         ySucxSWBYTpRv5Kg0zxMEjCsNVifW5ZLdFwG7guT3j8eGJCXxz1/cR5PzbD5QBTmXcvH
         m3A805Z/fEyA7TUqo8SLWDrS6UNIP2esdx+dIEReDAvB+Q0IDkRmIf4/jH827bQCj3R1
         Y20F/RP1/Lfl6GF2epAHh9LVB2uyXkaAu3x7a0txuUs+2V7AQTrToT4q7lwjgmFG9hVX
         +BSOwhRBaayHsFhxqD4xm1UwEuCEx6XiHry2ILmZqSJiG9SlWP6qphUlwdlln/ZUy7g7
         alZw==
X-Forwarded-Encrypted: i=1; AJvYcCVIa5Z0T4tf5TY0oXPPWTRNSsT17dTXUUSSwViFD6YiFe3JRcjzCEI6h5bW2o+FHKUZaEZQsEhpqVaz/rA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpji9Gej5qOdlZKOqDuNEQyPoNtM2/mCsaJLb+DpfBayXmgF3S
	IF99O7qfZgTlPPX6uYfIGI3MoD2LrLOm+4Vd1AppQ83SDMuJq2J1QSpe19VfO8PZ9rq5yrp551N
	9TzU0n1M5hlljhqFeAXQWg7lDYjsr3QYXZpn85gcYmwYSA1d7F+iEwo7Nj3ZbcqJovCw=
X-Gm-Gg: ASbGncuRmcVNFCfosom/fTce0ksugw+14+yTfrXWypkgxjCnItk8GsqTGnEwPOMkonI
	uswp7Z1SrfWjp50cGuXLOU1jpQvbP698W2pjDy8sMaASjXdjjjZK9LZe6xlQPgrfJA7z8v0etha
	bynftXgXOOoe5bjJdk539+xGr+LFkD8Sp6ObywbLBUEockjKF/+0/gT8l4yE5LJtVM5kXhk5Y5d
	ANpH7+7yIgSpfCvoGtBH+2d6kSgDJNm0ZeyNPenS0VfFMW5xEg6kkqw0zigmErahs7geJp3khyd
	OYN0GYks6VEVn+sL39dEIfwWgDedSJg6ewi7eYUtjhT8fpZfF/ugHjUhG0K8igMHcbQ9ErFycaR
	ju8EDgMGxjzfALsPO16KSGQfv5S6BWYyiS/uuz7Ngmz33hZhN6hwIeNG4
X-Received: by 2002:a17:902:db11:b0:24e:af92:70de with SMTP id d9443c01a7336-27ed4a7e773mr47493205ad.7.1758871593445;
        Fri, 26 Sep 2025 00:26:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtuIwETTdMuZFytO6gNG8pDDirIuQO50mBZZkHzCplsKRiXqaAce6j6yazHtoa1boWUkBnIg==
X-Received: by 2002:a17:902:db11:b0:24e:af92:70de with SMTP id d9443c01a7336-27ed4a7e773mr47492965ad.7.1758871593007;
        Fri, 26 Sep 2025 00:26:33 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671d8a2sm45117985ad.55.2025.09.26.00.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 00:26:32 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 15:25:39 +0800
Subject: [PATCH v7 03/14] phy: qcom: qmp-usbc: Add DP-related fields for
 USB/DP switchable PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-add-displayport-support-for-qcs615-platform-v7-3-dc5edaac6c2b@oss.qualcomm.com>
References: <20250926-add-displayport-support-for-qcs615-platform-v7-0-dc5edaac6c2b@oss.qualcomm.com>
In-Reply-To: <20250926-add-displayport-support-for-qcs615-platform-v7-0-dc5edaac6c2b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758871562; l=3979;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=V+bmwYjKfMRV9O7yUHq5omi3q3vjjg0Qz8GTgu2JE4Q=;
 b=8Gw1TqMTIu4+SMDOsf2QNnJ1zb+xwdOWQ6J2y4ga7ZkzeMW8XD2pf5E9cnQQLlVs0je+aagaj
 NmrMOdI5mPgC9gOOCsgy43oMazsY2HtkgiGoJtjIMzdWF79TzMxQ05T
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Proofpoint-ORIG-GUID: ayAUiDhNoATGxeEUnu7oQFUnlU2xH4Ah
X-Proofpoint-GUID: ayAUiDhNoATGxeEUnu7oQFUnlU2xH4Ah
X-Authority-Analysis: v=2.4 cv=aZhsXBot c=1 sm=1 tr=0 ts=68d6402a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=jm3WsR2aq1IkTfYpOVcA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX6J3STx7l5Ifc
 Xs8yPKYBguZ+RdWfXNHdITUaqUcRGRDlJ3uV7SYyLi4R0iQfAxibDFzVpowugdkvlvDEh4V+0tV
 aWleFYo+MmpGd6C5r8dSwmNPE9FFa5a0tkaUiuC7UTGEc0h6Crdp0yQNQj5/TQZkE7cgQvcAd2v
 tj5+XM8CNZq5kxTxlrZ401jAEXakSRK0Ru4dVag4kp9KobVvQ0Zqn/fijNhSEPxHl8QPIXjcehE
 C1sH0DaQQ7hpPi9FYm6FhFSuFKqPwHN5UUMtCUXUFVqOWfgM3lHmGekjftgVXJKezymhtdvzVIp
 Q5tKcgG0jSle/bRu4u9ntYlZ3Fz8i7oJFMcFA8NFVaNchjAWdZFMk5TgYGXC31ppdGG9tELLtKl
 18f4Yl4GzyUmV70rccucIipmu9Z1Sw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

Extend qmp_usbc_offsets and qmp_phy_cfg with DP-specific fields,
including register offsets, init tables, and callback hooks. Also
update qmp_usbc struct to track DP-related resources and state.
This enables support for USB/DP switchable Type-C PHYs that operate
in either mode.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 54 +++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
index 62920dd2aed39bbfddd54ba2682e3d45d65a09c8..de28c3464a40ea97740e16fe78cba4b927911d92 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
@@ -293,13 +293,18 @@ struct qmp_usbc_offsets {
 	/* for PHYs with >= 2 lanes */
 	u16 tx2;
 	u16 rx2;
+
+	u16 dp_serdes;
+	u16 dp_txa;
+	u16 dp_txb;
+	u16 dp_dp_phy;
 };
 
-/* struct qmp_phy_cfg - per-PHY initialization config */
+struct qmp_usbc;
 struct qmp_phy_cfg {
 	const struct qmp_usbc_offsets *offsets;
 
-	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
+	/* Init sequence for USB PHY blocks - serdes, tx, rx, pcs */
 	const struct qmp_phy_init_tbl *serdes_tbl;
 	int serdes_tbl_num;
 	const struct qmp_phy_init_tbl *tx_tbl;
@@ -309,6 +314,27 @@ struct qmp_phy_cfg {
 	const struct qmp_phy_init_tbl *pcs_tbl;
 	int pcs_tbl_num;
 
+	/* Init sequence for DP PHY blocks - serdes, tx, rbr, hbr, hbr2 */
+	const struct qmp_phy_init_tbl *dp_serdes_tbl;
+	int dp_serdes_tbl_num;
+	const struct qmp_phy_init_tbl *dp_tx_tbl;
+	int dp_tx_tbl_num;
+	const struct qmp_phy_init_tbl *serdes_tbl_rbr;
+	int serdes_tbl_rbr_num;
+	const struct qmp_phy_init_tbl *serdes_tbl_hbr;
+	int serdes_tbl_hbr_num;
+	const struct qmp_phy_init_tbl *serdes_tbl_hbr2;
+	int serdes_tbl_hbr2_num;
+
+	const u8 (*swing_tbl)[4][4];
+	const u8 (*pre_emphasis_tbl)[4][4];
+
+	/* DP PHY callbacks */
+	void (*dp_aux_init)(struct qmp_usbc *qmp);
+	void (*configure_dp_tx)(struct qmp_usbc *qmp);
+	int (*configure_dp_phy)(struct qmp_usbc *qmp);
+	int (*calibrate_dp_phy)(struct qmp_usbc *qmp);
+
 	/* regulators to be requested */
 	const char * const *vreg_list;
 	int num_vregs;
@@ -329,24 +355,36 @@ struct qmp_usbc {
 	void __iomem *rx;
 	void __iomem *tx2;
 	void __iomem *rx2;
-
-	struct regmap *tcsr_map;
-	u32 vls_clamp_reg;
+	void __iomem *dp_dp_phy;
+	void __iomem *dp_tx;
+	void __iomem *dp_tx2;
+	void __iomem *dp_serdes;
 
 	struct clk *pipe_clk;
+	struct clk_fixed_rate pipe_clk_fixed;
+
+	struct clk_hw dp_link_hw;
+	struct clk_hw dp_pixel_hw;
 	struct clk_bulk_data *clks;
 	int num_clks;
 	int num_resets;
 	struct reset_control_bulk_data *resets;
 	struct regulator_bulk_data *vregs;
 
+	struct regmap *tcsr_map;
+	u32 vls_clamp_reg;
+	u32 dp_phy_mode_reg;
+
 	struct mutex phy_mutex;
 
 	struct phy *usb_phy;
 	enum phy_mode mode;
 	unsigned int usb_init_count;
 
-	struct clk_fixed_rate pipe_clk_fixed;
+	struct phy *dp_phy;
+	unsigned int dp_aux_cfg;
+	struct phy_configure_opts_dp dp_opts;
+	unsigned int dp_init_count;
 
 	struct typec_switch_dev *sw;
 	enum typec_orientation orientation;
@@ -689,7 +727,7 @@ static int __maybe_unused qmp_usbc_runtime_suspend(struct device *dev)
 
 	dev_vdbg(dev, "Suspending QMP phy, mode:%d\n", qmp->mode);
 
-	if (!qmp->usb_init_count) {
+	if (!qmp->usb_init_count && !qmp->dp_init_count) {
 		dev_vdbg(dev, "PHY not initialized, bailing out\n");
 		return 0;
 	}
@@ -709,7 +747,7 @@ static int __maybe_unused qmp_usbc_runtime_resume(struct device *dev)
 
 	dev_vdbg(dev, "Resuming QMP phy, mode:%d\n", qmp->mode);
 
-	if (!qmp->usb_init_count) {
+	if (!qmp->usb_init_count && !qmp->dp_init_count) {
 		dev_vdbg(dev, "PHY not initialized, bailing out\n");
 		return 0;
 	}

-- 
2.34.1


