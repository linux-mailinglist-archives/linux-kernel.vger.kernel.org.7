Return-Path: <linux-kernel+bounces-783959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 917C7B334C1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 05:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C254420A40
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 03:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E115A2777E5;
	Mon, 25 Aug 2025 03:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KVJCpEGy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C360E27AC2F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756092974; cv=none; b=rmsAWjN6IDDL0lm9FXgApjgicwMo7TME6qjBHuiEcgMjuP4+dmS/+dko8rHTlPF3f3YMZb48KE0rALX/KaXEh77Qm1e0dXkD1c6jwLcFkAwkOcs7gwq7GH5pdlsZmLXt18f6fGqyYXneb6ETVlYmnAK6atqdOoSna7v5qTrNuqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756092974; c=relaxed/simple;
	bh=xP+KCWOk9SNxzFjMtHR6U06UR7/RbmmfOmVurK6QZow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nPq6v4WjmnEwgU1OHqanGdRGASY+VBwnjezGVZTg419qPwKqTjJ0R7pqbj1NkaeXMjwPkKFSa82oPnURwoHd5tTsT7N4WIxpmrjXhEgjdhpuzIgFcSA2+PtqCEbnA/Qiy/8OChTpGtrEIAYp8GyAdYVY9dTmi1/AwGs3aPmXTl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KVJCpEGy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57OMxflr002246
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Nc/Me6JhWACWqZ3Seo6sntz583zORBKIxRCpmiza2Ms=; b=KVJCpEGymbGybPM9
	Rkz9IMMik636mbIVWADF4ygtfKUH6nNdiZa4JvUqfBDOVkx9uqExDoyHAxFCRsHG
	ENuOH+2FYorhI9svghNSW/aV1MgRyhCdfKzsE4tXdNv535s31/u7/PcNy9RiTGl0
	bRI15QM/JGXBLP5KGv9cZcSbv+/uOdsfYIB6irFqeHYxtvey6ja8KNVau2cXY5tT
	3RuOMATqXWOAaZazPCsu0U+FDtKS+odvd0SJCyLtMc/sllQARZS/1KSaZtCWhLUX
	fcZLRO8QY66cGG5YrrGJ/V3QKRwjoVNPL7BsHVMYx2nmvRHVIB61Gp3tLJoTZisL
	SX3X1Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5y5bgku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:36:11 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2468b307df7so12601025ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 20:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756092970; x=1756697770;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nc/Me6JhWACWqZ3Seo6sntz583zORBKIxRCpmiza2Ms=;
        b=i3HHBwUxbcaJV+BRNexPDuOgdi6HIDkBVqYwHBqFjSvxXzUMEuY95SqZCmUsqKRwuR
         qMBpNctKs3t0aUTukhmJxveAX3qYy7UAsldFAEOBDhmm0yuYKa7Nk369WGr+llzqNxOD
         yqnZFx3Xgi0a7lZyB9GRpzvwFw1U8cwfRMVZEpMN5F67TTtQLVTtg+dkmZlVHqYtXtl3
         Wg9h5RMZIRokQx9uVtAeOaOLs7Yq0HkvJsLToe33C4ozfxaD6GCjDQcKd4RItbr3Y+fP
         pNBpD9weEsSub3oDlzTig0Tt6QjxP7B3mY5NnSHnayqQRv4G9+hnpLd6fixiRbo2GCgV
         nYXA==
X-Forwarded-Encrypted: i=1; AJvYcCVVHhlB6EtcFkkQdOzJtxyD4Y6g3UXhqAikrAPFoKcf7WcZLuH+O3jZDCmnx3sy2D7Fa2Ib6loOLJDjAPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYNVIpUgfxwio/+MKEKFLcKfb++nIOZrHPN/17iD1faLASyWF3
	gIjAZ46dKpZgESx7cmB12ip8qT/VqjVBVV6o/th4XG4hZJNBH1kisilQfwHa2Vo6xgrAH91z/k8
	W1dEoVMP4XHV81awzyQC9CXmzYPM+chfvbPgmgs+q+7bcdQylq+Al7WteIMPtmv/1lg4=
X-Gm-Gg: ASbGncvkIChcuejVUgf6+gyHMUXV1EM61B/sAzTpRtxJtj38/ckvWFjaENHA74WKgu4
	mkWujFIJqccUWOJRNTQ2KJPxXMvLwUMapclmmuLTog1lmzv01d5ntjXE4HYyhxjh6m/Ja5JHTwc
	PGzTvi+hEhi3IqZ4yIVr36KS0GyAGc627wMVqYT1Wh/j+dRG/58MciMnka5tek/JSdezi55rYqk
	Tl4df6A54zV6wZwdWDuhDlQmcfe4848mWINFe1iqNt69GgjtW+IX3XQ8xBN1i+3O7BXx4SmFJJd
	qb4IVEZ7JuSaZe6Pjzb3zISu0ovTIdggwlCYfxsX1FIAihleG88fL4G1s6AcHrqxG+sW6x4=
X-Received: by 2002:a17:902:ce90:b0:246:5214:e166 with SMTP id d9443c01a7336-2465214e452mr98782735ad.60.1756092970418;
        Sun, 24 Aug 2025 20:36:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzTqSR67U+tpNmDgf/how6hjhQZdfWFRotg9qOkMwQOBCL1NTrcmhM6hc2DsV3b0TbsOsshA==
X-Received: by 2002:a17:902:ce90:b0:246:5214:e166 with SMTP id d9443c01a7336-2465214e452mr98782415ad.60.1756092969812;
        Sun, 24 Aug 2025 20:36:09 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466877c707sm54859565ad.22.2025.08.24.20.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 20:36:09 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 11:34:24 +0800
Subject: [PATCH v9 5/6] drm/msm: mdss: Add QCS8300 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-qcs8300_mdss-v9-5-ebda1de80ca0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756092926; l=1044;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=xP+KCWOk9SNxzFjMtHR6U06UR7/RbmmfOmVurK6QZow=;
 b=FDyvGFXblAvBxHfRLhBNE2iuwsCHg20XL9cYb6uaNzOfq+jOhcjID6Tdrjb1NsPhIGdVdhyxf
 M4kmoCsJlbOCNbuFyrTSCeFqfFRefX4qhhz0HoHJUoA3h8CbL447X5M
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX2HwH4TEX/u9J
 NKlCUnk6S4Wy7rJdAJpW0j9F6AYHiz3Acm9jyslrpkY/TTpWU9pkhqLXVEWgKbm5rMfytx2q3xE
 WMZDdqSLHyPWEuBrpC2x3+H2vmU49qH5MpcccV44/Q3PtcB+K9TBqSbpnuPTKnEw2gZ4HkcigDu
 b7/w71LezOEreIUrVcqfrOSGUMBg79FKBTJCgaal5lWjJQMpHtqqUY4OmOv5ivMFbUwJJJ0LY//
 dDFcq94aD6ACPPUsyO9j1MV7fbsywxzunI+9LiHCXyDDecpoSL/ku7tf32RP5R8LCKMsxqsHNSF
 fNRuMSUl2zDNW5i7ZEid/adKkyw4tMcO0O0RpEtt7Xd/hX2nVynH68u5LpPYDNiBhPT1bymC/YR
 iBa8wE7s
X-Authority-Analysis: v=2.4 cv=Lco86ifi c=1 sm=1 tr=0 ts=68abda2b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=VHyea80QRMuD3TjLfpgA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 8S1R8ln2IonrFpK2OTBNarQ3uOhgwtgH
X-Proofpoint-ORIG-GUID: 8S1R8ln2IonrFpK2OTBNarQ3uOhgwtgH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

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


