Return-Path: <linux-kernel+bounces-822407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FB0B83C99
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176AF1886AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D090630215F;
	Thu, 18 Sep 2025 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iGCVQKFJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8EC3019C8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187691; cv=none; b=swNA/aQKeepOwlZRXPICTlMva3P830FwSrjLSBbRIn16IBhAjuYQk8uNjwk2Zc01t2Fh11xgCCwCCKUXEh4lROrMOn33/qJl/1/dUvqSqJ7eSo7nS5Imj3PCqVs9zloitA4Yj4BjJ9W/LizJh5L2IxDPcqw81ogSAIYPFFJ7TMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187691; c=relaxed/simple;
	bh=ArXwDIA34+1WfUp8gIHMT40+a9JNYhOA/RMyYMWiy6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BazRf/m8Y0ZGoT6zpI6+iwz6s4l/jogr7PWh/0Vbn/zNunWTQC6AxQJUqqybPjrWpvsqWrduA0f3ZCVpHBJg0H5m1aXWdHcbsOMYXQjGHjwTBBGwfFfrY7r4x2q9J24sneQ2Iez3KCPWSOydqCV3/vdSYuG0pw9WPWR3xLi27WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iGCVQKFJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7MD2h011014
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3F+avBgCPtVijc/CXlYOC3xqwD3ll2D58Zhdko8e96g=; b=iGCVQKFJoCU6rSM4
	n/vtMg7pn/ZGQ+k3BZGhURIVRFr1trFI1LetKQEMVsNF7rHrqjwBRWOFkxPr5P0T
	4bv/pdqdQI8EptKkqsYvyLC1JjSriq2NStd0nEnFTyTtDYpnJzHwERaiXpJZktPZ
	H12tRAYpwRERYG8C32UeW8SL6dQwPXN1leEth+vxyqRYdkQC6a1N05JZ2Qe19kMD
	64oD0UEKZgL7O0OhsVx31/I24tpzivqsbX4xvAchLuxjAcPjruglzzwepqYAk+se
	jputYJpoNiWFL6wMBhH3O/iMWzDtWXUErwtnQGYwF826uHa2LaanTZmxijeTiS1p
	1I7dqQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4985wx1nvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:28:07 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32ec67fcb88so658689a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758187686; x=1758792486;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3F+avBgCPtVijc/CXlYOC3xqwD3ll2D58Zhdko8e96g=;
        b=R4GPeRiXO/4FwitnbwL9lvhqZ/IxeXBfLCKIRsCvZkAXm9wd5ptUAtQIQdefHDyWHG
         Gx1p8cwRpOIt4tjnR1vbKN58YXzVx2eapmHETxsGYLqSVYFps7xnkWOB4Xdpv8wCnZKC
         3ePVTCJyLeolmFoQuToboG9clB7TGyusnv3Y8DswuDBlsRt+XAHuNnjuaF3WFQ05LqHc
         Mw625pI/P6vgyVR5CgU+d9zzCCqEQIUKgW6YyUOIMTl/ACJm374crDmiLDxQpJbs3ZIh
         n17omW+VLgT6QrUqEvN/Z7d9X8IzawocNo09tuIJ/uNBDV7N3I06TFzeqLvJhthEW8OV
         1/vg==
X-Forwarded-Encrypted: i=1; AJvYcCWwWnz+jdTiPlhYz4MNahqQlCmaxYnp2Xa6rx37uZEpJbVprM9s5C+WbsbhtTlsh9/yrN0dT+BaYN8oq/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCEWWBs5faLraeO6Pmd1kcWhXBMMjBjHN1nBA3v13/J6tW0L0r
	yCIyUHjp9wH+uZWL8wZ9C3p0R8zduEdX0WsJXURwTmGWRixbHF2xt3h8XfICSuteaY4+y4P5VYE
	+P6ySS16FMjOZjkT42B3Qqy19IljBZMDglWzOJ6UVcYIvDr0uRuoJ3/C5atSVeaxuu1c=
X-Gm-Gg: ASbGncvB1fWtAym1LjLnzZUimc2s0bhUn7s/1XrTcRfRRHHMWnyRTq2oZ33NqaKLKKg
	A6q++QbeaIObDOSGNMts0/S/AR0UuUEFMMdX0Sh6UeHMgZ43Lqob2cTCotiztBqV0vTNIjRuZij
	jNghPEPcCkRTrYZokxmYz2LRk/wZ3yHvEeSAPSQdknTagWPuswLV1ZH6FI9SISdwbbmAWnr9Fod
	6x5twnhT0FvyxW+Lvd5FxkSo84Ru9M0ca2/4eAinC3uhscsa5Ul4bQTRydFT7YHYYJlM+gVqx51
	uiHK1jPd+dCfuWDRmfcohkiI0AM3a4PLSAoLE+Qp/ZoITulDJx3T0IAtVbZ3a58Uo9I8s7p706q
	ia6jtcIC+Wk02QhZ+EOH6a094Bw==
X-Received: by 2002:a17:90b:28cd:b0:327:ba77:a47 with SMTP id 98e67ed59e1d1-32ee3eeb3b4mr7398900a91.15.1758187685883;
        Thu, 18 Sep 2025 02:28:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxAgLlv20QfQ7pYeroZaBP6I4S+pxEyWce3XgubjnvcE6lMDEzesNd8ntusI4J2/DS5D9dKQ==
X-Received: by 2002:a17:90b:28cd:b0:327:ba77:a47 with SMTP id 98e67ed59e1d1-32ee3eeb3b4mr7398850a91.15.1758187685382;
        Thu, 18 Sep 2025 02:28:05 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfbb79b81sm1819205b3a.10.2025.09.18.02.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:28:05 -0700 (PDT)
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 14:57:01 +0530
Subject: [PATCH v3 1/4] dt-bindings: rpmh-regulator : Add compatibles for
 PMH01XX & PMCX0102
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-glymur-rpmh-regulator-driver-v3-1-184c09678be3@oss.qualcomm.com>
References: <20250918-glymur-rpmh-regulator-driver-v3-0-184c09678be3@oss.qualcomm.com>
In-Reply-To: <20250918-glymur-rpmh-regulator-driver-v3-0-184c09678be3@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758187677; l=3104;
 i=kamal.wadhwa@oss.qualcomm.com; s=20241018; h=from:subject:message-id;
 bh=ArXwDIA34+1WfUp8gIHMT40+a9JNYhOA/RMyYMWiy6U=;
 b=0B2o6btoCTpfFbSbYve0QWiBMoOSBTxGHn8ncvs1EJxdlh6kWQQ3v/AA8O/6bulZ13bOL0ARq
 7IbHwBI+xaXC35QHZy8fPnzWm4lfaR6MBIstDPVsuVC7YL3+Gp+ZL5x
X-Developer-Key: i=kamal.wadhwa@oss.qualcomm.com; a=ed25519;
 pk=XbPE6DM5/mJi2tsiYwMCJCZ4O5XPMqColJRlGVcM7Hs=
X-Proofpoint-ORIG-GUID: J83Qb0EmK_gL_8p-E2xwPEFpfQOWpcD-
X-Proofpoint-GUID: J83Qb0EmK_gL_8p-E2xwPEFpfQOWpcD-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDIxOSBTYWx0ZWRfX4BHGjkWEdOTd
 DggFquLJs8BYHrCmMf87bOO9vG50zrQtUGG9jG6guQP/bVZHhgvcvg7K8tgJyNS+V50I1eXzipN
 sxxOy95h7i/+/7FikMsk8Qvx5YLUreoRhxJziv4cousYQwCAY59B8R7glfRNBowECsg/Y4/EBvB
 ga7V7vCWfgmip56JK5xwNXWi/guUc9yKjoP5SZDEINnLHZX/F+lNGFOWAQOBMbeXReJPP1KT2oU
 LNWOgs9S6U3K75c/ouDm3v8teOiCCFxO0q8SkV1XeB4eMG4e5tTW4OoYn/Qn+WwGlB2WagrPxer
 vTMy6KGfy1mD5yRCHbR7sdSY1Nyq2Z29jak7FALzbZ+02TU7GcW1gpFoB+3vwdLGeQFDLA4o3Kc
 JlOy+Bga
X-Authority-Analysis: v=2.4 cv=Fq8F/3rq c=1 sm=1 tr=0 ts=68cbd0a7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=lsy0SRZfEzWN0kW82SEA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170219

Add rpmh-regulator driver compatibles strings for below PMICs:
- PMH0101
- PMH0104
- PMH0110
- PMCX0102

Also add the supply name properties for the regulators
present on these PMICs.

Co-developed-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
---
 .../bindings/regulator/qcom,rpmh-regulator.yaml    | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index 4c5b0629aa3e622579b54a226785139a0b986079..40e57b10ebbebeff130871b6d978df64111b6f29 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -51,8 +51,12 @@ description: |
       For PM8450, smps1 - smps6, ldo1 - ldo4
       For PM8550, smps1 - smps6, ldo1 - ldo17, bob1 - bob2
       For PM8998, smps1 - smps13, ldo1 - ldo28, lvs1 - lvs2
+      For PMH0101, ldo1 - ldo18, bob1 - bob2
+      For PMH0104, smps1 - smps4
+      For PMH0110, smps1 - smps10, ldo1 - ldo4
       For PMI8998, bob
       For PMC8380, smps1 - smps8, ldo1 - lodo3
+      For PMCX0102, smps1 - smps10, ldo1 - ldo4
       For PMR735A, smps1 - smps3, ldo1 - ldo7
       For PMR735B, ldo1 - ldo12
       For PMX55, smps1 - smps7, ldo1 - ldo16
@@ -85,7 +89,11 @@ properties:
       - qcom,pmc8180-rpmh-regulators
       - qcom,pmc8180c-rpmh-regulators
       - qcom,pmc8380-rpmh-regulators
+      - qcom,pmcx0102-rpmh-regulators
       - qcom,pmg1110-rpmh-regulators
+      - qcom,pmh0101-rpmh-regulators
+      - qcom,pmh0104-rpmh-regulators
+      - qcom,pmh0110-rpmh-regulators
       - qcom,pmi8998-rpmh-regulators
       - qcom,pmm8155au-rpmh-regulators
       - qcom,pmm8654au-rpmh-regulators
@@ -246,6 +254,7 @@ allOf:
         compatible:
           enum:
             - qcom,pm8005-rpmh-regulators
+            - qcom,pmh0104-rpmh-regulators
     then:
       patternProperties:
         "^vdd-s[1-4]-supply$": true
@@ -422,6 +431,34 @@ allOf:
       properties:
         vdd-s1-supply: true
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,pmh0101-rpmh-regulators
+    then:
+      properties:
+        vdd-l1-l4-l10-supply: true
+        vdd-l2-l13-l14-supply: true
+        vdd-l3-l11-supply: true
+        vdd-l5-l16-supply: true
+        vdd-l6-l7-supply: true
+        vdd-l8-l9-supply: true
+      patternProperties:
+        "^vdd-l(1[2578])-supply$": true
+        "^vdd-bob[1-2]-supply$": true
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,pmcx0102-rpmh-regulators
+            - qcom,pmh0110-rpmh-regulators
+    then:
+      patternProperties:
+        "^vdd-l[1-4]-supply$": true
+        "^vdd-s([1-9]|10)-supply$": true
+
   - if:
       properties:
         compatible:

-- 
2.25.1


