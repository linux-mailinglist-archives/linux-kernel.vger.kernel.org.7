Return-Path: <linux-kernel+bounces-623518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B82A9F6E5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 19:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B43455A59B1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 17:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A7522423C;
	Mon, 28 Apr 2025 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="PnBod3Du"
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010000.outbound.protection.outlook.com [52.103.67.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147C22566DC;
	Mon, 28 Apr 2025 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745860113; cv=fail; b=atdItPGj8lUGWRgAd3w4J5qaybfi9XVCfuQl0U1qVLBRnPDR5MAu9TMvT1waN5AjdvbWkKPJLvPPPzdf6hQaUxEOsQa57lSvjYIscZ1oseia3DBTQdF/bz0arP87zBOynkTsa4pwecwJPqN26oTtClI/TfPRtO+RwIK3DScYB5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745860113; c=relaxed/simple;
	bh=nvT4VZjXuRhCUJcOezI2CJChhLS81vZr5zBQ6rz/Kws=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O4TcWZhvW943OwSLRY3dRV0n8HqOqPKvfzs+hSUY65p+QB9LRtTcOPJwwBkFWCo4yFzBHGHggA5CfLpDxEunWpDJgKNMG7ovHYfRRumptF1GhtBQ5xIrshOS+HrkvH5QY5NXqJYorYw5WkX5r3NXpUdVrLsbQcM4RZut+tQzMQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=PnBod3Du; arc=fail smtp.client-ip=52.103.67.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZyzgySQxgCQx5VkorQ3I/4h8W0ah4FR+u/PTCFkuFwp4lEqYDSJY8pORvoYHAJrw8XeaGSrUxjBZ3mwbfyq3lDl3AJTCsfKJJgYJEoA/QlbHQdsK9KA+XTD5aIwhGMYRAIX85F0TZzCEI7Sa/s1soznxbVVyUoQt8cwx2bT/S78xjvZAgg06Z5gvBvoDFJ23Bpy9PambiNtgOzInGaxbVC7CspIibBwGifgsPZWtZtFJKJJj0xAu68IiEjUbqyb4/Yu2uCahtlhWneyUS/Q1QJn/muIk2cO31473de57AONgGOQqEr+D1L8sfFaRdfoy4b208C15AwC08M6ZvwHrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeWY6Av5aM/IDfux21j+h9bWvJjsx2epBDyxhpvA8mA=;
 b=IuQTDec3OMk4WktGb7yiWr/MgJOBJLP3S7ffN+zflzllXYW2y78YlzJiGEEEALJb/iuZgn51qJAEX95qCL75zLTab51OcDnoKEiWs7+ZeS78vSX8uRMCrik05Sh1PhQp3wC8LzyYK30S33CEO+6wfG6pDQEidBWKL7JT1OqlFNJWhR8QsTrR8TDZ9cJxcOF4nOv9UAjupcHpvEn2Ey3D8G7RB85ijM8D1fQBku4+NTID/ntFZKvI+OAKHEtwuGuD6zJuxcfZP/5UScTnIh5R34mOegazF9PhEtytYS5Oa3jwaZCuGAWbEPZPbaC2djDMuLy7tgOcyRIyWFgmaqWA7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeWY6Av5aM/IDfux21j+h9bWvJjsx2epBDyxhpvA8mA=;
 b=PnBod3DuBh9hk37n8P/DQNDiTfhfNBLTM0srHK4YjtDqETdNhftDhbVTxrb9YJkyZnUEm6jDS4/6WRXaWT8g1ceOENe8pYGxnzy17KNK9I0sYoqESLuiWW5PgxciwIDTOeDllaU6fYqZCtiNbk56VO5VW4eV9ElGTsOrC3PwdpoNX9Fu0I3kuvuiKxe9Fsknzd95R4HmP6aBbt8QaA0tx5PZzR0ppack2Mw+cflMvrSlOmICFrB6rA/QXhFd7zRP1npS90TeNtKIgaCsb3buEFGCMJ4XQ5CZvzBaJdYfEqZ8XElilp9bPrfiIpsaXu+k9G4X/VbrdUI9cNbJ070JgQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB9528.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:109::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 17:08:21 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 17:08:21 +0000
Message-ID:
 <PN3PR01MB959715E4B4C95911A60ED075B8812@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 28 Apr 2025 22:38:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vsprintf: Use %p4chR instead of %p4cn for reading data in
 reversed host ordering
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>, Petr Mladek <pmladek@suse.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sven Peter <sven@svenpeter.dev>, Thomas Zimmermann <tzimmermann@suse.de>,
 Aun-Ali Zaidi <admin@kodeit.net>, Maxime Ripard <mripard@kernel.org>,
 airlied@redhat.com, Simona Vetter <simona@ffwll.ch>,
 Steven Rostedt <rostedt@goodmis.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
 lukas.bulwahn@gmail.com, Kees Cook <kees@kernel.org>, tamird@gmail.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 Hector Martin <marcan@marcan.st>,
 Asahi Linux Mailing List <asahi@lists.linux.dev>,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <20250428123132.578771-1-pmladek@suse.com>
 <aA-0MuLxVTueDAhm@blossom>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <aA-0MuLxVTueDAhm@blossom>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PEPF00000186.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::4c) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <cdfdb58b-4946-412e-ab9e-98ca82163184@live.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN0PR01MB9528:EE_
X-MS-Office365-Filtering-Correlation-Id: 4af50e44-276f-427b-1e5a-08dd86774778
X-MS-Exchange-SLBlob-MailProps:
	/UmSaZDmfYAf5TnZFQyEFYQ62+HWCaboeO3Oz2wqxceGUn6yYxZtpAfOBCDk03waDttwx3P96NG63dAhvnlAIwkOXyugrNLf13+4JjLtHgUL2NuzDQ55pxkVS/l55Eg6yQ6hVwO8za8b+KtuAx6OBW4xu5XeMORwV1NQHDUYqYrCKNmNjIZp7qVDLBaGB1kNVtU9NXm+WaUDS6m6PsCzP/jAWDM+ww+Bi450MH5gYu9qTrd3dt3bZ7QC1uxR/J9YzmK+Y9nBd/yTSZibf8U6S4xOZ2GqtCiNcnL+wzUeGhuh2evJZUNA0uFCOPBUUyanPVif4I+HMdayfdq7heKbivimSSNv4NZUQLo8/z+NKsWD2A+a2zJ/YzqhI4TCao3dWvMSOZlwf9roLk8GWG/xkIh2/P+e+o9j7vLBqEoGjoxlUGxxFPKEsqCk5VvhU7slEvrR+teDmUGsdsX5p75/ebtZ1b0GwAQtkaSMPxuIFVVc6VuVjAgnR5oXqTsKWzkNgJ6jBSLaYIHt1gHS56PPzYPcvSGNVWnRCVq85Ew9isg8+t3qRn94rtobcZZ8cmiX6BeUYaMO3MBgsxZ3QzyOVVPLHXQJWpEOii3Wms02vRIJgJLuSgVkpz/Qet0fYkwYLYlSXfyDDcFEoMMQ1yeOdluUKd4VWKEisRRryhh/o5z4LQZCCJnNsswCNGehFcLzvlvgc6aPqy4h1opme6jt28GZeBBR0r02etEmifbUGSlLY6zNublAPU/zUY0sRvHhHbk9xhf4AErIoNvlgz6get4dagntnCfnVv0WnT+gYhjXdkZHd/JP0EDr6h+JeV3oS/r0Hedig3ftT2WSzZp/DQ==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|15080799006|19110799003|7092599003|6090799003|5072599009|461199028|1602099012|10035399004|4302099013|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWtzb2s1a2RCbUI1dDMzYjJ6dHFmVm15bjJvTXBCTHFyMWlWZmFzZ3pLbkds?=
 =?utf-8?B?em95enY2aFhSS2w3R1lYOUUxM2Y0QjJTK3VRTHNBRTgxWkFiZEFKek8vekkr?=
 =?utf-8?B?QUhlbU9uZGJyS3V5bDNva295RmJ4S0Rjam4xRkdaTmt3ZnJrdTdvQ0dFQmUr?=
 =?utf-8?B?M0tsbWx1ZFI2eVBma0FKRVpDVFo0UkhlSGVZV1R4M1lZUVlPWkJMUGJWK0t0?=
 =?utf-8?B?dTlaTnlESUd6NWlLSEpRZWxNWHU1czB6WEtXNE1SSk44VzFkNm5qTjJFSWQx?=
 =?utf-8?B?cFRYTXluTVdpU1lQaDhZWDZnSkx3b0hNZlNyUm14d2xrejZZby8yTzcxdW9C?=
 =?utf-8?B?VmUvNlFNcWo3cmFTUTRnZHhpVzlnM2tvZ3pMbUJrcC9lVTJRck15SWlSazlp?=
 =?utf-8?B?T0EzM3NBS2tPKzRWdnhoZW5pSFQzdWkxQjJTV3lWOVhHaWVha0huZ1pacUM1?=
 =?utf-8?B?V0Eza0NxZ1QyT1FnQjNYOHluQ1ZjT0hNaW5qK2IxMkNKL1FxdFcveVZ2STdT?=
 =?utf-8?B?bG9CS0Y2SlhxcTl0VmtmLytQS2RXcG9MZ0xiaVJTR1BPTDUvd1VrL0tNT0tD?=
 =?utf-8?B?a3BaVVlUc3RFd2hqZmloenhJRjZXeWMxTFZzZnN1UmsrbkFkamJuRkxhaFdk?=
 =?utf-8?B?eXZaMWpoUjdFMGs2My9RaFNWc25WaWU1Wk9DSnJxOFFSbFJWSnNVSDFPcUVn?=
 =?utf-8?B?dDkzWFF4UUpIMExTZlB1TW1PRzBISjh6SHNBZTNsUnkvRnZnNEk1M3BueGxM?=
 =?utf-8?B?dDRPVGZqeXMvLzFJeld4VjIzbGY3NHJKZm5uNjhybjdjRVdpbXFEVC9NUU05?=
 =?utf-8?B?cURwa0NQTHEvU3pkaVpHZjFKZnZrazljZmNtOWNXVk1tTjdYTklVSEdRM29O?=
 =?utf-8?B?b2xGZGU1VjRjV0g5QWJUQUJmZVQyaWkwcUdZckZ4bStBMFMydERtWmlWaHBX?=
 =?utf-8?B?OWtGUmRndERQaXBIU01hQkFNazZmMEJZelJHOVFIVGhRS3RISUdteDVVQUJn?=
 =?utf-8?B?cG5NTTFBN2lYR2RQUk9XbG5ja0t1R0EwcWxEYnNETlZ5N0FMU2YvTGt0N01E?=
 =?utf-8?B?NlMvVXNQbW5XbXJzMzVMMU96UjgxMk9CdFNuY3o2TzYySFoxUisxNTRiQTA4?=
 =?utf-8?B?b3pGektMZjR1UzJnNTMwd3JmZy9KcTh2TWlOeXVKRTRuQk1pZEZQVWxFWWdq?=
 =?utf-8?B?aGdndTBZeVZNNlBxU3FHTDZvaG5RYndVUE5qc3oyRGJURk8wZDlUMCtOZE9B?=
 =?utf-8?B?QTFWdFhGRW9QQ1BPSWp2KytWem51QWo0c1dWSHRESWhvNVp6ZTM3MHBRNjVz?=
 =?utf-8?B?WFVsL3ZaaHhYQWJqbWwyeVNnVkRPaENRSndnck5KL1piTFU1dHJmcEFUQk44?=
 =?utf-8?B?bTEvb2ZxNmRXUC9qbms2OHdieURjSU9vSW5pNlIxSlE4WFM2TERiWlJMM0lU?=
 =?utf-8?B?WG9Vc3dkR0lmcUk4aElwUWxpK0oxQjNWSGo4cXRrZmRlWVp2YWNZcnd4cTZU?=
 =?utf-8?B?VnUzTG9aM0RzaFFwR1N0OG14K0dqWkRYRHBoQ2xsMVhGRks2UDIzV3o4RkdY?=
 =?utf-8?B?MWVNOGFaeVVrTThJZlFEUjJDbmRnR3RjOWRwY05aVVZHUGk2a2MzMmxHYTNk?=
 =?utf-8?B?VnV4Z3hIcmZOTXNPNFRSVG0xa0tJQ3VvUDRNTzB2bFdxZ3o0TTh0VzcyaG9z?=
 =?utf-8?B?bFJBczNCNDhYMndSSnBQRGRHemVLRnVzNXVLVjFxanVUNlY0WGFLREJ0R2hr?=
 =?utf-8?Q?mE8Wm24899I/P8Q6oo=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vy9vdS8rVER4N0pLOHJObTZTNytFNW9RQ0tUUXVrYUszeVRjZjhhaXBrWmNt?=
 =?utf-8?B?QTFpaVZxdlRJR2ZPZXZ0RWJJN1ZSUlBzQWRkU0o4T1BqbDFkcThEc2l4dVZq?=
 =?utf-8?B?L2ZaVy9GaENOYVEramNONWZCTmVkTlV6MmRFSS9IQW5WRVdSRXJJcDczeWJu?=
 =?utf-8?B?TTMwa2JvUXFLT1ZQbzdJNHhWV2xRQ21pSmluUENRTGRBcGE3VlBuTVZhVE1G?=
 =?utf-8?B?ck5MeDAxYUYvMzYza2pNREJtYWRQL0h1V3dKWk1td2QyNDdkaXF4K0h1T29x?=
 =?utf-8?B?RTVMWmNWb05vY3NvQXZtaHlpR2JHRFlnZXJIWXBha05BN2NpSEg0YmZLVm9R?=
 =?utf-8?B?UEpGbGxRQ2JESkJ6VmNMeE5pNG5uTVJDQi9VNEM2amlaNmp4K2NhV2NGdWJz?=
 =?utf-8?B?STA2M3I1VHFENkFvZHl1V0hOWDNCcENGN01FSG5td1BMNVc5WDFzNXdGcGd5?=
 =?utf-8?B?SUwwa2E5Yk5lTEJvZysvRWtZK0ppK0p2VkhvWURJakkyVXFnNXZZSkVqbFBi?=
 =?utf-8?B?bW9wMHo4SFJSeGx6cDUxeUVSRmlVeWhLWGViRmRIY0xDcjYyUUpiQWdONEhB?=
 =?utf-8?B?RXQ4SlhwY24yZ2ZHcERTR1hSb2hncDNpQ1Q1aVpKdjR1MVJiUEZacE0zRFpQ?=
 =?utf-8?B?V0ZyTksyUUxGZUZ6VzBYejlJTzJVN1YrZlNINHJEWS9WMFJoYXNGZzFlTDZt?=
 =?utf-8?B?ODJPYTlaRGtrVmgxbkVKeUpvRXhCTzZIMFJDcVpya2dYNUpzRWhwZ25ZUDNS?=
 =?utf-8?B?bCs4RkpJcTNuQUR6cExjQmczcGVOL0tHcGVmQWJHejVSc3BQMVJrNlpPMkM3?=
 =?utf-8?B?OXBxQlQ2TVNPSUI3U1c0VWlTai9kWEwxbzA1OXVrSmYyemRzNUthQWpNc1FE?=
 =?utf-8?B?OTB3NEp5VkgvbEUvQjRQQ29wL2NYVG9teUxMMm5ZSlJQdCs4UjdXNDgrRHBr?=
 =?utf-8?B?UzV5RUh5VUxwTmtYVkRheWVpQWZTNmhqd0d5cHh4RXFvdzEwQ2pZVjFaeHlK?=
 =?utf-8?B?WmdIbVpMU2NQb05sS2o1NDkzeGZNWlY3YitENlBVYTdDMEkvY3hGTXhTTXhR?=
 =?utf-8?B?clpmaGtSc0JqZm85Z0wyenFUM21mL3orbm55TEU0UXZtc3BOTWhOaVZmeWJx?=
 =?utf-8?B?Kzg3N0Fjb1ZNQ0phRmF1YUowL2hEWVFsNTZSQm1vU2pDMnRrc3Z6VHRBWTdB?=
 =?utf-8?B?VlJpbFJ5V2szcXJ2WlVSeWhFczVhVVV6VXVGU0lsdW9ZUXFvZmFtN1RWWFFw?=
 =?utf-8?B?OGxicDZ2V2FzQnNid1pzaytJdkUvRXZXMS9NWW9WREJxM3RGbFMxems5UlQx?=
 =?utf-8?B?dStTMUNwTEpDS24wajAwOHB2ZzhxQkViWW1oY1VMNE1ZSnlNdjQvZUp2NGpP?=
 =?utf-8?B?TndNYWZFT3BqRmdsQU40Y3E1Y3JNMXVGYnN6cDk5cTJUYW1UeFhXMUdIK29N?=
 =?utf-8?B?OVY0UTJNanBqVUNUN2tkam5DZ09CMUtUcFRnVWRPeWNnRkgzN01KOUt1d1Y1?=
 =?utf-8?B?RWJZSXhzcDZOczBKVGV4bTVVQ2FYdG5Qb1cvOXRObkZOQWtwT0lTSGovcXl1?=
 =?utf-8?B?cUo4Q2hBeWNWOU1OckRPc0twY0M3ZW50bDIwRTVzbTNtb09UeVZsQVoxemtF?=
 =?utf-8?B?Wk9rcVoySmw5dnNGeDZNRS90M3BFL1BCbEJRQkFpOXd0L0FPWE1qclRwbTBi?=
 =?utf-8?B?bUtKZitFM2tLQlNseGswMWcvNXU2M3UyYTloTlVveFpKaVhHeG1VWjlVY21E?=
 =?utf-8?Q?yXiWKPZjyklId+RZQgM+3Mhm3mANCeVNLbWR/TT?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af50e44-276f-427b-1e5a-08dd86774778
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 17:08:21.7353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9528



On 28-04-2025 10:30 pm, Alyssa Rosenzweig wrote:
> Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> 
> Since the other patches went thru drm-misc-next, I guess this should
> too?

I think yes.
> 
> 
> Le Mon , Apr 28, 2025 at 02:31:32PM +0200, Petr Mladek a écrit :
>> The generic FourCC format always prints the data using the big endian
>> order. It is generic because it allows to read the data using a custom
>> ordering.
>>
>> The current code uses "n" for reading data in the reverse host ordering.
>> It makes the 4 variants [hnbl] consistent with the generic printing
>> of IPv4 addresses.
>>
>> Unfortunately, it creates confusion on big endian systems. For example,
>> it shows the data &(u32)0x67503030 as
>>
>> 	%p4cn	00Pg (0x30305067)
>>
>> But people expect that the ordering stays the same. The network ordering
>> is a big-endian ordering.
>>
>> The problem is that the semantic is not the same. The modifiers affect
>> the output ordering of IPv4 addresses while they affect the reading order
>> in case of FourCC code.
>>
>> Avoid the confusion by replacing the "n" modifier with "hR", aka
>> reverse host ordering. It is inspired by the existing %p[mM]R printf
>> format.
>>
>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Closes: https://lore.kernel.org/r/CAMuHMdV9tX=TG7E_CrSF=2PY206tXf+_yYRuacG48EWEtJLo-Q@mail.gmail.com
>> Signed-off-by: Petr Mladek <pmladek@suse.com>
>> ---
>> Hi,
>>
>> I am sending this as a proper patch. It would be nice to queue it
>> together with the other patches adding the generic printf modifiers.

Atleast thats what this says.

