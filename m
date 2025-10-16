Return-Path: <linux-kernel+bounces-855791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F7FBE2548
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988F0480B99
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7A7314D37;
	Thu, 16 Oct 2025 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kdvY4WM/"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011040.outbound.protection.outlook.com [40.107.208.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EA03254BC
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760606279; cv=fail; b=Ytl56H/yOf/fS4TbGOiE1u3cafczPnWemuD2RJYB5WUjX7gh3JlGhVeVkZYDcMO+Nl+mHqLkhvFeNNNYwcevZHvKWZUNdN1zNLYxFttMnamdV6/HyxAE5JQmqywMDcsCeQN+4iV8cHJ/rg729Bl7WDa8qLvMPRuHZ1hr4E2zHRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760606279; c=relaxed/simple;
	bh=Us/8ADDxn3KC4+7Wu2EOFv6C61xWPznrn+DxzG+SFt8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B/j1znOi2pGgMArYVmV7ikYzI1VZDNIb4sqhH/rQsGJytuRjjgKgpbQmXo6Ucf5AeEXlqtHP4apNrCJDLys0uf17TXELWPN5QSMNvUfMzktsXXIkzN3Tc4V+JcoNvv4KtfSEIyMYEUVi49k3ecKEIF83fmUIEC3pOwxQ5Cj4Dc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kdvY4WM/; arc=fail smtp.client-ip=40.107.208.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQRXqXr87/HbBZcAA3J2Gx6TcqZx1C4Sb6Adw/k7j0A9+D+vAuhPYQQJiMVYCw47qWoW1imTxJo9GOo1Fsp09KascPhi3DWFurNL7u6IUjzqEKYAzlPuHsI8NWvGwwaVMzC03YyhJ3cqlvNWHvDl0U8lb2B5K+ZWuD0ulDZUJ5EEggDz3PXx9Wi826BoanW7rxWyWdMNsKnilgmG4+ryHqDl/F4kQ6b5Eoqb72Y+G94x63Wymt9c3OJZ5vvJ5/798yXDeqlCirRGeQUlhw0MbITTdI1I2ZOz2EpqZ/jUSmeRSoiU1vk4AI0Zrb1fSbltphVM8IByi0+4b3iaPygMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yr7JmmmfG9FBUtz6GhGSNLURmrEfD/vJY1H7rtvM0lM=;
 b=Pg0a4kJvgmKOISlH3OUSP+4knEwY6rc20PoDbPpbhLuhzn/+WBGeZZNq37yswSBzfA17qQPz6IwT5WPnpEhAVpgwX9kKBff2HLaPee1L8iq/kSugpA6k0ErUvpUC2b9pZvH1A5JBBe7H4ySpbGmrP5VZ0J6VMAtlIqEOrk4OQG/I/9JGSBcUYqvQidwmUFW2JCiPSC9i+mVwl8qtfrKeGqAEZNW34PlxXYyR9lKwnGAW7GT5vEWZVKt/fVpYQL8QT+JGVg7tmOch1plYQRrVe+ErBPYciPyk1zJM7b6/XJlKxs602HiZ9QdfLeN0vdyqxL1m0Fp2wo1DpW2V638tlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yr7JmmmfG9FBUtz6GhGSNLURmrEfD/vJY1H7rtvM0lM=;
 b=kdvY4WM/dQ1+A21rrgqwNxwQwx20ZzSTLxxiZ8o1B43IvW14hkBT1TuG9CFImZmaOid2JxspFmRGRqlO+2hm7UlmNrR9YHG7R6XGUXhLsfLSJDODh72fOkFfmAQiXovLkidduN+5PtSZ65h9RY/lDljs9G6HXrU4CCV4hnI9vws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13)
 by BL3PR12MB6402.namprd12.prod.outlook.com (2603:10b6:208:3b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 09:17:54 +0000
Received: from IA0PR12MB8301.namprd12.prod.outlook.com
 ([fe80::e929:57f5:f4db:5823]) by IA0PR12MB8301.namprd12.prod.outlook.com
 ([fe80::e929:57f5:f4db:5823%4]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 09:17:54 +0000
Message-ID: <b525fbe7-8024-45be-a12e-771e0b8cdbc5@amd.com>
Date: Thu, 16 Oct 2025 14:47:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 4/9] mm/migrate: add migrate_folios_batch_move to batch
 the folio move operations
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
 willy@infradead.org, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 ying.huang@linux.alibaba.com, apopple@nvidia.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, vkoul@kernel.org,
 lucas.demarchi@intel.com, rdunlap@infradead.org, jgg@ziepe.ca,
 kuba@kernel.org, justonli@chromium.org, ivecera@redhat.com,
 dave.jiang@intel.com, dan.j.williams@intel.com, rientjes@google.com,
 Raghavendra.KodsaraThimmappa@amd.com, bharata@amd.com,
 alirad.malek@zptcorp.com, yiannis@zptcorp.com, weixugc@google.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250923174752.35701-1-shivankg@amd.com>
 <20250923174752.35701-5-shivankg@amd.com>
 <20251002120320.00003ab7@huawei.com>
Content-Language: en-US
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <20251002120320.00003ab7@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF0000018A.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::55) To IA0PR12MB8301.namprd12.prod.outlook.com
 (2603:10b6:208:40b::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8301:EE_|BL3PR12MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: 85c73c20-6af1-4ebf-cd5a-08de0c94e2f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Znl6UUtuamVVTDRBT1VYU3hkU0JDMEVvSDdFOE9VZVMxMTlTNmIwQmZRTHpz?=
 =?utf-8?B?S2JhUFdMN2Z2dTEza0dPVTQvZElHQS9CdC9PL1NKTmZ2TVJKQiswVGJ3dGpL?=
 =?utf-8?B?U2Z0aHJPdDR4aUhPSVZtOXBiQllBelB4NjBsdU5oRU9Wa3hQT0U0K0FGZ2NT?=
 =?utf-8?B?UXNNTGhabFpUazhxYkpRT0M2bWd3UERVbXVFbUZXd3Rpc2JzbUZiR3d2UlJ4?=
 =?utf-8?B?MEpWSFdNeXVwOFZOSlVVWVpjN28xakhDUWNWeGhoaUR4MGxCb054dC9WY21o?=
 =?utf-8?B?SmIxaldGOFNmQlJyZSsxdnV1SDZlVmVUdHlFMHBhZE5Ub2E1dUFQaUJJd1hr?=
 =?utf-8?B?V1I3TThEWGI1Y1U3bmcrWGI4UXFCMnBKdzVRcVZub3lMVGlPTGhJN2dmRm82?=
 =?utf-8?B?WnMwVXBvNFdGbllUZFUxYnJtWFByY3FMUUtMMjhFRTdJM1VtdjZibUFBbDYx?=
 =?utf-8?B?QUFKZW5RZ0NkV1VMWEFkdHp4UXVLcW9EYlRVeXFneWN4ZXcvTzN5dUxmTHZw?=
 =?utf-8?B?ckZaTmNCUXg0K21yQ0RQRyswQndldGVDdkVBL0paYW1IUGRrRnkzSkFYbGtT?=
 =?utf-8?B?LzYySlZmeUcvb0lSWE10OHVTOVFmSTA5dllmbHJCZlZRcXloZWJXRjl4Nm15?=
 =?utf-8?B?ZGg2aWZ0NWhpZHRiQ2RCR2R4cFJPU3NSV2ZURkxnWDBmbVRpbE91anFGWGRn?=
 =?utf-8?B?MGJKQUp3WS9XOG1iSFlESEEvYXlpNnJBdnBGTU02YkRwaTlpWDBEQ29YNGpk?=
 =?utf-8?B?S0pyTGErREtlWGtpU01lc25CTXNjMXRlakt1ZzdYZ2dyeGdtQk1FYzFCYUw3?=
 =?utf-8?B?V3BXTEtubWN1UlFiekNjMTNnaGthMFplTlFRS1JTY2hxTDMycWVGdkc0WG5G?=
 =?utf-8?B?MXZMYW1pOEJ0dC9hWStrc2prSG1HcDM1c3RLdUhUKzkwU1FlaGpmTldiNHRi?=
 =?utf-8?B?VG1xL0hMYWxnK2oyWDJsRTlwTXJDbTdPSVdqQkd3REtLN21FcFBtUFQybmV3?=
 =?utf-8?B?L0tOV1BzQlBaMTlQMm1lbE0vbEFOcW5GNHBSNmFHTmZrYzhoZ3MrV1YvMzYr?=
 =?utf-8?B?OWl3RXRPNDZqUHl1cVJSbExJK3FxQ1ZsQW9Za1VKc0dWUWhyTUxLWjJZRVM2?=
 =?utf-8?B?b0NSbmhHR0lFWE5Lb29mOHJ5U3Z1TkViek9rUEZaa25KRGRvREpNQ3V2V3Fs?=
 =?utf-8?B?RmNLQnZISzAvYjhoa3FjZFNIVWpMTUpTVmVOMENPRVlnYk4vcVduK0pBNnRp?=
 =?utf-8?B?bkZIdkxoRTZYdTNqbjU3TXppSFprU3dQSUkxc0ZMWE50YUtld3hkUTF0azho?=
 =?utf-8?B?ZkJkcVBXWjJjTnJONGJKTHhpVWZIVGxNSHBPbWllWHp4QUtKN2JYSklDWWNY?=
 =?utf-8?B?UzU5Y2hyMUdIQkRwZFE4N0ZZODFrQ0RTSHZScTFXcHUzRWI3NURnV3c3V2lz?=
 =?utf-8?B?ZkU1YlZyMWRDdWU4d3V0Ylg1Mm5uR1l3dnM5Y2tZdkxKMGdYc0RraWNLR2Mz?=
 =?utf-8?B?VEM4blFhRGYxRWtmdW13SDdnZGkwS09Bb3dna3IwcVhmRnZCeGNURWlUQmVs?=
 =?utf-8?B?T29MRkdqT01wMGV2UndnNVN5cklNQTNSWXhjZ2VkWDFhdmlUejFoZWtDWjQw?=
 =?utf-8?B?V05tdUlKMUhISHYzNzAxSnpEUGZ0QUtiTUd4dGgyM2NEZnRENXlldEl2WTBQ?=
 =?utf-8?B?M0NGeFE2VmZZN1lQejhJN2llRHM3TXRTam4yYnVBSVVkeHd1STM5TjlMVVdh?=
 =?utf-8?B?aWE5WEZPQTF2MlBTTWxFejBQdVVxckR1eTVVMXlIdDUwS21WblFYSFFHQjFL?=
 =?utf-8?B?NHdheHFLOVJ0V1F4SkxsSnVWakJ5bUVXZlJqeng0SXJrSkttK2hwRTJrOTho?=
 =?utf-8?B?emdGbnFzZHh3bTFBOVFlMEdKN2J6eStRai9wSzhLZkZDbEZiSS8wZW8xL3Rq?=
 =?utf-8?Q?onFlJNNjKb+0f1Nim6Zc41k9KU69pwmg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8301.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnUwQ3lmM0R5TFU0dnQwdlNFckJTL1Y0MHcxWGRLR1ZEY3V2MjRuOWRwbC9M?=
 =?utf-8?B?YWxHSGFrdVBBL0NIamVPZGlIWGlDUTBZUVJNaFZkRXlCQTZUYXQ3UzlablBk?=
 =?utf-8?B?TjAwUnRlM1Z4U3kvVWNLUmV3ai9ERkp6c2FPaGJoazJYbk9hc3FxeU5KRmtZ?=
 =?utf-8?B?NTR1YWl3MEpsMFpzeDV6eU4yejZ0aEFaZGVMZk9vWmx2aHFRckJVQ1dTVExX?=
 =?utf-8?B?bFg0cFQ0VTFBaSt1K0MzaU8yYXhxbUdwd096UEhuTkVDZ1ZxdTlKOGRLNmsv?=
 =?utf-8?B?WXlYZ0xHZzYzL0NnRDJUQndsM0dxaGNWb3pvNE9MMlhsc0kybUh0bW5ONkgx?=
 =?utf-8?B?Zk9wLzJMZENDM3g3MFlzVXhlbjg3N2VVWlhiaXppUzRjOEpieUlTVFdTS2Q0?=
 =?utf-8?B?RG1LTUo1YUZyYnU3M1JKaHNIajhtRE40bHptcGJIWTFEdlZDNGJEWnZYQWsy?=
 =?utf-8?B?VVExa3hnQlYyMjlacSs5c24wT1VOQzZpaGJDc21yQytnUzdMSkhFeXlicmxM?=
 =?utf-8?B?MVVYZmQzbHpKZUJpR0NMd0RYbUswcVNOaHBiRklWdEZGK2M0Z0xmK0tTL2tp?=
 =?utf-8?B?RCs1bUt3OFBOWER2b1FoSWpiVnRVTGNSdllPbVlEWmprUWFKY3VWYTFvVWVY?=
 =?utf-8?B?bHU1YlhFNVFWeDVla3gvaUJIVWhMVSs0RDBPeFZyajRYSmE3UzRKTkhSWVBB?=
 =?utf-8?B?UDBidWpwaWpPMDRCaU5sZWZDanJKNjJoQXcvVWl0elFtL0NIL3V1T1VFcE9k?=
 =?utf-8?B?QVdYU2lXNGQ5SjBMd0hpSE11S3VzSU1pNC9PQVBRcTVCR05KWkFUcHBwSEt5?=
 =?utf-8?B?SHgzMTVuc0MzQjlYUDB0aVFUY2pBWm5XZHhrYmhleG9xS05zZ1Vua0picjRL?=
 =?utf-8?B?Tms3YmhaZ05tVnpZR2FwQzVOLzNTMWZ6MDVCeFIwZ0NxK1lsWXJ0TTQvRFlx?=
 =?utf-8?B?L1pZc1RuS2xZUUxZbk5PRThrZE8vVExmV0daVWhNYkhZR2NFVWJRLzBYczdO?=
 =?utf-8?B?WCtJVW1ValQ3Z3ovSGNYQzlNU3dWNWpmVnprelYxejhjOEYzWXVKang3SEF3?=
 =?utf-8?B?VnpITmM4VGNjbU1DQ21TNFFNSHFlMVFkWXRiQ25yRkN5Nk5mdFY4Vlh3NUFT?=
 =?utf-8?B?WFRvNGRKNjd3K2MxUUpGL1hMTXpuUDkxbG1WdVpLdzgwcm9SQmhsZ2FBaXNF?=
 =?utf-8?B?UDlsNnI3d2NVZkc4aW5RZHB0RU5aWkNvNEYvK0xHYkVqZDl6YWMwQWoyczZ2?=
 =?utf-8?B?OTA4ekNrc3hya2FleUgzd3lyaXRJeWtML25WVm13NDVIcXc5S3RLNlEzVERq?=
 =?utf-8?B?VktPZHYzZWNSV3hlbnpXMGtGWFU1ZGU3ejlLd1Jic25aMXIzUWtnbGNOeTBR?=
 =?utf-8?B?L2xBcUR5SU8wNUZSUXAvV0VZVE9sU2Z2THlRbENlMkN4djlyV3JtT0JqcUJj?=
 =?utf-8?B?ZmFwKy9nM3lTTUJiN3AyK0x1emVlMTBCekpQRnpzdmhsZWNLMk82Q085NTJB?=
 =?utf-8?B?bGc2aDZ1UzlSSEZMbWVhOHRZaWtmc25rU3hacUtjU0poTi9rWk1Wb1FMMWt1?=
 =?utf-8?B?YW93ZEM5Nm05ZXR5MytXdTVQdUROWDkyZXVuVDlvZHVIZ3pXZ0VSMXVvT2tx?=
 =?utf-8?B?ZSt4TmJVS1YzNWZjcnVQMlFPdHRTT2djKzNQMk53QmhMamFVMlR0TTVkZzFa?=
 =?utf-8?B?aTVBZDF0Y1EzWTloQ05qbjkvMW5MemxOejN4aWJ5dUFNQ2ExK3l6bkFUa0FC?=
 =?utf-8?B?R3AyVEt0REtCcHNFVkJiWkc2ZERkZXFiQytpbWVRQk1pZHFGdVdTdDNTeFF0?=
 =?utf-8?B?akNHVzVGL2FKNDZDRHdEdzNGWVprQWcwajZlMHRyKzNpNUx0dGNZVk0zNFRS?=
 =?utf-8?B?YVFZVTl1MjgvalhXTnBDY2lra3AwcnVZV3lFMWFKQnVhUi9XRjlGUVRVdzlh?=
 =?utf-8?B?QnViZnYzajFTZXF0dnBJTHdYZWgrdFk3YmxDZXZYOGh4ZnBQMkZwWERsNXFY?=
 =?utf-8?B?THVGbDBBeFFSTzRRTllPZ1dHWkpRYWlma3JlYndoYStCREo1clBFWXhIajcw?=
 =?utf-8?B?aW9PM29jNHRDMEF2OXZxVTZxWERRVXJkSHFQOVB5VERsbVpFWmxlSDM2dUI2?=
 =?utf-8?Q?TNu2cJGgvQIHnIJ1j3XS0EGUW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c73c20-6af1-4ebf-cd5a-08de0c94e2f9
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 09:17:54.1688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5eGss5LKaKH0eXFaI0aLo7Tll4puzbi296QcPzDYVTDMumcz+aUKYhHbV7tdqy3C/ERZomosZuAflJkBukeEoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6402



On 10/2/2025 4:33 PM, Jonathan Cameron wrote:
>> +	/* TODO:  Is there a better way of handling the poison
>> +	 * recover for batch copy, instead of falling back to serial copy?
> Is there a reason we might expect this to be common enough to care about
> not using the serial path?

Not common enough, I guess!

> 
>> +	 */
>> +	/* fallback to serial page copy if needed */
>> +	if (rc) {
>> +		dst = list_first_entry(dst_folios, struct folio, lru);
>> +		dst2 = list_next_entry(dst, lru);
>> +		list_for_each_entry_safe(folio, folio2, src_folios, lru) {
>> +			is_thp = folio_test_large(folio) &&
>> +				 folio_test_pmd_mappable(folio);
>> +			nr_pages = folio_nr_pages(folio);
>> +			rc = folio_mc_copy(dst, folio);


