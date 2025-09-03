Return-Path: <linux-kernel+bounces-797851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D695AB4163C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD7354890B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C682D9ED8;
	Wed,  3 Sep 2025 07:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WhP6YCn0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5B42D94BC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756884021; cv=none; b=dUmETVoVk75K+siIZXs6vIhZ+oXnOddd+3ziWDz8kLzhPnNcgVUaxMaf7CF663+YUwE2ay0rsalDMu1//ONuVUbgA5iWcsCLtck0pVoV3h/yA4ugfZ528sq5BshBIo3knx/MotGeDbdFFji3B2WTS0+SBwtjCtarY08BwkQyOws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756884021; c=relaxed/simple;
	bh=OqO8tYRqtS5572WtbMixP6NoK2GKv0qjh/+BfhYV+CU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cJyeBFrnQtp74yYWKD61zl+J2VFYv8NuUqQUWW0c3eMaD7eB0b/sbY8Y5lrijXeTZAbh0fapvTES3lrRpCypJt+098PxCTpRMyhA66qdMkRay1Gu+CG+jbsEJJ2Noov8/ZsPhia/Dq2z+x+7TlAB1MyK0KyO9RtWqsdlLJA9X84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WhP6YCn0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5832TBbK012191
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 07:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PR6KqsPCNUM+EZNcWonweXt6CFzY44sPfHX2M7jwd74=; b=WhP6YCn0bkXXOkys
	EFEdGtm70REHJV1emT2YiqfAql4S28V40ku38wqrVS+fWnbF2Db1LAqThyrtw1nz
	dvkzSygM8E9XmT/TMc+mqjYY8q831hCkTv75Y6/NO+XWPVVBd6zK8Cc/wgp/Dd0Y
	lMs4cvXFdBb2texc9SxEz9RaB11usHC7hJHIKW+YH2Oa6cCYJLs5wHl7Yiti1OqB
	5G1rEC6bfwJBRN8D7O9NnJomdiWg6JkW+5DO6ky/byHqpm7lJtE503E2gHgtXF/Z
	EW5uOLbdh0JLGl3urfzT51ncIugEhqPmDlWlNgtqyVU/Np8frLrjhtR0Pov5x09D
	M1Yh1g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fjfx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:20:18 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77250d676b0so815907b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 00:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756884017; x=1757488817;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PR6KqsPCNUM+EZNcWonweXt6CFzY44sPfHX2M7jwd74=;
        b=N0NdzTWeWXn8jsa5h526iNm6klmJ2hBXB+AGtD6o+66uHwLlwzHvUq6NhOG1vrV0zl
         U+y7RcnUSnTjlgl0EW4jgM4JxzZ0YNtjytTTGj/330w859x9GiMs18V4qNEaGbXiDXLL
         j8eBP8QQ40RSxhsA57JGIgZ7BYst290eFmhPssQU/5CgGstb05HeliHoQ98MsKm78qKn
         FMoSfCQ3DeGlBNo92A5Yj2Zcs4sAQwAn4FFsmPQKWIEiVU6HPKemGfa9+LE1PteVrWaG
         8piGBY65tXreJ8k9aQibNvguVS9EDMnJxRJ3xbj9pZJoLw+uE+jJ+srzzn4wNzGFA6S/
         VT9A==
X-Forwarded-Encrypted: i=1; AJvYcCV14/Qf5MdkkXMRbo1r9JJemgzfrHu3+bwtgeTuhvfb8z21/4AhOUPZW0eC3Q/bWUf4/v0WwRKDs4Z9rzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzZKsi+jEe+K9Le6N58FA2peYEdsqx7jt5lrGEXAYKiQq8XaV1
	R1NtG1hh7WQrIwbkwnvKET5S+As0mv4uUGoi6UZ/PM/60BXoxHP3PxS6rc71YRf5jZHZUtRXMfg
	ImvvR1vyEatXGDHeLkks8+8XzoWIhzdCInzshEQszcOf6qDPg5Z7RcC9QsipUnnC8IZo=
X-Gm-Gg: ASbGncseBwPB6bX2L4FSA0wrW8dyxYghg5TQAsFmDA6wtWn2Dkbv8idE3ZkrLDAX3VP
	gDpa63xk5OjvKv/k+KBbl1g/3rDuWkvHGginjlaYLfusKyh6bZe6XC6qTYJ8ZSc7WOP/LNim8oZ
	sdSttg+UvvFxNUjPMkrk0FZAWjpm/GwtJtGNO/5w0CucZDZ5ykrNfLQZ4Vy/tM15LDbo2ZZDlnd
	hX+9ybiCWmwq3MFRdNImjhohkKxVnno42v9JWf9UXLMjQOQan39DszBeDJGzZQbyA53apVOkdu8
	LAJpn7qs88aYRUpjE1owJuHF2NvG4jkz9UkF4yeqJJyBqe1RxI3oTxZpYuGjmEJF
X-Received: by 2002:a05:6a00:138e:b0:76e:7ab9:a239 with SMTP id d2e1a72fcca58-7723c5c841bmr19009905b3a.16.1756884017221;
        Wed, 03 Sep 2025 00:20:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoCKD0QFh/hM1sUteZfm2odrN6P+2cM9K5e1ZRXWq6q8tcAxq9HE3dI/77BQtbZrh4URINKA==
X-Received: by 2002:a05:6a00:138e:b0:76e:7ab9:a239 with SMTP id d2e1a72fcca58-7723c5c841bmr19009871b3a.16.1756884016695;
        Wed, 03 Sep 2025 00:20:16 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b78d7sm15816191b3a.30.2025.09.03.00.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 00:20:16 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 12:49:52 +0530
Subject: [PATCH v5 1/5] dt-bindings: display/msm/gmu: Update Adreno 623
 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-a623-gpu-support-v5-1-5398585e2981@oss.qualcomm.com>
References: <20250903-a623-gpu-support-v5-0-5398585e2981@oss.qualcomm.com>
In-Reply-To: <20250903-a623-gpu-support-v5-0-5398585e2981@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Gaurav Kohli <quic_gkohli@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jie Zhang <quic_jiezh@quicinc.com>,
        Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756884002; l=1928;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=u87CzBgcXsITaBIhArlZrl9vUsN6j2cKpyp8cwIsM1o=;
 b=CiL9c+CxrSxF6MC52aVaGcpBg9TQe2gy4Y8Jxg1eWT61ioWHIbVTfgmwHGthgwBy6xFhNGIuo
 MlZS8xehYqdC431+l2BX2XaNWR5GpZOMBdClLX1Okkx4eDs3yvXlzfR
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfXzMNkdVB7f0dh
 ekPrCZqm1EBGd9OriDIRVAMBabpXqDhyrlDqslpGPjBwu5DhW69kiQqGtUuuZWS5RpiAQvdevwS
 C1pF7o52zccDwBs8tYnhl6zeLh73GgcA8Y4WsvloEhw93I0sTtQ7l36VYV58Mt9/DKVPFzNAEWX
 r93EnBpkThUFic7hqq8q1XnZhOxnQOvKQIXAcFim4vqkeErUw+RpL4Opq5YmMKevu6iRc2OnMjU
 3sl8vHGlhtpnRNWZo6yiMAIhm2/RroSy900hgj+GKLs+0Ksn+pb1qEjRQNSMmAxXs325hvPHkXQ
 FduQSAchgqimQSthzBR8EVoufXysBQ0n4t4r+8lX8RQoT3ZU4MMmZSj8wsPbqxuDONgBIldPSpb
 zuhq1Zun
X-Proofpoint-ORIG-GUID: 9LmR_HAJ-eLklHK-D_3xiMB8ceHEbiqO
X-Proofpoint-GUID: 9LmR_HAJ-eLklHK-D_3xiMB8ceHEbiqO
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b7ec32 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8
 a=Z2Up3Oz-XkvUWgdIv6MA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038

From: Jie Zhang <quic_jiezh@quicinc.com>

Update Adreno 623's dt-binding to remove smmu_clk which is not required
for this GMU.

Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/display/msm/gmu.yaml       | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index 4392aa7a4ffe2492d69a21e067be1f42e00016d8..afc1879357440c137cadeb2d9a74ae8459570a25 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -124,6 +124,40 @@ allOf:
           contains:
             enum:
               - qcom,adreno-gmu-623.0
+    then:
+      properties:
+        reg:
+          items:
+            - description: Core GMU registers
+            - description: Resource controller registers
+            - description: GMU PDC registers
+        reg-names:
+          items:
+            - const: gmu
+            - const: rscc
+            - const: gmu_pdc
+        clocks:
+          items:
+            - description: GMU clock
+            - description: GPU CX clock
+            - description: GPU AXI clock
+            - description: GPU MEMNOC clock
+            - description: GPU AHB clock
+            - description: GPU HUB CX clock
+        clock-names:
+          items:
+            - const: gmu
+            - const: cxo
+            - const: axi
+            - const: memnoc
+            - const: ahb
+            - const: hub
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
               - qcom,adreno-gmu-635.0
               - qcom,adreno-gmu-660.1
               - qcom,adreno-gmu-663.0

-- 
2.50.1


