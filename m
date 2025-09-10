Return-Path: <linux-kernel+bounces-811055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3D7B5237B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 23:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B730E1C24E0A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D23310644;
	Wed, 10 Sep 2025 21:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YavzuQ6K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9E82C11D3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 21:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757539924; cv=fail; b=ZEGBCBC+JWV1ztosKV9tH0P9O0JZznlSn+l7pnYH+w/Jwns13dNU7tB90faWda4A9x0o5yKAOYHaUX7rovbAbOA1Mi6DvhfbBwba/0P7jUggIUbLYXXjlWgUFHcWUgDCIeNAA8palQbCA1Q3uDoN2Gnt+JQNZ5L//PkdVA4l1IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757539924; c=relaxed/simple;
	bh=L6uZKEAJA2iVE114/Oo9c+B9dM9LMldNWcGrwINR6ks=;
	h=Content-Type:Message-ID:Date:Subject:To:CC:References:From:
	 In-Reply-To:MIME-Version; b=NeCZCTANuzOZAol3Txrj0jXn+447emP5BmelbbxAfB/15MnVHIoGI2ddfzvbX1RMHb59xbX/L9xYW2rx7NgQWiCcj9MixmEiMd9dcwXxQqFn4AjryJ6CD8HxBZpw1RWjf1Lbn2nx+z0/rxQcvQoWW328zuhKgaXmrp/TPwpJjCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YavzuQ6K; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757539923; x=1789075923;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=L6uZKEAJA2iVE114/Oo9c+B9dM9LMldNWcGrwINR6ks=;
  b=YavzuQ6K2PFxgLmf+f0uy88akYZVn1H0YfTWFy3dTce+kLE/K9jJMPwA
   mPmLCKIYU6kzjxDx8vrZads8c+d3YGc4h4IZDuC4aWjQbXuhi1BdObXpX
   3h/MKiiB8SyNVQnD5lvJwmKXtYiwd9oxF63g5gdBQKV7xDSp2iSSvD+i6
   WdyDpNI4iY28fMdKpR6Ye0VT3FAqx65K9nvk1z6Ex0SdB2tmd9LgI119L
   EIPw3/h2m+P5T7mPaqXIlXbOnyGnr/JKDHbe2JJVj+fjsrh5HKW5PXI4Z
   vNuDUb/DtZvSNywFevCB/gv5QWMg8w8bMS6BP8Y8tvWZmYege5bKqoNiD
   A==;
X-CSE-ConnectionGUID: xxOSBlO6QsG6yosBGIRTCQ==
X-CSE-MsgGUID: xbtbjqusTYKRTGr19ok9Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82450343"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="diff'?scan'208";a="82450343"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 14:32:02 -0700
X-CSE-ConnectionGUID: gc25NN4uTASU9ZwsuXhm5g==
X-CSE-MsgGUID: azQrqlMtQhKBhgYUnPNStg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="diff'?scan'208";a="172792846"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 14:32:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Sep 2025 14:32:01 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 10 Sep 2025 14:32:01 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.48)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Sep 2025 14:32:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSiLBTH4DTUIXLqoD3HX6v3JIsPXSE2Wfz3VAv1CPhOAyiTNN9B5yMNfR6+HjQWCsgTMHxTDIoZSHaOWAelTlYfljgZnuu9SlB39lwXYXpDzzkqg7p1+yL+G4xX967U6e0SbtbDvGDMGnHP2CcRjP1LB3Cn6M/LwdD1ZEnNsJMD/YnLQHfKKlQ7MbDBP3XufGqYnoXw65aX2UN7vIQOXUmlG00JVTqaCMEFLkEJvKZ6PmivWev+770pevAqKE5zQrt9TSWozJmTM5LomDASEJE8PrezdW+alGthu3rDIIzSDxslUkc2QQJtvWTO7rsI9jJjNq+ACX/OIQMwiFWQDlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i39y+XAw1FoQawvlZmfWswqkhYpAATKuH02M5u20K+0=;
 b=mOH6wDtnbye0/AbwAHKWVNM7Zf9Fv0E6NTqCanHn0BdX4t86koe3hQVGUlJwspNi3hBf1B4vKPH0uVtDVbfs21u1W1LecxnhR4j5gTOAraG8/20Pn+BrkhZr1WSOYbzetAAEvJucx7cgmYh/2Nz4k1xGuUS7KQCHH6yWVdBNb4A/6dm+g0G72kux+UXMytjTzccuj3IUNhkleprkSyE3nGvej37OWhxVz5EhtBCzNlZhjz+og+N0kmwBlAvpWLIpl21ex26TnIqv9h31S+krnJ/1jfQnR7cqk879dQxayWifkh2xQ4Aj562kvx942xfdgszPzwmjtKHuYEmQfmzSfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 PH7PR11MB7122.namprd11.prod.outlook.com (2603:10b6:510:20d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 21:31:58 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%6]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 21:31:57 +0000
Content-Type: multipart/mixed;
	boundary="------------kWZtHS7TVjeyV0gnmiu9B4hO"
Message-ID: <4ed4c815-12ca-48e5-a6fe-a2f2dd367730@intel.com>
Date: Wed, 10 Sep 2025 14:31:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] x86/microcode/intel: Implement staging handler
To: Borislav Petkov <bp@alien8.de>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>, <chao.gao@intel.com>,
	<abusse@amazon.de>
References: <20250813172649.15474-1-chang.seok.bae@intel.com>
 <20250823155214.17465-1-chang.seok.bae@intel.com>
 <20250823155214.17465-6-chang.seok.bae@intel.com>
 <20250910183325.GEaMHEdavbE56NiDUF@fat_crate.local>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20250910183325.GEaMHEdavbE56NiDUF@fat_crate.local>
X-ClientProxiedBy: SJ0PR03CA0275.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::10) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|PH7PR11MB7122:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4e48e8-d4f2-410d-2692-08ddf0b1784f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|4053099003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TG5vWGdndFpWYm16SVdpRFJEamZBMlNzTGlMSjRCZm92YVRMOXg4QkVtUStU?=
 =?utf-8?B?Vmx4dnR0OHoyMEdCR29KS1g3REk4YTd1ays2UW5GTjhQdmVsN2ZvT3pGbjl0?=
 =?utf-8?B?djdXMW80azBDTGFJS01VTmgzMC9uc29ORGVsMS91ZFdCT3ZBNTR0ODA1dzdy?=
 =?utf-8?B?WlJMMGovOFVzT21HQmRkKzVLSFllSU1ldVlodW9Tb3NVVFQyT2Nyc2d2Ni9s?=
 =?utf-8?B?RS8xM25VampJZVNETmRUTEMzZnpRYXVrYnJlcktvMHJFRjJQcE5nUHJhcmta?=
 =?utf-8?B?OU11KzV0ZnFzNVVYSWxPZmRTNklBUGQ4YjRjVXVIQlArOHQvd25NaFJ6NW5o?=
 =?utf-8?B?MkVSdXU2SkFNdlBCMWhKZmloa0I5d3dpdmZhU1BHYk5yVHlHVlRRaDdKVXdu?=
 =?utf-8?B?ZVFIckdUREw3QXBVVHFTYk1aOC9VVkdndlhUMGRRNjNwVjc1YVhNS1FVM3JY?=
 =?utf-8?B?RXU4a2lIMm9JYkZvWTNlSEVHZUUrNWlQK0UvamthY0RGOTVpUkZwU1VMS3FF?=
 =?utf-8?B?Zjd0SVJ2S2RvM1VXWlJSSVlWZndRYzZhKzQwWVNUQ1dKQ3lzMHlURG5xZ09n?=
 =?utf-8?B?eXlVSklvQ0xidWwzdEd3MkNPbEdSZVFaSkFkdnNCQTA0UCtPeURuRllocW1s?=
 =?utf-8?B?WG9iZjhST1p5YS9mZFBTN1VITjcvS2xzejlwNnFPaFp6MHB4OHF4SUp5NjA4?=
 =?utf-8?B?T2ZoeXFLSlZuZnRwQUI0RUlDZi8wNEdtTjFIZnpZRlYreGtoR2lSODFmZlFP?=
 =?utf-8?B?L2pITHIyU1JteVNUaFpIRHFuOHp5TElyYzdudGJoUlh2amkrUG9oeWlaUDJB?=
 =?utf-8?B?dzZucW51NXUzdE4yQU5YR2ZBVE82ZjlKbFNRbm9XNHlWbTMwZW9NVnNDYzBs?=
 =?utf-8?B?MmtzOC9sT1Z5ck9pVVlXN3ZmK0tTdkxFcVpMcGF0Y3dxY01OckVTc3V0MVNC?=
 =?utf-8?B?dFVDSS9mTFpvcFdBRk1BUDAzQ2c2YkdaYjlubjFIWmVJdFhaS2dRYkh1N0F5?=
 =?utf-8?B?aHNGdDhVZVR4MGF6T2RMN1IyV2t1bHZDellCSGVUODNONmJVdlRpSVNSeURm?=
 =?utf-8?B?ZnNsM0owWDJsVC9mQmhZWnhEdkRkUGdqQjFhSHMrNFcxcS9YWEdBQlA4R00x?=
 =?utf-8?B?aCttNWFzZzQ5ZWNrSUdVMXZOd0M0Y2NXczEya3Z6RHFzQ0themNWY3pMKzlD?=
 =?utf-8?B?TXBVL3lhWEhhUWI1T3d0V1I2M2NlQWk2UHZXck8rUVczYVkyT042UHhxQ0xT?=
 =?utf-8?B?ZytKZFNKOGdxNVpVMi9TTGoreUorSXpOTCtEWmxFKzhVSXlmNm00YU05RlRV?=
 =?utf-8?B?SDFNM3daQ1J2WXdjcFh2T3JHMmxXT2Y3Um54OFAvVDh0cmpCNFYyT1R6Sm5k?=
 =?utf-8?B?Sml2V3I3bm5IWHAxSGt4eGpXQ25YQWw4eXFhR1JXSy9UT3hPTEhoZ2loYTYx?=
 =?utf-8?B?WUxoTWhmbVB5UFU0MnJzQlNFSXJOK2hHTEdGQ1UzTHFUWDI2SnJ4bTdkdjVS?=
 =?utf-8?B?QXliWmdMTUZkV2V4eC9DVUF2QmhiRnVBNTA5ZitRR202YjVrSnllcjhLNmVW?=
 =?utf-8?B?WU0zT0Z3RllVYm12TWdyaEkyUExBdFEwa2JtdStPNmg4aUcvNTliMkVvY0Va?=
 =?utf-8?B?VERvZk84aDBSdytrQlB3cmV5a1VpTWZzeUNNYnZDbytrZnNpRTQ1ZDU3amhq?=
 =?utf-8?B?LzRlK2x4Rko5cU5pSkRSUDhUNHg5WE9nd3hiejJkSUp1YnZUaGRqWEN3dW1x?=
 =?utf-8?B?MEdMM2s0VlRwK0sxM2hpQ3Nld2dYK2toQkJIVUZ2RjhIVnJuRHVPN3V3L3ZT?=
 =?utf-8?B?ckhDbGU4ZVBWbHNzdmNKYzNqT0xXRzZ1TmFOa0oyWHdTaExMZFBwRFNBZ1Vo?=
 =?utf-8?B?K0xrWko0R1lsWk1US0dBeXJwK1E2Q01JVXkzeEZCZy9iSTFxaWJ5MVpHeWNw?=
 =?utf-8?Q?gUHxl78b+58=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFhXUllaZndEV0wxQmNpeURIN2h6Mk5lQXI1VUFBU3A3L1VEUTZ6NE9BVjJh?=
 =?utf-8?B?cmJJclRCWUw2Q3FxbDVPNEM2bXY5RlhMZTVpb0lSQ0kzM2tUS2MyeHU3QUY4?=
 =?utf-8?B?UFZlK3RoQ2orTVdvSlNuSEhmTmJYM3pWNXFWb0RwazFqdmFXY0tMN2l0NFBm?=
 =?utf-8?B?cWtLY01LV0s2VnkxN2FsZkQ1T2NoajNzbTZCWldWc09yczNsSmtHbWJVLytF?=
 =?utf-8?B?bnVFbzZILzB2UFhkQUlqYU4yYkw2Vm9jTmtZSWdac1pwQVovMHNpdXhmV3pZ?=
 =?utf-8?B?REpNQUk5Y21NQzZvd3dCL3Jpb3RLeS9nM1JTWEc2cnptMjNUN0NpbWIwcUlG?=
 =?utf-8?B?NnRZUmRsMjhuRm9neE12MmQwbTlDVXhtNjJqdXhkR1BTajhTTDdRWWdrSnp1?=
 =?utf-8?B?Z3RTaW5xdGVKcTVNTDFLMzZobENLbEJubFViMHFrTlBvUUpCU0djQTlVZnFR?=
 =?utf-8?B?U0YraDdGTHBFVFQyckdZMmZsNVhLRHdDZngya1J4V3RpUy84VnBiT2E5QlhJ?=
 =?utf-8?B?ZW9oTmRneG5kei9wbWNIUE5BY01QM3U1bGNnSE5FQkU2VktZcTZpeG9SMmU4?=
 =?utf-8?B?N1Uxb2RUTGR6U0xhWGxyZmZnZGtoMnNFOU9rT293TjNOR1JDOEIxd05Ib3hk?=
 =?utf-8?B?NXRzeHVXN3lrR3JBY0ozUDI3ejVlU2xBUkpOVDJ6WFhTc0F1enVkY3JlRFlU?=
 =?utf-8?B?ZzhHTVVXTmhDdlN2b1N6QVBJL1A0eUNtTk1KcGFlQ00xTnIzSGtMVW93QVlv?=
 =?utf-8?B?eW9WemZJcUJzLzJYVG9YSnpQZzdOQTlScVBJVXBUUDh2WFJGU2xKN2tFZHRV?=
 =?utf-8?B?MVNtTDNuUjFOM1dqTEV6LzY2YytMK2UxWkN4Q1RaTnVOcU9MT09rbzVJU2l2?=
 =?utf-8?B?QXcrNlhnUW1MakxDU0NJNk5IQzljam9VbXR5ZWNvM2ZsUXBCV3YxYW0yM1Vu?=
 =?utf-8?B?RXN6YVFLZGJDeUZMbUYvdFhGUXFCRjVNSTVVN01FMjJGUGprK1ZmaXNheFh3?=
 =?utf-8?B?RjVFaWsyYzNBNGhDNTN4dU1QVzZXVjVBQnVCVEZLaHg0Nkc1czlHUDk0ZGpt?=
 =?utf-8?B?dXFFOGxVdEZaeTdvajNianhuaDM1eERCYk9TeFFwWjljeFh6N0NNcmpaZnJv?=
 =?utf-8?B?Zmp0RkpUTlJHUXZtbG9WSWVtK2ZZQlB1c2srRUNJQmtscXlxell2VUMrc3dX?=
 =?utf-8?B?TlFtQTdYSFFaa2pqZzBrWVlweElJY3NrQjBlcEc0aFhzN29HQitSd2p5RDYv?=
 =?utf-8?B?S1pHdDFjNlFaSEtOVVpQRStNdmgwVHZoektKajRWSjd4SjAwZ3BBc1E2V29i?=
 =?utf-8?B?ZGNoMTVBRXZJWDhsZjZ2TklRSGxuZnRrWTV6d1V4SDFYcTJwNkJYL1dVcWhh?=
 =?utf-8?B?eXdUZzBIZjhEVVU4Z0k1YXNLYUN1TDdDa2ZLYzJvK2xYNmRQVnNldm5DeTJy?=
 =?utf-8?B?ckJXYVZHQktSRFlOOEx0S2piRjBnclZsMWlJbUExek5BQllvQ0Z0dUpNN28z?=
 =?utf-8?B?SlZ2Z1NtT3JwbG9UemJJcTZMbWJrWHpxNGpCek41Q2J6c0pQUWp4SDBLdFlZ?=
 =?utf-8?B?Q2krQ2p5ckZXR1pwK043OTNTMmlPa1VEUnBjTldsaW1lbWdqOW53MDdMYjFO?=
 =?utf-8?B?WlhIQUFtUDRBU1FJRVZSckE1Zm9DWXQramhYcmZZTGRGSkU5c0F1SWFiOTJn?=
 =?utf-8?B?UFY1NnFGWTFiQkEvZ3k1NkkvSUNFcTFSeExFVkJaR0FYYzQwWDE1UHRua005?=
 =?utf-8?B?ZWNkODA3Nm1oZzVHMG1WdGxXWmFzcVAwaXlaemRaZWlGemxJclNGalpJTXJz?=
 =?utf-8?B?TTdzUlRRZWdDbWxhcUllYU5DY25BVExtQkFnRUwya3pZbEhMT0Y5WWoxNUZm?=
 =?utf-8?B?NkFjUklkU3A4TEx4bWNpemN1bHRXMFg4VFh2STVEUDRFc3N1VDBoVDgzZlNT?=
 =?utf-8?B?ZzFyQWpSc0NRTk9haWVlZDB3ZGZlcDdWSWFkcGZDb1FYR1NJMEF1SmhvNS84?=
 =?utf-8?B?b2RxbGhFS1FpcXdNbHVlY0ZVbFVVVmRha1hMeDNJNXNjODl1VDVkWjlocGZi?=
 =?utf-8?B?OXlJWHpGS3gxa3B1eGVOVWZpUElwOE51QkRCRmIvb2hGU3ArRnowQkc1RHlr?=
 =?utf-8?B?ajJOU1dSRFFNZDdJVXBhV01hbGZ3bHNWdjcrWDdwL0p1bnZKeFk2aGwzY09C?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4e48e8-d4f2-410d-2692-08ddf0b1784f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 21:31:57.7446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ieWj2bMpp2d65xYcAjW6y3yZmzGzmmRe9NWrjbwQgYFZwkMYXGp+pag6TXU9XS1WGcvsZJHFS5Afz28zryvPKOEC3kQ2CdvOOtOfnzJ/d8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7122
X-OriginatorOrg: intel.com

--------------kWZtHS7TVjeyV0gnmiu9B4hO
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/2025 11:33 AM, Borislav Petkov wrote:
> On Sat, Aug 23, 2025 at 08:52:08AM -0700, Chang S. Bae wrote:
>> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
>> index 3ca22457d839..a1b13202330d 100644
>> --- a/arch/x86/kernel/cpu/microcode/intel.c
>> +++ b/arch/x86/kernel/cpu/microcode/intel.c
>> @@ -20,6 +20,8 @@
>>   #include <linux/cpu.h>
>>   #include <linux/uio.h>
>>   #include <linux/mm.h>
>> +#include <linux/delay.h>
>> +#include <linux/io.h>
> 
> You do see those are sorted by header name length in a reverse order, right?

Okay, fixed -- and I adjusted patch6 as well:

  #include <linux/initrd.h>
  #include <linux/io.h>
  #include <linux/kernel.h>
+#include <linux/pci_ids.h>
  #include <linux/slab.h>
  #include <linux/cpu.h>
  #include <linux/uio.h>

>> +/* Defines for the microcode staging mailbox interface */
>> +
> 
> ^ Superfluous newline.

Dropped.

>> +/*
>> + * Return PAGE_SIZE, or remaining bytes if this is the final chunk
>> + */
>> +static inline unsigned int calc_next_chunk_size(unsigned int ucode_len, unsigned int offset)
>> +{
>> +	return min(PAGE_SIZE, ucode_len - offset);
>> +}
> 
> That oneliner looks useless - sticking a comment over tne min() and putting it
> at the single callsite below is good enough.

Agreed -- removed the helper and moved them.

>> +/*
>> + * Update the chunk size and decide whether another chunk can be sent.
>> + * This accounts for remaining data and retry limits.
>> + */
>> +static bool can_send_next_chunk(struct staging_state *ss)
>> +{
>> +	ss->chunk_size = calc_next_chunk_size(ss->ucode_len, ss->offset);
>> +	/*
>> +	 * Each microcode image is divided into chunks, each at most
>> +	 * one page size. A 10-chunk  image would typically require 10
> 				   ^^^^

Fixed.

Just to make sure, include the diff here.

Thanks for the careful review and for sticking with this set.
--------------kWZtHS7TVjeyV0gnmiu9B4hO
Content-Type: text/plain; charset="UTF-8"; name="tmp.diff"
Content-Disposition: attachment; filename="tmp.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWljcm9jb2RlL2ludGVsLmMgYi9hcmNo
L3g4Ni9rZXJuZWwvY3B1L21pY3JvY29kZS9pbnRlbC5jCmluZGV4IGM3YTc1YWZkMmI5YS4uNGQ2
NjNjYWI0ZjQ4IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21pY3JvY29kZS9pbnRl
bC5jCisrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWljcm9jb2RlL2ludGVsLmMKQEAgLTEyLDE2
ICsxMiwxNiBAQAogICovCiAjZGVmaW5lIHByX2ZtdChmbXQpICJtaWNyb2NvZGU6ICIgZm10CiAj
aW5jbHVkZSA8bGludXgvZWFybHljcGlvLmg+CisjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4KICNp
bmNsdWRlIDxsaW51eC9maXJtd2FyZS5oPgogI2luY2x1ZGUgPGxpbnV4L3VhY2Nlc3MuaD4KICNp
bmNsdWRlIDxsaW51eC9pbml0cmQuaD4KKyNpbmNsdWRlIDxsaW51eC9pby5oPgogI2luY2x1ZGUg
PGxpbnV4L2tlcm5lbC5oPgogI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KICNpbmNsdWRlIDxsaW51
eC9jcHUuaD4KICNpbmNsdWRlIDxsaW51eC91aW8uaD4KICNpbmNsdWRlIDxsaW51eC9tbS5oPgot
I2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+Ci0jaW5jbHVkZSA8bGludXgvaW8uaD4KIAogI2luY2x1
ZGUgPGFzbS9jcHVfZGV2aWNlX2lkLmg+CiAjaW5jbHVkZSA8YXNtL3Byb2Nlc3Nvci5oPgpAQCAt
MzYsNyArMzYsNiBAQCBzdGF0aWMgY29uc3QgY2hhciB1Y29kZV9wYXRoW10gPSAia2VybmVsL3g4
Ni9taWNyb2NvZGUvR2VudWluZUludGVsLmJpbiI7CiAjZGVmaW5lIFVDT0RFX0JTUF9MT0FERUQJ
KChzdHJ1Y3QgbWljcm9jb2RlX2ludGVsICopMHgxVUwpCiAKIC8qIERlZmluZXMgZm9yIHRoZSBt
aWNyb2NvZGUgc3RhZ2luZyBtYWlsYm94IGludGVyZmFjZSAqLwotCiAjZGVmaW5lIE1CT1hfUkVH
X05VTQkJNAogI2RlZmluZSBNQk9YX1JFR19TSVpFCQlzaXplb2YodTMyKQogCkBAIC0zNDQsMjQg
KzM0MywxOCBAQCBzdGF0aWMgdm9pZCBpbml0X3N0YWdlKHN0cnVjdCBzdGFnaW5nX3N0YXRlICpz
cykKIAl3cml0ZWwoTUFTS19NQk9YX0NUUkxfQUJPUlQsIHNzLT5tbWlvX2Jhc2UgKyBNQk9YX0NP
TlRST0xfT0ZGU0VUKTsKIH0KIAotLyoKLSAqIFJldHVybiBQQUdFX1NJWkUsIG9yIHJlbWFpbmlu
ZyBieXRlcyBpZiB0aGlzIGlzIHRoZSBmaW5hbCBjaHVuawotICovCi1zdGF0aWMgaW5saW5lIHVu
c2lnbmVkIGludCBjYWxjX25leHRfY2h1bmtfc2l6ZSh1bnNpZ25lZCBpbnQgdWNvZGVfbGVuLCB1
bnNpZ25lZCBpbnQgb2Zmc2V0KQotewotCXJldHVybiBtaW4oUEFHRV9TSVpFLCB1Y29kZV9sZW4g
LSBvZmZzZXQpOwotfQotCiAvKgogICogVXBkYXRlIHRoZSBjaHVuayBzaXplIGFuZCBkZWNpZGUg
d2hldGhlciBhbm90aGVyIGNodW5rIGNhbiBiZSBzZW50LgogICogVGhpcyBhY2NvdW50cyBmb3Ig
cmVtYWluaW5nIGRhdGEgYW5kIHJldHJ5IGxpbWl0cy4KICAqLwogc3RhdGljIGJvb2wgY2FuX3Nl
bmRfbmV4dF9jaHVuayhzdHJ1Y3Qgc3RhZ2luZ19zdGF0ZSAqc3MsIGludCAqZXJyKQogewotCXNz
LT5jaHVua19zaXplID0gY2FsY19uZXh0X2NodW5rX3NpemUoc3MtPnVjb2RlX2xlbiwgc3MtPm9m
ZnNldCk7CisJLyogYSBwYWdlIHNpemUgb3IgcmVtYWluaW5nIGJ5dGVzIGlmIHRoaXMgaXMgdGhl
IGZpbmFsIGNodW5rICovCisJc3MtPmNodW5rX3NpemUgPSBtaW4oUEFHRV9TSVpFLCBzcy0+dWNv
ZGVfbGVuIC0gc3MtPm9mZnNldCk7CisKIAkvKgogCSAqIEVhY2ggbWljcm9jb2RlIGltYWdlIGlz
IGRpdmlkZWQgaW50byBjaHVua3MsIGVhY2ggYXQgbW9zdAotCSAqIG9uZSBwYWdlIHNpemUuIEEg
MTAtY2h1bmsgIGltYWdlIHdvdWxkIHR5cGljYWxseSByZXF1aXJlIDEwCisJICogb25lIHBhZ2Ug
c2l6ZS4gQSAxMC1jaHVuayBpbWFnZSB3b3VsZCB0eXBpY2FsbHkgcmVxdWlyZSAxMAogCSAqIHRy
YW5zYWN0aW9ucy4KIAkgKgogCSAqIEhvd2V2ZXIsIHRoZSBoYXJkd2FyZSBtYW5hZ2luZyB0aGUg
bWFpbGJveCBoYXMgbGltaXRlZAo=

--------------kWZtHS7TVjeyV0gnmiu9B4hO--

