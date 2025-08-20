Return-Path: <linux-kernel+bounces-778674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10721B2E8CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE06728780
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1EE2E1722;
	Wed, 20 Aug 2025 23:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ElWPpn5e"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFA32DE702
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733117; cv=fail; b=CgiTZXYsLzEJKDBHmqlTS5foAhcY5rTQp5ARwWKhnzrJaj1wLtBJzV/fkLYTJ7/VNg8/LM55KcYv9fNqrcSmBj8REx5FbmP5JZJ4Y7Ki+akCXyoZAg8xYftc7SgoEjlpzlbwAJYpoz3lV5SnFCkzqJE8mrP5QkygzOpCIaSVq6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733117; c=relaxed/simple;
	bh=iu/F/3hR6jjmebhdsweGwbiJQm3ycSXq2LB043ZSCz0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qyTSCSFs42LaM5W6LeV5lGPVIeznYfxepwYBP+mbMKFu4m933rTWRVSbhwb3iRRnM+5DSzbPYWGtWsOORKCaaBVbLe0pPSZL6ilNymgvONY04o/P736eJuDeioNKiUzcoub9FCqSJtkVsf9GqBVK3Rm52gyM6bn7dltpFieoMY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ElWPpn5e; arc=fail smtp.client-ip=40.107.100.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWSbIbWkUf03T0L3HKgPGG+Y/G6nGKgxqLTELhzHcNBl4DhYxmUvnOhag2BOBtrRHwU1y0s0Zw/rVRZjTUpJeDm05CF127TmF9iOkDSoIkb21+RQEuV2JxFRVlZc5Dew0cFrRTzDhwtDwmYXa628TRHiikVjn5zQ2zNWdpK7XlQ8xsEWBtjqwBmR5NjQ9TOwpQ67+TLbmeQ4wUqJp2WT3NzAg9+uX+1D/bBSpNKqMpcFr7w8COJRUT0/HorpUq7jyLF4CepP1VHLIB+Cy7gzq5L/Eu9dZQxBRTLl0rOBShLEWeEggV20s99opADvjWS2Cx9sORcFIdMfkksyZFbFWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LewNfBsezDWObxxfkZaRiLabV0piVJlH60NMCm2WO1w=;
 b=D9H4nyZJMBpOReBEC1vj1WZVToa80SJbsg0KOIaBXpG5X6Z5bckTT+DxdRBPcfxz7/Enjd43wFRIiurM3cVx/SbTrhTeAgt/EHdZSgK8Dl0ZhPmsytBHiOx/CLewRuMZsqXPePcbJuylrtFOo7EAnCrC06o9NDbDq/qJVmp5R00nCCHhJfI3sDmMpsmeXukPhnDmvZhOyfebORPxYBIfKXO9hGlYrqe8NaLzG7pUM5UwddRxbv4j1C/FNz/TMovJh1ZHO01YuV2qXL9wj09RDi53i3OOIF9fo+NxrDLY7Omg/A7DsQEcyBG7PSsTzbuLfVn+qHmyzy1sxLmBZK3gSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LewNfBsezDWObxxfkZaRiLabV0piVJlH60NMCm2WO1w=;
 b=ElWPpn5ezjy3/1tKvUA54IV2VJk2wDCzwrf0pVdceFI9ijGE7l2ZzQUyCxOlK7u/x6t4qPuXo7hzmzikuh0OJEVCNrTFGOI5JKXzl9WgjCtjRdRmT2UQXwiAvn/t5tRZ/P9HhqSBxXSAfCc0EssIqy9L/ZDC4qd3q8J6e8fINLI=
Received: from CH0PR13CA0036.namprd13.prod.outlook.com (2603:10b6:610:b2::11)
 by CY5PR12MB6178.namprd12.prod.outlook.com (2603:10b6:930:25::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 23:38:25 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::38) by CH0PR13CA0036.outlook.office365.com
 (2603:10b6:610:b2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Wed,
 20 Aug 2025 23:38:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 23:38:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 18:38:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 18:38:24 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 20 Aug 2025 18:38:23 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
	<jacek.lawrynowicz@linux.intel.com>, <dri-devel@lists.freedesktop.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
	<max.zhen@amd.com>, <sonal.santan@amd.com>, <mario.limonciello@amd.com>
Subject: [PATCH] Documentation: accel: amdxdna: Update compiler information
Date: Wed, 20 Aug 2025 16:38:17 -0700
Message-ID: <20250820233817.4050006-1-lizhi.hou@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|CY5PR12MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: bd58b1b6-6297-4c8a-dc01-08dde042a898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FQjd+QgdcpWdSYYUosUGi1b/pJGOz8r+CHeIWVI6eoFPqH36yFsrbLSDzPho?=
 =?us-ascii?Q?6k2EO2XGMgGKl0SbK9EAKVvEhpVC/KwB+xWmeq312YFGshEf1YruaxpJXC/k?=
 =?us-ascii?Q?o1gasrddv3gFpfrNOkzEuP6rsseCJfk20l9YY3ac7mfHrZDiuEwJ2SXt0Eq0?=
 =?us-ascii?Q?h9Ci6xLKXPzCUs3htPgTxrqOuTreGZOZUSxpvO0gamPNTfsfOQFNWbc0RfEJ?=
 =?us-ascii?Q?Lxj+EA1QhxlvpQUT9OenzJb9ZvxTm4pFcHfiUUbCIeP21qk4EzeY0OIIZX/2?=
 =?us-ascii?Q?UdK5VKyIq5dJU4a+KUjyGGBPhMF3RUh4hDSZ/fE/SXKU+14FtcAFuqbyX2Ta?=
 =?us-ascii?Q?OFsBX3ezqgAqo3BnmSTMAFE8Ci4UQlE+t/KGDWGlyVK6wxZByVIzTlnKVMaQ?=
 =?us-ascii?Q?Ac4tFhGQ463ROyy3W7OG+sbDF7tEqYSdhNffLdFwV+2ZrIQxPlzeRlm1//Ns?=
 =?us-ascii?Q?l3udPkVmreqxB2mPAcZZey2yzqMoDSaHlrWPx4j3F+WFV2abVI6ukmyWZ7Dy?=
 =?us-ascii?Q?WdIscpYCAeIdNZE7fOG3J3KTQvsOkraLROacG1gUUy9G0EOfr2O8jQa8BsTX?=
 =?us-ascii?Q?+J9k4ihYLy/n+Sq6zZXqspvHG06alvpVn4l34ArEEK3zj3zhCRq5ljvafiSB?=
 =?us-ascii?Q?iQ8S9iQs7B7gaR6Tcz3T2Hjnsg10o4RZCluS1Vq9EJlaHo8jvjFr0mLtoAOL?=
 =?us-ascii?Q?acPpFGlYpzl6kmmwFeL9M3+UoamExMlZaS9pWoDhrbdNavwXQHgTP9MqKSXW?=
 =?us-ascii?Q?XvKNgX1fPmcPs5b6qdxPm4ZWgbxxvV1bfACAll8SIttbn/d493MIu93Oki8n?=
 =?us-ascii?Q?P10SMtHaAItj6IyHV9/nHALyqNJdMwH4J679sPNOScuXEhAHsTY3GktH9ADx?=
 =?us-ascii?Q?1Z7ql081+9Yxuti2+8A1UeFRjqPJgU9E5DFuYqFRgrbo3mziJ9a2fRxu5b0T?=
 =?us-ascii?Q?nYEJTb/hDozEy/mpNSF+eIuKWI22Ahe0y84ezkMag43N+k53D+zc/Tu4UrP7?=
 =?us-ascii?Q?F4g/aWgx6IdKmDeDgf10jqRv6eCftMIrFkaVcWyZQ8vNWFsabx4SfCBe4Rx3?=
 =?us-ascii?Q?cf3iHKQcEjN1C7dde4jbpAEhMArH4yrCtTvWfIVp5c8Q+rE7FKI1m1vp2F4r?=
 =?us-ascii?Q?3WgtWqPZgXX9Gff2bFj2k0XzBZy3UGrEWDqJygg6BpAVumrbPcqdc1h5weHg?=
 =?us-ascii?Q?w8QhoTaJYwWm67MwNAqMS6Dj97ii+8h5WsVnLl9fXBlprW5F2R3GebcsnJrf?=
 =?us-ascii?Q?y0RiRjilY7prx03hHDZ4jkgBIECl3JArjT4fznZf4O+ts9L0xJ2z41v/Yrtk?=
 =?us-ascii?Q?49VbiWF2Ux5UUpB0iM38erYqaaH+d+RuYIrJcR1cuxLF9C9QTnwo1Lymzm5L?=
 =?us-ascii?Q?jCLtmnSp4mfWyIQgeP7Ci0NsxKmfvUTMwdAEPTU14TDsX3tyrvpLIXakg23w?=
 =?us-ascii?Q?PoHPrtzK5Syo7J7lsfYPf0Hkj9rBb4mfnEiW+V2RJ7BT8dmBTOzINOXcGgO1?=
 =?us-ascii?Q?kOYqxJU8LjjzMG4/zyT75syN/NHGlPH1o881ey/3WWs94BuWAWIRkn18Fg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 23:38:25.6992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd58b1b6-6297-4c8a-dc01-08dde042a898
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6178

The compiler information is outdated. Update it to the latest.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 Documentation/accel/amdxdna/amdnpu.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/accel/amdxdna/amdnpu.rst b/Documentation/accel/amdxdna/amdnpu.rst
index fbe0a7585345..42e54904f9a8 100644
--- a/Documentation/accel/amdxdna/amdnpu.rst
+++ b/Documentation/accel/amdxdna/amdnpu.rst
@@ -223,13 +223,13 @@ Userspace components
 Compiler
 --------
 
-Peano is an LLVM based open-source compiler for AMD XDNA Array compute tile
-available at:
+Peano is an LLVM based open-source single core compiler for AMD XDNA Array
+compute tile. Peano is available at:
 https://github.com/Xilinx/llvm-aie
 
-The open-source IREE compiler supports graph compilation of ML models for AMD
-NPU and uses Peano underneath. It is available at:
-https://github.com/nod-ai/iree-amd-aie
+IRON is an open-source array compiler for AMD XDNA Array based NPU which uses
+Peano underneath. IRON is available at:
+https://github.com/Xilinx/mlir-aie
 
 Usermode Driver (UMD)
 ---------------------
-- 
2.34.1


