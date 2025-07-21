Return-Path: <linux-kernel+bounces-739744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7BAB0CA57
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA69189A587
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45ED2E0924;
	Mon, 21 Jul 2025 18:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ywqtKjmh"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73C429A9ED
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753121547; cv=fail; b=I+lFB/Odkw1Pmjecf79C5g8/6f01AcEpkcd2yJshDxASIRu9JZSrW+Cj921YWwdpSWbJmkiJjbvyV1bdq49YO1dNJkOQ3E95HLe3a12unHed+baFnHCBpWZE13UJLyCZA1Xgqg8LjiOhWKxif1yxvmnEB48aspGh54nzjYiEsPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753121547; c=relaxed/simple;
	bh=FgN1ctujMyf+2/dnm6ik7fWS1Ttl6vkQUyijCTg3u/o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Coja9N/V2L22ecnO52aHs0tpOi9fvV/Iob4FZl0DAefevMPF1PexFI3G5UHRSwVbL5OH6Y5LUjXMR2jtzOmYjuoFqMIyEiWZypVfzJTR1ln0ir/Yq88Ol6cKkNYoBxR2wy6y6yrxBgEXaJ6H44aqQk4bQYNOoviI+AKbwVI9pV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ywqtKjmh; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqdvpKAH3VV080EK3G2nlLB3+uaYE0RJjyYkUkagTXHaiO5DLBYWcALy3d4PuKdROksWUKC+WvdSD6WY69NahA3wAdd8GNVSnJ+rFIM2dI4f+iaE3/6S06pfGDnKnsOfRZeMbP5JDPiLm0AlqXINlUWqtfHHHgkYjGKAXobU5e2/Uq93KGcNL2nbAWQZ41k/GtnavyDBTp/WzgV/wKlEPNR172CTJa9ygv9hJ0aKiyRGpNFxbVq78hZIKvwOJXpp1dtvUcUkjBFJdvoH8eLTGzem4HrO6BtMsqis1GEhtD433BCzXSFOGBDyIE9sjYrJldoGGccmYOjk4VwBerDkxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFU0+SG9l/fRGXvdZRhNkztrvEor5EOzLrsjdj87Qpk=;
 b=nqqyXZFUGORLb+CNGUMZxNVCKXR+QQukhGW3UdWgjuJvCmOwadksvjMfWfSaiOVZ3QjvlNxifw9ftLAtrlDW8O8HOapZ3rbASjl8aYC9cTYU65wdmNuzgQzhVTgS0fm4scd6qJe83qxmq8DYdYGlOF0NQBZJNjMTyvXbBfkiqn6dYZCr+3hO5F2A+q1PfJRk5IyRfOgNepX3mmhuod7cd38SvLxujr4RMQdchj++zvQ9mAZ3eMrmTpdIgBzHi61zvQJgRGrqmqH9v7fwSD3/MwLQQBDwuDtrk4UdkptzMSGusyfkY+3x2PrGumgfVlB1Y2UvIr7ASKgVeo4xi5X6tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFU0+SG9l/fRGXvdZRhNkztrvEor5EOzLrsjdj87Qpk=;
 b=ywqtKjmhihLA6vMmR4LMPOXJMSGiJ1vm7iul8lKYO72X5cWzAWiy2MHCDnBcQD8YmtFowGC84wKYBU8z4hF7CpVxWxS5DS3n4Ajf/UamOlwWf7ItvQeXDnsvYoQEeRhGAKFo3iFU6Mwza8HNUNUM0l/Fmwm6cppi0JMn5b6caLU=
Received: from MN0PR04CA0030.namprd04.prod.outlook.com (2603:10b6:208:52d::29)
 by IA0PR12MB8693.namprd12.prod.outlook.com (2603:10b6:208:48e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 18:12:22 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:208:52d:cafe::4a) by MN0PR04CA0030.outlook.office365.com
 (2603:10b6:208:52d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Mon,
 21 Jul 2025 18:12:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Mon, 21 Jul 2025 18:12:22 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Jul
 2025 13:12:21 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <x86@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>,
	Libing He <libhe@redhat.com>, David Arcari <darcari@redhat.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH] x86/CPU/AMD: Ignore invalid reset reason value
Date: Mon, 21 Jul 2025 18:11:54 +0000
Message-ID: <20250721181155.3536023-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.50.1
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|IA0PR12MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: 272f1fb5-4c70-489c-b9e0-08ddc8822364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/dJ/8j6ice5MDUMcHW7P6Fy8i3SPHYLrsFEnvUHdMvGytrrYrrpTgMF05Lcp?=
 =?us-ascii?Q?EWLzuFCsluOTh/ev50yJXAPK0Kpn3PfKy4NdIM6RY2iclLTFWnKpOdO1+OZc?=
 =?us-ascii?Q?tgUVGFM9VjzYyyN60iRGrUbbaEzDhi6p+T1GrhjzlfK1/QR3fYyLc1bo7LGt?=
 =?us-ascii?Q?gHJLTVM5ubtMUXB94WVdWNLK6tNSV7I3T1rW12MTsVxQegex8+3nkzI7yDWX?=
 =?us-ascii?Q?oG97Zvh48Gk+k1VScdtuEKFslRakRMoCqQartWfhQL05k3lb3yLDgHr6Lh9p?=
 =?us-ascii?Q?cUw5Zz3Wu9HSQyuJqAb0qiexNc77u/JHcQKB9AgSxZph+m4fyr2o/Cm6jhhU?=
 =?us-ascii?Q?SViNbTDLTgK4SP+3JJZ5BTsM/a+vCJnowDbF6pX09B12+sBBNaMUVxfpRFpu?=
 =?us-ascii?Q?276JLmydi8NP85+k16G7/sRPAmoql1d2geVVVBqZufW8MV6pM/TN2TFgXeuw?=
 =?us-ascii?Q?VsEBhWx0yoPNDL02pI6DPsyWlczZ43PfGxemOZfx7w+vS9PbAMgRO/9C2nbl?=
 =?us-ascii?Q?Lqkz0FGd3fdXellaSOA7AtxkcQ6m32srwdIu51N9Zn+NIR3x/2M6hq2qZEt+?=
 =?us-ascii?Q?oP9Vkl7X2AGvIeYK/4nVVCVeiFmGTyabRQNChJQxD3UWHEaUgYKeS0DF5bbu?=
 =?us-ascii?Q?siPEmXcZpdRLk2izTWNM8C21KE6OFObW6smxBex9ASNsiuSmKiKv2vxIz4MN?=
 =?us-ascii?Q?OhTl/Fhiu/BSL5fajmWWxeHsVvZbWpK6NoE5RKnHTaEIpITGy3jV2Duj0RBe?=
 =?us-ascii?Q?eGSgMXfrNk2fQI4NGHuWsQztv8o145pet4RMhSkJD/ZXxZiwUFTPMRGUoHwr?=
 =?us-ascii?Q?E8OsRYsaP8h0YUuJH+VwcLk2zWeFdhYxU1H8ufz39iedvXxDm3AWhfa6J7PC?=
 =?us-ascii?Q?FgnEUyuotfym3qOGeR9eRAhjDSlK7MCHDTnfIbsR1cPIgrngImBnnnAhumBZ?=
 =?us-ascii?Q?SbfrAsMM1daMYCcYOTexwuANm7a3YAXd/da/+ydikdenq0Rb5qoC3Px1IgI0?=
 =?us-ascii?Q?jKYpR0yYQoXqQktlA0w4fM4/SGNjDA290bEmbA6XP1urXgQ3GWfCOM469Apa?=
 =?us-ascii?Q?HmB3HkF7TDpWVBxaQrMQiPB+FFLadGELR8XlovQiVk7gXLVPU2RKKn4ivGRP?=
 =?us-ascii?Q?uE7QkGslfwy2Jpjd6KRVNQoqdcff03yeHayTWXK99VHoELdtTATqh3k1uBtV?=
 =?us-ascii?Q?rcjNiFWvil7Et9QxWnQ3VpaAo8bjqZ/hDu3Do8Bx+xuKC9/s44pbXOGvLRcV?=
 =?us-ascii?Q?Hc6CsD5z+MDR3DIsJ7CdQQ700UIqpTmJAqquaKCSfPDSE6I5AYhEMa0vAFgI?=
 =?us-ascii?Q?rjZqmCLtpmpeWR9sJyiffojMtSuGWL9ATYBoDxhGmI0zP5fj1RWkV043g7zq?=
 =?us-ascii?Q?AbIe2rL0bCDhxFttD7QbjYziLVqiRPhTe1+jVnQsRR1YvaNlU94eCiYujMHx?=
 =?us-ascii?Q?OclkQQTxUwRZqhfIeg6Xl2k+7AsXTkrRG+aLePXimdg0j6eRSVsfyLPfwlK6?=
 =?us-ascii?Q?Foizeavccg+aBQmjzR5hJCeKqMTs4SavxY0U?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 18:12:22.1168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 272f1fb5-4c70-489c-b9e0-08ddc8822364
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8693

The reset reason value may be "all bits set", e.g. 0xFFFFFFFF. This is a
commonly used error response from hardware. This may occur due to a real
hardware issue or when running in a VM.

The user will see all reset reasons reported in this case.

Check for an error response value and return early to avoid decoding
invalid data.

Also, adjust the data variable type to match the hardware register size.

Fixes: ab8131028710 ("x86/CPU/AMD: Print the reason for the last reset")
Reported-by: Libing He <libhe@redhat.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: David Arcari <darcari@redhat.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/cpu/amd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 50f88fe51816..db0f9e0d181a 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1274,8 +1274,8 @@ static const char * const s5_reset_reason_txt[] = {
 
 static __init int print_s5_reset_status_mmio(void)
 {
-	unsigned long value;
 	void __iomem *addr;
+	u32 value;
 	int i;
 
 	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
@@ -1288,12 +1288,16 @@ static __init int print_s5_reset_status_mmio(void)
 	value = ioread32(addr);
 	iounmap(addr);
 
+	/* Value with "all bits set" is an error response and should be ignored. */
+	if (value == U32_MAX)
+		return 0;
+
 	for (i = 0; i < ARRAY_SIZE(s5_reset_reason_txt); i++) {
 		if (!(value & BIT(i)))
 			continue;
 
 		if (s5_reset_reason_txt[i]) {
-			pr_info("x86/amd: Previous system reset reason [0x%08lx]: %s\n",
+			pr_info("x86/amd: Previous system reset reason [0x%08x]: %s\n",
 				value, s5_reset_reason_txt[i]);
 		}
 	}

base-commit: 65f55a30176662ee37fe18b47430ee30b57bfc98
-- 
2.50.1


