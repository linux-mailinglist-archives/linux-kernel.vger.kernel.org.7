Return-Path: <linux-kernel+bounces-721058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE122AFC438
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A3317D79F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36430298CA7;
	Tue,  8 Jul 2025 07:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ku3Juuzi"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78FE21A428
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 07:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960260; cv=fail; b=qzpI06pIi1wlgc2DaXoTx9Jro4VCeK6G0LViOsv8SUHWpDXinAcDF2Ig0JOEZwGi6mRB7qIvzKGhofgQbpMjx/wnzdQpUzVO/XCCra8lQOWfZvxiEKSXvrCck56JEnZpO6Pvv19nHbHiGPL9ApEhOyXdHXGUpmONZLmwC87dGzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960260; c=relaxed/simple;
	bh=Plhe1agKIZrIFH31uyr5t0x30OERdZODypWu106K2mw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uhjwPVSefw2OvObNeu6fLLDFFH6ARLDEiCpcMERvSeTW7DBNTQSqNMT6XssB6tTfndFV32uHl/p88q/Y4sIvBXNrtjN7/LD6OXjMkWaTiVV1R1/5AwclyG1LS32cGMEursCTNS9KB16WVcbYF9q042i09g7rEo0kpGGO6Kv9e88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ku3Juuzi; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVOmiTCi3QptSBjelW1Uk2cGl3RrdYZgRM6b5lDw1mwX+IlyyXcp02Gh7a2Zw/6aMWg4HMmmqHqYzasZFbPgRfJACmNEX4EEZZ6oRP5GsyUYKtwt6VguHFnGWqZJwcps9Qw5nH+IkWUlj8drTKHTJhV6A4VvpG3sBRq3Fp0qMufJ9O+LqlMcHKDs1cU6hO5c1GAezrIcmBNosZMLlIdu/ZoQXs4H4taV0CH8ggCnwB1MUB81/Wh7IQUah0mGrgbredU1gtbE6xxEMf81qaFCg77NZwEl15HZ+4m442leYGGHfOIHehwpXjZTwR0yTX0tm5OYwxr2f5lCXgNknB9ttQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/K3p7QaZxKVQbuY/5k8r3kRFwYbdbykh0YO8RPUhOM4=;
 b=lWPiW8ra9SlIHWQU1oPxQTFaRi80LE9NMk17Fcb5fUdHUeijNxPOUT46SYD2WT4JqTY6llXgpHQBr9N9CVZLzYgquULIEtBShdePjoeVbSc+QNN0DLSsBp17RBwbx7aG099ZMFFbWQDR4bceCIwpb4VgOZhLeFEpl+qywYos90+vWwPlVmgnO+Lkb4R/gfbntbG2dZXD65hRF1DcaargleCKi7z0ouRwfPPmkB12H7VZ+rZsrj+KD6IDNf/FeVwuU1Xh2zrK6lC80+a/KYvI8hxci4CL6ZIxn0aoaowcYwRv4RGiMv53jxuaKrhxaeAL2V2b7kHn/zhXfzkApHh83A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/K3p7QaZxKVQbuY/5k8r3kRFwYbdbykh0YO8RPUhOM4=;
 b=ku3JuuziNb5UrdpVM/VwVk8MOB7HhAeydylY9QYrXqfG3MAWzgBLkJTj+/H/F6LD2efyZl7yBtBDJP0TC1ZkmY2qtJ3wOj8Wf0X1yhYokBglMFtzMmIWfKnN/jt4TNLfWESI6DVAsl1bG9VjZxVgX59VDNLWwvEBd2CiLRQHHkywQtyRpqg8Ax0Br1Fa3X7yIYQrMOU9JUuhH8hk4s04eY6dzzzrmvvpRp++H/INRY3w26oXaS7//3vvs3PqkBWhjIY3dO2CVVo/8DaBqfqevLumyBNJT3yz7tktxXoJ58ZnTGyJ7Q1RqECC6SpMOfoAdzgP2o0hhFHvmyIzzujudg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by BL3PR12MB6451.namprd12.prod.outlook.com (2603:10b6:208:3ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 07:37:31 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%4]) with mapi id 15.20.8901.021; Tue, 8 Jul 2025
 07:37:31 +0000
Message-ID: <c08156c8-bb0d-4d8f-b411-92c82e1dcfba@nvidia.com>
Date: Tue, 8 Jul 2025 17:37:25 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [v1 resend 08/12] mm/thp: add split during migration support
To: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Shuah Khan <shuah@kernel.org>,
 David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>,
 Alistair Popple <apopple@nvidia.com>, Donet Tom <donettom@linux.ibm.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <20250703233511.2028395-9-balbirs@nvidia.com>
 <e1889eb8-d2d9-4d97-b9ae-e50158442945@redhat.com>
 <715fc271-1af3-4061-b217-e3d6e32849c6@redhat.com>
 <b25b3610-5755-4b7e-9a9f-d7f1dc3e4bdc@nvidia.com>
 <6bb5b0ae-6de3-4df8-a8c1-07d4c6f8c275@redhat.com>
 <2ace3c9e-452a-4bd2-a7df-6fa9fd3de290@nvidia.com>
 <f1e26e18-83db-4c0e-b8d8-0af8ffa8a206@redhat.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <f1e26e18-83db-4c0e-b8d8-0af8ffa8a206@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0203.namprd05.prod.outlook.com
 (2603:10b6:a03:330::28) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|BL3PR12MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b996df-5389-4953-0ccd-08ddbdf24c02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzVGNXZubnhaSU1SSnAycE1ZZlZxZkFhRlJhMnFqQ3VoTTFUYVRKNllvTnpW?=
 =?utf-8?B?anFXRDE5RHVOTDBldWtMNW9wdkJrWmJPQm1wWmE2UmhIZVlFS25SWE10dDBF?=
 =?utf-8?B?ZTAwUkdxRi9PbkF2VlVZaG13Mm9BSTkvTHJZdy9ydjlRL0dKSGdZWm13VVFj?=
 =?utf-8?B?ZlNXMlducmZtZVVKdDNoVTAwSklOcEMyUkEvOFFDUVQ1aG5yeEFJTUpacmdO?=
 =?utf-8?B?TEUyZUp4Z1pMM0ptbURCc21EQVdUUGJydTFLUlI4TC9UMDIxOGxBN1hrT0Yy?=
 =?utf-8?B?SFhXYkZ5UTkyVVNGcFpENktWRlhXM1hrcm1CSWNsOFlZQkFWNW9ZbEc4QkxH?=
 =?utf-8?B?R1A1cVFDV2hWbXdHMVVVVHp0SkxpWTVzUW1LU3ZWTk5tcmhSSGZFODRQeTB6?=
 =?utf-8?B?VjZkR3Y2SVBKdFNYSm1Udk96ZkNQWWpQbWI2UFhwUHh4czhKM2dtZTE5dDFM?=
 =?utf-8?B?RG1GUzB4Y1FpdlNaZ0JqYU1mSWE4NzcxQUVDb0RNd1ZqVVBhaFdySGx6NUQ1?=
 =?utf-8?B?aHJpQmZwMHZCRTNESUJYbjhvZUppTUdqcDVXZHY5NlJodDZRN29XcDI2TmVK?=
 =?utf-8?B?bmpvMTdFM3ZBT1RJeGJ5dzdXakVBejV2bU45SVZ2WjdrL3BYbGczVy9OR0ZX?=
 =?utf-8?B?WDV4ZkF0ODdZYzlaMHRHa2FaRllDZXNpRTh5eEsyZ1A5N0loZlNWZTlXclpT?=
 =?utf-8?B?VWpJK2k1K0dwWkxNRWVnL2Z6SUxoZVNDRGVOYWhaNG0xdnBBcUtHWkF5MXM3?=
 =?utf-8?B?OXI4MEF5QldBS0pyWCs2b1hyU3BIWHZ2bjJlVmprZDFSYkZwL0dERGd4Z1RI?=
 =?utf-8?B?QVRMWjY3WVV1UUNRRm9FSEg4R2pqWU50TVp2SHZhcXYyQnNCRFkxWld0R1h0?=
 =?utf-8?B?d0lDOFczVGNwN3RFdGx6VkdqVTBvOWFwNUwraTV3M25OMEF0UTh5aXBISVM0?=
 =?utf-8?B?S1hSbHd6d0QxeWRIcWxEalRuc2VWYzQxUmphN2Z5Z09Eb1VxV3NBSGlOSGV2?=
 =?utf-8?B?dkY5em50ak8yT1V0KzZ4YUltNVNFVXVUTTZFd2cxWTlhMEdURkxkSkQzOXlO?=
 =?utf-8?B?UTlaK3FodTZ6cmhSUTMrQUhEbDcxMnZQbWIxZW8vbE1EYzZMMkRmTXFuMEZl?=
 =?utf-8?B?SlRBRVErbXcveTRDZ1ZGaXJNUlpCdFQ1MU5lazBXdmM3Vlh1Wnh1TFhaRzls?=
 =?utf-8?B?aVZwYWY2VkFwU2Y0ZVJUOFRsZDhFWFhWZGhwa1M1TFFKS09DVGNTb2NINHo2?=
 =?utf-8?B?NVBPMXY0aDNBM1hVQnAxNmc2RzJpQ09BZldleWVYSnhoYk9mYSt5ZC9FMEtw?=
 =?utf-8?B?K1poRVRpNUYvOWc1d2o2Tk1UeDhVNEZjaXljZ01PYXljZTZlV0dFZktncEZZ?=
 =?utf-8?B?d1BDQVl0YkdJRVQ4VWNZb25NK0NUcjZMUW10VEQzSU5xeWhPTEtVSVpZV24y?=
 =?utf-8?B?MS9iTEFoQ3d6eGd1bE5MQ1lGZ1MrYjlRZm53ajlVSzI0b3VrN0xBOHN1SW8v?=
 =?utf-8?B?NTY5RjQvM2crMTJhS0RMZmdyeEFzU09CQXl4Uks4YzZPQ3M0V3VsOFhPTmFF?=
 =?utf-8?B?bmhacTg3SjloakFNTEo4b3djbWFjMzBDc1hqVlBsSVFxUkhTZS9FSGh6SjRK?=
 =?utf-8?B?ck5CLzVkUEc5K1BLV0hTeXRHUlV4akJ3aHZmWm5xUFovU3BZb2hPeTB2SzRk?=
 =?utf-8?B?KzhqOEpTbWY0Z0tOYWRGQjhJMTVFbnpnTHgxTFJTY01qckI3UmpwRlQ2MUNa?=
 =?utf-8?B?dXBJN3ByWi91ZGRuQmRtK01lZVU2cktIM0NWSXluQktwVkNOaW93MWVnZkZB?=
 =?utf-8?B?bXZXRG5WZ0FtMTRJQmxUSUJsOGpwM1hLNUtiR3A3R2xvTlNKcnR1STdDQllp?=
 =?utf-8?B?TTJGWGlxMTErTllFaHVKcUw1c3dWbzBHdXVHdzdFNndUdEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SklhUk1MbkRIa0hpUW9aVlorQi9ESDF2NkJRMnFYUUFQUjBLOXRqNEorTHJN?=
 =?utf-8?B?VVNpVXBGcVh3SjZaUlF6VFZPWkw0UUdRbjBmS2NWYTR3MmNreG5RY1QwazBv?=
 =?utf-8?B?dG1UcXNianlKZTJLQ0JQMmVXZ2pLTkc5aHQ4V2tFb2IvaGZHMXVyY1lWZHJz?=
 =?utf-8?B?bGpVOTZTdFpHeDRsdjMxZTNFMWpYdlVhK1NRN1ZlNitHUHpqRzRxUm04eUI0?=
 =?utf-8?B?ZTE2bElma0pZaXJOT2c5MzA2ZnphQjNuVEVIblVsVFE2MTZ2ckFhSWhnZGpk?=
 =?utf-8?B?VGs5SkRIU0ptNjkraGliMlBVL0hGYUJuc00rMmZhaVdCQnVJQXFDQXJBNjZm?=
 =?utf-8?B?RUx0TkM2cDBybDJITC9HYS94KzAxSCtWZUkyRG41dlNDbW1WOUlnOWVXMndk?=
 =?utf-8?B?TVkrQ0kvRGJoTUN2QkFYNU9EcnJPZnV3Ky9qMDViek9sZ1pZdXlBYUVrZ3BV?=
 =?utf-8?B?YVl3aVp1MzJYb3hSVjlQNkJob05oUFUwdTNSbUZXSjlFeWh0ay9Ta3NQVEVm?=
 =?utf-8?B?THFpYkk3VGtEQ0diby9OUlFyd01Nd3BLTTJ1TW03S09OMVhaNWFORWsrRTV4?=
 =?utf-8?B?NmV2Zjg4V1lXK005Skc1ek5JbDN2Z3JwOXJtb0NZZ3d0bGdaYXlaak5neFZB?=
 =?utf-8?B?VVJ5ZFNIM2k2R1NKRHkxb0xxV0hPWkhHaTl3YzFnZk5mNTdXUi9SRWpaM1Jj?=
 =?utf-8?B?K2wyVUZtN0hJT3VMVDQ4cmJVK2ZjWXlqYVZaeVpHVlNmanBRZlhEY2VlZGoz?=
 =?utf-8?B?eFZMNXEzczcwVjBPSHhLNndxSnJDZHBDU1hsSEt5NlZ1WmhKdS91TmlNR0Qv?=
 =?utf-8?B?WTVuRko2YXBuMW82SGluZVdpVDVERmRadEdaN1VNR0hpdWNKZm1oQmNmNjdF?=
 =?utf-8?B?OFlIcWJwSHBubnFGd1cxR0NJL1Y1clFqa0wzVjNQbmgrcmN5cHRkSHUvOVpF?=
 =?utf-8?B?ZElEOEw3S1FpK0pmTDc4dk5ReTI0RXdMSmpKTmtRejlSK3IwUGhOQ3lGTUpP?=
 =?utf-8?B?ejlkTjhaQk1vVnZEYSt4NmxPM2FDZW4zcnpBMVZmS0puclVlbXg5MUdhZ2NE?=
 =?utf-8?B?WEdQQ0JHdTc0U1c3MXY0NUhSRmw2TDUzK2pYZDdBVlRucHBqd2J2aE5IZTht?=
 =?utf-8?B?cHViZkJPNGZHYzlZWS93MWEwTE44Z2h3bEsya2FtRzAvVFBMZUlVR0NVTW1L?=
 =?utf-8?B?N3hySTJ5WjFBMXZJQU9nMVJVQmZ5TFdKK3pyZ2pCT3dWdVJhR1Bkd1FkcU5i?=
 =?utf-8?B?UE5BbVc0ekFrSkM2UFBNeWoramhpY0NnbE1LL1MyS1FrelF1MW5sOHVpQ1Fx?=
 =?utf-8?B?UHZPTmZ5QW8rNjNubkRWVnpEZTV4WmlQckdzczBvR0VYY2dnM2xzU21nMW1X?=
 =?utf-8?B?VytYYWJXSUZZVXVVaUE5NFFUL3FSTWpENmFwamdUYjRsaW1teURPV2FHVHF3?=
 =?utf-8?B?WWhMUTFsOTRLYWJENTRqUXNXMlVkQ0hJL2xpZkdyc1lDWTQzMzJ6YVpBOWx6?=
 =?utf-8?B?TW14cHV1OWZwZXJYSnlKdFVJVmpUSTF4Zkd0Z1Foemo2bUJWYWJqUUxmVEZU?=
 =?utf-8?B?NXJWU3ZSZkttcTl1ZnJESHB6OGdZbS9DUTZ5SUdZeG82V3F1NVUwVjZBQTg0?=
 =?utf-8?B?YVNJZUw3dE8zMjVLYkhnbkU2aVhTYUtGOXVseHFUOUJQeTZDWENLRFNQSTFn?=
 =?utf-8?B?R05WcGY2S2VNQUdzTWdCd0p6MkcxcWoyMVZPd1JqTmtSUis4d3pFMmFFYmNU?=
 =?utf-8?B?WWxsRTJ0Qml6R25FTXBJYVFxbktBanZWZ1VMSVVBdjlHZGJIa2lFVWZTZkxJ?=
 =?utf-8?B?WjNzdkg5aityY0g3c3RSZE9uaDUzRFQxRDR2NSt1bzlWdGZMNmF2UW1SbjU3?=
 =?utf-8?B?ZXhWQW9vOXd3Y3VSUm02OW9sTzA4U1FXWDVlL0JFOCtsNXZPbndMYjQ3azhv?=
 =?utf-8?B?eUV1Njl1eHFWZ055cTlrRTVORjk1dzU0QmhiSHpPbCsyTlN3bklXemtab3JS?=
 =?utf-8?B?WTUrU1JRbDNxelB2M29LODIwTklETmZybkxkQ0dtODc5UFJLL2ZwamhBR2Ja?=
 =?utf-8?B?cjZKNE1WOFdmR25XZmd5MVA3U3lJeUlDMlNEeWN4OFN3RnBxRUJqYWNETFhX?=
 =?utf-8?Q?ZlNump58kh77SUryEuMZ5G7Cd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b996df-5389-4953-0ccd-08ddbdf24c02
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 07:37:31.2751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4CEREh5nXdqanGXUo9BoedxTb6oJIOUtqpCtPMyvX+0dPBFKTggdc6C1uXK8JJSGSNSy5Br39K0vuKeAaANJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6451

On 7/7/25 13:29, Mika Penttilä wrote:
> On 7/7/25 05:35, Balbir Singh wrote:
>> On 7/5/25 13:17, Mika Penttilä wrote:
>>>>>>> +static void migrate_vma_split_pages(struct migrate_vma *migrate,
>>>>>>> +					unsigned long idx, unsigned long addr,
>>>>>>> +					struct folio *folio)
>>>>>>> +{
>>>>>>> +	unsigned long i;
>>>>>>> +	unsigned long pfn;
>>>>>>> +	unsigned long flags;
>>>>>>> +
>>>>>>> +	folio_get(folio);
>>>>>>> +	split_huge_pmd_address(migrate->vma, addr, true);
>>>>>>> +	__split_huge_page_to_list_to_order(folio_page(folio, 0), NULL, 0, true);
>>>>>> We already have reference to folio, why is folio_get() needed ?
>>>>>>
>>>>>> Splitting the page splits pmd for anon folios, why is there split_huge_pmd_address() ?
>>>>> Oh I see 
>>>>> +	if (!isolated)
>>>>> +		unmap_folio(folio);
>>>>>
>>>>> which explains the explicit split_huge_pmd_address(migrate->vma, addr, true);
>>>>>
>>>>> Still, why the folio_get(folio);?
>>>>>  
>>>>>
>>>> That is for split_huge_pmd_address, when called with freeze=true, it drops the
>>>> ref count on the page
>>>>
>>>> 	if (freeze)
>>>> 		put_page(page);
>>>>
>>>> Balbir
>>>>
>>> yeah I guess you could have used the pmd_migration path in __split_huge_pmd_locked, and not use freeze because you have installed the migration pmd entry already.
>>> Which brings to a bigger concern, that you do need the freeze semantics, like clear PageAnonExclusive (which may fail). I think you did not get this part
>>> right in the 3/12 patch. And in this patch, you can't assume the split succeeds, which would mean you can't migrate the range at all.
>>> Doing the split this late is quite problematic all in all.
>>>
>> Clearing PageAnonExclusive will *not* fail for device private pages from what I can see in __folio_try_share_anon_rmap().
>> Doing the split late is a requirement due to the nature of the three stage migration operation, the other side
>> might fail to allocate THP sized pages and so the code needs to deal with it
>>
>> Balbir Singh
> 
> Yes seems clearing PageAnonExclusive doesn't fail for device private pages in the end, 
> but the 3/12 patch doesn't even try to clear PageAnonExclusive with your changes afaics,
> which is a separate issue.
> 
> And __split_huge_page_to_list_to_order() (return value is not checked) can fail for out of memory.
> So think you can not just assume split just works. If late split is a requirement (which I can understand is),
> you should be prepared to rollback somehow the operation.
> 

I'll add a check, rolling back is just setting up the entries to not be migrated

Thanks,
Balbir Singh


