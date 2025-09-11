Return-Path: <linux-kernel+bounces-812333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8DCB5367A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20CFE1C22EA8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1EF1E1DE9;
	Thu, 11 Sep 2025 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OWa2rwR9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC133343D9F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602545; cv=none; b=deywRL5MDL+PcbxjeIunuMzWNts0iEpnoVgKQ7c/kSZCsjaGaH9wThwFZZa/lrKY1YgqICeYKXaRKdZ1DDeb186sPs1ou6VCBljB5/vVqvlbiDRbn9/i0kxJZpOTu8dkjxZDVW2ZDzHebjr3oSUcmZByk9T2MGok9k5iMpEb45U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602545; c=relaxed/simple;
	bh=LgccMGQtMns6i0nd4D5JzFa/u0XEgWzMdMJHz1iq7Mg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BJw3NpD2GTvMNvb3OrwviPHQPOkd/UUOey15D4/6GryjJxZQb91bmw426sMgRWZMIapOwJlY15Cvyj8bhVSuX2rNasG/rVerCjOIEi7FMlYQVn35kpNPXwuRRSHCAuoK0lytEIAYXv330IQz9XUi9FGwdPNtaWwtUifxB2/3mfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OWa2rwR9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BBFJTw016084
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jjkngGlYDAm4B8CujfeVMFkJRW4QuQM6B+E9nbyKLy0=; b=OWa2rwR9JtE0Pi3E
	+VVmB9lAdF4GiGxz+77B3UPGSlLm7tlINIrm0wv1hVvZpywBjDiafCuGLmH3q2pN
	Ce3+OCnwsiOZnKHvBEXVexJJeJmwQtsPZFr1C7fCfEYu0UYMatUMWf02EAzrbpWE
	2//eJRAW21/1cBzgfsBrdmyBooiOApSHXkPkgsNyn6LUn0REtjcR2t8U30ffMStQ
	TfLVPpoS2IbH9wFFfMVb5n7XkU3PPeNcJ2Fg3VZ8t6Mxf6960P6uK6X5i55EHJvu
	5n2ciqIrHME8O4/yBWohYxG4EsKtVAMdUjaVhbMYHtGnSxHE80/b4HxsmOZQPXwa
	ZpegLg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t384kam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:55:42 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-25aadf13424so1648315ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757602542; x=1758207342;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjkngGlYDAm4B8CujfeVMFkJRW4QuQM6B+E9nbyKLy0=;
        b=EdyCZKdlkZ5dHPdQkOqHEQVatIPnVGiQG5gZDHaQXvU6BofufKfVWQX1b+AwDXYyHo
         tqHfzAGPAu5UA6SyFCBXlaDIJYaCks2BH1UQCCefaOfzbIdYWGUecVnt21IRpffgAoQK
         NxVul5Sjt6othdT+W2Eh6EGnBfE/zXvjQHzDLPByYV8wdpe3GWWvl9PgQRhRthQB/QN/
         0eoTr4tpwlxsFdFpbEcx/ECquhLIIui3+q1MLzZgkLAw2RBkoMJOd3x/vYYa9NSL/oYt
         f2CkdC2pQDWT7MUeV4TrWVhVAaZXBzQDomOCLuC8hY/IaQYrDJQPj9haS5hXOVN4FML8
         R4qA==
X-Forwarded-Encrypted: i=1; AJvYcCVyqcjW6gL4A9zQ+wWFumLfApqRjHnwwC2pwYI98Xx5BVGUmRVulm4bA0oVe/bMT2ZrgKBALeczab/ooKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQsCf6yygu/SZ41tIIXuZk67gveQYeQfFfuXUMKx8BtrcvAHEo
	TFg+TgCEPkL9MA4PqyGqIMvGgQ1va/PfpjkVNL9I8k4zDwLXtiVUQCya+x9GAg568s52Owhwqh9
	8bMpQcgCVUgLYT4TySGNPz6yh0y5JI6IImqV91/srsHJulPEgJatOG14Wlth/aX/6GsQ=
X-Gm-Gg: ASbGncv/8THMzUiJ/I/+s/b0x685AdTpxDy2Fx0GNBY+oAj9N0q/7MJceSVpyxWIKZP
	B3RSCYlj3mnH56hB39Z7jG7PyUtwM1jlKE84drdIYR8tUabOgyhWYnISnjWef32w9S7Q9JGfuOo
	Hb2lWd1AMluC5RNKoEOF2k9Z4p8BCPCW5WdOzRwLqFzYJTA++y/PAC6eCamGECWw6qcTuGaerLW
	UeQZcKVNOoLHdkhg/4QfSTLRZ3AeUYQigH+yWZHxzIX5At9z8cPzG4e2pw1UARPNEbEtSqykvku
	SFgJPI8VYDkajiS1HsMeiOifBZzxeaENW7lV+qhUX/8VG/ZaEV+qJi8+/PEut7liwMhkuCmYDJr
	hzV6NTKdPc7ZmSSX+8LWupTL6LQ16vEfx1twH1+7D3TF5NnsqW8545af2
X-Received: by 2002:a17:902:c40b:b0:243:589d:148e with SMTP id d9443c01a7336-2516f23de24mr132990735ad.5.1757602541984;
        Thu, 11 Sep 2025 07:55:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEtpsa7qlUyYAsgBCQGIBTzIJxW2bcMhr8lZkbI7bFHvqypkmZ+m9OuDf0/hYNs6aysv1XsQ==
X-Received: by 2002:a17:902:c40b:b0:243:589d:148e with SMTP id d9443c01a7336-2516f23de24mr132990335ad.5.1757602541465;
        Thu, 11 Sep 2025 07:55:41 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a387cd4bsm2107453a12.35.2025.09.11.07.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 07:55:41 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 22:54:58 +0800
Subject: [PATCH v4 01/13] dt-bindings: phy: Add QMP USB3+DP PHY for QCS615
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-add-displayport-support-for-qcs615-platform-v4-1-2702bdda14ed@oss.qualcomm.com>
References: <20250911-add-displayport-support-for-qcs615-platform-v4-0-2702bdda14ed@oss.qualcomm.com>
In-Reply-To: <20250911-add-displayport-support-for-qcs615-platform-v4-0-2702bdda14ed@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
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
        li.liu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757602527; l=3530;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=LgccMGQtMns6i0nd4D5JzFa/u0XEgWzMdMJHz1iq7Mg=;
 b=mXj8P2zI5LqxmvJf/ITJhpiVlig+/0otZwvxQRDsBRti9c9obJVcSQTesm+iB69NrWfS1lqLZ
 V6KJztXRPxcBV79k9PWjTr9xRHUa2hlg3SDAYgvXdXof961JAOSGaTy
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Proofpoint-ORIG-GUID: FVC1tJIxLu-2RDeSrQw_RBzh5ASONDUo
X-Proofpoint-GUID: FVC1tJIxLu-2RDeSrQw_RBzh5ASONDUo
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68c2e2ee cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=z8W1oWq9hX_DlPyfQGsA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfX6ahR7kxG3NEl
 nlAJ7uXO6i+7NjWcypP9XRoc6cE+UEWgWVrjcVuKN4e2H4iG/8hivBjkYk9Y6wS9xaeAooVZsAa
 G98EKxYUfWuZ/0tTp8e881e3ksdfXiI4249NtUZnVJNQRbVPAKWT1zaVlSGl3LAHtrZDuFI3sIN
 p/DFGvDuK4uLEmkT3b0ySXoU5lpiEJQMEgiGaC/8heisU0pT7cjZmxF54MSt7itJDpqGNQSxObN
 aUcB3YbvbE0FBVTigLj1m8eYuKsFwusIVt0lSQoTJZEFoCbPWzychAX/CtlQnQCBDYD8+82Y0mH
 GV8cWWVgr1RI7BXfT76M45pFQ4it+tkYZoYK4euTqNtU4AVkO7s7WYAtcvoPEX7dXeWfGIymY50
 1XqzDflN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066

Add device tree binding documentation for the Qualcomm QMP USB3+DP PHY
on QCS615 Platform. This PHY supports both USB3 and DP functionality
over USB-C, with PHY mode switching capability. It does not support
combo mode.

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


