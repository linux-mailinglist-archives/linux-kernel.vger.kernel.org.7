Return-Path: <linux-kernel+bounces-868508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AB1C055C0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2031A088E7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0322830BF4B;
	Fri, 24 Oct 2025 09:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ngGz33Cm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA18307AEE
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761298420; cv=none; b=e9AjsS6MztUliKZp4OWZ64IdKm7brBTHnQ6r1L8WrZnB5AfXkwxtNZYF9apYxX49CDO59/ZCjxwy8+I/o5tE3P5A8NApisT4DO6/tfVeBDvF0GeAVevVzd2y4suaS/ClJ3OL6RKNC6DalQboNnl8yXHhuxrc/4vsHUnkjGLhdHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761298420; c=relaxed/simple;
	bh=aJDb+NHHQuno7cwN3CiGpg2o/Y516jxogFCrK6JxNqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IA7GFWOGVDIwmUwNXSiFnbCrsAwm4oV7Rtwsvhv6vSbbaKXix/88Fa09VgLKhhkke74e9r+XY6PicrpWSE+6O5RF3JiZ+7CtaaDzIXSWKyXvscXQb7V1MqLsaQKZyaWnf6ZtYxXhoPHL0A5XbtYmsEIZ8n0P3MwOtGBLOBs7cMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ngGz33Cm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3FGC5015821
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ub5W/Kkbd1Alzx9NyyOxlMByJyQ868SAcsxXG1ockE0=; b=ngGz33CmGIhxfsox
	Q+6NcNAs9csb+0UcCu31rU9S0WU+h+DWDinuCJ69B4JYRGr7ReBBsbTl2QzBVgUE
	IIwu3kTwFim5zEHDenRViJ/2b4UdGbKbJoUsEzzSNhHyliYqNTMZIyUUwsEfZSs1
	pM6RK0xlZwWvSoZ6aFEVbkvqKTIrcZCPEVndUHTV/UdaWOSYd1v72aXIrK2x7LyP
	f0cTm8W/BgML4Ia6etKj/dSSllWYLYcv2mhW11Arclog4BQRbzzkXdirvTsPTxkc
	NlE3QS2o7xAO71qgEwLaQXdmnfEBeRCOKaxrVVJ2Lzl9KolgRkQ45w1/8cqiZNwQ
	tAHFlw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xkpsh56q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:33:37 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7900f597d08so1389335b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761298416; x=1761903216;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ub5W/Kkbd1Alzx9NyyOxlMByJyQ868SAcsxXG1ockE0=;
        b=mb4vhuNe4NKsSMGQmf9BvbbxYsVbtY0wpBiPFV68V9JLLdQfVg+LBsg2UmYh4Uf+qU
         0FVNf8eElaBqCKxZ+udXTnI7z9wkX4+Hd1Sr+1K1F9Xo+9H+/ucBIJd3jC8DMYlcF+g0
         rFdndFyYrGtN+Q0H7IP14T1GUzPM5ZHAQ1kNWKn09xp8HieAnCkeVV6gRt6OsxHAJAPl
         40p77fKCVRQNGkNaKO40eQ1cOdoyZkq9X9Ql2uiS0NKBE7dMA6QYc6VnmCLA0QYL/du/
         Rum0RGK3WMhhkyD2zdSvVYJi7DE/wyyUxfLrd3/Lx+89a5fvaGWP1j+NEBKnEvpeWDM1
         h+jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhmXN4UbBWUqQn2oJsPU8ksztxmK4dgfhv6aN64H8QbXjN0WqmiOSmcNdW+kt+jmflKW0PeCuNKW8REi4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ws/fxeR6SJPZkt6Yjjdi0PD5bsyTgZXIRGsgTm4S+cxy8F9u
	vIdTJMF4zc+buqlVTi54FFDiDcCpOjQ5jem27U6fdIda2W4Wphj7/10rWYONvOLfGWCU1qhG4mS
	dPTcPFpfGlGm5eiLpQwvhCBGT+BE216rqXzFXUgPEJ1pd/Vs6c8jVcYcQrEG2pjHfZzA47plC/Y
	w=
X-Gm-Gg: ASbGnctFXfSwDzi7YqfjSp3GJa5X1wv6TaYDGXHzN0dpW2nVskC9mkDBCAc7EaOO/62
	TjDzSAyam0gtqyNldjXK2PfdVDtT5fpKKjyDLbgOS/ZPpmIeLUC+9SG/JiM+w7yYT6bIoypHdYs
	tod80p0LOCal9CdeFRYQzPLUkRk38dDx826IVFgqmWWDZnOMVEEu6e6gyWo9z+wjNiyCgLZdE9D
	eGpt9bzInrdjZocbyWGAYWrZZl7rvXKQ2ipCXf7oJJ6rKDZIpKboweYvtpx+tSC4d6vdvnLzpQZ
	b3c6dvmhQRsUqxwzz2aUqDPzp1qZmquzVuXtFVvl6U9JTKCE+CJN+kGSRsQz7wCPSq8QvFMV60+
	KbsxZZoPTkSML0+SI+PICT/smeGHcYMnRdQ==
X-Received: by 2002:a05:6a00:26d6:b0:7a2:6e61:c2a4 with SMTP id d2e1a72fcca58-7a26e61c50cmr7606567b3a.18.1761298416102;
        Fri, 24 Oct 2025 02:33:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3lz4HxbH9WXF2OdylXm8XVAgL+lrYMWY4oLNzS+JocMh0r8Y5PYPpgSPgMekzxEa8glMGtA==
X-Received: by 2002:a05:6a00:26d6:b0:7a2:6e61:c2a4 with SMTP id d2e1a72fcca58-7a26e61c50cmr7606529b3a.18.1761298415568;
        Fri, 24 Oct 2025 02:33:35 -0700 (PDT)
Received: from hu-jprakash-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274dc33easm5270332b3a.68.2025.10.24.02.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 02:33:35 -0700 (PDT)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 15:03:22 +0530
Subject: [PATCH v3 2/3] dt-bindings: spmi: add support for
 glymur-spmi-pmic-arb (arbiter v8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-pmic_arb_v8-v3-2-cad8d6a2cbc0@oss.qualcomm.com>
References: <20251024-pmic_arb_v8-v3-0-cad8d6a2cbc0@oss.qualcomm.com>
In-Reply-To: <20251024-pmic_arb_v8-v3-0-cad8d6a2cbc0@oss.qualcomm.com>
To: Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Collins <david.collins@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        aiqun.yu@oss.qualcomm.com, kamal.wadhwa@oss.qualcomm.com,
        jingyi.wang@oss.qualcomm.com,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761298404; l=5722;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=aJDb+NHHQuno7cwN3CiGpg2o/Y516jxogFCrK6JxNqA=;
 b=crW6gL8X14t7FzTo6LkrNkMHJnC+2Hfrusd048oxV6OixqVXcbj7/cM67CRNUelVk74M0UdDl
 aYN5OHKf4uDC3dICNg3qachNWM4qZaM1jl7KUhIZjTm5UF7Jxbcn/YK
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE5MCBTYWx0ZWRfXyUDX56qGcbkW
 K4p3GMMcbNWlZWmwCZ6ODDScCQfGmDXgC8uQ4nuG+36sXyZFq8cUS0clNuGdHyvaYJVwTFQPITN
 ziPCbpd3cWuu2I0sWBln1qcP9+FzMY1PyBQeRA+PxQKvirR9k+WPoH/JcI/15EUZtMIM4ENUG9O
 +9UuYmRir38L18gT2iQ/8srDVEha8KldiOBmW3gCXe4YPUzGdi0KgfH8JNnEDfr8s0xkLYZo9Xp
 G5doSffeGYE216nYUsvxamdsmPC8kp/0YJ+1XAW2htbxeYlwAOi/BzALfYlXDJer/WqJoMqmGFo
 P0E/ujZzMKJVBzlCi9eGLUW+d9fo0rm2gm5v45ETqdDq2NkuUYnqxKPeWW0lbzwLJ9idy8eJnkZ
 uQ4qNuK1k3KWEN+DEacqwuXY+TwO1g==
X-Authority-Analysis: v=2.4 cv=FbM6BZ+6 c=1 sm=1 tr=0 ts=68fb47f1 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=t41Tp4pyULMMg2XcS3IA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: wgno6AcPvOSlZr-ZdDebBQEMZ49GQNVl
X-Proofpoint-ORIG-GUID: wgno6AcPvOSlZr-ZdDebBQEMZ49GQNVl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510210190

SPMI PMIC Arbiter version 8 builds upon version 7 with support for
up to four SPMI buses.  To achieve this, the register map was
slightly rearranged.  Add a new binding file and compatible string
for version 8 using the name 'glymur' as the Qualcomm Technologies,
Inc. Glymur SoC is the first one to use PMIC arbiter version 8.  This
specifies the new register ranges needed only for version 8.

Also document SPMI PMIC Arbiter for Qualcomm Kaanapali SoC, by adding
fallback to Glymur compatible string, as it too has version 8
functionality.

Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
 .../bindings/spmi/qcom,glymur-spmi-pmic-arb.yaml   | 150 +++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/Documentation/devicetree/bindings/spmi/qcom,glymur-spmi-pmic-arb.yaml b/Documentation/devicetree/bindings/spmi/qcom,glymur-spmi-pmic-arb.yaml
new file mode 100644
index 000000000000..3b5005b96c6d
--- /dev/null
+++ b/Documentation/devicetree/bindings/spmi/qcom,glymur-spmi-pmic-arb.yaml
@@ -0,0 +1,150 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spmi/qcom,glymur-spmi-pmic-arb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. Glymur SPMI Controller (PMIC Arbiter v8)
+
+maintainers:
+  - David Collins <david.collins@oss.qualcomm.com>
+
+description: |
+  The Glymur SPMI PMIC Arbiter implements HW version 8 and it's an SPMI
+  controller with wrapping arbitration logic to allow for multiple on-chip
+  devices to control up to 4 SPMI separate buses.
+
+  The PMIC Arbiter can also act as an interrupt controller, providing interrupts
+  to slave devices.
+
+allOf:
+  - $ref: /schemas/spmi/qcom,spmi-pmic-arb-common.yaml
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - qcom,kaanapali-spmi-pmic-arb
+          - const: qcom,glymur-spmi-pmic-arb
+      - enum:
+          - qcom,glymur-spmi-pmic-arb
+
+  reg:
+    items:
+      - description: core registers
+      - description: tx-channel per virtual slave registers
+      - description: rx-channel (called observer) per virtual slave registers
+      - description: channel to PMIC peripheral mapping registers
+
+  reg-names:
+    items:
+      - const: core
+      - const: chnls
+      - const: obsrvr
+      - const: chnl_map
+
+  ranges: true
+
+  '#address-cells':
+    const: 2
+
+  '#size-cells':
+    const: 2
+
+patternProperties:
+  "^spmi@[a-f0-9]+$":
+    type: object
+    $ref: /schemas/spmi/spmi.yaml
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        items:
+          - description: configuration registers
+          - description: interrupt controller registers
+          - description: channel owner EE mapping registers
+
+      reg-names:
+        items:
+          - const: cnfg
+          - const: intr
+          - const: chnl_owner
+
+      interrupts:
+        maxItems: 1
+
+      interrupt-names:
+        const: periph_irq
+
+      interrupt-controller: true
+
+      '#interrupt-cells':
+        const: 4
+        description: |
+          cell 1: slave ID for the requested interrupt (0-15)
+          cell 2: peripheral ID for requested interrupt (0-255)
+          cell 3: the requested peripheral interrupt (0-7)
+          cell 4: interrupt flags indicating level-sense information,
+                  as defined in dt-bindings/interrupt-controller/irq.h
+
+required:
+  - compatible
+  - reg-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        arbiter@c400000 {
+            compatible = "qcom,glymur-spmi-pmic-arb";
+            reg = <0x0 0xc400000 0x0 0x3000>,
+                  <0x0 0xc900000 0x0 0x400000>,
+                  <0x0 0xc4c0000 0x0 0x400000>,
+                  <0x0 0xc403000 0x0 0x8000>;
+            reg-names = "core", "chnls", "obsrvr", "chnl_map";
+
+            qcom,ee = <0>;
+            qcom,channel = <0>;
+
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges;
+
+            spmi@c426000 {
+                reg = <0x0 0xc426000 0x0 0x4000>,
+                      <0x0 0xc8c0000 0x0 0x10000>,
+                      <0x0 0xc42a000 0x0 0x8000>;
+                reg-names = "cnfg", "intr", "chnl_owner";
+
+                interrupts-extended = <&pdc 1 IRQ_TYPE_LEVEL_HIGH>;
+                interrupt-names = "periph_irq";
+                interrupt-controller;
+                #interrupt-cells = <4>;
+
+                #address-cells = <2>;
+                #size-cells = <0>;
+            };
+
+            spmi@c437000 {
+                reg = <0x0 0xc437000 0x0 0x4000>,
+                      <0x0 0xc8d0000 0x0 0x10000>,
+                      <0x0 0xc43b000 0x0 0x8000>;
+                reg-names = "cnfg", "intr", "chnl_owner";
+
+                interrupts-extended = <&pdc 3 IRQ_TYPE_LEVEL_HIGH>;
+                interrupt-names = "periph_irq";
+                interrupt-controller;
+                #interrupt-cells = <4>;
+
+                #address-cells = <2>;
+                #size-cells = <0>;
+            };
+        };
+    };

-- 
2.25.1


