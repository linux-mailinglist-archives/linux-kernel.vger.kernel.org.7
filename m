Return-Path: <linux-kernel+bounces-771003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E23B28174
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A89ACB67353
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2310921B9E1;
	Fri, 15 Aug 2025 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4aFwVGTh"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD23199931
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755267401; cv=fail; b=c+TncNRgVy1sDnW4L5LF9o86hVLzc74tzvCiAGQks4bHLd5j2Oq+MPuucN2wO/hGA8F8Q30xuuLNSW7LlASIPrJ2aAcWYljWOvOtkeoWThH8BWNZSMLOr2GoH9Lk55r5yZSro3shA4SKwdeNS5Y0t76tzGSWvn2TjL1VRir+xD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755267401; c=relaxed/simple;
	bh=4w+HmrEk6+vC3QSVSIkxWA3V6NCkbRov/ZwqeixslHE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sXFJH7uGajkD7CsN8xt/THy8OHBun8PuQWq/1gFUtFTmZ0WAbZFvIdACyiQoLDNtphvr49UPNARGptKEYBZQnqyW1wCaSNKIGMBzi46VlC6Bdp0V5oSCVoTAv6Iv/Y4e+pppyLD5ipX272/R0BFOaOqe+/KVevFgVmmfgry+E5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4aFwVGTh; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFdknYeYlo+lf+1YSoY6HAUddlUfk62XnmuN8KJoukee1Tuvp6FGIK9p9QgSQomiclyCjKaW8xrVtYjTmA+hvPf7pe1Kjv7X+9B+dC5PF+/MQAgRi1c0/GC/Xiau0xuJESaXCLWHax67OVhq1oiRKfHb5hjfejGi8+XzzqqLr2n2LpHdmOb7f7e9PJ4kHw/iZPldajley1cK6Y3QD401lOZ4whWzPNAQ8OzodCMETDBN09+FdMEQRBWK7MlCP2fAgbLNMi1dH5KbEVAGTBQi4m1V6OGhKexrivWormuV0hJKxxzIzN26XbmFf7jAdckvhgluTXy6Lirdin9CgmS9JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqSzzXL5llNtRhQTEX5lN2Xl8WWhzzS6kbm/VNBLJog=;
 b=YQqhMWWrOQt8dxk0ezxivAH8o/5LAdmqJ12WuuXToD/EoOk9Jm5UBkRq8ieCEym7QDzApoe4yl9Q/19YG4SyDlH17kj1W3gkMyq2SeyTQ9TkfMfPvbLdCWbGntY/InhLVIVzvfRrAqmhJdv5O1x5/1CLPNRn2cOoUndxqUo9u3KE5XChK/pYSwfNv9tx+2WsyWFfqXlwxpuXVM/xHmA36amBxeGHbW2AvuYF/ZlskccF45GVgG6lnRpzE40t08cDR3/HmQW7FI2z/8lBoGBIGcx5nttSuohM+8r+Q/Jd63i72OHtcXN/Nk/f0gz0aN/aowdjtElUtqGOv9uOVW0sMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqSzzXL5llNtRhQTEX5lN2Xl8WWhzzS6kbm/VNBLJog=;
 b=4aFwVGThhht0/jR5qdDYMBGZTESJKGXMGqHuO3mxZRYL+exvXfW0dzGMfq8ulgjfDFIxyPPpPzjxu00fPb7w5mAvagqgCv9cFFONFPz/334anGlIwmJFLWGXe0XVVXAQm9z0iM0+VhZifhdi5FyoxoNlf4G9jwa+9PvaQN6LyMs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) by
 SA3PR12MB8440.namprd12.prod.outlook.com (2603:10b6:806:2f8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.20; Fri, 15 Aug 2025 14:16:36 +0000
Received: from DS0PR12MB6439.namprd12.prod.outlook.com
 ([fe80::ec83:b5e5:82dd:b207]) by DS0PR12MB6439.namprd12.prod.outlook.com
 ([fe80::ec83:b5e5:82dd:b207%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 14:16:36 +0000
Message-ID: <8565f305-f36d-42a4-abf2-24e064067fc3@amd.com>
Date: Fri, 15 Aug 2025 19:46:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 3/7] mm: Hot page tracking and promotion
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Jonathan.Cameron@huawei.com, dave.hansen@intel.com, gourry@gourry.net,
 hannes@cmpxchg.org, mgorman@techsingularity.net, mingo@redhat.com,
 peterz@infradead.org, raghavendra.kt@amd.com, riel@surriel.com,
 rientjes@google.com, sj@kernel.org, weixugc@google.com, willy@infradead.org,
 ziy@nvidia.com, dave@stgolabs.net, nifan.cxl@gmail.com,
 xuezhengchu@huawei.com, yiannis@zptcorp.com, akpm@linux-foundation.org,
 david@redhat.com, byungchul@sk.com, kinseyho@google.com,
 joshua.hahnjy@gmail.com, yuanchu@google.com, balbirs@nvidia.com
References: <20250814134826.154003-1-bharata@amd.com>
 <20250814134826.154003-4-bharata@amd.com> <871ppde4b2.fsf@DESKTOP-5N7EMDA>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <871ppde4b2.fsf@DESKTOP-5N7EMDA>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::15) To DS0PR12MB6439.namprd12.prod.outlook.com
 (2603:10b6:8:c9::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6439:EE_|SA3PR12MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: 006689e1-9c8f-4ec4-85c7-08dddc0657ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2JrYTczd0NScThnQ0Q2TTV6dXNBa20zTEtXY3ZCOGRsSSt3dEJNTkpXMkgv?=
 =?utf-8?B?VVNCNTF4N00rdmJlWG5tMU9aZW9wVlV0RlJTNnZUQnhUKy85TUprZkVyY0ZG?=
 =?utf-8?B?YnowYWEvdlJjQ1dMZTFVMXgzMittY3RZU0V6bTBCUVV5c05CNi9IVzRsTGtC?=
 =?utf-8?B?dnBQM2p0Y3lPbzNuYjduV2VYRnNaS0FtaHhCL0ZheUtWenVUeHcyV29jSXFL?=
 =?utf-8?B?ZmVlckpvbnlvVXgvQ1VvMnh2Mm8rZ0VmNXI5MnFVbEk2MWlCZlhYSXdSWUJD?=
 =?utf-8?B?bzZaK1dQd05wWUtFVVBJYUxReE9KWE9OQzh3ellWS3djb1BlblpjOU5JSTRU?=
 =?utf-8?B?a2VqNnNNZTgyb2NFS0xvMHg0V055WW9VUjFWRWdPak9La2RQV0Q1RnJzdUxi?=
 =?utf-8?B?U3JjczZFL0VxaWp5VnQwdUFDTUUrbTFuandVSnllRWw1ZnEyWU9uK3VKMTB2?=
 =?utf-8?B?TmFTbTlpREhBS2RpQlQzdi9KeEh2Q0p3c3g0dzVFcVR3MTg1bWIrVzFIcVpr?=
 =?utf-8?B?Q2hmbHgzRU5yOXBiQ0VObks0cFRiNElDaDdQamswTm9LOTRDWnJqYWtIL3hr?=
 =?utf-8?B?K1ZQZGZDbkpEdS9wWHBjL1FheEJoeEE3bkFEckNUUmpVWDA4bHdJQ042L0JH?=
 =?utf-8?B?alo5bmVIaEo4cUNpQTRlSjNFN05Bdk1Wdld6SWI5YUM5QnlQL0xiTlcyWDlh?=
 =?utf-8?B?cFpaSGlyTU8wUU10bzdUc084WjQzOXlmdEhkOWE2Smx2NHRFaHo1d1pwUHNS?=
 =?utf-8?B?MThuckxDamphN1VKaG1iUjhUellUV1Bpbk5vaE5QdmQxY0c5KzJ2N0h2NzhU?=
 =?utf-8?B?RW5uVFRxMDduRUZLQkhwU1NtRXphTTRuZ1ZBNXlhU3FkVGJzaWlwa2I2TWp6?=
 =?utf-8?B?dW1oOXhXdEtrUTN6Y3hxV3hGZG5jZHFzRWVoaUhFQVNOZk9ucHBRTjBzMjFK?=
 =?utf-8?B?dCswVjlSQXVVUk9aNjliQ0xCRDFMSDRrY0tQeWxLbUxUb0pFVXMrbGRQdmdB?=
 =?utf-8?B?L0IxenlMYjl2ZytOMlNmMFAvVDFCWDM2c2FobzJPcEo0czdCYko4anVHS0hW?=
 =?utf-8?B?N1lqbC9uWXFseWdCZDNYSFhsNEl6NUFvaDE0VzREdXpyMTZIK2RtcDV2VFRS?=
 =?utf-8?B?LzlLc0NHTXJ0WmVveXpPTXgrTFd3WnVZNjY0eld4Mi94dVljQkJ6S3FqRlRD?=
 =?utf-8?B?KzIyMVlqUXJCSkkzUG4zYzVCNGZXODcxc2JIRi9aRGxSeS9zZDFzcEx0dUhL?=
 =?utf-8?B?UXcydjlSNldlZmdueXpjRk9aNHhYVzd6T3dBRTJoZTRGQ3ZWL0VHVFRNMVVp?=
 =?utf-8?B?OWw0T2IxUUQ4S0p6bUR0R2RtZlpUd3FnN3phVFFmWnVERDIzNEhaVXBsUS9J?=
 =?utf-8?B?d2VuSlJ5Yit5Y1JJMW5TeUhOWjcrL2liL3E2RkRZcXNZd0dHWGNHbWIvMTBn?=
 =?utf-8?B?WEVUcTVndWxhNHpSTk5Jckc2YVdHM001bGRRbnphM1p3ditFMHRFNVU2WW5n?=
 =?utf-8?B?bVVMU1hoUzB4NFIxRnRHNVRUc21HUTc4U2kxellHSTM5ZS9oYWprbFU4QUha?=
 =?utf-8?B?N0dIRUdaM1A5NFNGN0JkRzBVaHIzc3JOVWxDeVk4Z0IweGJJd3U0SFpFY3hj?=
 =?utf-8?B?aWlmNy9Sb0tSMkdaSEZEVWR1T25ZL3oxUEROd1JOeHB5UEpCcW1zdGpRZktP?=
 =?utf-8?B?ZFJBWXUvWDBFVjk0dkRjUlpDZUQrQldISzlpL0NPTXY2Wnl1UmhRQzc2TGx4?=
 =?utf-8?B?SWNEeUIxc24vKy9VWVRndjBWNXFQdUlRamFRcElvV3lvUTVoMUs0U21Rcjk5?=
 =?utf-8?B?UjR2WHJudHdlVGp5SGszbGMwNy81bTJVSFl1cVA2bE9xTU5nQWx4c01ueEFj?=
 =?utf-8?B?VmZrdXpFVnh5dyt0enZsUXF2MW0yaGh1ZzByRXhzUjZjUjgxek5uMURFVTZX?=
 =?utf-8?Q?/AfTP1Cn3N0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6439.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzN2UGx6R3A5ZnBQT3p6MDNpYkVQTXpmSUlKMy9NTnRYdUswOFZaRlBOa1l3?=
 =?utf-8?B?RENwUkVkeS9Tdy9FVG55Vlp4ME5TZENKM2trYW50ZlZ2N0JqK3Z2Y2hvK0Qv?=
 =?utf-8?B?MDlyWXUxV21sWmFtRGFVdnZRQThiU2JRNWl2YkpMSnBzK0toa0VYeHZTcjNO?=
 =?utf-8?B?MFZxT1B4NVUxTExRbU9yb3IyaXl2cENlRDVGaFNJY0o4TExDRUNEdVpXMng0?=
 =?utf-8?B?SDRLL3ViZkdwUEpaN2k1dktvMUd5UW16c1RyVng2REpnUmxOYUwyZWYxS1BC?=
 =?utf-8?B?NEtYdVhuaWFrMHU2S2NNT2x3eng0TnZNamFuN0VmcUlab0lrb0J3UlE4RmtY?=
 =?utf-8?B?bTJzYStCMWQ3cGx6ZzRoRXQrYVRyMzdIOHVMb0JQNzcxVmw5YzU1SjlKNmdJ?=
 =?utf-8?B?RTM5dk5GekFIbThoME1CQXJsa0VWa3E0ZytyN2FBRkdqOFJWOVdUNW1MTkMy?=
 =?utf-8?B?ZXYxM1pybHFuaERKdTFPNVdldFl0VTExaVRMZFhOQnRpZXF6bklaT2ZRakhQ?=
 =?utf-8?B?aXNSWXVyc0ZkWUIxMm5GOVFtQUVYR1RNa3FieW9FSEVZakJDNW5OT2swUFNZ?=
 =?utf-8?B?Ris4YnR0ZTFOSEphVHdieGNBR25ZSUJOd2huelVDRXk4TnVuRjFhMit4RE5B?=
 =?utf-8?B?ZVIvbzh0eVlnY1EvM2FSWFh4YVNHbnNuNXJUSkEvNXNsdWpzOHExMEVIZlRE?=
 =?utf-8?B?TkVyNWFlZEQ2ZGxEVnErRjZZL2NEZHRvNmZSNUhHclpKaSs5N1g0eVU3aTh2?=
 =?utf-8?B?WW9pR1RveU5FUEtic2JacFhxejJSMm95djYxU0E1UkF5NDdCdDNnUndna1Qr?=
 =?utf-8?B?U0J4WGdiWlc0QlhMREx1SEdONjA2aVhqQWgwTmhMTjJXSXg5Z3E2NmJlSzgz?=
 =?utf-8?B?bnhvd0FJa2ozZ0ZreUd6eDBnWm5oZ01lTXNuR1drMk9CV3o4dzJoNnp4RWlR?=
 =?utf-8?B?NUwzSGRmZ29ZNnRmUThRMFJLNStEajN6ZENsMC9iNjllSWRnZmN4M1pZSFdl?=
 =?utf-8?B?cXdNWm14eGVPYW9sTDRjRDZWQ0hWbTJQZFY2WlhSK1QzME5ScUVBZ2V3V1Fl?=
 =?utf-8?B?S2VTUmY1WGl6RFUzWXUyS25maG1IRWtIUUNtT0VzZEdtaDBnM0RTaXc4S2sy?=
 =?utf-8?B?KzFkS1paYWhzSmJrVG12NVNhUm9haWZsZlpiL2VkRlJMek9GRzVIVXRhYkEx?=
 =?utf-8?B?Tkd6U3FZM0Z3U3ZYYWxZTjZYV21uNDY2aC9xU1BqYkVrMnVma044bHU5L3ls?=
 =?utf-8?B?VWNEU0lIQjd4aWs1SGh3WTI5ZkEzekkvMlY4dzZQL2FXbnIxclBIZTkxS21Y?=
 =?utf-8?B?WWpVczdONWFVdkc4YzFrbGw1VVowamhLYWlaUGJ1WXVTQ0JlcnZBRHJubzdw?=
 =?utf-8?B?T0EwK2pSRjc4V0kzT1lSTXV3Nkh5NTBXNjU0ZXoyaDFsM0l3NHUraTFQMFN3?=
 =?utf-8?B?Q0ZvTGgzTjJuUFgwc3ArUXJEUUhaTEZWTXo4KzhWR2FJaGxBYWRPZXdNcjJO?=
 =?utf-8?B?ZUhzZ3UybnU3amVPWDkzaXBHNFV1czBJcDQ1bFNqR2ZpamFOZjBDaGVqajM1?=
 =?utf-8?B?ZU5wbFpmbGNobDA4SzRaNjJHYndsSWk5ZnRrTEJUZzh3Nllsd0VNblhnd1Ju?=
 =?utf-8?B?bVRHV2FnYmJlUFk4Y2U1TjBGWk5jR24zdjF2M2F3VzVMM2c5MlRHUHdDTDNC?=
 =?utf-8?B?VDJaT1hGZWFtNDNtNDlGTmtnOWJMd2VhNHBZYVk4aVZDaHRITFlFQ2RqNy9o?=
 =?utf-8?B?T0tpdmZWNHo3TFREOXVMWittdlRoVzlTNGpaM0dqOWhwbjJxMUNpZTl4ZHJE?=
 =?utf-8?B?Y0ZETnJmbUsxM2ZBQnVqQW90L3A2MUlOWmgxVlVyd2xNelFjeWxiQnE0K21F?=
 =?utf-8?B?NndOSHNoaXJWVUF2Sk12U2laUzgwd0ZlTEdzSElwMUorb1g0VVBmQzJERHlU?=
 =?utf-8?B?NjVITVRUQkE0am9KSGc5S0I5SVhKdy8wNzIwL1hweGtJKzBkL3FyNUdrTWFC?=
 =?utf-8?B?b3RQbGNZVFd5ZHl2Z3Z4eU1TYlFDVWVGOFhpaXdpdW5XaWJCOENYb3JWTnJK?=
 =?utf-8?B?b2lJVm5jRzZpRitXODU2ZWdsVW1LRnRjc05jaDJIN3RFS0NwRmhpUGpPa0sv?=
 =?utf-8?Q?GBlzfOp1yQs1SSkEqZxToqnT4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 006689e1-9c8f-4ec4-85c7-08dddc0657ab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6439.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 14:16:35.9397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDyX6ZOPcNr8VC87iGSDTFOVSaUkOcffOxUEkEKD6wDSz+GvpoD6dy8aww/hABo0lQssYUoQOD1Pdw15wF81rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8440

On 15-Aug-25 7:26 AM, Huang, Ying wrote:
> Bharata B Rao <bharata@amd.com> writes:
> 
>> This introduces a sub-system for collecting memory access
>> information from different sources. It maintains the hotness
>> information based on the access history and time of access.
>>
>> Additionally, it provides per-lowertier-node kernel threads
>> (named kpromoted) that periodically promote the pages that
>> are eligible for promotion.
>>
>> Sub-systems that generate hot page access info can report that
>> using this API:
>>
>> int pghot_record_access(u64 pfn, int nid, int src,
>> 			unsigned long time)
>>
>> @pfn: The PFN of the memory accessed
>> @nid: The accessing NUMA node ID
>> @src: The temperature source (sub-system) that generated the
>>       access info
>> @time: The access time in jiffies
> 
> How will the page hotness information gather with NUMA balancing hint
> page fault be expressed with this interface?

Something like this can be done for reporting accesses detected by
NUMA balancing -
https://lore.kernel.org/linux-mm/20250616133931.206626-5-bharata@amd.com/

However we need to bypass the hot page threshold detection and rate
limiting and have the same or similar functionality implemented within
this patchset.

Regards,
Bharata.

