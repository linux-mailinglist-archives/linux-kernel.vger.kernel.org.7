Return-Path: <linux-kernel+bounces-813817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C959CB54B0C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A874F1881AC3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3563E3009F4;
	Fri, 12 Sep 2025 11:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D4MfqE5T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tgf0P8MI"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8137B17A5BE;
	Fri, 12 Sep 2025 11:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757676883; cv=fail; b=lR1wNkA5wjBk2WBUFFK3FeaVM5n7o9bm102sp6cm2eJEUdTz/vEGI2zrrth7N0futKqkQCPxuaYWg1ThScMUmJ5k7NHzN76AWBTkDySPwEVxiDllGIfxfJKzuJNUoLC4rOLapccnmysab5vU66b8T8kzwly2lnWsgnjdRBB4/tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757676883; c=relaxed/simple;
	bh=ZGxGoM+/xXN/cxSs/B92MMQqwbpHNdGXqcxXhYSJaoY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eMOG22+pu5Wj5sLRiRbZsxw1HP38s5YKyOoM7W3QCkYfbPIY3RIzOJQpskUuEvsKd2+cZGMvBANaNn2s+qBkg6VLvN3kxGwCZgpgtnFsII3Y6cSy+iQRhzncQ93WU+VTKNY4Nm2Jue2KwCHo5rb/0o2J+jWx4EJeyQFhtk7YXhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D4MfqE5T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tgf0P8MI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1twTS022576;
	Fri, 12 Sep 2025 11:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZGxGoM+/xXN/cxSs/B92MMQqwbpHNdGXqcxXhYSJaoY=; b=
	D4MfqE5T5HFvB2bJv2s6roHLa4NXtNbJPyVWe2EUHSqK5fDyZLLQZL2xPVzd55Am
	VIFWrzkSx4TQPNXXPaZyfqPltIzaRZSozCC6KHavpGnhWcM//PnJbHAlHRTVL+3I
	fXqi4qczEFrFQVRAhoG33Tv+WudbEWZGGUw7ZGC/yfu6tkV+FSaryVU5JfXamuyk
	1Mb9Eqezjv0ZdcN7nzZMAjxsJfzFOTSdEfVlt013Ah39uV0rdkqc5znpMWehkxLR
	KH5rvSKIG+xI+kMfTp2fUbP3bpWS0HyhRYUheFb7TGXpZRk7FDHBuUsO9XtHpXWm
	T/x2bIMztupGAvInEyicSw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921peg2gq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 11:34:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9nsba025911;
	Fri, 12 Sep 2025 11:34:24 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010054.outbound.protection.outlook.com [52.101.193.54])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bddsrd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 11:34:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ayicFrLg/yw4iYSkLwtLy7LXAuPMhNRR+Ig861MpUlknQaCNd9Pn0jXxJ9XIatPp/BF2tIubu+uSuvVQLXcMsi50tkptYjFccRjE284x/H+v8WNE9VTDyKGScW/B5kpkuM77MNBgZ1PI2GVj8XMvu4kVws+XGLPRkc3mx9pFx5nigFGDpiDYMd18ivDwMN5mRA01TfZSV2j0CuDi5+NilWSxPgy7jyHgP2gIQ4CKJcD5Qh8/6zxfM22ggmMsVqYzkdzj38xiNWznoqWGI66X3khq2uucpB1cSzQDCEKkA8fZ5b2VAMkHZJpQAqkOPD7qOcolHJqpnjAoO7qmbDpw5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGxGoM+/xXN/cxSs/B92MMQqwbpHNdGXqcxXhYSJaoY=;
 b=m/UGf0UDByYXRLGNi+ouIQMeLGMsQDuGq3Xd72A08RRBlrCH4iXYjM0DH0IsUSVzBcCNowFTy1OwO1EGrqLv+mDyBbbpZasl1l4KzD7yWFGgCIoZo6qqnwgcqVEZsme3c3zPNFysmscsg6PTE1+AS2Lp3R+xk2eb+paiodluFoVi/ABVzPUdCYzPMcVLTaTpPcU5YYIj/QlJLH5Q21hCpQtCcKxey4v89HBfrmErzuOArse1yxWvrcMo1EIMB7Is5rkF7pEZ4LmPzL/3WIHHZmcce6z/PEmkMaIaRldsHxCD0Vjfrcy7rHW/T0kTv1BVS720rmq5UZEr97dUlgg3mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGxGoM+/xXN/cxSs/B92MMQqwbpHNdGXqcxXhYSJaoY=;
 b=tgf0P8MIArAFOyHgennD+A0R931V7G3vaX2k04AQypLOeR8EVpyspKMg0e7p6wf6/UGMEWIh8QS8GYOX9eHlLZw/qwKPEM0K8ufP7mQIti/+EMT9BoAY7sQ5Doh20YGrOsBSal386NXTHbkc/zTXL2rwNUXbmFAALyK+AMXmvMs=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SA2PR10MB4651.namprd10.prod.outlook.com (2603:10b6:806:11e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 11:34:21 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%4]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 11:34:20 +0000
Message-ID: <3cc0d2bb-d7f7-4e8d-96d5-35863da244b0@oracle.com>
Date: Fri, 12 Sep 2025 13:34:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/19] tools/docs: sphinx-build-wrapper: add a wrapper
 for sphinx-build
To: Jani Nikula <jani.nikula@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>, Alice Ryhl <aliceryhl@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
 <e019f951190a732f9ac0b21bcda7e49af3bd5cbd.1756969623.git.mchehab+huawei@kernel.org>
 <e13837a0ac46dffe39c600d11fdf33f538bdc9c3@intel.com>
 <20250910145926.453f5441@foz.lan>
 <45888ca6c88071c754784495b4ef69460ea67b4f@intel.com>
 <fuv4p45tvjfdvwu2625s2l2kvcw64p4ohherlwyum3vmogmrfz@yb47nt66xgm6>
 <87zfb1p0r3.fsf@trenco.lwn.net>
 <a1333c717bb5bcea7f7c616cbf8604fa259c3158@intel.com>
 <87ldmkojo5.fsf@trenco.lwn.net> <20250912100645.15c79351@foz.lan>
 <1e5ea0314833519fdfda3a75c79fd046d41c086d@intel.com>
Content-Language: en-US
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <1e5ea0314833519fdfda3a75c79fd046d41c086d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0396.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:399::12) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|SA2PR10MB4651:EE_
X-MS-Office365-Filtering-Correlation-Id: 49c798f8-ee5c-41d8-be33-08ddf1f050ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3puRXZ3SWNzN1JJak9rV1RrdE1seURuMnR2am1CMGNPdFp6bjRLckhEM1Fq?=
 =?utf-8?B?KzA1Vk0xMm1yemRkeE1xbEMwRG5sUXNNTXBHM3dEbEhhZForRVRnbHhqb09H?=
 =?utf-8?B?eklBd3dWRmxub25VV3hCTUFxKzVGSTJxU0p3SUZQV01EYnVNbkd5UXZZaWxQ?=
 =?utf-8?B?THJmOFQ5TmFjY0d4Qm4wSWJXTEJxeVpmUmozK2s5cUsrRzBjS2tNc2F5eFJs?=
 =?utf-8?B?dzBXY3BqTG4rUkdPVW5SbjV1UGJ5VUhQbE01c3pSY1FuNzd4M3MydUR5TkJQ?=
 =?utf-8?B?cExwNUFuZlJ1ZEIzTVZYWnljVkJ5ZzdlMFFubFI0b3RDZ1hZYldOR0FkbG45?=
 =?utf-8?B?QmlST1l5R1VIeDA3KzVtU04wTXoyTTlTUDlaZjFHd1c3WmFsRTBXeUFDamtD?=
 =?utf-8?B?b1M2M0NJQ2hES3dkM2RoNUFUb25hWFVnREs0bmpwdDVwTmZYSkJEd0laNWtD?=
 =?utf-8?B?WkVWYW5PV1RFZ3d6azh1bmJkdCtsYkdsMnMyTmc1ZnBhWk8xRVhJK3hraDhs?=
 =?utf-8?B?dFdJSEJBT1Y3M3hXQ1FTSDhwRjVQMFR3Y0xKWHRBQXJIR0FYVlBBVmpiVUg3?=
 =?utf-8?B?ZGJoMXN1Nno1bzFIa0xrUm9PRjUrS2paWDZWa3ZlNlNXa0xDb0pLUVpPOXl1?=
 =?utf-8?B?ZzVxZ1lyQ29td2QwRWt2WVBKc1VJb3VSbWlHcHNqamFMeGdXV1lIdGEwMDEr?=
 =?utf-8?B?U25JcHlTc1lrazRHWmxnN0JWMmRQMVplVmpYUGErZzFTVm9GdHgrbnNvazd1?=
 =?utf-8?B?aS9ETUx3R0p0MDFhNExyakMyajNyL0NlRFN0Qlk0UGNmQlNCT3dVOHpITC8z?=
 =?utf-8?B?Ri9XUXpOSVVHcXlLRTNyWGNQM0tRNVAzVXMyRlorejhBOXdtQ1IwYkJaRjFo?=
 =?utf-8?B?M0dSWTVyNmdzdnZTRzBMak5ib1dIWXNrL1ZaWmU3dzNXZ1cwSEVQNlpWMHo5?=
 =?utf-8?B?eFQvdTNVdVIrWlVlK3VZUkh1dUpXWGRzSm5WOSs5c0loU0hBWG1TYmM4K0Yv?=
 =?utf-8?B?eXltZnp6RzJva1JYa2gzVmZmQ0RQQ0YxSjNWYnNJcjcyZXo1ZGRpYU41eGFk?=
 =?utf-8?B?RURQd1ZWVlJ2S3gxc1BDSTYrOWJKK2hFTy9sMG9Da2pValo0cDFtaXMwZkI4?=
 =?utf-8?B?eHRrM2g1czFQWVo1UkFWTWRUcGtlTU1oZzgyeSs3c3BubDArT1JLTXFVVUFO?=
 =?utf-8?B?Nkc3R25qRy9QVEl6S0hlUE1SejhSQU9zM20xQ09kZmxxUmVIMlF2VUdjMlVy?=
 =?utf-8?B?ZlFYdW5zbWt0NzduSTZZUUhiRnBpbE1iWEtXWWNUQ29XdGpjenJ0RGorMGxC?=
 =?utf-8?B?WlFIMWlzMEFHNkltK2ZGd0ZEZFMzamEyQklYZjRCOHBGZnFtY0lrc0lsb1VU?=
 =?utf-8?B?Ym41MjlrUDIySmNLMWEyOXhsVDcxMENXZ21qT1A4bXdUU3VPdnVTaUdqNzI0?=
 =?utf-8?B?ZUdFWGZ4cGg2YzhrZmNWUGpXRGQyWThzb3paalNpTzJySnMyYSsrck1FTzZz?=
 =?utf-8?B?bTl0MEF3bkdwY0RuVTZlVnBKc1NYSlR2aml5a2dVK3gwZVpPZmxjZ3M2OTRO?=
 =?utf-8?B?cHJrcVVEREF0ajBlNWRFamlsQ0ZrYjEycmZaVXZ5dXd5SWdzNS9ndE5uSzh2?=
 =?utf-8?B?RksrYnp0MDVBRGg0bDM5NFVUd2xsT0JNKzBVZmkzNXVCVlVlckhJL1JOVHEx?=
 =?utf-8?B?M3A5YmZ0QWRROFZwR3Fkenl5OTlUVEFkbVpYZFB3UVhIclUrZGFWblFqZkhM?=
 =?utf-8?B?eXAzSm1xaHB5VTBQSmZXODNuZ213QUNrTXFOV0wxNXd2SjIzTmVQWnR0Z1B5?=
 =?utf-8?B?SGdXbUFaeDRndytuOENXMDRJUUozV2MzQ05JS091dHB3VURxUXJLYTBkMGQ3?=
 =?utf-8?B?VHFaWnVtdnFZVXNYZU5CRzhOVG5Jd1lZM1ZkWmJQRlpKYW5HY0ZSaFNpclJL?=
 =?utf-8?Q?WTQr+i020Vg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEpRa1ErUFVhdEJUZ29WMk9CeUc0TTJ6U2x4R2lySjJJamtIMCtMUkFnVHRZ?=
 =?utf-8?B?aUF4azRSck5xZzZubzUzaXZ2TTNQeUFCUnJJN3MrZkkxZWlQVzBlOFdlT050?=
 =?utf-8?B?M2UxVTNTcy9TMzdQZHo4RVNMSWhkSUZDeThQVzNjbWxCTEZoZno0MG94bklo?=
 =?utf-8?B?dzc0eTBEcFE4QXJOd3puK0ZrSHNLN1NyS0RLekRrYk0wbitnVk9DSnl2aFR4?=
 =?utf-8?B?TGNHRzFyMVphMFFGM2d2aGpWZStVV3pIWWgxS0lJL1FGZ1k2SHg0cnhDR3o5?=
 =?utf-8?B?dTlFSTArZzlxYmozK1ZPMnFpY2NlaGdRdnlZaGZrczlRYVZwMTgzVFlqWkdC?=
 =?utf-8?B?R1d3NXRnc1J2YlFoeGJHVi95eG9ERlN6b3VvTnpsR2swbUdLWUNxWldWTDhU?=
 =?utf-8?B?U3VmMk9SaENEQUZEUFB2ZkJ3QUxOOHMySDZRbngzMk5zSXNTV1dnZHhEQkwv?=
 =?utf-8?B?d3R1ZnFqYXdiZ3VDRTlHaVYvOEgxdUVzak9BWUl5T2RReVpwWU84Z2xQdU9I?=
 =?utf-8?B?U3BOMTlwRG0yU1lkZ1drcjUzVkU4WTBHditEaTlDM2hnYlgxb2cvT1IrdDNa?=
 =?utf-8?B?UnhNTGJSM2w2MTUyZk5pT1NZNnFOWjBTRkFKcWZYN0VzZVlTTFVWOEUxNlFW?=
 =?utf-8?B?VDNVcFdMamxFVDZBZ2tKdFlpbUNRVHd2dVI2aWxHZUxqb1lrc3MwNDhsYnNH?=
 =?utf-8?B?cUw1QjVKN3RBeUF2TG5Ka2N3cTlqVGtEckxuak9pNWRUSGhtNzJVZXZOdFdF?=
 =?utf-8?B?MEMvMmRIMUkrbFJoV1Z2UXVBcExxcWVoMlRrdkRnTjg5cTJlM0x1V0lKQ0tE?=
 =?utf-8?B?clFLTlRXSlNGZGNhRm5TM0JvNU15ekw3a2VPb1FPem5KY05DU0tTWi9ROUZp?=
 =?utf-8?B?RHcrOU1iK3AzM2F6aVpoa09LRkUvdzAvNlpGRkdneXBEQ1FHSmd3a1poZFRZ?=
 =?utf-8?B?eWlvM2JhaGV1a1dtbG5kUlVGVVFmdmdnaGNmOTY1bm55MUJDZWsxZnFOaG5X?=
 =?utf-8?B?RHEzRWRTVDQ1bitXUlgxV0xxZzVlNTQ0WlcvOVRPWVRUby9UcU1YaDJMTEZG?=
 =?utf-8?B?c1REUWRQdTNoRXRmWVZWTm5CRHpjUjZ3SHZTUXJlVW4rUkVJV2NvRE94Q1lw?=
 =?utf-8?B?OURhWUcrUitLZWc1eXpBZXNUZ3pnWTNaSlJKU3hXWmY4aG5jdms2SDNJTGc3?=
 =?utf-8?B?UWh6R0t6b1hiS3l2RlgrcTFVSElNVHR6b3Nxd29NRkdnclFjc2hhWTZEQUdE?=
 =?utf-8?B?VWE4N0FDSjVhR1gyazh1d0k5blZIK1o0cmwvTC9INEwwdjFqL3JCRWw5MEE0?=
 =?utf-8?B?QW45SmRmOWk1ZzczTzl2TmV4am56VTUxdDE5d3dkT2ZQeU8ySGVoT2x3ZVIr?=
 =?utf-8?B?NjYxL0J1TXF5RWswd1phTFlOSTFCd0pyV1ZOQjFNVFRRV3pjUFFWUjVUVmJ0?=
 =?utf-8?B?WWZnSC8xc0xHYldaU2R0RmJveHBLTk1ld3R5aVpqRmpoTlcrYW84ZE9IeEFt?=
 =?utf-8?B?WVh2TEVPUmFNdVpyV1NRRlozRWJIRmJ6ZlhSREQwZ2NDeldoRFMwMDA1ZklC?=
 =?utf-8?B?VUtmUFhTVkRiOVJMRXhwMEVSc0VaU3JaZFBGUThFS2k5alZpcHpseE5Bc2lD?=
 =?utf-8?B?ZTV0THF6TmZHcHV6NVBGY092cjV5ajA4SkN4RWRKekliZEtqYWVTRjdZUjJM?=
 =?utf-8?B?c0VTUUlUTTVSMGdSamVuOE1HUHV5YmRhc2FDVGxwc2VXWDNQZ1kzS2xWQzNw?=
 =?utf-8?B?MUlFbCtQQ2pJZWFTMHNuelQ4Z0Y2TWpmTXZDVGpUbXBpblhuWU1aT1A1Y1k3?=
 =?utf-8?B?QnkzazdQT1ZxRkZXdDRVVStqSnFJVEpMcytScjBmNFc0STBrdWxURDRsNHgw?=
 =?utf-8?B?MjlCSXZBL2JPVC9naXZzUUpaNFB3bFNKdHljOFAzV0VVWjJmT3FDNWtvcFJW?=
 =?utf-8?B?TzFGVmlxZUZVRnNsTk5hTXB4Z0pBLzhmK1d0cC9wZWNYTUovL05XaUx3VEJt?=
 =?utf-8?B?YkZPTU11bmhGSFVVTW1GMXFFNW43ckRCMWhwMkY2bisyYUJ6SElDT0pTUUxG?=
 =?utf-8?B?OGxLd2JIeHZKc3VVZkVURzJuemN2OHpmaTZxR1IycmliVXNxVFdUVUFYV1hm?=
 =?utf-8?B?N0NUUVhLVllUZXo2ZVJ3enhIS1lRV2U5bE83MVhvc29yVlpNU3VnNlIxdjdP?=
 =?utf-8?B?WEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/NKuuX2l78i3CYpgY5IvdfYQ3bNT0qQLOJdQFoy42xmg/8BNHzGGWOAni6j7QYtMwPRYVoBApo2vTrWhbglDSFcjI5J/U3xuYUxfasu0apwxDl+fX0Uw3fPvOGC/INGBhmzM8rseYdWV9STqG6OrmYycZDqLI1ZPg0bNZtv4wGw0oKeZPG8PfQkO46sZcLOTen26+78RXznEEvL6sV255iIbj8hOB4FfRbXWVD+R5drb9Nv9kEgYkp6EQcVvMkSeGDPW36x9hgyphb2Igrb+3dyqUHrzYyf8GCfJUM+ipMhCjDxChQcy4cgcF4mRjSvwoe9ESXFIOLByaNSVb7mF6ejRAJnKL4zkj+iBb33VGyn2Cw/eZtktwRM2Grap+QlL6ulF20JEZQPIdr20/rHVxfsSk51lJz7p0Inhddmqt0sFA3pmlEk2wu7VbBpCWGDV6QWOt+6H9X0UfLhvfZr57iYa7mrPHoa6dvvGAUzZPaHz81C4rbRqMdhT11gsLg7w+jMSmh+hvAOmYgqNVHbFogfx/WTqOty+SiB0m6h6WV1XNbu1wfp9Y5HDl6mQElBRTJgxHvPbfQHrRHZ9UFLVF7ciPHxZ1CROEDlqKdLvOJ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c798f8-ee5c-41d8-be33-08ddf1f050ae
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 11:34:20.7650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMoudng9fLUf6akoXJppiJ5zB9BW2BIX8ctIkLjzf8sl40WVoK0d5RrVcNzrtcNC/2RA5XA7VTOW36kbnXwFiRp1hSgo25I52Dxb4b6uJ/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4651
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=820
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120109
X-Proofpoint-GUID: rXlCSfcTVAdE1qV8zeDef3-ln6aKJStz
X-Proofpoint-ORIG-GUID: rXlCSfcTVAdE1qV8zeDef3-ln6aKJStz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MiBTYWx0ZWRfX9j/Q/338eJiu
 v88isskYCNU0p5vYkBsg4gIrEFj2t/VU5R7xyVQcfGcNE5/Lda5Z2lEikil6/M9Tp1E2eR0zFQy
 YzhwNu68Yc94Xkif5Ht8m30fvVPEG7lavCF32lX0L3qAhwdOcv/tmBbeAo+aiSlayzSDz+YWWEr
 0BNCiCBFLnZUAZlRas3xXzVOJ9P0r266t5B1JOsyIu9gI6G9HaIAGb2rxD0slocKyT1h6PPhFH5
 +wAcGYvjXB0pdZVD67UlE3ABB6n6UInuD3fClvOz1p3jiwQlVg6UobdC6x0v3WjGF9j+iXz2GeM
 W7HEXkE3/0x7KB8/+kkTG+78v+e51bOX5UWnTlw9nzZzbooGaC1bDNDdqi6v0DhU7/CwzUPhrZs
 OgMJad03kqv79EGs6X7OQcjtZ+UkSg==
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68c40542 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=D5z5kySsHXYBfaX9H7sA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 cc=ntf awl=host:13614

On 12/09/2025 12:16, Jani Nikula wrote:
>> Here, any time increase is problematic, and SPHINXDIRS play an important
>> hole by allowing them to build only the touched documents.
> This is actually problematic, because the SPHINXDIRS partial builds will
> give you warnings for unresolved references that are just fine if the
> entire documentation gets built.

I admit I don't have a full overview of all the problems that are being
solved here (in existing and proposed code), but how hard would it be to
convert the whole SPHINXDIRS thing into a Sphinx plugin that runs early
and discards documents outside of what the user wants to build? By
"discards" I mean in some useful way that reduces runtime compared to a
full build while retaining some benefits of a full build (reference
checking)?


Vegard

