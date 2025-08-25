Return-Path: <linux-kernel+bounces-783956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D9DB334B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 05:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B17817F91A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 03:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259B8277C8D;
	Mon, 25 Aug 2025 03:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fh4KurSO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14E525C80D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756092952; cv=none; b=kJNuvBN2spTIEs/tIToKVwUY+JJW78/SpLFGaGPaJ82lUOKQFpk96eLOgmAWVRSTxlSs2bfCIGzJB+A3TS+N/wDPbRdChUMa0oPpdvhtloulmPz6Yqp0k52G44JUwgpl0mOguFSfr/91aFVriAgYnNv51mARx+UILm1wv2WKH50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756092952; c=relaxed/simple;
	bh=LBoCkIOz1nhLErv2TZjqow4lrif4gDacFutX3m6t01o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bC3w51LEV0KLkxjj4r/kR5/Y3CflVJaku9rod+SyqWMTC0r/iuwa/55GlwLXnq8E+A2KwU8FYesQ/stjjU+iY34i2Kts1CKjxeDO3EJ2a5qrGG8+Xm92blrGyF2UK1hWVNCWLVHEDA+TGSFaH+sZmRsSPg8qj0MiCnye0Rqf5tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fh4KurSO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57OMcfF6008052
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OZg83hCdtMCdsj3A6OZC0JX1BgccRkDWTc/mnL5LnSI=; b=Fh4KurSODOa3EQrt
	dHbbZmlijp7FN0kX/upao1z7v1quR30bPGFp+oiG1YbqE5SuyKpIZ0Efk+P5gTau
	zZvujRbFFZ3OBhtthckrPwCss2dIFCe7QmIvhXK3FZ5tL71H6JBGp67LEMJcYvnq
	ekRaf3k4ASBuHfbro975Q6cMFVclN84dLq9qK5gi2bACmHIorBh0EnQm9QhnpKmH
	fK8J3IeMIkP5xeSNl0A7oGshoeQKV8+fMD0aRzndLfqzYfStGxpAE+n2gT6FfLtW
	XLJiUJGekz+ydyae2s9wppZpMNUIF9PvT/25PnmtEVXK/Zs1vTYJSw1PI9ljuFlY
	k/FMoA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5w2kmpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:35:50 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-246a8d8a091so23354145ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 20:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756092949; x=1756697749;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZg83hCdtMCdsj3A6OZC0JX1BgccRkDWTc/mnL5LnSI=;
        b=CgJPgfo2w9Ezq8Ar/cAX84PPL2j9kFk7gB6A3Eq/YKAuxYAQOlsyVVhq+6tw32WqrI
         5HGuMTlD7srdVfpiorBvNjiLoGr7HcOuTUV0lIbNElTPpa8ub6HMj52GiTzO7F/SRJKB
         JiSDGyS6j+2SE6/p9+DCIhB1KNMuVTQpn70mvhaWCZLQbxRJgLXAh1g0l0G9ly6uh+uM
         g12vEDLmjRPF3F8o5pkqmQehByGU3OtmYmtHqLXbK1+mOtYqMa4UFWHdBVoOdKpA/ddK
         qznTh4uF+DHA/hBoy+kAc1qoxvgHYCZV3kowJnyqgsV6xR92jsMTj/cGwSgm+SXVBZQ2
         aNsg==
X-Forwarded-Encrypted: i=1; AJvYcCWKjO5NSwsTJI4K5st62qjwVxoYdw7WWgcIFjMrA3rK4viG4FN2/3MnX3o++3TPBQr+IHEnmyZLs1DVaw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6WLiZjv6+F6gc9p6MVn/zRrcPMk5ZByhVTWRB3/QcM1LNhgLq
	1JloLgBFOZ1zYtFSui8HJRoPVBRN8pGDKR5HAymI75HkiLTcUFgsRPvZs/JhCzvfCPycWskCdLo
	58wIT1YnVnzKzTubL5kjrAN/2P4SL7IIYPXeEnqMs1ltemrTUNkHqqjlRhmjWOyZNn8A=
X-Gm-Gg: ASbGncsugl3lYgm0RL+JPiXy845nO3Sa87t83oicUe5a58FNbMnGWx7wZJbqWSAINh5
	TZgXLcmy1ZndisrRQTz23eiP9nXBGHueV6CZgE2AInsznklJYe3XBBxODucbZCrR/62LrLgIZM7
	tPDQDkHhuZ/xt5FMshCsdWV8+9RChLAwlb9rTwkZpAYIiXaprqn3y/cLAlMpkt3G7Tf1RxsYcNm
	hh7WWLSr1ET5CT2jf8mQzGYAkszC8QKa2bNeCHuwFLr1nIleB9Ny0Bp15wNNyNTIHt7xBA/GCFk
	ilUR9U+0Bc2Hqqzf/787fFoffB6as2jwzNcE3/JKgY5IGx5yvh4rPG2TXn/ls8RZFuMsm/I=
X-Received: by 2002:a17:902:e847:b0:246:e621:96f2 with SMTP id d9443c01a7336-246e621a7f1mr14024095ad.31.1756092948805;
        Sun, 24 Aug 2025 20:35:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAwYYh6f6erS5AzdwM3CnzPO5hhkgBPJrkBabrpVRyKaCiZvK90nuAoQsSrtjRliZmm1vy1g==
X-Received: by 2002:a17:902:e847:b0:246:e621:96f2 with SMTP id d9443c01a7336-246e621a7f1mr14023855ad.31.1756092948375;
        Sun, 24 Aug 2025 20:35:48 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466877c707sm54859565ad.22.2025.08.24.20.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 20:35:48 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 11:34:21 +0800
Subject: [PATCH v9 2/6] dt-bindings: display/msm: dp-controller: document
 QCS8300 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-qcs8300_mdss-v9-2-ebda1de80ca0@oss.qualcomm.com>
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
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756092926; l=2062;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=LBoCkIOz1nhLErv2TZjqow4lrif4gDacFutX3m6t01o=;
 b=Y+yHBkF6j80VW9ppElFvbvtjnk+nZ8Ffhpo8+67cKLzsDwk48Y5mh2s5hr8gMEoFRRIrPcw8u
 +7JcJitAwSyDuIAeqQZXYBlerGqmU+wJBEBKq3NyyCb6aTQPzN/Axvj
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Authority-Analysis: v=2.4 cv=Z/vsHGRA c=1 sm=1 tr=0 ts=68abda16 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=eRoelbRBQ5ypv8gDxK4A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX77r7b7kGhaFx
 UqDg+WhZbo+xraxwaMWHWWTI6qNAdjEFboAWhfmnaSyKods/8zCLVZzdDUs+B4Eg0Og8bg2L1rz
 4s+ICB0fQyiDo6SmX6sfmJfnSP/TP/ZMyNJ1atU6DdHal27nxoyqQ4GLpXg0nTklCvFby7eN3OR
 VhmURLIEvcnSAENpuxqJGW+M1heqErR3WPLB5+Um7+x8y1IgCwDfcRO8WUvUj0jIWYDzWFpm70U
 rM1Ata78pT1wVmcFJRozfHsfQoNApE7E++CNj3IDNj8m001aFzygRm8ToyZnhbUFdeiOZ4ArENw
 Jy0VWZ/1NRXkJ1R3uROHCHqWPfwVRrJD0BISqUVn1ujbo293R/LqIZtDb8FOIctWE+b7SjOohiZ
 MJn4ZeYm
X-Proofpoint-GUID: NysFRw1CpdOEYRR1v9o5K8YQ7djT6Goo
X-Proofpoint-ORIG-GUID: NysFRw1CpdOEYRR1v9o5K8YQ7djT6Goo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

Add compatible string for the DisplayPort controller found on the
Qualcomm QCS8300 SoC.

The Qualcomm QCS8300 platform comes with one DisplayPort controller
that supports 4 MST streams.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 .../bindings/display/msm/dp-controller.yaml        | 26 +++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 68a6fd27506fda004e53174db5bcc88a29e8d2a6..4da22a211442b7abe2dc18e769d8fd14d224eb40 100644
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
@@ -241,11 +243,25 @@ allOf:
               minItems: 5
               maxItems: 6
         else:
-          # Default to 2 streams MST
-          properties:
-            clocks:
-              minItems: 6
-              maxItems: 6
+          if:
+            properties:
+              compatible:
+                contains:
+                  enum:
+                    # QCS8300 only has one DP controller that supports 4
+                    # streams MST.
+                    - qcom,qcs8300-dp
+          then:
+            properties:
+              clocks:
+                minItems: 8
+                maxItems: 8
+          else:
+            # Default to 2 streams MST
+            properties:
+              clocks:
+                minItems: 6
+                maxItems: 6
 
 
 additionalProperties: false

-- 
2.34.1


