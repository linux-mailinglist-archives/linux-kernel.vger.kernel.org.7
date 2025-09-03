Return-Path: <linux-kernel+bounces-797613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8AAB4127D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C8A3BC574
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F1A3594B;
	Wed,  3 Sep 2025 02:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KQe6cXoB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00931FBEAC;
	Wed,  3 Sep 2025 02:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756867559; cv=fail; b=rjE78UDXgLXMbargPpyLLv6xngwsmCSjaUoqLUVQpGm2sngPuttBZu2N/bPINIKSMoI6UE3yxiHHDT45aj9yt/PWlAcDPA2H9NlrCCCF91MFtOmaz92cI6mYCHQKsGo7LT3svfObjcPNmJo6MU6x0fesAdJYdwvtLKGoXGQ6tws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756867559; c=relaxed/simple;
	bh=bavyTglhuibOsiaG+YAWfLo/Mm16u/SnhvL6b6NkUi0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F/vT8EKGKUhFSs5NbSNniggVOdGF3d+siRJXYRunRgnYkrilnrEM2WSyVaHLUIpvW3rZpdGbbWBz4b1ShDPzgP9XhzFdU5g7JHkOxIOpD5Xanw1O9xNbUBdyo08qnq3JTzhBx/DQ3ZvGU7MFjPaE+TcqwpKmFUR6OkDNpI16Uhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KQe6cXoB; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756867558; x=1788403558;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bavyTglhuibOsiaG+YAWfLo/Mm16u/SnhvL6b6NkUi0=;
  b=KQe6cXoBKD7AOFA5U5lql1RfSZdz8QK9M0Oc5HGNWv+m7XbZPQQQG9nv
   LTYf9hpwEaxivYdl4cCRn8m0rtWuCwagldhnaMABMlQgUfh8ULb9gXhlU
   OOQHz1ewHM2nlKz+PcMy6Y5dZuNPkNTFKWsUFcI7q3H8jguP0q8SIYp7E
   v6LhYLCwaofPG2he8lZiY4OEAf1suHQDSR1U+bn5mP4+Qc3UeYV8dngFi
   /JS+Ua+Wlu4Z3L6e9YESO6NwsRvxxMkd2siGRZ3AX29Chnx5OrDygzQBa
   X/qDvw1XfQ3/KYufAqMtf2KugGlrls0PzgHFzuo2jQqPjw9ZiLY9d52Dn
   w==;
X-CSE-ConnectionGUID: i+nzSsw/QE+Sf7dhQLR4Cg==
X-CSE-MsgGUID: nW+s9Nk1T4OaqRZ2CMMCqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63002794"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63002794"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:45:57 -0700
X-CSE-ConnectionGUID: YNUYo10vQxyNA+K5etTaog==
X-CSE-MsgGUID: id5rZrbsQie/4Fq60AVerg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="195097899"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:45:56 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:45:56 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 19:45:55 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.59)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:45:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nY7iEbiyggsu0p/weEOJDYpU/wisuz8J7Go8URjwpXT4OXZixzbJp1T0Hhx622id4nqrpVvdvApHnJZEu5Uhzs+YG1U+SRBN4jNsCMPImiLLTkV8M2r3pntx5cdPPVsnUtzmtNtTsPHuWAphhaQZgGjGU737lo7tNqvYmVJU7MrP12T22pirFmE7W49JSRFOuF38LurqO7CyN/d+agnoH5cJOuM3VuKx+QRxP8AkBLx5nDDxUWb4WJydz4pPknFeB3K1bZltfIQEYfx3zPyLfdrIEDQCxV5ckq06ulbFkxErMcExlvJLlYdZhsm7SP09uaUjzvWkpg9WsSLwt3B98w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjyJfQesfx4RzvGWIT/CjveBUKm47ce+V7f4E5j9XN0=;
 b=Duwh/YvX/05QYm+QSUXpp0AGd9GqYD2Bx6NO8UjPE7fospeqD+JCE3eTz65axh7X6s84s+uDsQXCSTHWCxs2q+BnPqn92gPq0kXMCXjz2J0Srur/lJ9NsiKGHlpMEt0CIti49AQyguKx6SgdbhGy3JMBWpSsZBLgr87Le1vlfVZQStrK0nkBYL6KZQOxZZp7d9aD+oFdXstMw+JckITBG5yQrbQMsiU6CZB/pFsJmU5GNCuczd6pGZMPvRXSDSGhMj2Js+9XKkLyR4OUuUsT1Vt384OvDg503x3udpbZtD4YwVI+S1IwafzzzGzaKiBq0OQ06RZOcwIMesTKHoHP+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB5129.namprd11.prod.outlook.com (2603:10b6:806:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 02:45:52 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 02:45:51 +0000
Message-ID: <b26f303b-3acd-44c1-a53e-15a9db6dcf1c@intel.com>
Date: Tue, 2 Sep 2025 19:45:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 27/33] fs/resctrl: Auto assign counters on mkdir and
 clean up on group removal
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
 <1ee0f8674f0ab48bdbc3e05c11b7df30d6fa53fe.1755224735.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <1ee0f8674f0ab48bdbc3e05c11b7df30d6fa53fe.1755224735.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0372.namprd04.prod.outlook.com
 (2603:10b6:303:81::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB5129:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f58018c-f668-462d-30ea-08ddea93ff10
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFRDb2Ywd3k1eEg1aWhVMFJlbStqN3dSMDlMTFpiVHNUNGFZTzRhTDM4MzVX?=
 =?utf-8?B?M1d2TVNLdEMrb0FaUHZOMTR0UFJ4TDdNS2V6Ny9XZFdzc1E3TjczRi8vYmtS?=
 =?utf-8?B?L1BMV0RCSzIvZkE5eDRUUG9ranF3cDhoNERzNHpkamtSalJnUlh3NkNOMGpk?=
 =?utf-8?B?QVBiV2lWSHdhd3o0SUZ0STZEb2FNeGw0NVZReUtPTkFaU0pNK3VkMDVJVzhP?=
 =?utf-8?B?a2V0VUMzM2ZKQUQ4WFcyMGcyUkxhRlVEN252d2o2OElVN1JpU0MzZFpib1VW?=
 =?utf-8?B?eFpRT3U1RGEzZG9JSjAzV0VSaWtGbm9qdzlmVE9SMnhuRXZJUDFGZmJmeGI5?=
 =?utf-8?B?REE3azlSdmNhMy9jaFZ4S0w3VjFQaU01dTlteHhIcjdmUDlmT25BYUU4c3Nz?=
 =?utf-8?B?d3A3VUNkZG1HN2VubGhwZlo1cnFHanVMTXZYTHp1QkVQYy83UVlaL0NrcU5C?=
 =?utf-8?B?N0ZlV1JQaDBiWXQzL0RRaTc5aGo4bTN2NHF4OFkydkJZKy96c0thT2pKcmdU?=
 =?utf-8?B?UW1teTBCT2U5M2pTYkJtbks2QnF3eGlDNGZlL2loNG5tRXBVVGtDMVBpb2M2?=
 =?utf-8?B?VWc3MkVGTGVnQVRERjliZkI1WG1DaGs1QU53N1lFOUg1NnNSbmhsQlh0Qy9S?=
 =?utf-8?B?VU1WTTR0V21uU1MrTTg4Y0JaTHF1QTZqbGw1bmh2YjRkV05abkIyQjlJTTV0?=
 =?utf-8?B?MFE5ZU1QT200aU9zcTlibjNpd0xTell4Mkc2MHZ0ZzdjV3pTK2k1bEUvT3lP?=
 =?utf-8?B?WE9ZNkFGMFhKWjJaY2lTMjJGNFIvd0lvbVVJSDVpc1N0TmhwL0NZWnJ0L2t3?=
 =?utf-8?B?dDR6Q1ZMbG41bWhlaHlud3NYV1U3YW85OGR4eldJVFBrekdpRVBiL0pENWRo?=
 =?utf-8?B?SU8wR1BtV3JlbExnMlhxSFpWbDhabER3eDFqU2RaY0VmdXZpbGYvMjZxS1Vp?=
 =?utf-8?B?U1NScjM0SlFsamh3U3NUaDZ0YTZ2Y3FJdXA4aXJDd09YN2VGMk1KeEREcTc4?=
 =?utf-8?B?UE9zUjJtNHJPcHRCL1QweWRnRndBekhmNmJLa3JPejA5cW56UnppRWdoenBU?=
 =?utf-8?B?VFo0M3ZhQldMTmZDUU9iQjh5VkpBMGNBaExWMHZ5NjBPay9wY29BZ1YwS0xt?=
 =?utf-8?B?aHJnK0tROTdzL25pditSOVJwSFgxekhPcVd1T1NzYnRhQVp2aGZrRXpoMjNT?=
 =?utf-8?B?bXNmSUhubVZIb3R2TGZKVjZER0V5S0U5Q1h4NXZJcG16MVhQRjBWclp0Um1R?=
 =?utf-8?B?c25IOHoySVVQdnJXblFQRklqTjZjcFFuYytkblcxdWcvZHc2WThES2VDVThB?=
 =?utf-8?B?OWN0LzBOYWkrTWEvNDgrdUMyazhVRTZCc3VCV1hqU0FsRTZOdUhVejU3bTU5?=
 =?utf-8?B?SHVuSUFtZ1YrK3VHd3pNcmlMbW4raE1HcSt1eEJDbDFqazdSS2xQVzMvYWor?=
 =?utf-8?B?L0F2aWh5N3lPVUEvWlQ2MzRsT0xab2xpMmMyMVRqRE1jeXYrTE9QSVRXUWt5?=
 =?utf-8?B?UElIZ0RtM0hFRDI2S1Q5a3pRVmM0ZzdoL25qZnNHWm9mY3lYOUtmaERtbzRl?=
 =?utf-8?B?MFlxVG90Umc2aGJYYjZvK2s2dytTNndrTlRqR3ZvSExOUVBUUVRoTGRmc0tS?=
 =?utf-8?B?QVo5RStsanVqWllGMXN4bXcwUVNNdFE1ZG9KeDJxbEQrcGp3R3FGTDJ3eDEy?=
 =?utf-8?B?TFNxTjYxbXBRc0VDNnRGbk9KQ2NTQlIxbUl2b2dtZ25XOVB6aDFIUmt1S0hr?=
 =?utf-8?B?S1Yrb1cweGtrbVZFVFlPTlRrcEFGVjdOVkswemlvQ2MrV2YwTzYya2JyaE9m?=
 =?utf-8?B?bVJodWN1eXRoYlV6Skk2OURpSHVWakhxZnJ0ZTUyWXdJNEN4L1RMdnhHWkh3?=
 =?utf-8?B?OHlRakJLR2R0Q25jWW9RaXlXWmdzUFIzbWEzeGd0U25JL1EzWUpqWkViZ21a?=
 =?utf-8?Q?2RBhI330F2o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emZ1cFdkeS9ENlJiNTc0dWtDMVVzK3ZUZEZSbXVHOFp1TFF5WmloNk0wR0Fm?=
 =?utf-8?B?MjRxbm5QckZYRWlsMGJtTEowODRxSDMxRzJrMEliQ2QycHpCQVhHKzk3NXk1?=
 =?utf-8?B?NWFUTnhRNlRsd1R6SzVFM0hzZ1NHS21MQkpJTGRvbzhGbTM1alIyMGxSS3hL?=
 =?utf-8?B?MFk4YnNyMWFFUmcyL2RPUlVNT1o4R2d0dTB1Qkl0VFQ3Vi80RVZGblZ4RjM4?=
 =?utf-8?B?K29WUk43TDRoV1lhZFBJNVA0T3RDV1lRbU5FOTBReGZLSmVjM2lycit6ZU8v?=
 =?utf-8?B?WFFkNHY0OHNCNyt0bnhESUQ0ZmxneTBROUNnVHg4RjU3c2Z3RFlIdTNMajhB?=
 =?utf-8?B?Kzh6QVp4QUVGQU9uRGhzeFlnbzk4SzBybGs5UkE0RUMzVW50TUl6U2N1Si92?=
 =?utf-8?B?OWh1azZUcXRrdUNqa3NVT2hVU2taYlFYVzVaSG1aTFN2Y3hMaXVDQjhZSWJG?=
 =?utf-8?B?aGtSMTg2SXdWMmlwNEV3OUgzcjliR1ZLQVNRRERPalNyWFI3Rkh1T3h2cUhW?=
 =?utf-8?B?VlYwNW1KbGczY3E3em8xbDk3UDNLQUwzN3dDUUJiV0R2ZVZudGVxWThRVEpx?=
 =?utf-8?B?YjA1Qno5d1BENDdhR0FhL2UxTloyQlJqK2J6MEN5ZmVvVlVRaElrZHpvNHNJ?=
 =?utf-8?B?TUM3cFFxdWwxemh6MmNPa3hwN2UzOEtJU3BiOWZoVW5maWFmcG5wMTZ0Qmwv?=
 =?utf-8?B?OXhUR0FHT2svOWFFWXV5aXYxYmZPWFVDbUZyY0JiT2MwNkJxeTFJRnJ6THU2?=
 =?utf-8?B?eFJTMmlkbDhEN3Z6ZFpjK0tpSUxuYmlFN3NGbHU0eEd4WVJFUHdzYUE2S0Q2?=
 =?utf-8?B?TENzc3JEdW5pMDNhSFByK3QwejZubEZURlNvTjkzVWhHengxbmJYWGFDWXpR?=
 =?utf-8?B?V2JQbjQ1ZURGMTNhWVh1WEJSMzBjLzVRVml1NHlRTEdTV1hqZFBuakROQ0hw?=
 =?utf-8?B?MUZYWTFnQkxxUGNGalhQRHFtTGxLNzJzbDhNdnhCVHd1M05pQWRvZVdGcHhI?=
 =?utf-8?B?eXdhbHRQZUtQeFJRb1d6VmQ1SGJ6akY0SGp1VlJRd2FJQ2VvTUlWOVpJMVBR?=
 =?utf-8?B?ZDVmZ0U4MUVqT3h3TEVhQVU1TkU0OEkwOHQwSm5raDYwZ0U2WlVKeUh0ZDVM?=
 =?utf-8?B?c0RMZm1FQmxiWi9SdTU4Z3V6aWFsK0xYWVV1TktQQmRDOTFnU3pGSjRTSUJB?=
 =?utf-8?B?bEZyNUpRVW1pM3Rpd3l3dkRrajl3NHFkbUNrTUhSTkwyT1dWeUFXM0h0eTN3?=
 =?utf-8?B?RVhQeFFnTG5lM0dEZWxuTlpLZUZHN0dndU5HOWdzVEtNWisxb3RDV2tTQys4?=
 =?utf-8?B?bFFUYkkzK3M5ZWVrYkhSWHAwTFVGS1FDYXBEa3lPejhmaVdodklhdlB3TEVh?=
 =?utf-8?B?R2ZIMnYyWVF0MDVGN21WSG5oY3I2Z2lhU01DTmhnMzNHakxUTm1KbWFxTEhy?=
 =?utf-8?B?bU1LVlJkMDd5VkpzRVRXR05tSWVSQ0dLQTVnbEt4bmQrSVFsOFdCcXF3ZmZR?=
 =?utf-8?B?NHdWU21NdFBMN3VWeFkvYzhFMllQR3VWanBxTmw0R3JZWnNKd3hOd3pZRjgz?=
 =?utf-8?B?elkyQjErM2l3eUhRdFUrTy9zVTM4dXpKSXF0T3psb29teVM2WmZFMUtRYVgr?=
 =?utf-8?B?SUd6aGRuMVp4OWJjOW95ZTVockZ2TGFPM1RRbGQ1dzRCZms5SEVzdk5GTlRR?=
 =?utf-8?B?eEtZM1hySmQ2TnhuYUJZa0Jaa0NUdmZQZFRjR0pWa3VaQSt3ek1iZXJyLzFF?=
 =?utf-8?B?aFB5bC8vajdORzcrem55dkNzU0toTEtSbVdpUklQVmdvSXpvM00yancrUWk1?=
 =?utf-8?B?ZGMzUysrRCtrRzkrUzBrOFM0T2h2SXB2OHpGaDhXa2JPR0J3OVh2dHB4Tk4v?=
 =?utf-8?B?L3dkTVgwN2lBNzhIeXBZRVExcFJGandWTHc1ZTFTbTNOZk9rNmNIVUxFZWV2?=
 =?utf-8?B?VStPSjc3MkxZMEhSVEVSWUtYNis5K1M5alFEY2VtdHREbmFkd21wQjdwbGxN?=
 =?utf-8?B?cjUzMVJRUVpVczBUTERkbEtPSGFjM2lqZmxCcUxHNmpUcDlWNXlCWVdhVEdv?=
 =?utf-8?B?TjYrZFVES29mN1MvNDBSMmw4aStPNzhHMmUrNjZXOFZFR3VJRXBGTDBsTkNr?=
 =?utf-8?B?SFdSQnlaVlQwVUErZkxINUhuUks2YW1aamdNNXI2cDFFSjgyMlJzR2d3Mm05?=
 =?utf-8?B?NFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f58018c-f668-462d-30ea-08ddea93ff10
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 02:45:51.8208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRKKBHpIDyi0J38sqnaPgl79lyyPjPRmauIDXrJLygLlf4ugcLR/shZLj5B2cenS/5pGfD1N0icrxtDp4SOMXOpy5R/PemuX2c90h6kCJqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5129
X-OriginatorOrg: intel.com

Hi Babu,

On 8/14/25 7:25 PM, Babu Moger wrote:
> Resctrl provides a user-configurable option mbm_assign_on_mkdir that
> determines if a counter will automatically be assigned to an RMID, event
> pair when its associated monitor group is created via mkdir.
> 
> Enable mbm_assign_on_mkdir by default to automatically assign counters to
> the two default events (MBM total and MBM local) of a new monitoring group
> created via mkdir. This maintains backward compatibility with original
> resctrl support for these two events.
> 
> Unassign and free counters belonging to a monitoring group when the group
> is deleted.
> 
> Monitor group creation does not fail if a counter cannot be assigned to one
> or both events. There may be limited counters and users have the
> flexibility to modify counter assignments at a later time. Log the error
> message "Failed to allocate counter for <event> in domain <id>" in
> /sys/fs/resctrl/info/last_cmd_status when a new monitoring group is created
> but counter assignment failed.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

