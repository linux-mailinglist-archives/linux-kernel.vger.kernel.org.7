Return-Path: <linux-kernel+bounces-771410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C33B286B3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1188B174DFD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D59522F75C;
	Fri, 15 Aug 2025 19:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JrqX3jpj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110212253E1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755287432; cv=fail; b=SjcMMs6ryU2XGA50Uv+/CZ5byzUWfpbLGrYTR235sLAP+4eWyy/ASxEf3O5xGiTEDA7Hvqv5nQsio7kz5IvyhXy0/byj2lRIp7aNu901f96QkJVQ21mWxG+oXHwLGzwrYfCDsFYsMHiyax3vGyHIbJQWDj3DPuLStwBkFY3yy4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755287432; c=relaxed/simple;
	bh=WaEh1vfGW4bva/5NnhEdbaXTsV9Oup+vS6UHLplDbwg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n4SKJttkr5HGYsrYlYGKO/SOx3tHujRQIIAr+ImvYWgGP/buPEecQT+H4FicHnVmTc+z+B2DdOpvBi7p3upBVxovsbW8oiVIAr+Z8F9Bl79cvyrCCsvoS261C55MVxvZKmnUcr2SPfukQmZiT6rC5y97KE+dPyRzmHW29cYkjo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JrqX3jpj; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755287431; x=1786823431;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WaEh1vfGW4bva/5NnhEdbaXTsV9Oup+vS6UHLplDbwg=;
  b=JrqX3jpjwoaHVSJ9DDfP5FtIosRESZTCJORhTZDN5ChGgox7m5ZttC49
   kB5NL6qKpBQgzJ+th8tUlyVHFNBoSb0Dsq8gcBoF0MSXqDG/2Zhym2oUq
   wD7r01IWco0bX1rlgzmevVqZZjcwh+OJU5/OZS1rQWS83xbubyguIa6PW
   6eNNmDCbVkT45yATxwK+cx15rLpZgfcj3yfkLGOV6ITXMzyObkl2Z/Vag
   QfBZlEZoRBovoyJrfFz+74j92E8O5rUujpeKXwDKYH0xubJxvpkHxSiKc
   OitNOIG8w8qW+kMKn70MkeveC4i2xEq+nyRAnXUNjcbODLzPoaXD819B9
   A==;
X-CSE-ConnectionGUID: gY4vv/BLSKmwv7BWBcqgKg==
X-CSE-MsgGUID: xyVntHsOSMGXulwSwrrrew==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="80190222"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="80190222"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 12:50:30 -0700
X-CSE-ConnectionGUID: vMdNBE1fRDGobKw16b5+7g==
X-CSE-MsgGUID: 5MEzI4h3Sfi4Dkd5VphUuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="167894273"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 12:50:29 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 12:50:28 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 15 Aug 2025 12:50:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.89)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 12:50:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niR93q+sZ8JajvUcW5DQ9IRoyvKJDhWr2CXo5aIk3rnIRQ+mGwrbiqDMvio2gDqObdaBASO6gsXwxn9d3POW1xF/04BDZnoph6XjtEcLdhHr295k8VDDV2mjJeliW/J7MNrDR6qB94o95zqF/G8ZykaJxA7q3xmsJHZApoxYj0nCjWFpe8PcpTD4BCizoKf6hnhB2+Wq21CzSf9aTNj+LEnztxJm3mww1FED1DUcDWOKr/q+lTSKUhvtOzw+qMpSRYtvupIEcw4T1CNUBRUd+fEz4aj+ocB+0c8Tvx6Yz0si5R5RyzoZSrL5qGEDVuG90pAoxWt5Ow9IhMj5xTfQ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDP/dZD+BNN9SlGYKch5hpy3sraEDYrC1SBdrBg8/uU=;
 b=aedMZKqSzezYUgAjiMfJUsmQvU3C8aTBf8mKW5HL2uhi6FxS4+BeciSlOBDvdybZdMAU1+06ZI8lDtPMqRMlBlM9w5NamjcDR+VGA4ORdrrpC7sNuZmMBpB2xggNjOWkjLASNkUrNIDvB9pGcHarYdmPINj+hTi6ogk/rihBmqRf69HXd3Q51/JVdRRJrA7wz2kwbmkwzAK4Bnti9bvg24uGJGRXOiDZXDp8W44TRci+XGA2Qf5nuBBo5LE7BGmGi/sbr35mR3BEKaRxLN7skD0MCSFIfpYX5evKHYu7as43xTQgNXzeaNh1DE4b3d8RiwHh4twex4fTdFX1Fr+M5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 PH7PR11MB8572.namprd11.prod.outlook.com (2603:10b6:510:30a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.15; Fri, 15 Aug 2025 19:50:27 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 19:50:26 +0000
Message-ID: <644c6633-35c0-4feb-a2d5-97ee4663d4ee@intel.com>
Date: Fri, 15 Aug 2025 12:50:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/microcode: Add microcode= cmdline parsing
To: Borislav Petkov <bp@alien8.de>
CC: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
References: <20250809094206.28028-1-bp@kernel.org>
 <20250809094206.28028-2-bp@kernel.org>
 <6b345bdd-d5f6-4967-9f2a-15c2d371ef1b@intel.com>
 <20250815092025.GCaJ772U9p_UpEasfa@fat_crate.local>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20250815092025.GCaJ772U9p_UpEasfa@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0087.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::32) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|PH7PR11MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e30654-097d-4f7a-9f7c-08dddc34fb34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUsyZjkxWmJMVENCMlNmNU11V1ZZUlVYLzU2NjlUTXVVOWNSYVFOUWh5MUNi?=
 =?utf-8?B?akU3UmZtSGEzc1htbHhwKzNhblpwVWtJNTRFcG1ZWDZlVDZEdWhzSWxxYlBK?=
 =?utf-8?B?aytEaC9KTk5GZmQxZEhNNWR3N01MczZwdy9RMzg0a0wzeTFvTXJxOEVoUFVB?=
 =?utf-8?B?Q1lrVnNaMHczNWo0Wk1DUERzb3Y5UDV1Uk5saHJvMDU5bmpVc1Fab204QXNX?=
 =?utf-8?B?L0h4eVZYaU41ZkxUMmUzR3VCOGU0ZEllWEE1SDFiUkNZT05OVTBHbHk5T3U1?=
 =?utf-8?B?ZitKNzBHOEUrYTh0WHZxQWhEU2N4QW9wV1UzUU1iNVZJZEFnTE5pKzZSbTF1?=
 =?utf-8?B?Mkpnd0RkNnBINy9iY0xqMGpYNDFIVnd5ZFNpeEJnT3QzUnIrenkwamlwd1ZI?=
 =?utf-8?B?eUNNTWJKVnRpbU03a2w4MWRaY2FOa0x5SDI1cFdLTnUrRE4rc0RLMG1QWkZt?=
 =?utf-8?B?VzlLVVgvdVR1aTU4UDFEM1Y2WTdXc2JNTGZ4Wk8xUjh6Y3NTeG9CU3B6WFJk?=
 =?utf-8?B?MmlzeEd5QVhzL3lEQUFYQ2VRUGREMWd3aG15NmxoOWVhbkptZ2NjVVdXNVRK?=
 =?utf-8?B?OFF4MU83bXVvb095MGs3R2xVd1YzWlNaby95NCtYRUNXM3VJVGo2UTloenIv?=
 =?utf-8?B?WVIxVHVhSVJnQzhiNzJKQnEvRXArSlVhenhvb1RKU2JFTTZxeWFnL0gybmJ6?=
 =?utf-8?B?Y1ZZWFZadVdsalVqRDhyN1lWZTRYNnQrUENRZ2c3MEJPeUI2NEZzQnh6aS9G?=
 =?utf-8?B?OVVqWjZmQzZkZTFQZTlwcDJFQWFjS2xiR2MyY2ZtdFBabmFpN1J0NER4aDd4?=
 =?utf-8?B?cDk5aTA4ZjVxZjlmZGp6azRZUFY5QnhrVVFwVTJJeHJkMWgrNldjQVlhSFhi?=
 =?utf-8?B?SlRIU3M1Wjh3YUlTTVdUMmx1SVJtN0RNaEdaSWp4UHhvamVvOGJVdDI2eDZy?=
 =?utf-8?B?eGVFTSswSUxYWStZUFNrUVBLWmFXVjN2Zm5pNDh5ZmVoRS92bm9NWmlncTZp?=
 =?utf-8?B?RHBUQUh1UGVnR2Y0NURvU3JIcHNWRjFWaFpQSHY2bWtXbUdHcUJNRm1KVEtx?=
 =?utf-8?B?TzVHNzlkdEgzOFp6MWxEUkI3MzU0aWZRaXNIaEwyeG9UT0kxU2NNeWdmVzVv?=
 =?utf-8?B?a0Q4ZWJDMjJ3OFRGYnNmekd2Tk1rcEE1L05rdk9SSE9BQ2pScDlWSXY5RU9S?=
 =?utf-8?B?TXpUOWl1RHludWgyaHRGeFZweTlSS3BhQ21MQ0ZFZjJ3cmFCS0kyTmdsdm1o?=
 =?utf-8?B?Z0VubzhwK1E0U1pZcEVuelcwK2libXVyTUNzVWYzSVhvYjNCa0xOYlJQdUk2?=
 =?utf-8?B?NGZQYlEvL0xER3FnUkw3akhBZlRPQWhLQldLK2locjhZK1pSUmkwa1RKOFRn?=
 =?utf-8?B?N2Y2ZERFbjhOMmI2TU5zbkJqanVqMTVoWUROMDhkUDM4Y1lSWmVWcDRtYVBw?=
 =?utf-8?B?SGovSWhYeVUrVjUvSDB0SHV3dllhMHRvamdsdVd0QnJDdXNRWHlYcTNCV2di?=
 =?utf-8?B?K3NRR1RIczh4OWxTLzN1cXE0bnZBRDdET1hyUHZCOTBmZmRqS0d3TnBKYm4w?=
 =?utf-8?B?QkN5aU4rZjQ0U2hDZ25EdHlVVFRXQXZTRjk0MlBoa3FmcWE1ajZhVzhnN2Jr?=
 =?utf-8?B?bEtMdk9WYUVoQXkvZkJDWGIxTkdBZ2sxWVBvWGZBT2s5MzJFdVBMMHBRY0Zo?=
 =?utf-8?B?NzBJOE43SU55M08rcHRPaWlpTTZoRmFZMWJMVjMzTUpxc2RzeVRxc2RQVEMz?=
 =?utf-8?B?ZTE3NDdsL1hzM3g5dzJyMXNOdCtwMFNqUEpvblpjeXNmUlJjOC9OcWpqUmND?=
 =?utf-8?B?TTF5cytiNDZtNlMrTW9mYXVRUDlhWDloUFUzbzNzbU1PakpqNzRoU3dYNFFr?=
 =?utf-8?B?b3I3V1IwZjJUY2NmUHpCWTZIMXpBSGJmYVEwRDFueFB2K1QvNjVZbnBEWnFH?=
 =?utf-8?Q?AOBFUzHmRTU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnhKUWVnTHBCVXJ1RmUxaFBmUHB5Q1hXcTgzRE1jWTVnQXRXSEZBSjFJUWxo?=
 =?utf-8?B?SW9FSVRYMldxbkc4ZjRjc2JHTnA5MjZxa0VRMmJwVHd1bmpINmR4QmZiczRL?=
 =?utf-8?B?WjRYOGNKQmpVTFNFcHVSa2FiT1VhemNkNENUQ0NtZjFob1F0eW1RaUZ3YTZ2?=
 =?utf-8?B?VGRMWVJqY3lSMzVlcWNRSHd3M21HRTQ4WUJxdWxoejg4YW1kbS9iV092WlVC?=
 =?utf-8?B?Yys2cEt0Ry83SHJSZENKK0I4QWhpdXkyVDJMUXNVSDhRd3ZZWHBRQ2MvRDJl?=
 =?utf-8?B?ZWhkaDNuMTNrbjI2aXRnWUFnTEh6NnNxQS85N3ZRUHFJUHZKeEhlRmdKOW1C?=
 =?utf-8?B?aUl5RGZkb2VhS09QcUVyQzl0ak9hVzZXMlNyVmNHMkh5QkNpRWJXMVZDTjFT?=
 =?utf-8?B?MWtjSVE1ZllLWW5rM1hxbExmSWtORlN4UVYyZTB5YUNIQjBjeis1d2QybDlv?=
 =?utf-8?B?UmZDNXJMQTVUSFEzcUQrenlsRDZueFVydGQwTjQrU2FxUGlnMks2ZmMycXBm?=
 =?utf-8?B?ZnlpYVdwWHNoOGpBTWhwc09PTkR0L2N3ZlRTYzI2anRzRUlBMnZUNVV2NWxq?=
 =?utf-8?B?Z2d6cSttZExiWENQWncwa2E3YUo2ZnpWU0IzamVDekYySTZNcWp3Y1ZhU1Zi?=
 =?utf-8?B?NklKSWlaZ2c1VjEvQTZ6Mi9NOFE5bllmbWRBdE02YmtJMFNIMmxJdFVKMk9j?=
 =?utf-8?B?ZmNtdS94SUpuQkswNFJydmV6NmdOeThnT1VhV0xOS1pwTjc4Ni91QTFsSENs?=
 =?utf-8?B?Q0NqbUYxTGJHOWxoajI5T2Mwb2d2RjFoeFk1REZUQkFrZnBzampEcytZM3M5?=
 =?utf-8?B?TFNQUS9WaUpDd1RZMnRuQlR0OUZGR0ZVNDNvNE12ZWdYclFIemI2dUVXZTVT?=
 =?utf-8?B?T0YwRDZFUHFVYnhweHBuNmE1Q0oxb0szWmxQQmx4UW1Xbi90aDU0cmpFVmFR?=
 =?utf-8?B?aS9QcFBZYXVFMXRJT3B2M0FPZ1JROGdyUGhLazdyaG9aUHF6R2lWVWpWMTBw?=
 =?utf-8?B?cTBQRVc0Z3RQdTZ3UG5BMG5JUk1xN296K09HV25XQ1Q3ckkxMjNDY3NHaXhR?=
 =?utf-8?B?Ym1XZktXYUJmSzEwbFlRb0k2TlVEaHFQd1ZNNmFHUm5kRVV6bmovdHlTVmhF?=
 =?utf-8?B?MWdFdk9CZ2s2TWRQOXh4bHNHWmVLRE1ZcnFla01VbTg3Unc0TElGZ1ZNcWRT?=
 =?utf-8?B?SjNKSUx2Zlh4MGUzL0VzVE1tazlENEZtdHVmNThrcVpBTWxjNFB1UmZrWWc2?=
 =?utf-8?B?aG1rVWVPb3lwUDdoK0NORkRUbGdidEdNYmdnRERRdmNVa1NZd2VsTjdiM1Fh?=
 =?utf-8?B?b2NkeDB3TnpJcGMySkVvVHA2Z2JxN04za2hhdURjLzU0eCtuMzJDSXpDdU5S?=
 =?utf-8?B?NnovSUtOYk92SDZIeG5SR1VMcWVsbG5jckhyVWZDZC9FeUZTaHlOMUI3SVkz?=
 =?utf-8?B?bkRNbThDSnlHbWVBcVpkdDRNcmtNeTBTdHhqN21iZExJRzhrUmZwWlZQNS8x?=
 =?utf-8?B?bHh6Z0RrK29sWDZhS2JZUWExOHgzd0NZa1drR2RiR28xazRmNEJFckcwUmh0?=
 =?utf-8?B?R3I3OGVnL2dZc2E5YXF2dTAwMEVsU0R2OERKRXdmajA5ZkttSytVMTdQVkxw?=
 =?utf-8?B?eGQ0RVZOMHdFTkFTYkdvRFJvWkE0ZUpMZ2VHclAvTUpDdU9ZTG1ZeWZ1eFNB?=
 =?utf-8?B?NVBZMUJqTThPWFJWRUdEeXJqMjNWNmZ1WW95U1hBd0dHYlROZ2x4SGdMMUhv?=
 =?utf-8?B?bGRvZ3drQ1k3USs3V0p2Nmx0enNGdjgveTFXVTJzQ2RzSTlwcGYyRjBGNFJ1?=
 =?utf-8?B?WmlWL01GQmw3S2MyNy83QjdKSHQrckNsQmhQQWNqRisvbHpBOWhnQ2lXQ3Yw?=
 =?utf-8?B?MXVxV1F3L3ZNa2FPdlVjaENuNEw2bXcxbzU2T0paVzJubWNLSDRzMFluQmlM?=
 =?utf-8?B?NXQ5THZXQmExRGU1TytFZDNPeGRwVm5BdlltMWduWHBYb1ZrbHZmYjRlS01h?=
 =?utf-8?B?OVYwMXNkU1k1cmFRZ1BxOGM5M2hOUzJCdlpjU21KVDlNUlN5NWo2VGxjVHZX?=
 =?utf-8?B?RU1EY3ZjRGcwZ2E2eGtvSk5sZTFJYmUrbUhtOUdCb1dNMDJ3cS9QQnZTRDhF?=
 =?utf-8?B?MHlIK1FzSXdBWkpNR0o0UlBoSmdIY3RWZFlTVUhsWC94OHc4d0svcEtqUG8w?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e30654-097d-4f7a-9f7c-08dddc34fb34
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 19:50:26.8899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZe0kaI2gdW/VLPDye0Jd7vuNIN7ItUnnvpVso+R4yU7xHm1LCqfkI3fbDl/onZuWAsFGXtDaIa68WWmXCxEVgZmjPUOFESw/GA3xcQJ+4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8572
X-OriginatorOrg: intel.com

On 8/15/2025 2:20 AM, Borislav Petkov wrote:
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index fc002b1a9f57..e7badf2aba63 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3770,16 +3770,17 @@
>   	microcode=      [X86] Control the behavior of the microcode loader.
>   	                Available options, comma separated:
>   
> -			dbg - Format: <bool>
> -			enable debugging mode when run in a guest
> -
>   			base_rev=X - with <X> with format: <u32>
>   			Set the base microcode revision of each thread when in
>   			debug mode.
>   
> -			force_minrev
> +			dbg: enable debugging mode when run in a guest
> +
> +			dis_ucode_ldr: disable the microcode loader
> +
> +			force_minrev:
>   			Enable or disable the microcode minimal revision
> - 			enforcement for the runtime microcode loader.
> +			enforcement for the runtime microcode loader.
>   
>   	mini2440=	[ARM,HW,KNL]
>   			Format:[0..2][b][c][t]
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 462bf03aeda5..77f72f075d89 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1340,7 +1340,7 @@ config MICROCODE_LATE_LOADING
>   	  use this at your own risk. Late loading taints the kernel unless the
>   	  microcode header indicates that it is safe for late loading via the
>   	  minimal revision check. This minimal revision check can be enforced on
> -	  the kernel command line with "microcode.minrev=Y".
> +	  the kernel command line with "microcode=force_minrev".
>   
>   config MICROCODE_LATE_FORCE_MINREV
>   	bool "Enforce late microcode loading minimal revision check"
> @@ -1356,7 +1356,7 @@ config MICROCODE_LATE_FORCE_MINREV
>   	  revision check fails.
>   
>   	  This minimal revision check can also be controlled via the
> -	  "microcode.minrev" parameter on the kernel command line.
> +	  "microcode=force_minrev" parameter on the kernel command line.
>   
>   	  If unsure say Y.
>   
> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> index 3a4e210f6cf3..f045670a1fae 100644
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -45,7 +45,7 @@
>   static struct microcode_ops *microcode_ops;
>   static bool dis_ucode_ldr;
>   
> -bool force_minrev = false;
> +bool force_minrev = IS_ENABLED(CONFIG_MICROCODE_LATE_FORCE_MINREV);
>   
>   /*
>    * Those below should be behind CONFIG_MICROCODE_DBG ifdeffery but in
> @@ -142,7 +142,7 @@ static void early_parse_cmdline(void)
>   	char cmd_buf[64] = {};
>   	char *s, *p = cmd_buf;
>   
> -	if (cmdline_find_option(boot_command_line, "microcode", cmd_buf, 64) > 0) {
> +	if (cmdline_find_option(boot_command_line, "microcode", cmd_buf, sizeof(cmd_buf)) > 0) {
>   		while ((s = strsep(&p, ","))) {
>   			if (IS_ENABLED(CONFIG_MICROCODE_DBG)) {
>   				if (!strcmp(s, "dbg"))
> @@ -155,10 +155,8 @@ static void early_parse_cmdline(void)
>   				}
>   			}
>   
> -			if (IS_ENABLED(CONFIG_MICROCODE_LATE_FORCE_MINREV)) {
> -				if (!strcmp("force_minrev", s))
> -					force_minrev = true;
> -			}
> +			if (!strcmp("force_minrev", s))
> +				force_minrev = true;
>   
>   			if (!strcmp(s, "dis_ucode_ldr"))
>   				dis_ucode_ldr = true;
> 

Thanks for consolidating those loader options -- this makes them easier 
to find and configure in one place.

The overall changes look good to me, so:
   Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>


