Return-Path: <linux-kernel+bounces-826481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3E3B8EA39
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 02:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33AFB16E426
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 00:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C050980C02;
	Mon, 22 Sep 2025 00:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sfP07wxg"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010046.outbound.protection.outlook.com [52.101.84.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E031339A4;
	Mon, 22 Sep 2025 00:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758502420; cv=fail; b=DYaq5gslWOaULVmuOcK0g897gkLzsutVCbgjB6J/vAnUykkyu+OCWuBlAHrGJNgNcmFUbPvYIoiq6TXBALOGffE/5lTZxL0TSXM+v4Ksc2Y/xJbi2Z2Zbe8/ErJstwq9ByrGLRDMAxWAXM27OZxYMUxuXcBHwDxnsK9h10e4aJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758502420; c=relaxed/simple;
	bh=Ky4xNeTBkDDvi+dBTKA8g3AyMzitXwB5nCf+8l55wi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hiCdX7UAakr4k9c0IHsFIf70RyoYe+dMVKHKLLmUx854jaLVq1K0ICbfEYANOFBq9Ifkq8gPAjgvxJFLtC9yecja29szxTKvDdX96x/WJo0l4oObPYBjuzj/o0fAhXTIru7woRWZRKae2YNLUKXdOTkbK9RtF3YPYPv3+LP6+4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=sfP07wxg; arc=fail smtp.client-ip=52.101.84.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYUWH/ckTPZk5XBXDzLoxK+0aMySHIIFuojdBmcWARflVRzQtGbsWfD1KCM3J5/3PMT16dnNDo0wSGaPAk//Syf6pIgft68hlo9rbudXb8Bn38glF3lrGW+luyXxqbVngc/xsemmUBb6ndHY3/6bL+7u7djJmiBCaSRUPtRvSgxEObLh4FiEkdxGU/gOLdn87BSb7WL9Kt106GJKY2ugFGkXY7JAkXMC+BF6uJ6ZelYjBradeuiphYfn/pZPP7kQVqfA6AqsCegQfM9SPd0Pec8gm4W65C4tKYIqMFaQUdykj2lRapP8zM9P0oYi5z8wQXQ8z+I7WAiS65ukS0wV7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CY0OAV7CngZIuepyntZmY9eSVgmPUas7jl5MKu56xKQ=;
 b=soHxOPIiWU1Mmn+AEFu8JRRhXX+GWfi8MDmQveUOX2za6uOdEdZIOsd3oshEToi7r79/X01BznxNYh3C9qiC39v3vx//bHI0XaeOBMWH5Ot9p2KOBPnt3UM7JuXBp1DSoeVpos79fC8JWgAc/tHxSJMxtdlUFpxHQFpwVmUu5ySJtzSA8y/nZE6UC6V2I+0jCaMx1LLlN6jVNfZGG5ax9C6oTlGUAj4lHRzsmOcyyqplTTZ1JX4pKSwzhTPdonTFYg6iU/bs325pf5aYV3G05eOPrydp1SF1JPUt31073RYWZATlE8/qlnRs8iIjAPBeSjc3D5YvbLRlfmBAE9+PPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CY0OAV7CngZIuepyntZmY9eSVgmPUas7jl5MKu56xKQ=;
 b=sfP07wxgVBExSCirlTnzSU5HY045kEuM4rPudzsLH+9KLkDyVBm020uFMqzRc2YA8CRwcdzvuRGsUsG2wvAUBhTTgNosODETYWmUGR/5kTHPToRx43B/EQ4G/7G+T4Tv5Iv9lGCgA/97AVJwFvqQKefm0b6q8ohSD/U0PcHYmybeAAd5wUoYjMtYyhFO69OS/1Q6uk0iHPaIEclDaebJjSwJMI7RHpAvQ6xoh0hmOPwcCzdhRfJ96MBJ8+ozcCKcDpiC3JkTm+ciZlV2EmEtVM8LUoPR9zs7b6UHM04+7TAKPOY9e8jevcqFgMTVh0wRurFYktplcKTI83i4BCPS5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB9116.eurprd04.prod.outlook.com (2603:10a6:10:2f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 00:53:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 00:53:33 +0000
Date: Mon, 22 Sep 2025 10:05:11 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Brian Masney <bmasney@redhat.com>, Conor Dooley <conor+dt@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/5] clk: Introduce clk_hw_set_spread_spectrum
Message-ID: <20250922020511.GA14753@nxa18884-linux.ap.freescale.net>
References: <20250915-clk-ssc-version1-v4-0-5a2cee2f0351@nxp.com>
 <20250915-clk-ssc-version1-v4-2-5a2cee2f0351@nxp.com>
 <175848801471.4354.13819701022920596111@lazor>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175848801471.4354.13819701022920596111@lazor>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB9116:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e56ade-a129-4690-d6db-08ddf9727462
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FXWUfTdo0/PFkpLOIwPbknAoJW8zPLHZkP39cy7bjGvm6R4Eu5+NJ+Vt+Peq?=
 =?us-ascii?Q?eq2ci7ytP0ze8agCFET0Np0tH8kAEi2tq6XJhCF856exhb84YnBV3wsOHsfu?=
 =?us-ascii?Q?to0mEwruRlHF9lUCG32Ykbrcm7bS9slPSEkxxAVVzqA+E4vn1zRRaiV4xCQ9?=
 =?us-ascii?Q?zb32EHgDvL3cUdzvhR8LXTUSuOk6xEx3Rcib/djmZuPa4QeHnXILZ5SScDYk?=
 =?us-ascii?Q?Zd6ffjgFm1gObaWGgNw2KM4mGUYJsT7/22cE63DbZsF5D2G6/zIxOX4g8lKW?=
 =?us-ascii?Q?Ix0csI0kDE+b7GYjIYZvdPmwEHNKcgC4SYXSAurS8L26b21TURLOVaI5gROM?=
 =?us-ascii?Q?uhJXCEKiXJLvLutkXyuLADtDIk1EPMXWj7Iou29G3jqPpNwU3aYFkyfl5cGe?=
 =?us-ascii?Q?KGYFCj6kJ6crdEIT+wUYhfigP0P75f2YowrdJNKf/pKpjq+N/vpfGdWPXuzM?=
 =?us-ascii?Q?ClSACWbbRg3OVsfPC58iy8011j52rHVXuQR7ucQuMhporNftoj+YZ2vc3w/L?=
 =?us-ascii?Q?ByiTfQ5dYEoK2DcLpjIjjiu/ppQEuim9zeb32/FyTje/8/CU1K+X9K28rxqO?=
 =?us-ascii?Q?uRpA6nbcweN+Q+hBuBsZqDE9OcAcG57Z6UtghK65Ql3QQvnC1mISgRFYRf7D?=
 =?us-ascii?Q?knKCFyR/F2Ad8bYjqjZQm5EnbNcbNprw2CsMpck5BiU1vUQx1fCJwPjsfHAn?=
 =?us-ascii?Q?mWGdKQvXSPtVpjJHc2Z11Sa7FC+YNoe0FovvSlubitnI1h+L4j7Fqy7230JC?=
 =?us-ascii?Q?VskuX+VninXVsilN6tc3Uihqu4Kx0SCtTpO2+MReAcXmRLlyb2ipHuDyfaBW?=
 =?us-ascii?Q?5AFo7IlxhI2HIM7P7J8y0Gc6AgseFMNI+kNxi2aiVQqEAFqKrmkc/NqoBjvj?=
 =?us-ascii?Q?onbThzR7oI5kbUIO+4zX25wkc2ZciR9VuKUUZ849mxKDRamQ9Kiw2LGd4cwG?=
 =?us-ascii?Q?8L1IjMbPZNPXzFollPLSvm+bl1s0TgJpNlSJ3LhzMsTPK8n3drTwYIBiv/EU?=
 =?us-ascii?Q?PKwNbtYwmPD+vdvzB1dFx4S0DgQTtqadNRaDm+i1BjEvOQ1BrRv1MJWo3myx?=
 =?us-ascii?Q?PyaXOmjsfREyTc/qPaGoiNgaYPIcFWIFkG0y0KktXt6gP2Gib1N+Nij6XG15?=
 =?us-ascii?Q?W8XePon5CVWQCqNp9uNWPNE7lOv0cLSF4m7sSY+thF5oVXomV9/5gquVX3u8?=
 =?us-ascii?Q?MQnitYZHQrG2kpVH4Jv6QAhYG5aIhUxGE9OWuRuEB03i3bqpjg7vofjhVUBk?=
 =?us-ascii?Q?QcXC8dQR6khE8hRbdx/rKW2kFZL6jpzW/Xx+VmDPLY9C3+dOoMSLq1VjW1W5?=
 =?us-ascii?Q?qOYy37LrkVwqqGE85+dcZyU460lvf94+uYGvipFZqDxLHagve0Fl+5RUZhI8?=
 =?us-ascii?Q?zgNnKFlaxTEdpnyfXAcDsEsCNUhvk8aGZWdJdnDkehNt+DA11jtwRC279jFs?=
 =?us-ascii?Q?P8cYpoUjnpw6Rkw20gdQt+EcjOLWjiOsYxRN1Yl4/uU5tN/2K2qB7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fHfZ0ZJikcmXFr4I0I12aqEEu5ASykdsdQ+i6dtyQHteOywPwMrJa7WmBmOO?=
 =?us-ascii?Q?0eovm28qErg5mycFzH4FNwCSLZOjKHy8u3M7sMimlgoLlEMoSfJqaEFKdpcd?=
 =?us-ascii?Q?bSDN92jslIq7YIlhuh6yD/9MuLBC9c9SUAqP5UO7jmpkVREx+EjfljX0ttUt?=
 =?us-ascii?Q?8j11IXYmI5Pi6wo9xAYtukH4hYectTinbmgySGEcOSJlXkaqVC52xbhm4TiK?=
 =?us-ascii?Q?BJZl+dXvks8o0sZEPuDYNHW5Po0jEEsRJonBr/htIvmVS/8L5fZqMmZ5+nw0?=
 =?us-ascii?Q?NC4XRgJJMhWad9QCpLtT3Iz24Uww8ITDQWW8ZqTk807qjlar1CU2oc/iCJrY?=
 =?us-ascii?Q?MJBqoLyL4Oj9JYdePkq/Tx0k/k4aeTWPa6ImkT0BgVNCOR7mKlPH+BUniJoH?=
 =?us-ascii?Q?VT7nW65auttBwPKfDLsi5CC6OhAkrhWH1dnSVoCII/iZumx9KnxJ6+gbLfzZ?=
 =?us-ascii?Q?PgJ/3B4OHIDbdiEqVOQTPFV1Vwy2OuAnQodMi059hWvxxIatMi+i4ygLyIxw?=
 =?us-ascii?Q?trPLSc+c23eAZ7Pc5BJVUh8cfAkArePVis02T1lHdWEw4UbjWeVtAymLC+y4?=
 =?us-ascii?Q?8kUy7PjbPNajv8SG+WSPQKIhUEhz9wyypOE51AldXZY19Qba81tJiBrGjAgX?=
 =?us-ascii?Q?7sN6x6PY2IHjG68uPI70fwpZJs/Rcdq6eFNloKo8lecXR6CF5tYqMcgwS253?=
 =?us-ascii?Q?mDjTzD0flxpFqH25e1h7i+k+bLYT2U0bQG2vqq8Btpcq4Bdg5Lw/m1ykPHjs?=
 =?us-ascii?Q?l2Lz7/8b1brByphLiVbAAea/DFl2NCC2thJhaTIYi+6SLxpSS31nOXIQ6UQi?=
 =?us-ascii?Q?yRoIkxn6gVf01ZfzYnCGcEZcfdmqupYMkxG4VZJTGp/m6JSijRheJx/0XfPz?=
 =?us-ascii?Q?USW7hcrGltSst/Jwu2H0oH0V5SeEZx7AidHxhV5i6Pa8LfacGw/MC6lM53GB?=
 =?us-ascii?Q?hS2/J4Wl03kMBtzd+r4FchoIDNZkyJNB3i41bis3RO6s+DX/8d/NRDRC/9n8?=
 =?us-ascii?Q?bsKzRvDQI7ervS7WP7ifOyQZgBIUxez+FPLOsI+4KfxNe880mShtGdpmUJF6?=
 =?us-ascii?Q?X9lmRYAWVby27p0lUK9apERrbIxvJz849phuk0U/PV2mJ/zpHLECZPLM+uBF?=
 =?us-ascii?Q?QQlIdAoUTObOfAmd3Iq2epN3Z2TRcxdds5RkUMwS96SkkfjsbDhi0SdVWXTv?=
 =?us-ascii?Q?Aw7ORGGzkMASm9acYwmPtbMk+oP/P5Pkbh5TG/rSz49hHO/KLmw7f1D12pGj?=
 =?us-ascii?Q?ao+x7eAOJ4A7l6Yc3gjYtwUJDdg78lArjick+mGfKFD8XF9mX6ZZLUWNn9cK?=
 =?us-ascii?Q?urC2zj3NOyg1mkjQynT/Sjyp3b5uGEWUyNigmJluzSMSsuileiWnEI0qcC4T?=
 =?us-ascii?Q?Nx/ajU3lWq1Ds8EJ8LzJeEhqcUI7/OMpypgNSdjhwwFtaaN6oIxftQ5ItERn?=
 =?us-ascii?Q?CIHqsd9fcdR/wnyPrSPWqJFiP7jjc2ngHJdKAjRXONVvIXjZwzoXwIZoe244?=
 =?us-ascii?Q?XCu/YdfjiswaxhMstO016yH47Ppyqu0zuDQY0bHE+QpNU1pCNwMtM7xGJBmZ?=
 =?us-ascii?Q?Q5NSdjkFhG2PjHD1fEsQjJtjvKybnE0o00SNRVkD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e56ade-a129-4690-d6db-08ddf9727462
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 00:53:33.8296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIIX/MjZYieYc8SVLUCc6OIFMq4OS2O2dzmCpXTu7wfKsVEposFgn6E8NH4gh1Ko2m/wLsAFhavBZTENUIFRyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9116

Hi Stephen,

On Sun, Sep 21, 2025 at 01:53:34PM -0700, Stephen Boyd wrote:
>Quoting Peng Fan (2025-09-15 01:29:36)
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index b821b2cdb155331c85fafbd2fac8ab3703a08e4d..06db8918a1b35e3280e565272bc4603a88295a92 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -2802,6 +2802,32 @@ int clk_set_max_rate(struct clk *clk, unsigned long rate)
>>  }
>>  EXPORT_SYMBOL_GPL(clk_set_max_rate);
>>  
>> +int clk_hw_set_spread_spectrum(struct clk_hw *hw, struct clk_spread_spectrum *conf)
>> +{
...
>> +       return ret;
>> +}
>
>Does it need to be exported? 

Yeah. it should be exported, I will add it in v5.

>
>> +
>>  /**
>>   * clk_get_parent - return the parent of a clk
>>   * @clk: the clk whose parent gets returned
>> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
>> index 630705a47129453c241f1b1755f2c2f2a7ed8f77..4f48a4df95a1c54638a0e91e0a449fcc8aa40b80 100644
>> --- a/include/linux/clk-provider.h
>> +++ b/include/linux/clk-provider.h
>> @@ -84,6 +84,19 @@ struct clk_duty {
>>         unsigned int den;
>>  };
>>  
>> +/**
>> + * struct clk_spread_spectrum - Structure encoding spread spectrum of a clock
>> + *
>> + * @modfreq_hz:                Modulation frequency
>> + * @spread_bp:         Modulation percent in permyriad
>> + * @method:            Modulation method
>> + */
>> +struct clk_spread_spectrum {
>> +       u32 modfreq_hz;
>> +       u32 spread_bp;
>> +       u32 method;
>
>What are the possible values of 'method'? I'm guessing it's the defines
>in the dt-bindings header?

Yes. The values are in dt-bindings header and aligned with dt-schema.

>Please connect these two somehow, maybe
>through an enum.

ok. I will add back enum in V5.

>Also, why are these u32? Shouldn't these be more common
>types like unsigned long or unsigned long long instead being exactly 32
>bits?

u32 is large enough for modfreq_hz and spread_bp.

modfreq_hz will not exceed a few MHz, normally [1-9] * 10KHz per my
understanding. 

>
>> +};
>> +
>>  /**
>>   * struct clk_ops -  Callback operations for hardware clocks; these are to
>>   * be provided by the clock implementation, and will be called by drivers
>> @@ -178,6 +191,12 @@ struct clk_duty {
>>   *             separately via calls to .set_parent and .set_rate.
>>   *             Returns 0 on success, -EERROR otherwise.
>>   *
>> + * @set_spread_spectrum: Optional callback used to configure the spread
>> + *             spectrum modulation frequency, percentage, and method
>> + *             to reduce EMI by spreading the clock frequency over a
>> + *             wider range.
>> + *             Returns 0 on success, -EERROR otherwise.
>> + *
>>   * @recalc_accuracy: Recalculate the accuracy of this clock. The clock accuracy
>>   *             is expressed in ppb (parts per billion). The parent accuracy is
>>   *             an input parameter.
>> @@ -255,6 +274,8 @@ struct clk_ops {
>>         int             (*set_rate_and_parent)(struct clk_hw *hw,
>>                                     unsigned long rate,
>>                                     unsigned long parent_rate, u8 index);
>> +       int             (*set_spread_spectrum)(struct clk_hw *hw,
>> +                                              struct clk_spread_spectrum *clk_ss);
>
>const clk_ss pointer? And is it actually 'conf' or 'ss_conf'?

I will use "const clk_spread_spectrum *ss_conf" in v5.

>
>>         unsigned long   (*recalc_accuracy)(struct clk_hw *hw,
>>                                            unsigned long parent_accuracy);
>>         int             (*get_phase)(struct clk_hw *hw);
>> @@ -1430,6 +1451,7 @@ void clk_hw_get_rate_range(struct clk_hw *hw, unsigned long *min_rate,
>>                            unsigned long *max_rate);
>>  void clk_hw_set_rate_range(struct clk_hw *hw, unsigned long min_rate,
>>                            unsigned long max_rate);
>> +int clk_hw_set_spread_spectrum(struct clk_hw *hw, struct clk_spread_spectrum *conf);
>
>const conf? And 'ss_conf' again?

yeah. Fix in v5.

Thanks,
Peng

