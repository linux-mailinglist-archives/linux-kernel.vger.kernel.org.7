Return-Path: <linux-kernel+bounces-733948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 529AFB07B10
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA32717122F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B39A2F50B8;
	Wed, 16 Jul 2025 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JwTIF8wz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09A82F1FE1
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682990; cv=fail; b=jH4bk3fG6+NwlAAF79RHWtz29CalCVx+t3SLK3OY/v62w1CxiYUqo2FV6OR5TthyIdzKyaaP36KEcDzE/GheB3JLYpPbLwgHh/xOQctWauE1U++R9hIaV3/ECFWUkur5bjynHc9TRDBX9dCtsPaQTa6deBkAQ6cOaFRDexIitWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682990; c=relaxed/simple;
	bh=ejvB5HsY7lcX5a65TP5G2DddmFFgPut5Og2NE5V+Vug=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hz/v+4KWn997+9fZCwYH+OOoEGeHhenzywPa0tAdpT/ANfWDJveHj9mTyqZxjEIN+gq4MUrscd3ZiOcCqMPYZJYiHOOTWFIe3PrnVTpJqydqUHrL/yFZUDH+qu0yn8RwBCKN5C8CYPpEhG6mN2z+enX6KXXjyjMJTEx+Np0fsY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JwTIF8wz; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752682988; x=1784218988;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ejvB5HsY7lcX5a65TP5G2DddmFFgPut5Og2NE5V+Vug=;
  b=JwTIF8wzHmWH+aL6En9NgXg75p+DPljGdtqK9j1sUtHwpoEVCaktxhHo
   I0eMY9jY24lkWQW0+5BzM3fkhhb+TMbx0pzu1+KRNl896vbE2+cajynYl
   l+awrTTIoMHRg4Z8dFiXoGe8wXG3UUXyPdxq3X2SZfZbziuZDOOB2EjYB
   srf8zPeqE5Ck4+n2XWU8cwJOwbWgLivib7o0v9mURRBAVEPbXJlapXCYH
   wBd8mP0BGfsP7t6mPMG6PnJepv/iCoDfRz0ewIKODK2iWhTRBhfYhJntA
   rs04cYM6gMGWGU96HFV8vBRQwVLsfp9A60HqmgKlkl0HoxVrm5MWvmyds
   Q==;
X-CSE-ConnectionGUID: 25i6NSoURJCCAIQKdflhIg==
X-CSE-MsgGUID: 7ci2jnDKQB2QByPwUJvMcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="55030100"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="55030100"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 09:23:07 -0700
X-CSE-ConnectionGUID: JpiScASCR3Kg+PnYgEIb7A==
X-CSE-MsgGUID: 697Fh/f2RGG2W7DteD6NTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="156954871"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 09:23:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 09:23:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 09:23:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.85) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 09:23:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sj9g91nl5mP2b9sgguPsFHAbYOf3RumI8S4YUxqD79+JlpnJLDJ5FsOYXYZJnA3pbt9KANW3WhnnDFNui6sSkyd91JBEU1V57FC+jycFkFKK0j/r6dyr0fTTNR/d5+0BO/aFoQXMlmvy9sXPqyNO1lKLLT8+dNe4AZSG5bLfJ3eFFJN8QWpH7KH2emdv9iIPI3dzfUl+GvG8dCQzgMKQh/YgoRtAJRwKRMnKjXXxbB0yJq2a0O+dZgTLvf8IrLNY0szvGnkZFALXLrJ2KcKBy6Qc4z9CQZIftxAgQRhQuh2FC0+BDWF4D8242LSDhLxP7fXRdth35NQ44FX7/JCjsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5BbA2MZGX6Ufw1W05a8r4vL3Y50P3p1SWMHf+tk4ic=;
 b=apeYA5dmXxKWPP2XXKZcR2QbrIfugQ06P0VX9HbXazRLGkDu6AlUfTCkFK88gtyjn/zUBB3RzV6uxYK8QgETmCk6dANnIUWN/JbrqXW7ToB2Jaezyf9o2hDTvho1MbE+wZXL7Ps1HWevLaVgHly6Ob7hl8kU+5Gfu/SO5aM6KADYe82/WjW68qS6jOEZGS1yVpbUQrhk978tFo9xFXcmGRXROXP592xYCYoPz3K2X8G1YnmxOX0Qj4KVnAZ0Kba5YcSjKMuZfTpq6MuhMDjoM80N0gnRJ9uAKm6Fnd2aeSPYOeshQSIb4DXC+PvpeFc7ycl1flSvDFObmVtWmJiixg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by SA1PR11MB6686.namprd11.prod.outlook.com (2603:10b6:806:259::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 16:23:01 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51%7]) with mapi id 15.20.8880.021; Wed, 16 Jul 2025
 16:23:01 +0000
Date: Wed, 16 Jul 2025 09:24:45 -0700
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
Message-ID: <aHfSTdoi/M9ORrXE@lstrano-desk.jf.intel.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <20250703233511.2028395-9-balbirs@nvidia.com>
 <D129A3F2-D79C-482E-BC70-A26C781B149E@nvidia.com>
 <1a451d37-56c3-4d60-8e06-3abae72e6bbd@nvidia.com>
 <007E2728-5BFC-40F9-8B8F-25504863D217@nvidia.com>
 <aa4f94a3-f601-4379-b6ca-4389421ccca4@nvidia.com>
 <906590D4-04E2-40CB-A853-25FE6212700C@nvidia.com>
 <eab52820-813f-4137-b664-c79ba8b453b7@nvidia.com>
 <aHc5/pmNLf4e9brJ@lstrano-desk.jf.intel.com>
 <1DD0079E-0AF6-49F5-9CB3-E440F36D2D9B@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1DD0079E-0AF6-49F5-9CB3-E440F36D2D9B@nvidia.com>
X-ClientProxiedBy: BYAPR07CA0101.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::42) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|SA1PR11MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f353e7-ed5e-4a53-5b7c-08ddc48508db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ky9PTzc0RGs2VWlXallsKzl4eS9PVGxjUlZoc3VtMDFWbVRneEQybzlUYXpT?=
 =?utf-8?B?Zko1VC9yakdPTWFLUlpZQllWTDdValRrcjNpRmRpb0NsRVVlMEcvL0NGWHB2?=
 =?utf-8?B?b3VhODdIZTd1NG5vaHh6Y0VUQzk1a0ZlS3lYZE5aRkpYTXpiNnh2ZVFSdnJ4?=
 =?utf-8?B?OEtXNkxNZHVjWU92cXNDV1JRYUJsMU80TWhQeFI1WlJ3ZjZjM1VMRURwVEE2?=
 =?utf-8?B?R1JVazg4UEdRcXEwVDFDa0NkWHpsaG1SMWtCM01HLzlIWDdKaVk4dXJoS1N0?=
 =?utf-8?B?MDhYb3pPeW5WeWt6czE4UytHczZoRDE3OGRUdUx1Ynk5MkZ1Z3VEMitOYTVG?=
 =?utf-8?B?aUNHdzk2a0JZYitwVUQzd3V3VFpPdkxONEtWMFJaSUhhOFB0TllZK0hydmRo?=
 =?utf-8?B?S2VsSUYyREpDSjhDUTlxTGpNTGVUYUViYnVNYjRxZVJUaGpzU0hEelVyalM0?=
 =?utf-8?B?RjAvOFdSck1DRDVXcWV0em1iek9LL3B0NnFYZ2NzY3NBVUVoR1Q3NTVpbzhM?=
 =?utf-8?B?MjhIWDhLYzE1RWljTEhGV1M2OElsL09wUWJUb0ZINFc5djlaVGZVKzQ3N2hE?=
 =?utf-8?B?c1BGUXlmMVJIQjF1U3dFS0Nvb3c5aXJDZy80dnNRYk1wUjE5YUMzK3lkL2Vt?=
 =?utf-8?B?N1NEM3hKdFNNMlNuQStDL29ySFpTQktOcllGZ3JsWFlhQXBnTFZuajIrSTg3?=
 =?utf-8?B?aHd4QXcxTmZzd3RzSU4xN05IS0ZlaVF3d2NNcjV0b3UvOWRpaWs2TTY0M2lK?=
 =?utf-8?B?aDhhYlpVcXd6Wkd2ZWkxc1dlWXdLVDlQSStIaVF4eVNSY2xpU1NYQnZwVS9N?=
 =?utf-8?B?VXBsYksxdzFNTmVsVjd6dk05blZFSDAwWkJJcnBRSlhrME13aTRwK0trcVFw?=
 =?utf-8?B?T2R3aE5XSHp4cXF0VjZqWi9GT2dDNS9GVWN3amhNek8vcEhXeTloNDQyNzNS?=
 =?utf-8?B?RkhnTEV4UHVYWlpzRGY4UUYyc2hDUjRNSjk5ajhLMElkNkR5dFdPTzBFMWhr?=
 =?utf-8?B?R3ZRUkNDWnZENVRTdkxpNjc0NithVTZTN29xV2NFd050eE1Cck56Y05lcWUz?=
 =?utf-8?B?UU44bFpGZElnVzRPRksyQW45eE9uQm8yUGdqQTlJYnk0TVA2RUFCUWloN3Aw?=
 =?utf-8?B?c1dzU29ibTVMMTF6OFd1WS9wdyswWTAzeWlJRDkwNG8ydnI4bk9PTnVlYnUw?=
 =?utf-8?B?YXdMWFhwelpmOHJSSGVFWEptL3IwT3FpWXdZRityZ2pRUDZ0UFRVTndjU1F6?=
 =?utf-8?B?RllnQVF4Yk1YamhQbVN4N1VvMHB2c2hpUWptL0lFc20rYld3WnlQWHlSbFkr?=
 =?utf-8?B?Z1JKakFDSFBvZjVyL29tTFlDR2I1VXRORXYySzZvMmFRSTBoazZIdFVpY1do?=
 =?utf-8?B?NVJnU01iMmV1MjY3VFQyZGgvUnhSaFVFOU5lN0lwOTdsMUxYTGduWEx6T2lK?=
 =?utf-8?B?YzlKR2Z4bjRERjdSc3U5V1N0VW8xSHRtZ2F4WDRZL1lBR2lnRW9WbzVsc0Ny?=
 =?utf-8?B?SVhGajdmSi9vRDFDZTJUVmd3eTgyQkpyV3p6NHpFMXdub2RGdEl2MWJlZnJl?=
 =?utf-8?B?NTdPQUFHcE1vdGZoMksvYzRRb25aWXRIVkJ0UFdxbFhPbTJiTUpRMnhBb29z?=
 =?utf-8?B?Umx4SGpodk5YK2QwTlB0NFI5MmY4WjFRUWE3VHJYZTJqT1Ava3AvQzlUN0li?=
 =?utf-8?B?cVhKUU5YSy9RL2xGbDBJNU5scGZCSnZJbDFtMDJxSS9XUDR3WnhOazdyQnRR?=
 =?utf-8?B?eDR3TFVUcllQQTNjbUxUcUpUZmRzbTd4ZmZuOGNKNWRIYUhKWVdmTkVzai83?=
 =?utf-8?B?TXJuRlNtRXdJV2d2ZUdSUlR6aCt6d1o4cFlZOEVaYnhleHZidkFoa01zQkJq?=
 =?utf-8?B?cVlCbTNXd0JRaFpzOG5tTlM2UlBscndqOXR4QWdJdmdsWkFlTUpWVURVWExo?=
 =?utf-8?Q?jCIAppmLMR4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aThKcVF0blZhUjVWaFgrTXF0YTFkTEpGQjluUU9Pd3dxelNOY3FSRGhPak9s?=
 =?utf-8?B?QzlwSHR4WVBZYks3d1F2QUZvcFY1U2tRc3gzZm5uaFdMVWVqNVBWTG9YRnEx?=
 =?utf-8?B?NnhOVk8zZTk4Y29DdnFvMHFtUTRqV0FjSU11YkN3SlVMQWpZdTNmMFZ0SXBF?=
 =?utf-8?B?VS9XSGxqUytIQi93KzduQmw1SHlXUXJRRlVnZGRkNjdqRHFLanhaSC9vTVRo?=
 =?utf-8?B?bCtFY1RtOWloYzhTSGJROWhUL3Y4Ujdkbk1XZW95VkJqOFE1QUR4dlJZUnFl?=
 =?utf-8?B?N1RVTzZBTUxZMy9GYkZRanE4OEVGWlduZU1HaVlreFAxSTVaL1ovekhyZWlu?=
 =?utf-8?B?Vkp3VnlNOTNlaElHWFQ0UTNKdWplV3RvNlAzTlRWQnRtNVhyVFdWMmZmdDFC?=
 =?utf-8?B?cUxxa1VvK2w0SjV4MDFkL1ovcXNwZEZIVjNpNXJnbFdmenRhQTZiOFBuQW1t?=
 =?utf-8?B?N0kxV3Izd0kyN3FvaE1UOTFSWjh1SC93b3Nxem5td1dxbmN4LzVaR3NYajBR?=
 =?utf-8?B?R25yL0NoenNCcmNOa2RqcWNzSXkxVFp0RWtQMmcrOUhkQ1YrSTNWRVFQc3dy?=
 =?utf-8?B?UlNMWjExRnRkUE15MmUybmgrQU0zZUFqUFRsMk12N3NxaFAvTHhMNUpxM2lj?=
 =?utf-8?B?RUlteGtWRm5oN2ZJeS9wdUVNVHdwMERKeHBkbEhFWWFGNnVWaVRCYjNyMkRq?=
 =?utf-8?B?YmlLQkxIR3hVZHVZbzNlQ0pGZi81Y2VuTWUyV29CbDlTc1Z3RnVCbmNZYWlD?=
 =?utf-8?B?ekM4enorK2w4NTJDMEtjRjlhNlI4aGlGZ1ZSNjdlblFhcHlXU0owYXZiTERJ?=
 =?utf-8?B?ajVucjB2UE56N0ZQTXQzeTRMSU1BQk1IZHQwY0FydzY1OFQ3R2tlWDFWSVp2?=
 =?utf-8?B?WmtnclZ4UzI1WHg2UnF4S1JwT2RSa0gxZlhlMkdKa1h4THY1L1psdzNnWVJE?=
 =?utf-8?B?bWdsOVUzVk1LRmlMQlU2Y1pETkxHVTdxSGRQV2hSYnJxMU8wRS9mSVJuMHh3?=
 =?utf-8?B?R29DT2crdFZFc3lBdXVUNzZPV09hOHVQSWh2SUt1S2tXQ3M5cFVobHVEbjNO?=
 =?utf-8?B?WnIxTU9kajk2QXZpV3NENHZyd3FqMVh4VmFTdzNIVnJyQy9WNVJXNm5jazNJ?=
 =?utf-8?B?RjZBSHordHNSa1VkVmx4QVVacXppd3psS1hGMkNhNGQ2MFdXSDhUc000ck5R?=
 =?utf-8?B?M0VxWEJjZTZtclV5VlpRczZZV0JnRUpUcXA4M3JXbVZTeWhkaDZuWnBxV2V3?=
 =?utf-8?B?aWhDdmxNV0Fialk4aUFSM2tyZHRmUTZEbnp5dUppb09kUExNUHZFY1RIU05P?=
 =?utf-8?B?WkVLQ0dvM2E3aDdiVnRPTS9nZG9TcjRlTkNIaE9GQkp3NE5hOFNjTlZkSXBp?=
 =?utf-8?B?YVg5NU41QnFuVm81ZjZ4THJiK0J6djVnSzV0NEtUTHU0NDJiNTk1VEllUWcx?=
 =?utf-8?B?UEZFMTdvcG5iQnJJVThrWEptOXNEbGI3VUdkWU41ZThXU2taYWtaaTV6YVky?=
 =?utf-8?B?MjVuOW81RU9EUTllNyszMlFUb1N1UTVEUXZML1hqNEF5aHFVNnhheWQybG1P?=
 =?utf-8?B?UUNUU3poYmxoMkFTOWdYenlpM1V5TE9MMmNGVk1CNS9FampRbFNYbUdJRTk1?=
 =?utf-8?B?NjhpOE9mVmg5UzFnUVBLYjVhbmVUVjZ0bFJkSnB4TGpST1NjcGZKYUpVTGZv?=
 =?utf-8?B?WS80V0d6MHcrQnI4SW1Id0ZUZUVZTzcrSjUvQUhwWjRFck9VRkdVWjlaT1p6?=
 =?utf-8?B?KzFRVmtPdHNobTNzQnczd01VSzVSQXo1U2dzcUhCVDZpNENpNHhpVjIveFFK?=
 =?utf-8?B?UnIrNzBtejVJL0VJOFlRS3pqS2xsTWhvMGluM2FyeERlYzZwc0xrZVUyS1lU?=
 =?utf-8?B?UCs5YWhhZVY2TTQ2c2x1dDA2SFg3SER2WEF0RXZsUUU1b2UvK2lySlFraE5F?=
 =?utf-8?B?dU1TZEhoeGU1VDhYdUIxQVRIckZ5QzlaemRzQ2JReXRjVngwMTl1ZzIxMzZl?=
 =?utf-8?B?MUdiTFRTWkFGRi85YWF0NytncTl3dFJhZlpJWVhpd1Qra291bEJOMWkxVUs4?=
 =?utf-8?B?S0VVQkFsVE91bEVIa0EzQUp0djBQQTR1WStmdktMVVlKQlovVjl0TFlzQXQy?=
 =?utf-8?B?UTNJQmhudkJtaTZ1dDhESWV5SXlvRVl5R05WK3A0NEZqOEZjQXJ4YlFPcmFt?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f353e7-ed5e-4a53-5b7c-08ddc48508db
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 16:23:01.7579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQ+aPpp5R5BnZfu84ZWvW5IazoUIN2xZr3Tb1b7xaPfZu6seFR4/EmWu3aDCFJqBTR/NR9Zye8pe0rnGcqMYLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6686
X-OriginatorOrg: intel.com

On Wed, Jul 16, 2025 at 07:19:10AM -0400, Zi Yan wrote:
> On 16 Jul 2025, at 1:34, Matthew Brost wrote:
> 
> > On Sun, Jul 06, 2025 at 11:47:10AM +1000, Balbir Singh wrote:
> >> On 7/6/25 11:34, Zi Yan wrote:
> >>> On 5 Jul 2025, at 21:15, Balbir Singh wrote:
> >>>
> >>>> On 7/5/25 11:55, Zi Yan wrote:
> >>>>> On 4 Jul 2025, at 20:58, Balbir Singh wrote:
> >>>>>
> >>>>>> On 7/4/25 21:24, Zi Yan wrote:
> >>>>>>>
> >>>>>>> s/pages/folio
> >>>>>>>
> >>>>>>
> >>>>>> Thanks, will make the changes
> >>>>>>
> >>>>>>> Why name it isolated if the folio is unmapped? Isolated folios often mean
> >>>>>>> they are removed from LRU lists. isolated here causes confusion.
> >>>>>>>
> >>>>>>
> >>>>>> Ack, will change the name
> >>>>>>
> >>>>>>
> >>>>>>>>   *
> >>>>>>>>   * It calls __split_unmapped_folio() to perform uniform and non-uniform split.
> >>>>>>>>   * It is in charge of checking whether the split is supported or not and
> >>>>>>>> @@ -3800,7 +3799,7 @@ bool uniform_split_supported(struct folio *folio, unsigned int new_order,
> >>>>>>>>   */
> >>>>>>>>  static int __folio_split(struct folio *folio, unsigned int new_order,
> >>>>>>>>  		struct page *split_at, struct page *lock_at,
> >>>>>>>> -		struct list_head *list, bool uniform_split)
> >>>>>>>> +		struct list_head *list, bool uniform_split, bool isolated)
> >>>>>>>>  {
> >>>>>>>>  	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
> >>>>>>>>  	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
> >>>>>>>> @@ -3846,14 +3845,16 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> >>>>>>>>  		 * is taken to serialise against parallel split or collapse
> >>>>>>>>  		 * operations.
> >>>>>>>>  		 */
> >>>>>>>> -		anon_vma = folio_get_anon_vma(folio);
> >>>>>>>> -		if (!anon_vma) {
> >>>>>>>> -			ret = -EBUSY;
> >>>>>>>> -			goto out;
> >>>>>>>> +		if (!isolated) {
> >>>>>>>> +			anon_vma = folio_get_anon_vma(folio);
> >>>>>>>> +			if (!anon_vma) {
> >>>>>>>> +				ret = -EBUSY;
> >>>>>>>> +				goto out;
> >>>>>>>> +			}
> >>>>>>>> +			anon_vma_lock_write(anon_vma);
> >>>>>>>>  		}
> >>>>>>>>  		end = -1;
> >>>>>>>>  		mapping = NULL;
> >>>>>>>> -		anon_vma_lock_write(anon_vma);
> >>>>>>>>  	} else {
> >>>>>>>>  		unsigned int min_order;
> >>>>>>>>  		gfp_t gfp;
> >>>>>>>> @@ -3920,7 +3921,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> >>>>>>>>  		goto out_unlock;
> >>>>>>>>  	}
> >>>>>>>>
> >>>>>>>> -	unmap_folio(folio);
> >>>>>>>> +	if (!isolated)
> >>>>>>>> +		unmap_folio(folio);
> >>>>>>>>
> >>>>>>>>  	/* block interrupt reentry in xa_lock and spinlock */
> >>>>>>>>  	local_irq_disable();
> >>>>>>>> @@ -3973,14 +3975,15 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> >>>>>>>>
> >>>>>>>>  		ret = __split_unmapped_folio(folio, new_order,
> >>>>>>>>  				split_at, lock_at, list, end, &xas, mapping,
> >>>>>>>> -				uniform_split);
> >>>>>>>> +				uniform_split, isolated);
> >>>>>>>>  	} else {
> >>>>>>>>  		spin_unlock(&ds_queue->split_queue_lock);
> >>>>>>>>  fail:
> >>>>>>>>  		if (mapping)
> >>>>>>>>  			xas_unlock(&xas);
> >>>>>>>>  		local_irq_enable();
> >>>>>>>> -		remap_page(folio, folio_nr_pages(folio), 0);
> >>>>>>>> +		if (!isolated)
> >>>>>>>> +			remap_page(folio, folio_nr_pages(folio), 0);
> >>>>>>>>  		ret = -EAGAIN;
> >>>>>>>>  	}
> >>>>>>>
> >>>>>>> These "isolated" special handlings does not look good, I wonder if there
> >>>>>>> is a way of letting split code handle device private folios more gracefully.
> >>>>>>> It also causes confusions, since why does "isolated/unmapped" folios
> >>>>>>> not need to unmap_page(), remap_page(), or unlock?
> >>>>>>>
> >>>>>>>
> >>>>>>
> >>>>>> There are two reasons for going down the current code path
> >>>>>
> >>>>> After thinking more, I think adding isolated/unmapped is not the right
> >>>>> way, since unmapped folio is a very generic concept. If you add it,
> >>>>> one can easily misuse the folio split code by first unmapping a folio
> >>>>> and trying to split it with unmapped = true. I do not think that is
> >>>>> supported and your patch does not prevent that from happening in the future.
> >>>>>
> >>>>
> >>>> I don't understand the misuse case you mention, I assume you mean someone can
> >>>> get the usage wrong? The responsibility is on the caller to do the right thing
> >>>> if calling the API with unmapped
> >>>
> >>> Before your patch, there is no use case of splitting unmapped folios.
> >>> Your patch only adds support for device private page split, not any unmapped
> >>> folio split. So using a generic isolated/unmapped parameter is not OK.
> >>>
> >>
> >> There is a use for splitting unmapped folios (see below)
> >>
> >>>>
> >>>>> You should teach different parts of folio split code path to handle
> >>>>> device private folios properly. Details are below.
> >>>>>
> >>>>>>
> >>>>>> 1. if the isolated check is not present, folio_get_anon_vma will fail and cause
> >>>>>>    the split routine to return with -EBUSY
> >>>>>
> >>>>> You do something below instead.
> >>>>>
> >>>>> if (!anon_vma && !folio_is_device_private(folio)) {
> >>>>> 	ret = -EBUSY;
> >>>>> 	goto out;
> >>>>> } else if (anon_vma) {
> >>>>> 	anon_vma_lock_write(anon_vma);
> >>>>> }
> >>>>>
> >>>>
> >>>> folio_get_anon() cannot be called for unmapped folios. In our case the page has
> >>>> already been unmapped. Is there a reason why you mix anon_vma_lock_write with
> >>>> the check for device private folios?
> >>>
> >>> Oh, I did not notice that anon_vma = folio_get_anon_vma(folio) is also
> >>> in if (!isolated) branch. In that case, just do
> >>>
> >>> if (folio_is_device_private(folio) {
> >>> ...
> >>> } else if (is_anon) {
> >>> ...
> >>> } else {
> >>> ...
> >>> }
> >>>
> >>>>
> >>>>> People can know device private folio split needs a special handling.
> >>>>>
> >>>>> BTW, why a device private folio can also be anonymous? Does it mean
> >>>>> if a page cache folio is migrated to device private, kernel also
> >>>>> sees it as both device private and file-backed?
> >>>>>
> >>>>
> >>>> FYI: device private folios only work with anonymous private pages, hence
> >>>> the name device private.
> >>>
> >>> OK.
> >>>
> >>>>
> >>>>>
> >>>>>> 2. Going through unmap_page(), remap_page() causes a full page table walk, which
> >>>>>>    the migrate_device API has already just done as a part of the migration. The
> >>>>>>    entries under consideration are already migration entries in this case.
> >>>>>>    This is wasteful and in some case unexpected.
> >>>>>
> >>>>> unmap_folio() already adds TTU_SPLIT_HUGE_PMD to try to split
> >>>>> PMD mapping, which you did in migrate_vma_split_pages(). You probably
> >>>>> can teach either try_to_migrate() or try_to_unmap() to just split
> >>>>> device private PMD mapping. Or if that is not preferred,
> >>>>> you can simply call split_huge_pmd_address() when unmap_folio()
> >>>>> sees a device private folio.
> >>>>>
> >>>>> For remap_page(), you can simply return for device private folios
> >>>>> like it is currently doing for non anonymous folios.
> >>>>>
> >>>>
> >>>> Doing a full rmap walk does not make sense with unmap_folio() and
> >>>> remap_folio(), because
> >>>>
> >>>> 1. We need to do a page table walk/rmap walk again
> >>>> 2. We'll need special handling of migration <-> migration entries
> >>>>    in the rmap handling (set/remove migration ptes)
> >>>> 3. In this context, the code is already in the middle of migration,
> >>>>    so trying to do that again does not make sense.
> >>>
> >>> Why doing split in the middle of migration? Existing split code
> >>> assumes to-be-split folios are mapped.
> >>>
> >>> What prevents doing split before migration?
> >>>
> >>
> >> The code does do a split prior to migration if THP selection fails
> >>
> >> Please see https://lore.kernel.org/lkml/20250703233511.2028395-5-balbirs@nvidia.com/
> >> and the fallback part which calls split_folio()
> >>
> >> But the case under consideration is special since the device needs to allocate
> >> corresponding pfn's as well. The changelog mentions it:
> >>
> >> "The common case that arises is that after setup, during migrate
> >> the destination might not be able to allocate MIGRATE_PFN_COMPOUND
> >> pages."
> >>
> >> I can expand on it, because migrate_vma() is a multi-phase operation
> >>
> >> 1. migrate_vma_setup()
> >> 2. migrate_vma_pages()
> >> 3. migrate_vma_finalize()
> >>
> >> It can so happen that when we get the destination pfn's allocated the destination
> >> might not be able to allocate a large page, so we do the split in migrate_vma_pages().
> >>
> >> The pages have been unmapped and collected in migrate_vma_setup()
> >>
> >> The next patch in the series 9/12 (https://lore.kernel.org/lkml/20250703233511.2028395-10-balbirs@nvidia.com/)
> >> tests the split and emulates a failure on the device side to allocate large pages
> >> and tests it in 10/12 (https://lore.kernel.org/lkml/20250703233511.2028395-11-balbirs@nvidia.com/)
> >>
> >
> > Another use case I’ve seen is when a previously allocated high-order
> > folio, now in the free memory pool, is reallocated as a lower-order
> > page. For example, a 2MB fault allocates a folio, the memory is later
> 
> That is different. If the high-order folio is free, it should be split
> using split_page() from mm/page_alloc.c.
> 

Ah, ok. Let me see if that works - it would easier.

> > freed, and then a 4KB fault reuses a page from that previously allocated
> > folio. This will be actually quite common in Xe / GPU SVM. In such
> > cases, the folio in an unmapped state needs to be split. I’d suggest a
> 
> This folio is unused, so ->flags, ->mapping, and etc. are not set,
> __split_unmapped_folio() is not for it, unless you mean free folio
> differently.
> 

This is right, those fields should be clear.

Thanks for the tip.

Matt

> > migrate_device_* helper built on top of the core MM __split_folio
> > function add here.
> >
> 
> --
> Best Regards,
> Yan, Zi

