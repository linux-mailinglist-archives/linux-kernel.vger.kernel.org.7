Return-Path: <linux-kernel+bounces-760335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83238B1E9BA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2113A6EE5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC639145A05;
	Fri,  8 Aug 2025 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y4rtVRTw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFF212CDA5
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661555; cv=fail; b=hRWePNRfvwTTEN0rCBlPkwAUEfykCJogBO1gPvXNd8PHhyDrMbF8GrIPd1z1mB1yLcHO+sS47W7QyELYk+Syosz3SN1GAXGuhKy3QmLKkVpzd7O5oYc7YCGuSUqh9bOfClW3aTAaHcAIzkaRV5b0b2F0CzCSe9SEj0TCxbOUtcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661555; c=relaxed/simple;
	bh=imuHdRBJDDQ7bWpPhdnC7dy4MWg8sHfkD7Jn8AxKGG4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QyAmnUhE+19EaVsxGAXxaDn/OZGSBKxhoS1gvZH+Oyvv/Mua65pCF/rxKIcfu9JwVrbrbt1J1d/Kn4WYP7H6UXw9iJSRQdom6nkQyMCwpyIcOvRnJ1DMhVyjNdOwqlPb2zxMb6aJkYR97iFDDHBIbBLtCVjQObjCk/E/sBHL4Ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y4rtVRTw; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754661554; x=1786197554;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=imuHdRBJDDQ7bWpPhdnC7dy4MWg8sHfkD7Jn8AxKGG4=;
  b=Y4rtVRTwwauJYCU38+fkln425+igzF/DV43J++hH5q70BIjCTNAxCb+U
   0ytKP3+HnyF9Q6l7A4n75aKjT/nAmZO0F8eu2A+skfYHdQ+dmHfXlPVd8
   VKaZWtC+0Hv8C0xpWd0MNKl2YRSi6M/0HDdKcyWS6GK37uhSGz0wHmboT
   vmOGPXAmulkobxzp3HoEwV6wDVyxGoDN6vF1kO60HRYwbtKr7mmCSSrc/
   LPkpHl5IThCfPscCkUdpr8XfD45gWhi1/oaTxQB/Yr7rbWOWWEAMhzvaf
   VxcuOw9laEx+Tvr3IDJ6rgJODwCpDURu5aMx/hWbJLAaqEbJV/J8ukp9q
   Q==;
X-CSE-ConnectionGUID: E/CRDTbQRBKCAu2Cy0Y11g==
X-CSE-MsgGUID: MhIeNeDdSZ6Cj69zKYaj0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="68465252"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="68465252"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 06:59:13 -0700
X-CSE-ConnectionGUID: L6aWGGiHTuKcoO69XJfYiA==
X-CSE-MsgGUID: eogAxw1BRfOs6UR2uk+RzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="169559867"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 06:59:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 06:59:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 8 Aug 2025 06:59:11 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.88)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 06:59:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duTjzkDiGDMUPpRGw5TwfiwkTzmCL7JzH/DjjOodmSDxhupC95gG2VBe1dwnuQBRi/zLt0y1c5IkXv1t/lJPYkjmYS1ZC323IVOnGOMe1toXnNCFp2xyRAdDEqSxmnvQ96MZFPXlS/VAUtGqWIeIY0fhqLW+xIp5v2EMgW2q6jDQ+3DAN70WjnHEH5ykUjkREY1SRlKOY61vKQGa72IsmtdUM33YoSpWTHPvqsfIFvZ8jgBPe0x7nWoYRjMcIW6o1xeyQurM/M73FPC6SOOQReJOY7ZbtSfQqzIqh8PklVA+Te7hGzKvqS433rwvSXlBdetnTxm4dGmWPA1t2QyN7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4lgA2QK98VEGsEKbrprbLaKut4vm+tv20IYHcmz3FM=;
 b=xJy5Y1Nhz2kMx0hW4vL/CTHm9f21pX+7LcO10iQM7iwuwSTWiisdFT1xJZtr3IalVZFpW1Nh7UMG59/osy9F7fnVSjzd3hQrs5fm+UEnKHBJ9D0wou7NWftlYWOUWzdNaneouQtPlBymys5q2QprdQ02B2htCvSqJMg0ZlMNlmti0SfsBqoNl5HdpsZCAMMLzmDdJpaae9tsDm4sDUK/jJKAExRxB5JbMkWhZPp+T514VM6IySL6A8pW9/Jxx9wDQj0BCLq9C9OVhUh5FG39TjZqRjb8GV3kKpx9xaJIGLBpvO+5QkyxhK299UhNKvC7LC2IufHtMXVUUxRveWO1tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DM4PR11MB8204.namprd11.prod.outlook.com (2603:10b6:8:17d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.17; Fri, 8 Aug
 2025 13:59:08 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%7]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 13:59:08 +0000
Message-ID: <e46bab92-ee1f-478f-8076-d46bd3fe9411@intel.com>
Date: Fri, 8 Aug 2025 06:59:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] x86/fpu: Update the debug flow for x86_task_fpu()
Content-Language: en-US
To: Oleg Nesterov <oleg@redhat.com>, "Lai, Yi" <yi1.lai@linux.intel.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>, "Borislav
 Petkov" <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@intel.com>, Sean Christopherson <seanjc@google.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Vignesh Balasubramanian <vigbalas@amd.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, "Chang S . Bae"
	<chang.seok.bae@intel.com>, Brian Gerst <brgerst@gmail.com>, Eric Biggers
	<ebiggers@google.com>, Kees Cook <kees@kernel.org>, Chao Gao
	<chao.gao@intel.com>, Fushuai Wang <wangfushuai@baidu.com>,
	<linux-kernel@vger.kernel.org>, <yi1.lai@intel.com>
References: <20250724013422.307954-1-sohil.mehta@intel.com>
 <20250724013422.307954-2-sohil.mehta@intel.com>
 <aJVuZZgYjEMxiUYq@ly-workstation> <20250808074948.GA29612@redhat.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250808074948.GA29612@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0345.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::20) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DM4PR11MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: abf3a292-2aa6-41b9-8cd0-08ddd683be7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGxjTWdISXhxNFhrb3FpRm5nY1JpRUZIWmtpVDZYMkh3NXZYTWNPbk9TYUk2?=
 =?utf-8?B?eXVhaDR4WUdmNkZPdHVrUG0yUVlnNGJHYTIweDRVMzJ2L1J0Z1lrNUs2cmg2?=
 =?utf-8?B?d2FJQ2ZFcUtYc1B2YllrdWI2aDJVT1N3c2pTYlFpdUpHakgwWlpvbW9RQnF2?=
 =?utf-8?B?aDV2N1RBc0I2d0U0LzFTbEdtdnNjem9vV2JIZHZVNm4yTEUzMTNGcXRiNEZ0?=
 =?utf-8?B?WkN5YmJKQUVHVXpDSnJGVWtROUNJQ3IxMmhxbmVIWXd1ODRTdXRHR3VSd2xI?=
 =?utf-8?B?T3B6Z2JGeURwc1M0OEZPQUhidTZhSExYVnExaEhjNXdFU2c4bWdmUjlUbFRj?=
 =?utf-8?B?N1pjcHhtZ1M4b0k3ZGMveis3djhBSWZ6aU9EOVc4VUEvVW5WeVN4c3dQL2Fn?=
 =?utf-8?B?ZTF3Z09GRzA0cXdmSVNFMVlIY3R4dTBJMGpGQ0JXSE01L3JPY3VPL2ZXU1M1?=
 =?utf-8?B?TnpvOEE0QllLU3F5UWhxV25RRFdVOWpyR3h1am15WnVmbThOdGtxenRINEVj?=
 =?utf-8?B?UVNiU3dORUpuSHFwUW5IZmRlL1k0QzJSM2FMa2REOVIvNjVRU2ROVUVtbk44?=
 =?utf-8?B?SXhKTllSRzdwTXNLb05mZldVODhWd24wY0FBeUtZaVRxOXExblA1VXdHS0NW?=
 =?utf-8?B?bXVqU3dseGZOK2MzTDFOVGt3WWtqUitwRW44aFpuMTUrTUdXL09uWlYwT2lo?=
 =?utf-8?B?dmNvK1ptcVNXMFZGWGlsVExCNTBOSDRVdk9jM3FOQTRWRloxejAyVjZPMG00?=
 =?utf-8?B?ZU9RRmpoSXdFSDcrWS9URlM2bEVrL1QrUk0xdnBTQ3BjQTdCbFlTbVh0cG5P?=
 =?utf-8?B?Mm5OUUhpYktsaFpmOWJLOUxEZHc0NFJaNkhtUm55WEtpNlpWNnVsQUYwZ2tW?=
 =?utf-8?B?WFJ0aWRKZllCUFRpeXNxbTUvL2RwUDFYZHNYWUwrTDZkRVNFS1B5UVpPb2RQ?=
 =?utf-8?B?a0xMY3JFbVFIN1N0d0FzUnhCaEJuZFVEaU9sSUVyeVFjdmJmdUVPajdobmxo?=
 =?utf-8?B?bUtZY2paZGxCRmRSSmNMZ0F1SmF2aEZQYkQxS1BmTGFTWk1BOWJzcUR3a0Fq?=
 =?utf-8?B?bFRNVGxxbVU2Kzhwd1plVnJkcCtXN0VZR2pWOTN1bGE0WGE5aUdMNUtWRGlk?=
 =?utf-8?B?ZWd5emozclQ2UFZ2cHFzQ0pPSCs4YjJoeFZSWUpWTHV6dDhOaWxFS3RPYmpY?=
 =?utf-8?B?MEhwN20vQzNLc0RweWZpZHJqYkZaK0gyTUFYeHdoaFludVlBZERBRkhNSGht?=
 =?utf-8?B?aHIwN2RLNFZQSkRKQ1p2SG5kcHh1diswMGdCdTNiMUdnaU5CeDdkTmh1dHZT?=
 =?utf-8?B?VEVIdndaRUkwQ2xGY0oyNFhsak5uekFGczB5b2N3NHF4aXAydXoydHNqUXBV?=
 =?utf-8?B?UFUxNVFzLzY0UVJPYmFxWmlJQnFWcy9nV05UZjI1Zk9LVWVTT0kwU0lSdTZT?=
 =?utf-8?B?UTlTbzBFU1ZDeVFXNlZ0R2xIWC9BU1NsUWFReVFybXhmNFQ4ZmNFWUVqRUIr?=
 =?utf-8?B?K2JpamZpVnlFN0tRR2hTWGZpWGUyb1hpR2R4aEZrNVpIUEpZanVZUUVGRTVx?=
 =?utf-8?B?MWNqOE5uQnN3WFZpQlRSdThqQ0VsckFrVWFaT1NrU2dJUG1nOVUwRjgyK2tw?=
 =?utf-8?B?Q3BLYUxUa0dKNnRGWno1U1M2RGJ0M3Zkb2dXUjBqTWZZUXE0Y3JvSnRKQTZX?=
 =?utf-8?B?aGx5WHNzNHErVy8vb1RNVU9NK0xTQ0lxK1hWV0MzMnpFVXlEaTk2a1Y2TzZX?=
 =?utf-8?B?UE44a3dXakxOdngrNGZmTWFjc0wwYStmUXJQY1RlRXpZS0NoR0VtMHowLyti?=
 =?utf-8?B?U2hlMXJick9oUFI0UHNBNHJGYVRwaUxDZTZPWEE4MXVpTUNDdDZ0UUxBeHFZ?=
 =?utf-8?B?SUVFNjczMzM0dVVoZDFHV3Y1cGc1SWkwUUpjZzRZODM5YkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnE3RnNWUGxWdFBUMzFJWGdoU0hHVVltQ2tobFBYSW5TaDVoRU1VcDJ2MTlN?=
 =?utf-8?B?WStvcGhiUGdwWkx0UnRtUzRqNjhBdkNBYnRKL3hMN3VDTERTNVJicGlIa2Zm?=
 =?utf-8?B?c1NWWnhjcGdEdWlkYUR4UXhVTVdLMkFrRU1NdkRTYWJpQnc2eXJkOFc2d3lE?=
 =?utf-8?B?YW14bDVQbm1tQldJQ1pCMGl0ejE0dXh6RlFKbzdRK2x1RmIwWGllcnUrcVFn?=
 =?utf-8?B?aVdqaUhYQWY1cytqMm9Ibmd2V2ZlK0grUk5HTEQvMWRHZnNKdFUyUTNxb1hC?=
 =?utf-8?B?dEpqZC9BVm9hK1ZYR0I3U2R0dVhBdGh2ZWJsMmdQWEdMMnFWdmZzMWtCNWcr?=
 =?utf-8?B?Y2xFSkx0OFNZZ1JEcXorcGdDTmVwUXZLbFRoUzZaZlRTMU16ejFQOFNDY0Vu?=
 =?utf-8?B?RHFwcFJFeGs5eUdZRzB1TWtPNWFZeE5lOUxUUnJaWkdXMWpubUowd2hXdENB?=
 =?utf-8?B?MkZDZnlRQzBZelRFT2VEemplWGlOUm5yZ25kMElDNEdRVG5ZalhJUGFpcWpL?=
 =?utf-8?B?WG1iVWVFWDRlMFFnM2MwTDdOK3pWSFV2aWl2eDFiTC9oaCttczNkeHVVREhZ?=
 =?utf-8?B?OGhkWGxmRjJGd0t4Z3FLL29FRVpteTNUTUJCSHc4eDJERjM4K1p3aGdiU0NO?=
 =?utf-8?B?bjV5TXFDYVJyTXB4SGcvUk9DUUpJT0VTRDdqZ2FpUlpRdXBBN3RyUG5jSnh5?=
 =?utf-8?B?UFNYdDIrVVBWSCsxbFRhSzVCZ2Rxcjd1eHdkNEMzRlBna2ZXZlJPMW4zTXYx?=
 =?utf-8?B?V2R2MkVLUXFUdXZrOXRIcTRaOFdxcEpIOS93akZUSXhXMEFEdW9ZN011MFVp?=
 =?utf-8?B?WnptL2lJbzR5Z2wvVE81YnFFRERjSUlTR3kwUzlNUklMZGhwS1dwaW5JMmx6?=
 =?utf-8?B?WXd5dVNNRFFCVFF2bU9QanUwYlY3MVFOSUlwR3UydHp2VG93SlJwWkZ0SUJr?=
 =?utf-8?B?NTRnQnpzTnVpeWJBMzJRWmhYTlBoSTNOdlFxRCtVL3E1dVh0TXRDeUQ3RWZi?=
 =?utf-8?B?RDNldW56MG9GRXpOV2ZpWUN6RWtnREF6Z3dyTmZwc3ZENm5VZGhrTnF0TlJa?=
 =?utf-8?B?WFN3c295TTFwdy93SG84Z3BBNFpNVlNRZ0NId1YraW9FS0tZalNoeTROa09T?=
 =?utf-8?B?dTdHa3RMbklLSTdpQXlnV2I3M3owVlZFZDE5alVFN3RGV0x0dytIci95Yk5q?=
 =?utf-8?B?YmluMkYrMXFEMUFRbWYrYmlQVFdUd3FERmREcUkzUnhYTXMveXYxUlNlaGJw?=
 =?utf-8?B?U1ZZYXB6WkpiclJTTG52ckpIdkNhWFZkSEFNUjFQaUVHbmYrdEtFV0thOTln?=
 =?utf-8?B?TUdmcGdmS1NPTXlJRUlPY1NDOUxWOHlXcGE2aDhCd2ZOaEo5VHdScWxxTWRk?=
 =?utf-8?B?ZTUzcXZNRFVQM2pBa1J3MFMzN2lzWkZ6VmlxckdUWXF2OCtaMXNTOE1VSjVn?=
 =?utf-8?B?OTZIa2lXYWwwMDNTQ1R6ajFLTHhZTU9aaGNOSThuZm9SenFFa0JFaEsyQ2Zp?=
 =?utf-8?B?d3FIeGhnYVRTclM1UkFWQmFFQXRWS213VUJVeDduOEdhRDZSYmd0TFR5NTRB?=
 =?utf-8?B?Q0IzSTlTV1ppWEJQemRyTG5xYmJrOVo2d1IwWUFkWHNZUmpySldwWUQwUnls?=
 =?utf-8?B?NFVLWUQwUERYQkJYU3cvNUVRY1BDL2h1Q01TQlhwUGxTL29LZzlwZC9vQzEy?=
 =?utf-8?B?SHZYUHdtTDNmS3JBejA2RzZCT0Npb2tZMHJUOStyOW1DeXZmOXFXdDFwSXc4?=
 =?utf-8?B?NG1lWjBUUDdlazNjazZ3L1N1UW9yamdhK0dHSktxWmUvZWVFWWZUdWgvU3Zo?=
 =?utf-8?B?L3RCNER3WmRaUnNSQ2ZVZXQ5ek5Vc3dYZlMrM3lyMUhUbmxVKzYra3lYOHVH?=
 =?utf-8?B?NjZOUld5dVpaRUU4bkhodW9GYUpDU0RpQUYvcWx0VWxoeVcxZnB2UzZGMGQ5?=
 =?utf-8?B?ZTdpUmFWTXhXRGFUaENJSy9pbVBkUXkxeEV3OEhQejFtSTduWG5hUFBKdmlp?=
 =?utf-8?B?TDFBbVhsREo1UXU3M3U1WDVFMXNldzB5RUhWR25vWWdGWXNFMHhmYmV6VTVD?=
 =?utf-8?B?Q25MWEVFalZWd3drU0ZITzh1aCsvRVhQeFkrd0lwQjNmTjN3enJaMTJ1KytT?=
 =?utf-8?Q?mU94GJV9V0Tfcadtz1DBmhQJJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: abf3a292-2aa6-41b9-8cd0-08ddd683be7d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 13:59:08.2624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWVO3pYkySUZfa29x93EE0iXz2pmQGMlFG7grM0HOvegLLtQpbHySpTa0yVQgo51Gb2ByFW3qmL3rBeqapajMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8204
X-OriginatorOrg: intel.com

On 8/8/2025 12:49 AM, Oleg Nesterov wrote:
> On 08/08, Lai, Yi wrote:
>>
>> [   17.474769] WARNING: CPU: 1 PID: 731 at arch/x86/kernel/fpu/core.c:61 x86_task_fpu+0x76/0x90
> 
> ...
> 
>> [   17.481244]  xfpregs_get+0x9c/0x1e0
> 
> ...
> 
>> [   17.485304]  do_coredump+0x370e/0x5060
> 

The warning here is mostly benign, right?

x86_task_fpu(target) and x86_task_fpu(current) wouldn't match, causing
sync_fpstate() to return early.

However, independent of this warning, can xfpregs_get()->sync_fpstate()
be called in the context of the PF_USER_WORKER thread? Would that be
problematic?

> Damn, I was going to check the ptrace / coredump paths but didn't have
> time and then forgot :/
> 
> For now, I think we need to remove PF_USER_WORKER from x86_task_fpu().
> Then, we add it back later.
> 

Adding PF_USER_WORKER to the warning is only proposed in this patch so
no harm done yet.

But, I am also skeptical about the x86_task_fpu() warnings. We have
"struct fpu *" comparisons that seem to be getting flagged but should be
valid in principle.

> It is not clear what should we do if debugger does xfpregs_set()...
> 

Yeah, I am wondering whether treating PF_USER_WORKER threads as
equivalent to PF_KTHREAD is truly accurate in the FPU.






