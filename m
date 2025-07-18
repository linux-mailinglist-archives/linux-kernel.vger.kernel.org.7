Return-Path: <linux-kernel+bounces-736721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 402A5B0A0EB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 629A05A71A9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D29E2BE63D;
	Fri, 18 Jul 2025 10:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wamtYogD"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2531A2BE034;
	Fri, 18 Jul 2025 10:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752835548; cv=fail; b=bS05HXcuTP1bEQnpmwI0oE+HLqkGD+XtS8AL97vI03jdn40ri/vdSJjGTMuKpsxZWXgD3tvnn4LNIUAXtjQCQ3yk+53/BvYCNImHC0LVzvmsYAG8XPrYZjj8Z3cfPbJMBcRHoL4BCBDzfgB31QcwfXUJVmO9I0dVZBUc7Qou6E4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752835548; c=relaxed/simple;
	bh=JNnvEzDYPOpyhzjWlLQBOKWaVZZKfIVtQtbmolmiN+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mt5QX9V4ZpVFtKQ5olMQqDRrc4UGl0ggx2w+2m7NlnBR/vd8KzdPeqtMBqt1zDBZmgeHaBTbx767L+elZJGuEMDiZkVjKgZRgP8OjWST1V9UKzVsXmg5MUaLRdVjpy03nLqkFe9C+elZNPR65p2sDHGPPrcsH6QfAG2sdfec/tU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wamtYogD; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHQoqeEs7Nt3xWINi3pAGAmxvtDMPzTtcZ+ttxaKsJUGspOlMTO1VPtm9mGDuD62n+ov1MLYVLfdZDu4dnUBQ4dGs4V1GsPwCigEna2YO8p/4uWP8BdjIlf4jkU35GiqjXudnb9FEhk0AmWK1V9gNwUu46FREN4htbTuVeGLkAAjVdxnJ7GfFGPKkit8AwYcrrusuirKMOvxolftwl3tpjJ7HztkhueDJATbIj72GfI+FwRNUiRYUdQv9YHqrlo728yRYZLlxsdh43RuTabU+A0B4zqXXSUe+NA6URH1ytWIOQyJ+JHIV2RspxVZzRSbR35VG1A5dW9gQ627IsDuhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuAzRdc+9z919FeQ0BazoVshxWb5KkBZl09pmcyjD+s=;
 b=SDrXxZvBDovv0u40pVO69WPPjKnLBgPb+97eQK9xWtKnP89zjLYRYAWac9SSN8rH8+tl/Eck8xq5LLn1b44RocDRYf0OUE/SfXLmJOIY0dgLQX7l1indX/YM9S7w6bMMrIHSO9p7uH7Hz61FKtSgx2vLlp03l0NX11u2BMaLW/hDHSo+7dycbngbCAbM0sk+a+uRTVkejD4HmSowujV3C0JR6UQQCIU0CGL4Z840CtZ1nx0U1hKS/XITOPnJ6Y5VXzV3mykE93CgYud7caCn4QTzmFC8Kom8IK/osTtTfuYLOe9oYRW+achxSqFLNWTSQ5mYnYTSka6G7bYyumrUeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuAzRdc+9z919FeQ0BazoVshxWb5KkBZl09pmcyjD+s=;
 b=wamtYogDk3Qz+RiwUm9H+vhguf34MusSAvw9PSpyQAuiajIXPx5vsiXRy54LQCUt16LWR5RofibWOnyjy3Cm/rF6nipqFqAZ/QvrcIl6L60vuUG2fnZ5Apfg1/HVIPu9VHRV+jUZZB9MPBNyqkukyY5I3AmhsekE1CvcRscR3T8=
Received: from CH2PR04CA0024.namprd04.prod.outlook.com (2603:10b6:610:52::34)
 by CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Fri, 18 Jul
 2025 10:45:41 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::f5) by CH2PR04CA0024.outlook.office365.com
 (2603:10b6:610:52::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Fri,
 18 Jul 2025 10:45:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 10:45:40 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 05:45:39 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 18 Jul 2025 05:45:38 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Vishal Patel <vishal.patel@amd.com>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 5/7] arm64: zynqmp: Fix pwm-fan polarity
Date: Fri, 18 Jul 2025 12:45:10 +0200
Message-ID: <e6dc9ce1e0b97c9d9b073c323cc94a5d7a88b94a.1752835502.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752835501.git.michal.simek@amd.com>
References: <cover.1752835501.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1192; i=michal.simek@amd.com; h=from:subject:message-id; bh=d+EwN/DberzJ8tnfOqJOftFoSI+joEKqTjph90npp0Y=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRUqe6K+C1lJxMfWjXpQ1ZaoO7b50e6dErdVVqPzVyZt 6Prm0p2RykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAExk8WdGhi/qvx8yvjmaJcUg ZX/kDse5HtPEE9NiL26JVuY8Ktt11oSRYeKBvKtcWtw3vpZ2rDm92sTV6N1u7Rq1wDb177s7F9y +xQ4A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|CH2PR12MB4216:EE_
X-MS-Office365-Filtering-Correlation-Id: c563f5cf-003f-4b8f-a0bd-08ddc5e83d5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sarBHT11clj1yOH7U2YUy3AWcIhA5CsJmg1vI5akdWmNuvqddoUBHyTos46t?=
 =?us-ascii?Q?ZDn8axKsf5kTA8xTuXI7wVvH6ujq2M34OiQ+PTDpGG+RzRk3m3c7V4uJDUrt?=
 =?us-ascii?Q?teenDwAKzqBK/tHJKbDsdTr2mx+ng9BUMyyA/Lk0kfq4CRhwArk18JLxfd8o?=
 =?us-ascii?Q?+D+o32Uhhfa/B1g19D5odgJLCKqKypdeA7BF1r1KPjilJWKCk+W2HSs1WkMA?=
 =?us-ascii?Q?Al+Rxn6/SJvJK4TgSeZeaWhs5JPhvpOCg6rAscBBHZlHIwLeVK0lXTaKKbyQ?=
 =?us-ascii?Q?ydy3fmMLu4CYtbOQWnLS4E1jg24u+WRdzsR/UG1oHcreoOyFN5F7gpE1gZ++?=
 =?us-ascii?Q?11Wz4GKcueZ3N+ESl70fapIfhhp45Yf2HXbsmdiAfdzE3mMR9afXqIIX5wi1?=
 =?us-ascii?Q?tjc5pk6hfv9oQAMG8+G2yDN8QeQ1aX3zdN8dwlzAiv9+0HGPKr8kDnyR3+WU?=
 =?us-ascii?Q?T2JBA4/gvhv9n/VzKgztB+GfFv4Gw0BBcqxtSbYXhX0+zqlobts4uZ4AOXYV?=
 =?us-ascii?Q?SnWqo9g2qHvDPXLBgALDYXf4yqiIs55IWmyuJeXdUE0KXpLUavJDbKzs57vQ?=
 =?us-ascii?Q?HA9NOD3bCeGl2VfdlPai3z5esL1kP91s4pAJ/VRdxDabvQNgjRpndRTQ9h2Z?=
 =?us-ascii?Q?N0lpsDEmZav0QmHzgDaraVIJLcyV1jt9rRQJiW+7GwjZ7cu1K6QaZXXlKTcY?=
 =?us-ascii?Q?pwBt4b8CCXv1dHumPiOAeBqC5ZVWIdVDmkz4g1PBN3iEQPI0ingzsUycCj9T?=
 =?us-ascii?Q?eCRdZjoouLFQt3GNe+FMWdeZXGihkUcelv0ZJ2Lpws56ndcUkk8NzghZ9zyN?=
 =?us-ascii?Q?Cg4dAXQf7gbfcTsG4D8WR+0tcfRq+a0MxuD1vcdaaaX9dXEwTaF4D+WuUXDz?=
 =?us-ascii?Q?ZHN/ZcnVhlweD2kkVq0x07WUfCtN00sdZmBe+b3EoIExaaqa9QHnUfCqGhk5?=
 =?us-ascii?Q?xgLrefUUqcMzHTUpChyxxB3Md0Nd7LqMUAlSOB5tiWsVn0G0UAadM5EcC3dK?=
 =?us-ascii?Q?SBg6D1RAeAWkXnTbo/Bq4eIqrFEXgtpBevEHRsQPSn/WMvi8GeOFRvHMGHHL?=
 =?us-ascii?Q?q5kaNX9wVu5wT0HhqCnoSRQ1G3VdlB4qklggxNJKSxqQymQ9x+dqsbUUivMx?=
 =?us-ascii?Q?DZRlcFLegJaQdaJNCnWFX63hlM7myTA6zGfELE8WpTssliR/WIQjk99SPKam?=
 =?us-ascii?Q?H/OEu/B3p6KQz/VHaobxFdMvSuHDOZHCovFLTX+u7c7bLXT2HHnUU1vPsyNm?=
 =?us-ascii?Q?dKP1QRvzrt8Gr6I3osgA+n5AgzubH0nVc66XUR+d8yrKR4Srv8Y5xLX+UCFK?=
 =?us-ascii?Q?YLkSv8zsrFTre2cJKnWGrKR57z7gKnGRRDEdbvsFXCNzNi+/LQJE4LPmWEfg?=
 =?us-ascii?Q?SKhXnyd4pyitAsca6gnWPIc8mffmRFPAn49uWIXyq8kcgIWFqvZAazeVePGv?=
 =?us-ascii?Q?YoAyhHTzVE4g4bUKn6FxhtAThaNVEWO1EghezwhSoPO6wZc4WFJAFfFc+Ae6?=
 =?us-ascii?Q?edBLG3vtJWspi+X7Vy6RTlMCXEmMHQOPv5Q8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 10:45:40.8628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c563f5cf-003f-4b8f-a0bd-08ddc5e83d5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4216

From: Vishal Patel <vishal.patel@amd.com>

The correct operating mode for the fan is inversed (1). The previous pwm
driver implementation had a bug and the polarity information was propagated
incorrectly to the kernel. The normal (0) polarity specified in the device
tree was incorrectly clearing the polarity bit in the counter control
register. After the bug fix, setting the polarity to inversed (1) in the
device tree will clear the polarity bit.
Also provide label for custom description based on this SOM.

Signed-off-by: Vishal Patel <vishal.patel@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
index 51778df5540c..500af1d2232f 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
@@ -90,10 +90,10 @@ ds36-led {
 		};
 	};
 
-	pwm-fan {
+	pwm_fan: pwm-fan {
 		compatible = "pwm-fan";
 		status = "okay";
-		pwms = <&ttc0 2 40000 0>;
+		pwms = <&ttc0 2 40000 1>;
 	};
 };
 
-- 
2.43.0


