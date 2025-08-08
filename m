Return-Path: <linux-kernel+bounces-759624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1400B1E046
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 03:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689C01AA0CF8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 01:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE0414883F;
	Fri,  8 Aug 2025 01:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KboWQw64"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316A1125B2;
	Fri,  8 Aug 2025 01:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754617693; cv=fail; b=KmLNW6jYCn6iXhPoIIIeyLbMFoA91Oce/vtq1CE3mYdHX8x/o0J1a+tbPKffkQxEGmj3KAGNNSUGJFzLaTSPMVNc36UmYVDJMLB1LEh8fOxrtKToEOXxBZMCStpZsGQ7eEllDDubj/m/QIF3COUlv/L9sdCzhBWUKAv4yqQteX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754617693; c=relaxed/simple;
	bh=favziMk/VR2Y22117qydXjbqq61wrlZXswOUccw+KaQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GqTI0xl/NXUOAx37nJW2BPauL7zNr51pGzuGKFDpF+7LQtLECEfPJLFg57VCBYcxfbbEi9uAe3GT4j+1lg2f9uv3RHKzm9CI7YoJi6lTeXUrrIzkWs6oRhhXNPvZZz+Vu0S0oz4s/6lVc4TsCpU9Z+lsskX2p/lGvrary8h0MOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KboWQw64; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754617692; x=1786153692;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=favziMk/VR2Y22117qydXjbqq61wrlZXswOUccw+KaQ=;
  b=KboWQw64HQ+yXxS75EI0/ASyIeUQq/wYH1bUFLK0NHgJ690Xx8zbr4Ts
   vOXcQESVcNWH0HsPHF2rXeE8IaFHdSP983xNurgNfDgsA52g83uyDMvGf
   QHJf0gOhfLmtNkk6BWjJB8oVFldqkteWXiZMArrteX8w7sF3SNoK08TB7
   Y68Qy2ciZaE4bGsFty7zK3/+fb5zlLdtqXr3wxG6iCQZUD3BFIGYLaaua
   tKJOtiH+7l7aWfyzCu8r2dIs/7AJuAb3kYrk2ziQ4joWPgTHyIlZsx5aG
   GrQCGsoUD4OCQzIxtNp4QHJ/GzWCGKwKPFiZfBRVKjdPVsk2QRAxNr/Jg
   g==;
X-CSE-ConnectionGUID: 2TgS1FwQS4CkC3mEuDiDhQ==
X-CSE-MsgGUID: 73D/9+EbRvyvTONEV6ekkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56001183"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="56001183"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 18:48:11 -0700
X-CSE-ConnectionGUID: cK7AvN1sStCFxR7FmfHQ3A==
X-CSE-MsgGUID: kwjcokaORgi9gX2v/R2GIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="169666937"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 18:48:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 18:48:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 18:48:10 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.45) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 7 Aug 2025 18:48:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fc15xdwaTGF/jFcBJ+UOgE2Nx2Wru6xxDil2a304bmSaCHorgiDCp13AwbQHqTAD7my+pz+1OcrSFoTV7RfSc+iHHmdkicP/PeRHeUG3HIrVMtvxFRBBs+L3Di53P5B8hUQx6kizKyDuG+c8GlqssiQt6MtCvtvKuB+KcbQ1bnXlt/u0C6PdOYT6PRbh6+Var8vdwlmaLeKF7nkYgjmRWw1GNrPdTgP1I4jEoF/LikHLVVMaviJvxcWnxLSHxQEV/HWjcXTHvFWkhNcy79cAO73jV37draOLbM58+NK71l1qWXKVEqNMTFZy5cG1dgCYZ54Q0WcqcXrqkWpikcoCzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2vUYXjZNQThhxeXWK0JpHUqNQCUSEXZDcBIVlhyyOs=;
 b=U+9mETU1luBkX2xILMRdfVtX5Y5A6SyHyq0ZTBA+F7Y/yApdMnigeD0m5Cv5KD+u0T/g3kfxfIDzFCB4iOnSr1N+PVObNVQ8vvWz9FGAfiayLzQrk/k9vXapnVylWn+R1G5KYlnIK4WI0C6PFyFdwmzVnMyy35Nd2atiGG6baWOEvLD5InEFbKfm3uX8hROgMz/+Nqf0HRDeHYspqeOznLCq7fxzcOpQsIOFHlb9fLPkUN6/FOIJbu08mYyfKM3Cex4PBtx8s0Fgu/ZsUB6nEVH4J3HqW57rsffy5bs8vMLyOEFmidOTkNUyLC+tpL6hmCiRey187xJY2ePWFbZStw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW6PR11MB8390.namprd11.prod.outlook.com (2603:10b6:303:240::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 01:48:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 01:48:07 +0000
Message-ID: <d566dcf5-fb4a-4d28-a7fb-d173d423c83c@intel.com>
Date: Thu, 7 Aug 2025 18:48:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/10] fs/resctrl: Introduce interface to display
 "io_alloc" support
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <rostedt@goodmis.org>, <Neeraj.Upadhyay@amd.com>,
	<david@redhat.com>, <arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <pawan.kumar.gupta@linux.intel.com>,
	<yosry.ahmed@linux.dev>, <sohil.mehta@intel.com>, <xin@zytor.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<me@mixaill.net>, <mario.limonciello@amd.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <ak@linux.intel.com>, <chang.seok.bae@intel.com>,
	<andrew.cooper3@citrix.com>, <perry.yuan@amd.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<manali.shukla@amd.com>, <gautham.shenoy@amd.com>
References: <cover.1754436586.git.babu.moger@amd.com>
 <1004ca25abe2f7460960f08bf9bacacbb5b07b3b.1754436586.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <1004ca25abe2f7460960f08bf9bacacbb5b07b3b.1754436586.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0270.namprd04.prod.outlook.com
 (2603:10b6:303:88::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW6PR11MB8390:EE_
X-MS-Office365-Filtering-Correlation-Id: 0627ef8a-9caa-46d5-9243-08ddd61d9f6e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzRNR3ZabDU5VG5lZWNqU1VsOXJWUFpzbkYxYVpMcXdGbFluOGMvVzBNRWtY?=
 =?utf-8?B?dmwvZXJhZmNWTE5lOUMrbG9oMFRCVlNIYlE1cVovN3VzanA1R0J3NnQ5Skxl?=
 =?utf-8?B?c3BoZ3Y0VVRWQW5kNWQ0Z2J4TFZWNnlWeW9OalF1UUp4RFZJMFU5LzIwOHFo?=
 =?utf-8?B?M0poM2xvTXA1VEFXdzdjOUpjUTJ3bWlTYlVHMGJLS1ZoemlpNHJGb2xRN2p3?=
 =?utf-8?B?a3hLTVhzWm9pcHdzMFM5V1g4dVMxUEJOaFlmWXptaVU2RjM0S280eHY2VWN0?=
 =?utf-8?B?MnZmUUVaeFozZEsvcmF4UlpBaFh2emVtQWlqYWZsTTl5VVA2RXFiRDZZUU1W?=
 =?utf-8?B?ekJXZG1wVFBOd1Zaa2c2VkRqSU9SSHd1T2pZN2d2WGVVQ3dQQjBsUDZIbFZS?=
 =?utf-8?B?ODlEK3QzdXd4MnpmaTlzdlQreU5QbnVUdzU5eHFIaUtUT2RNRFg1aGx0SHdC?=
 =?utf-8?B?ajM5MUlXbWdHa0Q5ME42Y0k3bUxkV1R5b1NYNTNxZG9uNmRJMTdINnl4REFm?=
 =?utf-8?B?SlRUb3VKNStwaHZZOHArRkpqMlFCK3RkYnVyVmlETmFyVFk4MHd4T3hGUm4v?=
 =?utf-8?B?TE1ZcXQwc1J5MnlGaGJwUmVsKzYzNnJldlJIT3lVNXRwS0c0ZUhITzF3SS8w?=
 =?utf-8?B?a3cydjEwQ1h2MENka3U1T1FicTQ0TTNDYzZ1SmVKNWpnYnliWE5BeEt3NEdB?=
 =?utf-8?B?QlQvcmNCckt3eTEwWklYeUM2cTBZR1V0bmVUbm45Y1hNS0hNd2FaZ2l6WGJz?=
 =?utf-8?B?YkUwTng2VXpiY2NIT0pFd0hOQkxFRk5yVm1xQ1diaUVPaVpXWXVVU3I4VWxp?=
 =?utf-8?B?OThBRGVSSStWTkJBUUxkZUJJRHMxc0NEQ3drZWY3TGpwTUNHbGN5NFU0V2F2?=
 =?utf-8?B?R3c1NXg2TlZ2SFBWM0pWQ3UzRENLNXZXUFQ4N2hDdnNwbTBsZ0xTL21RNUZq?=
 =?utf-8?B?T2NOc2NzSjRCKzZhZytEQmNvb0tJNGF6alB6c0hlNjFwdzRJdHl0V0NOcTZm?=
 =?utf-8?B?ZXJwdTZvRWhoNm9yQzRVMlR4djNWejZEVXdkNDJtaTYxMWZOd1kwMk12bTZn?=
 =?utf-8?B?NUUwWEtQZkRkYVY4V2k0cW9PVmJwaSs2YVBzNUp3aUVYdXd0TGU3ZjBWOUJL?=
 =?utf-8?B?Q3hLVXVtbE05b3loaTBpUHoyZFM0dDJBN2FicHp2NktWbmtHeTYrMlNMdHdy?=
 =?utf-8?B?b2pwcWF5Zlc1V2c4emtTQmR6eWpMaGxvQkE4b2RQSGx2QTNHRW5hUWxoUmpZ?=
 =?utf-8?B?UDNhdGFKaHZQQzdmcVlwT1dVWUl5WU1mUGs4czk0NnFOWUFIc0VqdmorbUx2?=
 =?utf-8?B?c2lxU3B1OTJGalliaW5LYUtrTFk0YjM5cXBaSnZzSDliL254WE9GM1ZhUzhn?=
 =?utf-8?B?ZUJJdXdLWXdzeWRrUTFhcndPYzlQL0tmSXdhRXZSRURlSGVDelgvMWk2R1JT?=
 =?utf-8?B?dk1ZWUYxcVlvQ3lGL0Z4Szl4MHZHT2NxSEJWOHhEZEFyOWlUNzFhWnVyZmh4?=
 =?utf-8?B?U1hlSTRNQ0xPdUliR0F6TzdsM2J3QkNNTWJUYWlOWlpWcmd6S3lZQ2tGQ0Np?=
 =?utf-8?B?bEhVYUcxL2dFZlhXSm11cG9jWTE1c1gzeWxuUXhvZmRGandxaUw5cUFhUG1p?=
 =?utf-8?B?QlRES0pvdWczUS9QT1ZPYVNZWTZwWlNxc0k2VHd1MDZobmhNK3JFY1JHd05Z?=
 =?utf-8?B?SG1HU3grbXlZZTUvYU16UWZ0Y3dZYkovYVdOT1U0U1pGb2ZDUnBhT0t4RFZZ?=
 =?utf-8?B?M2Y3VmEweitQQzBGVUZhU3dYRUc5RUMxM0ZNUDl1emxPK0NDcXlVVkRRZStu?=
 =?utf-8?B?WmFvOWVVdkFNMnhFY09WTm5UazVlcHdJNnNVWEVHcEkxM2NMbWhIVTl5WkNT?=
 =?utf-8?B?eGNwaXk5d3NYQVBDK2w3NnpiVERFaXVKMFIyd2Yvcy9vL2tFOEc2cFA1VjRh?=
 =?utf-8?Q?q/5G0TZnxsY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDRzbkhtWFo2NXJCaWVvNFdqUHltS3ZuWDlUUm9jck16dWNhblAvZUd4RW5Q?=
 =?utf-8?B?VGFpbUdhaVF4NGxFZGExeDhrbXI2djBYT1NKZ2ZCOXdBZThETHdmaFR1MUpo?=
 =?utf-8?B?ZTA5clJGV0NOZzdab2FmeHQzaDlONVI3ZzI0Ykl2TmQxeDVwZitlR1BnNlJB?=
 =?utf-8?B?d0hKT0k4NGt2U0xVMGVnYVdTTitjeEJwQk93ZExXVWh2S3cvbXhSK09jU2to?=
 =?utf-8?B?ZUNlaTdPcGtKZTQrRjNxWDNoMCs4bWJRVkpDMFJaaVA4Y2EzbnBGZ1RUejV2?=
 =?utf-8?B?REVGRURHRnpZYTZrOHNvU1MvYmlIdStLRjBUMTA4UlBLRGxYTjZjMGF2RFlY?=
 =?utf-8?B?Qm9Ca3Z6amtpVzMyOG9XZWpYODk1dlhYeE5Bc2lwMGs5SzErTWxMWllYUk0x?=
 =?utf-8?B?TjlENDZsMFhwK2d2cTNqbUs0NVBuMi90d05KNi9ZUHhPVDBGRnI5S3dwdVlu?=
 =?utf-8?B?VUYzZmJTTHlUUzNEdTRWK00xRGFTczY0SjhrakZhY0tEZHVCUmN5MDNZeTlC?=
 =?utf-8?B?MkR6YVF0R1IrcmlyZWhZZHU4RURpbDN1SWFCWmpWK3NCanIwaHhieWMra2lE?=
 =?utf-8?B?aDAwMWFkdXVHd0pSSnM4ZTFXRW02OC9QL0l5NUJ6Zlcvc2tuczI3TFpqb3kv?=
 =?utf-8?B?YURncDN0engveHplK29INzJyeG83V0UyZTA0SUNtc0hoMCtuTWFxZlRiSzdt?=
 =?utf-8?B?dHF4Y3hPei9nRmtQOWRCM0Y0ZWlQL3lYbFI0cjdPbE9rV3JOdVJnOW51WDhz?=
 =?utf-8?B?b25uaHNNNTRvYW51dUx0TzlVcHFLNFdVeUhKZ0djT25DUXlGa3drYjNJQTFk?=
 =?utf-8?B?emlKdFR6MldwUlRWUlNVTXZDWHkwOHM3akZSNWJqUnhzbW10N0FlOEFFSEQx?=
 =?utf-8?B?bkRrb0dqTjlOR1JZSkJucVMwaXcvZis3T0J3TnNUNVcvUTVjR0hmOW5xY0J0?=
 =?utf-8?B?NE5TZmJZK1F2dUZ6eW5EOWd2cCtsNjcyUXBuNFVIVmF6L3J6RnR2U3dheEt3?=
 =?utf-8?B?VVhwNzByVHdVTzBrVDJKTi9QbXBhbjlobkZtSGJ3ZUZzUS9BN1BZeXh4dkVZ?=
 =?utf-8?B?NUFFbklzRHZCRDV1OWVKTnlVb3lVaGVTV0UvLzVTK2E5OWFHbzZsNG5xZ3Zo?=
 =?utf-8?B?bUlHUWw4d2NNVVpZclVLdzIzQnJuYmpWZ2wxZmNBOGZwaFNUVEhJOXh0SDZr?=
 =?utf-8?B?UzllNXVuTmlXZ2lDajBaNkhieFRDZUF0OUhCZ2kxdUtHOE03U0RQTVo1UnVT?=
 =?utf-8?B?Q3ZILzFMZ2ZJdFMrc0RDc0piUkxSeXkyeDg5a0RiQ3Mza0RxWHVXMFYwZU55?=
 =?utf-8?B?TW1naHRFeVpVK3d0ZmRldVA1UUd2SjY0L0d0MktVU2ppcC9sdVVpREhSbzRK?=
 =?utf-8?B?SmxRcGc4MDdJSXdWZTZMZmRLblVaMllFV2ZxY2wyUGp0MTFraG1QRTh5SVVl?=
 =?utf-8?B?bFdNTkg5em42a00yMjU2NzF6bU5reXFjeHpPK0JzeE82SzVRWkxhTllwQlVV?=
 =?utf-8?B?VEVlaHdMOTE0cVZQR0tVS0xtZG5tQnFxcytvUFZoS2RtbTZ3Z1VEeWl6U2Ri?=
 =?utf-8?B?Z2VXc2ZiQU01YTZ3VUFWdkZrRlgzZy9qZVZ4U2hBWXJha1pRckw3TEdISThW?=
 =?utf-8?B?ZktnQmxyN1ltdmJZMCtiL2QvMmFXeEY4MG80YitSMWRSQ1JUeU4ydHpObFJ4?=
 =?utf-8?B?dDlDU0xMbGFQU2VJK1dMOWt3OEl5OEQwNzkrdW82bytJSlpaU1RNMlRuYVJv?=
 =?utf-8?B?ZXBlTVlOVUpWNXh5YS9PcTFsMXFZanJ1U0ZLK3czZ3VnMlVMM3c5YTlseXND?=
 =?utf-8?B?VmFWZWtPZmtFbURFU1RCcFBQeG5iMEUrMHEwU3BKTVdwVjczNmdCZCtRczlH?=
 =?utf-8?B?d1oxeFJ1VmtzY3dpbG90ZG5PYnNjUTFiZDYzSU5jL0dJNlBQMHoxejRnaFZ0?=
 =?utf-8?B?M2Rxc2N6R2lyZnhTRnh4TXN5R1JqNVloTDNpTXBQaHR4dThCQ2k3QUJzbjlC?=
 =?utf-8?B?clpLSVRFMC81cEh3NlFKQ2xyZ2lUNi9YcUNDVEppRGJ5VDJGQnFaVytVUFRJ?=
 =?utf-8?B?bll4NzRjaGpYRlJsUnRDVlo0QmlOa3dpcWRackN2VGhqazZmTWxsVXMvUlNS?=
 =?utf-8?B?emVFOHdaQ2EweW8zVWN2SURqVVlEeEwxSU5YTEEzR29yOHkvU1RrQ0V5aDhm?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0627ef8a-9caa-46d5-9243-08ddd61d9f6e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 01:48:07.5392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Ll0rt3a2xeVTNh6EQCS0jBOUY3FsBYNNsXcFbl5RygWDIg9/5Yom/0B3oRJp/k3qonsvVc8aHOT/WTC+JKx/UJOO6r7/Si149vI3+UoLwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8390
X-OriginatorOrg: intel.com

Hi Babu,

On 8/5/25 4:30 PM, Babu Moger wrote:
> "io_alloc" feature in resctrl allows direct insertion of data from I/O
> devices into the cache.
> 
> Introduce the 'io_alloc' resctrl file to indicate the support for the
> feature.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
...

> ---
>  Documentation/filesystems/resctrl.rst | 29 +++++++++++++++++++++++++++
>  fs/resctrl/ctrlmondata.c              | 21 +++++++++++++++++++
>  fs/resctrl/internal.h                 |  5 +++++
>  fs/resctrl/rdtgroup.c                 | 24 +++++++++++++++++++++-
>  4 files changed, 78 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index f08699030312..fff7e04d1e2a 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -136,6 +136,35 @@ related to allocation:
>  			"1":
>  			      Non-contiguous 1s value in CBM is supported.
>  
> +"io_alloc":
> +		"io_alloc" enables system software to configure the portion of
> +		the cache allocated for I/O traffic. File may only exist if the
> +		system supports this feature on some of its cache resources.
> +
> +			"disabled":
> +			      Portions of cache used for allocation of I/O traffic
> +			      cannot be configured.

To help distinguish difference between "disabled" and "not supported" it may be useful
to prepend something like "Resource supports "io_alloc" but the feature is disabled."

> +			"enabled":
> +			      Portions of cache used for allocation of I/O traffic
> +			      can be configured using "io_alloc_cbm".
> +			"not supported":
> +			      Support not available for this resource.
> +
> +		The underlying implementation may reduce resources available to
> +		general (CPU) cache allocation. See architecture specific notes
> +		below. Depending on usage requirements the feature can be enabled
> +		or disabled.
> +
> +		On AMD systems, the io_alloc feature is supported by the L3 Smart

drop "the"?

> +		Data Cache Injection Allocation Enforcement (SDCIAE). The CLOSID for
> +		io_alloc is the highest CLOSID supported by the resource. When
> +		io_alloc is enabled, the highest CLOSID is dedicated to io_alloc and
> +		no longer available for general (CPU) cache allocation. When CDP is
> +		enabled, io_alloc routes I/O traffic using the highest CLOSID allocated
> +		for the instruction cache (L3CODE), making this CLOSID no longer
> +		available for general (CPU) cache allocation for both the L3CODE and
> +		L3DATA resources.
> +
>  Memory bandwidth(MB) subdirectory contains the following files
>  with respect to allocation:
>  

Code looks good to me.

Reinette


