Return-Path: <linux-kernel+bounces-838394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED83BAF13B
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 06:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C91B2A177E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 04:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D322D6E75;
	Wed,  1 Oct 2025 04:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZCWytKAv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D8C2D6623
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 04:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759291936; cv=fail; b=TwSRfUBr2wfglxyPIzSpkN3lzEBc1JUk8H/vBGgqOq2wLk8xHNEicPdTYHT0sZwMyxNXfzhpNgoGen4fD6nB/6ycHn6r/X/fCUH5y2tszxgg3zzHkUgLFgDExvQFR+QKf5L/8IS7gAZE4VwvVFXnGUcAZ1EBRt1D2ws8VCXUk/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759291936; c=relaxed/simple;
	bh=qidGIJd5gqxhGGdU+MV9b21gF5WoF0AvKDihdkMQAb8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U9lM5L2fDb4TRUdgT2yWrRfCD66dvge+T49Hqc9wdpYAhPcuAL8oDsvMvnDL5uzJ1kMosHkSFibdIFfP8tTlR+T1V+eJOAenFNyJpKOVHeMv7IeobFSQ/JGlYWNc65Cts6vokx0O/sOz5pdhhQwNJwrwI9nBC5UK9kcjyctR3vE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZCWytKAv; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759291935; x=1790827935;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qidGIJd5gqxhGGdU+MV9b21gF5WoF0AvKDihdkMQAb8=;
  b=ZCWytKAv71H55rn/iIak/B6u3RgAwRhJCVTMPtkALWBaHhIQiLiKIXre
   4+q9gxznzSnGQOH+pIE+MpAk+m4SxRngz/F0DVsueIYv0B/WhPwloa/eT
   giY6ebejtdglGZQ7bjD+MYsR4N14W7IeykRRLOCotTBLWBlDsmVC0x1dj
   oStl45ombqRel3dzwSKI7gHqVrGG2AOD1oaKTzcYXA4Er0v6N9V0aw0Jh
   8xk784POtWjfUVQSWmhqhdIAFGZ7aA7zKPSrtyruYt/mjOOSjUqCoaasN
   1uolZ0t8mTsJCS3KXLL070TghdwXBZtsCTFVpYZBEc6BM3oDUFIMLL0Wa
   A==;
X-CSE-ConnectionGUID: CpEyI5uYTS+ulfTNIdVeHQ==
X-CSE-MsgGUID: Q3romxLDTCm9amI0ncs/Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="65200237"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="65200237"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 21:12:14 -0700
X-CSE-ConnectionGUID: ukTwXhtKQ+y0ph89nUIuNw==
X-CSE-MsgGUID: hUsUi7f4T+e9KoibLAeT+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="178644862"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 21:12:13 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 21:12:13 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 30 Sep 2025 21:12:13 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.10)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 21:12:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FzAknbJ2natbyzzMoYItKHJYVFqqzs6AAFwKTvuTsFsf2w87wHFbqHPJ2xp604FnHCeQBGGU+0YCz3DcNJ+f8d72N069Zqkf/MfgrokrlRwGM7PnOSw/b5t3YUGCaImEsuAEm9L3OVCGTi00241lReBwCCY1SQp1m8A3Gf1QG6bkrf9EGFteqWK3k5KZrc13Z368WwdGpJ/BNQ/ECfsoB06pMWyOND5z1EVstVL+teEuMUGuIY2/QOZlvhbiVSN5tjNdc1uw4UipzsMYDYKGGsFfno5Y5aP2iThoD4NsSI4q5fbvfUDC2moxGeMdnkuFhmbh0cjtasbvpHU4hLsLnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qidGIJd5gqxhGGdU+MV9b21gF5WoF0AvKDihdkMQAb8=;
 b=ID31MMX/alNuNyJAU8u9HwyzaGsaomoBefCOwSG6gOlvjZwv2MD6reXO8MbbmkB0AVlV2B2/6RZlMJywt/r7n8tgR6XVvKXx81Bla+AFUOKMnlYPNvI/E302RMMU+KX2e0l3SkhROxFq8Xf+4vhHXYjJTa2fbXoSAvqbKqsmOC3br527uAF5q/zRzOjs+MnAj799gHJelLUr48ZwrdQdwZu7CyHEjcUfDZ4uHungqO6m/TD7Z3jDN0JSa8w3isOgxPsYeYGTpY4D2JwjYXALPyTHiikCgyPn1bTjgKjb4i1nBsdpVstdcHweQVF3+6zY7F6jYxkSlYCjN8zf3xc/SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5525.namprd11.prod.outlook.com (2603:10b6:208:31f::10)
 by SJ5PPF64191BB3C.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::82f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 1 Oct
 2025 04:12:10 +0000
Received: from BL1PR11MB5525.namprd11.prod.outlook.com
 ([fe80::1a2f:c489:24a5:da66]) by BL1PR11MB5525.namprd11.prod.outlook.com
 ([fe80::1a2f:c489:24a5:da66%6]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 04:12:10 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "Williams, Dan J" <dan.j.williams@intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 2/2] coco/tdx-host: Expose TDX module version
Thread-Topic: [PATCH 2/2] coco/tdx-host: Expose TDX module version
Thread-Index: AQHcMnp/jKWYw+n9jk+kyWxP5S88frSsriSA
Date: Wed, 1 Oct 2025 04:12:10 +0000
Message-ID: <e4041d4706fe55d3d012144680d9be33acdda19f.camel@intel.com>
References: <20251001022309.277238-1-chao.gao@intel.com>
	 <20251001022309.277238-3-chao.gao@intel.com>
In-Reply-To: <20251001022309.277238-3-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2 (3.56.2-2.fc42) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5525:EE_|SJ5PPF64191BB3C:EE_
x-ms-office365-filtering-correlation-id: fe826942-d713-4b84-5b55-08de00a0b186
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TEZqRnllcElkTW5ISzkyZlM2TTVheWRROHVGMStvMkZnQW1jZGxlV1B2a0gv?=
 =?utf-8?B?Wm5pZzdMMjdkV2NXeFkvWE5EMWFaWnNaYWtmekFwZXd2YnhKa2xFcEI3dXRC?=
 =?utf-8?B?cWJvMFd2aVRlaGpCcUthYkRMNk5odWRFVW9YcEVnckJIUkRNU3BxekRwaHF2?=
 =?utf-8?B?bWRqY1lWMmxlZnROcW5JTlROK09FekJXTDdDcHBCT2tuZGIxdFJ6Qm4vSElI?=
 =?utf-8?B?Mk1qNUxWYk9YeXJlQW9UODB2MWhQclZZenY0amFHd3paS01odW9nbXFVWi9q?=
 =?utf-8?B?Tms2dTI2eTFibmUxdmVhSkx2a1IvZjN0cFdsOFVaZ2pELzRjdUVqN2NLNHVv?=
 =?utf-8?B?ZVBJZS84U3VJV3czb1B3N0pTUFdGMzZYcW52OEFEUThEUHRTQmJHeVpoVW5o?=
 =?utf-8?B?YlVQSURSOE9oaFVsN1Vlc3VQalUxZjFXbGNPSVhCT2g2TlNmYmZENm04amJ6?=
 =?utf-8?B?azkzZElwWVNmRlgxRGJ3WjVVUkhsaWR3VWZweTRBa0FhQ1NvSTRNcW0vbWtm?=
 =?utf-8?B?dEFBN0VGSy8xVXljQ01lek5tNVBnUEt0cjRmdGg2MXNlelQrZmpFWXZ0T09G?=
 =?utf-8?B?bms4QWJTOFBNN3c3NHVqK3c5UGNLeS9OckY0ZHdPRlVKVk9ybmdMZGkxeG90?=
 =?utf-8?B?NEx1VXY2S1k0Tm9zSDU0U3hLYUhMVkxKS2o2a2ZhaWlmREltVXRsb1BabWpm?=
 =?utf-8?B?YUJWVkJQR2xub0Y1MFJ6UktIM3FNWkdpNDFUc3RmWXBlR3pmWFQ1V0NRc2FY?=
 =?utf-8?B?NHRaNGsxK3puY1V6Rk9aTUx0SzdPV0o1VzlTc0FMK1U5b3ZWajhFRjBPeXkr?=
 =?utf-8?B?TEpYM0N6WXZGOGNPdTRCeGpkb3dPam5BQnhVWmNEZ1MxZjhkcVBOa1RmbFRa?=
 =?utf-8?B?bG1PblBlWTQ2WnMzZnZiN1g1L3pkMVh1a3NiRW9QRTI2VEphMmI2Z09rZkVR?=
 =?utf-8?B?QkRxZElPdDFPQ0JDNTdEN01zZUhXMWdFTVBNUGNwR2NRNGxhOHMwL2NFNEgx?=
 =?utf-8?B?TFpPYkJVNzhFOEdOcE5teitCMDNuQ0lJMnhuLzdPT3hTSkZEL3dVN1g4MXBL?=
 =?utf-8?B?K1VFdG4zVHBVQ3dmdDdPRXI4ZjFtTTBMZTJNVThiV2U3azdXSEU3cVc4Snc5?=
 =?utf-8?B?MWF5MERFWERjVkxCa2dlS0ZzU3I5NEs1TnVOU0xDRkRwNWxFdzExcDlKMkNy?=
 =?utf-8?B?Q1prM25xZ0hDZElWMXNUTnhzazl0endLblRwRVJNMUl5bU83NjRnczdPVlRl?=
 =?utf-8?B?M1loTmxvbmJSZTM2V2grMXBnRDVxWE0zUTg1NnJGcFJsUmkyajMxQlBsazAr?=
 =?utf-8?B?YVJ3TmdwNDFMYko0eXpSUVZZa1dNU1NSRXhlSllIRmlxN0FzWTdmWUZIN0p0?=
 =?utf-8?B?VW1vZmptQmFJWlBlakVVVXNBNkFrNmRHeFBmLzZPVVpha21HUSt4RURDbzVn?=
 =?utf-8?B?VDhUZHJuS0FCUEJPOFdFTEQxVWdmdE9ocnFDU0gxQzYydjJ6RUpCVFhJUXlY?=
 =?utf-8?B?R2xhbEx5aytONjRaL3M3ZzNTM3RGK05tUGsycHFadENWemF2WGtOK2dKVTha?=
 =?utf-8?B?Ty9peWFsWjdFamhyNUlkSWNZQmpzbkZ5Z0VZYk1BLzkwalhqZmVUdU1la1ll?=
 =?utf-8?B?U0ZSTHFkUUloS1dMSlRkbUJ0MjZER01ueHR5SjRiS2dpREhBQkhvNklXZzdU?=
 =?utf-8?B?LzJwbytpMVJWbDRTL0Q5NVhLMUZDTllsNm85bGdOVFBUUWxsYWsyQys4YnNa?=
 =?utf-8?B?TmhFK2JKc05YRnZRUVhVckJlWm1naXlCbmpVamE1NU1oM2l1cnlZQlI3MDRS?=
 =?utf-8?B?SmRIRWh6VXl2RkExaGRMWElVekFJaHdjN1ZFTzFMRHBmYzdOaXQ4UThvbDdk?=
 =?utf-8?B?MnZKN0lzSDdGSExEdEhzYmJEdGVsVWl2Q3NVbkRGZzFIbmxXZkN0UjlHZStp?=
 =?utf-8?B?d3oxQ21QSDBocHFIcldUWXhSVW1ZSTdIUTVmNXRlKzU0NFpCUnhEczZoUyt1?=
 =?utf-8?B?R0ZVWU11ZU9VZGZlQnFaQzI4TDdoNDFzekVQREFEUjdPWXc1QnNzU0FJMHhH?=
 =?utf-8?Q?Q3Hfwz?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5525.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1ZBblExT1hyNG45Wkt2S010SzRKeUJMUFZONkpvRW9aRWVaZkpJYmgxajM2?=
 =?utf-8?B?V2NNdkxza3h0RkFIL1FSN0tPMEM5VFVnMmlTQVBQWTVNNXFCVGZkUDZoY0Vn?=
 =?utf-8?B?eUFBb2RrdTdNa3pXejk3d3ppQzU1UzVVcUJXcXFNaXRPWjc0bEhab2lENStt?=
 =?utf-8?B?ZUtjMElUaXRZMTNJRWxHclZpU2RCMnJQYVNiajVCUGpkanBic2FpOGswZDdz?=
 =?utf-8?B?TmVoT2FxbEVPMU11NmhIYlJoOFlNbXpsWG1xQTQyZEdxTStCS0h6by9kUU9M?=
 =?utf-8?B?ZldZQ2luRXltQko4eEFmZDFtYXhwSGFXMTJ5Zm5TblR6UXBqMlhobUpHblR4?=
 =?utf-8?B?aE43K0ozR0p6M0FwZlEyUXYvazc0N2JvVEN6bGR6Z0dlcTNhL251TnA4ZFB4?=
 =?utf-8?B?aFNjajZRMXF1TWp3MHN4QlY4c1M0QitaeVVLL1F4N0lPbHlsSVNzME5yN1hm?=
 =?utf-8?B?WWpsQmMyejZ0R1pRdXN4ZG1XbXBONFUxSEZWcy9EK0dycXNiUkFHaHRDZDNU?=
 =?utf-8?B?WHJCeEJxMlFOWDRFMEtWNmQ1RzI0MFRsanlkV1hZSEo5SUFRR1ZBWXA3aHJ5?=
 =?utf-8?B?eXMyblBxL20ya2NTcnFFK005NHN0L25jQWQ3bjdySno5S1NhdGo4WVFnOWFq?=
 =?utf-8?B?N0FIM0V3VS9kZ0Z0eXZ4cXJXZ1pNbElsMlFSZGdKSW9UcnV4a3Y3dnZKdTd1?=
 =?utf-8?B?QWZGSGVsYlY4TWFBM1Z5WWJVc1NScGZXUHlickZXMHFHMEhmRE14cEJMVGdo?=
 =?utf-8?B?MzdmeWZrUkJ4MWsrTVhvNFpZMERhem9aLzE0SHczRlJFSlhCT3RZSTl6WDE2?=
 =?utf-8?B?eW0rZ2F2d0Z1YU92WnVnYkpla0c2NjB6ditMKzVjRVFuS1lqZzFld2Y2cUJo?=
 =?utf-8?B?Z1RIS2tkWlkvSnphRUI4MkF6cUJJWVlyem5Wem50ckx3YjRSc0xFVkpiWGNX?=
 =?utf-8?B?MVF6Z1Jmb1lWS1NIRkZ4RXpIeGJNbjA2Y0s5S3JDeFZyK1Z1R0ZhRGhncjVj?=
 =?utf-8?B?YmpyOUhUM3lQYzNKeXBIVTBGbWNFcnJyUTl6SjY2RWNXeWJkOVk2aEE3WFAy?=
 =?utf-8?B?NkVKSmZEUWREQmJPdnZ4Tk9ndXFSdmFZVkMzWWJVeWpWTVVNNE5aMks0NXdz?=
 =?utf-8?B?V0YwaXViUWlRUUV1RzFFZzl1UTF2L1RWN2oyaFAxd0dSL2NPYTg5YTBOSVRE?=
 =?utf-8?B?ajFTMEdybUkvZlQrYThYWCtkOXV0UU9QWVNuZEhlYjRLUmhoQU8zbkx5cnNl?=
 =?utf-8?B?RnlkUmp5RHRlYUFjZFZpMWo2clFQUUg5L2R3S1lDaEZPMHB4K2t3eDgyUC9y?=
 =?utf-8?B?ajdMRTl6THNYd0owOXdxbnV4M2JaeVVVTGNyWDV6ditTV2hMVnVyQlNVbXRi?=
 =?utf-8?B?alc4ZDZ4U3F6cDkxajNCWVp3TEYxSzdBS0U5MFdtdCs1MVp3TUlQemhQL3lR?=
 =?utf-8?B?NlZiL1BnVzgxV2tLYlJ6STVHd0RWMzRtOFNjU251ckRFeVRlM09LYWljdW9n?=
 =?utf-8?B?RzU2Wk53Qkg4ODd3V3k5MS8xT3lmcFcvd0txbm5XNHJaVzNKOWEwVE1JM0po?=
 =?utf-8?B?VWl2QXNzVUdGaXRweGNZQnlHZVNBUGw3N1lqSGZuVVhUZjF5cjh0eVFCVlpK?=
 =?utf-8?B?Y3J0OHh1cE5IV1VpRDVXaVFpZFpBSmk2RGViYUlpOXN1U0IrVkhGNW9KZFNi?=
 =?utf-8?B?SnRBbE0xWTBlc1JHT0dTeG0yNGtmS2dNeFFkQ29FbGx3ODNlMDh4dnpUNVhy?=
 =?utf-8?B?QStraEp0RFlCZkNWS2xmUi9Vb2NndUxFNjB5M2RKaXFvdkk1RExwMC95VVo4?=
 =?utf-8?B?Y3BSNlVxd29GVEZLcXkyd2pXZmdYUXEvTlhQQ21uY0dzUjFjQUxTVzZSVGZQ?=
 =?utf-8?B?YVVvMFc5REFYK0ZhYXJxRWtxNXR4UmpFeU8rQnFjU3I0dGJza3ZhUEpHN2Vr?=
 =?utf-8?B?ZnVvRDZvb1ZnVy9mN05vUW1IRFVCeUR1U09qdzJaQ01mdThnbEswM1lxdUNL?=
 =?utf-8?B?aGlkbmxYTGxnZG04WDdYSXVHdXc1eDZuakJBWlJiTVZaQnVlZXY2QmRwRXR0?=
 =?utf-8?B?d0pxTnNUUXUwWS8rbUVSajZ1YmlNazFsamc2VzlKQlBrTE5MaDhvcXRkMC9m?=
 =?utf-8?Q?ja/vhoaDYtroriI0shAjkd7hx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5C8DDA6A0AF9B489BA6D2E3D91FBA52@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5525.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe826942-d713-4b84-5b55-08de00a0b186
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 04:12:10.6076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9fuPPehIC1k9G4VPoxqMNonnn+ZSgyV0NQBkxeASkkLEDofVDsaEtJ41I8GLs908gYL8Mjvm5NdhrrK275V5GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF64191BB3C
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTA5LTMwIGF0IDE5OjIyIC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gQ3Vy
cmVudGx5IHRoZXNlIGlzIG5vIHdheSB0byBrbm93IHRoZSBURFggbW9kdWxlIHZlcnNpb24gZnJv
bSB0aGUNCgkgICAgXg0KCSAgICB0aGVyZSBpcw0KDQo+IHVzZXJzcGFjZS4gc3VjaCBpbmZvcm1h
dGlvbiBpcyBoZWxwZnVsIGZvciBidWcgcmVwb3J0aW5nIG9yDQoJICAgICBeDQoJICAgICBTdWNo
DQoNCj4gZGVidWdnaW5nLg0KPiANCj4gDQoNClsuLi5dDQoNCj4gK3N0YXRpYyBzc2l6ZV90IHZl
cnNpb25fc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICph
dHRyLA0KPiArCQkJICAgIGNoYXIgKmJ1ZikNCj4gK3sNCj4gKwljb25zdCBzdHJ1Y3QgdGR4X3N5
c19pbmZvICp0ZHhfc3lzaW5mbyA9IHRkeF9nZXRfc3lzaW5mbygpOw0KPiArCWNvbnN0IHN0cnVj
dCB0ZHhfc3lzX2luZm9fdmVyc2lvbiAqdmVyOw0KPiArDQo+ICsJaWYgKCF0ZHhfc3lzaW5mbykN
Cj4gKwkJcmV0dXJuIC1FTlhJTzsNCj4gKw0KPiArCXZlciA9ICZ0ZHhfc3lzaW5mby0+dmVyc2lv
bjsNCj4gKw0KPiArCXJldHVybiBzeXNmc19lbWl0KGJ1ZiwgIiV1LiV1LiUwMnVcbiIsIHZlci0+
bWFqb3JfdmVyc2lvbiwNCj4gKwkJCQkJICAgICAgIHZlci0+bWlub3JfdmVyc2lvbiwNCj4gKwkJ
CQkJICAgICAgIHZlci0+dXBkYXRlX3ZlcnNpb24pOw0KDQpOaXQ6IG5vdCBzdXJlIHdoZXRoZXIg
dGhlICIldS4ldS4lMDJ1IiBuZWVkcyBhIGNvbW1lbnQsIGUuZy4sIHdoeSB0aGUgJTAydQ0KaXMg
dXNlZCBmb3IgdGhlIHVwZGF0ZV92ZXJzaW9uPw0K

