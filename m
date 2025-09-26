Return-Path: <linux-kernel+bounces-834507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB62BA4D64
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9FDA5634CC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F120F30F94B;
	Fri, 26 Sep 2025 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TDH2e2DQ"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013068.outbound.protection.outlook.com [40.107.162.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F0930EF9E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909944; cv=fail; b=Dmaqb6BM3xWjiTNW4DTMtNFCL/qtWnA5lW9kzkOyVw6KyEsNTqDkmbtMG39/dq4vnEqnipJoAiIf/zWX2tDkhvVJBzmoyjUX1a/VEtEvLfofPlCLCwIELBHhcOICHAMNoGqoTaYybHEfTsaypvpLarcc4CzILtKOTsu8KD+P39k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909944; c=relaxed/simple;
	bh=QviGtzZ+2AoIAXkI1K93TC8/jGcIfN8m8iL+skdEPeU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A9MUxNm/Gbe2PWJC6z2bQ31iftEhcVDNkDHkUasLUVVtH4HBTK0aUrH9FDZl94Uq5U7wa+t1fyl+sLgdatYsg7AkU8KnIyz6kLqeabJgBdax4RfAl6h+LIiewUMIcChGnxehMYqzk9nSPMnBXFAhWj5pDikFyipClji/XLAvk88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TDH2e2DQ; arc=fail smtp.client-ip=40.107.162.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urA2aBL4sKNHXz5ntxdLK9Tsn+o7bzI4YbIzO43MVgi6XoZQ4V4hkT0+UY+Dc8f5LX1HreqosjPMXCBVQo++/VKnX9R1hRGAtSPkpuUFNr32ijb9vsxdylxs00DaWRT5Lc9lcXtiOVYBJwmbasNaD1Ykud5pmFAzzzKgqm32uulTMmXkG9FDOGJWaYmQvrS3ralbOQxxIK4/Vx7oZIu1w+P/IG13HPeA2f7bs0J3/duzyKfmLCiXRtS4FZfZLPHX6cNxVijDgEMOcGwR6nyVRIywJlbAvTIReVVGirCCVobTPe9i9sNXtVVnYQ7rh5qjt5LGmty2X5Y/BEnoc0jJPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpm5PhLO/JfnIQI6/my72jyY+2fdfduUGEhn2eU9Tco=;
 b=Fgcg5TkppjLZtcjUB1DcMVgCO2rHvhscjuo2SzH2EsmNtbK9dRe31dXL0oVGI2o8uKZPyAjlu4vGyAoFz380DlrEyog3UNjsBmOw+10Jr2JiYrSp9IBa7OKKBwLdZqhQKaeCU9jlw9PgPjV0kQeR900L5B0FJyhm2SPg+cbg3XXfOy7zv6jz8riloI1i8gy/Qo8rhdMNJPvlEDZGiHiNpNS4n78jYc37FC30bV6k6dS+Odng6huFa05ZNvPMcLgVUPCsfRcWGdDjZuuZG5J38NKjXWMSUcCLJyKqMH6suvKPJV/00OaHmCIKWLqFo/e2stphbDoVjI9f35IHAPiWUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpm5PhLO/JfnIQI6/my72jyY+2fdfduUGEhn2eU9Tco=;
 b=TDH2e2DQMV7L3h1o/YD5Nb7qWZ0cG8yQ1DOLD7OTAYtjG0+YyIIhMWHXZ7bWjG7zyqjQMefv3qNLFdjTRr1IOwluX20G1gxvWk0Ec+LNIKHiBwd0tVAQFSDlX8FIamUA5j3X52+FTXS+zQZUYGuvXu0Qkyzwza+hlJJiHmxvTXcYu9myhSftWe07VGwgR8rY6ZExw3izRz81Cp+eAgx5xD0nGI3IdqXw5anFDzrI2EjnCPgPsxinF0kdHUyg0vvbY5PWOukixglPW25clhLcy52G7mk8jkVJpYN6wBfaO4ZUDH52nvhMUWkQOovDFVv74T9UD2YzmEPJDNvMq+LF5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB7823.eurprd04.prod.outlook.com (2603:10a6:102:c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.14; Fri, 26 Sep
 2025 18:05:34 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 18:05:34 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 phy 15/17] phy: lynx-28g: use timeouts when waiting for lane halt and reset
Date: Fri, 26 Sep 2025 21:05:03 +0300
Message-Id: <20250926180505.760089-16-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926180505.760089-1-vladimir.oltean@nxp.com>
References: <20250926180505.760089-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0008.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::9) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 232e29d0-24e5-466e-2c6b-08ddfd2749f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HwVAuH5pTEqA8voBFg/BNWHa2uXKGFYBDZffaZywYUeUlMNQJL85wGZv7sPZ?=
 =?us-ascii?Q?Q8Tn6RGlpbOb2BMXPrfuen7Zcr/uSV2fsRXmpZm650YvFc3Bw8i7gnjFyEGy?=
 =?us-ascii?Q?b9D4bgnU3BuMbtceo0glKEAofZ2f+j9zHkGpsOksoaUvFb7+VkpE4HoNKadx?=
 =?us-ascii?Q?QcQhYIG9+sny0BjwOcGWu51SAyMRPxZwsI47CLAlVjKJaP7m5CK2Clu78K5R?=
 =?us-ascii?Q?p5zsdXQO8W5nRRJsNdI/B8M9AlvxPZj9KFF0+BopXza6Wjz1yDxz9pnpbnSM?=
 =?us-ascii?Q?idkAA05l10kuzHEjYov1PEJJA0hN7PvnGnvzhwSKF9/J7qZucAKf5zBpdaqM?=
 =?us-ascii?Q?KGRB/Inhd37Xpq/D8UMjoospUHjJa9o3X1/R94ZbVjN3yKtFQhplLl5Fd90m?=
 =?us-ascii?Q?m1wZCOUb25j5U7hKHMCq4jgXfnJ1zpNYGlm60bFvaM7LmV85RIAvCuLguvo6?=
 =?us-ascii?Q?LAs5tKK9we4YGh2XqAsTjFo9xtYskw1O0Fg1kfmVAZ8nUDKlfoq9N6jJWeev?=
 =?us-ascii?Q?3u1T8dLsl9q0muE0peUN/CahWK7Q3H3CT1X54YTZnbzNTJAADZ8KAseozM9b?=
 =?us-ascii?Q?kRINWiSrD5nGxDuKl88pQj1UuPuKQEPHAC6zMeMpO5c7QSEquqy60T4q6Lov?=
 =?us-ascii?Q?AimVeM9lDzXal2iCRqW/SwI5iH6bzRdNh+v5JbiZ0ev7eiJUViX6syRZbao8?=
 =?us-ascii?Q?NpbG1VouJrEXt60TH+JNMTkROIk27sQO++11vX2OMIzkTn7xNnO57SrblITP?=
 =?us-ascii?Q?FgD6wikEgyxGaZn0Acdm2bxlvX2JODtqHxwH18EP7HEtjDkc0TJB9FM6oL2B?=
 =?us-ascii?Q?JdHo2/XpBi5vTCX/+GgibMPXegFhNb6qRDesyzQ57Kx8488oQe50QghkHT86?=
 =?us-ascii?Q?KP613Yijno+WZIXr9kZ+bbPaeGTugppDjIfCG5KFhSKb90pOfnC2o6tIDGBu?=
 =?us-ascii?Q?8Xmq3kWonTsZp42qx+urVmJ3fS9EqPJ78xLBP/PC95tagAyKxiAxLsqKphVW?=
 =?us-ascii?Q?Mrj2En7c7Ei4gN0dsjq3bko7NFYilrpu9ZdgR2IksQRCGwgmHS3nXFiKVkCB?=
 =?us-ascii?Q?ikWWj8cQKz6NgMkURB8MEdNCm846soaqDfNGDaDUHEE9rARD5yDEj8F15qpk?=
 =?us-ascii?Q?Hlwl0L3zbD0QwUuUExZkargxjmwMPNHSIaHxHk+QULTneBzzPveQ2X++K/FT?=
 =?us-ascii?Q?R42L06Zhlq1GWe6uCSHRiugK/ur7tkItx0RU394qVTfPbZwfDwVYfq87FYhm?=
 =?us-ascii?Q?9JRJoYsI9bszzvdpYiImQSKI9kJ2V1Z5Sw7c4Nw9s2g+OTfIXv9+qANQKuIL?=
 =?us-ascii?Q?zhyUYIiyEk8scX3JabFUMaBb2xpXUDJXFCmZXvbpWnW957yb6l69vQLgE/c9?=
 =?us-ascii?Q?l6/OYMJdzEI17hN1N3zOmp5aNlsTfswFMY+uzxN7A+6c0lKcJFU6/M1IrIVz?=
 =?us-ascii?Q?ZoTHZkWlTahAjEYSM14z06NhXtDudAsKJg/qnDlORHhHMfEQym8WDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mnegZZys/8JKrxCfZyoaP1i9Fq4IrNmgKyQA1pylBRDEy2JbVBTuWIh05jYr?=
 =?us-ascii?Q?bE7UJX2cShdS1s68q9r37sej7UxNn+ZKkXiRwYUyAmXet/PNTzfexwbQPmqt?=
 =?us-ascii?Q?cukVNOrGIQITV1hS6zV5xEOeMB5Cbv29R5f+W9LQfHZzD6mfaUcrSxyKhjTc?=
 =?us-ascii?Q?F7s1H9KdgyLt4Vd17XICKmnMZ4B3TVdScF80sI3kHnUUfd2Ygk0ElAMlgYR1?=
 =?us-ascii?Q?APLYHEe3JYmQ5+E3hHy1/2olWDmnr1EjwDXwFpG9oFgVB9It4RPWv040wwFp?=
 =?us-ascii?Q?6yjgMnx9RTKuHJPVDsFgUBhZOpb9UktrvUaTzzSu+7tqExFVkHSkY1AfV6s+?=
 =?us-ascii?Q?/jXjDifIXqYz99QYDERKDJGSkDsA4BRB4dWRhMn3j5kDganYrf4YrQMbc2CV?=
 =?us-ascii?Q?JDGHpjm03itFMA6HqWtGsHlQlboGtxm5U58YFCx85EHbCiaTMYLRz7cMN66G?=
 =?us-ascii?Q?n7xs9zUbLy65cNOx6HBsa/72mXQyLycltl2nwHrkjjLJriqM89np6ZDP0QN6?=
 =?us-ascii?Q?0bFyVe/CczIHesEf+Orf9vq6DkOAGnyY5vZpF18V8eUdGIN7WWsLAy60W36P?=
 =?us-ascii?Q?3PYksHxMeU/ApUxGZ4770YHJ2gCdertIgKchgQbMe+ZPKRMARgQ5cqOU8CmN?=
 =?us-ascii?Q?zhROUhkM/mM8CrrhZ1BdVFBV8egYP/MFkf2Kf8aNBbB4OvU0O4QRzANF2Tyj?=
 =?us-ascii?Q?jECcc31l7zLCaXfPnAkyb42xN4qlMGK6PnV0y62BOqg6Wkt1SzI3Ty9w3O7r?=
 =?us-ascii?Q?AC7LPajQRA4qb+uieWZRiiXkGtCXEtz78n3n2SikxHS+C8NQIDoBMPUekmGy?=
 =?us-ascii?Q?rZVfFRyPTznlsf+LtR0n4DRLAlDWz+veXTRIIAr0s3BAY7MGZIHaqG5Le56m?=
 =?us-ascii?Q?axlDCllfFPb4K7oubq/hmaWU010NT+1j1Ifd9K3no0iwrgSu6oQlU6wO7Sz6?=
 =?us-ascii?Q?Q0CYa6m2m7QWA9RJwwbriD7r3SG6fgEAPR47pupHJKseDE9uA1w5SwwrHpFP?=
 =?us-ascii?Q?T2i+Z1akvvN1PDXmvnL3jawwGcgT2pVicuO8DncWsx9L8EbIGomSRrinBXtg?=
 =?us-ascii?Q?d06UBXza7DhDfLiodlSzJuXaYW8YrLqSJ2HKAe87NUNdCw4JA1dNpso9KGVy?=
 =?us-ascii?Q?X99xGZ5fg+OzYk54eG6OmhWnDp+//0qq++KGA+hWBvqt85v1LL8djEUIG9aA?=
 =?us-ascii?Q?nydIzM/42Z0/Ao5LDdeusnDVDPskDN6zbzvjtIIwPdaXiYiwDBI7V6v8hQJN?=
 =?us-ascii?Q?kQU3zBKvz2WvqmPqiHN6eNbBoiYimLHLl9o7BcyZmU6tVgBqSJ5tBzOChbY2?=
 =?us-ascii?Q?Bf4fDUBzuhFNIt8Ji5j6sPWX8M4DSstScqMUcnwOJJC2kQNHk6/JFB342ETF?=
 =?us-ascii?Q?+1c12BhIMFSHa7rj2cdoFZy3u7zE+mvUe4etrpDbEV43/Wsc8FvTIjle+3yc?=
 =?us-ascii?Q?kHP6z/B/9/CzEQ15vKIqdoutfKh3kjgsa6v9FGNUOxvsqSO+a3SbTGwqRgLc?=
 =?us-ascii?Q?Anw3XTOYYF+m0W5KHnN6vxYVK+EtxC3DRjuD1oo86kFPaGBOqTE7uBDGkZo2?=
 =?us-ascii?Q?2GFVwU0aVz1xG9N2MRUc1XzbZyNi6Bvf1TQ3pFUFUcK9CLQ99rBMZ6EoFkhO?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 232e29d0-24e5-466e-2c6b-08ddfd2749f1
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 18:05:34.4413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3cVcX1lqn3TR9FxOF4QSSaZAwFhVc3kuFsmh+DIQJL2HKJQp/v6oBQHxgiU4ankBX/rKO9uwOUoOIetzTCLKyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7823

There are various circumstances in which a lane halt, or a lane reset,
will fail to complete. If this happens, it will hang the kernel, which
only implements a busy loop with no timeout.

The circumstances in which this will happen are all bugs in nature:
- if we try to power off a powered off lane
- if we try to power off a lane that uses a PLL locked onto the wrong
  refclk frequency

Actually, unbounded loops in the kernel are a bad practice, so let's use
read_poll_timeout() with a custom function that reads both LNaTRSTCTL
(lane transmit control register) and LNaRRSTCTL (lane receive control
register) and returns true when the request is done in both directions.

The HLT_REQ bit has to clear, whereas the RST_DONE bit has to get set.

Suggested-by: Josua Mayer <josua@solid-run.com>
Link: https://lore.kernel.org/lkml/d0c8bbf8-a0c5-469f-a148-de2235948c0f@solid-run.com/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v3: patch is new

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 96 ++++++++++++++++++------
 1 file changed, 74 insertions(+), 22 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index aaec680e813f..4e3ff7ef47e4 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -254,6 +254,12 @@
 
 #define CR(x)					((x) * 4)
 
+#define LYNX_28G_LANE_HALT_SLEEP_US		100
+#define LYNX_28G_LANE_HALT_TIMEOUT_US		1000000
+
+#define LYNX_28G_LANE_RESET_SLEEP_US		100
+#define LYNX_28G_LANE_RESET_TIMEOUT_US		1000000
+
 enum lynx_28g_eq_type {
 	EQ_TYPE_NO_EQ = 0,
 	EQ_TYPE_2TAP = 1,
@@ -672,10 +678,29 @@ static void lynx_28g_lane_set_pll(struct lynx_28g_lane *lane,
 	}
 }
 
+static bool lynx_28g_lane_halt_done(struct lynx_28g_lane *lane)
+{
+	u32 trstctl = lynx_28g_lane_read(lane, LNaTRSTCTL);
+	u32 rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
+
+	return !(trstctl & LNaTRSTCTL_HLT_REQ) &&
+	       !(rrstctl & LNaRRSTCTL_HLT_REQ);
+}
+
+static bool lynx_28g_lane_reset_done(struct lynx_28g_lane *lane)
+{
+	u32 trstctl = lynx_28g_lane_read(lane, LNaTRSTCTL);
+	u32 rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
+
+	return (trstctl & LNaTRSTCTL_RST_DONE) &&
+	       (rrstctl & LNaRRSTCTL_RST_DONE);
+}
+
 static int lynx_28g_power_off(struct phy *phy)
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
-	u32 trstctl, rrstctl;
+	bool done;
+	int err;
 
 	if (!lane->powered_up)
 		return 0;
@@ -687,11 +712,15 @@ static int lynx_28g_power_off(struct phy *phy)
 			  LNaRRSTCTL_HLT_REQ);
 
 	/* Wait until the halting process is complete */
-	do {
-		trstctl = lynx_28g_lane_read(lane, LNaTRSTCTL);
-		rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
-	} while ((trstctl & LNaTRSTCTL_HLT_REQ) ||
-		 (rrstctl & LNaRRSTCTL_HLT_REQ));
+	err = read_poll_timeout(lynx_28g_lane_halt_done, done, done,
+				LYNX_28G_LANE_HALT_SLEEP_US,
+				LYNX_28G_LANE_HALT_TIMEOUT_US,
+				false, lane);
+	if (err) {
+		dev_err(&phy->dev, "Lane %c halt failed: %pe\n",
+			'A' + lane->id, ERR_PTR(err));
+		return err;
+	}
 
 	lane->powered_up = false;
 
@@ -701,7 +730,8 @@ static int lynx_28g_power_off(struct phy *phy)
 static int lynx_28g_power_on(struct phy *phy)
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
-	u32 trstctl, rrstctl;
+	bool done;
+	int err;
 
 	if (lane->powered_up)
 		return 0;
@@ -713,11 +743,15 @@ static int lynx_28g_power_on(struct phy *phy)
 			  LNaRRSTCTL_RST_REQ);
 
 	/* Wait until the reset sequence is completed */
-	do {
-		trstctl = lynx_28g_lane_read(lane, LNaTRSTCTL);
-		rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
-	} while (!(trstctl & LNaTRSTCTL_RST_DONE) ||
-		 !(rrstctl & LNaRRSTCTL_RST_DONE));
+	err = read_poll_timeout(lynx_28g_lane_reset_done, done, done,
+				LYNX_28G_LANE_RESET_SLEEP_US,
+				LYNX_28G_LANE_RESET_TIMEOUT_US,
+				false, lane);
+	if (err) {
+		dev_err(&phy->dev, "Lane %c reset failed: %pe\n",
+			'A' + lane->id, ERR_PTR(err));
+		return err;
+	}
 
 	lane->powered_up = true;
 
@@ -1131,8 +1165,11 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	/* If the lane is powered up, put the lane into the halt state while
 	 * the reconfiguration is being done.
 	 */
-	if (powered_up)
-		lynx_28g_power_off(phy);
+	if (powered_up) {
+		err = lynx_28g_power_off(phy);
+		if (err)
+			return err;
+	}
 
 	err = lynx_28g_lane_disable_pcvt(lane, lane->mode);
 	if (err)
@@ -1145,8 +1182,16 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	lane->mode = lane_mode;
 
 out:
-	if (powered_up)
-		lynx_28g_power_on(phy);
+	if (powered_up) {
+		int err2 = lynx_28g_power_on(phy);
+		/*
+		 * Don't overwrite a failed protocol converter disable error
+		 * code with a successful lane power on error code, but
+		 * propagate a failed lane power on error.
+		 */
+		if (!err)
+			err = err2;
+	}
 
 	return err;
 }
@@ -1179,9 +1224,8 @@ static int lynx_28g_init(struct phy *phy)
 	 * probe time.
 	 */
 	lane->powered_up = true;
-	lynx_28g_power_off(phy);
 
-	return 0;
+	return lynx_28g_power_off(phy);
 }
 
 static const struct phy_ops lynx_28g_ops = {
@@ -1239,7 +1283,7 @@ static void lynx_28g_cdr_lock_check(struct work_struct *work)
 	struct lynx_28g_priv *priv = work_to_lynx(work);
 	struct lynx_28g_lane *lane;
 	u32 rrstctl;
-	int i;
+	int err, i;
 
 	for (i = priv->info->first_lane; i < LYNX_28G_NUM_LANE; i++) {
 		lane = &priv->lane[i];
@@ -1257,9 +1301,17 @@ static void lynx_28g_cdr_lock_check(struct work_struct *work)
 		if (!(rrstctl & LNaRRSTCTL_CDR_LOCK)) {
 			lynx_28g_lane_rmw(lane, LNaRRSTCTL, LNaRRSTCTL_RST_REQ,
 					  LNaRRSTCTL_RST_REQ);
-			do {
-				rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
-			} while (!(rrstctl & LNaRRSTCTL_RST_DONE));
+
+			err = read_poll_timeout(lynx_28g_lane_read, rrstctl,
+						!!(rrstctl & LNaRRSTCTL_RST_DONE),
+						LYNX_28G_LANE_RESET_SLEEP_US,
+						LYNX_28G_LANE_RESET_TIMEOUT_US,
+						false, lane, LNaRRSTCTL);
+			if (err) {
+				dev_warn_once(&lane->phy->dev,
+					      "Lane %c receiver reset failed: %pe\n",
+					      'A' + lane->id, ERR_PTR(err));
+			}
 		}
 
 		mutex_unlock(&lane->phy->mutex);
-- 
2.34.1


