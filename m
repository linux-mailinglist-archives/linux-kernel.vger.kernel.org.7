Return-Path: <linux-kernel+bounces-812338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AFCB5369A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDCB01C83DF2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D09A345752;
	Thu, 11 Sep 2025 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jN8hU3Ga"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5211A34AB17
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602579; cv=none; b=VSTldKwpYDwbE46tdoqS9M720MHMgYZQMfYGx9HL7Qc8En+ORI2+jS5ihHjoY0zod0kA+3/oLU2XZb+rGvX7nB3jTW9heRknlB/1r+VmOEOCFcoRk3FZvZj8Olf2+DmhG8+91EXHfgAY3IIyGWdxX7CjyftpVsDilo0jKZK75ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602579; c=relaxed/simple;
	bh=OWt9kB48mzxxvjrBaY3xyKfETt0QdvzjmmLgaJWlQh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wp0glYxb1dKUD6gyCsznlt9Zi5+MClPp/EC9Gjc93P4v0JccwdRhADB6qvjuy0E06jVvdbG6hiEwTKZtQN/gaEnkei5+VkN02e+NCIe2puhFDuygaTk/sl87D+3wmJLFhe338q3KZW2GtQO/UD+zAcOzcE8B19mKLLb4KPy1/Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jN8hU3Ga; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BAYncY006675
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CAnh39HSsou7guKP6/W0eKgu+3fgE+UqRuEA8rEgyiA=; b=jN8hU3Ga6Ly7uEfS
	0PzCS+XAAwH29rZM14zUuIWeWRyXh56YntI05tJEXl+PLkWR5p8wRsuK/giRrq/g
	HoDSYFNoD00sFyq8fq8ZRLUC8IFdC5oRgkDnAKERaU/buDzjJFvOaKJ75rbb4eZi
	F/+rT+OcgwAIcZ4p3MBc8mWzqYuRox0UwzeyT0QAZ/zFnb3cgm2hqiU049T/J5cL
	YbsgL+c+3V5rxKTyKtLtHopS0CKjkj/eNNpa6G3ls8F6og3u0ThW5zAv93efKk0g
	2sOaC4MqDN6SpW3QJKkM04oueNGf4ylqX+9JBm19PCiVnqUEMAwaQ+YM/mFAwjvd
	sSXAyA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8ag56d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:56:15 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-25aadf13424so1649225ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757602575; x=1758207375;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAnh39HSsou7guKP6/W0eKgu+3fgE+UqRuEA8rEgyiA=;
        b=uc+NdAINIvzfpO/LngIrwmWqyepRwYeBg0jOojbmofn7iUYTi9pbyIcK4M/HDVC3pf
         /HixQ8E0z/ANlVvDwxxH/C2UUYgVofYQL6A/KZG0dte/0qFsqKgd6SJzGeF+7oyId/L2
         0WYIRwc5Ie7jPWTNt4pwyVfGeUAXNtl6MwbZupkqHbC0zIU6DQK+yVbu0nxkytmy3UO3
         f454+Pw2g90rZ142hxbG/PB7Ctxu4URAZl7JpcWaFr0aTHT0ROGAAgyAcOrDRI6TM7rT
         LlX09SylyjN0qIiMGNWIbgXcaoCv06tq64Mx9ZoiGpKYngjYsCsTPy1UFQkqflL7ySRy
         r8tg==
X-Forwarded-Encrypted: i=1; AJvYcCVLgUc1SB8bCfgq3WBcbpdwHWarkjO4HGDf9XZRe4Uyu6irxiLjftTtAwxgz5ttb7I80ATnahzs8qUxCD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj4BytyDzl4g0DKgBpfivFPQjJbVxvkaNBXmbca0AkrJbOjbil
	tJ1SXCH1nQ6Qqvpnn0LNbaJ26G7wWWY8H2jqAi/N0wXMnFCZXPzZBbRv4zUm0Y2iNWGdbMHef2g
	KNllD/MZe1xtUGFoxgm3X3fLydq9JUWF30eWXft7ReFEuEFXsYdzq/3MksOaEmHpI3tQ=
X-Gm-Gg: ASbGncvrVB5reJVlWQXvcW+nkx/5Yk9T8wHO/dhKqvC2KKfDZoFxV1fcRJ/ulSw9JPz
	TMGa2BqjdC54fEKzQKfkXh+rXuhHKuMWldg1qaUtX1TQI7BvwO30kHZFApoaCOQkJbBJ/S/ttjj
	cgn9dKvwFv9k1Je1qL8Rn1UAUtKgjI+ezn8S1CbmB5ZoGWKiEvIGaEazrvHkMAyGewW+5fMo/sk
	Vl7AWVd2MJl45ZNNtdWMNiKat7FSBCejDeW4UBJqiSxwFIydwWbK1N//8sI06unRJRQyWZGniAz
	f15OzaZ5Wutlp9Xza2M0tSYNZPUwGnYyMkWUarE1LxgOM9wWd/TKwEvocBvEDjOTe3S/ypXaYEA
	78rh5SscSvYAMeSNG6y0rb4n2eA+oie+6agLSDXRbJzfmEVufrUlhMqPV
X-Received: by 2002:a17:902:c40b:b0:243:589d:148e with SMTP id d9443c01a7336-2516f23de24mr133000265ad.5.1757602574669;
        Thu, 11 Sep 2025 07:56:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUFTTFMQ2rdWbNsDbWngOPJ2WH+IaqettH8JeXlHbxDgg3kXL8d6vzlVpeg48nFbm+O4tliw==
X-Received: by 2002:a17:902:c40b:b0:243:589d:148e with SMTP id d9443c01a7336-2516f23de24mr132999835ad.5.1757602574070;
        Thu, 11 Sep 2025 07:56:14 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a387cd4bsm2107453a12.35.2025.09.11.07.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 07:56:13 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 22:55:03 +0800
Subject: [PATCH v4 06/13] phy: qcom: qmp-usbc: Move reset config into PHY
 cfg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-add-displayport-support-for-qcs615-platform-v4-6-2702bdda14ed@oss.qualcomm.com>
References: <20250911-add-displayport-support-for-qcs615-platform-v4-0-2702bdda14ed@oss.qualcomm.com>
In-Reply-To: <20250911-add-displayport-support-for-qcs615-platform-v4-0-2702bdda14ed@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
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
        li.liu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757602527; l=6897;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=OWt9kB48mzxxvjrBaY3xyKfETt0QdvzjmmLgaJWlQh0=;
 b=KGI7fDuTXIC9M5EO9nZ+gm6xulQkGDTUo93FCzKvlUkt4ubvrY9zrKkv3xs4QtYBJf8NpMz5f
 eFtIBPbiNe9ALJDF8q8xE0SgYadPXCNSw8IxQZmqKrapSxh2WAtFU61
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68c2e30f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=-_sGn0fMRN9O-kufMFcA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: lBeo7rx7l3d0muBgebgIpzko5Wn86IQx
X-Proofpoint-ORIG-GUID: lBeo7rx7l3d0muBgebgIpzko5Wn86IQx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfX4K3HfuMMKNMQ
 J1EfLOxS2uHJarUiZGjTg3dkdqXvfqbDIUSV/hFx0KUd4ovUK8V7l7KvWMy2nh6+4K1skQK1ecK
 ZeC1XuFVNyeIb0tI3O9fURBQX8J7LbHU6ji0WFHfSeWczqA7mrn8z+1I0CCF3lhS9FqqWiIohpB
 dAKrYs9hdIm/wsoB4tOQXfUE2Jz1EI92VDVQN3vNW/s9WUAo/RTC8B+uKjkywMrMvrcc705fDu/
 kzVqh90b9cJ2fQ7HIlRg49sgdIWyBtVcEVU1gB3SjqI2LHDLhnGxoJQvjkIOhw4b6BFJZbw4n1H
 1gXAbHarGjvLkz9lPi1OaxGr5fWC1KZkazeR0u238D9sf3uLR6++TDN9+8rIAIauC6nLYRQQmL+
 ooTZe+JF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039

Move reset configuration to be managed via qmp_phy_cfg instead of
hardcoded lists. This enables per-PHY customization and simplifies
initialization logic for USB-only and USB/DP switchable PHYs.

Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 56 ++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
index 23a0efa7fc4418f379ac4c02fd92080c7755dead..663024b8c09124f2991b8e0537a9feb60baaa686 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
@@ -415,7 +415,8 @@ struct qmp_phy_cfg {
 	int (*configure_dp_phy)(struct qmp_usbc *qmp);
 	int (*calibrate_dp_phy)(struct qmp_usbc *qmp);
 
-	/* regulators to be requested */
+	const char * const *reset_list;
+	int num_resets;
 	const struct regulator_bulk_data *vreg_list;
 	int num_vregs;
 
@@ -447,7 +448,6 @@ struct qmp_usbc {
 	struct clk_hw dp_pixel_hw;
 	struct clk_bulk_data *clks;
 	int num_clks;
-	int num_resets;
 	struct reset_control_bulk_data *resets;
 	struct regulator_bulk_data *vregs;
 
@@ -508,6 +508,10 @@ static const char * const usb3phy_reset_l[] = {
 	"phy_phy", "phy",
 };
 
+static const char * const usb3dpphy_reset_l[] = {
+	"phy_phy", "dp_phy",
+};
+
 static const struct regulator_bulk_data qmp_phy_msm8998_vreg_l[] = {
 	{ .supply = "vdda-phy", .init_load_uA = 68600 },
 	{ .supply = "vdda-pll", .init_load_uA = 14200 },
@@ -572,6 +576,8 @@ static const struct qmp_phy_cfg msm8998_usb3phy_cfg = {
 	.rx_tbl_num             = ARRAY_SIZE(msm8998_usb3_rx_tbl),
 	.pcs_tbl                = msm8998_usb3_pcs_tbl,
 	.pcs_tbl_num            = ARRAY_SIZE(msm8998_usb3_pcs_tbl),
+	.reset_list		= usb3phy_reset_l,
+	.num_resets		= ARRAY_SIZE(usb3phy_reset_l),
 	.vreg_list              = qmp_phy_msm8998_vreg_l,
 	.num_vregs              = ARRAY_SIZE(qmp_phy_msm8998_vreg_l),
 	.regs                   = qmp_v3_usb3phy_regs_layout,
@@ -588,6 +594,8 @@ static const struct qmp_phy_cfg qcm2290_usb3phy_cfg = {
 	.rx_tbl_num		= ARRAY_SIZE(qcm2290_usb3_rx_tbl),
 	.pcs_tbl		= qcm2290_usb3_pcs_tbl,
 	.pcs_tbl_num		= ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
+	.reset_list		= usb3phy_reset_l,
+	.num_resets		= ARRAY_SIZE(usb3phy_reset_l),
 	.vreg_list		= qmp_phy_sm2290_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_sm2290_vreg_l),
 	.regs			= qmp_v3_usb3phy_regs_layout_qcm2290,
@@ -604,6 +612,8 @@ static const struct qmp_phy_cfg sdm660_usb3phy_cfg = {
 	.rx_tbl_num		= ARRAY_SIZE(sdm660_usb3_rx_tbl),
 	.pcs_tbl		= qcm2290_usb3_pcs_tbl,
 	.pcs_tbl_num		= ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
+	.reset_list		= usb3phy_reset_l,
+	.num_resets		= ARRAY_SIZE(usb3phy_reset_l),
 	.vreg_list		= qmp_phy_msm8998_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_msm8998_vreg_l),
 	.regs			= qmp_v3_usb3phy_regs_layout_qcm2290,
@@ -620,6 +630,8 @@ static const struct qmp_phy_cfg qcs615_usb3phy_cfg = {
 	.rx_tbl_num		= ARRAY_SIZE(qcm2290_usb3_rx_tbl),
 	.pcs_tbl		= qcm2290_usb3_pcs_tbl,
 	.pcs_tbl_num		= ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
+	.reset_list		= usb3phy_reset_l,
+	.num_resets		= ARRAY_SIZE(usb3phy_reset_l),
 	.vreg_list		= qmp_phy_qcs615_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_qcs615_vreg_l),
 	.regs			= qmp_v3_usb3phy_regs_layout_qcm2290,
@@ -653,6 +665,9 @@ static const struct qmp_phy_cfg qcs615_usb3dp_phy_cfg = {
 
 	.swing_tbl		= &qmp_dp_voltage_swing_hbr2_rbr,
 	.pre_emphasis_tbl	= &qmp_dp_pre_emphasis_hbr2_rbr,
+
+	.reset_list		= usb3dpphy_reset_l,
+	.num_resets		= ARRAY_SIZE(usb3dpphy_reset_l),
 	.vreg_list		= qmp_phy_qcs615_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_qcs615_vreg_l),
 };
@@ -671,13 +686,13 @@ static int qmp_usbc_com_init(struct phy *phy)
 		return ret;
 	}
 
-	ret = reset_control_bulk_assert(qmp->num_resets, qmp->resets);
+	ret = reset_control_bulk_assert(cfg->num_resets, qmp->resets);
 	if (ret) {
 		dev_err(qmp->dev, "reset assert failed\n");
 		goto err_disable_regulators;
 	}
 
-	ret = reset_control_bulk_deassert(qmp->num_resets, qmp->resets);
+	ret = reset_control_bulk_deassert(cfg->num_resets, qmp->resets);
 	if (ret) {
 		dev_err(qmp->dev, "reset deassert failed\n");
 		goto err_disable_regulators;
@@ -700,7 +715,7 @@ static int qmp_usbc_com_init(struct phy *phy)
 	return 0;
 
 err_assert_reset:
-	reset_control_bulk_assert(qmp->num_resets, qmp->resets);
+	reset_control_bulk_assert(cfg->num_resets, qmp->resets);
 err_disable_regulators:
 	regulator_bulk_disable(cfg->num_vregs, qmp->vregs);
 
@@ -712,7 +727,7 @@ static int qmp_usbc_com_exit(struct phy *phy)
 	struct qmp_usbc *qmp = phy_get_drvdata(phy);
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 
-	reset_control_bulk_assert(qmp->num_resets, qmp->resets);
+	reset_control_bulk_assert(cfg->num_resets, qmp->resets);
 
 	clk_bulk_disable_unprepare(qmp->num_clks, qmp->clks);
 
@@ -939,25 +954,22 @@ static const struct dev_pm_ops qmp_usbc_pm_ops = {
 			   qmp_usbc_runtime_resume, NULL)
 };
 
-static int qmp_usbc_reset_init(struct qmp_usbc *qmp,
-			      const char *const *reset_list,
-			      int num_resets)
+static int qmp_usbc_reset_init(struct qmp_usbc *qmp)
 {
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	struct device *dev = qmp->dev;
 	int i;
 	int ret;
 
-	qmp->resets = devm_kcalloc(dev, num_resets,
+	qmp->resets = devm_kcalloc(dev, cfg->num_resets,
 				   sizeof(*qmp->resets), GFP_KERNEL);
 	if (!qmp->resets)
 		return -ENOMEM;
 
-	for (i = 0; i < num_resets; i++)
-		qmp->resets[i].id = reset_list[i];
+	for (i = 0; i < cfg->num_resets; i++)
+		qmp->resets[i].id = cfg->reset_list[i];
 
-	qmp->num_resets = num_resets;
-
-	ret = devm_reset_control_bulk_get_exclusive(dev, num_resets, qmp->resets);
+	ret = devm_reset_control_bulk_get_exclusive(dev, cfg->num_resets, qmp->resets);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to get resets\n");
 
@@ -1147,11 +1159,6 @@ static int qmp_usbc_parse_dt_legacy(struct qmp_usbc *qmp, struct device_node *np
 
 	qmp->num_clks = ret;
 
-	ret = qmp_usbc_reset_init(qmp, usb3phy_legacy_reset_l,
-				 ARRAY_SIZE(usb3phy_legacy_reset_l));
-	if (ret)
-		return ret;
-
 	return 0;
 }
 
@@ -1191,11 +1198,6 @@ static int qmp_usbc_parse_dt(struct qmp_usbc *qmp)
 				     "failed to get pipe clock\n");
 	}
 
-	ret = qmp_usbc_reset_init(qmp, usb3phy_reset_l,
-				 ARRAY_SIZE(usb3phy_reset_l));
-	if (ret)
-		return ret;
-
 	return 0;
 }
 
@@ -1246,6 +1248,10 @@ static int qmp_usbc_probe(struct platform_device *pdev)
 
 	mutex_init(&qmp->phy_mutex);
 
+	ret = qmp_usbc_reset_init(qmp);
+	if (ret)
+		return ret;
+
 	ret = devm_regulator_bulk_get_const(qmp->dev, qmp->cfg->num_vregs,
 					 qmp->cfg->vreg_list, &qmp->vregs);
 	if (ret)

-- 
2.34.1


