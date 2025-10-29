Return-Path: <linux-kernel+bounces-876603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB81C1BD42
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A650A34B692
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31523446B5;
	Wed, 29 Oct 2025 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b="rOhdlRZg"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022126.outbound.protection.outlook.com [52.101.66.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BFA26B0B7;
	Wed, 29 Oct 2025 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753171; cv=fail; b=X5H0AZ6FSJn3umjMBAaVqffarDT06/hYTTnrIHnCuVd292j0uGch6MwSimIkRIKJfno6RML5GPAoIBUaK1qOt/vWVhZlWywWu2bPbEgwLEy6orwI2j18aWvrfyzmBC5ZQbLn3aASdlDo7VWTe1pAxuAPuinRGPd95v4ceJXwxos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753171; c=relaxed/simple;
	bh=MFsTS3xo8ep7nQyf/6IAy0ltulpRD6M3baclo/OsdX0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R56YLQc/GghvBSWyS8K/z0rCfJf8j5P8IghbE3rRBbjGhSIOoJrOuJX7aJUY5b4zFn3ziMVTJE3V43iK6HzU40aTpXrUWuTxQbBhZ3H/zedsBP/oFUE24wGFJHNn4pJMutAq5FxCenpyUfdDLEJS58iQBnJ7XvoQwszM58gWshg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com; spf=pass smtp.mailfrom=gocontroll.com; dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b=rOhdlRZg; arc=fail smtp.client-ip=52.101.66.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gocontroll.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUi+WYg7BZ5QSstya0vOyIO1bYWJ3bydCGWvkc8IcieCmgMQ7WDylYatAzwqRdo2zPJHomkgOs9+l9AN3nMKCm4gIh1BNbu3fwHemL83dGT9Cfa84qa6uMu06itE3yQZmlpm2SVAAqm8tffwbPD8GtEiYoZQhat2MM53oG7foZZiuLYlR1sR+oL6Kow18xXEPVH00NRiKqkwQdIQBUbCGUfD5tiX11goSG4JIpwm1AbXBsk6WFp/ayt1xQyEHITEuQKUdgQchghTGPWGLZO4VCHPEEBginqDPIvN/6TvMQuU0LeFEBObGFaKieLtUtxo1tZY1jxYmTRr2ygLcYM12w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23omEI33LQmqAPuHRtcc50v/dPcsMMG+rZYLlfFYoWU=;
 b=SUQ9yv2XZAptfb6LZIjnJWyxwrCFf8q0GGJJx9L437ugk+XA+OruJ3x3L3WA8bYH32Zk7yf0SeUCCTXFzb2ya/W5u7d4/b0W8tA5FPoncw5F+R1GsqCMnS3zwyeGiFv+B/QHfVsQsPEsfjRy86pvKVF6Qh00VCNzP0MYIyHLTstEcEZl36AO9r11bcxW006DM6XpxHioF6fFpKSwcCQ8ULcaSePwNCdBGJNP2yRAaM4WMKY/23ozmVgs0UUhgj74RWnb4qfNeGB+WL2F8TqWArBqmy9s0pbY7e6vtyQLOJz7sG3p1WgYPol8UuSUcdtyFZhL+EkvX3jWGgXoEsB/VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gocontroll.com; dmarc=pass action=none
 header.from=gocontroll.com; dkim=pass header.d=gocontroll.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gocontrollcom.onmicrosoft.com; s=selector1-gocontrollcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23omEI33LQmqAPuHRtcc50v/dPcsMMG+rZYLlfFYoWU=;
 b=rOhdlRZguQ3fOt2al9IbpgeaK1jgNdwEpuL/waNvJLL+HCESkwv3GuLklVE3l0NlQHIbaPsXLVi4G8XplUYNaEy3Sun5pItHwunK7dHiTiODZ0sOgNWzb1KPqtohaDrXtcPgawAzONycOt1ebwIZRnbKKjdfA3l1kBXZeyQ0RVo2EM14QAp2B9V9ckmaDnyXG5+7QDEJFl7gyIvZIX+XyZUllm7018gGkuANm6baKULFdSvFKVfMGNc0u9LbxXhwlkO1e0drSnzodAKHeGHBgKsC3RBQ/P7+rwc2VnVd++Vx0LlIWwRjunFcGNUKeeV8Jj1lhc2LuwoUjs12sjLolw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gocontroll.com;
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com (2603:10a6:102:ec::16)
 by PA2PR04MB10447.eurprd04.prod.outlook.com (2603:10a6:102:413::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Wed, 29 Oct
 2025 15:52:41 +0000
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f]) by PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f%6]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 15:52:41 +0000
Message-ID: <7aaa736c-2390-44b6-913c-0ecb63393ee5@gocontroll.com>
Date: Wed, 29 Oct 2025 16:51:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] arm64: dts: freescale: add Ka-Ro Electronics
 tx8m-1610 COM
From: Maud Spierings <maudspierings@gocontroll.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20251022-mini_iv-v2-0-20af8f9aac14@gocontroll.com>
 <20251022-mini_iv-v2-3-20af8f9aac14@gocontroll.com>
 <a7012995-c2a8-48a3-abe1-5c227272f21c@gmail.com>
 <65202d1f-6c4f-4d4e-9fef-85cfb74ec768@gocontroll.com>
 <938f85b0-4c9b-463a-960a-f5f4e4092480@gocontroll.com>
 <20251029081138.2161a92a@karo-electronics.de>
 <4a47b9b5-f482-41b6-a441-7728572c5a0c@gmail.com>
 <20251029104838.44c5adcf@karo-electronics.de>
 <d05c62c9-7ed7-46e4-aa4d-27172741b5ee@gmail.com>
 <0667e026-99f3-4233-b3f6-e38273961d49@gocontroll.com>
Content-Language: en-US
In-Reply-To: <0667e026-99f3-4233-b3f6-e38273961d49@gocontroll.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P190CA0005.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::10) To PA4PR04MB7630.eurprd04.prod.outlook.com
 (2603:10a6:102:ec::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7630:EE_|PA2PR04MB10447:EE_
X-MS-Office365-Filtering-Correlation-Id: 81adf083-849e-43e2-52ac-08de17033178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SC85UGJVSVl5UjZqbW9aYy9FRlp0a3BWWnJ2Zi9USGUrSHNwQ3VjUVhDV1c1?=
 =?utf-8?B?U1ZLWUVpcllKQzZ1S2s3RlNZMElBTDUyZW01Z3B3UktzMERyZHBuSWtjcHQw?=
 =?utf-8?B?aEN6aGQvUnpHT1ZJWjN0MnJuNVVGdUNhbnpwMy91SEx0RUUzRFNqeDJPRXJM?=
 =?utf-8?B?RFovK0IraGxieEkzRTBuS2grTGdPUXhwWlBJYTFTNm52UXFzYVNpdVNZTElo?=
 =?utf-8?B?RHpiRFhzREk4WEZjVXlEVkI4R1N6QUlyNGR1Z1RNL3dRcTlkQW53KzJOMGp1?=
 =?utf-8?B?cXBwYVVEOUs0MEVRSlVFZE9MK25xTW9uWkQzazltL0lmZVZsVWxZWEFUOXFD?=
 =?utf-8?B?c2VsUlFjMFpWN1NYWjNRcXdjQ2V5c1VvOFR2d2dwRERjM0o4T3djY0tFdjNL?=
 =?utf-8?B?YnNoYzh6M2NyemhjV2JUZFpiNW5JUFkrVU4wa2JETEdRKzNhTlN4Y0pTWklU?=
 =?utf-8?B?bTh1V2JObmxaeE1ncUNyS2ZWVEc5OVBUdHcrbEczVUVJQWUyOFF1aExxYktW?=
 =?utf-8?B?NUptem5lNHpESGRnU3A4Vm5EaExrZjZRcWQwQXFxVTY5S2oxRnE4OHVPOU4v?=
 =?utf-8?B?Z1huSUttNjNOcCtxU3ZyYnZvZEM3RmZkKzFsTmJObm5sVWRJYmpKY3RPT2Zj?=
 =?utf-8?B?bk4xUXBJODRTcDYrWHRFdUFMMHZvYkIzOFFWOVlveHVaTzFaR2VGWHJ1ZUs0?=
 =?utf-8?B?cDlLNTFIbVNiVFc3VmVEUG5ISjI5Umo5RzJvZmM3YmUra0I5TFZBZnNVbmNL?=
 =?utf-8?B?RjJIN3BxOU5iOHFwd1hMd2ZOU3pDUks0NVRiSXppOVZsUTc0a3lWamdTaG5O?=
 =?utf-8?B?UHBkc1VYV2FiNjMxVG9OSkxjUEtDUWNnWERDMEhWWTZjYVkrWGdyNmhZbGV3?=
 =?utf-8?B?MVhNSWpva01rV3lVYUV6azZCaXN4VUpqMHpvM2dLUXo1dW0ySUVYTzBBbFdL?=
 =?utf-8?B?eHhZWnhDdTdJLzZzVTc3SlIyUzIzZzdGYzJVVmF4enN2dlRuODFZQUR6TVdn?=
 =?utf-8?B?SDdwZSsxWnJ0TWo3Tm14c2FoTjF3NWV0bG4zYWpDdzYvTi9Za1B2T2lFd0xU?=
 =?utf-8?B?UVNLVjR1TUZoVWRMVU5JdzlmL0dkNHh0SjEyTUpuTE9rTGk3WmNHQUFIWVdX?=
 =?utf-8?B?UFA0T0dCMXhhcHpudEVWY2FXYlpZbFdDeVVOR0s0YUZpZ1Jzc3BFSXlOS0Fj?=
 =?utf-8?B?c3RqQmdNTUVrVlBYVXcyT0t2c1NYUmVGcEFwUEx0QlhoRnFDdXd0allzc3Ry?=
 =?utf-8?B?c2VqbWVKcUNtcGtXbDZMZkZMOE42SGJlZ1h2TFNuWkZoem5KOFFHZEZqVkM1?=
 =?utf-8?B?Rm5MUmF3RHJWTEt1Vkh5R0k5SjVQU1VJQWdVZEEzajhzdVF2bXFRRlZucDR2?=
 =?utf-8?B?ckJ1ZU4zdnM3aFlWMUszVTN1UlBXR1JqaWx4bWE1eldmeG5YTkpZU0szd0JP?=
 =?utf-8?B?Y0NYMUJpR2FwWVMyNzRZTUhlNzFTN29LNzc4d3lzb1phK2VuL3Y4WWZ4MFph?=
 =?utf-8?B?UWlTNUp0ZGt2YzE0eHprM1Zidklod0g0K2NlbXFER0k2UTRrOUZCbG1oSGRL?=
 =?utf-8?B?a29yTE9oZ3d4dklFa0JnWExqMWtzSnJtVEh5dGl4YmlpK1hweVRYb040Vm9B?=
 =?utf-8?B?UUtCQVU3Nno1UnRjQ3RVL2dzSHluSlpXMFNRRkREWFp2TFJKWFFFUE5WakxH?=
 =?utf-8?B?SlkvR1hGTHVrSC95cVNPdkNnTk80Q204eWo5STJpVDM4T0dGaGdteHVHcklL?=
 =?utf-8?B?ZVBRTU9pMkxEK3ZhR3d0cTFaNTRWYjAxS0F3WjdOKy9XRUVyakNua0VCTHBE?=
 =?utf-8?B?aVVORG5BaWtRcGx0cWZtUTRZellCdnhqa2VuT0FrcDQ0VnhDVXgwY05yREY5?=
 =?utf-8?B?UHFFdDNlODdrL1JDYjl0ODVuS3Noc1BhOTNXblZ0M1B5WVptWDNYQ0x2NEg5?=
 =?utf-8?Q?hEIvemNMPzxj8SU1quDoB6jjZc4S7ct5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEZ2TUxEaG56Tkw3Q3V6L2ZoaFhuMGlTcWl0SmFIQSt1TitGMzRiRjkyQzd5?=
 =?utf-8?B?S2dydUhieVZCR1EwM1hhTlBCVDZ6c3hmTWp2bCthOW5kSXZTbDlFcE5Rc1Ax?=
 =?utf-8?B?UUE1cTJVN3ZmcDRaL282OU5GMTBIU0syekx6ZWJLNHRLY1FGaEMyWUpDbnEx?=
 =?utf-8?B?dlFVczNQZDVrenpaZEplTi9ENXlTd3hzSndmczRNZENReDRCVTBmUW9hT2NI?=
 =?utf-8?B?NnNFTGJJY1NNZzE4dFFWME5XcHMveFkxOXE5MytBbzNEM3U4SXU0VzJCTDFE?=
 =?utf-8?B?MGM0aExMc3J1QUZ5ZXE0UUdpK1NEVXdCcEpyM3lZOGxqeVJxNXVVWm9yYnZO?=
 =?utf-8?B?RXcwRlVTVzcrM0pnMHlXSFBIcmlraktsb0pGencrK1NlMkdxcWE2WXpDamww?=
 =?utf-8?B?ZVNIVmVsTmJKdEdweU5vajJMeXJxbUxmeDdrNGdCVDZReHlTYnppTkhxc01t?=
 =?utf-8?B?TUF4aU8rb1R0cTdDSWQweFFERW5oYlRTZE5FbFBDeTRnSUwzb2VFSEJyMHFu?=
 =?utf-8?B?YUR6MjVITHVueHBSa2NGbjlIYWJhNndQcVZscmV1YnVLQXJRQWtiWXcwc1dG?=
 =?utf-8?B?MFQvYUMzelhSMnR3ZnUwbnY0QmxxVWxuMTNVbytwOVdjSVhSUDFNTUIvTm5O?=
 =?utf-8?B?dVhVdkRPVXpVWHgxbFVIejB3dUdKWHo3bFk1S2I1My91VzZrQ2VmOEUrNTQ4?=
 =?utf-8?B?d1NiZGc5N0ZLZGhPS1dXSHlYcXYvWk9MOWl1SFF5VDU5ZkFtL1M3QlY2TTdD?=
 =?utf-8?B?dVNOY0w1Q0hMWkUyck1yNXFyMWFCNUQrMUZmOWN1ZUR2YjBIdEdKZHl2bGdn?=
 =?utf-8?B?VmZINjdYYjJIQUJ0YXFUa1hkUHBGL3M2Z3c1WVJscHNUSjFMQThCN01RUzli?=
 =?utf-8?B?ZG1Qd2g0cThBRkZEZ0hjNnhzNFJmV0NNOHY1VWE0VW5qV29aWE1QOXJNQTRY?=
 =?utf-8?B?a09PNk9DU2dxc1h6cVVJQ0V2MzJTaDdzY2djZDF5ZEdFVThWbmdFajRPdm04?=
 =?utf-8?B?eEFTTUxibDRUZHdkdXRnZ2dHMlJmY0l0R2N6c1hKNFdPUTUxRW5DOENyM2JH?=
 =?utf-8?B?Uzk1aHpJdnltWFZ1VFZyelZqajFlWUdYaDVJb2s5NjZZTXgzaG5QUGJpY1hY?=
 =?utf-8?B?VzlsRGdqY20rUGpxVlpla2NSY3dMMzhDOXExZU82MHBUMWEwcTFMcWJwTkdP?=
 =?utf-8?B?eTY1UWlEcTZxeVl1NzRDOWl5c0sxRlhVQUwvc28rT2N5ejRTa1ZwN2xpQmdm?=
 =?utf-8?B?RVNwZ1gxSnZOS1RoT1hiZ0hjbUpuQUdTQkpXcHI3TEY4NXdPS1RNWXkxMGVT?=
 =?utf-8?B?ejNUWWRmeWVkRU90bnZZbnZ0aWZRRlR5aXA4cnZNRXpJNFFmeXdlOE50eXRn?=
 =?utf-8?B?bVVqV3NNTk1wQ0JrRHZpOGhvNE54QTRDcXRLLzlNbnVpYW1KUmo3Zmo1alZy?=
 =?utf-8?B?aWIwL0ZlWERoQXY3cU82SU1Icm9haU1KQXdocVV3S050eFF4TWNqUHd5bXNy?=
 =?utf-8?B?cDFOZHhTY2ltRmNXS1NwUXdJcEhlNFBBS2tvbFpUa3c0RThDV0Q3a1RFUjIw?=
 =?utf-8?B?QnZTdXZjMDdyL2c0Rm1WdmdpaHlwaVROWjJaQlRyVHFyUUptQ2I1RVVCNXZW?=
 =?utf-8?B?WU12MTJHUmZyUFR6UHBOamU3Yml0eTVQTlYzWjhDNWsvVnh5VlpESzUwWXR3?=
 =?utf-8?B?YnMybzhkNHFqbDFXV2FWcFI1VjJscmlUNVpIU3FkWjN0ME5NeENBa3FQZWJu?=
 =?utf-8?B?M2p5eUtHNW9YZXc1NlF2T0diYTlmeGkxMHFwTWpxbHRGWGc2djlucG5XNUZT?=
 =?utf-8?B?QVd1RHFlKzBod3ZVZ2lWMWdDUTdoQzlxV2I4c1VKRVJlN245ZkxmUFVQK3Y0?=
 =?utf-8?B?SktjNGdRcVZSZGx4RjFzQzVTUVFLN240K2U3OGtGcFI4VWc5SkhieFczVkcy?=
 =?utf-8?B?S3IwejZvUGZ6SlFBdHNpeUJPTSsvbHNhcDFYaFZtVGpCdTlWVHhaL0tNUm1j?=
 =?utf-8?B?Y0VVUlllOXdhOVhWbi9BUERKbFU1alpiYnRHNlV2dk5QVGNvOEpFM0l1cW9E?=
 =?utf-8?B?dHBPaVpyd1VadE1sdys5VnFNUHJtY1BXbnVZeThLTUZhUU00SHo1WlpUOUdW?=
 =?utf-8?B?TC91bExVL2FKWXVNZG00UHU5b08wOS91alQzckxsYStMM1lLV241ZklSallj?=
 =?utf-8?B?QzFTQjh3ZjU5QkRqY0E1STI3UkdVSjNIRU1mUDFsMndhanEyTWZWby9tbm5H?=
 =?utf-8?B?NzdrcmMyeHc2bTJBejAxQmhUYzN3PT0=?=
X-OriginatorOrg: gocontroll.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81adf083-849e-43e2-52ac-08de17033178
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:52:41.6755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4c8512ff-bac0-4d26-919a-ee6a4cecfc9d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0YwqKbqXtoCC0K7xRswqqH4OQiACLEk1BkdoV0IwKWJ9LpDTWsGudYQ5IL3vJM7K3/Eq05oExuxhhlMX3NIheEkakRu0fhA43qlB/0sV7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10447



On 10/29/25 16:35, Maud Spierings wrote:
> Hi Matti,
> 
> On 10/29/25 11:05, Matti Vaittinen wrote:
>> On 29/10/2025 11:48, Lothar Waßmann wrote:
>>> Hi,
>>>
>>> On Wed, 29 Oct 2025 10:42:17 +0200 Matti Vaittinen wrote:
>>>> On 29/10/2025 09:11, Lothar Waßmann wrote:
>>>>> Hi,
>>>>>
>>>>> On Tue, 28 Oct 2025 14:10:04 +0100 Maud Spierings wrote:
>>>>>> On 10/28/25 13:42, Maud Spierings wrote:
>>>>>>> On 10/28/25 13:15, Matti Vaittinen wrote:
>>>>> [...]
>>>>>>>> Could/Should this be described using the:
>>>>>>>> 'rohm,feedback-pull-up-r1-ohms' and
>>>>>>>> 'rohm,feedback-pull-up-r2-ohms'? If I understand the comment
>>>>>>>> correctly, that might allow the driver to be able to use correctly
>>>>>>>> scaled voltages.
>>>>>>>>
>>>>>>>> https://elixir.bootlin.com/linux/v6.18-rc1/source/Documentation/
>>>>>>>> devicetree/bindings/regulator/rohm,bd71837-regulator.yaml#L108
>>>>>>>
>>>>>>> Ah I didn't know those existed, should've checked the bindings in 
>>>>>>> more
>>>>>>> detail, thanks for the hint!
>>>>>>>
>>>>>>> I will have to investigate this carefully, since I don't have 
>>>>>>> access to
>>>>>>> the actual design of the COM, so I don't know exactly what is there.
>>>>>>
>>>>>> So I am not yet entirely sure if this works out, I used the 
>>>>>> calculation
>>>>>> in the driver:
>>>>>>
>>>>>> /*
>>>>>>     * Setups where regulator (especially the buck8) output voltage 
>>>>>> is scaled
>>>>>>     * by adding external connection where some other regulator 
>>>>>> output is
>>>>>> connected
>>>>>>     * to feedback-pin (over suitable resistors) is getting popular 
>>>>>> amongst
>>>>>> users
>>>>>>     * of BD71837. (This allows for example scaling down the buck8 
>>>>>> voltages
>>>>>> to suit
>>>>>>     * lover GPU voltages for projects where buck8 is (ab)used to 
>>>>>> supply power
>>>>>>     * for GPU. Additionally some setups do allow DVS for buck8 but 
>>>>>> as this do
>>>>>>     * produce voltage spikes the HW must be evaluated to be able to
>>>>>> survive this
>>>>>>     * - hence I keep the DVS disabled for non DVS bucks by default. I
>>>>>> don't want
>>>>>>     * to help you burn your proto board)
>>>>>>     *
>>>>>>     * So we allow describing this external connection from DT and 
>>>>>> scale the
>>>>>>     * voltages accordingly. This is what the connection should 
>>>>>> look like:
>>>>>>     *
>>>>>>     * |------------|
>>>>>>     * |    buck 8  |-------+----->Vout
>>>>>>     * |        |    |
>>>>>>     * |------------|    |
>>>>>>     *    | FB pin    |
>>>>>>     *    |        |
>>>>>>     *    +-------+--R2---+
>>>>>>     *        |
>>>>>>     *        R1
>>>>>>     *        |
>>>>>>     *    V FB-pull-up
>>>>>>     *
>>>>>>     *    Here the buck output is sifted according to formula:
>>>>>>     *
>>>>>>     * Vout_o = Vo - (Vpu - Vo)*R2/R1
>>>>>>     * Linear_step = step_orig*(R1+R2)/R1
>>>>>>     *
>>>>>>     * where:
>>>>>>     * Vout_o is adjusted voltage output at vsel reg value 0
>>>>>>     * Vo is original voltage output at vsel reg value 0
>>>>>>     * Vpu is the pull-up voltage V FB-pull-up in the picture
>>>>>>     * R1 and R2 are resistor values.
>>>>>>     *
>>>>>>     * As a real world example for buck8 and a specific GPU:
>>>>>>     * VLDO = 1.6V (used as FB-pull-up)
>>>>>>     * R1 = 1000ohms
>>>>>>     * R2 = 150ohms
>>>>>>     * VSEL 0x0 => 0.8V – (VLDO – 0.8) * R2 / R1 = 0.68V
>>>>>>     * Linear Step = 10mV * (R1 + R2) / R1 = 11.5mV
>>>>>>     */
>>>>>>
>>>>>> Because I do not know the pull up voltage, and I am not sure if it 
>>>>>> is a
>>>>>> pull up.
>>>>>>
>>>>>> So:
>>>>>> Vout_o = 1.35V
>>>>>> Vo = 1.1V
>>>>>> Vpu = unknown
>>>>>> R2 = 499 Ohm
>>>>>> R1 = 2200 Ohm
>>>>>> Gives:
>>>>>> Vpu = ~0V
>>>>>>
>>>>>> And:
>>>>>> Vout_o = 1.35V
>>>>>> Vo = 1.1V
>>>>>> Vpu = unknown
>>>>>> R2 = 2200 Ohm
>>>>>> R1 = 499 Ohm
>>>>>> Gives:
>>>>>> Vpu = ~1.04V
>>>>>>
>>>>>> I am not quite sure which resistor is R1 and which is R2 but having
>>>>>> there be a pull down to 0V seems the most logical answer?
>>>>>>
>>>>>> I am adding Lothar from Ka-Ro to the CC maybe he can shed some 
>>>>>> light on
>>>>>> this setup.
>>>>> R2 is connected to GND, so Vpu = 0.
>>>>> With:
>>>>>     regulator-min-microvolt = <1350000>;
>>>>>     regulator-max-microvolt = <1350000>;
>>>>>     rohm,fb-pull-up-microvolt = <0>;
>>>>>     rohm,feedback-pull-up-r1-ohms = <2200>;
>>>>>     rohm,feedback-pull-up-r2-ohms = <499>;
>>>>> the correct voltage should be produced on the BUCK8 output, but a 
>>>>> quick
>>>>> test with these parameters led to:
>>>>> |failed to get the current voltage: -EINVAL
>>>>> |bd718xx-pmic bd71847-pmic.3.auto: error -EINVAL: failed to 
>>>>> register buck6 regulator
>>>>> |bd718xx-pmic: probe of bd71847-pmic.3.auto failed with error -22
>>>>>
>>>>> Apparently noone has ever tested this feature in real life.
>>>>
>>>> Thanks for trying it out Lothar. I am positive this was tested - but
>>>> probably the use-case has been using a pull-up. I assume having the 
>>>> zero
>>>> pull-up voltage causes the driver to calculate some bogus values. I
>>>> think fixing the computation in the driver might not be that big of a
>>>> task(?) The benefit of doing it would be that the correct voltages 
>>>> would
>>>> be calculated by the driver.
>>>>
>>>> If real voltages aren't matching what is calculated by the driver, then
>>>> the voltages requested by regulator consumers will cause wrong voltages
>>>> to be applied. Debug interfaces will also show wrong voltages, and the
>>>> safety limits set in the device-tree will not be really respected.
>>>>
>>>> I think this would be well worth fixing.
>>>>
>>> Before doing the real-life test I did the same calculation that's done
>>> in the driver to be sure that it will generate the correct values:
>>> bc 1.07.1
>>> Copyright 1991-1994, 1997, 1998, 2000, 2004, 2006, 2008, 2012-2017 
>>> Free Software Foundation, Inc.
>>> This is free software with ABSOLUTELY NO WARRANTY.
>>> For details type `warranty'.
>>> fb_uv=0
>>> r1=2200
>>> r2=499
>>> min=800000
>>> step=10000
>>> # default voltage without divider
>>> min+30*step
>>> 1100000
>>> min=min-(fb_uv-min)*r2/r1
>>> step=step*(r1+r2)/r1
>>> min
>>> 981454
>>> step
>>> 12268
>>> # default voltage with divider
>>> min+30*step
>>> 1349494
>>>
>>> Probably we need to use this value rather than the nominal 135000 as
>>> the target voltage in the DTB.
>>
>> Yes. When the driver calculates the voltages which match the actual 
>> voltages, then you should also use the actual voltages in the device- 
>> tree.
>>
> 
> Think I've got it:
> 
> diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/ 
> bd718x7-regulator.c
> index 022d98f3c32a2..ea9c4058ee6a5 100644
> --- a/drivers/regulator/bd718x7-regulator.c
> +++ b/drivers/regulator/bd718x7-regulator.c
> @@ -1613,6 +1613,8 @@ static int setup_feedback_loop(struct device *dev, 
> struct device_node *np,
>                                  step /= r1;
> 
>                                  new[j].min = min;
> +                               new[j].min_sel = desc- 
>  >linear_ranges[j].min_sel;
> +                               new[j].max_sel = desc- 
>  >linear_ranges[j].max_sel;
>                                  new[j].step = step;
> 
>                                  dev_dbg(dev, "%s: old range min %d, 
> step %d\n",
> 
> 
> the min_sel and max_sel fields were uninitialized in the new 
> linear_range, copying them over from the old one (they refer to the 
> register range if I understand correctly so they should not change) 
> initializes them.
> 
> Then setting 1349494 as the actual voltage makes it fully work. 
> Otherwise it complains:
> buck6: failed to apply 1350000-1350000uV constraint: -EINVAL
> 
> Final debug output now:
> [    0.327807] rohm-bd718x7 0-004b: buck6: old range min 800000, step 10000
> [    0.327813] rohm-bd718x7 0-004b: new range min 981454, step 12268
> [    0.327819] rohm-bd718x7 0-004b: regulator 'buck6' has FB pull-up 
> configured
> 
> I will add this fix to the next version of this patchset and include 
> your requested change in the dts.

New idea, why don't we just change the values of the original 
linear_range? Do away with the allocation there entirely.

Kind regards,
Maud


