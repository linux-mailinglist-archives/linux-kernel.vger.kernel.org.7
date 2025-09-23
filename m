Return-Path: <linux-kernel+bounces-829592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185DAB97673
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6751C425CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF4230F549;
	Tue, 23 Sep 2025 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VI4W2Y0e"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011025.outbound.protection.outlook.com [52.101.65.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CFD30BF65
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656735; cv=fail; b=rSBaSc0kwStYTfOfRSSl+t52jx6WxbRo7pZ7eSnSemWCeaI03sBHTBocQuKLWb/7R6Z84EWOoyaMo3drlrHwiKJDnPElkaW4XC67bhAA1Tgq+8M/TnhhI0bCmI8xlky9u6IkZ8UA5bwvgvJJM3tH4AtSzo9v9gVPCjQzQ6au9L0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656735; c=relaxed/simple;
	bh=eP46T7vDOBS+9sAOaMZHm9rlZiO0zWjyM+xqHtyqqac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jq+dDH6u/SjZYgTUArTiE/TchJepfbZYV3qxpjcdXntB3xnGgr5lyKe+ADJaBSe11rPnVQtBAvNBmP1W9VBvELz0L5stZwBBOggk8NLUQvIwMlog1T5kM3dMFw3ZxyXcvgVTmw680g4nRjptA9L7PSR8q49zzS2DwNNrDmkXQqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VI4W2Y0e; arc=fail smtp.client-ip=52.101.65.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFaE74PTTwsypYrcEJYEvY0vXE5J8LLvqsck0suIW9J/K8uNIQuvRYAXzzMqBtAKYvMm30f5IGKQEfyvfuDLJDKYxYiOfWSPybtUpaQuQ4/wrTtFORE01Ye6s8K93RnXStV+1s7ASunZz9n8KTsQEVH+mhtPV0PwEAiouCGAvwhf4GaN7brWZf8KCmDV+8cnq7/TFlWud+2NFgIPLw5Q2/zeqYftS0O6EksrOCFyUzZefQw2W2HPl/p7ce+S/AsLUjTY0eNjFQS3nzilQWE1GsE8x04aNZw0ps9UF8F7/MUQ4tA6GNvVhNJK0Yv0+Hk/8Xmw4Mriy57RRqSHF/LIyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbV84NuierieuAGyysHDhq6gd//is21js3Id08Qvo+Y=;
 b=OZ/dRa7k0MNK2rq1lHHXl+vhMXqOAD68J4Pq03dmPl5Z/6VUguzAqeZOdxl+HLhbIq9o/Xsv/harxDkkSzn1mKIiB5G1Zec2hLfCMzC2Ql3yhFDEixGdFTwGd2qQrJyF1TMvDMbzZ+5jBmRj17EyEdd5oAsgAfyhriiAHWg/PKHh0dL+dJ2A3H5f7R544dfPb2Z3qPDxSD84E1d07tJyzyoREXrYBAJwlEI6PlJagVMO27f9rTkTtSrjXnrvtiCKNPwTVDxUqAREyuflgib7wfgie68Myqlf4lfGPsoZPZJHlg8tUPXLZyjyYdYR9DMaS25zMZzINmj/L4MF0IZvpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbV84NuierieuAGyysHDhq6gd//is21js3Id08Qvo+Y=;
 b=VI4W2Y0eFf7s+zgOCtzMwjtPqCQ2Emr/1cOb0Qp2bTe2+nDtF9A+UFQ4l+/+JfCD1lucwVszQ2jenZPoruWUguo1F22CiVCRs+/pm4XUny7v5dMQ3DM5p3Ra9Mpa8AWODY5aCfU3Tm2JPFREXlKQhVKgL+exBMv6mYM8OCj6WhwfkdfOCxwGbmub+i9MH/z6aguyoBk6iQbfQUpgiFzaDv10dzuslOT/warI/EHnKhiS/WgMxNLUfTby7JIhE4R8yqd9uXnKk6jeghvAyhepbPr6XXOMZ+r3h3ZAXkCJbF45rD96MvT5Vc/p/8ON31Gs68Plz9neppMgIuoF9Sx2aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBAPR04MB7352.eurprd04.prod.outlook.com (2603:10a6:10:1a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.8; Tue, 23 Sep
 2025 19:45:19 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 19:45:19 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 phy 15/16] phy: lynx-28g: truly power the lanes up or down
Date: Tue, 23 Sep 2025 22:44:44 +0300
Message-Id: <20250923194445.454442-16-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 569de58b-8d86-4e55-d18b-08ddfad9b9ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?We/sVxbZwYJ/Icc04ZGQp12XHNcx806OXAF8UCeA7B/JGGn0HYPrySlMu0+x?=
 =?us-ascii?Q?ZvsleBrE/IvG31Mi527CxOYhupmZEBnZ/xcbonLtrA6ymE4S2+M8O9nfkx4B?=
 =?us-ascii?Q?FUSw2fDQweVc8rcpdHYoagaWNIH3VRjNcw8dp2zwJYD2vXF0oF9gp05rElhR?=
 =?us-ascii?Q?dxo+cEY5a+45FxIvJ3rLbU329I/b7ZIJGGs9sybdtSH/FfBukxPT6R4D1AwU?=
 =?us-ascii?Q?WPeP/BSMZqTKEtajBc2ZaW2zb1iAr870k0h4Fbs3Eu+WhZCEIjb1qGOL3Wjy?=
 =?us-ascii?Q?RjRh22nSTqie4FduR0NBZgowBtWk9O1YPE6mi/WtkbueU3eX02NZso9dVbS4?=
 =?us-ascii?Q?r1w3oB7clrjw4b5JYEyUMDdGqN4Jd1XthbxHVQQk985j/GVR5rGf3CGYaCCB?=
 =?us-ascii?Q?kd5yL/vD6QbGbH9/9VPJRyU1kY58AuSD22qNVE7cR4jWBsxFLwe5+cGybuzX?=
 =?us-ascii?Q?JvhK68CtLvFLziB3e0rKRQWkOabbgRP4wbwY/uGeheAsJzt8x7UAbQrjNju7?=
 =?us-ascii?Q?Wcx/jzqSShqwZ5AXdP6vHJ9kwiIQ/c8jvtQ30dtH9jb0KCbW1TW6LRkBDrkS?=
 =?us-ascii?Q?axx6fobyOxIH+wIp37vIHeVj2HOwns/q3ywiOZnIUf9dsi7771UTUlbQG/5y?=
 =?us-ascii?Q?RjA31l3fqm0VffWtDXKhFbQtuCW1Cfvbb53D5hvcGxJOqL8cu+97MrXzsIkU?=
 =?us-ascii?Q?eP/XCdGKkRaLzFO8Fq6YzgrnhOAOWPuoTEkHozCJQAnnh7jYm7GtsmWdYCRA?=
 =?us-ascii?Q?ceIyQokwCkJr4Qh5gsVd0MvhE8ujn0kVFMcggpRb2PAIT7App5PoypDjUi71?=
 =?us-ascii?Q?8GUdTjHG1HReRY0qb3PEGBBgt3UcVe+polJQ1a7VTCK+gfrupihTkL564Oy5?=
 =?us-ascii?Q?1UiSkr0fEqTguQFGlQzl6iPct/4ZQskRnUnhWmJqx8RMwEyWJE/wJgCny1H5?=
 =?us-ascii?Q?zm6pxoiOazBwBASmr511Y/z7WcVbUdopu/1SzGJ0mkNFpVbgAa38WoUb8SAk?=
 =?us-ascii?Q?AGLWPTsvEjBTgUBhACcCrf2hDw6yaYDCPsLG3v0sV9lHSccslnxHv06wTqGM?=
 =?us-ascii?Q?e360CTRhz0WOwvdvYb2MHqQGjgYdb2DI8WrS9isToRxKOIR36ZQKjJIRiL0S?=
 =?us-ascii?Q?xXq6BKdJNhFdtyy5sJzVU0PDajIMcbauKh3nD456YTZzG+jtuJHkSaKaM5Kw?=
 =?us-ascii?Q?86oSXGInbEfTPfh18GOfEodoXh1bUfLMdcb7fz7nMqi9bA8GFFpVxki7cHJ+?=
 =?us-ascii?Q?tkdO4cRiLUqX3nrtzOXbp5ftzWlfHrXDeJB1cC2EpK4hZyY6U+HVH7WZjmVC?=
 =?us-ascii?Q?fzdmaPD4d1LTLAIUsUVE6j+Rpn7kEpJ5sg4EM4hTJvozNGVNslLsgxWP3WPs?=
 =?us-ascii?Q?c1B0ThA0P+arLYG1m9h/5G4X01v66g+2XewJ8YOiWmx9eVnmw+gS7HQglNcN?=
 =?us-ascii?Q?LOo+cmhH8crscXuRrKemMs9zauAo/S7QCYxHu3NVSu9XqGt4jS/h3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bHsOfuDqLAscr3gceSW+IAH4s/o+5Gsz1tRp0UY9Pai0y84HHJf3uUbDISxc?=
 =?us-ascii?Q?B7tUiyQEJg+Viu4RNRJlj6cLfeDsspaUn+W9VC9v0MBWLP/VBzIS/l/whtj1?=
 =?us-ascii?Q?4p3zglYAgGivgzIqReZkt1gHbnyXIUgkwa4PJvBJuLzkNWdTwLTWHkhBxFbo?=
 =?us-ascii?Q?x6V29e0ZSbXED+6S/QzkEzfGY83umArC1hUEoe4FLEhTUMq+x+ScGUCSDc9a?=
 =?us-ascii?Q?jSGlK7BpBq9ihdz8irmOqmscsXADAw7RjSKMf6RimlSMrZesUNrUDvDR0itZ?=
 =?us-ascii?Q?bi7pq/GsXnOWu3tFovrykSAQhJC5TFp5l+/WADowlAGD9xyYBpx3LhBnKoGB?=
 =?us-ascii?Q?9QB1RaQeAWb72wP6RFd0VodOODzj+jMp9TObhT6feEIH3zVbMGjX9NLlx8N1?=
 =?us-ascii?Q?2bxTdRXJE+77aqDtW+UI20P2eJye67trtttLBJAdI5U/e8S3ZgMKIono6sM0?=
 =?us-ascii?Q?64IxO9MKTlHw872BeowYjmVOVhAs2llzdy7s//nmK7UG8BNu+iVq33PZAeTe?=
 =?us-ascii?Q?HWG9FpNqi02BzFxiu9IBKVHlsb/C21dpHVouZ/tfRw70gUEvQiAxRxI/rbwt?=
 =?us-ascii?Q?Qke8iNJaqLCuf+VcxGeiH2O5AWSSn6pXi0Z7mTvvqyePTQQ0ZEnc6q3MAiiB?=
 =?us-ascii?Q?UlDWZ6QKIcmq4dWw31KsSQetW9lvLAbCIiUl5QhpVgdYREYUlHuohEUWkDdh?=
 =?us-ascii?Q?hEPaaMA6dw+LeEOvGIWjH/bz/2G1rbe8a6NRl7jdC8qwI/RtCdiV8MhsFbeC?=
 =?us-ascii?Q?lHIwLme886v9VVMYRm/0+Y9TBpQ24xHZiuhsbrG5jgnkWm5reIMs0mr6OH+O?=
 =?us-ascii?Q?gog0wb3YbJWJXMA7CzFtPVm9vhU3edfFo+4kxq6ByLSxMUnSneoLIvYie9m2?=
 =?us-ascii?Q?kMAz8n/xbg1K8EvAfA4sSbN2sAzFsgHZbuJPJ9OgtbwfAR3ogv6nnJlOzguJ?=
 =?us-ascii?Q?gFipq7uL4rJ363TzzFHDgVFI3RPhM72HL3u3U5FSC6MVePB31UXRF2dkw61T?=
 =?us-ascii?Q?iYLZV58C32WFKMSf7KGlbleIsKzAYGWHHrKpzSoma0P6j51Vre0HnkN5tAuj?=
 =?us-ascii?Q?Zg7FkKkfgeLRtZJeneFW5TwuepnlFHy/ePyuuCP9mpb0Ke7dil0QrjHQQkfS?=
 =?us-ascii?Q?JBAlew+My0gZ6LkphIgw+ztYVnV/OJ8JD+65+odIssI4bLqzVGK/Z9QOXsMw?=
 =?us-ascii?Q?U+w+RtldKb57sXFAOBHq+XepCbwSpYaIem64wkfPadB3QAiE16wiX/HzmZn1?=
 =?us-ascii?Q?U+pxBbPYUqUcIyV9JU94UJEkpKRYqOO6M/uWEbBm7bYYGFh82T3AST6o4lza?=
 =?us-ascii?Q?wrfOyanS9o90HY4NIsN8tSE+OmKVHr2aSYS8K/eD5bTHDNZpqeSqbDlBsRV+?=
 =?us-ascii?Q?/MAhiKwzmzocAQQlQtE4vhLJMlV+fcdibug/3lpBzTAFg6jICX7YQWiuC/jM?=
 =?us-ascii?Q?aFRXkuR4KTaIOV9lLd3AhhFfjo4C3xKFakXLqW6wADoABix/hKoM1GEu9lH1?=
 =?us-ascii?Q?UffbM/htjDE1LM4qNuK3v7rCMXTY/ywS2blt6eiH8mw6qp8VkL8kXDK3G7+d?=
 =?us-ascii?Q?ZCAldh8+PuQZxKlW6wVj6WpkVfMczSbx+AlIqQ1GEaLlnoqlOgD4TSaqF95i?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 569de58b-8d86-4e55-d18b-08ddfad9b9ed
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 19:45:19.2360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RI2iWUrzC/Ls/62vdzSxkoYcn+D0xMjuSVRkukOHn/yjlOIlw6BNRTbSrZO/7x9gO7QXF0G2omOs/fISCWEOIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7352

The current procedure for power_off() and power_on() is the same as the
one used for major lane reconfiguration, aka halting.

But one would expect that a powered off lane causes the CDR (clock and
data recovery) loop of the link partner to lose lock onto its RX stream
(which suggests there are no longer any bit transitions => the channel
is inactive). However, this does not take place (the CDR lock is still
there), so a halted lane is still active.

Implement the procedure mentioned in the block guide for powering down
a lane, and then back on.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: slight commit message reword

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 78 ++++++++++++++++++------
 1 file changed, 60 insertions(+), 18 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 6f2078721aca..798343b55ec7 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -73,9 +73,11 @@
 
 /* Lane a Tx Reset Control Register */
 #define LNaTRSTCTL(lane)			(0x800 + (lane) * 0x100 + 0x20)
-#define LNaTRSTCTL_HLT_REQ			BIT(27)
-#define LNaTRSTCTL_RST_DONE			BIT(30)
 #define LNaTRSTCTL_RST_REQ			BIT(31)
+#define LNaTRSTCTL_RST_DONE			BIT(30)
+#define LNaTRSTCTL_HLT_REQ			BIT(27)
+#define LNaTRSTCTL_STP_REQ			BIT(26)
+#define LNaTRSTCTL_DIS				BIT(24)
 
 /* Lane a Tx General Control Register */
 #define LNaTGCR0(lane)				(0x800 + (lane) * 0x100 + 0x24)
@@ -102,9 +104,11 @@
 
 /* Lane a Rx Reset Control Register */
 #define LNaRRSTCTL(lane)			(0x800 + (lane) * 0x100 + 0x40)
-#define LNaRRSTCTL_HLT_REQ			BIT(27)
-#define LNaRRSTCTL_RST_DONE			BIT(30)
 #define LNaRRSTCTL_RST_REQ			BIT(31)
+#define LNaRRSTCTL_RST_DONE			BIT(30)
+#define LNaRRSTCTL_HLT_REQ			BIT(27)
+#define LNaRRSTCTL_STP_REQ			BIT(26)
+#define LNaRRSTCTL_DIS				BIT(24)
 #define LNaRRSTCTL_CDR_LOCK			BIT(12)
 
 /* Lane a Rx General Control Register */
@@ -672,14 +676,12 @@ static void lynx_28g_lane_set_pll(struct lynx_28g_lane *lane,
 	}
 }
 
-static int lynx_28g_power_off(struct phy *phy)
+/* Halting puts the lane in a mode in which it can be reconfigured */
+static void lynx_28g_lane_halt(struct phy *phy)
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
 	u32 trstctl, rrstctl;
 
-	if (!lane->powered_up)
-		return 0;
-
 	/* Issue a halt request */
 	lynx_28g_lane_rmw(lane, LNaTRSTCTL, LNaTRSTCTL_HLT_REQ,
 			  LNaTRSTCTL_HLT_REQ);
@@ -692,20 +694,13 @@ static int lynx_28g_power_off(struct phy *phy)
 		rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
 	} while ((trstctl & LNaTRSTCTL_HLT_REQ) ||
 		 (rrstctl & LNaRRSTCTL_HLT_REQ));
-
-	lane->powered_up = false;
-
-	return 0;
 }
 
-static int lynx_28g_power_on(struct phy *phy)
+static void lynx_28g_lane_reset(struct phy *phy)
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
 	u32 trstctl, rrstctl;
 
-	if (lane->powered_up)
-		return 0;
-
 	/* Issue a reset request on the lane */
 	lynx_28g_lane_rmw(lane, LNaTRSTCTL, LNaTRSTCTL_RST_REQ,
 			  LNaTRSTCTL_RST_REQ);
@@ -718,6 +713,52 @@ static int lynx_28g_power_on(struct phy *phy)
 		rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
 	} while (!(trstctl & LNaTRSTCTL_RST_DONE) ||
 		 !(rrstctl & LNaRRSTCTL_RST_DONE));
+}
+
+static int lynx_28g_power_off(struct phy *phy)
+{
+	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
+	u32 trstctl, rrstctl;
+
+	if (!lane->powered_up)
+		return 0;
+
+	/* Issue a stop request */
+	lynx_28g_lane_rmw(lane, LNaTRSTCTL, LNaTRSTCTL_STP_REQ,
+			  LNaTRSTCTL_STP_REQ);
+	lynx_28g_lane_rmw(lane, LNaRRSTCTL, LNaRRSTCTL_STP_REQ,
+			  LNaRRSTCTL_STP_REQ);
+
+	/* Wait until the stop process is complete */
+	do {
+		trstctl = lynx_28g_lane_read(lane, LNaTRSTCTL);
+		rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
+	} while ((trstctl & LNaTRSTCTL_STP_REQ) ||
+		 (rrstctl & LNaRRSTCTL_STP_REQ));
+
+	/* Power down the RX and TX portions of the lane */
+	lynx_28g_lane_rmw(lane, LNaRRSTCTL, LNaRRSTCTL_DIS,
+			  LNaRRSTCTL_DIS);
+	lynx_28g_lane_rmw(lane, LNaTRSTCTL, LNaTRSTCTL_DIS,
+			  LNaTRSTCTL_DIS);
+
+	lane->powered_up = false;
+
+	return 0;
+}
+
+static int lynx_28g_power_on(struct phy *phy)
+{
+	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
+
+	if (lane->powered_up)
+		return 0;
+
+	/* Power up the RX and TX portions of the lane */
+	lynx_28g_lane_rmw(lane, LNaRRSTCTL, 0, LNaRRSTCTL_DIS);
+	lynx_28g_lane_rmw(lane, LNaTRSTCTL, 0, LNaTRSTCTL_DIS);
+
+	lynx_28g_lane_reset(phy);
 
 	lane->powered_up = true;
 
@@ -1132,7 +1173,7 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	 * the reconfiguration is being done.
 	 */
 	if (powered_up)
-		lynx_28g_power_off(phy);
+		lynx_28g_lane_halt(phy);
 
 	err = lynx_28g_lane_disable_pcvt(lane, lane->mode);
 	if (err)
@@ -1145,8 +1186,9 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	lane->mode = lane_mode;
 
 out:
+	/* Reset the lane if necessary */
 	if (powered_up)
-		lynx_28g_power_on(phy);
+		lynx_28g_lane_reset(phy);
 
 	return err;
 }
-- 
2.34.1


