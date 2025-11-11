Return-Path: <linux-kernel+bounces-894520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2365C4B3A2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81266188F210
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD2034846C;
	Tue, 11 Nov 2025 02:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mu6Lbgp/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160C7348460
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762828644; cv=fail; b=QQWRYWWVwcvRmVTBu2hkZbBymcjfdI7gspEbNqbOhCrPSbOmezl66C7/uvERgxiyOxxev01yjFK4eCF0741RXLlfClqBd4o0Wbvwej+QocTmSsOyXYt5Znb0eA1pBmOLYDobh4fBh/oinCFz9QK7Dnbxu2r3oODquuWLu+98KhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762828644; c=relaxed/simple;
	bh=D89fEDRa+/yrWkChgFXQWGSGdA9UJLtyA4Nanp6KS/k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RRBjZlpUVcV2ku4tw6skgJr/uuZEz2kL4JpnBOCexbBgfOpoSsKDxdK678FSoKvqSt+QmGcNw6TlD/OAjXr0uIeHY28/7e081JnG63sYp5hLeiT9dph9ep73w3/irCSlm8tH4oqfysSA+GzpgTa61MoTleuXN79lzh5iSSa6GpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mu6Lbgp/; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762828643; x=1794364643;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D89fEDRa+/yrWkChgFXQWGSGdA9UJLtyA4Nanp6KS/k=;
  b=Mu6Lbgp/TXiagnR9evWKozDWdGhWiySLEHigETGlJ3MIqhT+Mp6LXDDo
   heXFiAPJ30Rrqgi+RWdNrWToa1WSX8SIeXNRuvZA1V5HaUABUavfO54JR
   O4LhkZ9xygpqheKNu2TUxiSEIPGhRrJUr2U/r4w0utnl4BMuvpI4T0fw2
   l3xi1rOlw/Udti3b54cogyhXgguzXruyZHhbCi239tpTTQ4VeihuVPZgD
   j6uSVCs0trqTfX7JBxGe6KOeYl5NYMAGujnGAwaJlLc+YF8bB0W1Y+G+d
   Tr9bjC5bZBW5iG7fQA5iY/BYu+oQh7ePdjcRTFpNWsA5dbtABfxHS471Y
   w==;
X-CSE-ConnectionGUID: 1Cxscp68Tcygi3VI6Z5PbA==
X-CSE-MsgGUID: Qw8uudoPT5mYi9EIJyRSYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="52444546"
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="52444546"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 18:37:22 -0800
X-CSE-ConnectionGUID: 6u88VhWSQIe2mKBwFbph9w==
X-CSE-MsgGUID: +xcmxMGmQEiDPuqvceCslw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="189282750"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 18:37:22 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 18:37:22 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 18:37:22 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.43) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 18:37:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g72pX6W7a1jK9DrPwa8bxFPfUOhWGCzH7LfmvKA8Lhw1CqO9LFDSgcl6wvGAiXttQP/qo62yP2hth3NXiMQRbAMso3GF+LSzCN+R+MjQfWeqAwyN8cyEWCOjtVTssvxPnUFZXBypS+4tt1GkT71nRWgY9zanyb7EySLmye9CUQZpf79fvrxo9NouQqJXDOHv2+Z8pTBAlZDms2cyTM+fHfyNf1Yt9prieR1d2nf4ovatHWZrkPcQgH6aSDwQO3a1UNDWpG+EOBnY0Fwrs6Dp1jUtRUdqVw209LtkQrFTbtY3BoNvQExYi+j3onwnH3+XA0OK0xMX9KDt6o14qTA45Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlPP6Vpyvr9nheg4bn5Q6TRowwrltZkIMi/g/p6FP1E=;
 b=KNhRcipOS8dbq22SgbwiTLdsQmkvFALeXXpb68N8wPcw+uCq+92tQUANJu9byRZXOQufgFJ0gBfV3eIAndrZ61PtReXsH7ZlPN0CfIX16JOCm9Mee08ylMrAdqcDJXMAeGxLRF5z5uTOPCecWs7RkV9ttgtPYTGUSESabuYNB8s/dbceE7Mfqp9U3pyQPuJqGialCHlRijXX5pP/eplwoyQu9npZ7SsoK91q7CAPO02fVvJyM+3imb+EIwMjYIbLTckl2M0Yhard0d5qD0ik3R8Hf5ulvuICrhn9uP0Hug0aFvvpoE7n0p8hmME7vKs+gPA4sr0JAcyQtz0TUORSXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB7742.namprd11.prod.outlook.com (2603:10b6:208:403::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 02:37:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 02:37:19 +0000
Message-ID: <8391b079-4053-4f8c-b756-e1470a18fda8@intel.com>
Date: Mon, 10 Nov 2025 18:37:17 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/resctrl: Add io_alloc_min_cbm_all interface for
 CBM reset
To: "Luck, Tony" <tony.luck@intel.com>, Aaron Tomlin <atomlin@atomlin.com>,
	Babu Moger <bmoger@amd.com>
CC: "Dave.Martin@arm.com" <Dave.Martin@arm.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "babu.moger@amd.com" <babu.moger@amd.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20251107012401.224515-1-atomlin@atomlin.com>
 <20251107012401.224515-2-atomlin@atomlin.com>
 <2a0b270a-e398-4d88-aa10-421f2769a759@amd.com>
 <53iuqiul6uo7zj6sfckm2h465cjusaxvpxrtdmnbmhvbzuqiq6@7ogm3zqddzjd>
 <fa2c3cbc-2af6-4d98-bd70-8ab49cb0d83e@amd.com>
 <4whfbgq336xfuov4i4nwwrn35ywwlwizuvpdlstmdqzkhvwrq6@eits26xbwyz6>
 <bcc8e6d2-8e91-4e91-9dab-f1c00f99c408@amd.com>
 <knqdzael7yihvznsdzijztawviex2n3i5pqbzslmk3rolnacrh@h3cwjthvyeuz>
 <SJ1PR11MB6083F15A9FCB09AEC3A46827FCCFA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <937022c8-82cb-4f4c-a2a3-ceaf99580cc6@intel.com>
 <SJ1PR11MB60833A27A1B8057CDDFB1B2BFCCFA@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <SJ1PR11MB60833A27A1B8057CDDFB1B2BFCCFA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0237.namprd03.prod.outlook.com
 (2603:10b6:303:b9::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 63e1d56f-497c-497e-96d7-08de20cb3bf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?LzlQcWdrc3ZwZWlFQkxIOHU2dms1ZGsyVHBZd0hPOHhieFd6bXJQUkNLZGlX?=
 =?utf-8?B?MnFOWFBPbkJWdlc0UHFZYzRiZFgvc0VtR0hBTTNnUGRud0J0TlJrYlo4cnBu?=
 =?utf-8?B?MzhwUW9UUURZSEVsUHFNWTZYcjRzSDZtT29sMEFscFl6eTJNSmd4U0dmdHVr?=
 =?utf-8?B?TG4rR2RLTERQVFd1S05RM2xENjAvYnY5SzcyclNHSlNoQnk4TlprTG1xclBW?=
 =?utf-8?B?SkQ5dCtLUlA0UlkvOTh2bXZacXFvNEtiNDdGR2t6Q1hXQ0RGbkFKRStuc3BB?=
 =?utf-8?B?cU9SZE84OFNvU1JGdVViRUE0UzMrKzYrZGVzT3gxa0FaeTVVeUFORlZaUGM1?=
 =?utf-8?B?RGwyc3JFc0tMNXladmMzeG1QeUY0OTdjRHhsYzVDd0xVSkVGcndBMTNRMG9L?=
 =?utf-8?B?SEI2dUJlcG94eVlPd2Myb2YzYnRlWHlqUGlIemQzM3JOQ1IzYnNST1l1L3Zx?=
 =?utf-8?B?cGRsUmxJN1kyTUtYU3hiak91c2lXNTkvVnFFYnA1d3hQRzBQWWlISktrQmd2?=
 =?utf-8?B?VURiV2hITFg0ZzRUZnBxU1ZQUmhNSG9jNU5qamdpSDhUN0RCNEJrMU51L0FR?=
 =?utf-8?B?UmUzL2loMXlXMFVFZlV4TWRjNkIrbGl3eG1jM0U5SG44MGpqejdwQTlDUis4?=
 =?utf-8?B?UmkvejZxMXRnTXpjNEhOZHA1ZTBHclJzQ1JDTHVQK0t6NFdybG9IR04ya2Rk?=
 =?utf-8?B?eHNCdUZBTEZ1bGVwRWVkeWJtc1R5Q0FGUmZSTGdPaFlFMUxGQXpnYW84ZXNQ?=
 =?utf-8?B?M1lNWjBnZ0FLQWlxTi9PTzFETU04SEQvSy80bkNEQ2xaaHV1MERPbUxrVXY3?=
 =?utf-8?B?dExlSHZHMVRaYnVReDdnN2pTSXFrQ3IvN3ZrYk8vYlVQSkNqM1ZXazg0RURN?=
 =?utf-8?B?MXNKMXBXZFZFUDVPVGFzNG1wZ2w3YUJYc3JqOVJuVGJsWWhXRWZHcnJxb2pk?=
 =?utf-8?B?aGdYZ2hlcjlCMXVxdk9qTXBzSU9rRWdxakwyV0RHUk9EeWwvNElqbEV3d29S?=
 =?utf-8?B?dU82MFI0RzJsOG9nYWFPMFRDalc1eWtRTEhSakFwMXZNUWgzMjY3Mit6RHUv?=
 =?utf-8?B?RGlOZTlJRWlmZ3M3Q2t5MnZSeDE5cGdtVXcrU1cwbC9VNEk3eXU2Ukh0ZS9R?=
 =?utf-8?B?dkZTRmxPNFFneERnZUdadmhicHRESVNwaDFTODdJVG9aNHUvejlWb2J4czVr?=
 =?utf-8?B?UXJUMUxObFlQd2sxbHJpNUFKU2FQSjF6Z2FCVTJkNFlnU2FMbVBOc2F5TGx2?=
 =?utf-8?B?QW5FMjhQblJDNmFlbnhoVkNlWmRoVmQ2bkd0NHk1Q1dPeXlnbUxRNHdGYlYv?=
 =?utf-8?B?R0hmRGsrNWN3SndOUTY1bWdXUFAzQ0VxT0w1Y2V6VzRjK2NWdTBMWTRzRWVO?=
 =?utf-8?B?N3RkY042c0RPN2lkOWc1R29mci9XcE5ET1lrMHJHcFE4SFhWMmJIVmpoT1ow?=
 =?utf-8?B?SnplRVJqM3RYeWJLNDhpeE9seDNYRWtndys2L3FCNzM4dEtsOElsTXo2cFA4?=
 =?utf-8?B?YWVQY1BOc1NJUVRmaGYxRE5MM2d3OWNwaHJvUU0xcnJqM1A3d2NsNkR1QnlQ?=
 =?utf-8?B?SFNEdkYxbFFsL0NVQi9vaTd2UWptcWkvMVlRMjM0MFJDaG03OWwzUG5GRHBt?=
 =?utf-8?B?eUY2RUR4U2EyaUZMYkNPZmN3SEx3dGdXK3hsRkVjQmpvbUhrRkVJTUJsL3Ur?=
 =?utf-8?B?WmFSVmpmbzNQNlZHTlRMckNhTTlsSFV0cFUzMWphS3dzeHVLVHRwYlppbS9s?=
 =?utf-8?B?czNIZjF6SDVHSEVjeXNWRkxJQUlnanZpeU1INUVueDZqK1JrMnMrbmVDUXA4?=
 =?utf-8?B?ZDdYaFB5Y0xxWlZiMzJBNE9nV3E4d3hZUjYwYTRhSGJIVkVhTlVrOTFVUlMw?=
 =?utf-8?B?TG5KVmovL2xjRjJoRmoyeW9hOTZwTDNmVmd4cWVwNWJqSnZxam5mSkVIZkZV?=
 =?utf-8?Q?hb3v3jdSXcKgtOVVHYQxiisy7ddYimvb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0Vnekt4Y2FaUEVuNG1XR1hQeGZoRlMxaHphSTQveDNuOWROMWhWK0tITEsw?=
 =?utf-8?B?M1pRL1Z3SzhPSDVOR3pFSVVQWXFOallVVTNWUFVuencydEUwKzJlTXpFNzZD?=
 =?utf-8?B?NHlQbi9CVjRHdlJsSC9GNmVjVmZRSU1QWm9QMG0xM0p1MGdtQktwVkwzL0xJ?=
 =?utf-8?B?OFErT0xGc1NGb1NTdW1zL2pPVG0vMDdFNjZiQW5YamtSTU5sbk9UOXBLd3ds?=
 =?utf-8?B?L0NOc21HU0JvY3QxR3NSRlZreEV4bS9ZQWlCTWQrb0NDNjVZdytEWm54bDdo?=
 =?utf-8?B?UnVHSFZwS0ZtQlpIc0cvQzJYcUF4UU1KRk13QWxXZnFvajFGc3NubUozQ3Rp?=
 =?utf-8?B?U1F1Z0FJS3dRUFZFU2hlSVdSa3hHRjZBODIyQnpsczVSQ1JDc3JlRjBaMFd4?=
 =?utf-8?B?T2xCY0RvNmtlckxuZ0VUL0Fla2lTZldlSEx0aktFYXlXMTJ4elVFb2VTNUdv?=
 =?utf-8?B?UXoveG11QnJyVmNJbGNpZUtvVzlvL2ptaVBMTXBGajl3RFdJaG1peThHWnc3?=
 =?utf-8?B?Mm95WWc3a2NoWE95TENUcnhZVmZsVlJ1VmROb1luVytFZW80S0R5WW4wZVc4?=
 =?utf-8?B?cFA2czBPOHdZSENtY1dIbnJmYTJpNkJSREVPYXVqeXZsZWFXdEZpSmpVa0Zj?=
 =?utf-8?B?elZVTXUzeGRHY3RsNlROWFBMLzV5Qy83RDZOVVhIQ0pNbWZIUURjYjdUU3g2?=
 =?utf-8?B?K3IxTkFTWDgyNXB1Q0NSQlVTcVpQNjJIUFdJUENsVEUwK0JycTNGbHZ0OTVI?=
 =?utf-8?B?V3llUU1Zblhsand6ZFMxSmtidDV2MjloV1BubjQ4a1BYRzBuSGM5TFpLelp5?=
 =?utf-8?B?T3JVOThoTmQzM2hHTzFOZVdaM2JhQUhmNHMvRjNDaE5BYytFRWs2c2t1SEs4?=
 =?utf-8?B?Z0FDQitCMTVJRkRLbUtqVEcyakllUG8rMFNUaGhrOHY0eWJ1bGRBYzVUcDdH?=
 =?utf-8?B?eUNGSlhyREg1aUNLRkVPZHh3OEx6UElhVkRtY2J0N2sxa3VkSjZMeUNxMG5s?=
 =?utf-8?B?VGpzYjI4VVpvMUI0bUdKK3pRS1NaU2pDWTFMTHMyd0hmS0d1MVpjNTk3SUFC?=
 =?utf-8?B?UjFmaWxTdDFJRDlSVGZSUXRRQ3dRMVA2a3BZRVNKaXhjNHFhRldWZDdIUDlq?=
 =?utf-8?B?V2RZZWI1dTVtRkxad1pmRDRoeStyK04wQ0tKWERkQ2RidlJtNzBMUlY1eis0?=
 =?utf-8?B?RjZnMEdiM2szUlZhQVppRnliS1E0UjdNVVZMU2tEVkRjK21rTUc0T21QbEF2?=
 =?utf-8?B?Yy8vb2tvWkIraG9MY05yWFU0N2lURGxPRGtiSGdKV2xOM1BIT1Jma1grZktu?=
 =?utf-8?B?OGtLNjZnOENzUVZwTmI2b0s0MDNvcFp2UGZndE95ckFsUXlCTld4bTd1bFZo?=
 =?utf-8?B?NXJmZEpHb1Vsdm1wVVVBR1hNMEt3NXFRbFZyUFJDR0Z2NVQyV3ZXK0tCaHlp?=
 =?utf-8?B?RkJuRlBobWU3ckcvS3dRVFRzNE1RSkJhakVMdDZybm5YK056TmY0d0tEQktI?=
 =?utf-8?B?VVEwT1FzRGl5eWZHa05PdnEwQjdmblYvM29SSlcyRWpjZVl6RHpPQjM5RGlC?=
 =?utf-8?B?WmR0bk1xempkR045dll2MENhQXVKODE2M0JUYUtoakVsS2ZuM1JqYWJ0QU5l?=
 =?utf-8?B?WmN5Um9SaktGZk81Zkg2MThCTWhBQWtEaDdIazZOWS9sSEdUMDNReTAxZ2pi?=
 =?utf-8?B?N21hNUdyWmFHSGhvUXk4OUpGTC9QUTRMQ3Q2ZHQ2MUdwUmxPcS90ajRGTXZN?=
 =?utf-8?B?cHhqdWQ3aVNIWHRDaXJTcDg5WW5NaUZVTldiUmVJZVJIYVdydWtsb0xaUGdi?=
 =?utf-8?B?QkFwb21CUkpXeEJFelZZRnpiVHJXb0NJREZUOGFSSzROTG1ndDJvaFBtWG12?=
 =?utf-8?B?Y21ONDBndzZsaDQ4aGZ5RU9sQ2h5aER4UmhIMUh1cEJFTjFwa0lGYk82V0Y5?=
 =?utf-8?B?dU9iRU1LZWJkZTRMSjlMaUZoQ0ZiMUtkbngvaFJGMU45bE5tUGZ5TW9PYWpv?=
 =?utf-8?B?UnZoakFWdVdSaEs3U0NBbmY3eE5PSUhoVGZwSGRjVis3UTdzOGdCV0tBbGZ0?=
 =?utf-8?B?RGlrZEE3L1krRW55U1pBNTNEc2ZLOWlWU09hUnpUemNtL3EvUHpuYmdLbHpF?=
 =?utf-8?B?UTRmekw3TE8zb091UzJuV0xtQW9jbDhHU0Rqd2YwWVliUG5RQWhBR050ekNa?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e1d56f-497c-497e-96d7-08de20cb3bf2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 02:37:19.0829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: boWRN1b5qKI81Yv4Ss6JZlafQK5K35uzY53V1aL41WWo+5YaEyuHnEJW0bmFJ7xxoU+8sLPo4n3mciW8nBE4dcL6CvhgeUNsQEu/sHaUhik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7742
X-OriginatorOrg: intel.com

Hi Tony,

On 11/10/25 5:40 PM, Luck, Tony wrote:
>> Seems like user space has needed information to perform a sane reset?
> 
> Like this:
> 
> 1) 	Read info files to figure out what minimum mask is needed for this system
> 2)	Use Babu's suggested syntax of
> 		# echo "L3:*={min_mask_from_step_1}" > schemata

Exactly, but without the "L3:" and with s/schemata/io_alloc_cbm/. Specifically,
	# echo "*={min_mask_from_step_1}" > /sys/fs/resctrl/info/L3/io_alloc_cbm

I do not believe this feature is being considered for the schemata file (at this time?),
just for io_alloc_cbm.

> 
> Rather than Aaron's
> 
> 	# echo "L3:*=0" > schemata
> 
> I'm OK with this for L3, but still see it being less useful for L2 with asymmetric domains.

That would first require that these L2 with asymmetric domains be made available
as resource for IO allocation. At this time the feature is limited to L3 but when/if it
expands to L2 an interface like this could remain sane by allowing values that overlap all
domains to be set on all domains with one user space call and a clear failure presented
to user via last_cmd_status on first failure if it is not possible. 

> 
> It can meet the "set a minimum value across all domains" need.

ack.

> 
> But can fail setting a value that isn't supported by some of the domains.
> 

ack.

Reinette



