Return-Path: <linux-kernel+bounces-800733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EFEB43B4E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2748E17D3FB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A8E2D8391;
	Thu,  4 Sep 2025 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="M1c+2PVw"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013010.outbound.protection.outlook.com [52.101.83.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D9A2DA777;
	Thu,  4 Sep 2025 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756988105; cv=fail; b=rz0Xgx5zEww+tLpPzS585whmDnsDprLj2rLCCas7wwXgFL30I/MEHE0byxDfh21j836f1aHoaInl6G/FgBfi2CC58xj02WMn8nz9DM7CyJDiN04PtyIBWJoMqgOGQqd+S5iF9IUwqrv652yqh9yPBsSLjASsLXjhAT8jzndGGDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756988105; c=relaxed/simple;
	bh=Cj6q25uUPDG0e3o2GvYLjFICGegW295jT8NYYdTQwO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bwr75z5NrcGAnPX14aaLFzcCydRgO2qqz+9xplRxc24wNumPSUeMqa1Oq3dGtkkCkWfDScREl19Htv0xRXimE1/PBBUibzkjeLfAX62JBPks0nsPsA5mWTDrkVUouoHT+oZngOH7NTfD9+Z8psFkHOHFPFPgmPQ72E7nYdV5uqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=M1c+2PVw; arc=fail smtp.client-ip=52.101.83.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FF5yBji67oIHduqj/k2hRa+EoewqlXmPcib32xUq+OVu+SRDWCNrWsp2eVjdKNj25tvU4joGgCHi3kzTkjGcZGFjzKrxKLYQ73TEtQ4S+bmTDnycX743yOOLs47bUzUgmqYokHf/YaK+JUiop9DHvJZkRQhrPdoh75I45KKnv/cXaErxhsZeAjPm6kVpH2SKWBIbxjoBVjJjgqvP3WYHN3iKmacz8UyV/gQwCrQqu0y4vOnl31L9FDs8wje0fJIpO11jbkT1mMq+yQc9GLTechQpLWQyUmaJmpAvRFlrSUy855/snoFzd5p46FMVvYvrsNcOP/brV5RmLcqVgn7NCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiL+Reta1Y0nervAHXbLofnynaey1xeQTVU2w7tm6Mw=;
 b=vyRfT6Qs/vDiyetBfxOkqEqLYpIekY8wKsezFS4CK1Sc52w1V1DfsmuUzIqQ50/xFN/myDhvjFdTbO0E8BnqHT9FDIVyKhck3Iz81hAmhXccstSIqFMIeBkEC6v83ReJvS4cGBRt23w4yOiR7RnWxWe8f9Ih6CIO/YvIh9TJn85ZiJJG+WVa93xFYEnIlhA2gXcI3R2hf/8dD41WVo716O7LtnNlv9yzRwqS7oivOgMr0r3s9jvatZX3mTv2k4BS34sTeBsPz4mo9eyUfXCFmNBCR3O+fCUoWXvugr61Q8h22++LKkCvXkunkEB5Klsd2JsMG0kzBwL4/MQbnJb7wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiL+Reta1Y0nervAHXbLofnynaey1xeQTVU2w7tm6Mw=;
 b=M1c+2PVw6pm0zLbouFBJpmDKDs6+B5vOvdhvNcuYvWdgRMTbmIkIIgCPsfzybHdxZrnGIaVycswfuect1XUe5vt0ownDF9vunECQA0XVCopYp17s7PRMo6OjQVso4IEXTNbuoX6fm3Vg5WBwv1foZWkvOvMCETKi+mH3j/QmxivhK5zM2xTM7tL5heWjpjWFy7+OLF0HKfomHk03fsktTScMZqcOQc0V1dsL/BBVdrZo28NAbZPU1strAJhKTh9kY5IcGxIzKq2KGdfbI/dtRjeetytETDAgkb/+pYqgUFt2yt3WSV+BkF/QCSH/hqnk6NwTvdG87SyNaa10rWG4KQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by DUZPR04MB9872.eurprd04.prod.outlook.com (2603:10a6:10:4dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 12:14:58 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442%5]) with mapi id 15.20.9094.015; Thu, 4 Sep 2025
 12:14:58 +0000
Date: Thu, 4 Sep 2025 15:14:53 +0300
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: imx@lists.linux.dev, Abel Vesa <abelvesa@kernel.org>, 
	Peng Fan <peng.fan@nxp.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/9] dt-bindings: clock: nxp,imx95-blk-ctl: Add ldb
 child node
Message-ID: <dkumg46ybhyvjlqgequj52vq4wszjce7myz5of42ofydwuvkp7@2okl64wavaa2>
References: <20250903123332.2569241-1-laurentiu.palcu@oss.nxp.com>
 <20250903123332.2569241-7-laurentiu.palcu@oss.nxp.com>
 <20250904-misty-mini-buzzard-af2aec@kuoka>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904-misty-mini-buzzard-af2aec@kuoka>
X-ClientProxiedBy: AS4P190CA0027.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::16) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|DUZPR04MB9872:EE_
X-MS-Office365-Filtering-Correlation-Id: 432874d8-6b17-4050-0e7a-08ddebaca9d2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GCQPj9Pqd0QT/YemTzW7q/KV7RTek8iGSr6VvutRZ8dehZbMIotzF5Wi+iH4?=
 =?us-ascii?Q?xVQtMAnG8tOhAWoqVV+PGvE+WGLwdmGGZzkUYybPYzkeBRtSgyMoYzdBN1JB?=
 =?us-ascii?Q?AxOf+2UORPHPHjfC8rJiAU3MVOn+RJNKMvKKkGs4j5AOIk1KITPe2pv9iJX7?=
 =?us-ascii?Q?Uel73VSdn2WtSpvnaGUKXTuT6a6pP2cgpUM4+DxF4g/3rhgsll37veNTDaYl?=
 =?us-ascii?Q?CP0lzuk1xXD8mNfPx/ASyoLdCPf2c5f9GKDe0Tta7yYnpz240NttqaRJk3pJ?=
 =?us-ascii?Q?J9R4IgIsaK/vOxRQ5ATxKK7RDVVQLIV5Y7Dt9u4MTn12X32GdCkrzjhRmzbv?=
 =?us-ascii?Q?Xba9mf6kMgnzMytknJIzu6zU4MquaR0pJ0wR8ijGIg07NWY9UcMQWZTj3RR2?=
 =?us-ascii?Q?3L9D0JnSsj/66ZybuvMAYhJiVoZs0jPiMOgOQn0kJIBF1zuafSXHk0Lu11Gh?=
 =?us-ascii?Q?uDqmY8A+ene3EgnKm6vHk1Pu/GFhdyXYJV1CwRImZliGirBpUgPvjlzEAvgv?=
 =?us-ascii?Q?Gdr1a7uxw5DosvaAemdICfcL+AENYNVY0n4h6ZWFbetOv8lpgHipVGDZr/Nj?=
 =?us-ascii?Q?hTTbvuVkEwoPgn6womG74z9CEi5QS+pEOASKS+6nk8rr+qOeQjiCHXB9yGeC?=
 =?us-ascii?Q?oFt+8Dts1/M9aIWRnXfe+RavQfWPNtUvzwdDHxGotI3tq7g7PKjZ5ywvcbVJ?=
 =?us-ascii?Q?Wjx1kOw1jjNVuUTBp1x1+hjlrjJjs8+RxDNa/35sFIoknvA05s9KarbJ4igt?=
 =?us-ascii?Q?kbclg0nDDq+4yjGgmnSSr4PssdE9y/FtmgqkoY8GaiKJuJULa3IjS1f/P+4W?=
 =?us-ascii?Q?h13eV9XyE3LXy5cD6565I1TQRIbRYo5Ud0CZAOw3zKNkaMPkg0L3RrVZNrWQ?=
 =?us-ascii?Q?rBlKdjkrZSRbknWGNJnIyzZBA0//BctMLcZaH9mIAGNUvO7d3Np9A1kOZZyV?=
 =?us-ascii?Q?FwyPY/q/cifgiBkzJ67YxP7R4Sr7JVGr0wl72L5cBptECjm9eIlRnvwFoih2?=
 =?us-ascii?Q?2R4QogZvtqDZWzDpK6zf2PIpK8MD8MnrSlR42MPv6aywPvTzEQifWHxwfUwo?=
 =?us-ascii?Q?UGo3/HAuOcps2PdT1T9vSUmpdXGwExleo7vJ5boWop7Cgen910Wr53B6J63j?=
 =?us-ascii?Q?tb0a/oaSctqtv1TR1fj8YrxWrW6hAaxpbK39DLHYJR8caiQpSL+Ba0gPXUIu?=
 =?us-ascii?Q?KdbTjUdm96MvIcw4zebV6N0ZmTswEZXz2Dwr9wnN940cbOreR4pvab93LLc/?=
 =?us-ascii?Q?oC9hYx2abFooOPAm6FtkblfV7+q/xEcr3IyWW46ge4kWh/4FpEy52JNeRqdd?=
 =?us-ascii?Q?CY+7334mpm/n+n8I2shGFu02OQOLfqUIPtndOlZq4TkUylImFGPOWMQPcCwq?=
 =?us-ascii?Q?+JMKxVKW9qxqumekgBte2nsM9fV2VWYZ03sm54G1/+8qAQDWnxIsuK9FoulP?=
 =?us-ascii?Q?f3aMwbPDsP8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9135.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QfKEj0+AIlmTS97YA41GWHGbA6FJEWKH7PXANHpdiWroj0nNJtm5At0MF6fE?=
 =?us-ascii?Q?MYcO75QgkIeESR0jqXUm5ncBVtw8D9o/c64SFy+BH5NjrjN79J9dNNKwxDoA?=
 =?us-ascii?Q?pIfbmlyQmUB7muw2c1Se0gZ+v02a2mRY7fzjsWtj+gmf1dKiU94nzZdvgZJf?=
 =?us-ascii?Q?GJjmSDvbT6WqsgIYhng+06MMHrJoq3kqX3dxNGcJqKmlZO/WkHiTu86K5p3v?=
 =?us-ascii?Q?vzluHre9nvp89IGumEtcMnH/wxYTrfOBDv1sDJIuK+WQa6zkP+nFmqqO2pG8?=
 =?us-ascii?Q?UMXpN9IQrba9MoDNkNkBD+MHChpWQ1j4lCQbHwUENs42PVOKj3TuXAkvNJdx?=
 =?us-ascii?Q?X7oxynL1+Wbqz2nhpfI95353C9vXon0Y9Jq3Jhw/D3JKt0hHa6lw2PMFfLSO?=
 =?us-ascii?Q?7FJQopectPRlFcZmpRspyenO90TTTmdqghcMEVi3uravF5h6+CTSwRwino/r?=
 =?us-ascii?Q?puuh/xyDPYtkavGQhTYaS1yjSGWInayZynpPn1lz+TIkfhW6R+l7ftVp/U60?=
 =?us-ascii?Q?lJeTOnpojJcC2e62PtMLZX2JOlDTpq7JBPNvsVTkwNchiq/zKIgwlnywNrsA?=
 =?us-ascii?Q?wxJ7MOd/gnTxB0HdOrWE+9dgtKYf9IE41aaOF/jHsZO7OOqn3wcDUGZccVjK?=
 =?us-ascii?Q?vQUeexC0vGoJ+cS2l/WwxCr3tQcxY7jSfBZMy/gyFjqCDJp4t3CiLMoAtmiK?=
 =?us-ascii?Q?zdlPoHnHhq24ZKqwEh/VSMhpKW5WVxKJJdG1yiHZF09Rdiy2BfZrLC7F1Jlg?=
 =?us-ascii?Q?eaXPEKv2dwck2CKiViKBQSvDlQAY4NNIIXan7/zObwNzGD9mBavn5SDrNDM7?=
 =?us-ascii?Q?YkA9BItbg1RuCfznKqQCoJKzGTDa3SzopC+Bw7IbmVRRQMp1zF1e0498QJbz?=
 =?us-ascii?Q?XMV7+NMZqs0Za+JKLRr7/8WmoRPvlvUuzr6BaXqDHaXxh4zJOWQd6slegrOd?=
 =?us-ascii?Q?ZVGlgwVfFQ9tOnIlcpR6I91Lojrmgx/kHorkaml5z4opoP2DJeK4xplc60Xd?=
 =?us-ascii?Q?XNXOqXA6MAydTguRvNpwqZNlmUDdeFxex5Zg4e999oC7kgHfc75AB6wEDPFu?=
 =?us-ascii?Q?O4TJGr409b29eIQuuQOPDYQhkOsGjRE7BlJ/bXuSyinNBsVEBSQulg3fdXgu?=
 =?us-ascii?Q?H3q6TL3fz9dplrDH/reOb+XPDbarlOjn2zbPpPCdINP6eiUmVDaDQCgvlXqA?=
 =?us-ascii?Q?oTRiuLWv+IbCcg+cbRqk6ogrbQHtDXxEraJZVYZYATuM/H+V9Dy5s/WXEkyY?=
 =?us-ascii?Q?ddw5OROBf1hmh/qT7aEB1+Bm6t+mUhYGXkCE/QA3Yjtho8PLk0AOF3mZNoiX?=
 =?us-ascii?Q?/5TZ7K6V/YKfCggn9WJLEZl7+gstdxYGVgIlBr2/tah75Ib8EP8Jz97JMoC7?=
 =?us-ascii?Q?7LM3Th26FT+L8zu/dw3roGhtwMA8DszACwL696IqTtk1YtI1j7SbMao91pSv?=
 =?us-ascii?Q?6rp3x14W/xwB5Lh2DDrZ7I8HUT721YZCOfcPMpnn1aSI7zwnUsBoUP8/C59s?=
 =?us-ascii?Q?Daao30GrLC4cPpquJxlL4J15OQeHBTjb5SopxT4tBkN4B2Ml6G1kBVxPcCZV?=
 =?us-ascii?Q?xkILufes2kFsCqLO/COFUAIwNtueX4lsZ71oXm+kf7E7w6m/nBQ3/eNjBHSC?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 432874d8-6b17-4050-0e7a-08ddebaca9d2
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 12:14:57.7165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfcXWuP3mVNThQdbOYyeGQJhemQL2mTJk2pGyAfdxAsEQan5ke4i9mLLy1kcII5aeMrsTF7QKpXbHQNJ4QPxtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9872

On Thu, Sep 04, 2025 at 09:27:31AM +0200, Krzysztof Kozlowski wrote:
> On Wed, Sep 03, 2025 at 03:33:24PM +0300, Laurentiu Palcu wrote:
> > Since the BLK CTL registers, like the LVDS CSR, can be used to control the
> > LVDS Display Bridge controllers, add 'ldb' child node to handle
> > these use cases.
> > 
> > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> > ---
> >  .../bindings/clock/nxp,imx95-blk-ctl.yaml     | 24 ++++++++++++++++++-
> >  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> Nothing in the changelog explains this patch.
> 
> What happened with entire previous review?
I will try adding a changlog to the individual patches in the future... :/

> 
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> > index 27403b4c52d62..f83d96701bb04 100644
> > --- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> > +++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> > @@ -39,6 +39,28 @@ properties:
> >        ID in its "clocks" phandle cell. See
> >        include/dt-bindings/clock/nxp,imx95-clock.h
> >  
> > +if:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        const: nxp,imx94-lvds-csr
> > +then:
> > +  properties:
> > +    "#address-cells":
> > +      const: 1
> > +
> > +    "#size-cells":
> > +      const: 1
> > +
> > +  patternProperties:
> > +    "^ldb@[0-9a-f]+$":
> 
> No, don't define nodes in if:then:. Where did you get this syntax from?
I guess I looked over various bindings using patternProperties in if:then:
blocks but I completely missed the fact that the nodes were actually defined
outside... And you gave me a good hint in a reply for v4 but, somehow, I failed
to completely understand what you suggested... :/

Hopefully, the following *is* what you meant:

...
patternProperties:
  "^ldb@[0-9a-f]+$":
    type: object
    $ref: /schemas/display/bridge/fsl,ldb.yaml#

if:
  not:
    properties:
      compatible:
        contains:
          const: nxp,imx94-lvds-csr
then:
  patternProperties:
    "^ldb@[0-9a-f]+$": false
else:
  required:
    - '#address-cells'
    - '#size-cells'
...

> 
> > +      type: object
> > +      $ref: /schemas/display/bridge/fsl,ldb.yaml#
> > +
> > +  required:
> > +    - '#address-cells'
> > +    - '#size-cells'
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -46,7 +68,7 @@ required:
> >    - power-domains
> >    - clocks
> >  
> > -additionalProperties: false
> > +unevaluatedProperties: false
> 
> NAK, so schema warned you above syntax is wrong and you decided to
> silence the warning with this hack, right?
Indeed, the checks gave me a warning and I thought it was the right thing to
use 'unevaluatedProperties: false' since additionalProperties cannot recognize
properties declared in subschemas...

Anyway, with the change above, 'additionalProperties: false' will do just fine.

Thanks,
Laurentiu

> 
> Best regards,
> Krzysztof
> 

