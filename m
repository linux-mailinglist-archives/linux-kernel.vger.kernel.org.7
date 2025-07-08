Return-Path: <linux-kernel+bounces-721069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3D9AFC45C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A94D427008
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C613629ACC8;
	Tue,  8 Jul 2025 07:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RAhdVOGi"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71105298258
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 07:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960448; cv=fail; b=Swt0O4FO8FHQvzym8gld/TKrlE6ycZKnTKQo5j4ebNWQN/+lk6cmtREitB1r+B7sZM+tVVu0cRqJZSzPxSgUq38CbXpLJDnt6LM9K5RxZtpHPuinjZthJPhryWNqdcO/N7zIJhEWU3Aclgu6ixzsvLxo1hO5a+2bQ7NwJoJzIJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960448; c=relaxed/simple;
	bh=beNbAmE3lch/eXFL0Sg5yb1QUcN+lIOCUalEmLdyQw4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ssBsPvYiJInAQqc6Kg1qShKViExyJn9mapC4vKDiA5bf8B3qMEHK5hoQVuRBy/jxtAWUUKSHdel3A2aHqxyqVF9lW21vkqLztpxyD0PS0GOovHYloiLbpiGTvikx1gvrcveRs+xG2DeS5sozFvg97Dz8W0U3JYf+fGrJT6ouCsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RAhdVOGi; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVUB/nyeB5NOkbHWuVM40WdvmFnyN7q1Q7vbNiNxjgELH39lSXQPDu8yx++RR3Ykk9Xb1lRT3wLUvh36UDMztLZdKThvAVxbUQGtJcJfOdLrhZP4wt72XNNq9r0ZmmCzTnX8PRky+awcakSTEkAHozgaqAe5Gk5coFJPFv3I2RI0Cr5yHs2G3dHqCWGmlhwfLdvmu4Qx9qBg2/4IDHnCAaCUR+599dzaVxfDWSIOQ5TZHSqa4ZprmUSdOl/Pc1jRckoUMqHkSp2gu+1zQvFTCHs74/6DbCjfre2w/sKSWqoXYhPvtWeyFi7vxSvYVpJEak5afypc/B7HHkrMPLfgcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kc0pfo/Tejw/mC8AkkIkEW9WHmrZQp2j+GH0G+VEUxQ=;
 b=L+o2XRfVc2V0RTKUTRHAxOjNkrY1USae3zkueHeP5OnZBex9tVuVyNAo7+rdYd7v5/MP2879T2+QLCCm2WpuD14rbxJ/XqkpP09usAyyDYYX8I0AZJzzwVLeX3Fj0SvCkJX6EwvI4vOJJO8wjpIX4G0bKlex3sKE9V2mEZ6yI1GiySZiO0TXNco1+5bjsLkiSGm5GIkVhODw7x7XlGZiR6trz8EJCfHB+DRhl/oxVf3bg+tgkmjNPJD4hp4vx+1j2DgfMcVpC00/bTtMGOpGP7KcoPfANMxelatHWc36dEchqpABO1ktZP0EzvdERZBWvobAuM0BuXvPM8Gf5srsmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kc0pfo/Tejw/mC8AkkIkEW9WHmrZQp2j+GH0G+VEUxQ=;
 b=RAhdVOGiAPyyFArqUi4BWcBuP74yB5IifgQq2ogscbMs9LjDuJJq7gOf6SGEU1yYixXBvTEsQ7bKoq0lcDh1bjI6j/vaiOF9h1sfuas+jlUw9ddJT+bpTcaE+SshgzdQDXjStK59OM0AL1QM0WFJR3WsxUMuNwdDMO2qlfn4lI7tH+0ydRiYRobr1yjGd6NSivM/wT9wwf4SE17XVz0gOA6MQH40UDoeQQqQybDsAWDTZfVWBuooOHaDsh7YngV2yv9oCJ5OhguJKONb89c0+yaRmoZ0DL/vmmb2drF74Wqj4kAQhjW7LWZ0GL/1THOxlHD3i7TkwYTMWZVP1+1Tmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by PH0PR12MB5632.namprd12.prod.outlook.com (2603:10b6:510:14c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Tue, 8 Jul
 2025 07:40:43 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%4]) with mapi id 15.20.8901.021; Tue, 8 Jul 2025
 07:40:43 +0000
Message-ID: <a3a6afe9-5188-42a8-937e-54aa495b380a@nvidia.com>
Date: Tue, 8 Jul 2025 17:40:32 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [v1 resend 03/12] mm/thp: zone_device awareness in THP handling
 code
To: Alistair Popple <apopple@nvidia.com>
Cc: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Shuah Khan <shuah@kernel.org>,
 David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>,
 Donet Tom <donettom@linux.ibm.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <20250703233511.2028395-4-balbirs@nvidia.com>
 <4c274ac4-17d7-4d37-aeff-9517731d0c9c@redhat.com>
 <5ba8cf21-60ca-465e-a524-5dd43b9bbc97@nvidia.com>
 <xbsn2gqp54bmb5qtxp5hr3fmtnm4elxw4wmnezwq6qs4ewdvsz@e46t5tcnpms2>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <xbsn2gqp54bmb5qtxp5hr3fmtnm4elxw4wmnezwq6qs4ewdvsz@e46t5tcnpms2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0016.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::29) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|PH0PR12MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: 555e4af9-4f0e-4abd-659a-08ddbdf2be68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTlYRGJlbzRCUVdvdGoxYnhwdHpZNmlSWmY0WlY3ZEZLMFZnUkZrbEFqSWhw?=
 =?utf-8?B?MUhEQkM5dEl3ZTNhSmxubVVEaDQ0bStxQ0U4VWhLcmY2ZUpkU1JoZ25KNVR5?=
 =?utf-8?B?VVYySkNzaUM3bEhiRWgySVBSZzFBMGV6Z3ZNbVIvZ2lyY2VsSytXZUZHYi9N?=
 =?utf-8?B?WDR4SFFoWkgveHRmeW5ERkJGc1F6b0tacWkweGZjUDJFK1MxS3huNSttZmFS?=
 =?utf-8?B?Q1QrTHdTSFdURUxVbTlXc3ovYUk0OURFQktwZ1FJSHlFS2l0UmRJMXlaK3Fr?=
 =?utf-8?B?WjdJSS9LNFVCMFFzMFJ3OTc1U0czNWRGaHFJYzhPb1QrcVNwY0xnNTkrRzRZ?=
 =?utf-8?B?dDlPN2FaelEyYnY1enJtdUlXa09nYnM2TDVKRjhpSVhsQ29EL1FQTFJtbHF0?=
 =?utf-8?B?WVlxMFRaaUllNzNEblk2TGpGSHlwWlA3NXpYcTBDa0JISjZHNXlJVFJLSDFu?=
 =?utf-8?B?ek5aZ2w4OG1zdDRpVVMrMkMxS2RYdUxGQ2VJSVdVQUdvOGVWTGtTV2wzcXRW?=
 =?utf-8?B?K0FKTkpTUjI4M2cwWlFZVG83UEpLOUw1bURrOTJ1WHZmMFlmUzdPeXhIWlFB?=
 =?utf-8?B?SXRvaC9YNHFtNVZVWW9Zcmh3Q09PUlhoSFhqTjQ1REFaVkFZUmovTmdCYUsv?=
 =?utf-8?B?ZXpxN3h4TURJOHUrcHRQYVZ3b01kRTZqZEljTVcxc2JVMUg5RWRjR1Z0ZUk3?=
 =?utf-8?B?NUJzMlFJaCs0cUdLKzArY2FiSHhhNU0zZlRSb0U3Zy9xZ1Izcy9Ublg0eTgv?=
 =?utf-8?B?dlN6L2U1dDQ1c3ZzNXlBWnVib2RKcjRuRCt4VUFaREZzWm15VG1zcUhGSzEx?=
 =?utf-8?B?Nk4vOGpLZUNNRk90K0xQUDZCVE1sSzgzVkYyMmVMNCtoMys0VTZuWnVoZEV6?=
 =?utf-8?B?VjRrTVEycTNBUlNtRVRnWm1KS0RITVJyNno2ZVdTRFdUeHpGUTU0WG5oa2VG?=
 =?utf-8?B?eXZVaHluS3pnMVU3b0U3SDdpTW5FdFQrWDhaNTJUY25TMU9TU2R4ZFJ4bVNt?=
 =?utf-8?B?UkRyNVhVR1haRW15TjgxWk0ySUdqak93OS84eDFjbjFjODQ0SGNmdHBwZ01S?=
 =?utf-8?B?RTNmR2hUcjVlWGQrTDFuaElnT080UXY2ZWpjNjlWbUEvVkQwRHArMU5DYlE3?=
 =?utf-8?B?bWxKUEwvNktvbnp2aXEyQ3pnVXpXcU12YTIvM2Z1QUYrZm55bDE4VFJuQVNu?=
 =?utf-8?B?WVRjMzM2eTZCVHRBVmJUV3lDakxwTDVWQjN2SHdxK2dSbTdFdWRLOStxZk0z?=
 =?utf-8?B?VXZFTVhrY2w0MXNhREtDZUFRamNjUlFtSGFodkJzZ2ZnRTk5YnI3V2gyVHlC?=
 =?utf-8?B?TWVxUEY3TmYxQWZlYysvMUZCZmN2cG1URlcwNnZwWnN1T0cwYXloZTEwSExD?=
 =?utf-8?B?ekh5alliQlMyM0h1M2VSNXhob3pOUnNDYWc4Q2VYL3lmNGdwRE1GTDVaTTFY?=
 =?utf-8?B?QzR2aWhmYlpIY2JUZWZDSzRBSlBqZFl5N1U5cnhXNlJwUDlWaGVTdUJTeUNs?=
 =?utf-8?B?V3NhbURYT2tQTTltWXFuZnY3VldQblFOR2lZYk1OdWVsa3RHQ3lzQnJuWUI5?=
 =?utf-8?B?QlY3V1Z3dlFVeVFvdExyWjdlb3luTHdHT0IraEZ5ZFk0MWk4bDZNOS8rRVlk?=
 =?utf-8?B?dUJzQVJXMkhUWkY1dUNXOUtQbVpzblRaVVFaUHIwUXhoNmtaSnBTZkdrRWs1?=
 =?utf-8?B?QjFUOTJSMDBJQ215eXF3U3lycldtZE40aGRuY1BGMTZxdGxZSmk0YjFoTnpt?=
 =?utf-8?B?NEcvN1E1bHlIdkRWcmE0RnlleTlsUERVdzZqSjhFNnpWTkk4aEFhanp6SHRL?=
 =?utf-8?B?VFRtNUZDSHNVUVJlUFh2UmFGUVpaVU1jSm54dTZyVmtpNm9GZXEyUmtJa0Y1?=
 =?utf-8?B?ekZ4a1Z5WUxZaS9aNDg4cHRZVHJ0WE9yUU9ReTRYVk5ROFhweklRUFVzVGRn?=
 =?utf-8?Q?Gucse07Pnmo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDVhMHp4cWY4Q2dmdWI4QUt2dkV3Szl5ZXVIQnc5cDhldFFiQjloRWsrMmpD?=
 =?utf-8?B?N0FXYWR4UzN0YWpoWW5sWFg5NFNPV1BUcnoyb1FxNjdOWVpkNnd1b3dGTVF2?=
 =?utf-8?B?UTFuWFhDVTNxakhwQW1CNWlZLzlRVnlqMkpIZWozVzFBSVlnOThzRmt2ajhT?=
 =?utf-8?B?TnIvWm1sR0lhRWFUS3JTdzVUM3FWWnJnMWZYNzFvNkVHY2thTXlSeGw0VUk1?=
 =?utf-8?B?VDlIRlhvM0hOLzBkcmIrN0R3aEZmQlk1YUZvN1lCd0txUXprakozTUU2UW5J?=
 =?utf-8?B?V3NqUitWUjZRem8wa09ZcjBaeG44c090ZmZ1SUFrWDdES3A4OU1DKzZ2STdm?=
 =?utf-8?B?TVUvdUZadmZ3ZnozR3BadUhiemowNkl0MlgwOTJlVzlwaE52Zk90MVJSTHM1?=
 =?utf-8?B?K3doL0FaMTkzWW40OEJDSDRrRnZWaEljbnF2WmtMYlFKU2RXUm1ub2VqdEQx?=
 =?utf-8?B?M3Q5aHU0ZjF0NmNmNlpjcjNWdHpCT1llQW14OC9CZk5CeGNkcjRGWDhlN0p3?=
 =?utf-8?B?cEE1Z3RBN1dJRFpXY3JaRzUvZmxRcVdVNG8vcVVZT04rQzJnb3JKM0MxUzNE?=
 =?utf-8?B?RDVqME5TSFJMWmR5eFlkV2lNTEFXbkRLT0xvNDFEUEN1THFjVjNZcmd4RTE1?=
 =?utf-8?B?TTc4QjA3cnMwRkw5YTNVM3dvRlJWZWZOR3RnVTJmTnVTRURScHVvV2VVVElv?=
 =?utf-8?B?TlB2ZklwRExiVi84Zk5KSTBsY2ZHNDZZUGduN0d1UllJTTh0cVVDTlIwWC9s?=
 =?utf-8?B?RVFSblQrSHFZQUFjT0tNZnptK3BVRXNITG16L2hhcnFqdnh5di9QakFjUFJK?=
 =?utf-8?B?TWdTZFI2T3YyVjVMay9uWEdESEpIcm83WE14ZEdnN0F3U3JOTjJrc1pqd3E3?=
 =?utf-8?B?dDhnR3JIc1IwMXJhOG5JZjluV3FmZFIrako1MFZwSzM5WlRtQ0NQbzB6bytC?=
 =?utf-8?B?eWJUS3hGRERPS2NjSS9TeTAxN013dlJWYVJPRmxPQzIzd3NzWE93b25JUnNJ?=
 =?utf-8?B?WXdOeTJJUDZ3TXA1NmhmeStXb3NKcVBQUkdjNFpGTzM2QXpWZGNYVkZvY3B4?=
 =?utf-8?B?V09pcFlYQjJHMmdWY2NEbVJGWmVPbXh4Q21KdENha3NVeFU3STlPd1ZXSWJ1?=
 =?utf-8?B?UGF4WWhJakk5MjgwWlNWQ0k4YzdJMUJXVVRrWjVhRW5vYWJpTDlKR3JtZ0FJ?=
 =?utf-8?B?VFJINTNvRGdFUVFSbTFuU0g0M28rd3hVRzd5SFpHemJkeWZzY3M0a3NLSExX?=
 =?utf-8?B?R1B2NTRGTVRlU3RsTFZnR2E3MkJMNnRBTVdXeHJjSVBnMks5SERMUWRoR3lP?=
 =?utf-8?B?L3dKSXNYTHdVaTMwV0ZVQXFkcGNLeGVaVUVLekJKcWMvMHJtalVsRnFUOXlw?=
 =?utf-8?B?YVNXQisvN2dWUXR3V2RvaTdPSzNFc1dLbVRwZFBrKzB0cFRMSlVKazVudEtp?=
 =?utf-8?B?NWNQVm1KRGNyRk51dHUyL1FIR3RDck5ZZzNhblFzUzdlVEQ2ZDAvU2lwMG9X?=
 =?utf-8?B?VUZ4L0NPd2NGSWJCVHUxV2lOb2J6K3FTODl4cEg5NUFrN0txWnR6Y0NnQW9n?=
 =?utf-8?B?UFMzNEhUbkl3MEZ0Y2lYUURXcTNoUnJOVzM4TVVXZXpVSFhja3g5dGhFelpl?=
 =?utf-8?B?MVVMQ1NXemE5MHM2SHNTNXl4bXpVSm9pNzlqcVd0UWVGNk9WWGJiZnVGZmp3?=
 =?utf-8?B?WmEwL2VpTzlOWFZJYTVIWGRLQ0IzUllGUG13Yk95cXFOY0d3YnN0NDRVSjlr?=
 =?utf-8?B?QnZ6WnpOVHRib1VrcldsSzIvejgrTlp0QWN5VEhvY1BFSjZVQjZyOFBuUFVx?=
 =?utf-8?B?bEZMTC9aaDR4TC9GWGszOFMxRHNLYk9nVEgvU0FjREt2T2xIa21UU1hqdERN?=
 =?utf-8?B?ZUdaSm85dS9mOFg2TmxZY2FFb0orNSs2SmxQaVV0MGpteWJXd1kyOEEvT0tv?=
 =?utf-8?B?eHEwTmVudDltTitEZjlMaDZwN0JOZS9uY1FwMGNQYTMwMWRrZ29UVzBKdkQw?=
 =?utf-8?B?bWNzQzFrN2dvTnQxTlFZRUlvTE9yalNlUndta3B5cHJEdkx3QXRRQ0ZtVUY0?=
 =?utf-8?B?QUVnVFV3MlN1elFLMU5jL1Y0NXI1UVhUSW1qekxkTzErT3A1S3RwSEg0cVBC?=
 =?utf-8?Q?lOVTm3Fh+JnqSv6A1o6J9Z1s0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 555e4af9-4f0e-4abd-659a-08ddbdf2be68
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 07:40:43.2328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qC5qi++wpNhUZV/5/k0n8m4s/N5xvGIc/3b9xJdzT0V+ZsOKuitEPRvV0Sn8XH4xuY5zC8Vvj1FFk7sX1QSSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5632

On 7/7/25 16:09, Alistair Popple wrote:
> On Sat, Jul 05, 2025 at 10:14:18AM +1000, Balbir Singh wrote:
>> On 7/4/25 21:10, Mika Penttilä wrote:
>>>>  /* Racy check whether the huge page can be split */
>>>> @@ -3543,6 +3594,10 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
>>>>  					((mapping || swap_cache) ?
>>>>  						folio_nr_pages(release) : 0));
>>>>  
>>>> +			if (folio_is_device_private(release))
>>>> +				percpu_ref_get_many(&release->pgmap->ref,
>>>> +							(1 << new_order) - 1);
>>>
>>> pgmap refcount should not be modified here, count should remain the same after the split also
> 
> Agreed.
> 
>>>
>>>
>>
>> Good point, let me revisit the accounting
> 
> Yes, hopefully we can just delete it.
> 
>> For this patch series, the tests did not catch it since new ref's evaluate to 0
> 
> You may not notice bad accounting here unless you unload the kernel module,
> which can hang during memunmap() pages waiting for the refcount to go to zero.
> 

The tests do have an eviction test, which tests that all pages can indeed be evicted
and I do unload/reload the driver

Balbir Singh

