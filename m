Return-Path: <linux-kernel+bounces-847593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC261BCB3E0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 02:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93313B4350
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6D82BD022;
	Thu,  9 Oct 2025 23:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SuC/pK52"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012068.outbound.protection.outlook.com [52.101.53.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586DD29B224
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 23:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760054380; cv=fail; b=bm/7IJ06lIOOan6UMPBNKcX1VXADIQNLwpoc+5jJ29WW6GL9eF5arJlLIFcvIEQkumQCr/j9rcFeSfB8WYMWQmaP1F5sYyWJxoiVSVcB4ctCpJah6p+8x3dokJTK5XtMt5qTqYqb+rbTT3lQ8XokUOBMI1mhP88t2E+v/D7q/Hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760054380; c=relaxed/simple;
	bh=F8iOORZj24OsOlCstT5pMu3zs5mT0Ls33qdoZ9KCukI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lrfUUFle0WaLZgoij9Ot1YGXyKA8KOBtTyKtt+uUohDlsFrmNOYVr4iEkLtEqI5KkbyTEOYVcAey7LVtculumkBgeHxCALaaO+rycgyNgVAtmLteZjb2VdGtTLA2DjyahwOpYIbFxsF5v4iiKp9Ij2gVNuQ6yuU8GMqx7DF3NtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SuC/pK52; arc=fail smtp.client-ip=52.101.53.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pII9cO2S0z84rjt0/PYZWE8ipNLzY6JNG7a+SO/GxJm86K9dZZ6QkGaP1T9dXfuhgsVVaRI5Qm5E1bKbQyZqXFN998JCOSf0C2ltGh6keBjD5dPCSBRv8IKKlBEHaCLh6b63qb3/ztBCUgQTD+aDF2bQCF9VdBXAFIpwajYSPkecEyuQt937yGiWjJLuPIdYEezMkwSthSZygBgz0J3lD+rGZ3zoVXYkXU0zOd2FTgQ1ftGuz3xid6HWy9Cu00L1B9naFy+8vVQkOmkQomCZnaaOfrJm8GfgorV7lEvb4d+FWpiXyaaIpoB+PLyAbMMTMgbMxyeu1MSEydDz3M+pqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ts++y/btPWbJIZgOynvyL5XPULDL+fPjcxLF4XD1CV0=;
 b=wcpOrZ9k/QowupEmBcsCZSJzEB34kQq6GFj4z4M2vuXNNNXqRSUsUMbv2FqdxVbHuIKiSvPhhkMF/xXaV2NH0hczVrufqw+n+iXBjiOXFtEUIkXMlhwb6wRhfYf5Z+c6vrczOUo6giQgJRTO3R8w4RJTi287UZOTxGCxiKjTjc1IB3PVvNsFpq3hkqRcvLqgKOi8jSWlIpfttB2dUxOIBSTcaDogMGAkRbTvMZsWRcX4T8/P6ePCCz86N1j49tUzSJlgEDtMfxZuKrsCeGKQdWMZq18gcEOVHq14uAzSkZpwLViN2bdl2AcPOIhRlLzL7+R5Wg7kL/NzuTUV42uiPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ts++y/btPWbJIZgOynvyL5XPULDL+fPjcxLF4XD1CV0=;
 b=SuC/pK521G2PAXe07jV+CgBPeFGXpz3O/eBLnKk8ddSmIIJWJdlYhNqJLofPF+/b7W1PHj/0dyMknG8lsePMlJoqqjYBd0Q0cWAWjQXAqrIthNEdKPUoBc7tm9GiGZDfF1Gd6ceOTMKYrnP5D4y9E2ON17MusrDGHS9lBCMMq0Y=
Received: from CH5P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::23)
 by CH3PR12MB8306.namprd12.prod.outlook.com (2603:10b6:610:12c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 23:59:31 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::ae) by CH5P220CA0024.outlook.office365.com
 (2603:10b6:610:1ef::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Thu,
 9 Oct 2025 23:59:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 23:59:31 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 16:59:21 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 13/15] iommu/amd: Refactor persistent DTE bits programming into amd_iommu_make_clear_dte()
Date: Thu, 9 Oct 2025 23:57:53 +0000
Message-ID: <20251009235755.4497-14-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
References: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|CH3PR12MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: f92d9d7b-1e4f-4081-bd38-08de078fe3e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qughkFQBNypUOOyFtoCUod9E2AbVW9uorXlW1gRKRrT+qqpKjiyETpAoa2Yq?=
 =?us-ascii?Q?8/oKo/Vf/R8W1Yf0CeyI3CinjT7QzhGZjwIWtKbbPGpL77tZWD/qm8Ua2Ao/?=
 =?us-ascii?Q?pSGBSngGbxGJG+cHu4iYVX958qd7MK1r3BO1qRHAU8jV/VGE/4gdzCjLETW4?=
 =?us-ascii?Q?pqYXtyXFKxtMfs3lNK/Np79ikm5AiV5tQ6vJXhorzfnG0nB8gEiofxQ1TssT?=
 =?us-ascii?Q?UtePFpnRBWs7l5CHmEbBbcMy/XU6oz/c4P0HRf1fH9hQOLDai4PNDTrpbtuL?=
 =?us-ascii?Q?y9v3QM3s8Bm1RKGWtx3n4AXiGk6YcLElCkF88rPk3N8Fss40I2xMWo3Y3uOc?=
 =?us-ascii?Q?dzcpv78weTwg9ZcloB6DF1TidjMGWiyxl9W0FLSeEUm2lcM+myLw4128tmyX?=
 =?us-ascii?Q?/ez5zQxoF7yPEf5aSvIJ9Aqc5o9Rn6TZ5kN+0NQVgZ/X/N6fw/c2zscxYIlP?=
 =?us-ascii?Q?ouX/WLy4o/rq00YYc7Dt6QFtojJ36XseprgO3P0z6w7qj4scpkPlg1uCr6m9?=
 =?us-ascii?Q?oBRYtloKxhUfZHYCDln/sM46kaCi7Uv+IxeN9cBWTkx7yN31xfEiS2Xdra6j?=
 =?us-ascii?Q?fAmJEKj6w2OKKKjcMnuEIZEs92OKUKJ5L5fSDQCFdL03eHvXvm6p/4qsI/I5?=
 =?us-ascii?Q?zxmBeIh76NqjTlf8d5LnSZph7+LBpo7HMZeOQNdZYQmzJSwoANfjJNnyGbXP?=
 =?us-ascii?Q?vGi8iHSqIMYk+AGkuWAHfFmihSzMDR2OahLMWLW0Gc7ndd1JabI8B2pfNPK9?=
 =?us-ascii?Q?u/xf/Royhcria5vlIYrYH7+WnaGKe5p9jUjzmluRBisNOidEQq4p8YENPVQl?=
 =?us-ascii?Q?ofapQIO+7pVQajkRZtDbOfel+YMB5hYcI5E5EtXMurbPuoDP2S8e6DXCVblb?=
 =?us-ascii?Q?iuF5LTQ9kckASrCRz0Nw4I9Wsep0nWCgNHRtegKORGCxcCQMWnSXersgdQEm?=
 =?us-ascii?Q?lf+0NPbD+H4eHnby+5bK6t34wQLAU2Gu2kFAVBE7T/yECogehxQ4zXj4Z+vb?=
 =?us-ascii?Q?j5qbD2wxMCItVWKyqUY7hFciPXuP2vhQQkF/ChPGi68O1PVlZgj8TFJspPZ7?=
 =?us-ascii?Q?1dSIPA32HyeynkwL2Ucx4UnJG7P5o3FpRcIwdsEZ8i9Czy514iQjKdy7dlYJ?=
 =?us-ascii?Q?kel42vrAAn4S8gxCEWGkrwJBDl/WSy14vkFKb8RmJQxUgLudr59irVtI7z5t?=
 =?us-ascii?Q?KOxsB/MDSanoIdkVRU3jPseBY8KGWDsWhtzqg0YXNmK2VYAoowhqOg8rNiUs?=
 =?us-ascii?Q?pNX0SdDv/WjYwlgCT5J5Eomj1AUFI2CYMCUQpmnnbhZjHOucko/D4jPlmVsm?=
 =?us-ascii?Q?jcMp0KKnE225gRLZkWUw1BVhMXJHTKqhKDAoaMII5Ejs4ui7cX9O/nXquDsr?=
 =?us-ascii?Q?Bms+Q//wR79RcaPOYGta2KKw00ICHWzCEWiP0YeDAy0dRxKfMfz0KhaNtu7p?=
 =?us-ascii?Q?6wRZDq/CgfUhzDrZvyAh/AJT0arm+VY8GzGSQQukBXcxLWowWeg/l/Zmodsv?=
 =?us-ascii?Q?wL8enbyf/iEAEWXgCnapgSTmARI+iumvN4ukTvLpQ2rfM52dhZfbU1VgdmR1?=
 =?us-ascii?Q?sZsGQtfaYzMCZxylvN4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 23:59:31.7460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f92d9d7b-1e4f-4081-bd38-08de078fe3e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8306

To help avoid duplicate logic when programing DTE for nested translation.

Note that this commit changes behavior of detached and blocking modes,
where DTE bit fields for interrupt pass-through (i.e. Lint0, Lint1, NMI,
INIT, ExtInt) and System management message could be affected.
These DTE bits are specified in the IVRS table for specific devices,
and should be persistent.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 13 +++++++++++++
 drivers/iommu/amd/iommu.c     | 11 -----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 3730d8bbe6dc..cfb63de7732a 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -197,9 +197,22 @@ void amd_iommu_update_dte256(struct amd_iommu *iommu,
 static inline void
 amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry *new)
 {
+	struct dev_table_entry *initial_dte;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
+
 	/* All existing DTE must have V bit set */
 	new->data128[0] = DTE_FLAG_V;
 	new->data128[1] = 0;
+
+	/*
+	 * Restore cached persistent DTE bits, which can be set by information
+	 * in IVRS table. See set_dev_entry_from_acpi().
+	 */
+	initial_dte = amd_iommu_get_ivhd_dte_flags(iommu->pci_seg->id, dev_data->devid);
+	if (initial_dte) {
+		new->data128[0] |= initial_dte->data128[0];
+		new->data128[1] |= initial_dte->data128[1];
+	}
 }
 
 /* NESTED */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e489e360bb77..ffb1adfd75c0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2049,7 +2049,6 @@ static void set_dte_entry(struct amd_iommu *iommu,
 {
 	u16 domid;
 	u32 old_domid;
-	struct dev_table_entry *initial_dte;
 	struct dev_table_entry new = {};
 	struct protection_domain *domain = dev_data->domain;
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
@@ -2090,16 +2089,6 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	old_domid = READ_ONCE(dte->data[1]) & DTE_DOMID_MASK;
 	new.data[1] |= domid;
 
-	/*
-	 * Restore cached persistent DTE bits, which can be set by information
-	 * in IVRS table. See set_dev_entry_from_acpi().
-	 */
-	initial_dte = amd_iommu_get_ivhd_dte_flags(iommu->pci_seg->id, dev_data->devid);
-	if (initial_dte) {
-		new.data128[0] |= initial_dte->data128[0];
-		new.data128[1] |= initial_dte->data128[1];
-	}
-
 	set_dte_gcr3_table(iommu, dev_data, &new);
 
 	amd_iommu_update_dte256(iommu, dev_data, &new);
-- 
2.34.1


