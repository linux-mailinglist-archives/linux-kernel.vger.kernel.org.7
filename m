Return-Path: <linux-kernel+bounces-778861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E85FB2EC2E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A402317B815
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B632E8E16;
	Thu, 21 Aug 2025 03:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eUlmt6AA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB062C21DE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755747449; cv=none; b=ur/87og5Tszmpm3kSsXJuTpMHETpkHz7iW0NP5YqYdKnyXD2kM82JGLlfdrvzs3008yQueIjg2jHbQ0QLXXWcX+ORAK4P3aMmfh9LUlg6nmTqP1eOkQqO5wU3ptyus4p8GJU3g3DNtEMlOvVIF4Cs8E/s1paBogD3QD3CAyGP/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755747449; c=relaxed/simple;
	bh=jx21lmx5MGZ/FfsdeqVGZncpC/OsVU2to6SdDDH2l5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YOwfjFBczSDISUngmdwt+GhsryZ/Sy/aIVRQ5RLWK0ZUFkdYJN8L+BZXIiXwaFUKOtO0DF8+L0PLSCuSaiOaldYQA+5PhnP2hNqYFx37XY9kDlpRGMys58nf+49eLtUStIqFColAFTSts9rKbkVM3nvV7ksJBL1QZEF8I/Tnoak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eUlmt6AA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KIdtBI019728
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c7ZlGnJLq3+8VPdDBGrjVATTNbjOXYsVFry4SHltG84=; b=eUlmt6AAuho5wdkr
	o4j6MR9QVgfB9gI8IylgS1vLDVapbYjbRHop+U7w+lk0vgg42JVRmjWb7RttP5eQ
	D2nT/7kULgkVnRetLcdVUfQXH9vvvvJPRZlDsE+3lNLe8U0w+lbrKAwhPvNomZAt
	NhrmDFu+4JLgJlaMTlh8ZW7ZrneTYiwO+yIWyxADuio1HVM1Tz97ly7fD9IG63Ad
	HnCN9IkRdb53FG8VnXbI2zwvjRd2CuFlZ0r4H5M4RoLogny2lpJE4JH/wAgM6YC9
	dhhhQySSNExksxKCuZoPDknaXVDsAsjhYtI9hDmpwCOPlxPyLQ80mXQUyYh0CqFq
	ta4etA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5293uw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:37:27 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b47158d6efbso462963a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 20:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755747446; x=1756352246;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7ZlGnJLq3+8VPdDBGrjVATTNbjOXYsVFry4SHltG84=;
        b=aRyX2AmFtj0tx7AvE3K/xZGT1WpjCcJtb7ATrI2xxFYLB/QVcG9/cJVP0n2TmRSdTl
         cBiSt+Mls4GPaoL8DdK7DK8ms9J73motPvDc8/zFEWVLqXeENXSmZgoZnDZu7d1ej+WN
         XJ3t3ba6govfdwZyrC7ZZu/O9poYOLVxClRHf8LOLK1p/3ISgLb2qxLh7lAmEidgG+vA
         0oYQKQ9wsHm/oXnlj/R5aUZiQU8706oWgl63IhYDDWx3/M3Vm9dBt4rVPck3pkE7VEob
         5pD1otYZQdOlBJ9iES+FRpkI888xN4mGeEENWzoTOrlAMXLp4n3mFwCslQnzx1J+5rh1
         riMg==
X-Forwarded-Encrypted: i=1; AJvYcCVPLf8g9Z8bayCulZdAmxeaZaTOriQwWqOcD5GVjYY0eHD/Ka1+tKXRnlWIUkO80tYblPQO9ORV85QYXWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyetqtnTFV7VkQJe58soO9cBH8h9PhFTSG2b3sQI9ih/6H+nlX1
	gmKwAZAaRsnZqhJI1TtmyvHHZngX/5r0VM2BjHxnmXGUlf89wAufaXU1gq5zCJ/EMbxOiff7Z6f
	5kK9oeAUVTFX0qk8c2HnCFKjARSJmXusl4ICBQkVEGHoAcuqc21hbcrSZPmhW4mte1HY=
X-Gm-Gg: ASbGncvawAqF1rRRI59dQlslyeFUNW0+usGMbkZjZX52djDAfPZDIJ/aakRntWtRGqD
	tS80EH85ZpUFk8CoaQJvRG35ozINoElePs5TebZ+WPOHkX+oNIblt7Lwj32KHpLIW4qQNLP18Fv
	Dam3DW9qM2srUW9iEdUWEcKl8Z69PyUW3rJ2i0B9Uu9p15zCV0gEDBWdhIWl0rGZBd79nBxUoAK
	+K/hpkWlL2vw7BWDulLqwYos5jkgAqna4dGUi9fLf05Xc1J/HXS0mpKK8BHEx7c6/ZeKFKIzE7z
	0E1Jzp7cgQGZhjjMZOOzQ+Eq9qwVAu9UgJTuX9XmvsF907ly2ytMjUVaMVOyqz7JFR3AbQM=
X-Received: by 2002:a05:6a21:6d94:b0:240:1d4f:71da with SMTP id adf61e73a8af0-243302c9111mr1308507637.23.1755747446526;
        Wed, 20 Aug 2025 20:37:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEP7fH3nvIAuguK5uO0nZHBdwSgTrqe9xEtuGpzyBRAGzFnVbJ7eW9pMnJeNufd/3ZYhmSLEw==
X-Received: by 2002:a05:6a21:6d94:b0:240:1d4f:71da with SMTP id adf61e73a8af0-243302c9111mr1308473637.23.1755747446067;
        Wed, 20 Aug 2025 20:37:26 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47640b6554sm3497780a12.48.2025.08.20.20.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 20:37:25 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 21 Aug 2025 11:36:00 +0800
Subject: [PATCH v8 5/6] drm/msm: mdss: Add QCS8300 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-qcs8300_mdss-v8-5-e9be853938f9@oss.qualcomm.com>
References: <20250821-qcs8300_mdss-v8-0-e9be853938f9@oss.qualcomm.com>
In-Reply-To: <20250821-qcs8300_mdss-v8-0-e9be853938f9@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755747403; l=977;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=jx21lmx5MGZ/FfsdeqVGZncpC/OsVU2to6SdDDH2l5M=;
 b=nIqdK5cwHfKA4OLfWyrt9z/LdtZOW4Iwetkfd1JMz89UozEsjKfrY5moqsraiVywkhgM6/qjq
 uGY5PjQ4rAWAws1iQ4pyqdTzZ2LqTHFXsU0e8v9ZXsffLRA2a9Ne3f+
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Proofpoint-GUID: 5NXaTqs8nyEPXnr7HzXAtUmFCc-zN2wX
X-Proofpoint-ORIG-GUID: 5NXaTqs8nyEPXnr7HzXAtUmFCc-zN2wX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXx38hfbIGJgpF
 lgP+qWkPZ3/abcfLnb2fg8YT1gk15q0cqFMKXGzlFcpI8uKJDdfArsMy1YsvopE68NPl+5J3j88
 eIubAWnzfjt/xxLNxa6o7+6TwJ8dXpKRsqjvLWBbWr175ruraz3fXPOkVxbBevvAr4+YMkpsB14
 ugGkkk8xg1+4q4zIdbHiGXzK0P+MMm4uPklhfuXoBsfjkx+Aacn56ak8bOHk/TFGXadqYwXi5ZF
 cQZsBz98NEXo/ljG+9okjEjlSW40T5t81pUAcL1fGrcjkk7OZFrqtGJgnn8TrfgHBt0FqjFahSV
 ct8cYvdFICyq9UZEqFQsAtxH7vvqFiLV6GhGqvXtAiSFHuiOkuumbkRdJSIHy4lKogltMMhsajq
 OEjd7iBO61NaMuCNCeaYFZOGuUgw9A==
X-Authority-Analysis: v=2.4 cv=SPkblOvH c=1 sm=1 tr=0 ts=68a69477 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=56KCLgTT6E_AFdM1kc8A:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Add Mobile Display Subsystem (MDSS) support for the QCS8300 platform.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_mdss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 2d0e3e784c044db8ac0c478446d211a982cf0350..db2f0064eb72e8a990ff4806f60be74d3ff8dfa9 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -555,6 +555,7 @@ static const struct of_device_id mdss_dt_match[] = {
 	{ .compatible = "qcom,mdss", .data = &data_153k6 },
 	{ .compatible = "qcom,msm8998-mdss", .data = &data_76k8 },
 	{ .compatible = "qcom,qcm2290-mdss", .data = &data_76k8 },
+	{ .compatible = "qcom,qcs8300-mdss", .data = &data_74k },
 	{ .compatible = "qcom,sa8775p-mdss", .data = &data_74k },
 	{ .compatible = "qcom,sar2130p-mdss", .data = &data_74k },
 	{ .compatible = "qcom,sdm670-mdss", .data = &data_76k8 },

-- 
2.34.1


