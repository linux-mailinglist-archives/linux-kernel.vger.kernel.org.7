Return-Path: <linux-kernel+bounces-777927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF86DB2DF46
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48B17687066
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3705527381C;
	Wed, 20 Aug 2025 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="slcwCbM+"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022107.outbound.protection.outlook.com [40.107.193.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8551D7E31
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699824; cv=fail; b=LiXZyH/Q0ir60PzXngfeilfCvSuhYnzFTmqxmJtrEvXpwoq51eovynmPsdu/HJdfLJelpZrGnOG8+NTWtYVS6/xpESYUYkzSLUCW2fyvTNmN4xagI6GBZeEttAwKm0iL4LN9/ALBCIikeqIHqNlRHr2xZZpaiRbtbXacmORDrFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699824; c=relaxed/simple;
	bh=5R6+FECB7PASCIIluahnd6ANN3sRkeU/iXllDLBVk5M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cKYM+aUlOxz7Fvo4vzP6HYUWbNl31xeHKsdF4NB+RWXOndPlqFLfDHDgtH9TVU5K+gxLuJar5K4TjMmO64XBMIkYplrRAeJx1xb05ZpwkDZCErH4J7HRMV5MR/gJ+biGlEIzGrZgIFy8qDATX5IuJpR3zr6AKOQhX3gQNngm+kM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=slcwCbM+; arc=fail smtp.client-ip=40.107.193.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFNMPX3jxwmxu+a3axszkjFbwvvEgFPurOGT7dbQRaLgv6xVE3w8IO5owiqS9aLNIJo2qEdBvb9kwCKXma5JV73nKkSN2HQNtplpbn2NSb35QGoDQfp8LTY+c13QXc5QcDwTIVZ1aWiIalcGd5BFAzihkWVtqLAbPtb8+ibS0aTdCqeRIfqM4/m8Qs1I+YMb8KLog3cS9mkjHyPTO5ysa5q+PxsAtzR/IFzy7/e0fHN0eJiOiDNCzelzXKNv2FsPOeOZCdxXfp2/6FYXHt8qWSLq/kP+Ee19LTlLS89NGyRXJ+9Hu0uvKVy+SjjpahtAYFIzr9thqLpqqAJR+ywbNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+8tUmwT2/MsnA65XVj6QtImT7R5CVkmSDKrBmn2bvg=;
 b=iQ7FkpoKDxQFiGazV0yfir1bQc1zOnELiIxZXrA2uhYIIPUG+A1XDY01YN6WzuIQUR13y0ZJR9+qzTBTwn6HTWOiYhg4SAqaYQtauILIFGeJOECZwq0W7yTpNDvslg4pLvKQnSsIHn0HTcfccICh5jtHCwbQv9UfvIS8SLGtJY9uGOxLpPai4x3HYOO7IbSbpJH0xCJlwgYgdezlivlPA3oaevcff43VLYbwEES+axK8sZoDWRYDiR53UQNY0fjQV/5oG3CKIUX1OBEaug8VLsrLjrX063f1e07dvEiVCmjyjDAFJtOongX+ZKa/+o36jfDeTeUlOQps16SWSKyndw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+8tUmwT2/MsnA65XVj6QtImT7R5CVkmSDKrBmn2bvg=;
 b=slcwCbM+JY3yANbP/1GkCXLEHsesHby8xkBV6K1P4Zut/rM5NVXbDJ09MQGuAdM9OZlaKC109mKbWGmQVmRZ3rA+jR77TRHxhcMUTcikNp3ka4hT+yaZvEfmgbznjneikLe60PbAxJbdom4NJCEfYVcgSisBiugXFCf7ZYSjDKzoxr1/LEA33kKWohshG8gLUlaS3+Jk+gW1r9CCv+OcGihyFLo5Uq5Kd5u870l135agjQ0uwAnORqLQvZtJdx6730WmxRsHDYzIajkj/gwlg1R9XC+KF+GkUvolati1VtiTXcXVYjAUVXZiK8KO3RD4/niODPNk1OGcW6o5bBlROA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB8758.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 14:23:37 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 14:23:37 +0000
Message-ID: <8fdb9b21-a918-44bb-b9a0-cd8cbe6379c7@efficios.com>
Date: Wed, 20 Aug 2025 10:23:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 01/11] rseq: Avoid pointless evaluation in
 __rseq_notify_resume()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Wei Liu <wei.liu@kernel.org>, Jens Axboe <axboe@kernel.dk>
References: <20250813155941.014821755@linutronix.de>
 <20250813162823.845026450@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250813162823.845026450@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::40) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB8758:EE_
X-MS-Office365-Filtering-Correlation-Id: fe7ae672-afbf-4836-9975-08dddff526fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1B4ekFZZTFkak9Sa2lMZlBDTVJGUkp3TTRTTWtHdVNJM3hjLzZGTnQ1ZXhK?=
 =?utf-8?B?NFpwWFFEclVKK3RSMHplV2U4YmpmSlNBbWRTOW8rMU1pV3FIQUxBODhES3dw?=
 =?utf-8?B?MEt4UlhkQUdkcklKeEhBNS9sb25wYkZZQ1dKNlVvMVlnOUV3VzFBRG1XVUsr?=
 =?utf-8?B?Y1JYTitTVGdsUHVjYXFnM05YUEIzaUpVaGltNlFnSzFNVkcrRldVSUs2dmZJ?=
 =?utf-8?B?d09UUTlKaTZUTUVjc0k5SUdsaENjSHN5b2lSUXlvZHhPcmIyNmVjMjJqNG1r?=
 =?utf-8?B?YVZLMjhDRDUvQkhZOUhWdTcyMEs4QWdYcXJScXgvWTdqTzQ2bjg1a3FIYjNV?=
 =?utf-8?B?ZEg2OXU4aC83OGZndGR6SGQ0SndFTTJXVmhDbnRPTlJQMmJPa3RIZ3ZSd2d1?=
 =?utf-8?B?WWFiQUhJVEduUVNVZjd1cEp3S0Z6Y1A5N3V6VkdhWU4zQUJ2VGlDS2ZtT2VZ?=
 =?utf-8?B?VDhoSEZGbWIzMEJjSFdRa011T3VHcTRSVW9jRFlPSXVpSEYybWtHOW5hOEU0?=
 =?utf-8?B?UnFWNHRWSTRzNXQxa2p1akdFTjBvTXptV3Rqc0pPNzVHbUFackNOWlFyc3hX?=
 =?utf-8?B?WnJoZUtraDRjcEM5WmRWSVRuandnUVV0MFREVVBaLzh1aG1vdzIzUWtlTEZ1?=
 =?utf-8?B?cUVEeVY4SGZ6UGVDcm5VaFNXZXpuUmF2K3FMdnVVU3RyVGJIQTVMSExBRmtP?=
 =?utf-8?B?NVVMTkdOVzlyMlU5OFNsV1BrdWwvMDF2M0I2UmNFSHp1bGh5OG4ydlFYaCt5?=
 =?utf-8?B?MXF2dUp6bjBTMDRLR2V2WTd5SmN2K3Mvakt4ajVXek1Nb1oyV0pqTERrK1Z0?=
 =?utf-8?B?RE95MDFCVmtwaE4yazgzU0VJNCtiZGxUN0oyS3FuQU9iS2tCR1lncVFPZDYr?=
 =?utf-8?B?RFJja3paSjg2MER5cllqbFozWGZKd1lZei96Tms3S3g0enBPMEdjSFJvLzl2?=
 =?utf-8?B?TGR4L1hPUmR3SnNHMTV1SzJUZEExNHNEMUFhVFVWSDNnYjYyL2psZzFPSENx?=
 =?utf-8?B?RUtaYnBEbldFQ3BNbkN3Ykp0cmpDSFlRcHBnLzBLbG9mOU4vODVETVFBa0Ji?=
 =?utf-8?B?WDZYeUhWNjNFODhDa2h3Vmp2eFNGS3luMUYzRzZZMFdLSjAxUDlqRVBmZFJN?=
 =?utf-8?B?Q3FYcWcxTEVrVEZhM2F5eGxJWG9NTFZ3V1ZVVW8xZ1VlQTVpeVBOSGFTclZx?=
 =?utf-8?B?OU8vWGJ0ZU9nbEVieDV6SHJaY0R2R0pMSUNSU1ByYkdQb3VSMG1iTHUxeXVJ?=
 =?utf-8?B?NGhOQjlqM1RRZTRINFVQWDZOOCtWVHg3TWdHV2JTdmhTR3BESHdSRWwxbzhJ?=
 =?utf-8?B?SkRFSEJhTmovdEZDc294Wk5TaVI4NUQwNkl0WnRDRHFKb203b2dhZE4zdEdp?=
 =?utf-8?B?dTJ1dlh1T0dJZVp6QkFIbzlhcW5wMjNtM0dPMmJ2dlUwV3FQZE1lTHhONWpu?=
 =?utf-8?B?NDRiSFFjaldCTGlYTmpoMGE2a1NORGMvbHEyNm0xSGI0VmV0anhiNlNLbjI2?=
 =?utf-8?B?d2JEWUxtL3g0d3h5K3h2MjhUOGNPcDd4MU14SWhhcVdyM2RyVUJPUlNRaUg3?=
 =?utf-8?B?REYrQnkwQkZGbmJGWklySy8xb2xocFhicmV0UWFjbG5Ob3ZOeEdQUFFTZzg1?=
 =?utf-8?B?cm5rQ09jdDdKRmFYZ3k2MlNkYmhJQWxCd05RMlpYMDJhVXdNcmt0c2JISkNn?=
 =?utf-8?B?UWx1ZVBDVmZnVXVEQTZKYkhxclV2cjBUTHNpWVE5NFBSN2lSVFNHc0xmcGU5?=
 =?utf-8?B?VmVDS0VBQzFLVG4vaE5QOFpiRXRPRVViQldBN1VHZ1VHd09vcFhON0tOQ0Ur?=
 =?utf-8?Q?kQlGgr9liWjshMD7aPLlf1e8A4JHvjX8EHxjE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGREUVhKZWRSK01oOVVSWURDS1lGOGs0djU4NHlUaDREZkhPd2dTNEo3U2lC?=
 =?utf-8?B?aVdmaloxTGV6cnNrbUhaRWYwOUwxbjJGdU9uZXdTYTk5aEtkZGNJZTlYbm5l?=
 =?utf-8?B?cG1JUzV2RUtCUnA2anFlenZkQS9BVU5BVU9FZEdkSUlQeHZNdWZ6Nys2R1lY?=
 =?utf-8?B?Rk9KMlIzZVkwUE5GMTR5c3g4WXVIZ0YvL0lOdll3UzNDdk9WQlNKcTZTSDB0?=
 =?utf-8?B?dW1kbEZjTVpkT0trNlRyR3MvVWNVMTNtNUdVbGFZMTFkc1NIZXBJRmcxOFFJ?=
 =?utf-8?B?ZjF6c3VTNlR6MERqMUptM0pLd1FzcFZzc00yLzVORGdVT2Q5d3hTNzE0R095?=
 =?utf-8?B?L0VBUHpDaGlYVlJlR2hBQS9pZGVXQ0plMXYwR3AzYU1ETkZtUnlCSi9CTXJK?=
 =?utf-8?B?Si9Ldm14aGVTb0g0MnM2L0Z0MEtWVEZXblpacWtZUXFCbFhrb2JueURsenB2?=
 =?utf-8?B?UllsVjhCd1k0djF2QU1iYjBIb1NjRFgvOXpKWUhoSHpFelRBazhRMlc4Y1du?=
 =?utf-8?B?SmtBNEhwUWRBQmlYYUxVM2U5S0xQVEwvWnZVYzd2MmNiY2ZKMStyd1Y0RmtX?=
 =?utf-8?B?TEMxbnE1SGNxanRMaFBrZlYveWx1dHB6VDhFemFjUDZjc1VKNVo5cUF3bEZR?=
 =?utf-8?B?YVVkeTF5NSsxNWRkdEowOUpqWjMzZVVPcG9Ec296Q0theldET3UycHdqdHI5?=
 =?utf-8?B?NWV6UTNGa2piWlhFVjhPZEgwcnl2ci9VTUVZVFpkWllGWmU4dzdZbEpUVzRJ?=
 =?utf-8?B?dFp2STMvcEh5T0YwSG1aRnN6VWlBT2ZUOWM1QmZxVEdURkI1M1BrZU43K1VP?=
 =?utf-8?B?aFFwVXpZT0FyazU1aXNxeCtYOTFxYW5hVzQ0dmhSMGtGOVRocnEvWHBvSnhI?=
 =?utf-8?B?SFN4TjNjeGFHOFVmZEJUcnFWZHYrQklMd2lBR3dzeXF5VC9YVUt4d0JhcWh5?=
 =?utf-8?B?M3A1WXJRd2lSQU42dWJyZDhicDYyeHRpSmxjUk5EK0x1RGVJSFVZandtVlBa?=
 =?utf-8?B?L0E0MnZTdnB4QVlvYnRsbklCMCtWNXZEZjNaa0RYcUQ3TENEanhIUHZvL2ky?=
 =?utf-8?B?UjA2aHFoaVE3cTV6WFdrSDlPMmdHeTJjRXVtYjNaWjJTRVRrRVJwMXRMT2dN?=
 =?utf-8?B?TlEyRklKYVNlZ044MnAydkROSzJ6RzBaNHRpOC9UMnYzNEtDSHhFbGxxSXUv?=
 =?utf-8?B?WGUvWmFhMEcvNE1vVTMvNzZxNlVvVUtvaGNTaUp1bm5VeElaM2ExNEt2MURm?=
 =?utf-8?B?c0Npek5pWnRtWVJiT1pHTHRTd2x4eVNFcG1qZXlnZzFUc1BQRys3a2h1ZTk1?=
 =?utf-8?B?SU85ZUluRzFjOVp2cFJrK0dORWwrT0R3bUZKR0NLeUMvUjZvcGRYL2VDRzBz?=
 =?utf-8?B?ZTkrc214eTM3THhWVFdtdEhETldWRXhEVnRXRE9qOWRxVVNydmw3S05LTTlX?=
 =?utf-8?B?aU5Wbktvb1drMmYremsveHpwcDcyUEY1eEo2QzdwL0srSW4vdnFnaHovOGZZ?=
 =?utf-8?B?MXowbFRNNTA4Qmo2dXBtSWlQNVNoZ2J2aGg5K0JlRVVJRkwrQ1N4QWlJeUxi?=
 =?utf-8?B?cWoxa0VEMmFzZFhyTE5SRjhDYWxtWTIvRlZOeE5KTm1Nc3BHOUcyVGNhOG91?=
 =?utf-8?B?OUpyN3ROaFd0VGdWaHEvZWdFbWE4ZjFWZ3ZKcEt0VXZ0cVZ6b3VsOEhqREha?=
 =?utf-8?B?QWtxTGxGK3Q4RnIvNmJRVC8vWnRMTFpyeGltc1MyT0plbnFaemF2Q212RTA1?=
 =?utf-8?B?WGFvaFZwVjhYdWRGMnFOMkk4VzcydnQzNFlQYlBrNll5TkJHN0NsTzJtbmMw?=
 =?utf-8?B?TTlvRU9Id0pkb3FoUU55TEpoYzFmTFhjSThDRy9jQThkMEZiY0hsYnZCWU1a?=
 =?utf-8?B?SHluWHlZSi84YjRLNkdyU1lWWFZ6bVVFVk40VWpDSGJUMmxnbFdSR1U1ckxQ?=
 =?utf-8?B?RSt3U3FUR3NYSENOWDh0ckp5ZjFBblZqWDBmVnp0K0lEM21iZE9HYmV4K0tD?=
 =?utf-8?B?VDhJeFBHTTFRaWlyM3NKTlFocnM4eFREUEFQSmthNHJzUzA2WXcrS2xVSHVx?=
 =?utf-8?B?eW1ITFRsMlIwM0xmSzZtNkkxUzAxeHIvYmZabjBhZWxIOUx4ODgvc25XN1M5?=
 =?utf-8?B?RWJoR0MwSmxIMlVjNUpTanBpM0ZMcGJKblcrUkxGTnowRUFzMFJTUVB1bmxR?=
 =?utf-8?Q?F5uP867acHqOb23CbzEEgEI=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7ae672-afbf-4836-9975-08dddff526fd
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 14:23:37.1988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+clMOtm+r6YGDbEyrvkDnAnGu2X9Z3kNm3PSfUAMws7dUerCTXRIgRWnmXB8kZkW9FmBm2DduYEe13ieJb7xMWqTdniSo84JKhTrcWIUIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8758

On 2025-08-13 12:29, Thomas Gleixner wrote:
> The RSEQ critical section mechanism only clears the event mask when a
> critical section is registered, otherwise it is stale and collects
> bits.
> 
> That means once a critical section is installed the first invocation of
> that code when TIF_NOTIFY_RESUME is set will abort the critical section,
> even when the TIF bit was not raised by the rseq preempt/migrate/signal
> helpers.
> 
> This also has a performance implication because TIF_NOTIFY_RESUME is a
> multiplexing TIF bit, which is utilized by quite some infrastructure. That
> means every invocation of __rseq_notify_resume() goes unconditionally
> through the heavy lifting of user space access and consistency checks even
> if there is no reason to do so.
> 
> Keeping the stale event mask around when exiting to user space also
> prevents it from being utilized by the upcoming time slice extension
> mechanism.
> 
> Avoid this by reading and clearing the event mask before doing the user
> space critical section access with preemption disabled, which ensures that
> the read and clear operation is CPU local atomic versus scheduling.
> 
> This is correct as after re-enabling preemption any relevant event will set
> the bit again and raise TIF_NOTIFY_RESUME, which makes the user space exit
> code take another round of TIF bit clearing.
> 
> If the event mask was non-zero, invoke the slow path. On debug kernels the
> slow path is invoked unconditionally and the result of the event mask
> evaluation is handed in.
> 
> Add a exit path check after the TIF bit loop, which validates on debug
> kernels that the event mask is zero before exiting to user space.
> 
> While at it reword the convoluted comment why the pt_regs pointer can be
> NULL under certain circumstances.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> ---
>   include/linux/irq-entry-common.h |    7 ++--
>   include/linux/rseq.h             |   10 +++++
>   kernel/rseq.c                    |   66 ++++++++++++++++++++++++++-------------
>   3 files changed, 58 insertions(+), 25 deletions(-)
> 
> --- a/include/linux/irq-entry-common.h
> +++ b/include/linux/irq-entry-common.h
> @@ -2,11 +2,12 @@
>   #ifndef __LINUX_IRQENTRYCOMMON_H
>   #define __LINUX_IRQENTRYCOMMON_H
>   
> +#include <linux/context_tracking.h>
> +#include <linux/kmsan.h>
> +#include <linux/rseq.h>
>   #include <linux/static_call_types.h>
>   #include <linux/syscalls.h>
> -#include <linux/context_tracking.h>
>   #include <linux/tick.h>
> -#include <linux/kmsan.h>
>   #include <linux/unwind_deferred.h>
>   
>   #include <asm/entry-common.h>
> @@ -226,6 +227,8 @@ static __always_inline void exit_to_user
>   
>   	arch_exit_to_user_mode_prepare(regs, ti_work);
>   
> +	rseq_exit_to_user_mode();
> +
>   	/* Ensure that kernel state is sane for a return to userspace */
>   	kmap_assert_nomap();
>   	lockdep_assert_irqs_disabled();
> --- a/include/linux/rseq.h
> +++ b/include/linux/rseq.h
> @@ -66,6 +66,14 @@ static inline void rseq_migrate(struct t
>   	rseq_set_notify_resume(t);
>   }
>   
> +static __always_inline void rseq_exit_to_user_mode(void)
> +{
> +	if (IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
> +		if (WARN_ON_ONCE(current->rseq && current->rseq_event_mask))
> +			current->rseq_event_mask = 0;
> +	}
> +}
> +
>   /*
>    * If parent process has a registered restartable sequences area, the
>    * child inherits. Unregister rseq for a clone with CLONE_VM set.
> @@ -118,7 +126,7 @@ static inline void rseq_fork(struct task
>   static inline void rseq_execve(struct task_struct *t)
>   {
>   }
> -
> +static inline void rseq_exit_to_user_mode(void) { }
>   #endif
>   
>   #ifdef CONFIG_DEBUG_RSEQ
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -324,9 +324,9 @@ static bool rseq_warn_flags(const char *
>   	return true;
>   }
>   
> -static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
> +static int rseq_check_flags(struct task_struct *t, u32 cs_flags)
>   {
> -	u32 flags, event_mask;
> +	u32 flags;
>   	int ret;
>   
>   	if (rseq_warn_flags("rseq_cs", cs_flags))
> @@ -339,17 +339,7 @@ static int rseq_need_restart(struct task
>   
>   	if (rseq_warn_flags("rseq", flags))
>   		return -EINVAL;
> -
> -	/*
> -	 * Load and clear event mask atomically with respect to
> -	 * scheduler preemption and membarrier IPIs.
> -	 */
> -	scoped_guard(RSEQ_EVENT_GUARD) {
> -		event_mask = t->rseq_event_mask;
> -		t->rseq_event_mask = 0;
> -	}
> -
> -	return !!event_mask;
> +	return 0;
>   }
>   
>   static int clear_rseq_cs(struct rseq __user *rseq)
> @@ -380,7 +370,7 @@ static bool in_rseq_cs(unsigned long ip,
>   	return ip - rseq_cs->start_ip < rseq_cs->post_commit_offset;
>   }
>   
> -static int rseq_ip_fixup(struct pt_regs *regs)
> +static int rseq_ip_fixup(struct pt_regs *regs, bool abort)
>   {
>   	unsigned long ip = instruction_pointer(regs);
>   	struct task_struct *t = current;
> @@ -398,9 +388,11 @@ static int rseq_ip_fixup(struct pt_regs
>   	 */
>   	if (!in_rseq_cs(ip, &rseq_cs))
>   		return clear_rseq_cs(t->rseq);
> -	ret = rseq_need_restart(t, rseq_cs.flags);
> -	if (ret <= 0)
> +	ret = rseq_check_flags(t, rseq_cs.flags);
> +	if (ret < 0)
>   		return ret;
> +	if (!abort)

Sorry I'm missing context. Which prior patch introduces this "abort"
variable ?

The rest looks good,

Thanks,

Mathieu

> +		return 0;
>   	ret = clear_rseq_cs(t->rseq);
>   	if (ret)
>   		return ret;
> @@ -430,14 +422,44 @@ void __rseq_handle_notify_resume(struct
>   		return;
>   
>   	/*
> -	 * regs is NULL if and only if the caller is in a syscall path.  Skip
> -	 * fixup and leave rseq_cs as is so that rseq_sycall() will detect and
> -	 * kill a misbehaving userspace on debug kernels.
> +	 * If invoked from hypervisors or IO-URING, then @regs is a NULL
> +	 * pointer, so fixup cannot be done. If the syscall which led to
> +	 * this invocation was invoked inside a critical section, then it
> +	 * will either end up in this code again or a possible violation of
> +	 * a syscall inside a critical region can only be detected by the
> +	 * debug code in rseq_syscall() in a debug enabled kernel.
>   	 */
>   	if (regs) {
> -		ret = rseq_ip_fixup(regs);
> -		if (unlikely(ret < 0))
> -			goto error;
> +		/*
> +		 * Read and clear the event mask first. If the task was not
> +		 * preempted or migrated or a signal is on the way, there
> +		 * is no point in doing any of the heavy lifting here on
> +		 * production kernels. In that case TIF_NOTIFY_RESUME was
> +		 * raised by some other functionality.
> +		 *
> +		 * This is correct because the read/clear operation is
> +		 * guarded against scheduler preemption, which makes it CPU
> +		 * local atomic. If the task is preempted right after
> +		 * re-enabling preemption then TIF_NOTIFY_RESUME is set
> +		 * again and this function is invoked another time _before_
> +		 * the task is able to return to user mode.
> +		 *
> +		 * On a debug kernel, invoke the fixup code unconditionally
> +		 * with the result handed in to allow the detection of
> +		 * inconsistencies.
> +		 */
> +		u32 event_mask;
> +
> +		scoped_guard(RSEQ_EVENT_GUARD) {
> +			event_mask = t->rseq_event_mask;
> +			t->rseq_event_mask = 0;
> +		}
> +
> +		if (IS_ENABLED(CONFIG_DEBUG_RSEQ) || event_mask) {
> +			ret = rseq_ip_fixup(regs, !!event_mask);
> +			if (unlikely(ret < 0))
> +				goto error;
> +		}
>   	}
>   	if (unlikely(rseq_update_cpu_node_id(t)))
>   		goto error;
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

