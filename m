Return-Path: <linux-kernel+bounces-736219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2679AB09A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DC077B9F7F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC65A1BD9CE;
	Fri, 18 Jul 2025 03:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YxpgrU+0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379E62E3701
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 03:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752809519; cv=fail; b=KkOINdEsoiveQQhXTTe3P8yQ8mFvR6dsGpCoIix6CsXZGLlyWsYmTjNX2yjnWHnP5bXhJNHoAFyCOmi32VO0hlGpvFHg9fUNtOwgESP7T8QXV2vHF+BRqkwsmOEgPJo79pCGGc4Iz9hCvu15IGBQxWkUfeijGDqxnS03YfAfs0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752809519; c=relaxed/simple;
	bh=sAj50p2VYVPtmP8oXkJibEiXejwHKa1KH+iQ8k1JQug=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WYHd3NG0lXxQyVEP/AlJbIR+Am+vSb/k2/gIM6zYYyMaiqQUxQGMRwvov92LLuVRHIT0aR8uTtBUiFfs1ML42N6G14zBnc80GrN5EwxMMhRS4pWrXuypZCxCobXWCco734d1vAlXdntsELKrKNv4vUqAs9sp2izQcjPWeEr6vJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YxpgrU+0; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752809517; x=1784345517;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=sAj50p2VYVPtmP8oXkJibEiXejwHKa1KH+iQ8k1JQug=;
  b=YxpgrU+0NWoDeFC/uybO6LURKTlkxL+/F2jDiTL/60AHBwGMOHBcIpfN
   gW45PrCabyxX01AGPdoFNgFeP8I0I9Ve77m8jqUMXKCH38TV9X6x0PwBT
   jbUeEwDu8IUAN6SpGiFDlkoL6/pxlO/WUGzuP7gwDwHx1Qy6sYDQ43iij
   JTZO8xqGwlI11ZaOAJ/ncl6QG2Gf0HIHMnt01FRY1i36jIc02d9em+iCm
   32Dj1ghkSZYjj6WZa4brxc0Kkkkb7bJjYoFolOkkdo17qPAiAlfQ9FInO
   9I8HFNw7vdzXHZb+k24+sMlL3/7K63VGHMNs2XMXK/9XjrwqSOkaIWBjF
   Q==;
X-CSE-ConnectionGUID: bvHSrquwSfKdcdQspONiHQ==
X-CSE-MsgGUID: Nf4NJCZRTpG4ICEkzAl3Fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="54811672"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="54811672"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 20:31:57 -0700
X-CSE-ConnectionGUID: qLYUekBTTNSxsD32q3orHg==
X-CSE-MsgGUID: +xpCc67QQxuUMDMwlsnaDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="163590572"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 20:31:56 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 20:31:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 20:31:55 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.74)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 20:31:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ypd2E019HHnBgZ+bqXeRTPbGiuIaLGkoPyJpadpPna8w+hi9rj7kYU7RanBaULY/j4LUxOj4U777Ohf71IN55qXt0C0N6iEu9fyCugDecxYKX3du0oh0J+I4VFLEaNTGfArOZBRaUKzrFW8DFR5prmFuq1fidm6nZW0L0MX48+/++IfKohrGeJ9vj7JZruWt1UFu70QHg/ElkAykiqAZgX6X74Du/h6mVkJ8gN2rj7iGY8z/22qdKPVYRF1E8fmOyNAnjSSpSx27Il9tQwPPVhI1S9oH6UTtY3gTOOltdVyXAEFsp+OybuulzXXAf32nzqqKHIR/0q9jpo8sw04Z/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0JP6l97QYQtcHZAAz90N6vHuWJx893v5oFEIOWSwXw=;
 b=BYXqoho/0BfpYa0ZwYjE2LEWi+gkDn31Kp4y8Mw89d8zNV3/GowkwxHxeI/yI3yvwebtquDHX68KcQMPAgNJQHlo0zPK2hvBtYbzV9RXl7RgKUiM1qH8NtqXJV9EbSPdrOEL9C4LIDxFEUIw0DWSOClcAt2GZDyZm9ZTzapKl1IMVwVbpe9mnCC15DLVVA9tT7L9DuyIrs4VTdmlCZBye6Un8Oj0ZEccBQiAy3QX3ZydnN8edCz59QqAUEsNAq3wSRNkI0vwWMYVJL+w3wIcQN3XCi43bktscUDJ3OYfonJ4dSswCf5NTpV8uzuJ9w0X8SkS/V7gCxUYitxV5Bkkog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by DM4PR11MB7760.namprd11.prod.outlook.com (2603:10b6:8:100::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 03:31:38 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51%7]) with mapi id 15.20.8880.021; Fri, 18 Jul 2025
 03:31:38 +0000
Date: Thu, 17 Jul 2025 20:33:22 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Zi Yan <ziy@nvidia.com>
CC: Balbir Singh <balbirs@nvidia.com>, <linux-mm@kvack.org>,
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>, Karol Herbst
	<kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, Danilo Krummrich
	<dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>, "Barry
 Song" <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, "Ryan
 Roberts" <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>, "Peter
 Xu" <peterx@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Jane Chu
	<jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>, Donet Tom
	<donettom@linux.ibm.com>
Subject: Re: [v1 resend 08/12] mm/thp: add split during migration support
Message-ID: <aHnAgjaJeyKM+Osm@lstrano-desk.jf.intel.com>
References: <906590D4-04E2-40CB-A853-25FE6212700C@nvidia.com>
 <eab52820-813f-4137-b664-c79ba8b453b7@nvidia.com>
 <aHc5/pmNLf4e9brJ@lstrano-desk.jf.intel.com>
 <1DD0079E-0AF6-49F5-9CB3-E440F36D2D9B@nvidia.com>
 <aHfSTdoi/M9ORrXE@lstrano-desk.jf.intel.com>
 <a7e8485f-e9da-4edb-a809-a014517f26eb@nvidia.com>
 <aHl4IuMlE9D6yaET@lstrano-desk.jf.intel.com>
 <9E024BB0-7365-4A81-81E1-72CB44A07775@nvidia.com>
 <aHmYVkNDRjz5JwNf@lstrano-desk.jf.intel.com>
 <9F4425D6-609F-40C8-BF24-2455F15234A7@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9F4425D6-609F-40C8-BF24-2455F15234A7@nvidia.com>
X-ClientProxiedBy: BYAPR11CA0082.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::23) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|DM4PR11MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d86dca2-56a0-4af0-9348-08ddc5ab9ad5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UG1UVWxTenFkZFc3dGpESlFHVW1yVWUxVCtaeHNSQnhheE1SSUlvbm8xa3hv?=
 =?utf-8?B?dTJ2TzZsTXJWZHZSSjNNNGNSZWsrWHlEcTVlQ285M1VLRUI4aFdkWEdXRE5i?=
 =?utf-8?B?WmtrVEN6R2V2akFvK2NmOFpLcjFUUzdQcFRaQWdOY05xTTdvbDJFWlJCVHor?=
 =?utf-8?B?TFpSdEF5dEdmbUxOd1Y4blJnZHJ0N0ZtNnBQREJqNi9WUTdBbncyVFk5TkFq?=
 =?utf-8?B?L25mSG4rU3RhTE1hc21HK2Z0R1VFYm00Z21aVVF2M0NrRFp4NCtSM0JkeFhw?=
 =?utf-8?B?VmdzRnJ3RE5ROFBrUGJRc1lNMFRSZHhZRC9FU3R1Q3dKR2cxNkxSY2hwdnhs?=
 =?utf-8?B?dml4amxmVEdOUzdQMjJ1TmRSOGlMdDlDZUJZZ0JMb1FNeHZZZ1ZnN2RtWmpU?=
 =?utf-8?B?Sm16dmk2VGgvUUNTMWZ1NGhFSmp1S3RXS1hCcy9tcUNPY1hCVlNabU9uNzJ6?=
 =?utf-8?B?ODhZcmJZQ2x6YnEyN2hDL1pocDZPR0RlRXJabGhVV0M3bm96ZnVrbmszbkJQ?=
 =?utf-8?B?VitGM0pjclhHR3BMSC9SOTZrL1NSQ3NIcG9WTVVnQ1pGWWNFdS9vWVFNRFJl?=
 =?utf-8?B?d3RBcSsra3oxMUlVbnhaRVBGVFV1cUliV3EyQWN6R3BEWjE1d1FJczFKeTNE?=
 =?utf-8?B?blN2OEtOT0JkQnN6RmZBNmV6UU5idFp1VmlxRmdQRGE4bmxxUE04Ly9zQzJI?=
 =?utf-8?B?OGdlQWdNTTQvUnZxRnd4TFBHOC9oYUo0WDBGR2xJbzAyM1phajY1cUpES0hG?=
 =?utf-8?B?dDRocW1UZlJ1VmlOdy9kUTVHbitnVU1ldFJaazMzVmhTczFRbWVTSEhKT2ly?=
 =?utf-8?B?b1Z6UW5ydkQzSU11K2RhUXJiTlpXbnlEWXVBNGtSNlZZT2VnN3EvUGdqMWNC?=
 =?utf-8?B?Z09tV3JyLzk2bCtJZ092a3U4dUozTkhIRk1PNTEzRk1nYUNycEtvRjBROTNX?=
 =?utf-8?B?ZEVzd0tKNWtBNWUrQ3ZtTjVROVZ5bkxhOE9EcHV6QkQ1UFNJNWdvWkpxQk9i?=
 =?utf-8?B?VzIwd3BJd0NYQVVnVHFoeEVFWUNiR2ZWVFlQbWhTRTZxU1NGK08zYUR6VmV4?=
 =?utf-8?B?Nm5rOFd2V3dwUWJyRjdKRC9UbkdDTzVzM0ZoU1FYNWpyWFAvVms3a1F2MytF?=
 =?utf-8?B?azVTK1FFMmhUTW45bTVVVGsrUFpNakN2THlna0ltdnZDZ3g2eWd0WDZzczE3?=
 =?utf-8?B?STdISUtLVW9DQkN0S0k0U2x3T0VObWFzU00yTmdxZEhWN1huVWhpVFVQeG5h?=
 =?utf-8?B?OHZINnFVVVl0cHpKc0xSaGxDRzQyMjJoSjQxM2lwQUNjWHNwRmQ2SUMwc1hU?=
 =?utf-8?B?eWc2eERWMGNMUDZ1K2l1RE9JakQ0VzJTQ2w0bXpSVXV4aGNVazdiNHpFTnBY?=
 =?utf-8?B?OHNUd2d2QlNLS0ZLVGljeW0yUytESmhZNVZDdVBLUXN3eTEwSzFIZEVQTnow?=
 =?utf-8?B?UkdPUURsbGZCR0NxMHBpVVA3YSsrYkdtQlVSUkpvSmNjWWRpaURTNDNEL3dS?=
 =?utf-8?B?djRiN3p0anloc0lzWVh2cDIrWk8yU0x2R2V3RE9kTkFsa05UR1NuSTBnazkv?=
 =?utf-8?B?Tm14S214cDhLRlhTaWszNlZJTVB6bytrVnYzckpybk5lS0l2bzRmdlowZXA4?=
 =?utf-8?B?eGE3SHB3UEQ4VlVvME9OOGFRWUI1c0FmVWJpTzNvK3NBT0NjVUwvTW93VEY1?=
 =?utf-8?B?ayszK0RqcUFwZkRBU015UkNkam9BTldwSGd0QjYzNUJybFdHR3RsT0dwQVhH?=
 =?utf-8?B?NFd4Qll0a2NIM1RJTjYwaG9VbjRwdTNZMHgxRFRmL0xqQzI5dVk5SmZKTkxw?=
 =?utf-8?B?ZzFSN3RZNExwMTJ6VUtFYnpUQVV0RlpPcm9hVncwQzNvNXVFWjRXU1FLVjI0?=
 =?utf-8?B?N2JqRjE5ODlSRUplNG43aXIxdnRWOFA5cktPdEpINnk2NHlyUFdzOFlnSkFO?=
 =?utf-8?Q?A9+4qt2z7Gk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3pta1lmKys1cW9XSDhXSXFETUtXclVBRVpqUTFiWlNXb2MrUG5MNWdyRHV6?=
 =?utf-8?B?L1NBY2dFUmlkSmlnUVJsRUFZdWRneVZvTTlyQnpVaW1adWJTdGlaQjRxeXVr?=
 =?utf-8?B?bDJsN2hlNjlIR2NwWlhqRkFQZjNMVGt6VUlSS1NBU2V5V1VVT29Pd0ZCQnFu?=
 =?utf-8?B?ZWtucjlPSStqM1BlUVgwd3k1bW1lQldGZHRKVjY2czFKWUNsOTlyekVIeU1h?=
 =?utf-8?B?bktna1ZXK2pqVWxpWWZIRHM0Q3ppTmZTYXVmbUpoVDQ3aDFOcDkrcC9abHhC?=
 =?utf-8?B?VmptVlIwZ05mWWZmZG9Ia3k0bTE2eVpHVWRCT1cvUC9BYU01aWs2V05JcFZa?=
 =?utf-8?B?LzdUWlIvR1g4N2pyU0VUM3pzaTdRNDVrVk9nNm41eVMzN2ErODZnc2NHaStq?=
 =?utf-8?B?WDI5OVVrQlBzaTlwSktKbWx5dENPU3JpUzNMOW1GaVJGNHA5RloxcXM0WHZS?=
 =?utf-8?B?QmhQV2UvWjVqbjQ4dkJBTUE5bThFQkNrVUhWdXBQdjA4RVFLbXc0Y0dpNTc4?=
 =?utf-8?B?UmxubERWd3Vrbm1rbmNtRS8vUWxuM2phWjhEUXlQZmVCNEJzRTE1b3BrQVpr?=
 =?utf-8?B?cXlmT3I3QVlZZkJNUVdrbzFTRVh5eU9iNEpRTDVvUDhLcDFWd3VMTVFEcnpD?=
 =?utf-8?B?MG1pcDA2cUJuSzBBOFZWWjE4RW5aaG9aa0d2dy95SktWdGZsZnlpZWdscmhy?=
 =?utf-8?B?UWd0Sk8rNG9MeHpoNkpMcm9xWHVFOU94WGJRaGtucnZyM2JWS1ZqY3IvN1g0?=
 =?utf-8?B?RmMrd09xZlpBMm1LK2xuTXQzeFhKSFJwaVZoTS9HZ3BZQkE1UzF1Y2hudGFv?=
 =?utf-8?B?L2Z6bm5zdjVKQkwwVGNZTndnMkRHZnFCNkxyd0gzcU5BeW5QVmxSSHE1dGdT?=
 =?utf-8?B?MG5VeVB0cWtKK3lJQTlOdld1WDRRQmsrQTJZeTNsNUVWWS9SQVVMK3cxaTNP?=
 =?utf-8?B?TW9YRTk0WnNOS1gxUWIwekc1bk9QNDM2TUtzL1o5ak85N1BJNENYSGhaT2FN?=
 =?utf-8?B?NDV3U1VJVHNFVk53RVJtTkFJVkRiY1Z6RDJVbU5RWTk3eDhCdTQxM0xaS0lz?=
 =?utf-8?B?TVZEUmFsbGR5bHZWZmVBc3JNT1poOFBPZ0RFQlBQdUxhUlBKeEFMbFdjV0Vy?=
 =?utf-8?B?cUNMWmdyN3NLMFV1QUgzcDlvSGJaYlN2QlkyU25NUTRzeXZVaEhITEo0a2dN?=
 =?utf-8?B?cjB4OHk3MmdmblhKejkwYnErMmZqRmsrUmV2QkdPZFowYS9VTEtIVEhESFJS?=
 =?utf-8?B?ZGtaSEM1TU01UE1xK3ZYSnNhcksrTElsN0hhZnJLT0tST2pCckt5WDB0OGZ0?=
 =?utf-8?B?UXZ6WXZjU0pBb2VDZGEwTHZxTnA4di9IRDF0UjU5V1B0c0lyWTRLMlppYS9j?=
 =?utf-8?B?bGVqV2FtanpwY081WVM4dlpoM3JuM2dRS0c1MmlMb2dVYmYxSng3MWRUbHl2?=
 =?utf-8?B?cUtrbFBiRUlWZ1ZtZ3dKTlM3SkpJK2JzWEFCSllnQm1RbnZoSEtQSEo1WTNR?=
 =?utf-8?B?dWlBbStyejFjSkhmTVVsem9EVDMvWVBLaXVvTE9RR2dwS0NobW95SVM5RnBH?=
 =?utf-8?B?S2JrbHZlUHM0VzVNaTdoUlp1bStEWFZzeFB2SGszMEZqUnVva1BkQklRZ0Ro?=
 =?utf-8?B?OWh5MXhvT2pqMExKakZqOUU4WDlOODVtcllHbXZEYklId3JvWUFpYmRHUUdz?=
 =?utf-8?B?bXp4dHFaWERlVkxsaVZvdWxaOTlDRVdPRWtJQ0ZjYWYwc0tiQVZoWTNXY2xE?=
 =?utf-8?B?UmRmVHd3UndiKzcvOXFFeEUxb3NuS2E0LzE5WVdkTXBuQkxxREc2VE1jYmNy?=
 =?utf-8?B?bU9oa2F6eFdsTnUzWXZNYjZMVE1rVEV6SDJSVVBudWo3SDFrY0EyQXBkUTc1?=
 =?utf-8?B?THQ4RCtzcEhBSDNZQzE4SEp0YXNXVnFzeWxHdGVuSDdwaGtzR3dkL2trd3Fi?=
 =?utf-8?B?UHN0ZHN4eWY4K2ZrSDN1d04xWTQ4bFp4c1g0cWw0Ukw5WFdXMFpnckdzNDA0?=
 =?utf-8?B?cHVqSVlocFZMK3VnUmp2TCtjMmE0VXRSTEU1Ry9OeWVxcHdGQ3JSZlJ1ekpx?=
 =?utf-8?B?OG4zcmhrbGpzSkM4aFJ2KzlhZ0IxN0Jqc2NlZmluOUxxTDlVNVlFY1dTS0pK?=
 =?utf-8?B?MS9xb3pvOEFobmlpY0g3aTdFN1QvU0Q4aTZva0xBMXVqSUl4cHZOeHg2OWt0?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d86dca2-56a0-4af0-9348-08ddc5ab9ad5
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 03:31:38.7080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t12XhJ2KmpbJL3z+59DrPS63QMOxBAnf/hMUXcELUCmPKFmpUpkNpR82khcaunzGkBfv/dQAjp5aU2pkHt2H5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7760
X-OriginatorOrg: intel.com

On Thu, Jul 17, 2025 at 09:25:02PM -0400, Zi Yan wrote:
> On 17 Jul 2025, at 20:41, Matthew Brost wrote:
> 
> > On Thu, Jul 17, 2025 at 07:04:48PM -0400, Zi Yan wrote:
> >> On 17 Jul 2025, at 18:24, Matthew Brost wrote:
> >>
> >>> On Thu, Jul 17, 2025 at 07:53:40AM +1000, Balbir Singh wrote:
> >>>> On 7/17/25 02:24, Matthew Brost wrote:
> >>>>> On Wed, Jul 16, 2025 at 07:19:10AM -0400, Zi Yan wrote:
> >>>>>> On 16 Jul 2025, at 1:34, Matthew Brost wrote:
> >>>>>>
> >>>>>>> On Sun, Jul 06, 2025 at 11:47:10AM +1000, Balbir Singh wrote:
> >>>>>>>> On 7/6/25 11:34, Zi Yan wrote:
> >>>>>>>>> On 5 Jul 2025, at 21:15, Balbir Singh wrote:
> >>>>>>>>>
> >>>>>>>>>> On 7/5/25 11:55, Zi Yan wrote:
> >>>>>>>>>>> On 4 Jul 2025, at 20:58, Balbir Singh wrote:
> >>>>>>>>>>>
> >>>>>>>>>>>> On 7/4/25 21:24, Zi Yan wrote:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> s/pages/folio
> >>>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> Thanks, will make the changes
> >>>>>>>>>>>>
> >>>>>>>>>>>>> Why name it isolated if the folio is unmapped? Isolated folios often mean
> >>>>>>>>>>>>> they are removed from LRU lists. isolated here causes confusion.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> Ack, will change the name
> >>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>>>>   *
> >>>>>>>>>>>>>>   * It calls __split_unmapped_folio() to perform uniform and non-uniform split.
> >>>>>>>>>>>>>>   * It is in charge of checking whether the split is supported or not and
> >>>>>>>>>>>>>> @@ -3800,7 +3799,7 @@ bool uniform_split_supported(struct folio *folio, unsigned int new_order,
> >>>>>>>>>>>>>>   */
> >>>>>>>>>>>>>>  static int __folio_split(struct folio *folio, unsigned int new_order,
> >>>>>>>>>>>>>>  		struct page *split_at, struct page *lock_at,
> >>>>>>>>>>>>>> -		struct list_head *list, bool uniform_split)
> >>>>>>>>>>>>>> +		struct list_head *list, bool uniform_split, bool isolated)
> >>>>>>>>>>>>>>  {
> >>>>>>>>>>>>>>  	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
> >>>>>>>>>>>>>>  	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
> >>>>>>>>>>>>>> @@ -3846,14 +3845,16 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> >>>>>>>>>>>>>>  		 * is taken to serialise against parallel split or collapse
> >>>>>>>>>>>>>>  		 * operations.
> >>>>>>>>>>>>>>  		 */
> >>>>>>>>>>>>>> -		anon_vma = folio_get_anon_vma(folio);
> >>>>>>>>>>>>>> -		if (!anon_vma) {
> >>>>>>>>>>>>>> -			ret = -EBUSY;
> >>>>>>>>>>>>>> -			goto out;
> >>>>>>>>>>>>>> +		if (!isolated) {
> >>>>>>>>>>>>>> +			anon_vma = folio_get_anon_vma(folio);
> >>>>>>>>>>>>>> +			if (!anon_vma) {
> >>>>>>>>>>>>>> +				ret = -EBUSY;
> >>>>>>>>>>>>>> +				goto out;
> >>>>>>>>>>>>>> +			}
> >>>>>>>>>>>>>> +			anon_vma_lock_write(anon_vma);
> >>>>>>>>>>>>>>  		}
> >>>>>>>>>>>>>>  		end = -1;
> >>>>>>>>>>>>>>  		mapping = NULL;
> >>>>>>>>>>>>>> -		anon_vma_lock_write(anon_vma);
> >>>>>>>>>>>>>>  	} else {
> >>>>>>>>>>>>>>  		unsigned int min_order;
> >>>>>>>>>>>>>>  		gfp_t gfp;
> >>>>>>>>>>>>>> @@ -3920,7 +3921,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> >>>>>>>>>>>>>>  		goto out_unlock;
> >>>>>>>>>>>>>>  	}
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> -	unmap_folio(folio);
> >>>>>>>>>>>>>> +	if (!isolated)
> >>>>>>>>>>>>>> +		unmap_folio(folio);
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>  	/* block interrupt reentry in xa_lock and spinlock */
> >>>>>>>>>>>>>>  	local_irq_disable();
> >>>>>>>>>>>>>> @@ -3973,14 +3975,15 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>  		ret = __split_unmapped_folio(folio, new_order,
> >>>>>>>>>>>>>>  				split_at, lock_at, list, end, &xas, mapping,
> >>>>>>>>>>>>>> -				uniform_split);
> >>>>>>>>>>>>>> +				uniform_split, isolated);
> >>>>>>>>>>>>>>  	} else {
> >>>>>>>>>>>>>>  		spin_unlock(&ds_queue->split_queue_lock);
> >>>>>>>>>>>>>>  fail:
> >>>>>>>>>>>>>>  		if (mapping)
> >>>>>>>>>>>>>>  			xas_unlock(&xas);
> >>>>>>>>>>>>>>  		local_irq_enable();
> >>>>>>>>>>>>>> -		remap_page(folio, folio_nr_pages(folio), 0);
> >>>>>>>>>>>>>> +		if (!isolated)
> >>>>>>>>>>>>>> +			remap_page(folio, folio_nr_pages(folio), 0);
> >>>>>>>>>>>>>>  		ret = -EAGAIN;
> >>>>>>>>>>>>>>  	}
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> These "isolated" special handlings does not look good, I wonder if there
> >>>>>>>>>>>>> is a way of letting split code handle device private folios more gracefully.
> >>>>>>>>>>>>> It also causes confusions, since why does "isolated/unmapped" folios
> >>>>>>>>>>>>> not need to unmap_page(), remap_page(), or unlock?
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> There are two reasons for going down the current code path
> >>>>>>>>>>>
> >>>>>>>>>>> After thinking more, I think adding isolated/unmapped is not the right
> >>>>>>>>>>> way, since unmapped folio is a very generic concept. If you add it,
> >>>>>>>>>>> one can easily misuse the folio split code by first unmapping a folio
> >>>>>>>>>>> and trying to split it with unmapped = true. I do not think that is
> >>>>>>>>>>> supported and your patch does not prevent that from happening in the future.
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> I don't understand the misuse case you mention, I assume you mean someone can
> >>>>>>>>>> get the usage wrong? The responsibility is on the caller to do the right thing
> >>>>>>>>>> if calling the API with unmapped
> >>>>>>>>>
> >>>>>>>>> Before your patch, there is no use case of splitting unmapped folios.
> >>>>>>>>> Your patch only adds support for device private page split, not any unmapped
> >>>>>>>>> folio split. So using a generic isolated/unmapped parameter is not OK.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> There is a use for splitting unmapped folios (see below)
> >>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>> You should teach different parts of folio split code path to handle
> >>>>>>>>>>> device private folios properly. Details are below.
> >>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> 1. if the isolated check is not present, folio_get_anon_vma will fail and cause
> >>>>>>>>>>>>    the split routine to return with -EBUSY
> >>>>>>>>>>>
> >>>>>>>>>>> You do something below instead.
> >>>>>>>>>>>
> >>>>>>>>>>> if (!anon_vma && !folio_is_device_private(folio)) {
> >>>>>>>>>>> 	ret = -EBUSY;
> >>>>>>>>>>> 	goto out;
> >>>>>>>>>>> } else if (anon_vma) {
> >>>>>>>>>>> 	anon_vma_lock_write(anon_vma);
> >>>>>>>>>>> }
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> folio_get_anon() cannot be called for unmapped folios. In our case the page has
> >>>>>>>>>> already been unmapped. Is there a reason why you mix anon_vma_lock_write with
> >>>>>>>>>> the check for device private folios?
> >>>>>>>>>
> >>>>>>>>> Oh, I did not notice that anon_vma = folio_get_anon_vma(folio) is also
> >>>>>>>>> in if (!isolated) branch. In that case, just do
> >>>>>>>>>
> >>>>>>>>> if (folio_is_device_private(folio) {
> >>>>>>>>> ...
> >>>>>>>>> } else if (is_anon) {
> >>>>>>>>> ...
> >>>>>>>>> } else {
> >>>>>>>>> ...
> >>>>>>>>> }
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>> People can know device private folio split needs a special handling.
> >>>>>>>>>>>
> >>>>>>>>>>> BTW, why a device private folio can also be anonymous? Does it mean
> >>>>>>>>>>> if a page cache folio is migrated to device private, kernel also
> >>>>>>>>>>> sees it as both device private and file-backed?
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> FYI: device private folios only work with anonymous private pages, hence
> >>>>>>>>>> the name device private.
> >>>>>>>>>
> >>>>>>>>> OK.
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>>> 2. Going through unmap_page(), remap_page() causes a full page table walk, which
> >>>>>>>>>>>>    the migrate_device API has already just done as a part of the migration. The
> >>>>>>>>>>>>    entries under consideration are already migration entries in this case.
> >>>>>>>>>>>>    This is wasteful and in some case unexpected.
> >>>>>>>>>>>
> >>>>>>>>>>> unmap_folio() already adds TTU_SPLIT_HUGE_PMD to try to split
> >>>>>>>>>>> PMD mapping, which you did in migrate_vma_split_pages(). You probably
> >>>>>>>>>>> can teach either try_to_migrate() or try_to_unmap() to just split
> >>>>>>>>>>> device private PMD mapping. Or if that is not preferred,
> >>>>>>>>>>> you can simply call split_huge_pmd_address() when unmap_folio()
> >>>>>>>>>>> sees a device private folio.
> >>>>>>>>>>>
> >>>>>>>>>>> For remap_page(), you can simply return for device private folios
> >>>>>>>>>>> like it is currently doing for non anonymous folios.
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Doing a full rmap walk does not make sense with unmap_folio() and
> >>>>>>>>>> remap_folio(), because
> >>>>>>>>>>
> >>>>>>>>>> 1. We need to do a page table walk/rmap walk again
> >>>>>>>>>> 2. We'll need special handling of migration <-> migration entries
> >>>>>>>>>>    in the rmap handling (set/remove migration ptes)
> >>>>>>>>>> 3. In this context, the code is already in the middle of migration,
> >>>>>>>>>>    so trying to do that again does not make sense.
> >>>>>>>>>
> >>>>>>>>> Why doing split in the middle of migration? Existing split code
> >>>>>>>>> assumes to-be-split folios are mapped.
> >>>>>>>>>
> >>>>>>>>> What prevents doing split before migration?
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> The code does do a split prior to migration if THP selection fails
> >>>>>>>>
> >>>>>>>> Please see https://lore.kernel.org/lkml/20250703233511.2028395-5-balbirs@nvidia.com/
> >>>>>>>> and the fallback part which calls split_folio()
> >>>>>>>>
> >>>>>>>> But the case under consideration is special since the device needs to allocate
> >>>>>>>> corresponding pfn's as well. The changelog mentions it:
> >>>>>>>>
> >>>>>>>> "The common case that arises is that after setup, during migrate
> >>>>>>>> the destination might not be able to allocate MIGRATE_PFN_COMPOUND
> >>>>>>>> pages."
> >>>>>>>>
> >>>>>>>> I can expand on it, because migrate_vma() is a multi-phase operation
> >>>>>>>>
> >>>>>>>> 1. migrate_vma_setup()
> >>>>>>>> 2. migrate_vma_pages()
> >>>>>>>> 3. migrate_vma_finalize()
> >>>>>>>>
> >>>>>>>> It can so happen that when we get the destination pfn's allocated the destination
> >>>>>>>> might not be able to allocate a large page, so we do the split in migrate_vma_pages().
> >>>>>>>>
> >>>>>>>> The pages have been unmapped and collected in migrate_vma_setup()
> >>>>>>>>
> >>>>>>>> The next patch in the series 9/12 (https://lore.kernel.org/lkml/20250703233511.2028395-10-balbirs@nvidia.com/)
> >>>>>>>> tests the split and emulates a failure on the device side to allocate large pages
> >>>>>>>> and tests it in 10/12 (https://lore.kernel.org/lkml/20250703233511.2028395-11-balbirs@nvidia.com/)
> >>>>>>>>
> >>>>>>>
> >>>>>>> Another use case I’ve seen is when a previously allocated high-order
> >>>>>>> folio, now in the free memory pool, is reallocated as a lower-order
> >>>>>>> page. For example, a 2MB fault allocates a folio, the memory is later
> >>>>>>
> >>>>>> That is different. If the high-order folio is free, it should be split
> >>>>>> using split_page() from mm/page_alloc.c.
> >>>>>>
> >>>>>
> >>>>> Ah, ok. Let me see if that works - it would easier.
> >>>>>
> >>>
> >>> This suggestion quickly blows up as PageCompound is true and page_count
> >>> here is zero.
> >>
> >> OK, your folio has PageCompound set. Then you will need __split_unmapped_foio().
> >>
> >>>
> >>>>>>> freed, and then a 4KB fault reuses a page from that previously allocated
> >>>>>>> folio. This will be actually quite common in Xe / GPU SVM. In such
> >>>>>>> cases, the folio in an unmapped state needs to be split. I’d suggest a
> >>>>>>
> >>>>>> This folio is unused, so ->flags, ->mapping, and etc. are not set,
> >>>>>> __split_unmapped_folio() is not for it, unless you mean free folio
> >>>>>> differently.
> >>>>>>
> >>>>>
> >>>>> This is right, those fields should be clear.
> >>>>>
> >>>>> Thanks for the tip.
> >>>>>
> >>>> I was hoping to reuse __split_folio_to_order() at some point in the future
> >>>> to split the backing pages in the driver, but it is not an immediate priority
> >>>>
> >>>
> >>> I think we need something for the scenario I describe here. I was to
> >>> make __split_huge_page_to_list_to_order with a couple of hacks but it
> >>> almostly certainig not right as Zi pointed out.
> >>>
> >>> New to the MM stuff, but play around with this a bit and see if I can
> >>> come up with something that will work here.
> >>
> >> Can you try to write a new split_page function with __split_unmapped_folio()?
> >> Since based on your description, your folio is not mapped.
> >>
> >
> > Yes, page->mapping is NULL in this case - that was part of the hacks to
> > __split_huge_page_to_list_to_order (more specially __folio_split) I had
> > to make in order to get something working for this case.
> >
> > I can try out something based on __split_unmapped_folio and report back.
> 
> mm-new tree has an updated __split_unmapped_folio() version, it moves
> all unmap irrelevant code out of __split_unmaped_folio(). You might find
> it easier to reuse.
> 
> See: https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/tree/mm/huge_memory.c?h=mm-new#n3430
> 

Will take a look. It is possible some of the issues we are hitting are
due to working on drm-tip + pulling in core MM patches in this series on
top of that branch then missing some other patches in mm-new. I'll see
if ww can figure out a work flow to have the latest and greatest from
both drm-tip and the MM branches.

Will these changes be in 6.17?

> I am about to update the code with v4 patches. I will cc you, so that
> you can get the updated __split_unmaped_folio().
> 
> Feel free to ask questions on folio split code.
>

Thanks.

Matt
 
> Best Regards,
> Yan, Zi

