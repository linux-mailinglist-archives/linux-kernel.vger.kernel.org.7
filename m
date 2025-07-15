Return-Path: <linux-kernel+bounces-731518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C91FDB0559A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48BE1C22638
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5C52D5400;
	Tue, 15 Jul 2025 08:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Cq4PjwR+"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4412D46C7;
	Tue, 15 Jul 2025 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752569827; cv=none; b=fghruutKgXw3oE/rPpnXcDrRoijU2ZhywoFrxNsWx0JGunGxR7wFXfV/VkMIDg15NYGTznInTxk8t8er0dRunrHFHR8Qm7BhGplyrab3mmjLcvTCvlL+lurExm8ID+CDzm3nSbPL5A20mUw0QyYi2sBEzC1KQgmaLcq0laXPx7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752569827; c=relaxed/simple;
	bh=hos6iVk11QyXI+zX7kx2DTvqzJd8iugClhi7esuRW5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=aD9v2Ygr1lYV6ivjiVcN3XfilV8BCi8yaigHBhPOvwdtiY2Zxyv4vNONtfm4GNuuu25lxDfJKJ7rbO8MK7X7PuFNhC5HILolmgod5jzaW0URB1GWR3D/c8O9qfAetSfroGN7f0StnjB3lB56VnmbbtNHdTUVtjN8sENyMbfVAsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Cq4PjwR+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F7HBv0021930;
	Tue, 15 Jul 2025 04:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ubRYq
	BIjCj3mZbT9HxemmEuCm6A1jj1svN9C6SKA9QA=; b=Cq4PjwR+9/RQDYxDXHXZC
	7ysfEB6cvjlPvq5BTbOXJE47AAtx+EcgIn7iygtChvWMY1LbeSs8ClaosxR6SVHp
	3P/tBqy/yO9/5DXvl5T2yHq9AhtwdL5DBMPbIlt23d1GGaob6ejpU2LVXxwQC/6z
	X0Wv3OVEOuvwp1hShW9tJX/kLoUpHInVUp+B620J8jblLoyNcyhUVlomqarwLUNF
	6QMcv4tE4PZ05UfWWbNp6S8D6x5/QvJwCGsQM3436pj8RFQl5PwlK5P9Ze1USCCF
	XjOQ3XEhTGGi/JHsFB7YGfsf087SPEn6Q7wFY/Ck/LfX1/YOpXhe9GTqliYe49Nk
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 47uq0ccecp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 04:56:42 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 56F8ufel062538
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Jul 2025 04:56:41 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 15 Jul 2025 04:56:41 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 15 Jul 2025 04:56:41 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 15 Jul 2025 04:56:41 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.81])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 56F8uRA5019186;
	Tue, 15 Jul 2025 04:56:37 -0400
From: Jorge Marques <jorge.marques@analog.com>
Date: Tue, 15 Jul 2025 10:56:03 +0200
Subject: [PATCH v5 1/2] dt-bindings: i3c: Add adi-i3c-master
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250715-adi-i3c-master-v5-1-c89434cbaf5e@analog.com>
References: <20250715-adi-i3c-master-v5-0-c89434cbaf5e@analog.com>
In-Reply-To: <20250715-adi-i3c-master-v5-0-c89434cbaf5e@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752569787; l=2966;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=hos6iVk11QyXI+zX7kx2DTvqzJd8iugClhi7esuRW5c=;
 b=4cCLBSVuE6YbUTTcJZfcVVvQ1HRFEvsne2s01vvu9eenPfjjX5/2MMclusjE/A6iqya+NBnfP
 6f269oC5J3eBniBPBm1VD5n5s2Deau2Hm1Oy6yWII6a3jBI2LdgPMK5
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4MCBTYWx0ZWRfX3cKHhppdFAgb
 5D8oMdaL1zADYGu5Bh37+wEsbHasJ6MIL3JBsDTAfp77a2ho1ZVhFrwwCLi2otqM3AaUXtBWNv/
 R5oYdnc/akkiK/SRZJqDS8DTqY7fIanejikZraVWslz8B8Urd9ootHsTl9JE9lbEUTWZrIUt/DX
 FEjnOCHWWZJG/n8KtFn7Qk2M5UI0tKbi5gM8zBP8afeYl+HSPm7JCoNf5OliWSs7kZnhD3dBu60
 CuQW65zpi1ERkaPZFUF4MeoudZaJDLPOouyMqpkxxQpq0QhSwtGRxizNwZjajo6GF0bWW4FdOv9
 Ostfk72sHjI8w5J/V+B2upordvi8h9x7bDVxzpWa/TIpuPZhemZ6vRJ5YJJI3Jc/j86gDhRXEps
 mGeKUKBwahBrgk2bva37Fw1QXU2zuCRYkbqkPAvX1U04GXvhAv3NT+CjodzrBDyGA18nrAB7
X-Authority-Analysis: v=2.4 cv=MohS63ae c=1 sm=1 tr=0 ts=687617ca cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=gEfo2CItAAAA:8 a=wI1k2SEZAAAA:8
 a=gAnH3GRIAAAA:8 a=Br2UW1UjAAAA:8 a=Q2ZsWLbW85TiznQkgggA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22 a=6HWbV-4b7c7AdzY24d_u:22
 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: CtmzXqIjPMtc-VHzcipkRrLjbSi_8jUm
X-Proofpoint-ORIG-GUID: CtmzXqIjPMtc-VHzcipkRrLjbSi_8jUm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=860
 lowpriorityscore=0 mlxscore=0 phishscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150080

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


