Return-Path: <linux-kernel+bounces-815248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DD1B561A5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 16:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3C21B2641B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 14:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2B82F068F;
	Sat, 13 Sep 2025 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.CA header.i=@LIVE.CA header.b="GtwVlA3Q"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013085.outbound.protection.outlook.com [52.103.7.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED2D6BB5B;
	Sat, 13 Sep 2025 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757775058; cv=fail; b=jKJKTzDvBRBiAu1xoyT1Sl90qe9nbI/vl5ZsL/9bHhopq0k0YK3abnvT2Fzqs/Igil8cUkVY2U/B0EMVOqNk9Yrmee+J0FT2ut0xG7za45+iu7P3rqoGKVtSm9bzAPXDVZishjLwINP/ZwMZFuITYaE5uIyMnTBAXl8boaq73C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757775058; c=relaxed/simple;
	bh=wCOXXZcTg6JzKeEGSpj6t2Se/M0rNvnNupuq+4RyEOM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rVl9cBLn0NQGZO6ZGca3nafqzHRdLEmDTvdyCBkGBC/iTgDhWD1An6YQr5s4yB9iJXX/3uTB1MBClLaRx2ODuT5xq8nue3vbWcGXvDpRv0ecczDO9X3LSrebzFhZM897hZu1yKJBAGRvQH4XM5KSjDLVIvVzg+Y3I9WSZI7f2m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.ca; spf=pass smtp.mailfrom=live.ca; dkim=pass (2048-bit key) header.d=LIVE.CA header.i=@LIVE.CA header.b=GtwVlA3Q; arc=fail smtp.client-ip=52.103.7.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.ca
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXLKQIQRm1UWEiIi23OLlk3PhtcAVSAv3kY3dqInvwCt57AYtlln45pXSot71Mw7RTmFLBfuugExDKumTsYx0JEjNJWSOz+h2nWz19wfF1Qo5ta5VJJjdBowLsa5+P5RZH22ZC+BbP54vdUcKwBFWhBvuwRIsQssKS217vaT6sByXdQS7qnmfbePKiQft4BanKMwMwwtFQwctoqNuRQaJo6ofPQQJ5whsqzC8VuwnrCTkfolIRUk3OY3h52XtWxSSReg5PcvJPO9O261ft2iSx5uF7p52pkLG9mMcK6t6z9gzqrvafhnVZ38bpfIF54OIjQ+WqA+wftQi3d/VmWx8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9G/+m1qqzywU9hwQdTGImvb+C6yclA9lmxzt/Zc8T0=;
 b=xpNTxYzZu1A1JDTuN+RnTRWD9hh8s66uTNCcd/nkhgZurm5vdqs8rhA8f4b+2r9m/0CHg8+bf2TWgKdnDtr1ctlwgx9TFyZiDuhNWeiVToQc6oCpFsyYHZqF7VhSrvPMoEQKgZYN33msRsOqPPxf5jIddKl/2CxdpEuD5BgoaIotStQyh9dEAN9l8aA5YCkCeTAIH92eyuQsbe/DNg3inPn+9s6cqtum552b+Yac6rSfEYbUSkJ/GGj2El9EDeyX9onvGwC+mz9XBMVmMLB4x9JsQ4sntHQy6WSqpQs2i1KiPdYvoxXG1Ek7jcPiDcimXU83fcMZ34TMvcUlXwPNjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.CA; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9G/+m1qqzywU9hwQdTGImvb+C6yclA9lmxzt/Zc8T0=;
 b=GtwVlA3Q8vz5+QI+rkQlu21PgIg5tzo2JQM6e8WDrKhY5s/Txpg/SOlddDFOj9cIpo2niKG5wXRsqB9XZQQj5VMYme2Hf+QHYe76ccCz6dUMhwvZx85ayM6O1uLIK8Twbi38V35LTKD//RE+YfViKh6q/D2Nzy8x+IdBUtDPpOdrTptH0IAof5S3EVYsujntedwzxEej2FYpfbdnTdwUMsLaiy+LxbIrK73NkaenoFvLRvHnbwZEh4qKM/9iZbrvVRcGb46Fo8v1u/vqh7fHnP8uXUfManh8NDFqAGSzF/oJuTVpFIqBrfCNXP4b1QNqamXHLzzwGza1nixKtae1ww==
Received: from MN2PR06MB5598.namprd06.prod.outlook.com (2603:10b6:208:c3::13)
 by SJ0PR06MB7321.namprd06.prod.outlook.com (2603:10b6:a03:2e5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Sat, 13 Sep
 2025 14:50:54 +0000
Received: from MN2PR06MB5598.namprd06.prod.outlook.com
 ([fe80::96f9:fd1e:4b7c:17f4]) by MN2PR06MB5598.namprd06.prod.outlook.com
 ([fe80::96f9:fd1e:4b7c:17f4%4]) with mapi id 15.20.9115.017; Sat, 13 Sep 2025
 14:50:54 +0000
Message-ID:
 <MN2PR06MB559854ADB7D4F32EFE9A2E25DC0BA@MN2PR06MB5598.namprd06.prod.outlook.com>
Date: Sat, 13 Sep 2025 10:50:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] platform/x86: lg-laptop: Fix WMAB call in
 fan_mode_store()
To: Markus Elfring <Markus.Elfring@web.de>,
 platform-driver-x86@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Matan Ziv-Av <matan@svgalib.org>
References: <MN2PR06MB5598DFC94FB13E9F809F0EB3DC08A@MN2PR06MB5598.namprd06.prod.outlook.com>
 <37610abe-e6ea-4694-be63-1a7147c52b73@web.de>
 <MN2PR06MB55988311E10C20DD6EF0CB97DC0BA@MN2PR06MB5598.namprd06.prod.outlook.com>
 <f8726808-9e34-44b5-b6e2-27e898c53321@web.de>
Content-Language: en-US
From: Daniel <dany97@live.ca>
In-Reply-To: <f8726808-9e34-44b5-b6e2-27e898c53321@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0388.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::17) To MN2PR06MB5598.namprd06.prod.outlook.com
 (2603:10b6:208:c3::13)
X-Microsoft-Original-Message-ID:
 <acfe8161-bb04-45ce-b458-46091b161ded@live.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR06MB5598:EE_|SJ0PR06MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 7941c657-5546-4940-d4d7-08ddf2d4ee1c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|19110799012|5072599009|461199028|6090799003|15080799012|23021999003|41001999006|440099028|40105399003|3412199025|26104999006|12091999003|3430499032;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3JNd28xN1R3UjNuR3JsakhWMEdLUXVNT1VpdDUxS3VxSnlsam9YbURaQmVV?=
 =?utf-8?B?RGlZeTJidm5HanZFZzBMejNudzUyODVPZkVjNEU4SW5FOEJHUlk5Ym41dW9q?=
 =?utf-8?B?ZTVrT2hMbThWSDRzZ0xxcllaVTVEZUo1V0RFZGk1eGhWNk9RbWwvUi9qMlBX?=
 =?utf-8?B?N2VsWFNzOFc2R2lLS0VrRHRBd0NZdGZYRnhUcEJ4WUhCblVpNVkyNFlmYjJ1?=
 =?utf-8?B?aExkaFlmdTVkb3ZwNnVrWGs5dzhSdHVydFJKK04yU3VXZnQzdWhCZXZJS1hm?=
 =?utf-8?B?SlJQN0lGVXVUVGkxdVhnVVROZjhaUjhuYzlBUTdGK0wxcC90b1Frc28zdm5H?=
 =?utf-8?B?VUZia1lkQ1VSU00wdnlCWm9YK3Rma04wdTFwWHdBS1JOS2NYVFVDSXVROXNo?=
 =?utf-8?B?NUlBcEdOUkNkd2NacXBPckUxVXFKYmlSUVkrUzJOR0Y3UmdkdUowVUs2Rk52?=
 =?utf-8?B?TE5vTjY3MG9OaDRqYWVDL2drYjRKOU8rejREVDBIVnlFUWpVOHgxSHBJZHp2?=
 =?utf-8?B?cE82MDdJVHRUUmI3TWpqekFNK21lKzhlVmtPT0p0b0xNSkQ2blJFYXJCS2F0?=
 =?utf-8?B?b25qd1M1NnY0YnorWHBxTFZIT0hqdWFPMlo3WVNWMExzUlErUndHVjRVeVoz?=
 =?utf-8?B?eUYwamhLMnJjcXNjdVozWVBwT3BJTkVzZU5zYWVuVHp2Y0kxVHJrNnFPZEpX?=
 =?utf-8?B?NlZUcHpCa2xldzJoOTB4UmF2YUFBTmZTVDI5ZjZyclpNcUNEbDg3Zyt2UTND?=
 =?utf-8?B?dTNwTFowNzRqaFA4QnF3cXZ2b2drN3VsK0xEckRucXZ4a1lzSE01UE5YaVIr?=
 =?utf-8?B?UXp6YUwvaSsxVzBqMW9nM25UQnZxSkZKT1pVbkhEZ01iVTVkOWp1WjBDWHNk?=
 =?utf-8?B?YzhVTEhXMFU5VWplUXdZVDFuSmg3NmR2WDl3YlVybTdPVTVCQ3ROa0RId3VX?=
 =?utf-8?B?ZGEzbWtTVi9KT0FwdnNkR2VSWklIM1cxZUp0MTZXWHZ4M29BK1p3MkRMcHRV?=
 =?utf-8?B?ZHFCWkdydlIrZ2F4aVdDWU1CSXV4YlFYZmI4VTZnRXA5ZkxTaTVaa0cya0Vi?=
 =?utf-8?B?SlpFUFBwOTJhU1NkUVN5N1NqakhJaW10QUxnQXh6ejV6WEVrMGtPaHBXYVNj?=
 =?utf-8?B?YlMrRXZ1WXU1NGhYcFZpeDdqUFY1UFVER3NKZXl6Vzg5ZXVHSVNMWEQ3YXFs?=
 =?utf-8?B?b1RsMzk5MWF5OHE3U2piajZxQW1aMXQ5TzhNVi9NMEhoNU5aME1TSjhlYzVE?=
 =?utf-8?B?VVloRi9NRk9FUGtLWXVuaVFHRytlSzRMZnA5ano2YVF0SEpOSEZMWXAzZmln?=
 =?utf-8?B?ZUd5MnEzRzlIRlNtSzJuVTNUSkJza0hKUTkzdDZ6Z2dMRllLMWhKN0tkcWtr?=
 =?utf-8?B?RTVoaEQ1VWF5UlMwZ080aTdvMlFZcC9rTzdCUlBMallscjFJd2Y4ZW9GeGpi?=
 =?utf-8?B?RG9KY0FmMTFkcjYxTGpaQ2pBNitQNXFhU1FQeHBnb3JrQVFGTWFUbGFqM1Uw?=
 =?utf-8?B?eEZZN0JQc0ZaMmlKQ3BvN0ZESlFoQTN2dy9aMVpXV0p6aXQreFBMbzJSZkpN?=
 =?utf-8?B?UHlDUVZOa2N2T1BzRjhSRDZyNGZSb1RJWGR3REhDbktFSzhPOFVlcGxQc3Q5?=
 =?utf-8?B?WXFoZkJaMjVIZllWNUdFQUQ0dmFZQ21kcmFWWjRhQWNvd0FvRGZ5clRkNlFE?=
 =?utf-8?B?MEhHeUUrVFRtQ3hxV0U2empIbzFKUEFqWVNrbWVsaG5waXArcFNkbC9RPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlpHSDhpUWFSOVVkcVdyK2MxNzY3RGZQRjU1STY3OXV6ZlY0aklVOTNLQlpa?=
 =?utf-8?B?ZS9QalBndFhUYjhHam9lOHNvamVxMTlJbEZGd3hsQ3BadFNTYi9KRkFpaVV1?=
 =?utf-8?B?dm84cUViUlQ0cDJLbGNGNzY5aWlXTEs3NysxMzljL1JxVVV4VCtmY3h0TGhP?=
 =?utf-8?B?NDhtUmZRMjdXVXJQcklEUHJ0c1ljQzBSOHltVDZTZGUzMkhGVGVibGJKOWhj?=
 =?utf-8?B?SEw4TXdvTXMzSHY4aVdIV0d4VjhNSTE1aXFzdmtxZTlQZWpNZW9lTHNnWDlY?=
 =?utf-8?B?TEw1UUhMdzF0QVNrVVoyZUxXWXpCWVdoVGpmaytpTFNHUmx1Y3BNZkh6T21Q?=
 =?utf-8?B?d0ZlWjErZ0wrSEJIZnhVQUhpa3FYcmxtMmtYelArMTFrenFKYURrNkRwTGhF?=
 =?utf-8?B?QTdGa3VyVXg4cXdPY1ZVUEgrdmo5WFFzdUZxNlo5eWJFSWtqQ1hnVGNyS1B1?=
 =?utf-8?B?ckI1M21pcUs4SnlrYnNyZlNkVllRZGRsWnQyNU55d3ZEWXE1UHB6VVhIcWx2?=
 =?utf-8?B?b2NjOTlwejhmVzJjdXdpRlJDTFU2ZlgvWnFuYmtrbWY5d1E5VjdOZlBjL0p0?=
 =?utf-8?B?ME12Ukw4WGFuQ1VkTjVkZ1RsVHBFV2N6dzhVb0tSZklxc3JwV0FrMXkvVjZ1?=
 =?utf-8?B?dVBhb0dSL0E1ZHgyRVRyQWNQWm5QUm81bkpNVHU4cDRyR1NlRjhjWkRUK24v?=
 =?utf-8?B?SHkrUThPRGtKRU03aGpPVzQvTUF6NUFrc0Z0NmtvSHdubngxNHZKNnRPd2Qz?=
 =?utf-8?B?aFYzZTZKSDY4aHJIYXVZeWVQeUhsVzk1N1Q0UUhzcXlwT0I5ZXVWQVdGY3d6?=
 =?utf-8?B?OHNXUGxlM2FoUzZERCs1SkJzOWJQd25BdFB0aXFJZC9PaEhueTdQNkpSSkpW?=
 =?utf-8?B?S29nK25hNU1WMzBRY3JpSFgrMU1PT2VkSitJK2dFeTJxcnlqYVM3K0luOXJm?=
 =?utf-8?B?eEY3TmlIQWd1ZGVhY3pONHJ5eThWWUVicytnekNrbDhEVTg0WEpwY253Q21W?=
 =?utf-8?B?NW5XZXplcnFiNU5FeXp3Q2lTdHg5Z2pHTkpXcURCU2xOZ3VpZUVYUEdwRk9q?=
 =?utf-8?B?QmtDZml1UEJCM2FuRUJmekdWR3ErOFk1S1lEVGNwSUZkZ2tRWVRTb1U4VUtS?=
 =?utf-8?B?a0lBb0p2a1YyZ1B4aUlwVzRQRlhDY2I2V2U0L3pYclVkZWlyZEdhM0VyLzd3?=
 =?utf-8?B?TkFNekNBb2paamJJNk16cnk2LzZvdjh2OG5FS2Y3WHplcGN0T2lwSWtIelFG?=
 =?utf-8?B?RFNaL0p0K1pGNEE3dmp4VklXdFJSL1RTUFl1OUxKVHQvUG1EK3RkVjBZUElY?=
 =?utf-8?B?eEI3L1QzZDhQNFVseVI5MzJzbER3amJhZTdSQ2diQkh4NVRYcVRDRnppZzZI?=
 =?utf-8?B?S0VlZGVyYXJYb01pbGVzbkltcTlVVGVKMmVtZ3AydW9RVmxFYzdVa1RNMnFY?=
 =?utf-8?B?eHZCZ1BzTHRjd2wzMHhpUEFSRnlrTWROaFZNbXc1c3lJRk5lMUxHUXQ5SDg2?=
 =?utf-8?B?eFBiQ09lTUdTQjBJTm5NOHNjRGVoNUxlUUxxY2tESUJBNkQrdHYwbFUvYytE?=
 =?utf-8?B?OGk1L2Q3Njg0S0dtdkpEcnpwQmVQT0VhS2gwR1Y0c0RZT3lXUlR1aHd2TW5h?=
 =?utf-8?B?Nmt4OEgxVFdRMGdIYXJ0SzVZbnNZVEE9PQ==?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-a1430.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7941c657-5546-4940-d4d7-08ddf2d4ee1c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR06MB5598.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2025 14:50:54.1310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR06MB7321

On my LG Gram 16Z95P-K.AA75A8 (2022), writes to
/sys/devices/platform/lg-laptop/fan_mode have no effect and reads always
report a status of 0.

Disassembling the relevant ACPI tables reveals that in the WMAB call to
set the fan mode, the new mode is read either from bits 0,1 or bits 4,5
(depending on the value of some other EC register).  Thus when we call
WMAB twice, first with bits 4,5 zero, then bits 0,1 zero, the second
call undoes the effect of the first call.

Fix this by calling WMAB once, with the mode set in bits 0,1 and 4,5.
When the fan mode is returned from WMAB it always has this form, so
there is no need to preserve the other bits.  As a bonus, the driver
now supports the "Performance" fan mode seen in the LG-provided Windows
control app, which provides less aggressive CPU throttling but louder
fan noise and shorter battery life.

I can confirm with this patch reading/writing the fan mode now works
as expected on my laptop, although I have not tested it on any other
LG laptop.

Also, correct the documentation to reflect that 0 corresponds to the
default mode (what the Windows app calls "Optimal") and 1 corresponds
to the silent mode.

Signed-off-by: Daniel <dany97@live.ca>
Tested-by: Daniel <dany97@live.ca>
Fixes: dbf0c5a6b1f8e7bec5e17baa60a1e04c28d90f9b ("platform/x86: Add LG Gram laptop special features driver")
---
V1 -> V2: Replaced bitops with GENMASK() and FIELD_PREP()
V2 -> V3: Add parentheses next to function name in summary line

 .../admin-guide/laptops/lg-laptop.rst         |  4 +--
 drivers/platform/x86/lg-laptop.c              | 29 +++++++------------
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/laptops/lg-laptop.rst b/Documentation/admin-guide/laptops/lg-laptop.rst
index 67fd6932c..c4dd534f9 100644
--- a/Documentation/admin-guide/laptops/lg-laptop.rst
+++ b/Documentation/admin-guide/laptops/lg-laptop.rst
@@ -48,8 +48,8 @@ This value is reset to 100 when the kernel boots.
 Fan mode
 --------
 
-Writing 1/0 to /sys/devices/platform/lg-laptop/fan_mode disables/enables
-the fan silent mode.
+Writing 0/1/2 to /sys/devices/platform/lg-laptop/fan_mode sets fan mode to
+Optimal/Silent/Performance respectively.
 
 
 USB charge
diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
index 4b57102c7..335afdc75 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -75,6 +75,9 @@ MODULE_PARM_DESC(fw_debug, "Enable printing of firmware debug messages");
 #define WMBB_USB_CHARGE 0x10B
 #define WMBB_BATT_LIMIT 0x10C
 
+#define FAN_MODE_FIELD_LOWER GENMASK(1, 0)
+#define FAN_MODE_FIELD_UPPER GENMASK(5, 4)
+
 #define PLATFORM_NAME   "lg-laptop"
 
 MODULE_ALIAS("wmi:" WMI_EVENT_GUID0);
@@ -274,29 +277,19 @@ static ssize_t fan_mode_store(struct device *dev,
 			      struct device_attribute *attr,
 			      const char *buffer, size_t count)
 {
-	bool value;
+	unsigned long value;
 	union acpi_object *r;
-	u32 m;
 	int ret;
 
-	ret = kstrtobool(buffer, &value);
+	ret = kstrtoul(buffer, 10, &value);
 	if (ret)
 		return ret;
+	if (value >= 3)
+		return -EINVAL;
 
-	r = lg_wmab(dev, WM_FAN_MODE, WM_GET, 0);
-	if (!r)
-		return -EIO;
-
-	if (r->type != ACPI_TYPE_INTEGER) {
-		kfree(r);
-		return -EIO;
-	}
-
-	m = r->integer.value;
-	kfree(r);
-	r = lg_wmab(dev, WM_FAN_MODE, WM_SET, (m & 0xffffff0f) | (value << 4));
-	kfree(r);
-	r = lg_wmab(dev, WM_FAN_MODE, WM_SET, (m & 0xfffffff0) | value);
+	r = lg_wmab(dev, WM_FAN_MODE, WM_SET,
+		FIELD_PREP(FAN_MODE_FIELD_LOWER, value) |
+		FIELD_PREP(FAN_MODE_FIELD_UPPER, value));
 	kfree(r);
 
 	return count;
@@ -317,7 +310,7 @@ static ssize_t fan_mode_show(struct device *dev,
 		return -EIO;
 	}
 
-	status = r->integer.value & 0x01;
+	status = FIELD_GET(FAN_MODE_FIELD_LOWER, r->integer.value);
 	kfree(r);
 
 	return sysfs_emit(buffer, "%d\n", status);
-- 
2.51.0


