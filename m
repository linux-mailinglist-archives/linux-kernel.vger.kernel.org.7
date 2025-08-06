Return-Path: <linux-kernel+bounces-757342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF86B1C105
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5246B18A5F5F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 07:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADA421773F;
	Wed,  6 Aug 2025 07:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="fGyekUTt"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022105.outbound.protection.outlook.com [52.101.126.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDA8171C9;
	Wed,  6 Aug 2025 07:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754464282; cv=fail; b=UkGoWsuAGOKikcqwKYNpiwlrxSPZQ3tMdjiHxebCuJGeyMi118VspTh+vRpQspV49TYGWkKpKo7kPSdiv0yD2bmj8dt2gLxDi8Ktxvnxfg7ngVwdiTkUaGjGu/7fM9Z0RyPkCdB6dDdYGv8EnquMXgRg5LE2O9OQY2uVRq1FRdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754464282; c=relaxed/simple;
	bh=01InpC1sRDzJ5s1GRgdN7WwXbIah+mw3wUQgiIdTvS4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=usVQd0RwlasR45jozkyWUjmAA1enR33fldj/pE4M2zyc3GlEoqu0u85V4xK+muTrm7OSnyr1ZoEqdvSB8he9MkR0cM7rxuMUMR+xPO3PI1LpNS8O1W4cgRSQW+fivuXHZYdbfThICB7AiBVw+pB75Xu8bRVzNqM1PPHDEdmpDpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=fGyekUTt; arc=fail smtp.client-ip=52.101.126.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+zLfmcuIpr7sczCyQUJcbQSltU0664NNjOrPCbKqJx+Zekoxaj26+X3wrC55k6Ljymv2FJqP+sqrIk6h4y+/vuyWfoDl1exAADBdLS6TZRigAwel8OemAlAW+JDxdKO/Zqz+4lS7Bfi7akjxd5fy1UNC5Z4etlwk1PWytdDxzoTh4qePd+URls6WyQik7SWxDVqA8wAbhpWSSvXta0ETJsD6opQE2hb6hRpxo2LskPVySWmq3VclmvWNRIRv1Q/2xBCc+ZyJ1e8FIBu04D2ef7TUPR4vXWeaq1/uID1pUaZLw2KXD0mSHrPmcf4ri1N31c6nUIA+S0xxJIFstZ0ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hN/pAJsu0htqg1nzyUA65wGuemcERU2yI4AnOMeXtkU=;
 b=CQAlCZTcDu3ITmRbVuddafqh8w/wpII1rZM2PGMDwC7iqyCqbsjig9QJ/C6mWkXNoMaOrgo++L2Q8grp0pbea6Gxm9JXeo4vHFGpKjZ4pjtfOAxGb6JCoLFsjSZz7rHuwj+j/5Oz9v2qr+mFLAy/RKQu1R0evGWE5I3oqILgDFHjIaiu08GYLgirHxehkMNMa24lVozsC6LRE7FSyGWNsTRifN83zQq2p1eNyfregslkbd7/7OOpD5gzHutpwS8/7GxHUR6ns+KT7aV5bpVXfR4dhR5yypOSzyCN73nA716AALm6Dv3Is9vB0nYYsc50rN99wdrofc0BTF5TNc1Qdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hN/pAJsu0htqg1nzyUA65wGuemcERU2yI4AnOMeXtkU=;
 b=fGyekUTtu731O01+ieN5FzYa7szg7fn1OvGWpSPUF6SrbTTl4JjMTRgQvHmV8HJzG1Ivr60MBFjTWeWncJdh5Gja/Gz4atgT80gWi0qm3SyrcL32V4pUTXTrc2eGtG7SJ0snEfyeplklciS7e0hg2brMLnHbpfKgcl0FX/g9BW2p8y7ZFlhgXmtccWYOG8jSoja+l8VKRmBi+i+saO6sBHpXH7CAvQghxzz5wfWse6vmpBeAj0Y+XlW0HUQau4FCah5RHVhhXUVT2QrS4cxcOmvMaJTnfX+6eaxhupv5RHGTyk6/EvFFmOXlrst9pB4KwjAKCW63iN/LL+iMPcfgXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by SEZPR03MB7958.apcprd03.prod.outlook.com (2603:1096:101:17d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 07:11:13 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 07:11:12 +0000
Message-ID: <3bcde794-c120-4a74-90b8-efbe3d61f448@amlogic.com>
Date: Wed, 6 Aug 2025 15:10:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/26] clk: amlogic: clock controllers clean-up and
 factorisation
To: Jerome Brunet <jbrunet@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250702-meson-clk-cleanup-24-v1-0-e163c9a1fc21@baylibre.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <20250702-meson-clk-cleanup-24-v1-0-e163c9a1fc21@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|SEZPR03MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: 19641189-087e-4670-7f51-08ddd4b86cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXRuSVFJWnA3aVV4amV6NlNrSVM1K3I2M2tzV2NUU0hDQnVRa0dIZ3B5ZDBQ?=
 =?utf-8?B?TFY5Q3BWd1dsWGswbDdqTDhBaDdXcGEvMitVRCs4ZHd6ZG9QaDdGbGtCb3BI?=
 =?utf-8?B?MlBzdE9xTHhwVnRDcERBVDlHcmw2OHgxWVlzSXlmdWc0NksvdG02NzNIRzI5?=
 =?utf-8?B?OVNkdFNpRWNWY0FFOHlyM0czM0FhU0NJbzhIQ3MwSnhmc2NkRU1ueDRRVGhE?=
 =?utf-8?B?NW5FQ2pERm94RGVkcGExN2JxWC8rLytOTUhoT1BKbjFNTlZtZldCUEM0RjlT?=
 =?utf-8?B?bkY1Y2NvRzdEM2xqZTJDY2xmRVAxa3k0d0ZNdzloOTk4ZG42c25zL3NGNVlm?=
 =?utf-8?B?OHFsVW9SSG5ET0RacndXN1dmTFcwTHNaVGp0dzU0M216RmNYRG5EanZ4ay9W?=
 =?utf-8?B?RVE1TWJ1elIvekN2K2ZseHZvYkpneDN4bHBYQllFaEllMzhzb25UWDNMWllO?=
 =?utf-8?B?RkllRkRDVGdSbzZGbnZDZjZsTnRFRHorUGZ2dUQxSFZrOThyQVRqM1FtTmFQ?=
 =?utf-8?B?YjNRa2J1RTRvYzhaM0hRczBvdmlySjZpbkdqTVJiS1ZURkNPUWl4a3pQK2Vz?=
 =?utf-8?B?RTVpY3NMdGYwSG0yR3VncUVBaFQ5YjA1N0VVWjBXT25kb1Zob3VxOWlnb3VF?=
 =?utf-8?B?cHhVRW1rbkV1VWlFaktrNGJUcnFESEFXNDE4cFZSRDdoSi9GSlVQVmF4QVJh?=
 =?utf-8?B?QUtDR2xXdTZoNVdkTVhEaUxxL3hSS2tyYkxZMzVSOTE0SkVPYmRFdW1aTE5h?=
 =?utf-8?B?WVArUTRTL2JoUWd5UUQxb2ZUV1hTVlROaWxWVVJ3TEFwZVp0Q1BjeW1OR2FO?=
 =?utf-8?B?alhlRitHNWhNbkdxVWJSQjhSTWVTVXJLOG9MOUdXZjZZTjZNbTVHalpQcGhX?=
 =?utf-8?B?Uk5KWjFnSm04MGRzNU5tRCt3K1lEdFU4cFpHZ0FBMUZqWXBvSENwZVltSGFP?=
 =?utf-8?B?L3h4amM4QS9RWk51RWRGbm94WGhDYW11aVpTMWs4N1ZiUDFnOU1SRjFCc1Vr?=
 =?utf-8?B?NVVUYWNVWlB6cWI3K2NpTW5mcWtSNXdqS1VEd0lQd1RaWGEvUThrZ3paT1Uv?=
 =?utf-8?B?Q2R0RER6ZTA2a3ZrcnBPNGpnTUMxVWNuZnUwWW13bEpXZzlQK2JDOU1VMGl6?=
 =?utf-8?B?L3IzSjl2bzZZMXFtaGp1RmsxSGdvTGI4RmNBTnhNdUFFZXVQUERzRjNKdEE3?=
 =?utf-8?B?NE1Na0kwd2xyNDRubWVqVHhwSHprMkNla2lWSjlzOE1ISFk2UE1aVUVRVHJW?=
 =?utf-8?B?Z0tIVjE2T09vK2JGanVVZDZJVGxESWFCbllxV2VwL3RGb29tYkV4eVlFM1kv?=
 =?utf-8?B?SzFPeXREMnVwVFhkR0hrdm5nWW43UFp5SG9CdHladjhCbFIyL1FYbGlzbmx5?=
 =?utf-8?B?WDJYdVZjSHpIOENJZDk4WFYzWHZEekx2VktyN2diUTF5dEVmbDkxMUZjOE9J?=
 =?utf-8?B?dDk3WVVuSVJ6bnBaYVBaS0RrZWJEUzVmVXNodUoyVVFLWmIxQzNqaURZNnVv?=
 =?utf-8?B?bCtGZWVNOUNpcUE5NXJ6dFBhTGIvQTAzVlNQOEt2d2xScDZyQWU5NmxsTERx?=
 =?utf-8?B?UGg4bjk0MUpkcFNzZFNrZ3Z5a24vbkU4QWpkVmVjMzZHdmtvdk5Fc3haRUdU?=
 =?utf-8?B?V3NiNlJHWmtjdGVHNlA5Uy9Ld3o4WlJLYzhVdEhtYVYzZFZveE91SFVyMm85?=
 =?utf-8?B?VW1zK0RadWRWd2o4ZWVpOVZETm81V3c0RTZJc0xkbEgwRFJVcVRXNGFWWEJ3?=
 =?utf-8?B?MVJ0aXptc052ckY1OXd1R1FWK1NjaGRxN3ZBcTE1UzNJY1FLbEdFZFU5UDRu?=
 =?utf-8?B?MHBCYytXZ0hGdXlwWWhkSVVhaVcya3dBT2syY21nR2dqa1hLTFVMUTFjbW9L?=
 =?utf-8?B?VnY4NFphbDgwVDNHNVAwMFIvdTgzUy9FTjJ6Y0txZzNzZEJhdWhQWGhTR09m?=
 =?utf-8?Q?ZLCektb/CcE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODBKaVVRZGFjN1N4Z3VyTG02Z1gxRFQzM0hjZ2NKZStjNDgzdFVzaGFpUTVW?=
 =?utf-8?B?VkFRQjM4Z2UxbDhKMTF1NGs5MFY5RFdzT1owdVFud2FmSVdWWnBxQlVoendx?=
 =?utf-8?B?dkZ2WnRWMTJ1K0lPbVBDZmN4QTAyTXNjOFB0VDZFMldyTHpITEF0Y2QwaTRS?=
 =?utf-8?B?b2w5UUloNmVwYS80VDBKYk1ucG1OYUhvejZzc1U0OUZRMlR1b0RQSzk3M09W?=
 =?utf-8?B?SmpIczN4SEZTaGxXTXZ5U0V1aTNrazV4Nkw0R1lNZTg0ZnFNaW0xbWxzemVw?=
 =?utf-8?B?cjRXeG0yTzI2eVptc1lVY3k5a1JZK0dFYjV1TFJHd3ZFek9lZFBkRmxIQ090?=
 =?utf-8?B?TU5BQzhSWGpnMU9aVDNCeUR0ZnZLQzAzN2s3YWlmOUJVN1BESTRtMjdvYnBR?=
 =?utf-8?B?cU5ORGlDSzBGNW45U3BPaDVuZDJ1UFZ5c2RWK3RnSXJZS1VibndpWmtQaXhz?=
 =?utf-8?B?QlI4UitmQmRKalhNYXlsM1dub1dFOUFqb0VQTm4yMXBDbitNaG9hZUEzbjN4?=
 =?utf-8?B?YmNWTCtTNXhYY0FvVkR3MVVUSk1OVlNPakJRWnRubTdzUDZkdkNaK1ZteGRM?=
 =?utf-8?B?T3p3Ti9oVzdBZ2MxUEFGNklON3VlQWRzVEZpUWt2QTk5WU9SbkJQdkJPYTNK?=
 =?utf-8?B?OTJFWFZkQzdWWk9Jd0tYMG1oektUNHJ4YlN1NlkzbE4vTkNIcit5aXJjbG5I?=
 =?utf-8?B?OGp6QksydFZLUkdIR2JxQ1Q5YitYSWFlVk9xaVFScHdEWUtyUXZaL2VxRUcz?=
 =?utf-8?B?aDMzcXc2YWlVbE9USml6WksyNHlIRVNwTWV5bGRNUS95S2d4bm1GeXRwd3Fy?=
 =?utf-8?B?OFhWbjd6YUZ3b1l0SDN6Y2QwM2FkVjhlR3czd3hEcjRvdHhoSHdHTUJuTUYy?=
 =?utf-8?B?LzFMc2FmRUs3cU01K082eCtlR2ZLaW1JUVB4N3ZJSXgxU1c5Mng4RGs5M2F0?=
 =?utf-8?B?UllleG5GT3p6UnRXeVNXTHR1SUVOc01pT3dqMytKMFE2ZXEza083QkZBKy9T?=
 =?utf-8?B?NSttblQxTkRsSktoVGZFWVpyNnpiY1VUNW1QYjl5bXkrR0k2ajkzMmUzZTNp?=
 =?utf-8?B?aGJWWDRac0xJK3ZQQlNVdTBaTFBnYWk0Ri94NlRMUUFwNk5oNzBLT2VhdHlE?=
 =?utf-8?B?NjU4YTh0V3EvVTVBMWdzNjlRMCtDSWZseGRnVXNVb3VMRHNRdmJsOEtyWVVw?=
 =?utf-8?B?NXZZWlN3S1ZPZm4yOVBxc0dpTUxwN3BaMHNqTDVxSi9vZmJsUTFVYWVPOE1z?=
 =?utf-8?B?b1I1enVHTHc5bEZBN1RGcVlRNW4zckxTbEdSTGV0ejB1ZU96WEdUWTF5VG83?=
 =?utf-8?B?cGpJTjdPVE9HVmF6cFBQZmZVc0VtaWY5V25XWHpHS2xQZUVJS05IWk1ZcWxq?=
 =?utf-8?B?RnE0Z1JhUExkMGdob1dNMWI5ckRySVorL0Uvd1hrZllzOCs5c1VlSkYzMXZC?=
 =?utf-8?B?NmxaMTRTMlJmZ1plWjNHcHV5U2NqY1ozRjdJd0Y5Tnd0MElnTXovUTkrMG5s?=
 =?utf-8?B?TnNhQytDMHlRbHYwMWxhcmVBU3VCRE9LMGc1dUdMdjRmTmxOSkZqb3E3OVd5?=
 =?utf-8?B?YU92Y3QzbWRZTCtybUlodkZ4OFZVenJhb28vT2xEcGpibDFTSHNFTVp3T2la?=
 =?utf-8?B?MEUvZHdzMzhNck1Oc3RYYWl1dHJBNmo0YmZqOEgzbEx3aGoxTW4zRDNjMExp?=
 =?utf-8?B?Qk9UZTlhVlc3encyc2V5YjV6N1QwTjdYNTg4aUpISnIwR2t1RXZPditUNHlH?=
 =?utf-8?B?bGlxQzdINUJFaExvSTdZaVc4UWxlMTErbXNWTUpFQ0NCb2xaajlCVjd3QVR0?=
 =?utf-8?B?QmYvTnAxTHQzS3dkR1ZKMkxPLzV3TVVEQ0pIVW1Ua1hvaS9KMC9BR3FBUDlx?=
 =?utf-8?B?K1AwbUNhR1NkNm84VVZKQ1JieUpQbStSSUtXWTVXUFhIemJ1VEN6eGtId0I2?=
 =?utf-8?B?QUdFTUIzdlJRbW9Kb0pBUjI1S3l0amtPWjA0NFEwM09qZSt0QWN5ZW95VXdm?=
 =?utf-8?B?NmEzbk9sWDJJLzNuRFVDekpmTU9FaGxUNUZhTVE4NksraFN0L04wWFMxYTVo?=
 =?utf-8?B?ZXU1NTZHWkIvY2Z1dE4xeHk0MTFHSER6WVdDeGJGYVRYVjhzKzk3dE5jcTNF?=
 =?utf-8?Q?t7sTGAc9IhcQ7DqB5Be5/Yhvn?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19641189-087e-4670-7f51-08ddd4b86cf4
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 07:11:12.7455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBsbeB+h+jAlpvvXrlSqeisjZnwhUP8/S9cEPHbnyYad54g6QdgnjvT7nry4fF99du7S02lWF93r7pM0rJWx4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7958

hi Jerome:

     Regarding this patch set, is there anything I can assist with?
For example, testing the modified chip functionalities? and we have
more clock drivers for other chips awaiting submission.


On 7/2/2025 11:25 PM, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
>
> The work on this patchset started with the submission of the Amlogic t7
> peripheral clock controller [1]. This controller is fairly similar to
> existing controllers. Once again, it redefines the peripheral clock macro,
> the probe function and composite clock helpers, even if it is almost the
> same as in other controllers. This code duplication trend has been going on
> for too long and now is the time to properly address the problem.
>
> There is clearly 4 parts in this patchset. These are sent together for v1
> to show why what the ugly first part is useful. If more versions are
> needed, the patchset will be split in 4.
>
> While all controllers are doing more or less the same things, tiny and
> often pointless differences have emerged between the controllers. This
> makes it harder to exploit SoC commonalities.
>
> The first part of this series deals with that problem and realign things
> up. There is nothing complicated going on there beside renaming. It is the
> ugly stuff, yet necessary, we have to go through to get to the interesting
> stuff afterwards. There is one change per controller for the review, with
> the intent to squash this into a single change on application.
>
> Second is the factorisation of the probe functions so those stop being
> copy/pasted in each clock controller drivers.
>
> Then the clean-up and factorisation for the PCLK macros, again to stop
> copy/paste but also the silent use CLK_IGNORE_UNUSED.
>
> Finally the introduction of macros for composite clock definitions. The
> same pattern as the for the PCLKs started to appear on s4, c3 and t7. Done
> properly, this could also help reduce the verbosity of the older
> controllers.
>
> With this, the c3-peripherals controller may be used as an example of what
> future similar controllers should look like.
>
> After this, there is still some house keeping to be done in the amlogic
> clock drivers:
> - Moving remaining reset drivers to the reset subsystem
> - Proper decoupling of clk-regmap from the clock controllers
> - Reduce verbosity of older controllers with the composite macros, where it
>    makes sense.
>
> [1]: https://lore.kernel.org/linux-clk/20250108094025.2664201-6-jian.hu@amlogic.com/
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
> Jerome Brunet (26):
>        clk: amlogic: a1-peripherals: naming consistency alignment
>        clk: amlogic: a1-pll: naming consistency alignment
>        clk: amlogic: axg-ao: naming consistency alignment
>        clk: amlogic: axg: naming consistency alignment
>        clk: amlogic: c3-peripherals: naming consistency alignment
>        clk: amlogic: c3-pll: naming consistency alignment
>        clk: amlogic: g12a-ao: naming consistency alignment
>        clk: amlogic: g12a: naming consistency alignment
>        clk: amlogic: gxbb-ao: naming consistency alignment
>        clk: amlogic: gxbb: naming consistency alignment
>        clk: amlogic: meson8b: naming consistency alignment
>        clk: amlogic: s4-peripherals: naming consistency alignment
>        clk: amlogic: s4-pll: naming consistency alignment
>        clk: amlogic: meson8-ddr: naming consistency alignment
>        clk: amlogic: drop meson-clkcee
>        clk: amlogic: add probe helper for mmio based controllers
>        clk: amlogic: use probe helper in mmio based controllers
>        clk: amlogic: aoclk: use clkc-utils syscon probe
>        clk: amlogic: move PCLK definition to clkc-utils
>        clk: amlogic: drop CLK_SET_RATE_PARENT from peripheral clocks
>        clk: amlogic: pclk explicitly use CLK_IGNORE_UNUSED
>        clk: amlogic: introduce a common pclk definition
>        clk: amlogic: use the common pclk definition
>        clk: amlogic: add composite clock helpers
>        clk: amlogic: align s4 and c3 pwm clock descriptions
>        clk: amlogic: c3-peripherals: use helper for basic composite clocks
>
>   drivers/clk/meson/Kconfig            |   13 +-
>   drivers/clk/meson/Makefile           |    1 -
>   drivers/clk/meson/a1-peripherals.c   |  995 +++++-----
>   drivers/clk/meson/a1-pll.c           |  124 +-
>   drivers/clk/meson/axg-aoclk.c        |  153 +-
>   drivers/clk/meson/axg.c              |  237 +--
>   drivers/clk/meson/c3-peripherals.c   | 2055 ++++++---------------
>   drivers/clk/meson/c3-pll.c           |  245 ++-
>   drivers/clk/meson/clk-regmap.h       |   20 -
>   drivers/clk/meson/g12a-aoclk.c       |  238 +--
>   drivers/clk/meson/g12a.c             | 3316 +++++++++++++++++-----------------
>   drivers/clk/meson/gxbb-aoclk.c       |  123 +-
>   drivers/clk/meson/gxbb.c             |  611 ++++---
>   drivers/clk/meson/meson-aoclk.c      |   32 +-
>   drivers/clk/meson/meson-aoclk.h      |    2 +-
>   drivers/clk/meson/meson-clkc-utils.c |   89 +-
>   drivers/clk/meson/meson-clkc-utils.h |   89 +
>   drivers/clk/meson/meson-eeclk.c      |   60 -
>   drivers/clk/meson/meson-eeclk.h      |   24 -
>   drivers/clk/meson/meson8-ddr.c       |   62 +-
>   drivers/clk/meson/meson8b.c          |  746 ++++----
>   drivers/clk/meson/s4-peripherals.c   | 1160 ++++--------
>   drivers/clk/meson/s4-pll.c           |   82 +-
>   23 files changed, 4437 insertions(+), 6040 deletions(-)
> ---
> base-commit: 2c37e1c671428002519e7615d786b9b692261052
> change-id: 20241211-meson-clk-cleanup-24-41cbe1924619
>
> Best regards,
> --
> Jerome
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

