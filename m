Return-Path: <linux-kernel+bounces-767339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 680A9B2530E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FC8B7ABB13
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2912E8DF1;
	Wed, 13 Aug 2025 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MyJv48MZ"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624012E5B22;
	Wed, 13 Aug 2025 18:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755109740; cv=fail; b=YT5Cr5eoBduroD41AE6k1kcV6gMMBuVNISlR3VEaty1LRiS2um8B2TPAkH35A34EA8KTB5s40/uyZx/CT0SsbtI9RdPKGUj5DRruaCp+AVYyA4fKCatlBLUwdAIwP94WNVjQx1LRG0NMMqZFF3uIWWJQ3koJksJkOkz5h9t481U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755109740; c=relaxed/simple;
	bh=f3S7kDDJB5EtPWUTZ12gLrxSWGNMmOmK2/CRKDVcdJ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hxIqqes1trxMFTTvZkUQLiOHZk+8HRQJPim0xrePg5Y5D4CtwkE4Pk4J3b++K0bPMUN+bVvaF+/vnCd5/rQM2/OUAv2g3jo5k5YTyqb/tMc4nZH2qhbcO+uVIsDkfi7ty7krQXb48THM2wSbcEZC79hlbN3q894f3i6vDyo81wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MyJv48MZ; arc=fail smtp.client-ip=40.107.102.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1sTYr10EvXLoIz4JFo4rbaHuZt4VnBaiyNNcR+Y+G5QU9GlLhxCjwXI3gM2lWAa9Px25mAxUY3p/blD+4ZAaZRMu2Z03p5D9v/mH09zFApYgEMqohOXWfAYYOzWkUYGnUczp9yeP2RGRYs5PJfDL8TjSE29ns4/g2clI3H5c+CCZ619Irz/vjyHyabdjRI7+KNR2ocBdOPRiyzrVMwrrpCU2A8xryimf9ZM7suAKCrs5xOWcrSTzrifMaIeupF1UukSM6noyhUtr91q+AKauOBffyo7Po9vEKDzTy4JBjmce9m7J/bkfANgjlErNG7XyRfB/+gLVprfHeJFUjt5iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Upej9gSaK9valgU6D6hOxA6kABHrs1u2rMCP31CqGg=;
 b=lwYiCoiQQH3JIghnUR1Qo2l1pqhtLxzT8TxGUsOSZ5IQGE477ef6XxkhT93gYopji37Jo1+KqLftc0kr+ig8th3nbtxVVmuc2PE44hgjx2DYc2HZENzkRzJpdeq/3AAAWyTuV1mgk5eMY3whsIFJKW5ujcaB7olNBziG+1GB/38dH7lCj3S0uNlMcaiO9PQnPcfsch/CXGRfEWiqlV75lfRCKFSsmUDwuQ6SGfzu33s5R+haPPJNGx4vWcdOocOy6BXroFb+WeHF8FprikMKMSS1qIILYMFFC70UwSV9iWk2CCD7LJXrObt/ts3XXjQILvSDTnzksBGHLEwRksKqeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Upej9gSaK9valgU6D6hOxA6kABHrs1u2rMCP31CqGg=;
 b=MyJv48MZWXo/T47WauJhpkdPyX6wDeNyHpMcLu1L/LOvab7KhZppYUGoRllkspWj+B0EBbhs8JOYhhr/NXM+9GJgUtzCCFOuPvuam8P1p5Oc/Ude1NSCiTwY6fJbTIi02kll1KHuPeuN8sn5W6Tk8J/lLUXU4z/4m4GBX95mSWk=
Received: from PH7P220CA0146.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::32)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Wed, 13 Aug
 2025 18:28:53 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:327:cafe::3d) by PH7P220CA0146.outlook.office365.com
 (2603:10b6:510:327::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Wed,
 13 Aug 2025 18:28:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 18:28:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 13:28:52 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 13 Aug 2025 13:28:51 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <robh@kernel.org>, <lpieralisi@kernel.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V1] of: dynamic: Fix memleak when of_pci_add_properties failed
Date: Wed, 13 Aug 2025 11:28:49 -0700
Message-ID: <20250813182849.3229140-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 160ca5fe-441e-4ae2-8284-08ddda97414a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B5wpKcwS19gkY7GHAZw8kQb0hIace3kT+LP3UZpqjEI1leNbtbZMsxAEt2QH?=
 =?us-ascii?Q?W9RVHClMfFsPE73JOc1yyPyf3ZC35PMUPr/z5VCqZUgtMkg/KKjSzbujj1Qk?=
 =?us-ascii?Q?aKFAJyQINAOJfF1WFQcwlbyA6zVYF+x3XC6cYkwnTip0DItSA8kdsGhfKJFU?=
 =?us-ascii?Q?X3COrSSsQHKHy9zrjdhj82ksj5QAyfuXBbq7gN1bmK47ALctFdbxDBMxloN8?=
 =?us-ascii?Q?y18WhYne3lZE8svJXxCNRc2+e2OFscz6YGPk0B/vQh0RZ/pHYLv3kzGlN1EU?=
 =?us-ascii?Q?A4Ku2uKW5qYhacCO8DCQ3e31Os6Rq7XoMcQx1QfKdo2OJt7roa3sDO6jM4TT?=
 =?us-ascii?Q?8SNmPjMlSRjsGnk0UqVgvJU45HtC8+aUqd5uUQJpzkKTSSMSH7jfIlySoDES?=
 =?us-ascii?Q?aaR9WRL0B2XqNttcIKyHGk99Y4hmNxvyMKqpPM1sRNNO47VvoHgYsvtEsN+E?=
 =?us-ascii?Q?T4tHEolXq/vVxAQ8kN0kiSISu2dEJX9I/TJbnVyj5CySyZcEiPjEMAdwWtbu?=
 =?us-ascii?Q?BXTMD9qljVlr9GfjtO/SAbjfkWj2+MURqpAXuJwmZJb66TZ7Z1wnUhM7d2fy?=
 =?us-ascii?Q?bafBJqfi29qA5IWScV4n+X2MfikVYSb50O7goxQksZiJIob9hrQb7Brteef4?=
 =?us-ascii?Q?RJ8zhc6ooQbJp51dyQzTnd+QxdcXkxbvYKSMwXJL83pdm0pBfIAaevkZf49h?=
 =?us-ascii?Q?Uf+2gvnHePxGAPSY8Hv4Ej5wug8JKeeC8JMCXS5Qz8pZlXa8VbjOw43VF/QL?=
 =?us-ascii?Q?juYBR2gD5P1Y8KDA11WP9uHZFXfF0+gGHvUWJxUVOBhw9gi7SWFbcKO5i3MD?=
 =?us-ascii?Q?D7FD2j1zctHUyZgcqlVFM5onAYaWB76uU3rMlvaZ4xaVH0n+3VygVf1Jri2a?=
 =?us-ascii?Q?CdT1Cn60EqrFwNbzpv7Kj08NdqBUv9i9FACgZHYFbcuMzSu02jQpDgQbsI3h?=
 =?us-ascii?Q?2GIsBkgdf6VvR+69Ytw9By3/TSFbq0aUvYknXKTmHWSp0rcR6aPtAovJr7Ns?=
 =?us-ascii?Q?s3vG6c5uyCfO9srFb9p1hDn1PkuF5PKzYYDWOY4ChjG9WMRzzhYXCXuf+KGQ?=
 =?us-ascii?Q?aeQ7y1Su6Ka+pAeY56Vg+E92Y9fKTwUJAJw7XWtX1Eh0NqfWOVqiXgLzgTjQ?=
 =?us-ascii?Q?QDzUOmOu1TRDdDONneaZo22XNahaI7td+3Sree3QhYKFt+HH/cFU/DVuka2g?=
 =?us-ascii?Q?7Lu8Bfm5vDh/X0g/BBnZpzM8OcCV8BAcaP6VxABR6t0NCXUawlylk4w3j+Uz?=
 =?us-ascii?Q?KknG1sFVoiTUVoRgB5M7q2cO3s9HU50y0BInE+Qph9AO2wxSS6Wr+CGKWeGF?=
 =?us-ascii?Q?EWomFCqj4QXoGQIn4K8BdZA7b3YX8X0JdqV5MKf0/WLYIXcu4cNnTOQj7Rkb?=
 =?us-ascii?Q?P3VcAcsX2SKa4k4d4qYPw3cFrB05etILwdOX6XCqSUG9RApB8SPiKwoQNNrK?=
 =?us-ascii?Q?lX0ymJSW97nUdR4FH0t/I8HNN4vCAVWaBiXFR7/AxpemFW6X+O8YkJzewNeF?=
 =?us-ascii?Q?8EIUTHA7rj9MRqvfX1FH7k/rl/xstVetfcs04sz8Lp7QHTMz0GmwidGjzw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 18:28:52.6141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 160ca5fe-441e-4ae2-8284-08ddda97414a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604

When of_pci_add_properties failed, of_changeset_destroy is called to free
the changeset. And of_changeset_destroy puts device tree node in each entry
but does not free property in the entry. This leads to memory leak in the
failure case.

In of_changeset_add_prop_helper, add the property to the device tree node
deadprops list. Thus, the property will also be freed along with device
tree node.

Fixes: b544fc2b8606 ("of: dynamic: Add interfaces for creating device node dynamically")
Reported-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Closes: https://lore.kernel.org/all/aJms+YT8TnpzpCY8@lpieralisi/
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/of/dynamic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 0aba760f7577..dd30b7d8b5e4 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -938,6 +938,9 @@ static int of_changeset_add_prop_helper(struct of_changeset *ocs,
 	if (ret)
 		__of_prop_free(new_pp);
 
+	new_pp->next = np->deadprops;
+	np->deadprops = new_pp;
+
 	return ret;
 }
 
-- 
2.34.1


