Return-Path: <linux-kernel+bounces-737663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C72B0AF0E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 11:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A8A1C24A06
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 09:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60E6239E7C;
	Sat, 19 Jul 2025 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ajGrBT/U"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67637238C2C
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 09:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752916491; cv=none; b=gPPk99CjdaL3KICZXvdLZNgujdGwj3M1qE9Ev4OEzA3EdB0XcR78FHcvv0WztHDK22i/FWk/iwXXgQLvgIBuRubonir4ojZu6mB5UJWdHrqyMASCtrHSemR0H/NNf4WZYRh5JJJqBPYhenhiJeVCdDuQUwceIjpkqVrCIsLQpec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752916491; c=relaxed/simple;
	bh=jwVRqM0theHy/Aua39lYnAS5tUnNexlBP199jrO9fzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kDo47y5oMxKE5FpFjW0No3SMuZk+vz+wsDsGYDRciImPH+ABzj56HZz4uBlfeC/hEuxASOH8ieqOaXakMgUt+8q1FkCtc0C2lYPAoxyNScfd6Q24/cUzFyxujwcvIMyneBTQlefcushBQUMy0JoW4KBPoyXm2m+X6XV12owMkfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ajGrBT/U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56J4LG3R015197
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 09:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=5wZDc5GWMWk
	tbr2LV45DqbpFgPyVLPIoTjpMyPCwwzY=; b=ajGrBT/UWPZPh3lDzNJCKksjJ58
	ScqhDdABcfpZ1w+Pw/FlHyanswabIFUYVjxiW2c0uAWzDWRwhDruiy58CXBe0OHV
	tYpBE68t5FVXquVTi88ZGucL9ul5eejn66A2LNvUqvRRgMg06QXf59zjKFaLuEBT
	zR+jQbGo1syi62E+OhIjEf5iTcn20thjkNH1cVBk4+XztCEfN7mSH9aMtbRzVkpb
	riEdOQqJSPb1nrNToDEWSsDUyFU9eeosMMGBXXfa/H6gvhX3ar95EbIygdcA6e5l
	icOxtA7C1CHRR/J/cQFL3S0tWECv3zJR3n5MqA/1tL76U9qbiHl1LZydpVA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048t8cph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 09:14:49 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e269587d8eso493848185a.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 02:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752916488; x=1753521288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wZDc5GWMWktbr2LV45DqbpFgPyVLPIoTjpMyPCwwzY=;
        b=H1a92T2HQfCKuBKvgRKNbNVUlgi/uphkUYclFV2kmzrMD7CGkRrwuJxXzoiHlTEQUg
         oAoLJb19BYEkd2XJP82BT9pVrHQOHvooUzNTNC8fSQrA8fLHtiOTSpEnYGXxsiESN6iq
         mZpvISPmCAculbDqfNtANhKTj2LI6R58g7sR/i8TzEdOKKViFgoj387ZpuCIe1bzw6jM
         FPamZ0lm7+4zb1ZnUnp46dXOqr+Kg3QLl/mSIcFtGflcBl7d4gXWA6dJbBfWfaBM5DB3
         IftG0rxNEtVR25cQMr7HuRBm+MICGhpdUzlbsArOQoBVP47t2y1MppZr17SQTnZvBFF5
         PQrg==
X-Forwarded-Encrypted: i=1; AJvYcCWda+uEEiGow7pUQ+D+i1eONxLV/PMuSW7CDK4YGZcn+boXK1fdq6nnUseEZHSzFbHkzmifGX0vtPtfrLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrQ8E5RymSqqoaAi4NqX6n6GNrUJWEFGKs1OaUgIHzKRo1svsm
	it/Nbc1VgdaB//G7LT5CFt/rFTO8i6YMj032P05KtgXxtA43qPJj5ldN9/MtSFk0CdbxKUZ5Evi
	UwiBpTsN1b+SfkyMJ1pegMzmtutF72oKzeIw0XsS+/gIy0CBBuwA7psKinlCnYb/xpa3FGGgrpx
	U=
X-Gm-Gg: ASbGncsRhRFA5TID4wPoFc2C4ym6EFatZLNhPoCGG2YIs6d6Zm1S8hil2jVzu9XDg5d
	Bax+2pwP5nbacYoNM5Uwax0saUFTbq1dQdAE/IGdpNBpVVlzRlD+M3/ylbhHRzGFetvSNQWj6I7
	Ans68tf2oH95AqNdVOG2Ln2sQ9BcRMOMuly14G3LGZiKbm3vlAM91VG4efLWIjW40vRSbpWln9D
	48cEbYEL4QoQCrp1/Op1VXuUkE23mFM4HBmEhwpIbKCz9mSDu+zkeykfTh8IXP5b60YUJPlXJfa
	KLWuzu3Zwf04amEr8iJUIJ4XEBj1NMjBqA5YwaLPJYc4Wtr2Weg/PFhz5vlW14SvF4fKvXvNwVb
	IdZEWf4Euo+7x5e58PlE6d4GvKEDtyseq1NlflcGEHO4t7z6dOgYQ
X-Received: by 2002:a05:620a:4050:b0:7e3:4415:bd05 with SMTP id af79cd13be357-7e34d9f79e2mr1305487685a.60.1752916488064;
        Sat, 19 Jul 2025 02:14:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDAN35XkTBQM2UPvbexmAbV/sfM9zAiC11TqR3XTg/5fyKgjdicRbMY+x2+0LlwRcobf3JYQ==
X-Received: by 2002:a05:620a:4050:b0:7e3:4415:bd05 with SMTP id af79cd13be357-7e34d9f79e2mr1305486185a.60.1752916487632;
        Sat, 19 Jul 2025 02:14:47 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a90d4ffasm5480891fa.6.2025.07.19.02.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 02:14:46 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Mahadevan <quic_mahap@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Danila Tikhonov <danila@jiaxyga.com>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yongxing Mou <quic_yongmou@quicinc.com>
Subject: [PATCH] dt-bindings: display/msm: dp-controller: allow eDP for X1E8 and SA8775P
Date: Sat, 19 Jul 2025 12:14:45 +0300
Message-Id: <20250719091445.3126775-1-dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250717-dp_mst_bindings-v3-0-72ce08285703@oss.qualcomm.com>
References: <20250717-dp_mst_bindings-v3-0-72ce08285703@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE5MDA5MSBTYWx0ZWRfX9T/NKwnsq6HD
 M4qaNqwpXhuMpzO7f9WxIWAW7SXE7HFnDuBNpDkdMoNxIqOHhs9ObULZGJfLfM/aDYj+YOa3845
 A+yf2YnO8df2rfZCeI6OIh2O+9U9oRXLLcD7YmNPpxNJXN5oHKeAz1hfamDlof10SbDsHAW3knk
 n4GjZQCaneYolflJinRXq4MtcFKANRBZNXUprj2Q7ItbAHaWh5/UIpTG/0ctC0+EJZdbwTxbpal
 e7io1E5EsK0ofwynsbCyTIjG2w29ojei70kBJVea+mGjOVhoawUW5+H4ZF5oTHbFmzNmycfqHiB
 7ykDF3eF/FWrDffMN/w9+qM2/Fs+DxEg0oYXnOMCT31yoAOeV8YIwxX6nTNTRjQXtEWOg07D+2J
 Za1FwaV6r7TRLmqc3RavysdIYNkFfz9+VfQYrhegZrXLFBMxXKeskfuJxNy2XGawQIXHmo8M
X-Authority-Analysis: v=2.4 cv=Jb68rVKV c=1 sm=1 tr=0 ts=687b6209 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=EUspDBNiAAAA:8 a=jb3qBSlP78txkkNFhucA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: PTnTiaqN_d5iwhhw9YVMEgrppT23J2Fv
X-Proofpoint-ORIG-GUID: PTnTiaqN_d5iwhhw9YVMEgrppT23J2Fv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507190091


On Qualcomm SA8775P and X1E80100 the DP controller might be driving
either a DisplayPort or a eDP sink (depending on the PHY that is tied to
the controller). Reflect that in the schema.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---

Jessica, your X1E8 patch also triggers warnings for several X1E8-based
laptops. Please include this patch into the series (either separately
or, better, by squashing into your first patch).

---
 .../bindings/display/msm/dp-controller.yaml   | 26 ++++++++++++++-----
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 4676aa8db2f4..55e37ec74591 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -176,12 +176,26 @@ allOf:
       properties:
         "#sound-dai-cells": false
     else:
-      properties:
-        aux-bus: false
-        reg:
-          minItems: 5
-      required:
-        - "#sound-dai-cells"
+      if:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - qcom,sa8775p-dp
+                - qcom,x1e80100-dp
+      then:
+        oneOf:
+          - required:
+              - aux-bus
+          - required:
+              - "#sound-dai-cells"
+      else:
+        properties:
+          aux-bus: false
+          reg:
+            minItems: 5
+        required:
+          - "#sound-dai-cells"
 
 additionalProperties: false
 
-- 
2.39.5


