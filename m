Return-Path: <linux-kernel+bounces-730115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F682B04067
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CFAF3AD463
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAD3253F14;
	Mon, 14 Jul 2025 13:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QV6u55Wu"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DDF24DCEF
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752500492; cv=none; b=oJY0ipkqtv1TSKDNgs5JyLDgGl1mU2oOOLjd8p/S2zgZt0MAcxejN2/MF22L/UttM1IMPXmVWpd6wdZiIE6np0JCcwYlJXgJypE9pOfufcuYlQQNd5o1HjtTS4em4kvto/mpkdsAtOyzPGnwvTIJNAhL+1mrqMh7GkTS0fZ9qOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752500492; c=relaxed/simple;
	bh=N0FiLOa/kCeu/NHGrIPyU79z0X8zCwU1KG+xS+vfyYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qh8cJ1n93AxoRtcpnZwnZRtvSK79mjKdaMxsXdYD+tsl9cxm5UIEUs3rXd7nHMmW3S612lQmuC0AGfjHXIPQq4mTcQ2c0cZQMFNMm5og/n3H8h03XloDEix8xrpW1kWst9h/HEaebOfO1l2ddLpz3BbVouRk+R/Cv+raEhhwFN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QV6u55Wu; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-456133b8d47so1379855e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752500488; x=1753105288; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N3lTuIh5S1FYvkQ1ZLooc79sNOGjgNo0+8qWLqGThgk=;
        b=QV6u55Wugnt59OWtvNc9f3gtvm9FCLJL2tiefrBBBe/ozOblVk50Gd5xIly7f2D0Uo
         GAqJNVuko0Ecj4GB6Q+omTTQNxnh6GLIh5XkuEcvE39sE7loLddbWNbWv7IEAsIWgTFx
         S51yR4llA2sP959ZBhUTSo46t9WnO6vdDHw8SQ+w5yE+rCsJ26SNgQK3MuxVtLbxxG5E
         f0uQQd7enmN755gQUzGMhCldCQBdkcTxATgo6kmQ66LeoE9Av+rAcuT6n6lpym2lyXoX
         VvrP2NZ9fAFexDmJLWlbwaP3YCSn1+A+soFJ5PV1LceQu90oRnwx24Y4jDquUR/DHWq8
         W3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752500488; x=1753105288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3lTuIh5S1FYvkQ1ZLooc79sNOGjgNo0+8qWLqGThgk=;
        b=LG0Fft8CBTIRr5qrtQyOp7xwy/yu94sDywtk3+RfFuxpxIcxLEO/lo/Lv2D8EXCdyL
         fhZo0bh0uT9+xG+qkEy1bNDSLBlu3pNOXr44dUDOgkB/j3aGLoOOJWz8IKAA0MWA1cmo
         K9Nv5UjVOSEbHdVS9MSaPIriC641T68FDleibZwN7glgnTipAgvvitq6zT61toY6MDRy
         iDKFgfECzOzsu0MAntvbPs/Z6id7ITn4oVriITe1EEryhyVc99yo/VFMjI3Cn76ceeyZ
         3mcUH9poV4x0Q9X5TxEpPqOmEze1+hrrotPwYsKmLUjeyQ+/PjqV3N1D/SJTtq78Vv8z
         Gg/A==
X-Forwarded-Encrypted: i=1; AJvYcCWJ4rAsyvjbcZOcvbSd/bPJ2KrptIkp3ibPJhw6SIIfW0E4ZKALRxh5eyoHGhnbXOL0d/NV7dufc8fq4bM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuCacK8UAp6/5RcCQXnOF5oMnckHtlF+HRWWJQQXbqNEKik6EY
	venqM6DejbiXUkbf+rAhW9MnQyCcBZpe9WhN8XnnwXaVYrw5jS1HGKGVb95ctaVEEnU=
X-Gm-Gg: ASbGncvWwpkXChduu8QiJmGY7VLWa+umXlHsl2OP0cQQ7KRc0w3oUzSap/mZsA5QdPS
	wqSRVNU1X025XxXzHPcOAZTkg+XBdDK0aPt2s93sG1CnykFcgL0XhpHHB7CUlHSawKfhi+nzfOd
	l0KkparTzQl7q99a69SjirvDW/6Skgy/POdYpclE+3F/us5XB2rNb2XfpLcVqvzj5H2iMauMcht
	L6whaRwfQSLjZUSGP4dO21QwSeLcV/+rCKP6uIuMx+hGG3d9NFeVCg2E1/Q77ygsjFHvs8fCdUz
	VP//7WWyX3+JlwWue+HJxPYnD1e65jrWD5DHhxzgexyC1psbo+BX45KnWxw1rLHVjkz55YG2uCB
	0s2BjDK9j/v4PIUG2xFZ+V+85dPx3gPWHynhB
X-Google-Smtp-Source: AGHT+IH/77wC4xERgT8TAu9P3Ccruj4NUXxcgbWHiYjWBnWtXjpKgbx1wOWS/M5as07m/W20VeF+2g==
X-Received: by 2002:a05:600c:a282:b0:43b:c844:a4ba with SMTP id 5b1f17b1804b1-4556f8ab34dmr32154685e9.3.1752500487677;
        Mon, 14 Jul 2025 06:41:27 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4561b176f87sm31371375e9.35.2025.07.14.06.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 06:41:27 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 14 Jul 2025 15:41:16 +0200
Subject: [PATCH 1/3] media: dt-bindings: qcom,sm8550-iris: Add SM8750 video
 codec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-sm8750-iris-v1-1-3006293a5bc7@linaro.org>
References: <20250714-sm8750-iris-v1-0-3006293a5bc7@linaro.org>
In-Reply-To: <20250714-sm8750-iris-v1-0-3006293a5bc7@linaro.org>
To: Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Dikshita Agarwal <quic_dikshita@quicinc.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6219;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=N0FiLOa/kCeu/NHGrIPyU79z0X8zCwU1KG+xS+vfyYI=;
 b=kA0DAAoBwTdm5oaLg9cByyZiAGh1CQKiOm+mc5Q+Va+s3HmFSNGF5yoCEIUFNlmbMDGhPpsqw
 IkCMwQAAQoAHRYhBN3SYig9ERsjO264qME3ZuaGi4PXBQJodQkCAAoJEME3ZuaGi4PXbWQQAID+
 xZCeBSMm+EMQ8CIDDCSkQ7/DStICm4MCpBI5Iu9fQTTRFH4EIka6D3HSFweyVPmdRrQYy01QMms
 R35U3A2jMd3AH5wr4aVym1J3Aa6yzfY30Mjm8PiwfhJpKSPdd+o614P5sVrbaaRAcHoIvnyp5Ij
 3PT1MbrDwocUa6grgzOBbaBDvssM0xRV+KSWdKdpoKhy0i+RH3k1neyTEBJddJ8DPfjfXSzNyYD
 cFbRlGScipOCN+Q3PZvAETgbfqmHmxLH/DLrDfQt5WHXLBmYHNNRL4ThKCKhMrPN+pb//cxh5++
 JgaQ/KymDH5+ojRCjVjVw2TkXfv8JMEUSLn7Yh82+ryCILJ4y2KqGQjDt8/orBkhB+sCESBexhu
 4Dsa2eV+yR4qczGaBzWHSOB3INFvqtJx6l4JxlkTstO+6j47ZtSCNNjn8ungwNm/DrOZ1ftwumV
 WmXmx1rPo8/HwxBO+wUcicoO4d4Px+t/z4v+Tq6LaGHElfDSRddLJhyB36ZEG+P0AcmAL6ywq4+
 /JGiTuOR93nnnCDpayfsnpq6YQcEy35KuRniORJ4YT1sRb15uJz/WOtfRSFFH9+pW42fUfHbATO
 dpg4IL1O85wjWrNld0YO84pOVJ5Zjn3iExT9Bvqw8zSXuYTf1DOcfOR+FI8g4wDU/JxFAau/4eL
 frwXp
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add binding for Qualcom SM8750 Iris video codec, which comes with
significantly different powering up sequence than previous SM8650, thus
different clocks and resets.  For consistency keep existing clock and
clock-names naming, so the list shares common part.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/media/qcom,sm8750-iris.yaml           | 186 +++++++++++++++++++++
 1 file changed, 186 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/qcom,sm8750-iris.yaml b/Documentation/devicetree/bindings/media/qcom,sm8750-iris.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..e767ebae7c4022d406d61a7bf606b8d878d8632e
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/qcom,sm8750-iris.yaml
@@ -0,0 +1,186 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/qcom,sm8750-iris.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM8750 SpC Iris video encoder and decoder
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  The Iris video processing unit on Qualcomm SM8750 SoC is a video encode and
+  decode accelerator.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm8750-iris
+
+  clocks:
+    maxItems: 6
+
+  clock-names:
+    items:
+      - const: iface          # AXI0
+      - const: core
+      - const: vcodec0_core
+      - const: iface1         # AXI1
+      - const: core_freerun
+      - const: vcodec0_core_freerun
+
+  dma-coherent: true
+
+  interconnects:
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: cpu-cfg
+      - const: video-mem
+
+  iommus:
+    maxItems: 2
+
+  operating-points-v2: true
+  opp-table:
+    type: object
+
+  power-domains:
+    maxItems: 4
+
+  power-domain-names:
+    items:
+      - const: venus
+      - const: vcodec0
+      - const: mxc
+      - const: mmcx
+
+  resets:
+    maxItems: 4
+
+  reset-names:
+    items:
+      - const: bus0
+      - const: bus1
+      - const: core
+      - const: vcodec0_core
+
+required:
+  - compatible
+  - dma-coherent
+  - interconnects
+  - interconnect-names
+  - iommus
+  - power-domain-names
+  - resets
+  - reset-names
+
+allOf:
+  - $ref: qcom,venus-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/clock/qcom,sm8750-gcc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interconnect/qcom,icc.h>
+    #include <dt-bindings/interconnect/qcom,sm8750-rpmh.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
+
+    video-codec@aa00000 {
+        compatible = "qcom,sm8750-iris";
+        reg = <0x0aa00000 0xf0000>;
+
+        clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
+                 <&videocc_mvs0c_clk>,
+                 <&videocc_mvs0_clk>,
+                 <&gcc GCC_VIDEO_AXI1_CLK>,
+                 <&videocc_mvs0c_freerun_clk>,
+                 <&videocc_mvs0_freerun_clk>;
+        clock-names = "iface",
+                      "core",
+                      "vcodec0_core",
+                      "iface1",
+                      "core_freerun",
+                      "vcodec0_core_freerun";
+
+        dma-coherent;
+        iommus = <&apps_smmu 0x1940 0>,
+                 <&apps_smmu 0x1947 0>;
+
+        interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+                         &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
+                        <&mmss_noc MASTER_VIDEO_MVP QCOM_ICC_TAG_ALWAYS
+                         &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+        interconnect-names = "cpu-cfg",
+                             "video-mem";
+
+        interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+
+        operating-points-v2 = <&iris_opp_table>;
+
+        memory-region = <&video_mem>;
+
+        power-domains = <&videocc_mvs0c_gdsc>,
+                        <&videocc_mvs0_gdsc>,
+                        <&rpmhpd RPMHPD_MXC>,
+                        <&rpmhpd RPMHPD_MMCX>;
+        power-domain-names = "venus",
+                             "vcodec0",
+                             "mxc",
+                             "mmcx";
+
+        resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>,
+                 <&gcc GCC_VIDEO_AXI1_CLK_ARES>,
+                 <&videocc_mvs0c_freerun_clk_ares>,
+                 <&videocc_mvs0_freerun_clk_ares>;
+        reset-names = "bus0",
+                      "bus1",
+                      "core",
+                      "vcodec0_core";
+
+        iris_opp_table: opp-table {
+            compatible = "operating-points-v2";
+
+            opp-240000000 {
+                opp-hz = /bits/ 64 <240000000>;
+                required-opps = <&rpmhpd_opp_low_svs_d1>,
+                                <&rpmhpd_opp_low_svs_d1>;
+            };
+
+            opp-338000000 {
+                opp-hz = /bits/ 64 <338000000>;
+                required-opps = <&rpmhpd_opp_low_svs>,
+                                <&rpmhpd_opp_low_svs>;
+            };
+
+            opp-420000000 {
+                opp-hz = /bits/ 64 <420000000>;
+                required-opps = <&rpmhpd_opp_svs>,
+                                <&rpmhpd_opp_svs>;
+            };
+
+            opp-444000000 {
+                opp-hz = /bits/ 64 <444000000>;
+                required-opps = <&rpmhpd_opp_svs_l1>,
+                                <&rpmhpd_opp_svs_l1>;
+            };
+
+            opp-533333334 {
+                opp-hz = /bits/ 64 <533333334>;
+                required-opps = <&rpmhpd_opp_nom>,
+                                <&rpmhpd_opp_nom>;
+            };
+
+            opp-630000000 {
+                opp-hz = /bits/ 64 <630000000>;
+                required-opps = <&rpmhpd_opp_turbo>,
+                                <&rpmhpd_opp_turbo>;
+            };
+        };
+    };

-- 
2.43.0


