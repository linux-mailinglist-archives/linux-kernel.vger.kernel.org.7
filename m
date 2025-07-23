Return-Path: <linux-kernel+bounces-743156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025B4B0FB44
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044403AE1BA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7974230269;
	Wed, 23 Jul 2025 20:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o/ve7/8F"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749161EF0A6
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753301295; cv=fail; b=ILNugdgqWN9MEeiPgsuf8iE/skxWHvIzDQWH8eviuHOrI6/vpO742jDlagYkdKiFMQU92V3Qgq3n4B/zmFbgMkH77VCMmIIEw3veCmInXKC5jwkA1KHfbgvS5YIUuU2aaRmdDjA7nLFo1mrgI25/5b2q7T/VPGXB4+HASoRn7mE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753301295; c=relaxed/simple;
	bh=waOOhvdLprcNMhGBQHRIpFHIKcWzviRUD/XAEgN2gNk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nPwhXEhDjO0Qt3cfPqvybKw0+JNKNAKCVFmnUPhQr4lpDjso6FzZtEfDC6P7K21L7HTwt1pXtji7n5v70E6i/8rQfGdLpy1CR2Mvis9am23VWuwna68phmY1zaoBlfCaAgA+Qvf1Ya/3J56OxbtyHsvm6opof5sZxgz8JIcwC9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o/ve7/8F; arc=fail smtp.client-ip=40.107.95.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApjhOdUzHQMF8AZ3cr+dPE0ChtNsZsn97X+GHEfMx6x8ESHpS6PpIPmOIGq6ABDg60OEjnzYgxVtp0MA8ve7qwoBR/1xK/Pg02ZzDYifZgvJOHMdWs7PrfOKyFcLWdoeeX8ocCuHvAAie9dJ95rieBARPJjn78yA5WM5Y9jer32DrJTkwcarOg0I3ujoeIoM2XBpI94pDKM6V0Jp9odNdW/HxknX4NJoWAZNowNTR763DuUdLunlxELJ1abY1aFfKAhhCMVESvAQotn8norvTDVV3/vFGo7w5v2yp9j4Z3RvN7TvTd8C+B+dhSbKBcd1ovnkGUf3KpO82B8o9Pn+VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkiInml4x/ChWggWcKKHvj1BY6tl/oelfuXpYyzHW2U=;
 b=nJoFF7nlFgCoxTMbpoO66I/NjsnvfA4f7rsb0f/aPwDOq8mJVla3Mt5MPocr157mhR0Vy53stgpkFfgxVh4XEZDTWWc3D7SBjL1Fel3OnHVzqJeHygg+fRwSLLq6ByNJN7oZjihCa1CkM6z3nWt45etIJv7IXfCksIJt7HBcr8zEUEvgnboGwRwplNpquMBoJLfSXCd7v/cvl8LWwr4SmjU6M4MafgMah7JCxgvysm4ZVJ/RhA23I2nCc0s+Ez3XifEZMYI2XwmfjbCQu+/3Cefvn0zRtMw7XgXDx8Fpg0ZBMH4Nxbl8AWKIeRTe/3aSc+OD9NiebNqw4cEK4Wh7QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkiInml4x/ChWggWcKKHvj1BY6tl/oelfuXpYyzHW2U=;
 b=o/ve7/8FjEfvPTo9w67n4oEnRa3fFWwMeOjDeD/neSgQehdei6s/7x9B2Ekal1/K/FAeifFS4RvAxltX77Hcjc/TyCGdCL7FDrTsPql0ZRPQtzxIFqbIR538OVvRzr2yIgvuAV1a8yMYDkOUBAeHAlfM6kQoJBtVJy0OXhuLWP0=
Received: from BY3PR05CA0019.namprd05.prod.outlook.com (2603:10b6:a03:254::24)
 by MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 20:08:09 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::ee) by BY3PR05CA0019.outlook.office365.com
 (2603:10b6:a03:254::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Wed,
 23 Jul 2025 20:08:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 20:08:08 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 15:08:06 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <x86@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>,
	Libing He <libhe@redhat.com>, Mario Limonciello <mario.limonciello@amd.com>,
	David Arcari <darcari@redhat.com>
Subject: [PATCH v2] x86/CPU/AMD: Ignore invalid reset reason value
Date: Wed, 23 Jul 2025 20:07:52 +0000
Message-ID: <20250723200752.2851345-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|MN0PR12MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a975469-a9e6-4545-ea2d-08ddca24a47d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vzTu7FQ/8nsH6bkM8t5/EDxFSEGfxbbD+UiChSDtb3j2lgEtTnCkqRZGsoNF?=
 =?us-ascii?Q?RN3wwQKxz0XWGAR0dWllf620domUANChrTAHZ52qxwOZ9KsekFdYSWjBWzjN?=
 =?us-ascii?Q?j0hW29oCT4jh+bFyB3/QHERcXLwE5WnDKbBXqNXrn/rf/uafTZ9t0Og9Xlst?=
 =?us-ascii?Q?ulDaReHiH3zYOwUxl9fOhWH8IT3USLbiLVO3dR3KyEI6qcxgiCX+/JjsQDRI?=
 =?us-ascii?Q?Yd4N2Dkms4IKMu0wihz4+/plFTPgd0o5R2qQq3z+l/Gem4TMDXLR+6SOFzey?=
 =?us-ascii?Q?ytvOSTwB+p7pfwZE8BzZwbyF/tKYYw0BUAJGJueCEn4RohBkzhZXn+OnqH1Q?=
 =?us-ascii?Q?DRb4X6asuKknhj8TXXu/mDi2+5k9k0v4tu91vytlWrY9uwRB3Ky/x7sgy839?=
 =?us-ascii?Q?NFeX/zzdGCiE+3nMUXVMA1puabREQF2dWw+2H1aRKVBU/1j4HzpRgVgEfZAG?=
 =?us-ascii?Q?DhEPPUO2un418YVxZ/IN+Y8s2zzryzj/3XW+wk7aHUJSLxM/GZjwCGPOCFlK?=
 =?us-ascii?Q?p+PVk3coHbUtCxIJob6qfycp5KMCrquQZKITJ9lBuQ0HOA5k/zQC/l1TTYCO?=
 =?us-ascii?Q?xSCyDipYsnCuj1yi1/v+CpEaO65XgH71LpC+y3ES5GuQ0nrr7VXlJk4r0KY7?=
 =?us-ascii?Q?J/Lc7s5q3gVRem9RupnQObVR6oQ67RgKpQi4slI94i077EPDwun9YaaQOwzO?=
 =?us-ascii?Q?drh7FZ7vCV6tTawWo0ALa9M71as9divNg2lW30rFwl6CMSf9TSAMSF4hfHtC?=
 =?us-ascii?Q?6YzlCiZRJ0LHJotCnbVaXS6YuNL9Fg38k0W+xv5FWCC7A8F1bnOPV94XnxhO?=
 =?us-ascii?Q?7rgEhiaTOKdvTxfeAp2q8QXW1qNxmz+TS4Miv8d9/Q6BGx/X7ghnbVkBMgta?=
 =?us-ascii?Q?6GqLTbCM0xEGhQgUaRCTUP02FTqc23yUeUz4Pgy2v+q+BauagIyr8ngl969/?=
 =?us-ascii?Q?UJOrOd6WTedqkEeWXzqNdjCFhw23mixVIIiz0h2C7HtM6HF91VGvkhwhPrjf?=
 =?us-ascii?Q?hUo9D6jwhIL5eOPOuv3nBU4tTBiE6lCGmJsxtR0H64spw3/hp+TuMFs1/YLP?=
 =?us-ascii?Q?f+GI8FNp+JwJRg0CfdMX2J9GPhC3B9DKygy+dNFLVO0z+DRZd1remLFhp9it?=
 =?us-ascii?Q?uSZIpy2UB9WLTYKw/6BChMDpZa5MnBKL7cT/Edk8ADtBoj/XPbq7YcCuvRTw?=
 =?us-ascii?Q?pyrdRabwVRAI3tQ89Z/ppqIdmX4/1HN9q6iNP580iL+jkvvKBSFsp3O+si6X?=
 =?us-ascii?Q?jcmiLEYtdeWEPcgoFzOhUkuJ4rrXtTmmPWqqCxY6sUg9HmEvDf3Hq2umn8WI?=
 =?us-ascii?Q?TTW0IbDjIM6SDR50OsTE+Rs944eQTfZHYJcGF1j3Teq4AxDksBhKWu7Xpf3S?=
 =?us-ascii?Q?D1jnEKWjVZiTw/cYseKa74IfcaLDqa3gJVkoAv8OXwsGCYjj/lWjBTiWBO04?=
 =?us-ascii?Q?WJHCH0CpoEkx/MzVHNnurfNwEwFyiesLmjObHFAzTnuS2SIlx1e5bJktxops?=
 =?us-ascii?Q?iF2xJk0rrx7LKr1Q8jSeq2uDkQbWM3JA5yM+ejKR67irmUNjj+jTlJQmaQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 20:08:08.2466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a975469-a9e6-4545-ea2d-08ddca24a47d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905

The reset reason value may be "all bits set", e.g. 0xFFFFFFFF. This is a
commonly used error response from hardware. This may occur due to a real
hardware issue or when running in a VM.

The user will see all reset reasons reported in this case.

Return early if running in a VM as this register is not emulated.

Check for an error response value and return early to avoid decoding
invalid data.

Also, adjust the data variable type to match the hardware register size.

Fixes: ab8131028710 ("x86/CPU/AMD: Print the reason for the last reset")
Reported-by: Libing He <libhe@redhat.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Cc: David Arcari <darcari@redhat.com>
Cc: stable@vger.kernel.org
---
Link:
https://lore.kernel.org/r/20250721181155.3536023-1-yazen.ghannam@amd.com

v1->v2:
* Include Reviewed-by tag from Mario.
* Include hypervisor check suggested by Boris.

 arch/x86/kernel/cpu/amd.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 50f88fe51816..7a10fe426104 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1274,10 +1274,13 @@ static const char * const s5_reset_reason_txt[] = {
 
 static __init int print_s5_reset_status_mmio(void)
 {
-	unsigned long value;
 	void __iomem *addr;
+	u32 value;
 	int i;
 
+	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+		return 0;
+
 	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
 		return 0;
 
@@ -1288,12 +1291,16 @@ static __init int print_s5_reset_status_mmio(void)
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


