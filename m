Return-Path: <linux-kernel+bounces-875548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC604C194BC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38045466DFD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79E6320A3C;
	Wed, 29 Oct 2025 08:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CB6oKgrt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hPQGQ3N/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E731E320A23
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727937; cv=none; b=flbU4X6rYiNIaVXPOcCl00U9XM/fyxLzk6pK6LOxhd/Mwrk0jNTEEtTkmWhkL3yOLdABYqIBWOQJPwcG5aXOAB//qBr6aTxF7BzA+LMjCG17vuBRbsTYliXD7vBFbDeH+kj3e9TGK5XAP4tci+ZVC8GF1IPCejBSDLAM4wixAjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727937; c=relaxed/simple;
	bh=0bB3QqeW4bWYz/xWdreXtz7qff69A6lmcFNCfehiC0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KHO/d7dWnUsEofZcSqHjm7stIxTFzfVDnm3OVsvIRsxI8jVcbTe5szjClCTgBVpK98+PNYDGyq5nWmGqx2V09uMf56FUSRDNoUoKGEYBgrBNFCI9j/NLdLjFh5D3cx2G6PBni3c1s5gpzAu96uC5Y75c6/TYMSGhVoRZhdALRc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CB6oKgrt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hPQGQ3N/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4urVs3642861
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	29heOy8Evds5DvvltZ2jgpoWRLNfoPnrGrq3bTaaHbM=; b=CB6oKgrtZqxWTZey
	XuYabHGSp2ZiXTN5i4+oBPibMxAg2PyHOKP7sZtj36rcaRJfXivZghRfrG6RV3Ul
	ndon7518WWl/4uIOy91pcJYAHdNrqUE2cqLhinko9cNZoUhj9NTnzpesxW5yUhnb
	K30GUAd97IOHxNsYlJkkzkx7wFyn3tIauxWYykf+uoeWvZyRT+xPcM7FjwWSRt6f
	cJLSDE7nnDvhaf9N1mYUbmuSAmA11lUKrbMVXKc9phhzRFOXaSxgoLK7aqUtLpBT
	Ae9UUwVL77tzYiAiAgBaralCIQF4fBT5dPauHamJ4QATEOKW8LxL2/IzMCVYTTJ7
	ipiYrw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1hvmh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:52:14 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e8984d8833so317796061cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761727934; x=1762332734; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=29heOy8Evds5DvvltZ2jgpoWRLNfoPnrGrq3bTaaHbM=;
        b=hPQGQ3N/VdCMrl5WNoHLKd563Za2Do1gEj9TWPQOVp+he4Xp3idXYeuEeJN66Im5JZ
         eLZJiEm+kt+zS2YiqUzFVcPG30roAuXI9CHjrWPkgTOKKQosjGlGzk1GaRBK9YakryI5
         IjZq2Kpy4kBFELfGdTDltlPtXA3ylT17V09KDEw45Wr4S2y0pNxxU/azOf6X7QxgRNCW
         smL00ufoGJewXNFgTwfUjIqANqhMNOztVJoob5u7gC5pn761Dfp7Xf6x0IbWTFrdq7Bq
         Gfel1z3KtrV39AhF6NXbrbK7xQhHMbIFVqHfMUaE9ElEOV4e5gqs8PIaMsv2Iy4SzZqy
         nz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761727934; x=1762332734;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29heOy8Evds5DvvltZ2jgpoWRLNfoPnrGrq3bTaaHbM=;
        b=FEi8m2rxGZ0/6uizX/3dzsT0vfW4yGBC78pGEkClCXXbG8xCHNTUz3PoaHO5cKlsvu
         e2NQlP7wF3IyAYG5cSMQK5z3ZKV01NDDypEn9frRmEgMwde8zw9hwbceCOUnVOiJMqZR
         O1Hd76VyEuUWcCTSGj0a5CFYPIjrBoDd+SBQ3ciohI3n6KR+J3ccl2/p2aHDiMfhM5gm
         rfOaV1ZpxMxzA+V+H3u3e1Wqpw1uzE+fopu+KTZbbCuo8YNQKRHA99mb7yaZBn0cwTI8
         Zb1XNXJ8mBW7olXeSpPyncFegHS39RDrdVYjaBRpIsr+inSe5qe4rFc5qkYHrZPzGNRa
         Pf3A==
X-Forwarded-Encrypted: i=1; AJvYcCVUtgoPUA7NuwcQ7Ri/mNVuafctDbJJcHwT2CA/LMW0xPVzaO1zHB9Q8e2O33lAiAJwITv6gkn/OazNb9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEvsY9q6EOj6XsvW1sCMsS3u4WE2dHVjIoUEkKQTv4fg5yvpav
	4YzmEGZwuFN1wTCydNPJn/bCZJxNP0yzyMXJFJpSfD40f1PSIgv/hBO+W90K+1AoyDk1tEO1lRr
	QDXsjfIJgRlDQW1JzyxXDxC+euNsc1014dozswrLdKqZY2i4QHrStFCMfo8Ed98Aq4L0=
X-Gm-Gg: ASbGnctqSRXqFt5+kMZlLcPqvpCYc+rKmVsfQ3kOQeICwpyGvfzhutulaJs6ROMdL21
	R8bvS/WQXDW5AzNbtqDMFPE76RkUEN6z1xSAd9lomKAZEL+lRsjnQ+1ERdmqK0a2jHOYdgEz2VM
	A2iJw7dewrqvL8lFJ6D97ZrdoZwUXo1YCyTKVdIMvS7M2R2Uw8zWtFqhTJbZoEEigfw6MUDWXz6
	fWqpvHzJv2NPfGBWe87adrvEbl2KqOIO7TOuZ/cHTsB3UMqlQkYmPvFeFIkLFpNOZfcP2z+62sU
	UrmnU7i5lTwEZgx2yQP4B2qPaJC0QOJE8/ymxsgFC009/QRaOmnRU8GKCIxgBYPhr1E0ypVuejo
	x+2peFos16dNeldCNwwHfPmc=
X-Received: by 2002:a05:622a:1a1e:b0:4eb:a2f0:356d with SMTP id d75a77b69052e-4ed15c2ad04mr29285371cf.84.1761727933713;
        Wed, 29 Oct 2025 01:52:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIK628hRRJ0GtENaQ8WRZSM3uBToMy/ANa6nahU9CcTzLDhjqWx1sd3SP66pa0UxopSXpvJw==
X-Received: by 2002:a05:622a:1a1e:b0:4eb:a2f0:356d with SMTP id d75a77b69052e-4ed15c2ad04mr29285061cf.84.1761727933259;
        Wed, 29 Oct 2025 01:52:13 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed0817602dsm36760171cf.18.2025.10.29.01.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:52:13 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 16:51:36 +0800
Subject: [PATCH v13 3/5] dt-bindings: display/msm: Document MDSS on QCS8300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-qcs8300_mdss-v13-3-e8c8c4f82da2@oss.qualcomm.com>
References: <20251029-qcs8300_mdss-v13-0-e8c8c4f82da2@oss.qualcomm.com>
In-Reply-To: <20251029-qcs8300_mdss-v13-0-e8c8c4f82da2@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
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
        Konrad Dybcio <konradybcio@kernel.org>,
        Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761727898; l=10307;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=0bB3QqeW4bWYz/xWdreXtz7qff69A6lmcFNCfehiC0w=;
 b=U+Hv/MwDUuiDZ91JXeUgU2+IJ1N2ge58JK0fgPXiSUPfT6wSPqPbABogQoCAG8/y/+njlJNNA
 fT4FrlChGLjCJkL/dbMR51GfNo0w23U5JzdHOoMVo8/Ui1BDZbtOro5
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=dbiNHHXe c=1 sm=1 tr=0 ts=6901d5be cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=xy87eLYBKWInB6EY41QA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 79f3aNIwW3Ubcpl6AyWUKHB-KAmbJ9bk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA2NSBTYWx0ZWRfXyXR//jrljL/2
 DOBgAlmhUxRjwJRwmRvHtJGPeNQlfQJt5uV18wmgofrjrxONWoOjnjMvVVx8gf8ov4SHQ3Gh965
 scUYtl31z6CIgCGQvYKHAm5tE0YTRWWQ2wthQx2a4HhftH/OxDh45eBplrCLKTt3byCHYXEK+6+
 JTPIqcouzOpE4uzjzrTInV+h+bWN4Rzo1JLjmLve5iz1i8HNdHIp82fKzAiJ0aXucBbisswKXlf
 H9AyedW318QnDsBvu8GDQxIo6/HjzReVPUzSw2L0s9z9SpoZuS2FrI1g/O6f1OPwqOn9gWXwZ6p
 oatyw/JEZ70+squRcJRhXc22ELD0uVPam//e4RmRDJVLUrnSusFz6UCpjjObMctyE9gDypa3PGe
 koP1xwJQNma1MvrPUSSSk21XRQ0fyw==
X-Proofpoint-GUID: 79f3aNIwW3Ubcpl6AyWUKHB-KAmbJ9bk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290065

Document the MDSS hardware found on the Qualcomm QCS8300 platform.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 .../bindings/display/msm/qcom,qcs8300-mdss.yaml    | 286 +++++++++++++++++++++
 1 file changed, 286 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcs8300-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcs8300-mdss.yaml
new file mode 100644
index 000000000000..e96baaae9ba9
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcs8300-mdss.yaml
@@ -0,0 +1,286 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/msm/qcom,qcs8300-mdss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. QCS8300 Display MDSS
+
+maintainers:
+  - Yongxing Mou <yongxing.mou@oss.qualcomm.com>
+
+description:
+  QCS8300 MSM Mobile Display Subsystem(MDSS), which encapsulates sub-blocks like
+  DPU display controller, DP interfaces and EDP etc.
+
+$ref: /schemas/display/msm/mdss-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,qcs8300-mdss
+
+  clocks:
+    items:
+      - description: Display AHB
+      - description: Display hf AXI
+      - description: Display core
+
+  iommus:
+    maxItems: 1
+
+  interconnects:
+    maxItems: 3
+
+  interconnect-names:
+    maxItems: 3
+
+patternProperties:
+  "^display-controller@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        contains:
+          const: qcom,qcs8300-dpu
+
+  "^displayport-controller@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        contains:
+          const: qcom,qcs8300-dp
+
+  "^phy@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        contains:
+          const: qcom,qcs8300-edp-phy
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interconnect/qcom,icc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/qcom,qcs8300-gcc.h>
+    #include <dt-bindings/clock/qcom,sa8775p-dispcc.h>
+    #include <dt-bindings/interconnect/qcom,qcs8300-rpmh.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    mdss: display-subsystem@ae00000 {
+        compatible = "qcom,qcs8300-mdss";
+        reg = <0x0ae00000 0x1000>;
+        reg-names = "mdss";
+
+        interconnects = <&mmss_noc MASTER_MDP0 QCOM_ICC_TAG_ACTIVE_ONLY
+                         &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+                        <&mmss_noc MASTER_MDP1 QCOM_ICC_TAG_ACTIVE_ONLY
+                         &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+                        <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+                         &config_noc SLAVE_DISPLAY_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+        interconnect-names = "mdp0-mem",
+                             "mdp1-mem",
+                             "cpu-cfg";
+
+        resets = <&dispcc_core_bcr>;
+        power-domains = <&dispcc_gdsc>;
+
+        clocks = <&dispcc_ahb_clk>,
+                 <&gcc GCC_DISP_HF_AXI_CLK>,
+                 <&dispcc_mdp_clk>;
+
+        interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+
+        iommus = <&apps_smmu 0x1000 0x402>;
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        display-controller@ae01000 {
+            compatible = "qcom,qcs8300-dpu", "qcom,sa8775p-dpu";
+            reg = <0x0ae01000 0x8f000>,
+                  <0x0aeb0000 0x2008>;
+            reg-names = "mdp", "vbif";
+
+            clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_AHB_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_MDP_LUT_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_MDP_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_VSYNC_CLK>;
+            clock-names = "nrt_bus",
+                          "iface",
+                          "lut",
+                          "core",
+                          "vsync";
+
+            assigned-clocks = <&dispcc0 MDSS_DISP_CC_MDSS_VSYNC_CLK>;
+            assigned-clock-rates = <19200000>;
+            operating-points-v2 = <&mdp_opp_table>;
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
+
+            interrupt-parent = <&mdss>;
+            interrupts = <0>;
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                port@0 {
+                    reg = <0>;
+
+                    dpu_intf0_out: endpoint {
+                         remote-endpoint = <&mdss_dp0_in>;
+                    };
+                };
+            };
+
+            mdp_opp_table: opp-table {
+                compatible = "operating-points-v2";
+
+                opp-375000000 {
+                    opp-hz = /bits/ 64 <375000000>;
+                    required-opps = <&rpmhpd_opp_svs_l1>;
+                };
+
+                opp-500000000 {
+                    opp-hz = /bits/ 64 <500000000>;
+                    required-opps = <&rpmhpd_opp_nom>;
+                };
+
+                opp-575000000 {
+                    opp-hz = /bits/ 64 <575000000>;
+                    required-opps = <&rpmhpd_opp_turbo>;
+                };
+
+                opp-650000000 {
+                    opp-hz = /bits/ 64 <650000000>;
+                    required-opps = <&rpmhpd_opp_turbo_l1>;
+                };
+            };
+        };
+
+        mdss_dp0_phy: phy@aec2a00 {
+            compatible = "qcom,qcs8300-edp-phy", "qcom,sa8775p-edp-phy";
+
+            reg = <0x0aec2a00 0x200>,
+                  <0x0aec2200 0xd0>,
+                  <0x0aec2600 0xd0>,
+                  <0x0aec2000 0x1c8>;
+
+            clocks = <&dispcc MDSS_DISP_CC_MDSS_DPTX0_AUX_CLK>,
+                     <&dispcc MDSS_DISP_CC_MDSS_AHB_CLK>;
+            clock-names = "aux",
+                          "cfg_ahb";
+
+            #clock-cells = <1>;
+            #phy-cells = <0>;
+
+            vdda-phy-supply = <&vreg_l1c>;
+            vdda-pll-supply = <&vreg_l4a>;
+        };
+
+        displayport-controller@af54000 {
+            compatible = "qcom,qcs8300-dp", "qcom,sa8775p-dp";
+
+            pinctrl-0 = <&dp_hot_plug_det>;
+            pinctrl-names = "default";
+
+            reg = <0xaf54000 0x104>,
+                  <0xaf54200 0x0c0>,
+                  <0xaf55000 0x770>,
+                  <0xaf56000 0x09c>,
+                  <0xaf57000 0x09c>,
+                  <0xaf58000 0x09c>,
+                  <0xaf59000 0x09c>,
+                  <0xaf5a000 0x23c>,
+                  <0xaf5b000 0x23c>;
+
+            interrupt-parent = <&mdss>;
+            interrupts = <12>;
+            clocks = <&dispcc0 MDSS_DISP_CC_MDSS_AHB_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_AUX_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_LINK_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL0_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL1_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL2_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL3_CLK>;
+            clock-names = "core_iface",
+                          "core_aux",
+                          "ctrl_link",
+                          "ctrl_link_iface",
+                          "stream_pixel",
+                          "stream_1_pixel",
+                          "stream_2_pixel",
+                          "stream_3_pixel";
+            assigned-clocks = <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
+                              <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>,
+                              <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC>,
+                              <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL2_CLK_SRC>,
+                              <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL3_CLK_SRC>;
+            assigned-clock-parents = <&mdss_dp0_phy 0>,
+                                     <&mdss_dp0_phy 1>,
+                                     <&mdss_dp0_phy 1>,
+                                     <&mdss_dp0_phy 1>;
+            phys = <&mdss_dp0_phy>;
+            phy-names = "dp";
+            operating-points-v2 = <&dp_opp_table>;
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
+
+            #sound-dai-cells = <0>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    mdss_dp0_in: endpoint {
+                        remote-endpoint = <&dpu_intf0_out>;
+                    };
+                };
+
+                port@1 {
+                   reg = <1>;
+
+                   mdss_dp_out: endpoint { };
+                };
+            };
+
+            dp_opp_table: opp-table {
+                compatible = "operating-points-v2";
+
+                opp-160000000 {
+                    opp-hz = /bits/ 64 <160000000>;
+                    required-opps = <&rpmhpd_opp_low_svs>;
+                };
+
+                opp-270000000 {
+                    opp-hz = /bits/ 64 <270000000>;
+                    required-opps = <&rpmhpd_opp_svs>;
+                };
+
+                opp-540000000 {
+                    opp-hz = /bits/ 64 <540000000>;
+                    required-opps = <&rpmhpd_opp_svs_l1>;
+                };
+
+                opp-810000000 {
+                    opp-hz = /bits/ 64 <810000000>;
+                    required-opps = <&rpmhpd_opp_nom>;
+                };
+            };
+        };
+    };
+...

-- 
2.43.0


