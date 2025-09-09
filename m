Return-Path: <linux-kernel+bounces-808578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52B8B501C1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442B3441768
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA04278761;
	Tue,  9 Sep 2025 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ofsAOZcz"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8BD25A2DA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432743; cv=fail; b=Wbg06vbSFbS1GUFc76PJQb/bQoZA58oGWJdUhNStGCxRMy6gC/ZNTcPur0ebAe+lpBdCL972Pez9F/Jre5FY5P3nf0GhfiZkJ9J6uOIfU0uR/vyClIWFiRMcCYCa6Ko8lzMZ2HFHZRBBORKvenBAogwAuC7/b8E+cJ+No3yXKdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432743; c=relaxed/simple;
	bh=rbYo2ybpSCyTQi9KuFfkRepwNYmgnA0MYYDs0PQ4tOs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JaRZoJiwO5l804Et+7WOJ2Yl+KydN3CrVavOvTN62utuF1Zdj4IWK6nhcp7WLVXoLW3t0xfGz3gPz2nQoYtYWT5yL5iPaVhhc9OvSQAg3UFKLaweJ9TdKA3UUyE01Qpl/gQfOEJTXrVh/3QoqgWffhpQ1eMpeeMWOZCluNgJ/P8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ofsAOZcz; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdSQgSRKoD2/KsRefDb2OSmMmlRTok0prlZhySA0HzawJ0ucFLsCQUEjaAcuXL4b3ocy8Qvw75ahgxEW3ePT2LmfJWlTWbbauqaiOfS77kJQpHI3PHxyJocBmeZIm6H12XH8ddbXTN5cjsf0otsOs5Kvrmuh6H0cPGEsDIYeeCB85c9tjEh9cGN1VKsk9PFOZeSNPALaF4o2TY4/SnsjU8T33joc2rbZnzJ8F1HiuBvkfHnvAotIBgkounO7fshwN8/nX9+c8CifRexQ5HLPVTS+fZQQyb5UwXdSCSFUJbW+ia3ErwG9AGR297TaV9tcqFN87KDmvx23w1OITE3tKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+re4CKwZ1351RNj0jhdofZlOrG3npzWzaJaNdqbEh84=;
 b=Zs6RQsODlDw8wZciT07J4Aztvgfww4nAP/4i5WjTUGO6NkJ7ZCJdjMheHNRs6Z7N8eFwrdKA3WeQ1tDPU44DJ9easbtdE9nuf2bNuwjFTGxfbk2gnokkPUO57NgvIgGmlTJPeo4Hkut7zmlYuhiBuzGeRZFO15VLkQbCtJtywRW8WUFPbB2o32L8vaULoi+8TYDjSjLKp1xtEg048EvjoqC477ExdN9fY/ZesPxW6VXulSTM+POM4bs2Ezwxzz1O7LZ6VZ0Nx6o2h3AsqIeti7KYaQ0ISY8Itp/UwlAb4Am5l3fbA3b2/jMl+Q9CioTQ55GZaz23XVWhCO3fNOxpWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+re4CKwZ1351RNj0jhdofZlOrG3npzWzaJaNdqbEh84=;
 b=ofsAOZczK+GmhJBHVw4tWsE+J+kBOvPN89iJu2d0pv/aWoAoqC3cMXfql3arcb1F2ktpKlyNncse8KVUIozriceuiaSjGOSfSklmNT5OIMrKbEOi4vCzPfbiRS78SsN0amAE8UUk/UJ++NzGMQ9PAroIX+bQ+WEdSP2JCEDWWow=
Received: from BY5PR20CA0016.namprd20.prod.outlook.com (2603:10b6:a03:1f4::29)
 by LV5PR12MB9753.namprd12.prod.outlook.com (2603:10b6:408:2b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 15:45:35 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::d9) by BY5PR20CA0016.outlook.office365.com
 (2603:10b6:a03:1f4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 15:45:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 15:45:35 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 08:45:34 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 08:45:34 -0700
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 08:45:33 -0700
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
	<jacek.lawrynowicz@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
	<dan.carpenter@linaro.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
	<max.zhen@amd.com>, <sonal.santan@amd.com>, <mario.limonciello@amd.com>
Subject: [PATCH V1] accel/amdxdna: Fix an integer overflow in aie2_query_ctx_status_array()
Date: Tue, 9 Sep 2025 08:45:31 -0700
Message-ID: <20250909154531.3469979-1-lizhi.hou@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|LV5PR12MB9753:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b0ecb52-4d0b-4882-9559-08ddefb7eab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m5BII0i9oabiWQKL/vCAn2ivG65IxFAHk18Sh1nZXAunoYHKNhwmDhqWpJGT?=
 =?us-ascii?Q?HhNUC5IlIIe/4CHegHFq/pJHWa7vNuvGK+nJK3+stxnUvp8ZuA6tPE4jWAoM?=
 =?us-ascii?Q?fnXdHX/vAzesDLiR+q9MUsvGttghFD2GwJXP/eUnh/4N2OhItiCORFS3SEl1?=
 =?us-ascii?Q?vpstLlHbeFBH1dFSW1efI1sqI2LihuH7gISnO1f2hID2/Wm8ObAXqr8bIwej?=
 =?us-ascii?Q?rKdOy7Ps1EHUQCBYcOT6DMvV4xDUYWaATdf2yRbCX07KyjQ60GSAuYJHJb8o?=
 =?us-ascii?Q?Yj5V/2Ddtv/5nippgGAJkMGheJtewDooWSh1JJSVlq9euZZiuBgiIyCwooYq?=
 =?us-ascii?Q?uwXtW9a3ov/mA/q7msEX1CRLd8jWUek3wpygJf96VrpVuRI4EgzRInM1QQYt?=
 =?us-ascii?Q?P+ZbPeCgJRvxdcQYi+HxIJSfFQ694YDoVg1v8hq4XFP00EvNjwOjSG581B/5?=
 =?us-ascii?Q?8qaePyh+1JXuqqIXKdKl9sdNubFM+f7khGHvZ4JXjjaDgSUCF+HFU99aXCKq?=
 =?us-ascii?Q?RS03kyEyzBxn2SyaHA7bJsuSMbPiwYJh2g+kJig2Tj2UOS4F+qHzs7SEmyqt?=
 =?us-ascii?Q?c+JKJRsojLccE9djDLQXJrvDL57v62cDxHDcHMmEAx6qoldEwCf+aOxuEC4K?=
 =?us-ascii?Q?GPcBGfvWlLhgDE7XDXVr/u7YwqipBk7CotbBp1t3uh8kBYuvsjuyGf7JdF+S?=
 =?us-ascii?Q?Yzhd/z9oFx9uhpveis+DeI5wbz5Vg1zwe27n/ey8mWn+T3/7K1F/2mj8XlWG?=
 =?us-ascii?Q?jxrITLZT/Kkot1tq/6H2OLvl3nYDv+lIm6hcTw0fg1hGBgc45j5HT8kbmaHV?=
 =?us-ascii?Q?Nx+LvOTEOj7MyEH1ISbPO+5oj9wVCYBcnvb+2dfecVrOUKi1Ey9rPA5/CSOC?=
 =?us-ascii?Q?IYUYVRV8vXbCdWkbCDflxt1c4Yx9+CT+dURh+0SCRXO2xO0s0VUvvPs/0JMP?=
 =?us-ascii?Q?+oARWq2VkhQYLIJkI6saB3AHzk89lWonHqrEhhnbudsx607E53dwLk9oW0oa?=
 =?us-ascii?Q?wdkWX7hhGhihlHQrXzUxXY56km1i/W4nuPQtaGnrPmsqnc2/dFsUHBkDOwrx?=
 =?us-ascii?Q?0dnI1LOlnHmbHnwBImHxIsPoSvs/v8AWZAMaGikrlIiXj0/xX0OicoxZ0Ha8?=
 =?us-ascii?Q?qxXWM04raRS585vbv9ZGJx2fj4/qPH8uFmpjNK7F/y+cLM0KCUzA7/n1efFd?=
 =?us-ascii?Q?pVJOQDHhrqQqqSh/zLp3/nOUQlPz3eS5tqYWFEkGYM/QMSiP8IbLDXJgbFgy?=
 =?us-ascii?Q?cm7nZ8zt8yZpdk1NTr4uCoKEnVEYzOlumoEFo7CndJA853fVY7r+844LHPbU?=
 =?us-ascii?Q?vtDFGpPqeNnKSd7ONNGQo6w+kqbhlTGzSf6uTqNCnZfvngDWzMYdI3kx95mD?=
 =?us-ascii?Q?2iMzoA7jjWLL8g8fe9m6B85tSWYGYTVPTsNCw6Fl2tW4dACO+JkFE/fEiy17?=
 =?us-ascii?Q?CedWhxjRcNAMCKdrvEtmqaj1jGvDP0vjq0IfZKrbnM7FP3utctq1ZNrmWvTX?=
 =?us-ascii?Q?IpRR/3xZI9nEFpg+9KTlz02kJ161p5ZFau28gwzSiN9MgLtGt4L8WxdgCw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 15:45:35.0911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0ecb52-4d0b-4882-9559-08ddefb7eab5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9753

The unpublished smatch static checker reported a warning.

drivers/accel/amdxdna/aie2_pci.c:904 aie2_query_ctx_status_array()
warn: potential user controlled sizeof overflow
'args->num_element * args->element_size' '1-u32max(user) * 1-u32max(user)'

Even this will not cause a real issue, it is better to put a reasonable
limitation for element_size and num_element. Add condition to make sure
the input element_size <= 4K and num_element <= 1K.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/dri-devel/aL56ZCLyl3tLQM1e@stanley.mountain/
Fixes: 2f509fe6a42c ("accel/amdxdna: Add ioctl DRM_IOCTL_AMDXDNA_GET_ARRAY")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index 87c425e3d2b9..6e39c769bb6d 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -898,6 +898,12 @@ static int aie2_query_ctx_status_array(struct amdxdna_client *client,
 
 	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
 
+	if (args->element_size > SZ_4K || args->num_element > SZ_1K) {
+		XDNA_DBG(xdna, "Invalid element size %d or number of element %d",
+			 args->element_size, args->num_element);
+		return -EINVAL;
+	}
+
 	array_args.element_size = min(args->element_size,
 				      sizeof(struct amdxdna_drm_hwctx_entry));
 	array_args.buffer = args->buffer;
-- 
2.34.1


