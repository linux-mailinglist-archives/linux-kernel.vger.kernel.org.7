Return-Path: <linux-kernel+bounces-831512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2F1B9CDDF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5D877B7DE1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9B4223715;
	Thu, 25 Sep 2025 00:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jJsRDp+M"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED30223DF9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758759474; cv=none; b=EgJ4za9mDBtT4dzo5cu8Z3JfxA7cNyeROjY85wj4MBlt67o4wZ1cyaJYR4qVzeNG/r7xaV+C8HzANwRQ31Ff8uSEMv81oGyq5Jav+mJUSw+cGtWTPh0mJw4UOh9oIYA7rh3Szq6A/IZjqGpXbFL0cI2RDMmbxK1E9vl1NVaSYzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758759474; c=relaxed/simple;
	bh=ZnxxXrVBknVL5H7ycfQJ0yrFxVkXtooRPcMnrqf/92A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uLEa6yVAtKl3aX+UnELK5sI8Hcgxu6c1Y/iwKJ55Ne4nYuz9jj2AwBrMniW+wsBT7OVFv8SUiCafq0atv1W0lAO6iVPbCmuVKXFobrs1/gAzMCteqV8BDU3qC0opIMld0JTE4/K+Tr8Zv8xxDfqZrccQM9hwVslebpnoquMSX0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jJsRDp+M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P02ATb025120
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cSFLnPk7ysFol1223CGza3Hdc63+GvMEeu9hW4hWOO4=; b=jJsRDp+MWL8MqeOv
	jmoaP8mr/n+jvzb10X1b3s21XjKqV9fJl4kJ0QRLiUegts7E78hxULDxx6jTuxXi
	0nuDrRcgFjxiXPaVqbej/Zq/4XVQGPaTUy6SwvrNxlUe+JRVjqYKqnfd6RX4+h2V
	zPw4dJyv43pNrKDmk6kHYdeXMji4nU/iUfR116D9XqQovIbNbMoO4rpD76a+FoDb
	IauGraKh55dksMDQPzXk5bUNLgtBTYWwgP6dUSzchWrhYGzsBx2WJM0SQTdrNhPD
	5iBrwu9uyfxvLBlWePbV6ud+fJ9GbKA/Cqx3pxYCVYQhf3bgisYomLQCxYphWnI2
	Ci3oSw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv165u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:17:51 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77f610f7325so312827b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758759470; x=1759364270;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSFLnPk7ysFol1223CGza3Hdc63+GvMEeu9hW4hWOO4=;
        b=LZveUrdNIxAnO7qlsdRkRYME8/KASE1gns+3xsqcCFVOpuUi6OuUWI40ofKGJSAHIT
         YoOypJb2Qx9F+qJV7aWOkDOJvpGYpZJSSDQzgzebBu2YBdkatvmT0JsnQZwETfEvNDZL
         w67gAOK5ot34QB5J69IX75W1G66d1mkJQKJinBxy+3PJdjkEsRpaiA3MvcCilP+2Johd
         WuXSZMPxDFhQ5qnnaKnnGdE40np1utLo//h50QHxYU4aGncKSuZy7dfo0/soLX+C5mcs
         0Da0GU+kRBMxcACzXX+0sdJvIAQYOz+mdV90pwgqtGaw+nzyvfpoKQr6483mJpYBiJTh
         mZEg==
X-Forwarded-Encrypted: i=1; AJvYcCWvOT3S3A82CIm4IFl1YHldYNp0o5tnmQeysEmFhQ8fGAHqCIT2GbunROIXnIq5H2x+auZf+RfbZJo4ido=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqJu8SsEwOHWvfCoaahROZ+3nx6p5+9IgfajcgfvMO57/fZs8Z
	Nzj5xmLPnP+SpgM3iGUW1pf0RHgWd7YuBw/MVXk9H6ZYw2kD6qNYHaKeDChNWSihF6l9rRcgYYX
	yQfnSjTK1crQsHFoJmvf1c8dToACyjHOB+28LTPrIFTsEJT7id4ny4Y/Ts2ca5m1lzPo=
X-Gm-Gg: ASbGncs48mJZmxp234kUcQg6bHONckB52qxn/MIhEvUiPRyPq3P0e9D8DVK5InLRoLX
	FMibPNONE5iQsFyoXERUg3wAguzCClgy31SfW2QcBVmWb/04VHDfOzThMtZ0mQCsgQ6KNghfnN4
	jUTZ5Xk7yQ56BsXldNqqaD7h/KziOEBNo6LK5rFheAuaWwFNXIvU+jSuckeGQWGMtzaiZ15r9HZ
	DGkO5P6dtElKh29ecJmLNjEdGc7rlm5KhEMzQTia2D3ycahW9YEb5N53a3VLhUjIJ2bFQyXTB96
	e+XPjdshF8GEZIF7l3oGAeqyEarByJSZKLeLabLXVUd9zmWnI/n4LmWFu/vANZX7nd7jL+g0dLx
	mXq3xFFNAtdv85bY=
X-Received: by 2002:a05:6a00:b8e:b0:77f:3204:efce with SMTP id d2e1a72fcca58-780fce1e944mr1355722b3a.10.1758759470251;
        Wed, 24 Sep 2025 17:17:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5TgNMXbf4MVufpWFUDFnWgDHVNG8MKlTqGJetdLMSZMeJ8LIAXTsyQfcT0GbHH2qoz6OvnQ==
X-Received: by 2002:a05:6a00:b8e:b0:77f:3204:efce with SMTP id d2e1a72fcca58-780fce1e944mr1355701b3a.10.1758759469818;
        Wed, 24 Sep 2025 17:17:49 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238e6fasm262748b3a.1.2025.09.24.17.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 17:17:49 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 17:17:32 -0700
Subject: [PATCH 15/20] arm64: dts: qcom: kaanapali-mtp: Enable modem
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-dts-v1-15-3fdbc4b9e1b1@oss.qualcomm.com>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
In-Reply-To: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758759448; l=835;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=ZnxxXrVBknVL5H7ycfQJ0yrFxVkXtooRPcMnrqf/92A=;
 b=88h1SfUl/uT/sG3wHC4ylffWfLG269Cyw9rxlcD8h2YBm14w7Uw+DK4ew8FpNK0ZL+hCyCwCi
 GIfpUYm0PH7AaK8wVDGlmhilu87brR5A1Fol6ECCJVCK5fFCqI/saCK
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: HOdrhoc3IOhvRFm8pklibGlZ13TWgn8q
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d48a2f cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=4W-xSDX782KYlO1dws0A:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfXy1ImCnZtbZjM
 Q5GTSJzjoIa7vgOGYzFhmknm7LjF8J5eXLRUAaLKDGhAmgz7Tdr0TJ0frgOZF+FrlhB0Td+LWxP
 P6MjD2GrkW/OMWKbJQ93cNb1+OA8rRfT3z9MVa1T7j5/LZXXiXgI0Q3tRlbb9hUB2wqTNqS4mHi
 zY/KHk8IQGrkGLrAwHeCm9tOqN17hzN0own6NuLUHTePmtvugvx44lC6mIQBzlCoJREfy8lr9wv
 Z+gU8DsEXPO2ymGrzU+sHfGIKBMqbtYUJOeXwqQyeqiiArq2cNWkwmykBXzainNvIKveBNtgoSi
 kr441gs8ksR98++GI2f8mi4L9BJNVIfVPPIaeIjzIfnFpC2dqQuGaLAXfT77x6Vb+07QflXdU93
 MdeHFcM2
X-Proofpoint-ORIG-GUID: HOdrhoc3IOhvRFm8pklibGlZ13TWgn8q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

Enable the MODEM on Kaanapali MTP board.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
index 2949579481a9..8d1b3278389e 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
@@ -1263,6 +1263,14 @@ &remoteproc_cdsp {
 	status = "okay";
 };
 
+&remoteproc_mpss {
+	firmware-name = "qcom/kaanapali/modem.mbn",
+			"qcom/kaanapali/modem_dtb.mbn";
+
+	/* Modem crashes after some time for OEMPD load failure */
+	status = "fail";
+};
+
 &remoteproc_soccp {
 	firmware-name = "qcom/kaanapali/soccp.mbn",
 			"qcom/kaanapali/soccp_dtb.mbn";

-- 
2.25.1


