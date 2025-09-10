Return-Path: <linux-kernel+bounces-811056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62030B5237E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 23:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93121C25635
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B4A31076B;
	Wed, 10 Sep 2025 21:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UvJCh6EU"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175A82C11D3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 21:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757539938; cv=fail; b=qcfuO4vCAnlfq5QcvIMATZdMe494tu4ve5wpUXW/mqZ2fGY8MI1qIrFx7Me+rP1Uq1zrW7D5ICBrZ9y+f2pfyDsR/+4zrhq1vjp5LMdoPtbIqhKGJFUVMRPXwV6XCkKjTodkj8xVa3BJkmmgyZUzsvmC7m+3J9Ul3h9sOgkquZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757539938; c=relaxed/simple;
	bh=5+jdyuQ5AP3JUvsaIeHuw+3eZQG1xu+Chz6MmErRDBE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QB9WNGHOH/YN7MGp2L4uWYUBLPqQH+naUSiC/ZmISZ1NdlHhAptYrHiFOnwPK1LJAhszHs0tC0YTr4iGx4/fumAB7GkXEqdBSSUMTtfO9atUs/ZjvIcu0yCWOfEgcFxf16oA6wJMn229jFwTW/2Y/rWV5OWwm2FCAGFgD6wKsHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UvJCh6EU; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVCi9vr7QCI8iplnnwHN5tgNC9Zs7j7R9HDZkFLXL3gZACdgTKVBylPqH+vZPc2IqaQFBUn0AJj5MxEH8iwpwfj9HUhpOy0l5VahV8U2nNq7O0J1z0awjVeiX84ozoGVew0MAGhzAMQuMXM6jEknk6J1KMFodkkkSlbZ+N9ASP0gBRrvWXtTuhPjoUidQsqSgDgsREcY4B5kyMZhUgemItRkszw7Oy1mIY9ev3U1KCvAC7VQnbmB769dUE5OqdlLy1s8i6nqeIJ8YLDoQKInHHdVpvYaV6WA7JSQm3NPj4/5UEon4VhMG0PzEvD94Vaj3Tbdt5OL+SHLPzhCDt5jRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5KSYSBFJtiSgA5hgC3RAPXVxqvuSsg3rgta7eDx3gs=;
 b=Y4dLrU7gTCRqzO0Ijv851A/2WWhkq286DYFCOg0keFTxNEXXzQUtdD/iAW/jXu+5z5v882Ch2KI7Dn1u/Vyp+XkvuoD8ZI7+g8djlQ3gJv3htUz+7UJrCgQxozfNSymRcPNI+ICuv4feJgX8+n/YE8HuA5MS4BTWJKZTwE+R5wUkNAtHZeQuBRubp3KekHsQWK3rqL2OJ/FfYAXwd9VY3rAgAqXAOHKEBneJ/f5tEwpbrVgEOltMmmB/hAxD3PWc/i4qWgIAR/0mnx6j8d6KXGexxTeekL+FlaqfurKhHMkBbAtkhWH9HHVMk8FUXXPkKYuHfgOdJH/gILTgS/gNUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5KSYSBFJtiSgA5hgC3RAPXVxqvuSsg3rgta7eDx3gs=;
 b=UvJCh6EU5ZqKfvh57KY6qIAcyu3gYBIM0aKhzfky6GHLUMcUwG8BO91rZPZdwIdNlZZftv/kC8hkhoCqgtVBu6pyMhSRQb+mj9FOrb796WlumK9AFKsItCWs+DLqVzqLqb3JkQB8QyQmoxmQ2ee8w7x1Hc/QzuatHUHp5NSYtFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CYYPR12MB9015.namprd12.prod.outlook.com (2603:10b6:930:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 21:32:12 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 21:32:12 +0000
Message-ID: <53e5cc5d-f220-4e4c-8ee4-159a7d8f329a@amd.com>
Date: Wed, 10 Sep 2025 16:32:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Only restore backlight after
 amdgpu_dm_init or dm_resume
To: Matthew Schwartz <matthew.schwartz@linux.dev>, chiahsuan.chung@amd.com,
 alexander.deucher@amd.com, harry.wentland@amd.com, simona@ffwll.ch,
 airlied@gmail.com, sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org, zaeem.mohamed@amd.com, misyl@froggi.es,
 linux-kernel@vger.kernel.org
References: <20250910212753.3167295-1-matthew.schwartz@linux.dev>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250910212753.3167295-1-matthew.schwartz@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0047.namprd16.prod.outlook.com
 (2603:10b6:805:ca::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CYYPR12MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: f9004b03-288e-4b92-0b61-08ddf0b1810b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDBJYjlZQnpEcE45djdGcEhyb3IvQUhEWDNqMnVzcHJpMkhoczJrc3ZpRUpB?=
 =?utf-8?B?ZlkwSnJyQmhzS2N4bmpoc0tCOGg3RzVJRk5ib2U4WGxMb242ZEcxb0dYV0ho?=
 =?utf-8?B?cU1pY2hzQ1p3U0JJTk9vcDJEZFpOT0wzMEd3aTVQZHlwODdXSVppSTVQTlRQ?=
 =?utf-8?B?L2xrbFRGV2l2c0JkUzVrMmNhR3QzMXFwaDhKUWpXUUtjQjg3dUVjTGErR25i?=
 =?utf-8?B?TklOTWdVVHZwUzBZeTBUNFZ5bjRQeGtKemduSytaUHliNDRLK29ST2t6QXBS?=
 =?utf-8?B?c1kva1B0VFRWNVprRnFlMkJqLzRZdXhWdktoNm5NUkdCRW1FeUFjVE5UTWpq?=
 =?utf-8?B?SzByekVENzIybVJJd1NDYVpGa0RxZ3k3UHVCYy9MWUVrcUpOTHJNcEtqUUQv?=
 =?utf-8?B?NUhVQktMblZEUlBOelRuR0FudmF1ZlFyT1B2NFR4RWFzZmFzYS82S3cxeHBG?=
 =?utf-8?B?MFRvL1RXN0syVlBhaFhNRFhlQUR5VWNXMENmY096ZnhJMWJXRzRoWS9XR1dG?=
 =?utf-8?B?OHA1M2pBVzkvQkg0WStta0RUYXZoY3JMR3hOQ3dxQStSbWxOUUpIVVdZenhH?=
 =?utf-8?B?Y3pSWUg2WCtyY0ExSU41OExrSmxYb3BLUVZVNFp4QURPUjVKNGhwdjh2c2R6?=
 =?utf-8?B?eFR1NndjdTVhOXR5bGlLRHl0VWJGek5XdDc3cS9VNFp0NURIVXN2Z2dST3hs?=
 =?utf-8?B?WTVCZ2tqeGxrMzhwakdaMiszSm8yZVk3MGpEb2NObnM2OWRqZkUxOS9FR3hR?=
 =?utf-8?B?VStWQzY0UDFCQmZFYWNzdS9MOTJMU3l6TGttdWhkYzk5VzBIbzdRSmxPaHVU?=
 =?utf-8?B?bE1ic2dVaGlzTldNYm5iMmk5c0JSeFhzZ3lPL1lGTUlVVDNUc1hqSW9ybFcv?=
 =?utf-8?B?amI5eno3Yk03V09sUWJNaEdGRlBuTG5rNUdDUmtMZUpyM0R1VEFtdVdqdWp3?=
 =?utf-8?B?OFlKMGVESnc0TC9IaFh4M2Y3OXVMeUdCOUMvVitwN2FJWVV1b3JkR3dSUytk?=
 =?utf-8?B?L05kSnZVWkpPc2xUVjNMV3dzWUZRZVM3NzYzQUFxbmp0a3EzaDZhS0taR3M3?=
 =?utf-8?B?ZlIzLy9iSThUQmVZOHhtUGorbk4vWUZUTnpTbHgzNjFEVW5ZZVR2bnhJaHU2?=
 =?utf-8?B?a0tBcDZuMEhZdkpOQytEaWtnTDJrOVJ3RnhTVWpsQ1h4QlNnOC8zL3BUWTR1?=
 =?utf-8?B?MTNISGV5Y3F6NlhQRExuTzljNklVVVNBTi9TU0JsbzFTRmZ1S1Y5YnJyMDRN?=
 =?utf-8?B?R0w4TVVRdG00UHpWWlUzSDJqRTBkQ2ZwNTFxS1F2VzN2VklEK2l0aWZCdnh1?=
 =?utf-8?B?eHJCMGUxaWhNZ0lOaExQUzRjd1k0Vi80RDZUV1BYbmtjY09uZzJ3WWJaZjJr?=
 =?utf-8?B?MXc1c3ZKb1pHWS9iSkxKNDY3SGEzTlFMU20zNjJHMElwVWtiYllkaFpqSkFy?=
 =?utf-8?B?WVhuR2xRcjMrOXgrTFF5eEk5VnFBMEo2NEtBZkg3bkVONEdxMm90K2ppMGlU?=
 =?utf-8?B?cHFKaExpNGpNL2J1MmRUSUVhMUxuZTl3ZlcxdUNxek54Q0hMOTBDY1ZDRkRx?=
 =?utf-8?B?OGR2YUNsUit0NjI0cW5VN0VSMzJ5YlZZRStnQWpNSEN0RU5kTlhZMWtSdGhG?=
 =?utf-8?B?R2JZYWQxLzVmM3RCQVNXckxMSEZLcHJiQzJZc0hmaitWYXdmQXQycUd1MC8r?=
 =?utf-8?B?dENadWJwOXhqSndQVlVjWHRHZWxQVnZNWHJCbG5rK3JtSDVWOG5yVTNFQ0Nv?=
 =?utf-8?B?K2Jic3RaTnRxU1BtNTFBbG4zdXFKS29jQlB3NDRBaC9jWjJYaDZJWWdnRGJS?=
 =?utf-8?Q?YmmllTk7GVe1u/vB4BcWIesam+lk83p6/+fSY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUhZdGswcm5yS0NXV2FuMFkvUjVpQ0s1R25selR3VGRyYXdSSUVXcWJ1Ym1a?=
 =?utf-8?B?UUh5TVF4TjNKUVllRmxaRGl5WFJpL2NUOU9MZzE4R1JTait0TWpsVmszT0Zo?=
 =?utf-8?B?T3dJVWVuQkVWK0Z6bnI3VDdPMTMvbUI5b2lXTStYdFdnN01yV0FzdVdRYTd6?=
 =?utf-8?B?aCsyOVhYMlB3ZUVLOUM1ZlIrYU5tbjh6QlptQzZEWFZJaHlCL3I4dFBtN2N2?=
 =?utf-8?B?YXJoS1h3Y0xnR1I4bXNJc2R3aXRWMXdkQ2d5eHNDVDVPUVl3RDJrWjFib2Zw?=
 =?utf-8?B?MzBHQzFwWS9KZUIrYm92YjhMd1d1cGp5N2RhM2gwTFlweVkvbXFTLy9uaGNC?=
 =?utf-8?B?WWtjN0hCOWFIU0cxZ0sxRG1SZHBuWnB2YmQvS0s3Z1Y2UHBrMVNvS2VNbHZq?=
 =?utf-8?B?d014NFg3M3hxcE1ad0NtRU02ODcyQXBRQ1JQVnFaeXBiRG5MZitlTjh0T0U1?=
 =?utf-8?B?Y0phaEt4MWRwdDhYc0Z0Rjhyd1dWWUdiVHJWYmJoRXNDY25ZOFo2UzJ3UGpP?=
 =?utf-8?B?d1dlMWRyTXBmeEJMZCtseWQzcDVpR0JWQmhCdlZzN0EwOW1JOGpTKzNHdVYw?=
 =?utf-8?B?cDNjZ1FOWHRBVE9jOUczOGREeXQ3dUo2V2I3WEtjeEg4TU9rdDhXazVtWG1T?=
 =?utf-8?B?aW41VUpFQ01JaWFnVFJxL0hzNmtGSVJlUmdSZHFkMDhsNFBOVWFFc0l2dGND?=
 =?utf-8?B?UTBjY2RlNUlxQjQ2c3pQT0F4UmNlWk1xaFlWNHZWYmJnYzdlQi9aVlp0SUlm?=
 =?utf-8?B?ZzFYbXJWN0F2cVhuaWJoa0R1RTByQU5LWHNrNzdiakI2K25oUldTaVZETFNN?=
 =?utf-8?B?aHNKaWRSTHRkc05kVVJuZTV1b1FRdG9UeTJnRzhVMjVJZjZsZUE0djBUU3dp?=
 =?utf-8?B?dlU0ZDVBSXQyMlRMQWI2c1hPWUIwYW9oVDdHcTIzQWFOSUJsYnJRTkg4TWsw?=
 =?utf-8?B?ZTlJci8zUWY0OUdjMUJoYmZGcWQ4SGdIWjhHWmhJNUNsWG9vMkw2M3B5U1A2?=
 =?utf-8?B?Um5sNFpXVlp3OWx1RHVtekF4bkprV1pVOWxrZWpiaERHZFltdG9HQy84NXNL?=
 =?utf-8?B?MzlNSFFQaW5jclZpNDlaL0p1Qm9Eb0IrcnMzRmZYRzErOXJFZEprTTZtODd1?=
 =?utf-8?B?NXFMbEViT3A0RVgrMnhZbkVZMEZ2KzhBVlRaNWt3d2dsMXVSc0w1VjZCK0U1?=
 =?utf-8?B?V04vWWpRVE90RGdiaVBlRWhqcDh0SmpRYVRGSk5aYmxmb1Zoa3NxcXlvNTE1?=
 =?utf-8?B?RnQzQUFaaVJsaFFkWkExa2RPeE11NVlWdzNwNUMrNisySmFaVHk1RzRzck5r?=
 =?utf-8?B?d09Gc2hsZnJ3eVJQV25NQ0IvVlJiYzZvTFFFMkVFRk0xOE9zR05lSHpJQndy?=
 =?utf-8?B?THNHWnBicFZhaXFVZTBNWDVuLzdkOVJJckdIU0tyODZLVmZNWXpHVEFFbERZ?=
 =?utf-8?B?aFZHVzZYY0dTR0s4b3AyRmM3S0pGOEFkVXcrZllOTXhyU0kxU2RTSTlHOG5y?=
 =?utf-8?B?cGRYMjZiZjdIeU13R0NJK1RKaWZnVWVhTC8wUlhWS1pVVyt5VU9ia2I5WGE1?=
 =?utf-8?B?TGRuUlpUdzBzUFovUyswTmRLL1Q2SU9IbFRUUmtZM0FDS01Nb2o0elg1eFFH?=
 =?utf-8?B?am5GNUZ5UGY4aE5PQTA1OVowdFV0UjB2azcxbEFZV0o5V1I2M25FWjd4VzJw?=
 =?utf-8?B?bXZ1VmRUaVJRNkdSVEdwV0RYQ2NwbTBGQnVTdDJ3U2ROV1FFS2k3WDQzYlZw?=
 =?utf-8?B?UzBsTmx3dXdhTVI1a29FbGRlSWpnajhteTJpTy9reXUzT1BraGxrbjd6SVZx?=
 =?utf-8?B?ZnoxWnQxZ0FKTFAyaEI3eUVkdFQ3dDZVcm5teHA3L2tVNjFRZDZhUEN1ZTY1?=
 =?utf-8?B?VTBmM3o2NGpLc3h5T1lEUXpjUlhnWjg5eEVSRGQ3ZjQ4aEd6cHVZaE15ZENz?=
 =?utf-8?B?Ti82SHh1RkVEekZBeDd0SUlUUXdjTHZnSGNrNEhXQjhKR2x3cXJyVWxSa1Z4?=
 =?utf-8?B?eldMTXIwSGlGekNBNzZDUVFkUzVQZVpHekNINkExZ2hwdE14Qjh0K015T0l3?=
 =?utf-8?B?akM4NTJnVG5wNHJyNkVta2J4SjdoN0Z3djErRWlOT0hlaUNxTEg0cjRydDFj?=
 =?utf-8?Q?PXbWmkmMz0QOJU2w2u4BOknSa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9004b03-288e-4b92-0b61-08ddf0b1810b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 21:32:12.3836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUm++PgmbFr0MfeW2EEUkczgpsDRAiXDb9pxueM1REsT0SsigqbTgaXJzUk/RYwNdhQwNq8WnMrAa+QpJrrnlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9015

On 9/10/25 4:27 PM, Matthew Schwartz wrote:
> On clients that utilize AMD_PRIVATE_COLOR properties for HDR support,
> brightness sliders can include a hardware controlled portion and a
> gamma-based portion. This is the case on the Steam Deck OLED when using
> gamescope with Steam as a client.
> 
> When a user sets a brightness level while HDR is active, the gamma-based
> portion and/or hardware portion are adjusted to achieve the desired
> brightness. However, when a modeset takes place while the gamma-based
> portion is in-use, restoring the hardware brightness level overrides the
> user's overall brightness level and results in a mismatch between what
> the slider reports and the display's current brightness.
> 
> To avoid overriding gamma-based brightness, only restore HW backlight
> level after boot or resume. This ensures that the backlight level is
> set correctly after the DC layer resets it while avoiding interference
> with subsequent modesets.
> 
> Fixes: 7875afafba84 ("drm/amd/display: Fix brightness level not retained over reboot")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4551
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 +++++++++--
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  7 +++++++
>   2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 7808a647a306c..3651315760759 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2037,6 +2037,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   
>   	dc_hardware_init(adev->dm.dc);
>   
> +	adev->dm.restore_backlight = true;
> +
>   	adev->dm.hpd_rx_offload_wq = hpd_rx_irq_create_workqueue(adev);
>   	if (!adev->dm.hpd_rx_offload_wq) {
>   		drm_err(adev_to_drm(adev), "failed to create hpd rx offload workqueue.\n");
> @@ -3407,6 +3409,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
>   		dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
>   
>   		dc_resume(dm->dc);
> +		adev->dm.restore_backlight = true;
>   
>   		amdgpu_dm_irq_resume_early(adev);
>   
> @@ -9922,7 +9925,8 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
>   			acrtc->hw_mode = new_crtc_state->mode;
>   			crtc->hwmode = new_crtc_state->mode;
>   			mode_set_reset_required = true;
> -			set_backlight_level = true;
> +			if (dm->restore_backlight)
> +				set_backlight_level = true;
>   		} else if (modereset_required(new_crtc_state)) {
>   			drm_dbg_atomic(dev,
>   				       "Atomic commit: RESET. crtc id %d:[%p]\n",
> @@ -9979,13 +9983,16 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
>   	 * to fix a flicker issue.
>   	 * It will cause the dm->actual_brightness is not the current panel brightness
>   	 * level. (the dm->brightness is the correct panel level)
> -	 * So we set the backlight level with dm->brightness value after set mode
> +	 * So we set the backlight level with dm->brightness value after initial
> +	 * set mode. Use restore_backlight flag to avoid setting backlight level
> +	 * for every subsequent mode set.
>   	 */
>   	if (set_backlight_level) {

Is there really still a need for the local variable in this function 
'set_backlight_level'?

It seems to me with this change you can just use dm->restore_backlight 
for state tracking at all times.
>   		for (i = 0; i < dm->num_of_edps; i++) {
>   			if (dm->backlight_dev[i])
>   				amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
>   		}
> +		dm->restore_backlight = false;
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index b937da0a4e4a0..6aae51c1beb36 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -610,6 +610,13 @@ struct amdgpu_display_manager {
>   	 */
>   	u32 actual_brightness[AMDGPU_DM_MAX_NUM_EDP];
>   
> +	/**
> +	 * @restore_backlight:
> +	 *
> +	 * Flag to indicate whether to restore backlight after modeset.
> +	 */
> +	bool restore_backlight;
> +
>   	/**
>   	 * @aux_hpd_discon_quirk:
>   	 *


