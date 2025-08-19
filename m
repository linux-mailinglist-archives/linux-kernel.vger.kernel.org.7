Return-Path: <linux-kernel+bounces-774795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F40DB2B7A4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84CE43BA30D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AE42D8790;
	Tue, 19 Aug 2025 03:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NXYv47w0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849EA24A07C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755574453; cv=none; b=bc5wGPc6NmwiAKYKFqez/C+cavmInNYEeffyZqPXovNAJe/7+htHRAaQTfecyW3HcJkl38C4guTZCH2TOwedQv4fcIzC4u5Yxt5rtsJ1SPkf3S0/j5sTQUcrv2mXb9Wrz4LDaOQ5gHNCa0wuEe6SJROMl/K+YE33f736PKLWd6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755574453; c=relaxed/simple;
	bh=QnxcyA2I15PFGprmlotWeGRQtMp+i/s/DgtWXJl8lG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z0YCFD/eIIPPiccE6CP6RuEeUTD2TDVQhDFmzwOYnSlFLwv92PC6po6BGqkNP817VtK4QPEGK+et22aVO0J/F5tYVsC9+2MboECeDEMVQUIBx4PLVF6b4MLfJ9cB7FuEP/qssYc2tff+AuzL2p3q+KoM+4xpvMWmYIVdKCYn9+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NXYv47w0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J2eJ5h014629
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	87YUgQQPTRuBrNxZ7K2LEM1CG60UDLM3XWSwUouNtgs=; b=NXYv47w0XLZ0etqn
	U3/ZFoJ6fER9zn/OS/id+PAInwM8cKfUDJAjFlpaHvoH5lSy0KMw4z6tuOp6tSX+
	VVedvKPrQFhU8vL3sn0RgIMCuSsmV4xcYgWuN4snxfloiO5utUydjem9fFLMpybD
	sy75WsyAzN1IQKDMzGs8Ao4qKijBrHSLKsNa0pUkWwg+ZE86crFnMfJCRnGgmnr3
	IUtj4+cP94BTEYJ/RpFJPZ4xFGDR/3SDwDNqSObIMmmUGEbz1fw8N05+ypoLKInG
	IE2zg4ifxSA6/tg9sf5Ap/IBA0FKBVf0Zp6hj4+L1GqfxBc2tBPWBtgxyUyMYsOX
	/8veaw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jh07724a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:34:10 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24456ebed7bso57479385ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755574449; x=1756179249;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87YUgQQPTRuBrNxZ7K2LEM1CG60UDLM3XWSwUouNtgs=;
        b=QVetaiy5pc0LITl4k3l2mBhHmJmz8DtMT94la02VrUeni+jGL9QYjdrIpiNVhIPHab
         VjoXov1vH1Zb7WaTxDk1tVDPUY/6yIU1Yh+H6gg1NLIxIMQUNpKXE+EzFmJeFrWp7caK
         RyWkTBulEbeuZOVs/l2jOLUAgJ8Bd6uiRfCVmBDrukj0AzVtZyPnDrXS5UYIUPmydgu3
         g45CAIC/c9T4617PYO7q6RWA+PMw9eht7vIj+ht4FnTkBmnbRjrXRZtjPjcA2dmkrTGt
         WD7R7j+asCHBvtrIyzH4t2HZsORTZ1wDna1owLkY3p9Mc9QclwjagLxCjZuA6qzvYfVF
         oxHA==
X-Forwarded-Encrypted: i=1; AJvYcCW0Q3+TjBkiSFQtXwyfaGAP9ZV9PmeOi4fLfba9aOuvm4ZMedt0K31BTwtRIv+85ZMwVMifNBNxk+yYRa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHwdGH57jBiojqiVsgQicPIv6awGPLWqkEadf2mGDjy+0weGCB
	xve8XB+gVmVFsASyp/daq9uQx6ylx+55zML44KOb40wKXFDrfgBpdlF3YWIx4cbreqQXdmIj9Kn
	c2ADShgG3oplhXsrxBpKFRcYpsmKUti/7L+jsXO6OX1KFNBUh3+0Vl2tt2sa3gdoZMNigtoE0Z0
	WM3Myh
X-Gm-Gg: ASbGncuKI6QUCKyzc0hTVHjF5GSdpHdmIIXnI5eqDdq5GfiQnHKhkMY9DkgJhAP3PXj
	ApBk+DYLMtHRViIfrSOXaQ0bDFK7dvfq3JhjLXW1fzDIad9OnOh3Qf+xnjc6L2TVtYiO0rFV6Rc
	Bu29/lMUewzfL5fSGXAnDFEwoRDRVo6vvyrVp4j/o7CS0QJc/nLusfKk1ab9wZzANqVnFIJTfwH
	Dod6WmB+8KgDN66h+dKyMmIiz8fSNdehnXg4/JvVAS3iwxbHCivrhYQ0o66vGRq3N7VE6JFBU5/
	MSSfIxUFJnPhaX+rUb1UdcrpSZe+MqeZrO6GWlY1hKuA3FoLelusDFwV6uMfOollpg+bs/I=
X-Received: by 2002:a17:903:11d1:b0:240:86b2:ae9c with SMTP id d9443c01a7336-245e0eb9d4cmr9920375ad.14.1755574448406;
        Mon, 18 Aug 2025 20:34:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWhwpVUkX2ye/OZpyid0P3l7BJisssSc43x34vQBSucCRnkmKAQZ+uiuAr4SwQWZXnctibyg==
X-Received: by 2002:a17:903:11d1:b0:240:86b2:ae9c with SMTP id d9443c01a7336-245e0eb9d4cmr9919825ad.14.1755574447890;
        Mon, 18 Aug 2025 20:34:07 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f55esm94486325ad.82.2025.08.18.20.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 20:34:07 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 11:33:29 +0800
Subject: [PATCH v7 2/6] dt-bindings: display/msm: dp-controller: document
 QCS8300 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-qcs8300_mdss-v7-2-49775ef134f4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755574426; l=1832;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=QnxcyA2I15PFGprmlotWeGRQtMp+i/s/DgtWXJl8lG4=;
 b=HqEhByeRXqiHzIa4ch2zSFoAWOuFImPKR7WmRzmAehg4nt/3hs/awQcKGG7d9aj/sMJR/gbjm
 N9IwfWrKqJpCn8AZWObN8dz9LM1V1Dk8gNhn6PcK0ozQwuge62KbNR5
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Proofpoint-ORIG-GUID: xyDTUSUM6H7RgBaJMt6TD3yx_rY7qx65
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMCBTYWx0ZWRfXwGMzwVaHJs5N
 sWm2WSmVXyMNZnlsGtMdNEaMN9ISE4eExRNMVrVQu5p276CegErPA6xCRJ+KtKGGCh6yAT2dLK8
 gzd3wFVnUtMXcEHpA6DmUaNlG7zOBnlmk7B+gADizKGYNLQFdIgS6LqGBTb9ji1IjGlM6Zi8F6C
 UefXhXZODV6bbjIwempN/AfWqjEOov2u9+C5MA3rkSd7XcX4oA2ebJoCf5J+fbwhqlCbfyCgZ9B
 q772aPhfC1pugK6GAa7LIAK+1MPd+4XiWKYkK/pJ3N9jTIIasJ4v9bwGzVtsEGqCmQvJCgzNShA
 PH8LHNUMukYMCFetCYDwgMEEJdTDLieHlsg6ydYPIN/23JxRUd8AdnMXKy8vq1tD4xKuax5e+l4
 ETXwFxtn
X-Authority-Analysis: v=2.4 cv=a+Mw9VSF c=1 sm=1 tr=0 ts=68a3f0b2 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=TDvFBFFeHOCVSu0WV4EA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: xyDTUSUM6H7RgBaJMt6TD3yx_rY7qx65
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160020

Add compatible string for the DisplayPort controller found on the
Qualcomm QCS8300 SoC.

The Qualcomm QCS8300 platform comes with one DisplayPort controller
with same base offset as SM8650. But it requires new compatible string
because QCS8300 controller supports 4 MST streams. 4 MST streams will
be enabled as part of MST feature support. Currently, using SM8650 as
fallback to enable SST on QCS8300.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 68a6fd27506fda004e53174db5bcc88a29e8d2a6..ac44abfdd2853393ae199387c9ae2c37e1c48f52 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - qcom,qcs8300-dp
           - qcom,sa8775p-dp
           - qcom,sc7180-dp
           - qcom,sc7280-dp
@@ -179,6 +180,7 @@ allOf:
           compatible:
             contains:
               enum:
+                - qcom,qcs8300-dp
                 - qcom,sa8775p-dp
                 - qcom,x1e80100-dp
       then:
@@ -217,8 +219,9 @@ allOf:
           compatible:
             contains:
               enum:
-                # some of SA8775P DP controllers support 4 streams MST,
+                # SA8775P DP0 and QCS8300 DP controllers support 4 streams MST,
                 # others just 2 streams MST
+                - qcom,qcs8300-dp
                 - qcom,sa8775p-dp
       then:
         properties:

-- 
2.34.1


