Return-Path: <linux-kernel+bounces-760783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5117B1F016
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 23:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03C21894653
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 21:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2CF248F7E;
	Fri,  8 Aug 2025 21:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ImYvUBsm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2641E5B60;
	Fri,  8 Aug 2025 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754686815; cv=fail; b=E4pcUQOkLm5ScrG4snsjEWdpdO6qdyWXpgx//FBMiuxX0XdxEooGhcykvoyYyAH0x0YDIZWmbZLHh5h/cjD4/Po6L3SLKcLSoIxd+Rvr+IkK/b9xIla3QbB9ygfot34lmw27m10+fZLkKA5O8z8HeFrWFlLUIrKmBMBJe504+ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754686815; c=relaxed/simple;
	bh=SOGvp7OR/FrTq5lc11koSCbUmpO08byRO6cqrny0IiM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oqFPEQerXMYd0iS36KczyQYcp5VCQB304mmws/e7uejRXtouf/+lAWD04f3b9CnAvMGYtsWNKZlFbVuT293+3KBmMIalalu0TVqy4+ccl0OMuyuAPYc+9YLUH8WgZpxdtlzlEJqTU0Ir9Z6Jq4ryHrU5r3dDdBKnj9hcGFzZMyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ImYvUBsm; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754686814; x=1786222814;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SOGvp7OR/FrTq5lc11koSCbUmpO08byRO6cqrny0IiM=;
  b=ImYvUBsmaq08uE9s+DFro169629QlmRKImZI2ythaOeJI3LsQvxoAAGq
   W6ccaYDRzA+mSkMqsXhk2SJVhcn7RKKqjqtxq1951eVdxU586SNniOi0Z
   pLRpb+8KXm5wPM5Nbeqjs8gTji6tH7PdRxzla1c0oJnWgmYgAjcBBkLcE
   U+p/wmq1Hs5PyaO3Qcr8LyWaE9vKQGKPhZE5DrLny1eATpmIR8bnYGW5a
   UG8GP/wlrMzWSVwPfUeJpItUMcxasKroG0Fz8cXz3YBMF0s+VtmnQNY8B
   56Psi95qd2JREegQ7SJ71xpBLKjzQzbcfzos24HoJFGZ0zx4/dSyU1t27
   w==;
X-CSE-ConnectionGUID: oMlPtvHYT56AY8/bi6m6yg==
X-CSE-MsgGUID: EwGjfwWLQmO1gDWbt4fegQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="68496930"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="68496930"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 14:00:14 -0700
X-CSE-ConnectionGUID: Yol2tX/GQ0i93tVS3WZCFg==
X-CSE-MsgGUID: nYyytaY2RpShs+xSMfUtUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="170666758"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 14:00:13 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 14:00:12 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 8 Aug 2025 14:00:12 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.73) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 14:00:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=da2/II8xB4/QysIklbLlr4lNRLi/bX3vUSQH2BF5/pzKmmQPT1eGGjZnf+7dpaGBd5aeiU2QJOmmTK9K8eP60Dku+elKL9Lf3JAmAv2gx3Rkoi6zyKTvbX4EPeYMi+v9KQY+MTHUlmpA2vPQIdutPKRt0XcFDGqHcGGSJX+V3XIYjPNKgY1WQTA99pu/VonzaDNvZkIvbfX17e9iHiqNHqol/CWmfd5RuHnNviMUImuH4J2AD2xZ3BjS44PSDB4KHC0B5wptLv5TAdJyKEdSld0q1prXFVT5dYjsuHt+PAQotnm5EkIi7/QmxSK8xi/y0P32PGaQckbdElepiNbM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yusvDXqDhQkMECXCVju5jMDkrcjyA2kSL8V4SWIMhiU=;
 b=hAP0WvdTcwBIXA2ORu67rXzZM5oEsqaKG6BxsK1k/tzLFHi+NzzMji+hSnLh8DE5wLpAx55YfkiyG7qByu+OF+eUKb6F29B61FT+/lqc7Dzbbj5wPTNxmL+kwshgqbbO3BwqRAmHRTbcJSQzzvQoilJGTGOR3NJXYMZ76cCJ7IQSZz7kchhfjVg/VkO3bWNd/x6HisK0N2cO73sjB0Gya7HBNkWzEiOAQ01/bHELH6GZkySLuhAs4rYS0P3YBk2+1e8xcakJD/iMBdJNCv8p3ipcYRBM/e+pgPXQYYWIQqCAp38O41Dr9OjZR5QtJ71+2mr77cmeKxpZYgP3j3mf5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7407.namprd11.prod.outlook.com (2603:10b6:8:135::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Fri, 8 Aug
 2025 21:00:08 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 21:00:08 +0000
Message-ID: <c363313b-78b4-4dce-9590-5cd0c418741a@intel.com>
Date: Fri, 8 Aug 2025 14:00:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 27/34] fs/resctrl: Introduce mbm_assign_on_mkdir to
 enable assignments on mkdir
To: "Moger, Babu" <babu.moger@amd.com>, <corbet@lwn.net>,
	<tony.luck@intel.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<Neeraj.Upadhyay@amd.com>, <david@redhat.com>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<manali.shukla@amd.com>, <tao1.su@linux.intel.com>, <sohil.mehta@intel.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<xin3.li@intel.com>, <kan.liang@linux.intel.com>,
	<mario.limonciello@amd.com>, <thomas.lendacky@amd.com>, <perry.yuan@amd.com>,
	<gautham.shenoy@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>
References: <cover.1753467772.git.babu.moger@amd.com>
 <dd92bf598bf7c922b212100ea668f3241f6417c0.1753467772.git.babu.moger@amd.com>
 <f653a942-b2e7-45d2-b5fb-458b022a25bd@intel.com>
 <e4137f68-6b7c-4c4e-80a6-53fd029478e3@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <e4137f68-6b7c-4c4e-80a6-53fd029478e3@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:303:b7::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7407:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ccbc914-11e6-48e2-6033-08ddd6be8eda
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUxGRmptTXkxWlQweEJ1ZUF4dmpGdmVMWmI2NzFqUzhQOVVRODFjRTRDZGtm?=
 =?utf-8?B?KzN3QisrTmhoNkFvd1pDQ1JOWEF6NWlRR29GMit6TlBtVVVTRDNZd0ZqVW9M?=
 =?utf-8?B?UDJaaUhTZlNlYUc2TzlSdjUyUXlIbUYwVWtuc0M0MHpkdDVEOERwM2E5ZTRo?=
 =?utf-8?B?UHUzNkE3eFFwV3diS0RZeDVNN0FBL1lvMitYd0lRd1U4Z00wenFPTXYvN1JF?=
 =?utf-8?B?cHBaV0NaUWppS0RwYkZOMVpoRHgvdFMwL011NllrYitKOEdNNEltZnZTTTV1?=
 =?utf-8?B?RnZQSno0N0phaG11VTU4WG10ZllUSW1nTVNZMi93dElKU0dRSkJkWFF6b2dm?=
 =?utf-8?B?dWFqNXJJWnU3UXBsTnFCdWhyc1RHb050bGlzZWZaQXZiZitSalJrOFJ4aVFo?=
 =?utf-8?B?K0ZDMUR3eXpVRm5uZFQwaVFrcW1hd1BnTmhNSmxwZWVQYVBvRTFsTDIxN3A4?=
 =?utf-8?B?dHZBbzkxVS83NS90aXU5bi9mbW53clpxclVyeEZiSW9ZdmplM0FVL0lHd1hX?=
 =?utf-8?B?UWJSUEw1Q2JLM0NnQWQ3ak40VGpFS1YwamxuTWFoblByVEEvS3dDWkY5L2Ev?=
 =?utf-8?B?ckZwMEUvMkw3d3FzcVRkdUlhZ1Z5ZDZoZWFyR0VWUEVaUlNHbnlsMTZ6VGtE?=
 =?utf-8?B?Mm91endDb3l5S01MQndqQkpjOVlRQlB5Y1hpL01waVRjL0hyaTkrSEJabVdB?=
 =?utf-8?B?YlFKM0VHVWYrSi9PeDI4ZWl2WjQ0ekVRVDVoV3MzMWlSQ1UwSCs2Nlk0YU9V?=
 =?utf-8?B?Z05YcFBsR1hIZ0hRRFphVlI4aFF5cXNrOU4xUm83NGZJRDJxNUZLZDc5dG5O?=
 =?utf-8?B?amdkQm9xRnF1KzdyaUxCdkZWYUR4UitMczMyNUwwRnFjQkU3djI5N0RUTVVa?=
 =?utf-8?B?enZkaDBKb0Jka09NY2plcFp2TXIrSnpPdFg5ZmVFVDdRUmJ5aWpKZnhkcHFo?=
 =?utf-8?B?UTRnZTQ5S2VmV0FFVEt3REJ5ejBvRGFJL2hTaE83WmtFSXFFUXRKalhEZkJi?=
 =?utf-8?B?RCtyajBvdzNqNlRtZEFiOG9rM1paTzFMbit1bkFncjI0Y0g0M1p3QmpnMVZF?=
 =?utf-8?B?Rll4aytjK0RqcDF0dTlCdTBMQjh2VE92QTIwVWFZdWJDS2NwMi85eVdWY1cz?=
 =?utf-8?B?MVhOZjBJYzhYS3d0bllhdXR4Zk5zQnUxMDB4YjJWRlRGZkRqamUzeGJSQXQ3?=
 =?utf-8?B?cE9TTTBWanVBRzNYYTIraGovT1VHZ2NTUUt1SklITnpTUWFsS0xiOFVaQVdE?=
 =?utf-8?B?S1QvZ2c3YThqVENlU0lMS1Nha2tQZm9TeU5wVGRQZm1OdzlRRll5WldHWjh0?=
 =?utf-8?B?WDNTVmJGbUpvL2JrSmliZHN0NEh0eEZFRUxtcE8yRnNnWWg5cCtBMEU5Yzdu?=
 =?utf-8?B?SWVxenQzK1dlMEZ3T1hWdkx6dzNsdE1BWjZkUnNYenRaL3Qra3pFNTN2Mmhx?=
 =?utf-8?B?U056Q2lwTEJ2TTF5TUYyUTNoTGljR0RGQW1JdEFURUFaMkZKeVhSWWVJSzlV?=
 =?utf-8?B?VHF4RGxTTVlnM2E1OWxXaVljYU92bzMxeXczQ3pEMXMrSVQ2eC9DK3dPdlgy?=
 =?utf-8?B?ZXRaQTUxeGpPazdqQndSYzJsWmNpLzdCU2FSNWtoQkV5dzZpYUlad2FNMDQz?=
 =?utf-8?B?MkcwMTZ3bXNWMGhiVUw3K2lhai9Xa3EvdDNrVmd4M2RlVHVEQnIzbFZjY2Nx?=
 =?utf-8?B?Yldua3lyNHNYZDFkYW9ydWE2NXc1VmNSa05nVWZKNU1zb2lGYjdGRjJCdXdl?=
 =?utf-8?B?Mnh2eTlpeDhVMDlOT0ZvSDhTQXdmaGRyZGJZYldWUG53bzlxa3Q1UkRkWUxF?=
 =?utf-8?B?TlNpZnZqMmdzWnVmZjBEeHpQbXk1QzNPY0RqZlpYdkhaN3Y0d0JLUTVFRmdC?=
 =?utf-8?B?dHp3R2w2b3dteGo5TnJsQjR1Z3pKSCtCNzRjSmJra3d5SS8yRGRXcTJqckdZ?=
 =?utf-8?Q?1aCK8HHjRvM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z20rZ0hRVzhyaEo4Z2k5M2JLV1BGa3pucW0vSVljenI2S0dGaGVnSFRCdWNC?=
 =?utf-8?B?NG9rdWZrbml2NmJRejBLa0Q2Q0tLRUlLT1MwNkFJR3UyeHIxZkNUeUN1bkVK?=
 =?utf-8?B?Q3FVcFlTQTlRM1RhSlZSNWNPSEJjMmEwbmZEQ1k3VlNjL0ZIbHRyYkJMdDdO?=
 =?utf-8?B?Q2Uwd1dFbmw0amxrUVJHK25QL1p3TEFaeFVqdkJyVlRwbEJHNkRydFBIak0x?=
 =?utf-8?B?RzRzUmhuVmZER2tkRFNBaTFoTWpsYkNvUUJnZVZwWE5INEVwa2tlTUlQQTMy?=
 =?utf-8?B?R0c4SjRyQnpRU000WHRpSWVwZXJTR2h3YnhvQVVFNC9JSlloRzlTRFQ1T3Y1?=
 =?utf-8?B?MXFSSWFCRkF1MkEwRExQdFAwWVBXVnR3eVFDN20wZUVlKzVsaUJRaFhGbmYy?=
 =?utf-8?B?MHhLZFVLSUFSSWR4RHNmMWN6dEhwa2lPdks3dlRmcCthQUdYL1MxOGVpSDhp?=
 =?utf-8?B?R2ErMnh5L3pCVnRWc3o4VndmQlZheHR5SXl3SGJCYXQzMGxYT0VhaTBYZ0sr?=
 =?utf-8?B?cFlYeGYzbUhocHdsQ0pMU3BWTS9nM0dFM2VFeXp5NHl2OTBBMzRqQkcrYTdM?=
 =?utf-8?B?cFN3SW0rWjEvSFp6QlN6bGhZYnVBUmdLdS90OUJ5SFREZHk4Ny9OSWV4Nkhh?=
 =?utf-8?B?R2VMdkhlbThqTnpSWkxMTENoV09BTjBkendzY2NLVyt6Q0gxeHZxM2RJdm1C?=
 =?utf-8?B?VklMZjBKTEJpTC9GWDcwTjlKZVM1d2lkdTVnY2pic09jRGlkTzB5OVRIYTVF?=
 =?utf-8?B?NEVXQTdmcnVwU3dobzhxcXVKOUU0cGRIQUZYQUxiY0JhNzFBVGZyc01qQWRa?=
 =?utf-8?B?ZEdlZThneDNSOW5xOEJqSHhVK2NycExlemllNG5lWHNrLzVhVGkwb0QvdFZ2?=
 =?utf-8?B?ZUtRZXE0MHhoK2paNFF2WlhNaU1OS05DS0d3WTFxL3NXWUVmRVh5d1JZLzlr?=
 =?utf-8?B?TGdDQ2haNU9mT0ZtSXVhYWhYRHpqaURvOWdlcHFPR1MzK2xmMUo1Ui90UTNH?=
 =?utf-8?B?SzlKek1zd1FzMlNpRklVdDNmUGtpZzB3NFdDU3AxaXh5eVErR1ZONnJ0VERw?=
 =?utf-8?B?L1VOSzFCWGVCbjE0cDN6UFRiQVBLM3BHSWV5aGhoWkZlTFZ6MjhiWG92Q1l3?=
 =?utf-8?B?MVp5YXZadkFNcHQ1eU5XSVRKSkRHVitYaDlCT0FkSDR4dFRsL3VtcmxtRHdO?=
 =?utf-8?B?RkdveGZSVDhLWkhpcVlQWHA5TGtNSk1jd09BSXVHL3Nxa0N1OGZ6Z3ZNelFX?=
 =?utf-8?B?SnBTNjREK2hOZm92Yk9TMW5qeWt3TUJhUUx6bUtxN0dseDlXREZBQTdtMnBw?=
 =?utf-8?B?ZGVuWkNBcDloNkRibkIrZjZxRkF0TDNyR2RhdDV2MW1zOUhKZWlJUTRwNVdT?=
 =?utf-8?B?WlByeVVaVzFkZkJCdCszMUxQVGJseXNrUnRNQmpSWDhtZWFybEx1UVVXWnVv?=
 =?utf-8?B?WUlwV0RwcmZTNkNlRTR6anoySG90MWpLWGN6dWlONGpONWJaRWYyMWU2eXk5?=
 =?utf-8?B?REk0V1puR1NycHVOSmNERFN2M1NWQ3dmUDVEY0ZzbzB0YVNFaXlLYnh5TWdS?=
 =?utf-8?B?eEVqTmtQZDR6Z1M4UWdGUC9jVTl4aGdlQzhOSlZTbXQ5Zy9FTnFLcGJkL0pu?=
 =?utf-8?B?Qm1oSVVCTnJPWS9IYk9HaDNBaW5td1Q2K0FpQjhPWnpYTm9VZ0hOckpVSGRQ?=
 =?utf-8?B?VTRZRVFReWI2WkkyVS9BSVdybTdVeFA2cU1ZWmhDeHNVcVN5QTNrRUFBNzBz?=
 =?utf-8?B?QVJVTFdaWDJ0ak1CZCtDTnFFczFjdGt3Yjk2ZG5zSmRSTDZqcjhsc2pjdHln?=
 =?utf-8?B?bXVXYW1NRktEOGJxSXVlbDNBRElJa1dRbTd3TlkrVHhEQzYzYTJkZVkxRk5I?=
 =?utf-8?B?Y0FaNXl1c3NBWXRGV0MyRk44N3p6akVxMHE1SkRyZWVXYXBPZndxQzQzOVY0?=
 =?utf-8?B?R0NTWmdXc0x0MWJaSWxMSjVwZlR1cFFzdFUveitjQTh4QVdHUVZ3bWorOG03?=
 =?utf-8?B?OVpBZUVna1hGQzFpMmxIWDEzRzUwbmRQNk9UTTlnbUZMZTVlWS9vNFoxMGRK?=
 =?utf-8?B?ZUJFVFNqVjk5MFU4Q2ZrRXREaTYxYzlSQUh4RlRvZGR3Y1cwVFNlMUJNU3Qx?=
 =?utf-8?B?UnhvRVA5K2YyQWlmRHo4WU5MSnR2SHU5cmI1dmUzV1hvOXdWbTA5MER2OEpR?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ccbc914-11e6-48e2-6033-08ddd6be8eda
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 21:00:08.6619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LPhYU4MlLrEEA5YytQzzaYsjkwHGQcfJiNA1LVxk9ivWccKvGFInqvKEhh4iWseuZQFHtxcBq8RvhFsYu92j6figDSp4lG/opn9j7FePrrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7407
X-OriginatorOrg: intel.com

Hi Babu,

On 8/8/25 1:29 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 7/30/2025 3:08 PM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 7/25/25 11:29 AM, Babu Moger wrote:
>>> The "mbm_event" counter assignment mode allows users to assign a hardware
>>> counter to an RMID, event pair and monitor the bandwidth as long as it is
>>> assigned.
>> Above implies this addition is in support of "mbm_event" mode while the
>> implementation applies to any and all assignable counter modes, including
>> the "default" and for example the upcoming "soft-ABMC". It is clear to me
>> how this is used and interpreted when "mbm_event" mode is enabled, but not
>> for the others (more below).
>>
>>> Introduce a user-configurable option that determines if a counter will
>>> automatically be assigned to an RMID, event pair when its associated
>>> monitor group is created via mkdir.
>>>
>>> Suggested-by: Peter Newman <peternewman@google.com>
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> ---
>> ...
>>
>>> ---
>>>   Documentation/filesystems/resctrl.rst | 16 ++++++++++
>>>   fs/resctrl/monitor.c                  |  2 ++
>>>   fs/resctrl/rdtgroup.c                 | 43 +++++++++++++++++++++++++++
>>>   include/linux/resctrl.h               |  3 ++
>>>   4 files changed, 64 insertions(+)
>>>
>>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>>> index 37dbad4d50f7..165e0d315af7 100644
>>> --- a/Documentation/filesystems/resctrl.rst
>>> +++ b/Documentation/filesystems/resctrl.rst
>>> @@ -354,6 +354,22 @@ with the following files:
>>>         # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
>>>          local_reads,local_non_temporal_writes
>>>   +"mbm_assign_on_mkdir":
>> Needs a "Exists when "mbm_event" counter assignment mode is supported."?
>> Also needs clarification on on behavior when "mbm_event" is enabled vs. disabled.
> I think we should allow it to modify  only when "mbm_event" is enabled.
>>
>>> +    Determines if a counter will automatically be assigned to an RMID, event pair
>> "will automatically be" -> "is automatically"
>> "RMID, event" -> "RMID, MBM event"
> Sure.
>>> +    when its associated monitor group is created via mkdir. It is enabled by default
>>> +    on boot and users can disable by writing to the interface.
>> "users can disable" -> "users can disable this capability" or "can be disabled"?
> Sure.
>>
>> This implementation enables user to read/write this file/property when "mbm_event" mode is
>> disabled. Considering this explanation I do not think it is clear how this file reflects
>> system behavior when in "default" mode. There is no difference between mbm_assign_on_mkdir
>> enabled/disabled when in "default" mode, no?
> Yes. So, we should only allow modifications only when mbm_event mode is enabled.
>> Should interactions with "mbm_assign_on_mkdir" be restricted to when
>> "mbm_event" mode is enabled? If so, the next question would likely be whether value
> Yes.
>> should change during "mbm_event" enable->disable or "disable->enable". Above states
>> clearly that it is enabled on boot and it may be reasonable to have it keep (but not always
>> expose) user's setting when switching between modes.
>>
>> Restricting it to "mbm_event" mode now gives us some flexibility when soft-ABMC follows
>> on if/how it can/should support this. What do you think?
> 
> Yes. We should restrict it to modify only when mbm_event mode is enabled.

I agree. I also think it should not be displayed with mbm_event mode is disabled. This is
because it indicates to user space that counters are automatically assigned to RMID, event
pairs and since "default" mode depends on hardware doing this it may not be accurate when, for
example, ABMC is disabled. Alternative is to add a third value, for example "enabled", "disabled", and
"undefined"(?). This sounds a bit awkward though so I think simplest may be to have this file
also be consistent with the others and return error when mbm_event mode is disabled.

> 
> And always enable it when switching from
> 
> "mbm_event" disable -> enable:  r->mon.mbm_assign_on_mkdir = true;
> 
> "mbm_event" enable -> enable: "no need to modify as the value does not affect the behavior."
> 

ok, please note this may need an update to the doc that currently only states "enabled by
default on boot" to indicate it is also automatically enabled when enabling mbm_event mode.

Reinette

