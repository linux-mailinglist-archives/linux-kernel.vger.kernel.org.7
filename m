Return-Path: <linux-kernel+bounces-818250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2736BB58ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF8A2A3282
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477632E54A0;
	Tue, 16 Sep 2025 07:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fanxZ/AG"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012020.outbound.protection.outlook.com [40.93.195.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166C92E3B11
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758006565; cv=fail; b=AIF2qFvFWZ/Vf+ROBIuljWhNZFT5t9OJJyQZ/jRCSA1PI3KVoXQmu3MZgn2gif8Mwcys05KOfWed4ilrhZjJTXchb12M+33wX0fpyoj/lCdb7C9BELM7keMwp7jCjlWvx6HcjU9eSnD5QJ1n18DW5VL70QTCwyIwbk49Up7nS94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758006565; c=relaxed/simple;
	bh=oY1I5mE8i9Ty6a9Y4eSuqN8WBqF+TLbsjj2lt+Q5IlI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+YaDCeIYt55ltqzPXp1lglB37dhsfUmS6XPevls4Pa9AQDgxjjWP0F4kSon1PWU1PPZwDEuNfchCvNxCMyEcic1rPMElsVj9pfz3+/vXMeDyBYqXe7dIR7Bs8+KWYSpc660NFkC08V2r48rlUgXVtezqa8BkOMsGXNGyt3pAW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fanxZ/AG; arc=fail smtp.client-ip=40.93.195.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9FGPb7qTWFmOxBDL7llk+PdDzGSP2UR/vhMoXxcn4CKzdxAXyNFvLWQYZtX4Fm+C3psItQdnrw2/n31K7tGY5cUjo0hqQ5PKZ0yzPjWaWRiE+73/JZsuo1KPztXR89uLs60kx/ji2nli60u/vPMdg1mxiAfuevu2MDmwU2JBDCMyVv91jcLtUmD6aWcILni09JhqwClHzx1nj7eAe6sFvQTpmWLjmLVm3XTp21ko3ZECQF0DGM6BIXq66FNlGqoMWIh4X0PIiq1OsnvIQZY3toB4p7+JEQBMPiIPt8K7N7VD7FpCX1LqSKNBJRnyG00HkUcl07ECC/bvPaiZaLMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6NpChupbqRtX+Zu9qyrJxdEyRjZ5aVSvEDXQkKQDfI=;
 b=yUoCK51ObKJG8d/zOV1iBb04+cnn8ck+q8vtmDWg49gAYeNZ5ky5oy33w1t8w71UMhjkAgf7DYD76FN6a7cRKm5gSU/BdEVeYmrrvkqmtuMRBG3NgRcuMUj4mK3uHbE5T0zgpbQ/vrKB3x6wmLt55Jo2un4u0/D8I/CYKY+fuqLL1MuogiXZquvn4B0qbttvMYEB2KBp35NlOHbAia8aDOwUgz4rXB/6/54TxdlMjDdsAUDQYbJRuxTPYpMfR6jZuBkTAnFRl3hJ2+97rjLwWd6sviQYrRBw//lqqX4iY6TX4JQCoONMSPUXHSwNJl8rcxvhSk/f7NvCLk7/iaOtEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6NpChupbqRtX+Zu9qyrJxdEyRjZ5aVSvEDXQkKQDfI=;
 b=fanxZ/AGG8VhTzclc03gbd5rLTTokufMIch5HKvguzf+F8+4h3e+Lr4DbjAFMPBFd5PMXAN086kEwxbOozi2Gdz3nI+T+i2nCVzEHNvdFTqEXrMgGc6MJgVnmiUdlMBUWjlofhxDE85S2AS+WbzN81aX1g5wlDZTFa2pWgoyM74=
Received: from MW3PR05CA0010.namprd05.prod.outlook.com (2603:10b6:303:2b::15)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 07:09:20 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:2b:cafe::aa) by MW3PR05CA0010.outlook.office365.com
 (2603:10b6:303:2b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.11 via Frontend Transport; Tue,
 16 Sep 2025 07:09:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 07:09:20 +0000
Received: from FRAPPELLOUX01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 00:09:18 -0700
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/2] drm/amdgpu: remove gart_window_lock usage from gmc v12
Date: Tue, 16 Sep 2025 09:08:45 +0200
Message-ID: <20250916070846.5107-2-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916070846.5107-1-pierre-eric.pelloux-prayer@amd.com>
References: <20250916070846.5107-1-pierre-eric.pelloux-prayer@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|MN2PR12MB4342:EE_
X-MS-Office365-Filtering-Correlation-Id: d24a6453-5e1f-4de7-2307-08ddf4eff555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sV4GcfLgzrcmntLCxuMN5oPl1ANsrTwUB1wtdZYo2EHC+OQ2iq5sFwGWoFW2?=
 =?us-ascii?Q?U+b12LlbO3Dzof6injjx9H8ukVMpX6uO+DYZgXMeBDrJ372a5H/5Xs6ct5ra?=
 =?us-ascii?Q?Y5DYWLDM0mvkzxAcxS4VdS67n7mnzjKytNvArvu4lhz67RefF29GPNMTvtnU?=
 =?us-ascii?Q?YJmbGV6PqUz7eqm1F4yLS/LbCSm+Xt0OdCzUwnOkaBsmyRoCmtU0eB2Nqq2w?=
 =?us-ascii?Q?sJsFw7KUopl5qTMtpY6/jwah3JI/veHG+d2CFU7LDHjRTY2V38ubY4ZN15pU?=
 =?us-ascii?Q?dXN8RFFrjU5Di36AV/K/dSDK0Z7kSMI4iGiF7ZSfo1t8BS3vyPgP+JZrRI5V?=
 =?us-ascii?Q?8K3ACOBdeOXV7z+ss+1arNYiMZukchWaVGHIFktOzS5kyTedQr719EoCoKeO?=
 =?us-ascii?Q?Atb1s41+06mW5/vWQTI0NyQwXiDiBbtXvyz3z5/6JRxcf7edeYUDeUtz96Qs?=
 =?us-ascii?Q?AbhFEIb01TbCPCsd3eWsY4ORQAo3GMSArorMj9zhEiFi1b6RYXDWPCx+45hb?=
 =?us-ascii?Q?NkwQaBtmYcnfZCmE8wFeK7fNOkz/pNMHevYUX48+bBujurltoXGHfSCgUqK6?=
 =?us-ascii?Q?dSPj0aWqR2nmwgihwEEtyzQG3uvpDCmLM8TgchhRhTYX7ejHItWqJPYjdJqW?=
 =?us-ascii?Q?S+68psdd0gihTwTszjTISZDIM0WFs4/cfb9ra6zX8xY72yUK3oaaDQMykTA4?=
 =?us-ascii?Q?FKrMiDR539WL1F8skSLW2Pui5RP9V83ciBdQqr0j5NoQBCEgcOAtaCxrZQ3Z?=
 =?us-ascii?Q?Xmrm21U8PChMxMALjRYKwtb8/gSwZk7T81adB06xdqo1QOj4i9YUPavQOxWj?=
 =?us-ascii?Q?vnJYHjNbzNL5jiSzUp6upbM6H86m1q9XSpDee9JekG+aWFOeGddoeUWIrtvK?=
 =?us-ascii?Q?p3+FB/iUfkndGyk/3fp2Tqj7BcI996efgF172nYT+w3nUOmn8DiL3m7VWq6+?=
 =?us-ascii?Q?3BIzzqDZT44DxEuLfEAa7NyoebAHR7+MuiGgzoLVKKL87363FwCJrhnlgXM9?=
 =?us-ascii?Q?rV8rFQcC+YRvufPmNKuKmOejcGG3IVnH14agiB9bFa+qvHWIHuTOIBn0TKVB?=
 =?us-ascii?Q?QMRs7252EMZGLEwa5K1vxj0OtXOQgtwzRcr+xWWkTAxLWxcWmX0DxHsuI2eF?=
 =?us-ascii?Q?lXf6CUGwWHL7cT8V5OXxOwPRAMjpxtBkjxZv8K5+HFx4la7DIqGQjLqgqMv9?=
 =?us-ascii?Q?YaZ4zv/jGcly75SlqrdmQRlpPIABdJg5W2F4wUo/c29G6noFHuY3QbQcKRax?=
 =?us-ascii?Q?b/Lkd0B4Pb53Y530h9bkhH6oOp/KQDS/MMvHu9DwwCiu2Xp8lf99Xl1vRn3z?=
 =?us-ascii?Q?a9IjjZ8WkkhGv6pR/Rg8eaPWlKodTtg5aTanCZ8B7YIavvugAm3SpmXIaklY?=
 =?us-ascii?Q?YXb5LXmLEGElrzQoO960OsypUIvqOJXt5J0x67PuhS42OfXshBLM2TNokVsQ?=
 =?us-ascii?Q?ud8NPqV61Q62xk/UB/+eW/hTbMWv72azCZ/0hs8U9elZoOMGHrejfFDuob9z?=
 =?us-ascii?Q?qpE+MBgDjhNLjsUsxyhJ46UbFcy3g4No66+V?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 07:09:20.5506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d24a6453-5e1f-4de7-2307-08ddf4eff555
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342

This lock was part of the SDMA workaround originally implemented in
gmc_v10_0_flush_gpu_tlb (a70cb2176f7ef6f moved it to
amdgpu_gmc_flush_gpu_tlb).

This means this lock is useless and be safely dropped.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 76d3c40735b0..454fd1104c6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -312,9 +312,7 @@ static void gmc_v12_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		return;
 	}
 
-	mutex_lock(&adev->mman.gtt_window_lock);
 	gmc_v12_0_flush_vm_hub(adev, vmid, vmhub, 0);
-	mutex_unlock(&adev->mman.gtt_window_lock);
 	return;
 }
 
-- 
2.43.0


