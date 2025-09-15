Return-Path: <linux-kernel+bounces-816026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA534B56E57
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 04:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728C118998E2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4452921CC79;
	Mon, 15 Sep 2025 02:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="g4lJ7WgA"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013006.outbound.protection.outlook.com [52.101.72.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9151ADC97;
	Mon, 15 Sep 2025 02:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757903756; cv=fail; b=mOhg7fIe7fY5l3PnunM+f07zIFPkJC9NwG5uJ3LxOAJW2CKb11l3wNuNPx25xs5gtOsiXvgV0brmutTlFz45VkVKQkMw3b9hNsmVHXWnpMy+wh0ffuXW9rM1BLt3Xs6WHWuUE7qJt+Pk+qoyURPiAITswOF4fpXs0C1E4hFx4Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757903756; c=relaxed/simple;
	bh=s4yPTjFFBKr4uS7Atz7GSDoB9XNmRbsMFX3HJDRNKSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y7MnBTA3Gh4Mst9Z/O9MX2zBtEmzndMU40kyqXlPCA1B3/neUr0Th2cb/w+sBnrVBG7KJRFtm3my4Dxk28CfMxGSu9hrnFcZsMY0+MhBaFO9fJUNKdZLtWDZfg9NgGWy91OFiq+8R4SS2SiAx6MdZewsQKp5B0N3AX7xma3ZmNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=g4lJ7WgA; arc=fail smtp.client-ip=52.101.72.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fide9dfwgc2RoSd3qoEvNvQNX8zD8vS+gmtZS77OIRmBTkeeRisxcgCk2m1sDEJ7GhpUzZ2zhr/w+Ek4Yg3RLEDpPpggN0mW8RqYlBiDNSBblj5ZX3mmmkcrfFVlp5YlnuKb4SGYx17hdwPcSfpBmMJicUA30wVAQIz5E3OfExOO6rbEzpz81S5hOYhFaa19jEr05t5S23k/DKrAPoaBR6CKQp93fsVn31PlfIwQHm65VZmp3wnXd2rBX5dsMBFOBr9ea+dhfpqt1BrNcxLAljR3DeiA2WdHG1TQ3aevofkNhHjPTfwDPNakPV7COX6JwP9PxiWoDTL+JRbKnPRltA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFq63UVda3Oi5agpUYyyJrXZ+Jx3YaxLkGj+9FM9ItU=;
 b=o0Kb73h+jHPkQfpMRSJvJeUFZBoqsaFI59npfuZi093GKpYQgVTuwECryapzo69sTPwKOtHpcNOUZei9zy1KEZOT8g+bgnfYc8WLmdF1apVAueYbLF8XLodG+/LCrQ5XdkOkFe2uZpmtI34q3HfHduvJ4zp9K1n06XoCrapue1lgPtNHm/TBpfpVY5tv/PmoroF+rMcpTGa296ppAOV1OsHjfoSZZfJQfu/HEOZ4BLoez24qw0QXrXmjz31ZY8ckr8PBgtjtuw8UrSouTDO8azSNAH+QI0sRKg8FZCVW6lwpGMIwqWXafZe7F537wYGFUJj8AxUoz8UMRPqvuprPcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFq63UVda3Oi5agpUYyyJrXZ+Jx3YaxLkGj+9FM9ItU=;
 b=g4lJ7WgAES+wmzbEeGC+nDM3jsZ+5kpt7cM9QOZGJztVTPAVSjN+KCMF4Jo+a45KWKT1wobwTLSiB31YvdvafIjzkPSiGIL8OB/uHJv6lFXs+brBwmoexki7w4vrprWJRsxBVs5NjnfY2r5XubqotURW7PMgfo6QMhMITkMGTYjyTCurxjxhEb4qblb30qm1HGMfSwqwQjkHEDE+OpUg1MZg03RQfrh1UNGko57eKyjBvBySRuXRz2LjM1H+Utzs1UH+J22qLwR48O/UJpxgpgIHZ+bNcF/kgsGZh/xey4wiuRI1qe4EJItJ+Lw8Epl1FMjRtQR0ZVtDl9EE6L7DnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB9018.eurprd04.prod.outlook.com (2603:10a6:10:2d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Mon, 15 Sep
 2025 02:35:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 02:35:50 +0000
Date: Mon, 15 Sep 2025 11:47:13 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Brian Masney <bmasney@redhat.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/5] clk: Add KUnit tests for assigned-clock-sscs
Message-ID: <20250915034713.GA1331@nxa18884-linux.ap.freescale.net>
References: <20250912-clk-ssc-version1-v3-0-fd1e07476ba1@nxp.com>
 <20250912-clk-ssc-version1-v3-4-fd1e07476ba1@nxp.com>
 <aMQzP7DamsQWl8_L@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMQzP7DamsQWl8_L@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: f607d54f-92cf-400e-24e0-08ddf4009551
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K3o/g+QMJlb3zPrzzkUZz2PDSKN2ryWmoDn3sJ6dNizGnYOAfqJMENEUeg/z?=
 =?us-ascii?Q?T9rjhGLhfQ2M40cP0rD8ioOCyM5K9GvGKT3ssxWCHW20INAdpHBVYCZOJ4+o?=
 =?us-ascii?Q?84fXnKDBOJvTcaAQ7tRlDV6T6t/xxAfX8tr+nIyDG6EwBae0U1LQypyIRnMx?=
 =?us-ascii?Q?4ltCeaFFkY+tUcYuBEcohDmaNHSfFlsbEfwRao0Qo6El2EgbPPXbJTvVR5e1?=
 =?us-ascii?Q?U3MLOmZMQjQB5VkcVosWxV5bByRBwMLfM7MlGg8pM6kbCv34sRF0KWMNGhSY?=
 =?us-ascii?Q?uxKofXhFn2Tj0Wf/ywCNMcIk6SZuHl/Kvf6JMqsaYCjoPsM1Qd1e4tVlyZZk?=
 =?us-ascii?Q?6mpCfKH+nBRmi5EIgoVmOI80yaSFDVCd+RGylIP9FFTqi4muaJw5sEAgnGqR?=
 =?us-ascii?Q?QZ8CkJMphXS00NMnVb9zHKBw3Z7Ax/ER/wFRvWaF7rUZxQOSfNREolksUQx+?=
 =?us-ascii?Q?VR7Os849A8GSrpHVu+ynTyoM4XVmsQug6Q/LitlHyUGc8r+0CBqFk8xxU52E?=
 =?us-ascii?Q?6BsMcMOYpqYLSCQo8BIJSUqInqWqUW1JQnoSeWB3X17junoC80sUMik/TbEh?=
 =?us-ascii?Q?Eyv323eGklyjZm1qMv2RmuYmP4YRUIpJdf+u3fphVU7L1l/oMzvyrhdjAUsa?=
 =?us-ascii?Q?nmHvAv4YEWBdjdS6Rpg+DJymXf9a1WE6R2LaCOQRdUH/hRDX8AqlAkXQbS+r?=
 =?us-ascii?Q?xTxFIKMPTIpuKX1aDrZU5/wFbiOvanRAJQy8ksRKRDTe2mz4qXUUlaBer5yx?=
 =?us-ascii?Q?rkYLTqhHa9sMY7LqcGtpaoO9932Sy5OO6/Hmsbc/jbBAxDhzsMM/Wvw6CH4Y?=
 =?us-ascii?Q?rm4xv7X/yvitSnLRcHHe7HkvztmGwD8hKYQ4TNvWM13NRa5DWy8ZAZBCTbvI?=
 =?us-ascii?Q?rVr9VioPlfem/f1j9+WPJIhMJqHu5UB2IwSWh+2+l1/0DQvpV/nyEY7zDFkG?=
 =?us-ascii?Q?+ilt02ksKEnJseEJpANru1KGN00InRegayRWSDkLDsv0TAuTdnjAC8RzWbfG?=
 =?us-ascii?Q?iwF1QKaz6EY6O5ge4z/eXA33OoDXWg+6oQopB7DgoAnVCzoOr7q0DuB69nAN?=
 =?us-ascii?Q?mdhbQivd+0RLFd2jsUyFjqDN5BPnMkS5Y53jSaEBI/yv8dPV3/6YHwk2+hmt?=
 =?us-ascii?Q?ApWhGqS2VYxMb05bkQK9h3YAMOg3oBgIzmufDEiI9r3Xz1mGt/O/7ut3SJ+6?=
 =?us-ascii?Q?y8WlhkYwZ1MYPqtt7sEA7c7VTsJxGuumTYWzaovqy6cR3P8/lFPaJl3ncUEl?=
 =?us-ascii?Q?bNNXH42hcIFpY+6+QeaMZvKqTlKBQVWWb2+Zo0XxaR6qlu61ddaeTNMSgFuF?=
 =?us-ascii?Q?qq2zzkEtluRlsSOqOjkfDv3wyVKXMDnc/nYR3kLqj6dVf+Y6a2/dQDUbqnkd?=
 =?us-ascii?Q?szK8RWdwGW0RP79gZ8aRrwU/a2pZHS9UVvbdN+B1fo2FAB3Jm3BKp4zKNu15?=
 =?us-ascii?Q?yc1vNL3pWW3ra+L5gRABI7YnSIVp02BUNhZ67oR+8yLaIn3t+GZy6w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pv8BbZwQvOv6XNlkbxMbNVw1mA1kOxW7URuaOZMUc2MkVWh6wkzkJsNlxhWn?=
 =?us-ascii?Q?tEzOR8dg2tr7kkW135E3IeNYIsf9JC3w/F44FiXnBwHsApGnn+G0jddtrhNN?=
 =?us-ascii?Q?Gi71gfHuLiZHKDmnNIR/N9pg2XyI1rP+Jrp7NI53rxGIS3wPsnqeacPakZgt?=
 =?us-ascii?Q?WhGKmzHYlEix/xqMQqm9RuBLVbEt0/SQ4fvAkWt9LRpjJAET8qHK/2YFtp40?=
 =?us-ascii?Q?JYZ/e5SqRz50A+mAEWXcwbX3jVvL+LERFCQ3+mctBBtHSHXNM8V9hWqQHjNU?=
 =?us-ascii?Q?bBBN8z2SlyGMS8wrKmRFq+OzrbUzq5wK3cnhAxbJvLBo8PFgC/pYOwDjhMV+?=
 =?us-ascii?Q?HGJ7XCHTJUBs79nKeSzeleAAdG9KzR7MR9cofXQ6qUtgDAEl6oUpQkUYxjgY?=
 =?us-ascii?Q?9r6qtaQmGdMIAmt/yZeLlP2whUvvnG6qsIYOLEYzP4DXEsmzEu62VQsjPDd8?=
 =?us-ascii?Q?CVr3khWHHb5TZtvXphMEQguN+Nx+q8ukRhi+6vwLYqOMBGP2IWBBu33MVv1t?=
 =?us-ascii?Q?wzkLXMWZK1/iLs3n1YlpGNGbgHbBe8FTxfnB8Jz8T59W2mnUidrEaWktpX8H?=
 =?us-ascii?Q?pPx6j1+SFhPEO9QPJQ6YH0jJUVyESQwTlZcusMi+gk4LfsWGznmT0J+QUmfr?=
 =?us-ascii?Q?CJlTlBTYN/ZUN3TCCEYHvksF6t6m0A+3cUQkAhkWzphWULo6/8/YCaStb6FZ?=
 =?us-ascii?Q?GI9okNVlRmdBiEZiR2HoohobdjCgJZTxIwr4XvRgzZsvmXHB2feoyjs2NvBD?=
 =?us-ascii?Q?SI6yTuf1RfWtREwkfHl2FyOgQia+S3wRmrVE9u2Pg+XILYg11SRyjSLAtoBn?=
 =?us-ascii?Q?QbTgoRTK7jRF2M1S5LEdaPcThIX/UaOSldt/d5em2GWej0xpT3dbj/7UNW9v?=
 =?us-ascii?Q?9iPfDSOZWZdQXkbgidlMs8TTD251qF1NkCgbEWu4ULgP0nyBxvY193tNtJVz?=
 =?us-ascii?Q?a0qbyr3/Lk3MpPnFgPUVXmR1ArQh4AgEaaO+ESDqeEbeGX2yDTmqjA28WEkM?=
 =?us-ascii?Q?zlMKqDybzlYIKacwaryDiRaw/arHDVwOGpXin3f2N5uY+oMVe+ba8xfOq9ZH?=
 =?us-ascii?Q?5oQ7BGCDjRipd8Fd2Dfuc39p78hsGYr7fz1y0ntSPSzq1KmZQiryFIEj8bS8?=
 =?us-ascii?Q?8DdzYsvko8NOpgs/LMvZC7DrJFOu2/jirH0E1B7GOkUeqAol5/LDKWF3CPh+?=
 =?us-ascii?Q?nGwcMXiuIT1vKATZX30LazQ4vt6gRI88jJ8jWIKxcPLduIMiXYr5wwL0UJBn?=
 =?us-ascii?Q?Fr3pznUFvBXqr6rNJvfQEr+3al/kMFjE5+drMv9E3yQZ6Xv2bz++m6lfapAo?=
 =?us-ascii?Q?34ojqjBWQXXgtl3q0fN62A6jSX5d4iv27aaTBxZ7QJvy8P6nekhPgK+FcCxs?=
 =?us-ascii?Q?ZMvFE6KkNc9YRv0u7RD0HHZA5/X7aLqtHbKvRWxF8V7S3ljMpEP5v8f8c4uc?=
 =?us-ascii?Q?3U8X6UBbdt/SwgCsFcADLQANUIewKb7NETeG+0wbtKgOFK1lRnSGhI0NfkMS?=
 =?us-ascii?Q?OSLdJfAaTEkZBcn2/ZuypCDSCPrt/c5IBEMPTnN3ZscEAUXLoIRlvCrx0wqj?=
 =?us-ascii?Q?N8wBiFzWJvzFANM2j+HYsDjfwiTzIW/t1adS4Ssq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f607d54f-92cf-400e-24e0-08ddf4009551
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 02:35:50.0989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqTaeE2/Baqz2LSqBfW5LwCSeuJrvSKckhtpJhnIlT9mTRNaCXMjPtXx3+Dci2Bta+YE6Ayb0iK5VUCJPZc+dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9018

Hi Brian,

On Fri, Sep 12, 2025 at 10:50:39AM -0400, Brian Masney wrote:
>On Fri, Sep 12, 2025 at 11:35:53AM +0800, Peng Fan wrote:
>> ---
>
>There's no need to add a Co-developed-by for me. I just gave you a very
>rough starting point.

I honor your support, otherwise it would take me more time on write
the kunit test.

>
>> diff --git a/drivers/clk/kunit_clk_assigned_rates_zero_consumer.dtso b/drivers/clk/kunit_clk_assigned_rates_zero_consumer.dtso
>> index 1d964672e8553a90263af400367a2d947f755015..d62c7522c92461245d45f8ac0ebd26fa2850be98 100644
>> --- a/drivers/clk/kunit_clk_assigned_rates_zero_consumer.dtso
>> +++ b/drivers/clk/kunit_clk_assigned_rates_zero_consumer.dtso
>> @@ -12,5 +12,6 @@ kunit-clock-consumer {
>>  		compatible = "test,clk-consumer";
>>  		assigned-clocks = <&clk>;
>>  		assigned-clock-rates = <0>;
>> +		assigned-clock-sscs = <0 0 0>;
>>  	};
>>  };
>
>kunit_clk_assigned_rates_zero_consumer.dtso is modified, however
>kunit_clk_assigned_rates_zero.dtso was not. The underlying test doesn't
>check for this, so you can drop the change to this dtso file.

Right. I will drop this change.

Thanks,
Peng

