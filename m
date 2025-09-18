Return-Path: <linux-kernel+bounces-818818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B63B596C3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2AB1884E2D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694142D8393;
	Tue, 16 Sep 2025 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iDGAgyp0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B30129BDBC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758027572; cv=none; b=as4ryFUx1WpVYJYdzxdu2EWz5Gvlxr3JsPRepxadepcLN/fRysZArEQ5/BHBLAVeHyBI6DcjcvosR05xZ0G52arLlLP5iO1NGHdta+bXJxK3uaWL9ii5Ww4DXcF3q+N7m/Bwr74NPU0qV9phBymIvREL68mynLX4SMOxekpqo70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758027572; c=relaxed/simple;
	bh=ArXwDIA34+1WfUp8gIHMT40+a9JNYhOA/RMyYMWiy6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lWzVxBycdxSCKnLuX4pPtp4xtESdVPQYNsGJHUwEpi4tpWq4evqLg08ZEK0uHp/IvkE0DXihVTXrTA16/PqMiG6cBtTG13vnWVuBLSISXt3eqtuUsrqnu10T5ruxlNjGpg+LFmFtrOUPKKR1LPPf/ZMrhfeLmXCxgONSY6cuBxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iDGAgyp0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9mami005518
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:59:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3F+avBgCPtVijc/CXlYOC3xqwD3ll2D58Zhdko8e96g=; b=iDGAgyp0GaLspUGc
	T1e+6zPtGvr+NOFiYfcFIHxFmy/8yZeLMrrLm1ZohXYSjQ1oRelqYSKegxqTe6JZ
	IXZdDI+Wg4dpMNVJMbs3UjJ8NHQN3tZ5QJO4KgP+74OkEW4G+hz1VzmXRLn/GlYH
	51MUYNRiTWB12dLMM7mINxWCbaEsYdWZyfdTs5JHoX0MrsNWavv7EB+w8ebJW0j/
	oGjHcuo8h1j8v3AMeqONpDIc6VOy8LrVSAmyIcnqZVxV+4KNXImceow209bk3Vey
	ItWmsuavpQ4DU0gCj1uEeDoFuckSnknFlUYEOUr0P1mrTIICrpYPehkgZSfMyKFD
	aOvUQQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4950u58tqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:59:30 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7761c58f77fso3236449b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758027569; x=1758632369;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3F+avBgCPtVijc/CXlYOC3xqwD3ll2D58Zhdko8e96g=;
        b=e+/HVb5ewU6qUqY0ZyXJoWL3J9Dp81Cyw4d5ZAi1M4YzxNP9hkZCZARQNbwCSsJZ1a
         wwNPFCPOFN4vvyj5gd0kCR9lfN72NzQXUt4eU4o6lli1x7GHtb2TkSDMqumbgRXWLmk7
         kCf9U0t5eG9xbjzYFC9boJWr2FUolMday3GdXLSv6NApgK/ckK3fML5vrowD0BZ1lMNS
         HpN50Ga2gUtkQbQRJ3YDCOmpIbKPyBSgzERykxA9upYQ3RA1AOL0ClvDW0iMocz+hCRP
         rMKugHSBDgTw3s/UH5uzFarwzAHjuD5cUctLMC/+H/2nKcve7auPL4bQJ5sr+ytlRCXz
         +JAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUix42IFcC2j9qpDzzDPMcrcFKp655R/KEHqfkDlEvdq7x/rH9HopPFCwpMsd7GNKfAOm7Ki8AmHnHpRgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX5yzns9jGCY0jw/p6+UORp2hjh108A7x2M1WJgjZNFnLQ4hhu
	fdYUigG6yAKs/8kl5YnEDBsWcGrFL0aR+iHG51ddFTliJ2mhw3ftpSKyzpVOHLWkvWxEBU+645d
	6KjkYUb3ltfucD16HlzYI8Qiiqkpp3g9sf8sUkpeom50FDZDssSEUGtLKQlA8ycOqZzI=
X-Gm-Gg: ASbGncuXo3XhkUjK9/9swyA5o+lIoVBtnjxjT/b67nwuUZEJ9t2s9bWFWEiSMAtxzhb
	SM+XMFbTtLugXx86a/XeeXpQCLz/+nmig4aHj+qqGI1+4T+t1bgjRVM/+8lTRruFpk0mXT2WtqK
	YkrPAThpV+prkKevuWvlGBMJYapDbO5LaGzap+HFYLidDMnAQ//UP+D8OaAA0kKrgeNvxmMxnNt
	oWJLPBPQQgv7s4zgIVj5x89KqlBNCda/h5XqEX7kbx46Th00/YRTHnR4PvWP2j/ptYvVvoU5kCb
	iTrhSQlP6dvuZaWvc/YpBkO8khXlgMKivESzX+CsA/4LnC3AlnnUXztNyaJIae5/NnyAe0uGMs7
	A2XkGiOpIjQADV8WbRbuLbKgpqg==
X-Received: by 2002:a05:6a00:4646:b0:770:4ede:a2e8 with SMTP id d2e1a72fcca58-77612163929mr16665910b3a.16.1758027569352;
        Tue, 16 Sep 2025 05:59:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmb71a7q47hpN//nq+ziR3OQx8TzsAwDsoM4rUQcl/VbXCJ5ovd9F+DFg/NB6YAIn4jpAoYg==
X-Received: by 2002:a05:6a00:4646:b0:770:4ede:a2e8 with SMTP id d2e1a72fcca58-77612163929mr16665880b3a.16.1758027568835;
        Tue, 16 Sep 2025 05:59:28 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a46b7asm16057113b3a.22.2025.09.16.05.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 05:59:28 -0700 (PDT)
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 18:28:52 +0530
Subject: [PATCH v2 1/4] dt-bindings: rpmh-regulator : Add compatibles for
 PMH01XX & PMCX0102
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-glymur-rpmh-regulator-driver-v2-1-c6593ff9b4be@oss.qualcomm.com>
References: <20250916-glymur-rpmh-regulator-driver-v2-0-c6593ff9b4be@oss.qualcomm.com>
In-Reply-To: <20250916-glymur-rpmh-regulator-driver-v2-0-c6593ff9b4be@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        jishnu.prakash@oss.qualcomm.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758027560; l=3104;
 i=kamal.wadhwa@oss.qualcomm.com; s=20241018; h=from:subject:message-id;
 bh=ArXwDIA34+1WfUp8gIHMT40+a9JNYhOA/RMyYMWiy6U=;
 b=5S++N3b4m1dfuTL8iMCLcvTKf3bQiw6ME/YqNaXckgvIqnAJ16aBRLDv55tV4wftAV3FIn7su
 tBJtCieE1s1CZZ8rr+CyclA+U2uuI2I+vpwOZScZIYua2Au0JfInCMC
X-Developer-Key: i=kamal.wadhwa@oss.qualcomm.com; a=ed25519;
 pk=XbPE6DM5/mJi2tsiYwMCJCZ4O5XPMqColJRlGVcM7Hs=
X-Proofpoint-GUID: kWgLU-5eDYSw_zNWqR9ykgWj2ikw1l8P
X-Proofpoint-ORIG-GUID: kWgLU-5eDYSw_zNWqR9ykgWj2ikw1l8P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzMSBTYWx0ZWRfXy5bqU1A+jbIR
 O9CE5n31ViA0KsF/m1spALfJ7LTw3EViwsTepdageRqWb0vAqHB+fGQtkvdqnML8fDkHIBcZoBR
 3237Pjy8RgmSuWqZP+quOgJXlP7bzyWrBPJvUE7TZkH+8xdn8IPBadMHO2T+g3TobSTJmNAFfnF
 jibtkIhu0AMSgWvdpglmR9SwPvgK3B3H1/nAHUSXvMkkXce2Ccow4smME9T8ZA7Pv1jTpoMkgg2
 1VXxIQ0jYDJTQGtkvyrH+jpHbDaDL5dkRZGJqp7dnnw763KlTUoAghgtnKtG3ZnHPdiuD+8gShs
 A8yn29zVrJ7COjK4lxnT+7NRBFWRVDX/1t6Cy5E2XrPANRd0wC2SfvwuqWl3uyeXNT95Bpor11I
 96VD/fQd
X-Authority-Analysis: v=2.4 cv=JvzxrN4C c=1 sm=1 tr=0 ts=68c95f32 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=lsy0SRZfEzWN0kW82SEA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130031

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


