Return-Path: <linux-kernel+bounces-844976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 59244BC32E8
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 05:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D0E6A34D5D1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 03:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE03261B99;
	Wed,  8 Oct 2025 03:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lrt0PrxI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179031D7E41
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 03:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759892708; cv=fail; b=YSJAnSRQNlGm0Bskf7NKfCp2CHAO8IiF6/8zPipsDeX13nfO61ChhgRtGxH9OW9f1Pv4E0fa4FLXOG7YNYtZnml27zvrDU+IB9UrIpJcfvWrpVUO3/OhP1VENlvhH16xwGWkUiEtM3MwjQmKQ6q70xGLdqAggu4jYdhRIoNpXcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759892708; c=relaxed/simple;
	bh=GiyPoyxJrupqxYFBMU9x8h/137ddJ37yaoloxT39q5k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BRdfst3qVKOEfTj9xmA7362/tXpx5k+e+Ve4YQ2Hm7xO3XYnQMZx4x/j5bDejMt6UsxUFqgk7dQZYwg5Qtdf8Q9nNGjVCMr+UTE7hMPE3YbSHK6wDT31zDhpGG8eqwisqDG9K2Vxj2QAecoilFakb8V7f9PnZh64Qpx+mthk0Fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lrt0PrxI; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759892706; x=1791428706;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GiyPoyxJrupqxYFBMU9x8h/137ddJ37yaoloxT39q5k=;
  b=lrt0PrxI99UMt6SYTmb89ksp5uB/21pUQPGJMHQf7U2XHzY0oFkKJjBN
   6/1nMJZlbEamjHR+kDp8Qx44EaMxMiRIdytdVBij2LWZ966ZWH0rWpo2/
   vURST7NLYpRcOGVEijjVp/Mwsgu9I3rLVKLhOi4anTKdA/xf0FVVgi29l
   R0zP5+mGB19/MdKwGiNVwiNMfOBpzQUNPXlqZke95ZehB8WhUe9LNGoBM
   Mbrhnsm3EqYlRQsHp0IzWEAsTgskVV8ObrbZIgKTcCT+1SzUhDPPVPdWv
   SWEZQjtpCAh8xR/BfEnUGkXjntpv6cRLJXnTOuvRdOw/PmSmuVwDZOvR4
   g==;
X-CSE-ConnectionGUID: ccpeN5UTSZ6HxCVnqabCEw==
X-CSE-MsgGUID: a9e75zc5QGSqjRf+psAlnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="62179365"
X-IronPort-AV: E=Sophos;i="6.18,322,1751266800"; 
   d="scan'208";a="62179365"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 20:05:04 -0700
X-CSE-ConnectionGUID: UdX8yFEzQoyDbECeSCGScA==
X-CSE-MsgGUID: TG76C3viT9W5jII6vULXHA==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 20:05:04 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 20:05:03 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 20:05:03 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.33) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 20:05:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEyI4rA2sBpR2TbZBgxbyp2Gtv/8cTLukBle0RFIKIJ2Gifkos6vi077JZ6+ZRNkWktJkUn9N1ASg+kHIl9IYYULOInHp6+YK23F1fllekX9vy2u6rD9ekgPMb4G3uVlun9mEeKsE+zmYn5HoKXd170C1lllZLgKFBXHRE1uv4b+xuwbPABTXY1Z5nmnJkH1hI9ei5/y7R2JQE3OMo7GHIpTD0mQy9k2VZWUCzc52fabjPF2631XaXzTtmlGGYxyKu+X7pv13DCrZkqRgsRrtkC2LntG0E5d+QV9gURoF9JLc3S9FvQWRLcUa/7euZ0sX3vozty+6UZx1ZRGJPoZAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CE/+seBaUZH87kCXd/A5bmgl1kbfyvSowO4N41BZJE=;
 b=zW5zXDiKz4mrKHIm01J0Ce6bYB7oDU0Ko6Nj1OWNh0YwVT0I4+vLkPQlyehLVg9fTMxBqKjeHHEhw4ngwoUvIYKZT7LJKvV1JUOWW+8GHhludgc8KNZpZ/OE2hlmyxyqm2HWbrotT65ZUaByAPc7qd8FhGCl7LQho3sgtndRJq3TjcsNBMnQGjNdwqfraoHPgiToy/7Ukb6SvSDlxOExy8eM9Fnm41I2Em0PoeawbY3C1DYiFBHabdGsOY7YhiVCuvuPJYghmz4yS0qPNiuojQ63jcacknyC7WLpJee5ueyKnFzjKVGFFN+tqqfel6d2QE+4SzwV4NVEX+UhqdZy3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4692.namprd11.prod.outlook.com (2603:10b6:5:2aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 03:04:52 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 03:04:51 +0000
Message-ID: <1b352ad2-e542-4005-a470-5a9bb94b7ad8@intel.com>
Date: Tue, 7 Oct 2025 20:04:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Fix buggy overflow when reactivating
 previously Unavailable RMID
To: "Moger, Babu" <bmoger@amd.com>, Babu Moger <babu.moger@amd.com>,
	<tony.luck@intel.com>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>, <gautham.shenoy@amd.com>
References: <515a38328989e48d403ef5a7d6dd321ba3343a61.1759791957.git.babu.moger@amd.com>
 <fe06aa33-3351-45d4-a687-ff88a689be6e@intel.com>
 <3e1b459a-bd9a-400b-8c10-038b330e539f@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <3e1b459a-bd9a-400b-8c10-038b330e539f@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:303:8d::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4692:EE_
X-MS-Office365-Filtering-Correlation-Id: 02413e57-bb40-4ecd-4934-08de06177304
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHR4Y0MzTWl4SG8raU5LVUlGWjV2YWt0K0EwUXZZcWFSM1dnSVM3ZUk3T2Vx?=
 =?utf-8?B?ejhGRDlhTnd0RkkyeDBZQXk0TW9tbm9ZRzAyTmc0c0xJeC9iaFZjeFliS3Iv?=
 =?utf-8?B?VVhyZXJaaEQ1TE5JSWs1Yks3RmN1OHIzQU1kc0FSWG4wN3p2WTM1TnlqR0kz?=
 =?utf-8?B?US81akFSOGJiWlRvdExleG1MTzI4VE5Eb3drbllwK2I0bGRTUXpUNmEremV6?=
 =?utf-8?B?MGxFTmtzN1pqRVFwc0dueXFlMFZEU091cThlb1JRVDNxYU1DbG43cERvZVNq?=
 =?utf-8?B?M3JhM2NCWFVkWDl6QUNqYldEaEFBRGxMRzBzRWh6SmE3azJ6bTVXN0puTm9I?=
 =?utf-8?B?K3NXRHZEeGVMSC82ZDE3dU5VMmFqSk1JdGRLb0ZYbThPMmFxOGpBa3NubDds?=
 =?utf-8?B?ZC94M0tYdVcwRXVHNVVUM3FYQXNFSHpCenpwSkhKbWNrQnYxVFBYNWE2SXBo?=
 =?utf-8?B?UWlFa1plVG82emkxcFp0V3AyTWdncGE1YTgxd094WkszZ0JkelFWSGQrNHVq?=
 =?utf-8?B?M2xwZUw1RUJkRVFTRyt0NTRjWkp4cnlPQmVkcS9LM3YyUXN5THZqZFQxcjZW?=
 =?utf-8?B?R092WXo4eUh4ejcydFdvQTlZRXFucnd5ZitZMHBqT2ljUUVyQ3hCUWhycGJv?=
 =?utf-8?B?ZzZjeTNUYjRmRWlsQXVQbkRRVVdPVmczODE5VXRGQW4rbVYxZVp1SDhwRmx0?=
 =?utf-8?B?R3NMdG1tdGo1M2JpNENDM0VPZGZSbFlSTmw2d3dTcmtFNnZDVllpbityaWF2?=
 =?utf-8?B?aTJNcXQ0SDBBTnJDRmhORnZPdGUvZ3M0dXlBUm5teUVYM2RtTnd2TU9GODJQ?=
 =?utf-8?B?RjZHcFRTRlNsL0U0QXVYYmdnWW5pdW9kTlpJUWxnd0Z5bTA2VlpYTjRWdlR5?=
 =?utf-8?B?TUZMNG5EQ0pZcGdmZWdJdUlwV0VqcW81d1pRWXNDRVd2NEJvRS9VZ2MyeU5t?=
 =?utf-8?B?STNVMUlBNDF4bWZBNFlYSE5KWHdlQjg3dWVyVWJxLzQ1L0dZNFREVnpMYTFV?=
 =?utf-8?B?WnhBSWhNamg2MU13b25kVy9PNE5FYThGZDNNSjMzTkFHOVFicVdTUDV3NzIy?=
 =?utf-8?B?OSt3UjRlQTdIKytJbDdDVzJNK29sYmJRMkhTdEt0ZFJSNW81KzJ5VmEyL1JI?=
 =?utf-8?B?cWdTL1ZkY2VhMEczeEVncjFlaGVqbFVYb05ITXJuZmp3OVg3Q251RVdzQmlC?=
 =?utf-8?B?RTJrSldYejJuMkdobWxXd1VLZUtDbDlvVm1ZNUdPOHp4OS9kTWxrd1lUZnhr?=
 =?utf-8?B?anp2eHdIWWx4MHdlT1pEVHpGOHE0QWJRNmdZQ0JVeVpuM2RGN0lFTWFGWVRv?=
 =?utf-8?B?WmxmQ043QTFNd2ZEcWZpMFY0L3pocXJDOUVhd3Bzc1JZTHVJeThvRkpYZ0hP?=
 =?utf-8?B?WlpqMkFaRmlmSE1aV2FaRWxRRGZiTVJOVVVIZEhqcVdzYm5vbUdYMXAxWi81?=
 =?utf-8?B?L2NzZzNOT3ZHNEpoYkRBQmFIcjNtVHREU2VuVG5qU3RwZ3BBekZabWpCSnEx?=
 =?utf-8?B?RlhLVHF4clVPSmFRaUt5UjFPc3phWjhZQk5OZFNqNktVdm4vOU1tbW9xMGg5?=
 =?utf-8?B?ajRZWTdEOW4rcFZicytNUkd4STFBd203c2hmZVNtcTZ6cUg4a0hXa1piWnhX?=
 =?utf-8?B?WldHa0dvdHJxYjdINFVMSFRDVkNlTlNxd1dHSWhvaTlmOXVCbWs4Ty84ZS8w?=
 =?utf-8?B?V0JBbWR1TmhVU0tUTXd2YkVoNXVWWUpHUi9uWlR2VFQrUzNDOHdmOGdKY0xX?=
 =?utf-8?B?NHdHazh1c1VoWE5TazB3TUNvcGlWTDBxTzd2YnVkUFdIeFlEVWR3V1ZjUEJB?=
 =?utf-8?B?MWRvVms4azc1WDFoU2RGbUM1bnp5bER0Y29QY1UrcWFqSnU5a1VqdmdGbW1x?=
 =?utf-8?B?OE55RE9nSVBrWG85LzZRVlQxS2ZxZzc1a0dhdzJ4UEQrd20xNFZCanFCcUZh?=
 =?utf-8?B?a1Bjc0pFbmV0a3dKL2N3M0grOS9OeDRSNHlFUGpWQ09PdXJBVHZCRnJsdnRF?=
 =?utf-8?Q?OxbU0qGyERWIjYdLcs/rovpahiiUEM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blpPRXVjOFB2ZGRKRHI0dmZZWWV4VU1JRWpjY2JnREIzV21LdjQ4T1JoZmlE?=
 =?utf-8?B?MEszaU91REZ3SkNVMnh5dnNhRGd2ZFpiWWl1RFZSM3Fid3c2UXJ1cjNibUxr?=
 =?utf-8?B?ZjJ0MjJORElleU9zSktuUUUzZEdBNmM0QnRBa2dUSE9yQU5tMVhLa2o2eFc5?=
 =?utf-8?B?dmJmMkFXN09DaDdlTEtycEo1R0dNaFR4em5Yb1c0RzY3M0pJNWFlTC83RWZW?=
 =?utf-8?B?Z1dhOWZkMG1mbGFvQ3JMWDA0TTQxRTNMQjhnZG5pUWN5TGxuZ1ZBOCtUU3NV?=
 =?utf-8?B?MHBva1pVNUFnSnd1dXp3THZRcHY5NUdQQzhYK3EwVmhxb1p5R2FvdEZzM2k5?=
 =?utf-8?B?WTRRUW9wRFYzSWN0R2pZUDJ6NU9XVmI3RnBoS2lEcUVGNW5jQlZERHZTOElj?=
 =?utf-8?B?UEJWTStRTlhzVE9Jcm9aMVZOU2dWeGY2M3VyM29GSzhqS3puV0U1L1Z3Njdp?=
 =?utf-8?B?Ti9id2ZodGZkR3VpTVJyK0dZcEY5YjkwOEx4OG9MSlIzakVMaHUzTGhURnE5?=
 =?utf-8?B?RGgvMERBTU03NHc2VlJpMEtBQnNiZjU5TVR0aDBDODRQUitoN3BpMFI4WjNi?=
 =?utf-8?B?SFRxR1NWc2greDk5ZVZFdXFYVm5RaVVoODk2a0VQWHdpZjBHN2RPWVVpcmhm?=
 =?utf-8?B?bDEzd2E4U0o0Rk5jY1dVblM2WFhTSWpsVG5EMTVSOUxyU0tiYXZ4RS9oRUVt?=
 =?utf-8?B?NjkwYTdNbTdXQ3FtcXNhYTBLYjNLYnZiaUI0b0sreDByL1FieS9LTzR1ZU1D?=
 =?utf-8?B?ZXRiK0VyNDdWQXk3MVZMNnM2Smdadnp2YVJxbld2OFRlUXh0elY0QnRCa3RL?=
 =?utf-8?B?Z2J0UXhmNVYyVWdZTlFjNll1anFrQWZSYmFkckR1Q3BPbW1jNXp6UTFldE53?=
 =?utf-8?B?Vlk4NnY0TVRDMTBJQ2FvMEs0M1QxWXBnYXF1RDJsZ1J2djFJSVNnanFsa3lt?=
 =?utf-8?B?RlVibGExSm9BSng1aVhqTkNjSERrelNDU1BLZTUzZjlZb0VraThUcmlER1l5?=
 =?utf-8?B?ei9ZcjJiRG5ZeTB5Y0RDY3pRam9QRllJVDk0Z01BVS9sVVBYSC81dlYyOSt3?=
 =?utf-8?B?RGpPeTZCR21OK3NVZ1dsYThBeUVGYWxMckJaMGEzYlNydXBwa2JESHora2Zn?=
 =?utf-8?B?c1QwSkVBUEtYSXcrd3IwUXl0S251cFJ3Nk9Ma29LbENEN0lpMDdJR3ozbmFR?=
 =?utf-8?B?OTR1NFR4a1IwQ2ZMWmlvOHZvc3dPa0wyT0V2cW9UeGd2b2lBZXVCY3BQQmdX?=
 =?utf-8?B?VFZzZEI5LzZGc09lYUhOZFh6bTZHVzMxWUJaVW1OQVNSSytuZWpKZE8yTk9l?=
 =?utf-8?B?aUJMMTZBWElyeUt1WEpHMGoxTWFtZDh2M3JJajd3Tkw3ckF0dTZVQlFXWGR2?=
 =?utf-8?B?eW50ZGxyenVBZWs5cDN0WVd4aVIyRVF4eUthOHd6M21BQndyK2xIdXY0aDB0?=
 =?utf-8?B?T29KWEI2eFNTMHdBZDM4WHVWT3NwdjFldkl1MFZJdFJMQVBEV0xkU0szUjVk?=
 =?utf-8?B?MTVRbkkybUlGRVBNU09Fa2t1YTBlTkVnYnVsS1NNcGlCQ1lHN0ZJRmxKbVZB?=
 =?utf-8?B?ZHA0eGZsUkdWdUpKSXE0ODUrQStIY0c3MklpdkZPZWVXM3lwTHZWU0NrTzVE?=
 =?utf-8?B?QzU3Uk5IUmRBQlRodTdHTjJrYmdMaU04eGZRQUZhNW5jMXVUZXhoa0R1WEJC?=
 =?utf-8?B?dURSUWsrWHhxTks0WUgzbVQ0WTN6dE9QcGtleE9GaktFMUJudlpzdWFKQldM?=
 =?utf-8?B?T2VQdXVFVmp5cG5LaFUyWE9VWThzK2ZKUlhvM2VNNkZ1UGR5YUZxQ0FtcGpQ?=
 =?utf-8?B?b29sRWd5azcxNHFnaGRHZHJpbHZXcEVFQ3hqRUlLUVVVYkQzdnl3ZWF5WWRN?=
 =?utf-8?B?ZkxOUG5wcUF2MXVlKzVaWHVIaGhoUUFHSEw3TjhpQUFvWUhnanY3OXRvaW5x?=
 =?utf-8?B?MnVpbWRzSHZmdk1lcFphY3R4RGJEZWtMY3BsSDhOd3NsWTlPZEVWYVZ3WS80?=
 =?utf-8?B?VU45dllDdFlyVWxXNGR3dFR1bElUR3dWL1NNdnlrU3dWRWhVMzAzcFd2SXJx?=
 =?utf-8?B?bTlQcHdLcUgwMTBZWkk3TnlVS2NuZmF6R0NPbFdtMXA3czVuQ0NZM1VMeW02?=
 =?utf-8?B?K21GNHM2WHRvcjVWYi9iNjAzSzNYNkVIRTEyU3pzTWRmckk1eERESUxrMDk4?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02413e57-bb40-4ecd-4934-08de06177304
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 03:04:51.8793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/9OZrjlwGNA8mhZD3YjVg6WJTlZaQQS/rAm3i8NhncE1DShVcEjsKhpqm9ZwMIsdLC1yqtGfEMf/XjDPhsL4LgHji/Y2DWQKY5jIEBnIpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4692
X-OriginatorOrg: intel.com

Hi Babu,

On 10/7/25 4:47 PM, Moger, Babu wrote:
> On 10/7/2025 3:23 PM, Reinette Chatre wrote:
>> On 10/6/25 4:13 PM, Babu Moger wrote:

...

>>> ---
>>>
>>> Tested this on multiple AMD systems, but not on Intel systems.
>>> Need help with that. If everything goes well, this patch needs to
>>> go to all the stable kernels.
>>
>> Needs a "Fixes" and "Cc: stable@vger.kernel.org"?
> 
> Hmm.. Not sure. Which commit to add Fixes in. This is AMD related.
> We should have taken care when adding support to AMD. Does this commit make sense?
> 
> Fixes: 4d05bf71f157d ("x86/resctrl: Introduce AMD QOS feature")

This seems fair. From what I can tell this spans all LTS kernels so I expect
a couple of different variants of this fix since this code has evolved quite a lot.
Do you want this fix backported to all the LTS kernels?
It may be useful to add a note to the stable team that this patch needs changes to
apply to all kernel versions (see "Point out known problems"
in Documentation/process/stable-kernel-rules.rst)

>> This patch will only apply to upstream though so would need backporting
>> support. Will you be able to support this?
> 
> Yes. I can do that.

Thank you very much.

Reinette


