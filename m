Return-Path: <linux-kernel+bounces-839554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61320BB1DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 23:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20633188B97B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 21:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09E331194C;
	Wed,  1 Oct 2025 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ivw7cOTz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E056D269CE5
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 21:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759354870; cv=fail; b=bd0ppdsO72brbAvFuEU4SbNYO/qC0/9075o4on3z0GwdRUFGKDwL8RLYSboSjDRMS1I2Xwrv80bXOdHGI5/hyOPzrkCEcHKGvjvTQVvpHS501mF1stw2o3ZsZyDiEYBk5t446RsHJb9pIQP01Gvo7oVb+XCOcjdS5pDKYpbln6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759354870; c=relaxed/simple;
	bh=nRCX/vadJGLNryk3NwJUfJvLNlA8dSjfKaMDOBaacUo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uSawW8px0T8rR5nwYfNP1Bwac6U55og1230RArZ4ixumFNcYPW6XoSmJvJtpF9NhhZtDASSxmlsgTjgRBT1MtcEg26T8l5i2ElH7xjc1XBIOvAlD4hMu8AdL+EzBoEQRm39Lh4dM+9c37GT/bbO5wob0JdcWP0Ztiugy+gJQP/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ivw7cOTz; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759354867; x=1790890867;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nRCX/vadJGLNryk3NwJUfJvLNlA8dSjfKaMDOBaacUo=;
  b=ivw7cOTzYLz5DKFDBz0BQl2eULzKEQ2VCWZwDA0AoRl8erk6iRtWlis1
   rycdPIHVsXUxnc9eQqKS1lAryi+8AZOscxfjMbTANpDbwRgb0VIORhDFM
   /1B6It6f7HJxClQQ5ZlWLeecIdwMxmBFUAQaWje4gjb5fHitDqGv1dblr
   UDYuuXtaHAn56Cin+CfU2Jtf+n0bbhDjavCJ0DsVN+2J6ZxJ2zjVSvT6G
   Vm+g9QVswt59CcSvISFWSrwgprayMDl1Cri0d01RsaIURrb8nLbzGnQ4p
   hLLWmYcapNPBXplUiIDX16/mPiw19phsTaU5nz29AUckaTF6mLEPHffRa
   A==;
X-CSE-ConnectionGUID: 3/9BgtZJT2Wr5ju0ADNCLg==
X-CSE-MsgGUID: tqOEh6OKRwifHvDHU2Xyww==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="73068595"
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; 
   d="scan'208";a="73068595"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 14:41:06 -0700
X-CSE-ConnectionGUID: 5gN5UbXpQ8aGT9eLyQ1I3g==
X-CSE-MsgGUID: ErZpuWYpSoKYZdaEXWWCvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; 
   d="scan'208";a="178926569"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 14:41:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 14:41:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 1 Oct 2025 14:41:06 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.41) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 14:41:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRU/TNzL2UpenlCH/DW+1V2ePd4ABNkOKImwklAP0l0FOLMm4vMQ+JUSXExTpr8Lfy4O1kZ3QznWao2L7i5KNVVOw8tC7SXK6Zc9RjK3m0PjVm65+dKqBHdE5FGa5abKwc5DbCcLmmOE/Q+ubimybduyrPQU6svkpX3MBeiwSDdGPbZsltEPOKgRShgR7mtKJAyr+TInBfRfO+W8nMoteTaFmdeGtPEgOnrSh/wlL6cjqdaaYoXYEaOrWAQ4KnKQ+QWV3xtYTBz7mS15nVsOyUNT45AaU0Nuyiql/stnBHQEuxLJdbrwyPoAYZveOY+f0GJ5pF7HEC4OYTtGDTLOyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRCX/vadJGLNryk3NwJUfJvLNlA8dSjfKaMDOBaacUo=;
 b=GolWweVFFfr8/uyTgX/dW49PsEm7V/PUeno4eWJbPiOKZcdC+beYXsFm6G4dPWZw+FMnClbyB4o7D53coMn7g0Hf7pYEfTTMI97weMO18Zj+5aaMnLykbSa0KCweVLZsyszjDjEZ4MgiAnBZrc9YmnV5BDoc7xUdhPpZksJz6J6FFWjBLg3XO9yiOthuWS5G7k4+40QNv5hCJZMm9aP8Zkc+aL55CeMWqRazH4FxXxSx4q6EL0qgdLFWypcxGG4sGSzyujDDuOHGulUKQ/yJsVE0WsKek5k/H3EfZtWf+Rhp4oQ10efcGJ9yhiXbRayFciDes1zC1KAyzE5uECs8tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5525.namprd11.prod.outlook.com (2603:10b6:208:31f::10)
 by PH3PPF0515C3CD3.namprd11.prod.outlook.com (2603:10b6:518:1::d05) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 1 Oct
 2025 21:41:03 +0000
Received: from BL1PR11MB5525.namprd11.prod.outlook.com
 ([fe80::1a2f:c489:24a5:da66]) by BL1PR11MB5525.namprd11.prod.outlook.com
 ([fe80::1a2f:c489:24a5:da66%6]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 21:41:03 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kas@kernel.org" <kas@kernel.org>
CC: "Williams, Dan J" <dan.j.williams@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
Subject: Re: [PATCH 2/2] coco/tdx-host: Expose TDX module version
Thread-Topic: [PATCH 2/2] coco/tdx-host: Expose TDX module version
Thread-Index: AQHcMnp/jKWYw+n9jk+kyWxP5S88frSsriSAgAB5ggCAAKuMAA==
Date: Wed, 1 Oct 2025 21:41:02 +0000
Message-ID: <4619ca4ec7097678b387e003c76f44c879524a88.camel@intel.com>
References: <20251001022309.277238-1-chao.gao@intel.com>
	 <20251001022309.277238-3-chao.gao@intel.com>
	 <e4041d4706fe55d3d012144680d9be33acdda19f.camel@intel.com>
	 <4ukjpckzgbfyef7wrajivc6qzw4ycdudmqdr55rbcz6fsecv5c@yovyjdmhs4tg>
In-Reply-To: <4ukjpckzgbfyef7wrajivc6qzw4ycdudmqdr55rbcz6fsecv5c@yovyjdmhs4tg>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2 (3.56.2-2.fc42) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5525:EE_|PH3PPF0515C3CD3:EE_
x-ms-office365-filtering-correlation-id: 386bd974-7428-405c-0896-08de01333829
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?clVBWTR5Mm5zTVZDUXlSTGdLNFgwdGJvM2hMdGJGVy82eWpndUhYUFQ4ZGJp?=
 =?utf-8?B?OVpzNXdWL1cvQi81YWFWY2hHaUF0OThGakoyWVRIQ0hJQzl0ZWNCNVN6RGhr?=
 =?utf-8?B?RFBQR2VzbU9jcEJ4Yk8vcjlmczBmKzlrd1Y1NUtWVll0ZWpTdjFWZHhmS3RN?=
 =?utf-8?B?ZFZTR3dPc2dPY2s0VW56VUxUa0RSOS8wMStJV3FnV3dEQXpwTmF2N1hhNGEz?=
 =?utf-8?B?K0xzZFRkMEJ5WWkxOW0yU2NGSm8yMGYvSUNEWk1CM1J2aGZubjdiczNIWmxG?=
 =?utf-8?B?SmZGdDVnUkQxaXRnbnd3VC8yeVN1OVV6RW1VbHdBdUpBVHU2VnJ6TFMwR1J0?=
 =?utf-8?B?bDBUNElqaENTMHNaRTdDZ1NtUmhIUkJZb2ZOcjVIQ08rYTJEWnZXTzB0VlFu?=
 =?utf-8?B?b2ZFMm1Kc3hQTWtFZFVSazFaTFlkTG1PU0NISVB2V0czWnpxSVNwVjBaWlcw?=
 =?utf-8?B?SEs0MjBqWEk2NU5pSU1WWnZub1V4a2lNMlllRHlIZS9JblZnMWVEeTA1cUht?=
 =?utf-8?B?dkQyY1NyRHRVZmQwNE8rOG1YMml5QjVKdDVneXRPUmxxbzFZT2xqbmZucXlo?=
 =?utf-8?B?Kzc3K1QxUkxWd0JCZzFHNHZIaTZ5Slo3eXdDVXU3ckFRNlNZaC9EZUxpR2dO?=
 =?utf-8?B?dkVuKzdDcXp1Y085OFpkNmxQZlU1TVRmVWt2UW9nREd0S3hLVXhueFR1TEt0?=
 =?utf-8?B?OHY0b25qNFYrSTVKdS92UW5jdGJPbjd4OXpCR2l4TlFYRnRISjdSVFVFVEJ2?=
 =?utf-8?B?NGpoZ0MvMjk4bVQ4K1VVeHZUM2hkYW5tS0YvcnBTeUJKQ05HRStjcVNqS1FF?=
 =?utf-8?B?Y2h2S09BUnEvRk52dnIxY0xLRm9WRzg4aEVab0NTL1dSWFM1OWgrZThhNDdT?=
 =?utf-8?B?ZmN6VmR0dnFkcXFORnZIcjQ3R0J3K2VlWWc4U2FzUmtOakRrTTZLdDJGMUxK?=
 =?utf-8?B?K0RybFhRR1dXaHJoUUtzZklGeU9uOG5LTlh6TitCM0F1MWgxZFZUTE0zK3V6?=
 =?utf-8?B?b0NYTWNPU3FRZ01MZytkSEV0ckN2ZlFlVW81bExqYllkTDd0V0hobCsyYXFj?=
 =?utf-8?B?SUVJOHhZbm56c0VubFVqNWpVSll4TzlRem4zOCs4UGlLNUVhVnN4UHBxcENj?=
 =?utf-8?B?YjAvekx1aC9yeEo5UmVhekxwZUlpVXZ2cmE0ZTdaY0RJaldiRDhVZFN4YmRB?=
 =?utf-8?B?TkNsNWVqZjQ4NURvSkJqeVptYzROZUpKRFZFWS9tQURnZ2pJSURuVkNLckEx?=
 =?utf-8?B?bjBETExUTVd0NWoxMzZBQjVXanJtQms2OE9YM0lUVFZJa0lnZ0hxSVRFYUwz?=
 =?utf-8?B?Wkl5ZUF4bTdCTnQwSVg2bEJQQlNFUk5ZRWpHcjlndVg0M3RldXlTYXNQWHRq?=
 =?utf-8?B?bGl2NkM4cGNMazZCYlhPOGlZaFhTZ2hlc204MEFvU1haZitMa2RhQkhyRFJ0?=
 =?utf-8?B?K1k0QjdFd0hONURLV3BGUnorSXNBV0NZenRwcFhFckVrS0Nrb0l6UFNRSjdz?=
 =?utf-8?B?TjBGZkhYSGZiS1NKKzFNQlBDenJ5anRiS1BqSXlBazJXaDREQVc5L3dQbytn?=
 =?utf-8?B?RVZGcXhsN3U1ZUNGK3B1N3BCZGtXMWEzODNndXhNOFk0dmR5Tlo0elZHUkZB?=
 =?utf-8?B?ZFdTa0hlT0p6eUZhS3ZoK1k0c1lTZVFPYjY0Nzh5SFB3Rjh1VFlsWlI5UWY3?=
 =?utf-8?B?bFQrWDd3dmtNNCtoTEVsOTRueVpsQ2ZvVmhEV0pZMW5uTHI5R2FjcTlTbG1I?=
 =?utf-8?B?bWxwTGpEMkNjdDNycnFVZnpodm5OUy9vUTRMcUdJOVZmb1RUUXBPSnJqWXpQ?=
 =?utf-8?B?bVlqTlVnT3FRaXlBL2QrdFFsRFdwYlhQRktZbm1aSlZ0QWtQa0VLaEpzT3dF?=
 =?utf-8?B?Nm5MbjRMMVA4N0lzRU5xbDhXbjVvYllXM2J3engvaWpUR3NUaGxqRmFiZU1p?=
 =?utf-8?B?a1dzUU5XVkVVbThFOUt2Z3BKZ3ZOdElXVnFYaHRrUGNmQm1kYXUzZkd0ZW9N?=
 =?utf-8?B?RkpiQ1grUXcvaEkvVXE1ZndFNm40WTNSeFMwY0ZSZ0xaVTV1OWdkTzdhMTRW?=
 =?utf-8?Q?L6ieaU?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5525.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wm1JUU1kYjNjMldPT1NUVGJYRm9NdE5QSTVVYU0zUjhzQmFzZnUwOUZOUmJn?=
 =?utf-8?B?b25XNDBya1RTb2hFSDVxZHZSeG03MktFbFhBTmxvVWZTSTN6ODNEa1pyWklv?=
 =?utf-8?B?TGRxa3FlbFh5SlNwME5jSFoxQjBhazA2dWFYbWxESENDTkFqbTJnRkpDeEJy?=
 =?utf-8?B?V1Npc05qdWc0RFJjd01qRlZXVUZ1R0ppM256ZXR5UG12ZDBRV2lnbXNuQXU1?=
 =?utf-8?B?R2NxbVVBM1JLeXJEdW1mbWJ1dXBDNWlwcjNleCt6TzZQUDdZNXdSOTdtSnVy?=
 =?utf-8?B?cGpUTzJMQWpSOC9maWEzR0hvVFI1emkzVHVuZlh3czl3QmJXbmJVZXdsZlhP?=
 =?utf-8?B?WjZrbTRaTGJ1d0NOVmRwUkxLZHAzb3VmckZVN0FleWpDdUhFeEdDRGVuR1FE?=
 =?utf-8?B?SnBMbHphWDNOeWdBMitpR0FseFd5OUNBNGtFOTJHNlNXMXNHSGJ1MTJIKzFw?=
 =?utf-8?B?QVQ1TkVwYTJGRzBnekFKNU5vci8ydTRvSmtjNW5va3ZJc1JXcS9BR2M2K21K?=
 =?utf-8?B?b2pLS1RJNXdvdmNtREtMWFVDdmtEK3FmWWxPM0o2N1VoaXJyR25YUTNZQ3Fi?=
 =?utf-8?B?S003WVQ5eE5raDBYamhTS1R5YjNFbXk4Ni9zb0pUaGZSMkxBTXdWYlBubWQ2?=
 =?utf-8?B?Y3RvckhrZHIrMWp4MUlLRTRGTW9JaHdEUytHRExIZzhMSVY5K0FLaE95YjNP?=
 =?utf-8?B?eDUvY2ZxWjJJUGdjTEc3clViT0xac0hlZW9uby9oNzRvUGpnSmJHT2MvY0p3?=
 =?utf-8?B?b2hoSEU3cEZYUTlhVDk1aFZ6c1lLSENvOHdRaFFNby9Lb0xHTTc5MFdyTVh2?=
 =?utf-8?B?b3pqSHhNZ2ZlNWpaUktDb3dXUlAwZkdZOUlYcG90YUFXdFN4eXpGUlVNeCta?=
 =?utf-8?B?Skl6RENROHNkSEdxVmtOU05qNnNwclVRYklzYkhRRng1Y0tqOERxSHlRSlZC?=
 =?utf-8?B?QVY4d3dROHU5WUtYMDdrZWFpUTNERTNqeDdVeG5LMjUwY2R2NnpERDVOWSt3?=
 =?utf-8?B?QjI4Wi9tRUNZRmdSMitrby92QWlBVUdaKzJ4bXFaRzVJRlJwZkIrWmFrajNa?=
 =?utf-8?B?Mm92alduQytKOHgxdkZQTXZsbTA1ZnhZM1ViNE1OaWNMZ2hLQXRrenF3S3Fl?=
 =?utf-8?B?eitsWVdiMUhvUmRFbEpIMTZ2NFNNUG9JNDJSdnpyWE80SWc4eklsY0trWTFw?=
 =?utf-8?B?eEdFTlZyaFg4cGZRQzF0TUt1Y0grTWFVTnkvUUdobC81RVVvUWttaUE4ZWNL?=
 =?utf-8?B?YW5xZjZKaU1xVEF1ZFIzd0RBZWV2ZXBWRENqTS9jbk9oWUxYYVhrMWtER2hY?=
 =?utf-8?B?cjdyNm4wZW5NR2FMWDNKV3hXcW45VGpudlIxN3FSL0ltc2krRm9mdVFrMC9W?=
 =?utf-8?B?Mm1hSnJqeDJJelhKMm1Bc2ZpajNrSmpGbzZKZ1JWVDhzZEZDYmcxVk1FUHN0?=
 =?utf-8?B?Rlg4RVFHa2tDWlRRYmh2MHdGSzFha21pNktVS0dwakhsK202L29XeFg2Rm1I?=
 =?utf-8?B?ZWZCZVMvSkFOL3ZFcjBOYnZDMmxxZGRaWjhVbENxTy8reUYzS1NPNUZOWjNm?=
 =?utf-8?B?RTlIUUZaMlpNSHcvcEdXZnJvWjRWU1BNYjZTRlFzU2twMnBITWVkeU0xYlBO?=
 =?utf-8?B?eTg5bnIxcXJGUklyV3lxeVdBR0FxTzNIK2plL3FTMDM0enE3SlNwczBUeDVw?=
 =?utf-8?B?Q083S21YbmNEZE1oM1M3aXF4OVdnZjQ4emdmUUtlMkR2aWJzcFBhSGJaeUN1?=
 =?utf-8?B?ZXpPdndhU3ErSFRqVFkxNlZKUTlSVWJXTzVxdy9qbTBKN1BsdC9iUnhsU2Ew?=
 =?utf-8?B?ZThpZjZVaXBkcE4vYmRHQWlQVVp6b1JsQjVnV3p2U2Y5MExWckNvaEZKOVV1?=
 =?utf-8?B?UUdkNlJpeGNDcnMvcmFFc3BZY2tqdXlqeTdxZHdPRlVwMDAyRmdvbTBtMjg4?=
 =?utf-8?B?c3M0SXR2eU95NU1HMlBLUDVISkE5YlFIbEU1WTlPRnRBOUNRalJsZlNZT1RQ?=
 =?utf-8?B?UFlpcFV2Y1BsZnVUNEVRRE5Lbk1nR1NvdmlPUkdaZ0hNRVNlZnBrRUdEOUJL?=
 =?utf-8?B?TDJKNDJ5MVFoNk8xdWg5bkNIMDgyK2JGNzJtUCttbHY1TmZzK3RCbmJXVm96?=
 =?utf-8?Q?K+RwqZ09zzLbD3DouA9KNcQ9m?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA8CCFAFFF87614F977AB8B59EE28C6C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5525.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 386bd974-7428-405c-0896-08de01333829
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 21:41:02.9972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lAAf+RdaODmg45L6X+oGx5iHGL157ZWSHbJW1IS/Ay1J9SegJZZl+XQXKHeyJNd3ggUfDzqKgmxf75/a5vjGwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF0515C3CD3
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTEwLTAxIGF0IDEyOjI3ICswMTAwLCBLaXJ5bCBTaHV0c2VtYXUgd3JvdGU6
DQo+IE9uIFdlZCwgT2N0IDAxLCAyMDI1IGF0IDA0OjEyOjEwQU0gKzAwMDAsIEh1YW5nLCBLYWkg
d3JvdGU6DQo+ID4gT24gVHVlLCAyMDI1LTA5LTMwIGF0IDE5OjIyIC0wNzAwLCBDaGFvIEdhbyB3
cm90ZToNCj4gPiA+IEN1cnJlbnRseSB0aGVzZSBpcyBubyB3YXkgdG8ga25vdyB0aGUgVERYIG1v
ZHVsZSB2ZXJzaW9uIGZyb20gdGhlDQo+ID4gCSAgICBeDQo+ID4gCSAgICB0aGVyZSBpcw0KPiA+
IA0KPiA+ID4gdXNlcnNwYWNlLiBzdWNoIGluZm9ybWF0aW9uIGlzIGhlbHBmdWwgZm9yIGJ1ZyBy
ZXBvcnRpbmcgb3INCj4gPiAJICAgICBeDQo+ID4gCSAgICAgU3VjaA0KPiA+IA0KPiA+ID4gZGVi
dWdnaW5nLg0KPiA+ID4gDQo+ID4gPiANCj4gPiANCj4gPiBbLi4uXQ0KPiA+IA0KPiA+ID4gK3N0
YXRpYyBzc2l6ZV90IHZlcnNpb25fc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZp
Y2VfYXR0cmlidXRlICphdHRyLA0KPiA+ID4gKwkJCSAgICBjaGFyICpidWYpDQo+ID4gPiArew0K
PiA+ID4gKwljb25zdCBzdHJ1Y3QgdGR4X3N5c19pbmZvICp0ZHhfc3lzaW5mbyA9IHRkeF9nZXRf
c3lzaW5mbygpOw0KPiA+ID4gKwljb25zdCBzdHJ1Y3QgdGR4X3N5c19pbmZvX3ZlcnNpb24gKnZl
cjsNCj4gPiA+ICsNCj4gPiA+ICsJaWYgKCF0ZHhfc3lzaW5mbykNCj4gPiA+ICsJCXJldHVybiAt
RU5YSU87DQo+ID4gPiArDQo+ID4gPiArCXZlciA9ICZ0ZHhfc3lzaW5mby0+dmVyc2lvbjsNCj4g
PiA+ICsNCj4gPiA+ICsJcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAiJXUuJXUuJTAydVxuIiwgdmVy
LT5tYWpvcl92ZXJzaW9uLA0KPiA+ID4gKwkJCQkJICAgICAgIHZlci0+bWlub3JfdmVyc2lvbiwN
Cj4gPiA+ICsJCQkJCSAgICAgICB2ZXItPnVwZGF0ZV92ZXJzaW9uKTsNCj4gPiANCj4gPiBOaXQ6
IG5vdCBzdXJlIHdoZXRoZXIgdGhlICIldS4ldS4lMDJ1IiBuZWVkcyBhIGNvbW1lbnQsIGUuZy4s
IHdoeSB0aGUgJTAydQ0KPiA+IGlzIHVzZWQgZm9yIHRoZSB1cGRhdGVfdmVyc2lvbj8NCj4gDQo+
IFRoYXQncyBob3cgVERYIG1vZHVsZSB2ZXJzaW9uIGZvcm1hdHRlZDoNCj4gDQo+IGh0dHBzOi8v
Z2l0aHViLmNvbS9pbnRlbC90ZHgtbW9kdWxlL3RhZ3MNCj4gDQo+IEkgdGhpbmsgaXQgaXMgZ29v
ZCBpZGVhIHRvIG1hdGNoIGl0Lg0KDQpZZWFoIGFncmVlZCENCg==

