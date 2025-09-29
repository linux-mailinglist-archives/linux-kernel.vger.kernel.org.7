Return-Path: <linux-kernel+bounces-836327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7039DBA9554
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FC9716C160
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9FA2FBDFE;
	Mon, 29 Sep 2025 13:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KEb17Y1N"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8F026ACC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759152477; cv=fail; b=MvKSXHkjWnraiFdsxY21YdUVM7yhlbUZHG2gVxmQ8IkwjqTAfRap04XbgVzFzJT0Yat+nBm4R+PyVzt+1tZYH09dC4n6mQr5gRRuWdWuxMQEju0xXmtVcfny/sMsC1JDPKyiHvQJVZyaBKavdaBlMa/rj6bP60wIrKc/wUtMxRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759152477; c=relaxed/simple;
	bh=MBdvrfqWiqmxXwhhkFroymK27sgegmw4J6WLKD42sqo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r7PAJaiTs288NjKkb39EBASAGdgQOUmWPX+j/MDLaXvg+Ccr7uCxiBr65j2Cqft9bMdjG0zL5Dqzpwzb03SAZM9XHwPmGMpDlYSkf+HeQj/6GqNwix4kQD6k39CZh1d/vqYnhCMhcBdZe+Ut2GXTbeQr4+UGgpW0F9qnDF0UAMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KEb17Y1N; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759152476; x=1790688476;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MBdvrfqWiqmxXwhhkFroymK27sgegmw4J6WLKD42sqo=;
  b=KEb17Y1NRfdYEEdiUTwibYDwhd+ubfm/1+YplSnGLxXD5S1ssYMilo39
   uQ6J+zSLxYRzE9oITjQffXqEBGkMvEMAtQWALIwbWwbdY/pE/rITFfKC4
   T5iDutXUU8ZWZiIC/PGPQtkZ2TV/3dpgo8RszQ9NfFNDqO3XM6n/fnRbb
   BzVZV36ZiZVHzX0uGe3oIOSx+aYVyMXkzu5Tn2o835TE4R32EjMOCDO/N
   VF/UZZhZ4zjE6mtHyBeq5iHES9pWVqy21QGkQ8G3Xsc0lX9upL9ZzDYNl
   4xdvghNBir20ZeVQv13zPLz3SiJgcY92MviEfbvJUWViTKaPugapbDX3S
   g==;
X-CSE-ConnectionGUID: FNV7JqW6RDm1tqisJt8Dew==
X-CSE-MsgGUID: g46yFlfBRiidNaS6aI41aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="72493594"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="72493594"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 06:27:56 -0700
X-CSE-ConnectionGUID: zrwnF3+TSySSwjlElDhpDg==
X-CSE-MsgGUID: 9j1zGLLfQLKY9g0KVQ19sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="183487598"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 06:27:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 06:27:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 06:27:53 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.45) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 06:27:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTtGZsE6RzZCbdAV0c8B1Ouz8r7mLJ8MgAlQ85nGjV31tzLBgw7mCgTZi8gFxZL1cNUgz4+DcrUMHNqYYftwnD7wSFgzhBVMErM9jWnZwjTR5y/OlYlgjYqR11Ze3kN4jVxf7u7QwoHKHgmfKrjT7BXbUsSneoHRiZnZKReclqqO46nJ+iZ4fqMmQMnIRHX6n8EJj1D1RWZdpbxc7bqIkLSTyyJtxuebAMvJLAnk2UOI6FesduN3BISPzwAPpQPBpA13A8Jco+h5AZkJ5v9aptFZa1zs+vp1Af/3vwGjmm2yCK9URPlsdmzgZPETQJhXA7uCLqtwcHHQpHZxlMmcnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBdvrfqWiqmxXwhhkFroymK27sgegmw4J6WLKD42sqo=;
 b=LnyGbUKiRzJQAOA9209hTfw7n3PJb0JWKZudD8B3j/86R/2uuZoREsLIQFx9K+MpfUEWoM/lvNzmy8HahDXL52cZMZfNUFMDFhLWhJx6cNBKfpxPIHSI7dz/046cywUCoseen6Ib9tDcA9PSmCAnHVbDexMkUFm/ZTFNRxkIpKKePEpjbP+ta38zBuUIlTiJfTm9ERATcs5N5W+Ikb9zzHjAJkyJaIZsmpu3aOUiY7sxg7TbKBLX22VTNE3i9s9clIwMBxOC/VAiiXkwmw1ay1iCLZycmPH1Bqe/afeCVNW+rYJhCM1SrwixUG5IvlGh3ZdUGnY0L1l5GD+wHm6LIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB7130.namprd11.prod.outlook.com (2603:10b6:806:29f::10)
 by SA2PR11MB4794.namprd11.prod.outlook.com (2603:10b6:806:f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 13:27:51 +0000
Received: from SA1PR11MB7130.namprd11.prod.outlook.com
 ([fe80::fc98:7fe:bac0:f2d4]) by SA1PR11MB7130.namprd11.prod.outlook.com
 ([fe80::fc98:7fe:bac0:f2d4%5]) with mapi id 15.20.9094.021; Mon, 29 Sep 2025
 13:27:51 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Jiaqi Yan <jiaqiyan@google.com>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"david@redhat.com" <david@redhat.com>, "lorenzo.stoakes@oracle.com"
	<lorenzo.stoakes@oracle.com>, "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
	"Luck, Tony" <tony.luck@intel.com>, "ziy@nvidia.com" <ziy@nvidia.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "npache@redhat.com"
	<npache@redhat.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"dev.jain@arm.com" <dev.jain@arm.com>, "baohua@kernel.org"
	<baohua@kernel.org>, "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
	"Chen, Farrah" <farrah.chen@intel.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Andrew Zaborowski
	<andrew.zaborowski@intel.com>
Subject: RE: [PATCH 1/1] mm: prevent poison consumption when splitting THP
Thread-Topic: [PATCH 1/1] mm: prevent poison consumption when splitting THP
Thread-Index: AQHcMChLk4bOL1ruf0K10LKRmZ1XGrSpJMYAgAECE3A=
Date: Mon, 29 Sep 2025 13:27:51 +0000
Message-ID: <SA1PR11MB7130ABC25E060D2CC4749E45891BA@SA1PR11MB7130.namprd11.prod.outlook.com>
References: <20250928032842.1399147-1-qiuxu.zhuo@intel.com>
 <CACw3F50ijQ20Vg8ycMROSCccf_XtjB_fFvLGxvQZ7eaNQoLwGQ@mail.gmail.com>
In-Reply-To: <CACw3F50ijQ20Vg8ycMROSCccf_XtjB_fFvLGxvQZ7eaNQoLwGQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB7130:EE_|SA2PR11MB4794:EE_
x-ms-office365-filtering-correlation-id: 62506935-17a3-429a-b032-08ddff5bfd37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VFdzVTRaNG15c0pJZy9xa1FGL0JOVmtLUmQ5Y2dMZno4WVRtVWtiaHd0OWQz?=
 =?utf-8?B?akcvMi81SU0zalVjeTVjZ2xJSVFyWmlqbnE2OTBBd2F3TmgwRXBjTDhKYkto?=
 =?utf-8?B?cDRCbkxlRCt3cG9VSm5pNEFYZnh5R3k5emhsbjdvUiswZVJ1ODVGd2NIRXFS?=
 =?utf-8?B?aEY1eXZacmtmdmNoTHJJWkErNXFia3BWdHNaWllPU0FZUVVWYkE2MTlHY1Fy?=
 =?utf-8?B?OW4yTlJpYm5EMWtlcEpJa2h2M3JWREdTVUJBUExJTkRsWS9rSWp2aVc3MGRI?=
 =?utf-8?B?RVdFZjNCVWZrdXhnSVd1Sk41bzNOZHFDTGh6QmZKdHpFd3VqRkNmenlOSzM0?=
 =?utf-8?B?ZytXbnZEMEJKL1diWm40c0xUazdVMFRYZnVtc01vUkR4TlhKNFZSRHB1dmV0?=
 =?utf-8?B?MzRGaFU3RWNlaUpNMTVTUExFbFNzOHRCUk5ETVppNlcwS29HUkFEK3NPSk8v?=
 =?utf-8?B?UUFUYUZWeFlWS2d2eHI3YnpBcEppeWpBNWxQZG9QQURBc1hiQ0dyTk9kcG5Y?=
 =?utf-8?B?T083enhLU3pzczg2TzVieVc5L3ViU1A1YzZMbUdiOWxBSHNsZXluUE42bVRV?=
 =?utf-8?B?NVFyU2pIUlVubi85aGNhZFlPUUFNTnRtRlVObloyeldzcEJncVhYS0lZYUtY?=
 =?utf-8?B?UHY0Si9MdmNWcjc4eUNrM0tvOE5pSnVJUlM3QktzY3NlWVVWNDVpNEFhUFFZ?=
 =?utf-8?B?MG41UE5KVzVqUVVmVnBBVnFZOS9LM2JCblgwTUwvc2s5dVB6WEdpZ0Qrd0dQ?=
 =?utf-8?B?b2xVWnBrLzdHdkFLRGVDVUlUMytVU2lOankxdFZ0L00xb3lnRkM2QlBaUUJ1?=
 =?utf-8?B?VTU3YmU1cWpzRy9FVk0zL2MzWGdsTGJhTDRWZjBRNkdsNjlOR1UwSHRsRFJP?=
 =?utf-8?B?b0hHbW55VFJOL0tlUnY5VXFRR1hDdG4ybVVLanJGMEV1SEZOVlVVKzN2NHZK?=
 =?utf-8?B?OVlmSGIyZis2WDdaa3R6Mjh0aUZKOFI1c0V6VkRVZ3h5VEFMcHZ3T0d1OUlX?=
 =?utf-8?B?ZjFhZElEMzQrQ0hnU3lMenVHcFpYMGZ4ODd2WXdHcXljRmJlSVF6T0EvZVJs?=
 =?utf-8?B?OURsRVpqK0liYTlScWRFL0JkUzYzK3k3Q2NyL3MvRC9xZERCYjBSa0ViZm92?=
 =?utf-8?B?dUZsNnZHSHhENWRmenFlRzVaNlVmdVJTR1g1eGgwNi8xTkp4Mk83NmRmMWsr?=
 =?utf-8?B?Z2lJOGM1dlY0UkgzampyREdnclBjVXJWeFZkREg5MU9oSnpkblQyNHdjQUtk?=
 =?utf-8?B?VUdEVGNzVkxQSkp6M1hGL2hHc0tzZXN4cG5MSkx3RkFLcTUreVhjMkpqdXhm?=
 =?utf-8?B?YXZNVjNhekdUTnNGd1p6Z3FxVDh4Ulk4N2wyZkl4NFI4dGlYQndWVnFDOWoz?=
 =?utf-8?B?TFdWc0svc1NFaHM5aXh2RUNCb1ZhZzkwaitTSjdFN0NUOVB6bTF0eWMvVDMy?=
 =?utf-8?B?Zi9HckM4Q0NjYkVSVEZPN0lCTXJ3cG1EMFJidElaRnRPYzJCNkJUUHlBWWVz?=
 =?utf-8?B?Vk1NTUtlUVZsT2YyQmxrdzU3akNHMlJXdnBFRmxST2pBU01EdElYMzVzZlB3?=
 =?utf-8?B?R2JyTXlPamlseGVGMzVBcnhUVXRqRmgrV2tpN29UYmpXd0EweVVJRmxRakc0?=
 =?utf-8?B?M2hwQWlKMllRamlVT3ZkYmZaaTNZK1FaTzhBVmhMSGFkS25UZGhOZVhDRlRy?=
 =?utf-8?B?aHFWMWh0bGxZZ1BRdzkwa2dYb0dia0ZZVzZGb3NvcW1OQSt0VHR1N1BoMDBG?=
 =?utf-8?B?SjgxQlpkTUN5NlpjYWszSUpieUhhR2FrMGsrYlYwUW9SMnFOR081dVYxNFlZ?=
 =?utf-8?B?eDVZU1FWUWNTMEtNQi9pN0o2R2Q1SVhiMUJESVYwYitzdVlpZWt0ZnRZQTV3?=
 =?utf-8?B?UWd4MTdkUjdPaDNjMHhxS0NmK2FDSlFrNzNNQ1FySDJUNWVMY0JlUXNyWk1N?=
 =?utf-8?B?Qmg2RFBZRUlLYUE1YmJuM3dFaXRoWjFhZUhNWk13RWd0VUEwS1ZjWEZrRTJV?=
 =?utf-8?B?STRJSVN1MDFvQmt5TERLOWVZZnBTTHdDeDN6bVBlNjVBd0RaWDZQV21WcTI3?=
 =?utf-8?Q?KWn5vI?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB7130.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkZKTU1oamlIRUVvdVp2Tm5QbGR4MUVVRmxqU1BaT3Z0YjVPaVZsZjJjaVBX?=
 =?utf-8?B?Z0NncW1TV1Z2RnNJVFRFZVREVjRVUTNmbmV0TmVFeWs5SEtzZWJudkphWDdF?=
 =?utf-8?B?WFo1TjBBeGludG9SMkwzbWc3SnpQVktjNUViZnNHeXRoS2EzTVhvL3N5UWlG?=
 =?utf-8?B?RFRJZ1BQaEJRWEo4bjVTdFNpc0xMaDAxUDlybXlUUkk0c3pPYjlHK0FFYTdv?=
 =?utf-8?B?ZTJVM09ad2wxcExRU0k3dHlEelNJaDlDSENDbjdTT2J5RVYrOXMxWWhaZ1dz?=
 =?utf-8?B?VUNmOXdBMlRjY3p3V1g3SSswMVQrdWErNnM1YndiaXNXd0RXaVQ0TnplM3Ni?=
 =?utf-8?B?cC81YnlDNURsOXBXQ1RwWmorQWhUd2ZycTliU3VidXJxZ1NVc2xwZHFkRkJM?=
 =?utf-8?B?UzFCUGExTzRhT3FHTUFNOGNTYS9PRVNkUVlkaE1vcjI1QlZoTFo3V1Y5N3JH?=
 =?utf-8?B?ZmV0YXNzM1RxU3BoUXo5VjdKcjZLd0xRV1hCLzA4Zng3MitnUFYzaW9RWFJ5?=
 =?utf-8?B?TGhWWWcrTmlNWHNiSng3bVN0dkVubndhMUNUVVNQTWVnazVtYklvbU00ZnBj?=
 =?utf-8?B?VXNQbk04WldXcTdYNEtNRGYzZlhTWlRmK3dLYWVnelpsK21ZaGk5eFlJRU8r?=
 =?utf-8?B?ai9rdXp0ak9nMTdSRldXK21qUDIycW9CV1FMTW5qdVdtMHNtQjdXa3FuTTgr?=
 =?utf-8?B?YkVjZHF4Z0N2eEpEZGY3em5XWmtKQ1g2NHNZYkFtRUlFdUc0QzREbHVscmI5?=
 =?utf-8?B?TWVmNzhxYk14VkUzNDBGcW9DRmlXbC9EUDZkUU5TR0xIQy9hT1dVN1JFVU1w?=
 =?utf-8?B?RDdsTjhPclBRZm1hU1luSmt2NUVwOVJmSDJnRUpramZ4S1lhNnF3RzJIRXdU?=
 =?utf-8?B?NDdvclRib3BDS3VKanVCOWl0STBHOWpsRmFYbXIrc0ZZSFo2YUZUTGlDODNv?=
 =?utf-8?B?TFhRVVI1WG9DcjU4d0xoVTlyOGU1STlKbThQbEhOUzVWZHFTdExrclNtWXVJ?=
 =?utf-8?B?VFVhSGJldkpIblUzVHowV1JicU5HSUlNKytrM1FTMzA4OHYrMHVlWEZ1Mm82?=
 =?utf-8?B?N1oxM0VNT0NYWkduV0xlUnFYT0pReEtYZXZvOVE3aE43dlhGZ0pQWFM1bCti?=
 =?utf-8?B?Wld5Y1FPN1lRYURhb3REWjVEOHVua2lpUU04ZnAzL2V3dHVEYkhPOHFYcUh2?=
 =?utf-8?B?TmR5Tjh1eDNzeURtMWNjSk03bHR5aXNjYkhKb2VKdnBucytCMncxU25qVmlm?=
 =?utf-8?B?dFJ4RFRFWTVrOGRNck9KVXpUTm9YSThYci8yU01MVmtVMXF2OU5HTTVySG1X?=
 =?utf-8?B?UFlWTGFIeDFtQmZxSVpERGM5WkhMSUlROGI2Q3F0YkxFdFprY0RLSUpWTVVt?=
 =?utf-8?B?Q2hoVnJ6T3RlbFV3TTdaZGdiemNRSHNUQXBjQUZBelZTcUEvS3pxbnpXWU5U?=
 =?utf-8?B?TFVBZDZtUld6YVR2cWwzTzdhUnppMGc0cW1sUlIyMjBlQnZkbTFkSDZ5YmNZ?=
 =?utf-8?B?OVFxRTUxaGR6eDIrQmxRK2ZTMVNvaXMwRlRYZlNjNlpJaEZuZ2E4bHNlckRj?=
 =?utf-8?B?VVNjblBPOCtvMDM3NjlOcWxodUZ2VlNxd2c3RXcrTkEvNjlJcFBoTlRCRTNE?=
 =?utf-8?B?VnJzMFRQTFBMNEVtandVTVFTaFpVSTVHOEFnT3JGb29tdWpmUHhNRnFmTWo3?=
 =?utf-8?B?ZWc0bEpkSDJHa2x4WlloWlUvMzlISGNqYkZOaWxSZnF1ODhNVmVxNUd6NkVv?=
 =?utf-8?B?YndRdjdISGZoaHFranBIU2pEMjR4aFFJdWdWRUJicGFjRlZaaWt0T0RuMlVD?=
 =?utf-8?B?NDI2dEpEWkV2SEk0MEx1c1E3ZkFTTGJuWlFGdEhhK2gwelZIeEtFZXdFL09H?=
 =?utf-8?B?b0gwOFNiOWUxbTJvV0JZc0dZUkdhWjErS3F2Zy94U1VGT21BbVBSVkNMemJW?=
 =?utf-8?B?NVRPakdmTHZFdUE4SGxGeE9zK3dCbEhiTUtlVXR4WGVBMi9KMXk4U1VHMEFZ?=
 =?utf-8?B?NUd4cXdMdUR0TjlsYVFldFNQWDNVc3hxbFlBaUlabnFERVRmR0JtRUNyeFk0?=
 =?utf-8?B?b2FXTHNTVWkyL3lBSzJDd0JJWVQrVmhNaE44TnR2bVZ0TUdzN0ZnRkQvSWV4?=
 =?utf-8?Q?jPAFlyBnMyewK0Gjw0yTN0vwr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB7130.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62506935-17a3-429a-b032-08ddff5bfd37
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 13:27:51.1019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NsEZa0bMkeA1cUIzmw0whkG6zQTqK4JQ/DSj0kZMC4Ku+Qj1sx5ZX6IYNSgd6uMg6wMQHBahNFJzasBS6R/TgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4794
X-OriginatorOrg: intel.com

SGkgSmlhcWksDQoNCj4gRnJvbTogSmlhcWkgWWFuIDxqaWFxaXlhbkBnb29nbGUuY29tPg0KPiBb
Li4uXQ0KPiA+ICAgRmlyc3QgTWFjaGluZSBDaGVjayBvY2N1cnMgLy8gWzFdDQo+ID4gICAgIG1l
bW9yeV9mYWlsdXJlKCkgICAgICAgICAvLyBbMl0NCj4gPiAgICAgICB0cnlfdG9fc3BsaXRfdGhw
X3BhZ2UoKQ0KPiA+ICAgICAgICAgc3BsaXRfaHVnZV9wYWdlKCkNCj4gPiAgICAgICAgICAgc3Bs
aXRfaHVnZV9wYWdlX3RvX2xpc3RfdG9fb3JkZXIoKQ0KPiA+ICAgICAgICAgICAgIF9fZm9saW9f
c3BsaXQoKSAgLy8gWzNdDQo+ID4gICAgICAgICAgICAgICByZW1hcF9wYWdlKCkNCj4gPiAgICAg
ICAgICAgICAgICAgcmVtb3ZlX21pZ3JhdGlvbl9wdGVzKCkNCj4gPiAgICAgICAgICAgICAgICAg
ICByZW1vdmVfbWlncmF0aW9uX3B0ZSgpDQo+ID4gICAgICAgICAgICAgICAgICAgICB0cnlfdG9f
bWFwX3VudXNlZF90b196ZXJvcGFnZSgpDQo+IA0KPiBKdXN0IGFuIG9ic2VydmF0aW9uOiBVbmZv
cnR1bmF0ZWx5IFRIUCBvbmx5IGhhcyBQYWdlSGFzSFdQb2lzb25lZCBhbmQNCj4gZG9uJ3Qga25v
dyB0aGUgZXhhY3QgSFdQb2lzb25lZCBwYWdlLiBPdGhlcndpc2UsIHdlIG1heSBzdGlsbCB1c2UN
Cj4gemVyb3BhZ2UgZm9yIHRoZXNlIG5vdCBIV1BvaXNvbmVkLg0KPiANCg0KVGhhbmtzIGZvciBj
YXRjaGluZyB0aGlzLiANCg0KTWlhb2hlIG1lbnRpb25lZCBpbiBhbm90aGVyIGUtbWFpbCB0aGF0
IHRoZXJlIHdhcyBhbsKgSFdQb2lzb25lZCBmbGFnIGZvciB0aGUgcmF3IGVycm9yIDRLIHBhZ2Uu
DQpXZSBjb3VsZCB1c2UgdGhhdCBmbGFnIGp1c3QgdG8gc2tpcCB0aGF0IHJhdyBlcnJvciBwYWdl
IGFuZCBzdGlsbCB1c2UgdGhlIHplcm9wYWdlIGZvciBvdGhlcg0KaGVhbHRoeSBzdWItcGFnZXMu
IEknbGwgdHJ5IHRoYXQuDQoNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgbWVtY2hyX2ludigp
ICAgICAgICAgICAgICAgICAgIC8vIFs0XQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIFNl
Y29uZCBNYWNoaW5lIENoZWNrIG9jY3VycyAgLy8gWzVdDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICBLZXJuZWwgcGFuaWMNCj4gPg0KPiBbLi4uXQ0KPiA+IC0tLSBhL21tL21lbW9yeS1m
YWlsdXJlLmMNCj4gPiArKysgYi9tbS9tZW1vcnktZmFpbHVyZS5jDQo+ID4gQEAgLTIzNTEsOCAr
MjM1MSwxMCBAQCBpbnQgbWVtb3J5X2ZhaWx1cmUodW5zaWduZWQgbG9uZyBwZm4sIGludCBmbGFn
cykNCj4gPiAgICAgICAgICAgICAgICAgICogb3RoZXJ3aXNlIGl0IG1heSByYWNlIHdpdGggVEhQ
IHNwbGl0Lg0KPiA+ICAgICAgICAgICAgICAgICAgKiBBbmQgdGhlIGZsYWcgY2FuJ3QgYmUgc2V0
IGluIGdldF9od3BvaXNvbl9wYWdlKCkgc2luY2UNCj4gPiAgICAgICAgICAgICAgICAgICogaXQg
aXMgY2FsbGVkIGJ5IHNvZnQgb2ZmbGluZSB0b28gYW5kIGl0IGlzIGp1c3QgY2FsbGVkDQo+ID4g
LSAgICAgICAgICAgICAgICAqIGZvciAhTUZfQ09VTlRfSU5DUkVBU0VELiAgU28gaGVyZSBzZWVt
cyB0byBiZSB0aGUgYmVzdA0KPiA+IC0gICAgICAgICAgICAgICAgKiBwbGFjZS4NCj4gPiArICAg
ICAgICAgICAgICAgICogZm9yICFNRl9DT1VOVF9JTkNSRUFTRUQuDQo+ID4gKyAgICAgICAgICAg
ICAgICAqIEl0IGFsc28gdGVsbHMgc3BsaXRfaHVnZV9wYWdlKCkgdG8gbm90IGJvdGhlciB1c2lu
Zw0KPiANCj4gbml0OiBpdCBtYXkgY29uZnVzZSByZWFkZXJzIG9mIHNwbGl0X2h1Z2VfcGFnZSB3
aGVuIHRoZXkgZGlkbid0IHNlZSBhbnkgY2hlY2sNCj4gb24gdGhlIGh3cG9pc29uIGZsYWcuIFNv
IGZyb20gcmVhZGFiaWxpdHkgUG9WLCBpdCBtYXkgYmUgYmV0dGVyIHRvIHJlZmVyIHRvIHRoaXMN
Cj4gaW4gYSBtb3JlIGdlbmVyaWMgdGVybSBsaWtlIHRoZSAiZm9sbG93aW5nIFRIUCBzcGxpdHRp
bmcgcHJvY2VzcyIgKEkgd291bGQNCj4gcHJlZmVyIHRoaXMpLCBvciB0byBwb2ludCBwcmVjaXNl
bHkgdG8gX19mb2xpb19zcGxpdC4NCj4gDQoNCk9LLiBJJ2xsIHVwZGF0ZSB0aGlzIGNvbW1lbnQg
aW4gdjIuDQoNCj4gRXZlcnl0aGluZyBlbHNlIGxvb2tzIGdvb2QgdG8gbWUuDQo+IA0KPiBSZXZp
ZXdlZC1ieTogSmlhcWkgWWFuIDxqaWFxaXlhbkBnb29nbGUuY29tPg0KDQpUaGFua3MuDQoNCi1R
aXV4dQ0K

