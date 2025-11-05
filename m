Return-Path: <linux-kernel+bounces-886129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEF9C34D1B
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D92B450052D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F98A2FE076;
	Wed,  5 Nov 2025 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FJMxn/rh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R1AI2t1L"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601A92FF668
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334203; cv=none; b=c6/M5cyraDuDfENa3uw5VAugexyoHWqrmaUVDHpWM+XeEX1bbZwLgmyEwJTovXda916SqW+4OBD38kf66v2/L2LQq+7zh+hFShKaJC9Sd6D4aRs9/45PgVDZ11KSVaSjj8yQsvis9L1aLDIJQe39PY8ZJ0TLWJ5o9mk3NKx6onI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334203; c=relaxed/simple;
	bh=A9ti4s4wSaiXfw3JIiAVtqvMXhv9C1M/PRlWv+V8fok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kYJvsxFFGQZFbIkQG9k9H0OGfE5KDFTPcyYy12WpZfKX3b+JA9AE/yQ805MfDZ+JmiQnMK7Fig/zXU1xLhLJVGI76s2Llw6WxXD2LcoF/LUebFAm998cf+PJzNfonV4dM1e28xUs0jgy3CuS+0qtqnBY7b35SPKBZrGTZ+zwyHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FJMxn/rh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R1AI2t1L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A57nLBT2927463
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 09:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JKGXmxysrCSUCXJZc61bKgPq0wJnPYCRj4YwJdhI/ow=; b=FJMxn/rhUvOTOzxA
	YxMTNtzGjgYJc8VOrAs7UxbYPnY1lgpWfJGzywqMbCo8Q2rgc7DmT6tpE6YP034M
	NTM03GNq2b//8u5sEFqFDuMNL2nvma/scUdsgvSYekjC6lDMz/rVCptNhvle6X/b
	A1b6hqFpW4PiopDGHQOylaVEpFAOQoDGK4Vy/ZBgdpnLSwuCHdjcoQCndovd1gT5
	0VMHhrHPnOn1g9OcEOlygF7/jFxgDiGJW+W76Gtl2vY2QRXYzEPC838TErLVGi51
	W71kXzByTc2nBUXnPoL9hrw0k4bZwlWnyoT/H9btOCRALdufZQGYewUO0Ud3pvTn
	z15KQg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7me5trha-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:16:40 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34176460924so1840977a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 01:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762334200; x=1762939000; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JKGXmxysrCSUCXJZc61bKgPq0wJnPYCRj4YwJdhI/ow=;
        b=R1AI2t1LyyFGuLeWHnHotGo4ztjrWMbuXRt8/UXdLSBeURi04g7xLH6I6pRxAzQY+c
         7mX0pnX7ce0LMZUqNt8/TmzgUlQPU5Qm/5K6ICfwBWxuc1AQrXKZvQut1btnoXXQnPxv
         NLP2l5ZbMN/MheKNAbTMGfGGJcTvAtGGuzsPF/uxUDa7O0ISeckWRTgGecVhARfyQpsS
         iR35iHzdujtNokmN53mN4YIILRMDWewmt4sJ/Q2oC2dBDg0NkARNNpZ8g6NQIQvZLGQ9
         Fr8edabwuCJ0NU4FLTuNliCic9E5OcjL5PmBNIMeBS5exSQy2ZsvmvMZ/mlf6Tat4uQI
         gulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762334200; x=1762939000;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JKGXmxysrCSUCXJZc61bKgPq0wJnPYCRj4YwJdhI/ow=;
        b=V2ema4dgO0CUIzdYMJ25JYveFdz1kVuuWN2PKORc3x3tvTDFkwnp96Bo+TJXX11441
         XhSATwC/yrt7Xomztk0dvloXESMLM8/8UN/uxqgi67c9YmDCrCj+kAQ/Qf6y7Fm6VVU7
         o/9AxdKveA6AncxT4rIYzHt0uMKw5sVAZ4e8NXN4cukIKxohwD/bSpDP2F/G2D13P/2S
         NBr+luM4ID6Hp/yndIqb3YgP/Zlmcc/4ppsatxpGedc6nIXO8QG2Tfqc9+QdEWc8+/5A
         yXs60+wUi6RhoMO/LY5pXLT56GgZUi9JM1hyQ1NckTyLOKl6j1u8+jo6S/BPW2Q/T5Nj
         ajPQ==
X-Gm-Message-State: AOJu0YxyHm8lzTWwFb9Ga2FqFhCmbtfvJYzXzdSNhxk4CnfIfmvF+FkL
	cG83sKHPr5n4O5KeN0NpAGoRABkw9x/ktldRG6C3b+tkRaBPdqnqZWxfj21zMTmUvmS+SghdBjm
	VKNZWFJOOw62Ev8rGCaVFfDOlg0dRdPfv6JHR5KbPGK3/QWMyH56/fxRpUnsX86JEoO0=
X-Gm-Gg: ASbGncugra147zPn3aMh+9UpHfn3gU3eMDWrnwCZCEhLGY6XXjwnORTdsnt2cqzzaHq
	ky3kz7hZYz6ziu8dN7IKpzAxiYHuJzKZNwtogKHXjwpdkx0+5NCI4Wm172uURKoh0lA1osSaqBs
	YuR5z+bh0Ih3Kvs4sefqGxDVjN6hdlqkqjzGsPPeVCrKQKcyp6IjVFoz6F8QGZuirDO2oySbt+k
	pYCU0mCECypJS8D2TYk4/2KjQvKBvp2gZx0ksxJ3axGgkidhQO//hCPm4LiUZ9GNfYcX0HYorNq
	uQSU4k2SD7nTlP8/ZITCmlvWNSNL6rjg1V7ZtZ59FVeT+2dD2jKW0gLPhKlx205ZjE/4m3YowDT
	PrjNLschOMdvOE29fGD5J6ACPI2Wt
X-Received: by 2002:a17:90b:1d4d:b0:32e:52aa:3973 with SMTP id 98e67ed59e1d1-341a6c1e1edmr3019405a91.8.1762334199632;
        Wed, 05 Nov 2025 01:16:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHV7QgAd558YVAFSjQJudcKW/aI1xyFRUAkLB6cz3hMh0JP6kISy8THKMgqQOqwmy1smdJc9g==
X-Received: by 2002:a17:90b:1d4d:b0:32e:52aa:3973 with SMTP id 98e67ed59e1d1-341a6c1e1edmr3019350a91.8.1762334198983;
        Wed, 05 Nov 2025 01:16:38 -0800 (PST)
Received: from [192.168.1.102] ([120.60.68.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3417a385563sm2274249a91.0.2025.11.05.01.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 01:16:38 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Wed, 05 Nov 2025 14:45:49 +0530
Subject: [PATCH 1/4] dt-bindings: connector: Add PCIe M.2 Mechanical Key M
 connector
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-pci-m2-v1-1-84b5f1f1e5e8@oss.qualcomm.com>
References: <20251105-pci-m2-v1-0-84b5f1f1e5e8@oss.qualcomm.com>
In-Reply-To: <20251105-pci-m2-v1-0-84b5f1f1e5e8@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5517;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=A9ti4s4wSaiXfw3JIiAVtqvMXhv9C1M/PRlWv+V8fok=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpCxXo/3egFPr03OzBAGmFojCRWd5IW7Mq20dUz
 PuXa3KZz5OJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaQsV6AAKCRBVnxHm/pHO
 9Sv8B/oCE9oXfkhSibtdfOWmq81wQIZOBkLw/0VpjoAuVDYZmti2bIS3+PETsv3YuewcE2C/fbY
 sftVnl8XSwztbHh/AdmhBBUzdtv7hhC8DHdNlO3ykVxItWf+0gjersXN23osxjJnnLCn6bL26Vc
 HXezwR+7EgrT69Wji0MgpHK9AIg6HBdyHH7jqiqgX0Xtmav3zzNMd3JrB6YBuvn6QPNEOlvYbOi
 jnPe6urGGQPB0HTAKlVBfK3e+prpl6eylUui8vijRm5gWSqnIHqavmWljdm4iqdqAEi5XgGB1EK
 PCIEx46MXIxSuM2T0CyuDa3E+kSKT5f43TgnCOAWvZhwUh6m
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-GUID: _RRmesRgLDvcRhzZe6mshkWptM1x8Gau
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA2OCBTYWx0ZWRfX9YvtVHRklTEj
 4QtV6cNI1WXWJZX2qwjH8lDd4C9L+Wf7CO6yGQpvqnmff0l+ZyRmliVutIwyk+Uk/Ndz/IbRHv/
 H4C+KyFFuqEJXnZ7t6GLlanvy2XK3ub1qSFeIPRyo45rU3GY0udrcp46h0LTi4WPdlXFVqSMcec
 lzuH+2ohhDfBWIGPgr5yN9wzAISSNkFO6TB2vNFVUw4QaKjZYvH4zFAR+yuEpuCKrhpFYJ0A5SQ
 BJVhgNg0cUG+kUfE3g4u+rNs+pdfPpQv1OiMmBIbkBrhYL1Vs1tame8VcZ6gvg72KOYJm2zYQnK
 BZWJ4dFV9m/Ij0tg8wtj7jZmJoqCPogUa/sHrzxJIwIH/u7cmPzETWR3aLiRxYHq1R0bocopmgG
 izNb5lk1uoq9hD0dE6/bsHBIBXwk3g==
X-Proofpoint-ORIG-GUID: _RRmesRgLDvcRhzZe6mshkWptM1x8Gau
X-Authority-Analysis: v=2.4 cv=IpsTsb/g c=1 sm=1 tr=0 ts=690b15f8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=adoi+G5QptZiRYWGMQz2cA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=uqBuD39NasnnOmdszP8A:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050068

Add the devicetree binding for PCIe M.2 Mechanical Key M connector. This
connector provides interfaces like PCIe and SATA to attach the Solid State
Drives (SSDs) to the host machine along with additional interfaces like
USB, and SMB for debugging and supplementary features. At any point of
time, the connector can only support either PCIe or SATA as the primary
host interface.

The connector provides a primary power supply of 3.3v, along with an
optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating at
1.8v sideband signaling.

The connector also supplies optional signals in the form of GPIOs for fine
grained power management.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 .../bindings/connector/pcie-m2-m-connector.yaml    | 121 +++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..2db23e60fdaefabde6f208e4ae0c9dded3a513f6
--- /dev/null
+++ b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/connector/pcie-m2-m-connector.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PCIe M.2 Mechanical Key M Connector
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
+
+description:
+  A PCIe M.2 M connector node represents a physical PCIe M.2 Mechanical Key M
+  connector. The Mechanical Key M connectors are used to connect SSDs to the
+  host system over PCIe/SATA interfaces. These connectors also offer optional
+  interfaces like USB, SMB.
+
+properties:
+  compatible:
+    const: pcie-m2-m-connector
+
+  vpcie3v3-supply:
+    description: A phandle to the regulator for 3.3v supply.
+
+  vio1v8-supply:
+    description: A phandle to the regulator for VIO 1.8v supply.
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    description: OF graph bindings modeling the interfaces exposed on the
+      connector. Since a single connector can have multiple interfaces, every
+      interface has an assigned OF graph port number as described below.
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: PCIe/SATA interface
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: USB interface
+
+      port@2:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: SMB interface
+
+    required:
+      - port@0
+
+  clocks:
+    description: 32.768 KHz Suspend Clock (SUSCLK) input from the host system to
+      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.1 for
+      more details.
+    maxItems: 1
+
+  pedet-gpios:
+    description: GPIO controlled connection to PEDET signal. This signal is used
+      by the host systems to determine the communication protocol that the M.2
+      card uses; SATA signaling (low) or PCIe signaling (high). Refer, PCI
+      Express M.2 Specification r4.0, sec 3.3.4.2 for more details.
+    maxItems: 1
+
+  led1-gpios:
+    description: GPIO controlled connection to LED_1# signal. This signal is
+      used by the M.2 card to indicate the card status via the system mounted
+      LED. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.2 for more
+      details.
+    maxItems: 1
+
+  viocfg-gpios:
+    description: GPIO controlled connection to IO voltage configuration
+      (VIO_CFG) signal. This signal is used by the M.2 card to indicate to the
+      host system that the card supports an independent IO voltage domain for
+      the sideband signals. Refer, PCI Express M.2 Specification r4.0, sec
+      3.1.15.1 for more details.
+    maxItems: 1
+
+  pwrdis-gpios:
+    description: GPIO controlled connection to Power Disable (PWRDIS) signal.
+      This signal is used by the host system to disable power on the M.2 card.
+      Refer, PCI Express M.2 Specification r4.0, sec 3.3.5.2 for more details.
+    maxItems: 1
+
+  pln-gpios:
+    description: GPIO controlled connection to Power Loss Notification (PLN#)
+      signal. This signal is use to notify the M.2 card by the host system that
+      the power loss event is expected to occur. Refer, PCI Express M.2
+      Specification r4.0, sec 3.2.17.1 for more details.
+    maxItems: 1
+
+  plas3-gpios:
+    description: GPIO controlled connection to Power Loss Acknowledge (PLA_S3#)
+      signal. This signal is used by the M.2 card to notify the host system, the
+      status of the M.2 card's preparation for power loss.
+    maxItems: 1
+
+required:
+  - compatible
+  - vpcie3v3-supply
+
+unevaluatedProperties: false
+
+examples:
+  # PCI M.2 Key M connector for SSDs with PCIe interface
+  - |
+    connector {
+        compatible = "pcie-m2-m-connector";
+        vpcie3v3-supply = <&vreg_nvme>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                m2_pcie_ep: endpoint {
+                    remote-endpoint = <&pcie6_port0_ep>;
+                };
+            };
+        };
+    };

-- 
2.48.1


