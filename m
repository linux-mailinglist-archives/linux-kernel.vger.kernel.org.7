Return-Path: <linux-kernel+bounces-731981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 534FBB06076
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFE054A5756
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8274F2E4995;
	Tue, 15 Jul 2025 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ncCAwAoq"
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012026.outbound.protection.outlook.com [52.101.71.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F73C2E3382
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587868; cv=fail; b=OyKjIGn4QP2s4HTyjgv/V7TwwfR4zxnTDN28h38ToLXSuTGbloJXf0A/9Q/1IqDUqB5yizJJM4e1BePJ67GdEmESaNIt5XCPAxIt//oM1Uxi06EJ9o43lqX1hOP8i/JrGRxMkC7W4pd4elny7c5RgNS8KHMPScmV4qtrEafe6Ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587868; c=relaxed/simple;
	bh=gHb8yzREW3Mwcku8X7Lm6+MBIJw0ykmsxMiLSbf82Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tQQlpNaO2Ghy85fg6drLLaovo1CIAEQbUzL/xmK/YYcHaXpXb5pRX1i/qZaLNVm2shS905H725tjmorWhQGl4M5VGCEUn733lpTEr5bPAK1cQQDmrXW5xkkhn4iaQ3pg6aTddKmaHfuqCTpIEOvsXruu66FI4Gp0CyVLK3pRd7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ncCAwAoq; arc=fail smtp.client-ip=52.101.71.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lvGy9Bk+Q46LQDOf6LEwt9RcGvwZLNlJ+gEyVtHkc0O9komwTw70gMd23cfxQax/btBZa3A7NgWdAyOyUxxNO0o2qAerX3lhnkjHt0H2+tfl8dOdo+yPOLEim5iSbK2XHlefLI+DKz0UBFLmh3moz5NKySe0DHg2bu71g+IBUxIafqIdeWbl2W9Pw+APRae7CTjGmiG1YvC/OCby/PCtSG4BPV2Aug4zJdHWAPqIC5oCnjee05AFsXaeWEgc/ruqikyeM2w4m3WPccKR4VlXb0+3Zzl+RBFzJ929gYlHMZNBHRXWn3Omc2oc6OoKYD6wQHXrPSUL71wjvtELfyMKzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oe3bPtAucnsWZX6Tlw6kNPnkw/d63PSKeOVfrZYNVGA=;
 b=zTpjJptJDaYPTnX4LznvUXXGFAKc9cAlupKkGzfqA87k8o085xmfl6D4sSleqEaSdcwbbtueBsTrj639SjJ7MBw8ZZMIEt3OX6BPtxmXRD4ByJYNj5tUYsRMG59eJh+O903D/XZf/eiZZt4GQ10H3AT5uvUY1Skdbtsn5GEWGc6N2fI/RtpZ9ILNsjIg+aoh8ijrRYeUY/rqh+iKjqNyMcI0f2xhI4gBepQmJHXwBoNSod+pgXnr6WDQp0DaEoT6s08CbGFg9LurnflIrEH/TbRK+mF2+OZ//brHXCAIyZtXK/NeX+EAP1+9ZEYz7HM2Ora493GscWWY32SNvkBiDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oe3bPtAucnsWZX6Tlw6kNPnkw/d63PSKeOVfrZYNVGA=;
 b=ncCAwAoq94MNkSncZd6sAFRtO2bysN4Lk3UEDFy5sKnkTokb944LA33wU00Flz8PHug6FhnQNi+HMoRTNnUcqdTdPpWiL/ArLRy4R2o16zl1G7vOe9+GQB++CwMgdhW8ArUgkt08Jg63klMYtgocLF6TUXD5dRtkUJaE7lowNvLYtFsoNzAQIZNN1z66T+QleoFFjtLat4YZNSBMBodqHFVxOz/ts1AnZwV1GJpYo4V3FKUHlG9JH5kLMqfNq7rtvaydOYmri3YhyxCWfhC5R6vXWD+hL2t6S83nna9HmnHRCChcMwxV+0yFNXrI5N6jTtCd57kRAoBJsBbvltzzwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8813.eurprd04.prod.outlook.com (2603:10a6:102:20c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 13:57:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 13:57:42 +0000
Date: Tue, 15 Jul 2025 09:57:36 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux i3c <linux-i3c@lists.infradead.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2] i3c: Fix i3c_device_do_priv_xfers() kernel-doc
 indentation
Message-ID: <aHZeUNfoU89Il985@lizhi-Precision-Tower-5810>
References: <20250702040424.18577-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702040424.18577-1-bagasdotme@gmail.com>
X-ClientProxiedBy: AS4P189CA0030.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8813:EE_
X-MS-Office365-Filtering-Correlation-Id: e7fd1c09-48c1-4d29-0202-08ddc3a7919a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+IlbqPNU3fHqIENQx4ycfV2iqEAICLF+igFdRoA9XlHwtqMbbiNB//vv2FAH?=
 =?us-ascii?Q?FjyEGAy6xrqSBqv6Klp6kzjLUZRhh1gRWdhpp/tCIyfgV/t1bZw1uxse/6lk?=
 =?us-ascii?Q?Pjym4vmSe9kA3ma0lnTVscx5O2+PEyv2fV2I3GXV9sO/D6KPVsTLJo0RJnXD?=
 =?us-ascii?Q?lDa0/BhlfyeBOJyol//V/8Ig4r9CVxVnL0VjeBuDzpQKpbctANCKOlWAhEUi?=
 =?us-ascii?Q?Nh0/9gxuRQ1LFhzL7w2jHEuEG6cQ2VJS5ti1x4f5I2SDQStqG09dkXBDICoL?=
 =?us-ascii?Q?+DWbpzGgQhVHwBVSQgzg4oSOrdhBRVZjpYr2DQcTGA6rmCouRHvQV2OCDoN7?=
 =?us-ascii?Q?GETMnNBXh4y61lnh4rVdWHD9pHfobwjYdI9oiowClX/gRPDtuHkoRAk1gMGS?=
 =?us-ascii?Q?e3wzBhnhffV0RD515boOxdckCmrMpdwqXtrh0xHNrwvYyjj8DQDdnNtvnNh+?=
 =?us-ascii?Q?/ahmEM+tYYvDvhewey8Gr1GtIy4twCKa2rBASYac//Gc2OUG1OkeIj0PCY8B?=
 =?us-ascii?Q?ittjsjWYZeK0h+Up2O0hA80AbyKvyo2BRhnVByJJpUbCb2MHNCKnMOYm95SP?=
 =?us-ascii?Q?R8ZsHymTRdxPzdUrNs9g+JZYyAcISeQ/3Sr+p12ATGPVlj1MFGlpOksd0g+Z?=
 =?us-ascii?Q?FhJ2zoUImoSSgdaV4H9c2SryyBtui1TJpHAfi6arzqnH7J0kXg3bjFJJqNWE?=
 =?us-ascii?Q?p2l82xV89vhxGho8sdFkr+VLFIkLmL1d4+g6Ap1E0FI3lPRdNomLy3FMUxYb?=
 =?us-ascii?Q?rks1B6RBDojiwZ74yL3qYzgXL8vmuzedcj30y8MLXZZoePUMiWVv4ImojpvM?=
 =?us-ascii?Q?3CQMPhSpIzdLVwkOeXpveA6M8Jev5pLXRVUSLaoosFPkPwSOgElxCpK1kNC5?=
 =?us-ascii?Q?pzGPpuMlUFcZjwzv/KbS8ZMkwdrcyFSQSPgicVlt6zMs50etEfoOW6UiuTXf?=
 =?us-ascii?Q?UtKAbBk21v1wyzuw+TAJchZYi1p3yG27KAyfHixrsggoX2OO15P5a0w97HXa?=
 =?us-ascii?Q?xtV34kAQolGbY//t/JAl+bxnQwgOPH7iBwvcT3iKAQdzchdp1ajl0qgKzsyt?=
 =?us-ascii?Q?tNE7s3e2QZ8dc75r+3uxw/K+GQNCNgF/uaRe4azKCXs5xC7vDvSn5TsvOtzs?=
 =?us-ascii?Q?MzQMd+U67nIjXyUbqLdcK+HvfdB/H16GFIrh4eZRoOyi9m+/uLcVuGje/L4m?=
 =?us-ascii?Q?ivOUG7ol9n3HLast1ktOfRTtCh69rFnRZErEyU7Y2sfFIQ2jfsBGjHNYcMKm?=
 =?us-ascii?Q?/FGuOT1IkpdINEqZK+uKQOTTtIZpAYtT2vJk3jMSoUA7F2XjcjMQ6Wi0+nWi?=
 =?us-ascii?Q?C6WUm6l9uSZi1ixRPSoIGOBBRppwIKJvG1fpmMqqsN4QMgPQDZfZ+uQd+GfZ?=
 =?us-ascii?Q?yV3kf+x5oeScwtdAbqP9AEnsJxeo75b82SwkVcmi32S1UPw/eqvBZ0wpM5no?=
 =?us-ascii?Q?/g/4q5JDm0+qTL7jVHHHHsVh4rM9y15LTQwM4mU9v7ROR4KxHk6l8ZeRY+zW?=
 =?us-ascii?Q?Lr7jKD7iPiGu9H8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kc9AsiDK8Bj1e3RTCugHaC4KbVgi02QBLWM7c/PIbJlv6AmI2I0qr8QDGXxV?=
 =?us-ascii?Q?ZmhU5aWAEcqkl9rtDkfJBdp3uy+TXgwJStEfCVmtW4KtG1fVkSsrwGrj7epc?=
 =?us-ascii?Q?g2LHM14IHImB9mkujiWczqZ9RMxQ8uuXTwu9Uii2NDJmvQx4xCWwbHlMDuSn?=
 =?us-ascii?Q?jRxG+BeEBjprUNJkIW+EkWvf2a6bMLzCGBcDzRNzMOg0fwptugTon/hTBwcl?=
 =?us-ascii?Q?HtLODzrB9CsOws+JU0zoRTjDxDOn4RNFkKEm/fhWMKRv6F71TZyxb0AYjJEn?=
 =?us-ascii?Q?5Sgf9zwgMOu9jkOy4nFqB94shVkc3FS900wkgkF5cuZV2V0aMdu6seY4MCuP?=
 =?us-ascii?Q?Nlxbt9jtNaWWQ+XgVvVgmun1EmGeoUCqKVuZlWYyidF8PxEIEL0XoqfoyLVK?=
 =?us-ascii?Q?aioI5shQW4+sKxfHMZcLcJq38Flxw9LWOd6SnlYnjaTzHO7f1rd7dixthS0d?=
 =?us-ascii?Q?enWBnq4IelZqztRSu+fTG8ZMPtx1JQpMrxtFefIlzqLCrMdoNNki0OcdboKY?=
 =?us-ascii?Q?Cj31/ER+YFsT22n8mNFRzZWZZ/VOV6+lHnfbhdpEzrztivnDgVAbBQjAmO0Q?=
 =?us-ascii?Q?zBxaWM+vx42VU5BA92AbKg2g66TWvXMFXyqTNkz1s8v3Kl/984Xypa6iA/jy?=
 =?us-ascii?Q?VW8jTsMQqUsQJyUCkslRUWvlwB5FCDej5oF5kc3ivEnHJxRLiuvMNoWn0U8l?=
 =?us-ascii?Q?ICuRhlIR7VO2V0Xfu+TtpCT8Nx8XmAjSEzzTBlrXrm2z1cd1/ouE6yQ5AJh9?=
 =?us-ascii?Q?UISEs1TqQxYOpbjI4QDqWrF7clxxrK2sr04aAJJS21va99Ca9Jktb/hhL0KH?=
 =?us-ascii?Q?vY1wAqJVdh7ZQUqEYUuHshv8PHsrMV1PtRbLzcxVBZ3dcIaf5iQMF3FFb8mv?=
 =?us-ascii?Q?rSp4z/AxxqsTOGSIk+kea0C8T/fck11duh838RR9cV+5x2RelWIIEt9Q5Ewt?=
 =?us-ascii?Q?Mt4wgzc2x5CtFMQ2Rldt2Ak3z5ifOOspnLQfd8Hi87rHpPrD7za5wtR2uGL1?=
 =?us-ascii?Q?BakozC7L1T1F9MrnYST6wYDU9myBRtkse0CSh6EUIqGa+lKbAMpw02mdnPwU?=
 =?us-ascii?Q?ydwts+nBiD/8N4UGLnTKVZSM3usi+tNc6OmMxOx+LpulceY81MIwmBb21dOr?=
 =?us-ascii?Q?JfCrHIpPHGLUlwBwLC7GDakHuVabB2a84NaSqPlYI0dvKB+rsdpwC5aRgwF0?=
 =?us-ascii?Q?zESdq9+dGveF3GX3LS4cyIjopHuo8Zkv/58BWefu3r17CrJGtwkdcjvaEvzU?=
 =?us-ascii?Q?z5sksMd0g6BWADkosCcyOwR8bFOVVb2QbS8waSEh55BBSb6UJq5CoHA6PCY6?=
 =?us-ascii?Q?rhHtzmTArID36M/5TDnkxxXHfqiSdoIGBN9m3Kf+uIKPGHliemMfYiyE4eeb?=
 =?us-ascii?Q?Y8JlY7N9iO757q5GtstA357UF5/LWQe2YijZQ1eKrTIm0ubDY9JDwDdp1a94?=
 =?us-ascii?Q?ZkjbaRMwHPRpImPYMp56hbfvS6qOpPGLQVqpfuUCqLDNCe08md2B3NSejKtq?=
 =?us-ascii?Q?gQqD5ow+DrEDWsvlKEX+1k6YKMXKDv9kzxlVJt8BwY6Jbtx1zH8YeBhs3ifk?=
 =?us-ascii?Q?mCPhYujoYpBTs/Ljrdbk/ptc0g75xBR9jJH3eIYd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7fd1c09-48c1-4d29-0202-08ddc3a7919a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:57:42.8549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxqwcRl965yaHyf9d7Zje/vtI+F9ZK2CMda9+lmWAw30IEudgtjBpGLO+EgRecmq3erFEVYt8cxr4S45zXKclw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8813

On Wed, Jul 02, 2025 at 11:04:24AM +0700, Bagas Sanjaya wrote:
> Sphinx reports indentation warning on i3c_device_do_priv_xfers() return
> value list:
>
> Documentation/driver-api/i3c/device-driver-api:9: ./drivers/i3c/device.c:31: ERROR: Unexpected indentation. [docutils]
>
> Format the list as bullet list to fix the warning.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes since v1 [1]:
>
>   * Follow kernel-doc style on return list
>   * Patch subject massage (Frank)
>   * Drop Fixes: tag (Frank)
>
> [1]: https://lore.kernel.org/r/20250626042201.44594-1-bagasdotme@gmail.com/
>
>  drivers/i3c/device.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
> index e80e4875691467..2396545763ff85 100644
> --- a/drivers/i3c/device.c
> +++ b/drivers/i3c/device.c
> @@ -26,11 +26,12 @@
>   *
>   * This function can sleep and thus cannot be called in atomic context.
>   *
> - * Return: 0 in case of success, a negative error core otherwise.
> - *	   -EAGAIN: controller lost address arbitration. Target
> - *		    (IBI, HJ or controller role request) win the bus. Client
> - *		    driver needs to resend the 'xfers' some time later.
> - *		    See I3C spec ver 1.1.1 09-Jun-2021. Section: 5.1.2.2.3.
> + * Return:
> + * * 0 in case of success, a negative error core otherwise.
> + * * -EAGAIN: controller lost address arbitration. Target (IBI, HJ or
> + *   controller role request) win the bus. Client driver needs to resend the
> + *   'xfers' some time later. See I3C spec ver 1.1.1 09-Jun-2021. Section:
> + *   5.1.2.2.3.
>   */
>  int i3c_device_do_priv_xfers(struct i3c_device *dev,
>  			     struct i3c_priv_xfer *xfers,
> --
> An old man doll... just what I always wanted! - Clara
>

