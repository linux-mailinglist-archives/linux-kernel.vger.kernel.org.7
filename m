Return-Path: <linux-kernel+bounces-812342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEAEB536A1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C76A03794
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE18D346A07;
	Thu, 11 Sep 2025 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g8jl3gUW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A908350D6C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602599; cv=none; b=qxePHFHi9iXprV1ynCw5EQ0MhSbtATwnqQ14JQouhhZfeTv6dLxvOUUmOl2Ao+hP4Zs7mvssw4skxeUi2uPid9Y9JW0wCiQo+fIe+hDCjJN9QINroLWg7qOFrObkoRFQM6FcSvQpJKzboJLItbJfYg9NQHqvkq/ZxPo7wioYEdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602599; c=relaxed/simple;
	bh=mc60fbGnoAVEo5yG+c12CgJyqEsRxFDHJbOqeLy8ArY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WqLBcT6YGZWPaipmdY8/UGzL6JVgUQcBp9o5Felk1qWOgb7vznz8psR1WPtx1uYNEINDCMZqTsRlCoo5C7ffM8KMEKAZ2LAbxQWpODU3BOYrPy7N42pFt32Ooyu7OL2FbXylfQ/bqGlR3wwBBslvO/Q/r4b3Xg7qsSgRgG/R6QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g8jl3gUW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BAUJ4I002273
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZNQeat9pvNbPTog67roy6KckIEGxAOnd4dbWmMxr+og=; b=g8jl3gUWF+B7wb/t
	Y57wnvQ5U4L4AugZpZa+RZfiGF0E7U+eY+fEk8nF+CCnuwVhspCB9b/KsrWbHAeQ
	NunepMkLfx37O5rjegq0gVYaK98s6ymDUPhnCDof8usvT8jFGNSPxcjoXCuJoDCy
	R/c04/vRlJGTdNfJCZPHQuiMtAISC5wbJOPhayat+lBDP+4zDgdUn9KqxtNLs4JZ
	Su7kpuHs7Etl+a9HxHzaOxk3ELc0eNEAkouLIi26VVXRfav4k26MoQaubnpsJ8iY
	ZIw1lN27ZtcFgl2r4Ta2HmArpNKBehf77ei+JN0zeNNdyXAGAw6Tvisq93dUv8Mi
	91y53w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8r794-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:56:36 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32559972951so228474a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757602595; x=1758207395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNQeat9pvNbPTog67roy6KckIEGxAOnd4dbWmMxr+og=;
        b=Q5xRKYRGD+JPfe8b3TRtwDav3C5PKblBiKglOKvJ5SVn6TVhb0gmbgGHVjHtlR2gfW
         rkQqYBUOY+D5qtlsNddRh8mgTtA752SiGvB1FAEJpN2s2d7reQZLK9rtuGQR+8oY7akh
         Jjko1djJKyQL8GrDElyP08q5H4V2A5m99gYsBIXmXzMvODAVV1aT1gQVSBUPmP3q98Kg
         1042Yg3t+5OMflZRKcTshQAaX74sPTTh2azfQc9MkGtjnL1XvVS4pon9ji4u5KVWPwsp
         9FznQBpr6RUO/HAUuZeQosGP5qQgmVGWtISQVrmD8ISdS7MHJg9yNaHlknGzKgnJ/tsY
         tZeg==
X-Forwarded-Encrypted: i=1; AJvYcCXgg+VzAqycZ9pgVjFjs4oxy1l5db7qUdfXniKdxmBCZGYgoiIIAiSF3Cg0mmwfwgEW3YSM0hhSgvkRfh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YykYt/64kcm58oiP7da6aA8GSCFxjexnSI0Nb5snzUiwpufrF4/
	cxEfSv5FjMoOju8GSut8xy1am1ccU2DFQPC5mWPQnKfU6pzfaWb+sqKs0oS822G+JvO9PuVPPEJ
	Mo4O37L19gr1Itz1BI/2R9YIGtE2HP/ayDqEooKz7BciwAGdw2j03s4fJrdfSTnoFc7LXAoPAi1
	A=
X-Gm-Gg: ASbGncuj0upNBphEuiBI4Pr2Zk6EKLWUTOfSvfzSao736SdZxeq05L8I7bJ9cLSjFTx
	wXxlDm2g8j9zkjraCFn6FZEC0zyiA1+oA3VvmZCPqBGAvKiylzmCz0eFtNxBHWfbUmCvcaAZQ6o
	iGrjDTDX529xW6itgm9idAjkN1AgYJ0J6Gwxpku9gDtEaOdXxyOQtCS1QVSL4j3uNq2+AEgjLoI
	gE4mqfT8YR+YqINhbfATxysbsHPI+fsA6rr2I/hU3OMCYLGpVU/b13E1XsOa84Q+YGD+H5o6J2G
	msZBDzGZGXf5heFZ/b0FVwoO92nZyaDQo0b0Ib9hAwJGMCrSfLX5i4PBpDZF/UNSYt6+ZmlXgzx
	ENknhVXfiu8rHVCXV4wR/yZlQuLyODoETceYIpJNtoaNQIeIMmAXbacry
X-Received: by 2002:a17:90b:1e53:b0:32b:7082:b4 with SMTP id 98e67ed59e1d1-32d43eff842mr15045416a91.1.1757602594591;
        Thu, 11 Sep 2025 07:56:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvB0n9NMJS1ssPh6TYrlAyonIfVRXAMxAbAlgyzpNBDjSW1xB+NeJwGODHWLYzvOXf9ftkFw==
X-Received: by 2002:a17:90b:1e53:b0:32b:7082:b4 with SMTP id 98e67ed59e1d1-32d43eff842mr15045398a91.1.1757602594070;
        Thu, 11 Sep 2025 07:56:34 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a387cd4bsm2107453a12.35.2025.09.11.07.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 07:56:33 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 22:55:06 +0800
Subject: [PATCH v4 09/13] phy: qcom: qmp-usbc: Add TCSR parsing and PHY
 mode setting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-add-displayport-support-for-qcs615-platform-v4-9-2702bdda14ed@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757602528; l=4233;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=mc60fbGnoAVEo5yG+c12CgJyqEsRxFDHJbOqeLy8ArY=;
 b=SBS1/8HrXVaD6s2hujd4K482pOZYmdQ76wxvNB8nYNvez9CiGfPDcHnXCpjF5aCAf5pHlWsYG
 VudOVMF1sUvD28zAAEmVHwrpU/l47Mo4Xn3Ozy2hOioRZYXiYluCkkq
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX0RS6qa5RzIO5
 zNoOg5ZMs3yGQe+Mp/jjz70IaNVoqdLU55gRKW8g/Ys2Z6OQHgZN2GWADRheCiMyOr7on78+H/Y
 mGEw7B/zBHCzYwXE4uC7Vna+FIQ5pNj27Z8Z8ALske9J6x9LnPy9ohv8GO1zZgioRvC+PdB4tM+
 99jjiEtAIaNHSdHlRrmAN5kQg5/ssJ8PsCG9WVkjqOzCd+VzOFtSzzvdC2C+Mhw9U132vf/Ykbq
 SzPTgrMydu/TVK0VeffeU/8z52NvSnId3EWeUpzbXSPk6TWgTRusMvyHDQA59cnN5kE4z2l5RV0
 FytC1qmbSb+tNOSqZDF4v2UXIk5953AT1Ax2xqgTg7AYR7mZW1FU23wQF4ZNFsXqK+BqkP0hAnS
 ZXvXf8Sh
X-Proofpoint-ORIG-GUID: hczVHZXgw2fIw4dLytMekr1YwmZv33Wl
X-Proofpoint-GUID: hczVHZXgw2fIw4dLytMekr1YwmZv33Wl
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68c2e324 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=ADjXBmbmjA5MTMSrQwQA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

Parse TCSR registers to support DP mode signaling via dp_phy_mode_reg.
Move USB PHY-only register configuration from com_init to
qmp_usbc_usb_power_on.

Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 47 ++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
index 95a099de908e7f3478eb1e18326b21d4014d8da6..c57596fe0d5cd5c15105ad8183ccdc047953e4d5 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
@@ -33,6 +33,8 @@
 #include "phy-qcom-qmp-dp-phy-v2.h"
 
 #define PHY_INIT_COMPLETE_TIMEOUT		10000
+#define SW_PORTSELECT_VAL			BIT(0)
+#define SW_PORTSELECT_MUX			BIT(1)
 
 /* set of registers with offsets different per-PHY */
 enum qphy_reg_layout {
@@ -686,12 +688,16 @@ static const struct qmp_phy_cfg qcs615_usb3dp_phy_cfg = {
 	.num_vregs		= ARRAY_SIZE(qmp_phy_qcs615_vreg_l),
 };
 
+static void qmp_usbc_set_phy_mode(struct qmp_usbc *qmp, bool is_dp)
+{
+	if (qmp->tcsr_map && qmp->dp_phy_mode_reg)
+		regmap_write(qmp->tcsr_map, qmp->dp_phy_mode_reg, is_dp);
+}
+
 static int qmp_usbc_com_init(struct phy *phy)
 {
 	struct qmp_usbc *qmp = phy_get_drvdata(phy);
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
-	void __iomem *pcs = qmp->pcs;
-	u32 val = 0;
 	int ret;
 
 	ret = regulator_bulk_enable(cfg->num_vregs, qmp->vregs);
@@ -716,16 +722,6 @@ static int qmp_usbc_com_init(struct phy *phy)
 	if (ret)
 		goto err_assert_reset;
 
-	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL], SW_PWRDN);
-
-#define SW_PORTSELECT_VAL			BIT(0)
-#define SW_PORTSELECT_MUX			BIT(1)
-	/* Use software based port select and switch on typec orientation */
-	val = SW_PORTSELECT_MUX;
-	if (qmp->orientation == TYPEC_ORIENTATION_REVERSE)
-		val |= SW_PORTSELECT_VAL;
-	writel(val, qmp->pcs_misc);
-
 	return 0;
 
 err_assert_reset:
@@ -996,6 +992,14 @@ static int qmp_usbc_usb_power_on(struct phy *phy)
 	unsigned int val;
 	int ret;
 
+	qphy_setbits(qmp->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL], SW_PWRDN);
+
+	/* Use software based port select and switch on typec orientation */
+	val = SW_PORTSELECT_MUX;
+	if (qmp->orientation == TYPEC_ORIENTATION_REVERSE)
+		val |= SW_PORTSELECT_VAL;
+	writel(val, qmp->pcs_misc);
+
 	qmp_configure(qmp->dev, qmp->serdes, cfg->serdes_tbl,
 		      cfg->serdes_tbl_num);
 
@@ -1068,6 +1072,8 @@ static int qmp_usbc_usb_enable(struct phy *phy)
 	if (ret)
 		goto out_unlock;
 
+	qmp_usbc_set_phy_mode(qmp, false);
+
 	ret = qmp_usbc_usb_power_on(phy);
 	if (ret) {
 		qmp_usbc_com_exit(phy);
@@ -1493,6 +1499,7 @@ static int qmp_usbc_typec_switch_set(struct typec_switch_dev *sw,
 		qmp_usbc_com_exit(qmp->usb_phy);
 
 		qmp_usbc_com_init(qmp->usb_phy);
+		qmp_usbc_set_phy_mode(qmp, false);
 		qmp_usbc_usb_power_on(qmp->usb_phy);
 	}
 
@@ -1634,15 +1641,16 @@ static int qmp_usbc_parse_dt(struct qmp_usbc *qmp)
 	return 0;
 }
 
-static int qmp_usbc_parse_vls_clamp(struct qmp_usbc *qmp)
+static int qmp_usbc_parse_tcsr(struct qmp_usbc *qmp)
 {
 	struct of_phandle_args tcsr_args;
 	struct device *dev = qmp->dev;
-	int ret;
+	int ret, args_count;
 
-	/*  for backwards compatibility ignore if there is no property */
-	ret = of_parse_phandle_with_fixed_args(dev->of_node, "qcom,tcsr-reg", 1, 0,
-					       &tcsr_args);
+	args_count = of_property_count_u32_elems(dev->of_node, "qcom,tcsr-reg");
+	args_count = args_count - 1;
+	ret = of_parse_phandle_with_fixed_args(dev->of_node, "qcom,tcsr-reg",
+					       args_count, 0, &tcsr_args);
 	if (ret == -ENOENT)
 		return 0;
 	else if (ret < 0)
@@ -1655,6 +1663,9 @@ static int qmp_usbc_parse_vls_clamp(struct qmp_usbc *qmp)
 
 	qmp->vls_clamp_reg = tcsr_args.args[0];
 
+	if (args_count > 1)
+		qmp->dp_phy_mode_reg = tcsr_args.args[1];
+
 	return 0;
 }
 
@@ -1694,7 +1705,7 @@ static int qmp_usbc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = qmp_usbc_parse_vls_clamp(qmp);
+	ret = qmp_usbc_parse_tcsr(qmp);
 	if (ret)
 		return ret;
 

-- 
2.34.1


