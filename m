Return-Path: <linux-kernel+bounces-745276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC24AB117CA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9022E3A8B3B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 05:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F2024167F;
	Fri, 25 Jul 2025 05:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xbeqNasq"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011043.outbound.protection.outlook.com [52.101.70.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E9623D287
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 05:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753420266; cv=fail; b=qBjmEJ7AsAL1PmSZU6swjxbKL3LkXIGYlfQCvlAcjrUl4u6VBy6UhrM8q/FEk6b0/b+bW5gfBY1JYhOLCqPJYEiHkiBbZJDePOcq5ldLuHLR1Jl2FLLiHMYsQYl7BjAndSeRsBkO54I72slZbkWJ0+wr1RKsaJRdcJO7cZrXb6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753420266; c=relaxed/simple;
	bh=rmIF4MszWBB9esekWHRjfY5kK7F6p+w5vmqSDypE3TQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zfl4rIAFJi1CNxCWtsAVAlNPG2lttaMYtwAgO4h46WtYBTAlJu+QO7NWixW0uEgHeQKb+w9IxKhXD0JbBMoLeZs4GI2w2qFwJG68e91BQNF35BR+xj9D3VVX+blB6YQIoYqu8CyC+jjDocBI8BK9jhvwzIFisQe88SAm2NDnVkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xbeqNasq; arc=fail smtp.client-ip=52.101.70.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkvMfAbA2AyhzTSRsnRegUQf/IvnGKvekhkbmAMmwlemIWwunQaW9EN4+tVqVr2xZ3SToaJbLrxdDvQxFS+0lzQy+Xv1n4MdDhdPGqV+4050mE484NCv5sQSN8sWzMJdjo6+CM1ZziR2D3IUP3dpUiTtXTHfjbrAKGww1u0fnuDqjAslL3BHVqjOQIm3ttTRMruKtb/s7bji/G9pyVV6MYvKBBHxJm6X8Fq96hatjwkhrCSORHE8c9lQR2z6pj+qHx5j2kO3zYuXn+ptp0oyAuVJyU5Jesfh8PB0ftGEQNsDW17wrjzZjAi7vuDfwqS4tqs5cl5fBGsGQ01v8gTQBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xf+euri3PXdj/odpV/Fc8xke4ort1SVEH0aP83kZYSQ=;
 b=gmBkj5DOKPgL2edkUO/CfcCrFEYMUv1xGanL97GdHjkYIYTkS4ua8/qCGJGvKVvzyqYNtYPXwLHayPHrfB4xjO8iynPLcsiVVf6ktAIK8A7zXXWC8/pf7ddSU0bg9jIU0W9aJtctlEOhKhvRXb54Eg8zpxCcyIaEZu7cWxTZjcEnrWzZBGI+RnI2wDuYpyNgbC27x1X9MO8KIomeo9LTxiYphbmaBTG0/EkH4wn/bJVWPDWrY8dxJgC5wsbvtLCU5YFfjmI/kHsocm6XR4fRPHxxfruaGEX6dCRVdCnXJ0/GCjGoXjGNxj4MniDlbXgEvi7i04au6Vuo5JTa3gCTnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xf+euri3PXdj/odpV/Fc8xke4ort1SVEH0aP83kZYSQ=;
 b=xbeqNasqR1mPbHMlYI0Ik375dWHFEdH7WaFhipWT9SVxvNw7huzszlc5nHCFEoWWV2TxaAnA0EpPR9SrQ5DA/2jhzYzkZjsRT/pVJ6eKqUdZ59VH3ysySA4Zm/fnE0ZjZW6bBfO54tIdV3n8M/cgUiotlT+Gw0sVM2f/4wt6dRTOMrfqMpEuYzib4qZ1oZnytnN78Sarf2WiRx0oE+cqER5hFgUFT6Ie7rD+xWl861VQ9I/N7NY2W/7KeHfClNQq9bdKhpfyEBwRpXac5bDOnH/HD5smFmki1TvZQjup0dFqKuqmTxTvXxI2FBrxg5EToPx/dDZVw/G6hOkOYW7rnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by DU2PR04MB8808.eurprd04.prod.outlook.com (2603:10a6:10:2e3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 05:10:55 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::c96e:12f1:67b7:ed74]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::c96e:12f1:67b7:ed74%3]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 05:10:55 +0000
Message-ID: <cc7b6fe7-db3f-46a8-ab79-90624ec8f4d0@oss.nxp.com>
Date: Fri, 25 Jul 2025 08:10:52 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/20] clocksource/drivers/vf_pit: Rework the base address
 usage
Content-Language: en-GB
To: Daniel Lezcano <daniel.lezcano@linaro.org>, tglx@linutronix.de
Cc: S32@nxp.com, linux-kernel@vger.kernel.org
References: <20250705160129.3688026-1-daniel.lezcano@linaro.org>
 <20250705160129.3688026-4-daniel.lezcano@linaro.org>
 <6b478a82-5087-44b6-b2e6-acb494fe1e22@oss.nxp.com>
 <c51c45ef-e769-406f-ac2f-53c90bc78d8d@linaro.org>
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <c51c45ef-e769-406f-ac2f-53c90bc78d8d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0021.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::12) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|DU2PR04MB8808:EE_
X-MS-Office365-Filtering-Correlation-Id: 514721e5-ea87-4c96-40f1-08ddcb39a221
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|19092799006|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qlg4YU15dFpHaS9OQXVBdzJHN1NzclpLcERrUGtocTR1RFB3aXptQWhJNjZC?=
 =?utf-8?B?K2tMdTZPUHNOU2NMSFVRQzV3eWRvNmh6K3FiL0wrRkhxUHVJenZnNEt3b2tn?=
 =?utf-8?B?Mkl2VDZTSFFnamNKOGp4Q0VRcnE4OHdDOEZ0VzZQaWsyUFBGdkFnQ1llY1lE?=
 =?utf-8?B?dHFiR2VjYWdvZk9EUFREMjhrMXcrUzNZbkZCQTQ0aVJPQkVLdTJSZFpJWG56?=
 =?utf-8?B?QkhaQlZ5Y09obDAxSmZVSVo5aXJxRjJNcVRDMEF3ekMzUS9qN0J0c2lHYkhq?=
 =?utf-8?B?dG5PTk5HeEZERFRjZVJzVTVldjJBTmlGeTZ3VGszWTFua1RYTmYwVEg4bkRN?=
 =?utf-8?B?WGFqZjh6Sks3Yk1pakJWcEhFeXROdDRScmwzVjRxSDY1TFZNNklPYkh6UE5Z?=
 =?utf-8?B?ZGZ1WVhrcTVTYTJmYVI5NzJiV1VuV0dFbUU4cTBUVjh2Q0xXaFBrRGpCcFlo?=
 =?utf-8?B?YU5lbUV2OG9yTEZ5Q01LYnZ6Y282dlZqbUxySi9naXcwYjRUN1FrMmhYVnM2?=
 =?utf-8?B?S2gwNjNTc3pOOUs5dVNjZDRxU2pHZzB3Z1pWOHpFelg0MkxSNXo5RndiNEFT?=
 =?utf-8?B?VDRjU2RnL2JxOWdyVU9uSHVQY002ZWhtN3ZRQ0tpZ3ZHNTJvREx1cVN5dzdx?=
 =?utf-8?B?eUxxKytCOVhIRG5YMU0xUHJJZHFEZ3g1RjNBRjhHejM5U1oyVjBNS2liS0tV?=
 =?utf-8?B?WkxUUlNSMzVod05rOXEvKytGOHNwNjZ2UUpUMUppV2h4OG9HdXlXQ0tybExU?=
 =?utf-8?B?cUZyM3BGbFVSeWEzNk5RVXZWRjF2dXhwSUJ1alBkbWlsU2Y0dGJ4ZkJPZFFs?=
 =?utf-8?B?ZUdOc3U1aEdBU1lZL1lIVTBwd2UreVZCcEVTNElQYW5aTFkxVk53R1VCQzZO?=
 =?utf-8?B?dDVBck1OMkw5VmFza24zUEY0Ly9nOUkrR3JBZWxLYzA2a0t3NWcxb24wcy9h?=
 =?utf-8?B?OVBZZkxSbTJnT2JVbUlKMDAxVTh6TWlqVG1NRC93OUxjTDFYSEFhb0JmNU9t?=
 =?utf-8?B?ZTBrOEZlSG1PNHZtSHAwOVZmRGxuVkN6S082N0llK0Q2ZnRCc3VRYkNWUXJG?=
 =?utf-8?B?dHhLYlRxNVJSWVBienVLTDc1bUpNSlA2N3VQU1B4ZEJYb2ZrNlBvNU5tcjVG?=
 =?utf-8?B?elg4c1VtTHErZ3IwQVc2d1ZINEEwZk1IQ3ZNQ3lrUFpHZnk5QmJPOG15MVhz?=
 =?utf-8?B?M3paME1xK0pDMlYrMHg1QTF3dkZxWGNHalJMTGtDL1NtUmRTVHVyOTM1T3k3?=
 =?utf-8?B?eDlCa0lZaENxeThkOWZiQldJdUdHdGdqS3pqWnRGdnhtYnB0TC9GdFJ0NW5m?=
 =?utf-8?B?bXBBdnk2Sk9STlc2VU1ZNk1uUmFSTVluNzhnNG40NW9vZCtVZjh0YXEwS2xY?=
 =?utf-8?B?TjVtOU5GL3dvdGMyUnV2QlpNaW9hWXBuZThiSkRrUjE3S0tiVzIzUzdYV2dK?=
 =?utf-8?B?SmJpQmVwb0NITEVvcnArVjhOVEhXenRRTDUzVXROaElxa0VSTjJOS2lSNXp4?=
 =?utf-8?B?Nms4K1ljTk8xa21uNzNwMEFraTRZSE5FcHFVM1EyRTlCV09FVGdwTTJGRnd4?=
 =?utf-8?B?WFN5ekZDWUI1T1J4ZE8xbks5YitmSGN2NEpKL3p2MlBKWG5rbU51VW1WRnpt?=
 =?utf-8?B?U21PY0Z3N0ZuZHNSdStlbzFtajhReDdGeU1LWkNoalRBWUdOcE9vUmRha0hW?=
 =?utf-8?B?Tkdlby9UT2VEWU1SN1l2cnQ5Z0YybDNuZWZ0dmRjYU40dTUraVJhMUt6Uzhr?=
 =?utf-8?B?TzcxWkp1eTMwcVFqWjc0L3B1dzBTV1NjOFNqNmMyODZ6ZFZyUTRtNEpDV2lH?=
 =?utf-8?B?MFhWci9MSW15bUFWaVcwMTE5ckF6eHNpY2ZsRWUrQ0xnSVFNVjlvZGpJZmp0?=
 =?utf-8?B?emZlalB0STkxNlBjOXQ4WENDSkhHQysyVEhPYS8xblpjZGgwRlpXc0UxWmh3?=
 =?utf-8?Q?zX8SFNpAVGE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1pnTkZVbHRNQ2MvZkFzZ296OUdyVTZRbTdEZWN5cFZacjVNMEFnbHNtQkY1?=
 =?utf-8?B?WGo3SktMNC9vUUlmTzBUZjdBVWdFVGRFN0RKNk1ZMWdUY1I3NHNNOWZIWGpP?=
 =?utf-8?B?QzBVd0VXVDlZeURmZlZQdWJkZmkxM1Z0M3U0VjNIL0NocE91OWdSVlhTQ0No?=
 =?utf-8?B?VUFPdHp6bkErRzMvaXpBbm53cHQrT1AxbzY2UmVOYkRTWEQ2Y1hXTnJDQ2Rj?=
 =?utf-8?B?cHZTYmJ4bFpsMytWQW5xMGtlcGdhQUVobkVucTY1ZW96NkdLYVhpd3NYVWJq?=
 =?utf-8?B?aG0ra285SUhMQnc1ODNBUXZqdk9PNHRiZ0RTL1RnMEtiY056Sml4c2JqVlNx?=
 =?utf-8?B?UXZybTJqTllOUVBFQTE2M1JKSFVLdUtodlVyeWdFMlNjZk9pMEpKU3BiOGEw?=
 =?utf-8?B?S2RQU1VqcmVvR0QwUjRZc2F5VGNkVmw2ZWM3cS96OU9aWkl1UW05WExWTzlJ?=
 =?utf-8?B?ZDdETGhQVHNLTW00WEZtMXBHZzVoTW5XZHM0N1pyRXRKYUc0UTZ5Um1PU3NB?=
 =?utf-8?B?RjYwUm1FS3J5RzhlQmFrMXFxeWRwTm50TkU3alVvZi9RTUJTSTRxdTlISXBq?=
 =?utf-8?B?Y1NSNFNsdUZ4TmRHc2VLOTNZTXZJQnY5ckY1S0NLZVI3RG5YbFVtQlQ3RmdD?=
 =?utf-8?B?UU5Ydk1iTjZ6SlV2Wk5DcTBEODNTTjJhN3VvOHlUNlA5SllLK3Y5cEhGbFNM?=
 =?utf-8?B?enVGanByMVh5a2J5ZzZTWnJlR2R4elUyTGc0Z2ZWMWp6ZVpscGZRbjI5M3pK?=
 =?utf-8?B?V1U5ZW5jSEtpVnVxWWttdkdwMjhGRit4RVo5b1NQOFZLYnhrNndNL3BETUU2?=
 =?utf-8?B?SHNJQ3g4MVpzT2tIeWo1VHNtVm9mSlhuN1lNWitqQWN0WjVWNkkwRnBNc1Ix?=
 =?utf-8?B?bTltY1c3a0RmUEg5UjlIU1BEemNWYXpPT0JQblNmcU5iUE8yRklJY1BCazV2?=
 =?utf-8?B?NnFlZE5sMnJrSTdVSnhrT1FiWVdOeDVEMG5RRkZlN2hzTWxkdTRCUWduY3hp?=
 =?utf-8?B?WHIzWk05WnJJaitOYmtYK25HZjlDZ3huNml0bFBSUlhXYWlVOWM3MzRoaGlU?=
 =?utf-8?B?d3RZang5eStpeGs5THc5UGd4NFNUdUl2MWlvVG10VjZGZUlhUWRwbkJTQWNR?=
 =?utf-8?B?QWlFYS9UYmdvZmVwVHF5OWhRWlpValdlZ00zT1F0Ri9oeFdLNldFdWExcmw3?=
 =?utf-8?B?UlJ3dlhkRTN2dG5MdkNqZ2RDdC9QSDN6S1BPdlZXRTFTWldobEFkTXU2eWxN?=
 =?utf-8?B?dEd0djB6NmhCZEtPNmdudC9qRlZRc1FRZWVlelNCcG9wRmcyWUF3REVsU0Z2?=
 =?utf-8?B?NXJrYjYwRWtzMUVmS2NaQnBzVjVGZTdNMHNQbVRGeitxQnJFTmlUZzNYTHpK?=
 =?utf-8?B?d01UWWJiL25YMVdZSHFBdWpMalB3SGNwNTJUa1pJRWdqcnQ0a01yYS8zWVY0?=
 =?utf-8?B?ZmVDcWJyQUhoTjBwOWRTbnl6YUpaR0tibDlxa3owUXJFVjY3RGVva3NhejFB?=
 =?utf-8?B?V0ZQUE9CLzA3VC9pMzlEajFXZi9vQ0QrTmx6OTBRbzh2aVZ5djc3bjlBdHpz?=
 =?utf-8?B?cTlkTndwMEtha3FLd1NDaW9iWmpoRitjRHIyakgxU2g5aEJQV010YnAvMXUy?=
 =?utf-8?B?KzdoNVkySlpnRjZ2RTltaitrVjhLT1RNd3RPejh5RUk3UHdoeDJTR2p4SGtW?=
 =?utf-8?B?T1IzUmp3amRWdmtvdTMxZVN5QmRRWFZ1VnJpUDZwWjFEWVdOcmpyY1FTS1lB?=
 =?utf-8?B?WlVrS1JpUGpaZjh6R3ZQVXdxSzBwWThTa1VibThWQnprYlE5cjF4UW5idEVs?=
 =?utf-8?B?NEo5dVJkdmcyeUFVeGl6bHhrSjRNYXFnT3hzVEdEWWVvdHo2UUs4eCtGcnY2?=
 =?utf-8?B?RCs0dEpBZzNBMzVydmNBYkxXcUtjRkptVFJhbDNIQ0d2TVhVNDFHMDR4UENr?=
 =?utf-8?B?Rng1QWo3UHhrbUUyUXpydklIQ0N6T09VaVJqQ2wxWXNSUTRIUVdIOEpicVB2?=
 =?utf-8?B?d1J5RjVzMHc0WnJtTGlMZXJtQ0tFU2JuUXpJVXE0R0VWajZBczY5UEVYeklq?=
 =?utf-8?B?clNhL3lMdkdkbURrQ0pUeW5HTVJiZ2NiWTZhU0xlaEFNY0lVM2FXUkxSZG1R?=
 =?utf-8?B?Z3U2V29JcnFCWENMYVJBQzZHcVMwNFZhMzRvS3ZPQmdEM0l4K0JkeGR5ODlx?=
 =?utf-8?Q?fHoTqgmwhkZp30YwPj8tkqI=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514721e5-ea87-4c96-40f1-08ddcb39a221
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 05:10:55.5331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uREzdYaOvk8U9ik1Fip6FGoH0+s+MfVQGfFoqiz409SuRKKsPlKMvzuXTo6ErDOC24ng2EoHs8q2BELY3Qe+xHDELmbc5Hao3+Pl22tDdL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8808

On 7/24/2025 8:29 PM, Daniel Lezcano wrote:
> On 07/07/2025 14:03, Ghennadi Procopciuc wrote:
>> On 7/5/2025 7:01 PM, Daniel Lezcano wrote:
>> [...]
>>
>>> -static int __init pit_clockevent_init(struct pit_timer *pit, unsigned long rate, int irq)
>>> +static int __init pit_clockevent_init(struct pit_timer *pit, void __iomem *base,
>>> +                      unsigned long rate, int irq)
>>>   {
>>> +    /*
>>> +     * PIT0 and PIT1 can be chained to build a 64-bit timer, so
>>> +     * choose PIT3 as clockevent and leave PIT0 and PIT1 unused
>>> +     * for anyone else who needs them.
>>> +     */
>>> +    pit->clkevt_base = base + PIT_CH(3);
>>> +
>>
>> This description is somewhat misleading, as it refers to PIT instances, whereas the code actually operates on PIT channels 0 and 1.
>>
> Actually it is what we have already in the driver, it is just moved around. I'll take the opportunity to change the content if it matters. What about:
> 
> "The channels 0 and 1 can be chained to build a 64-bit timer. Let's use the channel 3 as a clockevent and leave the channels 0 and 1 unused for anyone else who needs them."
> 
> ?

Sounds more accurate. Thx.

-- 
Regards,
Ghennadi

