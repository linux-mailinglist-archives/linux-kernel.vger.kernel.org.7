Return-Path: <linux-kernel+bounces-801173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74971B440DD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 306B4A42D62
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3B128003A;
	Thu,  4 Sep 2025 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a1SInVFT"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011062.outbound.protection.outlook.com [40.107.130.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8897D2820D7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757000659; cv=fail; b=F703dGAePKRIKrxQr7ez8i0p04yEq6hqLPile2Tg8YBOAkLadA7Y1mzgax8DCq+Xl4KabCAj/eOMCv4ZpCC1RE2fHbQef8p1MPtVq7MReB5At8LpIELD0/+wqvKlAxwbHbRVCPA221b6I4AyH+sJ/OLUC8Ne0A1kBT5GE9YeeUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757000659; c=relaxed/simple;
	bh=sCel1dvFoPc+oD6nT0wX4NkzZ1YbaWAGY1eQ4bUDUbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G7XeopVTzSFx+lmeEDYvIl+PtV4WH922KVHPxubkRyrOb85FwVtkyqBiN67bW0/jFpqPf3ddLM6V2Y4wvWO0msCGu2+Mb2iw3512GpPloWrGNWQzaWmotp2nUZB/P3yvcmbVVqIuHepKvvW5fczk4RJvcYV9gxwalIm1Smf2wE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a1SInVFT; arc=fail smtp.client-ip=40.107.130.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDcmVfkpd9/RlMx1B+ixbmqcE09qyKIbhVa4hjbpzmiCp4n7OWKAAGjivYt/smjTj72eE51zv+to4unoVkz4qNUYUI7ZV/YVmVLb9IJvWY0gF81q9Vg6v2w6g7f08YMZYnesNRQ+CRDiXRl4vj6n7dVFFKrQSBMmo2KCgCRkUvS7Fxmr2RSsKAfUjS9NouyJy9egCTIlM5T5y+3dKOcmHSZJGYZOKTL1DWUHpaWOqn++BnPvlLHvhslOWL4TSMTiyJUnUS4Phey4lPOgHpdXgETaVfijKOPTRTcnqLD5IMorctvweS+6mNbcxHBYaQEKy9qZ6wq2U0eo8xGIWSsukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mY4s6N6xK0vtLDVxTN4oWgqn1oGYs5JdRwJlhHwBBfk=;
 b=kuFaaYIQYPj5bqU7pWyctaRNGtedMtH6rylpw7ImDoQ9GE5huv5SI6U1RO/ogUjeepr/FxNUUkXfEXZXArVoNMcbP+CwLUECNCqFTMGNqbZuAmr1WhsTb+OynkMLr12bny4Y5cVNLANoHZtvjsJZlI3oDPyDQvw0ab4tqcgMgYEhQPxUbKXEFktiTx2u1JTNTrhYu4ShA91waD6DuS2GZH7iQSE9K3zHe36C/KWKds2HvYlSZBDsstkrwf3uDAEcwnqqz68ywLfVyCaYtF7npzXTO2rpO+tOV171W8Id3BmZOz3M5wbtUY+Gs+o2lKpz05ZtqlDxsVa1O1lHoUDh7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mY4s6N6xK0vtLDVxTN4oWgqn1oGYs5JdRwJlhHwBBfk=;
 b=a1SInVFT19Mxk6nIke/KvBl90J6QicUrjpXOkEbbBqQo0KzavzI7hF0BuqPNNOffyvaV2ezqe13GDdny49Qn6SRe7aGDeMq8/Dl9EBWJcgj1Zzbtgeg5vzVGnY4lPUhY5lwoODTmZhY44zFLZRApD1DBcRPLecJLCAWOSNSb+eUw/gOk8UzgQwcvrLWfGZobH/3plUokMMII10DflDzBW27fgZzuAY7O3seB7wKkiVAtGpYHIU4Vmmi06DgatiyZcJCF0ZHX9Er4B80/mvQsdCauov/N9cxFCUKg5iEZG82cJfWI1nMOlCuFNsgopGbQorReqQ4tQosqnbcXKib46A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM8PR04MB7348.eurprd04.prod.outlook.com (2603:10a6:20b:1db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 15:44:12 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 15:44:12 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH phy 01/14] phy: lynx-28g: remove LYNX_28G_ prefix from register names
Date: Thu,  4 Sep 2025 18:43:49 +0300
Message-Id: <20250904154402.300032-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250904154402.300032-1-vladimir.oltean@nxp.com>
References: <20250904154402.300032-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0060.eurprd03.prod.outlook.com (2603:10a6:208::37)
 To AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM8PR04MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 97ea45a4-379d-45c3-025a-08ddebc9e4ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8x5SBzE/0+urv8N7cCd8MlKJfmqvykzX/ANrjFilLNy+NrnZspnk1Kmhz77p?=
 =?us-ascii?Q?VyqOJ0P/ep4G3Xy6JeRYZAIJG/yxWbd3FAKVkhPXzJyhBR7wr6TCBYaqL7Y5?=
 =?us-ascii?Q?TZYhnnuT1zX4XZnoj6kfkVJKwdprzpabdFuVaQu/2uZiCWKgP0kKGfI8STfL?=
 =?us-ascii?Q?Eq81Jr8RQKT5NqkGhSmFRO7wSIeYAAmKe9oxKYlPeyS/eqkq6jawoYgjM22w?=
 =?us-ascii?Q?MMbymRyrPE9WxM4kdp2PkYL+yp7xhOrGuZ53gQLYC2gm/OUSw/zgJKw97khp?=
 =?us-ascii?Q?jmaExwLfEgPi++r4gv8wMbsuwc25lVIAyJrexuUk13lsxu5mh2rDUt9UEtFE?=
 =?us-ascii?Q?EMjlkkIPzRV39OqG7S6lHngz/KptIYZtqdNVlilYwTeBk6CM8AifFUd3QXvC?=
 =?us-ascii?Q?0PXdNFi/tx3jq5eAy9AkYbmPmnd7Z0do+yTaOkcCTSIhdy1P5BCQCD0tl5B1?=
 =?us-ascii?Q?F+o/tGdU+5JQ1NznJyrHmi4IjK4+DQd29g3UmiVRB9fo8+N9XFdCJZSnoHPN?=
 =?us-ascii?Q?9qG5SFD0Q1iGLLDb9rUDLOL0K3gE6u4FjpT5fLYCNP2YMBp6RLvzFNcMEju+?=
 =?us-ascii?Q?3d4QpMRC1EzjtUu75pSWDbxEf9/9z3P0TvAdPKamsdaVDu4qtTliygKlbeWZ?=
 =?us-ascii?Q?Dz7m0vWR0ONeQKVDau3Lj5BnX0Xp0dKC490AFs1VcdUNxu21Oj4VN2ekGNp5?=
 =?us-ascii?Q?HasQGlWW0SulMb80pmOutVkI0IhXuT3DhkFdwDoRy1hmifqx7puVXFCyp5dU?=
 =?us-ascii?Q?nFCQ7+p68UwzacRCLWRmVsLrJTzbPk4EfMR/yZVVlSBIHR+cBu+sbkpKwPr8?=
 =?us-ascii?Q?+Da1olHtQt1nPqBqlhr7DOrvHmSromwW+lZRt6BK4gsg2DaSdQd+93Xuoo+4?=
 =?us-ascii?Q?CpxGAfQNuylNoZeGGMd+bkOV5meY8A6JW1IXLg71BsvAfRysjI2NivFu+a3+?=
 =?us-ascii?Q?guJfUIYgx4rlUC/UwxsKVtxt7hgMuatnyphxBxbrye9n3umeX5MzVDcj3LT8?=
 =?us-ascii?Q?tBVjiih8atjk6C2cYGDKSrzzKMPg4f/J0o3xyi2Ed5PYLca/EA8jf1jRWCx1?=
 =?us-ascii?Q?pi3n/OQK2EXftgA71u1DnG6Ic2REjKWR4SOJ2xZIUJRoh+8RcanYN2oG4YFt?=
 =?us-ascii?Q?ftoxja4WZ9KSqQan+p8yUU1JSt7ZOYhht8VyXQ8PjeCTf0r8yLqeCcalOHoG?=
 =?us-ascii?Q?Z3wuR7sbU0T5YkK39yUEYZgw1KJ0OAm8w1nVpYYCunDzkTwHwSsw8DEMt8oN?=
 =?us-ascii?Q?fiVidTJGXmUJgDp9sMoFUoYnXXuGmSOwI+Fit5R6L+qXIa6xJs9VwKnAZ6v7?=
 =?us-ascii?Q?nTqn5NwDFDL3NWAniCIW1kRB0YTvK7ok4quGuQfO07siOV6HAyHIK5RGhXwQ?=
 =?us-ascii?Q?2NvK4aeIwfUprGFYe06W5OmX8Y+2qPPzgjyZxIDHJReCoPb/eKtLQM0TlRD9?=
 =?us-ascii?Q?Uz2wp02Qccg7hEsg02Ad+UFR4w8omqn2T6rR9uH+3wWu9ZDuk81WCw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x3WsGy46cFfDCXSIrVFKAmmhF3MFr++FZlHgsTwXrv1OFw3bOHpXSEtHf45H?=
 =?us-ascii?Q?sO+PAXnSkspj+fe2r5MCalCynG7p9vtYNGsNpj7xgdjOHBapSaug/DrDdeZG?=
 =?us-ascii?Q?yB+JrEK8Rn7RZEOEOdOvcFos1laHJhbcvCOF3tyCxZ+jp9Kdtvpkj7qVwKsy?=
 =?us-ascii?Q?nA2HCrC0u3yKM3HqMVqC2w6d225vW0/Tr1nvjQXaTRV/8lyIrK5NTVkCzaoF?=
 =?us-ascii?Q?OqCRYvwiGLr+nz+5B5DF25YHGMjGpmRePQDlgAmW90zpoaxvMphU2iH7RPBX?=
 =?us-ascii?Q?fzAkNkngLgfKIqwoLkxEae2Qx2D2W0+GrsF53LzYtpYuETEY4V+BTRoU1TmT?=
 =?us-ascii?Q?/hzgveCZmfsvbBKhKwSyMLHN22b1Eev7r80EVSTEoOhy5wEL5GRq4zyxDVgu?=
 =?us-ascii?Q?pzU+ryP4jpEcAwm0JyUR47OucIqhmhvcy1cxj+TSozp2ES5Yl7m6IJkTUlhB?=
 =?us-ascii?Q?WlaXxJivszEvtNRot/HIO8bSltBVQi27W6CqRYYGRZ+bbbOoFn2SpTAsOan4?=
 =?us-ascii?Q?7ghBhie2t0k4ddC2AlvMMHAjsxvqXTyoIZauW0Usmsuot8ag9HHJYaPNWTBH?=
 =?us-ascii?Q?x1Hh4GGpFM/WIF8OIgtQ60w02g5qiCFGJOf5HvlQUL4iZaFCQATmDkEsYs7A?=
 =?us-ascii?Q?xNwJLNPc38mniiwrSrVeBRT3e3Unp+KAhBV0lDOaaSk3LjyT4XivEyLQErUe?=
 =?us-ascii?Q?Q83XnAo9wD/3eEAz6P04xiYxyddWPLBwGDSwHmG5dZttBP2+zMbc0bWmX5Gk?=
 =?us-ascii?Q?lySMGOz73CPM7aOzBMfcldtudAlfNTDZuNQRgcD4YaWB08cMBjWIFI0elr5/?=
 =?us-ascii?Q?UJ/mYF+LrqHqe2KnOe+4kNyCchFd57ZxMB76bh368B1fYZlOmzHzI77m0lmT?=
 =?us-ascii?Q?bK1T+b3oM5vLmwu/CX+7lPrXihnLvxOiY1UoOsk3Ve9SEUcs8pRJ3efGwHcN?=
 =?us-ascii?Q?e5elnDHKppnEkPv3UCmtc59mULjEFNRftelSObk+gCB1faBEIqumVXO/Khck?=
 =?us-ascii?Q?gMiZciUoL5R7yyVXf/BFsEBi8hodGjX1NBkbrWtqF9/XKqHXrq1XtVqAJwlc?=
 =?us-ascii?Q?rlvvmtbWcR13dXXR6iDyyO8Y7swkGXkoQmN7JzyWvP5xcQl27/aEhV9ggVtG?=
 =?us-ascii?Q?3pav6eCp20T9/lt8GOs8B/iAJw+NF8I6z4xuj5q6SvgfXhs2kfg9kmfJS50/?=
 =?us-ascii?Q?I5kfGtikY7ZIWDLsdodlvHUgu4jTNYvQDzsnn7ZGeC5hXvcKjmFeNw7SSFSz?=
 =?us-ascii?Q?8EgsWTQXZvQZVChixFIcCMg8RC/uFCgF4UNhDc0Hg1Ia06VUmjV+HRHwTtH4?=
 =?us-ascii?Q?wkpvp9/9ZTwPc6qywdV272AuAVuAQVakUbFb6+CPh5awuc1XMiiyRZZAmHgL?=
 =?us-ascii?Q?ZMFHWBTJhBZXNtmd8yGhTCl+AqhaZBRnHeAYoIWfe19raUJygqeAxf9Pn9V3?=
 =?us-ascii?Q?iXsGsqsOh0I2EFiNHGjomDt7olHdetHvcoVzR74Bv7SlZMoIdxdZaaE4nTCM?=
 =?us-ascii?Q?WWpk2fJCVvhPFqwr5ZJN0XxivQssgh2gFWf2VrwXlGsv6VHzGOuWfsv3+ELA?=
 =?us-ascii?Q?ZtbCJ3Rfi1Eth0X7pdqkNJFxiv5MJN/e5tHhZhFfzftBOqcesOtkeA0EobsT?=
 =?us-ascii?Q?1g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ea45a4-379d-45c3-025a-08ddebc9e4ff
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 15:44:12.1821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a6IupkO0mo1mbhBOokLWZyxj6I2DjZ/yzWY1MJC8KI4Kfn52by9xNYwT5OmN2aHdw/zKlwXWiks0IINRCYyJEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7348

Currently, in macros such as lynx_28g_lane_rmw(), the driver has
macros which concatenate the LYNX_28G_ prefix with the "val" and "mask"
arguments. This is done to shorten function calls and not have to spell
out LYNX_28G_ everywhere.

But outside of lynx_28g_lane_rmw(), lynx_28g_lane_read() and
lynx_28g_pll_read(), this is not done, leading to an inconsistency in
the code.

Also, the concatenation itself has the disadvantage that searching the
arguments of these functions as full words (like N_RATE_QUARTER) leads
us nowhere, since the real macro definition is LNaTGCR0_N_RATE_QUARTER.

Some maintainers want register definitions in drivers to contain the
driver name as a prefix, but here, this has the disadvantages listed
above, so just remove that prefix.

The only change made here is the removal of LYNX_28G_.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/phy/freescale/phy-fsl-lynx-28g.c | 248 +++++++++++------------
 1 file changed, 124 insertions(+), 124 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index c20d2636c5e9..4e8d2c56d702 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -12,99 +12,99 @@
 #define LYNX_28G_NUM_PLL			2
 
 /* General registers per SerDes block */
-#define LYNX_28G_PCC8				0x10a0
-#define LYNX_28G_PCC8_SGMII			0x1
-#define LYNX_28G_PCC8_SGMII_DIS			0x0
+#define PCC8					0x10a0
+#define PCC8_SGMII				0x1
+#define PCC8_SGMII_DIS				0x0
 
-#define LYNX_28G_PCCC				0x10b0
-#define LYNX_28G_PCCC_10GBASER			0x9
-#define LYNX_28G_PCCC_USXGMII			0x1
-#define LYNX_28G_PCCC_SXGMII_DIS		0x0
+#define PCCC					0x10b0
+#define PCCC_10GBASER				0x9
+#define PCCC_USXGMII				0x1
+#define PCCC_SXGMII_DIS				0x0
 
-#define LYNX_28G_LNa_PCC_OFFSET(lane)		(4 * (LYNX_28G_NUM_LANE - (lane->id) - 1))
+#define LNa_PCC_OFFSET(lane)			(4 * (LYNX_28G_NUM_LANE - (lane->id) - 1))
 
 /* Per PLL registers */
-#define LYNX_28G_PLLnRSTCTL(pll)		(0x400 + (pll) * 0x100 + 0x0)
-#define LYNX_28G_PLLnRSTCTL_DIS(rstctl)		(((rstctl) & BIT(24)) >> 24)
-#define LYNX_28G_PLLnRSTCTL_LOCK(rstctl)	(((rstctl) & BIT(23)) >> 23)
-
-#define LYNX_28G_PLLnCR0(pll)			(0x400 + (pll) * 0x100 + 0x4)
-#define LYNX_28G_PLLnCR0_REFCLK_SEL(cr0)	(((cr0) & GENMASK(20, 16)))
-#define LYNX_28G_PLLnCR0_REFCLK_SEL_100MHZ	0x0
-#define LYNX_28G_PLLnCR0_REFCLK_SEL_125MHZ	0x10000
-#define LYNX_28G_PLLnCR0_REFCLK_SEL_156MHZ	0x20000
-#define LYNX_28G_PLLnCR0_REFCLK_SEL_150MHZ	0x30000
-#define LYNX_28G_PLLnCR0_REFCLK_SEL_161MHZ	0x40000
-
-#define LYNX_28G_PLLnCR1(pll)			(0x400 + (pll) * 0x100 + 0x8)
-#define LYNX_28G_PLLnCR1_FRATE_SEL(cr1)		(((cr1) & GENMASK(28, 24)))
-#define LYNX_28G_PLLnCR1_FRATE_5G_10GVCO	0x0
-#define LYNX_28G_PLLnCR1_FRATE_5G_25GVCO	0x10000000
-#define LYNX_28G_PLLnCR1_FRATE_10G_20GVCO	0x6000000
+#define PLLnRSTCTL(pll)				(0x400 + (pll) * 0x100 + 0x0)
+#define PLLnRSTCTL_DIS(rstctl)			(((rstctl) & BIT(24)) >> 24)
+#define PLLnRSTCTL_LOCK(rstctl)			(((rstctl) & BIT(23)) >> 23)
+
+#define PLLnCR0(pll)				(0x400 + (pll) * 0x100 + 0x4)
+#define PLLnCR0_REFCLK_SEL(cr0)			(((cr0) & GENMASK(20, 16)))
+#define PLLnCR0_REFCLK_SEL_100MHZ		0x0
+#define PLLnCR0_REFCLK_SEL_125MHZ		0x10000
+#define PLLnCR0_REFCLK_SEL_156MHZ		0x20000
+#define PLLnCR0_REFCLK_SEL_150MHZ		0x30000
+#define PLLnCR0_REFCLK_SEL_161MHZ		0x40000
+
+#define PLLnCR1(pll)				(0x400 + (pll) * 0x100 + 0x8)
+#define PLLnCR1_FRATE_SEL(cr1)			(((cr1) & GENMASK(28, 24)))
+#define PLLnCR1_FRATE_5G_10GVCO			0x0
+#define PLLnCR1_FRATE_5G_25GVCO			0x10000000
+#define PLLnCR1_FRATE_10G_20GVCO		0x6000000
 
 /* Per SerDes lane registers */
 /* Lane a General Control Register */
-#define LYNX_28G_LNaGCR0(lane)			(0x800 + (lane) * 0x100 + 0x0)
-#define LYNX_28G_LNaGCR0_PROTO_SEL_MSK		GENMASK(7, 3)
-#define LYNX_28G_LNaGCR0_PROTO_SEL_SGMII	0x8
-#define LYNX_28G_LNaGCR0_PROTO_SEL_XFI		0x50
-#define LYNX_28G_LNaGCR0_IF_WIDTH_MSK		GENMASK(2, 0)
-#define LYNX_28G_LNaGCR0_IF_WIDTH_10_BIT	0x0
-#define LYNX_28G_LNaGCR0_IF_WIDTH_20_BIT	0x2
+#define LNaGCR0(lane)				(0x800 + (lane) * 0x100 + 0x0)
+#define LNaGCR0_PROTO_SEL_MSK			GENMASK(7, 3)
+#define LNaGCR0_PROTO_SEL_SGMII			0x8
+#define LNaGCR0_PROTO_SEL_XFI			0x50
+#define LNaGCR0_IF_WIDTH_MSK			GENMASK(2, 0)
+#define LNaGCR0_IF_WIDTH_10_BIT			0x0
+#define LNaGCR0_IF_WIDTH_20_BIT			0x2
 
 /* Lane a Tx Reset Control Register */
-#define LYNX_28G_LNaTRSTCTL(lane)		(0x800 + (lane) * 0x100 + 0x20)
-#define LYNX_28G_LNaTRSTCTL_HLT_REQ		BIT(27)
-#define LYNX_28G_LNaTRSTCTL_RST_DONE		BIT(30)
-#define LYNX_28G_LNaTRSTCTL_RST_REQ		BIT(31)
+#define LNaTRSTCTL(lane)			(0x800 + (lane) * 0x100 + 0x20)
+#define LNaTRSTCTL_HLT_REQ			BIT(27)
+#define LNaTRSTCTL_RST_DONE			BIT(30)
+#define LNaTRSTCTL_RST_REQ			BIT(31)
 
 /* Lane a Tx General Control Register */
-#define LYNX_28G_LNaTGCR0(lane)			(0x800 + (lane) * 0x100 + 0x24)
-#define LYNX_28G_LNaTGCR0_USE_PLLF		0x0
-#define LYNX_28G_LNaTGCR0_USE_PLLS		BIT(28)
-#define LYNX_28G_LNaTGCR0_USE_PLL_MSK		BIT(28)
-#define LYNX_28G_LNaTGCR0_N_RATE_FULL		0x0
-#define LYNX_28G_LNaTGCR0_N_RATE_HALF		0x1000000
-#define LYNX_28G_LNaTGCR0_N_RATE_QUARTER	0x2000000
-#define LYNX_28G_LNaTGCR0_N_RATE_MSK		GENMASK(26, 24)
+#define LNaTGCR0(lane)				(0x800 + (lane) * 0x100 + 0x24)
+#define LNaTGCR0_USE_PLLF			0x0
+#define LNaTGCR0_USE_PLLS			BIT(28)
+#define LNaTGCR0_USE_PLL_MSK			BIT(28)
+#define LNaTGCR0_N_RATE_FULL			0x0
+#define LNaTGCR0_N_RATE_HALF			0x1000000
+#define LNaTGCR0_N_RATE_QUARTER			0x2000000
+#define LNaTGCR0_N_RATE_MSK			GENMASK(26, 24)
 
-#define LYNX_28G_LNaTECR0(lane)			(0x800 + (lane) * 0x100 + 0x30)
+#define LNaTECR0(lane)				(0x800 + (lane) * 0x100 + 0x30)
 
 /* Lane a Rx Reset Control Register */
-#define LYNX_28G_LNaRRSTCTL(lane)		(0x800 + (lane) * 0x100 + 0x40)
-#define LYNX_28G_LNaRRSTCTL_HLT_REQ		BIT(27)
-#define LYNX_28G_LNaRRSTCTL_RST_DONE		BIT(30)
-#define LYNX_28G_LNaRRSTCTL_RST_REQ		BIT(31)
-#define LYNX_28G_LNaRRSTCTL_CDR_LOCK		BIT(12)
+#define LNaRRSTCTL(lane)			(0x800 + (lane) * 0x100 + 0x40)
+#define LNaRRSTCTL_HLT_REQ			BIT(27)
+#define LNaRRSTCTL_RST_DONE			BIT(30)
+#define LNaRRSTCTL_RST_REQ			BIT(31)
+#define LNaRRSTCTL_CDR_LOCK			BIT(12)
 
 /* Lane a Rx General Control Register */
-#define LYNX_28G_LNaRGCR0(lane)			(0x800 + (lane) * 0x100 + 0x44)
-#define LYNX_28G_LNaRGCR0_USE_PLLF		0x0
-#define LYNX_28G_LNaRGCR0_USE_PLLS		BIT(28)
-#define LYNX_28G_LNaRGCR0_USE_PLL_MSK		BIT(28)
-#define LYNX_28G_LNaRGCR0_N_RATE_MSK		GENMASK(26, 24)
-#define LYNX_28G_LNaRGCR0_N_RATE_FULL		0x0
-#define LYNX_28G_LNaRGCR0_N_RATE_HALF		0x1000000
-#define LYNX_28G_LNaRGCR0_N_RATE_QUARTER	0x2000000
-#define LYNX_28G_LNaRGCR0_N_RATE_MSK		GENMASK(26, 24)
-
-#define LYNX_28G_LNaRGCR1(lane)			(0x800 + (lane) * 0x100 + 0x48)
-
-#define LYNX_28G_LNaRECR0(lane)			(0x800 + (lane) * 0x100 + 0x50)
-#define LYNX_28G_LNaRECR1(lane)			(0x800 + (lane) * 0x100 + 0x54)
-#define LYNX_28G_LNaRECR2(lane)			(0x800 + (lane) * 0x100 + 0x58)
-
-#define LYNX_28G_LNaRSCCR0(lane)		(0x800 + (lane) * 0x100 + 0x74)
-
-#define LYNX_28G_LNaPSS(lane)			(0x1000 + (lane) * 0x4)
-#define LYNX_28G_LNaPSS_TYPE(pss)		(((pss) & GENMASK(30, 24)) >> 24)
-#define LYNX_28G_LNaPSS_TYPE_SGMII		0x4
-#define LYNX_28G_LNaPSS_TYPE_XFI		0x28
-
-#define LYNX_28G_SGMIIaCR1(lane)		(0x1804 + (lane) * 0x10)
-#define LYNX_28G_SGMIIaCR1_SGPCS_EN		BIT(11)
-#define LYNX_28G_SGMIIaCR1_SGPCS_DIS		0x0
-#define LYNX_28G_SGMIIaCR1_SGPCS_MSK		BIT(11)
+#define LNaRGCR0(lane)				(0x800 + (lane) * 0x100 + 0x44)
+#define LNaRGCR0_USE_PLLF			0x0
+#define LNaRGCR0_USE_PLLS			BIT(28)
+#define LNaRGCR0_USE_PLL_MSK			BIT(28)
+#define LNaRGCR0_N_RATE_MSK			GENMASK(26, 24)
+#define LNaRGCR0_N_RATE_FULL			0x0
+#define LNaRGCR0_N_RATE_HALF			0x1000000
+#define LNaRGCR0_N_RATE_QUARTER			0x2000000
+#define LNaRGCR0_N_RATE_MSK			GENMASK(26, 24)
+
+#define LNaRGCR1(lane)				(0x800 + (lane) * 0x100 + 0x48)
+
+#define LNaRECR0(lane)				(0x800 + (lane) * 0x100 + 0x50)
+#define LNaRECR1(lane)				(0x800 + (lane) * 0x100 + 0x54)
+#define LNaRECR2(lane)				(0x800 + (lane) * 0x100 + 0x58)
+
+#define LNaRSCCR0(lane)				(0x800 + (lane) * 0x100 + 0x74)
+
+#define LNaPSS(lane)				(0x1000 + (lane) * 0x4)
+#define LNaPSS_TYPE(pss)			(((pss) & GENMASK(30, 24)) >> 24)
+#define LNaPSS_TYPE_SGMII			0x4
+#define LNaPSS_TYPE_XFI				0x28
+
+#define SGMIIaCR1(lane)				(0x1804 + (lane) * 0x10)
+#define SGMIIaCR1_SGPCS_EN			BIT(11)
+#define SGMIIaCR1_SGPCS_DIS			0x0
+#define SGMIIaCR1_SGPCS_MSK			BIT(11)
 
 struct lynx_28g_priv;
 
@@ -150,19 +150,19 @@ static void lynx_28g_rmw(struct lynx_28g_priv *priv, unsigned long off,
 }
 
 #define lynx_28g_lane_rmw(lane, reg, val, mask)	\
-	lynx_28g_rmw((lane)->priv, LYNX_28G_##reg(lane->id), \
-		     LYNX_28G_##reg##_##val, LYNX_28G_##reg##_##mask)
+	lynx_28g_rmw((lane)->priv, reg(lane->id), \
+		     reg##_##val, reg##_##mask)
 #define lynx_28g_lane_read(lane, reg)			\
-	ioread32((lane)->priv->base + LYNX_28G_##reg((lane)->id))
+	ioread32((lane)->priv->base + reg((lane)->id))
 #define lynx_28g_pll_read(pll, reg)			\
-	ioread32((pll)->priv->base + LYNX_28G_##reg((pll)->id))
+	ioread32((pll)->priv->base + reg((pll)->id))
 
 static bool lynx_28g_supports_interface(struct lynx_28g_priv *priv, int intf)
 {
 	int i;
 
 	for (i = 0; i < LYNX_28G_NUM_PLL; i++) {
-		if (LYNX_28G_PLLnRSTCTL_DIS(priv->pll[i].rstctl))
+		if (PLLnRSTCTL_DIS(priv->pll[i].rstctl))
 			continue;
 
 		if (test_bit(intf, priv->pll[i].supported))
@@ -181,7 +181,7 @@ static struct lynx_28g_pll *lynx_28g_pll_get(struct lynx_28g_priv *priv,
 	for (i = 0; i < LYNX_28G_NUM_PLL; i++) {
 		pll = &priv->pll[i];
 
-		if (LYNX_28G_PLLnRSTCTL_DIS(pll->rstctl))
+		if (PLLnRSTCTL_DIS(pll->rstctl))
 			continue;
 
 		if (test_bit(intf, pll->supported))
@@ -199,9 +199,9 @@ static void lynx_28g_lane_set_nrate(struct lynx_28g_lane *lane,
 				    struct lynx_28g_pll *pll,
 				    phy_interface_t intf)
 {
-	switch (LYNX_28G_PLLnCR1_FRATE_SEL(pll->cr1)) {
-	case LYNX_28G_PLLnCR1_FRATE_5G_10GVCO:
-	case LYNX_28G_PLLnCR1_FRATE_5G_25GVCO:
+	switch (PLLnCR1_FRATE_SEL(pll->cr1)) {
+	case PLLnCR1_FRATE_5G_10GVCO:
+	case PLLnCR1_FRATE_5G_25GVCO:
 		switch (intf) {
 		case PHY_INTERFACE_MODE_SGMII:
 		case PHY_INTERFACE_MODE_1000BASEX:
@@ -212,7 +212,7 @@ static void lynx_28g_lane_set_nrate(struct lynx_28g_lane *lane,
 			break;
 		}
 		break;
-	case LYNX_28G_PLLnCR1_FRATE_10G_20GVCO:
+	case PLLnCR1_FRATE_10G_20GVCO:
 		switch (intf) {
 		case PHY_INTERFACE_MODE_10GBASER:
 		case PHY_INTERFACE_MODE_USXGMII:
@@ -242,20 +242,20 @@ static void lynx_28g_lane_set_pll(struct lynx_28g_lane *lane,
 
 static void lynx_28g_cleanup_lane(struct lynx_28g_lane *lane)
 {
-	u32 lane_offset = LYNX_28G_LNa_PCC_OFFSET(lane);
 	struct lynx_28g_priv *priv = lane->priv;
+	u32 lane_offset = LNa_PCC_OFFSET(lane);
 
 	/* Cleanup the protocol configuration registers of the current protocol */
 	switch (lane->interface) {
 	case PHY_INTERFACE_MODE_10GBASER:
-		lynx_28g_rmw(priv, LYNX_28G_PCCC,
-			     LYNX_28G_PCCC_SXGMII_DIS << lane_offset,
+		lynx_28g_rmw(priv, PCCC,
+			     PCCC_SXGMII_DIS << lane_offset,
 			     GENMASK(3, 0) << lane_offset);
 		break;
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_1000BASEX:
-		lynx_28g_rmw(priv, LYNX_28G_PCC8,
-			     LYNX_28G_PCC8_SGMII_DIS << lane_offset,
+		lynx_28g_rmw(priv, PCC8,
+			     PCC8_SGMII_DIS << lane_offset,
 			     GENMASK(3, 0) << lane_offset);
 		break;
 	default:
@@ -265,15 +265,15 @@ static void lynx_28g_cleanup_lane(struct lynx_28g_lane *lane)
 
 static void lynx_28g_lane_set_sgmii(struct lynx_28g_lane *lane)
 {
-	u32 lane_offset = LYNX_28G_LNa_PCC_OFFSET(lane);
+	u32 lane_offset = LNa_PCC_OFFSET(lane);
 	struct lynx_28g_priv *priv = lane->priv;
 	struct lynx_28g_pll *pll;
 
 	lynx_28g_cleanup_lane(lane);
 
 	/* Setup the lane to run in SGMII */
-	lynx_28g_rmw(priv, LYNX_28G_PCC8,
-		     LYNX_28G_PCC8_SGMII << lane_offset,
+	lynx_28g_rmw(priv, PCC8,
+		     PCC8_SGMII << lane_offset,
 		     GENMASK(3, 0) << lane_offset);
 
 	/* Setup the protocol select and SerDes parallel interface width */
@@ -295,25 +295,25 @@ static void lynx_28g_lane_set_sgmii(struct lynx_28g_lane *lane)
 	lynx_28g_lane_rmw(lane, SGMIIaCR1, SGPCS_EN, SGPCS_MSK);
 
 	/* Configure the appropriate equalization parameters for the protocol */
-	iowrite32(0x00808006, priv->base + LYNX_28G_LNaTECR0(lane->id));
-	iowrite32(0x04310000, priv->base + LYNX_28G_LNaRGCR1(lane->id));
-	iowrite32(0x9f800000, priv->base + LYNX_28G_LNaRECR0(lane->id));
-	iowrite32(0x001f0000, priv->base + LYNX_28G_LNaRECR1(lane->id));
-	iowrite32(0x00000000, priv->base + LYNX_28G_LNaRECR2(lane->id));
-	iowrite32(0x00000000, priv->base + LYNX_28G_LNaRSCCR0(lane->id));
+	iowrite32(0x00808006, priv->base + LNaTECR0(lane->id));
+	iowrite32(0x04310000, priv->base + LNaRGCR1(lane->id));
+	iowrite32(0x9f800000, priv->base + LNaRECR0(lane->id));
+	iowrite32(0x001f0000, priv->base + LNaRECR1(lane->id));
+	iowrite32(0x00000000, priv->base + LNaRECR2(lane->id));
+	iowrite32(0x00000000, priv->base + LNaRSCCR0(lane->id));
 }
 
 static void lynx_28g_lane_set_10gbaser(struct lynx_28g_lane *lane)
 {
-	u32 lane_offset = LYNX_28G_LNa_PCC_OFFSET(lane);
 	struct lynx_28g_priv *priv = lane->priv;
+	u32 lane_offset = LNa_PCC_OFFSET(lane);
 	struct lynx_28g_pll *pll;
 
 	lynx_28g_cleanup_lane(lane);
 
 	/* Enable the SXGMII lane */
-	lynx_28g_rmw(priv, LYNX_28G_PCCC,
-		     LYNX_28G_PCCC_10GBASER << lane_offset,
+	lynx_28g_rmw(priv, PCCC,
+		     PCCC_10GBASER << lane_offset,
 		     GENMASK(3, 0) << lane_offset);
 
 	/* Setup the protocol select and SerDes parallel interface width */
@@ -335,12 +335,12 @@ static void lynx_28g_lane_set_10gbaser(struct lynx_28g_lane *lane)
 	lynx_28g_lane_rmw(lane, SGMIIaCR1, SGPCS_DIS, SGPCS_MSK);
 
 	/* Configure the appropriate equalization parameters for the protocol */
-	iowrite32(0x10808307, priv->base + LYNX_28G_LNaTECR0(lane->id));
-	iowrite32(0x10000000, priv->base + LYNX_28G_LNaRGCR1(lane->id));
-	iowrite32(0x00000000, priv->base + LYNX_28G_LNaRECR0(lane->id));
-	iowrite32(0x001f0000, priv->base + LYNX_28G_LNaRECR1(lane->id));
-	iowrite32(0x81000020, priv->base + LYNX_28G_LNaRECR2(lane->id));
-	iowrite32(0x00002000, priv->base + LYNX_28G_LNaRSCCR0(lane->id));
+	iowrite32(0x10808307, priv->base + LNaTECR0(lane->id));
+	iowrite32(0x10000000, priv->base + LNaRGCR1(lane->id));
+	iowrite32(0x00000000, priv->base + LNaRECR0(lane->id));
+	iowrite32(0x001f0000, priv->base + LNaRECR1(lane->id));
+	iowrite32(0x81000020, priv->base + LNaRECR2(lane->id));
+	iowrite32(0x00002000, priv->base + LNaRSCCR0(lane->id));
 }
 
 static int lynx_28g_power_off(struct phy *phy)
@@ -359,8 +359,8 @@ static int lynx_28g_power_off(struct phy *phy)
 	do {
 		trstctl = lynx_28g_lane_read(lane, LNaTRSTCTL);
 		rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
-	} while ((trstctl & LYNX_28G_LNaTRSTCTL_HLT_REQ) ||
-		 (rrstctl & LYNX_28G_LNaRRSTCTL_HLT_REQ));
+	} while ((trstctl & LNaTRSTCTL_HLT_REQ) ||
+		 (rrstctl & LNaRRSTCTL_HLT_REQ));
 
 	lane->powered_up = false;
 
@@ -383,8 +383,8 @@ static int lynx_28g_power_on(struct phy *phy)
 	do {
 		trstctl = lynx_28g_lane_read(lane, LNaTRSTCTL);
 		rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
-	} while (!(trstctl & LYNX_28G_LNaTRSTCTL_RST_DONE) ||
-		 !(rrstctl & LYNX_28G_LNaRRSTCTL_RST_DONE));
+	} while (!(trstctl & LNaTRSTCTL_RST_DONE) ||
+		 !(rrstctl & LNaRRSTCTL_RST_DONE));
 
 	lane->powered_up = true;
 
@@ -495,17 +495,17 @@ static void lynx_28g_pll_read_configuration(struct lynx_28g_priv *priv)
 		pll->cr0 = lynx_28g_pll_read(pll, PLLnCR0);
 		pll->cr1 = lynx_28g_pll_read(pll, PLLnCR1);
 
-		if (LYNX_28G_PLLnRSTCTL_DIS(pll->rstctl))
+		if (PLLnRSTCTL_DIS(pll->rstctl))
 			continue;
 
-		switch (LYNX_28G_PLLnCR1_FRATE_SEL(pll->cr1)) {
-		case LYNX_28G_PLLnCR1_FRATE_5G_10GVCO:
-		case LYNX_28G_PLLnCR1_FRATE_5G_25GVCO:
+		switch (PLLnCR1_FRATE_SEL(pll->cr1)) {
+		case PLLnCR1_FRATE_5G_10GVCO:
+		case PLLnCR1_FRATE_5G_25GVCO:
 			/* 5GHz clock net */
 			__set_bit(PHY_INTERFACE_MODE_1000BASEX, pll->supported);
 			__set_bit(PHY_INTERFACE_MODE_SGMII, pll->supported);
 			break;
-		case LYNX_28G_PLLnCR1_FRATE_10G_20GVCO:
+		case PLLnCR1_FRATE_10G_20GVCO:
 			/* 10.3125GHz clock net */
 			__set_bit(PHY_INTERFACE_MODE_10GBASER, pll->supported);
 			break;
@@ -536,11 +536,11 @@ static void lynx_28g_cdr_lock_check(struct work_struct *work)
 		}
 
 		rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
-		if (!(rrstctl & LYNX_28G_LNaRRSTCTL_CDR_LOCK)) {
+		if (!(rrstctl & LNaRRSTCTL_CDR_LOCK)) {
 			lynx_28g_lane_rmw(lane, LNaRRSTCTL, RST_REQ, RST_REQ);
 			do {
 				rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
-			} while (!(rrstctl & LYNX_28G_LNaRRSTCTL_RST_DONE));
+			} while (!(rrstctl & LNaRRSTCTL_RST_DONE));
 		}
 
 		mutex_unlock(&lane->phy->mutex);
@@ -554,12 +554,12 @@ static void lynx_28g_lane_read_configuration(struct lynx_28g_lane *lane)
 	u32 pss, protocol;
 
 	pss = lynx_28g_lane_read(lane, LNaPSS);
-	protocol = LYNX_28G_LNaPSS_TYPE(pss);
+	protocol = LNaPSS_TYPE(pss);
 	switch (protocol) {
-	case LYNX_28G_LNaPSS_TYPE_SGMII:
+	case LNaPSS_TYPE_SGMII:
 		lane->interface = PHY_INTERFACE_MODE_SGMII;
 		break;
-	case LYNX_28G_LNaPSS_TYPE_XFI:
+	case LNaPSS_TYPE_XFI:
 		lane->interface = PHY_INTERFACE_MODE_10GBASER;
 		break;
 	default:
-- 
2.34.1


