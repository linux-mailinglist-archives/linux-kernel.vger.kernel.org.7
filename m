Return-Path: <linux-kernel+bounces-775847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E7CB2C5B9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4243E3A7B43
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9B42EB85F;
	Tue, 19 Aug 2025 13:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="a4aXu5HV"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013015.outbound.protection.outlook.com [52.101.127.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0AB2EB854;
	Tue, 19 Aug 2025 13:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755610163; cv=fail; b=OR6sNnG3YmR/Tp0QShvU2ImjdHWtujtBu64/FhAyNigPE1oiVHLHLaqs2PEo7PozPpvFG/Xx5FzvfqEs0oThyNM/VX+0669alchx3izhKmJ3uJonpN0bp0W5sjeex89VapiNrClDrY98ht+wgigmOQ+mumkYZwTqWdbA2DygPUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755610163; c=relaxed/simple;
	bh=meWzyFZpMbEpqR9ji76lWSxSmlYz1j5KzVe56/eZ5iw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ImM9n90wWpkbmGoKlejnn/ntq2za1QKI78S493P7oJd8wM6Aayhap3/+7B6GA05P0v4tPXE+cvXv8V6PNC1b1QvTJb3KHYHOB8uaIC7G/CN786H0ZpGN21LLzOHnq3kEKb4VBseIgs5YAwqoYH8hzymBRx7uCkgJDtqyD9NwkFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=a4aXu5HV; arc=fail smtp.client-ip=52.101.127.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTQTQGNOCNlUQu5+y2gGT/pFq0Ey2PQNffDr2OhFXNRH5sH2+bdIFxs+rWxUO492Exfq5wa1RHiScKlrlcdTuKArE4CazTwfxLK4SgTWLwxwY4FYWia6UQ58lcpZq1m/XsCT/Wi0nkruXl78AaTU6EQFFvXfe2a2jMwmCMzPwfnzN28avVQ0I7eJVySlag0s/5e9erB4A7chOQdWkvzpsx8yeWx6k0AMmW7QdGZf3THEMh7/qnJ0UQaM8yNxIXr/yyGXSmpHEyOVbB7y3AinrZs+iwzdg7U1XWldEeWdfU9EuGxCw6qdp3Pd21/xEaDp++b5Dscj9/p7OKLkjW1+1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fm8jDzPrWIl4MLnYP+kwQFg9S0MnIgNMXEmNtmcFOE=;
 b=lc062Mx8A9F+3tjSfI1Xmr2MYxSc8gAaeLn791EbxPHCrn9qBa4XT9t97BaghsDBiJ0JBBfI27XHF5dArP9C5guPWEMGQ040g1r+pextN5KbS5y3jxVk8HQF3apaq55Jgb814xBVORR98EfccylieOKXbc7TELzKfKzO9BCqr32co6Y3v7wYxKpt9utcxUfWScPUsE7mShhZKIWwQr6qHWHchseocC0cgnIssNjBjI4dpfdyBXD+6K3Voyx1BRntEMaufvqxBs5VnreXEcCOinHYd4dnznmFAlezq2hWaHl630XKUhvlp3VwA57/mxBkWn5ZPHlqz74FG8eDDimipA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fm8jDzPrWIl4MLnYP+kwQFg9S0MnIgNMXEmNtmcFOE=;
 b=a4aXu5HVE7AaGUWxSoJALcJecydA68JbzlPM51mT9qH5brUHCG7+xQ+NnKnhnyKVv/FCSq/ELqykmKjwNCEA4jGXWAkltdIgEN2WM553Lvub1dkVtZ8TPEDqE6xj2zEajJdUqXM7jyTUx727Xmu4+jEandGz3nlJTHklf2/xBwkrFm6QlSXxebQYy8b0UUJn3rhCmX/Sc1nxHEU+r94rzc5p2F3UsgNDvHPvPoK2ro/Ko9V8v4Do+U7bJKTVyi+5qOky4rwAnZmiyvQts8trPaUS4uQmZtUvL4J6UJ81/BLIul9/h/F5Ib+J62bDRJPUxnO7r9peJLYmKeP633uEvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SG2PR06MB5190.apcprd06.prod.outlook.com (2603:1096:4:1d2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Tue, 19 Aug 2025 13:29:17 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 13:29:17 +0000
Message-ID: <61d4c6ab-1326-4c30-81e1-28bc500f8877@vivo.com>
Date: Tue, 19 Aug 2025 21:29:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] backlight: led_bl: Use devm_kcalloc() for array space
 allocation
Content-Language: en-US
To: Daniel Thompson <daniel@riscstar.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250819035804.433615-1-rongqianfeng@vivo.com>
 <aKR6FAYDrNDhY6Af@aspen.lan>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <aKR6FAYDrNDhY6Af@aspen.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::9) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SG2PR06MB5190:EE_
X-MS-Office365-Filtering-Correlation-Id: f22a1698-06d8-4df9-574c-08dddf246587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0lhdVN1WmZJT082UHBVRVlsbGlkS2Z1c3dyUWp3KzkzMG1aamJUSFNtTWhL?=
 =?utf-8?B?cE1YRU1iR09qbGN0WnQ5U2RnSFRuZDVtRFRHeGFHRS9zTldFaUxwYnlVcDZa?=
 =?utf-8?B?VS96MndXR1NrTEhLK29IaEFqY252dkl4OVQ2QS9LejJYVnZ2alVlRDZlZzZU?=
 =?utf-8?B?SnpaLy9pK2RSM0xTOG9zVi91bW55Z1dzQ0NCTERxYk04OUMvVWMzRThhRVdW?=
 =?utf-8?B?KzlwaFJibmc5TnVHMEJ3elBabmZLUy9kbG1kSkVkYS9POXRNSVYxRGc5WHBR?=
 =?utf-8?B?ZE52VDBQYkVWUFZvS0Y5UEJjVkV5N3FEZk90aitkSG5WL1hpVTZVSzYzaTVY?=
 =?utf-8?B?NzZIU1ZCQVZ1VzJBRXZRRE1rcDJkWWFNVnF4NW9vY29GOGdQV2dYcUtUOVpW?=
 =?utf-8?B?bFVlNEV6TGxNNFgxbkwyS0kvMldSZ2t3MDc1cnRRZjVXMjVab1dkSWxhaTJh?=
 =?utf-8?B?dDkvdGpmcGZUc0xINmJvcWszUUtDc1RHWFh3RzlJQjVrdDk3WnpRQmxkcTBx?=
 =?utf-8?B?bStWekt2cS9uUjBMOTBoZUVBLzl3SzZubVhWZkpaQTRoN2xpMm9LOW1oRzFP?=
 =?utf-8?B?T1ZDbFpFZWFzSXRVQWszbFBhRFNjV1pkd2pqdGVkUGEvZVBQVHpuN2tRSmFx?=
 =?utf-8?B?U1MwSUtLUFVxc2JxMHJQZmpIWWNHdGRyWGdjRU9VREZ5QTc1aFlhK2ZiU3Vv?=
 =?utf-8?B?MU42VFhsbnpHQ0ZndVh5ZEpOQk92emVwM3ZJbDBPVGl0cHdDWlpMM3dpWGNu?=
 =?utf-8?B?YWQ5ejUzU3VHYUo4b2xsL3V2ZjFJNDZEZWlHeWo3Z0Y4cTY3aVJOTW9yT0JI?=
 =?utf-8?B?RUtnNG5yMlQ5QmtJTlNXd1dYOXM3K0haS0UrZG1XR0RCL0JVd2FSaDQ4Qi95?=
 =?utf-8?B?UzFLbHAvem1zLzZFdHNGQWhnaExnWi9OcEd0ckg1ektlMVVGbDNuOU5HS09s?=
 =?utf-8?B?WVBQckVuMDBTYjc3RmhQOFl5MTRsTFI3aFljbU1QSnVEV3ZTbVdYNVJjZzhn?=
 =?utf-8?B?S2dtNDJyeS91TXk2L0t6bzNaSGQvbEtjVXhwZ0Z5ZE9XL1JnTEczZE00Sk51?=
 =?utf-8?B?L3ZZTjE4emZFNFZFOHdXQS9NWGRTUVEydm5NdjZpQzAzQm9KcmpIMnlGalFL?=
 =?utf-8?B?ZUUzVmdGK1NhTlVwTktmUHhkdnc3T0RmY29qMmh0NDRkaGtodW15b05VYkpm?=
 =?utf-8?B?NnVwNGs3alU2SGZzaVAzTTBXS0FvQ3J0dmViSHBhWUl3elNpaENadnRRVHE1?=
 =?utf-8?B?K3J2Vk9zMHUzbml2RHZEL3VMU0tUQ01BSXM2NzFHQnI2eExBV2ZQcTNkQ3FI?=
 =?utf-8?B?dm9BRjZvU3BDQ1c3YWQ4bUlTL3FabXI3UVJ3aVZIUXFTRnNlYjVnaWdHMWMy?=
 =?utf-8?B?RGMwamVyQ3FXK1d5dThBZjBjVCs1MmxqZXJ2WmJTcGRoNStENXdnM0tsMlYw?=
 =?utf-8?B?MEpHckMySjNQQTh1cHNqS3I5dzBoK2dtL1hJbXRDcHd2ekFaRWkrSzFRdStx?=
 =?utf-8?B?UVdpRFd0RnFFdmprWVZDc2tzU1NRNFhBQWZmN051R0NzbEtQOEpNVDRDTHBw?=
 =?utf-8?B?K0VlNlhteWFjdFJWNVBIL1RONzdXU25HV2hCYmFGYTNVZGVNcG1oSFAxM05Q?=
 =?utf-8?B?bDkxc2g3QkJPQ3lhdGMrQytKamsvcGpYdHJNY09rSmRDbU56dkczL0NhMTBm?=
 =?utf-8?B?MWRWcnFheEJMbjBWMWd3dUpWTEFudVFxUlA3V2x6czdLQzVST2cvRFdmVi8y?=
 =?utf-8?B?WlJ6ZE9ZMnBxa09RdlZNREdpeDMyZWlMeHU1MU9PWEdJenlyVTdOSldvamtp?=
 =?utf-8?B?a0xlcE84bndwZzVYendKcXlNK3VjZTZYcHR6WTlUZ1pVa1k0bDlYTk03ZWlh?=
 =?utf-8?B?R3RZa3JuWW9uT29MZ0dnaUs2ME5lTjhYZFB1ZVM5MkZtTmlIb0tWeExOb0dy?=
 =?utf-8?Q?tKlG+l4ms8A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUthbUc3NnBtT1I3QStSSTIraWRwa2N1cTNQaVhMMTNINXgvV04xUC83Qzho?=
 =?utf-8?B?Sk5qMDhiMzA2M25BOWZzakk5TmdxQ2hraVVMRlM2b0k2NmRuVWtDeGM5Vkp5?=
 =?utf-8?B?Z3daK1I1NmJWUjBRWkI3bmpOYmNjQkpUdWNWR1czZ0p3eUNUMHVlL2svL3VL?=
 =?utf-8?B?OHRUaldadXZzUmo0WUtkVEUyY0w2SzhHU2RxNW9tM3ZUendDRmp3MHZpK2JM?=
 =?utf-8?B?Q0JlZG45TXBSWWxlTGNuODlFQlZQZE5ObkxkNG55c3M1VHZkdUdxQ2RrWmxW?=
 =?utf-8?B?UTJ2SENJK0p6MFZyNkxiQksyZkpzVmpMR3JoTE9TN3RLVTRnb05jSlR5bXJF?=
 =?utf-8?B?SlJVZFJHc1hJY09WVzBrdmhyNnI5K3BBY3FFMkorKzBSbTkwdWdTUmJUaWJu?=
 =?utf-8?B?allrZVNhcy9kWGtseGFMYkFERkxCTG9xUnhUMWJqMVRUMzJCMEh2K3k4TkVR?=
 =?utf-8?B?blV1d1dKSjV6L0pmZk55MUdPTk03OHlBRnpVc204SXY0R0E2ZGQ3bDNEK05Y?=
 =?utf-8?B?OW1VKytzdVRQSXRXaGZVQS9MaWZicmU5WXF2aGRrYTljMms4cE9laE9ZN2VR?=
 =?utf-8?B?RjAzVElNb0VCWGpqeWdTbXAvSlRZeXdqWXpDOFczcW4zNUl1Mmw4Q3pFaTBw?=
 =?utf-8?B?b0Y3ek5pWU5uUFhZem95VlMzVmdpdHBuY3lxUC9ISzhuV20wOFZJeWhKdlpo?=
 =?utf-8?B?TzR6ckNTYzl4UDNaQXpiT3VadHdyUUVyWHdmbkQwckpaQlE2UWI3dERoVVRw?=
 =?utf-8?B?M2lWalRJdTA2dG1TSVl6MUphb1BvMi9ic0Y1djhjUkgvZDl3Y0NoWEVLb2Vs?=
 =?utf-8?B?ZVd1cVRMTU5qZitteDlzcW1pa3lmakhra3pnYzVZTWkvc1BuTlpUaXRVWEFS?=
 =?utf-8?B?UVZPSkMrWXRudHdwTzdyS0xIaDFraUNwQjA0UFNvbk9yVFdiam9hYzNBY2p6?=
 =?utf-8?B?Mm45eFpxRE9jS0VkOHRwckJhNnJJS2F6NTJneGV1UjdRMDJXMUlMZmxHcTZN?=
 =?utf-8?B?QzdLU3lBSkR1eEVMeHdWYXU5UXcreTljRncrbUdEaGh5aWc0T3hoRHRjZllV?=
 =?utf-8?B?SDU2eEx6NS9jVlhvTFJIWkRmQmV6Skx1R0liT2JZS3o4WWpSaTYzMmRaMzdV?=
 =?utf-8?B?VU9mdERrdlI3Zm1xZ1BJd2F1ajVielVsSkFvZjRUbE55d3YwVUV5MWRxMSt0?=
 =?utf-8?B?MUFReFB0L2l5OU9MVlZ4TjAwNkxUbnhmMEU5QzFKck80Q2V2QlM5MzNLMU9u?=
 =?utf-8?B?RkJTbkxGMThwbnFpTWhvL2JTN1VOcE14Z1ZmZEpFeWFNL0J1bW5vdWZHMFNX?=
 =?utf-8?B?UmEwMW1CMStZUHJaNisyVktKdmZ0OHRmTjFoWXJjNVRuSGFYMzFpdE1UVi8w?=
 =?utf-8?B?S2ZrcUZMMHhVeFFvKzRkQ0JsREdNNU1VemF2ZDdKYTd6a0pZSVNFSG5tNWpR?=
 =?utf-8?B?RjlVZVhud29EUUs1clp0NGVvc1hIUUdXZnpXU1Z4Z0lBRkM4Q0NCZXNYeTFa?=
 =?utf-8?B?NzdvREEzdjQ2Z0NpMVJNWVVHVXJkMXAvSm13UEw2YW1heFlZOVVMZFNZcFZU?=
 =?utf-8?B?M1NIU1NUSTVKUFRIdTcwWXVkbEZEb1RCWVl5QjA3dmFJZmpvVlI0eERMUThU?=
 =?utf-8?B?UUwzb1Noejd4V2dkem84b3BZc3BuYm1ZcWorOGhoeEtEYkxrMExicExVSWN6?=
 =?utf-8?B?UTUxRU8wSnV1LzZaZEdVVFRTUHRBek5MME1BVjZzaUMzWHp0TEJBWktIbUtK?=
 =?utf-8?B?YmRIUnc1cDJDYytYb09xckhHSEVsS3FIZFJlK1JiZ2NQQVBCNFdNQzlWQlBZ?=
 =?utf-8?B?WThvNE55VlJNMkYrS1ZmR3NwMXpvTlQrRElRNGxkc3B1Sjh0ZHVRTVN5bzhR?=
 =?utf-8?B?ZWwwdWhwb3U0WldaVkl4dm84bS9YZUpwRHJjeDU2UUJSdHZXSzlReEhIdkl1?=
 =?utf-8?B?NFAxVWE0eGphUVd4UGJXME9ISU13ZmtTTW1rSUNwRGRWcm1oRnNOMGN3ZVdJ?=
 =?utf-8?B?RVRXRXAzcDZUdHRRNUlaTDk5NFVqaGFuNkxNRTd6VnNCYjZRdE1tcHA3Zi9q?=
 =?utf-8?B?MDlBb210Qk9oV0piZG1aTndTYWxkNEF4VUhhK29NSDVDK2hWT0M1UmE4cThl?=
 =?utf-8?Q?4VtaOXG9oldM3C13JJCcZ4o4h?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f22a1698-06d8-4df9-574c-08dddf246587
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 13:29:17.2744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nPdCDDnbeUDWusNgNt8Tt+XwmFI9nH0w1hnbdzJ8M6ZHoNcz2jhFL9xJIKpf0LUL/Cr+YSPSb+1JHL0L7LA0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5190


在 2025/8/19 21:20, Daniel Thompson 写道:
> [You don't often get email from daniel@riscstar.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Tue, Aug 19, 2025 at 11:58:03AM +0800, Qianfeng Rong wrote:
>> Replace calls of devm_kzalloc() with devm_kcalloc() in led_bl_get_leds()
>> and led_bl_parse_levels() for safer memory allocation with built-in
>> overflow protection.
>> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
>> ---
> I assume you scanned drivers/video/backlight to look for similar code
> patterns in other backlight drivers? If you did it would have been
> really helpful to say so in this part of the patch (because in it's
> absence I had to do that myself).
Yes, I scanned the entire system and there was only this one in 
drivers/video/backlight.
>
> However, the code changes are fine:
> Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
>
Best regards,
Qianfeng

