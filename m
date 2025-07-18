Return-Path: <linux-kernel+bounces-736386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9C7B09C44
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D0547B2D1B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C0F217F26;
	Fri, 18 Jul 2025 07:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W9RHudh1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EDE1E521B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752823221; cv=fail; b=QInRC1ZFDfQZd3HN0lvNkL7ex3Ipkz8qvZR7KXQmR87rzVEHvjhUf70b4Ml3MmJqctq5KVyKoggFO3cCRUkoj28Qho7Uw+TA+9rEGRt4M2Ise71WdZVf1lYILDWNiao1dBj80rLy2Y0IH4WgKwzigbSuraVLjwKzZ+0oLzKQCYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752823221; c=relaxed/simple;
	bh=5ZNvk7a7pLzoSdwNfAIff1q9KsHhne/2pbKqWnftMAY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PAuD60+PSLGdIVMu/xMOd7mdOBWomApcHmLwBQx4RD5Da8xVKRiXAzoQo+hNTjVYTSm7VCRuMF9WKWVMkTPmFrIqs2QDcLDwdiDuN8ooh5QMc03veNEq0QdcD7yKgjbesztElGj9fo8wpVQfR9pkWR3frgk2XqtQpQLCGLa7W2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W9RHudh1; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752823220; x=1784359220;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=5ZNvk7a7pLzoSdwNfAIff1q9KsHhne/2pbKqWnftMAY=;
  b=W9RHudh11zD90SRvUxZWO1/WT1xihJvveRNNsODaR1kLnjg4nKjc1rWn
   hTn+FueHM54pA1NyVfTcF/EVWf1C7C1ErEXho38lDtqugRQQGJupwYysp
   YmoM0GAft8Lp0OidErfdQuK7or4TvqlpLPIE2OkTiQOBSIBDUSTH2OLDa
   0aOsnd9lkVg7hGaDa8VodcTpJD43pVyLqxyUzfRp3wxzLvkaruTOxcfg1
   zm2rd844xfN2FqGDV5iAVveKc8hzLwqfTeG6cXjEKQxpjbCoW1tyNKGZf
   BaFl/9+eunufjeHC17vHwmiHeCjNgCjIzkvsDkUVnrtoXW25fxbKzsmxt
   w==;
X-CSE-ConnectionGUID: 0mWdUir6TQy4amFaACOrvQ==
X-CSE-MsgGUID: bbPUtmUnSq+yDwMusHgYRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="54824034"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="54824034"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 00:20:09 -0700
X-CSE-ConnectionGUID: C8BOnco5QDusJGtXAPLD+w==
X-CSE-MsgGUID: kdQPPvxEQQWijD1eihMjkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="181702507"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 00:20:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 00:20:07 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 18 Jul 2025 00:20:07 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.76)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 00:20:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CSlnV+u9ptV462MBgbJouH0jNgWm/Zd52fR0NASP1Fxj4CMakPNLhjB7QOvvNYAYMya/nBGjQ3oq4ve5oBAvcIQGAVDjt07YbPOSnplxmGTRHJ+mx+GNDnAKxiZ8GoT0wUOFuTP15HQVKlIsYgTAVcuek0L4QJdLFKjpMZLLZQO81PV8ypLA3mEBRdzpBQVsYRpMS/D65iYziJSiJJL7OxKavLWSJRf3qi4QOgbsTB5Lj3GUxT3JLETb/6YWm1eCBOQM/jMbDCfzxYzI+/7UeHyQF0wsRa+ty4IcQyivckdRR0xuXiTQrwrYplkIJjhf3cGMPEsFqphViJ1wzWunkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPlhgr6SQqa7xXTTnTXgNS5ljpQyLLKJCkyVLds82WU=;
 b=SMuplGu70DbT+amrAbvI0c9upm8/Z+Gh21oYMWJHDLEoLzH5gi5Wliwnv9M/orjBbz8GcjJ5960hcJqcOdPyl01lair+AXMZXkklozIZcvmiqPgAwz4fv7Oq4GJnzDcr6LYUZMCz/VegHKF6iFzorpa3rtqJx1SSjKaPDiiGSIWlU/UGgObj6ulO32tUaU1wPmew5V8yTEqgCaBfY8KYE0abM9pG72FEGY+834n5LDZry21StVJ2UNkR6bK8glgBy83Na2fAImYWkL+eOVyJs3M0YbI6A3R3c01JJRwV0Vu/T9xig7vuW8Zx1XvynCh1X57Hon5XCSm6cuLbmMKQKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by DS4PPF11E6CAE14.namprd11.prod.outlook.com (2603:10b6:f:fc02::c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 07:19:52 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51%7]) with mapi id 15.20.8880.021; Fri, 18 Jul 2025
 07:19:52 +0000
Date: Fri, 18 Jul 2025 00:21:36 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Balbir Singh <balbirs@nvidia.com>
CC: <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>, Karol Herbst <kherbst@redhat.com>, Lyude Paul
	<lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Shuah Khan
	<shuah@kernel.org>, David Hildenbrand <david@redhat.com>, Barry Song
	<baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, "Ryan
 Roberts" <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>, "Peter
 Xu" <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>, Alistair Popple
	<apopple@nvidia.com>, Donet Tom <donettom@linux.ibm.com>
Subject: Re: [v1 resend 04/12] mm/migrate_device: THP migration of zone
 device pages
Message-ID: <aHn2AE+l5oVTQLox@lstrano-desk.jf.intel.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <20250703233511.2028395-5-balbirs@nvidia.com>
 <aHnw0kEpIDYfFX3E@lstrano-desk.jf.intel.com>
 <83354b1f-8170-4f73-933f-5127f1d12dc6@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83354b1f-8170-4f73-933f-5127f1d12dc6@nvidia.com>
X-ClientProxiedBy: SJ0PR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:a03:332::9) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|DS4PPF11E6CAE14:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d2c15ad-1dce-4f97-391f-08ddc5cb7cd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SE82Wlp1QVcwbU90TE5FUDFwTk5Hd3VseDE0UWxMaVFVMjAwajRJckZRRnpB?=
 =?utf-8?B?Qk1IT3dPSm04M2UrUDdpeFhIZGFJOEdUZmVvYmpjZER6eFc5Zjd2NEtiM3hU?=
 =?utf-8?B?Y2tNZkZlckxsRURWUklzZEp1SU5paFZkUmJrRHBrQWRLTHpUR3dieUptMUFX?=
 =?utf-8?B?WFZyTi9veENtemtHWjZyM2g4bjZXTitOL3FHNzNXdHNYemVYZmdPS2h5VHNF?=
 =?utf-8?B?a3BuRkxQK1pVRzFDVzZocFBIbTF4Q3hsYjlteHFQc3BNV0kybUFPeFFpUUth?=
 =?utf-8?B?TUNvdkc5R0RDMVlDYmorU2FFYmRqRXhkQXFUMUlwZnFacGpDZEJLcG9ZY0Fz?=
 =?utf-8?B?enlPT2drZENqbjBnOHRFVFZnSy8xMWZkTVY2RzlHRDFLZTVCYUhGQ0ZTWTRR?=
 =?utf-8?B?QWkxNWxQcGlOQVpuTnY2YmRUbWFUZFdtOEdqRlJaVTN2bUpNQ1czWW83N0Jv?=
 =?utf-8?B?NWVRQUNIeEU2WUprQjdWNm1wTll5Sktib1ZkUDVMeUlhS3dPOFNheWlCdmdj?=
 =?utf-8?B?R2pSNmp2dVcyZGRTY2NZT2JFNDRqQTY5UnpkVmZXeFB0Zk8xZUJyTHdFcXFt?=
 =?utf-8?B?enZpSTNGa1pwdjVPUGtKajMyclZuMThnL0o5cTltdHVjb2lrNjlnY20zdktL?=
 =?utf-8?B?eWFqL3k0N3RPQVExY0JGS2dldHI2aENkRjdiMDRUK1BGdzMzMjk5OHR6VGRG?=
 =?utf-8?B?RDhUNVFPVllUMWxqNlROd1lJT0ZtV3V3ZGhCMW4xM1VpenlLMnovRUFsc01u?=
 =?utf-8?B?R0lSeU5MS3B1ems1d21sblVFWmVuSWZmSng2NU5CRHpFb0dFbEFSeVRjVnBT?=
 =?utf-8?B?L045TnVPZzFZcjFTUnNxMjVtVWxqaTdha2dpM3JaTjNjelgyZlFSSUZvaG03?=
 =?utf-8?B?bCsxRkRPN1RTdThFN3VFOXg1U3IvVTNYWkloQ05CNVRQZmdydm5ya1UwajBm?=
 =?utf-8?B?VUJUR2dPWVRiMzgvR0VCZGxZbno5SFdneVJBU3gxejNJTmp6bmkvVk5Dejhz?=
 =?utf-8?B?bTdXMFRwdkVVdGYxUVlucTN6RE9iY01QUHNsM3ozZjBOSTN5Smw0TUVZekNR?=
 =?utf-8?B?anlwL1ZLUWV0b1g1NG1IUDhrcFNBcEYyK3dVMXBlckxSMzk4eTRNTWViQXhx?=
 =?utf-8?B?TFg5VzZJMDNtc1VJSjRNN3BXME5RMzZWaUhObmVYNDV5US9lcjV3aFpobXRW?=
 =?utf-8?B?cmxPa3c0UTU2MENwY1UyS2t2azVUdmIwVEh6aXJhMXE3cWNUb0o2Ly8rQytm?=
 =?utf-8?B?MEk4NjNJSHcwekN2T01VSWNpTW9Mb1QwaHJVU2VIcmluaWx0ZVdYRU9aYU95?=
 =?utf-8?B?WTBkYnY4dVBVZUhUck5saUt5ZUE5SnVVVGtlaUJCamN0dTFSbmxIVlpheFNV?=
 =?utf-8?B?T3VpNFpIRUZNZjYyZ1JweWJOM1dXTkFuMnlkRTJJUXhaMVdHaHpxaUtWSGN4?=
 =?utf-8?B?aTN3T0ZuRlJDdUxzYTh6emtWR0dkYVA1d0I5azBydDBKM2w3NDhSQlJFemRl?=
 =?utf-8?B?b0xUSFN0OGxxVXdUcGc5S3NSQU1mVy81Tzg4bURMS1U0NVRFV0RLWnJIK1hp?=
 =?utf-8?B?ejBUcVArK1ZreW43NGVnZ0VzT0hmOVl2Vm1SeHk5NWhmM21rcC9oYXpHZ3JJ?=
 =?utf-8?B?SHgxWlJGTnlieXpZYkxQemR3YUVZdU9UYXpxK1phMUwxbFR2QytIS3Y5NlRY?=
 =?utf-8?B?cUxheG5lbVBnTFY2K3JtVmZWU1Fsc0VMTG5pOW5sVmpnU2NUK2FIYUpmZjhN?=
 =?utf-8?B?WTdEL3MyVEFDRTkwamdjVWtBR2JqdnZGbmM3OTRnNkl1Z1NOd2tSVUx1cDVt?=
 =?utf-8?B?Y2F6OXVKdmRTblorNGE5Qm9jOHlmeUU4V3JCK0ZJRXgzSllRYnA3S1RQRU9Y?=
 =?utf-8?B?VXFCRjNZUUtCVzNrV1Y3YW11d1lBV0h5cjVIWEpVQVI5aGZVTFdRUXVQRUNm?=
 =?utf-8?Q?ZuaF0lrM/tY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1N2YXJqczZFVG0ydVc1aXlkZ2Mzc3ZxcmwyZmNTUUVPbnVtVmpCa0V3a1Jx?=
 =?utf-8?B?RDhyUFlXdWlBYUVyVGZkK2t2UWFJN3oyRklUYnIvZDNTZXVYZDFLQjBMZksw?=
 =?utf-8?B?bmRHREQybHdZanE5Y2ZtQjRxM29UNDNlay9lMVpIU2ZaK3pqWG02RTcwbGxJ?=
 =?utf-8?B?TjZaVC8yb2RCSWZ6c2U3VC82eiswdnRPOWlOYzhweG9VQkhMWGhDYWJOVjB4?=
 =?utf-8?B?Wm9aUHQyN1Z5NnFvZ1YrTDladXlQRnpJMHhyWjAveGxDWnJaY3FzZ0pQNldt?=
 =?utf-8?B?eEh2Ly9WdURiazZNa2pZd295b2kzbS9rMGVwVWovY203c2pEbzBkRXQwdWt4?=
 =?utf-8?B?V3FuQy9vNUo4OWVUdWpla2FuTmV2Uzc2T2lBdnFUSWdXR2E1RitUZzVPVlh1?=
 =?utf-8?B?TnMwMHVxajd3VGVDTmJ1c2ptUHRIZGFqdnBHUTE5Y0ZuRFBLc0Fxa2daSzVr?=
 =?utf-8?B?bUJ5TzVQazIwN3dDTkphbGZXeFRmNU04ZUZvQk9QVXNtaExrUzZoL0J6Wm1V?=
 =?utf-8?B?K2JmREFEZE16ZXZCa0FkWGFINzZHUHhIbGxKYU5oYmFmcEY3NHF6c2RnR2VU?=
 =?utf-8?B?bk1EVDREcEVZMmxFay9nVjRSRDAyZW04WWJLNEtocGF6SXJxMmRRTnJDckVy?=
 =?utf-8?B?REJ1akQrR2F0UlFxNFNWcVBhOHNYMjhHZ3hrSnFZeW5ZUGRtZWdRUHp1NU42?=
 =?utf-8?B?dGhTV000TXFOQWt4YWd4OHJHbmVrdVJHUHlJVWliWnlvK0dEdHFOdHA0NWRY?=
 =?utf-8?B?bWlCWUpvbE00ajk4enZnWHQwNkh4K096K1N1TnVMQzJKcnU1QTRldWpjMWpZ?=
 =?utf-8?B?WXo5bENDMnBjbDlsUjEyeFFTUk5lcWtTS0I5N1p2ZGJXdE1FT20vZkRBOWND?=
 =?utf-8?B?elBUeno2Mk9mSm5RbE5xS2hFMWw3V1ZSUVRQTG0xZnB4Tm9Uc0NBQjZqSTlw?=
 =?utf-8?B?b3hiUjBuaVVTcDNIdkFWYktMdy9OVGs4TjRHcG15TUhTUytaYmlNckhQRTNE?=
 =?utf-8?B?VXhXWTd6RXB6TUIrWnFNclp6Uks0RTBqNCtDVkFieGpYd2xGejJsb3UxM0Rp?=
 =?utf-8?B?eThDR2lxdmd3TkhRRlhHZk5jcnU1blRFYVA5NER2aEQvN0tQUEtmYVN3R004?=
 =?utf-8?B?RFg4NFRKRDBJdkMxYXJucjRDTWRFenk1cEtrTldJczREdEJBVHFnQ1o2bUxm?=
 =?utf-8?B?OGZkQXA4VEsyZXhVckFIWmZiUG13RSs4NVpZK3pvbVZHVlNHR0MyKzA0RS9w?=
 =?utf-8?B?cEphdkZOYUhRMld4YStHalBQZllrM3gzbElaZUFGUkJvelJ2MGIwSVMxTDJy?=
 =?utf-8?B?UU42TlpWTFZlNnhvclZnQmh1V1BGVnFtdHBwZ21PaFNmQ3R0TFgvajd5WnA0?=
 =?utf-8?B?UVY0MzVydE1NVHdjMDZINk5pbHJqWWltQ3g4STd6VkROVW9kYVNmdTUrdkUx?=
 =?utf-8?B?RG9mWXk1ZkczN3l4b1pyMXZGY2g5ZWNXVk5oWXdxMytydmNWREFVOTIxN2xw?=
 =?utf-8?B?YmkyNWVrZC9vSCtybjUvT3F2RCtZeEdCZjlVV3FUSVdrNVlNWlM0TkVmMG4z?=
 =?utf-8?B?UGJieHM0ZUVsVGQrWnJKY25xOGZSR1BVOTdrZ2tEZnNac1N5Qmkyd1UrOTZq?=
 =?utf-8?B?cTQrT081VWtybzM1dE5vSVp5cHRzMTF1WjM3TkdtZmNCaVU5YldmR3dCcEJv?=
 =?utf-8?B?azMyOEM2djFyN3BwNUsxWlNTUEtqV0VMR2xxeE44a2R2Uko3Mm9GeUtOS1U3?=
 =?utf-8?B?SHNIaW5uUEtRbm9zMUNmUGVxaDJ4VjFlSmZxQXpGY2N1T0dKT2NSK2ltYStx?=
 =?utf-8?B?WlErRDZCUlN1bmFvQnFTcWllc0Fndis5czg3SVAxVmpWdlIxKzlROFJLTDA5?=
 =?utf-8?B?amFQVys0ZnA5NG5aOFcxT2pRZ3oydVRHWWlQQTgvK0FkclBYYVQyc0NTWGZ3?=
 =?utf-8?B?SGNDT1B6L2NXNzN2aEpPdlhQTHVadWtUaWk1NmNGbUI2cXRWcHF1RURxbXFO?=
 =?utf-8?B?endEcmhBOS8wQ1d6QTlGdG1XUThCZEcrcWp5Rlg1NWpYcGdMU2F1cFdRYWpG?=
 =?utf-8?B?S01uMjhxU3F0cUlicGY1TW9yZ1dkTkdqRVFxelNTYUtRWVFzVnlETFNsQnEv?=
 =?utf-8?B?VWQvVEFSZzQxL2xQK09XSTZvNTc0MFBVK2dBRmF4YWVsUU15Zk9jZW1uWk9S?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2c15ad-1dce-4f97-391f-08ddc5cb7cd8
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 07:19:52.2161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9j9hqfRFPXA35RU/n47s0xQyvxru23ZLboAzTNTz+iE/j0cIt6FWSVkxiHANcKsBGigoWUmQDkxnY77uvAzmgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF11E6CAE14
X-OriginatorOrg: intel.com

On Fri, Jul 18, 2025 at 05:04:39PM +1000, Balbir Singh wrote:
> On 7/18/25 16:59, Matthew Brost wrote:
> > On Fri, Jul 04, 2025 at 09:35:03AM +1000, Balbir Singh wrote:
> >> +	if (thp_migration_supported() &&
> >> +		(migrate->flags & MIGRATE_VMA_SELECT_COMPOUND) &&
> >> +		(IS_ALIGNED(start, HPAGE_PMD_SIZE) &&
> >> +		 IS_ALIGNED(end, HPAGE_PMD_SIZE))) {
> >> +		migrate->src[migrate->npages] = MIGRATE_PFN_MIGRATE |
> >> +						MIGRATE_PFN_COMPOUND;
> >> +		migrate->dst[migrate->npages] = 0;
> >> +		migrate->npages++;
> >> +		migrate->cpages++;
> > 
> > It's a bit unclear what cpages and npages actually represent when
> > collecting a THP. In my opinion, they should reflect the total number of
> > minimum sized pages collected—i.e., we should increment by the shifted
> > order (512) here. I'm fairly certain the logic in migrate_device.c would
> > break if a 4MB range was requested and a THP was found first, followed by a
> > non-THP.
> > 
> 
> cpages and npages represent entries in the array and when or'ed with MIGRATE_PFN_COMPOUND
> represent the right number of entries populated. If you have a test that shows
> the breakage, I'd be keen to see it. We do populate other entries in 4k size(s) when
> collecting to allow for a split of the folio.
> 

I don’t have a test case, but let me quickly point out a logic bug.

Look at migrate_device_unmap. The variable i is incremented by
folio_nr_pages, which seems correct. However, in the earlier code, we
populate migrate->src using migrate->npages as the index, then increment
it by 1. So, if two THPs are found back to back, they’ll occupy entries
0 and 1, while migrate_device_unmap will access entries 0 and 512.

Given that we have no idea what mix of THP vs non-THP we’ll encounter,
the only sane approach is to populate the input array at minimum
page-entry alignment. Similarly, npages and cpages should reflect the
number of minimum-sized pages found, with the caller (and
migrate_device) understanding that src and dst will be sparsely
populated based on each entry’s folio order.

Matt

> Thanks for the review,
> Balbir Singh

