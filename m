Return-Path: <linux-kernel+bounces-744935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 972ADB112C0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7A71CE16F6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDB61C1F22;
	Thu, 24 Jul 2025 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dP/64KT0"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6FB17332C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 21:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753390965; cv=fail; b=eOssfE/zhilxqu9AS5Hei25X6IaqUX0LE0REV/EIh5ykk6nwXLJboCx/IhjMih92cSJNU1t99/Ui8zCBAbPC9l5qKMqcfEPLbwTstVWcmOYqVGvrOXwQkOpmmcOwJd2Ke5/trKbngGLjIG3Ex/hgzymNCaXYsgowqhWJ260AfZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753390965; c=relaxed/simple;
	bh=Tu5E/e3HrbCMAnmbhmQfXU+yzAtWOhd0uZ9q9x7pj0Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mMTaH213Y/Zb1XAnwFQoULZnRkTWmDSoTPCdfME1QWO8qd7O2RyZJtF4O/4sXRDIsKt3QX4EnBPD26kAhRveFwmTf4QcOL0OeSeVjyecRX0283oJ+UOd5ft2zp4XwzMWomICSXkIibovCnt7fNHi5nkgQKSdjrxPmqO2y3Axpz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dP/64KT0; arc=fail smtp.client-ip=40.107.212.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTmiE8YA2KHJ5GXoJFbcHqnQ6ey0rqchewxshfPxkMNRXXEDB7fxxB/EZ0BKVG9yjdsu/YRBKfKoNrRimddKkjhQIxzi7GwaxpF+qNrPWPbCEnxqotAWbva5/O7pbMQc7VgwTd1f+ZDe11zqkPuXOo7AHkImkZi7/TrJ9POMLqmr8IajoGk8AcqmnOwoGur2HiIxiCL0zYNZn0CIqTHpFfhuG4sfojlG2UxbXLf4AnuY4ObcyEbRqW5dN/LYaw3PrmfFZYSrLDaaBHfMU9zMP/mHYBQiYWVZfm73A0LlgiYtOv9EtmQwOTPEfsqvuA5ZWj1X7/UQKF5as1u7RwEp7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tu0VHrrIIZZMjhGyX/6EPIWTdoRaGTC0xQzaHO38sis=;
 b=Ib/dTkmuOTDvmgyJfYZBZ49x2WDmjF9GYVdLXfjjxA7WcLUXVRsoXbHRJfHHYTkZlUdEOGTsZLV3c6aUAkRdAyR9kQw7pNsizhEbiRcp8NCvI6FHjLFcfl4CSvpEJ2E2hUrvtGjhMt/L4fOJBpFqsaRt5Tsok4edzvOMjh5Y7nUPLL0PvUdlHVfpRdsF7Iu5OA2mdiIJoERIPKzz8MVj3WEY6zgIdrV1Xjdd4NhYEZ0sHVImWdILplA32CT8VW4u+Ey4nE6Wkxoapt6IwGM/fD9ghPELMR1iG6RDM5f6Zwc2EHyQdaq4vHC7ZQnFLuNS9spbXtjaw94JutUvPPj9wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tu0VHrrIIZZMjhGyX/6EPIWTdoRaGTC0xQzaHO38sis=;
 b=dP/64KT0ZBrfJuZU98IW9cdlvitTqWol9v0DpKK9mARj9r+xPOw7ai0QxlVGxJaUFb2RlYerhJdhv1D3lz7eTLcDsuEi5xe8pXFfxFV1c0jmn3eGciG884d/UrU8VWbufiMINwvNjeSGH0DNi8W8rod3ta4lcfkdiZZlCb4A220=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4173.namprd12.prod.outlook.com (2603:10b6:208:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 21:02:38 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 21:02:38 +0000
Message-ID: <3cc16f7d-c650-43f2-b0ca-d99c427cd69b@amd.com>
Date: Thu, 24 Jul 2025 16:02:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/CPU/AMD: Ignore invalid reset reason value
To: Sean Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Libing He <libhe@redhat.com>,
 David Arcari <darcari@redhat.com>
References: <20250721181155.3536023-1-yazen.ghannam@amd.com>
 <20250722165615.GCaH_CryG7kNrAS4O6@renoirsky.local>
 <20250723183426.GA1158000@yaz-khff2.amd.com>
 <27E487FE-EC8D-42AC-B259-F8A18776C802@alien8.de>
 <aIKehTDgP-Nu36ol@google.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <aIKehTDgP-Nu36ol@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0065.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: b8eeae04-3178-47b9-ea24-08ddcaf56ba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnZtTTBaQlIzaE00Z1E0ZjcyQ2JjSFZCZzBOVlk0NVJaUUdpRFlrWVhWVDJR?=
 =?utf-8?B?Mm9OUjFHVk1IK3phV1ZBWlRHNEY3NVhiaE9FSE1vUXAxeUdMK2FreEVKcCtr?=
 =?utf-8?B?VHIxMjZkTmorMnJ0aW9GRy8zQkYrbzRVSStQOVJPOEF2dFRRdmlpeWRhZWdQ?=
 =?utf-8?B?d0xvd3lmUytxcml6QXFoSk5rWTNtSmI3NzVzUnZnRGZRRGxwUkVTY3h6VFhp?=
 =?utf-8?B?MnUrQTl3Zzd1ajd5TUdySS9hMk9UUFJHblFhdTB0YkF3akpCeDAwWXZyVHZ1?=
 =?utf-8?B?ZG83UWlqanp0d2ovT2ZaVlh1WW9wQzNHbStJSHk3ME1YKzV5TzBhUkJyYTBT?=
 =?utf-8?B?YjJTNmQ1NHBWcVNrSnVyL0p1a0FtY2x2RmJWY0NvVk56MG4rYmpGVGFhRmx6?=
 =?utf-8?B?dmZRV01SZVNBVWh5d29WckFXWXlUZ1lENU9ybmxmbWR2Skw1ZXdST3FIUDhY?=
 =?utf-8?B?Tm1FRjE3K3ZVU3pXaklhTURWZWtNZDh0MUN2M0g4N2lCY2YxYlYzWWdQZkl5?=
 =?utf-8?B?bCtrWlRYRlRSc2lwdS9VelhIejBqbU1hTzNkZk5SaW9TTXg2a3oxWDJsQnJO?=
 =?utf-8?B?bWNTRGdhanhRRXcvZ3loaUdOc0JtRmRPUDVLd256SzZ2WDZLRVBrZ09YWFQ4?=
 =?utf-8?B?V1p0MW5xNHlnbExBeVhlRG9WbE9lOG44a0M1TDF0UElDVE5kbUMxRjNUWEg0?=
 =?utf-8?B?UVZYMGMwYTFCb3lyYlhPWm45ZWVqTXprRlNGcmx4NVlmQVZ5TlJtTm5PTno1?=
 =?utf-8?B?MTNwbzZ0VEd4VnZJbGdNUjZzVFB6NHZiS3FBckhicG90TTl2L3d3TnR0OXZm?=
 =?utf-8?B?Nlk5TWJVTFAzdmdMOXd5MWZhMzlCbzJGMVl2bWZGVjJjZTdrc3pYN0NtY29j?=
 =?utf-8?B?MDAySXhxdnhuTzVJRkJwLzVDelA4a3FvY0VWUUhlTm4rQkRqT2ZXaWVDV1hZ?=
 =?utf-8?B?ZjFmckVzLzN1Vk9yV1ZnTnNXbEN5MnZIV1BYaVk2OC9pTVpXdDBtckkrWldq?=
 =?utf-8?B?dkZIMkh0SU8vemY2U0F2QnFPK1oxNzdUc2h1d2JuenBXSjFHQzJrS2xrMi9z?=
 =?utf-8?B?c0Z6azN6UDZYc1RWMGR0QnVIOGtZd2RjSWZsbFhDbUNTUEw4WGRHQzhCR08v?=
 =?utf-8?B?SHhkTkhNbUlYRUZmcnVQbUx1QVd4YVRsczN2cUtOczNDVXAvQm5EVytrN2ZJ?=
 =?utf-8?B?eTZSRC91K2tRbzEyaTc4cEE5ZlNtcGd1YU5BMTIrTmgyb1l2WGt3eHV0Rjda?=
 =?utf-8?B?aTNjVUFSQlQ3SlR5djBuRXNIME15b2RNSWNwL2FYeWdGMzZBZ1pHVzFUWXBz?=
 =?utf-8?B?UVVWZjIxTlIrZ3c3QWVNMXpmV25lUCt4YmNCZ0MwWjZsRmd2M0FRVHRkTDZV?=
 =?utf-8?B?RkhTZVJWUzgrQzBHS2p0RUl0MW1UN0tVUmtFZHJhdkwyQXRnTWFSQ2o1bUtu?=
 =?utf-8?B?VjA3UFlzTTdRWmprNXY4Qm02b25lUUVDTVdaL1lkVVBQaHZhdjd5VVpod1V4?=
 =?utf-8?B?V1N5RTJjbUVrNGlTdXYxNFFNdW1Ia3VoS1h5QjJuazNhK3UzbG9Tem9EYU0w?=
 =?utf-8?B?b3RKR29zeEJVY0hWSGdpaWdiRVFGZEYxYmVSRi8xV3JZTzlXYWtQdU9mbGUr?=
 =?utf-8?B?ZTlDT3BjQ1Jtb0orU2d5OUtLYXVibnRjSUJCNm9zdlZMOURyVnVOTkZxUjFy?=
 =?utf-8?B?alErcmozc1JLNWc3ZHozOG9qRUxEanNsY0tqNmlOYkNZTW0yTHBWeWZYNHBw?=
 =?utf-8?B?c1o3T3ZUTU05bVJTanBsWDV0bERTNERYL0lhTmp1d2R4VU5ITkhqSU9uS3VB?=
 =?utf-8?B?Vml2aVh6UFdIaGZIdkcrQWt3NldGR1pRUGRHeG9QWGZsZVRKUnprV0xYSGtY?=
 =?utf-8?B?S0t1S2FRMzZHbHZlUlBZemcyRGQzUmxLeXZjenZlRmprOStOMlZhRFYzblZL?=
 =?utf-8?Q?1FjPFd/7BaA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2RqcWQvNDVVanVWQmEwVEFzemZLbW5BTTdldVF2Nmx1ZWowRElQZnNnREw4?=
 =?utf-8?B?c3F2Q0R6KzQybWYwcnBaaXZDaWRDdkZrUkV2OG9NVkYwOXZFZnNhcC82SDhB?=
 =?utf-8?B?YUZGQ3REaVJWbCtNUVJGNmhOalVVZEJTdnlOMzc0OGZmbGt1WmFVeG04WGhP?=
 =?utf-8?B?T3pVRW5Wbit6eUxBay9Ed3hGeFp2TVpobWF1ZGh3SlFFbTRPdGJVSVQ0Ykpr?=
 =?utf-8?B?ZVAxRmt2cGpsSldGNnZON3BaazJTTE9odFdVVVhDUUJsS216MHBoOHdZd1pr?=
 =?utf-8?B?UTY3ejFDTHZjRUhuanpsTWE1amxBMG9UTnUvTEF5N01icXZoWnJJU3FNbnZo?=
 =?utf-8?B?a0wwL2VGMzJRYmJvYndEUFJlbHNMb3FyVUE3SDRITXRBTFJlVHhhMm1pUG9a?=
 =?utf-8?B?bFd0czdkdnY2YjBNOTJRQWN4YmNmTGJIcDczWHg1V3VqWnAwUDJNVTlaUURE?=
 =?utf-8?B?YTRzUUdVeENlcnovY0xUc1pCMWcrczNJNFpzbk9Jd0dLcyttVndLeU01TmV2?=
 =?utf-8?B?OWNMdmdvaFVVSFBmWlFVSEd1MVJReFdETk1xYkNuYjJPM0dUNmNkMGllVFVq?=
 =?utf-8?B?QThVRWtLb2tJRi9LcGwxOTAweUxpTDR4K2JOQy9vK3VjQkVmcW5YVitvSnk5?=
 =?utf-8?B?UmdBT2RUdm13RTFDWTFQOEZ3OFYvc1Rvam5kMU1sSEF4emdjVTd5SmF2NSt0?=
 =?utf-8?B?RS9DZlZlcS9OZUFJUHNqbU9MUFZqNFJFOXFnOHcwQ1FMWm1qT3U3TmxlL2Vx?=
 =?utf-8?B?OVJzTlJ5QW5HcTlKNGNYZkdZUXVVdjMzRVJyNjlxMVB2YzRBNDJObEJwZVFn?=
 =?utf-8?B?V3N6bHl6WGREK3ptZUtqZklkd2w2MlRWM1VyWUFQVk9ra1pvYUM0eW5FWklu?=
 =?utf-8?B?ekhMQjMrOXFLb0NFS1c1akt2R05VTnlJUjBDTE1BNUZ4bWQyUlZXcUJYckx2?=
 =?utf-8?B?TUNPaSsxWjlCU3VVVXF3QkJ3NHVkZ2IrRG5tN3ppTHRRQThudXN4bFVSL2Jl?=
 =?utf-8?B?b1JRTGFEUjFMLyt3TWs0b0ZHVVBkaEh5Y1BBMDVza05VQzBuTWlhZ2lpeldq?=
 =?utf-8?B?dXFGQ2lIN29YT0VKbm9yNUNHYVhVc3oydG1ObE8wV1hVYnNYa3dZT0tyRENG?=
 =?utf-8?B?MThUWW9QSFR5aFRoL0Y4ck0reCs0VDYyVFdpcFhMOWRISnJucElscitacFZ6?=
 =?utf-8?B?OFF5d2NVbzJGYVY3SFJBbWFYM2JyRmlLVU1YbTFKMzJ1WE14ZTk0SXhyRTZw?=
 =?utf-8?B?Z205N3JVdG51WjFMNlI3ZDhSUWd5NFBkSTRVaWt3Z2VVUDZZWDBwUlB0UFR2?=
 =?utf-8?B?MnpPb0pLQitBcCt6Nk5UUW8yYzVwbTgxR3hGcTFGbE1jZEp5c3IyUFBOUkZ1?=
 =?utf-8?B?TU13ZGZJZkRQbHh5Smthay9UTzRPQno1UjVjcFdRSGZrU1J0RTF5T0Mzb3Q1?=
 =?utf-8?B?Mk5uRUxyTzJqc0tmNi9nNVdMQjBuVWhvKzcvWllnaTdzVm1oTWhjbXZ2aXFE?=
 =?utf-8?B?RVBPR2dULzd0MVZ0aG5uNkZiYU8wU2xxWFlvaWxreFp2R3l2S013OWtaTU1p?=
 =?utf-8?B?cDFDb2diak9xOUFIVk41bG4yUlNIRUZIc2xLaXBNLzNDSlh5TmtWL0J0czR6?=
 =?utf-8?B?R3M1UzVreWZnNUZrNU9LcSs1akdkdzdiS3RjTlhpS3V5aFN5aFB1MkFteklh?=
 =?utf-8?B?THVIZXVlZHZmaUI2ekplQ2Y1TUpwNWFQUy9HUjFjbC9TNmswdTNxSFZ2K216?=
 =?utf-8?B?YmgwSHJBMGtyYjVQaUZQQ1dhT0ZNSTVmd2FPL1p3T25VTG9ydkN1Y1hBMlEr?=
 =?utf-8?B?NDNFZlBDdW9TdlBCWHZFYjFOeE4wOUZBT2p5YThSMWRJTFJta0pWMXlobDdL?=
 =?utf-8?B?U0k2N08vZEY2Z3FyeFZ2SlhtNnFidVl0M2RsK25PNm9Dd2dkdUxUQVptOWZK?=
 =?utf-8?B?TjF6WVNUa2Uyc2ZHV0FSRlVPaDg2VHlOYklEQ01wdkpZTC84UTcxSmM5dU1S?=
 =?utf-8?B?bk8vZW5RQWYyMC96RGlGdzRJd2U3T093bEl6UFphTDFqMGFGQjR1Z3JvWnZ2?=
 =?utf-8?B?bGdZTEJFbTJFVitWV2s2a2xHRit4KzlqK2ZrY3p2KzJ2bVpwQ1Z4ZFk3b3N3?=
 =?utf-8?Q?1RvEUP8mfUi8kphJZWY/hDl1n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8eeae04-3178-47b9-ea24-08ddcaf56ba1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 21:02:37.9570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxPUh4OvhnDjS6Drnpeg0qvxubFrx2BOmoqaxv5DHZFhSr8VSJHnW+IrCUd/b9qrHdP8KjB7xjGz/6vZvXSzGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173

On 7/24/2025 3:58 PM, Sean Christopherson wrote:
> On Wed, Jul 23, 2025, Borislav Petkov wrote:
>> On July 23, 2025 9:34:26 PM GMT+03:00, Yazen Ghannam <yazen.ghannam@amd.com> wrote:
>>> On Tue, Jul 22, 2025 at 06:56:15PM +0200, Borislav Petkov wrote:
>>>> On Mon, Jul 21, 2025 at 06:11:54PM +0000, Yazen Ghannam wrote:
>>>>> The reset reason value may be "all bits set", e.g. 0xFFFFFFFF. This is a
>>>>> commonly used error response from hardware. This may occur due to a real
>>>>> hardware issue or when running in a VM.
>>>>
>>>> Well, which is it Libing is reporting? VM or a real hw issue?
>>>>
>>>
>>> In this case, it was a VM.
>>>
>>>> If it is a VM, is that -1 the only thing a VMM returns when reading that
>>>> MMIO address or can it be anything?
>>>>
>>>> If latter, you need to check X86_FEATURE_HYPERVISOR.
>>>>
>>>> Same for a real hw issue.
>>>>
>>>> IOW, is -1 the *only* invalid data we can read here or are we playing
>>>> whack-a-mole with it?
>>>>
>>>
>>> I see you're point, but I don't think we can know for sure all possible
>>> cases. There are some reserved bits that shouldn't be set. But these
>>> definitions could change in the future.
>>>
>>> And it'd be a pain to try and verify combinations of bits and configs.
>>> Like can bit A and B be set together, or can bit C be set while running
>>> in a VM, or can bit D ever be set on Model Z?
>>>
>>> The -1 (all bits set) is the only "applies to all cases" invalid data,
>>> since this is a common hardware error response. So we can at least check
>>> for this.
>>>
>>> Thanks,
>>> Yazen
>>
>> I think you should check both: HV or -1.
>>
>> HV covers the VM angle as they don't emulate this
> 
> You can't possibly know that.  If there exists a hardware spec of any kind, it's
> fair game for emulation.
> 
>> and we simply should disable this functionality when running as a guest.
>>
>> -1 covers the known-bad hw value.
> 
> And in a guest, -1, i.e. 0xffffffff is all but guaranteed to come from the VMM
> providing PCI master abort semantics for reads to MMIO where no device exists.
> That's about as "architectural" of behavior as you're going to get, so I don't
> see any reason to assume no VMM will every emulate whatever this feature is.

I don't really understand why there would be any value in a VMM 
emulating this feature.  It's specifically about the reason the hardware 
saw for the last reboot.  Those reasons are *hardware reasons*.  IE, 
you're never going to see a thermal event as the reason a guest was 
rebooted.

CF9 reset or ACPI power state transition are about all I can envision 
for guest reboot reasons.  And even then do you *want* the to really 
have the VMM track the reasons for a guest reboot?

