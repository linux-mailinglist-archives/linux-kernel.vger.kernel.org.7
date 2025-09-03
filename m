Return-Path: <linux-kernel+bounces-799008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FE1B425C9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83F537A31AA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811D221D3F6;
	Wed,  3 Sep 2025 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ia8tn7Y4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1D11FA272
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914435; cv=fail; b=CaxmKmKxG2I026cbKTWqq4UTU2Q41RssTbCtPh2pAl5RP7WwEQTaB9qceleCoNd+hfrCDTAdrFAkpZ1U2gjb7hbgUmR/Kn1w5ava4PlQO7nsoezGz1oigj91aHkdyjWddckh1NBiZoZbZuCcxt0ZcbgxcGO2w8DA0plfwxqbdD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914435; c=relaxed/simple;
	bh=zPTgEr3RFJYF3uRh+N7mcGsEOpb2/x9gpN7hXahaU/8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hGVQs3TSU1NgzVELBiwWNZl3CWNlx3DXFCFcSlnacep6oRnw3pn7aWe98he+KANRqJeuJw9+vjYx3lj2KWy9A6CNYgUDg4Ls/NkIMrxGn8TIAvRHcO32TEQ2yRYBxsAZ7CH6hN06rVVRQsAD355dyzQTVeg3e3IEXxI73IZc5TI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ia8tn7Y4; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756914434; x=1788450434;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zPTgEr3RFJYF3uRh+N7mcGsEOpb2/x9gpN7hXahaU/8=;
  b=Ia8tn7Y4oOOc/5xg0DtGoo1KmDUjCditdLyGujz+rBbMWtb/ugnC0/4J
   SRQNA+vGcHASqjn59rO/EHeLgqip/nZGbl7pA6CIrepH/9q441YmsUVji
   IkwJo0ucXp4fqkPLObJ9DaWAr/3xTkD8xzrhT9bAgTcS0uc9ucqLMjob0
   0mT64l9RFrksE+DFl/ZaJNqP635shup+dP12gFEfOQ7drtyHfYqpp65As
   UEuCzB4VVsZs1NfZNaasRGA2sSn+D7xD+r/Dbs9pNb3kUUGaZhvJNj1aC
   cFR0EWYf+QjUPtOn36pQYMYiFIc9sWH9uPuPvt2bsAUhem0yJFhJwksj7
   A==;
X-CSE-ConnectionGUID: 7zT5F26lSs2QiTlCN5RumQ==
X-CSE-MsgGUID: rB/vl3UAQgWEBKP4Fgtwzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="63053345"
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="63053345"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 08:47:12 -0700
X-CSE-ConnectionGUID: WQo7A38cSKetbY06OtDIfQ==
X-CSE-MsgGUID: JkdPfAdsSmOcdVdRV7ku2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="202579823"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 08:47:02 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 08:47:01 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 08:47:01 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.61)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 08:47:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OghaUIg5iQ+r6HlGyMu9XsEl1gxGV6do4GSO1Pp4LFMBNWck8XcbBeN5nFhwFgyRGlZ4Dr1brs9oFK8neGRgRZ6SQMv7+t1AwP6Obx4vqGCksla+NQgHZz3KyHlzniHWfT6Ht1oMvIti1our7NBDrQ2wbGbErqiJ5EdLNWR5JFW/4vCPdNzhsHTtS47gWDTELRhQ5NStkdM1wagT0w5412InZoMA2E/zPo0LqBZ//yWhtj4bAr9O9jlWzXBOK2Y27XTa/SxBXv3HlXG+RGpn4nRINr5idRsCWKmyFOpNCNvpeio61xkDwXggXOckoV4kNMWnh3KtYk1uFOER7VWrEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPTgEr3RFJYF3uRh+N7mcGsEOpb2/x9gpN7hXahaU/8=;
 b=pvMwUaUQtQt19zJ2KUd4VH52vp7zQO4/NuHiIkFUU1scdgshvtOtB6kC51URo0C3Mn/8AZ9EcQExbcRzSkQwhkfwzFb5bnGlDIbWBgLvX0D0MJx4/DO1d7lrPLWysi+ZPJUkNAVPnOuQckeiGQoW9OuabtO1rxgOgJE/dOKQR6r3CqcHx11u4vZ7xdYA2/xv9gfCbh6UgZNozl/j5OuXZt0LzMZwb2TdYG2mhN6buEjWiwnriTY63cyeOmW0qR+06gqU+fp75AZopv4bKC31o/yGCSU463DmX8Fx44K5APZaXRIkEgiJ7sB7Ohw3l9zyti3Zv2lbeBRTQ9FqY+3baA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH3PPF8517B3F27.namprd11.prod.outlook.com (2603:10b6:518:1::d35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Wed, 3 Sep
 2025 15:46:55 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 15:46:55 +0000
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
Thread-Index: AQHcE3q31HuRziJTPEK2T8WL/8xAvrRu3dGAgAAvBQCAAAthAIAETlGAgAMr1oCAAAr0gIACBpMAgAEiCACABqXUgIAA3s2AgABibgA=
Date: Wed, 3 Sep 2025 15:46:55 +0000
Message-ID: <78d2f583a0d3008c7d0e2b0e6b70a1b3258cc659.camel@intel.com>
References: <20250822153603.GA27103@redhat.com>
	 <064735211c874bf79bfdf6d22a33b5ae5b76386c.camel@intel.com>
	 <20250822192101.GA31721@redhat.com>
	 <b483759593fb83ec977c318d02ea1865f4052eb7.camel@intel.com>
	 <20250825134706.GA27431@redhat.com>
	 <2491b7c6ce97bc9f16549a5dfd15e41edf17d218.camel@intel.com>
	 <20250827145159.GA9844@redhat.com>
	 <4249e18ffed68e8038624021aa3a6f06b64eeb85.camel@intel.com>
	 <20250829150605.GA6035@redhat.com>
	 <e653fb9cab51ed2d0ea71f9d322c55420a83a4f5.camel@intel.com>
	 <20250903095436.GA18799@redhat.com>
In-Reply-To: <20250903095436.GA18799@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH3PPF8517B3F27:EE_
x-ms-office365-filtering-correlation-id: b719a1b8-4392-4240-f9d2-08ddeb011c35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NXRkZU5uSWVOWXVDaVRNeFI3eitsRjQveUp0ZEgxWGw1d3IvUDIxV3dzOGk3?=
 =?utf-8?B?S3BOTzBrMXJEbGZlNG5BdnVaUmk2QSsrYm9WWWV4N05MbjhJdzlHSWIzUWNT?=
 =?utf-8?B?akRhMEtid1EzVGdIejZWdTN1bGVkWEYyTU13QXdjeWp0ZWhQOW5Ub3pOek12?=
 =?utf-8?B?OFcvaCt3NnhoM2QvNlFuZE1ndSt2ZERYaUY2RzNobHJyc1hZS0N3MVdaYlpH?=
 =?utf-8?B?ZkQ5RlpmbUtWUFYvWC9YZGh2QlgyN25jU3lWZm1GQStoTFQ2bmI0WVY4SmpP?=
 =?utf-8?B?MlpQRU9naE9TRy8zdm5uM3NPYlJHa25hMTFqMjJnVDEzdlVoaGx0T3Zrelpn?=
 =?utf-8?B?ZlFqcE5oOXR0R1lDWWNmN2FJVFI5aUtpZ29DZmYvQVllblBhYzEyT0VTUTd1?=
 =?utf-8?B?anZCZnhWd2NsNmVUbGs0Z2ZiR1FwT005WlpWMGFEemg4Sm1CWUVsdkRNRGUr?=
 =?utf-8?B?cTFBYWxOeWRFY0VVaGI4OGthb3ZPYjRQemdXYVpKbHp4ZytUckQ2NnNaQVk1?=
 =?utf-8?B?QWp3aUl0VnBBZE1pY0xPS3JHN1cyTnBiQ2I5dlp6SndqZWhmbWNtL3NPQ1Bn?=
 =?utf-8?B?TUhTMEViK2R6T1VmaHMrTVRBblR2RUlGbXM4MTNnMStoYy9yQVh4dEpoVGlv?=
 =?utf-8?B?R3VGQVpVSGJHUG9JNG16Ri9hS3lRVE9mNGFSOHJld3VhL0kydk4yTnJ6UkJa?=
 =?utf-8?B?OCs0VkZsaVpVcjRvTmVhMHMxY1JDbWg2cVVIOE55cGJBeU9yME1kTHFjNFRu?=
 =?utf-8?B?a3FoaVVRL0tmamtLZkpZd2ZudlhnN1FvSGtoYjkvOXlyOTBSUTVKVGh5c3pQ?=
 =?utf-8?B?TnJkZ3FNVWp2MEJkWjZpeWhJRXd2RUkzV2VmSGdCZytaaWlTUVRJSmZZd1dO?=
 =?utf-8?B?MEpGZER1YnNRYmRDdnNLQlFMNGpWQWRMaEZIYkQ3Y1NiOStMSEZpT0JTT1Nz?=
 =?utf-8?B?Z0xFcFBJTExLaTNIdHdIWkd6K3RKTThQSyt1SzJ5YjdPSGRXSHRuSFlNNEEr?=
 =?utf-8?B?OFJVZ2E4bHAzN1dhOFhQMUNzMk5OM2xwVXBpOXdDL0hsbFVSMEIvczkrMHpW?=
 =?utf-8?B?RmpHbU9VSnd6cjA2czFVY0kwdERrcFhidjc4ME5vdUxITDloUU1zd3BDMnp6?=
 =?utf-8?B?eWkwZWZTM0JEb2VIbnVvVHJWbjZ0bDVyeUFaMk8xU01yS3AvQ3J6OXpnZUQ0?=
 =?utf-8?B?TlZ6S0o1NmpTUHZ0blRicnIwVjVwcnBHLzdRTmhaQ0xKQUdhWitXeWtiZFIw?=
 =?utf-8?B?K3JGYk1ONFR0QVZjYU5VTEhvVzBJdkE4UUpoYjQvc2VzOUY4amRiOVloSm9p?=
 =?utf-8?B?ZFE2Q2g1SE9NMFI1d2NpUGk1OWQyZ2ZmS2ljR2pFNEpxWFRPN1dFZG1mYUhm?=
 =?utf-8?B?MDVXNTdsWUp2a0NQUWZMWUJNanVIT0VjUDE0bE45QWw1OS9aZjJrZzNUaXQ4?=
 =?utf-8?B?S2pIdElLWHI0clZkWlFWNE8zTmY1RllNckpmS2hUTTI4TVpYQTFKcEJyaDZl?=
 =?utf-8?B?ZFZmSytSZGxlRXhjTGNlbk9jdXQ5Z1Y5aEZlMnNqYkNiSXRUVk1GWmsxdElu?=
 =?utf-8?B?UGVnajB3em1qQk1TWCtIT01MdVJIa3JXUk1RSjZMb2ZwbnBkNExwVVNOcFor?=
 =?utf-8?B?T3pZdWo5WGRsZm9PTEZQTFQ0RFZKYVl4bzFLaWcvQUhWNDVCeXNEcHBvVnAy?=
 =?utf-8?B?d0c1bUhBUXIrZG4xSnQxMVI3ZGYyVjRZalQxQUtGbDZycS9QdWxjVGxUd3Zu?=
 =?utf-8?B?RlJxN29KN2pFTEgvWVV1MmhjYUowVFRzQ2NRbU1MOXFxTkU3ZVIxeHJ1OW1N?=
 =?utf-8?B?bFFaUzcxSzAwRWpnazhIb1M0QllITkZhYWdYNENJSWQ4YlA2Z3d1dUV6cmJs?=
 =?utf-8?B?WGxZNlZEaDdPTTZoU2pkT0o0T1dqYVp4YzBTN3ZRMVo3S0ltM1FUTUY5dHZp?=
 =?utf-8?B?VE96Um1aZ2poa2w5eUVRK0J1Y3BzSlN6VUhGRGZINjF4dk43eG82SmNqT1Fk?=
 =?utf-8?B?aHF6VjdWdnpRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzlVRlh6Tk5rSEdpN0U4Sk9EZWZ0dGJVMS9oY0E3Y0hUYUU4aC9WT2hkeHlZ?=
 =?utf-8?B?ZzhyVTA3MU4zR3lxMFVUQzdIcXFEcTRjQjVpeXlOc1hIM253bXUvNW5EN1M2?=
 =?utf-8?B?M0V3bGxWWis4TWRKYm4wZTR3MWxVL0RudU80K3E1V2RtNkhTV0o1NkdqeUh5?=
 =?utf-8?B?VnFGK3c4RnpGUWN2VWFQNm1FV3JOOGJycHdNeXU1UjZvRHlhZmRIR1NBSXZI?=
 =?utf-8?B?RFZVajdDRjRzYVFjQzB2UytNUWZoRDhHRjNGM2pwQUlnb3FLcGZ6cWc4ZCtu?=
 =?utf-8?B?b3RZZGprM0Y3UEtLdk5VdTNWemFnVVZscmdsNFl2WWk3dWk0Zm9UV01HUTBU?=
 =?utf-8?B?U0pmR1NQQVUzQVJwdEE5eHNNN1FsK0JDU0JFMWJocGQzeDB6VGJUN3RlejA2?=
 =?utf-8?B?aUg4UzVtdzc5YXBoakZ6VjZ5ZThsTjBJZXV5d1JySGpMSnNVR2RpYi8ycXFU?=
 =?utf-8?B?YVIyTWl3aG1qK0RrbUNybzNRU3pPaFd6L1lvT2VTc2w1dEhyUGFrZkNTWkRi?=
 =?utf-8?B?WVNLL3dhWndML3RYMXFhOGZXcHlXTU1aam5LQXh6cE85TGk1akFHTEFqSTBI?=
 =?utf-8?B?cEhaY1VEVEUyVGJZSFg1a2svcks0ZlpDWUZjem50YWZuWmxIME40Mm96TXpS?=
 =?utf-8?B?bU40MTZKZ1lNS0ZyY3N1Q0lpdktvb0VhUkVHUFB4ZjNSbnFDbDhiVktYWEpP?=
 =?utf-8?B?OGJneVBTWXFqcE1lTVc5T2l0a284UkVvMmFlTjYzOGxUZTBYTGQxT000MWxD?=
 =?utf-8?B?ZTkyKzMwMzBEbXZqUU0wa252a3oyT3BWbmRxejZIVlNkWnNtNFIvNklWK1pG?=
 =?utf-8?B?MjdMbnV6Ym5kWTRFZFFrbk5ZNVdRVXAvVnZjSGZJRGUyano2VDV6NGlCUUFH?=
 =?utf-8?B?N29iT0VWNlRQbEROWkQvQmtKNFJtd0MzbEFrTHAwNlpvSEJ3VHNZMGNlbUxy?=
 =?utf-8?B?WU5rYUVYTDB0K2kxbTJLeW45ZGQrL3RWUVNPVi9HRnhjbGt0OU9QRXRQU3lt?=
 =?utf-8?B?OE5hS01KUlVCWkNlV2MydVF5ZXlWSGFCemVJMktMRXVtd3RibDd0VHlsSmE5?=
 =?utf-8?B?T0FPWllJb3ROVFk3TTk4T2JXN0VoQVFvUW1OcmJNMEIxM0lJNy9PREt0LzVp?=
 =?utf-8?B?bXVQcS9UcldTM2hPVytFR0J5SlJSaVdiSy9jZmluUFgrWWNyVTdpcHV2bXVT?=
 =?utf-8?B?eUx1MEtFbXRtdWtaaHhJcEQ3N2pNc1RpSnZjeG5NNWJ5SXRMYTBvUVduekQz?=
 =?utf-8?B?RU52bGhxenFudC9aRFMyQnczNlJ2Sk1rdHZBVVVUTlBzMGdzcUo5eFdDR0Qz?=
 =?utf-8?B?N0s0YXBLQnUvWHBUNUhGeWZMUFc1bGpKT2h0dFpKY1hxOU4xQ1ozSTZQajNB?=
 =?utf-8?B?QmJpUmxrV2tUT0U4N1YxQTRTZlB4OU0ydWRFMlBLNk52SmZOUWRLbWpCWVdo?=
 =?utf-8?B?NXlrRUVtVW45RWZ1NVBDdm91dUIyMiszMGlFU1FhRjRkSkpZWThuTlpNdEZl?=
 =?utf-8?B?UFFISnF1WDRMcHRwQ3EyRlVrdXNyVjhBZk5zRmN5cVhEaU1qZGFFenZvNjln?=
 =?utf-8?B?R2VzNVlqTHJYMkR0bncrcG9tWldBS3pXV25iQUJ6TjhiNTlFVEtuOFFLejN3?=
 =?utf-8?B?VVQyOFNhUnpPTzIyUUhqdGhsVk1rRTJYRVZrOUVTOTRORmYwMXhOZHZtS1Nv?=
 =?utf-8?B?MjlTUmxLWFpJbEp2WXB6bU1YSmZVdVBFRElVRDJQY3NWRklIMC90VW54d0k0?=
 =?utf-8?B?VE5mQWlDY0dsUkZwaDM5M2FsamlzMWNkVno3RFlNNEovY1JraVBLV2FSZzhY?=
 =?utf-8?B?YlAvUzA4Vmswd1VWT2JTUllzT0Fpd05kSmFQMFZONzc1Qm1PQ3NkTUliOGFB?=
 =?utf-8?B?RGk3T2VLZFNOajlOa2UzZllHanJCR2pGdHZIVDNQRkZYd1Uramlob3M2Z0ZV?=
 =?utf-8?B?Z25WeFA2ekZuSUlFZFNzdjVhUmVPaVFFNExIR3JBN0orZ09NYXJpdlNxQ284?=
 =?utf-8?B?VTdsd0MzUWFmZ054Z1ZJbjRNVUl0dENTMFo1TkpxUUV2M0pTRHB0c3NFTkRs?=
 =?utf-8?B?UWxuQTFXRWVGbllER3dOWWwxd0sxVkNUQi8wT2ttVW91NXpTaFFWYWdGTFdx?=
 =?utf-8?B?ak9LeDdCKzVMNGNMRVRoWm0xNmNLQ1B3SDAySjBFNXJPWi85VzIydUQ0eU4y?=
 =?utf-8?Q?Vw0ykLBCp0Fryz1pS0LgTSI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28E276D5133DED4CB977776F6735A798@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b719a1b8-4392-4240-f9d2-08ddeb011c35
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 15:46:55.6797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3cN9heGjFnw+EswlBvxBLK8sZB/Mn43AZ2c8P/361YZasdgjvDYlIp0n4l06AgqTg55wph4ZhUwSe1S2tWpvVclJxhLaWkS8B7r0eCloS/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF8517B3F27
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTA5LTAzIGF0IDExOjU0ICswMjAwLCBPbGVnIE5lc3Rlcm92IHdyb3RlOg0K
PiA+IEhtbSwgSSBhY3R1YWxseSBkbyBzZWUgYSBwb3RlbnRpYWwgY29uY3JldGUgaXNzdWUuLi4N
Cj4gPiANCj4gPiBmcHVfY2xvbmUoKSB3aWxsIHdpcGUgb3V0IHRoZSBGUFUgc3RhdGUgZm9yIFBG
X1VTRVJfV09SS0VSLCB3aGljaCBtZWFucyBpZg0KPiA+IHhzYXZlcyBkZWNpZGVzIHRvIHVzZSB0
aGUgaW5pdCBvcHRpbWl6YXRpb24gZm9yIENFVCwgImdldF94c2F2ZV9hZGRyKHhzYXZlLA0KPiA+
IFhGRUFUVVJFX0NFVF9VU0VSKSIgY291bGQgcmV0dXJuIE5VTEwgYW5kIHRyaWdnZXIgYSB3YXJu
aW5nLg0KPiANCj4gRXZlbiBpZiBnZXRfeHNhdmVfYWRkcigpIHJldHVybnMgYSB2YWxpZCBwb2lu
dGVyLCB3aGF0IGlzIHRoZSBwb2ludCB0byB0cnkgdG8NCj4gcmVwb3J0IGNldHJlZ3MtPnVzZXJf
c3NwIHdoaWNoIGRvZXNuJ3QgbWF0Y2ggdGhlIHJlYWxpdHk/DQo+IEFnYWluLCB1cGRhdGVfZnB1
X3Noc3RrKCkgd2FzIG5vdCBjYWxsZWQsIC0+dXNlcl9zc3AgY2FuJ3QgYmUgY29ycmVjdC4NCg0K
SSB0aGluayBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gaGF2ZSBsZXNzIHNwZWNpYWwgY2FzZXMgaW4g
dGhlIEZQVS4gSSdtIG5vdCBzdXJlDQp3aGF0IHlvdSBtZWFuIGJ5ICJjb3JyZWN0Ii4gQXMgYWJv
dmUsIGl0IGdldHMgemVyb2VkIGluIGZwdV9jbG9uZSgpLiBJIGd1ZXNzIHlvdQ0Kd2FudCBpdCB0
byBiZSBzb21ldGhpbmcgZWxzZS4NCg0KSWYgd2UgYXJlIHRhbGtpbmcgcHVyZSBjb3JyZWN0bmVz
cywgYW5kIG5vdCBmdW5jdGlvbmFsIGlzc3VlcywgSSdtIHF1ZXN0aW9uaW5nDQp3aGV0aGVyIGl0
IGFjdHVhbGx5IHNob3VsZCBiZSB6ZXJvZWQgZm9yIHVzZXIgd29ya2Vycy4gVGhlIGJlaGF2aW9y
IHdvdWxkIGJlDQpsZWF2ZSBzaGFkb3cgc3RhY2sgZW5hYmxlZCwgYnV0IGRvbid0IGFsbG9jYXRl
IGEgc2hhZG93IHN0YWNrLiBCdXQgYWxsIHRoaXMgYWRkcw0KY29tcGxleGl0eSBjb3N0LCB3aGlj
aCBzZWVtcyB0aGVyZSBpc24ndCBhcHBldGl0ZSBmb3IuDQoNCkkgZG8gc2VlIHRoZSBwb3RlbnRp
YWwgdG8gaGl0IGEgd2FybmluZyBmcm9tIHVzZXJzcGFjZS4gVGhhdCBzZWVtcyBsaWtlDQpzb21l
dGhpbmcgdGhhdCBjb3VsZCBiZSBmaXhlZCBhbmQgZG9lcyBoYXZlIGEgY2xlYXIgcHVycG9zZS4N
Cg0K

