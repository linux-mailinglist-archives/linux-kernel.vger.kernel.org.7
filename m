Return-Path: <linux-kernel+bounces-834499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F305ABA4D43
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F117B388613
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9681B30CDBB;
	Fri, 26 Sep 2025 18:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i38tYidm"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012003.outbound.protection.outlook.com [52.101.66.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABAE278156
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909937; cv=fail; b=WV79r8LgTsBg3q/d5eB7KsQClICwpa78vRtnaaUnEr0qdKS8GH1ZgUdWWDWyWPmDeBm/rHms+Npcy///mtQOx/wvYnPXkIKgvR+BaWNyfalfN+pU4591enNnEpMYm8x8bxbt0thewdASckdhfO//Q+NlAl7Wbrbr9FMvAqQsJQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909937; c=relaxed/simple;
	bh=NTt3EHEt4iJtNrmQQQ/0O1Wd/kgda1R7EtWINwSLJhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OPHO/nj3kNvt2yN1hQZkqAORE94dyhHc10UMKBhk0Q5MEMeau+x2DctZhWxDDltRrflvlAjuhSOUC0x/ili2tUhkqCvl7RaTo5WdldWllRv4B+JRGt2SK5ymNVyr+rt6sm40EJ/u+erLTh8Oba/LwMszmepIutQPthb62Z1hzms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i38tYidm; arc=fail smtp.client-ip=52.101.66.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0orrBYwd/KgrFBcOPXFTAL+Xw/7pLBbLuvZW/AaB8FAyUb8k4HStPEGemoxjIDxK4WXYOMc77oEAHwqjzyufWntsJZ49PUjw0Y06OEHRiFt1jBPkP6RyagdbO4WVfWbLhT/30WCmuG7L6Ceaq8CPDFYoHAZpVVecrlDh/N6Z3yp5U2SrY1U4oA6Rl2dqwvqdOdwrPcShotkk5YvNga4gu894grUNetj0a1hDAVe7MOLN+dXI7vosx6CS5Tz7Li3pPNGoNDrurO0eyidp3kQNguLFRVEt0F9kQhc5EcK9yKse3IjYkC9aQH5lb07W1ot4T4lE9XxjjHe2u2fm74dHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcvrIjVSKEghfI0txyJwFSvI9VmHOQhBmH9oOu2xXqc=;
 b=TVmnbyIozLz5WSXLQmCW0yqsXXguuOIUXBWhqe70c/0SvfLxAlxiviKltU5+p16rNTjPO13NwF8bG372muI6EL2bRhUhGfgkA9QTbeJIrgkziEu02zBdGhgFUvR21ig2x3Lo/SomQcK0XW6PdAWmdSF7NgltQ8uQyeJBOzcGYJCZ7rWdYjay+vMvV6EO+HpqI+OprsgEdKS5HZyLCl+ngkT7jxoNByZTDhzb95NMM7eqcrfwjDIGqG8HVHoEWFaVnSczoSj+1tgqT1Xy3G4uTcrQIDZ+Sln85vDOxgx3XkW17m5ho4F5eZtsYor3fApUTjR2ziLA7Dqy5BbTP09RwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcvrIjVSKEghfI0txyJwFSvI9VmHOQhBmH9oOu2xXqc=;
 b=i38tYidmZJ0CK1v+Q1TBKw+pLaNoihPelG7itmbB9EmGvI+ZfLiXXE6SOoMuIrc2vBc6v/vCd6ZUB5UFM7ZNXbnXOVEDAzdSGvUluZXnZfpBGOV6N7S2BLmo4/qJao9m1j5sHri1RSdxzZwQ3TznAFsvd+iCT44iHo1a9eJ39tp6sG6VJLpx4ffvF2xt54dn3uwEiYby/xX2iQQBHlRLDL+KYKny6OwLfVQRnb2bYaKvXiIAcdcEogXX1SvE2Lh6Qi4flP/cTSYvyTNFwfJN9zVa41Y+oQX8AV66A7FUyOJMNAuXskDm567RpZbxBvOkTse3JsyI+TsFoNZfKagA0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 18:05:24 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 18:05:24 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 phy 03/17] phy: lynx-28g: use FIELD_GET() and FIELD_PREP()
Date: Fri, 26 Sep 2025 21:04:51 +0300
Message-Id: <20250926180505.760089-4-vladimir.oltean@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 625ee4fc-0468-4a3f-4ca0-08ddfd2743f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MOFnS/M7JO8m0UmndnKiEch62OCMhNWaiWLuAn38pFprbvn+2Jc4s2e1DkmJ?=
 =?us-ascii?Q?BDpTinO9IiVa0F9B7sP4qsbiabqbI63lA4FjkuTDO5+ThGyAwOLqBvbkLcOe?=
 =?us-ascii?Q?7qbXKzVJZId2Jw8VfAw4bByn6777wlDyywcDhtHNxvbgt2CXcTwqsy3zKXld?=
 =?us-ascii?Q?jtpSjbT+uijtIOPUaaROjq9e7J24AUl6KwPIf9L6/bcS2P3+KiZ18zogYXn0?=
 =?us-ascii?Q?We9AGTbseCEXCtkNy+C7B/QlQz3sQMFV1t9wJdknt5In1hWp6ZjZ8FaxMEfn?=
 =?us-ascii?Q?wFKRY2c6psZG5CqkLhqo58VrAkalz8/a+c194LCjC7XO4m5xCluxqrQv6fSk?=
 =?us-ascii?Q?ZXQsiH2X/frx8qGIaqHhpm5NvT6cPpSVXCi3RGQBByl3R7XXF8R7ibdph0Ns?=
 =?us-ascii?Q?rR3OEuE9b7S+CT3K5vQ8IvJgNJZikesTJuOyhlBPIBHCUYy4uz8h59VZvF89?=
 =?us-ascii?Q?1tbYXGqxWfltFuiFxFz/hHOM3K43m2WWtQyimN2Si2SsloO51YJw/N4g36gG?=
 =?us-ascii?Q?py9kPxb2T/xQiFwrBJ7+1xKC1L/FBWSMrrui/2H8l+fSONTGS6pt4Xexqw30?=
 =?us-ascii?Q?g45JaIk4I1UeFb40HZZzXXLs8wYOg80e5QB78oG3MnA/311xjP62NR5xIBEs?=
 =?us-ascii?Q?olRBKSaehXn3T7fq8we/aamoq/mA+Ue8lU4GVEKxDHZfV3eVDenDRQdq7Neg?=
 =?us-ascii?Q?Nalzh3CWKUzMWF+SEn2UHtomMyrZvqBCCClxpAuDSj3XyIIx/UZMFWkDVjr0?=
 =?us-ascii?Q?o0hvEBTkCcwFSlptBK2hd9C0flm1HZpMC69FCqyp3m0SMWJBiqxBskgNfgOO?=
 =?us-ascii?Q?+ZOY7WvR1fpFa99v1zwlRODEK9M6lQG3VTSynXie7gseZqAeaJVFH0IdkiRU?=
 =?us-ascii?Q?ftxiY9zSjeEuV99IPTYkO0LlA+oREbAjujLNukjuvP48BoukYZKQCePicGX/?=
 =?us-ascii?Q?QufLY28u6O6Nn50C0pm5gcd+aYEvlmN2+A04tRCKF+yhq+83CXB55Zhc1sSr?=
 =?us-ascii?Q?EAG/BDHLgthXr7Er+2vIuECcR4ubLPB/iT4pLePcT+UbpHx4cpnL72O1GNQ2?=
 =?us-ascii?Q?WElSdzjulSHnUGzfkJS7aJxu3HAQ+hd6sr19Puq2BNvyWBk9GnbSFjb5Upfl?=
 =?us-ascii?Q?j2bn0PiLnvCl4jyNBs/94SsEQ9VaVeu/pPZ3O71lriZGocCbh5xMQIeGuGpo?=
 =?us-ascii?Q?HaoY/BOI28Cd3Ol7Foi8A8Z1OZmpwU6FvHGMrrkgmaACrx28O1N8ZsFZ9+05?=
 =?us-ascii?Q?ruQFg3IzF1vNM2P6NW4tZ4Ip+x1e5vLjsbwhB7sRhzPNBMVgKKGzRRjiBaDG?=
 =?us-ascii?Q?YKy0r0ZvLYL/y26v0vjk2Qfo7BsKaBeczBzXanmdPPjCzMaHQ+K8kn1T9C7R?=
 =?us-ascii?Q?JpZII0VBXupp0NXBNm5W3Zo7fU8QpoSGvMvs/B8PxBh8SF9n+neSqfcrYapS?=
 =?us-ascii?Q?EDnPIHYUxvBg3QQ1iS3FZt28EaMl0jhOC0djMW8GS3niZQgZlt2DgB+ovyTa?=
 =?us-ascii?Q?3rD/0HgpfPa75NnzTWJSS/ZPYSCVuiIyYh4O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zhDU+Oe76r0+BYP7BD7Ukw9zsHacRWBOZo4jCJhLd43gsFu4SLGfNQpTCII6?=
 =?us-ascii?Q?bWc9VK60Csc0vzo56h9HGo0nVWbFyhGS8CXf9pYo1iY/z+ruuio1e4eL6QYa?=
 =?us-ascii?Q?cod6ly0pFL3fgo2wx8CpEkVNJx0CeBuB7Mg/JQ83OnxDX01kRwaupQA9HlDe?=
 =?us-ascii?Q?zmvqedhKa9MqbikhAYxk/xHI3KR4ULDsijXVyJ+uAOt/MjXTDpktuDNaLKrV?=
 =?us-ascii?Q?RnrjFre9JtX/D4rut2lo7+TM2rnoQQddppgoIqnE8wZOLV23JU4Ol9DUkfBM?=
 =?us-ascii?Q?AXfV6tNdPe5kVgyHd8RMnv/Z8x/DxIbeZurrBMNOd+5PpswofZ+00TDYR42q?=
 =?us-ascii?Q?m4m2w2h7NmPbjkR8ciUUKgpdoH1ghv8faTcxbrqZWMTAKZIIzEDdsqOg02C4?=
 =?us-ascii?Q?uGpYhwbrFqtRLUIM5HSZLjkykPByethVp68GEi27XOVF1OdqBIU/3E5McZoM?=
 =?us-ascii?Q?ty/lGTW00zKjo7/c0O1aycbtg8Y4SV9qa19TDMUQkTKnau1zrw6AEiUQIkXD?=
 =?us-ascii?Q?CEQ4aigdN1i5U+vbQUVxQTkQ/O4PFsSXctf43v473eksdYrycVDbbUvU4O9u?=
 =?us-ascii?Q?dhzZ/1YL/gakYoTZXjE4Jx0DDKfnRL7nTsP1Q2qBQfvjgbP7S+7v3xvunnTg?=
 =?us-ascii?Q?yWmFvfKD2ktDQN0wMNfD1NNqewhTmfTHkQ5VapCsnc8TFJa0EeRvgbgoAjUP?=
 =?us-ascii?Q?/BAh2PVMWJExytsT4SUiGejAunfgfAH8Oz8N3lEO3LcDUX9jfZEwwTEWvNRX?=
 =?us-ascii?Q?yAO4viRE1kdM9g/PsD6VSsVuMhNQlO8l9FnH7KQmErxFdhRggpl9TmsAg1W5?=
 =?us-ascii?Q?dqf2rtyRLY2cfGiUq4H9UMq3icE4lIu3enFISP0Dk0jvsBnw4TuU0msZP0ia?=
 =?us-ascii?Q?LYaMrIPoeGKqQW/wsxfhBFPhv2N+d0iRs0Wq1t8Stb4g5FBaQlJD2pWxvFHS?=
 =?us-ascii?Q?VYUJ19GdKLXUhsLyl/+gom29uoogc+GwY4q8/AX4+d0KK5ZGvIe+R9d0z+PE?=
 =?us-ascii?Q?7Q6s5LDTXu2XuCWwGfMoh+SrwibKh3+4i6ZuJ8iyzYt31ohtEEa2A9aR9ar0?=
 =?us-ascii?Q?2Re362z83L8oKiF9Oame5si0i8GuE71u45gRaI9uc/3ewCstqA5hUk/ACE/a?=
 =?us-ascii?Q?Mb6WGtC8EFiTy3o5qS3jlAV62VnI/ntNNsZhWo1g+z+eBuhuM1K1DGFOgLkx?=
 =?us-ascii?Q?VuXx58OPIBBZ3q8A86iVC1SHWysizps7eLHqfy8BAhOuOuFgUA9atqw8rZi3?=
 =?us-ascii?Q?crQ+mJwFNC+d++PdO43wLvBXNXefYA7ngs20isqpIsg09hjt/qCwm/3t26pl?=
 =?us-ascii?Q?VW4idX7uC8B4QTi2fvrRMBX0KOVIgtBC4AzcijElHZbgDljEQVKUSEZedQUC?=
 =?us-ascii?Q?EPlF/Bbek3+n3ZksSpFUlC6iL3J1F6IhN95IUgl0GdwlBtnsgEGWTKSnp2nm?=
 =?us-ascii?Q?XN2B+o4OVflASKuwnPeqxtJ31Z+wKN/7chVr7fb6nqnjYdC3HvGpWgc5wZzJ?=
 =?us-ascii?Q?FQRVR8nDZkpgHHqeMf5xjYDouZatm7fmydephJdWdKkZYRFFpI1E7CSkWHTC?=
 =?us-ascii?Q?ZUf/1bqU7hXAORfBZYF2nccLx2cTr0UNTfaEWOhhm3VVB5Z4AN80nh9Rfz9b?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625ee4fc-0468-4a3f-4ca0-08ddfd2743f1
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 18:05:24.3679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZurRFVSoBkqLvlcXWBG+rggjlhWf5OA2FHYMeEZ3DsEdze6HEv3Vvcis8Bus7aJutSusPP26Ifu9ylJgGmLJzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878

Reduce the number of bit field definitions required in this driver (in
the worst case, a read form and a write form), by defining just the
mask, and using the FIELD_GET() and FIELD_PREP() API from
<linux/bitfield.h> with that.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v3: none

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 107 ++++++++++++-----------
 1 file changed, 57 insertions(+), 50 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 732ba65950f3..414d9a4bcbb7 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /* Copyright (c) 2021-2022 NXP. */
 
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/phy.h>
@@ -29,26 +30,26 @@
 #define PLLnRSTCTL_LOCK(rstctl)			(((rstctl) & BIT(23)) >> 23)
 
 #define PLLnCR0(pll)				(0x400 + (pll) * 0x100 + 0x4)
-#define PLLnCR0_REFCLK_SEL(cr0)			(((cr0) & GENMASK(20, 16)))
+#define PLLnCR0_REFCLK_SEL			GENMASK(20, 16)
 #define PLLnCR0_REFCLK_SEL_100MHZ		0x0
-#define PLLnCR0_REFCLK_SEL_125MHZ		0x10000
-#define PLLnCR0_REFCLK_SEL_156MHZ		0x20000
-#define PLLnCR0_REFCLK_SEL_150MHZ		0x30000
-#define PLLnCR0_REFCLK_SEL_161MHZ		0x40000
+#define PLLnCR0_REFCLK_SEL_125MHZ		0x1
+#define PLLnCR0_REFCLK_SEL_156MHZ		0x2
+#define PLLnCR0_REFCLK_SEL_150MHZ		0x3
+#define PLLnCR0_REFCLK_SEL_161MHZ		0x4
 
 #define PLLnCR1(pll)				(0x400 + (pll) * 0x100 + 0x8)
-#define PLLnCR1_FRATE_SEL(cr1)			(((cr1) & GENMASK(28, 24)))
+#define PLLnCR1_FRATE_SEL			GENMASK(28, 24)
 #define PLLnCR1_FRATE_5G_10GVCO			0x0
-#define PLLnCR1_FRATE_5G_25GVCO			0x10000000
-#define PLLnCR1_FRATE_10G_20GVCO		0x6000000
+#define PLLnCR1_FRATE_5G_25GVCO			0x10
+#define PLLnCR1_FRATE_10G_20GVCO		0x6
 
 /* Per SerDes lane registers */
 /* Lane a General Control Register */
 #define LNaGCR0(lane)				(0x800 + (lane) * 0x100 + 0x0)
-#define LNaGCR0_PROTO_SEL_MSK			GENMASK(7, 3)
-#define LNaGCR0_PROTO_SEL_SGMII			0x8
-#define LNaGCR0_PROTO_SEL_XFI			0x50
-#define LNaGCR0_IF_WIDTH_MSK			GENMASK(2, 0)
+#define LNaGCR0_PROTO_SEL			GENMASK(7, 3)
+#define LNaGCR0_PROTO_SEL_SGMII			0x1
+#define LNaGCR0_PROTO_SEL_XFI			0xa
+#define LNaGCR0_IF_WIDTH			GENMASK(2, 0)
 #define LNaGCR0_IF_WIDTH_10_BIT			0x0
 #define LNaGCR0_IF_WIDTH_20_BIT			0x2
 
@@ -60,13 +61,13 @@
 
 /* Lane a Tx General Control Register */
 #define LNaTGCR0(lane)				(0x800 + (lane) * 0x100 + 0x24)
+#define LNaTGCR0_USE_PLL			BIT(28)
 #define LNaTGCR0_USE_PLLF			0x0
-#define LNaTGCR0_USE_PLLS			BIT(28)
-#define LNaTGCR0_USE_PLL_MSK			BIT(28)
+#define LNaTGCR0_USE_PLLS			0x1
+#define LNaTGCR0_N_RATE				GENMASK(26, 24)
 #define LNaTGCR0_N_RATE_FULL			0x0
-#define LNaTGCR0_N_RATE_HALF			0x1000000
-#define LNaTGCR0_N_RATE_QUARTER			0x2000000
-#define LNaTGCR0_N_RATE_MSK			GENMASK(26, 24)
+#define LNaTGCR0_N_RATE_HALF			0x1
+#define LNaTGCR0_N_RATE_QUARTER			0x2
 
 #define LNaTECR0(lane)				(0x800 + (lane) * 0x100 + 0x30)
 
@@ -79,14 +80,13 @@
 
 /* Lane a Rx General Control Register */
 #define LNaRGCR0(lane)				(0x800 + (lane) * 0x100 + 0x44)
+#define LNaRGCR0_USE_PLL			BIT(28)
 #define LNaRGCR0_USE_PLLF			0x0
-#define LNaRGCR0_USE_PLLS			BIT(28)
-#define LNaRGCR0_USE_PLL_MSK			BIT(28)
-#define LNaRGCR0_N_RATE_MSK			GENMASK(26, 24)
+#define LNaRGCR0_USE_PLLS			0x1
+#define LNaRGCR0_N_RATE				GENMASK(26, 24)
 #define LNaRGCR0_N_RATE_FULL			0x0
-#define LNaRGCR0_N_RATE_HALF			0x1000000
-#define LNaRGCR0_N_RATE_QUARTER			0x2000000
-#define LNaRGCR0_N_RATE_MSK			GENMASK(26, 24)
+#define LNaRGCR0_N_RATE_HALF			0x1
+#define LNaRGCR0_N_RATE_QUARTER			0x2
 
 #define LNaRGCR1(lane)				(0x800 + (lane) * 0x100 + 0x48)
 
@@ -97,13 +97,12 @@
 #define LNaRSCCR0(lane)				(0x800 + (lane) * 0x100 + 0x74)
 
 #define LNaPSS(lane)				(0x1000 + (lane) * 0x4)
-#define LNaPSS_TYPE(pss)			(((pss) & GENMASK(30, 24)) >> 24)
+#define LNaPSS_TYPE				GENMASK(30, 24)
 #define LNaPSS_TYPE_SGMII			0x4
 #define LNaPSS_TYPE_XFI				0x28
 
 #define SGMIIaCR1(lane)				(0x1804 + (lane) * 0x10)
 #define SGMIIaCR1_SGPCS_EN			BIT(11)
-#define SGMIIaCR1_SGPCS_MSK			BIT(11)
 
 struct lynx_28g_priv;
 
@@ -197,18 +196,18 @@ static void lynx_28g_lane_set_nrate(struct lynx_28g_lane *lane,
 				    struct lynx_28g_pll *pll,
 				    phy_interface_t intf)
 {
-	switch (PLLnCR1_FRATE_SEL(pll->cr1)) {
+	switch (FIELD_GET(PLLnCR1_FRATE_SEL, pll->cr1)) {
 	case PLLnCR1_FRATE_5G_10GVCO:
 	case PLLnCR1_FRATE_5G_25GVCO:
 		switch (intf) {
 		case PHY_INTERFACE_MODE_SGMII:
 		case PHY_INTERFACE_MODE_1000BASEX:
 			lynx_28g_lane_rmw(lane, LNaTGCR0,
-					  LNaTGCR0_N_RATE_QUARTER,
-					  LNaTGCR0_N_RATE_MSK);
+					  FIELD_PREP(LNaTGCR0_N_RATE, LNaTGCR0_N_RATE_QUARTER),
+					  LNaTGCR0_N_RATE);
 			lynx_28g_lane_rmw(lane, LNaRGCR0,
-					  LNaRGCR0_N_RATE_QUARTER,
-					  LNaRGCR0_N_RATE_MSK);
+					  FIELD_PREP(LNaRGCR0_N_RATE, LNaRGCR0_N_RATE_QUARTER),
+					  LNaRGCR0_N_RATE);
 			break;
 		default:
 			break;
@@ -218,10 +217,12 @@ static void lynx_28g_lane_set_nrate(struct lynx_28g_lane *lane,
 		switch (intf) {
 		case PHY_INTERFACE_MODE_10GBASER:
 		case PHY_INTERFACE_MODE_USXGMII:
-			lynx_28g_lane_rmw(lane, LNaTGCR0, LNaTGCR0_N_RATE_FULL,
-					  LNaTGCR0_N_RATE_MSK);
-			lynx_28g_lane_rmw(lane, LNaRGCR0, LNaRGCR0_N_RATE_FULL,
-					  LNaRGCR0_N_RATE_MSK);
+			lynx_28g_lane_rmw(lane, LNaTGCR0,
+					  FIELD_PREP(LNaTGCR0_N_RATE, LNaTGCR0_N_RATE_FULL),
+					  LNaTGCR0_N_RATE);
+			lynx_28g_lane_rmw(lane, LNaRGCR0,
+					  FIELD_PREP(LNaRGCR0_N_RATE, LNaRGCR0_N_RATE_FULL),
+					  LNaRGCR0_N_RATE);
 			break;
 		default:
 			break;
@@ -236,15 +237,19 @@ static void lynx_28g_lane_set_pll(struct lynx_28g_lane *lane,
 				  struct lynx_28g_pll *pll)
 {
 	if (pll->id == 0) {
-		lynx_28g_lane_rmw(lane, LNaTGCR0, LNaTGCR0_USE_PLLF,
-				  LNaTGCR0_USE_PLL_MSK);
-		lynx_28g_lane_rmw(lane, LNaRGCR0, LNaRGCR0_USE_PLLF,
-				  LNaRGCR0_USE_PLL_MSK);
+		lynx_28g_lane_rmw(lane, LNaTGCR0,
+				  FIELD_PREP(LNaTGCR0_USE_PLL, LNaTGCR0_USE_PLLF),
+				  LNaTGCR0_USE_PLL);
+		lynx_28g_lane_rmw(lane, LNaRGCR0,
+				  FIELD_PREP(LNaRGCR0_USE_PLL, LNaRGCR0_USE_PLLF),
+				  LNaRGCR0_USE_PLL);
 	} else {
-		lynx_28g_lane_rmw(lane, LNaTGCR0, LNaTGCR0_USE_PLLS,
-				  LNaTGCR0_USE_PLL_MSK);
-		lynx_28g_lane_rmw(lane, LNaRGCR0, LNaRGCR0_USE_PLLS,
-				  LNaRGCR0_USE_PLL_MSK);
+		lynx_28g_lane_rmw(lane, LNaTGCR0,
+				  FIELD_PREP(LNaTGCR0_USE_PLL, LNaTGCR0_USE_PLLS),
+				  LNaTGCR0_USE_PLL);
+		lynx_28g_lane_rmw(lane, LNaRGCR0,
+				  FIELD_PREP(LNaRGCR0_USE_PLL, LNaRGCR0_USE_PLLS),
+				  LNaRGCR0_USE_PLL);
 	}
 }
 
@@ -286,8 +291,9 @@ static void lynx_28g_lane_set_sgmii(struct lynx_28g_lane *lane)
 
 	/* Setup the protocol select and SerDes parallel interface width */
 	lynx_28g_lane_rmw(lane, LNaGCR0,
-			  LNaGCR0_PROTO_SEL_SGMII | LNaGCR0_IF_WIDTH_10_BIT,
-			  LNaGCR0_PROTO_SEL_MSK | LNaGCR0_IF_WIDTH_MSK);
+			  FIELD_PREP(LNaGCR0_PROTO_SEL, LNaGCR0_PROTO_SEL_SGMII) |
+			  FIELD_PREP(LNaGCR0_IF_WIDTH, LNaGCR0_IF_WIDTH_10_BIT),
+			  LNaGCR0_PROTO_SEL | LNaGCR0_IF_WIDTH);
 
 	/* Find the PLL that works with this interface type */
 	pll = lynx_28g_pll_get(priv, PHY_INTERFACE_MODE_SGMII);
@@ -302,7 +308,7 @@ static void lynx_28g_lane_set_sgmii(struct lynx_28g_lane *lane)
 
 	/* Enable the SGMII PCS */
 	lynx_28g_lane_rmw(lane, SGMIIaCR1, SGMIIaCR1_SGPCS_EN,
-			  SGMIIaCR1_SGPCS_MSK);
+			  SGMIIaCR1_SGPCS_EN);
 
 	/* Configure the appropriate equalization parameters for the protocol */
 	iowrite32(0x00808006, priv->base + LNaTECR0(lane->id));
@@ -328,8 +334,9 @@ static void lynx_28g_lane_set_10gbaser(struct lynx_28g_lane *lane)
 
 	/* Setup the protocol select and SerDes parallel interface width */
 	lynx_28g_lane_rmw(lane, LNaGCR0,
-			  LNaGCR0_PROTO_SEL_XFI | LNaGCR0_IF_WIDTH_20_BIT,
-			  LNaGCR0_PROTO_SEL_MSK | LNaGCR0_IF_WIDTH_MSK);
+			  FIELD_PREP(LNaGCR0_PROTO_SEL, LNaGCR0_PROTO_SEL_XFI) |
+			  FIELD_PREP(LNaGCR0_IF_WIDTH, LNaGCR0_IF_WIDTH_20_BIT),
+			  LNaGCR0_PROTO_SEL | LNaGCR0_IF_WIDTH);
 
 	/* Find the PLL that works with this interface type */
 	pll = lynx_28g_pll_get(priv, PHY_INTERFACE_MODE_10GBASER);
@@ -343,7 +350,7 @@ static void lynx_28g_lane_set_10gbaser(struct lynx_28g_lane *lane)
 	lynx_28g_lane_set_nrate(lane, pll, PHY_INTERFACE_MODE_10GBASER);
 
 	/* Disable the SGMII PCS */
-	lynx_28g_lane_rmw(lane, SGMIIaCR1, 0, SGMIIaCR1_SGPCS_MSK);
+	lynx_28g_lane_rmw(lane, SGMIIaCR1, 0, SGMIIaCR1_SGPCS_EN);
 
 	/* Configure the appropriate equalization parameters for the protocol */
 	iowrite32(0x10808307, priv->base + LNaTECR0(lane->id));
@@ -513,7 +520,7 @@ static void lynx_28g_pll_read_configuration(struct lynx_28g_priv *priv)
 		if (PLLnRSTCTL_DIS(pll->rstctl))
 			continue;
 
-		switch (PLLnCR1_FRATE_SEL(pll->cr1)) {
+		switch (FIELD_GET(PLLnCR1_FRATE_SEL, pll->cr1)) {
 		case PLLnCR1_FRATE_5G_10GVCO:
 		case PLLnCR1_FRATE_5G_25GVCO:
 			/* 5GHz clock net */
@@ -570,7 +577,7 @@ static void lynx_28g_lane_read_configuration(struct lynx_28g_lane *lane)
 	u32 pss, protocol;
 
 	pss = lynx_28g_lane_read(lane, LNaPSS);
-	protocol = LNaPSS_TYPE(pss);
+	protocol = FIELD_GET(LNaPSS_TYPE, pss);
 	switch (protocol) {
 	case LNaPSS_TYPE_SGMII:
 		lane->interface = PHY_INTERFACE_MODE_SGMII;
-- 
2.34.1


