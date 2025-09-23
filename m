Return-Path: <linux-kernel+bounces-829584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FC7B9764F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B064222B1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7085B309F0E;
	Tue, 23 Sep 2025 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BhPknK/q"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011025.outbound.protection.outlook.com [52.101.65.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA04306B39
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656727; cv=fail; b=sOOMaOXihaKg7Ma5b6oQGDh6hd1XGE0Jt9JQX58Ej/rdFSVXQ+OHSWY935a78OgmxW6FutPnUi7OiJQpWaOMDnkkM/7nlpiecUGCcCAFb8UrzZfN3Ql//aExFvK18mCacZlAR+XsO+c2IMRLiedk4jq1N6BZVGW3COef54QG7jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656727; c=relaxed/simple;
	bh=VfPosj9n190jvjhKDCbqLs8Wop8RuxxFg1LCpE8kRXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pl1YsaRZusiJO85YxUylhISSVZtzTLFJRQPBn6Fb16fHhqpK3HZSOE3XHyUq1rDG5zkYQut+HggSfWMyGGeU6bu9SgPtggaLzYceExZ45CjUioOCcLZ2YkwvdpOT7o/t9UzsMvNjnLdqcG3pO2BWgxlYpP4AjNIBdmj99MTvNSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BhPknK/q; arc=fail smtp.client-ip=52.101.65.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILEYKiqQ2fCCvlEep06BaQbArEfsxyuejyUBUmWzRl/JgcGZJvwXazTc1FNBjVTl27dDX7SC6zTF4ogToTeDZLZWsXaPFvOS+fQDHn5lS7xHA80nvQpCF8JiueY2vn5QRsP1udyNO+YSM8YzLWfozwzxufPEYEb3CPdd6jhblLprigRhuXsOd4niqLOZc6eJqDnPojcdbymOlAusWpCzLYt45cdRYaDnP+OWpL6uwYCYRPnlnzbv94Nd6Km3QZJdUZtoIHWQDqkXS3U5RG3qQROM4TsLayNLACrmv/3qc8r9L0PmUoJxyZ//j643muO+dVhuTgnfqyV7uqdihYtUEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhHmU+JdFxXjPbl5fqsDCvDarf5KJ4skCquXaR3IwMw=;
 b=UuZiQLh/DXGtZOnSgyKrJ2MGU7lpfNtbQ9v1+tFR3cWepb8pnH0Ch9vj8zyUbsh6Urhe7KNv/qiP6OwP/BFuC0L6+zt0PISvxZf6xvIct35iXoqAbLdgwpIDdcm87be4AoJo0eQt1BdEdYbapi7Mm5aHkH7R3Y3N2REHiNBdvTSQ3S1pxGwrNN1ibNvxlQM4xOp7xChzoq0TDFJiAuTqYZe6/Ci314tdGPSLc5DWf4MpnT1AOtUGY317Ba8wBUFvykD+DqulZkLI8u2UxJk9b3v11jvHTO9NG8goMAe1YdBTt0Tk1gN8io6QzOyv0F4ZFc6qPuVkqTjHkpKfs6aivQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhHmU+JdFxXjPbl5fqsDCvDarf5KJ4skCquXaR3IwMw=;
 b=BhPknK/qTWPc16rhWg2CsQH7ZcNdtP01mggNgZb7uz9tJSd8iK9U+NakZlCSUqfZDK23t/J7JgcfJ4uS69norJyRPln437bJ+rqEeQaOMeQHfr72xkD40772FgXaqoUO1jzc1NAC/YTq0rbA+5mEyNhnaOxZiDQpu7OzfrK2ZOwi8XWbvqPRE2MjkJ4uc/po0V1AQ2TYAmCvpsPwDS5IdiuEjsdOTMXaww7/MhzEWEvJ+YgiPSH3vhx/2sivTYIL0lS0o4PgDp+0bANluK2xZ61I+l2q371IEi/GyLaqZxaUFGlhojsngcyuwk8wCmD9DE7Q/6N/wt5hqnHi6p2tjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBAPR04MB7352.eurprd04.prod.outlook.com (2603:10a6:10:1a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.8; Tue, 23 Sep
 2025 19:45:13 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 19:45:13 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 phy 04/16] phy: lynx-28g: convert iowrite32() calls with magic values to macros
Date: Tue, 23 Sep 2025 22:44:33 +0300
Message-Id: <20250923194445.454442-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250923194445.454442-1-vladimir.oltean@nxp.com>
References: <20250923194445.454442-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0028.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::33) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DBAPR04MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: df50b1df-252a-4ac9-635d-08ddfad9b506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x00Z5MnAv0e1QUgEp+J/KhtpYNzAnfZ4jgMhLGP41tBm+oKfYb+9HGJ6EsxH?=
 =?us-ascii?Q?zMhiy2XHYjLjSwiu2VgKqyRh4Gx6JifXTnuBy2jiFAENCh9xz3cjvLUK3Wpx?=
 =?us-ascii?Q?kH2mYa/v9KdMplOR5Q63/IlYbl3Zq6v3AvFpQRC707MD/6dT3YtkAo9ZSwy+?=
 =?us-ascii?Q?26mXmFf32hHF5m6VCF5l8WAFxqCFnVkSE2eTzkGgdP0M+5Io26RPkJqyWNaP?=
 =?us-ascii?Q?y+oxBRHgl5QJAqYk6thGrNQMGyJjQ8ygouOxNbWW8M1uiIPf359KxQkc351w?=
 =?us-ascii?Q?f4bMEWwYFMFehQ9AXZktnZiurMM3xrd6A/srV+vqWSbCvpd6p022eLeYNSKV?=
 =?us-ascii?Q?qh04E+sFbb/NjX7fSJKbBub857UUF5AgaenxiERNXt3fNFyYm9KucRvneKHq?=
 =?us-ascii?Q?/1YrOUFFrUxf/XWwmtA0zQGUgUNN/8aCzvYlU6EhOiDpwFZEZpzXFCTygIdT?=
 =?us-ascii?Q?nmkw1Qh0KlLJVloPGSxdcbzJCYb0v8ncZm0tVrOKOGV6Tfrixyom6my4MQgF?=
 =?us-ascii?Q?1I7lFpGk75KY4VZ2qdC84zKK2ices1JomPRpUo/xXM+KYS6rYLWM8UF2ai9k?=
 =?us-ascii?Q?c/ew54vDZIiZVXcTBXuzIxanC9nqg5QfwjnrTdkZ9+HwD7u2Z3j4shs0siyH?=
 =?us-ascii?Q?y3cWTa6Y98uYjS7AB9B82U3NY+HTs+DnSyPjokTtmmCljz8DRpFlnZWGb3Ql?=
 =?us-ascii?Q?mSbepshSJsHrrN6HCoVVluWk1fZ/DVvrflbhbSDqUfMJr0Zw7rsDxXDiof3q?=
 =?us-ascii?Q?7R9flE7lppTV2GL44G0HserP0Huhrvoo6XSEs3t8AmF3TPvTYO7vihRpDApa?=
 =?us-ascii?Q?ss0E4df7JDECmCO2LQeaRPqzSsC3lW7rzdcuqde8HUj6j3l/ChZlEOhux1Ka?=
 =?us-ascii?Q?DxMr40TiufJBh5pN/m5pwsDkegfapnfPFKba2yvgPGu3MtDE/i/5ymWJndRY?=
 =?us-ascii?Q?qKNr2dFMfbA2wdmnrq850wfFMjZZA+XbTNYNEfKiqh+gDCeYUD2NiAQa3oaT?=
 =?us-ascii?Q?NG0/McdJfTgU1UAO10Pa7+NqzNVL98nMxdu4cZkg1/LuI2pwYqao+PHgirV/?=
 =?us-ascii?Q?ZSmu/IMCD0hXkVDmsFBPh5agdN6OzAteI7Tp4hwoguDpWc2Ck+7E2OmYDBge?=
 =?us-ascii?Q?N+aipjhghsZ2uK++ed6vi7pcip2XnlSe6dWA/xS8I1HsJMTIfjRIwGOkXWoG?=
 =?us-ascii?Q?FJO6Inoxl6PtjlFAB7t6WQLtSGEGwYjobatxRo5skNKfFFLgyrB0u/2rQTQ1?=
 =?us-ascii?Q?mgHyHxSfsll7x9sf/LaALUiRwaxNFk4OpI1mvB1tInTKvUUFHsDm+I1NvVta?=
 =?us-ascii?Q?JpHpgnmUfx0D5JgIqwqbnef8qqScGaGztaih2Q5ExwFNq0ezU/9RrsnXY92e?=
 =?us-ascii?Q?HHyKRJVpdH2QIurJEgDyYOZkXDQ4GHbrNCjFgKlBqOv7afDv6Fr5eTmJ0lqr?=
 =?us-ascii?Q?bQfphfYIpaJjGhI7GAtMqkRieyP+6cu7dzD5vVb/gqGrowyFdpdtYQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qD4cGw7hvKOMgAY4jqX8mrWRt+dqAhXmp5hxNBOuGNygZkrmW06Efoho+i7Z?=
 =?us-ascii?Q?VsWu/US6TYX0hFQen4yV8mNoVGybfBDhijHaXJS5sZ02nMH01Erh3y4Z4Tnv?=
 =?us-ascii?Q?BtX0P/3oOZkefiEfgLFpWysTSLIhWOZvezyYb0EaCJYExNk4Wx1vBNjnwV7M?=
 =?us-ascii?Q?J6WWiBFSTXqe6uS4k45hqAoSWH5zsTY9DwvLMgiiavpZw86vLSPQgeBKodkU?=
 =?us-ascii?Q?ViuJ47rDdO8/28R8NxzxiagebefC/M23ea0BUDnKTHZ+N5vH/yX5xLV+ikr3?=
 =?us-ascii?Q?QJmcsJZsmDpsjfyr/j6T/Og4TBRRQNtWi7yxBCuyaO/vjJBayzq8nk3GEEMI?=
 =?us-ascii?Q?tqaOq2dzPJrIZLZ0tgLyOMZvlV7Cwag0TZBoHbQoorGOtoQ+Ah9oEgHdcTSJ?=
 =?us-ascii?Q?P8Y0CeBVjNKc4Dq82Wuxb+f0BzZ0fDdAu+02+CWloAggwjJm32hvgTgtBZEh?=
 =?us-ascii?Q?OsHnMqtIrE3fQV2/Mj9S2mb8KcQZA7kNz5uCwBHs/irkxWeiSCcs96dpmRIX?=
 =?us-ascii?Q?bUf0a51gddhQoAZpgfXa2+PEbPDVr3KN8VpMHSu3+dfz82JgculXTZHoja9/?=
 =?us-ascii?Q?+xEyKmzSrbGan8DHH91/A2grIDmgShPOFqS5yOJR2amiG+6r1ul6to3FSvEl?=
 =?us-ascii?Q?d1Ao2h2bhs3PQ3BAwQV2nAx6cgX4edDGSHkjMYxxZxEE5s5P1PiyT856GZ/u?=
 =?us-ascii?Q?IQIEfZSH7fgRVN9FDFEse/wFS6TET2jDhfDsQDiEri4rIc8WfoKRO+tNqj4w?=
 =?us-ascii?Q?fikArnSzZW6k3xcGDXrAU2UwDrCTVJmkO4iWSa2ilpCM+DoMrruRqXDJ2tfB?=
 =?us-ascii?Q?ybxPOCVeEBv5XYL/IyP2pVAlQyP4QVFvFa+F/An4U2UEJVpkf6iDqTiErYTh?=
 =?us-ascii?Q?kZV8WOI/omSu/4xU5D9kUjHeWlvWzoCnFCZoCThQGMCk/zrbIMgKhxqB7kXm?=
 =?us-ascii?Q?j2QYv4mbJqTehmw7ntQBS7102SScsmULTMd1CRk/zzofr273Yl/6GCs7x3qj?=
 =?us-ascii?Q?/RJylqnnircNVmOb7lHnCJKnG5O7y8kRwYDNcbH9lvkFZgh40AGCOFFFd32l?=
 =?us-ascii?Q?D4GXh2Nqh4MWQoAtgxudC3WwnYnPn/T+1C7RpzmeOc49R9c/cN/yUQkKv4U3?=
 =?us-ascii?Q?w+xHtNGpVlbPOb2oRN1uQ1pmVXe6RKKv6ukjLh386HRAMWWaMinetfTGUd1m?=
 =?us-ascii?Q?MiRvZlagZRnqyjdfaTP6GMTOPxgTtYpOKoOBCaGPVVy+qPFD9kHwfzYrxnNC?=
 =?us-ascii?Q?+d/CBN3JH2WQOZtXda/3FM4e2e9a2GRRHtyWFxtBBIdpR6necTf5XRu5bTRs?=
 =?us-ascii?Q?Hx6WrZRT9XU2KmabNCLh3Y4nNJDacRy5F+Wt8E+0pYpsDv3jpGwxOt+W+SUM?=
 =?us-ascii?Q?PKS84zOgtLUfraDTpvjLsFcpHJQieJSsFA56umAfyiRGQ97/XtER7LziaNw4?=
 =?us-ascii?Q?9PUAEPa024lDNPakkzr4+jVdLZh3snk+DNOTmVlzk1ZJZ5Clcyx+O2hc+NTy?=
 =?us-ascii?Q?sclbg8pO4pF/ny4CbfpvY30MCqddstFNe97A1phTA7sqJHPEC7ikX1y9IOen?=
 =?us-ascii?Q?hndE2AYl9QQxwbo9P8fbmTzPbxJKjSJqr3HSLzHcJdgdRRzHLFWe9VXMShsE?=
 =?us-ascii?Q?qA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df50b1df-252a-4ac9-635d-08ddfad9b506
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 19:45:10.9978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1rcioqVvPNzT1YlB9wkyQn/lBAAuF5tNhRpnEHdOD/ShmRPVLbxuGqQd9GXKkwWz71vVfU7YUTPssuOn6zNbFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7352

The driver will need to become more careful with the values it writes to
the TX and RX equalization registers. As a preliminary step, convert the
magic numbers to macros defining the register field meanings.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: remove duplicate LNaRSCCR0_SMP_AUTOZ_D1F definition

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 102 ++++++++++++++++++++---
 1 file changed, 90 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 414d9a4bcbb7..684cafb3d3e1 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -70,6 +70,12 @@
 #define LNaTGCR0_N_RATE_QUARTER			0x2
 
 #define LNaTECR0(lane)				(0x800 + (lane) * 0x100 + 0x30)
+#define LNaTECR0_EQ_TYPE			GENMASK(30, 28)
+#define LNaTECR0_EQ_SGN_PREQ			BIT(23)
+#define LNaTECR0_EQ_PREQ			GENMASK(19, 16)
+#define LNaTECR0_EQ_SGN_POST1Q			BIT(15)
+#define LNaTECR0_EQ_POST1Q			GENMASK(12, 8)
+#define LNaTECR0_EQ_AMP_RED			GENMASK(5, 0)
 
 /* Lane a Rx Reset Control Register */
 #define LNaRRSTCTL(lane)			(0x800 + (lane) * 0x100 + 0x40)
@@ -89,12 +95,56 @@
 #define LNaRGCR0_N_RATE_QUARTER			0x2
 
 #define LNaRGCR1(lane)				(0x800 + (lane) * 0x100 + 0x48)
+#define LNaRGCR1_RX_ORD_ELECIDLE		BIT(31)
+#define LNaRGCR1_DATA_LOST_FLT			BIT(30)
+#define LNaRGCR1_DATA_LOST			BIT(29)
+#define LNaRGCR1_IDLE_CONFIG			BIT(28)
+#define LNaRGCR1_ENTER_IDLE_FLT_SEL		GENMASK(26, 24)
+#define LNaRGCR1_EXIT_IDLE_FLT_SEL		GENMASK(22, 20)
+#define LNaRGCR1_DATA_LOST_TH_SEL		GENMASK(18, 16)
+#define LNaRGCR1_EXT_REC_CLK_SEL		GENMASK(10, 8)
+#define LNaRGCR1_WAKE_TX_DIS			BIT(5)
+#define LNaRGCR1_PHY_RDY			BIT(4)
+#define LNaRGCR1_CHANGE_RX_CLK			BIT(3)
+#define LNaRGCR1_PWR_MGT			GENMASK(2, 0)
 
 #define LNaRECR0(lane)				(0x800 + (lane) * 0x100 + 0x50)
+#define LNaRECR0_EQ_GAINK2_HF_OV_EN		BIT(31)
+#define LNaRECR0_EQ_GAINK2_HF_OV		GENMASK(28, 24)
+#define LNaRECR0_EQ_GAINK3_MF_OV_EN		BIT(23)
+#define LNaRECR0_EQ_GAINK3_MF_OV		GENMASK(20, 16)
+#define LNaRECR0_EQ_GAINK4_LF_OV_EN		BIT(7)
+#define LNaRECR0_EQ_GAINK4_LF_DIS		BIT(6)
+#define LNaRECR0_EQ_GAINK4_LF_OV		GENMASK(4, 0)
+
 #define LNaRECR1(lane)				(0x800 + (lane) * 0x100 + 0x54)
+#define LNaRECR1_EQ_BLW_OV_EN			BIT(31)
+#define LNaRECR1_EQ_BLW_OV			GENMASK(28, 24)
+#define LNaRECR1_EQ_OFFSET_OV_EN		BIT(23)
+#define LNaRECR1_EQ_OFFSET_OV			GENMASK(21, 16)
+
 #define LNaRECR2(lane)				(0x800 + (lane) * 0x100 + 0x58)
+#define LNaRECR2_EQ_OFFSET_RNG_DBL		BIT(31)
+#define LNaRECR2_EQ_BOOST			GENMASK(29, 28)
+#define LNaRECR2_EQ_BLW_SEL			GENMASK(25, 24)
+#define LNaRECR2_EQ_ZERO			GENMASK(17, 16)
+#define LNaRECR2_EQ_IND				GENMASK(13, 12)
+#define LNaRECR2_EQ_BIN_DATA_AVG_TC		GENMASK(5, 4)
+#define LNaRECR2_SPARE_IN			GENMASK(1, 0)
 
 #define LNaRSCCR0(lane)				(0x800 + (lane) * 0x100 + 0x74)
+#define LNaRSCCR0_SMP_OFF_EN			BIT(31)
+#define LNaRSCCR0_SMP_OFF_OV_EN			BIT(30)
+#define LNaRSCCR0_SMP_MAN_OFF_EN		BIT(29)
+#define LNaRSCCR0_SMP_OFF_RNG_OV_EN		BIT(27)
+#define LNaRSCCR0_SMP_OFF_RNG_4X_OV		BIT(25)
+#define LNaRSCCR0_SMP_OFF_RNG_2X_OV		BIT(24)
+#define LNaRSCCR0_SMP_AUTOZ_PD			BIT(23)
+#define LNaRSCCR0_SMP_AUTOZ_CTRL		GENMASK(19, 16)
+#define LNaRSCCR0_SMP_AUTOZ_D1R			GENMASK(13, 12)
+#define LNaRSCCR0_SMP_AUTOZ_D1F			GENMASK(9, 8)
+#define LNaRSCCR0_SMP_AUTOZ_EG1R		GENMASK(5, 4)
+#define LNaRSCCR0_SMP_AUTOZ_EG1F		GENMASK(1, 0)
 
 #define LNaPSS(lane)				(0x1000 + (lane) * 0x4)
 #define LNaPSS_TYPE				GENMASK(30, 24)
@@ -104,6 +154,12 @@
 #define SGMIIaCR1(lane)				(0x1804 + (lane) * 0x10)
 #define SGMIIaCR1_SGPCS_EN			BIT(11)
 
+enum lynx_28g_eq_type {
+	EQ_TYPE_NO_EQ = 0,
+	EQ_TYPE_2TAP = 1,
+	EQ_TYPE_3TAP = 2,
+};
+
 struct lynx_28g_priv;
 
 struct lynx_28g_pll {
@@ -151,6 +207,8 @@ static void lynx_28g_rmw(struct lynx_28g_priv *priv, unsigned long off,
 	lynx_28g_rmw((lane)->priv, reg(lane->id), val, mask)
 #define lynx_28g_lane_read(lane, reg)			\
 	ioread32((lane)->priv->base + reg((lane)->id))
+#define lynx_28g_lane_write(lane, reg, val)		\
+	iowrite32(val, (lane)->priv->base + reg((lane)->id))
 #define lynx_28g_pll_read(pll, reg)			\
 	ioread32((pll)->priv->base + reg((pll)->id))
 
@@ -311,12 +369,22 @@ static void lynx_28g_lane_set_sgmii(struct lynx_28g_lane *lane)
 			  SGMIIaCR1_SGPCS_EN);
 
 	/* Configure the appropriate equalization parameters for the protocol */
-	iowrite32(0x00808006, priv->base + LNaTECR0(lane->id));
-	iowrite32(0x04310000, priv->base + LNaRGCR1(lane->id));
-	iowrite32(0x9f800000, priv->base + LNaRECR0(lane->id));
-	iowrite32(0x001f0000, priv->base + LNaRECR1(lane->id));
-	iowrite32(0x00000000, priv->base + LNaRECR2(lane->id));
-	iowrite32(0x00000000, priv->base + LNaRSCCR0(lane->id));
+	lynx_28g_lane_write(lane, LNaTECR0,
+			    LNaTECR0_EQ_SGN_PREQ | LNaTECR0_EQ_SGN_POST1Q |
+			    FIELD_PREP(LNaTECR0_EQ_AMP_RED, 6));
+	lynx_28g_lane_write(lane, LNaRGCR1,
+			    FIELD_PREP(LNaRGCR1_ENTER_IDLE_FLT_SEL, 4) |
+			    FIELD_PREP(LNaRGCR1_EXIT_IDLE_FLT_SEL, 3) |
+			    LNaRGCR1_DATA_LOST_FLT);
+	lynx_28g_lane_write(lane, LNaRECR0,
+			    LNaRECR0_EQ_GAINK2_HF_OV_EN |
+			    FIELD_PREP(LNaRECR0_EQ_GAINK2_HF_OV, 31) |
+			    LNaRECR0_EQ_GAINK3_MF_OV_EN |
+			    FIELD_PREP(LNaRECR0_EQ_GAINK3_MF_OV, 0));
+	lynx_28g_lane_write(lane, LNaRECR1,
+			    FIELD_PREP(LNaRECR1_EQ_OFFSET_OV, 31));
+	lynx_28g_lane_write(lane, LNaRECR2, 0);
+	lynx_28g_lane_write(lane, LNaRSCCR0, 0);
 }
 
 static void lynx_28g_lane_set_10gbaser(struct lynx_28g_lane *lane)
@@ -353,12 +421,22 @@ static void lynx_28g_lane_set_10gbaser(struct lynx_28g_lane *lane)
 	lynx_28g_lane_rmw(lane, SGMIIaCR1, 0, SGMIIaCR1_SGPCS_EN);
 
 	/* Configure the appropriate equalization parameters for the protocol */
-	iowrite32(0x10808307, priv->base + LNaTECR0(lane->id));
-	iowrite32(0x10000000, priv->base + LNaRGCR1(lane->id));
-	iowrite32(0x00000000, priv->base + LNaRECR0(lane->id));
-	iowrite32(0x001f0000, priv->base + LNaRECR1(lane->id));
-	iowrite32(0x81000020, priv->base + LNaRECR2(lane->id));
-	iowrite32(0x00002000, priv->base + LNaRSCCR0(lane->id));
+	lynx_28g_lane_write(lane, LNaTECR0,
+			    FIELD_PREP(LNaTECR0_EQ_TYPE, EQ_TYPE_2TAP) |
+			    LNaTECR0_EQ_SGN_PREQ |
+			    FIELD_PREP(LNaTECR0_EQ_PREQ, 0) |
+			    LNaTECR0_EQ_SGN_POST1Q |
+			    FIELD_PREP(LNaTECR0_EQ_POST1Q, 3) |
+			    FIELD_PREP(LNaTECR0_EQ_AMP_RED, 7));
+	lynx_28g_lane_write(lane, LNaRGCR1, LNaRGCR1_IDLE_CONFIG);
+	lynx_28g_lane_write(lane, LNaRECR0, 0);
+	lynx_28g_lane_write(lane, LNaRECR1, FIELD_PREP(LNaRECR1_EQ_OFFSET_OV, 31));
+	lynx_28g_lane_write(lane, LNaRECR2,
+			    LNaRECR2_EQ_OFFSET_RNG_DBL |
+			    FIELD_PREP(LNaRECR2_EQ_BLW_SEL, 1) |
+			    FIELD_PREP(LNaRECR2_EQ_BIN_DATA_AVG_TC, 2));
+	lynx_28g_lane_write(lane, LNaRSCCR0,
+			    FIELD_PREP(LNaRSCCR0_SMP_AUTOZ_D1R, 2));
 }
 
 static int lynx_28g_power_off(struct phy *phy)
-- 
2.34.1


