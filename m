Return-Path: <linux-kernel+bounces-831880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4756DB9DCAE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D4C2426582
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFA82EB5DA;
	Thu, 25 Sep 2025 07:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SS7SHXn1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80DA2EA171
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758783978; cv=none; b=g7dFZ7+RGM3CH2J7BrKKzU+X0SJ9NvUp+OFtV0VzyaMmTRGWgzNdbNQwP174kKJEiFNe1/0eP9GrceZv6jB6TK6voS0bb8DOqQQDOZgqJFmnPD2a2M5yItSZ7ME/ZtASbS5W/3N7CLkAcwmXSwfUZnaFW/3v4LZMKfHiGzdoDo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758783978; c=relaxed/simple;
	bh=oQp9DwFQdYQWDdvU1iDKEeRn3mcSQ7RLuxSrcgehlKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rmaJY3IWQNbEbQ/c9Zc4bjtAmtgyOuY3gl4ZgC0250ztrY+r8HAc7ft0MCstZseUXrFQOBrsqv3dfuUAa6j9S8k6qGtBrTL11mxwIx1gKW7CT24B8OjX/XOLKZSuh3DgeMJoiCFaUDAoSebQvQuJeo+8H7JoTA7vlDaQ457Igr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SS7SHXn1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P1XK2o017430
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lBHyWqd8iRjW0Q2gzYVRQmCW7nBgory1hKdsYJUUAsI=; b=SS7SHXn1fvLzykEc
	0Ap2j9m9oYum/DQncO9UNXAEJD+XnI8xthQmRUxhYA8MI/G1KRyT9T5yebI7Wkg9
	+p+eu/Qy2UCSbsJa/wV1IPn3hTm1bWxGXtB6gds2zxxgOcfA+a0tZ61AW7/3C/3E
	QDxGceboO6T0JtHL+vM3Nje/7xq0mnPXmTp4MIIbQf1EficzJXOaCNjRrXzN6uL8
	ckR8qAZg4uY8F1W++kctB5BJA/vxN1LgMQuY5O2YvPsIwF26lH3INn6WW1TMc8/q
	KHxZIXWyWx0hCkgKhdqabpgPeumN67GNOLLkeGvzDLYxIq5q6X7WCbEzeNp9UIHR
	Pyx4Kg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvk0f8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:06:16 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3306bae2119so299987a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758783975; x=1759388775;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBHyWqd8iRjW0Q2gzYVRQmCW7nBgory1hKdsYJUUAsI=;
        b=u694ApxQklq78GIZ8TfzOiiK+hVuLwpdItlJl6xD9WZpqk+q3KqsuTLIu1bzyvD3X2
         tWvHOJk4eNYmxzQNvh0b2P6MHghp3gKllwGQNKjy1KfaB9NIRBiVRqxtkY9kGw8TGb3e
         DtbaIRL32U1JX/4MoBV86pAl6+RYed7wOwhRajRexUJ7pszwaN8FK7Rz/s2uIuatzlzf
         vF9gL+NlyHPHZf6QvK8OdUoX0jz6X7EkZng+nsu/kRqp38Cy0vdHBKXJEC3FMD19sPuP
         bWvjNcnZY4fSEbfisIrEF9pYo8Z1Rgva+ylPEPc6Cp8DQX/0oVFxjhn3kvxchRm0TRsd
         MJkA==
X-Forwarded-Encrypted: i=1; AJvYcCWstaHoWGJvK+dm5RUYYNcDGV8QVeeSfLHJ6ttjxodHGRPMv0eXkf71C6ol7fbRwTUtwgqurcKMDGlq4uU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBIRDfzpAx4X8LgtXe8TJrT0jaohXRpekDxb6i9d2ZPyP8sxr+
	75zVqMyhB7SFCKztQTcCzC6HP1RDYyiaATiORAiA2RI0gQBJqy6TSuI7t3nuu7lxk3e5dx0EAtz
	1E7U6cg4KVwY2OcnklrU6ncIFmr43AX6Pqh4SuNNVUF7ByASA5y95PlSZ/vsVNqj6En0=
X-Gm-Gg: ASbGncuwCGiwUeIar942LfdlBNP4EF1LpCZqLsHzeQFD//2+p26+tZ8Rh60F3H22Hrb
	Lwfx5c2LH4e4R5OGgVnnIAwNwyOyE9XNzJTS6SYOcz/kXGBBw6icn0MVUOzMBy7t/sBZTh+A0KI
	VlwlR2OsFR+tyYucG+kpU7ryvOwHj7fVP3AEOSrcCn3guwhcDP3owO5JHihLbBoQPF0swHbQ8kp
	1mKeOycbkeMxfrzFDoANFnRLZRlYkczzzK/UxGBAT53o1R73VQB13MPdzauWvkdz5T1Ye/iJPm+
	6Z6rbgUJr368yEZ6LgaoMezj2dpHLDKUgcS3+Yr2CvJqUCS9y7o3bP33mtrQA7s5Vpbs+57D2R0
	YUcFJMEmOgxX2UYUeCa5npAkIeSkfv+KuBlNXQJzYo36vAGcnpFh14Asi
X-Received: by 2002:a17:90b:3891:b0:32e:1c10:74b with SMTP id 98e67ed59e1d1-3342a2c1f8cmr1565055a91.4.1758783975059;
        Thu, 25 Sep 2025 00:06:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9PP9NRgLLd7lkeJWMJjxqz7UqXV5q8QhfzEDlDV91GJHtJb969F2hLbbATzfgyQE8+9DfTw==
X-Received: by 2002:a17:90b:3891:b0:32e:1c10:74b with SMTP id 98e67ed59e1d1-3342a2c1f8cmr1565019a91.4.1758783974615;
        Thu, 25 Sep 2025 00:06:14 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3342a2bd584sm914253a91.0.2025.09.25.00.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 00:06:14 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 15:04:54 +0800
Subject: [PATCH v6 08/14] phy: qcom: qmp-usbc: Add TCSR parsing and PHY
 mode setting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-add-displayport-support-for-qcs615-platform-v6-8-419fe5963819@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758783910; l=2826;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=oQp9DwFQdYQWDdvU1iDKEeRn3mcSQ7RLuxSrcgehlKo=;
 b=Rzq0VxNC+esKB+p27CQHdyn1Ug8EFPjuJyL9kqeUF17gLpHRcSFrh6YDcOvfKUy9wHgBIeChD
 AxWN8YO+ZkFAygzyS7hlykxV3YItns9IThiwlgZGxMb1LAihWPB/rjt
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Proofpoint-ORIG-GUID: xc_hkndn-uzQIVIZvAszofPhAXoGDa_j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfX/kLymFnfFI/d
 3siVHo0E3GJkUzMwZjgUGVeyTJwMLQ+LAoFIbPveXdy8IE0tqkKkHjYko6OaiVu9ldB5tZOl49E
 K+H5lvGEDdABMpDQUr6VSElkHTik0Sd10QyNMO99cQmQHSp+vK1YinVFrvFVuEOSo7JqRRk01Dg
 cex66vQktbJeiV8M60AmZ1LYPNuiVW2jywvLFgmOQ3udP9/fu/ovIvcIi1DVGBTf47ypHrqtsDM
 NVLbMoaYi+5Z8CFBV2FAttTGOClDrKtUj6wvTJg3yJB/Efra0zhRAyNPKmusMNNiR3cAZGuJe1W
 VHy8/nLYEQJFnKODKJOa9ZVO63fkk2gCGYephBy8EseKs9dGharswSIJNrh8H08iTSIG1khYs2I
 zXmHTwdV
X-Proofpoint-GUID: xc_hkndn-uzQIVIZvAszofPhAXoGDa_j
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d4e9e8 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=NTL_5ILWjaOn02JYBUkA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

Extend TCSR parsing to read optional dp_phy_mode_reg and add
qmp_usbc_set_phy_mode() to switch between USB and DP modes when
supported.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
index a971bdc3e767727e69ea07b14d9a036347d365f4..fab6ccc4a5f12a4096e9a71f066f8ccec73adad2 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
@@ -529,6 +529,12 @@ static const struct qmp_phy_cfg qcs615_usb3phy_cfg = {
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
@@ -669,6 +675,8 @@ static int qmp_usbc_usb_enable(struct phy *phy)
 	if (ret)
 		goto out_unlock;
 
+	qmp_usbc_set_phy_mode(qmp, false);
+
 	ret = qmp_usbc_usb_power_on(phy);
 	if (ret) {
 		qmp_usbc_com_exit(phy);
@@ -1113,6 +1121,7 @@ static int qmp_usbc_typec_switch_set(struct typec_switch_dev *sw,
 		qmp_usbc_com_exit(qmp->usb_phy);
 
 		qmp_usbc_com_init(qmp->usb_phy);
+		qmp_usbc_set_phy_mode(qmp, false);
 		qmp_usbc_usb_power_on(qmp->usb_phy);
 	}
 
@@ -1263,15 +1272,16 @@ static int qmp_usbc_parse_dt(struct qmp_usbc *qmp)
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
@@ -1284,6 +1294,9 @@ static int qmp_usbc_parse_vls_clamp(struct qmp_usbc *qmp)
 
 	qmp->vls_clamp_reg = tcsr_args.args[0];
 
+	if (args_count > 1)
+		qmp->dp_phy_mode_reg = tcsr_args.args[1];
+
 	return 0;
 }
 
@@ -1319,7 +1332,7 @@ static int qmp_usbc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = qmp_usbc_parse_vls_clamp(qmp);
+	ret = qmp_usbc_parse_tcsr(qmp);
 	if (ret)
 		return ret;
 

-- 
2.34.1


