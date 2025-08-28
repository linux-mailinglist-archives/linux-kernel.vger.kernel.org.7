Return-Path: <linux-kernel+bounces-789906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E400B39C6D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9C316EB7D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D64530F937;
	Thu, 28 Aug 2025 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WBGkOii2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46C03101D1
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383025; cv=none; b=K5PWs38A7C5ha9s1t8euGU3y8Y2OFK+27MoJHH6s0SE8g77sUBKXbKav4eQMX+2xhvfz7lcJ4VhzCFnWS6g1RyHwv6EQMC01UkAYxyn101Az2J8hbkcsTdBD6HlHxoQH2nDqP0awQ/CbQlvNXnfGx1zr63MX6F4AoQYCv5rmUUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383025; c=relaxed/simple;
	bh=8zvZqpFeuXSiqe4t+MpIJYoVCiPCsJm1Ov8cxUJVKCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QRpDno/t/bkWtZtKwWvwc5WkKR8HKys/vU44K9SFYt1V5ZMjFeXV2kE/xO/ONgzj7YqtCRYtCsvdtxwYRVhp5XXIMGWYlmBW8kjsGiRKToZ5OG1MyWjjhIcuovYY/e4BokkXtTb4HRag/rPKMMhMsI7hU8s3arM9k3FQX1hepq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WBGkOii2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S5h0ah015908
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N5SuIv3JLHlPvqOUKHgEWsX4PG4GINisx08kaTXoUAg=; b=WBGkOii2Zwhsy+sc
	xHBvriDMKvagkkmCF1m5HAzgGrJlOPOSBamZyFPpDTo9lCegzVLsHhwhFgSS5QpZ
	p2jpV5+Tf6WPAjIuZikuSPXh1AdvCnv+xk7D2BraiDpX2NRYVzgqHSfsujd9//hH
	S2z9EqpuKtIDkrEi5pcWPGaY1IrlyCJq24vpBEvNXWfgdXNuEN8a0JsXgbR/lnxY
	H5I7srI6ghOIe0ZJ3m77+ckmzifG9ZdOCN6zmlzPcmToKNRbkeoPO/d/G8CoqSS9
	aMG+eud5nX30EczdV7aAJyJ29y5uLQx7d0Nrpz4WGBlLJxyBZ2RYeQEVQeKKQ3ZU
	9MnWpw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48rtpf2drh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:10:22 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-327706e0642so1596456a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756383010; x=1756987810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5SuIv3JLHlPvqOUKHgEWsX4PG4GINisx08kaTXoUAg=;
        b=Ibo6X33N+pLNJN7+jxFMWUmj6Cf4/CC6uYZA4OvVaDNnYWWrMulqqIuckiW7TYAh4s
         fYcP9PXSd+Nz6Y41ReAUZEeGdAnH7PPhArCm7lBq8ZWiMMCgHYcwCrj3sF636pQGf1x6
         uessgY39yHj+Cq//nmDvEsr0wB/cHyTGaxTtCLDy72l/wX7h4XsY8AStPCP65rrphc80
         LAscGCusCkxT106JEHDLW7GGlPdtYu6rTWyRvfLZSZGduxUY3CbaQVrs57BPOd4GS/Tx
         EnC86JNs/FpB7AYYQFnjKcu5vHHEeCzAqnzAj6i6iRGyPBMiBaOPZiLF170xXMizaiuh
         WarQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqhRsvoQA7BW57hONYe+6y8hI9+7dwUze5GL8yHO54TlDRsgbk2nOfZZPhPzmaANQiJAZdnrNbje3an9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3u3c6D0qeCML7Jn0Lpz4PngH+cfx7W94/sGE91vM0lWBZww6h
	0reHcPZlA66oHnCwvmNFdXtkr1P4XPlqQQeEzMUZF4wRXjKVgEQGEEN8+midn9UFysjuu2Q1aXu
	mfQjcDLxjBtkfNq12FGGsypo4GarHuwy6bXa7eroJ4qx1ZpJcH3bcQeSIacAhoY1nGTM=
X-Gm-Gg: ASbGncvGNq1jQvZzsw6W7t8oNAKcOkzyZ+GPXs0+JOE4Srv/rTngMc2UjxzdTYchNJN
	p3UvX/MMgSwk85d1JU2n87gKr1VRiCMEHj3pVf06+g9jLrHKupw4EtnDV5UnaXWTIC0JYxalCv6
	/gTqLP3GNWOZTKrpqxzR/qnNf1iANnf/B97q7NYZ4233TWZqo1JZkArVdn/zU1430VJwDw0noKt
	pRqG4Hhc+MvgJn4U1bOWrs2w5rUjPk7v58rnnIRMAXsSC3+EjYN4UGad3frTVs6DbzF7T6mgnQJ
	J58m9bvyKxQBM7YOQvjUh6RhPLUKdmJnwo9ejTd99rOnR/S0sCVt+A/8AIPEBRBm8X18JxUfOR8
	=
X-Received: by 2002:a17:90b:5445:b0:327:6a43:c73f with SMTP id 98e67ed59e1d1-3276a43ccb8mr8454341a91.20.1756383009728;
        Thu, 28 Aug 2025 05:10:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZ1xN1nH2+SOb4TBgCljRgNHYk41wxaH6Bv3TBCbiJASEGGgEmFVy9pBEJvSscYC2NVVceMQ==
X-Received: by 2002:a17:90b:5445:b0:327:6a43:c73f with SMTP id 98e67ed59e1d1-3276a43ccb8mr8454272a91.20.1756383009006;
        Thu, 28 Aug 2025 05:10:09 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32741503367sm4019070a91.0.2025.08.28.05.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 05:10:08 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 17:38:58 +0530
Subject: [PATCH v6 1/9] dt-bindings: PCI: Add binding for Toshiba TC9563
 PCIe switch
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-qps615_v4_1-v6-1-985f90a7dd03@oss.qualcomm.com>
References: <20250828-qps615_v4_1-v6-0-985f90a7dd03@oss.qualcomm.com>
In-Reply-To: <20250828-qps615_v4_1-v6-0-985f90a7dd03@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: quic_vbadigan@quicnic.com, amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756382994; l=5849;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=8zvZqpFeuXSiqe4t+MpIJYoVCiPCsJm1Ov8cxUJVKCk=;
 b=jmYXpazt1LKuasdTDORWhr1cdImPInQgvTaDPJW/cJ43tD/9dbY47ia5cmphxGwxpSeg2YmcK
 zDj8ENLXIXfAy6GkNEgqDWx0QQOU+mh4pdMcKY2526d6HsUk6IKx2i+
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: 1T5_69aQlhzWz3slBfxQ0MI6jDSAs7A6
X-Proofpoint-ORIG-GUID: 1T5_69aQlhzWz3slBfxQ0MI6jDSAs7A6
X-Authority-Analysis: v=2.4 cv=Hd8UTjE8 c=1 sm=1 tr=0 ts=68b0472e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=dWfasREweX4F4dHnDHIA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE0MiBTYWx0ZWRfX3NN3rsrzO/Yw
 g5BWJa7Zq9wlujU8+Ktj4QMlSgfJmbV6dkXJ0ncm95kL+SJm8cqulbK18516MLgb8SXD8mZBn9b
 0+MjaEEZU9zDZ+bZExmROPYS/zVoJlXvgW+VAN1Us8p1upiVxW071n1+wXGx8EdD+eVkOTPAT8f
 wtlvGhkscDsdNHxdeSC64WyJrsccFE12K2KA1rf3EGsY0Jey9PQU1rkglFw7q5b5157jBf63Fzh
 fBPjYPxGPRxpP4Bm9cs1Vp7uVs6IUa4/luF52BnrJGQCgTPiLnhPwJtYTS16nimSF9ahU59krGy
 PJnTM/XBri5bsgoIXYVRJ7q1FL7piImk28+TMSg9zz8kOBM4Cch4pR3Ubf6SWgiFfzuYy9zncsk
 y8BSduiv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250142

Add a device tree binding for the Toshiba TC9563 PCIe switch, which
provides an Ethernet MAC integrated to the 3rd downstream port and
two downstream PCIe ports.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/pci/toshiba,tc9563.yaml    | 178 +++++++++++++++++++++
 1 file changed, 178 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..82c902b67852d6c4b0305764a2231fe04e83458d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
@@ -0,0 +1,178 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/toshiba,tc9563.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Toshiba TC9563 PCIe switch
+
+maintainers:
+  - Krishna chaitanya chundru <quic_krichai@quicinc.com>
+
+description: |
+  Toshiba TC9563 PCIe switch has one upstream and three downstream ports.
+  The 3rd downstream port has integrated endpoint device of Ethernet MAC.
+  Other two downstream ports are supposed to connect to external device.
+
+  The TC9563 PCIe switch can be configured through I2C interface before
+  PCIe link is established to change FTS, ASPM related entry delays,
+  tx amplitude etc for better power efficiency and functionality.
+
+properties:
+  compatible:
+    enum:
+      - pci1179,0623
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO controlling the RESX# pin.
+
+  vdd18-supply: true
+
+  vdd09-supply: true
+
+  vddc-supply: true
+
+  vddio1-supply: true
+
+  vddio2-supply: true
+
+  vddio18-supply: true
+
+  i2c-parent:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      A phandle to the parent I2C node and the slave address of the device
+      used to do configure tc9563 to change FTS, tx amplitude etc.
+    items:
+      - description: Phandle to the I2C controller node
+      - description: I2C slave address
+
+patternProperties:
+  "^pcie@[1-3],0$":
+    description:
+      child nodes describing the internal downstream ports
+      the tc9563 switch.
+    type: object
+    allOf:
+      - $ref: "#/$defs/tc9563-node"
+      - $ref: /schemas/pci/pci-pci-bridge.yaml#
+    unevaluatedProperties: false
+
+$defs:
+  tc9563-node:
+    type: object
+
+    properties:
+      toshiba,tx-amplitude-microvolt:
+        description:
+          Change Tx Margin setting for low power consumption.
+
+      toshiba,no-dfe-support:
+        type: boolean
+        description:
+          Disable DFE (Decision Feedback Equalizer), which mitigates
+          intersymbol interference and some reflections caused by impedance mismatches.
+
+required:
+  - reset-gpios
+  - vdd18-supply
+  - vdd09-supply
+  - vddc-supply
+  - vddio1-supply
+  - vddio2-supply
+  - vddio18-supply
+  - i2c-parent
+
+allOf:
+  - $ref: "#/$defs/tc9563-node"
+  - $ref: /schemas/pci/pci-bus-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    pcie {
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        pcie@0 {
+            device_type = "pci";
+            reg = <0x0 0x0 0x0 0x0 0x0>;
+
+            #address-cells = <3>;
+            #size-cells = <2>;
+            ranges;
+            bus-range = <0x01 0xff>;
+
+            pcie@0,0 {
+                compatible = "pci1179,0623";
+
+                reg = <0x10000 0x0 0x0 0x0 0x0>;
+                device_type = "pci";
+                #address-cells = <3>;
+                #size-cells = <2>;
+                ranges;
+                bus-range = <0x02 0xff>;
+
+                i2c-parent = <&qup_i2c 0x77>;
+
+                vdd18-supply = <&vdd>;
+                vdd09-supply = <&vdd>;
+                vddc-supply = <&vdd>;
+                vddio1-supply = <&vdd>;
+                vddio2-supply = <&vdd>;
+                vddio18-supply = <&vdd>;
+
+                reset-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
+
+                pcie@1,0 {
+                    compatible = "pciclass,0604";
+                    reg = <0x20800 0x0 0x0 0x0 0x0>;
+                    #address-cells = <3>;
+                    #size-cells = <2>;
+                    device_type = "pci";
+                    ranges;
+                    bus-range = <0x03 0xff>;
+
+                    toshiba,no-dfe-support;
+                };
+
+                pcie@2,0 {
+                    compatible = "pciclass,0604";
+                    reg = <0x21000 0x0 0x0 0x0 0x0>;
+                    #address-cells = <3>;
+                    #size-cells = <2>;
+                    device_type = "pci";
+                    ranges;
+                    bus-range = <0x04 0xff>;
+                };
+
+                pcie@3,0 {
+                    compatible = "pciclass,0604";
+                    reg = <0x21800 0x0 0x0 0x0 0x0>;
+                    #address-cells = <3>;
+                    #size-cells = <2>;
+                    device_type = "pci";
+                    ranges;
+                    bus-range = <0x05 0xff>;
+
+                    toshiba,tx-amplitude-microvolt = <10>;
+
+                    ethernet@0,0 {
+                        reg = <0x50000 0x0 0x0 0x0 0x0>;
+                    };
+
+                    ethernet@0,1 {
+                        reg = <0x50100 0x0 0x0 0x0 0x0>;
+                    };
+                };
+            };
+        };
+    };

-- 
2.34.1


