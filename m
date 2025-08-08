Return-Path: <linux-kernel+bounces-759629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD279B1E058
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 03:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A7EB7AABC1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 01:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D7F158DAC;
	Fri,  8 Aug 2025 01:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IdLLKLtQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB5B1553AA;
	Fri,  8 Aug 2025 01:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754618026; cv=fail; b=DPGffLcTMqnNYPlAqsWlfmGJMUvSvf3RhxP+zafyUKG9Nnbal0OZF/gSSgQjqFB9lH3t7Cx5sBFbXVcFV1RXbOdGsBZbxOA9oxY7XTERhxpTJNEMkHF41ntGQahD8+PRtRNFUacF30v5Qng/YIIruF3WFQjVX6Bdf9nNJ53Xz+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754618026; c=relaxed/simple;
	bh=nOcwpHq7/Ng25sL7bkA27g8Ky4v//uStdlpxaaW/UB8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xbc6iKvT4nsqg+up3k0326qp/2k02rSULgbDbxeQIZIk+yFGFBC6caP7VpFh+xofQZYgRGsCt/Kdch3IXFJUA5McknXU1FIcjz35kmf/bPJ1RZ92mh2HRaEODpI3GbtT0zfPbO0ghXbSwG/mYP7OFWIlihPTJqQ3l0P8B4x1SR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IdLLKLtQ; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754618024; x=1786154024;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nOcwpHq7/Ng25sL7bkA27g8Ky4v//uStdlpxaaW/UB8=;
  b=IdLLKLtQQQSg1xmTsv/XF2n19iNa1gtpa3fI5W97MhMRZtdBKbi7c7+d
   hx+fBwcu7QfBUEChX6D2PbUBNlQkMOm6TpQmOWAiXGR9o0BeLS2k6U4Hk
   0uvZbRESwef6VzRxtewLr8d6EUlX8c1joGVTKDpmGDK2iy2nt0i23UBLA
   wI9jE6jVqew8/biY8qyHOwN7Ca/vsyqLK6nxE1GWENMHSxkjWFDEKm+Kf
   n9kmoKaU5wdvRk/zQJCPimdsGtyKaK5CClDpTzXopBrv4z80uGBhcqLkx
   yGWzptMshKj9sbzXs8oW4T1tRYGMr8qn/VsqvpkFmAeuNlaVa6wxN1Gs4
   g==;
X-CSE-ConnectionGUID: zIP+jov4SqGjB1nQu9tPBw==
X-CSE-MsgGUID: fB+2A0SoRCalO/OcOpJPiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56885447"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="56885447"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 18:53:43 -0700
X-CSE-ConnectionGUID: Peg0F9saSHKsmuP5c0m8gg==
X-CSE-MsgGUID: D4q0khX7SXmlA2QDfmkzQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="196039116"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 18:53:43 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 18:53:42 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 18:53:42 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.53)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 18:53:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mfnp9kynJbkQSzd2dEiHZ0W58mCoouGX4ciSCWh8Sr5YF649MTOuHzPLCbLeYu3mtK1YtSg5Xwk04F3o6U2/iQrQLUbIt2GhOu3K9dhvPdAxNMLa5kuBF5Fj/FP+gCtJHKRjK7/9A9+w7HGTAMFHNru4xBP1cyiLKdEigLYe5RZGuFTYkMOeqi2cf9RlLdOmju6UZzfFY696Lmb72wPOdHVpr8hyYiYZznRZIm3YjQTQ62LbUvcd/ByuHRQl9qjMacE63kQdxxq3xIorKUJteY/dRY9hn8vHsddcxGEdbzXcnJ6Td/8GsGxZgWhpITpTpiPmS9u3+gDr/7ENbckP/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pokd2+PsoJMPnwkUtBE2VYnqh5lglezVxeHSr9xHys0=;
 b=G2UeaGAOom4/OIUAxSTVekhe3Z/3NTTMSQr++sekSlYY16klcWNYHHoJqn4ts42BqsknVPTsX4wacCfvlxVVk65GjcQUyL59ELu4A9yGbijnDoXcyCgZbsbz9xdEW55pa2+AeHgc2dKH5cXUnUgt09gbGCIE9YWwkF9q7LxCs1xH+AnjhYbTsCxESKonmRg/AAOJdFap2J7CsbfgPa3OxGAOqKFgRgyRPPN98Pzu4LIti1THoHvwpVeeIADx+1m8sZgOzmvjUasgpDyDqLoRv0c5zFuaNzenrGBwwpwuuVgNdNEgkyf/572PrCYx6/2yJF2lYkfwu5wbABP91jOwJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW6PR11MB8390.namprd11.prod.outlook.com (2603:10b6:303:240::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 01:53:35 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 01:53:35 +0000
Message-ID: <5003e6ca-6683-44f7-9a44-7fce8537a7e4@intel.com>
Date: Thu, 7 Aug 2025 18:53:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/10] fs/resctrl: Introduce interface to modify
 io_alloc Capacity Bit Masks
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
 <4652b5d8fac8ecad90b3eb734851916036246140.1754436586.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <4652b5d8fac8ecad90b3eb734851916036246140.1754436586.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW6PR11MB8390:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d9af32b-d6d6-424c-fb03-08ddd61e629d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N09iWGMxREMrNmN6bWRzUVZaeDR3MUQ0Q3ZLTWRxblBOU0RIOUMxYUYwTGdO?=
 =?utf-8?B?TVdkMjJ1WU9kc0hXMUEwd0lYUU9YSVF3bHYxeUpYU2htd3V4UUphR3hkZ25V?=
 =?utf-8?B?L2RLSHZ1ZjJNdGhNSEM4ckhsM3VLMFBHSDRGbFVpKzFzNVZiNFh5c2ZnbTJJ?=
 =?utf-8?B?WEc3dzVhQTlhVDhxL29rSEZ6VFNuQksyNnRtVENNMCs5cWpnMkNuTDg5RXJx?=
 =?utf-8?B?MjUrUGlJeDRQMWNlSFptdjBURkd3djZINy82MUFWYkpOY2F6OVRGK2JJMFhH?=
 =?utf-8?B?QVhZdDVLZXNUWmd5ak9qUk45S2t0bUQ1NUFsczVHTFFjTko2TEhSc1dIR0ds?=
 =?utf-8?B?SDNiTWhHUnFCdmxPRkhJaHFIK2pCUDBmMmRXWnMvS1p2TXIyRjRRVlBQSDZp?=
 =?utf-8?B?d1NYNkordEpPT1llbnE1OU5zMmVic3NVcmI0ejF1enQxbDlyd1NiOHVqZDYw?=
 =?utf-8?B?UzlGb2RHejJoVExERGU1VWdabUZtcXFGNVFNSVNYdHdWdm9TTG4wL2pZUUd4?=
 =?utf-8?B?c1Uvc294cGV3dTdzQysvWXpwZmpuTnNxayswNjk1ZGVGc3dTRU12VVp3ZnJQ?=
 =?utf-8?B?T3RMMm1RL242Z240Vm5lTk9uTTlrSUFaaTROS2s2OU9sM2xNN0xoV21wMUJz?=
 =?utf-8?B?NzBPUzZyNnpFbXozSWwyRmw3QUdZRkM4MW9iWTRCUDkrc2hSR2IyakU0aW9Q?=
 =?utf-8?B?cWpLbm5hc09vTEIyODNjOTc3eFF2YXc2NHV4cnFadm1ueGh4NHh5ajJNUjI4?=
 =?utf-8?B?eEsvWlBoWlJOaWgzTW9hbW9qMlRXTmJjckdvcjJGLzRpZHF6bUNaYnZRbmJ0?=
 =?utf-8?B?K0o5bStUbi9hbExYODRlT1ByMHNDemhMNzh6bnB6dVVGS2o2OGRRVUZmOWZk?=
 =?utf-8?B?NTdBN2E0RFVTV0FlNGVkMEJDaVN0VkY0ZE9Jd1B5S25MTFZJOWFtM3hQUWlK?=
 =?utf-8?B?ck9Rc1FCeTBYdFUrOWVQNzhkcEhSUktLVHZhV3p2bGdOSStLb293TDQzMzRo?=
 =?utf-8?B?cll1MFRkZzlvQm9QUU9rdDJ2aEZHZENNNlRyUHZjWXRYT1dyZTNDYmdNQ0Zu?=
 =?utf-8?B?cVhDY3dMZjBFK01SUW85c0NNb3NVelZyNWFOdWx5Y0dTODhNaXpzSnZjem4r?=
 =?utf-8?B?K0dMajIwWDN4LzVNUjVBa0RXd3JFQXJlUXJsQW9pQlRDTWQrT2RLOXZ5VzRV?=
 =?utf-8?B?WXZGQTFMRFBMdjFEVzBYNlU0bk1kY3d5R3p0N0pXVmxVdHVFak5OS3BJdklr?=
 =?utf-8?B?dndVaEh3TUlFZTVEUDJnL3BwZHF6YWsycVlOMXVYbXBNNm5xdlVQbmxYOTRm?=
 =?utf-8?B?YjJvTFJwbkNpL1MrSEVTSTBZLzhFUDJlOWNCajIrU2MvcWZrelVwQitIT2hT?=
 =?utf-8?B?cy85Y3ZEUkk0blFVeVJIcWNrVVNoUS94RndZZVZPVWwwdnhuMDNNeGkxVVdi?=
 =?utf-8?B?R01mZGFodWsyVXlOS0I1dXNzbkJHem5KelFXQ204UmJzUmdXUkxEeDMrNzk1?=
 =?utf-8?B?S1dZZjdaUEdxelZFdXVtdnJWbHJKb0JvVTEzL1VlRG53UXZBa09QakRkYzc5?=
 =?utf-8?B?eUhFL01Zbk9ONHRJbVJUWGJkYjc2RTZnT09JOWlzZ0picjhmN0xERU5abUl5?=
 =?utf-8?B?YWltdHpLakpSK1JqK3I1QjJGbFBnaHZZd2lmUDhBRzcra0lOdGVINlhoQkk2?=
 =?utf-8?B?eXhCWWlqN3JpeVJyOURiRG14bnRyYjRQMEVLQzdlVnZHZ1h6ejQyVjJxbTV2?=
 =?utf-8?B?MmRuekV5ZGozNkNHNVVPZHVXYmxGV2NyL2hEeGFid0JEZ2xLSW9ST0RYTzkw?=
 =?utf-8?B?by9ZSUZDRUE4RkY5b1dHanI1NjJVaGFkNERNeHEybjJZSStJTnZaRVk4cXR0?=
 =?utf-8?B?VUY5VTl0SHNIK3Q3RG11UTFjbzNGaDVETFF5SDVoUXlzazZJZjVkei8zRTJr?=
 =?utf-8?Q?s6OPu5lAxGE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmtqRWZXa2YwZ1lVTWJRd2NjbDlWS0o0RElsV2pRN00vR3Y1WXRQWmlLUndE?=
 =?utf-8?B?N0R6VERPZzVLV3pGeFBCWWdxTFNaU3d4MkgrOTZWL2cxR3NYajZxMHRBTmZ0?=
 =?utf-8?B?RWgxMmdIMFV6endScHFCRSs2cVpGM09pZ0ljKzdOakdjOGNsekIxaGVhMjUz?=
 =?utf-8?B?WitORWRWeW1UQ3BjbkwzamNXQnZjb2tJUStVZFQwS3lZWlpHZlowS3NidUNF?=
 =?utf-8?B?N3haTnArWFJCeTJRelcvOTJoTGNWdXpMZm13UUFMd28zOHl2ZWhCNE9kN1or?=
 =?utf-8?B?TjQ1WDZ4WUthYjMzVnorNlJIeG1DdkdsYWFhNWNjZlcrY2ZVbCtHejRFa3VR?=
 =?utf-8?B?Z3RKV2Y0SGloRzVMUzd1NlhJanZXS2NPWGtaUFZXMVgwRVBtdzZSNUxOaU1j?=
 =?utf-8?B?d3l4Y293RVdaVW5lUGcvOTU0eCtPZ2pnRGt1amJUdE4rdVBna0ZUOHkwUUh0?=
 =?utf-8?B?VURuRHZiYXAvT3VDQ2lMZ2hlaTVCa1ZtdU9GdnRSSlF0cUZYTnVMQStJeDZ3?=
 =?utf-8?B?ZThGajR0aHN1aGgzSW02WTFyV1hqa2hOR2VtcEFFZ0l1YklWcHUydDI2bHhl?=
 =?utf-8?B?T0VsS3ppNW9nV2pFNFVJQ0xhK3hIMks3S2dZVWpoL3VrM0JudUhFUTJIMlN1?=
 =?utf-8?B?dlB2Y3VrdHlVRUdSbENRbHp2dG5IbStSY2FhLzJMSVNWRHpHcXNDZDFiQWNB?=
 =?utf-8?B?czFoQWJkN0MvNjQybzB0UlcwdUd2Z25oYmc5aDdPbmpBMnBkR2RYT2FiY3lQ?=
 =?utf-8?B?czl0cGN4T3Q3dlhuajdIV2tpVG9KRzc4OGZaWFlRdjZTQUZKZFFabUNzb3VR?=
 =?utf-8?B?dHlpSVczMTFqT0U5d2lqR0p6dmVuNWJLcXl1d2FCZHpNcWkzbFZVMEpVUU1C?=
 =?utf-8?B?Tmo3dnVnK1h6S0dOYk5EeUtRa3N1TmZkRUcvVks2N054a2IrWlpaakI2NGhz?=
 =?utf-8?B?S090RldyS21CaVNLS2NQcVo5RWtzMWMwQ3VPckFyMXgzNllua0ZvL3BwZ2Uz?=
 =?utf-8?B?aTUvc0Zwa01zMHpVUEZlcThZcGhNTUlqSm5VUm9GZHl3c0srTzNVSE5JcDEy?=
 =?utf-8?B?V2YxZ25RdDVmZkpHZmgzOG9FZjBhVXIzZkpmZlA0Zzh0clJUZFBXRnh0aXA3?=
 =?utf-8?B?NjExc0JvaDIwTFBkZmRiSXJuWS9EREVoMlN3M1UwV01QK1hUUFgxKzZ0QXIx?=
 =?utf-8?B?VXlVeWtVYU9Zbm92eHplOHhRQlNOMkdzdU5BTHIxRmxqRlN6dkxTaXg0bXQ5?=
 =?utf-8?B?ZG93WDgrMERWQlZaTnFoWHhxdHhyc1pCRTZjTStGb2RJVkE2aVRUZTV0QWVS?=
 =?utf-8?B?LzVqc1ZHaEhORFNJWHpoQlhMMEZERklleklkZ3ZjV1k0a2E0YlJia0N1VWRE?=
 =?utf-8?B?UlowV0lwZnZjdXE0d0hxMHRzRUVFTUgrbnlpMmYxVExQVHhQWEZ3UzU5THhU?=
 =?utf-8?B?Zk5mcmtTUnc4TGMxMUwxaXdycmxEMkFEc1AxeTVSV2NXOEZGWm5la0l6YVFm?=
 =?utf-8?B?WUQvSXR1L2NGTHFzaTJKQ1BlVVpkMzVDVUJiSEUzTW5IbEZuMGhTTFlsZitJ?=
 =?utf-8?B?Ym41TEhCWTV0RnhrWTlOQjdaamRCZEEzbVNuOFdxU1NqMEdGRll5bEFZcDgy?=
 =?utf-8?B?M1BmWjhwaUJjeU83ZXFkVUFCNTdpNS9TNkFFK0oyK3pOT3lIbXNUY1R3bE4v?=
 =?utf-8?B?eW1jU0N4SzdLSmp2d0Y4ZDUzRHVFNlVmd2F3Y2pxYnlhN0hWYVpocTgwTi9x?=
 =?utf-8?B?Smd6UHR4YmViZjJiWkphT1lOdld6WFBwWHhJOFlkdkM2akU5NzQ1T3QzM292?=
 =?utf-8?B?SWdHYUZXdDVCYXpnNjI0ekYyb05DRmdYVm5PcEZESkpXSnZjT2FVa2EvWjY1?=
 =?utf-8?B?MGswVVZWSitLS0M5RzhxcVVzU01tNFFZWjFCR25YbC9MTjlHSmxIbkNJVFYr?=
 =?utf-8?B?UGpyZHhLZ1dVbG1UYUE3Yk11UHlOSCtRdUhDMzVTcU1xMk1EbHY5ZDVkT2V4?=
 =?utf-8?B?Z0ZlbW1vZkkwSTEzd3d4dlJ5Q21RaUd2VlBFdFp5ZTBpSkpWVkVjSExyMFBH?=
 =?utf-8?B?d0VLMmpsQlBwcDlGL2ZKbjdUR3NXem1TTnA0bDVNZCsrSmhoVlBoVklRbDR5?=
 =?utf-8?B?NFEyeXhmYXZTZEVsWG51NlBjM3U4VzFWVnBEK0hBVGVhcllvSVRydGJRVlI5?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9af32b-d6d6-424c-fb03-08ddd61e629d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 01:53:35.0263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/0+5nA5DsvF2qKnGIVyfDYZ3w9glJa4cmjZqFfUrOvID0DYcpEqSHKDO4ej/+NLKL61WM0ekiQPeJJRpk5i2Gtsd0OjxerbWCd09RPdyLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8390
X-OriginatorOrg: intel.com

Hi Babu,

On 8/5/25 4:30 PM, Babu Moger wrote:
> "io_alloc" feature enables direct insertion of data from I/O devices into
> the cache. By directly caching data from I/O devices rather than first
> storing the I/O data in DRAM, it reduces the demands on DRAM bandwidth and
> reduces latency to the processor consuming the I/O data.
> 
> When CDP is enabled, io_alloc routes traffic using the highest CLOSID
> associated with the L3CODE resource. To ensure consistent cache allocation
> behavior, the L3CODE and L3DATA resources must remain synchronized.
> rdtgroup_init_cat() function takes both L3CODE and L3DATA into account when
> initializing CBMs for new groups.  The io_alloc feature must maintain the
> same behavior, ensuring that the Cache Bit Masks (CBMs) for both L3CODE and
> L3DATA are updated together.

Please rework this copy&pasted text also and make specific to what this
patch actually does.

> Enable users to modify io_alloc CBMs (Capacity Bit Masks) via the
> io_alloc_cbm resctrl file when io_alloc is enabled.

Here the changelog can provide overview of what is done by this patch
when a user provides a new CBM. This can include that a CBM provided
to CDP enabled resource will copy the CBM to the CDP peer.

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---



> ---
>  Documentation/filesystems/resctrl.rst |  8 +++
>  fs/resctrl/ctrlmondata.c              | 97 +++++++++++++++++++++++++++
>  fs/resctrl/internal.h                 |  3 +
>  fs/resctrl/rdtgroup.c                 |  3 +-
>  4 files changed, 110 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index 3002f7fdb2fe..d955e8525af0 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -187,6 +187,14 @@ related to allocation:
>  			# cat /sys/fs/resctrl/info/L3/io_alloc_cbm
>  			0=ffff;1=ffff
>  
> +		CBMs can be configured by writing to the interface.
> +
> +		Example::
> +
> +			# echo 1=FF > /sys/fs/resctrl/info/L3/io_alloc_cbm

It may be useful to demonstrate syntax when more than one CBM is modified.

> +			# cat /sys/fs/resctrl/info/L3/io_alloc_cbm
> +			0=ffff;1=00ff
> +
>  		When CDP is enabled "io_alloc_cbm" associated with the DATA and CODE
>  		resources may reflect the same values. For example, values read from and
>  		written to /sys/fs/resctrl/info/L3DATA/io_alloc_cbm may be reflected by
> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
> index 641094aac322..1f69117f96f8 100644
> --- a/fs/resctrl/ctrlmondata.c
> +++ b/fs/resctrl/ctrlmondata.c
> @@ -858,3 +858,100 @@ int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of, struct seq_file *seq,
>  	cpus_read_unlock();
>  	return ret;
>  }
> +
> +static int resctrl_io_alloc_parse_line(char *line,  struct rdt_resource *r,
> +				       struct resctrl_schema *s, u32 closid)
> +{
> +	enum resctrl_conf_type peer_type;
> +	struct resctrl_schema *peer_s;
> +	struct rdt_parse_data data;
> +	struct rdt_ctrl_domain *d;
> +	char *dom = NULL, *id;
> +	unsigned long dom_id;
> +
> +next:
> +	if (!line || line[0] == '\0')
> +		return 0;
> +
> +	dom = strsep(&line, ";");
> +	id = strsep(&dom, "=");
> +	if (!dom || kstrtoul(id, 10, &dom_id)) {
> +		rdt_last_cmd_puts("Missing '=' or non-numeric domain\n");
> +		return -EINVAL;
> +	}
> +
> +	dom = strim(dom);
> +	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
> +		if (d->hdr.id == dom_id) {
> +			data.buf = dom;
> +			data.mode = RDT_MODE_SHAREABLE;
> +			data.closid = closid;
> +			if (parse_cbm(&data, s, d))
> +				return -EINVAL;
> +			/*
> +			 * When CDP is enabled, update the schema for both CDP_DATA
> +			 * and CDP_CODE.
> +			 */
> +			if (resctrl_arch_get_cdp_enabled(r->rid)) {
> +				peer_type = resctrl_peer_type(s->conf_type);
> +				peer_s = resctrl_get_schema(peer_type);
> +				if (parse_cbm(&data, peer_s, d))
> +					return -EINVAL;

CBM is still parsed twice. As I mentioned in v7 the parsing only need to be done
once and then the resulting CBM can be copied to CDP peer.
https://lore.kernel.org/lkml/82045638-2b26-4682-9374-1c3e400a580a@intel.com/

> +			}
> +			goto next;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +ssize_t resctrl_io_alloc_cbm_write(struct kernfs_open_file *of, char *buf,
> +				   size_t nbytes, loff_t off)
> +{
> +	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
> +	struct rdt_resource *r = s->res;
> +	u32 io_alloc_closid;
> +	int ret = 0;
> +
> +	/* Valid input requires a trailing newline */
> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> +		return -EINVAL;
> +
> +	buf[nbytes - 1] = '\0';
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdt_last_cmd_clear();
> +
> +	if (!r->cache.io_alloc_capable) {
> +		rdt_last_cmd_printf("io_alloc is not supported on %s\n", s->name);
> +		ret = -ENODEV;
> +		goto out_unlock;
> +	}
> +
> +	rdt_last_cmd_clear();

Unnecessary rdt_last_cmd_clear().

> +	rdt_staged_configs_clear();

Placement of this can be improved by putting it closer to the code that
populates the staged configs. That is, just before resctrl_io_alloc_parse_line().
The flow is not symmetrical in that the out_unlock exit code always
clears the buffer whether it was used or not. I think it will be easier to
understand if the out_unlock *only* unlocks the locks and there is a new
goto label, for example, "out_clear_configs" that calls rdt_staged_configs_clear()
and is used after resctrl_io_alloc_parse_line().

> +
> +	if (!resctrl_arch_get_io_alloc_enabled(r)) {
> +		rdt_last_cmd_printf("io_alloc is not enabled on %s\n", s->name);
> +		ret = -ENODEV;
> +		goto out_unlock;
> +	}
> +
> +	io_alloc_closid = resctrl_io_alloc_closid(r);
> +
> +	ret = resctrl_io_alloc_parse_line(buf, r, s, io_alloc_closid);
> +
> +	if (ret)
> +		goto out_unlock;
> +
> +	ret = resctrl_arch_update_domains(r, io_alloc_closid);
> +
> +out_unlock:
> +	rdt_staged_configs_clear();
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +
> +	return ret ?: nbytes;
> +}

Reinette

