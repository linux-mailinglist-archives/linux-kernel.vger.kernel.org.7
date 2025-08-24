Return-Path: <linux-kernel+bounces-783810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF83B332DB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 23:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2858F484BE5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 21:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D821227EB9;
	Sun, 24 Aug 2025 21:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b="c+FEzT2A"
Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazon11022089.outbound.protection.outlook.com [40.107.149.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFDF1A4E70
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 21:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756070985; cv=fail; b=Xnr0yI4h1dQJ2+hJw8kxJ7SVypvDM1NcDC499DvY+oHZi4EQkjIeelf065gt3dk/EfMDa92twoHznPw/5X4JshXQlxjgXIm99gaHDBZ+k/P8cGtWR+l0roJRwc9pyjSnXi8ey8K60JkYnOXwnDGkVvCTbP5sODofm0W8hLzA1WM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756070985; c=relaxed/simple;
	bh=gPZIiLttGLgRLDH0PEaLIUbzRpC8skGVHw2ilA3poP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gPdSKdBbE5dOEW1Qwq9koN3jj6EaBZqKxxDlhivp/aV7LFdZAdn0tVaUsKtGnCBHhGmsVdwC+amPtPHRvVXtWZJ6guN22FRdJvTvKtxsHPVMObfFTpLOTnp7D3eiErcLv58rd/9vYI6gAIYa9JXJAuFgY32lLUT+2Qy6lXBRDtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de; spf=pass smtp.mailfrom=eckelmann.de; dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b=c+FEzT2A; arc=fail smtp.client-ip=40.107.149.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eckelmann.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMvt7KVCDfVFgpOvRt1NzGOHad/r1eWoCl6hNsoPFHIdyOAAuXBiZmXEvQOBanTvrFLBJVmUWuqII9CwtVelRe5BqAKQah8giyDn6Fqlx1Cufv+S6UVJycji6HiCYqwdWeitFqFcWamKA0ZEEIDjYtseWwRjZHXFJaJCxbmVKGMidsq61DACQSUPN0c9HOoe60P8Vvf9HlYy1WFav3Vh59K6iSMXlUuTVPM8EENET5+GXw+PWpjqcG5iS+/bqmoKWUAevGpQITSbKDsBrWmwFxTQ8jGn/mzBQYROqVYzcFDVUf7xNzJNgKyOQa0SgQlg9ks/2sJ+GKkOcNRMBBBbhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlGRGo0ExVuNqOITyej1sEvcjBiYuOj201Tglplu0Gg=;
 b=l1bVB+edoji7YbzuHjLnNKoANPuqy+3OOCxjL0GHT0Iq9zt4/QhlqBbJ4Tsn+Gndn8Tg9T+PiuGsehVfr8+2p3WBZnVxGonYVCHmoG7yqg7KEkpT9Ss15HPvQ+xjFPBk9vlfrmKwH7Flg68F21rQKjXcp2tlYCT+bzNJeDBPGYoatK8PtPOnUJmsZVvfNEb0DTIafwRzmM9pYUBuYucXfq7qIbKu4Jb5iUAGcVyj4hPM+DZWpPRlWPDUWNa7yQfJ8VEa0nDBYCwUx8gFvS4BjanAfnNfETvY9q/DyGDuvnRPiTnwLQXA9HYFis7wOHAPIdGc/aU1jPBmG1kSvofccw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eckelmann.de; dmarc=pass action=none header.from=eckelmann.de;
 dkim=pass header.d=eckelmann.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eckelmann.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlGRGo0ExVuNqOITyej1sEvcjBiYuOj201Tglplu0Gg=;
 b=c+FEzT2AvkWubTUYLK8tu/Ee47Gp32RCP2/inq1/cXsB7HL1ItAp55FhbC90SCbZX7VZfb0WrrC1AFIsR1M6r5i/U0ORbURBYpvPjM92oNMehZQSMqClK9B7oFf50ilQnOsgV6YGFPY4ZjYdmhk9b3/JdPPhUxMAxaD95evqFg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eckelmann.de;
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:da::13)
 by BE1P281MB2385.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:30::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sun, 24 Aug
 2025 21:29:39 +0000
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3927:fe99:bb4:1aa7]) by FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3927:fe99:bb4:1aa7%7]) with mapi id 15.20.9052.019; Sun, 24 Aug 2025
 21:29:39 +0000
Date: Sun, 24 Aug 2025 23:29:36 +0200
From: Thorsten Scherer <T.Scherer@eckelmann.de>
To: Xichao Zhao <zhao.xichao@vivo.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] siox: bus-gpio: Remove the use of dev_err_probe()
Message-ID: <f4awghxl4a7svo2gazwiy2cxt56vp2t3hmo7mk3dbiyurh7224@rxdoa2yruyer>
References: <20250819121749.613584-1-zhao.xichao@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819121749.613584-1-zhao.xichao@vivo.com>
X-ClientProxiedBy: BE1P281CA0416.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:83::20) To FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:da::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR4P281MB3510:EE_|BE1P281MB2385:EE_
X-MS-Office365-Filtering-Correlation-Id: cd234853-dff7-4503-7efd-08dde35554a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vOaWU/1IVv/gUHVnsqTYqolCUxDonAHiscv7pnYB2tfdNJbdiq5uL4e9cZ0X?=
 =?us-ascii?Q?Gv11QzTEl6+ox7eFwfL23yy9Kyurbsoe3h6gZNaepA6FbBixKAAckyw+z8xd?=
 =?us-ascii?Q?pODEIFfY373yZEjdV1EpPrp48PeW60iRjuC61cGHn0UNNnoscedQDU4MqqIL?=
 =?us-ascii?Q?1N9nqXOcmGz5yrTaPJrgL0Mx0qov1H6sxtb3qhiEphmZ1q6hHiLi9iLMlWrT?=
 =?us-ascii?Q?cw0JY6eKuQ0tMJvVTcB0oXFPvtrSco50P9GOBaR/ONgaguCCTlxgy7lsn42Y?=
 =?us-ascii?Q?i0TsVGcG0dkh2ksG7FWOwisqI0nemkfB44cVsAh3pbDpNHuwtL5x9kl2gDaT?=
 =?us-ascii?Q?P66BTzTDvA2UQ6gUUcM1NfY1SisNXtJCBjakTVdvRRPALg+NqYAtRoGEIuZR?=
 =?us-ascii?Q?UIamy04wPrM0NAWBhFEDs3GzEtYoWayDvJ6f6H50ziCHWxmKq6YwOVAIlvTq?=
 =?us-ascii?Q?Fuz/9UYE91N2jPSUMm+O++gBVhjOLYKvdvw6UoUwIfsYnmidXXUgJIgbdW6Z?=
 =?us-ascii?Q?ta8NC5X/GlSJwr2Ehulgv6ZPX+k5pf5Ha2BlR2HjYHh+lv5GV958M8b6v5aH?=
 =?us-ascii?Q?gYKkfo6NLbCMZa7uLuJXZG5utf6MRMn3kGq/lwXY68c130pTPuetn6/QQ5o9?=
 =?us-ascii?Q?L2Q1EsvwjiIAbRk91p1St900j0epIWLN5QiwRx7jMb7LZ7qOq6aZBKPNbyMo?=
 =?us-ascii?Q?CNBs60qlo3Bv8T8Tixe1STWJU8X3HzZYcM91zT9oO7TmIOt24nbMqAl3P2LT?=
 =?us-ascii?Q?ktyPRESagRFcdvBSn9RXst4d2P2+zlTftqR7EA7pVDqn04jrvXbcH0HHCW9c?=
 =?us-ascii?Q?bvr9p8HBNNFkn9kQc8Qw7942jx1E5zU5eNfRn1Ytdrt1o4IzdlgXTPGN9MgQ?=
 =?us-ascii?Q?uoFVoUUbLtD/gxtj+EG0puwyW95ODM8KA8yV0bVt24pgAarDUy76RPDllhwd?=
 =?us-ascii?Q?pM3JB1pDXaiTSFoLn+pXC0dRnLWUKEMmGrlXyQ3T5UUQu3TSIMmp2Rhb4+jL?=
 =?us-ascii?Q?I5H1dOpjUwmI8EC4IdyvT17eDzb3ldWi1BNQKB8vR7afIRjcZKTYCo1yec+V?=
 =?us-ascii?Q?bLbOnbYdxhLqSkxSu1M1yvfjl1ptG4z7qKy4jqlAhuCO0EZ1A8L/ovyERttv?=
 =?us-ascii?Q?eMEfKeQk+P8AUlZhpnHJCzz9gFU6IsiB1SRMStgMXsE9zq64KxvNP1/1627G?=
 =?us-ascii?Q?Fr0wHWaRJl2Txf20tAOsB7/01GhAeN773X3Sa95Vgq0GuOTTy4SoiljfmsvM?=
 =?us-ascii?Q?33mjigzKTk2Q65LAMmiPHsbvzc85fCnwXv29bkQe/x3z+kHmR56DVyJH0+Di?=
 =?us-ascii?Q?hOoR4B4ECb8MLwkmCNo0sOKZUYrkrJMrCQWWb8y/s8/O9t0zCQXOEoYHV2Pv?=
 =?us-ascii?Q?PjAA4gsO5EmGTJS45xi8Z0pVwXp+19aNf0WVmidcFhoAy+QY8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1traqXuir284FMqfrQY99MqaI/SUA2TVzRDrLUsjkrONuhI8KPlC4UJ5awqL?=
 =?us-ascii?Q?SebzB3LWEINSg3hz/k6NzVr30AWjpH3mNy0a4ptdcPYfcIYbKsAGbQUYA39D?=
 =?us-ascii?Q?YYuKQSbQoaSm7LhJh0tpRGyvfQHZ5rQrmpGGT6q0zQkp3lxTgYkRas3FTFIs?=
 =?us-ascii?Q?Ud5afTEqiANXXz+gVgg4Bcw+2tTD771ATLGDpwpymG4aT9u677erYt7ZKywz?=
 =?us-ascii?Q?okPd6Q4LZFuiXfMqh2oN/UYsIq4h0nxrrpTd3ew3IKVHxQmwjjebOw1+NGHg?=
 =?us-ascii?Q?boUMP8CL474C+lEDMH6AnBx1MpkWUr1AGMa4k33RJMVXaaI4z6SCnabiTYg5?=
 =?us-ascii?Q?L12K5UMk//V42+2I+oqvkyT69qauRMg2rDAoXhPSyGTrFDdFb6rjFg4eh+6n?=
 =?us-ascii?Q?9gjiS3i4BdadRwThcUiDSg9bQvdI19SDLtyrj+oKvKom6+fttJf+XhfiAy/+?=
 =?us-ascii?Q?bGY++Sk9r2CuLbsQSrGmkav9DWln84m5oaFHGgWULFnOESB5EwuypP0uHrRw?=
 =?us-ascii?Q?EwamOMLLQ22SkGksJNF+Qp1moCtybt6PLOULje1WLLYQWkkKGgXC61CNG1CE?=
 =?us-ascii?Q?rcW/2uDcVy+KfnrLQZkILQGRgtF3dXOln6OX4WNY3wEOks8K2yyxjzhip1rk?=
 =?us-ascii?Q?q2CYP81dvat2u8tRCsiCWcPtS3YZY9OOgw/HUPuOytKeam9c+nRr5JXmAGTf?=
 =?us-ascii?Q?Uwn8rR2F5fqbgVsl0nBx7OsKJh/bHBU72mr/i1Wat4Tj3ExjFLAiHNV7CZFo?=
 =?us-ascii?Q?qUSboqm+aImN2XWRgDjWpB162J8vgf2fImD9qwTZhFoqnMdhmOT0OQhmC9CV?=
 =?us-ascii?Q?e88D/zaYU5HWjSrh2jos3IZ2qWntWJSzh5tmbWEzzGQyXm3u9lFGL6X1zSt9?=
 =?us-ascii?Q?qihazp5s2E2/8q/Cu5gnvXk6tk3uAqd8zt5uAIRwRvxQr29GGyzT8ervickJ?=
 =?us-ascii?Q?yfjfMu6y9SrqA1qCqfEpr7onxChji7TZ7WYWIrX4/pbhHqTQjPImOm7IMxyj?=
 =?us-ascii?Q?GeepU/uMQy6jTTHxL6zr+OEELQ+dgVvmRlcDpNQSqGSzbU/fqF6ZvJojgqTx?=
 =?us-ascii?Q?/BZQT+Uta5PlybHo91qMFI0x1rTtQsXS4/u2ldRChcU40WaK/XHHqLUonfWg?=
 =?us-ascii?Q?3Wnw0ivGULBa7+8Mexyhs438tYy56z0Vi1cLnEhvC+EPSv3tQxWl5MVRXRTf?=
 =?us-ascii?Q?G58l1j+2ZpjOje6spH+fa9K1wVw1NcNFxqYq/KXncsYRblQipaRzITFh6QH+?=
 =?us-ascii?Q?IvcBJkVBQQpf0LTUWZIKO54nDfOKmDVDPSgfhT7NuiiyLR9eLPsCewv3u7Kd?=
 =?us-ascii?Q?UNMgp01971ohX1cgWkDqbFXQGkYFNSxNuM4qi9ygijzSzxLItbRKxeNEYEtK?=
 =?us-ascii?Q?bHZBkAQz/O+vXtP1jupKsxvR33B9ZCIx5KPxNG+zwkHqOS3iCt6yD6yRuv77?=
 =?us-ascii?Q?muuT22VuKrYCDEAaQgZRy/6MTGYshfQhZsY/iFWGTnqkT1jX3lQp4Tj63rIa?=
 =?us-ascii?Q?SJIS5akJtT3cQ4TGP4pwbRIsOMqrgGyw028LmxfHyGuIFZ6EWUFFzloXcVZ3?=
 =?us-ascii?Q?yOlE1KS+XmN750xunLUx3SBYgKLlFEC5gLPVnlsI?=
X-OriginatorOrg: eckelmann.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cd234853-dff7-4503-7efd-08dde35554a5
X-MS-Exchange-CrossTenant-AuthSource: FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 21:29:39.0866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 62e24f58-823c-4d73-8ff2-db0a5f20156c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8kC5jfa52NL15sc/PSIAM6n0JheboQcLe4ou/MhGXJ042OdW0h7iGP8GDU23FxFWuc7uGzCLh9KkrrIz/morg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2385

Hello Xichao, Hello Greg,

On Tue, Aug 19, 2025 at 08:17:49PM +0800, Xichao Zhao wrote:
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> Therefore, remove the useless call to dev_err_probe(), and just
> return the value instead.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

Acked-by: Thorsten Scherer <t.scherer@eckelmann.de>

@gregkh: Could you please take this patch into your tree?

Xichao, thank you for your contribution and Greg, thank you for taking
care.

Best regards
Thorsten

> ---
>  drivers/siox/siox-bus-gpio.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/siox/siox-bus-gpio.c b/drivers/siox/siox-bus-gpio.c
> index d6f936464063..413d5f92311c 100644
> --- a/drivers/siox/siox-bus-gpio.c
> +++ b/drivers/siox/siox-bus-gpio.c
> @@ -93,8 +93,7 @@ static int siox_gpio_probe(struct platform_device *pdev)
>  
>  	smaster = devm_siox_master_alloc(dev, sizeof(*ddata));
>  	if (!smaster)
> -		return dev_err_probe(dev, -ENOMEM,
> -				     "failed to allocate siox master\n");
> +		return -ENOMEM;
>  
>  	platform_set_drvdata(pdev, smaster);
>  	ddata = siox_master_get_devdata(smaster);
> -- 
> 2.34.1
> 

