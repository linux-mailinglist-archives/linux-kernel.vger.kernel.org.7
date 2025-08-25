Return-Path: <linux-kernel+bounces-783960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6D7B334C2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 05:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1549A420C23
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 03:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E3327FD75;
	Mon, 25 Aug 2025 03:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pGgDr/Fz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3A027E07A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756092980; cv=none; b=SLvFXgXYH6X960thAA/dCODmNYn+fvr77scfyeYjEIjlwVBBn37Yenj/3qnOulYrC0Df1GAuA2vxoWsuZwTMhXHv0JwCdPTBF7KY3XFzFpDoHwNAh/DO0+C3B6QQZr0G0FN7OE0YhZj/mfj5m65la0KTc1MKWSciLgzYU87wHVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756092980; c=relaxed/simple;
	bh=jmOF3YxLYSDfb8Ohpc4kXPJtA6m1LCaahphFup+ozoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gqwkEuh1n1ovYhffAkzbHQFfm8s4S127IFcjkLJsSvYMygTh4wC6JCFtKWl+pnvDjy0Ks4VmyZY/SXmY1z6LSADWi90+C3vuONrj0oIp52gCKsTN3FKKKNMxhlQm1w6YjalB0txUU8p3FH1D4IuGivt621CHp6C3J7VHhusMAJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pGgDr/Fz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ONpNqk007281
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s5H/bF7V+/uMeSq3g0gxgqc/EofmL6r/gf0PKGC0ccY=; b=pGgDr/Fz3Upj9d+I
	At0CdDfKw777H8QMjqQCBobmuLqKx+uNxEtgVEHKcwfFRS7BV8ezxeX6Yci6r9Fq
	NmyNYzh+kIrNMNtV3Amcyp343N1OPnFk+oSJGDlOQqTm5iu7SL//qTbvWU0mucvN
	1Ja5TsExp3z5vqtLS9ygTrR6yPdS+4rxwwbzI/9/3jiCDWRPQDHFrHiw3qS50eAc
	n4c5oFlmPnGeuOK46EGE1S+Aychkxpvk+l4iqNIO2oys6eZ0SS2NNgtiiqYlO1po
	m5A4M0PmBR43xwbmlA0P1pZKgYX/uwGMihjnDSc8fDHPj1Kr3qFJjP7QuxXnTA14
	rkQ5hQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5w2kmr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:36:18 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-244581c62faso48964235ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 20:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756092977; x=1756697777;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5H/bF7V+/uMeSq3g0gxgqc/EofmL6r/gf0PKGC0ccY=;
        b=cDYWawWKExAQycHel6bMBMBeJooxys5y2BZTBGxmUz/41VDG5/91K/kN0vzYHtvN04
         e/5NMLa5liCYvuKLHxQWgRzI7yKGFT0w3Kfs37WJsiEahCMuU2V/3rXMaaZ5K2NT/AF0
         uZnvCRK0lb7iCSSgXf7WiG3+NPcXhesnCjxS0A3L7/Zgd6l1OftBe5usS9gkoFgh5YQL
         kSsTrHUuUrCbxKdSb9mDcs1xfsQWQun2YTxeYkpzLw+RIHCwfUPkGFQvDyxvPCQNJr+n
         TYtVU1zRy0u4+BNY0Ydqb6WXEWVfB+HVn80aTQ4O1dPCacOg0xTyu3hrPPxazW9rC/Ns
         EGnA==
X-Forwarded-Encrypted: i=1; AJvYcCWgIryybroJI9jS9PXYbWqAdU64M5Ut/LizbQxC9GeEGfHDVzbvEYDS1DVoo/HrUoREF1V5AAZ8vAju+CU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbyxPuKwFMyBYbmLR4K0fUoNCsfZNyPCJfExuXB2rpyhSOMrXg
	q8uXPsiyDSSzjA4QtS45IarF5kWQDJz3kk4ocAcaSDZ7daTHPjsLJnVoZ+E+qgZ8QtId3au/FcW
	xjrRD3NgWpRwGLJfqmhF6cv8vQJDIdmI5w4QRgaeg3QmEy9yrw7PbvJgT9a+sBNfMaUE=
X-Gm-Gg: ASbGncuD8K/qprwMU13ZHpZv6J4gnLiE/gMEPEC5bxTr2ghAwTOJynTLY1+XsUFGKSq
	c5qy2j9rgezbaNIn0NYx41mHRcPxd6aB2HfPw/PypvgE04QYXo7mZ6N/nv19DnmK1o4+zTwJM5E
	VwhJAog6XuOtb0IVOcAIL5K96VITFQhQxntQrm9qcho0W+c9B+8m7X4TXm6nUQc7BBG6ILW8y3Y
	CGJYUybqmJSAKdmlKBhODfCq9LT6L2ruvMWIUInBfro3xZojoVs9S93XNQa7jGNxxox5jqKsfWS
	1hRXwykIXpumy6bor/2OQq2eeUA99ubKbU0504oANoRaaEBPE2mnOY84oaGT8P4iUcH5x2s=
X-Received: by 2002:a17:902:c94c:b0:246:1c6a:7026 with SMTP id d9443c01a7336-2462ef5fceemr147015205ad.40.1756092977437;
        Sun, 24 Aug 2025 20:36:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUHF1EOpueF6zxgZFcVMl7eVaFCuRiBqihrB66vAAoQ0pqCcjvsZWuWh8z1BidLoA1l+DrmA==
X-Received: by 2002:a17:902:c94c:b0:246:1c6a:7026 with SMTP id d9443c01a7336-2462ef5fceemr147014785ad.40.1756092976954;
        Sun, 24 Aug 2025 20:36:16 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466877c707sm54859565ad.22.2025.08.24.20.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 20:36:16 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 11:34:25 +0800
Subject: [PATCH v9 6/6] drm/msm/dp: Add DisplayPort controller for QCS8300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-qcs8300_mdss-v9-6-ebda1de80ca0@oss.qualcomm.com>
References: <20250825-qcs8300_mdss-v9-0-ebda1de80ca0@oss.qualcomm.com>
In-Reply-To: <20250825-qcs8300_mdss-v9-0-ebda1de80ca0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756092927; l=1242;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=jmOF3YxLYSDfb8Ohpc4kXPJtA6m1LCaahphFup+ozoQ=;
 b=+HddgfRGfsccGRo6kGLEJNIBQn6m5wNdaACaxKf7tyrPNIGgvaclwhJLOqcbQW5QheaYxKVIC
 zxQVvicexOkAOWG5myMhf6iDOKDelASLJfIQjhcr7u8lGqcq2fdmsdi
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Authority-Analysis: v=2.4 cv=Z/vsHGRA c=1 sm=1 tr=0 ts=68abda32 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=E9mFum2VwHQHOKsBOicA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfXxkzBj7qBd9WT
 +BxvrtlxIvX31qyBk/8SAfoAuQ/o12V/gKcZJA4Y3sX43/qI9eLE2L7456BoRe72CE4xu0onFcE
 rmECDHt801MfUs/HTLcokop9CZJvx7J+gEVDSFZLwYnv+kv4cBmOG0x8mdIF48tYiskRpNacLEj
 +nFHi3xee3IEj1DUuov0Fyfgzh6OaE+Mrf2FMxO8H7Wl/7nBzQcPhffpxYfC2aJHduXmXdWCa0R
 XanvJbxH03Wl7ocmP2VaPXH+Gl/Xo5uryuO/Hiw1mL2M1qjjdP+SYgVX0wAlouCp2Elhx9sR0eh
 QVOGsicv7sF4EOPF+QYztsJ6Wpat0PKQGbMTBfZ19lSnxo9/p8yRWjqXjgagZMygj6llKLlre/R
 CTfbKapQ
X-Proofpoint-GUID: sDQIl3EDCRSqsVWOhDaxr2v4fLAXCSjy
X-Proofpoint-ORIG-GUID: sDQIl3EDCRSqsVWOhDaxr2v4fLAXCSjy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

The Qualcomm QCS8300 platform comes with one DisplayPort controller
with same base offset as SM8650. But it requires new compatible string
because QCS8300 controller supports 4 MST streams. 4 MST streams will
be enabled as part of MST feature support. Currently, using SM8650 data
structure to enable SST on QCS8300.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index d87d47cc7ec3eb757ac192c411000bc50b824c59..bb4660585849d1a67921a28e7e12422e0c327ab2 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -187,6 +187,7 @@ static const struct msm_dp_desc msm_dp_desc_x1e80100[] = {
 };
 
 static const struct of_device_id msm_dp_dt_match[] = {
+	{ .compatible = "qcom,qcs8300-dp", .data = &msm_dp_desc_sm8650 },
 	{ .compatible = "qcom,sa8775p-dp", .data = &msm_dp_desc_sa8775p },
 	{ .compatible = "qcom,sc7180-dp", .data = &msm_dp_desc_sc7180 },
 	{ .compatible = "qcom,sc7280-dp", .data = &msm_dp_desc_sc7280 },

-- 
2.34.1


