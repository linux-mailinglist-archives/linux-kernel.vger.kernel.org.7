Return-Path: <linux-kernel+bounces-704956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A75AEA3B2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 18:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301D94E22CB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 16:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2346E21421A;
	Thu, 26 Jun 2025 16:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R0wew87V"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2762F1FF9;
	Thu, 26 Jun 2025 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750956448; cv=fail; b=aNGcnGFaPBVs+6wDIdlai3aNkZPPQofN2JEnRbfjvn0O4eS6tveDM3KWf7+vsV/eZ3hXsBgxkB0Lsb1qVy2ZAjiGOrYARx+2jT+t9piJiN2fyiDzbA7svdfm/jrW/oinJdafrQanNyjfzNU7whpHsyGcTUp1D4Dh3eyPOK6jbUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750956448; c=relaxed/simple;
	bh=Jxn7WUVgNoVY5phdgxZKDLhlYQFUSzRJJKaR3DmOkAs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ae1qXfqi2RMdDCDz7WZeHybg77dhzYbIFv8pvC0pnQnw1MIXBFOZlTjFauQgigZzqXcjZb4hAL5E/4VvTLYF2Ut/KSEaYmQIJsbMDzqfh6l2FZEHcXEVNbPbzB7SVYGFD/MFmPMxNbXByQaOMuWC0VYoePAvlCoinFhEXAfJ6TY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R0wew87V; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750956445; x=1782492445;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Jxn7WUVgNoVY5phdgxZKDLhlYQFUSzRJJKaR3DmOkAs=;
  b=R0wew87VZ5S6ipr1pusbpoJtpBvxwzOt6a+RTSjbQJtm61O177GdCujL
   g3JHOE6TiyW7RXgI+PIEGAs46oEFeD0zuRlKokpNMfbHR81p4Umqt/RjS
   78BtfkYhx4crp69z1H9peE8oM82ELkSzqMzgu8dVTZZNYssxQgpQnqiex
   T9BArDEkhAMIGqEvyFMLhMzmXmxE55toZAupafWCqzFqibsjBntP44O85
   Av2IqGDJgU8DQZnwxum+kBdHGRJFTLbnSBiLpzJjFg8do16S7AKNLDaCf
   c2xoTHi4xUzeOEDybdScSgrvuxkCtSEQTOEB6nRET/r8YR/aYYwUiytiy
   A==;
X-CSE-ConnectionGUID: x0a+IF9YTPSvnuhzk1gFaw==
X-CSE-MsgGUID: yIlvcn5zS56aRJ2MWThrjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="63859919"
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="63859919"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 09:47:25 -0700
X-CSE-ConnectionGUID: gnNr3/FRRRiiijMdHRc/cw==
X-CSE-MsgGUID: Ksx0LXQARx2Q6ypXk2FXOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="158063883"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 09:47:25 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 09:47:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 26 Jun 2025 09:47:24 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.55)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 09:47:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DD3PQh4/xRBPoc1NqKK2VlP9eqK3Gf0hCU0N/Zufsl/85Iwv4CGDUCOYIn62MSfatVpyXcOnZ6XLmjHnjJv+JCcPihsym0hDzOWKIGaMEGAbcE6db1blDZG/GUTTAZS/qauTmrBLKTj75/J2i11V444zz0ODRA7PP2C/LxG7i2are7r2jJu2DuuKmXE0Bt4VbvN0bt6VBivff+NGT3V8rMmednYKn5wQK470kRwaRhHPwy/1OCXfUYiX1g7yBYfPHaxz8es2r0QWctKzTv2dLGgj8+mxP5wQn4U+SormfAoU3oKytZQ6/nms8gP2JxCtTA0xCxE/6iAO5cRX6Xyq0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jxn7WUVgNoVY5phdgxZKDLhlYQFUSzRJJKaR3DmOkAs=;
 b=dPbPjALUzO2CZHWMCSavQwAVG5W8PF4wDzTBuTmYS5NH+Wv1U/pCUm37Q2W2Fpgt7GHATwYO1o1ohTnjPToqUpMe/OksDUNpimJQkJTuHVjaztGWEdMP1RSOKIM6EYkwwq2bNVuor8WKxzwSZGuT9smBVNe7qQUWUuw1mLulw6OBMfMbyTTK16NfchnZM/ldSSJUOqQapUkWWMxFYdlofwxSexTLcXll2EvDDfSavCrCIGG0t2GpelSGJFtY49CdpiUxd7TbZuVTY96KBRbRPof9kCLsy3DiFM8AoMvVJ13+cJG12y3a/ZZJ99ZYTim4vw5bO7xboXSIWmdM4QuOyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by BL1PR11MB5255.namprd11.prod.outlook.com (2603:10b6:208:31a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Thu, 26 Jun
 2025 16:47:19 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%3]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 16:47:18 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org"
	<acme@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"irogers@google.com" <irogers@google.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] perf top: populate PMU capabilities data in
 perf_env
Thread-Topic: [PATCH v4 2/2] perf top: populate PMU capabilities data in
 perf_env
Thread-Index: AQHb27iBi24xubkwT0KCSvkAnlaB+rQVvIKA
Date: Thu, 26 Jun 2025 16:47:18 +0000
Message-ID: <6680ed82adc3a2528c7587138d90dcca0d3558f3.camel@intel.com>
References: <20250612163659.1357950-1-thomas.falcon@intel.com>
	 <20250612163659.1357950-2-thomas.falcon@intel.com>
In-Reply-To: <20250612163659.1357950-2-thomas.falcon@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|BL1PR11MB5255:EE_
x-ms-office365-filtering-correlation-id: bc8a65fd-5f93-4ff3-659a-08ddb4d11d29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eWQ2ZVN4NlE5RTlIbWtZbCtpQmVCTHdtV29KeG8xd04vSHdzbzR0bWVQeFVp?=
 =?utf-8?B?dEZUMGU1NkxOZXFIUnJRbEJmZ05uY1R1MElGTzgxc0IxNzZTY0FUUGhFcTlj?=
 =?utf-8?B?eFFKelNRR3JBeFVzalJTWGlkbVJ0NE9KM3JMV2loSzRaa3FQUlJKNldkakNO?=
 =?utf-8?B?KzIySCtQSG5QZXowK0tZQzJpbGt1b0dGODgrU1R6SzVSaHlIMHp6RkFOcng4?=
 =?utf-8?B?TGZEVXhsQnhyOWZ3Mzd4SDJVaSs2Qktrd2F3b2xPL0p0dWJBNUhPOWtjc09q?=
 =?utf-8?B?d21zd0dad2xLNlYvaXYxSlA1MnUvM0ZFQ0tLOWJZcy9lOEcrTEZSa2hLWi9u?=
 =?utf-8?B?M2pVUUZ1RjlpaXZ2WTJIbEYzazNxSUNIUTl5aldhRXFzQTB6c1JBY0thMTg4?=
 =?utf-8?B?Q0tDTE5TRlpyQTZ1SWNYRjdSR1NqazBZYytaek84WDZ3TGo1QjNuSU5DQThU?=
 =?utf-8?B?SFRWd2lJT0Ezc0tWcGVWZGdzYWZSMGVlUW5uNDkrcnhZWXNsZ3VIUjB0M3hp?=
 =?utf-8?B?SnpPbldGQytqSXJFdUxucjBRVTFLeE12NkVpUmJvSjhWWm1TcWdlZkpnY2Zl?=
 =?utf-8?B?UEE3M21Pa24wdmtzRjZTNm42S3FNdTZvTjF4R2FHcFVXVTZwTXpmQXV4N1Ri?=
 =?utf-8?B?Y1JEYUU2ZjFwQkx6MUhLTVdoWlRaanpzbEEzWmJWblR1SDR0bUhmUUxqMlh1?=
 =?utf-8?B?ZDRGcUpIZG4wTXA3bkRDLzlpUW5lU0Y5QTd0N09mRHhwUXB1V1owSFBxQkEv?=
 =?utf-8?B?R2VHMEJOUld2dVVxMnhnTm84WTE1eGprSVkyU2lPMHR5UkdHb0xUdVFVaW8x?=
 =?utf-8?B?QlQzSGc3ME52ZE44VWY2NEFHWnZ6QUI4eERTS2REMWt3dUVYU01rWDVNR01s?=
 =?utf-8?B?WUxRMzFKSUdMN3N3WmtpaXVUckJJVis4SEVJeFBPbXFJaE1FVUVibW5DVXlC?=
 =?utf-8?B?cXNwWFdITGxDaU5HeGpxSXp4NVRQc3V0VW1LSmVHclNZY282T1JUcmhMcDVj?=
 =?utf-8?B?ZWczRHJXdXF6QU1aaGYyaGZOMUlyUTJmVTFrWmhOazlPTzdNaDhPOHg5bkFH?=
 =?utf-8?B?TWJ0VnZMcDhYZ2UrNWVxakJQNDVMQXlSRms2TkNCVVFnaXkwSU41WEhxYkx0?=
 =?utf-8?B?LzZMRGVGSnVqWXIxYUxxakV4bVY5MUpMa0RuUUZTNnV1eTBGVU1FdzNqMVFI?=
 =?utf-8?B?Zk5qSS9DcHFHRjA3Z1RzRVQ0aFNpVXFQSDR3OUFjSU9PMkdRMnhkUW1kTzRa?=
 =?utf-8?B?NnJWVzlCNGZQY2Z5T05hc0Q5N01qNHNYdUxaQSt5R08wc3JEQjAyaTRMbUov?=
 =?utf-8?B?TEw2ODVQNlBSSStyeEVOYlZ2amtZbmNqbnFBTXAzRnhaaHlXaFNpbXRieGNL?=
 =?utf-8?B?S3ZpUFVmWnk3SEkzUm85eUhpSi9SNUU3VHdVTXRNWGM3RjF6dHZFa1p3UWFn?=
 =?utf-8?B?ZFNvdEtDSE02RjgxaXBudkRzSFN3V2l0MHk1MzhGcU9XdlZENnpHWnEvVito?=
 =?utf-8?B?SHNCTGNVVUFlSkRWZkhkY0ZuNFdkajNwS1JraUlmQ1NYM1RHcTVyWjBXYjdj?=
 =?utf-8?B?RXJCOXJBR1ozWURIS1Jsd0hLSGVQZlA0bGgwa1djUGU3MTZwQVRhKzc2M25z?=
 =?utf-8?B?QUtrOXVXZnFhSzQ3YXpZazQ3RnluOGphb1crUGRVKzZrc3JYM0lmTXVFS21G?=
 =?utf-8?B?Y2FYdXMzeC9LMUNLaWVEc2FSRGdqL25LeG4rTmlCZEpQMEdmSzlhSE9BdnhU?=
 =?utf-8?B?UVlCSENreXVRWmJvSDhLOG05Z2JjeUkyYUhPeVUzNVFvZ2xjU2UzS2k3V2tD?=
 =?utf-8?B?V3JLa1BIRWN3eUhNUStwNktCejJVenR4b0JOeVdSNDBuMFRiVHBneStQUnJq?=
 =?utf-8?B?ME5QRVdmOElsZk1NZElCTUgxQ1lRWWk3SWtvTVRLYmV2NmU4K1JLR2YyNEc0?=
 =?utf-8?B?VDBJOU1xeUR2NVdCZ0wrZmM1WUVwbUw5ajI4dUtYUDNWT21KRFB4LytndmFQ?=
 =?utf-8?B?OTUyL3RPaHZ6QkpOajgzcHBGenRwN21hN3Z6UUNlM1BEUTBDVUVtUHh3VjJq?=
 =?utf-8?Q?tLlzRR?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WndHeWFrd3o4M3AvTERka0Y1bVRuV0IxSTBMcGZVWkdGR3dWaHFtQVlVNy9R?=
 =?utf-8?B?VUpwK3BRVHc2K1FuVWxXVElpdlNGKzN1YmlmOGhLeUNSWWw1WUtUc0NKUzdz?=
 =?utf-8?B?MmM5a1NrUWhUTmhrdXRPK2FuejZoaGRERTI5Mnc1c0hxOGErVUFLT0NrL3lY?=
 =?utf-8?B?NndkWExXUVFTWVFDU1phQXRmbE9sZGE5MFFEaDhmSzdwQmQvRE5LbWxvME5L?=
 =?utf-8?B?NzUvUlVFcDhDOG5vUzVnQUs5NWtFbzM3ZjkzWXBEa05BSzF5bEFOLzdkMlly?=
 =?utf-8?B?RExndHFrOWxBd0o2QTRKc1c2elZSanVueVdYa3hrK2M4MXpCMUs0V1FVM1kz?=
 =?utf-8?B?MG1BeE9RWEtQZitlK2NLM0ZTd3pUYUdrd1FCa3R0Z0R2bTR0TGtsWFcyWElz?=
 =?utf-8?B?R2N2UVk3N29wdHFQU0hyYjlPcDY2VzFGazBrUERyWGVkWi9rK28ybkdoZnYv?=
 =?utf-8?B?ZDhXN0tkOVFaZExSbWVkbnhQMFV1bFZYUHhqNXNnZjRnYWxseE53ZEJwMjVT?=
 =?utf-8?B?N3huZlBaUW5WNCtxODVPdHo4UFVrOVRMd3RuZldtMUxlYkRFRW5LL0d4a3VP?=
 =?utf-8?B?L3J4YmsrRGlnRytpbzVhRjJjMy9YNTUxKzcwVGRObWtSamxnTS9ZZlRZNkZJ?=
 =?utf-8?B?eHQ2SDhpSnNJemw0WG8zaGsxOVZqWDJpV0FQLzNsTXpOTXpzd0grVldmUFZH?=
 =?utf-8?B?K1B1SlBDdTB4MDV4UnhjamJwNm1kalFlNjZ2bVVXR3BZWTR4Rm1GcTFkYnY5?=
 =?utf-8?B?SnZHQmgrQzhtM2NkcWdIZXJFbmRVUGpwU2kyNVdhOEZJYUhDK2s5SUVwWTNV?=
 =?utf-8?B?N1hmZjlORlRqKzFJVlc2Z0Nna3RqcVJPY2hmZ3F3OXVzYktmNk5uK1h3bENW?=
 =?utf-8?B?eG5MUTRXQzBueDJVcmtRYmJhL3Uyc2dMYWQzODF4VHRlcVJRNjBDV2VRVSta?=
 =?utf-8?B?NlZLdWhIV0lMWkZieXZOSWluN05uRDlGZkxXVjF1NFVlendUQWxSUWF4RHV1?=
 =?utf-8?B?OFZrWUdlUldnR1dMenVHcWRFcmNHeFp5SDBSUzU2L1ZCT0l2SUVya3Jvdkgw?=
 =?utf-8?B?aGZXTXFsQlYyRTdtaWtrUytUNEtWaWtLTkc3UC9ESENSYWVhR0JsRXVkVlh4?=
 =?utf-8?B?N3NPOXE3OXlhb3BtL2NEdW1qWXR4UzhPNEVOd1JDdVcvT2xuc25OK25yUVBy?=
 =?utf-8?B?SGM4SE5nYUt4WXV2aFNDUmxzWFVHd05rUHh0U0tLRUtOWk9TWk13VUNHTW0r?=
 =?utf-8?B?eVVoTU1BSnYzTkJ2aDhBeXA3K2QzcG13ZXJqMjArak1VZ1d2ZnZOZlkyNW15?=
 =?utf-8?B?N2huUlpGTnFmckhGd0NjWEtzeGIyd01RTTZpZk5oUFY0Yiszdlh4YjU5TlVt?=
 =?utf-8?B?NFRhaXVHNXVWa1REUnAzR1hHUFpsRjJENzFzb1JGU05sMWtYK0pnNGtQRzNv?=
 =?utf-8?B?SDJ6WWEwTldZYnNsRFJsMXFpYVBBQUVrOWpjVVN1Z0krK01zNFZLeTd2S2Ry?=
 =?utf-8?B?U1QyOTM0aXlTM00vcU5YdHVOL2txcXJMOFJOWGt2MHRXUzVZelk5QUdtT3l4?=
 =?utf-8?B?QVBzbHd1N0RDRHhEUFowdWtCb2lNVG9rMjlzamkxa1FZYjdUUnI5aWtqVmFq?=
 =?utf-8?B?Q0NhcHFTZ3luWUQzOVJFUG4xU3NKVUtGNWQrSGprcTFOMlFKZjAyeTRoc0ZF?=
 =?utf-8?B?SVF0ZGRWU0FPRWZUejBhNDExU3ZJWVdJRjhKT3g2aU1JRTk4ZHZVcU95QTRj?=
 =?utf-8?B?Wmd4bEpPL2dvWWNnR2JNRktSdUw2a1JIbURSeG00b1N0T2oySGx3Nks2Umtm?=
 =?utf-8?B?dTNOZWtQdWlydXhYaUNGaWdFUTJaNG9oVlJYSFdTUmRoZXJzbFgvYWtTUDYr?=
 =?utf-8?B?M1V6WWRtSWxYS2o4VE1sUnhGWUtSeEk3M05FME5lODF1WnNHVU82VFQ5bHRh?=
 =?utf-8?B?bTRxT1BlRmNlUzcra0wyWnd6bHBxODRYajl6bitJQ3lNMk5QcHg5OTljVWpY?=
 =?utf-8?B?c3RxQ1lIOFVmdUlyd0Y5VUhzVVIwK1I4bzdaaG5CTGV4NmJQQUV5RUpwS04r?=
 =?utf-8?B?dUJqUnFhSmFMZCtCeHlZVWh0OTRab2hBeFhaWHUrb0VmRVdKcDd6Yi94UWUx?=
 =?utf-8?B?QTh3b2FRQmlZM1IwaUNydDBadSs4aFJLMXBxL1NQTUpqaDNYQmVGOFR2cFlZ?=
 =?utf-8?B?VVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3691A83C040A5D46B1DE2EA6C3243076@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8a65fd-5f93-4ff3-659a-08ddb4d11d29
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 16:47:18.6310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7t5tpUxkYMCsABV7EGvzbMlxIaoZbCALZTYdXEE4mDqw1frvVqOzjP4grZjtWPkldDMmJWu0OWw7fLspnhtqmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5255
X-OriginatorOrg: intel.com

SGksIGlzIHRoZXJlIGFueXRoaW5nIHN0aWxsIG5lZWRlZCBmcm9tIG1lIGJlZm9yZSB0aGlzIGNh
biBiZSBhY2NlcHRlZD8NCg0KVGhhbmtzLA0KVG9tDQoNCg0KT24gVGh1LCAyMDI1LTA2LTEyIGF0
IDExOjM2IC0wNTAwLCBUaG9tYXMgRmFsY29uIHdyb3RlOg0KPiBDYWxsaW5nIHBlcmYgdG9wIHdp
dGggYnJhbmNoIGZpbHRlcnMgZW5hYmxlZCBvbiBJbnRlbCBDUFUncw0KPiB3aXRoIGJyYW5jaCBj
b3VudGVycyBsb2dnaW5nIChBLksuQSBMQlIgZXZlbnQgbG9nZ2luZyBbMV0pIHN1cHBvcnQNCj4g
cmVzdWx0cyBpbiBhIHNlZ2ZhdWx0Lg0KPiANCj4gJCBwZXJmIHRvcCAgLWUgJ3tjcHVfY29yZS9j
cHUtY3ljbGVzLyxjcHVfY29yZS9ldmVudD0weGM2LHVtYXNrPTB4Myxmcm9udGVuZD0weDExLG5h
bWU9ZnJvbnRlbmRfcmV0aXJlZF9kc2JfbWlzcy99JyAtaiBhbnksY291bnRlcg0KPiAuLi4NCj4g
VGhyZWFkIDI3ICJwZXJmIiByZWNlaXZlZCBzaWduYWwgU0lHU0VHViwgU2VnbWVudGF0aW9uIGZh
dWx0Lg0KPiBbU3dpdGNoaW5nIHRvIFRocmVhZCAweDdmZmZhZmZmNzZjMCAoTFdQIDk0OTAwMyld
DQo+IHBlcmZfZW52X19maW5kX2JyX2NudHJfaW5mbyAoZW52PTB4ZjY2ZGMwIDxwZXJmX2Vudj4s
IG5yPTB4MCwgd2lkdGg9MHg3ZmZmYWZmZjYyYzApIGF0IHV0aWwvZW52LmM6NjUzDQo+IDY1MwkJ
CSp3aWR0aCA9IGVudi0+Y3B1X3BtdV9jYXBzID8gZW52LT5icl9jbnRyX3dpZHRoIDoNCj4gKGdk
YikgYnQNCj4gICMwICBwZXJmX2Vudl9fZmluZF9icl9jbnRyX2luZm8gKGVudj0weGY2NmRjMCA8
cGVyZl9lbnY+LCBucj0weDAsIHdpZHRoPTB4N2ZmZmFmZmY2MmMwKSBhdCB1dGlsL2Vudi5jOjY1
Mw0KPiAgIzEgIDB4MDAwMDAwMDAwMDViMTU5OSBpbiBzeW1ib2xfX2FjY291bnRfYnJfY250ciAo
YnJhbmNoPTB4N2ZmZmNjM2RiNTgwLCBldnNlbD0weGZlYTJkMCwgb2Zmc2V0PTEyLCBicl9jbnRy
PTgpIGF0IHV0aWwvYW5ub3RhdGUuYzozNDUNCj4gICMyICAweDAwMDAwMDAwMDA1YjE3ZmIgaW4g
c3ltYm9sX19hY2NvdW50X2N5Y2xlcyAoYWRkcj01NjU4MTcyLCBzdGFydD01NjU4MTYwLCBzeW09
MHg3ZmZmY2MwZWU0MjAsIGN5Y2xlcz01MzksIGV2c2VsPTB4ZmVhMmQwLCBicl9jbnRyPTgpIGF0
IHV0aWwvYW5ub3RhdGUuYzozODkNCj4gICMzICAweDAwMDAwMDAwMDA1YjE5NzYgaW4gYWRkcl9t
YXBfc3ltYm9sX19hY2NvdW50X2N5Y2xlcyAoYW1zPTB4N2ZmZmNkN2IwMWQwLCBzdGFydD0weDdm
ZmZjZDdiMDJiMCwgY3ljbGVzPTUzOSwgZXZzZWw9MHhmZWEyZDAsIGJyX2NudHI9OCkgYXQgdXRp
bC9hbm5vdGF0ZS5jOjQyMg0KPiAgIzQgIDB4MDAwMDAwMDAwMDY4ZDU3ZiBpbiBoaXN0X19hY2Nv
dW50X2N5Y2xlcyAoYnM9MHgxMTBkMjg4LCBhbD0weDdmZmZhZmZmNjU0MCwgc2FtcGxlPTB4N2Zm
ZmFmZmY2NzYwLCBub25hbnlfYnJhbmNoX21vZGU9ZmFsc2UsIHRvdGFsX2N5Y2xlcz0weDAsIGV2
c2VsPTB4ZmVhMmQwKSBhdCB1dGlsL2hpc3QuYzoyODUwDQo+ICAjNSAgMHgwMDAwMDAwMDAwNDQ2
MjE2IGluIGhpc3RfaXRlcl9fdG9wX2NhbGxiYWNrIChpdGVyPTB4N2ZmZmFmZmY2NTkwLCBhbD0w
eDdmZmZhZmZmNjU0MCwgc2luZ2xlPXRydWUsIGFyZz0weDdmZmZmZmZmOWUwMCkgYXQgYnVpbHRp
bi10b3AuYzo3MzcNCj4gICM2ICAweDAwMDAwMDAwMDA2ODk3ODcgaW4gaGlzdF9lbnRyeV9pdGVy
X19hZGQgKGl0ZXI9MHg3ZmZmYWZmZjY1OTAsIGFsPTB4N2ZmZmFmZmY2NTQwLCBtYXhfc3RhY2tf
ZGVwdGg9MTI3LCBhcmc9MHg3ZmZmZmZmZjllMDApIGF0IHV0aWwvaGlzdC5jOjEzNTkNCj4gICM3
ICAweDAwMDAwMDAwMDA0NDY3MTAgaW4gcGVyZl9ldmVudF9fcHJvY2Vzc19zYW1wbGUgKHRvb2w9
MHg3ZmZmZmZmZjllMDAsIGV2ZW50PTB4MTEwZDI1MCwgZXZzZWw9MHhmZWEyZDAsIHNhbXBsZT0w
eDdmZmZhZmZmNjc2MCwgbWFjaGluZT0weDEwOGM5NjgpIGF0IGJ1aWx0aW4tdG9wLmM6ODQ1DQo+
ICAjOCAgMHgwMDAwMDAwMDAwNDQ3NzM1IGluIGRlbGl2ZXJfZXZlbnQgKHFlPTB4N2ZmZmZmZmZh
MTIwLCBxZXZlbnQ9MHgxMGZjMjAwKSBhdCBidWlsdGluLXRvcC5jOjEyMTENCj4gICM5ICAweDAw
MDAwMDAwMDA2NGNjYWUgaW4gZG9fZmx1c2ggKG9lPTB4N2ZmZmZmZmZhMTIwLCBzaG93X3Byb2dy
ZXNzPWZhbHNlKSBhdCB1dGlsL29yZGVyZWQtZXZlbnRzLmM6MjQ1DQo+ICAjMTAgMHgwMDAwMDAw
MDAwNjRkMDA1IGluIF9fb3JkZXJlZF9ldmVudHNfX2ZsdXNoIChvZT0weDdmZmZmZmZmYTEyMCwg
aG93PU9FX0ZMVVNIX19UT1AsIHRpbWVzdGFtcD0wKSBhdCB1dGlsL29yZGVyZWQtZXZlbnRzLmM6
MzI0DQo+ICAjMTEgMHgwMDAwMDAwMDAwNjRkMGVmIGluIG9yZGVyZWRfZXZlbnRzX19mbHVzaCAo
b2U9MHg3ZmZmZmZmZmExMjAsIGhvdz1PRV9GTFVTSF9fVE9QKSBhdCB1dGlsL29yZGVyZWQtZXZl
bnRzLmM6MzQyDQo+ICAjMTIgMHgwMDAwMDAwMDAwNDQ3MmE5IGluIHByb2Nlc3NfdGhyZWFkIChh
cmc9MHg3ZmZmZmZmZjllMDApIGF0IGJ1aWx0aW4tdG9wLmM6MTEyMA0KPiAgIzEzIDB4MDAwMDdm
ZmZmNmU3ZGJhOCBpbiBzdGFydF90aHJlYWQgKGFyZz08b3B0aW1pemVkIG91dD4pIGF0IHB0aHJl
YWRfY3JlYXRlLmM6NDQ4DQo+ICAjMTQgMHgwMDAwN2ZmZmY2ZjAxYjhjIGluIF9fR0lfX19jbG9u
ZTMgKCkgYXQgLi4vc3lzZGVwcy91bml4L3N5c3YvbGludXgveDg2XzY0L2Nsb25lMy5TOjc4DQo+
IA0KPiBUaGUgY2F1c2UgaXMgdGhhdCBwZXJmX2Vudl9fZmluZF9icl9jbnRyX2luZm8gdHJpZXMg
dG8gYWNjZXNzIGENCj4gbnVsbCBwb2ludGVyIHBtdV9jYXBzIGluIHRoZSBwZXJmX2VudiBzdHJ1
Y3QuIEEgc2ltaWxhciBpc3N1ZSBleGlzdHMNCj4gZm9yIGhvbW9nZW5lb3VzIGNvcmUgc3lzdGVt
cyB3aGljaCB1c2UgdGhlIGNwdV9wbXVfY2FwcyBzdHJ1Y3R1cmUuDQo+IA0KPiBGaXggdGhpcyBi
eSBwb3B1bGF0aW5nIGNwdV9wbXVfY2FwcyBhbmQgcG11X2NhcHMgc3RydWN0dXJlcyB3aXRoDQo+
IHZhbHVlcyBmcm9tIHN5c2ZzIHdoZW4gY2FsbGluZyBwZXJmIHRvcCB3aXRoIGJyYW5jaCBzdGFj
ayBzYW1wbGluZw0KPiBlbmFibGVkLg0KPiANCj4gWzFdLCBMQlIgZXZlbnQgbG9nZ2luZyBpbnRy
b2R1Y2VkIGhlcmU6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMTAyNTIwMTYy
Ni4zMDAwMjI4LTUta2FuLmxpYW5nQGxpbnV4LmludGVsLmNvbS8NCj4gDQo+IFJldmlld2VkLWJ5
OiBJYW4gUm9nZXJzIDxpcm9nZXJzQGdvb2dsZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFRob21h
cyBGYWxjb24gPHRob21hcy5mYWxjb25AaW50ZWwuY29tPg0KPiAtLS0NCj4gdjQ6IHByZWZlciBj
YWxsb2MgYW5kIHpmcmVlIG9wZXJhdGlvbnMgaW4gYWRkaXRpb24gdG8gb3RoZXINCj4gICAgIGNs
ZWFudXBzIHN1Z2dlc3RlZCBieSBOYW1oeXVuZyBhbmQgQXJuYWxkbw0KPiANCj4gdjM6IGNvbnN0
aWZ5IHN0cnVjdCBwZXJmX3BtdSAqcG11IGluIF9fcGVyZl9lbnZfX3JlYWRfY29yZV9wbXVfY2Fw
cygpDQo+ICAgICB1c2UgcGVyZl9wbXVzX19maW5kX2NvcmVfcG11KCkgaW5zdGVhZCBvZiBwZXJm
X3BtdXNfX3NjYW5fY29yZShOVUxMKQ0KPiANCj4gdjI6IHVwZGF0ZSBjb21taXQgbWVzc2FnZSB3
aXRoIG1vcmUgbWVhbmluZ2Z1bCBzdGFjayB0cmFjZSBmcm9tDQo+ICAgICBnZGIgYW5kIGluZGlj
YXRlIHRoYXQgYWZmZWN0ZWQgc3lzdGVtcyBhcmUgbGltaXRlZCB0byBDUFUncw0KPiAgICAgd2l0
aCBMQlIgZXZlbnQgbG9nZ2luZyBzdXBwb3J0IGFuZCB0aGF0IGJvdGggaHlicmlkIGFuZA0KPiAg
ICAgbm9uLWh5YnJpZCBjb3JlIHN5c3RlbXMgYXJlIGFmZmVjdGVkLg0KPiAtLS0NCj4gIHRvb2xz
L3BlcmYvYnVpbHRpbi10b3AuYyB8ICAgOCArKysNCj4gIHRvb2xzL3BlcmYvdXRpbC9lbnYuYyAg
ICB8IDExMCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIHRvb2xz
L3BlcmYvdXRpbC9lbnYuaCAgICB8ICAgMSArDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDExOSBpbnNl
cnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi9idWlsdGluLXRvcC5jIGIv
dG9vbHMvcGVyZi9idWlsdGluLXRvcC5jDQo+IGluZGV4IGY5ZjMxMzkxYmRkYi4uYzlkNjc5NDEw
NTkxIDEwMDY0NA0KPiAtLS0gYS90b29scy9wZXJmL2J1aWx0aW4tdG9wLmMNCj4gKysrIGIvdG9v
bHMvcGVyZi9idWlsdGluLXRvcC5jDQo+IEBAIC0xNzI5LDYgKzE3MjksMTQgQEAgaW50IGNtZF90
b3AoaW50IGFyZ2MsIGNvbnN0IGNoYXIgKiphcmd2KQ0KPiAgCWlmIChvcHRzLT5icmFuY2hfc3Rh
Y2sgJiYgY2FsbGNoYWluX3BhcmFtLmVuYWJsZWQpDQo+ICAJCXN5bWJvbF9jb25mLnNob3dfYnJh
bmNoZmxhZ19jb3VudCA9IHRydWU7DQo+ICANCj4gKwlpZiAob3B0cy0+YnJhbmNoX3N0YWNrKSB7
DQo+ICsJCXN0YXR1cyA9IHBlcmZfZW52X19yZWFkX2NvcmVfcG11X2NhcHMoJnBlcmZfZW52KTsN
Cj4gKwkJaWYgKHN0YXR1cykgew0KPiArCQkJcHJfZXJyKCJQTVUgY2FwYWJpbGl0eSBkYXRhIGlz
IG5vdCBhdmFpbGFibGVcbiIpOw0KPiArCQkJZ290byBvdXRfZGVsZXRlX2V2bGlzdDsNCj4gKwkJ
fQ0KPiArCX0NCj4gKw0KPiAgCXNvcnRfX21vZGUgPSBTT1JUX01PREVfX1RPUDsNCj4gIAkvKiBk
aXNwbGF5IHRocmVhZCB3YW50cyBlbnRyaWVzIHRvIGJlIGNvbGxhcHNlZCBpbiBhIGRpZmZlcmVu
dCB0cmVlICovDQo+ICAJcGVyZl9ocHBfbGlzdC5uZWVkX2NvbGxhcHNlID0gMTsNCj4gZGlmZiAt
LWdpdCBhL3Rvb2xzL3BlcmYvdXRpbC9lbnYuYyBiL3Rvb2xzL3BlcmYvdXRpbC9lbnYuYw0KPiBp
bmRleCAzNjQxMTc0OWUwMDcuLmIwNTNkMDk0MzhhZiAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvcGVy
Zi91dGlsL2Vudi5jDQo+ICsrKyBiL3Rvb2xzL3BlcmYvdXRpbC9lbnYuYw0KPiBAQCAtNDE2LDYg
KzQxNiwxMTYgQEAgc3RhdGljIGludCBwZXJmX2Vudl9fcmVhZF9ucl9jcHVzX2F2YWlsKHN0cnVj
dCBwZXJmX2VudiAqZW52KQ0KPiAgCXJldHVybiBlbnYtPm5yX2NwdXNfYXZhaWwgPyAwIDogLUVO
T0VOVDsNCj4gIH0NCj4gIA0KPiArc3RhdGljIGludCBfX3BlcmZfZW52X19yZWFkX2NvcmVfcG11
X2NhcHMoY29uc3Qgc3RydWN0IHBlcmZfcG11ICpwbXUsDQo+ICsJCQkJCSAgaW50ICpucl9jYXBz
LCBjaGFyICoqKmNhcHMsDQo+ICsJCQkJCSAgdW5zaWduZWQgaW50ICptYXhfYnJhbmNoZXMsDQo+
ICsJCQkJCSAgdW5zaWduZWQgaW50ICpicl9jbnRyX25yLA0KPiArCQkJCQkgIHVuc2lnbmVkIGlu
dCAqYnJfY250cl93aWR0aCkNCj4gK3sNCj4gKwlzdHJ1Y3QgcGVyZl9wbXVfY2FwcyAqcGNhcHMg
PSBOVUxMOw0KPiArCWNoYXIgKnB0ciwgKip0bXA7DQo+ICsJaW50IHJldCA9IDA7DQo+ICsNCj4g
KwkqbnJfY2FwcyA9IDA7DQo+ICsJKmNhcHMgPSBOVUxMOw0KPiArDQo+ICsJaWYgKCFwbXUtPm5y
X2NhcHMpDQo+ICsJCXJldHVybiAwOw0KPiArDQo+ICsJKmNhcHMgPSBjYWxsb2MocG11LT5ucl9j
YXBzLCBzaXplb2YoY2hhciAqKSk7DQo+ICsJaWYgKCEqY2FwcykNCj4gKwkJcmV0dXJuIC1FTk9N
RU07DQo+ICsNCj4gKwl0bXAgPSAqY2FwczsNCj4gKwlsaXN0X2Zvcl9lYWNoX2VudHJ5KHBjYXBz
LCAmcG11LT5jYXBzLCBsaXN0KSB7DQo+ICsJCWlmIChhc3ByaW50ZigmcHRyLCAiJXM9JXMiLCBw
Y2Fwcy0+bmFtZSwgcGNhcHMtPnZhbHVlKSA8IDApIHsNCj4gKwkJCXJldCA9IC1FTk9NRU07DQo+
ICsJCQlnb3RvIGVycm9yOw0KPiArCQl9DQo+ICsNCj4gKwkJKnRtcCsrID0gcHRyOw0KPiArDQo+
ICsJCWlmICghc3RyY21wKHBjYXBzLT5uYW1lLCAiYnJhbmNoZXMiKSkNCj4gKwkJCSptYXhfYnJh
bmNoZXMgPSBhdG9pKHBjYXBzLT52YWx1ZSk7DQo+ICsJCWVsc2UgaWYgKCFzdHJjbXAocGNhcHMt
Pm5hbWUsICJicmFuY2hfY291bnRlcl9uciIpKQ0KPiArCQkJKmJyX2NudHJfbnIgPSBhdG9pKHBj
YXBzLT52YWx1ZSk7DQo+ICsJCWVsc2UgaWYgKCFzdHJjbXAocGNhcHMtPm5hbWUsICJicmFuY2hf
Y291bnRlcl93aWR0aCIpKQ0KPiArCQkJKmJyX2NudHJfd2lkdGggPSBhdG9pKHBjYXBzLT52YWx1
ZSk7DQo+ICsJfQ0KPiArCSpucl9jYXBzID0gcG11LT5ucl9jYXBzOw0KPiArCXJldHVybiAwOw0K
PiArZXJyb3I6DQo+ICsJd2hpbGUgKHRtcC0tICE9ICpjYXBzKQ0KPiArCQl6ZnJlZSh0bXApOw0K
PiArCXpmcmVlKGNhcHMpOw0KPiArCSpucl9jYXBzID0gMDsNCj4gKwlyZXR1cm4gcmV0Ow0KPiAr
fQ0KPiArDQo+ICtpbnQgcGVyZl9lbnZfX3JlYWRfY29yZV9wbXVfY2FwcyhzdHJ1Y3QgcGVyZl9l
bnYgKmVudikNCj4gK3sNCj4gKwlzdHJ1Y3QgcG11X2NhcHMgKnBtdV9jYXBzOw0KPiArCXN0cnVj
dCBwZXJmX3BtdSAqcG11ID0gTlVMTDsNCj4gKwlpbnQgbnJfcG11LCBpID0gMCwgajsNCj4gKwlp
bnQgcmV0Ow0KPiArDQo+ICsJbnJfcG11ID0gcGVyZl9wbXVzX19udW1fY29yZV9wbXVzKCk7DQo+
ICsNCj4gKwlpZiAoIW5yX3BtdSkNCj4gKwkJcmV0dXJuIC1FTk9ERVY7DQo+ICsNCj4gKwlpZiAo
bnJfcG11ID09IDEpIHsNCj4gKwkJcG11ID0gcGVyZl9wbXVzX19maW5kX2NvcmVfcG11KCk7DQo+
ICsJCWlmICghcG11KQ0KPiArCQkJcmV0dXJuIC1FTk9ERVY7DQo+ICsJCXJldCA9IHBlcmZfcG11
X19jYXBzX3BhcnNlKHBtdSk7DQo+ICsJCWlmIChyZXQgPCAwKQ0KPiArCQkJcmV0dXJuIHJldDsN
Cj4gKwkJcmV0dXJuIF9fcGVyZl9lbnZfX3JlYWRfY29yZV9wbXVfY2FwcyhwbXUsICZlbnYtPm5y
X2NwdV9wbXVfY2FwcywNCj4gKwkJCQkJCSAgICAgICZlbnYtPmNwdV9wbXVfY2FwcywNCj4gKwkJ
CQkJCSAgICAgICZlbnYtPm1heF9icmFuY2hlcywNCj4gKwkJCQkJCSAgICAgICZlbnYtPmJyX2Nu
dHJfbnIsDQo+ICsJCQkJCQkgICAgICAmZW52LT5icl9jbnRyX3dpZHRoKTsNCj4gKwl9DQo+ICsN
Cj4gKwlwbXVfY2FwcyA9IGNhbGxvYyhucl9wbXUsIHNpemVvZigqcG11X2NhcHMpKTsNCj4gKwlp
ZiAoIXBtdV9jYXBzKQ0KPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gKw0KPiArCXdoaWxlICgocG11
ID0gcGVyZl9wbXVzX19zY2FuX2NvcmUocG11KSkgIT0gTlVMTCkgew0KPiArCQlpZiAocGVyZl9w
bXVfX2NhcHNfcGFyc2UocG11KSA8PSAwKQ0KPiArCQkJY29udGludWU7DQo+ICsJCXJldCA9IF9f
cGVyZl9lbnZfX3JlYWRfY29yZV9wbXVfY2FwcyhwbXUsICZwbXVfY2Fwc1tpXS5ucl9jYXBzLA0K
PiArCQkJCQkJICAgICAmcG11X2NhcHNbaV0uY2FwcywNCj4gKwkJCQkJCSAgICAgJnBtdV9jYXBz
W2ldLm1heF9icmFuY2hlcywNCj4gKwkJCQkJCSAgICAgJnBtdV9jYXBzW2ldLmJyX2NudHJfbnIs
DQo+ICsJCQkJCQkgICAgICZwbXVfY2Fwc1tpXS5icl9jbnRyX3dpZHRoKTsNCj4gKwkJaWYgKHJl
dCkNCj4gKwkJCWdvdG8gZXJyb3I7DQo+ICsNCj4gKwkJcG11X2NhcHNbaV0ucG11X25hbWUgPSBz
dHJkdXAocG11LT5uYW1lKTsNCj4gKwkJaWYgKCFwbXVfY2Fwc1tpXS5wbXVfbmFtZSkgew0KPiAr
CQkJcmV0ID0gLUVOT01FTTsNCj4gKwkJCWdvdG8gZXJyb3I7DQo+ICsJCX0NCj4gKwkJaSsrOw0K
PiArCX0NCj4gKw0KPiArCWVudi0+bnJfcG11c193aXRoX2NhcHMgPSBucl9wbXU7DQo+ICsJZW52
LT5wbXVfY2FwcyA9IHBtdV9jYXBzOw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICtlcnJvcjoNCj4g
Kwlmb3IgKGkgPSAwOyBpIDwgbnJfcG11OyBpKyspIHsNCj4gKwkJZm9yIChqID0gMDsgaiA8IHBt
dV9jYXBzW2ldLm5yX2NhcHM7IGorKykNCj4gKwkJCXpmcmVlKCZwbXVfY2Fwc1tpXS5jYXBzW2pd
KTsNCj4gKwkJemZyZWUoJnBtdV9jYXBzW2ldLmNhcHMpOw0KPiArCQl6ZnJlZSgmcG11X2NhcHNb
aV0ucG11X25hbWUpOw0KPiArCX0NCj4gKwl6ZnJlZSgmcG11X2NhcHMpOw0KPiArCXJldHVybiBy
ZXQ7DQo+ICt9DQo+ICsNCj4gIGNvbnN0IGNoYXIgKnBlcmZfZW52X19yYXdfYXJjaChzdHJ1Y3Qg
cGVyZl9lbnYgKmVudikNCj4gIHsNCj4gIAlyZXR1cm4gZW52ICYmICFwZXJmX2Vudl9fcmVhZF9h
cmNoKGVudikgPyBlbnYtPmFyY2ggOiAidW5rbm93biI7DQo+IGRpZmYgLS1naXQgYS90b29scy9w
ZXJmL3V0aWwvZW52LmggYi90b29scy9wZXJmL3V0aWwvZW52LmgNCj4gaW5kZXggZDkwZTM0M2Nm
MWZhLi4xMzVhMWY3MTQ5MDUgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3BlcmYvdXRpbC9lbnYuaA0K
PiArKysgYi90b29scy9wZXJmL3V0aWwvZW52LmgNCj4gQEAgLTE1Miw2ICsxNTIsNyBAQCBzdHJ1
Y3QgYnRmX25vZGU7DQo+ICANCj4gIGV4dGVybiBzdHJ1Y3QgcGVyZl9lbnYgcGVyZl9lbnY7DQo+
ICANCj4gK2ludCBwZXJmX2Vudl9fcmVhZF9jb3JlX3BtdV9jYXBzKHN0cnVjdCBwZXJmX2VudiAq
ZW52KTsNCj4gIHZvaWQgcGVyZl9lbnZfX2V4aXQoc3RydWN0IHBlcmZfZW52ICplbnYpOw0KPiAg
DQo+ICBpbnQgcGVyZl9lbnZfX2tlcm5lbF9pc182NF9iaXQoc3RydWN0IHBlcmZfZW52ICplbnYp
Ow0KDQo=

