Return-Path: <linux-kernel+bounces-794269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62FAB3DF49
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EF7717D82C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F8C30FC07;
	Mon,  1 Sep 2025 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cJjSUUcw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD4D30FC18
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720718; cv=none; b=iDRw7ArZ8prZ2tiSbeRtaVXVj44G8jdExGaUeNMkFJXqL3wDHePinLtYXtieGW1xJnnru+CAsnbqzqW4SStlbb4E+PECWl4sCJy6O3qeA5WeP0ZQc4xLFR0mrxPtTM7yWkeJ1afKX9dJUA6w8fqybhpwfxCHaRZnMfLhLP5E66k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720718; c=relaxed/simple;
	bh=xP+KCWOk9SNxzFjMtHR6U06UR7/RbmmfOmVurK6QZow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xe8xwTxo6m21OrEQCUQytISTVfJij6wmioiqmrMXZX8Q+EykVJ/00YB3SWYHdKPIiuDc4xnD/wJkS9tTOLSRpupAp2w7sLxCHhNAn7+2g2B3KC8isWO9yu8tEMStBuGbJaUtKQw3vlYZ2wXIgNXYl2D6Xe17oDoWTLC7UlPLkvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cJjSUUcw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5819eOs6010933
	for <linux-kernel@vger.kernel.org>; Mon, 1 Sep 2025 09:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Nc/Me6JhWACWqZ3Seo6sntz583zORBKIxRCpmiza2Ms=; b=cJjSUUcw7rcCaAs9
	3ece+tFyKmFvLsxDYnjr0bmulVlDEjpqyScfF1zpBz9X/si+oa/G6vGyOlFteiNl
	cIlGpxJAxbNKtQBvcanLte4fWozqrvFrFWrOnzCl0UCU0oTDeHlqw4srZK/CrnVI
	u1EomFOYJYfvDf6vQxew/+vcI9vp2DxDV69EMeeCWeGwgEwjCLqhF9si8tXOkDVN
	3Tq+ZlMApckfndD4XkvAlZkacIWNHGB3UOblJ2rpc+k+zEgApFWGYKK6LuRLpaiU
	HNq0oWpodbTtoPoCQHwhMFnCfT5GNS3Sj8kjh8ZaY2oTwhsR581j2J5NrBcx/sPK
	Ll9N5A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk8v75m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 09:58:36 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-327704c12d3so3859686a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 02:58:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756720715; x=1757325515;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nc/Me6JhWACWqZ3Seo6sntz583zORBKIxRCpmiza2Ms=;
        b=OFQS4lrV0YKA5UV3Cf8cioracvPlIlFIF5JVktsr0Br57dftRx9FNG8OpjE4BGEsfS
         hfCwRoqRh6E3CxD00Q72gQa1YgFneFhEgW5NmMJGmCjnxvNbeXvC0pHCbIEIpT4FLMb6
         v4/GHzbRF4hVo3EgG01vPV01ivwNaeREdW2lT/nZxXdhcNdCcFoXXEa10e0RFjdkxick
         yzjifiro0RE7WzhGTDkLZIWiuZz5qf86kWl+K/0mrsv8hXT/MxSW4NmuBvFZYjm5nIPM
         58JsDliKdCnjX8360v4W9DQDV4QjGqcc2IoSqRrDyiNEyHehKWb+6ykh12dYCX8mCzHS
         ZUNw==
X-Forwarded-Encrypted: i=1; AJvYcCW4XXFDrmqaYFjy7i3Xpfy6zJ5cLsron8AcbvejVfxAUvIecrlDhvPB0xJ2rX45glmnOzO/itXRvxMmO+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkOgDxFjFVFE1wI7Cyo9rKLP1UUwYyaqSl8W1d0nMMutPffGmr
	PxOV4mIEVJU/UrtaCHZwE7gAVdmz3sfm/09h6L44GeN+GyjDIDfkD+Q9Zxl1iovWBVRfpZ6CWS3
	esa1cuVWom/mXwrtwv1bOE9EHRnJeDfWg9JANrONwvB2S/ogHNb2VkdfQaCPJSbqDv9A=
X-Gm-Gg: ASbGncug3NiZEW++FA7K/ccPg8pmtObGt2exbNSi67ja82BvGH42CAYqAKiWsHdoj9a
	l843W0ZJjKmxzmG1T/Dy+dynwDjebdR8/ZeANVVZvzWWGE2E+w0Nwh3lY9/VYlfG/+DS7I8eu+G
	5GS+GgDgOvfY/PYI4wFS6lSLSwp9OhJrd7hS7jxXQJwE9HSzMAM70pMPCPJPfY3S3dcOO+q18GJ
	GfDP5NZvs+rNNyoSdZfMafh9boWKNdkPiPa5HTRq3EKsbVEIee6H0hsQg5wwZzLSaJDlFXA97ld
	Ov4rtoO5gqEtV8QKg3S8Uxsv52X4LB83hGB1kZeYQwBU/2P5SVh10UcqCip+N08ugAyKF4I=
X-Received: by 2002:a17:90a:d403:b0:327:e0f4:93c8 with SMTP id 98e67ed59e1d1-328156e3403mr10453248a91.35.1756720715350;
        Mon, 01 Sep 2025 02:58:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELPKocoeFWcHuBmJ0qmsn5YbGQOyvdDQm/Bwbw5KgIEgQX/1K8sTClC0rbHAhXOKucBgdKgQ==
X-Received: by 2002:a17:90a:d403:b0:327:e0f4:93c8 with SMTP id 98e67ed59e1d1-328156e3403mr10453218a91.35.1756720714887;
        Mon, 01 Sep 2025 02:58:34 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26bfe2sm10305656b3a.14.2025.09.01.02.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 02:58:34 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 01 Sep 2025 17:57:33 +0800
Subject: [PATCH v10 5/6] drm/msm: mdss: Add QCS8300 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-qcs8300_mdss-v10-5-87cab7e48479@oss.qualcomm.com>
References: <20250901-qcs8300_mdss-v10-0-87cab7e48479@oss.qualcomm.com>
In-Reply-To: <20250901-qcs8300_mdss-v10-0-87cab7e48479@oss.qualcomm.com>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756720668; l=1044;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=xP+KCWOk9SNxzFjMtHR6U06UR7/RbmmfOmVurK6QZow=;
 b=GeirIYyOUXVPOWPSskOREOmICTSCKpJng0kNFerFH5dqKzpm3oLQ35QPAuWOKEVhpy+YF9gM5
 KLrQ5nU7/SQDePMf//NeenzMFWPPPZfEe3rrbvP2Dup5ClT8diq6E0b
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Proofpoint-GUID: _h41gJod1UTz3HEXPmKs54Zw3-dUFxVh
X-Proofpoint-ORIG-GUID: _h41gJod1UTz3HEXPmKs54Zw3-dUFxVh
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b56e4c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=VHyea80QRMuD3TjLfpgA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfXyIKrNUT10s+J
 Dlnc4YwbtnIaU6Wi04qpbcHuvlgzLlyNxftAP3ca9K+tCwPzoDtW0LBMkacnLin79FlPKojRgrv
 WqI8ZUeEBMSe1D8Y/D1n89BKmO/ra3QBSOrTJHCS1VYap1pH0yH+qooAkPud0bV99k0yxLJSOhS
 AC3eTrN0eh5AcnqiBpyCe232eN3/7ouWHqHqCWsY67QbKdmNRFYYK/NRgFDr1rbugXgXSxM+1w+
 boM1fmgHpGSTkFc3FUXoL7LinfdCfgiU+2SmgWkZQBePpG7b96i0EdUz6OyUHARfowHg8R5qKXD
 WuGtCa6xsf2QxptQJvWDpGaBOZhbuu9vk+K7dPX56v7CLpr/aqcOVMDyZ+oATWZdSVDrRn7bSVq
 HVfjtWb2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

Add Mobile Display Subsystem (MDSS) support for the QCS8300 platform.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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


