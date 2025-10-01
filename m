Return-Path: <linux-kernel+bounces-839567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D10BB1EAF
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 00:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21661892B56
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 22:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95473312805;
	Wed,  1 Oct 2025 22:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hj4ciPud"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0B3280CC8
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 22:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759356343; cv=none; b=GbT0paMnaZwAXhfJFG1ZwTgeYIj9d/tyyfEGL3ovBX22lyky2YTTvQopdKQIG9fZYZ/H0y1FwVHGDdP5hSyU2Kf6H7g4K1WXVzQA3ArmtQs+bE3pG3YBK+0cb2D4ICPoAe3opWOPb0hUVg7f8qkxCpZQ20QDpohnICPSUg5maoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759356343; c=relaxed/simple;
	bh=MCbqnX73P4uJn/n4jiAlTVZO9e/LGJ1yW50aiT4ZX9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EFssuzuBWmFBNPbvNvGm9qEY9STU18U1J4ME2XZVlfzmh3yTdkZSeeQJJkPg03TBk1E/a1oKxKxRr72F5oLJARjecofYCGRhm2HSE9pLqQppq5CyW01o35R0MTqjshE1rBlAu/Gs/m6U+HG7xbvInraVrAJclWC3b37nzTT4mzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hj4ciPud; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591Icn7O006667
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 22:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=YYQJM1FZM3o
	3DDgyVmJ5oX4Xtvn4+xxewRNc42qivew=; b=hj4ciPudSQPTU+U1pI5THoE1fAN
	0Fc3bwT1gTOt3MkyH6+BVYF+ABdncobayX/s5qw6WDfRtpJx76XsqkVgZOxP/PB/
	3pZRr6YfOiy2Xtn/Q5jkGEmL1jfE1uryTv7JUMJ3Byc+S6DUZu6gpiZzzFpakjFS
	3YITEzDydigo3lz9IpMeexwko8f7p5jMBfIfIAN0GQ6SYMQW6oKjTdIIlipG3/ze
	jtz8mWQqYIeAiOJyAaGLWwzZQjC4zZHOjOQXx29uSOfEaySQsD7O/l5+mrZ+orh4
	AZ+GQX9NWSusmaWdV2rC3Mx9YbaW+ZQlMd1TVD8XZS09dKJOmLeNT+KODWg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8pdnrgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 22:05:41 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32eb18b5500so525896a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 15:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759356340; x=1759961140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYQJM1FZM3o3DDgyVmJ5oX4Xtvn4+xxewRNc42qivew=;
        b=bDEZuIuSOg49JUDBaBYbeUEaGZ3rSJr1gmRF2EjaA2S1GdOZTGyuPTNAja1O29LnWd
         dWCDDrmxU/VnEuXG/5hIgfKTVgQumVX6ezfm9vEygOnj555hAv/yu35C8an8xpc4DMdG
         Hs65ay8ta+Yk8JVGABneAOVt6ODLK2D/df3R1lwbgXz3PvJI8n9f5laSTEUQ7cO8u+Y1
         Yp5g6EKLlxkf4/8oAOrzFPuGdMDu99IKTN0qT7p/rl7Z4Xm/fiPl9Pp2cm/rlMJU6I5n
         GjshJerL//rHuZ8BI8v2S/ucMh1ts9yfOnd8AwkKYIFsZpTXCQKujZNhF5vU11ZEQa4N
         nYow==
X-Forwarded-Encrypted: i=1; AJvYcCWJ9+hAefURz21UBGyYcRPrSIf5L0i5weprVxm4YaPDQ/3JULr0liBkT9BEejeiB2LfJpAvbE7hKEWouOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSuIrxFk4dVoSueYHm1bDLTJchm8P9vZdzaQMlIxKpGRKHTxFa
	Py+1P1ENDsOpr+RCcs/Y/wtVCwNcaWeqLPFS8az+ACCcSiVnOQKb72Jjn0tZXRdBx3V7OUaYkqR
	0eNzLLF5EHSoIjStBRazaOY6g+cH5P+XjCxVhh+gG+aNbmNJKj8yzvUXPlYIAwlnd1NLX4FF+Mb
	4=
X-Gm-Gg: ASbGncvAw3xJ4hTUeV/WqOj8PPj1mixCxpq2XipJm730wCLuLM/F6sorKO0s2k3sHPL
	iE5vBg2K1Q+yRQSHTMd8zEpf/nOWnFgEVKv0f/HgVKkDNq1QHKV/slVamm46WQg13VtBKQtsgkh
	6DZCnm0kqsC7hcjGhdARorXnlZVqyPE6b9WYP6Hd/7Oe0nCoz/xk50BYtNBr3r09sJ2ySOMkafD
	PvHcYokZXFOenedgHqwV2OAqXtOy7On1VZKQG+WR4ARbIqNgCYOv2LDfDtfQpRukqF3B8ZOWlZt
	SFBDS2ywPVgJbohPSJfDMb1EjXVPXcyb/n7OP61PJqTFp919bUY3oUIFrk1868ZCZy3loVXsRtE
	BOGXDLHcybU1wzfnq0Uj7tg==
X-Received: by 2002:a17:90b:1b0d:b0:335:28ee:eeaf with SMTP id 98e67ed59e1d1-339a6f6b08dmr6125778a91.29.1759356340440;
        Wed, 01 Oct 2025 15:05:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnpFbmIm/22XzKrvgj3DpJIIWDvuNtoI8e9ISV9nBUIC51KNVUubMK51OjfPXVbhfl8vYXjw==
X-Received: by 2002:a17:90b:1b0d:b0:335:28ee:eeaf with SMTP id 98e67ed59e1d1-339a6f6b08dmr6125752a91.29.1759356340029;
        Wed, 01 Oct 2025 15:05:40 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339b4ea3c3dsm702085a91.5.2025.10.01.15.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 15:05:39 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, konrad.dybcio@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, kishon@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH v4 02/10] dt-bindings: phy: qcom,qmp-usb: Add Glymur USB UNI PHY compatible
Date: Wed,  1 Oct 2025 15:05:26 -0700
Message-Id: <20251001220534.3166401-3-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001220534.3166401-1-wesley.cheng@oss.qualcomm.com>
References: <20251001220534.3166401-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Qf5dMgTZvDAkgkHcPuxEEZjJy4rupz3V
X-Authority-Analysis: v=2.4 cv=MYZhep/f c=1 sm=1 tr=0 ts=68dda5b5 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=e4LYGitkWRZSOGXTHbEA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: Qf5dMgTZvDAkgkHcPuxEEZjJy4rupz3V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzNiBTYWx0ZWRfX8Tzic2qo8U48
 X1OZ0Xl8qvgDE5C7hn/mCo79YvM1p1jd5Uudr8+1hIzOieEn1s73IPMl8RkDcqSZezlLwN1kwQy
 Oy0vdkLcRoB2+MfB8nAaf5MjTtYtm/Mt4zPdKXL0eEWroATPGOCJTnQDsyPdFCgiyHl88cC1uqY
 m5lvuS7G82T8Mf06ncf/Zh2aOIAMIJZmooFtKv1wYOAyOL6Ai+mEhG4L0L5fqo7M1PjXnJzdU7+
 RSlVnARf6Gz7Y+oV/E1U5B+DzzQXNBrAwVxV7zXtoi8CFVlZjjPlUu8uKmcsDLIE0JVgkR6M7rr
 e0jHpxj5C1f9MOnh3dnomi9t7VWakzQqJ1BrUeCwRc1ZRP5463JQydOPAOfRyRGvGFn3KdyLWlj
 HWdk/9IRCiyLSAf0R/EO4CUbkj+rcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270036

The Glymur USB subsystem contains a multiport controller, which utilizes
two QMP UNI PHYs.  Add the proper compatible string for the Glymur SoC, and
the required clkref clock name.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
index a1b55168e050..b0ce803d2b49 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
@@ -16,6 +16,7 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,glymur-qmp-usb3-uni-phy
       - qcom,ipq5424-qmp-usb3-phy
       - qcom,ipq6018-qmp-usb3-phy
       - qcom,ipq8074-qmp-usb3-phy
@@ -62,6 +63,8 @@ properties:
 
   vdda-pll-supply: true
 
+  refgen-supply: true
+
   "#clock-cells":
     const: 0
 
@@ -157,6 +160,25 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-qmp-usb3-uni-phy
+    then:
+      properties:
+        clocks:
+          maxItems: 5
+        clock-names:
+          items:
+            - const: aux
+            - const: clkref
+            - const: ref
+            - const: com_aux
+            - const: pipe
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,glymur-qmp-usb3-uni-phy
               - qcom,sa8775p-qmp-usb3-uni-phy
               - qcom,sc8180x-qmp-usb3-uni-phy
               - qcom,sc8280xp-qmp-usb3-uni-phy
@@ -165,6 +187,19 @@ allOf:
       required:
         - power-domains
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,glymur-qmp-usb3-uni-phy
+    then:
+      required:
+        - refgen-supply
+    else:
+      properties:
+        refgen-supply: false
+
 additionalProperties: false
 
 examples:

