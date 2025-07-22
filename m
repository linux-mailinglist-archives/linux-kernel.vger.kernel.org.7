Return-Path: <linux-kernel+bounces-740331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6C7B0D2E3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE9DD168211
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D032DCF65;
	Tue, 22 Jul 2025 07:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="icgi/h3C"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FE92C15A5
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169029; cv=none; b=ANi6Wg05AbCbIrh+8iVXy6k3YJp9lNLKT9R/wMlwM4RWiXNghBNdUiBQ1EwHR8s9/daDDEVo1jrsodsruv1b5hQhQQ1gIuDOdQBnT2TiJZfWMoBACshw3tdROEBkrarM/6qJfwzNSNN3ei1x0H4ycUSzpXQRN8pRZSSMihi0nWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169029; c=relaxed/simple;
	bh=ciyqoCYFS3+/i08fo7/Fy7G1mvvHDXj3yVN7GeS3ZyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EA0EDhtnxITv37/WpMyxVrv+sYzfrNfxNONTj6SYQr2C6f4g8jYC/QmnZbVDquU8ODrqUH0u6sg8thMDyHi/oKi+dTA17azwHbl03QObrN+4xxJ5Qx+25O/vISh+1rO0iFCEGil3h7sFAXzdeCdQ2tCOj/RUflGr5yP/7tYAu0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=icgi/h3C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M2Ek76016268
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X7rTNTg/49ZHhf8B4W0jhkieUw+2aiMDE3XH+NwjhvM=; b=icgi/h3C+GjuGd1J
	WvE5bc0YhbTS3weKVinY83yE2zIwuULFNxarVzRuWMS67JuShghgGELWPRNUHqj1
	yBwgyvMiL/onk5YAAHQZ5InCCmZOtQ5jrqK4YT0xUdRQLS9jmWs1kbfSGizXNNlX
	b3OQzNfHFfLcG+MdRuCQ+EVQQh4LXumlX7jwj6YeaqFKP+1RV+F6GzC5ej4FbvM/
	eInGX8gJWEXS/4sYUhIUzPgQf1F1AZRy+OenETcTzhkAQmsQOTl7ODaVQqtq/gt/
	AjpQTOgJZ84wClAgsrLVeckFwR9KdM2znRFEFigg8+8ldq6O31Z/A1D0Vh74cP7R
	lGX0Aw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048s0huh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:23:46 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31c459ccd56so1117236a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169026; x=1753773826;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7rTNTg/49ZHhf8B4W0jhkieUw+2aiMDE3XH+NwjhvM=;
        b=sQ1Ledkcs6uR1P213JC/AN7IYsc0IdRhPPpG2/6WbEu+VQbQdkdsAfD/zO7vHw6GCX
         H4vljuhtNO0/M6MwQDwchJh55KuJPl76rzwH+sZd/yrklinW0H/ayRCtrU6kK2j3KEDl
         sKu53OdWksljzYjCnVX9jKuaYvdg1bBnggOhSjF3G3NR1DF/i6li6mUsLPGYcME6sj15
         z9jqJ/UDdq6fUiBOFvFvyQBQD4oIuW3vn7XFFgg//MYPPrgffeHn7OugrEUhq1XzbRiA
         Z/3pjTt6bVB+TJVyDytaTbBP3a7G0D43BrN6GLFnfNPZjpfIam8AWl9jWyK6INVkR8pv
         tAUA==
X-Forwarded-Encrypted: i=1; AJvYcCXIv9Xhm0UToN12673TB1rGSoIlUyXyYkxGS1Vex4z0fAUYprGuF8A0vvlet+JKQK19KS+duz3GvOSyuXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX2Oi4Ev3GSpnW+QDSz+04gZuK5aM+jT38JjMBrrAm6X0GFm9l
	VELFA+Czrc9KQqIoXUUIKGSwMlUfkT7ZZEOvtuK7i+bTdDT43bToKD8f70xVKqVo4bqYQBauf6P
	DIkmv/DlzJlf5402G39RD2XQLC2vcRPBHA4WUvRD/O11k1O+NYP+xe76B7kq7Qc+MjTE=
X-Gm-Gg: ASbGncuXlTRnhez5hKYaCl/ONSucyx9Ah5hPIeC8vl9RCZSvUdUB3+XfTIz7nB5RA2u
	P/STmVKblku02rPdX+ljJ9lIXs/LKo6bRkM/CbIAipGv1w3Wzksc0Q2IUcOXumCO+Y+V3zMk228
	HTBdWa3ZbbHlm/TC+wMWb4jOOBVG+pkI7kik74A2C14NoBxMy+Ebg6qCAVn1RXKDvAZwiFgFrLX
	T+KAp8Iahk/hVBQynP8xtWyorXU2KeNMQ1C82/8aF59xLEJZnjzaOtS0w4Sfqn2bbTJAuHO5TUM
	/9LzHkNDkbMtfWKcSTlcgLu2qT051fnYyF8jEW/FKnYCHrLl6bGF6zsxgkALT7a3In055Xcx9w+
	UpBOSHfUqITSxhjqgyTZZyzQJkJ15w22jM6sDw0LMKQsUjuVtE5O5FVs6
X-Received: by 2002:a17:903:1a68:b0:234:d7b2:2abe with SMTP id d9443c01a7336-23e24ef7922mr141277145ad.7.1753169025674;
        Tue, 22 Jul 2025 00:23:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZi2sVWjlvxIefJwnEAsJbibA0RoEFuNEkqwkL4eJL/Th6uYnt2AV1OJZwiVCrhQBLPZSpSg==
X-Received: by 2002:a17:903:1a68:b0:234:d7b2:2abe with SMTP id d9443c01a7336-23e24ef7922mr141277025ad.7.1753169025225;
        Tue, 22 Jul 2025 00:23:45 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3e45e6csm7490753a91.3.2025.07.22.00.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 00:23:44 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 15:22:13 +0800
Subject: [PATCH v2 12/13] drm/msm/dp: Add DisplayPort support for QCS615
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-add-displayport-support-for-qcs615-platform-v2-12-42b4037171f8@oss.qualcomm.com>
References: <20250722-add-displayport-support-for-qcs615-platform-v2-0-42b4037171f8@oss.qualcomm.com>
In-Reply-To: <20250722-add-displayport-support-for-qcs615-platform-v2-0-42b4037171f8@oss.qualcomm.com>
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
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        fange.zhang@oss.qualcomm.com, quic_lliu6@quicinc.com,
        quic_yongmou@quicinc.com, Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753168938; l=1195;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=ciyqoCYFS3+/i08fo7/Fy7G1mvvHDXj3yVN7GeS3ZyA=;
 b=FFmdwXZ8slTdA0DVE9pvzO1FYYEDAJMGMU1mJ7YxSnMqTiMvS9E6ow/3xLAHL6dB1Cr+/Lm96
 yucXBPSLDRWCQ54WzwHwXgwV6uLy40ZWzhspxwW2naZqPRAuu5M8Fc3
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA1OSBTYWx0ZWRfXwcK7mwFhyWQs
 Y86Z2CIRc/5CAp/VtYOZ+7uZ2eibehxN9B8CKyJ2dBriuTmA0zUq1CAjzqiZehVrUNxMoZF8m7c
 jef5jwwsEsndGNmncAvR4bjcs1p2eUAhBifhgyDTsHGhInahNpTl2BHA0N5f+JOc8hIZV820rXs
 fJZWLHok4Yb09YVhMBczyMPBTrPkIBZ1YgVgZyVMhkOrS3xdIuHUHfEYWBTkAcSy7BaECOeB01x
 GeZ8iCNpzu8NisXKr3e4/XAnEwoCENHwf1G9WLA3S99s1ANEsdqTiUaPFOJJE8SSeG/dfU4mJD/
 UCfHTuqaPZhVp7Bz0mQcsFGv+LCZzn+rE1JlbXjnGnofGBG9cE+HiWTiHrZyZgrGLVd34zZFHyz
 zHesD1A6WHDGvkDr6itVErJZRC9pTm1kXkRlEpNfd+SmVRYFZoAnmPucli03ORUX4ZZEDBbA
X-Proofpoint-ORIG-GUID: i8cS9dkvLZhQZEJnE7EpY_IqAp7oRPVz
X-Proofpoint-GUID: i8cS9dkvLZhQZEJnE7EpY_IqAp7oRPVz
X-Authority-Analysis: v=2.4 cv=OPUn3TaB c=1 sm=1 tr=0 ts=687f3c82 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=f-sKLqVA4YZL9HvktjMA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220059

The Qualcomm QCS615 platform comes with a DisplayPort controller use the
same base offset as sc7180. add support for this in DP driver.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index d87d47cc7ec3eb757ac192c411000bc50b824c59..ddb22b50490035779904d4cab20e2fee7e0f9657 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -196,6 +196,7 @@ static const struct of_device_id msm_dp_dt_match[] = {
 	{ .compatible = "qcom,sc8280xp-dp", .data = &msm_dp_desc_sc8280xp },
 	{ .compatible = "qcom,sc8280xp-edp", .data = &msm_dp_desc_sc8280xp },
 	{ .compatible = "qcom,sdm845-dp", .data = &msm_dp_desc_sdm845 },
+	{ .compatible = "qcom,sm6150-dp", .data = &msm_dp_desc_sc7180 },
 	{ .compatible = "qcom,sm8350-dp", .data = &msm_dp_desc_sc7180 },
 	{ .compatible = "qcom,sm8650-dp", .data = &msm_dp_desc_sm8650 },
 	{ .compatible = "qcom,x1e80100-dp", .data = &msm_dp_desc_x1e80100 },

-- 
2.34.1


