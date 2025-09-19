Return-Path: <linux-kernel+bounces-824702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00950B89F1D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3263D1724D5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10B331329B;
	Fri, 19 Sep 2025 14:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="frgj73cC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35329314D3F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291964; cv=none; b=dI0ZU3zXIOqCUiD1RVniP1DSPj5ypApRF0HQVYZ+EZPznzfJwH1hS70XErevEgj9YeK8eL6XfMHEylQ6kYAk/iWmrHVn6+XJC9vW2fNCMIIyKINg8kaSxcXe8tu1cCJTw3SALXEF9DGUI5I4b5YG6rJ/ahyQfj47GzsBe3awEg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291964; c=relaxed/simple;
	bh=zQm7xoATNcQDtX7SbZxZLRT+sVir+FtQeIRb1OzNIbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qkF1cj4UDSC2+G3Bumovrvq33+8uTndw5h2Q1kWQbn6XwVw8XUny50s5W2ZvvKu5KExP77A2TKnChCtzGcXimeSNZVi331ZzHGKtBuVM3lM+JDVRkabH2RQ3OsFwbAZFslTnfVEsS7wFMkbMKezgE6znkEKQ7ckn3Upb1Ge6rs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=frgj73cC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58J6i89S032414
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vZiouIkqwuEXWY6n8RmAMyZHUHfsJ1HpkFbjJVrd10Q=; b=frgj73cC8TTtvavt
	Wd3nBUlV0Gq9luP56eV27Meg9OMzrCWhXp3RTOSTbtL6LEuGvSqKaYDMCfah0fBi
	VhrW0kK2VCTYjUqqXfEMNONFSf6WR40CsEIipqZDFCF/MCjo/T1/8jOdLv1c0KjH
	CKBrSMUUaNffcdhqMdMATlNQzz7r9lAkzuD0ZLqpNvTrJEzJTjZrVGpMuQ+FT4n4
	j+wqZyy403Msy7Os+QjIOzcAw995kF28E5wZETCqqZ3JVNtU8IaLr5wix8kkbkRI
	fflsEFMOLK3AVpliAXkzrvoVi6XPOPXqOB0xUuOQZI3I/6NnifO/yNaOzRvqATMh
	Gu502g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxytqk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:26:02 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2645223059dso4594745ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758291961; x=1758896761;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZiouIkqwuEXWY6n8RmAMyZHUHfsJ1HpkFbjJVrd10Q=;
        b=tbomnwKX7ZScz4a18wr930Fud7+KYLzV4Lw0txE6f7Ujsh6QHIKBDdE0rr3nRQPxs+
         gY6T4W4eYJqSua1XcEdacox4bBE3OUZjOg5c4r1ij70uxLjFLvh6OSozJukUhORf1Rui
         CLAx4bP2JPAgSWzyseoxvBxsWPDq+wS/nweYNDkC+2z5t6Xo78R7lTjoQTpQi4kk8utc
         VDpGrRG9yvmejjvI7v4JxuxdJS16Lp6kYzk/P+AOtQWSL2zgN1iKC/0HGOe9RK4v08BB
         Sb47LLJGrMk3FYSevpT2VtQxAfMwPh2TrVlQMr5yfOTZOtqwKlEa2xKQALLw7/rXV4V4
         eA6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfFLOOSi+dlGf7wQOKiKxuSVaeRFz3FdEPmW4wRgdHKB4mQiaDVZJOcqXnfszn5/YM+MvL2Byf64G3wNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9VPpvc7vzgB+TUNmF69BZwWAlvkFRPtpJuckWja1WtiWBcZ4S
	zqPQeaCk8o5ZjJOPCp/pJKBOczMp2T/T2IrTK743H01vpEtRFxooRADP5VMoT6qwPyZFTWsIam1
	kcbovt2cdqDTeXawXwucfPGN8FqO5biBOFwH5URKbEkKDPOGJnJJzNKBUtH+GjsQgrFM=
X-Gm-Gg: ASbGnctM2fXoUf9h4Br0+qM8rbmfrBiH0FPeg7HjjBbEtGMPh0KZVqm1neei8xu6+mv
	1LDEKZKCP9vbWBq1EG9eMDOhUbMNN3t/6t1KR8WSrNbpgTfT5GFTwVOxBUw9QAkiqWKWAW9wykN
	X3Sv0Affv42U5o8Ct8CEjbAa+6F5pD7WKLEpACEO/G29KMRolL/xroN2P6kfKj8mC8tYAVrtZTS
	+siGX203WbklEwUyWdI0oELpJb1wXz+8rz1xJJdCJDIwCViV0340tPaUcr0v9fn9tPepLPwCNUn
	NRkBY6aUskBEFzxHM7OeI8vn+Fxp+dpzNIFJQ4zJheQcd4v3fWWe2hqHOHN0ovaVRadi7iqmJ75
	Y83uK83nS6w0ocg==
X-Received: by 2002:a17:903:1cc:b0:253:a668:b638 with SMTP id d9443c01a7336-269ba40ac13mr27964475ad.2.1758291961035;
        Fri, 19 Sep 2025 07:26:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGW/WGzLDodG98wkkzW1+1CcHHUv5fJVGPnsFeMb4qTDtiiEpVeyW35NkEbhYoWwReS8eZH+Q==
X-Received: by 2002:a17:903:1cc:b0:253:a668:b638 with SMTP id d9443c01a7336-269ba40ac13mr27964085ad.2.1758291960575;
        Fri, 19 Sep 2025 07:26:00 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26e80409ee3sm2210035ad.80.2025.09.19.07.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 07:26:00 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Fri, 19 Sep 2025 22:24:25 +0800
Subject: [PATCH v5 08/14] phy: qcom: qmp-usbc: Add TCSR parsing and PHY
 mode setting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-add-displayport-support-for-qcs615-platform-v5-8-eae6681f4002@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758291894; l=2759;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=zQm7xoATNcQDtX7SbZxZLRT+sVir+FtQeIRb1OzNIbI=;
 b=EwyQaS9J5/X0EbdYFn5jwxIbQpOofUaOCkwUg+4xDM9/U/lcsRns9MK9JmlDfzU6LUq1gRmQp
 n87WsJ0jOHcAcGcwXxm927IBd8ngExNLZP6+/NEiEDHieVyW7NStZ8V
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Authority-Analysis: v=2.4 cv=e50GSbp/ c=1 sm=1 tr=0 ts=68cd67fa cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=JdgWeW5AdtZ5oeTK9qIA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: RfiQoaRnZzjME7XTirVKbz802TfNsXcA
X-Proofpoint-ORIG-GUID: RfiQoaRnZzjME7XTirVKbz802TfNsXcA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX6TvlubUllgcI
 lqj8swuGVZkvQB1lU1zZOJYCz0toS/Py+9cXDVZ+AQgmOTyt1v2zOnOY7PSyxTX1hBqMx54MkWX
 SyvOQB4yiPDcI8ryh0EH4+TItNPAJdbsKMyrE/eKLL8fDb7vif/qQFok+29VDOZFv5uFah/M4kV
 nmYgu1j23DvyqHJ9boDpgQeo9C5odWy0/B4Nva5rOfBn2Be0n7qULwXkba9dmIoHxYAdj7elHfH
 cvQe+XCZV1oRF1mwyr79anKwJfOcBLzW1V0X18Tel+5E6J6N2uAxS9tC/JoSKRZqpnknbkLRTUu
 B7IfT+rnNpXViUnlkZus3Hje44n8iHPf+FT1cL70/Tpyqdi1imydlMNHWp6WAfDGQ+LSuuRHHjM
 K9A9wxEd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

Extend TCSR parsing to read optional dp_phy_mode_reg and add
qmp_usbc_set_phy_mode() to switch between USB and DP modes when
supported.

Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
index d570ce486aee8e8a3cf3f7bb312a00bc1cd03d82..cb0197538befa6e7a5408c8d2d45225aa9520e8b 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
@@ -533,6 +533,12 @@ static const struct qmp_phy_cfg qcs615_usb3phy_cfg = {
 	.regs			= qmp_v3_usb3phy_regs_layout_qcm2290,
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
@@ -673,6 +679,8 @@ static int qmp_usbc_usb_enable(struct phy *phy)
 	if (ret)
 		goto out_unlock;
 
+	qmp_usbc_set_phy_mode(qmp, false);
+
 	ret = qmp_usbc_usb_power_on(phy);
 	if (ret) {
 		qmp_usbc_com_exit(phy);
@@ -1117,6 +1125,7 @@ static int qmp_usbc_typec_switch_set(struct typec_switch_dev *sw,
 		qmp_usbc_com_exit(qmp->usb_phy);
 
 		qmp_usbc_com_init(qmp->usb_phy);
+		qmp_usbc_set_phy_mode(qmp, false);
 		qmp_usbc_usb_power_on(qmp->usb_phy);
 	}
 
@@ -1267,15 +1276,16 @@ static int qmp_usbc_parse_dt(struct qmp_usbc *qmp)
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
@@ -1288,6 +1298,9 @@ static int qmp_usbc_parse_vls_clamp(struct qmp_usbc *qmp)
 
 	qmp->vls_clamp_reg = tcsr_args.args[0];
 
+	if (args_count > 1)
+		qmp->dp_phy_mode_reg = tcsr_args.args[1];
+
 	return 0;
 }
 
@@ -1323,7 +1336,7 @@ static int qmp_usbc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = qmp_usbc_parse_vls_clamp(qmp);
+	ret = qmp_usbc_parse_tcsr(qmp);
 	if (ret)
 		return ret;
 

-- 
2.34.1


