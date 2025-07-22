Return-Path: <linux-kernel+bounces-740489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 898B9B0D4D9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7743A174F8F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDD62D46A3;
	Tue, 22 Jul 2025 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SdRS63dk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0539E228C86
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753173806; cv=fail; b=c16bJiO+te/chHW5KHKN0+v0lrFaj7whp/Of22bFS87xmqqrE+3V29xTkNM0V5Velqt0GMusyYfSLEHZWv5DJBL6M1iZxMEJynAAK8DwAhpq/ponvSdbhhuyZ8wMHtahiSkUDrLQ4FoYGbUMOINs2nc2VUWGmYZpCeh26IBTmfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753173806; c=relaxed/simple;
	bh=oNYhlaY/y79VZsA/3dv09PQbsuDuEHkfLPmy63jUIrQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aafMlE1o+cOKH7wS8YGs6n/71e7mVy7z8Rr1kzg8S9xgaKNfK/q4x6Ye0xhl/nK0nhLzW7E/nNjPWrzPlgw/BjPYiWtZI0OXbqxvQ2WWSI76cJPf/9QBBaICloGWdMMNkzquFhbMCuacpdHE9o1ZFUEvqXjN7/zd7wj2lQ4GmJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SdRS63dk; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753173805; x=1784709805;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=oNYhlaY/y79VZsA/3dv09PQbsuDuEHkfLPmy63jUIrQ=;
  b=SdRS63dkNBvAWhrteSLBj99X7jcgqeEISlgfMG3hlpVN5vZjA/yFPO7w
   z1rxHdpKTgbhE+Igb0KLxaoeOItRamOmj86SchxUs3QwcaAXVrWanuVe3
   +idvkhM3XBlOdwNGZpw9X4C92+ei/tWH100UhE2URrcBbo0EgM5Ovuze3
   pucrSQKJbPdQciV1frSLP3Z6vPQQ9Jl943mGvopc0MF0KhwScodvoBQj7
   F1hc8WTxix3uaXHRsr7yGg6FB6BgMZkDvf1Gdf7QJa9VUv1gMWpQwQDf4
   o6jvW0HhjH7kjfYjv1wsHbMUVFEhtErDJHs+JKweMA1BbfCReYVyii7ld
   A==;
X-CSE-ConnectionGUID: CDdWs0buQvexVSrB0I48wA==
X-CSE-MsgGUID: ciCiAu5GQdyJnrq9QCalfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="72982332"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="72982332"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 01:43:24 -0700
X-CSE-ConnectionGUID: +SRQp/wpQfGFSlPNjSsDGQ==
X-CSE-MsgGUID: pMKqaNC6Q36jSMtKOt1kDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="158744685"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 01:43:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 01:43:23 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 01:43:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.43) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 01:43:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3kqeJwj4PKHqIwkXY0p0nAxn2d1K4Z9JTOy3VG9izDh1dzvPTm2WVjgD56PYc9gnu+VPlllVXrPu223dxnJt3z7WyL0SEqaIuWTjiPki+o4A5ZEHwXNwLTyiIZk6e+ZzPse9fMbPE2zQuxoQQorzAmXmWprAI0YkTC9xbDdnrc57Z85IHIF6tj6va9asCUVLon9iK7ia5q76m3m8xHVroEjNrYAF47H+Nxtsbj0GvFlLsExwzE84asbAI20iIicxyM0+uRoIDf1WUD7go3KgUiCP0o3tSv6ZXdXBZBUtYuBe84Jtv3UNjryqViN1q+Kj2SiJknR6iRlkyufZlU2Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=060ee1RXEUhuiLHC6bypZSiw+AlCaYbJznUKNL9V1ZM=;
 b=lGpTsd7iLOWcfYErP4E2qjQZpMP2kPTHVsYLjwgpqwfubYWWM/6gP6fLJfIKszQDofhMwOiNZCMtG4k+pk3nEILVhQYJObGxejHOoDPOSJDYjaI10ma4D5+Ys7l+CijP1NGRvnp38I1zMWCWRK5NtgmSK2vsIQzT9BxOPZqSLXF9yRjexcoAtrvya9wEyEbA/b6/TSwSCgeavWicN7ULkmEtdBP+LQseHYycup8k31EMvQJBI86B7BbZeBP5OzGiXpwJrIhWa7sdhxlcGALKg5mkPg6aM3lkCMHv6hRXlzVMc7b8VIQl4QSoPhMrktlBnZFYQESiP8QT5/hboaK3Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by CYXPR11MB8711.namprd11.prod.outlook.com (2603:10b6:930:d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 08:43:18 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51%7]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 08:43:18 +0000
Date: Tue, 22 Jul 2025 01:45:03 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: <phasta@kernel.org>
CC: Danilo Krummrich <dakr@kernel.org>, James Flowers
	<bold.zone2373@fastmail.com>, <ckoenig.leichtzumerken@gmail.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<skhan@linuxfoundation.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <linux-kernel-mentees@lists.linux.dev>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: Re: [PATCH] drm/sched: Prevent stopped entities from being added to
 the run queue.
Message-ID: <aH9Pj+eIuIgNiL69@lstrano-desk.jf.intel.com>
References: <20250720235748.2798-1-bold.zone2373@fastmail.com>
 <66a14b005fa3dc874f4f3261b93901af1292bde9.camel@mailbox.org>
 <e7c0f63678a93261182b69aa526217821552a150.camel@mailbox.org>
 <DBHNK2XQHUIW.TQHV41LR5D8I@kernel.org>
 <aH6B7JruWCkReaLw@lstrano-desk.jf.intel.com>
 <80f569dd3c42f11927324ea80e7c14ac2d3352b5.camel@mailbox.org>
 <aH9GwaquE7OR0HFY@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aH9GwaquE7OR0HFY@lstrano-desk.jf.intel.com>
X-ClientProxiedBy: BYAPR07CA0028.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::41) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|CYXPR11MB8711:EE_
X-MS-Office365-Filtering-Correlation-Id: 701449bb-540d-4083-f493-08ddc8fbce2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXdTNHdjRytNQ0YyQURRd25aVlZNVjIveE9TaHlTc1FvUUtaMzV6YmVJMFUw?=
 =?utf-8?B?aTM1Q3JoN1UvR3lNWHlueGNISGZRQ0tyazVodUkrZUMzUUthVVNYbFFaWEdr?=
 =?utf-8?B?OGxHL2Z1L0x1N09xZW5GaXF3azRyOTNlQkxCQ1Z4aUpBSHpZMlR0aW4zWFlY?=
 =?utf-8?B?QW5JL01zKyt4ZXM2ZVgrS2VIVmpqTFVGUWRkZGJrQ0JBYjNxOUlvcjFtZjJn?=
 =?utf-8?B?Y0RYSC9CaFlyVFRySGQ2cHgzVFRRWWVGQStlM3ZlUjJtYWdJaXRQRWFhU3J1?=
 =?utf-8?B?ZlVvNWtzb1NBaUhLZkVUb2J2dXVEdktydzBXN2RuRGZXckJ3SVdCbjBOQ0FT?=
 =?utf-8?B?My9SNnZnTjdiZy93T2VKRGlPMEJxSXlpbG13M2dIeVVxdS9KZTBzbG9rQkp0?=
 =?utf-8?B?L044UDdhQ3FWcFRpM3pCRTN0eWxvSDFqYzNyem9WWjh0ejRtOGd2WDNOWEdU?=
 =?utf-8?B?aWpsalQ5NDNTOGNwR3pvM0RxTXQ5R01aWnNBNkltcEtaSlZiWW9qNHRmL0o0?=
 =?utf-8?B?RkRWbjNRUzVod1hwUi9TSW5YbCtDbWVqQlJKNDF0b2hxekwyc09xSWR1b3Mr?=
 =?utf-8?B?SjgzRHpJZlhINGdRcFlGcHFGam5aTEZzUS8rYTE0YXNTZlBLeTcvcEkxM0xH?=
 =?utf-8?B?a1dYV2hnYlRFTEUyNHV6bHdqZEhZaUhEcWp0YXh2NlhJTHhmVFdnK0NteUll?=
 =?utf-8?B?L3pOWXpiS2JBY2JENGpkM08wV3NWOGRZL3dWeHhPUDNYMzk1UTBoVDhrWHYw?=
 =?utf-8?B?QTRmcmhmOWlCeVVrc1ZkejVQcHROS1JuTXp6VkZ0SGlUSk1ONFVvUy81dGxu?=
 =?utf-8?B?MFJHQi9wZ1BaWEprN3VuSVBELzlmSVZ1NHZCRUVOOEkrY01zOTBxajVJb2xz?=
 =?utf-8?B?UFZRSGhtcVI0dW43MmFyZVVtTzh2bUhKd2N0MGxPMGtuSDRuSnNPaGZPY3Vp?=
 =?utf-8?B?YWNaSnhocU95Q1RwSHV1ZVdUc0Z0YmRmUUhYQzJhRG92ODhnZ2ZPQ0dxSWFJ?=
 =?utf-8?B?Y0JTUmtueWFMSEdLOFR2c1Q3OUVTcU1zQVdCbWtFcGtTREtYSkswWndJUnMz?=
 =?utf-8?B?dXc0VkdUdXpNRC9WQWpGR0hLdHg0VWV2THovK1AwTTRGVGdsV09ibWU1Mkw2?=
 =?utf-8?B?YklmU3EyS2dYaVVzOEJ2QS9SRjB6VUdHWFd3S25NVlRpN0Eyd3RyNEdneEw0?=
 =?utf-8?B?L0hXUDVWRUJwVmxuL1JnOHN4TWhBNTFCc3p3TFVjYW1WcmUySzRKc1d2Rjk0?=
 =?utf-8?B?TVh6R2lYbG9mb0xQanNYMXZLR1VQUGpRS1NQT0piTk51R0RKVXR4ZXpiWjVV?=
 =?utf-8?B?U0JyNlRnVUVaajRUcmpYY09QdlFTb2dlMXBYeHR1YVpFRW9kMThrdmo3aWlq?=
 =?utf-8?B?eStMMm1QNnd4dldQa2dudWR6QjczMkhLM3Z1bW5Pd3Flc3BjaW1DS2FjZEo4?=
 =?utf-8?B?Q1ozUHhpL245U0RuQ1BlZ05uUWxBVm1aeXo0bnF3aktWclVDRS8zcnJVYnBh?=
 =?utf-8?B?R0h1aGZ5QngxclJuKzZjRGJJU1NuMmY3UFBtc0xIYzdwRVJWNnJvWlMyMUxF?=
 =?utf-8?B?bnNwUGlIVVpoUEMzRlBKWjlVbElHMjBsYWVVcFZwL2FnTHIxbnhuWUhNM3k5?=
 =?utf-8?B?Wi9ZR09yc0VWL3N3TkZyT1pJUHlaZmo3RDk3RW9UcHRjVW0rb21tZDVjb0Jr?=
 =?utf-8?B?MjJNWGxZRHBpTnJNOE55SnhOTlZhbDBkZFI4bTlKSS82WkJsQklOaldzanh6?=
 =?utf-8?B?OEI2TTRXdzlOQXdibUtxUW5DTTJ3Kzc1WnM0R2pGL3RESVJQSURCenhrWFJZ?=
 =?utf-8?B?OEllUUxmZE90YTVqRGp3Zk1NZ2diUTBMamZvTmFvSlYrN1kwaXdrMzA5UktM?=
 =?utf-8?B?aklqR3gyOFNhUFdpNEw3ZFh5S3Y1aUNjMlNvWGliWE1Dd3lhVFJ1UWpXd2RX?=
 =?utf-8?Q?4OtgWjGU28M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU1xTGZ1ZFpwWUZ1ZFErdFFEYzcxa29oUENKS0piTFJhOE55OG9TeGxJM0xK?=
 =?utf-8?B?ck1MbzJVRUEvbTh1QWVnNkN3M0xJckFOcW9ScHJGZHZCMUJYNFp6QWZ2NGE1?=
 =?utf-8?B?dVhPRjRlYVVtR3U4dUFUM2dLRVYzRE1sNU02K1o1enpndUFaR2RlRnBzL2E1?=
 =?utf-8?B?L3I3L3lFNDJzdkZldUtra3hkUkdCOGFDSXZnRDVYQlg1S3pCZFNXWUxhNWJq?=
 =?utf-8?B?RVE1QWFVaURSd1hjbWFOU2JucVh5K0ZaREo1cnhpY2svdmxmeVRES1F1K0I2?=
 =?utf-8?B?YmVxdjFGcS9BcEIzY2xmb0JVL1o1YXRGVis4TFg4MmxTMFNoVzlUM3BLQXov?=
 =?utf-8?B?UzVMemJyWWRzRU5IQTZ2YkhCS3I5bmZmemRtazlkSUxwdmUydTdDSHRPdml6?=
 =?utf-8?B?VGZMMXE5dkYyVGViVEo3cDNCMDh1RUNlK1RyQkZaS2pUTnBKS0Z0NmQ4WnZz?=
 =?utf-8?B?QlFmUnNqUVYyMS9majBLVEdCSEpDYU4yekhwdy9zbTFqR0Vpa0R6Y1FVa3pK?=
 =?utf-8?B?OGNVM3JRUDByOFhwdml1RU12MVF5am5WQTloQU14VDNOVXB2K044eTh5Tld1?=
 =?utf-8?B?bFM2UVFaS0krNnlDUENXWGhiU3ljc1JqbDVyUXZ3SlZkcGlVc2VQaDFUQ0U3?=
 =?utf-8?B?dVl2ejFUell6SWtIWWZscVZVdEZDSWg5OVVybmRkS052My9hN2NZRUFERVA5?=
 =?utf-8?B?TWFTTmd4ajBkR0E5ZHdKNm1OUWpMVGZRekRuYXQ4cWJVZXc5azZvU0RGUjll?=
 =?utf-8?B?by9Fd29QYWtScFFTZE5zYm5LbStvV1pQbVZoV0ZYekFGZGJmNi9OY0pqNytF?=
 =?utf-8?B?bjVXN0pOc1E5YVFXRll3MUtCNjhRS2Z6WDVjZUxhaWoxamZHWHg4WWsrNHRQ?=
 =?utf-8?B?MzQ1enhCeUxLRUwxeTJsUi9QTGxGeDZoT0hBd3o0cWMzUVZKNnlQaGxuOUVL?=
 =?utf-8?B?OTRWOGR5L1VVWlFFdGxIRi94OEVCMXlZQjhMTjBwWHZ1MUNHSjBiWlc0M3pX?=
 =?utf-8?B?dVpNcHdWVlFKNzFmTUVCYm1PTEhja2RZWWVIcjFaQ3c0M3pGbVo4N1Rvd2hp?=
 =?utf-8?B?M2hGQW5hSTZzMzhtUEdMSUFtVng3aFlhOGRIa0ZrUjlYSVpLanl2YU8vQ2Zj?=
 =?utf-8?B?ZzVTYVRtcG5UM2hhaFN4NjVxb3ZYNWdBcHlHZWd6UkpVRXRpK014aURudEV6?=
 =?utf-8?B?NTNKUkRCMGFKay91S1FHcVdibDhCM2FZS1huclR6MnlJL0t6RzVMa3haSEJp?=
 =?utf-8?B?a09kaXVwMkZuTXJJZm9NWVdRdGR5ZUxZQkNkRkhUQ0FObGFUQ0JZVURUcit0?=
 =?utf-8?B?UUpOd3ZBU09VVE5KaVB2UmI0TEl1SVZDbFdQdU5UOHdIaTlua2ZmTldqbjdj?=
 =?utf-8?B?QnlXZGRtSkZOWFA1aUoweHJEazdJUzNZdnNmdUpTODU1WjhPUytCRllUMFdw?=
 =?utf-8?B?SGNvZzVPc3BUaXBhL296U1dIa25sLzAyai94VDJxK3c5MkdJS3N6Q2NneUVK?=
 =?utf-8?B?YlFpKzA1QkRqK09qWUh0MzF3TlpEVytoQ1p6VHF0S0t2eEtibGI4bGcwRkhk?=
 =?utf-8?B?TjlHemFLNlhhQUdOZUdsOS9Ic3dNQW5NV1RscGN3eXdKcHhoT0dXZVhVKzJv?=
 =?utf-8?B?SVFaRVVZa3hJUG95cm9VS0o2eU0wT280dXlhb1VpU3ZjOERLSEFpd3UydDNr?=
 =?utf-8?B?ZlNvb3kwSlhuaUE2em9DL1JNdXRNdzRyeWtGeHdFa1ZBaW9mUk95YTdHMUxQ?=
 =?utf-8?B?My9GM3ZEQ2VxUmVhZFh5dHpFdmpDdzRZRGplMVNxSHpPcG1lS0FRN0VtYnJB?=
 =?utf-8?B?NjNkUWs1ZXh6a0dNK1MyM1IrZXZBOW9JNHJvaDR2MEFnY2NVWDFiaUk2cGtB?=
 =?utf-8?B?Y2lueUFwK2FLYkRUK2JKc2RreFVNNDRRM0g3NHVrNTVISFFqazZ3RGxIVTdF?=
 =?utf-8?B?aFpYUWs4c09RTStpNVpyMU5NT0E1dHNTYXBKQ1FmWVRkZjF1SStaa1ZJS1J0?=
 =?utf-8?B?QmJoMEQyK0lrR1dadUlOMlhoRnNBV25tVnNJdTJ4emlpSUVWNVRpaW5IanNp?=
 =?utf-8?B?OElaUzhHVUNuQUMrOHZnQjdvQ3dia0pieGxLcG8rMWhxcFZLejI3dlE0UDAw?=
 =?utf-8?B?WFJWK1orcUF6dUxsSlhnV096cWpnaDhUYitqanZXNlF2UUpwbGUvdjduVWpE?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 701449bb-540d-4083-f493-08ddc8fbce2a
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 08:43:18.0914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2LCuZTZrOOE1tUJtN4Sns7Mf+WmB5HQI6J9H4iMBJlFHlZRR5CWQoOq1K0iwU2oPd7rWMx0hA7RONEBF+VItiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8711
X-OriginatorOrg: intel.com

On Tue, Jul 22, 2025 at 01:07:29AM -0700, Matthew Brost wrote:
> On Tue, Jul 22, 2025 at 09:37:11AM +0200, Philipp Stanner wrote:
> > On Mon, 2025-07-21 at 11:07 -0700, Matthew Brost wrote:
> > > On Mon, Jul 21, 2025 at 12:14:31PM +0200, Danilo Krummrich wrote:
> > > > On Mon Jul 21, 2025 at 10:16 AM CEST, Philipp Stanner wrote:
> > > > > On Mon, 2025-07-21 at 09:52 +0200, Philipp Stanner wrote:
> > > > > > On Sun, 2025-07-20 at 16:56 -0700, James Flowers wrote:
> > > > > > > diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> > > > > > > index bfea608a7106..997a2cc1a635 100644
> > > > > > > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > > > > > > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > > > > > > @@ -172,8 +172,10 @@ void drm_sched_rq_update_fifo_locked(struct drm_sched_entity *entity,
> > > > > > >  
> > > > > > >  	entity->oldest_job_waiting = ts;
> > > > > > >  
> > > > > > > -	rb_add_cached(&entity->rb_tree_node, &rq->rb_tree_root,
> > > > > > > -		      drm_sched_entity_compare_before);
> > > > > > > +	if (!entity->stopped) {
> > > > > > > +		rb_add_cached(&entity->rb_tree_node, &rq->rb_tree_root,
> > > > > > > +			      drm_sched_entity_compare_before);
> > > > > > > +	}
> > > > > > 
> > > > > > If this is a race, then this patch here is broken, too, because you're
> > > > > > checking the 'stopped' boolean as the callers of that function do, too
> > > > > > – just later. :O
> > > > > > 
> > > > > > Could still race, just less likely.
> > > > > > 
> > > > > > The proper way to fix it would then be to address the issue where the
> > > > > > locking is supposed to happen. Let's look at, for example,
> > > > > > drm_sched_entity_push_job():
> > > > > > 
> > > > > > 
> > > > > > void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
> > > > > > {
> > > > > > 	(Bla bla bla)
> > > > > > 
> > > > > >  	…………
> > > > > > 
> > > > > > 	/* first job wakes up scheduler */
> > > > > > 	if (first) {
> > > > > > 		struct drm_gpu_scheduler *sched;
> > > > > > 		struct drm_sched_rq *rq;
> > > > > > 
> > > > > > 		/* Add the entity to the run queue */
> > > > > > 		spin_lock(&entity->lock);
> > > > > > 		if (entity->stopped) {                  <---- Aha!
> > > > > > 			spin_unlock(&entity->lock);
> > > > > > 
> > > > > > 			DRM_ERROR("Trying to push to a killed entity\n");
> > > > > > 			return;
> > > > > > 		}
> > > > > > 
> > > > > > 		rq = entity->rq;
> > > > > > 		sched = rq->sched;
> > > > > > 
> > > > > > 		spin_lock(&rq->lock);
> > > > > > 		drm_sched_rq_add_entity(rq, entity);
> > > > > > 
> > > > > > 		if (drm_sched_policy == DRM_SCHED_POLICY_FIFO)
> > > > > > 			drm_sched_rq_update_fifo_locked(entity, rq, submit_ts); <---- bumm!
> > > > > > 
> > > > > > 		spin_unlock(&rq->lock);
> > > > > > 		spin_unlock(&entity->lock);
> > > > > > 
> > > > > > But the locks are still being hold. So that "shouldn't be happening"(tm).
> > > > > > 
> > > > > > Interesting. AFAICS only drm_sched_entity_kill() and drm_sched_fini()
> > > > > > stop entities. The former holds appropriate locks, but drm_sched_fini()
> > > > > > doesn't. So that looks like a hot candidate to me. Opinions?
> > > > > > 
> > > > > > On the other hand, aren't drivers prohibited from calling
> > > > > > drm_sched_entity_push_job() after calling drm_sched_fini()? If the
> > > > > > fuzzer does that, then it's not the scheduler's fault.
> > > > 
> > > > Exactly, this is the first question to ask.
> > > > 
> > > > And I think it's even more restrictive:
> > > > 
> > > > In drm_sched_fini()
> > > > 
> > > > 	for (i = DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++) {
> > > > 		struct drm_sched_rq *rq = sched->sched_rq[i];
> > > > 
> > > > 		spin_lock(&rq->lock);
> > > > 		list_for_each_entry(s_entity, &rq->entities, list)
> > > > 			/*
> > > > 			 * Prevents reinsertion and marks job_queue as idle,
> > > > 			 * it will be removed from the rq in drm_sched_entity_fini()
> > > > 			 * eventually
> > > > 			 */
> > > > 			s_entity->stopped = true;
> > > > 		spin_unlock(&rq->lock);
> > > > 		kfree(sched->sched_rq[i]);
> > > > 	}
> > > > 
> > > > In drm_sched_entity_kill()
> > > > 
> > > > 	static void drm_sched_entity_kill(struct drm_sched_entity *entity)
> > > > 	{
> > > > 		struct drm_sched_job *job;
> > > > 		struct dma_fence *prev;
> > > > 
> > > > 		if (!entity->rq)
> > > > 			return;
> > > > 
> > > > 		spin_lock(&entity->lock);
> > > > 		entity->stopped = true;
> > > > 		drm_sched_rq_remove_entity(entity->rq, entity);
> > > > 		spin_unlock(&entity->lock);
> > > > 
> > > > 		[...]
> > > > 	}
> > > > 
> > > > If this runs concurrently, this is a UAF as well.
> > > > 
> > > > Personally, I have always been working with the assupmtion that entites have to
> > > > be torn down *before* the scheduler, but those lifetimes are not documented
> > > > properly.
> > > 
> > > Yes, this is my assumption too. I would even take it further: an entity
> > > shouldn't be torn down until all jobs associated with it are freed as
> > > well. I think this would solve a lot of issues I've seen on the list
> > > related to UAF, teardown, etc.
> > 
> > That's kind of impossible with the new tear down design, because
> > drm_sched_fini() ensures that all jobs are freed on teardown. And
> > drm_sched_fini() wouldn't be called before all jobs are gone,
> > effectively resulting in a chicken-egg-problem, or rather: the driver
> > implementing its own solution for teardown.
> > 
> 
> I've read this four times and I'm still generally confused.
> 
> "drm_sched_fini ensures that all jobs are freed on teardown" — Yes,
> that's how a refcounting-based solution works. drm_sched_fini would
> never be called if there were pending jobs.
> 
> "drm_sched_fini() wouldn't be called before all jobs are gone" — See
> above.
> 
> "effectively resulting in a chicken-and-egg problem" — A job is created
> after the scheduler, and it holds a reference to the scheduler until
> it's freed. I don't see how this idiom applies.
> 
> "the driver implementing its own solution for teardown" — It’s just
> following the basic lifetime rules I outlined below. Perhaps Xe was
> ahead of its time, but the number of DRM scheduler blowups we've had is
> zero — maybe a strong indication that this design is correct.
> 

Sorry—self-reply.

To expand on this: the reason Xe implemented a refcount-based teardown
solution is because the internals of the DRM scheduler during teardown
looked wildly scary. A lower layer should not impose its will on upper
layers. I think that’s the root cause of all the problems I've listed.

In my opinion, we should document the lifetime rules I’ve outlined, fix
all drivers accordingly, and assert these rules in the scheduler layer.

Matt

> Matt
> 
> > P.
> > 
> > 
> > > 
> > > > 
> > > > There are two solutions:
> > > > 
> > > >   (1) Strictly require all entities to be torn down before drm_sched_fini(),
> > > >       i.e. stick to the natural ownership and lifetime rules here (see below).
> > > > 
> > > >   (2) Actually protect *any* changes of the relevent fields of the entity
> > > >       structure with the entity lock.
> > > > 
> > > > While (2) seems rather obvious, we run into lock inversion with this approach,
> > > > as you note below as well. And I think drm_sched_fini() should not mess with
> > > > entities anyways.
> > > > 
> > > > The ownership here seems obvious:
> > > > 
> > > > The scheduler *owns* a resource that is used by entities. Consequently, entities
> > > > are not allowed to out-live the scheduler.
> > > > 
> > > > Surely, the current implementation to just take the resource away from the
> > > > entity under the hood can work as well with appropriate locking, but that's a
> > > > mess.
> > > > 
> > > > If the resource *really* needs to be shared for some reason (which I don't see),
> > > > shared ownership, i.e. reference counting, is much less error prone.
> > > 
> > > Yes, Xe solves all of this via reference counting (jobs refcount the
> > > entity). It's a bit easier in Xe since the scheduler and entities are
> > > the same object due to their 1:1 relationship. But even in non-1:1
> > > relationships, an entity could refcount the scheduler. The teardown
> > > sequence would then be: all jobs complete on the entity → teardown the
> > > entity → all entities torn down → teardown the scheduler.
> > > 
> > > Matt
> > 

