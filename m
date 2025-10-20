Return-Path: <linux-kernel+bounces-861210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAABBF2114
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF9718974F6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9122258CF9;
	Mon, 20 Oct 2025 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="myddLrqn"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011037.outbound.protection.outlook.com [52.101.70.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33F41E1DE5;
	Mon, 20 Oct 2025 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973775; cv=fail; b=K2Kpj5o+W4NSOJnu/KjSqYCUOpDigO+PpKwz8JxKDlamZuThrlWXSrUqp0Wxc6wjBFRFX/hOuZd/A1s6ZGpQEUiNao0sya298ygiTJl0uBlTt4wCWk/LdnxF6JwEf0hxkUrK9aTVSKqqBFCL5bi/Hm4Dkl8yjs0Yry+T5iKTwIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973775; c=relaxed/simple;
	bh=xyzKRSpVNMfAsaS+PHlYrWxN57C3zlhXw1Bh/bCBhA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S1UfHRC8Vv/MVVIM1k1BRwMRqt/bTSjlVBVvVXZ4fJMz+uLaEZ2UhPrWp53nmkKpuy5TrGVUzlvYyp1Rq36jvzsEX3xMa0Jz+ZBVfKwlaaJl8FES0gnBg6KWcV6/f6E2AI5OAI849Dl22L97BylhvrrqgxYy1Zm6cyyuLD8xrjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=myddLrqn; arc=fail smtp.client-ip=52.101.70.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VI3J3itGrMIMI8y3s9XLINiw1j0iW/tjtOV3X1C4xVoph3ezlPJyxKSgxVnZwLyE67WmVYCIKLHHtKoZdbUOw6B/DuqQ8b+iu9BMf2vAp+xiluBqb0WzFtRGUPPjhnYjyI75C8Mq2dWbuF5wPnaR4mgUO+BY/aORX3+UiUvD47hD1JbLAbQplrkNJ5TVTxEnxPe05oOclkRNkCvagUT3Eq4asXkVSkGD8Tlt11f0oQ5NuZWOI3r79ZXwAiijgGfpx2o3fKzrfKXr9DqLN4ov9flj+MMyj7w1k3P11nQ+dai9Fs9Dq901NEveT6lmZTBepOXMDSIPldAqbs0gecgjmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VJ5vW+ZaAH/nhXkBpUiPHk5pMc1zBVecjsnkJ3Qad8=;
 b=nKvUcFyBIamcMdWq+vD7ycLwtPWEiZegwNxoKpvUGubr6TXLDs2Q1baci3T7QsbfzYH2SwUIpONCZ6hVI23pXgSfnFc2DWUH3zfh631NeoV+2VdMASoUeHSicdQeWjVhGiwZePqWTye8ONCAH1Num51O40AabWECfbhWDgw2X6Dk3PGW4RKCKCmokLL6i9NVpoezLv69nZtjJqd/KB2RTja9KzT6deAgogZdX7bdwpd+46w5bvkSYVQMdjSca0GHnCIVylb4SnauA7G7AUyh+9fK+yKy2kCqe7v60MqoEQmDCEGJ2S5J/1kDMQ3ssThiuBqoMS93+wsCYUfM2NtBDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VJ5vW+ZaAH/nhXkBpUiPHk5pMc1zBVecjsnkJ3Qad8=;
 b=myddLrqnEkLnL4oy5R67imu3XZhrJUQN4n1v7ADOnA+vDKT4uz7p2IO2EINXi+QEUCOxyjjwUk8AWMzAVizoqHrXO3P0KPJoGtZjuq3EHEu78qbmaK/13AZbiN6Rgvvl9kpBNXpvQcodzGsJlvdHmya3AUI1yCRUdLSZmS8OjGMGeZ7nbB9UARy9TeXVhJ09KYpai/tCl8+mlNhEmtOvoS8iUBFux0Vhu+FLw4HOJKtHOiZ5Sp7QKHUkX6MK+8iHOBAwHHfCbvHoZDf4kaWb3i6txTZf0IxXOVurF8ufTuIr6+W5nNEwj3C6owfbWYGtvNyhjwFFpN+vnQ1EGUCIlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by VI1PR04MB10025.eurprd04.prod.outlook.com (2603:10a6:800:1e0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 15:22:50 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 15:22:50 +0000
Date: Mon, 20 Oct 2025 11:22:41 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>,
	Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 2/8] dt-bindings: clock: document 8ULP's SIM LPAV
Message-ID: <aPZTwf8O8tkqnDhx@lizhi-Precision-Tower-5810>
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
 <20251017112025.11997-3-laurentiumihalcea111@gmail.com>
 <aPJZ6dDRyyl3Qg4o@lizhi-Precision-Tower-5810>
 <cdecae8a-7fb9-4ac2-a412-1a18c4783ffa@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdecae8a-7fb9-4ac2-a412-1a18c4783ffa@kernel.org>
X-ClientProxiedBy: PH8P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::26) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|VI1PR04MB10025:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c7ec7f-bf77-4125-87b0-08de0fec87c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|376014|1800799024|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yi6+DCdq6DMyFRoPquvFEliJt4k5OdmNwdZssgIMywCW5T0S2aUNBh46o1B1?=
 =?us-ascii?Q?Xgz0WJAOa8Ea282Ul9N278FnknicnmvJN06y7/cjKMHVhk2YsOWlQZXJsHxh?=
 =?us-ascii?Q?6pNyaqAT+lZjR+czW45TeL4iSB6cTQW6qVq3WeBS7u4RJKEe7M/579mtdwBQ?=
 =?us-ascii?Q?QwHJhJZGuVxk7ZIiPtv4Xgk+Ff+socZan+ra+uIKqJZm4RU1U3k+EoS59Pox?=
 =?us-ascii?Q?uzv0IjlqBzuZ+vCGBixB8zUc5js9G8FcLl+KeQ5+2ukmDBT38Hx/Uc0tXf1g?=
 =?us-ascii?Q?HQYbyHdwGlBVGkqXiV1GDtEpJ82gPMGVUfRI0ruh0cRTYYyqEqa6qIdqsVOx?=
 =?us-ascii?Q?XuVN22y3RvfgkDk6ie+5/r81bFTRiAdqeX2BfbkdBV+qdOtINXe+G51KZqOd?=
 =?us-ascii?Q?XwnmiEfh9SNr+fW/F4Bt1VDsoZtVEp6l1Otq8iooDgLhTz9yPQBG45AMljNe?=
 =?us-ascii?Q?KRolzaDo/uJ5TnYgyrviQBmHXfgYWiccDpxj5brw9eWa/mntzwNE9BYpH398?=
 =?us-ascii?Q?cca8ZGdTSVtFC2nJoxMZxjPkc8QjynKlhATW7nb3ZPrw98se3pwpnU3gc4EX?=
 =?us-ascii?Q?bc/nnHRqpyGwUIgz6QYROmQbXKPmZFEbgsfPeG57dXhPmDVomrFK+93hJTjX?=
 =?us-ascii?Q?ev1xV7/t1YQIGZh8zW655JvzlJ6QQ9fdXhhUSkWSsMUvvtKRpFT9kiT+O7jO?=
 =?us-ascii?Q?NfdGme8wxv+DiY4exN94a540G3nneFejH+gImB67dNXM61+MvJFhQGhpB6QF?=
 =?us-ascii?Q?+gBjejAQysEPkqePHzi8KEELvSyTlNoafd1cXKV64ov43YOvgsh+1qpyGHu7?=
 =?us-ascii?Q?4GReoRx2mLoljP3AMJJPYASp89v6oG3aGPUskE/My8EaUSZW8VVTK2gbgttS?=
 =?us-ascii?Q?OOkm9f5Z85pk0dt3MebkZg/1HKNdI4p/azrsXGyTtdjpU9Anqs2wjbwCLcWd?=
 =?us-ascii?Q?ey3hrPnwtU/Kng58MunoKjudah2CQoaf+n/q8re95zSQrZ8fTrBAjNashxGw?=
 =?us-ascii?Q?G0a/S9i+89gmVG+3TRCtwJvN21cvBuf7p281zCAjhwv0p679ZmK/U2Ji7s29?=
 =?us-ascii?Q?B+9V/RRLHi5haQ5rVRMcJt982W6FvyOYGM8Vw6HDARmrwgZqzBR95FmQ2K5i?=
 =?us-ascii?Q?LwIfAYUEg/LYolw0s9kEDbqgaurcUSu2WqDNnVqzDfKw0VkMuAKU+EoePT73?=
 =?us-ascii?Q?cufFQqQCUhDKYdq0ItaxvEu1nM0QyPlDFcmiRXWyxz2B/mT/bXoG9+Zzsuf0?=
 =?us-ascii?Q?gXWLVnTfuT+PVE24jEXnNvOqhzx/jqF9ELHXlwplIeHvAb/avMmGByC7vVkI?=
 =?us-ascii?Q?fziGVVMZSP1xHJn1cwfOuXde8eiaRzKzUeY1oZtDFEjbv0Q157N+wuZfNUzM?=
 =?us-ascii?Q?8nhkSPQy/RrPu9aBz8nCYtktVeHQ2QZyDyw4WNsRztArbWsQYmWVOpypGdme?=
 =?us-ascii?Q?r6KVbFQc16dv8ujt8WSvW66w/hXyKJ6sFyXaSei3RB3vRnvSB6mfRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?reNG0TKJKwz9lr908tgQbSv76dJNI6NXe23laVfmvpbQzA+DdvDZddelFl7Y?=
 =?us-ascii?Q?m3Sy5UpzWbSOcdqAjueJkcO/1bLTNZ4tGZ40sahkrgA2xCyiFnDsEwt5n9o6?=
 =?us-ascii?Q?SpxB6XTlMdJy169sZbFxTQa7Ojg1iBGDOusTXSFuZuDbJTR0et0IgmD/TKiX?=
 =?us-ascii?Q?WOJO3QkOvGgfG06GPZFJeQ1ZKPaGo4dOBYvJw5jeV76efMf4ssJgLlXJILKa?=
 =?us-ascii?Q?GDTT6Cx0/rRCcctDVoAa7V0jEieR1NSF1VEReXPEwv8Xz9gU2MiBexm9Up1i?=
 =?us-ascii?Q?XAD8VGap8HqdsGJBZcTgqd+JLwLd2d/9r+iJErMfTfDmjimRrHpLK6zHYzKI?=
 =?us-ascii?Q?RPWc/cDyT5JAznhHSAr2mmHoAUFTh9YzBGsN0IMwkkoLMtDhhbQSqCwrI3OK?=
 =?us-ascii?Q?AbTY8YYFeOUITDS5pVCP5Kx2YMOiCDHXk5av3V/RCVr1xus2irFPpTM2pjS7?=
 =?us-ascii?Q?3Trw2my5M5S20lTeqrmvL1SQOm7Ufisjv5D2pzxMPF5N7NWCAawrpO8oQCwv?=
 =?us-ascii?Q?xgF9P3a/LgIyfJBRYk1p3Qmll8o8cI91pu+DA27d14NLAVsc/QHafvdax1XM?=
 =?us-ascii?Q?i+hRU96xUG88OVJIZBfwRF6rRK/zKrGH6jvRhEC/VZhrIh+o3p1mbl2yph70?=
 =?us-ascii?Q?oq4RKotHXp5GiqN/fZ7+0ZBkit/v0qtqgM5Ue0MFiAY2+cOeqP9otdxlRaJP?=
 =?us-ascii?Q?grTwEXmTe7xz6Sqpowa/enVOGvf87OI7H03ChT1xyB7hXhj03qf5zNr9yXyS?=
 =?us-ascii?Q?DYpbWCU2gyVvMSJig6tuZZemXEU5kArLh5QMQPIFpITwQJSTqYsJmVaF4jKW?=
 =?us-ascii?Q?r7Hl1OE7ouCdUt4jTv7RNy1+IsfJaVwtAe7/5gZzez8bPHMBp027/F6nOHJZ?=
 =?us-ascii?Q?oJv9/pioDjz3QwLswAmYrGhrT0wh+9V6MxCqpabCMmNm+nnJ7x5uNF72Hxuu?=
 =?us-ascii?Q?qg1G5fuQrCQ6OeyqcyvHRMbX39Cs957RNL2H0Yk18BBtJcdXujlSpbyav63L?=
 =?us-ascii?Q?ZVbahgexC/vBCh+xZuM7MJk6VR0z2+n77MVmg/JMQv/bCygpI9ANBeZTN3vm?=
 =?us-ascii?Q?Cs3CZ+i3bIUEEMJKUiD2yKJgU6GiVD5UPAAbO+izOtjad8REKy3tkhjM2yeB?=
 =?us-ascii?Q?ZFtgPUVWDKEh68srFJjFoXCYb5k36BT78T6Mzu2Iv20IK95Z7+ji6kM2ETT3?=
 =?us-ascii?Q?9BpcbkpX+6ciivYUkiLtRhNKd506nZw7jopQghfmexTDRdkxKJ5cgN1+noHP?=
 =?us-ascii?Q?hqiPH+xRykN33vW6HATZypTcvjow9GpFG0kL4+E3Dpi+IJ5Y2E01HGBreuh0?=
 =?us-ascii?Q?iuZcYkaVzzjoW2tJpc5u9GhIZSeaqP0BuXghBwB7UywIffz6fU9z4rEeA1Gw?=
 =?us-ascii?Q?yun6e37PDgDb5SsGLHlHWsicbuvsEgsH67huXesFZ+MSfCb7Qw7XkNQGnKX7?=
 =?us-ascii?Q?WOXasoRfAFN+0/lHw8nB5kE+OjMoPq2iBttk0zIwVOE7zFPjGT1GoLhWo/YD?=
 =?us-ascii?Q?SQUEIfVp3KbR1z1Y5zhpxPZro5OnuIWbUtsoKG0YEvN0oOPMuImxeUG86YHi?=
 =?us-ascii?Q?HyQBtmAcpHdrM4A0rh4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c7ec7f-bf77-4125-87b0-08de0fec87c7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 15:22:50.1579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4LMEhkNIAWrBb4rTbgWKKHSHbSzOArxAuoyE4PKqotAtdK79lrusOxpvKUClKoKrbIT6bTj5jQ6TaL4fASoYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10025

On Sun, Oct 19, 2025 at 12:05:27PM +0200, Krzysztof Kozlowski wrote:
> On 17/10/2025 16:59, Frank Li wrote:
> > On Fri, Oct 17, 2025 at 04:20:19AM -0700, Laurentiu Mihalcea wrote:
> >> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >>
> >> Add documentation for i.MX8ULP's SIM LPAV module.
> >>
> >> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >> ---
> >>  .../bindings/clock/fsl,imx8ulp-sim-lpav.yaml  | 72 +++++++++++++++++++
> >>  include/dt-bindings/clock/imx8ulp-clock.h     |  5 ++
> >>  .../dt-bindings/reset/fsl,imx8ulp-sim-lpav.h  | 16 +++++
> >>  3 files changed, 93 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml
> >>  create mode 100644 include/dt-bindings/reset/fsl,imx8ulp-sim-lpav.h
> >>
> >> diff --git a/Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml b/Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml
> >> new file mode 100644
> >> index 000000000000..fb3b9028a4c3
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml
> >> @@ -0,0 +1,72 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/clock/fsl,imx8ulp-sim-lpav.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: NXP i.MX8ULP LPAV System Integration Module (SIM)
> >> +
> >> +maintainers:
> >> +  - Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >> +
> >> +description:
> >> +  The i.MX8ULP LPAV subsystem contains a block control module known as
> >> +  SIM LPAV, which offers functionalities such as clock gating or reset
> >> +  line assertion/de-assertion.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: fsl,imx8ulp-sim-lpav
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +  clocks:
> >> +    maxItems: 3
> >> +
> >> +  clock-names:
> >> +    items:
> >> +      - const: lpav_bus
> >> +      - const: hifi_core
> >> +      - const: hifi_plat
> >
> > dt prefer use -
>
>
> I don't think we ever expressed such preference. Where did you find it?

It should come from review message when submit binding-doc patch.  but I
can't find it now. But at least, compatible string and node-name use "-".

It'd better to add to writing-bindings.rst. It is hard to search whole
linux-devicetree mail list or brain may cheat me. It is good to keep
everything consistent.

like:
     " vs '
     VCC-supply vs vcc-supply
     ...

>
>
> > lpav-bus, ...
> Then just "bus" or "apb".

core, plat is also better than hifi_core, hifi_plat

Frank
>
>
>
> Best regards,
> Krzysztof

