Return-Path: <linux-kernel+bounces-774799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87512B2B7B1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F14680B36
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D362FDC5F;
	Tue, 19 Aug 2025 03:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jBOq9EoF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE9C13FEE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755574472; cv=none; b=WwZ+VNDOqlHVaghH2V4yHeVU+PIJse/4xNlO6yz/8yh3/jBliDEpqLQFtbyCFPOx8pb4SscFECRY6ayA21BfDEQnCEEl3Z0rIbn3ZvTvT2ZfvECOOFw3FpfHGMWSVy7iQZL14dSRg/fpGlMU3fn2XoOWiinH7hM4i692haetq0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755574472; c=relaxed/simple;
	bh=jx21lmx5MGZ/FfsdeqVGZncpC/OsVU2to6SdDDH2l5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tH9+6suVdpWToSob/IeOAD9j4bR13T5Ks63/Ckelg1tYt+UipH1dVIDdKdgJ8heFCSa21Cx8cVLMB39CMMeJd99UmpoVb80c2SNBOoR0vdxhSZ3SfKZWs/ZFOJ3p4EPb1YxH6yUGLEWQDuLvYXZ82OSey/QTutIZoOr8+hIetBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jBOq9EoF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IMUmH5026772
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c7ZlGnJLq3+8VPdDBGrjVATTNbjOXYsVFry4SHltG84=; b=jBOq9EoF/fhoB11d
	p/8AZMQlBQkJLJl1pz1YzheO7gBtxEC3pb81u2V4V2gvrfZvq2r/4FDxTkKbecgS
	5eG8kDSO/TlPhTImxtVrbePWdrtCS1lV5WC8bWmlWXLh/r4ynV5gka8QBw6EN1nO
	iOvYF499PhiS8KfmZ+jvDonAE0CP4vD/WNGPOiBo98Y1zZe0Wf6P65iGJup+Dw2u
	6eATT6JK7jmg7YRPbKDpNWtzOAspNgUL71Un8eBtqxUxreYWJ0C1DtQk+LXKlGwW
	B2+F4hGOZKp/35KMDVghHwuz28kKBJzVHvHNoAVd1VaDinDBcVLmKfDREOSxGbjJ
	7I0ong==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj2uf3bv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:34:30 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-244581c62faso50922755ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755574469; x=1756179269;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7ZlGnJLq3+8VPdDBGrjVATTNbjOXYsVFry4SHltG84=;
        b=pghanH6li5ESOW6bh0OsXNNPPIALZUrfIQva2uDz18Q+eXgXmZrqZqYjjr92VTuI18
         GzrnHRYZhKCBwG+FiuLcZj70GDTcN/6AhCkkuOQR6U2RjaY4b7iTRQitkk32CwjEfTrB
         EUCBBZfOP9JwpkLWSiXMNNt7rZiTtEp+pn8kSXpfu2aGOYJKrmrYQbVUl9ksLmdZJMEV
         MxemUuo+WK+0up/STDJf9Pgi2BD6Mx47Xd0uAq18z1cHAxSaNaxfOXLve8/W1/XH4Uip
         qHolrl8yk2a+FHt8TG/LT3KzDB1LBJBHQuEh1YTymwb658lN4KUwCDmnBCBIxPdLdVxw
         Zdnw==
X-Forwarded-Encrypted: i=1; AJvYcCUBStuF79qoyn8RPbmczdWGTwrY78QiBPwiQmGw/ffHoN1jp/wPwsSyecbwjMzKc5SrU/f+gYFsUr083gQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKajUGXGm1kiS+z+WhmPS/YdC/aLgouz7Rv9RcyPC1aQGDXBbs
	jf7fUmjIGqSP1IzBLHkWaGzvbYLOI4xM4AU45ehZwCCi5iZrxhA8ea95Xi6phJAlT24dkpHiGyD
	lRKzaH9vU/vlGO+GgxWqZVdNzh0nh1BHaibbEVUfW9Ygj/SIbFWeuInPUddUldWsvyP0=
X-Gm-Gg: ASbGncv4M2lH9yfvPPGs7qW3LW0iw3rGCGpoytMj9ALo1H/jjQtQ8RJnhl+sEF0lSHu
	ozA1W0YlnGS91nTbS/EnOZ3R94KdOKoxDwhSDWFZ/yLJMqtCfeCHfEi0Sp0XSFY/d06o0OhGFqj
	9/C8Ak8yXgKph0rxfLcUAdlc+2PDzmIKbHlmucb/TfPEJdh8VZLxHXR8vuOrmyS3eEQXq3Zl2mb
	pmgPG6HOcFoh7bScdU3FQdYhKiy1bXwxoCnJEAO+J/hM8ntAn3cZoufoIXJuy7qQZupcoIshP2I
	PIK5sDJIINGsc64HSFaVwtx9gzZspPM3j5FbgH/FwRTAcDaMtXQe+Z6OA7ZeqvDvWfcMO4Y=
X-Received: by 2002:a17:902:d4cc:b0:235:eb8d:7fff with SMTP id d9443c01a7336-245e0482f9fmr10589985ad.28.1755574468897;
        Mon, 18 Aug 2025 20:34:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1JFgru4hf1iy17i0CObbmSg5dyLheaV4AtduwGDjvOBwcV3Gq7ppd6xpwIwMmE6ACKsiVUA==
X-Received: by 2002:a17:902:d4cc:b0:235:eb8d:7fff with SMTP id d9443c01a7336-245e0482f9fmr10589795ad.28.1755574468461;
        Mon, 18 Aug 2025 20:34:28 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f55esm94486325ad.82.2025.08.18.20.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 20:34:28 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 11:33:32 +0800
Subject: [PATCH v7 5/6] drm/msm: mdss: Add QCS8300 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-qcs8300_mdss-v7-5-49775ef134f4@oss.qualcomm.com>
References: <20250819-qcs8300_mdss-v7-0-49775ef134f4@oss.qualcomm.com>
In-Reply-To: <20250819-qcs8300_mdss-v7-0-49775ef134f4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755574427; l=977;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=jx21lmx5MGZ/FfsdeqVGZncpC/OsVU2to6SdDDH2l5M=;
 b=ImYRC7sd2hDvtu9kDUR4j9uSNjtTCgqBVkh1MYWwvd6QNeGLrdTV3xFIkGqkEQEAfQekghy19
 TIZij5TnEnoBeShRac//+ic8blMQwGeM0RSHAJpsmLH3sryOvrEhsrP
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Authority-Analysis: v=2.4 cv=MJ9gmNZl c=1 sm=1 tr=0 ts=68a3f0c6 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=56KCLgTT6E_AFdM1kc8A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: NyDz8Q4_53f8ceUV55b3hp0gKqmQlK03
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMSBTYWx0ZWRfX3BaL3yeReZy+
 GqmbjnJUaiPRhtLE8Dz4VC0sWul0NYPz7TwRgz55LVJAwWZtEJfOZmH5S3290ZOauPjBhATbYWN
 HF793ci2MffljZ4XVn9FVyIvhZfvOA8QdlJjVcNH3foQpNbqC+ZMGpmPovHkHKJEK+B2sonfSC4
 kgdhMgpyq41GbP/PTvX91JtYJF80kGd3FWBHFmsrMGDxBRPfA0wjN4XQnAyWHxr0R2/D+HNE2hJ
 2j+/BfYup4PDhBQsZEKtekdckcozR9wXh+y5HfsMyE6SUAVCoRdBfPRWKm6Ze99Mw5q8NwIu9d6
 v+gcwuoHJ6nIeV3Z7hUBd18YwzxkdfGcRBfvnFYdQC9W2MB1z6yHOoi4Tf04qjnppM3hFD7wY44
 MH67i5pF
X-Proofpoint-GUID: NyDz8Q4_53f8ceUV55b3hp0gKqmQlK03
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160031

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


