Return-Path: <linux-kernel+bounces-872308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37819C0FE02
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06E9C4E877A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0CC2C0296;
	Mon, 27 Oct 2025 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oIm0bc+2"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011042.outbound.protection.outlook.com [40.107.130.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E30D230D35;
	Mon, 27 Oct 2025 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588954; cv=fail; b=goqUdW+SNsr9clG20yXJTys0WiJdr9pDRc20PCBoCoT0EuGpz23AwG4hjok+5TyP9BB0K5zVphDupkq7VhzpKbin+WiZ4nJIKnAmXYs8+0oEZ0pgfwIF38CP1eBpaehcIP/mvPlQnQZwq84y479xN3DJMN/jkIq7Wd17vOtEC1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588954; c=relaxed/simple;
	bh=dTXAHOgtCWw9qq1LBPsWGC64ZJ/qwMKzapvMzEhbwxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dlEGfvDS/gXDljGRAMB/Q+ffASykqptj1z8yg0sTLGaB+WHLw+dguDW3he5JH/gvksQVaOH7oruhDZK9eV0/782DcfBr4B7pkgARLcm/2ECE/94FAsR7Ck4vxZUtkInNTp3qxADV665ITVJW6108UIbMvxxgIMw7nAm81aeCV3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oIm0bc+2; arc=fail smtp.client-ip=40.107.130.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTNskdL6/AuQgL2lSHnUGSkZDRJUVHEFBxMbQGdN1KPVpZn1bh8nN2v9eqlJ1IfWnyMDXbyiCwsSwz6DRSfzGfaa5AuaoO6lRe5tql4SlfhoBcxtqSUl+4glg9gLGM5ipThShtsS+OuNdYIvB6TvLvgEOGHZ3iUGdQyWgXqhMFPXl3CMOW4VIiqnXYw+PoHOFSX3tqKa2K0AOSUtiO+6boohDUkrAalEGuIOr9kkHWbH+BgkKMaQQDnU1ldQ65gZUG74EwKvkmtFtRU7tjs9bD+1FhoxVPqjpwOtECzK0ucTUeCEEy5mkmeqxye7w3IzMuaZh1vI5ywTYGmRw9o9kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlRyWZOyV0oVCjtFa02Rm6eyvXpxsg9mqyM+Pm7430w=;
 b=ahZBH3wnZpYLIqU27hijb4kTmpMjnoQsIVXkbluSxpLfuOl8uaHxRWVXQzBBSb/SHr3x22+T2RBTHs1yBUUFaVp0TDoBcKUWtzJpVjduZHxVxFwmT98RCaP26pvdTNzGb60QrHd2Ika8u62ol0ebEEPS0QZiDnsA7mwqORqsODf2Wp4Pw99ptG96mBcjzLTSypV8kn2PmO1oD3fQuUJ0C6AjKA+USfXdAGUxdNVw2yspB4rHuCypa+qCictMmBpUA5CnYPdy4JjBeJGxBisevJ0JfUmcPTe+TouFkp5bXPv0MrJuxhoOkLo3XmJHqybuO7BgAoEi5IdP8736PQtpvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlRyWZOyV0oVCjtFa02Rm6eyvXpxsg9mqyM+Pm7430w=;
 b=oIm0bc+2BH2gS50303Tl38L/8fRjYHU7MM86Ah6QsRm4tAvNOk2GtxUdWdXbbgoL5MxjwU7M3xwtA13Y5kECAbxJlIpEVTI+NyHKXTZhvjtWDt7AZaHez/a4D/ZsdtJdPR1W/r86YPoxuZtP3ulNT5xbKctBwrxO3cYNFE19vCW82jjnoIHs505lZtQKbAEpm5dMmqF2AZy6fOXQu3sCbMSDav3tLD8ytGxkHWr3UQ1fI+QekUaPhJTMpXhJ/aNIHHEg1GHdN0jFH4YkGOvHWEtQ6Z31hgVOSZtPArH1Is9vuAU7lvAEay0ZmOcgW8Vz22wPp5mpGqdl26bf4qI2Mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by AS8PR04MB8326.eurprd04.prod.outlook.com (2603:10a6:20b:3ff::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 18:15:49 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 18:15:49 +0000
Date: Mon, 27 Oct 2025 14:15:40 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: dts: fsl-ls1028a: fix USB node compatible
Message-ID: <aP+2zBxuVoRTPR9R@lizhi-Precision-Tower-5810>
References: <20251020133754.304387-1-alexander.stein@ew.tq-group.com>
 <aPaXaFigEh50sdZC@lizhi-Precision-Tower-5810>
 <aP8YIIQG6uT7bLEA@dragon>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP8YIIQG6uT7bLEA@dragon>
X-ClientProxiedBy: BYAPR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::32) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|AS8PR04MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 60318131-d4ac-4a14-a479-08de1584daff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iaDwIRWRm1ijUvWK+3X9z4ujK9UOe+5AwmD8mftXvhpXYTwGV3576PKQIbro?=
 =?us-ascii?Q?0cwZ7R6XLJlKyOgHwHUwa4xpGXLfvRUbKVQ8SD5rTxCEoxNce2mBsC5HzOeM?=
 =?us-ascii?Q?LH71INrVEEvOurGTilE4KnyyRJ1ckdkR7ndvt6PjYACHDmCF8Eb1MzLXgd20?=
 =?us-ascii?Q?3FrwL1vrQcBctm8IyId9Lh9vOeK6tEmx18MoNDG/VaeLh4IQkswh5JGFH8jN?=
 =?us-ascii?Q?5tywTD3uFZvWb6guOwQcHF7sM8N4Uoe4qN9eymd1VUs1CH22QQy2CoIQQesL?=
 =?us-ascii?Q?oHxNxLswy0UZlihd7cYyUeBoYFPmX1INDWZGl4E2FfRrz3Q6BWleAGq7nQ8z?=
 =?us-ascii?Q?VMpCj5OMmoAo16Bu2s1CDymBOKIR7scjNJDjJg3mC/gkiqd/S6OgTEZTSf9p?=
 =?us-ascii?Q?vQ0vB4y0SNqfr+11XfEGbu9CNdbqZU3QbCP8RdR542mtUJSVSSwNvaXMxdnx?=
 =?us-ascii?Q?z2ZVSX7Mk0T/WyY1OoUoM9G0/SqvYeXpPnsfsA4uHxPqd7+5iHplfJ67dwWm?=
 =?us-ascii?Q?pxKLsUNK2a4qn8pjv4qNW3uUi1SxbibiiyYbHTRyAoJGP/vrbXgHc4ly9k7J?=
 =?us-ascii?Q?Z3ZAZZgkVdysYBP0WNOgd73fZNKA6n2yvN0DGWP7qhYIzdxoNEblrmp3cPFh?=
 =?us-ascii?Q?E5TaZMmrC6Ctmm3J2ev0iSmSFZBEb8IyxYVcTEQ3BNi8jDK7ifJ7llw/lM4S?=
 =?us-ascii?Q?+WO4Fiwi4eiGyWpm/tS65ziSGgNEq4NpmDznSX7knN+qGlLhODaumZ5khTdr?=
 =?us-ascii?Q?VOtQJ42enX7BT35vg3+ZQQW2OEuCxHsI39FIxIF+FBXdlU0TRiBF0ZufvFKj?=
 =?us-ascii?Q?r8iIxXVwdC3Ca7j4/GIjfsfoGboSTvRGJmmp9JwhJKu0PdV5o3hja3Dd1ODl?=
 =?us-ascii?Q?8ILV4QEmShauPVISF7sdHO/sgQ88VOYa5benlby9kMX74SgyD2MBF8Pt/ev/?=
 =?us-ascii?Q?Q6H50wqgkcsqNDdFEji+qLbo3AaCrmm+dbMUSjjhJELs8CeU0biV6OtHX/eJ?=
 =?us-ascii?Q?I60fzmHJEyKmBzELRBs5s/Nli8h9VSu2mczhf2cqRXBO1tZbrPhBpsTMM3hP?=
 =?us-ascii?Q?EpERHkKjp72Lpiq8zKzlYjpZv8lzXsGLOwNhyT4aFDmDjOT/B3Sdk03oii40?=
 =?us-ascii?Q?aKlc0C0d4BY8o46oDTbdiuzB9l95H2Mlv3+Ee9kBYuN9BLF5gorULu/bVyHY?=
 =?us-ascii?Q?3muP1I5lPZpdt0R/1/mJpW1W3tRLvoJ0wSZyCdAwSMF885e9OI/qS40KoR//?=
 =?us-ascii?Q?isXxNN57amy30JHvjFnCuSoQyXoehqhmkrhMzbs36y0uRmE8N9UnSM834gX2?=
 =?us-ascii?Q?G3t/RjNfRaxVEQ/e5w5I/eSvRjtf5DwhMkZRdkVC8YnNo1wedk+erMXZgFnA?=
 =?us-ascii?Q?to9v8xxc2i7w1BEg8wzJs5T4lagwQFwFZVp/smgQxfT51Tp78l1GXNYZF0M6?=
 =?us-ascii?Q?24QbBOBB/xze/HzfwHNbJm63EWW6Pt/qgGaU4ao39dfgJPbudej+3jSyxdN6?=
 =?us-ascii?Q?/ypR+iavqHAeyyeJn8xf02IAh9/mW1VXo9E4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?APtxsFO7eQhxR6HzFwMuFXGjnDUyQ+VlxgtpYX+uyEODdsMjsEF2YAwHecME?=
 =?us-ascii?Q?AiBi2wgcAay3h0UXFg/w6Yn7dzH643B08jct0A/fC82Rf/a+EMfEyXCDX1W9?=
 =?us-ascii?Q?YAlqk4HQN2MIDBUdY6T0RfPHHuir8V0IELAZTtEdv8iWXlM1Xc/YLvPgwqrL?=
 =?us-ascii?Q?Va0Jowpnn1uLNweskcnmXJ1LWx2SLmXEymW1IxjDQP8Zk2OfBFqhxIvnoJhG?=
 =?us-ascii?Q?skkPgpjHASMKYyF2lXxC2olcK5+dTJQwZRtDrutuglg7sn+1RnhN6Nqju/UY?=
 =?us-ascii?Q?pQ99tTytRU+Y+h3A7f0ySvT8nvdD1BDXeHwC6xqqUMGw2hHsIuLtR5EdY6d+?=
 =?us-ascii?Q?jrz0wOdmELYzez3yqLzR/L5upqsc5CY/JsqfX7cA2lkWa4XnjVZo1LN7HEvt?=
 =?us-ascii?Q?X3MnAPiAoCJkn6yHKPuQB4b5JI5jdTN0ox0gCTY8SCsgdAs8x+P7cn5VKTbY?=
 =?us-ascii?Q?C7nQG8Fqt/mCzGCqwrqlDOL++PxmfMN2n6FVV8+8rYj150kp3fV3AnBEE+c4?=
 =?us-ascii?Q?Q61MncijoT94Ukuro2zktyYsSr5sO1JcCv1HDq6UejS7LbRQ77DaDuTxt+f7?=
 =?us-ascii?Q?InDjYKfS97mUI/A8LXeECp1Q2IriY79ZXlouc1E4agZFzDHAomEevtLvIp75?=
 =?us-ascii?Q?0pdlpDG04tylnCl/y4lw6K1aQW9FPmSY4AM/f6IITYovE80Da3NBSwd/QhX5?=
 =?us-ascii?Q?tKosoIcqmtm4pVlIL/lRGc6Ap3Ntu6BNt4cZbvCCrEPlannp6T33jrDeiItF?=
 =?us-ascii?Q?WLt6Tes291GnNI4o01xFixdlyHVJVAaIXErg3TNAqnIjiLCZSV8FF893h5/I?=
 =?us-ascii?Q?W9KnrBdqxwr7MsfcwOgLR20RF3b5ub3ouuW8rP66qA57Z8tgZp+tSNk5WMKz?=
 =?us-ascii?Q?k9AGtinuA5kE8eDihrLI12aQqTu+1iHoqZNaj/OHhKgazKElfIOG49ailtn/?=
 =?us-ascii?Q?SlEPvk0IT5nQkYAsWn4n8cRwEfZik/BokySX4CS/IM4nKMlk7YkPwyewWzGC?=
 =?us-ascii?Q?V/fzBoN4SxTCXRAWuXeIxuwCUSs7sowMkYAQSsC9hNDMgnDN6QDGDn/6HABc?=
 =?us-ascii?Q?gDkhhxglggsUR2QXh/xlmD39W1LWiX5BqAbwBRYWWqMfhxH/wkmZBB0zyGYE?=
 =?us-ascii?Q?+6FGGoZ9UcTSSJkyyJ8A8ML88RQQHlbWlY1uJZR61iyxy2N69v3eum1obdtV?=
 =?us-ascii?Q?L9aP4PQMcGPgtdR+LS0u9reDUqvA+F4NJQsh8I62qYWbCZq1x4N15E5K/2l5?=
 =?us-ascii?Q?Q+GQD1W7EkzzgYicWLrk6SHHeo/JgKg6nC/VqDgSgEMC8XwPFbhLpN12GtFW?=
 =?us-ascii?Q?yhrrFotlzriPfnu02wa9nn8zTBPBond5apR+0JmScUYGX6EBy/hOf3YAV5Y1?=
 =?us-ascii?Q?NiwraELzi2h0qtFKOPquNalklvThg4Q6YmlWn9yRx0eu/7MXzbBQq7qpFJi8?=
 =?us-ascii?Q?6myFIx/D6Eu5uxTa8EgKDbQHpI5cYGxt/38xHmFrwCkZZAZB0wKxsLLy1/ek?=
 =?us-ascii?Q?3fHwFHxchpFlLdxRUUUg+id9BJmt/N3iId+kz5uwZzWzITfg+YCxJ3ZL3PMe?=
 =?us-ascii?Q?kteeZX1E4towjhCAFdSYkl1LzsSez0CDZ2Y34eR0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60318131-d4ac-4a14-a479-08de1584daff
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 18:15:49.0723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjgUFt7Wlchi8MKbcvcj63UGMPwXqCb5HmnzbvAHf0rlR4GWkxYmAL7Nhwqq3oX/T7/p7ImrYxCJVCMpT8gKkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8326

On Mon, Oct 27, 2025 at 02:58:40PM +0800, Shawn Guo wrote:
> On Mon, Oct 20, 2025 at 04:11:20PM -0400, Frank Li wrote:
> > On Mon, Oct 20, 2025 at 03:37:53PM +0200, Alexander Stein wrote:
> > > usb/fsl,ls1028a.yaml says the compatible is just a simple
> > > 'fsl,ls1028a-dwc3'
> > >
> > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> >
> > Thanks, but it is similar with last patches of
> >
> > https://lore.kernel.org/imx/20250929-ls_dma_coherence-v5-4-2ebee578eb7e@nxp.com/
> >
> > Waiting for shanw pick dts part.
>
> I'm waiting for the usb binding change in the series to be applied first.

It is already in linux-next

commit b9f1c762a4de17d93017fbd12b9941caff6d3078
Author: Frank Li <Frank.Li@nxp.com>
Date:   Mon Sep 29 10:24:14 2025 -0400

    dt-bindings: usb: add missed compatible string for arm64 layerscape

    Add missed compatible string for arm64 layerscape platform. Allow these
    fallback to fsl,ls1028a-dwc3.

    Remove fallback snps,dwc3 because layerscape dwc3 is not full compatible
    with common snps,dwc3 device, a special value gsburstcfg0 need be set when
    dma coherence enabled.

    Allow iommus property.

    Change ref to snps,dwc3-common.yaml to use dwc3 flatten library.

    Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
    Signed-off-by: Frank Li <Frank.Li@nxp.com>
    Link: https://lore.kernel.org/r/20250929-ls_dma_coherence-v5-1-2ebee578eb7e@nxp.com
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Frank

>
> Shawn
>

