Return-Path: <linux-kernel+bounces-770896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66782B2801A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4647AE5510
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC6C301004;
	Fri, 15 Aug 2025 12:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="iTGAFh2i"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012065.outbound.protection.outlook.com [52.101.126.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F522C3264
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755261772; cv=fail; b=HC+dfcg7Jcnxm2WnTvJlxF7j5G4ExLc3ou4j2rIfPMRnezDvJJ1AK+Y2HcUyvewsJuivUyaXh/NZvKKLLQ4vxTOm7nTVASbxK3qtAfEQ8N9+ZtQiiYnC/9LlwM5LlXw4e8xqSLcNaAkQO9Q1A/cHgdbN/7p4ngChO1/746i1xbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755261772; c=relaxed/simple;
	bh=QYz86UOipvouCF3BIuQ+ZTSr3+O3n4K/mVmQpanwvwc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OPOGfy+C49eoP7EIwxHEI1CBjhE7Gn3GmwroK7OU88RJq1yz7aTnR/EOuhQP9ECl6i/xnlWh8AZa5O4aiev1Q+C36iTd/PQE1nSRz5V+ct719GVCidauxiGZqdofJPV446RhUPaBYnmMuwpY5dxaqEYxarxbFhoeOfZQ4y6FYj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=iTGAFh2i; arc=fail smtp.client-ip=52.101.126.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2vfOKvJ89TfxvOApGO21OCFlOcwRE35Zn31NHIbTS06aKIqa5/ImjCn0IjgEouwyip4WpRsC4p3OLSJqPwIJM1l0H6c3xVuZ9eYxrk7dOqdKcCnahVwV2s82c5zHFBs8ljhccAeiC2urIvI4E14WAhiDl5dD/8nq2oq1ad3spshW1U0SCRqs0ax5GFMceGkHu3Vqclee2uinMcA03FTjiuSqy7SM8I3dHMtG9chN236eszCUUZmrx0dT3xQsPtJdWLCZWsGrBAwQV6tTrnGlj84wL3THCZaKLL21Jw/NYeE/c868VmVjkRZ/zhceLtP+LriL0Hyr8EhL7qUSvjzDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ja1YEBMAvgS/lIywTBw9ku1zlzCfl+Q08A3f/LaWrGw=;
 b=ShX8xKFZzwfIXgTeCJKSQN+FVwzaVI33wS1tKdsdP9WE42mMFR8CPcgESDH/7Lfomx/3o61QocAGypLuMKawI7AZGQqtmZmRwpamSPLfu+AGyiLBtoNj+XCW5yuG0ZGegPRqg0erAse9HvJvSfz366t1EnAL+kTqc10KoeMklg6Mt7DO0e5zONeCRYnE3oq5FPyLE49nCs6vY8MuMOohZhXBur3ExugHxRMRvTY5aKOc6sXAbJZo9VfGU/A/zkon+RVSVXRqYLivjPsMW4iey9VjmxetddmyqIO9GATxmWmv5UxbxZWK7elt81/qA1jJkk5l6uWVkzWSwaPUriwMRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ja1YEBMAvgS/lIywTBw9ku1zlzCfl+Q08A3f/LaWrGw=;
 b=iTGAFh2iffjYOymwemxOzSAbIdep9htdbUf0d4xVQUe+///Dt6tev2XbcIJl/YW5StJnJy0+rJth/3zru0/yZNfDndlpYDQHDqwP8CqaPsHj1o/epm/5vpUZQZavsTiX2pV3QUY6b5SsGOV+8pRSMpxa25mY2zdRCnjTlM0xUSyiY0zEWXcb+/cdaF/RqYllvPzMTOBD5VCcSP15H8/mPxaXphs4vcoBsziP7BFDoJBT5unj5VJWfTzOPUuvuP+T0qmy+HXCjQPJpmAj+tnnkalGyDlodLLfQ9v7cRFi9ZHnpCwmF/GyhidAwFaYFXzdk/FEoFRMfzW2ELajFBBDVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by SEYPR06MB6508.apcprd06.prod.outlook.com (2603:1096:101:172::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 12:42:45 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 12:42:45 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net (open list:F2FS FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] f2fs: Use device_alloc_policy to control write priority in multi-device setups
Date: Fri, 15 Aug 2025 20:42:25 +0800
Message-Id: <20250815124226.391583-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|SEYPR06MB6508:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b464d3-d3b8-4232-2f28-08dddbf93b8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mmiBnAr0mDx1FZDi4sgZnCDKd/gBfgFY8K/OxnszmuJ4pivuKd4MNsx9BwJK?=
 =?us-ascii?Q?vVlq1pTPxoVca47vPXD9Oj91kdpNpjiW4b3cFF+JwSshUgjJv1SGSZQwRwzr?=
 =?us-ascii?Q?TSpUDGJQjuI8yzQ82ozCJAk8kpVY6Bqb96EwV4XJ0ayG8etwtzPwnGQc4at0?=
 =?us-ascii?Q?Y/ijCz1KzEtBywgfT9UPcBtilpHTnBVuqRVkCuAJ9jb57lSlwDIY/rEs6WKH?=
 =?us-ascii?Q?SL40QqfAD8XzNuysGvAGsPWRA8AghYOJrAj6t4VddJXXPvNd3sWGjLUhf7x2?=
 =?us-ascii?Q?f4bfsTHCB0noydH5XXZ1o9LWtmMdg4/yG1/OTshk7x7WLe5WONhbgnIGWqYe?=
 =?us-ascii?Q?jwRgcU+mnejSoW+RbFkOVcCxHVjmmc/qDdICFWWKyE6pPZ4L7LsZzU3df8mO?=
 =?us-ascii?Q?5YjjnfdX76+R27I9aqUxyXuhT42mnT/qezjttOAY0o53a1YCYdco8RuUz32T?=
 =?us-ascii?Q?08/zlGzIVqz3YVex7lkC2NDkm3v7F9PVAkWsXvJEGFg5Mh29Wcb1qPBJgh5l?=
 =?us-ascii?Q?dqZ7yzYdkc+1ffzAaK3gcNdnkd+ps2m40Up43gOmfJMlOTtojgRY79hePPAa?=
 =?us-ascii?Q?QlO+mHwAbKt349rYrZwXWxON1U5woSyKkKx7eDI3LXmliha5HOpUpxbAEkix?=
 =?us-ascii?Q?oZ5Y4/6NdsODBhJu3qIg/92+0ghWnbkPEa7JzXR7fq9lsUyKoG3aQ9H06Pnc?=
 =?us-ascii?Q?68+AKmHqk8RUHu7KyUfocpt11FzRe7l/orAPelzZ08poelQ1vqHniIglQcKS?=
 =?us-ascii?Q?w/3mcH2+q3uO9ZjSLwnnEMyr8Z5hTENOrR0hEAgS/3JLCTIKlkjG9HXmr26L?=
 =?us-ascii?Q?C7DlhHHN02XJl3OD8TroRFN1bEchF4j4+0Lzh2rekbpm9oR6qGZODJbcdHBp?=
 =?us-ascii?Q?jniVdqpJkDLdqyTDqXeTtOeiaxZGhCO1q4tV3rCARARVfn98q1BWtLscxbR7?=
 =?us-ascii?Q?LvZhvMN6fHM9IaAxidu44ynYPrtu5+ZWwOF5O4vqQQDe1A/MHqj/1nrTSFGn?=
 =?us-ascii?Q?R/KPMsNwEAnc0g1Mo8dLV5z3Oa4GYw9UlVhYYoU9VZyt3Y2DqzEiqn3V1I3h?=
 =?us-ascii?Q?Dfmb0UswdLxh8pZxhH7lJF0uoStUy0GUIDLQIfgaRleG88dxQSk5ebqL6VcR?=
 =?us-ascii?Q?EmatQoqAG09RdzJ5wsF4E6VULLzdgWQ0Km9xvs+idobBPbYEqcWLUsu7Fha2?=
 =?us-ascii?Q?xDepLkiQmkvcErQDOE7tuL3hOasVu6pxuuk6Hp+vKA05pTQI9cKnXzHfQS85?=
 =?us-ascii?Q?3NitdWxi8xD06uqO8WkibrQdRVHEsUyAZY+wwqOI/5easV0ad5h70jPQt4iE?=
 =?us-ascii?Q?DMc3Y1VYyt50eyAdg1P/yAv3QVPcNj4NRoufRFqqO4+JcemGU3ixnfcAS+io?=
 =?us-ascii?Q?U95tyeg4dcZMSvBEuEC5MUbgM1yRoXt/5/PimIGTdGM8BUyzDgO2Fje5nnM0?=
 =?us-ascii?Q?Wfco6HOIQKogiJN/I3ZGZTMyqvZEVDY8REmnqQkfTWgPE8yYu4ECng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T6CC0y9Z2Sl/xN43yz+inNPrOhfJrP9bXJ5cdKQTFecFwSFOZ5tjTINJBrrM?=
 =?us-ascii?Q?geYpBGetQ4u37jDOEDpKPerxy/ONd4Gb+ST+NtZWAC0eWlUGRM+Wslp5gRXB?=
 =?us-ascii?Q?J/+OGJZOX1S2X85T+AAUfGLAUUdag241mMynY++iuwKC7NXwpvds2UNCZOBz?=
 =?us-ascii?Q?sleTUmzLJ8jrY96FCUj3JVlxwvNjlv+SY3c+5l9I2YcYZv3nC9Vh/O56piA1?=
 =?us-ascii?Q?kMqG0df1mXKe39ULm7Wbc8SBZT++TwYMFx09fXFyc6JfvSI55B8ZFGQJPLJp?=
 =?us-ascii?Q?d3o+Norgii+pHFopXzyFvDc5TpbMtRTMlEqo8J4Gge+etrS3Z0XUt9QxGPur?=
 =?us-ascii?Q?udiBWfifujX1G4KzHCDa/LEkFNtaysNFdecdVSyHgVdvAA/iY3URnw0SvuVH?=
 =?us-ascii?Q?B6wxK34d2p8hJun9i7hgiGtSvvx5vmqCjmgxWeGVRJ9WuTGC2qUhELSudH9C?=
 =?us-ascii?Q?ECYlQaKnpF3FoT7VYD0Kq6stgxobAyGHBrezHlBsEk2Gx/pimnrVLIkEbH0Y?=
 =?us-ascii?Q?UQKqebajW6uyotUHCtcgtWnV2Q4LBFNG5Ql+7AnT/uo9QdLrUOeLwdO7WkrK?=
 =?us-ascii?Q?h1Z4kkSfoyjlRA/8uy+Eoxrs6xfTLcjeH23JmSMCBcee8pbMQy10fOIpkIi6?=
 =?us-ascii?Q?DxA5whmHFx8Yhx+wgX7juaNeQ27XHbTJt6Ezczg6NoVa9jhmURDTfwIj3ust?=
 =?us-ascii?Q?4BSippqRvqQJvP/yFWXLOowqLEuLTk2Ij5A9vS/uce6K3xSH2yvjjyiZp1tY?=
 =?us-ascii?Q?dB6n6RS/4FLXowjrB4DGDibloR7aKzVJwXeWk5Flfgon9GfJs8OeFd9pg2gx?=
 =?us-ascii?Q?8XDnbyIvAuwKxFR4iXmHrszGDThiGRHbiX+vP1LEsRawm7+Uh6ZOLpyEznek?=
 =?us-ascii?Q?RmX/501bc67wWUpKfaRySjOm8erqzsyyRsgQYtz17dd7vEm41H+ABLv43u8B?=
 =?us-ascii?Q?hSzHrDgZYn8lMAqk6+SonUzjJC6YjsdOyR2wBIpfqxTL4n5lwzDfNKjV76JU?=
 =?us-ascii?Q?MrgY3ju3cQ1K/KxSvdyUQd/X9hsXfNwP6zcOkzvx03X186REzM7EFYWqTORv?=
 =?us-ascii?Q?XeIYxUDgO8q5rG93IaW0kbuHtY4gSTqHfHWgSxh4Kd8TYIvSRSCQcHDR0Axg?=
 =?us-ascii?Q?L//zZwqpyz17GtmirUyP6+fQylOzuHddWwyLPwpRBPwnhNIi6OPS8thUx4r5?=
 =?us-ascii?Q?faT4KU/xIVrD6qK1I320eKRpAzO11C0Q5pWX2AwrLAKZH7i8fQ/BkoGkD129?=
 =?us-ascii?Q?kDLWw7RQPlPD965mzVyGjcFv33cEzrRUZzsOxNxnxjngENf8XW2ukUTD0iXW?=
 =?us-ascii?Q?rO9o5JZyfg+j4u25qmIRVlH0U0V+guVkSpRf+//NSk3ajJMCuxvnBp7HJ/tw?=
 =?us-ascii?Q?S0oMsHal4M/LrFkjiSIX1KxUbcH/Y70CbQF8goCz8sJ/uD4NrIK6ufI5LO69?=
 =?us-ascii?Q?XCMqtLch+/SzyoO5YthtHNXk0cO1+9OGToefFM8BB6Fykdk4Dv3NYc8SXbuL?=
 =?us-ascii?Q?oiia7KJ+EdRgZqhmuYnM1DgEDkjsXQTCArBchB15uM7I0tFvw4q4uGG9RYsq?=
 =?us-ascii?Q?3nD9lyznuJRApTyPKh9dwC2aTsRl2BEpxnPSG8+t?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b464d3-d3b8-4232-2f28-08dddbf93b8d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 12:42:45.0937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hpz2KQpC5iv+n+p7GnBrHPv2ibG89JCHxqNXNHy1qlFQoc2uKva5D9V5HFQXXbSaQBd+dmY8CQsRiCw2vw+Zdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6508

Introduces two new sys nodes: device_border_line and device_alloc_policy.
The device_border_line identifies the boundary between devices, measured
in sections; it defaults to the end of the device for single storage
setups, and the end of the first device for multiple storage setups. The
device_alloc_policy determines the write strategy, with a default value of
0 for normal sequential write strategy. A value of 1 prioritizes writes
before the device_border_line, while a value of 2 prioritizes writes after
it.

This strategy addresses the issue where, despite F2FS supporting multiple
devices, SOC vendors lack multi-device support (currently only supporting
zoned devices). As a workaround, multiple storage devices are mapped to a
single dm device. Both this workaround and the F2FS multi-device solution
may require prioritizing writing to certain devices, such as a device with
better performance or when switching is needed due to performance
degradation near a device's end. For scenarios with more than two devices,
sort them at mount time to utilize this feature.

This patch covers both the F2FS multi-device solution and the single dm
device mapping for multiple devices. Additionally, there is functional
overlap with blkzone_alloc_policy. Future consideration might involve
integrating blkzone_alloc_policy into device_alloc_policy, as zoned devices
are a special case of multi-device setups.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 22 ++++++++++++++++++++++
 fs/f2fs/f2fs.h                          |  8 ++++++++
 fs/f2fs/gc.c                            |  5 +++++
 fs/f2fs/segment.c                       | 17 ++++++++++++++++-
 fs/f2fs/super.c                         |  4 ++++
 fs/f2fs/sysfs.c                         | 18 ++++++++++++++++++
 6 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index bc0e7fefc39d..2ef3ba36a775 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -883,3 +883,25 @@ Date:		June 2025
 Contact:	"Daeho Jeong" <daehojeong@google.com>
 Description:	Control GC algorithm for boost GC. 0: cost benefit, 1: greedy
 		Default: 1
+
+What:		/sys/fs/f2fs/<disk>/device_border_line
+Date:		August 2025
+Contact:	"Liao Yuanhong" <liaoyuanhong@vivo.com>
+Description:	Indicates the border line between the first device and others in amulti-devices
+		setup. It defaults to the end of the first device in sections. For a single storage
+		device, it defaults to the total number of sections. It can be manually set to match
+		scenarios where multi-devices are mapped to the same dm device.
+
+What:		/sys/fs/f2fs/<disk>/device_alloc_policy
+Date:		August 2025
+Contact:	"Liao Yuanhong" <liaoyuanhong@vivo.com>
+Description:	Controls write priority in multi-device setups. A value of 0 means normal writing.
+		A value of 1 prioritizes writing to devices before the device_border_line. A value of 2
+		prioritizes writing to devices after the device_border_line. The default is 0.
+
+		=======================  ======================================================
+		value					 description
+		device_alloc_policy = 0  Normal writing
+		device_alloc_policy = 1  Prioritize writing to device before device_border_line
+		device_alloc_policy = 2  Prioritize writing to device after device_border_line
+		======================== ======================================================
\ No newline at end of file
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 46be7560548c..4af5f2ad0b2b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -155,6 +155,12 @@ enum blkzone_allocation_policy {
 	BLKZONE_ALLOC_PRIOR_CONV,	/* Prioritize writing to conventional zones */
 };
 
+enum device_allocation_policy {
+	DEVICE_ALLOC_PRIOR_NORMAL,
+	DEVICE_ALLOC_PRIOR_FRONT,
+	DEVICE_ALLOC_PRIOR_BACK,
+};
+
 /*
  * An implementation of an rwsem that is explicitly unfair to readers. This
  * prevents priority inversion when a low-priority reader acquires the read lock
@@ -1804,6 +1810,8 @@ struct f2fs_sb_info {
 	spinlock_t dev_lock;			/* protect dirty_device */
 	bool aligned_blksize;			/* all devices has the same logical blksize */
 	unsigned int first_seq_zone_segno;	/* first segno in sequential zone */
+	unsigned int device_border_line;	/* the boundary position between devices */
+	unsigned int device_alloc_policy;	/* determine the device writing priority */
 
 	/* For write statistics */
 	u64 sectors_written_start;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 098e9f71421e..5fd5cc3c70b3 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2182,6 +2182,8 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
 	SM_I(sbi)->segment_count = (int)SM_I(sbi)->segment_count + segs;
 	MAIN_SEGS(sbi) = (int)MAIN_SEGS(sbi) + segs;
 	MAIN_SECS(sbi) += secs;
+	if (sbi->device_border_line > MAIN_SECS(sbi))
+		sbi->device_border_line = MAIN_SECS(sbi);
 	FREE_I(sbi)->free_sections = (int)FREE_I(sbi)->free_sections + secs;
 	FREE_I(sbi)->free_segments = (int)FREE_I(sbi)->free_segments + segs;
 	F2FS_CKPT(sbi)->user_block_count = cpu_to_le64(user_block_count + blks);
@@ -2189,6 +2191,9 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
 	if (f2fs_is_multi_device(sbi)) {
 		int last_dev = sbi->s_ndevs - 1;
 
+		sbi->device_border_line = FDEV(0).total_segments /
+					SEGS_PER_SEC(sbi);
+
 		FDEV(last_dev).total_segments =
 				(int)FDEV(last_dev).total_segments + segs;
 		FDEV(last_dev).end_blk =
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index cc82d42ef14c..0b0427c7995a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2807,6 +2807,10 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
 	}
 #endif
 
+	if (sbi->device_alloc_policy == DEVICE_ALLOC_PRIOR_BACK &&
+		hint < sbi->device_border_line)
+		hint = sbi->device_border_line;
+
 find_other_zone:
 	secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
 
@@ -2828,13 +2832,24 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
 #endif
 
 	if (secno >= MAIN_SECS(sbi)) {
-		secno = find_first_zero_bit(free_i->free_secmap,
+		if (sbi->device_alloc_policy == DEVICE_ALLOC_PRIOR_BACK) {
+			secno = find_next_zero_bit(free_i->free_secmap,
+							MAIN_SECS(sbi), sbi->device_border_line);
+			if (secno >= MAIN_SECS(sbi))
+				secno = find_first_zero_bit(free_i->free_secmap,
+								MAIN_SECS(sbi));
+		} else
+			secno = find_first_zero_bit(free_i->free_secmap,
 							MAIN_SECS(sbi));
 		if (secno >= MAIN_SECS(sbi)) {
 			ret = -ENOSPC;
 			f2fs_bug_on(sbi, !pinning);
 			goto out_unlock;
 		}
+	} else if (sbi->device_alloc_policy == DEVICE_ALLOC_PRIOR_FRONT &&
+				secno >= sbi->device_border_line) {
+		secno = find_first_zero_bit(free_i->free_secmap,
+							MAIN_SECS(sbi));
 	}
 	segno = GET_SEG_FROM_SEC(sbi, secno);
 	zoneno = GET_ZONE_FROM_SEC(sbi, secno);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e16c4e2830c2..d3de907d8aaa 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3860,6 +3860,7 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 	segs_per_sec = le32_to_cpu(raw_super->segs_per_sec);
 	secs_per_zone = le32_to_cpu(raw_super->secs_per_zone);
 	total_sections = le32_to_cpu(raw_super->section_count);
+	sbi->device_border_line = total_sections;
 
 	/* blocks_per_seg should be 512, given the above check */
 	blocks_per_seg = BIT(le32_to_cpu(raw_super->log_blocks_per_seg));
@@ -4629,6 +4630,7 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 
 	logical_blksize = bdev_logical_block_size(sbi->sb->s_bdev);
 	sbi->aligned_blksize = true;
+	sbi->device_alloc_policy = DEVICE_ALLOC_PRIOR_NORMAL;
 #ifdef CONFIG_BLK_DEV_ZONED
 	sbi->max_open_zones = UINT_MAX;
 	sbi->blkzone_alloc_policy = BLKZONE_ALLOC_PRIOR_SEQ;
@@ -4659,6 +4661,8 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 					SEGS_TO_BLKS(sbi,
 					FDEV(i).total_segments) - 1 +
 					le32_to_cpu(raw_super->segment0_blkaddr);
+				sbi->device_border_line = FDEV(i).total_segments /
+							SEGS_PER_SEC(sbi);
 			} else {
 				FDEV(i).start_blk = FDEV(i - 1).end_blk + 1;
 				FDEV(i).end_blk = FDEV(i).start_blk +
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index f736052dea50..3af77f37fb64 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -866,6 +866,20 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "device_border_line")) {
+		if (t < 0 || t > MAIN_SECS(sbi))
+			return -EINVAL;
+		sbi->device_border_line = t;
+		return count;
+	}
+
+	if (!strcmp(a->attr.name, "device_alloc_policy")) {
+		if (t < DEVICE_ALLOC_PRIOR_NORMAL || t > DEVICE_ALLOC_PRIOR_BACK)
+			return -EINVAL;
+		sbi->device_alloc_policy = t;
+		return count;
+	}
+
 	*ui = (unsigned int)t;
 
 	return count;
@@ -1138,6 +1152,8 @@ F2FS_SBI_GENERAL_RW_ATTR(max_victim_search);
 F2FS_SBI_GENERAL_RW_ATTR(migration_granularity);
 F2FS_SBI_GENERAL_RW_ATTR(migration_window_granularity);
 F2FS_SBI_GENERAL_RW_ATTR(dir_level);
+F2FS_SBI_GENERAL_RW_ATTR(device_border_line);
+F2FS_SBI_GENERAL_RW_ATTR(device_alloc_policy);
 #ifdef CONFIG_F2FS_IOSTAT
 F2FS_SBI_GENERAL_RW_ATTR(iostat_enable);
 F2FS_SBI_GENERAL_RW_ATTR(iostat_period_ms);
@@ -1371,6 +1387,8 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(max_read_extent_count),
 	ATTR_LIST(carve_out),
 	ATTR_LIST(reserved_pin_section),
+	ATTR_LIST(device_border_line),
+	ATTR_LIST(device_alloc_policy),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs);
-- 
2.34.1


