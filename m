Return-Path: <linux-kernel+bounces-741376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59218B0E35E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1A0547F05
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F5227FD4B;
	Tue, 22 Jul 2025 18:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DWjgBkkd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8A22E36FD
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753208423; cv=fail; b=apMxQpK7Y15eWyfg0jBgyAFnA2pzcYfpUyTdUiVX/M8WkM/+zBC8kQm0DM6oGx8fbZOSFWwnNshjufZtwijcYXZLPIXbgxrQWQM0bKL/l1dTWo0c78HlZ4rqj//j3B50W+HeJS9JQtuTrV369Sl+yiVCuTK1clXt6YJCZ7PIzUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753208423; c=relaxed/simple;
	bh=PoFPdY4M1QRGJLIAsxwvjJjURUe60I9R5KiWZOWJUiM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q/mUm2PpzrCRwlAgmOLvrK+We2Qk8kIRmUp/5QYo5m+wr9V1D4xXtx8Mkm16Jzt3FZ0/Jx1LCc4xryO517MShGxcAB78wfnv19uuoyuaRk++rdIsY918Q0OrRaosIUVnjv0xYgpP+FHTeBA+ewYehTT+dRLQsds0lWDcjxYSDUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DWjgBkkd; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753208422; x=1784744422;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PoFPdY4M1QRGJLIAsxwvjJjURUe60I9R5KiWZOWJUiM=;
  b=DWjgBkkdKb9aIpBH/TmBcelpGeZTibpLhRgUvs2Y9o1HDu2Ux5XnsKpf
   ONE8ZFlN27vz10a6U1N1biLwMLLMoGlQx2AMeJlP9FBo9R9t8a97PE/pF
   jQc4lZz70cyTl/BBsgkm4hegIjyoR5NsbttA/jCmVTrf8In5NDDgjci9I
   eh9WpIHn5F4giwho9d+/eApfqJA//ApqfSh4Y3MZOiNG94U4iCIBKfooq
   W4hT2A1PiDmj+iqZOTWKjahCy+1dpSlwXnv181Rh78qWUwgRXN1iaddLT
   Hdfvn++AN/koUUFYI0YkoHASjB9x1ussCgGlEEo55g0XrybXcntgzkrxs
   Q==;
X-CSE-ConnectionGUID: J9wCTw22SsaaNbzHZwtpMA==
X-CSE-MsgGUID: glXhVu2rQYWpK1GI/fRmRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55179389"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="55179389"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 11:20:20 -0700
X-CSE-ConnectionGUID: 56uLI95DS+iKmyao+AiE3Q==
X-CSE-MsgGUID: uesW/cryRNmI1VQhCSZ9dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="158512704"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 11:20:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 11:20:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 11:20:19 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.49)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 11:20:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vs6/t44Nx4iv6XCKPA2sjpXOpNTt7rO+Pim/gjPH/euF1E2cE5pcpwD+IBerLyBufCEyyjHN7Z2oyt4RqyJ8McxmRPmvOx9bG8d7vwnifKw9vwDnoHQN2izjZ1+OAzOg+t2qihgmN5WSDwOf8VF8YzpOzjoegY24div0F8FCnEldgIEaCdNLnaCFEAcxJ5W45+/lXKJj5ZXqm72Xypri7Zbf7b+ybpP03d9lJApZ86E29G0iaN7NYYB0Nkv5wUQPMHuzmYj8t5Rfgr00pchAX+TR/5wM5CB6R7KYyAFJ08TFrOkWAAty20pwMvWFJVYdY6qjgi5ZyW6RHhXzXW/qow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyFI8nFMUWVko4wn9koGO7RIyx4m/oeroILmuMJ1uRw=;
 b=Q3THXx+wowgB4UHZLq/EF9Q0hkMBZRd3kPmN1uNiTnON05Jjwq5EPQSiaLmnh0XPmSBI8XohnZtj+I3WqlIMqzUem8Y8YD5YLlk4zqZS2hODfFoLkw8wNSYORqERtm5PAMAyp4fegwmO0fDfmobcUO9sbYQ46BQ9yFLwoNuUAAEqnSfxwtExQeUxFd7e1rNJ5ikvyEUWeX3xbKg+Xwu7vxk3bQCQZJIoCRIfexPy7DT0vs/X7NeTKohglTbdCin/yMraqTXx6qEPDmXAApoUKZvElOAh+rnC1fCD7kn/uKhILwqvHoL5zcXdh41pXWQ6ELlV5IY38REKJ20yKtCaBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM3PPF4D011AE7D.namprd11.prod.outlook.com (2603:10b6:f:fc00::f20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.24; Tue, 22 Jul
 2025 18:20:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 18:20:00 +0000
Message-ID: <c4518fe2-dce3-46d1-8d79-cd63377bdcad@intel.com>
Date: Tue, 22 Jul 2025 11:19:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: avoid divide by 0 num_rmid
To: Barret Rhoden <brho@google.com>, Tony Luck <tony.luck@intel.com>
CC: Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
References: <20250721180051.3645697-1-brho@google.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20250721180051.3645697-1-brho@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:303:b9::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM3PPF4D011AE7D:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a524324-f0e7-47c9-1ffb-08ddc94c5eb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVpHN2dWOEhyRWgyWG0yVGF1Q2JvRkFBS1d5MzExRndQQkVTMWdra3RpSWlo?=
 =?utf-8?B?VEJpeE5iOWE1b3Bvay84U3I5NVBlbDRoQndKL1VDZHRHZlZuWEJOY0xBM3Bx?=
 =?utf-8?B?djh4UUluQ0ROVTZ4KzVuT3ZsY1RuN2hpeGpLaC9wZTZBMlYrdllPUW1iTHhq?=
 =?utf-8?B?NkFCS1MzMDZTYkVsZi9HRlFQNWhPZ3N0SHJRU1AvaUJGbkZuYUs3VGdadHRT?=
 =?utf-8?B?MlZjUmNIUGxHem9CQ2U4WEM2NjZnWTF1RDJydE5uNXVxdEpSUUd1WXFNWUNi?=
 =?utf-8?B?bVVSMThVTUZsMm1mT0dDaWhHWjhMaFVkb2ttM3FkdzZWZzlGbTNnbmp5SGM4?=
 =?utf-8?B?aEZNbE1Zb3pRSHNpSHVzWkw4TThRVTQ1blJURFBTYVZVUWhtQ0R0cHRTTHBH?=
 =?utf-8?B?YzBpZmUvZ0FQcWNEbEIrTUV5QzY5RVczdG5MNnJINi9ZMzhqWGs4cXlUUUU2?=
 =?utf-8?B?a0FsZDN1NkIrMFZJNGpxRXM5eFZLZ3hsUE9BYVhFWG03YVppQTdLSkpUeE1i?=
 =?utf-8?B?c3g4dU9UTXlRWjN4UnUwaDJ2RjVXSVZkbHpUUmNoZWpvcUNaVFZ1RTNuUDls?=
 =?utf-8?B?U1FIK28wNWRXMUlyeDd6RllWVjBiUTJuaFFMdmp0RmQzVDNHZ3RKTVIxUjRC?=
 =?utf-8?B?WlQwZE9mVHNoRFVWZ3M1LzU1R09BLy9DQnJncDBJWlRVUWlsMnBxcXhZajlk?=
 =?utf-8?B?bDg5YTRST2ZSTi9EbXJyWkt0YzFvMWUwSi9pd3lVMm9QdW50c0N1Znk2T05t?=
 =?utf-8?B?cVVLUGw2elNJam5OZEw2b0c5V2x1R2pmTUJrc3pMeEJjVEc3MVNBSlJBdDNQ?=
 =?utf-8?B?a0dtN1ZoZEFlZW1BY0p3TFBEaXNYQmJHVGl3ZU5CanBtYkpYVFVRalBLb29F?=
 =?utf-8?B?Q3JiWFkzSlBKbXlFNis1ZUxIZlFIV0l0VDQvZE1HVk45Mml1cU5yeDBWS2pR?=
 =?utf-8?B?M3ZoSTIwVnpjV2U1S2oyd1dlblBzNWlWN1ZwNmx2NWpTRFBpUXhHRy8xTE96?=
 =?utf-8?B?Q1RvSTVpLzR6NTkyNmVrUjJFRGVoUjRhRkVIenNaSlpoc052NXVoMkU0UGVK?=
 =?utf-8?B?UG1ldWNYSnFsWXRsWjN1V1BnN3RTQVk1cTdpVm1WN1JDMHhxeHIzdDVkNEtG?=
 =?utf-8?B?akd1cmVNUGxFSzkrWE4zdFhPUjZPUnkrVHVNQ1FXb1ROWWtmSThwK0tBU3Vh?=
 =?utf-8?B?R3UvbytzM240UGNDMFNGYjVkRUdPMmU3SzVqMlo2LzFzOVF4d2d3SERoMVlU?=
 =?utf-8?B?eHJmUUtvTElTUDY1S2ZlWi9COENGbHQ5QUh2MlUrbXlETXNSMGhNT2RCLzU2?=
 =?utf-8?B?eHpxcmNwTTllTVJrVkY0cGNMMDg2SVE4SVk4SXBHVFVHTmxNa1lETEdmTmRy?=
 =?utf-8?B?SUJLQWtqejI5TTJRYlNjNkRRaHNuUkFmTjlNWmFjdTFlZ3R6T04rV01mSTYv?=
 =?utf-8?B?NzN3TnZCVnk0NEozbVFLTzlrUVAxTDJ4NnRhalJlUjJUUTFXNlAxTUNwUlMz?=
 =?utf-8?B?VVc3WHpobGJrWnRLZmJSMGFMMlhQR3JJV3BHTU5qa0RFK21FZWlRRThqamNh?=
 =?utf-8?B?bzJVWnVqSmlyZWNBTmNBS01uaWNubkVZcG1nNDV3enFCZHpXekc1OExMeHJY?=
 =?utf-8?B?NDBUWmJ5cE9aVVVwQjBlYmVIQ0xYM3JXYk83Qjl1TytqVGRaZ2xwVGp1OTFV?=
 =?utf-8?B?QUJDS1AxbEx3Q25VRGxCVnQ5NW8rcnhyTWg5OEUzYXA2bXdzcGJjL0FBWDJm?=
 =?utf-8?B?em5kVmxncWR6ZlJvOFo5UlRtcjZzT0R6MW9mOHUzUDZIQzJmYm15WG1TWi9t?=
 =?utf-8?B?cE93RERTSk9XZ01jL01HQ2NMeitzTEo3bXJ0SkIyZXJMSTdGWXBDdzNrYWZi?=
 =?utf-8?B?QVpvNVZvWFhhSVp0aWhUVXVvWExmbHRNVGVOc3plRjdUOEQ2YWJaRThVMzlC?=
 =?utf-8?Q?m6pXFG496Es=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUlGK3QwakRkQmxVU29ZQTJtcndRNm9HSVllc2d1bVphRnNUbldOSUF6Y1R6?=
 =?utf-8?B?M3NCeWVnV0VXU2FPM1VFTVFPZ2JyOTlXZ01tZW1nV3NNMUVRQXhpbkpiN2Nj?=
 =?utf-8?B?SE1XeHZSWWF2SFdobGFaVGJ4ZllrMmxJK29taVhjcXFEbUt0bFBHTXZLU0VU?=
 =?utf-8?B?cll4TDZySUkrTmExZE5yTzNWbUtLZGx2dGdhTDhCV0Vpa21jQ2tRMUp4U2R6?=
 =?utf-8?B?UmVFV2NuQm12M0NvRU95V2dxby9YWDlDbUJjZi9UN0pvOFFHYVMwZldNSFJy?=
 =?utf-8?B?eVNzZkF2MlgwdldxQzRKMkwxQUVLcjZYY3VjeGtWaWpwalhRN2N6MkhQc1li?=
 =?utf-8?B?OHRXSExsSmRuUXpSbkFpVEVjakd6b3E5UGI5aGtQUDNkZmxUUzdrMG92SmZN?=
 =?utf-8?B?WDJSWjM4K3U0V1lodDVRNWMzQnkzTjllUmxWWEdoZngzTmw1SXZQT2h2b0p2?=
 =?utf-8?B?ZUo1MFYrWHVvQlJxbFgvZ0hsc2cxOWxvbU4vV2xtUWZwV2ZuMExqVFJ4WVlw?=
 =?utf-8?B?c3NwSjgrbjd0QkRhcUpEQjEvSWRheUNmSFVoK0VSS3BzQnN1YkRtRU5hcnpn?=
 =?utf-8?B?Ym5vekhzM1FieVkxYlk1NzFLL1hFRXBVaEh6b3Fxc3l4VXFnNUdPUDJvMlcv?=
 =?utf-8?B?bkl6WFZYUHlyR2U0L1Jvalk0NzY2VmE2UWFLL1pvUUk1RTJaclhmYU10Z3ow?=
 =?utf-8?B?Q0t1RllTZ2NsVFAwNDlNaFhyT3p3SlAyc0srVVdUQ1VIenQ3bTU3VVdoOTU0?=
 =?utf-8?B?RjFZaHNxMXR0TDBVVURpWXBNaEE1a1ZVbjA0MmtBNktlVFo2L2dnbGFIWGJG?=
 =?utf-8?B?UXBrWFJHSVEyd0pUdU4xVFFDNVlBYTUrdE5iRC9vdzRQcmlvT09HcVByTmM5?=
 =?utf-8?B?SG15RVI1dURWR3lYSUVaVHQrTGRNNHl6cE1TZjkwa3hBMDd5OHlzNDBRVUVX?=
 =?utf-8?B?aFptb1d6amhpNXVzbUZFMExzM0ZLZjlYWFl2Z09Sc3pJWW5UejBkVmtSR1l3?=
 =?utf-8?B?YzVXWjdKVEUvbWtrV3NjWmNGRzE3ZGdFNjJjdWdMOVVKYnVIN0tFUjdTbWRP?=
 =?utf-8?B?VnNuQ1o4TFpRbE03L1AzYndWVGx3QU9lVGkxVVVuSXdMZnJOYjZrQ01ISHND?=
 =?utf-8?B?cWtIbFVNM1lCWnVOeElVaFRpQmVWNENxbDB2eDNQTFdqMUlXRUoxYzFZSlY5?=
 =?utf-8?B?VDYzMHNHV3hzQmJyaGdnY0NNbkhGd0hZNjkzMlpTYUxQbkJrNUVHeWRBcUkv?=
 =?utf-8?B?eHNlV0FaQ3RiOGRoR0UyUndqYUc2djAwdVlyZWxxdzgyTkVLY3pveDhheDNa?=
 =?utf-8?B?aVhVU0FUc0hNNFZYYjhaMndmNjFwRjROVEhMcU8ycFpKVTNQNzhWbExnS2c1?=
 =?utf-8?B?ZFEzRVV2Zmh2MkFXUTFHTzl3V28vdHlHV3FoU20walZkdXlMMzBXbVBXa3k2?=
 =?utf-8?B?c0MvTW5XdXRLRGV1UHFka21lQ0VleXF4Mjk2cXc2cG10QzRMM2RPK1l1amJm?=
 =?utf-8?B?aVAzLzRyTDlBOENZV01YUEUzWG80UWUwNVRBZHliQTZSWFNIRHlGcVJvMzlM?=
 =?utf-8?B?Q09paStPY3BZems1b3Z4Ylh2ZWZUV053cEFzNys2VHh1LzJ1aitPeW9tS2ZE?=
 =?utf-8?B?T1VXT1dLY3pJdVE1aTFwUUUzUnkvMlBlZU4yVlNsYWFGRmY2SGp6alNrTzZF?=
 =?utf-8?B?SEx3TTBHd2UwNThwTU5iS0V3NUhwSEVrWmFnR0JIeXlyWGlhQWkraU80WG1z?=
 =?utf-8?B?RkcyU0oxeG9Za0ZtU0lrbWRDNGNQZVJUUUlaYzZZSXpsVGZBSEdIZVRSMzNT?=
 =?utf-8?B?VmtDVUcrZVl6MEF5RFRKWmN5MXpnQ0VOaVRzUDlqdXRqM0FURmJ0QVVSWW9Z?=
 =?utf-8?B?eDJkeGY1U2JHeVZuSXRJRzY2SFFsZFRadG9kQmVqdWhIYVpXWGlJTThZeHlk?=
 =?utf-8?B?aVFPMk94djUyNkV6bndLOVpYdHgzYmxmNnI2OUxnQ3lZSUtsbC8wcElwblFy?=
 =?utf-8?B?VWFIUEZwTlExNWhJV29pRGF6K3JmanFjU1RMcVFhZGFldWZoTGtCUlRGVUh3?=
 =?utf-8?B?a25BbGdSWVhyYk4yWVRZbStRbmNnU2N0VzdYSzFTbnhxU1diV21OMTllSEFk?=
 =?utf-8?B?bU02U0FqV1ZMMS9tWVU2UHZla1ZBNTZrK2RIbTFaa3JrdFJhbVdyRW9kL3gw?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a524324-f0e7-47c9-1ffb-08ddc94c5eb2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 18:20:00.1630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ak/j2wFYZZs46+dcsS6eBm6ochJ+V6PUY3c9lfmT1/9lMhzFVRpb1oUWb6iXog5Qhgm5q/Izc49TVTJAn5D8mZFm8QiykNuea9l5+cDRUTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4D011AE7D
X-OriginatorOrg: intel.com

Hi Barret,

On 7/21/25 11:00 AM, Barret Rhoden wrote:
> x86_cache_max_rmid's default is -1.  If the hardware or VM doesn't set
> the right cpuid bits, num_rmid can be 0.
> 
> Signed-off-by: Barret Rhoden <brho@google.com>
> 
> ---
> I ran into this on a VM on granite rapids.  I guess the VMM told the
> kernel it was a GNR, but didn't set all the cache/rsctl bits.
> 

The -1 default of x86_cache_max_rmid is assigned if the hardware does not
support *any* L3 monitoring. Specifically:

resctrl_cpu_detect():
	if (!cpu_has(c, X86_FEATURE_CQM_LLC)) {
		c->x86_cache_max_rmid  = -1;
		...
	}

The function modified by this patch, rdt_get_mon_l3_config() only runs if
the hardware supports one or more of the L3 monitoring sub-features
(X86_FEATURE_CQM_OCCUP_LLC, X86_FEATURE_CQM_MBM_TOTAL, or
X86_FEATURE_CQM_MBM_LOCAL) that depend on X86_FEATURE_CQM_LLC per cpuid_deps[].

I tried to reproduce the issue on real hardware by using clearcpuid to
disable X86_FEATURE_CQM_LLC and the CPUID dependencies did the right thing
by automatically disabling X86_FEATURE_CQM_OCCUP_LLC, X86_FEATURE_CQM_MBM_TOTAL, 
X86_FEATURE_CQM_MBM_LOCAL, not running rdt_get_mon_l3_config() at all, and
not even attempt to enumerate any of the L3 monitoring details.

What are the symptoms when you encounter this issue?

Would it be possible to send me the CPUID flags of leaf 7, subleaf 0 as
well as all sub-leaves of leaf 0xF?

Could you please also elaborate what the impact of this issue is? Is this
a VM that has been released with many users impacted or something encountered
during development of this VM?

>  arch/x86/kernel/cpu/resctrl/monitor.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index c261558276cd..226dee05f96e 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -359,6 +359,12 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>  	else if (mbm_offset > MBM_CNTR_WIDTH_OFFSET_MAX)
>  		pr_warn("Ignoring impossible MBM counter offset\n");
>  
> +	if (r->num_rmid < 1) {
> +		pr_warn("Invalid num_rmid %d, cach_max_rmid was %d\n",
> +			r->num_rmid, boot_cpu_data.x86_cache_max_rmid);
> +		r->num_rmid = 1;

I do not think enumeration of this feature should proceed/succeed if there clearly
is a configuration issue.

> +	}
> +
>  	/*
>  	 * A reasonable upper limit on the max threshold is the number
>  	 * of lines tagged per RMID if all RMIDs have the same number of

Reinette

