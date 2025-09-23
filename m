Return-Path: <linux-kernel+bounces-829590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CB9B9765E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77205423111
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD96530C622;
	Tue, 23 Sep 2025 19:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y4AC5Nz3"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013012.outbound.protection.outlook.com [52.101.83.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD5130AD00
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656733; cv=fail; b=BoLIyF1SIPOX544yZEoP1xFXZyYkEzjlO/ykOtV3oldZ17VzP2Xy01aHXjp1+DVngBcZtMfpPmqU7SSiEslpQO0ov9E43+CB32y0SlyGnBiJd4KvCnySEiP5MliYXyZyEqunhosgx5YgOb0OTVFSyOGhCBT8SoVAvxl2i9Ao41c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656733; c=relaxed/simple;
	bh=5pMR88Z0uCZBGPHTYjmk+djiuHdG90eGNYQySknuPn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CWSKAEJYh500ddHozZmmvV+mI1JTFtaP7M9/1EIkbwuucfXOGTMuKNSpXMWDAO0ml4QLvy16XJ230/+6PcqjMR2SKKNIwF7JOmWDcuGmIU57CMUIKnCX6mocRI2AmbIvVZP7ysLXpWkMXvI7VJsQLT9q38bK/Er3aMmil+srCG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y4AC5Nz3; arc=fail smtp.client-ip=52.101.83.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fkZnjcNA1Fy+Ff7DLpjAUaShX0RswoxyOF9m+hN5L3NWbrQQxKXUipRRsNz/PwuOZuqLuTUqYNjwu30VVS6ieoHOmxiTDXHMVf32PpMudUDDpRBfrMHP0VqFgyor9mx/XxniiVL7x8Tg+YAYbcF7xEb/XY9fsI5CroL26tyrGko+wvuplAUZNpTA3feBhLt7LLqaB/bMqCZuD3VF0FyqpNmKv0oxfqQw4RE6L/3Ean+gmHzCcYn4yzIX2zXaAcnzL6RALzlb8awLdkiomj1RVH/IDIDyLW8ryZwCMy4pSvYrMkTX5R/KevOyq9B1YoDq6rb/Sl1VSy5momyZAuk7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiFIIZDVYKBe9+Qd/XZV7H8tFBwsPmr15DyAxh4bff8=;
 b=xYa4hAqxgnsFsblM/mbtp/OygBFkUsy/xKoZNW++XLHPhXhF/fwg3EdmAVOhYIS6fzT13IvDSXL3lBX9Fwb4W6EiuU7vjyxF7c37KYPiwqAYYShMZ4XJqSbnJQY6ulAEniANaw9/5sDTCycfeFUZ7ue+59XLmhQ1/7V7HSqEX5X3tKJef0H9U5eTtV87KXAfqUvv2Rrf39hh+q+/kFPLXD9rj2WSlQfoninxBuv4xjA9ilGafIZpmSa9TW87ID9DesDZZ5UvnrK/nraQ1xRf7VBvayBgZax2a4HyJLq8ZgistYNGBeMG/S56OMM/gW9f/WjRY8nEduyjjHoSZYOKKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiFIIZDVYKBe9+Qd/XZV7H8tFBwsPmr15DyAxh4bff8=;
 b=Y4AC5Nz32GrKdTmRH8rwatr56ZVx12DJPT28t8GkUbuD/fYt8Gi3UFJ5XoV3oV9R1zUO3MpjRvZz7R/U/yFa+wx2nQMISOFnZrx3CiLK0sCnIzMK1c0ni5ustC4wB8j6tBX7EyaFtTvsxZuwhlF44+jxOsiJgiyQHiLXX4ltXGjryx2IbB+FMzwQR/autxEQHmRgYqStgwoir6Ep4eysKOH54XGYcK8TXvTnnVRXewwLdIpOhc4OWEIcS1tfi6tEwl9mCofV6TYGSx+8Uo/DYbuANp6bxYQGfMrl9sLIPCssSpXMP93NljvLcasx6N78hUCPHWRUqviQLGDGb0qArQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBAPR04MB7352.eurprd04.prod.outlook.com (2603:10a6:10:1a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.8; Tue, 23 Sep
 2025 19:45:18 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 19:45:18 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 phy 14/16] phy: lynx-28g: add support for 25GBASER
Date: Tue, 23 Sep 2025 22:44:43 +0300
Message-Id: <20250923194445.454442-15-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7bdf5eaf-ba01-4af1-717b-08ddfad9b985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WhVUnpWHsOND6se5sxJzmFYUoD3872Jl+zvJvJJ8ZYl5ade/E0Wy7HdJIi0R?=
 =?us-ascii?Q?lcCdQqeIK04aiP4O+WaUtXhRDm6DQFez3swjDN+ytkIN6B1+eQ9YStGkOZGS?=
 =?us-ascii?Q?f+WiiRZZxdZUOl+NAXeMI21miELw+3XxnxyjoTyZfH99dn7rttTeeHfky7dh?=
 =?us-ascii?Q?AsWAfZhzpVMnnuRdBYK11mhgcKhfcQlvoXBWxAjsibpxoadQLEQ7SQ6VMjiI?=
 =?us-ascii?Q?uG0+bNwvz+4SW+k52qBp8pcHabyXU7/O99iYPXuz+kQUqhI7gS898WUStuDL?=
 =?us-ascii?Q?ShlhiHnnDKzMvw3g0dc5J9h6oYr/H2hb+XH1MPq1wfRVQitQDAk8HLlwi6mi?=
 =?us-ascii?Q?AnmjaeO45wodrSMDFvhlETKDdGAuxTC7zIaKqndkLanntbKsI7CdDIJbE042?=
 =?us-ascii?Q?IVNtReDHmhu6oJeymWffOvAuuVVhWVKTxtqr+Sqzk5iwp0Ld18taJ9PLCY/d?=
 =?us-ascii?Q?z3kXmwausZQcCXYRMVJqIG/t4xrOyRahNQPJVuOFJG8T1N1EBQdWjWN95cp2?=
 =?us-ascii?Q?5okCx/0ON552AFeUE7D+V/J7HBaoyXdcGhBBOptEXhJfKGPGuNkp39GE8oAz?=
 =?us-ascii?Q?7RRNrlKp1epo/69AJgnyXeq4wpBZCDJ5fxYIy7lcAwaIclx7bqx091ZP5vh0?=
 =?us-ascii?Q?5JzqsS7SWTA9jvOZYH5qooW2RXdMKpvS6F03gl4c9YUa5yH31fIJL16SaPqL?=
 =?us-ascii?Q?Qs3un5Xox/mhFapm9g/zBBPw+fH0RiHy8CbTCNpG0HZQfneQ/kNVBQ1aWJpJ?=
 =?us-ascii?Q?5IRaEiieGStm/D0oarli+xBtrCr735mFQPOAM41Hm1jwxkLVGsaBsTsIohEo?=
 =?us-ascii?Q?lUlABl6gqRpzjPf4qXqlswCnNpth40KeYaCWtXWRyQ8v1yTmM2AsUF7qbl6d?=
 =?us-ascii?Q?bZI1BLvgZ/D/0O+EVJXCVf/H7CYyB2sEH7fJKwLQ7QkENATfBUg4wl/WPYFk?=
 =?us-ascii?Q?sYYWyaQ+T9xlgb7E0cP3w9+LZFVwe8XcZ6AZ+Jlhy86P5b9FG2cIuQCrZ6eH?=
 =?us-ascii?Q?MbO/QxnwlZ7qUtFFfl5njM2gSyOweoURdGgc42zXkKyRzzzkpwDqsF+bBVif?=
 =?us-ascii?Q?hbT2vFuiEMbtPtpivA+jwYum2+3Mm62/JaSzPtYmvn6SC1NM7NiCDFjZP0ek?=
 =?us-ascii?Q?KcBjNFVC8+SphMYHK89AwPP0C4hwlPLMwiuA2+H7+nbgMVGpfpRTO8aNQZOn?=
 =?us-ascii?Q?N6D8XMh75bO3gGBKzYeAFMoKhdAAvW4ZeJuEM9og7pvGd7FUILZ7vuhPDEF+?=
 =?us-ascii?Q?NWLRnw6/VlX/KW5FPtAHoDPjFIdfiXUTILq+fiwociiiKsujWJFuFW/hA5dP?=
 =?us-ascii?Q?+08V5ygrTi6+ro3DEuUIFY0qGHCP/Su/ey4EAnSIwZtsDBf3GX4lA11rmASd?=
 =?us-ascii?Q?bnGH2vsVB3f7rAr/juSbVCrkxTx0Skspv9QARnUpiogbAKWpknkK9bVI3szM?=
 =?us-ascii?Q?96I8+fybA4ttpf0tM8U0wcTtuJUuTX5GEIEFOv4I1nGvkGcgvCHR+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?De9zxIVUo+LRth8Ef4MlBGuUjsJAg2QPr0oTqDAeNJ6T4rCpahEQhg6T4JTU?=
 =?us-ascii?Q?4LfZEIAejvArUCvsJ8Q95kfhI/aIVwXu09NylAU2JmXA1WeCLDCtRQCfRr2H?=
 =?us-ascii?Q?NEHHrP3OmZNFs3Fbx8N7HaD7baJGI0/wLlB6bAfmkxQVxXA0C6BRHbQHQGec?=
 =?us-ascii?Q?Bi37t25QxVPE6bZAmDHXNqom4RmIVy8nQQveSmdzeBivPqsFpQGnTFTafQoC?=
 =?us-ascii?Q?vC2acE4JupIgwhlpDyXj3UsXoa9F4VaYDo7LcExo8IxsoVyjRiafqF5NhoGy?=
 =?us-ascii?Q?xUoY7BMlKf8jGVgUDcHK3FiHpezlxdV3hlRlt0iVOf+qBbkzzcrv1NZPT1uk?=
 =?us-ascii?Q?RWNW2iox16zkwaRsNM5MnWMDw6qSBDUUgh9x0a3DtqgptNDlpFfB0XcWZRwB?=
 =?us-ascii?Q?r6AwPl+htWxGgTsKFu5C+q9OWOYLwm57DsbZ6tc7zQzgE035KI+4ocrdrqux?=
 =?us-ascii?Q?cOSr9hUcHQ6MT0QqBpB9ekKHd3CI2fdzB/E7aJCHRhrnE1RmY7mzvRCZfd+t?=
 =?us-ascii?Q?b1GTKEea3oU3QArtWd7SEp6zecK+WNZZ+0eekLY1nj4DRb23Ldl33YJArnav?=
 =?us-ascii?Q?06nQnSGJsptXPAYqNCPNU7q6eq1+NJPGC4KJktlXfXaUnhu3hstmmzxXYX4o?=
 =?us-ascii?Q?UgGm7HnDdeED4SqXh7zpfEoMQJbsuUKV/ZsH09QbjWs+y5qgnGYRWYple+ps?=
 =?us-ascii?Q?hH8/ukS6qSXPs7f1lM8pZReJoqe5xx1Hsi5YViqjXRVHiy//JX8id4/894gR?=
 =?us-ascii?Q?NtYeoerjjgJ4ERKuHTT4+ZZKGV8uR1yjn5KJkVVwSjtsH84NyXq/4Dd8HZ7S?=
 =?us-ascii?Q?5UalQ6UYgefzb27VjngEzX3tlZb1pwdRF1Elpm4LQ+hqBx1xNUjZh5AaNjOf?=
 =?us-ascii?Q?XJPUXXDfetU0z87GJzaZLneJmtjFl26JfBQZYIJVNLYzevIRAMVAKYIWR4ro?=
 =?us-ascii?Q?ikB0itQaKYEHVAuHFo36y8HSQZiThELVGG/pXzK/5wVgLXtbwkObXW0BK6Hq?=
 =?us-ascii?Q?xRBHJT5a7lsaP1sw0XVKUWoddfF4U5TLk5LSiBXZQUkL3WP8tlmhN4FO4Nxh?=
 =?us-ascii?Q?2QuEFtnIIYLhtzlBM1AthjrFD81JMagIpHnTCCa2F1jYE+nJ4t9nMP68+O9n?=
 =?us-ascii?Q?xHxAS5pB/XfQ5KLtFiEg5VRG+EEjPcqbXN+7vMeniEQ1SCYWvn27GP5QWPTr?=
 =?us-ascii?Q?Ch8AUblJrR3vY/IgsyWCTvWXbHRT7nAFfQp1OGyW/y6eesmQa15ZWEeaNDSh?=
 =?us-ascii?Q?S5mZlLdHEJpJUF0ZIRoi9nLsWXsiiqwv9wnnnOQPvOeJvyrdRXOCMFDBzDJs?=
 =?us-ascii?Q?HR4GohUi/Px6m/OpCy5egrrReUAkqXGlTnqrWu2VzfV+HoW6xQGckVkn9eJd?=
 =?us-ascii?Q?CxntQTkVQGNWAd4glz37h4dKzhuSXZ4YpqBdqZnhAcwwE9xuF301POud6b/N?=
 =?us-ascii?Q?+wPi1kCTBIgvl54Ktm+o0PZMs1usEk6Y7+b4LfHCon9hGaeOjd/hz8WbqYew?=
 =?us-ascii?Q?NBNuYqw4NQU0CLjvskU5RtdTnIymwid8HIOACtv1bdTFDUxr5Ni62hYyfj1D?=
 =?us-ascii?Q?neM188Te4wSlg1bpaW7beoBFuUov8XCwMfYzhsk4rXJN45OO1sIm+rcwyIWc?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bdf5eaf-ba01-4af1-717b-08ddfad9b985
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 19:45:18.5388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVIQYCgxgmmFo/Rjrg78l3Hw07Howr1CL5KO31nKIibotTeogg/ygEi3QPpPBzc7zXkbu55bxe99HPZYRqOtpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7352

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Add support for 25GBASE-R in the Lynx 28G SerDes PHY driver.
This mainly means being able to determine if a PLL is able to support
the new interface type, to determine at probe time if a lane is
configured from the Reset Configuration Word (RCW) with this interface
type and to be able to reconfigure a lane.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: implement missing lane_supports_mode() restrictions for 25GbE

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 90 +++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 9b8e24828d0f..6f2078721aca 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -57,6 +57,7 @@
 #define PLLnCR1_FRATE_5G_10GVCO			0x0
 #define PLLnCR1_FRATE_5G_25GVCO			0x10
 #define PLLnCR1_FRATE_10G_20GVCO		0x6
+#define PLLnCR1_FRATE_12G_25GVCO		0x16
 
 /* Per SerDes lane registers */
 /* Lane a General Control Register */
@@ -64,9 +65,11 @@
 #define LNaGCR0_PROTO_SEL			GENMASK(7, 3)
 #define LNaGCR0_PROTO_SEL_SGMII			0x1
 #define LNaGCR0_PROTO_SEL_XFI			0xa
+#define LNaGCR0_PROTO_SEL_25G			0x1a
 #define LNaGCR0_IF_WIDTH			GENMASK(2, 0)
 #define LNaGCR0_IF_WIDTH_10_BIT			0x0
 #define LNaGCR0_IF_WIDTH_20_BIT			0x2
+#define LNaGCR0_IF_WIDTH_40_BIT			0x4
 
 /* Lane a Tx Reset Control Register */
 #define LNaTRSTCTL(lane)			(0x800 + (lane) * 0x100 + 0x20)
@@ -83,6 +86,7 @@
 #define LNaTGCR0_N_RATE_FULL			0x0
 #define LNaTGCR0_N_RATE_HALF			0x1
 #define LNaTGCR0_N_RATE_QUARTER			0x2
+#define LNaTGCR0_N_RATE_DOUBLE			0x3
 
 #define LNaTECR0(lane)				(0x800 + (lane) * 0x100 + 0x30)
 #define LNaTECR0_EQ_TYPE			GENMASK(30, 28)
@@ -112,6 +116,7 @@
 #define LNaRGCR0_N_RATE_FULL			0x0
 #define LNaRGCR0_N_RATE_HALF			0x1
 #define LNaRGCR0_N_RATE_QUARTER			0x2
+#define LNaRGCR0_N_RATE_DOUBLE			0x3
 
 #define LNaRGCR1(lane)				(0x800 + (lane) * 0x100 + 0x48)
 #define LNaRGCR1_RX_ORD_ELECIDLE		BIT(31)
@@ -269,6 +274,7 @@ enum lynx_lane_mode {
 	LANE_MODE_1000BASEX_SGMII,
 	LANE_MODE_10GBASER,
 	LANE_MODE_USXGMII,
+	LANE_MODE_25GBASER,
 	LANE_MODE_MAX,
 };
 
@@ -407,6 +413,41 @@ static const struct lynx_28g_proto_conf lynx_28g_proto_conf[LANE_MODE_MAX] = {
 		.ttlcr0 = LNaTTLCR0_TTL_SLO_PM_BYP |
 			  LNaTTLCR0_DATA_IN_SSC,
 	},
+	[LANE_MODE_25GBASER] = {
+		.proto_sel = LNaGCR0_PROTO_SEL_25G,
+		.if_width = LNaGCR0_IF_WIDTH_40_BIT,
+		.teq_type = EQ_TYPE_3TAP,
+		.sgn_preq = 1,
+		.ratio_preq = 2,
+		.sgn_post1q = 1,
+		.ratio_post1q = 7,
+		.amp_red = 0,
+		.adpt_eq = 48,
+		.enter_idle_flt_sel = 0,
+		.exit_idle_flt_sel = 0,
+		.data_lost_th_sel = 0,
+		.gk2ovd = 0,
+		.gk3ovd = 0,
+		.gk4ovd = 5,
+		.gk2ovd_en = 0,
+		.gk3ovd_en = 0,
+		.gk4ovd_en = 1,
+		.eq_offset_ovd = 0x1f,
+		.eq_offset_ovd_en = 0,
+		.eq_offset_rng_dbl = 1,
+		.eq_blw_sel = 1,
+		.eq_boost = 2,
+		.spare_in = 3,
+		.smp_autoz_d1r = 2,
+		.smp_autoz_eg1r = 2,
+		.rccr0 = LNaRCCR0_CAL_EN |
+			 LNaRCCR0_CAL_DC3_DIS |
+			 LNaRCCR0_CAL_DC2_DIS |
+			 LNaRCCR0_CAL_DC1_DIS |
+			 LNaRCCR0_CAL_DC0_DIS,
+		.ttlcr0 = LNaTTLCR0_DATA_IN_SSC |
+			  FIELD_PREP_CONST(LNaTTLCR0_CDR_MIN_SMP_ON, 1),
+	},
 };
 
 struct lynx_pccr {
@@ -486,6 +527,8 @@ static const char *lynx_lane_mode_str(enum lynx_lane_mode lane_mode)
 		return "10GBase-R";
 	case LANE_MODE_USXGMII:
 		return "USXGMII";
+	case LANE_MODE_25GBASER:
+		return "25GBase-R";
 	default:
 		return "unknown";
 	}
@@ -501,6 +544,8 @@ static enum lynx_lane_mode phy_interface_to_lane_mode(phy_interface_t intf)
 		return LANE_MODE_10GBASER;
 	case PHY_INTERFACE_MODE_USXGMII:
 		return LANE_MODE_USXGMII;
+	case PHY_INTERFACE_MODE_25GBASER:
+		return LANE_MODE_25GBASER;
 	default:
 		return LANE_MODE_UNKNOWN;
 	}
@@ -588,6 +633,20 @@ static void lynx_28g_lane_set_nrate(struct lynx_28g_lane *lane,
 			break;
 		}
 		break;
+	case PLLnCR1_FRATE_12G_25GVCO:
+		switch (lane_mode) {
+		case LANE_MODE_25GBASER:
+			lynx_28g_lane_rmw(lane, LNaTGCR0,
+					  FIELD_PREP(LNaTGCR0_N_RATE, LNaTGCR0_N_RATE_DOUBLE),
+					  LNaTGCR0_N_RATE);
+			lynx_28g_lane_rmw(lane, LNaRGCR0,
+					  FIELD_PREP(LNaRGCR0_N_RATE, LNaRGCR0_N_RATE_DOUBLE),
+					  LNaRGCR0_N_RATE);
+			break;
+		default:
+			break;
+		}
+		break;
 	default:
 		break;
 	}
@@ -665,6 +724,11 @@ static int lynx_28g_power_on(struct phy *phy)
 	return 0;
 }
 
+static int lynx_28g_e25g_pcvt(int lane)
+{
+	return 7 - lane;
+}
+
 static int lynx_28g_get_pccr(enum lynx_lane_mode lane_mode, int lane,
 			     struct lynx_pccr *pccr)
 {
@@ -680,6 +744,11 @@ static int lynx_28g_get_pccr(enum lynx_lane_mode lane_mode, int lane,
 		pccr->width = 4;
 		pccr->shift = SXGMII_CFG(lane);
 		break;
+	case LANE_MODE_25GBASER:
+		pccr->offset = PCCD;
+		pccr->width = 4;
+		pccr->shift = E25G_CFG(lynx_28g_e25g_pcvt(lane));
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -695,6 +764,8 @@ static int lynx_28g_get_pcvt_offset(int lane, enum lynx_lane_mode lane_mode)
 	case LANE_MODE_USXGMII:
 	case LANE_MODE_10GBASER:
 		return SXGMIIaCR0(lane);
+	case LANE_MODE_25GBASER:
+		return E25GaCR0(lynx_28g_e25g_pcvt(lane));
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -703,7 +774,12 @@ static int lynx_28g_get_pcvt_offset(int lane, enum lynx_lane_mode lane_mode)
 static bool lx2160a_serdes1_lane_supports_mode(int lane,
 					       enum lynx_lane_mode mode)
 {
-	return true;
+	switch (mode) {
+	case LANE_MODE_25GBASER:
+		return lane != 2 && lane != 3;
+	default:
+		return true;
+	}
 }
 
 static bool lx2160a_serdes2_lane_supports_mode(int lane,
@@ -1018,6 +1094,9 @@ static int lynx_28g_lane_enable_pcvt(struct lynx_28g_lane *lane,
 	case LANE_MODE_USXGMII:
 		val |= PCCC_SXGMIIn_CFG;
 		break;
+	case LANE_MODE_25GBASER:
+		val |= PCCD_E25Gn_CFG;
+		break;
 	default:
 		break;
 	}
@@ -1142,8 +1221,12 @@ static void lynx_28g_pll_read_configuration(struct lynx_28g_priv *priv)
 			__set_bit(LANE_MODE_10GBASER, pll->supported);
 			__set_bit(LANE_MODE_USXGMII, pll->supported);
 			break;
+		case PLLnCR1_FRATE_12G_25GVCO:
+			/* 12.890625GHz clock net */
+			__set_bit(LANE_MODE_25GBASER, pll->supported);
+			break;
 		default:
-			/* 6GHz, 12.890625GHz, 8GHz */
+			/* 6GHz, 8GHz */
 			break;
 		}
 	}
@@ -1200,6 +1283,9 @@ static void lynx_28g_lane_read_configuration(struct lynx_28g_lane *lane)
 		else
 			lane->mode = LANE_MODE_USXGMII;
 		break;
+	case LNaPSS_TYPE_25G:
+		lane->mode = LANE_MODE_25GBASER;
+		break;
 	default:
 		lane->mode = LANE_MODE_UNKNOWN;
 	}
-- 
2.34.1


