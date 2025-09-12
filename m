Return-Path: <linux-kernel+bounces-813830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C93BB54B3B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 333B97BB687
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855DB301017;
	Fri, 12 Sep 2025 11:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DNO5V6jG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4718F2F28EB
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757677193; cv=none; b=rbfvw0JG+p/hafofAGoDuDfWq36RoCV4KI0P9L8BNAYmb09IX/Rh4LBkMsis7eIqDlyYP6+pJfJroB87eaj1kjw69UUVrZeRisFRixSJ5JGOQsusXEUkQCA97Vfw9aPPAFCNzU1deNu+4hijlBD6NmpLHvNzUqrXwn1OL7LeTBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757677193; c=relaxed/simple;
	bh=zsw44VeIS8tPBhNLX2AbLAqsAEVNVFzksn5mBiXdC5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XkaTYSQ4J9DKFNaDXGfH7VDhVVoYWbkKBO7GI+alyThiLCB8eN++8/6XkYZaojOtRBuNhYLLg55tw3Xj07u8w/p5enwwSeRRkapBzcRxb+jXaGV+Bq5QPX1LxvR+hCXYwiVgARGy0L5o3+qtrSUeOn0iKmIt1o3BLU8PgrSCtOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DNO5V6jG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CBBR6N017560
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BTpiCmS+aOzJx4voYgNQ5Cttmm2gaySgd22IqIIsiDM=; b=DNO5V6jGRZFKjJ8G
	REDzWZ09eSSOriS7/JdVLBtoVn88r/WwuvHOkJA585P0y+e+z6ZEmljbP8DPV0Ot
	o/4qspZ9s3ZSKCaPymBFcLTi5LRGDM9EEKW4/yFUWPlJhbFJDMAKygzWKZNVNhwT
	0Oqgd9aEybGGihqlVvXGcaoR7UIxquPwRKIogt/SWYk28yGsDGlTo9plUkqbD647
	eLKyCp5pwaZkngbD8X9x1j/3U2PD3CmE9PRPKCgFEVIWXZfTNaOGBW5wUqj0O0WO
	m4jqiI906up6sipn5yO8wnYIXFChb4ZV1GatcVGjRCHO3j+8kMS6aP1yQMsDMzWM
	j81xow==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494jdx02aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:39:51 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4d01b30e8dso483467a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757677190; x=1758281990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTpiCmS+aOzJx4voYgNQ5Cttmm2gaySgd22IqIIsiDM=;
        b=rcf/r9/zol32zE7lPgSbNCauWNt1sUe8mPj17ct1B0RUfbcc1q/9hJr6I0bemoE7RD
         tLMDJbDeRmx3XAHNAsD3bgcybRdg0cDHYy6oA7FCXm/HeLsvY4VOjcjwthDnnbPUzYSs
         IRquJfn0hxO8iVDZvuWvun/H9G0DAg2KmH5pK1el1zrHlezLhW/9h4KbkMstWkcifch2
         ZsYtmsc/ZL5NmWoVn9jUUFLaVtsM5RWD7jN4v/iOXI5zSowJVnDy8qNOLoTErDV1iKL/
         SrhRqMoEr9VyEi+LtFr3mE6nMq9NZxtHpiNlYsiVPSiNym5JPnJI4peIFl0Oai/JGfeV
         T9hg==
X-Forwarded-Encrypted: i=1; AJvYcCUjMyovHwcroWwQYQ8rILzFJ+jaT3YmyyvLdhcqtf6ZPuFd4c+xGKom7Y8ntXaZCK3KVtM9CpwxmxeHx+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaIaLE6HYpwjqZ+wCG0Ds2D/FkyBi0jzhY2gpvUZxhVaW/xLbg
	njxhpiumuGRfBVUhG+tq/JHAtwM3fHU0FutqOXGGGScJV9B5QJXN38tLVGiypcazUnJ18wk/enn
	8492E1x2qyrVgp2n03lSVVU9Td2PTHHkgkz2F015jQHCouAl0rn78gltpmCGpIXEMBLQ=
X-Gm-Gg: ASbGncta0I6WOOYce47H4HtzFokO0awMiZCk95pUbn1NY1NFWZPWW4mx1HfLjTLEShM
	Q+5AsxXOg8mb5+8KMv92KvVw0DIlWiwD8HMO/t9su+jEhKL+vpmkFJscJQ3724CAq5I7dP5fJog
	mGfssfxQVuvt93Eb+bU4g4VXQ5yBfxUY0xnwe/+/jWob9Sr3Ozjgk5nrIxDjvKaQHSEAG8Dl/NK
	Gx3wJWVVozr8+er88OSFFpUuo6yPoEMNzaFc85YPaVIqIvrOZibfC734EcyR9PORpSgg2vJZUf3
	Ye2qxpTcYfMGnYQ1Pj2arcDmnK0gCN8AKU39Y7gUYc24wmqhYJGnhpRifzySt0ldnkKQ6xfAdvR
	R7xqcTcwvvWXyzXWF//p1A0fff0BPbZpTP0e7JFeW5GFGXaG0ucc5aYTZ
X-Received: by 2002:a05:6a00:2393:b0:772:46b5:cc7d with SMTP id d2e1a72fcca58-77611f9a1b2mr1873635b3a.0.1757677189856;
        Fri, 12 Sep 2025 04:39:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELFvLrg5kPis7j53nKtzrsgs2TLYs/gVlDCE8CvFTY2T8sgBM9bn50GM9tw577E4AAn+xTlg==
X-Received: by 2002:a05:6a00:2393:b0:772:46b5:cc7d with SMTP id d2e1a72fcca58-77611f9a1b2mr1873608b3a.0.1757677189294;
        Fri, 12 Sep 2025 04:39:49 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607c45e34sm5278760b3a.91.2025.09.12.04.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 04:39:49 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 19:39:17 +0800
Subject: [PATCH 2/2] drm/msm/dp: Add DisplayPort support for SM6150
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-add-dp-controller-support-for-sm6150-v1-2-02b34b7b719d@oss.qualcomm.com>
References: <20250912-add-dp-controller-support-for-sm6150-v1-0-02b34b7b719d@oss.qualcomm.com>
In-Reply-To: <20250912-add-dp-controller-support-for-sm6150-v1-0-02b34b7b719d@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, fange.zhang@oss.qualcomm.com,
        yongxing.mou@oss.qualcomm.com, li.liu@oss.qualcomm.com,
        Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757677172; l=1260;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=zsw44VeIS8tPBhNLX2AbLAqsAEVNVFzksn5mBiXdC5s=;
 b=Wiv2VU+0hSjsT91pK/MSZfPi0gQD+MHY26Tlb8S5d2LDXH8c2j+H0K85uR4jH147bspO16+mg
 nDrmZ/85KDfD06aYmXxXgE14luXHDfN2yEFInlheFlMfGQaj7U0A/+I
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEyMDEwNiBTYWx0ZWRfXyiA7jA03Mao0
 LKwPwKgsn8aoxiCYfflMFU5flNnLaIdqK2k+NpZG3YTAlJhHAyFgr0BRl/C4JNq2/HMrELoVg/9
 YD1eRqxcfsardQDMMP4SOw4Yt3MXv3s3GJ8fEl9/ZiiUH58sUoYCfo7VOjNhXR386uLn1CXAjux
 8xRlesUMt+85zUGRFaYR0CmPFuiuh6lrrZNJspMARtghxXoYk6b8GNsvrXyGm5D103K4RvvE2zp
 vTsqzeAj0OFSTNvBpxXtYrKdjP4Tcy1SCDMWdTmYpbUZ8ZQu/c9g2PyudrOnT0J/hY0ETLmOcHY
 +33eT0kVXZSLIm2sfkp7/KGGHao7nZbY0f2pbwa0O2EVwUPQMw1VgVXHzXn4DvD9nJbut6bxRCO
 t6tqEzM2
X-Proofpoint-GUID: YZZo_yQLHslsBwXEX2Gy4U-jjwLqp6JQ
X-Authority-Analysis: v=2.4 cv=JMM7s9Kb c=1 sm=1 tr=0 ts=68c40687 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=zkzxiq2xDrpwyWBV8T8A:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: YZZo_yQLHslsBwXEX2Gy4U-jjwLqp6JQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509120106

Add support for SM6150 DisplayPort controller, which shares base offset
and configuration with SC7180. While SM6150 lacks some SC7180 features
(e.g. HBR3, MST), current msm_dp_desc_sc7180 data is sufficient. Listing it
explicitly ensures future compatibility.

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


