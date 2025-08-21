Return-Path: <linux-kernel+bounces-778980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853CBB2ED78
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E8867A508D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2BC2264D5;
	Thu, 21 Aug 2025 05:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WhSbbIWo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F12636CE13
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 05:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755753342; cv=fail; b=PmMBx1NYNTaWq8gkg/pQNRW9qq3aTYaWrnA+8iNzyx7hr4CTjCrZb40NIk2aupPbKYqjujA3szwi+mEXAaBrmUicApBVtrFT5gtJ1spKDcXpPflzDImtxl4l4AYkp9zsYvkyAOSc5xTjdKWYIVQnlvo9MTw8eWxfaRPdzdJhJpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755753342; c=relaxed/simple;
	bh=AYWIKZOr8k1jbMgSFBBrjRWhNp1okLGv4Of1jdVZLlU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NMO86Z8blMAWyzpbc2XgMYz2NqsR/JMikFHjZPtyCwh2k3LusS2AnRn+2e/NQ0ntpnxPm1VdFgQnEeE2J4sF52e8CLswg8KU5lNe+xW5VDOdYS5u+JibJPO3TwsHbtcI/QQl2pG5e0txZhXD97PBtgST21M9Bu4zoO2/CMB2VFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WhSbbIWo; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755753341; x=1787289341;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AYWIKZOr8k1jbMgSFBBrjRWhNp1okLGv4Of1jdVZLlU=;
  b=WhSbbIWoReDr2Jj5ioMU1ZbZZ5H2GTR/xbMseYuP9eLlXCtRp8f/k8ux
   DBWBtXDt3KKvrPUHTX9j8A33yycsGiNDv/znbIJEYpKXurxuc49ZgOBuc
   4ZS09Fll43wTFEBkYKtEU4sGyZ++tNWA7iP4hdMUvUW636f0pQFFnOZ2d
   2QrfulaASn2yFtuX2wR1zZIh/n+Is/pIA2mlw+ARKKP9mgeCmZ0TXL5Rb
   qZD1olXKSZM9m2NBEy116KMBtIoiCdIg+CJ8IHqCT5wpqZlK1vAoE7g9z
   ZchyJW1Ic8nFnKK37h/cwwKD/Ja4htwiYn2e0eYuVFUiJIfzzdd9ZRPvO
   w==;
X-CSE-ConnectionGUID: aP1wdTI1RA2x/iNQ8oSeMw==
X-CSE-MsgGUID: vDK5NbGJRmizvFnptvQB8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="69474071"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="69474071"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 22:15:41 -0700
X-CSE-ConnectionGUID: sCVzaW8LSYS92UUYUWbCwg==
X-CSE-MsgGUID: iRYMS6usT2GYbeEWxokltA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="173580898"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 22:15:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 22:15:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 20 Aug 2025 22:15:39 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.66)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 22:15:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2ZjYuWu+heo9J/03gsQi8rQCZq989hkD8GTUfeSYLAqjPwCM4FTLaRNdV1PIIsZKZQnpem/fT37Y38P7CWokg4Q2v1BNmdT7ZPet2d5fy8XpnI2Il/wEclJaI0kbO6BCZ3SNe4gY0a3aCmDrlvABO8+a1Q6KhE9du4FHNANhHwljLKWWQ06n0pGiBW3wanv5GpssVSgr6LUKCr7SgVmBjOMZaSWtjWYlHco49QzCN0n/QBODp0kzv+EfMyO2i7OzboidJn3ziI4YrsdMyTP/QgWNoRPW5C4JlhJLjqTsz2PAHegkaEPClhBh1r/YJ0takMSUj1ey3rMy0w9fFhjXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OikwGQs3tyOdsoewz/LH2k7RJD7m8Y4E/qQ8XxPWIfk=;
 b=uFDsl+gFtfIn8hUCy9Xe2lKZhtvzhQo9zS/Dr6NcB0s5FDiyRPvo700898Ij06Sn9+eeU+0ksATCvOM6WGoxxWpeJ3jU5eB2won6/gcaDb88gHwGLdQfbqzWNZ6xPEduzfhZ983VFQF35eQ7suWLcg5OlBU2RPvlG3YzxJNg4SLLOn55vXD5UFT65NSa0PnLKRZa2ZPMbJvsnslDczthAK/SnscjOC0PV2siCX+WBOH64q9J4Q/gORBdrY9lkFjik5YZN6YNisSfvBMbT44jBFnc67CHImj9Ef7p/5gMhtdnzmRkKg9CPx+Jmf9L5pcL4vLnCWmNBEp+CpXwzftBrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 LV3PR11MB8458.namprd11.prod.outlook.com (2603:10b6:408:1bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Thu, 21 Aug
 2025 05:15:37 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%5]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 05:15:37 +0000
Message-ID: <d5e7c902-5bbd-4efd-ab7a-c1da19d573a6@intel.com>
Date: Wed, 20 Aug 2025 22:15:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v1 1/2] x86/microcode: Add microcode= cmdline parsing
To: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>
CC: Sohil Mehta <sohil.mehta@intel.com>, LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
References: <20250820135043.19048-1-bp@kernel.org>
 <20250820135043.19048-2-bp@kernel.org>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20250820135043.19048-2-bp@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::15) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|LV3PR11MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: 18886855-7efd-4a18-b30f-08dde071c338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnljbC8zYnN6ekdGVVJQMlp0ZWFEMUQrbUs5c3MxSWJkVFYrMmwrdHBWZ2cx?=
 =?utf-8?B?QVduUFZETDRKZnljRmJiU3RwT25wWnZnQllPUDBDTEpUU3R4ZEg3YmEydFNU?=
 =?utf-8?B?bHNtSGZsVUZ4TUhvSmorQmRuc2NsYXhwaFplaHAyR0E2ck1Fc1V1WWFtLzdj?=
 =?utf-8?B?QmRLWWdaV0VmZS9TWWpVVHMway9LNENFYjVUOXVZQzVmMFVNMTRETHM5Slpi?=
 =?utf-8?B?ZHJITWxEWVZNU2F3M1pvZkhlV1ljVG5kdG9rYUNzNTZPRlZRTzJWME9TNTVi?=
 =?utf-8?B?QjZoTXpkMXRjalhscEdLU24xeXAzb21Ka0NKTWQ3TGtqMVoyckx3c1VHR2J2?=
 =?utf-8?B?VStwVUZNc25xUVZaa1dmcE9zTDZVWVp1ZFBsQituZmQybFJLUGlYRFRQRlhw?=
 =?utf-8?B?S3RocEYwUHBHakhqVnJPRSt2TnZHeU9HK1c3TzIrWTE0cHNmZWh0RWlRTEkx?=
 =?utf-8?B?eUdoazNBa0JkZWRNeGc5RWoxSVVCQzlCekR0UCsvT0I4S2tRUnNGSGM3Y0Vz?=
 =?utf-8?B?NzJYZ3licTVhWHFBNVBTbDhQTVJUckhwOU9DcDF3aGVPamtiRWNvYWRpNmZY?=
 =?utf-8?B?a2c0d3NCcXd1dlAwSjlsWFVRUEJLL1BZNElxUEFsSkZyd1VDQTZlRjNlOUxH?=
 =?utf-8?B?bDFtR1FPLzhJVlBEeUk0QnhDaHdHN3BUYXZWbXVDQ3JnSFk3a3ptYVdvZnRY?=
 =?utf-8?B?M1BzVXlhZHhLTzl3RDE2TWJGbm1jZkNDWUFOdXpuTERKcHpMaFNSbnFQUHYw?=
 =?utf-8?B?RlNkZDcrUUQwOFdKeVlQa1NQV29TREZCeUU5SGNDL2RlMXh2U1pYdE0rUzJu?=
 =?utf-8?B?aktTRVZ1bHpxVjF6cmtodWM2K1NiRU4yczlZN3U3bGxaeFRjdGRiTDRpa3A5?=
 =?utf-8?B?OWxjUDVqL2ROSHlKd21VaytidWxtWFNtRS9tc1p0bExlVysyRzRwUzJnOUQx?=
 =?utf-8?B?cmlYQi9GaXdCY2lkTVF5VE1MQlNRbVdVRUtXWUhPajlwdVdyazlkU0lZTmUy?=
 =?utf-8?B?a1hMN3R3WXY3VWlSWDZwSDFBMzR0R1didzJNQ2VXQ29PNGZ4SUJVTFE2R3JZ?=
 =?utf-8?B?YVdldWNMbi9YVzBGRExYd1B1cFI1OU5GUlJIZ0RkNUs3aHZyWXdORTNvLzJQ?=
 =?utf-8?B?WUx5b3RnNW93Vk52M1RhNWllTzMvY1J4UHZOMy9tS29sOS8vYW5rYUhmZTRv?=
 =?utf-8?B?YVVCcms2L0FWN0dhYzUrU1UyWXRCUHgyVnNxMCtENXZLSC9TUVVDc0tpZnZN?=
 =?utf-8?B?VEVsUTFwcDZYM2p2THdVZ2NWdWpkMTFBeDg3V3Q4dFZIT0RKRTMra1A5V2ov?=
 =?utf-8?B?dTNPdTYxRlJJWG9TQU5iU2hLRERodEpzL29CU2xRVENJVDdLWGVoWkFPaTlE?=
 =?utf-8?B?TVFxVDFWYWJIbFV4MkdTZ1JaRUhLRzRZR1NFZDhCYytERTJHL2VvOWUrYXZk?=
 =?utf-8?B?NmxNSjV6ekZ0RVh0cjdEbWQ0MEx5ZVpnRFdvemVXNnZTb0xEWnJacVZhQWJH?=
 =?utf-8?B?QndWVVYyUlNXeXF2WDc3M0xqWlF6ZXhodG5Gay9iZWtJMU0rb1RuS1NPbWc0?=
 =?utf-8?B?SFphK21FcmpZRDdDWlQ1cVhLTnFlUmkrZUlUa2FQcjRjMEpScXpMUkQ1elpL?=
 =?utf-8?B?ZVBqKzNpdWhkSktwUVNRZ2ZyVXFYY1BLb0cyTUVpVzhVVGZXMXJob2QwOWRN?=
 =?utf-8?B?bFU0Z0hkQ2MvcmpOQ3ZleDFUa3lsRmc1ampzYjlMRXE1dnBRQWwvNXAxTHVk?=
 =?utf-8?B?MFdFKys2NUlvdFNHb1pPcEpMeDBJd1BqbVNYaFU1VTRHUExoUUw1dGZkU3Fn?=
 =?utf-8?B?N3pRbytLWWwyNW5sVWNnenhXbVpuMXBrejlITGg3OS9TajZuK3dXYjdoWHRM?=
 =?utf-8?B?OERhalJ1dVpJQm4rbXVuTWtRVGNYQ1NDNEdrNDZrRjE0KzNFcW9nenpqZFds?=
 =?utf-8?Q?LRJnqJIpWYo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXBKbzRYRnpyWThuVWNnWUZtMkJYWmdGaUdCZllXaHIyNTl5VXI3SDA1UVJC?=
 =?utf-8?B?NDl3UE9WbG83WXB0OEJIZ290Q0Y5ZFB5MjlUTC94RjVta0d5aTNUUXFqLzhu?=
 =?utf-8?B?TkdKT0ExblBpZU85R2x0OVd5Q0JWSnQ0aWxoQ0c1TTFpYjVKWlRuUGxodzJs?=
 =?utf-8?B?M2VUVUVURyt3cGFITWR6WWFzbWdiY3JTWHEzRExHczZLOHM1eHUzRE1hWUpJ?=
 =?utf-8?B?S1BkUFdzaU9Rb3N1OHFzWUhMZ3phbWdsVnNWQUlqb1BkMnVzc1czKzB3RFVm?=
 =?utf-8?B?eHgrTkFMd0taY3Z1cEZ3MVVRNVo0UzNhMElRcW1IOFJnNFo0M1U3VmJvNHdy?=
 =?utf-8?B?bi9sazVUSm50YmpubW5DVXJ1eDZEbHBQMkZpZlYyNnFxMVVVd1dmQis4NFJ3?=
 =?utf-8?B?VVNnMUVtaHIzbGVvUmEyK2NIazF6NWllcGFwQlRwT3lJQ3AzdjZRSGhjZERO?=
 =?utf-8?B?T2NTczFlL05JcmVWZnJNMXNUSXBjdHlmVGR5azU1Z0lLNGs5RTJYOVZ6Q3NQ?=
 =?utf-8?B?bjNBTjBTVU16WTBMbUlzTmFiZGtjUW5LRENvUG9QUk5NWDM0cTJNcmVMNkpK?=
 =?utf-8?B?UEw1dzBzZlFzMVlMaGJlNlg3REozdXoycGowRzdaY3VoZmYweE1INGpKQUFZ?=
 =?utf-8?B?d2d5M1BRdVpUbWx5VCtBRnV6T3pUN0VUVEVkYlV0SE5JeVI3Rlp2cUVCYWZL?=
 =?utf-8?B?ZlZiVXBla2Y2QTlTcXFMTWxUOCt0aVpmdlFSV3BzM0YzL1ZWQXMzOGR0UTEz?=
 =?utf-8?B?QzhXZHZPbnpNR3lJVGd0U2FWbHdObm96SXBYa1A4MnVYS1JKL09HNjIzYjdQ?=
 =?utf-8?B?MXBUYUZGb0FVVU1KRy9FSHpiRjVhbFEzTFpYTmE4d1dGV1RrNlNVVmJnMkxQ?=
 =?utf-8?B?SHZYeE9XemNWVnV1SG1aOFNNTDc4OXN1U0djOWZVQmc1eXY0WWJUMXNJMnMy?=
 =?utf-8?B?dVpJbytqK0h5MnFLeDZRUVJGSlJKcVdGS3lBNWN6bExkVVJ5QTN4RW5ndGpr?=
 =?utf-8?B?TWh5c0ZrN21sRDNDb3FEQTJFbFlvMXlFaHErTFQ2MWtwNGtWYUpXQ29Kc2ty?=
 =?utf-8?B?UjBNeDRGZlRXbHBuUnhOYzFYNHFGOVBVSlpkRUdScjVxWnlPYzhwUnh4cWNC?=
 =?utf-8?B?VDQ4NnhqZ2MyZnRZbVJPRENZS3FzOVdOckR4ZEdyTklEUUw4ZVpMbC9ha1BW?=
 =?utf-8?B?SFpVc1Jtc1p2b1NkdlJBOURjYjNNWEtwakk0cVNaSmdZUW8rQ2hiYjhKeGJm?=
 =?utf-8?B?aHdEcXZhRkJkNjRsQmRveWd6L2w1QW9kV2JEQlNCWFg3MExIYnk4MUg2VzQy?=
 =?utf-8?B?R09La25UME1TNnJrQnUyWU84QzZldHhJT1h3eDJtYnFVMGJOb3hzRVdzSVR5?=
 =?utf-8?B?MTVyWTZWS0o4R1hFUisxZ2M2M2JxNEp2Tlk0SDFBZWFaWHh0NWdsYVVnd2Ro?=
 =?utf-8?B?WVBSUUlWcTdFc0pGNEhzR2pMQ25XaVlKdUcvVTB5WGlCcjRiTWtNdVpzbWZ0?=
 =?utf-8?B?YTFvMDZvVzZpRXJMdFFXRVVpU2pIMURMSTlYaVUveVgxTW5ybUNENFhodnRY?=
 =?utf-8?B?ZEplRHQ0SlJkNFhCZk9pc1pRQUZ6dkN1bkwzRWZ1cEgreGd3N3FqRE9raVdt?=
 =?utf-8?B?N3RBd0RqdDgvZUlVQjZKRTRSVlRlUU1KSnNGaVdxVitEb3hMSEM2MlhFRUdH?=
 =?utf-8?B?bGF2RGpMQk1lTnVad09YL01xZ2pRVXVFSGVpWkZpSFBUY09TdzVWZWFaanNv?=
 =?utf-8?B?anRWM2c5YWtmY1FsK1lPdUF6MXJ2aWhNNGp4c3RpZjBpV25DdHJTbXVZSmxv?=
 =?utf-8?B?VTdMd0F4REhjUW5ocGl0QzJVRnI4ZVBOS0FZc0l2VTBXWUZOWU44MlQ5QWMv?=
 =?utf-8?B?VTNJNHZ4MVNoS01FeFpJR2VJMncxZjhBc3IycWQzMW5iUjhtN245bnNGZGVN?=
 =?utf-8?B?M2ZXVzdSSkErU3M4cktZNHZMSzVZOVhhby92SG9GSVNxdU1tRUhrRWJ2THdt?=
 =?utf-8?B?aXo1R2pTdXIvanp4N1ptMElOTDRPcitpMVUrRkhrV003aVVUOVo4TjVpL1dX?=
 =?utf-8?B?c1lEd2tRTmhDRzNUQ1F5Ukg3eFU3bWUxdlNhblJXZGJQUGhmNHpHUnJKcFcy?=
 =?utf-8?B?WEtxZzNtR1BjVFFIbVlwK3VDckhPN0pBMm0wUFlnMkg4VDNabThZM01vTmRB?=
 =?utf-8?B?Nnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18886855-7efd-4a18-b30f-08dde071c338
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 05:15:37.0686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pzkfxt1vhG9IT9wvqko8+pSZr0oAC6kkOiLorhHqz4P+m3efxBYqF2w45hzVUTQ5tnorRRrp5McSBX2VjlS0+0kRfVikaTR8NIBegcW2v90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8458
X-OriginatorOrg: intel.com

On 8/20/2025 6:50 AM, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Add a "microcode=" command line argument after which all options can be
> passed in a comma-separated list.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>   .../admin-guide/kernel-parameters.txt         |  8 ++++--
>   arch/x86/Kconfig                              |  4 +--
>   arch/x86/kernel/cpu/microcode/core.c          | 26 ++++++++++++++++---
>   3 files changed, 30 insertions(+), 8 deletions(-)

Looks good to me as well:

Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>

