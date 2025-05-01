Return-Path: <linux-kernel+bounces-628939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85181AA64E5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 22:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17394C545F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 20:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C5A25484D;
	Thu,  1 May 2025 20:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X24Xi6Qe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEE4253F1B;
	Thu,  1 May 2025 20:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746132435; cv=fail; b=kQWeRP4rf2xP030VdaM04b1EHANLPzCn/vOWD91uvT603UsaG2shv0P7+t0F8Xf/ROrgMlzwtGAunfeHQsrrICL2ot29laurHgSCe0taXxXTxogZhZCvbyOP7xzKmNW5k18sqdy2pGXgh7i1bqvlh+BcWI/BNtYbpSGMmGqrtFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746132435; c=relaxed/simple;
	bh=wtFUdGg+/HXwmjzIhju6ds/K8IxMGPZjK/tWQJ/EcyE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hu1JNQLPZlSFAZtXPHEqAPRlX/TwqDI1Rxk54RH8kSiSUhkso+eucx+kp8UfsQiU+UZZuvNaLpgcrHmkk3PUc9rrzSgiWkdOaSV0tl3YruDQiVNhso+fVASTx/+w8H+UYJwsxkJ8jUpf0eP5sdYXckIHU3YTofbNfDmDTFqK2V0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X24Xi6Qe; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746132434; x=1777668434;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wtFUdGg+/HXwmjzIhju6ds/K8IxMGPZjK/tWQJ/EcyE=;
  b=X24Xi6QerIGEIzvQBC6OT99NIDw320WAE+OKU16ifVTqTuQu5qc0ym+T
   bXzlsPO2xC1gHmXBmUeF5Z86xSHjR8/6K11DKsSPegLeM2EcsFk9Eeuch
   VMKXaYSPJX/B7HrNmJXLpAwWCyxKWnpbQpoWBr92ZbdMfYCsM1dR2UqqR
   nSCyNcJl0YkBgWQknBTr0XaWwaPTxCkOWZtDxraPQBaQ046X3gGxiQSps
   /rRFYsqUHpatOat5bdsWSRvOUwEYSoJJEfJGI9UknxvUbuvNntr0B1ecF
   Iu/VFjF/eS0Jx12XjWSzZC3Zbeimg7zeUYCezAxKWeXLCFxvgHrlDtfPm
   Q==;
X-CSE-ConnectionGUID: p3j6bPvtQraQ2R2jqqecOQ==
X-CSE-MsgGUID: u/jehuD9RNCJbvqun52unQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="47957476"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="47957476"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 13:47:13 -0700
X-CSE-ConnectionGUID: I2WcR41eR9y+NVnrUt18kQ==
X-CSE-MsgGUID: SdGclzKMTTCNz04RfivABA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="134374703"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 13:47:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 13:47:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 1 May 2025 13:47:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 1 May 2025 13:47:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJrZBJlYIATUQR/I903ZF5z/0ZG+s0Ak1MzoW0rL5hcU5c5wTOtEQJhavkTX4tIGM6XXZ3npjUuM+uJ/IiMG3AMDUh6K23rLOB3FUxJCvPdeOOFpxVrSlSP7yLidLKFXuKn7kVAXzctypWeQ8kS1eNp8MUumlujrmyu1mNHmBb7nSvhJTErgyzw+bMjJmT1+sySQNiKrm9btD17tYVyBFW2itLLGwSDj5misY+Mm9w8bO2LyTuZqK7A9uzSbWbpZFjAvvIhtjklxw6Llph1yLGGLLFnirnbqnpdVCLy/zcCipATqdZOXW6wqm/PrRZX1Q9/pN2pfMv35iQfDEYIhyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtFUdGg+/HXwmjzIhju6ds/K8IxMGPZjK/tWQJ/EcyE=;
 b=JJYWw9Ftm9nBFCMIWRNj6og2fuUP/LNcNAESpqzqpKaSEJv6tQVy2dQJ7QcKGwh5A8JrxiIgE1HKo0CN/wMpXIylRr/TUu5JKfSHGFFF7lWGP2hJo7rkwvn2K2tsDrQyy8+2kQuCY6CXC7DvS3/Ry+lFIFTXwZ59sSswU8LLBbn0Naubi4r8ODlix6s7RhOBKN+RdpK8Q0YA2rdZxq05iC0MjNLvIPqo6wVItN1244DMSQU9OEjuHI3aR5VmHLmbekFknRCjFY57Rou4x4R5nO/zRlG2Xk8BvKdTG+BT/j8fyfH5zQidOFELN9B2gUbMIk5zckHXH92qrL0YIgui4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by SN7PR11MB6971.namprd11.prod.outlook.com (2603:10b6:806:2ab::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Thu, 1 May
 2025 20:46:28 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%3]) with mapi id 15.20.8699.019; Thu, 1 May 2025
 20:46:28 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "irogers@google.com" <irogers@google.com>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org"
	<acme@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH] perf top: populate PMU capabilities data in perf_env
Thread-Topic: [PATCH] perf top: populate PMU capabilities data in perf_env
Thread-Index: AQHbusi8bCHGoKc1VUKR+vojmANVi7O+MekAgAAMuwA=
Date: Thu, 1 May 2025 20:46:27 +0000
Message-ID: <6732ac7aad986d682c6a36db5d435b113c7527d9.camel@intel.com>
References: <20250501184143.873536-1-thomas.falcon@intel.com>
	 <CAP-5=fXorDgm-oJS9kC6cxCEvS9-Gz5Uh_5V4MtzCYV3pXAxCA@mail.gmail.com>
In-Reply-To: <CAP-5=fXorDgm-oJS9kC6cxCEvS9-Gz5Uh_5V4MtzCYV3pXAxCA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|SN7PR11MB6971:EE_
x-ms-office365-filtering-correlation-id: ccb9219d-5901-4e6e-41b4-08dd88f13eee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|10070799003|7416014|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?aEcwdE1ZS1JhL3FhbUhKTWswTzF3Q3dRWjVHRmtIMGFoU0hkeHRqdEdIWkg3?=
 =?utf-8?B?NUppQjhpTEU0QlFzcnNRTlRMQ0dDWmNOc3NUbVljOTBYbVk1cmJVNnZhQUp4?=
 =?utf-8?B?clEraWhWUTE5bDZkZFVsQmdTMkZ5NVl2UWw5QkZnOVFEWGExbk96SEFuNmcw?=
 =?utf-8?B?bVRWUXd2KzJxZlIwbkpJWDVJZDFISmdSN3V4QTViUG5FWUFuNUVvUm5YV2Ev?=
 =?utf-8?B?QWQ2cjFIUzJwcDZyQmVMM1ZrY0hZNnA5Z1ZPY08rTUNHVWRKc1RPWEFJbmJH?=
 =?utf-8?B?SmV2OFJSYUdiNUtEc2pHRiswWDYrcWRaY2xEUjRVcVJweXVYTEpnMHBjdVpQ?=
 =?utf-8?B?Mm85SUdJcmxlZmxiUzc0d0lxN0VJQjVxb25WYW1Ra3NEWU1sdVBoV1N6aVNK?=
 =?utf-8?B?ZlhVamlqcXc1UlZ0Q2thQk12SWR1dzU4ZXNKd08vcmlxcGtuV0xoQlZqUXJ1?=
 =?utf-8?B?YllCbWF6NnM3ZWtmQlZjMjlBZUVsS3RvRlhkVTNJNU9jSlNHaDl3T1UrNEFQ?=
 =?utf-8?B?VXBmSUpjNFNrd2xaVUJHTmpROUJJMGZyS3VaMEx0cllHTC9SVVo1azBOTmc0?=
 =?utf-8?B?ajd1aVpGVHlCN0o3cTNqQmYrTkFVTFZpWUFTaHhoYjA5cXhXZ2FsZUZvS3Yx?=
 =?utf-8?B?QzlkNlpJZzArRXNuT1hRK0xmdkE3b3cwVGowV3FrbGtjUVBZdzhBZzJKYklD?=
 =?utf-8?B?aU1Tc3VrVVZIbUdrUlRmcVkxOTc5MG5IYUNoaXp6a3hRWTJ1QkZtVklwYmpT?=
 =?utf-8?B?Y1hJMnZUeDdxb0NVZmV5MGgwdWc5ZVBzOTNtVEJoQ0dKR3MzbDV2VjYrZUww?=
 =?utf-8?B?bEh5ZDVBQ0JmR1dZclcrR2ZsUlhvN21CWC9EMFpObmk2TXc0VUd2a1E3WjVv?=
 =?utf-8?B?S0FEUkQvT2tpdkxZTjF6MkxKSll5aTdXZXpQSmJvY0p6SVZDYkNaMjgrY0pm?=
 =?utf-8?B?clVoNHN3cFB6dTIwWXV3WXcvbHA4QWZnNkNjZ1VUWlJTdHJNNFdQb0s4dUJY?=
 =?utf-8?B?MTBFN045ZHh6V0RlWUlrSUhyanZneFdjUm1Zd25QMW43WDVWS1BGalJObUN6?=
 =?utf-8?B?MXdlYjQ2VlFodlgrSGd4clJNOGF2eDJnUFpwYzh3Q0VhSHJEcXRtajg3bVdI?=
 =?utf-8?B?QXBpeG9tVFI3VXl2LzlLK0kzYnJZN1lpZ0JNRXAvVThoeC8rSGpqRkJhRGgy?=
 =?utf-8?B?WXl4WEt1ZWRGazl1bitwVnQwbWkvdFB4YmRCdVNMcDE0cDdQMHYyMURxWXM4?=
 =?utf-8?B?TjVKdHdVTFZYOHc2eWRGRUU0bTcrU1NJUUJjZk5GUFJEYWZYakxUaGdQOVA1?=
 =?utf-8?B?VUgxSEtLNUhObEJwL1ZnQ3Q4RU5yUWhma3ZqOFB4dS9VaWVObXFZVGtxQlhH?=
 =?utf-8?B?SEJGN1h0YngyUmlvbFR2bDlZSnhuaG04eGJ6ZEg1blJBOGJFRHd1OU1icHVm?=
 =?utf-8?B?aEFTb3pBWTF5L08xZXNJS2NWZkhwdlBQdk50UmwzdGJ5NExYYkROaFZLSmdM?=
 =?utf-8?B?WjYwT0tQVllqcWZPSjJJUHJacXppeFo4a2hlVDNKVzN0cm9hMlVLdCs0KzF3?=
 =?utf-8?B?TTgyR1NOSUhGSVJaTElEL3Z0eHBwR0ZoV2ZFTHdFZzc3andrcGhzazBSZGQr?=
 =?utf-8?B?MGphL20wcDZ2NUFoSUlzNlg4Z2VsSjdVb0UwVTBsL3M2Ni9JTjMwcEJWNW9Z?=
 =?utf-8?B?UDBJOVdTTmJHRG85TlNJWDVqblhuY3kvVjJwME10QkJHa1RVbGorbGFKSFV6?=
 =?utf-8?B?LzhjZGxBamgveXhhN2hPY0xhZXpGNVdsanNUWUxhZGlUbDFVakZINE5yRDNJ?=
 =?utf-8?B?UXBKZ2pMWjJFU1hlbzhDY09yekVSOVZNRzl5UWhLQ1BpK3A2STcwTGc4UTlC?=
 =?utf-8?B?Vnp4Nm1hUDBaNXpUSlhRMFlaZTdoeENQYXRqc0NtU1QvaEJZeklaYitYTFNl?=
 =?utf-8?B?Y09XL29aSi9kYVpodldyb0lEb1RHa0dLaXhLcnFBV1J3SkhLVjhkZU1VdElC?=
 =?utf-8?Q?h9343ueZdBEQDJQnmkY+wxIMWyQiRE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(7416014)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHRjNG83S25sVWJoYzNsemk3WmY5bGRvWUNJS2VWemJCdWNJUldvcEM4eUM1?=
 =?utf-8?B?NFpDbFcxa0luT0RYbVJ5bFoycEx6d3Z2RE4ramUzYk05dWt2djN4RFRtSHV6?=
 =?utf-8?B?SGYxSko2N3BkK3BRVi93UTE1bjNoNWtXeDZhZHdxUUdxajgwY2U1ZUpXVTBJ?=
 =?utf-8?B?Tnp6NkNIZjRuNkpTekZFdVQrMHB3T0tDQTFoOW1xUzJWbGpia3MvRC8vai9l?=
 =?utf-8?B?K1o4SWhvYWZwdWhLV0xDT1VTam5KYUtra1gwRHJhc0VpNTJyU2VJZ25JS0RI?=
 =?utf-8?B?WFBCMG1zT3I0bjJhUzRVTk9KQitHMVlBTjVnSTgxelVtR3pobUVMVnhYaWhV?=
 =?utf-8?B?L0ROaHFIUXN4d0tUeGl5T1FBVEdVb2lHZk0yaHFvbCtWWmJac05LVnNCZE1k?=
 =?utf-8?B?QlBSWmpnK2I1SzQyM0dUa1NjdnpqaDkwcG9oaHp3QUM4NnNlM0RiMHowL3VV?=
 =?utf-8?B?VTRZYlgrL2pTWFVCRGVVOHVNcGVjUFoyT0Yvd0hVdTdBdWg0N0FxVDNEaGJV?=
 =?utf-8?B?SzY1YzZPbnJqOGRhZklkUmQxS2ZIOXo3b0dQM3NpL2tBaFN1clNCNjJFeXNW?=
 =?utf-8?B?M1p1Rk5sWGZrVkpocHc2UGdXWmYzUjdYTURraEZPcFFGalg4eno5YjdlWUR2?=
 =?utf-8?B?WVRoTEVYQlgrakNORzdBZy9haGp6ZDJKdlBoUSs4VlJSM3k5THpQWUhvY2Ru?=
 =?utf-8?B?V0cvTlUyTFVwUDdYaFdxZkhNVnplaWFBRWoxRENpZUUwc2VyU3FGZmRhMFkx?=
 =?utf-8?B?WEN3cDJVM1VCTjFzVzlYNm1PNFZFazlCZmN6cndWVkNVMGtoc1hIR2pMWGF5?=
 =?utf-8?B?S2dRZjNtd1pQMVlGcFBNbjFMVFNreW1EdVNacjRjRTV3YzBjUFFWQ1U5RGNM?=
 =?utf-8?B?cEdjQjl6dEZTMGp5eHZsWVRFdzFJL1hZTWpDMEFzSEhIWHBxMXAxTVhybVQx?=
 =?utf-8?B?QzcraWF5QUEzdks4M0JzZDlkTWYrczBrOExOZzg4ZnNGVGFYNHEzZGJMc0lO?=
 =?utf-8?B?N1ZYazVhQ0ozclpQV3pMbjlKYWpjZCtOYkl6M0pkZDFwb0JiV2c2UkV2WVEv?=
 =?utf-8?B?US9qZjBoTjl4K0s3Rk1wVVpaM3RlL01sQ211UmFDcms1VWk1ZDZaTk9tc1Q5?=
 =?utf-8?B?RkRtelptY3hicmdWRW5NSVg1bXd1YU9zWUxsdmtHN3BiMmZUYlFiemFWMmdJ?=
 =?utf-8?B?V0lTYU5iS0J5MXFUaHdpMGY5NTg5bS9JT2Y0TEpGcmpKOFE1QWMwTnplVDJm?=
 =?utf-8?B?Z2tXSFUwQ1hOYmEzNFlGNmEybG42Z1Z6NXNVOVBVWThGRmJCbThnWlBmUWN1?=
 =?utf-8?B?blVyV3RqbDZnS1krcVFVMCtJUkM3ZmVYVFYzdm5LR3MzbHhodTJqQ0YzdGx6?=
 =?utf-8?B?d2tzZVBIaTVTQUE5WC9XV2NHUlBuMER4L3FJdFNzaVdFa3BnRFFZSHZ4NVc4?=
 =?utf-8?B?dHREUGxMUWtmN2pkR2ltMlc3MEQ1cFBQY3l0WFZaelhabkM5WkpqeHNhWTRE?=
 =?utf-8?B?dHhac1VyMDdwMU9qSHFhZklvcnhsMkcwSFpCeXpZMmw4Z00zRkF4YVpvYkdn?=
 =?utf-8?B?a3pWWFArb3B3Z0g5SHNJQlJpSU5iNkpHRlJ1aFBYcUYyOFB6S2V6a3B3YzJ4?=
 =?utf-8?B?VHlvemRwdDlYam96UlM0b1dXVytXckZBUWxSK3ZZSmwxQUZ4MWJ2d0dFclBT?=
 =?utf-8?B?TjhnRTlIQjlxQU16NnVIYVpaa1hKZXdNR3FFRENBZ3BTc255dVRYVEJKWG10?=
 =?utf-8?B?V3lEVEdVLytBUHRZaThJS3N6WFg4bU9URTdPSFZDdnhZbHZWZURmNUlQcE1Q?=
 =?utf-8?B?ZWV0VFkzOUZPQ05qaDhMdjExMXlhWnJsWXBCVmZlMHZUam9Jb1ZkTTkxenR0?=
 =?utf-8?B?T0s2V21IZU5HdWlUS2xQMXdxVDRTbTR0OUVNcUJrblRRaGxsZVFvZ2FLV2Fx?=
 =?utf-8?B?cHE4Mmd4RUdVT3NBT2tnRmlQb2locXVzUmozWE14cy9rbS83RkRCNVQ1Y3dU?=
 =?utf-8?B?a0twWk9SV25DNFpXUytoaFRKN3RFZHZXZjNHa3M5UEdJQjRHaTVFM1h6bFg0?=
 =?utf-8?B?ZnMyRnRvZ3J6dWtNTjVwRktHSkNzVjZYUFRJWGN1OGd2NFJXQkNYcEVDNDBm?=
 =?utf-8?B?L3VHeGpnQkJHTDFkK0dYNnExU09VRU13N1U1M1RSQWZiSTVESmVqVWxoMVlr?=
 =?utf-8?Q?MP3agyoKNym5Y+wIP1lM9iE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6879B68886B7554FB4913EC5CB9CA8E7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb9219d-5901-4e6e-41b4-08dd88f13eee
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2025 20:46:28.0552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +SI5i0PhVgw7ZtcJjZNEDPqKocpPhfZxroEXbQMaCIGXOLWCTQIQvFOI14IDnXM+7H7kExpa5UHJx6I42aelZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6971
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTA1LTAxIGF0IDEzOjAwIC0wNzAwLCBJYW4gUm9nZXJzIHdyb3RlOg0KPiBP
biBUaHUsIE1heSAxLCAyMDI1IGF0IDExOjQy4oCvQU0gVGhvbWFzIEZhbGNvbiA8dGhvbWFzLmZh
bGNvbkBpbnRlbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IENhbGxpbmcgcGVyZiB0b3Agd2l0aCBi
cmFjaCBmaWx0ZXJzIGVuYWJsZWQgb24gSW50ZWwgaHlicmlkIENQVSdzDQo+ID4gd2l0aCBicmFu
Y2ggY291bnRlciBldmVudCBsb2dnaW5nIHN1cHBvcnQgcmVzdWx0cyBpbiBhIHNlZ2ZhdWx0Lg0K
PiA+IA0KPiA+ICQgLi9wZXJmIHRvcCAtZSAne2NwdV9jb3JlL2NwdS1jeWNsZXMvLGNwdV9jb3Jl
L2V2ZW50PTB4YzYsdW1hc2s9MHgzLFwNCj4gPiAgICAgICAgIGZyb250ZW5kPTB4MTEsbmFtZT1m
cm9udGVuZF9yZXRpcmVkX2RzYl9taXNzL30nIC1qIGFueSxjb3VudGVyDQo+ID4gcGVyZjogU2Vn
bWVudGF0aW9uIGZhdWx0DQo+ID4gLS0tLS0tLS0gYmFja3RyYWNlIC0tLS0tLS0tDQo+ID4gLi9w
ZXJmKCkgWzB4NTVmNDYwXQ0KPiA+IC9saWI2NC9saWJjLnNvLjYoKzB4MWEwNTApIFsweDdmZDhi
ZTIyNzA1MF0NCj4gPiAuL3BlcmYoKSBbMHg1N2I0YTddDQo+ID4gLi9wZXJmKCkgWzB4NTYxZTVh
XQ0KPiA+IC4vcGVyZigpIFsweDYwNGE4MV0NCj4gPiAuL3BlcmYoKSBbMHg0Mzk1YjVdDQo+ID4g
Li9wZXJmKCkgWzB4NjAxNzMyXQ0KPiA+IC4vcGVyZigpIFsweDQzOWJjMV0NCj4gPiAuL3BlcmYo
KSBbMHg1ZDM1YjNdDQo+ID4gLi9wZXJmKCkgWzB4NDM5MzZjXQ0KPiA+IC9saWI2NC9saWJjLnNv
LjYoKzB4NzBiYTgpIFsweDdmZDhiZTI3ZGJhOF0NCj4gPiAvbGliNjQvbGliYy5zby42KCsweGY0
YjhjKSBbMHg3ZmQ4YmUzMDFiOGNdDQo+IA0KDQpIaSBJYW4sIHRoYW5rcyBmb3IgcmV2aWV3aW5n
Lg0KDQo+IFRoYW5rcyBUaG9tYXMuIENvdWxkIHlvdSBnZW5lcmF0ZSB0aGlzIGJhY2t0cmFjZSBp
biBHREI/IEkgZGlkIHdyaXRlIGENCj4gcGF0Y2ggdG8gc3ltYm9saXplIGJhY2t0cmFjZXMgbGlr
ZSB0aGlzOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjUwMzEzMDUyOTUyLjg3
MTk1OC0yLWlyb2dlcnNAZ29vZ2xlLmNvbS8NCj4gU2FkbHkgd2l0aG91dCBhbnkgcmV2aWV3ZWQg
dGFncyBhbmQgdW5tZXJnZWQgLSB0aGUgY29kZSBjYWxscyByb3V0aW5lcw0KPiB0aGF0IG1hbGxv
YyBzbyBpdCBpc24ndCBzdHJpY3RseSBzb3VuZCBpZiBzYXkgdGhlIGJhY2t0cmFjZSB3YXMgbmVl
ZGVkDQo+IGZyb20gYSBTRUdWIGluIHRoZSBtYWxsb2MgaW1wbGVtZW50YXRpb24sIGl0IGlzIG5p
Y2VseQ0KPiBzZWxmLXJlZmVyZW5jaW5nIHRoZSBwZXJmIEFQSXMsIC4uDQoNClNvcnJ5IGFib3V0
IHRoYXQsIGhlcmUgaXMgdGhlIGJhY2t0cmFjZSBJJ20gc2VlaW5nIHdoZW4gcnVubmluZyB0aGUg
cGVyZiB0b3AgY29tbWFuZCBpbiBnZGI6DQoNClRocmVhZCAyNyAicGVyZiIgcmVjZWl2ZWQgc2ln
bmFsIFNJR1NFR1YsIFNlZ21lbnRhdGlvbiBmYXVsdC4NCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIA0KW1N3aXRjaGluZyB0byBUaHJlYWQgMHg3ZmZmY2I3ZmU2YzAg
KExXUCA4MTIxNjkpXQ0KMHgwMDAwMDAwMDAwNTdiNGE3IGluIHBlcmZfZW52LmZpbmRfYnJfY250
cl9pbmZvICgpDQooZ2RiKSBiYWNrdHJhY2UNCiMwICAweDAwMDAwMDAwMDA1N2I0YTcgaW4gcGVy
Zl9lbnYuZmluZF9icl9jbnRyX2luZm8gKCkNCiMxICAweDAwMDAwMDAwMDA1NjFlNWEgaW4gYWRk
cl9tYXBfc3ltYm9sLmFjY291bnRfY3ljbGVzICgpDQojMiAgMHgwMDAwMDAwMDAwNjA0YTgxIGlu
IGhpc3QuYWNjb3VudF9jeWNsZXMgKCkNCiMzICAweDAwMDAwMDAwMDA0Mzk1YjUgaW4gaGlzdF9p
dGVyLnRvcF9jYWxsYmFjayAoKQ0KIzQgIDB4MDAwMDAwMDAwMDYwMTczMiBpbiBoaXN0X2VudHJ5
X2l0ZXIuYWRkICgpDQojNSAgMHgwMDAwMDAwMDAwNDM5YmMxIGluIGRlbGl2ZXJfZXZlbnQgKCkN
CiM2ICAweDAwMDAwMDAwMDA1ZDM1YjMgaW4gX19vcmRlcmVkX2V2ZW50c19fZmx1c2ggKCkNCiM3
ICAweDAwMDAwMDAwMDA0MzkzNmMgaW4gcHJvY2Vzc190aHJlYWQgKCkNCiM4ICAweDAwMDA3ZmZm
ZjZlN2RiYTggaW4gc3RhcnRfdGhyZWFkIChhcmc9PG9wdGltaXplZCBvdXQ+KSBhdCBwdGhyZWFk
X2NyZWF0ZS5jOjQ0OA0KIzkgIDB4MDAwMDdmZmZmNmYwMWI4YyBpbiBfX0dJX19fY2xvbmUzICgp
IGF0IC4uL3N5c2RlcHMvdW5peC9zeXN2L2xpbnV4L3g4Nl82NC9jbG9uZTMuUzo3OA0KDQpUaGFu
a3MsDQpUb20NCg0KPiBgYGANCj4gc3RhdHVzID0gcGVyZl9lbnZfX3JlYWRfY3B1aWQoJnBlcmZf
ZW52KTsNCj4gYGBgDQo+IA0KPiBJIGtpbmQgb2Ygd2lzaCB3ZSBkaWRuJ3QgaGF2ZSB0aGUgZ2xv
YmFsIG9uZSBhcyB3aGF0J3MgdGhlIGRlYWwgd2l0aA0KPiBvd25lcnNoaXAgd2l0aCBpdC4NCj4g
DQo+ID4gRml4IHRoaXMgYnkgcG9wdWxhdGluZyBjcHVfcG11X2NhcHMgYW5kIHBtdV9jYXBzIHN0
cnVjdHVyZXMgd2l0aA0KPiA+IHZhbHVlcyBmcm9tIHN5c2ZzIHdoZW4gY2FsbGluZyBwZXJmIHRv
cCB3aXRoIGJyYW5jaCBzdGFjayBzYW1wbGluZw0KPiA+IGVuYWJsZWQuDQo+IA0KPiBJIHdvbmRl
ciBpZiB3ZSBjb3VsZCBlbmNvdW50ZXIgc2ltaWxhciBwcm9ibGVtcyBmcm9tIHNheSBhIHBlcmYg
c2NyaXB0DQo+IGhhbmRsaW5nIGxpdmUgZGF0YSBhbmQgc28gc29tZSBraW5kIG9mIGxhenkgaW5p
dGlhbGl6YXRpb24gc2hvdWxkIGJlDQo+IGVtcGxveWVkLiBJdCBpcyBoYXJkIHRvIHNheSB3aXRo
b3V0IHNlZWluZyB0aGUgYmFja3RyYWNlLg0KPiANCj4gVGhhbmtzLA0KPiBJYW4NCj4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogVGhvbWFzIEZhbGNvbiA8dGhvbWFzLmZhbGNvbkBpbnRlbC5jb20+DQo+
ID4gLS0tDQo+ID4gIHRvb2xzL3BlcmYvYnVpbHRpbi10b3AuYyB8ICAgOCArKysNCj4gPiAgdG9v
bHMvcGVyZi91dGlsL2Vudi5jICAgIHwgMTE0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiA+ICB0b29scy9wZXJmL3V0aWwvZW52LmggICAgfCAgIDEgKw0KPiA+ICAz
IGZpbGVzIGNoYW5nZWQsIDEyMyBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBh
L3Rvb2xzL3BlcmYvYnVpbHRpbi10b3AuYyBiL3Rvb2xzL3BlcmYvYnVpbHRpbi10b3AuYw0KPiA+
IGluZGV4IDEwNjFmNGVlYmMzZi4uYzI2ODhlNGVmM2M0IDEwMDY0NA0KPiA+IC0tLSBhL3Rvb2xz
L3BlcmYvYnVpbHRpbi10b3AuYw0KPiA+ICsrKyBiL3Rvb2xzL3BlcmYvYnVpbHRpbi10b3AuYw0K
PiA+IEBAIC0xNzI5LDYgKzE3MjksMTQgQEAgaW50IGNtZF90b3AoaW50IGFyZ2MsIGNvbnN0IGNo
YXIgKiphcmd2KQ0KPiA+ICAgICAgICAgaWYgKG9wdHMtPmJyYW5jaF9zdGFjayAmJiBjYWxsY2hh
aW5fcGFyYW0uZW5hYmxlZCkNCj4gPiAgICAgICAgICAgICAgICAgc3ltYm9sX2NvbmYuc2hvd19i
cmFuY2hmbGFnX2NvdW50ID0gdHJ1ZTsNCj4gPiANCj4gPiArICAgICAgIGlmIChvcHRzLT5icmFu
Y2hfc3RhY2spIHsNCj4gPiArICAgICAgICAgICAgICAgc3RhdHVzID0gcGVyZl9lbnZfX3JlYWRf
Y29yZV9wbXVfY2FwcygmcGVyZl9lbnYpOw0KPiA+ICsgICAgICAgICAgICAgICBpZiAoc3RhdHVz
KSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcHJfZXJyKCJQTVUgY2FwYWJpbGl0eSBk
YXRhIGlzIG5vdCBhdmFpbGFibGVcbiIpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGdv
dG8gb3V0X2RlbGV0ZV9ldmxpc3Q7DQo+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiArICAgICAg
IH0NCj4gPiArDQo+ID4gICAgICAgICBzb3J0X19tb2RlID0gU09SVF9NT0RFX19UT1A7DQo+ID4g
ICAgICAgICAvKiBkaXNwbGF5IHRocmVhZCB3YW50cyBlbnRyaWVzIHRvIGJlIGNvbGxhcHNlZCBp
biBhIGRpZmZlcmVudCB0cmVlICovDQo+ID4gICAgICAgICBwZXJmX2hwcF9saXN0Lm5lZWRfY29s
bGFwc2UgPSAxOw0KPiA+IGRpZmYgLS1naXQgYS90b29scy9wZXJmL3V0aWwvZW52LmMgYi90b29s
cy9wZXJmL3V0aWwvZW52LmMNCj4gPiBpbmRleCAzNjQxMTc0OWUwMDcuLjM3ZWQ2ZGM1MmNmMyAx
MDA2NDQNCj4gPiAtLS0gYS90b29scy9wZXJmL3V0aWwvZW52LmMNCj4gPiArKysgYi90b29scy9w
ZXJmL3V0aWwvZW52LmMNCj4gPiBAQCAtNDE2LDYgKzQxNiwxMjAgQEAgc3RhdGljIGludCBwZXJm
X2Vudl9fcmVhZF9ucl9jcHVzX2F2YWlsKHN0cnVjdCBwZXJmX2VudiAqZW52KQ0KPiA+ICAgICAg
ICAgcmV0dXJuIGVudi0+bnJfY3B1c19hdmFpbCA/IDAgOiAtRU5PRU5UOw0KPiA+ICB9DQo+ID4g
DQo+ID4gK3N0YXRpYyBpbnQgX19wZXJmX2Vudl9fcmVhZF9jb3JlX3BtdV9jYXBzKHN0cnVjdCBw
ZXJmX3BtdSAqcG11LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGludCAqbnJfY2FwcywgY2hhciAqKipjYXBzLA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCAqbWF4X2JyYW5jaGVzLA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCAqYnJf
Y250cl9uciwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1
bnNpZ25lZCBpbnQgKmJyX2NudHJfd2lkdGgpDQo+ID4gK3sNCj4gPiArICAgICAgIHN0cnVjdCBw
ZXJmX3BtdV9jYXBzICpwY2FwcyA9IE5VTEw7DQo+ID4gKyAgICAgICBjaGFyICpwdHIsICoqdG1w
Ow0KPiA+ICsgICAgICAgaW50IHJldCA9IDA7DQo+ID4gKw0KPiA+ICsgICAgICAgKm5yX2NhcHMg
PSAwOw0KPiA+ICsgICAgICAgKmNhcHMgPSBOVUxMOw0KPiA+ICsNCj4gPiArICAgICAgIGlmICgh
cG11LT5ucl9jYXBzKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gPiArDQo+ID4g
KyAgICAgICAqY2FwcyA9IHphbGxvYyhzaXplb2YoY2hhciAqKSAqIHBtdS0+bnJfY2Fwcyk7DQo+
ID4gKyAgICAgICBpZiAoISpjYXBzKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVOT01F
TTsNCj4gPiArDQo+ID4gKyAgICAgICB0bXAgPSAqY2FwczsNCj4gPiArICAgICAgIGxpc3RfZm9y
X2VhY2hfZW50cnkocGNhcHMsICZwbXUtPmNhcHMsIGxpc3QpIHsNCj4gPiArDQo+ID4gKyAgICAg
ICAgICAgICAgIGlmIChhc3ByaW50ZigmcHRyLCAiJXM9JXMiLCBwY2Fwcy0+bmFtZSwgcGNhcHMt
PnZhbHVlKSA8IDApIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZXQgPSAtRU5PTUVN
Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyb3I7DQo+ID4gKyAgICAgICAg
ICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgICp0bXArKyA9IHB0cjsNCj4gPiAr
DQo+ID4gKyAgICAgICAgICAgICAgIGlmICghc3RyY21wKHBjYXBzLT5uYW1lLCAiYnJhbmNoZXMi
KSkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAqbWF4X2JyYW5jaGVzID0gYXRvaShwY2Fw
cy0+dmFsdWUpOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgaWYgKCFzdHJjbXAocGNhcHMt
Pm5hbWUsICJicmFuY2hfY291bnRlcl9uciIpKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICpicl9jbnRyX25yID0gYXRvaShwY2Fwcy0+dmFsdWUpOw0KPiA+ICsNCj4gPiArICAgICAgICAg
ICAgICAgaWYgKCFzdHJjbXAocGNhcHMtPm5hbWUsICJicmFuY2hfY291bnRlcl93aWR0aCIpKQ0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICpicl9jbnRyX3dpZHRoID0gYXRvaShwY2Fwcy0+
dmFsdWUpOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsgICAgICAgKm5yX2NhcHMgPSBwbXUtPm5yX2Nh
cHM7DQo+ID4gKyAgICAgICByZXR1cm4gMDsNCj4gPiArZXJyb3I6DQo+ID4gKyAgICAgICB3aGls
ZSAodG1wLS0gIT0gKmNhcHMpDQo+ID4gKyAgICAgICAgICAgICAgIGZyZWUoKnRtcCk7DQo+ID4g
KyAgICAgICBmcmVlKCpjYXBzKTsNCj4gPiArICAgICAgICpjYXBzID0gTlVMTDsNCj4gPiArICAg
ICAgICpucl9jYXBzID0gMDsNCj4gPiArICAgICAgIHJldHVybiByZXQ7DQo+ID4gK30NCj4gPiAr
DQo+ID4gK2ludCBwZXJmX2Vudl9fcmVhZF9jb3JlX3BtdV9jYXBzKHN0cnVjdCBwZXJmX2VudiAq
ZW52KQ0KPiA+ICt7DQo+ID4gKyAgICAgICBzdHJ1Y3QgcGVyZl9wbXUgKnBtdSA9IE5VTEw7DQo+
ID4gKyAgICAgICBzdHJ1Y3QgcG11X2NhcHMgKnBtdV9jYXBzOw0KPiA+ICsgICAgICAgaW50IG5y
X3BtdSA9IDAsIGkgPSAwLCBqOw0KPiA+ICsgICAgICAgaW50IHJldDsNCj4gPiArDQo+ID4gKyAg
ICAgICBucl9wbXUgPSBwZXJmX3BtdXNfX251bV9jb3JlX3BtdXMoKTsNCj4gPiArDQo+ID4gKyAg
ICAgICBpZiAoIW5yX3BtdSkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7DQo+
ID4gKw0KPiA+ICsgICAgICAgaWYgKG5yX3BtdSA9PSAxKSB7DQo+ID4gKyAgICAgICAgICAgICAg
IHBtdSA9IHBlcmZfcG11c19fc2Nhbl9jb3JlKE5VTEwpOw0KPiA+ICsgICAgICAgICAgICAgICBp
ZiAoIXBtdSkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsNCj4g
PiArICAgICAgICAgICAgICAgcmV0ID0gcGVyZl9wbXVfX2NhcHNfcGFyc2UocG11KTsNCj4gPiAr
ICAgICAgICAgICAgICAgaWYgKHJldCA8IDApDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIHJldDsNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIF9fcGVyZl9lbnZfX3JlYWRf
Y29yZV9wbXVfY2FwcyhwbXUsICZlbnYtPm5yX2NwdV9wbXVfY2FwcywNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmZW52LT5jcHVfcG11
X2NhcHMsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgJmVudi0+bWF4X2JyYW5jaGVzLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZlbnYtPmJyX2NudHJfbnIsDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmVudi0+
YnJfY250cl93aWR0aCk7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgcG11X2Nh
cHMgPSB6YWxsb2Moc2l6ZW9mKCpwbXVfY2FwcykgKiBucl9wbXUpOw0KPiA+ICsgICAgICAgaWYg
KCFwbXVfY2FwcykNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+ID4gKw0K
PiA+ICsgICAgICAgd2hpbGUgKChwbXUgPSBwZXJmX3BtdXNfX3NjYW5fY29yZShwbXUpKSAhPSBO
VUxMKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGlmIChwZXJmX3BtdV9fY2Fwc19wYXJzZShwbXUp
IDw9IDApDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+ID4gKyAgICAg
ICAgICAgICAgIHJldCA9IF9fcGVyZl9lbnZfX3JlYWRfY29yZV9wbXVfY2FwcyhwbXUsICZwbXVf
Y2Fwc1tpXS5ucl9jYXBzLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgJnBtdV9jYXBzW2ldLmNhcHMsDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmcG11X2NhcHNbaV0ubWF4X2Jy
YW5jaGVzLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgJnBtdV9jYXBzW2ldLmJyX2NudHJfbnIsDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmcG11X2NhcHNbaV0uYnJfY250cl93
aWR0aCk7DQo+ID4gKyAgICAgICAgICAgICAgIGlmIChyZXQpDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgZ290byBlcnJvcjsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIHBtdV9jYXBz
W2ldLnBtdV9uYW1lID0gc3RyZHVwKHBtdS0+bmFtZSk7DQo+ID4gKyAgICAgICAgICAgICAgIGlm
ICghcG11X2NhcHNbaV0ucG11X25hbWUpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBy
ZXQgPSAtRU5PTUVNOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyb3I7DQo+
ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiArICAgICAgICAgICAgICAgaSsrOw0KPiA+ICsgICAg
ICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIGVudi0+bnJfcG11c193aXRoX2NhcHMgPSBucl9wbXU7
DQo+ID4gKyAgICAgICBlbnYtPnBtdV9jYXBzID0gcG11X2NhcHM7DQo+ID4gKw0KPiA+ICsgICAg
ICAgcmV0dXJuIDA7DQo+ID4gK2Vycm9yOg0KPiA+ICsgICAgICAgZm9yIChpID0gMDsgaSA8IG5y
X3BtdTsgaSsrKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGZvciAoaiA9IDA7IGogPCBwbXVfY2Fw
c1tpXS5ucl9jYXBzOyBqKyspDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZnJlZShwbXVf
Y2Fwc1tpXS5jYXBzW2pdKTsNCj4gPiArICAgICAgICAgICAgICAgZnJlZShwbXVfY2Fwc1tpXS5j
YXBzKTsNCj4gPiArICAgICAgICAgICAgICAgZnJlZShwbXVfY2Fwc1tpXS5wbXVfbmFtZSk7DQo+
ID4gKyAgICAgICB9DQo+ID4gKyAgICAgICBmcmVlKHBtdV9jYXBzKTsNCj4gPiArICAgICAgIHJl
dHVybiByZXQ7DQo+ID4gK30NCj4gPiArDQo+ID4gIGNvbnN0IGNoYXIgKnBlcmZfZW52X19yYXdf
YXJjaChzdHJ1Y3QgcGVyZl9lbnYgKmVudikNCj4gPiAgew0KPiA+ICAgICAgICAgcmV0dXJuIGVu
diAmJiAhcGVyZl9lbnZfX3JlYWRfYXJjaChlbnYpID8gZW52LT5hcmNoIDogInVua25vd24iOw0K
PiA+IGRpZmYgLS1naXQgYS90b29scy9wZXJmL3V0aWwvZW52LmggYi90b29scy9wZXJmL3V0aWwv
ZW52LmgNCj4gPiBpbmRleCBkOTBlMzQzY2YxZmEuLjEzNWExZjcxNDkwNSAxMDA2NDQNCj4gPiAt
LS0gYS90b29scy9wZXJmL3V0aWwvZW52LmgNCj4gPiArKysgYi90b29scy9wZXJmL3V0aWwvZW52
LmgNCj4gPiBAQCAtMTUyLDYgKzE1Miw3IEBAIHN0cnVjdCBidGZfbm9kZTsNCj4gPiANCj4gPiAg
ZXh0ZXJuIHN0cnVjdCBwZXJmX2VudiBwZXJmX2VudjsNCj4gPiANCj4gPiAraW50IHBlcmZfZW52
X19yZWFkX2NvcmVfcG11X2NhcHMoc3RydWN0IHBlcmZfZW52ICplbnYpOw0KPiA+ICB2b2lkIHBl
cmZfZW52X19leGl0KHN0cnVjdCBwZXJmX2VudiAqZW52KTsNCj4gPiANCj4gPiAgaW50IHBlcmZf
ZW52X19rZXJuZWxfaXNfNjRfYml0KHN0cnVjdCBwZXJmX2VudiAqZW52KTsNCj4gPiAtLQ0KPiA+
IDIuNDkuMA0KPiA+IA0KDQo=

