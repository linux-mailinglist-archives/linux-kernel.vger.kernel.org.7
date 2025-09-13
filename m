Return-Path: <linux-kernel+bounces-814963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17356B55B9F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 02:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17EF585BD3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 00:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB106BB5B;
	Sat, 13 Sep 2025 00:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gZf9tOX6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CD111CA9
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 00:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757724719; cv=fail; b=UVrCWrSUuJiHgPP20UawmhOhSmpjEO27Cu9t6DVglvYyaAiSyJIED1/3YekiM9tbHeJI5s8D0l26HXWl6krguI1rgdk1yymVrU/WxMmTpTB1rEil/c+ytpjuq0WYvCslzRDGfPycCms1pZbvbrArQ1iqv3qCGVhjKVzLikYwfSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757724719; c=relaxed/simple;
	bh=1GZiFMf3+iy56gNFpvHs29CF08hoIlwvfMRJrWtNeDU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lup44ieet+05sdon8wc2Z2QmepMe3eQ/6KZaYc36RJFbeRmEUG25HED2Mv6fU/OXB+KPYt09RGiJMWLnzMJAHnwv5HARAxt6HQlpOHm2etVoOUtUmQckIHk7sCfjbbJAwOUszQVZKrS4jNmDvyzXMxAqZY1JpwBhg0sopZkow1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gZf9tOX6; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757724717; x=1789260717;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1GZiFMf3+iy56gNFpvHs29CF08hoIlwvfMRJrWtNeDU=;
  b=gZf9tOX6xjYn0hkhlbvOEdAcgp2izA45/CpqyqyQo3VRYNo6C7AQQphn
   7wwigYcljhBBF1/AMMCb/lEPmaoNzL9dal8tN0Vd26/SOP/nKK6wMmn9L
   5j6xmGk0peb6OnvcJ9XIgAHkNjLHBFyoOZ76NCSTxo3byGe5ezAbmgClu
   F8qA2ag2doNir3ALylgPRiGsAxMQyAvqaGxArAyGNZXT5sGVMxT96upHO
   awZys8r5P27fNsLTJgsiLHkQzSV8G9xx4Vy7kNbZWRLLrxGy+EVWUIQDz
   qYqbJyhaUjt97upCpLEKccpwef3kNrlc8dRBXRjz7VoVFQyD29s9BGKl2
   Q==;
X-CSE-ConnectionGUID: SNO9pRLDTg2bjZ++vXX5Ow==
X-CSE-MsgGUID: 2/r0ePBAT5+lELza0SUk6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63894209"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63894209"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 17:51:57 -0700
X-CSE-ConnectionGUID: 6WG0OdYrQ1S7B29W53AW4A==
X-CSE-MsgGUID: WXE2VAXAT9C0ynO4N+ZCQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,260,1751266800"; 
   d="scan'208";a="174509794"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 17:51:56 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 17:51:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 12 Sep 2025 17:51:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.75) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 17:51:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8EfUcTWLk01l88qHziZ1KA3FMjJNvetImJ3Ov2kRTsdv22hSqOn0sR/CNz68dnWgeC1lc555fyHpHLZv6lvcMfLR8ef7gLxcxX65ZpaVe1HtU3tnX+/JROIODXh8i+Cv5Q9OZLtjExXfR5zenNdZGmEbSEmrTSgKghnYriP6dV5i34YQH9wzA02Pw7Ttcc3qanwed9VdP+r+hAg4QiaVJudSoknI5zgzaQyVjJ61hGOLndN83F9UmRWA27KZ5/WNMbRvYE8tCg0o3r4Xm2qemd/QeuHGPfbvjrzQ09X8mHsLWhm9ueyMKS1YLNHPy+5EV4h8NZ8bKc91/iLy0yCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPlvavgBV882d0/U4m2GQPVYAC/WssP06M6VJEfxfvo=;
 b=ZAPr/OFLfYSMLF0bpdnOe+sG7ANSDX/PfQ3uvK4w1OVbofph89vHrdxtoxrxn6sRNcZEZI2Dqg9yhTZxLz6u1Ktz2qzZZyIBTOJCQ+CtjwyLdG7ipRAr10dZ+q20uF6CYllf2vyBTbFPmA5ArKQfVXq434ZnQm8naVpFEu5xjtRFEiCEhbKMGnwOPvbfampwDJPUGXmX2ZEdRaLmaY+catxnc2yAN9MhpfUd3NdI8GpGPBAM4DILdBTO12p1euPesppghR2R1uxdaydsHH+XjRMRiW026u9Zleq4Ea0XH4P4KJyu4oJ+gx2i5a0h1Z25GO/EN/ISGYcGehqeamzR5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 SA1PR11MB8573.namprd11.prod.outlook.com (2603:10b6:806:3ab::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Sat, 13 Sep
 2025 00:51:53 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%6]) with mapi id 15.20.9094.021; Sat, 13 Sep 2025
 00:51:52 +0000
Message-ID: <c0580922-608a-410c-aec6-08249087943e@intel.com>
Date: Fri, 12 Sep 2025 17:51:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] x86/microcode/intel: Support mailbox transfer
To: Borislav Petkov <bp@alien8.de>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>, <chao.gao@intel.com>,
	<abusse@amazon.de>
References: <20250813172649.15474-1-chang.seok.bae@intel.com>
 <20250823155214.17465-1-chang.seok.bae@intel.com>
 <20250823155214.17465-7-chang.seok.bae@intel.com>
 <20250912163421.GBaMRLjTUr3bcG5fvJ@fat_crate.local>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20250912163421.GBaMRLjTUr3bcG5fvJ@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0214.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::9) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|SA1PR11MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b22db7-cef3-4796-0040-08ddf25fba5d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWFPaVcvZnNsbkVKMlAwSUJFekcyNnAvdnd1TXZYanlrM1AzbUJ3K0xkY3Zq?=
 =?utf-8?B?ZTgwZFFSSEtYdUtvZzZOYWsrUjF3L0hxdWx6RUNqN2pPUERzTjNhVEVkMy9B?=
 =?utf-8?B?SytPeWNGcUh0VGFuTHVIUUk2QW9LM2VRb0RlM3lZZUI0Vld1eHBOL3VIVWpp?=
 =?utf-8?B?YVU3emRzMk55QVRaS0pUc1JOOE0wRXpYZFJQUUcwQVdqSW9jd0ducnlyNk5i?=
 =?utf-8?B?emlNcWhOUWhqNnpOR0FJb3ZIL2RwcG5kbkVHMjBxMkMvejJSUm0wZ3FWT2NG?=
 =?utf-8?B?NUVGZDhaYldsZzlxZTBDMDFmZ2lXbmNNbXBrQ295YThrOThuanFGMGVDL2tG?=
 =?utf-8?B?NjkzdEdFVFNkWjNTSnB4eWdPUmVkRXlXelVyTGY0WTJMTEtrSGhjckhrQndP?=
 =?utf-8?B?bnkvS1dEWEt4cWQxaEJiZTlCRXNFUmJTRTZsN055VmpXTVJEcityTHdHUTZQ?=
 =?utf-8?B?eVE2Q2NvMkZRa3hOQzdlVEUvMTkrSUZnQjZtM3JERE9jaEF4a0RyRk1PQlVK?=
 =?utf-8?B?V3FkWXFjRmxBS3JlUnNmN2NpNWtqZjhlM3VTL3ArWnhjMHRRTVloSFZXazdF?=
 =?utf-8?B?TXlwRkxaY3I1K2x4bXVRZksvaGh2MmZTRGczcCtuSi85b1BpbDJIdW9WWVlv?=
 =?utf-8?B?VXc4R2pWV0UwVmNLVjVzWEU5MVJtNmJ4WnFac0lmTWU4R09CalBkRW1rZVRy?=
 =?utf-8?B?bTJxK1h4eEVERisvanpBckVTb0FzalI5S1Q5b3czbk5lWU5qMEswN0gwdk44?=
 =?utf-8?B?V2FjWEg2SlF2Q2EzZWgzUTh2RjU5aFRFb012NW5sYlFtNkNVSXJ0NTlaSzVK?=
 =?utf-8?B?aEJseG8xQ3VFOVRoWm9jOVVrMEJIajg0NzhsNjJPQXJHN3F5eUMxV0hDZm9K?=
 =?utf-8?B?RXpnVUYzZS9yb1IvRjl5UnlmQU54cGs5dGRYcmNBNFhWeWtyNU5NcEhpN0Z0?=
 =?utf-8?B?czg2SXNpWWFNRVRDRjltdGtOQjlZc1BsOFhyY3IrdzFjSWpmdEd1bVVUYktM?=
 =?utf-8?B?WTJqZW1HZlhFYVlFVUoxam5hT0lvMnluRDdMbnFLaU55TEk5Y25ReXRUZ3Q4?=
 =?utf-8?B?Ty8rZWtSNkdtaTBzOGZoWlI1MXFTQ01FRi9IMW41clF3eVd4eGx6YnNONXhL?=
 =?utf-8?B?VElaMWZJN3lpQXp3YTNBRm1GZDBuTWFPZURHSmJSSGJQRDBTM2FkM1ZvdUxD?=
 =?utf-8?B?RHpzRjJkc3hweWM0Q1hhWkhJdUxtTm5qdE9WdzV3NkRXUXRqTVgweXhDekds?=
 =?utf-8?B?cHRvb3YwWVlFbHZ2R0hLbjkwN1VoRlk0WjRsVUg2U3hMblN3SXN3NGRaWVZx?=
 =?utf-8?B?S1I4OFl2YXhhSG9nTEZVTkFGMGw0YlEwalNPcG9hbTVNdmZwcGxwZ1Z3cVY3?=
 =?utf-8?B?cTBNcSsvV3o4S1d5Q2lsaWlmVk5aejcvZm44eUJobkdXQ3BYbVRmSEZGNnFZ?=
 =?utf-8?B?UGlpZUI4UU1QeWt0ajB6Rll0ZW9SRTBucTlaL2x5TDlUYUZ2azd4N0VqYUxT?=
 =?utf-8?B?dEtqVlBySHF5REFNREViVDdNZWlpSlFubmxTc2l1Y1pOWWg1aWZMMnQwVnht?=
 =?utf-8?B?a3N6MVJMSTlJaEhXKyswdGFtRHJjUzZ3TjhFb0JMQlhQcWdocDRFTXcvaXVv?=
 =?utf-8?B?bjcyaTVoa1pWUGdqOStQeUxqZHc3ZkZoM3U4Umt4YlZUOWlEZU9RclRKbXEy?=
 =?utf-8?B?SlovZ2RURDRwQVZSODV1NmxRQjhIb3JGYmVVemIrVWpxdGI3V2Zxd2piTlBM?=
 =?utf-8?B?ZmR4QkpVUlBhUTFORENkY3U4QStmYVlLaUJyWk5QRVM5WG5XUXk1Z1drUFNo?=
 =?utf-8?B?V0xnd1ZGUEp4WEV2MW1vcHdEeXhKRnFvYldLREx1bmdUV1I3dGZ0cGlXWkkz?=
 =?utf-8?B?SnVDaEFGeVViWXdYYU1ZLytCVTJaRkxEUlRnNmhzUHZpbGhnQXR6TTVxUzV1?=
 =?utf-8?Q?6vs2frC80RA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UktIWi8zU2VJdFVXVld2MUhnVGY4VHljcEM1RHhldnpsWGplczNRQUJjUW1W?=
 =?utf-8?B?b2w2SHFxeWhTWnd3T3Z3bTVHUG10VEZONmdQcnRhbXhwS1dCMFF6STlxTUZP?=
 =?utf-8?B?bXh2MWJranlRMmZnT3E5U1kzMUhVVFFycVFOWFQwTWdHRUQ1R0FZbHpZbUho?=
 =?utf-8?B?alErTGdSclc0U00rbzl6VTlmUGIvSWFTRGtCMHZvNjJ0S1VHMUFtQzAyNmdI?=
 =?utf-8?B?WXllZEhhRncwV3J0UUVYMWdkc3JhcHpWcGUzWWNYOGczMzRrK1RtaTlLRUN1?=
 =?utf-8?B?NXNGUmlwNlNuVWNEVEM4YzVFYy9Md2VwQmJrbzFSQ08zZXZZcS9GdVdqS1ov?=
 =?utf-8?B?cDNmZG5sSmlFbzcwNVlkaENUK2ZYVWxURldUUW0vN3o5WWk5QzAvRDE3Wkwz?=
 =?utf-8?B?RXRaWWhUanQyTmhYMUpVWmdueTJ4WGE1VndmbkppdEUzWVJ5dS9qVy82TnNX?=
 =?utf-8?B?WmhyWGUramh1TDh5UDYyQWFtTjNZS3ltOGRDYkk1bzZsVUMvMDgwZEdENWxQ?=
 =?utf-8?B?QmZ2RGRvNjZncVg1RWw5QmxVZHdqVmQwZkxaR0N0TWNReWFmanNGZ3dJVGRP?=
 =?utf-8?B?Z3pHOHJ6ZkxjNDNtdUpKUDg2SDUzQXZoK3MxbjAwVGtyVS8zZTBFUDliUEVQ?=
 =?utf-8?B?aXJFTEtucHdXQWhuNzZ4bFdvcW1ZMEk3ZG56VTN6WDJHYlprRVcyV290RjNF?=
 =?utf-8?B?QmxiN2I2NndtRDNZVWRnMURSaE42NWFEenFqTVJXY083aFB2ZU5Kbkc0c3ZE?=
 =?utf-8?B?KzVpQ1BmZnFTTUl0K1VuU01nRTA0TTNxdmRxV1RIamlUR1VOcWJsSE5qVUhm?=
 =?utf-8?B?eTB2dUtNVnVrL21ITGtEckhhL0hiT01ZM2tuaDE3ZzFKL3UwQ2IyNkFyamRi?=
 =?utf-8?B?VWZhZ0hLWE1IUUdmcTRUSE54UEtUTkVnTGplYkNUcFR0dUVycUZ5T0QxNW9p?=
 =?utf-8?B?SUFja1FKSXo3S0FYcHdzTTZYUFpHQldaeUc5Mktxa0VqNTRMZWpDTi85TmpO?=
 =?utf-8?B?aUhVa21jQTBWcXFGek41L1dSOUtzQTBqcGFxUmdOK09vSklRYVBDVElhbVhF?=
 =?utf-8?B?ZzZVcXdYUk1nNHprL3JneERlcGtWOHRVVW9IQ0VZWlM2ZFpEaVVRQkR0TjdQ?=
 =?utf-8?B?TEVFeU9XV1BGMlBudTE3WVdOUHNQQ2ZrZ0IzSXpQdkxmcmdnZm5zUlBtcFdO?=
 =?utf-8?B?cnFBb3BVZVlhSFM5bmE1SWlDbjdRcm5MbjN5cS81V0xNdjR2b0p0eTFNd2ho?=
 =?utf-8?B?amJNcXdxUWlCVzBYUUtVcmdEcmJ4NmZidDVVeTJtOTZ6YXFYV0JvZ3RRVUx1?=
 =?utf-8?B?b3FIWGtheWtiLy80RWFYZ01zb2VlbXR5Y2pNdTV1Z1BLb0RzVk5JMUFyMzd1?=
 =?utf-8?B?SXM1YlZmS2lmWlNGSktVaUt0NWZGSVRzd0MxdGtGRXVzditLVEk4RDQ5ZlR0?=
 =?utf-8?B?WkZsRnEzMWNOUjVOVTc5RmVUa3hxU3VxZ1VzalRLR09aVGMwd0VaWHBYUmhX?=
 =?utf-8?B?a1dkVzJuYUR0bDdvMGsxTzFBQUJ2NnFlOU1jQmxScXE1T3hONU9Ta2JFd2M2?=
 =?utf-8?B?MkxUU3daWjlaMVNIVVF6T2ZNL2tpUTdEZ0xEVksxY01QS3hqQ3pRMmhzeGJI?=
 =?utf-8?B?UlhYRGRZYklabUlidW80SnNxSFJJeUtDUTFIalM2MlEyUU5RekNheW1walBI?=
 =?utf-8?B?OFVSNHdEN1ZEZmNRbFdUckdWTzlBR2lERjRiazV6akZHYkZPdXA3SWZ3cVYr?=
 =?utf-8?B?N0pGd0lYZ2ViblF3QnlDQjYvOUVjZmIvcUxtV3NzZzRQc3ZBdXpBS2dwZUdI?=
 =?utf-8?B?aEdtZU9OeFJNMEZVTU9NZXViWHhvN2FoZDY0UFJrczFxd0JPUlZDVHMvRlRl?=
 =?utf-8?B?ZUs2bzU0US9sMUFtZkwxcXl6elVBRFY5UWhJVGpKWVdWWVNHU0RKMXFVOEh0?=
 =?utf-8?B?UGZqTzJiVVJ3MjNyNmJKL1VmUXF0ZlUzZjdrUkJyU1AwU0dIVFp2ZjVUdld0?=
 =?utf-8?B?L1hwalpHRHYrdDQxRnp5RlFhdktpQVlJVjI5clUrNTN4K0FkK050NkVaemh4?=
 =?utf-8?B?VlBjMGhQaHhPbXVCR1psY1F4RE5qdmpWdDRLUWQvbXJNdnZSZDRINlBsWVFl?=
 =?utf-8?B?RlNvL0NpWVNEbHlLOTZsUit4WkZBdzZXU2hjZVM5VUNWTzJ0dzZoKythSmFU?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b22db7-cef3-4796-0040-08ddf25fba5d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2025 00:51:52.2965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DrCC/U4bPd+co2R5/g7noMzGuBs1z2vUpJUOWnjCle5Lxy1qyktKCqmix+IO+3zfdadsZPP4TzVyFSLg1+O+7OVeqLsqPHPu1sdTMc1VWlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8573
X-OriginatorOrg: intel.com

On 9/12/2025 9:34 AM, Borislav Petkov wrote:
> On Sat, Aug 23, 2025 at 08:52:09AM -0700, Chang S. Bae wrote:
> 
> I don't understand what the point of this explanation is if all you end up
> doing is writing to "io_addr". Why introduce the unnecessary confusion?

Yikes, it looks like describing the format and interface went into too 
much detail when that's already covered in the spec.

>> Note: The kernel has support for similar mailboxes. But none of them are
>> compatible with this one. Trying to share code resulted in a bloated
>> mess, so this code is standalone.
> 
> Now that belongs in a commit message. Stuff which is non-obvious etc.

Okay, maybe the changelog could be something like this concisely:

The functions for sending microcode data and retrieving the next offset
were previously placeholders, as they need to handle a specific mailbox
format.

While the kernel supports similar mailboxes, none of them are compatible
with this one. Attempts to share code led to unnecessary complexity, so
add a dedicated implementation instead.


>> +	/*
>> +	 * The MMIO space is mapped as Uncached (UC). Each write arrives
>> +	 * at the device as an individual transaction in program order.
>> +	 * The device can then resemble the sequence accordingly.
> 
> reassemble?

Yep, fixed.

>> +	/*
>> +	 * Hardware is neither responded to the action nor signaled any
> 
> s/is/has/

Also fixed -- and I'll do a more careful pass to catch typos like that.

> You might want to dump some of the actual values in those pr_* statements so
> that it dumps more breadcrumbs and those prints are more useful when debugging
> issues.

Yeah, good suggestion -- maybe it could dump invalid header and offset 
values like these:

   pr_err_once("staging: invalid response header (0x%llx)\n", header);

   pr_err_once("staging: invalid offset (%u) after the image end (%u)",
               offset, ss->ucode_len);


