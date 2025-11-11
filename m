Return-Path: <linux-kernel+bounces-894772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BED44C4C01D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DDD96349E7E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66B634B1B0;
	Tue, 11 Nov 2025 07:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5n008yy1"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013037.outbound.protection.outlook.com [40.93.196.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A1134AB1F;
	Tue, 11 Nov 2025 07:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844784; cv=fail; b=FhJwUbsFy8nxtrfr/5ZTHDvW7igBWIWn+Vnj/nHTnINnBwP0o7Prs/0oOu6bXp6F8HUCCtQQCao6e0a1tQOKvKBlpqs+2JqJvqPOCCR7xiJyDjsjGUZyYfUKcDJGWZEoSTat+PeZAjZMobcwdS6tAQ44PG0JuV833HqjGD1v/Rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844784; c=relaxed/simple;
	bh=401j76RmEQvmD2E7Z8yUFRw3yFfCxSNuqi+q50qbSuk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JJyuhtKyBB1ZnMciKClGM/FjJEJBgaW/XCKUSxQBRqvRQJEwY9RH5rCihNVGeJZ1RRzDpbef+FbMNaeo8fw2xYeVdtpW/Z1LIg3wHJyWXskR0j9UIEye/39i0EvSjt6j7lHdSt7/xzK2oudY7Zl9qF3Fn8jxiDBnFV0kCzgL8TU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5n008yy1; arc=fail smtp.client-ip=40.93.196.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOh6LrQpmuC4kmKFlvhHqkeIV3ooN+xEjIZKLzYwE6lPOK2hr3XlXUPs3rCq4MCM0y2a+rTZiJ6sQypfF6/wRPjkb1aQcRqFTyo6/Lv95SsA4k5DkJtRY2IOtnbDf9oJCFTS4OawyGeAwsVFT/fRUwWJhuaA6Wx5MvU0g8aInlZ8pygoIg9uK9pzQkjUzQrAvopeJjSHl6mT+jI1Ck+1STjMOuQ2ivffdThJb0g1bOod9x34CLFpsFDyMQl5PL5QjiEK82c88CdgQikVeBddB6S7zvEqaqagu+1OEbouR2lwodzyVO4dB6AWzwt6XshLzsNB+gYY4q/avHtoGXbLzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFUoaM87RBXkp3Q9tE6wsenPXiXbBNKh0IbOV5695Ak=;
 b=gfEACMkTHfcW2b3gDUJrx1vYc6h2Q8JgQ0yRiCfW/Jn5CEoydSRbjtjBnDVFBvHLRry3cs+MQXfuWlEt1EiqHtEJ/HL1ZQURoP2BCiECNHccHMeiCwtfMNXEKU1BrAmiF9p0IG/Qc1PuYE1Rlp49FAyPVRjC/fL8Sar9OHR5Y5xFeqyu7fqlKwRYsNI1GDiJm7BztrH9cAelM5GgHF+XzSMavTm9OrBpujwyREmkGUfN5Zmsf0jsomoP/g9uTOaCQEQAbFM0liBanVMpZsumZvwxTPadCWqGaG9vMApKsHFmQTJ2knOAC92bZ3CRFi6xS44/TcZ27jhrYIDRm28/Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFUoaM87RBXkp3Q9tE6wsenPXiXbBNKh0IbOV5695Ak=;
 b=5n008yy1IwQjeK7eS6sK6BuBd9lKSnO3jtHKUU7kspE38SjoiOKRQ5arF8ZFFM/hvr0bGF4J/3hP/pI9KapbN7BsVvx9KFRE67eqbfNOPFiYWw3V1q/we8xOcJ+t6Errfy5H2Xy8SZeFMuZwFNqRAH3J3oFFNMX2E8TWfiMy404=
Received: from CH2PR04CA0027.namprd04.prod.outlook.com (2603:10b6:610:52::37)
 by DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.13; Tue, 11 Nov 2025 07:06:17 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::3c) by CH2PR04CA0027.outlook.office365.com
 (2603:10b6:610:52::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 07:05:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 07:06:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 10 Nov
 2025 23:06:03 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Nov
 2025 01:06:02 -0600
Received: from xirengwts09.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 10 Nov 2025 23:06:00 -0800
From: Neal Frager <neal.frager@amd.com>
To: <gregkh@linuxfoundation.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, <git@amd.com>
CC: <michal.simek@amd.com>, <jguittet@witekio.com>,
	<jay.buddhabhatti@amd.com>, <arun.balaji.kannan@amd.com>,
	<senthilnathan.thangaraj@amd.com>, <thomas.hommel@emerson.com>,
	<micheal.saleab@amd.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <peter@korsgaard.com>, Neal Frager
	<neal.frager@amd.com>
Subject: [PATCH v3 1/1] arm64: dts: xilinx: fix zynqmp opp-table-cpu
Date: Tue, 11 Nov 2025 07:05:55 +0000
Message-ID: <20251111070555.1169130-1-neal.frager@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|DS7PR12MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d0099fd-4d0c-428e-d910-08de20f0cf48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TQ1ctWrKATFbNDeoUbxqF8T7iVVw0Iv8hGL+OM71Or3gDLh6Pmq8Qpxbmp62?=
 =?us-ascii?Q?sn69RirChGLDkreISAlGpMrAnRcA/1di/GavaI54enoPwb90UUIrQac/W2kY?=
 =?us-ascii?Q?BtnjAUvhhv88rZmzzhuGULnmtBxfQSxE3ZN8RQ0Rb8VhO43eXdeofx8yaSKk?=
 =?us-ascii?Q?wL3lxrglJU59Id55wEeetsudSQStmihQpTev5tu7ByylkYlDKI3pQOEn1VUk?=
 =?us-ascii?Q?1Ao8A9+Jg+ycyGT0qEi2wvOWpGfcNeBl4tV7raR/0KKiba8aNPqm0WSjMyIl?=
 =?us-ascii?Q?0knOMC28UtXOdHz/cHc1FahA7zuo7OOrVVqhXSx65jJ9QscclfdDzID4tio9?=
 =?us-ascii?Q?OQj0wkg/o/5sKvCLeETPsFwvjw6XzSyqqRpe9/0dPHim7QqWSks39U+E5Ddp?=
 =?us-ascii?Q?Q1teptF1mQMW1sEagQVG9wlZz9M5O7iAFJjO2zgz8UQdMwfyVCD6rT3Jcnra?=
 =?us-ascii?Q?8n6VT7BJfwhXX0YU4VI5lEZaSseLwSmpCrkyFqIXhESBSNAcLqBr3rAZpQN6?=
 =?us-ascii?Q?G13klS57Zly86VXtnslMvF+Fz35ggcQxOMC3SABCO2VwcECqommHgPWgg/pB?=
 =?us-ascii?Q?wJDC5F3UaWcy7A453eiisSuVeJ6gva+0GwbtqH4fhvfId+M/TJsVC4FQWJ2T?=
 =?us-ascii?Q?m76GG7Xl8q1gRe5+fmbFhaRlkuepA9hWc+zgPCE4KdQTP6rQz1iTW68X5doz?=
 =?us-ascii?Q?+Co6U0tvbkMBpd8UWuKm5E6ymmQIk2cPasKGv+G/hjzg4RK6VuFQJ85tN2XF?=
 =?us-ascii?Q?DCnEyiqz83MzDTY8xSD7pF86/zsQuzHuuOT8YVEUbhxW6mMMUaE6RvG2weVS?=
 =?us-ascii?Q?1sYHHbE6CIoI7RXNmvsvZwrV3BFxd7G9tWRcZqgrCFC5ymjPvEVpYX119bb0?=
 =?us-ascii?Q?GQMvtTiaNMkFWyWn2v1WfVLsapsO22tanvVUQvRrqqXFEgsFlwUE1YWYN7iJ?=
 =?us-ascii?Q?GTFK3TrYlOS2cgRia630EkH5MkVwDib7GrHJu/S5ofAVfcyYC5+2FGb7GXTc?=
 =?us-ascii?Q?UC3mc3L8kpK8wdG70WdNHoEm7aBJSg+jEmNVAi6fAW4OjoFWqExTAlQA7GGR?=
 =?us-ascii?Q?7w8NEGJJg3qB1co9I1qlGknjB1TKMGUTyNxEVNqeimT27SYk3gYCKVAlILbP?=
 =?us-ascii?Q?zuP/99v8O7AeZK+4516lZbj6xzc0yqDdBaUDamqsx48OHxaCGZ2yfrmsjbWV?=
 =?us-ascii?Q?5807obM6BK4CX8taO5grltut1Fw3ycYD12NR3HyEcIl06FTa603q0bJzrDrM?=
 =?us-ascii?Q?LMetDmohvXRPufX9eDhB3YC0XCarzTLDO0iZmnws9rcPtI7ZAPIwaENfUI49?=
 =?us-ascii?Q?2QVe3oQ/MkLKH0x/7V7krSsiRuTBlaKIwXBpqEljg9woV8UBXJflL7UNg/nB?=
 =?us-ascii?Q?yVptx/hTy9A1yeGYkmBoUzd8WByLTJsff90kiKEjbU24mxxExzG4YpOjZMCZ?=
 =?us-ascii?Q?ezD8I4iTELICpLb5mf3F5u+ACOcUMb3yX4VUkq9/V3L1SE87blLdEB/eMVmC?=
 =?us-ascii?Q?xcouiFpPDoX+0gHO7iereuCQ7l0urGTfyiPRHrQiKVQeE2kRzMXHYbBmGtQl?=
 =?us-ascii?Q?FtOXdg61oKbPPVlO6wY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 07:06:17.4546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0099fd-4d0c-428e-d910-08de20f0cf48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5741

Since the following commit, the zynqmp clk driver uses the common
divider_round_rate() when determining the appropriate clock divider for a
requested clock frequency:
https://github.com/torvalds/linux/commit/1fe15be1fb613534ecbac5f8c3f8744f757d237d

This means that all the calculations will be in kHz when determining the
appropriate clock divider for a given cpufreq request. The problem with this
is that the zynqmp.dtsi and zynqmp-clk-ccf.dtsi files have frequency
definitions in Hz, so when dividing requested values in kHz, errors can occur
with the rounding.

For example, the current pss_ref_clk frequency is 33333333 Hz which generates
a cpufreq parent clock frequency of 1199999988 Hz which is the same as the
highest opp-table-cpu frequency in the zynqmp.dtsi.

But if a user requests the value 1199999 kHz as recommended in the available
frequencies:

root@zynqmp:/sys/kernel/tracing# cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies
299999 399999 599999 1199999
root@zynqmp:/ # echo 1199999 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed

The calculation will be:
1199999988 / 1199999000 = 1.000001

This will get rounded up to a divider value of 2 giving the following result.

root@zynqmp:/ # cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq
599999

Also, if a user tries to work around this calculation by using any larger
values, it still will not fix the problem because the driver will use the
largest opp in kHz which leads to the same calculation error.

User requests 1200000
root@zynqmp:/ # echo 1200000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed

Driver converts any value greater than 1199999 to the largest opp which is
1199999 and then calculates the divider value with the same calculation.

The calculation will still be:
1199999988 / 1199999000 = 1.000001

This will get rounded up to a divider value of 2 giving the following result.

root@zynqmp:/ # cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq
599999

This means there is no way to configure the zynqmp for the fastest opp using
the current dtsi files.

To fix this issue, this patch updates the zynqmp opp-table-cpu and
pss_ref_clk, so the clock rates are calculated correctly.

root@zynqmp:/sys/kernel/tracing# cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies
300000 400000 600000 1200000
root@zynqmp:/ # echo 1200000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed
root@zynqmp:/ # cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq
1200000

Signed-off-by: Neal Frager <neal.frager@amd.com>
---
V1->V2:
- The clock-latency-ns and opp-microvolt values did not change, so simplify
  the patch by only changing the opp-hz values in decimal format.
V2->V3:
- Improved commit explanation
- Added pss_ref_clk frequency change to the patch
---
 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi |  2 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi         | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
index 52e122fc7c9e..482f432ba7f3 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
@@ -14,7 +14,7 @@ pss_ref_clk: pss-ref-clk {
 		bootph-all;
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-		clock-frequency = <33333333>;
+		clock-frequency = <33333000>;
 		clock-output-names = "pss_ref_clk";
 	};
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 938b014ca923..dd9bd39f61e8 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -103,23 +103,23 @@ CPU_SLEEP_0: cpu-sleep-0 {
 	cpu_opp_table: opp-table-cpu {
 		compatible = "operating-points-v2";
 		opp-shared;
-		opp00 {
-			opp-hz = /bits/ 64 <1199999988>;
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <1000000>;
 			clock-latency-ns = <500000>;
 		};
-		opp01 {
-			opp-hz = /bits/ 64 <599999994>;
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
 			opp-microvolt = <1000000>;
 			clock-latency-ns = <500000>;
 		};
-		opp02 {
-			opp-hz = /bits/ 64 <399999996>;
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
 			opp-microvolt = <1000000>;
 			clock-latency-ns = <500000>;
 		};
-		opp03 {
-			opp-hz = /bits/ 64 <299999997>;
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
 			opp-microvolt = <1000000>;
 			clock-latency-ns = <500000>;
 		};
-- 
2.25.1


