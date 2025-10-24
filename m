Return-Path: <linux-kernel+bounces-868950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B9BC0691D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228531C07A2B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC31320382;
	Fri, 24 Oct 2025 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ov9aG3ob"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazolkn19013074.outbound.protection.outlook.com [52.103.46.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E84B2749C1
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.46.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761313824; cv=fail; b=nq/TQs9RimpN/5JDfGLOs6sA/CHQ+E+yGXvycBoSDJHpYzkKPkG2IQ56vrQk/33yZzMVDzmxU2tZWL0KXpGL6VO4lZ/fGffuPBCnZF5YLgOobweYYkgjqsBF/sjQvFPbyhcpm2OFb0khJ2SLYmhaDqWs258cmoLl1W4AhQ3ZRhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761313824; c=relaxed/simple;
	bh=RvT1pZXcCQZVYOxiNVNHww6OOMC5zVIDGoe+Jz1cKzo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RIbK6o4FCBLLtjBin6tgdbxB3bO82n38IwAacUq4qNuICSiu5LXCpHjOAymna3eAwe+MCAi5P7QyjgdXhvNfDODMtESDZ55pp3jGMq73UDEr611zzjQDu8ss65upB7EIqddTn+7Ywzjw4df6kNkKnMtxoxTGu8IUtJM/aJ5tawI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ov9aG3ob; arc=fail smtp.client-ip=52.103.46.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyNXsu6ilVKZd3enHnozOHVZbktVTmMH7cFGK5wYjRwSpMK31ylKCy+XFsQZbdjeFBQzvJrXxKM4GrlR4FJY6CcjWUCUjRs7ZlBVc5QDm9HHOSyJpSapFKz7sMFXRJiraiZkeeqSYE/XfI1UDQ6Mdvdxuoe31F9i7Fmam5Put4vwUZuKmQv90sGg7tL6J6wuw5t0cpTNnKfKZSl0Z8Q1XjiPuPGVjygb1JPxGsNo2/ajrfEFu1LNhLTjPkR7FNG+a+cuUALhePDSyYP5+IZ9+2XD4Ka33fJo+XOKzyUO9j7zqbHBNtxtjxUp/DPB7YiDsqKGq3io+Ev5fbmrknxWQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nT7noKjGyqw3opZTJ8R5eOHeGpvXvv/R8rys+w1+OSE=;
 b=xowOryAXVgZ9cjXPGsD6bkSNdAKGYHsKjMKr3ce06uirsX7FIjAYuIYC69/GCjHauFP/TsicKGEe2NQE5oyPRMGAQX8BadcRjhOWv7idqkvWoIK5W0lqoqUEbIC19BLP45vg5hyw4Rd4yDRurm7chc7O81CnFj8tprTN6rf+p6V2xr9lSQIk76YUxPldU1mF6hTpcBpbImnl3UhqyNBdjIdx3itj8DB2Xa0yfIObrDiQ29sFq9JH5kzltPt58gCwD/ZJBGieTE6XwzI9P/G5ZlIZZxloQS+AUsNRQK5CpNpy1QGhhJ6ZLU/aZRpk4pWSoR0w//fHJff60gf1nptoSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nT7noKjGyqw3opZTJ8R5eOHeGpvXvv/R8rys+w1+OSE=;
 b=ov9aG3obYt0ak5v/1DAYpENG5aEvuulY6/MZn4C0w2hYptXz24kq1l4fMVTbbgaP8KwFkGGIMVs1RR3BONw0eQE4Btz8fkjCGgQGdN3u5eP3CWDb6WeU8R0t1stjkPBSe2G7fkqR+3GNcHXe2CzHhzEzTcjufQOo8Qf1l8HVfKgo79OzwZg6YmQy+rVkZTY8mAwwPwIZJ4jNrtYrX6KwRXXQq6M8R70t5piTCZVUC0buhdZiOk7G8fdB7He0B2zFKic3bxszP4HCbqK40rrLMhLR/6Y9Wb5S1OX9MvwEJNV0ISsPXgNrPiY+yXqXzMMZ0fbhJiv85Dr5Bi0zzBjcIw==
Received: from VI0P195MB2739.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:2c4::5)
 by AM9P195MB0886.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Fri, 24 Oct
 2025 13:50:20 +0000
Received: from VI0P195MB2739.EURP195.PROD.OUTLOOK.COM
 ([fe80::350:3f3c:7e09:a9cc]) by VI0P195MB2739.EURP195.PROD.OUTLOOK.COM
 ([fe80::350:3f3c:7e09:a9cc%3]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 13:50:20 +0000
Message-ID:
 <VI0P195MB27396082C4B72FDCDF18E775EDF1A@VI0P195MB2739.EURP195.PROD.OUTLOOK.COM>
Date: Fri, 24 Oct 2025 16:51:00 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: Make sure CPU_ARM940T kernel can be built.
To: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, Ard Biesheuvel <ardb@kernel.org>,
 Russell King <rmk+kernel@armlinux.org.uk>, Eric Biggers
 <ebiggers@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Kees Cook <kees@kernel.org>,
 Dave Vasilevsky <dave@vasilevsky.ca>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, trivial@kernel.org
References: <VI0P195MB2739D000BD1BF18B3B718F93ED1FA@VI0P195MB2739.EURP195.PROD.OUTLOOK.COM>
 <CACRpkdZbwuf2Fgtq+jyqzqspb37-P6X4O9xqkG-mSb+afSjh3g@mail.gmail.com>
 <VI0P195MB273993B2928F985EAC763375EDE6A@VI0P195MB2739.EURP195.PROD.OUTLOOK.COM>
 <6d9bb65c-d693-4d99-8183-b605cabf9380@app.fastmail.com>
 <VI0P195MB273999EC8797270AE732D8BAEDE7A@VI0P195MB2739.EURP195.PROD.OUTLOOK.COM>
 <7d0b68d4-6798-43a5-a6ca-99807bc183c5@app.fastmail.com>
Content-Language: en-US
From: Franz-Josef Haider <fj.haider@outlook.com>
In-Reply-To: <7d0b68d4-6798-43a5-a6ca-99807bc183c5@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF00014AE3.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::316) To VI0P195MB2739.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:2c4::5)
X-Microsoft-Original-Message-ID:
 <c57bd30e-3630-4f74-8c38-4c70c3e6b661@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P195MB2739:EE_|AM9P195MB0886:EE_
X-MS-Office365-Filtering-Correlation-Id: 70457b77-decc-4e2d-c93a-08de13044555
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|6090799003|15080799012|8060799015|19110799012|5072599009|23021999003|4302099013|440099028|3412199025|40105399003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0FpRDM0cFU4VE1hVHVvMC9mTk5seDBYZEVMQ0IzbmxLK0ZIbkFtVTFaV1p3?=
 =?utf-8?B?Wk5sN3ZuaWhNUUZraTBhRWVOTm5QRnAzN01vRTBFaWdYQ21JWUJMZ2ZxQStF?=
 =?utf-8?B?ZThDS0tmdS9CS3VhRWQrYnRnanVmV2lqWjdISlE4MXdXTVVCNktXTm9vZk83?=
 =?utf-8?B?anNuVkhibDRUcWVhUkl6WmtTL2R0V1ZKT2ZZZUJ1RTdCMmxMZWZQT25EM05j?=
 =?utf-8?B?VTVLd3AwNGtqenlSR1cwSGdpRGhDaDFJMjdMUEhHc1RWRFkrTUlwMFV2eU9M?=
 =?utf-8?B?Q1lvak5TRjNXdUhPK1RUZHdNK1lYbFk5a3A1djEvUk5DWFRDbDgwZy9FVHlX?=
 =?utf-8?B?QkVsUWVsS2w4YmxCMmx1aFo2MDFwblBCNTdGbHhITExkN25rTG43Z3d1N3kz?=
 =?utf-8?B?bURQdjE2VkRhK2NzTEVERWhnNURxeGxCTDFkaVdxcXg5K2FZZ2djSDFhWmVj?=
 =?utf-8?B?SlBuR1oweDYyNHY0ZGppUFd4RWIwOGJnbWEzQnFyWm5IZ1ZMQVFGSnIyRTN6?=
 =?utf-8?B?S2ZpUE1oRHF1N1h2c0JWQkFKN2pyYk44OVZpeXZtQ1BkenR1UmdzSkZ0U0Y4?=
 =?utf-8?B?dlk4WGEwYWJtSTdDZmQ1dnJKL0htbVZLVU9WeENicmxoMlNLT3o5VGhISUZZ?=
 =?utf-8?B?clRiU2NSQXRRWE5od0Fqdmlnc0J6aHZtM2hZcjVENGhYOFlYRFhmMHQ3dzli?=
 =?utf-8?B?dDJ0blJBNzJLcXZ6QWdWcS9nNGl6VXNQU0NtZDNxa2hFRlYwNllSRFkvNHR1?=
 =?utf-8?B?eUE2dmxCaTVuZEpPSUZxSUZROXBXZ1hVUUljWE9MZ25nOHp4ejZ5M1hBbHRB?=
 =?utf-8?B?aUhpRWs0WENiSUFoK3IzTVEyeWhaS0dMMDZHd2NSSlQ2ZUEwTmpUVERQaUNJ?=
 =?utf-8?B?MjhGYjZQanJUMG40N2NTVXRtU1A3Yy9lT3ZJb3dQM0EyUzd5V250OTc1U2hF?=
 =?utf-8?B?bENyZDFiUzB4Q2NnOVlacjBSeGp1WW9yR3NsU1poYzJkSENVRStCM1NhY3BZ?=
 =?utf-8?B?SWNRT042czh1NGxmM2hVZlNiclQ5RzBBdFJocUp1RkZmNUYvTWExQ3U1cUR3?=
 =?utf-8?B?TGxGR1Iva0tNNWYwOEVoeS9zS2hEcFJBRzlQWC94dnEwdjJMQ3ZCdCtsKzdP?=
 =?utf-8?B?K2lMbkdzQ3RsZEd3a1RlYVZyRGpjVExyeHRCRTZRYTR2QkdMWittTFNJK0hU?=
 =?utf-8?B?T0FvTmFISlRQNEttMGRtUnBIZGVNWjNXV2xoc3lITWZLOVBqbnpkVTYwa2J1?=
 =?utf-8?B?Wkh5ck1qZHdHNEg5UWdxaTFVaDg1SUdFVE5rNXZMMDEvZ2VNd28rN1QrYnMx?=
 =?utf-8?B?UnR1azhxT0NnWE4zRWlYREFXci9ZdmV2ZmFuRG1Yd3pOUXhDTHU3N2ZEOGdn?=
 =?utf-8?B?SHpHUEplZFhUN2sxN3hHK2xPTURzZXRsN1JES3R6d21pQU5oWWZqRXh1WVRy?=
 =?utf-8?B?cEZBWFJnMWNMQlk0eGlKc3NlWHY1bmZzS3d1MnFPRkkvVUFaQmM5RTR4ZGk4?=
 =?utf-8?B?VTlGangrMWpUSWwrcFNuNTFrUW15aHpiOEp1QVVqRUFnMFQ2ejZQTEJnWkp1?=
 =?utf-8?B?NG44QWxpNnpPazlMQlFzOWI2Z1J5NFNEU2xnczNGZDRzVE50TXdrM0kzN0pJ?=
 =?utf-8?B?MjU0VEVnclRoSzVCQ3FRemw0dTlxVXRIUXBYNDRZVno4dVF6UlZyc0NiWVVv?=
 =?utf-8?B?QjZhMUFBRGdUK01wT3NJb0lvZm9MMitSaWFERkE5MFpLL3FlZFR6ZHBzbFVF?=
 =?utf-8?Q?/LyPWZzMnhLnx7EC08=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2lzWWFkOU1sSFd1QUxMeXFad3A5VG93MHBraDVKNWgxay9XdUpLVnVDUkVQ?=
 =?utf-8?B?NkZUYUtPaDJxY0RLcHE0OC8xaU1OMmo3R0RnaDIwdDM5QVRaMW4yclljUmI5?=
 =?utf-8?B?VGdxWStQcGxDSGdiVlRTVFBVc3JpU3h2aDVUZ2ptWFVHQ3VkaE1USFVvb3hB?=
 =?utf-8?B?eUVKZERQSWMzVDJYc29tZjFpRmIzNHJIOU80TDllNXFBZCsxUmRJVWZEc2Y0?=
 =?utf-8?B?cjZTVE1hSGhIOU5DcWNpb1UveXhjS2JFL1ZDQW1ta3A2dWhZWHB6R2NFc21i?=
 =?utf-8?B?Q3Y4U25nS0ZrMTlNamNDSGpQSTlmT3lQOVhpb2tkZHlPWlFpWmdYcjNwS1ZU?=
 =?utf-8?B?MHF5aXg2Y1Bqd2VWdU5ZanMwMUtqMGk3SnNZazFHdmxlQTVuK1pRTWJsMkY5?=
 =?utf-8?B?SFlBR21MMU9ESkhINUJaa1k1U2d5a3orNmM3U2V0TmN4NE9uNUFHWDFQQzJY?=
 =?utf-8?B?bTRqWFJDNDVIcEkxazBkVGlEZUtvaWk4bWEreEpnejVMeFRycE5XU1dGZ3pX?=
 =?utf-8?B?andITXhrbGc0dmNhVFNTamZIdFRjRytOOTA5amx4V1FQc0dvVVZFRjhGL2Jp?=
 =?utf-8?B?aTQ2YTQyUXMwUWJaTUZuL0pXM1d1Y0lUMFJ2aGRsR0JHVzNCK3NMbWpKcnls?=
 =?utf-8?B?ZUlYa3E2d01BenkraUVackhidW14eFhINWRoRHRjeUMxcHdZRXJ6OTNFa3hR?=
 =?utf-8?B?KzJJZE92N0VNdkQvemZrYktJQUxodENjR0kwZ3BDY1BiLzlCSUJ4Z3pNNTlj?=
 =?utf-8?B?UHdPSG1JY1V3bU5YZkFnUHB4N3h1Z211eTd3NExqNnNFYmpBQlREVnBSS2hz?=
 =?utf-8?B?SkNuUjZlTTBQWlNDNDJ5Wm12Z0VGdDBKaVBvU2g5L1JsenR4SDZDR0tmS29v?=
 =?utf-8?B?Ylh0Sit5SlBXRjRhaDBIQWcydDE0dklTemFRZVI4M0lDeEhkOU9TaTZNMlRS?=
 =?utf-8?B?TlhHN0wvWkY1Qng1RUVCVWFFUWdheVh4anVLdlBjWkxMYXllMnpyYjB4M3pE?=
 =?utf-8?B?QTE1NlhNcjB4dFRTcEdSRmg5cmxJL0I3Z092amc1QU5tbW5jZmZwQU9DQTNC?=
 =?utf-8?B?Q0crRFB3a1hqall5QkswbWRtZWI3WDBOY2t4SXpJSFZ6UE5uTGhnSHo1MnBR?=
 =?utf-8?B?SWQ2NjRLRFBBcWVuVnBwMlMwSU00dWRXV1JHMWJkRUc5a2dYK0k3MytvWTB3?=
 =?utf-8?B?Zmt0bEU3R25pR2psRjgzTDAzZnltL3ZaejR5V0JLcThqVHViaW1yUitNbG1X?=
 =?utf-8?B?WjRSdXRaRWdlMlNnT1ZxeUtKVUdKWml5MUEwZ2o5SWJXb1RUdmdMVnBaaFVs?=
 =?utf-8?B?Y21WZW5oV3BYUW13NEN5YmJlVWRtdmF4d3dORjUyVVQvWU5KMHJYcW5XWlMy?=
 =?utf-8?B?K1FvQXJ3L2lZTzYxUWRxV29lMS94dThMcUc5Z2JINi9aOXpWSUQwTmo0clRD?=
 =?utf-8?B?dVorSDFJeGJnS1E3SWFjM3hOY3FWamVOWmtKYmN6S1NtdTlhWkNmNzl4N3Z6?=
 =?utf-8?B?aHZRcWEzTHZXRytSZ2p0U094eTB6bk1lT1NKenBFWTNVcnVyZUNjZDNlM1hB?=
 =?utf-8?B?MTlzZVBjNGN3Y0tMSVZQcGVzbTFDbG1Cdm5JWEw0djh5dVM3MitHYWMzOVRa?=
 =?utf-8?B?R01PRkJyVXlrTklGaXlBdXJ5OG83WkZJZS81WVhSOEZlZ25ZbEpEWlY3WHMy?=
 =?utf-8?Q?8AFLNBtbYNmaYCwrK3tR?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70457b77-decc-4e2d-c93a-08de13044555
X-MS-Exchange-CrossTenant-AuthSource: VI0P195MB2739.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 13:50:19.9951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB0886

On 10/3/25 02:02, Arnd Bergmann wrote:
> On Thu, Oct 2, 2025, at 17:34, Franz-Josef Haider wrote:
>> On 10/1/25 23:52, Arnd Bergmann wrote:
>>
>> Ok if the support for ARMv4T NOMMU has been removed, then maybe we can 
>> leave this as resolved.
>>
>> It's actually just for a hobby project, nothing important. I just 
>> thought these two patches might be helpful to other people who 
>> encounter a similar issue on similar cpus, but if the support for 
>> ARMv4T NOMMU has been dropped then there is no point maybe.
>>
>> Here are the patches for 6.2 in any case but it's very much a hacky 
>> WIP, and there is some stuff in there that's not needed anymore on top 
>> of later commits. https://github.com/krnlyng/linux-ipod/commits/n2g-wip
>> I also have a version on top of a recent (~29 SEPT 2025) commit locally 
>> if that is interesting too.
> 
> Looking at your tree, I find that the ARMv4T NOMMU support is not
> even that bad to put back, especially since commit 84fc86360623
> ("ARM: make ARCH_MULTIPLATFORM user-visible") made it possible to
> add a 'depends on !ARCH_MULTIPLATFORM' in the platform specific
> code.
> 
> I still think that this specific oneline patch is not helpful,
> but the other one you sent is technically still a correct fix
> and we should either merge that or drop the remnants of the
> ARM740T/940T/946E code now that we know it's broken.
> 
> Similarly, the later ARM1176 based code that you based your
> patches on does look worth cleaning up and merging if there are
> still users.
> 
> For the specific s5l870x (arm940) SoC support, I see what you
> mean with missing cleanups, but more importantly I think that
> we will want to drop nommu support from arch/arm/ in a few years
> as the remaining users all tend to fall into a similar class
> as yours where the developers work on them for the fun of it
> but without anyone else depending on it to run on the latest
> kernels. Since there is a significant cost in continuing to
> test and fix the special cases for nommu support overall, I
> would prefer to draw the line at S5L8720 support and not merge
> S5L8702 or earlier.
> 
>       Arnd

Ok, I think it would make sense to merge the other patch just for correctness sake or drop the ARM940T code entirely, but ofc it's not my decision to make.
I will ask the person who did the S5L8720 parts whether they want to cleanup&upstream the changes (I only did the S5L8702 parts).

Thanks and best regards,
Franz-Josef

