Return-Path: <linux-kernel+bounces-763138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E7BB210CE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998F818A283E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A052EA159;
	Mon, 11 Aug 2025 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XaMalZoS"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C8A2E9ED9;
	Mon, 11 Aug 2025 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926804; cv=fail; b=MmFiJzuHB7vhRTCZjdLWvbfblr6Tj2M8EoLloTvQLwOP8r03Hy61FH3wXEQ09fj/O4ZVISKot/AknsqSDcH8jjMXIZoTS2P9x7aZd0G3/kiOmQGsz3DFf2yY3Fz5SAnqNk3V4hixYU9CmetK62/7D6aaQW76/GcMJMDN3p9J6/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926804; c=relaxed/simple;
	bh=n8pbl14GXsa721NzPxbQMLeg6hFHNiqYDVuNs9WfUps=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bw5EZdVtE7CerWAAlzUTY2Ols23k6m6D+fGtO2/edTr5nTOqarWZ3N2EHeZA6e6KZJipZM7J9FYO3kM93T+m96wAYTPdij8Y9qB7yiUHsWhfPHWflZP9oq9V6sUWPjre/7wHGRgorrctgiSNTYaCuTxiaB3dH0ZQdzydp7BTxo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XaMalZoS; arc=fail smtp.client-ip=40.107.96.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j9QGM3vBCmGxn82XNHgX4rTV0UF1n+e/vnQEtlztgjYFOjn+dtgaPGQBkU6QGdmJkGu/Mr3w/iKZJyu354KpNU1JNu4+Z/NJOsdC7fQSD6bdyHEY2pekvuEGoLDogIp+fz3f8m+ErqteKZ0ROLUvdCJIAgLfjuppWKtFCSLzGwc/ZoFIpqlMgGn7obforafO6BnEN1jP88xd6jjLKJswFOnFs92JyMOFLjikkkHuYRBTv6QJoqj51HZ9MPeXGKLPDkaNJvvSa0GZmK8X2iPNPmjH5kBl9LYmG0swfh4MQRnDku7IjFf4Z/kZJgm+o5tH+M+e9r5CeRqv2t2JOYZ4OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRUrv+aN+c4YyS/WEc9NJ6DvYrr5UpzhvMQ2Zk8bL94=;
 b=wKtS0JClUrgKCElsVa0nxzWfO5TGOn5cETEv3Y2ya7n6ylhzo9V+Zdc0cn9vmi8Z7XPmC/eNmJV03bT1Q3boznEg1jZWufmGarVOtiKRgQreFxtWuNkNewr2GxEMYuRvs53tHtdfOd0jQxZitTCUMNN0A6zkFrUAvgiLaVr1dLJX5Jtc+APvW44BCuK3HmOl9frSIwWatlA4IlZVr4YSLbQM3WctFfhVA3XYuaw3xzl/IPa1gTVXyQQLR0vBbr2YbPyIXtSU0D3EcrpwhUzMO31qdUHZaaCxjRxcKJylMXNNmx3fjAPC+fwKf/wRoGsgJqsit20KGup3ivWegMZCbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRUrv+aN+c4YyS/WEc9NJ6DvYrr5UpzhvMQ2Zk8bL94=;
 b=XaMalZoSY7+WcmKVu7c8RsKgnYcAW8U66Mq03KpuKvA5hVIciD9vCie+k5Tl3LBrshb/bOqChS5vc9yMA8yCJORoOi1cL/OYK9DJ+V03Uu4PunC8+Mb5mrC7j9erP2Uy2yH2vxlhRDe/DifaDiFolmaemLud6KXeQWBWroNkS0jPbBisqGnbi0F2kEbZQNHg0kbJ9Ic9797WGP1PyBqElqWFIda4xLUODJ8Gpcr6cZP0z4buhQvvMNcAKkUsgc/9yRy9A2HNo9er4eoP59tYn++R45RCXNSj+vKHhspqbK3RUnM020U3DdIDJ51ygyrV0Tw9mNkBK8/n4aOIAvVX7A==
Received: from BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::15)
 by IA1PR12MB8192.namprd12.prod.outlook.com (2603:10b6:208:3f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 15:40:00 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:59d:cafe::7b) by BY1P220CA0004.outlook.office365.com
 (2603:10b6:a03:59d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Mon,
 11 Aug 2025 15:39:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 15:39:59 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
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
Subject: [PATCH v2 4/4] platform/mellanox/mlxbf_pka: add __free(kfree) to handle memory allocation
Date: Mon, 11 Aug 2025 15:39:34 +0000
Message-ID: <20250811153934.671070-5-xiangrongl@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|IA1PR12MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b9673b-1ff2-4f75-fb6d-08ddd8ed54ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w+Dm1iBCwEaQ6k4hyiq6o/HLPtt69bBzvMaR7wie84ABvQxmoH2iC5qyasaM?=
 =?us-ascii?Q?zNStCsXQLrB6KK/dJ4+oKuBqYSmgjtwLUbZa5OJLRUt1vEvKFjlTZdafrgU4?=
 =?us-ascii?Q?7jFqgaP0ATPsPVwnzp48fCoeziyHOClwiZLSgNStiG0RxRmO0UhIv1VLuDNi?=
 =?us-ascii?Q?74PrWoDooSxNBVOd4F/Api0ZFaEGh66DOEoZGR/R7BX09U3qkNzo2IINVJ6F?=
 =?us-ascii?Q?Ipm6hdxaQ5ynsR3RUzSyXrehjOjGuzXz2qjLBRAp/ERl0xBsKbPrsPHTxdL+?=
 =?us-ascii?Q?lXWJ6ec9YrFaMGaX47Z7pN72yppjzQpWhZp7ldCLjQTN9mEupifytbE4oI5M?=
 =?us-ascii?Q?CiaV06dT0ky5FhJV1Aj2fopUOfn13bsuqkLObZcaovzcqegqwq4GS9UYqqAA?=
 =?us-ascii?Q?ps4O5M6jR2sJWBzsSjCffqiMdbPl6wBoxnGPIMiVppM8iohxP4L4ZCgRSBus?=
 =?us-ascii?Q?+N6eugH7XGNJy55sBZxu1L9eH+N2h04VKj6dVLqFMuptlYxfudiVzFauCBmk?=
 =?us-ascii?Q?ddHI+8+EogoQmbE9TY+yCrEeZRT3F2hLiUg+n0VmdJXngXlCC+CKwEZZ1euo?=
 =?us-ascii?Q?0X8c9f5tfL0jBf+Nk7EgTMIALtj4ST5lj5ewxEn13kDewaaisuOJFvIzZSqI?=
 =?us-ascii?Q?YJ3sf+f/7XuxFz/YSfp54/at5W8kvkqzpQPHdD4JLdWMXs+PY8X5FfNZWMJp?=
 =?us-ascii?Q?Xr7YxUHyZEZ6qgiSEG5vNorv/7lTK/fMeQgX2TWu1/MZIuFMEIELV3XPlTd/?=
 =?us-ascii?Q?QrsKIpa/d6/ESV0S1KYX4LAObEVdIWXvcEExkEC6zGhn148U3Ah13GZFp48P?=
 =?us-ascii?Q?x7Y10nsAijeqm7+rql6tslu9haRwC4a/4xteC3rsH/23uNhdm0/qfKfWzdLF?=
 =?us-ascii?Q?lEsDig8eQWEvsENBQr5kLpBCs+XzW8+aWbnx1Nl53l9tmBVJ6Fr0uflawKMg?=
 =?us-ascii?Q?aQG01cPU+BEPTwHfWNN11rVLYEKMVrEphoha487/Q9jMbWPTx7sKi3fyWebu?=
 =?us-ascii?Q?L8jS1AicgdSgMUu4I7kpijJCWcm0QFZJjWnX39XnN2i3Xy6c2t/YFDyRDXdy?=
 =?us-ascii?Q?MPfcFWBQOilITu2ds2NVU0wpz7rIEIEkE+6DlxdsVuHfkLWcVdUBvd+BORDc?=
 =?us-ascii?Q?kVIPEhQrKRkiZWdHK1rBVvjl6Mke5At49eJX0kV+w0A11hPkMQKwCMVFK2Pa?=
 =?us-ascii?Q?Eg8UzzhO/hVHUQhwatIXgQZAIR6QMTiMQ41+egLjiEhJbVBwyVrXHRJcqsE2?=
 =?us-ascii?Q?rZYy9akeShr7q5aoCkc0+4RKFrAIgo+2z0hnQf85b9P06nPPXnJt74FEddFd?=
 =?us-ascii?Q?4CEXLa0uSmcwYWpcqNvyG8GTXTOu+7RootWxBFLpQBVy216gD3LJecojPk88?=
 =?us-ascii?Q?ysEyRbfQit3kEDtngafN9nek1+ZV2hZeBTS0uLsa1TePScpaR81qkDVjxi/I?=
 =?us-ascii?Q?s1n4BxLA52x2QVppTpi9EguLu5KCbvDfP9z4ImFmRyCpuFzrez0wH8p++PCB?=
 =?us-ascii?Q?JQBw8i85/Q64j7OnXx0SWk3rmeKisxbt2IIF?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 15:39:59.4584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b9673b-1ff2-4f75-fb6d-08ddd8ed54ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8192

Used __free(kfree) attribute to call kzalloc for allocating the 'data'
variable in mlxbf_pka_drv_ring_ioctl(). So that the variable can be
released automatically.

Reviewed-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Khalil Blaiech <kblaiech@nvidia.com>
Signed-off-by: Ron Li <xiangrongl@nvidia.com>
---
 drivers/platform/mellanox/mlxbf_pka/mlxbf_pka_drv.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf_pka/mlxbf_pka_drv.c b/drivers/platform/mellanox/mlxbf_pka/mlxbf_pka_drv.c
index 0f93c1aa7130..2dd773ec1dc3 100644
--- a/drivers/platform/mellanox/mlxbf_pka/mlxbf_pka_drv.c
+++ b/drivers/platform/mellanox/mlxbf_pka/mlxbf_pka_drv.c
@@ -3,12 +3,14 @@
 
 #include <linux/acpi.h>
 #include <linux/cdev.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/hw_random.h>
 #include <linux/idr.h>
 #include <linux/interrupt.h>
 #include <linux/iommu.h>
 #include <linux/ioport.h>
+#include <linux/kdev_t.h>
 #include <linux/kernel.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
@@ -438,7 +440,6 @@ static long mlxbf_pka_drv_ring_ioctl(void *device_data, unsigned int cmd, unsign
 		struct mlxbf_pka_dev_shim_s *shim;
 		bool trng_present;
 		u32 byte_cnt;
-		u32 *data;
 		int ret;
 
 		shim = ring_dev->ring->shim;
@@ -456,25 +457,21 @@ static long mlxbf_pka_drv_ring_ioctl(void *device_data, unsigned int cmd, unsign
 		 */
 		byte_cnt = round_up(trng_data.count, MLXBF_PKA_TRNG_OUTPUT_CNT);
 
-		data = kzalloc(byte_cnt, GFP_KERNEL);
+		u32 *data __free(kfree) = kzalloc(byte_cnt, GFP_KERNEL);
 		if (!data)
 			return -ENOMEM;
 
 		trng_present = mlxbf_pka_dev_has_trng(shim);
-		if (!trng_present) {
-			kfree(data);
+		if (!trng_present)
 			return -EAGAIN;
-		}
 
 		ret = mlxbf_pka_dev_trng_read(shim, data, byte_cnt);
 		if (ret) {
 			dev_dbg(ring_dev->device, "TRNG failed %d\n", ret);
-			kfree(data);
 			return ret;
 		}
 
 		ret = copy_to_user((void __user *)(trng_data.data), data, trng_data.count);
-		kfree(data);
 		return ret ? -EFAULT : 0;
 	}
 
-- 
2.43.2


