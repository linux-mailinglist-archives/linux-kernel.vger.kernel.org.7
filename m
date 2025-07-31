Return-Path: <linux-kernel+bounces-751724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF42AB16CC4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03153A7268
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BD518859B;
	Thu, 31 Jul 2025 07:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Y8doCavn"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013009.outbound.protection.outlook.com [40.107.159.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D436187FEC;
	Thu, 31 Jul 2025 07:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753947095; cv=fail; b=PWdc5BUFwgxo0b4uDw2OLb2VtdWhu+JebtDA1RDsonI+5r9f8YKD7L3sqRhGAlqmk5NX2hgQ6E27r8cX87N066VfYnhbb6jKiuepcJdLGV0Iw4WLzeraq4tnsQqcm2JksCHb/AsMMace2nJujhHmlKlwUATaV5QaAW+jXde8Y3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753947095; c=relaxed/simple;
	bh=uevGHu21stk+kJ8OzdJcv/uOz6vO5K/IK8ef6unz4IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iNdcb/3tltPhr4T5lx2SPA7LEZ0HH7I0IjnYGnxlRX7jD9JTwRNwqkyJ1Dae+VGgfXPHfEp8JfWjahcvlkSj3BWlvPqg3SqZwLXXduXOiw1kJSwz9CcO7TlIERY8nBHxwTzmcaSwHy7Y8SYh65e0NLCIN8Fp+YCXSemfk4725BU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Y8doCavn; arc=fail smtp.client-ip=40.107.159.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLBNJ89C6Ctwlo/DQZ2FO2ez3aZgWgp5i8WvB2r29FhujLQzrI7ae+jAYsqyJXkVoqC2RayPkgcvtaXbs17Pwqyrvo4uAKcBbK79iMJOmbZBbhsqiBgLSVeO57IYGmCDVquA4xYRgxN3zr4/fmxu68oHZvBe9scFHYeQ86b1tbpcdLh181JGYO1r+NYz/4ZNjMWs65dor75ObfqrqQcRCguzUhWvLdVlHImKwTsaz4Q8iP2Degz0xfmpq4dY7lrg3qu8bUqbqDdtELtakK5EkiBwT5iU28x1JjJTxBTEyQ9eCXtbegPHocd3e2/lLwH9tXA4/Y8ZMs/yb/kOG7qKMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=al7sb0PaqWnvrI2wuBfH/Lk4Z8Ssp9m1xI3c1kWfnkU=;
 b=QV1TVLnpSmGbpFAv+iTYTJw6uXiNtuC5lytJHSsyQ2sSOaFuGtbQunm/LFwWlkCIV5U+sZG3wXMNZP1m28HBi/PkSeSCwqaunZuykHF7JKWoihAlBgQGbKwXxe4Thmj4kE2geYc6xF2nHl39Km3SnT3Ije55PU3pTprk5qAmleV7CfpfGZMhUm6QyUSjXVaqrExVeq7mPDAw9o3V9xUjYkBZFlRlirKKmuf0CALsUstrbblsfGIwpCTba7inxXwfjLiYBY3f+yw9Ml0OhlbR56BT3R+/TFMg+U1ygRXDQrKyHQluCoaYP9cwftiQ76TgDUerEvN3eZRDF1nbIrV+Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=al7sb0PaqWnvrI2wuBfH/Lk4Z8Ssp9m1xI3c1kWfnkU=;
 b=Y8doCavnPXr0Ohwia6NT6rQfRXbjogsBUYogNnteQRKHWOH7UgYHZKLN3gQeMI+FsuUByjRvbjHIvwcw9k+Xe2WtnYfUujwh9o1AasU9iXnXjpQ7r8WuxIKMaqqo790FQor/sCoaDlIzl9OcGnI8Qqyezvs+vFZyc3ueqTXSO+5Gik5klWpXrI4qLekJIikr+FmzorQ6YZnbcPFcBw04BQCiQgy9WYw4gGYK1ISW+DmdJKiFZDU9b9CFClC8mdzydtTv0ya9rD1fIuwDIG8yq2QtXQgpdZLIRFE0zGcisNaqoF+Y5RRVoDNuXbWJLMvSDwaKG9urFGWQSkkc47MrhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by VI0PR04MB10686.eurprd04.prod.outlook.com (2603:10a6:800:25d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Thu, 31 Jul
 2025 07:31:30 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442%5]) with mapi id 15.20.8989.013; Thu, 31 Jul 2025
 07:31:29 +0000
Date: Thu, 31 Jul 2025 10:31:25 +0300
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] clk: imx95-blk-ctl: Save/restore registers when RPM
 routines are called
Message-ID: <2dgzmsbzx5geriie4kaolwa6uw43etut55re4pxcvyvy34mlqr@33pynziwfzfc>
References: <20250730125932.357379-1-laurentiu.palcu@oss.nxp.com>
 <20250730125932.357379-3-laurentiu.palcu@oss.nxp.com>
 <aIpHEugNppI2C0/q@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIpHEugNppI2C0/q@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: AM8P191CA0014.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::19) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|VI0PR04MB10686:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ff9d41d-3d53-478f-3bd2-08ddd00443f1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2maabeo+5NY1q8psOgN1eEHiAA1pmXAvx0P/huIjpCXMsHMVovzdL3VDyVuN?=
 =?us-ascii?Q?rFMDoK9xdueB0FPd2T9UcpqWLZ+URhNbEyY8aDgF3i0tJPDRPwU1/ORX8Z9p?=
 =?us-ascii?Q?mNM556ZLHRe2xmbEf2ndhXYLV+PqNmSacjyGLhjoJpW14WzNu8SbP7nStxcv?=
 =?us-ascii?Q?MwLqBDtGn1TTV0q6U3mrVS+hz1oFNz1ZpqO4HNHkk3mZQxFPWO12e+NtV7hd?=
 =?us-ascii?Q?lkbYCA0z25SAUWHM6qX7Jk3IyakD7G9HjS078un1xvaj8yEkYfYXxXJmf2NJ?=
 =?us-ascii?Q?uV39XsUmbub9s5iKqbBJlJNv8Iwsjoi/vFdADImxEOginJ+qZJ9KhdkINu7q?=
 =?us-ascii?Q?v2A7kcR/ZO7+Jv7zcWyT/CK1gdwEtO1sPHj4vI+WpJwNnNjc8oNRq3wxzHG6?=
 =?us-ascii?Q?T7rwL311L4maUCCCEHY865zlqkdB+BV1UuXeMdNFb2vZ3M/CLf9juKeuiMvv?=
 =?us-ascii?Q?ZKuxUVUVMTfNHK0GgOTDSEnGx7/ZX/G1kT2uibd2Veu7YWLQ9oknNXinnc4o?=
 =?us-ascii?Q?RM4pkJHtTFXeDaAP/DqEFkzrlgeUZLG9MCywRlQyYXZ5xdBkW253tisRqXki?=
 =?us-ascii?Q?wJwJfyeuUW9OJMAh0ZKku/I9sw/TT1cFpceQE3QsUayoWcmHYST/GnBxhhi7?=
 =?us-ascii?Q?hqqKaBa3kvYJ/uFao+6DjKw5X+/S0lETUDkZ8WnGFpu8X+Q4VluwrbE/kyu7?=
 =?us-ascii?Q?ugSxa2A4rk9bZMOpkMheJmRMxBNsH+/7BPFbQS6luiJEt2XtfmTPvG7tpMv+?=
 =?us-ascii?Q?loLQvZubJj7FQvjjPkPbsxgGWyrZjsi0NK5wO+0qj0DBXRkPmT9XXOVhl6pS?=
 =?us-ascii?Q?DFSsZjUPYmUs8UzwFXh3rqwHqFALVcmbVsLP0CAakkX8CEx1MhY0Ke8c7bSJ?=
 =?us-ascii?Q?UCJxCQlGafXGkvhXZKLnqd1Ci8iPViea/+/Tu9FELtyQ10uhibf2t93ZJTsE?=
 =?us-ascii?Q?bagc/o2pOUemH5d+flyadXpeuRvv1BC5EURBSAQIpIC4m8tnkgBYX8bLuWX3?=
 =?us-ascii?Q?fk8FlO4eq2PWFsJF7AVvMni12W8iQgsNgU6t3IHT17OVdRiPNiM9r1gfcD+E?=
 =?us-ascii?Q?ih5TTfa+xrhJ7uRHZkvEimxB7xgiif8jjGP6GmpAQ9/9YlEuz3bcHqiVNEgs?=
 =?us-ascii?Q?1cDqvfehs1586cZIfBKK+Wdd4sc434ODgi8hUtZ4Np1HLFkne3S/Su46k5vt?=
 =?us-ascii?Q?r9JQ6IfuPjDluZk4mH4I03Zg22j9o6GBaNpJl62hvbM8mzW5XTi7AaNdurBp?=
 =?us-ascii?Q?ievN01pzof5sJVsQJrbcjbm4B+QVQzMKU8s7DK7wrfq7wKyG1d8Mv4RnQZ/D?=
 =?us-ascii?Q?ab3MnOOZ1rjEsYZjFw9Te7al1lXKQjel90OST9qEB0QgWkoZK6yn8ahCfnTk?=
 =?us-ascii?Q?lsntf+vKot3M/Hy6XGZMUZ7MLDU6Hyd4FiPz3dslIQsT/qLP038pb4Euyzvm?=
 =?us-ascii?Q?3Dutv9LBEj0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9135.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?frnazKBEIGCXhvcPyBl1wC9Z4SDKzEYb/rSLNEh8D0fKpaxw0CCNnmXZy7Cd?=
 =?us-ascii?Q?ftKDqzPvjHX8lUZrqqevuIm/4UV9lGRAOpFtlx+nZ5BatO+U6pB7xvZAHc/y?=
 =?us-ascii?Q?Ip26TRDT84FWpVwrm6FsXe5fGStloeP+VAd93wtDItOqlAONRipmrqFXsSSR?=
 =?us-ascii?Q?mRhG65mG6oLk2U55uUWFJIiDgSCKSwvhf5cQ7ei6RGNBwtLrul9X55tO+iB9?=
 =?us-ascii?Q?DzMNxHwrvfxelJMR5UWMNyTBk9sZ9Y/dSN8hGaOrQYeQl61jOS5KLNJyINg6?=
 =?us-ascii?Q?ZjArQWuqajsBfaosdxZQyxPtX5qi2qxc5SxkWFf96ceBVCzjBAK/bHVYLYHC?=
 =?us-ascii?Q?7NPOqxBDxxfDhgckYHeYCsBUbTQwRMx3N0D0wSrkqcoHPaNBI7JsMkPCuIkD?=
 =?us-ascii?Q?auhOsQhTt3Bv7KZ5Q1YtgIsmzKlaA7kW1cFIxvFsAjEM59y82X6b3KbGlR93?=
 =?us-ascii?Q?xRK/gOoV3Z34UHDhiY+6oD+Yog2nBrqaj9ED9heuEcU1gVigFh58I/dh5OED?=
 =?us-ascii?Q?spNBF3ClWnzDrSs9BX8uvviN9+/9Cp0ZrbpYONdaJrXz69Nj+59t5vdWFBIu?=
 =?us-ascii?Q?FodsHs8SDGh2Jcbx4jX/EYiDAf0KfXij36lPZbcon4QRQdUwTJhpkJh0g6j3?=
 =?us-ascii?Q?9Ci1G6/vWhFioGo1I8kch8tGO4yuPjnqobblKg8RGNW7GXtbd+CpZt0dNmsB?=
 =?us-ascii?Q?LNZVK6HCbCgIOHBDvGFiOZGswMWvjgzqlkHEpaMI/nnr9uTWNIGqLeKopJGW?=
 =?us-ascii?Q?zMaLLzHad7qmwEWjEG/isHDXhwIxquHsMWOwI2f6kUatxnofOT0jOT1OSwXs?=
 =?us-ascii?Q?efTC1bhutIlo46tvAmkeEWg+Uymc+UJLg/q9JQiPn8gov/vNZSRhsxuASpxk?=
 =?us-ascii?Q?184rHJM9hOCuQagpReVgzAPOTv3N78d17M7O6QFHTjWhqSeBuRWRRMPmM7I5?=
 =?us-ascii?Q?XbQPZUWmDCrbnvzgpQ5bFOGGzWHdvdQ/XKVTca6WimamWJ+JwomazDsUsafO?=
 =?us-ascii?Q?LetmmDQL3w52LirYRi96hGH89E/EtQPKfgTkuAHqmY0kVl+4GcCrOUPj73Sk?=
 =?us-ascii?Q?1JsElhLID/AfadtjYc27anheuyoIKetM6q0bj3BUAdCFcsQtURLLgHtnPeS0?=
 =?us-ascii?Q?cOuopHUDY5RbD6U2HJaEJk2d4jnx+LTtMeqTStqknlgCWpFv0xu5klhgJhDT?=
 =?us-ascii?Q?aQp/06J7CIAAIQc98/7f3C6Kh1Y4GJqE2U1my1waQfhpu8iFsKt5Jka8wGg6?=
 =?us-ascii?Q?kkRP0f5m8X5MoaSfoP+JeSkh5w9ZyymoVnyaGrSQiUoz4hknydfxZz0gU8uz?=
 =?us-ascii?Q?UwfU6sb0llG6iGT+oAy/UCCakJb8NKVm1S32j9rUc9DTtasAmVrGD3fPJvcS?=
 =?us-ascii?Q?8QqHo52jcGaIc0rzEiqY40FALcrgZAszKH6Vy5pWz8lHVlIDTvb0i79PzgDU?=
 =?us-ascii?Q?YVcdc+IIRxPHuOadFy47EQMqy1V0my0qczQeD1eUMkDypaFwqlo8O8HURJJF?=
 =?us-ascii?Q?h5/7x2EDv7fGwWD42r1FcZWDFeq4keOJipsfamQjN1BR57ehHlTJgDTKs9h6?=
 =?us-ascii?Q?d9/Bc18XEGd/VVoZx6VjL4EClWwPhDBXAfGsG35/PxosIC19B2Z3rZxN+gG2?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff9d41d-3d53-478f-3bd2-08ddd00443f1
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 07:31:29.8021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eD+B2nItR04c28U+LXjKOMPnRW5GOoA2HNNmWzCXpGNtjlQhjF8ZUjLw9Oy6pXSLQ9pPxjgySmczi0fmlDhTtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10686

Hi Frank,

On Wed, Jul 30, 2025 at 12:23:46PM -0400, Frank Li wrote:
> On Wed, Jul 30, 2025 at 03:59:31PM +0300, Laurentiu Palcu wrote:
> > If runtime PM is used for the clock providers and they're part of a
> > power domain, then the power domain supply will be cut off when runtime
> > suspended. That means all BLK CTL registers belonging to that power
> > domain will be reset. Save the registers, then, before entering suspend
> > and restore them in resume.
> 
> Save the registers before entering suspend, then restore them in resume.
> 
> >
> > Also, fix the suspend/resume routines and make sure we disable/enable
> > the clock correctly.
> 
> Check runtime pm status in suspend/resume routines to make sure
> disable/enable clock correctly.

I think the current commit message is clear enough already and follows
the guidelines. Obviously, someone else could rephrase it differently
but I'm pretty happy with it in its current state. TBH, your suggested
changes neither add new information nor correct any grammar or spelling
mistakes, so I don't see a strong point in changing the commit message.

Thanks,
Laurentiu

> 
> >
> > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> > ---
> >  drivers/clk/imx/clk-imx95-blk-ctl.c | 33 ++++++++++++++++++-----------
> >  1 file changed, 21 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/clk/imx/clk-imx95-blk-ctl.c b/drivers/clk/imx/clk-imx95-blk-ctl.c
> > index c72debaf3a60b..56bed44719954 100644
> > --- a/drivers/clk/imx/clk-imx95-blk-ctl.c
> > +++ b/drivers/clk/imx/clk-imx95-blk-ctl.c
> > @@ -453,15 +453,24 @@ static int imx95_bc_runtime_suspend(struct device *dev)
> >  {
> >  	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
> >
> > +	bc->clk_reg_restore = readl(bc->base + bc->pdata->clk_reg_offset);
> >  	clk_disable_unprepare(bc->clk_apb);
> > +
> >  	return 0;
> >  }
> >
> >  static int imx95_bc_runtime_resume(struct device *dev)
> >  {
> >  	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
> > +	int ret;
> >
> > -	return clk_prepare_enable(bc->clk_apb);
> > +	ret = clk_prepare_enable(bc->clk_apb);
> > +	if (ret)
> > +		return ret;
> > +
> > +	writel(bc->clk_reg_restore, bc->base + bc->pdata->clk_reg_offset);
> > +
> > +	return 0;
> >  }
> >  #endif
> >
> > @@ -469,17 +478,12 @@ static int imx95_bc_runtime_resume(struct device *dev)
> >  static int imx95_bc_suspend(struct device *dev)
> >  {
> >  	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
> > -	int ret;
> >
> > -	if (bc->pdata->rpm_enabled) {
> > -		ret = pm_runtime_get_sync(bc->dev);
> > -		if (ret < 0) {
> > -			pm_runtime_put_noidle(bc->dev);
> > -			return ret;
> > -		}
> > -	}
> > +	if (pm_runtime_suspended(dev))
> > +		return 0;
> >
> >  	bc->clk_reg_restore = readl(bc->base + bc->pdata->clk_reg_offset);
> > +	clk_disable_unprepare(bc->clk_apb);
> >
> >  	return 0;
> >  }
> > @@ -487,11 +491,16 @@ static int imx95_bc_suspend(struct device *dev)
> >  static int imx95_bc_resume(struct device *dev)
> >  {
> >  	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
> > +	int ret;
> >
> > -	writel(bc->clk_reg_restore, bc->base + bc->pdata->clk_reg_offset);
> > +	if (pm_runtime_suspended(dev))
> > +		return 0;
> >
> > -	if (bc->pdata->rpm_enabled)
> > -		pm_runtime_put(bc->dev);
> > +	ret = clk_prepare_enable(bc->clk_apb);
> > +	if (ret)
> > +		return ret;
> > +
> > +	writel(bc->clk_reg_restore, bc->base + bc->pdata->clk_reg_offset);
> >
> >  	return 0;
> >  }
> > --
> > 2.46.1
> >

