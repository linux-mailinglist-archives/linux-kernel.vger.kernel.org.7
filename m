Return-Path: <linux-kernel+bounces-738916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F6EB0BF05
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DB4E165B2A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55BC287258;
	Mon, 21 Jul 2025 08:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BOkEAFRb"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011056.outbound.protection.outlook.com [52.101.70.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82511E50B;
	Mon, 21 Jul 2025 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086913; cv=fail; b=SUI+YfU69PcVnRnboD6NZVNu0rsqbelGNVqY0EDciMOvDUmUMvfSOtr5QN2V+D46wqD+PLPuXqcpvMPBVjAKw9/9SSLqDyCndIhWqMLekQ6ukdPlfDDdx8Qd+/iX07UZHZbeLylY2l0ChRWadiWHwY8oLB5zO7B027I99Qq23h4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086913; c=relaxed/simple;
	bh=MVj1o3ogN/MNe8NhLNIaWmhuMmqAEAxhhXgS+fmwsME=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Mlg595MSxFhTSPuxm8OA2zt3ZoGH26Kyc7hcS3cJe24DNzN21fzOOBAO10UjEBqdtGMGX2v4bZVBa+n6K2g/yl/9TXK0VJEpc9ljXzNsswVQjDKe5t5xxgwddIlXRepL8sOEuVoplUaNW5uc0uCLYOdghMRzBeDAGCQ2+gwG0wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BOkEAFRb; arc=fail smtp.client-ip=52.101.70.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMDfrfuzU0KRFHD6ebgjGGq9lJEWpUXI3OFPA/ZjOjOvWY97+1e4yzJT0gsaIJcwWv5iyP3+odtSxBbRNfnDL3bcqF86B8gwkuDEohhC305QYVGQym8cMKN41btvkk3afrzmRIF60D5OO8aCeVOhWB+vffla+OVGtl1fMr90eI0g8KqLA0EOEvUgSMRXm2KE7hSyEZrowHEwkRZ2KRoHEbhprKaLehtdEvimgNA5C77hSphjdDKyiTgXqwXzvuu4VVQvntl7VjBtlnzINQ0XYBxqjlUC8lD36Z4wX6wZlDv8Kdr+11FEJdeEEdykAWX56e11indG98rsylLpzZbyLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaKsJ3q9mHPrJYZZ1TGNMiK6dDC236d342mFgSbjzHs=;
 b=PoMnFFnJ1DtUaXFyEAOlNM2h1V8d/ydXkEs4aE/yePj/M8PBnDT2WfAwu6CT8tLuGQL4KnTL4k0aeUaT79H+Jmssq5b9GLcbgAZw/ns5SSFZHrcrVlvkDMkVAlW39vp8lsjdZ+01o2Fptmf8s1Fv27k0hee+zm20ZMQDO5p8tPVzOu6KBFhf5ic0oMuFLwu/qzOeqxIdscSl7y1Rhv8icYNgoO5mXLmeSRDcSiaeYLa+JfLLtPpTvSwyg1P1vBFwrONLHHSLQ1PCUpWLxVmvOSPt9stcC5SQAZ0OVc3D4Sh5mLwCE0+V2u2arDsBjfMJoINynuyRjzveflKj18hUOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaKsJ3q9mHPrJYZZ1TGNMiK6dDC236d342mFgSbjzHs=;
 b=BOkEAFRbte1khCXcAnyUhdPcxOfciFbuZIld/b6z+wV4cdS961gfd9MuJ5Y+DgjwOGMVf4PeZNsHTP8UjVyS+Q4rDFvnhhluHmozDMEg0TffyH19IPeYpfOm62c0vr5yRZmdL/og/DEXnHWap/E4DQBIzGDShzn8aKCWOANtDbayzzS/OIK67+y5L28YKe2goAR3xdIgOBrXYW8MLKSnKQjc45/vSf/ulnRlWaiqMwQEQCo1KgbBU/OThi2Z6NLke8oFGz6KBzYH63/l8VfnUjV1W41Ged81OauwwK7FRwbbmsjlYhq5+qUtLYpkLHs4mYLPQNvECsgXsG/uiev7WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by DBAPR04MB7223.eurprd04.prod.outlook.com (2603:10a6:10:1a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 08:35:05 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%5]) with mapi id 15.20.8943.024; Mon, 21 Jul 2025
 08:35:05 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: [PATCH v2 0/3] arm64: dts: imx8m: support more sample rates
Date: Mon, 21 Jul 2025 16:34:30 +0800
Message-Id: <20250721083433.25711-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::12) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|DBAPR04MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: 95be9f7f-0d87-45b7-8963-08ddc8317dc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tACQtOvxWW7ggZD2ikbsesUb26QmvXUTV3xKO0S6kmkpASLUuQUNciPoMzXs?=
 =?us-ascii?Q?VuYc5RagfuUeZTZ40AqmhE8WkmpPfuHxaadlC4X5dnBkbdEVdiVMBBxiMofW?=
 =?us-ascii?Q?qqTu22dBRlc5KxTIp29qETka7aCcnmVuu6OjdAnoQkWHFcIdQ2D0c7+dHsxt?=
 =?us-ascii?Q?fWIMdsZYM6qzmEOBHrceNGIDXbV10Oc4rwKHNKYGglCYhYqpl4VlIZ1JT115?=
 =?us-ascii?Q?xPk2YCvuUxCjojq6uZNVYdSzU0sjyYROnAgB9tWmhLaIp/5h7SknVfn87fHi?=
 =?us-ascii?Q?pqSFetzEAYB7K70UozVGQgr0N2gGxynJ5ETgXUxjrwST9TZiP5orZ/yqVYik?=
 =?us-ascii?Q?EMtu/JRR/40/zhHzD1M5M305MSj9eg0CLR3KOMLfOk/SPFOr6zZ7eoGBvNJo?=
 =?us-ascii?Q?m6tmcL2hnEQ8qCySDXxQDSz0bGcUKz1c/E/vaMaE4GFHUzrX2NfBXWaRPHJf?=
 =?us-ascii?Q?J36Z7nX5IpqL1R+cAkmXxl23O7XIi3iWq/VsopPPWYMsqMr3oLZL1HFMU0ED?=
 =?us-ascii?Q?8+o7XQassiQJKdpreH9pCzbzO8U2gWzoDY1uDBkUrpKmcMw2dEEHUrZF6pcL?=
 =?us-ascii?Q?Wi5na0azXeUkLDbmu9Unr6CldRA6XxMg379xYBkS+nfuhmy4J7GOZGh4KDw/?=
 =?us-ascii?Q?oN6fwu4lAuw/8ewIzRUrkvNqJC1Vc5JM48vcxRXcqhtD/WoB8S1LTvkDffMh?=
 =?us-ascii?Q?KF0KoYoywVbv+qYIp19P2bL+avg7KRcVK4DRPfEpz6KrBhfF8nFW5agHTc5d?=
 =?us-ascii?Q?TPa7cCiYFWOsU2vG6wpYXqdjEsVdPDV7FwELXF8JQY1AopLPUUOP1VXwSqgR?=
 =?us-ascii?Q?UDOpFWY5Q1Fb3RwkXMurr3d194/A+dtte39Y7zO+wOrpJpNI4UtZ5Z1IdnvG?=
 =?us-ascii?Q?1DK5j/FnYBPZlwfV/0abqSzUjF8xt40Pmg/CIvhb+GXQzEkBtAuqa1a0P+DU?=
 =?us-ascii?Q?MUMqhA4FMIG1U5Srk7Mkql1g+/VhDJZSeraqC1Z08gT2UJ+7YmXD3GrF3Ii5?=
 =?us-ascii?Q?xTpHDSiJmzG9o9LJwbJMZtBscOIRH3Hl/RPwoT4omDfMM49YTvIz/CyXJP4h?=
 =?us-ascii?Q?ODuVdv3BWb+YpliABZFdbjXg3uFboaWuNnw3g1Sry0VB6iWzWrMFKI7+SfnT?=
 =?us-ascii?Q?pYUUyBcTKekun4Bd9O1opdfz+041qNDh1JhNITpJkmYT8ayvK3n9CA5X36wO?=
 =?us-ascii?Q?hIkPdjkJCLhMjUatEKc3B3mTG9QhsSxD4Oyc/86vHHnm//MF4Ud+f080OVsE?=
 =?us-ascii?Q?nTWKWhLSaR/01SLNH8sdG/M9keY0DlT9m17JVdyeBWNndz7Hqw03QMd2kfcX?=
 =?us-ascii?Q?2CZSRHa5qKpVBC78lVPonL691ReSiD5Yl1+L36U63YZLWjoT2q33rNWW+t4i?=
 =?us-ascii?Q?RgRoM5CTz69unYKANxanGgM5QO2VkzaUrvSuflSxPr4PnuTlsRaTedKww0FW?=
 =?us-ascii?Q?cCvxVxXL3sZSFZRbBZC5XwtkOtxF6fRkdUowBVYnYKgDO8erCjk4LSsDiNzG?=
 =?us-ascii?Q?F7wfMFW0teN7RJM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cf3fKUEaC1XjbNTiHedDAITV+xpHOkIHw+HAkDZSRU6HkEBbYfnvDH7krstg?=
 =?us-ascii?Q?vCnhrMTnTFTMtSFBqTYvm3T7CUxHxQSdSw50b1BLPJ7Jd2HpErqb9bLLaRrn?=
 =?us-ascii?Q?xl6FYPozzrBLTjs/yA0ay3lttJEoDv3+GjhyPr2yHwkZ9f20nL/tQBrBIn0W?=
 =?us-ascii?Q?iuP4OL8HLapDypnUNoLDdGr2ASRPq7yFlcpJ6Elk2Jt3fGoJGs1k3ebGOpgh?=
 =?us-ascii?Q?uatllRd9E3K0GcBkdKjVw9Dw8UVOjhZjenrIXnf7a/S/wayz6qjltvxQk0Z9?=
 =?us-ascii?Q?K25pgaW5VkouSVFzmiSgIZqXtaTvzISkKTXCqUIMzvyRZ4PBrsSpZxqAcQaq?=
 =?us-ascii?Q?M3oZFA4W5v8BS7Pnp0CQJLw+hjvkU4eBsPMI/NawDDObT5jheI5dqEXV5N7+?=
 =?us-ascii?Q?vzdCrFTKbjtoyHcT23ywVx8YF5yQO0biR7C0K6SgMNR2akvTR4wE9QQGH7Z5?=
 =?us-ascii?Q?xc4e+dB5FDRrMqe0N4oPVtom8h8wG1t36Wwy/rx1hhNEt1Uso842daYM6aeO?=
 =?us-ascii?Q?wAcblv14pHStZHC79aGoCtSGs5t4pFo+VI8fLf2FSqUkUMUJhrBp12rkbWD7?=
 =?us-ascii?Q?qmAhf/uyuZp5TVBEvWhZT8Z9a9UYl4gABZUX2AHLijKsIyBIKkvf+wAF2Yr7?=
 =?us-ascii?Q?UMoyLYlUUSpooCGFRn7Rem//7PkPl2us3io3Ixrrb7lLzt3oreGR3KlE1n5o?=
 =?us-ascii?Q?mpil0xg4hWoH4NZVY6h/+wUpgTvU2vfCVpAVNwHM9MdaeYM7PGiOxsHNIFHm?=
 =?us-ascii?Q?JYnw5Fm9CXFgSTaN+d5DpAFofz4NczLG3cdI7bRvcegbm3ocFS8y89QNw1Tm?=
 =?us-ascii?Q?R7OpP8VvYY9wIa4rICkrzE1xE7Z7XDGN+u6fsseRBB0+ER3RgFiDd7due/f3?=
 =?us-ascii?Q?Sn4hcN7apCp/HXikj+5Q8faJ7ZjQOpnJ6zK5qutwwjjiaLmBxbXoeL9MgmfL?=
 =?us-ascii?Q?D4h2XomE7GIpDaztz4FEAwnivf1jybl8o+PxBUwj+TYeBBgxHnZYEkfUl1S2?=
 =?us-ascii?Q?iSO74BcsfHCcDm+UPWEXPfS1EX+SWWM2EQ1oSCltyL/yp5HSo0Tah5nBxznu?=
 =?us-ascii?Q?d2LL0Zjn44Hp21hRxiQAyf3PGkeKQZ7mcN2A2YE8UuNrsdCd40oyF4zpGA8/?=
 =?us-ascii?Q?RMEBPiRF6JOhG9wHCu5zzjedJR7Vuu4+qBs0KR74QHgaR7uisxmmvH6OvNGB?=
 =?us-ascii?Q?kCPFJwqZoMDDvDg9qKKey9mEAOgXVwo+s8H+H66GWl1/g2Ci3DUQK1xzDk+Y?=
 =?us-ascii?Q?rsLMW7hkdxfijueO5eB1DzAhp8CjQTvzG8uczhumwBW5YkzpMhgbpZnDu6C+?=
 =?us-ascii?Q?Vc+R4rE+HT0PjtNvD/AyVIsutaJmmE06fDL3MF7AIVP2uYW9t8t+qb/12IR2?=
 =?us-ascii?Q?PWJUY5yR05l8FulBY3K0wMYcHhWDm3LNsGlV9Gc94O8xVGPccfWlKbSiSNVl?=
 =?us-ascii?Q?hSEaF0OZI3DR9zGr7hciNotLzwogd4J0kOpxcPcSB9N4+Q9T0IGQVZlKBpZd?=
 =?us-ascii?Q?y1GIia1889kCJe1CmO4SBhRNlYYTJcfJgIeOGK6qPRJJw2ITFh9oMG9Lr+TB?=
 =?us-ascii?Q?iv7IejKASinhGo2UiFmv6ilhoD4dUr58M+wI/UPL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95be9f7f-0d87-45b7-8963-08ddc8317dc5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 08:35:05.2755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x4/ApFt+cPt8C+9FGajbtqmowL4hx9hkzXik3NmhxQ9g+/w1iB64ysgC+hHlik98dSZ35D2tUM+Th0/N1XqRGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7223

The wm8524 codec is connected to the SAI interface. There are two audio
plls on i.MX8MQ, i.MX8MM, i.MX8MN, one pll can be the clock source of
44kHz series rates, another pll can be clock source of 48kHz series rates.

Previously it only supported 48kHz series rates, with this change the
supported rates will include 44kHz series rates, from 8kHz to 192kHz.

changes in v2:
- Add more comments in commit message.

Shengjiu Wang (3):
  arm64: dts: imx8mm-evk: support more sample rates for wm8524 card
  arm64: dts: imx8mq-evk: support more sample rates for wm8524 card
  arm64: dts: imx8mn-evk: support more sample rates for wm8524 card

 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 17 +++++++++++++----
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi |  5 +++++
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  8 +++++++-
 3 files changed, 25 insertions(+), 5 deletions(-)

-- 
2.34.1


