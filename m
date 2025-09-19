Return-Path: <linux-kernel+bounces-824683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B304CB89DAB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0B61C84E24
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0070D310782;
	Fri, 19 Sep 2025 14:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="otQm3Lgj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F792F0690
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291294; cv=none; b=SlCPWfpwG3p+Br9FhVneMD8qPhxgqmrXv/cn3cRRLXPW2yKZEPKOlfMijYkR6wS5t5AynOPJSuKrc6QDCyHFJ9OAata8ppEkG1mCZ1nwISldpBL+SAyG3jwwC06wrVj7mubAo74pme2k6bZes6pouhYVMfU45udL0BIkqEKJNkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291294; c=relaxed/simple;
	bh=H18JYOxIyEwenlKHPH3Q4sdgZATPQK3L6NM+azc19AE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YaWv94+xnWSrutDJCIeLzY9lfpjYru9F58pXkwkrNv/8xpydsT3GOMgZ/nyBSx/bHiIjAOoGG+MwKcewQ3AseQ3tfasJV8BfuEu8kYJOJjrPpfQl3mKBkYrDkFfYKJmru37Kx1/8o/lK7Q3tcJ/FjPy1sG7m04V9Dnc+qlVPfn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=otQm3Lgj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58J8k448028290
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=9EEP86bPrEuFPhyrGPMSKAxoE/r/N527VzL
	IseJvapk=; b=otQm3LgjLRebVNhPqwJ2r4P4UwvdHcYQW0UiPpHqaB7xzV6HyM9
	vKzvnzwXzb1wnT0cQiae+vzW+nGogSHtI8Y/yk9twjffddOQV9ORTjnzAgoOYnBY
	/LIQYPBNpULBHrlS45de4tmaymkz/V9OkN4byh4X/LKbO5/ZxP5CXzUDnJhD7T5r
	EMMwSNDvPTn0zfqt5u5BGnVIomx8pPNxVUgSwzVlNAy8lipcnaLmC98DrPxTW5iM
	vKA0+YsKPkjByEDVsFkuU2fv9VS5oanzav6ZORXWagmzJ9x9hHDFo+YawtMmRXyO
	HETV1gbCN82wR2OYXo0yoi5rOR/IVfupU0w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497v1jgp7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:14:51 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4f8e079bc1so1537675a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758291290; x=1758896090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9EEP86bPrEuFPhyrGPMSKAxoE/r/N527VzLIseJvapk=;
        b=MKLDPfHJsJvZSlQ/gzmC4ChPNL+Aa4f5FMfHkp3DOXsRXE8ZN69glxkvH3uxG3XC/m
         qfZqU4m9C4qj0bTAwXR7j/2Z71k5RpHANaCBGvQIjY/GSN2vcWKfnpRlFxHPY+6N0CJw
         WgsyzPvC+XBmm5WxwoWmnYMjrt+WUqGyVJIgTaU1NAS+OqcPMG2t8Mf6W4lG9IBr6bp3
         hIioJv0GwFDzr5YTRj1LuOjd1qibuTbrL46VSxCWHjjljo/k8lTOSUbR3cbJzQeXpvWt
         dyz7x2IX2G/SHC1A/tzFtQVQQXjj5R7rG1VxoaYNNOh7XIZQb2I0zpERpts9qUCjkq0H
         9ulQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdnPC4BGsfy/toAmMhC6rQ7j9fvgyykGRhhVrJGr/wUptMMAt69e6isbuDQB9Y8ZwV7Q/nZ1Pnxv9IGoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP18+h1WklLeX5PN761F0nOWufQiRnKweLY3/XF/C6sPCu8gPW
	km5mqnOzIRsPbMV83SimNWCSds/pGfQ2V/Ek6qsUFmWm5dxDbL+fKJZZDqVXDF8NX01hoYbTeqP
	kss7L/gHX+NR0N6LgIsoar4bJWzdfxJ1P3iyAKIJ6ZCWbkPdTurSTMxaxdMa27NQpJmHN25yJXr
	k=
X-Gm-Gg: ASbGncuTEnmrt52mtnbmvO5hnv9OHtzk3QWKfa7DUXC5HcrUl3OH+i7tE1OivV6KUAu
	16AEiNc9uROHB+XCj8w6SoiOFEX+bA6ZlloLXoWWdzOCRQe3hK3BqerboONkfz1K0WRwNsfopG2
	Wc/W7yG2h1M20nARWo+LiCRvXdnH+0Kf30rXhHX13ZVxfzTSuqcGpj3F4J40/kqZ2nCw5ynjhkr
	Pjv5kioJluWiUdC76PM2Debp+e83U+sFJv7RXxSJR4btk3QncYcXX5m02fKpwfixF0GOLFTtotj
	2Ou7azWfmVsHGcIx4mXEyeRrIPStz7tRAC+F08dW+nQZvA9uVnWfQvS/saM2QHTbyJBeDArZ7IE
	reZc24x6+Sn8VNeLfgLGdxMIziALvW7fNB0apeRnsyKNJvcGN1RVYRbHBggKy
X-Received: by 2002:a17:903:2341:b0:24c:a269:b6d5 with SMTP id d9443c01a7336-269ba27020bmr50046075ad.0.1758291289596;
        Fri, 19 Sep 2025 07:14:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZEoV1JBT8ltcQHOk66+9wxwccfdS5Zcfmesrj8v0ZFx8i90bAAeizJjd/qgTQvGzs2XP4SQ==
X-Received: by 2002:a17:903:2341:b0:24c:a269:b6d5 with SMTP id d9443c01a7336-269ba27020bmr50045735ad.0.1758291289091;
        Fri, 19 Sep 2025 07:14:49 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016d9d5sm56456845ad.53.2025.09.19.07.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 07:14:48 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: andersson@kernel.org, linus.walleij@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pinctrl: qcom,pmic-gpio: Add GPIO bindings for Glymur PMICs
Date: Fri, 19 Sep 2025 19:44:40 +0530
Message-Id: <20250919141440.1068770-1-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4UUVWw3diiMR7cBnKCUqsj1anFRzPAWG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDExMCBTYWx0ZWRfXwZNBIhyc1MEm
 LbSH+6SztT9F7m7YlA1u1rz00Zo9XYWSlZWBOExBnOUtjaJjc3iStUEif78+/O5NALMYuiCBKWa
 tBsUdJUBnsNGZKQhS/dKEqin6peKke6/78DmoVIHJ53CFD+3KuZqeMNIjHDhsSQA3C2lO4l4LaY
 rNInJv3VcwatQb9V7F3ITkgBeRM/Gqagq3H6NwyX+xEMGMKpbnV61VrhPS0eXcMFXcWfmlnkn7l
 s7wKDj3hw3MLr9Jl+CqW3+Q78HcHz7K8nrdlakbHVKmcY2abbU7eO8JXIp0MtksoJMipAO7g45d
 j15hWqNRDSWd0dPpLn7Ux0qO9Zph1fhrL6UQbb+aO0/6gEZH9RgEoFXfdnmd8IFPy/4G9LhBEE9
 VHhBUSct
X-Authority-Analysis: v=2.4 cv=AeqxH2XG c=1 sm=1 tr=0 ts=68cd655b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=gVt0xI4JxzluFwnjjo4A:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: 4UUVWw3diiMR7cBnKCUqsj1anFRzPAWG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509170110

From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>

Update the Qualcomm Technologies, Inc. PMIC GPIO binding documentation
to include compatible strings for PMK8850, PMH0101, PMH0104, PMH0110
and PMCX0102 PMICs.

Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 .../bindings/pinctrl/qcom,pmic-gpio.yaml          | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
index 5e6dfcc3fe9b..8ae4489637f3 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
@@ -59,7 +59,11 @@ properties:
           - qcom,pmc8180-gpio
           - qcom,pmc8180c-gpio
           - qcom,pmc8380-gpio
+          - qcom,pmcx0102-gpio
           - qcom,pmd8028-gpio
+          - qcom,pmh0101-gpio
+          - qcom,pmh0104-gpio
+          - qcom,pmh0110-gpio
           - qcom,pmi632-gpio
           - qcom,pmi8950-gpio
           - qcom,pmi8994-gpio
@@ -68,6 +72,7 @@ properties:
           - qcom,pmiv0104-gpio
           - qcom,pmk8350-gpio
           - qcom,pmk8550-gpio
+          - qcom,pmk8850-gpio
           - qcom,pmm8155au-gpio
           - qcom,pmm8654au-gpio
           - qcom,pmp8074-gpio
@@ -191,6 +196,8 @@ allOf:
               - qcom,pm8950-gpio
               - qcom,pm8953-gpio
               - qcom,pmi632-gpio
+              - qcom,pmh0104-gpio
+              - qcom,pmk8850-gpio
     then:
       properties:
         gpio-line-names:
@@ -303,6 +310,8 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,pmcx0102-gpio
+              - qcom,pmh0110-gpio
               - qcom,pmi8998-gpio
     then:
       properties:
@@ -318,6 +327,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,pmh0101-gpio
               - qcom,pmih0108-gpio
     then:
       properties:
@@ -481,13 +491,18 @@ $defs:
                  - gpio1-gpio22 for pm8994
                  - gpio1-gpio26 for pm8998
                  - gpio1-gpio22 for pma8084
+                 - gpio1-gpio14 for pmcx0102
                  - gpio1-gpio4 for pmd8028
+                 - gpio1-gpio18 for pmh0101
+                 - gpio1-gpio8 for pmh0104
+                 - gpio1-gpio14 for pmh0110
                  - gpio1-gpio8 for pmi632
                  - gpio1-gpio2 for pmi8950
                  - gpio1-gpio10 for pmi8994
                  - gpio1-gpio18 for pmih0108
                  - gpio1-gpio4 for pmk8350
                  - gpio1-gpio6 for pmk8550
+                 - gpio1-gpio8 for pmk8850
                  - gpio1-gpio10 for pmm8155au
                  - gpio1-gpio12 for pmm8654au
                  - gpio1-gpio12 for pmp8074 (holes on gpio1 and gpio12)
-- 
2.34.1


