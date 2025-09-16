Return-Path: <linux-kernel+bounces-818315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7BCB58FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81EEC520C8B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A79B283CAF;
	Tue, 16 Sep 2025 07:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gfxJ98nq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D59F283689
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009522; cv=none; b=h2I/9d+960pYM8SFa0maHFEHFwQxeE1iEHprN8bYp8wdYU6jJZBFFa6qSJ5U/VVQHPX5xnSxEf2jb/u3zbiGOC+RGVdEy2wQsS7Ai4KYGT7grhYgKkgZYgiuV44IY5daCSX7sPmNUuOnpfDVZFd6VzVs0PuDZ+cYHkWxLaLv3+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009522; c=relaxed/simple;
	bh=ArXwDIA34+1WfUp8gIHMT40+a9JNYhOA/RMyYMWiy6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kP8xXjjAWEvvultvYbzA36ui4dGpBBPfkMbq5kCHwHf2vxVH+h+0ANBeQaYWQ8QznQbE3YRZBQ6x3FWJHYjWojFgQw3h/4gwYAtFoa4HC/atIspE+4X5A3TVLFMh9B5TDOSlXvR61APMG3gvJRJdXQ/C4tbtVKPX3wjmb6jT3PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gfxJ98nq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G3pkgY010790
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3F+avBgCPtVijc/CXlYOC3xqwD3ll2D58Zhdko8e96g=; b=gfxJ98nqc1X9fWDn
	YvZSuEW7G5QpctkTQRxAX+q99O3+o/EqY+Vy+2uMXaCLMLW6ICdBQnw0Xg9dj24q
	NHECqVKHk2Z2aPBW/OIe/J9+Qof4OphRwEW/iSSNEC0MOHjudBG3+9wgDJFQPU8x
	MGktFoAuZSbys/obCOVqGNoyBivo7CtsW0SptiFS1FdcTDuv2CNLMAsfjWY0fGdr
	ddTLEt9JqNElaYIM+PR6SNHCmnaafRII76P4gBuGCVeXSBiAujlsJXuofjf04Kde
	VQ+mGNMmYTzCP6pDBDL/iZKLG4ylL908iTSmW+K99xC6lXJrxOZN02mnpqOLxoHZ
	NA2hiw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951snqrv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:58:39 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7760b6b7235so3828833b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758009519; x=1758614319;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3F+avBgCPtVijc/CXlYOC3xqwD3ll2D58Zhdko8e96g=;
        b=SH8LBLNi/x1QH+LK9LTmbBwI7CXJ9hX1WRlWMzbnWy7ED5to2bq/i5qut6nVO/6Ln4
         Pj+kgCP1bO3Jdmo12ufofMS5BHTX+33xk1W/2TjEUpn+aVmlKgKpwiBSdbab7Iv1qm+Z
         1raj/uBLqLVUhGDbZEszi7W5xQN2E/pk85dLWw4/Zs6Vg89oBpesLkzMFcD8/BHSnOcx
         tSoLUPdW3A+JhJcXNoSp4jnw+GXdt9oj5C3Qp9ECp3jlNXvAP6SHn6krBrNZebKe5vg9
         sxFN+3W+MO1a2A0D3UUsguM09tsMc/XnOq8rpPsP8kTIF8Xrb6OOYyQkc/c9hMSP14me
         nJaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqRp0k1hfIm2vy7vPa0IYr3zbOcDbNwGk6uG46UJDkHoVzVSo0vbduvtzH98HbMarif1zKaS/eaQm6SQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4WUKjRlJhm/FnW1/qJLKdTzKuSvglItY9cqEoqIjj8aFG+aU+
	Ul8l8y9m+kluLiybalXhKDwt4aro02rMqwNvFYZLZYk8mt9nNYDeiu3VECjJaMk0YKu4v/ncNcO
	GWIw5VzoGQYW9JRttzwHJYmqZX0Z1jyiFG/fpWeQNOeJ1GcBJEDgX6J0cKNcehXTWCnWYJi6jtG
	4=
X-Gm-Gg: ASbGnctLnCSMzflNs2X176Zvhcl2PVbWOZJqB8cX793IdvedORtjCcCD7BrRduubnE1
	6QnCgzUEs8+gWLmVyIub/Y0e+8SLIIemWBbedwITfZWNHg8H7qDQpNR4LP9bEEclywIP/0i//Ev
	Y+27LtsxPH78sQ7c7HsfZprYuITc5qPM3naFwvGqZg1lwiEqTlzhSGyzvVp1xvVi6KVm5XE8sQ9
	OBDT5Nzs6XkCIuT3Ypis9riwElzHwbF/++ka6Amoyij8VW5FHGpAhyLNOjWQtbVsmKFin61eV1m
	HfVMaQaulSiHnJnkcbTytbB4zO0OIo5oZ0FDXaMSduCfWr4iwL8eVz/rL9+AF+A6d2bMEFbm6P/
	zqz1vw+ad8JZbbuchb8GNlAHwZw==
X-Received: by 2002:a05:6a00:3c8a:b0:772:306d:a1ed with SMTP id d2e1a72fcca58-7761219fbfbmr20081624b3a.32.1758009518607;
        Tue, 16 Sep 2025 00:58:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaXARsNUr/p/kt1rsM7pNdMTXvhVpM3o7m0bfspEzwuZzKeEjPRx9DfSQD4zl+cl+r9jCK/g==
X-Received: by 2002:a05:6a00:3c8a:b0:772:306d:a1ed with SMTP id d2e1a72fcca58-7761219fbfbmr20081578b3a.32.1758009518112;
        Tue, 16 Sep 2025 00:58:38 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7761af2e09dsm11292222b3a.76.2025.09.16.00.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 00:58:37 -0700 (PDT)
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 13:28:15 +0530
Subject: [PATCH 1/4] dt-bindings: rpmh-regulator : Add compatibles for
 PMH01XX & PMCX0102
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-glymur-rpmh-regulator-driver-v1-1-bb9b00e93a61@oss.qualcomm.com>
References: <20250916-glymur-rpmh-regulator-driver-v1-0-bb9b00e93a61@oss.qualcomm.com>
In-Reply-To: <20250916-glymur-rpmh-regulator-driver-v1-0-bb9b00e93a61@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758009510; l=3104;
 i=kamal.wadhwa@oss.qualcomm.com; s=20241018; h=from:subject:message-id;
 bh=ArXwDIA34+1WfUp8gIHMT40+a9JNYhOA/RMyYMWiy6U=;
 b=VJZoKeKCzGneNcfP/XfShsAj3Uzq/FRWiiIfMzOKguvIhoBMR7Kjh3uIoXuY4IhfBD3nqDm4o
 Oafp2CZPFbpAar02GR97BuRVAD4i5AZnnkZ1YnrxzpiXMrdjhQscfaR
X-Developer-Key: i=kamal.wadhwa@oss.qualcomm.com; a=ed25519;
 pk=XbPE6DM5/mJi2tsiYwMCJCZ4O5XPMqColJRlGVcM7Hs=
X-Authority-Analysis: v=2.4 cv=JO87s9Kb c=1 sm=1 tr=0 ts=68c918af cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=lsy0SRZfEzWN0kW82SEA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: sg-aLy22MHoCXJfxQMtGfxL152aAY99A
X-Proofpoint-GUID: sg-aLy22MHoCXJfxQMtGfxL152aAY99A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDA0MCBTYWx0ZWRfXy1dpgAMXIvYX
 In8wjERaF12kp9sEySB/Ld1UyQebtMKt+Vk6qyOdi5bCofTeJF7eUgmbbNusxmpMHejL+nYk64Y
 q6ihXdbf9fHI2rB61FIEesWVQ/LQTokDQcnV6oBckDwCx34Ustt83RGtCXWBePcRSkSX7jLNjPV
 pql+DxOLYP7rqcVLqQmML3nZIfGVoEGB/jUjS2YgZfSPy1LKDt40YRwV1p/Vd1QksqFZsMsrxBx
 wZ54UQ6ubdK1m8Jl2DEGljlYgBw/x/GU3TvcpAZYIgf+a7UCrjQR1Omok+64thdcnI2r1UjvLe6
 8ikvwelZOun3XMYzSRY+8VYSopq7E9DuTbHAjrvRElGCsM7t4+zXuV63xa2fYl60NrkcYJdzWkl
 Mz8Je+ss
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130040

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


