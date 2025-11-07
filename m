Return-Path: <linux-kernel+bounces-890014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4610EC3F11D
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE1E54E36C6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24763316904;
	Fri,  7 Nov 2025 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O+wwPsoW"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABAD2FFDF0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762506291; cv=fail; b=Xnnx6KPi7jXJyOZ6i5R6jkc89vymUIIcQ16F4wj7k0vr4bSrpXkDJGROk2X7b+MOJ9DKV2MzEJxmC2sVfpkPFdI9qk/h0x/E2jvL7II2eQyXHeAIay2rwQVl67CnJOi8Mjs/Nz0/Ond/veEU6QCD53mxfiBp+5OmNiDv0dHiosk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762506291; c=relaxed/simple;
	bh=36tUjFQNRWfXWmW0NrdOF6av8ndj4WAfbGI0Acs0S7s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sut0DG5p3Tz/g46uTrOjWdJJUz+Ga6V24QkaAd/xNBvTO8WTEuckoXBY+LA7sn3VwBPVSnxcuLBj/YH1CASG693Hk4MpcVgvjS42+SXL+P/Gbs5PSboSo/uVimKY43pmKhbhkt05VTdUX0y2bsEf5f8yhYFGQf0Lwg/s72J9iF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O+wwPsoW; arc=fail smtp.client-ip=52.101.56.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcJBrx+cbZtLpEWdDUMHukXmhjUidTQj3AMwmy6oCCtTESM8UA4reaCvPCbjYKkdLckD5NjE20+Y48G9sSgmjvzwv88tjiy8B3gIqgezqjFoYxHYPfHQsqDSLAcPLaGpYeJzcWegbCtzba1lZEKfkT2vx443YHDrDsA6t0fSoQDYGxTD1/K9aol5zWS2zQPSHvujr83toO6HX1/TrvnGoWArRWWzMg/OPvXqf7Z2DGRsyEEbRlKbxuNE4FRbIXfyl4ShVYwVY2yt9gcj93KAMzQ/3ezz3nKsN+mHTM1d5zO2+ma/Q19iylPYLw+vzZhTToYbwjppY54Wp57qlaEesQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xPMpl8VEA8QBzh65oO2lBWtlg4Tp/boL50io4vE8rw=;
 b=oesTPxJOUfXdl7KMT0MNs9WSOIPVNMi6aXjTHzv8a9ULMv+fw2v1k4m1VaIVwPr70wvtFD9bpdTSnIMlPQPPdHc/gYIj7kJO/OJU+K/+H0IW9ZhMMdBurV9/e5L77Pk/JPWG98uwl3aFjL/Zwf4y8oTW/oXWY/ypTI8R9oYWi46zOMzHKa1bLmJ9pfimuDAHVkfKiVDwCqDbb84mXK6qadggfVs9tegKoif+sEiZe+mGlT8g9Sdsi17As8aKXDEvcuiZcnvIYpZV0jILAxflGlfPigtgL1doyQbPvNnVIgh/Hl+cwEBmhe+mVJdxvnrWFnNE6xe4/fKRKjOsjN1hEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xPMpl8VEA8QBzh65oO2lBWtlg4Tp/boL50io4vE8rw=;
 b=O+wwPsoWFn5YgmaUTdFDoKqjZLvCsCFPaxbTC84HTLMP4zxEBor8UvHBW+q7YDxBwrIhMlnE/yWIEkaUzOnmp+MsP88nKCibRIB/MnHfwfblQAAfTgfQUmpE25AZkaBCwh1xj59gnZEiem6FiEVRWyQGK23T7dGX2DQX+LqPEo8=
Received: from BN0PR04CA0036.namprd04.prod.outlook.com (2603:10b6:408:e8::11)
 by SA1PR12MB8699.namprd12.prod.outlook.com (2603:10b6:806:389::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 09:04:44 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::f2) by BN0PR04CA0036.outlook.office365.com
 (2603:10b6:408:e8::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.13 via Frontend Transport; Fri,
 7 Nov 2025 09:04:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 09:04:43 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 7 Nov 2025 01:04:42 -0800
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/3] drm/amdgpu: add engine_retains_context to amdgpu_ring_funcs
Date: Fri, 7 Nov 2025 10:04:19 +0100
Message-ID: <20251107090425.23199-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|SA1PR12MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d482203-2d97-4265-ac57-08de1ddcb15b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f+/K5oUXRQojRm56eWb+DZNt0iWfeKAi+iFRXdPyq48i1yNeeWzTtymv03D0?=
 =?us-ascii?Q?CR/XR/ukOlBUt5l+WkSSScT/P8/YX04eh68GEt+7wlRBu82X2khxiOXXa4aA?=
 =?us-ascii?Q?3p6kEkzKcBrpi4GqXwN/9jodbbPI5ViNmzG47SRr7+ZebJH0bgCK/k/MkpjW?=
 =?us-ascii?Q?2b69yKSyU6lwBhc+LoFPALWD+P0efrzxKktrAobZ7cMTFaEB6sNWUM4XMeS5?=
 =?us-ascii?Q?z4oUR/Le4/BfjQYofWFaB7nV4XVNeJj2AOvsRJlY20j41jRkSnkuRZDusxJC?=
 =?us-ascii?Q?lz5T+KanaWTfbsBFNleFFl8ehq/oYCPiSSQTPXzcrIFN7KE4jrEnbyJXzAtX?=
 =?us-ascii?Q?ihjkHN7VPZ2fTk2orvXTOmw402hEFCz/I8IpysBn7tUgNvvPmtbFVLh/frBM?=
 =?us-ascii?Q?zFkyy8YM693a3DHBy2mFx16sX1v5pokLYmNdwgnnC3RqWQ3Iujw9nmGR/T2R?=
 =?us-ascii?Q?D7voLHS+06ljGsdpBuIfdQMFjapf3uXZAhJOH2qsrxK7MOU47htlW9fQ7Vx1?=
 =?us-ascii?Q?E6+errm2LYYjM04/i7s3TrtKOtYrye8Sne9wozwHy7VU6ak87aGWTMjOzsPh?=
 =?us-ascii?Q?inf42KsJp3d+z76oXRHcvgi63HEI6MB2Mge/U64bHs/H4BRKNw4z2UPMj1Ve?=
 =?us-ascii?Q?OHOS1utJp+6hhZi7dE2GPASAuFr8w2HUmA11cILXUYLwlXCAYmBHKxP6eN3p?=
 =?us-ascii?Q?fbydWhh/mnRbBIRpj9fY0SwLb+YGfcFZzZ9AsxjYF5sT0bb4JVymWx42uXcO?=
 =?us-ascii?Q?9JW1KEQTKJWZqn4zAK3i8Cnovqc0ZrM0Ix8wgox04/g7Rq8uAw35YVMHy27M?=
 =?us-ascii?Q?2NyHElfSekjUpvA+YgC66cE/sN5jsEIkmw5SO3g3rN3xYNtk3WnRLZRTL9Oq?=
 =?us-ascii?Q?GDjwnc2mitsgqXtxro5Qe3xrVShCMXxtv5KPZqFyPqEVB6jboFkO5cl5SDrS?=
 =?us-ascii?Q?DgFlgbNekV+lf6PTu9QJYozSpXSAYA67zSg62T2yMYqVv9f5e/oJgec9lJso?=
 =?us-ascii?Q?f6FExxJHPQoaJkcAlspkbjOMMihQx03qpw/UzjoR15PR7FDAC1v3XOooD15y?=
 =?us-ascii?Q?2jPX0Jv6WZAY6VEcmleB2dwRBKf37wn7sEaRT87kqaKrSTByEycBuGWyQTLn?=
 =?us-ascii?Q?Vhnx5QgXfAJuL6TPkU+bAJs6Ax9ErpLuRiwoSKFKW6tSx/bgeSed7LI8iNYG?=
 =?us-ascii?Q?mqNq+XTvyeTkX0wAvzICFWmsTl8SGxtnXLokGISc6uS6L4uqoelsgmY3s+1v?=
 =?us-ascii?Q?u0IJMxCyp0otIAMTLU5B+etIkJPJouOVESzMnhPOVyHjWKf/V5HeNg9sIikx?=
 =?us-ascii?Q?7wQEPZwKHmCCjGenMAQR2K5pvdbyCza3cAU7mXqh4Zgo2T+eQYDNTHGvlCNO?=
 =?us-ascii?Q?Vx2xgNqxEIV4hIE+Ebxu0/pHBV+Oev+hXIRIoxbLnUlxcGTvdDazUZljdsBe?=
 =?us-ascii?Q?XsWWTwQlUndtMN/+D3GrxazJG9H7pNeWaUgeUrGvQLfqJtI7+2uURtYCh0/C?=
 =?us-ascii?Q?sqqeBuHDZMGkcKKgRR+akejq/N8GqtxeqX5PM4VkY3AojXPGeiQnpq2gnJhO?=
 =?us-ascii?Q?yXlMBgw6wDsQdbztcB4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 09:04:43.8349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d482203-2d97-4265-ac57-08de1ddcb15b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8699

If true, the hw engine retains context among dependent jobs, which means
load balancing between schedulers cannot be used at the job level.

amdgpu_ctx_init_entity uses this information to disable load balancing,
but it's best to store it as a property rather than deduce it based on
hw_ip.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 1 +
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c    | 1 +
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c    | 1 +
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c    | 1 +
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c    | 3 +++
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    | 2 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    | 2 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    | 2 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    | 2 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    | 3 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  | 1 +
 15 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 4b46e3c26ff3..a10efac2fc54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -211,6 +211,7 @@ struct amdgpu_ring_funcs {
 	bool			support_64bit_ptrs;
 	bool			no_user_fence;
 	bool			secure_submission_supported;
+	bool			engine_retains_context;
 
 	/**
 	 * @extra_bytes:
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index 2e79a3afc774..4a85b5465bb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -181,6 +181,7 @@ static const struct amdgpu_ring_funcs uvd_v3_1_ring_funcs = {
 	.align_mask = 0xf,
 	.support_64bit_ptrs = false,
 	.no_user_fence = true,
+	.engine_retains_context = true,
 	.get_rptr = uvd_v3_1_ring_get_rptr,
 	.get_wptr = uvd_v3_1_ring_get_wptr,
 	.set_wptr = uvd_v3_1_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index 4b96fd583772..e7c1d12f0596 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -775,6 +775,7 @@ static const struct amdgpu_ring_funcs uvd_v4_2_ring_funcs = {
 	.align_mask = 0xf,
 	.support_64bit_ptrs = false,
 	.no_user_fence = true,
+	.engine_retains_context = true,
 	.get_rptr = uvd_v4_2_ring_get_rptr,
 	.get_wptr = uvd_v4_2_ring_get_wptr,
 	.set_wptr = uvd_v4_2_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index 71409ad8b7ed..a62788e4af96 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -882,6 +882,7 @@ static const struct amdgpu_ring_funcs uvd_v5_0_ring_funcs = {
 	.align_mask = 0xf,
 	.support_64bit_ptrs = false,
 	.no_user_fence = true,
+	.engine_retains_context = true,
 	.get_rptr = uvd_v5_0_ring_get_rptr,
 	.get_wptr = uvd_v5_0_ring_get_wptr,
 	.set_wptr = uvd_v5_0_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index ceb94bbb03a4..0435577b9b3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -1552,6 +1552,7 @@ static const struct amdgpu_ring_funcs uvd_v6_0_ring_phys_funcs = {
 	.align_mask = 0xf,
 	.support_64bit_ptrs = false,
 	.no_user_fence = true,
+	.engine_retains_context = true,
 	.get_rptr = uvd_v6_0_ring_get_rptr,
 	.get_wptr = uvd_v6_0_ring_get_wptr,
 	.set_wptr = uvd_v6_0_ring_set_wptr,
@@ -1578,6 +1579,7 @@ static const struct amdgpu_ring_funcs uvd_v6_0_ring_vm_funcs = {
 	.align_mask = 0xf,
 	.support_64bit_ptrs = false,
 	.no_user_fence = true,
+	.engine_retains_context = true,
 	.get_rptr = uvd_v6_0_ring_get_rptr,
 	.get_wptr = uvd_v6_0_ring_get_wptr,
 	.set_wptr = uvd_v6_0_ring_set_wptr,
@@ -1607,6 +1609,7 @@ static const struct amdgpu_ring_funcs uvd_v6_0_enc_ring_vm_funcs = {
 	.nop = HEVC_ENC_CMD_NO_OP,
 	.support_64bit_ptrs = false,
 	.no_user_fence = true,
+	.engine_retains_context = true,
 	.get_rptr = uvd_v6_0_enc_ring_get_rptr,
 	.get_wptr = uvd_v6_0_enc_ring_get_wptr,
 	.set_wptr = uvd_v6_0_enc_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 1f8866f3f63c..3720d72f2c3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -1539,6 +1539,7 @@ static const struct amdgpu_ring_funcs uvd_v7_0_ring_vm_funcs = {
 	.align_mask = 0xf,
 	.support_64bit_ptrs = false,
 	.no_user_fence = true,
+	.engine_retains_context = true,
 	.get_rptr = uvd_v7_0_ring_get_rptr,
 	.get_wptr = uvd_v7_0_ring_get_wptr,
 	.set_wptr = uvd_v7_0_ring_set_wptr,
@@ -1571,6 +1572,7 @@ static const struct amdgpu_ring_funcs uvd_v7_0_enc_ring_vm_funcs = {
 	.nop = HEVC_ENC_CMD_NO_OP,
 	.support_64bit_ptrs = false,
 	.no_user_fence = true,
+	.engine_retains_context = true,
 	.get_rptr = uvd_v7_0_enc_ring_get_rptr,
 	.get_wptr = uvd_v7_0_enc_ring_get_wptr,
 	.set_wptr = uvd_v7_0_enc_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index a316797875a8..1691d0f955a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -2117,6 +2117,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
 	.support_64bit_ptrs = false,
 	.no_user_fence = true,
 	.secure_submission_supported = true,
+	.engine_retains_context = true,
 	.get_rptr = vcn_v1_0_dec_ring_get_rptr,
 	.get_wptr = vcn_v1_0_dec_ring_get_wptr,
 	.set_wptr = vcn_v1_0_dec_ring_set_wptr,
@@ -2150,6 +2151,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_enc_ring_vm_funcs = {
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
 	.support_64bit_ptrs = false,
+	.engine_retains_context = true,
 	.no_user_fence = true,
 	.get_rptr = vcn_v1_0_enc_ring_get_rptr,
 	.get_wptr = vcn_v1_0_enc_ring_get_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 8897dcc9c1a0..046dd6b216e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -2113,6 +2113,7 @@ static const struct amdgpu_ring_funcs vcn_v2_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_DEC,
 	.align_mask = 0xf,
 	.secure_submission_supported = true,
+	.engine_retains_context = true,
 	.get_rptr = vcn_v2_0_dec_ring_get_rptr,
 	.get_wptr = vcn_v2_0_dec_ring_get_wptr,
 	.set_wptr = vcn_v2_0_dec_ring_set_wptr,
@@ -2144,6 +2145,7 @@ static const struct amdgpu_ring_funcs vcn_v2_0_enc_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.engine_retains_context = true,
 	.get_rptr = vcn_v2_0_enc_ring_get_rptr,
 	.get_wptr = vcn_v2_0_enc_ring_get_wptr,
 	.set_wptr = vcn_v2_0_enc_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index cebee453871c..063f88da120b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1777,6 +1777,7 @@ static const struct amdgpu_ring_funcs vcn_v2_5_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_DEC,
 	.align_mask = 0xf,
 	.secure_submission_supported = true,
+	.engine_retains_context = true,
 	.get_rptr = vcn_v2_5_dec_ring_get_rptr,
 	.get_wptr = vcn_v2_5_dec_ring_get_wptr,
 	.set_wptr = vcn_v2_5_dec_ring_set_wptr,
@@ -1877,6 +1878,7 @@ static const struct amdgpu_ring_funcs vcn_v2_5_enc_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.engine_retains_context = true,
 	.get_rptr = vcn_v2_5_enc_ring_get_rptr,
 	.get_wptr = vcn_v2_5_enc_ring_get_wptr,
 	.set_wptr = vcn_v2_5_enc_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index d9cf8f0feeb3..8dcc07b3f631 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1857,6 +1857,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_sw_ring_vm_funcs = {
 	.align_mask = 0x3f,
 	.nop = VCN_DEC_SW_CMD_NO_OP,
 	.secure_submission_supported = true,
+	.engine_retains_context = true,
 	.get_rptr = vcn_v3_0_dec_ring_get_rptr,
 	.get_wptr = vcn_v3_0_dec_ring_get_wptr,
 	.set_wptr = vcn_v3_0_dec_ring_set_wptr,
@@ -2021,6 +2022,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_DEC,
 	.align_mask = 0xf,
 	.secure_submission_supported = true,
+	.engine_retains_context = true,
 	.get_rptr = vcn_v3_0_dec_ring_get_rptr,
 	.get_wptr = vcn_v3_0_dec_ring_get_wptr,
 	.set_wptr = vcn_v3_0_dec_ring_set_wptr,
@@ -2122,6 +2124,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_enc_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.engine_retains_context = true,
 	.get_rptr = vcn_v3_0_enc_ring_get_rptr,
 	.get_wptr = vcn_v3_0_enc_ring_get_wptr,
 	.set_wptr = vcn_v3_0_enc_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 3ae666522d57..f1306316dc3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1977,6 +1977,7 @@ static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.engine_retains_context = true,
 	.extra_bytes = sizeof(struct amdgpu_vcn_rb_metadata),
 	.get_rptr = vcn_v4_0_unified_ring_get_rptr,
 	.get_wptr = vcn_v4_0_unified_ring_get_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index eacf4e93ba2f..5a935c07352a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1628,6 +1628,7 @@ static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.engine_retains_context = true,
 	.get_rptr = vcn_v4_0_3_unified_ring_get_rptr,
 	.get_wptr = vcn_v4_0_3_unified_ring_get_wptr,
 	.set_wptr = vcn_v4_0_3_unified_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index b107ee80e472..1a485f5825dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1481,6 +1481,7 @@ static struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.engine_retains_context = true,
 	.get_rptr = vcn_v4_0_5_unified_ring_get_rptr,
 	.get_wptr = vcn_v4_0_5_unified_ring_get_wptr,
 	.set_wptr = vcn_v4_0_5_unified_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 0202df5db1e1..2d8214f591f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1203,6 +1203,7 @@ static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.engine_retains_context = true,
 	.get_rptr = vcn_v5_0_0_unified_ring_get_rptr,
 	.get_wptr = vcn_v5_0_0_unified_ring_get_wptr,
 	.set_wptr = vcn_v5_0_0_unified_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 714350cabf2f..bd3a04f1414d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -1328,6 +1328,7 @@ static const struct amdgpu_ring_funcs vcn_v5_0_1_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.engine_retains_context = true,
 	.get_rptr = vcn_v5_0_1_unified_ring_get_rptr,
 	.get_wptr = vcn_v5_0_1_unified_ring_get_wptr,
 	.set_wptr = vcn_v5_0_1_unified_ring_set_wptr,
-- 
2.43.0


