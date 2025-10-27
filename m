Return-Path: <linux-kernel+bounces-871241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CC6C0CB7F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 677924F0EC8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA632F0C68;
	Mon, 27 Oct 2025 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="r363CVTo"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011042.outbound.protection.outlook.com [52.101.65.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DB92EFD90
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761557910; cv=fail; b=a/C10hFMso23mj7UxjsZtX7mawnsv0ZE234qiVVB/y0r4vpooAles6KJ3YCYKKA1kq9YDGHa6KQRI1DBzxo8lGx0cEVUYKlxvJ9RR1PPElCNi5c86d7tEOPxVQXPup0w/eek1HZqbX82s2duM9X/yzTVsq29TAZmGWDHaRzNk5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761557910; c=relaxed/simple;
	bh=/nqY/2aQggnySVmfjZCQvLJlYzQ3ch3O/ArJErkYNaE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qEezAec3LZf/ZkvSGP6/xI6AVG3FTPzymjW58LtcpZcKhJiTnFfR7jiFyhhZfYz71OYXeZ8LmXlTleC7W6q4XIgITfEc2sBp4nW/GcVHCDEfq0OO57cmhvd496PQDlk4GUWu462NLFafsLmpZDpPwNCy9QuokBKOhbibILACGMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=r363CVTo; arc=fail smtp.client-ip=52.101.65.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnY/p0iTj/KpBHqA0oTeexrPYn0+Ve+/VgM03xTxW/3s3cHiT9pHc1k0s2d8r/mBxSRg+dsvqcfqEee+iLcJbk+43s1IJ6Mp9vARM7hfySQcERYJ8b3/hLU96yf1OAeClpQnWm94TAQToZwTrKAoA8BZCj3o9aAbB2IzVfBsUp80Pc2LVWu3ClkPZjW3q+dvOfGD0c1FH1Kd8WhOvxCMbqHIQoamjV4Oq3pODQGkdb8kftrb781YSilh+g4TiXZNJa06fNIhSelMHNKyfluhVQup1cABSFUIawro3Vyh1TYUrLJQrN8DnI9e36gSLU00dSEiWwUGj35VUMcYwt3SFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3uER36Q6Kc+N9709+rM+t9Bg6w50/DR1UIE6yg6f6Y=;
 b=E1pNxfBZFqlGQ3DjI1szlcjSArZ3nGgPbcI0iSaek7qIds8CfKtfetbGvdmSsB+bo/YeyB/3F4zrL7n6ntUIlTOaEeZ4V6bRCmCqbbfJ8J0toNRNi4M7Q0t3/wUzvGXei1h9XY57P3vGsCspt/mGwNlud1MLMLOcO28k758WMN7quPjHVjDxBC1zVYN913pF6/mCDRqBWznCsyllafHsbnFhHs+sO6be18XjQlxBAN5OLelh89jH2hcfECzUJD5gQhDkKZIEtz/1CQHwdgupEEQ0Wp+eENPJRdyLAMm/XnCcwe9p5AhLZlXPSKAArlByXm+dC9c0wXOkQeI3ZHAZdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3uER36Q6Kc+N9709+rM+t9Bg6w50/DR1UIE6yg6f6Y=;
 b=r363CVToGAvfEezpkJfTjqTW/5G7YfReKV6hwbsK0BbNOI8rFwF4rCy7jbqsFXpe80479jPK9jwrwF6jqcbQiHbZfPvd609e6R0F697mRd9l1DXgTBa/nbWaarW1KuOWaD6QdvcyT1YPD8qz8Eq0bvQ8yE+uVzVpzeMsSpfkwzM=
Received: from DUZPR01CA0249.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::10) by AM9PR03MB7883.eurprd03.prod.outlook.com
 (2603:10a6:20b:436::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 09:38:22 +0000
Received: from DU2PEPF0001E9C3.eurprd03.prod.outlook.com
 (2603:10a6:10:4b5:cafe::e1) by DUZPR01CA0249.outlook.office365.com
 (2603:10a6:10:4b5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Mon,
 27 Oct 2025 09:38:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU2PEPF0001E9C3.mail.protection.outlook.com (10.167.8.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 27 Oct 2025 09:38:21 +0000
Received: from n9w6sw14.localnet (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Mon, 27 Oct
 2025 10:38:20 +0100
From: Christian Eggers <ceggers@arri.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Mark Brown
	<broonie@kernel.org>, Krystian Garbaciak <krystian.garbaciak@diasemi.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: regmap: Modeling a shared page selection register
Date: Mon, 27 Oct 2025 10:38:20 +0100
Message-ID: <2765821.lGaqSPkdTl@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <aP8xPOG68qL2IQ-A@smile.fi.intel.com>
References: <2241758.yiUUSuA9gR@n9w6sw14> <aP8xPOG68qL2IQ-A@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C3:EE_|AM9PR03MB7883:EE_
X-MS-Office365-Filtering-Correlation-Id: d002fbac-cca1-44b0-d60d-08de153c9147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bqq51pBARTYjEn3+FSdybAFe6FBAnkMriNZ0ePbtE83pZen4mmqlDEXlC5Q1?=
 =?us-ascii?Q?WsBxJetQzqi/M7rJQ6kWg+ffaSly5Ab9+vkeGoTGQ+6QP5Ku+K6/OYJ7jy5G?=
 =?us-ascii?Q?gjm/mTt//K+IUnAhAYg5uWLV6ftMmZYTok8VtVFaRY39VSSsY4HnyMZMiva5?=
 =?us-ascii?Q?wtSMkULJSUdI58AUxGa/qm17gkO4NMafmlXreBDDQQkXnYxKb2MTnJ4sHop2?=
 =?us-ascii?Q?hIwGlKZiOKYpZb6NP4dlo5M70K05aKthAZtICju7rQfYlXW7SWMPNwzR5xga?=
 =?us-ascii?Q?tprANnUduiNXGdTE/d9acpqBA1IV3vKieeX9Diwp/j0HNVNIJBCVPWyuthgZ?=
 =?us-ascii?Q?MZelzdvwRDDkmN8DpUrEKpfzqusNqUhPuLpBRpi6YkCGAYKJlWSlErptYPi9?=
 =?us-ascii?Q?9UzfKbFfZPwB7DFd6ZuAfHxSvxLsvXhqkevav25vUnl9UPSUmw6DMQqvBEf0?=
 =?us-ascii?Q?opndR0fc3F18DWodIPMuaTZddiiIwVH2XMD18fapwwRXsixOj4uLbApVg+Fa?=
 =?us-ascii?Q?qeNMvfxzE7G6plEFDGDH06g3nWXzcaOHdVtJosi/cqWbR9aH3BZE4SIob5Jg?=
 =?us-ascii?Q?YSkZ1IMU27XtXTi8xhje3voQRa5dpdAFpCd0dr7qtfeYRdr/dJIUl00Sw/Dp?=
 =?us-ascii?Q?/yU0b2fFZ46+jmWltKG6tobAV9DMu9CZtGWAL9+uh6XCr4Go5EmATOBkOLo1?=
 =?us-ascii?Q?ACE3E8onvcsRoroA6BRfAC8KnLsEWtoqHVAoMne/GvrkXr8wDGA3f8sTqQcG?=
 =?us-ascii?Q?2SJfdM0khkweU6Qk7IKbIYyBQQQOIrx2Kn6okkWY8si+IHbVEgfHENm7a0SY?=
 =?us-ascii?Q?lfhrviQIJnBk2U1HAoLpnCpaU9dNswV0pxkR5FQN8BKoHN6lVJam2lKiVGw+?=
 =?us-ascii?Q?tbkZYaSfxjm+mAuMTbfbVPKR+hR487JitvBRT3sewoDy3/2NZCH9TdaVEK/x?=
 =?us-ascii?Q?3PRyg55TwInZY12W7i8C01FB2/YGm2ffivF2Ga4DfIzBFpWAQEkVsnLo9BOb?=
 =?us-ascii?Q?WSr5PzYIQExrGEhECLRBpVa6Ci2WnljB0OIYMab4SOaQZb4USTBjKkIqbcRv?=
 =?us-ascii?Q?uR0gyHXhsxZQ15cH2VKsXoRv4G3GF5M77Xjf0oCY15FWlk6RsN462dlsGoU/?=
 =?us-ascii?Q?lQQkjquE9TGEQXaH0y2eoLUNgvx0gEgjiO6IZd5wOQmicFklq16jaxASTChe?=
 =?us-ascii?Q?4nqwFJ9MclbZixRR4i842Bbq2P+deu3LbxAa6TUR8rc9xV1ZhjzCTAU7AvUp?=
 =?us-ascii?Q?b4ienYgCGD0sPnRbovskMHBatn0y4pXVDd9BO5SSyC7H2ht4l7jD9sOyBDtG?=
 =?us-ascii?Q?CjOXBlk/Wy5PGGNHDDLlI1wlvqT/YmuboMfilmA/C0SM9rOf3/IGwme3tjdW?=
 =?us-ascii?Q?aMgtNJ/vrEbuoCfxZMMIhB69FNjATqYrOV8e9HtYqoTHXTkeekN+ZaDgR7Pw?=
 =?us-ascii?Q?OY8w/F5hFHboJ0cbi1D8QUqRl3XA1V3PyaADc6WazUGpm59QduPxVXnTuN2e?=
 =?us-ascii?Q?cGZRZHE6dOwVkvOYUNKt1XZanyHfPbzKm7qDNYnNmCo9yyZbZrnWjELU1fdQ?=
 =?us-ascii?Q?MjwD5KjZFu/whe2napQ=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 09:38:21.1284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d002fbac-cca1-44b0-d60d-08de153c9147
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7883

Hi Andy,

On Monday, 27 October 2025, 09:45:48 CET, Andy Shevchenko wrote:
> On Sat, Oct 25, 2025 at 06:22:26PM +0200, Christian Eggers wrote:
> > Hi,
> > 
> > I try to develop a driver for the JLSemi JL5104 Ethernet switch (no public
> > documentation  available, sorry).  The device is attached via the MDIO bus 
> > and offers different register accesses (it occupies 8 PHY addresses):
> > 
> > 1. Direct access (on each PHY address for the first 16 registers)
> > 2. Paged access (only on PHY address 0, last 16 registers are paged, 
> >    register 31 is used for page selection)
> > 
> > There are also 'indirectly' accessed registers, but that is not part of
> > this question.
> > 
> > I would like to build regmap for this like the following:
> > 
> > ---------------------------------------8<---------------------------------------------------
> > /* Regmap addresses are built from the phy address, the page number and the register address */
> > #define JL51XX_PHY_PHY_MASK		GENMASK(25, 21)  /* PHY address, 5 bit */
> > #define JL51XX_PHY_PAGE_MASK		GENMASK(20,  5)  /* Page address within PHY, 16 bit */
> > #define JL51XX_PHY_REG_MASK		GENMASK( 4,  0)  /* Register within page, 5 bit */
> > 
> > 
> > #define JL51XX_PHY0_BASE		0x00000000U
> > #define JL51XX_PHY_BLOCK_SIZE		0x00200000U
> > #define JL51XX_PHY_BASE(PHY)		(JL51XX_PHY0_BASE + (PHY) * JL51XX_PHY_BLOCK_SIZE)
> > #define JL51XX_PHY_END(PHY)		(JL51XX_PHY_BASE(PHY) + JL51XX_PHY_BLOCK_SIZE - 1)
> > 
> > /* Page selection register, shared between all PHYs !!! */
> > #define JL51XX_PHY_PAGE_SEL			31
> 
> Ranges are sets of virtual (subject to page select) registers. If you have a
> common subset of the register with paging available, it should be a _single_
> range. I.o.w. _a_ range per set of the registers with a unique selector.

Thanks for clarifying this. Actually this is how I started. I'll try to do
it this way (see next paragraph).

> 
> See, for example, drivers/pinctrl/pinctrl-cy8c95x0.c how it does it.
> The HW has more selectors (i.e. PWM settings) than what is currently
> implemented, but you can get an idea.
> 
> > #define JL51XX_PAGED_REGMAP_RANGE(PHY) \
> > {									\
> > 	.name = "JL51xx PHY" __stringify(PHY) " paged registers", 	\
> > 	.range_min	= JL51XX_PHY_BASE(PHY), 			\
> > 	.range_max	= JL51XX_PHY_END(PHY), 				\
> > 	/*.selector_reg	= JL51XX_PHY_BASE(PHY) + JL51XX_PHY_PAGE_SEL, */				\
> > 	.selector_reg	= JL51XX_PHY_PAGE_SEL, 				\
> > 	.selector_mask	= GENMASK(15, 0), 				\
> > 	.selector_shift	= 0,						\
> > 	.window_start	= JL51XX_PHY_BASE(PHY),				\
> > 	.window_len	= 32,						\
> > }
> 
> > static const struct regmap_range_cfg jl51xx_paged_regmap_ranges[] = {
> > 	JL51XX_PAGED_REGMAP_RANGE(0),
> > 	JL51XX_PAGED_REGMAP_RANGE(1),
> > 	JL51XX_PAGED_REGMAP_RANGE(2),
> > 	JL51XX_PAGED_REGMAP_RANGE(3),
> > 	JL51XX_PAGED_REGMAP_RANGE(4),
> > 	JL51XX_PAGED_REGMAP_RANGE(5),
> > 	JL51XX_PAGED_REGMAP_RANGE(6),
> > 	JL51XX_PAGED_REGMAP_RANGE(7),
> > };
> > 
> > static const struct regmap_config jl51xx_paged_regmap_config = {
> > 	.name = "JL51xx direct accessible (paged) registers",
> > 
> > 	.reg_bits	= 32,  // roundup(phy[5] + page[8] + reg[5], 8)
> > 	.reg_stride	= 1,
> > 	.val_bits	= 16,
> > 	.readable_reg	= jl51xx_paged_regmap_readable_reg,
> > 	.volatile_reg	= jl51xx_paged_regmap_volatile_reg,
> > 	.lock 		= jl51xx_regmap_lock,
> > 	.unlock		= jl51xx_regmap_unlock,
> > 	.max_register	= JL51XX_PHY0_BASE
> > 			  + JL51XX_NUM_PHYS * JL51XX_PHY_BLOCK_SIZE - 1,
> > 	.cache_type	= REGCACHE_MAPLE,
> > 	.ranges 	= jl51xx_paged_regmap_ranges,
> > 	.num_ranges 	= ARRAY_SIZE(jl51xx_paged_regmap_ranges),
> > };
> > 
> > ...
> > 	jl51xx->regmap_paged = devm_regmap_init(dev,
> > 						&jl51xx_regmap_mdio_c22_bus,
> > 						jl51xx, &jl51xx_paged_regmap_config);
> > 
> > --------------------------------------->8---------------------------------------------------
> > 
> > The problem is, that devm_regmap_init() prints the following error:
> > 
> > > jl51xx 2188000.ethernet-1:00: Range 0: selector for 1 in window
> > 
> > So, regmap complains because the selector_reg (JL51XX_PHY_PAGE_SEL) of one
> > range appears within the range_min..rage_max area of another/all ranges 
> > (PHYs in my case). But this is how the hardware actually works.
> 
> Of course, the idea of paging is that you have a single address space which
> maps on per-page base. Also consider leaving the default page address be
> untouched (meaning that most likely you will have direct access to the
> registers _and_ via virtual address space to the "default" page).
> 

I guess that my problem arises due to the way I built my virtual address map
(I took it from the vendor's SDK):

> #define JL51XX_PHY_PHY_MASK		GENMASK(25, 21)  /* PHY address, 5 bit */
> #define JL51XX_PHY_PAGE_MASK		GENMASK(20,  5)  /* Page address within PHY, 16 bit */
> #define JL51XX_PHY_REG_MASK		GENMASK( 4,  0)  /* Register within page, 5 bit */

As you can see, the PAGE part is in the middle of the address, which
causes the PHY part becoming part of the value calculated for the PAGESEL registers
(which does overflow in turn). I haven't tried yet, but I guess there are two options:

1. Manually splitting the PHY and PAGE parts from the PAGESEL value (when writing
to the PAGESEL reg). Then I would need to record the current PHY value outside of the
regmap and add it again in my read/write callbacks (sounds weird).

2. Rearranging the virtual address space, so the the PAGE bits are in the
uppermost bits. So the PAGESEL value should be calculated correctly, but I'll
need to split the PHY and REG parts within my read/write callbacks. This looks
more straight to me, but differs from how it's implemented in the vendor SDK.


> > Of course, I could access the JL51XX_PHY_PAGE_SEL also via unique aliases
> > which lay inside the individual ranges (see the line which is commented out). 
> > But this would break caching (as all aliases of the PAGE_SEL register share
> > the same resource in hardware). Caching this particular register is the 
> > most significant speedup I can imagine for this device, as it has to be 
> > accessed for almost every other register access.
> > 
> > On the other hand, the PAGE_SEL register is not meaningful for the first
> > 16 registers of each PHY.  So, coding individual cached page selection logic
> > (within the driver, without using regmap ranges at all) could avoid
> > writing the PAGE_SEL register when accessing registers which are
> > not dependent on the page selection logic.
> > 
> > I have also tried to model this using only a single regmap_range (for
> > all PHYs). But then, the 'PHY address' part of the regmap_adress gets
> > lost within regmap's page selection logic (the PHY address becomes
> > part of the page address, until it is by the masked out by the 
> > 'selector_mask').
> 
> Perhaps it's due to the detail I just described in the previous paragraph
> (of my answer).


> 
> > After commenting out the "selector / range" checking logic in __regmap_init(),
> > everything seems to work fine:
> > 
> > #if 0
> > 			if (range_cfg->range_min <= sel_reg &&
> > 			    sel_reg <= range_cfg->range_max) {
> > 				dev_err(map->dev,
> > 					"Range %d: selector for %d in window\n",
> > 					i, j);
> > 				goto err_range;
> > 			}
> > #endif
> > 
> > This check dates back since 2012, so it feels wrong to me to simply remove it:
> > 6863ca622759 ("regmap: Add support for register indirect addressing.")
> 
> Right, the logic behind paging implementation in regmap is a bit tricky
> (and has some known non-critical bugs, FWIW). There is no documentation
> and it appears that most of the drivers using it, do it wrongly.
> 
> I am a bit lazy to spend time for googling, but you may try to exercise the
> lore.kernel.org search with my name and things related to the regmap paging /
> selector and find some discussions in the past.

Thanks for providing a pointer.

> 
> > So should I better open coding the page selection stuff into my driver?
> 
> 

regards,
Christian




