Return-Path: <linux-kernel+bounces-591443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03908A7DFE8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 15:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB9F3ACE1F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 13:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A38C1865E5;
	Mon,  7 Apr 2025 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="P1HxDA+a"
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010005.outbound.protection.outlook.com [52.103.68.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE8B15C158;
	Mon,  7 Apr 2025 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744033375; cv=fail; b=NWTO0J6SKOdMPB8rRuU9ghILa5c/LLJp1/+r7oEGH0hyI/9hS0M1ys7UWwcnndXX/MIF9c6t/aYjYdLERwlmhl8GzJtGzVuEmtu+kutkxdan0zdVs46XNf5Tqtg/Ot7aJaXiLNeUV89dVWlVO5vFUHcVoN0C5YpA50+79d1yVbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744033375; c=relaxed/simple;
	bh=qrGcaIhi7mvKFVw57J7DpZY5Mrkt0PQm/7lIpEaZVfg=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jBsmA0TVQiRnsTb2mdamwPHN4gFpcCTU5rHQo2yVLVo1QJkjrDWcqzNQpiFVvcM4KXRHAnl3OSJ39Puu0HRO7ho9QEK09TBQYGM6RHixvcCb7t7n537G4nL9ivgQTODcuSasDVi5LUrFCXLc8smioMvlr+XPWEX6/rsramI+6IM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=P1HxDA+a; arc=fail smtp.client-ip=52.103.68.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1JdZCwtL5D+ozV1W+P023Yl3UWWaqIj9OSlz+D1sM3BsM/sfUsrpoLGWCgyL5tK6DtRz3M527CcM0lP2NCFpBDQYvzsrlVrIXONOt69C3qbOy2T15sddct51F45HptrjkVQ4P57Itrxx3bQyNZU1uktdafUcp1qUBq8Fwx/xNO21aPJr7PIn9MBOjr+2dBsCZSFab2HwGMfPp+5rTLErnxgWHWWQFedSvXppvEDRVs9u7qQt31QMYUBnryRD+BKMVCOE0WYk53ySPS0Vr6AkDAEZjBHuUGcNZ1hcj9XeCu37EcE7odJ1zUbMcSqBDY0bmHebESiKcmfMiHpELwAQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzgGQooTF18u66Jb2F6ePpNExjffIU5jJORuFHVjyRo=;
 b=bfj33swozHMyW5gIAu65qyQLOEtIIKB+ouz0jot1wpUys57ckshjnIrADyrIxxACt/FjRL79YcceqVcVd1X89tPK2dU79Kge7SIzpKxbb/h7Gm/m/SHM8durksPUufEBNYW2m2Tnfc/6rlQGv2Jotohky8HzpPGSFGridG02jW6tWfR7rlG6noBtkHPWy5wlZDqJjfOuvFh89WtWQDFAdGkLsHVKmwXjY1jW9/TVqt9/wPmDJx6YZlOnDzLtnCNMrtEIJ4VBb4UidBtmT3BNkYu9c4Ea8bAF4bm8uEducmZ33ACG6zwKx86FNeTghQjSg7NT/Rh0OEXfsPKEC876kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzgGQooTF18u66Jb2F6ePpNExjffIU5jJORuFHVjyRo=;
 b=P1HxDA+aD/hSugFZyl+FKNf1o3GjfBhhKeRavFTjXXK9CUicaARex/30JrCtz7NO+jNciTthKWGYZ6kiMHnMNTgZh4jsl7Qm8XQdJpUBTJO9J7a7R6beoKKP9lf3rcj1IXZmV5KAgi0J/tOUkzc0/PuSqxlR2NO3RPldemJjWgPzJSw3cydFmw07N9aMsHTvrmUOUZYzxooIXDRMoubQqrN3iY+AyW0onKzkaPX778EjsZjGGJntbT0vNU8F7XHd1e1SQFAU6OfXNCCizPikEIwyZkzY93FawUpWtQuCWxtC7pnSHIBgGNIA0ydY8iPA9u+d0hnYGzGFcbRGhD36uA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB7332.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 13:42:44 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 13:42:44 +0000
Message-ID:
 <PN3PR01MB959799C9C343A7F08E04158BB8AA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 7 Apr 2025 19:12:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] printf: add tests for generic FourCCs
From: Aditya Garg <gargaditya08@live.com>
To: alyssa@rosenzweig.io, Petr Mladek <pmladek@suse.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sven Peter <sven@svenpeter.dev>, Thomas Zimmermann <tzimmermann@suse.de>,
 Aun-Ali Zaidi <admin@kodeit.net>, Maxime Ripard <mripard@kernel.org>,
 airlied@redhat.com, Simona Vetter <simona@ffwll.ch>,
 Steven Rostedt <rostedt@goodmis.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
 lukas.bulwahn@gmail.com, Kees Cook <kees@kernel.org>, tamird@gmail.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 Hector Martin <marcan@marcan.st>,
 Asahi Linux Mailing List <asahi@lists.linux.dev>
References: <8153cb02-d8f1-4e59-b2d5-0dfdde7a832e@live.com>
 <PN3PR01MB9597E8833F0DCE0C7C360135B8AA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <PN3PR01MB9597E8833F0DCE0C7C360135B8AA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::24) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <a99ada5f-327d-4af1-b61a-9afa765ebb72@live.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: fdbeee0f-f6fa-471d-1680-08dd75da12ee
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|5072599009|8060799006|15080799006|7092599003|19110799003|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V09RQnNhR0l5TUtweXJjQ0orZGgxSTl1d210YXo3N3ViOFREaTVTbzBhaTY5?=
 =?utf-8?B?Z2lLS0JkV1E5cUFtdHpuamMzaFVHdUNvV2M3Z1dGd2FDYUU4WWh1OCtIVnNR?=
 =?utf-8?B?UHpHMGtvL3R4TStBN2NKYURCQzNJdVpCelFNeTJ2ZHR0eHR5WkdhQ25rekg2?=
 =?utf-8?B?ekYyUHlWdThCQXdmaVZxaDl5em5zU1g5aXhLM1ZLS1NpVEQyWk1iaXBRTlkx?=
 =?utf-8?B?UXUvWTBlYXEwTTJVa1hUa2x1d3FYNzQxc25VUitvMDJMMzh5aDNlMk5Na1hE?=
 =?utf-8?B?RGthUjRvd1k5L0l1RWUvbjBoNytsWXZEU0JIa052RUZiemxxb3JsQWYvaDNy?=
 =?utf-8?B?bmVuT2grZUJ1Vk93ajNjQlNwckJ1WnNZTVBycHhMaEtaZW1SQ3hPcnplRkJt?=
 =?utf-8?B?azZSaWtIeDEvY2VSYURmUlhMUHhKcm5rU3NzVTZqZm9UZEM3RzlZM1ROYmFB?=
 =?utf-8?B?eFkybGZQMUhZUlhTWDRHUWhyZE8xQUYvV2JoMHduL1Y0Z0pacmV4R2lGbnJB?=
 =?utf-8?B?ZU13V0s4M3RzMThvc05KQXZsSUE0UEphaVZUYXlTOVAwVk91NnlyNzRRbEg1?=
 =?utf-8?B?MkFLMjhiUG90OFlyVmQ2SDZPMTViUERsb2dIaEtVWXRiRHEzNkZsenZhdjJk?=
 =?utf-8?B?ZHdLbnlVTFF1VERYeVpUaVF2cnIwa3hqbEQ2UXY0L3g3ZlBqUVlTODZOenhl?=
 =?utf-8?B?ay8ydzZkaXhIUmwyVVNBNlQzMWVHbDJSWVhMVUZTanlLcFZISkJtK0oxVzhF?=
 =?utf-8?B?cE5ldnIvYkFLbDA0NGIxUUpaaC80OHExY0xROXlXUGttUGpGZ1lGYkg0Mk1G?=
 =?utf-8?B?K0JEWmk3WkhpN0gzcFZNNjBINUN1NzhhYW9tczZOTTJsTkpvS010NHR5cTBZ?=
 =?utf-8?B?WTloNU92QnFMekY4V3pCUVFWaUI0NHFlNnUzMWJlVXNsVjZzeE1ibzBkUy9N?=
 =?utf-8?B?Z0pnNEFGbDg3NzVIcWhXMmlGN0VIYS9FM1RUM0ZEREhnamFZRTkzWWZmTVJB?=
 =?utf-8?B?cFhnMnJla083UjBxeG9IUDhNTStQUkowMFN1QkdxeGx3UEhhWUFaWmN4Qm1M?=
 =?utf-8?B?b2ttb09yZGVOUWV0c3lqQkZEOTVscUlBMXkxdkZKcjllcERCQ0Rwd2xaenJN?=
 =?utf-8?B?cytaVkFoQWNtd3p0OUhPWTlXMDVxNTFscXJKOWlKcnJaQlkwakJ6cDFqaTdT?=
 =?utf-8?B?enQ4akFPdFgzS3ovRmNzSTk2bnVQZDRZaGFlVS9EWHJUZTBhZElDSytnQUZN?=
 =?utf-8?B?Tkh2NmhQQ0wzVi96U0laQWtGWnpyN2FTYXVyVHZyN0VMc3BTV1gyUzNTcnda?=
 =?utf-8?B?d3pUclI5Y3VSS0JCc1pkWW1XbXdSUVNGbW13UUZyd3FCVE14YVZuNWVscWVU?=
 =?utf-8?B?OEp4NURNc3dFTC9lelFPRUZiOFZreTRPdzlWR05EclplU2ZKeGVqR3gzSVda?=
 =?utf-8?B?djFTaDlXL2xvbXlzMy95a3hJbjlHaTBMMkZzS1ZwZGpQOXE2eEh3bndVRHBQ?=
 =?utf-8?B?a0dWMEMyNktKM3pGakFMNnhmSlNCYndLbHk3TVZVNk8wM2dtUGtia0NucXpW?=
 =?utf-8?B?bHd4dz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ak53S2RDOGdDd0pKbUNGU21pempTSFp5eGR4SDRETnBPNWdYS0xMMUUyWHFu?=
 =?utf-8?B?RHhJd1BJZHhib2NFRmtJNlJxL1dWN25tTFlYNEw0Szd4dTBBZ011ZmVZNlZP?=
 =?utf-8?B?bkFPUkV6Z2taRXhZTU5ITTRTV3hzZXBUUU1obU91NjliU01vLzlpcEZjbzFI?=
 =?utf-8?B?RGs3VERIN1U2SjhiSmdhTDZRR0pDdTZ4T2wvYS9nZHNxdFJpUVdvYjRGM2ps?=
 =?utf-8?B?OUh2UE9hVjlDVWZaK240TDNzYjlzc0JrMEdRL3hhYkVacmtvYURZcUtpcUda?=
 =?utf-8?B?R1JrSnh5N2Z5ZVdGU1ZIREtBYnZ2bGZYUlNOWTBwcGZ4TXE5dDRxdjkva0FE?=
 =?utf-8?B?RUVHWk1iQS93blprT0ZGN3poakhKTHJPTG11ZUNWZFlpVHhhZlJ1bW1WNEJh?=
 =?utf-8?B?V3krUHQ0T0VVdnVETTJjMUFxM21TQXhTTlRFTjVqSUJFRGJ0em1VMjFYSlJH?=
 =?utf-8?B?clYwQ0I1NmlnQ0NOVWlua1FGRVBzTi8zUE1DSW9vNW9mQjliZ0dXb2FGYUUv?=
 =?utf-8?B?bXoxYytJcnFBVWY5aHAzU1RBVndEWHltS2UvMmNDcjd1TUhEN2c5d2xZRWZv?=
 =?utf-8?B?SG52bGFUekxIbytLYjJtaXNYVSszWW5xMjJ1TmdLUC9OTjlCcEllN3plakdT?=
 =?utf-8?B?NjJta29rMi9XbG1WZzB3d0Q0cFFXQlc3czJzSnFLTVRRbXN2OUlOZzBYejM0?=
 =?utf-8?B?S1E3QjRxWWhGMGtMUGdJU2ZCZHV3ejhRS2Y1a2tqa1dqTE50ZVFpWnlMRnpt?=
 =?utf-8?B?WDVUay9IWk82cHRIUEpPL1RId05SUGYvcHdNM2xFYWxVOHBmVytJZERPV2Zx?=
 =?utf-8?B?TzZsWEhsUDk4TzBSR1pOY04zMHlmVTZWemhxZ05sUWM4a2JCVW1qSlFIc2Ev?=
 =?utf-8?B?MjJXQ3RNNE1GQldVczlMVDlZdDZXNnkwam1DYWEzZDV4T1ZJUklKUU42N2Fz?=
 =?utf-8?B?aCtoZUhhTDFwVHVBcjc2RXpCbjA5TGxwUFBxMEsyZHBHT0tuZ0wrOGx2V3Nt?=
 =?utf-8?B?R3FkQ2FYV25VeHc3RzBvS3ExNmxYZW5jb2FXeUJucGQ5VzByeW9lVUJoVW5M?=
 =?utf-8?B?QnllaW1RdHRGcUp2QVk0dTk1OWUyOVRJcTUyUk9YSzFEaFJDdGpEeFdEbndQ?=
 =?utf-8?B?R1pUZ1lCNHJvbThpb2tXanpiOEsxcjhWVUl5ZXBXd0l2LzA2MjBQZ0FndHFi?=
 =?utf-8?B?MGttbjBVRzZ6aXZpSEl2amc1Vmxhc3NvM2c5Zlg3Z3NUS3ZYWUdYWDQ0ZmV4?=
 =?utf-8?B?SmlYOXdGSXUyMFRGVTZLQk0yblk0cXN0cjU4Tkc2dk1VZmxxSGJ4TWxURGxx?=
 =?utf-8?B?L0FWc0FDM25KaVlyMnhEaTc4ZEpkSldzazcrZUJxM241N0JjbTZBYXBVUU0y?=
 =?utf-8?B?NGtTdWN4YzE3MFJFTzFwRmtteGZKcCtab1dNelpiRUd1VEVwNkJVakZHVExP?=
 =?utf-8?B?bmZiVWI3TktEZ3Z6anR2QXg3cEpobTQ1RlBFUTVpTXJ3bC9MZDdrc0pxYTNN?=
 =?utf-8?B?U2tTSThRMEYwL1hhcTRvOVp5RG12V1l4RGs4bFkwYk5MR3I1M3gzV29uNkp2?=
 =?utf-8?B?SjZEYkJZcjFBR2ptbGFmeVRVRzVZVnczV1BvdG9rOGtTL2xxaVR1YXlHeFNB?=
 =?utf-8?B?MkZEalkvMkltM0lWby9mUWNiSk91M2FNUEdlb0tUdStLZFhRRHQ4R012M2wz?=
 =?utf-8?B?UGdybTIvS0FnT1FtenR3T3hFRjVxdS9HU0puZmRzeFM3SmMrbkJPS01FT3Bx?=
 =?utf-8?Q?nq+KSog7mFUq2ZECckOP6pohlLR9AlTrHzV24z3?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbeee0f-f6fa-471d-1680-08dd75da12ee
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 13:42:43.9794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7332



On 07/04/25 7:07 pm, Aditya Garg wrote:
> From: Aditya Garg <gargaditya08@live.com>
> 
> This patch adds support for kunit tests of generic 32-bit FourCCs added to
> vsprintf.
> 
> Acked-by: Tamir Duberstein <tamird@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---

Petr are you fine with this here?

