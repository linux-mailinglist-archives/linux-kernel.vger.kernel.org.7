Return-Path: <linux-kernel+bounces-778860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCB4B2EC24
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4A227BB815
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984272E8E05;
	Thu, 21 Aug 2025 03:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WNhEtQwz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD932C11ED
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755747442; cv=none; b=dq3mgd5X7XMP4G5nZfGaiXUMgz3i6X/zj9C+xGCw2FXDBiTum0yP1obqLgINx4xJgrnCF+zZ+wiExsc9TjZC7figPvKnCiJZOqmwkSKTrNK5YJoZcVB/A3i/NBg3YD2JWYTzlFFaVny+6Ejw0OFInI/xQbbcsg79coAseA319vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755747442; c=relaxed/simple;
	bh=/6uXAHc8u+Q/a1DjNDEMhzB6keYn2be9cZkXxsbUEe4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lgrFEhdAJAj0nIvRJm2q0r/MiBI5satB9xaUfcXX4gMhKZOUPDeKA8mznJ4GybAy7o6m6KO8WmV2kSWOkbRn1Tl7Q08mA69OMaYoRusZsvZZrN9CZwKe3mXVCvbjmiOG0rL+f5AurMyggd4+ALa8HCw0deejgT8ELkHGl80gWmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WNhEtQwz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KJFGk3026051
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WIK2qr3/NE94iQwkqEL7J6K1o6tIhuvxaoMJhpu+NbY=; b=WNhEtQwzj9cmkG9C
	gKNtR9kKQRmkFRkYW3g5clgGxOYtVJ6MlNpwsM4lCNOtY+s9HUZvCNiC8YXe+LQw
	hulL1XttHEsXP/TEU3oZYBKyXnMNo0eUpikA3Bw47iHS1f0TByHPVjQihfKOXUyy
	7fv+ELIt+zI7eTW870Pfhp5G1ah5l7s7i9G5ekOwahBD7hcGZf4nsKsxHgNMkh4g
	kAs63c7LAD8tT4EvcWvesZc3GXEQzZfJzvIxGHF6j+XoReS9Ix06y/GTVk/knFrn
	hzM0F2XYN8E8YohUPDI3QaB2q/oLYq2FY883gPq9s9Oyb5qzncu1DrTiu/Y+792h
	Hu8R0w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5293vb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:37:20 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e2eac3650so1804817b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 20:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755747440; x=1756352240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIK2qr3/NE94iQwkqEL7J6K1o6tIhuvxaoMJhpu+NbY=;
        b=IGYqbl/b6sm9bLt0y5wljA3ejiWVYS5RCKItB1cOF4W6XdhpcWc3G9N5TkjzLt49X0
         C+bNdFDppde3IWKh9SX+JDKbMi625+dntXNRyPYeRVnKlgCH0Jm8YTgSnQPJ8Hd6x6Bf
         8ElJ2nhCsKXfefIVW2nzL3AKJAva/dg6wLDaqzo7D2HKkxHVKIBbpHxFM26j1Pamhd3/
         QseZUdLWxc7sLAsDUuEr5ZkfQQA+Ykz8ji2iTgYuNgMLUTI0BYcf2irpys7WhNmy80YW
         Wihh9qg4gqmjkt8t8o1y9fuCxbHykHhHR1bJMGtRJlWvFijRb4+ngSBGoYa9FwojnUng
         OXwA==
X-Forwarded-Encrypted: i=1; AJvYcCUHPPyHByQiLU725XvF4m90jzE7+mqe+evIwIt0hC4RaF4BkBlCcSg/IqXFH/ue75p3HTAY11rPRBviLlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg06MCd4o99dAVIbFbQcyjeXZWvwT2BVJ/0tTob8Bznntp1rXB
	BsOQvNS+na2LfVGr/rAt4fhbILRWFWfOhDEyrHTeL4vAyzqlMX/rYZhHe5iXyucxOC+bQgPQvrX
	DxjRywdZdzKRHnNLbVfsh+QkwynX74+dFh96Zoh7N/0N0jPzmYUi22Ca3+/KW7I1423s=
X-Gm-Gg: ASbGnct+ayDjlzaAkkVdy02j69lFKnEkECw8BMWEOch3fBw5oAwNuHQf8P7xpVjyTVM
	JRbC404yYKmtG+XH2fiOuZeLBT9CSq0sTk2bnVUUvSHfl3FhyV3oe9FpVvjOxZDlLt7dEbBUeuG
	0QSZoYmtafwPwFeb/+38hSaSdd7ItP41kB0PNRc1a+gMwiPnBm9mWrUA+cEnguCxwJeeUB+oXf9
	GS27okIMejiSyEFp5QuHtEKNKRNYW/yjOwQYYtbBxR/8rnkAg3HJnxl05hRBnUGJ5Rcmp5rR3w5
	KSDubcGR/HYIBt3NUJX40Yy+9++7PGFIjguaqI1BhjSgGPncTKmVo5xrN8mHU4rNztRkaMk=
X-Received: by 2002:a05:6a20:430b:b0:23d:d5c3:c92f with SMTP id adf61e73a8af0-2433084ab09mr1143136637.7.1755747439748;
        Wed, 20 Aug 2025 20:37:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+tAEO6RQ7A4Yif9M5PGwG6tBqJ9xmZEWW8ipYZf3ykfyR3Cl22ZimZ2XbB0j+wgWpjjPh8g==
X-Received: by 2002:a05:6a20:430b:b0:23d:d5c3:c92f with SMTP id adf61e73a8af0-2433084ab09mr1143101637.7.1755747439294;
        Wed, 20 Aug 2025 20:37:19 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47640b6554sm3497780a12.48.2025.08.20.20.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 20:37:18 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 21 Aug 2025 11:35:59 +0800
Subject: [PATCH v8 4/6] soc: qcom: ubwc: Add QCS8300 UBWC cfg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-qcs8300_mdss-v8-4-e9be853938f9@oss.qualcomm.com>
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
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755747402; l=1189;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=/6uXAHc8u+Q/a1DjNDEMhzB6keYn2be9cZkXxsbUEe4=;
 b=PAchjJlEg6YULryzF2qUBVRmkx6B5muCm7v1gdEvjkVwjtgrvuc9yDJpeJiZirjS7AjHchmY/
 XBkDPxjkAr+CIuWlqlw0wdqfS7TFHq6xnd2Ix6GRqyFNzToACWb0cCX
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Authority-Analysis: v=2.4 cv=ZJKOWX7b c=1 sm=1 tr=0 ts=68a69470 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=yyC0Gtz2zuuxwh5CSaYA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: yrrGLCXxMERAEWrJKOeajS5ZYKt6x48q
X-Proofpoint-GUID: yrrGLCXxMERAEWrJKOeajS5ZYKt6x48q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX8/a+aF38JhT6
 D5AHIxh48HFH0QlcR56Rjkii/XjKZhFzTCNEX/dZE/v6PJoRaf1WMArzQaIEfIuKnNzd9uatsKv
 rjlaU1xHnGRA+1gx5zgD4AobmJiZNWPrKw4P3fjZPqjOvtb/6SLZlRy7uwN1WJCSihEoz8kdIvT
 8iL1LL5tzLl2+pTcbNq+/WGxkvnBTcCSpJedumT4yK5hxHbJbvCWafy3l58XxFCZDuOsRyOb1EZ
 6DbCj2DmE/I6vIpfK1M3HN+rcywGKIUy/aE9uKIrWapTiMbjGkQm771poxtrPGVIeCbgbOuGxpQ
 vZMpnJyD0UjniyM//+MaCBYQyQ5LiB7QJtsohQD/Y10RHiS5NbtAfF62x99+RzyXsFwkp+ueodB
 xCnHuVFtzWYE75/aKvjc2Lie1C7O2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

The QCS8300 supports UBWC 4.0 and 4 channels LP5 memory interface. Use
the SC8280XP data structure for QCS8300 according to the specification.

Acked-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/soc/qcom/ubwc_config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index 1490a7f63767bba176e8e2e76891d7d2c424bb7f..b70627d40dc4c671b8a855a17d4b8ca2dd9952d5 100644
--- a/drivers/soc/qcom/ubwc_config.c
+++ b/drivers/soc/qcom/ubwc_config.c
@@ -236,6 +236,7 @@ static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
 	{ .compatible = "qcom,msm8998", .data = &msm8998_data },
 	{ .compatible = "qcom,qcm2290", .data = &qcm2290_data, },
 	{ .compatible = "qcom,qcm6490", .data = &sc7280_data, },
+	{ .compatible = "qcom,qcs8300", .data = &sc8280xp_data, },
 	{ .compatible = "qcom,sa8155p", .data = &sm8150_data, },
 	{ .compatible = "qcom,sa8540p", .data = &sc8280xp_data, },
 	{ .compatible = "qcom,sa8775p", .data = &sa8775p_data, },

-- 
2.34.1


