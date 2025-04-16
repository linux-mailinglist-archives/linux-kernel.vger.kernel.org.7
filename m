Return-Path: <linux-kernel+bounces-607151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE8EA8B879
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 14:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BFDB1885A3C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 12:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922B5250BE5;
	Wed, 16 Apr 2025 12:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dtL6BW/g"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A6D2505BD;
	Wed, 16 Apr 2025 12:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744805223; cv=fail; b=AWQhlozM3L00gRAlsBB9nYcgKGu25RwefeL4LgNjH6EY/SS6J0BAFhVc0TVHrEEqgB57lktUWp2+NrkJOtqrtbCymtxm2qGUNCeN1TLDhVWo/FhVveaQedClEo29BbWzW6ax5FnRCq1IRjxtT+R31OXu3mu6BNEnPhT6M0sD3Gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744805223; c=relaxed/simple;
	bh=9NMKZJ+rO1KD8JMxNDv9hWZ7E9zfuqcnOa05Ju9hsHM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pedqya7pFeZ2ld4RKWShnYO0P5rJ/pSr/YHGh/SY2O2ytiB96hWbD+QcESVdonLTN7NHUyMNZ+1Zey4TLXayYjosPhreueRHR3xunmfvSgDithZdIGpJ0ukKQPhxCIV642iKn65EDg2Vh9YSOld/5u2F7Js4cBMYR0BvjGYfTm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dtL6BW/g; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744805220; x=1776341220;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9NMKZJ+rO1KD8JMxNDv9hWZ7E9zfuqcnOa05Ju9hsHM=;
  b=dtL6BW/gyxL7lrghJyDAjvyZaK4Wa/xHVnrZq2fu8EEtNH63PRG7F+hQ
   Nh08xUg8c3/+SkpHonXnZZRZAi/ZjzoCnOhuIhogvNUEWsd0CoyGQDUSK
   8KUF/AJAuaXlBm4Xxmcjra462AkCi/X1NfmlWHVXnkL+De5l25MLjzxIW
   Bq68UBdEw3YQ1tj+XJ4NpIckkJrjc8WYn6U+5zPCKOvvvujWcWN1YE+U8
   XuX7iyyFtHyWUTLT0jb1jjyxM+S9KlatDWh8CpiOTDl81lEWJwzBFW0AE
   GZOrglZ8A3gAxBtSvY+mg1IaauoOv2GHzOawXTrvH/KUH42NC0d4XLPfL
   g==;
X-CSE-ConnectionGUID: tOS5Y855SHqihHov3IfhSQ==
X-CSE-MsgGUID: e3DDpUlHQHayoxDCqLBZMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="49043362"
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="49043362"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 05:06:59 -0700
X-CSE-ConnectionGUID: T4eougDARX2NIPyLMXiXNQ==
X-CSE-MsgGUID: wcnW0yJnQN+6C09n102ukw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="167625093"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 05:07:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Apr 2025 05:06:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 16 Apr 2025 05:06:59 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 16 Apr 2025 05:06:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lh92+IjV0JXnblGUZvqaXeFuUEc2GfAgd2FuAzLKwTtZkBVe3olu9yDjdJ8gfOV3eM7ciP6QSoeHL6sD58DSpFkudzXBgC/hqBXfuJdRSpf3+bL4NFFdeZmR46w+qbCBRXGu1HUWIsWVCOHrjYdk0SdsgovJKm9JWOpPrRiipYRRAo3hCXgEl+65FZu/Zf24EhIagzHlVcvaptfOBPvW5DE1gDi6Oxe7iHIpXAxzChqwZu5wqE+S591cwsD/Sm6kFSwoImTj4kIAql/9N9v0B4cKCoQ3J2PRTHNOzXo4iFODh/zUU0HrmtEKPv+sIL8D1rV4QADUdXL9HhdpPoGtSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NMKZJ+rO1KD8JMxNDv9hWZ7E9zfuqcnOa05Ju9hsHM=;
 b=nMQFvbomfXKrI3VuqoVaPJdwuQl+EDpFuFryc1ZvaCW3acuC86q4kVmk2Xtv33xm1S+qvfMHeGMkOVYT70yNqytBbjAGYyb9nfqc1xRxDVTyw8Xxv04Te+SmqM9pPlEEPx+FA25mGS+DqN39r+TiD4XZvadWHzbSeQggCvsQ8sxIb8szh/wTTa4IrUm67zw7qZ75pzpWM3qQlf35ogLCEXFxW9knQVkimU46wB3l8eZkXIgqztoTARINb+1V7TsJDT2gdSgk4CgdoEzw1e5kfisvTWMeZttS0+TT2mneztwynYBnnPqNigsJ5fPTqUMx0Bq3WHy2eG/bIEPQpOXgQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 DS0PR11MB7335.namprd11.prod.outlook.com (2603:10b6:8:11e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.32; Wed, 16 Apr 2025 12:06:56 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::4df9:c236:8b64:403a]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::4df9:c236:8b64:403a%7]) with mapi id 15.20.8632.036; Wed, 16 Apr 2025
 12:06:56 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Huang, Kai" <kai.huang@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>
CC: "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, "Scarlata,
 Vincent R" <vincent.r.scarlata@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"jarkko@kernel.org" <jarkko@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "Cai, Chong" <chongc@google.com>, "Mallick, Asit K"
	<asit.k.mallick@intel.com>, "Aktas, Erdem" <erdemaktas@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bondarn@google.com" <bondarn@google.com>, "dionnaglaze@google.com"
	<dionnaglaze@google.com>, "Raynor, Scott" <scott.raynor@intel.com>
Subject: RE: [PATCH v3 2/2] x86/sgx: Implement EUPDATESVN and
 opportunistically call it during first EPC page alloc
Thread-Topic: [PATCH v3 2/2] x86/sgx: Implement EUPDATESVN and
 opportunistically call it during first EPC page alloc
Thread-Index: AQHbrfzujDHiSNozs0m8Z6fqnS5FZ7Ol6JiAgABHaSA=
Date: Wed, 16 Apr 2025 12:06:56 +0000
Message-ID: <DM8PR11MB5750C80ED4AB80C696F581EFE7BD2@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20250415115213.291449-1-elena.reshetova@intel.com>
	 <20250415115213.291449-3-elena.reshetova@intel.com>
 <11f7e006073d2a4fa8fd6c609024a69ed40af9d6.camel@intel.com>
In-Reply-To: <11f7e006073d2a4fa8fd6c609024a69ed40af9d6.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|DS0PR11MB7335:EE_
x-ms-office365-filtering-correlation-id: a2388e8d-4bb1-4b96-d88e-08dd7cdf2efa
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RHpRRnQvclNwcXFTUkxiclN1QWlCd253eUdHbk91d3QxYlJJTG1ZdDU3d3VK?=
 =?utf-8?B?dGNSVVk5Yk84cUtJNjJkTms5emViT0hNR2JhcEJYbXNENTB6TjR2RVdqdWcy?=
 =?utf-8?B?Q0VoQ3AvR2M5QlduNEdrTHlmQ1RaUFpZbEt5NFc3MGVweXhLK2Vuem1JOUM0?=
 =?utf-8?B?YWZMeG02QkNtTnVvbG1mSjZMOXFPTGhGME1LVUdlNUdVbEVtcFFzRGUvVy9u?=
 =?utf-8?B?cjN1UUFGTmRPSUZvWWtEMTFCdEZiRlFzWXRVRUE5MHdrOXl3L1VhTjhSSmpi?=
 =?utf-8?B?eU5zdksxM0hCVTlaS1VkMkpIWTI5SVBva0hLakpOSkZwRG8wbC9UNHdOTkRk?=
 =?utf-8?B?TThzTUdIVysvdVVSeW1XUktvR1NqQzY2UExWdW44dDVsQTJDU0NIM0hOSWR5?=
 =?utf-8?B?N1hlLzRBTkRzdzMxNlUrRXluWUhSLytydCtLNzhqZ2owd1F3c2dyVXJDS01n?=
 =?utf-8?B?RWFLcmdiaVNrTFRHaWVFbjk2QzlBazhNRUpSZzhPK0VNNG4xcExNdHAxSzMy?=
 =?utf-8?B?VnhTTWo1ODF0NkNuWXVrZktZbkNFOWJjR3NlTHNIbkkxTlJ3V2JRSVl6d1Jl?=
 =?utf-8?B?bjNKVENRV2JyMTJLeUZpN250aXhrM3FPQkwvcmswTzdkYys5VXpvbVhsTkYv?=
 =?utf-8?B?NWQ1ZWs0b0ZJYW5kdklad2tQd2I3dmVaTGdzQTB0T0VHN3FNeWdBT0JTZVQr?=
 =?utf-8?B?WGdSUENxMlhNNmVIT2dqRlM1Nmw4dzdrTnlVemI1ell4Y1pvb3FteFVLaWll?=
 =?utf-8?B?ZGFXazBONittcFpJVEdkdFdjZURsdGU2L05UbzZUdk9nTlo3SlExWVVnbHFl?=
 =?utf-8?B?SGM0REZCT08wTDdFcnZKSklyWTAyc0tyN25MZ2xNcTYwWm1wTUdBVXV6NDFG?=
 =?utf-8?B?WmlzT1pFMk4vSWtoaS9yd2RtenFzVkZob0tpWDBiOEdqUGU1OFpZTkgyZS94?=
 =?utf-8?B?dzE1VHdSdmo1cWpRVmV2V1oyalVWK21zM3BGWkNTbldOY0Y5NFZNWFBaSlky?=
 =?utf-8?B?RGZodzVnQTQ0QS9kckpzMUp6TUZrVWhSOUpBeCtiSG1JaTVYblZvbWpwZFNs?=
 =?utf-8?B?ZTB5Tjd2cHJQbWtVK1Fkb0R1WktJaGJKb0ZWMmdyUVIxeDdUY08wL3BhVkwr?=
 =?utf-8?B?c1EzY3d6RDNuUm5YMkdpUzI0QjhVbTlNaHZwSmdNVWdRaDJaelNTaTlQeVBR?=
 =?utf-8?B?WHJFWVpEZm5tV1RHMmRzb3lqeWplWCtCajRoRFFlL01ydmhmRTNwNjBPR3Vw?=
 =?utf-8?B?dkVldk5CZlFid0xQSU9DSmpxOGpsenppalZQS0R4djRVTkFYSDI3ajU0YTBE?=
 =?utf-8?B?ZUg0cXdyZ3V0bDZtUUFNL21NdlpHRnBaL1lyT2JLRUhoSUlacnVpOUFhUnJ4?=
 =?utf-8?B?MjhyOEtJY0kwTWdPOXFoZko1a0EyYTNKMGMza2E4YU85dUJlYmZjRlJpZ2xE?=
 =?utf-8?B?eGN4b3NpTXJBRWYrb0hQcGNFd01OSGNLRzhzRkwvc2dMSDVwNjZSVHlxV1JB?=
 =?utf-8?B?SnhCQWwxeGg2QTFpenBrT2IrS3dqVy9aMWJCV1ViRk45ZlRXdzBuQmd1YlNr?=
 =?utf-8?B?QUVvdmRxY1ZndlI2NElKeHNKU3VNMkhudi94c3FRTlFlUFZVRHkxZ0UrdEU2?=
 =?utf-8?B?czEzenZOUFpJVHB5MzFCOFY5ZGdnUlRkY1pTT2RZcHI4dklwaFZvaEh3bVNZ?=
 =?utf-8?B?NmxNeWEzQkxwdXhGelRTNFlSUmY2aU16b2QyZW1vMVJ0b3FXK1lHVm02UkJM?=
 =?utf-8?B?cFQxSG9BY0JaeVg1Z1pxQVQvN0dKa1dUQW9VUEtQUEdGREtldlBQUzdiU0dP?=
 =?utf-8?B?V2twOUxEaFp0bnhRQTNaT2VmMGMxdTg0ck5Pc0l1RFIzUjRkVHM4RTg1OFgz?=
 =?utf-8?B?aEE0L0kySTJUckJxYThiUnBWbDNZWHJ1dmRzVFd6d0NrY2R2Y1lFNktNNUk3?=
 =?utf-8?B?a3hPNUl1VzFGVXhQd0J5WmFDWndWdVlqb0xpYmFWV1ZDcGRHNVh3dTBXc283?=
 =?utf-8?Q?wyEZqo2iX15eOO8gbEiTfE9qcFnPpE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVNGV25kNm1INCtzaUVoMTN5M1V5OGdONytCbTBlTSt5a1Z3UHowZi9jemF0?=
 =?utf-8?B?WHFiOW12clgyZE9JRjZ2M0Z6VlZzUDlUTjc4Q1MrWmFTQ2dtaTJsbWFWWW5u?=
 =?utf-8?B?UkdDYjlxZWZuU1NEaU1Ba2FTR3VSQm9YTUZlUEFOU3RIS010ZFQwdmFFdEJR?=
 =?utf-8?B?ZnhmRThQcWEvWEVvZldQbWxFWHZ5ZGdvdHJWNG5YZDl0S1FROVVVdE9oSFpq?=
 =?utf-8?B?S2N2aThWWHhyVDVibktzY0pFZm5EeTlNcDd4Wlg5M3V5SWh4TjhRUnpJWUpN?=
 =?utf-8?B?ZlErOWhrUEhWUGw2RVBzYllETC9RVzFYNjlZVFNLSWFjalBjcCtwU0NzVWFm?=
 =?utf-8?B?aEMzYVR2V2VJd2UycElSYlFCOWpxYU1vUjY2TXNRQk1SRDlJOE5vOC8vY1Bt?=
 =?utf-8?B?UnR4OWx2QzJzeC9vOXRtc1FZZkNhUXJVVUFmczhjcnpUdHNCWHluQzM5YXFj?=
 =?utf-8?B?YnA1WnJhaWZsc2hlbFJpY21LL0E2TWpyL0NIVERkMkF6amFDdkpMT1ZjRlpp?=
 =?utf-8?B?YzVpTCtwOEFXd1BmYnEyWEYrT1V1OEdoM3dXL1ZZeEZyR0RVYmtWb2I5TUIw?=
 =?utf-8?B?TXZNWnFNL1hKMXMzUy8vem1UYldWV3REV0lFT043U1F1QlBCMDhnZGl0cklX?=
 =?utf-8?B?MFBzS1V4Ly9MRTRjZTJVZW5iNDZlMFZ2b1k4YUhIZTJxaExlQXYzajVrOU9h?=
 =?utf-8?B?VHFGWHlHaFphQ056eXphSWN4VFk3UDRxZWZBSEt5WW5uVURSQmo0cUZXUFRs?=
 =?utf-8?B?MFBzWVd3UmFPY3FpZ2VXZmdwQjJqaHlTcmVNZ3BzR3h3WHFWanBQQXBUNDRW?=
 =?utf-8?B?Mm9QaDVGbTVwcmFvRlFSL3EvaTZHRHNaWGlvc3BYcGhyVUl4aXU5YVZYR2Zh?=
 =?utf-8?B?UW5wZTREUXdlZ3ZRdWNjZTRxTU8zWS9CcVphSHAxZUU0ajd3RVhndlcvcUoz?=
 =?utf-8?B?ckxqNkNiOXIwSzNjVjBjdHB3bXExSXJNYS9EbStvMWszZFQ4THRESmhEVHg0?=
 =?utf-8?B?LzEzNVJHWWN2S2trOTlOMXFzcGEyVWljd0RSN1ozdXJMdGZhbnhqUjJRZ1BL?=
 =?utf-8?B?QVlBbFhERERnNVAweVhyN3RienY0RjA4SHV1dWFYUU9tbmFkMnROK0FCdmpw?=
 =?utf-8?B?WXppSEx6SUx6aXFzbHcydlFtQjYwTXZsQmhIOXl1VFFaQU13MDRFYXVQU2tD?=
 =?utf-8?B?b3dGTytmZkw1Ti9LQk5iUGtCMTIzd3NmYXU5UzJzUk9VTy95cFJnY0Z2SVZW?=
 =?utf-8?B?OE1DczlQa2R0cUdVMzZ2SjBYS0xsVmtRczUyS0lHbEdVeHk2bCtpRUdaekQy?=
 =?utf-8?B?Rm5yYlRTQ3I1R1pjUWVzL0MrZzIrV1FmQmlCSUR1ajBSVmlodGNEQUw0QjBW?=
 =?utf-8?B?Z3JFM0JTRlQ1Rks1ZUsvREExK1BJNUpMVUVsNVA1bEk3N3MzdGRkTHRQeFdC?=
 =?utf-8?B?TDd3Z28xUXlLZUM2NVdzVEdFcGo2bUxUNVJOL3hFRWpSWW5yM3Z2cGVUalhp?=
 =?utf-8?B?NjYwR0tEVFFTbzNvTzJZUnFiN2V6aGJRK0s3dUR2a0F3V2NSZ1FyV21mNVVy?=
 =?utf-8?B?QVRFanlMdEdwdWlXcmpheWhxdE1xbU5uMlFQWWFQcUlRYjZsbWFPNkVNeGRz?=
 =?utf-8?B?MVlWbHNvaHF2T1NZSm1TTWQwYUJFd3Nja1pSaldUUEEzZjJ6WW1Vc1RqSHFM?=
 =?utf-8?B?Y0hwZUpSZ1NhS3RMcWgvdmRTZTRLdzFKMForcHNmNmUxOTRYcENPUTRmTkly?=
 =?utf-8?B?SnRiVTM5bnNLblM3TlRCRGJQNmI4d3cvRE4zUm1ReFpsQTZjRm96LzNlYTVL?=
 =?utf-8?B?YzVyelRuSUoxZE8vNXdOdFlnNUdEV2hrYytzQzdVQWtNUGw4UW1qOWVWNlZx?=
 =?utf-8?B?S0doeXhzMjhKUkdKdUpPYUR5TjQvc0tHc1UybEV4TGcrOThWZzNMc1ZpNTVz?=
 =?utf-8?B?dDFCS1NIbk1JeWhGMVRtdnRjUTZuUnllTmM3a3pYNlBHU2luSklmYzhlVTIw?=
 =?utf-8?B?WUtkY3ZuUThnMzk2MURwQmdQcGpoTVpGV1ViaFNIem5pL2RWVkRYbFFndmFi?=
 =?utf-8?B?dytVeXl5RU1EUlJjdnRiU1JsUzVKNExUVWhWbXliKzF4MXp0bnVxRGVXM1hy?=
 =?utf-8?B?N1NyU2lLUjNiM1dGM05VdSt3MHdhNTM1d0xTVFpjREt6R3RrallRUzFBWHNk?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2388e8d-4bb1-4b96-d88e-08dd7cdf2efa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 12:06:56.3614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HrsNf/3VdfC8DnCG2D91BagIyFZVn1oMI+JVp46TExLN91pLL0s9bXblBlTTY2j+As29I31iehirsEsCcCzHDvPW7TZLNUnqlyfy/aXaQ9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7335
X-OriginatorOrg: intel.com

DQo+IE9uIFR1ZSwgMjAyNS0wNC0xNSBhdCAxNDo1MSArMDMwMCwgRWxlbmEgUmVzaGV0b3ZhIHdy
b3RlOg0KPiA+IFNHWCBhcmNoaXRlY3R1cmUgaW50cm9kdWNlZCBhIG5ldyBpbnN0cnVjdGlvbiBj
YWxsZWQgRVVQREFURVNWTg0KPiANCj4gImEgbmV3IEVOQ0xTIGxlYWYgZnVuY3Rpb24gRVVQREFU
RVNWTiI/DQoNClllcywgeW91IGFyZSByaWdodCwgYmV0dGVyIHdvcmRpbmcsIHdpbGwgZml4LiAN
Cg0KPiANCj4gPiB0byBJY2UgTGFrZS4gSXQgYWxsb3dzIHVwZGF0aW5nIHNlY3VyaXR5IFNWTiB2
ZXJzaW9uLCBnaXZlbiB0aGF0IEVQQw0KPiA+IGlzIGNvbXBsZXRlbHkgZW1wdHkuIFRoZSBsYXR0
ZXIgaXMgcmVxdWlyZWQgZm9yIHNlY3VyaXR5IHJlYXNvbnMNCj4gPiBpbiBvcmRlciB0byByZWFz
b24gdGhhdCBlbmNsYXZlIHNlY3VyaXR5IHBvc3R1cmUgaXMgYXMgc2VjdXJlIGFzIHRoZQ0KPiA+
IHNlY3VyaXR5IFNWTiB2ZXJzaW9uIG9mIHRoZSBUQ0IgdGhhdCBjcmVhdGVkIGl0Lg0KPiA+DQo+
ID4gQWRkaXRpb25hbGx5IGl0IGlzIGltcG9ydGFudCB0byBlbnN1cmUgdGhhdCB3aGlsZSBFTkNM
U1tFVVBEQVRFU1ZOXQ0KPiA+IHJ1bnMsIG5vIGNvbmN1cnJlbnQgcGFnZSBjcmVhdGlvbiBoYXBw
ZW5zIGluIEVQQywgYmVjYXVzZSBpdCBtaWdodA0KPiA+IHJlc3VsdCBpbiAjR1AgZGVsaXZlcmVk
IHRvIHRoZSBjcmVhdG9yLiBMZWdhY3kgU1cgbWlnaHQgbm90IGJlIHByZXBhcmVkDQo+ID4gdG8g
aGFuZGxlIHN1Y2ggdW5leHBlY3RlZCAjR1BzIGFuZCB0aGVyZWZvcmUgdGhpcyBwYXRjaCBpbnRy
b2R1Y2VzDQo+ID4gYSBsb2NraW5nIG1lY2hhbmlzbSB0byBlbnN1cmUgbm8gY29uY3VycmVudCBF
UEMgYWxsb2NhdGlvbnMgY2FuIGhhcHBlbi4NCj4gPg0KPiA+IEl0IGlzIGFsc28gZW5zdXJlZCB0
aGF0IEVOQ0xTW0VVUERBVEVTVk5dIGlzIG5vdCBjYWxsZWQgd2hlbiBydW5uaW5nDQo+ID4gaW4g
YSBWTSBzaW5jZSBpdCBkb2VzIG5vdCBoYXZlIGEgbWVhbmluZyBpbiB0aGlzIGNvbnRleHQgKG1p
Y3JvY29kZQ0KPiA+IHVwZGF0ZXMgYXBwbGljYXRpb24gaXMgbGltaXRlZCB0byB0aGUgaG9zdCBP
UykgYW5kIHdpbGwgY3JlYXRlDQo+ID4gdW5uZWNlc3NhcnkgbG9hZC4NCj4gPg0KPiA+IFRoaXMg
cGF0Y2ggaXMgYmFzZWQgb24gcHJldmlvdXMgc3VibWlzaW9uIGJ5IENhdGh5IFpoYW5nDQo+ID4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjIwNTIwMTAzOTA0LjEyMTYtMS1jYXRoeS56
aGFuZ0BpbnRlbC5jb20vDQo+IA0KPiBXaGVuIEphcmtrbyBzdWdnZXN0ZWQgdG8gdXNlICJMaW5r
IiBoZXJlOg0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9aOTgzWmFUYVdOcUZV
cFlTQGtlcm5lbC5vcmcvDQo+IA0KPiBJIHRoaW5rIGhlIG1lYW50IHNvbWV0aGluZyBsaWtlIGJl
bG93Og0KPiANCj4gVGhpcyBwYXRjaCBpcyBiYXNlZCBvbiAuLi4gWzFdDQo+IA0KPiBMaW5rOiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMjA1MjAxMDM5MDQuMTIxNi0xLQ0KPiBjYXRo
eS56aGFuZ0BpbnRlbC5jb20vDQo+IFsxXQ0KDQpPaCwgSSBzZWUsIEkgZGlkbuKAmXQgdW5kZXJz
dGFuZCB0aGlzLiBDYW4gZml4IGluIHRoZSBuZXh0IHZlcnNpb24uIA0KDQo+IA0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogRWxlbmEgUmVzaGV0b3ZhIDxlbGVuYS5yZXNoZXRvdmFAaW50ZWwuY29t
Pg0KPiA+IC0tLQ0KPiA+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9zZ3guaCAgICAgIHwgNDEgKysr
KysrKysrKystLS0tLS0NCj4gPiAgYXJjaC94ODYva2VybmVsL2NwdS9zZ3gvZW5jbHMuaCB8ICA2
ICsrKw0KPiA+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9tYWluLmMgIHwgODINCj4gKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4gIGFyY2gveDg2L2tlcm5lbC9jcHUvc2d4
L3NneC5oICAgfCAgMSArDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMTE0IGluc2VydGlvbnMoKyks
IDE2IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUv
YXNtL3NneC5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vc2d4LmgNCj4gPiBpbmRleCA2YTAwNjk3
NjE1MDguLjVjYWY1YzMxZWJjNiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9zZ3guaA0KPiA+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NneC5oDQo+ID4gQEAgLTI2
LDIzICsyNiwyNiBAQA0KPiA+ICAjZGVmaW5lIFNHWF9DUFVJRF9FUENfU0VDVElPTgkweDENCj4g
PiAgLyogVGhlIGJpdG1hc2sgZm9yIHRoZSBFUEMgc2VjdGlvbiB0eXBlLiAqLw0KPiA+ICAjZGVm
aW5lIFNHWF9DUFVJRF9FUENfTUFTSwlHRU5NQVNLKDMsIDApDQo+ID4gKy8qIEVVUERBVEVTVk4g
cHJlc2VuY2UgaW5kaWNhdGlvbiAqLw0KPiA+ICsjZGVmaW5lIFNHWF9DUFVJRF9FVVBEQVRFU1ZO
CUJJVCgxMCkNCj4gDQo+IEkgYW0gbm90IHN1cmUgd2hldGhlciB0aGlzIHNob3VsZCBiZSBhIG5l
dyBYODZfRkVBVFVSRSBiaXQsIGp1c3QgbGlrZSBvdGhlcg0KPiBTR1gNCj4gYml0czoNCj4gDQo+
ICAgWDg2X0ZFQVRVUkVfU0dYMQ0KPiAgIFg4Nl9GRUFUVVJFX1NHWDINCj4gICBYODZfRkVBVFVS
RV9TR1hfRURFQ0NTU0ENCj4gDQo+IC4uIHJlcG9ydGVkIGluIENQVUlELjB4MTIuMHgwOkVBWC4N
Cj4gDQo+IEJ1dCB0aGlzIGlzIG5ldmVyIGdvaW5nIHRvIGJlIGV4cG9zZWQgdG8gVk1zLCBpLmUu
LCBLVk0gc2hvdWxkIG5ldmVyIG5lZWQgdG8NCj4gdXNlDQo+IGl0LCBzbyBwZXJoYXBzIGZpbmUg
dG8ganVzdCBwdXQgaXQgaGVyZS4NCg0KSSBhbSBmaW5lIGVpdGhlciB3YXkuIEkgY2FuIGNoYW5n
ZSB0aGlzIGlmIHBlb3BsZSBjb25zaWRlciBpdCBpcyBhIGJldHRlciBmaXQuIA0KDQo+IA0KPiBb
Li4uXQ0KPiANCj4gDQo+ID4NCj4gPiArLyogVGhpcyBsb2NrIGlzIGhlbGQgdG8gcHJldmVudCBu
ZXcgRVBDIHBhZ2VzIGZyb20gYmVpbmcgY3JlYXRlZA0KPiA+ICsgKiBkdXJpbmcgdGhlIGV4ZWN1
dGlvbiBvZiBFTkNMU1tFVVBEQVRFU1ZOXS4NCj4gPiArICovDQo+IA0KPiAvKg0KPiAgKiBUaGlz
IGxvY2sgLi4uDQo+ICAqIC4uLg0KPiAgKi8NCg0KVGhhbmsgeW91IGZvciBjYXRjaGluZyB0aGlz
ISBJIHRob3VnaHQgdGhhdCBJIGZpeGVkIGFsbCBjb21tZW50cyB0byB0aGlzDQpGb3JtYXQgYnV0
IG9idmlvdXMgSSBtaXNzZWQgdGhpcyBvbmUuIFNhZCB0aGF0IGNoZWNrcGF0Y2ggZG9lc27igJl0
DQpjb21wbGFpbiBvbiB0aGlzICgNCg0KPiANCj4gPiArc3RhdGljIERFRklORV9TUElOTE9DSyhz
Z3hfZXBjX2V1cGRhdGVzdm5fbG9jayk7DQo+ID4gKw0KPiA+ICBzdGF0aWMgYXRvbWljX2xvbmdf
dCBzZ3hfbnJfdXNlZF9wYWdlcyA9IEFUT01JQ19MT05HX0lOSVQoMCk7DQo+ID4gIHN0YXRpYyB1
bnNpZ25lZCBsb25nIHNneF9ucl90b3RhbF9wYWdlczsNCj4gPg0KPiA+IEBAIC00NDQsNiArNDQ5
LDcgQEAgc3RhdGljIHN0cnVjdCBzZ3hfZXBjX3BhZ2UNCj4gKl9fc2d4X2FsbG9jX2VwY19wYWdl
X2Zyb21fbm9kZShpbnQgbmlkKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3Qgc2d4X251bWFfbm9kZSAq
bm9kZSA9ICZzZ3hfbnVtYV9ub2Rlc1tuaWRdOw0KPiA+ICAJc3RydWN0IHNneF9lcGNfcGFnZSAq
cGFnZSA9IE5VTEw7DQo+ID4gKwlib29sIHJldDsNCj4gPg0KPiA+ICAJc3Bpbl9sb2NrKCZub2Rl
LT5sb2NrKTsNCj4gPg0KPiA+IEBAIC00NTIsMTIgKzQ1OCwzMyBAQCBzdGF0aWMgc3RydWN0IHNn
eF9lcGNfcGFnZQ0KPiAqX19zZ3hfYWxsb2NfZXBjX3BhZ2VfZnJvbV9ub2RlKGludCBuaWQpDQo+
ID4gIAkJcmV0dXJuIE5VTEw7DQo+ID4gIAl9DQo+ID4NCj4gPiArCWlmICghYXRvbWljX2xvbmdf
aW5jX25vdF96ZXJvKCZzZ3hfbnJfdXNlZF9wYWdlcykpIHsNCj4gPiArCQlzcGluX2xvY2soJnNn
eF9lcGNfZXVwZGF0ZXN2bl9sb2NrKTsNCj4gPiArCQkvKg0KPiA+ICsJCSAqIE9ubHkgY2FsbCBz
Z3hfdXBkYXRlc3ZuKCkgb25jZSB0aGUgZmlyc3QgZW5jbGF2ZSdzDQo+ID4gKwkJICogcGFnZSBp
cyBhbGxvY2F0ZWQgZnJvbSBFUEMNCj4gPiArCQkgKi8NCj4gDQo+IFRoZSBWTXMgY2FuIHByZS1w
b3B1bGF0ZSBFUEMgdy9vIGhhdmluZyBhbnkgZW5jbGF2ZSBiZWluZyBjcmVhdGVkIGluc2lkZS4N
Cj4gSG93DQo+IGFib3V0IGp1c3Q6DQo+IA0KPiAJCS8qDQo+IAkJICogTWFrZSBzdXJlIFNWTiBp
cyB1cC10by1kYXRlIGJlZm9yZSBhbnkgRVBDIHBhZ2UgaXMNCj4gCQkgKiBhbGxvY2F0ZWQgZm9y
IGFueSBlbmNsYXZlLg0KPiAJCSAqLw0KPiANCg0KUmlnaHQsIGFncmVlIHdpdGggdGhpcyB3b3Jk
aW5nIGNoYW5nZSwgZ29vZCBwb2ludCENCg0KPiA+ICsJCWlmIChhdG9taWNfbG9uZ19yZWFkKCZz
Z3hfbnJfdXNlZF9wYWdlcykgPT0gMCkgew0KPiA+ICsJCQlyZXQgPSBzZ3hfdXBkYXRlc3ZuKCk7
DQo+ID4gKwkJCWlmICghcmV0KSB7DQo+ID4gKwkJCQkvKg0KPiA+ICsJCQkJICogc2d4X3VwZGF0
ZXN2bigpIHJldHVybmVkIHVua25vd24gZXJyb3IsDQo+IHNtdGgNCj4gPiArCQkJCSAqIG11c3Qg
YmUgYnJva2VuLCBkbyBub3QgYWxsb2NhdGUgYSBwYWdlDQo+IGZyb20gRVBDDQo+ID4gKwkJCQkg
Ki8NCj4gDQo+IFN0cmljdGx5IHNwZWFraW5nLCBzZ3hfdXBkYXRlc3ZuKCkgcmV0dXJucyB0cnVl
IG9yIGZhbHNlLCBidXQgbm90ICJ1bmtub3duDQo+IGVycm9yIi4NCg0KWWVzLCB3aWxsIGZpeCB0
aGUgd29yZGluZy4gDQoNCj4gDQo+IFJlYWRpbmcgYmVsb3csIGl0IGNvdWxkIGFsc28gZmFpbCBk
dWUgdG8gcnVubmluZyBvdXQgb2YgZW50cm9weSwgd2hpY2ggaXMgc3RpbGwNCj4gbGVnYWxseSBw
b3NzaWJsZSB0byBoYXBwZW4gSU1ITy4NCg0KQWN0dWFsbHksIG5vIGluIHRoaXMgY2FzZSwgd2Ug
b25seSByZXR1cm4gZmFsc2UgZnJvbSBzZ3hfdXBkYXRlc3ZuIGluIGNhc2UgdW5rbm93bg0KZXJy
b3IgaGFwcGVucyBhcyBhZ3JlZWQgcHJldmlvdXNseS4gSW4gY2FzZSB3ZSBydW4gb3V0IG9mIGVu
dHJvcHkgaXQgc2hvdWxkIGJlIHNhZmUNCnRvIHJldHJ5IGxhdGVyIGFuZCB3ZSBkb250IHByZXZl
bnQgcGVyIGN1cnJlbnQgY29kZSBFUEMgcGFnZSBhbGxvY2F0aW9uLiANCg0KPiANCj4gTWF5YmUg
anVzdDoNCj4gCQkJCS8qDQo+IAkJCQkgKiBVcGRhdGluZyBTVk4gZmFpbGVkLiAgU0dYIG1pZ2h0
IGJlIGJyb2tlbiwNCj4gCQkJCSAqIG9yIHJ1bm5pbmcgb3V0IG9mIGVudHJvcHkgaGFwcGVuZWQu
ICBEbw0KPiBub3QNCj4gCQkJCSAqIGFsbG9jYXRlIEVQQyBwYWdlIHNpbmNlIGl0IGlzIG5vdCBz
YWZlIHRvDQo+IHVzZQ0KPiAJCQkJICogU0dYIGFueW1vcmUgaWYgaXQgd2FzIHRoZSBmb3JtZXIu
ICBJZiBpdCB3YXMNCj4gCQkJCSAqIGR1ZSB0byBydW5uaW5nIG91dCBvZiBlbnRyb3B5LCB0aGUg
ZnVydGhlcg0KPiAJCQkJICogY2FsbCBvZiBFUEMgYWxsb2NhdGlvbiB3aWxsIHRyeQ0KPiAJCQkJ
ICogc2d4X3VwZGF0ZXN2bigpIGFnYWluLg0KPiAJCQkJICovDQoNCkkgYWdyZWUgd2l0aCB0aGlz
IGV4Y2VwdCB0aGF0IHRoZSBjdXJyZW50IGNvZGUgZG9lc27igJl0IHByZXZlbnQgRVBDIGFsbG9j
YXRpb24gb24gYW55DQpvdGhlciBlcnJvciByZXR1cm4gdGhhbiB1bmtub3duIGVycm9yLiBUaGUg
cXVlc3Rpb24gaXMgd2hlbmV2ZXIgd2Ugd2FudCB0bw0KY2hhbmdlIHRoZSBiZWhhdmlvdXIgdG8g
cmVxdWlyZSBpdD8gDQoNCj4gDQo+ID4gKwkJCQlzcGluX3VubG9jaygmc2d4X2VwY19ldXBkYXRl
c3ZuX2xvY2spOw0KPiA+ICsJCQkJc3Bpbl91bmxvY2soJm5vZGUtPmxvY2spOw0KPiA+ICsJCQkJ
cmV0dXJuIE5VTEw7DQo+ID4gKwkJCX0NCj4gPiArCQl9DQo+ID4gKwkJYXRvbWljX2xvbmdfaW5j
KCZzZ3hfbnJfdXNlZF9wYWdlcyk7DQo+ID4gKwkJc3Bpbl91bmxvY2soJnNneF9lcGNfZXVwZGF0
ZXN2bl9sb2NrKTsNCj4gPiArCX0NCj4gPiArDQo+ID4gIAlwYWdlID0gbGlzdF9maXJzdF9lbnRy
eSgmbm9kZS0+ZnJlZV9wYWdlX2xpc3QsIHN0cnVjdCBzZ3hfZXBjX3BhZ2UsDQo+IGxpc3QpOw0K
PiA+ICAJbGlzdF9kZWxfaW5pdCgmcGFnZS0+bGlzdCk7DQo+ID4gIAlwYWdlLT5mbGFncyA9IDA7
DQo+ID4NCj4gPiAgCXNwaW5fdW5sb2NrKCZub2RlLT5sb2NrKTsNCj4gPiAtCWF0b21pY19sb25n
X2luYygmc2d4X25yX3VzZWRfcGFnZXMpOw0KPiA+DQo+ID4gIAlyZXR1cm4gcGFnZTsNCj4gPiAg
fQ0KPiA+IEBAIC05NzAsMyArOTk3LDU2IEBAIHN0YXRpYyBpbnQgX19pbml0IHNneF9pbml0KHZv
aWQpDQo+ID4gIH0NCj4gPg0KPiA+ICBkZXZpY2VfaW5pdGNhbGwoc2d4X2luaXQpOw0KPiA+ICsN
Cj4gPiArLyoqDQo+ID4gKyAqIHNneF91cGRhdGVzdm4oKSAtIElzc3VlIEVOQ0xTW0VVUERBVEVT
Vk5dDQo+ID4gKyAqIElmIEVQQyBpcyByZWFkeSwgdGhpcyBpbnN0cnVjdGlvbiB3aWxsIHVwZGF0
ZSBDUFVTVk4gdG8gdGhlIGN1cnJlbnRseQ0KPiANCj4gTm90IHN1cmUgaG93IHRvIGludGVycHJl
dCAiRVBDIGlzIHJlYWR5Ii4gIEFzc3VtZSBpdCBtZWFucyAiRVBDIGlzIGVtcHR5IiwgaW4NCj4g
d2hpY2ggY2FzZSBzaG91bGQgd2UganVzdCBzYXkgc28/DQoNClllcywgY29ycmVjdCwgaXQgbWVh
bnMgRVBDIGlzIGVtcHR5LCB3aWxsIGZpeC4gDQoNCj4gDQo+IEl0IGlzIGNvbnNpc3RlbnQgd2l0
aCB3aGF0IHNhaWQgaW4gdGhlIGNoYW5nZWxvZyBhbnl3YXkuDQo+IA0KPiA+ICsgKiBsb2FkZWQg
bWljcm9jb2RlIHVwZGF0ZSBTVk4gYW5kIGdlbmVyYXRlIG5ldyBjcnlwdG9ncmFwaGljIGFzc2V0
cy4NCj4gPiArICoNCj4gPiArICogUmV0dXJuOg0KPiA+ICsgKiBUcnVlOiBzdWNjZXNzIG9yIEVV
UERBVEVTVk4gY2FuIGJlIHNhZmVseSByZXRyaWVkIG5leHQgdGltZQ0KPiA+ICsgKiBGYWxzZTog
VW5leHBlY3RlZCBlcnJvciBvY2N1cnJlZA0KPiANCj4gSG1tLi4gSUlVQyBpdCBjb3VsZCBmYWls
IHdpdGggcnVubmluZyBvdXQgb2YgZW50cm9weSBidXQgdGhpcyBpcyBzdGlsbCBsZWdhbGx5DQo+
IHBvc3NpYmxlIHRvIGhhcHBlbi4gIEFuZCBpdCBpcyBzYWZlIHRvIHJldHJ5Lg0KDQpZZXMsIGlu
IHRoaXMgY2FzZSB3ZSBnZXQgYmFjayBTR1hfSU5TVUZGSUNJRU5UX0VOVFJPUFkgY3VycmVudGx5
IHdlDQpyZXR1cm4gInRydWUiIGhlcmUgYW5kIGRvIG5vdCBwcmV2ZW50IEVQQyBhbGxvY2F0aW9u
cyBvZiB0aGUgcGFnZSBpbiB0aGlzDQpjYXNlLCB3aGljaCBtZWFucyB3ZSB3aWxsIHN0YXJ0IHBv
cHVsYXRlIEVQQyBhbmQgY2FuIG5leHQgdGltZSByZXRyeSBvbmx5DQp3aGVuIEVQQyBpcyBlbXB0
eSBhZ2Fpbi4gDQoNCj4gDQo+ID4gKyAqLw0KPiA+ICtib29sIHNneF91cGRhdGVzdm4odm9pZCkN
Cj4gPiArew0KPiA+ICsJaW50IHJldHJ5ID0gMTA7DQo+IA0KPiAiMTAiIGlzIGEgYml0IG91dCBv
ZiBibHVlLg0KPiANCj4gV2UgY2FuIHVzZSBSRFJBTkRfUkVUUllfTE9PUFMgaW4gPGFzbS9hcmNo
cmFuZG9tLmg+IGluc3RlYWQ6DQo+IA0KPiAgICNkZWZpbmUgUkRSQU5EX1JFVFJZX0xPT1BTICAg
ICAgMTANCg0KSSBjYW4gY2hhbmdlIGl0IHRvIHRoaXMgdmFsdWUuIA0KDQo+IA0KPiA+ICsJaW50
IHJldDsNCj4gPiArDQo+ID4gKwlsb2NrZGVwX2Fzc2VydF9oZWxkKCZzZ3hfZXBjX2V1cGRhdGVz
dm5fbG9jayk7DQo+ID4gKw0KPiA+ICsJaWYgKCEoY3B1aWRfZWF4KFNHWF9DUFVJRCkgJiBTR1hf
Q1BVSURfRVVQREFURVNWTikpDQo+ID4gKwkJcmV0dXJuIHRydWU7DQo+ID4gKw0KPiA+ICsJLyoN
Cj4gPiArCSAqIERvIG5vdCBleGVjdXRlIEVOQ0xTW0VVUERBVEVTVk5dIGlmIHJ1bm5pbmcgaW4g
YSBWTSBzaW5jZQ0KPiA+ICsJICogbWljcm9jb2RlIHVwZGF0ZXMgYXJlIG9ubHkgbWVhbmluZ2Z1
bCB0byBiZSBhcHBsaWVkIG9uIHRoZSBob3N0Lg0KPiA+ICsJICovDQo+ID4gKwlpZiAoYm9vdF9j
cHVfaGFzKFg4Nl9GRUFUVVJFX0hZUEVSVklTT1IpKQ0KPiA+ICsJCXJldHVybiB0cnVlOw0KPiA+
ICsNCj4gPiArCWRvIHsNCj4gPiArCQlyZXQgPSBfX2V1cGRhdGVzdm4oKTsNCj4gPiArCQlpZiAo
cmV0ICE9IFNHWF9JTlNVRkZJQ0lFTlRfRU5UUk9QWSkNCj4gPiArCQkJYnJlYWs7DQo+ID4gKw0K
PiANCj4gVGhlIGJsYW5rIGxpbmUgaGVyZSBpcyBub3QgbmVlZGVkLg0KDQpXaWxsIGZpeA0KDQo+
IA0KPiA+ICsJfSB3aGlsZSAoLS1yZXRyeSk7DQo+ID4gKw0KPiA+ICsJc3dpdGNoIChyZXQpIHsN
Cj4gPiArCWNhc2UgMDoNCj4gPiArCQlwcl9pbmZvKCJFVVBEQVRFU1ZOOiBzdWNjZXNzXG4iKTsN
Cj4gPiArCQlicmVhazsNCj4gPiArCWNhc2UgU0dYX0VQQ19OT1RfUkVBRFk6DQo+ID4gKwljYXNl
IFNHWF9JTlNVRkZJQ0lFTlRfRU5UUk9QWToNCj4gPiArCWNhc2UgU0dYX0VQQ19QQUdFX0NPTkZM
SUNUOg0KPiA+ICsJCUVOQ0xTX1dBUk4ocmV0LCAiRVVQREFURVNWTiIpOw0KPiA+ICsJCWJyZWFr
Ow0KPiANCj4gSSBkb24ndCB0aGluayB3ZSBzaG91bGQgdXNlIEVOQ0xTX1dBUk4oKSBmb3IgU0dY
X0lOU1VGRklDSUVOVF9FTlRST1BZLA0KPiBzaW5jZQ0KPiBJSVVDIGl0IGlzIHN0aWxsIGxlZ2Fs
bHkgcG9zc2libGUgdG8gaGFwcGVuIGFmdGVyIHRoZSBhYm92ZSByZXRyeS4NCj4gDQo+IEFsc28s
IGl0IGRvZXNuJ3Qgc2VlbSBTR1hfRVBDX05PVF9SRUFEWSBhbmQgU0dYX0VQQ19QQUdFX0NPTkZM
SUNUDQo+IGFyZSBuZWVkZWQNCj4gc2luY2UgSUlVQyB0aGUgb25seSBwb3NzaWJsZSBlcnJvciBp
cyBvdXQgb2YgZW50cm9weS4NCg0KV2VsbCwgaW4gY2FzZSB3ZSBoYXZlIGEga2VybmVsIGJ1Zywg
YW5kIHdlIHRoaW5rIEVQQyBpcyBlbXB0eSBhbmQgaXQgaXMgc2FmZQ0KdG8gZXhlY3V0ZSBFVVBE
QVRFU1ZOLCB3aGlsZSBpdCBpcyBub3QgdGhlIGNhc2UsIHdlIGNhbiBzdGlsbCBnZXQgYmFjayB0
aGUgDQpTR1hfRVBDX05PVF9SRUFEWSBhbmQgU0dYX0VQQ19QQUdFX0NPTkZMSUNUIGZyb20gSFcs
IHJpZ2h0PyANCldoaWNoIG1lYW5zIHdlIHByb2JhYmx5IHNob3VsZCB3YXJuIGFib3V0IHN1Y2gg
YnVnZ3kgY2FzZXMuIA0KQW5kIG1heWJlIHdlIHNob3VsZCBhbHNvIHByZXZlbnQgcGFnZSBhbGxv
Y2F0aW9uIGZyb20gRVBDIGluIHRoaXMgY2FzZSBhbHNvDQpzaW1pbGFybHkgYXMgZm9yIHVua25v
d24gZXJyb3I/IA0KDQo+IA0KPiA+ICsJY2FzZSBTR1hfTk9fVVBEQVRFOg0KPiA+ICsJCWJyZWFr
Ow0KPiA+ICsJZGVmYXVsdDoNCj4gPiArCQlFTkNMU19XQVJOKHJldCwgIkVVUERBVEVTVk4iKTsN
Cj4gPiArCQlyZXR1cm4gZmFsc2U7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHRydWU7
DQo+ID4gKw0KPiANCj4gUGxlYXNlIHJlbW92ZSB0aGlzIGJsYW5rIGxpbmUuDQoNClN1cmUsIHRo
YW5rcyBmb3IgY2F0Y2hpbmchDQoNCj4gDQo+ID4gK30NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94
ODYva2VybmVsL2NwdS9zZ3gvc2d4LmggYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9zZ3guaA0K
PiA+IGluZGV4IGQyZGFkMjEyNTlhOC4uZDdkNjMxYzk3M2QwIDEwMDY0NA0KPiA+IC0tLSBhL2Fy
Y2gveDg2L2tlcm5lbC9jcHUvc2d4L3NneC5oDQo+ID4gKysrIGIvYXJjaC94ODYva2VybmVsL2Nw
dS9zZ3gvc2d4LmgNCj4gPiBAQCAtMTAzLDUgKzEwMyw2IEBAIHN0YXRpYyBpbmxpbmUgaW50IF9f
aW5pdCBzZ3hfdmVwY19pbml0KHZvaWQpDQo+ID4gICNlbmRpZg0KPiA+DQo+ID4gIHZvaWQgc2d4
X3VwZGF0ZV9sZXB1YmtleWhhc2godTY0ICpsZXB1YmtleWhhc2gpOw0KPiA+ICtib29sIHNneF91
cGRhdGVzdm4odm9pZCk7DQo+IA0KPiBTZWVtcyBzZ3hfdXBkYXRlc3ZuKCkgaXMgb25seSBjYWxs
ZWQgYnkgX19zZ3hfYWxsb2NfZXBjX3BhZ2VfZnJvbV9ub2RlKCkuDQo+IENhbg0KPiBpdCBiZSBt
YWRlIHN0YXRpYz8NCg0KWWVzLCB3aWxsIGRvLiANCg0K

