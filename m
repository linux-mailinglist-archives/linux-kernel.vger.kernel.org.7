Return-Path: <linux-kernel+bounces-856769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AF7BE5066
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDFF5407DF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3C3223DDD;
	Thu, 16 Oct 2025 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DCPPFme4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B91223DC1
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760638680; cv=fail; b=OtAPAUCSST4k2jSR42XTQxE+bw68WA6AoqC4DAMTzuooMlTM9qpkqdo5DUQJ1DdMOIPG40ycadMdOnmqwtJ3zH1Ucyfad+omJdRHWAZYA/lLesL33FKqoKYnzfhfKmiqCLjIpvMnc9/Rc2/UjuHpwf8BHT5fOcelzW/aeD/usC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760638680; c=relaxed/simple;
	bh=i/AU0qBf9wXjVynnlpG9mhtqZsrpDwlFlkjqZhBz5/s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I2Lngmb5VI73+XfH2rCqmLmim/IlcC0ZWc5pHZbZHISAOv081RHHfkgmzTh/qSiA0KLL6W4AHKoX7ZeoLpOAUCcnotBuKNQeVch3QcxR4ccDdqUMWJ6hhz7hPG1kyQUjo4fWY993XZXPtmeHZQIr6FsDoxW3rc+Y8/uSXcgSec8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DCPPFme4; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760638678; x=1792174678;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i/AU0qBf9wXjVynnlpG9mhtqZsrpDwlFlkjqZhBz5/s=;
  b=DCPPFme4P5dW5vJxjZN4Hh9FxfjpPZZNsLSak2FWEUt/qzg47qf63271
   3Z9VAVNL1Nb2mw+V79J0gkg2nlgVlHy/41nhEsA2U7WA0DFUYSgTvTQyV
   AGnOQyrgXCwTFH1YoJHEsJCDyxJ1epS9mLf1TR9wkeviZuShz2Uokvp/p
   g2QxtJ2Gsqw970O5j8PFObBC6hUEa9dOT7ztnbWTDbjcGJDRpP/sGXKvj
   0mboYg39Jcfuw9Gh0Z8u4e1SXdhL/zAq4NawRamdTHy3+3mlUfgfR2UQo
   ig4WL9dWAUYOa+Sb1UJn+jL1B30oHsjAqgYxaZeNK6mq8ffHXH4mstZIo
   Q==;
X-CSE-ConnectionGUID: W0O/+3DeS+macVbnYhatOQ==
X-CSE-MsgGUID: 1GQEGc10QkWNstZLE2EWIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="73959199"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="73959199"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 11:17:58 -0700
X-CSE-ConnectionGUID: 7TGFNlqaRDiyKRS9KfacLw==
X-CSE-MsgGUID: HgONTfQXRry9bZj6X3UNDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="219681268"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 11:17:58 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 11:17:57 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 11:17:57 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.26)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 11:17:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgIfYOu5FDXlBq0AN0FTBId0p6UoJ79/g1eFvAd47Xxv+T1I3Pac+QJ3w9izr4F2LtGjpLTtwWFMQfNlB/m3/dc9z/TdW1q305FQW8rbYMSMBEk1ZVpnMTNVYqv/k9y4sLhnzb72uXtB91rP3JKVoeLA1VdfN5ekcZQe+qSI0jMEO8LHJTfhdbUegh2p8Vy/ljgLkyfiaJletdIuOH8/Ca1JbD8wnjBIkYfXazlxDEyXV8HFRWy/PF96Vdv6IPKwF8xQ71MXzg7pfNaYc8U9QoYVZE5yhkaYWdl2nqYybqVnnYql1a2pqDEcH9lMRd+8OBP6F+bG5Hdr4SSj4qBPuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjRLhao0AVksDTcB1GPOFlUJRZpvE9r8xao1RwPMCQU=;
 b=nOCZ7cZriR+qfPV3ElAmwOgWa3DJWtP/tA54wvrOrVzmULwHGJSrkIUrt7NAk/v7MQK6pdMYYSKtI7v6cihtkoi9RsyQtVHAJcxdKshwhq1Z5uwg0tnkAzls/A5SsgW9VbT00hp4PAwt3nwk2Z3DG2C6tg0gBhi1p8Jlw4v3ts4PLkjRixTuOdI9mP/GErIusbA0PVAsELvIMGJaw5DWfali/vS5ImDpUBcKepYnwUHdZOng8KK3Z9cHu/WYngGyQtVlQYPMEAOHN8rBYzSV/l9K82nOCXIirmIRsaJFWKeRqRqLYQqY5wseo6s3y05Ui9NZUnw9hz+PqPU4uEAg/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB8810.namprd11.prod.outlook.com (2603:10b6:806:468::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 18:17:54 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9228.009; Thu, 16 Oct 2025
 18:17:54 +0000
Message-ID: <47b9871c-6c08-4bac-bf05-2e6f431beb95@intel.com>
Date: Thu, 16 Oct 2025 11:17:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86,fs/resctrl: Fix NULL pointer dereference when
 events force disabled while in mbm_event mode
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>, <gautham.shenoy@amd.com>
References: <a62e6ac063d0693475615edd213d5be5e55443e6.1760560934.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <a62e6ac063d0693475615edd213d5be5e55443e6.1760560934.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:303:b7::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB8810:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e06eb52-0046-497d-1c58-08de0ce052f9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHMxeCtNVEpSV01PZENqRFRVRDFwR3ZmSlRoSUo4amlsMzVEL1poN3pyV2xa?=
 =?utf-8?B?eXgzWTdUamo5QjB3VE5XQ3M5M2I5M3c0Q3RaL2g4TDFLSlhrTVBBYXNMUFoy?=
 =?utf-8?B?RElzWERoS2hCbmlkMllENVpDSUh1VEdwR3FJbk4rV1ZzMkY1K1FEeUxNTS9Y?=
 =?utf-8?B?VUpscThtZ1RXY1dNOU42YjZRSHF2WGtZMTEyeXJCQWVCVzFtZFRPTmFkY3E5?=
 =?utf-8?B?SHFLNEh2aXUvT2FVT1NEa0VLVm91azh4YU5UTXZIWnlzeTFTYzdtd01rQ2F1?=
 =?utf-8?B?MnQxYUJSUG9oblZnV3BiWEM2QjYwKzNIZE9NTEM3d3J0WGpkRTJiUDZPTE4y?=
 =?utf-8?B?MzBYdVJjVFhmZ3pZaW5zNG9maG1mTGlXTTUrczFLajBLL1hydXdhU0F3OHZM?=
 =?utf-8?B?aW81MFFQSmRCdmQvQzlSV0c0aHR4V0JsZVArejdFTEFFYUZzKytXYytnN3JT?=
 =?utf-8?B?UkE5L3Q1NFA4aTltalhCa2t5NWZKNEJYVlowNEIzSlJ5TjZoRkd6akhNcWY2?=
 =?utf-8?B?VUFQRHdNVEIvYTZHWEpxbDZJUS9yMnZNeWpQRmpabmtSVlNPdWNZeTA3SE9i?=
 =?utf-8?B?bWNGeFBSYlYyeGwzbmpsTUhnRHk3SkF5UXB3enhDeVNSUXRFMTljNzZUYmkw?=
 =?utf-8?B?U1BxeFJCcjVLRXFzU3pJNEdTa01Jazk1UVYwa1doOVNEWnZuR0FZc3BNMTJy?=
 =?utf-8?B?Vjl3S0dUMmhDNjVxb0tQSFRlb2dBMnA5UC9NTDZJNXhtZkNzTkdvRDMrR1dr?=
 =?utf-8?B?TFFLSFZGckEreU1HV0V4Zzdxa1JEUFJJSWxMclozV2RtZ1Q4Slo0alVNMmlp?=
 =?utf-8?B?T0ZjRVc4UXI0S2VFTmRYWS9pRytORVpKRVVnY2VKOUdIK0MrWXZHNFM0UGxK?=
 =?utf-8?B?QVhCdEg4clk0amVvOHp5M2VGNlY1QzZ3L1h0dFNBNExBM01mazdKRG9Zekh5?=
 =?utf-8?B?QTd2Y3h5RXBJb0ZhU2VCaEZQOXRHcG1Wc1BsVXpnLzNRRHVGa3hPb3VLVXVq?=
 =?utf-8?B?ajJlaG8rMytpQ1hCTUUyeVBVUFNvRkVtcFhITlRWZzRWdGRhYjlwSU1qZXJn?=
 =?utf-8?B?c0FrNUJBN08xUE8yWDJRbllCai96TzN1M2RDRjlzdk8rcUxhbHJHdm5OaWhJ?=
 =?utf-8?B?SjJNVnR5T0NIckNKc245ejhrczRLU3NvbVlDcVVnSGJZNk5lRnBZMWxNYVRh?=
 =?utf-8?B?bGtySHZxUzhoYlRxTjZtNGZBZGRqTFB5WFhFdy8xd2k1dGlwQ21XK2RJWVYy?=
 =?utf-8?B?S0t6dElYT3RreXJkZU5TamJON1JzSis1dkdCcmdmS2s2VHBGQ3lWT3pQaVdO?=
 =?utf-8?B?M2p4RDdyQ1o5S2R2ZG5tMXFhUTcxdXY4b3RCSVpqUjdOZ0lQNG12eVo1U3dQ?=
 =?utf-8?B?VE1qdlNhamJSTUttQVJ2ZGFXbFZnbmNFQUFmWHhMbXA4Wmk0RGlwZ3NaelRW?=
 =?utf-8?B?VTNMT1ZmbWtUTTV6cWVaKzFvWEJuZ3pnZ2c2VWdhMDNHQklBbGM0dkI1cWc2?=
 =?utf-8?B?QWIwc0R0Y01oWEQvYmNqTTE5OGNjWDEyZlFJTVBFMWM1dDdhQzIydEQ2LzZ5?=
 =?utf-8?B?QUVYR1dRUE1MZSthdVQreUFlUWZVeXVnREo2WWVaZzlwOExPaGpFTG1rZTBp?=
 =?utf-8?B?UlF4L1dRTDh1ajJZVlpaellhdVF3N1Q1bEpJRVIvOTFlYW1telFoZ25rOURS?=
 =?utf-8?B?VlB4YldDN0s4MGErQ3d2ZHZJcTJNL0wyYzBRNmFvMHpsa3ZTc0Z1UXRpVUp0?=
 =?utf-8?B?UDRDWE8zR2doZTNmTUhERnlvVFhMS09relNvUVNMWXRoZlJKTnBmWUE2ZkJI?=
 =?utf-8?B?bTdvR2FycTNiVTFWUkV2b3Y2WkxmbWw3QldPb1lQR3ZOYUREamZodnovN0dq?=
 =?utf-8?B?RHhoeEtsdi9aT3VEUmh4Y25JT01hazcvVGY1TGNSd2hFaHFZaDhQY0hrbG9U?=
 =?utf-8?Q?EEbYCtDoz2KsEhaMU/Yc0v478ttUo07N?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEdPRUtIVmlLTEZIaDRrK09ZQmdHaThtK3Z4Y3EyWnJqaVFoSmoyMmFsQnJJ?=
 =?utf-8?B?Z2ZQVmtscXp1U2x2TmlidmNXc3lxMWZtNm5sbXUvYzdSSnZ5OEFlM29vNUh3?=
 =?utf-8?B?dk10eitnV2pYTHFvTVZPQWZNdGNERnB1QlN1RS9IZE9jVUtqSGJBNXdqRUM4?=
 =?utf-8?B?SmxoUjZQSk1MbU5qY0N3MEhremVFeXJOblplL2plZW82VVppb0VEY2dDc091?=
 =?utf-8?B?RGl5alJTQURmbkZkbUFiaXFtMmJORG9Cd2NXVTBEa292QUx5TkxHanRYL05l?=
 =?utf-8?B?dkFEWFBjVnh6OVNsbkMxSlp4YVU4TTh1aG1pQmhwd1FPVVROem9CNnhXWFpp?=
 =?utf-8?B?ZUdRTnJ4VThIbU5KZkZDSGNtTXhKRFBCYW9BMklicWtudzdpbk9oZ3hPRlhD?=
 =?utf-8?B?Z21GWTBPMWpObGFIUkgwUE1PZERZVFhXVmZobnI3TGRhQWtuN1p3bVl6bUVv?=
 =?utf-8?B?eEZVN1RVNHI0a2NoVXlsQ0xrd2xYNzg3RTd3bnNXQUUvTDZkaWxkQVpoWkNw?=
 =?utf-8?B?WWNvMXcvVUFsa051ZXdNQ3laM0pObWUvbEJad2ZVeTAxWUk5dGNYbWdLaGIz?=
 =?utf-8?B?NElNRmlMMUJXTXRCNG55TG9ZNFFOcmtLR1c1Wkcwd0JEa2tNbGMwdGZBNUhi?=
 =?utf-8?B?cFhPWnFBYmtzU0gzbTdzR21BZ0d6WTkzODc3eGxBSGFUZTNHdWM3R2piTk03?=
 =?utf-8?B?SDdOeVhyNEEwQWM5T0JOdjBXK2R3UGpkZUlyT3F6d1ZIbitSSGpqTUlnQndH?=
 =?utf-8?B?VTRFekVDRDRzUy8wTXFaT1Y4blBBTzlrdFRteWFpVjlBbUI1azYvSGo0K3RY?=
 =?utf-8?B?bEdQelpQVDdtTmF6SjJFV2RCb3poRncwekVrcGVkcWkvL1BQeEJEdnYremhi?=
 =?utf-8?B?TndYc0ZkVmEwVlNNdXNJY0FMR2NGVUd4M1BEVDJVVzFkZHJZTllkRnQ3dkQv?=
 =?utf-8?B?Z3RUK0YxM0R6eGNVMERqSjR0eGh1VWNSeUlMZUowSXBWL0tBS1FhamZIQ2Zt?=
 =?utf-8?B?alBVeFgrNVJQREkwZ0NHMUFvbmswK1VBRTYyRUFkbTJqUk1YbGJmamJ1TjFR?=
 =?utf-8?B?MkU2bnRzV3FKMEJYcXlsa3VMVFU3R1Z2cGJJUmZiSFJKSXViaVlxRHpxQmh6?=
 =?utf-8?B?YmRnL2JCVmJ4dWpkYjhZZkRjR0I1VnBGVkJubmt1WGhIc29BWEplWDhTalVO?=
 =?utf-8?B?NURZSzRGQklmTDlhMHpKbnFhNi9sRGNsVFdTMTJ2ZmEzWHlqTXNNZmd0MWlG?=
 =?utf-8?B?SEFmK2s1R2JvTkJjbnZLbnc2M3lJMlhLVlFLcjNJNEt0R0lkbGM5aHdNbUZD?=
 =?utf-8?B?Q3BxMnRpVTFhOXpxeXJodFVwc0VEOG1vbnRGVnpCL3U2akp1QUJtelV4WTk4?=
 =?utf-8?B?YzF2aHBQTk1iRExKL2ZHSi8wZjVYajE0ajVBMFNNU3BFUnBMTkppbEk2Tlp1?=
 =?utf-8?B?Y051aGZlRVc4dm5NM20zNDB1R1Y2SGNYdlp6Rnk1QmxuUWRoSkROR2VNVjc2?=
 =?utf-8?B?VG9uamtvSDVHNG5ORGdwYzR3Q0ZpZitPQ3RFU2kwcjJ6MjVCVC9RS0dPTUU3?=
 =?utf-8?B?OTJ5MjJLQVZzRHI2Qkx5UkNYcHN5VnhnRUR4TldSeDQwSG5EcWFGQU1hTG51?=
 =?utf-8?B?UFNqTm5qUm1pelUvbzhvU2hNNzFsWXJEZE9BNDJvV2srRCtJMk1pQ1VUS1JC?=
 =?utf-8?B?bDl1VkFIaWVBQ29YZlBQbEVXbkpBdlQwSEdQQjA0WHAwSTdQeWZYSVJDY2cx?=
 =?utf-8?B?RFhocFN5dk5XUGtGb0FVUHVIaXVJUVEvajE4S242bm96SjRrR3BnT3hpUnVs?=
 =?utf-8?B?eXFHWTBpWVdtZ1QvbHVGcy9JYkpSRkxCWnBWeGUyL29DSTlpbVRtZzQzNGR2?=
 =?utf-8?B?eER1R2tmWXdSekFHQ3J1MGM2QWVVOW5NREFpdUk1Qlh1Vlgva0hpaHc4M3gz?=
 =?utf-8?B?bnMvMVJUV2JXZjBncHQvUDluR2Y2dklJTTZ2TjlrMzlIaXhxdWZzc1NLTTlk?=
 =?utf-8?B?T0xKUjZUNWc3SkhLcWMvWjRjb081S2M3U0owK1pUclphNEVxNysyZFRxRDYx?=
 =?utf-8?B?N0tvQVVtRjR0NFU3SlNiTnB2YkZxN3o1a0J3Z05MU2p6SGUwa0RUMFFZV3JT?=
 =?utf-8?B?WCtsN2wvcHR3SmxUN3I4MlVTNUwyZkgzcnBkU2V0OXZXeWhaUkFPMkpVbytj?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e06eb52-0046-497d-1c58-08de0ce052f9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 18:17:53.8600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A88rGbyBEAA08y903SmKVNkKkl8JNjs5W36lNhbxGVMuTbAiKK7ALzdiXRcWGHwSTtHMP+MLR7nkUz2/RdxXSUl6LbR8VabGYNwzhuR7Kig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8810
X-OriginatorOrg: intel.com

Hi Babu,

On 10/16/25 6:34 AM, Babu Moger wrote:
> The following NULL pointer dereference is encountered on mount of resctrl
> fs after booting a system that support assignable counters with the
> "rdt=!mbmtotal,!mbmlocal" kernel parameters:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000008
> RIP: 0010:mbm_cntr_get
> Call Trace:
> rdtgroup_assign_cntr_event
> rdtgroup_assign_cntrs
> rdt_get_tree
> 
> Specifying the kernel parameter "rdt=!mbmtotal,!mbmlocal" effectively
> disables the legacy X86_FEATURE_CQM_MBM_TOTAL and X86_FEATURE_CQM_MBM_LOCAL
> features and thus the MBM events they represent. This results in the
> per-domain MBM event related data structures to not be allocated during
> resctrl early initialization.
> 
> resctrl fs initialization follows by implicitly enabling both MBM total and
> local events on a system that supports assignable counters (mbm_event
> mode), but this enabling occurs after the per-domain data structures have
> been created.
> 
> During runtime resctrl fs assumes that an enabled event can access all its
> state.  This results in NULL pointer dereference when resctrl attempts to
> access the un-allocated structures of an enabled event.
> 
> Remove the late MBM event enabling from resctrl fs.
> 
> This leaves a problem where the X86_FEATURE_CQM_MBM_TOTAL and
> X86_FEATURE_CQM_MBM_LOCAL features may be disabled while assignable
> counter (mbm_event) mode is enabled without any events to support.
> Switching between the "default" and "mbm_event" mode without any events
> is not practical.
> 
> Create a dependency between the
> X86_FEATURE_CQM_MBM_TOTAL/X86_FEATURE_CQM_MBM_LOCAL and X86_FEATURE_ABMC
> (assignable counter) hardware features. An x86 system that supports
> assignable counters now requires support of X86_FEATURE_CQM_MBM_TOTAL or
> X86_FEATURE_CQM_MBM_LOCAL.  This ensures all needed MBM related data
> structures are created before use and that it is only possible to switch
> between "default" and "mbm_event" mode when the same events are available
> in both modes. This dependency does not exist in the hardware but this
> usage of these feature settings work for known systems.
> 
> Fixes: 13390861b426e ("x86,fs/resctrl: Detect Assignable Bandwidth Monitoring feature details")
> Co-developed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Thank you very much.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


