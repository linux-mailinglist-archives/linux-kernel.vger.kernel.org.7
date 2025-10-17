Return-Path: <linux-kernel+bounces-858508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3BBBEB01E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611C51AE2E08
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D322FE59F;
	Fri, 17 Oct 2025 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="laJoqBTB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F340301034
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760720960; cv=none; b=NFsE8mRjGbKdm4x+8OjTQ7yfNJ68Kz+tGBti1KkAUXFJ9KpzrOuyHWGJYdPZi0jixa9nyKFbcm9Mov9AVOWE/RrwZqYyHpfGr3CY/qWFDBM5eR/mjYfxXjY/AMmGMV6C7oRqPqzN57MGxg+9WBlM62YBg6VYgST43u+l8ibB3Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760720960; c=relaxed/simple;
	bh=sX4EE5hAcefL6V6eBB1BxZA4MnJW4trHfzsuBuA6010=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QR8GNWY6A4rbl1mmxfwHNnPPVKH/7LnUq397n9Empj0lb63Dr+FjeDZnom2R1IkVyENSkgzrqgqaLGr63DvkKGzSTiDRc6Ozeo8yZVvA6zeQyWoi9aa51rnXX5+eY5mElm1Peqg5j23FzxQ261PbFHnnSUXpdGafsvrZa/y2zaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=laJoqBTB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HGrWKF025387
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hqmiSi/EcNgLN8MIHk8p4XKaA97uQpMTNTjFIwpiBBo=; b=laJoqBTB9PkIZxTw
	ybi4CHmMyV/KgAZuFrPtr1TyPbXKBZLIe/DbGLDpfvCxgKtD0HW3jBIepzMBml4Z
	NgnDSNooXb2gPJ4yESpzHUBAboaDMQERVr7p6MRWFfTKJvsEmtGrL52NYGCZsXtj
	AinMl6x28NOOhnTOoDoZEW+LsXJuoBk1xLarj5NKppEBtM4MitIfOKUJ7lOFNrSx
	kym0/7HKdeat1IaDHIn+/Mh10IdjxmMSTpkSzL3OdpxYz12N+bYj+Eb13euUklqI
	uG/b+1uWtklgAomBQSqVaBbbizcFUEoljrlEsgECCYpEIQ/3ILvJAG3JL0U0uUaE
	fg5Wew==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdkn2b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:09:17 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-290e4fade70so7407025ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760720957; x=1761325757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqmiSi/EcNgLN8MIHk8p4XKaA97uQpMTNTjFIwpiBBo=;
        b=fv2igOXmTUaMJ0XiEzJ991ro/O3HF42Gqys23ZygaDIMa14SpPlQH9HBARhGX8twKI
         wVwEFP/KrUbVaeYnLt9FaBMBaCOcZPIgLj9hR2HMitlK4ki3eAFhhX5DI0PXKXKuYHY1
         ZCP7tKolJGurfwtnO6uUMD0sp+28L5iB6bzip2HDsWauk4+4/TawICuCeEiDSd5T3fAF
         c4CZNwWMqVi339EiBxsMHYSnrhhO3mmQ1oiyUKIlV1WK1f0beTrAMhz7MScl2gHMahoL
         wZ6a5o+md0+cM3td3CyL/F9Zctydc/wvqEqlC3jQO+huB533izan04qIP0YMVp1ATUyL
         gutA==
X-Forwarded-Encrypted: i=1; AJvYcCXVkl6aFUoq+pE/TUApL/+mll8rZc+uGW4vNf0pwrcgGeZUbmDXUDUmiz7yz3sUaouk2BUZ+OuVh2dMkos=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC5fqjl4jTsPw9623EocLaqc2uYDiar6RJusUQLCzUUnbM/e9D
	hw9aDPXi10oKbWvfCUP386fRGwS7inqhTQtjeJ6CkD0GTJyYykA4uBgOhZG5Ue2GLbwYVoH+Aym
	4l0VbDV0NakTXN9cdDNO9LDSZJQkg2yqzNaPaFkK+K1QcPNLb26taqgupmrFZtXNcoIY=
X-Gm-Gg: ASbGnct0VUzz0bEHjbomGRA3hPE+JJrhJ6Y/Xkk3mhKh1Eu7pcQ5DN72CB3Iv+Eyy1A
	9FgHb9MeHawW3qzbUvArG+lgn6mqsBAKfeZrQViNk9O+tH2cFdNxV5GkmSmtz1u1U9T1f9MGUbI
	GayrbuMa4Zr+X8n9XaF6TESSmJEU54agcHu6Q8T3KLwdlLkgiiiLk0+w/z8sBPhhcnGtLpoiqdQ
	p5eo6FtpPdSgCSBeF9hRt8qTdUxbj2BJWlKgXExwiyGzNLrRqutM6pW/SVCxVgZsrekeBwPIN+T
	5W1tpOmGxwJ21VgZ4i0TJClxip0Wdd9wOgFjLZIKRWuQ4ncJBaS5rjTUtFRyXynXG+EDDipWb2L
	ezYoB49biyWbUxdvwZvho3PU=
X-Received: by 2002:a17:903:24f:b0:267:a95d:7164 with SMTP id d9443c01a7336-290cba42a8bmr43850945ad.60.1760720956309;
        Fri, 17 Oct 2025 10:09:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECM4Gg19lRFs8Sa1aaNG9GkjYF95qSMpT0D7neC1fOINMo0JSdB6MFdV9osSiN02voYub3Zg==
X-Received: by 2002:a17:903:24f:b0:267:a95d:7164 with SMTP id d9443c01a7336-290cba42a8bmr43850645ad.60.1760720955826;
        Fri, 17 Oct 2025 10:09:15 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471febc6sm173625ad.86.2025.10.17.10.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 10:09:15 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 22:38:31 +0530
Subject: [PATCH 3/6] dt-bindings: display/msm/gmu: Document A612 RGMU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-qcs615-spin-2-v1-3-0baa44f80905@oss.qualcomm.com>
References: <20251017-qcs615-spin-2-v1-0-0baa44f80905@oss.qualcomm.com>
In-Reply-To: <20251017-qcs615-spin-2-v1-0-0baa44f80905@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760720932; l=4163;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=sX4EE5hAcefL6V6eBB1BxZA4MnJW4trHfzsuBuA6010=;
 b=uIKWqinlgjkELumeJO3EaOVUmuZOe6ykmBwI2gz7iZFC2+LOH11T6sTLyL36mUQHk9TNRx3xV
 wVBlBw4BqdOCJNBAURiKsSCeETvn3FwR1OeOEmlmqNNQ6E7rj6PLFHi
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: 8HmgjYluRTevVw21EIycwXI3StUM16pe
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68f2783e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=OspxmFM2CjPT0bdoapIA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 8HmgjYluRTevVw21EIycwXI3StUM16pe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX5754UFMlQMVK
 7/LqKd2OBerOwRu+kKdLISIsY/km4aYf06bB4zVS7dftYE60kha/OHmL+gprwddq5oF8/k0Qwiq
 CMMuCsZO31VH3vW/Kew9+zA+4x210SNUT5rJgguz701CqoDw0LItc7RTwhv0S+onDthUfdZPSTn
 OC5uWuEu/N/ZI/34sYtoTm472PiCQQ9ASSe15V6WJWBIhwJF+8TamqfjDj1/Rso5E1M3JiHvX/r
 B80HJe/3KRTpCoI4qcfB4w8NxQAuVm10TLDqxZQuOaF6I3LfMr+WvKrWY20c8fksYozsBg2n7/r
 CZJcHfaEQW7VwIqccrufWGXKnIu+gNb1kjYZwz2/MnCKy4p+glt3NRgkUF5mBfKMRtBBbFtccSz
 3bPDnwayRzO1CYDYsSS2eAO5QVgW8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

RGMU a.k.a Reduced Graphics Management Unit is a small state machine
with the sole purpose of providing IFPC (Inter Frame Power Collapse)
support. Compared to GMU, it doesn't manage GPU clock, voltage
scaling, bw voting or any other functionalities. All it does is detect
an idle GPU and toggle the GDSC switch. As it doesn't access DDR space,
it doesn't require iommu.

So far, only Adreno 612 GPU has an RGMU core. Document RGMU in the GMU's
schema.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/gmu.yaml       | 98 +++++++++++++++++-----
 1 file changed, 79 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index afc1879357440c137cadeb2d9a74ae8459570a25..a262d41755f09f21f607bf7a1fd567f386595f39 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -26,6 +26,9 @@ properties:
       - items:
           - pattern: '^qcom,adreno-gmu-x[1-9][0-9][0-9]\.[0-9]$'
           - const: qcom,adreno-gmu
+      - items:
+          - const: qcom,adreno-rgmu-612.0
+          - const: qcom,adreno-rgmu
       - const: qcom,adreno-gmu-wrapper
 
   reg:
@@ -45,24 +48,30 @@ properties:
     maxItems: 7
 
   interrupts:
-    items:
-      - description: GMU HFI interrupt
-      - description: GMU interrupt
+    minItems: 2
+    maxItems: 2
 
   interrupt-names:
-    items:
-      - const: hfi
-      - const: gmu
+    oneOf:
+      - items:
+          - const: hfi
+            description: GMU HFI interrupt
+          - const: gmu
+            description: GMU interrupt
+      - items:
+          - const: oob
+            description: GMU OOB interrupt
+          - const: gmu
+            description: GMU interrupt
+
 
   power-domains:
-    items:
-      - description: CX power domain
-      - description: GX power domain
+    minItems: 2
+    maxItems: 3
 
   power-domain-names:
-    items:
-      - const: cx
-      - const: gx
+    minItems: 2
+    maxItems: 3
 
   iommus:
     maxItems: 1
@@ -86,6 +95,44 @@ required:
 additionalProperties: false
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,adreno-rgmu-612.0
+    then:
+      properties:
+        reg:
+          items:
+            - description: Core RGMU registers
+        reg-names:
+          items:
+            - const: gmu
+        clocks:
+          items:
+            - description: GMU clock
+            - description: GPU CX clock
+            - description: GPU AXI clock
+            - description: GPU MEMNOC clock
+            - description: GPU SMMU vote clock
+        clock-names:
+          items:
+            - const: gmu
+            - const: cxo
+            - const: axi
+            - const: memnoc
+            - const: smmu_vote
+        power-domains:
+          items:
+            - description: CX power domain
+            - description: GX power domain
+            - description: VDD_CX power domain
+        power-domain-names:
+          items:
+            - const: cx
+            - const: gx
+            - const: vdd_cx
+
   - if:
       properties:
         compatible:
@@ -313,13 +360,26 @@ allOf:
           items:
             - const: gmu
     else:
-      required:
-        - clocks
-        - clock-names
-        - interrupts
-        - interrupt-names
-        - iommus
-        - operating-points-v2
+      if:
+        properties:
+          compatible:
+            contains:
+              const: qcom,adreno-rgmu
+      then:
+        required:
+          - clocks
+          - clock-names
+          - interrupts
+          - interrupt-names
+          - operating-points-v2
+      else:
+        required:
+          - clocks
+          - clock-names
+          - interrupts
+          - interrupt-names
+          - iommus
+          - operating-points-v2
 
 examples:
   - |

-- 
2.51.0


