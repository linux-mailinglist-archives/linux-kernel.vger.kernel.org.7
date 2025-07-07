Return-Path: <linux-kernel+bounces-720659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B6CAFBED4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 01:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07CB44231AB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 23:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935A128BA9B;
	Mon,  7 Jul 2025 23:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hWr1TRNx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E217521D5B5
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 23:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751932783; cv=fail; b=PavYFG1qBDSybDURSm0NB1T5O8EMq4TNCZfC7LO26A9hAx6HBuRDBEEh0gWKoD3EIVHMtWBcKbBxKU3g1eYe3Cz3XU66m+AVnM+hZLn6w5dVOYFx8zrJ+hNIRX4jj962uk/5t/vKfH2rVHAJOsnfDfQvKGNEOQIKvHiED92OMRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751932783; c=relaxed/simple;
	bh=hPmjzhNrdqytxR+J18JTElkny9Uu3PCzJJswhaLPap8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BvrVGczPDpbZXJme1L5KRyMBnPP9UYjP1DN1yx8jtD8aHVR0zADSvyCcrCulsoVSXWltlGl1FW0aWqfLBFeVuwLsQnyyZ5CItcL4jXMMQh7lzUvX5vwFyAnhjl7S8ZcuQLdarJiAQMBS31cA7b1ahOgJY4u7PRgmGsbjyTpAYHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hWr1TRNx; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751932782; x=1783468782;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hPmjzhNrdqytxR+J18JTElkny9Uu3PCzJJswhaLPap8=;
  b=hWr1TRNxcC260p8n8S4hh2dPdK5rHASqrL/8YGCdAWDyv+TazNU6Ogk2
   cfUJoRce0fZXkR8mNtdA2eKNFlRizArbQGvGLBaEgeSeqpm5ykzg2E7WE
   +9j2kUzv8zFmPgcTkleumB2npmM79BajABZZZczpAnMcNktr7AkezHOFG
   DJK1skRiR7aWRfeEPkQ40q8gtFF3pJxEGnJTrHHIwrQXTP0DpibKqEKy2
   qCsE4PvnRix16ESPK5SMbrmGO8fVgGLHsgkFfxqdbtml79CIKQeZgCm+c
   RM/dx3CLjjYInUKzQtSIw+FPOlTsmvumlR8bIq4eMjVr+50IypklfwRtO
   Q==;
X-CSE-ConnectionGUID: 1i0mgPGjQs2GCi5spt40cA==
X-CSE-MsgGUID: ODC8qmupQE+eaFb5zEb7pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="57932283"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="57932283"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 16:59:38 -0700
X-CSE-ConnectionGUID: 0eS/PbRSTIajKQBeJ8FAFQ==
X-CSE-MsgGUID: w3j/v5vVQIiUCzA/CDVwOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="154750704"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 16:59:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 16:59:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 7 Jul 2025 16:59:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.84) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 16:59:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bEmiCCegKJDQ4oSUSkB9DAo/mZUdjjK3cwCHlz0YM/vtsiJwgeE1uBgfCPrupnBXbnC/SbV4Y9g/pm6Dg4XlFgfAjf8MYl40+CmXbBaegrjc/JrQZiU3yEzIyIIkQ5bj521wfT8dBmzQx2M/xKHyDJKUaCw18etRm5aKQhnbN1KM11WGDZtQmPJjP1I9NVaj+INxsA5HsoiV6De4u2Y8qLtDrhTO/72NluxYxwCIBKL0o5dzXTlLqKxHRzXSfDTCyXzsMp16g+94t3G25zoNKVlYJvIky5BMp5JeMJUgE6Rvqiy85apnF2qtlWFHPQm/T8yzs20836fJJqS1bo0niw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPmjzhNrdqytxR+J18JTElkny9Uu3PCzJJswhaLPap8=;
 b=jVGeri8JG4hTKWEHYVs/KMOSXRo5viX/Y2gxv0Au/HVoJTGZCF2yjGsIFBIVU0sekDCtxWfTocX2KaMCHxd1oyymnhYEd8BPWKsnP3D2LFaQpSD5UP5qh7EnQukGPsf2NmVL8g/BNxKhkd+bggS8iRJAkv3rxvsM8wLCICFV8d9Q7nlP5W02Ifjm+at4Ujd2uIzGREHhWg4EZFAgIbN4t8oH7hAkf272R4nk1FgSa+p+qa4Hd8xh5xGPPyb2W5PJ7skZLylydaO5FeNzkW/8+1OmL1knZhMwi+1stckMjoR60QAESLO4sMRnWkbzRdfsesLXTr6QrEKCrQwZcpdo0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB8121.namprd11.prod.outlook.com (2603:10b6:510:234::14)
 by SJ0PR11MB5940.namprd11.prod.outlook.com (2603:10b6:a03:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 23:59:34 +0000
Received: from PH7PR11MB8121.namprd11.prod.outlook.com
 ([fe80::ec4e:64cf:cf1f:daab]) by PH7PR11MB8121.namprd11.prod.outlook.com
 ([fe80::ec4e:64cf:cf1f:daab%4]) with mapi id 15.20.8901.023; Mon, 7 Jul 2025
 23:59:34 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Nhat Pham <nphamcs@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosry.ahmed@linux.dev" <yosry.ahmed@linux.dev>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>,
	"ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v1 2/2] mm: zswap: Consistently use IS_ERR_OR_NULL() to
 check acomp_ctx resources.
Thread-Topic: [PATCH v1 2/2] mm: zswap: Consistently use IS_ERR_OR_NULL() to
 check acomp_ctx resources.
Thread-Index: AQHb73udiwxSkj470kS99fTK0TgNN7QnL1AAgAAl3lA=
Date: Mon, 7 Jul 2025 23:59:33 +0000
Message-ID: <PH7PR11MB8121BAECEF741F0D9AD8AF33C94FA@PH7PR11MB8121.namprd11.prod.outlook.com>
References: <20250707201315.9497-1-kanchana.p.sridhar@intel.com>
 <20250707201315.9497-3-kanchana.p.sridhar@intel.com>
 <CAKEwX=OLk308EDSc4ApXnuQYbR4_-Vi9Ca9rJ3dgRwV+Airz_Q@mail.gmail.com>
In-Reply-To: <CAKEwX=OLk308EDSc4ApXnuQYbR4_-Vi9Ca9rJ3dgRwV+Airz_Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8121:EE_|SJ0PR11MB5940:EE_
x-ms-office365-filtering-correlation-id: e2f97b26-6e8a-4121-ee89-08ddbdb25256
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aGY0czQ1N2tYSzdxcXI2L1NEN1ZMS21zMTdxeHd4L1VNS1gyU3p0Y3dmNjAr?=
 =?utf-8?B?aVlEbEp3ekFzK0tFL0NoSFk4UmZUT2FPWHlJTDhPdU55WUdEWi9lVG5UZ09T?=
 =?utf-8?B?UmxaRDhtOTNnMHB0N1o5Mit6TWNhbnFHbzJzaXpWTHFYdkRJbmtubU9MaWkr?=
 =?utf-8?B?aHBxcWhoYk1FNnowWjZFYWJDU0IxVnozZmJNaDhQaE9YUVI1eHVReXVGWFVQ?=
 =?utf-8?B?WE5yYnZJQUhwUEFFNEliTlltbklZZ1JtakNEQW9HSS8vUnNkRGM2ZS9YdEtH?=
 =?utf-8?B?U1p4dmlaNGxST3d6K0d5UlhGQ1AzZ3BxTHNQcmo3Z3N0cmU0Q0NzZlZ5Unh0?=
 =?utf-8?B?RlRBcUVWbTRrQ3VwYUVHeEV1dFVtYWVJSVZJOUxSYUtsbCtCK20yWTNzOFRH?=
 =?utf-8?B?UkpBc1JQcHV4bk5qRkIxVXFLN3Y3VnR5b3FhcCt4VzltajNLMWs4UnVQRUlv?=
 =?utf-8?B?Q0JYdGZkY2l0WDlualA1Sm5WbU9kRVBkOEJKVnFVZ010VjI0QXlTMVhrbW1j?=
 =?utf-8?B?MkxnY2V5N2x3dndibjlGQjR1a0JCZjVObTN0UXhLbW85VVZobWVpbGhpN1FI?=
 =?utf-8?B?cS9NV3JtYVZxcUVYa0VseU9HWmdVZXlFcWlJWjA2b1RmRElaZllMOEVQMmlv?=
 =?utf-8?B?Mkd0dUpiUmJRMkdoUGkyc25vWXRmTU1PMkhZRDFBekNXWGhybW91cTVKSkMz?=
 =?utf-8?B?S1N1Wms5Wm81aU8rTWNCZXExOXRnbjRtakUvR3pxcjlXWGN3N0c0VytCTWZ0?=
 =?utf-8?B?eWpOd1pKSzFtcm53WGZWOW5uaTVQV1lkT1hPd3lTY09nRjBEaFFzMEk0eGpJ?=
 =?utf-8?B?K2Q4Mm1kenNXcGp1bzFPd21YVlQxblVseDczb0oyUCtrbjB3MG1mVWp5T09y?=
 =?utf-8?B?U0FxcVBHUkM0QmFiRXV0Wkw3cDZPUE82dkthOXg0TmJwTUErWmk4bjcvMzhq?=
 =?utf-8?B?dTdEb0Uzc0ovMk9vY0FHQnRZbjRyZGN2a29QaTllNjI4OVRITUNNbFk2Ympy?=
 =?utf-8?B?bDVNQ04xT3g0UXZUWFBQT29rdFB5REhxNTRUMlpQSFdkYkpXQlpMTEJoelRy?=
 =?utf-8?B?aG5lNGtDV0lBT0FGeVhqQzhqZjVHYjNmaXpHSi9CeXVYQUpJalVkYTk4TzFL?=
 =?utf-8?B?aTQ3TCtDN1pETFNyaVVaY2NDa2NVeFhRNVhqUFRsZWdTRFFiOHVKTm1wYW9G?=
 =?utf-8?B?V21FYlBxNkdzVEQzMWRnWFlEeU4xRTJvYWRqMUVMVmk5R3VMKzBRSGhheWpq?=
 =?utf-8?B?c2xFTkJPcEdHT29jQU5ZdlFHL1p6TXpweWhOQkUzUXNPTW9RWFVYMnF6UzdQ?=
 =?utf-8?B?N0FJQXRNRGU2MXJjY2tCUjhxVW0vZW9jQm11UVF3VHNzYlZRSlMrUFZZekFN?=
 =?utf-8?B?aVl1TFJueEliYkJ1bFc5RllWU1FnOEZvcUdrRFdzenRUc0M2TjZVcytZdUIy?=
 =?utf-8?B?VUtRdW9GWjQySGtPU1VpTEUvdUZra3oyNWphNVF0YXNYdG9PY2h0MytyLzZz?=
 =?utf-8?B?SlFveU13UmFScGZCcFpzTFhGUHNXd2ZUTW9RZ1RWVktaODNyUmNqYW11Mlpk?=
 =?utf-8?B?dUZkMVRyR3pUSTFuTmlldm5GVUxqaDdVVHRmNDJ1SGJpSU5mMkZ6cFBiU0RR?=
 =?utf-8?B?akZTWWd2eG55OCtMQ2M0S0lVTzNja2pBUVhUQ1FYVmE1MnBJdkphK0NSaWdD?=
 =?utf-8?B?SUtsVVIwTDgwayt0cGNkUVg1N0tvbTZPdU5UWVFFWXpxUk1nNEFhei9NK1p3?=
 =?utf-8?B?SllmZHBxOXA1Y1llaGVoM1NSN1ZrZjRyUkJPelo4TUV4TzJuSE0xY1VtTmEx?=
 =?utf-8?B?YkxVL2xFK1RET3ZqWmwzblltMkRVSGVnbVVFMTJBU3ErRVc4OTkzdkJ1cy95?=
 =?utf-8?B?SENNc3FNWWVtQkxtY1U0VzRvL0ZaZEM5WE1WZ1VORFdmdFUxUkUwYnRxOHVD?=
 =?utf-8?B?dVhRMHp0RFhRRXo0akdkNm11bXRucTl2WEQ4eitpUlk4K2VOMjBuclJPeEE5?=
 =?utf-8?B?RlNkTitQTVJRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8121.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzNaVGdOeDRFVjAvRFJNVjNjeWJ0RFBTR3JKRHprZ0JWQXB1aFY4SlBYUXFM?=
 =?utf-8?B?VnR3R2czU0lZUEVHcS9sVGdFWndRWDNjMm54NDJYeGMvbjc4ZXdCVmNsN1h5?=
 =?utf-8?B?NnNrejF1SVRnOWdBR3hMQWtLVDhoRHdpKy9UaVEvSDlldDA5WUV4MDdiTzJu?=
 =?utf-8?B?YkQ0VEFQNDZlSVZjaTZHRUViRkRscWxLdmRiN0dzQy9FSkJUcXlOWXZLVDN4?=
 =?utf-8?B?ZklScUs1dnFSYUR0YURvSURWUkFsRXVkRHBEeFQrdWtvdm9KR1hpMGNjYXFZ?=
 =?utf-8?B?MmJjYkp3cnlESXRYcFg0SG15em1qRHcxT1N2YXJkZXB5NFF5THgwRE5XdCsx?=
 =?utf-8?B?SkptUVc1OVA0SXJyM1hxWk5Jdklsb2RRQzhWV1lMM1doOS9nbjcyTUZ3bXlm?=
 =?utf-8?B?S2k3WWpOSkJzb2lBVU1xa0wwQU1XME1Lc1lrVzhRNVJNUUlRZHlqS3p6MzJT?=
 =?utf-8?B?aXdDc2dFOWRKRVR4QWNISzVsWjZxWnREbmJOMi9GT1FiUy9jOTVwUElndFZV?=
 =?utf-8?B?NWJ6L1gvRWROdHlaeXBZUmNadEFEM2x5K3VDTENuTzZRYWZ4bFMxYk1FVFM3?=
 =?utf-8?B?VnZ5bGQ2RDkyTW50MUkzc2FTS252YmM4RjZubHNVMEVyWXJqM29DQVRnYjF3?=
 =?utf-8?B?elYxeENPK2duTGZzUzZ5SEc2blF6NW5kai9Ka3dWSlF6SGVvS0F1WEk4d0c2?=
 =?utf-8?B?YmErMXFwbDFlS3dqUjZobzM5K3pzd0hpbzJxd0dUMmdSSEIvcnFicnNSWWxJ?=
 =?utf-8?B?MmJrRnFnVElxRU1EZlM0L0dudTdPTUM5MkR6a2ltYkd6N1pjbTMyZkF6UjJH?=
 =?utf-8?B?UWVYUzJvajVqR1Q0UnZxU29SSnlqZ3FlOTdsUnFFQTF1MHE5dUFaTDhJYktF?=
 =?utf-8?B?ajVhcjA4bENoSEx3WmdsME9GR0xrbmNCM1FHbHFsN2dIcUlWbE9yeVNtZ0Fs?=
 =?utf-8?B?RGJMc0tKL28xcjRRdnhYYUw2ZUJXcU94QkxkVHlKbFQydjBDRWZTbytvYllZ?=
 =?utf-8?B?Y2liZ3V3eit2SEtBNHIzQjFGRUtPUk5KSVhtaFEvRWRQTEx3TEFEaUxDYm9n?=
 =?utf-8?B?WVY4WmxuU3V0bUVxWXdwVzlXWXhiRUpPVCtmTnNaNFVSZ2VpSTY4MENBZU51?=
 =?utf-8?B?WXhvQk1YUmNvUmpiM1NYMVZKTU9oeXI2L2xxaVlYYnhNc0FCNXF0MVp1V29C?=
 =?utf-8?B?Z0F1SW8vZGRleWNsaEJCZXE3c3pNOCsyUTU5TTFwakd3TkxaTUNOeVp0MVlp?=
 =?utf-8?B?Rnd3NGZGckU1S0l2b1loUXB4OUZRNmI3MEFvR3dvOHFXRFpPVUtyeWROS1FO?=
 =?utf-8?B?SkJZZVJtS1NBUDZiRWc5SXVlVnhSRGRFZ29XQ1pIN0dka0NUMG02QStSMmxE?=
 =?utf-8?B?ZVE3VnhSQlduWXpBUzlUeXlwdkhZQ3pjU3JsT0ZEUUtTU1daTWd0RmNxeHhv?=
 =?utf-8?B?LzRyOUtMNWFsQnRSMDZHTGVJVkdFdU5kUGlpNGM3dWNwUVlEYXZ5T1YzdFJG?=
 =?utf-8?B?VEdBSUsrWWFsQXN5clkyNVlaOVFubUdPOUtUUExScjF6SnI0RFBldlpmUWFP?=
 =?utf-8?B?aVY2ZHpPRjYxZXl6dEVKaDNxK2JscFBDTXpPQ21LWmdXdXRtRUx5SVU4VDJ5?=
 =?utf-8?B?TTdSRXZnMzJpN2RBSmI2cGYxNkwxUlVnOHUrVXZubFR6TmlIdmxjdlduSGJq?=
 =?utf-8?B?TURjbEtkQ1RhOHcwVEllajRzSWk3N21mOGR3S3o1ZU5Zc0xtUkcraFZwZTR0?=
 =?utf-8?B?Q2J5YUoveUVZL3g5UHNpUnV6NmgzTWQvZ21CNWZMazY0bkpNSDlNNy8wL0h1?=
 =?utf-8?B?YUVzSVN6VnV1NmRkMktlNVNTZHByeWxmSjE4VFFxOUFuTkRncUdoVmRqVncw?=
 =?utf-8?B?NnVaUkxRdU05UlBLc1Vtdmo1S1hzQUtZZjh0U1RJWEpXb2hwUjB4eGY2Q2ZE?=
 =?utf-8?B?Nk5RUW44TkVwRGZJWFhmOEl2L01jVHVNNjhEL1FiQWt4ZlpUNFFNcUhpK3RP?=
 =?utf-8?B?NWt5UUhvWEUrS3ZKbGtiSlBXK1hNOWFKZmpaNW5EU1VKOXZhK0dQMUw1U0tY?=
 =?utf-8?B?aG04SjcvSFI0bnlRYkJPQnpIRHR6QjA5dUZCK1hXc2l6SHlGU0xTemovUjBW?=
 =?utf-8?B?aEF6cXU0ZEdCa1dXaVd6dnEzcUFaQWZ1VDdyNGdlejlxMjU1UXVmYm84UWVr?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8121.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f97b26-6e8a-4121-ee89-08ddbdb25256
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 23:59:33.6783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZhvNk+Hkqe6YbxxxFSN2tlLsYlg0xR8mzeM5hPe2GdgxQq26PvyRpOLKjtyRxm1S59q9jWfRD7kyV8kfYBoPcPRJIJE+nQyP5HJD3/sBzxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5940
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE5oYXQgUGhhbSA8bnBoYW1j
c0BnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSnVseSA3LCAyMDI1IDI6MzYgUE0NCj4gVG86
IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+DQo+IENj
OiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7DQo+IGhh
bm5lc0BjbXB4Y2hnLm9yZzsgeW9zcnkuYWhtZWRAbGludXguZGV2OyBjaGVuZ21pbmcuemhvdUBs
aW51eC5kZXY7DQo+IHVzYW1hYXJpZjY0MkBnbWFpbC5jb207IHJ5YW4ucm9iZXJ0c0Bhcm0uY29t
OyAyMWNuYmFvQGdtYWlsLmNvbTsNCj4geWluZy5odWFuZ0BsaW51eC5hbGliYWJhLmNvbTsgYWtw
bUBsaW51eC1mb3VuZGF0aW9uLm9yZzsNCj4gc2Vub3poYXRza3lAY2hyb21pdW0ub3JnOyBGZWdo
YWxpLCBXYWpkaSBLIDx3YWpkaS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsNCj4gR29wYWwsIFZpbm9k
aCA8dmlub2RoLmdvcGFsQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAyLzJd
IG1tOiB6c3dhcDogQ29uc2lzdGVudGx5IHVzZSBJU19FUlJfT1JfTlVMTCgpDQo+IHRvIGNoZWNr
IGFjb21wX2N0eCByZXNvdXJjZXMuDQo+IA0KPiBPbiBNb24sIEp1bCA3LCAyMDI1IGF0IDE6MTPi
gK9QTSBLYW5jaGFuYSBQIFNyaWRoYXINCj4gPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+
IHdyb3RlOg0KPiA+DQo+ID4gVGhpcyBwYXRjaCB1c2VzIElTX0VSUl9PUl9OVUxMKCkgaW4genN3
YXBfY3B1X2NvbXBfcHJlcGFyZSgpIHRvIGNoZWNrDQo+ID4gZm9yIHZhbGlkIGFjb21wL3JlcSwg
dGhlcmVieSBtYWtpbmcgaXQgY29uc2lzdGVudCB3aXRoIGFjb21wX2N0eF9kZWFsbG9jKCkuDQo+
IA0KPiBJcyBhY29tcF9jdHhfZGVhbGxvYygpIGludHJvZHVjZWQgYnkgdGhlIG90aGVyIHBhdGNo
IHNlcmllcz8gSSBjYW4ndA0KPiBzZWVtIHRvIGZpbmQgaXQuDQoNClNhdyB5b3VyIGZvbGxvdy11
cCByZXNwb25zZSA6KQ0KDQo+IA0KPiBBbHNvLCB3aHkgSVNfRVJSX09SX05VTEwoKSBpbiB0aGUg
Zmlyc3QgcGxhY2UuIENhbg0KPiBjcnlwdG9fYWxsb2NfYWNvbXBfbm9kZSgpIHJldHVybnMgTlVM
TD8NCg0KVGhpcyBpcyBiYXNlZCBvbiB0aGlzIGVhcmxpZXIgY29tbWVudCBbMV0gZnJvbSBZb3Ny
eSwgd2hlbiByZXZpZXdpbmcgdjguDQoNClsxXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3Jn
L2NvbW1lbnQvMjYyODIxMjgvDQoNClNpbmNlIG15IGNvbW1pdCB3YXMgcmVmYWN0b3JpbmcgdGhl
IGNvZGUgZnJvbSB6c3dhcF9jcHVfY29tcF9kZWFkKCkNCmludG8gdGhlIG5ldyBhY29tcF9jdHhf
ZGVhbGxvYygpLCBteSBpbXBsZW1lbnRhdGlvbiBvZiBhY29tcF9jdHhfZGVhbGxvYygpDQpwcmVz
ZXJ2ZWQgdGhlIElTX0VSUl9PUl9OVUxMKCkgY2hlY2tzIG9uIGFjb21wX2N0eCwgcmVxIGFuZCBh
Y29tcCBmcm9tDQp0aGUgZXhpc3RpbmcgaW1wbGVtZW50YXRpb24gb2YgenN3YXBfY3B1X2NvbXBf
ZGVhZCgpLg0KDQpXaXRoIHRoaXMgcGF0Y2gtc2VyaWVzLCB0aGUgcmVzdWx0aW5nIGFjb21wX2N0
eF9kZWFsbG9jKCkgaXMgY2FsbGVkIGZyb206DQoNCjEpIHpzd2FwX2NwdV9jb21wX3ByZXBhcmUo
KSB3aGVuIGFuIGVycm9yIGlzIGVuY291bnRlcmVkLA0KMikgenN3YXBfcG9vbF9jcmVhdGUoKSB3
aGVuIGFuIGVycm9yIGlzIGVuY291bnRlcmVkLCBhbmQNCjMpIGZyb20genN3YXBfcG9vbF9kZXN0
cm95KCkuDQoNCkhvcGUgdGhpcyBjbGFyaWZpZXMgdGhlIGNvbnRleHQgc29tZSBtb3JlLg0KDQpU
aGFua3MsDQpLYW5jaGFuYQ0KDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2FuY2hhbmEg
UCBTcmlkaGFyIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBt
bS96c3dhcC5jIHwgNCArKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvbW0venN3YXAuYyBiL21tL3pz
d2FwLmMNCj4gPiBpbmRleCA3OTcwYmQ2N2YwMTAuLmVmZDUwMWE3ZmUyOSAxMDA2NDQNCj4gPiAt
LS0gYS9tbS96c3dhcC5jDQo+ID4gKysrIGIvbW0venN3YXAuYw0KPiA+IEBAIC04OTMsNyArODkz
LDcgQEAgc3RhdGljIGludCB6c3dhcF9jcHVfY29tcF9wcmVwYXJlKHVuc2lnbmVkIGludA0KPiBj
cHUsIHN0cnVjdCBobGlzdF9ub2RlICpub2RlKQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4g
cmV0Ow0KPiA+DQo+ID4gICAgICAgICBhY29tcF9jdHgtPmFjb21wID0gY3J5cHRvX2FsbG9jX2Fj
b21wX25vZGUocG9vbC0+dGZtX25hbWUsIDAsIDAsDQo+IGNwdV90b19ub2RlKGNwdSkpOw0KPiA+
IC0gICAgICAgaWYgKElTX0VSUihhY29tcF9jdHgtPmFjb21wKSkgew0KPiA+ICsgICAgICAgaWYg
KElTX0VSUl9PUl9OVUxMKGFjb21wX2N0eC0+YWNvbXApKSB7DQo+ID4gICAgICAgICAgICAgICAg
IHByX2VycigiY291bGQgbm90IGFsbG9jIGNyeXB0byBhY29tcCAlcyA6ICVsZFxuIiwNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBvb2wtPnRmbV9uYW1lLCBQVFJfRVJSKGFj
b21wX2N0eC0+YWNvbXApKTsNCj4gPiAgICAgICAgICAgICAgICAgcmV0ID0gUFRSX0VSUihhY29t
cF9jdHgtPmFjb21wKTsNCj4gPiBAQCAtOTAyLDcgKzkwMiw3IEBAIHN0YXRpYyBpbnQgenN3YXBf
Y3B1X2NvbXBfcHJlcGFyZSh1bnNpZ25lZCBpbnQNCj4gY3B1LCBzdHJ1Y3QgaGxpc3Rfbm9kZSAq
bm9kZSkNCj4gPiAgICAgICAgIGFjb21wX2N0eC0+aXNfc2xlZXBhYmxlID0gYWNvbXBfaXNfYXN5
bmMoYWNvbXBfY3R4LT5hY29tcCk7DQo+ID4NCj4gPiAgICAgICAgIGFjb21wX2N0eC0+cmVxID0g
YWNvbXBfcmVxdWVzdF9hbGxvYyhhY29tcF9jdHgtPmFjb21wKTsNCj4gPiAtICAgICAgIGlmICgh
YWNvbXBfY3R4LT5yZXEpIHsNCj4gPiArICAgICAgIGlmIChJU19FUlJfT1JfTlVMTChhY29tcF9j
dHgtPnJlcSkpIHsNCj4gPiAgICAgICAgICAgICAgICAgcHJfZXJyKCJjb3VsZCBub3QgYWxsb2Mg
Y3J5cHRvIGFjb21wX3JlcXVlc3QgJXNcbiIsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICBw
b29sLT50Zm1fbmFtZSk7DQo+ID4gICAgICAgICAgICAgICAgIGdvdG8gZmFpbDsNCj4gPiAtLQ0K
PiA+IDIuMjcuMA0KPiA+DQo=

