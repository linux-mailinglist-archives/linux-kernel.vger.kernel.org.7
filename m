Return-Path: <linux-kernel+bounces-798435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8625EB41DF6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5229D17FC2F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83E82FD1B5;
	Wed,  3 Sep 2025 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EQLw1s6V"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B650D2FCBEB
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900706; cv=none; b=YXoHxDsGevLf7gLxQD5kQEQRA7ccZyYaQhmGbTm132SFV1UW1qHlq1pL0gKdR9YM0Qd96ZzuxgEm7WKmWRJdn1FI7nJcp+LIpMxwcqxoE38WXdz3Gq2Cp+eXJUKFfKUaKkcuofJv/YVTqHPWg9Vi5h2E6pCZQDyR5+J2vTc8xVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900706; c=relaxed/simple;
	bh=Mg8cF8dtHa8FBVVXmu7mhjOEv6I2lafX52Q7aTfQdic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nroKkH+PzoNvPm4de8KXqZLDXK8WCNl1fFPCAmP9HPZr8JtzcdBYy3SHH6rGHUaecqLVaQ422MrvXYot0gMHFhSJb8nnH5FbGGvu/sSj9C3BiciQcGxIdmaOWfeGnacd6tx+0Rxbea+dkb9EAakXHrmY8szLK+0VVQaXnuWD7F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EQLw1s6V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BEqBL013914
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 11:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7m1HwxzI8G7RL+o2tt5C5+jDIvVaSDVT2O8wP58iCTY=; b=EQLw1s6Vwpk5KUvn
	5mZpuQBSCeTg5U8GFQ+9ZgzJWEGiCA20lsbVlPYYRjkrX+FI7mE8sJxxpVb2D25e
	Il7Z34ZyKv9EjK6ql9sU0nUj6hc0v24sbSduEET7DAlgsGBNTe4j7Xsr9UFTKs77
	xfNZJkFuf9rFvD6alQn5blSKbhUtClMf4QcXhIzYMglXYLuL3N0SjT334Dpb5IFx
	aG4tD1KoUouTCmzYteSayI4R5U+NLTKyQJgXixUlscJNEReZyhVKXt3mpGv3Kaht
	H20pT9yd3VjSA5sC5UEUVoSILHg1eHFgAd8Ub51Lmlory96VHhRbT8A8LzpT8Ae3
	GjQG6g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy7dx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 11:58:23 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70dfd87a495so116737936d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900703; x=1757505503;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7m1HwxzI8G7RL+o2tt5C5+jDIvVaSDVT2O8wP58iCTY=;
        b=DMfeaofDZgp5V5q9GOnaAfuUIfc5fllv/s0gziGHO4tnVa9g7a7A8jnD+6J8aTjKYs
         20DKZSUFD1hJGu3udGS6QlDrUWq79yAFZ1D2FB5OcUct6SygM9BLcNRIKjuqruOGgy1B
         Gp7XGdYYF2YV85zfLRQj6yXDwduFNAe4kpdPOqrZqEOyJ/jv1ZAffOdwwp2/OsD+Nsmw
         5zSb12WihVIin9lptKoOFqA6okMv04xjOMWYzJeCe0+WpselppcKvkoMd3GGjIlRBQA0
         OxjLoqBC6VKu6XT9DxCMCjvV2EDqVPUzjutXvuxoMC5rQbiykPv3xpPDBWhyReMNdXdK
         bQWg==
X-Forwarded-Encrypted: i=1; AJvYcCX5Z1yeXgq8B9a6PEn8MUrViaM+rPVjBG/+kf2iso+Ke1TEp9hUhKGqJwewTdKA6Ic2PwglXcl4LZVo//U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlEMNcaQ90WGGKA0ENsMvPTzCNN99ReKGKDWhB3RycZ6qYQwZ7
	DCaqIzJnu+9E9sSDBH97NSDzLFATHO0TykzA3gXz2mor2P2aLXOV/cSGeb1xL/Iz23GZ52TFmxO
	T/Q+A6fHSS/s5EVGgVV/MEKFvKnuI3p66DNAufmgGvr4b0ZI/3m4xy6qDZlC17U1QOUY=
X-Gm-Gg: ASbGnctvMPLvNFBavj/Z/78tvB7TaFtk/GA9ey2KQBnVkmThSBtRW5aVGYKU9Iyo6pH
	RKHeRBSjjG7RhMNdgBIHyB5ReIpn/KN/5z1JWeCIYTeuScLdmprxn5aVxAQInGXzwZ22RXRCdTA
	2LncaEyqFezc5Iv78oFIrQZC480o6wKoFm9E262Z9maix9RtaY9qCgeGFTOer/hpnG1SrSo/a32
	FcJauEyAASgY08Wy8YEnB2H5FHTbUy3b/oTJkUdf2LZ4Q6N8kLnavbO69pJFLgrIQky84AyPUw+
	07V0oYZL0CSwQ/qgn04yhgxeydq1AYrD62OCF8hJy/e0NRJDc8rFlXlELPK9db/FP4BCObCz747
	OeyDaeT6HPlWu08IwitlmBM6bMC1SNYdzAeVhP77C6DNaiksIvCEY
X-Received: by 2002:a05:6214:234c:b0:70d:c901:64fe with SMTP id 6a1803df08f44-70fac883ce1mr176720486d6.41.1756900702738;
        Wed, 03 Sep 2025 04:58:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj9hZcrJ+8S42PCt+RrOt1ShsvO+BYl52eMjU0T3wyJA35RFJjzM/AJCRPGUZH3504p2FyKQ==
X-Received: by 2002:a05:6214:234c:b0:70d:c901:64fe with SMTP id 6a1803df08f44-70fac883ce1mr176720126d6.41.1756900702249;
        Wed, 03 Sep 2025 04:58:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f50d30b0sm9891421fa.67.2025.09.03.04.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:58:20 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 14:58:12 +0300
Subject: [PATCH v8 1/9] dt-bindings: display/msm: dp-controller: allow eDP
 for SA8775P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-dp_mst_bindings-v8-1-7526f0311eaa@oss.qualcomm.com>
References: <20250903-dp_mst_bindings-v8-0-7526f0311eaa@oss.qualcomm.com>
In-Reply-To: <20250903-dp_mst_bindings-v8-0-7526f0311eaa@oss.qualcomm.com>
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
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>, Mahadevan <quic_mahap@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1543;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Mg8cF8dtHa8FBVVXmu7mhjOEv6I2lafX52Q7aTfQdic=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBouC1W1p9ibzzCWoQUIQX0KfzGSz/kKXFwqoffX
 NJj3hOGz9mJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaLgtVgAKCRCLPIo+Aiko
 1XT3CACu1B8wHPkuKcAXGFd3QruC31bXNY0THTielGdmOfrW1fAonzUr3Uu2fYxVH5s7ghwg9k8
 68pHE89tztuW4b4bNgWVshbnNrINXf70tUF0y70xHDMIJ6b+EHPogOndk3qAcJUholeTSK9swx7
 PS0bFEobZk+VbXsh0QiVlHl5RZRmoSflDwsGA88Vs580Cch8RFs+b1d52zmEYfEbrB9siCkWGu6
 wRWaOfCtn/+iTtNQIvEdvLazeBoi5MsCrAu1KAgKEmvSuV3ObzYNpprUKesg1vr1uW49Fhj2U2L
 YLQv8p0o35kFJsMsvDISYVh8N1pcKQuVXLc6KYInBJ9Km+g7
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b82d5f cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=iBDq5nSyD7x731avtJAA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: uk7Kzbfb_6_xe7ctYxHwIY0TUtsOKuot
X-Proofpoint-ORIG-GUID: uk7Kzbfb_6_xe7ctYxHwIY0TUtsOKuot
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX3on2Jg50jG1H
 YTeft3XofistNT3y2ZDNqdTDHkraiuTjXi2R6Y1BiuOfyB3ZPlg+1YEdIEAYKxGRT5dGJGNHd/Z
 Jc2/kCCje/0+OzymJC96JPeyyPs/9L1tReQUXfDCY+55PzhdqmbQ7xxYna0hS5C0Eq3ab2yuJ+Q
 6SIzM7YGq+miWf+JSmb7kshkkNfqNpQPiPMrOqWXfOfbm/lOK9SPpMHsGZ6sBERnvvn6QgJzlKl
 vWRr5KZ9HwPFqrShtyZeBdeibG01h2AOVu1BeF5Em9/ReaE4KzmQfzkUQYNvLUmToJSS2FxV9Q4
 CZAFopVazrcPPhd6rjkmsjprdeAJsifzlo2bdwjJKSv9tRZbinw9mdsAiBFLteFYmUjd19vdFHJ
 nod1S9uP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101

On Qualcomm SA8775P the DP controller might be driving either a
DisplayPort or a eDP sink (depending on the PHY that is tied to the
controller). Reflect that in the schema.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../bindings/display/msm/dp-controller.yaml        | 25 ++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 9923b065323bbab99de5079b674a0317f3074373..aed3bafa67e3c24d2a876acd29660378b367603a 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -174,12 +174,25 @@ allOf:
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
2.47.2


