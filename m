Return-Path: <linux-kernel+bounces-732424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 011B5B06693
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 21:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CABB43B157F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 19:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98E72BEFF9;
	Tue, 15 Jul 2025 19:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Mi0BuCs1"
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148A226D4CF
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 19:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606701; cv=fail; b=pDAR6hAJFxNRm+pPgXzoXboGH36X5Hqt6SZGPF/aL+U+B3rymzzuLM3eo1cTrI/Kn6mOdkBBM6C6Qd4hcUbyNue2p7Hme0s5wxVXlTAwwiL9OPvKiMKUkWTeBAs2SV8E5x8satC15YT+mzyPPTiymXx8c8q0RS8oHr3qkBs1Pro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606701; c=relaxed/simple;
	bh=WL3upnpdfPQsVaoPDl7/JywdDV+B+kRsoHb+D1UR6OI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IG016/JquWGhNtgX0NozerazWs8lxxjTsmqNGFo0TebipGAzEy/1F8XdLtc3Nabq+ef/4Fp3BsbR3JvCsOv9RDmQIrhKnLltk9niQLL17gtH+G5khDzBs9AS9rQuBwtUbgC7Hh2waNQngzQW6FhP/zgAssGNIIwELZIXWHvj90E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Mi0BuCs1; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FIbYt3012597;
	Tue, 15 Jul 2025 12:11:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=UuifibMsSlAHuGH5Q9KTr8Jpdxb1I2Sfn76axpGmpjc=; b=Mi0BuCs1dieo
	qJQ25BWUKPR9/3nECR+XzStV9xDu5Rcab21k2KHX0xup+/wJe5OJsjz55xXKkBzJ
	BrlpFEpUbIXdDRaa0Tz/uTNAYfbCByK09fNU29ga9an5D7pDJunlQgitsR/g1uhN
	YsSXMRldvOenY+4DecHZRVKSQM4dVADuo1NSNhTTyR4X1+o+7B5n/OtpmmqQxSKF
	gfnwsQ0QZhzs9GPNDJ4sGTMta9t9cZeip3bXVY1hwsMfQ2JH7M/bDp5pnbmR82+n
	e31+N0uXjE4f24hY4GxBhyykpC0KCpz56AeGW5A7KXrQOUTprKkjuhyK90ikP0Mj
	bEl0opxNUg==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47wk86n5xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 12:11:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEmoPaYK9GUbQHxENPsSBtndH6UWGsUYm9E7LosYMEPTuCM4n5qJIyJ5C/AIORpGwp4zNi33Kr34YEPAV4bOeE2A1v8X1kXsueUp+p5y4tMm2dhpOrfqQXkCCRetVymhDMzCgMgomityu/SyeqkISVnRL9UeE4Y6M0T7sKbd74glW3nAN9rOhwk2cPBZeliCOwTg46NKRRoFVV6lZrBdhp0fOGlBIxWUWaFyRv+t+lCaijC62VW5aN/bG4BCUx8NpI9MnG9s4rT/vzl90vIqvBgzamImrJcnCDQM1fGXaZA9gwrLyW1GSnfIRgkJC3EPRwK69LIqNfUTa6u7JWPqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuifibMsSlAHuGH5Q9KTr8Jpdxb1I2Sfn76axpGmpjc=;
 b=IzY5llLlPuif3grW341o0BBcLBLGCgkRjHb9Kvn0hGFjKDBqYQaQnFarTE7f50Ktbnwz/EfNzLXxqBMPeaWfyvJQca7gXD1vpAtwxj/BikHJ8/Hu1rh2gAC262jeQxiqkcnAyZbMYG6LjvPwD109eifnuZGTH/eTJrnzoo5D8vY4Z2AkgtXOL7Ct4L6e/DJ+M6mF1QfNffXHkh+R5SUZZi7gzgdKSNRLw/BYBtIDnLHMGiPFozWeIOs1iC33+hOOduAtkmjwR5zZnhp1CzVbWweKNkzGnqWJfMEGvm6Z3Rnx4NiS/qUFKo+y6g27RQFZz0/Wdfw/zvKOqcrxQVN5mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by MW5PR15MB5241.namprd15.prod.outlook.com (2603:10b6:303:19e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 19:11:25 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::2f8a:961:d95c:3b35]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::2f8a:961:d95c:3b35%7]) with mapi id 15.20.8922.025; Tue, 15 Jul 2025
 19:11:25 +0000
Message-ID: <0d86c527-27a7-44d5-9ddc-f9a153f67b4d@meta.com>
Date: Tue, 15 Jul 2025 15:11:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] sched/psi: Optimize psi_group_change()
 cpu_clock() usage
To: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
References: <20250702114924.091581796@infradead.org>
 <20250702121158.350561696@infradead.org>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <20250702121158.350561696@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0040.prod.exchangelabs.com (2603:10b6:208:23f::9)
 To LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|MW5PR15MB5241:EE_
X-MS-Office365-Filtering-Correlation-Id: b9d7962a-036c-4ae4-0617-08ddc3d36484
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnFuR1pBNkJ0RmlrSmp0MkpPenFBVzFXUHhQblZGRFM1cjRjNVpSeEtScUZB?=
 =?utf-8?B?NzhnNHpvSEdlRjRoT0Q3MERvWG1FTGdHYWs5WTZPdFVuYkhQV2Y1Q01lREdI?=
 =?utf-8?B?TGF6d1ZMUTJDKzVCOWpmUnhDN3pjdXdEM3ZrOXJTdlBJd3hLbXU2V0Mrd1o1?=
 =?utf-8?B?MDhTUU9TWkRKaVdhS0hMaWZkS0Q4cDA4UnZRMVA5clIrSFBLTGFvZkpTVFBB?=
 =?utf-8?B?WWdpckNJQkxHVFU4bVVtd1Q5TDcrazNleXlwTklZYUQ3ZFpiYnJ1cHJVcGdK?=
 =?utf-8?B?MCt6RklVTE1hM2dPbHA3TlQ3WDNiMVBJUC82R09NM2JvNHNKYUFkRGtVV1gw?=
 =?utf-8?B?S1BJUDNYYXVhR3BJb0d5TkVGM0Q0dm5EaENkSE5RR2tZZERqaU5PRm5NZGgx?=
 =?utf-8?B?c1I2d2xDY2JnbWo1dXlEQnpuVC9IYWt1TGduRWNCTUQ2SEM0VkFsNDRBYVJU?=
 =?utf-8?B?NzVxSHJ3ZG9tdFhWRXVhd3BXeFpwb0F0LzJEb3JpVEhQakI4dmdNWnVjdnhs?=
 =?utf-8?B?NDJxNnRPR0xvUE80V2ZybTZJVWNWc3Rzbms5cU9SRzVSYTAyNUdtNE04eFlM?=
 =?utf-8?B?TWxnd2tpRGJtc28wZzVuYnhYUFpFK0pqOTVTQjlHdFhUYzZjYkVCcW9Cajgy?=
 =?utf-8?B?NTE1V2xYblh5akdqWWtpWlhYaTZ2VlVydFQ3cHoyekljNXlzRHlvMGhXNCtS?=
 =?utf-8?B?TElFUEdqVHNhVko3STNYaVM0ekdOOXk0aWJzSUcvMWdIK28wZE1WajR1WGNY?=
 =?utf-8?B?VTh6YlZLazhKMWM1NUtvOUszd3ZHVGtKdkpmUGZGejNnL0lTbHFIV0hRaTdW?=
 =?utf-8?B?Q3pUVlo4ZWk3MG4yaUZrQkhvMm1GREhVQURudisrdUlQRFluTDZGaGxoRmMz?=
 =?utf-8?B?aW9ZNTVnS0hIc0I1M3Z5Tnc3WkR3dGIxLzRhM0JTcmtWRnFZRjJ3NHpUeXRZ?=
 =?utf-8?B?QkU2ejhnaVpib1I4VExOQ0psYWRHbklkc05IOHpvVU11US9nTmJFQmRFK3dh?=
 =?utf-8?B?Q2d2dGlvUndaNEx6Mk8wVXZTOGpONGVOcmxrbWx3d1dIQjk0UjA5bXZEakl4?=
 =?utf-8?B?RmVmNmpIUHFyYmxMUFcyTFd3NWRaV2tSd00zQ1IxYlNHRUVnc3ZmeXNxVE5k?=
 =?utf-8?B?TTkrMTZ6YjVaQ1lXR204Yld4WjdtZlhkYS9aNDRocWJQd2YwTTA5dCtLNms4?=
 =?utf-8?B?WHlVOXFHVVFQNGg4M00rUXNQdVFUQVBMdVdoc0xvbEtOOFRVVWNDd0JueFVh?=
 =?utf-8?B?L041Sm10T1ZlczBpU1lnUmxhdXlDVS85WXo4Vkh0dm8xRjJiMGFZbWk0UXZh?=
 =?utf-8?B?Zmt6QzRNMkc0TWo4cTlnOE54Q2VyYkErMW9UYm5MUFl6Uy9QR3hPSzc4bjVs?=
 =?utf-8?B?UVYwRGloM1FTQUZoS2Q5dzI5RUt0RWJWdDJhMEY3eHlEUXR5bWxyM255RXJl?=
 =?utf-8?B?RlhoMXUxUG4vajJuY1RPNTlobUNqZ3hua2pYVUEvRWFRSlUrOHFyZER3MEVk?=
 =?utf-8?B?MXpkSDVCc1VOZVhJN0JyelBDRmp4VG1NcW9oK1RUc28xdlFaWDJxVVFqWm9W?=
 =?utf-8?B?QWJBbmluU3BDVmpySGRVVFNMQVdiSDFFRWFaUmp0TlZncEIwOG1lZG43UTJR?=
 =?utf-8?B?QkhnQ01FbE51NStQdi9hTExqMU1OOVlRNXB2YmhoMi9yUjZDZ2kwVW9Gd0RG?=
 =?utf-8?B?MWVybFRRRmIxaWlFbXRaOVVvRjNWbkUrUjErWjlYSFVsR0FuaDh2dWZVUG80?=
 =?utf-8?B?dWdqVFRZZzA4MVVha2grWXJyZExpQ2VsU2V3NDE0R3hBOE5SazR0M2hjUHc3?=
 =?utf-8?B?TWtyQTdEdkFzWFlGQitLRHFyM0FrK283ZklZNEtYWjBvQmxYQytmOHVsWThT?=
 =?utf-8?B?b1A3MUc5bmpLWDRsNGN0c0tDOWQ1VEQycy9HT09jT2dvbWJ0bzZoTkY3S3Rk?=
 =?utf-8?Q?+mzN6Ef9sKw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REJrQk03L0RSOFkxVXR6SkhuTngyNjhpaVVZeVcvdmZYZE5ZTWxvdWs3cEY4?=
 =?utf-8?B?bjJ1TDBxQ3dnKzhhT3NFUHVPMDE4eTltdUtpUEFnSnVnYU83KzZqZ2YwNUgv?=
 =?utf-8?B?UjI1RWpTU0JZeEI5OGJLajVOdkdKd0drd1BsSlNKRi9BYVYyMndaSk9pU3Z2?=
 =?utf-8?B?SkJYM3p4TDJFRWdjQUN3MnpPeTJGaHBnVE5MNGZKTnVyTDF4TnZzTjUxc2hi?=
 =?utf-8?B?Y0RRSTlzbVg3eWtZanU2a1poalZZMkFBMTEwSHJDblJCMUl0Z2dKdU9pUHZ5?=
 =?utf-8?B?VEU5VDJtcEFIWE9kdmRyczhtUS9PUnhVRU1xNXNyTUJFRWtJSzdkVHFLNmcv?=
 =?utf-8?B?WE5GMjdYQ1V1WG9YZnBNYlRERVlFMW9jajBlOEFaU1VkczhxRCs2eENlY2J1?=
 =?utf-8?B?VFNZa2VGL0ZvYTBaMGFoVHcrOWphak9Hc3JRS3RMQ2lyTDNXaXAvTVdDb3Q5?=
 =?utf-8?B?RGwzM3pKNWN1dGtFUnhJU0RZa1UwSDZrbjVmQWhEZ3d0bWlSNTdFS05vR3py?=
 =?utf-8?B?Qk5pdGFEMTk2ODZXWTJTYzFERFIyN0wrRWU2MGZ6dWgrbG93NVl2aXRRc2Zr?=
 =?utf-8?B?Wkkya1VkWHpOaEJCQnRpRzNYUHVlQXY4TjI3Z1dyMy9iKytERERtRWtBOHE5?=
 =?utf-8?B?SGZNRUM2VkxPZFRsOHo5NEs3WjBVaWZhSXpXNXZjVEVjenNLVU10VzhabUo1?=
 =?utf-8?B?ZGxxYkl4WlN1bVMxVi8wZ1V1Mk1jMlkwbmo2SUZ3dkFaZE9NV0h5dTY3UlN2?=
 =?utf-8?B?VGM2WGpTUldKOWpuU2U5RWVIK0VyamVrU2tNRjlPR0tPZHMzMEUyWmdPZ1ZN?=
 =?utf-8?B?RU54aGhMc1QzQkkweDZTZUlLa0x6L0NHdXFwbVY0bld6SEtSQ3IvWU92T0Jl?=
 =?utf-8?B?Yk1rUmZUQXByeldMN1QyNzl0T0l2YVRoUjRBdzh2VlNscUNTeVV4TEhhd3pm?=
 =?utf-8?B?ZzdVR3FlS2NJaW9mRUJ1aWZSWlUvUFptZEVtMDkzOEdjdUZWZDhiZHhEK3M5?=
 =?utf-8?B?OGk1NjYxb1lhbkhQZHhKbVVabnZlVmwraDR5OC9sV2s0VkdqU25jSmJxcXB2?=
 =?utf-8?B?VDJjVnZaaVA2THFlWkxMQUpEWjViQkdsQlI0TXBVV0VGQjVrZDVSc2xNR3ds?=
 =?utf-8?B?TVIvWEprRk53MHp2YW1RYkNralgzeW9aTDV0MDVpcGdrOEg3OVZQSWdsMkc0?=
 =?utf-8?B?alV6NnZCMVYrT0NUTDIwUENQdmpNWUQxVVdSQ3NaZHdnT3RsY1JDYkdZUlBh?=
 =?utf-8?B?ZjlzbTJnczQzRC9SK1I4VmlKLzRlUTVKMEh6cTJMU2t5MXFkTlhrUDN1NDFP?=
 =?utf-8?B?Y2s2MXFLSzNHMVRvOW93ajdnQUFrMFJoZkFqYWJManFMOVdHR0NGMEJPK1hn?=
 =?utf-8?B?NzNhR1B4aGVHdXZVVGVnKzN0OFRtME8xSG5YR1YrZ3hqWVVWMEJvSHBsUDVW?=
 =?utf-8?B?cWZ5d09uSk96eTdNMEYvUStkSTlEZ1B4TjRwQklKMGN5WnkxaEp3QXVkYXhU?=
 =?utf-8?B?d0orVzNjbUNCYjVsQU1KcmdlU01ob0hoemcxOUhJaTI5c1VLMzRTeHM4T2Ew?=
 =?utf-8?B?S3BMc0ZFVllpNE1DVCttcklEbHhST0d1alZwK1dQQ1V3R2h1SFpwMjNPbjhj?=
 =?utf-8?B?Qko5OTBTTmlUaVNrbEFrcHVRVVVuTlBad0Y0Vnp1RVdIcTgwTHppcnliTVFI?=
 =?utf-8?B?ZjlkVUR4NG50U2ZvcFliRnE4bExCN1hyUGcrdHJ2YkdHcERDNnZTdTVxbWN6?=
 =?utf-8?B?Zmw3Ykg1alUwRDZSOEYxWXhVRlJrQ0hxdGovdGpaV3hvcDBQc0sxUEt6SWNI?=
 =?utf-8?B?c3hNVjRLaUJURDhGbXY0RVNva2U1Z1hZazY5WmhSVHVDNDV2T21Gb1h5QWEz?=
 =?utf-8?B?MkhWSnB6MEZlMFpIS2MrNTZveU9qOXRRTVJkVHVOVGlIWHlHd29rZ1VISjh3?=
 =?utf-8?B?dDlaSjUwbFZYd0J0Ni9TZWIrU0hzT3B5Nlo0Z0REaU1VYXpxU1B5LzQxSWsy?=
 =?utf-8?B?c1ZYcklBVlhSMG5VbE5IWFhFb1o3UmtjYUFQQ3VXajhSR1F3RUZyR0xYMlFX?=
 =?utf-8?B?N1pTUWw2SHJrOWpSdnpoWDNTNEpXUTQyR1NtN3g2NVpxSmthcWZDQUhzSDVU?=
 =?utf-8?Q?rNMo=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d7962a-036c-4ae4-0617-08ddc3d36484
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 19:11:24.9767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ts7Jzxkx+HdDhn5PED2/cODMHcAhqUZvr4NGzqPjCVFgGc9nJndu5UwBoGIzTO2B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5241
X-Proofpoint-GUID: HuThtHuH30vgoZJbtVPiDJoF7YMzHE6e
X-Proofpoint-ORIG-GUID: HuThtHuH30vgoZJbtVPiDJoF7YMzHE6e
X-Authority-Analysis: v=2.4 cv=T5SMT+KQ c=1 sm=1 tr=0 ts=6876a7e0 cx=c_pps a=jQuO6sawZVmGirNBLKPjUQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=WsHKUha7AAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=ufHFDILaAAAA:8 a=90SR26LeqPeVHm87JbsA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=QEXdDO2ut3YA:10 a=H4LAKuo8djmI0KOkngUh:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 a=ZmIg1sZ3JBWsdXgziEIF:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE3NyBTYWx0ZWRfX/IdxGhz68Ryj IsWREi/FycD1CtdepODQ7RjFS8Uo2j7zHt0Slm5gBIsFTFnLPOzO33XGR2bCfofi6OHZQ4k7os4 09mHhI1btFcLkC3Qj4g9Auc62fXHTCGYy/vvOjc+R+toJZoMullnVob6d5PuR1gyBxowAou2/Hk
 1GCG1wZkm/V+zRUDBlC8uASiH3Ncx3FSdaytNXijNDvYa6k/g8GxsVs7CsYSLlCx2c6Utj5mNkK NkvPe6Kp2PvcEvKeAScyW0ZAMzCifJ/fAkv5MTWsPBT30UFK9Y8vqidjh2DdYTJxmHSQllCKA6x TzlP1UOuA3Hv4UP8SyC3zbF2cA8/GWAjZVp/2U3+nGSQsJTPk3ZO1ItlNmSxBo7fh0CwaHpmJkE
 uFsihzJIGYKNslXIpyuAvJyxlvpKegDcO+6b8FRtMdZ1225fz9nYKNRTN44V0DXNAWJrjkOC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01

On 7/2/25 7:49 AM, Peter Zijlstra wrote:
> Dietmar reported that commit 3840cbe24cf0 ("sched: psi: fix bogus
> pressure spikes from aggregation race") caused a regression for him on
> a high context switch rate benchmark (schbench) due to the now
> repeating cpu_clock() calls.
> 
> In particular the problem is that get_recent_times() will extrapolate
> the current state to 'now'. But if an update uses a timestamp from
> before the start of the update, it is possible to get two reads
> with inconsistent results. It is effectively back-dating an update.
> 
> (note that this all hard-relies on the clock being synchronized across
> CPUs -- if this is not the case, all bets are off).
> 
> Combine this problem with the fact that there are per-group-per-cpu
> seqcounts, the commit in question pushed the clock read into the group
> iteration, causing tree-depth cpu_clock() calls. On architectures
> where cpu_clock() has appreciable overhead, this hurts.
> 
> Instead move to a per-cpu seqcount, which allows us to have a single
> clock read for all group updates, increasing internal consistency and
> lowering update overhead. This comes at the cost of a longer update
> side (proportional to the tree depth) which can cause the read side to
> retry more often.
> 
> Fixes: 3840cbe24cf0 ("sched: psi: fix bogus pressure spikes from aggregation race")
> Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>,
> Link: https://lkml.kernel.org/20250522084844.GC31726@noisy.programming.kicks-ass.net 
> ---
>  include/linux/psi_types.h |    6 --
>  kernel/sched/psi.c        |  121 +++++++++++++++++++++++++---------------------
>  2 files changed, 68 insertions(+), 59 deletions(-)
> 
> --- a/include/linux/psi_types.h
> +++ b/include/linux/psi_types.h
> @@ -84,11 +84,9 @@ enum psi_aggregators {
>  struct psi_group_cpu {
>  	/* 1st cacheline updated by the scheduler */
>  
> -	/* Aggregator needs to know of concurrent changes */
> -	seqcount_t seq ____cacheline_aligned_in_smp;
> -
>  	/* States of the tasks belonging to this group */
> -	unsigned int tasks[NR_PSI_TASK_COUNTS];
> +	unsigned int tasks[NR_PSI_TASK_COUNTS]
> +			____cacheline_aligned_in_smp;
>  
>  	/* Aggregate pressure state derived from the tasks */
>  	u32 state_mask;
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -176,6 +176,28 @@ struct psi_group psi_system = {
>  	.pcpu = &system_group_pcpu,
>  };
>  
> +static DEFINE_PER_CPU(seqcount_t, psi_seq);

[ ... ]

> @@ -186,7 +208,7 @@ static void group_init(struct psi_group
>  
>  	group->enabled = true;
>  	for_each_possible_cpu(cpu)
> -		seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
> +		seqcount_init(per_cpu_ptr(&psi_seq, cpu));
>  	group->avg_last_update = sched_clock();
>  	group->avg_next_update = group->avg_last_update + psi_period;
>  	mutex_init(&group->avgs_lock);

I'm not sure if someone mentioned this already, but testing the
series I got a bunch of softlockups in get_recent_times()
that randomly jumped from CPU to CPU.

This fixed it for me, but reading it now I'm wondering
if we want to seqcount_init() unconditionally even when PSI
is off.  

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 2024c1d36402d..979a447bc281f 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -207,8 +207,6 @@ static void group_init(struct psi_group *group)
        int cpu;

        group->enabled = true;
-       for_each_possible_cpu(cpu)
-               seqcount_init(per_cpu_ptr(&psi_seq, cpu));
        group->avg_last_update = sched_clock();
        group->avg_next_update = group->avg_last_update + psi_period;
        mutex_init(&group->avgs_lock);
@@ -231,6 +229,7 @@ static void group_init(struct psi_group *group)

 void __init psi_init(void)
 {
+       int cpu;
        if (!psi_enable) {
                static_branch_enable(&psi_disabled);
                static_branch_disable(&psi_cgroups_enabled);
@@ -241,6 +240,8 @@ void __init psi_init(void)
                static_branch_disable(&psi_cgroups_enabled);

        psi_period = jiffies_to_nsecs(PSI_FREQ);
+       for_each_possible_cpu(cpu)
+               seqcount_init(per_cpu_ptr(&psi_seq, cpu));
        group_init(&psi_system);
 }


