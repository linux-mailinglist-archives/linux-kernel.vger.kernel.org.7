Return-Path: <linux-kernel+bounces-578740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC23DA735D9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 16:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63852188B35E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 15:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5811991CF;
	Thu, 27 Mar 2025 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VsRJiphD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE36126BFA;
	Thu, 27 Mar 2025 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743090162; cv=fail; b=A1c/2+wJxYxhCo0evIVLhQVzamiugnPtVj5fdkjS2rOa2Ggxq5EOZeA9sCBiV0LAbXcPMepdjlSyHoNHppogXiGv+ry+IS0xDPqd5tvSpAND6wGul4z7RKJCj616vxbgzDKoQLI4YA0zpus+XzH70d9BaY0vB3l09LeK5Qe1f6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743090162; c=relaxed/simple;
	bh=qCFFfwhY5TwU3stZJ1DIogpQxbvC4O59spdmtx1BvPU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y43WD90AX0PkvP/q0RpD+fwyxPlHzsKAKJbK+OBCGdaFn+AVj0WW8k1DssVfvCET5J6rbUscoaMJj4N/BLCiKveBRLmhSJEYLZ1vn5npZca2vymcTnRVhkx4gYDiGes8PKCEUYybxCZGXap4MohTveGyIDhxlfGAUpvGC7nTHnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VsRJiphD; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743090160; x=1774626160;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qCFFfwhY5TwU3stZJ1DIogpQxbvC4O59spdmtx1BvPU=;
  b=VsRJiphDdtTgB7LocUsD+/pMgvStdpgIjnCpTFri/RNAzNECdFVmKFCy
   W2DQ4bVuIla+nA7C55sOaWsiNAK/abLrxIzKLR/enUZD8xWwgmXrcubg7
   pEBHD64JfYCiInPIcTiCkEmsdhtmIu/WzwOhkI2ce7QGxi+d3eRwW6L7r
   1TZqS4dn5kv0u/uIE3/EsN1BbBt+/pLmRHDaAZZwn8yQHPi3p0paEjDZX
   Yd7cuYAFhytjLqxBpoawEOVQ5RdEAM5QVi7/eiCiZIkNSmp/F/Oyr8Ju0
   u2iVzUvYvYJdkLkM9yCQgI2el7Mo9m4goT4MPEMnmA93qJ0BJW33SK9i6
   g==;
X-CSE-ConnectionGUID: RKj3GoPKTSWet9VdLlvGmQ==
X-CSE-MsgGUID: mYjDEg5mTK2EBOa/G/5Zbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44555341"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="44555341"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 08:42:39 -0700
X-CSE-ConnectionGUID: jZkwOuoeQf6cDNrq/Pp5qQ==
X-CSE-MsgGUID: w0FxSeINQ063LsGot6plMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="125693554"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 08:42:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Mar 2025 08:42:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 08:42:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 08:42:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJ2TPiRjYspfdOB8OhkS7ZmxthMxnhJt7YCzCEHHEGebgvYSh/92JWKSRiV8eAN+F+DG8OoWqnaPmld0HBZ9N6RALC2IR+jD0uWGVyJdpL53JLj2lfSUA9hY11wcfeRnWkeuuYN84so9HXxGaXKVqxxFEDImVeKot//cF5M7X1srlIvXp6tCZZzJKEuYlyW9iZGHFtx1yXMtlJU3fetZhgse0/jaOPSFbJtRM+Wja7o5Ten6TD+T4TKInlXxKezjjE0QYJRdiLOCYLbDvw7l2qw6XJ6NHL/3uFDbV2B/70y1aPCorpJiCBVPdAnsrKVvwWzeg4wd7dIlONWzdbKtAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCFFfwhY5TwU3stZJ1DIogpQxbvC4O59spdmtx1BvPU=;
 b=oDq/R74XmX0MNEontdkljeQW/h2GMUkf1x93mOr4hcle/5+SGezHW7f5GCzSRoRcXPtY7j7tPPsFf4YrF5585dkkOSabFhYL9n6QAio8rDldo4f0BJkvMBqrZjIGiE/uyE2PDIFOltkFchlkzVAGBMSzV3cY3gjbw1yO4Ai0QASx5WA8DeOg+OeIRFs1aFg5wG1tLomQWfjNJNAeEhfP9mcRQQPEFK4pXF5ty/racSh8g/8pKryb8/AZi9TCVa0eBp2wbT8KrdWFkAYoSHJNVbstScfpJMTKjOndDhQpg4rBYB9wdGcLIdH0N+8KNaxrESp9czNwyfAlUbPDNMt8Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 CYYPR11MB8385.namprd11.prod.outlook.com (2603:10b6:930:c1::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Thu, 27 Mar 2025 15:42:30 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::4df9:c236:8b64:403a]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::4df9:c236:8b64:403a%4]) with mapi id 15.20.8534.040; Thu, 27 Mar 2025
 15:42:30 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "linux-sgx@vger.kernel.org"
	<linux-sgx@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "Mallick,
 Asit K" <asit.k.mallick@intel.com>, "Scarlata, Vincent R"
	<vincent.r.scarlata@intel.com>, "Cai, Chong" <chongc@google.com>, "Aktas,
 Erdem" <erdemaktas@google.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"dionnaglaze@google.com" <dionnaglaze@google.com>, "bondarn@google.com"
	<bondarn@google.com>, "Raynor, Scott" <scott.raynor@intel.com>, "Zhang,
 Cathy" <cathy.zhang@intel.com>
Subject: RE: [PATCH 4/4] x86/sgx: Implement ENCLS[EUPDATESVN] and
 opportunistically call it during first EPC page alloc
Thread-Topic: [PATCH 4/4] x86/sgx: Implement ENCLS[EUPDATESVN] and
 opportunistically call it during first EPC page alloc
Thread-Index: AQHbml5zm6Mg6JqIu0KJnS8UZti+urN/vCmAgAJ9k8CAA6gNAIABRhDA
Date: Thu, 27 Mar 2025 15:42:30 +0000
Message-ID: <DM8PR11MB5750FE25D4C8EC2297952845E7A12@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20250321123938.802763-1-elena.reshetova@intel.com>
 <20250321123938.802763-5-elena.reshetova@intel.com>
 <Z983ZaTaWNqFUpYS@kernel.org>
 <DM8PR11MB575000AEB9CC3A318651AAABE7A42@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Z-RfcpSBAybk-KjG@kernel.org>
In-Reply-To: <Z-RfcpSBAybk-KjG@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|CYYPR11MB8385:EE_
x-ms-office365-filtering-correlation-id: 84cdd3ba-3f0b-4fbe-b4b4-08dd6d45fbd3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TlQwYWdyWVJiY3RqMDd5R3hvdnNRUGI5bkVCbVluRWtabmJFZUdSLzBQSXJu?=
 =?utf-8?B?RUJ5V3VOR1F2bUpFcHRyVXoyYWZmYy80Yk5VMVZYOFlLRWhURkZYU29RWUd4?=
 =?utf-8?B?WkhvNEVHeTB6WkJIM2dqS2I3Rk9pTUY0S0FFeXFyRXo5Vm16OXhmOEVZNW5K?=
 =?utf-8?B?cEdwRjU5MDUvNnpLeW9VYUdQTFRTWVNobStSbjdSbFBFMmZDTnVNR1E0NERM?=
 =?utf-8?B?Ylp0R05TSEMwVWxVZ1QwYlJSQ2oxUmRFOTNuZlExaHFjMjVMdktwK09PSkJh?=
 =?utf-8?B?WjFLdk9oZFJCeUs4UFJkdDBoQ1BVd2lodlF4T05qaW90d1l3ekF2MWVrUTc0?=
 =?utf-8?B?eVR5cG8xd214dmYrWGsvS2ZOc1U0MDVUUWtsbVNXUm1peVZSM2hMU0xqbHgz?=
 =?utf-8?B?OGk3OHdrclpITUNBcFpDcXlvT2lnTnhsR1grRHRMM2FIbWZWOXhpeVYwU2Jl?=
 =?utf-8?B?b0FhYnJnQlpKUjJhSTh1MHdCdVdmR05pVTNUS2FWZjFkdXI0TUpTMjdjMkVJ?=
 =?utf-8?B?bm4wc0NDb2E1OGQrZHBBbFFHWUxrcjJjdURZdDdmLzZhZk0vaDlzT081L3Jn?=
 =?utf-8?B?QTZ1VUUvLy84VCt4eTRnVUVqeTJaOWZRSlRyWGdSYzl6OVdDOEs5ZFpHNEd3?=
 =?utf-8?B?MGdwSkNHN3dFOVdUUjBCUURibnZNdjJhandIQ2xrOTFaeWxZaS9vZXR0VmZY?=
 =?utf-8?B?WCt2MFAwOGxVZmt2d3l5aGNHTUNsVUtHTE9Eb0F1dGVVWHIvWUN1eERxWnpK?=
 =?utf-8?B?TE84WjlFVTVJM1FvYkpaTUtuL0N2ME44bldBdVBJa1hZS3gyQ3FJcTE0Uktp?=
 =?utf-8?B?d0l1RG5hTkpQSXRmejY0NXRJUUExcThnOGNPclJYQkNjdm4yNlQzbTJXdXkx?=
 =?utf-8?B?TU9RZmsyVHRSclE1V1VjZStUZjdvQldlSVRsREgvcGYwL2tUK1c4OXB6czV6?=
 =?utf-8?B?ZFBYckdZWHNMTVdIVWJyNzFhRW5WeXRDZVFPTjVoaW0vZHpBRVlJK1lZUURC?=
 =?utf-8?B?WGRRcERvS0Nnb2RvK21lRXZQRHUvR3pwYVpUa0F3RXZWZjliWjVOVmtoR3pO?=
 =?utf-8?B?WFo4ODRrYkU3RWJSTGZ2dm15RmhKRSs2SUpNajdzTDdrM0VOejdkMW5wd3Fn?=
 =?utf-8?B?WjlPWEZNd2huTUZpbXhFS2syejMwQ3pwdldMMStNUzN1d2FTMVJrZTdmVEtP?=
 =?utf-8?B?VzNJcjJ0a0hmd2NKbzJ5S3I5ZzRiRWVndTdjY00yTWtTKzQzcTdDc0NXby9K?=
 =?utf-8?B?QzFFbFNhY1owRmxXdlN3cWZ0bmI2dmZkYzQ0L05zSy9mYjk5UHFWY3d4QjNI?=
 =?utf-8?B?UmJXWmU4V0owbVE5eXJKT01YVFE5a01nREV5bldxRlBCemVEMDdLT25CUWx0?=
 =?utf-8?B?ZzE2c29zWHNXV0ZRYy85TGZCMWNVQ3FxV0pKemgwcHBQWTRvTjBMWlc4WXdx?=
 =?utf-8?B?M3RpYm5id0s2ZDZDdXI5NWVUU21YZVdwK214WjF4d2RDaUE4WWhKL1o0NGhy?=
 =?utf-8?B?RUVBbEZTa2hlSUlpZGdORzI5VTdaT3pKcTdNeXFNWVhTNmdFaXk5M3RZMytr?=
 =?utf-8?B?NThmVXg0clo1U1NyOVZPejVBZDFsOCt6alUxL2kzOENRMlF5NlZjYXdwQWxM?=
 =?utf-8?B?T1JqQ3BQTlRMV1NIOGtHNWp2N1UybEs4Z3ZFeFJBT0x0NTRiUWdObTRxUUZm?=
 =?utf-8?B?RDhzMGYzU3pCeUcyQUk0WkxhWUxaNHFWV3htQ2hIem5qWk9KSGlyT0k5VHB2?=
 =?utf-8?B?eTBCSkd1SVZLdWx0Q3oyNDVRNmdNWEJianVTVWZab3AxdGlpcXdoT0h0T2hZ?=
 =?utf-8?B?WkVabGZWS3pLOVMzSDZqZ3JGbUNadUdETmkxaHdSM21PSEFWZDROWDg5UDZ1?=
 =?utf-8?B?QnNOVTREcGt0dzRwYk55dmh1c1ZxQ085M3NrQlpiMzhSc0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TW9SWkEwTU1sNEVIOXNwNHRiRTE0ZUZDU1BScEtSbTd0WUcvZlZnWUJTRm0w?=
 =?utf-8?B?Ujhia01hT1ZrYWFRNXNtVmlpS1JoakYxMEtKSnp0cWFnbXhNUHRmT2t0RzFt?=
 =?utf-8?B?Wk5iQklLY25RQUNsQjVnQ2VNeWUvVFJ3SCtJZW11MktneVM2ZHp0NXYvSytL?=
 =?utf-8?B?WTFITUtqZ04xS1R5VWVvSnFxVnRDWEZlRGoxaVpCMHZheUg5RFBTbEFkL1pC?=
 =?utf-8?B?M2ZaV1k3RFJJemlLMmdKTC9EeHg4c0FEY2VlcENIYUtIVFdiZnVWUVRlOG5B?=
 =?utf-8?B?bTV0eFJUNSs1bURUc29FcElSYzF1Y1ZNM1o4LzRFakxFMnFmVEJxQkpxSmZR?=
 =?utf-8?B?NWZpUmJlNXBPNzVJY0V6OE5zMUtiK3pnMUYvd1lGYjFPcXJsMVJLL3BqNUVR?=
 =?utf-8?B?WjRvRkc2T0d1QXhyTWRVdHhHWU9DOGtBRDhWTmhFenlSeVJEeHlJanRlS0tp?=
 =?utf-8?B?NS9YZEJHVzZLdThCbkszaEw5THhNeHRXNVZBQ0dSQ2c0SENlVXI1c1NKV29h?=
 =?utf-8?B?KzlOTHRDTzQ3bUNTMmF4SStEVjdrb0ZPdDF2b2lyZExiQWNvMGh5RDFzckRG?=
 =?utf-8?B?N0lENEJNK0lHWno3MlB1eS83TE9ST0U0L0Q1S1l0ZVhlbW9Yc3N2aVExOHAx?=
 =?utf-8?B?SFNtODFpWGJ1bTlMdGViN2pSK1VjZlZHQWdBWGg0OWVlenlWSW1kcFRSVFJN?=
 =?utf-8?B?bWl5OHpPQXNvMG1xK2RQamxQekpHbjAxTEVyRVZoZ2RqaW9FV2VSMEpmbmZV?=
 =?utf-8?B?QW8raFQ1bTV1Uit6WTlsbzFBOXgzODI3RGJCaVhma211TTN0bVVtYzUwN0ZP?=
 =?utf-8?B?Y0JRZ3lxakxmWlhEamVhWW9vS1QyblhVTGJGNlY3czlhNFJjVm1paStHREN0?=
 =?utf-8?B?R2FnWlQ1WmNFazlGcFBXNjRPWXNKeFdPZVdnZHhmTFlIak5HSkwrRXE0VDRF?=
 =?utf-8?B?NzlDZlJqcUt4eDFaQW1ydW5rZFIvcEw5L05qR3YxbzZYditHZzgyUnR5c3NM?=
 =?utf-8?B?VlRmL0tFRzM4MjNsYk5NYzBxT3BTMG8rMUdpTjJUV2N2aW5xTzBJblhYSnY5?=
 =?utf-8?B?dERJdjlPN2dSUVlhb1k5NFRRV0s2cmNHSC9IendqZy9KZ2xHSmJFaFN0WHVx?=
 =?utf-8?B?eW1pYkMvenpDMzlqYXgyNzUvbTFIUjhNaEhoS0t0Y0hiYzBvL1dsU0taU3Bh?=
 =?utf-8?B?ODdVbGN5d252U1VPeW9sNGJVUlhueUtWWVQ4RUNMNER3d2V4UytQMU5xZkpO?=
 =?utf-8?B?cGVDM0RNWk9KbjlDbUIxNDQrRTBweW9MUCtEWWdXWnM0REFXTnpHL3JWNVM3?=
 =?utf-8?B?WllyYmpveDVqNW9iSmIyWTk4LzFGbWF2WVdqenBDZTduOTAxQzlFR2ZIOE9u?=
 =?utf-8?B?eVJyVmV2NEZNdjdmQ2JTTUpmVWNhVXhEK044WVNkckoxVTdaQmFWWFVxZVpp?=
 =?utf-8?B?VEtLNFVHRjFKSXFkTVk1Qk9pT01ybnhmcTBsaDB6M0EzSU40czhuWnB2dGI0?=
 =?utf-8?B?cUdXVjRYam0vN0kxQUhOL1I3akFzWGRPSGt6RStVZk5WdkRUZUxxSnpSU0th?=
 =?utf-8?B?NDNOVzZYSlZ3MHQyYktmcXZobUJqVnhQVU5LU1BmVVYrS1NvYmFGckRMNE92?=
 =?utf-8?B?UGNuZER2NVowWWFzeTNyNlhaMHU4M1JWUzVmM2JBc3pYU1dTTjA3S05xdnNj?=
 =?utf-8?B?TTUxMXFaUTk0NDBocjVnM09EYXFCWkY4djNSQTdFcnFwY1JxOFZnWEFNNmVm?=
 =?utf-8?B?NHc1eHpFaXdHakJGM3BFaDJzSE43VGRkQkx4RWxJbFdxRUhLczJ1L21QUmRQ?=
 =?utf-8?B?ZU13QWlsMm1vODFKb1Qyd3ZmQmtsdnEveUZLaDUyNGY3SGVYSU5CWHExN21S?=
 =?utf-8?B?dFZnUmlMZDFEQVZZNjB5ck1JVTRIQXN3eXp1VGxjM00wNXNsTVNBczBTVG1V?=
 =?utf-8?B?Yk8wVVlxWFU4U1Jrb05COGY5Zm84SjFYbXRLYTBrWTUyMmJuWU1aSTRHSEdG?=
 =?utf-8?B?RFZCaGk2aWpjMmRlbFdYNEdVNXkzb0dzYU9MVzRzMnQwbXR2Nnp5OTFuRXZ1?=
 =?utf-8?B?ekgyWHVqNnNQVGtJMEZHcmd5YktVYjZxVjBqTkd1RTJ3bHpBMDg0cWRkTDRG?=
 =?utf-8?Q?qw6Otu04JDJbpNG1phZ4jXLrl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84cdd3ba-3f0b-4fbe-b4b4-08dd6d45fbd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 15:42:30.1037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tvvw+MHP6C9eXpds1/hjZqX2sZax4eg+96tMZnumlflPUJbEWZevIuWsQG18YWqq6ABHk8BLcU++tJNykes6LFqfhcaCiV5Z0x8rLCLvAZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8385
X-OriginatorOrg: intel.com

IA0KPiBPbiBNb24sIE1hciAyNCwgMjAyNSBhdCAxMjoyNjozOFBNICswMDAwLCBSZXNoZXRvdmEs
IEVsZW5hIHdyb3RlOg0KPiA+DQo+ID4gPiBPbiBGcmksIE1hciAyMSwgMjAyNSBhdCAwMjozNDo0
M1BNICswMjAwLCBFbGVuYSBSZXNoZXRvdmEgd3JvdGU6DQo+ID4gPiA+IFNHWCBhcmNoaXRlY3R1
cmUgaW50cm9kdWNlZCAgYSBuZXcgaW5zdHJ1Y3Rpb24gY2FsbGVkIEVVUERBVEVTVk4gWzFdDQo+
ID4gPiA+IHRvIEljZSBMYWtlLiBJdCBhbGxvd3MgdXBkYXRpbmcgc2VjdXJpdHkgU1ZOIHZlcnNp
b24sIGdpdmVuIHRoYXQgRVBDDQo+ID4gPiA+IGlzIGNvbXBsZXRlbHkgZW1wdHkuIFRoZSBsYXR0
ZXIgaXMgcmVxdWlyZWQgZm9yIHNlY3VyaXR5IHJlYXNvbnMNCj4gPiA+ID4gaW4gb3JkZXIgdG8g
cmVhc29uIHRoYXQgZW5jbGF2ZSBzZWN1cml0eSBwb3N0dXJlIGlzIGFzIHNlY3VyZSBhcyB0aGUN
Cj4gPiA+ID4gc2VjdXJpdHkgU1ZOIHZlcnNpb24gb2YgdGhlIFRDQiB0aGF0IGNyZWF0ZWQgaXQu
DQo+ID4gPiA+DQo+ID4gPiA+IEFkZGl0aW9uYWxseSBpdCBpcyBpbXBvcnRhbnQgdG8gZW5zdXJl
IHRoYXQgd2hpbGUgRU5DTFNbRVVQREFURVNWTl0NCj4gPiA+ID4gcnVucywgbm8gY29uY3VycmVu
dCBwYWdlIGNyZWF0aW9uIGhhcHBlbnMgaW4gRVBDLCBiZWNhdXNlIGl0IG1pZ2h0DQo+ID4gPiA+
IHJlc3VsdCBpbiAjR1AgZGVsaXZlcmVkIHRvIHRoZSBjcmVhdG9yLiBMZWdhY3kgU1cgbWlnaHQg
bm90IGJlIHByZXBhcmVkDQo+ID4gPiA+IHRvIGhhbmRsZSBzdWNoIHVuZXhwZWN0ZWQgI0dQcyBh
bmQgdGhlcmVmb3JlIHRoaXMgcGF0Y2ggaW50cm9kdWNlcw0KPiA+ID4gPiBhIGxvY2tpbmcgbWVj
aGFuaXNtIHRvIGVuc3VyZSBubyBjb25jdXJyZW50IEVQQyBhbGxvY2F0aW9ucyBjYW4NCj4gaGFw
cGVuLg0KPiA+ID4gPg0KPiA+ID4gPiBJdCBpcyBhbHNvIGVuc3VyZWQgdGhhdCBFTkNMU1tFVVBE
QVRFU1ZOXSBpcyBub3QgY2FsbGVkIHdoZW4gcnVubmluZw0KPiA+ID4gPiBpbiBhIFZNIHNpbmNl
IGl0IGRvZXMgbm90IGhhdmUgYSBtZWFuaW5nIGluIHRoaXMgY29udGV4dCAobWljcm9jb2RlDQo+
ID4gPiA+IHVwZGF0ZXMgYXBwbGljYXRpb24gaXMgbGltaXRlZCB0byB0aGUgaG9zdCBPUykgYW5k
IHdpbGwgY3JlYXRlDQo+ID4gPiA+IHVubmVjZXNzYXJ5IGxvYWQuDQo+ID4gPiA+DQo+ID4gPiA+
IFRoZSBpbXBsZW1lbnRhdGlvbiBvZiBFTkNMU1tFVVBEQVRFU1ZOXSBpcyBiYXNlZCBvbiBwcmV2
aW91cw0KPiA+ID4gc3VibWlzaW9uIGluIFsyXQ0KPiA+ID4gPg0KPiA+ID4gPiBbMV0NCj4gaHR0
cHM6Ly9jZHJkdjIuaW50ZWwuY29tL3YxL2RsL2dldENvbnRlbnQvNjQ4NjgyP2V4cGxpY2l0VmVy
c2lvbj10cnVlDQo+ID4gPg0KPiA+ID4gSSBkb24ndCB0aGluayBmb3IgSW50ZWwgb3Bjb2RlcyBh
IGxpbmsgaXMgbmVlZGVkLiBXZSBrbm93IHdoZXJlIHRvIGxvb2sNCj4gPiA+IHRoZW0gdXAuDQo+
ID4NCj4gPiBPaywgSSBjYW4gZHJvcCB0aGlzIHJlZmVyZW5jZS4gSXQgaXMganVzdCBhIHdoaXRl
cGFwZXIgZXhwbGFpbmluZyB0byByZWFkZXJzDQo+ID4gdGhlIGJhY2tncm91bmQgYW5kIG9wZXJh
dGlvbiBvZiBFVVBEQVRFU1ZOLiBJdCBpcyBub3QgcGFydCBvZiBzdGFuZGFyZA0KPiA+IFNETSwg
c28gSSB0aG91Z2h0IEkgd291bGQgcHV0IGEgbGluay4NCj4gPg0KPiA+DQo+ID4gPg0KPiA+ID4g
PiBbMl0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjIwNTIwMTAzOTA0LjEyMTYtMS0N
Cj4gPiA+DQo+IGNhdGh5LnpoYW5nQGludGVsLmNvbS9ULyNtZWRiODllNmE5MTYzMzdiNGY5ZTY4
YzczNmEyOTViYTBhZTk5YWM5MA0KPiA+ID4NCj4gPiA+IExpbms6DQo+ID4NCj4gPiA/ICBOb3Qg
c3VyZSB3aGF0IHlvdSBtZWFuIGJ5IGl0Lg0KPiA+DQo+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBD
by1kZXZlbG9wZWQtYnk6IENhdGh5IFpoYW5nIDxjYXRoeS56aGFuZ0BpbnRlbC5jb20+DQo+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IENhdGh5IFpoYW5nIDxjYXRoeS56aGFuZ0BpbnRlbC5jb20+DQo+
ID4gPiA+IENvLWRldmVsb3BlZC1ieTogRWxlbmEgUmVzaGV0b3ZhIDxlbGVuYS5yZXNoZXRvdmFA
aW50ZWwuY29tPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBFbGVuYSBSZXNoZXRvdmEgPGVsZW5h
LnJlc2hldG92YUBpbnRlbC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgYXJjaC94ODYvaW5j
bHVkZS9hc20vc2d4LmggICAgICB8IDMzICsrKysrKysrKy0tLS0tLS0tDQo+ID4gPiA+ICBhcmNo
L3g4Ni9rZXJuZWwvY3B1L3NneC9lbmNscy5oIHwgIDYgKysrDQo+ID4gPiA+ICBhcmNoL3g4Ni9r
ZXJuZWwvY3B1L3NneC9tYWluLmMgIHwgNjUNCj4gPiA+ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLQ0KPiA+ID4gPiAgYXJjaC94ODYva2VybmVsL2NwdS9zZ3gvc2d4LmggICB8ICAy
ICsNCj4gPiA+ID4gIDQgZmlsZXMgY2hhbmdlZCwgOTAgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRp
b25zKC0pDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9zZ3guaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NneC5oDQo+ID4gPiA+IGluZGV4IDhiYTM5
YmJmNGU5MS4uNWNhZjVjMzFlYmM2IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS9zZ3guaA0KPiA+ID4gPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zZ3guaA0K
PiA+ID4gPiBAQCAtMjYsMjMgKzI2LDI2IEBADQo+ID4gPiA+ICAjZGVmaW5lIFNHWF9DUFVJRF9F
UENfU0VDVElPTgkweDENCj4gPiA+ID4gIC8qIFRoZSBiaXRtYXNrIGZvciB0aGUgRVBDIHNlY3Rp
b24gdHlwZS4gKi8NCj4gPiA+ID4gICNkZWZpbmUgU0dYX0NQVUlEX0VQQ19NQVNLCUdFTk1BU0so
MywgMCkNCj4gPiA+ID4gKy8qIEVVUERBVEVTVk4gcHJlc2VuY2UgaW5kaWNhdGlvbiAqLw0KPiA+
ID4gPiArI2RlZmluZSBTR1hfQ1BVSURfRVVQREFURVNWTglCSVQoMTApDQo+ID4gPiA+DQo+ID4g
PiA+ICBlbnVtIHNneF9lbmNsc19mdW5jdGlvbiB7DQo+ID4gPiA+IC0JRUNSRUFURQk9IDB4MDAs
DQo+ID4gPiA+IC0JRUFERAk9IDB4MDEsDQo+ID4gPiA+IC0JRUlOSVQJPSAweDAyLA0KPiA+ID4g
PiAtCUVSRU1PVkUJPSAweDAzLA0KPiA+ID4gPiAtCUVER0JSRAk9IDB4MDQsDQo+ID4gPiA+IC0J
RURHQldSCT0gMHgwNSwNCj4gPiA+ID4gLQlFRVhURU5ECT0gMHgwNiwNCj4gPiA+ID4gLQlFTERV
CT0gMHgwOCwNCj4gPiA+ID4gLQlFQkxPQ0sJPSAweDA5LA0KPiA+ID4gPiAtCUVQQQk9IDB4MEEs
DQo+ID4gPiA+IC0JRVdCCT0gMHgwQiwNCj4gPiA+ID4gLQlFVFJBQ0sJPSAweDBDLA0KPiA+ID4g
PiAtCUVBVUcJPSAweDBELA0KPiA+ID4gPiAtCUVNT0RQUgk9IDB4MEUsDQo+ID4gPiA+IC0JRU1P
RFQJPSAweDBGLA0KPiA+ID4gPiArCUVDUkVBVEUJCT0gMHgwMCwNCj4gPiA+ID4gKwlFQURECQk9
IDB4MDEsDQo+ID4gPiA+ICsJRUlOSVQJCT0gMHgwMiwNCj4gPiA+ID4gKwlFUkVNT1ZFCQk9IDB4
MDMsDQo+ID4gPiA+ICsJRURHQlJECQk9IDB4MDQsDQo+ID4gPiA+ICsJRURHQldSCQk9IDB4MDUs
DQo+ID4gPiA+ICsJRUVYVEVORAkJPSAweDA2LA0KPiA+ID4gPiArCUVMRFUJCT0gMHgwOCwNCj4g
PiA+ID4gKwlFQkxPQ0sJCT0gMHgwOSwNCj4gPiA+ID4gKwlFUEEJCT0gMHgwQSwNCj4gPiA+ID4g
KwlFV0IJCT0gMHgwQiwNCj4gPiA+ID4gKwlFVFJBQ0sJCT0gMHgwQywNCj4gPiA+ID4gKwlFQVVH
CQk9IDB4MEQsDQo+ID4gPiA+ICsJRU1PRFBSCQk9IDB4MEUsDQo+ID4gPiA+ICsJRU1PRFQJCT0g
MHgwRiwNCj4gPiA+ID4gKwlFVVBEQVRFU1ZOCT0gMHgxOCwNCj4gPiA+ID4gIH07DQo+ID4gPiA+
DQo+ID4gPiA+ICAvKioNCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUv
c2d4L2VuY2xzLmgNCj4gPiA+IGIvYXJjaC94ODYva2VybmVsL2NwdS9zZ3gvZW5jbHMuaA0KPiA+
ID4gPiBpbmRleCA5OTAwNGIwMmUyZWQuLjNkODNjNzZkYzkxZiAxMDA2NDQNCj4gPiA+ID4gLS0t
IGEvYXJjaC94ODYva2VybmVsL2NwdS9zZ3gvZW5jbHMuaA0KPiA+ID4gPiArKysgYi9hcmNoL3g4
Ni9rZXJuZWwvY3B1L3NneC9lbmNscy5oDQo+ID4gPiA+IEBAIC0yMzMsNCArMjMzLDEwIEBAIHN0
YXRpYyBpbmxpbmUgaW50IF9fZWF1ZyhzdHJ1Y3Qgc2d4X3BhZ2VpbmZvDQo+ICpwZ2luZm8sDQo+
ID4gPiB2b2lkICphZGRyKQ0KPiA+ID4gPiAgCXJldHVybiBfX2VuY2xzXzIoRUFVRywgcGdpbmZv
LCBhZGRyKTsNCj4gPiA+ID4gIH0NCj4gPiA+ID4NCj4gPiA+ID4gKy8qIFVwZGF0ZSBDUFVTVk4g
YXQgcnVudGltZS4gKi8NCj4gPiA+ID4gK3N0YXRpYyBpbmxpbmUgaW50IF9fZXVwZGF0ZXN2bih2
b2lkKQ0KPiA+ID4gPiArew0KPiA+ID4gPiArCXJldHVybiBfX2VuY2xzX3JldF8xKEVVUERBVEVT
Vk4sICIiKTsNCj4gPiA+ID4gK30NCj4gPiA+ID4gKw0KPiA+ID4gPiAgI2VuZGlmIC8qIF9YODZf
RU5DTFNfSCAqLw0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9zZ3gv
bWFpbi5jDQo+ID4gPiBiL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L21haW4uYw0KPiA+ID4gPiBp
bmRleCBiNjFkM2JhZDA0NDYuLjY5ODkyMTIyOTA5NCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvYXJj
aC94ODYva2VybmVsL2NwdS9zZ3gvbWFpbi5jDQo+ID4gPiA+ICsrKyBiL2FyY2gveDg2L2tlcm5l
bC9jcHUvc2d4L21haW4uYw0KPiA+ID4gPiBAQCAtMzIsNiArMzIsMTEgQEAgc3RhdGljIERFRklO
RV9YQVJSQVkoc2d4X2VwY19hZGRyZXNzX3NwYWNlKTsNCj4gPiA+ID4gIHN0YXRpYyBMSVNUX0hF
QUQoc2d4X2FjdGl2ZV9wYWdlX2xpc3QpOw0KPiA+ID4gPiAgc3RhdGljIERFRklORV9TUElOTE9D
SyhzZ3hfcmVjbGFpbWVyX2xvY2spOw0KPiA+ID4gPg0KPiA+ID4gPiArLyogVGhpcyBsb2NrIGlz
IGhlbGQgdG8gcHJldmVudCBuZXcgRVBDIHBhZ2VzIGZyb20gYmVpbmcgY3JlYXRlZA0KPiA+ID4g
PiArICogZHVyaW5nIHRoZSBleGVjdXRpb24gb2YgRU5DTFNbRVVQREFURVNWTl0uDQo+ID4gPiA+
ICsgKi8NCj4gPiA+ID4gK3N0YXRpYyBERUZJTkVfU1BJTkxPQ0soc2d4X2VwY19ldXBkYXRlc3Zu
X2xvY2spOw0KPiA+ID4gPiArDQo+ID4gPiA+ICBzdGF0aWMgYXRvbWljX2xvbmdfdCBzZ3hfbnJf
dXNlZF9wYWdlcyA9IEFUT01JQ19MT05HX0lOSVQoMCk7DQo+ID4gPiA+ICBzdGF0aWMgdW5zaWdu
ZWQgbG9uZyBzZ3hfbnJfdG90YWxfcGFnZXM7DQo+ID4gPiA+DQo+ID4gPiA+IEBAIC00NTcsNyAr
NDYyLDE3IEBAIHN0YXRpYyBzdHJ1Y3Qgc2d4X2VwY19wYWdlDQo+ID4gPiAqX19zZ3hfYWxsb2Nf
ZXBjX3BhZ2VfZnJvbV9ub2RlKGludCBuaWQpDQo+ID4gPiA+ICAJcGFnZS0+ZmxhZ3MgPSAwOw0K
PiA+ID4gPg0KPiA+ID4gPiAgCXNwaW5fdW5sb2NrKCZub2RlLT5sb2NrKTsNCj4gPiA+ID4gLQlh
dG9taWNfbG9uZ19pbmMoJnNneF9ucl91c2VkX3BhZ2VzKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiAr
CWlmICghYXRvbWljX2xvbmdfaW5jX25vdF96ZXJvKCZzZ3hfbnJfdXNlZF9wYWdlcykpIHsNCj4g
PiA+ID4gKwkJc3Bpbl9sb2NrKCZzZ3hfZXBjX2V1cGRhdGVzdm5fbG9jayk7DQo+ID4gPiA+ICsJ
CS8qIE9ubHkgY2FsbCBzZ3hfdXBkYXRlc3ZuKCkgb25jZSB0aGUgZmlyc3QgZW5jbGF2ZSdzDQo+
ID4gPiA+ICsJCSAqIHBhZ2UgaXMgYWxsb2NhdGVkIGZyb20gRVBDDQo+ID4gPiA+ICsJCSAqLw0K
PiA+ID4gPiArCQlpZiAoYXRvbWljX2xvbmdfcmVhZCgmc2d4X25yX3VzZWRfcGFnZXMpID09IDAp
DQo+ID4gPiA+ICsJCQlzZ3hfdXBkYXRlc3ZuKCk7DQo+ID4gPiA+ICsJCWF0b21pY19sb25nX2lu
Yygmc2d4X25yX3VzZWRfcGFnZXMpOw0KPiA+ID4gPiArCQlzcGluX3VubG9jaygmc2d4X2VwY19l
dXBkYXRlc3ZuX2xvY2spOw0KPiA+ID4gPiArCX0NCj4gPiA+ID4NCj4gPiA+ID4gIAlyZXR1cm4g
cGFnZTsNCj4gPiA+ID4gIH0NCj4gPiA+ID4gQEAgLTk3MCwzICs5ODUsNTEgQEAgc3RhdGljIGlu
dCBfX2luaXQgc2d4X2luaXQodm9pZCkNCj4gPiA+ID4gIH0NCj4gPiA+ID4NCj4gPiA+ID4gIGRl
dmljZV9pbml0Y2FsbChzZ3hfaW5pdCk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKy8qKg0KPiA+ID4g
PiArICogc2d4X3VwZGF0ZXN2bigpIC0gSXNzdWUgRU5DTFNbRVVQREFURVNWTl0NCj4gPiA+ID4g
KyAqIElmIEVQQyBpcyByZWFkeSwgdGhpcyBpbnN0cnVjdGlvbiB3aWxsIHVwZGF0ZSBDUFVTVk4g
dG8gdGhlIGN1cnJlbnRseQ0KPiA+ID4gPiArICogbG9hZGVkIG1pY3JvY29kZSB1cGRhdGUgU1ZO
IGFuZCBnZW5lcmF0ZSBuZXcgY3J5cHRvZ3JhcGhpYw0KPiBhc3NldHMuDQo+ID4gPiA+ICsgKi8N
Cj4gPiA+ID4gK3ZvaWQgc2d4X3VwZGF0ZXN2bih2b2lkKQ0KPiA+ID4gPiArew0KPiA+ID4gPiAr
CWludCByZXQ7DQo+ID4gPiA+ICsJaW50IHJldHJ5ID0gMTA7DQo+ID4gPg0KPiA+ID4gUmV2ZXJz
ZSBkZWNsYXJhdGlvbiBvcmRlci4NCj4gPg0KPiA+IFN1cmUsIHdpbGwgZml4Lg0KPiA+DQo+ID4g
Pg0KPiA+ID4gPiArDQo+ID4gPiA+ICsJbG9ja2RlcF9hc3NlcnRfaGVsZCgmc2d4X2VwY19ldXBk
YXRlc3ZuX2xvY2spOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJLyogRG8gbm90IGV4ZWN1dGUgRVVQ
REFURVNWTiBpZiBpbnN0cnVjdGlvbiBpcyB1bmF2YWxpYmxlIG9yIHJ1bm5pbmcNCj4gPiA+IGlu
IGEgVk0gKi8NCj4gPiA+ID4gKwlpZiAoIShjcHVpZF9lYXgoU0dYX0NQVUlEKSAmIFNHWF9DUFVJ
RF9FVVBEQVRFU1ZOKSB8fA0KPiA+ID4gPiArCQkgICAgYm9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJF
X0hZUEVSVklTT1IpKQ0KPiA+ID4gPiArCQlyZXR1cm47DQo+ID4gPg0KPiA+ID4NCj4gPiA+IAlp
ZiAoIShjcHVpZF9lYXgoU0dYX0NQVUlEKSAmIFNHWF9DUFVJRF9FVVBEQVRFU1ZOKSkNCj4gPiA+
IAkJcmV0dXJuOw0KPiA+ID4NCj4gPiA+IAkvKiAuLi4gKi8NCj4gPiA+IAlpZiAoYm9vdF9jcHVf
aGFzKFg4Nl9GRUFUVVJFX0hZUEVSVklTT1IpKQ0KPiA+ID4gCQlyZXR1cm47DQo+ID4gPg0KPiA+
ID4gVGhlIGZpcnN0IGNoZWNrIHJlYWxseSBkb2VzIG5vdCBuZWVkIGEgY29tbWVudC4gVGhlIHNl
Y29uZCB3b3VsZCBiZW5lZml0DQo+ID4gPiBmcm9tIGV4cGxhaW5pbmcgd2h5IGJhaWwgb3V0IGlu
c2lkZSBhIFZNLg0KPiA+DQo+ID4gU3VyZSwgSSBjYW4gY2hhbmdlLiBUaGUgcmVhc29uIHdoeSB3
ZSBkb250IHdhbnQgdGhlIGV4ZWN1dGlvbiBpbiBhIFZNIGlzDQo+IGV4cGxhaW5lZA0KPiA+IGlu
IHRoZSBjb21taXQgbWVzc2FnZSwgSSBjYW4gZHVwbGljYXRlIGl0IGluIHRoZSBjb2RlIGNvbW1l
bnQgYWxzby4NCj4gPg0KPiA+DQo+ID4gPg0KPiA+ID4NCj4gPiA+DQo+ID4gPg0KPiA+ID4NCj4g
PiA+ID4gKw0KPiA+ID4gPiArCWRvIHsNCj4gPiA+ID4gKwkJcmV0ID0gX19ldXBkYXRlc3ZuKCk7
DQo+ID4gPiA+ICsJCWlmIChyZXQgIT0gU0dYX0lOU1VGRklDSUVOVF9FTlRST1BZKQ0KPiA+ID4g
PiArCQkJYnJlYWs7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwl9IHdoaWxlICgtLXJldHJ5KTsNCj4g
PiA+ID4gKw0KPiA+ID4gPiArCXN3aXRjaCAocmV0KSB7DQo+ID4gPiA+ICsJY2FzZSAwOg0KPiA+
ID4gPiArCQlwcl9kZWJ1ZygiRVVQREFURVNWTiB3YXMgc3VjY2Vzc2Z1bCFcbiIpOw0KPiA+ID4g
PiArCQlicmVhazsNCj4gDQo+IFRoaXMgaXMgYXQgbGVhc3QgZGVmaW5pdGUgcmVtb3ZhbC4gV2Ug
ZG9uJ3QgbG9nIGZvciB6ZXJvIGNvZGVzLg0KDQpPay4gDQoNCj4gDQo+ID4gPiA+ICsJY2FzZSBT
R1hfTk9fVVBEQVRFOg0KPiA+ID4gPiArCQlwcl9kZWJ1ZygiRVVQREFURVNWTiB3YXMgc3VjY2Vz
c2Z1bCwgYnV0IENQVVNWTiB3YXMgbm90DQo+ID4gPiB1cGRhdGVkLCAiDQo+ID4gPiA+ICsJCQki
YmVjYXVzZSBjdXJyZW50IFNWTiB3YXMgbm90IG5ld2VyIHRoYW4NCj4gPiA+IENQVVNWTi5cbiIp
Ow0KPiA+ID4gPiArCQlicmVhazsNCj4gPiA+ID4gKwljYXNlIFNHWF9FUENfTk9UX1JFQURZOg0K
PiA+ID4gPiArCQlwcl9kZWJ1ZygiRVBDIGlzIG5vdCByZWFkeSBmb3IgU1ZOIHVwZGF0ZS4iKTsN
Cj4gPiA+ID4gKwkJYnJlYWs7DQo+ID4gPiA+ICsJY2FzZSBTR1hfSU5TVUZGSUNJRU5UX0VOVFJP
UFk6DQo+ID4gPiA+ICsJCXByX2RlYnVnKCJDUFVTVk4gdXBkYXRlIGlzIGZhaWxlZCBkdWUgdG8g
SW5zdWZmaWNpZW50DQo+ID4gPiBlbnRyb3B5IGluIFJORywgIg0KPiA+ID4gPiArCQkJInBsZWFz
ZSB0cnkgaXQgbGF0ZXIuXG4iKTsNCj4gPiA+ID4gKwkJYnJlYWs7DQo+ID4gPiA+ICsJY2FzZSBT
R1hfRVBDX1BBR0VfQ09ORkxJQ1Q6DQo+ID4gPiA+ICsJCXByX2RlYnVnKCJDUFVTVk4gdXBkYXRl
IGlzIGZhaWxlZCBkdWUgdG8gY29uY3VycmVuY3kNCj4gPiA+IHZpb2xhdGlvbiwgcGxlYXNlICIN
Cj4gPiA+ID4gKwkJCSJzdG9wIHJ1bm5pbmcgYW55IG90aGVyIEVOQ0xTIGxlYWYgYW5kIHRyeSBp
dA0KPiA+ID4gbGF0ZXIuXG4iKTsNCj4gPiA+ID4gKwkJYnJlYWs7DQo+ID4gPiA+ICsJZGVmYXVs
dDoNCj4gPiA+ID4gKwkJYnJlYWs7DQo+ID4gPg0KPiA+ID4gUmVtb3ZlIHByX2RlYnVnKCkgc3Rh
dGVtZW50cy4NCj4gPg0KPiA+IFRoaXMgSSBhbSBub3Qgc3VyZSBpdCBpcyBnb29kIGlkZWEuIEkg
dGhpbmsgaXQgd291bGQgYmUgdXNlZnVsIGZvciBzeXN0ZW0NCj4gPiBhZG1pbnMgdG8gaGF2ZSBh
IHdheSB0byBzZWUgdGhhdCB1cGRhdGUgZWl0aGVyIGhhcHBlbmVkIG9yIG5vdC4NCj4gPiBJdCBp
cyB0cnVlIHRoYXQgeW91IGNhbiBmaW5kIHRoaXMgb3V0IGJ5IHJlcXVlc3RpbmcgYSBuZXcgU0dY
IGF0dGVzdGF0aW9uDQo+ID4gcXVvdGUgKGFuZCBzZWUgaWYgbmV3ZXIgU1ZOIGlzIHVzZWQpLCBi
dXQgaXQgaXMgbm90IHRoZSBmYXN0ZXIgd2F5Lg0KPiANCj4gTWF5YmUgcHJfZGVidWcoKSBpcyB0
aGVtIHdyb25nIGxldmVsIGlmIHRoZXkgYXJlIG1lYW50IGZvciBzeXNhZG1pbnM/DQo+IA0KPiBJ
IG1lYW4gdGhlc2Ugc2hvdWxkIG5vdCBoYXBwZW4gaW4gbm9ybWFsIGJlaGF2aW9yIGxpa2UgZXZl
cj8gQXMNCj4gcHJfZGVidWcoKSBJIGRvbid0IHJlYWxseSBncmFiIHRoaXMuDQoNClNHWF9OT19V
UERBVEUgd2lsbCBhYnNvbHV0ZWx5IGhhcHBlbiBub3JtYWxseSBhbGwgdGhlIHRpbWUuIA0KU2lu
Y2UgRVVQREFURVNWTiBpcyBleGVjdXRlZCBldmVyeSB0aW1lIEVQQyBpcyBlbXB0eSwgdGhpcyBp
cyB0aGUNCm1vc3QgY29tbW9uIGNvZGUgeW91IHdpbGwgZ2V0IGJhY2sgKGJlY2F1c2UgbWljcm9j
b2RlIHVwZGF0ZXMgYXJlIHJhcmUpLiANCk90aGVycyB5ZXMsIHRoYXQgd291bGQgaW5kaWNhdGUg
c29tZSBlcnJvciBjb25kaXRpb24uIA0KU28sIHdoYXQgaXMgdGhlIHByX2xldmVsIHRoYXQgeW91
IHdvdWxkIHN1Z2dlc3Q/IA0KDQo+IA0KPiA+DQo+ID4NCj4gPg0KPiA+ID4NCj4gPiA+ID4gKwl9
DQo+ID4gPiA+ICt9DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Nn
eC9zZ3guaA0KPiBiL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L3NneC5oDQo+ID4gPiA+IGluZGV4
IGQyZGFkMjEyNTlhOC4uOTJjOWUyMjZmMWI1IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9hcmNoL3g4
Ni9rZXJuZWwvY3B1L3NneC9zZ3guaA0KPiA+ID4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1
L3NneC9zZ3guaA0KPiA+ID4gPiBAQCAtMTA0LDQgKzEwNCw2IEBAIHN0YXRpYyBpbmxpbmUgaW50
IF9faW5pdCBzZ3hfdmVwY19pbml0KHZvaWQpDQo+ID4gPiA+DQo+ID4gPiA+ICB2b2lkIHNneF91
cGRhdGVfbGVwdWJrZXloYXNoKHU2NCAqbGVwdWJrZXloYXNoKTsNCj4gPiA+ID4NCj4gPiA+DQo+
ID4gPiBJIGRvbid0IHRoaW5rIHdlIG5lZWQgYSBuZXdsaW5lIGluLWJldHdlZW4uDQo+ID4NCj4g
PiBTdXJlLCB3aWxsIGZpeC4NCj4gPg0KPiA+IFRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIg
cHJvbXB0IHJldmlldyBKYXJra28hDQo+IA0KPiBOUCwgZGVzcGl0ZSBhbGwgdGhlIGNvbXBsYWlu
cyB0aGlzIGFyZSByZWFsbHkganVzdCBtaW5vciBkZXRhaWxzDQo+IHRoYXQgd2UgbmVlZCB0byBu
YWlsIDotKSBJJ20gc3VyZSB3ZSBnZXQgdGhlbSByaWdodCB3aXRoaW4gcm91bmQNCj4gb3IgdHdv
Li4uDQoNClN1cmUsIGhhcHB5IHRvIGRvIHRoZSBuYWlsaW5nICkpDQoNCkJlc3QgUmVnYXJkcywN
CkVsZW5hDQo=

