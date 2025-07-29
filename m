Return-Path: <linux-kernel+bounces-749809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D448EB1531B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0465C4E4141
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C4C24A067;
	Tue, 29 Jul 2025 18:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gGn4nX3Q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD7E1A0B08
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 18:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753815023; cv=fail; b=l3icf9+2UgwJimsCSeJCrzhDJcDB/GYRL9D2Zl7Dw6ba2HoTitLvf3Mt9z6INYL7ebI3+EFGHlu/WI4B8P4H+kVTFOghsFTmEvedN6ca8l4fAOEnNMGSt5TbovpUGHFx/YeSNPUuMazElU19tWNeZgH6yRSRU+/hiBXBJ8mxKgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753815023; c=relaxed/simple;
	bh=o5E1J1KFpoAb5fPzW4kvbEnG/jmlOvcWZ5eV4LsM5kk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dZzRJrr3UB12E6aZG71EG82IY342m8rZnLiaM2+xEMrees4cNKrkA4VM/mjJjZQI5hlFJ8EA/VTOIWCwdgSRQ0zOO3ytbEGM9vB5rJQ3ePoMC8ifrm2VWIzZEVZ/CzNWIk7DUwCjBHh2IgTtt8/NdYobC4bMeIiHU8/PtNuOZV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gGn4nX3Q; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753815022; x=1785351022;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o5E1J1KFpoAb5fPzW4kvbEnG/jmlOvcWZ5eV4LsM5kk=;
  b=gGn4nX3Q+fI9hDNiWpyPkH2WAP6SVS9wWwm4HjG9lwo7jyqQNEmvgJBC
   N1enxjfiALRVLPfXJ6ZIDMo11ToAqrNDuGxTVHIVwrik1JxCaHdqkpHpu
   hw4/kDQZ/oBYEN6SqqcIMgH+tV/5Z+jwNt4OXhItIuS3F4yj2LsCwxQQK
   QoWa3ydLPkofYmDWdVtyxLM/RpZwUA2lDYoKZr+fPG20mFpi3sw/Z89R/
   FNFLJIIqFv0O+KP9rOzesJuP6SpY6Zb8xcMfbrekD5K27ORXguOLFg/Ha
   UnzFTWDu1+Sxho2MD4hq75p3XICYyNKEVEndzxt8ZofGAPc0qm969ViZ/
   g==;
X-CSE-ConnectionGUID: Qigi6JcaSq2IT8vpdQg7iQ==
X-CSE-MsgGUID: qTowr5s7Qs6q4NkfjyLF9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="81542941"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="81542941"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 11:50:21 -0700
X-CSE-ConnectionGUID: ogfsV15SQMuJ55jqmQvYig==
X-CSE-MsgGUID: 6bbVe9TvQMai2wNaDRnNuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="167036707"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 11:50:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 29 Jul 2025 11:50:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 29 Jul 2025 11:50:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.43) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 29 Jul 2025 11:50:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QktNZ3u3lW0xyq8FvyWgk/jnSu8YvH4GZcJVtXYTMIVgl9Aa/nJgKKisYmCp6dNgt9Y3rA34+CaBR0pQR/VCCSXs/dvg5Orinhe6xhZbFoPCQPVClbRlznydzO207/BmX3sfxUY23J7LIOKeP6AAc+6kD6QoXo4HnP6hC0UIKZw5IS5ba0W4Loxjc+Be37c1ZrSaHnYrbPY3+Y8LAcwl/ymiTXmkaeHWayXc5ZVoBqtz5XHhPuAovEujWVEadBhXwrbIXegmvNrD+2MbCsjYMOiS3dey7CCl+G/9RkYB7g8KOaZeHfFbLsGOtUjII5slBqPVx8X8DcXzPjUjEtfm7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKBXf6NLAXexh+b4qzvXSSjauxJs2nCht92fr+rbFlk=;
 b=XjNcCXDTS9Mtumiw2jHqMHmtJsra5bJ2CzYIhWMWTlepqXgnFO3xsVAbFmRcKPcD+uZ3VpDiZ6B+1f+dSKRxRVCHMiAkgWixHF+WkV9lD1JfXZfe2cKMmnSxwr8mhr0196vXpLWdA+JSONmr8XKZ6hcDOLapjEAASw5eG1/ACkg+FmQhrXBQIQj19ty99brBxDz6dMhEkbWlk5aHJhXmrQX0+XtNiwEj4BO5wvl81uvCc3KBg4dLzcHZYTnA9AZYEhsW3O6LEwZweYRvaEMNQAPuimWZ8pZ/IZqI+O3kNWyEGMNf6Ux8JIe3CJZdS3bL2LWC/381ocqXa9RLtxzSxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS7PR11MB8808.namprd11.prod.outlook.com (2603:10b6:8:257::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Tue, 29 Jul
 2025 18:49:48 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%7]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 18:49:48 +0000
Message-ID: <2d30ee37-8069-4443-8a80-5233b3b23f66@intel.com>
Date: Tue, 29 Jul 2025 11:49:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/intel: Fix always false range check in x86_vfm
 model matching
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <darwi@linutronix.de>, <peterz@infradead.org>,
	<ravi.bangoria@amd.com>
CC: <skhan@linuxfoundation.org>, <linux-kernel-mentees@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20250729042621.6403-1-suchitkarunakaran@gmail.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250729042621.6403-1-suchitkarunakaran@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::8) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS7PR11MB8808:EE_
X-MS-Office365-Filtering-Correlation-Id: 4deceb9e-c0f0-45bb-f2e4-08ddced0b174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0IycEhad2Y2a3JSLytNU2Z3aWF1LzlCU3lBbVAxSDNRc0tiUHJiaTZDQzFx?=
 =?utf-8?B?cmZlNTY3U2ZsVlNTeDFVVzBZcEdxMFQ1VTJOMm9UOCtJbThzbmY1NnFaWnpj?=
 =?utf-8?B?Q2J3TWdDQUxsTnNISzN0dnI1emwyaFB1VUNza1dhdXZ1Ni9leXZoL2I3WlVm?=
 =?utf-8?B?S3JCaDNsT20rSFNRY21GNEwvS2hLYzF5azNKcnY5cTFLVXNFYVN2aTJqY2k5?=
 =?utf-8?B?TGd0cU40dkVvT1JuUzI1TFUyMC81dVhxRDhPNFRsZkJKWGd2eFlKV2IxWHRC?=
 =?utf-8?B?NDM0NlpVbkQ4UTVEbmo2MlVjanc0eXBOcFJObjdCNmR2Z2djRW9OeFFiY0J1?=
 =?utf-8?B?U1lNeU12ZGFCckZad1VuNGhhdnluMzVUYzdmaUtYVDVYdGZmTkdYL2E0SUcv?=
 =?utf-8?B?Y1lSUmFUVXkyYVBMdlF4eGV4bG4yd2QvWHUwOHhwMGxhdFdGMVozOXhjclhX?=
 =?utf-8?B?aTY0V3BnREU0NmJnRDkxc3Y5TU9uVTJKWHBwQVh3bXNJckl3WlFkcFpHaC90?=
 =?utf-8?B?VFZSMWZ0U0hUekVpY1IwVlVCeUUrVjRWUWxWS05PY2VXZEgvUERvYkFNUEJQ?=
 =?utf-8?B?SzZWVzMxUm9rdmxtajhONEJ1bklaVStWVm12cFMyVnlTdDdtb09JVlJ1bEFT?=
 =?utf-8?B?b01yRktOeFl4VkdXZXRsVlVOZlE5SklpdXlnTi8xbElKQVVxQytkcTk3TnFZ?=
 =?utf-8?B?YmQyN0FMOE94L3dyM2xsZ010OVkxRlhPZUEvZnhlTVY0azlUSEdXVGs5a3RI?=
 =?utf-8?B?bUlTbTJYT0ZMaWw2ejdlc053T1Z3OGo3NXhpMEhJVHJlYzQrdk1HR3YyMWtR?=
 =?utf-8?B?MzBHN094UFRvSFJpbnRJM2UybCtnaUcrR1pDNDh0bWp5SjFHSWVZQVczYXpr?=
 =?utf-8?B?S3hlTngzbWtCcHg2TnQ0WG5uVTBrcUNRZG5OMGVjSGhEU3puTEZmWHJJZjNw?=
 =?utf-8?B?SWFZbldrR21zZmVFTzJQRzUxdExSOWNWMVA1b2FCOGNEM1diWGJYNFNnS2J3?=
 =?utf-8?B?Q3EzSHlzV1JSNmo4V1RlTzZoVEFVQk5LT0UxOURPMzQwa3d3blZqQVI1eDUw?=
 =?utf-8?B?NmV2VXJMRmUzRi9nTi90MVJpQXo3QXZvV1dIVjJYcXZwcHdxSVd5WktaRkZ6?=
 =?utf-8?B?cGR3Z2lZbkkxRUpZLzNCREpMajBPR3NuQTZ4cTA4di9yOHEva1dVQU4xZ3VC?=
 =?utf-8?B?ZkV5dE5QOStyRnphUHg1YUd3RHFyZG9hMkFoOVdhbTU3RjlnRXpmdjVDaUdh?=
 =?utf-8?B?aUZuZkh4bzFHMlpQRmZIK2o1ZmRzSzRTMWJVUU52WXhWemFLeUxBbGVWb1oz?=
 =?utf-8?B?Q0EyWCtwclo0M2I5TmZ6Vzk5L2pVQlBueG95bm91TWJjMzFhbmhGWmIrNWRB?=
 =?utf-8?B?cGFRQ09zYXhmclIrUVdBMlV0TXV5VzJSVUI3V3lQQmxFWm9MSkZMQ04yamJX?=
 =?utf-8?B?REY3VVJFNFhqZ29TaHRCeWhzZVQwNC81Uyt0K3VWN1hhVjI1akx2S2J4SFdF?=
 =?utf-8?B?YUVYSDBoM0FGVFAyMXk4ODExTmdHdTE0d3RNNHJ5d3ZJZnRoR0V6S1BmMThG?=
 =?utf-8?B?ZEN6YXJ1THcyWVNSMStmTlhPUFdkUWFYZndHNXFCRnhBeWkvcmNwSzhLb1lC?=
 =?utf-8?B?VmpZMTFkWVRubDdyWXk4c0JMTTNXMlFVak5MV3o5RkhPV3BEM1NIa0lvTE5z?=
 =?utf-8?B?S0w5aUY5QkpUMVkzeUhjVXF3YkREU3hLZzNmblgzcm85Skx1ZThiaEFrYTh6?=
 =?utf-8?B?OHdtczU5dkUvc3JsV2ZhL0lSNDFLSFZ3VlFaNXR5OXRxbHlNVWx4QTFoOW9n?=
 =?utf-8?B?b01VUktONmhvQ29DMU5Fc3M4Q2liYmx4Z2kzQWJnaU9vT2JBUGd2aDdsOGF4?=
 =?utf-8?B?NFRGUmxWbXN1VkRrNk9sMkxYRlFKZ013NFJPZHlvZXQvNFVVRDJrcXFuT0l2?=
 =?utf-8?Q?WEXV2Wrd1+s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDkrZDJpVnNaUkhYT3NvTG1JSytjOVlZSC9aU0hiTUhSWnI1ZFFENU5ZSjdk?=
 =?utf-8?B?UHBxQnZDUGNXYjdYdW0vak9WSUxtdjVBSmJEMllkK1dlRndQZFZqZEVIMDBL?=
 =?utf-8?B?cEFaaUZIbHJMTktlN1d0UkdnWTVuNjJRVm12bVpBUzVBdis4dCszRU5hbkRL?=
 =?utf-8?B?WStndk1tWUl2TUNHUS9wdmljeUNLckVJQmVzd2RZd3Y2MWw0MVZBbm9HNnB4?=
 =?utf-8?B?Kzk0dEEvTm81MlF4bzVYVFVCcENCNGlXSFNSZjlKYTE1RXFCVXNSV0NuL0NH?=
 =?utf-8?B?UFJIZkd3NmJIeWt4azczQUVvbWZ0bXBndGJ5SVd4cFJJeWduV1QvZ2ZkL0M4?=
 =?utf-8?B?aUdBWXNGOEZEZDU3MyswazFESjJFMVlMY2thRDliR3J2QTZtckNxZVc2NDRx?=
 =?utf-8?B?eHJuVmVOU0pURjlIdkYyM1hSRHhEdUxwS3pxNnovWk1xM0w5am1BMEEyTFJk?=
 =?utf-8?B?SVIzN1l2VnBGVlowK05zNUNZbzNEcGdGZmpKQ2NKV21XaUZpNEVZV2t6OHo4?=
 =?utf-8?B?d2h1MC9OY1BRQWJPR0R2cEc5SGthWUQvKzdvTjF6TFhLSnV3Rkk2NzlxZzlt?=
 =?utf-8?B?TFJUQzF2bWZabWRUMS9SbzZPbDdoQU9RT0diSGtuQ3AvaE1EdVlQaFo0cGtN?=
 =?utf-8?B?QS9jNHd3OWFpN2VkdUcxSExXaStpQXB0Q0F5cmwwVSsrOWFGSlFra1A5Q2hh?=
 =?utf-8?B?WGtWdE4zWXZMSHZGenBobDZqU1JMM1ZzSkFvQWxRN1VDQ2E4Z0FGWE53dDli?=
 =?utf-8?B?YnJrcUxXQStqaG1RNjF2MEdTbnkwZjM2djBJb1pKSXBCZDRONFN1aitoN2to?=
 =?utf-8?B?eE9LYmJid0NqRGtwR3NiRXJSR29jZkJBalkzSFlCcHh2dEZxVndyWUhpWHdt?=
 =?utf-8?B?Zzk5QndFTUNQYTN2a0lBM3hBUFU3bUxKZ0xtVlRwRk5WUFpWaVFNNDJvdzA0?=
 =?utf-8?B?S05jejA5eVd1VmRHUnNHSTJSN3pOY1BpWDVhaXp2ZjdWZnRwQlJRWE1acEFl?=
 =?utf-8?B?TzZaeVl2WFRwWG10RVMzandrNkdyMTY3bFpTYytSNHBNa0w1MDgrSG5xc3ZV?=
 =?utf-8?B?U3Aza1ZJOE1Uck5WeXdxdE1UbHN5cEVrbjcrUnBLTHhISVFyVmdXelhOQTgz?=
 =?utf-8?B?TjhzVllWQVhJL3c1K1RPZ2lFOUNBYnc1eXdUUUZON3dmOWxISnJySWdZemFW?=
 =?utf-8?B?c3BHcXkxZlZqa1VPK1locFl3RnBVNjRWemdGTTVMSlhkNEpHQ2xmUzBVMVNP?=
 =?utf-8?B?TWtydEY0Ui9yM3BjTExNSnJtcDc1TGxDdXZ4ODAzSkJNbEoyUzhqYk4zWTNJ?=
 =?utf-8?B?czVKRGY4THNlMDRXNkNsUEVpVlFpQkR2MVJ1ZlpHaVpIOWRHeHJ5TzJob1Jo?=
 =?utf-8?B?SXpRUHphOVJmVVYvR0QvdHpGVndLQXhPNHVKYWpaaEs0MGh0Q3ZFNXdiN0cw?=
 =?utf-8?B?cWxGM295WloxMDFZOHJqbTBpWUJva0lhemgrNnkwQUt4UGkzcUpPQWU2STNY?=
 =?utf-8?B?R0RONXZsamlnODc2QlJOWUtKbXdKd3JoWWdvSzJuZTVqMEhKMHViZ2JEQlJX?=
 =?utf-8?B?Yzd5WlZZa2YxR0M1TUJtRkFaSng3N3o3WTUwNUxIZjMxVlJMZVB4ajFCeVJP?=
 =?utf-8?B?OU9nMWJnMEZJUitVVmRMcEVzNnhnOE9ydlRjUGZjcVBac3VXSlFKRUt1UTUy?=
 =?utf-8?B?ODFUWVgwaE12OXhwbW9EYXhYUlZjdGtYdlR3Q002WDNJaUZLWUVrNkZSNTRT?=
 =?utf-8?B?cUNCY2tPNW1pWkxaS2hMS0NJQlFrYTZqQXpUZFppYWNUc1VOZ0Y5b25RRjhx?=
 =?utf-8?B?RW9EbWFuVjBYeHUvVUZLYXQwTVJBYkVUVWxHeGFwRmpuT3RNNHgvd0MrOVVN?=
 =?utf-8?B?YUVSdGNFZ01ocTUvVm96VXk0d05jQWhkZDRWKzBBV1lBaDhIZ1ZhQndhUnE4?=
 =?utf-8?B?SERaZHZuTjJQcUowU2F2YzNJRktWNnJaTS84eWZVOU1EQjRkTlJ4ckdwK2Vr?=
 =?utf-8?B?ek4weUdhUWpnUW9LVElzRzN4eFhreWc1U1ZadXM2UllvYzJKWFB4M1dzSGlt?=
 =?utf-8?B?WW5TM0oxV1FRL05GRWxlQUl5eWRNWGZjVlU3UW1zZ1lYcC9iOTJHdktZWkIv?=
 =?utf-8?Q?F/PaLCA5oTTXz9NteJ81J7zS+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4deceb9e-c0f0-45bb-f2e4-08ddced0b174
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 18:49:48.3932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: usHSzE2/Pp8HGB0fn6AQJmBglOqCpvMUpxE5T2tbFhkiAmvpvxbSd/HXWttav7kfkprsaU4rVIOc9qFeBj+gYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8808
X-OriginatorOrg: intel.com

Though the title is correct, it is better to make it more precise.
Something like:

x86/cpu/intel: Fix the constant_tsc model check for Pentium 4s

On 7/28/2025 9:26 PM, Suchit Karunakaran wrote:
> Fix a logic bug in early_init_intel() where a conditional range check:
> (c->x86_vfm >= INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_WILLAMETTE)
> was always false due to (PRESCOTT) being numerically greater than the
> upper bound (WILLAMETTE). This triggers:-Werror=logical-op: 
> logical ‘and’ of mutually exclusive tests is always false

We can focus on the why instead of how this error was found. How about
wording it as below?

The logic to synthesize constant_tsc for Pentium 4s (Family 15) is
wrong. Since INTEL_P4_PRESCOTT is numerically greater than
INTEL_P4_WILLAMETTE, the logic always results in false and never sets
X86_FEATURE_CONSTANT_TSC for any Pentium 4 model.

The error was introduced while replacing the x86_model check with a VFM
one. The original check was as follows:

	if ((c->x86 == 0xf && c->x86_model >= 0x03) ||
		(c->x86 == 0x6 && c->x86_model >= 0x0e))
		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);

Fix the logic to cover all Pentium 4 models from Prescott (model 3) to
Cedarmill (model 6) which is the last model released in Family 15.

> The fix corrects the constant ordering to ensure the range is valid:
> (c->x86_vfm >=  INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_CEDARMILL)
> 

This line is unnecessary. Changes that are easily observable in the diff
below don't need to be described in the commit message.

> Fixes: fadb6f569b10 ("x86/cpu/intel: Limit the non-architectural
> constant_tsc model checks")
> 

The "Fixes:" line doesn't need to be broken down into multiple lines.
All of it can be on the same line.

For patches being reviewed for upstream, adding a stable Cc (Option 1 in
the stable documentation) is the easiest and preferred way to
automatically trigger submissions for stable.

In this case, include the below Cc: line after the Fixes: line.

Cc: <stable@vger.kernel.org> # v6.15

> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> 
> Changes since v1:
> - Fix incorrect logic

Patch-to-patch changes should be below the --- line. That way they will
get ignored when the patch is applied to the maintainer's tree.

> ---
>  arch/x86/kernel/cpu/intel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 076eaa41b8c8..6f5bd5dbc249 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -262,7 +262,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
>  	if (c->x86_power & (1 << 8)) {
>  		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
>  		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
> -	} else if ((c->x86_vfm >= INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_WILLAMETTE) ||
> +	} else if ((c->x86_vfm >=  INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_CEDARMILL) ||
>  		   (c->x86_vfm >= INTEL_CORE_YONAH  && c->x86_vfm <= INTEL_IVYBRIDGE)) {
>  		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
>  	}


