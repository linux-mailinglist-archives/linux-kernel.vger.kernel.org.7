Return-Path: <linux-kernel+bounces-894054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7EEC4927A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19CD03B156C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BB53375A4;
	Mon, 10 Nov 2025 19:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g+Z70kXa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91212D8DB1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762804604; cv=fail; b=u37XdLL27RUS+0xwPH19I44ej8X9on+Cm0HpKYep1G+30hAbKZQjILXzt6+FY+1ENWmK26Zx4rh+0ODlwp8f3Geq/FrfmbEOumuLEJom8ga7YqmtqK/eEkyF0BGXiEPdxr4H1x3ZqVSZnONPnuqVerjVaHSjI6xm2tvMXBoyT4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762804604; c=relaxed/simple;
	bh=OWW/Re61UqVq90GuS30dxY6l2b4V0Zx0a5ByVYFp45c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oMi5fRuof2eORZ7gzsTwLsbeZzmeLdgfuc946TfpEtJ9YwOtVjWn5ztesCN/9V+MzO2f7S+CjYVLdbZhW2/PaLyhz2ixci5SsnkPWcqh98QVPX5jhfaF0uzTfxFpsF8I4JK9a5aJVynQe5Fw8pOrZP/FhUegBntUURZvXQy+ozc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g+Z70kXa; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762804601; x=1794340601;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OWW/Re61UqVq90GuS30dxY6l2b4V0Zx0a5ByVYFp45c=;
  b=g+Z70kXat3fs3EUKUoUA0egFn264mscGFK99oXeG+jDTz3rMXJjLVqEt
   HTTnGWMKiBjAXt6EwjsRRtmVBD8i1HU87XCyLR3Pxdou+CPZN0UsgT+xf
   T1eZnpiMdMtBOzFzFfhyHsNjucnPWLWcyUDT4gCcqgFcjDEL1vQZAhWqu
   c6tHkarqwRDlPg7gUtIwizmG2W49UHWvs+RV6sieyikpSuNH/uQ0qNS5+
   IrllxjqvQrgklBXe+NV+vM5LkNP2B833UJrnXBsB1QY40aduzUAxH1R5q
   j2up1nGwFWkgVcBlsCWZxQXd1Sv2tdBQ9wKH2Y0hbiTeNcddMvL1GQ+SU
   Q==;
X-CSE-ConnectionGUID: ASeMRG4ASXCmm1cG6DNq9w==
X-CSE-MsgGUID: Vp4YQyOlT+KRpqe8wdPmOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="52420365"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="52420365"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 11:56:41 -0800
X-CSE-ConnectionGUID: ayKcU5JZQVGluLiQW2wKug==
X-CSE-MsgGUID: HKKSG/wpRKmzWmedJ3A8xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="192864527"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 11:56:41 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 11:56:40 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 11:56:40 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.56) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 11:56:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ruu0fJMFv9vIrs4bBdau+PPYMgtod+J4osEoZ1KR1jw+C8CgFnGSw/lQv8g0ZDK3XVuF02WJSmo4KQO7LlMytN7fYB522gVQl6GeKFQ1zXZYkb5DecMZz4Uid1iboBNyskDjvZfDCvINpGh08c/NxU1wtQmsL/xDZgKezxaV/6ccMHHmLo8ceUJEUBXyzO/SnXBi2jb8/bEGp7cMob/aX07tZNRLQfFiHZMVawpCJx3SvvzsC6yecltHuH8Zdu0fWiWFrc9pdSpVjBmYQUSiqpbXnFyzz9QRU7AB63wwfNpy/E3DSD8lRQ7GxFWYkVIOC60UcCDneqsh1Ixnt+BfOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWW/Re61UqVq90GuS30dxY6l2b4V0Zx0a5ByVYFp45c=;
 b=V2vzvdxRRvqJWcA7RjFQ7WKrmHWwYMQoF+3k7oGsh+piGd/FCJ+WOTesREpyKDaYDOJBLGUfs36iH8oBc1hFpb25yn/F0a/9Rrk32Cj2Emxr5qAEsQKAF9+HcpROg9+8i3F27Hhdt7P1gi6U75fLbvNo9NEXePmkQJO6DfsOQZnG4KS0x4DZTSDWfcIUuEHACZW6HHgmWGYpkQP7D4Hf/fwzSI+VB2GLPmpkpydruvpmNb3Yn+Uhy3yIP/mQtZYOFYR9SByoYWmNnFRuyReD4q92HUwQROyB2Zurxfbyr+ew3xYUcV7OJ8niYRPBAOOCly73xfa0K9KDQyCX7TKJOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA0PR11MB4702.namprd11.prod.outlook.com (2603:10b6:806:92::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 19:56:32 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 19:56:32 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Babu Moger <bmoger@amd.com>, Aaron Tomlin <atomlin@atomlin.com>
CC: "Chatre, Reinette" <reinette.chatre@intel.com>, "Dave.Martin@arm.com"
	<Dave.Martin@arm.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"babu.moger@amd.com" <babu.moger@amd.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: RE: [PATCH 1/2] x86/resctrl: Add io_alloc_min_cbm_all interface
 for CBM reset
Thread-Topic: RE: [PATCH 1/2] x86/resctrl: Add io_alloc_min_cbm_all interface
 for CBM reset
Thread-Index: AQHcT4VCMZzJIaIcpEO5HF/nc2I90rTnxWyAgAAGSYCAAAv9gIAAFBMAgAQ1DACAABM98IAAISWAgAACCLA=
Date: Mon, 10 Nov 2025 19:56:32 +0000
Message-ID: <SJ1PR11MB60836AB4270419338FBB4D1EFCCEA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20251107012401.224515-1-atomlin@atomlin.com>
 <20251107012401.224515-2-atomlin@atomlin.com>
 <2a0b270a-e398-4d88-aa10-421f2769a759@amd.com>
 <53iuqiul6uo7zj6sfckm2h465cjusaxvpxrtdmnbmhvbzuqiq6@7ogm3zqddzjd>
 <fa2c3cbc-2af6-4d98-bd70-8ab49cb0d83e@amd.com>
 <4whfbgq336xfuov4i4nwwrn35ywwlwizuvpdlstmdqzkhvwrq6@eits26xbwyz6>
 <bcc8e6d2-8e91-4e91-9dab-f1c00f99c408@amd.com>
 <SJ1PR11MB6083701B503CE361E3D7A656FCCEA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <f4a043d2-9cb0-41c9-a45d-31f96fd007d5@amd.com>
In-Reply-To: <f4a043d2-9cb0-41c9-a45d-31f96fd007d5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA0PR11MB4702:EE_
x-ms-office365-filtering-correlation-id: cc39024a-e924-4b67-6bf6-08de20933ee4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?N3hsK0g5dzNiMXNJTDBSKzBIQ0NQTWliU3VTSGpITFNyZTN6WkJEeTJxRTlZ?=
 =?utf-8?B?MlNHUXp5SWtNT3NheGZrai9VSkVTRjhZVmNHVkxJMlFlL3N2RUw5TzRLWUlX?=
 =?utf-8?B?aC9sUVJjZ1Z4ekRsczBsU2VYcnZpZkVzdkVBQzF3RXBUd2Q0U1lldm96SFpC?=
 =?utf-8?B?aUNKNVhKUGlTczI2OStwUjFROTllTnBJUGh3VUxqallHVGRHYndDbGVtQ0Rq?=
 =?utf-8?B?MTVsSG5iQkhKMnkyWGpoY1ZvU2NNN1NSd1ViY1kxNnBIa0R3RjEvdk90WjRr?=
 =?utf-8?B?YUdONjJjTlVBM0NiRU8yM0YycngyNWRObWI2THpFNGsyOFg4Uy93MmIxbFpJ?=
 =?utf-8?B?Sk92TDdvMGVPRGRJd2tIdjF2TU9XVllBYXlTT205QnVJZnBsZ29hdnpVTGRF?=
 =?utf-8?B?M3VTWG81RXJ6YTJTWlk1WVVNSkxXeG5qODBDZStHc0orclhGZ0hRSlJUUzRE?=
 =?utf-8?B?cW5ia1dEeS9XZHJVVGhlVUloUTRuRUx3WnpNM0wzVVM1V3UyTmExMmtmdUZT?=
 =?utf-8?B?VTNnb01zSUU3ZWR2SjBzclh5eVJjRlp0bWsxL0FVeGRjSVFUMlBkL3l5YWdv?=
 =?utf-8?B?L3RMWjV6elFrMFdGSjNWZmQ0K3NXb29jM3hJbGNEWDFKNXdNSTZWOGVpWXNx?=
 =?utf-8?B?Q0Vtd1drQVlYMXhlL1ZDZkFhdlpsSk1qMlNvOFVQaXVBMWp6dGFTakI0RVhn?=
 =?utf-8?B?enljd0MxWlRsZ29rSUcxd0R1YXdFNHg4dTBCWlJpaFd3ZXJUYkxGcEdWdXd2?=
 =?utf-8?B?YWdUVkgxbkMyeHgrd29Nam9xMHVmOU81azB5MW9qTDVDMnBzZzhVNlFFRC9L?=
 =?utf-8?B?cEJQM2prMzB0YUo3a21aNTVwMHNoMitraWJBTitsK3BVeU92UG8rQXVuWXda?=
 =?utf-8?B?djZJUkltdC85b1RodmZvbnpkSUxzTHYvZGtheVdkMitIMThHT0d6aGhxV2hM?=
 =?utf-8?B?SUNYaXR4OWtveHpJbFE0QnB5aHdmRkJiSDhrUkF1ZVBOaFRTOGxzeVUvNEdW?=
 =?utf-8?B?VjRIWGpIQm5rSmREYUkvNnpTT1U3bFdLcDFSQXp6WHU1NkJlOWlLemN4RCtk?=
 =?utf-8?B?ZGFsWWRtR2lYR25vM2NmcjBNRVB1V0NUTzNrRThLZTNJdy9TcGpMWHZmeG5I?=
 =?utf-8?B?a3ZBUTJsMHRHQnNnM0gwOEk1a1NuWm0vQm1KeHJHckJVazdpWE94TCtLZmZU?=
 =?utf-8?B?Z3gvc24xZURBSktzZnlRQXljWEloSmp0SWREYmw5czlxM00yR2thcTQzc2NX?=
 =?utf-8?B?K0VUWk5xdXdYMVZqTWpjckdDbXpKOWNySGliMVlsdHp6a2grdEV3TUc4bW1q?=
 =?utf-8?B?MXc2VjFKTVFtTWQyY2ZUSzVlUEVmNXRpVS8rdDkxc3JScWNxV1QydHovQURY?=
 =?utf-8?B?U2xmZnVhSjJKc0E0d05zcDQ3U1NlQ0g4ajNrdXlZWUhHSXdzS1BYZzd6WjBk?=
 =?utf-8?B?b3hZWE5iR3hHUENvV3VSVE9Bdk54YXZPR3lhZjJCUmVFOE1PdDRRVlIzRGp1?=
 =?utf-8?B?Y3FvUW1uMCsvWGtRa2s5VEZqY21uMkx3RGcwNElRK29Yb1hJNEJQWXlzM3hs?=
 =?utf-8?B?QkU1RFBycUpLOW5NTTc0Qkl1YzRNUkcyZTlvVnJNcUVLT1lKRnRyanFjb3kx?=
 =?utf-8?B?eFJjYTdsUU40U0h2Q0VIQmpmVTM1OWNEODRmRDNhcCthd3RMMjV4bWpXM0tx?=
 =?utf-8?B?QnRyTFFTVXMzVzgyc0xoQjJBRkJtR2hvZlNEQmNXTThSMU9tK1czSU9MeC9I?=
 =?utf-8?B?aWJPclRhQjFXYU1FYnlRYVFvNHEzMHNkVGR0c28yOGR6N3VTdFR2VUhEeHlu?=
 =?utf-8?B?Lzd5M0RVcDJDSVMwOEVMaDNDUm0xc3B0TXNkMmVHZHhBaFcrU0p6cTNCOUkz?=
 =?utf-8?B?bEJyUjQ2SnpDTXVhc3JsOWhFOGlQN29NR3lLdWVVMzUxVnZZakVScTBHbW55?=
 =?utf-8?B?b3gyK0N2dDdCU0VIZEIxL0xic3JXemJOSi9XYmJBVjQrS2p1TGsvNWxXU25C?=
 =?utf-8?B?TjNYVkU2cE9HQ2M1ajExblpCa0Y0WHVwYnNKYUJpQXk0UUMyaFBDVHpQWlRR?=
 =?utf-8?Q?vM2TeU?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2tJYzE2MDNSZkpSeWNaOWNLSElOd0dCUGdmRE0zclN3UVRWL1ppTFRMdGpk?=
 =?utf-8?B?dU92eUVMV1N0UlpHa1ZZNE9sQjU4Nm95NlF5ZUpzcTlJa3NKUTNkcC9IL3Ja?=
 =?utf-8?B?K2dEMWYwWVBQMlV1UjdrWXc4eWFWd2ZJYk84dUYwT0FoL0NDeDc0ek1KRnM3?=
 =?utf-8?B?U21zVzdLQ0VJVGxIenl2WXh0ZE5hcmZ1cUl1V3FINURFTjd2MXliUVFqY0FH?=
 =?utf-8?B?WlA5YVlweUVyVjhJSlRIanc4cks4cUh0Z2JyWDhBR3VTUENtVGlQYTQwaEdG?=
 =?utf-8?B?Ly8xV2R0VnlxOXhTeVV5SkZ4RFlzenFBdTVXb2t4TzJIYVM0OXpLRXFqc2t3?=
 =?utf-8?B?RVhHbWxNVkp4QWxUVUFjNzdPK1NmY1RaRHR6bGt0bys5RHpzKzNjMzRyd2Z4?=
 =?utf-8?B?VWdKTXk0TWQ2bmRndFZSZ3I3Qzl0THRDMHA0TWFSWUpBTTFwVjlTSEtzcWVq?=
 =?utf-8?B?WjU1aGNsT3ZwclN4bUVKZ2o1YkFheWcxSEFFRkRrekZKV0xZR2FQM2hScVov?=
 =?utf-8?B?ZERwQ1ZhWkdGdnBWZ3Rxc3loeWVvWFRoK1U1L1dMdnN6WWF0T0VialdpZ2Fn?=
 =?utf-8?B?SFpOcWlwRmdIU1VCNHZnNFhLMWNkYW5xY3Qvbm5OS256WlhoU1dsREJoWU0x?=
 =?utf-8?B?WWlLUUNuWGhsb0Rod0xqMDVNQTZxQlZLcjk0bWhwd3RQNEtaMjhFMVdLU0Nw?=
 =?utf-8?B?RGkrQnNTZzNnSDFNSDlHV0pJeUd3R01ta0lEWmNJQUxjZ0JBQjN3MjFGWEh6?=
 =?utf-8?B?L1pkTEx5Sk11YmQ3eXNvVUJ1Z01RdEhhU015ZkdITnFwN3BHOG8wK285ODNh?=
 =?utf-8?B?Rm96cDVFVHBnY2F6bUJ0VFppZDJ0UFJvYVR3MHJwMTI5RlNzQ1plc1BGOVdk?=
 =?utf-8?B?NCtaTkNEMllsRkFHSjJDVk85Z0puYUdsaG43TnNRTG0vbXo3TldqNkRlMnll?=
 =?utf-8?B?bnJLb3dZRzNpNllJbE1rS2FJeFh5elcyR1BKQ0NIUXpFc3VBa3U3MmVDQ25J?=
 =?utf-8?B?Tk5zajgvQlRheEc5dkZTTzVmWk1sZmxwc0xGWW1pUkd4cVY1SHg4S05YL2hB?=
 =?utf-8?B?MDBWSUw2MUFOQk5NSWxSREVpdzRUL09GREJQaDFrajVRd3RURGxPZ25sZWQ1?=
 =?utf-8?B?UW9IY0Yzcmk3YUdNc0FCOHUvZWRCRWFQYnJGbHZER1FYcVVHZjRuUlQ5UTdy?=
 =?utf-8?B?dVR6Sk1UaEJqYlUzVFdMdDNKK0FMQmFWbThDYXBidWpFOFdyYTNLeG1IZy81?=
 =?utf-8?B?NUdlcEJ3di9jWG1tVW51NFhtVlB6OHhDeUVsQU56SzY0eWNwVnl2OTNUbFM4?=
 =?utf-8?B?ZVRvRkdlV1pNZVJqU0R5TDJGeDRPS2RmOFFkbW0zMkxQM0prci9Rc3dKYjdG?=
 =?utf-8?B?QldaNXJxZFdzaXFRemFXSXl2SElqYW9la21IOGhXNHZGQkxaMW5VOS9GTFNC?=
 =?utf-8?B?THZZNXE2dmJnQ0x0dS9wVGJsSnhabGxXOE9lY0xQVTVjdENlaHRvQlpVWVA0?=
 =?utf-8?B?Q2p0dkwxZWNidVdadHpkT3Q2TmQzVEdTNTM2R2FXOXBkZk1wZElSQ0RLQ1dO?=
 =?utf-8?B?dXFDQ1JPcXFtQ2dXa1ZLK3dHTnVwMGR0a1plLzdma0FYNXNXZ3V5OVFFMi9l?=
 =?utf-8?B?YTBEWFpOTndiWUowZzZUZXdEWjhBQUhkcDRiMHdoUlhIaXpVY3h5aVluK0hI?=
 =?utf-8?B?WFg4YmcxUUxoaEFBY1YwWjBkaE4wakxkeXhzY0YxWkZFSFVFTlJJcU8yMkpJ?=
 =?utf-8?B?MXRvNFh5bFBta3d1UHorYllraS9mMWlHQ3BZWEVhdjVZTmNHeW9mZTZ4emZR?=
 =?utf-8?B?aWRDRitmbW5DVXhsR3dnMVhpLzE2Rms3NjI4dnpPbnZEcDE0YU9XbjdCenNv?=
 =?utf-8?B?TEowYjNlMHVSTmNVZHd5V09COFErQXNwS0hVVXNoVXVWVEFySExwUzlKU1pU?=
 =?utf-8?B?TzE4c3JXMllpaWs4NHVDK2tkcGFQb0ZhZk5hN2RaOTVJWkRoUTNKRjJDOUxj?=
 =?utf-8?B?MTZmbVVIWkRQR213RHN6NlNGVnpldGFjMjIwQlEwTWJqWTRBVVVQM294QUNB?=
 =?utf-8?B?ajJJa0l3MEZacGk2aGVzZWp1ZnFFdVVJNVY1djRkaDVhbWdBT2JPTmVEeStS?=
 =?utf-8?Q?dWRY5j/BG3p57EWtLVUMqI3vu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cc39024a-e924-4b67-6bf6-08de20933ee4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 19:56:32.0455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aKOJNgxwJrV1w2NWVSoHdyjxlih1PZ34zjfi1tz20Zx3YHaV8h1mfvaSQmznLYLx113ii5cNOFv3o5CwZZAOMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4702
X-OriginatorOrg: intel.com

PiA+ICMgZWNobyAiTDI6Kj1mZmYiID4gc2NoZW1hdGENCj4gPg0KPiA+IHdvdWxkIHdvcmssLiBC
dXQNCj4gPg0KPiA+ICMgZWNobyAiTDI6Kj1mZmZmIiA+IHNjaGVtYXRhDQo+ID4NCj4gPiB3b3Vs
ZCB0cnkgdG8gc2V0IHVuaW1wbGVtZW50ZWQgYml0cyBvbiBzb21lIGNvcmVzIGFuZCB3b3VsZCBm
YWlsLg0KPg0KPg0KPiBJIHdvdWxkIGNvbnNpZGVyIHRoaXMgYSB1c2VyIGVycm9yLCBhcyB0aGUg
dXNlciBpcyBleHBlY3RlZCB0byBrbm93IHRoZQ0KPiBzdXBwb3J0ZWQgdmFsdWUgZm9yIHRoZSBk
b21haW4uDQo+IFRoaXMgc2l0dWF0aW9uIGNhbiBvY2N1ciBldmVuIG5vdyDigJQgd2Ugc2ltcGx5
IHJlcG9ydCB0aGUgZXJyb3IgYW5kIGV4aXQuDQoNCkJhYnUNCg0KTWF5YmUgaXQgd2FzIGEgcG9v
ciBleHBsYW5hdGlvbiBvbiBteSBwYXJ0Lg0KDQpPbiBhIGh5YnJpZCBQLWNvcmUvRS1jb3JlIHN5
c3RlbSB3aXRoIGRpZmZlcmVudCBMMiBjYWNoZSB0b3BvbG9neSBzY2hlbWF0YQ0KbWF5IGxvb2sg
bGlrZSB0aGlzICg4IEwyIGRvbWFpbnMgb2Ygb25lIHR5cGUsIDQgTDIgZG9tYWlucyBvZiBvdGhl
ciB0eXBlLg0KDQokIGNhdCBzY2hlbWF0YQ0KTDI6MD1mZmZmOzE9ZmZmZjsyPWZmZmY7Mz1mZmZm
OzQ9ZmZmZjs1PWZmZmY7Nj1mZmZmOzc9ZmZmZjs4PTdmOzk9N2Y7MTA9N2Y7MTE9N2YNCg0KVGhl
IHByb3Bvc2VkIHdpbGRjYXJkIHN5bnRheCBpcyBvbmx5IHVzZWZ1bCB0byBzZXQgYWxsIGRvbWFp
bnMgdG8gYSB2YWx1ZQ0KdGhhdCBpcyBsZWdhbCBmb3IgYWxsIGRvbWFpbnMuIEl0IGNhbm5vdCBi
ZSB1c2VkIGZvciB0aGUgInJlc2V0IGJhY2sgdG8gZGVmYXVsdHMiDQpjYXNlIGJlY2F1c2UgZGlm
ZmVyZW50IGRvbWFpbnMgaGF2ZSBkaWZmZXJlbnQgZGVmYXVsdHMuDQoNCi1Ub255DQo=

