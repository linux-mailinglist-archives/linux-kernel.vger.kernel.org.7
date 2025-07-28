Return-Path: <linux-kernel+bounces-747522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFCDB134C4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F211659A7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B964223324;
	Mon, 28 Jul 2025 06:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4PUoAOMb"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18865222568;
	Mon, 28 Jul 2025 06:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753683077; cv=fail; b=B2YolvhSSuWIX+dTjWi55saBQMnmMp/Hp6T7ehswa+S20eknss5/dC0oaGjlBDvdBA6x+9VEUnWqQOpK1fnhI3+OQ5JJV0rGbW8zKmvOehJX8CQZMkpcYFuuq5VZ82iu3JcAkxGemzbmMnJIym8qyKd85DxwfAcbcN43d290fO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753683077; c=relaxed/simple;
	bh=0wBscopFWaNqJ72dxmQ7lfKLIjOj5QEcVLSrH0QxycM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7cEgiepa2L6C05duzQUKtYFYDpOq+/CWxFJ0p+Ie17MkT1LOsUSrg7suXLbBtFIoAIyOLxdzMI9PeIzPKCR0kYo5zlClJVPOHtDRsNaZw6XrPUemGCcrZ8KQeooNBjJnaGkCelqpwf4Hxi4lqyZzVHv0wkbOPJiRG3lr1XZsGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4PUoAOMb; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EiEma8P8e1/wkQwNqf0w+6tUqwsYWpNGBxCF2MG4oIcShMkmXkQSF/LOaNMpZB/X+qkRO4TD6ZL+jd6xqz8TITwigBhbNz33jUMfdYd7Yy0Nf/GJoRPkedTrJIS1ulzPCrnp+5JmZBVkUCGip2fuaAt9FEF/VRLsrHDazVJKyaOZDJDjrSW8raQ1DJKCVHPfXqfm5FwuHBjEal/WHI6/sRBn4PpEt1ZG5HQO70qV+wsI4N8S/JydfF7/bZWfuyEjvLASo98kihxHzSRz8L7UuxB9rrqWP7Iw1O9xjxqWi5UwbrQAHmUnyK+EKwO/EEdtpsm+d4NpvPTvk03i1lOHTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLUFuJrHZHRKEqaOjwUF50LKHQLYVljr6j87UEEhUEA=;
 b=bfoof7bfLLAraA1xshn+yfnIw9b4oqVnnt+kCxm9t1HGehReZZ3xoH01pGS1NFxKUHM3O4+ES+ewAiWYBET8diKLyWtEKjBcgvqfgLu1n3krdDCloGN+feb9dFL4SfYvca0E9i9hqT/N6rmO/fBs5FEGhYn2+pifdJNqeCatnRfmfau3dlKqSNoLS0glUM6NiTgBiybhEzsf5N8JKsKwla9+veB1ZYSpd+iVXrmNRvUglErprde8+yOXLx+DStt+nBnbsWLJUHQ0ayRlPwKvI+G3/XEJ1TKNbgylYtYJHZAlrAygELVz6sIdabZC3K4wY5jZWEi7MEmHpC0QXReEUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLUFuJrHZHRKEqaOjwUF50LKHQLYVljr6j87UEEhUEA=;
 b=4PUoAOMbS71tQbSPe1IKE7RonXIUVetOS/4e1fQ96vzOaKUM2+bHHVyvBSUsw5bnQouvPwE8VuL4mD5fktTEp7M0wwm4leHFZT0WGo6gfkFm4ZKOxxsj1fgIJNlYJz+wuP5OPmTrqDKha0VieZs0V1nmrXaYoOEJI1q8DOkam0U=
Received: from MW4PR04CA0211.namprd04.prod.outlook.com (2603:10b6:303:87::6)
 by BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 06:11:11 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:303:87:cafe::ca) by MW4PR04CA0211.outlook.office365.com
 (2603:10b6:303:87::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.25 via Frontend Transport; Mon,
 28 Jul 2025 06:11:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Mon, 28 Jul 2025 06:11:10 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 01:11:05 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <arnd@arndb.de>, <linux@roeck-us.net>,
	<Anand.Umarji@amd.com>, Akshay Gupta <akshay.gupta@amd.com>, "Naveen Krishna
 Chatradhi" <naveenkrishna.chatradhi@amd.com>
Subject: [PATCH v1 3/5] dt-bindings: misc: Move amd,sbrmi.yaml from hwmon to misc
Date: Mon, 28 Jul 2025 06:10:31 +0000
Message-ID: <20250728061033.1604169-3-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250728061033.1604169-1-akshay.gupta@amd.com>
References: <20250728061033.1604169-1-akshay.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|BY5PR12MB4115:EE_
X-MS-Office365-Filtering-Correlation-Id: a378f0cd-2355-4092-0c71-08ddcd9d8c9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rxw7cZsBdJQF6aLtwMuTiFjNUtU1gQXp/ApXNyH0wWAk/Zcki+FGO1FiVOoG?=
 =?us-ascii?Q?nrmVEX0pU9lNtYSS8wmFm3OQL4w28enCvBkfSHVMQwTLiOMnNqRrkPDR27mu?=
 =?us-ascii?Q?zI+UheMWIZT4sWoZEyJGKNLAn2jc0Y1K55Cc9LzPL1SHcYvySWkE7aHBvViv?=
 =?us-ascii?Q?Of4tqe3PJwQ7O3oLnf2+H/cHy5aSFKF0imxkK4wgw2BoqjTNAm5l0QxxNvdY?=
 =?us-ascii?Q?8lTFsSMDR2tBcs9JT78PmFzDlWIYlYzoFBBvmRgZzTsv7Fsmf1f4SbVap1uj?=
 =?us-ascii?Q?MYaVPqx3YW3J3FkiHZcpXjitdEEzeA6N+/VD8KHU5aLg4qyhW4V4mM3RhrNZ?=
 =?us-ascii?Q?NKQLGxmp5RNIzsYgG4e/3PBVVNUwv28O73hulZ8d0m/fZ4Csa0zRBuYPnykB?=
 =?us-ascii?Q?qPH/oZJcmCBeW55e1Ah1tnSsLmEJxsiCkQnqv5nyMFnB0nEAlomV9BfFAXaM?=
 =?us-ascii?Q?dV1j5S3NKkNnVYJ295L4rL9rHR6pK0gfHRt3hf5nT+dKP0LOBwSoaHdbUBqt?=
 =?us-ascii?Q?7l2OYCyr+JKm7Y1C015lUEQD+sdi0TozM55MwfuzcYCEgAk+0R1APDH+RkXF?=
 =?us-ascii?Q?kawuYRIk+NcqvupFl417M3fevDNsX2+QSdgQU35KvM/fHMP+lcbat8mXY1Vy?=
 =?us-ascii?Q?ejcgEc43ivxxhNUgy1nC7NNBSWCqTCiop1JqdcBuM+e4NCMdqT9+2ynAP9b8?=
 =?us-ascii?Q?EnW9vFcNFx3XQO6Hg0R8mQB77MByCzNFmnSdYlbAvFB6X7HIsuRiFWVixHMt?=
 =?us-ascii?Q?FLVVoa0865c6wFJzbHxVfBCmZFTIxZzmYRj6oecrBOK8+Z4U310augNin2Ud?=
 =?us-ascii?Q?Fhn0tc7P42iiLQQh3zOuAg8T9LykKtswyAmoF0w7W0H42uYBByUVYJtCF03t?=
 =?us-ascii?Q?Tpj8vLTrkl5WerBqGeXXkLJ/JL0G1nVhgkFb99r2hU6cGh7JH5W+mrNpAlHJ?=
 =?us-ascii?Q?6tEjsfHSGIVyHzzlJDqn3feWyNP/vVcqzOQxLOKhGaamoGu068u3U2D4laB3?=
 =?us-ascii?Q?FJZIRzBEF+sTBtoaTbKBVshnJWMrmchaVL72uAoUmQ1GcVNSiP3EVqg3W460?=
 =?us-ascii?Q?EIQBtLjH8qTBMoli1esiXfEzjUTBPiG2iXUetvvWP8WBC02Zh9g1xBCxj8Nv?=
 =?us-ascii?Q?uAF5gn3Upr5Z59Jomw8uMO1j6gUvecE1CCWYK4jid0bxYetlIh6j2ZX9MldP?=
 =?us-ascii?Q?mft2w3YwkkTYnBw61N7YTGIFPKpizyrxGAOrMHC8yyTfdrpKB0YqWkHrGDWv?=
 =?us-ascii?Q?OfR3Vll/JLFYrIQOMTWg1gqOaX5C14LfJevJzRjL8u6srtSEXMgXD5X79dAM?=
 =?us-ascii?Q?mwrAzYVl8Z8VPbEqK6O0s+TL8namNkT8SA3NJQc9cZjlka0P6smCmFlWZ4LX?=
 =?us-ascii?Q?xTn/L4ub+ebxUpnMfB5USwbtgcxfuA5dZz1Q4HqKtDvjN4tJ36eiHXJIFfka?=
 =?us-ascii?Q?fJgSZb4pTYiO2vQkFPHGbufBpBJMkH2Y8NQECPaVo5SK0TywnIStLs0Ub+g2?=
 =?us-ascii?Q?MEtBgP0m4nMLZEnBBOX9m0DxEpOVBs0hWCxU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 06:11:10.7590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a378f0cd-2355-4092-0c71-08ddcd9d8c9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4115

- AMD SB-RMI patches are moved from drivers/hwmon to
  drivers/misc to support additional functionality.
  Move the related bindings documentation files to misc.

Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
---
 Documentation/devicetree/bindings/{hwmon => misc}/amd,sbrmi.yaml | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{hwmon => misc}/amd,sbrmi.yaml (100%)

diff --git a/Documentation/devicetree/bindings/hwmon/amd,sbrmi.yaml b/Documentation/devicetree/bindings/misc/amd,sbrmi.yaml
similarity index 100%
rename from Documentation/devicetree/bindings/hwmon/amd,sbrmi.yaml
rename to Documentation/devicetree/bindings/misc/amd,sbrmi.yaml
-- 
2.25.1


