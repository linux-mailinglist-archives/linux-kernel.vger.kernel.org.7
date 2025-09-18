Return-Path: <linux-kernel+bounces-821872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB4BB82849
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FB1624E06
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2EA211499;
	Thu, 18 Sep 2025 01:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="nqk1dTRB"
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011003.outbound.protection.outlook.com [52.101.125.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C09418DB16;
	Thu, 18 Sep 2025 01:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758159287; cv=fail; b=myTC39v6IVR4ZaA+b31V1XruckmlpeTzjZGIXKaLaz9p3WbAjBNuy1u2EOUS1eaLGTmXmbRsjGnQi4+OOA+Fwule4YwZeIQSSEwQA/rdQo0LXR3JAsdEUBVjerONha0QBmCdj4Vn7UAV/Ryz9lqPFXgrSx48GO/ct2pl5BcTuCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758159287; c=relaxed/simple;
	bh=sLylMs8dRTPwBQ3/HAenqIYqETUXnuPmBVEvOqpDtI8=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Fpn5hq/nH+fzgzez4/tTPXUs6Cn1odxGvWpHD0A1eQPN9xDfGcmLQ4/Atvhi+q6rlDogBhur3EwUmp3ykHym5jf+ww/J8bWjRhmgMrv3UfPxfhnSGpeoIOIDXGKLltAxP06c9aVPFdyeqNYAb+7T1I/Ly9DGov+rwFlKxU2aKGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=nqk1dTRB; arc=fail smtp.client-ip=52.101.125.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjGSYVxm01gdZHpdwsmcbJlJsiXYZ+B4LhECJgc7mK7H6rZ9VHuP6uSFQbhAh6LM5BlgnTgA5KUCP0KJ/T2REv2TO/wvFVHydtk3bLokincH2C5BaWWMckYuY4CJ/n8JN2irc3fdqAfVfor3Dn1I8OkeVceexujwQxWAQI0hHn6RbbmdbEeG9adCU53LqnTg4XUCD2uo4FC81ZEcjLyT+GEKOCks+fSKm/vzTabV+/sRGwHiB3rbLmcpr97E0nW37ggAjgLWcwKluCMqgqlI6MAzjz+g5WBNQ77nXQ1Vqkwf7U3CC3Cs7Clhf5l1c+ZYBBs5DW2hegAScyn/DuOiIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAK9tXTa3lHyquO7eO2KC+SY99qbTBV5f0Kvt4/HzCM=;
 b=Lhcshe/qMiZOkGGlgflflLuShg0rMTnWeFLt6nHzoWuy/r7L9ncmjrr1ng68Ra0Xh8Bamcp4tduLInG/3Lq/8sGNOZK9lzv5Gz2awx97tZW50ZmfFqksOOK0eftFGSrKMHcKTEhsJuTSNfKawJitxfqWzSQd8puSFtka2JoRQNS4/rR/4TG6AJpYR2dne8l5FWpBNJlpLsL4mvIS0v/g7fEa0hmni2avFNiE0JlS0+B6BgPstpvTdfli99Bq6+qyDFneqWsoicOTsmHjFIiJtX5KcDprshumHfpNz4tmxh++mh7CGW81WrRO4CMC0CtBp0AUv0xmCmqgyvgzWar9yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAK9tXTa3lHyquO7eO2KC+SY99qbTBV5f0Kvt4/HzCM=;
 b=nqk1dTRBDpReKwOqDZR6WlFlZ41Xkw1QGc3ENSQb8jTRuDcoob0dOz9mWcI0mD+JZYbDFfCSFjIf/BNH0+VLcwsh5h4zIh7fN14SEVrWlYIl3zPXKRrU1EUCzc66mvLMX442axxCr79VrDALCBLKpAGxyx2peswyMoL1BrzObIM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY3PR01MB10485.jpnprd01.prod.outlook.com
 (2603:1096:400:311::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 01:34:41 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 01:34:41 +0000
Message-ID: <875xdgpmq6.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Olivier MOYSAN <olivier.moysan@foss.st.com>
Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Liam Girdwood
	<lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela
	<perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	<linux-sound@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: stm32: sai: manage context in set_sysclk callback
In-Reply-To: <a9725bfd-a2b8-4343-83f2-d18908029ea0@foss.st.com>
References: <20250916123118.84175-1-olivier.moysan@foss.st.com>
	<87ms6taph0.wl-kuninori.morimoto.gx@renesas.com>
	<a9725bfd-a2b8-4343-83f2-d18908029ea0@foss.st.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 18 Sep 2025 01:34:41 +0000
X-ClientProxiedBy: TYCP286CA0170.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::11) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY3PR01MB10485:EE_
X-MS-Office365-Filtering-Correlation-Id: 38d91382-787f-449a-c7f4-08ddf6538a15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RsnIk/WJS2qvfDnkkW5qPSxglmvZdyFDFYbM/ZAqE6umzgru7ALTpZhi0OSR?=
 =?us-ascii?Q?Sig8Uq52J0TC/LAZmPinn7IgYeANXpHG/+rE9jqse+oEuegAQqivD92WzPhG?=
 =?us-ascii?Q?E7NbeK53KP2E83w/3s5dv0e4geAaXaUWFRh9HxDKDJvYQyMJYDSEP67QsJRv?=
 =?us-ascii?Q?0QXp0CPFI5dzaqbJNJZ5LCrCGJWig6Eo72rNKmFHCnummdFtMjteXmWO1BtW?=
 =?us-ascii?Q?V+JwagJXZU9oNy11YEytlzaPCkx8i4/8Z2OW9pFX1vg8y/nvJzMi4JpR7bel?=
 =?us-ascii?Q?Uj3Bz1QS2nZjFa8hLw5/WpjU9EhtpGd0dA/mUlF2tn/g8tfoKSSj79KQYy9i?=
 =?us-ascii?Q?xnF4CpvGTb2HVLezHTypAFEA7torsHFG4L5cKw1Krv8i0t1/YDaI1q9HDxRw?=
 =?us-ascii?Q?gUGBarGVUl2QTWCNB3EA/NUy+0QFxk0GxsVCUFaW1KffhlU2IT2JK1JbG4Iq?=
 =?us-ascii?Q?AIW5x5eFSvTjEudbz7KG+kDjJl4xkILA71bBE0gi/Oi/VbWGnlFu2lOvUYT6?=
 =?us-ascii?Q?7P693HiFzxKVvtIdZZduImraTky+Gu+S5Rt4rtOqOnNBd2oa9JnptxVMxbCM?=
 =?us-ascii?Q?oBs2QyNDBHZlBs+b8kI16XBkOGUO6yYdFHUvSWvWUd0SK6lLkYdDnOniO8YG?=
 =?us-ascii?Q?pV0dlcgp+bD9+dqLzkFPLpYcIp+UfzN4c1819Hrr6jZ9Hvxvw8eWfxBq6Y06?=
 =?us-ascii?Q?DcAR7vlKJiSuFd/kcfsKKqn/FUPzwSnEgIP2XDq7OddeJOjog/ZF21HIaiWH?=
 =?us-ascii?Q?EbbrAszbWiuXlDbns4fKSzbMLqnWOOGJZwTxOniHRXTTtK6MACG4U8BFxtKR?=
 =?us-ascii?Q?LSjeJONXPxYkd9nhcMYcEoDeBs/3GpE3u4o3AvSUMfODw44mC8Wt7yoXXdnl?=
 =?us-ascii?Q?S5mn7mO0P/E/eMI3DSaZ4Nv6r43JRlOYRFhCrG7P2iarOyHyGL6TsjPxK6ZP?=
 =?us-ascii?Q?x+W+D7igZk6u4MrliPO9Pi+EqwsgSBnejaMyjhzwt5PIvmksx+DDfWfoqpay?=
 =?us-ascii?Q?IAwqnWmM47ttlxVyic7aUi0KTv7DL8kGeslk1q3La6iiLle2ZSbO9QxzhWRO?=
 =?us-ascii?Q?4qCgRiYiu0Z/k1EYfCxjqe2NzRFdwEHp2rcL6KDDYIm/jSTR4kcIS3wrEJmP?=
 =?us-ascii?Q?KGCqGvbdbsQ3xKPQWMnEDv5BkLa0HmwJhpF0B7ETiKsSNNuS07lHVcehj5k3?=
 =?us-ascii?Q?DcWM0oGo3oVA+H5q0mKbRY3ZkCOtBFM9pP2xVRq8+c4NSLKnV3JmJThultzd?=
 =?us-ascii?Q?9FG2s3CIZ4L2hWJINApsm7lxId+y+Hkid0rcjcsTzVKl155HuX7bmW7H6d19?=
 =?us-ascii?Q?IqnYS2bvau1b9WnCB2wD/MnU0uF0kImt/c8uB5pCupDQvUeeipQIDwc1+E8L?=
 =?us-ascii?Q?zWowkRBEAmzeMqS6ekuMM/R6SJlIcU2Pvz3mbIh+OiiM8epiAJCt/sWuUfn0?=
 =?us-ascii?Q?Ox0Er6CXkC3V68+Hzb13ZPOk72ifj/J76XmNP1tETS5OKLiTiqqoXA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lWChznFji6WwIZrsqxPI2nZtn7EWN67adCdbBB9dkn4XiFztN8m4Fxx98TUg?=
 =?us-ascii?Q?lafjZSzxZsx2+RYRJ5My+Pcd3dJF3AcwX9a8Clp4dm6IxGaO07q20kqa/LQd?=
 =?us-ascii?Q?O74mDT5dEVFnMj9XZQqDlpBY4hOUThvUlKihnzDeyPb81cANafbpFDlGQYf/?=
 =?us-ascii?Q?jebqLyuwcxOjylAqPgxUb84Z8Ef96PtgRes6YinZS5BQfUn7aeYP6weqqbza?=
 =?us-ascii?Q?O2FQ5NQ1eZlTe7fdbusRpr0gyVo8Pd9+qmN0qtsBCCX8zBGnP1n3d4iPKBwS?=
 =?us-ascii?Q?4jTb5nmTIk9IDp8fD7rfHj1a2YEWt1pagDgCqQBWU+nt5I92Mh0gF0ToSxKi?=
 =?us-ascii?Q?NJ8X+vrIxuZ1/8/HTqVTWCz1fs414ART6ppumtdQal+h2cuaMcChfc2zTymc?=
 =?us-ascii?Q?D+Crqj2gTcxVB91IQEF7obye1ydipJXBt8pEJaw8oF1vYtJDNEr1PvgrLMkG?=
 =?us-ascii?Q?gHeR8Jsd68pYypX1sVUpp6tCmXDrgVSt4hCStCPe2eFAE/UjOKMHiQpzedZ5?=
 =?us-ascii?Q?If9HPMx5iLZLg0QnDPI3pXOo6AMF8XngR9K7uU0VP8ZhssjRxXaJT6drz7NX?=
 =?us-ascii?Q?eqP0St/XIihaDG/MS9bcA3kdC2Uqw99VdToZ70YCLeDWaA8Q94jBeUEPb0GT?=
 =?us-ascii?Q?/SDukp+y4rbqn5NNRpzHvGywvGHGJBAtjYNXKSl11nEoa/4L/pJZ6e5RAbgL?=
 =?us-ascii?Q?89OUWjN8QQVOhLRt0f6JOTKYyztj7my2Ek6LoxvZPYBT2Q7hJBvc2YQKWbzs?=
 =?us-ascii?Q?COeS45hiJPKFRIaYJpPkhbxJUqFMo/pdSz0hlN5EwUgB2hlzWeFCkYGSLako?=
 =?us-ascii?Q?2iy57Nhpu9/epBCnl+KdmkUXe+eHgEbmktkFFw08jdxPQM8bAlAvs+aO+Yr/?=
 =?us-ascii?Q?EFjDJq4FdvaXciOVc3QwHQX+TYvin4ebaiD+FQYXA0XPM5rqDyS4lz68CuXP?=
 =?us-ascii?Q?GCgETssaIkPAgJ13ihYYt3LHot1DbqW+4l0OZXHcbC4Lp0cN6QvsMMoGnTew?=
 =?us-ascii?Q?81I6uLfgbdt0WM1zT1JxAPy3WL89ouMj8bWOCcBgCBggeom+lPxEbqmdEzU+?=
 =?us-ascii?Q?cEL/RgKdqXEBCum4QSnnLOXeJQny4W+IknnDKBahdlSnkt4oEbINXm6c98So?=
 =?us-ascii?Q?f3khZjrhItUWI/aO9qm4hqYmJpZrGnaLUv4r1D68JOD6gPUHIkaGJmhrtGaA?=
 =?us-ascii?Q?37pU1toSuKBZEqs5WyE6P9lTDwkFj3m98UhoScQ2L4fZMO0/DI14nVtFvqCM?=
 =?us-ascii?Q?AH2z3WnXMn2EB2Jotu89cFTyN5tChTUumrWg0t4KfP53V3Wm60RbBTPcvmT0?=
 =?us-ascii?Q?F+Ysq/pA44LLvmkv5byde2Nv+EavSuRlOnGIhIRFluSsYjUOESJa9HqnMvGp?=
 =?us-ascii?Q?1fSK7+MdWaLcGbW5L10AVOXwnBhT3uvwzplRZFBQ3XHGKRmEziaLG1lg5RWl?=
 =?us-ascii?Q?TYVLF9ogV5bf4poMyqCY1Czzl0dn7fXfuhvo/CkKIOXBm4TDsighRdPMEWxn?=
 =?us-ascii?Q?AfUpy5r9Fqs6U3Ju5cIDhnxKvVG4riMb7YPpgB7jZZqxifMfwkHkebDgEr75?=
 =?us-ascii?Q?sAW2evd13HseD2TaUqyc07tcvO4y5D+C+j83H4lbgrHuwvYA6pIeO6EkKXvm?=
 =?us-ascii?Q?/Jf8jZvkRRiE1xqIw4NwQWg=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d91382-787f-449a-c7f4-08ddf6538a15
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 01:34:41.7649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Sizd2sPTg2741h8+FRbT34i229jNHj2CYRY7hbmH/1iKk579LBJEFTYiWk3KgUkoVCZ/nYceejj5N/xLbU/XQmz26B/tsXk1mIlxpq88gG1jDptjOzQ5Ek0vCIA9rXH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10485


Hi Olivier

Thank you for clarify the situation

> Looking at the traces (see below), initially, we had one call with the 
> 'in' direction (kernel clock frequency) and one call with the 'out' 
> direction.
(snip)
> Now, both calls have the 'out' direction when the property 
> 'system-clock-direction-out' is set. This seems more consistent with the 
> changes from commit 5725bce709db1.

Ah.. simple-card-utils calls snd_soc_dai_set_sysclk() from 3 functions

	- simple_init_dai()
	- simple_util_hw_params()
	- simple_util_shutdown()

but its "direction" is...

Step0:
	Before
	a728f56094e7cf60a1dc0642fe86901d1a4dfb4e
	 ("ASoC: make clock direction configurable in asoc-simple")

	- simple_init_dai()		fixed: 0
	- simple_util_hw_params()	fixed: SND_SOC_CLOCK_xx
	- simple_util_shutdown()	fixed: SND_SOC_CLOCK_xx

Step1:
	After
	a728f56094e7cf60a1dc0642fe86901d1a4dfb4e
	 ("ASoC: make clock direction configurable in asoc-simple")

	and before

	5725bce709db1c001140d79398581e067e28c031
	("ASoC: simple-card-utils: Unify clock direction by clk_direction")


	- simple_init_dai()		dai->clk_direction
	- simple_util_hw_params()	fixed: SND_SOC_CLOCK_xx
	- simple_util_shutdown()	fixed: SND_SOC_CLOCK_xx

Step2:
	After
	5725bce709db1c001140d79398581e067e28c031
	("ASoC: simple-card-utils: Unify clock direction by clk_direction")

	- simple_init_dai()		dai->clk_direction
	- simple_util_hw_params()	dai->clk_direction
	- simple_util_shutdown()	dai->clk_direction

In Step0 and Step1, your dirver is called with both dir IN/OUT ?

> In my setup, the kernel clock is an input clock. Maybe it should be 
> tagged as an input clock. However, we have no 
> 'system-clock-direction-in' property yet.
> Anyway, the patch in the STM32 SAI driver is still valid.

OK

Or maybe reset simple_dai->sysclk somehow (not sure...) ?
(simple_init_dai() will call snd_soc_dai_set_sysclk() if it has
simple_dai->sysclk)

Thank you for your help !!

Best regards
---
Kuninori Morimoto

