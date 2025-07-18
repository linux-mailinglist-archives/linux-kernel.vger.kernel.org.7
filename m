Return-Path: <linux-kernel+bounces-736124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B448B0991E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6A24E7AA4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 01:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250FE175D53;
	Fri, 18 Jul 2025 01:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o/qlrNJq"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3D6171CD
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 01:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752801914; cv=fail; b=VPm0XzePCFDFKoKeCbuLNogwHyxXj7hUH6heCm1IDyMuEruN7fylGad2sLh8UG+Bc4mtwNVaGZfbrF8UQeiu3ZlIoRtGnEIhQ+V+yKdfP3eL9bp8esYOl0cQ8PWi4SF1vz0V/0NEq++l9DrWP4mswUoOreOj7SzkwVvU1u6hm0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752801914; c=relaxed/simple;
	bh=9cUOntiyJUd2E9YHae5zfTzQVHQ4yD22YMqrZRS50og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QHy1KIxzN+QxLh8r4eLNq6BLv9pkDyQaRlkYSEMNIfw8pVqc4qoqSWr33oODD0vuLk5AdTB/MJlBaAvc/aC8tfQ1ONl7nkQTkskkh1IWJQs/iT+R7yuGoNIj7W/lWK6pwZtSIkpI25WVs72k4DZD0FAQv6laATxRWcjXaQzb9NQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o/qlrNJq; arc=fail smtp.client-ip=40.107.100.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1xfzMyNAF2ZCgWrkp0YA4VEKmGkzqaXqyzyJeCftg6gqu7L0IMCF2HxaDbt/7HN6yEvAiXykhpGTLUEtbAC4VY/b2P2+IFM0xZVU3ADLKAnnmaYXOS9NTEcZXk1mbn2cWM0BDiLKtHRBN7Tks8IYcx2fx3l1LujQhbOfVJ6wReYo+GfprxjDzLd0EazJfHQTFeteDT69xMEVe7sJUE/QY5kMalcJ/1PUF7xzaZjMzfcdlAnyKeT7ohr7hc3NcBOV8JxzwFJ0ytQn6tI5rVsM43JIaOca5nJ0czhLe6OICj4a+2b9Gcm98sjWY7l9fKjBdM1GP2KmtUbJh48SSc4aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zkRGKpsKrnyxVx+K2hP1V4+ALa8l6Kpw4U7klPxOuQ=;
 b=hDPFu6a5WF+fJciYBkwrbzXc1LFD3cKutmhBQd4fH/xzSLprd26LusUGdaisWnL63aUEqNl+TwFjI1eYXgfDrCpWhJ/J/yCHP/FguTGZ9wXiYxoQfOivSY0og7hKZbYM0GeeQOuv+UyPkKRH/+zsPGat0Wste28qQXLKeYrhT46KWYaErA0nHp1FU3SuA77SksbWJ5Ax4hD8T6r9nmePOTKnD12NNFJVvdt/b+TnaynwHTM7GOObKBb71nCdlnavjchcowXZ+nTJLRJqbXgmuqWqmmQU/ZLA5ibGEt0ceSYWs22la8FZLDoEzIExwJyF9Mocz1BjaxgbB4TF1Ngk4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zkRGKpsKrnyxVx+K2hP1V4+ALa8l6Kpw4U7klPxOuQ=;
 b=o/qlrNJq3qcTu5lJgoyTb9pZR31e3hAveGpefDqynLgrrINWzQ1W/xhMLEIVNKgMyV3461HL/VGD8IX7baq8IKb+z3sfY7qWwcDuhFq+lelIj+MqyTeaz4oNO31hfpwZxhPI+VNDodiBPsfS0JK+wf+mTdMmW4Rc3zxZxe5gEPvzTyrS0jKPzN+ph3fAJvVqa+MKcpUVpjomkzZKjJtdWeJs99JAH8A4SOnS1SA0cXvRgOD2ebe+HvnYT5DHgfsK5Iik7UpOusdBxaAFWf3+LCsoJeHVBjdI2I2em8Eq+Ay80JHy3iV/lYsTWDWI3Ed+eFBJhttfek0eTh0H+U0TBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB7257.namprd12.prod.outlook.com (2603:10b6:510:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 01:25:06 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 01:25:06 +0000
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
Date: Thu, 17 Jul 2025 21:25:02 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <9F4425D6-609F-40C8-BF24-2455F15234A7@nvidia.com>
In-Reply-To: <aHmYVkNDRjz5JwNf@lstrano-desk.jf.intel.com>
References: <007E2728-5BFC-40F9-8B8F-25504863D217@nvidia.com>
 <aa4f94a3-f601-4379-b6ca-4389421ccca4@nvidia.com>
 <906590D4-04E2-40CB-A853-25FE6212700C@nvidia.com>
 <eab52820-813f-4137-b664-c79ba8b453b7@nvidia.com>
 <aHc5/pmNLf4e9brJ@lstrano-desk.jf.intel.com>
 <1DD0079E-0AF6-49F5-9CB3-E440F36D2D9B@nvidia.com>
 <aHfSTdoi/M9ORrXE@lstrano-desk.jf.intel.com>
 <a7e8485f-e9da-4edb-a809-a014517f26eb@nvidia.com>
 <aHl4IuMlE9D6yaET@lstrano-desk.jf.intel.com>
 <9E024BB0-7365-4A81-81E1-72CB44A07775@nvidia.com>
 <aHmYVkNDRjz5JwNf@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0300.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::35) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: f3a833af-5239-454d-639e-08ddc599ed8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M25abjlneXhoMEs3K3RXOWFIRjJtbTVneHUvRGhFMGdUMk1waUhRK0xEZ1Bh?=
 =?utf-8?B?V2dpRU5sSTV4ajAzZVVRUzNJWSthMVo3UlNFazVadHJFUml6WXBoT3FTN2I3?=
 =?utf-8?B?WjV2ZEpCUCtlQmpHeFZncGxXWlVvUE8yV2NuZTBYUWdKYXpvaEw1aGZEWE9m?=
 =?utf-8?B?SlBJcmJpRVlKUXVpMlFPWG15OVhRSHdmZ2xxNXJzTjV1UTkyTjROc253aUJN?=
 =?utf-8?B?V28zbXdYRWVzM1JDTUlYcC96dmxwNmRkM3NGc3puZ0YyVG1CM0RVZENmb2JD?=
 =?utf-8?B?akRJNW5wd1NuMnVZbHNjMXJHQkQzQmZzNnNnQWxYeG8vT0F1ckRnVHpSNGtl?=
 =?utf-8?B?T3RhKzl5eFJWT0RpUzh2RUZvRW9TdjhDdldWcHByTkNhUW9sbkdJcnl5Zm9r?=
 =?utf-8?B?NW43RytUV1JvOHhZeGd0RWR2N1pKNkM0K2hLZytXUUgxcGwyTE1RV0d0R0h5?=
 =?utf-8?B?Tm90MU15eVI0Ky85ODREOEk3T0JuclFYUkI2MVBMNk93aFY0UFY1QUMyWTBv?=
 =?utf-8?B?NDBLVitXOWQrNjZqckVDYlNxMWdtRlhlQ1ZUUjV3WElmaHhCSUttUlc4UjRF?=
 =?utf-8?B?VUJFMFA0a1VGTjlBQzJ5TjBBUjdDblZ0d3hSY0lJSGlMb2xQUG9JMitudTlx?=
 =?utf-8?B?eFlkcjQ5azIzVkkvcm5UK25OSXY1T2tPMHhqc1Jmck5pT1duNjlXa2FBNjF1?=
 =?utf-8?B?RDJvSHpuQUUrcEo4VDRKQzZ1bjdlVGp0cXNqU0YyV2xLQU5LLzNkb3JwdU1K?=
 =?utf-8?B?NHpyU0labUNQVXA3ak1JcU5jcTZYNWp0MTBrMlg0NkU5c0xFVDcrcWFkVGtG?=
 =?utf-8?B?aGUrRElLVjhjSkluUEJpUTY1SCthZzkvVjhZemg3WUJYd2pCaGJyRWlSOUM0?=
 =?utf-8?B?amxvNjVUWXdGbnhBRW5kcTVLaTl6NDdiU0U2VXIvZ0hvQTBVelNLVVh0VWNq?=
 =?utf-8?B?Ui81NHg4QndaSVFwQWdnRmJoU0RwY1Nka0RWQ0N0OFJXb2R6N3VScWlmUHRC?=
 =?utf-8?B?NXk1ZlZCMmpIdHNjcCtGQ0p6aDFLY2ZNRFJ1YytZQXZRZWFia3UzUk1DdTVQ?=
 =?utf-8?B?SW0zd3BENlMxTGp0L25PK1Q4WUJFVWpUSEpqM1lBNUJkUjExYjlIcC90eVky?=
 =?utf-8?B?dGxCdnhpaEg3MVVyNzdmT0N1U2tnenJMVWtnZTRMWDBwWTdHQm11RmppZkxl?=
 =?utf-8?B?UlNjUEg3TDUxcjVLN2dRMFFqSEZBbGJMTndpRW9UV0ptSzdFbjVjbStRYTJV?=
 =?utf-8?B?TnBINVJzNXFtS1hBZlMrOHFQRm1aUnBZUzBZR1RHT2JxNVNDazJJY3FHUUcy?=
 =?utf-8?B?OVd3MzA0VldTQ1BJaE5teUw4bWRBZVFWSVF1V2IvSVd3U0xZR1RsVElNT0V5?=
 =?utf-8?B?OXBVZVJSNkpKdzFkWXRjU0IwWGdHZlF3VjJIY1ZiR2h0bzQyWjY4N2k4UDk5?=
 =?utf-8?B?c0ZoNzc2TWUzNU1NNGY2T3AyanZUZVM1enRWejZlUGJkeWY0b3pLQUw1RzM4?=
 =?utf-8?B?ZTdld2FPMk9RKzdIdzRDOVFueFFiTTRERm1jdHBnaVh5Zjd1cGJQUTJkb1hC?=
 =?utf-8?B?TEJ5RE5pRnUzMUJzSGozOGRYVTBUbTR5N29QNlVtV3U4cnJIc1BpUVZ5VGN4?=
 =?utf-8?B?cmdXWHNvOHZnMHpFWlNqS0l3T09kbkppb0JFRDQ5TDNDaEJQNEpxN1VZN1hR?=
 =?utf-8?B?dTdzU1h5bVVaOTk2R0ZOUkJKaTVCNVdQei9COVNSbnhoaFhZWnRXZm0rNGow?=
 =?utf-8?B?aTBwQ3dXTW96RitvVC82ei8yN3hEOWxwREtMNEYzaWJ6YTZQRENma1ZkNXE3?=
 =?utf-8?B?Q21TeE9KRHZXWCsyamlpdlNNT1MxcjlGc3BLOUZxaE9ZWWxySVVoUVJvTDV5?=
 =?utf-8?B?Umx4QnJ3VDgvT0YvNFdiZUpZcnRGTmNtYVo2Y1pROFgxODE5WjdtNFVUOG94?=
 =?utf-8?Q?LhZWmtPW3N4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmkzSmw1K25xby90NTMwZXJrN0hLVHEyYkRpSEIyMUxoc2twUkxwdkcxRGUz?=
 =?utf-8?B?TFdieDI1b25RcC92M1pnckZZcjl1Mmx1Rnd6c0UvdDRFYjREeE45K0NUK3Vx?=
 =?utf-8?B?K3ZYc3pmTGR1S1VHZDBoVHcxcklaazhTZDlSWlUwSmlDUE1BbTVibXM2REk1?=
 =?utf-8?B?cVNrakhhRkhUcCsrSEVaanlwZHpzaFFQVFR5aFg3VFZoelNEbzJGL1k1S2Yr?=
 =?utf-8?B?RXJYZFloTng3UWw5bGNweVkrWlFCd1h4VkZYNitRdTkvRWJ0QThJR2ZWejRN?=
 =?utf-8?B?VElrL1N3S1NDTm1sL0pQazBtdE5LQTQ3OFNpdkpVZXVVSEFzaXNkNko4U0hZ?=
 =?utf-8?B?VkpDOXhHd2p3bi8zVGo0RVhOWjFzbzBLMWNXMkU3REEyMkNhZE1pNG1LamxW?=
 =?utf-8?B?WkJNMjAxdTZhTVZJbU55SU80Z3JqcGVzYkUrTnVSZGpXUUJzbU9TS3FXelhr?=
 =?utf-8?B?UFI5VFB0MXl2NFFhSEo5S0dROVIvd3pDcWszNHFUektvVk5mMjNVc2xkbG9E?=
 =?utf-8?B?ZkJkQ0RzTDI0OTk3OXB2UlNsQ2VCblhlQVIxVFBJN2NHTFFkK3ZvTEl4blBN?=
 =?utf-8?B?VWs5RWZNdFdwQlA4YlFwNVVGUXliMEVtYUFaUTFVQ0ZZaHNpUk9saEgveFdQ?=
 =?utf-8?B?VkhaQWV1Z0JnT29IaGFUdFpJN0J6ZkNmRjZzQ2VKajJwa1h3VWMvQVNhb2Fj?=
 =?utf-8?B?TjJmckZkOHNrUlN6RWJxK0ZRY3FMU0lHay9NSUllMmdPMHZpcFlBOTRKbVRZ?=
 =?utf-8?B?b3B2NmRycmVMMFRTRDhrNkZoQ0xYZitjZWJNNTRUT1hzbEEyclhaSUFWekFT?=
 =?utf-8?B?MXVGOTJXWmdmQXFobUthREY1UWsrb3lha2EyM2o4YU9MUk5ldUdkR3pKUFI5?=
 =?utf-8?B?ZUJDWnNTdk1jVjlad3VxNjR0cSs2blFzRHcwbVlIYTVzdUZid1lJaHlabWdo?=
 =?utf-8?B?ejJlbWFYM1NJNWh4ZGdtR25MdVBhK1RkUE40VzA3cWFGNk1jSzdxQ3kwdW9G?=
 =?utf-8?B?cmdXbUVRbGtaS1dLbkxlaFFWNElBMXlIbGVtUURLaWtkdmxteDVodHJVeGda?=
 =?utf-8?B?YU11a1cxa3NvenRyQkFRZGJWTEk3NGhQZjBmRXlmcXdjY2ppVTNUS0wySS9W?=
 =?utf-8?B?THNxNVlkVDVFenY3K0dxby9Ya3FrUkczaVc4Uk1KVmNHbUZYMS84aHozeHBi?=
 =?utf-8?B?Z3Z3NmtBUnFTNnRaSG5HUzZOb3gvV09tZWJrdmVoVXFlazB4VkN0Q1IzTzhV?=
 =?utf-8?B?NjZwUUNaODl2b0RVWU90cHVEWURMYVZkZzJoaGpyRmNoZko0VmxWRXVFVVFX?=
 =?utf-8?B?QTQ2SVFrRElnSk81dHMvWHpaYVhCQ1BOdDIvVUFlME9yVXQzNkFubmJSS004?=
 =?utf-8?B?ZzZOSmh4ampIaG9EZ3FNNnBoL1ZVZitXNDhyTTV6MzJZcVM3Mks5T25wRjJr?=
 =?utf-8?B?MG5GYWJPSllPVFRjc3MzT1AwZnVHSzZJdXFFY2dmc1orVkVGOTlEVTJEcGNn?=
 =?utf-8?B?WGltU2JMSUtkQ1NkQ2JqNnlLZWM2Nk9HK2sxdU12Z2UyMEMrQ1Bvb0FlcDlZ?=
 =?utf-8?B?bVdVTE9QVkg3M3NVU3IrUGhuK3puZ3Z1a3oyYmsxcW5HQzJDRE15cE5TdGhm?=
 =?utf-8?B?ZVdRY3ptRkdQQzV0R0Y5ckRGWEczcHVvSkdtZit5QXQ3VTVubjkxUEx3bXJu?=
 =?utf-8?B?Q0V0NGlpbHNpcWxjTmJGZGplSXB6V0RuSkpVUEdOQnBzdEpzT1h3SHRibVdI?=
 =?utf-8?B?WndSNExnRjMyS0lDZktEbFJRK2N6SVh0TjB1ek5YQkRVTnhzRHFkSGl5Nk5O?=
 =?utf-8?B?NGplTmRqZ21uSi9nTTA0NWJ3WVhWKzM0bXZHT0Z3K1lldlI5Y1pGL2ZZN2hm?=
 =?utf-8?B?WXhGaTE0WVVzTW52allTQ1cxekk2aURjYllrU1dIMzVCb3NvTVNKb2tmcE9W?=
 =?utf-8?B?RmJEVFZoTGEwZ3gzTVBiMDVPaGFSRW9leklTNDVyQXh4bThmaEZDMmtoZTND?=
 =?utf-8?B?bk9uY3JIUTJaMXVoZzJPbW9MUjJTMmVVakZuS0hTcVd1T0I5U1pVN1IxL3Zm?=
 =?utf-8?B?VGcyNHFWTUxKZmtDNk5hNjZSR29YZ0NFVGxaU0NYRG15OTVyQVZQNm0zTkdh?=
 =?utf-8?Q?54bGvvrKMS22LAi/IDSaZyvGH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a833af-5239-454d-639e-08ddc599ed8d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 01:25:06.4199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NC81s9iKBnB3r5HrS5nsigEqyLvFoFB5IeR7exyxydlC7iIFmOIuWBlY06oKjBMl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7257

On 17 Jul 2025, at 20:41, Matthew Brost wrote:

> On Thu, Jul 17, 2025 at 07:04:48PM -0400, Zi Yan wrote:
>> On 17 Jul 2025, at 18:24, Matthew Brost wrote:
>>
>>> On Thu, Jul 17, 2025 at 07:53:40AM +1000, Balbir Singh wrote:
>>>> On 7/17/25 02:24, Matthew Brost wrote:
>>>>> On Wed, Jul 16, 2025 at 07:19:10AM -0400, Zi Yan wrote:
>>>>>> On 16 Jul 2025, at 1:34, Matthew Brost wrote:
>>>>>>
>>>>>>> On Sun, Jul 06, 2025 at 11:47:10AM +1000, Balbir Singh wrote:
>>>>>>>> On 7/6/25 11:34, Zi Yan wrote:
>>>>>>>>> On 5 Jul 2025, at 21:15, Balbir Singh wrote:
>>>>>>>>>
>>>>>>>>>> On 7/5/25 11:55, Zi Yan wrote:
>>>>>>>>>>> On 4 Jul 2025, at 20:58, Balbir Singh wrote:
>>>>>>>>>>>
>>>>>>>>>>>> On 7/4/25 21:24, Zi Yan wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> s/pages/folio
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks, will make the changes
>>>>>>>>>>>>
>>>>>>>>>>>>> Why name it isolated if the folio is unmapped? Isolated folio=
s often mean
>>>>>>>>>>>>> they are removed from LRU lists. isolated here causes confusi=
on.
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Ack, will change the name
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>>>   *
>>>>>>>>>>>>>>   * It calls __split_unmapped_folio() to perform uniform and=
 non-uniform split.
>>>>>>>>>>>>>>   * It is in charge of checking whether the split is support=
ed or not and
>>>>>>>>>>>>>> @@ -3800,7 +3799,7 @@ bool uniform_split_supported(struct fo=
lio *folio, unsigned int new_order,
>>>>>>>>>>>>>>   */
>>>>>>>>>>>>>>  static int __folio_split(struct folio *folio, unsigned int =
new_order,
>>>>>>>>>>>>>>  		struct page *split_at, struct page *lock_at,
>>>>>>>>>>>>>> -		struct list_head *list, bool uniform_split)
>>>>>>>>>>>>>> +		struct list_head *list, bool uniform_split, bool isolated=
)
>>>>>>>>>>>>>>  {
>>>>>>>>>>>>>>  	struct deferred_split *ds_queue =3D get_deferred_split_que=
ue(folio);
>>>>>>>>>>>>>>  	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
>>>>>>>>>>>>>> @@ -3846,14 +3845,16 @@ static int __folio_split(struct foli=
o *folio, unsigned int new_order,
>>>>>>>>>>>>>>  		 * is taken to serialise against parallel split or collap=
se
>>>>>>>>>>>>>>  		 * operations.
>>>>>>>>>>>>>>  		 */
>>>>>>>>>>>>>> -		anon_vma =3D folio_get_anon_vma(folio);
>>>>>>>>>>>>>> -		if (!anon_vma) {
>>>>>>>>>>>>>> -			ret =3D -EBUSY;
>>>>>>>>>>>>>> -			goto out;
>>>>>>>>>>>>>> +		if (!isolated) {
>>>>>>>>>>>>>> +			anon_vma =3D folio_get_anon_vma(folio);
>>>>>>>>>>>>>> +			if (!anon_vma) {
>>>>>>>>>>>>>> +				ret =3D -EBUSY;
>>>>>>>>>>>>>> +				goto out;
>>>>>>>>>>>>>> +			}
>>>>>>>>>>>>>> +			anon_vma_lock_write(anon_vma);
>>>>>>>>>>>>>>  		}
>>>>>>>>>>>>>>  		end =3D -1;
>>>>>>>>>>>>>>  		mapping =3D NULL;
>>>>>>>>>>>>>> -		anon_vma_lock_write(anon_vma);
>>>>>>>>>>>>>>  	} else {
>>>>>>>>>>>>>>  		unsigned int min_order;
>>>>>>>>>>>>>>  		gfp_t gfp;
>>>>>>>>>>>>>> @@ -3920,7 +3921,8 @@ static int __folio_split(struct folio =
*folio, unsigned int new_order,
>>>>>>>>>>>>>>  		goto out_unlock;
>>>>>>>>>>>>>>  	}
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> -	unmap_folio(folio);
>>>>>>>>>>>>>> +	if (!isolated)
>>>>>>>>>>>>>> +		unmap_folio(folio);
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>  	/* block interrupt reentry in xa_lock and spinlock */
>>>>>>>>>>>>>>  	local_irq_disable();
>>>>>>>>>>>>>> @@ -3973,14 +3975,15 @@ static int __folio_split(struct foli=
o *folio, unsigned int new_order,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>  		ret =3D __split_unmapped_folio(folio, new_order,
>>>>>>>>>>>>>>  				split_at, lock_at, list, end, &xas, mapping,
>>>>>>>>>>>>>> -				uniform_split);
>>>>>>>>>>>>>> +				uniform_split, isolated);
>>>>>>>>>>>>>>  	} else {
>>>>>>>>>>>>>>  		spin_unlock(&ds_queue->split_queue_lock);
>>>>>>>>>>>>>>  fail:
>>>>>>>>>>>>>>  		if (mapping)
>>>>>>>>>>>>>>  			xas_unlock(&xas);
>>>>>>>>>>>>>>  		local_irq_enable();
>>>>>>>>>>>>>> -		remap_page(folio, folio_nr_pages(folio), 0);
>>>>>>>>>>>>>> +		if (!isolated)
>>>>>>>>>>>>>> +			remap_page(folio, folio_nr_pages(folio), 0);
>>>>>>>>>>>>>>  		ret =3D -EAGAIN;
>>>>>>>>>>>>>>  	}
>>>>>>>>>>>>>
>>>>>>>>>>>>> These "isolated" special handlings does not look good, I wond=
er if there
>>>>>>>>>>>>> is a way of letting split code handle device private folios m=
ore gracefully.
>>>>>>>>>>>>> It also causes confusions, since why does "isolated/unmapped"=
 folios
>>>>>>>>>>>>> not need to unmap_page(), remap_page(), or unlock?
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> There are two reasons for going down the current code path
>>>>>>>>>>>
>>>>>>>>>>> After thinking more, I think adding isolated/unmapped is not th=
e right
>>>>>>>>>>> way, since unmapped folio is a very generic concept. If you add=
 it,
>>>>>>>>>>> one can easily misuse the folio split code by first unmapping a=
 folio
>>>>>>>>>>> and trying to split it with unmapped =3D true. I do not think t=
hat is
>>>>>>>>>>> supported and your patch does not prevent that from happening i=
n the future.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I don't understand the misuse case you mention, I assume you mea=
n someone can
>>>>>>>>>> get the usage wrong? The responsibility is on the caller to do t=
he right thing
>>>>>>>>>> if calling the API with unmapped
>>>>>>>>>
>>>>>>>>> Before your patch, there is no use case of splitting unmapped fol=
ios.
>>>>>>>>> Your patch only adds support for device private page split, not a=
ny unmapped
>>>>>>>>> folio split. So using a generic isolated/unmapped parameter is no=
t OK.
>>>>>>>>>
>>>>>>>>
>>>>>>>> There is a use for splitting unmapped folios (see below)
>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> You should teach different parts of folio split code path to ha=
ndle
>>>>>>>>>>> device private folios properly. Details are below.
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> 1. if the isolated check is not present, folio_get_anon_vma wi=
ll fail and cause
>>>>>>>>>>>>    the split routine to return with -EBUSY
>>>>>>>>>>>
>>>>>>>>>>> You do something below instead.
>>>>>>>>>>>
>>>>>>>>>>> if (!anon_vma && !folio_is_device_private(folio)) {
>>>>>>>>>>> 	ret =3D -EBUSY;
>>>>>>>>>>> 	goto out;
>>>>>>>>>>> } else if (anon_vma) {
>>>>>>>>>>> 	anon_vma_lock_write(anon_vma);
>>>>>>>>>>> }
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> folio_get_anon() cannot be called for unmapped folios. In our ca=
se the page has
>>>>>>>>>> already been unmapped. Is there a reason why you mix anon_vma_lo=
ck_write with
>>>>>>>>>> the check for device private folios?
>>>>>>>>>
>>>>>>>>> Oh, I did not notice that anon_vma =3D folio_get_anon_vma(folio) =
is also
>>>>>>>>> in if (!isolated) branch. In that case, just do
>>>>>>>>>
>>>>>>>>> if (folio_is_device_private(folio) {
>>>>>>>>> ...
>>>>>>>>> } else if (is_anon) {
>>>>>>>>> ...
>>>>>>>>> } else {
>>>>>>>>> ...
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> People can know device private folio split needs a special hand=
ling.
>>>>>>>>>>>
>>>>>>>>>>> BTW, why a device private folio can also be anonymous? Does it =
mean
>>>>>>>>>>> if a page cache folio is migrated to device private, kernel als=
o
>>>>>>>>>>> sees it as both device private and file-backed?
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> FYI: device private folios only work with anonymous private page=
s, hence
>>>>>>>>>> the name device private.
>>>>>>>>>
>>>>>>>>> OK.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>> 2. Going through unmap_page(), remap_page() causes a full page=
 table walk, which
>>>>>>>>>>>>    the migrate_device API has already just done as a part of t=
he migration. The
>>>>>>>>>>>>    entries under consideration are already migration entries i=
n this case.
>>>>>>>>>>>>    This is wasteful and in some case unexpected.
>>>>>>>>>>>
>>>>>>>>>>> unmap_folio() already adds TTU_SPLIT_HUGE_PMD to try to split
>>>>>>>>>>> PMD mapping, which you did in migrate_vma_split_pages(). You pr=
obably
>>>>>>>>>>> can teach either try_to_migrate() or try_to_unmap() to just spl=
it
>>>>>>>>>>> device private PMD mapping. Or if that is not preferred,
>>>>>>>>>>> you can simply call split_huge_pmd_address() when unmap_folio()
>>>>>>>>>>> sees a device private folio.
>>>>>>>>>>>
>>>>>>>>>>> For remap_page(), you can simply return for device private foli=
os
>>>>>>>>>>> like it is currently doing for non anonymous folios.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Doing a full rmap walk does not make sense with unmap_folio() an=
d
>>>>>>>>>> remap_folio(), because
>>>>>>>>>>
>>>>>>>>>> 1. We need to do a page table walk/rmap walk again
>>>>>>>>>> 2. We'll need special handling of migration <-> migration entrie=
s
>>>>>>>>>>    in the rmap handling (set/remove migration ptes)
>>>>>>>>>> 3. In this context, the code is already in the middle of migrati=
on,
>>>>>>>>>>    so trying to do that again does not make sense.
>>>>>>>>>
>>>>>>>>> Why doing split in the middle of migration? Existing split code
>>>>>>>>> assumes to-be-split folios are mapped.
>>>>>>>>>
>>>>>>>>> What prevents doing split before migration?
>>>>>>>>>
>>>>>>>>
>>>>>>>> The code does do a split prior to migration if THP selection fails
>>>>>>>>
>>>>>>>> Please see https://lore.kernel.org/lkml/20250703233511.2028395-5-b=
albirs@nvidia.com/
>>>>>>>> and the fallback part which calls split_folio()
>>>>>>>>
>>>>>>>> But the case under consideration is special since the device needs=
 to allocate
>>>>>>>> corresponding pfn's as well. The changelog mentions it:
>>>>>>>>
>>>>>>>> "The common case that arises is that after setup, during migrate
>>>>>>>> the destination might not be able to allocate MIGRATE_PFN_COMPOUND
>>>>>>>> pages."
>>>>>>>>
>>>>>>>> I can expand on it, because migrate_vma() is a multi-phase operati=
on
>>>>>>>>
>>>>>>>> 1. migrate_vma_setup()
>>>>>>>> 2. migrate_vma_pages()
>>>>>>>> 3. migrate_vma_finalize()
>>>>>>>>
>>>>>>>> It can so happen that when we get the destination pfn's allocated =
the destination
>>>>>>>> might not be able to allocate a large page, so we do the split in =
migrate_vma_pages().
>>>>>>>>
>>>>>>>> The pages have been unmapped and collected in migrate_vma_setup()
>>>>>>>>
>>>>>>>> The next patch in the series 9/12 (https://lore.kernel.org/lkml/20=
250703233511.2028395-10-balbirs@nvidia.com/)
>>>>>>>> tests the split and emulates a failure on the device side to alloc=
ate large pages
>>>>>>>> and tests it in 10/12 (https://lore.kernel.org/lkml/20250703233511=
.2028395-11-balbirs@nvidia.com/)
>>>>>>>>
>>>>>>>
>>>>>>> Another use case I=E2=80=99ve seen is when a previously allocated h=
igh-order
>>>>>>> folio, now in the free memory pool, is reallocated as a lower-order
>>>>>>> page. For example, a 2MB fault allocates a folio, the memory is lat=
er
>>>>>>
>>>>>> That is different. If the high-order folio is free, it should be spl=
it
>>>>>> using split_page() from mm/page_alloc.c.
>>>>>>
>>>>>
>>>>> Ah, ok. Let me see if that works - it would easier.
>>>>>
>>>
>>> This suggestion quickly blows up as PageCompound is true and page_count
>>> here is zero.
>>
>> OK, your folio has PageCompound set. Then you will need __split_unmapped=
_foio().
>>
>>>
>>>>>>> freed, and then a 4KB fault reuses a page from that previously allo=
cated
>>>>>>> folio. This will be actually quite common in Xe / GPU SVM. In such
>>>>>>> cases, the folio in an unmapped state needs to be split. I=E2=80=99=
d suggest a
>>>>>>
>>>>>> This folio is unused, so ->flags, ->mapping, and etc. are not set,
>>>>>> __split_unmapped_folio() is not for it, unless you mean free folio
>>>>>> differently.
>>>>>>
>>>>>
>>>>> This is right, those fields should be clear.
>>>>>
>>>>> Thanks for the tip.
>>>>>
>>>> I was hoping to reuse __split_folio_to_order() at some point in the fu=
ture
>>>> to split the backing pages in the driver, but it is not an immediate p=
riority
>>>>
>>>
>>> I think we need something for the scenario I describe here. I was to
>>> make __split_huge_page_to_list_to_order with a couple of hacks but it
>>> almostly certainig not right as Zi pointed out.
>>>
>>> New to the MM stuff, but play around with this a bit and see if I can
>>> come up with something that will work here.
>>
>> Can you try to write a new split_page function with __split_unmapped_fol=
io()?
>> Since based on your description, your folio is not mapped.
>>
>
> Yes, page->mapping is NULL in this case - that was part of the hacks to
> __split_huge_page_to_list_to_order (more specially __folio_split) I had
> to make in order to get something working for this case.
>
> I can try out something based on __split_unmapped_folio and report back.

mm-new tree has an updated __split_unmapped_folio() version, it moves
all unmap irrelevant code out of __split_unmaped_folio(). You might find
it easier to reuse.

See: https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/tree/mm/hu=
ge_memory.c?h=3Dmm-new#n3430

I am about to update the code with v4 patches. I will cc you, so that
you can get the updated __split_unmaped_folio().

Feel free to ask questions on folio split code.

Best Regards,
Yan, Zi

