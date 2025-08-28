Return-Path: <linux-kernel+bounces-790787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 963E0B3ACF7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB1E1C85B0A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2142827B4F7;
	Thu, 28 Aug 2025 21:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PSP8FewR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC0621146C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 21:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756417693; cv=fail; b=CXmwPY6mx5ilikCqwP8LMaUZ1N2zgkaSZWZmaWUv1RpIsxJKHNMCduqsvOv+kbzA1wdAPGdtFNH6XWdu010CX5NwmleaQcEtC740wFocoTat71U6SZAjg9c0URLtPHcc/BwT9YPJLejJWxyw6B9vBEBTroVIycPUNUzatDx2d0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756417693; c=relaxed/simple;
	bh=sqIgqiiKUccYbshm6AKH7xLF+fuQy4PVq2mDZtjsEAo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rf8vP4njMTaKHije2ulrRJpLf+AQLkgowPVEFpYhn0MkBK6Y0aR/yr1Cbj2G/bq7zVehlPQzwsABRCjqwSrc4GIHJxSiXyLF1bJH71nvOxHX1v8/M88C96QltEasxJa03V3V3E77pLkhwqZehZ3vdkDHWcbjwp4epKRJcDEv1tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PSP8FewR; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756417691; x=1787953691;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sqIgqiiKUccYbshm6AKH7xLF+fuQy4PVq2mDZtjsEAo=;
  b=PSP8FewRG8MaJSMQtwnuubME88OPLnNUdPyS7v9I6/ukGeOEbI1ZrOo3
   TQhcFEzIhnRZzBl7ZzEk/jhD7RYGBGXI/mUy346+m9cwWKdcSWf/mZFk/
   l/lxqjdZcJeLO47E9SJpfAR7On85bHF/LniUbiNfZPzfQFOI5xrf5fKzq
   wljneMf4tL0ens6gsp+VvdTNlPehyAbSCi2T5FwBmZphoEpaa7MHOlZUI
   0rF57LXY/gq707esWEqvFJatMDH7tBFtTaqdzO5h7OAi57e2kwangLN+5
   IoCR10wL8bMd1V/x3FSH5D67saYmufwvRXhD6uWT9UGcaX1zzmN8A4+bR
   A==;
X-CSE-ConnectionGUID: MMzasgWbRrWZSc3mtoAs0g==
X-CSE-MsgGUID: kBaF05qXQKC4kfDGYH5W6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58847831"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58847831"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 14:48:11 -0700
X-CSE-ConnectionGUID: ttv5PARIR1uUzqM2u9Kq+A==
X-CSE-MsgGUID: GUX1NFd+TYutSvzZj7+lrA==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 14:48:11 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 14:48:10 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 14:48:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.61) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 14:48:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KcufZj96EswIWwudm8mbZWEnhGnw1IpAn8xr1OkeuKJ3A8dSa82ugMKBeKl7PjaPstqj3dOoR+P3lNa/XzbLHzHtfa4c5Lq0reaCLp8V3RhG4WM4thm4/6QkfaMGqM3wSTA1xtdV0FGGh7Fug0Oqopxqjf1XYaoSLRpJCPqZB8og9s8+TbNmkqGvhPphSaRhJXsGSVUX2zW85y3D9Kf1BrgXdFqWgxov3VhuPDsdjwxFQ6uG9YSXyo8GJTK5enmMwSU3J5IRCKtSEpevfApveIk4OUrqWQ9SeHGTs2UKBPyYzXPIVzdYOd0FxyOn4+QZaqA7rA5HCuHUgw4wLjZ5uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqIgqiiKUccYbshm6AKH7xLF+fuQy4PVq2mDZtjsEAo=;
 b=R1DSnxGAKySsdam6Z16n4/NLZBxBmr0u04ZRV74GVdmEJm1TyHEQfN70AbCzoGGx64JQw2o9NJICSY8+s1WbsGizFmr/MW1adPQCXHqZ5+XtBNo6dPBuecFezEKMW0yKRhRZuLT5pX+9uY9CA20c+xfjkfSWNo3uK6rJJZm/8RNN/bLgRZOYkujn4rPf+lIxBeBoEamwlugslLvQQJhggDxOqGlqPoyteUiwii7LoRR5H6ESlDh6a1sqz7HKbHg/fgqMvv5ubq9BvzDKBNg76K6/AsAk4Q4Cv9hkCal43fJJBtJkSc3Wc11Ve4fpvQe82LZLFrwvnQsYmo89S3fPtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA1PR11MB7941.namprd11.prod.outlook.com (2603:10b6:208:3ff::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 21:48:03 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9052.014; Thu, 28 Aug 2025
 21:48:03 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "oleg@redhat.com" <oleg@redhat.com>
CC: "debug@rivosinc.com" <debug@rivosinc.com>, "mingo@kernel.org"
	<mingo@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "broonie@kernel.org"
	<broonie@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 0/5] x86/fpu: don't abuse x86_task_fpu(PF_USER_WORKER)
 in .regset_get() paths
Thread-Topic: [PATCH v2 0/5] x86/fpu: don't abuse x86_task_fpu(PF_USER_WORKER)
 in .regset_get() paths
Thread-Index: AQHcE3q31HuRziJTPEK2T8WL/8xAvrRu3dGAgAAvBQCAAAthAIAETlGAgAMr1oCAAAr0gIACBpMA
Date: Thu, 28 Aug 2025 21:48:03 +0000
Message-ID: <4249e18ffed68e8038624021aa3a6f06b64eeb85.camel@intel.com>
References: <20250822153603.GA27103@redhat.com>
	 <064735211c874bf79bfdf6d22a33b5ae5b76386c.camel@intel.com>
	 <20250822192101.GA31721@redhat.com>
	 <b483759593fb83ec977c318d02ea1865f4052eb7.camel@intel.com>
	 <20250825134706.GA27431@redhat.com>
	 <2491b7c6ce97bc9f16549a5dfd15e41edf17d218.camel@intel.com>
	 <20250827145159.GA9844@redhat.com>
In-Reply-To: <20250827145159.GA9844@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA1PR11MB7941:EE_
x-ms-office365-filtering-correlation-id: b71451e2-e906-43e5-f638-08dde67c90ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dTdCRHZsUE1WeXcvT29PK2M4RWVvN3pjaG82TUNURVJpT3hzMFpvV2U2MHp3?=
 =?utf-8?B?bmZhRVYyUEFsSklNWENreW9SSlVBOFRRNkhzeGhlZUFyb2JjSkdpMmI4TW9Q?=
 =?utf-8?B?Yjl1MzErNVNvZGtaMFAzaExUTkx1dlVheXhyWWRNcmUyTHJuOXR0ODFJbkhO?=
 =?utf-8?B?SmFpNGlCc0YxSDVVakNVOHQ3dHRpY2hNOVZPbHIxK1Frd1FQMy9qMXZ5Vm5V?=
 =?utf-8?B?SkU0ejBGc2JPYkJBbVpXdDdqOURNWDVNejd2aVVUWUQ5UVpSQnBlUk92eDFR?=
 =?utf-8?B?SmNSTjJqZHlKaUI0WWYzeXh1TC90SjRZVkFVeWF4MC9sTDMzSy9YUWo1OEVT?=
 =?utf-8?B?TUdIL2IxNlFKNFk4dUo3TEpXV0JacW81cUt4a2FkK1M0eVlBb0hOTTVqaS84?=
 =?utf-8?B?cW03cjNBdGpDNG01VWdOYWNwVndWUmdPaERpQ3ZkMG1kL01kcTl4amN5bVgw?=
 =?utf-8?B?ZGNQMjJlTHhBRWZmL0dRUGxrejFnRWxaNXBaV3o2V1M4RjZ5emlhNTdEUGo4?=
 =?utf-8?B?WTFzdlB5Ym90bGQzdlNWK20zQnB4Rk9WblhDOEpaZDJLQnZNbk5saytSclBB?=
 =?utf-8?B?V3IxSnlISHFGeHh4YUFTc0FiSFhwZ3hKOWdxMWhqRnRXaU1SV3lNMVYycU5O?=
 =?utf-8?B?eGY4dHVvYW9QUkljMStFZWREcGdjY3NzbzY5VVVPUFJTSmdpTksyTjE4Nkhl?=
 =?utf-8?B?TmpxeU9JT2xhVlU3K2RjU3c0RU5BcTM1ams1bytMNVBVZEUzOHlXU0hFYVlF?=
 =?utf-8?B?NUdtb21ucnV6aTAyc01uY20vODV3TXQ5b1owSmJLMlRzSXVnL2JVNVBBYjY2?=
 =?utf-8?B?V3dlZTltbGJFK0hVZWJkbFQxeGkrVWM0SStLcUpJbTlBQUk2dGhUY09zQjM5?=
 =?utf-8?B?WmFQTUJ4RDk2N0ZsSTdIcGxzREN3ejFzUWk4dEpudHRiOXlJVFpGVkNVb3lP?=
 =?utf-8?B?Q0owcnRYZk1RMHhXYU1aaDVsT0dmRG5GZVFhNFl5WWVpYjRTRUNMaFZMK2FB?=
 =?utf-8?B?b0lpcEIzekwrVGNGRFFVazJmYVFlU1BmQTk5eERCbDNueFhlSmMxUjZyTHpB?=
 =?utf-8?B?Y1F4NGZXMGdKZ1AyaHdGSHBGdnhsVHRaZHFNa1VoS2FXRFlyckY0V2x0cXFL?=
 =?utf-8?B?Q05TMnpJVFhEUG8wTTRoU2habzF1VmlQZUJnZDJibjNLV0VzRGpPWnRIQTVm?=
 =?utf-8?B?UGR2Szk5YUxDZXZuQ0h5ZmRLbnU2YnVsRzY0cHFtVGVpa3hkSEpLN0VwNnBV?=
 =?utf-8?B?V0NlZ3ptUVIxL3lVK1hFL3RyYWkzRnh1SEpSSUpBT0FYWkZwbVdUcnJtVHV2?=
 =?utf-8?B?Y0RSOWpTZlR4VkQ5ODVNNzJHZkZsQ1BrNFpMUVU5V0RVT1Z2blZNays1K1Nq?=
 =?utf-8?B?QldDQWFrOEptQ0I3eWlQS1Y5enR1Z0h5enNpOS9YdWpUNU1SLzlPVm9QUUpG?=
 =?utf-8?B?Rk85ZWRzK0J6Q1M2ckhndDkxOStURzZRY3ladk5kdFQrenJXN1JKU0c1cnk3?=
 =?utf-8?B?dE5xTUVlN2xOSmsvcEpidHRwdHZZUTkxc1pUVWRyV2ZrYXA4YzNuR0crWFNM?=
 =?utf-8?B?ZkFqb1U1WkdsOThzQTh2d2d0NGRtUlpNZEszTFp6VlJzTkFIY1NjaUtHL3ZG?=
 =?utf-8?B?RjdIMExaclNoeGJhYldsRlYzOHpNVkp3bXZmeUtqWkpuK2lHSjVyV1pvOTdl?=
 =?utf-8?B?SVJZUUhuczZ6ZXVWYklXSURKaGlTeitqbkZMNmRnZURDZFlQQ0Z4MWhtcG1k?=
 =?utf-8?B?aU1QQzNOcnVoWXBiZkFydzEzR0R4L0hMUEtHQlpJcWZRd1JtaVJIQWZGUnlo?=
 =?utf-8?B?aFNIR0FXcWtBQ1RBNE05UHRIVEZ4NmpoMm16UlptMVhwbXlxbFYxKzVIaUNQ?=
 =?utf-8?B?dGFXTkNINDlWZXNIWDBwdnpYWGhFd3Z3T0sxZmtjR3FNR25JY1daaTFJRXpQ?=
 =?utf-8?B?ak9RS05oR1g0NmE1Uk1FckRqbk52d21zSERvbk5kMHR6NzVLcklsL3B4aWtJ?=
 =?utf-8?B?eHBUOVdhNHR3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHZ2N3pWRU9XeEpJcTEvMjlIMm92c041ZnBtUzE1VG9jMVBvTFVuUkFUVWxW?=
 =?utf-8?B?c3h3U0tPVlhYQjNWMUd6QU43Wjh3ZHBaSk1IQ2VQMXlqeDJOaTloRjdUTnU2?=
 =?utf-8?B?T0R5Ym5ZMXRhMUpHaUNPaStpdXlZUW9zYk5OUEJkRmNIWE9BSHhSZlVuMVAz?=
 =?utf-8?B?Z2xsbFRFWHFkS0xOQWJ6ZjNNaitmbjJvanFNVTNVNGo1ZlNBMVIwRVUxcXhl?=
 =?utf-8?B?cWtRZnA2QzliRy9OM2NPQXRRRVQrL0NvYnRGcWUxbmtqYUNhcDlrOGE4TC9t?=
 =?utf-8?B?L3orUEdUemJwSUYyT3FZV1BTUHg4RU9mYTBUK0FOdlZHVHJjd0tOMjhJdDZm?=
 =?utf-8?B?MmtCUmVvZTIvMzlZYXU5M09XbFlMY1pKQkFSQllNeHFDbXBYUUlsT05Hdnc3?=
 =?utf-8?B?WCtiVVZ3a3FBSXByb3dCcFBBT0NTRGpscit0VVZOSk5BZkd4SklBeDFkS1lq?=
 =?utf-8?B?M082aUFkSVVMcnUvWElzRUhMQ253WmJBQnVRNDZWWmU3S1c3SG1yVXQ5SkNk?=
 =?utf-8?B?NW54ekZRRFUrMGhXRHN1VzZwZHNDc0tGVURVZ0dnWjR3UGFSZjJmU1lsdGk1?=
 =?utf-8?B?WmxwQkJjZE9rTS95WGdaTVJERVo1S0JCc1d6aG1DdmZaclVJczYyNFpQdVo1?=
 =?utf-8?B?MndRU3QybnBYcFNKbC9TVzBUaXVrTHk0VE5RdnhuMjh4V3Ava3hTSkFwenFZ?=
 =?utf-8?B?ZUttTWlwcDV1em9hWXh1UzdPeWlPcW9CME5XSEhVOUVGWTd4Z3pQZUhGVXFT?=
 =?utf-8?B?MStSZWlReEpBYkUwQ1ZGQVdZR2NQR3FMNzh1V29hV2tRQklnaDEyMkxRdlF4?=
 =?utf-8?B?RVFBRGpvQVJuTWg3eEdnMTFjejREVGRjb0JtM1VzNDllRzhzVUE4N0p4YTQy?=
 =?utf-8?B?K2pGWGdxa3oxUjczSWMzbnQ4TWVoMFF4Nmo0Zm1XbDVDVVl3M1dSaGc4c2N1?=
 =?utf-8?B?R3BJaFJ5OTVlSy9QOXEzQmdQYzdIOW0rM1d4OFVIaUc3Y1dUTDdYclZyL2pW?=
 =?utf-8?B?UHBOZ0RsWHJBWTFNNlI0Vmp3Q3ZNdERBeE93RU03S2cxZGdiM241bWwzT2hk?=
 =?utf-8?B?ZG4zR2xBU2xwTjJtOFNHc0ZNOU41bmkxSHdXOGt0UjI4UVBCUVcxSitsTFU0?=
 =?utf-8?B?azkzclJOMkdBaTgwdDR4RG5KRlpFUWp0eHd6L1FDcW9UdFlGUitEYU1jMmNq?=
 =?utf-8?B?dVFzVUM1MmlMV1poSEdxa0ZqZUF2Uy81dGVBS05Fb3Yxb2lLMXJkd2Z2Y2p4?=
 =?utf-8?B?dkFuR3NnakFWaENPRFE2ZE5PYTZTbnNOODFZamMvMm16QnBUZ0NOc2F3bllV?=
 =?utf-8?B?MTltNHZValRWYytENVdKV1h5UG44VUc0dWVUWFBrMlZuWFB6SHczS3U3dWIx?=
 =?utf-8?B?TGJmOVg5cTV6OWRxRVp6d0VLMmJYbkUvK0tLbVFYMWh6VUI3WEVVUnNLOUI5?=
 =?utf-8?B?YXJ0N2NES0V2RmNJL3ZiWmxYNHRoWmNhZ0MrbDlodXVKWFd1RWdRbXB6T09B?=
 =?utf-8?B?Tm9FL3NFaFQyVkVuM3lOSzNpTW01c1NJcEcrd1Vtd2JLQmhEQ3IwbW85RFJC?=
 =?utf-8?B?VXhYWmJpYmFxcjVDbTJKcERTdWc1WGtwcjV5REdUQUtNMUNoNEduV25ic1JR?=
 =?utf-8?B?Uml4aDNXNFFjMDAvb085enFNSHBrdTNHTy9CcTRHTVdpVi8vbDZUTEdVQWtp?=
 =?utf-8?B?c0ZZa3JlY0E1SHpLR3A5UnAzKzZ5bGdwdnkyT2gyNE1ZcDk4ZFBqYStXQUN6?=
 =?utf-8?B?WXlUbjhIK2ZUMTJ3WVZCZGpFclRrV0ZPMVlCcEIxUFpDNzNidElhTVA5SDZK?=
 =?utf-8?B?TzZ3K0JNY3RXM0NxQktnZ3BLSEZQb3lzVEZCRXpERWdmT2lkOUFFUEx3VjVI?=
 =?utf-8?B?UkVhUzB6Wml2MUhLVTJ6RUh4SG1CNW1PR2I3WkhPWCtVM0ptVmVteWJ6WkJj?=
 =?utf-8?B?c2dCQzYrQWxwTitIbTZKSUFpNDNqZFB1ZjhTY0NySmoydVFRMGJER3dGekRH?=
 =?utf-8?B?RGdjQjlzWXcxQ0hRTkV3MFdSRm8xVXBSenp1VTRrVHFoaENmN0l6UnIrbTRl?=
 =?utf-8?B?Wlh3WjA4dWtVQXQ2cThyd1hQenM2bDdrc3gwNjkzT3U4NEM1djZ0YUtYTHRR?=
 =?utf-8?B?VEo0c2hXUE1GZ3BzSE43NkpqYTJHNVFCRUhVQ0tsQXpkN1FkSW53ZmhIa2xs?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <94BCE9FA78EA6843B823A2B97B521D8E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b71451e2-e906-43e5-f638-08dde67c90ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 21:48:03.8072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mh+W+uwd3khi0L3C7Jr+g9cCslJ+NB6oxPFH2hz2oXB6gtBdjC9CENs29peIdgjTipwFtDbs7dRqN99k/MKiEU0yfMHvJrmNbnCPon5v7Es=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7941
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTA4LTI3IGF0IDE2OjUxICswMjAwLCBPbGVnIE5lc3Rlcm92IHdyb3RlOg0K
PiA+IA0KPiA+IEkgZ3Vlc3MgSSBxdWVzdGlvbiB3aGV0aGVyIGl0IHJlYWxseSBtYWtlcyBzZW5z
ZSB0byBhZGQgYSBzcGVjaWFsIGNhc2UgZm9yDQo+ID4gUEZfVVNFUl9XT1JLRVIsIGluY2x1ZGlu
ZyB0aGUgZXhpc3RpbmcgbG9naWMuIEJ1dCBJJ20gc3RpbGwgdHJ5aW5nIHRvIHBpZWNlDQo+ID4g
dG9nZXRoZXIgYSBjbGVhcmx5IHN0YXRlZCBiZW5lZml0Lg0KPiANCj4gQWdhaW4sIEkgZG9uJ3Qg
dW5kZXJzdGFuZC4uLiBUbyBtZSwgY3VycmVudGx5IGFyY2gveDg2L2tlcm5lbC9mcHUvcmVnc2V0
LmMNCj4gYWRkcyBhIHNwZWNpYWwgY2FzZSBmb3IgUEZfVVNFUl9XT1JLRVIsIHRoaXMgc2VyaWVz
IHRyaWVzIHRvIHJlbW92ZSBpdCAoYnV0DQo+IHdlIG5lZWQgYSBiaXQgbW9yZSBvZiBzaW1wbGUg
Y2hhbmdlcykuDQoNClRoYXQgY29tbWl0IEkgZHVnIHVwPyBJdCBkaWRuJ3QgaGF2ZSBhIHN1cGVy
IHN0cm9uZyBqdXN0aWZpY2F0aW9uIGVpdGhlci4gQ2FuDQp5b3Ugc2F5IHdoYXQgeW91ciBpbnRl
bmRlZCBiZW5lZml0IGlzPw0KDQo+IA0KPiA+ID4gVGhhdCBzYWlkLi4uIENvdWxkIHlvdSBleHBs
YWluIHdoeSBkbyB5b3UgZGlzbGlrZSA0LzUgPw0KPiA+IA0KPiA+IEFzIEkgc2FpZCwgc2hzdGtf
YWxsb2NfdGhyZWFkX3N0YWNrKCkgc2hvdWxkbid0IGNsZWFyIEFSQ0hfU0hTVEtfU0hTVEsNCj4g
PiBiZWNhdXNlDQo+ID4gdGhlIGZ1bmN0aW9uIGlzIGFib3V0IHNoYWRvdyBzdGFjayBhbGxvY2F0
aW9uLg0KPiANCj4gT0ssIHRoZW4gaG93L3doZXJlIHdlIGNhbiBjbGVhciB0aGlzIGZsYWcgaWYg
d2UgYXZvaWQgdGhlIHBvaW50bGVzcyBzaGFkb3cNCj4gc3RhY2sgYWxsb2NhdGlvbiBmb3IgUEZf
VVNFUl9XT1JLRVI/DQoNCipJZiogd2Ugd2FudCB0byB3b3JyeSBhYm91dCBhbiBleHRyYSBzaGFk
b3cgc3RhY2sgYWxsb2NhdGlvbiAod2hpY2ggRGF2ZSBzZWVtcw0KdG8gZG91YnQpLCB3ZSBkb24n
dCBuZWVkIHRvIGNsZWFyIEFSQ0hfU0hTVEtfU0hTVEsgdG8gYXZvaWQgYWxsb2NhdGlvbnMuIE90
aGVyDQp0aHJlYWQgdHlwZXMgYWxyZWFkeSBhdm9pZCBpdCAodmZvcmssIGV0YykuIFNvIGp1c3Qg
YWRkIHRvIHRoZSBleGlzdGluZyBsb2dpYw0KdGhhdCBza2lwcyBzaGFkb3cgc3RhY2sgYWxsb2Nh
dGlvbi4gTWFrZSBpdCBkbyB0aGF0IGZvciB1c2VyIHdvcmtlcnMgdG9vLCBhbmQNCmxlYXZlIEFS
Q0hfU0hTVEtfU0hTVEsgYWxvbmUuDQoNCj4gDQo+ID4gSXQgYWxzbyBkb2Vzbid0IG1ha2Ugc2Vu
c2UgdG8gY2xlYXIgQVJDSF9TSFNUS19TSFNUSyBmb3IgdXNlciB3b3JrZXJzLg0KPiANCj4gV2h5
Pw0KDQpCZWNhdXNlIEFSQ0hfU0hTVEtfU0hTVEsgaXMgc3VwcG9zZWQgdG8gYmUgaW5oZXJpdGVk
IGJ5IGNoaWxkcmVuLiBJdCBhZGRzIGENCnNwZWNpYWwgY2FzZSBmb3Igbm8gcmVhc29uLg0KDQo+
IA0KPiA+IEkgdGhpbmsgRGF2ZSBhbHNvIHF1ZXN0aW9uZWQgd2hldGhlciBhIHJhcmUgZXh0cmEg
c2hhZG93IHN0YWNrIGlzIHJlYWxseSBhDQo+ID4gcHJvYmxlbS4NCj4gDQo+IFN1cmUsIGl0IGlz
IG5vdCByZWFsbHkgYSBwcm9ibGVtLiBJbiB0aGF0IGl0IGlzIG5vdCBhIGJ1Zy4gQnV0IHdoeSB3
ZSBjYW4ndA0KPiBhdm9pZCB0aGUgcG9pbnRsZXNzIHNoYWRvdyBzdGFjayAvIEFSQ0hfU0hTVEtf
U0hTVEsgZm9yIHVzZXIgd29ya2VycyA/IDQvNQ0KPiBkb2Vzbid0IGNvbXBsaWNhdGUgdGhpcyBj
b2RlLg0KPiANCj4gUGx1cywgYWdhaW4sIHRoZSBjdXJyZW50IGNvZGUgaXMgbm90IGNvbnNpc3Rl
bnQuIGZwdV9jbG9uZSgpIHdvbid0IGRvDQo+IHVwZGF0ZV9mcHVfc2hzdGsoKSBpbiB0aGlzIGNh
c2UuIE5vdCBhIGJ1ZyB0b28sIGJ1dCBpbW8gZGVzZXJ2ZXMgYSBjbGVhbnVwLg0KDQpJIHRob3Vn
aHQgd2UgZGlzY3Vzc2VkIHRoYXQgdGhlIHVzZXIgd29ya2VyIGxvZ2ljIGFscmVhZHkgd2lwZXMg
dGhlIHdob2xlIEZQVQ0Kc3RhdGUgdGhvdWdoLCBzbyB3ZSBkb24ndCBuZWVkIHRvIGNhbGwgdXBk
YXRlX2ZwdV9zaHN0aygpLiBEaWQgSSBnZXQgdGhhdCB3cm9uZz8NCg0K

