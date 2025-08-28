Return-Path: <linux-kernel+bounces-789854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11485B39B91
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205E6189AFF7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D9D30EF8E;
	Thu, 28 Aug 2025 11:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ssnpcAOh"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC6830E0FF;
	Thu, 28 Aug 2025 11:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756380610; cv=fail; b=hz2C7RfmMiST+ifha1ISYJhmY7dee+/ZzfXT8HzIZnUNO0bWpkWDCros4ik06U3y6jjs9B1O83Cxy2rmHMcDXak5W+oMMXbNSLj0+vH5c+GmquYa7BPEcPl2ne9rz4yx4gEi4OuZHrQ5488daEF9NhbzS9XikABK6PskT+SYuC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756380610; c=relaxed/simple;
	bh=0jdMBwSWrSCEIO0vW3gRnSq1a1pWLlzovHcqyl15CbQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GX0KlZJ3SRjY+Nc/MiIfD2SPfAC1X3naqa+M6iwg04CoEqUMnjwebV1rsP86TniJusHR+Uh6F+btRWJQotIVGE3EGCfPf2SfBTnO2xuhFXCeQTuxc4g1GylLju9s+P+qWcStsZfM9v0pbdSq9OYGaZ16143ehCabqyYKcpY3DE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ssnpcAOh; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6S0SfU6elb69e1ExQkpay7knrdvTtJBaz0xKzuWIFexrST7WIPlI+p3LX9ETmLcu8YWzeg1Zk8KKJG1GmbTX+/nbY4hv6Y37wrHo+Fhreuc6Ezs4nEGEioqmNsrn2NxAaNrTaLSHMRVlI/4SWIQaucX6+/zYrlRsFDYleAw4YwTDOJZEC9dsVJ8cKcb8XxbILDrlmYouwKMBXHR3sjzHhCsItzemrSe6kNxGSnUIKmldC+ZfTb2mTYE35YGAiajd/KL24Bn2b+h2p0NPgQKVW3DC2qerImCW4RfQezNViQxrNWGusiV5ZDHXhecDfajk3LxcpcAP/7c8UO7eg1nfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0idRWNbm8foNQstYiSLmb/wjD1Rf6tdvhRn44mwxDE=;
 b=xi9rQY1E7jOl7adh1+RLsVQBslQdHJewmwbJyki6saPVg4r3lO6iqqFjn4wC1iU/kHHsVXiOtBWku/6CtnPPzVTGh7MD4NVwiZH8LHZTT9JLwlwzgSPWrLp1chyYqZkTKaQA8x0+7WLzvBu/ZwoCRb2yb4jReVI9supWl/mITnnmcGPGlHUCJMesfLd/pKtNMIdaqHH610z8Qm0+qQlUoHuNEvqD55oMOflGLMzo/akEaeXQf92Q5CoM5URbcKVL0DuKtAQMy+hR7+oRTHJZED1tHKK9XXIB7MA495NTMRiI0i58CyuUmBno4OC72aLHMCm1UgPO7oLiu/mI+Rjwxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0idRWNbm8foNQstYiSLmb/wjD1Rf6tdvhRn44mwxDE=;
 b=ssnpcAOhhK9ffsVsLO7Q9beGnk5L0j8dFOGOVRiazLdnGrcLA3M3YD8sZN6QRsxwCm3dN66U4QxJ6R2dsb8kIA91jDPEjZhH36yHxj5DtMOX+IQBYhIY7pKM4jp9C9GxgnlkvYpm/4Xqom5ZUZdx4dnDl7AnXXauRWFKAJ7V+Mc=
Received: from CH5P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::11)
 by BY5PR12MB4228.namprd12.prod.outlook.com (2603:10b6:a03:20b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.21; Thu, 28 Aug
 2025 11:30:01 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::43) by CH5P221CA0020.outlook.office365.com
 (2603:10b6:610:1f2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.18 via Frontend Transport; Thu,
 28 Aug 2025 11:30:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 11:30:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 06:29:59 -0500
Received: from xhdctallapa40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 28 Aug 2025 06:29:57 -0500
From: Srikanth Chary Chennoju <srikanth.chary-chennoju@amd.com>
To: <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>,
	<m.grzeschik@pengutronix.de>, <Chris.Wulff@biamp.com>, <tiwai@suse.de>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<punnaiah.choudary.kalluri@amd.com>, Srikanth Chary Chennoju
	<srikanth.chary-chennoju@amd.com>
Subject: [PATCH v2 1/3] usb:gadget:zero: support for super speed plus
Date: Thu, 28 Aug 2025 16:59:42 +0530
Message-ID: <20250828112944.2042343-2-srikanth.chary-chennoju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250828112944.2042343-1-srikanth.chary-chennoju@amd.com>
References: <20250828112944.2042343-1-srikanth.chary-chennoju@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: srikanth.chary-chennoju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|BY5PR12MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f1b32ac-fe25-401b-b8da-08dde6263a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rON4EYc+AKcqCHDwh+JP9YwHpKbNykYZRZlJq3+RMBuQPw7ooQ6hQOTIHu1Q?=
 =?us-ascii?Q?NtUwdE52DFMMpKG46f9JpxfNyLes7jpcwuf7F+SXDgTn9xNo12hPXUmXpUqv?=
 =?us-ascii?Q?iNBBbXyqaVxNmEjVvUpCA1S/2AB6TnF5QlA3FdPynismsgfO9HmPsaGLNDiE?=
 =?us-ascii?Q?3LbAJx9EtJ6357YSysMhfeBOtiywco0Vd87BgFhL31pKRs+/z6f7Ku/eWfAT?=
 =?us-ascii?Q?jHqO6JEes9fzbTYMQ+HdFiWzm3CC888nPsD1igqzpvTTqmk6FgOZfVnNJMHU?=
 =?us-ascii?Q?UVddAYgHnQxRpOaGliHDCG2+6GGmskrB308Vdatl7oufekeVOpmqPQ4/cjJ2?=
 =?us-ascii?Q?dHhecUPDXOZ6x5EbyDMeRbmeNNuoWEePXaTAavPHbThnM6gD5SNQ1MG/fHl1?=
 =?us-ascii?Q?ZSAuZr+RjQgIA+KDLJXukyehel02MgAFW8dj06kr+JtcYT/BtdzQrpqYVk1Z?=
 =?us-ascii?Q?a8lTAa8oGtx9xEKA6fwmlbE0NtMHu3zz2pNrSdBWpTc5zrkhRhSdezC5Rf2D?=
 =?us-ascii?Q?japPHdoiNAQ0/zhVEnQjy56cBiV0AgT1Edj8h9P27Cmuvb1kUWrm+nDZSPyZ?=
 =?us-ascii?Q?56jchl1qmKe7fHYm3Psf7i1exGpxLZwysRQ1kuXzrqoFul5VZ9jdaEVxdBt7?=
 =?us-ascii?Q?sSnMTln/uxf4XgfqnwtpHz4ALHUCBp0lkmbhR84Jc8vAzISwvcUrrH/O8UOt?=
 =?us-ascii?Q?tfR1eqrLEyRKR48QqqOXe7xr9p0jb7awUDt22KKaXSR8qIa0CZWGVaP4eceA?=
 =?us-ascii?Q?tCxXHCOYqLxpmv33sFHSTg8yvtFjOOFkLL6UcAqcGt4Gtgohzdj5KKJwgYOq?=
 =?us-ascii?Q?UjeZBjeaZIY5+4m2Ha4q9Hqvobr7FHAX33Jd8W9zgBlfMkwkcjrK14YvoiCI?=
 =?us-ascii?Q?LdxXvNn2A8VB98wLJP9w8BmDWZwExmLbZ1fa7tjejwgFydqv3wEJpIdXWko0?=
 =?us-ascii?Q?WFhuCxFLPHg/ZPQnOO70bVYgaxsXnSyc2qTFOc9N8O4bfx72fYJh6FseicHD?=
 =?us-ascii?Q?vbBCtf1JKI+MUDtQiIcHRCUXtd8rzdrmdrWzcFlNabh9YyieN7kPgQi6VedG?=
 =?us-ascii?Q?JPRBxHXoLj7TKkypj9lVjsGRgBvHFMimJx6eLgeF6+L9/xevgUiTf52JfVpd?=
 =?us-ascii?Q?DHPfnUvLEsQTo8Lw3VaXMWoyV5AJvpro+ExI21A/KIWppivKQ4wDftlrYv8F?=
 =?us-ascii?Q?htUGzHBXHhxw6J1c0oU+RNRJt9XE8b6CrThiHOiHWl0CHBZmYFQm0YadjBLv?=
 =?us-ascii?Q?nlBCQCh/y2M5myh4UrBiDu14WXGW6Nor+kweDArnyNGI1YYxCs9r96xp2eqn?=
 =?us-ascii?Q?NA9xzwP11Y0DgkjkJo+J2UqUqc9c9FW/cgrOwxx82I/ZTkTKC3KlaOtgYqSn?=
 =?us-ascii?Q?FGBqNDgcIq3T5eEY1v6PAlQi/CE0hsFmWz0VB+wTg/Z6kQYdp2fjG2t/TeqK?=
 =?us-ascii?Q?jROtNkBXVUklP0u5BvXLjjrsPLpnD1CplbCTC5wlyGeC7a1ZFqpXlA/nHeN+?=
 =?us-ascii?Q?Wi01Sv87pWFsDpCUBYSctPgQkwJ9CExhy2S8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:30:01.4364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1b32ac-fe25-401b-b8da-08dde6263a25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4228

This patch is applicable for Bulk as well as Isochronous transfers.

Signed-off-by: Srikanth Chary Chennoju <srikanth.chary-chennoju@amd.com>
---
 drivers/usb/gadget/legacy/zero.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/legacy/zero.c b/drivers/usb/gadget/legacy/zero.c
index a05785bdeb30..0cfb7dec22e2 100644
--- a/drivers/usb/gadget/legacy/zero.c
+++ b/drivers/usb/gadget/legacy/zero.c
@@ -415,7 +415,7 @@ static struct usb_composite_driver zero_driver = {
 	.name		= "zero",
 	.dev		= &device_desc,
 	.strings	= dev_strings,
-	.max_speed	= USB_SPEED_SUPER,
+	.max_speed	= USB_SPEED_SUPER_PLUS,
 	.bind		= zero_bind,
 	.unbind		= zero_unbind,
 	.suspend	= zero_suspend,
-- 
2.25.1


