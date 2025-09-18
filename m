Return-Path: <linux-kernel+bounces-756292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF98B1B25E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837183BF40D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D69235364;
	Tue,  5 Aug 2025 11:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bU+sCuFN"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895411B4F2C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 11:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754391680; cv=fail; b=UOJR3G7pHTiVoi67jGeTOQv1SJwGIkp7WHnXYgKouDmLIP6m+krjsMU8mz+r5zsVRzBQUveL5dH9d83Yd2GAoJn/7nk+6pgZV2QQ6h7MKUlZHjcRABXaOIfbhnPZBjHTASi8nhvNRyEIkm9Aqt3ByNJehZPhSSb038KmQ36qzrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754391680; c=relaxed/simple;
	bh=MhfT3OqquQsUy8qIQvAoT1xCA65cQ4I7wtz4XZYvYVA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HxIzRRWPiDO/9Tc4nL45yomlf4DJ3tI1OEOQ9Ud7/oftXhPTurJbeZoR8BKzS2quzv7Ntngo4ycq21/1Ul9Za6ihe5f27p0+ze3zkrRM9tZ2sgwzV65wnWTvSTbB74Xk6vwrSFn9Onw71Jys2glDRpdnWQ5ayJNmGqf2YdYimQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bU+sCuFN; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQrVfHhF5uk9b0PfVCnNGdDJH5iFuv/chmpJY0z6XolwBY0GvLQWdEM0vgjn2Mkvlwm2IIPCtFLjG2vcayIdv3r/vjBEGMrnJmggET+Y0Itf5rdnM8B6M84uUmjKPuaAkbqY7yk8JJPlZ+HMBP4QmWmZjqLnyC/BB5vNgqH+/rX0hwzqJcfeabyJANMe5lhViI0PZmhj2xa6e1aFf+4FsNhBfgPVy3eoYJGW7jORuMKv/FY8pCtqfuhguDadqZI49ZtXt1UoXLx4OXXXP4ueMmlWXRinJeGKOVGfPGUK7927RVrnhzB4vwY6biDYbvrWc5bS8x2FvJ6KYnsNjnTzIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2TcfvWJlrf1EbOHugRqRN1BzeXQdVgVfJYs+UdBtIw=;
 b=HBcg5o61YxAr2/KIks5ndUhzkeKWK8TYiZMpZbAw2jmCmmGoAU2/rp2TdVv6CgPYG3/yi2Qy6wbksEJLWgkJR6i0kfWOnRkDIoxmQCKenw7ouZ5MUDuGWIGufGUcmJYxHHmc7uJ3gNbMyW8W3aWBRGe7TqLbZwbQEE7wnuxRbQUhrfCt2E50ut4CYyeNBBZ7h9hkeAUQ2sH4YIzxixFukwKMD7YINlgUnnVp6jVrNKFVJCb5cb3lj8UlPMeAgbBlv0F4Grwuh+vT90rpRGwF0lk/VhfjaqHGtV8qxC6RHgxxgdQt74T5hOCQ1td4OsojIBn8M/SxawArzzDW16Ln8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2TcfvWJlrf1EbOHugRqRN1BzeXQdVgVfJYs+UdBtIw=;
 b=bU+sCuFNoG4FKCrBEoeH6mcGIEXFb3My+SSrGuk7pgSYWcwpZEBcgqRLJEusiJVjK/HJUTckv8R6EZmxyD8KPtS8CJ1U8aNI/kcY6Q0vT77sxVmmT16dGtuegHO82aeiHgSnTHCStHjMRcI+x+NICTaM1RdnHLF2zlnKMfOSk0P9TWnEgZqmkPGLUgf0tEXl1XgkhNzgE9EV6MSOXdnf5PtZfvXo3QK9Za17B37/ykcUg9OIet92nSGhcrAddLvEmACcHllQklXKsq3p68LQ63osaflRDwYAwZn91M6q8joa0SKMKNayZLkTfP6SpH/vpPRTmJsdyyW7e003vlz85A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Tue, 5 Aug
 2025 11:01:14 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%5]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 11:01:13 +0000
Message-ID: <9c0ad782-e1c3-4c7d-bb20-730d2f915dd5@nvidia.com>
Date: Tue, 5 Aug 2025 21:01:07 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 01/11] mm/zone_device: support large zone device private
 folios
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Barry Song <baohua@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>,
 Alistair Popple <apopple@nvidia.com>, Donet Tom <donettom@linux.ibm.com>,
 Ralph Campbell <rcampbell@nvidia.com>, =?UTF-8?Q?Mika_Penttil=C3=A4?=
 <mpenttil@redhat.com>, Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20250730092139.3890844-1-balbirs@nvidia.com>
 <20250730092139.3890844-2-balbirs@nvidia.com>
 <dbebbba0-3c59-4ee1-b32c-4b9f6ed90d92@redhat.com>
 <1e307223-897c-4db0-9564-95d76bc3d260@nvidia.com>
 <98a30c7f-8be1-4b08-955c-724667971288@redhat.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <98a30c7f-8be1-4b08-955c-724667971288@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0064.namprd02.prod.outlook.com
 (2603:10b6:a03:54::41) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|PH7PR12MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: 08183f6b-b118-4f8e-776e-08ddd40f64a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXNzdVd6R1ZpbWhhZXNzZzF1RUFaYm5CemhLajBUWmdkZ3E0Rmhjczd5TFJq?=
 =?utf-8?B?NDMvVFA3Rjc3NjRPaDZXcm5RejdMNEhFVFVSa2ZQQlk1WDg5cWs1c3l3alIy?=
 =?utf-8?B?Tmtvdk5jMmhYYmNBOWs1TmJSd2ROSzRJbkhoT0t1citPU2hNa3BIVXU5K1FG?=
 =?utf-8?B?SkU5OEF1ODFGcnpoVWNJMCswS1lsRXpMZWJzemJ4alJUQWNUZ2pxTHBiamZM?=
 =?utf-8?B?azhKM2g3VHFkZklKMS96KzIzQ0phdGRIZDBYbFdrdmV4TW9odzdRU0R4WUNj?=
 =?utf-8?B?TzRxcjhTZk9hRjJSWWJyclF4MmtOcURhOEZ3Zm1aemVKMnUyY3huSTlSaEo2?=
 =?utf-8?B?TldjQVYxdnErd2x6emZObEllQmxLdUxQN2lieVd6bkg4b1YvSWhOa1BXNTdz?=
 =?utf-8?B?N0JNTXRVSnYvUVI4SXkwNW00YkNBV2s1NDhBVlljanptY25yOEo2SkZaamdI?=
 =?utf-8?B?TEtBS0xxTWNaNTZXajU4UDZ6S0dmMXdiUEIycm9aVGZIeVF2OFdsNWJkTE5k?=
 =?utf-8?B?ZHd2cmhSU0x3SlhtWGNDamVMbEEvN2Q4M0Zld3hITThxQ3JiSXczMTdZM3RW?=
 =?utf-8?B?aHZDb2xOVkg3SjlCNzdvd1I5NmUyM3Zva0hFa3pabDhwUkdBb1ZiRytvazk1?=
 =?utf-8?B?MW1YdnA3ZWVtL1ZYbkUrVHVEczB4OHNKRXAycENhRW1acGVHNkVLS3Vidnpo?=
 =?utf-8?B?UUptWjZpTWxjYUw0TmFramNkQ1lzZnZNYzAwb2NSOXRqSEFCUFFTVWQ3Zkcz?=
 =?utf-8?B?a2hkZGYwZFZnK2dxdVJWbG5CTktiWVdhV3JOcnd6VGhxRmlUTytNMWxndEFJ?=
 =?utf-8?B?dDljRUJqc0ZzZUYvK1RnMzVKbU52RmNFemMxa3dBWXlreWpYL0VZcnlxK1lq?=
 =?utf-8?B?RGRpVlFMQng2NERWUEdoV3hPZXlkRFBXSGZadFlYZWNiVDdiL0lYakZDWFQv?=
 =?utf-8?B?RnlBUityZGpyZU1zMDRRL204ZmVoRCtwSWJIRzNYWGtCZ3RLZ2dlTGxNUWdo?=
 =?utf-8?B?Rk9za3NFRUJUMk5kME5hdXkvejRmMjFCVHNla0o3SWpnVjlGajUyalBFUjZn?=
 =?utf-8?B?VE9QVVJwWUJKUjBhNEYzUEhFM1ZZVDcyUmwxa25MeklGR09BbmoxQUc3WWJz?=
 =?utf-8?B?RjBtK1lwRlI1aHppbVQ5QklTeURWUUxlQUxwU3dCK1NESjFCQkErdVAxejBP?=
 =?utf-8?B?VVRGMndNKzJpcHlrTlFaM1BOMGdFSmU4WG5TWkxFWUhGNkVNYXJiNkRBNE9K?=
 =?utf-8?B?K2hwMGJOVGhnNXBSZXRsZVQxRzN5OXJaR01LOTJXV0krQmNScFBKaGpUb3d5?=
 =?utf-8?B?Qzk5T2U2V0hJaXU2QTVrRE9Db2F4a0VnQlA1ck9SWVlHdEgzRjVrTCtJVXRM?=
 =?utf-8?B?ZjVKRTBJcW1VS1U4ZVJ1d0VWaUNVS21YS1JZZGdZdnhGOGZmZklVNnMvbG41?=
 =?utf-8?B?RWp5NFkybTFoc0JNQS81TlhrbjJOc2dMZlVZWVlyL2NzTnByaVpzdUdoZ1Zk?=
 =?utf-8?B?ZmRTbEYvMDRrTUxOMks2Vm9WODRqY3dEMkJKdE8vM2J1NjZ6cUczZ1E1a1g0?=
 =?utf-8?B?aE9IMDAzNDZuSDRKdVhOUEFmUFhhVUhiVUJ3eVFrMjlzZWgrS1FoVHRFeVJG?=
 =?utf-8?B?dWU0WEZNamJNOWVCVDhwT1htYzhDSUluZDltdGZJL3FIdkFKTXhENUJIZzln?=
 =?utf-8?B?N045QXUra3FHZC9uZlVWbjJIZmxmUzVtaDFpMTcwZmp2ZEQ0VlpLQUZ1dS9D?=
 =?utf-8?B?S3BNaVk3eERiNmU5TGkvNkVQcENRRWVOdkV5OXlqazd6WHU2MGJXK3NwSUQ4?=
 =?utf-8?B?dmZDOVlqdDVmODNIakZ4aERlNUdMK2JzVmxWVk41b0h0aTBCRjI4eWRmZnNu?=
 =?utf-8?B?alI5bWQ5MHVXa3hqODZyNVZLcXhhMEJRbHc5SFF4RHlIVjJoWFFHYnAvblJX?=
 =?utf-8?Q?X4cDyoKO9sU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHhad0dSaWxxOTcvQTFNL0krdzU4eG9TZ1F2VE9QTzdxdDU5cnBtRVQ3eCtG?=
 =?utf-8?B?M3hLNVU1SjlLRGk1YUE2dHdzYldNWlBXR3JrMmxrQTJSWWRLVnc2YkVBQjJC?=
 =?utf-8?B?ZjdGSWZJOThaaGc4cHRlZmp5ZUNUU0IyN3JabzF5b2hGUmM0M3FUQVN4MFc4?=
 =?utf-8?B?OWpJbDQzcVZEajg0SG5iQ1REYlFYcHhLT2RBaktHVk5GY3U0bUpobzhSYndm?=
 =?utf-8?B?R2ppd0ptSm92ZnJqUzhpV3pkMHp3QmY4U2w2MW53ODUxT1VWbGNHclZEZi8z?=
 =?utf-8?B?bmVnc0J1TVgvZ2lSMHRvOVNTbWJ6UkJqbkh6bjFPZUhHbUk1dzZlekRMRHlP?=
 =?utf-8?B?cEhENGdZdi9GVlJCWk5OQWo4ck9YMTlxVmVGMmUyYkFxKzNzcTBOMi85QUFm?=
 =?utf-8?B?b0J4cXB3U0J5VHRBYVVTbjllQlRidGhETkVYNXlucVF2Y0dHMGhqQnNIWVNM?=
 =?utf-8?B?MkRDQzg3YWJaVGs1UFJ0eWI0U2huaDd5QVVISm4yM2RzRnlVOVB1RFg3MEpq?=
 =?utf-8?B?U3hWRVl4TGlWU1plNTZ4UzdWRXlqNVhCMFlwSVhPNndWSDljWWpaY2p5MzB1?=
 =?utf-8?B?bUFxVGtzUlVxRzQzTzcxbE5od0VjcEliQzBKK0krYURGOUVoeENEL1dlK1R6?=
 =?utf-8?B?Tkx3ODF2emIvYmVWcGFoOExwWkM2dXNrSnU1djhEcitZMHBwZXU4UkZ2LzJF?=
 =?utf-8?B?MGJZUTBNYnJMN21ZYjRJa0RXQjl1UFZaU0M1ODQzV3BIZkExMnByWTA5SXln?=
 =?utf-8?B?WmxZNitQbS9IdXU4RFV5QTFab1pNSlQrZDNWNzBjeTU4a2hzWXpVYVJkU01H?=
 =?utf-8?B?ZGxiQU11NDJLc2szbWZ5WFc4QWdWeXp2S25kVC9TNEFrMnU0QXV6WGJVMDht?=
 =?utf-8?B?a3F6b3dsVXlYSU5zQ3FFOENwSE9sNVlnT0s3cTh1OVZkdVFiSWtOL3BPSDV1?=
 =?utf-8?B?VTlkZ0VhTnFZN3NTL254SEFRaWRveVp0WEUzaGhIdlgrdk1RMzhkQmswNVFo?=
 =?utf-8?B?c3J6L0pFblMveFlxTHpYeU5FWUdOUmVKQ1RsNzdvQWhBSE1FQWtkOWhBN0pl?=
 =?utf-8?B?WFMxMEU1dXNMb1Y5bDBVSmIwanY2ejVuSmpCRCtHUC9uS1VqbHk5S1ZvSjdW?=
 =?utf-8?B?OC9lUXNUWGFBSlVrQ2s4UFplMkdpa3FLTk5UUWVJTUF3SmxLNGY0MmJYbTFE?=
 =?utf-8?B?MjNXNlhCeUdMcDVIQjJCcWp2TmhFSE04U3hpUTdSbGI2eW41MTBpR2M3b29Y?=
 =?utf-8?B?b05XeGVndi9KWGVYUlY4djlpQmFrTVhHRVRoTnVFUU4ySVdVU0VLMkhnQUFY?=
 =?utf-8?B?MEVtM01MWFVtNTFQbVpMUGU3bUUreWZnVmRTME14WEdSOHhVanQ0U0VUY1Qy?=
 =?utf-8?B?ek1IVm1abC9XTkRadGJEMnhtSTA1NEoxUE1XRFE5ZmRqL2dyQTNOSGFUL1Zu?=
 =?utf-8?B?MU95ZE9waU0rUEdRWC9kWG01Rit3OEpNNENsbTUxYkdPMG0yMzVtOFVwd1I3?=
 =?utf-8?B?RmlPMFFPQ0pXd29rdlQ2c1NRVzFKNW16KzZ3T1NoQzg1Z0tzejUwS0ZyN1Rv?=
 =?utf-8?B?c2RDeWNxc2pqNWkzWW5XeWE3QlZKSUdiUkxvai95OC81ZWFBZ1ljU2RYK0Fn?=
 =?utf-8?B?OXNZTmlua1R0SE8rZE04QUZiNnpuU3RLNDY5YVRPdTF4Ymovdlk2TXNaVWpl?=
 =?utf-8?B?OXpqNkRVTnhlR3R4ejg2YnVQZzhSbUFGRHMxeVNBWC9MRWNqZ1pHN2lzSmsz?=
 =?utf-8?B?YkNnekh4TldQc1hreHNhL0poa0toSittdkJBdnZVT0owcUVsdDFFUDA3amEz?=
 =?utf-8?B?bllBL0FGNjU4UVVPZ2hhNDFFUGJPUUZ1Z3oyWUVkV1Y0RmNVck9rUzNsQUlz?=
 =?utf-8?B?ZnZVRW1oNVQ1V2NwUVBtSisydmVpYXI0S050Z3VIaVhWNFdVcTFFWkNEQmdI?=
 =?utf-8?B?c2VRTWFOZnFlYjdkM29Mb3FUQ2VRcEhsY2ZVSWQ5QUcvaDJwNk8wQmE4MDdq?=
 =?utf-8?B?OEdIbTZCYjIweFdlNThHT0FuY3JvOW8vN1FPSkVPTFN5ODkvOHcwc1ZKTHZV?=
 =?utf-8?B?YWcrMkNaalR0R1F5eGtaVlN0QjdQSnUvR2MvN1RPVmVTV2xSWEo4Y2pWRXNt?=
 =?utf-8?Q?wKw3ndOYifzHbC1zZnlZdWLUR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08183f6b-b118-4f8e-776e-08ddd40f64a9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 11:01:13.6223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+U4sECzpFRtK4M785hz/qcLMYzj0tMxGsoMj3U38N72mCL7QelImMEOpEMy83RHL5hkT69z8dgNuqNNOfNXZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7820

On 8/5/25 20:57, David Hildenbrand wrote:
> On 05.08.25 06:22, Balbir Singh wrote:
>> On 7/30/25 19:50, David Hildenbrand wrote:
>>
>>> I think I asked that already but maybe missed the reply: Should these folios ever be added to the deferred split queue and is there any value in splitting them under memory pressure in the shrinker?
>>>
>>> My gut feeling is "No", because the buddy cannot make use of these folios, but maybe there is an interesting case where we want that behavior?
>>>
>>
>> I realized I did not answer this
>>
>> deferred_split() is the default action when partial unmaps take place. Anything that does
>> folio_rmap_remove_ptes can cause the folio to be deferred split if it gets partially
>> unmapped.
> 
> Right, but it's easy to exclude zone-device folios here. So the real question is: do you want to deal with deferred splits or not?
> 
> If not, then just disable it right from the start.
> 

I agree, I was trying to avoid special casing device private folios unless needed to the extent possible

Balbir

