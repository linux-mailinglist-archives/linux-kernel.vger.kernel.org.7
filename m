Return-Path: <linux-kernel+bounces-887104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C410C374A5
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 19:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E3C3BA43D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 18:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B3127F73A;
	Wed,  5 Nov 2025 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VUMvaUCj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A829F279DCD;
	Wed,  5 Nov 2025 18:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367136; cv=fail; b=A3w3q1/1+sR5rPXBW8OuYMp+VXqY4CCzCZZCWFHWCw3sXvqlzQo7C0VnvX7nFL7AE84moxa0f774csaAuy816kBdKbEODBwUcUgFmE9DhSuLX5Jn6e7cptUKLJXoVZeqNri3zO9Tp+Qm0A7dKpoijX8SWLhG4331BnxdW/Q+xpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367136; c=relaxed/simple;
	bh=6vJ6glsWIoVT6GLnS6f89dNRasyiVRey7n3S47Y2tNc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SyC59vW6ix1K8Og+6EAm5OLUIFLlm5w+xVjmrMPwWV9fxF8mlQy0cuLykiFP7kFb6RAA8IIdi/9yykBxk5Uffu1NTN5eSQku+OjRcv7L/1q2gei8x3pqEMiZACjCS8aDLpuUirShqdeSntM0uX7eIObSNI0ObnNxtAQ8+ljZizI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VUMvaUCj; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762367134; x=1793903134;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6vJ6glsWIoVT6GLnS6f89dNRasyiVRey7n3S47Y2tNc=;
  b=VUMvaUCj+j8PVFdWBhFsXijTTkkEANZVCA7fhcYW4HTXwiGvmI62Ugeu
   SY9GUctgjvx0J6bIzQ9g8naO3kf6EWJlp+GOaE6+cJ/d0HU5ZlnNEA5na
   pfZDPt19vGlkTQ/fqY4dBNbg3fRU1cR4adG/5ulLUk0Y9w++2dDu3/8CN
   zUxNyR5Nq8ihd9QyQ4BJQyaxz3Zrvh7XO0HPfwYvLSZIwiS1UK8GjJ+PW
   HPMgPb66Tv+ZOjaiQTZIUrm6uJzj6tgpGSC8ocVS+YJKqx0wG6Qn2F0tL
   RR2hGCsD6ppk6XslLNHNM3EQPGS7WSD6DIDB+knMdj2rVn2SSvuVyBowo
   Q==;
X-CSE-ConnectionGUID: cQIE5O5aQ7+l2im9IPr14g==
X-CSE-MsgGUID: cfnZ3uN3RiSFBdayeV0csA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="63697128"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="63697128"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 10:25:33 -0800
X-CSE-ConnectionGUID: 80YsD9wcTra6boGsskwstg==
X-CSE-MsgGUID: 71KdawdVSHWUROAc4iEd2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="192593507"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 10:25:33 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 10:25:33 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 5 Nov 2025 10:25:33 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.28) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 10:25:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jecYfLFRz0KPhZp4I8cdeBdxg0Ag7gXmA3BFxUYVdQtaX5kDgdiP4lEjIkxtMV0TEGoSiBiaSh2oqlPHvd232ZtU+MQaxx9Ynsp/+uzNms+QDV6MVtuggkiJN5lW3jPOUQ8BxETx+EA9D74g5kAmhj1a7ZETaf/N1iOLVQ88D7gYa8APUWxEd38RKSxV12Y8HYGEwEi2TiG1wtHH3tI2VYeajQTp6daHzfcZV9o+li1/wyXYvJKWPtqcPt7+eVhvy+d6dMFPD9JFeriboMUTGEHbl6QfHqHiCkv6fAaN49tA3pS7CFRihtJNekril5wsIGsqcjTXdcg7rmK6JAAe5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vJ6glsWIoVT6GLnS6f89dNRasyiVRey7n3S47Y2tNc=;
 b=J+Eka2vs2bVcY9Y2GAAGJ+Om1UpGGr8fOYX7AVKGZwKz+ZiwfUD5G+POKXdOTtUGt+Wp0akeGY/Jh1oWNQ7e01ebqJ2Wrj5jFUAOmdZSfsaMFMPj+LDmiHEH3/4EIkhH9PHQYh2Bk91h8zwIIv0xKAaXY34F7dJbN7YH2903EudtZnmoJnPEgmasOeYrcjW6G5xKUEGiSofq1pH7ijEoMDe1sCWpH//g7N1RpuTWY36MSXsYNIqxGMjDGg90YVkoLNumadFVUOEJKC/Ha07HXmm6ltmkSjkgT3+Vg8hkF8GW+TqPLNtPLyctkeaG3qX/1G5c8gmrcUbveyOdHR6HyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA3PR11MB8966.namprd11.prod.outlook.com (2603:10b6:208:572::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.18; Wed, 5 Nov
 2025 18:25:28 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 18:25:28 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Moger, Babu" <bmoger@amd.com>, Dave Martin <Dave.Martin@arm.com>, "Babu
 Moger" <babu.moger@amd.com>
CC: "Chatre, Reinette" <reinette.chatre@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "james.morse@arm.com"
	<james.morse@arm.com>, "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "rdunlap@infradead.org"
	<rdunlap@infradead.org>, "pmladek@suse.com" <pmladek@suse.com>,
	"kees@kernel.org" <kees@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"fvdl@google.com" <fvdl@google.com>, "seanjc@google.com" <seanjc@google.com>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"xin@zytor.com" <xin@zytor.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"jarkko@kernel.org" <jarkko@kernel.org>, "Bae, Chang Seok"
	<chang.seok.bae@intel.com>, "ebiggers@google.com" <ebiggers@google.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>, "ak@linux.intel.com"
	<ak@linux.intel.com>, "mario.limonciello@amd.com"
	<mario.limonciello@amd.com>, "perry.yuan@amd.com" <perry.yuan@amd.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peternewman@google.com" <peternewman@google.com>,
	"feng.tang@linux.alibaba.com" <feng.tang@linux.alibaba.com>
Subject: RE: [PATCH v11 06/10] fs/resctrl: Add user interface to
 enable/disable io_alloc feature
Thread-Topic: [PATCH v11 06/10] fs/resctrl: Add user interface to
 enable/disable io_alloc feature
Thread-Index: AQHcScECSW4etIRcAk6KEfuJ7qFq2rTkVAiAgAAMXwCAAAtTEA==
Date: Wed, 5 Nov 2025 18:25:28 +0000
Message-ID: <SJ1PR11MB608391142B594331922876EFFCC5A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1761844489.git.babu.moger@amd.com>
 <deb3a4f19d6e138a502b136034fb88ad8b8c9c75.1761844489.git.babu.moger@amd.com>
 <aQt/dSRgtQNfJPCj@e133380.arm.com>
 <4a120a9b-b84e-4cfe-af46-1b4d721c2995@amd.com>
In-Reply-To: <4a120a9b-b84e-4cfe-af46-1b4d721c2995@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA3PR11MB8966:EE_
x-ms-office365-filtering-correlation-id: 54deb3be-fb87-456c-758d-08de1c98b264
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bHFnczVFTDF1TzEveHB6bTNuekFvMGcxR3VRTlF1RWZYUGN4Ymx2Q2FqREdN?=
 =?utf-8?B?T2g3L3RyOW5sRjhtT2ZBUmxCL2NjWFBMTmt0Mms1WDBxUmo5SHpza3EwVGNu?=
 =?utf-8?B?b2w5ckE1U2JrWVVrLzY3OS9QQlN5TkN3WlBwNWNtaWNRMCtQR0F6bmV0ZWt6?=
 =?utf-8?B?K2MvbUQ2amhzekdjSWJ1YXV1dnF4TGorK1BsWTJUMkxkUldONUFRelRVemR4?=
 =?utf-8?B?L2hxaGNLOFFpR3h3RmdpU0h6SlN2U080eU5rUVJaa0ZhS3l4OUJIZEIyNFBT?=
 =?utf-8?B?NzVWazFXZEpSYkNrQktraEFHYVRhWDZLNS9mR1pVTXVGM0YxYjZXWXN5ZFpv?=
 =?utf-8?B?L3JTRStvMGJxNnhleWVTT2dZMnNKc042WXhoVVltOC9HN3RtUmNVRTFTVVc4?=
 =?utf-8?B?blFRRy9rSHFBeEh4bXF4U1Y5KzlUSXNpZytST1U0Z2x1eUFZTW5KV1p2UFZI?=
 =?utf-8?B?SDEzL3o0a244N2x6SU5ZZ0VlL0ZzMC9icXZwdUlPcjdxT2JjYTFqOFcwUjV5?=
 =?utf-8?B?MHVlcVVKc0prOWN3a1YvYTc3cVgrMnlaNExPUmZnaTB0aWh3M1loUzlORlRI?=
 =?utf-8?B?YzBKRzBvYW45TWlEVHB0cHp0WFN1eVNIYWt6NFhmTEVaMk5YTnNyVm1kT1kx?=
 =?utf-8?B?ZWttN1hJWG93ZlJseUt4TERQWFRnWS9BV1c2bi9iN1BVUHdEOFdMUWtucTRo?=
 =?utf-8?B?aHlxYUxVWVMxdXNYcW0vRGlWNkpLNXhkaU9wcGNLV1l3SVFzaTZibmpIWjZG?=
 =?utf-8?B?S3pIZ3FzNWtmazZLRUR1dGF0bGdyWndIcnFpc0JteW1LSVdqTmxCUnd2U3Vl?=
 =?utf-8?B?RHp5UDQ1RjdtYXQ3V2JwRGdtNklhWW5SWFBWZ2d6eFVoVlpRdmltRzNjODM4?=
 =?utf-8?B?SXRGTlQ3N3JJaGMvRDFSZkhWT2VwMXlOQlNnOTZGcDZkOHVyb2locHZpT3Uv?=
 =?utf-8?B?SE5pNzVsV2JNVzRpaGlBcmtHMVliNE4wYWlDNU9QNXVadjN3RFExQmIwOWpY?=
 =?utf-8?B?VnRUaXZ1RDZlOVcxNkpkODA2Y1NOaXNpWnZFRUMzM3NJSHBGcW9TQTJiMzAr?=
 =?utf-8?B?a0tvczZJU1ZCTGh6TkFNN21zQ2FGbVFqSlNxR3NjZnlxL3BENFVYZjhvNmRl?=
 =?utf-8?B?QXVWbXlIOWM3cmRpbmVoMlFiYXBSY2hGdWlST0JZOUhuN2VRdVBEZldDOEJE?=
 =?utf-8?B?S1pKbUZLeFlpRzJ3elhWQ2FXWlN3d2ZPM2RvWklsMW1XZG9NLzJvSGZsdnpP?=
 =?utf-8?B?TXRmejRJWGVmUnVxQ2JvNkxMbG5RdkVZU0JIS05ic1hOSE15aFJoajZDQ3h2?=
 =?utf-8?B?ZTFrZ0JPMWF5RnkrQ3dhS3BKNFJUMHduUGdsRmRsTDFnSTc3K3Y0S3RHMFlJ?=
 =?utf-8?B?YTdySjlkS0VETms1ZTlaeGJ5YWZjYVRxdFhsUDBWSmdvdXlyVjdYNCtOOS9L?=
 =?utf-8?B?Sml2VVdnTWZpTHMvQzFDUlRIOHpDd2FwOExKV2VTWHRYUUpob2M3MmpCMFJW?=
 =?utf-8?B?Vk9KNVpMdWpXc2VsOEZvcnhwR2JoR1ZQZzlGeGY1SnRJS0d4bXRhQm83UXBW?=
 =?utf-8?B?eUJqSTFXUXBEWmVlc2thdStsTFpwNlk1N0VZVCtCUEdVTVM5YUdublQwS3lY?=
 =?utf-8?B?ZnFRa3RsbXh5K3NQdGpJdTZZdEtDVEJLMGdTZjY5MXlEbXRVRzl3alJLU3Vr?=
 =?utf-8?B?dUtEem9DSWlqYVNYMyt1Q3VSNGw1M2lhOWlrQXNCNFBVajYwb0tVdFNvd2hD?=
 =?utf-8?B?cFpVWDRiOEIxbWRJTWdTKytJYXRPR1I1T2UyeUZyN1N3SzlzallFNkRnTG1B?=
 =?utf-8?B?UG9GTFJtdVB6WkZQQndTeit2OXU5K0gxd0gzWG81RlJhYWFvNzhtRXVvd1Bh?=
 =?utf-8?B?TDV3bko5QkJRTVp5NHJKTDlocUxaR01FY3pzRkpUOEliUlRiNlBheGg3N1ZW?=
 =?utf-8?B?b3dkRXUzOVczTTBud0tDSSsvdUo2WGNweExqMUYvVk1ETS9YbEFVT3BXcVh4?=
 =?utf-8?B?QUE0cmVQOHhUYmhTRWZNTk14ZCtXK0dDWDJKMFBLWVJEUEZOZHRLcC9IbXkx?=
 =?utf-8?Q?w4BVXr?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vk5Nem1KdXU3NUpyQ2NwMElpTHZEOEpGSkZmeEFsT21teWhoVVNiUFZBZXJX?=
 =?utf-8?B?MHg1UEdtUnAyanVTdVdXTi9Yc0dPUitIelZpeXVwNkN0TDhlb0ozeHdmTzRk?=
 =?utf-8?B?bjJjTktTTEFVd0UwVFBFUkRQaUgzSkhkblJuSktWYUZldTErSEZGU2ozRi9v?=
 =?utf-8?B?VWJZK3F6bXNoTGZGdmxoUlRtWGlwN3M0QmowZWVSSUFvNWdBZ3ZDeTZPd3lT?=
 =?utf-8?B?dGFFbkxab1FqdGJTZmFWZEF4Qy9GNy9Od25yWi8xWndoOVV3TTRaVTdnSURV?=
 =?utf-8?B?QjVDTWIvRVVOSXh4YjFWY0o3cURhWStEMVpzMXpkTHJRc1RZOVBKd2Z4bXAw?=
 =?utf-8?B?Y3d6WmkybVcxUE1LMTJsQ2llM29rRmNuUTVZc3dmcWpQYUhLdzR4VnpEeksw?=
 =?utf-8?B?WW0zMlAweFdHTmJaOW5xVXlScjJrR2ZkcXg3YXBrbHZlY09PVGoyV0lBWGlI?=
 =?utf-8?B?MVdTWS95YzUwQnh5VzRoSk53QUt6M1hSR0psdWU5TUU0KzhLVTJ3eE9UQmJB?=
 =?utf-8?B?VTNYcmthYzhKT2VoNzVNcjE1Q1VVRmFnZE9RVzVZYk1waEI1US9tSkYzd3pE?=
 =?utf-8?B?Y1FPNzlJVnhGSEVzalZvVmtpaFczS2dlaWVuZGd1emhyR2xWWitSQlZKMDVW?=
 =?utf-8?B?d1YreWFobzF3RC9YQnhsSWNOVzNGQ1Y0dXR3cWpGclQ1OXlUeW91ZGRqWXMy?=
 =?utf-8?B?QTY0c0FYRlRSZ3NRQjI3TjJXRjVwUnZWMm5DTFo5Q05DU1hkV3I2TDMrWHVR?=
 =?utf-8?B?bHJVMXR5ZDVWQngxK0ZUekR6eHJIdGR3aE9FZXNhNnVLdG82UHRXd0ZXSlpS?=
 =?utf-8?B?SjRUcUJ3SXRGRkx1bzhsaUt0V04rSjI5am5Ud0pGWnVZanFQUHl1QVMyaW1q?=
 =?utf-8?B?OHBGZzVpRVBFZDMvQWUrWHVGTlhwUlVNa2Y0OUJmYU1oTmNYZ05jb3A5WnpJ?=
 =?utf-8?B?NlUweEp1dHBEYkxySktra1NaMVJhV2tsM1IzV0daWDQrMnJ5RUErY1BTazF4?=
 =?utf-8?B?RXR1M3pvYjExNHd0K2IxSkFTbnFEclhVNlFyT3JkNVMyUzNQSzlNRndHb0V4?=
 =?utf-8?B?aWM0VGZFUGsyY28vbXp0VmE5c3BMZVhnRkl5SVJzZitFRVQxTzJtK0s0RTIy?=
 =?utf-8?B?bS9pcGlWazJDT2VKVG9Tdm9KTjI5UkpOZFN3VWk4VFFkOUVzVU43QXdYbjdZ?=
 =?utf-8?B?eXUwa2RvZUtjdmwxam9qeHU5WlBwZnlpVzAycmNUTFc3amptKzFUT1dJbkQx?=
 =?utf-8?B?Y3hEajZzNzNzWEJjNHVFalVnMU9RZ2JBZ1laWVM1ODRvZmdMTWFrSURESDVl?=
 =?utf-8?B?Rld5eC9SeXBuM1ovaVBmaEpJT0pOVjZ6WnVqZHVGa2NhcXBHVytpSm5wVzFP?=
 =?utf-8?B?NURyQ1I4SWdwa1I2cDJqN0pENHgyaWJKaFVybytacWFMaFBqd0dEckIrVjd1?=
 =?utf-8?B?aDEzSDhrKzg3TTdXY0ZKQ3FENFl3TW9IKzYvQXBaeFZ3aEVmL3hWbEovY2ty?=
 =?utf-8?B?cVRRa3Z4aDdnbmhiTjFaN2I3TTJPRG9OT1lSZzNMRUoxaHlLY0E4aVJHSGox?=
 =?utf-8?B?RFF3b1drVmp1VmdhS28zdXZtSHFmOHBwOW5ZOU93YmpYQ2F3cVd1aXhQUkQr?=
 =?utf-8?B?NVNJZU92Z3JVS1VjTnhYeUpxdytITE5DOWFrOVhqSFphQWNYMmdtcGQrbVN3?=
 =?utf-8?B?STlSYTc0SDdnYUJ4VXBVb2pMNVBiU09xUTJIMFF3NDNWMWl0RTA4ak1uQlUv?=
 =?utf-8?B?Y1RWNTZLdlRXTmloRzNVbmdoL01jQVhtcWRoNStRRmJQNktnWjFuQTFEeHhT?=
 =?utf-8?B?RXhMK3dOSi9lc0VSZFQ1MHRUQnloTXFTT3ErelBRQTlOOHB2cXRxVDJXcjlo?=
 =?utf-8?B?OUVnbDhySVpvcVhNdVpEeWJVTm05WXBTek1tZjY4V3ZVNFRMZy9TS1FxNFd2?=
 =?utf-8?B?Y1dOamdlMHVpS2NzcllXSVZuZ04vK1A3dU5oY1pDTERzR1dYdXkxR3dQVElD?=
 =?utf-8?B?SXdLOXA4UGN3WkR5UUxGbXdOdnpXV3BBL09wVms3ekQrVUFMRThCVjNxUExS?=
 =?utf-8?B?c25sMEM3V1hRS2t2QStWMkx3ZTNKbklXV01hUE1tQkR4MnNPZDZ4UStDTWZZ?=
 =?utf-8?Q?UsTurMB04BLSFNbnp2Uo2ND4+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 54deb3be-fb87-456c-758d-08de1c98b264
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 18:25:28.6363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: znZpikap+oWcM97xuFm2MRfko9PvBOcP5Mn3/KcOqx4br4oYBisSObgRQ713gUHaMfQIa87Wn3ChOze1NFFBWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8966
X-OriginatorOrg: intel.com

PiBCdXQgaW4gQU1EIHN5c3RlbXMgaXRzIHRoZSBoaWdoZXN0IENMT1NJRCAoMTUpLiBBbHNvLCB0
aGlzIENMT1NJRCB1c2FnZSANCj4gaW4gbm90IHZpc2libGUgdG8gdXNlci4gVGhlcmUgaXMgbm8g
dXBkYXRlIG9mIFBRUl9BU1NPQyByZWdpc3RlciBkdXJpbmcgDQo+IHRoZSBjb250ZXh0IHN3aXRj
aC4gSGFyZHdhcmUgaW50ZXJuYWxseSByb3V0ZXMgdGhlIHRyYWZmaWMgdXNpbmcgdGhlIA0KPiBD
TE9TSUQncygxNSkgbGltaXRzLg0KDQpUaGluZ3MgYXJlIGV2ZW4gbW9yZSBjb21wbGV4IGZvciBJ
bnRlbCBJTyBhcyBkZXNjcmliZWQgaW4gdGhlIFJEVCBhcmNoaXRlY3R1cmUNCnNwZWNpZmljYXRp
b24uIFRoZXJlIGNhbiBiZSBzZXBhcmF0ZSBJTyBjYWNoZXMgZnJvbSB0aGUgQ1BVIGNhY2hlcy4g
V2hlbg0KdGhpcyBoYXBwZW5zIHRoZSBSTUlEcyBhbmQgQ0xPU0lEcyBmb3IgSU8gYXJlIGluIGEg
c2VwYXJhdGUgc3BhY2UgZnJvbQ0KdGhvc2UgZm9yIENQVS4gSS5lLiB5b3UgY2FuIGFzc2lnbiBS
TUlEPTEgQ0xPU0lEPTEgdG8gc29tZSB0YXNrcyBhbmQNCnRob3NlIHdpbGwgbWVhc3VyZSBhbmQg
Y29udHJvbCB0cmFmZmljIGZyb20gYSBDUFUgTDMgY2FjaGUgaW5zdGFuY2UuDQpJTyBkZXZpY2Vz
IG1heSBhbHNvIHVzZSBSTUlEPTEsIENMT1NJRD0xIC4uLiBidXQgdGhvc2UgbWVhc3VyZSBhbmQN
CmNvbnRyb2wgdHJhZmZpYyBmcm9tIGFuIElPIGNhY2hlIGluc3RhbmNlLg0KDQpUaGlzIGxvb2tz
IGxpa2UgdGhlIG11bHRpLXNvY2tldCBjYXNlIHdoZXJlIFJNSUQ9MSBvbg0Kc29ja2V0IDAgKGFu
ZCB0aHVzIEwzIGNhY2hlIDApIGlzIGluZGVwZW5kZW50IGZyb20gUk1JRD0xIG9uDQpzb2NrZXQg
MS4gIEJ1dCByZXNjdHJsIHBhcnRpYWxseSBoaWRlcyB0aGlzIGJ5IG1ha2luZyBSTUlEIGFsbG9j
YXRpb24NCmdsb2JhbCBhbmQganVzdCBwcm92aWRpbmcgc2VwYXJhdGUgZXZlbnQgZmlsZXMgZm9y
IGVhY2ggTDMgY2FjaGUNCmluc3RhbmNlLg0KDQpJIGRvbid0IHRoaW5rIHRoaXMgbWFwcyB0byBD
UFUgdnMgSU8uIEFzIEJhYnUgbm90ZXMgYWJvdmUsIHRoZXJlJ3MNCm5vIHVwZGF0ZSBmb3IgSU8g
Q0xPU0lEL1JNSUQgb24gcHJvY2VzcyBjb250ZXh0IHN3aXRjaC4gU28gaXQNCm1ha2VzIG5vIHNl
bnNlIHRvIGFsbG9jYXRlIElPIFJNSURzIGZyb20gdGhlIHNhbWUgcG9vbCBhcyBDUFUNClJNSURz
Lg0KDQpJIGhhdmVuJ3QgY29tZSB1cCB3aXRoIGFueSBjb25jcmV0ZSBwbGFucyBmb3IgaG93IHRv
IGltcGxlbWVudCB0aGlzDQp2ZXJzaW9uIG9mIElPIFJEVCBpbnRvIHJlc2N0cmwuIFRoZSBlYXJs
aWVyIGltcGxlbWVudGF0aW9uIG9uIEdyYW5pdGUgUmFwaWRzDQpkaWRuJ3QgaGF2ZSBJTyBjYWNo
ZXMgaW5kZXBlbmRlbnQgZnJvbSBDUFUgY2FjaGVzLg0KDQotVG9ueQ0K

