Return-Path: <linux-kernel+bounces-736075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C2AB09833
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 01:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862CE170A91
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A6423FC5A;
	Thu, 17 Jul 2025 23:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CzVLKsd8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4923C23771E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 23:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795544; cv=fail; b=Cte8tZwme0kEB2UEVng4S8wXdrsE2Zdc+pvMkKLEiZeZG+7TOIf+B1CssifteAT7Fjn6xsOrVUStaPNDVU+pnirZQSnHmEbzGEgDRLjSOJM4Q6GALY0d7zKsDFmeM4QVCp8NSrLoWFzftma6ZKGuxa9K8TtsdE9zP15rkEvdN5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795544; c=relaxed/simple;
	bh=nMWaaphf2DsA2xCfB6O1GAmpnD+/ciwU+L8KYHu1usM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZJVee94gnXCKwDxv2+glTkjcu2/ni9u2BWTUOiJlmqTGCnS+3l+3QgfHGKK4qorkiMNYaFZuDJ5PBRZ6LJ9G5i34z7yz6WNxg4be+5Wg1bC0qh2e/qRHiROR6HuJlplD0D/m43rOYRQ+gfygLNrNat95GnmiuACWcJqm6ZnSIZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CzVLKsd8; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752795543; x=1784331543;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=nMWaaphf2DsA2xCfB6O1GAmpnD+/ciwU+L8KYHu1usM=;
  b=CzVLKsd8BddnojCZ9QZ8E4/Svqh5V8d5cPXNLmZYhGUMq65UMfVTu3aZ
   px/pARLvsPEGiaBgk3EJfS6Ttm3zVRqS5W9wjyp/hmOaVODabl9mugo14
   MjKKEoVYeH50XlkZ8BjMzGHrScplybmFoh/1ZdgF63PKAHONZtq8EjZ/j
   BQyg6hzq9pAsNiNzPgCzYVIBrOn5vF1DY4izW0QY5904Eozh2CcUh+enq
   jS59fIdRvbREKDsvJ3r3lUH9t8tZWdAfm4w374+wdsE+kIhIUyCi1vEAC
   bF5IgkJBKamaL6AO3r6fLlo4EGMAiMc5ZNwWmghwLeBLJwzPqFzcdiwdc
   A==;
X-CSE-ConnectionGUID: nNbYpYIJSRqUXyfJHis1Zg==
X-CSE-MsgGUID: FAclAsmfTuGwiM4M+1XTww==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="77625593"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="77625593"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 16:39:01 -0700
X-CSE-ConnectionGUID: qdMZ/KTFQh+q4LJ0vNRNUA==
X-CSE-MsgGUID: KQDnuhC2QaSF3lEA3m8lqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="162219130"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 16:39:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 16:38:59 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 16:38:59 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.49) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 16:38:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ky224BIYXkglzI29a/tRpcGDn6hFhZ4EoEmLI2s7xCiDahXWQX61r7JDd+NST5LcoN6kKLhbSQ064aiX6+0CjkjG6c84q3iex/An5lyEEQeMHvhNeFJLkndYEBoam3+MUFifea4s4qfwLDBowKZNqFmIL3CE8WV9qC7f+gSQ2RoDd884057Ffn48J87qg83AzeBkotF5n0vmaNk1pkwK/37pEIup5zdVO5joKQx6GOl6p0LjfjzvUE15dJiwJ+pJC31Ofnl9RVOFEvh4vYM5PK87vCoR0TfNMu1rDLftu+bAdUyS8W2aY+2uDPzjqUTRzBYk6l1cIJrjvzYkNNCJpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gLRNFGeoSRshy6vhE86e4YHdGcfUCmwLkZigIlMShM=;
 b=C0x6IxdNWBOxmgtfJduPrm2VkLGFeZeYZ9iPX1gYhNFSBvjZAv2BcOlTyKrIFc9cLGFR6dhsDNjutoFYQuo/yp4myG8H5RFyKRAkir9VdUu5DUo0/6w/4jJcGqsYSj+VV+rMDN6AT9IbulXX2pFvC+sY9s809dg6p/ybE9qqLwSN+RtfYimn9e27oA5MyXlNbh5FR9186hZo1V6/zagdFKO4BtBO+diUsKBtX4Dd17VFJu+Km/0kd0CUgy7EQvrUb4fhqoq7XBaWdqsTAgIJM4rA76BSnvWt95vJmh0C7PpltieFj0OggfW4Kd5KZrcO1T33MMMVYriubb6R1HeFVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by SA2PR11MB4777.namprd11.prod.outlook.com (2603:10b6:806:115::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.24; Thu, 17 Jul
 2025 23:38:57 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51%7]) with mapi id 15.20.8880.021; Thu, 17 Jul 2025
 23:38:57 +0000
Date: Thu, 17 Jul 2025 16:40:40 -0700
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
Subject: Re: [v1 resend 00/12] THP support for zone device page migration
Message-ID: <aHmJ+L3fCc0tju7A@lstrano-desk.jf.intel.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703233511.2028395-1-balbirs@nvidia.com>
X-ClientProxiedBy: BY3PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:a03:254::19) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|SA2PR11MB4777:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a22bc9d-b7ea-475b-948d-08ddc58b1902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0pJSms4NVR5NFBsT25EZnRpYnRCT29VdWZZN0Z0Y3gyaWlqWUJIcWZXRC9q?=
 =?utf-8?B?WFcxVlVZcVNEZDlSSGlIMUQvNEtIdmJEbCtDdm1hUGZHMytieWkwbWFKV3l2?=
 =?utf-8?B?dTQ1RmRFQ0oxalVpTlBWeW1HWENySiswYmJIazBCcDFkVFJWcHQvTTk3dkFi?=
 =?utf-8?B?L09nYnBuamJhTENkak1hMFg1Rk05QzdXTEFRTTBVT0kyUlFGczRGVGJnZjV5?=
 =?utf-8?B?alJBbUVEMEd5LzZiSG92L1RIZVlWVWxmYzdncW16K0pMcTg3dzl2Uk5qY3Jk?=
 =?utf-8?B?emZYSVhGdDNCQnNqVDRCTHhnZ1JxNXB0Z3ZOTzkwUDdTTzZyTXByLzV6NDBu?=
 =?utf-8?B?eU9QSnd1LzA0dUtwUWE4MUN2OU1nQVZZVHJYQ2RLOHlkZE9rbjZ0bmZhMlhp?=
 =?utf-8?B?Ky9zblRwRGJUZUdDLzVuVnB4M2M3aENMVWREemFydTBCbEEzNlE5WGdKcXRl?=
 =?utf-8?B?RERSMy9rc2Ixb25BRFNram1zeTkwQXFDdE9PV20yNjNxaDFoTVowc0pXL1dM?=
 =?utf-8?B?NUxRUTVFTE4xc3hPM3FHdmlkWXNOYnpUT0cyZTZvcDRtWUhJaER3NWxXMnFN?=
 =?utf-8?B?NWJXNktWcjRRVVc5cnZpRDJ4dTVBVFVib3FEbnFQcHJnUGlSaWIwZTZaMWZy?=
 =?utf-8?B?bEtlWktSYlp4UjVIRFZaSUdWb3l2ZlJYWlpQdDZlTEJmV3hDRFA5cVdKU0k1?=
 =?utf-8?B?Qm1xcUhNbmxVZmlFLzNsZUJ2RzIyaDdmcDlWc3Rwb05EN09SU2VycWxMQ1dh?=
 =?utf-8?B?aEpjSFlQTi9TbFpDM25IdHNCS2ZjL0RvYmMyRmtyaUtHbTR6ZHZVZTh4ekpm?=
 =?utf-8?B?TWt5bGJnYkJkV2NONjZUSmtMQVNvcUliREVsellZRFZSZmt3Sys4NUJHWEV3?=
 =?utf-8?B?VE54OGVBTzR0ZEV1cExxYmhId0RabjFYbStlOTlpSmltK0tpbS9vR1hBRWo4?=
 =?utf-8?B?OEd1ZzY1L1N4YU1tQ3BIL0dSY3ZpdmNPVGJ0eWpUS0kxQ3I3OXQ1bHgzZ3B4?=
 =?utf-8?B?c1FTZXlqVjhwUXFKeGE0UnpMK3BJYkdlSlV5cHQyQWJ3VWZNbXhBWldUY3FW?=
 =?utf-8?B?dUxhRC9qejkrbjdXVWRCSll1eFV1Snh5M0lBRFRSeldVdlNyanFIUGJWVXIz?=
 =?utf-8?B?eU52YVNQVmNHVXEzaFFqQW0wMG8zU0dPU05MeU9YN2g3MmdYc1BVSjJsR0VC?=
 =?utf-8?B?Y05WL0tDZVhFN1g0MytVTEhvZnBZYWREamRtaW5vQVBTUE04djRtNFRPeEgr?=
 =?utf-8?B?SEVmblVBQ1VOdDVVZzZaTE5teUJsYllERUVZL2wxZG1lWjJCTDl2M1hxMWlO?=
 =?utf-8?B?ZGMwNjZ2dkprVWpQUmR6N0tWSVI2REpGem9UOHZPZTZkYWV3WHJzWGw3ZGI5?=
 =?utf-8?B?dmU0TUdtQy84d0Z6UGZxOC82OFRYYmNwV2djZ0ZmSm5DMVhxUERPT2htWmJn?=
 =?utf-8?B?aEVLT01HSzJocS9LcnJQM2dqb3RPdFFqZ2lPekVObHRYOFJRWGZSTlliVE9R?=
 =?utf-8?B?ZktXZ1EzaldjUk1WZjVDMytUbFNTaW5EVFlKOVlqL2NMUDVaQ3dyVjNsai9t?=
 =?utf-8?B?OTM0a3N2dFFSK2cwa00xZDVtU0FENGNqNUttZUJoaWxPU3p3QUUyb0hSYmdB?=
 =?utf-8?B?V0tXTDZWV1FhV2dkOE12Zi9zRE80endoTHdxOE81TStzMDkwY09Pb09BUGpG?=
 =?utf-8?B?YU1JSGprbUhWdVNTeDNXRUFXaTB2MHM4S2cyZEN1VEkrNVYxTCtXT2lwMnFV?=
 =?utf-8?B?Tm8yT0ZzVk1SN1RNRWRkZmd4Qkgwa2k2NE9CeFBuNmEvTHlML0JXNng3M2h1?=
 =?utf-8?B?TDV6anZqWmxYV09SbkZ0bm5vRExBR1VMdmxTZEhsMzQvdldmWXZBQTBiK3B0?=
 =?utf-8?B?MG9GeDBFMmdROVRDZFpwUnNJUjJXRnh5dXVOZVZBZ0ZFY3g3d1hnMUxUdGRL?=
 =?utf-8?Q?N3GCawB8Mis=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2EvMzZvbXhSRWNndEsxaVB3eDdxOHVGc0duM2FBNDRUaGVJeGFJZnVYNEN3?=
 =?utf-8?B?V1JJNjJPWDNESm1iOVR5RzBpbHptZGVuYXdpZ3krVjdEME5TSk1xVWp1R25Z?=
 =?utf-8?B?eE0vajJUbjN3WWVPT2FROGp5V1F6N2tOczFmK3RCcmtGM2JPMzlhZDF5Y0JN?=
 =?utf-8?B?MkpCS3gxTFdxOHJKdXhneG1KbHI0bjFWS0ZYMndOLzVOM0NhcmFvRkdPYlcv?=
 =?utf-8?B?RUNzUUpwSHovMXRKMklwdUVKNE16Nmo3a1luNGdVak1NUkQ2SVdEa3JqV1U0?=
 =?utf-8?B?T3VKWUxCZFZrSENyWksrOElTd3UyTzZtSWlXMG9ZRVQ5TEl0VEJmdnhrY2Fj?=
 =?utf-8?B?SlVRd0FXWmtwb0JrQ0M1N2NFYWlvR01PUklVTEdFVW1FNVB2WGhuN29qbUsz?=
 =?utf-8?B?dTIxQytCQ2Mwc1dMWEkyUGR1T2VFS09jbE1kTHFaRit0clcvNVA4ZXJnUW1G?=
 =?utf-8?B?aWJjc0ZjaFJuZk5ON1p0RDlRalZFUS9HU05zTlJubVF1UTFEdXJ0NlhRbG1i?=
 =?utf-8?B?VVFJdlpxRU5vMk9lMXNQRXZkb0xMMFFNK2Npbm1vNWRxQ0ZyMHN3YjQybFVv?=
 =?utf-8?B?UjExMVd0SEhwUFoySnNMWStGRkh5WE9nS1pXY2RIMWYyT3JsRE5Xem16bDIv?=
 =?utf-8?B?WHFVclVXQUx5VnEyOW9jM1J1UGIzVXNSZThJdU9oZGdRQWc3MjdFVk9rNzNZ?=
 =?utf-8?B?NFpRUDU5d2s2WXR1bnNnYXByWnFYU3d2OUVZUWdBM0NlTTZPNWJSRnZ4TytN?=
 =?utf-8?B?ai8xK1Z0R2VjQlg1bjdEdmJGSUxDekR4N3JoenRpaU5pYU1vb2hoSDFSREo4?=
 =?utf-8?B?VWVCS3dwN1NLTUNCOUFNRExOclpUL3lWV3hPY3F3ZUdqbmd2dXlFMTAyNWVP?=
 =?utf-8?B?cDVJMUgrZGN4MkoxZ0pCWHJSTXU2WDFCNXlkb0FNRUpjaWE5SkhmNGZ4RGdq?=
 =?utf-8?B?K1VKNDBmcHAyR2FDVnFIN2R3Ni9xaUpXMC9qWkFUVHhDM0dVN1hnOC9BTHhw?=
 =?utf-8?B?dmxQNDZpOXFsMlVSNXNqcjJ0d2o4M0pROGNUWVMyNnRKenZxWmtDQm9aTzhD?=
 =?utf-8?B?eHFOL0thVlVFcGQrTVpyektkNW1MRFM0N1Z3OVdXZVlESTUvTGRYUUxsM2dF?=
 =?utf-8?B?ZG1icmxtZS9JYzBoa1pvb0VRbmx3dSttWXJLR0RwMmxCdUdoandxOGNQdkZ6?=
 =?utf-8?B?ZmJwemF0aXR2TFhRWEI2aE8vZUJiN3R2Tm55SzJ0OE9DNWZyeUQwR2ozYzFx?=
 =?utf-8?B?blBWQmRiWThjZTkzMDlCZXVSbkRmaGFGMm01OUVsUU54K05BblJtNDdXQzk1?=
 =?utf-8?B?dERFZEJ6cHBSd2lQQ25ORytLSGtGRGZtVDRVUXFiMHB1RDZnVmdPL1JId1JV?=
 =?utf-8?B?Q1JHbW5reVNIc2hhRWpHbzc1RUZzQ1YzemRYdkFmMDhsWU1QNjVTNXFrR1Fa?=
 =?utf-8?B?TGthbFJjakRjZzVLc3BNem1SYnJML2lBaEtsU21lbzNQNktIdWNiRFhWYjRS?=
 =?utf-8?B?YTN5L2Jqdk8rR1F3REF5eTF3dFZZM1l1VHRmQ1pNMjRzWlVsMlFlZDdtZ2xn?=
 =?utf-8?B?TkpEVjRENVFWNjhaWlZQN2YyMkRvVUJCMjlVZHFMSzRnTllEOTFEZkpNVnps?=
 =?utf-8?B?clB0THJMdWN5QjNDSjg5KzN5dmxONFpaREpZa2svd0lRS1M3Nm9RQmJvMy9N?=
 =?utf-8?B?OEl2a1R5YVhtc2FRMzFyYVRCWHlBb1FZdGpWdWhVMGx2cTVEdTJyYkM1b0FJ?=
 =?utf-8?B?QjFJVEVjWTBLenhCM0xVcG1QdFlTUjdiNVBoeUMwRkN4NDllRzZzdkRndkx3?=
 =?utf-8?B?QlArbDd4TG5YUFRHTXNGYUd3aHFMT24xbkw1c3piYXd0U0xaWWowR2haYU5x?=
 =?utf-8?B?TXJFalZHZGV3SS9OSnVhZGYyQis5MXI5L29RVVZJNndxdlBLYk9FYkY5S2Mw?=
 =?utf-8?B?THNva0o5ekp0VFc4MHNqRDZURFZxQkg3OThJcXo0bWswWnFjd2tNWG1OYks2?=
 =?utf-8?B?TXRJaXpoNWlxS203MzdGQVdjVHhaVlhseENCTCtYQzVyU2tYc3BvRjRxejEv?=
 =?utf-8?B?OEtrUUluQ0taTTZWRG96eVBJRWRlQ2tiOGpuTU9YWDh6V25PaTlhTTllVE5K?=
 =?utf-8?B?bzV0Q1FzQUl4bFVkWWhGN3FGOXVnSUl5OUZOOVJ3SlZRWjM1QnhzRjJCNmVu?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a22bc9d-b7ea-475b-948d-08ddc58b1902
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 23:38:57.1062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dAJad1hzCDBOemUyH8yw7sf3inDxvgWhLvbdMQzezlEWcP/MtM1dtwE/YK+f9xS2WAGu/zdMee2f5FkqURLicg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4777
X-OriginatorOrg: intel.com

On Fri, Jul 04, 2025 at 09:34:59AM +1000, Balbir Singh wrote:
> This patch series adds support for THP migration of zone device pages.
> To do so, the patches implement support for folio zone device pages
> by adding support for setting up larger order pages.
> 
> These patches build on the earlier posts by Ralph Campbell [1]
> 
> Two new flags are added in vma_migration to select and mark compound pages.
> migrate_vma_setup(), migrate_vma_pages() and migrate_vma_finalize()
> support migration of these pages when MIGRATE_VMA_SELECT_COMPOUND
> is passed in as arguments.
> 
> The series also adds zone device awareness to (m)THP pages along
> with fault handling of large zone device private pages. page vma walk
> and the rmap code is also zone device aware. Support has also been
> added for folios that might need to be split in the middle
> of migration (when the src and dst do not agree on
> MIGRATE_PFN_COMPOUND), that occurs when src side of the migration can
> migrate large pages, but the destination has not been able to allocate
> large pages. The code supported and used folio_split() when migrating
> THP pages, this is used when MIGRATE_VMA_SELECT_COMPOUND is not passed
> as an argument to migrate_vma_setup().
> 
> The test infrastructure lib/test_hmm.c has been enhanced to support THP
> migration. A new ioctl to emulate failure of large page allocations has
> been added to test the folio split code path. hmm-tests.c has new test
> cases for huge page migration and to test the folio split path. A new
> throughput test has been added as well.
> 
> The nouveau dmem code has been enhanced to use the new THP migration
> capability.
> 
> Feedback from the RFC [2]:
> 

Thanks for the patches, results look very promising. I wanted to give
some quick feedback:

- You appear to have missed updating hmm_range_fault, specifically
hmm_vma_handle_pmd, to check for device-private entries and populate the
HMM PFNs accordingly. My colleague François has a fix for this if you're
interested.

- I believe copy_huge_pmd also needs to be updated to avoid installing a
migration entry if the swap entry is device-private. I don't have an
exact fix yet due to my limited experience with core MM. The test case
that triggers this is fairly simple: fault in a 2MB device page on the
GPU, then fork a process that reads the page — the kernel crashes in
this scenario.

Matt

> It was advised that prep_compound_page() not be exposed just for the purposes
> of testing (test driver lib/test_hmm.c). Work arounds of copy and split the
> folios did not work due to lock order dependency in the callback for
> split folio.
> 
> mTHP support:
> 
> The patches hard code, HPAGE_PMD_NR in a few places, but the code has
> been kept generic to support various order sizes. With additional
> refactoring of the code support of different order sizes should be
> possible.
> 
> The future plan is to post enhancements to support mTHP with a rough
> design as follows:
> 
> 1. Add the notion of allowable thp orders to the HMM based test driver
> 2. For non PMD based THP paths in migrate_device.c, check to see if
>    a suitable order is found and supported by the driver
> 3. Iterate across orders to check the highest supported order for migration
> 4. Migrate and finalize
> 
> The mTHP patches can be built on top of this series, the key design elements
> that need to be worked out are infrastructure and driver support for multiple
> ordered pages and their migration.
> 
> References:
> [1] https://lore.kernel.org/linux-mm/20201106005147.20113-1-rcampbell@nvidia.com/
> [2] https://lore.kernel.org/linux-mm/20250306044239.3874247-3-balbirs@nvidia.com/T/
> 
> These patches are built on top of mm-unstable
> 
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Jane Chu <jane.chu@oracle.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Donet Tom <donettom@linux.ibm.com>
> 
> Changelog v1:
> - Changes from RFC [2], include support for handling fault_folio and using
>   trylock in the fault path
> - A new test case has been added to measure the throughput improvement
> - General refactoring of code to keep up with the changes in mm
> - New split folio callback when the entire split is complete/done. The
>   callback is used to know when the head order needs to be reset.
> 
> Testing:
> - Testing was done with ZONE_DEVICE private pages on an x86 VM
> - Throughput showed upto 5x improvement with THP migration, system to device
>   migration is slower due to the mirroring of data (see buffer->mirror)
> 
> 
> Balbir Singh (12):
>   mm/zone_device: support large zone device private folios
>   mm/migrate_device: flags for selecting device private THP pages
>   mm/thp: zone_device awareness in THP handling code
>   mm/migrate_device: THP migration of zone device pages
>   mm/memory/fault: add support for zone device THP fault handling
>   lib/test_hmm: test cases and support for zone device private THP
>   mm/memremap: add folio_split support
>   mm/thp: add split during migration support
>   lib/test_hmm: add test case for split pages
>   selftests/mm/hmm-tests: new tests for zone device THP migration
>   gpu/drm/nouveau: add THP migration support
>   selftests/mm/hmm-tests: new throughput tests including THP
> 
>  drivers/gpu/drm/nouveau/nouveau_dmem.c | 246 +++++++---
>  drivers/gpu/drm/nouveau/nouveau_svm.c  |   6 +-
>  drivers/gpu/drm/nouveau/nouveau_svm.h  |   3 +-
>  include/linux/huge_mm.h                |  18 +-
>  include/linux/memremap.h               |  29 +-
>  include/linux/migrate.h                |   2 +
>  include/linux/mm.h                     |   1 +
>  lib/test_hmm.c                         | 428 +++++++++++++----
>  lib/test_hmm_uapi.h                    |   3 +
>  mm/huge_memory.c                       | 261 ++++++++---
>  mm/memory.c                            |   6 +-
>  mm/memremap.c                          |  50 +-
>  mm/migrate.c                           |   2 +
>  mm/migrate_device.c                    | 488 +++++++++++++++++---
>  mm/page_alloc.c                        |   1 +
>  mm/page_vma_mapped.c                   |  10 +
>  mm/pgtable-generic.c                   |   6 +
>  mm/rmap.c                              |  19 +-
>  tools/testing/selftests/mm/hmm-tests.c | 607 ++++++++++++++++++++++++-
>  19 files changed, 1874 insertions(+), 312 deletions(-)
> 
> -- 
> 2.49.0
> 

