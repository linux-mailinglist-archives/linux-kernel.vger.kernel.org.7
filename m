Return-Path: <linux-kernel+bounces-811934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A286AB5304C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B404858FD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0B631AF3B;
	Thu, 11 Sep 2025 11:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XtvCC23R"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4143531E10D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589889; cv=none; b=d8rNE2hF1+2o99Qn/ja7Cg/VOs9hx6rtBmS/N4H0pJNhakpWnONAUWdzwL5l/WEkWP23jbctQSWYgysaqeM1HLg+mYCplrAXRjGrGRjtH/xczfN6jRguMx2rWBG5icWDrYjxnrlHLNaGmdKi9aZ/BKgb3jLcPuZsohaUsv/R3IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589889; c=relaxed/simple;
	bh=f/HHi/48hqff50ItUhEpqZ+zfupVghiSAFK6cNZOm8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tgMiNXWz+uUPHbqdv8UgHMIHEiRHUy7cBID9W2DqD/ZGn4OhGNCZ27XvfyiP0AAa9SM0URlTsPBagdQcmDghWwMOFXiwuKRY3PWlsltg/TPTnkKjKhMHMsyDsjeOVCgvQvsGUdkqtQCow85N511nzimdYIUGMgyEcaCTBKIj9bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XtvCC23R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BAJ1wJ006008
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:24:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PqVjiwHHM6HMBkqOPTdcX/9mwjZ2lFutTM2OIer6Fqg=; b=XtvCC23RsHklyInm
	c7KoMjxSHqMi8zxFc0624vmpxQrBILAimTeu1L3EMV8XcWYrGsc3sNOtO/pCUxnN
	9O+qTZ0stmuCoVdwWBvl8BA+hD2oDJEz3DrtZYOMq4wjLWCE8tKOEW3IiWWBPoru
	qeWvG4t81da0Wbfju6H3YPuKCe/pTeHx0X5yMLxGe1jSf/+uFRuGJxIynoY6LF2O
	zJhoiAQiwhYR3eeD5bJg/4ehuqh1uaVEpZrFg4kvvaaZpnT5UiOSHJgPAEEZENI9
	vv4mEynB3CXsgs4YIei2CJuPap5wIL/Yl+8e9Kmc10MePBahURBkKziFxoPlf1Rz
	Wg61vA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8afcc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:24:47 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24b4aa90c20so7157755ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757589887; x=1758194687;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PqVjiwHHM6HMBkqOPTdcX/9mwjZ2lFutTM2OIer6Fqg=;
        b=pmJsM495I0/q2DxFslvFFDH+/LWz6H4xOhD/2PH0OFJQ1aMYu05NJIjw0UI7UdGfnq
         9w0E450MbjprTQYcZbZh9ikqxC9FaU9nutxaU+Y9vECWRIsQ+vyoyu5X3qaL6N8FFDPr
         uC50XUPu00odxVeBHivObgMh3sBmdCZ+2kPPFO0DWOhtfEy280lFcb1A13oeh4PjOcSW
         LYaaovDNcPi74nQoRQ3YRFl620bXrxY5SeUCsc48VPCUztUwTG5lZvyA5xDDWxHpVbZq
         blWlBXAcmZ/jMPQTA5o7ojKAGng19I+C78lJdy0s4Wvgs0cokAmHNAWy7cQHPY5HZEWQ
         nOuw==
X-Forwarded-Encrypted: i=1; AJvYcCX/YZuZmgGkv2E1LEiA8C3mVzDLaHZBH0pOz4OllrYfvDOV/6E5FyN3Wa78qnAePm8ImmWecaLnMlQI7IE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3aRl9pYhYihKLFVG7LbutIOdTq8RvGX4x2vi6JRMntuwWd2zr
	TpSVnfxF46EvmKx/zWZgBc/DsmiEWd0uVgLlS+ocPgMME6zSNQOtE9GaGIcc9QjbghFmRInGnc1
	/IiIyzSBY8YijZLrk4XKyfAoWK/h5fp6H3RvuNGzM7HNlQ9ZuAJrKlvNwbFky6KsorThgWU/CnN
	o=
X-Gm-Gg: ASbGnctLI09Q6yiZwBHkjl7X9JP1ek1+4Pi4msyPelQgZ8TAxo2neaITup7MKOkjNXs
	4ey5uhAZZyYFukOFvsIEcO3KURXOSCJTjW8LY4GCtLsgcjiIFCGIjFUpLx/IpMw9b6wDwg9W2s/
	7Wcl/Ha3VOWF8eRusdE8Q44RMFrUarFz2TIpzrttdor6LvsLkm/EUV8zyv+XiapY0DHCTvgOND+
	kky8Th3Y9NgOx588QLP8FtDqVclfmZ2SmNqJE3aS6XujRmc5bhj4+5h57tiIW1GltCalxnRLm2r
	SXaDTpPFzhAV41TcgJdLy9iPwaCMc/WrYq2zei2uMFvMocn5ALWJfYaLfyJc5ieCHIUBjy6d7gg
	eqgC6YP1g56NnUQHYJCL9w1wB5s+Jkw8E
X-Received: by 2002:a17:903:2346:b0:24c:c190:2077 with SMTP id d9443c01a7336-25173119212mr269058885ad.38.1757589886644;
        Thu, 11 Sep 2025 04:24:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6QZfPeqjAdNDP/IOs1Iw7mvPTxlF9kQau40+ELjQ7Q8xG9vYN+Qx9eo0Ez25ipgoMd6bCXg==
X-Received: by 2002:a17:903:2346:b0:24c:c190:2077 with SMTP id d9443c01a7336-25173119212mr269058525ad.38.1757589886162;
        Thu, 11 Sep 2025 04:24:46 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c37294b17sm17005365ad.40.2025.09.11.04.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 04:24:45 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 19:24:05 +0800
Subject: [PATCH v12 5/5] drm/msm: mdss: Add QCS8300 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-qcs8300_mdss-v12-5-5f7d076e2b81@oss.qualcomm.com>
References: <20250911-qcs8300_mdss-v12-0-5f7d076e2b81@oss.qualcomm.com>
In-Reply-To: <20250911-qcs8300_mdss-v12-0-5f7d076e2b81@oss.qualcomm.com>
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
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757589847; l=988;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=f/HHi/48hqff50ItUhEpqZ+zfupVghiSAFK6cNZOm8A=;
 b=WpU6ED7a5F0yYamqUPXQmbEUElYlXxgI9Gy6Pj2DC+Dd2tBeAmG2l+2DtlQb/pKR2RcSjT3jd
 gjHYH2wDACyCQAfBTfxBjEIffU98xb0MjBM/hBwyufT2axZmE9F1DQq
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68c2b17f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=w6jnlB3v2fMHmChJ9ZgA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: PxUurgzknHpXodi-cXarct6mku3FwDPR
X-Proofpoint-ORIG-GUID: PxUurgzknHpXodi-cXarct6mku3FwDPR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfX2AUE3iZTB9Cr
 mF0WFvmloMSIJdOV0NzjubrqTNJH6vsw7aQD6Y3zZdoKWAjcLszHn1dTbSNm2Zn/sVGo5nzUa99
 2YYyBp+Y+QzgBeWUxTYm8zQ2LdjcJp2dVsYt2mRgmq8yqNY7ixpTT5oXQwGdW/MoM0r/tL2lS/b
 ZEsiJ8N6+NCJ1h0dr7PvZbozTzWT/FWbixkmriiSNZl4pdRI/MtSyVPP3GGtf8FyeU1pts0iCRt
 z7gQ8LOTBAm58OBBHcIC5UzLFPsHLCNhO/eAf1o4GFndSioN3RXAqs3rPzoD7mzjt60yJ6RAz7/
 7tXf4h6U7+LVHleaDQbftoYOfDzmKGo8leFen4T9bCHhMGmXfZYbtc3LupIj3MaBCmPjTtltAOR
 qN3MSI1P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039

Add Mobile Display Subsystem (MDSS) support for the QCS8300 platform.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_mdss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 2d0e3e784c04..db2f0064eb72 100644
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
2.43.0


