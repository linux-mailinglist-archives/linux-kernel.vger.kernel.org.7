Return-Path: <linux-kernel+bounces-881423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E271C282A0
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 17:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F77A189FCFA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 16:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2C9257859;
	Sat,  1 Nov 2025 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QBEAFSxF"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011019.outbound.protection.outlook.com [40.107.208.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4BA248883;
	Sat,  1 Nov 2025 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762014521; cv=fail; b=b186+2WkMJ0ITJeXVqxKWCEv+Yamh3Sm50GRJckYEclRGF0R8NpwQbbppPu+Mxemgb3+VBkHNPepxP77V7e8adcbYgUn4XCeIuu0101o1C3z8Snu7yL951bjD1c1/dQnV0leXC0GFNB3TJn9wALrhOK1KrjOa93X0qlLkF1w0eU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762014521; c=relaxed/simple;
	bh=Iw2eKUyywGvCTGdT9rtdvFlIZZTG9JUHLtgOb79Cbho=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dH3OcyPx0Wchi0/yLsOs3ywfhjD0oqOthZNZFNTimDUvC1+gunB/lKhD2QWDqDV58p/RDso7sOeYKN/D6KMhOxY4zdYjvr1c7TA9TUjigLu6mIBL+Gxa0yfRoZMsWbYn4zxehviWOx4whgZRuhgNHpsivV3eUnz8zuVKlQ1qqv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QBEAFSxF; arc=fail smtp.client-ip=40.107.208.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fEzqUKiXrf/0ciHwaSRTL/Y9Ci7CPxUWuHvSllhpO9aLT1umluC6dcD0yoa1e5UuXBTK8u0tzWINPE2L6lmHIfAYdL8GEhzKvis7xPRcYI8YQtguIXghPHY5CZ1Iy7enZ05gpDWqB2338069+G8McHOYRj84zXu7C6pW32sIaUGIqGkfjczybXDWSw+ra3pP6swTS1+WCmglz2HNSxqKh6yJhtRgsV7iwQVLMoLlVoPtEn0DjgbULbP+UYRSwMqIAUY/oohAX1Ap/nSpQA4iyJPMcxpAYllILGCKG5II4Wv8KcInimyPssAhMz+Wj8wT/035KaJIPNxOQBGg1/L9Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aH/tpmJM+y2IVVNbPdKuUBlhOjAuLonc4VWnT9mO1FQ=;
 b=jBvSbHDcrZ1+x0Xr6OHZvaZH0f08YLvgUPcPCFP9Mn1JV0pHe1otXKjcT7WZq/4QkTjknl84HHUL9IjDIMIxZt874UtkpS82VLgd5fXrLKFOa00SzcfA/HeLg7bjkbycDLse+/HBD+qialAX55hvMs3TodVUukz6YoGDn74MdeMolbz/hl//2Nr+8XPTYqz18RSRpZC5R3PoDgyqhiKLWbanuFBvzyffsHyjPDwcfPxOMFeknODKp7bLsXmQ/oNL13QtmO58gb7vJUH0xadsnCkLxdeqGtshum6qOsdbQT4FS9zAWcGvSQ3WHwdKd9pyTTI2vALy6TWybyX2dC796A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aH/tpmJM+y2IVVNbPdKuUBlhOjAuLonc4VWnT9mO1FQ=;
 b=QBEAFSxFLlY7YimwLUm6LC7u8IMPWJEi8/hz21fWhlS/42NysZxg+KNkwV5nR4pqmoasWXoaksdncBoFLW1B7YOELIQraNxj/fO4ryKBqqEriJBFNDFhv8rI08PDPpf7+ejEDneiczi/qtatQbk1YzO+2PlEzceMQFMp4iTZeWA=
Received: from SJ0PR05CA0038.namprd05.prod.outlook.com (2603:10b6:a03:33f::13)
 by SA5PPF9BB0D8619.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 16:28:35 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:33f:cafe::5d) by SJ0PR05CA0038.outlook.office365.com
 (2603:10b6:a03:33f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.6 via Frontend Transport; Sat, 1
 Nov 2025 16:28:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Sat, 1 Nov 2025 16:28:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sat, 1 Nov
 2025 09:28:34 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 1 Nov
 2025 11:28:33 -0500
Received: from xirengwts09.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sat, 1 Nov 2025 09:28:31 -0700
From: Neal Frager <neal.frager@amd.com>
To: <gregkh@linuxfoundation.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, <git@amd.com>
CC: <michal.simek@amd.com>, <jguittet@witekio.com>,
	<jay.buddhabhatti@amd.com>, <arun.balaji.kannan@amd.com>,
	<senthilnathan.thangaraj@amd.com>, <thomas.hommel@emerson.com>,
	<micheal.saleab@amd.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, Neal Frager <neal.frager@amd.com>
Subject: [PATCH v1 1/1] arm64: dts: xilinx: fix zynqmp opp-table-cpu
Date: Sat, 1 Nov 2025 16:28:29 +0000
Message-ID: <20251101162829.3076855-1-neal.frager@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: neal.frager@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|SA5PPF9BB0D8619:EE_
X-MS-Office365-Filtering-Correlation-Id: 20d1679f-334e-4645-c221-08de1963b471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tYktiARsChM1lZLOmAeUVWfyZVM+dRbUiupHxvmns+VZ7s8OChoYN58rcmn6?=
 =?us-ascii?Q?Q0mL2PbaeUx5b6hsDfx5ESai5QNianv0SKC18FEcS/0RPqzsAzcYttvla6nl?=
 =?us-ascii?Q?mS0TXnnmLOefRe3LbLO0bfnQfwAV3W672kk/8A2K3Wgc1Fm8RckMUMzNSHCb?=
 =?us-ascii?Q?EBiFPY+p2E2MyH/atMUPZ+WtvY/REz/CQxqb1JjbrDctyM7cUO1lY8m/YTIn?=
 =?us-ascii?Q?YI6ZMvMDAItH7QmQ4y1dxOgSJEiHk6nUDhYwrrSdgYcnA9G7r+xfDVjW9W1D?=
 =?us-ascii?Q?C9XxrFyvI/Jlw9bE3QPs+yIMYEjhBYmk/hZgBL96t52J61EY/zuhPxGdPpHm?=
 =?us-ascii?Q?rolyc5ipOI9MfPJ8rdUIAzuKKOaezIXWeSje/GawzY6tDwaIeKYcu/0s0onx?=
 =?us-ascii?Q?d3Yr9n9TclulRE98WIG1kIymq0WQa51l3VGnqwo7iK5iWEljoAzFLgQFFFnI?=
 =?us-ascii?Q?EcBjQ6JxPDg7pxGQ2n2UYOAUYiN+Yv+pkDJJp7PbEOc4W4L8u+VZ6nlppziQ?=
 =?us-ascii?Q?FJFofiefPzO2Y4hubwkFEqtRq3OId6YqBogsFExIBHWvOZ+uDJF2MV/MrVfQ?=
 =?us-ascii?Q?MhfHXjh1TGWMZzv7TdCuWMmVbJMAvsyj3yEn0MwMuW8khvzaCnI1ErH55vdr?=
 =?us-ascii?Q?ol64lEgp4FdC2im90wlFkbBEuqy58HtycVAJBbyKSvSfsYp10U+NPt3+/tMm?=
 =?us-ascii?Q?Q0+mSnHR3DO44szsE2jD/dsB4AAD3Ouho8IK+/jVfUsmrfXL4mTBbJlDmIEr?=
 =?us-ascii?Q?AOckqLVzosExujUlrVqg3RTr8ScXWBkKrTCY6ILp3A5WqTO1xhvEmOyV98P4?=
 =?us-ascii?Q?APk8hJDqCc/bAU9/nNqXnFSHVAQI2kShMXkC59R46vv5p9NBXiPJFEKtQ1Jg?=
 =?us-ascii?Q?+kIIFa61ZRGMHDYRXVoduEqS9BZWtIJuzaOTR8RR7M5fzHI89GI/BjJ1Fy6M?=
 =?us-ascii?Q?ngrU3P/XaKqfHCywNnYdJzjCk1SfqhcxNO5WE29wP7d08q2nzc9D4UpLjXNa?=
 =?us-ascii?Q?f0QQPWyg9vno2tRTrn+Xo8OsWb40QDNNlDL/wq48etBeMRWN92EMUUlFvJ38?=
 =?us-ascii?Q?7QltB24PF1ZKlQytBOSB3g/to3P7gekEaQ5U7ktu9KY+3dUSqylm+owIx3aI?=
 =?us-ascii?Q?FHQyNAPr22qJA90QWzsXhx3Hst4OXtQIKzeSvs6A4ULJH1hQLW72YUdxbNmO?=
 =?us-ascii?Q?XGvL6RFYCqf8vCVyGlzhv0dyhv9Ed/xnrkcTA2w8Kq1U+TFtQpbcYlSmHj4k?=
 =?us-ascii?Q?RydCtNYL/izYLTUiM7xLDS8l6U/md9HUJ2KAJnQ/IBed2YoX3bWACGf2ozdF?=
 =?us-ascii?Q?y8mTaVyrHiRxsHRzLOTIuNQ1GT6cfUzWVd+KF1WO7gyV5A3yyLO6Q4wqSumm?=
 =?us-ascii?Q?7ZjYmO0Ox1tEbwIPi1u3+qroyYstEhpS7ck+Ze5RRygJgXX+dn1jA7A7LKmb?=
 =?us-ascii?Q?rBGw79Ojvlo2kYZc1C+AJn0GNhnT6ojTEECtvwcT2yP7m55CiD1K9bHA2OOy?=
 =?us-ascii?Q?8DGCEvuSLkLDJWiDZauRzMwbvCBVJSC9NXKUgeRRVPhyC8PccpJ3BaEMGicL?=
 =?us-ascii?Q?gRMMvwIM/QJWQECoAho=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 16:28:35.1636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d1679f-334e-4645-c221-08de1963b471
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9BB0D8619

Since the following commit, the zynqmp clk driver uses the common
divider_round_rate() when determining the appropriate clock divider for a
requested clock frequency:
https://github.com/torvalds/linux/commit/1fe15be1fb613534ecbac5f8c3f8744f757d237d

This means that the typical parent clock rate will be 1200000000 based on the
zynqmp pll configuration. If the current zynqmp.dtsi opp-hz values are used,
this will mean the divider calculations are always slightly above the correct
integer divider value meaning they will get rounded up to a divider value
which is one to high. The result of this issue is that the cpu clock speed
will always be one opp lower than the requested clock rate.

For example, the following will occur when requesting 1.2 GHz with the current
zynqmp.dtsi:

root@zynqmp:/sys/kernel/tracing# cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies
299999 399999 599999 1199999
root@zynqmp:/ # echo 1200000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed
root@zynqmp:/ # cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq
600000

To fix this issue, this patch updates the zynqmp opp-table-cpu, so the clock
rates are calculated correctly.

root@zynqmp:/sys/kernel/tracing# cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies
300000 400000 600000 1200000
root@zynqmp:/ # echo 1200000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed
root@zynqmp:/ # cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq
1200000

Signed-off-by: Neal Frager <neal.frager@amd.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 38 +++++++++++++-------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 938b014ca923..484901dcbdba 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -103,25 +103,25 @@ CPU_SLEEP_0: cpu-sleep-0 {
 	cpu_opp_table: opp-table-cpu {
 		compatible = "operating-points-v2";
 		opp-shared;
-		opp00 {
-			opp-hz = /bits/ 64 <1199999988>;
-			opp-microvolt = <1000000>;
-			clock-latency-ns = <500000>;
-		};
-		opp01 {
-			opp-hz = /bits/ 64 <599999994>;
-			opp-microvolt = <1000000>;
-			clock-latency-ns = <500000>;
-		};
-		opp02 {
-			opp-hz = /bits/ 64 <399999996>;
-			opp-microvolt = <1000000>;
-			clock-latency-ns = <500000>;
-		};
-		opp03 {
-			opp-hz = /bits/ 64 <299999997>;
-			opp-microvolt = <1000000>;
-			clock-latency-ns = <500000>;
+		opp-1200000000 {
+			opp-hz = <0x00 0x47868c00>;
+			clock-latency-ns = <0x7a120>;
+			opp-microvolt = <0xf4240>;
+		};
+		opp-600000000 {
+			opp-hz = <0x00 0x23c34600>;
+			clock-latency-ns = <0x7a120>;
+			opp-microvolt = <0xf4240>;
+		};
+		opp-400000000 {
+			opp-hz = <0x00 0x17d78400>;
+			clock-latency-ns = <0x7a120>;
+			opp-microvolt = <0xf4240>;
+		};
+		opp-300000000 {
+			opp-hz = <0x00 0x11e1a300>;
+			clock-latency-ns = <0x7a120>;
+			opp-microvolt = <0xf4240>;
 		};
 	};
 
-- 
2.25.1


