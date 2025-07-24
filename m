Return-Path: <linux-kernel+bounces-744134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A591B10858
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9690BAE1B41
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1885C26B755;
	Thu, 24 Jul 2025 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DZFdRFmy"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805F226B2AC;
	Thu, 24 Jul 2025 11:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753354818; cv=fail; b=PUUjTvJ4mmYOxgZbZitdNJGLBGc2HrksGEpg37wvgL5OX0xSIgAqtKoSchhDPjf+F/OLYWSeu5844OavrFB3lxZOEzddCMJX3QzC0jikA28gmTd4S0OGngf7vK8ipMIO/sEO7lADQU0NfQQq/HV6/tlyFTwjEHlRRhYArj3h5yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753354818; c=relaxed/simple;
	bh=aZ7GxTlfxbjH8q0vBfTyftE5bapKG/Asxqe2LgonH4s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NW9USIkhYEZDiaFQjWqS3Zr/8x2OsQO3w8jsgvP4kGdPyIMBB0S+Nw+sLXwPaels/CinHxdTeNNx6zWluXax2nG9RtUGRWHX0PyXWYzftTlawGCAW669j5ohinkNdh5yzAKAWqk/k40+qyNsMN093eXIxiPJG2w8QN8DwFGrCRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DZFdRFmy; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BcfNPRyEo6tOfnuiptt5xASg6QN37kqlTJNXtoqNMmUMkbjIO/kE9r75+FjvK2Y49OSgLiwGp/YwZ8lDp1k4lCTm0XhVTbloYSEr3Ygx59GL4wMrRSyGUP0xZ7KqaEfRiAZfwSr2pkxfpHjCUpeKJwelO2F1QWoP1hdJOhJyUW4at4SnRW/D1w1kM7l1W/nAU5y6rrOyUN4QKYQpljPgM5D6P4bvaEFXtwL8sut8AAPYqVuxZOawuFgT7Y+vmogNHkh4aW7T5NrUdNUQSAN51G8CLJEWAT0/jjwksmw3ubYWuHcZb4S9qb0moiMmC4VV34JQr2rpeuOChJ05knJMag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8K6XY4LshMIOkrgq0k1elVKNVpg6MmOIWHNdb2cN/c=;
 b=GAlRdLn86DwX5zZuMV+ssWFiByMTkeT1DyvrKW/Qbo+Pvfdo9VEKQAkUqa/ev8DpP5kBk+qoGElA9y2fz9+5hfeQ+5hzzmsPdo/sm7Bp+yDLke/v708y4lrvYWVttx5faDVxpbwSEovrTPOvWq3S1LiMBDK5augcSloQM0DDI/Yz0YbNaz0c3m4gRCMqc52FoSI6GPYyqdLpppBpqq5jB47UCL+3rOTJkzeW8yVc0n5sbYsZxVyZ8RE5GO3UaTMWgSFM16oUCvDBJIH45qQNgLVcHiZuUzl27gNVLGETZ3MAFProGUuI1br+scLTa7mDd9/7RSSxS6xJ507lh1xI6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8K6XY4LshMIOkrgq0k1elVKNVpg6MmOIWHNdb2cN/c=;
 b=DZFdRFmyxWb5L2k/AFxjLCyJy9P1Cn8lwUKwng6pQ8ghhnm0WxTHk6rLRFSqxpSenNj7kekgmc9rTUZwK6JZkvtF1Y/ox8RlFgN2/dLrdegLW14BUug9tTnvF1Ox0wrWrihWqpfUMLW6/YmO0+WWNCD+JYv0eHLCEzys/R7NPO4=
Received: from SJ0PR03CA0172.namprd03.prod.outlook.com (2603:10b6:a03:338::27)
 by DS5PPFD22966BE3.namprd12.prod.outlook.com (2603:10b6:f:fc00::662) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Thu, 24 Jul
 2025 11:00:11 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::e5) by SJ0PR03CA0172.outlook.office365.com
 (2603:10b6:a03:338::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Thu,
 24 Jul 2025 11:00:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Thu, 24 Jul 2025 11:00:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Jul
 2025 05:59:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Jul
 2025 05:58:08 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 24 Jul 2025 05:58:08 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS" <devicetree@vger.kernel.org>
Subject: [PATCH v2] dt-bindings: interrupt-controller: Add missing Xilinx INTC binding
Date: Thu, 24 Jul 2025 12:57:57 +0200
Message-ID: <2b9d4a3a693f501d420da88b8418732ba9def877.1753354675.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3766; i=michal.simek@amd.com; h=from:subject:message-id; bh=aZ7GxTlfxbjH8q0vBfTyftE5bapKG/Asxqe2LgonH4s=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ0Ce56Wtz1eVPUsljepI7337efuZi1pzRahv+k+Z3OR h/hojSpjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZjIUQFGhm0fvZRZpnzqbXFb Oy0wee6ecFepO776z13ui7y1DRSKK2BkmGrq++PO+1MhH2Y7hE97am7DKLXwn8uMhtJbUVv8rO2 nMAEA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|DS5PPFD22966BE3:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ab87c7-06de-45c4-09b3-08ddcaa14231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WnY1GT3S7yDZFDXKGqHeiJ+8Oryo5yAc7nbDM9LXgf5d4BCiUp381XRirkhr?=
 =?us-ascii?Q?jj5FUedsJD7wvzivB1rp4nySdJ1E85/kBwruw4PsoOmuqXqHvRJ0salvgP1T?=
 =?us-ascii?Q?7HHblScxQesWy6U+gXXn0Rdev1dq4/pcYbSGG7Q6sGOQgNDJ6zNXYc7QKzIT?=
 =?us-ascii?Q?LRrC2muootxh66pouyJ8Ib9LXEjSf08ZtsQkMAL7Ez4sQHz3D80vB3vtI7l0?=
 =?us-ascii?Q?N+GhZm83XPWlHOXqRPHF2DWa5ed2+UZtPpIYZ0ZUfn1Ny36ChRvOkb4VF2RQ?=
 =?us-ascii?Q?tGJFPgEXnkpLoRmW8WTn7n/N/zCEJPMQhz+t+vbrtcJ4ddmhuKWKE2QfUUh0?=
 =?us-ascii?Q?79iPI+pCfR3z4kPwbILpMaZIOJmrS8Uj84WO8vkclI1ziJAamDH00klhzCXr?=
 =?us-ascii?Q?8YeCXMdll4Vup6vRand9BcYBWwhwB84uLgK7EpM2fMsc53Ca58IGb+0S3STK?=
 =?us-ascii?Q?s6v6Amz+B3Tect8IcZhxpCKrmqlVAjItPQhgpBeaZWqWUYdmA52rM3buL/U9?=
 =?us-ascii?Q?Ps89KzLjJEihlYMfkGBG7yDgXrbrci9sNW+KHsayA/n+sVhP9qd673olV29p?=
 =?us-ascii?Q?KHk2ZE+RIKr1jW3ABBHO9H7YH9zAK9Ja8pZHNUeKCH2zCySruW5xsbkY6Qjg?=
 =?us-ascii?Q?lvQcL+448W/QiGP9ZFN9ilE0wS6PoDUBpdabo8AywKs+a6cer6vdx0ttCTuo?=
 =?us-ascii?Q?iJqCebes7ZAsptlgRTqdY62hdBRfua2GDeOdjsok1FCaOf0f6UyqlUqRa15l?=
 =?us-ascii?Q?TiY7CZpTOXW9+Oq1AjDG3ybfBwZKUP8QjDgegIfcPP775ugu9Jbl/AH71QyO?=
 =?us-ascii?Q?iWm3r/jAaTa9fRfzLaIvwgk3D6Y4sqduVlUfEJGgo4bU7e1iVXCu9cAECd3U?=
 =?us-ascii?Q?cjWQbWu+GIoUgN0uWf7ltxTFPx7CiQeOjgMeasTnDyMJmeVP2ETFiq/hPasz?=
 =?us-ascii?Q?aJIGuvO4NuOJk0qjYnH+CPC54tOL4Z7KJRDSl09Lk2b8YzVtmwhJmYflXJnp?=
 =?us-ascii?Q?nXYHJIridS2UjfbXpk1AdACjd+w38Pq3z9bT6UUwb8dpQZJsEKTarRTl8CRD?=
 =?us-ascii?Q?x4s32p6PccmTQYspgM26vgDAQTrFACIUCeUS54BjSPePI5AFoouYqyqlLslo?=
 =?us-ascii?Q?lMuFBj3JrFNcnDExm6hIM9Z9zMqpVZ6FjD63lZMd0l5Jp+FkOwoflD4ZqC9f?=
 =?us-ascii?Q?1MG+uJ/zoH4t1JbKol4QVo3Aatl47NaXWaCrl50AMw+Ht3r1WUkIdO0cBsrt?=
 =?us-ascii?Q?MBLsHbFoBoAQXyII85BDI5xyd02YaPh9Pd9v8C28d0K5uxAp5PECtOhO2UqW?=
 =?us-ascii?Q?MWR8EO3rvyAzwPh+xLcUEXUSbM3PiOcUUwP7XMjw+FoNLaSGijU82ecnj8iW?=
 =?us-ascii?Q?VfTSel48J1gkVcekc2zxYkcAfYTPR+ldUklcifetoeye0vouuFJxWSY7r6eJ?=
 =?us-ascii?Q?+aqbXRvdn1cnKAvUfb0oCQXZtmqApycE5gEW34+89kqhr5C8h6N1rw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 11:00:10.4189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ab87c7-06de-45c4-09b3-08ddcaa14231
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFD22966BE3

Add missing description for AMD/Xilinx interrupt controller. The binding is
used by Microblaze before dt-binding even existed but never been
documented properly.

IP acts as primary interrupt controller on Microblaze systems or can be
used as secondary interrupt controller on ARM based systems like Zynq,
ZynqMP, Versal or Versal Gen 2. Also as secondary interrupt controller on
Microblaze-V (Risc-V) systems.

Over the years IP exists in multiple variants based on attached bus as OPB,
PLB or AXI that's why generic filename is used.

Property xlnx,kind-of-intr is in hex because every bit position corresponds
to interrupt line. Controller support mixing edge or level interrupts
together and this is the property which distinguish them.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- update subject and commit message
- drop second example

https://docs.amd.com/v/u/en-US/pg099-axi-intc

---
 .../interrupt-controller/xlnx,intc.yaml       | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/xlnx,intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/xlnx,intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/xlnx,intc.yaml
new file mode 100644
index 000000000000..b4f58ed25993
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/xlnx,intc.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/xlnx,intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Interrupt Controller
+
+maintainers:
+  - Michal Simek <michal.simek@amd.com>
+
+description:
+  The controller is a soft IP core that is configured at build time for the
+  number of interrupts and the type of each interrupt. These details cannot
+  be changed at run time.
+
+properties:
+  compatible:
+    const: xlnx,xps-intc-1.00.a
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  "#interrupt-cells":
+    const: 2
+    description:
+      Specifies the number of cells needed to encode an interrupt source.
+      The value shall be a minimum of 1. The Xilinx device trees typically
+      use 2 but the 2nd value is not used.
+
+  interrupt-controller: true
+
+  interrupts:
+    maxItems: 1
+    description:
+      Specifies the interrupt of the parent controller from which it is chained.
+
+  xlnx,kind-of-intr:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      A 32 bit value specifying the interrupt type for each possible interrupt
+      (1 = edge, 0 = level). The interrupt type typically comes in thru
+      the device tree node of the interrupt generating device, but in this case
+      the interrupt type is determined by the interrupt controller based on how
+      it was implemented.
+
+  xlnx,num-intr-inputs:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 32
+    description:
+      Specifies the number of interrupts supported by the specific
+      implementation of the controller.
+
+required:
+  - reg
+  - "#interrupt-cells"
+  - interrupt-controller
+  - xlnx,kind-of-intr
+  - xlnx,num-intr-inputs
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller@41800000 {
+      compatible = "xlnx,xps-intc-1.00.a";
+      reg = <0x41800000 0x10000>;
+      #interrupt-cells = <2>;
+      interrupt-controller;
+      xlnx,kind-of-intr = <0x1>;
+      xlnx,num-intr-inputs = <1>;
+    };
-- 
2.43.0


