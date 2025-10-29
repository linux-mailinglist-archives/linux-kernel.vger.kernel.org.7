Return-Path: <linux-kernel+bounces-877032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A50B0C1D04B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B766404BDF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB9D3590B5;
	Wed, 29 Oct 2025 19:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cS3bv9Zx"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010026.outbound.protection.outlook.com [52.101.193.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1D03559F1
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761766477; cv=fail; b=ikNMB0VJ0sqOXaug5ROl64CFy0clzOJLpAqh30ZVaZk9psFfhiPTxBNjQGFL77zXCNRFXH/sULLm7pBJVpaEEk5ud6MFh+IK3xwNIRL1Q9FMA/kVGRdBfhGBx5mW9dYuOJZYKFTNcaXvY2Viof6Q4kXsrkT3DIv3wd3AAjcblWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761766477; c=relaxed/simple;
	bh=y5P8XGqDuaG5APjC8pzNkhXJUF6aUWoppptuN3d2DzU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sG2g5kG6zf24JhrG2+j7m5J4hCSCNQPKo9pxxPEm6fRj/jgjYkTmwe08ooUAbU32rVcpNhRIi7ouk4HJpHwqnaqf6VsIRQ+wjBOi7t/5za7VV0hRnCvQGxzzLo3LLPYYXX8BWRQ/SUYNCdcp5ETh99T6UQCoKLHsrkTss0OIbVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cS3bv9Zx; arc=fail smtp.client-ip=52.101.193.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qANyv63VbxHZTR1ueAcf5bNqrYXnNwQGDDYOxZA6RRZA8qMiHgEOjterLosdFEiQYclDWgXFUa0D5YaASpZoB8lVxW/bn4VNchD2Vg+7BS//NFvY5pYTx5EaacGiZERvPUy2KQFngMdT7HnjNmHS3ygdpvbw1LauS+sIcsm6NRVEoCR8ygFRvrPXFTPMVPgrvxcjQe5UHvDy0yCtlr/GqYOnEBivWIHvAEgorHqCdEOYXkTI1gihRlLFX/5nFDTgsfrbRlvnomrQky29Xm0leCUFjFz2vlvI6ew1yTjwClTNKNX8JXOf3UAfuGqqZjIzaOd4ZC6vv8usSuCxReUDKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqB6fFWEnxXfAYiod5n2sTbFz9fV+eIVZs2RXbMXHm0=;
 b=HgiKE6fq84jBnBqbVPNBchwsX796+SjRPxSDLNK7PQqh4qr1yERDgfuDpy5eLwyssK1VlgHuMz/4WtuZwToiV6p0Z5n6Tz73k5PfoEupCi2hP+kCce2i8HIxOZoRzT3tbFpw7vU/nY8+qqQxIf3mX2XCoAa/pWLVDD5G8S+N/MZ1C2IKoWvwcQpA6ds/3PJISt/RfZq6px9GQqgzqWUD8LojyX4e5JG9ESRI7uU6+Q1XquUBVHXXOv4ShJHOBlUpvE/uSJXSfHt/FaXn1ZjkxkLpqLilatz5fU6jH67qkcpW1AlctBEggvl2QruHU6ubLrPvSsU9nY3MEfO3ORduqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqB6fFWEnxXfAYiod5n2sTbFz9fV+eIVZs2RXbMXHm0=;
 b=cS3bv9ZxU4wzb7gqy7laZDFLpFxOd47sS0cIhBxx+03LtyjgJzbgHVMkbvO58V7Ns4YAB8OEUCVRY7F9SoBkLDh8vLlIq0B5gXF4u7vjRKuxnc35XCWujnsLmcuQIvkjpYGJpNAiGqRrR/7XloDEc+cuMH9KK6K60cMpSJWZRrQ=
Received: from CH2PR02CA0024.namprd02.prod.outlook.com (2603:10b6:610:4e::34)
 by MN0PR12MB5739.namprd12.prod.outlook.com (2603:10b6:208:372::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 19:34:31 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::65) by CH2PR02CA0024.outlook.office365.com
 (2603:10b6:610:4e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 19:34:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 19:34:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 29 Oct
 2025 12:34:31 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 29 Oct
 2025 14:34:30 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 29 Oct 2025 12:34:30 -0700
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
	<maciej.falkowski@linux.intel.com>, <dri-devel@lists.freedesktop.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
	<max.zhen@amd.com>, <sonal.santan@amd.com>, <mario.limonciello@amd.com>
Subject: [PATCH V2] accel/amdxdna: Fix incorrect command state for timed out job
Date: Wed, 29 Oct 2025 12:34:23 -0700
Message-ID: <20251029193423.2430463-1-lizhi.hou@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|MN0PR12MB5739:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d9300cf-a39a-40ae-f5fc-08de17222ec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IAfbBqdrYcWfN5DVozG8upA0a+KGMdSCfmH+eV/3/pvPq/zzPq2zhCQZ72gC?=
 =?us-ascii?Q?4iU9OOk5J3JbWG+36gKbBi7LpnHm1+hLy2IoKESgJuU5CUVETTUbVd2iwdd8?=
 =?us-ascii?Q?Ji0UztDBdinNcI8lmMtW36CjsWE0NE9JVEIohIJNeg51M/bzJPkjH/n2raw2?=
 =?us-ascii?Q?xBBE3Ch/kOrkFLjrWSM1CR/Wdq3Kqod4sDyPYub9gjThxpLH6+pvyrw+zOHc?=
 =?us-ascii?Q?7lDL79wXWTtAC3dUaIB1AWO7seK9NNKszzAQ5kmX/2/JTHyRcPDgb/fbg3tH?=
 =?us-ascii?Q?s7OPDRmbnpv0ct49tgBmM0sJzLS1qAInWOOkAQOCLcK2zveYVi0ZnQpEnRD+?=
 =?us-ascii?Q?e493x4m3taeuzfRKc7VEI92gzzNZEvtn0xIR6ZG2bhDWTNlWuoCKk1AWXgVg?=
 =?us-ascii?Q?It9B7OsslNs3cWSkfHrn9Kferz7C284cUEE6qyAG4+XETaRODV1H85rHyKvp?=
 =?us-ascii?Q?dmcyRqO88fVz5dSK13h4+1k44zMIF2ujP0BQlcXL51JdiszXND5GiwwKzkAg?=
 =?us-ascii?Q?CEbQktDSzWd9bssfokownDO1IkMCripRDa+2GGQnvMW2rnEF8ukX41cH14y4?=
 =?us-ascii?Q?oBvZoP1dA9b5Pa2pTTfbOrVgANGsK+3ALw+SKyVudkK6e7flh5kvMvmTEc/I?=
 =?us-ascii?Q?DCMmPNKXrs3rgGX25sJhoVleq4coHRBwLomzxwRpuIih28yp39POYM6dyVfI?=
 =?us-ascii?Q?wR2hMw55XDwpf+xx6oSggfmyKTgAUKMt8GIBenQfAQZQB6uuxCL7wxxujcpE?=
 =?us-ascii?Q?g0RC5z09WCFO2TZ79lZMgsjN1tZ7PBAY30s0hRJRWKsF1/SinEWvR3gECep9?=
 =?us-ascii?Q?v59waXkCtW17PVqzqx8F/xpfh3WN1Em6YKcEce6Fny1feP1KfGhpXKGxy3X+?=
 =?us-ascii?Q?Ie4cw4eNWrlL06hTdhOOhXiQsDwzmS6ENeQkqAqJjM+UMmeEVUNde7eg1Dt8?=
 =?us-ascii?Q?Vpl3oz0hcRILRvbtRcx5vHXtDYz9N9f5hokmt+0GPGxvogTXlSAWjVxG534e?=
 =?us-ascii?Q?LVHk57ePxoJ+5Zwn3J6oxALco16pFqid+XYLYSynLpGs4N7J2mFOi9FS5FSo?=
 =?us-ascii?Q?Sdjk1whk1JxaDl6dHfpAZU+y2+LyOip35OdpX0oNCaub1XqDyKvENqPLfkuG?=
 =?us-ascii?Q?k6bCEFy2pi3gLvW8xcgXSXNmQXw00tmqPI/py2jS56rm9JuK3JAgwYMVtmxC?=
 =?us-ascii?Q?VSWUAjZNmVxOB/sTDEgwiwEb15XJb/qQfAJu/Pe5mUN7gBVM2eT2L0IlWWpr?=
 =?us-ascii?Q?Glj96AbKVwFAQS8EUPoKu8GpjXZcV9PtNZx2fJEQWrwTenNq1L+ox6eeDEAj?=
 =?us-ascii?Q?n5XkGCM3uYPobJLrMP6io8HrCg2n6lu2P2gqtPDQZjaCMAWVFynyIIk60exP?=
 =?us-ascii?Q?8elyABG5Ux7BBMVPp4ezGYRbbux21fAnqD9S3wG72+d8NLsS8KYVSPNBPGuk?=
 =?us-ascii?Q?+6ZmR2nG+RRmO0g6tfY6iUivT1o//K6F0ezw+n49i3f2TmJXvw2cyJHkn0m0?=
 =?us-ascii?Q?sQgzPjUkjrXGho8KSSwcMV7hhTECpfl7SwKaCHr/GXo9Bv4v9i6vsaShZdS0?=
 =?us-ascii?Q?TrvGLk0cHDz7bEW+3vw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:34:31.3447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9300cf-a39a-40ae-f5fc-08de17222ec5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5739

When a command times out, mark it as ERT_CMD_STATE_TIMEOUT. Any other
commands that are canceled due to this timeout should be marked as
ERT_CMD_STATE_ABORT.

Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_ctx.c    | 15 +++++++++++++--
 drivers/accel/amdxdna/amdxdna_ctx.h |  1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index c6c473c78352..289a2aaf4cae 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -204,10 +204,13 @@ aie2_sched_resp_handler(void *handle, void __iomem *data, size_t size)
 
 	cmd_abo = job->cmd_bo;
 
-	if (unlikely(!data))
+	if (unlikely(job->job_timeout)) {
+		amdxdna_cmd_set_state(cmd_abo, ERT_CMD_STATE_TIMEOUT);
+		ret = -EINVAL;
 		goto out;
+	}
 
-	if (unlikely(size != sizeof(u32))) {
+	if (unlikely(!data) || unlikely(size != sizeof(u32))) {
 		amdxdna_cmd_set_state(cmd_abo, ERT_CMD_STATE_ABORT);
 		ret = -EINVAL;
 		goto out;
@@ -258,6 +261,13 @@ aie2_sched_cmdlist_resp_handler(void *handle, void __iomem *data, size_t size)
 	int ret = 0;
 
 	cmd_abo = job->cmd_bo;
+
+	if (unlikely(job->job_timeout)) {
+		amdxdna_cmd_set_state(cmd_abo, ERT_CMD_STATE_TIMEOUT);
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (unlikely(!data) || unlikely(size != sizeof(u32) * 3)) {
 		amdxdna_cmd_set_state(cmd_abo, ERT_CMD_STATE_ABORT);
 		ret = -EINVAL;
@@ -370,6 +380,7 @@ aie2_sched_job_timedout(struct drm_sched_job *sched_job)
 
 	xdna = hwctx->client->xdna;
 	trace_xdna_job(sched_job, hwctx->name, "job timedout", job->seq);
+	job->job_timeout = true;
 	mutex_lock(&xdna->dev_lock);
 	aie2_hwctx_stop(xdna, hwctx, sched_job);
 
diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
index cbe60efbe60b..919c654dfea6 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.h
+++ b/drivers/accel/amdxdna/amdxdna_ctx.h
@@ -116,6 +116,7 @@ struct amdxdna_sched_job {
 	/* user can wait on this fence */
 	struct dma_fence	*out_fence;
 	bool			job_done;
+	bool			job_timeout;
 	u64			seq;
 	struct amdxdna_drv_cmd	*drv_cmd;
 	struct amdxdna_gem_obj	*cmd_bo;
-- 
2.34.1


