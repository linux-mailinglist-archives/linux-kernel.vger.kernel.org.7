Return-Path: <linux-kernel+bounces-736042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A05B09711
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 01:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57ADF1C25514
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62C2226541;
	Thu, 17 Jul 2025 23:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TOnE7yGO"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E76B1D5CE8
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 23:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752793499; cv=fail; b=Qr4wEgoV69x1OsbOTKDvcWt/9LRjbuN0S8XwGxJnmYhh/oMo23lrGYW99csrc/pQk22asvNLFQ72V2aK5MVTepeXaDIQAjtKaXT4nfLyYTSEKnGAstZryeCMBxcx8s6YmjEyNc2R6Nmdl9joy9Rc7xz4cpqr3DM2o2cAi+QYMZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752793499; c=relaxed/simple;
	bh=ZArqfZDL9PPjhHSRwKOZXs2nI1eV7Li7q5LiU1ZdNQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aEgU/fAQUGhw+EfOE4zyZT3REqEBIWdTqLJOXoHtSv/rnBLhgDE4rIKiXtQQkE+CrD0N1uRPb7ptHu6tmMUzo5NQXHboS7YuQOhZoDPTWvV0fTSAIJi3bj7bp1vCZ4Kehk9r5C8jHNyCPbyrUdr6EgM3M39q5XUZij8R+1q25L0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TOnE7yGO; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Et69HFPHbd6GM3ZyNmA8uqAoh9p276If6UdCJRLamD+jJA2UdTbJc+cxtKe8DYISYaulVmQUPvfG/t9Yaq+mRoV+QXX4Y/0TVVHQhQmG02bAEMT1TGKGwOf3MShDV7FILvCwWVWG/h3MpWZcf5K2VpPNzHNf6xg/Cj++HQBjf63P59CU6LCl6d4+HEAXRLfU7ZkV6VPL0rvgRXc94YDsoGlLL7Bzm+vTEUo7vgGpoli88EeInm+Fl/kdGB2kPvHTzk01ka41BH/1ccYrSlqS1UFeF3u4SiRNPF7FZRi6Q7dK9S8ubNwyd+oEa0nKN8MMRGcAhHNxoEIiy64Kq33wMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCur3EOXMj7IuSGmOdmy3Xvm8z0s7kteVQuPXuQwOSg=;
 b=L4aILAQUAL0kykxmH84i8LcKkYZ4B1cE3WN6S8mC3J5lCWuKmz36JQKiY8aoylG4jwsVQ1wziP8R8EKv1jVG/bj366IcAkMF9B9ehbY+JS6sGE052U/QUQYY3e7j/SPAUYEJHyTLhoZ79PkrBmioA1x9/1bI3aum/EtknFI8p1/95l5BJ2dU42gKFC678C/pCsZCLZ6+LS9PyvOoWT+hDkL7uBw6R6Sggyg6yyCWlWT09zdJa3de1VHqQY1PCvx5zMxiJBjg5wRE3AwgDoO36LyUUo+jOwQLJZd04IgZ7ApKEQOd+meJWW9/oLmukNPSQ1+8YBUVgwaZ6hUjaJtDVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCur3EOXMj7IuSGmOdmy3Xvm8z0s7kteVQuPXuQwOSg=;
 b=TOnE7yGOfpYr/zAxpoigIEPAfnLb7yyH/l+PQtUFDwKBGqqTcQLLrHyqV/aRHVWwDyyVwCZ+N+ZnXrlmJhzRdWedMf0ud7YB81dMpxjsIaw0JcBfs8UtyNeFXnLhd7XTS1DKbmIlf8IcoU67lCkpOSYYSOIBEyezSxADQZUBK1Kh+NFyDOvxPRwHdEwEQgMbxZ8Ynxdt8JvWueZlm0GogjGlK+Qb6Ibkfp61vucBhEB9z/dwmawEFptRmKtC8nDrHjR4Emg4wMnS0aZ8N3Rp+qVQqZS/HKGtnAcXfBmTtTT+/VEqe/c9eVYT6bxNOwA/4ZERJooZTx5w07QS3W0S/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM4PR12MB5939.namprd12.prod.outlook.com (2603:10b6:8:6a::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.19; Thu, 17 Jul 2025 23:04:53 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 23:04:52 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?utf-8?b?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
 Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Jane Chu <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
 Donet Tom <donettom@linux.ibm.com>
Subject: Re: [v1 resend 08/12] mm/thp: add split during migration support
Date: Thu, 17 Jul 2025 19:04:48 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <9E024BB0-7365-4A81-81E1-72CB44A07775@nvidia.com>
In-Reply-To: <aHl4IuMlE9D6yaET@lstrano-desk.jf.intel.com>
References: <D129A3F2-D79C-482E-BC70-A26C781B149E@nvidia.com>
 <1a451d37-56c3-4d60-8e06-3abae72e6bbd@nvidia.com>
 <007E2728-5BFC-40F9-8B8F-25504863D217@nvidia.com>
 <aa4f94a3-f601-4379-b6ca-4389421ccca4@nvidia.com>
 <906590D4-04E2-40CB-A853-25FE6212700C@nvidia.com>
 <eab52820-813f-4137-b664-c79ba8b453b7@nvidia.com>
 <aHc5/pmNLf4e9brJ@lstrano-desk.jf.intel.com>
 <1DD0079E-0AF6-49F5-9CB3-E440F36D2D9B@nvidia.com>
 <aHfSTdoi/M9ORrXE@lstrano-desk.jf.intel.com>
 <a7e8485f-e9da-4edb-a809-a014517f26eb@nvidia.com>
 <aHl4IuMlE9D6yaET@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN0P221CA0013.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::18) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM4PR12MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: c914f296-18c9-4412-aad6-08ddc5865635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUozS2hheXM0MVAxcTZ0bFJVemh1dm9NU3lTYkM3OWFqTGkyak1Wb1o2R0FG?=
 =?utf-8?B?R3h0dzFSeTNoRzdFQ21mR2NKLzNUelQ0dTFTd1R1MDhyc1Zvc0JkVXVJd3Nh?=
 =?utf-8?B?bHBSeS9pOGowUHZSb2dBTy9DZmZTYkdXWnlmaUNyVUxuRnpxRE9UK1lJVk8r?=
 =?utf-8?B?YlFNS0VwMlppOGJ4RUdiTVdhQmJWTzZ5eFNRekRpSFh1S3UwTlczcWFhTlRQ?=
 =?utf-8?B?alAzMHY1MTVmUHRyMHRtSm9mLzExQVIybFdwQm5BUi9WS0dqL051RTRENmVj?=
 =?utf-8?B?WDBac1J5ME41cmwvTkdHY3lVeHBsdnhDdzVwck1abUN5SzdTaG9tWkcrMk4x?=
 =?utf-8?B?T1o0RUEvZlVwQXJZUmJ0eUVCZWRKbm55SldmUGlFSFlIZU9ORXd5bklGVzBN?=
 =?utf-8?B?VTRjTmErRjRiVzZqeDhlUkppaVVSODl0cDJWZWZUQnhHQWNwUEZqZ2QvY1ht?=
 =?utf-8?B?aFVrWFhvNTBhRDhFSWt3KzFnU3p2azJQaHdqNEY5cVBzaU9tMFpFaHlabGp2?=
 =?utf-8?B?bWVjUE1tYmNCQmt0eHRPd3diVGZhQktUaGVvVUZ5a1NhUHV5ZHQ0Tk82K3R6?=
 =?utf-8?B?cVhZOTNGM2JnZ2ZPWlFCVlQ1NStQUmliSFFRN0FJSURHS1NXTnArMnpZcVJG?=
 =?utf-8?B?UjBiVVZPNGJMc3Zzd0xDT3JWNDdkZkRkc28xd0dERzFkMVY1eDdRZ2JZZlpW?=
 =?utf-8?B?RnVSQ28ycFI3M3NjZTl3ZjZWMXpEOCtCMHFJTlFMaHAvdnZMVDdvM1Q0bk5J?=
 =?utf-8?B?SXQ5UTMxSmZSYld3RUorVlE1bzlIcVltZGNueTZzTGxJZ1ppRTRvOG93aFho?=
 =?utf-8?B?ZE1CVzN5M292bDQ0eXU1MmxQZzNTVGVrVTZwandxaXl5aXNIS3RqNnZTRGQ0?=
 =?utf-8?B?cEFYcUFHU3ZQU2t2TVZ2TnhjVXRJOTZ5OUttWkh6VFJOVU91YWh4Mzk0aDk5?=
 =?utf-8?B?aHB2VE1kOXZSY25UdjY3ZWFMdXA4V3k5OEcwV2F0NWNBZHhRZXR6R3huaHZu?=
 =?utf-8?B?VEo0YVk4aE9KSlpUNjhhL004dnF0dmxOSTVTekdEVjNtN0p4dGhYQjhWaGwv?=
 =?utf-8?B?cy9INndpNnErTXdGWnlYV1kzbWMvNnNYVGxDdnFUdWN1ZStLeDVRZmhnV3hX?=
 =?utf-8?B?cER2OUtkTTREaStPM1BlOTlRS2h5VWRYdFBKaldHR0FvcXp2SURlNVUxZWJJ?=
 =?utf-8?B?SVVkSml3djc4N2dMQ2tNaUxCamI4QmtCdVIrbnpmTGNLV1BxRlIvMkY2bE8w?=
 =?utf-8?B?ZzJsTzQ0SjNIZXdjVUxaTEZGMTQzcWtaYzZkemVzcUV1YWVIUGRwYytMRVVp?=
 =?utf-8?B?SHFxdlA5cDh0bXpQeDVSNE01TGY4WmxIM1lGRmdwd2dReTFwRk5mTDdtbUdD?=
 =?utf-8?B?eGgyeDQ1dzVwNjJZeVAwdm9mS3RyZE9JSDd3akZ1OXdWclRsbnBieFR2V0tK?=
 =?utf-8?B?WEVTR1gvOGM3eS9nNjhiM3BRczNma3cyWEtEMXRWMmh2NHZTOTdRLzJNUFF3?=
 =?utf-8?B?cENlRDh3Q0VDcUVZUnl2OGt5MlNLREp1TnpkcmR1bU9UYU51NlNOdVNCc1VW?=
 =?utf-8?B?VXU4aW13YStCV3VuZ2lkdzZKYUw5TnF6SC9sRHdPTUwyOWpLVjBFUFoxdXho?=
 =?utf-8?B?d3E4TzhUOG5pUnhXaEQ4VjJ2aXErK0dSVU1EbnNJNENLS3Z1cGsyWjVDMWVW?=
 =?utf-8?B?azVPZnAyK2UvcTh5YkJiWThvNnFQMWd6NmVleWRLQUs4cVRlc1VQQVhkUUgw?=
 =?utf-8?B?L1lUdVRQVmF5UUdVSDhQTkVIZk5kblVwNU9KemJpTXFNRHBTc25oV255K3RU?=
 =?utf-8?B?a2czQWxVSG5keFEzZU5LNVc3RXFMQ2xJeVpyY2dGUjVXV3dFdGZwdFkvZG45?=
 =?utf-8?B?ZmlSZnJNR0Ewa0plb3NBYlp5dUxDQjFJTUxRcnRZbldxVmFKYXFmbElvR1lw?=
 =?utf-8?Q?vaLf6SCH9m4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1EvUWdxWFI0RFZNd3g1WWZqWjkvVkRoUllnWGNIbVllV2JJMy9EMmdIU0Zo?=
 =?utf-8?B?WGt0R1d2eFVURW9vVUM3OUpLem92YlIxVXBjUm5HQzBmQm5vS2JPemZ5c3VX?=
 =?utf-8?B?dDhGRzkzR0NNS2tEaFFQK3BFQzNpcENaQkFWdmRCVWlHRnNnSHcwUVlLTDJl?=
 =?utf-8?B?bDlzUyt0ZjhXcExBZUJTVmY1OVVHR2NoOVZIUEFmcFJ0S2M1WG95UXViaDd2?=
 =?utf-8?B?OHVGbm1KOVlldG1JUmNYSWxZdXFkU0pBU1k3OVc3dHdqWExkQ082YVhneDlp?=
 =?utf-8?B?SE0yWjYrUzd0cG9LSkt6MW1MNVBPdGEwaTV2L0FtOUdSQ2dTZzMyaEVJcHRw?=
 =?utf-8?B?djJHS3dZdWxES1ZxVENqZlVVU0VSZytMTnRtUFpyeml0L1RoRFlFaTIvS1RC?=
 =?utf-8?B?dkJjUzVJbUx6QmgyWEl2OTJvR0RNSitxckE3QU1aUm85OXlCUHdtUVNZWTJ5?=
 =?utf-8?B?WFhMNCs3YXliUmdMRXI0M3RLeUtDeFp2QjQ5d25BWVlpKys1MmFZOUFuK1ZM?=
 =?utf-8?B?bzlrTG4wNnc2Tk80V1o3T3UyNS93UWttdWJuOGJxem93L3FWQUxQOW1tc3Ri?=
 =?utf-8?B?VHd1NVhrUHBzL1hBTXlTSXlIWlBPKzUwbHRMaVB0NlYvN3UvTnpxV24wbkN2?=
 =?utf-8?B?TVpCOUN1R1F4SlV2dU9jYWdYcmVuck1xZTNLaFl6bmRtYVpDbkJZN0lqR2Vo?=
 =?utf-8?B?RW9UWmhWY0gyNE56SFk5cndBMHdXY1NNNmp1VXNidDRlaHFBaVRCWVpGUjVl?=
 =?utf-8?B?STVSd1ZvMVRsNmN4djc5TGRzZndBWXJpOUQ2Yno5dWswT2xDNUYzZjZqQnUz?=
 =?utf-8?B?TXVEenBSaVJyL1pGb0hTU0VGOS9OZlVSRnl4ZWFkWkVraUpoTDFsMStCOUhj?=
 =?utf-8?B?MzlSWDlRUnAyT3RCNUlRclF2UkFGU3JZcEZaUkNGYytwU29GMU1QdFhWMmlZ?=
 =?utf-8?B?MndFU1RWUUlEOENOTm9kaGsvcTkvSjk0QWJtbW5RdmZGMDM5VTJDM2RsejJq?=
 =?utf-8?B?NkgrMmUxSk1KdC9nZXptMjJUb2VaNzhMdkxDRVpPbVNXalR5VGJGblhoMExp?=
 =?utf-8?B?cjNUSko3SG5tRktnMUc0eUdkMEk3VEVtRmZoYmlMdlV3YSt4a2Fla05YMHdC?=
 =?utf-8?B?TWREaTNoWjhjdFZHWGhNWG9GTUxqVjBkRGhZR0FGS29zbVQ4RzV1cTRKc1ov?=
 =?utf-8?B?TnJCMmJUYjh1d1J1Y2ZJQXRJU2tHYWYySDFacTEzT2FMT3VDdnRpdXIrMEc3?=
 =?utf-8?B?NFUxNjdBQ2RXMlJ0YzR3ejFtaHI4RXNmS1VDb1R5d3hFY21oSzNWczQvOEpw?=
 =?utf-8?B?WGRJeHNYQU5uaUxDZ084N3lVWWMzenVJbHg1U2w4Mk9sZVpaTXJQb2ZNTi91?=
 =?utf-8?B?TDZUTzdiVm1RUXlqTCtiSXRxK0lvUk53ZytQeDV0YnNQTFVWU3pKM25LNWll?=
 =?utf-8?B?T25jS044ek0vaHFpMzIzdzlaVjVicXk2bHVuUWlhUDhXd2NQaU5veUV0SWlJ?=
 =?utf-8?B?d25QY1JDeGc3RHRKSDgvejlkUFhtckV6cmM1TjU3bjgyUXA0ek9zMjduS2Fm?=
 =?utf-8?B?K1J2NDVnWFFWYi9aRXVGelZidTI3WDNTZHFTRk1HU3lpZE95STI4VXU2ZVl2?=
 =?utf-8?B?R2F1OEhNYWN2ekJDZi91ZDlQenQ4bW1QZnJEamtqbk1XVk1kUWJQNUhFM21R?=
 =?utf-8?B?dERXSnpUd1EwNGlKU3Z3V3pCeEwzRFpjTEl2YmM5L0N0NzlLSnR3WFI4a285?=
 =?utf-8?B?WVArMVNQZnIyMm9Ya01tZ1EvbFM4OFZ2YU5UcVNEUVowWTY0RVUxcWhrK1dM?=
 =?utf-8?B?MS9CRUI1U25FSklMdWpBRWsrNVFPa1R0bkIyVnl2RTVNendJUGo0S2VGWU5G?=
 =?utf-8?B?NWZEL0V0TFBodnZTajBWamZFREFFYWtQaTNiZUVFeUN5ZFpBN3BOR1RmRzRz?=
 =?utf-8?B?N1RiMWF2OWtaM2p5OTJBdUd4aFJ4MmdPaHFLWG5qbEpyNnpUMFFFUG1pWEd3?=
 =?utf-8?B?c0trQmpXellUZlJIK2QwSk1vZUNVOWUvd1c3MWd5MmNKbE5ONm5SSVVaOERR?=
 =?utf-8?B?V0w1am1KR3NGSE5CUWNIWmRrbEFEeFk3SzJ3RHoxUVB2R2tLTjh6alhONUdw?=
 =?utf-8?Q?MCoSYMAEEYzzgPSTxkWtFJsAh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c914f296-18c9-4412-aad6-08ddc5865635
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 23:04:52.1406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugUzwd1bA1H0oD27Teqysm3xMksvDMrs8uI1713D8fmZgqni7qef4w2CSoQOLxbR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5939

On 17 Jul 2025, at 18:24, Matthew Brost wrote:

> On Thu, Jul 17, 2025 at 07:53:40AM +1000, Balbir Singh wrote:
>> On 7/17/25 02:24, Matthew Brost wrote:
>>> On Wed, Jul 16, 2025 at 07:19:10AM -0400, Zi Yan wrote:
>>>> On 16 Jul 2025, at 1:34, Matthew Brost wrote:
>>>>
>>>>> On Sun, Jul 06, 2025 at 11:47:10AM +1000, Balbir Singh wrote:
>>>>>> On 7/6/25 11:34, Zi Yan wrote:
>>>>>>> On 5 Jul 2025, at 21:15, Balbir Singh wrote:
>>>>>>>
>>>>>>>> On 7/5/25 11:55, Zi Yan wrote:
>>>>>>>>> On 4 Jul 2025, at 20:58, Balbir Singh wrote:
>>>>>>>>>
>>>>>>>>>> On 7/4/25 21:24, Zi Yan wrote:
>>>>>>>>>>>
>>>>>>>>>>> s/pages/folio
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Thanks, will make the changes
>>>>>>>>>>
>>>>>>>>>>> Why name it isolated if the folio is unmapped? Isolated folios =
often mean
>>>>>>>>>>> they are removed from LRU lists. isolated here causes confusion=
.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Ack, will change the name
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>>   *
>>>>>>>>>>>>   * It calls __split_unmapped_folio() to perform uniform and n=
on-uniform split.
>>>>>>>>>>>>   * It is in charge of checking whether the split is supported=
 or not and
>>>>>>>>>>>> @@ -3800,7 +3799,7 @@ bool uniform_split_supported(struct foli=
o *folio, unsigned int new_order,
>>>>>>>>>>>>   */
>>>>>>>>>>>>  static int __folio_split(struct folio *folio, unsigned int ne=
w_order,
>>>>>>>>>>>>  		struct page *split_at, struct page *lock_at,
>>>>>>>>>>>> -		struct list_head *list, bool uniform_split)
>>>>>>>>>>>> +		struct list_head *list, bool uniform_split, bool isolated)
>>>>>>>>>>>>  {
>>>>>>>>>>>>  	struct deferred_split *ds_queue =3D get_deferred_split_queue=
(folio);
>>>>>>>>>>>>  	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
>>>>>>>>>>>> @@ -3846,14 +3845,16 @@ static int __folio_split(struct folio =
*folio, unsigned int new_order,
>>>>>>>>>>>>  		 * is taken to serialise against parallel split or collapse
>>>>>>>>>>>>  		 * operations.
>>>>>>>>>>>>  		 */
>>>>>>>>>>>> -		anon_vma =3D folio_get_anon_vma(folio);
>>>>>>>>>>>> -		if (!anon_vma) {
>>>>>>>>>>>> -			ret =3D -EBUSY;
>>>>>>>>>>>> -			goto out;
>>>>>>>>>>>> +		if (!isolated) {
>>>>>>>>>>>> +			anon_vma =3D folio_get_anon_vma(folio);
>>>>>>>>>>>> +			if (!anon_vma) {
>>>>>>>>>>>> +				ret =3D -EBUSY;
>>>>>>>>>>>> +				goto out;
>>>>>>>>>>>> +			}
>>>>>>>>>>>> +			anon_vma_lock_write(anon_vma);
>>>>>>>>>>>>  		}
>>>>>>>>>>>>  		end =3D -1;
>>>>>>>>>>>>  		mapping =3D NULL;
>>>>>>>>>>>> -		anon_vma_lock_write(anon_vma);
>>>>>>>>>>>>  	} else {
>>>>>>>>>>>>  		unsigned int min_order;
>>>>>>>>>>>>  		gfp_t gfp;
>>>>>>>>>>>> @@ -3920,7 +3921,8 @@ static int __folio_split(struct folio *f=
olio, unsigned int new_order,
>>>>>>>>>>>>  		goto out_unlock;
>>>>>>>>>>>>  	}
>>>>>>>>>>>>
>>>>>>>>>>>> -	unmap_folio(folio);
>>>>>>>>>>>> +	if (!isolated)
>>>>>>>>>>>> +		unmap_folio(folio);
>>>>>>>>>>>>
>>>>>>>>>>>>  	/* block interrupt reentry in xa_lock and spinlock */
>>>>>>>>>>>>  	local_irq_disable();
>>>>>>>>>>>> @@ -3973,14 +3975,15 @@ static int __folio_split(struct folio =
*folio, unsigned int new_order,
>>>>>>>>>>>>
>>>>>>>>>>>>  		ret =3D __split_unmapped_folio(folio, new_order,
>>>>>>>>>>>>  				split_at, lock_at, list, end, &xas, mapping,
>>>>>>>>>>>> -				uniform_split);
>>>>>>>>>>>> +				uniform_split, isolated);
>>>>>>>>>>>>  	} else {
>>>>>>>>>>>>  		spin_unlock(&ds_queue->split_queue_lock);
>>>>>>>>>>>>  fail:
>>>>>>>>>>>>  		if (mapping)
>>>>>>>>>>>>  			xas_unlock(&xas);
>>>>>>>>>>>>  		local_irq_enable();
>>>>>>>>>>>> -		remap_page(folio, folio_nr_pages(folio), 0);
>>>>>>>>>>>> +		if (!isolated)
>>>>>>>>>>>> +			remap_page(folio, folio_nr_pages(folio), 0);
>>>>>>>>>>>>  		ret =3D -EAGAIN;
>>>>>>>>>>>>  	}
>>>>>>>>>>>
>>>>>>>>>>> These "isolated" special handlings does not look good, I wonder=
 if there
>>>>>>>>>>> is a way of letting split code handle device private folios mor=
e gracefully.
>>>>>>>>>>> It also causes confusions, since why does "isolated/unmapped" f=
olios
>>>>>>>>>>> not need to unmap_page(), remap_page(), or unlock?
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> There are two reasons for going down the current code path
>>>>>>>>>
>>>>>>>>> After thinking more, I think adding isolated/unmapped is not the =
right
>>>>>>>>> way, since unmapped folio is a very generic concept. If you add i=
t,
>>>>>>>>> one can easily misuse the folio split code by first unmapping a f=
olio
>>>>>>>>> and trying to split it with unmapped =3D true. I do not think tha=
t is
>>>>>>>>> supported and your patch does not prevent that from happening in =
the future.
>>>>>>>>>
>>>>>>>>
>>>>>>>> I don't understand the misuse case you mention, I assume you mean =
someone can
>>>>>>>> get the usage wrong? The responsibility is on the caller to do the=
 right thing
>>>>>>>> if calling the API with unmapped
>>>>>>>
>>>>>>> Before your patch, there is no use case of splitting unmapped folio=
s.
>>>>>>> Your patch only adds support for device private page split, not any=
 unmapped
>>>>>>> folio split. So using a generic isolated/unmapped parameter is not =
OK.
>>>>>>>
>>>>>>
>>>>>> There is a use for splitting unmapped folios (see below)
>>>>>>
>>>>>>>>
>>>>>>>>> You should teach different parts of folio split code path to hand=
le
>>>>>>>>> device private folios properly. Details are below.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> 1. if the isolated check is not present, folio_get_anon_vma will=
 fail and cause
>>>>>>>>>>    the split routine to return with -EBUSY
>>>>>>>>>
>>>>>>>>> You do something below instead.
>>>>>>>>>
>>>>>>>>> if (!anon_vma && !folio_is_device_private(folio)) {
>>>>>>>>> 	ret =3D -EBUSY;
>>>>>>>>> 	goto out;
>>>>>>>>> } else if (anon_vma) {
>>>>>>>>> 	anon_vma_lock_write(anon_vma);
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>
>>>>>>>> folio_get_anon() cannot be called for unmapped folios. In our case=
 the page has
>>>>>>>> already been unmapped. Is there a reason why you mix anon_vma_lock=
_write with
>>>>>>>> the check for device private folios?
>>>>>>>
>>>>>>> Oh, I did not notice that anon_vma =3D folio_get_anon_vma(folio) is=
 also
>>>>>>> in if (!isolated) branch. In that case, just do
>>>>>>>
>>>>>>> if (folio_is_device_private(folio) {
>>>>>>> ...
>>>>>>> } else if (is_anon) {
>>>>>>> ...
>>>>>>> } else {
>>>>>>> ...
>>>>>>> }
>>>>>>>
>>>>>>>>
>>>>>>>>> People can know device private folio split needs a special handli=
ng.
>>>>>>>>>
>>>>>>>>> BTW, why a device private folio can also be anonymous? Does it me=
an
>>>>>>>>> if a page cache folio is migrated to device private, kernel also
>>>>>>>>> sees it as both device private and file-backed?
>>>>>>>>>
>>>>>>>>
>>>>>>>> FYI: device private folios only work with anonymous private pages,=
 hence
>>>>>>>> the name device private.
>>>>>>>
>>>>>>> OK.
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> 2. Going through unmap_page(), remap_page() causes a full page t=
able walk, which
>>>>>>>>>>    the migrate_device API has already just done as a part of the=
 migration. The
>>>>>>>>>>    entries under consideration are already migration entries in =
this case.
>>>>>>>>>>    This is wasteful and in some case unexpected.
>>>>>>>>>
>>>>>>>>> unmap_folio() already adds TTU_SPLIT_HUGE_PMD to try to split
>>>>>>>>> PMD mapping, which you did in migrate_vma_split_pages(). You prob=
ably
>>>>>>>>> can teach either try_to_migrate() or try_to_unmap() to just split
>>>>>>>>> device private PMD mapping. Or if that is not preferred,
>>>>>>>>> you can simply call split_huge_pmd_address() when unmap_folio()
>>>>>>>>> sees a device private folio.
>>>>>>>>>
>>>>>>>>> For remap_page(), you can simply return for device private folios
>>>>>>>>> like it is currently doing for non anonymous folios.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Doing a full rmap walk does not make sense with unmap_folio() and
>>>>>>>> remap_folio(), because
>>>>>>>>
>>>>>>>> 1. We need to do a page table walk/rmap walk again
>>>>>>>> 2. We'll need special handling of migration <-> migration entries
>>>>>>>>    in the rmap handling (set/remove migration ptes)
>>>>>>>> 3. In this context, the code is already in the middle of migration=
,
>>>>>>>>    so trying to do that again does not make sense.
>>>>>>>
>>>>>>> Why doing split in the middle of migration? Existing split code
>>>>>>> assumes to-be-split folios are mapped.
>>>>>>>
>>>>>>> What prevents doing split before migration?
>>>>>>>
>>>>>>
>>>>>> The code does do a split prior to migration if THP selection fails
>>>>>>
>>>>>> Please see https://lore.kernel.org/lkml/20250703233511.2028395-5-bal=
birs@nvidia.com/
>>>>>> and the fallback part which calls split_folio()
>>>>>>
>>>>>> But the case under consideration is special since the device needs t=
o allocate
>>>>>> corresponding pfn's as well. The changelog mentions it:
>>>>>>
>>>>>> "The common case that arises is that after setup, during migrate
>>>>>> the destination might not be able to allocate MIGRATE_PFN_COMPOUND
>>>>>> pages."
>>>>>>
>>>>>> I can expand on it, because migrate_vma() is a multi-phase operation
>>>>>>
>>>>>> 1. migrate_vma_setup()
>>>>>> 2. migrate_vma_pages()
>>>>>> 3. migrate_vma_finalize()
>>>>>>
>>>>>> It can so happen that when we get the destination pfn's allocated th=
e destination
>>>>>> might not be able to allocate a large page, so we do the split in mi=
grate_vma_pages().
>>>>>>
>>>>>> The pages have been unmapped and collected in migrate_vma_setup()
>>>>>>
>>>>>> The next patch in the series 9/12 (https://lore.kernel.org/lkml/2025=
0703233511.2028395-10-balbirs@nvidia.com/)
>>>>>> tests the split and emulates a failure on the device side to allocat=
e large pages
>>>>>> and tests it in 10/12 (https://lore.kernel.org/lkml/20250703233511.2=
028395-11-balbirs@nvidia.com/)
>>>>>>
>>>>>
>>>>> Another use case I=E2=80=99ve seen is when a previously allocated hig=
h-order
>>>>> folio, now in the free memory pool, is reallocated as a lower-order
>>>>> page. For example, a 2MB fault allocates a folio, the memory is later
>>>>
>>>> That is different. If the high-order folio is free, it should be split
>>>> using split_page() from mm/page_alloc.c.
>>>>
>>>
>>> Ah, ok. Let me see if that works - it would easier.
>>>
>
> This suggestion quickly blows up as PageCompound is true and page_count
> here is zero.

OK, your folio has PageCompound set. Then you will need __split_unmapped_fo=
io().

>
>>>>> freed, and then a 4KB fault reuses a page from that previously alloca=
ted
>>>>> folio. This will be actually quite common in Xe / GPU SVM. In such
>>>>> cases, the folio in an unmapped state needs to be split. I=E2=80=99d =
suggest a
>>>>
>>>> This folio is unused, so ->flags, ->mapping, and etc. are not set,
>>>> __split_unmapped_folio() is not for it, unless you mean free folio
>>>> differently.
>>>>
>>>
>>> This is right, those fields should be clear.
>>>
>>> Thanks for the tip.
>>>
>> I was hoping to reuse __split_folio_to_order() at some point in the futu=
re
>> to split the backing pages in the driver, but it is not an immediate pri=
ority
>>
>
> I think we need something for the scenario I describe here. I was to
> make __split_huge_page_to_list_to_order with a couple of hacks but it
> almostly certainig not right as Zi pointed out.
>
> New to the MM stuff, but play around with this a bit and see if I can
> come up with something that will work here.

Can you try to write a new split_page function with __split_unmapped_folio(=
)?
Since based on your description, your folio is not mapped.


Best Regards,
Yan, Zi

