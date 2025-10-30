Return-Path: <linux-kernel+bounces-878592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9F1C210F9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97DFF3BFEC7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CEA3655E3;
	Thu, 30 Oct 2025 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="su9L0il/"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022095.outbound.protection.outlook.com [40.107.193.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D3A312801
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839471; cv=fail; b=t9Uu3aR68RnBVa/D4vn46IXX6KBNCe7FbLuPnqtF3jVBL4RnmdcAb/aKQMzPtmwATptowb3rEdQ97AoyCLCX6XnD5sULVAHGFSxHRDdI5NKv8IVD7ft4b+14w5h9D5yz01WOIU+MYt4JV1U3eL23QoZAnH0vZpZHPtmGcnEL7Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839471; c=relaxed/simple;
	bh=F6LryvBmdL/wzC3tfd7+hC8RY4aLCUxD5OOSsRo923g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p0DAusAy640aY+43vr9QTALAAHphg9O0mSgBU7avHmR832jXUNj+m42v+frwhuKSKJZjUWlUyiya753mgBySFB83ZFdvLsZyumRb3Iphd3o3Wp8Baf5xlyY9FrHlU7JRNy72iwuMCIJFHepd4eLHaN9YIJ6Qv7soqYeHlXP4PMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=su9L0il/; arc=fail smtp.client-ip=40.107.193.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBLjrv58FzTVg18scwIL+Zli6YK5SF+ZE3uQTy74UOEPw62k/67L3TGNgWN6roPUNZMH1nJGY9gtLNRqbD3Vi7YmLAtAOb58B/jYVl80ZtNaC1r1tPHbr8V9iFzHnYy71s24LACKI5ZzvcKhCzkN9VIGcQ+SFy/fPDB3+lSQeRPDLROANIZAaS+J/Q66b0PcfCx/KocGlmBXjGoFLQhwIZ74EaQmQQAT4WzmXnO7r5jvvFtzEGyaLD0egAz/33/EJxUpungbgK6RmRNmiwrhIKzhnckof8YdS1IQWWNxhjR9AkWe/tX8mZTynqZQJgCOyf0wDHXqzYBOD1UAhiRobw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlWGTh9UKqckq9X0qms1JXm6/dtAzzhPnYlayA/+3zE=;
 b=EO4zgr3ZG5CViZVGE/2oCcmexNtW29fVVgA2aqjjFsjrG9LhjpKdujVBIcJwkNF67FxL0WPU9CJZwqlYCeQl9u/HbsAvaJdMHwA1MX3jqwlVERIxno21+uXsI4c0Zyv4kzuI70v2xIQ3AeBFHiOM8gjYA8YSlApHNjER1X4uDNR0UkOMTlMhW4VA9mFoN1+GofmBuPNSfOO4rqfMHS2oaLJqmoP+kdMw+xwP7g/z9L8zqaOC/pu+lf5SAUfL5E0ujfTe1xeDz/avP6tT17s+szQCBKja05lXiMO/g6xLGi9QYPns9WM63XvGrQGA5ZveKhhaVLcBkTZ5VLEdGiWDpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlWGTh9UKqckq9X0qms1JXm6/dtAzzhPnYlayA/+3zE=;
 b=su9L0il/yL5mVVRn9vm65sxi/I0diZGj6H+Bi8Kw5kikZTztThzxV9OUCs+xR6rRIJ7kh4Juk6Bnv3j/tkLv5jVFqE8FrmoaW0riysXifLxVKx0qu5mLpNefNOYucBgAa5BRV3Bw2yWfP0ZZ/puSWaISL9psTuRXvOh+/i+RpYNjZFNZI1j8OqeCBvWTjk4lHbhuyWdu/mv/t4jAovFl23EdAy9G0hjrG/zh3LedwcbbPTIDBxfWkxB6xOc/lWmNP3T5MEZjWzWQIREo78nnZy6tVUGDNi2bUqbDnIvhgP4yfsxXkSDurNXZLcD41bwrQ5iu0fpeNJTyHbUI2NtaQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB10361.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:8a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 15:51:05 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 15:51:04 +0000
Message-ID: <c2e4fed9-b207-4d28-93f5-b09f0fe78e35@efficios.com>
Date: Thu, 30 Oct 2025 11:51:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 17/20] sched/mmcid: Provide CID ownership mode fixup
 functions
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124516.343419392@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251029124516.343419392@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0226.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::19) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB10361:EE_
X-MS-Office365-Filtering-Correlation-Id: f37ef5dd-3654-4002-5494-08de17cc220b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjZYUVkxYjlkMTdXL3ZEVjgvMW5TcWxVN0ZGU1JqbWZqMWN5U3MwSStqY3VC?=
 =?utf-8?B?TVE4ZDB4L0g4aHZ6ajJjQ2RaU2RzcjNnaVRaWjgwS3RnTThqS2g1K0VlK3pZ?=
 =?utf-8?B?dDF6WEJDdjRNWHREK2NvSjg3WG0zUUFUWnhTeEhpMkVCTEg2eHJFbVRXcDNP?=
 =?utf-8?B?eEFNREptWnQ4bUdBS0YwczdkZmpkMittQXhNR0NRUkloRktIdGV3cTR3OXJy?=
 =?utf-8?B?bC80Qk5OdmwzU0krdWhIZ1A4VUdwYmo3QjZBTEdmWVFrZ29WdE96bXZ3ZjI1?=
 =?utf-8?B?eDdrbWlQUEI1dUtUaXNjYXdVU0FtVFVmTlhFSS9vNlZ4b3ZDMHVwL0lPZk5I?=
 =?utf-8?B?MHp3M3I5WXJUUmg3dllLbldyaVVMdHFMTGtweStnNVBKU3pYeEVMVlhwZ20y?=
 =?utf-8?B?a0hKUVRqZWhXaXZUZktoL2ZhQjlWa2s2R0tuTkhwWGNBZDgrYW5qZjhBQ3c1?=
 =?utf-8?B?Z2ZiNXNBVk5aZDNER25RUmdiSmF2T01LWFlQYmJyaG0yUXFCMHdKdTVQSW1x?=
 =?utf-8?B?M1cyQXJvclpPYzhkTHo3Mm5VNVRaWWpwcXlseUIxc3Y4VEZaQ2FMa3MyTmVr?=
 =?utf-8?B?YTAzWVRvZ1ZwVFVNU0hjLzdWUE1nK0tPQzFpRERoaytGN09pOGVFV0NiRUx4?=
 =?utf-8?B?YnNUV0JTSXpmNVp0bmlRZzRadHVJcDMwT24wak1aN1AwN0hQQ0xnVnNIRjk1?=
 =?utf-8?B?UHpRT2FHdVB5Y2RnOEJpUnZQQ1dYUldpUTRmUnRrMVNRU1NUYXJ0TDdIYjUv?=
 =?utf-8?B?SXoyRjhYbVRPb1NrVWY0OGVkWWVIZURxOE1Ka095cnUwWTNOYnB3TUZEQnJy?=
 =?utf-8?B?L1hPcWZQZzUyN3FWcVNHZTJzVU9lTi9CQkprVTNFSW5MOEZEWkNrN2I2Qi9v?=
 =?utf-8?B?ZE9ST01YVW5mSGlkNGJyVGZ2aEdLWTFKWEFmMGpYOTdOU0V2Wm9RaGxkdE4r?=
 =?utf-8?B?U21UZ0pGKzIxa3B4UFMvMGd6TDlkMEtIV1BNSFM3Q2Y0aVlnSndzU3ZRVHVK?=
 =?utf-8?B?bDhSdGI1STY0VGQxTGRsOXV2eVNKd2hoVnU3K016bFNxQ3JVTUhYUUk1Smdh?=
 =?utf-8?B?WFVSRHFjWStsYjI4OUpzTU1LOTZFVFhSRWVyTEY3cG1CN1REeUJ6MGJNRlpG?=
 =?utf-8?B?VGVCSGRJS1JXSmxEemVwbXlsSHcra29PWVJDeE5vQTBNc2NBVTl0MktyQlZ6?=
 =?utf-8?B?LzdWY1k4NE9RMUt2R1Rua2VpSVYwVlFuZVNZRXp1Nk01QmtHMkRyaFcrQ2d2?=
 =?utf-8?B?OVY3dWNxZTlGa0EydmNOVmYwUkljRTQwVTd3OVhvMVJmR1habWtjY05WeGVx?=
 =?utf-8?B?WitlWHkrUUZaa09ZbkQ2dGFaNjFHOGc2cVJtdkEwVndtVCtjWDZWUFRxdG9n?=
 =?utf-8?B?d1VZdFc4bjJHWFFINGtRUi96NFNOSzRuSmdwNzAzNW5JL2hUdEtlYlZ3T1c0?=
 =?utf-8?B?dG9TUUhoMlJzcERDQ2VUT0dYMjhIdzZsUHUvaE90a04wTjZnZkNBVzV0SzFY?=
 =?utf-8?B?bS9hRUllWERNeVhQTWM5N0UvNWtpS29GVUhEL2VqVTNzb3BBRVpQUzRibnNx?=
 =?utf-8?B?TzM0QmdMZ01SOEN1NnltWW8weGVMV1N5M0p3M1FTWC81WWhkZFI5am15RE9T?=
 =?utf-8?B?MWFYcEdLNnZEckRRbVdQSGRhamJnbFdtb2Z2OWVXck5HSUNJS0E1ZDE4TlBn?=
 =?utf-8?B?cHhhMFBnVWZmb3lVaVN4M1FJZ09xNllDVFF1cElkeEZPa08rb0VWS1BpSVNI?=
 =?utf-8?B?WDZ1UkNyVTZTdmhoUUFZMFpTUW9KQy9kbHg0dndDc2t3OGZpOXN1Y1psd2dv?=
 =?utf-8?B?Tkpmbi95blZVTWIrWHdIR3UyN2xRTEpkazBUZVRzMmdodE1UMXhRdDE2T3ZQ?=
 =?utf-8?B?SURkRGwxNk1NdktIaVhjL3RaVERrcUZBb0VMRHp2U2dhWWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmZKN2hhMnYySHJkdEtsVTZUZjloVm9pYm9KQ3E1eW9ncWNnb0JoZ256VzIv?=
 =?utf-8?B?QVhTdXlqOWhYYkdvMGhqOTU2elZzRDBTanMxNjVVNjlaNzhFMkV1R1k1SzEx?=
 =?utf-8?B?Tk5aZGRNbFhwZXRlQnJKU25CY2hGS1l1OWdoemt0RVR2bE5JeldoY29ZU1F4?=
 =?utf-8?B?eE1yMnhydmtYN3hIWWRscmc0UUFWUTg5L1ZYdU1DSCtjUmcyUzBvSnA0VFAz?=
 =?utf-8?B?bVFyd3RpenFPK2hsTXVlblpTUkVRckx4NEU5a3R5Yi96THVENVR4c29FV0RT?=
 =?utf-8?B?NWIzamlOVThQbjQ0eGs0Z0pySXc0ZmltT3RZOXE4WkhxeGt1WVNSY0NSUTlQ?=
 =?utf-8?B?Y1pCazcyRVI5bHg3UVJDNE4zci8zbkE0QUp0ZENYSm9LZlRtZS9SSys3VXhI?=
 =?utf-8?B?aUpERnpQK2FzV3BIVWZ3dHprTEVOdWNPUHVJS0xZRHhpTmI1WnRibXArazM1?=
 =?utf-8?B?aEJtM0tnWDBGOFhmckZSb2hTc0l4TWFCVmVyZklTcDNtRmUyRnVvcnNoSUdp?=
 =?utf-8?B?QzdFQzF4NmZ1NFlzNFBmaDM5Szlhd25GMGoxeDlCei9lMkhhOHIraEIwckxS?=
 =?utf-8?B?M1ZGUmFKSFZVTGlNbkhKdU51Z1U2R2Vra1RMYXNIc09TdHNBdUFRSGREODA1?=
 =?utf-8?B?T2dHNmJRQlpZdHlCY25DVDRhb05yRUxXNGZzOEpoejdvcWtBT093YmEvb1Ir?=
 =?utf-8?B?bTdNc2dYOWc4Y3JsTXNlVmFMWkNhbE1TQkhXZGNWTEpTeUZYNkF3dHRSamFu?=
 =?utf-8?B?bFZoS2xNZUI2OUpacVR3N1hkVXpuczJRamFaa283WW8reGg1SGw4b0xhdWNs?=
 =?utf-8?B?T3hDL1hqdGYvRTczZkp3Sk9vTjBUS2tqcG9FRFZuUnp6WHBrRXBwSlhkeWZZ?=
 =?utf-8?B?REFRMGhSRGNRQkxaeThMTHBsYUNkZ29Da0JTVHRwWDk1Q3VTblF0SG55OWRj?=
 =?utf-8?B?UnpuR0ZmRHRhTXJvN2hIeFBSamQzRWV4MFg2dXBmYU1YTVEwV1RtSUl1ZjBs?=
 =?utf-8?B?L3NPMVI2RFF0NW9tb09CdVdqa09Ya0NkaytaMERrVm4yZlQwS2tTQUg5Titr?=
 =?utf-8?B?aWJjWEovekpTaW8rN2lTWTNZdnQ1MVZEa0ExdnE1bU16anlqb09VbVNkclhi?=
 =?utf-8?B?MmNaQ0FhUmQ1WTA0Y0hOYmZQeXBoWGhSZ2xZWEV2LzdacGZueFFjeTZxRWhx?=
 =?utf-8?B?dnMxUW01VGw2Z0hUeTR6SmR0UXZCa0tQSTRzRFAwdlNJUzUxVHQ4S3Rqdnpa?=
 =?utf-8?B?Y0svVk45U1pqS3R1eTdBSEd0YjZZK3hCWG5QSUFoUytZd05icUxyVm1ZVHc2?=
 =?utf-8?B?amtuR1Z2N05lbk5LdHV6V0tOaHBzQW1WK3U2YWprdW5KZVJ0SnFXeThTM1dP?=
 =?utf-8?B?MEdJT2tlM0Y2dE5VeEJidUVjMVJLTzFPVHFNOUJFbGFGNmRlTVo2Y1FvMG9o?=
 =?utf-8?B?YnVXZnJUQzcwZnVVTGpTMW1KWTFNN3lmS2xNR0FCZDVOdGp2eWN1djFjWXQ0?=
 =?utf-8?B?MGdQbHBYdmtjUzBGd1MrSS8wMnBzZmpZZVNrYjlwVEczQ00vejJmMkwzSXJt?=
 =?utf-8?B?cjNTdGRqYjk4YXBMY3NMWS9RL2k2Z0xNZThVYWM2dUdXb0VJVlFkTEhPUTFD?=
 =?utf-8?B?bENMYVgvVUZ1QVZUclozc2JkMnVsVWsycGdOS2xoa2drYzZpKzV2S2k2RlJu?=
 =?utf-8?B?R1JWSkhlZ1AvOW1iVVU4MkdCdTNkZjd5d05XWmRjazNSZklXWnVSR3RrY0tK?=
 =?utf-8?B?S1R5MkJBeGhWeFZmcFhnNGYzeklnN2c1Ukh2YVFYeG9hQjNGSndvTGZrT3NI?=
 =?utf-8?B?TFhSUmJ2MGtlUEZTMXUwZUtUS014anZZRWRsWmFDZHJBVkhpRTJWdlNTeUF4?=
 =?utf-8?B?SWRTSGxHeDVqVDVhRVloK1hkNEdHM0M1QnVYdlplNTExV3FhaWlENFQrTDUx?=
 =?utf-8?B?ZC9WNzlQYXN5cHNGNEY0RitING9yM1kvc0pROUZNb0k4TFJFMmNCNG1FZlov?=
 =?utf-8?B?R1Z2VW56aDZvdHhReGNKSmlGZW5sTFZlUDZoMExHcGVpd2lsa2s0SEJKN2Vv?=
 =?utf-8?B?MUJMWTR3bDBzN2tHbUpqZHFnUk1IZUZUZlFlY29FUGlWRERCck9GL1RUNUVB?=
 =?utf-8?B?MFUrcEp6bGRBVzZ6ZmF6N2MySlBzRldZSmloWTlNMVhHM2ErR01DSlNFOWN5?=
 =?utf-8?Q?TnvD0cRMzHOJI5QrutccO28=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f37ef5dd-3654-4002-5494-08de17cc220b
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 15:51:04.6854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIKQn9o+eDgL52a8tsvudv+OEDja4Xr9kb3USIamPXCv1rA0QzuALuzwpU8jbR+dQBVEhi/kqtmj3GGTriOZHfK6nUICcTohtm2IThjFWaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB10361

On 2025-10-29 09:09, Thomas Gleixner wrote:
> 
> At the point of switching to per CPU mode the new user is not yet visible
> in the system, so the task which initiated the fork() runs the fixup
> function: mm_cid_fixup_tasks_to_cpu() walks the thread list and either
> transfers each tasks owned CID to the CPU the task runs on or drops it into
> the CID pool if a task is not on a CPU at that point in time. Tasks which
> schedule in before the task walk reaches them do the handover in
> mm_cid_schedin(). When mm_cid_fixup_tasks_to_cpus() completes it's
> guaranteed that no task related to that MM owns a CID anymore.
> 
> Switching back to task mode happens when the user count goes below the
> threshold which was recorded on the per CPU mode switch:
> 
> 	pcpu_thrs = min(opt_cids - (opt_cids / 4), nr_cpu_ids / 2);
> 

AFAIU this provides an hysteresis so we don't switch back and
forth between modes if a single thread is forked/exits repeatedly,
right ?


> did not cover yet do the handover themself.

themselves

> 
> This transition from CPU to per task ownership happens in two phases:
> 
>   1) mm:mm_cid.transit contains MM_CID_TRANSIT. This is OR'ed on the task
>      CID and denotes that the CID is only temporarily owned by the
>      task. When it schedules out the task drops the CID back into the
>      pool if this bit is set.

OK, so the mm_drop_cid() on sched out only happens due to a transition
from per-cpu back to per-task. This answers my question in the previous
patch.


> 
>   2) The initiating context walks the per CPU space and after completion
>      clears mm:mm_cid.transit. After that point the CIDs are strictly
>      task owned again.
> 
> This two phase transition is required to prevent CID space exhaustion
> during the transition as a direct transfer of ownership would fail if
> two tasks are scheduled in on the same CPU before the fixup freed per
> CPU CIDs.

Clever. :-)


> + * Switching to per CPU mode happens when the user count becomes greater
> + * than the maximum number of CIDs, which is calculated by:
> + *
> + *	opt_cids = min(mm_cid::nr_cpus_allowed, mm_cid::users);
> + *	max_cids = min(1.25 * opt_cids, num_possible_cpus());
[...]
> + * Switching back to task mode happens when the user count goes below the
> + * threshold which was recorded on the per CPU mode switch:
> + *
> + *	pcpu_thrs = min(opt_cids - (opt_cids / 4), num_possible_cpus() / 2);

I notice that mm_update_cpus_allowed() calls __mm_update_max_cids() 
before updating the pcpu_thrs threshold.

sched_mm_cid_{add,remove}_user() only invoke mm_update_max_cids(mm)
without updating pcpu_thrs first.

Are those done on purpose ?

Thanks,

Mathieu



-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

