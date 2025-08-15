Return-Path: <linux-kernel+bounces-771027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87619B281E3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A877AA4FC3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488A425A343;
	Fri, 15 Aug 2025 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bPOu+Iiw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A384A233D85
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268242; cv=none; b=CNJD1ZBMDhPKqXFuBUuRON2ugejfLh01ZUYnRlhuEAQ0jmIEAGcmylC+12HSbJhoeQ/jWvSvLKDMdRWGmmgWnHjk0D1RFEQbaTbLI58GkKTyvfDrR2yYtzX47U0eEP3LEr6zkHfLmusd6IHwwHL+vbxGOzeR/n7RBXjgCn8yMBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268242; c=relaxed/simple;
	bh=Mg8cF8dtHa8FBVVXmu7mhjOEv6I2lafX52Q7aTfQdic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CJbHgEkX2rGPnfATSE5O3oGdmoDEyecJ1AwGeu1bTLcUPcymhWY3Nk+0Nbjyv1K1kerP6abl0NetRyORnt/FbibmkSQJraC5RGpMMFyQSvt5oisdUwkHRaYI/Wvow9Y1bHzvSXuNk0I87qkcNCxK/p3mVhO/AoY6zuvujdwuOcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bPOu+Iiw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FEIkKW019986
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7m1HwxzI8G7RL+o2tt5C5+jDIvVaSDVT2O8wP58iCTY=; b=bPOu+IiwDjR9ymdP
	FCWKD8+hJeyFmM9yhn7JopBQPmbzuGNIw/ntcZrnpqVTbdcOvwHdRvU33iJO+D8U
	EnUBL3UqKG7Jg21avuVTdbFv7TSq+P29tfXwSFFXli7zWXmYkiuyfAVlB6vTtP3v
	+0oUohe9Y65RQ0aoHW6O8fE4RYB8/ubrTnFHsVGTQZsROip2nFARPa65WcQaz+i+
	8gC6vKQ+wA1lJ7wRxZ5NAp6+WkBtHQyBPavdhszVhLxXEA8aXOoda1rNSlBftpsE
	Mlqi41x0231Rr91JXaGk2iH/xlMIx/nDhISvRvpdAolDTWZwuvCsktk3PvADtNmi
	5rxtqQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3gk649-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:30:39 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-709e709adfbso72436736d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755268238; x=1755873038;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7m1HwxzI8G7RL+o2tt5C5+jDIvVaSDVT2O8wP58iCTY=;
        b=GCooyuhNsD7q7bpjV2ivB5zejbgh1Rp+eDB0PKZepwZUMVfrI6IMc9CaF1WkklwXd9
         6+EFn/sApRlffbRg2OORBg+DgWFLepgGtSNQkm81p6n/sTGHhEUfJzcVzjnpbqYtjtV+
         lU1KMepUY7sB1Ai+kkaJXTbeLwy/O4EqWygJnv49NuctpPBzymE5mBuuZ9Yi+jVS8En7
         DmkRofoFR/+jLW2CNVLm0Jvjc/WFfFgXONlNpOU5rHiAB3ss+390lPeEPiLTTB0vvJa/
         49OrkT4shChQuBuOwtrF8+Ce78F12LvTpvUEBtQAvxXxq60RQZydH4vkyV0NGyw1pQzi
         4QFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC38P/TOaUX5efUgafMA/shWE9gZc4kY3tjBQSS/3wJUQt/281r7edJNQfJ1iyeM6BoiStrDetp+ZbokY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMYu7ZuADk0yg7O3jCE2ZOm2T1k8LAik1fHScyit4CM6H0lKxZ
	Wy5B59wHOMK9zfbt+B8ujXN1CvAPp5WTkGwF5B75BOdB6qXphAVO6QCC1qv90SCbHQRaf8AliZT
	hLKBHdUu8UitNPs0gklPVnPIlTDpMh6behC77wpFnD53foSNyiaoV2g05ShFaA7wshpU=
X-Gm-Gg: ASbGncs8SctCHGulQnpnsVvP+iTPb50KxTrwCxhfaBUirnOIF2EvuQGXYtjunugSc5P
	uwOIDPntKHcCBlGNmgnShFJ/NiRAuJ9fG/LLE0OQDzD5DYGoHRmuZvrE4O6WguzgG6GznzQdA9v
	tQOmznbmBy1liWIE/fzqFYjJwX7gcMlHQel/5WkjrAo+nVGQuRmruEnp/8Zl6HbG1q/0BmkIO1D
	uDRTTDz782hWTraNbtPgcUc3in7EE965CwOqSxXB3JSCLp9q8Dniqu4ex2dEGem/1Dy8/YTwQfS
	MLC6iu3FdTfLRgGN1D8sBov9RHs7p+rI+6dceaKr0mnE7zrpiBh6rRqOOIasd8SyKWU/BCgJciA
	nBKAw9zw1B8k4bpKxoiBvEq0Wewp1dxnvDv7hs7SpztZiFgLdcDna
X-Received: by 2002:a05:6214:500a:b0:707:6409:d001 with SMTP id 6a1803df08f44-70b97e3bb48mr87498626d6.21.1755268238380;
        Fri, 15 Aug 2025 07:30:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8ovjWbOs+92uJ739mohecs8VJyDODcJr3savSKli3vBqXpsZ7ifXXVkzwoE/LbA7woPJTKA==
X-Received: by 2002:a05:6214:500a:b0:707:6409:d001 with SMTP id 6a1803df08f44-70b97e3bb48mr87497976d6.21.1755268237808;
        Fri, 15 Aug 2025 07:30:37 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3f358bsm305661e87.110.2025.08.15.07.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 07:30:36 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 17:30:28 +0300
Subject: [PATCH v6 1/6] dt-bindings: display/msm: dp-controller: allow eDP
 for SA8775P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-dp_mst_bindings-v6-1-e715bbbb5386@oss.qualcomm.com>
References: <20250815-dp_mst_bindings-v6-0-e715bbbb5386@oss.qualcomm.com>
In-Reply-To: <20250815-dp_mst_bindings-v6-0-e715bbbb5386@oss.qualcomm.com>
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
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBon0SHXLVyiyAWAnY+ykHy2ruSRC8nKRZgnP/Bn
 xINi6OKiNKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaJ9EhwAKCRCLPIo+Aiko
 1etFB/4oS7mGdVAc837H48kHj1jUJBhQYGWrSf1sRZ/FqGtBZdkV/0jyuAAoP2duffnj+icLPyl
 2cjqsaEIA+4jfjhEfIw2ZWPXdfrMUPu+vG0TNsohOGDIqFuT6NcSt5CX0sES+CZTig9vE+1AqlC
 SSo+BAHxWcXSxA2l2qhQtL+5g12gn199onkgcpBhUbVKIng9zMMkXwWgYqjXO6WFazboZ+xL3U8
 p/RzfBIlbZVh1npczR4Gc6udiMtTKIrcKHjbGy+S7UHf+UyqT0c13hVw0Gw4clDnvX4Vc8Itxoe
 3Mlwe1IUQDGFmbDtvqHg8r8VNR2ViQlQu23rwrDpPEYDIlP5
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=689f448f cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=iBDq5nSyD7x731avtJAA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfX/UdzMe1RaCR3
 26eIb98WmuET8R8bqG+ctUbEKpRD2HvPUDwqrID1PekF9LrNhfvVHfawHMdTOC9acMGvqk3cN3o
 K5aRZAPuJftIinmGBr9MSd8onPkehSc0vGUNsbsqK52yMVmnuJ4F8pz6kEEAl78SzbvbCmD/mZT
 NvaRd0GmPBpea/Wp1Wp6SI08vLd1w2usxG6yRLsqwn2OLPj+/p36rSJZT166XK42gUPXmF2uabq
 kPMidVaDX609EEp6ilWUvtFGuZdDAz7kwjE3AXa8j/1voMP4+/1AVq+eNORK8RB9jT8O4O2qMiG
 UAnDt4FD+hIcthFCb2zSfE+L6+z8WwpNJCEGcmIT0zYpY6YWLKkXR9k4v9NO31DFZU00vj2CZAN
 8OtFrYDO
X-Proofpoint-GUID: gjf07X6nbUG_4ANnrl3SfqSQrXtwcJnC
X-Proofpoint-ORIG-GUID: gjf07X6nbUG_4ANnrl3SfqSQrXtwcJnC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031

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


