Return-Path: <linux-kernel+bounces-720870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8EDAFC183
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 05:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B61C04A45DD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3081B3925;
	Tue,  8 Jul 2025 03:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bh5p5qE1"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348FE101FF
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 03:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751945506; cv=fail; b=HXfWMzqFDcERIWy6/uv9kR1v6jztX8bgLu3IXrOFreZpMfzykjCwGbNs97xXjqhxF5HQdEqjFtfobYm17UvaJn3A0tzVFxaqjEIMX6SjeGkCPEzVgAgnkj0IgNnnBQCeNa967TWw2MAAvrCBg/D1I4O7BM+hvYAuMR6D0eZVDE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751945506; c=relaxed/simple;
	bh=9Vn2qw6LDm27lzgAB4E+8s2LuUvZgUYSPF+JWfht8eg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rqz8p96kbPt0v+UD/apwCAeIo8n++KFxd6WXur+e2EhzE57W+aKmiS1MnuOoZmxGxomCmo71M/Fx1doqLw5+orKAw/xXL11OW6SYFGCMvYBY2hePe9BTwLAdWfLMXgBWx0AhEQJkfillsGyMIS5jNfGGcXB2MW3WT7+vPH31QSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bh5p5qE1; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMWa6vpk9OXz5S36P7BtWW/piQm0e+p3+8MarzE8v0ZKTXDKu+96zYtWu4lBMSp0aUCJsR9YMgLXBL6O+U9kwEe8Hi0uColTcr+2aYUB/dN8yQU/UZtIA0XQiK+jY8CHr2bbXpnYZPOjBktJk127vSL+MP/TRAoBAcnUbFYovDB+otEo2jCvu/YddKGF/qGaMHuWw1NXKuT+YfOebMQYoKFAFdNRnybAQPeq0rNltSb+J+cdODIxP4Rufh3kxuVMuxnHOS7tIL0UWosyJDTnLtajcg1uJ8t7vF6K2Zd8oW73Jm3RClOSFwZFVjUIF3BMX+/BL3Ki/WrF+4qv8GjCqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nehk1c4/gpPS9hZlIuDkOWl52z6HxaNvNmQStIL9quI=;
 b=sHxQH8X08iqapVa0SHxBCtd1GEPWgTAzz6PNDXS2VrKJk7gfQHJaSMK0G31svLNY4mwSFKEpuMB6FB2AkJOzABbKk7Cf38Z99FjYTtvflfqeg5OUQZaiQ2IeQD0wGdhse/HBKN9Jekl6NE0YmWC9PcnXFDwVHJK1aG7swHe6K1BzB9hJn/YH+soUdjI6ZO2TngVdUZkbUHl2m+DCa84UBQKAlFgCSd37TEzsEsDckFtUvr/jwpcJxoVGFje1WW+UPwX9PkUlSl6XtSqCrMWhgjICKxuYBt5tP3OMfRnH6nkN4fP/6JwswTtVr0XebU2tXxOX84hZzdp+WBPd5ADZEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nehk1c4/gpPS9hZlIuDkOWl52z6HxaNvNmQStIL9quI=;
 b=Bh5p5qE1EHJcwDGL7HmdE5DjNMcw+NaCVJqPATIAKx6DUL+ZCHkVmdRDnmtjqGvQO3oHNMMpZF8HFz728wK9bmmss0HxvO9spuQNjl9EWfOmKw38536mtztoYpjqURjLlIXrfwQNr2WD1RyETyNQdAkd5tDWUOdVkrWuhmV/Gb4yvtE3stZORBPin1xYM5xoVm0auwVVKDP/tmF95ZXaFo1cjlpgKgMf5ELj6mEh5t3Jf8nIw9EO+gSVf6iQwvqTs+mJZUEl3+TjS5L8KfPxdxzZKN59YVw3Q7MDPL6bMvRV/yRpnRbqOyfTAvq7pjGVDIkVi8T7VAKr6afX/i6roA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by CY3PR12MB9580.namprd12.prod.outlook.com (2603:10b6:930:10a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 03:31:37 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%4]) with mapi id 15.20.8901.021; Tue, 8 Jul 2025
 03:31:36 +0000
Message-ID: <c741a198-74b4-4412-bca9-91a8e730f11f@nvidia.com>
Date: Tue, 8 Jul 2025 13:31:29 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [v1 resend 08/12] mm/thp: add split during migration support
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
 Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Jane Chu <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
 Donet Tom <donettom@linux.ibm.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <20250703233511.2028395-9-balbirs@nvidia.com>
 <D129A3F2-D79C-482E-BC70-A26C781B149E@nvidia.com>
 <1a451d37-56c3-4d60-8e06-3abae72e6bbd@nvidia.com>
 <007E2728-5BFC-40F9-8B8F-25504863D217@nvidia.com>
 <aa4f94a3-f601-4379-b6ca-4389421ccca4@nvidia.com>
 <906590D4-04E2-40CB-A853-25FE6212700C@nvidia.com>
 <eab52820-813f-4137-b664-c79ba8b453b7@nvidia.com>
 <2BC37A17-1005-4016-B4D8-85832F75C500@nvidia.com>
 <94D8C1A4-780C-4BEC-A336-7D3613B54845@nvidia.com>
 <0d1e51f3-ccea-4255-9c5f-68e5a41da03c@nvidia.com>
 <660F3BCC-0360-458F-BFF5-92C797E165CC@nvidia.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <660F3BCC-0360-458F-BFF5-92C797E165CC@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::14) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|CY3PR12MB9580:EE_
X-MS-Office365-Filtering-Correlation-Id: 444f449a-e395-42b7-ad69-08ddbdcff173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEx2VXlGNjRSbmtMTnFnQjNTZnFmZi9Pc2loYzVjaDI1Skc2aDN5NDlLOHZ5?=
 =?utf-8?B?Njd6dndvZzB1NTBXd2ZGbnU4aEpQZmk3QkIxQWpLenE5L3luUGRLZlE4MlRX?=
 =?utf-8?B?R3ZjaW5CSldsRmJKcjNraHQ0VVNGUGZZcFF1Zy9uSjZHdWRhZGRKNjBRcTYz?=
 =?utf-8?B?UzVIS3NWczZOblRMM0Ezczl3emxNR3JsQ20wZXV5NDhWSjBtS2RrMmQ5Uksw?=
 =?utf-8?B?MXJWWkVGOEs0RUlMVTdscytvZ3ZTRG5wVWl4eVViZmdhdHh0a1JvNzY1cGpN?=
 =?utf-8?B?djN4SzdmWFlEL2FENDRHKzdYZ2U3ZXRienFEK0xNd0JaTUt6a3RwQjkvZ2x4?=
 =?utf-8?B?eUNRbkh4QkRlOWxqTHQxTm52ZmVWcHJxbnNyd0lhVjJOc2JPVU9RMnFwSUJa?=
 =?utf-8?B?ZmdnMktQZzREcDJOVEh2Uzl2c3NaWGxSYjIya3FkUDl1QVRvMzc5VG5TMVVo?=
 =?utf-8?B?aWRQTVVPd3VEZFUzV3dTeDZIMHJHQkdsUGtRUzIrYTBmMm5NeUVZN0dnQ2V6?=
 =?utf-8?B?c3ByOHB6NGVNWC9qcWR6UG1HRDBQejd1VU8xcmtuMmd6SE5qUHZmckZDcnNi?=
 =?utf-8?B?K3pkbGZaV3dlRklQanVvVE1rNVFjZ2g0UEFtZENsdm4rbTE2SytiUGFGTWZF?=
 =?utf-8?B?UklxQTYvNThKcEloVUREM3pSQThyaXM4Zk5lWXp1MEtHUk5yU1Jac1VGZnM5?=
 =?utf-8?B?N1pIQWNVVC9qWEVIazBuSk9WTlRDdlBrbVBPYzFwZWRmVzF6dld3Z1hib3dW?=
 =?utf-8?B?SjVHNXUyd1dEMC9SaDJqUmxscHl5NkVqOVR2UzlWNitEZEJrNXN1VG9wQjVx?=
 =?utf-8?B?WVNkU2JoLzFIY20vYUs1Slo2RmZranVwTG1qZUpyS29DeDlwY1pOSW4yaUxj?=
 =?utf-8?B?UHF6MnpUSEZaa1dnWW9jWnhFQW00V1pzSGNNa3RkMmtEa0NiYTk4cjdDNndQ?=
 =?utf-8?B?ajYxTGd0TURwWUxzUWVkclNHTHY2L2hENzFVSXk5U0RlcGNqVmlKY1BuNnNR?=
 =?utf-8?B?eXRrM2dlWXptSm9BU0lzK3dieU4rYml4RHRvNGV1bDdpMDJZT01wVnVER2pn?=
 =?utf-8?B?enF6SVpoODc3NXROcDBXaDFGNHMvT3hJOEg2M05VOHpSUm43WXR4Tm12YmRL?=
 =?utf-8?B?bm0wQm1ERllJRm9NMGVSQlNoQjJTTEljdk14cEhjV21nZS9uQ1RXN1l6dHU4?=
 =?utf-8?B?a0t1Z1E5dFdLd2ZpNWlpTXNnWUtMZUZDeTNRVUxYRWNBYnZ6VVBFYktSSEVx?=
 =?utf-8?B?SDNzZjE3WlFjQjFad25zSWFtejdDN25ZR3p0UmVKR2R2ZWJsZzc3alN5Z1pO?=
 =?utf-8?B?M3dXcE1FU2hCU0ZQTGlNRmgyMFJPcTBCOGY1dFh6eVpmOVpzRk1hZzl6VVhu?=
 =?utf-8?B?ZkMvTXdFMUtzTHp3RURGdDlKOE5vMXNRdFBQTUhtSjZKL2tyTkltRlQ0azg1?=
 =?utf-8?B?VUxIQ1EvSUphb2dGSUdmMXhzakYvRUE5ZHAxaUJHempGYnN2MmJpbTRraGMw?=
 =?utf-8?B?c3duV1g5MTBreUMvNGlqQkZpYklpOC9TVWdwY3crOGphemNodG94YkJtYnpz?=
 =?utf-8?B?ZjBqMHIwTVluN3dKUE1ocVZkZEdaOURWQUI0VUhQakRvTWFQUXlNS0p6L2Nk?=
 =?utf-8?B?S01oMXU2ajdwS0VYNkdCUmhEaVByMTlUQUtaUkRtRnA3dFArSitHd0syTDB1?=
 =?utf-8?B?RWRlWm9Vc1dBeUh1NlRsNHJycVNONkUwWWZ0SnBxTUhHb2w2Zzg4cFJvdUJP?=
 =?utf-8?B?MjhIS1hVZmkrVjR4bkV3cXY4V2NHZ1B0eG5TdklMR1JSdVhKVTRvbHBGenRY?=
 =?utf-8?B?dWlYMWVUVXJtekU1ZVVNU3hkTTE5L1g2V1VoRzV0NUFEVGRHeW5GUUZuR1VZ?=
 =?utf-8?B?QU9yc09ZU2o1eXltVld2bzNCUmZIMXQxOXFNZzVmMS9tYW9iK2RsWUp5QlEy?=
 =?utf-8?Q?3jmkZ0MRO8c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmhPakJ5M05RWXNPNE44R2FjRElwZVlwRWp6NFQvbGdmT1dqekg5cjJqYWtF?=
 =?utf-8?B?KzUxbkcvbHVsYTlTM0UwdkYvWHF3UXlpNHZpWU9wQkJtRjVjMXNyYzhHbVhR?=
 =?utf-8?B?Ymh6YmVaSFZ0RmU3QkUzV1pEaUtoRUdBVkRNYjNieXVQWGViUjRmaCtLK2dL?=
 =?utf-8?B?SGpsRkpONjh5ZmlYb3BsU2ZiREtGQVJsRHQ5T1ZwOHR5UzZsSEMwV1REWnV4?=
 =?utf-8?B?VU1hczExWGRmNTMvaG1meERyZnpGTnpCeXpjY2hHbnBYOHRYY2ZrbjhpV3pU?=
 =?utf-8?B?UmcxK0pwN1ZUTyt0MmhXMXJkcVZEY2Y5LzRqU0VzZEdEbkdKS1dock5jY3l5?=
 =?utf-8?B?TXhiMXFwK1BXaUQ1eU03bE5pYWYvaEJNZnJzazFSdDF0cVJIVjlZUVJBa3hR?=
 =?utf-8?B?ZFROUkROMGp1YmtNTXF5ZnA0K0RHcHYrRnZaL2U2S0pheXBXbUcvV0NHc1c2?=
 =?utf-8?B?Q29uQkVKRFpYVkNQQmtpRVl2d1lGNkgzZ2grN2ljemtCbFBIejA1cWh5NEdL?=
 =?utf-8?B?RFAxTzMzVUR6aExaMlJYWGdGUHM0Nkk5RDVQdzVyZjFqa2hldWdkM3RJOU5h?=
 =?utf-8?B?RTdQUUhmRVJodnd2d1FsWDQ3dVVRVXQ3b0RXOElYRjQwcWxiQ1JWKzNoWFdF?=
 =?utf-8?B?OGJVYkgweElWWUxjS254WG90b0psUVRaaHJOeGV1Z1cxVnlkajFpaGFYWVZn?=
 =?utf-8?B?NFJHOVptdzRTN3k4d3IvN3FDN09rQXJzMXVJR3d0bklOYWN6Vlhsdk43NkZl?=
 =?utf-8?B?TGdCbUt4Rkl2eUdWVzBlT2FobDFVdnBBbFZycGlMMG5xU0R3QlZNeWJOcFFE?=
 =?utf-8?B?YXhENWV6SzdZY3ZKMm0xcHVVMmRGc1hkQ3BoZHlkS3NsS2QrZTdtb3lVaGUv?=
 =?utf-8?B?aDI4UmJvaWdHU0tlT3dZc3RPSGVVQjNFdVBpV0VERFdoaTFkVnlaYjZ4RmI4?=
 =?utf-8?B?aHE5andWTnoxd1VXLzEweHZOLy9Tb0RVdCtaZXhqckIyendUNWk5QXJYZ3ZK?=
 =?utf-8?B?K2syaXBBeERydGczS2NjRE5DeHRDbHdIbXNWTjRML2NMS3ltTE1QT0hGSWdS?=
 =?utf-8?B?MmFDODJlUjEzbkUzODVnek9BK3lwT2E2WkQwQ3hsMW0zdHZ3Y0J3WStXejMy?=
 =?utf-8?B?aHZ4cTVRbG9PRXZNOFVpK3g0S0ZPY2xEcWZsaStwMGN3ZzBwQVEzMzB1S0xo?=
 =?utf-8?B?VTFVdkpGZjhkYVkyU2VnNUkwRTViKzJkRVJnT0htV3dYSnVZU0ZKL1lRU3I1?=
 =?utf-8?B?NlZrZVdmTHNLTHY0WFplVnhTVC84b0JGcDRsSHhjUXc1Y0FKcjNYWnBneUVt?=
 =?utf-8?B?NE1raUFybmtwRkpIcmdTeHRwbkFjTnRVL1ZRQi93TnZ4eEJ3ajFJc2g5WkJ5?=
 =?utf-8?B?MEtXdlJIS2ZDUTc0ektzdHRYL0ZBdDM0V0w4ZTJVd3lNYWN3REhsV1BXMjFs?=
 =?utf-8?B?OHhBVTJYa3pPT2JNMGZPMm14SkV6aytvcFNrZHZXc3dUa1VxWXlYSWgxR2tm?=
 =?utf-8?B?VnRPb3BLVUVkMCtkK01MKzJUcHJxa3loRmg5NGJBNjdVMUtRWmpPSFRDS3R4?=
 =?utf-8?B?dDlKa0pkYjRpd09vM2JScW02cGJzNkhwcVFJZXpyM05iYjVvNXkxdG41NGRt?=
 =?utf-8?B?ZVpvZ3R6OGk0cFgvN01aV2JBU3Y0Um9yUGI5eXhNVlh3NDRCbkNRQ0NiTEVP?=
 =?utf-8?B?OHFaT0pySFAxVEwyMnBpWHZqSTFWNDJWUFNjN1d3V1p4L1grVTNTZVA2cms0?=
 =?utf-8?B?RjM4VllRM2ZlT1FadmxMcmt4Z1d3RGpvcm1CWWlhT0hNSExxSlowdGlEdnNi?=
 =?utf-8?B?Y0ZHUzFobHVqSUk0Y2pVMnFVMXFtZ3B3RFhOVTlFZU1yMmhGUTk5cForcjJS?=
 =?utf-8?B?SG1FU2ZsTFk1OWdLa0E5VHBoa0pqRnQ1QU5xMzNSYXk1OCtiZldvZDk2ejhP?=
 =?utf-8?B?Z3l1RkJkMXMyRm56ekVHMnp4Z0hKZzFTWDR0QUx6b0I4ZytFY3ZuMzZyZ2Ra?=
 =?utf-8?B?S29BcXhEbEd1cWt0RkVFUnNmclg0R24yOWw2dGd0Q0JDYjJMcjJvWld1eHpN?=
 =?utf-8?B?dGZLMXhuUy92Ti9PdEIzVzFqN2dZK05VV2dMWDQyWEpVKzh2bkxsd1NYaFp4?=
 =?utf-8?Q?sSdahhdv6iMIisJswZT+wkvC1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 444f449a-e395-42b7-ad69-08ddbdcff173
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 03:31:36.5784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7rV9VcCOJXYYI108jKZrYi/Ed3hXJ6lQHC5Zx1T3aGNJGHA6BEEvRRMC63dE3/DpElQ3pDV1bGZ/fXKbm4Txg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9580

On 7/7/25 12:45, Zi Yan wrote:
> On 6 Jul 2025, at 22:29, Balbir Singh wrote:
> 
>> On 7/6/25 13:03, Zi Yan wrote:
>>> On 5 Jul 2025, at 22:34, Zi Yan wrote:
>>>
>>>> On 5 Jul 2025, at 21:47, Balbir Singh wrote:
>>>>
>>>>> On 7/6/25 11:34, Zi Yan wrote:
>>>>>> On 5 Jul 2025, at 21:15, Balbir Singh wrote:
>>>>>>
>>>>>>> On 7/5/25 11:55, Zi Yan wrote:
>>>>>>>> On 4 Jul 2025, at 20:58, Balbir Singh wrote:
>>>>>>>>
>>>>>>>>> On 7/4/25 21:24, Zi Yan wrote:
>>>>>>>>>>
>>>>>>>>>> s/pages/folio
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Thanks, will make the changes
>>>>>>>>>
>>>>>>>>>> Why name it isolated if the folio is unmapped? Isolated folios often mean
>>>>>>>>>> they are removed from LRU lists. isolated here causes confusion.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Ack, will change the name
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>>   *
>>>>>>>>>>>   * It calls __split_unmapped_folio() to perform uniform and non-uniform split.
>>>>>>>>>>>   * It is in charge of checking whether the split is supported or not and
>>>>>>>>>>> @@ -3800,7 +3799,7 @@ bool uniform_split_supported(struct folio *folio, unsigned int new_order,
>>>>>>>>>>>   */
>>>>>>>>>>>  static int __folio_split(struct folio *folio, unsigned int new_order,
>>>>>>>>>>>  		struct page *split_at, struct page *lock_at,
>>>>>>>>>>> -		struct list_head *list, bool uniform_split)
>>>>>>>>>>> +		struct list_head *list, bool uniform_split, bool isolated)
>>>>>>>>>>>  {
>>>>>>>>>>>  	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
>>>>>>>>>>>  	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
>>>>>>>>>>> @@ -3846,14 +3845,16 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>>>>>>>>>>>  		 * is taken to serialise against parallel split or collapse
>>>>>>>>>>>  		 * operations.
>>>>>>>>>>>  		 */
>>>>>>>>>>> -		anon_vma = folio_get_anon_vma(folio);
>>>>>>>>>>> -		if (!anon_vma) {
>>>>>>>>>>> -			ret = -EBUSY;
>>>>>>>>>>> -			goto out;
>>>>>>>>>>> +		if (!isolated) {
>>>>>>>>>>> +			anon_vma = folio_get_anon_vma(folio);
>>>>>>>>>>> +			if (!anon_vma) {
>>>>>>>>>>> +				ret = -EBUSY;
>>>>>>>>>>> +				goto out;
>>>>>>>>>>> +			}
>>>>>>>>>>> +			anon_vma_lock_write(anon_vma);
>>>>>>>>>>>  		}
>>>>>>>>>>>  		end = -1;
>>>>>>>>>>>  		mapping = NULL;
>>>>>>>>>>> -		anon_vma_lock_write(anon_vma);
>>>>>>>>>>>  	} else {
>>>>>>>>>>>  		unsigned int min_order;
>>>>>>>>>>>  		gfp_t gfp;
>>>>>>>>>>> @@ -3920,7 +3921,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>>>>>>>>>>>  		goto out_unlock;
>>>>>>>>>>>  	}
>>>>>>>>>>>
>>>>>>>>>>> -	unmap_folio(folio);
>>>>>>>>>>> +	if (!isolated)
>>>>>>>>>>> +		unmap_folio(folio);
>>>>>>>>>>>
>>>>>>>>>>>  	/* block interrupt reentry in xa_lock and spinlock */
>>>>>>>>>>>  	local_irq_disable();
>>>>>>>>>>> @@ -3973,14 +3975,15 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>>>>>>>>>>>
>>>>>>>>>>>  		ret = __split_unmapped_folio(folio, new_order,
>>>>>>>>>>>  				split_at, lock_at, list, end, &xas, mapping,
>>>>>>>>>>> -				uniform_split);
>>>>>>>>>>> +				uniform_split, isolated);
>>>>>>>>>>>  	} else {
>>>>>>>>>>>  		spin_unlock(&ds_queue->split_queue_lock);
>>>>>>>>>>>  fail:
>>>>>>>>>>>  		if (mapping)
>>>>>>>>>>>  			xas_unlock(&xas);
>>>>>>>>>>>  		local_irq_enable();
>>>>>>>>>>> -		remap_page(folio, folio_nr_pages(folio), 0);
>>>>>>>>>>> +		if (!isolated)
>>>>>>>>>>> +			remap_page(folio, folio_nr_pages(folio), 0);
>>>>>>>>>>>  		ret = -EAGAIN;
>>>>>>>>>>>  	}
>>>>>>>>>>
>>>>>>>>>> These "isolated" special handlings does not look good, I wonder if there
>>>>>>>>>> is a way of letting split code handle device private folios more gracefully.
>>>>>>>>>> It also causes confusions, since why does "isolated/unmapped" folios
>>>>>>>>>> not need to unmap_page(), remap_page(), or unlock?
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> There are two reasons for going down the current code path
>>>>>>>>
>>>>>>>> After thinking more, I think adding isolated/unmapped is not the right
>>>>>>>> way, since unmapped folio is a very generic concept. If you add it,
>>>>>>>> one can easily misuse the folio split code by first unmapping a folio
>>>>>>>> and trying to split it with unmapped = true. I do not think that is
>>>>>>>> supported and your patch does not prevent that from happening in the future.
>>>>>>>>
>>>>>>>
>>>>>>> I don't understand the misuse case you mention, I assume you mean someone can
>>>>>>> get the usage wrong? The responsibility is on the caller to do the right thing
>>>>>>> if calling the API with unmapped
>>>>>>
>>>>>> Before your patch, there is no use case of splitting unmapped folios.
>>>>>> Your patch only adds support for device private page split, not any unmapped
>>>>>> folio split. So using a generic isolated/unmapped parameter is not OK.
>>>>>>
>>>>>
>>>>> There is a use for splitting unmapped folios (see below)
>>>>>
>>>>>>>
>>>>>>>> You should teach different parts of folio split code path to handle
>>>>>>>> device private folios properly. Details are below.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> 1. if the isolated check is not present, folio_get_anon_vma will fail and cause
>>>>>>>>>    the split routine to return with -EBUSY
>>>>>>>>
>>>>>>>> You do something below instead.
>>>>>>>>
>>>>>>>> if (!anon_vma && !folio_is_device_private(folio)) {
>>>>>>>> 	ret = -EBUSY;
>>>>>>>> 	goto out;
>>>>>>>> } else if (anon_vma) {
>>>>>>>> 	anon_vma_lock_write(anon_vma);
>>>>>>>> }
>>>>>>>>
>>>>>>>
>>>>>>> folio_get_anon() cannot be called for unmapped folios. In our case the page has
>>>>>>> already been unmapped. Is there a reason why you mix anon_vma_lock_write with
>>>>>>> the check for device private folios?
>>>>>>
>>>>>> Oh, I did not notice that anon_vma = folio_get_anon_vma(folio) is also
>>>>>> in if (!isolated) branch. In that case, just do
>>>>>>
>>>>>> if (folio_is_device_private(folio) {
>>>>>> ...
>>>>>> } else if (is_anon) {
>>>>>> ...
>>>>>> } else {
>>>>>> ...
>>>>>> }
>>>>>>
>>>>>>>
>>>>>>>> People can know device private folio split needs a special handling.
>>>>>>>>
>>>>>>>> BTW, why a device private folio can also be anonymous? Does it mean
>>>>>>>> if a page cache folio is migrated to device private, kernel also
>>>>>>>> sees it as both device private and file-backed?
>>>>>>>>
>>>>>>>
>>>>>>> FYI: device private folios only work with anonymous private pages, hence
>>>>>>> the name device private.
>>>>>>
>>>>>> OK.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>> 2. Going through unmap_page(), remap_page() causes a full page table walk, which
>>>>>>>>>    the migrate_device API has already just done as a part of the migration. The
>>>>>>>>>    entries under consideration are already migration entries in this case.
>>>>>>>>>    This is wasteful and in some case unexpected.
>>>>>>>>
>>>>>>>> unmap_folio() already adds TTU_SPLIT_HUGE_PMD to try to split
>>>>>>>> PMD mapping, which you did in migrate_vma_split_pages(). You probably
>>>>>>>> can teach either try_to_migrate() or try_to_unmap() to just split
>>>>>>>> device private PMD mapping. Or if that is not preferred,
>>>>>>>> you can simply call split_huge_pmd_address() when unmap_folio()
>>>>>>>> sees a device private folio.
>>>>>>>>
>>>>>>>> For remap_page(), you can simply return for device private folios
>>>>>>>> like it is currently doing for non anonymous folios.
>>>>>>>>
>>>>>>>
>>>>>>> Doing a full rmap walk does not make sense with unmap_folio() and
>>>>>>> remap_folio(), because
>>>>>>>
>>>>>>> 1. We need to do a page table walk/rmap walk again
>>>>>>> 2. We'll need special handling of migration <-> migration entries
>>>>>>>    in the rmap handling (set/remove migration ptes)
>>>>>>> 3. In this context, the code is already in the middle of migration,
>>>>>>>    so trying to do that again does not make sense.
>>>>>>
>>>>>> Why doing split in the middle of migration? Existing split code
>>>>>> assumes to-be-split folios are mapped.
>>>>>>
>>>>>> What prevents doing split before migration?
>>>>>>
>>>>>
>>>>> The code does do a split prior to migration if THP selection fails
>>>>>
>>>>> Please see https://lore.kernel.org/lkml/20250703233511.2028395-5-balbirs@nvidia.com/
>>>>> and the fallback part which calls split_folio()
>>>>
>>>> So this split is done when the folio in system memory is mapped.
>>>>
>>>>>
>>>>> But the case under consideration is special since the device needs to allocate
>>>>> corresponding pfn's as well. The changelog mentions it:
>>>>>
>>>>> "The common case that arises is that after setup, during migrate
>>>>> the destination might not be able to allocate MIGRATE_PFN_COMPOUND
>>>>> pages."
>>>>>
>>>>> I can expand on it, because migrate_vma() is a multi-phase operation
>>>>>
>>>>> 1. migrate_vma_setup()
>>>>> 2. migrate_vma_pages()
>>>>> 3. migrate_vma_finalize()
>>>>>
>>>>> It can so happen that when we get the destination pfn's allocated the destination
>>>>> might not be able to allocate a large page, so we do the split in migrate_vma_pages().
>>>>>
>>>>> The pages have been unmapped and collected in migrate_vma_setup()
>>>>
>>>> So these unmapped folios are system memory folios? I thought they are
>>>> large device private folios.
>>>>
>>>> OK. It sounds like splitting unmapped folios is really needed. I think
>>>> it is better to make a new split_unmapped_folio() function
>>>> by reusing __split_unmapped_folio(), since __folio_split() assumes
>>>> the input folio is mapped.
>>>
>>> And to make __split_unmapped_folio()'s functionality match its name,
>>> I will later refactor it. At least move local_irq_enable(), remap_page(),
>>> and folio_unlocks out of it. I will think about how to deal with
>>> lru_add_split_folio(). The goal is to remove the to-be-added "unmapped"
>>> parameter from __split_unmapped_folio().
>>>
>>
>> That sounds like a plan, it seems like there needs to be a finish phase of
>> the split and it does not belong to __split_unmapped_folio(). I would propose
>> that we rename "isolated" to "folio_is_migrating" and then your cleanups can
>> follow? Once your cleanups come in, we won't need to pass the parameter to
>> __split_unmapped_folio().
> 
> Sure.
> 
> The patch below should work. It only passed mm selftests and I am planning
> to do more. If you are brave enough, you can give it a try and use
> __split_unmapped_folio() from it.
> 
> From e594924d689bef740c38d93c7c1653f31bd5ae83 Mon Sep 17 00:00:00 2001
> From: Zi Yan <ziy@nvidia.com>
> Date: Sun, 6 Jul 2025 22:40:53 -0400
> Subject: [PATCH] mm/huge_memory: move epilogue code out of
>  __split_unmapped_folio()
> 
> The code is not related to splitting unmapped folio operations. Move
> it out, so that __split_unmapped_folio() only do split works on unmapped
> folios.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
> 

The patch fails to apply for me, let me try and rebase it on top of this series

Balbir

