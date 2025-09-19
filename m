Return-Path: <linux-kernel+bounces-824698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E18B89EFF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975CDA056F6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958D830E0C2;
	Fri, 19 Sep 2025 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f9gPE8SD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27799313530
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291935; cv=none; b=HN+n9rZH5z5kiDViJes6UbEW/lTFtznAZtWGR9JEzO2ymIFA88lYtqpAVjICNYv3sCa+RK2SC+CH97lL3Vhu/SJgJFB+ALci1mKFRYqEwxRwizQ4HLZXQuW5Gi04dXh1aSUr+kYzMuJ77HiwNNxVXl3EToPhiZBfQFP/XgkFdDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291935; c=relaxed/simple;
	bh=ScND5R19fNR4fxgqnX3CVdg+GNtnOHYJhlmcXMGybGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ouo7wSw2XfWlJluwtK6j/8Q8Z08GU/y5BgOoEqroiOrN9y9LUB3nMNIYfqfMfvHsGLhDnonYlVEnVMXhWbSjiXL5OkTP5nwQqXw8buNxNtzOIhXCCCh8TpFUn19OuCSy1Zk81LO0HZnVuHvyX+FDk+Q4RUXGbf8PLZMTNtEjxwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f9gPE8SD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58J70eni019068
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ph7HUhaBaiRojkAD3JbT6dqDUnW8cPmN0abiXHdzjwk=; b=f9gPE8SD9OX8YF66
	O92Zjn5/G199P72cs82s1JD1BJ3PH4Ca3Vdc7+OibOshKUtQQZB13DWTGxNKGso3
	1hzbFhZWyZHCUsPe2VJd2tDHkLYEoTDWMAnLwrZ2mMTea2fJP3xXcGOOjc+cSvUm
	2A7mrh6FDM+LdEcqir4YxKcAEIBNuLXqJFvioXzatdj8KrXyDFbBjom/7u96e/Ak
	T/Yl/kwMMXbcfDoS2Al/ve34EDKwG7YV0TDHkMsep+S0q5h4Lw7uLWu6S8AVdL28
	OO2HjBvUH3CWvYIYlbdr/lAA3uD5eQW9lvyPL9QUytclkt3HteXB3+Xc6xQE/Uew
	4xpSlw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxwjphx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:25:33 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2696ab1bc16so4746705ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758291932; x=1758896732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ph7HUhaBaiRojkAD3JbT6dqDUnW8cPmN0abiXHdzjwk=;
        b=Xf4oaV0iWowv1zuIQg4Gno96EEa2UOzVcjGCbr7wx7YywJjjyhf5NP4AAIDoyPPWKL
         0e8EG2P0sZuJ3a5YbyQ6BL+s487lC/mN27EiSdk7ymSlXP2of0n/2Vvz5E9vb0Agvn+8
         Ak0whDxng5dTS8E/K6zt0GKFLYeVEbXxvV2p02FN9zerQ0Kq3hDhTDOtzjd+v3biCZDz
         yHiVqR3Q2KspGkBs+JY90o0Kx1pM+4xKuk1//eamiMgkIOO5HQAjMznRc5J/rSz3MP6z
         +qw9tqpsuu69tjFkxiVBZFlwFmRuuC9AbrZ1Rs1p3IE1o+1yDxxrnmhTDjnnJft2ijZL
         DR0g==
X-Forwarded-Encrypted: i=1; AJvYcCVUr6oMgjIvtHwYu2BhxGq4/nmLYw2p4wQWttgLtmKM67aOBQlbR81RVS2iPvZVXh0BItxoCdxDePLXFVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ9wq7tx52pWkVxcOikJ4xMvm8PRxaTqEMXsAx/EoHG5S3MqhG
	wSUvSVWc9aLk7jvU0H4ghqD4SYA7hfn7ggj+BdiAf9zZQyXjwSDwryqjZDDk139+Qs8c5NlYee+
	x3xaQEGkdU/gHHhr5xOiWDg9f658+CI2XDsSgpLAUL0gjdB9enGkHGylqZThSaJpm9yo=
X-Gm-Gg: ASbGncv5HPmanexerVsHrlEvtKtNRptnqL/IG87GxKI9rbebGv7/pW+JbJ+XQJjxqvl
	a9pb+25b5GCay2gzGRgK+y68MP/I70F76gv7JQvpXH1FzzzSCefnGvlN7VNgx7t8nOLkywslnkO
	1bFIiLBIIayfC+xsxEsiHiNkEZ89kuwWFh+waSFTOSif+nvbvoVwhDVRxlZBwaIHt6p1PDxosAw
	NFymxKbYMbgPkUlff0ff/oSCLhv2vWIp+h9jh79umY5MLcFn+uqAY7OVVHJ+/fRXyHMdzEipdCR
	hoe1iy1g7PKaT7fZ2m54C4cZOGK/ObYhuGjNYkmzzBcRBnyltvkI7UbTXbo+EpPT7GFQQHXkyCU
	adpQdNOStGHzPPw==
X-Received: by 2002:a17:902:d50a:b0:257:3283:b859 with SMTP id d9443c01a7336-269ba51e02amr28034875ad.9.1758291932307;
        Fri, 19 Sep 2025 07:25:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9k4V4LZwBj1bALmJjwm4mvgiiPZwxFTRvqIpmloNrIs+Hb4ymL2uQ5u+YSKVtkdkkR3g1AA==
X-Received: by 2002:a17:902:d50a:b0:257:3283:b859 with SMTP id d9443c01a7336-269ba51e02amr28034505ad.9.1758291931764;
        Fri, 19 Sep 2025 07:25:31 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26e80409ee3sm2210035ad.80.2025.09.19.07.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 07:25:31 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Fri, 19 Sep 2025 22:24:21 +0800
Subject: [PATCH v5 04/14] phy: qcom: qmp-usbc: Add regulator init_load
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-add-displayport-support-for-qcs615-platform-v5-4-eae6681f4002@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758291894; l=5441;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=ScND5R19fNR4fxgqnX3CVdg+GNtnOHYJhlmcXMGybGg=;
 b=wIVCw4xJblRND34EU16CJTmhIw8JDc0MbkTUUnrROQg12ldbCsU5AI3GCnUxeFAB2KaokwrJH
 BcP3XpKuLGCCUc8PrxsNSVqnrt+tTEUsqjdyDcd3dFCyEhdcyxdUsPw
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Authority-Analysis: v=2.4 cv=HbIUTjE8 c=1 sm=1 tr=0 ts=68cd67dd cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=6BFfyeCpfu5Dl7vuC9UA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX/Fy9xXotZda0
 FSX3LN0cjzxuVNgA8p9d3j3Z1O4Zs/jN/l8WjleO6ZdbkRYArZVr2ob+KsSY1MeaKAOwtgcUw/N
 XFeGrJpHbTnasZCA13Nt0zI1dfdcWIgXHeMRD0czN976TH4gyxQhEWfCUTb4gnx6bgKqb6gSvM4
 CyIscwYYrISBl9DMp55hQut3Rn7pOtLNL5XBeNuiCw82Ue4284nOsBTAppwoth80UV2cOJgPry4
 z3bV/SfAplomurfj0SObRmwK9HtNNeV/5QcN/f0wMdcTWKDtFYQ28CWMIUQEqI9HdQZJAXLYTDB
 bHyQULctOD8h/Wsl5BM6ZIkQyZMax08092ub2Mnk9byHZZ4yRph3mSfyyarwSZvcNa0xMDhyFKh
 NuPnFZrv
X-Proofpoint-GUID: 5xavra7n4VbJLTb3Hu6iV4dvAl9UVB1E
X-Proofpoint-ORIG-GUID: 5xavra7n4VbJLTb3Hu6iV4dvAl9UVB1E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

QMP USBC PHY drivers previously did not set init_load_uA for regulators,
which could result in incorrect vote levels. This patch introduces
regulator definitions with proper init_load_uA values based on each
chip's power grid design.

QCS615 USB3 PHY was previously reusing qcm2290_usb3phy_cfg, but its
regulator requirements differ. A new qcs615_usb3phy_cfg is added to
reflect the correct settings.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 68 ++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
index de28c3464a40ea97740e16fe78cba4b927911d92..3b48c69f9c3cb7daec495ebc281b83fe34e56881 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
@@ -336,7 +336,7 @@ struct qmp_phy_cfg {
 	int (*calibrate_dp_phy)(struct qmp_usbc *qmp);
 
 	/* regulators to be requested */
-	const char * const *vreg_list;
+	const struct regulator_bulk_data *vreg_list;
 	int num_vregs;
 
 	/* array of registers with different offsets */
@@ -428,9 +428,19 @@ static const char * const usb3phy_reset_l[] = {
 	"phy_phy", "phy",
 };
 
-/* list of regulators */
-static const char * const qmp_phy_vreg_l[] = {
-	"vdda-phy", "vdda-pll",
+static const struct regulator_bulk_data qmp_phy_msm8998_vreg_l[] = {
+	{ .supply = "vdda-phy", .init_load_uA = 68600 },
+	{ .supply = "vdda-pll", .init_load_uA = 14200 },
+};
+
+static const struct regulator_bulk_data qmp_phy_sm2290_vreg_l[] = {
+	{ .supply = "vdda-phy", .init_load_uA = 66100 },
+	{ .supply = "vdda-pll", .init_load_uA = 13300 },
+};
+
+static const struct regulator_bulk_data qmp_phy_qcs615_vreg_l[] = {
+	{ .supply = "vdda-phy", .init_load_uA = 50000 },
+	{ .supply = "vdda-pll", .init_load_uA = 20000 },
 };
 
 static const struct qmp_usbc_offsets qmp_usbc_offsets_v3_qcm2290 = {
@@ -454,8 +464,8 @@ static const struct qmp_phy_cfg msm8998_usb3phy_cfg = {
 	.rx_tbl_num             = ARRAY_SIZE(msm8998_usb3_rx_tbl),
 	.pcs_tbl                = msm8998_usb3_pcs_tbl,
 	.pcs_tbl_num            = ARRAY_SIZE(msm8998_usb3_pcs_tbl),
-	.vreg_list              = qmp_phy_vreg_l,
-	.num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
+	.vreg_list              = qmp_phy_msm8998_vreg_l,
+	.num_vregs              = ARRAY_SIZE(qmp_phy_msm8998_vreg_l),
 	.regs                   = qmp_v3_usb3phy_regs_layout,
 };
 
@@ -470,8 +480,8 @@ static const struct qmp_phy_cfg qcm2290_usb3phy_cfg = {
 	.rx_tbl_num		= ARRAY_SIZE(qcm2290_usb3_rx_tbl),
 	.pcs_tbl		= qcm2290_usb3_pcs_tbl,
 	.pcs_tbl_num		= ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
-	.vreg_list		= qmp_phy_vreg_l,
-	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.vreg_list		= qmp_phy_sm2290_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_sm2290_vreg_l),
 	.regs			= qmp_v3_usb3phy_regs_layout_qcm2290,
 };
 
@@ -486,8 +496,24 @@ static const struct qmp_phy_cfg sdm660_usb3phy_cfg = {
 	.rx_tbl_num		= ARRAY_SIZE(sdm660_usb3_rx_tbl),
 	.pcs_tbl		= qcm2290_usb3_pcs_tbl,
 	.pcs_tbl_num		= ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
-	.vreg_list		= qmp_phy_vreg_l,
-	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.vreg_list		= qmp_phy_msm8998_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_msm8998_vreg_l),
+	.regs			= qmp_v3_usb3phy_regs_layout_qcm2290,
+};
+
+static const struct qmp_phy_cfg qcs615_usb3phy_cfg = {
+	.offsets		= &qmp_usbc_offsets_v3_qcm2290,
+
+	.serdes_tbl		= qcm2290_usb3_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(qcm2290_usb3_serdes_tbl),
+	.tx_tbl			= qcm2290_usb3_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(qcm2290_usb3_tx_tbl),
+	.rx_tbl			= qcm2290_usb3_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(qcm2290_usb3_rx_tbl),
+	.pcs_tbl		= qcm2290_usb3_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
+	.vreg_list		= qmp_phy_qcs615_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_qcs615_vreg_l),
 	.regs			= qmp_v3_usb3phy_regs_layout_qcm2290,
 };
 
@@ -773,23 +799,6 @@ static const struct dev_pm_ops qmp_usbc_pm_ops = {
 			   qmp_usbc_runtime_resume, NULL)
 };
 
-static int qmp_usbc_vreg_init(struct qmp_usbc *qmp)
-{
-	const struct qmp_phy_cfg *cfg = qmp->cfg;
-	struct device *dev = qmp->dev;
-	int num = cfg->num_vregs;
-	int i;
-
-	qmp->vregs = devm_kcalloc(dev, num, sizeof(*qmp->vregs), GFP_KERNEL);
-	if (!qmp->vregs)
-		return -ENOMEM;
-
-	for (i = 0; i < num; i++)
-		qmp->vregs[i].supply = cfg->vreg_list[i];
-
-	return devm_regulator_bulk_get(dev, num, qmp->vregs);
-}
-
 static int qmp_usbc_reset_init(struct qmp_usbc *qmp,
 			      const char *const *reset_list,
 			      int num_resets)
@@ -1097,7 +1106,8 @@ static int qmp_usbc_probe(struct platform_device *pdev)
 
 	mutex_init(&qmp->phy_mutex);
 
-	ret = qmp_usbc_vreg_init(qmp);
+	ret = devm_regulator_bulk_get_const(qmp->dev, qmp->cfg->num_vregs,
+					 qmp->cfg->vreg_list, &qmp->vregs);
 	if (ret)
 		return ret;
 
@@ -1163,7 +1173,7 @@ static const struct of_device_id qmp_usbc_of_match_table[] = {
 		.data = &qcm2290_usb3phy_cfg,
 	}, {
 		.compatible = "qcom,qcs615-qmp-usb3-phy",
-		.data = &qcm2290_usb3phy_cfg,
+		.data = &qcs615_usb3phy_cfg,
 	}, {
 		.compatible = "qcom,sdm660-qmp-usb3-phy",
 		.data = &sdm660_usb3phy_cfg,

-- 
2.34.1


