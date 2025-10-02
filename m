Return-Path: <linux-kernel+bounces-839932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC583BB2C32
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 10:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F70A3B0BED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 08:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B91B29ACEE;
	Thu,  2 Oct 2025 08:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f5c4+yxn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8694B2F2E
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392152; cv=fail; b=dsC6+8tSs0yuqjYzJFWP5/XWzQlPnGmf2lai1VqXkIPbA3hF8I+MiJ20OeD3dWU4wHjHz/aYdvgODTrFV1+ZBzWqz1R43YDKsYLsCoEML0SNyu0v4QIklE5uAOItQGcc2CedrH6g4QP7CrXfVm7m5rBB9p1qYGKvMVEkqH1/gSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392152; c=relaxed/simple;
	bh=wyzpsaXxMW0Lix0rx+c7OgurAq+WtvJfYe9tayU3NXo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NbBiHQ0p7pxIdKka6+FnVPCc4lFfeOe+0Si60L7+/nnIMiIbxmbeCecBiBUyIr7kq83CYB5vFTLAWDvroJSNF9fbuVKm0mY5bXXV3KD03Ss1n4seIgHTE/B2FuseSvvhykw8h6laM99su800Jo9TfR50R+63u+cNGAKmPn+k/3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f5c4+yxn; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759392149; x=1790928149;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=wyzpsaXxMW0Lix0rx+c7OgurAq+WtvJfYe9tayU3NXo=;
  b=f5c4+yxnN540VFJ/hDZv8mTkJIooFgNRLpnuRiLURNg4NK6otvj6FAO/
   cu+q+8OEYWrBqIBfi7Xh78FHbh1UvVv8FQTp66mbNIv0FbJYOexZfADmD
   2oM9oUiudISnR/ZDmwhw3wfo2XEznsw1gZ3unvjXabwQzbSS4L4IjrMqa
   v7Pw6BpGmewMXfrn94xC2NlXcA8MMp+1rLR7nyjIronwqAvUduahgHXz5
   T3JlpYQ4X6Gm5pHXjRW751AdLM7fJgdtf9OWi4vxF9tVl5cY1py8/28My
   7InNY/2LzPM27UJ0vuIiBnJqiYzDHaGB2aXZg56yDF0OfuG6InUtWACHf
   w==;
X-CSE-ConnectionGUID: totS2kacS4CGtkFWlRc3qA==
X-CSE-MsgGUID: rjo09ETZS/iPg3j8ZUGc9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="87118612"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="87118612"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 01:02:28 -0700
X-CSE-ConnectionGUID: Q807JrF3TeKPZyhWfsxcQg==
X-CSE-MsgGUID: FvfJQS+tToeOchka6M7yiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="178941831"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 01:02:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 01:02:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 2 Oct 2025 01:02:27 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.27) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 01:02:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pq3+EW+XYxDzBfZ81NGXGhWL4dXA3rnNy3whqsbfhjxQbHNgwg5tfkEEwX1w6FFYEpXePtEDAv7atmwh7ch7TNrylaLrp5dk+S1vJtwEt+yHFNqg07cVp7hnchJ8cLx357GT9XIcm1LxMiJ/y2RY/Us7LpMb+2ITkSZmKnehuyIh+gIrNlz7S9CwoxMPEHm6WeeLOrZxRY4XAGPU8stTwWhqgRtCr2RknQzoTkfC4mX/tvu9Gpg8Ed24q6cXkrSrgPlWsgFsrz3kJearL9UE19MxXTQ7CsYo2VoffIdm3vXQCwedSn2gZ5U2ST39PtcGKA4T/kP/wpnmK6Xc/+gZ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YJSCChomJ/Lw0SaVnvLw1UKjDUDJk0lOEH9yWUST4o=;
 b=MgWMYsSjp2SXDT3EZ73QgIrUJQGAeThAbFMLedn6eaCyrw2Sx3CF2XZ5KDW+btgMUlrGvp89hRv3VpthFaH4xe/DEK42Hm6Nkf+JvNCqf4U/Cp4q+I1s2taONqd3zfuRgMKi29q9B/W7c8ok2e+0Cegdch7zR6jVmafKPL6pUN/4JvMS19sni4Rz7yT277BFU3RVAAyUVZ6sqXUwsd5NcLXCE//s97rSCxR0uqa7XS24TBhTgydkmd/JRQJVdejG7oXpgOEFLb3aUBLty/Hr6SVaLXs4bqt7Sx7P6dzltuBNl/e22pReS+76hjyqmH8IXDA+HPrRxQJ1JiBWN0WUOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB6669.namprd11.prod.outlook.com (2603:10b6:a03:449::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 08:02:22 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 08:02:21 +0000
Date: Thu, 2 Oct 2025 16:02:10 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Shivank Garg <shivankg@amd.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<acme@redhat.com>, <namhyung@kernel.org>, <leo.yan@arm.com>,
	<yangyicong@hisilicon.com>, <bp@alien8.de>, <mingo@kernel.org>,
	<xin@zytor.com>, <yosry.ahmed@linux.dev>, <shivankg@amd.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] tools headers: Sync x86 cpufeatures and arm64 cputype
 headers
Message-ID: <202510021503.f668f456-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250929061644.19188-2-shivankg@amd.com>
X-ClientProxiedBy: KL1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:820:d::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b3437aa-6b67-446a-9ecd-08de018a03ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZDV6TEZVWjhqay91SDRteE9CY0hoOUlMWjk3T1h6UXdDakhmSlZUZ3hvOUth?=
 =?utf-8?B?RUpJSUhOOXhzRDhzTjlLeUZWUVlTOWNFQTl2UnlqSGx2bzZFU29DWTZlZGN4?=
 =?utf-8?B?NkI5M09adWdIQ3ZlYTAxbmFNb2RlS0Nuc3Q3cGhKY2ZrMXgvZTlvQTZIMml4?=
 =?utf-8?B?dFlXTUhoRkc4UUJOejJKTzc3ZFZwc0pJdjgwQ3RnbHR1RzBFNm5IQWZLQ2lu?=
 =?utf-8?B?RnVHeEhvVCtqNnphbUUzdE03QTBEWnlKV2xWWk5ydFdLOUFaVG1oTk1wS1pZ?=
 =?utf-8?B?azlNeVQ2aDJSTG1EQXdRb0lSUkRXR0ludWl6cm1rZmkyMXl3NTdPR0xvSkYy?=
 =?utf-8?B?QVE0aHlxd0JDWWpxUHAxT1E5UHZkeGZ2UCtJeWFWMm5uM0FSSDNlVHZnTFlT?=
 =?utf-8?B?bVBPV2hvZElQTHp0NkJTZ05nTEFjeUw2QnNDeUVtYzdFcDJQWWJPYjl4cXhG?=
 =?utf-8?B?R0txcEFscE13a2NES0dPYU0xV2JyQTJiSzRDTjFxdENBTWpZdmJZRTdySk9i?=
 =?utf-8?B?Z2lyenlPMVZ0WlhkL01jdThGNlJLTE9XbUhNSXNGMnVNdmZEYXk0N0ZqMmdZ?=
 =?utf-8?B?YWF0RXU5bi9pUWg3S1VKQ3d2NGxOeGJ2cFo2NHBkcjQ1ZGFHcm5iMHl6UTdD?=
 =?utf-8?B?RmdKaVAxNytEdklscE9PUmg2NzdrREh4dzZkWlNRVEVJaldBMkdVMEFTcGFH?=
 =?utf-8?B?Q1JIdUtFLzhsWmdSN3hLSlA4alV3ZzVMRVlzak1NY1lzeFFJVU1ZN0hyVnBW?=
 =?utf-8?B?NHVJckhoSTM0RU0vN0x4cC9JN2QwSEpCUUwzMUgyMUJlM2JvanRrRGhELzZ0?=
 =?utf-8?B?TmFQZFMxWWpDSnJyZ21QVmxSUGRoRFluRzZiL1NxNDNteTUza0ZkNm9WOGI5?=
 =?utf-8?B?bnV1UTVmNTJIMWpEemhxcHdzUXRuNHVCaEErNzJJVTBoaHFTdFlJQTdFeFBM?=
 =?utf-8?B?Ums2NU1xazJ4N1BlblNWa0xXUkRGSGpJelduU0xGcTVUUWl4eTJDZUljdWhu?=
 =?utf-8?B?OC8wUkk3bmxrNTNXcWRkTnB6TUhETDAxaEJxTkJ6M3A3enpwa09xMjhOT3hB?=
 =?utf-8?B?VGNIbTg4SnYrako5QkxxcEV3VVpnRkZuYm1oMm43RytQYXZ5VytvZjNMWlht?=
 =?utf-8?B?SXpYN2dxL05QM1owdjA4MWY2L0w5aVRTYmZEV1VpUjZIeDNNdFNWMFhOVG03?=
 =?utf-8?B?b1ZrdGs4ZGVROXBZR2pBRmEzMUNVckllYUpBK0V6Ti9EYTdyTXJZVjdDUXRJ?=
 =?utf-8?B?RktNbzk3dFVXQkFiRUtJUzBSeEZEQVZoSyswcXRha3BGdlV1SkM1Vi8wWkJ0?=
 =?utf-8?B?MCtuTVFsM0lTQjJ6RXUrL3dSSUlmOWdzanBKVVB2ZUYrYnR1bTMwOGRucTc1?=
 =?utf-8?B?Rk1UYXUrRFlUb0VuSlFEL01wWkVKcXZVcXdjelExTDNxSUZXVjl6aSt5b2l6?=
 =?utf-8?B?eWV2MnpaWXlrQ0U1SkgzQ0x4YXVNRzJZUmhETEhqUjJmdGlnQS83ZThKcTVz?=
 =?utf-8?B?dHY1STM1cFdsc2czaGQxMDY0dXc1L3A3MUE2SEhXY1NZU2REaTBpL0dUR2Uw?=
 =?utf-8?B?enJQajN6Z3J6WklJTnRKdjlaakdDcHV1b2hkZUNwQ0FWZmQrV1R4dzdwb2th?=
 =?utf-8?B?WGEwSFBveFB4NjZYbnM4bjJ2UGI4WFQ1S1hOVGtHM2tNaW9mTThqYVZMSThK?=
 =?utf-8?B?UUZxSTlqMklsakhDQ0I2cStvNGdKc1NXakVXSmNIR1R2WUJrODVvbUlMVjRN?=
 =?utf-8?B?SEI1UFlURHpac1Y3dVRUSmgzUUVhRWlLejZuR05WeG84dWVTTWl1ZDBDaTdT?=
 =?utf-8?B?Y2RHL2RzOHk4N3E5bDN4dENoMG1UWkhET2JTM2JpN28xSnhickNwZFYrajF0?=
 =?utf-8?B?aThRelJQNjU3SmxwampjRy9QdDNSMlJUZEZEandBNmNKVGdSWkRKNzdFZ1Jt?=
 =?utf-8?Q?iN0tVFC9njc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0d1b1ZsM2FiMUJVNlI3V1B4aXFGNmg3Uk9QbFR1dkFkLzFVaTNXaUQza0g1?=
 =?utf-8?B?UTdIOXZ5SE9UV3FVNnlRTTlvVVdjbDF6VXFUY1VxMHJpb3VTbk1lb2dWb2NC?=
 =?utf-8?B?SkdLV3dVL2hvbUwwOVhFU2kzbmx0cXNmU2Qyam9ibDl3cFBPdkVMVzJEbzZO?=
 =?utf-8?B?Mm40WTJhY2wzTlNDQUszdUUrNDRpcjBEWklhcm41L05jM0dIV1ViUS9HQVdU?=
 =?utf-8?B?LzVObzJOa0Rta0ZvQ3RqY1hyZFFFODZkVHRsNFJIREhaRjlJU1NCdlg0cGx3?=
 =?utf-8?B?TkpJOGx5UUMxanFBUndoa1dFR3AzNW91RG1ZeFlsOVo0TEdwZytrQ2N6MUt6?=
 =?utf-8?B?YzN5U2Z0VXBzWlZGTHZ3clJpVXcvMXFrS0FaQWxTeC9VZDlDNHpuakxwWlJh?=
 =?utf-8?B?c0x1NE12OFlvY1N2Y2hRaXNBVkYvV1JnblplRFNwSEF6ZkJoSXNISWdlVDcz?=
 =?utf-8?B?QkxncXJjL0NFWGpwa2pBQWo0VzZzRlJ3TnhkMkJldW5HclZLRHhJLzhESDJV?=
 =?utf-8?B?QVFxZXlwSnYyMzIvVHB2aEk4YmlRdlZhQUpUaGluNHpVK1JFTGo1RVhWZ2pS?=
 =?utf-8?B?TW1NeEp2Y0xTRWRkTG5MckdkUTF2WnFKc2NzTDZWc0VnbVgrWWFZakprajhQ?=
 =?utf-8?B?d2NkZDVXWEFPUnhpekdpMFdMQ1AyVUtsZ2NLQkhDcldzU1F6WDZxZnVnaHg3?=
 =?utf-8?B?dU13YTREZG5EYWcwdmMrUndzZ0ZoTEZvRmdETGZlZUt5dWpZSXBHMWpVMVpF?=
 =?utf-8?B?VU1VM2N6QTAzck9KTnV2aG9kbFIvWnB2eHN6NU8zNjhwMDdKL1JZNnJvMzJI?=
 =?utf-8?B?TWZHVjFvOEVLK1hhbEl1WExFZmZXNmNudEhSMHNyVWVoUVVXQmhwTTd1RjJM?=
 =?utf-8?B?NFBQUjhaN0pqOTBSaUk0MHRnNWJKUy9lTUdpZGtrM3B4Z2hMa3FSUjF3TXhD?=
 =?utf-8?B?OGUzNVIvY2tyV1hPSnNrRWJwOFlOWXBSKytvNlJwWXNTQ2hVaFgzdnkyRjVx?=
 =?utf-8?B?ZElvL0t5NjBZR3ZVNTRVOTF0RVFiTUN0YzI1M1lneC9EdE5oUXptZit5N0Vz?=
 =?utf-8?B?MVhDalY1d2hzRkNDNkZtMXpSNStlR3psSlVMcWhOVlNoVGxjQzMzRGZaS3VF?=
 =?utf-8?B?V2NERHAwcTlSSWllUnRFT09VVDBsRVJQVmZyL1cxK2RCNmxNclBKV0hKdTE1?=
 =?utf-8?B?NExObERyYWlFU0w4YTVTVXd3MHk3RHhtUERhRDUyOVdKNkcrNTZLUzBqNUJs?=
 =?utf-8?B?T1lyQUc4NFdWOWN1M0NqNXlGZ0dmM1JqWnpxRlRaaWMyTXA3WmNSQmFqVnpu?=
 =?utf-8?B?eXJzZmNWV1J1bk54VnpvRWc3anZWLy9jMk5UYllrMjUyWHlYS3B6M1o0N1NN?=
 =?utf-8?B?T0c3d2hpQ2pRU3gxTTFOR0N3OXdhcTM5N0lmVEY3RVlHSjQvUVBnbS9LRVFV?=
 =?utf-8?B?aGFQbmg3b3daRE11ZG9ZTHlYSE5lZk1CQTdOV2NGc2xqa0Zlb3VUZEcyTmdm?=
 =?utf-8?B?NmliNGxCUzd6V3REaHpUNU5YTHFtVitPcU9DalNrT3hKVHN4TTBDWWZhZHJr?=
 =?utf-8?B?UVRmQ2Z6Q1B1Ym9GaU81Yk1Kd3A3VXlMYU9vUVI1blg4bWRmT3JuUWR2Tzgw?=
 =?utf-8?B?WHN2SHJjUm03MzJmdTBhZUhQMnZsUkVIY2hnT3VYWVo3VEsyM295QVh6NzRO?=
 =?utf-8?B?L21jQWVKNlQ3NFR1VVR2VS9adUJwVU5HY21pYzl4c1YwZTdNdVF4STZMdnR1?=
 =?utf-8?B?SHNJYmRDcnorYzAxZURxVXBMc01ubkJrNGQ0d2dOYkVMN1l2eWZTbW9UVFRY?=
 =?utf-8?B?SUJXbUZJNkgyODhudHNZbHZpL05nelRKRlFKRjNkb0NPbXpqYzRBOGZBVTJh?=
 =?utf-8?B?ZDFUN2d3VDhKeG05dkNIcTZiYVBxUWtBYXg5S1VSdW5Gdi82ZGc5M1hsNUI5?=
 =?utf-8?B?NDhQanhWblFZSzZWSy95cVZCYjZ5RzZhazFXUTdLa1ZZSEc1N0tjSjhpRjFw?=
 =?utf-8?B?OG1YRHJGVzlMcC9pbk5jajNGemJtTVVuMDhFeWlIb0toRnRGKzNqMUpXdm12?=
 =?utf-8?B?VXdUVzFNUEw3eWx2cUdkZW4wUVRoYjRyaFlHZWxnK0dLZ00wOWNLd2RhcXVL?=
 =?utf-8?Q?WoUYkhGSu5O+WQbH/5KsvHcbP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3437aa-6b67-446a-9ecd-08de018a03ec
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 08:02:21.7981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLruuEZgh9FjwM7S27OA/zh95kSSO7J/HpctHBzsqc+O/rqUXU7QZ+FTgWxqJbr3t7VvHXO2sAHivc7/+01uvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6669
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "perf-sanity-tests.perf.make.fail" on:

commit: 00bacc579a0558c23b9fb50846091d3eb69dcd12 ("[PATCH] tools headers: Sync x86 cpufeatures and arm64 cputype headers")
url: https://github.com/intel-lab-lkp/linux/commits/Shivank-Garg/tools-headers-Sync-x86-cpufeatures-and-arm64-cputype-headers/20250929-141957
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git e5f0a698b34ed76002dc5cff3804a61c80233a7a
patch link: https://lore.kernel.org/all/20250929061644.19188-2-shivankg@amd.com/
patch subject: [PATCH] tools headers: Sync x86 cpufeatures and arm64 cputype headers

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: clang
	group: group-01



config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202510021503.f668f456-lkp@intel.com


user  :err   : [  247.978055] [   T2565] util/arm-spe.c: In function ‘arm_spe__synth_ds’:

user  :err   : [  248.467637] [   T2565] util/arm-spe.c:885:43: error: passing argument 1 of ‘is_midr_in_range_list’ makes pointer from integer without a cast [-Wint-conversion]

user  :err   : [  248.495319] [   T2565]   885 |                 if (is_midr_in_range_list(midr, data_source_handles[i].midr_ranges)) {

user  :err   : [  248.512094] [   T2565]       |                                           ^~~~

user  :err   : [  248.526499] [   T2565]       |                                           |

user  :err   : [  248.542706] [   T2565]       |                                           u64 {aka long unsigned int}

user  :err   : [  248.558780] [   T2565] In file included from util/arm-spe.c:37:

user  :err   : [  249.826660] [   T2565] util/../../arch/arm64/include/asm/cputype.h:306:53: note: expected ‘const struct midr_range *’ but argument is of type ‘u64’ {aka ‘long unsigned int’}

user  :err   : [  249.854297] [   T2565]   306 | bool is_midr_in_range_list(struct midr_range const *ranges);

user  :err   : [  249.871522] [   T2565]       |                            ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~

user  :err   : [  250.353462] [   T2565] util/arm-spe.c:885:21: error: too many arguments to function ‘is_midr_in_range_list’

user  :err   : [  250.373933] [   T2565]   885 |                 if (is_midr_in_range_list(midr, data_source_handles[i].midr_ranges)) {

user  :err   : [  250.392421] [   T2565]       |                     ^~~~~~~~~~~~~~~~~~~~~

user  :err   : [  250.408497] [   T2565] util/../../arch/arm64/include/asm/cputype.h:306:6: note: declared here

user  :err   : [  250.422856] [   T2565]   306 | bool is_midr_in_range_list(struct midr_range const *ranges);

user  :err   : [  250.439238] [   T2565]       |      ^~~~~~~~~~~~~~~~~~~~~

user  :err   : [  250.465872] [   T2565] make[4]: *** [/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-00bacc579a0558c23b9fb50846091d3eb69dcd12/tools/build/Makefile.build:85: util/arm-spe.o] Error 1

user  :err   : [  250.488993] [   T2565] make[4]: *** Waiting for unfinished jobs....

user  :err   : [  250.502580] [   T2565] make[3]: *** [/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-00bacc579a0558c23b9fb50846091d3eb69dcd12/tools/build/Makefile.build:142: util] Error 2

user  :err   : [  250.527554] [   T2565] make[2]: *** [Makefile.perf:797: perf-util-in.o] Error 2



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251002/202510021503.f668f456-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


