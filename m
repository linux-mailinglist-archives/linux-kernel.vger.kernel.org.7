Return-Path: <linux-kernel+bounces-830895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF81B9AD15
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D7C4C50AF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449BD3128AD;
	Wed, 24 Sep 2025 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z96XGFuX"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011036.outbound.protection.outlook.com [52.101.65.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CF01311AC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758730192; cv=fail; b=sXBE+kUec/G9NSj5Yc543U8ca7bn77fPzjctBR0Y6ds3CiYn53WAtIkVoUPACchYrX1+n8q56kEVc21txp8RBeC/01vUYPaJnhIwO5pJ7oBd7RoNKjGnbW0JVipEhNx32BECA7GRBKOWBweBq8i9Z29RnuJ+xH1OKtjAc+lq7aE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758730192; c=relaxed/simple;
	bh=NwAsBOQN3/OcwkNQZxGJAJ/30VU7wHTRPuY8S7sbYew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gai7xNB1Zaz9KsSL7Pxdd8BTzeIX2Z+28/rQYqWYIODemALO8j3PexjNh5RF8KzdQGd8XUn4Dphtu1ypbiMYIfArGaXe+VqCgB87DWxnS0x8okVduQmatzaHqZrXeCgIeIehSZyAEauW4mdLr0W24QWF2+8wcQjl16aNAXfRJRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z96XGFuX; arc=fail smtp.client-ip=52.101.65.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c020IopWZPhYIs+mWFShkjWvPjWQaNbhGyMYZkrx4h8738cpvk/fccSqUCA82SdZyMa9PcwettGiFBFA5txkUTm1a9vRpKYFKWSCa4yaefdu35nVXp37cs7yHY6fIY2QMG3kzrk8sldqU9JZMNo7KGk4YBdOnk81uZW7j7iRHoGQKR0LfW8VsFzqCIL3zYVPQU7HKFt45bh8wBuKPITdh65YvY69vJ55/6pnr24kdE7G40nr8WrBeWKbZUROciz/ohnN0rbACeBfJ7J57MBob3wmZZFrYATelWMdnYoojrN8MCg8g1d63GCCKWkSwP8fit5yV49AB4egTUNwpBcNrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGYJ9HirLM1Sedf3d0TXCn0I9k7bjwqCigtI6fgsFTg=;
 b=NIRbII1mOCfiVA90C1AEF/BfdroFbNQ+jMsBf68OHAVRcB29EijoZxV+6MuiOOoTnCMTh/Q5NT2h4nk/UjkC29mo5ju6K99tWOLtcw4iE2e9RP8fiQY+ALGw6M7JCiVNTHmS8IO8h6+ZaLCd0nskXGv2j4FDcDp3Eley+OH8Pq9mb970GWGHxrxeLzhDE5U7nJsUdV5EHa+hs9PxYE3OL6+GoaPOHaN4vj5Z5nb8i0b7wfWtm1Sy5yIxEvuVOI7sVJgZGybzdNAJKBD3mN1+l+Rtqbr38BhdCnDnBI485u5UbtMX6sNU8vCu+HBuhUgp73CFSlDBvfHETPNv34DX1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGYJ9HirLM1Sedf3d0TXCn0I9k7bjwqCigtI6fgsFTg=;
 b=Z96XGFuX/nFdtARukCkU1x/5P0cFzpEiE9Q9lWLYeu4eUSKqGeuSmOHH/dEneeBDnyh9rmeIFSB3LQFIhqsv3/AQoUQAGxPmUVZyeJT4mf5Psh8JPBUdvmkAe6wAj4hYEmkVtaXFZyZ6mPDdU6OJ801h1SU9SkJBVvBjdpccdtLWFx4MZdUs+chme5l5JGEgMov0UyqdbgyqjntMXLQpx4MoPjvGcQo8gu95BYt0GeAfTlzEht6Y5PI7uJSOLlJPpIOYSicIvigmB20cYOJc1C2luIBGnCsKtEHS9UOZ0gPe4bDmUhcG4h70BCV/c7lPARU2ZefFEdIzFxuR0nmvAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by GV2PR04MB11215.eurprd04.prod.outlook.com (2603:10a6:150:279::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 16:09:43 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 16:09:43 +0000
Date: Wed, 24 Sep 2025 12:09:36 -0400
From: Frank Li <Frank.li@nxp.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jorge Marques <jorge.marques@analog.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: fix big-endian FIFO transfers
Message-ID: <aNQXwHSQk1anrBA/@lizhi-Precision-Tower-5810>
References: <20250924150303.3601429-1-arnd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924150303.3601429-1-arnd@kernel.org>
X-ClientProxiedBy: SJ0PR13CA0223.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::18) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|GV2PR04MB11215:EE_
X-MS-Office365-Filtering-Correlation-Id: 991109bf-0784-4469-4c9e-08ddfb84c5da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jChTQceXh3AdbGrjWpp9TCyIWS64+V06oDMsmcCGB4Q+bW59PtKmR/Gm3aVU?=
 =?us-ascii?Q?CSIWz9cbtP+gOjVMjOIBf5SgIIZbh0/EM0K49uauD/H0P6ZLZ3GgipEah7Vm?=
 =?us-ascii?Q?JMoCoLsS/dhi3cDuO7t1Vj3XWT7Gxfzo2Eor0BfNo9UhSmtlMVAI+yLK0weA?=
 =?us-ascii?Q?ChGnOXnZ7uOm/VczVrozU692/+VXlBKrBjtPQ2awAspZJ00Taaso+SNWVHjV?=
 =?us-ascii?Q?VKQQlz/uAGaoWx+EfLORNU7fX5cWHST2U390vQR0jlWcPbTKfDjwikvbRmrc?=
 =?us-ascii?Q?3pEgMSufz6yTkHvsEclhDc4Xmqddobjv07jyQgmtgBDbLoNKdA2DliqJ2qyC?=
 =?us-ascii?Q?oeJ4L31wPdMWZ2Gu5PmlqxI6b/Rm//q52LOmovoz027D+9TQcRQIPB5Y9T8e?=
 =?us-ascii?Q?PJsXh3NsbRCcTycHrZTmyDikoT6NzWjVTECIBSbSCr6R3jkfysuNj6wP+EEl?=
 =?us-ascii?Q?hbEyzSqlZYyRc167RPAu2yHJpb9Zjuq5CIYEgUtuCd8e5i3bU5jsC97g5vYM?=
 =?us-ascii?Q?Nlw/yHu4fFrjaWBWSKNdVRFWxMwEWvMbL+6Npk06PIifcgt5pGsd5tgW9nJr?=
 =?us-ascii?Q?TEfQE2Bw2llC8sXg8KUXs+FH1JMo/2CnNXoFv/odhOlAGzJ+I+qDN+7obhoA?=
 =?us-ascii?Q?o1ptGiafJX3kJLz04cAUJGxlxAND7XOWDFvV0T6KZQbAaV2ifth1daA20vGw?=
 =?us-ascii?Q?DBXlBQ8WHT90x1HbKMzxl3BzBwK7WUjt2gMSIdzmjW6LuGAK4p6YE5T9/huA?=
 =?us-ascii?Q?w1TwmFauxd+FhJsEtDvrzRWHJbW/ZVqUeY05tJDS3q0ePIyy8z7/UkAEC3wt?=
 =?us-ascii?Q?G3WsW0152S9Xtqqv5O+QJTlcg8usiA/XSBHNx41H2lbWE2oJVqXAfD52HIkV?=
 =?us-ascii?Q?S5uaxN9Pbi2uSI6Zk08lOndaaHbDIKPbayxVKVijXc7S5iiu3aGFmqTcGSzD?=
 =?us-ascii?Q?nFsU9zJnxqKj11IOoCsQYBhE4IqFTUSoBgD7QCUjHSUSoTqbJ4XfEkWpLGWv?=
 =?us-ascii?Q?ftFWjsr3BodkgN3KJvDyaf3Ca/da7py6TsauXKVp9O1ZTZxEcqypbadWHFJm?=
 =?us-ascii?Q?1fiWusrX8bJ+EK3P4QUM8cS8VqjocygEXI1mYF1Hw/1QNM9JSdgcrUMa0fYa?=
 =?us-ascii?Q?Z5FXj0hSZLjxQXz7O/Qxurgc+TEisy3jcd77BI/FcFY+yi3ryaxutFLW0dha?=
 =?us-ascii?Q?3s0WK46zUXZ1KT5/4+iRb0uUuGrejZp5Jd3Xf+CNaMAvWWGreFG6Dg4ftCjL?=
 =?us-ascii?Q?P2um4+Bz16BSRDgLW95L14lNqyjnPIYnR16Mi4AIxMXupnbhi4KGWRD6SylZ?=
 =?us-ascii?Q?RrfUGj9ufQPx8u7P5jUtzLxNmL+9LxzGb5hNZIb0TFZ2azo8A5+OHGpXLTRg?=
 =?us-ascii?Q?euADQobRAcXSIiinfsB+mUyqTVcuCHmmJVmJAnHeCh5oqTYlgxcyNa8YsG+i?=
 =?us-ascii?Q?8ormOohium6tHujxd34LkRZfE3n5CuaZRdXB11McFvgWd8/1cexzeg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mXbpIfFZdHljtGGGjzlKyW3He6trgILl5ova7AbzTmAD81Jvp2ghTr7etZwz?=
 =?us-ascii?Q?jF9QrmSkvSCnTnEiBSRJ7CpUhMYa6PsoseamRRbDmwDi+Ox8A5M9maF8SAa1?=
 =?us-ascii?Q?APjgj1p/KNowBK9mUUjZh+s6IcPYmR8VsvRTcDDfhEVyB7mewKaYc++JOV3Q?=
 =?us-ascii?Q?EE+U4zYqnEEaQQhxC92NLfsjT7xEO/Wl3h6O1jHVHCgROHwmc9FXwcRjsECq?=
 =?us-ascii?Q?jJw2Ccg7oPgFbi8BXYeef66NBYMY08G+W43gmj6ndIAgxirWGdBBI/NVctwo?=
 =?us-ascii?Q?dPnJ1ucBy5fYXTUom9bHqiekco8MJaU/jpoojTHL6mb8u4pmoRPFIj4hinTg?=
 =?us-ascii?Q?jn+JTq95rTBn37RNvnRb1E8SlVs0xRZyCWH/Rc+3Y3ruzi0ouvD1tNP+33pz?=
 =?us-ascii?Q?c7vi0Xtp0eiLMFvSGKvuVvvpzGIuz++p9EvQ4O4eG5KkL47gOHkjBqcIdsnU?=
 =?us-ascii?Q?npfizz1rFx6NdFFdrTwFZMxzeWZrxCSwzO28aT5ZQOkl0MCml4rYW7CF4Bse?=
 =?us-ascii?Q?zWnvIALx7loGumKGGzuzLrgg03+kiLzt02WdXv5AGekO3hz7U4Vmn0mbpRRp?=
 =?us-ascii?Q?bgu9BKFy4bB5yobXiES3iH9225OYoyXPK+iPp/shhDfU6z3jYKwAdIBOpg7N?=
 =?us-ascii?Q?Ov5Ge4d+keABLC4mAeTfOgNff5FagFuZs2enV1rQ691Z4822uFzKkgKLHjpK?=
 =?us-ascii?Q?oUn3+viMgCry1t9nCjviaQIcKyfvDz8SNYID2cQAnNCiaCEU3juvzZ3HYYPi?=
 =?us-ascii?Q?iXV77Q8haAYRKFUM2N0LvxOL7Q/9utmoE3r+9/ZI/gV61rRKviJ0q6xhrOIG?=
 =?us-ascii?Q?KfhQolv/IGpCf3nVgImuy6F1kgx/NbZ4MOcldUJ+I6X5zlL/KjD3k/GnLzDX?=
 =?us-ascii?Q?Ty7y4xVyaLgK104mqe8o2oC0Cfh1YTrTSZk8NfihYghh18WgoNPJ4JgjW6QK?=
 =?us-ascii?Q?K7vs+73w5kd/4fZvxkXIMFXxKkdq/x1Na/fQCfi0pAg1wMUAU9dqzBEKGVTG?=
 =?us-ascii?Q?rkScr09XiqJinjo1O6ihRPmzoqwyMLo8/vlTd9XsXSjCVzuxB3bg+1FLlS64?=
 =?us-ascii?Q?4tAYEfkrEljna/Dn7RqdmOOK1fJ85GsPLIxZmg0HlSPHjQ7BrfpBLMuuZQe6?=
 =?us-ascii?Q?SuY5uZrUO5++IdYEkJlFkvXQ2H8s3yW+csLa6XvFsc75aP6KMZJ8x0MOQnJ7?=
 =?us-ascii?Q?Ysogq8Ly7gE+BfQE77O6qDvwZhY0XPNRsw1w4NptTsrwHAy9SNfAuaJR8BEv?=
 =?us-ascii?Q?Jm0PlM2Zt4gEAM7dSXG5/KctVteeo9QM4GvBT+TTYn9uPMLC/5AbYSwI+R++?=
 =?us-ascii?Q?r562PqYvLfLAJEF0mQ44LbP5IZZPCrey8HaWshv0mJZuNpsr2A4man0384o9?=
 =?us-ascii?Q?hEqW6h+wL5vrg4HkZscWOuvQwHMzzz0AQWeOuVJObgMExV3xZX2nBgj68oDv?=
 =?us-ascii?Q?0aODyhDD6bsqWE3S6MFcWkrG7A6WzgQa4E2fi1Nnr3UaalCQpoH/Vgu0d+cI?=
 =?us-ascii?Q?k8ItxnrLqAYywbtmE+5BH+R9SsCj1NDwjs0GjtEiz6b/AkE/0puWLzypEckX?=
 =?us-ascii?Q?l6CWiWTzGWx7dCKkAj2CYbZtCntVXVy9dokZjZr5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991109bf-0784-4469-4c9e-08ddfb84c5da
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 16:09:43.3665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFCpyojYSy5TdppgQj46WEwBqXKP0Yr7fgfp4o1HwASZ7SclC+PGOPC3LBX63oqqE7kW6P5ucnxI2rBMIePPLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11215

On Wed, Sep 24, 2025 at 05:02:53PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Short MMIO transfers that are not a multiple of four bytes in size need
> a special case for the final bytes, however the existing implementation
> is not endian-safe and introduces an incorrect byteswap on big-endian
> kernels.
>
> This usually does not cause problems because most systems are
> little-endian and most transfers are multiple of four bytes long, but
> still needs to be fixed to avoid the extra byteswap.
>
> Change the special case for both i3c_writel_fifo() and i3c_readl_fifo()
> to use non-byteswapping writesl() and readsl() with a single element
> instead of the byteswapping writel()/readl() that are meant for individual
> MMIO registers.
>
> The earlier versions in the dw-i3c and i3c-master-cdns had a correct
> implementation, but the generic version that was recently added broke it.
>
> Fixes: 733b439375b4 ("i3c: master: Add inline i3c_readl_fifo() and i3c_writel_fifo()")
> Cc: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This was a recent regression, the version in 6.16 still works,
> but 6.17-rc is broken.
> ---
>  drivers/i3c/internals.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
> index 0d857cc68cc5..0f8a25cb71e7 100644
> --- a/drivers/i3c/internals.h
> +++ b/drivers/i3c/internals.h
> @@ -38,7 +38,7 @@ static inline void i3c_writel_fifo(void __iomem *addr, const void *buf,
>  		u32 tmp = 0;
>
>  		memcpy(&tmp, buf + (nbytes & ~3), nbytes & 3);
> -		writel(tmp, addr);
> +		writesl(addr, &buf, 1);

Can you add comments here. According to function name writesl()\writel(),
it is hard to realize writesl don't swap.

Actually, write to FIFO according to byte sequency in memory, regardless
cpu endian.

Frank
>  	}
>  }
>
> @@ -55,7 +55,7 @@ static inline void i3c_readl_fifo(const void __iomem *addr, void *buf,
>  	if (nbytes & 3) {
>  		u32 tmp;
>
> -		tmp = readl(addr);
> +		readsl(addr, &tmp, 1);
>  		memcpy(buf + (nbytes & ~3), &tmp, nbytes & 3);
>  	}
>  }
> --
> 2.39.5
>

