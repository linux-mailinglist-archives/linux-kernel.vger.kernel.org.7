Return-Path: <linux-kernel+bounces-831406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA30B9C93F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 626E27AAB25
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7002BD5B9;
	Wed, 24 Sep 2025 23:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="INex7DrQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3CE1A9F8D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756658; cv=none; b=iWuyAChwl3c3NdeJEClA7ZqKYnO1QacZky5uczlbklnT+vDBLJcpdD1ik9CsuYsxCJRMyMUgfyQl2+5KuiowoRrfueveb5Vh2Pt/LAD9kL54arWmvJ/oV9Z6lSkfwARPwrPgLK9BYtGGVU1sevv4zk8IuUAjWZ83nbi1tONMR48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756658; c=relaxed/simple;
	bh=cU32TcSKW9YyIovlQL4SfLf5/O51JhAVf+zjp6IfwyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lPycHqYf9P9ZdgggZlgy0EWkMfkZcn3C36FSFoddc4cwl9qHYQ67u9zWb0Yr6jFt2/dqcLTFGFC1qfeScdkTMrjAR7CXK/R2Q6uSfWJyeDqFBsQ91jpD4JHvzcClCVpUtT+vUvlrv4vdLYZ9lW6pMJdNPUSNAc4zGmuWg7TFKVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=INex7DrQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONKY6O002710
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OuQ5pE+7XMJfuNagezwC+U/OxjrKQySR9lYMvVRSWPo=; b=INex7DrQExjDpl4V
	VhjeemVWrCg16YdlyTig+zznkqrHfGV/fJwGsLOIQo9+5R9WZW9hl9op38biojeS
	Hs8/J5XPN7Pye7qc19cMs8RY96nsEtF995cWD2zYUhbEXY731lzLa/Gx3LSSdDsv
	RiW5ZHMkWaD0H21dUDWMTgn2qKocp9ZIXr5Rjxdhw4/FHaU4ER1iHSr7P6xoeBfM
	KrKvS+VZAwcWWbgTe1F0VA9/A9od+bI/RfHgbEfsJyRAGVbq649VF0r1yLdSNt8w
	eg1zEZPofK703ZK89J9Tdo4ye/Ti5A0WC5T8AJxvEe+wnrQ6XOai1vRL/NfC9a/R
	uymk9w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajf0kcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:30:56 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-269880a7bd9so3392195ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756655; x=1759361455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OuQ5pE+7XMJfuNagezwC+U/OxjrKQySR9lYMvVRSWPo=;
        b=RF/iWBUV6ZQWNpTIxL2AHrNSbl8JrFiSCUHHGUYvQ8Y1DwOURxZGDT/jMeYuhCP6bG
         QwiEaRBFPXzUD8KUvFCurWM64SKUsPPO9wpO59P/nWUofEwS6GiPzKNR934/0eYk3pSf
         f7S3Zz/tQyih6vmvjQ5mOfRaQsfj1Lh/Hn6Q34SSa3zdjerCd9eXVgwTVPBUwwRysokp
         2ANKh1PwwST0laTlRvTmsY+YLf151arUEuBxkGTW4tNKUpC+NcKyYZ1780+n8SNQ8vaS
         Wq7Jmtk2HHCJ3iqYQEBGb0T+VVsRmo30DO0M0ceDKYmB04Fm4zWj3GJz9g2kZmdDPQUf
         axcw==
X-Forwarded-Encrypted: i=1; AJvYcCVepkvisPww4wrww64P7jEtpVGSt2+Q91k1QQVE1vyqmc4u82njHABGq6aVS4GHZ33n2fvmrD8NYI8LkSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvbRR/Uq2JOUPRXb5NXzsCZ4lSkwD1P+YQRPAMe5/C++8lH0dq
	h5imtBLqP6xYv63MVJsspHDE4AkB2IzBVQtN2W/GUe7MTkmduuA6JwOlCxOKaFn4wYHx6c+3Qpq
	xqhk/ct/jcSsPW7gKlQHff+D964LMwKAzAPcG6nzX6Za0Lqnr2/aLCcssxnniQoJ+Ii1v1YJR5C
	Vfuw==
X-Gm-Gg: ASbGnctluBrdGrnx92q0lt3p3jM1/8OknVvaYRJ5tfdP68/NJSUOpkR7B4wbwZi3G1c
	Apjqi6HIzpK3UafEQTPJJ1uWh2Tsi1sWT5qSk78u3TJ+kjnUNfO/bW95R5EfxLgr7PeQNYk3A01
	9lXfIzX1jDUErKGNGAVKoSvbqf+nLcAO7St5F1Gg5cx2CdkH9YX97pLemQcQcfYAD7UJZ+Qm3zP
	hP3D3x87UmEcD7bGeH1pSWi85RQnGcciUNANuGUs9FV/9cmZlz7uXskFE0a9zz4xgnxvOi3R5Ju
	c/4hItsrkX+8rUZrFZk2mZ5hlkmfHb8JpobPxBG07R532+tc57MRzQHXer91BDcttu3lcnjBPDl
	I6SAoKGIj8faOK+g=
X-Received: by 2002:a17:902:dac5:b0:27a:6c30:49c with SMTP id d9443c01a7336-27ed4a56ba4mr11632755ad.27.1758756655288;
        Wed, 24 Sep 2025 16:30:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF73pL4DbtNMTKsqVz8SVnywVT6FrsluvQdyVQ66mzDaIsEoW6YqWcm24T127WMgkyqc7WaYw==
X-Received: by 2002:a17:902:dac5:b0:27a:6c30:49c with SMTP id d9443c01a7336-27ed4a56ba4mr11632475ad.27.1758756654834;
        Wed, 24 Sep 2025 16:30:54 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6882284sm4122655ad.69.2025.09.24.16.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:30:54 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:30:47 -0700
Subject: [PATCH 1/2] regulator: dt-bindings: qcom,rpmh: Add support for
 PMR735D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-regulator-v1-1-d9cde9a98a44@oss.qualcomm.com>
References: <20250924-knp-regulator-v1-0-d9cde9a98a44@oss.qualcomm.com>
In-Reply-To: <20250924-knp-regulator-v1-0-d9cde9a98a44@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758756652; l=1753;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=fuQcxckOwrAnD/uN3prPY//RQ8aoexpztNDHqR78jIM=;
 b=YzBky5mXzDDTZRiTWo3DYyhE/wf5CnJ3bRm1sA3Z2czyllZYUn3GwVAukjyY8Lr4xbrNqyBAb
 x0oYo82Jd3VDxYsSk2ldyS/9VpfDwzSRRb1X23ISbjZy8MDPA3al5uA
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: wTIq6X_WBMTzu8mwkhOwnMQ2ZHV3TuFx
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d47f30 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=S1N0t0yXLE9zJeP-jjEA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX+IKblLTTUqTt
 LrTFFFdyC9bkRkZR7FttZefwktaf/G2kr4ThawQiKcficczFi9DxGu4puZaGmfO3BQglx7AIsXW
 VTOtEGpnHLWR33C1bCXAO68j0OU++2mF06uzZ5f92V382fYkoNHgV0zRWIj2I0UfKFqdoZvqtQe
 HQWk9zklAoB5qZiRvS+Cos6rle+rkJMwOFQVdS0zQmc2CI0m++pmpegcRgrio7Mfo2m33ZEcwox
 0+j/QlPM4nmuaESZR8z9hEJyoeXPjUqMF0QbylEBnXcTynlI68ICx7pkAQJjsHerMxH3R5r4XLj
 0t/bOUV8G1mJyEQbHi4Ke/GytBvXwiS2CK0TktcDnaMgMotBqHYk3/uGDm9X9X1yQfvz19NaSlb
 9fvS/IgA
X-Proofpoint-ORIG-GUID: wTIq6X_WBMTzu8mwkhOwnMQ2ZHV3TuFx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>

Add support for PMR735D PMIC used on Kaanapali boards.

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 .../devicetree/bindings/regulator/qcom,rpmh-regulator.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index 40ddc64577e7..4669095039c8 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -59,6 +59,7 @@ description: |
       For PMCX0102, smps1 - smps10, ldo1 - ldo4
       For PMR735A, smps1 - smps3, ldo1 - ldo7
       For PMR735B, ldo1 - ldo12
+      For PMR735D, ldo1 - ldo7
       For PMX55, smps1 - smps7, ldo1 - ldo16
       For PMX65, smps1 - smps8, ldo1 - ldo21
       For PMX75, smps1 - smps10, ldo1 - ldo21
@@ -99,6 +100,7 @@ properties:
       - qcom,pmm8654au-rpmh-regulators
       - qcom,pmr735a-rpmh-regulators
       - qcom,pmr735b-rpmh-regulators
+      - qcom,pmr735d-rpmh-regulators
       - qcom,pmx55-rpmh-regulators
       - qcom,pmx65-rpmh-regulators
       - qcom,pmx75-rpmh-regulators
@@ -496,6 +498,18 @@ allOf:
       patternProperties:
         "^vdd-l([3-6]|9|1[0-2])-supply$": true
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,pmr735d-rpmh-regulators
+    then:
+      properties:
+        vdd-l1-l2-l5-supply: true
+        vdd-l3-l4-supply: true
+      patternProperties:
+        "^vdd-l[6-7]-supply$": true
+
   - if:
       properties:
         compatible:

-- 
2.25.1


