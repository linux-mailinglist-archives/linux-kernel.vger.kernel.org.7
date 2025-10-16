Return-Path: <linux-kernel+bounces-855625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BC8BE1CBF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FFB6188E0DC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 06:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2E62E8B76;
	Thu, 16 Oct 2025 06:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J0ur+y17"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B162E7BBB
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 06:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760597173; cv=fail; b=QNQasswLAu4HeIFe8b2UeSunrNqqtzAfG7Tde1jcezG2MxJQkgTXqwPDkH2/p1u9Ut84UClqB20eMwtXDymuRCQbCDi5ZbOtAvom3NA6a0JXQo2StOl7KoOEXj2OnLQ1JS6106R3yicpa93bT4xBwf+WFWxso2sAC73xxBs7zk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760597173; c=relaxed/simple;
	bh=y3R0/hgryRom5Sj7C0Q7N0hyaFvN2JNoiOc0kwDEM9E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dBQ6zAuXb3SsM+oHOrcoYlUebreJUdlNIX7+ImAigrR49YE1HbLM8AbKf+p5eQxW2aHpOPJMnl0cAvfCpSrKBbKSNOkFHv/gPHwkKsJcnUZcsTeLRqW35P8dD03+nMxyhkezo45urEGpvbHMSI/P6MqV9/yWynnpyzzIKPYeZE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J0ur+y17; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760597172; x=1792133172;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y3R0/hgryRom5Sj7C0Q7N0hyaFvN2JNoiOc0kwDEM9E=;
  b=J0ur+y17/4Cgc5pQjMNr7fCThqL9AGaKFxxCHvSgYRg263NG6K29m5qa
   ygLWJ1M4oRlKcMjGt06e5rB6bu/CR7gqeWhBueJ8a7jMaEtiK4g8esqge
   sIMXnQVKtxLwoJ05j4jhk55Zd5wNLMOCKpcC8basIpYADTZa4vRdPcFq3
   gNoBC58irMAZX9+C0R24aV1O5dMSkLIIRpBASeHOh/2O3cnWqoowcCyL6
   NyR+pSgOIyp+j4d8+NoW7/e8iZJ6FgN697aCMbr0GL2xQ6QuuvxWzyOZE
   3JGKiG4biOFsxTaHPij2FyO19A0YhIWj6KY+MF9k+Nbd8+GWrwl9GkGW8
   Q==;
X-CSE-ConnectionGUID: cFHwusbZTSGOv11rGFBYug==
X-CSE-MsgGUID: T8JAYNyBQ4iKNMoPD3rdwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62711752"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62711752"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 23:46:11 -0700
X-CSE-ConnectionGUID: VTqhlRBPSi+Qy6p02Aqnnw==
X-CSE-MsgGUID: VdH4WJ8GR4Cfxq+UmNdpiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="186775526"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 23:46:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 23:46:10 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 23:46:10 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.18) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 23:46:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pA1Pu+GwNYjoINY7OjKNu7eP5FadQmW8IX6CR1NchGPoM3TH9mwGDtTDmu22cROQW1sdY8crtQWKaP1MhupQz/k7nZrUp8oFsX9KYS3L/ukq5a66azeoeB4P0tRUiafUJRfM7b5xn7IoGRV4wi40zeIhccd5TZqX25NViz2jSOe9OwqZ24ivUcDbSJ+egTlSG3YhDBH4WgNIbie4PBq1XFJbhi04FzW58t3n2Oq8arRvXgFDe1e9eu4WO6XnRASCiZJSVX/WCHqNwMnO17ZBakmOxk+pCM0rcWJoRAnx7tI65paqS7vwNFhf9TWfjBNWPH8T1T0TwynXoZkO3c/HlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3R0/hgryRom5Sj7C0Q7N0hyaFvN2JNoiOc0kwDEM9E=;
 b=a5uYj5t+yIfKddBBu5MZyCtJ3N4JAskNfBbguffbkD3Q6mTXG+QTL29bEQxZoHVwdAyPUTRllO16wl3C5/0X2eMAm41NZL0u8ROtGCkTVyRjjVWWdSr9OTQuF+y12OKHtRAtqzSkl011APArxTLsx0ehvF+hocT0kCBducOyopWEfLoBC6Hh1nITB+S+z3Z0sHdT2UrZZqyRXS+sHpkFJA/4hA+PuVCLA0ncHPInvx9IaPpleLEhJPc6P1w9jhLzBSBDbYxMpgPMyf/v6VZ6NvBRXxGky0TANGiX1bvVLULDJPYJNYVI40WKlGb0/4PlKZ6RwctQE4DgkymyqAwFCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB9495.namprd11.prod.outlook.com (2603:10b6:208:59f::17)
 by CYYPR11MB8330.namprd11.prod.outlook.com (2603:10b6:930:b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Thu, 16 Oct
 2025 06:46:07 +0000
Received: from IA1PR11MB9495.namprd11.prod.outlook.com
 ([fe80::fb49:1b0e:8ebc:254e]) by IA1PR11MB9495.namprd11.prod.outlook.com
 ([fe80::fb49:1b0e:8ebc:254e%4]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 06:46:07 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "Annapurve, Vishal"
	<vannapurve@google.com>, "Gao, Chao" <chao.gao@intel.com>
CC: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>, "Huang, Kai"
	<kai.huang@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "sagis@google.com"
	<sagis@google.com>, "paulmck@kernel.org" <paulmck@kernel.org>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov"
	<kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH v2 00/21] Runtime TDX Module update support
Thread-Topic: [PATCH v2 00/21] Runtime TDX Module update support
Thread-Index: AQHcMn7PzLsl5dUPTEikD7KJ8NM7q7TB2pCAgAEhGdCAAGjNAIABBY7w
Date: Thu, 16 Oct 2025 06:46:07 +0000
Message-ID: <IA1PR11MB94955392108F5A662D469134E7E9A@IA1PR11MB9495.namprd11.prod.outlook.com>
References: <20251001025442.427697-1-chao.gao@intel.com>
 <CAGtprH_FzXjnC0Rbctpvm2_kqAAnUOfnaT4885fBiAi7s0jcXw@mail.gmail.com>
 <IA1PR11MB949522AA3819E217C5467B51E7E8A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <5b4c2bb3-cfde-4559-a59d-0ff9f2a250b4@intel.com>
In-Reply-To: <5b4c2bb3-cfde-4559-a59d-0ff9f2a250b4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB9495:EE_|CYYPR11MB8330:EE_
x-ms-office365-filtering-correlation-id: ead3440b-e292-4250-5916-08de0c7faf10
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bEdJcEdBaHI1T1JGZkUyMnhYSU5xNUNadDNkS2VRdjdmaTY3L0lXNjVYZHNv?=
 =?utf-8?B?Nkd0ODFodm9RQmppbjFKSnJsMVJXVjBZWW0vaXpucnJFdWhLYUZhQmR6SmVr?=
 =?utf-8?B?OU1EK1JScHh6SFNxdi9tUDJmditTZWhsdC80Y2Q1eEJDcUMxd2JOTWRKOTUv?=
 =?utf-8?B?NkJUVytXR0lDMitSUUlubStSbHdjdG9ITVM0aVpJaFJ2c3VKWU1RQ1JxUkdG?=
 =?utf-8?B?TFVFSUErMFFkUkJ0T25VZVpGY3d4V3U3VkRXbzB0N2hod0JFYm5ZUmJYZWk2?=
 =?utf-8?B?T1NmTTVoUWRYYXk0dXVyVVVHajgwdHZwRGlWM2tvZlhTVjZDKzhPSHlxM1dO?=
 =?utf-8?B?VXB0aGRaakp6QXBwb2JpWTlSeitqaHI0S3RncFQxNllGd3gvNzUyRHo1S2hv?=
 =?utf-8?B?ZldTdklKaGNIUWZDRVBvN2xaT1E0dzZKZ0dQRWRPR014YTZGQkpESkFXVTRS?=
 =?utf-8?B?dnF1YnIvQkkzcVFyTEJucHlIL0RMaGVmdThaZmlxalhNR3o2WUFvSWpPWjRn?=
 =?utf-8?B?TDNZR2xPQ0k1bTFTWExvWUVsY25JV211TFZpUXNPb0EreGZnbEc3YmlLWnRY?=
 =?utf-8?B?eGRIMGQ2YnZ3VE1kNU5mbWFsQmVCZ3U4bDdZekpleFh5OHRNZmVNMWtxQUFR?=
 =?utf-8?B?dUFMSUVLdVNHUTY5UzZJNEJ5WkpXZjZpOHFMSFhEM3lhY1U5eTZYQXkzZlYv?=
 =?utf-8?B?TWt0cGR3ZE8yV0c3MEFuTmx3L2w3Sk9oTHFiRnJxSCtheWlXVjJBbnI3TEpW?=
 =?utf-8?B?QmF3cW5Nd2NRLzBsalJkeGZyTkNYZlNCVTB0RnA0Uzd4cnJDMUIxZm5aSnYy?=
 =?utf-8?B?MDJOSlNBdStVZUUxTzhsaVhxRW5BYkpYdFc0Z01USTFOVXlob1p4c1hMeHRa?=
 =?utf-8?B?U0prb0hkUzNLdCtNaTVOQWhtU1dPaUl1QUdMdzU0b0JqcE5aRGZ3OTBsREh2?=
 =?utf-8?B?bFI0ODdMd2dXTlUzb044VER1cUVKL25pbEl0WlZjTHJRYWdhYmUxRGJLUkh5?=
 =?utf-8?B?VzFqcVBzemFmSU9PVStMQVk1RGtxdWdTV3I4eFo3eHc1Q2lBYVpCU1pzOTNZ?=
 =?utf-8?B?TTQwNXdoU3lFUm0ydUE0ZkRqTkF0QmdoMVhEQzB2WHpwTlVBUE9zUjZ3MG1W?=
 =?utf-8?B?V3NxdGdQWGpGVi96a2dEenRsVU9oMitGUWJ0UE00ZlZwZUFGZnFqQTljUWxj?=
 =?utf-8?B?NHV1UDNsNC84M2UvUTd5dC90T0Q5N25SZXpZSEJVbWE0TWU4cE9aak8vOVg2?=
 =?utf-8?B?KytTUWljajYyVFB0NXJIc3NKeG14MUI2ZEVRRXVsWmFnWVp6anVBcllxdnNw?=
 =?utf-8?B?WTZFaWwxS0FhNTRLbkw3NjQxMm0vTVpQTWcxcmNqalMvaEdrQlJ6TW1uZDly?=
 =?utf-8?B?ZCszYTVJaE1TT01BeUttaFVkVmlqRHRjY1F2SWZpWlRLUjltVlJRbFEybmtE?=
 =?utf-8?B?QW5pVnl4Y3BETlNDTXZTSmVablkvVEl1ZlVFZEhRSG9wNGFocFJCbURLZkJY?=
 =?utf-8?B?TEVNeGtTcVFRZEVEc0Nad1VubUtpdi9yZTJGcUlxZWoyRk40a0lUUkxMeEV2?=
 =?utf-8?B?dUEvby8wOGhYamhOa0ZsMW51bmViZ21ZdVR4d2dlQUtYU3FHSjUvOUFsSFlC?=
 =?utf-8?B?alM4ZkdJdjh0UE9SOGs0b0tURWI5dDliMllzVUliblMrUTVRZEI5VUpRZGZE?=
 =?utf-8?B?dFhaTllNcXVkSHduUENqRXZNVlBMRWVhZDRrWC90TDFWS3RWT3VXQTcxK2lI?=
 =?utf-8?B?YWpxUDBkYUdlQTZXWmxXQXZZSXBtckVNQ2cvVGpDS3lpVkRwR3lsTHZiZVh4?=
 =?utf-8?B?blVIcndEUTJ2M1VqTDFjWUtkVTBzS2MzRzlUNjNtOXJoTGtsaUsrNFdwYVRS?=
 =?utf-8?B?V0VSbG5icDhXb0JyaHAxSlVxODhkL2JtTlQxY3JDL3Zuc1cwbS9XbTRQWlZE?=
 =?utf-8?B?eG1VTTNOS2V6L2VqY3lIMEVINVdObmI0NitZNFRFWkdPa3F4MmRRRkdxcHMz?=
 =?utf-8?B?Wjh1aW14bGNtY1REb2FQeUQzbThGaGwzKzVmcVBhNW9EbE4rczljOE02UU9G?=
 =?utf-8?Q?SsDMsr?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB9495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QS9kVzdxdkg1ZTBiR1FDWE9ZNkJOeHZMSklaVmJPVUdFemVTL3pYWTdEQW15?=
 =?utf-8?B?Yzg1ODVnNDlOZkJOeFlld3RacndTYXE0MzBPelJza2tra3NiUFFrQkdvSmNi?=
 =?utf-8?B?TmFvTG53VE8yWS9hVVhBbW41Z2xrL2hOWllpRTNYRmttdWphWmhpK0RiSVQ4?=
 =?utf-8?B?KytJRGlIUHU2NlFlcUJXVG5FSVpEVzlIMk9ha20wQXJiaWFHTDVnc0ZIdTN2?=
 =?utf-8?B?clY0T0NNaWNLMndLV2haaDM1dnRuTUEwYkpxS0tHV2ppTG82UHJjZWsyOWpB?=
 =?utf-8?B?QmdYNkNWQ1dNa2UzVmNUYzBBdXBsNko3ME9EZlBnVExoNEdhYXlhenkxWG01?=
 =?utf-8?B?WE5acldYbFI4UXV6dlFkemJBUjBSQmRzQWZQdW5tdWZ5cSt1ODY3V1Nmb21U?=
 =?utf-8?B?WEZONm8wazllM3JjNE51eXNMWmIwSmFQNzVjUGZSWnYxV29JWDY0N1g4UDkr?=
 =?utf-8?B?OU4vaEt1LzlJTFE0cE11RHpPM1BKcEx4VS9Ja2RhSHFxQWRmVXJvaGlUY2xP?=
 =?utf-8?B?VGVrUEVjUkpYRU9TVjdRNnBlMDB4dUdiUnhaZEo2dzkxeW82UmtwTUNpdDhr?=
 =?utf-8?B?NjlTQ0xpd21GSnFZT0VIRWZ5ZlQxbkhRdjJJQjhOQ2pxOUFLVzhCM3lhdXhN?=
 =?utf-8?B?bEVmczFIY2VDVUVkdElEWmFTT01hZllaNnNlVU90TTN1QVVQUk5nL3haSVRz?=
 =?utf-8?B?WDIrNTNydEpDN3JncVhxZEVZWlk2T2NFdUpNTDd2VEU2bGR0akMzeXFlUTBE?=
 =?utf-8?B?Zkl4RzVaRERKUmZucmhUTkFoVXBWMVgzQzdod1JUMDBxUXY0djlabWlYejQ0?=
 =?utf-8?B?SHRla1loVnRhNzdLSnRJakp2TmRkOTIvdU9NcDlrY2FyRXFQdnpCb1ZGcHVS?=
 =?utf-8?B?VjhLei9DUE9qU1pUMHAzdk9JbTlxR0FSUnlacXZsSWNpeWFvWm9lQlNGemFp?=
 =?utf-8?B?akJGTXZSaXA4QmFUbXdIZEFOUllUWWtmdTlsQjVNRFVZU1hPUXIxSWxUWjNF?=
 =?utf-8?B?aUFIVjNPUEJZa2FKY0g1QVBpT0tROFp1ZGZXV093TjJ4d2pxcTY3Rnc1S0dT?=
 =?utf-8?B?NVJlTHdiaS9zZUdRWlRXRzVIUHJFTjY1RmpyeEg0dUVPeEp5UzkwMWxjOS9H?=
 =?utf-8?B?ZW1mWk9WbWlVYy9IY25sU29sVTlwblhjWnNTRCtwVVkvVWJBWFZoMENkdlVr?=
 =?utf-8?B?NllnWHAzV2NsVnZOY0NEZXRQY3phZnhYWVNmSDhMTWhKUXFRVDNjQ1hka1py?=
 =?utf-8?B?eG81K2wvQ2ZPMkNFc3ZiRjRuaHNGZkwxM3pybzZNUFdtZklxYkRUTmt3OHpu?=
 =?utf-8?B?R1M4V2dJd1dXa0EyVzJwYzNjSWNtblBRS0VnN3M2YkQvRyt1NzdDbHhFRjhB?=
 =?utf-8?B?Q0llRkRRVjRmZkE2dms0Y1FrSUk2RVZrSjFYL3dnZ0hyUHQwTVNadUxXS1g1?=
 =?utf-8?B?RU16N1pXaFZ6ZE5BWU5MQzA0ajVQZy85VkRKaTAvNzZ2UEE0UzlMZFpzc2FB?=
 =?utf-8?B?aUZiTWk3dXNweXZNQVg3Q3EyQlJWY0EvYkNMaSs5NkdYSFVZeWpMRmNRU1Q1?=
 =?utf-8?B?Q1RXR0NROUFScUROVGJvM2d6eXV6dXIwTk4rUlBJbjVIKzhicDcwbjBIY1NH?=
 =?utf-8?B?NmtJVi9GRnBFcG5hWWRJZXloUTA1cEpUVVFSQ3FKbWNhMHIxSkU1cVNrc3ls?=
 =?utf-8?B?UDgxcnFrK3FEWFpXaGMzZHdaMDhyb0RlTkFEYmg4Q0lxdEVrRUtFaEtoRlR1?=
 =?utf-8?B?ZHVhLytFUEVsbXhWUnZHd1VBaTJCdU9ieW8wWTlkZXYxY2pKZS9lcWx6R055?=
 =?utf-8?B?ZUkwek5iYms0QXlLc29PQU84UmhkUCtCKzV3WGFUTHVldjZSa2ltbEJLaWhN?=
 =?utf-8?B?UFVKRHR2VW04ZGYyWjd0dEo1anVKRWZSamlwUThoK1R1VjQ2UDZIdEFsTFhR?=
 =?utf-8?B?ejdKNFREaHVDcWFBellHWnZkSW9DRVlUdzVUalNwTFJXTkRFenBmOU9UbzdN?=
 =?utf-8?B?TXNPUEFWaUsyblc5N3pYM3VlZk9zRGY1TFFVek5rZUx6NmdzZDZlaEdZT1NC?=
 =?utf-8?B?dHprSHcyR0wyMjlMRlU0Vk5hYisxZFJnRk82aGFjY3pyaVEybjVTRVhBZHMx?=
 =?utf-8?B?aGdIYkZ1Wk5ocy9sMnowQVV6dXBRbWhXR3piemJWc0NsUzV1ZlAzVlVQd1M3?=
 =?utf-8?Q?OWVMrUXFuc7fws0odLHyaYXqh828CNmAx2TGVbAjv8oq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB9495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead3440b-e292-4250-5916-08de0c7faf10
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 06:46:07.0148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +cK2hjtTNTU2aF0LCNYCpp5IpgnB3MttG8oKjAGy0P3pVtjr4xXGBQqsVlVIKnPgBBTaTD418Cn4F+mRVtXyh2WhykZXKJbt3eLO1aScsHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8330
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGFuc2VuLCBEYXZlIDxk
YXZlLmhhbnNlbkBpbnRlbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAxNSwgMjAy
NSA2OjAzIFBNDQo+IFRvOiBSZXNoZXRvdmEsIEVsZW5hIDxlbGVuYS5yZXNoZXRvdmFAaW50ZWwu
Y29tPjsgQW5uYXB1cnZlLCBWaXNoYWwNCj4gPHZhbm5hcHVydmVAZ29vZ2xlLmNvbT47IEdhbywg
Q2hhbyA8Y2hhby5nYW9AaW50ZWwuY29tPg0KPiBDYzogbGludXgtY29jb0BsaXN0cy5saW51eC5k
ZXY7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHg4NkBrZXJuZWwub3JnOw0KPiBDaGF0
cmUsIFJlaW5ldHRlIDxyZWluZXR0ZS5jaGF0cmVAaW50ZWwuY29tPjsgV2VpbnksIElyYQ0KPiA8
aXJhLndlaW55QGludGVsLmNvbT47IEh1YW5nLCBLYWkgPGthaS5odWFuZ0BpbnRlbC5jb20+OyBX
aWxsaWFtcywgRGFuIEoNCj4gPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT47IHlpbHVuLnh1QGxp
bnV4LmludGVsLmNvbTsgc2FnaXNAZ29vZ2xlLmNvbTsNCj4gcGF1bG1ja0BrZXJuZWwub3JnOyBu
aWsuYm9yaXNvdkBzdXNlLmNvbTsgQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+Ow0KPiBE
YXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPjsgSC4gUGV0ZXIgQW52aW4N
Cj4gPGhwYUB6eXRvci5jb20+OyBJbmdvIE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT47IEtpcmls
bCBBLiBTaHV0ZW1vdg0KPiA8a2FzQGtlcm5lbC5vcmc+OyBQYW9sbyBCb256aW5pIDxwYm9uemlu
aUByZWRoYXQuY29tPjsgRWRnZWNvbWJlLCBSaWNrIFANCj4gPHJpY2sucC5lZGdlY29tYmVAaW50
ZWwuY29tPjsgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjIgMDAvMjFdIFJ1bnRpbWUgVERYIE1vZHVsZSB1cGRhdGUgc3VwcG9ydA0K
PiANCj4gT24gMTAvMTUvMjUgMDE6NTQsIFJlc2hldG92YSwgRWxlbmEgd3JvdGU6DQo+IC4uLg0K
PiA+PiAiUGVyZm9ybWluZyBURCBQcmVzZXJ2aW5nIGR1cmluZyBhIFREIEJ1aWxkIG9wZXJhdGlv
biBtaWdodCByZXN1bHQgaW4NCj4gPj4gYSBjb3JydXB0ZWQgVEQgaGFzaCBpbiB0aGUgVEQgYXR0
ZXN0YXRpb24gcmVwb3J0LiBVbnRpbCBmaXhlZCBpbiBhDQo+ID4+IGZ1dHVyZSBJbnRlbCBURFgg
bW9kdWxlIHVwZGF0ZSwgYSBob3N0IFZNTSBjYW4gYXZvaWQgdGhlIHByb2JsZW0gYnkNCj4gPj4g
bm90IGNvbmR1Y3RpbmcgYSBURCBQcmVzZXJ2aW5nIFVwZGF0ZSB3aGlsZSBURCBCdWlsZCBvcGVy
YXRpb24gaXMgaW4NCj4gPj4gcHJvZ3Jlc3MuIg0KPiA+Pg0KPiA+PiBEbyB5b3Uga25vdyBpZiB0
aGlzIGlzc3VlIGlzIGZpeGVkIGFscmVhZHk/IElmIHNvLCB3aGF0IHZlcnNpb24gb2YgVERYDQo+
ID4+IG1vZHVsZSBmaXhlcyB0aGlzIGlzc3VlPw0KPiA+DQo+ID4gSXQgaXMgbm90IGZpeGVkLCBi
ZWNhdXNlIHRoZSBsaW1pdGF0aW9uIGNvbWVzIGZyb20gdGhlIGludGVybmFsIGNyeXB0byBjb250
ZXh0DQo+ID4gbWFpbnRhaW5lZCBieSB0aGUgSVBQIGNyeXB0byBsaWJyYXJ5Lg0KPiANCj4gRG9l
cyB0aGUgVEQgYXR0ZXN0YXRpb24gcmVwb3J0IGNvbnRhaW4gaW5mb3JtYXRpb24gYWJvdXQgdGhl
IFREWCBtb2R1bGU/DQoNClllcywgb2YgY291cnNlLiANCg0KPiBJc24ndCB0aGF0IGluZm9ybWF0
aW9uIGluIGZsdXggZHVyaW5nIGEgbW9kdWxlIHVwZGF0ZT8NCg0KSWYgeW91IG1lYW4gdGhhdCB0
aGUgYXR0ZXN0YXRpb24gYWZ0ZXIgYSBURCBwcmVzZXJ2aW5nIHVwZGF0ZSB3aWxsIHNob3cgYSBk
aWZmZXJlbnQNClREWCBtb2R1bGUsIGl0IGRlcGVuZHMgaWYgU1ZOIGhhcyBjaGFuZ2VkIChpZiB5
ZXMsIHRoZW4gaXQgd2lsbCBiZSB2aXNpYmxlKS4NCkJ1dCBJIGZhaWwgdG8gc2VlIGhvdyB0aGlz
IHJlbGF0ZXMgdG8gdGhlIHByb2JsZW0gd2UgYXJlIGRpc2N1c3NpbmcuIA0KSGVyZSwgdGhlIGF0
dGVzdGF0aW9uIG9mIGEgVEQgdGhhdCB3YXMgYnVpbGQgZHVyaW5nIHRoZSBURCBwcmVzZXJ2aW5n
IHVwZGF0ZQ0Kd2lsbCBmYWlsLCBiZWNhdXNlIHRoZSBlbmQgY3J5cHRvIGhhc2ggd291bGQgbm90
IG1hdGNoLiANCkl0IHdvdWxkIGxvb2sgbGlrZSBhIHJhbmRvbSBmYWlsdXJlIHRvIENTUCwgYmVj
YXVzZSBWTU0gZGlkIGV2ZXJ5dGhpbmcgY29ycmVjdGx5DQooYnVpbGQgYSBURCksIGJ1dCBURCdz
IGF0dGVzdGF0aW9uIHdpbGwgZmFpbC4NCk5vdCBhIHZlcnkgZ29vZCBzaXR1YXRpb24gdG8gZGVi
dWcuIA0KDQoNCj4gDQo+IC4uLg0KPiA+IEJ1dCB0aGUgc2l0dWF0aW9uIGNhbiBiZSBhdm9pZGVk
IGZ1bGx5LCBpZiBURCBwcmVzZXJ2aW5nIHVwZGF0ZSBpcyBub3QNCj4gY29uZHVjdGVkDQo+ID4g
ZHVyaW5nIHRoZSBURCBidWlsZCB0aW1lLg0KPiANCj4gU3VyZSwgYW5kIHRoZSBURFggbW9kdWxl
IGl0c2VsZiBjb3VsZCBndWFyYW50ZWUgdGhpcyBhcyB3ZWxsIGFzIG11Y2ggYXMNCj4gdGhlIGtl
cm5lbCBjb3VsZC4gSXQgY291bGQgZGVjbGluZSB0byBhbGxvdyBtb2R1bGUgdXBkYXRlcyBkdXJp
bmcgVEQNCj4gYnVpbGRzLCBvciBlcnJvciBvdXQgdGhlIFREIGJ1aWxkIGlmIGl0IGNvbGxpZGVz
IHdpdGggYW4gdXBkYXRlLg0KDQpURFggbW9kdWxlIGhhcyBhIGZ1bmN0aW9uYWxpdHkgdG8gZGVj
bGluZSBnb2luZyBpbnRvIFNIVVRET1dOIHN0YXRlDQoocHJlLXJlcXVpc2l0ZSBmb3IgVEQgcHJl
c2VydmluZyB1cGRhdGUpIGlmIFREIGJ1aWxkIG9yIGFueSBwcm9ibGVtYXRpYw0Kb3BlcmF0aW9u
IGlzIGluIHByb2dyZXNzLiBJdCByZXF1aXJlcyBWTU0gdG8gb3B0LWluIGludG8gdGhpcyBmZWF0
dXJlLiANCg==

