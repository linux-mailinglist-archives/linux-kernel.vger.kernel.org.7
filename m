Return-Path: <linux-kernel+bounces-831872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11085B9DC21
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34ABC4225C6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4632E9EA4;
	Thu, 25 Sep 2025 07:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aVaXGckP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263EF2E9755
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758783929; cv=none; b=TJciQB9FUCDCIKAs5e9NoXgCkMkhh1HYzuzdHJvhetkvAdXXmiqOn1z6KJPUqdfB1PWbL/BnHl/wCYLgKfyBfA/sVIk52V6N2o57zWvLzmR9viHtScoEAG0WV4s/G2Do+ZjajuBcqZbtPxiyVFUCD0T6R//ErxhcsY9PV0TZ4sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758783929; c=relaxed/simple;
	bh=upWyBh8lqfmu6LV7sTpbUr+WwNLCQ/FfInBDAu5O+9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dXv0EaZB4dJ9qfY7DJEDI/cfKKMJYYx5Ua70uzp5adKwdg0px/RhIDrH7HzbBZ46J3uyVr4720K10pjZ6AM2fU3XZQdXYJC8brDVoKEjtXtXU0h8V51nqMvaD6pateiQ7stEeNid5Ozr8x5J1IG7OQLK9gSbjdIgg/CT1ETBmts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aVaXGckP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0OQh8025079
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2e7Hy87wIaFmYTkT/SRJPCIfc6N0tMOhDASgzvKcFpk=; b=aVaXGckP3xZHpeRH
	dWVjafdziEU7gMMx6CiLzbJg3WZpSYr2io6UOWDH6OzAVHAJD5VqVtB9X3eQZ/Qy
	JiKKEp9gZYNgPi1pN9C+IyC2s+UsyPGe0f2TQdUtkRVG2KoTX35JQkoz/Yj0SsdL
	rNW8ku3MkkTM0HPDUW8+XfLdVWwj2zbgqUwvdS11oTrhFVbFDiouacMwAUwOsKY3
	Gf7WeH2HEBYRwwrVexU412u7PbavGkkc4Fq0ZJcRS2xS+RDeINdNtdNU98rJ0/R5
	0Znv1YYe609GfF4bHYaUuCLJQqLZNXGL1H5lnNN6u0gNSSnpYXKn1juymL/fV7X8
	s1SFwA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyeyey3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:05:26 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33052cda83bso169574a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758783926; x=1759388726;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2e7Hy87wIaFmYTkT/SRJPCIfc6N0tMOhDASgzvKcFpk=;
        b=PhOhMOX11qfpjH9AS2L45Lz3CohDQzkJ8QLn73mi3IpH7lJsAhSLScGYuSfDjFxDa3
         rcOTM64Valw+aLSKlEnSUPkUWHsGpdVAwoONORxxG40y0ObGsyNY8IT2MxykzPRmDYnN
         hM3EGzbqGk8lR2vKEskB3akt1NdEjYjM2nA838PhhsWP62G0cDSJWlpMHexGX2/E5+6F
         eh4bqIqX2iRjZkiQwQ1ZRz8RTv7PaDnfL7Q+yfJHCAed20cL5GGV+CJRs44X2bG4b54F
         TK2NFiNsFgM3UX9CsYTDtzmVyabfW/77Du+VWpWlBUpG4Jc9fR3UsgHp6D+Wm7htt9To
         6Mhg==
X-Forwarded-Encrypted: i=1; AJvYcCX1hrcK2OxUbWe9PDKVmqfZ8Tj7D2KGIcZdMWRpCkibzWvvxghVeFg3o4KSfuEk+r2edTbedTZQxJHyuJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLzX8RTNYKLqFpquMSuD2j8R2B92A4MAaCuKMbx/yFB0vrpmQH
	nOqLE799iGdXPc6TEMcgcLQmXVWuPk47M3lRrjqZhUHU/jtsOsAOMABX7jQuydftNXCn4O+iQ6r
	9acPB9OuRluOBz8kzWNEtfvlo9T/hiTk+kaSscrIyYtTCJCRb0BManrpFi0qm2oPc8ZQ=
X-Gm-Gg: ASbGncvl4/Wj3fjDKj+NBLN7sJ2BXmR1xJf1mdi13f2RVkiyHOD8/p1aT2xC8K3bcPK
	RuFE7n1VyfeFmkGJqolZk94+cYp/WLPt4BQI3xOV1o5DbeArlMhr1mofkgeiCtQThhxNcncKnvX
	mpCOFh3VGyzNyismqX/CLjqERNzqH+c33R2unK+WL6TxGbRIWJHbv9WbOMhUAYpuEd6+m69HXHs
	te8ToIbn+HEecspHthUWLLwSLO1841LrWzbgDCpZjgNAie1RpKNHxVY0MfwwsSc+B8/8DuqGe/C
	TyIZ/027oQ9zdin8B5EvOnxJcgC5R1kZGVAxmoarHHANVrk5fYPr2AIhBFFS0Kfx0dNqRyb3I4F
	LVkW3fDvr9f7iW3nhOVgqgszHoRDSHKEB4oEX4a+8OZWA2Kw8T46Ny+1I
X-Received: by 2002:a17:90b:4d0f:b0:330:b952:1069 with SMTP id 98e67ed59e1d1-3342a2dbeaamr1385473a91.6.1758783925814;
        Thu, 25 Sep 2025 00:05:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCpqcvdQExDN/tcMkaqHwuJZtGGTfCqnGGzDy5L8LFUtoOVfzw9y7B/380xTtLfWXC04SIqg==
X-Received: by 2002:a17:90b:4d0f:b0:330:b952:1069 with SMTP id 98e67ed59e1d1-3342a2dbeaamr1385428a91.6.1758783925188;
        Thu, 25 Sep 2025 00:05:25 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3342a2bd584sm914253a91.0.2025.09.25.00.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 00:05:24 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 15:04:47 +0800
Subject: [PATCH v6 01/14] dt-bindings: phy: Add QMP USB3+DP PHY for QCS615
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-add-displayport-support-for-qcs615-platform-v6-1-419fe5963819@oss.qualcomm.com>
References: <20250925-add-displayport-support-for-qcs615-platform-v6-0-419fe5963819@oss.qualcomm.com>
In-Reply-To: <20250925-add-displayport-support-for-qcs615-platform-v6-0-419fe5963819@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758783908; l=3580;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=upWyBh8lqfmu6LV7sTpbUr+WwNLCQ/FfInBDAu5O+9Q=;
 b=q8QTjt4okaLrL3p8+JMm94E79JTZZNoDPRaTdjR9Z4pKfRZoQHUIoCdwtYknqyxQ/TKHScZ1h
 VvgnhdjPFT6AMHcRVzzdSJH+4MJR9pH5fUyv4MuUabA8/ITet6h1K0e
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Proofpoint-GUID: dw14H8T2ZMluju1CYJbaaab7N1eSPpR7
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d4e9b6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=z8W1oWq9hX_DlPyfQGsA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX06aDwwdTk6Xo
 pQsdzSj63Ml/GnTrb6waNz3QUCZo27qUNHFt1/rNPp7i/l3JvvlgQwKIYOUhFmdLuyjeBH9+t8j
 2jK5wavfj5zWXydsppef6oVUJ/wF8mIqkcYebc2+XVYodwc9ZSFaDGARO9EY07dL1+wKEOQqewd
 4I7gM7qOzLD5DnLquBxsO2CQ8tHgAFjnHjqoKnhL29JMui2tK4txX04Ztci2eQLj1SY3lrxaJpJ
 CsPf2jDAlaw5u6/aLd8Hh/fusDsTpETvW9L84F1fHexOA/Fspc8lxor79CW7Cb+cOtPZAvJR54Y
 Mmi0azVT0yeCN4ZXIYlBv63KhsMhp9slG3qFssi62FGxB7/mBGCaMX56Xot9x3Od2ZcYQ3qU88/
 pApu5vie
X-Proofpoint-ORIG-GUID: dw14H8T2ZMluju1CYJbaaab7N1eSPpR7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

Add device tree binding documentation for the Qualcomm QMP USB3+DP PHY
on QCS615 Platform. This PHY supports both USB3 and DP functionality
over USB-C, with PHY mode switching capability. It does not support
combo mode.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
 .../bindings/phy/qcom,qcs615-qmp-usb3dp-phy.yaml   | 111 +++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qcs615-qmp-usb3dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qcs615-qmp-usb3dp-phy.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..efb465c71c1b5870bd7ad3b0ec215cf693a32f04
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,qcs615-qmp-usb3dp-phy.yaml
@@ -0,0 +1,111 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/qcom,qcs615-qmp-usb3dp-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QMP USB3-DP PHY controller (DP, QCS615)
+
+maintainers:
+  - Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
+
+description:
+  The QMP PHY controller supports physical layer functionality for both USB3
+  and DisplayPort over USB-C. While it enables mode switching between USB3 and
+  DisplayPort, but does not support combo mode.
+
+properties:
+  compatible:
+    enum:
+      - qcom,qcs615-qmp-usb3-dp-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: aux
+      - const: ref
+      - const: cfg_ahb
+      - const: pipe
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: phy_phy
+      - const: dp_phy
+
+  vdda-phy-supply: true
+
+  vdda-pll-supply: true
+
+  "#clock-cells":
+    const: 1
+    description:
+      See include/dt-bindings/phy/phy-qcom-qmp.h
+
+  "#phy-cells":
+    const: 1
+    description:
+      See include/dt-bindings/phy/phy-qcom-qmp.h
+
+  qcom,tcsr-reg:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to TCSR hardware block
+          - description: offset of the VLS CLAMP register
+          - description: offset of the PHY mode register
+    description: Clamp and PHY mode register present in the TCSR
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - vdda-phy-supply
+  - vdda-pll-supply
+  - "#clock-cells"
+  - "#phy-cells"
+  - qcom,tcsr-reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,qcs615-gcc.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+
+    phy@88e8000 {
+      compatible = "qcom,qcs615-qmp-usb3-dp-phy";
+      reg = <0x88e8000 0x2000>;
+
+      clocks = <&gcc GCC_USB2_SEC_PHY_AUX_CLK>,
+               <&gcc GCC_USB3_SEC_CLKREF_CLK>,
+               <&gcc GCC_AHB2PHY_WEST_CLK>,
+               <&gcc GCC_USB2_SEC_PHY_PIPE_CLK>;
+      clock-names = "aux",
+                    "ref",
+                    "cfg_ahb",
+                    "pipe";
+
+      resets = <&gcc GCC_USB3PHY_PHY_SEC_BCR>,
+               <&gcc GCC_USB3_DP_PHY_SEC_BCR>;
+      reset-names = "phy_phy",
+                    "dp_phy";
+
+      vdda-phy-supply = <&vreg_l5a>;
+      vdda-pll-supply = <&vreg_l12a>;
+
+      #clock-cells = <1>;
+      #phy-cells = <1>;
+
+      qcom,tcsr-reg = <&tcsr 0xbff0 0xb24c>;
+    };

-- 
2.34.1


