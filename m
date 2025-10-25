Return-Path: <linux-kernel+bounces-870005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A31EC09935
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2931C80DA9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D37D311C11;
	Sat, 25 Oct 2025 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="SKDSfV6o"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013016.outbound.protection.outlook.com [40.107.162.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3072FE061
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409359; cv=fail; b=o07Bsv77adHI8+y2Brs5q/ZM5hIxUT0YU6+51TGZu/NSz8L2x5G3DnjopLacUiET+eMB3gMA1LuXqnWGlItq4hhFuXRvLhU3E3tdEVp3IJQ+nTQhqTPwwkRFkHWhhQIoFuHCCrd6R6+A1IRUPPINFR2XXSSxGVDTR9tcLmD9wiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409359; c=relaxed/simple;
	bh=dISHuUzW6at+2InJ0A7wsiqMDsiQVoOKKEbfgucXuHI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r4+7umc0Pm625hhIAyi8yZtqH59+PBpH74GK75f0bIbPA2GPQuLqJirnUm2A6/ZEuTXgDG1ne5lhl3Bv3j/TMKTBIxShsWVf4uGPrIfaz4xVMoKCe/GCBpFsCvCOntindyw0kGjRwU34Op4yJ9/ltBa18vrOVQbCI5CXoNdRA7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=SKDSfV6o; arc=fail smtp.client-ip=40.107.162.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWlPozsVDcBMb9OEO+c2M+hRHqLKZmnZAKHzaFksQjRkys9KsYmw4qtKajgYXZ4Abh42dFa7X3PewbWTLAmjN3uOZRwiO1UKvt8CI3jVZgS0qCphDRigwWhKxfwvervvXf1A5e3fZuPHWj4AMKHVx+d2o35l1VJ1+mDP0heyJbgX5//M3AUVAEH7GCh4X9N5OwZYz19C2NesbiZr24izwNIUMB7lJDzZPNUlOJHjvxl8sKlsU0GMeb8/mEwDKL93q6TGeZrlJDMYLUBkzs7uHqZIW5O+acRlXzBR7CkSCbrIAcszUKlJeNUxN98lsoPpbjRb80XBUkEOL4eKg8eS8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsTxHB8hpuMYArQa6dYvvi8H7HFnJrbPtavhfIGP0Ag=;
 b=eu0Ey/kDXxDMGUj6LWPU1moadIwNavLWe7SGJJmVl4fy1EEmCmNF8ghWyptCwq41LS+ebgruN+Vo7M7zWqAnzTG2qtGdPRyCUc4z4P80SDNfwfVxBZGzBwKIeNWotk5hGH604jP75ebgCscbNbs5IjiI0sqcTBknjzWIynO/uykpVf9X9UwHAaXOulI+KjDwZ9DxrgjlVhQ2Iw/PTgoBwWhNB7Kn/haceLIyzOa8t66y0UI3qFzhZOkdqmj5SgeDjFe4SLNl7Ec3e9zUBOFoXbwqZbo/mD/z1Jl4X8DSTV8p/BpoO3YWBsLf4cBsiJqqE2nHyfcKAf3T2P9lot0nKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsTxHB8hpuMYArQa6dYvvi8H7HFnJrbPtavhfIGP0Ag=;
 b=SKDSfV6oEgqlWjzgOc3eOk/8TsaRQimV5gbFQlumTHPZknemLNjkdn2CKeMTZ5QASyigMVPeHn9RVWLbIPcL5yCrQAZpQfB1jaldxpDi61xmXGxGc6kYYV93wmL5MyKsytAgWv8RpZWGhvncMwXHnvTbl0uVbUbuPdthPDmtQ6g=
Received: from DUZPR01CA0227.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::15) by AS2PR03MB10137.eurprd03.prod.outlook.com
 (2603:10a6:20b:5f1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.15; Sat, 25 Oct
 2025 16:22:28 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:4b4:cafe::3b) by DUZPR01CA0227.outlook.office365.com
 (2603:10a6:10:4b4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.16 via Frontend Transport; Sat,
 25 Oct 2025 16:22:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Sat, 25 Oct 2025 16:22:27 +0000
Received: from n9w6sw14.localnet (192.168.54.18) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Sat, 25 Oct
 2025 18:22:27 +0200
From: Christian Eggers <ceggers@arri.de>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Mark Brown
	<broonie@kernel.org>, Krystian Garbaciak <krystian.garbaciak@diasemi.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>
Subject: regmap: Modeling a shared page selection register
Date: Sat, 25 Oct 2025 18:22:26 +0200
Message-ID: <2241758.yiUUSuA9gR@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|AS2PR03MB10137:EE_
X-MS-Office365-Filtering-Correlation-Id: 99e25e70-fd99-4cd8-2824-08de13e2b08e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4CeUmT2YnFpMJy0wuFZBwVZc0kuTfw0xDjWXbaRS5ZRACIQ52b3ut5z5SWKY?=
 =?us-ascii?Q?otSsZ6jsJ1M+CkxsFlnXQ6ceLFXWl3OfKh0yOGSsGDrSWnMiIulvjNYZCMR7?=
 =?us-ascii?Q?NA+FIX9fze3GgOOByd9cavyUS62dDqQhTok5vmROjkY9ajsy7uQS8lRC618W?=
 =?us-ascii?Q?gcBrwRq462SvdtcBpb7FCqJM3VhHkPzKuCVdw2r+5RR0aoueE6JReAn+gTiS?=
 =?us-ascii?Q?sqp2vNrF4epTLFLEF0DJnhvcPps8lyv4tJUdTTOQO5u+lM+S+n2OXynEWIpz?=
 =?us-ascii?Q?JqSrSZ+cpNzHR/KN7voyDh6vVsThEzPeeXn6Mv1mBzxN51uV30VUrrt4IPaU?=
 =?us-ascii?Q?v65HIgEJlerluUbmIHLw4DXDZFWJlaf6am59cHnJMMs+NRKbJKalIcAyjUtm?=
 =?us-ascii?Q?BuQxlGVox0l9Xzec3r5QUd3CTLPEdVM10XQv/0YfLmQwpBhlk++3BHU4ZHRL?=
 =?us-ascii?Q?1J9v8a2XklOSsEvavGzL2ubTVXfjUY6WD39k4g/KXVP/o5aczmXX426F1Raz?=
 =?us-ascii?Q?mpBotD5OCmRH4wO0/sHtnF7tnkqmJAA7Val9S1rP3WG+K5kgu9CDeOeZH2W8?=
 =?us-ascii?Q?WaLZO+dtfBwfa6HJ6682N1gtOETzqWaw6vLh5WSJtCzde0O7d1i18OBInqmW?=
 =?us-ascii?Q?U2M/ml9JwQ+223NVg0/gS8BVFXaWZfrFPaiY/gkPzx1RgA1ZJN5DaunA0rtV?=
 =?us-ascii?Q?9qc0C7qColJC5mDcdBe0fN6VF8lbZqj0eJ+4k1YHiKQBopsGT9oP6eIjsSpe?=
 =?us-ascii?Q?3uhUXrEy81EKV1YVeAwFrGhkPkSfXnTOwyi+HqqhLOFLLq45Ppt+GK0NlcMn?=
 =?us-ascii?Q?M4U/48G8FQPU1d5/r1U8BsqyWapqlndWX6ikzTgKl7Ao0/KsOpNNdNtWqMSz?=
 =?us-ascii?Q?Ze6v0RwXqwE4rv1HUIPsJRFKQ1TE/UQxy/PTkZmcVjcIDgJ1tnHzRawAQRhO?=
 =?us-ascii?Q?xRgVKQzd0HnFJSQCLRwbPWcDN1vMtyTavQxtjUuObjnET9ZraWgcpDGndh2f?=
 =?us-ascii?Q?6MiykVXQnDpnb+pl8L84RZ1/HGRCKdc222QPDhbKXAHE1l/51nYkp6y6xDDn?=
 =?us-ascii?Q?1+h+TL9GI44IB6LRoykFAGZ1cQ/a3XYepggUoiLF8Bt4pPs7GwhEQXiKW+ju?=
 =?us-ascii?Q?3P2MHWjYUXkI/4kBdl+isc1u3X+DKSobUBfkcZlBNNmy5Hot2QrBxnQbokX9?=
 =?us-ascii?Q?ARBBGZ81p3CPMcrHf9Yavx2mx8PJqlEUeCn1SApIJKYYb/YW0QUgu/asr1sf?=
 =?us-ascii?Q?zyIxWeKCbTezQl0fyLhh6hI+jOMhcb/urJ7hQj3KVabRLPORbnGnfAJtwH6C?=
 =?us-ascii?Q?p307a2TLmyS5vscEsQ4+MiERlnW6e+mkxb/bq0ubhGzWq7rdQoEYu7PEJP/H?=
 =?us-ascii?Q?GP5sgQpz6u0ajYbBkOEGt5juhKZDAdHESBSNwipg7HfxbrGkW45pbFrAQ+Xu?=
 =?us-ascii?Q?VcQ6y0v07Qen2TKl+SQCvudSMw2iF7yh93ojA0fjtJQvs3J2gKKZWkydXMAD?=
 =?us-ascii?Q?Z1H4dN4bdV3M8pGVrRFinRplJ8dfyioQMs/3NSaT0FxKHBE+sQk3qvRzvCc2?=
 =?us-ascii?Q?o38lDY9HkS7L18Yg59U=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2025 16:22:27.8088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e25e70-fd99-4cd8-2824-08de13e2b08e
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB10137

Hi,

I try to develop a driver for the JLSemi JL5104 Ethernet switch (no public
documentation  available, sorry).  The device is attached via the MDIO bus 
and offers different register accesses (it occupies 8 PHY addresses):

1. Direct access (on each PHY address for the first 16 registers)
2. Paged access (only on PHY address 0, last 16 registers are paged, 
   register 31 is used for page selection)

There are also 'indirectly' accessed registers, but that is not part of
this question.


I would like to build regmap for this like the following:

---------------------------------------8<---------------------------------------------------
/* Regmap addresses are built from the phy address, the page number and the register address */
#define JL51XX_PHY_PHY_MASK		GENMASK(25, 21)  /* PHY address, 5 bit */
#define JL51XX_PHY_PAGE_MASK		GENMASK(20,  5)  /* Page address within PHY, 16 bit */
#define JL51XX_PHY_REG_MASK		GENMASK( 4,  0)  /* Register within page, 5 bit */


#define JL51XX_PHY0_BASE		0x00000000U
#define JL51XX_PHY_BLOCK_SIZE		0x00200000U
#define JL51XX_PHY_BASE(PHY)		(JL51XX_PHY0_BASE + (PHY) * JL51XX_PHY_BLOCK_SIZE)
#define JL51XX_PHY_END(PHY)		(JL51XX_PHY_BASE(PHY) + JL51XX_PHY_BLOCK_SIZE - 1)

/* Page selection register, shared between all PHYs !!! */
#define JL51XX_PHY_PAGE_SEL			31


#define JL51XX_PAGED_REGMAP_RANGE(PHY) \
{									\
	.name = "JL51xx PHY" __stringify(PHY) " paged registers", 	\
	.range_min	= JL51XX_PHY_BASE(PHY), 			\
	.range_max	= JL51XX_PHY_END(PHY), 				\
	/*.selector_reg	= JL51XX_PHY_BASE(PHY) + JL51XX_PHY_PAGE_SEL, */				\
	.selector_reg	= JL51XX_PHY_PAGE_SEL, 				\
	.selector_mask	= GENMASK(15, 0), 				\
	.selector_shift	= 0,						\
	.window_start	= JL51XX_PHY_BASE(PHY),				\
	.window_len	= 32,						\
}

static const struct regmap_range_cfg jl51xx_paged_regmap_ranges[] = {
	JL51XX_PAGED_REGMAP_RANGE(0),
	JL51XX_PAGED_REGMAP_RANGE(1),
	JL51XX_PAGED_REGMAP_RANGE(2),
	JL51XX_PAGED_REGMAP_RANGE(3),
	JL51XX_PAGED_REGMAP_RANGE(4),
	JL51XX_PAGED_REGMAP_RANGE(5),
	JL51XX_PAGED_REGMAP_RANGE(6),
	JL51XX_PAGED_REGMAP_RANGE(7),
};

static const struct regmap_config jl51xx_paged_regmap_config = {
	.name = "JL51xx direct accessible (paged) registers",

	.reg_bits	= 32,  // roundup(phy[5] + page[8] + reg[5], 8)
	.reg_stride	= 1,
	.val_bits	= 16,
	.readable_reg	= jl51xx_paged_regmap_readable_reg,
	.volatile_reg	= jl51xx_paged_regmap_volatile_reg,
	.lock 		= jl51xx_regmap_lock,
	.unlock		= jl51xx_regmap_unlock,
	.max_register	= JL51XX_PHY0_BASE
			  + JL51XX_NUM_PHYS * JL51XX_PHY_BLOCK_SIZE - 1,
	.cache_type	= REGCACHE_MAPLE,
	.ranges 	= jl51xx_paged_regmap_ranges,
	.num_ranges 	= ARRAY_SIZE(jl51xx_paged_regmap_ranges),
};

...
	jl51xx->regmap_paged = devm_regmap_init(dev,
						&jl51xx_regmap_mdio_c22_bus,
						jl51xx, &jl51xx_paged_regmap_config);

--------------------------------------->8---------------------------------------------------

The problem is, that devm_regmap_init() prints the following error:

> jl51xx 2188000.ethernet-1:00: Range 0: selector for 1 in window

So, regmap complains because the selector_reg (JL51XX_PHY_PAGE_SEL) of one
range appears within the range_min..rage_max area of another/all ranges 
(PHYs in my case). But this is how the hardware actually works.

Of course, I could access the JL51XX_PHY_PAGE_SEL also via unique aliases
which lay inside the individual ranges (see the line which is commented out). 
But this would break caching (as all aliases of the PAGE_SEL register share
the same resource in hardware). Caching this particular register is the 
most significant speedup I can imagine for this device, as it has to be 
accessed for almost every other register access.

On the other hand, the PAGE_SEL register is not meaningful for the first
16 registers of each PHY.  So, coding individual cached page selection logic
(within the driver, without using regmap ranges at all) could avoid
writing the PAGE_SEL register when accessing registers which are
not dependent on the page selection logic.

I have also tried to model this using only a single regmap_range (for
all PHYs). But then, the 'PHY address' part of the regmap_adress gets
lost within regmap's page selection logic (the PHY address becomes
part of the page address, until it is by the masked out by the 
'selector_mask').


After commenting out the "selector / range" checking logic in __regmap_init(),
everything seems to work fine:

#if 0
			if (range_cfg->range_min <= sel_reg &&
			    sel_reg <= range_cfg->range_max) {
				dev_err(map->dev,
					"Range %d: selector for %d in window\n",
					i, j);
				goto err_range;
			}
#endif

This check dates back since 2012, so it feels wrong to me to simply remove it:
6863ca622759 ("regmap: Add support for register indirect addressing.")

So should I better open coding the page selection stuff into my driver?


regards,
Christian




