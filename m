Return-Path: <linux-kernel+bounces-734776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AB8B0862F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31DD17A746A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D2921B9CE;
	Thu, 17 Jul 2025 07:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FuJbsGjV"
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2907218AC4;
	Thu, 17 Jul 2025 07:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752736213; cv=none; b=pgFxNGR9Ob/nducMPjFOdnPvA1fh4vMekT//Bnp4ug7Q+UuS+PXxSo72whjWBLPHUHnHFIyghw0S6Tq9190McDHNVLH7HgyNQ7g3X2tPoQfnwT/OL+FZgZrN95iaypg5FBeo2t2w+OrOobgMuM7kfYlndCLhwxjZ+h896LRZHdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752736213; c=relaxed/simple;
	bh=hos6iVk11QyXI+zX7kx2DTvqzJd8iugClhi7esuRW5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=SH/WfjbR+YfWaadTuOIKeJb5oQAqFMYLbyJTzFbcDCNN3dkRnPmagkJotu2Kh7kEINCccdyVz6vLdkA6dJMr1uFkmCEIbG4yK0y+956A1PpgzCkBZhZK54WeOPG8FVyOJcdgXYbf5nHzeHl+ujbEk0EKlIcV58GyVZ6xOIrtaFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FuJbsGjV; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H57J7E007400;
	Thu, 17 Jul 2025 03:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ubRYq
	BIjCj3mZbT9HxemmEuCm6A1jj1svN9C6SKA9QA=; b=FuJbsGjVUa7p6+jNL1guk
	7UAR+MDcm/bHqFVZkC/jF/5ZY83EV68sbvjoYRe1lg+9XKqRaEuTsLaUPxhHJOXz
	kZ5Vt/F85vfV46y8vJnYa+lTFKM/gwTSWvH+Qncu2eWIT2FVVDYVZutvnRNoVpzZ
	PToDhOcjWgvtMIz65R4Y2g4zL6taac6NbdwX13jx/dxBDo4rK7txUPwx6S0Vi9rY
	Jzm0fUjPHVI+rUBIcHRHjdP4UjVsU4Qiq63ZlSHYtQvsiSsR8by7SOshJ93rTf77
	pnOYxrwSV2XGq3e2Nzc7mTasmNp1so5nl0kCqrJD4PCqC9zQ0YiGu5hSnE+5/OAc
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 47x799e495-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 03:09:52 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 56H79pRb046675
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Jul 2025 03:09:51 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 17 Jul
 2025 03:09:51 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 17 Jul 2025 03:09:51 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.72])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 56H79bDO005035;
	Thu, 17 Jul 2025 03:09:47 -0400
From: Jorge Marques <jorge.marques@analog.com>
Date: Thu, 17 Jul 2025 09:09:20 +0200
Subject: [PATCH v6 1/2] dt-bindings: i3c: Add adi-i3c-master
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250717-adi-i3c-master-v6-1-6c687ed71bed@analog.com>
References: <20250717-adi-i3c-master-v6-0-6c687ed71bed@analog.com>
In-Reply-To: <20250717-adi-i3c-master-v6-0-6c687ed71bed@analog.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Frank Li
	<Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-i3c@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <gastmaier@gmail.com>,
        Jorge Marques
	<jorge.marques@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752736178; l=2966;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=hos6iVk11QyXI+zX7kx2DTvqzJd8iugClhi7esuRW5c=;
 b=tL/AtPF5/sGBiQRv6V7W4VdMga4dv119OX8jLVKFx8GDvLVYuP/9mBAJ1YKBD9R6l+YuqGHb1
 vMLVKECzL65CYMgA2ylCmT/6LXCVRhV5eoGxZBx2wYgPPvQJTEBsk37
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDA2MSBTYWx0ZWRfX8UDGiwBQaSrz
 Q5wNRbYL7y4SsVngLtkSGm64NrceGg8FitiFtRDSrZBGmi2XLbGWBWU+24CQdRtqIK95iMawbjS
 DMu8phVatzdK97JanNLSCPg/SSmHMs+spWNs1NaXD0Z+vxmPwUNcFAljG+UBTx8hIVeqsvBjIKB
 ZYTn6C0N4Xcl/K03Ke2TT3+toRGOmy1QrPoklkW/5CNuTiZ2xroBkLTJZWVZkIcUM7W/wOizdix
 BuMPyuzCHfIepBvu5+i5au6YO6vHmheRosq8TPtBUroKqOdSBHOfHJpM5bRUdwCmkVRTTXW7aPE
 35gSN6rY5BqwOgLsrOE87yoYH0J4sTR0HByaTHlir4PQ++sxq0r/ICPCD5ODCDbE7CmZ1C5u0ST
 bqbiF1Z5lYONtfIwmJx7yauOOhfcQPIVtxFynGEX4GbshbLAUL0PM1ZfDhVPbhqcbDpDUVBR
X-Authority-Analysis: v=2.4 cv=N6MpF39B c=1 sm=1 tr=0 ts=6878a1c1 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=gEfo2CItAAAA:8 a=wI1k2SEZAAAA:8
 a=gAnH3GRIAAAA:8 a=Br2UW1UjAAAA:8 a=Q2ZsWLbW85TiznQkgggA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22 a=6HWbV-4b7c7AdzY24d_u:22
 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-ORIG-GUID: wMmTU2a8te_o-9Sj8V8Wf9COufDi-lEn
X-Proofpoint-GUID: wMmTU2a8te_o-9Sj8V8Wf9COufDi-lEn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=858 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170061

Add bindings doc for ADI I3C Controller IP core, a FPGA synthesizable IP
core that implements the MIPI I3C Basic controller specification.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 .../devicetree/bindings/i3c/adi,i3c-master.yaml    | 67 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 72 insertions(+)

diff --git a/Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..8f532386de2c05d3d514d41ff4d6a37ec840674c
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i3c/adi,i3c-master.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices I3C Controller
+
+description: |
+  FPGA-based I3C controller designed to interface with I3C and I2C peripherals,
+  implementing a subset of the I3C-basic specification. The IP core is tested
+  on arm, microblaze, and arm64 architectures.
+
+  https://analogdevicesinc.github.io/hdl/library/i3c_controller
+
+maintainers:
+  - Jorge Marques <jorge.marques@analog.com>
+
+properties:
+  compatible:
+    const: adi,i3c-master-v1
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    items:
+      - description: The AXI interconnect clock, drives the register map.
+      - description: The I3C controller clock. AXI clock drives all logic if not provided.
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: axi
+      - const: i3c
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+allOf:
+  - $ref: i3c.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i3c@44a00000 {
+        compatible = "adi,i3c-master-v1";
+        reg = <0x44a00000 0x1000>;
+        interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clkc 15>, <&clkc 15>;
+        clock-names = "axi", "i3c";
+        #address-cells = <3>;
+        #size-cells = <0>;
+
+        /* I3C and I2C devices */
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index d5a173e987c06d75848d112339e39966f2b71cea..1f212529276f4ab28f4b7d16b4105a8cf9ff5e2e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11452,6 +11452,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml
 F:	drivers/i3c/master/ast2600-i3c-master.c
 
+I3C DRIVER FOR ANALOG DEVICES I3C CONTROLLER IP
+M:	Jorge Marques <jorge.marques@analog.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml
+
 I3C DRIVER FOR CADENCE I3C MASTER IP
 M:	Przemysław Gaj <pgaj@cadence.com>
 S:	Maintained

-- 
2.49.0


