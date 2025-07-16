Return-Path: <linux-kernel+bounces-733910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B44B07A7E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F8277B0B31
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7AE1E5701;
	Wed, 16 Jul 2025 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aCgEESfv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B1E1D79BE
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752681533; cv=fail; b=kx2AoEt1boQe/rOCvh1G2eTuUtHPdJGU6k+WMSap9tAiE+H178g+hCzvYJRNgmwMX2NWOvn2V1dyuNEOj+G/6jVlP8EmwAPcg37udR5iwjNYtBn77Pfz86xEGJ8hq7KCBxOzEkmtIf+0G1Sgvp324uIs3GGy3kTm41NZgTp0yr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752681533; c=relaxed/simple;
	bh=7tHzEYa2qF2xkoNGaUtN1FZYhnzAF9v1fnlqotk9fgU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DegwilyEfroeiDAGuNfUWwrm4rpjmnEMN8kEYclczZe8n6zVVqWmcRYfekR9NvYDgkKTbElTJp59ZeODMzkZfAZODK77HpZ5w7j3XzdvpOBil48OpzQJQ6QKAODvSrJXQvSZYtSBI4luZgd4yZIWeumrQry94qck+FkA7ebjtTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aCgEESfv; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752681532; x=1784217532;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7tHzEYa2qF2xkoNGaUtN1FZYhnzAF9v1fnlqotk9fgU=;
  b=aCgEESfv3YCbhAYJoxzye69FPylVrsYZxt4rtpmlXhwmsBI7gpsoeaii
   92wUYMINtnRB2BP8A576EtGrWxy5XI25nHVnYqbgQZ2nKJ1354j09VqrR
   AkF0o62IcXl5JrF1pR1kV1H+OKEFi0lidRPa1HwpLGWVBbyg0sptx3+Yd
   D+7VXZcpjHHGcxT0uS4ObjzmIxR5FK7MSemJ5x30+ncw0QqUVkGqgQ0Be
   tRTfIAfqo8sSJAoWUrBNdH8xvnruYb+c512QCfMAUvLLXhkk51fyAWpk+
   XMdt4Uu9om4u/pIPfWWVGzYZrWp10zZ8emWwGYFHC1KxFKvDS/Y2GEn4p
   g==;
X-CSE-ConnectionGUID: gbzrIuzMT1au5Gfxs3Fvqg==
X-CSE-MsgGUID: 64/hryjfT0GVKfxuS8Cd+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="65631195"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="65631195"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 08:58:45 -0700
X-CSE-ConnectionGUID: WDNM920VQbuzKx0J8IR74Q==
X-CSE-MsgGUID: nvoo4B3pQpuC6NLKkjCp2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="158262971"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 08:58:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 08:58:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 08:58:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.89)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 16 Jul 2025 08:58:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGTdj3F+NLzepMOI9houwAKlq9ODUezUmnYyvf2FC18qUYrHK+xsFVtsNcYZlX/fiSZHab06IlzZGA85NKr6VAxefmWbdTSxJWesC/r9Qt6EqD10xuOD8qErIU+YNNPtrlFB6RFa2oVj5+D2L/O28LKlUMJ0/BRuVSy1mY4iqaJDWE8HvuQANB1UaPfsbin9fdY9HNNrXb5lL7g39rmcbLm9xyqpItcdpfRvnde9jShbPsTgpNH9YhgR3R/B5CLJi558kdBTMr1tBQtX9uDIGuxHWjtxAjd97JbSFDVDmy1+oThT0NHujeZYq9lkqDsbIzXGmjJdMnOFI2WlxiN9Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nmq8KIBxeV6nO59BfdJcFNraWse98+pkI42vK/hCOA=;
 b=IoxCV5bjXr3PHu06i1CRkeg1L6GidhYrPwCMLk6XayIQmifVD8xSTjm4WXSPy8fMqR9WlkM0xke/lesH4TaAoklfapTQ2HkDfCmvUFMb9Qx9+6huqZkWBy9DRDQKlkE4dHM7LRTQLH073iEI8qK8GnVwLbZSi+Z63se4dhcPTypamEjacSN7du9E3TelLWush4TbuxPB7atf8WghlyBqVlNvKinuADM6hCvHJL2sVRKXuF+Q2vTGPxw43LfIl5j2/eo+bEo3GzbcPXR38wiugGhOIf299Uopcj7M4QSmqVrtIPT2ZMlnqzWXdgYGWtNbuKK40dzfj3Uljp6boTEyYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH0PR11MB5926.namprd11.prod.outlook.com (2603:10b6:510:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 16 Jul
 2025 15:58:42 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.8857.026; Wed, 16 Jul 2025
 15:58:42 +0000
Message-ID: <ccc99276-2f26-4cea-9f55-be7f75c8bf00@intel.com>
Date: Wed, 16 Jul 2025 23:58:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/fair: bump sd->max_newidle_lb_cost when newidle
 balance fails
To: Peter Zijlstra <peterz@infradead.org>
CC: kernel test robot <oliver.sang@intel.com>, Chris Mason <clm@fb.com>,
	<oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<aubrey.li@linux.intel.com>, <vincent.guittot@linaro.org>
References: <202507150846.538fc133-lkp@intel.com>
 <10abe013-98d6-4080-ac43-0f1e02aa41f9@intel.com>
 <20250716112533.GS1613200@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20250716112533.GS1613200@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:3:17::30) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH0PR11MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: e731ba2d-c6d4-46f7-e095-08ddc481a2b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkx2ODJVRDRtNjJJb1lZM1d1NXVHWWcvQ0pGSFlLUFVtQ1RnUnQ0cnhzQzEr?=
 =?utf-8?B?aVVpMkpoNTlsMnJYWHJTbmY4cWw4Z200SHJRdDk2SWxsdmUvcXpLcmY1VXZZ?=
 =?utf-8?B?Z3pXMlRYdGw5YjF1TzQ3aTRFb0dKeFQ4MDhOVGpXcjhrWS9UcURpY1BGeUUz?=
 =?utf-8?B?b0ZIdjhUSGR1QkRRbU1CcHpLN29JY0piclA3OENxbUx2MTdSaklyaGtKY0Fy?=
 =?utf-8?B?bFc5ZWlKUjQwSHg3R3VPRDJwR0ZmNkhrdFBKZFlBMHRycDNTNk5Ic3ZsYi82?=
 =?utf-8?B?M3piSVdnTzZGU2tkZ1VYVXBvemlnYlJncS9QVEJXaTVQQXk0TlJMQVV5TndG?=
 =?utf-8?B?aG1PbFBGYnhabzVnUjB2eWtDZ0xnZU1hVUYyZGVoQWhvWGNHT0dMQlJ5OC9G?=
 =?utf-8?B?c3YxdkNNai9DZGM1ZTczTWdna25MRk1IbW5yYUtTYlI5QndaeWhldlNkSG0z?=
 =?utf-8?B?eFZkamwrWDZsVHZRcWhoL0x0c2JuaEVZK3djS3NmYUljbzdoU3hOaVZJcEFj?=
 =?utf-8?B?c2lnRG1zU3pVaU55WHJwaHM3anBHb0dXYmZxNDJqSitrNlZDVmRJRG1LWGNP?=
 =?utf-8?B?K0dTNW9KL2R1OXM3YWhrRktGRmZjdlRZOC9zL3ZNS1lCYmh6b1crUkhVN2V6?=
 =?utf-8?B?ajVvV3FCcmNZMXhCYVBlKzZ4ZlhPZVVrU3V2R2RzT2Nid1ZMc2hrY2dOR2tp?=
 =?utf-8?B?c2k5eVNDZnBBSDBKdmlUem5hNFVmVHd2c0QvUElZMU5ScWRyRDh0UGpQaWtR?=
 =?utf-8?B?Z1JHNzdRaXJNUGRueG5VckN5QnpJZ041ZGxveGwrdGVVeE5QclZtWXArNmtG?=
 =?utf-8?B?VUIwRkdQbHhFd2NFenBLNGFiVXJFeHFMZHd0ajVibVYxWXdsNityT0NKVkI0?=
 =?utf-8?B?YjRZSmN3UVRWZC9HNS92TTFGRm9jNEVWb1FzVFN2eUpIdFUrWWUwVW5xZ2VR?=
 =?utf-8?B?MHk1V2FKTkJHMjFmVHlSc2s0TTRiQkpCeXJWOW9IY0h3YUdGUS9GVWpqWjRC?=
 =?utf-8?B?cmMydFBQQzlpbXVrSjM2dnFJd1Jld1cwR1pKd3hNYXpjdzVROFFGKzVBczFI?=
 =?utf-8?B?MFBzOERvamhCRloxODRUT1grVHM0RUV3L2lNbExyK1ZRNmRxdWZjbDFEaUJq?=
 =?utf-8?B?M2VCS3IrcTRCdjEva3ZNYjNmTUgxcFJaVERoVlFWeGdrc2VTaWVOTmVTZDV6?=
 =?utf-8?B?bnEyeXFLcURZMFlEeEVxWmV5Mk5TMWdyMkNFR3hsWGZVM2p0S3YvdjkrSzJl?=
 =?utf-8?B?VW5GL2RzUnNuNG1OR2wyWGtqSmsyVDQxdk5WS2RDTGIxSGdhNXNmU2x0alhy?=
 =?utf-8?B?bnp5SUN6dmhweGRoTWpveVJlemRUWVJKdG1sWTFveFVYcE5BSGpuOFUrQWVY?=
 =?utf-8?B?WExWU0dGVUhpMGVTUXR3SGpDWnVhTk0vN1hFdkNZeHRxMk80Wk9PaElERFhr?=
 =?utf-8?B?MHNkbzRQTktWNkYvWXN0YzZDOGhkWERjSGpSSkZmSVFKMy9qVnBTU3BQWll3?=
 =?utf-8?B?WWx3Wkd0WVNibTJFcjRFcDA0M244cnRsL20wMUxNL1dTQmVnZVlGS3g4cFJp?=
 =?utf-8?B?VjBLVG1NbjVWaFBjK3Z2NVUyVXlwaGdoRDIzWkRoTS9yNm9Wc2dadkY5L3M1?=
 =?utf-8?B?VHB0SVBTZnUvM3YxL3lORmIyeWhmYmFCeFlrMzF1VnN6R2NKd05rZ3daY0I0?=
 =?utf-8?B?RW95TEFKdTRmeXlBOVk5Y3o1ZVJ6MVhGWFNLSWtHTEEzUktQZnR4dys3STJ4?=
 =?utf-8?B?ZHB2RmdVWkNEV3R3eDBCbm5CTGNsWjY4NnZwa0VZU1RJYWtWaElmOGk3T0Uz?=
 =?utf-8?B?ekdKNnh3NlJxWCtuYmNVQ09Yd0xveUVsTnBoeUovWE40NW9UVjVqYmJWeVVE?=
 =?utf-8?B?QmNWOGpVMXRwQlhXMDYrcWVYb0dIYzdEY2Q0NVlCeGlibUdZbHFjM1F1cFcx?=
 =?utf-8?Q?eHhHOONtguw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU4zYnEwelNMRG9qSXltcXU2Ky9FTTBqZWpvVkNENEtBckt1eHJpK00wVWlO?=
 =?utf-8?B?NzBNYnQwMURxSEppZ2JiUFZJU084YWFsQk1KWmppZUF6T1NHa0d0ZE82bi8y?=
 =?utf-8?B?K01MQk9VSHl0ek5pUWo4OHdtNlZIWmVxbDFiYnJrMXhPeTFKRnRCRm9uOXl4?=
 =?utf-8?B?aXdacndWRmJCL3Ruc3BNY2E0QnBIMkFuTWJTcWhkdmk0UGUxZ1pRZ2N1dG82?=
 =?utf-8?B?ai9NUXZHbzhCTjNOcUU3RVltTnhsb29aNERnV1ZCdnppenJ2RTNROUJOa1Q2?=
 =?utf-8?B?UUw3WUJUMDN0eDRLd3Bqa3ZpenpIZnRzQ0l0Z0s4VExza2RERXpmb25nY25U?=
 =?utf-8?B?TlFOZVFpMzJkMk1KdDVDQUVZc041NFVUQkpIZ0JNZ1dydWVQaWFzazhVTmZZ?=
 =?utf-8?B?ZjhOMUNFS3ByWVlYM1VzdlN6OVFKZjRMdnMzNXVGYms3K3JIMFZJYVdkV0ps?=
 =?utf-8?B?SnFPRnhMVzJ5NmM2N0FTeU12clZpMkRLRmFseDZIbElja3FhcE1ac1hnTG1P?=
 =?utf-8?B?Znd2Mk9oa1hib1UxUUhLTlcvZGlJZ2w3K0swcHVDVWZUaUpQeFN5cERkNlJl?=
 =?utf-8?B?WUJES0R4U3czSjFQck1Ic2Y1aEZpRHIyQnljOHN5L1NQZ0Q3ek1HK1ZyZjRl?=
 =?utf-8?B?MXhjc29LeEhUbXRQVmdMTWxrRUFPT25yUXZYV3dnUDJpaWlCZmZ3Znl1WU9K?=
 =?utf-8?B?Z2NsOUdRdEg4QzdHNkZIVk1pK3lRS3hhdG93WW1mcmlZYVJIemxzb2JhWWZN?=
 =?utf-8?B?TXFVNmlVdVl5TElubE9NdXBkeWdVbWlPc05RbFQyWDFxMkZlZ1cvMTREWFph?=
 =?utf-8?B?Q2JuQ0hHT3hHQUVING04MVJtSlNVUUZJVUJyUEZ3UWxZaHd3WGYzVnQzQllT?=
 =?utf-8?B?M2tCSDNPc3ZlSG1ZTnYybDdaVWNXMnd2UnhrcUhaNkdaaE9oLy94MVkvaG9l?=
 =?utf-8?B?V2txd3FBTkFJRDM3b1huS2JiNytYWUd4REVQSWNtRllPVWNBa1FyWHhTbmlV?=
 =?utf-8?B?dzFnRVUvMnErWVV5aWxBNlpIYzFSTGdqdkNCYlpOd283Uk9iRFo4bVJNWVl1?=
 =?utf-8?B?eUw2SGlYU1VUZkF0NFlZWGczY3V0d09PZThXRXVmQTU0bWQ2Y0d2bGRCa3ZW?=
 =?utf-8?B?SEtpc0NIc2F6aXl5UGVNYzhSYW5jWklpaXZCVSt6UFN5NEErTTFRQUFYU296?=
 =?utf-8?B?SXpCdG9pOXZBd05PUHhjejg4dElGU2lxbE5UVjFvRnRUd0NzZUxEeDRmWUJt?=
 =?utf-8?B?VlpoZ0FDc2NTcE4wUStCSjF4ZnhONlgzVnNUYnlqTkpzdmNWd0hkZHRTLzlh?=
 =?utf-8?B?aUdNeG1Vc3hjMEU3UEsyWEdpRm92L3NQRFMxaHpoejVRN0lNM1gwTzJTdno0?=
 =?utf-8?B?dy92b2hKZGxtVmpEQjY1QkVKaGlRaUc0KzBqb0NzcVdSKzhzYnhVd2l4WG5Q?=
 =?utf-8?B?RDY5NzFsTW1GOGJQS2ZUbS9FZzQxcmlrN1FrZ3NGV2QrVkp4QkRDaGlycDZZ?=
 =?utf-8?B?NmxhcXB5YmVJZHdTSWJyQ2EwSUJSM0lkU21OVUE2RkNHQndnay92bXBaVkZQ?=
 =?utf-8?B?SjJMMzdtMHhmbW5VV2k2STEraGlENDRsL1haU0dNRDBFYStlY2lmanEzc0pG?=
 =?utf-8?B?QkpYb0l0TlZiNEY1eWxSVG5UVnNDOUpkTmlOOHh3UWxtNUppdFY1RjZoeDFj?=
 =?utf-8?B?dG9oUTFYZXBDaFBYYU5yNUN1TGExbU1naVl0Z2d2OXdsdGMyT1p3RERhRk5J?=
 =?utf-8?B?UDFBcVhVVDF0cHY5RmpUOHJtQ0tpbEI3ZGQ5TFliM01rd1dzTUpZcVZtaVZV?=
 =?utf-8?B?T0xBYnhHUzlnUjdCV0g0OGhUQUtwRVRSTndhZ1c4bTdrLzUvdHc5YW12YmVy?=
 =?utf-8?B?MDBZUURRVFg4K0R5QjBNM1EzekZtUGhoYWNuMWJPT0NUS3FlUmhjOExZcEt3?=
 =?utf-8?B?V1VOMXNiOURaZkFYd0Q3d05rV1MwZTVmWDYzb0pHR0xzWlhQSm1nRyt4SHdu?=
 =?utf-8?B?c0laYTM5cVV2NzBzbnJVeHowaTRXV3NGMTcxVHc1MjE5U0Q4cVFJU09PTFBV?=
 =?utf-8?B?Nks4Wkk5NW9OTWFKbTRmOERCT3FBeXpjRVNEc2J6eXI5Rm5sRWVmZ3JPZGNu?=
 =?utf-8?Q?eOXWc6lQsuDImW71vMjQfhEle?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e731ba2d-c6d4-46f7-e095-08ddc481a2b0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 15:58:41.9787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxVhqJ43bUoOqjDOcdKKCKqkclzJevmAb/bUsLrJaB82R9SZu3eu2HYxPspQxi2OD88PiEKNHLwmkq/oHZg1yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5926
X-OriginatorOrg: intel.com

On 7/16/2025 7:25 PM, Peter Zijlstra wrote:
> On Tue, Jul 15, 2025 at 06:08:43PM +0800, Chen, Yu C wrote:
>> On 7/15/2025 3:08 PM, kernel test robot wrote:
>>>
>>>
>>> Hello,
>>>
>>> kernel test robot noticed a 22.9% regression of unixbench.throughput on:
>>>
>>>
>>> commit: ac34cb39e8aea9915ec2f4e08c979eb2ed1d7561 ("[PATCH v2] sched/fair: bump sd->max_newidle_lb_cost when newidle balance fails")
>>> url: https://github.com/intel-lab-lkp/linux/commits/Chris-Mason/sched-fair-bump-sd-max_newidle_lb_cost-when-newidle-balance-fails/20250626-224805
>>> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 5bc34be478d09c4d16009e665e020ad0fcd0deea
>>> patch link: https://lore.kernel.org/all/20250626144017.1510594-2-clm@fb.com/
>>> patch subject: [PATCH v2] sched/fair: bump sd->max_newidle_lb_cost when newidle balance fails
>>>
>>> testcase: unixbench
>>> config: x86_64-rhel-9.4
>>> compiler: gcc-12
>>> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
>>> parameters:
>>>
>>> 	runtime: 300s
>>> 	nr_task: 100%
>>> 	test: shell1
>>> 	cpufreq_governor: performance
>>>
>>>
>> ...
>>
>>>
>>> commit:
>>>     5bc34be478 ("sched/core: Reorganize cgroup bandwidth control interface file writes")
>>>     ac34cb39e8 ("sched/fair: bump sd->max_newidle_lb_cost when newidle balance fails")
>>>
>>> 5bc34be478d09c4d ac34cb39e8aea9915ec2f4e08c9
>>> ---------------- ---------------------------
>>>            %stddev     %change         %stddev
>>>                \          |                \
>> ...
>>
>>>        40.37           +16.9       57.24        mpstat.cpu.all.idle%
>>
>> This commit inhibits the newidle balance.
> 
> When not successful. So when newidle balance is not succeeding to pull
> tasks, it is backing off and doing less of it.
> 
>> It seems that some workloads
>> do not like newlyidle balance, like schbench, which is short duration
>> task. While other workloads want the newidle balance to pull at its best
>> effort, like unixbench shell test case.
>> Just wonder if we can check the sched domain's average utilization to
>> decide how hard we should trigger the newly idle balance, or can we check
>> the overutilized flag to decide whether we should launch the
>> new idle balance, something I was thinking of:
> 
> Looking at the actual util signal might be interesting, but as Chris
> already noted, overutilized isn't the right thing to look at. Simply
> taking rq->cfs.avg.util_avg might be more useful. Very high util and
> failure to pull might indicate new-idle just isn't very important /
> effective. While low util and failure might mean we should try harder.
> 
> Other things to look at:
> 
>   - if the sysctl_sched_migration_cost limit isn't artificially limiting
>     actual scanning costs. Eg. very large domains might perhaps have
>     costs that are genuinely larger than that somewhat random number.
> 
>   - if despite the apparent failure to pull, we do already have something
>     to run (eg. wakeups).
> 
>   - if the 3/2 backoff is perhaps too aggressive vs the 1% per second
>     decay.

Thanks for the suggestions, let me try to reproduce this issue locally
to see what is the proper way to get it addressed.


thanks,
Chenyu

