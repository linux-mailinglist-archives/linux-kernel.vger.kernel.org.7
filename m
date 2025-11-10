Return-Path: <linux-kernel+bounces-892364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34F7C44EE6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5AC33B081D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 04:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068C820468D;
	Mon, 10 Nov 2025 04:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tfr6yrJr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1755818C31
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762750378; cv=fail; b=gWdVE2DhAG3wDt6E455zx+naWGLn8AMY+UjgImh70W9oy3aH/FwbfhXwqQH02/gXPWp2MlYF1i1XiD9uiBiyWeLWZax3H6rnKGf2krpreR9jg0DnTwaHum/uG5gYCSqd8PZWMt3vR+FXxtDFrEKPFxL44NXLuE5t9B6j4Mf9Fpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762750378; c=relaxed/simple;
	bh=rU+cpQozMNwkRXa5qPTGbup/UYXvmGRyxKDtvrIijdc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ofzzGAwQecJX2q6p1mS3psk8Qm82N3S1u0JL07P4s4hg3S/4g5THwSAcFOfoSWtZYuN69v7iMfOpBYlfZv4J+KangndJR/W3AsoYjBm7PLncaz2Ltvor0jj33Ryil756HwDa0iyXto3aaPOQNhiSM9U6rKmdVql5u6Yt3PUiOk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tfr6yrJr; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762750376; x=1794286376;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=rU+cpQozMNwkRXa5qPTGbup/UYXvmGRyxKDtvrIijdc=;
  b=Tfr6yrJrFMqJQHAJaXNvVzrq4Ra8aFCpE6d6DS6lqLJGsU2qRUsHwzyS
   B4l2XedU5ZTI41+2Ck/11LSBeb8sKMkZ5drTXiJNI4SMrsXmaxNPBZL/d
   jHDuKCJEw6w4EDY6grmhokqeG9dmebQ6m72haQdz480wa0NzLlQbAFQg7
   K21HT35aDzZNltRKOxxoj0ewPzBstjigh6jGaxZqVgWCQPPGlZvSNFetL
   YydbBoz2T1UV+NMg5mp/Ap2YRuNdSr5S7zyoM2HWfMgzkMsWjrDifYW9O
   drjs0nuLX1IeK8w8MaunvivC/zHMU6OQA1It4lwMimv099WEoz05klK0d
   g==;
X-CSE-ConnectionGUID: ivQfSlq5QcmGgvZ2J7K+jQ==
X-CSE-MsgGUID: /OCDXigSRyWj5OkgCyz2cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="64838262"
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="64838262"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 20:52:55 -0800
X-CSE-ConnectionGUID: jpyIUDgPTtmnKfR/xoXOaA==
X-CSE-MsgGUID: 2Eki4T6eRumbxDCQzJDJsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="192836652"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 20:52:55 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 9 Nov 2025 20:52:54 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 9 Nov 2025 20:52:54 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.25) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 9 Nov 2025 20:52:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZOZ8I8JI+tAEgfmqnjup7X+Bvm9AmVPkCGReeA9f5qRLDWNmJTfOKJ6cyx28zfb8zoC5ERkofrUkT4vWZmoq3IIkGiMJnQ5Hy5/n1FFb3tBuDnqThHWVhyr47rRsW+C7ssamPBc5HwLHtMF+k+zntwwQx39syohNsAmXxmLfxA97IlJTAjhdg6epd7Rmy02upV/G4ZS8p7pk8s3FLhphzQl4eeDFU9ZJehFxozjJqd+/JdePnYK3dfu/832Q/il7ksPK6xUw405blsbgLgzmZ7IP78DPGlPTXLrXKYBIL7tt40M9HIvDXVfeHCUCoKbKT5KB92xZkd++sOtSEl4qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYEHVASHqRw1FiDMOLHWMYmBmXJ1MzMOVJ4XjKVUFbs=;
 b=COfpvsjEyOrCannd5BpYnQkd4WH60iwyUj2e0u8MlWeEgEzHnEEYXCC5BSMxLVXJlyNPFhd7FAy9t16qKGKFjdVgb9JgQkEc2a3KoUoIqgbc+juNW3Oc01FXRGhR0AN1TuVLHCrxvM3eTUWo43RwcCYAFBEIHC1kW3UMkr71R2OfW4s3Vev1x8gHNYRsih/VsKRrT5gG0czHS6NByVJB+iLkRuVh59DhNjUi2QpuR3TrZV4TRvV/T2OeBRIys4RtIDCtoyrMuTEBLEEMSPrZStHFeLiixaCAM/Y4lGz47+F4E54OUVePi4cFcZDmN36ERhD61Fk95nd9BCZ9N6s8IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
 by CY8PR11MB7746.namprd11.prod.outlook.com (2603:10b6:930:86::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 04:52:48 +0000
Received: from BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891]) by BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891%7]) with mapi id 15.20.9275.015; Mon, 10 Nov 2025
 04:52:48 +0000
Date: Mon, 10 Nov 2025 12:52:38 +0800
From: Philip Li <philip.li@intel.com>
To: <jim.cromie@gmail.com>
CC: Joe Perches <joe@perches.com>, <linux-kernel@vger.kernel.org>,
	<akpm@linuxfoundation.org>, kernel test robot <lkp@intel.com>, Andy Whitcroft
	<apw@canonical.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn
	<lukas.bulwahn@gmail.com>
Subject: Re: [PATCH 1/1] checkpatch: add MA_STATE to declaration_macros
Message-ID: <aRFvlrdwcB69JXWh@rli9-mobl>
References: <20251108234725.1650246-1-jim.cromie@gmail.com>
 <cc0edf9cf2ee40bc13eec609eec5686de4f9f77f.camel@perches.com>
 <CAJfuBxxfr3EgUB1cPDC_PXB0qVhrtDL330EmtTFeEbF=t8Wv5w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfuBxxfr3EgUB1cPDC_PXB0qVhrtDL330EmtTFeEbF=t8Wv5w@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0156.apcprd04.prod.outlook.com (2603:1096:4::18)
 To BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4165:EE_|CY8PR11MB7746:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df3f38b-4e07-45a3-5389-08de2014fe8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SER6Zmk1RXd5S01sZ0dCVTA2c0NJQ0FzbEdMQy9zZ2ZOdDY5TjJSbDd1T0Nu?=
 =?utf-8?B?ZEVBbmpJN05WUWtkZFk3QjlLUVYvN3MrRkN0T0pKYWlEeXNPV2lWVXZtQnlE?=
 =?utf-8?B?dVZlekhJMXZjSFNDb2Z4RVJ4SjFUR2NlcXU3VW1FNUZOcC9EZ0Qwa1AvSFNs?=
 =?utf-8?B?amVzUDg3aGFMMW4rWW54ZjJIK0V1NFgxVHZoZDNaUGkzbmNCazhBa3k4eldF?=
 =?utf-8?B?N3VpcE8rWUJWMEVZN0k1S01zNzh6eFhSekorQ2w3aUdmSXNWTGVPU2g4UHFp?=
 =?utf-8?B?Mi9qeWs0VjJsbHhkdThUdkQ3Z05ueDRBekdvRXB3SGhHUVM3SEJLVkVxdTV3?=
 =?utf-8?B?YzlyS0hMM1pmWHhWeTE5TEJ0S1UvQXRXeW5QaWs0RlkyOXh3ZkJEdjhjZDY0?=
 =?utf-8?B?Z3VRclRvK3VpeGxyblg2Mmx5bjhHeHMzcGdZWjFTT3JaSU5uRld4WlNMeWF5?=
 =?utf-8?B?N2VEWmpnWk5RcGtOOUV2MXdLVFp1NEN1RVlycG4wd21EY05Rc0RLaUtBc2JN?=
 =?utf-8?B?SUVpejZXRVFqSllyN2xyUXhtSSswMUFUOThXUVI3ZytySDBmczBGYmo5ZnBW?=
 =?utf-8?B?cEdVWE5objNRSjJ4aG5pTWV5UFJPdnJkMTh5Uy9EVUJKRHNMVXBDOG5wVzRV?=
 =?utf-8?B?eUJGQU9aS3gxMGtrdTJ4SXJ5RERPSHNOSU1tdDVvdDZEWmxIMUh1cGpVaHRQ?=
 =?utf-8?B?bXRQNUdRL2lENXNOeDhqRDV2REh2dnFrZUliY25kUDZhamR1dmpzVXRPZ1Rv?=
 =?utf-8?B?VXZhVkNSL0VnTkw2ZVpuUERROGFWOWZPU1IvUDljeFlDOUJ6TEE1QUcvYVZi?=
 =?utf-8?B?ZFozejdubWNpWjhRWUZ5MDdIUllLU2RnZXdMeXVHSUl2c1BVT0xOdFVSS1ZE?=
 =?utf-8?B?NGdoOWRyYlhPZDE4M2VEeTljd2VkZUJUUnRlYldKaTJMNXlBSHV0MXJKc2Y3?=
 =?utf-8?B?UklURHQra280NXQ4Kzk1dWpYMmQ0ckNScC9iaE5SdHBKeHd5bHd5aU13UG1B?=
 =?utf-8?B?b2MyY3dHV2xkMDZYWXV2bzNqRU9Jam1ha0tEREJtbE8rdFJJR0xabkcvcFd3?=
 =?utf-8?B?TU53bTdXQXMzQ2VSdlYzaFZqRGpWWFpkTnp5MVorMWZEc0ZhcGdONlVwc3gz?=
 =?utf-8?B?ZzdIOUZpa1I0WHpSMWd6eC9mZGNkaHNBdHRyYUZDZFlsbXlCTWtQdkFjVUJp?=
 =?utf-8?B?aS9xY29EeWhuZ05FZVdSUFhsS0NVNzQ3VjI3ektQU3RNQ1BwWmx4eDUxcVV6?=
 =?utf-8?B?VGxPT01lclBWQnlrSWlDZEhONE85ZzQweTZwT2dxcVZhUUtZK1JwQU9PWGdn?=
 =?utf-8?B?ajdhR3g2NXhkcXI0YUhQcm9IdVRITHB5YUtKZTBOUGR1WUk4VGFRNmVKZFk2?=
 =?utf-8?B?NklJMnVOZ2tDUStVb0ZCbDJaMlBCMWtBTzk3ZzZGWGNaYUVzWW45RzJKUTZs?=
 =?utf-8?B?TUxkQkV3aThHcWZIZ3h6cllSU3FEQnp5VVp4MjN5Sm1NNFBSVTgyMjNKc0U1?=
 =?utf-8?B?cXlBN3RMUDFJb2hBRHhTTWR1Y21WOHRic05EWVVseWxFSkU3WXh3eGsvWkRi?=
 =?utf-8?B?Y2ZISlZzMWM0WnlMdkZyTVZ2TFJNc0hLVlJkaWRYclFkWGRYaGFHYkVZYVpR?=
 =?utf-8?B?ZmlTcmlRYlB0SWhkdW9XNW9INElJUU9ob2pUNldjUGFVMi8yajJmcGlISlBh?=
 =?utf-8?B?djE2OUtLZWxLcWZ0Z05Ba09VUTY0Y0w1L2xRakl3Y1FkR1BQVTFua09WQkVk?=
 =?utf-8?B?YldwU282K1hkWjZLMUxJUUZWUFB4WUNVUEk5WDhqV1FZRDdFNWtpVjR2SDFt?=
 =?utf-8?B?UFhpOVdtSVRsSEtIbWJvc20xTDk2WGtJSnRQUFZrMTMxZFdraU03T2YreWNn?=
 =?utf-8?B?UkhYZFlkNFFncXVnL1NlL1Y5R1kvVktJTnBSRFpSa29wQ3poOWh4bU1wb29q?=
 =?utf-8?B?aW9TNXkrOXlmWStRYW9vQk14Mk5WbUg3eEwzY0k3TzkxMTdSNkVVWE13Y0ow?=
 =?utf-8?B?UFBLYUJ3WWR3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4165.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmpNeFQ1Y093RGg1YllxeDlRSS92ZG5ZY3BDd1hKVXE4cE5PSEk4NTJBSTUw?=
 =?utf-8?B?V0l5cTJsWkxOUHZMV1daSTgxczhWbWlMbnpVenhOZTh4dHRPWEgwd3cyOHd3?=
 =?utf-8?B?aTl0YXc2RDdnZ3NHUm1COHY3ekJldzFBQVpPUjBRQXYvVXhaNFA5VUJVcC9J?=
 =?utf-8?B?NGRHeFQ1SjRsWU1DWWVzUWVUTUtTdUd6ckRsQXlXOFlPNXJ6Y0MxSTMweXJ0?=
 =?utf-8?B?RnhlZUYrOTNVdVpSdnBPRVpneTlNcFR6dHVUcWt6OHVrWWJpVWRVajhRWUFK?=
 =?utf-8?B?ek9ZSStFVCtNdFNJak9GMEZuWDMrbDNpOHFOYWlZV2JqaXJ1WFNZUXRCSXkw?=
 =?utf-8?B?TXlxQm9ZSDhxNUY1V1ZhTHhvY3pPLzQydTNzaE53bzRzWmdZWWFHTHJYY01F?=
 =?utf-8?B?T3ZiVjBWamJMNzVyYzFrT1U5cmZSV2cwK09LN2dERURGQ1JCbm5VdkM3bzAy?=
 =?utf-8?B?UmdEbXFNaTJ5NFFTYUp3dVpNUWNYbVgycEc3RWErd3Rzbmw2QjB2dVVIS0dp?=
 =?utf-8?B?dUlVclQ0SHNPUWwveG1WNVY0UDFxUHltdXlKZ3dxajR0N1BFbFp3alprWWEr?=
 =?utf-8?B?eXVjbTZHVFV1Q3hWUkpENitIODFZTzU2VG9mUW9QVnNCdXpKdkhMNmwvaCtJ?=
 =?utf-8?B?b1YrSFprTUpTL3lQdlJIbmpVV0RnN05vbGJCcEs0TEFrMmZCUDFCOXZSbDgv?=
 =?utf-8?B?WlJ2aEo4UGM0M1A2enJPUkt3Vk9Wakdhb240QXIyVXZwZkRYK0xrOU9Rcm1D?=
 =?utf-8?B?eCtERmpYTy85VDJJMnNHUUVObzM4WW5tdHF3WW5RbFYvbHhXSDd5aHZobjFZ?=
 =?utf-8?B?eCtkZGhxS3F5Mmx2SHpWRHU4WFdQZlIrNVcyOGdnZ29TbXhFNFp5TE5KTVRP?=
 =?utf-8?B?ZWpBK0YxbDdkb25kR1VnRkxaNEFnNjB2WVB2ZzBrRkZrMi90RHpheU5oZUtB?=
 =?utf-8?B?TUdoL253NVBDVVhCc0tKYnR4MTR1WUxlWDFucU1MNkRvTU5JZmdIeXBqc05T?=
 =?utf-8?B?SXVHdXQxQkw3QUNSMUlOc0gvRnVXN1pPbGl5T3RVZENucklyb3JoTmNJLzBZ?=
 =?utf-8?B?QmE4V3VLNWdUZVJZU1U0U24zM09zTFc3N01PQ3MzVXAzWmV0VVViRngrYjFZ?=
 =?utf-8?B?N3FlZXlQSjM1ZERzb2RSY2RrMkVQT0hNMUdGcFF6ai9IZjdvRDFxemhpWERo?=
 =?utf-8?B?d0JjdDRyekZYeVRFUXo0ZlBEZWxOMHRRRDhaaDl0ZmovREkxb25BWVAzd1l3?=
 =?utf-8?B?Y1RDNDVXZDZQOWJlVmwxQjRBSStGZkRqWlRDTmF2bE5iSGpJSkJwYVZuMzFo?=
 =?utf-8?B?NWwwN1RDbVNtUFZTMkJhTWhhdlBYS0c3cWR6OFJ3RDRha21DOTVPYk92bHR1?=
 =?utf-8?B?aitwR2VQSjBWT3NzUzRYZng3R3JaZWNleHVuaXNtQUJYMXZsZ01ScDczT0dQ?=
 =?utf-8?B?RFBxNnIvWjdzaWV4RDJORnhreGNFMkZKQnZFWFUwNkZ5SW9XL2ErcUt3K1Y0?=
 =?utf-8?B?c05TYTMvUmg1V0lXd1Q5Nnc1RlJpOXhsOTJKbVJueVcxdnd3NnNPMEc4ZmpY?=
 =?utf-8?B?ZzI3em8zSHo1MUM2ZGxMSXRSaTVXNS91Mjg1R3k1RCtWbENNdmxTeVkwK1pQ?=
 =?utf-8?B?Q29oRU16b1cweFJFeU10N3N3clU4Zkl0NDJaZjNyQU0wcnBrSm9Rd3Q2ankz?=
 =?utf-8?B?WDhvdVJ3RkI0QlJRWXNsa0Y4UC9zS0xSVHJDNUZCYXpWWkVLUlZoWmNXSEVp?=
 =?utf-8?B?dWpjZURHVkdGUk1UVTYxZi96RUhQdDBkU0xEK3FodW9pbGFsUk9EdGxPRWJD?=
 =?utf-8?B?bDdiYnYvenhpYW96WjZKbTB4UDZVdkJqdlA3b09GYTNDWFZHY3lGbWNlbVE2?=
 =?utf-8?B?UlExNWsxeUt4aVkzM3piU0t1ZDc0ZzgvSEFjMFI5MmR5NW5qMlZPYVlDZjBE?=
 =?utf-8?B?dW5vU0RTK0ZiVENDVkZpR216Y1lkRzR1VGhtL0FUdFRhaGxTNmkrTVJ2WEgy?=
 =?utf-8?B?bnYrdFV6YlpFRCtIWmpGNFZNYlluU2NHWDBrMFVxSHlyZWZDTks0ZktzbCtk?=
 =?utf-8?B?TW9VWk9zazJwUlp4bjlJeHJaVVljQ3RzWjY1VWdJSTFkYUJXNG9FaXgxOTV0?=
 =?utf-8?Q?Yls7/4Pnr9BYqijoWBIpaJWcj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df3f38b-4e07-45a3-5389-08de2014fe8c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4165.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 04:52:48.1989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfR5teBlsUfHCVyIFztLS97ZyAqGSkvAFtHOQo6pTOv1kWy0WdYTRmqGPlOC8sp86ak6qKCNCbp/D5g2LeHzRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7746
X-OriginatorOrg: intel.com

On Sun, Nov 09, 2025 at 08:09:47AM -0700, jim.cromie@gmail.com wrote:
> On Sat, Nov 8, 2025 at 5:52 PM Joe Perches <joe@perches.com> wrote:
> >
> > On Sat, 2025-11-08 at 16:47 -0700, Jim Cromie wrote:
> > > MA_STATE is used repeatedly as a declaration, add it to the list.
> >
> > OK but
> >
> > > I left out the $Storage regex component, since I saw no cases wanting
> > > it, via: $> grep -r -B1 '\bMA_STATE' .
> > >
> > > This change fixes the following, reproduced locally.
> >
> > No following ?
> 
> the oe-kbuild report followed, but the link didnt work right..
> 
> >
> > And I looked at the MA_STATE macro definition that has
> > several NULL or zero unnecessary member initializations
> > but doesn't initialize the entire structure as all
> > non-named members are NULL or zero by default.
> >
> > I wonder if the unnecessary NULL/0 initializations there
> > could actually increase the object size.
> >
> > With gcc 15.2.1 allyesconfig & defconfig do not change
> > either way but I don't know if all supported versions
> > minimize the initialization properly.
> >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202511071306.OJpTf7fK-lkp@intel.com/
> >
> > This Closes: url is not found on lore
> 
> That is weird.
> when I follow the Closes link, I get something unexpected - a "not
> found - look here maybe",
> AND a ../oe-kbuild/ link -
> clicking that takes me to the report proper.
> 
> If you retry, you can edit the "-all" out of the URL and it works.
> 
> It sounds like a small bug somewhere in the lkp-robot CI chain.

Sorry, this is a bug in the bot, i will fix it to point to the right
link oe-kbuild for these manual check reports.

> 
> 
> >
> > >
> > > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > > ---
> > >  scripts/checkpatch.pl | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > index e722dd6fa8ef..4b5e2e64dece 100755
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -1096,7 +1096,8 @@ our $declaration_macros = qr{(?x:
> > >       (?:$Storage\s+)?(?:[A-Z_][A-Z0-9]*_){0,2}(?:DEFINE|DECLARE)(?:_[A-Z0-9]+){1,6}\s*\(|
> > >       (?:$Storage\s+)?[HLP]?LIST_HEAD\s*\(|
> > >       (?:SKCIPHER_REQUEST|SHASH_DESC|AHASH_REQUEST)_ON_STACK\s*\(|
> > > -     (?:$Storage\s+)?(?:XA_STATE|XA_STATE_ORDER)\s*\(
> > > +     (?:$Storage\s+)?(?:XA_STATE|XA_STATE_ORDER)\s*\(|
> > > +     (?:MA_STATE)\s*\(
> > >  )};
> > >
> > >  our %allow_repeated_words = (
> 

