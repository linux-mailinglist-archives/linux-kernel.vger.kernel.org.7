Return-Path: <linux-kernel+bounces-811521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADADB52A3D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27796482786
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCC4275B06;
	Thu, 11 Sep 2025 07:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BZAa0OBF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CA91DFD8F;
	Thu, 11 Sep 2025 07:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757576474; cv=fail; b=ltxYrZixmnYKHFfYqA/n52vX6q9LgJ21i6yFZl04wC/aAETGPtTcWnmuAkL/h0td+TxL/bBzzXZFlf72NyuTNh2OK2whEh7DsBBSr0sGU7AwYUudk+Sic0HEddyHTlnwu3swuC2BCW6ZIpFOqd5JNQgP0dbbOywfmupGZbvkFTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757576474; c=relaxed/simple;
	bh=mgRfuBOgPijjR5x9+SPLt/09vovAthBS6/ls2EjaeDU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tsAw0REJQYgDzaSKQ/t+caQ19hd/sqVG7xqzP5R+DQATirImloVhPs4km6xBQMbb+d4FbboT9lEWEb1yxT61mE/FGZyXUJfdvBMT0gByqfP4UIpZ1huyFIaTv+3UCO/k5EfVyjkPbchu3N70b3isS0kecBh5y8OWoQwzTTBnowQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BZAa0OBF; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757576473; x=1789112473;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mgRfuBOgPijjR5x9+SPLt/09vovAthBS6/ls2EjaeDU=;
  b=BZAa0OBFQcFQxXBMIexfTT9la1srycP1cXG18xWqPjgtg3mrJZaqwpZX
   ni/s4yhzghngvSZUo+sGrzaSYqx/qSIxp7yKJ2n2d0UU5vQqMRJauHTYe
   T36qYcBiZaeoXHaIVqYtTE6YGNLwZuWs0qRUJfgyCmmm+hcBEk37tPK2v
   U3E1bj14e/Z4xJ8ha47mYmaRVE2LKrGp7Q46xhAGEHYtb2x0JBmbd7cBT
   QqqRWUqOhytfcZ8NbJsILlq7uSlUNecBp3ObBp4SAERK9csugi9QiaPwy
   aL9z292Vp4pdZzLjr5DJO/V4WH7cAt++H82m4bbXYNtjQNoPH5idC+Qhj
   A==;
X-CSE-ConnectionGUID: ky8G/vp1TKm956QIlvbQ/Q==
X-CSE-MsgGUID: HQCva8uxSUqLpzjIW3TisA==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="59837351"
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="59837351"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 00:41:11 -0700
X-CSE-ConnectionGUID: xIMH3tIxRB6yDokufC9qNg==
X-CSE-MsgGUID: jfX9dYrMRZa4EYeVoMmiYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="173684371"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 00:41:10 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 00:41:09 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 11 Sep 2025 00:41:09 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.81)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 00:41:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XC1rw7BO45bqoOuNv6fi7mUVr+c+ryQuxI++d63A6G0Ehel/nGbvEw+6z0Cwvw/VkUl58W5xehPGmQqiTDDN8R12ymPis6AfrI25EB9wUkWeUVEQerpo4aECMcUKyZhCPkv7DgIzLhE4+j4WQjYZFuuIki3rDduO0YIrVCeMR64sloxWO4gezyoUFK1Vda4z851EI2NHdypMxtT5CVtxgmGPmcUilSw63dPH1gsMWsut/cew+yXqFDzTeklM3Kd5SBv8lFthwD9lBErF6yTkp8JuQDuI5DmUIO0QrweX8HktgNweKNF1sEZOe7QK0PuSJArScf8qU/trTI9DHkm2Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rOZjXtHOk6ARemayxZdsSIGbkbYLu+4/C57h8Gsp4E=;
 b=Q0ALBhAwDN9Zo8vCQSKRW2YdkHCvi5k3UpphdhcGxM4XqkxY4hrEXeUxzU3VKFt77IRv+5H6vZLT4Mq/Qi2/CafGAfxAnsrFtYHhPFiA0wGbncEeE95tkekqGVC+GbUT8/BfGB4oHML5JcOD1tRNofUWYfL7f9VXkUxZW1iTb84jBKU49WAlGkiM5AQ3GRPivCfX3JfajjSVciRN7kDN88WuPgfTtd9PU8zETzYmVe7RyzwMd2aiXTN/ZQuyJLuch2mgbTKNiBISmwZzc77DPko0GN22BIzB9XNXdkpYilW3JVY7yldDHG1ORQE3WVkOZLRcGgUJ0pzWOrJ/jzlXRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8283.namprd11.prod.outlook.com (2603:10b6:806:26c::16)
 by LV3PR11MB8765.namprd11.prod.outlook.com (2603:10b6:408:21d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 07:41:06 +0000
Received: from SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::3:e0a:87af:d4b6]) by SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::3:e0a:87af:d4b6%6]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 07:41:06 +0000
Message-ID: <73a46879-b1be-4668-8447-17786b3b1d57@intel.com>
Date: Thu, 11 Sep 2025 09:40:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: amd: acp: Fix incorrect retrival of
 acp_chip_info
To: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
CC: <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <syed.sabakareem@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Greg KH <gregkh@linuxfoundation.org>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>,
	Peter Zijlstra <peterz@infradead.org>, "open list:SOUND - SOC LAYER / DYNAMIC
 AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, <broonie@kernel.org>,
	<alsa-devel@alsa-project.org>
References: <20250910171419.3682468-1-venkataprasad.potturu@amd.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20250910171419.3682468-1-venkataprasad.potturu@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0018.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::13) To SN7PR11MB8283.namprd11.prod.outlook.com
 (2603:10b6:806:26c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8283:EE_|LV3PR11MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c5fda0c-8138-4917-7c24-08ddf10690f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWxyNkpmb3didmNiTkxDSkRLQWZrczdIK1RhNjVvdXhuZjQ1L1UyeXlweW1h?=
 =?utf-8?B?b29iM1NGTFlmbzZZSTJDdHA5UFBleklyMTlrOG1ManRaUFd2eHE2RFpMNFJv?=
 =?utf-8?B?UnpMc3o4R1MzaEZBYXIwSlBxeXU4b3pWTXVzamt1TVlKZ2pxQ2tma1BFYkJo?=
 =?utf-8?B?T1BHODNuY1dKZXdWdDFQZE1xbHpqaUxLWVNrYnVIOE02RjZZUnYzcmFNdUEr?=
 =?utf-8?B?aVRqSE9sUUJYMWNlOERDVXoyWEtWVGdFZ0FRZ3JUbkkrNmxUU0Z5ZUphRHZK?=
 =?utf-8?B?QWlQNjYwS0w5RXllQ3BON3cvNkFVREN6Qi9hTlFIT3VGRjJEK0srSzJNM3Aw?=
 =?utf-8?B?blB3RkZmeVlWMW5RZTdMdVV3Q3Myb3FTMjNrU2NwL3NyNlNIekJEYksyb1BB?=
 =?utf-8?B?VzFkU3F0eVFsbm80Nnc2aFMra1RRMzVEY0lFMEZHcWNsZzRyTHNKYjN1bnN3?=
 =?utf-8?B?enR0bCtVdkdRUzBLdFd5NWtvVEtZV0M3d3JVelU4MnB3eDNjTkhRZnBpMkg1?=
 =?utf-8?B?SVB3N3NhNHJYQ1kvTEJPZUN4dDFhQnhwQW82WVdKbjRiUFUrZFBrMmpDVk05?=
 =?utf-8?B?aS9JQVpKeDlLRWEva3JmSzZmei8rL1grWjNwZ2xVazEyRmRmejczWWtGSjlv?=
 =?utf-8?B?ZkJ2TzBjUWRVYSt5R0VaWldROVhrRHh5SSs1OGFRM3ZQekJSR01lV1NCQlYw?=
 =?utf-8?B?R200WEVjbWtnM3FzL2FRR1BJQWs5ZHRDaDBBMlpKZmtPamJrNGpNQ2l5SWpE?=
 =?utf-8?B?NXVSVWdJdnpmOHgwSFh3TVpteVVINDJQeSsrWC9LU1N1MnZ1TWowUlZLVFJX?=
 =?utf-8?B?SDlBaVFEOXhOYUhiVjlqb2M4cjZ5bmdZamdyYUlYZklNM3l1c2pmQWduelg4?=
 =?utf-8?B?c0QrU0puUzYwZDZpRk1SdFlHTjBqZXRKcVFYQ3F4VERMcmJLclRzZTNBcFNW?=
 =?utf-8?B?ZzlDaUQ3NytsRnFrRHJXVkhiK21CaDdkc3I3NEo0K2FPL0k3c3RQWVNqbFNu?=
 =?utf-8?B?UVNHOFdRdnhZelppaysreXNOSnVCL2N2cWpJYUVmTE1KMkZGY3d1V0M4bUJk?=
 =?utf-8?B?Qkx4dUZ5ZFVqZWFNanJhanZINXdPVk9rSnRMbGRPd0RkeGR5MDVQNlNSM1FH?=
 =?utf-8?B?NHdqK0JqQUhtWFR2R1pCVlFVQVlRVldDSmRjRjAwNlo4TktnNTA1TXlFc00x?=
 =?utf-8?B?WUlZZjRxZnZNSVVnTkdWQ2hwejBUZ0xTTTMyUWxpQUQrR3hNNWNzZ3R1QURT?=
 =?utf-8?B?OWFuZU5HTEVOVEJZOWY3VDBtdW9VdHRtbU83YzNtbkdwV0kxTklOZFpRWDY5?=
 =?utf-8?B?Mzd0WnpjcVI2SWxJdUhmMnRvWUYvREF3ZlFYb3pFaS9qa3Fqc3ZVWWNSQnRa?=
 =?utf-8?B?dVNJb0dGRk9Cd0lTNnZuNnpCUXZlUDZ2NEx4VlMxSEFqZlJERnZSUzJXNnpw?=
 =?utf-8?B?bTVNeU5CcVl4SmZwOW5TNldtR3RVNi90VzR1enJIejNudWpJUEZNNVNsSFRL?=
 =?utf-8?B?aDZsUGZKbWpnSFV0cTJoWkZVaHI0SFdOSzZzSkF0ZFhpS3ZzR1Y1RWVQVE81?=
 =?utf-8?B?dXI2WHhSRzB5aEFGV3pWMlp0NG1SRnpuWjhrc1IyMXZRaXluWUZsYlhpZCs2?=
 =?utf-8?B?TTJHM3FRY010d25BdCtGVU1BN3dMaVorYjhvTThXdG9WMFZUN3ZVS2tQbXY0?=
 =?utf-8?B?RzcyREhqVWRVNnVKcXRYTUcwNmpQRVlqSnppbnE3L2taQkgvTE05ZGpJUHF1?=
 =?utf-8?B?VGtMNDR4QmwrWXNoQ0Q2WUYwNDJySVdXS0pheEd1VE50bU9JaUZabVg0ZlUv?=
 =?utf-8?B?aVpGSDh2UlN1UFhNS2c3NnVzcERvQkNudURHVVd4dlNNTjM5Tit2dlZYczZL?=
 =?utf-8?B?eVg3TGNBMU80R0xKeGtybTRsUGRtWDNqdElhREhwR0JPWEJGUVZCcEIyVGY0?=
 =?utf-8?Q?y6RJXneksYc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8283.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHRsVk9abHZ4d3kzd3dvbWxJY2ZBcVhPRThNeFVCd09PNHRNdi91RFVMVDJ1?=
 =?utf-8?B?RmNzU01XWFBUdlRONVZPbjU5OEJqOUNiaElCZzFuaUVUbHo3TWRWRHN2bzNT?=
 =?utf-8?B?ZHAzSWd5c3VHSDYxMGRkMXAxdm55U2JiV3VxVHZhRmN4cEJFcFdJaktWblA4?=
 =?utf-8?B?eGI0UDVGOERhemFabEJqeThwRUQvbTZKNTI4c0p0OUVPSGhFSGdkY0cwb254?=
 =?utf-8?B?eXI1dzhGWXA3UVpWRlNQVVBMd2RFdUE5VWFGeElheTRXNnN6V29wRHVoUnlw?=
 =?utf-8?B?ZisxUTFHU2JHV29UTzA5elpYeE9CU1dDc2M3cmpsQS9UNWJzKyswVTZlVDJW?=
 =?utf-8?B?aVlDYlFmN25EL0dTRTRRdXdIMHdiNEwwNHpLNDRWN3pEKzREQ0dtSWFMUXFV?=
 =?utf-8?B?S0k5d25jSlk4Vm16SjF3TS9PMTdsQUswczVjVGExeXFUUGxnTnh0aGhjUUFT?=
 =?utf-8?B?WjlOSVRNcFpMT3E3R09pYVlnYzVNdUNkcDFLMWpQeG9qd2FOTzE2OGtkcDVN?=
 =?utf-8?B?Z1dEM2tJaldxb1ZiT0N4YkRuZXByZFE2V0NhREJVNGJpMDFNbUxCRmdMNXV1?=
 =?utf-8?B?RmROa1YzNGNyd1FxR0I2TDdrQWpkc2dNSGE0cHorcDZhN3hWNjBFZXZqeDRQ?=
 =?utf-8?B?WktDWG9lM2l2MDMvTXdXSFFLUE1wVEJWSDBTWFF3REI1dXNlRGtzTFQ3MXNY?=
 =?utf-8?B?OGNaNWF3bFVMMk1KT2FGQ3h3ZUxsdTBMWGlScWwrNDZDeVVCTCtBLy9jU0Q4?=
 =?utf-8?B?V2RvOWI3KzJiRS9TTloxcDRzVFhkMmFpYnhUY3Z6dmtYakI2a0tsYXpoQ1I4?=
 =?utf-8?B?RVJkQ3pWNTJGNklyVG5BbXYyNkZiUi8wOHJ5eVU4N3pTc1UxRXAwSDhQRjMy?=
 =?utf-8?B?UWpRSXIvdnJNWUViQkVuRGwwZnlES3VpSUVySm5pcjBpTU9zbWliQjRuN1dI?=
 =?utf-8?B?RjdvdTZNaEJXbmJEMXRaaWVuTld5blRjcDIvSjh5UlJwRzIzc2c0U09QdVBt?=
 =?utf-8?B?US9wbXdUakJwRnplQ0pJNlpvYWIwZjZCYWN2ZnhZanNqTFk4YlgrWENIRG85?=
 =?utf-8?B?eUhYSHVhM0JtdDRPRlR3dm9uVWoyVGdCMnJOUFE4blo1U3VGckgyR0tWQUZ6?=
 =?utf-8?B?WTdVUDN3c0RzU0JlQ3NuaVl0TUpFNUZ2UnBwK0FtSHZIWVRlVE9GNGZrY2Vk?=
 =?utf-8?B?a0QyR2I3VlBOS09ZcDNxeVZlWXNRbmpwVkk0L29iWlZ0QTBneHV5bGVUeWc4?=
 =?utf-8?B?NTRjRUM1Y3pGNjFScjR5UmtHVlkwenFIdXhUb1M0WEF0QTkwRFVSQ05TWkJr?=
 =?utf-8?B?c2pKWGtpTWZPenVhckQ3eml6SmpnU0pSK2JRUmJBSWxEL1p3cWNPYzVXNTA2?=
 =?utf-8?B?eFRHVXIxNzZjY0xCayt2dEZ3UXc2cXIyNkR5aVpOTjBwZHA4clBOODZqUGxr?=
 =?utf-8?B?bkowRGIva21XeHcxSU5QTkU3VG9iNjBURnhvWXhuNkFrY0xZWlVjQ2VBbHNJ?=
 =?utf-8?B?NklIdU1HSzVmdTVJM0JNeTJ1aEdQWGhSdFY0ZDBCc1hyZzdqQlczc2V0YnNM?=
 =?utf-8?B?eDNjcVBSSEtrNElxRSt6REZ6RkRodnc5dWNaL3hhUHpYNUxOQmpTZExsdE4x?=
 =?utf-8?B?dUFoa0NWMjJTMFhXU0FPMHZtRUVLMUM0WHFoeFdHS3BzclVNc1hNcUxlQW1H?=
 =?utf-8?B?MWhYT1pyZmMzclM0OEN4ZEdpQVU4aXNSOWZyY0VOOWNiaEdjNW03UTFwTG1L?=
 =?utf-8?B?WTIrWjg5SmdweUN4d3lobVk0MGJTZ1l0TTgxM2hOUW1NdmVweTNQMW9Rb2h5?=
 =?utf-8?B?b05ScmtOM1NDWi9DbTdIRlFzRDE4RUFHU052dUVpVFF6Qkd0OUZuOUlCYUlt?=
 =?utf-8?B?R0VuLzN1RnNiczVaM3pXUlhHS3RtSWxlWWh6NGVGczFHYmZDVnZpOWM2aytF?=
 =?utf-8?B?blErTnVpMzlobVcvazdyQWhVdWtOc215L05LTkJ4QWsxcnVZSUE2UlBjNk8y?=
 =?utf-8?B?YlR5VkZXeWlkbTFVWjY4TkJUWjNBTHBTc1U0U04zUEpEWlAyb21MRGNPVmhF?=
 =?utf-8?B?QzVaSVZBd3lXaEh6c1dUWW5xNnE3cnN2UjJ5K0JzbzFhVWt1RFFxNlJZaVhi?=
 =?utf-8?B?N3h3YXB5WW5XWmxOSTdSK3pqQ2lhRXd4UFo0Q3daMFhPb1FSSnhubDQrSUMr?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5fda0c-8138-4917-7c24-08ddf10690f4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8283.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 07:41:06.2560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrL/cREJYf1hwt8a5wVIvEcN9i77H8gREUlXQPp/3S8oDdzXrjQZ1r7mEX3Rcs16wI1pcFwLEQamzfCT32VPzImi7bnxqyM0G41eLoqV/IA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8765
X-OriginatorOrg: intel.com

On 2025-09-10 7:13 PM, Venkata Prasad Potturu wrote:
> Use dev_get_drvdata(dev->parent) instead of dev_get_platdata(dev)
> to correctly obtain acp_chip_info members in the acp I2S driver.
> Previously, some members were not updated properly due to incorrect
> data access, which could potentially lead to null pointer
> dereferences.
> 
> This issue was missed in the earlier commit
> ("ASoC: amd: acp: Fix NULL pointer deref in acp_i2s_set_tdm_slot"),
> which only addressed set_tdm_slot(). This change ensures that all
> relevant functions correctly retrieve acp_chip_info, preventing
> further null pointer dereference issues.
> 
> Fixes: e3933683b25e ("ASoC: amd: acp: Remove redundant acp_dev_data structure")
> 
> Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>

Thank you for the update, the patch looks better.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>

> ---
> 
> Changes since v1:
> - Update the commit description.
> 
>   sound/soc/amd/acp/acp-i2s.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/amd/acp/acp-i2s.c b/sound/soc/amd/acp/acp-i2s.c
> index 617690362ad7..4ba0a66981ea 100644
> --- a/sound/soc/amd/acp/acp-i2s.c
> +++ b/sound/soc/amd/acp/acp-i2s.c
> @@ -73,7 +73,7 @@ static int acp_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
>   			   unsigned int fmt)
>   {
>   	struct device *dev = cpu_dai->component->dev;
> -	struct acp_chip_info *chip = dev_get_platdata(dev);
> +	struct acp_chip_info *chip = dev_get_drvdata(dev->parent);
>   	int mode;
>   
>   	mode = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
> @@ -199,7 +199,7 @@ static int acp_i2s_hwparams(struct snd_pcm_substream *substream, struct snd_pcm_
>   	u32 reg_val, fmt_reg, tdm_fmt;
>   	u32 lrclk_div_val, bclk_div_val;
>   
> -	chip = dev_get_platdata(dev);
> +	chip = dev_get_drvdata(dev->parent);
>   	rsrc = chip->rsrc;
>   
>   	/* These values are as per Hardware Spec */
> @@ -386,7 +386,7 @@ static int acp_i2s_trigger(struct snd_pcm_substream *substream, int cmd, struct
>   {
>   	struct acp_stream *stream = substream->runtime->private_data;
>   	struct device *dev = dai->component->dev;
> -	struct acp_chip_info *chip = dev_get_platdata(dev);
> +	struct acp_chip_info *chip = dev_get_drvdata(dev->parent);
>   	struct acp_resource *rsrc = chip->rsrc;
>   	u32 val, period_bytes, reg_val, ier_val, water_val, buf_size, buf_reg;
>   
> @@ -516,14 +516,13 @@ static int acp_i2s_trigger(struct snd_pcm_substream *substream, int cmd, struct
>   static int acp_i2s_prepare(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
>   {
>   	struct device *dev = dai->component->dev;
> -	struct acp_chip_info *chip = dev_get_platdata(dev);
> +	struct acp_chip_info *chip = dev_get_drvdata(dev->parent);
>   	struct acp_resource *rsrc = chip->rsrc;
>   	struct acp_stream *stream = substream->runtime->private_data;
>   	u32 reg_dma_size = 0, reg_fifo_size = 0, reg_fifo_addr = 0;
>   	u32 phy_addr = 0, acp_fifo_addr = 0, ext_int_ctrl;
>   	unsigned int dir = substream->stream;
>   
> -	chip = dev_get_platdata(dev);
>   	switch (dai->driver->id) {
>   	case I2S_SP_INSTANCE:
>   		if (dir == SNDRV_PCM_STREAM_PLAYBACK) {
> @@ -632,7 +631,7 @@ static int acp_i2s_startup(struct snd_pcm_substream *substream, struct snd_soc_d
>   {
>   	struct acp_stream *stream = substream->runtime->private_data;
>   	struct device *dev = dai->component->dev;
> -	struct acp_chip_info *chip = dev_get_platdata(dev);
> +	struct acp_chip_info *chip = dev_get_drvdata(dev->parent);
>   	struct acp_resource *rsrc = chip->rsrc;
>   	unsigned int dir = substream->stream;
>   	unsigned int irq_bit = 0;


