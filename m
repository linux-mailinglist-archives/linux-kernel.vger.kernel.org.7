Return-Path: <linux-kernel+bounces-759623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3191B1E044
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 03:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A8057AF6AD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 01:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7F517A300;
	Fri,  8 Aug 2025 01:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X9ERUusY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11125156236;
	Fri,  8 Aug 2025 01:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754617657; cv=fail; b=nSEYUWHmQRvsZ8YZ1UklGobvma+jT8jVSNNoDh8RYNg2scLJGuf0ZCKJH3vfwl8h7+BY5MhmQY0k1YldP0kZ98jp2QsDRf1bttjWpEs22F5ib/iyt/jsBZgKdQ5OFaeM+Bx9mh4FEMNbSADjJru842ldWRfYOkQLlV35JS5B29Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754617657; c=relaxed/simple;
	bh=9T35EUCDojYobfODceIdqR1QsXUv6LWZf1SxDP5P3fs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YXaccpFSvMJ+TbDzIL0pLIub244zVmAcieWKTqlRQqLQ8xHtucHZVKiWnQ7banE9baCMDOjkqe7NWmFh1K4qZa/ay8SPZ1lgS7pNHap/d7YzGQ0zyG7es+v7ey6FaqvrdSulPl5j/ZjVh/zFJ7w0PZwIIAet4vunM8vvEg+VWHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X9ERUusY; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754617656; x=1786153656;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9T35EUCDojYobfODceIdqR1QsXUv6LWZf1SxDP5P3fs=;
  b=X9ERUusYsgW++Emv8kMaNeZVHxMS9PWSLv/Z8mC6gnrgT46ku8IGP+HI
   dwZvDW2xSjYFkwStGimZ1NoNEqpItRIUWB1ZZYtXVaRpcJEPn1BTxa+fW
   Z8DogrjlyRgfNNOD5F96VfHy5IixpfGOGIvzXUMdeyetaUnz34+0f3PVo
   62EhcnW6X8MKHmIQ05u4mnMqm+NN0QgZKmV2GTzuR7F3Iam8eIgL/k0Y9
   wASc6YY7tT0BF0v20FroanlVOwQdVi1xN9k8jKap6r/+4wTSp1ll7m4DV
   ExRpCy3ZcZbABkcXhddFsE4e3y37ygTrgjpN4AAmfF1/tpPFmrICyuGnQ
   A==;
X-CSE-ConnectionGUID: Pvky3tuhTt2ZE0iTP8SY0A==
X-CSE-MsgGUID: MvRQCDyZSmu1/RXuFqRciw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56885108"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="56885108"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 18:47:28 -0700
X-CSE-ConnectionGUID: IGShYHdXTMmQnWHS/ai/rg==
X-CSE-MsgGUID: lozhKTJLSjmwXysgS5p4RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="165226466"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 18:47:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 18:47:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 18:47:26 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.51) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 7 Aug 2025 18:47:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPcHBOEmfJ26GT5wIUSZkPXpLQwSlT3fxpawCjimeLHbGCPnakbBmjBsAefncO2Vf7bBrOIfliLo3bjgc6H/pUdQCGh/xVkRWWtjJkhjTyLwsQMu+QyHfeInz93/9lgbGM/DektTpSYb1YrQ09QRHdyrGAKVLjK+PzTVAqFXxnmtbKHThXggM4Q7L4MZbh8E7rGBHwH/zAFWQIO4+GOcwDCLBV9KtfpuQssBY/m/Rv/yc8uWghQ0ixmmT/XLDGqIrMswfNlojLBE1WXt3QPvBJJWRczwTPNM2lK4S+I2M9DgcFDJafXZQbdE/Lj/CUkKnx+pv0DBmNnGzAkFjLCarw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTYdoNtc5qPPTQDXriJvLe/RYpcfbQ1DDBsVupt/h08=;
 b=Ejs0KMRW9kom/LPiOTTFgExNoP/uVz4JavdvcIjnh13S4UDs5b4ZmHsChiQAFaGUVv/7KuRnSgtPFF0spKGDlbTCJ/SAjEEjsl8zBBdhSk5j3KMxUS8avmSjhxXqLUz1qbprMG2lXy1hEAXHYwE3BypgsLIekpSq0DTlgvByEqXvY8PRPgcITNBhYMssC6niGB50dNIr3MivtRfrmgrqOF4Qvbu77Q18C/AtPcHKIDzZf7xi5shLnmmT/IxA8J1B4rQmc6hWUPCa8MRdoXcv9PU7XQa/vdqPp7uBKZZgcCDS9fauKAOELPdkTOh5hFRYH2uA7IwtDrAYTOXOP96XAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW6PR11MB8390.namprd11.prod.outlook.com (2603:10b6:303:240::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 01:47:22 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 01:47:22 +0000
Message-ID: <53387aa7-0e72-4bf9-a188-43c0f78c2d6f@intel.com>
Date: Thu, 7 Aug 2025 18:47:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/10] x86,fs/resctrl: Implement "io_alloc"
 enable/disable handlers
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <rostedt@goodmis.org>, <Neeraj.Upadhyay@amd.com>,
	<david@redhat.com>, <arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <pawan.kumar.gupta@linux.intel.com>,
	<yosry.ahmed@linux.dev>, <sohil.mehta@intel.com>, <xin@zytor.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<me@mixaill.net>, <mario.limonciello@amd.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <ak@linux.intel.com>, <chang.seok.bae@intel.com>,
	<andrew.cooper3@citrix.com>, <perry.yuan@amd.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<manali.shukla@amd.com>, <gautham.shenoy@amd.com>
References: <cover.1754436586.git.babu.moger@amd.com>
 <40ffabb62f9f36aae6a8dc26e5f2e376a3dee23a.1754436586.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <40ffabb62f9f36aae6a8dc26e5f2e376a3dee23a.1754436586.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0261.namprd04.prod.outlook.com
 (2603:10b6:303:88::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW6PR11MB8390:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ae126b2-017d-4bb0-c57a-08ddd61d8481
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmIxT0VCNW9ISjRFUUhiYVVkNnFkbXpmbnFWb244Rk5nbW5hVTlEMENNY1BF?=
 =?utf-8?B?RlgxQ2QrUjljV1lVL2E3OU94b2wzM05GdkhxQlFGQkFwbXpZVVBmNTlEVzJi?=
 =?utf-8?B?NUlIcnkyKzJaSGFrclZ0c2g1Y3FrOGFrTHhNTkhuaVRrZDFiMFovZzdyVzZ0?=
 =?utf-8?B?QVl6d0dZYmNIczB2Ry9CbUlnYjQzWjBtc2x5RHJqMFUwb3BhQVNRRU5vRWRC?=
 =?utf-8?B?cVdPNDlwZEpKUFdnQy9rck5LYWlWWGZLTUFaRUNaWmRmQzVXbElLd01LYW9Y?=
 =?utf-8?B?M1NzN3NQYTV4TStZelowN25rVnRqRVprQk9pM0RqczZFT1JacnZNZlY1b3ll?=
 =?utf-8?B?TXRvTzJ3RWVtcnc1WkZmNEowaXR6dzhPcm9ZYXJBSytqWHV2VVhGeEZBZlg0?=
 =?utf-8?B?d2R0RkZFUFN6bzZUaWI0QjdXbDdmbWJMcnRPM1R0SnBvYytIRjJkbW1YTUFt?=
 =?utf-8?B?eEMzRU1TK09KVWVjeUtPQ0xoZG04blZEMnBreGlueStFb2JhK0s1bTFMTUxq?=
 =?utf-8?B?N0o1eVlXRlpyUW9IWWZya2tQamo1eDFFcnJRZHliTW51L2o3RHllNjMrMERQ?=
 =?utf-8?B?d2xnVFovd3pZMjF2ZlFkZ3RKdXlBWSszQXhYdCtGOFlxNzYyMHNubXhxZkZY?=
 =?utf-8?B?dTZGY0kyaVRib1dHMSsvMUx3dFVHbUJLKzByUHUrRFhNUUt0SEhWZ3lVaTB3?=
 =?utf-8?B?SG5vUllSaWE2NkdvT2dlaXhVQWU4QU1tSUhaYnpNMEsrZmQ5SExZYjM4Qit6?=
 =?utf-8?B?bHd1ay80NlBDNEkwNlF5cndYc1RGeGMyRWh2bC9HN2hjaVVaZzlXMmNwVGJF?=
 =?utf-8?B?a2p0S3RNeEM3YkwrckhNek1xd1lqaVZQWDlaMlZmWnlxREFuZGR2SVhaU0l2?=
 =?utf-8?B?M0hQRUFwTGVPaS9pQjNpWG5UUE9yQnlMNmVIRFZvTFBwNkloSzBkWGZrN0Ry?=
 =?utf-8?B?cWg5MUNkT0dCZ2lDVDJnak52SlcwRy9zOXV2aWJwN1BkNTZ6MTZ5TlNxWVJH?=
 =?utf-8?B?QnVxVEVXcDRlK1VudzFoZlNKT3IxUU5SS2tUNzl3bU10K2t4KzljQ3NwUnBn?=
 =?utf-8?B?YWI2MU5UOWphdzFPeElyc1JLRkpvQmtBQ25XM29WS2ZhUWZMSWtrSzMvbEkz?=
 =?utf-8?B?R21vN3kvVWJ0SDZ1dlU4eUNsRHFNK1ZyWEtMY2JvSklYNmpueVB1c2EveTdJ?=
 =?utf-8?B?dXcwaWZTanNUalFUeFVFQ0VRTmNVcjNrTEs3Y2cxSys1Z1lVbmNMbEtJM2xD?=
 =?utf-8?B?U1k2KzQrK2xrRUhiSU81bis2WUJaK0tYVUJ0K28rTTl1bUNwbEtwdWRCQTlv?=
 =?utf-8?B?bjU5b1ppN1JSZWZKRWMrTk0wdXZRQVlBSjJLclVQclhTNi9lbkQwaW0zMEwv?=
 =?utf-8?B?TW5JcUxtK2ZLQ0JPTDBBMENkZjFLdVoyYk84MGtoWUxraU9HcHFFT2FaNXRN?=
 =?utf-8?B?SCs3Ty9DVkF5ZGlyS1dDN0IvcG5MdUlMZHZoTmJIckF6NWNPZFJKTGJmSndM?=
 =?utf-8?B?VUdFUjZkcFpJWXltZXdKZEhmaGRuWmtLcFVoRGsxaWJPNmFpeEFFU3JXaTVJ?=
 =?utf-8?B?elZFWThjaTBYNVBzV3NxQXhNa1Y0RU5TTjdHc0FUbnFhbm5UbWJZNHByUnRR?=
 =?utf-8?B?RFlVU2JMWDJjWG4xTU5wQkdrbGFkOUl5Ulk1MWVFYVFXN3lUOWV4emdkTlll?=
 =?utf-8?B?cUxKSkRzTEE2cVhFcFZVQ2Exa1RqMnNlUkdYYUNxaG9jTjV6SENIdVpNaStX?=
 =?utf-8?B?clNYMlcyMGZBTUxEY2ZmQTNRbGFRaVQvNko0elk3N0syNWpFSlhndHErb3dO?=
 =?utf-8?B?Ykx0OWMzNXVBQ2p5SjlTTHVrWnJpalIrUXdFL2gzeTZLNmhpOTlHUkxMVjFw?=
 =?utf-8?B?SUZhbFI2OERqV3RWYUdETHNPOWZGMHZub3VzcFV5THN1RVVVTG5SZnhyampE?=
 =?utf-8?Q?h0R6KBa/b2A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3pkcjVKckNhMEZTaDg1Y1dEZjBEOTR6NTNzTmpUY2U3a2Q2TFY0eHRZYkxW?=
 =?utf-8?B?VElqQWUrQjlBLzhpOVBmM25qTHpHdmt6clJqZFhXaU9jTFNINDhGNmxPT0c0?=
 =?utf-8?B?bUJiMGIzaTI5VXNtOWw5Q3N1YTJ2cVFza2NZOGplWHVxSkRVc2JxQW8xMk1R?=
 =?utf-8?B?T0liNldMRlF5Y0RHVWtNS1ZhUXFybGRiVHlSRVFsVWFJclRvV1d3bmhhVGg4?=
 =?utf-8?B?MlJNQllDZDhmeEtveS9veHlkNEQwaFJmOTZ4bHVVUGRZMnZMZzQwSnJ5Wk1v?=
 =?utf-8?B?NlNMbGYvTCs0SllkTElWY3kwMHp0aWh0NzJwN3Z4MTF1VGE5d0RSb1U1cVl2?=
 =?utf-8?B?TjJ0RjdDR3VvdUNKeWlpYy9GK2Q0c0xkT3ArN3hrK3JyS0lCZlpoU2RkNUdH?=
 =?utf-8?B?dWo0cXRwVFcxRzRTUmh1NnhMbEdMRmdHR1N2YnlwSEFlZlZ2Y1laVUYwUTBT?=
 =?utf-8?B?WG9lMVVLcSsyNisreFk1WFA0L3VkVE1aM0RrOGFNSTBIV3p2dStKcUxhTjQz?=
 =?utf-8?B?d0VUcUdTSjFUTDBaOVRuOGJ1WTYxbVVvR1hWNGxaRDRFRTRuQWlCRFdMNkg5?=
 =?utf-8?B?Q2NYbjJPZ3dZUEoyZERoenk5NHI5d2FER0hnRnN2NUZiZlFOU0c1THVHZUNK?=
 =?utf-8?B?THhwdTk0TnRHbkFBcnAyV0ltbFdMOHhaRlhiL1ViU3JrSnFYMzV6YTJueVZn?=
 =?utf-8?B?RG1vR0Y4LzFUZ3BVaGdVK0hlc01SbFlRYlVKSWUrNUMxN2FORW9jYTZ1dGRP?=
 =?utf-8?B?bmE5NkZZZVdRdFFrbktXVU02ODRJREx4R2luR2lsS0lNeGJ6dVRIVE1Fd0NZ?=
 =?utf-8?B?Z3FmS2I2SnBqaWQrZW9hZFNFNDdIS2ErbFZvcitYdjNuQlJodjUvTUFkd3M0?=
 =?utf-8?B?V011ak1ha04wVTVwZDVmZzhhNGd5dHAzMGhoMUhpNi94SVpoNUlwMEljcmhz?=
 =?utf-8?B?dlIyalBveGIvZlV1cUUyNnJYa3FOb1ZhdGpEK0NOSVE4bUlOMytWQkhTT1hw?=
 =?utf-8?B?Vk9MSHNOM2tVdUNZK1M0NEgwTk5Vbnh3TmFDVEl3UWZaUTZhUUtTWUltbE5Z?=
 =?utf-8?B?MVU0Um5nbTVLVVJaREh3TzV1aUlSNk5ydU4zMUx0emdIaWFtWjdQWXAxOVBl?=
 =?utf-8?B?RGJDSmRaTDV0T1RpSHE2WHFZdXBuS2dCb2ZTKy9BdWwvRm9CK1ZXZjA2U0Vj?=
 =?utf-8?B?QkNYRXNXSVQ5VzhtcDVxU0pnRXRzNmZSWVNjNVh4UGV1S2xWTUxLUEt1SjI3?=
 =?utf-8?B?aXIrR0I5dXVIM3pDdVEzZW1NOG9CZ0crRzQydk5HQjFmaWJHZjd2T0ZxUzZF?=
 =?utf-8?B?b0g2SHY2aWtBeXV3SzBGMjdyTWtKVFFEVm11RkhHcjNNWDIxVjhUcW9tMm93?=
 =?utf-8?B?WWdzZHBTbnVGVlNRVmtTTDhLMXpsWUpCa2FiVWZ5ZzZ5ZG9GemhBV29Jd1V3?=
 =?utf-8?B?WHhiS051TURkSUtWeDBKaXE5N3J0b1pzNFdyQzJXYjdDYUxab2l3RDl2TmpV?=
 =?utf-8?B?SDQwRDA5UEpRYjZHMS9RcE82TWZTdGVUNGF6QmtCdm43ZjMwdklmUktSeVZx?=
 =?utf-8?B?ZzRldzNJS3VvaG8wdEhrV0RUMHRlYU55NEhSUURjandOVEdYTzI4ZG40c3FY?=
 =?utf-8?B?eWZlVmFQMk5HeFE5ZXdSaUcxT2lNVHFYWk8xRUR6RkI2RE83WDUzck8yRE5w?=
 =?utf-8?B?YXhLcXQ0aDlsdWw3QUZpMWJvWVc1aUZzbkc2L0xhN1BsMFRyaVkrYjNsY2NI?=
 =?utf-8?B?YWtRVFRNSDhnck9aTzJZbjFPdEJBd2ZmVkJGNGVjWjFRb3BnYStydGZjbDIy?=
 =?utf-8?B?RE9KOGtYYzhvYTRuNUlFODFlaVcyQXV3UE1hQ0FFc3NHMTA4ZmhCRzRjNlY2?=
 =?utf-8?B?MUd6ZFhXOVMzc2xZdGs2aytsL0IvRTd2Zm9iOGZZMUxuK3o0VHpnVFUrdFhp?=
 =?utf-8?B?c1VPWkVhWVRmbVBDNG0zTmlZaDlSOVVHdXY3eTAvSWM0Z2w2ZHI1bUJ4RVI3?=
 =?utf-8?B?aCt3OVdzaVV6dzFKS0pXVzFQeHJBSmxFRDl6Wlo4bkRtckxTVWk3bjArTSsw?=
 =?utf-8?B?TTBZek1NSVRvRFQyMGQzdUROc0xYWmRpR1VUUVZzVEJVVHdNWW5tREY1cGsx?=
 =?utf-8?B?M1lDWHFTejUzV0thNzJ6aUZlWlJYRUx6aFZHV0tBS0dEcGc5dElLREk3cTBw?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae126b2-017d-4bb0-c57a-08ddd61d8481
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 01:47:22.3732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fMiLa1lv/wKUAwUOKReSuNBIhyMlpJcc8s2S93Rhlgo90q0BJRKlCHOm2mK3C7cIH0MdpSa7q5spECeu50V+aSYzH6VjyaL0uQ1snEP7TE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8390
X-OriginatorOrg: intel.com

Hi Babu,

On 8/5/25 4:30 PM, Babu Moger wrote:
> "io_alloc" enables direct insertion of data from I/O devices into the
> cache.
> 
> On AMD systems, "io_alloc" feature is backed by L3 Smart Data Cache
> Injection Allocation Enforcement (SDCIAE). Change SDCIAE state by setting
> (to enable) or clearing (to disable) bit 1 of MSR L3_QOS_EXT_CFG on all
> logical processors within the cache domain.
> 
> Introduce architecture-specific call to enable and disable the feature.
> 
> The SDCIAE feature details are available in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.4.7 L3 Smart Data Cache
> Injection Allocation Enforcement (SDCIAE)
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537

fyi ... Documentation/process/maintainer-tip.rst has some examples how
the "Link:" can be associated with the changelog. For example, above could
be:

	The SDCIAE feature details are available in APM [1] available
	from [2].
	[1] ...

	Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]

> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

