Return-Path: <linux-kernel+bounces-854102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8B2BDD8BC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683E8544615
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEF031814C;
	Wed, 15 Oct 2025 08:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W6gHkoUe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5615318130
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518450; cv=fail; b=rc0wy/6ms01qaHSLVyyU57D31SaF5rkvJDkEZRahJIjTwAZY3zTo4XF0CBrVlKU0gdm/yGQct/bknjni0S+n288uvx8IXTfG2uauwxA6SWhv/bNb7CZDUoYzrPDQMtvmsdhfRUiGZfWftFuVv3NUmMP4gQqi01+8OP/2xldlgAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518450; c=relaxed/simple;
	bh=SRUE9IExcf/zysbepVAX9r3ziAihWy00YcNd5B9Mr6s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QnV/hp3kkoZRRq1ard2gusCWPWWwM4BeHjyjwKjyi/TeL1IFQW5jTxqzOGBkM6FCbDItNFhLAjlhUdxoF16oP0IG2ElDwU2EfiewnYNpL2Pb3GegUCFLH4PkdZfam9gsqCWSAJQmZ5I9Md/cBThmQpZ/T29pH5Jqz8/8CoBD09g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W6gHkoUe; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760518449; x=1792054449;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SRUE9IExcf/zysbepVAX9r3ziAihWy00YcNd5B9Mr6s=;
  b=W6gHkoUeIPfcAypba98fg6q5NKtUSNh8eKieiPhuWrISQUv+dpEM4NkQ
   rzoiTVq1+jLOUiKotXZt2pDFBjYMLPmp0Qe8CdDiYjPUnJrvVqPxeZA/I
   GnBxegJev8aLfqzg//4rFrIC0NOBsSYrJH0mnnpGCBOfCfIzggzOrXjKM
   PWiEaQKzEWjjH6NnAxUCojXsVJTGCrG/w+VCUXsRyD5TOX88hs6O10S82
   NODJdaY75WSmZ2D4jW27NgFAvMhiTzKawPxneGpM2JfO1N3jQkLjDYgt3
   gT08HInDEvJPltBKEvaTFOw4P556HznI5iFipmf0npqXL3Jdgouxw8jFX
   A==;
X-CSE-ConnectionGUID: aajbzWP8R6Gmt5CZRnq8PA==
X-CSE-MsgGUID: 4xyzKmSFQMam4JpzDJIcvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="61895436"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="61895436"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:54:08 -0700
X-CSE-ConnectionGUID: IxL3V92ASkWJHBVC55dtLw==
X-CSE-MsgGUID: /k9BNfnkQLC4vOv2ls5BmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="181676230"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:54:08 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 01:54:07 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 01:54:07 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 01:54:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7ecJHDpcafFDfLTylqVViFs/68hHQeVrF0OrSKv+a72tdwZsRggM7Phx4X+pLSuzujy4VxfKnd1GeCDEoC6+ZoBJ8sTMQsHZCiAGBFtaxzlostmzKTBSc9pL7V5aQZDlDknFIuwEevzKjR1aKmNYfMejETIZyC8/bxbSLEYRXdvr6ATpL7o6WebZsZveVeZRkozpS4vAn5koLN6vAyDRRcGbdgM7APDnRsZzKk6EDpNSjc8+GPo/JEqas/J7IYqN8jk3hKwbiECmsMeGLraGWPmgc/pAthpMq/XE43vAKMU9FonAVri2lViLqYkDm2m/MSBgmXV1f4jA7kHd/QPOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRUE9IExcf/zysbepVAX9r3ziAihWy00YcNd5B9Mr6s=;
 b=WG8S3YTCds5GRbVf54vwakKCKHZN5yfSijqrDY0qQAfzGJOuCG1KS/dv7HCjyVmtN0qfW9OwNEJ2l55BoNYa7DhwEtetegFowzPvpMLaht7D/DlFcoX/stacBOLrpDEgt7r5Ovrmb59OOxu8/HWPdZitTMmxQolnYe9DNCLKE8urqUBYGBHCT2dMac7nsdha41hPN9LvUgkJXRkncqNmCuIOb7bbrtLnD1gsx+o7g73MiLMjzIXZ6W3ED+KFswqenS69T4TySXZTyro7qY8xgscGqGCM8GYS8//eAPt05pYNwQlDT70Zbirk21G2MyNlSq0Kx0gJZwebzBLShG5Wrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB9495.namprd11.prod.outlook.com (2603:10b6:208:59f::17)
 by PH7PR11MB8275.namprd11.prod.outlook.com (2603:10b6:510:1ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Wed, 15 Oct
 2025 08:54:03 +0000
Received: from IA1PR11MB9495.namprd11.prod.outlook.com
 ([fe80::fb49:1b0e:8ebc:254e]) by IA1PR11MB9495.namprd11.prod.outlook.com
 ([fe80::fb49:1b0e:8ebc:254e%4]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 08:54:03 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Annapurve, Vishal" <vannapurve@google.com>, "Gao, Chao"
	<chao.gao@intel.com>
CC: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>, "Huang, Kai"
	<kai.huang@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "sagis@google.com"
	<sagis@google.com>, "paulmck@kernel.org" <paulmck@kernel.org>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov"
	<kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH v2 00/21] Runtime TDX Module update support
Thread-Topic: [PATCH v2 00/21] Runtime TDX Module update support
Thread-Index: AQHcMn7PzLsl5dUPTEikD7KJ8NM7q7TB2pCAgAEhGdA=
Date: Wed, 15 Oct 2025 08:54:02 +0000
Message-ID: <IA1PR11MB949522AA3819E217C5467B51E7E8A@IA1PR11MB9495.namprd11.prod.outlook.com>
References: <20251001025442.427697-1-chao.gao@intel.com>
 <CAGtprH_FzXjnC0Rbctpvm2_kqAAnUOfnaT4885fBiAi7s0jcXw@mail.gmail.com>
In-Reply-To: <CAGtprH_FzXjnC0Rbctpvm2_kqAAnUOfnaT4885fBiAi7s0jcXw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB9495:EE_|PH7PR11MB8275:EE_
x-ms-office365-filtering-correlation-id: 1735c7a3-a0b2-419d-4cbe-08de0bc863e1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TktIbmV5S04xcjhXY2JydWZyUFIvVWI0MUx1VlZRelQyWnVxRnBDdWJ5c3hq?=
 =?utf-8?B?K25STVJZMkoxcW9NTzVnazFPdGJaTmFsTzBUYXBoVFhFSmJTQ2FRaFdRbktk?=
 =?utf-8?B?TmlyRUhUZGIrUG96K2R5eFZIZnhxcDBpcnFFUmRpU0V3ZzAweWVPb3FaRWlB?=
 =?utf-8?B?eWhKV1kxSUE3QWNqOUNXUHdaajM2ZWhaL3J2aDkwRGpFRUs3Uzhha2JaYity?=
 =?utf-8?B?VE0rSFNNemlhUElmUkd2d3RjZmVEZVZZWG5ROFpwT3RBTGlQWFl5d2pLb2Y2?=
 =?utf-8?B?eEl2a2RTRzkvRXArZi9LOWNaUWZlVXFxRTFLM1lDdWwvOFhpdUdOUFRwaWZq?=
 =?utf-8?B?TUYyTDJXektveitmbUx5ZEsvQWl1dlVUN1RtZjVjOGZtcVFiZWJFaHEzV1kr?=
 =?utf-8?B?cC9zQURuYVBRSFdCOGJYbUxSc1psQkNtNTFXTzgyV0tLSFJHUHdpYmVhdnhJ?=
 =?utf-8?B?djAzNmFGNVluK045K3RCeFVRWTVsYlpRdjVEejE3bmtkTzZpWG9mTVNsRTVy?=
 =?utf-8?B?bjg5NGJXTHVYb3pyUU02UWxYRDIvMmMyT1hmV1gyVkpsTndlSHV0aUdVRlQ1?=
 =?utf-8?B?UG11ZGViYUt2MERiY0ttdjhkVTVPd0wxak8rT3BGTzlNbmViQ1VsYnd0QnV2?=
 =?utf-8?B?cHlGMFkvQ1d6TGFYQ3JyZHpRZVlCUVV2N1V0SGJFQjEyUDJDMnM4ZE5FVmor?=
 =?utf-8?B?Z1NSREhSSDBVRXNwSkNrZ2lqWi9SSE5KUUsvL2hIaTJkTnduRkw3SDd2QTRG?=
 =?utf-8?B?VFNCYVVWM21lYVRkdDlvVUtnRGgyeHlsQlUxTGNUWU5XMURUZXZZVkN6WGV2?=
 =?utf-8?B?a29lMXYrOU9na0JXTU1Pa2xKckU2aXBiNE1pVWVkcFN2V3FyOGFVRzk1QS9W?=
 =?utf-8?B?Z0pwOURrWk5icFBLd3EzN0Yvc1FTK2tONHpTMEpicWRHYzRkNEVZMGR1bVBs?=
 =?utf-8?B?SGM4RDdwYXhXSENBOEw3U3dkeHNRSXlwWjFvYWw5N3pneXdKK3BVT2pTeVE2?=
 =?utf-8?B?eXlLNlBJRThvckE1QStmaG1UWVZUNk8zTXNLcXpSaXlvWGlJYjMvUUwydHFB?=
 =?utf-8?B?R0RjT3dibnFGZk12a3Uwb3dBVWMwbDV1ME11VHhqa2ZLRFB4d0daWXV1SytP?=
 =?utf-8?B?aWlKUW5qaHJEYnJCTHc2a2NwdU51NlZ3Sm9JTlVyLzdsVUVlWHFZdTFSRlFO?=
 =?utf-8?B?Sno5QXh5Q2VqaUhtN3VhVkFQeW1hdnBRa2xXZ2MzUEVwbW9Vc2VjelBaWW51?=
 =?utf-8?B?RzJMYzhhOXdoaHc4dkhoTitUMlhMZkxTaWRBdW4wLzhOcURFWEY2YWExdDlE?=
 =?utf-8?B?cHRMT0pZd2QvdVJ1TSt1d2lKVndIcWYrQzdkWGxBQ1NTSzM5QTdnalYvZFVS?=
 =?utf-8?B?STVEbVpmeGNlOXNzOTd1OFl2TDBaRjM2UzQvaXc4ZUlDdVVqczhXanA3VlJN?=
 =?utf-8?B?VmUyMTlEUTBRUXZpRS9GMU80Z0JVUnY1TjRMRjhzeXN6UVRCeTA1alU0Z2dv?=
 =?utf-8?B?S20vSjhPN0dQU2ZGN1M0MFk3Y2NRZDZ2OGEvaHNXd1d3RHg5Z1A5Y3hCamRr?=
 =?utf-8?B?SkRWZnIvUVRNOURCdUpjRU9WKzM2THNFc3hNdS9XT3U1eHpPU1hVUmhkbzdI?=
 =?utf-8?B?T2RxQUlPbUgycTVKTmJNemJGckROUzZNTnFrY0RTZTE3bmhMdWxESkNEa2Rk?=
 =?utf-8?B?WTJmRGtVK0RWczR5RFpnS2xjVitqZmRyQU8xeDZrN3NETlYrQW9UdFJYMHhs?=
 =?utf-8?B?UTBaUFRJcFplUkNnMUFzRWR5WHlyTDU2TVVxSGduOUE5U1ZQNjB5R21QRDZI?=
 =?utf-8?B?cEJxOXVya1ZhNTlXUTdnWEVINHpIK09yRjdqdUFxdGVXWE1MeVlxUFRGVGU4?=
 =?utf-8?B?YjJEOG9ZaUxEQ3RmMEMrYm1sNlhKcC9lTTJLYzVueXQwaWpUNWdiUVY5QjJa?=
 =?utf-8?B?QTRQc1AyUm5EWVl0b3R1Y284cUx6UXk1TkdyY2hHejVXaGo4N0JJTVByR2Nx?=
 =?utf-8?B?VHFXNE5UWGN2enpDMU1aZjJVcXptSHdwS1BYdGR6RVpKazlrV0hUbHZIVVhL?=
 =?utf-8?Q?NYxgNw?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB9495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnhUV1V4dFFzN0M2MTdhRTNxd25JZkJHQW9JZjlpdEl6Qm82c1k2SFhBTlFq?=
 =?utf-8?B?VUthSnBNVlpmcDVRTGNFaDNaaG16d0RrNGxOZmNQTWkrVlhNcWs2SVBuTHpM?=
 =?utf-8?B?N1ZsMFpQR2hjRk5tVyt4Z1RNT1NHN0ZNRWpjaTg4by9zR0ZxdXc0S2N0d001?=
 =?utf-8?B?SW5ZdXpvc09DeDZpcHZnendnUFlHZXRsZnVpWG9jL2ZwQitWN0VDRXc0ejlK?=
 =?utf-8?B?WUhNSFFGMzUzQmlEQUZ2bGZ4UUtneUNwakIvSUhRQmV3OGdXOW9CZTNTMEJZ?=
 =?utf-8?B?M3dHUzR6UXFiMnJxNmdZYXVCUldIZWNNUHh6c0V2cUZhVmZEYStXeXlSZkFt?=
 =?utf-8?B?TEdwSUs5VEsybm9CTkhDWXNhYjF0VlE0RFppdFQxWXNLYTBGWGRuYVlkVERy?=
 =?utf-8?B?Z0gveWxMcjVjakRSQ0RXT2xWY09sV0JEeXliVWh2NDdiNGhFS2RZUjVkVkF4?=
 =?utf-8?B?UTR0cDFPQ0lRM2EwbW80L3RvMWkxZjBMY2o2SGhkc3NzcUxpTXYyekpjS0ND?=
 =?utf-8?B?aStZOGxQVURJWmdwK3drY1ZQWDZvV0ljMFVyLzR2SjdXSHB1U3FzS2pKajl4?=
 =?utf-8?B?YXh5WThERDJ1aGQ0RlBSZTZjWllsVjhxUk5QbzRxSTkrcE9QZjZTZHRrdFZK?=
 =?utf-8?B?UUVyLzRoYjRROTFZcVFjKzJ2djNHUmU0Y1hhUVd5ZnRjUmhlcDJwalY5bDJJ?=
 =?utf-8?B?YndTb24vVGZzOXByUVE4ZEtMZVNONUkvOE96TmY4Tyt5V2RSSmZzaDRXaVhm?=
 =?utf-8?B?MnJvbm9IQjNnaEViVzBDeG1QU2FxSDNmSVFCT0ZHZXdWaEdHUlRiY1R2TThL?=
 =?utf-8?B?amxVZjdLY3dDWVVPNXhqV2x1TDQvdXpZTXFRSCtVL0R4blQvWlRtakFzU1VC?=
 =?utf-8?B?Vm5aMm1PSWZROEY1MWlFQ0dCV1lsOVRiWGtFSlBCd1RDaW0wUHR3RG9OSTBu?=
 =?utf-8?B?REdLNWV4STZhUXgzVTQ5elU4NWYzeE44WjVkM1V5dXh4T2gzdVJZbFFFcDI1?=
 =?utf-8?B?NWh5U3VXNWtRZHBmYW9vM1pmcjI0eTJBRGhEck1rUWFBT3AwY2RBc3Z3WGh1?=
 =?utf-8?B?K1JDOC93clRiZnRaSVVUU3VieFVJWlZKS3crc3FBMFVqT09ZQXNYemUraDc5?=
 =?utf-8?B?cUthODluaVB5WmJ4blFJT2ZqSm5sdnlpZEZlNnczRUEzaVozdzlLelFyUTIv?=
 =?utf-8?B?TC9hSUgxMDliNGg5R25LQmswcXA3d2tUVi9xbENMSm1NSEJHZmptN0RuWVpW?=
 =?utf-8?B?Ky82SGlQZkdZTTN1Uno1MmFGZkpxVFVFdFp3c0hmV1prOEx4alJFVXhxdUFE?=
 =?utf-8?B?dlZ1cXJ0SlkzcjZhTnpIMXFIZzZmZVU3TG9jL3pmS2NaeEszamQ3OXplWFY2?=
 =?utf-8?B?YlZmZzBhNW9qRzIwNlFXZjd0M2tUKyt3cVc1UklHckRSMVNMSkhtSVRuKzF2?=
 =?utf-8?B?Z0pFa2ZDbXRUWlphMkZOQjVNS1NJeUhGaldidXptejRxTysrSXZZa1l3anVB?=
 =?utf-8?B?UjlmV3BiRE43T3JiVjFJU1FFS3V5UnAxZnpPNFh0R1dhQUJzUzV3REs2U1Bq?=
 =?utf-8?B?d0ZBdWk5TVhwUkpCWUNpSW9VeTFDZlhtc2k4M0hGdzk1YXBOd1Rrb1owbndw?=
 =?utf-8?B?cjgvc25kTDdVVEJYNjRjK2dzVEM2WjhVNlRxYVdOOXRJTlEyWXZUK0VOTFNQ?=
 =?utf-8?B?L0xwTzdZWDk2SkdpVnpJM1hUTjg1NmJQa0R0R05zWEQxV2hodkJWU0VlQ1Bh?=
 =?utf-8?B?YzVBOVlFMHhkNC93eCtRUTRYWlFmWDFCODdLMUpOSXZZM2ZFMzZLOVNIaCtk?=
 =?utf-8?B?dWxsSEYxc1dmNzNnR0VtOGZSVFVIRXFySDJNaHFzQ1FJOUhYRi9NekoyNWtH?=
 =?utf-8?B?YW03ajJJN3NkcjFnbFo3a0xnRFRtWkkxeGNITEE0UDdtejNKV3p4MHhyZzYx?=
 =?utf-8?B?cXZLOVFUclJPZXcyaHlGQXVINVUzRG8rZXh1ajhnYm0rNVF0akRNUWd0Tk1n?=
 =?utf-8?B?THVDMnAxTkJsa3BOYXJKOUlrRlNDR0xlSGdHdEtJTllZNnE0QmtNZlplTVNl?=
 =?utf-8?B?MjN1MlJUTXBjdHhiTjZHYTJudEtNT0ZlVmc4TEFEaGJkUFZOOUdTT2FkSGxx?=
 =?utf-8?B?WlZnaW1iSkJQdjZpbkg0eVpkL3pnMDBJRWh2TzBlTVB6b05Qb1NFdk5uMURZ?=
 =?utf-8?B?YVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB9495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1735c7a3-a0b2-419d-4cbe-08de0bc863e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 08:54:02.9704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 75ls4bfDFdwE4fh36B8DqTefgAPyNhcCpD0N1qKzJWfU6XpvN8CN0SKHWcNJjl8USaw/vJgunTSCCX0s6Ro5J880Bh4oCeRR7AOqK0cgx1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8275
X-OriginatorOrg: intel.com

DQo+IE9uIFR1ZSwgU2VwIDMwLCAyMDI1IGF0IDc6NTTigK9QTSBDaGFvIEdhbyA8Y2hhby5nYW9A
aW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+ID09PSBURFggTW9kdWxlIERpc3RyaWJ1dGlvbiBN
b2RlbCA9PT0NCj4gPg0KPiA+IEF0IGEgaGlnaCBsZXZlbCwgSW50ZWwgcHVibGlzaGVzIGFsbCBU
RFggTW9kdWxlcyBvbiB0aGUgZ2l0aHViIFsyXSwgYWxvbmcNCj4gPiB3aXRoIGEgbWFwcGluZ19m
aWxlLmpzb24gd2hpY2ggZG9jdW1lbnRzIHRoZSBjb21wYXRpYmlsaXR5IGluZm9ybWF0aW9uDQo+
ID4gYWJvdXQgZWFjaCBURFggTW9kdWxlIGFuZCBhIHVzZXJzcGFjZSB0b29sIHRvIGluc3RhbGwg
dGhlIFREWCBNb2R1bGUuIE9TDQo+IA0KPiBbMl0gbWVudGlvbnMgYWJvdXQgYSBsaW1pdGF0aW9u
IG9mIGRvaW5nIHJ1bnRpbWUgVERYIG1vZHVsZSB1cGRhdGU6DQo+IA0KPiAiUGVyZm9ybWluZyBU
RCBQcmVzZXJ2aW5nIGR1cmluZyBhIFREIEJ1aWxkIG9wZXJhdGlvbiBtaWdodCByZXN1bHQgaW4N
Cj4gYSBjb3JydXB0ZWQgVEQgaGFzaCBpbiB0aGUgVEQgYXR0ZXN0YXRpb24gcmVwb3J0LiBVbnRp
bCBmaXhlZCBpbiBhDQo+IGZ1dHVyZSBJbnRlbCBURFggbW9kdWxlIHVwZGF0ZSwgYSBob3N0IFZN
TSBjYW4gYXZvaWQgdGhlIHByb2JsZW0gYnkNCj4gbm90IGNvbmR1Y3RpbmcgYSBURCBQcmVzZXJ2
aW5nIFVwZGF0ZSB3aGlsZSBURCBCdWlsZCBvcGVyYXRpb24gaXMgaW4NCj4gcHJvZ3Jlc3MuIg0K
PiANCj4gRG8geW91IGtub3cgaWYgdGhpcyBpc3N1ZSBpcyBmaXhlZCBhbHJlYWR5PyBJZiBzbywg
d2hhdCB2ZXJzaW9uIG9mIFREWA0KPiBtb2R1bGUgZml4ZXMgdGhpcyBpc3N1ZT8NCg0KSXQgaXMg
bm90IGZpeGVkLCBiZWNhdXNlIHRoZSBsaW1pdGF0aW9uIGNvbWVzIGZyb20gdGhlIGludGVybmFs
IGNyeXB0byBjb250ZXh0DQptYWludGFpbmVkIGJ5IHRoZSBJUFAgY3J5cHRvIGxpYnJhcnkuIERp
ZmZlcmVudCB2ZXJzaW9ucyBvZiBURFggbW9kdWxlIGNhbg0KdXNlIGRpZmZlcmVudCB2ZXJzaW9u
cyBvZiBJUFAgbGlicmFyeSAoYXMgYW55IGdvb2QgU1cgdGhhdCBhaW1zIHRvIHRha2UgbGF0ZXN0
IGFuZA0KZ3JlYXRlc3QgdmVyc2lvbiBvZiBpdHMgZGVwZW5kZW5jaWVzKSBhbmQgSVBQIGxpYnJh
cnkgKGFzIGFueSBsaWJyYXJ5KSBkb2VzIG5vdA0KcHJvdmlkZSBhbnkgY29tcGF0aWJpbGl0eSBn
dWFyYW50ZWVzIG9uIGl0cyBydW50aW1lIGRhdGEgc3RydWN0dXJlcy4NClNvLCB0aGUgcHJvYmxl
bSBjYW4gc2hvdyB1cCBpZiB0aGUgb2xkIGFuZCBuZXcgVERYIG1vZHVsZSAocHJpb3IgYW5kIHBv
c3QNClREIHByZXNlcnZpbmcgdXBkYXRlKSB1c2UgZGlmZmVyZW50IElQUCB2ZXJzaW9ucyBhbmQg
SVBQIGhhcHBlbmVkIHRvIGNoYW5nZQ0KaW50ZXJuYWwgZGF0YSBzdHJ1Y3R1cmUgZm9ybWF0IGlu
IGJldHdlZW4gdGhlc2UgdmVyc2lvbnMuIFRoZXJlIGlzIG5vdGhpbmcNClREWCBtb2R1bGUgY2Fu
IHJlYWxseSBkbyBpbiB0aGlzIGNhc2UuIA0KQnV0IHRoZSBzaXR1YXRpb24gY2FuIGJlIGF2b2lk
ZWQgZnVsbHksIGlmIFREIHByZXNlcnZpbmcgdXBkYXRlIGlzIG5vdCBjb25kdWN0ZWQNCmR1cmlu
ZyB0aGUgVEQgYnVpbGQgdGltZS4gDQoNCkJlc3QgUmVnYXJkcywNCkVsZW5hLg0KDQoNCg==

