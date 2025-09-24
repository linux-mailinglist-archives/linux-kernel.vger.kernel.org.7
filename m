Return-Path: <linux-kernel+bounces-831345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A281B9C6A6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 329AB7B492B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF4A2C0F68;
	Wed, 24 Sep 2025 22:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NIPCqyBj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A771D5CF2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758754752; cv=none; b=hm9xc38CxgPM/Ae918IfmReb7OO1GF5k8Ni8Sikd9CVub/aEBgvT9Px9i8o77H9uFPPjzEl3+/rP/DXAU/wCOWUumAnfVe+pnX0y5F94t9L9Ai2yq5ZLpEHbfUhxbbmZ9eqmJhOWpQ3WBqD5iUZxWNtztibbWj8lfDCXfP0+dD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758754752; c=relaxed/simple;
	bh=40fXBW9Xqp5v/gjI8xVoD6JvyGACBObnmfKTLj4p+fI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qIAV7oT/apRF/nbwagE3LVT+jIXqhaG6Aeu2D2GI03rblo9qxFyRNXICkSODTGssgvMQAFjXHxm8OhY/zwa8e9N5Gpci/CW7MMW2VZ9s2FSLb2b+50itEu/mjzhoPzrch/Vy1hWj1GH5iEMGIKBJLHXMwkReOs0ZKjxMb836rEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NIPCqyBj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODdFGX017430
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	floPSo2VlD90GaZtQ5YRAEWFr9Y/OEJrQy5o1cbDEo8=; b=NIPCqyBjkBjbZu5E
	HxmubyHnshe8sCJ0BRULCJgXX4cmCkinkKIDpf9cRFN+o3PeqcIWIH46tgLsMVGf
	F6u7e7FmitDKGnm5rstQFVsgi3K57VG5h6VOvbpKSHbStFtY6h9jdTQuAFoxDxPC
	IqsitqienPH2I1ZQRTaR3HoUC+E5E7iNS35BeCZFX8MvUwaWBd6V9qq49N13fNol
	MXIQoeSoTq82XUIT6Hoit8EhnrbsMyprijh1HUbGnHd8K1hoV+w9Lxdqf1bZYahc
	Ky99BWS5rFJ9wA2VCrRcuuuhsgNIUuI6kW9+4R0+3JFPg7fHML2b9pA96JoFj5lQ
	DYzANA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvjya0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:59:10 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b55735710f0so401447a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758754749; x=1759359549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=floPSo2VlD90GaZtQ5YRAEWFr9Y/OEJrQy5o1cbDEo8=;
        b=EdcJzOiQPc/cnZeh2lpPyNHweXDXXcjN7fDL1U25u8TFAM1LkD3hEkInU3pg+gib3/
         NBUxlWfzFlBvYybXuDUp7J4UYRF9tSkeD6vHIDycNXkSJlW256ULff1tp89oxmIASo5E
         Y02GmWLKpNn08p6tDO4crYX2+0qgJsdv+6QFQLG02iJgshMOZ1bDxHJx/14EGYXsW7zW
         vlcjnRZtbw586ab0RMzg+kZko3ZIxNP7AS1OycaFnfoWT+bFBrV6F5FIBCVWZo2H+Iza
         nGnAePQoWQqp4asH5bMbrS5fC7PHjhq+RVyyiGSTZIYt+KY0k6EtjKSf8gwxNhZ3WwP+
         wRLA==
X-Forwarded-Encrypted: i=1; AJvYcCUDgE9CWdGAbUq+LP8927oaYcQQd/6RB3WJyg/HBVj3Fm2NokeBUEEc/S7TBTZo4lEC6Oof5H3pRqtnLuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFCO7EyGwnGe91L6KYMXxhvdhBoK54Cg1opy1hWGfqIve1C7D/
	PlHZFOx3UQG5SiKNIWrhZNE/pzex2ZpRdjOLqRxKIWX0trorcg8DWPBvTbTeDGV/PuV+QmDVYyM
	Cz/Y6Wm7hF/4IT0SbAg7HONSzZniilY+MlYeeS41EV3pLJWFLiZzwvMi8lA6NJXUC7O8=
X-Gm-Gg: ASbGncueNYRwSqmxMg+Pri6zQLjqRLBBKgCgMPHzBvcLQ8wNTK/yKXJYT7geYMR4fWe
	v6CorbOCf+DaTpMENmeSq07PheUla1O/9sp9/GFwlQ2Hk4klUztQy6Eaii2mDV7Elu3vY/ptiPL
	+1yOp9OuWFlSGWwott5QK+26vGIKkKjCq5g9/KpZUnP1COc1UT5nUMT8rOpyVu8pGV/JAXjYjAI
	5iqllI+UB58zc6Pei/TuyWeop0A4cZFHN4Syh1zL00MgNJBpcmegToamjWOnE49XhmZ1elu2LVZ
	kHwHzo9Y/PpR3G5RhuK9Mci/VmFUD0aYfCgeWQpfzG4VvDMbavVM5XMLwJcyuDGBExaKZnduzyq
	/uYv12Nl1UHWQtkk=
X-Received: by 2002:a05:6a20:918e:b0:24e:e270:2f64 with SMTP id adf61e73a8af0-2e7a604a88emr1669098637.0.1758754749398;
        Wed, 24 Sep 2025 15:59:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETIr5lwFtqn7bt8ILFT4PBR5uGgchwAXC33iEFytmgzm+iyeaKni+bW52piHN4IKeOWGTagA==
X-Received: by 2002:a05:6a20:918e:b0:24e:e270:2f64 with SMTP id adf61e73a8af0-2e7a604a88emr1669064637.0.1758754748826;
        Wed, 24 Sep 2025 15:59:08 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c2b70esm111166b3a.101.2025.09.24.15.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 15:59:08 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 15:58:57 -0700
Subject: [PATCH 5/9] clk: qcom: Update TCSR clock driver for Kaanapali
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-clk-v1-5-29b02b818782@oss.qualcomm.com>
References: <20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com>
In-Reply-To: <20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758754740; l=2291;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=ekI2VYdgbIxRfA4hFIEmcA/+yf9hLqtdUc0yX41msPU=;
 b=0f22/vllToK9I4UxKnLfNsn4mbzEQ8yqDqIEHlC5CcbY0PSeoYUTyQalmyk3l2q2shTlzOdoh
 4sqBUVvnJOkCNwyiK1lR7BkyNhiVHfPkqFMvBdU4hgGMsFomRyKc6d4
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: M0gadisSCKSI70RHu7AZ4yEa8hlBSeEt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfX4pUzpRoenGM6
 FjlgrsDsvWZ0z/s4BvARJzIxmlj4+3dS5STFHMyJKSaMLeiqkxDqAQc2Ym0XIbgcv09+z2Mwa+i
 7w0vrDUnthK28mNuAHgrK2f3+pDgnqd6TDPY9Y9YGv8Ahm70gCgN21r7SYgRXXSP9MIhWj0etyX
 M6BQ+z79S3SKqs4o2/3OuohKU4X7oCx/OSt2nLQSnTJmmPLEGZc4iwua/tvEk8og0kYmDpqW4fC
 OE1efVTheCcKUedglCty+Vx/y37zrFz2E5LtZ+pFU/6wk9I+u3T8ALf4HIJ+0TFc1CG9I7TMEe1
 UV7R8Zqz2lfa9BD+j676UuvubJSPV8EeZBh104NUq79MqLhluEnjPvDYlmHDxibuLbRS+NC07XP
 tx2aaNPQ
X-Proofpoint-GUID: M0gadisSCKSI70RHu7AZ4yEa8hlBSeEt
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d477be cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=dFtAHy0WI_kTpcb5h7MA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

From: Taniya Das <taniya.das@oss.qualcomm.com>

The TCSR clock controller found on Kaanapali provides refclks for PCIE, USB
and UFS. Update the SM8750 driver to fix the offsets for the clocks.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 drivers/clk/qcom/tcsrcc-sm8750.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/tcsrcc-sm8750.c b/drivers/clk/qcom/tcsrcc-sm8750.c
index 242e320986ef..f905f3824d7e 100644
--- a/drivers/clk/qcom/tcsrcc-sm8750.c
+++ b/drivers/clk/qcom/tcsrcc-sm8750.c
@@ -100,21 +100,51 @@ static const struct regmap_config tcsr_cc_sm8750_regmap_config = {
 	.fast_io = true,
 };
 
+static const struct regmap_config tcsr_cc_kaanapali_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x18,
+	.fast_io = true,
+};
+
 static const struct qcom_cc_desc tcsr_cc_sm8750_desc = {
 	.config = &tcsr_cc_sm8750_regmap_config,
 	.clks = tcsr_cc_sm8750_clocks,
 	.num_clks = ARRAY_SIZE(tcsr_cc_sm8750_clocks),
 };
 
+static const struct qcom_cc_desc tcsr_cc_kaanapali_desc = {
+	.config = &tcsr_cc_kaanapali_regmap_config,
+	.clks = tcsr_cc_sm8750_clocks,
+	.num_clks = ARRAY_SIZE(tcsr_cc_sm8750_clocks),
+};
+
 static const struct of_device_id tcsr_cc_sm8750_match_table[] = {
-	{ .compatible = "qcom,sm8750-tcsr" },
+	{ .compatible = "qcom,kaanapali-tcsr", .data = &tcsr_cc_kaanapali_desc},
+	{ .compatible = "qcom,sm8750-tcsr", .data = &tcsr_cc_sm8750_desc},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tcsr_cc_sm8750_match_table);
 
 static int tcsr_cc_sm8750_probe(struct platform_device *pdev)
 {
-	return qcom_cc_probe(pdev, &tcsr_cc_sm8750_desc);
+	const struct qcom_cc_desc *desc;
+
+	desc = device_get_match_data(&pdev->dev);
+
+	if (device_is_compatible(&pdev->dev, "qcom,kaanapali-tcsr")) {
+		tcsr_ufs_clkref_en.halt_reg = 0x10;
+		tcsr_ufs_clkref_en.clkr.enable_reg = 0x10;
+
+		tcsr_usb2_clkref_en.halt_reg = 0x18;
+		tcsr_usb2_clkref_en.clkr.enable_reg = 0x18;
+
+		tcsr_usb3_clkref_en.halt_reg = 0x8;
+		tcsr_usb3_clkref_en.clkr.enable_reg = 0x8;
+	}
+
+	return qcom_cc_probe(pdev, desc);
 }
 
 static struct platform_driver tcsr_cc_sm8750_driver = {

-- 
2.25.1


