Return-Path: <linux-kernel+bounces-783958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68CFB334B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 05:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CB507B044B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 03:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E328D27B51C;
	Mon, 25 Aug 2025 03:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DJXT9R5K"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D037127AC2F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756092966; cv=none; b=npAxA210+b3YXSYrSNZMRc8/u5UfTq2/qM+XNbRw2OgdGqiFINwsAHXXvHnWH+4N6E3QfFo4zwGSXkSZ3HDdCDsNQkIjcSpJtPbYkpTK1+AgK6O6jQcQu5wrGBeP36Kx2KoQDLlwKSSVnMIHZcFJyEz4JEpK39PFBwG648pKW3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756092966; c=relaxed/simple;
	bh=/6uXAHc8u+Q/a1DjNDEMhzB6keYn2be9cZkXxsbUEe4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A8jiz/kYDUb8rfndMcICS2c1kn7m6Jn1YNCDztoZuGeZMKDdhIgyqTiYl+8XjRpw1d+VL6QgA+lQv6lNWv5cAgW4DuOjFzLU/ozGr74iT3lEzJLQDbLUwnvyUooO7igaGuCFHPHNSpbFL8nrGgQ17yGhxH0qyUDyh1f6vkEuitk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DJXT9R5K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ONws4U026003
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WIK2qr3/NE94iQwkqEL7J6K1o6tIhuvxaoMJhpu+NbY=; b=DJXT9R5KHnbXlOR9
	HvLpkfiLTlqx8SyiCyhbicplyJ8lpIudXTWHaJBZ9uW4SV9xTIuhi4h6Oo4HfjBl
	7Qmxxp7v4GyUHylQb4KgJQk+pt72Z15Hjx2KhzDXyFdH+MNus1hPdPyurrNoGHTj
	u5+cxAb+qIorSGCG8rJwg+ctPjbsXtqGnDPT2QPT2ZOy4S7FR8MZiCIaxNeIFqm2
	fC1D9TuhP9jg4ERqYxiptJ2KxRKCIyR52Zw7/xkniz2rLDyOKaUhTcTxdRGc6pKj
	XlDIdKf89MZ9UpXPGtRX21HqL7VblckPtDLNRh/Davv7BsSTA1vn2tQxxpLYHu7+
	QcEmRw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6x83h3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:36:04 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-246736043cfso38825415ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 20:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756092963; x=1756697763;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIK2qr3/NE94iQwkqEL7J6K1o6tIhuvxaoMJhpu+NbY=;
        b=eSKGj2MrgQkbmKm3M1mwbWjrKUe+sbvVrOoHS5wnQIrH/Ol7zMv/vYJRtcgJMIkhg2
         zI8H6ER3VgauAMr+ZZ2/uYCsGy2qS4jthueqrh2dHHN6BLlKTt0ZLi2IKlmse8Y5QmFp
         UX9chP/7Ysw48LSaY4v/uN8mmXtC6+04MOOHsTetTIPd04C769jkeIFw9wJ3ErQUu+RB
         on87UBbh7Gz5bA/9hu+LBZdl8FRMbcLoTTKK4NyKWrrlgbaV2SriDMDo6TOmvOk+mVIq
         K1hfJ/NYEHqg6InsGxnRzWkFso+9d4U0JU+wg6b36ljHSTdCmT1TlvBW/SyPCB6xSre3
         c1/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUeiayXglJhKnokk7M1+9EcOLN3O+dqncVpKWs026XdsYmktc7eDDtYbpsJofk1rvqstWtr3sZkrISznzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRhSRmGvGcmay1FbaOvxWIxJZ6z1S3X7bydNRa/cyoLCOGDxiy
	uv2yStPjHZfYsE3z/uOFzIywKSWPa0KBkVkA1Cvh4HZyQVeXvqzGx+2qslEjotyW9XVGj4LdjoO
	cXcwERPPYsXPyPideK0BTPca0ftQh6PK0ymuwe/yUZMHJAsKfqgSvn+sxQWY7xxYBpTw=
X-Gm-Gg: ASbGncvxXVOzQBxbXA/3HRRxTTs5gCSRa6AwRn40Tu56C7BORygTh0Jo/TiFYMlVijG
	BCQMujIZhOc08MdB5XibEgMWPl+qpQPFcVEpZD0RvT/wUx+iwGaUuneCoRe7ZEfMYX3iOVjET1U
	M2Lcga3yfHLsgPu+A1ggaIpNGxBIEQAWMBttytAXvFJ9yXLGf+GbbXrlDH/KFwbdizAXjBs//y1
	n2j8TXOYmPmT0s9fZRsn+L2Bxw9cHll1WVaNg7ujrL4/+T1yk935inQZnefgEmFLi9uQn9XTLcH
	Ox9mX1r6N2Djf0VpqZYOjC2YPUFg8HhugHnt2n/B2xO6o7JpGpawPDzPapgj5FLgewBneVs=
X-Received: by 2002:a17:903:3c4e:b0:246:24d:2394 with SMTP id d9443c01a7336-2462edee975mr127358325ad.8.1756092963171;
        Sun, 24 Aug 2025 20:36:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMK+ADbj8IibkXMvQhzNxRNUL8Vw+7sUqexRIIq/HnlxR/jdalo1CFv7QorQ1UzxMgNEWZDA==
X-Received: by 2002:a17:903:3c4e:b0:246:24d:2394 with SMTP id d9443c01a7336-2462edee975mr127358095ad.8.1756092962709;
        Sun, 24 Aug 2025 20:36:02 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466877c707sm54859565ad.22.2025.08.24.20.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 20:36:02 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 11:34:23 +0800
Subject: [PATCH v9 4/6] soc: qcom: ubwc: Add QCS8300 UBWC cfg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-qcs8300_mdss-v9-4-ebda1de80ca0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756092926; l=1189;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=/6uXAHc8u+Q/a1DjNDEMhzB6keYn2be9cZkXxsbUEe4=;
 b=RZoweSQA8ut2a4sjQc8joqF1yqfWGozxepRs7xCi8mrDj9AMGr2R2uBJ5UsTZWqRa+fFcOCcT
 Lq3oefRbg3FCtvWOFYMAZT5M5XY5q/qLGJepIPBPhY7rdaiGdTA418a
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Proofpoint-ORIG-GUID: LQ6Lu4K8capOlWycgC-Z3Gx0H4Zg2RQ-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0NCBTYWx0ZWRfX0+5vD/ceDymt
 79nRXxOTLhmiYWC8qCJE1nZfOWQak+Lp4p194Y6OXkVKICiEA5uFEtg0P0BAUnpYrww+JQhimyD
 +PsOAXx6D+kCqvd0rGxN8Zwp6p2o+xiBJPz9mHX3t0JBBVV5UVY3UB7e5U/iq8ZmGswAKj5gOWy
 6vYgMAZ+3/YGuW+KwY3UHMj7V4gz5/mwE+hMpNhBjja/gVLpuvBiMA6cw9v0bNZZrH5VhzjPgxV
 hMoIh+qvEaiPVKbWqVPhVq0mzfHVXONx5dicZg5y3DbzXLVJz2pB8G9t64E+QNBtZOus96l0ht5
 t1LCjtO43M2TZFHdZgUoN31WAxz93QaHxOLfQxe0FaQQTKaa2ydK0A6GSFhCoTaROjGMbXBpG+q
 dsG0A3KJ
X-Proofpoint-GUID: LQ6Lu4K8capOlWycgC-Z3Gx0H4Zg2RQ-
X-Authority-Analysis: v=2.4 cv=Ep/SrTcA c=1 sm=1 tr=0 ts=68abda24 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=yyC0Gtz2zuuxwh5CSaYA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230044

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


