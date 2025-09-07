Return-Path: <linux-kernel+bounces-804657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0250BB47B27
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 14:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF46189FCDF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 12:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CC026738C;
	Sun,  7 Sep 2025 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mKRl2KTG"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013022.outbound.protection.outlook.com [40.107.159.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4631C28E;
	Sun,  7 Sep 2025 12:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757246450; cv=fail; b=umUAuv2+yKh9hJm3geLaxHNsMhYe0nyf0k/KjHTBU+sWXgrIsR1CVoOW1NQuoDCwmskVJF37LVyxovYP53SKmMg4kwvIMdBGvyuIvMKp+HqbR7tiE7H1ZmsQm7kDrgrqyYFY+PQW/F2ejAeC3JCmRg0MEH3CJnFYFdajnAiq1Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757246450; c=relaxed/simple;
	bh=Q05s2laEvtoAspjfV+SEvNMsR7NBmUx699KvWm35UwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uYTZ/fIKuFSI/Jl/iZwh2P81Z+IuZHP1vWv7hJN6HxisfYTLRS9X4d3lYD/ryE71DcBJ8zShaQVLcrjLThULNK9yKsH5wSigaDg+nBMGxF80jWrnnTfxlio+9tyZkms65fQbUY9ZOlWVh/PgpHy2Apz6/+9C8m1y2eJ3DT7WRlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mKRl2KTG; arc=fail smtp.client-ip=40.107.159.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zq2AukMR0C/KHDPsMlkJNi0PajA5u+HrK53VKlZZPKgzsRMiMYf3OU9WqBTqCjAVWDTm2tKHHyyijiH8DU/kHqAPDDVewjk18f/JMU72MIyXvqIGU9QPyfBYtvksI68/wAruknLOfCbnWXANFj5mztyK0iZKy7M7Qs5uzhw6IJRAYu6j4BioydzuvsHxF2B3GMx6e5nYfWE57ew4eARU7gdAbFG5y7WuX8Qf5Bpjxmu+w0lU11viK6N4S2uerZBj5HYARF8YGz85KyerhVqSjEzjlWPIaADm4Roel923EqDRM0H0dCJoNRB2ZXEHiPqtR7tJQwtCGQlbBjls7Qzstw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLVgG5NPWkoFExyYtGiCXN8E6DpgL1S2yqAYFLgScMM=;
 b=GtN4R2TzRq1BtYWK3by6ivVE1u6GPiNU78uV/L5yEzPTZlWs++iNlMpDgp8MXeGc5aTj1ABNEbGSkYTqePXJpMyVNf5BxwMfvr22Hixg1TI4Cckc+1neaXpheNQkglHrpPhaiklChTqqq0xRHo9uEM+TO5g7sQQjhN9tHa2CKFhd9kSNOgi0PjCkgo+nAtk2dmU2Er6NBivkVirrQy5HzQfYy7WXSMnr6WaMk0Mr1vTXtAZujx1UPRp5gYHgeIC3P3nQBFj++Er5HTivdJr0wNRvWr6c+yhU/QYdytjvRYKHmXVLd3HwA+N6ntM1u507OojJY7v3UwkGfamJGiPuxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLVgG5NPWkoFExyYtGiCXN8E6DpgL1S2yqAYFLgScMM=;
 b=mKRl2KTGB1ZmbhaPWU/AhV0MzTfarxVcZhdNS0oIaOuUfBSqXAXC5iHyRUsqj/UM1EGci9d0FISftJqQN11yYv7gzWHtkTELAAn8q5CInirPW8vFG76lI4ZGrBhq34oPDQdZ4VNZKfAFlR/mebYCC6452CaoqlPDeubFLom5vFgyu+8oZlZ1XEz3cHdOFSYr+igUsfIaHxbhPftHB3rCj98Wb7Fc8lBsNXS/G0vvztWGDDkevMh6a2n29eQKCWuVYuFiPvC0emxVkb/wPiBbBc54f7MJZmagWY7u7OQJy6fAkfhWl0VS01rGIZtiuYUWKJX3VQ/RjRpAF6Jj37rZvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10714.eurprd04.prod.outlook.com (2603:10a6:800:26d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Sun, 7 Sep
 2025 12:00:42 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.018; Sun, 7 Sep 2025
 12:00:42 +0000
Date: Sun, 7 Sep 2025 21:12:09 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Brian Masney <bmasney@redhat.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] clk: conf: Support assigned-clock-sscs
Message-ID: <20250907131209.GB26925@nxa18884-linux.ap.freescale.net>
References: <20250901-clk-ssc-version1-v2-0-1d0a486dffe6@nxp.com>
 <20250901-clk-ssc-version1-v2-2-1d0a486dffe6@nxp.com>
 <aLeEFzXkPog_dt2B@x1>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLeEFzXkPog_dt2B@x1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR04CA0195.apcprd04.prod.outlook.com
 (2603:1096:4:14::33) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI2PR04MB10714:EE_
X-MS-Office365-Filtering-Correlation-Id: 4994133b-8fac-4eb7-0de4-08ddee062b2a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mgqW+rejPXl1L7p7ydVF55tK8HeZ66ssdhT47q4DekuVjSlL6DIawh9lIhlo?=
 =?us-ascii?Q?gKf6wIPgwiMwNOnC+63mDiGiYQcsM8BE515xZGh/gNRLK9HRc02PmPIAF6Bw?=
 =?us-ascii?Q?lIAkDthkwK6+m1CCbJnstwJAecj89SgZrJmu1CjJNPF+T1FzBjTP6qhvRKYe?=
 =?us-ascii?Q?O/e/uJpcQ1D1hSoNUEubrNNmNVJG3e9olfrrGxn2/beR0tJVJ3hUYf24JbUd?=
 =?us-ascii?Q?djD/cCXdd+BtTc6tuq2wtbAU4i/WHZUIeSYb7waTIU4lf6TE71THIgKVdhs0?=
 =?us-ascii?Q?xBEqSuhbwHWibaVF/mCwDSM0gxt2mXUA+Cw23ghZBzzojUd+ilFlMteN5HuH?=
 =?us-ascii?Q?UMyJ2DhDVmHgWMIVoLr32Sc52K0Nzi6HlD6L8Q3+dYXZgAAun5fMr2ySfwpu?=
 =?us-ascii?Q?qIBo2hfS3/ica9PJMmUkt/7Lw2Acsk9gpnXsYuZ8kS5HA8+dng9o+8Gvn4Ak?=
 =?us-ascii?Q?7qMU3vseV0ZnIOnguDC09i02ZHjn9pNRatL9joPFW7qPBky7Dz7qYlInkmPX?=
 =?us-ascii?Q?Dxb3CILtjyHWRw4gq4ZG/KGyGIQ6zX2SQ2qrzRbcbEA8ALu2hYXSfkuo4dQF?=
 =?us-ascii?Q?rYn7imdbfcbZ6OdYQtVew4ticMhQYMzs5Lf47ayFHnde6w0Ic76+j6+Fy0Dg?=
 =?us-ascii?Q?BcKL9Idrr8aHCZD+8/N2ZKKTuUsmBxYMUvSWaTje4d880YHaTZ8Obu/AW/cp?=
 =?us-ascii?Q?eGH8A8J/62TWTPM/adxHTdhe+UyV0F89mc3wfrnsTVvcmthllmXUAJS7Jsdb?=
 =?us-ascii?Q?QX3FIFGZfxyGK4C87D+00koWUS7d0KANSVNpEtpnh+yRz+BlDAN3HQnPR4BI?=
 =?us-ascii?Q?IvCuhKv9f+PjJHuinHSv9TmyzZv2Pi4JncZ9YzP6n0KZDGI4NprDD1Gv/fh6?=
 =?us-ascii?Q?1TTp7/8uKYqkrtKqiGlmDR5cDh7E0p8Nz7dR5OK8tsvDtZGg+Zjp3+hWdO4q?=
 =?us-ascii?Q?0NG6BhuLF8a30Da6HBm/QGq80h7KFHCkz4bDr0Pga13APmT88pquCASTBUWv?=
 =?us-ascii?Q?aedh+EC1WeeDRTuFD/AyxwvC0TLW8Rf4npwFHPsdsvBaKFco4mE+YhWw9jUR?=
 =?us-ascii?Q?BE2HDXC2yQhPv/HtvuhzCnUc2nJevSl+Q22BHMGBRrU7+O54vPXHM25Th/Gv?=
 =?us-ascii?Q?+tHGhem/Woyr0VvzMATx3Lwq9alkRcyPSvAjmlfpwugvOuyR8cqYd6DUQJTM?=
 =?us-ascii?Q?F2YT8brmeEDyGLg+GMc+7FvKTmxC+5JnLTcs7cXTAWZhgJl/esVqyftbB7uh?=
 =?us-ascii?Q?afSV5xG/6d4SMoQ3XBlgrp6pZYRWKROW2iObTb4Gj6PTyak9yqe1QY1Tetmz?=
 =?us-ascii?Q?sUmmbzP5t9xsdaxQjODeIHYX4MVb0eksZBxQVXmnki7cIiq07AtmC0SCFT0D?=
 =?us-ascii?Q?lc3Wvz+htpbkvZmqysrzjIvAICMJZh1EfD1x8XRHcFEeQ0p+uRdTmvCMWO85?=
 =?us-ascii?Q?8EzaV6ZrKS6jo7AegUQMrNoXFqE3/CoVfDDtt7dvdCFd6CILFU1kFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i6oKp6m3XRLydtWATiWj+Q/jWz0HreKmbYRg0OJlQKfnJ6F7DtMVFbhiawuQ?=
 =?us-ascii?Q?FkimvI++9Q6JVwSvxKHhVid/C4RsTi/QuaRJvAghOZBPhHPd+FUHqdCeUzy/?=
 =?us-ascii?Q?43RTpopUkFTJ8Or/84CZn27KyAyq5zduaR+W4kmL9Z6iM551Yxr5SGZEVKVk?=
 =?us-ascii?Q?ai7/oIlyBwjRK4FiN8+BQ5tFE8MbDev8ou0fHjYLL/eJLQq/RSZPMBphmPrd?=
 =?us-ascii?Q?AAj4Hb7AmzHbVNvjJAy2s5p9IIMT9xL+WV9LF98jLu5HnZDqhze28DLMUcJH?=
 =?us-ascii?Q?EB2n39J4Cg/975wqYoe+ScPxVMGGckBk9f8BSdW5VSQlDTUpjcIplGwJDJsP?=
 =?us-ascii?Q?LzlQGxoxpCNlpOLHIl8YuAFcpiHQ98WIwEHkfvvDOsWZ3b9qiwitYITqK898?=
 =?us-ascii?Q?qFwL3KCykpHcaRIpFAIN4UjkgkuUVvdGi/gU8tV7YjYuFK25veTe9gHRp4Vt?=
 =?us-ascii?Q?Qc8+UngjvGv91VOMfHOBeGHtK8PA9zUc8j6x8LQcgX91d0DJVOKoWS29rMAn?=
 =?us-ascii?Q?NL2Z6P5hGxcd5QfTiHeultC6Rf07lntYVMmg5hFmal57g/TeibaxjDwJzbLq?=
 =?us-ascii?Q?vh+JPJ5NW4IL2hQKJdUxQcYeqJSJI2OwgnrCqnYvNHrUpUgOGO/xPSWwmGu9?=
 =?us-ascii?Q?liUu1wEjx5CuOlyo+0Qkec85G/n+OhZnk2Vk3rEThSWaiSCT1IxNP0gHp4Yq?=
 =?us-ascii?Q?h1rwaSLl3shax4Gj1lTNwLBCSE88Nyv9ueLkqKgVH/RM1RaiUPGJBPsi2GNf?=
 =?us-ascii?Q?PBwNhUe0UBGuaLNPIM/PbeICDYeCahQm31y74AhchFCynIxnUsQ6K9D7Kdyv?=
 =?us-ascii?Q?KVpthTl2ypnt2k1AWlTFdpN8UfFqSwYc6btsHpvy7otC1rSp+T3pxsTe/1tg?=
 =?us-ascii?Q?oqIWWnSDk1BEJ8gdJUrevGNFkv9XVGVXAkh7MPc18a2Ihw0hzGaH9oF7N+Fn?=
 =?us-ascii?Q?Vz7QLJinfqW01m/iuNjxU13dlGEs7er12OwP+amKvl3s9Dxdh3x1UhVXZ6YG?=
 =?us-ascii?Q?6TjUyO8cD1QyNmeCGlfb6GLSSmmQ8mSa1GZRYXfAF4K1Xb9fjq4PQd5V32bq?=
 =?us-ascii?Q?XOdcCPHZas0bzw6C+Nf2hQaR/h383ZXrQ7EpEEpDY0VqMlpjndQmcLB4MN32?=
 =?us-ascii?Q?QiOxPBzTi0XrZXMO7vkq6YrfObvbXvehLasZOQtni9mo1aWgeqzCaccGLAsc?=
 =?us-ascii?Q?aO9loeFT5mc7utqqZhmaO2XhBcbs4zMHYH78qfUC8o5ZCbxFblDPONTlHR0o?=
 =?us-ascii?Q?HXhzIfBkYM8h+jGtnNJ6r+b4SdCsJ7m363kkGTWrydgnfSzfS0JhuD5KCKSz?=
 =?us-ascii?Q?huVmAC6g/+/wEyBpDsXXmJHSul26zoRBenpdOsKdC8m2jzEIZ0WPaxEG4DWG?=
 =?us-ascii?Q?ofCJUgEPptCvXepSHwC7OfTmAMuvFZcc1wxvm7xc6gQj99/5DynCRcdcIcSG?=
 =?us-ascii?Q?4+1BPazNlWKn88xakzkwdEH3nQNkJQBYHBouN5mxb5pkeZL/o7595VgSplPj?=
 =?us-ascii?Q?HK7SZoTq452gqmku/mnGMTjXVw+nB46q2NW4CbvospXN1qJiPlTrfNRQrWfU?=
 =?us-ascii?Q?+vWGNhvY+r5TefNPJ9iXZfKzQqoozBg5tvNHpEzy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4994133b-8fac-4eb7-0de4-08ddee062b2a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2025 12:00:42.0701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Deb9m1b9k2NOdRJ2w/6iWHFkrjby20CB+rmVdLiqL1dEacW6bAw/+B7Gw0foBYoN4tIzCA5TRrnNFVae5V1nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10714

Hi Brian,

On Tue, Sep 02, 2025 at 07:56:07PM -0400, Brian Masney wrote:
>Hi Peng,
>
>On Mon, Sep 01, 2025 at 11:51:46AM +0800, Peng Fan wrote:
>> Parse the Spread Spectrum Configuration(SSC) from device tree and configure
>> them before using the clock.
>> 
>> Each SSC is three u32 elements which means '<modfreq spreaddepth
>> modmethod>', so assigned-clock-sscs is an array of multiple three u32
>> elements.
>> 
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>
>Stephen has also been asking for kunit tests to be added for new
>functionality in the clk core. There's already one kunit test that
>calls of_clk_set_defaults(). I attached a very rough draft of a patch
>showing that it'd be possible to mock this up in a test with what's
>already there. I set a log statement with the configuration from
>device tree:

Appreciate your help on this. I was not aware of kunit tests is required.
I will add one in V3.

>
>test_assigned_rate0: Spread Sprectrum Configuration: modfreq_hz=10000 spread_bp=3 method=1
>
>You can run the kunit tests with:
>
>./tools/testing/kunit/kunit.py run \
>	--kunitconfig drivers/clk/.kunitconfig \
>	--raw_output=all
>
>Additionally, what do you think about making a dt-bindings include file
>for CLK_SSC_CENTER_SPREAD + friends? Right now, the test illustrates
>that we need to hardcode the number from the clk-provider.h file inside
>the DTS.

ok to add a generic dt-bindings file for the the SSC Spread method.
I will add one in V3.

>
>Here's the patch and feel free to make it your own as you see fit.
>

Thanks a lot for sharing this.

Thanks,
Peng

