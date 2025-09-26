Return-Path: <linux-kernel+bounces-834496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6038EBA4D37
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51FFF1B287B4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCEC305943;
	Fri, 26 Sep 2025 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VodPUDS9"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012044.outbound.protection.outlook.com [52.101.66.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAB92773DD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909930; cv=fail; b=XJLIl3rQ8efVSTyFO8He+4KctaGClSEkcCnhfqQxY139peWD2XWI1FzjyS9R4o1sxkGFljkJ0MpQyiwDqIUCiKTgX3rtq546uAXiWhMSzp7F9xPL8aRxzEdU+ghZNU+gGO836HuGrwTGQ/kNkmoeRXKDAuaMo23wwoiiJY1qA0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909930; c=relaxed/simple;
	bh=N670IwrnchDv+my6753rDH39NhddqtOc5YjXRzcrDmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oLR1vNp/7jMUivDacjpSZ0azivSAnLyp6iIYIvBwXU5ODtXpf3aCcSI7sGN35nqR52pLmVDXY8YRi5OklQfZJHFDfZn7hPKBfLg8cOIgR33KhdeErxMzf1LQIULWCxUGPLGOph/+Ouif9Fi9AxsNsS5RHRWZuLHuPNYzWdRFDok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VodPUDS9; arc=fail smtp.client-ip=52.101.66.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YR9+G3hWU+MkcCh/EPmTMk9amTeVgB5RQx2p8Pitu0SNBQjFqI11xMwwEgN8Cqrb7q6Ht8CcUwAHGlM/9/kLnhWACJqWT/590+JsxOIIo2yTCtSZkh51WCIUHEhdNLo98P7MOFSF3CQ1ymnjLkEx05vIu8HNaiX1OZ2AItYsSDv7TG/7+E4b7YQ0Ih0DcnVNTbutMpPA+UpA7ojqN98HyGGB+tKaiS1b1dCZ/rihKk64pY7QOrDNG0gjnluQUKyPxdy/SLmL4RB+fKnJR2alG4ZTGbTO6VAL2Xavd2s8nufjHBayziGA4YYagmI+DKviCenQ1wBRiJzvwpVSHRmEEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84f4+UPmGvQNglZzm3QF0O6pkYy0S5rwVv92EpSXsms=;
 b=MLkZ98cgr1UyK3kjhtDUeG6Vmk9Chah0dPasWdPaGhMWEpwISgjaglRK6gi2s2koBqbXNmnj8TgkPLKRwAyxu04u3ujg8VZJgRWOPO9hNseepjubHu31CfN10UYF3Ws5dDWOan1T0Ghix7tazNlZQrJmfX7w2rzXoJdvLNk3ZcBBtOocyIXyVeBP8hMyM0A7jN3AuC9JLa1yXMziPcyM4hguXgptEta1jSVLIoYgA9mEGt9P3kGkVBp3hLgo+ryL3mM1cyh+KhODk57NOY/mjHSLeXguGhsjv7DmX4S/aNVAcFosNPUd+Ci9DuiAwF+bKPA4dzHDmN2QWO4c5DT6+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84f4+UPmGvQNglZzm3QF0O6pkYy0S5rwVv92EpSXsms=;
 b=VodPUDS9z1BB4vSh+iOW9ooJi1jy9xztPy4g1QyX1bMsn7s49fX9FxX0ksSUdCUMvCLEsThHbnVjvtHEWw8S6mTPgY7cQBgmHm8mNkpXSu7q3txQkVMQbYScsvI6M1pyvjck+KcaO9MIYVW23uO8w+0kplscXxBHFQeKlJgAZ2abu5eEJlrc/NiLMvufobaRc2+V4e8mgaLSBDXmgBwXDk4jwwWjJbZbQPxhBE4vVQLBZ9neiLveaiSd3H+VIIijZ+RwJ4EFOsQv15JHY346DnaH1m3AvuCZLWWpSdK6yeYH8rn0n+NBAWicW+JWA9iRfrv5YGQWmcD59mLq0z7Z8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 18:05:22 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 18:05:22 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 phy 01/17] phy: lynx-28g: remove LYNX_28G_ prefix from register names
Date: Fri, 26 Sep 2025 21:04:49 +0300
Message-Id: <20250926180505.760089-2-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 59402443-4642-4a16-aff2-08ddfd2742bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UrAAIIsfmA+kUYIjk4xLiwc0awJVJ4tRt5ymhkFHqfHd4nvZU0c4art0wdMd?=
 =?us-ascii?Q?/gqESZkeLa+1NdB70Afl38tdDD5bGxyoKVtCVuz0YeuFJx7yUsaM/IdGvrET?=
 =?us-ascii?Q?n9zxpij3NbdCdUF+NIwwXGbG0Wh/tpSfp0VfCBmnsIDT4fZUTrjgZy4PbFIv?=
 =?us-ascii?Q?nfFvF+wd2/NYaJp5+OAgyFsRkWApW5faG6olKSLBIRCh+QYPW1ywrpZWjSpa?=
 =?us-ascii?Q?fzXCktSp8trST8KSnNjLmsDKd0PBTo+ferIv7ssImKlqZmR+D6itjLgBufC5?=
 =?us-ascii?Q?UEZlLlD+kItPVo3CIbg1lm23mLahaBr7G7DROdLwBWksmygIWUz3U1zP/knp?=
 =?us-ascii?Q?ug0zq9VPTJveGszCYAG8OuvrEz+BockK8yDPRrUQzl9PRcCFMIf/025w/SO2?=
 =?us-ascii?Q?lLaYYkDDtCncSI5yUYjWi9mepdGuZ4Chpf7K/f8jXkYYlGryWQRVWKgfohaJ?=
 =?us-ascii?Q?yKbwaIxDu6RrwWktPictZ+UHAPO+YbAQicRTxwEVCa4d2tC6qoCXIio+TBYa?=
 =?us-ascii?Q?5nH5LoEX1pcdMRtobrOSgtTN0My5W0mOBik+kw4gy0r8EJjzqXx4Fj/HS03G?=
 =?us-ascii?Q?1Q8tIpCDgFdwQrMIXXq/ImTf8+UEgvYXkMQpBOgIKYqFpgPfjce8/isWe91u?=
 =?us-ascii?Q?H+e8I4AKrO+5anR9ie7pvwTN0PlvqBTGfPBEO3G2EHGYasw/xkMyZXMVoQBB?=
 =?us-ascii?Q?ShrACGe3pA1CJESmx/ax9refuqqkUrNL1k5emAkjzDzMw91My+Uo78eo/Qjx?=
 =?us-ascii?Q?z7H8wlVjUDN3Evj8/9E5Zo+19D6/wMvzu/FfwPiYZr/mJd8yNb8TjLu/Zk5f?=
 =?us-ascii?Q?jYMmyoaQUvY2iR4tsvFMiz2oADratGfB+aT6NZsb2s1k3VbxxU2Km/YJ1L7t?=
 =?us-ascii?Q?RamMfETCGncIHev/f+ZRuMcsMOb3auGSNbLtVGaqUfZt+DdyDQIvh0HXXtUW?=
 =?us-ascii?Q?mr2m6SsJq6uuN2NKWrA3MBstEbmlINmWgUmYWvkcOz9lxRkeLQN7dL3m3Q+4?=
 =?us-ascii?Q?pIULBLFV9/RwPFHFdk5Gxyfn9M49js+CRfkkFTQj1G2WY8yr5tAYGlcmO1T+?=
 =?us-ascii?Q?k+1SdiqqEki6FuTrBkJ5u5ymlZ4QFvOkMWwjZueWODtq5VjPUJG0avJeemz8?=
 =?us-ascii?Q?jzbKO15r50vbhQq1+TAzjWAXd79CZkeQfIoEeYi4K+3x8CIBrnyNDbYhCOJW?=
 =?us-ascii?Q?fYH04Wx1fqq4M+MOqSumay5PtmtrBAlz74tmEAyq5BmKlAdbs/fFZ4GUmGFT?=
 =?us-ascii?Q?TkS0LbK69+KgGEuJfKMC1CEq51XJLO++Qx7HBLLXhl6+roJ0iQjZej6V2d3G?=
 =?us-ascii?Q?SbZP1AiHUM3ouAxWmBW9WeND+uqLYFjQU/oBDiNjYCm3KQVDbrmndV/JMyYD?=
 =?us-ascii?Q?bcmsSTSyPNLO5nP9rizEbC0+psijBSN4zAL4RPjEC87JoZfFabzKdUOSniJK?=
 =?us-ascii?Q?m08WbHQJQVFWN+25OszvVTQm+Bfs+uzDfEP+0j7UDHu6FcAIQiXsQBfVVyTV?=
 =?us-ascii?Q?ZBnN+wCjV/YxWSeBwF+DiWi0UQodJtA/J8vR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E15WJCTt52Cia8n5vLHpTVnoR9/vSJjWlqR6lMu51DOD3jnFVYOqObC6RGJ8?=
 =?us-ascii?Q?E0W169H4VrN+tGyDn9GjTNmuZOxUzZzIKzI0w5dfx2HrC/M8JcBRKFUDCeXI?=
 =?us-ascii?Q?KClE9N3feqm86cNBEeXS5pFLrbUxZfdm4PhyUjip5aeQ51QhybKOTR92J9Jn?=
 =?us-ascii?Q?hy8NNBYf/UZn2li7l5EyZwBjbJYo52fe2bddK2jeIhUzTcB3et2/w9dR0c+J?=
 =?us-ascii?Q?+SFs+YuqDWS2k+b+Z9u0ip7PHSksdR0Ee6ID9vYaBIQJIp40wFMkVpknIX7t?=
 =?us-ascii?Q?W3RjzW7lrN1T9bh4T5M7LiJC1X+IuBoLtmAxz+dXYyOiFuwLBBh/4iLowVgH?=
 =?us-ascii?Q?bdLUYNywMQrauPuDa7DbYU/zxAp4gssWo6TPhf8sHKEvHmt841/IznhEmtg3?=
 =?us-ascii?Q?CnQHPmCiNXYACnw8oK/HHdj+racaWoIyIn1NQVuniWbC8XcOQ3O2SERwkdNZ?=
 =?us-ascii?Q?cX5eFTJ7mjE7uyqRfMYQs1kF5sG/8acgYRxHxAnaUf9GIGNC3Vh0zQMvcCTu?=
 =?us-ascii?Q?LcBGY4GHUwvJc/bXZ/D+w1VYdnTEMJTQfwkdmamYP7cdSz0ujNUkb3c5Y1Tp?=
 =?us-ascii?Q?+ojCK94OsEg7r8B/gLwgjUw8e9WXqNHvW5Hp1L6zyfrPQ1Z9BkgHM5BLuvtE?=
 =?us-ascii?Q?NPsm7/HXcqjR6bSiVTxnRG5EXBF/rbLB1ufVhQSEftXVRzGichiUHU87Wtg5?=
 =?us-ascii?Q?WlKSSVG3wXxNUWXruGZBVWeurMa+bb3LWbMRyJBLCoGqUj7nIJ0KMx4Wu3dV?=
 =?us-ascii?Q?7vHy4aYV/AYrQUrzHmZjJp++jxFPyMWZdQ2qCVrTZ1tcx/6ZGOTlm7cD70Z2?=
 =?us-ascii?Q?1N8qJHCFeViEU2wBO6wYY/IMN613l3muMATZ5cA4D7GH1q6pstZQdh67NezE?=
 =?us-ascii?Q?Ig0FzM2Kijdy/7cluBblVMNhLc/7gZk+5LztU4PXn2nF/sOQjShiU4NCZSR6?=
 =?us-ascii?Q?hRop/rHSxnHWfCw2udq9lNSOvybXBpDabDIiFuawmhmn6/IEnB7OWbVHPI8l?=
 =?us-ascii?Q?a3+0gcx539lZJHOJsEOo4kbkPjNsapN5b2FE229Fbw9thELvfOzzRrQ8bY3h?=
 =?us-ascii?Q?mg5W86Zmr8dEdygEz/eaprDXjAal1dqKdLA7S+tPkm/bu49C0rQQdQ69z5rL?=
 =?us-ascii?Q?2qOynmbhA3DgccUC0TR15suHtLdgKXbPhuYBVjDp2Q60RM8GTx9ILxLacYqW?=
 =?us-ascii?Q?FJmj73bL/RaTw9RuKMP/GNh+gqI8hrkoAvi+ADdSBjcldI0IMeTVepsOLEti?=
 =?us-ascii?Q?CoJLaEZLwGIvJN4IA67g7yj05tjTDveTjQqhRDEGoGbiK4KkJt01shdnEx+7?=
 =?us-ascii?Q?H8thBQZSKvxmXF16TZ1HkDaRfxhr7tOmTLHq6sA49OvxJFfVCyTLexa1X+8e?=
 =?us-ascii?Q?UZVNW8lyNMwsx/bE7jkm18P2dODEoFgjtS2r9OCCaLv1p00i59F9anxsI/x6?=
 =?us-ascii?Q?hLLMtJDuledSBCFk/f4Q/Gij/1jqKrZ7X+d9UoN9hM5Z10H4mbEbg0t5BTJv?=
 =?us-ascii?Q?fSjFdoF12l+cbp9yPbMetstrjMhQspPe2ZV9QafC50VneG8t/rkqvatfPL1v?=
 =?us-ascii?Q?RiR5xX6e8ij+clh9YdEksMZKYEC1tYmQb3NWWAo/aOqCFslilfafGsk7cxWf?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59402443-4642-4a16-aff2-08ddfd2742bd
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 18:05:22.7835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEDFlGFZjAq66I0Ccgjz9PCaiT29yCSLF73cvraOYacboKDBbLOxSf1cYBsOtFBwpAis+CfLNCYC7t8aPIfPDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878

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
v1->v3: none

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


