Return-Path: <linux-kernel+bounces-834633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFC6BA5244
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 22:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633731BC7060
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768CB202F70;
	Fri, 26 Sep 2025 20:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sqrsu6Jn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75804283FF7;
	Fri, 26 Sep 2025 20:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758920060; cv=fail; b=GEy1T3Y0tnO1Bep1km6JPQD9SgIdFp2PNyBgpgNGsqh+V7aqN7muenVFzHu/zillQB3RbeAKIcXP/ishneOASq3fvC8+RPS2sw+LRIacXo4LT1z+bBpxsW/2YTCZoEonjH7IeOtp91dmipHHEesI85pEMJ2G/gnFEcEtpfhGaIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758920060; c=relaxed/simple;
	bh=/DUG82Zy1yce5ruprs/fRWLB2IDVF2eLnATXGLLBSno=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rq3YgvS+HpcrXqLkUj90cBjWATshxThCusHd76vAYbrS2C8SwpP5nI8UjQPUc2FucPOhnW2TxQM6YTGNsgWZPuvILsJdp1FNaKQ4AcWmMjsxn1AJ0KLyDLPnoIqf5Cho2Gyb+Y+Fg0Cr4dxtpGx6wM8LGHWYxti8liLZM9HLGqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sqrsu6Jn; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758920058; x=1790456058;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/DUG82Zy1yce5ruprs/fRWLB2IDVF2eLnATXGLLBSno=;
  b=Sqrsu6JncsPFXdtDdILBBsIEbvSawVCbWGHzx2smN48Gm+xks5V2OX8J
   Li3YHlJboD9IB4RuheL8SbKBjbwvIFQ53TDF9hQXMCKbFE4H1fWnXKSbs
   4FUeIyu7SriWhcxnCh4VAdEKiYW277OilSDZe4O3w8U7cYp2tlCWRgSoL
   tQKjAGZQl18e2vPyByG1eoBECRHw9IrlvdA5vvCPmLZpHu7FFoCxnU4h6
   H0kjCnDHoU1zH86RcBpE77cvzQ/JDioZNp282sX0EaGRD97jHn6Voue0+
   2VvrV+LIbPp75A+pn66cFfrqohpWxoJtsXDLQt2LrXNcOFxteV0syixC2
   g==;
X-CSE-ConnectionGUID: fCFI4w/AT8+/N2gAjr+aQw==
X-CSE-MsgGUID: rphu5O6uRtGx/xo7bWDUkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="61148829"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="61148829"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 13:54:15 -0700
X-CSE-ConnectionGUID: 1gTBBpHkQCCp7+m6r9d7dg==
X-CSE-MsgGUID: QGCviWbEQfaXW/BaJnpM6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="214842855"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 13:54:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 13:54:14 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 26 Sep 2025 13:54:14 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.30)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 13:54:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvm64KG0RkvoWk+4RQsMFS1jMCboa3GLI340EsQOhyqrm/YF8hGU5GWO732V/Et4IsJTlET59+CCZD5Pc6xCHHO2Jsh/d/hoX4mA9Z6TRPuHqiWk40jTICTWbZRaubsQ3VzfNBd7zH329TjapM4WoDRaF1fRMjX6x58ezJh0RVSvX85nyxjFst9zeYD9J54fpgRFl9CUgphQ0NjTOqjrkRZUMTAuFlDxIYEKqVqplrtAEnJYLajrWl+tDldyuW4b9/ynhNHadDdcXT232/UOI7vxpKzQJy+DXMZSO0+QlLnQDdu7dflm6g6/hta4ZDrBLp/06rpOpafVMRHOQC5fNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LA0ZgY3po4LKWHN23iZd/c4KY5JBQcCyluoyO4+RTM=;
 b=D+eCuIbxjnRqM3Gz8HsLOVqeSbA2boRvuYJWPMaNxBrQ+qBs8m3a0rLM3UJybX6O6NxyT6OlEeiP3M4oZd+/VxyL81lkngwdbWwcf2jqg0Qm8PMfmJPuWrngI7AvEs7DfW52pxO9C72S75kamqfTUKWcses0glYKXVSJFXQ/q/UUrOzGRWQEnwmLWVtpfSmt1J52IEJSzuiJvV2pXzUkZJrT7Fpg1guMxiLnNmvzf0gljSohCTYoXsszBjyNbdpiVUlUlwGXFPQcNtqiM5/cLsqYdl/IpmiuVsrNVIFpUBe6kSJYd/WFI7e2VDHWiv/4cpJ5mPDXZML1p1/+6LJNZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7727.namprd11.prod.outlook.com (2603:10b6:208:3f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 20:54:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 20:54:12 +0000
Message-ID: <ffe1c6e9-e951-42d6-99ec-ec6e7496f9b0@intel.com>
Date: Fri, 26 Sep 2025 13:54:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
To: Dave Martin <Dave.Martin@arm.com>, <linux-kernel@vger.kernel.org>
CC: Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	"Thomas Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"Borislav Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	<x86@kernel.org>, <linux-doc@vger.kernel.org>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <aNFliMZTTUiXyZzd@e133380.arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <aNFliMZTTUiXyZzd@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b3d5ecf-b055-4657-5800-08ddfd3ed8cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzRlQ21ZK3A4anJQNGlsRUE5NHBkeDVLNTMrWUtqVi8yVURadEpKbDBmbjVV?=
 =?utf-8?B?dllmbTBSb045MXRuamZrMGI3K0pNbkJ2WHd1Mm0yN0JhWklzZnRMeEhKcEF2?=
 =?utf-8?B?WWQ5bTNtMU1nRlJMRE5uS01vakpEd0FVZTNvbU9OQnh6Vk1tTFE4SEd0eTVT?=
 =?utf-8?B?ekNacjgvSDR6bHNyeXVvMDJ1WWNoaWVDV0FSN3MrcE1PeHZqL2pPQ040aHNs?=
 =?utf-8?B?ZnhUeG5UT2tacmVabFhjMHdERENuRGQ2cHljQmI2ZzBCVTBPenFlS0x6cGdq?=
 =?utf-8?B?MXBVaW5XQnNqdnVnZStkQU4wRkpiWTljNlpwb3dnTFVFcmR2TFJRcW5BRHFX?=
 =?utf-8?B?SnZEVEZwWFcvYTNtTWVmcDhyZU1UWnFNcERsdGRCNDlBVjNQbVJ6cmxYT0gx?=
 =?utf-8?B?NmJ6U1BSWHU2WDlhd0g3eDBDa1ZDWUVnbEY2Q2k2QTdla1U5bnZIQ1BWQVNl?=
 =?utf-8?B?SEtvOU1hMXZsVjN4VXBCNmRDaXg2cHFaNXE3M0pYcW5OOHhZaWNmNTR0SWdT?=
 =?utf-8?B?c0tqaEpMb1dhUlFDU0VlZThkSTlTSUxQL1o5REpkdDQ3SitVck1PU1pKWWQw?=
 =?utf-8?B?dWJDSDZrSGdhZ0Z2czFFQWRBaEZGblN0Ykh1TlFaZ2JQUTVnbWliUENDR3Rr?=
 =?utf-8?B?bkVBQlBJZ0NoTmhLMEF1QXE3c0ZwUDV6VmNlQVpXTW1XdXhyaFdHcmJWRk5D?=
 =?utf-8?B?WiswbThxc3Mvb0ZlYTk5L00yWEN1Ukk4M2tGTzBsK1V1c0s1cDVuV2s2UWZo?=
 =?utf-8?B?ZjhWd0hGbzF6cXIvNTZjcjc4MW5uSU92MllpQWR3cUJuSW5pQXd2MTlpMk5S?=
 =?utf-8?B?Wm1RSmE5UWxrL0w4Qm00UG5OUHRva0hudTdlclRvRGttd1ExVnQ2OEhZcVgx?=
 =?utf-8?B?VndnaTJhMW40SkQ5amNIWkdmaWk5SkxBOXppMnFtemd6RUhCRTdhR2F2cFhV?=
 =?utf-8?B?MWhNeHdVQWFVa3FVbmJxTnl1RHBaaENSQndjRWFNeUxWY1d4ai9PaWNvQ2JL?=
 =?utf-8?B?WGl4RExmRUVNSVNEOHVhdC83NCtidVAvTjJSOEJPWThNcGZETDIvNjlFUFRr?=
 =?utf-8?B?VUFRTUtpUWlvN1I1T1lraG56ZEd6K0tLajUrSTcxTnhCWnZjZDJoMGxnZEJl?=
 =?utf-8?B?V05VUGpRWEdmcXhiMWczQlV6MzNsZWJESTB5NGZTMlc0L2VHUVN0VHYvbTZ4?=
 =?utf-8?B?OWovTHRsUUpPNy9mbHo4aWpHZmhJMWM4L3I0c2hCYjlybDYrMFNuQlJpREZJ?=
 =?utf-8?B?YkpGMkRyMDRtWldNbW1PVVJ5VUVGcDBBc0J6dEdaTm82dWhPTW5tVW8xVjFT?=
 =?utf-8?B?WUJFZThqTitVMjJUYll6UlNhY2J0a2ExUTk3UHBhTzQvc2QyV3FaRDZYRTVF?=
 =?utf-8?B?ZDd1TzFxZVZ4KzZKN1pobWdoOGNDaG9TbnM0SkRyQWFnMmlJS09sVGZlUzhk?=
 =?utf-8?B?OFFwd1Y3Wm9ZcmJJN1pucko5c1VkbGN3Qm80eXV0N3ZJWGFIZ3FTV1RUWGoz?=
 =?utf-8?B?VnJYRlFNbGhFbVY3YWpkTWdlbTlUZkphY1daY1d4bXR5V2RVdkVmN3J6bzFh?=
 =?utf-8?B?azFSZzR4Nlh4UnVPdGpkTzlhTU83MTIxbUhDdDl4b05GcEwwS0dCZCtFcmZE?=
 =?utf-8?B?YmR2QWNXUGswRVd5cUNYTEZOSEMyUVdzV0NCVXY2WnZxamU5M1ptdkpHaGF5?=
 =?utf-8?B?TDA5UDAzSW9VVWRxUkVEaWZKRzNPUi9rVWp1ajRwaWFKTFR2MmJOcXRxNTd5?=
 =?utf-8?B?OGRaZk5CL0N2L3JucmJXSHdqZnFVUGxSZ0g0UFdBUVBMM0dGaC8zVDdKaWFC?=
 =?utf-8?B?R1YzTFVFaE1aYURoc0k3WWtIWEg2c1BpVGFoYTd1cGhIajhRSXRQbjJ6Q2RR?=
 =?utf-8?B?dUlJemxlTjlHaXJDb2w4T0pYNXZWTGVRU0ZreC96Ryt2cjhubEt4QjhxZkxC?=
 =?utf-8?Q?ByHhWhNqBVhZtZM+LEHm7IUgUJDF/bdO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnJwNHdIYWtBVzVYNUl0WGNYOURKZVNhZG9MZDhlM2hoYmxvc3VhQkRwbmRK?=
 =?utf-8?B?ODJ5d2dPcTFQUXFraXNQeXRHUlVrNmNQZ0lXM2t3cGJOK1M1dFVxVXpqc0xu?=
 =?utf-8?B?alN2UkhVcGE2dkZSdW5lTG4wMFlTYXduMEtLWlQvYk1Ld2h2cit2bDJYSE42?=
 =?utf-8?B?elJ5VEtuYVFUSU1NUlJ3UGVBcmQxbGV4TTFIdzV3ZHhpZm1TUytFa1owZ0xj?=
 =?utf-8?B?RTBJZm9SaERzbGhnUmtyV2o1T1preFdRODU3WjY5UVBaVFAxOFE3QlBwTXQ1?=
 =?utf-8?B?Z1JILzBPdENOMEVaOGtleEpQVVUxdUFtbVhadlFNS0kweWFiN3FRcWtHamV5?=
 =?utf-8?B?elcrNDdrbmYyejMwU3o2SUI2ZTNPMkNvN2tpKzB4WjlGd1dYcjNjT2owOWFK?=
 =?utf-8?B?ZWRKWmZGOFlmN2hEOGpxL2ZHT2cwZ1duOVE2MTBVdmVZWlBhbm9GbnN1YS80?=
 =?utf-8?B?Wi9CNXVqVldtNUorS2hJVHZRUkgrNlVsc0hCOHZkMnZyUDFjbVZkQkV0NTBa?=
 =?utf-8?B?aDN4dnU4engvNnpvMllzOEN1TkxOWXBEWmZiN2NxVWhsZGlBbnVPbC9FWWZu?=
 =?utf-8?B?bVR3eVRnYlorbHhiK3hkWnZSNkZIekwzZkphRmRKaXF4enI5WlpqQkxmNVNv?=
 =?utf-8?B?UFdxZ0kyaWEydUpPMVlPQWdWaXJYZXd1VWhWNTVBVVF5TWw5T1pBcG5YaHZJ?=
 =?utf-8?B?bHpWNFRVSkVuT205V0xVZjh5ZkdMRldBd3JnbTNudWRqTEEzQzl4dkhWZit3?=
 =?utf-8?B?azQ2UDFydlZ0aG84d29FMFJLSFRDb3NDV21JV0Y4V2pYNFVtQWw1VjhHSXRC?=
 =?utf-8?B?QlcvclVodlI4djB4RE03M0Fmb0JXRHpRdGZaaXpvd1VyQVRGc2phL3VMNlor?=
 =?utf-8?B?WGxqcDRNNjZMM1RkZDNNbnJabTFFMkRob0tiTHlpcDV5aERVdzFHY05VN0xL?=
 =?utf-8?B?azJZaWRNMDlUTkZEc2pTeHFnVEg5RkJyeE44RjJ4bmVQZjF4SzRQb0xsdXdT?=
 =?utf-8?B?d0FyQXQ4eUQzb1BCeEtEYmlIUkduZjF5a2lDdVJZaEMrdHJER0dSanZXOEtw?=
 =?utf-8?B?RXJGblQzM0s3eVFteWRRTnBqK2lORnVPUG5kcnN6SlllaXFaWXgxYU9BdEVO?=
 =?utf-8?B?NFJUQnp0VkgzZlRXQWd5Z1JjOGt3V0NPblpoSjRxZ0s4S3Fsck1hZklYdmVv?=
 =?utf-8?B?bFdQWDJxMWpMOEM2T0tQNjU2UTlKeWtYYzNnNFVjK1Nzd2VQdU5hUVRST1I2?=
 =?utf-8?B?b0VNQklQYjNMTHl4WWk0YnMveHk5d1IzbmtIUGVIY0JoWnJDUmhXVTVDblV2?=
 =?utf-8?B?UWlIaGJPdkhmeXM3STdUV1RLMXQrai9uTG5JNEVGZ0dCV2ZsRE9aSEUzMWU3?=
 =?utf-8?B?UW5pN0tCZC9Ga0VmZlcyOXBzMEJnOHVlVzhQa3ZOQ2F3M3BMUi9JdnRnUWcz?=
 =?utf-8?B?SjdFTFNwZlZDUlJGYnFDMkhOZkNJOCtIRkUxTTd2V3JURW5XVHpPdXVLeHBE?=
 =?utf-8?B?UEE5ZTkvRUtYVHVQazFvcjBXUm1VdTN0OXlIUHozV0lEV2lCUlVRdisydzFP?=
 =?utf-8?B?aFY4cm1Xc25jN0JFNGNBV25zaUFReUl0N3NoR1BLRlRGUE5JcEd3eE5aeEcv?=
 =?utf-8?B?aEJhWmozTjk4bTlPMnFlL3B5MjFNS1I2NnBCZENpSTZoKzk3RXBRWVhVaUdm?=
 =?utf-8?B?T3FUc1lEWE15TXZ4N3I1ZW9nQ0NHbDhqU0R5K1FSKzU2Ylc5dnJWTmp5NFhB?=
 =?utf-8?B?aHBpRmkrQW9VU1hvelpNbXd2cW1kMkVTU1VFMTlBcjNxdlVqTVRxOThDbnhR?=
 =?utf-8?B?d2dxM0syeFkrMkZ6YXQwMW1seWE3SW5EK3hxZEdyTjdqNGVFbWlYOFZrN2lS?=
 =?utf-8?B?S0NOaFNzNXdHS20xQmE3aGhaS01lUE1zTGhWZ1hYcUZOTUkySWh3T3JLbFk1?=
 =?utf-8?B?ejRzaG5Oa0htQ09SVTNDSms2ZUordVRHeWMzdHVCWDhFVTFTUFJXYm9reS9P?=
 =?utf-8?B?OWV1ckI0UGZiU3hhaTAyUXROZXNCL2JwaUhHQkd4MmNSd0tiSjVIV0VjUU9D?=
 =?utf-8?B?SjNydGEvRFNOc2ZMdHFNc21QaWZ4VExlN1NCaTlwdzA3Rm1GVncxMTAvZk1y?=
 =?utf-8?B?L0o4RHQyNnV6L0N4K3VMM0N2Zkd3UDJRU0dzeWppdnBjT0s2QVFVbThjOC9C?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3d5ecf-b055-4657-5800-08ddfd3ed8cc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 20:54:12.4704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7cXlqI1pedsitbjWluwGSCl4qr+vdeXuCqZrqFwJEYqXtQIJW43PXfhIVrrEiSvLoI08J3XSYMygHVTtYWRf5dc2IlLxzvq+8NYw3juUMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7727
X-OriginatorOrg: intel.com

Hi Dave,

Just one correction ...

On 9/22/25 8:04 AM, Dave Martin wrote:
> On Fri, Sep 12, 2025 at 03:19:04PM -0700, Reinette Chatre wrote:
> 
> [...]
> 
>>> Clamping to bw_min and bw_max still feels generic: leave it in the core
>>> code, for now.
>>
>> Sounds like MPAM may be ready to start the schema parsing discussion again?
>> I understand that MPAM has a few more ways to describe memory bandwidth as
>> well as cache portion partitioning. Previously ([1] [2]) James mused about exposing
>> schema format to user space, which seems like a good idea for new schema.
> 
> On this topic, specifically:
> 
> 
> My own ideas in this area are a little different, though I agree with
> the general idea.
> 
> Bitmap controls are distinct from numeric values, but for numbers, I'm
> not sure that distinguishing percentages from other values is required,
> since this is really just a specific case of a linear scale.
> 
> I imagined a generic numeric schema, described by a set of files like
> the following in a schema's info directory:
> 
> 	min: minimum value, e.g., 1
> 	max: maximum value, e.g., 1023
> 	scale: value that corresponds to one unit
> 	unit: quantified base unit, e.g., "100pc", "64MBps"
> 	map: mapping function name
> 
> If s is the value written in a schemata entry and p is the
> corresponding physical amount of resource, then
> 
> 	min <= s <= max
> 
> and
> 
> 	p = map(s / scale) * unit
> 
> One reason why I prefer this scaling scheme over the floating-point
> approach is that it can be exact (at least for currently known
> platforms), and it doesn't require a new floating-point parser/
> formatter to be written for this one thing in the kernel (which I
> suspect is likely to be error-prone and poorly defined around
> subtleties such as rounding behaviour).
> 
> "map" anticipates non-linear ramps, but this is only really here as a
> forwards compatibility get-out.  For now, this might just be set to
> "none", meaning the identity mapping (i.e., a no-op).  This may shadow
> the existing the "delay_linear" parameter, but with more general
> applicabillity if we need it.
> 
> 
> The idea is that userspace reads the info files and then does the
> appropriate conversions itself.  This might or might not be seen as a
> burden, but would give exact control over the hardware configuration
> with a generic interface, with possibly greater precision than the
> existing schemata allow (when the hardware supports it), and without
> having to second-guess the rounding that the kernel may or may not do
> on the values.
> 
> For RDT MBA, we might have
> 
> 	min: 10
> 	max: 100
> 	scale: 100
> 	unit: 100pc
> 	map: none
> 
> The schemata entry
> 
> 	MB: 0=10, 1=100
> 
> would allocate the minimum possible bandwidth to domain 0, and 100%
> bandwidth to domain 1.
> 
> 
> For AMD SMBA, we might have:
> 
> 	min: 1
> 	max: 100
> 	scale: 8
> 	unit: 1GBps
> 

Unfortunately not like this for AMD. Initial support for AMD MBA set max
to a hardcoded 2048 [1] that was later [2] modified to learn max from hardware.
Of course this broke resctrl as a generic interface and I hope we learned
enough since to not repeat this mistake nor give up on MB and make its interface
even worse by, for example, adding more architecture specific input ranges.

Reinette 

[1] commit 4d05bf71f157 ("x86/resctrl: Introduce AMD QOS feature")
[2] commit 0976783bb123 ("x86/resctrl: Remove hard-coded memory bandwidth limit")
 





