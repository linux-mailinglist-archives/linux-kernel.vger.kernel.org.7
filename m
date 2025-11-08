Return-Path: <linux-kernel+bounces-891473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 654F0C42BA7
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 12:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C78503463D1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 11:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C3D30100F;
	Sat,  8 Nov 2025 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wGUfeN3o"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012052.outbound.protection.outlook.com [40.107.200.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC7E21ABC1;
	Sat,  8 Nov 2025 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762600132; cv=fail; b=bfeoZJuYtiSJzxOS4TxHCGTRdv8MwSvSzoKlQGjA82j+mnqIMIpriI0JbYSAw2UwFrhe9kOf3fhiug4yVAVGFDVjCd6GtuSE5PRH1WrZnzOmzO3LpnOZKviTv0DIEOvsjEEpVg213MEBAmZQg5UO1bBEp3Ix0C4CD2lhUzFyRGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762600132; c=relaxed/simple;
	bh=zZDc1ZOBWonslGaqYPUzo2wRL+5cz6LKhrZC6YFG7jI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tM1bI9+UYbwdXWW1e6XaASIM2+8VgzbDDxiUFb08qu+wufSEGrNQES4Jh6TTMFMDcQ1ebNNmdcq0xhqXRJF9Uo+mrZAW9QhkyRWOaGS9CWc/I1WEgHzB5ABfdakhPRE3lWQV0PbwdDwca7v6avVDAdX6RG9ez5rZrYy9pntem9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wGUfeN3o; arc=fail smtp.client-ip=40.107.200.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPH3OGNvtBH7pXZvHvwSFESvATVcazRUPtih8dp55H8ETu2VF2QcJ6WKn9eevyb/+9wEM8UA5sn/8zWYhZ7yDOpD+0CaJT4zOJxujs+qMCj32JBUZWZXvDnVjaX+RlP4IjSFNPaTDsW3q3Sj/8cvqhUJSEYNo6/C5FdIDhqohewPHttcXNFg51DcydSm0upv87FKFdgzs+orK3FS/sqvl8WYfIybMVF+Bw2X4JpBDerAVSfYw45bgK1xutCm2MBwrkW79oHmVoL6rwLU2M1JCEhD2g5mKhzFQ0Uo1jLeYP5zVJ/d2Px2dHmr4SM2kqyEXPNvIVIqge5i6p+aqU3emQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ib4QUkl485ytfnL1PRX2696HuAy8YWPA2zJKN+PSvWk=;
 b=J1oGb+4DpPsGQazHrJpAICuPlEQyS4x0NKihbpG/25knEfyPhNzeq10KqBa77O9OVnmq5tVgWarR9yu4eHGybw1xH3kUAoYOeTFvtm03Y+0idZA37GH5KAx6zz/9jbhRbkSnvGzbtCY5qLQP7u+LSZbpEy6EUWvHKDGVSnanTH22+BYSA730V8K+ssm7sa0HGn5D9L8v2/fE8132rq/8AgPFqvl/tpNM7BaX4kOrH/GSuQtkU0qSiZ5FIW2fNaNbPlwnNyUgihJ+n7MEMTC6kBHNZMOsH1BxTjwt8aw+Wbue0ns8ZEfJ1JUBdbEDvCT91Ti96qgPk9hn6JTv1PAQIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=google.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ib4QUkl485ytfnL1PRX2696HuAy8YWPA2zJKN+PSvWk=;
 b=wGUfeN3oVa0EwBJwGCUP3EBb13HQWpEXJXzbnl/rzu6I4Dj1A+KSnaAkDgyZKXcqem1J6nnBvYBXAP/0NI8DfVciZhjLCzn4YEqwa1KiKN5pIVs4G1w7g5ix3jdyUigbnyUwIRQcTH8EBHgY5uwm+mKkU38cdAbF3CjWRYD/PL4=
Received: from MW4PR03CA0157.namprd03.prod.outlook.com (2603:10b6:303:8d::12)
 by DS7PR10MB7347.namprd10.prod.outlook.com (2603:10b6:8:eb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Sat, 8 Nov
 2025 11:08:45 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:303:8d:cafe::73) by MW4PR03CA0157.outlook.office365.com
 (2603:10b6:303:8d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Sat,
 8 Nov 2025 11:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Sat, 8 Nov 2025 11:08:44 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 8 Nov
 2025 05:08:40 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 8 Nov
 2025 05:08:40 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 8 Nov 2025 05:08:40 -0600
Received: from lelvem-mr05.itg.ti.com ([10.250.165.138])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A8B8OGf356676;
	Sat, 8 Nov 2025 05:08:33 -0600
From: Baojun Xu <baojun.xu@ti.com>
To: <broonie@kernel.org>, <tiwai@suse.de>
CC: <andriy.shevchenko@linux.intel.com>, <13916275206@139.com>,
	<shenghao-ding@ti.com>, <baojun.xu@ti.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<k-yi@ti.com>, <henry.lo@ti.com>, <robinchen@ti.com>, <jesse-ji@ti.com>,
	<will-wang@ti.com>, <jim.shil@goertek.com>, <toastcheng@google.com>,
	<chinkaiting@google.com>
Subject: [PATCH v1 2/2] ASoC: dt-bindings: ti,tas2781: Add TAS2568/5806M/5806MD/5830 support
Date: Sat, 8 Nov 2025 19:07:59 +0800
Message-ID: <20251108110759.2409-2-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20251108110759.2409-1-baojun.xu@ti.com>
References: <20251108110759.2409-1-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|DS7PR10MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: f95d0a27-6e7a-49bf-18db-08de1eb72eb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BwzbubKANNhnDtMq6pC1PZ+lRtTzqtldDrOvlpsQbmfNdiTRohEsQqegymBV?=
 =?us-ascii?Q?/bN4wGz/lJxuttwxeRtxslugA3udpW9nKh86a0srTAsoZjzptnJYl3CiqNmZ?=
 =?us-ascii?Q?grVdKdOlqtDg1INztcyVpaXsZL74QFAxQqEfuGEPqpalScCVzi9eRCUR18oX?=
 =?us-ascii?Q?/SfG87vg/9p+bpNnLcg6LRGWncXs71KWyHscLo8Ckkr94lO52M1DdQUbYgMa?=
 =?us-ascii?Q?TKchZZiBhUFXdr1LzYATlhgKCS7I47n1pDsLfCdfj4v3lH3xFFCi4ztnbkTV?=
 =?us-ascii?Q?OFllwkb8PLzKdhDt5a2r59KE72MPBzKcRzktc5L3jVlRZLsstoQyR6UVh5uL?=
 =?us-ascii?Q?GmBK2iB/uCSa9sYT6/Y2pJAuh7R7Muy4t5XXsQp1s7XRex23R47+aclGRboY?=
 =?us-ascii?Q?Pa+dGlAsj1vA2HKosHcqobSiillUnF2JnXDMWZuW+t8JaBE97M7ca2NeAe3g?=
 =?us-ascii?Q?IZLd/SNjUIlKD86U0buEiQ/rdf7A/JDyFkI//TObAMCQdBLmp9m61v1vN9yV?=
 =?us-ascii?Q?IvSo37KhJM8ToGb5YGEg1H83IAOh6K6AFwHdJQ/vfE5fT1vJl9Ee7CVpEgH7?=
 =?us-ascii?Q?+OWzqTtmK/UcrEIuIrvl66Jqa1yCO5e3Nk5j+uQWE7MtDwUVkly+y0e0GWOe?=
 =?us-ascii?Q?/QWjZ4g3yCWO9RGdk9aRLeurvrshYJ0M5YVF/oU0808u3j7dEN+174DFjTem?=
 =?us-ascii?Q?RKzxTilJnELxoTjVVZPzuSGVUDxc+bO10Fkd1gIRKt7F1oaiXdqHGTkQrnEY?=
 =?us-ascii?Q?d7Zk+eloxl0t26u47DYabeTiaVMykrodNAllp4BsAhjZR8Yf2WT9bw3+cTvx?=
 =?us-ascii?Q?LuADWNo6vFxxuqnwtOavGYVOb9zftG5R1a0tgRguGa2A1sgBT9ETrr3csqFY?=
 =?us-ascii?Q?AZ1vy7Td2dBFe5ZDjclrxCMuQm325NeuZPdbpJsx0KM/2F/sGI3WLKagSC5p?=
 =?us-ascii?Q?tnkU5sZBBCF5McSscp6qN0pVV+7q48xJUU96CMmcPPb9F2is5mBe5zD9XoAx?=
 =?us-ascii?Q?sXoQDPA1ZWZEFOPHg9QuCLFsCrfefxvCxNqNTKAprAtg5s9lXfDcAVRGEsQj?=
 =?us-ascii?Q?ToBvpLtsrnvgDOXn+uwJin2LVQ152MeAvizz5PnA+TJrQ6mCQLKrj2pZeqIM?=
 =?us-ascii?Q?2n6701rwCxZD+njJ7QlANk4oZYe/ejtgIhG/Ez9pEoio9SsbnWkMP2cEHLlU?=
 =?us-ascii?Q?/1y41RHM3ImVkcu6STIBqXThJXe0mbiX1Hwd6vOYKibeZ98fQGy/YG3qzjpl?=
 =?us-ascii?Q?VMaS5q4DlsQtLNj88YWI+LN1x+fvxxfXwUCkXCDmtMLZNF/lNvzEvh+76t7S?=
 =?us-ascii?Q?ybF6+wqgmtIgUQqzQnF2pBUoJSz7xpLMJl86CxX3fabDvVozaHBgj/Cvvb5f?=
 =?us-ascii?Q?OXUVQIZncxUw/BoopbV3ryYt01q4fHLJY68f7kGjPi4fl4TTUJvvP34E7jpR?=
 =?us-ascii?Q?05l4chVlngnxEXqQp4eA/kF0pwzhNV2YdUDCbhbMc0agYe9gzC3AvIzEByjQ?=
 =?us-ascii?Q?l5WYhKf/KL9DgAIu/trwMfRpSmjDs4E8ecXVxJS81zhSiymZ959RCalt6HaI?=
 =?us-ascii?Q?j5WIRd65MUish7NINHs=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 11:08:44.3326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f95d0a27-6e7a-49bf-18db-08de1eb72eb0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7347

TAS5806M, TAS5806MD and TAS5830 is in same family with TAS58XX.
TAS2568 is in family with TAS257X.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 .../devicetree/bindings/sound/ti,tas2781.yaml | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
index f0bb5faf55c8..918f1ebdfb7e 100644
--- a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
@@ -35,11 +35,14 @@ description: |
     https://www.ti.com/lit/gpn/tas2563
     https://www.ti.com/lit/gpn/tas2572
     https://www.ti.com/lit/gpn/tas2781
+    https://www.ti.com/lit/gpn/tas5806m
+    https://www.ti.com/lit/gpn/tas5806md
     https://www.ti.com/lit/gpn/tas5815
     https://www.ti.com/lit/gpn/tas5822m
     https://www.ti.com/lit/gpn/tas5825m
     https://www.ti.com/lit/gpn/tas5827
     https://www.ti.com/lit/gpn/tas5828m
+    https://www.ti.com/lit/gpn/tas5830
 
 properties:
   compatible:
@@ -58,6 +61,9 @@ properties:
       ti,tas2563: 6.1-W Boosted Class-D Audio Amplifier With Integrated
       DSP and IV Sense, 16/20/24/32bit stereo I2S or multichannel TDM.
 
+      ti,tas2568: 5.3-W Digital Input Smart Amp with I/V Sense and Integrated
+      10.75-V Class-H Boost
+
       ti,tas2570: 5.8-W Digital Input smart amp with I/V sense and integrated
       11-V Class-H Boost
 
@@ -72,6 +78,14 @@ properties:
       Audio Amplifier with 96-Khz Extended Processing and Low Idle Power
       Dissipation.
 
+      ti,tas5806m: 23-W, Inductor-Less, Digital Input, Stereo, Closed-Loop
+      Class-D Audio Amplifier with Enhanced Processing and Low Power
+      Dissipation.
+
+      ti,tas5806md: 23-W, Inductor-Less, Digital Input, Stereo, Closed-Loop
+      Class-D Audio Amplifier with Enhanced Processing and DirectPath(TM)
+      HP Driver
+
       ti,tas5815: 30-W, Digital Input, Stereo, Closed-loop Class-D Audio
       Amplifier with 96 kHz Enhanced Processing
 
@@ -86,6 +100,9 @@ properties:
 
       ti,tas5828: 50-W Stereo, Digital Input, High Efficiency Closed-Loop
       Class-D Amplifier with Hybrid-Pro Algorithm
+
+      ti,tas5830: 65-W Stereo, Digital Input, High Efficiency Closed-Loop
+      Class-D Amplifier with Class-H Algorithm
     oneOf:
       - items:
           - enum:
@@ -94,14 +111,18 @@ properties:
               - ti,tas2120
               - ti,tas2320
               - ti,tas2563
+              - ti,tas2568
               - ti,tas2570
               - ti,tas2572
               - ti,tas5802
+              - ti,tas5806m
+              - ti,tas5806md
               - ti,tas5815
               - ti,tas5822
               - ti,tas5825
               - ti,tas5827
               - ti,tas5828
+              - ti,tas5830
           - const: ti,tas2781
       - enum:
           - ti,tas2781
@@ -137,6 +158,7 @@ allOf:
               - ti,tas2118
               - ti,tas2120
               - ti,tas2320
+              - ti,tas2568
     then:
       properties:
         reg:
@@ -217,6 +239,8 @@ allOf:
         compatible:
           contains:
             enum:
+              - ti,tas5806m
+              - ti,tas5806md
               - ti,tas5822
     then:
       properties:
@@ -233,6 +257,7 @@ allOf:
             enum:
               - ti,tas5827
               - ti,tas5828
+              - ti,tas5830
     then:
       properties:
         reg:
-- 
2.25.1


