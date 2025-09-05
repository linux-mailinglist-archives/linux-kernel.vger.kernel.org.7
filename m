Return-Path: <linux-kernel+bounces-803693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97183B463D4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB6C07B4E9D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED813280330;
	Fri,  5 Sep 2025 19:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T5p+kZV0"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1D727F4CA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757101305; cv=fail; b=iT35t7fFVh+t55jA5lw+yrW3FhnKDQY8SVg9CH2RFfTYhBQmtvnyU1rWe7TsII0icgq4PFVa35HmBmGHWTOD/+USF/925ySc8g/S2DCgPAgeqF9nI4Pv0fIK9soRWRgDTCdDCWrVOjEHjU5ujBDX772E7wp2WorFx8jjVnWRdYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757101305; c=relaxed/simple;
	bh=sxvIj0zGwcmsLgtaTcrUq7UNPoOe78J4Aka2B5t+/ng=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W6yTXHZRU2QqCTV8eExwV89IkX8ylrQ2ExUpMxWIjFYtM8GLFkNdtq7VfuclgNZ7puevF/hYG2cNib0oDBMdEf66a3L7pDFPAPff6nL6T3JQt6or8zSGVsHmL4ktLMlTiEVef9s2anChRmY3lpjNCUyUSUWTu8CMDYvoasPZJls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T5p+kZV0; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMGQre2NeOWLgvKYa3kto9zdaI6hk4Ifc6FOwqNBcj1HDc6BWm9J/rSB0d1lsIiJM53IMczntxr4qphQgSCR4gYho1BBIusi0guXglJONqMgnV9LStU7hgIeuQXeI3EcSUTfOm6U8C5kuSIiKYaQP/yJDgc3tHHjxaaXQcEq1ZDxpvf1BHBkOFUcJrM5TmCiRuie87P2jz2tRj7AbgVPkFCDBCKmSKdQdgeu+TFrzc3ywbMs/RvPfjYezymFJ6zmDko9A/p3UJizn+M/UDTxdU9QuVk7knXQ1bxxgQbuWPq6+MHeC4rcu0WbyAA5tF2kVNo0c1vuV9s3n6ciHO11Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaJLFsL7SJNBSxArsA8FzmfBwN8i3Y4OIRMyN4sMru0=;
 b=qMDXBkcKQ5+v6bnDQvl5Wx2us0tUAoS96QkD1PNKYyKH39NYmW71eBVWQEAV+AEmHfEILhCVGdy3AFqaPmi4+6PLac+8QHn38I2ihBeaDDFn6n+bq4Yw1I0SC/pQs0sX14MZqaY8UTaBgKsJEoKIQGY+by/HDLHwxXbWp+ngyEIRy5QhNmdZjqfEiJYRD9aIZ92XrVYVjDebRBGn1av2wAtgJvdv9qQBK3uTlR0yEQjl6L0M0k7w0xNS/KPQEceJ+lpUEc6yDIODf4XJHe2MizC5XcVEIggCCygd3XTiYbewT/gmjUN7T7cUYQSmCu4tP5bmI2tgnAutq+7MP9mimg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaJLFsL7SJNBSxArsA8FzmfBwN8i3Y4OIRMyN4sMru0=;
 b=T5p+kZV0mFkhdhWB7eWjHnct7zTrV5xJnzAHKOEkXy+Fhj3EoRd3HJ9qq3Kd4yLOi39YEN8mYy2XpVOmnwpEKQXfLDFTBZ35WFRzD4FCpfL8XgwBqJRhEoGqq5jWSSxc7J7LYjJZHGqO/+AzBaZBb7XWxpMs/3w0EE9R3/IvLCI=
Received: from SJ2PR07CA0014.namprd07.prod.outlook.com (2603:10b6:a03:505::7)
 by CY8PR12MB7634.namprd12.prod.outlook.com (2603:10b6:930:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 19:41:40 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:505:cafe::59) by SJ2PR07CA0014.outlook.office365.com
 (2603:10b6:a03:505::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.20 via Frontend Transport; Fri,
 5 Sep 2025 19:41:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 19:41:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 5 Sep
 2025 14:41:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 5 Sep
 2025 12:41:38 -0700
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 5 Sep 2025 14:41:38 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
	<jacek.lawrynowicz@linux.intel.com>, <dri-devel@lists.freedesktop.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
	<max.zhen@amd.com>, <sonal.santan@amd.com>, <mario.limonciello@amd.com>
Subject: [PATCH V1] accel/amdxdna: Call dma_buf_vmap_unlocked() for imported object
Date: Fri, 5 Sep 2025 12:41:36 -0700
Message-ID: <20250905194136.2644350-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|CY8PR12MB7634:EE_
X-MS-Office365-Filtering-Correlation-Id: 77dccc72-b893-4b9e-a31d-08ddecb43be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9BD/rWjq8bizrCDJzcrAaGwMceGoQjkENx+kLEbQGs0M9fFTg8VHAD5OOj+2?=
 =?us-ascii?Q?mntglhjKtG18LVRgSX3zkeLZ4gk2nMVzi4ql29ypnLsw+oA5HB4BuEbwAZCN?=
 =?us-ascii?Q?ZXAoMNWDSNVCdkJRhbksczMML4qim2+RcyLu5mFXohguFLLj6HLxNjsKaQp7?=
 =?us-ascii?Q?SLWxgoO29D6rD4s3FXlrS9MGy7sX9hkcnpBJ+LvyQ5359g7TI+2WweNR5Rao?=
 =?us-ascii?Q?O36mcgD98FIBMdmTlp5I71NJKWs0Lvn95CJvU0Ji3YPuC3YLagDEDuMxeU8J?=
 =?us-ascii?Q?rVojCLXjW/cMyi7UI7CQIpVE0asftNIBszNKPdo+Yy6zgilB+wHDZtpuLY50?=
 =?us-ascii?Q?XrzNQya8I1l6fAXErqlnmK199Sj79lyZJXL91UfwA3tLs4uNeAxCzqqt1URy?=
 =?us-ascii?Q?okgold0/2SulpZpjpjfl+mxZQicryi+LeuXbkcr9pz2vQgTDhBTf2vlOTy9u?=
 =?us-ascii?Q?zinhUhVe5/lGGNaRD68d2fwdjbgvSAQAp31k/4xX6isfh3RKtJkWKGFPfjx2?=
 =?us-ascii?Q?77x50tu89xN2v2K6R4ABh9MsZseFkU1oH1JL7X+c+HWo0tYXXdjDWnKaQsQP?=
 =?us-ascii?Q?YrgKcHejoZMzyeQHapbaqQWBAGTVxCNECcZtvHFjfGRu0UK60hoJy4uskVyK?=
 =?us-ascii?Q?opLLwyROfBFQX23xm2YMBE7lEjf+Dw2FI/hwH3o8WLlaqZf0++tHD98oXXT6?=
 =?us-ascii?Q?EMyR0NYOrA4YzCdu2EyWmBeHQhXJT+D2UFyGrnzpGV+xttmo2R3Qh/SD/Zip?=
 =?us-ascii?Q?aYANtF+tSKlb4tKMrhsmZB2/pXp2Fe2qSkdhv1o35l0CJ7nWsUyybD7Rgxtw?=
 =?us-ascii?Q?tAT5pXZXAwzqoQ5z47HeD+fYVtKcTN23tAD0cRy4y395fWUZxX3B75lyLjyX?=
 =?us-ascii?Q?basBKo8v89lph2OAKsI8vSbcyPi6VR8Yc29gMOhb0UoZs5xwjv1VhISPfVHd?=
 =?us-ascii?Q?T4hatx6KA15soWl+WpK9+hVFWesapPv4x4Ave7FPWPHj4qWZ4g3Rhu7NOPzm?=
 =?us-ascii?Q?EBZrjuoCt+33F7RyG6DvCKGPcl/AWqxKc+hB7WS5pUnzSlzQt24zrSi+05OV?=
 =?us-ascii?Q?OCOFSpjO6wl2K5lxkqpBcYTmHbJ1VEDwZtDnpjR3WUS/2qoq6upHID9f9qLp?=
 =?us-ascii?Q?WeKok22tRPVsQge2lk+XkSjOi6aXFqsH+SwV3aM+jg1I8SDgsOl9zR0X0piA?=
 =?us-ascii?Q?DIUBIF2PnrVlY8du5YwdMAMky9Iluhm80mTdEwvv8MjuhuHExh9rYY95LHRT?=
 =?us-ascii?Q?OuunKgkODVeq6mD8p9tUKiifwIGpwt0FqzPpZ5dv3E+mFIrGFk+qaTuOECMU?=
 =?us-ascii?Q?F5YgL3zo2e/0YgfHptzDdNYtuLCS7Htp9FqbUMeV6ci2ZpJ5hXf01SSWTD57?=
 =?us-ascii?Q?ZzkpkvlioJj+uvtSacRSz+Vv12E7/KXzcjPfEGCpogYEtymiHdpio0qMtLKT?=
 =?us-ascii?Q?HKAy2jsUj9AHvfQHP0crGZYsfPRvuG75cmG1k+yWghXKe3KaiVpCbUj1qrBw?=
 =?us-ascii?Q?22/3ZV928oO8uXTv58tnnqBLYkH14VfoDu2O?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 19:41:39.8384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77dccc72-b893-4b9e-a31d-08ddecb43be6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7634

In amdxdna_gem_obj_vmap(), calling dma_buf_vmap() triggers a kernel
warning if LOCKDEP is enabled. So for imported object, use
dma_buf_vmap_unlocked(). Then, use drm_gem_vmap() for other objects.
The similar change applies to vunmap code.

Fixes: bd72d4acda10 ("accel/amdxdna: Support user space allocated buffer")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 38 +++++++++++------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index d407a36eb412..50950be189ae 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -392,35 +392,25 @@ static const struct dma_buf_ops amdxdna_dmabuf_ops = {
 	.vunmap = drm_gem_dmabuf_vunmap,
 };
 
-static int amdxdna_gem_obj_vmap(struct drm_gem_object *obj, struct iosys_map *map)
+static int amdxdna_gem_obj_vmap(struct amdxdna_gem_obj *abo, struct iosys_map *map)
 {
-	struct amdxdna_gem_obj *abo = to_xdna_obj(obj);
-
 	iosys_map_clear(map);
 
-	dma_resv_assert_held(obj->resv);
-
 	if (is_import_bo(abo))
-		dma_buf_vmap(abo->dma_buf, map);
-	else
-		drm_gem_shmem_object_vmap(obj, map);
-
-	if (!map->vaddr)
-		return -ENOMEM;
+		return dma_buf_vmap_unlocked(abo->dma_buf, map);
 
-	return 0;
+	return drm_gem_vmap(to_gobj(abo), map);
 }
 
-static void amdxdna_gem_obj_vunmap(struct drm_gem_object *obj, struct iosys_map *map)
+static void amdxdna_gem_obj_vunmap(struct amdxdna_gem_obj *abo, struct iosys_map *map)
 {
-	struct amdxdna_gem_obj *abo = to_xdna_obj(obj);
-
-	dma_resv_assert_held(obj->resv);
+	if (iosys_map_is_null(map))
+		return;
 
 	if (is_import_bo(abo))
-		dma_buf_vunmap(abo->dma_buf, map);
-	else
-		drm_gem_shmem_object_vunmap(obj, map);
+		return dma_buf_vunmap_unlocked(abo->dma_buf, map);
+
+	return drm_gem_vunmap(to_gobj(abo), map);
 }
 
 static struct dma_buf *amdxdna_gem_prime_export(struct drm_gem_object *gobj, int flags)
@@ -468,7 +458,7 @@ static void amdxdna_gem_obj_free(struct drm_gem_object *gobj)
 	if (abo->type == AMDXDNA_BO_DEV_HEAP)
 		drm_mm_takedown(&abo->mm);
 
-	drm_gem_vunmap(gobj, &map);
+	amdxdna_gem_obj_vunmap(abo, &map);
 	mutex_destroy(&abo->lock);
 
 	if (is_import_bo(abo)) {
@@ -489,8 +479,8 @@ static const struct drm_gem_object_funcs amdxdna_gem_shmem_funcs = {
 	.pin = drm_gem_shmem_object_pin,
 	.unpin = drm_gem_shmem_object_unpin,
 	.get_sg_table = drm_gem_shmem_object_get_sg_table,
-	.vmap = amdxdna_gem_obj_vmap,
-	.vunmap = amdxdna_gem_obj_vunmap,
+	.vmap = drm_gem_shmem_object_vmap,
+	.vunmap = drm_gem_shmem_object_vunmap,
 	.mmap = amdxdna_gem_obj_mmap,
 	.vm_ops = &drm_gem_shmem_vm_ops,
 	.export = amdxdna_gem_prime_export,
@@ -692,7 +682,7 @@ amdxdna_drm_create_dev_heap(struct drm_device *dev,
 	abo->mem.dev_addr = client->xdna->dev_info->dev_mem_base;
 	drm_mm_init(&abo->mm, abo->mem.dev_addr, abo->mem.size);
 
-	ret = drm_gem_vmap(to_gobj(abo), &map);
+	ret = amdxdna_gem_obj_vmap(abo, &map);
 	if (ret) {
 		XDNA_ERR(xdna, "Vmap heap bo failed, ret %d", ret);
 		goto release_obj;
@@ -770,7 +760,7 @@ amdxdna_drm_create_cmd_bo(struct drm_device *dev,
 	abo->type = AMDXDNA_BO_CMD;
 	abo->client = filp->driver_priv;
 
-	ret = drm_gem_vmap(to_gobj(abo), &map);
+	ret = amdxdna_gem_obj_vmap(abo, &map);
 	if (ret) {
 		XDNA_ERR(xdna, "Vmap cmd bo failed, ret %d", ret);
 		goto release_obj;
-- 
2.34.1


