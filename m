Return-Path: <linux-kernel+bounces-783179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 868D4B32A75
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776FD1895074
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72E72EA165;
	Sat, 23 Aug 2025 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h0aaFrpM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679572EA15A
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755965125; cv=fail; b=KW49adNKhaImMfmzqtj/zsAMAFJzOBzg6DvmY/FD+pOO6FWub25vTutcrXNQP3yVGGCXs2C46xyjr79dTjkzoFG0AQWOnqsMcnJleDJovy+etA9ExpvgmmnPNAmWldj9PAiJdSZlRWJ5h0y2AbjGk85iwi+rV0aqHzHmdm2GYRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755965125; c=relaxed/simple;
	bh=1Hi/WpAhxXErtF8Tcm1QA7gMUM0xScadreHIYZa4IAc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zl/vtzCN/HoeBK/5s5rnq4+2NJt/oRh2MMyZq9riFusooM2cKP5wCS5a7SUDKF5/VSTfmD9u/1g+V3KxWqX/Ni42+xi5NL0pphy5VKOH2Ijp+W8pkCrDeD1SSHDGY0it0DSKxlqgWtq+6/XrJBWruZ4nWJQyBh73p8l0nNC0tz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h0aaFrpM; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755965124; x=1787501124;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1Hi/WpAhxXErtF8Tcm1QA7gMUM0xScadreHIYZa4IAc=;
  b=h0aaFrpMMjx3txrijpW1JNbAgu89bYkpl7XZjX83zm/T8L+cwu9ccIvz
   O4jlO5e4C4NK49QqGWuwz/vT8eeVicH3QDqAol5UV2tHiHBKfR2aefoNK
   epBjOlE9vYm+hXAFaxKrASFYdG45dV+62bKJDuzuX3Dmg5hCbTpzMggDA
   iFzmOrNOpTM5YBK3EknzbdzBwFCkNrtfrzye+6ztpLxEdK8enFGM+PNdP
   GfLiIZ0+cqi4jHEY3Gh5tzw89Shf8IecLymxKjw/F1BFMZQRxfAFbYjY7
   F6J1N+eCIQwfOV9hjB23sDVAs9wZ0Xs5BOiHuXReyWmjoDtQlSVG8LoQg
   A==;
X-CSE-ConnectionGUID: Dx00/RtbRCewdYBa0AUY8Q==
X-CSE-MsgGUID: rCXtOpf7SoG4TgZy98BQ9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60872551"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60872551"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 09:05:24 -0700
X-CSE-ConnectionGUID: xOv7T8bwTBC90FyU8zUivA==
X-CSE-MsgGUID: ZOmKRz9UREGwFyeZZumUDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168839908"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 09:05:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sat, 23 Aug 2025 09:05:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sat, 23 Aug 2025 09:05:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.71)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sat, 23 Aug 2025 09:05:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2ekO5ObZx1bYm0Z2rRv5c2oM5x5bV4E7hvx6BtQB9hCSccq4ODtFhSirEWABOiR7q5bYEdA0bjok8VQjYVMCMt0HKmsPetwMzbv01NAyvFW4foGgGn+vtGlU3GbDZodqB4xqYSEA3dobB6FlToBnJRXho1Mrhf1NaFVefCgv3LZRcujdsPQ1uwwQmDS5RgtbFbN7pEkltyNGqFXnDzP+wIrKI2RUsfbKNTSXJzFFvoRBhShmE5GeY68GOwxvPZTeC6NY6UDxeqIDL1jSpl40Iw4GolyYPgfrVA7s2m+Tctx7O6eERMckV3slC+iEirKoRY8Wjyyqb4lJG0J2+lVCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Hi/WpAhxXErtF8Tcm1QA7gMUM0xScadreHIYZa4IAc=;
 b=qwPLjpxah98rrWeGSxLNymGQ3h50XHfe5FB8OWkXjEX7lg+buPAfhde8sTmpI9CguHkdvrF+iCx2hyFN9PAEzVPmtZ3bLaItmx8ytzLkhQ6JK8ijmXxkP7W7FBqL6c3IMonhfPVKsATw4Yd42SrukDNSM1zZjrzruwihoyKV509RLD2NyeTkVcboK1QjPXWctMESA1OlDBKCRNvumY87O25JcaJvoEQV5ghYAdoEDFo6fP+W2FN3ek482ZyhXqQXPIIaOezkIvCjYhtGjba1BShFEHlGUtghsELbUJUaRo3aU8rnJJ/bY2FRWHt5A8e7pRsb8O7GNLEmMNQvV9kV/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 DS0PR11MB8019.namprd11.prod.outlook.com (2603:10b6:8:12e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.20; Sat, 23 Aug 2025 16:05:20 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%5]) with mapi id 15.20.9052.019; Sat, 23 Aug 2025
 16:05:20 +0000
Message-ID: <c01758aa-d341-4622-aaf8-9a93058417f4@intel.com>
Date: Sat, 23 Aug 2025 09:05:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/cpu/topology: Make primary thread mask available with
 SMP=n
To: <dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<colinmitchell@google.com>, <chao.gao@intel.com>, <abusse@amazon.de>,
	<linux-kernel@vger.kernel.org>
References: <04cb59cb-e9ed-489c-b36f-6c6209b2e93f@intel.com>
 <20250822223929.12483-1-chang.seok.bae@intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20250822223929.12483-1-chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::29) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|DS0PR11MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a98fd2f-6858-48ad-2eb5-08dde25edc0c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z1dBeTdGOEE1dzF5NURVWHJ5TGhrUW9oblBielNDOWF5L3IrazdEVHlkM3o2?=
 =?utf-8?B?czA5STBjM1JXamVJd29oOVFiTVdUTjF4cmRKV0tjbHd4TVZCZGJuZXg4WEM3?=
 =?utf-8?B?OVdQa0VMR2dvU204L1FxSi9LTDRMRGRRV2U1NkxMTmhOWjNkMnZ2SjdzRzlv?=
 =?utf-8?B?Tm9xM0NhbTVpancvOVA4N3RaeXFYYmxwcVZWU1FOalN2MFp1ZkF4NmIzZVRk?=
 =?utf-8?B?QTlIa3Q4WVhQVHk3dkVNOWpadGFuMVh6U1Uyck52RUZaQ29pOUh6d1hNU3dt?=
 =?utf-8?B?a2N4d3VWeEp5OFpValQwQllpcU10Mk1IRjVxeDEyUEt1T3liZEdlaUFNWVEw?=
 =?utf-8?B?Z1ZZb04zTFBCVmtlcXRaeGtKNjlpVnVXazZvRXAydjBMWjZCY2FYZUplOFZm?=
 =?utf-8?B?NTdrSytpdlhwbUprSHl5VlMrVVJFc1lOZ09UNFlaKzhXS09TazRPNkRrNHB0?=
 =?utf-8?B?L1V2ZlIzQVpNb1FkejRQRHhEZFdpUGlFN2NoNHA4RURrQll6c2wyVkxYTmN2?=
 =?utf-8?B?U3RYdnFleWlsenhuQUs2Z3pjejhFNllVcitsS1RTNmZ4TkFwMkVqUTAzMlE1?=
 =?utf-8?B?OXZOUWN5NzVjN2tmd3pQdm1RMUlmRnkxeWNYVUsvTlVoOHZWTmZEK0dQdndG?=
 =?utf-8?B?U1JtTFBSZlhDWHViZjFHTmdXeGFNVDhjbytmMFhCa1FaTTV3eGNMUlovVm9s?=
 =?utf-8?B?clF2bEVDYUNUN1Z6VURrcGVOZzJocy9OdmlVUXhvS2ZVdW5vNFFxTmg1aXV4?=
 =?utf-8?B?N2ZLUzB1YjVyV1lDUU42ZjI3UjdRVzVHa0djS1FKR0YyRjlEcU14THFqdHlr?=
 =?utf-8?B?VGlwQXQ3QXJlSXNZUndUV3dTT3JQbVhIbjZFMU15YUd4Y01PMkhHY2d2dDRQ?=
 =?utf-8?B?S0tqZVVMb096V0hYK1FaQlFwenFhRjMyczhFeHV0QWc0aFBwaWNxYVQ2UmZk?=
 =?utf-8?B?T3dXZkltT1BKRjE3Vk1QOG1IaFVGTVQ3OGh2R2ZLTTJ1Q29SQ3NlTWpYb09B?=
 =?utf-8?B?dmpwQ2s1VHhjdEY3dnlpNWcxQkhGbm40NWYzTUQzeitYWEk2SWJhYTg1N2Vj?=
 =?utf-8?B?NVhKV3hwR3VNNldpNWMzNy80elpKQngzS2hKZlE1ekd5REtiOHgrUVBac3Ny?=
 =?utf-8?B?MjB6WGowb3o4ZTZ4blNvNmVSeTJRV3NEcm12dnZMNW9VRTlGZldHMUdzR2gw?=
 =?utf-8?B?NmRNSnNTZUZXdU5yUWJUMUFuaFUrcmg0NXJzNGN4N0lZb0RrZ2hiN3dqTnc0?=
 =?utf-8?B?VVVWaStkMjlLK3VtdEdFbnFBVkRHdHVUckhqTEc1L1pLM0dsK29wa09ZNEFE?=
 =?utf-8?B?dzZiNEQ5ajNjKzdWUlF6Z0hJRVMwK254N3RFV2ZvbFRtVFRXclBMZ1hiMFVm?=
 =?utf-8?B?c1VLbEdMWGhWQTJwNXF0NS9TZWp3Z3BITnNmUm9CTTlHRC9UWHJVdllBWTlX?=
 =?utf-8?B?NlZQR0RIeDJkVFVjQ3l6MWZodUxLcGgrMThhWUJZODd2TXZhNnJ0WWNidHox?=
 =?utf-8?B?amVqMlh0R2wxa3NCbWd5cnV3VzRGVnI0SytnNW5IS0k4L2xSd1N4VzM4bXZh?=
 =?utf-8?B?a1VEVi9rYnEzWFdtbmJDVTJXK1BCclBLalB4d1F6Unh3MnFkU0k3UUlBVUVR?=
 =?utf-8?B?ZUFEKzVueFBmNFVCdWsxM2JOWHl4MXJFSmVMNXpoM0lxbmZvbDBlQk14eUpn?=
 =?utf-8?B?ZGgzcS85WkhGTVFHTGdlNHNBT2JteEpGdithVEsrcVBOam5wamdEZU16VjdH?=
 =?utf-8?B?akcwRDUzSjRnVWpqYW9mU0tXMEVkbk05bThSSURUL1dCeXJVdWUvU21aOEgy?=
 =?utf-8?B?bVRDQzZlUUx6bmxndG5rQ2lqNndCZWJWSWQxaVJtWGUwOUhGQ3pQb0lTUXY5?=
 =?utf-8?B?a0syMnZqdzFxd1ZzVnlYMUh3VUlDQ1hiYUkvcEJ4T1d4bGVuK1o2MUZqRWhP?=
 =?utf-8?Q?3o1A/K9jUtE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnBqemwzbHQ5YW82OXJxeFNMZjk5WXV4Rndzbk01Wk9TQS9lZnFySDAxWHBC?=
 =?utf-8?B?Y1cwT2JWWmdkckR3bmZEeFV0eXR5NTlMbmtLdUowVjRQeG5KVS9rVWZMZ1Nn?=
 =?utf-8?B?MjdkZi9LME5LSVYwR2htZ2tleUEwWThQWTNXL3dhQTB0RHR0M3hXRGhxODdE?=
 =?utf-8?B?dWdveEFXUEFlbG9kY0VYQzByNi9GVXFiR1R3V1JMSzd3QWdINE5taG1ETWll?=
 =?utf-8?B?dU9WcVJWazAzTHU0cVo0WkpsTy9tdFFyTFNEa0ZyS0psa2psWW9EekJuMWRo?=
 =?utf-8?B?N1U2UUUrRWZ5MEgrbThYS1dlQkJ2dGppTnNOY2EzUWdrbDI4YWN4RThEK1VL?=
 =?utf-8?B?cEtZOVBYVW1GaDRYanplMS9GZzlUdG1pMWlNZDBWZGQyQ2FPUENML0FtVitQ?=
 =?utf-8?B?Nlhhbk4rTXFoTlUyaWVkYTg4K3RlNjZtZHZvbGZHaXAzWHFYM1ZZYW5MOWg4?=
 =?utf-8?B?TW84aC9kRFRobUthT29kWFVRSmFvbThBZmJDSTJwdkoxdDI5UkJtVzQ3dEcx?=
 =?utf-8?B?UmZXalJiNEliN0pUdzRUb1BwcHFUT256SFViU085ZFV3NHlmUW45MmU4WW03?=
 =?utf-8?B?enUzMkpiQ3kvREttLzNsOE9teGo0OXhlZ1lTYUQxbUFzS0tyL0RCNXRQTkkv?=
 =?utf-8?B?MnU3Z20vMGlsVk41SlBKejJYN0h4QzEvT3RNMUplQ3J3Q09pQXdnazcvaWdY?=
 =?utf-8?B?ejc0cUFldlgrRXFUZjQyWExzcE0wWGpTdE9TbUtaRGJXeXZGcEh2dGJ2Z1RT?=
 =?utf-8?B?Ri82cHdlV1RCb3lZM2lDZXAxUlRsa24yUG9XUURUdUlRcnFXWHFTMHBzZGF4?=
 =?utf-8?B?SVY4TDMxMGtNSHZZTGRYa0Qrc0dOUmtmdyt5ZDkvN2xCQUwwZUVjanNxRkEr?=
 =?utf-8?B?OW1LaytVR1RZT0poZW1LdjVMSjlsVDFzMlQ3dEpNWVpwdUQxaGZFblQrRnpo?=
 =?utf-8?B?TEsrNlBNT08zdU9McCt2SU9EMEhvVVBRNEtZbTl5bENRN0FCcC9ka2I4K0t1?=
 =?utf-8?B?TEFhYlNFbElvZ3V3MWVheUQ3UGNCNGJoTEJNZ0hOTHhMUmttK2hqLzlDUmNT?=
 =?utf-8?B?b1RsV3FJeTRwQlRRWGZ0VHlqSnA0OFlWdjFlSExmTUxsZjRJaHlZZkIvT0I1?=
 =?utf-8?B?OU11Y2Y3YmNQaFBOdG5VNGdUcWh5U2F3TnIzb1drakszMW56aDdBKzRvTlRG?=
 =?utf-8?B?WTI3cUJwaHRSTFlWSjdMcVd3VXRXaG1hOU4rYkY5TE1hbDU4bjYzNXpVWmox?=
 =?utf-8?B?U2dKRFNqdkR6b2k3VmxHbzAyT2ZaVXozTXN0RGJ0ZjhNQnlaMGNGdGNOd1pn?=
 =?utf-8?B?OE1IaHlCS3FkblY1d2dvbERWMFdmNHFVRW9yYkRKKzlBNCtnd0NJelhLekdS?=
 =?utf-8?B?ci9FbDZ0dDZ3WENVNFdBL3FFcytGQmJLd3U3K1M5NEViakRjZDJ6TVZONW9T?=
 =?utf-8?B?dW1xU3UyY3FEd1VjVVJsQUlLb0F1TDZzTGl0c2ZOSjJFSXVPaWF6RXNtaXRk?=
 =?utf-8?B?OE9IYXdQc3ZnVlQ4RHBnVXd3Q1hvQmNEczRIYTZNTzVRSTB5RzZTeDI4Y3pm?=
 =?utf-8?B?Ymw0TWZoZFJjS2IyTHBnNTlpQW9DN01KUHM2Y05kOXlVZk1SL1l2L1FiVHZP?=
 =?utf-8?B?bloxRStMeWFmK0dBeDdCTE1ZOC9ETmJGUjVqTEQ2SXlPVFQrUEVWcG1BOWl4?=
 =?utf-8?B?cW1FaVppTG94VlhYZEVOSkV4WnNBRTdyU2NQWWZqRzBXaXF2REJjanFXM0o5?=
 =?utf-8?B?UUEyblpoZWcyTnN6NFRZUDFFV1dXVGNnT2x1RWFBVFVHRldKS1NROWR1ZXR4?=
 =?utf-8?B?QXE4WXkyVDd5M3RYRGtkd0lkQ3RZV2V2eWN4elEyUEZlK0xtem1yanE1cjNn?=
 =?utf-8?B?Ty8rZER1SnJDSElrNklTazJQZXBjSTB6cm1TcjliOFl0eDQwalRqT1RlRUZ0?=
 =?utf-8?B?Tmt4Sm43SXRVTWkwU3NQSTBBcitWYzVqY1dEenVCV2FrN1RBNldJdXdEaGZR?=
 =?utf-8?B?c0JySmc1UGp5Wk5tN3VQZ3lvdjRacEFFekNwYitSdWJEQjBpdWtjSXAxVHZR?=
 =?utf-8?B?M0tFTW9IZE9teHVXMTVXakhvRW1NZ1ZESWRIZWQvSW9qUnlVcHBzOUdpS29V?=
 =?utf-8?B?MTczQ0ZCTk5vV2tnWXBVVTZkUDdlU3NDZmdSSnViaHNVcnlUWEdtTm9wZytx?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a98fd2f-6858-48ad-2eb5-08dde25edc0c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 16:05:20.5576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUGZ2eNRQCFEG2i38v5G3Me4ww90PVDDJ06J3GZRLanBxb6nBZE4r7uG+VBJfgzGaQTYpFCAVcU9ILLdzeQwZndhReVPJOZrE2gomfx65BI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8019
X-OriginatorOrg: intel.com

On 8/22/2025 3:39 PM, Chang S. Bae wrote:
> ... The next revision of
> that series will depend on this.
Fold into the V5 posting now:
https://lore.kernel.org/lkml/20250823155214.17465-2-chang.seok.bae@intel.com/

Thanks,
Chang

