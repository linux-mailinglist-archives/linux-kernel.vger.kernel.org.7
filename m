Return-Path: <linux-kernel+bounces-831874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E092DB9DC45
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9235B321FDF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560462E8B98;
	Thu, 25 Sep 2025 07:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lqKrZrfm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDC72EA165
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758783944; cv=none; b=WRtxyxOKMwKul7jHCCAJFcHE2vVkqpQ534kNUJwprjGE+Ync2ib3+1b7lle8MPFeqFdW3XqjEWhiiDK8XC/1+k6jkPBwJM/3K6V3l7miDSlkSZXgFg0kaJ62pFJUvK5rE6JReUKIbFKq8P//j7Uek240Lau6ZjPr/0Qj+wKOsfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758783944; c=relaxed/simple;
	bh=V+bmwYjKfMRV9O7yUHq5omi3q3vjjg0Qz8GTgu2JE4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d0i3BkJ0IPLkX9OrnVihJIbVESBS/Dc72oPjUtU7zeAL5I47EP+F11HfnQTQEJMKJmAv2djNUwhfxpeqaPUCd+JW4cwNvR++77Z9MVHSmoVV6wewjwLIIUle6hfhKEOdNYOZ0rLgOX6bfFEWYvbpOJhK/nT04Sh32FI4WLBXeQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lqKrZrfm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONq6X4021486
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xaxo68cQZZrWEEivhuCOX2owVkj5hniZ5EATwBZwjNk=; b=lqKrZrfmnA1mA49d
	BMGBV4DJ0/vxTosfPR90Pc4E2f5oXHiWVRexHvOUMa/OsMVrAoLIGm7yQnocHpSX
	ccZgtt9i/Uu+1iHLafyo5iUwbbRNSxcadDmTp4Eszsth66cIXI2ARYyIUoTf5J4c
	t4oWuZz6CnM5fEuhtOvh6eNiGyGZ5OYiMwgJYaLItz4/bZUfT/yUq16n1tAwrUkY
	j5G8N+5rGjKWdXoXhwM5mBjmcL2bcZ+BoMGsJio78CJnKMfRU/84v71ENg9Ir7mc
	5dhATCTLyEEfLO56LjnspaO8gzewjGHuJKvNoIX7sjniAYYKsY1xuUEVBTaDvLzf
	0jpHCg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49budaepm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:05:41 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3327e438680so141405a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758783940; x=1759388740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaxo68cQZZrWEEivhuCOX2owVkj5hniZ5EATwBZwjNk=;
        b=gzh29wbqKdGU3Sxgdpm/w0B+C+7R2nJHCpDkmY2apgEMxKqKL+EKxoIww65yzhbi7u
         b7txeSfao9hTKT4j0tHO0T3Jef5R+2Ck09qBTwWZxlg+0B14YeCxT+tOMOR5xhBvdkQt
         9mQSlxv4ykQ5hy1tZc7L2Vefy6k1Bfg6LpYSKHaHlE9OC3CchPMoWa1c3xywqDib2oFN
         vQc4M0SQCef3SK2chJ0F7EaC2U0MSLE2IwO8vW448IQrS2RxcFgrzFmoLnBZz565Ah+C
         zOFxm7INQT9AatOOZwNHlXf2hPdEPUVIFL3NOT2L+L2xsY4RpXAnIqudMtaioUcIYn73
         kPqg==
X-Forwarded-Encrypted: i=1; AJvYcCW6PGoHpYyy/G0MJGcebnd2oNxU2o8fCjL3y50lbstATwxHNjjTDfPx+jc7f3LHAj9m4695n1ynMZnMrMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2htqWpqQU9mOIDl5rLr1iWT2ylBC85n4YmtE0y4oY7acZjrSa
	VW5c/5IW7fGRU+ayx8Ajg1vrHmovK+7lWopsV/9ObSyQCSBJpYbnDjhm6RJtBYQdzWUAsxWZ+vo
	6Fo0K5s42/ujrKkqRwq5M7io4p9KEih5J4u2PBPjGRoddrSJJAtWe/pcudou+txJDhcU=
X-Gm-Gg: ASbGncuHTZoQbEYZcM6i3a+z7M7xOtRejVpdP2HZWjx1IfDLEZN52O3x/MxuK+Tgxlr
	uxgoBqHzGfdXPPSQZ91Q/ts50O2MZg0894wwAbJYAj/dPBv9ZkQdci05A11ehLXxn8CFkM3RCHj
	LUuDZIc7aSbyEfmrqwvYArCEFWdBkb7bjqnsEkAAnW/ZIf0Kja8ndVRxBJbGprsVFQtod7JvVoM
	6Rpub1T19FODcQZb+MDNHBXYMZ6nxrBEKsoVXjh5SJD+Bwqb0krgnIbs07jDE6FUrwS/MsARzrv
	I3jeOt46JgfeR1RxZQYjIeXKt+4DGS1DksQ9iVyZZ/Rgi47pidimfsjsAYL5210jMJDp//51wKy
	H3DG4lqiMKVcp2aDI+r3dmi2Jyr8pklrOe/s6uGmzISjcqAJhazlvb79b
X-Received: by 2002:a17:90b:388e:b0:32b:aed4:aa1a with SMTP id 98e67ed59e1d1-3342a2becc5mr1437915a91.4.1758783940329;
        Thu, 25 Sep 2025 00:05:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF08XNZvMgLQSMxyP3a6gJQ7OHs/SMmu2hfWmPLLtMYILn3N1lf7IdRY1VjzAg/lXzvndi+aw==
X-Received: by 2002:a17:90b:388e:b0:32b:aed4:aa1a with SMTP id 98e67ed59e1d1-3342a2becc5mr1437881a91.4.1758783939828;
        Thu, 25 Sep 2025 00:05:39 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3342a2bd584sm914253a91.0.2025.09.25.00.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 00:05:39 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 15:04:49 +0800
Subject: [PATCH v6 03/14] phy: qcom: qmp-usbc: Add DP-related fields for
 USB/DP switchable PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-add-displayport-support-for-qcs615-platform-v6-3-419fe5963819@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758783909; l=3979;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=V+bmwYjKfMRV9O7yUHq5omi3q3vjjg0Qz8GTgu2JE4Q=;
 b=Ae0l6papN9LzPWR+g9eFxMd4ZlEhIaSGUpmSLY4qxCCVUqXRcR6QD7bRTeW43zrHkOlMzP+Ve
 p5rKCT8LoSsCIdXV1/sNtFb7PSqek1AuWbZErM1yQ8AxonY2RoJ96Vg
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Proofpoint-GUID: lllgGYHRG7BbN5nytmA2Ttx5khYyCXco
X-Proofpoint-ORIG-GUID: lllgGYHRG7BbN5nytmA2Ttx5khYyCXco
X-Authority-Analysis: v=2.4 cv=Yaq95xRf c=1 sm=1 tr=0 ts=68d4e9c5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=jm3WsR2aq1IkTfYpOVcA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDExMyBTYWx0ZWRfX9+tZaGIjHTqx
 sEEKaxj/cwXSykOZV+3Nk9nk4wHbiCy42qYsFGRgk6LAhP9yj+RxTb4wUSjCtZV9TCIdlaG0wRx
 H0zzK738sX6qmMDrsSo2Vjnhx+tlhIVzD8qF54mMVnPK2lWnnQ8zB9/SBEmhr19l1+GYFtoZPNe
 KVO6CPu13teusLumlJ0b8FSd/vbKghP7NC+mr028ZpE6YSUppxZZOpFm7S8eYMU5jmOqG9JmhkA
 dUTZb3PEq7NcNXYxZxUcEe7RTCSRRbBpWyAynDGBgxH+0J7B8/YoVpwTMBbOjuxxND8UFrjOqN8
 m6WqHdJM1GPSUS8TCgGSPMMNFtSqeQ4e/F2fFBcgv4y/SEXBrC07zGik8zTqFTW4Hi+yj67Jzfr
 v/DRWoON
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230113

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


