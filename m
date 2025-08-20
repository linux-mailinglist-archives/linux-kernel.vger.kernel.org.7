Return-Path: <linux-kernel+bounces-777569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02959B2DAF3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14BB56062B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C9B2DD5EB;
	Wed, 20 Aug 2025 11:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ej2zfOvS"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FE323C516
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689437; cv=fail; b=EfkEChRUCaXdEjIU8/UMA3PqsAdAxgLUEDCNJ+Nf85Pyp30MUiFVUJSZ8R+lTZhbByJOJX1bcXDRl3I0MsvxGNE69Hgq3XJ7OhgY73PAWCQfXHTR6nWNAJD7e9mYFwvBwooel9hiJEBDeeswbZRrhKPx6cfXvRfUPEHWHv7yCXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689437; c=relaxed/simple;
	bh=4C4/rQWSmWPw89Kxy6/nuaztBGtFXBQ18L1oX544gNQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OT4Sug8jIVy7oyl+wTQFBNcqPCeutl8AFfZSrq5QlnPOvAeOP/6V84ifjs2w2JLYr4DhRsZppuJxAJLfSLrjKSsNhyUuM8Cru0E/HhNLwQPsSx+vu8V7REziOKpa3PgiOVc9JOFQW/pf0V/2M4f94IT3lYki8W4uQF3s7ufi9II=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ej2zfOvS; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2HJCQL3EYte48pB31dEbEKV3RTDxnoRNBwJoGQyQQbZrUmzaEfF8JhXKUq0jfkNqpCXIsQmlvYcHEQoyaZPWz9ywBDOvhXu9cOqrGcavj9qFxgHIdgcCgASgR65aPzd/bmLJQy631VUikSl4j/pnzg+ubcaQRJmBsX1560ukyN/ufz3K3LEvqp8BVbVLK0dlHrdUUgwzLENSlh1kU7N5JrINrc1xDwIvq/lOTmD7gXnK5+UQLpDVcPjmPVtwfeyCakZw0y+8r4+yBcaDZz4GCGcHmbntpqnuqRymx0VesF7OWTDd/O1aflsimGFXX02Kng4GSIX8/wRWZ5wd2r1zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kg3XlE45XRr6UsH2nbWiOLd54ujKHYooNiH6Ky4zrUQ=;
 b=F2DmnoAUqtCWU99eiTeRzJ1FYO04CZW4Mmo+rqwJRHc4tsUaqWGKSIL8giK8BiZ8y+FWRCssUPM/WU+1tj8T4k4hJu3xa8taeQ11LrrXNOaydLoUDm+N8k5uvTKVyxb2MHw2281nj6myzHRojspZbRnZm96lluHhP6HM/j+CuD5BTr3segsa+RJitMSLWG2mQuiDzPnzHCiKNtY3ub2yX9wMtatDFHvvBJ5AC6HODzS9oTj3/VxESiYDEwFUkj57K0aUFmHqvkMkPLnFAO7n3labqv0HRfh5NKW1X6yDXaxS0u9fnnbXXPZD6/eno7b7nfcWPX4zYeaQW7yNW+fzJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kg3XlE45XRr6UsH2nbWiOLd54ujKHYooNiH6Ky4zrUQ=;
 b=Ej2zfOvSaUcWMm7laZAcrIjW7u94PXmAXW0iwLlyKDVC3QF+BHCgexY2uoUX+pehXJAIiN/TSRXWBJveEm3t5mjOVhK7VR7qzD/q9OlgV7xQHiQgJvHpXLEBtZ9iy13jnq9HQr5PIIHgYtUzewL6TTY62J2a5KMo5tH4pIXq9Ho=
Received: from BLAP220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::21)
 by MW6PR12MB8899.namprd12.prod.outlook.com (2603:10b6:303:248::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 11:30:34 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:32c:cafe::48) by BLAP220CA0016.outlook.office365.com
 (2603:10b6:208:32c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 11:30:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Wed, 20 Aug 2025 11:30:34 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 06:30:29 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH 1/8] iommu/amd: Make amd_iommu_pdom_id_alloc() non-static
Date: Wed, 20 Aug 2025 11:30:02 +0000
Message-ID: <20250820113009.5233-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
References: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|MW6PR12MB8899:EE_
X-MS-Office365-Filtering-Correlation-Id: bfaebbc0-d262-4c05-936f-08dddfdcfa49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SwkaPR6LKeNPWkhrc3HFmRAxTSkAFW8sRfmWNKOT6NOg1M3LamXo22F98QYF?=
 =?us-ascii?Q?ortkpOYvXuKAahO/oX/pgZLMXnNsc5fsSArMPqVhLFC8AhE4MfvIYTvRgtKE?=
 =?us-ascii?Q?qr5AqKTAdVtPdNhDEJqMONcCubB5AACDMIIdTcKTlKmAVJsr/RHdhAVQEOwm?=
 =?us-ascii?Q?aIaML8CIBVCU+K5Ezcz+vxrmGoAUpN/4c5PmLOt33ow4l+AiNY7/TTBPy3US?=
 =?us-ascii?Q?rL8WCaPz3FxQmEzbFEzW9WzPzi6+JMp5rSEjGKkNNuWpcEPDR6+VSfN4Xbr0?=
 =?us-ascii?Q?GhUmzi9fK+Fhl3ZsAFkjVWKySL8wh9L78kbGeTSXF8l6bgLsGHStworSfMMp?=
 =?us-ascii?Q?vInJxAoIXbtVUNfXAQrqL0UGyl4co2QlaGwQW74duTHiOqAGQNvR0NC9+uvj?=
 =?us-ascii?Q?8ePwgLILErXyzMk4vttwnHfO3dDuLgvdq+bI2+/TuhhBZ0ZO9y0DQiOHe5kD?=
 =?us-ascii?Q?QkgkQqHjAopfw7wNS3OO7ugD4SaIPSVa5ExYNfB/Px7Ay0iPXUnXnUksa2ss?=
 =?us-ascii?Q?ObLu/Zg8zWlu1O/EYsQxBEYQlTB94iZQFMuZpUbgDYxguYRuJ9F7mF24vGGC?=
 =?us-ascii?Q?TgxF18wFUVWZ2T4z/mfLy81hIX9IpmqP19YXqfw1hbjnGXYJEtYBDwDgpUDo?=
 =?us-ascii?Q?dj0YQaj1b2tacyyDY8Yi3aqDtctJIO+Sa5NKF8eYs6p7TNthQLfmg7TEYWhx?=
 =?us-ascii?Q?dkDumd4z9wNlBUGxm7CDDzRV50cqO5jpbRZP+jcP/CswLIa72A+Dm6wQPHGY?=
 =?us-ascii?Q?eLnXqKv76uQ7ceGrLs1Vn660GQtZGOIlm4LsNHtVzR9kl06ZnE3b/0Z70fcS?=
 =?us-ascii?Q?UUypVoZ1r+SkL7wr452YxJZSwNVA3OAH0LcZU3W7CUM04gR2+NHzwRVJSPra?=
 =?us-ascii?Q?E0eL9XHatqoB8P8gRDhcwUoV0Uz7R4eXcRjHtBagTEzBZLHETjv/7lR/pub1?=
 =?us-ascii?Q?zBd+fEvVY3q/TB3b+gX7g2wG3zuge2wT9XkIW1/7rjjCf8r0xIjaGg3z83Ip?=
 =?us-ascii?Q?d82Pn05seUjFxXU1xzL2RLdmfnrg95dXc0BCDCBPH/FxDh3KiYJ93fxNXUqa?=
 =?us-ascii?Q?17722WU4h1rtBTW2RaYEo13xQmxoFfR8+4aSAdlJuDscG4LlDFYD31o/w/3r?=
 =?us-ascii?Q?ZppXxCpQi+pk2oZaj+NiTsOJw/QPN7jGX8CrfUX+Q1zlg5RwMkDhcnDCyV93?=
 =?us-ascii?Q?59wbGO9CS/fXYdbzYrYS4XBw6ECoqMwXhQvsLCZmV/GpEDRDrG8fG1y4y2x8?=
 =?us-ascii?Q?eN/j0V24AeDvvKC1IYc4Nu3o71SNEmvP4ZyfhE+TCP5cSE2Xu3p523IdRKQ3?=
 =?us-ascii?Q?2GH4bxSu2sTkSto2Fo0w1+iqLXnrF3c135dUkQ0hTAbkU67pNNVgmuqeKKQT?=
 =?us-ascii?Q?6oWXhp3FE+XMN4RJgXfmQ38qPjp3o+a0X7FxAX755F1lOFRk20KOq5VNk8Y2?=
 =?us-ascii?Q?x4t/e1HO5JfbPGsojMhDgBuRkjwjkqI7TKDrNZl/22Zmh/ttqsT3HA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 11:30:34.0973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfaebbc0-d262-4c05-936f-08dddfdcfa49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8899

To allow reuse in other files in subsequent patches.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 1 +
 drivers/iommu/amd/iommu.c     | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 9b4b589a54b5..6ea549816a1f 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -26,6 +26,7 @@ void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
 void iommu_feature_enable(struct amd_iommu *iommu, u8 bit);
 void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
 				  gfp_t gfp, size_t size);
+int amd_iommu_pdom_id_alloc(void);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 void amd_iommu_debugfs_setup(void);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ebe1cb9b0807..a05b7f69ac74 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1816,7 +1816,7 @@ int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag)
  *
  ****************************************************************************/
 
-static int pdom_id_alloc(void)
+int amd_iommu_pdom_id_alloc(void)
 {
 	return ida_alloc_range(&pdom_ids, 1, MAX_DOMAIN_ID - 1, GFP_ATOMIC);
 }
@@ -1904,7 +1904,7 @@ static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
 		return -EBUSY;
 
 	/* Allocate per device domain ID */
-	domid = pdom_id_alloc();
+	domid = amd_iommu_pdom_id_alloc();
 	if (domid <= 0)
 		return -ENOSPC;
 	gcr3_info->domid = domid;
@@ -2487,7 +2487,7 @@ struct protection_domain *protection_domain_alloc(void)
 	if (!domain)
 		return NULL;
 
-	domid = pdom_id_alloc();
+	domid = amd_iommu_pdom_id_alloc();
 	if (domid <= 0) {
 		kfree(domain);
 		return NULL;
@@ -2679,7 +2679,7 @@ void amd_iommu_init_identity_domain(void)
 	domain->ops = &identity_domain_ops;
 	domain->owner = &amd_iommu_ops;
 
-	identity_domain.id = pdom_id_alloc();
+	identity_domain.id = amd_iommu_pdom_id_alloc();
 
 	protection_domain_init(&identity_domain);
 }
-- 
2.34.1


