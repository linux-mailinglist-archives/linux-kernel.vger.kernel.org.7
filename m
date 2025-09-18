Return-Path: <linux-kernel+bounces-801984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82813B44C67
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120DC1B23557
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 03:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD3D232369;
	Fri,  5 Sep 2025 03:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XEbGDZtI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9441E570D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 03:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757043711; cv=none; b=NS6UdbGAW9JTTn8vTrodLn5UQe1DBq+b7UNsfvVxXX1Wc47K7oVKnkpI4jdIbtqCmMgPvbQBEFaRVFEI3utUT1Pzi5hKwT4Df6KvcCYC1B8edJYbA3ZiiYPOM3sEA84DujC+/iZe1cafGDf7MlMwfEgQ6geSlyof2cL/txm+fYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757043711; c=relaxed/simple;
	bh=jmOF3YxLYSDfb8Ohpc4kXPJtA6m1LCaahphFup+ozoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HgRiW212QzS6xi+JHq0jVcasvHCw5U6cZZ62lzf97HqgUJw4Ro0l5vddl3d3//gSHh1KC0o1m8P59WYIlIaglzs17nQl/A7XCcSU2fx0Ko/+5L5yzb3b/ZR+YbjMqZJ6d/d/+t30cOygop8rfFJcwHmfoK8n+Gpyq1u11/+0oFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XEbGDZtI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584I5cwG013673
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 03:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s5H/bF7V+/uMeSq3g0gxgqc/EofmL6r/gf0PKGC0ccY=; b=XEbGDZtImuOhkztn
	NA+oNtbKbJYIGX60BiWd5G0nAbAd8pp6+KS9FPAKQWB10IGsEIGWbbEB7LwfKpBQ
	0A5CiO8xVsUUvITNdWFfzji+1SjmCURXUIKeRRWdk3cxfpIv6kObJ/+4BRh6+WJY
	7hiottyza2XXW2mUBfAth518jRCEuBmo8RdBFhRLss+kgXmvQm7hLycAjaDQwFhe
	H3RBzqSP9d+iv60j7WrRN1LAwdr2PsCVADpV1Kcc8CLmOz5cUTLLxEVlwQJxGgYK
	JGsFQvf6HQAB8GuVaD2qv92ArfPdL2R/Ae/8a1EnWtKnSRvQC+C1ZfzrT8Y/Nod4
	6DU9CQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wydmh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 03:41:48 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3234811cab3so2021471a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 20:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757043708; x=1757648508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5H/bF7V+/uMeSq3g0gxgqc/EofmL6r/gf0PKGC0ccY=;
        b=DjffNwCHHq9YjZ5jhvgKluXUBMxaWJjs9LPEAci2uwBHMqAUcoud6a6kim1pcIDN8E
         63p/UyVPQ27S7mtkhUNGw27oVeFpBnvnMuI59u2u95QdtN9SintHgqzGuAE7WgdYyRhg
         BPnIRcIigm1irJrl1jOq/LUHrCeFu+vmMyI+LAfgUW7ajmQz4WhE7kIWuwbJYnvqRKno
         Ej2sbB3AFUmw2ZBYBrdKf0gwoQZClk5hdirWMwq7Y27wdgsayFGKUXeh+dnbehICLaI5
         pEOR9yxbDIoUCppQlbG4rUD0CRfwLEGy8tipOxK2iVvzBmxM6fbhccr8Oa4Qyf/e52rj
         M+0A==
X-Forwarded-Encrypted: i=1; AJvYcCUGYE5oBSCo0HBogt5T1Od0X4232E60xRTD/nZW9oHFjN2fgsBTN5SAsjBX8Eoj9DCRBB4MGc3hmDyLw5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnbS3fD9vYvd9MbRFV6h16r1aqGVbst9uUB8378FU0b/PtFaIg
	KYHrekZ6Em7hU4RK2/pi2E5g1SA7bb6208YdDQiq0SZrRxeapU4z9H0D2KWdpQEq3cWK5kbiAMB
	IJfpJeZJUIfktUeM7NPiBxax1+/TihwhyYH1Bd8EHafiHRxpgXyoW+Q4q3rCbQT2lbYs=
X-Gm-Gg: ASbGncuAu8DoPqCdWmDqjjOSwvvlC0fq4PTJO99DXKhmdkavg/oA6EBDD4OmL1D2joX
	kzDR/GDHAWWdgwOwiMbDFtAWI5vEvJTLTN/+kDVFqivB4k3FHG/wjNPush8/hMhFt5BJclof7We
	3qozNCsRNBzswyUpr4CnQQ63fTHyNPt7fUm2ggVpdsx1dYkJliKu5L7uTfeLVkt4SMYN57uF0gf
	6I6WNGkYUdnRmthpXlJpNVDuVTv4+aRjQ9jEiRLZ766o0l1JnBsiR1oSNvv+blugCgoPL0xxQoz
	/KsnO6CJTDrsJ8kYRramlm9cClNUgxd7S7ZqU2RTpbgY6fQtDOibkn5x8bemTcB1ooc=
X-Received: by 2002:a17:90b:3a4d:b0:32b:d79e:58ac with SMTP id 98e67ed59e1d1-32bd79e5d33mr12785a91.31.1757043707422;
        Thu, 04 Sep 2025 20:41:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ9PvfDXRf85pIKpaZ0+e/fu4IJhXoTc6zGnbjcuhclxnsGhnVwS+OEgvprD3RTJKovkaIJA==
X-Received: by 2002:a17:90b:3a4d:b0:32b:d79e:58ac with SMTP id 98e67ed59e1d1-32bd79e5d33mr12743a91.31.1757043706922;
        Thu, 04 Sep 2025 20:41:46 -0700 (PDT)
Received: from cse-cd01-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772818bd5e1sm5922315b3a.86.2025.09.04.20.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 20:41:46 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v11 6/6] drm/msm/dp: Add DisplayPort controller for QCS8300
Date: Fri,  5 Sep 2025 11:41:38 +0800
Message-Id: <20250904-qcs8300_mdss-v11-6-b6b6a67a1719@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250904-qcs8300_mdss-v11-0-b6b6a67a1719@oss.qualcomm.com>
References: <20250904-qcs8300_mdss-v11-0-b6b6a67a1719@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756974526; l=1242; i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id; bh=jmOF3YxLYSDfb8Ohpc4kXPJtA6m1LCaahphFup+ozoQ=; b=y2MHkOnGCX4UsKhNfZcloL+SNbTVPfVHc05X62CuJDECzxLMqihVz5DujWeU192GbDQtUNiCY iWrYKbzafawBZxMW0395JwCyixV/fY4bmbxq9iyL4VKvKizfzB4Xkwb
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519; pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68ba5bfc cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=E9mFum2VwHQHOKsBOicA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: SvuD8DqbDqLiQ2TbQM924eC5eL7c6wWa
X-Proofpoint-ORIG-GUID: SvuD8DqbDqLiQ2TbQM924eC5eL7c6wWa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX9KvwTUEwQqid
 Q6kLEjbgcL/MGzUTsDajofFvu9b40ag7r2PCrgEzsGcZXH9eXR7j03/hxzbOqqF9C2/P3ocKz/Z
 W7B36VzKh9BOFm1qRFCu7JbvKFZ7wIx0sS1Ie9qZaRaONs3M+ZhKHqRTGz/ap5FPgXqnD4ilWh3
 iU70D6ZN0kOUUICyz+fpRzP5Ivf1p1DHifi1fMEvk9CE+QdOOJdcqgNuVeZjPnmkeiwGpHm3gFa
 CEcVytYPB5WWOGtZM+DD35RDr3Kuw05ZyBbN0i21sFAK29Y5JGs8QLEHt+BlzC6MN87oRaNQh+P
 5wQce4kMaOvT9Zn9HsfsavaieiREl0EGBENcG+O4M8b/x2QzfIoscjpf9KWKFQsTU1f6bnHXF38
 8m+MeEqi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_01,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101

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


