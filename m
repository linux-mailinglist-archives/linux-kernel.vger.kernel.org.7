Return-Path: <linux-kernel+bounces-888802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCA4C3BF32
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBEC318993DE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9037B337B93;
	Thu,  6 Nov 2025 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pqcxf/Mc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB183093DB
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762441340; cv=fail; b=bPvr7ZuPkVMc9hBJ3Et6S5+UzefL0IRuhST5V+JRhBx3bvZpb0DkHV328NVcpu88lvcNhBzWxHyLrF3iO5ZJL2vnuDdoQq+XCKPbYl8cmlzpaVIHNuV/mHQH+fqhaS11qxvdcU5OHqoPh36rxbW4HvGCbUSKF46z4jJdmrzlqdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762441340; c=relaxed/simple;
	bh=ds14I6qcHzLD0H9wdHge5WM2YtobQnfFE5A0FW9rn7A=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dX20wAgwt+I6dVNYaKse+UnVVXgEs3KwaGP9d/A/6OQdc3wPYkMU/cu0PXPdeLDndnXrA68M8Ge1ugjEkyi4eL3G/evWXVMVQnCil0p0fz8DYG4Iv1tkuOA8SO+hbaML1QH8t6RChFqtzIO43HC6wFWBxTmiouA1HAUZgP9vjKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pqcxf/Mc; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762441339; x=1793977339;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=ds14I6qcHzLD0H9wdHge5WM2YtobQnfFE5A0FW9rn7A=;
  b=Pqcxf/Mc42JNsoVFK12GHLE5PtYW5+cDoNHUJx4c3bouHyUC4V8i8jrk
   YkCq1fbI5Txnau6Idbm9w0C831g+3obdSKUpy6ol8fDJwsGcyhXWryQRo
   CJzHiDsakZDnFT9MGHmwmK9xBrBshbsmdtjb2eBI8+wjSts0lRVyqVBOX
   ZvrivtTKCr7GWsJzgBjPKIR1TDF0TUZMbpPNPUqcgGPflGo0a41eMaiPf
   W11KU5QAzEyVrBbWwj6rQHYUcIJ/OkxxNz50sHJD2l/HJs7f9r2Dwhc2r
   vDOTcrA+rdlp0TKqkJyFMo7pDQnGlPMNEZiSINitX1ZOOxL8YQph9GucZ
   w==;
X-CSE-ConnectionGUID: GTUjreOpSfiPi8+x0E5ZXQ==
X-CSE-MsgGUID: JnNeH0JmRi+ct5KiHAlH/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="87209058"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="87209058"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 07:02:18 -0800
X-CSE-ConnectionGUID: /x+4XfB9SHWxHYsopO8S3w==
X-CSE-MsgGUID: +wucdORETkOiLYF2JOxVfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="187492374"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 07:02:18 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 07:02:17 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 07:02:17 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.41) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 07:02:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzsa3f+31zNTShP7jgyRtC4RBg+0K3bpZNCr10JEGjP2vGWWaBPg7eKxo49Hxj/aNe3Ng6dtK91X5T3mAgofBtTEYpV2K3krJkB3oFTN/AVySUOr+hlxXvaN0oNsAfFteFjSWNQyrw2WFqh2GVsuGZLX/wTCutLC3re0cwgFuiCq7H4lg7TyuMnM/yKng+48/ZgtA/QGq7sEIGq0178qwXzRk/8sH4YXkcT4xBbzjvZdWHQlcDVlEW2kvEoWNSrhLw+At7rFokLu/tFOB2CVS7el95EhnbEE71MljlARmlm6f2WeY/E345x7tZR4h/sVNhM6OqXIMiHWJSnjorCvLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ds14I6qcHzLD0H9wdHge5WM2YtobQnfFE5A0FW9rn7A=;
 b=bgU1o5cVinsoKHBiAL9ggLvAerNlQ8nUQ9ncSkrjpX9iUyin7Md5o3+fBuDpVpfHDRq5p3XiuJwQNp9vBXwDRJWjTxgVs2qFNKFSvNEcHy7Ck9u4WQO5FdSSApZUKODeKU9b72XH6auD41mqnZLXMASVQkmiS8FGFUZ9am8PVRs3l43E7vvyOHX2CRTFwzGwvu2iP56Z3x8ESX3I67jDK8P0cHNsuhn0NdwdrSjQwTvtzO68gXGkJtnFR+/2XCkOTGAnaOVmSt51VftRoQP9klZL6CoaaW6NvO3v5R0l+T0cs1kfTdJ7jnFRMDRbCjIMgX2nRs/z/TlKn73bIPDlcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5330.namprd11.prod.outlook.com (2603:10b6:610:bd::7)
 by IA1PR11MB9494.namprd11.prod.outlook.com (2603:10b6:208:59c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 15:02:16 +0000
Received: from CH0PR11MB5330.namprd11.prod.outlook.com
 ([fe80::9d32:3dfb:c2f1:40e2]) by CH0PR11MB5330.namprd11.prod.outlook.com
 ([fe80::9d32:3dfb:c2f1:40e2%3]) with mapi id 15.20.9275.013; Thu, 6 Nov 2025
 15:02:15 +0000
From: "Winiarska, Iwona" <iwona.winiarska@intel.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] PECI changes for v6.19-rc1
Thread-Topic: [GIT PULL] PECI changes for v6.19-rc1
Thread-Index: AQHcTy5WXMP3ESrIeE2JL4gXZ8xGCA==
Date: Thu, 6 Nov 2025 15:02:15 +0000
Message-ID: <a8bc9becd448a48eb286697155ac8ec716e3467c.camel@intel.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5330:EE_|IA1PR11MB9494:EE_
x-ms-office365-filtering-correlation-id: ca6c9034-9667-4b8e-9a46-08de1d457938
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bGtUT2htRzNISTFEVWhFT3Bnc0tkUmJBTkJEcnM5aERibGUrOFlpVnNQbFN4?=
 =?utf-8?B?VVROUWd0N3NzdnFXNS9RSnUrZ1lreGJDZVo5QjRVSzlaWjZjMUx2QWg3Y0RE?=
 =?utf-8?B?TmlOU2oyY1J3Z1NQSVlBK3JOTk5scGN6WTdTWk1tS042d0hDUUwyZ1FTRzYz?=
 =?utf-8?B?MTZqVGhpckJYeG5hYjNPQ0w5SnBHRVBqNlhsVmRwL3h5eWUwREtCRnp6WkRN?=
 =?utf-8?B?Q296Rm5KTzY2L1BSMG5tUmpuR2VSb3diazNpNk5oWXBEbS9CdEdpTVNMeTNu?=
 =?utf-8?B?RWpjQUdSazkrcVhVdm1mSGh4R0JTdWFQWUIybU1tKzdUMjFaMnhBUVlFNG9y?=
 =?utf-8?B?MjFId3ZVaEdramROQlRMcXArdGhDeWE4YmhGWklOWW9HNXlwb2VxYklVajNw?=
 =?utf-8?B?Zm9UKzFMdGpoNk9qbkQxVzJ6NGZSd3BxYXJvRnZQajFoWmdXdEdmUDdNNzRR?=
 =?utf-8?B?RUY2NVRzT2c5WDBxQVV1aVVCNmt6R3VPU2dwTUhxS1dzN0E5V2M0ZUJxYk9M?=
 =?utf-8?B?M3N0NkVsUm1WK2NHK3YvaWFxNHVjMTMrMVMwaHEzeE1GL2EzeUJIV3k1WDRC?=
 =?utf-8?B?RkR3VXpYd21lczcxM1NabnhyZENkMWx4Q0hIMHEybjVnRnB6TFQybHRGeHVy?=
 =?utf-8?B?V2JYMmI4bzdDUUd2RGt3WERtQm50U05jY2M0MVd6TmY1c1I3U1BxMmhvcEt2?=
 =?utf-8?B?YUd3R0VCMm5zNUhEd1RrNGt2VzRiellCYTRuWUpna29pNmZwaG9Qcm9FZDMz?=
 =?utf-8?B?d010QnJuVGtoVTk4NDJjcG1xM0Y3aGJLZWZZZExhUGp0eGhXUlhDS3hqZEdz?=
 =?utf-8?B?Z1g4SlEzSm51SUdtUVYxVzFDd0UyQk5ma1VKcHVpWTNkZ0JkdHlJMGlsSFQ0?=
 =?utf-8?B?ZlorWVJvdG1FY1FLakxlSEV4TnNtRS9ILzdESlNzMTd5KzFBbjhHRGRFSy9H?=
 =?utf-8?B?NElxbGdVamY5cnRacC9mS2E1Rk9kR2I0UjdNTjlLeVVZTjN1MWM4cU4yL3N6?=
 =?utf-8?B?bFhpYTNtSXJzaXZVMnFnZUdMemE0dVpTVVFEdjF0TDhWR3lhUVdtOWZLQ1Fr?=
 =?utf-8?B?SEl3Ymh1NzV5U0x0V09uSjNPcHRQMmY3MUNRcXNxc25oZjErdDQ0eElCU0c0?=
 =?utf-8?B?QzJ5SlcvdERGdUNKWWp2REpoSGF2aWduTTRZamwyRm0wNE5LblE3Q0dMRjY1?=
 =?utf-8?B?cldMRXJEb0ZHMGY2c055V3RCTm1MTXh4cFBySkEzOEhIcVRFT2lSUnJzNisv?=
 =?utf-8?B?YmtVWWkya2x4aW13K0tGVXIySmtpeXcxNVhaS2UwYzdPKzZhQWVkZjNaei80?=
 =?utf-8?B?dUw5N2Njb1J0Q2cvd0F4VkU4T29iQzRKVTBDK3FQRktEM05tSlBnZGhWbEhk?=
 =?utf-8?B?Q1FnOVlDMnJyaE9lSzdWaHBhTklrTjVudkJXZjA1bUsrL0hRNTFlcCttakhi?=
 =?utf-8?B?VHpXdi9PM2NFVDFGQ0NVL0tKbWNHdkE0ZVAwU2N3d3FDTXF2M1ZEZ0lOcU1m?=
 =?utf-8?B?ZVUwRmpJRlJjcnk1akd2MkxsVU02ZGxsMkg4bmVLWEdSWmpPc2E4S01KL3Ry?=
 =?utf-8?B?b2t2clRuSWRQdlMzOTJlb1hQY0JVNnhLSm1UblQyL1FFRkFDR3BabU5ZcXBO?=
 =?utf-8?B?ZFNYbTkwM2N1TDhtNWhMTGsvenkyZ1pTaVBxbUxuV1BUMlhWZktQYi9NVk5X?=
 =?utf-8?B?bTZNdEhCZTJpd1ZaYnc1amRhMVJQblRqcWpiM1JSVm8vb1VsNnFhc0FKRG9n?=
 =?utf-8?B?Sy9FWHVBalk1QnZmM2V5TVdlQXA5UjJsU0tiT3UrZFlocHhTWVFoWlcyZ3JB?=
 =?utf-8?B?MHJTeEphRWhPa3doSDZtL0FoRnV0QUhraWNFdi9rNTlKV3NGSTk5cC95S0lT?=
 =?utf-8?B?UmtMRUVBNXdPazZIYVNkVlREN3ovWWtQVnM1SjR0Rk0zcURSNk8yN0pFNmMw?=
 =?utf-8?B?a0xRTGdJUHJiTUdoVTFsV2d4YTRteHFOaGNENEpSU25jemVLWTkxMk1KbGdR?=
 =?utf-8?B?OUF2OUdKemFkVE84ZlZ0VERrOTQrcGkyMHhia2FUL0I2WFpJTUFrUERDRk5V?=
 =?utf-8?Q?4b/NQa?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5330.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3I0Q1dublR2eWhTQ3hLaWQ0QlY3WjBiNDBBcERYbmNUS3Qxd0JuWllGWndh?=
 =?utf-8?B?dmhnQ2t4U0U1U1pNVXRYemowZU5IK0pxTHY0Mnd4Y1R4QW9yZG9hbEgxYVJF?=
 =?utf-8?B?U3UrYitLdS9USjRTUXk3YzhlZVQrajArS1ZUQlhKUmZKM2hldjI0YTZwdVhu?=
 =?utf-8?B?ZnBhTHpGWG5QMFRGc0pYRGJFK1BvWnNnUWJuSEdWTlV3MUdZeEcwaFp0T2tK?=
 =?utf-8?B?bUlFOEZCRmRJRnhlUmdBOUw4T1pRNDBnZXZ0aEYzZm05bG5NVmthM3VFbkNG?=
 =?utf-8?B?Mlg1dGIrYU5WNVFhY2lONWRFaENmSGExL25ZZ2xkclp5T2wvbTI2RmpmcW83?=
 =?utf-8?B?cjZzemxTckEvcmdUTmZmTWx5Wk9mMDlwdHZSYncrRlF2bXpwdWM1ZHVNbEJE?=
 =?utf-8?B?cTV1WnFMRnVLa3ZOVlZSaDZ6YlJQTXZEWXdiMllRLzNhTVRycDNuNi8wcEtC?=
 =?utf-8?B?KzB4d2F0WGhiV0Jkb2tDVXZkU2lObjN2YkxldFhKcjNPZFNvNmZCSXpGMS9s?=
 =?utf-8?B?OVBKdDNyRDI1RzNlbUpaTU94MDhuVFRSOFBubFFCSm9XeVNIR0RyNTg3NU5X?=
 =?utf-8?B?TUR4Z2hDUUJUNkVkUVJSMTFUd2VlSitiUFQ1a1dVL044OHFMYllTa3RBVmhT?=
 =?utf-8?B?MWFIOVNVVUoycVh3S1hRKzBKQzFXQUpySVg2cHBQNlZFRmcxQWh0a05SRVp3?=
 =?utf-8?B?cEkxNXdJTWdyQ25FdUdaZlVmRnVKWmgxbysxMzNjRTZnN0x2WFFZVDNpR0Fa?=
 =?utf-8?B?U0VQZHgzcnB2OTM5aTFGV29QMlBNMHl5K3VnbndDejROUEUzUHV6MEhYNW5n?=
 =?utf-8?B?NnJIOFZ6RFRibTV0TEtWY2hMSVNkaGcrZ3pVVWUwcTdPdzh1Umlud01XZkMy?=
 =?utf-8?B?V2N4Wnd6NFVBOVFHY0Zqd1JZVUdKdkw1MzUxTlZNeGpBRWtPdFI4SytuVDF5?=
 =?utf-8?B?TEtEQlExSG9KTHJQUnV6UGdkWE54QWpNckVycGJTVjFQdVRMN3h6ZVkvVTc1?=
 =?utf-8?B?K1dNaDZPQjBNdUVvM282WWtoQngyeTRqYzBISE9HUzFkbFpnNGVudjFZQ2hO?=
 =?utf-8?B?RUNnUGNxb1haaEJBaXVTaFdHTEVCNFZGQWFIaE5kMnRUbUN0Vnh0eUgwTmNU?=
 =?utf-8?B?UmxDbEZZTzFkZjcxaTRPZFhFMWJWb1crbmY4bmw3eXNFT2l0Qk9YK3M5WGNP?=
 =?utf-8?B?S2NzVHdTemJlN2UzbGhrVVVRWWtrQXRxb0Z6aXBoTDY0RVJpMzNJWUpMT25z?=
 =?utf-8?B?ci9DS2dvdlgzTWxJMWJFNzNsZjhnTFdqL2pnN3J3TndvKzh5L3NNN2p2WEJO?=
 =?utf-8?B?ZEZWMUIzSnp4Q3ljbC9ZUC9kdXB6YTVDSlBlcEFJOXpyQ0hCeEtwS1pkOHl4?=
 =?utf-8?B?ZGZ0NU5JWW9JMEluSzJRYzZqTnhDVldzOEdQYUo0anVTTkZiN2JRZEUzcFpZ?=
 =?utf-8?B?cDdML3pZb0ZVN0lSbDluWDhjcmZKbW1sYkRWckJWZTZKNGFHcnM5QUx6REVu?=
 =?utf-8?B?TnlWWVAwaEZpRWx6QUpkU2ErN20zYzFMeWJHTXVMWDhxSEdJQ0U3enRSMzhD?=
 =?utf-8?B?aWx0WjhWdHlMQmsrNjRHSVdLU0FMMVg3bHFPbDZiaDF0eWxteG1NQ2VRc09m?=
 =?utf-8?B?bmEwZmMzazFWVUgyQUM4NXJieU5MdXhGQmZZeEx3SXlUQ25pSVdLaFBONC8x?=
 =?utf-8?B?ZXdXWXRyR29nYUF0cDdrNC91aGxyeWNpQnExRjRhcVpITDRFYUlMYlE0U0hB?=
 =?utf-8?B?dkFNeW5VcXBnVmt4dkw3N05kL1pPVGVUUk82V2lUTFc2VTFhaURsM3dPbmty?=
 =?utf-8?B?UkhzZGlKUC85T0tyRFJUbE9VQU93R2VVMkRsV3NQWlRQWG1OdGNzd3JHaFAx?=
 =?utf-8?B?VkhMb3gzNWVuckZveDl2MkN5OUZvS3pSYTB4Yy9md01yQklqeExCS3lrWTRm?=
 =?utf-8?B?MnZWZHFLb01TRUM5RllyYTdaZEtVSzFnSS8zM1M2R1RWc3lGRnFwaG4wOFF1?=
 =?utf-8?B?NyszZHRvd3VsWUlQOEpXSDYxSHpJVklkejE1TzVDajhDT0V1U2hrQ3lTeHRL?=
 =?utf-8?B?cU5GNnBPam1QenV3VDhlcS93WlBUcU1ueTkwK1NYMnVUVk1YMXpxRC8zRUpU?=
 =?utf-8?B?MnFUbERrU3RpTStMY2R3UlB5Vk5taHh0bkpyYWQ5QkVaV1VoaVZZTGtlSjQv?=
 =?utf-8?B?ekE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77D55C33A1406B43BFAD137212F799A6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5330.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6c9034-9667-4b8e-9a46-08de1d457938
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 15:02:15.6532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: naVNN9JZENpzjT6lYCtMhp38OnE7TbwIU/uH+hj97lBhNTgBvZSjgIN7U09jkaJ59Hq0ZO6+PREPoLVEkaDhw+nfsHrUjFFGTNlkapBZiNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB9494
X-OriginatorOrg: intel.com

SGkgR3JlZyENCg0KUGxlYXNlIHB1bGwgUEVDSSB1cGRhdGUgZm9yIExpbnV4IHY2LjE5Lg0KDQpU
aGFua3MNCi1Jd29uYQ0KDQpUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IGRjYjZm
YTM3ZmQ3YmM5YzNkMmIwNjYzMjliMGQyN2RlZGY4YmVjYWE6DQoNCiAgTGludXggNi4xOC1yYzMg
KDIwMjUtMTAtMjYgMTU6NTk6NDkgLTA3MDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCBy
ZXBvc2l0b3J5IGF0Og0KDQogIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC9pd2kvbGludXguZ2l0IHRhZ3MvcGVjaS1uZXh0LTYuMTktcmMxDQoNCmZvciB5b3Ug
dG8gZmV0Y2ggY2hhbmdlcyB1cCB0byAzMTEyYjU4OWQzYTk5YTUyNDY3YTAzNGRiNmFiZDM1ZmVl
NWM3YzdjOg0KDQogIHBlY2k6IGNvbnRyb2xsZXI6IHBlY2ktYXNwZWVkOiBjb252ZXJ0IGZyb20g
cm91bmRfcmF0ZSgpIHRvIGRldGVybWluZV9yYXRlKCkgKDIwMjUtMTEtMDYgMTQ6NTE6MzcgKzAx
MDApDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NClVwZGF0ZSBwZWNpLW5leHQgZm9yIHY2LjE5LXJjMQ0KDQpBIHNtYWxs
IGNoYW5nZSBpbiBwZWNpLWFzcGVlZCBjb252ZXJ0aW5nIHRoZSBkcml2ZXIgYXdheSBmcm9tIGRl
cHJlY2F0ZWQNCnJvdW5kX3JhdGUoKSwgYWxsb3dpbmcgaXQgdG8gZXZlbnR1YWxseSBiZSByZW1v
dmVkIGZyb20gY2xrIHN1YnN5c3RlbS4NCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KQnJpYW4gTWFzbmV5ICgxKToNCiAg
ICAgIHBlY2k6IGNvbnRyb2xsZXI6IHBlY2ktYXNwZWVkOiBjb252ZXJ0IGZyb20gcm91bmRfcmF0
ZSgpIHRvIGRldGVybWluZV9yYXRlKCkNCg0KIGRyaXZlcnMvcGVjaS9jb250cm9sbGVyL3BlY2kt
YXNwZWVkLmMgfCAxMiArKysrKysrLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25z
KCspLCA1IGRlbGV0aW9ucygtKQ0K

