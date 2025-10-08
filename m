Return-Path: <linux-kernel+bounces-845796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9134FBC61EB
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 19:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 711D24E8C56
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 17:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1EC28D8FD;
	Wed,  8 Oct 2025 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="GFHL23jj"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022093.outbound.protection.outlook.com [40.107.193.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAF01E32D3
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759943187; cv=fail; b=b5yYRxuCkq+99nSeGhdwiOoARxI2zer0Wf8LC7gk4slN/aW4vI0qp0wQpzRkRowAyJBgQNtRez2uGLtfxqG4BhXHv+/IgeyWVlZ/4wI40m+Xv5+bCgixPSkV04Ph9BBlSZcmw/wPKRNZaJgRV7+hBf7Nt7zKSG3v3TD5CKXqRyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759943187; c=relaxed/simple;
	bh=4UromtNQlYUPJ+kwM61YfhL7wRKBqscHxJpP6kFugTk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kLhdVRadeKJK8KovzsYEc+An7VBhjzDC2A06Gte09tYUppaphPVzOFoOAWzXnUmGj9/tK22eVNL22owowR+OGX66Naxie8IppMFy23DDgQ1Vr28jbmV0u8KzDtMVw0KkMwCr2BF/FTWG04h8HEIzViIerxbFrmVOX7j2wtFIpck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=GFHL23jj; arc=fail smtp.client-ip=40.107.193.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wckx8KQpImK+QA5c1jNfbZLdUGfsI2Bq3q6WrGwo633SEZ16nDGC4+7TG5lqeiWpb8wXY/AusIwbPasklWjgEPHBKccHtG6Hu8gxUpraicc7bGuzOBDYABXQfNM+braEAC6LSfmbuCam/BZ4YeVF9faEge0ZTCU6sn5LHHnyN0m+Ztqlxs0wuss9J70tDXxdyS3TMHVynnTpoo7nWxBNFs7Xp/E8B6kBL3YCaoq+x5QdFK3XvmB3AjKugjehKn6RcFiSXY5ZZFkTeyN6yCRDJpMwzumMuT20IMdpo3EyX2NvGe20X91TvIAyY2WCNWAhvijYP4u7twnqscmoKUl9yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lc9hHXKwYwwyWaZyEJDcigjT2Uh1UV5K/d5MxHx2+G4=;
 b=mmbHmDBFd8PflhnZjIUa13kJtP+QIRbPtlkbM9W3DXsuvQrNiOe6rYXlov0lVw/9m2ZfLsqrPnw8jE763fL9sSOcF9L9rhIbDRnu8GiohOTiRpMlaJK14Yxh7HXucrWfhMrk4ULWo8oI4XeKnUNqOb7cN4oSRU1uNhi89lZFltpPnEgUDPD9Ik0UrloalOUJW/B0kXBJHMb0B7EBrjTYW52Rk/KYKKFgaQmI4CYvKOeDzQz+U+hvsuqLcjUbshbyjjn6BT+dbw/f7DjnYs8vQBAerU0LCi07W8aQMg9tSrAO2Iv0ufc5novICFZYZ5hwoSchk/nR6k8/sJEStcWs/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lc9hHXKwYwwyWaZyEJDcigjT2Uh1UV5K/d5MxHx2+G4=;
 b=GFHL23jjWszAeM/Fj5ikboTCerW1SxXMmkFHln7mPe++9cYMpHjPmD3hJfx7/4giw16BnCgooD2iMtfZ5oKU9ek7jZOponuj8zy7WJMBRqSCT4ReJQczdxPmSdBxaht0khA5yGn/VK7r3dz6oDw5xFcPZOJeACBS8aS+OihEnalfihtTZ1OaTW3Z2FoNXjD0Yj6yNuMeg8YRPSuMbo0y7nzxmEuOKLuKfR8FP0cSUawtTMbWrHYhGUxwwcdUEwd8xfUBRHrxF8XRJwNAApEdLDm1QuBXkwl9HFcuzSarde/iyXzgGcgoxt73nC7x9iKtkEZS58gDgzs7HURaZzL9iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB8944.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 17:06:20 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 17:06:20 +0000
Message-ID: <1a0b35d0-d739-4f1c-9a50-95780eed02e4@efficios.com>
Date: Wed, 8 Oct 2025 13:06:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smp: simplify smp_call_function_any()
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney"
 <paulmck@kernel.org>, Rik van Riel <riel@surriel.com>,
 Ingo Molnar <mingo@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>,
 Roman Kisel <romank@linux.microsoft.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel@vger.kernel.org
References: <20251008165746.144503-1-yury.norov@gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251008165746.144503-1-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0101.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::20) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB8944:EE_
X-MS-Office365-Filtering-Correlation-Id: b972fd69-0015-4951-4c2c-08de068d0026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUphcmZCck16TjN2anBHSTcvSml2em1pWVFwU3lpOHRVS21wcUZVQlhKN2ZE?=
 =?utf-8?B?em9zVW1FNUJ5UUtDRHRZTEY2UG8vb3BqRlBwR1R1R2dvSEpIZDNkNUxNVXk5?=
 =?utf-8?B?SE9ESWpiN25Oa0lGNzh6dVNNYzVwTmllOXhkWlpwUXA5Y3VycnhSTk8yajlq?=
 =?utf-8?B?ZVYzdXJNallBbmZDNWhqMlE2WW5hWGtzeWl4TFJ3UTA0aFFpWUptaXBFcG5r?=
 =?utf-8?B?RXlJR1RNZUREWlNneXkwMk15cWdGa0VCeVEwcXF2SjAycHN4VEVGWjk2U2pI?=
 =?utf-8?B?dWxLajlDN241d0RaU0E5Y1JCYmhKTitpMWR3ODV4emZqUzREc2piMXdmRGdr?=
 =?utf-8?B?aVR0RWxDYklQRTk2QWwwV3RuYXZ3aUQ1RjhSaW1qVk9ZLzltcG0yN21uWjFQ?=
 =?utf-8?B?Q1ErMVFpRWIxNnZOaEVJN1hTNkcxNTk4RFVvdnhjSjNSYzRMNHNKMXQzdGM5?=
 =?utf-8?B?YlpsTTAvMlc2RzBRZ0QxSm1hWVBZd0I2SmF0RUxDZXN3em5uYUdQSzZvUXA0?=
 =?utf-8?B?dDRjWE0xZDhFSjZrNlNsRklyVnVHemlPMytkdTFZc2xWZDl5U3pkSmRST3lO?=
 =?utf-8?B?OVV6cEYwMXBYRUoyYUlwUC9oYmlKQnNFNVgxV2Z1blBoVjR3MmFqaHVpMXZj?=
 =?utf-8?B?aVIweC9zOU9XR3BWMGw5Y3lqZlM1dEQ1U09tQ3ZEV1d1QzBMRWI0bEo4Z0RM?=
 =?utf-8?B?NE4wZXdFL29GekY5YUxBTGNGYlFWZ1RUcWRXZjhiT2NndkVlNk5IYll5azBl?=
 =?utf-8?B?VzhWTW5qUE9ORnd5dVpDbFNQRStIOE9lZFE1NlRCUytValRZaUgyTU9IU1Fz?=
 =?utf-8?B?ZWF5Q1ovbSs0STFETjJDRS91cmhicjR4SUN3WWdkR0s4bmpjY1BUUnJGOXQx?=
 =?utf-8?B?REpjZEw3TmNwcCtjaTQrYWR1WUlDcGNOZDIzZFhLVTNzbndKdUdTcW5udVBM?=
 =?utf-8?B?bE0yZG9yVXVCeE5LNnozZHpIc0x4SW5nYVJScWhnc01zOVNZcHJCc2c0RjZU?=
 =?utf-8?B?YWk1WjlOVldkSzRqQ2NpbHJJRVFDakNsblJveThSamxJNmhwWDBZY29paDlM?=
 =?utf-8?B?TnVlVkhaRWt5dnNUVzFVL2x5bC9HTHd0eUM5dkRiOC9ibDRMMWJxUFBlUjdK?=
 =?utf-8?B?Z2lhZlUycGx4S1dnYUl2eUtST01pQlNwcXExY2JWZDRNRmJIRVpPM0xJVkd3?=
 =?utf-8?B?YTFLQUoydnZvTHhRL1dISHFabnhhQWdTZDErZmx5OGd1RWFhbDFjNU1nNGsz?=
 =?utf-8?B?NXcvNVhsYzdpeHB3QTk4eVpxZ0ttZm1uUnp5WkpTYXRmREJYWEI0K3NuZzFD?=
 =?utf-8?B?TkQ5N2l1VE5sOHNvdDZTMlVRRHpjWitaanZ4RnROZzRhRHRzbTBDazB2QVp5?=
 =?utf-8?B?Mk4vdFdrZWhLMnRqNTZtU1lqMDFsVVRFb0oyRE9MQkJQdndaUDVqb2ovako0?=
 =?utf-8?B?Nm91QytmUzgvcE5uclhBWlBpVko0RW0rMkJRZmFHRm5sZ201Zzh5dWFydnJU?=
 =?utf-8?B?S2JRekVpcHRDQ3VZdEpTbndpdkJ2Ukk4TWI5ZEt5dWxOclo3YnBiNDF2RWMr?=
 =?utf-8?B?TGhld1pBOUdPWlNJYTJVZVJ0bWovTnl3WFBpZ1FtWjRTYTg2OXBHU3g1UVpG?=
 =?utf-8?B?VXNlZ2F3QytsVVZCdDVlcndHMWNNS0tkYTFxUG14dUFmYXI3UHVtZFg2MUwz?=
 =?utf-8?B?dCtkOUtacWREMzBsandqZ1ByUnhxOHVZMkI0TFN1UGMvV2w2eDA1Nmt0WHR4?=
 =?utf-8?B?WUpsTTUzc3pRR1lieTg5N1AyNm1YZmxEaDc3UEJ3WTI5UGswcXFNUW5xTzZY?=
 =?utf-8?B?a1pTTlJIM211aldjY1R4MGZLL1IzOGMwVEVEOGpyQjFycGgzbWRhQjRxU1hx?=
 =?utf-8?B?YUZubEp4aW5STnN2SE1EWHJuU3hlMjZVY3lOZzBkSHhaN3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUJybVd0S0tndXY4SXJGS2xyWGV6L3ZUbmJqU29SQXY5Wk55djBPaXRzRERE?=
 =?utf-8?B?cG4yREg0QWFRUldWZndrVE5sMVMybUdSMzJ2Yk5Lc2YvV0VwQk9uYjJ4OGtk?=
 =?utf-8?B?a1pYUmFSTkxndGZ4OVVIb3J2Z0NIeDJiMmpHWVp0aURpdVE3SDF6cnB0dC9N?=
 =?utf-8?B?MU1HalRsS1d0VlRwN3pMS2JyMGY5TVIxeGZyUmtHS29vbDM4WjNrNzNEZFNr?=
 =?utf-8?B?c2FtVjJTT1VBUi9HWTVDa1pObU1veDFXYUZMNXFVZXBMeWZoRlQxclozNFJz?=
 =?utf-8?B?S01FMGNMSCtCWEE1a2FMcEpBWm45RklLOGpLb2RUdndib3B3ZklJbFNBZDJN?=
 =?utf-8?B?ckRhWm1vakp5cnZ5ZC9NOVNPQnlTbzIrSjJlVHpWQ0hzYXd5TzJEdExKcVMx?=
 =?utf-8?B?NlFvK1cwTWZzZkdZd2VUZWFGTEh6Zzc0K1B6c0Zzc1NlNStBNmJPR3VEVTJ2?=
 =?utf-8?B?bTQ2azI1MWh1cGd3azhITEs3M3hqazJFcklzbThHM1pacUtyRWp0QnhsMW9X?=
 =?utf-8?B?L1NKQnhJaStYNWhDbi9VRmFHcGh2amdlWTJvZk5LRUc0YmcvbVNPc1ovQUE1?=
 =?utf-8?B?LzF4NFhWeFc4dm9WZ1A2Q1VtS1ZLSXFXR01BbmxRQ0duTWNTSno3dzdsWHF6?=
 =?utf-8?B?M2JrYUxWcmxFeWo2UzdUdUorcW8vSE5MU3VUMVJMVDY3N1NiZUQxT2NNT3hp?=
 =?utf-8?B?OHlQRU9vWXV3ZW5sV1FyYWMyRDA0L3Q2RHNKcmNQR1pzSHAyVHovdmZtNjIz?=
 =?utf-8?B?OEsvUGs4ZUQycDdzYjk0Wk1XZ1JhZ0ZhTzZmVDFDcUQ2SUFxMU05Z2VNWERM?=
 =?utf-8?B?ZHVvNVpQdVBuejdGSGk5eitGMlVaZWYxS0xGRVZxZ1F6TEJYNWxGVWZUSksw?=
 =?utf-8?B?TWlseHErdWNmaksxVW5tTG4rbzJHNEpQc0lUTTdqUEl4cFV3TUUyUTVBSWNV?=
 =?utf-8?B?cmsvRHV1M1VTWW0vcXYwa1B2UU5TOXNLZER0R0FMTE9PMUJrMlY1TzJreVU3?=
 =?utf-8?B?UGFqN0NlcU9Nbkc1UlNiZVNGSjdvdkcvWUc4N1haWThwWDk1bjRURkgyY1dH?=
 =?utf-8?B?azRHVXFNWXllNUtKS2lGU0ZTOTJFNHNjb0MrUVljSlVFN0IxeDV2cnRlSHVl?=
 =?utf-8?B?MXBIYkl3ME1uR0d4d2ZxaXV0dHphT0V5SGhrdHhzNUNHdTE4Wk91bDFCdklK?=
 =?utf-8?B?QVQ3R3B1cDVHVVV5a1BsVGVwTEhtaFRvczBVczFUZHlFZGVkeCtQbHdqaU1u?=
 =?utf-8?B?bWxaYmRqelNMa3RvN3QzeHZHQXR6alJMRU9iUUp0bVp3VzhNSTQrbTZvNGVu?=
 =?utf-8?B?Yjh0LzlmdWx6MGg2WFZJOFhKTkcwbUxBaitSMUFIaUFVUy9ycXAxVzZrMVpQ?=
 =?utf-8?B?SFJBcDJvUlZmam9pT1JXaHNMWTZJWlJHU1ZIVGViUHZZc0lTSUFnbnNQOEpw?=
 =?utf-8?B?Z0hRRFFVTWRObFlRZ3hRSldndFF0SlhxQWpqMWN4TnVXckk4enA1clpsZWN5?=
 =?utf-8?B?U3liVVQ5OER1QXl4TjVWalpUeGIyU1c2SDEzSHlSYVNHc3lnS21NNXg5THM0?=
 =?utf-8?B?VGc0OHhCdFpJb25BbFpndkZKOG82Ty9BbEMxZ3Zqekp5dDArNzhJTWFzc2RQ?=
 =?utf-8?B?d3J3S1hWeUlYNTJZeHRYcXZjT3pJQThVNjluazVEWjZVbHhPUTZPUUFscU5J?=
 =?utf-8?B?V3NaNHJJZzAwVWlUSWVCYTI3YkYwaWY3bEhuWlFiamF6elZxRTlWT0FqY29R?=
 =?utf-8?B?dUhGOE51Wi9yR0JxZjlBaFdPbkZVWnJFTkZTQ205cEl3Rm55V28yQXNYK3dU?=
 =?utf-8?B?azlaTUlJNVVWZEZWY0pOU25nUHJ3ejFCZXJPMzdib1NZZkhOQ0tuMzE0LzhR?=
 =?utf-8?B?N0VWN2NhaEFEeit4Z0orZWhtazkrb3pEZW9uWWU4OXpjeHhONWs5d1VQc2dn?=
 =?utf-8?B?bDllZFhITkM0UGJNbTNlMjFKNk81ZjhRWlVLYVpxOXZPZnJ1ZDZmUFUzSFc2?=
 =?utf-8?B?WEx2SGFQVXk0TUQ4UkRoVHFnRDBYMkxPNWhZdDRDaDFRWW85WThzTkV5UFJw?=
 =?utf-8?B?ZzBFSWNxQ2Q1ZVN2dGdPa2loeUNkeFNscjdLb0lwNVdUazRWKzRiYTF2SWth?=
 =?utf-8?B?azBkZTBTR0VQUjNJVXhFNDVpUVhDM1BJcFBSWEZiQWl3dWlBcWMrSlhCcENa?=
 =?utf-8?Q?0VhMuTaeVSLPzDcfLSzLrcc=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b972fd69-0015-4951-4c2c-08de068d0026
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 17:06:19.7401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRRyT8ndCmTGcj3Fws/a4QlFIXEXcqC0XuIIqpC+qM43uCiifh2dj18u27O0lpRcJAPU30SJN0eruyKyuIV/bT/59qxSGbp2GyN6uBhEuNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8944

On 2025-10-08 12:57, Yury Norov (NVIDIA) wrote:
> The functions calls get_cpu()/put_cpu() meaningless because the actual
> CPU that would execute the caller's function is not necessarily the
> current one.
> 
> The smp_call_function_single() which is called by
> smp_call_function_any() does the right get/put protection.
> 
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---
>   kernel/smp.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 02f52291fae4..fa50ed459703 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -754,17 +754,13 @@ EXPORT_SYMBOL_GPL(smp_call_function_single_async);
>   int smp_call_function_any(const struct cpumask *mask,
>   			  smp_call_func_t func, void *info, int wait)
>   {
> -	unsigned int cpu;
> -	int ret;
> +	unsigned int cpu = smp_processor_id();

I wonder whether this passes any moderate testing with kernel debug
options enabled. I would at the very least expect a
raw_smp_processor_id() call here not to trip debug warnings.

AFAIU smp_call_function_any call be called from preemptible context,
right ?

Thanks,

Mathieu

>   
>   	/* Try for same CPU (cheapest) */
> -	cpu = get_cpu();
>   	if (!cpumask_test_cpu(cpu, mask))
>   		cpu = sched_numa_find_nth_cpu(mask, 0, cpu_to_node(cpu));
>   
> -	ret = smp_call_function_single(cpu, func, info, wait);
> -	put_cpu();
> -	return ret;
> +	return smp_call_function_single(cpu, func, info, wait);
>   }
>   EXPORT_SYMBOL_GPL(smp_call_function_any);
>   


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

