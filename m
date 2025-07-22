Return-Path: <linux-kernel+bounces-740270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FAAB0D211
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832A41C21E5E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBA1272E6B;
	Tue, 22 Jul 2025 06:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="06//BmhD"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5996F2BF3CF;
	Tue, 22 Jul 2025 06:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753167004; cv=fail; b=Hkxrgl+lWRVUfbnuCDRWWfuAAM8GF+di/oiSRqZLKN0KhZ3jy0zC5cgBRSRsEv3f4g545Aho+frosGh5x8jHFpYzLLJJyYBTS0/q0fvBZfVfDlSSLtudn0KFXqjLz+gqQATmiilSsjEvaCgUxEi2M1+Ca9iS2LPp8YPRzyy38ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753167004; c=relaxed/simple;
	bh=IQpOqi9yDfTlrAd98h0DcfUuVxBUCXVK8fjk64QH9Cw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oRB5TR+W0nksCmeD7j8sifhfDhbKqvN3WLZbrpPQqSPV7kngEvshz3z1BpB7/qcsJzvBXrdF0ypTBgGxrJ9n/gRygh7jSFZwR1VwwDi3VJZuokXeqhylmC6Bh+f/dyFizZClD/wJq6rjMXseKvKXt9c161TV5iC7B/JuFufgmLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=06//BmhD; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRecqizvpaIUgf+pxrfMt/+aG4NY1U8oVfEu5RcLFAmUh9YgJSKGgAL/N01ea+mU2H4N+0snRlJ1cC7MhbNyY2twJBxWryiP0y8D332L9xgT63naWF7rZLmwULh9Q4bA7NdlvOumljibAvQU6zf2NVrKlEL40ctKjeXeg+QmMOisJ89M4sTXTfKvkRlapvjONrbN3pqCQKeBoXvUDl5IROuQFcDpcVYDm1VqWhv3ULiFvXURZNsty7OZg4QLD4rwuKIFWnSJQ1l3oOrhZGl2RXyuuZjLjM3vmzl7UZZDvrNrnCDCtbck4ESzMoDQ+zls6djAc0LxcmknsKUfZlnSDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LvDyrAPbnb5pS9lo4AgL367xCWvRNqh3eloM/faNIY=;
 b=bkfD8GUBVE9htnERaiuyBF05dRvHTqEwcFgJzMPimK+MK+CPejhvw6uXcBUEZC8v/c2MQdG2EnfGtS/7fLBx0zS4xbZjneQC9lqwm29hcSx99KgV+9W2goDIYhiOvEXldNdqp4m25GGfgYs6BucR0UGr1mMDFDShQNaUfuXEbNKLk4lDWVB68sKqs0igg/E0dPzVzmK4j/Yl5yR6JT6i7mP7cKImXD3OY9BDcD8JymgN3VQ7YnGqpJFgUKtdZPzoY24GiEGwMBCixnWHLX0bS1upF8rLLVxEXflpjhEGfKzczVWsbNKWQLc6HrmOfNwuoc3okz5AJED5QYQvF/Qqfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LvDyrAPbnb5pS9lo4AgL367xCWvRNqh3eloM/faNIY=;
 b=06//BmhDwkcvnCKO+N4nd1FceFT1w8rubPbG3JR2dyopgJvWrQ0b47vGJ3eW31zkADTHSUcaThW6YiYAmpjh75zEMtrSt0a0YVBpW8noi9db//i2Th1BUQ8wg3JWBnDcvlzxJXL02LI3OLmUL15jXc5xBlbmOGIvnoVuL+vkEOQ=
Received: from BN0PR10CA0001.namprd10.prod.outlook.com (2603:10b6:408:143::31)
 by LV3PR12MB9142.namprd12.prod.outlook.com (2603:10b6:408:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 06:49:58 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::1a) by BN0PR10CA0001.outlook.office365.com
 (2603:10b6:408:143::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Tue,
 22 Jul 2025 06:49:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 06:49:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 01:49:56 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 01:49:55 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 01:49:54 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS" <devicetree@vger.kernel.org>
Subject: [PATCH] dt-bindings: interrupt-controller: Add Xilinx INTC binding
Date: Tue, 22 Jul 2025 08:49:42 +0200
Message-ID: <6ddaf6f1e3748cdeda2e2e32ee69343a06c60dcb.1753166980.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3779; i=michal.simek@amd.com; h=from:subject:message-id; bh=IQpOqi9yDfTlrAd98h0DcfUuVxBUCXVK8fjk64QH9Cw=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTUm7T/dje40nhiapPG313nH+9Z/UNu4SdBY72LIUWMs 298LNff31HKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATCf7DyPDu1x+bTNeU96VV LhWy+xpN4sO5vNtSTIo2XNgk3/IxIpuR4bwVp9pl+81fjx35dov1XorxsknzZlZbbmRgNi2Wtji +kwcA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|LV3PR12MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: b4d67c0c-fe0c-43d5-3453-08ddc8ebf993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/A7FnIMKugcTjPcTs42Ih2JXsaj+m895FYk8PVUX5pYmtY8M3tGkAWe8XsE8?=
 =?us-ascii?Q?nbK6PQnyNaOa4gDge1AlTk5UI/HnQEwtF3iquM3HIOhuYGxN3v/0MfnRUelu?=
 =?us-ascii?Q?LuBF02oCR+uxG1cbqZ/y8KCA1XZlmXk7pm5cQjIkOLvXO2U46Ma6eykam3Qg?=
 =?us-ascii?Q?9+vga0+vT7LooqNORFIEYJ8y20WKNNqTOMPALAzWncGtGBdPhze4A0vStLKT?=
 =?us-ascii?Q?Vy4eLXL69du9E064pgwuhgoJOTIqFhGGOVdzOJ8Q+plStEaUDMxCFYkoC4/Q?=
 =?us-ascii?Q?eW3PNSSfIO37aQjTcB7QWdtmHHg0KPCMvxfpbwRe0ib/Kj8pRWLHS/y0xdqv?=
 =?us-ascii?Q?X7oZcYnmfIXiuq1aLZ8Vd75R8zDudBm+2khQxkPt52jSvXyxRkkcMeM2tQLV?=
 =?us-ascii?Q?YMgD33Cy0lg+fWk4/8KNOFon9/Uo3UxPgSzCWYBe/1eD2kfqF5+snjgsh2CZ?=
 =?us-ascii?Q?urMn0FF2SQAPavUhHB2u+w3uGSReqWOZ/BRiCZMyk9Bexazht2tTUtMUXGm8?=
 =?us-ascii?Q?u62j21ypYwlhXkVXKpS9eOB2A9SXmoOC5XyVCXGUqkQIJbdfr9Ywo3CHpoEC?=
 =?us-ascii?Q?Qr3sE8pMLZ0ljYti1NP4pSgcD8CQb4Fx6QbAcs21eZWcSbUGxclXqNAgQvUE?=
 =?us-ascii?Q?2EkN6P1FAnKA+xwOEnuzJnzhuV31sqJnOKshB1hlnGHMPpTrQTdjF5+a8PXJ?=
 =?us-ascii?Q?I+VGPhJ4G/ykxbKhGkwK275IQncZiQavPXHkq6Xe/R24sZruqBLegVMi+hVI?=
 =?us-ascii?Q?hFUNHx0W+SP1nQrrqMgXygJ09CalUvdc/mctIkp/d9/x1x4jwPHoY4z1Mkqp?=
 =?us-ascii?Q?QWyKpZ+e0ImUpwYdkJbu0kLciNK9yh5/JJZ8FccGqQnCjsKjGhi2GpaHUamD?=
 =?us-ascii?Q?0/XsO+bsZGccLCy9z8WaVklBrWjCr2Yr1n0/uFaPSN+y4UbD7Al2bq4wCWoV?=
 =?us-ascii?Q?IZxp6ULXbCdiLrg1LxohsP3Sz3/01R8q9iDBLwZ/Dyovud4zQOgBU3/lUI9/?=
 =?us-ascii?Q?HwDmt7l9kozqBjPONQhrzZ5r8ALrCpsP7gZjWU7h3m3BkxgzIV/52wyGJY5B?=
 =?us-ascii?Q?NZSL/Dt4bSb/V0BrUwi+zcS20jqZeoFimQCZ6ODPZ6q2YTDRdp0aX94AohzB?=
 =?us-ascii?Q?570VewnOt4xDwKCHMrtFlVrRaom3jTOqvtr3wPfkcIQeN0uEyNOGnCQb6Ud6?=
 =?us-ascii?Q?8RRfJ5HqC5yxMrLGLhNoYXCwxx6bjKiD0sOFKIjmZT2oJJ+okLuky4ohUZtt?=
 =?us-ascii?Q?JZTbeXJmZ4Yv9WjfgRFycdwX1zLmG4gd9rOoKj1fmjUp6DPxJx6HOEcux7AZ?=
 =?us-ascii?Q?uFmwee3Y/rVxrdrZH681XbHLkuqA7KXQffigLeHzPgb0yCT0oZLHXpweRxRk?=
 =?us-ascii?Q?UX0svIifrWVaXY4oe16H6E+wXaGHG1WpVecCO+XsYMuEWDGUmllMNHJ8psay?=
 =?us-ascii?Q?tJnwi4wuaVzRszGD/in5OOFscGscJDGtYm5RdSk8r9s2cyRvPJvJYQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 06:49:58.6069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d67c0c-fe0c-43d5-3453-08ddc8ebf993
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9142

Add description for AMD/Xilinx interrupt controller.
IP acts as primary interrupt controller on Microblaze systems or can be
used as secondary interrupt controller on ARM based systems like Zynq,
ZynqMP, Versal or Versal Gen 2. Also as secondary interrupt controller on
Microblaze-V (Risc-V) systems.

Over the years IP exists in multiple variants based on attached bus as OPB,
PLB or AXI that's why generic filename is used.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

https://docs.amd.com/v/u/en-US/pg099-axi-intc
---
 .../interrupt-controller/xlnx,intc.yaml       | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/xlnx,intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/xlnx,intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/xlnx,intc.yaml
new file mode 100644
index 000000000000..816f78d4e8c4
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/xlnx,intc.yaml
@@ -0,0 +1,95 @@
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
+    description:
+      Specifies the number of interrupts supported by the specific
+      implementation of the controller (1-32).
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
+      xlnx,num-intr-inputs = <0x1>;
+    };
+
+  - |
+    /*
+     * Chained Example - The interrupt is chained to hardware
+     * interrupt 61 (29 + 32) of the GIC for Zynq.
+     */
+    interrupt-controller@41800000 {
+      compatible = "xlnx,xps-intc-1.00.a";
+      reg = <0x41800000 0x10000>;
+      #interrupt-cells = <2>;
+      interrupt-controller;
+      interrupts = <0 29 4>;
+      xlnx,kind-of-intr = <0x1>;
+      xlnx,num-intr-inputs = <0x1>;
+    };
-- 
2.43.0


