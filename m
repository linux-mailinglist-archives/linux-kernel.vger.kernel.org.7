Return-Path: <linux-kernel+bounces-828792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CD7B9579C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF153A441C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C59212D7C;
	Tue, 23 Sep 2025 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dYz8SYQ2"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012067.outbound.protection.outlook.com [40.107.200.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2C726AEC;
	Tue, 23 Sep 2025 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624313; cv=fail; b=Uv+tkSfrBR5wcnvPkYUqF/6Xm5aoxMIk/YL3ZD8K8KxYs4l/4V1bE0DviTE+NMVMHij/QiMKC/15URi7j+rAVaR6R5mfrgcR8i3nAD3JMUDMLtoF95pAAIRsm4pO1jxFO/z+48ytcNxQlrXoYSK1V+B8ClutqvOejY03CC/R7b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624313; c=relaxed/simple;
	bh=wKmAH8TovPsVjhprgG/qRPo7n7FkKiZdwuW0cr10GUc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GS5lkapsuBx/wgnijt1PGWD1pSXAgQonWsAhXQ2Q/ebDYa4rFryo6zdAebDshe3GwwCEO1bp8+EyX62yXKxyvE1GtUynmP1YJIFJkIoHHStVQ2FND/N7QvUWY58lX9/mchdXploWYvPNnqtszyDSEgu4kVaAgZuM4ISa2q6h88k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dYz8SYQ2; arc=fail smtp.client-ip=40.107.200.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZhi3iDVttZv4GLbxIv2tH+rQJYiyQHYQnN3WYCyRNF2y1+vpVjYnSvFQVwhkgOMaZ+SaxKSjzw6F2DbBt858pfYN7dcfBDOCiuTAC3IzrWyn6vFr6c0eggzLX6lqDX1ARIVYmS2o8Ehagn//xfNbmtt4gwEL/4TEqMPh+aeZ1QsKcre+KIw2VdMZ6UP1CnXnkQhvAYV39oNgvcitzoyD57vpWDL5dP5gIkfbNqWf46Fg7F6t00AO06YVSfIsvoUshg+jO9uRJS6pSKC2PY5TY/YH0DDx8HLVr/hSDURwRt2WrImodpHSx5QgrIW+WxfGJfb0xX1mWX5JNvWvnh+yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEVhDkSVjT07EFizSfeylSAPRjJXSjJwCCOxiaZ1yfE=;
 b=R2UmifoIGo8jSEFgUBXfCZLel14t+carGEOvd1QT9bmNGY9Q8J5F/yrntdOr6jl7Q6UA8HaGoWbzCkzxntL5N42Zn0Mw910U61/Vawo3++/PiBUaPSqM+uFTPozU0VBIBfiYz00VyUvPWrLZ6CvaeeqzYfO4OfN9SmYUKHEiRhZMkwMtCVtlaSJckEwYpcmQKxzD7/nJL1OZcYZ5Y5uOAshme02hdQN85s/OuFYn2MvjuZiQqWtUGeMM2bjAxrda7f2AmvFx1KVnstGXXyL5HjrsRxlWRXy/CPTxaXbmWHI7ysVuKOJaWXmWrHg2TxypOkOpzPGbb5d2OkaWnE+/1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEVhDkSVjT07EFizSfeylSAPRjJXSjJwCCOxiaZ1yfE=;
 b=dYz8SYQ2yjx13SRwQSP9ZtNO4eFbcqhYO5ZB3fe4Vh4YcAwDPWYIICjW/SB2Ko3F/yFP60vNSqPzGLDLAVgWsa/ahpLlYGa4oENEX7TlrWzlfWr9vYojoImSvzh3wYtDBRB0+SxdVFQbfPxPKY/YaBnBSttE1lL6o42uyqBUYndziVzSetGO3Z57enVxAQ8PYoo7TAJZKzwVFl1wlP1pS1aAqSwNOW3AfPyLqf26UKhE7WPUIzRIfhqBkdlsuDBx8Rx+ExrO5R8c8EgrsFY04rtcF29WJ8vFCt7GL4JRrEsvGEEyqQ4yK/5mavaaMxlGfE3ehKwVTnaoeChAFCT42w==
Received: from BN0PR03CA0046.namprd03.prod.outlook.com (2603:10b6:408:e7::21)
 by SJ0PR12MB6901.namprd12.prod.outlook.com (2603:10b6:a03:47e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 10:45:07 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::3b) by BN0PR03CA0046.outlook.office365.com
 (2603:10b6:408:e7::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 10:45:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 10:45:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 23 Sep
 2025 03:44:59 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 23 Sep 2025 03:44:58 -0700
Received: from r-build-bsp-02.mtr.labs.mlnx (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 03:44:56 -0700
From: Ciju Rajan K <crajank@nvidia.com>
To: <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<tglx@linutronix.de>, <andriy.shevchenko@linux.intel.com>,
	<linux-kernel@vger.kernel.org>
CC: <christophe.jaillet@wanadoo.fr>, <platform-driver-x86@vger.kernel.org>,
	<vadimp@nvidia.com>, Ciju Rajan K <crajank@nvidia.com>
Subject: [PATCH platform-next v2 0/2] Support for handling interrupt storm
Date: Tue, 23 Sep 2025 13:44:50 +0300
Message-ID: <20250923104452.2407460-1-crajank@nvidia.com>
X-Mailer: git-send-email 2.47.2
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|SJ0PR12MB6901:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c93079b-e940-4ed9-975b-08ddfa8e4349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rpDJO0xk8g0aukXXkHe9QX0SEHfGkafrNolDT0rAgBujYGrdSF8yMkHjvGr9?=
 =?us-ascii?Q?oFqq1fJsV04K4sLS7h5+kz61hFqgfkWXJQK8k10YnCBxq2psvNsZ7t5YaToe?=
 =?us-ascii?Q?hAhyp3ehJoT6T2KYJJelBtd47nVnOkf5YC5xmbJTjBsJVXYCoWCniiPflHUS?=
 =?us-ascii?Q?CLCaY8lh+MoQMxrUv/2ltF0U26gBqP87MbAVIoChSuu0mJFAFMDUYCJvSnYT?=
 =?us-ascii?Q?CZ3fl9SapWfJu8x7iXq/K6x1KSxFtQAPPqqhNipriZHzS3vXOvzJalQPS5QG?=
 =?us-ascii?Q?UkPUGgya9EZreNJkL4cQLEWUQDdqaTjxr2i9x6QPhgsWU/4Kx5+niU9naJVx?=
 =?us-ascii?Q?ptclyVVD4gfQ0o8ImtMFuzuJkTd6SKIBVdASkiUIBr7ZiwdXWakaSwD9lRtv?=
 =?us-ascii?Q?8Uc+7gtqOIdxk5tftt+LBiSUP765PhtjZENkwyLKyhPpWcTlKsyjSIxthsEY?=
 =?us-ascii?Q?hzSWL2Veoh3JTaeJZ1DWAZmc3OI4ccwj9ODKjTPtn8Pv2iULEbNMwe/CbvjI?=
 =?us-ascii?Q?2FbnjH48/piOBG2ZFq8bFQKHBuHbfuSlxY+9AxmKCncnl1XDurUY4/nQjbBq?=
 =?us-ascii?Q?qNhVX6oRmNlboeMWS5XbC1ub1rrUQSrucI4Ttmj6IAHxYlXVFtPAe7sLStSU?=
 =?us-ascii?Q?CwwCAHnl7R4LlrfmFRtHc/ZXMGfKsesFQRScfDxqSGsSD8NjVKmPG0fuGcE5?=
 =?us-ascii?Q?rwnGawx3tKjh1zsoNkF14niX9NQgp89oL52RmlnlNUIlK9j+mnkpdTT6LNcc?=
 =?us-ascii?Q?zenfKy2rxLO8xxeNUTuI1Av4FJyPfnC2sENiLh0JuNluvzYz3RsahfZbc1a6?=
 =?us-ascii?Q?D8hdorLXTItuJx2qwmJ4R2AVLc/gaqeveH0uPjwI9qfq60NtWpc7CGiHcIzE?=
 =?us-ascii?Q?31pVdQpO9D/QE5OjFitI9NUE7j9hbIpJQXXf1ukX1XZ/n+5C2TKbnaJn9DUz?=
 =?us-ascii?Q?9RPtIKC/1h4ywMnXttx148ojY58SnffGxMgAoAYDqRyPw7EWLAI4gkg0a75W?=
 =?us-ascii?Q?qTBJv5APem6HSyhCl7AVK0W25uiDy+rRJh9BbAbWWPkOIwcbqyaHwPVz37QM?=
 =?us-ascii?Q?U5gitqTUU+G2fv4ARHo7mr82WsN+wXXGqmTowW5MQEaifm896vIQuizt9fvY?=
 =?us-ascii?Q?YuCHFfGzrMiJK9j012mHtbEUmhhLiX9TUq7JYDJTwAG14m7oGyZwWId1c6o6?=
 =?us-ascii?Q?NMIoFlphMJDyCBaYDFQXaf1WXGXN3V9PlEtPLVzdby8evvFoi8XY9mFbOXst?=
 =?us-ascii?Q?rzjjwM6hjKXQNuYJ2KAR5TmrOOPeHth2md5+zDSOf1Eiosrpnqw2C6PJqqAU?=
 =?us-ascii?Q?bj1r+B9+MaNIw9PnUC7eX2okOBid/NGWZ/ddHVWi5R14So8SxzxcBVxVQieF?=
 =?us-ascii?Q?VGsYXblG+TuqUbC5SnMVzyQtv1chdLE81DldVYcEtzwgIwbvYFiwyXNPl1H+?=
 =?us-ascii?Q?Mz0o9YQWi2+Xy1yFTfd4uMW/haAKb4A0Jkhpat63WK6o0zQtjqGtlx0qelei?=
 =?us-ascii?Q?7VcKDMl2Rgw5zyGPlAl0NdmzqxWOJN1vMHmX?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 10:45:07.5713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c93079b-e940-4ed9-975b-08ddfa8e4349
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6901

This patcheset contain:
 Patch #1 Add fields for interrupt storm handling
 Patch #2 Add support for handling interrupt storm

v0->v2

Comments pointed out by Ilpo:
- Renamed the macro MLXREG_HOTPLUG_WM_WINDOW to MLXREG_HOTPLUG_WM_WINDOW_MS to indicate milli seconds
- Removed the timestamp stored in wmark_high_ts and used jiffies directly
- Calculating the time window and storing it in the new variable wmark_window.
- Removed the variables wmark_low_ts and wmark_high_ts
- Used continue statement inside the time window check

Changes added by Ciju:
- Renamed variable wmark_low_cntr to wmark_cntr
- Fixed the time window to check for interrupt storm

Ciju Rajan K (2):
  platform_data/mlxreg: Add fields for interrupt storm handling
  platform/mellanox: mlxreg-hotplug: Add support for handling interrupt
    storm

 drivers/platform/mellanox/mlxreg-hotplug.c | 32 ++++++++++++++++++++--
 include/linux/platform_data/mlxreg.h       |  6 ++++
 2 files changed, 36 insertions(+), 2 deletions(-)

-- 
2.47.2


