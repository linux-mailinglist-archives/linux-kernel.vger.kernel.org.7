Return-Path: <linux-kernel+bounces-797596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E410B41255
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96103BA2AC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7DB1DE4CE;
	Wed,  3 Sep 2025 02:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B433D37x"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224CFBA4A;
	Wed,  3 Sep 2025 02:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756866634; cv=fail; b=Pm3WEpsM6lzVvpgrY0sGxPNWSBGY9zc1/rCcjovdLoJsLNsDwj8NI1K0cVk4Q1+ROlMBRRXbOL94x3PJ7X6sxH9CDjRQ4Gxni3J/enj9ewj7Yl2zA0V0pA+PuCoJLSGqwR8Cf50oZ4G/cYkN1+WLBjEbWO57rB7xb4soXCqHEvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756866634; c=relaxed/simple;
	bh=G/1G1cKr8mtMVr37Jg6VrZwemXSFzPyaQYc5jE7UV3Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kqGNyPeY/g2uZGnVe4tsM48PVXS8X9SgMqKgcskbY28fbmahGe+EDhqwPf1yD7L4kwUEZ1KoEWZW9SsIS/nbXNWdv/VTwq3SFpjzQO8c+QRNZ8X4jYgecB7MrszsS+jMcTQvq33IybndwmFVWxJ9BM0d5uRMTMXPtLgMnGmLjb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B433D37x; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756866633; x=1788402633;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G/1G1cKr8mtMVr37Jg6VrZwemXSFzPyaQYc5jE7UV3Y=;
  b=B433D37xNp45l64fdEV27M2QM3xmA4Q4NPMkfrzCEC1yQBjVfl8AM4TK
   NQDLNm8ruQSFjGUiwblI1tW/foFsGWVC3gHz7Qivb07kiOYHHDQrlB7Y6
   Oeg/0aTEgGdqyYjKWqj3rsD++4L0NFXGXhFR8k0ojCGmAGsf/aZclPs2U
   V555N4fBwHXi09mX8f/C4Yoc3GvFEKpRYgZo6TEvRouyitYCX0cVLh/14
   l5tHgg2j59afLC4TRqPY/l89Or8I3ld9KjREGDSg0J2yhHW6xwGJE7I2x
   vGDHxq3jytds2u9aq3TtLIHcKIt1ieL4/mO0ygdVOd20WkR5IJCD95o7j
   Q==;
X-CSE-ConnectionGUID: fjENr4j/T0i3KjYKp/GfaQ==
X-CSE-MsgGUID: 4zNaAJcqSLGnUn8K4wAYGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="58384143"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="58384143"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:30:31 -0700
X-CSE-ConnectionGUID: 2sQct9e0QBWsmtopcjQjxA==
X-CSE-MsgGUID: nHeBPGKESF6R1pkw3pQeYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="176743744"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:30:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:30:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 19:30:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.48) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:30:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOTRx8sEGPawXHhyPUwVIhLSPK8zB4Os9S5MJdL8o11OwaSbBV+Dz+uBPNIbc40mzprlQWK9Xevy2G6bdEkIJVRrU58QNy+hz1LLnXUbdrkqvZCwdPaHn62N5VCXGXewbq/IxCii3jkeXSXGEcZ/fhvxFfeBH+gypYMXtD0O8MgNU0H9Sk4oKyPdsUf7DVGc3UYnlbFsVxTMqbKI+LmfxyKIiPEOwtQPGn8qvpDmegtREJK+JaeF++EU5UjhlXa2yDF8k0g2Jyjxl5nw45hzTne84clEV2Gv7l+HPos0dmZJ6tEPBzYw9kDHnMxN4hiKkCR9/OcX2TJZZj9KcVo3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16GBRndDisZA4LJRgvXRWJJ3KK8umy1b8K6bTzVOCVU=;
 b=DQLSNerKuzFAf9OMtGpsX9rj+tdOHKE2blgHU/BnnklNjaswhzl5NEyyW7v57mj7Dovf9LHseMOWjLZvR8HSSYpYGVZ+PkdBh+uYXGaQVs2m2v0HXXliFXx8mZapoUsHi3P7LIfQ1qR/+ysE0uoR9fMTidcLBrgm1BmzR9bROfalFehZwvtfwn/Spcv5R8NJ5SeeMFrJJWsvU2IPGDJoK6bkueq1ZWFcyRhAY81zMaMpqjY/NWFjD4ld8s+cwCOx637uebZ6jva094MyFX2k5wUpZdVstzhjOs+YhVMTGfWw3CkcBENg5xxwSqKsEWPzCQhEwMgi0JNQccDXjie+tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8076.namprd11.prod.outlook.com (2603:10b6:806:2f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 02:30:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 02:30:19 +0000
Message-ID: <accea3ea-88b9-40d1-8a66-86d29d68c69a@intel.com>
Date: Tue, 2 Sep 2025 19:30:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 10/33] fs/resctrl: Introduce the interface to display
 monitoring modes
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <james.morse@arm.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <akpm@linux-foundation.org>, <rostedt@goodmis.org>,
	<paulmck@kernel.org>, <pawan.kumar.gupta@linux.intel.com>, <kees@kernel.org>,
	<arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <yosry.ahmed@linux.dev>, <xin@zytor.com>,
	<sohil.mehta@intel.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterz@infradead.org>, <mario.limonciello@amd.com>, <xin3.li@intel.com>,
	<perry.yuan@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>, <gautham.shenoy@amd.com>
References: <cover.1755224735.git.babu.moger@amd.com>
 <ccf66cf78123879e0797992249fc7a4988de2de2.1755224735.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ccf66cf78123879e0797992249fc7a4988de2de2.1755224735.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: a1315476-f2c7-4e87-13c0-08ddea91d387
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmV2L3pDd1dBNEppY3FQQVRQQ2NZWjE2MFVFSGJTZ1g4dE83R1FNSHM3aEtp?=
 =?utf-8?B?amM5a05hN0d3enNFM0dvb3VBamVyOTI0OEJOaklEdGxkVGw1VFpWdnVkTHQ2?=
 =?utf-8?B?VVdnSytoN2VXUXhHQ2pWR292c21nUDFpaWhMRkZqTTBCSGozTStqeFZUN3or?=
 =?utf-8?B?eGdMRDJ5UUNBeW5wUEFBam5wZFlvdytpWEhWY2M1Tk1iTWJuSlpabEtuMjBo?=
 =?utf-8?B?bGl6R1J4ZlMybmkyMEZVMmFWWjIwRk5RRkozcUJWc25lTmw0aDJtekFINlpo?=
 =?utf-8?B?WW9IVGhpQkhhVXNjeTBMNEhtRkIvczNBbXFKVDJRNmtFMWNmU2Z3NTFrbnFw?=
 =?utf-8?B?MHlieWlNM1JwL1VhMlZDUDBnemdnMG9rSDhnbFZsZFVqVHNhRHhiR0JBUlNS?=
 =?utf-8?B?VUU4Mm15dXRxQXp5VEVEempQSUw0WHRIWjNHTGVnWDcvSTU2dVhRQ3ZtWSt2?=
 =?utf-8?B?WWRXNzRkbUZRTDVIMWNjUUZBUS9ZdXZ6WXJlc3ZyL2tHdEg4bGxKK0VNNUlu?=
 =?utf-8?B?K2xtU01JbE9aZWxSSmc4NFdNR2Y0OTF5NXJhQnpGVWRsR1FQbzJKMWhOeFJl?=
 =?utf-8?B?L0dJVVluVlhqZVhrcjhIMDNvOU9tUEhvc1RITHZBVXhDNmxjMW1mNlp5cld6?=
 =?utf-8?B?YTJIWWVvN0gvVUErOW9nRTBrSUNKYmhjZ2Y5QTQ3WE9RbFQrc28zdWNmUERL?=
 =?utf-8?B?bTZlTkhscm1iUGVPU3dvZ2ZHNkIvdkF5TUZyRFVZZ0t0Y0VZSlhrS0tvdUJB?=
 =?utf-8?B?c1JDTndRenlmNnp2VG42OEIwQnFva2lETmV1eS9QWFV2aW0yM25wQk9IUGxS?=
 =?utf-8?B?Z2IxNk1qenQyMDFCby9ZWm1SeVZ2UnFPSzVSNGFWaGRlY3dieEFkaWYxMUhB?=
 =?utf-8?B?QnVFZmk2UktHY2JWb2ZGUnhQZXFPSU04dFRuKzFyUTh2R0RJTElqa2FjdHZF?=
 =?utf-8?B?NnMvQm9TbUdnUzVxcFJuUGM1ZFBaMUcxUWZmaWUyYUtXUzQycXo3RHFiNWph?=
 =?utf-8?B?K1J1bW9IREU4ZXRiMEl6KytLRjJMWHNKWTNqellPZFFsUFRmeUVKUEY2SW1m?=
 =?utf-8?B?bDgrUmx2Yit1b3o5MVJLQURlbk0zcGM4RHdtRFRDUDdwVFU4a2hNL2QyYVBI?=
 =?utf-8?B?QU9FT0RRaEdKMGZpQWNRU0VmMmVDZDhhQndCMUo1R0Q4Rkt0dFAvbDYzbFF5?=
 =?utf-8?B?eEJ6cmsrSmtvdWJIanZGL3Ntc1ZpMzJrMllFVEdRVFlJU1pwczA4WU9WY3Jj?=
 =?utf-8?B?ZzY3djliQzFXVUVqcFduaUMweTRBRzR2blVJcW5sTTVKNFFJcUsyRFZOYkJJ?=
 =?utf-8?B?c0ZTR0FsanJZSGVjZ0hmWC82TDhTeWlIcGxvMHM2UWU0eVVUb1hWWjhCc3pp?=
 =?utf-8?B?MEVUOS84UHdRWVc2b2hnK1BPSFFNTVJYODBtVFdyTkczbkdvVUIyVHlnRnBH?=
 =?utf-8?B?bldBMGJBTVdqRTdhK0RlNEc2a0tBd1lkTk1pTHlqQVU0WDBLd1FDNWlVaGJX?=
 =?utf-8?B?ZHRsM1BYbnNjcWQyOXhKMUhjWjVzaDlUbi9jbVNsVjFKbkM4MnJPbGxZaGk1?=
 =?utf-8?B?bFVGdHBKcnJpS1poV25jZmtWTFdlYmhGc09wSk1RUk1TVXB1UXZoa2J2bk5y?=
 =?utf-8?B?Ny9DVndQclRhNnpVQzF2UU8xc1lSMVkxTTE0bmFNR29EeDhOT0NVNEtUcGJm?=
 =?utf-8?B?T01XT05xVFdQVVRyRmN2VnZCZjJjaHJpR0M2WEE1ck1xQ00wbGhPR2pSYjNR?=
 =?utf-8?B?NE83azNEb1p5M25BcDRVQzMwdk9ZUWZJTFE4c1hwaXVMbGRINFFtNjZ6WmxK?=
 =?utf-8?B?SnFrdWlFUkMrd2lmbU1udjM4TVlLdEh3Ym45K0xtME1ZSHQxQklid0VvalA0?=
 =?utf-8?B?Q200SkJiVTgralQyUGxsclUrRVNiM3Y3emRNc2R6L3lWb0xSa3ZSV21leHM4?=
 =?utf-8?Q?eVoS96H1Uf4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE96Q3VZOERpUWx0VHlMSGI2dml2SDM4d0RpZkhVMVRUdENnaGpRenZXVnUr?=
 =?utf-8?B?azdsaHJqd1h0UmhTeW1UNlAzdU8zcXBnWVZhZzRBa2Mzc01SRFFRbmJraGxF?=
 =?utf-8?B?UDRyWEtNL2hibC90UWZ4K3p3amRTTnE0Z0tLNCt5VllraGsxTDBhTFk5VG52?=
 =?utf-8?B?SVJXemVtZjdHTUU3MDlyZG1UeDZiaHRpSmZraTdaSWozeGphZUhUeDFiMzBQ?=
 =?utf-8?B?U2x1OWh6QXMveDhyalVEZ2lDNk9VVE4vU3luQW5mbzI1Q25FL2s2dHh3UERq?=
 =?utf-8?B?RjhqZE0yZndkNEJkMEtpZ1l3TVY4dG51ZEwzSit0ZVVSUmNoUVFiV1RpdDA2?=
 =?utf-8?B?OFhhSkJza2pzaCs5cXdia0JUd25BVElGZEJ3NVZjSzlZU3paY3MxemVIMW51?=
 =?utf-8?B?TTlrZmZlR3Q5eVdGWjYrYUtZbGJubTJweTNlUE5SNEJlZnlsZVd6aXBOcm0y?=
 =?utf-8?B?cGZtN0xxN3h5bm9DS3VONVNPVkViOHFnRUFuNDZBK0dmTXZrMUVXdktXRG1y?=
 =?utf-8?B?TzFlQ1krVUEzb3RaQ3FQb1QzWTlGRXgzWnRia3V3TkQyamd0bkN4azBhRnd0?=
 =?utf-8?B?cXA3elJibnFNRU9Bd3NMQVVCN0dwSzJ3Tk52MDBQY1phcWNnVnNMeDBITHBK?=
 =?utf-8?B?Z01LN0szUENJVHJra0l6SW11dmxORk1KeVdQcVN4SnpuVkRpZGlLODdOOCtt?=
 =?utf-8?B?RnZ2c2hWdnlxOWxUcC9EUEQrUVQ3cHNrejVGN3k3ZUsxOTcrRStXL3kxOHBX?=
 =?utf-8?B?eENIYno2SjYxdWV0K0Y1UnFHL0RPOEpSUXFyTUMrcDJYVkpYaU42RlFobGtR?=
 =?utf-8?B?eUlaUmFPd1ZnMStiWU45VVVmN0EwaEJHRnJkbEMrNEpBZkdhMlZ4anpxNnNh?=
 =?utf-8?B?SGY1bkIxbGZxUHp0T3hPVVhRUlI2bWcwaEkzTUgvTXJUdDFUZmU2Q3RxNTI2?=
 =?utf-8?B?ejVVQ1RDcWo4aVRZQUMvNDJubExyQXI5dGhudVlqbVJ0VHJWLzkxUTdHYUJi?=
 =?utf-8?B?R1B5ZG9UYndUT0lZSkRPTUFVRmVlRk00b3hGaVFYTGxIUEwxcVlCY2dEM1lY?=
 =?utf-8?B?dE0zUTVNa1BzWC9LRXA4cjBYMVBVTXRDdlJ3ZWZLVk5NcUtlbGQ5RlhsTE4v?=
 =?utf-8?B?VDVXWng2UWEvSmdrUDVLeGluUlNTT3hMbUl1eFB2TnVIeEoveUx6Tm9PMTdl?=
 =?utf-8?B?Zk1VbkxTSzhlbTFjSDFyNXdiVmdyaVlnU3BXSVc5MkpOWVQyR25oOHJNdUY0?=
 =?utf-8?B?bGwwQTVqZmJkNXZmQVNRU2Q2MUV0a3F5Nml6ZDZzVmo5Rjd0ZDdjUWJCbElW?=
 =?utf-8?B?VXVMVmNWdXlzKzV6dlh4M1FEUys3NXVMd3piTHBrSDJWWHJRRTRDN0xIM3Rz?=
 =?utf-8?B?WC9BMEV5ZTQ3QzQzMHZCSGFpREg5ZHBGZU9CMmlnd1NWeVdYRDExV1FiWnJj?=
 =?utf-8?B?NExCZ3cwNXV0Y3ZLV3JJL1lOeUNYY2lVSFN5aHduQ3A2U1RnTnRNcnZOMnNQ?=
 =?utf-8?B?TW5VU2NGblFWMmpCVlZUNnJlSHNoZ01SOWxZN010VGYxNHI3eExiUitjcFNz?=
 =?utf-8?B?dTRpT1dxM2NzcHR5Q0ZBRy8rdVNicERzR0RlcExzYnVRQzkxdjFuZVRKeFRp?=
 =?utf-8?B?MjlLYTg0U3hmK3B0SWUzNXRnN2JVSXRJUmYzWVhETGF3TmhGeFRzVEExWnAv?=
 =?utf-8?B?QmlreE1IcVcrVjFZcW9ONElpbzExRXRDN0xyYW5tdEpPZkR6R0FOSEVjKzJC?=
 =?utf-8?B?ZFJicE9hYlc3YjRRdDluSUdibnZLTVlVbG9SemRndE4wc0wzZHZUWjRyd0lX?=
 =?utf-8?B?NmRMdmMvS2VjeUdWY2kxSGg0SkEzTzBrdFZjanZ6UUpkYVlYRUJYbE1JekhN?=
 =?utf-8?B?cy9PbXlTcVVJVGM4QnhzS2xsd3BFUzlEZkFtT3BJUWo3dFRYb0s3VjNDNDVE?=
 =?utf-8?B?dCttOWptMVV3TW5xUkRWbmhNWDE0bW9mdXFOSUtMRlhxMDlHWU1xZ05zdENV?=
 =?utf-8?B?aUJObmxHSEZNcURjNEV5TXF4eFFiblBrWUZhakZCRk4vcVhOQ2RndjU2SzF3?=
 =?utf-8?B?MSs2UEdqeFRMdWk1dVB6VCtWa3V2bHVxSkZMc01VeEpwWGFPL3JLdkxQT282?=
 =?utf-8?B?ZEhkVTZvd254b2NjNHpkd1dMWGc1WDJSRjNzUnNjWEZQZXY5a0EyRUFCNVFn?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a1315476-f2c7-4e87-13c0-08ddea91d387
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 02:30:19.8153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCtkQR6XMSmRiacU7SIxVQEwYF0cKmELqvUyWdkOekO2ciVR88nSs2FcYYrFApk1E60zJt2vR51ICHLR2OkZOonQ9D1wIpxPjucrRkA0NlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8076
X-OriginatorOrg: intel.com

Hi Babu,

On 8/14/25 7:25 PM, Babu Moger wrote:
> Introduce the resctrl file "mbm_assign_mode" to list the supported counter
> assignment modes.
> 
> The "mbm_event" counter assignment mode allows users to assign a hardware
> counter to an RMID, event pair and monitor bandwidth usage as long as it is
> assigned. The hardware continues to track the assigned counter until it is
> explicitly unassigned by the user. Each event within a resctrl group can be
> assigned independently in this mode.
> 
> On AMD systems "mbm_event" mode is backed by the ABMC (Assignable
> Bandwidth Monitoring Counters) hardware feature and is enabled by default.
> 
> The "default" mode is the existing mode that works without the explicit
> counter assignment, instead relying on dynamic counter assignment by
> hardware that may result in hardware not dedicating a counter resulting
> in monitoring data reads returning "Unavailable".
> 
> Provide an interface to display the monitor modes on the system.
> 
> $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> [mbm_event]
> default
> 
> Add IS_ENABLED(CONFIG_RESCTRL_ASSIGN_FIXED) check to support Arm64.
> 
> On x86, CONFIG_RESCTRL_ASSIGN_FIXED is not defined. On Arm64, it will be
> defined when the "mbm_event" mode is supported.
> 
> Add IS_ENABLED(CONFIG_RESCTRL_ASSIGN_FIXED) check early to ensure the user
> interface remains compatible with upcoming Arm64 support. IS_ENABLED()
> safely evaluates to 0 when the configuration is not defined.
> 
> As a result, for MPAM, the display would be either:
> [default]
> or
> [mbm_event]
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


