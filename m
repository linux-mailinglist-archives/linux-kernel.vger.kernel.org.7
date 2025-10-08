Return-Path: <linux-kernel+bounces-845041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F048BC35A0
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 06:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 77C97351269
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 04:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75C82BF017;
	Wed,  8 Oct 2025 04:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0GV/oLoV"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011041.outbound.protection.outlook.com [52.101.62.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A7529BD9B
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 04:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759899219; cv=fail; b=S5QI3UJtgp3dS0F4n7ZxGDwQRkAhehPcBS2wtBgYPeiqRqO/5+mwjEj+31qIfhNe6o8HIaenJXIxy/h/ydoDP6p++eKJddeJAi6oMnrx7WqYNogVjBcDIZsCt/gD8Qr3UX3cci8QY+9YqaLxM98e0koB6lFdAwqm6HoJ25PD3tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759899219; c=relaxed/simple;
	bh=hqXLkGg170y1i3smDIa53TAMnw43mGv8NWCmf8IxvTw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H0+GkejLwb8CK+tIEgmQAjja/QGVPQErkrkbQgZvHocWmTJDDWw0E5DEDzWitSbKDYqWrre2FmSM1lCMcf2r37nC1PKJQo2IsGlHucjc+sFViy6RHk/jNQgGI5DpCdMxjBjv68Pi3ZResbyq/ltJojjPTUgfHM+kIcmKKaNqlpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0GV/oLoV; arc=fail smtp.client-ip=52.101.62.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVWJ2+Fc86iNJP/z6PfoyhakIosXIdhN5+cJNCqxAkfxTQaMeF71KKAJ7c7qVuF9Lz0UdnVYefw+6misdKoVWFRhYc30TjWUB5IJ4gTD4BmNDy6Sdl9EdWNkYgKBd9fqj2P/niE13av0z7RkDdkYRyYkOvJw/cQLz13PAYpvx6vrMo6nUsjeA5pCarVC+ONOfPTyH/lFev5DkBNuSUL/DdKrPDIRM/sPmcLroOVV28JPBa/QH0FNkzzBHIZTw/t0Vfog1vp/DSlZBJaM2wjYUHFswyp/O/KLxPsmQ3GTeQVSfFjv0kqTsSz9syjhBt1xPipmBoQ80qYjg16Oa8+uoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6sni/LGgni+SK33pnZW5y5G81STOeDYxcfuw7R5TSc=;
 b=a4md24vmTGUrwZ1ZEYr1p8hy0Xjui2GNteYOLNrV9+c7HntaqiYGuL7C4MqNwtODyT8Xdd3JXPshIk6p4/5c8e3utRRTuzI8r+CjsdWbj78av2UyRYeZJHlr7PbYOtoqme02D7kE3KFOQ1e1LY2QG3SNDuS6J/qljKgHK6ajQTJX7+cGrfnDKvcND2fnUezCSqWeSTwrQML3o3CibScZYCTSDjAaK8pZxLDbR2/9q26XngmR5zfaYQEmNbQvxe1jHLP4hH4uApe+1XSp69fypInh94PHhhuyvfH/3UneLLv8/9HnQNwClNAEYC0jz27LUSK/7BO5hprdAbtNWLubuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6sni/LGgni+SK33pnZW5y5G81STOeDYxcfuw7R5TSc=;
 b=0GV/oLoVVzSJOEEyCVSTilL3UKvMYUIoIXiXx91+zC9lZ94tElWbkxYNHN+c+Et1C+jajqJLs6AtcQZ85TM/YnI3Y33Gcz2Gq86Qtw8z8HrDIUEEGgxiyBwELLkCkC2m0EZ0njqwXD3k/QbTimVYHA3Kjn3iigryIpUuZ3FZ7rE=
Received: from SA1P222CA0047.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::20)
 by SJ2PR12MB8110.namprd12.prod.outlook.com (2603:10b6:a03:4fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.18; Wed, 8 Oct
 2025 04:53:29 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:2d0:cafe::11) by SA1P222CA0047.outlook.office365.com
 (2603:10b6:806:2d0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Wed,
 8 Oct 2025 04:53:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 04:53:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 7 Oct
 2025 21:53:28 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Oct
 2025 23:53:27 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 7 Oct 2025 21:53:27 -0700
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
	<maciej.falkowski@linux.intel.com>, <dri-devel@lists.freedesktop.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
	<max.zhen@amd.com>, <sonal.santan@amd.com>, <mario.limonciello@amd.com>
Subject: [PATCH] accel/amdxdna: Resume power for creating and destroying hardware context
Date: Tue, 7 Oct 2025 21:53:24 -0700
Message-ID: <20251008045324.4171807-1-lizhi.hou@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|SJ2PR12MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f371c9-8cb1-4b84-0438-08de06269f56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vruTtU2n7p/gwtk1sWq1q/x6+9Oz7UkT5fuUiozkShjGTtzxfpdWFMe9ys1B?=
 =?us-ascii?Q?O04nVc+d3vhfGFwu8qdwo6NFF/lxThizN6V1cFHOHhigVcALdaH93WUo06pq?=
 =?us-ascii?Q?4SLZp6sIDhrIo4VCaRHvAym4zY/Gid0Ku9m9018hzz1Qxl/w3GYNyvlg7wtB?=
 =?us-ascii?Q?YNVzE6KkQFnKSEO2GpmBWid4mIvARDCcPJ4pWGQcWUm80ZQwU8H7an0dT8os?=
 =?us-ascii?Q?nOMr/3mRAY7xO/dwu0dDzxwxopH/9HlVGhen2K174UprxZg01zTvraYN90Lf?=
 =?us-ascii?Q?cdXS5qZULtakFwKJ7v2XPMwReQO9eemJx4mBs6WZNUzikwQU5AkHoA2uweRb?=
 =?us-ascii?Q?9yu9LyDdbXBqgDNxwbiWZlLP2CEiUHV1xuxDzUkyxL1bUlyF6eho0dAFBS2y?=
 =?us-ascii?Q?3AFLRkc6fR6D90+VmTag4LOcEDaEMYV4oyLXtQ4ihlp4U/CoWXbmcXEZ9jr8?=
 =?us-ascii?Q?zIumfnTSZKF3+aKwFMwgEJMgPxipYk4CLIkO2kETII14p84ggoR60v1woqdi?=
 =?us-ascii?Q?MScEt1ib89GcuEp5FJKPXMibvCZTiG9pBsZvIavX+I+2FNsfwPox7zlNEcyy?=
 =?us-ascii?Q?de4/SqC7paI0kZjCpStR8nACx4U6PPBsrK52LPXMewWdRFhDgw8D3wkVurPH?=
 =?us-ascii?Q?ftQ5kGz/s4aajyEGAP+zk9Lq+mTRhgeO+Dey8I9Nrhacgs3Y3wymxd15tqou?=
 =?us-ascii?Q?UfVN1h4bi+e9O8Sr8Htf+AuP5exNnR0rDTPRwWsRIVcmg0UyF8NF0eC+NXcn?=
 =?us-ascii?Q?S0upMUuTu85vpnK9Md3zRoFYzslsE4PLVYVnEhqlx3vUkBe9Suo8vnb71PfA?=
 =?us-ascii?Q?EdVSajQ09biN2/x6MeI/Lek2LeqEm9AePJEprg6Xpi+YK6WT49HKJLOzfYNa?=
 =?us-ascii?Q?UKnPjK0PLGJOTUtpnC8NdkZRP+NOAb4hdEOm4sz+azSYtKejhPI6wtfmrsfK?=
 =?us-ascii?Q?mZyRQfY1Vbvk+p8uvDRjt+XoXZbimdVQjYn4vzzAK/GT6VI804dOySPFx47U?=
 =?us-ascii?Q?GHOwsv6UQtQHnuQPpCrFR8fcsbr40lbqM5gAflbE8EdCbH7eKg6iVfBQuM1Y?=
 =?us-ascii?Q?YA4VfgOyo9Qz1zJYJUrq2kf2fLSJ4TotyJj1sXlFgJiG8Z75al2J4uAQboTO?=
 =?us-ascii?Q?17oUXzz+CwcwcpGk7XJw79OrG+C+yHAp0SCg9IGmM74G976RjZFkR+1BtWVw?=
 =?us-ascii?Q?gS5vZ7yidoGLRuAOssvb+zlgSSKA5IV+nbJ9Ry1P2053sSaXwqxnyUWr/yML?=
 =?us-ascii?Q?88JLx/7xGgwD5msd6nAsFgWUaqZvNpITTfJRbQ6Wo1K03bbXUD5bLjxKHo69?=
 =?us-ascii?Q?lRu4Byy+T2Sa0zSQWLhkYq9kdKHOPo/UwBizs3Y47iYDmcs9Iqf836dIqJnA?=
 =?us-ascii?Q?NXYQXiir3O7/4Q9SEhjnWyJrMuaQGAFF/kFF+2al+LZk8bfrqKj4Vib+/3j3?=
 =?us-ascii?Q?iQvUPvhNziJNNtYJzLDCjcDhX0r5/gr6rD3t5gYSQt65F0EvvWDKKCq2U0zR?=
 =?us-ascii?Q?7MX563H2sgjuYUxMV0ZZcrKvVQ5jyW/ddxgrdlh7ET4jAP3SBg9EN7sKVe8J?=
 =?us-ascii?Q?qNT9WBxzNd2pKBpGcHY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 04:53:28.4218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f371c9-8cb1-4b84-0438-08de06269f56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8110

When the hardware is powered down by auto-suspend, creating or destroying
a hardware context without resuming power will fail.
Call amdxdna_pm_resume_get() before requesting the hardware to create or
destroy a hardware context.

Fixes: 063db451832b ("accel/amdxdna: Enhance runtime power management")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_ctx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 691fdb3b008f..ab4d66f1325d 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -610,10 +610,14 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
 		goto free_entity;
 	}
 
+	ret = amdxdna_pm_resume_get(xdna);
+	if (ret)
+		goto free_col_list;
+
 	ret = aie2_alloc_resource(hwctx);
 	if (ret) {
 		XDNA_ERR(xdna, "Alloc hw resource failed, ret %d", ret);
-		goto free_col_list;
+		goto suspend_put;
 	}
 
 	ret = aie2_map_host_buf(xdna->dev_handle, hwctx->fw_ctx_id,
@@ -628,6 +632,7 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
 		XDNA_ERR(xdna, "Create syncobj failed, ret %d", ret);
 		goto release_resource;
 	}
+	amdxdna_pm_suspend_put(xdna);
 
 	hwctx->status = HWCTX_STAT_INIT;
 	ndev = xdna->dev_handle;
@@ -640,6 +645,8 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
 
 release_resource:
 	aie2_release_resource(hwctx);
+suspend_put:
+	amdxdna_pm_suspend_put(xdna);
 free_col_list:
 	kfree(hwctx->col_list);
 free_entity:
-- 
2.34.1


