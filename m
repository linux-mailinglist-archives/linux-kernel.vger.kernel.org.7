Return-Path: <linux-kernel+bounces-797300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B144CB40E96
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DABC1B27D71
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1B12E764B;
	Tue,  2 Sep 2025 20:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVysv7BQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B6B2DFA2B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756845438; cv=fail; b=M7KsgH0NB1uH0vvobx3i9j+yEEyGOlb5Xc4RLFK17B1Sn6sV3cQHdYHaaOBQoVen9K74CjJrHVkTmANsnAtKXK7L7GE29jYLc952rnhTSUurKv8uq7PY3oP/kGLUF6me5I/d3FchnxUMziWSLWCpT7OUloHUna74/OXsolhx4UM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756845438; c=relaxed/simple;
	bh=PwkjQebpriUclmmYsTYiEOEQPfp5hCW5h15aHJAqKXI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SRejvEQ4bBfM29a8a0POgo6TRJ5SIE0OGf2zliXDnqJMgSNGfVgnczKHnhgvUvUT8rmOGNXASkKPJn0Ai8m6SFpbnsmD9f+5Kt3GpmqoIXFTLnBNYFvvEE4HclYivi+j1R32RtyysZhwRyxRZ5CYwmSS4Y91gxxQTBEB7yZhCQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVysv7BQ; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756845437; x=1788381437;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PwkjQebpriUclmmYsTYiEOEQPfp5hCW5h15aHJAqKXI=;
  b=cVysv7BQmcbZOftrVesddQGwMv9cczdD6/leVFq21xqNYjg6Zo1ZmEhs
   URqd230K6rh56FvSuSTgd5Go5B9Ikhn1dUYKesmIzcTHIpu6TkWnzGRap
   HAOLV3n7zYp31d1ZcVtteZ6qlddGCg1/MIqNTiNRW5f/sZk1OFYMbkQPi
   fordmQdZMgh7DmQgCQNc/qX447O2lKxEPldoM14mpZ9w4cx6xp544dx5w
   E/ZcIkst0TbfKmSK/QCzQRV2S9A2ZPrbP5T68vp3dMYCJkvULOqGp+8gt
   xLQmvPGo8HSSho/aYqUUhOPK0NW0itpO1Z5jhVD+fjtyYYZmxUqCIdXN+
   w==;
X-CSE-ConnectionGUID: ZsFmKNQgQwu4e7m3RSecxQ==
X-CSE-MsgGUID: 0oxEoRqzRz2AqyerWjGcLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="84560063"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="84560063"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 13:37:16 -0700
X-CSE-ConnectionGUID: n+1oY/CQTUeXBsdOAebXBg==
X-CSE-MsgGUID: A9N/YTBMSHSJAvpMd0KvjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="176683531"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 13:37:16 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 13:37:14 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 13:37:14 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.63)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 13:37:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ubcd53IrV9sRfOAZKAJ2Hi9ze2FBOXl5rS1hlKX/dmOIqhiX9pYR+4XMSQL10e3RUmE2Y9CP/GKJ9bRZp4zE3LzXB5ZvoRw4/AJ2dMkx4RriYYF0mdnUa0HXSYPegRrLoP88Vo7puoNsn7pSotZrTNttx+BuibRtGGb/EZ7AaKG9kSfGl6/tt9fxIeOik3oBK2brofIdWLn5fLEQ2NWBo8F9h9eyuuCr5xzfBkmjOSGj08Sc1rxWeb4eXdTKJUSPk2Bw7ylu0ok0jrzQDc//KQSLldjtRjB3Jn6hOrflB/dNobK3HrIn/rS26YMwtjpYnD6AH1XfMw0JMZ9kLrx8KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwkjQebpriUclmmYsTYiEOEQPfp5hCW5h15aHJAqKXI=;
 b=e4QIfH8WDp3S1wUJheJB4igrmZOf0auBS9A4LbedhgEgm+Gs7Yl9VT9CLXJ1dEkQVHFcy7bZNG+5/Eu4gJAOma+NPcMNY8RY6UCB81k424ZSyzwsSmOO3IueZ78qbKYvj7KkBji2ogGu9UTKWEeOzdIfiG1EtONDc9fqFS4qc0CXF4UCk6D7nM88hlp6OkWlJaR0iFNYjzJCXSWByH5PSzfOH6fPfOe5tEi7fbw/0bVOX8XiLYP/r6pKQ6C4YF2DwVtQD+lxdfcJBCRVpo2gsUnRX3P+xE0vLhnFVOL1GeV67aFURDMqhaoqHuTEzkMOhkRskSBRK3VWDEn8ylMxDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB7359.namprd11.prod.outlook.com (2603:10b6:8:134::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 20:37:12 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 20:37:12 +0000
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
Thread-Index: AQHcE3q31HuRziJTPEK2T8WL/8xAvrRu3dGAgAAvBQCAAAthAIAETlGAgAMr1oCAAAr0gIACBpMAgAEiCACABqXUgA==
Date: Tue, 2 Sep 2025 20:37:12 +0000
Message-ID: <e653fb9cab51ed2d0ea71f9d322c55420a83a4f5.camel@intel.com>
References: <20250822153603.GA27103@redhat.com>
	 <064735211c874bf79bfdf6d22a33b5ae5b76386c.camel@intel.com>
	 <20250822192101.GA31721@redhat.com>
	 <b483759593fb83ec977c318d02ea1865f4052eb7.camel@intel.com>
	 <20250825134706.GA27431@redhat.com>
	 <2491b7c6ce97bc9f16549a5dfd15e41edf17d218.camel@intel.com>
	 <20250827145159.GA9844@redhat.com>
	 <4249e18ffed68e8038624021aa3a6f06b64eeb85.camel@intel.com>
	 <20250829150605.GA6035@redhat.com>
In-Reply-To: <20250829150605.GA6035@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB7359:EE_
x-ms-office365-filtering-correlation-id: fa71c413-a940-4a56-7a94-08ddea607f1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S1JpdDBYbDRpMmJnODR5Z20wZElFRHppR210czY5d0FzY25OVXBZRS9ZeGRo?=
 =?utf-8?B?UEIyRlQ2a2ZYVVZZRmZWOFJFN0VqM3psd3FISXkzSkMxckpJMGFuT0pXWVFr?=
 =?utf-8?B?M2N1R2ZQbGtzMW1mSmdsU0NFU0FFQm12ajFyZmVaK3hSbnozdzB4eFcwLzI0?=
 =?utf-8?B?TFlJc3ZWVTFBbklRTUlUblM3WXJKaFhQWkJHNXdiRTZXZ1pKelR3MGhISmZ6?=
 =?utf-8?B?VUhmY3BHK1VyT2FnMGdiczhBTTlwQWZrN0kxMVhrSUtjZWhzcmpNUFRsc1My?=
 =?utf-8?B?RG1YaTNvc0pNeW80UWk3bGZEZWFxQU43cFpzQW1rNzVXTnY3ckxYdjhPbldI?=
 =?utf-8?B?elA1WG1DQWxoNGtsbnNrWjhPTnJ1a21qQ3JWTU1nVXYva0xHUm5vU0l1T21i?=
 =?utf-8?B?M0dETEQraGk4ZTY2Q25CL1RMWWNKRTFKcDJiOHlZS0hlVVArU1Y1MVhNYUpM?=
 =?utf-8?B?QXBqY1loMGNEN1VwQzhZK0hNYVphVzV1L09mN0xQTm5iL1FhSW1od0VBR0JI?=
 =?utf-8?B?dCtGQXFaSFFCVi85OEhZb1ByS21Pb3JhUjFjdzR3V050eDNjdUpQOExMWjFQ?=
 =?utf-8?B?NVFkWkxKUmlTZFNlK08zQlVUSzRPVGNyaHc2UTREREE4T0gxVVBFcUEwVWlS?=
 =?utf-8?B?OWNrTkc0R3lvWTIrR2c0dmh4aHBCVDUvVlBRcGFObEZYSFRPR214Vi9LWU1I?=
 =?utf-8?B?a2VUQXZ6Ry9IQlM2K2ZKemNwcFo4VGFhZE0vdGdjaFRmTzY0QjhqaHVGb25q?=
 =?utf-8?B?V0lUamUyVkQvZlNLZjFQN1MrRzBCMHJhUVFDSFV3S3V5dkpxM1M1NlNDM1dw?=
 =?utf-8?B?c0VETjMwTmFOd2dsSDdLbEYydGdPS0s0VmlFSTlBcjhxZERib0l2cFZDV0pB?=
 =?utf-8?B?WFhpUEdtb2lPVkJ4Y1Z0RkVldHRVS3lsTFFFQTJWQVFJbDRLaFViUmZ0elY0?=
 =?utf-8?B?VVVpWmplN1RqcjV5bStSSEpVb2NUeTYrM0Njb3JJclBXNWhwSUNmeSt0S1Z3?=
 =?utf-8?B?L1FybE05eEVoNG0zUlpZNUtLbnpaclZTZUJuK0VrYVZGeUNpNmxDMEhQYnFB?=
 =?utf-8?B?ODgrYzhKM3Q3Mmc5QXdjMVZ2NDc5SlZjOGdCT0FXa0dVdktjSlBVK3dqYjQ5?=
 =?utf-8?B?blJyTGFycVVFbHFINjZ1VlJCeitaUUV4czN0OXNydGovUG5LRTRvODA0UzM2?=
 =?utf-8?B?OG1uMUtPVjNaY0tad1o0eDFqV2lzcmZoVUx6ODZpQ0tNbUYwWmJYcERhenBu?=
 =?utf-8?B?TmJ4RDlZTHJ6M1J4dFRHQjZFeUt2V091bEFyNjc3dDdoTkJLT2RlT09remh5?=
 =?utf-8?B?eldTeFRnQjNEMWxIMGE0UXBid2ZWUm1PZnNHRFptaGFBN0k0UitmNmVMeGs5?=
 =?utf-8?B?enpJMzM0NXZqVnFzTHpVakJkWHU1VHRnNkViY2V5Vk9HbnNDYm1BaGFjbjdQ?=
 =?utf-8?B?Y1Rhb2tVS1JPeWVoQ1R6dGVQMCszY2lBczlkTXpGUkFqWVdNN0JZeEZINUVo?=
 =?utf-8?B?QnlpNy92RXpMdHJBT3VTV3ZDN0p2TjZ0cys4MzJNYXZ0amhGUjFPajRxU0V2?=
 =?utf-8?B?OGxNeUpBNlVPSmhyNWkrODdIZlRTSStJWUVJWnVIY3RiVG9zaVJYM0ZrcjBm?=
 =?utf-8?B?ZU1kZE9nY1pRK3BnVFM3eURaNVpOOHB6OG5OWEZYc3dQWjBrQjM0WHhEdXJP?=
 =?utf-8?B?L29GbndXOU5NZ0dXcm9JVzYwMy9ZZXZqdTJTUnNwWmE2dFYyejJoTEd6dXhO?=
 =?utf-8?B?RkpHOW5GUjQ4ckg5elM1bjh4dXBjNzEySUk2UnNMazFVUDZhb3FzRE1rcjR6?=
 =?utf-8?B?ZHcrRlRUZEpFRHFzZHdEandrck1qVUdTQU0za1VhRkdRbTFudFFoemUrOVM1?=
 =?utf-8?B?N0MyNmdMQ0lraUJRQXpMODlVeEtneHJBN3dHeEcyazhBUmtadTdZWTJaYld4?=
 =?utf-8?B?MzlqUkMyRHZ3MXcxM2xvOCtmTVBzWk1BTEJUUVUxWkd1K05DdkpoWWUvbXY1?=
 =?utf-8?B?UktXWURLY25BPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmJMYklwc24xUW5MdDNsbHl4SlhNbG9vVlQzck1sUUxLSDRscFdmaG1lcG5X?=
 =?utf-8?B?dFBOaThVR2tWemlhUDB3K3o0WW5hbW14b2hVdzFvM3g0TDBuTXBCS21GNGpQ?=
 =?utf-8?B?SllVZ05PK2Z0YXVWUWJ2NUl1eVFlVE9oZDhmZFlHRktEYU5ONXJGL2lpeWlW?=
 =?utf-8?B?RTcrdGFQLzBXaHMrZkdFVXU0bG9ERzJjT0dMMFNiN2Q3WmJFem81ZGoyRTNp?=
 =?utf-8?B?RDRVTWJjam5ocFRtM3JORmRuMTFrZGkwWXRtajdjaDMraFZBTkszQTNDdEhS?=
 =?utf-8?B?eDlOeGMvRGl1RmZTQTllT1pPclM1N1RGZExSNFVPNytGNTJ1TWlUZ3IrdlN5?=
 =?utf-8?B?eVlJSHl3ZzZmWEpoQUtYTTRXOGNiTWdGbVpwcVY1dWVHR0xKanNSd2tnZVBk?=
 =?utf-8?B?TjVTZFJYT2tjcnZWU2J6azRRdk0rZkZpL2NWdXpwQTRQY2JzNUtGd3lhT0Rl?=
 =?utf-8?B?em5RcGlxeUFqNHNkUjU2Y1dUTjNJemRmclRGVE11WE1xbi92U2N5VkZhUFJL?=
 =?utf-8?B?YjhvTlMycXVyeW9jUThPVS9UOUV4OGpXZy9hTzRFbWU3L29wVzFmVjlKR2hH?=
 =?utf-8?B?WFlRL0E3dXhzamtpZUJDakZGVGhha2lhZisyWlQ3b3J0eVlsQ2dLT1dvWU00?=
 =?utf-8?B?bFV1bjVZRDdWeHVPRzlCNGV3cXZFYUY5ejJPM2FTVm41alZqNGJNMkt0TnNY?=
 =?utf-8?B?cGtMQ016Sm1aaThZQUxFUWxNR0d2WGw0RjlMYTNDU0lwcnJwa0k4ZVV5ZEJ3?=
 =?utf-8?B?cUcyUHdqK01TWnRjcGl0UUtsTVViZWI1WE9xK01adDF1eXVKd0xsWXVSa3F6?=
 =?utf-8?B?d2tWenhYYmszN3JQV3hNdkwzSldQNXpyRDFlMjdMVVJGSXAwcUczUDJFZ1lh?=
 =?utf-8?B?VlJlSVVOQkRUR2hsWlk4MDk3bkVpd3VqR2RqS25wWGRlQW5PSjRmTUV1VXQr?=
 =?utf-8?B?MnorTk0wYU4xdEhNTHFLQzhLVXZyYytEK3kzZGp6MS9zTER1UGN6U0JqQlcv?=
 =?utf-8?B?YXVjeGtkVVg5N0szcUpCbXVVUHNuRzRGZ291V0lTTmFlTGZ2V0NkWTAvZUNy?=
 =?utf-8?B?TDJ6b200VEhMcWlHQ0Y1Y1dlTGNDQzI2NXcvV0pON1NsaE9nUVVjb2FNTjZS?=
 =?utf-8?B?dDhWSmJ2TWRSWkZEaFhxeXczbHZadW10R3RERFJOOFJLZTdWODl2TkUyZHhN?=
 =?utf-8?B?bERjR213Z3VUYnFQNXZCNmJkN2JDSVhyRStJakVIbktTd29EK3hvMitpZHo2?=
 =?utf-8?B?MXd3VFZJdS94c1d0Z1ZUMFJhY2pqSHU4WlJTNHp6TTZXdFNsS0hIMTZxUFNW?=
 =?utf-8?B?WEVQcmhDU1JLZnJPV05JNXNGWUxyelhDZlE3Q2JqTUdzQittM1lYTk1zUXp2?=
 =?utf-8?B?blRtV1lFY2NKTHRac3NlSGtndTZRMVlVVit3RXVGWUFFenA4eSttdjBuaDAw?=
 =?utf-8?B?VWJIWW4zY21MQTl4cGFzcGpsMWxrekxmSlJtem1Ia3dFam1Od3h3bUV1Mkcw?=
 =?utf-8?B?V2EwUUh3dkIvUko0S1QrRjZ4aUluK3k4bDVqN3hSM2hlYU1HY0JoL3gvQXB2?=
 =?utf-8?B?WlNzSnRQSmRMblppaWQ2WWRNenVzOGoydUVLNENBdzVRcVFFalRtL2UvU0Vp?=
 =?utf-8?B?b2pvL0lEQ3pZWGxUUlN0NTBTM2t0a3dZdW9LWlovQkxtMm04VDRERU1LNTBn?=
 =?utf-8?B?M0drdklPOG1HNzR1Q1hNNWhSbEpmNUdJVk5YS1Roc093TG5uQmpGQVdXSlRs?=
 =?utf-8?B?anhqT1lESFZPTGZjK1VZK2QxQzVoc0pGbTBFdEVIMjJLd0lRWWFUR0t1QllI?=
 =?utf-8?B?Q1A4U0pobnFzdzd4NE1MVmxPSjNSMi9WamJVRnQwcklZdUp0aUVCZUNidVUv?=
 =?utf-8?B?amdocmZXVnBCb1VTMWdqdEpxMFYyZzdSZHNNWTFpWHl0TThjQWttTHJLOHpC?=
 =?utf-8?B?NzZwQ2ErNCt2L1l0ZkJ3cmd0dnh2Ny9sWUtENTZpZW1SeTN5Um9mRXpFRlFm?=
 =?utf-8?B?MmZac2hGOTZZS2Q5Z3g4OGVMMUVweEI1dHFzQjdtZHhZWW1xT2RSSGlESG81?=
 =?utf-8?B?bWdVa01pN2R3dGczcWYzNllpRnF5QXQ3VjJVanBLQjdNUzRZdHl1NXlYdUZO?=
 =?utf-8?B?endPTkdubENkUG15SHZNMk8yUHY3STdmak5PT3RpU29FTW5EZk1nNUE2YUN1?=
 =?utf-8?B?MGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27D9CA870896F94C9941C73E3EF8D3EB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa71c413-a940-4a56-7a94-08ddea607f1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 20:37:12.6757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qurmPnHTMCKe321L+x2siZkxg9MvJNH+VA74bzjeaGjsXlv8CB31hpSpNI1XDm/Vp4wQtLsoptZBaXIME/skt6e081KoiXgrSHXhzzuagp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7359
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTA4LTI5IGF0IDE3OjA2ICswMjAwLCBPbGVnIE5lc3Rlcm92IHdyb3RlOg0K
PiA+ICpJZiogd2Ugd2FudCB0byB3b3JyeSBhYm91dCBhbiBleHRyYSBzaGFkb3cgc3RhY2sgYWxs
b2NhdGlvbiAod2hpY2ggRGF2ZQ0KPiA+IHNlZW1zIHRvIGRvdWJ0KSwgd2UgZG9uJ3QgbmVlZCB0
byBjbGVhciBBUkNIX1NIU1RLX1NIU1RLIHRvIGF2b2lkDQo+ID4gYWxsb2NhdGlvbnMuDQo+ID4g
T3RoZXIgdGhyZWFkIHR5cGVzIGFscmVhZHkgYXZvaWQgaXQgKHZmb3JrLCBldGMpLiBTbyBqdXN0
IGFkZCB0byB0aGUNCj4gPiBleGlzdGluZyBsb2dpYyB0aGF0IHNraXBzIHNoYWRvdyBzdGFjayBh
bGxvY2F0aW9uLiBNYWtlIGl0IGRvIHRoYXQgZm9yIHVzZXINCj4gPiB3b3JrZXJzIHRvbywgYW5k
IGxlYXZlIEFSQ0hfU0hTVEtfU0hTVEsgYWxvbmUuDQo+IA0KPiBGcm9tIDAvNToNCj4gDQo+IAlI
b3dldmVyLCB0aGVyZSBpcyBhbiBhbm5veWluZyBjb21wbGljYXRpb246DQo+IHNoc3RrX2FsbG9j
X3RocmVhZF9zdGFjaygpDQo+IAljYW4gYWxsb2MgdGhlIHBvaW50bGVzcyBzaGFkb3cgc3RhY2sg
Zm9yIFBGX1VTRVJfV09SS0VSIHRocmVhZCBhbmQNCj4gc2V0DQo+IAl0aGUgQVJDSF9TSFNUS19T
SFNUSyBmbGFnLiBUaGlzIG1lYW5zIHRoYXQgc3NwX2dldCgpLT5zc3BfYWN0aXZlKCkNCj4gY2Fu
DQo+IAlyZXR1cm4gdHJ1ZSwgYW5kIGluIHRoaXMgY2FzZSBpdCB3b3VsZG4ndCBiZSByaWdodCB0
byB1c2UgdGhlDQo+ICJ1bnJlbGF0ZWQiDQo+IAlpbml0X2Zwc3RhdGUuDQoNClllYSB0aGUgcHRy
YWNlIGNvZGUgY3VycmVudGx5IGFzc3VtZXMgdGhlcmUgd2lsbCBiZSBhIG5vbi1pbml0IFNIU1RL
IEZQVSBzdGF0ZS4NCkJ1dCBpZiB0aGUgaW5pdCBzdGF0ZcKgaXMgY3VycmVudGx5IGFzc29jaWF0
ZWQgd2l0aCB0aGUgRlBVLCB3aGV0aGVyIGl0J3MgdmlhIGENCmNsZWFyZWQgY29weSwgb3Igc29t
ZSBwb2ludGVyIHJlZGlyZWN0aW9uIGFzIHlvdSBwcm9wb3NlZCwgd2hhdCBpcyB0aGUNCmRpZmZl
cmVuY2U/DQoNCkhtbSwgSSBhY3R1YWxseSBkbyBzZWUgYSBwb3RlbnRpYWwgY29uY3JldGUgaXNz
dWUuLi4NCg0KZnB1X2Nsb25lKCkgd2lsbCB3aXBlIG91dCB0aGUgRlBVIHN0YXRlIGZvciBQRl9V
U0VSX1dPUktFUiwgd2hpY2ggbWVhbnMgaWYNCnhzYXZlcyBkZWNpZGVzIHRvIHVzZSB0aGUgaW5p
dCBvcHRpbWl6YXRpb24gZm9yIENFVCwgImdldF94c2F2ZV9hZGRyKHhzYXZlLA0KWEZFQVRVUkVf
Q0VUX1VTRVIpIiBjb3VsZCByZXR1cm4gTlVMTCBhbmQgdHJpZ2dlciBhIHdhcm5pbmcuIEkgd291
bGQgdGhpbmsgd2UNCmNvdWxkIGFkZHJlc3MgdGhpcyBieSBqdXN0IHJlbW92aW5nIHRoZSB3YXJu
aW5nLCBzaW5jZSB0aGUgY29tbWVudCBpcyBpbmNvcnJlY3QuDQoNCmRpZmYgLS1naXQgYS9hcmNo
L3g4Ni9rZXJuZWwvZnB1L3JlZ3NldC5jIGIvYXJjaC94ODYva2VybmVsL2ZwdS9yZWdzZXQuYw0K
aW5kZXggMDk4NmMyMjAwYWRjLi4wOTRhODkxYmZlYTggMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9r
ZXJuZWwvZnB1L3JlZ3NldC5jDQorKysgYi9hcmNoL3g4Ni9rZXJuZWwvZnB1L3JlZ3NldC5jDQpA
QCAtMTk2LDE1ICsxOTYsOCBAQCBpbnQgc3NwX2dldChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhcmdl
dCwgY29uc3Qgc3RydWN0DQp1c2VyX3JlZ3NldCAqcmVnc2V0LA0KIA0KICAgICAgICBzeW5jX2Zw
c3RhdGUoZnB1KTsNCiAgICAgICAgY2V0cmVncyA9IGdldF94c2F2ZV9hZGRyKCZmcHUtPmZwc3Rh
dGUtPnJlZ3MueHNhdmUsIFhGRUFUVVJFX0NFVF9VU0VSKTsNCi0gICAgICAgaWYgKFdBUk5fT04o
IWNldHJlZ3MpKSB7DQotICAgICAgICAgICAgICAgLyoNCi0gICAgICAgICAgICAgICAgKiBUaGlz
IHNob3VsZG4ndCBldmVyIGJlIE5VTEwgYmVjYXVzZSBzaGFkb3cgc3RhY2sgd2FzDQotICAgICAg
ICAgICAgICAgICogdmVyaWZpZWQgdG8gYmUgZW5hYmxlZCBhYm92ZS4gVGhpcyBtZWFucw0KLSAg
ICAgICAgICAgICAgICAqIE1TUl9JQTMyX1VfQ0VULkNFVF9TSFNUS19FTiBzaG91bGQgYmUgMSBh
bmQgc28NCi0gICAgICAgICAgICAgICAgKiBYRkVBVFVSRV9DRVRfVVNFUiBzaG91bGQgbm90IGJl
IGluIHRoZSBpbml0IHN0YXRlLg0KLSAgICAgICAgICAgICAgICAqLw0KKyAgICAgICBpZiAoY2V0
cmVncykNCiAgICAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsNCi0gICAgICAgfQ0KIA0KICAg
ICAgICByZXR1cm4gbWVtYnVmX3dyaXRlKCZ0bywgKHVuc2lnbmVkIGxvbmcgKikmY2V0cmVncy0+
dXNlcl9zc3AsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKGNldHJlZ3MtPnVz
ZXJfc3NwKSk7DQpAQCAtMjQxLDE1ICsyMzQsOCBAQCBpbnQgc3NwX3NldChzdHJ1Y3QgdGFza19z
dHJ1Y3QgKnRhcmdldCwgY29uc3Qgc3RydWN0DQp1c2VyX3JlZ3NldCAqcmVnc2V0LA0KICAgICAg
ICBmcHVfZm9yY2VfcmVzdG9yZShmcHUpOw0KIA0KICAgICAgICBjZXRyZWdzID0gZ2V0X3hzYXZl
X2FkZHIoeHNhdmUsIFhGRUFUVVJFX0NFVF9VU0VSKTsNCi0gICAgICAgaWYgKFdBUk5fT04oIWNl
dHJlZ3MpKSB7DQotICAgICAgICAgICAgICAgLyoNCi0gICAgICAgICAgICAgICAgKiBUaGlzIHNo
b3VsZG4ndCBldmVyIGJlIE5VTEwgYmVjYXVzZSBzaGFkb3cgc3RhY2sgd2FzDQotICAgICAgICAg
ICAgICAgICogdmVyaWZpZWQgdG8gYmUgZW5hYmxlZCBhYm92ZS4gVGhpcyBtZWFucw0KLSAgICAg
ICAgICAgICAgICAqIE1TUl9JQTMyX1VfQ0VULkNFVF9TSFNUS19FTiBzaG91bGQgYmUgMSBhbmQg
c28NCi0gICAgICAgICAgICAgICAgKiBYRkVBVFVSRV9DRVRfVVNFUiBzaG91bGQgbm90IGJlIGlu
IHRoZSBpbml0IHN0YXRlLg0KLSAgICAgICAgICAgICAgICAqLw0KKyAgICAgICBpZiAoY2V0cmVn
cykNCiAgICAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsNCi0gICAgICAgfQ0KIA0KICAgICAg
ICBjZXRyZWdzLT51c2VyX3NzcCA9IHVzZXJfc3NwOw0KICAgICAgICByZXR1cm4gMDsNCg0KSWYg
UEZfVVNFUl9XT1JLRVIncyBldmVyIGRvIGdyb3cgdGhlIGFiaWxpdHkgdG8gc3Bhd24gdGhyZWFk
cywgZnVydGhlciBjaGFuZ2VzDQp3b3VsZCBiZSBuZWVkZWQgdG8gcmVzdG9yZSBDRVRfU0hTVEtf
RU4gZm9yIHRoZSBuZXcgdGhyZWFkLiBJIGFjdHVhbGx5IHRoaW5rDQp0aGlzIGlzIGEgZnVydGhl
ciBwb2ludCB0b3dhcmRzIG5vdCBoYXZpbmcgc3BlY2lhbCBsb2dpYyBmb3IgUEZfVVNFUl9XT1JL
RVIgRlBVcw0KKGJleW9uZCB0aGUgUEtSVSByZWFzb25pbmcpLiBBcyBpbiwgaW5zdGVhZCBvZiBt
YWtpbmcgdGhlc2UgcHJvcG9zZWQgY2hhbmdlcywNCmluc3RlYWQgcm9sbGJhY2sgdGhlIGV4aXN0
aW5nIGRpZmZlcmVuY2VzLiBCdXQgSSdtIG5vdCBzdXJlIGl0J3Mgd29ydGggaXQgYXQNCnRoaXMg
dGltZS4NCg==

