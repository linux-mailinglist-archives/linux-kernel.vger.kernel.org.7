Return-Path: <linux-kernel+bounces-736720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D672B0A0EA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 747647B9D65
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4674B2BE035;
	Fri, 18 Jul 2025 10:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wGaz2WF3"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164552BDC27;
	Fri, 18 Jul 2025 10:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752835543; cv=fail; b=b1VvAq0zOMEGOLF0sNDgw2jD9MhaEY4+80EU613XoM2DD1nRfck9MsI39ESt6Gay/HKBjaqnNuox6gqdMp9PDS6Q4P6TmiPhb64JyD9lzKG4oWQy2K7M8sMcT0akSt763M3zthuYlHoX5F5HfK2OPzn2rRZXKm/uQqbLrTjRN10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752835543; c=relaxed/simple;
	bh=5UPokWG7Tzs6sIGeb3i5ftKDbGDQlNZbjN1Vhn/BXUY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBSuoG8jXM39eMC+OQHEBqAHSbFP6V6bPHj83shBs4olRL0W2vW8ZCK+3SAYbKLwvG0CNjCNlVkEkQ8uyT2mvuGv8VpQjHwrX1JlLNhzRHfMty//p+k6IV2Btou3F/u/IwNKd9YBRU84APBsHOHTmBzWVJ6R29qx9oOSK0hGbW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wGaz2WF3; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFoo5FzLEuN6bNMDcvHBUPA5Js1EAThSORC7ynNsIHzDc9IZ3vL/jgCDIatGCngqG4m/a4zi6+JnvFMCDveyYO4AS3BEuRpr4Le455orn6UifgwNR3LW0WGhBg/NaQu1ofjUbenavsLSWGgwD8FYTBoqDungJpRx0xhteZsw3fbNYfszHWkOVCgk1MyjWp4Mqu9LgzWm9d+ULSO0uD2/AwOsGg/aa3soUvFeRXOoKpOXrLWs/ft63a66q1v7/WmanBoOy6D71qtnzpqRFvqNyTiCdQYt8GbSEw1L1xrGnSWL//A/1AqZhlmfn+VNnn9BlIDkKM9shMpcWeW1rQeJBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LIt9rVZaGPozEIznliRxNy7lHEJTS7UvN/PHbdPC6k=;
 b=E3nmdE9uraq3r85GdP8CatANe9kryvrBjmWX5P/gavgA9lGgVC4+E72xaDUeLcGtSllE6FEIlyNdfNMb2i9m573emrdNhxXpGOWGtPCbnwrNNuucnTvc57mR289zAoKeXkRIxWgmwbwj/Ik+NurCfNV8AfqJg8zWXHZ/3LPTdQSsfcvmgefeDWS4Q6EK3wn9K2LYDBEumMZ5eY7QeUnf8GVbr2D42ALjQuZfSu2KLmNOfpVEfuNkJQ4FSvPAJIjgZFq/G45fg7gIOKnQ6zScBJAdcV3urVajFdP0MkQ6WflajsZHBUg2NgZTrNi1NK76iB3PKr5On1GyQebznVA5Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LIt9rVZaGPozEIznliRxNy7lHEJTS7UvN/PHbdPC6k=;
 b=wGaz2WF3As6JPZs+FAVjZbHu0H7S8HqjkpO9WXTRW9LEU7sxckTySY+QLgjSgVOMdAKeovQFc+j1bK1m7Jtc1PG78mySjE1RGyeDDBj4iWz6E2zh8s8GjDUGjFaJycsRdr/Y00fWE5/qSFsbKpdzg/CJRP12n/bQ4tslFL2muNQ=
Received: from SN1PR12CA0071.namprd12.prod.outlook.com (2603:10b6:802:20::42)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 18 Jul
 2025 10:45:38 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:802:20:cafe::87) by SN1PR12CA0071.outlook.office365.com
 (2603:10b6:802:20::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Fri,
 18 Jul 2025 10:45:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 10:45:37 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 05:45:36 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 18 Jul 2025 05:45:35 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, Conor Dooley
	<conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring
	<robh@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS" <devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 4/7] arm64: zynqmp: Update the usb5744 hub node as per binding
Date: Fri, 18 Jul 2025 12:45:09 +0200
Message-ID: <564a09b84dfdce1e54c93e95f9156150e05b8f43.1752835502.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752835501.git.michal.simek@amd.com>
References: <cover.1752835501.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2604; i=michal.simek@amd.com; h=from:subject:message-id; bh=6PWAKUXGfjrmfymYHLZvJK9NpTuchE8l5K2doVnyYps=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRUqe78fkZC6Nq+gJXMX18bPEySa7RwKN1o/fvmbsXXU SXzu537O0pZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAiD3YxMvRy3rvOWzEzrNv5 iKPJ0s4/X/TnKMixq/2WrtSdn8X4gZ+R4dbSreyVH3f+ydl5lnXTOg0GCZF/Yb5nuTb+ZhOKXhS hxA8A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: f19b8394-b3d2-4bd1-b192-08ddc5e83b68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c+h9osoKPyOclj6dmBMI+dPNzy2dWc6X648oHphOjbsk7Mh/sEbJFgmHu4du?=
 =?us-ascii?Q?RlG/1XJaN9KTyYMkNqL8Y+r7ulGI59OslOoOH73SW1qHek+eCcOUG1w07Xll?=
 =?us-ascii?Q?G9KeH2w9YCK3XsE3LYWBPuc506V3yZIv+4Bu8ls5LRBORAYTqMB7a/3DitXr?=
 =?us-ascii?Q?OdhrkJkNqKBPGa+IeWrQXuUjI57CSGALrS94XrXBEwmPLeUoh9aOPoKASral?=
 =?us-ascii?Q?PnDJeqlIM6qDZ99nIipqxjrumVkaGcDWz9QacpTuDhotrhhTtOYU5C2VRYAh?=
 =?us-ascii?Q?9fCkBM2AGYztNcoDqBs6BD7kqiC6BhtQv72UJyIex3n0XSO/vAwdvmSLHQjs?=
 =?us-ascii?Q?8lNTGzbzL+NSG5Y1zpPvr7Dmn2hdOH0nT5+JgjRONijs7tyYdDZAVybaCysX?=
 =?us-ascii?Q?0MmU6CNmN3dqaqTS/mSa9lBeeVl08xgcIpsP87bjhOCU1SipyQWfrYai8fVn?=
 =?us-ascii?Q?QM/frO37BQkCevhcgBMkcMiUgBeUGFbzqplGDwl50AcCggqs6vZV9U235WOj?=
 =?us-ascii?Q?m+AhfAlCuooBP/eEHnTuOo7ov0sXuh9pwxuTlbRyxMoORte7qVg+YoV4b3s2?=
 =?us-ascii?Q?zFvwsHmxRhjRDkpWGSKcTRGmXS/9St7AXgR7K/lq3w+HnWqOiBaUYF42I7Qv?=
 =?us-ascii?Q?w2618TjIK2d386EfoAFd7CQ9vMuB5jNB1AqysdprhkPziOU6mMBfUuPc9AmH?=
 =?us-ascii?Q?36e0FYfJfhxOVd2AIMyYzFS921fufvYSqWR0pjlkhAd/XwguqYjKQPXW2bSa?=
 =?us-ascii?Q?EhOBnXOGOTKXxKdUfj0wL8BMKK7ZY/TDQ5AQzjZ35QT6Vzf79MFZBQloZQXz?=
 =?us-ascii?Q?0HDpyXcGbW+zgBLBKUhbJ419oeMOvOLf1bslOwV0d8cAD50Lh1D5iSdjW81U?=
 =?us-ascii?Q?SPFAJsoO3ZW3cK5XlDkbseY2Tf37+uIN2rL8EA/Qzf4QGFmJFR5KXPLOHD89?=
 =?us-ascii?Q?bCsto9ziKYQEYpnwNtHBIg0qzvUcVpYceiOTQk+B75TU5euoUjuIaGirrGLK?=
 =?us-ascii?Q?XsvFuiZJqVgvDNlwh445ikISNLSJJEBMB/KTqlPr1oMDRluQmXhu+NKOZTj/?=
 =?us-ascii?Q?LljLCbRDquJY5PleF74XO1Qx+JkGvqC71cU6VZGt/3vKpJQ4D3vC/z01L/WB?=
 =?us-ascii?Q?a5k+4NzkyEgHfzDupcaKptTFeY6LEyDhJ5KWCZ1GJ5+6fcupPmeDt1nKfgz4?=
 =?us-ascii?Q?qZt1VCuRnhfVKInnEyC6sN47DaV9Llv+rLvtWwGW8rUoMiatM3b6dVkuTI6a?=
 =?us-ascii?Q?XQTSQFUD/YAHp+bprSIwgsVaIBsdo3g+Y9m5IvhkqDm/cOZ2BONwcQdDfzr3?=
 =?us-ascii?Q?T2BGrpG6w+YOFNvE7L3vunNQHTI1h3Ix1zTTJXxeOkftOMmtGSUFKCOH0vOx?=
 =?us-ascii?Q?q+lRx8osJTETLFQun6jM97pyg/dbB9vs/Yq2edIE07yT825WC+Y2u2RF2j1N?=
 =?us-ascii?Q?d/+zUioJ2hNxx8PbuBvFpuNbbxpT2rjUdNFIhw0u+f27HiI+dQLLRuToqly7?=
 =?us-ascii?Q?6CRYEXzeyaPhfgAUXf0KxRcSaB18bcRvtiPp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 10:45:37.5631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f19b8394-b3d2-4bd1-b192-08ddc5e83b68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153

From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>

Updating the usb5744 hub node as per the latest upstream DT binding.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .../boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 19 +++++++++++++-
 .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 25 ++++++++++++++++++-
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
index 95d16904d765..a98a888d1385 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
@@ -129,7 +129,6 @@ &usb0 {
 	pinctrl-0 = <&pinctrl_usb0_default>;
 	phy-names = "usb3-phy";
 	phys = <&psgtr 2 PHY_TYPE_USB3 0 1>;
-	/* missing usb5744 - u43 */
 };
 
 &dwc3_0 {
@@ -137,6 +136,24 @@ &dwc3_0 {
 	dr_mode = "host";
 	snps,usb3_lpm_capable;
 	maximum-speed = "super-speed";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* 2.0 hub on port 1 */
+	hub_2_0: hub@1 {
+		compatible = "usb424,2744";
+		reg = <1>;
+		peer-hub = <&hub_3_0>;
+		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
+	};
+
+	/* 3.0 hub on port 2 */
+	hub_3_0: hub@2 {
+		compatible = "usb424,5744";
+		reg = <2>;
+		peer-hub = <&hub_2_0>;
+		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &sdhci1 { /* on CC with tuned parameters */
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
index a74d0ac7e07a..7490efea98bd 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
@@ -92,7 +92,10 @@ u14: ina260@40 { /* u14 */
 		label = "ina260-u14";
 		reg = <0x40>;
 	};
-	/* u43 - 0x2d - USB hub */
+	hub: usb-hub@2d {
+		compatible = "microchip,usb5744";
+		reg = <0x2d>;
+	};
 	/* u27 - 0xe0 - STDP4320 DP/HDMI splitter */
 };
 
@@ -138,6 +141,26 @@ &dwc3_0 {
 	dr_mode = "host";
 	snps,usb3_lpm_capable;
 	maximum-speed = "super-speed";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* 2.0 hub on port 1 */
+	hub_2_0: hub@1 {
+		compatible = "usb424,2744";
+		reg = <1>;
+		peer-hub = <&hub_3_0>;
+		i2c-bus = <&hub>;
+		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
+	};
+
+	/* 3.0 hub on port 2 */
+	hub_3_0: hub@2 {
+		compatible = "usb424,5744";
+		reg = <2>;
+		peer-hub = <&hub_2_0>;
+		i2c-bus = <&hub>;
+		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &sdhci1 { /* on CC with tuned parameters */
-- 
2.43.0


