Return-Path: <linux-kernel+bounces-782672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 533FAB3237A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB7FAC2C4D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EC82C3257;
	Fri, 22 Aug 2025 20:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.CA header.i=@LIVE.CA header.b="X9oKkDAG"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2084.outbound.protection.outlook.com [40.92.23.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EC8393DD8;
	Fri, 22 Aug 2025 20:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755893849; cv=fail; b=qUEN/xIfA11d4F4IRWUc9Aexo7vhjYzabm9jv37LVQ3Iwte2XFVmohIAPrrOAOUnXbQSwazm1/KUKzldfPHAZzdqoitmSPD0TyRydKJ1EXI98tJPnl06FtpvXZhJO2yKCGclbDyhYziB1efo6bmZN1SkhgDtLIs5GGE6OI7VpSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755893849; c=relaxed/simple;
	bh=ma5FH/Dq/UudqKTJK+ZidtKz942mW6CmgzXkMUl2k8w=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=ZvSvJzme7cYg8qWMzv3Jax/u1tgcmKrfLMjxtth/wVlFAfJl51kuwi4jkPtBhkDfxH9aM0ZTqcO6jojROvUsmDC5T1XVhPzDliB94FzcVuSpal4zZjWi9q/hDAkho6ZwNbujwC8h28KyAUDwTlztrWgY+pu3WLy/5pM2jZsO5IM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.ca; spf=pass smtp.mailfrom=live.ca; dkim=pass (2048-bit key) header.d=LIVE.CA header.i=@LIVE.CA header.b=X9oKkDAG; arc=fail smtp.client-ip=40.92.23.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.ca
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJmzUxPPSxwqQtcPRzRFzbjnu2bM/3pnA7MHCrqG4GYbv4ZqEzHNZ6W3lxozRISF3B8a+BfttfL5cfP074Y3yJJ1sR7fDnUcZ6ylylc/76MbxBSkNwe039CaujasfITXe2PgGwu6lB4YTorbt+Blnne6i1wd4sV58YGbD175PArMiK344KAQu45+Rs7lCUOBaHuANVqUZGBaLTu8NrFtkoXfZvkGZJ9EYhIzpJ3ZdJ7suj87DniJuJnlekm40knh+b+svVEHifhEKZyA9sQneb87cWDeEWU1feYhePGN4uzFFlxnKMowcdeVLC4+GvzsLG8HCNSVBrgStpt4rBG+gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GthZlcusOh/RDcLbqcYTt83YMLFcGlMr2Ks7q4yL/w=;
 b=pzgN4nLBFVY9+r33R8Sni2a+94MjkReqHV91fUAlofIWuQUhtDI2HV1FrJCydIqTPN2eIA9Vg12/Ca+1e4wyP3lPnaD6Hh3WDvRJKw6mBGATUmQ+X2UNUkDW2eUcfkGpmSP9zxpkJUUy1MPmfBVJBJ+INH133Bq/B9TAm6QZA74AqyLE8baf3FQbX5nHkjqN8EwEpRbFXlTfE7dMN/ksJYqtVcBOuuyaqG7/dzbdipA2tn42YGKvttMGBEZ+mSuTDpuHn1QITS2Gz6xXPerf0KAhszA0AMmLrC5L5vcYxPpsJeffCBo08svRnpjkG9QrY1k8lPu2ny4am50XugdobQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.CA; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GthZlcusOh/RDcLbqcYTt83YMLFcGlMr2Ks7q4yL/w=;
 b=X9oKkDAG5sM4ScSKli9x4ifflkBG6U84xP5yrZvd8lOiyUikK8NPiKvaN/1HG5vuv23M/tAwllqh33UacX/9k9/bD5Mj9wAvlXxQSTqBbykHvKGVEqF8lnUKbNJ3H5We8LlHn6Zic0SY+iCnrDN1ibWokclnnL+UY90Jf42Rk/DBwmrkHpvQlQGAHUADw45MxFWUndJL2PmCIsdsRFWpcZYk3xy/3FemY40fL3yJSwYy0XoZpiZ9A9JK5Ql0Hap+0FfUHdXNiC4wAi1wQLY0dUhd+puhB8YoypSb8y28+uxHwLNufgxgbmyrboSbVNC6GCNOG09TwnD8RPY5vKNGbg==
Received: from MN2PR06MB5598.namprd06.prod.outlook.com (2603:10b6:208:c3::13)
 by PH0PR06MB8111.namprd06.prod.outlook.com (2603:10b6:510:ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.18; Fri, 22 Aug
 2025 20:17:19 +0000
Received: from MN2PR06MB5598.namprd06.prod.outlook.com
 ([fe80::96f9:fd1e:4b7c:17f4]) by MN2PR06MB5598.namprd06.prod.outlook.com
 ([fe80::96f9:fd1e:4b7c:17f4%4]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 20:17:19 +0000
Message-ID:
 <MN2PR06MB55982D694628BC31FD980FD2DC3DA@MN2PR06MB5598.namprd06.prod.outlook.com>
Date: Fri, 22 Aug 2025 16:17:19 -0400
User-Agent: Mozilla Thunderbird
From: Daniel <dany97@live.ca>
Subject: [PATCH] platform/x86: lg-laptop: Fix WMAB call in fan_mode_store
Content-Language: en-US
To: matan@svgalib.org
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::7) To MN2PR06MB5598.namprd06.prod.outlook.com
 (2603:10b6:208:c3::13)
X-Microsoft-Original-Message-ID:
 <c2f207ba-db21-4630-804f-e51294a5e299@live.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR06MB5598:EE_|PH0PR06MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: 416330fa-e763-483e-a975-08dde1b8e479
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|8060799015|19110799012|6090799003|5062599005|461199028|15080799012|5072599009|41001999006|440099028|39105399003|51005399003|3412199025|40105399003|26104999006|12091999003|3430499032;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFpwUldTL3pGSjlGay8yRTNNUlVNbmljMC9EUHJOR25wemxLUU5ialZZNy9M?=
 =?utf-8?B?aXZLalIxTUtTaXMxYU5PTlhsT1FFQzlRdXY1SC9IMWwrY1FUWGZlWi9XMHBm?=
 =?utf-8?B?OWpUQVBOL1JvUHhydFo2YUhUaDNRdmtCdDVNTXdKczNtZks1MFd0T09TaE9J?=
 =?utf-8?B?amtzTnpTTlI3SEkwZkZsbGg4QnU0Mi9aeGxobDZVV1ZONElWVkRlcXNBdnFx?=
 =?utf-8?B?UzkyYVJkOVQ3aGIvZGZWeTdjTHdNWTQvQ0ZIaU9TNHBvMFdjekNNZHBYeEpq?=
 =?utf-8?B?YlorZm0wZk9BMlJUVTVaWDZhRGZBcUdxUG16cFQ1MVoxSUdaN3dUajNEWHpQ?=
 =?utf-8?B?emJUeXdLUFNGT0tvWVlQV25EVzRoUUtRNjlBU2pJQnRFdEZGaHBhdFdpRlBy?=
 =?utf-8?B?T2YvWkhxQk1kVHBVNysvald5NE9PWG1PTHRXRlhuaDFtZ3NXQUlYVTVzWjhE?=
 =?utf-8?B?QXI2UTE1NDRjYVByejMyWEEyL3pFVGtmVEU1aUtqMEVyWE5zdU9hci9aTzB0?=
 =?utf-8?B?alBMWnhNWlFCb2tmbXdCeDJraDdFZEFJaXY2d2xxbVNUNjg2cFo0SG15NXlR?=
 =?utf-8?B?Tk5sNk54a0NnajlUUDJweEh2N3lGNFJNTDRDTXRYMEk1bkZzakl6Qk5rMStp?=
 =?utf-8?B?aUFGUitVenZla1d1RE1pTmQ0b2Q2dWV1eTRtRjNLalpJeStKamtCK3UrL2dX?=
 =?utf-8?B?VG5lRFU1dHRYb1QrWlVjaEpWa085VCtJOW9aOVR2NjZ3SkJaTzlRcUkvTUJh?=
 =?utf-8?B?aXRheTRwUmcwNFRIa3AzZENHTnlTVFJtWkF0OXNzMmJDWXkyd1ljSEJIMCs4?=
 =?utf-8?B?cVM1d0F4b0RFYnBhUVYwc2F3RWRjaVh2d2ViaU5Ud3BOT1h6S0xMc0Q5WmVx?=
 =?utf-8?B?MHZ3SXFVZ01tUzZwc0FZRjRsV3hCUzFhaW54TEJ4KzNnMjRIRElxR0VmUjhp?=
 =?utf-8?B?ck5aUmNMa2dnVVlrTmkvWTN3VmgvcFBLd1RlWHcvQkFvN05sWForTEJHOFYr?=
 =?utf-8?B?YnFTN2U2VmRZV1lvYTNhVGE2dDBVOS9VTFNSaFlUem9kNm8zRm9LSkpRelZY?=
 =?utf-8?B?cnUrUWg1RzFjcldIWmIwcmtaVUFGa2pudFVVN053azFrUm02a0JWYjBLZGlD?=
 =?utf-8?B?V0pTM3M4SzZEcVgvMWt6ZjRETzhPZXZrMm1FQmlZYnU1cDVvMXRpRUFaSzFV?=
 =?utf-8?B?eG1QRnJONjBlMi9lU2FZWU5TbXlMVUlNV2txRTBBQ3hVWUlQSE1YVUcwbGxD?=
 =?utf-8?B?b29NZmE5RTU2ZTlTSFN5NTVUU0JJN2QzZ2hZNE5VZEhKZDNxTTB3SXVPSGVT?=
 =?utf-8?B?T0k4Q3lHSVBtNXZvODJoWit6U2xKZXhhRjZ0L0U1Y2xWTlZTMUMwQ2JDUlFX?=
 =?utf-8?B?TzhBVEpNemc4Z2poemI4c2ZRZjJ2Z3ZxNHVqUUhYaEdIQURHSDk4emVsSW1Y?=
 =?utf-8?B?MTUzcmF1QWJMaDB4WjN3bnlUY0RYdzNxUE5XR3RZMHdTdVdZN0hlVWh0cjBt?=
 =?utf-8?B?dmY2aUx4OU5JV0VrMUJFUkNKanF1TXpHZFhTMjhiL3pLck5GODloZkFSZnVW?=
 =?utf-8?B?aGxWaTAraDY3TmV1T25HUU5ZUVV6ajExRmhXdXUwV3NDbG9ISW5oY1VoaU9w?=
 =?utf-8?B?WWo1ZUxBY1IrenF4cks2dkF3c0F1MGlPaTBDVWErZWpRZlhMdE9WWUZOK3RK?=
 =?utf-8?B?NUlUYXRzMHlmVDlqeGg1UHF6STE3M3dJaDZqcGpIN2JQdjFUV0RNSmtQQW1p?=
 =?utf-8?B?RFVkd3Q5WHRJM1FjY2JuY2JRbFRtR3VPcGQzaVE2bHdLdVE2VnNlTmg5ZGtC?=
 =?utf-8?Q?eJ6IvQs3snpWvizFB8I93QNymAUqiVIulmA/Q=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ME4rS3N3c0RCSTh1eEJES1FKRU96MGE0TStwZVdhaHpIZ0lsUWtuSlNCa2tC?=
 =?utf-8?B?bmtwaFZSV0JFY25jMmQvQkdTQ2hITWtNRE55S3lOaUpNaDV2MGhLa0tWZ09m?=
 =?utf-8?B?SXUwR0IzQkt3UFlBaEtQR2tXblAydzNvNmZJVWNKU1pXSThGcW9HN3IzbXc2?=
 =?utf-8?B?TUl3UmE1ZDBBNFQ2WDVEVTc3NGJYcmdvTS9CbU5JSjl2SXREVDZGWStBdlA4?=
 =?utf-8?B?MUZNdEJOMmdYTzNjSXJUMHJRYWNya2NkM2xTR1dET2lya1oyQUd2aVdwSnY5?=
 =?utf-8?B?UWdyRU9lYS92VkFZZnhTekw4WVU3bXd0SUhkZmRRbnl3TUhmVDBMQXpwOVds?=
 =?utf-8?B?dlY3SW5FNjBOUnFjS21JV1NuMFpOdmJNK0Z4S2t2bVV4Yk13d1JES1NLVTlx?=
 =?utf-8?B?WE9vbkprNGpueUQyS3E4SXE1RVNST1VBQjErZlhnZ29zUm1hQWd2UE9QVkI0?=
 =?utf-8?B?a1lXWWhJeDBLVTNLRnlYU0Vub0JOcDdaeTcyMXZzSmxtQXZpWHBCQ0pMbXI1?=
 =?utf-8?B?UGxQbmNDU2RTMllycjhZZGhHUTYrQXg3azQ5a3BCVDNWaUh2ZEZhNGUyUWRR?=
 =?utf-8?B?dU0zL3pqV09ZRm9Zcm9MUUtEQW94ZnRWK2dGaURmWTJ3WmpFbWUyMSs1eThH?=
 =?utf-8?B?b1R6WWZpYlR6bHovdjk3NXMvSzdZdXBlK1h3NC83eFJlSlZYQ0czZCtNcU1p?=
 =?utf-8?B?VGVwb2hBZ0EwS0oxRTMxNlF2QzFSYzJ2T1R4MUZBU2YvNUMvWW1SbVNRcVo5?=
 =?utf-8?B?dFVmbmZlVkZOTmNJTE9ZRW5tMzBXdCtZODBBcDdCZnRNL2tHdVFBYzRZenFi?=
 =?utf-8?B?clY5UWMzL3JxY245RmV4dXY2YkZCWjdHTlBtYmxBSHF5ang2cldYaVRkMFJa?=
 =?utf-8?B?RmlwbG5iUVV1Q1BpTzlCTThkVEFMOXptKzk5OXR3YnN2dWNaaExtNEt0VEJp?=
 =?utf-8?B?a1lPWmdJTXI1dUY4NGlPSjlVRk1nMWlQc0pFaTErVHVEVWtpb3ZTcGNtMVk1?=
 =?utf-8?B?TDgrTVl0ck4vSEVuaXBzYmgwcWVlcnFnN3dzRU1QRUNoelpqWGxXUTk2MUpy?=
 =?utf-8?B?MTFIbUIrVzhKYXNPcWJ5VGNDeGYzUXdJc2xYcXpIbDZQREVnbE1HN1JZVWta?=
 =?utf-8?B?SkQ3V3Jnd1JKdk9JUHUybkxheTRlaTA5UFZZZTg3RGVMa2o2OGZlaWV4MnlR?=
 =?utf-8?B?VjlDZVlHVG1GNVdjL1pIVHR3UnpkRU5zaWRqQTRaL3NWR2NWKzVraE1LOVVH?=
 =?utf-8?B?aHNZWGpuVWZvaThkWnNnVGZXQnhZWTgyQzNlQlMrM2RZR1ZMZ1NKbUZBTjRs?=
 =?utf-8?B?OFlXdm4yVFpyMW13dW1iSDAxVTlMMjRqZm9hSzByZURXTzRRUlZibkFoYUUz?=
 =?utf-8?B?RnUway9LRFlVRHpLbys4MW1rbmJDK1gzSkxNcnh3VlQ5QjJWYUlHTG9tRHNo?=
 =?utf-8?B?akZ3czc3RnVncmxPeEcwZm9weEdEZ01ZVFptZ1NpYzJFdCtRTDUrQldQdEhR?=
 =?utf-8?B?Sld5RGswd0xPRHZkYXZnZ3FJUWFkVVRESUN5bWtHYTNtb0MrMmZnRG1GNEhN?=
 =?utf-8?B?RFFBdERjdWV5L0d0OHZZanpWQXFaN0FuUitKbjhYaGdUTTFwZWliZDI4Q1Va?=
 =?utf-8?B?ZnNZTnlZS042VGtxYTNKYlZMNzZZclJCRlFTQVBxcVgzbXdwRVY3UXFMbDNN?=
 =?utf-8?B?TDBRVktQOElrUWhySXE1Wi81aVRDUFZZUlltbzhQa1Q4c0V6eS81REo0Vm9Q?=
 =?utf-8?Q?AoMqknmwuIbbKwngyU=3D?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-a1430.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 416330fa-e763-483e-a975-08dde1b8e479
X-MS-Exchange-CrossTenant-AuthSource: MN2PR06MB5598.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 20:17:19.6993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR06MB8111

On my LG Gram 16Z95P-K.AA75A8 (2022), writes to
/sys/devices/platform/lg-laptop/fan_mode have no effect and reads always
report a status of 0.

Disassembling the relevant ACPI tables reveals that in the call

	lg_wmab(dev, WM_FAN_MODE, WM_SET, x)

the new mode is read from either the upper nibble or the lower nibble of x,
depending on the value of some other EC register.  Crucially, when WMAB
is called twice (once with the fan mode in the upper nibble, once with
it in the lower nibble), the result of the second call can overwrite
the first call.

Fix this by calling WMAB once, with the fan mode set in both nibbles.
As a bonus, the driver now supports the "Performance" mode seen in
the Windows LG Control Center app (less aggressive CPU throttling, but
louder fan noise and shorter battery life).  I can confirm that with
this patch writing/reading the fan mode works as expected on my laptop,
although I haven't tested it on any other LG laptops.

Also, correct the documentation to reflect that a value of 0 corresponds
to the default mode (what the LG app calls "Optimal") and a value of 1
corresponds to the silent mode.

Tested-by: Daniel <dany97@live.ca>
Signed-off-by: Daniel <dany97@live.ca>
---
 .../admin-guide/laptops/lg-laptop.rst         |  4 ++--
 drivers/platform/x86/lg-laptop.c              | 22 +++++--------------
 2 files changed, 8 insertions(+), 18 deletions(-)

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
index 4b57102c7..b8de6e568 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -274,29 +274,19 @@ static ssize_t fan_mode_store(struct device *dev,
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
+	r = lg_wmab(dev, WM_FAN_MODE, WM_SET, (value << 4) | value);
 	if (!r)
 		return -EIO;
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
 	kfree(r);
 
 	return count;
@@ -317,7 +307,7 @@ static ssize_t fan_mode_show(struct device *dev,
 		return -EIO;
 	}
 
-	status = r->integer.value & 0x01;
+	status = r->integer.value & 0x03;
 	kfree(r);
 
 	return sysfs_emit(buffer, "%d\n", status);
-- 
2.50.1


