Return-Path: <linux-kernel+bounces-767466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C33B254A8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A88AC7A48D3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479F723958A;
	Wed, 13 Aug 2025 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eirwJZ3P"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851D71373
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 20:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755118004; cv=fail; b=PJ8be25ivni9WjXFD1NyWFVu/qwEDMfbXHf+eQ0orqdoZXtki0CzExkhtLVK/kGe8ymJHEqx7hRgXLQiId7OI1vDt/WSYVJIO7HoB7wt1TmBQaTGf8a8hmtUw3Zg0oAEQkAOISgSOpksZzSQlzZJdCOcT33oUVZr3HUYUGhuZqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755118004; c=relaxed/simple;
	bh=agmHJpsmfQC7JWo+zHYt2bU9DNBqyIMotqW24GUCmRc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oDeu/mkMJ/8vklVHz0rh4+ZMPd73wtKXE4rq69vCpel+OfhaO2t47u3o13wvqjH0Qd4TDvrCQKSIwG67hbXOVd8HuhXus8C7BWGNvU6oO+7KWwJtaiK/1YC6cMyt3KRnF62qB5qO4vF+anIUp0yQSAzF7GG8txlUmrNyT3AGfQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eirwJZ3P; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755118002; x=1786654002;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=agmHJpsmfQC7JWo+zHYt2bU9DNBqyIMotqW24GUCmRc=;
  b=eirwJZ3P8NYgQ+WmswZmu6UDGhy9vtLr0InlK03RmLx4I+SrinGw95wL
   PZ5t5xwBnDU8sb9GHQilXfVRXwNFLvSkoekoiba6brewXebfMcclnmTGJ
   k1cD+CGag3m92+ysweGpWiZpY23AnXtwsinTIHPe0MUsNa4gQUvxid67U
   IWfeHknY3q6aVPyRBvFO9q0BNhq+M3eR222lokrlhCiL9/DUYqTWt75th
   w2CY2glRBhX0+CciQAsOL0f2PN17XqrlcLN58Pi46CL9g53I9oOWkX+5T
   K44Jj7eT6JmsibCnSTQZMcW8h+/9DPbByAVRIFHFsb2DEj6ytDDj5g9P9
   A==;
X-CSE-ConnectionGUID: sQuar5NuSfOe+9RnhwZcHg==
X-CSE-MsgGUID: B5+eKt3ETOaBuaeMdbxe5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="61273289"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="61273289"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 13:46:42 -0700
X-CSE-ConnectionGUID: bo6koE53Re6GEJZlWw+/ZA==
X-CSE-MsgGUID: FbuBVeWzQNW4MXjnBCfYgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="166217361"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 13:46:42 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 Aug 2025 13:46:41 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 13 Aug 2025 13:46:41 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.73) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 13 Aug 2025 13:46:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwwWqxEXdaxl0cQ2IY27rqehl4xdDskto7MdCxqFwAnfYmQ8divEMVP2eB5lK0zwUSgrSmSYDJ6m0IJu6sU+jHZ+Rz7rcLcZUNr4XJfKS2a+AZH+V1pMMjTqAwi2v4GVczBT/cNbssJP+R3PhOK1yIp64kDB7MqCRPRF+/SDjdbooiKiy/VTpITpJu06TnMgsY0CFJzxf0yQ5VrCV9ezC0kLRd4DV4nVUpESLM13OApRoBSQW8/8GVtQpi75sOT2YPfJa/ow+FnM4Exzisf7qE2oQtg351qeoYZ4P22TFgSfPALj4BbWJEclHraCFamynxcvYzZ079gdfmrn6xtvfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTR8Y+ApLhBmy2U8ol2CZ1E3Wj3dkRopwFWdcAau5vk=;
 b=urr6I21zfOijnyj4gg+G6UpDNYYSorCWPhUcXrRJ+A+VOoo7m8APCqz5f/fdeLBIjnG+ZgrUFuEKUFukmJrKoBxsuiS5I1FvrnsBmV9zOOkS8aGrVE9bN3WiWIT9yTsowmTUTYjOHGTkoSECr0t5KZCSqYI/HXfTZutbdCcfbAPy4LiwUCTznJCIORY4gmwPcgJFnCiEZuRrlxlQBJYUBABdRMK7xmQt1s8ZIJezh670Dbl52cVVTDaFxkAuNBUTAfkTy+00YaO7n3GCCxN+DXi/qhSe18fIQpCf5Pl7/n/yggxrJEMPuFihO/4mZBNpF30hDFCy9WmO5g+FE7loBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 MW4PR11MB7080.namprd11.prod.outlook.com (2603:10b6:303:21a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 13 Aug
 2025 20:46:36 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%5]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 20:46:35 +0000
Message-ID: <776e439c-60b6-474e-ac47-f33357c272de@intel.com>
Date: Wed, 13 Aug 2025 13:46:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] x86/microcode/intel: Establish staging control
 logic
To: Dave Hansen <dave.hansen@intel.com>, <x86@kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <colinmitchell@google.com>,
	<chao.gao@intel.com>, <abusse@amazon.de>, <linux-kernel@vger.kernel.org>
References: <20250409232713.4536-1-chang.seok.bae@intel.com>
 <20250813172649.15474-1-chang.seok.bae@intel.com>
 <20250813172649.15474-3-chang.seok.bae@intel.com>
 <06d43a86-204f-4658-9759-d24b7038b2d3@intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <06d43a86-204f-4658-9759-d24b7038b2d3@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0004.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::17) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|MW4PR11MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c2ede2-bf2c-4b5e-eced-08dddaaa7e30
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1hpdVpTcURDR0lpdzZQWkgxSjI3Q0dIQTd0ZnlGc1hwQnRvZDlvNjNIaXRy?=
 =?utf-8?B?RlF0YUFGMkdMWHhlUHIveDhaV3V6dU00TS9uY2RNcnBGbGN6c1Rwa1hSaTRy?=
 =?utf-8?B?VVI1d0R2c0REcnhWNWtqN2xIc3NYOGFmakJZTDRSVi8rMC9TY1VIN3dsVWRS?=
 =?utf-8?B?cHVoRjQ3UGNudkM3WEs2M09oV21jdjBLQXhiaXBoQ2VCeVZIM21MRmpVNHdj?=
 =?utf-8?B?aUhUQVNVYldJekVDTDVrTXJCQ0llekc2cUxkdDhVS0RFZGFUam5qV1hKckJu?=
 =?utf-8?B?WUJUUXk4ZXh0cm5FT0hmOU5MUmZaOTVkRWdyWXQxU1Z6UTZSc0tvSmlicVlk?=
 =?utf-8?B?MzhCTlNCbXFKSEM3a0dxNGsxTk5zWFQyRlJHcTZ4dnIzQ3pkRTlycjdUUDVN?=
 =?utf-8?B?enU3QUs4SXZXOTJ1azlMRExUbG1xcndPajRFT1NyVTZsR1VZQ2M1N1Z4R1Rs?=
 =?utf-8?B?clZ6WVQ2SmVhdzFMVHNzUHk5Q0FVTmM0TlByZjBxSlpCVklhY0I4MTU4VHdo?=
 =?utf-8?B?bjVRUDZkcWNLUDhRRndFYzZoRWcvNTR3UXhVTnhSOVBsTU4rZ3BJcGxPL1dH?=
 =?utf-8?B?K2ZhK2xLdllQRGY1eUliU3lJTGtnNnFlWFdmalJhTU8xbUwwZ3MzNVo4dk91?=
 =?utf-8?B?WCtLTGFNa0FoQThZOWs3M0YvVjBRdU9oM0RzZ0JRUVZYWXlHZG10N1lQM0JP?=
 =?utf-8?B?NzJIdlJVd0xFUjBFdlhXSlZUZVlBbWh6SHN2ZDFMdGloOFRKNytoWVlkZzM4?=
 =?utf-8?B?a3FZdkhER3JoZEs5R2puK3ZTMTRHMVhRNkdoOEtsVFFvbjBNM3lFVmJDODdG?=
 =?utf-8?B?Yng3NWJiaU9xQ3ZHUnhyVE91TDI2eEFja2ZBek5HUDZVUWVwckdRYWN2VHV3?=
 =?utf-8?B?d3k5SFFENHVGWjltWFlLS0xhd3U1aE5hUXdscHZhTVZxL21oc2svOThRbzFJ?=
 =?utf-8?B?aXNIOFpoUi95YUc3QmRIZ1JsN0RYV0Y0d1FnaVdpSVMyekhoV3ZHWFBTZ2xx?=
 =?utf-8?B?N3Y4MEV5VHdWNG1WNUpnbS9JNnYrblFzZk1lbDFOZUNBWW1SbU5VRmg5alIw?=
 =?utf-8?B?a1l1TTFRbkY5ZXhDVTdYQ1lwblZkMmFjTVlwWEdmSG5uVDhJN1hlZStEbksx?=
 =?utf-8?B?RXFPSm0vdGs4MlZWNzB5RlNZR3oxOC9nWFE0a05POGVrdFJ2dG5JRzI2azFF?=
 =?utf-8?B?ZnRZdU5VUWhIUWRsVmlkdjh2Und6STRYT0hpTlNEbDA4dkhBc1hrZnJybUV5?=
 =?utf-8?B?OWtNZGxnQ0lML0pJaHU3Ykd2ZDRIQTlmRTAvM0dEZ1JzWk0zd3VLRmVPSGl0?=
 =?utf-8?B?WlVOY3hyck8yb3ZvSTNpd0N3c0ZzZmlXY0xjaE8yVm1qUnY4eFNXOTBiaS9p?=
 =?utf-8?B?bWQ2c0ZHb2x2M0tkdWZRUFNXbW8yamE3U1hGVFRnQWNSTjRFdzM1NENwK1dq?=
 =?utf-8?B?YjhqTnRRRCt4bjhrOHJ2RTc0amxSblNJbmJsdWNoODFaaXdjYjlna3B2WTlS?=
 =?utf-8?B?M1lwZmFMNURJQWF5RE4ySUpEUGRiZFNWS2ltNDNtSHhjTzk0UCtjRWlvMlky?=
 =?utf-8?B?QXRUTHQxSVlibGZiMytBT1FyUmJna3lNY3M5VGJxZGVmT1RNT2NQWkd1d01W?=
 =?utf-8?B?QkRmZmdzNVRqV1NoTW53K1FNVEVuZGpYNkVPa2ZRbHFMNmcwRXJpdDc2SFQ5?=
 =?utf-8?B?VmlLYUhLQzlCd1l5YkVmQUFtbkcrYjJpSGhQL3g0YjRTTktaY1ovWXBkUDQw?=
 =?utf-8?B?b1MybER1MmZJR2JkWnJHaCsyS0tKMnZtS0orb0Rkc3hSZjZjemdZZ0lvbTZG?=
 =?utf-8?B?eG1XVlM3dHFaRmc1SFdtSWZoN1ozS0daZVRCNjFPL2ZSTG5vcGFESDlzL2xr?=
 =?utf-8?B?VnpYaE84QUFYZ09WWGZBb1hMSklyTjhtK0s2SE1Lak9kOC9TQkxPUFlZUWVn?=
 =?utf-8?Q?95xnf65YvZI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXd0bGIyUmdKVVQ0dkF3ME5ReERsL0liSUFiekJQaEFQcnI4M0dnOFVubTV3?=
 =?utf-8?B?cVdWSC9IYVZ5WUIvMWhtWHlYRStwQlM1TXRHaEdNQjd0TWtLQjRCQXJZem9R?=
 =?utf-8?B?cDNJUDRYbXFwZEpuZ1FDYnUydDEwbjh5eTdwbjBpMndzSHBKZXVyaERrYitm?=
 =?utf-8?B?YXkzT1BqaGg1cjFmeVM3L2xiV0dhOXdPM0tLZGVLWEoxbGhXTEl6WjQ3akVu?=
 =?utf-8?B?VEExTTJ1SjBwdWxLM0NoNXFRMFljNFJvVG5CUVJkYm1QRzRUZGVDR3UyWjFF?=
 =?utf-8?B?Rm9DcFdUdHBwVkJOc0VBakwzREc5anhsdVJDSkxCY3dlYWFNc0RvZmRNZEpz?=
 =?utf-8?B?ZHcybnRhRXJIWnBQcXQ2WVNOTW5PaUZ1OGJsVTFUQ0N0K09NZ1Urdmx5MHJi?=
 =?utf-8?B?cWdteHc0UmdqTnkzaW1aZGszVzFXdmt1SmhZYVNHRGt3bFE0bDUybWZOQWd4?=
 =?utf-8?B?R3hHa0oxcy9lVWtUUGEyUlFWSkE0bmtoWVhqWnBCWUt3WDRjODRMYkJmY3lV?=
 =?utf-8?B?L21yc0QvZWlMVTJ5am85M3NEbHR6SmIyTHplZjBxTWpGcTJuV2grSSt1R1dW?=
 =?utf-8?B?K1ovbEhGeXozTzVKR2VIa2tQVWhBL3VEd3JKbDVTQVJtcTZ0bE0wRmI2Z1Z6?=
 =?utf-8?B?RUozdUpwT1JENkJ4T3JJZnlCa2d2bjNKZmxJSzRPZmdqVGo1T1kzdGIzeGxl?=
 =?utf-8?B?eE9kd0JybGphU2JBZGFhUTFMSHlMNFpvZ0lrdExZMURmRWo2WmdFSzhSZDRH?=
 =?utf-8?B?cTRaejc5WTdlTDdEZnJ5cCtSeS94aDEvZDduOVZPZjVYZ1hHZDJDc29JNld6?=
 =?utf-8?B?ZnF5TmFzc3lqOXNFdExsU1RDNjNkclYveHlEQ0M5SE96NHVnQkl4dGV2RVEr?=
 =?utf-8?B?ZWx2UVdhcFBwQ2FDNVFvODgrZkJGck5FY2d6MmxOLzBQNFdJN2ZUK0h0UXdm?=
 =?utf-8?B?WjZKZWwyTkR1aVV0bHgwd0c5Mzh5TElTN3F3UWVra2FkYjljdEd1MjQ2aFpS?=
 =?utf-8?B?d0JsVGdkVUptRmFsL1lZTmp0MG43ZzZPODVJS2pOdFhwalpVbzRORFQvYTlF?=
 =?utf-8?B?TlFFeERrUkJVYjdtR3IwV3pZTjM3QzVnelJKOFQ4TlB0YVdmdHE3b0crUDBR?=
 =?utf-8?B?Nmgwb0ROTithWDlGcllreFN5OU11OU41T2o1S1ZPbWNUY3FEbW1OVWRMdTJF?=
 =?utf-8?B?SlgwcjY2OXFkaEloWmNycnhZWkczVUxRVHdJQVZpYnZyU2JQamRGcFI1L0Zk?=
 =?utf-8?B?VmNlSHBhOVJpYm9TNDZaczl2cnB6SURyZGpWRFI4cGlQT1JyMzd0NzFKdDdU?=
 =?utf-8?B?WlNjaHVYU1hrb2hoYjVsdzlyMGU3YjB0U3dRb01iMkxNSzFsSVVOMUl5ZTlx?=
 =?utf-8?B?VmttRmNQa0NZalZrMkRUaFR4ZWQvUnNnTGF6aEoxMFZ3ei91VmcrVjhqTXZ4?=
 =?utf-8?B?N2NxRStPdStnTnJIaTg5RlphWUQ2ZE9PUjJiMDIwcEZpK0cwMGcxMmx0N1RT?=
 =?utf-8?B?LzlQQUhSU2R5MHpnQzJjU1I0RmJmYUFiUDIrTXh6YitCNGNwWnp5aU93VUVS?=
 =?utf-8?B?YW9mZmRBMGdOaDJnbEN1ZXF1R3RhSU1JYVBobUN1cGQ0eksvRXRYUTA3Mk8v?=
 =?utf-8?B?MURCTGMvTWtFT0NwcElzZTNyRUtoZkw0dFJRZ1ZMblErblluZ3JwQnNjdmNW?=
 =?utf-8?B?ZTNrVHMvZzlKYld2NUljWGdydkVIaUU4R21UbTRkZVNoS2lsSmM5UlR2Mnh2?=
 =?utf-8?B?UjRXWE0zaG5rZ2FHengvTngxOGhqMjREeC9NR2RIeHk5djF3azgvM1kwZGcx?=
 =?utf-8?B?MytENHBUL1FvUS9kUEVZMW5OQTZSaVNLRkprc0VYM2NWWXVIckZkYTUyNGUx?=
 =?utf-8?B?aXVVaDVYVkVYR3NEejVMUkszdVJPcHpUMkh1cWFaZUVwNVBsNk5BUTkvYnpu?=
 =?utf-8?B?cU5hRmJKbEZtVm5SUkdJbStqZS9qcGRXTGtKM0J5T3gyRWFLWjRUSFpIWFlN?=
 =?utf-8?B?ODdqVUpSc0Q1ejFsQmREVTY4UDNsT3J4cTQrM2NZam9zT2ZiczF3QnNVZEdJ?=
 =?utf-8?B?TmRlNTVRTU5ocVo0SU9WV2M5VGI5VWdOT2hyMld6TmY2d1VnTmdwWGphbE9R?=
 =?utf-8?B?ZWxSWXUyaHhTUVZMZFdoYm5ZUWxLZDZhaDZETVorR2JjdWl6M1VQV0E0U25T?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c2ede2-bf2c-4b5e-eced-08dddaaa7e30
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 20:46:35.6497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BISiqFN5h2jE73as073fNOSwpuyQySKFNcDdBLTqNQkdGS6TpoLq36noLac4olyhu4/ytexAewfJHVykE7Ew/oWXgAzPdqs11sd+lde79M0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7080
X-OriginatorOrg: intel.com

On 8/13/2025 11:21 AM, Dave Hansen wrote:
> On 8/13/25 10:26, Chang S. Bae wrote:
>>
>> Also, define cpu_primary_thread_mask for the CONFIG_SMP=n case, allowing
>> consistent use when narrowing down primary threads to locate the
>> per-package interface.
> ...
>>   static inline unsigned int topology_amd_nodes_per_pkg(void) { return 1; }
>> +#define cpu_primary_thread_mask cpu_none_mask
>>   #endif /* !CONFIG_SMP */
> 
> Isn't 'cpu_none_mask' a mask containing no CPUs? How can that possible
> work here:
> 
> 	for_each_cpu(cpu, cpu_primary_thread_mask) {
> 
> ? Wouldn't it just not run through the for loop at all on CONFIG_SMP=n?
> Is that what we want for some reason? I would have thought that we'd
> still want to find the MMIO address for CPU 0, the one and only CPU.

Yeah, right.

Then, looking at it again, I see this:

config MICROCODE_LATE_LOADING
	bool "Late microcode loading (DANGEROUS)"
	default n
	depends on MICROCODE && SMP

This optimization only applies to the late-loading path. But, today I 
also had to clarify this dependency for myself. At least, my changelog 
could've made it clearer, sorry.

>> +
>> +	pr_info("Staging of patch revision 0x%x succeeded.\n",
>> +		((struct microcode_header_intel *)ucode_patch_late)->rev);
>> +}
> Hmmm. Consider:
> 
> 	static struct microcode_intel *ucode_patch_late __read_mostly;
> 
> and:
> 
> 	struct microcode_intel {
> 	        struct microcode_header_intel   hdr;
> 	        unsigned int                    bits[];
> 	};
> 
> So isn't this whole ugly cast thing equivalent to:
> 
> 	ucode_patch_late->hdr.rev
> 
> ?

Indeed. I must have been blind to that bit of ugliness. Thanks for 
spotting on it!

Chang

