Return-Path: <linux-kernel+bounces-837904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454CEBAE03E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009F13BF109
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E744F265CCD;
	Tue, 30 Sep 2025 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KKmZ6RUi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28C43090DF;
	Tue, 30 Sep 2025 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759248536; cv=fail; b=jhiaXorG57FKof2ZkSL7NJzYASiTzUl8UFIwlDBjMdmboLZVn4NDPwyASA5HcXzSCF1oWn/Qbm5XNy50qj8sHXfB2aaPZtv99IzDvqdweD+sqn9F5myU5yobRtF8jbwBbHti9SH7DDPi0RRKDF0uxIYc6jdeA2iCeACdHCli78s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759248536; c=relaxed/simple;
	bh=vnTZb08ouGRqdQz+DHyCFXFtrwVDBfR0BZfvfkGRUg0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j8bYYo03yVh9nGsolD6O7f0SAI9hTS1kuegVn4mrpJXGp8x72O2YnFv6W4YK928aHICsf2crf7ovRibAVJzFXr6oxmEoZ6I0hm4SMfEp1HyWp99o1fFLArySTz446kZPMfDSzld5y7ZTrAVJQ8I04kbhq6xEMkW0Uo3D2Ari8HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KKmZ6RUi; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759248535; x=1790784535;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vnTZb08ouGRqdQz+DHyCFXFtrwVDBfR0BZfvfkGRUg0=;
  b=KKmZ6RUiTA49CX3/u+lhrU+ZXkoFNkmevrB/K5g78t+PhCYadGiP/cp5
   jlSja8QKQ+xVP7MEzjf71S9DGGxd+erdvlI29MKxdJ7jtjmLFyQrbT8jz
   FkT1KVrkYnUVZG2MlKq9mxPnZG+8BvxSze4MyQU/20JPmFkMuaevf/OfZ
   lizcixbdKkcJHUOjJdMyc5IyufvJ3RIPXinymCl9qvBlBEJjDX1WWt4O1
   UnR5fFl8xXGvw0cxTmU1owOpETKFFWR7uIOaC0wYunoiJudPZCM1ucoUQ
   AJqLxSUuycZvynbts2HIRvqice2GIluO9HjY1pSD4m97p+JgHiJbqYWNa
   Q==;
X-CSE-ConnectionGUID: A5XFp/5eROSkwv379yCA8w==
X-CSE-MsgGUID: BuBXLt12Q2CYWhXhkOJ5yQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="78933486"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="78933486"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 09:08:55 -0700
X-CSE-ConnectionGUID: NUc4bgCERJSRT157P62eMg==
X-CSE-MsgGUID: i3JAGDPDTGGXnzC9uvLZrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="209513531"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 09:08:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 09:08:52 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 30 Sep 2025 09:08:52 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.59)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 09:08:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awmNCszJb5Za3s+bmVT9wwaCFTQtG4V41edhY2uEK5dDsgt0ZuXdn6hZcLfUgDvpJrbM7nBQOzq8Ma0KNYjbclUAxyG61aHw/iOi6k/GeL90UjZGsNJ2IlZ+dX+XcsSYqNlRYI7w1FOhEn2YkPPrwvTJhlkpd7zDQMhPShSu2xpOEeWWXwX8UL5ju4N2/KEOK0UQ2PcPnV0xxYAJGhJBgZnBtX8n63Gtmz9KhrbwNVdOJ2DYGZtAw75JiFgc+NJme1E/xwkx0Lan6MPrxplcu1NFvuR4Y1V7kNJmrvzUPjzKuDYSuYTScp+MHrX4Kyev/ydAGGOspaW1qXSJkb7EwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnTZb08ouGRqdQz+DHyCFXFtrwVDBfR0BZfvfkGRUg0=;
 b=FOmeFkxM0a2ZNA7H/E6jqG+pR7yMd+daOH0x03wOin7CT8JZMAqRpyz+s/P64XBOW+gqGVT2dno2vUl2B0+/6YkABUqXp7y6pI90c8YIkwrv4fAcqR79ajuPetczn/1JrpS/nmfqciBtNPmv+d8xQKDenPy4JD4P4ocM38LscEx4rTBfbB66ey2xUhhrdYkkg9uTavBVSQn1H8mdG5lJVKyzWsDpiicHY0y27LKnqhV5hS9uGFZDMu2SSGZdyOeDZr2S2gc6/D+7ymUTn+X2QUtpYwDLNXA4EzlGCaHyDLByEt+2Y1TFe/XNV4lzIwJF56PdlQxmTViUNP3zg/bl5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS7PR11MB7806.namprd11.prod.outlook.com (2603:10b6:8:db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Tue, 30 Sep
 2025 16:08:50 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 16:08:50 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chen, Yu C" <yu.c.chen@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, James Morse <james.morse@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	"x86@kernel.org" <x86@kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, Dave Martin <Dave.Martin@arm.com>
Subject: RE: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
Thread-Topic: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
Thread-Index: AQHcHCY4c4HVqMw7CEaMcDAeu2aTP7SfbCMAgAU7aICABWR8AIAAUhcAgAAfltCAAT1PgIAAU9dQ
Date: Tue, 30 Sep 2025 16:08:50 +0000
Message-ID: <SJ1PR11MB6083B06D21C6C348A3FAE6AEFC1AA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <aNFliMZTTUiXyZzd@e133380.arm.com> <aNXJGw9r_k3BB4Xk@agluck-desk3>
 <02647276-dea2-47b5-a271-7f02666e0492@intel.com>
 <aNqUACFbXHjURWir@e133380.arm.com>
 <SJ1PR11MB60838E8CBD68B962380BBA60FC1BA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <4ffceb95-0e5e-42d6-bbc3-a2cb8a3fd65a@intel.com>
In-Reply-To: <4ffceb95-0e5e-42d6-bbc3-a2cb8a3fd65a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS7PR11MB7806:EE_
x-ms-office365-filtering-correlation-id: 4fb6b8f4-ec34-442c-4d6b-08de003ba4e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?V2ZGUzFySHB2VnN1LzdQQUp5TnNmS1N5RUR2c3Q3cnFMajB4b2gzbmllNjNX?=
 =?utf-8?B?VUJMd09vRTI0S0xLVGl4UU1xOUd2ckxpOVJLNnQ1d3NtbEhsc2Q4U0lsQ3d1?=
 =?utf-8?B?VW00a3pFckJoUWlhSmFpbUtXbGM2ZFpnUjZLcG5taFBzOEwxYTJhK2V3VXdN?=
 =?utf-8?B?dmtURXNYNDZEZmxPTzhTTUFsbzJJZGxMY3dzbUxYUW9peXRoUVZrQk53N0F0?=
 =?utf-8?B?RExGck9mUXhrWUoydnk5Mkh4S28yd0hIS0ptY3pyOWpQcHZJUUd0cmMrd2ZH?=
 =?utf-8?B?cmlvbUVubHhBQXNpcG9Ybk02dkx1Ry9sb0FaY0l1L1pvbmxhUFJxWXJaQW8r?=
 =?utf-8?B?N1FtVzJWK25aSDVDcFlCTlg0U2RJZkFtUitLSnFkMDFRQnJlaWdOY2U1TS9Z?=
 =?utf-8?B?REUwVjRRRnFGYkNsVENNSGNZQ1RINWlrU1AyNld3c0hFQmFMcW1aQ3FKR3E5?=
 =?utf-8?B?MlBkU1RPYjZZN3dtTTRVZjNRTGNTZFJJTzlZTDFkKzZORnByMEhnQTMzNkdZ?=
 =?utf-8?B?NERObXByS0RZMjBUUmFhMTJsVUJNQ0F3RklSTHNZN0NNRkdNcVIvclhVd1l6?=
 =?utf-8?B?ZytMcHJscTkvZjZUL0xnMG4xb0ZTN1Jub2hXRmppcTJPM1ZBSXVpQXBjSlJ6?=
 =?utf-8?B?elptYlZJRDRVOFRGQm5PZWdYTTkvUUZMTTY2czJMNTMvaGZRWi9aK1BhSTRv?=
 =?utf-8?B?WGRKZ0EzczFRcDRPU3pqZGJCanVqKzU1dUw4dDhTVnA2Mmc5WE1TK0F0aldi?=
 =?utf-8?B?U0VLS05pUTNkUUxxVElmNU5QemRLQ2krTnhnR0U1Q0tkSS9BK0JPdUNnZkRN?=
 =?utf-8?B?V2Z4NTM5NVhEN3E3NDVhYU9EL25IOUhrUWxFV1dWK2RqWWJDSE01Y0h5U0ky?=
 =?utf-8?B?bGk2bSs5YWlxY0R4UU0zUEFNQVduQllDWVBrL1czQmJ5T3ZFZ2tjbk1sU0JQ?=
 =?utf-8?B?V2hBTGpTUlRwNHMzRVZrN2VpZ0t0UG05OXRpR1FVRDRaUmpWRERIcG4xTmVk?=
 =?utf-8?B?Z0pxSXI1M1JJQXJCVlM2L2tJWHZRSVNicFA1V0plcWJ6eXIvMldJUFZQSnhr?=
 =?utf-8?B?bVh4ZlI2c250UFN4T052YS9RS3NwTXduUjBuVklQSk1vUUF5a3o3RjhOV0VV?=
 =?utf-8?B?YVFjN2RNNzhiZlFxWVVxdDM3SE40UkJTaVNUcU1HTUtHUWcvS2w4ZjRoMU1v?=
 =?utf-8?B?dzhybFBRUmlmRm4yemQ2ejRZeEh6VjM1YWsza2FwN3k1VGdzQXR4ejAyOC81?=
 =?utf-8?B?YkxyeksrbzdqM0oxZk1PYnNjNi9vS1VELzRJblg4NENIQWJZei9CUU4rdXdH?=
 =?utf-8?B?OGllRlBoT2M0ZGlMNFgvSGtJaGJYSExRcW9MM0FpdlFFRldOS3hwUHgreFpl?=
 =?utf-8?B?Z3ZDN0JKWUJzRzlhQkY1WDRoZStSL2lYL2lLRWFaU2YzNk5UaXFmRlBDTUFo?=
 =?utf-8?B?d0VYZ3lMSVJVNjJpZXYrZVlMUkpWSFpnYmtyVHdFTVdoWUJNSXNyckFmazVR?=
 =?utf-8?B?QUpnZkw2dXpQTGd6WHRFVUlBV09tV2ZSd0JibUJFdUxCcTFFT2xvNEJoODNQ?=
 =?utf-8?B?eERnYlNjRy9vM25Yb2ZCeWd5K204eXhyL1VZVWRJeVk4MmxGUDl0dnkvRkt5?=
 =?utf-8?B?cHR5MS9sVEJQWEZzL2lDcWZSVHdoUVJaSHl2Y1g4MXIvckJHellsSmxncno4?=
 =?utf-8?B?S3hEb3FHcWFQUElxNmxIWDYzR0tkWng4eExXL1l1em5LSS9VK3ZWR1FTdmlE?=
 =?utf-8?B?V004cWs1V1o1Q0pjTlp1NS9iS0s5NEVnTTZjdytyYzBUaGhXazlScWl2TzBv?=
 =?utf-8?B?OEpHTmhkVGlORjFqVyt5RjgxYmtNT1hlSmJhM096WVlreUZEdjZROTRpZWtU?=
 =?utf-8?B?ZVliNFdHQkRRajlDYWtYWVQyS0VKYWpzOXFqRHp0V2JtK3FRc2xaSU5yQTIv?=
 =?utf-8?B?aVVWdWpma2Z0ak5MUTJ4VHdZakpKYXlkMHhTQUFxMUpjNWhla3pnQXpPSnFl?=
 =?utf-8?B?REdHQkxjTTlwQ1hzQ2hrS2REQkpUcDE2TytxNUZDRDhqdnc2NlVzR3U5Y3Vj?=
 =?utf-8?Q?1dpms7?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmI2aTYyUk9pUURQRWNIZk1UcXFiZnVES1NXZkZHVjNiUDdQMzJULzdzWFZx?=
 =?utf-8?B?MVFnNnd6YW5YSjV3bFAvMXdmaU54K2JRcW5xTUxPNGpjMDVueE5TRE5SQ1lO?=
 =?utf-8?B?K1ZpM2lPaXVvby9zN0VzSWkyNlVPNDZuc3RZVE4zMmp5UlpGcEFQQ2pOcTJa?=
 =?utf-8?B?OGRRRjk1QkF4TWJMQytiQ29ocGoxNHRkWFBWSDdTeHNnTU1XL282eFlrL3pT?=
 =?utf-8?B?ZFpDVjVwcWlqZFQ2Q203TEpMWldaSWNKL1NYY2YrY2JYUG9LL21IbTRWbUVx?=
 =?utf-8?B?d0QzVmJGZVQyYW1ieGpRS2U1ekJwL1Z4NGd6TE9xMzl4OEJRdUdYeTQyRmZu?=
 =?utf-8?B?ZEJZbitwaDhFMUVVMVdYam1uUk9NcWVDSjU1MDZIM1dJeWdlRkgvOWVSdmRQ?=
 =?utf-8?B?MGM3RnNxSDlWa1p6Z2syTkRXM3ZNelpMT2VSbnYvTnFtNnJwdlg3Mit4VDZX?=
 =?utf-8?B?STZScG1nUXhqSFRyNVBsQ2ZhaTV0bFI3NzkwMkhpODJiZ3dUemxydFU4NGZN?=
 =?utf-8?B?OU9UZGNmZlB4UzhrY1FnV2MwajVTcFVnb0IrVzc0U2R2U2R4ZHM1cWNicEZU?=
 =?utf-8?B?SmNQUC9MNXdBRHdFc2VieUsxSmZYREZsNGNQaEp4RDhnbitDY3JPa2lGOS9N?=
 =?utf-8?B?RTRVUmFZeWNrdXRWanBXTVBickZYZGQ5ZVV0d3FPZnluZ09iYVhObnY5eHdZ?=
 =?utf-8?B?UkpJZHl4T3RLVUc2WmdSTFdDR1k5SkQ3ZUpRSWFSejROVnFiYWp0bUpaNHRq?=
 =?utf-8?B?dlBlTzYyQlllcnRYRzR6T3RtUzR3bWorR1RGaHJNUjU5U0VnR1ZvcDVleGdk?=
 =?utf-8?B?RUdRcVVwdHIzRzZZbVRYQWVWY3RFd0RvaHJQbDFqN3VhUFJMRUdHOGZwWUJa?=
 =?utf-8?B?dEZKanZXR09KTkEvQm5wOWRiRGVaZEZjMWpLa3ZsWTlMT1F1SWJJWGI4TE1s?=
 =?utf-8?B?SkI2VXB4aWxGT2F0RlhsWWk1UlgvWkFBR1BUa2t4TzZsYy9lYmU4Z3g2a1dt?=
 =?utf-8?B?Vlk1UnBYSWh5V1JDZWVhYUlJS1hZVHltSmpHQXcvY21RZTlJQnAvUm1BeURU?=
 =?utf-8?B?NFUyTVArZzFsWUc5aE5vQkFGeVE5U2ZDNGtyRlcrcTRnK0U3YVl6eStxeUxV?=
 =?utf-8?B?NHRvK0RtNUQybGNtUmZrSCtLSjhKeGdCM1F4djFWMncrbU5zYU1vbjdDazdp?=
 =?utf-8?B?MUFWWTVjSytxQmxzS3pXaVZHd25rRjArYkxYSXM0MnRMWEJRbjNMeGl6Y0JX?=
 =?utf-8?B?RCsyMUxVYzNmbUdoeEo2YVRvMUk5ZTJ1RU9KWExUOGdrbEZ0Unl2bVNiMWJu?=
 =?utf-8?B?V0lvYlZvUWU2Z0dNMWJobEUzN2twaEtGSU10K0NPZjNBNkdLU3A2R0crWU1M?=
 =?utf-8?B?emVVS3FOckxnTEJUa1pxdlcycUFyUlBHSkNpeGlNbytkb3cyZXZCdWJpZmNS?=
 =?utf-8?B?VUxYMFJjYlNiV3E0T3ZUOS9zOEIzTTFaOWdzamdrQlJ0dDZpQXVCMEI0K0Nz?=
 =?utf-8?B?WVRWRE1ZNWxRWVptelhpWWkrMEtqMUpOcmlFaHBYR2lUT05rRjF0MUQ1WU9m?=
 =?utf-8?B?M0FDSHVUTElaOENUbTdwL1BRUGRiZUh3am0wQUp5amhwdURrL0hnV3dEZGx0?=
 =?utf-8?B?UEFKQ0lSOGx5YnNTR2ZIUEQ1cnMyM0EvdFh0NlZaRkJKdEQ5Q1JrOW1RSm5I?=
 =?utf-8?B?RnUrQlpQejlvYjVzeWcwdWFCM3BHNXlTZHVuWjB0U05GZEJIR0hRYkdDdlM3?=
 =?utf-8?B?WnRhenFnK09ONnZRTmRlSWxpdEZXNVozN0RFSE5JWTVINmxEa1hObU4wZDVw?=
 =?utf-8?B?bVhkZlBrQ3drMnhBeEhlUnJ0SVFCSEh4TUlSSW5YTUxKY1d6SytySlo1NGtk?=
 =?utf-8?B?TndVMHhDZjJPY0pvL1pObmFWNENTVndhMnNUNVBXaE9wb3RBZ3RYQVR2NUNU?=
 =?utf-8?B?SC93aUd2Nzg4OHVTU1dvWitrTm1Yc0s1YzV1REw5WmMyRUp1MzVMbG00U2tK?=
 =?utf-8?B?Z0x5aWxrcStkNmdQVE84S3ZGV2t3Q1poL0MwQnQ3K2IwTG5wR0Y5TDdPaUVS?=
 =?utf-8?B?RnViRTlldk5RYitIL2dSMTFmV05jRGFoVXdWcmdnUDFSZnRJSHRRcDZ2T2Zv?=
 =?utf-8?Q?ek6THRyH6Gy9PIcgzB0GD77pP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb6b8f4-ec34-442c-4d6b-08de003ba4e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 16:08:50.2292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zOatE/0jv6eQx0/kWFAXs04MIRTVJIGVfq2x8E9QScpDKthSiEQA9oJoMFGe/AWIGtwYpR4lGYdkdwQRry8zBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7806
X-OriginatorOrg: intel.com

PiA+Pj4gVGhpcyBzZWVtcyB0byBiZSBhcHBsaWNhYmxlIGFzIGl0IGludHJvZHVjZXMgdGhlIG5l
dyBpbnRlcmZhY2UNCj4gPj4+IHdoaWxlIHByZXNlcnZpbmcgZm9yd2FyZCBjb21wYXRpYmlsaXR5
Lg0KPiA+Pj4NCj4gPj4+IE9uZSBtaW5vciBxdWVzdGlvbiBpcyB0aGF0LCBhY2NvcmRpbmcgdG8g
IkZpZ3VyZSA2LTUuIE1CQSBPcHRpbWFsDQo+ID4+PiBCYW5kd2lkdGggUmVnaXN0ZXIiIGluIHRo
ZSBsYXRlc3QgUkRUIHNwZWNpZmljYXRpb24sIHRoZSBtYXhpbXVtDQo+ID4+PiB2YWx1ZSByYW5n
ZXMgZnJvbSAxIHRvIDUxMS4NCj4gPj4+IEFkZGl0aW9uYWxseSwgdGhpcyBiYW5kd2lkdGggZmll
bGQgaXMgbG9jYXRlZCBhdCBiaXRzIDQ4IHRvIDU2IGluDQo+ID4+PiB0aGUgTUJBIE9wdGltYWwg
QmFuZHdpZHRoIFJlZ2lzdGVyLCBhbmQgdGhlIHJhbmdlIGZvcg0KPiA+Pj4gdGhpcyBzZWdtZW50
IGNvdWxkIGJlIDEgdG8gODE5MS4gSnVzdCB3b25kZXIgaWYgaXQgd291bGQgYmUNCj4gPg0KPiA+
IDQ4Li41NiBpcyBzdGlsbCA5IGJpdHMsIHNvIG1heCB2YWx1ZSBpcyA1MTEuDQo+ID4NCj4NCj4g
QWggSSBzZWUsIEkgb3Zlcmxvb2tlZCB0aGlzLg0KPg0KPiA+Pj4gcG9zc2libGUgdGhhdCB0aGUg
Y3VycmVudCBtYXhpbXVtIHZhbHVlIG9mIDUxMiBtYXkgYmUgZXh0ZW5kZWQNCj4gPj4+IGluIHRo
ZSBmdXR1cmU/IFBlcmhhcHMgd2UgY291bGQgZXhwbG9yZSBhIG1ldGhvZCB0byBxdWVyeSB0aGUg
bWF4aW11bSB1cHBlcg0KPiA+Pj4gbGltaXQgZnJvbSB0aGUgQUNQSSB0YWJsZSBvciByZWdpc3Rl
ciwgb3IgdXNlIENQVUlEIHRvIGRpc3Rpbmd1aXNoIGJldHdlZW4NCj4gPj4+IHBsYXRmb3JtcyBy
YXRoZXIgdGhhbiBoYXJkY29kaW5nIGl0LiBSZWluZXR0ZSBhbHNvIG1lbnRpb25lZCB0aGlzIGlu
IGFub3RoZXINCj4gPj4+IHRocmVhZC4NCj4gPg0KPiA+IEkgdGhpbmsgNTExIHdhcyBjaG9zZW4g
YXMgImJpZ2dlciB0aGFuIHdlIGV4cGVjdCB0byBldmVyIG5lZWQiIGFuZCA5LWJpdHMNCj4gPiBh
bGxvY2F0ZWQgaW4gdGhlIHJlZ2lzdGVycyBiYXNlZCBvbiB0aGF0Lg0KPiA+DQo+DQo+IE9LLCBn
b3QgaXQuDQo+DQo+ID4gSW5pdGlhbCBpbXBsZW1lbnRhdGlvbiBtYXkgdXNlIDI1NSBhcyB0aGUg
bWF4aW11bSAtIHRob3VnaCBJJ20gcHVzaGluZyBvbg0KPiA+IHRoYXQgYSBiaXQgYXMgdGhlIHRo
cm90dGxlIGdyYXBoIGF0IHRoZSBlYXJseSBzdGFnZSBpcyBmYWlybHkgbGluZWFyIGZyb20gIjEi
IHRvIHNvbWUNCj4gPiB2YWx1ZSA8IDI1NSwNCj4gPiB3aGVuIGJhbmR3aWR0aCBoaXRzIG1heGlt
dW0sIHRoZW4gZmxhdCB1cCB0byAyNTUuDQo+ID4gSWYgdGhpbmdzIHN0YXkgdGhhdCB3YXksIEkn
bSBhcmd1aW5nIHRoYXQgdGhlICJRIiB2YWx1ZSBlbnVtZXJhdGVkIGluIHRoZSBBQ1BJDQo+ID4g
dGFibGUgc2hvdWxkIGJlIHRoZSB2YWx1ZSB3aGVyZSBwZWFrIGJhbmR3aWR0aCBpcyBoaXQNCj4N
Cj4gSSBzZWUuIElmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHksIHRoZSBCSU9TIG5lZWRzIHRvIHBy
ZS10cmFpbiB0aGUgc3lzdGVtIHRvDQo+IGZpbmQgdGhpcyBRLiBIb3dldmVyLCBpZiB0aGUgQklP
UyBjYW5ub3QgcHJvdmlkZSB0aGlzIFEsIHdvdWxkIGl0IGJlDQo+IGZlYXNpYmxlDQo+IGZvciB0
aGUgdXNlciB0byBwcm92aWRlIGl0PyBGb3IgZXhhbXBsZSwgdGhlIHVzZXIgY291bGQgc2F0dXJh
dGUgdGhlIG1lbW9yeQ0KPiBiYW5kd2lkdGgsIGdyYWR1YWxseSBpbmNyZWFzZSBNQl9NQVgsIGFu
ZCBmaW5hbGx5IGZpbmQgdGhlIFFfbWF4IHdoZXJlIHRoZQ0KPiBtZW1vcnkgYmFuZHdpZHRoIG5v
IGxvbmdlciBpbmNyZWFzZXMuIFRoZSB1c2VyIGNvdWxkIHRoZW4gYWRqdXN0IHRoZSBtYXgNCj4g
ZmllbGQgaW4gdGhlIGluZm8gZmlsZS4NCj4NCj4gPiAodGhvdWdoIHRoaXMgaXMgY29tcGxpY2F0
ZWQNCj4gPiBiZWNhdXNlIHdvcmtsb2FkcyB3aXRoIGRpZmZlcmVudCBtaXhlcyBvZiByZWFkL3dy
aXRlIGFjY2VzcyBoYXZlIGRpZmZlcmVudA0KPiA+IHRocm90dGxlIGdyYXBocykuDQo+ID4NCj4N
Cj4gRG9lcyB0aGlzIG1lYW4gcmVhZCBhbmQgd3JpdGUgb3BlcmF0aW9ucyBoYXZlIGRpZmZlcmVu
dCBRIHZhbHVlcyB0byBzYXR1cmF0ZQ0KPiB0aGUgbWVtb3J5IGJhbmR3aWR0aD8gRm9yIGV4YW1w
bGUsIGlmIHRoZSB3b3JrbG9hZCBpcyBhbGwgcmVhZHMsIHRoZXJlDQo+IGlzIGEgUV9yOw0KPiBp
ZiB0aGUgd29ya2xvYWQgaXMgYWxsIHdyaXRlcywgdGhlcmUgaXMgYW5vdGhlciBRX3cuIEluIHRo
YXQgY2FzZSwgbWF5YmUgd2UNCj4gY291bGQgY2hvb3NlIHRoZSBtYXhpbXVtIG9mIFFfciBhbmQg
UV93IChtYXgoUV9yLCBRX3cpKS4NCg0KSWYgdGhlIEJJT1MgZG9lc24ndCBwcm92aWRlIGEgZ29v
ZCBlbm91Z2ggbnVtYmVyLCB0aGVuIHVzZXJzIG1pZ2h0IHdlbGwNCmRvIHNvbWUgdHVuaW5nIGJh
c2VkIG9uIHRoZSB3b3JrbG9hZHMgdGhleSBwbGFuIHRvIHJ1biBhbmQgaWdub3JlIHRoZSB2YWx1
ZQ0KaW4gdGhlIGluZm8gZmlsZSBpbiBmYXZvciBvZiBvbmUgdHVuZWQgc3BlY2lmaWNhbGx5IGZv
ciB0aGVpciB3b3JrbG9hZHMuIEJ1dCBpdCBpcyB0b28NCmVhcmx5IHRvIHN0YXJ0IGd1ZXNzaW5n
IGF0IHdvcmthcm91bmRzIGZvciBwcm9ibGVtcyB0aGF0IG1heSBub3QgZXZlbiBleGlzdC4NCg0K
LVRvbnkNCg==

