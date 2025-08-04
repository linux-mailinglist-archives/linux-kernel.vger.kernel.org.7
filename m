Return-Path: <linux-kernel+bounces-755208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651D4B1A302
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47444163EA4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0125726A0B9;
	Mon,  4 Aug 2025 13:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="f+oZFbsr"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011001.outbound.protection.outlook.com [40.107.130.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9829266EF1;
	Mon,  4 Aug 2025 13:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754313322; cv=fail; b=VbjZbSm7bp+PiQFJPwS5fFpan0+xFSjTFHjdFyEnx9JejbCTlTFdeJn17JSI9bpkYTeG29JKBxozqIXvN9y2Rsu+ztiJT6RZC99ubnAgKfU4IVpOrxEAnHyPuZzOZlazLlPjk1xWzvqNf5lpNPKOqMz21NXZSngquGYZ6JqFgEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754313322; c=relaxed/simple;
	bh=BqSzMD0907AGpbFXdm+VnqzTWz1LqIriVI4TMdWJDwM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d2Oo0IGiCJ8PUSOuaQgO7mqhj1SmxAGgTErQvWJuI3TUH+7pELKhu40ZxEqANgCbOQOX06WJB+rI33BIFprhXWBzpweD6YuOCOK7UmACI+E9eGVoXN69NYLAAP7HGC3M9InPRhxXMA5Iaf59aFyFMAeIp2e/a8/eiptwPCkz8ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=f+oZFbsr; arc=fail smtp.client-ip=40.107.130.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ix8ueA/lw8y4zDFf5xm7bMLSCsqBxwUVQjxw8U/6pK5dmUFe+98iwP+nNcLsS/FNCfGYmZ/bsHksHCKMa1x+RrZdiPQsZddi7SvR5kKwyFZYJo3maeYwKdQf07ZJUc3L4/geuqRbymjtzFZdEsBlkItLrWPSoOxsX/NgPpQ82Eg7XyPU328iEoL/dPD+SWW6FXyaglVUqWIJPixZF/otR7uBUUZUP1B5l3FD5ES1rI+pZbi4b+aJVJHpyb1X2yaEae+oSUDmXhhk1+urv8e41xczgsye8kfy4He0ljflC80VwDPtuJyThuIIMvys8b1d8G7OnCrlAAL09fj9wBmF6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5/h17PUjNI9mey/DhpLhEtaIqbvYTS+yqLR3NNqI8I=;
 b=Xovbt2WlNb1mMdNcQhgS7/jaJXOiElEo8+mK6dcboHsC2YuI9RLYggV/saMKovleBIZhJmTe2x+n2Y/sqsysXuTi0QT52HkK+YtemhuDzFnpKRnvTzjKAKdTW0EpR45rrVuKBZCgKO52WFOXogYcBHieydbmErfP2rFLrxr3qIrY9mXKFC50QgwfYL5/BWPuAkfIUe81m0qlVYAWjqBgp2de5J8auwtj76Cgq5z+ePDo1iLmVVI0uiuHXTun4DrnVXiiVKe3PQl+3Au62oKqjp3fV9owteNcLMZY3TleqiJbRiWOeRqYgzXBLzquCZyM26neFSsjfE2z98a3mDoleg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5/h17PUjNI9mey/DhpLhEtaIqbvYTS+yqLR3NNqI8I=;
 b=f+oZFbsrAdpKwdRj94HlxKIr6IVP7OsyOKKU0jsURmQnto94PaPs/905CX3jbF2MCVOTyDgqFS3A1nTAWHtg8ckUqHVLKu5A80Vl7jSuAu0HyfVhxTMguAPSYAyFJU9AtFq26aHhsWjIGEErQjNwfgqkhecrIz+bJmKkDfBhlWPFxAG1+SigFVGimehu3TGKcFR9u9gnMu9lrYI5K3aT8vuXAJHdFkFOYSpFFR2KjMYuJGVdlhS9f81uZdpPDnmjMBRBwrOL4XjXk0Rq+GUl8gX1/4iXwO4dXXPGBjfxMPksuR03nbc6R4TLyGhqBTnmvYkoSOGjfFMD7vpdLSbtcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by GV1PR04MB10349.eurprd04.prod.outlook.com (2603:10a6:150:1c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 13:15:14 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 13:15:14 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: frank.li@nxp.com,
	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] clk: imx95-blk-ctl: Save platform data in imx95_blk_ctl structure
Date: Mon,  4 Aug 2025 16:14:49 +0300
Message-Id: <20250804131450.3918846-2-laurentiu.palcu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804131450.3918846-1-laurentiu.palcu@oss.nxp.com>
References: <20250804131450.3918846-1-laurentiu.palcu@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0015.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::11) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|GV1PR04MB10349:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ea3e46-0d59-4bab-9c80-08ddd358f2e2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|19092799006|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?29J603uIn/CIn9/SFOoWyaO4HSt9L7VcGZFdcp2TPTNMEnGAfENtg5XCuff6?=
 =?us-ascii?Q?7Nto2DTobjlL6OgUkcS474XIalTupPrnfQJ3/lU255xWumVeSyqM8AEo+1mm?=
 =?us-ascii?Q?yyc6M8qlMPj3sOfqpzOlIR7nKZFwBV8nXRcGvrjJJVqcPsVh3Yx2PDSZafMI?=
 =?us-ascii?Q?kKrXx097Nc6MPuZKUTZjzhgzx7MiHwmWCIcWPmM8t9GETV7YBgHxa6jcYU6W?=
 =?us-ascii?Q?oloUZ6AAjlIHu3r6Z3yYm/XHuyRx4AyNGAlYu2fyZszQLMWSRLtEcjk74U70?=
 =?us-ascii?Q?dHkgTosf78rRpquVpSxhqy47EMkxIVYKUuuIxYb5TpOTZrPQx09hAcbk/afQ?=
 =?us-ascii?Q?eMgE4M2Gy4HQrG+TPqUN+Hu9TZ+16Sq8LgXRSweUKzqaLOh1Q+989QDD0Uex?=
 =?us-ascii?Q?B4Hr0ExYof9GL/ce2jkYo1BpqEpIRHGfF6xFU0HSAEjE2NFvLQaeHT09ck+t?=
 =?us-ascii?Q?JBGdtP2Ke+Lv9SlAq2sgUF8rfFcsbpVMckHifQHixsELmiweMArO0c4HkdCn?=
 =?us-ascii?Q?b/dQhE1kvWzuYkItKMg5rnEX1yVHfkBtWarkRqFXjDNGo1uYMNJ+Qp9HVfPv?=
 =?us-ascii?Q?NL/knrejV5Nyi8AK6wQudG5moU9/q4by20iZ36Z4tOvBbNKfkjY8tnszcSZg?=
 =?us-ascii?Q?bjcc0GiG4I7cScA3MsR/ic7qSHFE+xsnqt2C9+ZDwWZyD04hG1rySFNVg35M?=
 =?us-ascii?Q?bDUNAI4JoD//O5+BxSE6FdASoTUam8rz0k+iEkoLEkDqL/jg4ZK3zBuIspZN?=
 =?us-ascii?Q?EPIz43+0y3oiKaZbr1fouipDEQ6qd5GtlXXF/3d83c8FgPUaOmBFxQpBPFAa?=
 =?us-ascii?Q?gRPVlMNDP9XfKUJ9StnIa7oEKOe1q2LBJ4AJWTuQv9sK2OTNm7Vynjzs+a2Q?=
 =?us-ascii?Q?avhnyMGvkJ72giO572Qvzip5SoDwZgiyaLB/YRI/PIftkDPzYH4HqcFz7GHJ?=
 =?us-ascii?Q?MspDd/rYysjPrWXLZbOxLraBETvjVGLuH4bo1ufbUUFcf3OA+xFyATLcs62J?=
 =?us-ascii?Q?TdBTtfypbn7tAzti79AAlUJBrFAJaHFUDVTIy4bFd97NA15cnoDPQV/MCojM?=
 =?us-ascii?Q?sR0KOsvcC7oZ84tOnZfccZdCk9OnoEN0Fp9EQu35NWhWOPbBcxjR+mn+VQRo?=
 =?us-ascii?Q?rEeiK9ZQiZKp9XLUa+CLtN0PXlaAlvA38MJanIF3sJnODCS8Mha1gtEVSdMA?=
 =?us-ascii?Q?f8u9iHl39R83BPkqlOsOFNsZQFO6AG3BRbjddPC9Gpb9Lnqng8s8nGpuuL5M?=
 =?us-ascii?Q?qmwe7aro+b99ikziS+Lvn6D8/r+Sg9AznAtpUXF39Zakd2LKYwKKxXa+NPBM?=
 =?us-ascii?Q?VtJJnIhX3A+Woskre0zyjn6lAZbWdtQVVArLjGmrDuhj8Gaxp7vD3Kef76si?=
 =?us-ascii?Q?z79Slejm5Ai0oruYaVCIvyswkxi7YlNwZiyEkyhE+zdASsMca+zTfxi1Ux3G?=
 =?us-ascii?Q?5sHv1Zg5hvY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9135.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DR/7pR4A65q+queJ8YPxRGzi6T5WIBa5CyK2qwPQylH5M4rDWI/AUmLSw7Tz?=
 =?us-ascii?Q?KdDT92dTLUYa8Mq2bROR0TyW8MmUrszctNdXTGQzXJIZvW6XFHGqXXfFfHpx?=
 =?us-ascii?Q?1poCQCGk6bEnkGr2fm63JV1q6bs+RTOZfSIUmT2dUDdYPGedkURqXsrqxXZC?=
 =?us-ascii?Q?FFR2o1ydVqaDseGfjEqDmsj1x18RGbgQq0IYpHI2OFjjTznRROKHQAPCND9W?=
 =?us-ascii?Q?SIA4UdUVtqChAOO+H/jpfBRS1bGlKMydaTpWDefwyW3t4ryjMxkHtii/lr94?=
 =?us-ascii?Q?fV7THXdpgFcr28ZO9f+7Wrm0vI8JyMEcJ3efjZEYoZZBavxQbQ05w95y+Z7+?=
 =?us-ascii?Q?OjW+2XfsfNafPMVO3DuBWjzj+u4iC02ZjUxG4/Fdy8LIwERB/d2JQvz2yvNC?=
 =?us-ascii?Q?KWjCcBviorFrfFJ0z67HpS4sDPIO/40olzIbKyWNTO0wBCcaXhwnqDvHQ5Ai?=
 =?us-ascii?Q?dmxzX5JWONSpMIrxnoeOh1oivpzP/p3JCrHit7jclc+m/I5cO1esLpOwRRNu?=
 =?us-ascii?Q?wWGv7lLyG2aHw/5JyGJHA4TSNnjIkq17GVUa2H6KVhK+ONg7HjSfFCxUusNp?=
 =?us-ascii?Q?Go3Dl8fqWochr+I2X+yorcMa12aCj2taTdltIgfzsDBcIpgKJYuRZu1z1HLK?=
 =?us-ascii?Q?BMzsIltDfiBHZ2Qay2pfJL4K8dz0rrrPVUSseOYdRO3XXz+Z3ULVmlmm2Bao?=
 =?us-ascii?Q?XA6J9uCRRqK4bINW3FJn4y4aKyFFK3QEv1KLzZZah+9V4/8oqNLIUH6l5ePF?=
 =?us-ascii?Q?L8kTP8ENlXDhsbuTclEUtMlgPrNR0HP45vFzq7T+1QAoYkxS/hxPTV7J74bL?=
 =?us-ascii?Q?UKznP8TCBxqlHkdDyPid7ArsMHhvyqK4e0a6vf4XPyggNgFisb92V5XPu2PV?=
 =?us-ascii?Q?pT0xt0BU8jhwaNEcYALu7nhdZ28Q9js5MnlPk0Pou+K5FeHKrAhVMD/caY/Y?=
 =?us-ascii?Q?UhmTqrd/bhIwpFlrpqcpDclHhFC+EsR9VRx2H9nbfuXjAwEf4HSm7DXyZLa5?=
 =?us-ascii?Q?QnTSbxfjUbOu4ZyHhq2MTnfXQyPzWCtOm2oRD6SwWOHK/QLeUcdVVez/SvGT?=
 =?us-ascii?Q?wXUmUaTbqN0VvcUYhDq5FJwZUqaYhNwWZ8qvIytoVEBiG1gTpJZ1cwd1PfYL?=
 =?us-ascii?Q?trDUgQlpvwhclyQgJ1cP0joRJDGLRnqp9A8JItr0BCQQfT2jSpDvyFRMi7/M?=
 =?us-ascii?Q?Ea6M58QK+7EzuIWmxdn5eGSXYzTabPeHggdgXPCeuAnM57qvApVLDTRjcNXQ?=
 =?us-ascii?Q?FklBPouFSxVahc9QVMTn4bEVqiDsbTNxPjIMwpXh+lB5UoCm/fVqfJ+FAYue?=
 =?us-ascii?Q?LcYA2UnF7rmkJyryS/8Xp8P2TVLwcBVar9wIYLquYQ7NHGlIPqbYNYXNVJh8?=
 =?us-ascii?Q?xy9QFFJz+b2QBSew7gi8dz53MTdPRqQv6g3CSaJzE2fSb959omxPrnIUBRrp?=
 =?us-ascii?Q?rLnwnw3C7w2gZnUNZZV0zcsrQYncDlArMo60/6pNbXC/xjjV0tqnr7fSEptO?=
 =?us-ascii?Q?CIS9RkdEdM2X9EVloWUol4JBr+Eplzk4IzlEavOUSnsG+CBrvHeoTU6NB2Of?=
 =?us-ascii?Q?qdWPAwGrXRqelC03dn4OOmq+VorjJmV+i49ZnV+jpWXVQlG8W0HnJXLaZQax?=
 =?us-ascii?Q?Yw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ea3e46-0d59-4bab-9c80-08ddd358f2e2
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 13:15:14.4322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HbIZlVVz6ScxAxEq0lGMFOQC02pYPVaiiqJzukDCZGHDD37KUyF1P2QaLx83lj4T4wQL1G6acLcVFozWsXC4Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10349

Add a platform data (pdata) member to struct imx95_blk_ctl to store the
result of of_device_get_match_data() during probe to avoid redundant
calls in suspend and resume functions.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 drivers/clk/imx/clk-imx95-blk-ctl.c | 36 +++++++++++------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/clk/imx/clk-imx95-blk-ctl.c b/drivers/clk/imx/clk-imx95-blk-ctl.c
index 7e88877a62451..c72debaf3a60b 100644
--- a/drivers/clk/imx/clk-imx95-blk-ctl.c
+++ b/drivers/clk/imx/clk-imx95-blk-ctl.c
@@ -36,6 +36,7 @@ struct imx95_blk_ctl {
 	void __iomem *base;
 	/* clock gate register */
 	u32 clk_reg_restore;
+	const struct imx95_blk_ctl_dev_data *pdata;
 };
 
 struct imx95_blk_ctl_clk_dev_data {
@@ -349,7 +350,6 @@ static const struct imx95_blk_ctl_dev_data imx94_dispmix_csr_dev_data = {
 static int imx95_bc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	const struct imx95_blk_ctl_dev_data *bc_data;
 	struct imx95_blk_ctl *bc;
 	struct clk_hw_onecell_data *clk_hw_data;
 	struct clk_hw **hws;
@@ -379,25 +379,25 @@ static int imx95_bc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	bc_data = of_device_get_match_data(dev);
-	if (!bc_data)
+	bc->pdata = of_device_get_match_data(dev);
+	if (!bc->pdata)
 		return devm_of_platform_populate(dev);
 
-	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, bc_data->num_clks),
+	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, bc->pdata->num_clks),
 				   GFP_KERNEL);
 	if (!clk_hw_data)
 		return -ENOMEM;
 
-	if (bc_data->rpm_enabled) {
+	if (bc->pdata->rpm_enabled) {
 		devm_pm_runtime_enable(&pdev->dev);
 		pm_runtime_resume_and_get(&pdev->dev);
 	}
 
-	clk_hw_data->num = bc_data->num_clks;
+	clk_hw_data->num = bc->pdata->num_clks;
 	hws = clk_hw_data->hws;
 
-	for (i = 0; i < bc_data->num_clks; i++) {
-		const struct imx95_blk_ctl_clk_dev_data *data = &bc_data->clk_dev_data[i];
+	for (i = 0; i < bc->pdata->num_clks; i++) {
+		const struct imx95_blk_ctl_clk_dev_data *data = &bc->pdata->clk_dev_data[i];
 		void __iomem *reg = base + data->reg;
 
 		if (data->type == CLK_MUX) {
@@ -439,7 +439,7 @@ static int imx95_bc_probe(struct platform_device *pdev)
 	return 0;
 
 cleanup:
-	for (i = 0; i < bc_data->num_clks; i++) {
+	for (i = 0; i < bc->pdata->num_clks; i++) {
 		if (IS_ERR_OR_NULL(hws[i]))
 			continue;
 		clk_hw_unregister(hws[i]);
@@ -469,14 +469,9 @@ static int imx95_bc_runtime_resume(struct device *dev)
 static int imx95_bc_suspend(struct device *dev)
 {
 	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
-	const struct imx95_blk_ctl_dev_data *bc_data;
 	int ret;
 
-	bc_data = of_device_get_match_data(dev);
-	if (!bc_data)
-		return 0;
-
-	if (bc_data->rpm_enabled) {
+	if (bc->pdata->rpm_enabled) {
 		ret = pm_runtime_get_sync(bc->dev);
 		if (ret < 0) {
 			pm_runtime_put_noidle(bc->dev);
@@ -484,7 +479,7 @@ static int imx95_bc_suspend(struct device *dev)
 		}
 	}
 
-	bc->clk_reg_restore = readl(bc->base + bc_data->clk_reg_offset);
+	bc->clk_reg_restore = readl(bc->base + bc->pdata->clk_reg_offset);
 
 	return 0;
 }
@@ -492,15 +487,10 @@ static int imx95_bc_suspend(struct device *dev)
 static int imx95_bc_resume(struct device *dev)
 {
 	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
-	const struct imx95_blk_ctl_dev_data *bc_data;
-
-	bc_data = of_device_get_match_data(dev);
-	if (!bc_data)
-		return 0;
 
-	writel(bc->clk_reg_restore, bc->base + bc_data->clk_reg_offset);
+	writel(bc->clk_reg_restore, bc->base + bc->pdata->clk_reg_offset);
 
-	if (bc_data->rpm_enabled)
+	if (bc->pdata->rpm_enabled)
 		pm_runtime_put(bc->dev);
 
 	return 0;
-- 
2.49.0


