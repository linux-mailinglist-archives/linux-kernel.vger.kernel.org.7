Return-Path: <linux-kernel+bounces-752679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476E5B17950
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 01:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71AB117083A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 23:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE2E221FA0;
	Thu, 31 Jul 2025 23:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cGVU+9QA"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012019.outbound.protection.outlook.com [52.101.66.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FB827E1D5;
	Thu, 31 Jul 2025 23:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754003704; cv=fail; b=q/sEBwA+p5OvtftLRQU7dFvTgEja1laYSeNHs0IMpLXyn0p9RDWAorA/4wgaI/0oyDzq63HEVOe1MFC/vTEz/BW2NjGcKZhRoZBLBI77S4CXiuwfUGVJnrHvHjAG/6wrHQXYmBex8r4jEdCI1sFPTrmHIIJLkGEnPe3Hm3lYHDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754003704; c=relaxed/simple;
	bh=t87pA09WnP7CwCYcQFbsSEJV6bVjQag4i7zRBAmuD5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y2KV9HEK1TD7tJkD6wqJoq6UYORkjw8I6embEX0EqejRTMKvxIFfPk3Nw0vwyEw6LEhPol2VjyEE7iG7zlE4cQGaJ2++LYo/7ktu+ELgv1br7cJDPjMsB3Y12ZZee6KhxV8cMzKzq1r1egnRb2OOh8y2VcMHHrUnMyO91OM5TAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cGVU+9QA; arc=fail smtp.client-ip=52.101.66.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urHsmIdg25nhBJnw5KzODcNJlbR+KHiQnwffp65WHzZ6OMFMalatQy9Xrdwb0UM/baOhOBd/Sb+IV2MfITQTKJx8AAZcrDs1NgXfLa+R8XZp3guL09xQjwm8QzE/9aJcjp5BOzpfHi7/Np7NFKa0tv4Okl+9hsxFnztKoMorspUUZYICdz4xlG/dKmhoGWQkoIDt2xXy7LnROZtI5TRA+3/pAecqzZg3KeZ4W2DHs8u4+WLgUiC2UfXZQt7CFzsPrM2H2jpuywsF6Py13A/AOwwv22RLrZVWvHHYtDFQbAAzmWHd/Ys4ClCVDsIYqph6t8+8SZ00dhOI4KAXhKh0Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMFwwK5/OHzfr6Q5AtxIldaQ2NSinHT0wjKQZa9Hysw=;
 b=k2bwcSFgs2D+o8JCGBk4r+rhxya5Ovlic3Z/J/W4MNkkC1VtgfF8PatE7EJpexMW7GYWvF6u3fOVgf7moInjiHGIJd7dvZsqvfa7sA3uv0kg1KRk9E5B7DiJMKrFXC1ySBEuK4kJk5rAk8YY3bPXWfVTKr1R+HzdtjC5wWMd01Lh2TK04A8eo8rKdIi175TH/jckrxVD4+0QwH2FmHq8Mqsdcv2HM/p9GuVMrgedFtbc73rLhSPywujR3tOAt57z4ZX6UCghXTORCtB1f7H3Wtzc5q4iWVqcBntfnKH9mZQfgY+/nUJKNWkukvYrFuwe9oRHQISemTtuSAXJF79rjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMFwwK5/OHzfr6Q5AtxIldaQ2NSinHT0wjKQZa9Hysw=;
 b=cGVU+9QAn2+GicXtc7rlEVSEnOikJYa3FTD8g9W/TYPL0HaBHJgstg23Ni0yiQAvhE8hLMFE9w7UKEYAmqcpzGv9uB3QLieF0pFxwX1ITXmxfjxVlZMNjlGKGdXOMVPbqnzqdmGA0PgoBBHy4o99kcZ/GHpsjdEN5DXeH0uEHGgAWV3KifM0cH2sGxiSU8u7N7Z15OlD0CC66UNzU+JNFltCxJH+S/66nUStLkjV0e0bXdO1KCzjCB6P0Zn4qrN1xyzDpOakt/rrscrVJjqSrkX+YQqKekF0artBqPUKRRWmwmisR/F7hSZgnPK6OCJjZEqaG5at6FTBIgKqS/Gvsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7509.eurprd04.prod.outlook.com (2603:10a6:20b:23e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Thu, 31 Jul
 2025 23:14:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 23:14:58 +0000
Date: Thu, 31 Jul 2025 19:14:50 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] clk: imx95-blk-ctl: Save/restore registers when RPM
 routines are called
Message-ID: <aIv46mUHu9u6uIzq@lizhi-Precision-Tower-5810>
References: <20250730125932.357379-1-laurentiu.palcu@oss.nxp.com>
 <20250730125932.357379-3-laurentiu.palcu@oss.nxp.com>
 <aIpHEugNppI2C0/q@lizhi-Precision-Tower-5810>
 <2dgzmsbzx5geriie4kaolwa6uw43etut55re4pxcvyvy34mlqr@33pynziwfzfc>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dgzmsbzx5geriie4kaolwa6uw43etut55re4pxcvyvy34mlqr@33pynziwfzfc>
X-ClientProxiedBy: PH8PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: d3db5489-bc50-474d-65a6-08ddd0881177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+xnHtAA+tdQdCm+7AEmdCscMgztJ6JNn0oNXa97iW+EeGTknI0V4k/l5L6Hy?=
 =?us-ascii?Q?A0/sT0e6D+MMNnGgR02C0s1tKYlhmCC0bEnCVdPrzPZNzeKAYDdXnMaMqiLt?=
 =?us-ascii?Q?LySGdsEaEy1pPH4ukiGq53gmEiepoMu38NffRtnPl2gf5QIWM7m/gGdk4Wwt?=
 =?us-ascii?Q?Vv9Eo9QBq5Tvju7pgTYE5nGKH3MuZEl9aKcRQDoy8jBcM2smbPz16d8RRdvP?=
 =?us-ascii?Q?kOojksL2XspNCqGx+2dKg+jKMNaHB2nuhqrJj+tW9MXYU7bVQ7xSuv23cQ8L?=
 =?us-ascii?Q?pUkjxK2NkCuvnpVGJZsin6YMoiMI2zmwBhDROvwlX+lLueaGdKDbK8v5ABfn?=
 =?us-ascii?Q?tbHEbkXX6/rm+tApTR0pQWuKUYiqGA06e+xN+QUNJ9eQVV4WTZwJDoSCRn2o?=
 =?us-ascii?Q?0BPLf47A3NfXb7BGli3MhUnpR+/WGQnsbmkbDePgqKvIJV6vRs6YwD5gM9jk?=
 =?us-ascii?Q?QE6zfTL9Cc+J230BIhFcg0SMfG9y7JcZSdhZERQHKRplrFv5/mKqxyeMxe+V?=
 =?us-ascii?Q?TyxhnK2lJWmbOReaxFv2d5+zuFEjjUkI0EaQDxKw9ZoDsSWybzKb5xoZz20M?=
 =?us-ascii?Q?8xm2vG3zSxLMqWoPbDGuCUnpBWX64K/FyLU1MZSV8uulc/2tj2POWVX+UAIF?=
 =?us-ascii?Q?ueknnLCWGG9OUF934zeg7pMmsaXSKHk5tAFgC2F2adPBitva5OZ6sZHMi0Um?=
 =?us-ascii?Q?sl8ZSYKoBgm0vUoIPhyaKOEtRQq4rwk8tan3StQE7WEk6+VEhvFCnsn1F5+G?=
 =?us-ascii?Q?BYy+n/GFXph80AOZgl6r65lPDhrkv1zZ6WjnKxC/4ppVWvmqlc7E7NSrL2ob?=
 =?us-ascii?Q?Mkr/JhehAjlNwB7/dpVmKVVPgaMU3fGQfyTHL3e2CimaSV5m85X7PGHKZTfR?=
 =?us-ascii?Q?6/nO8cu2d6FVUCtStAL2b5PZDGm71ULnKxBwt+jZO6zuqD4nmk3CKB62F5oo?=
 =?us-ascii?Q?joztPgSC0/D9LfC7i5lf9xHlOHRMVTCn9ohCPBVIwc+4dbSWNcw1HNbepmxu?=
 =?us-ascii?Q?6SDAC/0NXoLOU4O2WDUpF8loZx5M/Uwj4qNyPoET25rwsp8qq3AuWDfzfC6i?=
 =?us-ascii?Q?/essJdAh4DvUNXiR42LTCA/0LUO1Mh7ZRNfo1W81PWhHR1uTIkCJ5qzg7OnP?=
 =?us-ascii?Q?LIfhXYy7YOblVAHH35Kj9MkDlBFmuqcH8Rga58GNynj4WtkSAYaTtkycpTas?=
 =?us-ascii?Q?lbU9kMaMBlyTPUZ/oB2rWPNv74ByOxOtbUuT2DP0ZIRLRgYgth4vKIE5dinD?=
 =?us-ascii?Q?IsEAp5hMzs4evCeJDcetLKG8fUNfH8Ve1I/vLYkPrxG4hFDfbXnjOzacvzi+?=
 =?us-ascii?Q?TLkjTtRB+mNItcv4c4Rdus2c9P98IiqQh/aA1gwfUs6Mr4/OUrR58zr0Za4r?=
 =?us-ascii?Q?mEe0VYPG8IA/IxchKnsfKUo+OAes7TZ4Eq8bRkF3F5wZo2cVXfvnNrt2Kuz7?=
 =?us-ascii?Q?6Ibvcny9aSyaqjagJUUeInmhlcWmdhOhMPCi2uQ+kkTgw5doBQ9dZA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dEvHVkndoCQwY038u2UNCG0F1dyYDVCTwz9I9FpXei8GDFRTLZnHVla2v0QC?=
 =?us-ascii?Q?oYIgONFjT1AQMvU5Hbh84So1zSMPmXHh7uVfC6I4KffZZCLDtkOz9HAMkv9B?=
 =?us-ascii?Q?kSuhVPpRNHQlc3q0KGuAxXsNFrj6XimmywY52L7ncxbggjevLeIF9WvxwyAe?=
 =?us-ascii?Q?Ac75AkIDcygW+FyiTFM3kKfBhgcI+aUn7ugcI4c4API+KUAD8GUjqEG1uG8I?=
 =?us-ascii?Q?GJW+gZYvWIpTW5Vej/x9sYiKoRZf7Jmcxpi3Iv5b/wMFJfRtfx1cVh6Ci1Lb?=
 =?us-ascii?Q?bMlvuQJPuVXVWFRB/YZqybfWxKzaa0hy0jwfDLt11nA2TdjjxGqrt21z5pdI?=
 =?us-ascii?Q?wHt0kfEmVkKZbvAvpfvGjt/0WNnhVY3v/OPH/WocyPnJNfOuU83hnOHmUqrh?=
 =?us-ascii?Q?bArVAW41LNr2Rz7q5DtHVS8Z8K1hpXw64THyVXqe9ql6d7hIDtQNO9vKlHNv?=
 =?us-ascii?Q?6A7jhJrkxQn2EcZ5iaS76M4D8oSZxq6Jn8jRUpEBLqiUoNoXyS9IX4hg79cR?=
 =?us-ascii?Q?Z9b3wo9rNETMAQMgCfTHjc7eHlxQJiw7VxOp15oPvI6safwdQxGYVKfMuvW+?=
 =?us-ascii?Q?/h8M3K5tCinbOH+ggGN8Z0Qbno53H0DfChgU23n6jE086mhrpop8FQP1Yo8N?=
 =?us-ascii?Q?9tRxB5tY6qA4p2SYOAZ8qhQv/HULT3hPqKKSl4CKHx73P0kUTdrbEobnMT4K?=
 =?us-ascii?Q?E3tw6KEP2T3Rk0fyzZBfGfNNqyNGZQBseB3gt5UUk2tFhLR9oIxbxWyR+SKp?=
 =?us-ascii?Q?DJ0EEXsgnGJO3mQFntVydg/vqYg4IrQi2QgA1Lr16QPAM3HIYn5s4YOfWWcf?=
 =?us-ascii?Q?AVfQ1hRzX8Ht5ZYF6pki0FBMpwjBOt1nfSKpJ6OuHgOiWPsslgZoOYtTIguv?=
 =?us-ascii?Q?BJilxMeru+RmeDgFYq0xjH3vzREvyF1bGX0AOlEcXHMvfQNwsWtvyHivxBe5?=
 =?us-ascii?Q?1HEv3KMmvCBzEW/HaTyvQqF6bharZkYN5M7I+2qkFNk5Zv5M6/HPY8UcXreT?=
 =?us-ascii?Q?ONQZ6yCpGSVAtNcJ1WICFBtYXhgYN1ugDXrY8R4Ah78t+tKorYw1hXNwEUdI?=
 =?us-ascii?Q?E60GLJjzF0YB0+P8s1GbUTP0oBYAfH9jHJJnKLe+iIbuV3HnkD5ZPw5m5+on?=
 =?us-ascii?Q?BmJmOBM6/GVFQDYyWB4FBR0XwenaZpT7F70s8c0H7YBKkVB92D/7iQb7v9rD?=
 =?us-ascii?Q?FKZyaAcFvKHwmPcxPmcG8tEptF3Qo+U+4tkLM8Zhm1lxNRjgw3cX++EYEafC?=
 =?us-ascii?Q?lAWgu2yAAZlVWs7VkuCyfbPSjcqZyW+G4pyPKvDdW3iiUDli1/WzqNWeD37P?=
 =?us-ascii?Q?tJMDq0K2i6CVnM6LtVi7MsifcDDsulT4DnGZd4qpKt/XGiLg18Djp1SKysLL?=
 =?us-ascii?Q?w5c6/4uHsx3OXjRYTSD973ful1/06ZNtzAZk8HITrfMMi5bt9rrXqCpXftl4?=
 =?us-ascii?Q?EnM97MJzKAvsozyD4i1HVz8CZoqGB44JrVUzG+zegVkXh5HETsjeNIdWlbse?=
 =?us-ascii?Q?rCS4GXNu8Xd8MsNV0KwiTH/abr/0Yzo9Ww2JUPA9uxsHpmnSn1i58LhaxsWW?=
 =?us-ascii?Q?WWh+XeKPGvL13s65ZK0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3db5489-bc50-474d-65a6-08ddd0881177
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 23:14:58.5751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vMUVGVMFlsfz8sBdr6w7WJM6eEtI1W2yaaztsNNDfZgMlyGRDlFxbxv7pQ6vhh26jE5ELbwI/0OeceAGamJQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7509

On Thu, Jul 31, 2025 at 10:31:25AM +0300, Laurentiu Palcu wrote:
> Hi Frank,
>
> On Wed, Jul 30, 2025 at 12:23:46PM -0400, Frank Li wrote:
> > On Wed, Jul 30, 2025 at 03:59:31PM +0300, Laurentiu Palcu wrote:
> > > If runtime PM is used for the clock providers and they're part of a
> > > power domain, then the power domain supply will be cut off when runtime
> > > suspended. That means all BLK CTL registers belonging to that power
> > > domain will be reset. Save the registers, then, before entering suspend
> > > and restore them in resume.
> >
> > Save the registers before entering suspend, then restore them in resume.
> >
> > >
> > > Also, fix the suspend/resume routines and make sure we disable/enable
> > > the clock correctly.
> >
> > Check runtime pm status in suspend/resume routines to make sure
> > disable/enable clock correctly.
>
> I think the current commit message is clear enough already and follows
> the guidelines. Obviously, someone else could rephrase it differently
> but I'm pretty happy with it in its current state. TBH, your suggested
> changes neither add new information nor correct any grammar or spelling
> mistakes, so I don't see a strong point in changing the commit message.

"fix the suspend/resume routines" have not carry much informaiton. Need
deescript as "do (what) in (where) to fix (what's problem).

Without check patch, No one understand what's means of

"fix the suspend/resume routines and make sure we disable/enable
the clock correctly."

Frank

>
> Thanks,
> Laurentiu
>
> >
> > >
> > > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> > > ---
> > >  drivers/clk/imx/clk-imx95-blk-ctl.c | 33 ++++++++++++++++++-----------
> > >  1 file changed, 21 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/clk/imx/clk-imx95-blk-ctl.c b/drivers/clk/imx/clk-imx95-blk-ctl.c
> > > index c72debaf3a60b..56bed44719954 100644
> > > --- a/drivers/clk/imx/clk-imx95-blk-ctl.c
> > > +++ b/drivers/clk/imx/clk-imx95-blk-ctl.c
> > > @@ -453,15 +453,24 @@ static int imx95_bc_runtime_suspend(struct device *dev)
> > >  {
> > >  	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
> > >
> > > +	bc->clk_reg_restore = readl(bc->base + bc->pdata->clk_reg_offset);
> > >  	clk_disable_unprepare(bc->clk_apb);
> > > +
> > >  	return 0;
> > >  }
> > >
> > >  static int imx95_bc_runtime_resume(struct device *dev)
> > >  {
> > >  	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
> > > +	int ret;
> > >
> > > -	return clk_prepare_enable(bc->clk_apb);
> > > +	ret = clk_prepare_enable(bc->clk_apb);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	writel(bc->clk_reg_restore, bc->base + bc->pdata->clk_reg_offset);
> > > +
> > > +	return 0;
> > >  }
> > >  #endif
> > >
> > > @@ -469,17 +478,12 @@ static int imx95_bc_runtime_resume(struct device *dev)
> > >  static int imx95_bc_suspend(struct device *dev)
> > >  {
> > >  	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
> > > -	int ret;
> > >
> > > -	if (bc->pdata->rpm_enabled) {
> > > -		ret = pm_runtime_get_sync(bc->dev);
> > > -		if (ret < 0) {
> > > -			pm_runtime_put_noidle(bc->dev);
> > > -			return ret;
> > > -		}
> > > -	}
> > > +	if (pm_runtime_suspended(dev))
> > > +		return 0;
> > >
> > >  	bc->clk_reg_restore = readl(bc->base + bc->pdata->clk_reg_offset);
> > > +	clk_disable_unprepare(bc->clk_apb);
> > >
> > >  	return 0;
> > >  }
> > > @@ -487,11 +491,16 @@ static int imx95_bc_suspend(struct device *dev)
> > >  static int imx95_bc_resume(struct device *dev)
> > >  {
> > >  	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
> > > +	int ret;
> > >
> > > -	writel(bc->clk_reg_restore, bc->base + bc->pdata->clk_reg_offset);
> > > +	if (pm_runtime_suspended(dev))
> > > +		return 0;
> > >
> > > -	if (bc->pdata->rpm_enabled)
> > > -		pm_runtime_put(bc->dev);
> > > +	ret = clk_prepare_enable(bc->clk_apb);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	writel(bc->clk_reg_restore, bc->base + bc->pdata->clk_reg_offset);
> > >
> > >  	return 0;
> > >  }
> > > --
> > > 2.46.1
> > >

