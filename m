Return-Path: <linux-kernel+bounces-802753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0F0B45680
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61861A410CF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D3A345753;
	Fri,  5 Sep 2025 11:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GxFOP20B"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012027.outbound.protection.outlook.com [52.101.66.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5D53451DC;
	Fri,  5 Sep 2025 11:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757072286; cv=fail; b=oKwFwjq/3z0gVb0U44WMGRntM3ac2TGmejXxp/RRvTNuSdJXxguoxdP6NWznhH37XUM/pp26AKnexeKv3sudZLfxH8hfcJ4PCfvRTvsLefMQLkNx7a6FsY5M4TeP50WLC94jGnrx3QefWfGyLN/F9C39HbGiVHUfkN5qCCBx+0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757072286; c=relaxed/simple;
	bh=p08mOcfF9G2fgkvNyWSPHaH+qieZiiAIvnyC1o7wvZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q71f9qE902WLrJxWBoEkFCookgskPw4lxPIXI9vqDE2FkwIHTs8AIVElmaTUNUlR+bp0wJHdSwDeqRiDipdteoCgCbWV+/FVW3MU3gGii+zBaUnW9XMXvgXHwIE/Dz2Uddg8+dkHQaDuezQIVkHGYSl3z81I4shmtk862C2yPeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GxFOP20B; arc=fail smtp.client-ip=52.101.66.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hz/BDLPYvT+FqA6y5f3jMSKtkBpP7HQ2bErsG/X0t04zHYMvsacAeUEoIYXybd/vY4Fu/n6nH17sqiuqGctJ9bSt0RMCTITrunjg8063RIf9ddRCqz0IR0hpFA5gNM7628ssN2JPT61rxXisLcvUX5vNQG7vO4xh/l3gInPAOns9r3biZZPpFfgPS35GdQcTSDM422gsCbyQ6mrZ7Ud65TSxBZoxeaCuSGaEQR5N2/DTW/gBz7Nq5HQm1QA+4jTv0HnwS4t8phRCSh2gkDAdMJ9g1E3N1F7ArfWwy+dOJhRNkNFXoOpj8i5BFsAn0MICVEBZv9aJ/vViCnIpB/x2dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ikRCoJrvRVG5SGsBlBINs8j7nBK0aYFhAF+lyVm+Qs=;
 b=cs2sO/ObaUfUAsktM9KFWCHp85XB4731ZlOH6H8uz/okdHFgZn86DJKeo8zT0vx9439atNMWnyQFL3QZfi0WBT+cGjfG9JlpdQVM5NsGwpsSbXaOF4YUpajmZqR382pBnUPTfRMtgwI5N2pYowtefprjZ75wAPhpiWUR8/L/DPztj09lG856//dtQaIUKapgls948YR8B+tsJnscgymCxLfRZWGE9lYgQMyFdIkZhBpGRoHEbYu9j4WsqHlosFZf7nHDnbLvhq2S9IZXCJ9utMEEjZoixdP8cokEVBPFjy3ASXRGSAPn7LlTOXp+XaX9WpFzhB79aScTGrxprgcXkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ikRCoJrvRVG5SGsBlBINs8j7nBK0aYFhAF+lyVm+Qs=;
 b=GxFOP20BaWesbamtsfNZYVuVsUM0s9rEEi+ZyNSZKGZivCGHoEEwu08IOkHuBizyjTXANoIL6bwk9qwrBIyfasgGwJ0MOQoyK8/nKFqwsubtACpjA5Vjb9ALaBItGtXlFnSZqL+NPNqt0mDQCGZeAWb4QYBQKhly1BBIlq8Gx7GzAkVgNHFZJKraW3xiBFSgWR4upBlktfxID6vrlNxyrdkSt+2hkom+0tcwwytyTk6JWSe3UxT4cwAWfypcv4OOpnDG28OR9DKXmfELCCMN1STuY8NRigBgVNVQnQHcR2VLqhwMvMkD4KCoBk+HMnRQ6dGh50wL8vFXEwbHi4Rlqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GV1PR04MB10992.eurprd04.prod.outlook.com (2603:10a6:150:207::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Fri, 5 Sep
 2025 11:38:01 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 11:38:01 +0000
Date: Fri, 5 Sep 2025 14:37:57 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Josua Mayer <josua@solid-run.com>
Cc: Conor Dooley <conor@kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH phy 13/14] dt-bindings: phy: lynx-28g: add compatible
 strings per SerDes and instantiation
Message-ID: <20250905113757.pmumjdnbd52jxw6o@skbuf>
References: <20250904154402.300032-1-vladimir.oltean@nxp.com>
 <20250904154402.300032-14-vladimir.oltean@nxp.com>
 <20250904-molar-prune-4d3420b1bcb4@spud>
 <20250905104921.7grpgloevlifa3kj@skbuf>
 <8bbbf34e-ff9a-481e-a45e-26cde7d8f6bc@solid-run.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bbbf34e-ff9a-481e-a45e-26cde7d8f6bc@solid-run.com>
X-ClientProxiedBy: VI1PR07CA0293.eurprd07.prod.outlook.com
 (2603:10a6:800:130::21) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GV1PR04MB10992:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a03cf15-3ed9-4623-8dfe-08ddec70ab22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|19092799006|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C24xGvnedCYRkTB+F9sqCbP0gnpyIFTpkeaFP1GGezaN+wO8Hmw/+u3BwigR?=
 =?us-ascii?Q?afYqTa5iWbxSDM3mDWS9So8MU6phKpZ2+90reLZIiauHYn1OcMxtF44SHZr/?=
 =?us-ascii?Q?GtKjae+uNPwnjYqTG7w8C0r40q39Z6BwRY1qfjTwYVYgzZhPh2HgEeZKDPJd?=
 =?us-ascii?Q?D4NGvoty7eHAGUEwzLIVzopLthMN3u8YgT1pcCHJpa0du/k7XmgMjtXokz6L?=
 =?us-ascii?Q?6rHTSod1Reh1uB8I1jXOVe1LNwgNGQlJ0EwHLRvIIMMgjfd55i5RC00qZaUc?=
 =?us-ascii?Q?HJypz4I6KUzV90SefeF1zI5qjdgTYNp8+i0zpacxUU0vli7qf0achorf8xa3?=
 =?us-ascii?Q?TLXlbJspdhpwFUka4jj8jXVdEUKRDNqnY45fm57yDHfuq9H+n/n+k26HAPKF?=
 =?us-ascii?Q?UqiUNw9slI06ffBcXAUARDDg1Ss2QMpNwlH1joI9iedoaqGkvRXDp1POj0W4?=
 =?us-ascii?Q?e78+8Z+2jpvs3i6ZoCMWqjSSEV2fa10AvVaYh3yAmjhyNPY8LwbgWxmxwFQC?=
 =?us-ascii?Q?5p7I3jxStrah9refY0qz1ync0wsRI3UlQeyruGVz3UobogBNZ6wwQmuvhSWc?=
 =?us-ascii?Q?9MhYArzd0Yjk6m2WD+A/qhgnUnzfM7OMEIJe6Z+zyR4ZkvAYu8e8Xj+Y/Avt?=
 =?us-ascii?Q?Ou21I7BVxWVoGSi4kR32TzSmDW89XmA/pfOY/zelxJ1RYgMkE5b/eRF83Q8h?=
 =?us-ascii?Q?LlwQT6WFYQcoZEGxipILK2Bp+8/ytSuiwEi2mopIKEshFxFWbCfPUXOXOQQT?=
 =?us-ascii?Q?ZpqiWz3gPTnC0Hcc9yHHpLRo3CWYvQFOn0n4kl8rSN5sYx5hp6xVgGywrK66?=
 =?us-ascii?Q?WtKTA+bmSY3V/l7B2NDVP479d8G+Gy5BTkZp6vG5qhm7FVlz2QR1fsNuW9Vf?=
 =?us-ascii?Q?E3NpshA+Cl6sQB8TPjm4uMAGJ4RT3LkXlfynfuT1RvO0eNUYkPXrHrSNZ6ht?=
 =?us-ascii?Q?EBPCKq29flaex6yWqPwHiUiq4JXY484wD37Ggag7Pk2aeQM7sq+6W57g/lIr?=
 =?us-ascii?Q?qMpzAmnmbYk6arMAszXIimTEFhGOCi4OKDYmF15HNArWdy9r25EgVK0scKuG?=
 =?us-ascii?Q?JmYofmmtLm7LJjp9Hjqy1sYKk6JdGqw1Vgg55soW/ME+m1EVNxp6Y29LRi/q?=
 =?us-ascii?Q?1ZRH1ecEqpqOydErV9av5PSJATdvBI7Pdcs8XW/ww/yw6FYZ9THjYkya/LQf?=
 =?us-ascii?Q?YI2YlFI46sc5BokfsbUYmDGwuoqo3x8Tx5iBeJZJ23ObgdF2rLXCxVWnX4FV?=
 =?us-ascii?Q?ohFvrs7CnNYgRC6NtV8l0/W5mp78vquBlkru9QT3mhFF83msjOUERcFOuGzW?=
 =?us-ascii?Q?Ej5dsLjrEKzYleHR4nGJDnNN009ng66MeT2OtboepFQMKukFqReKUSqepMSF?=
 =?us-ascii?Q?0KGqIUGYM6g++W2NOw3MRQXuqcT6F64L0fpUkYZSrkbZeCWoseo6xzfKHZPd?=
 =?us-ascii?Q?edtOjMtBLi0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(19092799006)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S6jg62b9514hvoD9cnlUWPLNcVH5KmNKNMzTH7BoDAZEv6dBEEs0+KYs/q+x?=
 =?us-ascii?Q?sRORjJS7OOVUJTXaN1c407BU7sTc3a18OngPq8uSZ1ToAfxoNVqyXueUb1Kf?=
 =?us-ascii?Q?q019ENhvBSJeM6hegIPur0ldUUUGA/GyTe6I0CkIT5ona0ELEtS80K0eQOWz?=
 =?us-ascii?Q?+SvgzpPwDgeJNbEm49RWAl5pTa28mjJwqV78R1/f+g9r8twmxo8gI8bih9k/?=
 =?us-ascii?Q?IjEWhbY5u9JmdTF2HOtJFf/dtQ65Hs2b349Z9dKVu2TGAd7nrWuhQHUhr+fi?=
 =?us-ascii?Q?zLF2qeQc5aHiOBq3LDmchk6JGRdtgjaLZbkMbeWYhmmEF47Z1Yy3wyw6ugnP?=
 =?us-ascii?Q?E+Jb9dNDdw6KGmoan9+f3+ZSSLbiv+WL2fB+ahXL8ZND5sm35lAPqmtqRmNO?=
 =?us-ascii?Q?5IjW0jUuPITygLgiPExNGa6nFL9IPZsgmAOMTb9NE1OctCFa1+jqkwqaQ5nD?=
 =?us-ascii?Q?Z5Kb91f/iU7/KI9Klmvhr1aZqw85kZE5NmEcYUnEmGfL1CpLZQ/BDLV1XnPi?=
 =?us-ascii?Q?XD6ae/wKssF4GlVrmmnUfO+pbiF+C9jCOk4PSXo/ncDKHPQ83FNw73WEW3te?=
 =?us-ascii?Q?sdF2ygPN07ExuHLdtiA6Ndf4iLy5stMFKm+Ptz2TOSpMFJq+cgdYz87ovOiN?=
 =?us-ascii?Q?AdXzL5RTg2H8PKnFUsv2hCS+RgQiAlu68atM/TNYfAkH3oo84JnhZV8+hQ0u?=
 =?us-ascii?Q?Yz28cvu/CJVtKhXh7gdxK4WwyVP0hiD1jrBEuioThShlK2OC9/TQU4iKY/px?=
 =?us-ascii?Q?VRyVUG6QVm/F4Xj9jZiutktrTQuPp1QIbt0grQ4xCZOzIXSmZX6WcpAmxHgn?=
 =?us-ascii?Q?uCUyJkiq1OP1Lw1LOddAgMy/cK28tK9T9mosiJCfSdW31mm8jQCbbk+N1gn0?=
 =?us-ascii?Q?aRjQYZo80jFIUEKLxx+Zy1K/YLi20WvDjisB2RdsoX4K32KfSARkM+KAzRaf?=
 =?us-ascii?Q?qdSg6MV2Ia3A8q9dNh4Brgmm2ifKQyQDMqWofrQyiHsUM+5/XihvSirWSoGb?=
 =?us-ascii?Q?ywz75bmpEOC6ciRKxAKHkUZtWz2+ccwQ9kFj/+g0m0Tp4dQKGO6DoGW/ETSt?=
 =?us-ascii?Q?Lxf80/kIug2zGUHjYCTLsMf306ld5pWKkWm6vnT+etO4Bk1dv59iYeogBP6W?=
 =?us-ascii?Q?0UhR46qK+Gu+byNkFKJ/bfvbICIVhG/JcxCOd/emcDXLc4PcBwJpME3rCjmj?=
 =?us-ascii?Q?IMavhQA7oQBePmonzAYM0J+KUxatHAoQq8kqViMFCpFdNbb80ZOumP/WdheD?=
 =?us-ascii?Q?INIxWlLB5krB8Fvo5mi20CXVmMn3GBf/ltqLbt+pDblamnP3ExCOZ4kZwtJL?=
 =?us-ascii?Q?47rkNFxL7wDBGssDqIKqs1a37e2wWAtcY1d+WtDIFP4RIi6e/rQWfJaYxDWo?=
 =?us-ascii?Q?Xjmh6HsZOebWC+32Ak1XT2sfb+iqv97HJ2wGV9rTTbUdsHLB3w7mE3QWIsnY?=
 =?us-ascii?Q?DQ5WUSZONsCbRfS7TycZyfVI9+vROeTRlDXShxbVmqvf5OG8lzkHmXoSjOeG?=
 =?us-ascii?Q?6UOkL8y3v4ClN47jsaSqK607fdkzLKEG1kNGI5NRKUSbmo9Oa/0nx90NxVuH?=
 =?us-ascii?Q?NDO68Mte+F8+v7FWUOjPCFdaOzYVBKI3TaVHKJwAyUL4INT4rnm+EOHsHwXm?=
 =?us-ascii?Q?o8OeB1xD4PoONxpxNIDpZ3Y1cdRUnY1OPBgwEwPR0/OfuOea6l8gXrBlhH7B?=
 =?us-ascii?Q?FOXNig=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a03cf15-3ed9-4623-8dfe-08ddec70ab22
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 11:38:00.9750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qhzga71KaTm8t1BHKlahGf6iRTv5WjuP9glGcFS3pCKmIpoeqxxGT2Vz4q7xX9uaM0Kc562s9ol8aAiNSm2PSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10992

On Fri, Sep 05, 2025 at 11:10:53AM +0000, Josua Mayer wrote:
> Hi Vladimir,
> 
> Thanks for adding me in CC!
> 
> Am 05.09.25 um 12:49 schrieb Vladimir Oltean:
> > On Thu, Sep 04, 2025 at 08:22:16PM +0100, Conor Dooley wrote:
> >> On Thu, Sep 04, 2025 at 06:44:01PM +0300, Vladimir Oltean wrote:
> >>> Going by the generic "fsl,lynx-28g" compatible string and expecting all
> >>> SerDes instantiations on all SoCs to use it was a mistake.
> >>>
> >>> They all share the same register map, sure, but the number of protocol
> >>> converters and lanes which are instantiated differs in a way that isn't
> >>> detectable by software.
> If the serdes node had a phy sub-node for each lane, then software
> could describe each lane individually / omit 4 lanes on lx2162 sd1 e.g..
> 
> This comes with added benefit that perhaps in the future we can use
> them to describe board-specific equalization parameters.
> 
> The current driver uses hardcoded defaults that may be appropriate
> for some nxp evaluation boards only.

Yeah.

Given the fact that the SerDes can change between protocols, I suspect
you want to go one level further, and describe default equalization
parameters for each protocol. The equalization for 10G won't be good for
25G and vice versa.

Do you have a specific format in mind?

> >>> So distinguish them by compatible strings.
> >>> At the same time, keep "fsl,lynx-28g" as backup.
> >> Why keep the backup? Doesn't sound like you can use it for anything,
> >> unless there's some minimum set of capabilities that all devices
> >> support. If that's not the case, should it not just be marked deprecated
> >> or removed entirely?
> > To be honest, I could use some guidance on the best way to handle this.
> >
> > When I had written this patch downstream, lx2160a.dtsi only had serdes_1
> > defined, as "fsl,lynx-28g", and this patch made more sense. Keep
> > "fsl,lynx-28g" as a synonym for "fsl,lx2160a-serdes1", so that new
> > device trees still work with old kernels (as is sometimes needed during
> > 'git bisect', etc), for some definition of the word "work" (more often
> > than not, unsatisfactory - for example, fw_devlink blocks probing the PHY
> > consumer driver if the PHY driver doesn't exist, but the 'phys' property
> > exists in the device tree).
> >
> > Unbeknownst to me, commit 2f2900176b44 ("arm64: dts: lx2160a: describe
> > the SerDes block #2") came and defined the second SerDes also with
> > "fsl,lynx-28g".
> >
> > The second SerDes is less capable than the first one, so the same
> > developer then started battling with the fact that the driver doesn't
> > know that serdes_2 doesn't support some protocols, and wrote some
> > patches like 9bef84d30f1f ("phy: lynx-28g: check return value when
> > calling lynx_28g_pll_get"), which in all likelihood could have been
> > avoided using a specific compatible string.
> > The lynx_info ::
> In upstream my patch fixes nothing, it added a return value check
> for a function call that can indeed return NULL.
> 
> My battle was a different one, unrelated to varying serdes block features
> (I claim it can also happen with same phy on serdes block 1):
> 
> I found that the combination of Marvell 10G phy driver, pcs, serdes and dpaa2
> did not strictly adhere to phy-connection-type set in device-tree, or the initial
> mode negoitated between phy and mac.

Yes, it doesn't have to.

> Once phy negotiated a 2.5Gbps, the kernel would then try switching
> all 3 drivers to a 2.5g mode, when it should have stuck with 10gbase-r,
> or reported an error knowing that the serdes did not advertise support for 2.5g.
> 
> Due to massive downstream refactoring in the vendor kernel serdes driver,
> there existed a code-path leading to null pointer dereference.
> But that was also a consequence of other mistakes.

Sorry, I interpreted your patch in the only way that could have made any
sense.

In the circumstance you describe, isn't your fix just "code after return"?
How would have lynx_28g_set_mode(PHY_MODE_ETHERNET, PHY_INTERFACE_MODE_2500BASEX)
gotten past the lynx_28g_supports_interface() test without being rejected?
The driver would have needed to suffer some pretty serious modifications
to allow this to happen, and I'm not happy with the fact that it's changed
to handle incorrect downstream changes, without at least a complete
description.

> > lane_supports_mode() method from patch 14/14 is supposed to say what is
> > supported per SerDes and what not.
> Indeed, and upstream properly gates all reconfiguration attempts using it.
> >
> > In terms of implementation, what does "deprecating" the "fsl,lynx-28g"
> > compatible string mean, compared to removing it entirely? Would there be
> > any remaining driver support for it?Should I compute the common set of
> > capabilities between SerDes #1 and #2, and only support that? What
> > impact would this have upon old device trees? Is it acceptable to just
> > remove support for them?
> When you remove the old compatible string, the driver should still keep
> supporting old DTBs.

Thus thinking SerDes #2 supports all features of SerDes #1?

> I personally believe it correct to keep dual compatible strings,
> reflecting that the serdes blocks share a common programming model.

Thanks for the input.

