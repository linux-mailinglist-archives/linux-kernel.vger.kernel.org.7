Return-Path: <linux-kernel+bounces-603772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F98A88C09
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 21:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86BB117B4B0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 19:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC85D1ADFE3;
	Mon, 14 Apr 2025 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ffw2vyOi"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D5D279787
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 19:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744658216; cv=fail; b=UNZkAlYqi/493XJd4i+zx7Gl+txer9BkKsdctVDeOIo4ExULhkYtJevdczewMu2Cr0csceFG4TJG4VoOAyFulAEW/orwhR0sNxyOn65Y3+8Bqjsbo7XJj8ivRZJ1iJHMcLG7hyji3sxZB3Ltn3ZMIC82D/vuN6G51DmPo7xFY1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744658216; c=relaxed/simple;
	bh=mK+nN0dxOlaTz1X0gsUadpO+rdD8QLp8lT3aQ4UiuMA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bR4JjDmutoPS+MtjHDg/PBsWrbammNUUBELIhmZFpa92cthQ7Eq3CeVmRVEdpvT1gHGVFQVzNfB6VKD7g4/eqvB9I1RbA1qFlJy3N7g4auiU+rlMzrksKGRhbEUbQCSzPlR5FlGmX5Df2ViNJy+0SyPdWVBA8//qIdGPt7vt86I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ffw2vyOi; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPCazbN1YfbyM+Jh6gUd6Rmsi4MpCeQxDnK8fImbFfzii9YfBXXf+xgrG4CENAOxpUDu7BHfEqwDb/TYEiGOaufGfFqFwLTQ8f3A2HSag1Igw7Bl2WwBIMfmYu58FTeRWoshuFSm6OwzgS/8naVv5coPlyLXpF7dwOZ6GPPtCFr/w5mGqj4lvPVFjNoYdcjrPLkuaOC+WxkAFnlDkImNAZwmi6+eQbHI3HCldJF+n7lQos4WuAUGBBFdeUfb83VNRmxwpVwvgmi4qgoEvQauyeoIqgi+Cv9DF+tynOI5L0t2LpW4VBQ854b13pvdmBruLxrGEPWuILAZAOHM3yLtRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlKPP81VEz4yL/E+v+vFQakMAIfes2nU58DXffQffuM=;
 b=FmHWxOLLJ5TbQk+hoPAPRMf2aOC3q5CisoKbmlMt2QBoPhQ5lokibgrrrdbUThFuji4Xstx0cFvUn/h6YC8VzYWBAtH2Pn+vV17+vvP+aBD9XwTbOD6bRustz37BDF6McwYZBtm0kzK3mJq53TUfG0EstdVnW1DODJPs3G/vg3CpZba1P1gGlKkUBSAgEuN/NU4rlG0Zj6Lu+TZawUwdaGdY/FpfakE5zCL3x9i2gf9KaUQ+HedMXF0PAc2JD/SRRjiVzDZFVm5DjD2O92oa3LuZWheSSIwQsODTU6wkOcxDlEuPgLWTmZJpVPsPk0iTTtAjklHZDlZmobz0Ikf51Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlKPP81VEz4yL/E+v+vFQakMAIfes2nU58DXffQffuM=;
 b=Ffw2vyOiPLjufC0ZvU1SmC8rqLN0vNvosw/O9mZxCEq18jkx0lsv5dJNzt2ne9r8qJfk8R3fqSudTofmvPl78gTwI9ZQTEC7rptJgC0xSKBHs/t/sOCpGliv7Mle9BQSZ1heIRfQwjN/223FWPt3sMnC7kRbWiELwb/pHTFecfCiahcHVcospi8TX+PlDYwxDnpUDviNtOwhUJIM93n4tksJAe8mpQbqEFa/4KV6XQzq4bHGRKzFR/5PnS2YIZUkbnuJWmhjsC6euEubnp1VUZ+C09zKMsQtkXPC2Gvwb9T1M9kfta0DPQERLbs/PtG+dSsON7Lh3/usdfT5NxWEvA==
Received: from BY3PR10CA0017.namprd10.prod.outlook.com (2603:10b6:a03:255::22)
 by SA1PR12MB8161.namprd12.prod.outlook.com (2603:10b6:806:330::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Mon, 14 Apr
 2025 19:16:50 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:255::4) by BY3PR10CA0017.outlook.office365.com
 (2603:10b6:a03:255::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 19:16:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 19:16:49 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Apr
 2025 12:16:40 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 14 Apr 2025 12:16:40 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Apr 2025 12:16:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <yi.l.liu@intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <mochs@nvidia.com>,
	<alok.a.tiwari@oracle.com>
Subject: [PATCH rc] iommu: Fix two issues in iommu_copy_struct_from_user()
Date: Mon, 14 Apr 2025 12:16:35 -0700
Message-ID: <20250414191635.450472-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|SA1PR12MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: 818e2748-6e28-4a95-4b6c-08dd7b88e847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8tdELetV9RHlDDsCS7IBRrrC3FfkZnlfbjj/8khwFOKQRNb3UoODXi9rVKJ2?=
 =?us-ascii?Q?RPy/xxr+wygNeD9SsGoNsQXrGsfUCKT+N7imOGtm4iF9DWqjGycKyW5+MZ67?=
 =?us-ascii?Q?j6ILRS23Aa32lIl2KOPDLF6t9m8azKeXRoYqnpfq0j08rrOjJqCnRWAJI+CF?=
 =?us-ascii?Q?9g30BbWw3VWs+Yicgwh2NHmtrqWAe9crWcPazT0eORBiL0XXuWhDqEIFv5Ed?=
 =?us-ascii?Q?yUAeLYOb/B8MRK3150CJ/UmPbM5BbyLcw/06MUi86wzUyFKRMgoJI5EE41Ai?=
 =?us-ascii?Q?Fq3bIcoDhRtmQkp3Ua54HJQx7Lm+g61eEYKEONc6c0jI+5EJm2XrfUHFp2Y/?=
 =?us-ascii?Q?HbrFBnGXJr/HLOpZI47y/omzsLoqwBwpRkiultUuXH5e/hA9lEWRZbWYon3F?=
 =?us-ascii?Q?o8HMyI+FE+BxF9j+IaRW+4DfTxZV18Ub5G/99brUx1NeMlJGnhYBIfiuSQb9?=
 =?us-ascii?Q?8ANn4yDS7jqKT52o8giEudRZsay/4PLWbua64NUR3zIRP4yqQuOCLCZ7ZDsl?=
 =?us-ascii?Q?dDUl5vZW9x+VDL0pujRabYvwlp/LrGPri7K8cNdZKft4hqL8yG8gFX+JdxsE?=
 =?us-ascii?Q?7hRqjG7Qdwjrd68BXVVTmco+Tw6jBN/hjLbiCFQSqgLOag37AKq8Ez5nF3iK?=
 =?us-ascii?Q?NOcQsOsmzuC2mPSIkf407tNA25s33Vrd9m3GDgXL5ZADw7q+G95tMLCiP9DS?=
 =?us-ascii?Q?tdjxXGMO8JRW6eoMjP/VF6yuagvL8caXOtlez37ht3TuInIeicTFpKXMXvD0?=
 =?us-ascii?Q?3ZCj+ItiFL1AcLOahmEH/ssVfLBiiQ1e0wQR3i4j+qfh0TN2KePd838Onao7?=
 =?us-ascii?Q?tvge9hqZy0Y6F5yY6F0IaNnRsKkC/1Gn/GSJOwgxFKxcHF08IuXD9rrGDbgz?=
 =?us-ascii?Q?S+pVLfST+hFlpIWvuaspQpodnaJL8vBjKwnMzuSKWwFrC4P7QPkldHY9fNsl?=
 =?us-ascii?Q?3plVocpq0UPSJHgTYZn0eh/LYR+R6uSxii/+ZLLF1AYfgxm3+7940zZaBY/5?=
 =?us-ascii?Q?EwLBU9xjuFsoWdQ18sp4SHFd/C+r6+bQzSu8OkGymq0YG2cfjJ+i3HZZFGJz?=
 =?us-ascii?Q?jqpJyRc5HdJmj9H9LHCHrjl0SjTF4gP86DXRUKY7BAGj5quzWns0XBz9RPiy?=
 =?us-ascii?Q?ygfFtzqvMwH0e4HfiHfi84Rk8b6A9JmV/s07TPsc3gSThI/bj2ZX21E6TV46?=
 =?us-ascii?Q?w1XL95qgf4q5TVzOdM0Zj9Uhm8yqAELEhSZv26sh7PYUtxFOGjnGt8CeQoZL?=
 =?us-ascii?Q?YwwOABBTOSEcOPq4RqaUme1+ARYOeCx3UdrP9HRPQMJ3cUDE/JRbLx6h0sV6?=
 =?us-ascii?Q?wfy+SVG9VIL/JTD5+UV3RiB/ZN1wSUtAg4ZG3Zfk97UNAYO5QrkGbah3p+uo?=
 =?us-ascii?Q?Cxlbcb9n3hqxoUxGbwwklC0HpQ5D4R5Ezxry58/shLtyq1jPFpJOYeeWcAMq?=
 =?us-ascii?Q?BNuHRWvcy1pQQKuSMe8Ek6q6spN4WEvTcPTjfrL7JqI/tokb5Tg2pZfb9Nyo?=
 =?us-ascii?Q?9dW4msXEiOGV1JAZf5L9ydcSJhUyphQVRx0EEOXxouLtwfkQkHK8jPORAQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 19:16:49.8608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 818e2748-6e28-4a95-4b6c-08dd7b88e847
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8161

In the review for iommu_copy_struct_to_user() helper, Matt pointed out that
a NULL pointer should be rejected prior to dereferencing it:
https://lore.kernel.org/all/86881827-8E2D-461C-BDA3-FA8FD14C343C@nvidia.com

And Alok pointed out a typo at the same time:
https://lore.kernel.org/all/480536af-6830-43ce-a327-adbd13dc3f1d@oracle.com

Since both issues were copied from iommu_copy_struct_from_user(), fix them
first in the current header.

Fixes: e9d36c07bb78 ("iommu: Add iommu_copy_struct_from_user helper")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ccce8a751e2a..3a8d35d41fda 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -440,10 +440,10 @@ static inline int __iommu_copy_struct_from_user(
 	void *dst_data, const struct iommu_user_data *src_data,
 	unsigned int data_type, size_t data_len, size_t min_len)
 {
-	if (src_data->type != data_type)
-		return -EINVAL;
 	if (WARN_ON(!dst_data || !src_data))
 		return -EINVAL;
+	if (src_data->type != data_type)
+		return -EINVAL;
 	if (src_data->len < min_len || data_len < src_data->len)
 		return -EINVAL;
 	return copy_struct_from_user(dst_data, data_len, src_data->uptr,
@@ -456,8 +456,8 @@ static inline int __iommu_copy_struct_from_user(
  *        include/uapi/linux/iommufd.h
  * @user_data: Pointer to a struct iommu_user_data for user space data info
  * @data_type: The data type of the @kdst. Must match with @user_data->type
- * @min_last: The last memember of the data structure @kdst points in the
- *            initial version.
+ * @min_last: The last member of the data structure @kdst points in the initial
+ *            version.
  * Return 0 for success, otherwise -error.
  */
 #define iommu_copy_struct_from_user(kdst, user_data, data_type, min_last) \
-- 
2.43.0


