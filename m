Return-Path: <linux-kernel+bounces-788448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 700F5B38484
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E63E1BA6DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B254535A28E;
	Wed, 27 Aug 2025 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ftGlnMp3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7111302741
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303979; cv=fail; b=PWwk1Mj+EqqKeeVX00lfUxhxrfh5ESZ9RTid+sqQQaoeMH4rKqV4JbNzKnzskc20sUFxqQCJnGIYjhlrYnoqIDp6G3uDPRUHFEtTwYNqJO11BJ9KmSfgOIwO4RBupWzwFzPOkbVqujSFlyFs2VFJvUph+7P+dsNt54hrCyHZRFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303979; c=relaxed/simple;
	bh=+9223fzuHA4FPOtnLaDe0DQfPt6xYfAyaokVCGZo0hU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ht0zpvh6uzAbGSBbq3O/Wn4p9QPbBQUcccvzL/wZrnX8gP0f9OLHUDKFv/Gg/r38Yl08RUydYUiQL5078HHEeVvm7abbozEJGqdVWN2sWUI/X41FcnhBE2jsZN23ou3rIKzLy7jo9mtWGwhpZ+uSJY9xwme3mcax0YCqZC5doV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ftGlnMp3; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756303978; x=1787839978;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+9223fzuHA4FPOtnLaDe0DQfPt6xYfAyaokVCGZo0hU=;
  b=ftGlnMp3LRY5s4S+XhEZZynoNnN08zEvGEyIIVhzOp1fissJiuXQHC/3
   lyOoooRgHo7yTjLlp/+pdpD6hZ7PxUjiCGkhjI9M8IPwprn5dpj2bbCT0
   hLDyvvLHn9iBK8MDsiEjPEws6yHuBPvzo2lcTSUkYoN5YrxKOOXmEUj+1
   wATagt2n9UNEI20nR0DR0irYlNDI9BURDXQJzIPyDqC5t8Va5RoEGRixO
   MS2f7NEYiKHC33KOhildlbkl1l1A4NjSLOECrzfspvs9X9Sc1EgEJB06q
   I4ORCP7WZCwQO1WJfZ6GwAFShaEZJdMrIPYauo06Q/uy9aOqYDfhZebfg
   A==;
X-CSE-ConnectionGUID: Q6RO/3VNTg6rkcflb9lnNw==
X-CSE-MsgGUID: /yx1vZqwTLWpIO/fSWXDSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="58617806"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="58617806"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 07:12:57 -0700
X-CSE-ConnectionGUID: wAGCWlnjQRugw1YHRvRXEg==
X-CSE-MsgGUID: 7PW61yx7RMWSyywfnIKRWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="170230819"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 07:12:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 07:12:55 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 27 Aug 2025 07:12:55 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.68) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 07:12:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjmzDHbE6ueS/6eE73hCqF6ckZ+TNVYBAxgskNylxTnpUED+p7vpyeCCfdcpiRdItnwNy9Ltrna0BR1Cy91+YDbpTi1cxtJZPBKHWffG3QRMAKXExoIv0ciimoTpc6Cg9i/pf2ZYhi3H0aCI1kbkhQgKo1oAr/yb5ePa5SGu8LhRMDbR1WK1Zx+/B0VPYmA8plS5NxytYJM432bLznLw/Af2YbMq+SUe9DYy5JHx/MhpnfcGe5K17M1LLYKEpKYAOem8p2Zfujj/6Ew3AF3e0QJMwVO8aiCh72Xv3FfmQhRy6Is7ty+/aTzhym91j5hHA7B4jNHZYZSl3A7jtctnhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9223fzuHA4FPOtnLaDe0DQfPt6xYfAyaokVCGZo0hU=;
 b=NmH5R6oV4J08uW2KeHlQjcvcb/A1txFs2iRr2C0im7TlnX4e2OcrUGXW2/UBUx/yQJGoV5EXjTo9PSr6xhwIsy32cTqCsZ9b+oOTD2tcfdtAqXC+ZDspx07JrfNb4IbO/cASQ5QNIRK/Dgtfb3MEAFZGlR/5y3CKOko/GvhOKNKu9Ht6uxx9wUXnbbGsnnZqV2Z9Z7PlFLMjK84Z1YHiHvSRtlAy8pYmfNCTwponn6riqOpfNakg3vyO7KFCv/nBOTaqGVaKAOXBxPXCtK/IKtUtCMoqDOKwYpqITowE4/mar2u/lim3Gf03yrOkKqb9toY08xI98YYgDmTMW1tiRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB8719.namprd11.prod.outlook.com (2603:10b6:8:1a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 14:12:53 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9052.014; Wed, 27 Aug 2025
 14:12:52 +0000
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
Thread-Index: AQHcE3q31HuRziJTPEK2T8WL/8xAvrRu3dGAgAAvBQCAAAthAIAETlGAgAMr1oA=
Date: Wed, 27 Aug 2025 14:12:52 +0000
Message-ID: <2491b7c6ce97bc9f16549a5dfd15e41edf17d218.camel@intel.com>
References: <20250822153603.GA27103@redhat.com>
	 <064735211c874bf79bfdf6d22a33b5ae5b76386c.camel@intel.com>
	 <20250822192101.GA31721@redhat.com>
	 <b483759593fb83ec977c318d02ea1865f4052eb7.camel@intel.com>
	 <20250825134706.GA27431@redhat.com>
In-Reply-To: <20250825134706.GA27431@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB8719:EE_
x-ms-office365-filtering-correlation-id: 5d531cd2-18eb-448f-6f12-08dde573cff2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VWVxaTBwY3dHazgyNkQxdWdncStITmxCbktFSElKZTFmYVR5ZUkxOFowYkZS?=
 =?utf-8?B?emxPVUwvQllMWUhQQjF3SmFoeGhMaW5LOFhIdGg0Z00zcEpTRTV1eXFhV0ZJ?=
 =?utf-8?B?NkN0RWdpOSthR0FSMGtBalo3VkQwVUtubWJWYWhCbkEvdHBxQWNydVRnZlRH?=
 =?utf-8?B?am5GN0lpa2l6NGo3UFd0L01sN3dNYjZ6Wjl4QmxEeXhLcUMvRlhWdUNJeERB?=
 =?utf-8?B?bXNXeUpXZ1ZwWlhvUHpUb1JWVVVkc2tmNnB1UEZCd2dvUVlQak5oViticnk3?=
 =?utf-8?B?c2dyV1pTUzhmRWQwOXAyYjFpa002dUtMb05PUmM2OTFnN0hpWkxtcjlETDk3?=
 =?utf-8?B?MHgzZzI3aitqQ3MyOTBQMm1mVEJYdHhZWmFpRjJjaTl4VWw2SVM2R3lYN29G?=
 =?utf-8?B?QjlHYkkyNDl2alU4TitBdW1nMStNQXRTQUc5TjF0N0JnT3kvY0hPc1lVbGE4?=
 =?utf-8?B?S3BISFhsMUxlWWhQd1lKa1FPSWQ2ZWV5elpQUkU3MllNR0lQaGJncmxHZEcw?=
 =?utf-8?B?N01Eb1N2anh6US9tUEJFOEIyL3dNMnBRcnJycXBUcXE0aXVwdEd6dFVKenN1?=
 =?utf-8?B?Rlp3eEdtYUdJUTJDS2V5alR2ZVF2dzFwVzBhR0s2WHI3RnNIZGlvSm9vdjV5?=
 =?utf-8?B?a29wWVMzRnFZcHNHci9jZExZSU80M0c2RHVDTWhuYVlwR2djZ3BsVUFpWWpq?=
 =?utf-8?B?dWJhMnRXZG94Ui9DUHZXSGs4MWRFTHNyMWxGMFlrQVNkZXJLejJEeW83UEdU?=
 =?utf-8?B?aVhpTTQwYmh2b3EwanVXZy9ZbG5UQjdYTnN0YzljQU5jM0dMdkcyT0pUcmkx?=
 =?utf-8?B?dCtLZDhncXo0alVMQWw4d21LYkhxSk90eURUM2JYYXE1STZYaTUwMjhEMFFU?=
 =?utf-8?B?a2N4YVZKQVFWbnZQOUxDSlZPUjdDOG1iV0J0cDBERWNWNUVvSTZDSm5oT0dt?=
 =?utf-8?B?ZlpScnV1cUxCbTJYQ29Cd0tyQjEvM3hPZkt2NHJveWtYQ0tNbmFRY2tzak5i?=
 =?utf-8?B?Mmcrb0IxSTQ0clYxSTYzbzQ2aXROd1BxbDZLWDdjblhrTWREWnRDWlhDdlRM?=
 =?utf-8?B?dS9XM2NXR01TRU0rREZiOHRVQkhTdkh3Qkx2Qk5lV3A5WVBVNTNSc3UzTVoz?=
 =?utf-8?B?NHE1dnU1U1BVekFiaEo0Ry9ENUl2M1A4S0JiUFJaUEZOTm9oTHR4NGZLaEN5?=
 =?utf-8?B?b1VGRnBRakhxYkw3TXVuQlA0YVBPa0diZVRpcVJVNTRlQks3V01CaFFLa1M0?=
 =?utf-8?B?RGNoVEZVWXRoVHdaOWx3Tzg1aEZ4c3JUbkMwNVlkZmlVaEo1NngzRlBVeWw0?=
 =?utf-8?B?N3VEVlBRY21rcmtsclN4MEZ3MCtFYXBud2VFTkpSVzNTTGpRakUycUE0dTNP?=
 =?utf-8?B?aEcyME1qT0NlbjRhS0RVS2ZxTUNIRGRpOFg0Znl6MXplWnVCdWFEbDJHcS9r?=
 =?utf-8?B?N2Q3bjhCSk1lUHRTYUozYm5INVMvQ0dUemFRa1d5YmpaZzh1R0hHK2wrcVNq?=
 =?utf-8?B?ajM3dHdGRzdvUG1nRXlnZ3kzdXhyTjUyVmd4RERja2ZBNGdKVjkvdmdZdWVz?=
 =?utf-8?B?Mjlod1V1QW5NcldDcjlLMlBEakpxRk8wSUkrUjJzQ0ZmVGFaQW9iYUc3aU9B?=
 =?utf-8?B?Unc2SEk5djVVcDUwbG0yM05KanB6YUY3SDBKNGdQY0FqYzIydnh5NmphaW5v?=
 =?utf-8?B?cVQ2eWlCR3ZIYVVGU2tLc3dJOEFFZmk4Q2Ezb2ZxUUJ2UG82RjRCei9WVmM2?=
 =?utf-8?B?NmVDVDRoS2d2S1Q5YUsyNk50RnBFcExsWlptVUkzVmZxc2NUSVBEUktwMm5I?=
 =?utf-8?B?T1FqMDdKY0VSTnl6K1dDMGc5TEZ4b1ZzOVdiSHl0b2VHYnBCZk1DMTlySFNJ?=
 =?utf-8?B?enhrVDc4Rkk4Rm1mQTBjUTRVclppZFBSQnhWZWJUTnBEdFcvR0tPRnZHRERw?=
 =?utf-8?B?YjhERDU5RmFQTkdpM2oxTklyeXlwRnpJUmgrWE5KNldCY1Y3RE1MNWo0akRu?=
 =?utf-8?Q?N8HyDH75qWgx8a+HbxpMEwy1rMFcbw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2p0RTcyVFNBaTNTZFlDbEJRZHF1eGdpSnY2WWRZU01PU0hzdXludEdoZUQr?=
 =?utf-8?B?U2UyTjl1WEN4M1FUMXk1R2p5NkhPeGlGQmYxVmlDSkY3ZHljWmFZc3IwVzJr?=
 =?utf-8?B?R2JIbkNXL0JFVXBuSlJSTWlzVUphMUh1SkVMeEZoWVF6aUE1RmI0eWZKTzRn?=
 =?utf-8?B?SGdLaDMrYnBqQ1BSL2JwT2JycFpwbzVweVl1cldYaEMxcXhId3B3a0tCcEtq?=
 =?utf-8?B?a0hML0w1dmJucTB3aTUwL2QrbEw3N204akd5WHRUYjc0Z3lGNWs0a0tYcVVs?=
 =?utf-8?B?N3ZTWE1BbHZXYTZrd1NkZFE2dWxCV1ZkT3dzY3U1SGdSQzgyMHBTb0pDWjNq?=
 =?utf-8?B?UFlQRDVBL0ZVTGJSVE1mZCtMVXFrT0Q2bkJXNExXN0QvNUs5SGp4clE1ZFI0?=
 =?utf-8?B?UmxDQnBLT1lleUZMTkJHVStxbi9KaHl1SEZ2Q2tFOWoyREVLSWN2RlVTMXJJ?=
 =?utf-8?B?OHorZWVHSHpZT2hjcjlQdnBYLzhyUlNQSGthQUl4UDRndWZmcmEwV2krWGhF?=
 =?utf-8?B?aVl4bFRCREFPaHFFRFZ0QXhlelI1M0RRTlJ2WWZhQ0I2ODMxMHZkSGRmQ3Q1?=
 =?utf-8?B?TUh0OGsvRlZ1ek03OG43dFVpSG1iSzVVanF0RzRMaUtobVozZXoya0ZaVGxh?=
 =?utf-8?B?bkxwVUt2R0daUnpBSGdiVVlIWUI0bk5jOHllZ1UwWUVhM3lUcTQybmNpYTU2?=
 =?utf-8?B?TTdjSmh4UDcrS1J0bWUvZHhnNDVndDhGVjFwc2IyRkVlSlhrellweU1McXQ0?=
 =?utf-8?B?RXE3N0FSS08vVms1N1V0U0U3VHIva09kMmhMZ3ErYWZCdXd1L3N2elJKOFFH?=
 =?utf-8?B?bFo0TURwRExYcW5DNFROOXovYW5KSE8zL1BwQ0FBMDEzOFp0TmVOeDJ0T2Vk?=
 =?utf-8?B?Qk4vaDVuWWwwUzRKbklzWGYzdGtBTDFlNDdRSkRGamVNZ3pZNDJ4cTAzaGtq?=
 =?utf-8?B?MDVTd01nbXdKa1cwN1M3WlR4aXdYS3RKV2ZnOGFuVGZVOTZKcUcyZ1FpS012?=
 =?utf-8?B?Y2ZqNVR4WWxBcUhweU54QTlaSUNCVUtBenBId29uSCtxVktkdllJeDdTQjZs?=
 =?utf-8?B?aGJnakVLTW1qSW5VUmxWRlNSaWhNMng4emFoOGxYYjhrbit6OE5aY1NON0RB?=
 =?utf-8?B?ZXNGU0d0ZkhGRkFQK2xwcU5ZV1JLRU1Ha2RXd0pnZS8xT2dZbS9icVdKWHVn?=
 =?utf-8?B?VWowaGJNN21HN3A4VWh4OWxWYjY4K09QcGsrWGRSbU1oWnd0UWtDQVd1YWYx?=
 =?utf-8?B?M3RiNDh3WlAzV1dXTVNZRit4ditKQXRRUVFQalZsUSt0aXUzL1ZWNjNFS2NS?=
 =?utf-8?B?d3lpT2gyeDVYc0FMMmNtZzFySS9la2pIbjlKQnd1dUhmcTU2UHFVU1VBL1hG?=
 =?utf-8?B?eHhiSmNZM2cxcmQ2SEoxdFBaRkxSRTNRLyt3L294S0VvWmo2VCt5dkFSWTRl?=
 =?utf-8?B?OE4xSHZDL3JINnYzYml5Z1Mvdkx0dThJak4rZktBT253aEpTaitTdlltOFpm?=
 =?utf-8?B?Q0Z5aU9lbTVITUVVeDBwMjI2MlR4b1dhWDVuZFFMVFhpbHJuK1lWUkQ5ZnhE?=
 =?utf-8?B?NEF0NHcwTlZUVlNmN3p5ZG9kZkJUSTJCZVh5MVh5L0JvbkVFTE9NQmpvQVll?=
 =?utf-8?B?d09Icm1WVjlFdVhLRGt5M0ZieEtsdkVYNmRZT2NXa29jakhQQ3pXUmZGK1RL?=
 =?utf-8?B?a1h1eFlsSmxRS3BjamFkQ25nVzFRMHR6a1lTbnYwSVFjNDZVQW5qQmoyTDFT?=
 =?utf-8?B?UTBDZXdCTEQyNE1LaEhhTVN0Zk51SDE1U3YyT1N1K1Y0QStWN3dFNWtBY0Er?=
 =?utf-8?B?R2Y3aGZ3UUtYR1dPYzJ5YlZ2Tm1ObE9xT2hLSDk1RjdjZXlyWUlha1BGZkE0?=
 =?utf-8?B?YzRmaEs2emExUnI1SDRXbEJ3NkRKcWhxVzNqZnM3WVRMT1FaWG14ZHNnYit5?=
 =?utf-8?B?YUdDUDdWOWdUZ0d1SDZWQVd4STlvcXlSZFVyMFYvZzNmSnR0MGNBNzlkUEdX?=
 =?utf-8?B?NlVsN3Q2VHVwd0hqb2NNVm92M3lqZU5FWEVYaEp6QUxUNjRsNnpmQXJaZEdX?=
 =?utf-8?B?Y0dOaDRaOElGeTA2V1E1eGwxdVQ4K01jOFU1OEZUbStKcEdBdGc4T2hLZDF6?=
 =?utf-8?B?RFFBZjdKME9QTkhUcVhRUmdSSTZJVTZnNjl2SlYwYmRJMjNtaGNTMkZxUE0r?=
 =?utf-8?B?UlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDC3F8D3BDEEA442AD55F4654381EB2D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d531cd2-18eb-448f-6f12-08dde573cff2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2025 14:12:52.8660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XfA03KT5ajys0X+ibZW2eCl0EDwMcbL4KGpgr62s4+x+cfEoULlyGCqeSE+IdAcrd/WIwliGL1UkAJfUhem6sGxL2YUMAc9qpikFFL8LDZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8719
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTA4LTI1IGF0IDE1OjQ3ICswMjAwLCBPbGVnIE5lc3Rlcm92IHdyb3RlOg0K
PiBJIHRyaWVkIHRvIGFkZCBtb3JlIGRldGFpbHMgaW4gdGhpcyAiW1BBVENIIHYyIDAvNV0iIGNv
dmVyIGxldHRlciwgaW4gcGFydGljdWxhcg0KPiB0byBleHBsYWluIHdoeSBkb2VzIHRoaXMgc2Vy
aWVzIGluY2x1ZGUgIltQQVRDSCB2MiA0LzVdIHg4Ni9zaHN0azogZG9uJ3QgY3JlYXRlIHRoZQ0K
PiBzaGFkb3cgc3RhY2sgZm9yIFBGX1VTRVJfV09SS0VScyIuIEkgdGhvdWdodCB0aGF0IHlvdXIg
d2VyZSBhc2tpbmcgdG8gZXhwbGFpbiB0aGlzDQo+IHBhcnQuLi4NCj4gDQo+IFNvLiBTb3JyeSBp
ZiBpdCB3YXNuJ3QgY2xlYXIsIHRoaXMgc2VyaWVzIGlzIG5vdCBhIGJ1ZyBmaXggb3Igc29tZXRo
aW5nIGxpa2UgdGhpcy4NCj4gVGhpcyBzdGFydHMgdGhlIGNsZWFudXBzIEkgd2FzIHRoaW5raW5n
IGFib3V0IHllYXIgYWdvLCBzZWUNCj4gDQo+IAlodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwv
MjAyNDA2MDYxMjAwMzguR0IyMjQ1MEByZWRoYXQuY29tLw0KPiANCj4gVGhlbiBsYXRlciB3ZSBj
YW4gcHJvYmFibHkgbWFrZSBtb3JlIGNoYW5nZXMgc28gdGhhdCB0aGUga2VybmVsIHRocmVhZHMN
Cj4gKFBGX0tUSFJFQURzIGFuZCBQRl9VU0VSX1dPUktFUnMpIHdpbGwgcnVuIHdpdGhvdXQgInN0
cnVjdCBmcHUiIGF0dGFjaGVkDQo+IHRvIHRhc2tfc3RydWN0LCBzbyB0aGF0IHg4Nl90YXNrX2Zw
dSgpIHNob3VsZCByZXR1cm4gTlVMTCByZWdhcmRsZXNzIG9mDQo+IENPTkZJR19YODZfREVCVUdf
RlBVLg0KDQpUbyBzYXZlIHNwYWNlPw0KDQo+IA0KPiBCdXQgZXZlbiB0aGUgV0FSTl9PTl9PTkNF
KHRhc2stPmZsYWdzICYgKFBGX0tUSFJFQUR8UEZfVVNFUl9XT1JLRVIpKSBpbg0KPiB4ODZfdGFz
a19mcHUoKSBtYWtlcyBzZW5zZSB0byBtZS4NCj4gDQo+IFNheSwgc3dpdGNoX2ZwdSgpIGhhcyBu
byByZWFzb24gdG8gY2hlY2sgIlBGX0tUSFJFQUQgfCBQRl9VU0VSX1dPUktFUiIsDQo+IHRoaXMg
Y2hlY2sgc2hvdWxkIGRpZS7CoA0KPiANCg0KRGlnZ2luZyB0aHJvdWdoIGdpdCwgdGhlIHJlYXNv
biBmb3IgdGhlIFBGX1VTRVJfV09SS0VSIGNoZWNrIGluIHN3aXRjaF9mcHUoKSB3YXMNCm9yaWdp
bmFsbHk6ICJtb3JlIG9mIGEgY29zbWV0aWMgdGhpbmcgdGhhdCB3YXMgZm91bmQgd2hpbGUgZGVi
dWdnaW5nIGFuZCBpc3N1ZQ0KYW5kIHBvbmRlcmluZyB3aHkgdGhlIEZQVSBmbGFnIGlzIHNldCBv
biB0aGVzZSB0aHJlYWRzLiINCg0KU28gYSBnb2FsIGNvdWxkIGJlIHRvIG1ha2UgdGhlIGNvZGUg
bWFrZSBtb3JlIHNlbnNlPyBJZiB0aGF0IGlzIGEgcmVhc29uLCB0aGVuIEkNCmhhdmUgc29tZSBj
b25jZXJucyB3aXRoIGl0LiBUaGUgc2ltcGxlciBjb2RlIHdvdWxkIG5lZWQgdG8gc29tZWhvdyB3
b3JrIHdpdGgNCnRoYXQgKEkgdGhpbmsuLi4pIHVzZXIgd29ya2VycyBzaG91bGQgc3RpbGwgaGF2
ZSBhIFBLUlUgdmFsdWUuIFNvIHRoZW4gZG9lcw0KcHRyYWNlIG5lZWQgYnJhbmNoaW5nIGxvZ2lj
IGZvciB4c3RhdGVyZWdzX2dldC9zZXQoKSB3aXRoIGEgc3RydWN0IGZwdSBhbmQNCndpdGhvdXQ/
IElmIHNvLCBpcyB0aGF0IHVsdGltYXRlbHkgc2ltcGxlcj8NCg0KPiBCdXQgaWYgc29tZXRoaW5n
IGdvZXMgd3JvbmcsIGl0IHdvdWxkIGJlIG5pY2UgdG8NCj4gaGF2ZSBhIHdhcm5pbmcgZm9yIGlv
IHRocmVhZHMgYXMgd2VsbC4NCg0KSSBndWVzcyBJIHF1ZXN0aW9uIHdoZXRoZXIgaXQgcmVhbGx5
IG1ha2VzIHNlbnNlIHRvIGFkZCBhIHNwZWNpYWwgY2FzZSBmb3INClBGX1VTRVJfV09SS0VSLCBp
bmNsdWRpbmcgdGhlIGV4aXN0aW5nIGxvZ2ljLiBCdXQgSSdtIHN0aWxsIHRyeWluZyB0byBwaWVj
ZQ0KdG9nZXRoZXIgYSBjbGVhcmx5IHN0YXRlZCBiZW5lZml0Lg0KDQo+IA0KPiBCdXQgYXMgSSBz
YWlkLCBJIHVuZGVyc3RhbmQgdGhhdCBjbGVhbnVwcyBhcmUgYWx3YXlzIHN1YmplY3RpdmUuIEl0
IHNlZW1zDQo+IHRoYXQgbm9ib2R5IGlzIGludGVyZXN0ZWQsIGFuZCB0aGUgb25seSByZXZpZXdl
ciAoeW91IDspIGRvZXNuJ3QgbGlrZSB0aGVzZQ0KPiBjaGFuZ2VzLiBJIGFtIGdvaW5nIHRvIGdp
dmUgdXAuDQo+IA0KPiBUaGF0IHNhaWQuLi4gQ291bGQgeW91IGV4cGxhaW4gd2h5IGRvIHlvdSBk
aXNsaWtlIDQvNSA/DQoNCkFzIEkgc2FpZCwgc2hzdGtfYWxsb2NfdGhyZWFkX3N0YWNrKCkgc2hv
dWxkbid0IGNsZWFyIEFSQ0hfU0hTVEtfU0hTVEsgYmVjYXVzZQ0KdGhlIGZ1bmN0aW9uIGlzIGFi
b3V0IHNoYWRvdyBzdGFjayBhbGxvY2F0aW9uLiBJdCBhbHNvIGRvZXNuJ3QgbWFrZSBzZW5zZSB0
bw0KY2xlYXIgQVJDSF9TSFNUS19TSFNUSyBmb3IgdXNlciB3b3JrZXJzLiBJdCBzZWVtZWQgbGlr
ZSBNYXJrIChhcm0gc2hhZG93IHN0YWNrDQpwZXJzb24pIGFncmVlZCBvbiB0aG9zZS4uLg0KDQpJ
IHRoaW5rIERhdmUgYWxzbyBxdWVzdGlvbmVkIHdoZXRoZXIgYSByYXJlIGV4dHJhIHNoYWRvdyBz
dGFjayBpcyByZWFsbHkgYQ0KcHJvYmxlbS4NCg==

