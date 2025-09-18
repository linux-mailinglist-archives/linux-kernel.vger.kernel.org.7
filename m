Return-Path: <linux-kernel+bounces-822263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AB7B83685
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4115541FFE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B052EB5B3;
	Thu, 18 Sep 2025 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZUZCMJc7"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013058.outbound.protection.outlook.com [52.101.72.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF4329E0EE;
	Thu, 18 Sep 2025 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182427; cv=fail; b=j55bfwzH5dPwf0qyCN+1UDtEw7jUhw99KS9tq9+HacCElR7GtU6rjwND9evGJk6zMWVknXDt8hYS49pa3kbbmT7iTyQ1VJtbGseRRC3F2r8OtvkTc/OChOwtBuSI1F2pNmz/5FNJK7jjgNY3UGV+S8nYe1UJI8/kuq91tUMCY54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182427; c=relaxed/simple;
	bh=srSCLzrpSkswI7nWNNMEPryz/2tdEWP2OzQSQITi56c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aWKqq4ITAIigaRWEMYM4PL/wW5d+AejClKA2Y+me9E3AZ9PFE0LkO7RRIKfTeqmSKZaqAfXRjDwClYz4/dCSKnilIVrHoEWGIKLyPyJw2evk2jROj6YDwGCZacFMmAopKNWvjianeAaw+q5iRAI5ieIo8RQYZmrkCpfe9i0wfPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZUZCMJc7; arc=fail smtp.client-ip=52.101.72.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MoLTZXr68IGNWhNvQ4+qY8+F2bV3lscjuFcHH6ZaCc9mwl2nVZ9MWmlPYjhbL3uwXTLKSv5wY5xFmTyWWw42gzWs3YZ0oE+8Am212hNsLU7fhC7WDCJ6LNfgw2WzfK1pYV25ooLwe8L4b7TTHhDBWYhdIXVzg3Y90Gao98Njn1+SszmamF4pmzxbbezPPZigKdvUbhgBRbcvznnEHt5ozbk6/vRZxUeB/j0VEq8b9jjSGM1MSNpfbEC5ELj7Uu+DQN0LvSQb4eYCp7GPMmMg4oFmGffCdfn9Faenbccvtuz43kw+0YHzUDhVrNXC3vTCTuxmVqKxAGK/CTcmIhsr3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srSCLzrpSkswI7nWNNMEPryz/2tdEWP2OzQSQITi56c=;
 b=S2Jr/vk/P5rGpJ9mUUxcRMUhT14fNyZJD5FYU35JxDZvBAsI1Inr6nSFNEh5dd3Kylt08tGWl3HWBg1BfRcu+cLxe1WQPU2wE23WgkJoJykxHGNk87sDBbmD8NAv2qfSri3L/FArtYPgbIgqLiX7I4lKLdrQs74iFXvFOEwtLhBtHsf/t3uJmUWrlM+fxhiE313XJjVrJcibgL1rhDJ3MN08XfeVCYCCMY/9yTU5ZnQVKC6Am7y5GmB2861l6CCkbf0QTuIVTClkjMIWt4D8GRQ/GA0NmZWSKAcAyzSfKlbXltMTsiSSzOVdtb2xrvDISHstVPn7uGDr4vFZN5gGjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srSCLzrpSkswI7nWNNMEPryz/2tdEWP2OzQSQITi56c=;
 b=ZUZCMJc7Y6cepASPeYHk3osnG7/GsBVx4ARwOdH+UhArVS4e8BUtpL3YIJGMVKGh8gCob0elIhcmgzod3RjSeWMA/e4pvdUntdCf5Y64MvGuQfAEay0jVUzwSAfZwgvTIm2zsRrblBxWITO49TDCuSQye0I8fHduGrDLDg1jwfJn/iPz94d1wxW9kT+MdCdHltRgzKTHhRSq44S2fa0GpuPY3oNJWXeB66yLrkW3JJ7Fv5xR/Zt91VONWYu7OsCiufw98+M2CRApmXjjC5yDNJhwKI1abB0L5yrorb0d15+2MSullrWwyJGcPEaDDLQOj5cupddr1tc5/eJRN6VZrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8268.eurprd04.prod.outlook.com (2603:10a6:10:240::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 08:00:22 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 08:00:22 +0000
Date: Thu, 18 Sep 2025 17:12:00 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] arm64: dts: imx8mm-venice-gw72xx: remove unused
 sdhc1 pinctrl
Message-ID: <20250918091200.GE23028@nxa18884-linux.ap.freescale.net>
References: <20250916153216.1042625-1-tharvey@gateworks.com>
 <20250916153216.1042625-6-tharvey@gateworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916153216.1042625-6-tharvey@gateworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB8268:EE_
X-MS-Office365-Filtering-Correlation-Id: 398361b1-e221-4d52-e94a-08ddf6896b11
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?r5/o12Jn9J1q4B63yZJUs+ZK2GPBH7iLpG6LXti1QFEIlTy6oLzmz4lYxjB6?=
 =?us-ascii?Q?rq4JUNrC1S1jev2jLK1yMTh6DpyN0xMbhtYV5CetgBqtVZbnjOWTFWhzZWzM?=
 =?us-ascii?Q?0pk3MswjTKJuJKxZ6wD5yMTsuXrurNxohDxKS2V6idp2Kt2/LHjSgUM64oxq?=
 =?us-ascii?Q?9Nn9zi9gHYlFTvbtL53qX7tT8utsDTCu/Fn1Wb3gMFu0KrErbU4rOgXRRV+r?=
 =?us-ascii?Q?5gQkNuC1P20PuSYgsQwM10aMNY7ObznIdbArVHE2yWkfF5xgS+8lKrLIKQAB?=
 =?us-ascii?Q?yr6+wxGu8fu/R+EoZ8zmGL3YjRRvsx3jzdJO9fd6ReHHOKPbW16wmz/gz7oh?=
 =?us-ascii?Q?o9wbw9BPA5ppUPZ+wq9+BLSfWxHwPGp1QxMBBlrqNiRlgrQ3ksoGat/zu7gB?=
 =?us-ascii?Q?cpxMPOX6hX5cgoejrROINa5lAYjXKexQQKHdUKFUzE/fxEjKPzM7AB059Tj7?=
 =?us-ascii?Q?2sbfKvQJPJEBVMXz5PcC0Px+2MuSPbs3D1qiykf0Cf5UN0Ic42v1zs0pOpcM?=
 =?us-ascii?Q?qnKaoWBgVI23Lft0wJDQvVKicAuL5UUaZ1LYTH1PJgttkPc1CjVx0IacM6Ga?=
 =?us-ascii?Q?X8GxJJfYgzzvntAxJyU5v5tGjGkqH9BbZ69slBDa8A8zcX+TA9LmGsUPOzLG?=
 =?us-ascii?Q?TrwpmbA0ZFnyHfD5n9aslhjOFZnMe+FmxUkD/STKbKcqvJr4HWxTvxyiHDgF?=
 =?us-ascii?Q?vFmy4uGaKNSdH+9AyRvt06ONEnnidiLBk1MPZ1oFxxOjtd3loUp/YSOTe5n7?=
 =?us-ascii?Q?faGOOUWMailkDdG6vjSlmWdP+BUgeHRsBOndZGAimSnw2ntyb4V++VoYZUOi?=
 =?us-ascii?Q?lc3xsprQDo04amLZ3XBCGMxY71TFiQ3FFfRG8Csi5R8o/li6oa/JCLzBq96p?=
 =?us-ascii?Q?5EQZmwNmKc+mVRYbWOUWkEwWNKLx9wgZR6aeiXK8mYgAvaREGRdoF7jY9Flt?=
 =?us-ascii?Q?czd0fRUFsdYDTlWH36/RAQLMcpCOzxxNrnM48X7ufHREETaH750Y/mL3UwR5?=
 =?us-ascii?Q?cC1rEszRTKiw1a60bP8enfnLEdq8cM7tnlXxVzVYSczCe4X1DGTiiJbdhyva?=
 =?us-ascii?Q?jpkW/BWKjpU+WCo35iPazQWh6+PjbYvwH2I6s4vjQgP22IJF7NXkEzoLqCL2?=
 =?us-ascii?Q?Ig6WZTzeMp1W/TRizXpuX8c3KZEFBL7G8ZeTPpnnzvIxKh93H3pB7d8uoL8d?=
 =?us-ascii?Q?F40lW2IYKFrIO7vkiYmEDeOmBQXyoBHG0Wm0ZDdiEczw12AdOWLI+UrOXxmg?=
 =?us-ascii?Q?r+Iewz6V+MjDJT1VKoW3ym/4YUN7gOjjzCB8V88FSN5nBbbENCbBIRCcvJ0/?=
 =?us-ascii?Q?ysZ1CyVDKBiTenXmN2ycfHqtjvWFG2/EISrtLDtqYAo4bBHZDjpF/I/L89Af?=
 =?us-ascii?Q?tO607QKt8qEoT/6VkFIrhI3n2HJeDIQopOTpvTbs1MlsrLfO9mJbMn15gOpD?=
 =?us-ascii?Q?p0B9Cr3jEYbfh2NDzQgz2xfbxd30L8MMWBFmscD9utHar3vUhopx2A=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?wC9IdbvLIJA7lIxroOUprR+OOhXatiExm+n4Mf+16XGcMWJeKxDz2cqyZeMC?=
 =?us-ascii?Q?k1Si0S/NAcAiO9YLd/MLMbpzZGvMOO9txPNiR0EQKRlrUHVQbTPmfLH9x95D?=
 =?us-ascii?Q?5F0pTnUsg4fGqH9CyXgVfP2jaBz98Ru6wa8YTknQ1Hq1Tiv0A+ZLkkPUkpU3?=
 =?us-ascii?Q?kCU5EbxCBRgmIeyUqQXmFqIQiiFjWlMdaHUKjSNKBB0sm7ZOUYJOXX3ccrIt?=
 =?us-ascii?Q?6lRHb1hWO4eO6tB1hP0xkWIkZeMITkC2pSjTU0G4RZFTdaOkSJQ4beQRh3HV?=
 =?us-ascii?Q?oKCSTI0pPsAAApuL0H9ireKPLTX/ZUtkLMtbeehsaL4Zsxq/OLJt+u5qtP5T?=
 =?us-ascii?Q?rLrZRUKQpa9dEePMronZROkJUXksnNWkdeW+igswY3HBIedkO88qSrUYYzpf?=
 =?us-ascii?Q?aixt6KaWz8Qc5TP3f5rSrJAZVK8tsaqFnAP+pWwbzee+boNUuEjYB+LOONSS?=
 =?us-ascii?Q?SFzmjeVi0rmB1cjIAHJUAsXTXAHFDIOismnowA8DEQ4jJF+IG3L6vf0gr0JH?=
 =?us-ascii?Q?xth9U536XsE096+BCvrSqFnckP2eXcbRNcJZZwLaIJ8wkYm4ETGsHifZIUV0?=
 =?us-ascii?Q?4g92Eh6AZYEPMJzcTj42TI9XfnVPhEcLn4oytZB/NtEewg7Kv9XK85WlDV8J?=
 =?us-ascii?Q?C0xwEimktS+YZUfebwZv0c84aJH2YRoxkgvEGGli9mJjsuQCnzyhMYMmUCFt?=
 =?us-ascii?Q?w02Rj+jeCT13hBCeaMkNS3YjMUDrTBQ9/3/qCNaDyMOcYyPdwacppMZn+b9E?=
 =?us-ascii?Q?sXqXzz+FIJBVXQkO8xrJPf7hWuknyca6+MF1UzrBMu/kmIIwe5wkid3J5Jxp?=
 =?us-ascii?Q?+ZFVVYZUq7CNF6ipJ/RnYniZ2f+dGsNMwMBTy9Ht31ps/xchzGkp9v8yDaTn?=
 =?us-ascii?Q?3OkghHvRtcnVQ73jEOphrzDovKkEXyPkh6Q8Xkp7w9n+RQxBtffN4j2M6MZ8?=
 =?us-ascii?Q?AUAX0ZY+VgChwUrBOiT3NEeR3bKs+jlyiUd/WZOgJlQS7laxZQfeunOp41Se?=
 =?us-ascii?Q?uSuluK6IuIrKzTbpBIjTj+4fNXHredH6GPj59S6LpABgo/TvNRVl27zBuyTn?=
 =?us-ascii?Q?+ZhwGh3ER6FWOVOyWtuYRuCElJBR+gsmPk5ZgrDKZprR0kS10U0iNyptISCv?=
 =?us-ascii?Q?wHdm+0zBDFZI/usfwhQ4sR1f/SsnmnTbh25pf6LaD4mGeuc8HwJc3aqJ31R4?=
 =?us-ascii?Q?Wa+vB8MdBLj1zN1yvRswix6w63lL2M+OTOMrMsAtWATe4e4+tuBOxdg7fljZ?=
 =?us-ascii?Q?UOLLYpwWVF1r1zKPFGr3O6WWU8fYUIfRm/TERhsWd+KTmkLY3DaqKTf7utTq?=
 =?us-ascii?Q?s3PPUA5Y7e9G3I7GLDHyw0rIIV8l8sxBK9uLUuhcc4XKSrBuiKB6mu/bweYZ?=
 =?us-ascii?Q?oR9pKqH/H9msZWMuhcd+TevvzEndrKc3WLa1zEOyQUmlTLdeX0Q4asi1VJdn?=
 =?us-ascii?Q?B3EpPcmi4NyQCHcHirHZqRoOvbQjzDhNnpQ76CDDC+mxBwHZFUtxU/QF4dDQ?=
 =?us-ascii?Q?5Q6F90crNLIDGql6k+yhLtMC/TfX1A2C9C6ZdZJ4NSr5V+DIm1HA52MY6x4d?=
 =?us-ascii?Q?jlLsTOy+7RB27EDnSiMdpm/ouI0BnEAB5dL2L2wl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 398361b1-e221-4d52-e94a-08ddf6896b11
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 08:00:22.7105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGFUtyMgOgoOcG4ZaIO6x9Uo7qwdjx3n+ssMN1NUwTBOT8BHXSGfMsJqPzD2v00zOzGBj7TMRi+yP2sjOcQt8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8268

On Tue, Sep 16, 2025 at 08:32:14AM -0700, Tim Harvey wrote:
>The SDHC1 interface is not used on the imx8mm-venice-gw72xx. Remove the
>unused pinctrl_usdhc1 iomux node.
>
>Fixes: 6f30b27c5ef5 ("arm64: dts: imx8mm: Add Gateworks i.MX 8M Mini Development Kits")
>Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

