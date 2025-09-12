Return-Path: <linux-kernel+bounces-814915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D00B55A55
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 01:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C84811C80E45
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BDE2874F1;
	Fri, 12 Sep 2025 23:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oDJHkWfq"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E67270EBF;
	Fri, 12 Sep 2025 23:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757719874; cv=fail; b=eDj5dFB/8/s6EK55krh1JIbsB7obRv23OSJMdZO9musKBmfONlKz+HnncsTeJiSBLGZMgucSzPk2k4wJvRqGv+9oj5GdcCDkOy77d43RORY/PZafS1meS64yYhPI6I6pAUpVq8GICTgbzE/ynVhp7qCxECix0Lh3zv4rJDynhJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757719874; c=relaxed/simple;
	bh=Rg6sfrNyXvJbd3RUGn+t8ws5xfS/SXpAWNqM+K5KeGE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UAvl6tF4/ykDrczm+R9HrazZ+GMxLYGCDrSOB5VQql10/asi17rL+E8MaDi8gnl4Za0+5VIu6cO5RnNY1fUtMI0pLpzNeRjgg2mBy752gjxc6lhRYyFQ2zxMZ0mJyj1ojDBtI0ZDZEv99zZg2grjlpfJ7KMftzpQ1I39TQRhcPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oDJHkWfq; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbSaVMxmU/PruP6VBsSLx9Rkdv8fw7siyLpAuO7HhQbrfIxvpOBaTFbPzS4J/mTOMnm+v5F4xpEfzOQ67/kMAnUzPew9ULtWnJidKu7MhXtujRDUT/RuGHFnGfPDVTB2R3UiTJblv1CvMhQqm9ysyKspnuKhOLMC3idlMM0iA5wkAEi5tcUBdEH5Ale2k8Frm9NCje8FSxc/9gYOzGTMAO9tJVF3OUjBYLd9q7mpr6ydq2aO+mQLt/2FLvhtjddVZuSl5Q9BiikiaWnlbbG3tAhbOaUwXOs9R5X45WsmVueIfbgJKYoXzgivwLxKihAcXZdlHhuNrGF5ynJD2yJw6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZ+l2OjGwVo6GHuS+y3Z1hQwpI7di/ompVVldXJ/a/Q=;
 b=Jha7q3GKBTc1yuSybNYVDZ/EreHKbSewjChshGTcHL1nVkdETh4RQDcFDlGgAl10P7k4Xt33n6o58IZYrcHiNI1mY2trqC0WGO4eMwj7E17bQ9jsbvW6yi8zOG2tq9awLcPPJTeHVRzVkWkhpxcdRuaTwi8NCrlPSRdpzTTJdgGqyf//tEkqXYDWTPl3zdZhB8Fco0xedMbranESgmdUD1SPh0xwimUzbQ2g8RNqCLIVcuw2FHUHuaMoY3NgloBGTr2sxiij2MmjbJiuLLUGQvqJnySEH18QKt+ppFvXDGEL2pLpBD+rrtCRXITXHXTERMnIlUoP3wbSJu4uXvHCPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZ+l2OjGwVo6GHuS+y3Z1hQwpI7di/ompVVldXJ/a/Q=;
 b=oDJHkWfq17ZsBXAdTmAzsO+S6cFJ9EP+xJU+E/Z8hZgWwOtknHAlFsNtm+wIHu8a/uNToKZeAFeKNwI3RwupYOP7KcGPItMT8KVRiDONje28kiXwz7YnvMNucpCDl0PtPNEfDNu6Z64nn+HoGTzqfduJAsITjPKA1Y2XIcTmqyN1CTaE70ba+s3Y8glDUqreUgK2zyFbebpHKXtpnJIgyaw8UDU/Upe/x7xDb8mGRf0cD99ox9vqpaoNaMuE9hjnX1I1/Rwi8HmWn3vX2s9SP+BVe7DvXuF2qGQX060eejTdBTmvnZy6f9d1ykWYg2QmeLN6ok5NKEq+tngA8BjLLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by DM4PR12MB5866.namprd12.prod.outlook.com (2603:10b6:8:65::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Fri, 12 Sep 2025 23:31:08 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 23:31:08 +0000
Message-ID: <d45454c1-44a1-4e47-a3ef-2ff37d529235@nvidia.com>
Date: Fri, 12 Sep 2025 16:31:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: rbtree: add immutable cursor
To: Alexandre Courbot <acourbot@nvidia.com>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Vitaly Wool <vitaly.wool@konsulko.se>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, =?UTF-8?Q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>
References: <20250906140256.3059395-1-vitaly.wool@konsulko.se>
 <aL6YHkF96ICqqbBZ@google.com>
 <94252007-f389-41d0-b5a0-ed948225543a@kernel.org>
 <CANiq72k6OXcvjzKimfzKAAw8QPzDoVxUx_smFA8KU6gEwJ3yeQ@mail.gmail.com>
 <3f8de021-8eb3-4a7c-9adb-8244c5aa250a@nvidia.com>
 <CANiq72=ex8zJx+KZTV5eRoqkYE=PUkbG5TTvOJo5cXTtd7b1Fg@mail.gmail.com>
 <e49f9e6c-69ee-4ec1-bcc8-3a60fda9a7be@nvidia.com>
 <DCPMBM7DOG2Y.9N56KZVVO7GC@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DCPMBM7DOG2Y.9N56KZVVO7GC@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::35) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|DM4PR12MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: dfe1a676-0cef-40eb-b4d8-08ddf254734a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2tKMTJ1ZjJoSlYrcHJURWJqQzJPZUhLVXJ5UlN2YWVDTUVWeWl5TVhNSFZs?=
 =?utf-8?B?a3c0ZVZHV0hEVVlCRGd4SG05S0NzK1I5ajJUOVRocFJFeHVqMGFFUXVEUmlF?=
 =?utf-8?B?U2Joa3RKMzc0cWNGWnBIUExpU0dGVlBPdW9vT2lteFo1SFc4N2kvZ2EvSXFu?=
 =?utf-8?B?d0hVUnczck5ueUNNMEZXd1BMbHBHVXNEVTRvNDZxOFFKV0ZwVGVUeTdCcGJU?=
 =?utf-8?B?YVE2OGZqblk5UDBCTzFQMFgzc1o4U3F1OVpicFdQcmVCUCt1ZFhobmlKWFV0?=
 =?utf-8?B?dllPTGFVQS9wY2RoajdBZlFoZlkwdXBxOENhcmZzUFNLWXZkbjEwb2R6NHpT?=
 =?utf-8?B?dHZLMjJFYVhKQ3h0dmtPOFlXeStyWFJjeC9MWHgvN0p6cUJKdVNiRlcvV29s?=
 =?utf-8?B?RnhmcDRueFgweTQ0NWpHMzRIakR3ejdRTkR4Ny95c2oxNWZIclNiL1hQd09y?=
 =?utf-8?B?dlFVOEtLRUk3U2plbk5EUklac1BrRkZhZE10STFqUTlRM1ZZR0RPdnh3RWlM?=
 =?utf-8?B?Wm9HMW83LzBWTkQwQy83VDZqM2VQK2tBYXFlQmlsTEFrZmZ5UDhlTTVJNVNL?=
 =?utf-8?B?cmp5R1FuZnFObkpnUUJMU0hVb1piRFhDUndDTnJBVTlxbU5nTHlObXBaM1VZ?=
 =?utf-8?B?Z0JJY0M3ajI0SFBlNE52RG5BM003VC9zMk8zb2dEWTZMVytjc3MxNkZwSW5o?=
 =?utf-8?B?YjFzMVBpZ2tFUnVrZFE4MFJXd28zVWFUcjVmNXRVVGx0T3N5NFIxaEVNS3pT?=
 =?utf-8?B?dWZKOWpLanEycnAzMWhNTVJrWUNwcnhRSzBjd3VnUkxjbGtVYlRXTFp2UzhI?=
 =?utf-8?B?L2tYd252emt1VEpjR2kyNnpEYVgwS2VzeXpXZm9admkwN3psbkxUU05EWWVk?=
 =?utf-8?B?R1JFa2dxbThoYy83Q0ZnUFBlazZIV1BheGl0WHB1MXRFbmtweUxiZWU1cVZx?=
 =?utf-8?B?RWZ4dWxuMmh3TktDRWZSeG80QTlRcXd5S2E1cFk5dTZEdVZHUXlaN1BtSWZF?=
 =?utf-8?B?QUhvNDZCQ1U2dFBzeHowYzlSY3ZkZHc1S2JqRDdkTnBacndINmZuNnlTVjE5?=
 =?utf-8?B?K0ErVGJBNEFkMlhDV2w3RU95b0xQdXdHZmp4YjJFVHFCQ05jRWxxRzJDY0Zv?=
 =?utf-8?B?YldweVh4SnJOdnRWVHREeVVtYTl5REQxL3hORlRLN1B3a2R0Y3o0Ni85eDhG?=
 =?utf-8?B?bHRUTXRYUm9nUkV5ZENVWW1HdjI0NGFVUUkrMkNUWVpkVGpXZjZreDdhanRs?=
 =?utf-8?B?dFFxRU80ZFBQbENKS2FrdExWMTRtbzMzUjB6c0UraGdoSEswSFgvak9OemtF?=
 =?utf-8?B?VUkvWC85d3FXcEVYeTk1Q0szRFlzVE8wVk4yZHduS2lUcEs3aUlnUURHMERO?=
 =?utf-8?B?MmtrZm81UW0wVFczM0JacWtiaGVEa1BaQ2R1TDFkaDhQQnFEQzdTTWljd3Vw?=
 =?utf-8?B?c2ZzMmZWWnNNUytOMFhabUhYSWpzNytrRmNKbjRyTzhGNkRPZjVJeHlnZ3pu?=
 =?utf-8?B?b0JCTDBsVW9iMjg5WHU0UWpnMVlUQVB3RHNlamE5NWNnUERiNHJQZFNFL1JD?=
 =?utf-8?B?UXg3c0xQbWhYc2UxOVNYcitIclBvWmdkZWpwaDBNYTVrZ0VYVTRJWnhtMTNM?=
 =?utf-8?B?aGV4WU1NZnFsM3ZSaUdTaXdOUEZYWWp5QXNrVzIrWkhVSFk5WGZjNGZZMzg3?=
 =?utf-8?B?bEw5NzdFMUpXbVpuWEpvMy9IN0F2YnQxalhqQWdvaXIyeXhGVUZNWUhjVTYw?=
 =?utf-8?B?THFOaUtIR21OSEJVOGYyVWhLVHdMWXNoQXE5S0xOQ0p6YmhVM1VxOGhqLzNW?=
 =?utf-8?B?b0YyWWRoSlE1d21SWDRIbDVkQ0syUXdqalNqMjlBRkl3dUQ1RDQ4eUhGN05L?=
 =?utf-8?B?eXVxTWo1aCt0MjhUY2pLZngrejVlR2tZSEhtZzBocVJwZ3B3WnV2Y28xSUtr?=
 =?utf-8?Q?NilRYdT6rAw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1VxT3Y0b1IyblpkL2h0YU1BZkFRWXBleXBGMFBrZHFXTHo0Q1o1L29MV3Bq?=
 =?utf-8?B?YldPeCs5czBycGwwUmtGM01hL0E0dDFscTlqbHd1YWkwN0lKK3FKNXRjQjNO?=
 =?utf-8?B?bVUzd0VxcE9UZmZUN3h1S0F6bWMvN1pNeG9hQXh2SEZUdG9WbkFobDJ5ZHhJ?=
 =?utf-8?B?K1A3YzhILzBpSDZXTWZHMGZiR1lOUmRHS1hERGlvaVl5aDQrQ2ZkZTdOSy9P?=
 =?utf-8?B?TThWblZKbUdYU3Mzb3F4eEYzRmM3MzFaR3VoeldGZExYT0VJcy9YcGdNTktt?=
 =?utf-8?B?RnNJMUw2T2c1cHJJQXRyZkxTemV3ZkIxdzBERURwc1BUdGcrQXU0bE43Vlo3?=
 =?utf-8?B?QThFdTV4MDJRZC9iM0FXb1NtZ3ZCcTZmWmZqVkFMR1dzSmlVRmNON3YxdVN6?=
 =?utf-8?B?K2RiWU5MMlVoakhvYWYwS0NDNG1zRkVJQTdrbG1jbCt6aGtjTHN4VzZrdnZT?=
 =?utf-8?B?aXd2VDVvTzc4NFRNOHVWclFIdVpZME4vZ3lkQ3dXczlkeGhUbUI4ZEZPcWUy?=
 =?utf-8?B?c0NlZ2pJQXNQcVZmR1psSDBDeCsweWZtNHRNZ2tOQUdSL1VIaG9WazZVZjRX?=
 =?utf-8?B?VUhlVDhyY2pTQUVHYy9LeEJJeE9LYUhpampjUjZUWFgzLzFSTGh3SDdZVnQv?=
 =?utf-8?B?MVZWQThWTEx1cTRYdnV5dis2NkRNeEUzNUxSZHUzWTcyRE5SKzZlY0tZQVJ2?=
 =?utf-8?B?RDJSTTkrVHVteGhVTXdjdlMrSUx3RXBDK000UGFBbXZDQXh6a1dTNHBVNzJL?=
 =?utf-8?B?emhXMGFuNlRUVm1mYWQvQVFyZ1cxSitqMW1WWStGcHZZSGtDdkxrbWlkeWdJ?=
 =?utf-8?B?b3ZZNkZvRXZHZWltZ01hWC9hVzhua21pQUlUVXFJS3BqVGVXWXV6NGkwb3F3?=
 =?utf-8?B?U3JhaDlSVUlramNJTTlZR1d3eFBoM3N4a0pWTnlLMURoeU01dHlLUWNMcExx?=
 =?utf-8?B?eVVlWTBrUW5wY0YrajQzWWg5Sk9aZnlQVXZlRUJOMUl5dlZhbElPbURRanRT?=
 =?utf-8?B?dUR2SzRQbXZ4Rk9HaENTZlR1bmM0U2o2a1FYR016cVBZdUVnUnFnM0tFRGlC?=
 =?utf-8?B?bUFraUdEN09oTWFEVmYrVy9pV2RISDdWZStVaFVuRDVYVTZVdHMwa05jYTFh?=
 =?utf-8?B?Skc4elhSMVMyKzlnb0xoTm9hMGo1T3VmWW4yNmMydUk4UUpXaHZXNG9Ka0lG?=
 =?utf-8?B?VGJFNVFXbjhWREk2dHFJeE1WK3RkVjJUTGl4Z3BTbDE5dXIzR2gva2Y5emVW?=
 =?utf-8?B?ZURtU2oxc3Rlei81eFIyZGpYQUUvUDl6dHNxRXZWZXZMcWE4V3dyaS9qVzAx?=
 =?utf-8?B?ZndkalRCYnRFeWxIbXRWaVRaL2M0eDZidno2MzZ0LzdWRGsrS0c3SUpFQmkw?=
 =?utf-8?B?MEpSdjZkSHRZWTZraDB4S2Z2anVHWDVIY0plQTZaZ2VzaXJ3b2NzVHRqOWhP?=
 =?utf-8?B?VzJOWlZ1eEQ4elJ2U2VzV3pqYmpOMEVJVDdXZTRFdGZQbUJ5S2IycmRUTGov?=
 =?utf-8?B?a25Bb0NubURxVlQzaXo1eFlUakYzeFhici81TW5ZNGdTSUI3WjZhakordUhh?=
 =?utf-8?B?MERwNmh0aDNIMVF2Z2JtWXBzRENrRTRCM1ZUdzVRRVc3VEpWcXhPeXZCMVRo?=
 =?utf-8?B?WGUyeGNCQUxiUmZsWnZDQkNQck9ZMFBZZi9XdERVWHRIV2RNZlZwQzJkaEhO?=
 =?utf-8?B?Q0FJUTBic2NJUFIwRUFhT2hNVlpuWUlTSEkvcHVFV3l4ZGRoREkzMm9VelpV?=
 =?utf-8?B?QWJOSXp0cjVXUzZpTlROQjAzRUhGcEtxUmo4S1RSbG8wYUdXRFNXL24vWUNu?=
 =?utf-8?B?RU0vTCt3ak9rcU9GTmVsSHFvV0oxczkzS01SQWVEV3pRK1FDVDRrbThmWWNB?=
 =?utf-8?B?SmhLVE1EMzkzVkZ6MWpnYXpFU1RVK1Q0a1VldlpqY01IRTJQbDRWdDJwWmtR?=
 =?utf-8?B?c2RJcHE2K0NPalBEbDBxeG1wVHpjTkExOW4rTm93MHlNSVJQVUVpaHhJMnJr?=
 =?utf-8?B?aXBsMDBoZUd4bzZrODZtb2kzM2o0MTJzbTA3UXJVNTNLZmZ1M3g2TU43SlQx?=
 =?utf-8?B?NDFRcnJEVFZWOGNQRmt2MHNVNGc5TWdDSW1jNE43VmlORTRaajFsdnJhNWVW?=
 =?utf-8?B?dVRQVGtXVFBnKzQ0TXg3TS9hcUJGZ3NtQURPUjNwOVl0S09wbjVoWTR1bUZl?=
 =?utf-8?B?TWc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe1a676-0cef-40eb-b4d8-08ddf254734a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 23:31:08.3919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kY0+IHCfTd4wdNIP+18PUNU5t7ImPlXR4lgIL3XkdzFdGrwEEdU1jNiNoxNCBmvqvKNSkp5sDbU4YCd/O44aOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5866

On 9/10/25 7:33 PM, Alexandre Courbot wrote:
> On Thu Sep 11, 2025 at 4:40 AM JST, John Hubbard wrote:
>> On 9/9/25 7:50 PM, Miguel Ojeda wrote:
>>> On Wed, Sep 10, 2025 at 3:09 AM John Hubbard <jhubbard@nvidia.com> wrote:
...
>> It leaves unanswered, the question of whether (and how) to use something
>> like the &raw feature, which requires Rust 1.82.0, given that the
>> stated min Rust version is 1.78.
>>
>> Is there some sort of exception to the "min Rust version"? I haven't
>> figured out where that is written down.
> 
> My understanding is that while the feature enabling this syntax
> (`raw_ref_op`) is stable since 1.82, it has been introduced as an
> unstable feature before 1.78. So it is here, just not enabled by
> default before 1.82.

aha, that's the key point that I was missing.

> 
> R4L enables some of these unstable features when needed, especially
> since they have been stabilized meanwhile. For instance, we did it with
> the `pointer_is_aligned` feature for the `FromBytes` patch [1].
> 

OK, I see. Thanks for explaining!


thanks,
-- 
John Hubbard


