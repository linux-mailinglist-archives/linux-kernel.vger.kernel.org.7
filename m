Return-Path: <linux-kernel+bounces-877860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF991C1F36C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB03F189E59E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9275E341AB0;
	Thu, 30 Oct 2025 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ME1929/r"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012029.outbound.protection.outlook.com [40.107.209.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086B9254848
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815507; cv=fail; b=I5+ldvmxn18bPGX49lM06IonK3UsbmJzZtlMGBuempAEwOz5rT13a3Ep5GwBKYWFi348DG5R1Z8CBGSshL+8bHfBc+sCOiOvFRa4OwxJZfIRkz6i/xvYB9aLRr40X2LqKGVGj7/eaHcHamg61hgVksacz650etJEm1h6nbi1hTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815507; c=relaxed/simple;
	bh=yE0mFlr9gXP8QwR0IZ65nDcfdT/65j7ZXojimSx5PpE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+o1axi/4saXhe+ZbNwo+/bLA2ubqjrPrdcmZmtPUy1WeVcjOBDy6O1WMiVWBCJ+l2RfoviPX9Jsj0C5luzrOLxT5q2tqP7rFBqyVuuI0jFvFU1FkD3ht+iUR7JbS1AxIrdynQbaYfno/Lc6A768uqAxlnO5OD9SBP6Qfv6C08w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ME1929/r; arc=fail smtp.client-ip=40.107.209.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pynRicP6/7Brt6PTpWWnVc/YvI67Cek6nRC0CLVcb6tTKZsPU8lF3yyfbuJDZiREqcjehHo9ibXyTNOCu2+cPiBoPzX1QLnAmjHpymKNJNl5aX/EhoAb04Uj/BzpQ0yAGO8PI9HzXIy471WZVtlZc7hGZ0EJFGrtCA5U6i2uydk6NwRybXZ9j687nH4O3NrdK5B6fGAYz9kNw5WfG5qEA8x7pnw8H2NatOlde3mNwubEndml0cdokpnV17zEYIiEnW9WtJ0tNSTZWacjfAgjED3E1necPlfNoubca6IiTJtY7gfACAlHvPft2T0/8DiCSXeeIgeXUrFp8C6uR/wmAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+R+zqcTe6N8AI9Zq7PcqQOmrPy6Lsupd2bZ3tYWTaY=;
 b=F1DSkFx2OTW4fv5zsREJtuaWeF0Vk63BEmB4fzg99lWsom7TuekgO1IM//ZWbWHTXakuwaKuUH2DCa3gzlIUAmIJn1fjQ5hwgf9QZxx5LDsU3Im50s77vKR7IHArfy7/4j2UMyeS2PORDN+Xy4yy6jrLkHNDq/yW9TRmL4cQRnWkZ0Aljo1i7eLvxWDvlNZDLuOovHrKEfxUbTjDZJQmL2aA62kQvQaZ8Tk0h+qwXKEqfaUtCBdIdzoElOb9lAJmf1erfi0AWmskkkEcv7adcQ+oGuRcB0dDv8sOBWPsItAXQFXU4n/WPH8kcUDzQgQD6HXFLNRMCnjmDQP5Gq81Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+R+zqcTe6N8AI9Zq7PcqQOmrPy6Lsupd2bZ3tYWTaY=;
 b=ME1929/rlPDbgJ/wakzRFz6Wu/HW+Aw1QUrzV6wquUqzHfF5e3Yfa1nwS4QdRm0tFfO6VfedOLsHAMLvppCvlZOmDCYV8OywakgZPBGe2Wz3leHwCnJxcNOZI1ewXMBogqUAqaVWTxf53STnwGzeT4x9MrmXSD2cOt45/KVT11o=
Received: from BL1PR13CA0094.namprd13.prod.outlook.com (2603:10b6:208:2b9::9)
 by DS5PPFDB3A23D1A.namprd12.prod.outlook.com (2603:10b6:f:fc00::663) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Thu, 30 Oct
 2025 09:11:42 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::d1) by BL1PR13CA0094.outlook.office365.com
 (2603:10b6:208:2b9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Thu,
 30 Oct 2025 09:11:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 09:11:42 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 30 Oct 2025 02:11:40 -0700
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] drm/amdgpu: increment sched score on entity selection
Date: Thu, 30 Oct 2025 10:11:12 +0100
Message-ID: <20251030091118.4864-2-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030091118.4864-1-pierre-eric.pelloux-prayer@amd.com>
References: <20251030091118.4864-1-pierre-eric.pelloux-prayer@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|DS5PPFDB3A23D1A:EE_
X-MS-Office365-Filtering-Correlation-Id: e858b3c0-95ce-4ddd-c6f0-08de17945774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AQeia7lOseya+wl23OrOoDBB/EYffjG6aKirodaGYGSxNSe+9pn7OymoVO8u?=
 =?us-ascii?Q?GeflA7U8/Is0KsrHWJFGKeoENTBwxWHO/AphSCLOrDjyd7T6O+eSxvpCs7s6?=
 =?us-ascii?Q?tm5yQ15W/qR4ZrIWjqodIOVkTuWh2SMelTYI2DEFMjhEWhrhn64xYttzlc0x?=
 =?us-ascii?Q?gvyivLFaHomB6kHyMp1zyGCarvnlv0lvuyRmX0dEpJcnAz2bTUkg9lv4X6Ow?=
 =?us-ascii?Q?6Ay3tsXIUCxadkmC27SlnE/w7Jnmg+uer5adGQuNTfgYWrZMzBeDnycXJrPW?=
 =?us-ascii?Q?40wHHj5xKAzUWr7W8LqXO0KIA+OUgkdJwL3dZHpTMwvIOum3ljjzj9V3wsh1?=
 =?us-ascii?Q?3M+5cYeioQPG6d+8IRV09IY9LsVRpUomrQINpiOA3McDxL5btuMvnVRf/sEO?=
 =?us-ascii?Q?fmNtL6nz3xXjwhAUrk7JKipiXbb+au57jTqG+DnAoqPd+sCSiLtaGHKXj3ro?=
 =?us-ascii?Q?x4bX845WnW2Qt02mwy12pQyUruWk6DGZFjFjeK2s1ch+VLw4qHxHxaqQXZxG?=
 =?us-ascii?Q?+L7nDZd8fPAjpf+K3+r6jbNKn3x99P78LxfEx3bVh+tNYfFM0n319dOtKdkL?=
 =?us-ascii?Q?8q64lfRqhI86ALgx0H47k7hFVI+Pur51sGHZUShNiUihGYx9GnV3S67vNpg3?=
 =?us-ascii?Q?wzY7ctcPfWsT97AqQK9EqzvqB+QR9P513aS2VaBWRFjV2aOj8MSwaSQuuahv?=
 =?us-ascii?Q?nik2qDSyhc16EkCMZY0QMETdxsWDlnGaqUPzDl4t6XpEzp03dIeSlmRe6MdS?=
 =?us-ascii?Q?36UZopxP/CEiI+N1f5luUTmYRz1CODW0Y8DHoMQDDlwyChnScLqGkSGJRjmY?=
 =?us-ascii?Q?0ILmGmHJofRRkqpGq8gevZHMFDFy2/+sNUFI3JHNgqXeAszVAEKcJrIMuY+9?=
 =?us-ascii?Q?zWsHjE7z1xXQNMxQXeiNfecR/U5F/SYnYY/La2xZQ5x6fUI5gIJbFi5byxkg?=
 =?us-ascii?Q?Nd5ZwFWWeG/6jLrxZkY9R59A42/dvEKOAfjv7Mw8tKsycwJuYQHqdE612yPg?=
 =?us-ascii?Q?43JBGe/fWXGV+XXR27DmR3KqcKYxhCOI0rfGmox9oHhJz/Z1AYOHNNiZJAbF?=
 =?us-ascii?Q?xOQ0p7oZ57YJOjhHQxDDUOWHaBikhKYqLZk+Hl+UBIXepnUDJxW0B7YSqzDE?=
 =?us-ascii?Q?FKP0Q08j9vNP1lg/wx0xA8TOZ1H7L6nljib8kE68h8dOgw/oHTIopFGcKqre?=
 =?us-ascii?Q?1kJywNuF21y2B6/QEKXXJc9aodkB4LcpnQqB3uSeFG/Jb0R5ag+763gkGAa8?=
 =?us-ascii?Q?f0UZCqf/gSg4rooX/IV/dZeBnXpw6afIunnAFG9AUbKkJdvxz3BxATfjTA5Q?=
 =?us-ascii?Q?2ByYu9ziMBgonW/1BgOpB6hZ+yELUnSRVELa7etSB4X4ZnqfHS92PfAMWnE7?=
 =?us-ascii?Q?vErUlwLKHVg83oHx1+11ttwSzjXSu2IWlmQhixTs2YYOlwNiXafadXJ7Eirm?=
 =?us-ascii?Q?aFtOHmR3U7mwgmwXUkZzQITzweGsq+y1R32av3T+GaFYC+DDjN0YAZfCPgnh?=
 =?us-ascii?Q?hJ39+PHrsojpBpw+ICUI9ATNTxP0TMhz0/f6eT69wiTTyvc1F1eelINb/OYC?=
 =?us-ascii?Q?O1FFphkjYnvB9A3GkNI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 09:11:42.2622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e858b3c0-95ce-4ddd-c6f0-08de17945774
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFDB3A23D1A

For hw engines that can't load balance jobs, entities are
"statically" load balanced: on their first submit, they select
the best scheduler based on its score.
The score is made up of 2 parts:
* the job queue depth (how much jobs are executing/waiting)
* the number of entities assigned

The second part is only relevant for the static load balance:
it's a way to consider how many entities are attached to this
scheduler, knowing that if they ever submit jobs they will go
to this one.

For rings that can load balance jobs freely, idle entities
aren't a concern and shouldn't impact the scheduler's decisions.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 23 +++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index f5d5c45ddc0d..953c81c928c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -209,6 +209,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
 	struct amdgpu_ctx_entity *entity;
 	enum drm_sched_priority drm_prio;
 	unsigned int hw_prio, num_scheds;
+	struct amdgpu_ring *aring;
 	int32_t ctx_prio;
 	int r;
 
@@ -236,14 +237,16 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
 		r = amdgpu_xcp_select_scheds(adev, hw_ip, hw_prio, fpriv,
 						&num_scheds, &scheds);
 		if (r)
-			goto cleanup_entity;
+			goto error_free_entity;
 	}
 
-	/* disable load balance if the hw engine retains context among dependent jobs */
-	if (hw_ip == AMDGPU_HW_IP_VCN_ENC ||
-	    hw_ip == AMDGPU_HW_IP_VCN_DEC ||
-	    hw_ip == AMDGPU_HW_IP_UVD_ENC ||
-	    hw_ip == AMDGPU_HW_IP_UVD) {
+	sched = scheds[0];
+	aring = container_of(sched, struct amdgpu_ring, sched);
+
+	if (aring->funcs->engine_retains_context) {
+		/* Disable load balancing between multiple schedulers if the hw
+		 * engine retains context among dependent jobs.
+		 */
 		sched = drm_sched_pick_best(scheds, num_scheds);
 		scheds = &sched;
 		num_scheds = 1;
@@ -258,6 +261,11 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
 	if (cmpxchg(&ctx->entities[hw_ip][ring], NULL, entity))
 		goto cleanup_entity;
 
+	if (aring->funcs->engine_retains_context) {
+		entity->sched_score = sched->score;
+		atomic_inc(entity->sched_score);
+	}
+
 	return 0;
 
 cleanup_entity:
@@ -514,6 +522,9 @@ static void amdgpu_ctx_do_release(struct kref *ref)
 			if (!ctx->entities[i][j])
 				continue;
 
+			if (ctx->entities[i][j]->sched_score)
+				atomic_dec(ctx->entities[i][j]->sched_score);
+
 			drm_sched_entity_destroy(&ctx->entities[i][j]->entity);
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index 090dfe86f75b..f7b44f96f374 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -39,6 +39,7 @@ struct amdgpu_ctx_entity {
 	uint32_t		hw_ip;
 	uint64_t		sequence;
 	struct drm_sched_entity	entity;
+	atomic_t		*sched_score;
 	struct dma_fence	*fences[];
 };
 
-- 
2.43.0


