Return-Path: <linux-kernel+bounces-763139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB4DB210D0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00EEF687920
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC36C2EA175;
	Mon, 11 Aug 2025 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sbuRxpWm"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425C62E9EDD;
	Mon, 11 Aug 2025 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926805; cv=fail; b=f6rCeW28UmHpTVT+n/VZeoRSe5+6Je2lHiSMxKmInwfD1k098Ajwz698G/0XIKeWYRFlvxGq1/mkLKG1nu8GGTieWEEH7ujfmPgs8fX2xiSi2yU6TNR81QRd8FZ8bnczz36FncVRGyGLB3C/4kB5QyXvA0JmkQv1jo8sR/iyFzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926805; c=relaxed/simple;
	bh=WTUOJOD5VCS7Mk0ybqwIXRHdOfqbxfKUyFaNATlqmxA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pHb+8gJsSdKhUSp3Is6HEo38urGZfcxmpGb+d4ycdT6ft6jpS14sB2qlRGSgjXPkBnCX984TjrCs13DjJNDJzhRoCcqMg7OHg3yGoHhgD4ICmiE/BJoOyUE/HkU1i66IysUUc8Vu21fkzPy76HikTvzNSQGCljYd9fXz28w1OHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sbuRxpWm; arc=fail smtp.client-ip=40.107.212.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPliRy6EOcSeo3YLo1Iz/ua0Gb2bMbpYmUYm+h2dKZRIlnzZVGd1+6TPKlSznHNHqjwfEeMAsht3c01QPsezC7zfQbJxAGCwYXEH0kisNgNh2VSZ399HEb7880lUYSRhNnxZHHH8dEV6vJ+D/V0hph7xz+fPyVZ4kuqdZDz9YZJyiYkyrLc2sHy6ioUtQSeR6USQBN4NxITfW4jMi9GqzOG2QDhHq/pNNJpYibuZDDwz7vsTxMfqUiDUinIwJbPOthpom+cSyjiaE2LDZ07lF4Vw4S6/9ksf6XzvQUCO0lGaGRlF2RSEcKoab61sqU86kkHd2mg8Yfv5v9uUbDf1Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z306sAub2Dg+nu9dPOUHsH7OlD98BVSvRiVf+tNAgCI=;
 b=DBEn8p2TXHZthwAA8hpwt+V0rhH+4m0xd8jEqjRJkRs31XiTudCJ8euoDHcryscN+ySXCtGcwRX7BF0fKM1Hfbv+4rlhbvi/OE/5IBVy1stVzh/cXQe9cnitFSqECis0qL5U7cAymzuZ9if7yYLxwT32B5ucxZ91W9tPU2qe3YSUFaREdCcSC9OGgnSow6s1GhJpDRuc7D4hKVu/nAmO6dg8AmboSSRIOsMKQlGlh3VTZDIFECP8YbNj1IEytdOS5KkLFfVB5qH4l3Tzw+OMyP6l3V8nrjVatApaw3Jqio/Ev3NbVJ9mRsscm4oVoGVt8cGcUo0+wU1Lma3oZJwG8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z306sAub2Dg+nu9dPOUHsH7OlD98BVSvRiVf+tNAgCI=;
 b=sbuRxpWmDbHwqNDkToYbmwtQzOibvZ0xGZWNG6lpDyiQ1Gy/fZQGifI7Iy/0wD+ZxvMHufWhWla+ebyoDXs99cF76TtQHjpMgilluwEUpGCmm2mKOPOJE9MdHKYAhmszQrtFnFPaPASaVGb2bK0xCmwnAHwFIdqCWxguFgGSsuOnDIbfOs/fbGPgJeMxpH/FWoOtOU0GctnfsWk5rYjCZl5UzGn3xmwQSNTyiCV5/RURugPtaTF8us1UIuxQ6LB4QdkpO90Yh92XIU+9EZfU71qRlDsZ/txF0eiiWZybJTMaOMgphN6ePmBR+pC2lnk1aF6ZN9I1L4V6GJIlMljU2Q==
Received: from BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::15)
 by IA1PR12MB6284.namprd12.prod.outlook.com (2603:10b6:208:3e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 15:39:59 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:59d:cafe::7b) by BY1P220CA0004.outlook.office365.com
 (2603:10b6:a03:59d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Mon,
 11 Aug 2025 15:39:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 15:39:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 11 Aug
 2025 08:39:39 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 11 Aug
 2025 08:39:38 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 11
 Aug 2025 08:39:38 -0700
From: Ron Li <xiangrongl@nvidia.com>
To: <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<vadimp@nvidia.com>, <alok.a.tiwari@oracle.com>, <kblaiech@nvidia.com>,
	<davthompson@nvidia.com>
CC: <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Ron Li" <xiangrongl@nvidia.com>
Subject: [PATCH v2 2/4] platform/mellanox/mlxbf_pka: add guard() and scoped_guard()
Date: Mon, 11 Aug 2025 15:39:32 +0000
Message-ID: <20250811153934.671070-3-xiangrongl@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|IA1PR12MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1c04b0-7505-43b1-559f-08ddd8ed5438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RcmAwXeLyipa/iUIRUz+3W/MWYbJUvaswDewRqwjZtGuyZ7URslFpAGcGV0J?=
 =?us-ascii?Q?vT7x+hcel7R0Cht7Q6q4ckZlWclUqhB5Gvq/znCo8Nt3TPsQCV3tIx0gyWj8?=
 =?us-ascii?Q?cJglnPvEjY74VI6sXGCQnXiDeOYTLeKSQTn3/8VoXmTVW1Xr/spbzuBVnF8q?=
 =?us-ascii?Q?PLPHG2zhgdGGUIYVF67PjZu/RyhYWaVUrkzja71AomTNvwsIHp6SxhnVlZQf?=
 =?us-ascii?Q?oqjWoPEOJe7FHPOVPYOxLA265DlCANZ9C08iGK02L/oHwGz/JOZwdOV2k76d?=
 =?us-ascii?Q?vN+ZZloTOtFF1Rg+UoSYDmCGTO7IGvytdrMdbGzHpvaEOBi9hju8s/kSyzGB?=
 =?us-ascii?Q?HFFxdOpb3chItCm2j7CbXRwwsyB0rmlQ5uz4Gq1eqpDNypjq6zap8HjvYKxA?=
 =?us-ascii?Q?ZyyoUVBBcOnzEgDkbe7QI+enPJry9PxmrHgE9FdYgJCNyMW60asP5KXrFxdm?=
 =?us-ascii?Q?T7ZhPh/yXO42z2C7TXoMQ8k735xcTTTjpCCPpR2ocNvLmBYNcxbJfZneUaTG?=
 =?us-ascii?Q?gv9LqwDiISB2Cjt/cgETh6gA0AweKyuY+a5iVqQdcikkIejUMNI9+YlqEIMS?=
 =?us-ascii?Q?e9unPw4qUsDATuAemmTK8QEKiBpY+6VrHtj27oIlOWg1F2ZX3e/UPge1wLeZ?=
 =?us-ascii?Q?ueGQQRMtVCGWzwrLX1eSxwf8WyOq1jeMkmgsgBprj4cMUnaRPRdWb+uPwFvD?=
 =?us-ascii?Q?d9g7g7w1SLbM8zbqULnwjcOr7xKB4TrpTsvUie+cTBg56TUXWXdk3/X4EhAl?=
 =?us-ascii?Q?aCcJ/DL5lxBB5gdTzzZPc86L1xUyU8Cot2p9wUwut2CriLjJhHfBmOdP49Z5?=
 =?us-ascii?Q?lTL0VKBXgQYkhmnXizTCe5/IB5qgdB7YlsW6dhtcjKRn3RMFHpWkaifI+iOP?=
 =?us-ascii?Q?6pP3pitNJgGoTMMv9bfmI5RXIYQL/gHnN3lRAd34X2CjnRi22nbXkYsucRwB?=
 =?us-ascii?Q?YmGvHeR2N4WQv4P1AV9RZLt2GSo78p8xM9c9Ld2LAPrIeGye6hwtnVv9Uvk9?=
 =?us-ascii?Q?l1FIOIBdjhiV/Ni/PjHQS0qoyNDHKbXQYgH6d5WIc6KXQH/xW6yAsumQAqI/?=
 =?us-ascii?Q?UY/RFl8vm3lcKDxWeGl/IkX1bBVxOXGv8AiJy1QnxihNNhFqVGpwzJXtMdv/?=
 =?us-ascii?Q?8sgeABuRly5XlPS0QAYkw3pPi3xjGPLE66L1K/kSOkddCseYqLYGyBOE7yAb?=
 =?us-ascii?Q?n4wmyQ9o64uukWxZua5ELRsRTY1eAbFHDd7/5Uv5Tl5Kcn0c92UekOuKHNua?=
 =?us-ascii?Q?hw0UmWWNu8WUGde//1Txqmq+x+ZcA3FoP31Q9RftZ9NvDbc66GPkp+WElFmo?=
 =?us-ascii?Q?rZX89pdopP6eORcozhoz6CS+OA3Oje9qLE+Ww670PVMBpOTmjBHSw35Ywj3j?=
 =?us-ascii?Q?pPpK7OZHgQyP7oMXtiQhXm9eLPlkrLi+Ze9kGTBpgHvJj/54BQNQiqWPlRfQ?=
 =?us-ascii?Q?c57bitU2E1415LKMg4abJvpE5mlyIxo9Qs2LtGlkvz2JSicC9oyauV8Qd/0w?=
 =?us-ascii?Q?EU8Fkjw+XMwas1H+h3TIMl+dDn3sBBgR+CjZ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 15:39:58.6889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1c04b0-7505-43b1-559f-08ddd8ed5438
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6284

- Use guard() to take ownership of mutex and release automatically when
  out of scope. Simplified the implementation.
- Use scoped_guard() to simplify several mutex lock/unlock use cases.

Reviewed-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Khalil Blaiech <kblaiech@nvidia.com>
Signed-off-by: Ron Li <xiangrongl@nvidia.com>
---
 .../mellanox/mlxbf_pka/mlxbf_pka_dev.c        |  85 +++++--------
 .../mellanox/mlxbf_pka/mlxbf_pka_drv.c        | 112 ++++++++----------
 2 files changed, 83 insertions(+), 114 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf_pka/mlxbf_pka_dev.c b/drivers/platform/mellanox/mlxbf_pka/mlxbf_pka_dev.c
index 3048e7436509..a0282ae0c62e 100644
--- a/drivers/platform/mellanox/mlxbf_pka/mlxbf_pka_dev.c
+++ b/drivers/platform/mellanox/mlxbf_pka/mlxbf_pka_dev.c
@@ -1738,23 +1738,19 @@ int mlxbf_pka_dev_trng_read(struct mlxbf_pka_dev_shim_s *shim, u32 *data, u32 cn
 	if (!cnt)
 		return ret;
 
-	mutex_lock(&shim->mutex);
+	guard(mutex)(&shim->mutex);
 
 	trng_csr_ptr = &shim->resources.trng_csr;
 
 	if (trng_csr_ptr->status != MLXBF_PKA_DEV_RES_STATUS_MAPPED ||
-	    trng_csr_ptr->type != MLXBF_PKA_DEV_RES_TYPE_REG) {
-		ret = -EPERM;
-		goto exit;
-	}
+	    trng_csr_ptr->type != MLXBF_PKA_DEV_RES_TYPE_REG)
+		return -EPERM;
 
 	csr_reg_base = trng_csr_ptr->base;
 	csr_reg_ptr = trng_csr_ptr->ioaddr;
 
-	if (!mlxbf_pka_dev_trng_shutdown_oflo(trng_csr_ptr, &shim->trng_err_cycle)) {
-		ret = -EWOULDBLOCK;
-		goto exit;
-	}
+	if (!mlxbf_pka_dev_trng_shutdown_oflo(trng_csr_ptr, &shim->trng_err_cycle))
+		return -EWOULDBLOCK;
 
 	word_cnt = cnt >> ilog2(sizeof(u32));
 
@@ -1782,10 +1778,8 @@ int mlxbf_pka_dev_trng_read(struct mlxbf_pka_dev_shim_s *shim, u32 *data, u32 cn
 			if (!((u32)csr_reg_value & MLXBF_PKA_TRNG_DRBG_DATA_BLOCK_MASK)) {
 				/* Issue reseed. */
 				ret = mlxbf_pka_dev_trng_drbg_reseed(csr_reg_ptr, csr_reg_base);
-				if (ret) {
-					ret = -EBUSY;
-					goto exit;
-				}
+				if (ret)
+					return -EBUSY;
 
 				/* Issue generate request. */
 				mlxbf_pka_dev_trng_drbg_generate(csr_reg_ptr, csr_reg_base);
@@ -1806,25 +1800,22 @@ int mlxbf_pka_dev_trng_read(struct mlxbf_pka_dev_shim_s *shim, u32 *data, u32 cn
 			csr_reg_value = mlxbf_pka_dev_io_read(csr_reg_ptr, csr_reg_off);
 			trng_ready = csr_reg_value & MLXBF_PKA_TRNG_STATUS_READY;
 
-		if (mlxbf_pka_dev_timer_done(timer)) {
-			pr_debug("mlxbf_pka: shim %u got error obtaining random number\n",
-				 shim->shim_id);
-			ret = -EBUSY;
-			goto exit;
+			if (mlxbf_pka_dev_timer_done(timer)) {
+				pr_debug("mlxbf_pka: shim %u got error obtaining random number\n",
+					 shim->shim_id);
+				return -EBUSY;
+			}
 		}
-	}
 
-	/* Read the registers. */
-	csr_reg_off =
-	mlxbf_pka_dev_get_register_offset(csr_reg_base,
-					  MLXBF_PKA_TRNG_OUTPUT_0_ADDR +
-					  (output_idx * MLXBF_PKA_TRNG_OUTPUT_REG_OFFSET));
-	csr_reg_value = mlxbf_pka_dev_io_read(csr_reg_ptr, csr_reg_off);
-	data[data_idx] = (u32)csr_reg_value;
+		/* Read the registers. */
+		csr_reg_off =
+		mlxbf_pka_dev_get_register_offset(csr_reg_base,
+						  MLXBF_PKA_TRNG_OUTPUT_0_ADDR +
+						  (output_idx * MLXBF_PKA_TRNG_OUTPUT_REG_OFFSET));
+		csr_reg_value = mlxbf_pka_dev_io_read(csr_reg_ptr, csr_reg_off);
+		data[data_idx] = (u32)csr_reg_value;
 	}
 
-exit:
-	mutex_unlock(&shim->mutex);
 	return ret;
 }
 
@@ -1852,31 +1843,24 @@ static int __mlxbf_pka_dev_open_ring(struct device *dev, u32 ring_id)
 
 	shim = ring->shim;
 
-	mutex_lock(&ring->mutex);
+	guard(mutex)(&ring->mutex);
 
 	if (shim->status == MLXBF_PKA_SHIM_STATUS_UNDEFINED ||
 	    shim->status == MLXBF_PKA_SHIM_STATUS_CREATED ||
-	    shim->status == MLXBF_PKA_SHIM_STATUS_FINALIZED) {
-		ret = -EPERM;
-		goto unlock_return;
-	}
+	    shim->status == MLXBF_PKA_SHIM_STATUS_FINALIZED)
+		return -EPERM;
 
-	if (ring->status == MLXBF_PKA_DEV_RING_STATUS_BUSY) {
-		ret = -EBUSY;
-		goto unlock_return;
-	}
+	if (ring->status == MLXBF_PKA_DEV_RING_STATUS_BUSY)
+		return -EBUSY;
 
-	if (ring->status != MLXBF_PKA_DEV_RING_STATUS_INITIALIZED) {
-		ret = -EPERM;
-		goto unlock_return;
-	}
+	if (ring->status != MLXBF_PKA_DEV_RING_STATUS_INITIALIZED)
+		return -EPERM;
 
 	/* Set ring information words. */
 	ret = mlxbf_pka_dev_set_ring_info(dev, ring);
 	if (ret) {
 		dev_err(dev, "failed to set ring information\n");
-		ret = -EWOULDBLOCK;
-		goto unlock_return;
+		return -EWOULDBLOCK;
 	}
 
 	if (!shim->busy_ring_num)
@@ -1885,8 +1869,6 @@ static int __mlxbf_pka_dev_open_ring(struct device *dev, u32 ring_id)
 	ring->status = MLXBF_PKA_DEV_RING_STATUS_BUSY;
 	shim->busy_ring_num += 1;
 
-unlock_return:
-	mutex_unlock(&ring->mutex);
 	return ret;
 }
 
@@ -1901,7 +1883,6 @@ static int __mlxbf_pka_dev_close_ring(u32 ring_id)
 {
 	struct mlxbf_pka_dev_shim_s *shim;
 	struct mlxbf_pka_dev_ring_t *ring;
-	int ret = 0;
 
 	if (!mlxbf_pka_gbl_config.dev_rings_cnt)
 		return -EPERM;
@@ -1912,13 +1893,11 @@ static int __mlxbf_pka_dev_close_ring(u32 ring_id)
 
 	shim = ring->shim;
 
-	mutex_lock(&ring->mutex);
+	guard(mutex)(&ring->mutex);
 
 	if (shim->status != MLXBF_PKA_SHIM_STATUS_RUNNING &&
-	    ring->status != MLXBF_PKA_DEV_RING_STATUS_BUSY) {
-		ret = -EPERM;
-		goto unlock_return;
-	}
+	    ring->status != MLXBF_PKA_DEV_RING_STATUS_BUSY)
+		return -EPERM;
 
 	ring->status = MLXBF_PKA_DEV_RING_STATUS_INITIALIZED;
 	shim->busy_ring_num -= 1;
@@ -1926,9 +1905,7 @@ static int __mlxbf_pka_dev_close_ring(u32 ring_id)
 	if (!shim->busy_ring_num)
 		shim->status = MLXBF_PKA_SHIM_STATUS_STOPPED;
 
-unlock_return:
-	mutex_unlock(&ring->mutex);
-	return ret;
+	return 0;
 }
 
 /* Close ring. */
diff --git a/drivers/platform/mellanox/mlxbf_pka/mlxbf_pka_drv.c b/drivers/platform/mellanox/mlxbf_pka/mlxbf_pka_drv.c
index 95de7fa513dc..0f93c1aa7130 100644
--- a/drivers/platform/mellanox/mlxbf_pka/mlxbf_pka_drv.c
+++ b/drivers/platform/mellanox/mlxbf_pka/mlxbf_pka_drv.c
@@ -486,9 +486,9 @@ static int mlxbf_pka_drv_open(struct inode *inode, struct file *filep)
 	struct mlxbf_pka_ring_device *ring_dev;
 	int ret;
 
-	mutex_lock(&pka.idr_lock);
-	ring_dev = idr_find(&pka.ring_idr, iminor(inode));
-	mutex_unlock(&pka.idr_lock);
+	scoped_guard(mutex, &pka.idr_lock) {
+		ring_dev = idr_find(&pka.ring_idr, iminor(inode));
+	}
 	if (!ring_dev) {
 		pr_err("mlxbf_pka error: failed to find idr for device\n");
 		return -ENODEV;
@@ -550,13 +550,10 @@ static int mlxbf_pka_drv_add_ring_device(struct mlxbf_pka_ring_device *ring_dev)
 		return ret;
 	}
 
-	mutex_lock(&pka.idr_lock);
-	minor_number = idr_alloc(&pka.ring_idr,
-				 ring_dev,
-				 ring_dev->misc.minor,
-				 MINORMASK + 1,
-				 GFP_KERNEL);
-	mutex_unlock(&pka.idr_lock);
+	scoped_guard(mutex, &pka.idr_lock) {
+		minor_number = idr_alloc(&pka.ring_idr, ring_dev, ring_dev->misc.minor,
+					 MINORMASK + 1, GFP_KERNEL);
+	}
 	if (minor_number != ring_dev->misc.minor) {
 		dev_err(dev, "failed to allocate minor number %d\n", ring_dev->misc.minor);
 		return ring_dev->misc.minor;
@@ -575,9 +572,9 @@ static struct mlxbf_pka_ring_device *mlxbf_pka_drv_del_ring_device(struct device
 	struct mlxbf_pka_ring_device *ring_dev = info->priv;
 
 	if (ring_dev) {
-		mutex_lock(&pka.idr_lock);
-		idr_remove(&pka.ring_idr, ring_dev->misc.minor);
-		mutex_unlock(&pka.idr_lock);
+		scoped_guard(mutex, &pka.idr_lock) {
+			idr_remove(&pka.ring_idr, ring_dev->misc.minor);
+		}
 		misc_deregister(&ring_dev->misc);
 	}
 
@@ -746,15 +743,14 @@ static int mlxbf_pka_drv_probe_device(struct mlxbf_pka_info *info)
 	if (!mlxbf_pka_dev)
 		return -ENOMEM;
 
-	mutex_lock(&mlxbf_pka_drv_lock);
-	mlxbf_pka_device_cnt += 1;
-	if (mlxbf_pka_device_cnt > MLXBF_PKA_DRIVER_DEV_MAX) {
-		dev_dbg(dev, "cannot support %u devices\n", mlxbf_pka_device_cnt);
-		mutex_unlock(&mlxbf_pka_drv_lock);
-		return -EPERM;
+	scoped_guard(mutex, &mlxbf_pka_drv_lock) {
+		mlxbf_pka_device_cnt += 1;
+		if (mlxbf_pka_device_cnt > MLXBF_PKA_DRIVER_DEV_MAX) {
+			dev_dbg(dev, "cannot support %u devices\n", mlxbf_pka_device_cnt);
+			return -ENOSPC;
+		}
+		mlxbf_pka_dev->device_id = mlxbf_pka_device_cnt - 1;
 	}
-	mlxbf_pka_dev->device_id = mlxbf_pka_device_cnt - 1;
-	mutex_unlock(&mlxbf_pka_drv_lock);
 
 	mlxbf_pka_dev->info = info;
 	mlxbf_pka_dev->device = dev;
@@ -785,14 +781,13 @@ static int mlxbf_pka_drv_probe_device(struct mlxbf_pka_info *info)
 
 	wndw_ram_off_mask = plat_info->wndw_ram_off_mask;
 
-	mutex_lock(&mlxbf_pka_drv_lock);
-	ret = mlxbf_pka_drv_register_device(mlxbf_pka_dev, wndw_ram_off_mask);
-	if (ret) {
-		dev_dbg(dev, "failed to register shim\n");
-		mutex_unlock(&mlxbf_pka_drv_lock);
-		return ret;
+	scoped_guard(mutex, &mlxbf_pka_drv_lock) {
+		ret = mlxbf_pka_drv_register_device(mlxbf_pka_dev, wndw_ram_off_mask);
+		if (ret) {
+			dev_dbg(dev, "failed to register shim\n");
+			return ret;
+		}
 	}
-	mutex_unlock(&mlxbf_pka_drv_lock);
 
 	/* Setup the TRNG if needed. */
 	if (mlxbf_pka_dev_has_trng(mlxbf_pka_dev->shim)) {
@@ -842,22 +837,21 @@ static int mlxbf_pka_drv_probe_ring_device(struct mlxbf_pka_info *info)
 
 	if (!mlxbf_pka_ring_device_cnt) {
 		mutex_init(&pka.idr_lock);
-		mutex_lock(&pka.idr_lock);
-		/* Only initialize IDR if there is no ring device registered. */
-		idr_init(&pka.ring_idr);
-		mutex_unlock(&pka.idr_lock);
+		scoped_guard(mutex, &pka.idr_lock) {
+			/* Only initialize IDR if there is no ring device registered. */
+			idr_init(&pka.ring_idr);
+		}
 	}
 
-	mutex_lock(&mlxbf_pka_drv_lock);
-	mlxbf_pka_ring_device_cnt += 1;
-	if (mlxbf_pka_ring_device_cnt > MLXBF_PKA_DRIVER_RING_DEV_MAX) {
-		dev_dbg(dev, "cannot support %u ring devices\n", mlxbf_pka_ring_device_cnt);
-		mutex_unlock(&mlxbf_pka_drv_lock);
-		return -EPERM;
+	scoped_guard(mutex, &mlxbf_pka_drv_lock) {
+		mlxbf_pka_ring_device_cnt += 1;
+		if (mlxbf_pka_ring_device_cnt > MLXBF_PKA_DRIVER_RING_DEV_MAX) {
+			dev_dbg(dev, "cannot support %u ring devices\n", mlxbf_pka_ring_device_cnt);
+			return -ENOSPC;
+		}
+		ring_dev->device_id = mlxbf_pka_ring_device_cnt - 1;
+		ring_dev->parent_device_id = mlxbf_pka_device_cnt - 1;
 	}
-	ring_dev->device_id = mlxbf_pka_ring_device_cnt - 1;
-	ring_dev->parent_device_id = mlxbf_pka_device_cnt - 1;
-	mutex_unlock(&mlxbf_pka_drv_lock);
 
 	ring_dev->info = info;
 	ring_dev->device = dev;
@@ -869,23 +863,21 @@ static int mlxbf_pka_drv_probe_ring_device(struct mlxbf_pka_info *info)
 	if (ret)
 		return ret;
 
-	mutex_lock(&mlxbf_pka_drv_lock);
-	/* Add PKA ring device. */
-	ret = mlxbf_pka_drv_add_ring_device(ring_dev);
-	if (ret) {
-		dev_dbg(dev, "failed to add ring device %u\n", ring_dev->device_id);
-		mutex_unlock(&mlxbf_pka_drv_lock);
-		return ret;
-	}
+	scoped_guard(mutex, &mlxbf_pka_drv_lock) {
+		/* Add PKA ring device. */
+		ret = mlxbf_pka_drv_add_ring_device(ring_dev);
+		if (ret) {
+			dev_dbg(dev, "failed to add ring device %u\n", ring_dev->device_id);
+			return ret;
+		}
 
-	/* Register PKA ring device. */
-	ret = mlxbf_pka_drv_register_ring_device(ring_dev);
-	if (ret) {
-		dev_dbg(dev, "failed to register ring device\n");
-		mutex_unlock(&mlxbf_pka_drv_lock);
-		goto err_register_ring;
+		/* Register PKA ring device. */
+		ret = mlxbf_pka_drv_register_ring_device(ring_dev);
+		if (ret) {
+			dev_dbg(dev, "failed to register ring device\n");
+			goto err_register_ring;
+		}
 	}
-	mutex_unlock(&mlxbf_pka_drv_lock);
 
 	info->priv = ring_dev;
 
@@ -908,10 +900,10 @@ static void mlxbf_pka_drv_remove_ring_device(struct platform_device *pdev)
 	}
 
 	if (!mlxbf_pka_ring_device_cnt) {
-		mutex_lock(&pka.idr_lock);
-		/* Only destroy IDR if there is no ring device registered. */
-		idr_destroy(&pka.ring_idr);
-		mutex_unlock(&pka.idr_lock);
+		scoped_guard(mutex, &pka.idr_lock) {
+			/* Only destroy IDR if there is no ring device registered. */
+			idr_destroy(&pka.ring_idr);
+		}
 	}
 }
 
-- 
2.43.2


