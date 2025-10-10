Return-Path: <linux-kernel+bounces-848803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F16BCE9A5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 23:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 096DE4E56D0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 21:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4EE25A2B4;
	Fri, 10 Oct 2025 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPYgArxE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F359F2153EA
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 21:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760131222; cv=fail; b=alQ7OzK9CSW7/YkT9DzTcW391hvbaCYmaHEoStMCO/HsYGu5tbq3qKRiFEqxsdX3+pQdCiQ9hVWFjRzrTOHRKguyDFOzC0j4tSaxSQPThWgosNMQDWwCjusF9AhrYqhsAY4sW6x/0e3PuC4/zwl3TsTYGfQhRJcXF6aIwiNZnZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760131222; c=relaxed/simple;
	bh=oBJ3KeAk9i5rZulQuNWpuk3hAXg40myu8YmicMKRfUE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AHzyp7f15yjtm0pAPW5vVFXuQJx4gNBXE1avAsuLrv4XO7v+cY1+M05Nmn5DoKFQNCz8U/sg9NLvo536IM4fIoyXjr0HXQ7zcZdZM4/si+5Fx+MNc2hlN13lBuhKBCUhDRjwpLjOdVqSLykcRJyvJHVj/feDaws2tiVSPohMW78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OPYgArxE; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760131221; x=1791667221;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oBJ3KeAk9i5rZulQuNWpuk3hAXg40myu8YmicMKRfUE=;
  b=OPYgArxE8Cgn2PYhW0Fvz+Cm9Htdr2xQZtDL8kfLuq+mcPuVZA4fqOpO
   zRis8J/d8B/eMGoVzi60SVxkSTb3FatG1m7FrPQ5ETFDH2k4vuwGGj3SJ
   Pj6sGoKPWYPgBiHgFMV718kat8CMrRvbyig96gkBgYKa1J/E8tFPsVY1T
   Ef9i1ABvugYpZfjUojDIyKguMtJYMbAAkYA+WkhzZ7123am8wFwR+1zWc
   ezzQZtAoZeePLeCt/T7dUKTNOfCWZSVJO/NSCucxmz85/QqHX8AgfQh1P
   kqm14pjoK8nQbcrNV+6e07bMjhuGlkHcQSNLZDTl7HzqmP8vdFMeHYLN1
   A==;
X-CSE-ConnectionGUID: 6hPYO2elS56ZW5lE8iI5Ag==
X-CSE-MsgGUID: q2Ygs7dKSA2YISA+tYBllw==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="64976867"
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="64976867"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 14:20:20 -0700
X-CSE-ConnectionGUID: ZS2e5LAKS8aTcDOiwNEr+A==
X-CSE-MsgGUID: xoSEtV2zRMmYzVADwQXYLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="180188016"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 14:20:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 14:20:19 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 10 Oct 2025 14:20:19 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.17) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 14:20:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTIu3ZIfntPGP9tKssnhRX6vUMiQ9KKv4SAIlGSn3svgK+HDL15xD6248TAh4Yw/N/wtnSh/Zso6NJuEPJ38fsYm00iW2+Iy5PRXmp7bayK2F5zxx6c2hkJtDeRU1Hw9cZuPJZRvFZYBF+vVpEXAmkE8XG2p3+Ddf2X7YRJjS91EefCeTPZqAeSKDYnrckf7Yey9N0yhH+G7J74X3HRvfmM+iwUWdfCU9RvFrbhi+2TQ4KcAju+MwpQ6wSZ8ITnDtHHMKERh7BNm58LR9bXNmg0Iod7Nxvg6AupO3pChjrH6YNlh6jA+VUz8Ld6o1gOof5hz3/cwqQAImOhCCCqM7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUoAW1S1U+BIu3pjiIXc544vv0CUyisw2imw0nxFXFs=;
 b=nBQrOtA4/pSbVnzS1aEnVZ7tpxnV+vh2HyHDEt6O21VKq7DYidJQt6QQ+YDa3u+RQJ9SpioDZq77zB5p3YU2V2cNMAxyo1gjP4Q9TUfkCf4OK/NKEPbGCaNuAUI2pJItC9ZWQU3CoqqKom2DUXMX0lNIegRJROGkIedho/T3WZ9rF/Zzg5YAWsTgszQPDhjm4GxBlq5yxr1uR/BCc73rpvCpmXeUOVpmoZCMlLhJFHk7WE9Tgz0rysxAF/hbCk2E4npJRp311gLmNPV4Qz1pZpEltZFnVl50X1crcBIInIZPYFJ90EQsUz8NQ7UziHaZn3qqUg2pqytwtoCxRDk8uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB4963.namprd11.prod.outlook.com (2603:10b6:303:91::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 21:20:15 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 21:20:15 +0000
Message-ID: <9771a165-e7dc-4e34-960c-37b17bd996b6@intel.com>
Date: Fri, 10 Oct 2025 14:20:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] x86/resctrl: Fix miscount of bandwidth event when
 reactivating previously Unavailable RMID
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>, <gautham.shenoy@amd.com>
References: <0475e18db309c3c912514a6c4e7f7626297faa2b.1760116015.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <0475e18db309c3c912514a6c4e7f7626297faa2b.1760116015.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:303:8f::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB4963:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f98099c-51fc-4620-d1cd-08de0842ce1e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHNSS2Uzemp6enJjNG1PRXg3ZDdKWkVSYkZyUXY3dFQrdUZwUXZkS3Nqc2FQ?=
 =?utf-8?B?V0tsSHhWRE10Skp3ci9wU1RMeEVXLzNwR1VDTzhxT0RGT1hjM2I0anQ4OFNw?=
 =?utf-8?B?OVg4ODJvemc3Q3FOd1kyVWJHTXJjdnUwRk1leTRWSENxUUx4WWhzNW9TVXhX?=
 =?utf-8?B?SHNDVGF1VWZFUHFkaWhZRm11cDBNLzhMdWJPMEZtcytLVVhMaW5tUnZFTWFI?=
 =?utf-8?B?ZWVCTFRNam15NmlCK3MvTklJV1RsYnk2Qy9wdERZNUZIZnorL2FPZE05VjN3?=
 =?utf-8?B?Qy95R21LTm5YRkFlRm9SUEphT1g2Z1lkcXM0VURJa3NGcHlmVWVsckFCckpH?=
 =?utf-8?B?Qi9HdWxTckVVNTk3YTBHZ2JEZ1hrVW93RTZabUdOS0lPTFU0N3dZeUN2SDh0?=
 =?utf-8?B?ZTY3WDBLdXRGUHR3ZXFJVmtFdzYxZTRJU1dmQWV0K3FHcVBrcmFkQVpHV3lC?=
 =?utf-8?B?MFlFajd4T1pBU084UUhaVkhoSDdkZzROUm1DNGVYVldJZ0YvMEVnbEFjNGdS?=
 =?utf-8?B?YlVLNXR1ZWtMNk9wcklTWEpjeU9SYnozbXRjZmlhRzFUSEJXZUN5d0N4aWhv?=
 =?utf-8?B?Q1BvS1QrWmV5cFNRdmNBamU5VllXYTM1Q1pZUUFra0RBQ1JRU1pRZi92WjVJ?=
 =?utf-8?B?TmkwOTRIeWUyUG5RNFJqY3h1VGdsaVJjZXVpalk2bGlYc0szZGQwcDBiVy9F?=
 =?utf-8?B?Zm9GZEpTd0JDT3p0WHJTZTBhSzhhL3dFRnMxUVdMSjZsdmZ5OE5KUVF5cElO?=
 =?utf-8?B?WkRqa25xZWdiTjVZTExJc0FCZFlJcm5pQW1TS2NjV25UVlFSMmJwcGFYZml3?=
 =?utf-8?B?T3hxTUlRTlNsYmUrSTFvOEFVTWYwUG5PZ1IrME9ubW9DbnJVOHZJY25TZjgr?=
 =?utf-8?B?aVlndHVxemVGL3hPSWF0TmVkUk9YMzJXTk44Tlg5U0IrbnFxZm9LQzVMYjVH?=
 =?utf-8?B?T1FRaDJkSWFyMzJCdXNnczRwS01leGRRZ254Y2pjakk0QmJUQUFkZVN2amVt?=
 =?utf-8?B?ME9MZDA0eXJNcVFtckZlaHkzNGFyZGxOanI3eFhkRE05UmNLSWxKVVFZYnQx?=
 =?utf-8?B?VHBpMFNGRmVuT1lKNVJIZWhXMmZsOUE2V3VoV1BUUWs4VjNHdnpac0U4Q2FZ?=
 =?utf-8?B?a2VXRlNjZVREQlJKb3BCeHpFQmlKNFMyUTEyQW1kcnJSQXNkSDFyQjhnMUps?=
 =?utf-8?B?dXZaVVltemJqbnVFb2UwTngxMUpxSmk1cHVhNXc5bE1CTC9jWk9hZWMwenls?=
 =?utf-8?B?S1RCZGI2dVRTSDRnclhrdnh6QTdkeG1Ib3FHMDBhaFRwbVVJa0FBMGZVMVF0?=
 =?utf-8?B?empWaDRZSkF0Zk93NFNxUUNzakYvNWNxai8rVktRcGh0b0ZPa1dyQkJpay8z?=
 =?utf-8?B?S2pQRkdpSEg1Y0RjOHRyWlhVUjZlN1hKWG5aRnNXQ1hNbVNabFlYbno4c3Fu?=
 =?utf-8?B?SmEwSnd3TWZkK0pTaHJGa3BDelJ0WGoyU2owN1lFWFFqWnFJd0lVQ0xQRStV?=
 =?utf-8?B?WVlFMDFvY1NxdkZOaXBURk00ZUZwaFFmY2VCUFBGdjByTk9jVlU0VkdHa1lq?=
 =?utf-8?B?U0NvT0lINWZsSi9BeW1URVVzaVFnVDVIYUZhQkxJdVdnSmJmdG5pc1dSVDAx?=
 =?utf-8?B?amlKVmlOMVRlVkFlQkxJN0YrWVpTeG1IV3NxSi8rT1poKzE3NEIwYWw4Mnpw?=
 =?utf-8?B?ZTNXTWg1a08wTG9sOGsxSUlhbmE5OTBZcWpCMkFaRDRRQzFoWlN3QWFpam1B?=
 =?utf-8?B?c3Rkei9QZ0dKMnZGUDJqdE9pUjNSWDFLTHJ6SHczQjFBODNadlJwc2NoZjBr?=
 =?utf-8?B?ejlmZEwreDNvRjdIemVIaThJM05VeEJaV21ia3lrNGp6UzFnb0piUXBRdUVp?=
 =?utf-8?B?K2VyNUQ1SFFTMWU1azRzMnVBbXg5TmlWbkF5RkM5KzljMEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WklwQnp4cnV0eXUxYVlmZE5wS29pU2hUQ0dxaWQxVSticGVULy9nMjJ4ZHRT?=
 =?utf-8?B?RlBzNXUyMjNzd0FaamUzQzhjTjd5UzFsWkhoaFYxcUwrL202eXc1eE4vbEpO?=
 =?utf-8?B?ZzlXa3pYUW1PbExZS0cycTR4RTVPeEdIM2UzOFN0a0wxUnhmRG8xY2hIOGRD?=
 =?utf-8?B?enFJdTByeGphN0ZjRzJERjJ4TkNNenU2YTJtbXNycE9Od3ljUjhjMXFyajFN?=
 =?utf-8?B?MXVhOC9jTFAzY2dvbEVyRFFONzJiQ2lQZzBzWkZaOXlpQXh5VzFiUlcrMVI5?=
 =?utf-8?B?Q2VrK0NVcVI1SnlDeXFselhtaUg1Q2lyVS9ha042d2trOXJQY1Urdzg0SURo?=
 =?utf-8?B?enVVKzRsNXB5bFBaYW1uT3cyaVJla0EwaG03MjZIZUVBM0poZ21RMldnaFFJ?=
 =?utf-8?B?UUg3bWxpd2hQaWgxd3B5NG55RVF1RFNNdTNqYktLMmFSZWRFZnpMVVNSTDVD?=
 =?utf-8?B?MjVXcnIvaWJicGJCbG9DaVY3bXNlQnZSTGUxT29JU3pCanJtc0p1bUd4V1Vi?=
 =?utf-8?B?ZTZXYi92S1h0UXpOa2tQb283cU83cWNkZnFZZ0QrS1RGT0tSYlFVWVU0L20z?=
 =?utf-8?B?ajhPejc2VFF3ak12V1dhUCtoNkViOVEvNFRsSkVLU3NWNERVZENyd3JueWRS?=
 =?utf-8?B?RjFKT1FkWlVFVndjVE82T0p1R053a3pzV3cvMmtpeWZma0QzZkxRQ3Faandj?=
 =?utf-8?B?c2Y4c2dsZVpIWjVwUlhHTmcyNkxSL0xLNi9oTmVmSy9QRXFyMWdHT3drVEJ5?=
 =?utf-8?B?dmltWkZIS2w5WUNHd3dWYUxBWERPY3EwMDUxWE5GRzVTN0kxT09PbGdtYUdK?=
 =?utf-8?B?ZERXNkJjWGtJTmw4ZmlyVTRVaDhLbG1oRUVRWXUvY3AxQW01SmlmWU9pY2Za?=
 =?utf-8?B?RUhXUDYrZ00wNGwrWW41aTIzV25vT0dMNFJDbW1rUTFZNmIyOUF4VzVLR1lU?=
 =?utf-8?B?WXVPcGdvT3NuYVlVVnJYSFJkdXdGZ1pBOXU3c0pVRHRiS3dGUHBHTmVpN0Fn?=
 =?utf-8?B?djAza20xVHU1dkxIOGFjcFRFWUZ2MWxqQUFUUG5UbFR2OE5JZ1ZaSVNDM1Bm?=
 =?utf-8?B?TDdsVmxGdmdTSlpWNHB2NFF4QllEdlZYbWpNYWFlNml0TEJLcXlPbDdBNlN4?=
 =?utf-8?B?RWM3c05Za2JDUy9DYi95cXZuVUdlV3ZCWHNXN0d3aGJEQUVLSEFwc3Q5UFdT?=
 =?utf-8?B?N1N0aG4xNGRnRGhhUDdOYTkxU0dDb1J6OTRiZXdJS3ZUbDV6eGROWDZ0d3NN?=
 =?utf-8?B?TmJSVFcyeDMzb2t1dzZQYmZWaVIvSjJhRi9jNVQ3N3pwQ3RGMXY0WFVDSDRz?=
 =?utf-8?B?MlhJOVZkQm54b3RrNEpvRzJHUHowWFBwdmdYR0lJVVhnNUUyancvbWxIekp6?=
 =?utf-8?B?VWhteGJkN0VUZnFjK1BjWCtVZDhZcG1sV3kzblIyZDhuVHI3c3h6d2pFY2Rv?=
 =?utf-8?B?YkFYeTRGekJZYU1qT3FPNUlmTEN0SDdqbjdrZEZvM3p5VjNIUHhpdkpkOGpR?=
 =?utf-8?B?RFMxc2xHM2RkQm1QUklscVlyeGVpa3VnTmxpOENWbzFyTmlLM3kwUWpCQU00?=
 =?utf-8?B?ZlBCK2hQbEdjcTAvODQzV09sSk5zcXBKREhqSWgvNHVwQUZaTGVjVnNQbWw3?=
 =?utf-8?B?QkE4d1d2dWd5TjdJV3M2ZVJXWUVza0QwYngwZ1huclRwaFQ3L2lDa0RGZWJM?=
 =?utf-8?B?SEg4VldUT2JxK3JGNXRGaUM3VHgrbkVLRUpDRU1mSkdTY1EzbFZoQkxrMEp0?=
 =?utf-8?B?T3BlTUJyb0R2TUNBaUpjaDJ5bzFmWm02R205YWhIenh5bjl1RzZwTWp1cmdp?=
 =?utf-8?B?QUJ4eVBSR0NtcVZkUkJHQ2ZmcE1ab1FCNE9xdHZnYXBHS3RTV04yQlo3K00y?=
 =?utf-8?B?SXFHYngyTkxDTVlIT29HZnd1cHpuTnFsbmdSSGpGZGdjeHVoQWtVSWVvcm0y?=
 =?utf-8?B?dG9WT010VmZjVFFwYjlMR2xtZ2RHVVZDeDY5RnQwemkzbkZQODh2RlhKdWty?=
 =?utf-8?B?UVhPNDNuMXF1N3NXNWNMQjc2eFJVclRhSFlOVWtkOW9nNC94eE8veTNnUjFR?=
 =?utf-8?B?enlTVlNrRll3NjQwRTZsS0w1YnJVRjRNSk9tNGhHQWJuU1JPa3hGb1FvTUhp?=
 =?utf-8?B?ZUlQVnM5a3ZwOTBvcjdNeVJMVHBESFgrd1V0TkZkYkd4OUlzWkhka2txNHJj?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f98099c-51fc-4620-d1cd-08de0842ce1e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 21:20:15.3473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYhySTE5pUkoVkjPBmH6nBY127+WBQT1DvyzsiWecGFkCfEUxtG9YPAEnOLuTFnUOtQVjNGp5U3LtJofxnSU1RhaGowCuaPpFPFQ71aH7K0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4963
X-OriginatorOrg: intel.com

Hi Babu,

On 10/10/25 10:08 AM, Babu Moger wrote:
> Users can create as many monitoring groups as the number of RMIDs supported
> by the hardware. However, on AMD systems, only a limited number of RMIDs
> are guaranteed to be actively tracked by the hardware. RMIDs that exceed
> this limit are placed in an "Unavailable" state. When a bandwidth counter
> is read for such an RMID, the hardware sets MSR_IA32_QM_CTR.Unavailable
> (bit 62). When such an RMID starts being tracked again the hardware counter
> is reset to zero. MSR_IA32_QM_CTR.Unavailable remains set on first read
> after tracking re-starts and is clear on all subsequent reads as long as
> the RMID is tracked.
> 
> resctrl miscounts the bandwidth events after an RMID transitions from the
> "Unavailable" state back to being tracked. This happens because when the
> hardware starts counting again after resetting the counter to zero, resctrl
> in turn compares the new count against the counter value stored from the
> previous time the RMID was tracked. This results in resctrl computing an
> event value that is either undercounting (when new counter is more than
> stored counter) or a mistaken overflow (when new counter is less than
> stored counter).
> 
> Reset the stored value (arch_mbm_state::prev_msr) of MSR_IA32_QM_CTR to
> zero whenever the RMID is in the "Unavailable" state to ensure accurate
> counting after the RMID resets to zero when it starts to be tracked again.
> 
> Example scenario that results in mistaken overflow
> ==================================================
> 1. The resctrl filesystem is mounted, and a task is assigned to a
>    monitoring group.
> 
>    $mount -t resctrl resctrl /sys/fs/resctrl
>    $mkdir /sys/fs/resctrl/mon_groups/test1/
>    $echo 1234 > /sys/fs/resctrl/mon_groups/test1/tasks
> 
>    $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>    21323            <- Total bytes on domain 0
>    "Unavailable"    <- Total bytes on domain 1
> 
>    Task is running on domain 0. Counter on domain 1 is "Unavailable".
> 
> 2. The task runs on domain 0 for a while and then moves to domain 1. The
>    counter starts incrementing on domain 1.
> 
>    $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>    7345357          <- Total bytes on domain 0
>    4545             <- Total bytes on domain 1
> 
> 3. At some point, the RMID in domain 0 transitions to the "Unavailable"
>    state because the task is no longer executing in that domain.
> 
>    $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>    "Unavailable"    <- Total bytes on domain 0
>    434341           <- Total bytes on domain 1
> 
> 4.  Since the task continues to migrate between domains, it may eventually
>     return to domain 0.
> 
>     $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>     17592178699059  <- Overflow on domain 0
>     3232332         <- Total bytes on domain 1
> 
> In this case, the RMID on domain 0 transitions from "Unavailable" state to
> active state. The hardware sets MSR_IA32_QM_CTR.Unavailable (bit 62) when
> the counter is read and begins tracking the RMID counting from 0.
> Subsequent reads succeed but returns a value smaller than the previously
> saved MSR value (7345357). Consequently, the resctrl's overflow logic is
> triggered, it compares the previous value (7345357) with the new, smaller
> value and incorrectly interprets this as a counter overflow, adding a large
> delta. In reality, this is a false positive: the counter did not overflow
> but was simply reset when the RMID transitioned from "Unavailable" back to
> active state.
> 
> Here is the text from APM [1] available from [2].
> 
> "In PQOS Version 2.0 or higher, the MBM hardware will set the U bit on the
> first QM_CTR read when it begins tracking an RMID that it was not
> previously tracking. The U bit will be zero for all subsequent reads from
> that RMID while it is still tracked by the hardware. Therefore, a QM_CTR
> read with the U bit set when that RMID is in use by a processor can be
> considered 0 when calculating the difference with a subsequent read."
> 
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>     Publication # 24593 Revision 3.41 section 19.3.3 Monitoring L3 Memory
>     Bandwidth (MBM).
> 
> Fixes: 4d05bf71f157d ("x86/resctrl: Introduce AMD QOS feature")
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Cc: stable@vger.kernel.org # needs adjustments for <= v6.17
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]
> ---
> v4: Removed switch and replaced with if else in the code. Tested again.
>     Removed a stray tab in changelog.
> 
> v3: Rephrasing changelog considering undercounting problem.
>     Checked again for special charactors (grep -P '[^\t\n\x20-\x7E]').
>     Removed few of them now. Thanks Reinette.
> 
> v2: Fixed few systax issues.
>     Checked for special charachars.
>     Added Fixes tag.
>     Added CC to stable kernel.
>     Rephrased most of the changelog.
> 
> v1: Tested this on multiple AMD systems, but not on Intel systems.
>     Need help with that. If everything goes well, this patch needs to go
>     to all the stable kernels.

The behavior of the counter is different on Intel where there are enough
counters backing the RMID and the "Unavailable" bit is not set when counter
starts counting but instead the counter returns "0". For example, when
running equivalent of "step 1" on an Intel system it looks like:

	# cd /sys/fs/resctrl
	# mkdir mon_groups/test1
	# echo $$ > mon_groups/test1/tasks
	# cat mon_groups/test1/mon_data/*/mbm_total_bytes
	0
	1835008

I am not aware of resctrl being able to trigger an Unavailable counter via
these counter registers on existing Intel hardware and as a consequence do
not expect this new flow (ret == -EINVAL) to be triggered on Intel. There may
be some differences with RDT MMIO counters that I need to look into but since
that is not supported by resctrl yet it is not relevant to this fix.

Tested-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thank you very much.

Reinette


