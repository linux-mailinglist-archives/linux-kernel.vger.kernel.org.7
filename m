Return-Path: <linux-kernel+bounces-824697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD32B89EDE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32AFB585090
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BD431579B;
	Fri, 19 Sep 2025 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="khaP++Er"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC7B313530
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291928; cv=none; b=EhTBAoD9rNXt55VO82yreDC5IQJPmJBPD55z0gs1vYa+zitzlM0IkyCH/VoZ+xQvd+hk09wdzhcMqrm13aHquY0OQd9uQvM70uvki3iJSYQouZN2oMK4Uha04XLSqOPwLOTidpOqEjkDkykcfDOUAaVBRLd/rt0u5dxEIIC8Dmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291928; c=relaxed/simple;
	bh=V+bmwYjKfMRV9O7yUHq5omi3q3vjjg0Qz8GTgu2JE4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=igDHzbzGWr4diu4AhWTqjRjzS0iIG5Cb/WD9KeKncD6+Tl+G7LAELDBL8vO86Bv34gkM/VMutgC1wf99HGkMcnevha4SdoNxSHZdAIJXE3wSvwLktmUJFqGQHv0FufS7AiJ1PSUbR1h7H1RA9YIg87oZAXSvrn2eoyylk7/HB7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=khaP++Er; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JE3UCB018272
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xaxo68cQZZrWEEivhuCOX2owVkj5hniZ5EATwBZwjNk=; b=khaP++Er38sTrdaC
	a25QtnMmySG6jlbQzmbJPk9nvq8JUfUhtCu/p3VLfk0YA7FtM9oEN8s97ZnX5L1Z
	gnTjOdD7MtBAA2TeEWdbFO896ubNLF28BA4dxSc9ycdT9AwS9IBbzF4nrLA0hUZz
	zPty+mSFjpL2QHY9ENQPEnMwmPemM/tElkwKNgUF3FN5FMu6dGqPqdSpNeIILVvF
	gbskIgLEIDJW47aOensImQFZr1quulM+nEwqS9NJMHSuxcnVIj6KdotAuHRq5w8B
	QjSveBb6h3w8hYOsDXC13Zq5sik0CXxBfkW9nKcV5IKI7Bton3mEIg7ymC/0J7kk
	XZLwEQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxwjphb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:25:26 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2645223059dso4593715ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758291925; x=1758896725;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaxo68cQZZrWEEivhuCOX2owVkj5hniZ5EATwBZwjNk=;
        b=MD6FdwZchcpz3iWpbJn1UOKq8+x3EZPsEEQNscPASSbrNzUBL9otSWDJASev28vnX8
         EQTpiLZqyXdP4fwQj04YLWDEtTq4iTA1T/ycmXW2+bgDZLWNLb5rD/LNHcbacc51d9di
         Z6w2c1swUNeYDArP2o3oNOHxtTbpNkaOO7KtXv9EmwqMZ41V53kAoS3f9ef3zsB4Cf4s
         w0G7hE2TOoJ6w8ucZQwjqXwNFvwkDUvWgQNdaIpP2mRQEODZEfVnXq/OqUZMku+T4Uc4
         A83ex2Kn3yCzpmnDCeYksdmfLwjYcpL9qtGWEXX4F0P+5UOfYDDM5iIomTtxH5jsgQLv
         FlKw==
X-Forwarded-Encrypted: i=1; AJvYcCVAyMRjTyUcMLgwvvSC26e1ShYUqFgH0kTElt0JkzRliefAAPaBcf8b5MNH+BItIyK1cBxytKC06/SRhkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMYojl/CA2Z8+FhyiiSz7085QfpzU8a1jRaO+cZ2UU/skvTQFw
	2tE2AX/bBGDkU/2miq1gl9uQ/ybrOIoQhJAqQtc0cj69vnEsDSbD/kCUyMZ8MSs6PtoctW2Ub5t
	wedS+l36CEFi0CBrYWP/pB7h9jhFHazcuRnURVRbXh4OLVzPEnwE6/gZw5BLjqelaYa8=
X-Gm-Gg: ASbGncuGrUho90myzDyb9+Mu/I0nOQXl+galE9O0ta8e8rGf4LMvzIxyOSQQBIphZYb
	Byn/emq5VBnz7Dd1SCu2Lw0i76x1/7hF2+RkzduLrgEPFSt8D2Y6kuQJPUuSW0CHFjiVvub9/pQ
	SJ+95S5Y1Qb/SaHg1pjovZpL0THfY9BuS7AE/zzrDEfkyY3dIul6hGHL7yXjsnK0YzXtQ3J8qYc
	+R3BOaN3d+OmS/8Xk34xtf9vjLVkN/1df0WYgFpaVKRdinwGCfSi62Uc4F3xBaBHUVmwZS8L/XW
	BWva8adul4+O8/zMFCnNo8S4Puqx2Lox6MP90cr4aOQ8DtwI6Z1aX1GngKurH+JFkn1+X4g/yLo
	KxTYYU41nZtl6nQ==
X-Received: by 2002:a17:902:f68e:b0:269:96d2:9c96 with SMTP id d9443c01a7336-269ba2611c1mr28869455ad.0.1758291925134;
        Fri, 19 Sep 2025 07:25:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBIBS4AXXrSudYOMfmAwfNi+JdtzGlXQtukko475U4cFxag3zIVrNAiD2nbk1f8DLKq0tYqA==
X-Received: by 2002:a17:902:f68e:b0:269:96d2:9c96 with SMTP id d9443c01a7336-269ba2611c1mr28869165ad.0.1758291924517;
        Fri, 19 Sep 2025 07:25:24 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26e80409ee3sm2210035ad.80.2025.09.19.07.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 07:25:24 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Fri, 19 Sep 2025 22:24:20 +0800
Subject: [PATCH v5 03/14] phy: qcom: qmp-usbc: Add DP-related fields for
 USB/DP switchable PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-add-displayport-support-for-qcs615-platform-v5-3-eae6681f4002@oss.qualcomm.com>
References: <20250919-add-displayport-support-for-qcs615-platform-v5-0-eae6681f4002@oss.qualcomm.com>
In-Reply-To: <20250919-add-displayport-support-for-qcs615-platform-v5-0-eae6681f4002@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758291893; l=3979;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=V+bmwYjKfMRV9O7yUHq5omi3q3vjjg0Qz8GTgu2JE4Q=;
 b=D+YumCGLZ9Fv17diaosjhiV66oYGcYAUQpxt2JXYY0XK8mFV9R6yRnGH0JVEsEsiIQs6Zzfex
 tbHbYNLSINAA4p/JbPECyhUigU1ZdJjQj/ZzXsCwtg6fIlUQ4UP5k2H
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Authority-Analysis: v=2.4 cv=HbIUTjE8 c=1 sm=1 tr=0 ts=68cd67d6 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=jm3WsR2aq1IkTfYpOVcA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX0u5DXSctvF3y
 jfNRBnZGatj8EgDeQlvuNZSQb5ZJPgdv81OJ198vZKw9/zX7/XbX49HlCJz6fT3Yip2CgRcPQMd
 oelg3gC6ZTvfbbx5Iy717uD5jl4c0IZUIed/Gx1BpTCxGx5UTyHdMdmi0nEqeNS+x4qXx1f6oKN
 znhyPhVZGVM9eKm5hWCzjRKqslovbbLGAWTW2LqNA0fImZnZulVvCe5RJJGmWXO1Cfv3PdnL4AO
 rGcWC0S1LeA8eBd47rkGvuWWFW8td2cYzm+qoKW3jwtfaqJHcnD+KkhrWNfW+hj1KMnARxhbrJJ
 uj1KAvv7KvrVRbLvR2OcUXulX8t1v7iwgSC0JhqU9YA3C2tGgNgOuiUuGmuXsFGN5TDWRtnNFeY
 V/CbIwAY
X-Proofpoint-GUID: IWuXIDEw5T65K5heKRXnis2t7bLK4H85
X-Proofpoint-ORIG-GUID: IWuXIDEw5T65K5heKRXnis2t7bLK4H85
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

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


