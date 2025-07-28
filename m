Return-Path: <linux-kernel+bounces-747524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6BBB134C8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C7F1698D2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D70221FBA;
	Mon, 28 Jul 2025 06:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R7eCrlM3"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE505222593;
	Mon, 28 Jul 2025 06:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753683085; cv=fail; b=tQUZzzFsjZ4wh5m4fjVzzWh3R7VvXq94xsB72x1PaWUAXuVgFCgcjU1SLkfHezaMtpgxrsqpjHGEwSCNy/XuReunhRmDlBB9U9QqiTMyFPpZC3mpFCFS7X/idSV+Z+EAiDiPTu3jLd5mfGBT+Sr9jMNmi5eGr1/KZZeFP19E/Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753683085; c=relaxed/simple;
	bh=vPU5VwLt6XTXEXANOjW6TjMdYB4Io5/5sZQurXdgDRQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sgBg+pems80S6+aIoszF4tKhXg1DUcDGOGS15kcFvum607SosBz6hWo0JgXZxEVcODVEwotXVwCAaWRCOZURTpAeF3wgeixtzBsXFemxKhofqMyavUPMTn3CRpEUAdGYuMG3qbChAEpc6946cOITVNGWarqWICHqIwNq0WZ7lAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R7eCrlM3; arc=fail smtp.client-ip=40.107.236.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWSzbw405eyWysHKmAiQlK4Rz49jsIkzBKgvlbR7gcG4LWQEL9L/A92b6ohUlXgvsoi5aNu+vT5WKOSBjdBP9USTKaoiX9F/IIfGIuc4izi3U9MKxpwv68hWGB5MN44z1I+lS235Q8iJXqZoiykSTVJ33w+rU4cM1GayAKla/TdhTdsHML39Z41GtZhWIH2WDZqGTPttGpgCmlPljQY/gOyl6G4c3tcqDdOJaZbEZtHmaH4LFvPTBkApoXgXqya8MWiuWKRtTX9WIasxlXL3s7i3MFvvByz7UbZSFYBKA8hJJTq3Aj17kBLrnEPcpbr5yuE7wtKBQFZ/79q7nto3ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuqCyTnrZ4dzU7jx4kqHaBSQpv1ns4IY0n7BPE+QIrY=;
 b=PukBHG3Vl/s8zpNPQS25pAHAqKeOtPjxZlvuGds/7fnN7Tz+NrPMO7tyVxClMXgLb1UDWmF12p0nn3mrf1Hb7imoSjt5XR37OKKtUbE6bzhrg4/yOYguCi1HfDUoiVd1Ex/PGa9Tq2bQTbkQlAAltRz33doRaJpxuu3fKu5jfBMnTItDbNLD3XZcpCeuBjYXCbrxdrfe8gjchBHAI4PVI6BqnBeVAzanV/iXHby1ijE0FawHu0S9/62hYTJoiyYfyRLPAo5f//2Uq+z1xaPtw0dCdrwgxPBBLGC2UR9lGccHsJmMiL1IRH6jnY5w7CllWyl2tPKAiBLL8yd4OftqHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuqCyTnrZ4dzU7jx4kqHaBSQpv1ns4IY0n7BPE+QIrY=;
 b=R7eCrlM3UbUaBcknjE6f/fGWrPmcyybcZf0MHL1/LXhtfXj3gkQR5cxyauQ1CRpzIpY9XKlUSR2LG3UzgYXKkYunMqdfqD1TFRk4zg0y7bwoDpochS+xZoGezQxD9MEoxOsdJJETpXOKJaF8JdLyS/te9eScO7AUvg6gtYew5Is=
Received: from BY1P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::17)
 by IA1PR12MB8468.namprd12.prod.outlook.com (2603:10b6:208:445::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 06:11:17 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::78) by BY1P220CA0013.outlook.office365.com
 (2603:10b6:a03:59d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.33 via Frontend Transport; Mon,
 28 Jul 2025 06:11:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Mon, 28 Jul 2025 06:11:17 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 01:11:13 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <arnd@arndb.de>, <linux@roeck-us.net>,
	<Anand.Umarji@amd.com>, Akshay Gupta <akshay.gupta@amd.com>, "Naveen Krishna
 Chatradhi" <naveenkrishna.chatradhi@amd.com>
Subject: [PATCH v1 5/5] dt-bindings: misc: Add binding document for SB-RMI I3C
Date: Mon, 28 Jul 2025 06:10:33 +0000
Message-ID: <20250728061033.1604169-5-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250728061033.1604169-1-akshay.gupta@amd.com>
References: <20250728061033.1604169-1-akshay.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|IA1PR12MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b22d1aa-915c-460a-401b-08ddcd9d9053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MhQpUdfVe+h65Y3jhEOdy6ShurWJHHK49BuxfvoUpDofNnhsukTg0npwRBDO?=
 =?us-ascii?Q?poY/HMcQDylU/JEj6or+dswdM6nWCN+9Zhs5Tf25HGrxC9BlnKsbG7DfuaSd?=
 =?us-ascii?Q?2gpmnbKIoEBQv4IFIecTPk3CSC3fJove4RVi1Y85KMyVwmzuBhi3FM7zBZuj?=
 =?us-ascii?Q?jSiR+Gs3i0aj7mQgq2Tk/zBe0yGkPXCld7L0olckoQbfbXVZ4H4lWr7cHU/c?=
 =?us-ascii?Q?mUx4SL8LipNZ3lKA//TJn67/3RI2PKszhjlValQZw2niLI9ns2u7inGvBiuf?=
 =?us-ascii?Q?NrTTmK2z+26j5QdqBL8npXDvJ6BGWSqI45vz5zoR/D05ed6QC/xoQcEMvfSl?=
 =?us-ascii?Q?JYlybFBHsceSyPWPAXasDhpcRDX+vWUubIQDj4UA1MRYQK4cbPmDklOerHW+?=
 =?us-ascii?Q?i59/oyBMPPxl2X7vR19CA6lqos0qvKbqj11HTSbtHfPCD/3T8zOQmwIW/VCJ?=
 =?us-ascii?Q?L2LyAeTNYHafJ+PfzXzgbD12xm3cXuwR91B4OT6XPv/2iXusUjO/HIg3mwcb?=
 =?us-ascii?Q?sgXESfX7maP2qYoONAP7qqhK4Fc8df1P2qprR2UWGgVM2kmPHB1JETaHIbhr?=
 =?us-ascii?Q?4oYYLuraypxEndixXHoTsgSOMh40dhk6LWZa8Q4BAp4fMMQwejRk0wExXFnA?=
 =?us-ascii?Q?DQYrbDTPzG0bvAhDMyPDR+woVKPieI/ZMaCPcLUEtktScKlJ/zE7Vr9LtHqd?=
 =?us-ascii?Q?OYnmY9npQCYF0ROXt4t2hGWbSQjg3tsBVwTY67gNeUvulMZaxdibDWG0yZ1p?=
 =?us-ascii?Q?5CjielqcnR49a2g4XwZYq1wbloeBKzoaKswPIFTlInm5zCdhwfTl4BUVZott?=
 =?us-ascii?Q?7ZkFuXb8LkSbTqRKgT/0m3Lo0oIaiob3FKYhbwHH+ymDxpSel8j/P/zaQZ70?=
 =?us-ascii?Q?UmCu76HqZQjHvt77733DH8IgzRBWmlzaWTO4sN1ciVb0/I5NzWJr8gy1fs2z?=
 =?us-ascii?Q?TDPW/hy8CerXs9TX5q6Moe263oBfkzDeVuLosw8RGHvQeQM82zQbh656EqI2?=
 =?us-ascii?Q?k4Y9/yNg3xXa38JIosuETwr+dpd48rnzP4hkdQBNM3w4fgkkHSw50MTZsmMH?=
 =?us-ascii?Q?tairaIl9UumlHyCKIBn1t6eUfr2TfvvffCJLMAaiTV+/Cx12r4uM1IfAkOue?=
 =?us-ascii?Q?fbMFk586MPDrOD1rZBRCVoSHa03mu9+UlBm7bSTj8gWKa3ZAuikU1BEAChuR?=
 =?us-ascii?Q?HpY4np6ZSyQ1oqB0qdLvkck5/qJwbPWxmyztGlwNLyECayk3QfrgYeIeRPe/?=
 =?us-ascii?Q?MuP/Rdxcy0YfLv4KwAzsDJmY5nzxu4F1OBFc6/o0pY8eniOF7Lco7G3ZQulS?=
 =?us-ascii?Q?SlhmkAfduJCzFMLPMRIhcmL3AcoLhE8c2wRc5shY3uGysoM5k0NEGqXVc07t?=
 =?us-ascii?Q?Qj4sSwyUjY9NQFBaEMK9P1+fkdsHfWaw7Jx3MrW2D69j42jWvgHN3l9B0gmM?=
 =?us-ascii?Q?7cgGsDG6iZpJy+1zQarPmko/54tKqO2qigwL2JLmoTQOrKGnSfIYSA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 06:11:17.0073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b22d1aa-915c-460a-401b-08ddcd9d9053
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8468

- Document the dt-binding for AMD SB-RMI

Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
---
 .../bindings/misc/amd,sbrmi-i3c.yaml          | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/amd,sbrmi-i3c.yaml

diff --git a/Documentation/devicetree/bindings/misc/amd,sbrmi-i3c.yaml b/Documentation/devicetree/bindings/misc/amd,sbrmi-i3c.yaml
new file mode 100644
index 000000000000..1d19571c2095
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/amd,sbrmi-i3c.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/amd,sbrmi-i3c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: >
+  Sideband Remote Management Interface (SB-RMI) compliant
+  AMD SoC.
+
+maintainers:
+  - Akshay Gupta <Akshay.Gupta@amd.com>
+
+description: |
+  SB Remote Management Interface (SB-RMI) is an SMBus compatible
+  interface that reports AMD SoC's Power (normalized Power) using,
+  Mailbox Service Request over I3C interface to BMC.
+  The power attributes in hwmon reports power in microwatts.
+
+properties:
+  reg:
+    - description: |
+        Encodes the static I2C address.
+      Socket 0: 0x3c
+      Socket 1: 0x38
+    - description: |
+        First half of the Provisioned ID (following the PID
+        definition provided by the I3C specification).
+        Contains the manufacturer ID left-shifted by 1 (0x224).
+    - description: |
+        Second half of the Provisioned ID (following the PID
+        definition provided by the I3C specification).
+        Contains the ORing of the part ID left-shifted by 16,
+        the instance ID left-shifted by 12 and extra information (0x00000002).
+
+  assigned-address:
+    - description: |
+	Dynamic address to be assigned to this device. As static address is
+	present, this address is assigned using SETDASA.
+
+required:
+  - reg
+  - assigned-address
+
+additionalProperties: false
+
+examples:
+  - |
+    i3c {
+        /* I3C device with a static I2C address and assigned address. */
+	sbrmi_p0_1: sbrmi@3c,22400000002 {
+		reg = <0x3c 0x224 0x00000002>;
+		assigned-address = <0x3c>;
+	};
+    };
+...
-- 
2.25.1


