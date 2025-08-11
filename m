Return-Path: <linux-kernel+bounces-763140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07368B210CF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97EFD687884
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534D62EA168;
	Mon, 11 Aug 2025 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FIDKFTqW"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24EE2EA141;
	Mon, 11 Aug 2025 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926805; cv=fail; b=ZwYSozN+njN/2niV1uTOABuUKPu3ARQMDT3YtjKyljBsbDaMcKu0lsoEJn+v6ZVmN4w3Hnspm6QA6yFFDrXVvg9uHtK6PaM3xO0VKQt8F4Lma0rQ/v46HwFynRfoOBzvdblGBiMbFdFqxDdQWjIWi0Kbrp8o9oNhPj3mr7qh4Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926805; c=relaxed/simple;
	bh=M6QbAj/xfutfUua5v5Zt68eLCs88v76QethsOK5WBjw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kBpdX7DY6XssJyyzipb7I+1lW3xZfNYCmpmfvlTuxZxfPSGCrRi9nTVZ8pl2l8WmYfD2IXxgSl84uvdMUXX20cnfsnVUuHSrp/PGvjCHLHDkc/gjz3PVfUSCQ5WRUEhZz2cVO9KMCxI1eW24tDG8ukcJR+xCFuzqohxyw5PEt1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FIDKFTqW; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyJcyPpRSJGraQ7UiCYx8wEIe+p8mmV92TF2h9NFsjYwoZTJTfJ1eeUgtZr7Hosz3BUZ+H0mtcGODYrKxHC3lhZFB0MlGxLSjrKG3V6f/iNCW9ItJ83CpI4CN3Ku2cnI9phOyVRANh5szxQsac4RkEQToRvgHnCRtdfSCHvFUR4U8kdzo6VjJ+rwVsNQb9k4/MxK63V1mwbfyoxoXV46Sn+1Ele9yO7p8tIkQ1VvzOrNvY5Zo2N6jrWbwlx/wDwQeLI7iG75W0JjFSFD4RpLOy+6avs07LIM0+ZsCLO6Te7iG3n5W/XsW5Y944fwErFD9bKYe0kXvz+JvWkfMPSeIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wugK+h8qdWUwfr8Gp1EvRzsmB/GBcIdAu/vWcrN+JGA=;
 b=bOJmlsD/xcoK3H8/93r2F4cwwD6Ia6jvKl6SjkS/XJDOjK5HycLfxx5NJ9yE8GjD/vTFuaWE0OKLVezVebtv06FjsqcOgIh0Lns0Z5I9xcfdykKcFCyMXJhO/AgFzYUaKJf9fbdTBjv8V6JOI5jEO8AdLpzW2+n7Nzt0wbIAxvx5xF87R+DLxLVwUWZ2Mj0KI2M2NfZpx9IuJ9Kn9VDCTv7n4VekoGSMOAEF6zgR3kzmHfMc7PU8WsbIo/tXmJu+36NynVTUCTXtxESnR3LSjGp7DiKWaACklOqTCwbM8VLO9NBRLokOJjtxRg2FWk88ophnJcMdm2gbWNWDmBN3Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wugK+h8qdWUwfr8Gp1EvRzsmB/GBcIdAu/vWcrN+JGA=;
 b=FIDKFTqWhAvCHwIJ/DKhnCET3FQQvK29ObGfn4ZJbVOWdwZXBTr3cx4NpVx5w4ymWnS1s6ikQ+MxPrCtosoJh35JM6iBl3yc4HbTkrs+ayfFBChwYo93j9sJm0ytObnJh6/3tljNYgSXocuNlA/fBRHuhzYyGaCH75bXEs+YrpWzZOwZVrvjiUzgzYR+ENP8xSTj+TGA6csTYbXN1DWCSC87232ZchrUNYRsHP6hn7Lt3PkMCytjJeCeDHv4BK49krRbaoeQiv/xfIToHEmG3xP+Z7Bb8WcoC9Vg8xamGg3tSph9W8hD9PWcsCKTCCiZKRoKzHrcT1u/CPZ0/TsyBA==
Received: from BLAPR03CA0102.namprd03.prod.outlook.com (2603:10b6:208:32a::17)
 by SA1PR12MB5660.namprd12.prod.outlook.com (2603:10b6:806:238::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Mon, 11 Aug
 2025 15:39:59 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::8c) by BLAPR03CA0102.outlook.office365.com
 (2603:10b6:208:32a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Mon,
 11 Aug 2025 15:39:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 15:39:59 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 11 Aug
 2025 08:39:40 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 11 Aug
 2025 08:39:39 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 11
 Aug 2025 08:39:39 -0700
From: Ron Li <xiangrongl@nvidia.com>
To: <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<vadimp@nvidia.com>, <alok.a.tiwari@oracle.com>, <kblaiech@nvidia.com>,
	<davthompson@nvidia.com>
CC: <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Ron Li" <xiangrongl@nvidia.com>
Subject: [PATCH v2 3/4] platform/mellanox/mlxbf_pka: add devm_mutex_init() to initialize mutex
Date: Mon, 11 Aug 2025 15:39:33 +0000
Message-ID: <20250811153934.671070-4-xiangrongl@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811153934.671070-1-xiangrongl@nvidia.com>
References: <20250811153934.671070-1-xiangrongl@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|SA1PR12MB5660:EE_
X-MS-Office365-Filtering-Correlation-Id: dd202d6c-e5bd-4789-eb3d-08ddd8ed5484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AQcAyWZj8tUc52Hrs59qbQL+PlLLYdqXvg17m352Y941ddDGoqmK+h5JpLms?=
 =?us-ascii?Q?io2psUCCjVaE4r1yAXId+vTu1VohouSN4Dm5o3op2RPrOxo/xmGaQ2hY+hg0?=
 =?us-ascii?Q?/buFaYPSEoowJlQRHzzRQzyauevq/9CD08AzmPP5WKunSxhOT08s0kzMblCz?=
 =?us-ascii?Q?61Z74UdqyratL350bhKF1rNmqAU9L1H18mVSIUN4K+YWcYQMcA7VsyVh7H9C?=
 =?us-ascii?Q?6S77J1apS+i7b63po8k+raO1AzEujXauiB4e5/5isP88LdGxP4HCJ+0edkxA?=
 =?us-ascii?Q?QJV5BvFWXZQ2SiHiu5BLmauRKR1zLfKsywRsSuPfWuqIfGjzdz3dfwxj05Ci?=
 =?us-ascii?Q?+Nh3gBcjN9J/I5kCk02RjIvAfwk7O+/5rrc/IFkeWCFx4rWGI95DKEc/Q9l8?=
 =?us-ascii?Q?qE7HjDHhlEOTaX4V+BTFgQoNHQJLw59XanQvAap99+ePFpCTCX0GkZe7hFQY?=
 =?us-ascii?Q?y/ETg0VnFGMRuq92wrZhd7zmEn7lKNXgAPVmi4BfAAc0EBjIYKSIzx8+psZv?=
 =?us-ascii?Q?UNMRs4D+DOAl0zDn2ThFFMyRdbeA3y2wpzNiImBZW7wgkpO1+phssJYFhBOx?=
 =?us-ascii?Q?Lkf0l47Os1rVAim4YL6THIZ4+eX13+mrMPVqP7kWX1M188Zjqni+gRIRMWtT?=
 =?us-ascii?Q?eN8aYUNh2kRV4fdGi6NYyO/06zAFUAlaqO5g8WrXNe03X/C3fX8DIyb1t8Eb?=
 =?us-ascii?Q?1UzZfk96TDcmog1ANOi0OmQObSOvP5RTLej5n2q6+3v+Dk4Is+cPnjuxV0Kt?=
 =?us-ascii?Q?YfcjS6rdaTNyad02lktDsmx+ZSsEjvPYeLBHufMnlFb0lQUaL/xDwIRcmsiG?=
 =?us-ascii?Q?e8vf9BNmgb0Fl5tgryipgFexmbx3AlqT2WE/kXtOkBtXNnHyuIc4NEx3nwAJ?=
 =?us-ascii?Q?YYWChLTVUas9jZ31fXHCiWzprhQjkH/SY54kkKp0g0bJvyU60IBloaS8Tn0g?=
 =?us-ascii?Q?iZ8dg30g8t0TJM3y4Jr50k8nuPAHLTD8BBXvrQEir4ki67eIJLdVjQtyDFVr?=
 =?us-ascii?Q?+csCw8laEYwKhRg6WRxtizcAcTVxmkOdqG3qDYdU4NIXSkEK0/J5BwFX8LZF?=
 =?us-ascii?Q?3R/fxlUY4/ppcOYycjlTYpCqEw8PqBgSpeb5oKyh9x09z7+Mo9IL7NrrRv+V?=
 =?us-ascii?Q?2r4biidrmh1uKu8pvGGaCzbxu/d2Rp7ohU3WNXCchszuS50kfnEk82e1JFvW?=
 =?us-ascii?Q?bxR15JxMzLEXibBzZEik4OqJocvrxGtw4X995GIolsCtaWoqmzrvWgfRAEkD?=
 =?us-ascii?Q?W6sep3casuBwpa1+hhDRPQ+j6Ltn9ypSv3h8GlkAgCu3rqn7gxsU42/oFSeX?=
 =?us-ascii?Q?FA4nIIwgITwAuSONgrR9NCxA9KGHYwGyxpbZXDvndDcC/K/Zy3w7We4+Vb8L?=
 =?us-ascii?Q?XadnjNmZsFioQZlzdYlxK2rkyX80hTec6WOY4scYw5mdNCmvwi4RfgGn5b0y?=
 =?us-ascii?Q?yOtBu1BKtlCD1jArxDQ+YneLxjsXz2R/Rl/mT4Ziulk/du818OwqdJ8DpQx+?=
 =?us-ascii?Q?BRSdQOrLWCViRmBEd9/DBg/hOfLdP0U41w03?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 15:39:59.1436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd202d6c-e5bd-4789-eb3d-08ddd8ed5484
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5660

Reviewed-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Khalil Blaiech <kblaiech@nvidia.com>
Signed-off-by: Ron Li <xiangrongl@nvidia.com>
---
 drivers/platform/mellanox/mlxbf_pka/mlxbf_pka_dev.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf_pka/mlxbf_pka_dev.c b/drivers/platform/mellanox/mlxbf_pka/mlxbf_pka_dev.c
index a0282ae0c62e..9b52d1170900 100644
--- a/drivers/platform/mellanox/mlxbf_pka/mlxbf_pka_dev.c
+++ b/drivers/platform/mellanox/mlxbf_pka/mlxbf_pka_dev.c
@@ -296,6 +296,7 @@ static int mlxbf_pka_dev_init_ring(struct device *dev,
 	u32 ring_mem_base;
 	u32 ring_mem_off;
 	u32 shim_ring_id;
+	int ret;
 
 	if (ring->status != MLXBF_PKA_DEV_RING_STATUS_UNDEFINED) {
 		dev_err(dev, "PKA ring must be undefined\n");
@@ -354,7 +355,10 @@ static int mlxbf_pka_dev_init_ring(struct device *dev,
 	if (!ring->ring_info)
 		return -ENOMEM;
 
-	mutex_init(&ring->mutex);
+	ret = devm_mutex_init(dev, &ring->mutex);
+	if (ret)
+		return ret;
+
 	ring->status = MLXBF_PKA_DEV_RING_STATUS_INITIALIZED;
 
 	return 0;
@@ -1455,7 +1459,10 @@ static int mlxbf_pka_dev_init_shim(struct device *dev, struct mlxbf_pka_dev_shim
 		shim->trng_enabled = MLXBF_PKA_SHIM_TRNG_DISABLED;
 	}
 
-	mutex_init(&shim->mutex);
+	ret = devm_mutex_init(dev, &shim->mutex);
+	if (ret)
+		return ret;
+
 	shim->busy_ring_num = 0;
 	shim->status = MLXBF_PKA_SHIM_STATUS_INITIALIZED;
 
-- 
2.43.2


