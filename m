Return-Path: <linux-kernel+bounces-733452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E07BB074D8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B7E17B9D2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDA12F3636;
	Wed, 16 Jul 2025 11:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a4KhkC2E"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAF32C3266
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 11:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752665605; cv=fail; b=FWEYmgnC1pIistLEiDG7YXtaK69qEQKBvrXgH8evmBL+2Oj3Ipk647ciR9/Z5dHzJqj7nKZb87aiw/+ks3KET10mk2L5UtuErnO8rcdq3a8xUbbe5L+gw+6bc8n2qqvFCrTFZ3jhhmBFBR7oavoRgEJdzXxalIHqxSOxzgsK6Ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752665605; c=relaxed/simple;
	bh=CSov3D9TEN5vL2ca3+TuGkZZ3/xsyod6VpqrHlCyuQM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EGMDk5tAW01d5XZgAl0+41CWqqoS2Y7f/oQG4zi0TPuWuDVmrydZKvLiLzwvdheJzkAseOvNylb2IZhplWn+LFe+U4Mvfpb/P3M3C0uF7eM/KfIp4KxvEXX5DMXOmQuf633YoIh24sv1HnNK/a7TiC4xWXLjZlADwMfxHnJwvKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a4KhkC2E; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752665604; x=1784201604;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CSov3D9TEN5vL2ca3+TuGkZZ3/xsyod6VpqrHlCyuQM=;
  b=a4KhkC2EVe5MWY++82a3SFDdv9aR/KxXGzQUxlmBhwmqUARoREQt5yzz
   Pbpsr+blW8CMzSLFo+DcFIcd+K2z6YWtvnQmtlHyVwsMgJFaN0DGY7+uJ
   Cp/X4uAtgu8ymQYtcLgwH6lD2DYWCOpADQ970AVoh/QNqzmjDToVGUNbT
   OFBLbPmgpWoblOwglJsp8rlIbmnzsQHrvgW9KmgpaK4gJYePJi9V7qFWC
   aajUoxzyXfMSx7oyJxoR89b7Yijx2sWAM4Pd8uGOwitocPDUJ6Lb17mik
   QduPhSpvPc0K8MSyGzazWY0EChFqb5RuU9PiORwLEXoodpLK8+fhF/b3x
   Q==;
X-CSE-ConnectionGUID: FeObikGtRPOgthHIRjVJPg==
X-CSE-MsgGUID: S2sQWIAMTZi3xr4lLMIAIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="77440518"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="77440518"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 04:33:24 -0700
X-CSE-ConnectionGUID: xqfkKGZYSr2k1T+SMhURng==
X-CSE-MsgGUID: uy9vS3lVTG2Opmbhg+6nzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="194622881"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 04:33:23 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 04:33:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 04:33:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.72)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 04:33:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6OtvfPp9w7Lon676GD5fSqeoelLIzcGgXB3zfC6YSc4RgDGrhiABRrksRjtaYJvNoDi7HFmc3ft7Vg6u69hZXZ/CxLkg75HlzbtEbsrfer3wrEqnSrvrec8FpyHuTpAuRFV7FuCk7OeDotnRaFo1xvawpOO8sVnNnvhTcVsdAbe8YmCibEKum0mb+O1Q5zd0puksNG8P30OteEDz9bzl5Ri6oJ4TcaAMDiO51flt9x8H1y4rZK0LcTFdt48MGvzJr4P3MMNUBOd7iYYCArwieuMTGsW+9MI2kBgkVAyCByc0CF3M8DAa3CrVvZ27EmpOSZ5w/udm/Le4gJ4NxvlZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSov3D9TEN5vL2ca3+TuGkZZ3/xsyod6VpqrHlCyuQM=;
 b=ilC1AOaNVcrkBdCEB57lfT+4pv2Jsw5uq+MXdPyRvaaM5qT4SB5GhOYRyU0ccByFlL8xF34OGdqlOzxypNCf/9gELo6LByyWeTuARH0Lu2U03bMgnDnhQ9T4MNCpqkzleLnI/zPHlfBZ/2wl6HA2sIbm8JlgdFPQa2YZuZ+3AgEgL4HVtGv5AJATSo7MCf8NYozMVCGToVjWBHKy7rJUWxY9GbS9wUi3TytkHGOT/zRfssUs3msW0gPe8ict12BiIdEANudBMR6oxeJmtsClYT9BbBzgo+JUh8spwl//ZF2DCtS8wN5kCewgpK3y7JiVvn75zBgRLNBQOcSbTVxj4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5525.namprd11.prod.outlook.com (2603:10b6:208:31f::10)
 by PH7PR11MB6474.namprd11.prod.outlook.com (2603:10b6:510:1f2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 11:33:19 +0000
Received: from BL1PR11MB5525.namprd11.prod.outlook.com
 ([fe80::1a2f:c489:24a5:da66]) by BL1PR11MB5525.namprd11.prod.outlook.com
 ([fe80::1a2f:c489:24a5:da66%4]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 11:33:19 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "khaliidcaliy@gmail.com"
	<khaliidcaliy@gmail.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
CC: "hpa@zytor.com" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "khaliidcaly@gmail.com"
	<khaliidcaly@gmail.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v8] x86/boot: Don't return encryption mask from
 __startup_64()
Thread-Topic: [PATCH v8] x86/boot: Don't return encryption mask from
 __startup_64()
Thread-Index: AQHb9jJn73M6zjLUS0aibh+T6AsQ1rQ0nnIA
Date: Wed, 16 Jul 2025 11:33:19 +0000
Message-ID: <51aad9762bca3678f0d79adf72728e54c67973ce.camel@intel.com>
References: <20250716091332.737-1-khaliidcaliy@gmail.com>
In-Reply-To: <20250716091332.737-1-khaliidcaliy@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2 (3.56.2-1.fc42) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5525:EE_|PH7PR11MB6474:EE_
x-ms-office365-filtering-correlation-id: 6f26548e-f0b3-472b-8dd6-08ddc45c903a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dTNMNnFwazlYWEZoTFVJS3JGTHJKSmpyWmJHOFNIOEh0U3NpRnNHSDJIM0ZB?=
 =?utf-8?B?c3IwZHpnNzlTaW8vQll3N01ZaExmZFRBaU4rOFRYbGFUWEFFMnJ0bHJMd2hj?=
 =?utf-8?B?ZVM1KzFveFl1TDlpb29QTGtzSS9obTVwUnBVa1lhczVoWnVHck1wT3pBQ1BX?=
 =?utf-8?B?d3E3RG5nczJ3YnpQRFNDd0s5eENZSXhqVnoyd0VqOEVTVVNETWpjb3F3TS92?=
 =?utf-8?B?V0NxelRrOEM2b0RmNnJvV2gzSVhENDQ1QkRGV2F4VG5adk1STGd0S3g1YmtT?=
 =?utf-8?B?Z2dRTXpML1F0QWdlcENnVXVHTllMQTdOaWNQQlpPYW1VLzg0eTlDQ1pjaVM2?=
 =?utf-8?B?OEFwOUJaRk1NQ1V6WlZhNHFVM1p4SXFHcHBCMlNjOEhHQVpUbFRFQ0x0ajNV?=
 =?utf-8?B?bEQ0bFMzY0NkT0JIWGZ1UXZyV0ZYZ0E4N0hCWlBhSEVwb0Y5czJhSFRNWXJK?=
 =?utf-8?B?bFBKUVhWVlhZbStQc0xEWDBra0N1NlZqcjJJSHpiQVNxdTRKUlh4d01oTXpE?=
 =?utf-8?B?cXprN252WWlkN3dyU1UycStxRjFpajI2Q1BaZVpkTWR0Wk52M2xDS2JNWEwx?=
 =?utf-8?B?ZzdUeWdMejRTaWh1REhxYTE0TVZTVHZCd0oxVHJOMCtVRnRwaTgvdk52c0FO?=
 =?utf-8?B?N1BvQWRQZSt1L2xhc1R2SDVnZmEvQnZTWDhTQm1IcGZzOXdteENLVTJvM1Bn?=
 =?utf-8?B?T2w4cGNwWHhBMWI3Z1pDVUVYbWdxZ0paaGxCcWZlMzJ2a1VLWEZDZm9GV0Fn?=
 =?utf-8?B?NjIxbXV6dlY3ZTN3TDNvRjdPcCtaaEJJUFJvWHkwSnpudHhOSXczM2VBaVFT?=
 =?utf-8?B?ZXUySlVxQnE0RXlnY3JlQ2VKMnBEd3JkNnl5dDVoSFBpb2Q2RVAyTHpRWlcz?=
 =?utf-8?B?ZytRTHpDZVg0bm1Tb3dWYUZGRlVuVktpTlR3Y0xxQjJoTk5vOGVhTHlpb2x1?=
 =?utf-8?B?bWlXUHBuK1FVSlFUekowR3p6M1RnVHhOUjczb3RxeHFGQ1BsVlRYeE41WWdG?=
 =?utf-8?B?eGppMWJ3bmNyVEl5WDcxQ3R6bkF6TkQ2cmVSeENjQkEvUEQwQUtNMlFyU3dQ?=
 =?utf-8?B?OFRvRHhBVDRySlo1SVIzcGpTY3AvMFJWSUdwMzU3MEY2Z3p0Sm5NREphVTdR?=
 =?utf-8?B?bXhqWXcwaEcwKzV2YWhUeW5iNnVBKzdtWGVEK0RvV1hmT3Y1S09JUFV1cTFK?=
 =?utf-8?B?cXlDem5jT0lMVXpMWkVzVnZBWVlPTkloWWZuNEtDTGI5VCtxN1hZTi9JdGVy?=
 =?utf-8?B?NFZUbGVRcFhQbzFQRlhJdElqSW12WnhOM3RscktkK2VDckh1czFZTm9KSTFF?=
 =?utf-8?B?MkFISjFKUTZFQ2p6dWxkM3dManBCdWZIZ05jWm1kWWFQTkZvSEFvQksrU2p5?=
 =?utf-8?B?SlJRcUJhRlFzNXpFTzhMYUV1RDhtTjNhYUFkUEVNekY0MWN3SWlneExKMjho?=
 =?utf-8?B?M0U5VnA1RGh5U0RmMXZrTVNhMk1QeWpZclpJdkhQQkRBVEM2RXRuT1J5UWg4?=
 =?utf-8?B?bncwV09hUitVaHZnZ0lJMTlycjJRQWRyVkdpanRwWGR2dnQ0dldoYy93bUVa?=
 =?utf-8?B?Zm5YNDBpemVoL0w5YlZuTEhkL2pCYzRqZVN1RjVPRVZhcUVKZXBZZTd6UmVk?=
 =?utf-8?B?TmREdEU1V0dhUHFBdHMwdSt6NHd0cGhNdk93bjRwQ28zQVJlTm9jWVFKb0VD?=
 =?utf-8?B?TVA3UUJGa0c3Nkd1eUlzSDNMMUNiV2ZBVEMzK0FPOEZyRWsvclVzbWs1cTc3?=
 =?utf-8?B?WVovVDZyTkRma3ZCc01adklTMU5WV2VSdXRyZnRMZWxUdEpRNllhR3d2R2V2?=
 =?utf-8?B?RGFrM0JmSVRER2ZSdWlkekl2SkM0V21HT2wwV1RDazd0eGJQaTZzUkQxSito?=
 =?utf-8?B?Y0NuVlhNZ2d1U1N6eTB5YzkydTJONjFxd05MUzA2cTlkbnJRV05rUXRYY29j?=
 =?utf-8?B?VGgveVczcHBudUpsR0xKakJlMGZXRm9PWTNwTlBkaHNKd1VmZk5NMEJSUnFl?=
 =?utf-8?B?WHNzVEhzMTRnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5525.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZW1XUFlyZEo1NDEzWUFHdEhSaU1nYmcwN2trSDJjVHJsSkZhMVdiL2NYdjJU?=
 =?utf-8?B?Mmw4dG82MkVRbmNnZDZiTlRJMU9ickFSeVNPQjRBNldWN1dRWkU2VktGNW5j?=
 =?utf-8?B?TDZCWWVNZHR1TjRUVEhxd2xkK0FWQ0U4bjMrM0cxMVpkU0V0MTBoTHh4WlJl?=
 =?utf-8?B?RkkyMFlvVEozT3VHa0FlN3hxeTlZdklMM0FTUE15ZnVycjQrVWcwdzZ2dmMw?=
 =?utf-8?B?ZEQvUWR5aXAyRS90VmRKWXh4NldDM0pDTnVTOU9iRWJZbGltOFBNblNUaXhm?=
 =?utf-8?B?OVZaaUtUb084bFl5UzA5V3orb2R2QVZzTkFzUDZsSm13VGRxb2h3WFB1dTdJ?=
 =?utf-8?B?cUYraHlFWWhhdXRMQlFDV0RPVVk3K3kvQUF0WDhPekZlTVFKSEpBYWI4empw?=
 =?utf-8?B?RFlvSU1CTkVoT3oyMkpFUUZxTEV4dG1DL3B2UkdYU0U4emtPZFlvQUkrcWxR?=
 =?utf-8?B?NG0xUkMxOU1LbVVrMXV3emZYR3Q5TlpYNkw0ZUp0UzA3ZlRUSzh1WmZwbHc5?=
 =?utf-8?B?am9NREhjTlRiOXlsdTQxanV4WHlObjROZXRPMEJ6aUtzUCtPOWVLMVQzcGRC?=
 =?utf-8?B?bnNQRDBqcWVxMUJXTnRwaEdiYlFlcG02dHljK3VHbmRlNVJKaFdFNUFPaWRo?=
 =?utf-8?B?WUJZTG9qM0FVd1RYcUtnMStTYlA3NDlQaFU2dCtPN09MY3YwS1ROaDRBVisr?=
 =?utf-8?B?Rm4zcno5WVNTOUR1T1BWaG56ZkZSSXR4QnhuNVNUVzVuMXg1bVRwTjJqOXhV?=
 =?utf-8?B?ZG5uQWd0ZHh5N0RmQ2p4dVZSV3dRd2JBcm5EQnVMNXNESEY0NWtRY1E2QnUz?=
 =?utf-8?B?SDRYMmRkZDRSUloxbDJGUWRISFRLQzZnUFgzd0dkRGFnYzB6V1E1NVVsZkhJ?=
 =?utf-8?B?K0V2eEdXQnVxak1zYkU3MjFqZ3dRSUxVM0tnUEozNnYrSlRpUmxHZks1MS9N?=
 =?utf-8?B?TkF2U09yeE1VNlYvMURYN1EzVFZvc2ZKWHByL2RDWWNTeVlaeUhGQUI2THpG?=
 =?utf-8?B?amN3RkNpQmk5cTZmNzd6NlEwYVF2RGdBU1dtM00yTm5QZk9LejJESnp1aWFX?=
 =?utf-8?B?YlhxYWx0enJyOG5JSEdOVmszRjR4a0tCaGtRRTlMOXBjTkhWais4cVdOSWMx?=
 =?utf-8?B?QVJpbkthNGFIVEdzS3l6TDNQQ09jdFNyWEJRMWsxMW53VGhUcTc4M1FBbmd0?=
 =?utf-8?B?TTFFcDd1WnFieXpCQXdKNGpDcEoyYlVFSndDNFhrVDZMZndIOE0yUDlIQklY?=
 =?utf-8?B?TU5qS3h2dXJJWldKSDJmbkM3YkFacUFxVFBmMmRoamQ5ZEUvSTBqSE9NWFl5?=
 =?utf-8?B?dWlmS2tKcmpqdkpEOGwydVZyZEZNM0gvajdrUm8vcm96Ym9oU3l6dGE4K0N5?=
 =?utf-8?B?M0xHUG5nN0FVcjliZURRckZYN3VORTIyYWs4M1dnU3JIZkFsWUQ5bExxWGcy?=
 =?utf-8?B?S1dISEhTcFNiRldJZGpEQktLbzJjaVFwMVZqck50ZTF0V3VlYVVVclUxZjVy?=
 =?utf-8?B?dVBnVStRQVpSU3JvUStTZElFUWxVMjZYM3VHSU9ERzAxNHl3MUJPSWV2NXFT?=
 =?utf-8?B?UmZSL056SUdaNjFOMFRNcjRrNVRXNS9jU2xtUjc2NHZUeTFPQTN2aGR1eEt1?=
 =?utf-8?B?TW1BN3FsSDJrNFhkalZuZDJTS1pvc3pBYURJbWxZblpRRnRhbi8wa0xSOHZK?=
 =?utf-8?B?Z0p4VmkvMFcvYW9vRkNJNktMM29UOXk4MGFUY2F6Yk1VS21ENTFRYnpuVyt2?=
 =?utf-8?B?cWpzbzFuQkVsbEN4VVNrQ2Z3c2Y1WlFkZGt2N1JvRnRFYWN6M1lwL3kwZnlS?=
 =?utf-8?B?UjEvNnhsVWtDekJOYzZpVVlhRTlXcUo5S3dBUUVxRitKZWtLOE5EcjFHR2do?=
 =?utf-8?B?YnlTUDc3T0dVSmU3U05rS0hFaDV0MUhwNEFBaHgzQVNxcGh5UU5uYzJpQjVN?=
 =?utf-8?B?bk5tNGJqaFBUaU1JZFpwS05VR3dDbU5hRm45WWJzWWZ5S09OMWhKMlYrQytD?=
 =?utf-8?B?ZDhia3dxWHhHS2ZMRFhlcDZndlUxVnZkZmZBd3hROFAxYjd6QzFxb09NUWJ5?=
 =?utf-8?B?WEpOZXhzeWFJOFBzdGJoSGV4LzY4R29Xc2dSS0d6cEtkTHhIL1NFOWRLMEdX?=
 =?utf-8?Q?3cktByTz1dyHCQECNfUVVzT7s?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCF83FA9BA075D41A00C3E6005805B8E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5525.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f26548e-f0b3-472b-8dd6-08ddc45c903a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 11:33:19.2085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z2QJJt7QMHno4LxJk/DakhV/GoT+4KWOp4UY0wQCKhrNWsfSL+rAuFq3GMDNagcv0yHb07rbHXt0d+ip6Y9Xdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6474
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTA3LTE2IGF0IDA5OjExICswMDAwLCBLaGFsaWQgQWxpIHdyb3RlOg0KPiBG
cm9tOiBLaGFsaWQgQWxpIDxraGFsaWlkY2FseUBnbWFpbC5jb20+DQo+IA0KPiBBdm9pZCByZXR1
cm5pbmcgZW5jcnlwdGlvbiBtYXNrIHRvIGNhbGxlcnMgb2YgX19zdGFydHVwXzY0KCkuDQo+IA0K
PiBUaGUgZW5jcnlwdGlvbiBtYXNrIGlzIGF2YWlsYWJsZSB0byBjYWxsZXJzIGFuZCBjYW5iZSBh
Y2Nlc3NlZA0KCQkJCQkJICBeDQoJCQkJCQkgIGNhbiBiZQ0KDQo+IHNtZV9nZXRfbWVfbWFzaygp
IGluIEMgY29kZSBhbmQgc21lX21lX21hc2sgc3ltYm9sIGluIGFzc2VtYmx5IGNvZGUuDQo+IA0K
PiBUaGlzIGNoYW5nZSBhbGlnbnMgdGhlIHdheSB0aGUgbWFzayBpcyByZXRyaWV2ZWQgaW4NCj4g
c2Vjb25kYXJ5X3N0YXJ0dXBfNjRfbm9fdmVyaWZ5KCkuDQo+IA0KPiBObyBmdW5jdGlvbmFsaXR5
IGNoYW5nZSBpbnRlbmRlZCwgb25seSBjb25zaXN0ZW5jeSBpbXByb3ZlbWVudCwgc28gdGhlDQo+
IGNvZGUgYmVjb21lcyBjbGVhbmVyLg0KPiANCj4gT24gaW50ZWwgcHJvY2Vzc29ycyBzbWVfbWVf
bWFzayBpcyB6ZXJvLiBTbywgaXQgaXMgc2FmZSB0byBhZGQgbWFzayBvbmx5DQo+IGlmIENPTkZJ
R19BTURfTUVNX0VOQ1JZUFQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLaGFsaWQgQWxpIDxraGFs
aWlkY2FseUBnbWFpbC5jb20+DQo+IEFja2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRl
bC5jb20+DQo+IC0tLQ0KPiANCj4gQ2hhbmdlcyBpbiB2ODoNCj4gICAqIEltcHJvdmUgY29tbWl0
IG1lc3NhZ2UgZm9yIGNsYXJpdHkuDQoNCkFwcGFyZW50bHkgbm90IGp1dCBjb21taXQgbWVzc2Fn
ZSBjaGFuZ2UsIHNpbmNlIC4uLg0KDQoNCg0KPiAgCS8qDQo+ICAJICogUGVyZm9ybSBwYWdldGFi
bGUgZml4dXBzLiBBZGRpdGlvbmFsbHksIGlmIFNNRSBpcyBhY3RpdmUsIGVuY3J5cHQNCj4gLQkg
KiB0aGUga2VybmVsIGFuZCByZXRyaWV2ZSB0aGUgbW9kaWZpZXIgKFNNRSBlbmNyeXB0aW9uIG1h
c2sgaWYgU01FDQo+IC0JICogaXMgYWN0aXZlKSB0byBiZSBhZGRlZCB0byB0aGUgaW5pdGlhbCBw
Z2RpciBlbnRyeSB0aGF0IHdpbGwgYmUNCj4gLQkgKiBwcm9ncmFtbWVkIGludG8gQ1IzLg0KPiAt
CSAqLw0KPiArCSAqIHRoZSBrZXJuZWwuDQo+ICsJKi8NCg0KLi4uIHRoZSBpbmRlbnQgb2YgdGhp
cyBjb21tZW50IGlzIGJyb2tlbi4gIFlvdXIgdjcgd2FzIGZpbmUuDQoNCkFuZCAuLi4NCg0KPiAg
CW1vdnEJJXIxNSwgJXJzaQ0KPiAgCWNhbGwJX19zdGFydHVwXzY0DQo+ICANCj4gIAkvKiBGb3Jt
IHRoZSBDUjMgdmFsdWUgYmVpbmcgc3VyZSB0byBpbmNsdWRlIHRoZSBDUjMgbW9kaWZpZXIgKi8N
Cj4gLQlsZWFxCWVhcmx5X3RvcF9wZ3QoJXJpcCksICVyY3gNCj4gLQlhZGRxCSVyY3gsICVyYXgN
Cj4gKwlsZWFxCWVhcmx5X3RvcF9wZ3QoJXJpcCksICVyYXgNCj4gIA0KPiAgI2lmZGVmIENPTkZJ
R19BTURfTUVNX0VOQ1JZUFQNCj4gKwkvKiBSZXRyaWV2ZSB0aGUgbW9kaWZpZXIgKFNNRSBlbmNy
eXB0aW9uIG1hc2sgaWYgU01FDQo+ICsJICogaXMgYWN0aXZlKSB0byBiZSBhZGRlZCB0byB0aGUg
aW5pdGlhbCBwZ2RpciBlbnRyeSB0aGF0IHdpbGwgYmUNCj4gKwkgKiBwcm9ncmFtbWVkIGludG8g
Q1IzLg0KPiArCSAqLw0KDQouLi4gdGhpcyBjb21tZW50IHN0eWxlIGlzIGJyb2tlbiB0b28uICBB
Z2FpbiwgeW91ciB2NyB3YXMgZmluZToNCg0KKwkvKg0KKwkgKiBSZXRyaWV2ZSB0aGUgbW9kaWZp
ZXIgKFNNRSBlbmNyeXB0aW9uIG1hc2sgaWYgU01FDQorCSAqIGlzIGFjdGl2ZSkgdG8gYmUgYWRk
ZWQgdG8gdGhlIGluaXRpYWwgcGdkaXIgZW50cnkgdGhhdCB3aWxsIGJlDQorCSAqIHByb2dyYW1t
ZWQgaW50byBDUjMuDQorCSAqLw0KDQoNCkkgYW0gbm90IHN1cmUgaG93IHlvdSBlbmRlZCB1cCB3
aXRoIHRob3NlIHJhbmRvbSBicm9rZW4gY2hhbmdlcywgYmVjYXVzZQ0KdGhleSBhcmUgcXVpdGUg
dW51c3VhbCB0byBtZS4NCg0KQ291bGQgeW91IHBsZWFzZSByZW1vdmUgbXkgQWNrZWQtYnk/DQo=

