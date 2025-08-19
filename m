Return-Path: <linux-kernel+bounces-774794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC08B2B796
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BDC4561266
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CDB220F21;
	Tue, 19 Aug 2025 03:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QBKnSicd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AD82512D8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755574444; cv=none; b=DcoTAKdYwBhT0TLaeGxP72HtBcgLZ+cbACvSINpOZ5OHY4yqJGvFB1wOmv/iQt/etYmlGC6FCAwE/HOXyjKlXd8TtakY4AF9bEO260NCpVud70s53lRgqTEGdiUMYUAagoJI2HCleKDmksibWsC287gA7SdGja166L7EhGpER04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755574444; c=relaxed/simple;
	bh=Vcbndb0BitXQXBCCDy5phydPWg7MwP6Brhlf2YVSZNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UsBDy42Ezi295hLnyY5tYwqrwJFPxt7IyFMUG/802VNfOERxZkGe3Ne+QjqPLJAMCeE/2eqLhtos4JSVVxjmDs8jTRrJwm72s9/c3sFvgVUW5OwDxiBnPMclnns7TfDSdMHMJVD2yETRb6EtuWrw+UPv7aBNQz9c3ko992JgF+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QBKnSicd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J1VaOx010617
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0Yg/2s8cwpHYy/pmAzzHeffOyyjabiwQv6sxOo7TaLA=; b=QBKnSicdQ60U/RwN
	rM6ti3M1BzNnCvfb60iv4nHKRyBJOZ6zFdz3gGXKfue0X2x7mBm1deVbpbV9GDF0
	2QQW2+NbvJTGkCsJ1ees8a3yJFgoq+r0rFhwac3NRrDZJDVCTWuX+LQvBRrsfo2L
	WFmN/bNLWs/MZ/P4XP/dwWiA9zL9UMInCRS78jIcz4UvT/3YCy3qv2kqcYyltXqA
	o5/XizvG21twe/cuJxfqlKFYl8oYTV0c6xrxxQzTAPFHjERLCbTE0da08jOdtFTe
	5noXDm3aKwatKwF5l8o3FMCpQuhx4RK31pDU/g+h64b20/CvCoWQb/IvA7n4loY6
	6Jw0Ww==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jk99pyfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:34:02 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2445827ab71so42344205ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755574441; x=1756179241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Yg/2s8cwpHYy/pmAzzHeffOyyjabiwQv6sxOo7TaLA=;
        b=KWeM5dndnKVogLeRaSAz7r+xpXh6yy4inb9eN2LRSd+0a0EghATxS8M9RQ9t7+bO6S
         BNe5u+AYuUGxC9BKs31wMbMcxx2FVR/Yuv+jGcNT3qYr3+3RNR0SzUANA5pu8cEQDvlQ
         V2y1WORq0BoSl2r9ESL816Neq+1zQGY9zTN7FXsH1wv1X9ZVb78EpPLcBnkkYJ4xg5Rv
         vXPWKXze9/jOvUMl5MqXCpZnNN419sm2VEPpqILSq2gtxIjpwTCM0+ev0yD7Y+FmeEmB
         SqlsSoswnoJ4HEuD2WG/ZqlJi3cFcgPGjE0fIHMYdKFEuyL5XUaEmWmzhbKSid732WMQ
         BgYg==
X-Forwarded-Encrypted: i=1; AJvYcCVcgRYzseQezUU7UZkDFJwQ0YK89dFL3pUcDRwbta58OinwpFxkdSPYVKgu3m6AB9hYOti/N41Ijlfuvw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+j3pbjI2Pw+g8waNpHXtV6Amyj+EBZ7EYD6+jEs2TQmgWosqx
	J/lU6IRJnKO0167GJ8rTmkjsUWVwrdf4wL3YMu6f02m4RlCqghZ+jTBEI+RnSwK43ItMqQN9vla
	23+/YvW81A3gVcKRGP7Pjqr8LxSyKpkrw0VWzvgSjSWFWXcivYTDd8iPmLKRo5xmRvOI=
X-Gm-Gg: ASbGncs55ASrDK88QHzy7PvRvzmWH9mnkZo5Aqyib/Cqg006KA8Y8UvZO7naaTy4X3A
	8LOJ3idqJeir5HVKFCjWN1R5UYbu2lkRVta2viRY4mZJY98INoT/52dtanRbHibUpZCaVZvdvUa
	eSWPWKyUeqfjsRb6dFZfzth1cfaFrueb1pHjEeD6fj6vbt7evQ0lkDnD0woM68iY4jN7JDu1Tha
	JoRUEWcd20MevOsRf65OmRn2828Lg0cl+cvwutvBAoIg7ZEb2VJETQPdBxkpki5mjhuhwe5nWt8
	HCqmPYRD8QMZfxmsNuSWsaewFqgwlkti2WMMZY+rlH/ixTEqiOVhDoIKmifFULiVvWohoV8=
X-Received: by 2002:a17:902:da92:b0:242:eb33:96a0 with SMTP id d9443c01a7336-245e0328fc4mr13756445ad.25.1755574441587;
        Mon, 18 Aug 2025 20:34:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrNApVEFRaReBUGFIN+/yStP1nVoxmL/eBm8PHCEFQfNZ6i4GKi9pKkySdHpDkpBiZwAMlig==
X-Received: by 2002:a17:902:da92:b0:242:eb33:96a0 with SMTP id d9443c01a7336-245e0328fc4mr13756125ad.25.1755574441145;
        Mon, 18 Aug 2025 20:34:01 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f55esm94486325ad.82.2025.08.18.20.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 20:34:00 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 11:33:28 +0800
Subject: [PATCH v7 1/6] dt-bindings: display/msm: Document the DPU for
 QCS8300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-qcs8300_mdss-v7-1-49775ef134f4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755574426; l=1231;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=Vcbndb0BitXQXBCCDy5phydPWg7MwP6Brhlf2YVSZNE=;
 b=mUJMxoOSV81o4koxqdJbI5N6soG55O7wbqXD0dzr+1rxU6/SC3oVCKT8159FPywHXQQd8ZJ94
 FWOBhhiXatDCGTTsP7IYgNL+9ROa6RylZU+9nOngybefW6dHuZUr5tm
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Proofpoint-ORIG-GUID: pVpMfx4Z6O8qC11Kc1dPvgVYXx4mXipb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDA0NSBTYWx0ZWRfX47xwvxn0Wr8l
 UcvH3QJiGzakoHPQ+vRvaZOz3EOSUfKYfFq9PEnGnLpwFMLLDtjXUovFQ0w+YKqN+LlMevZtO/P
 QbdDi2469BFYF818dE3mxbfnJi/QElYtnHuGcQEzxHsRQwk9q7LWAAfuWgXUIFY4RIBlJ9iijyy
 D2QZAqW4GBFKaC/U2qzgoYjBz4C/4cXS5T7G+AsG7F2IVJi1+pt6MWrGGca+KFfWy343lQeZG5h
 2uWfr2KxieDOPX4jbAjsx9Wvkgz222T6KSLfgSdaRugD6uTIy4DP2+Tz67rOjts7eIRt0xKssXC
 4PT4EHoljcYYhCCEsxBZ6AqY+RdpJcTpTgabOjWvOUEcP2h6ff+FEW6UTt3018+OUBofibwPIA8
 ab+GYr2k
X-Authority-Analysis: v=2.4 cv=IIMCChvG c=1 sm=1 tr=0 ts=68a3f0aa cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=5ixSZjX4nqodb9qzXsEA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: pVpMfx4Z6O8qC11Kc1dPvgVYXx4mXipb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160045

Document the DPU for Qualcomm QCS8300 platform. It use the same DPU
hardware with SA8775P and reuse it's driver.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml  | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
index 0a46120dd8680371ed031f7773859716f49c3aa1..d9b980a897229860dae76f25bd947405e3910925 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
@@ -13,11 +13,16 @@ $ref: /schemas/display/msm/dpu-common.yaml#
 
 properties:
   compatible:
-    enum:
-      - qcom,sa8775p-dpu
-      - qcom,sm8650-dpu
-      - qcom,sm8750-dpu
-      - qcom,x1e80100-dpu
+    oneOf:
+      - enum:
+          - qcom,sa8775p-dpu
+          - qcom,sm8650-dpu
+          - qcom,sm8750-dpu
+          - qcom,x1e80100-dpu
+      - items:
+          - enum:
+              - qcom,qcs8300-dpu
+          - const: qcom,sa8775p-dpu
 
   reg:
     items:

-- 
2.34.1


