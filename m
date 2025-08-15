Return-Path: <linux-kernel+bounces-771166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5A9B283B8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C392AE4E09
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABFA3019C5;
	Fri, 15 Aug 2025 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jXeNSx8t"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E9119E975
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755274763; cv=fail; b=aVOfS4agRVLb5xCfriMElw1zgC3O+KcOZ8atbKZ+ATmNY/nAAAWCgaLnTMI/6vbxsltyosZonKKSQZPwS+Cdw/5WxkvTGRAwR3nXrtuzyYdcwQ7c06GHxniAX6l96h7XzGOB+b7c9iOutQT2gIpFskQL4dkj5A53Qqt5u+dyJOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755274763; c=relaxed/simple;
	bh=Y0gF5oGHF0UQdPj6dqbrkLYBECvB2Jhoe5X7/lC6leI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E7PkmmJB+W2b+TSvtuZewts3iOrYXUBGKtyWn0buC9vQC0lJwU/YX1QLENtLt+FsDow5uRJERkCqjOWXuIQKfSDuUSvEFx6JWmOjRoCyWPYHc8Omk9W54EqMOluzWX8N/kyWglG0xMieuK9cMV0qs8z4ms7gCg8YvQnXd1cAhRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jXeNSx8t; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755274762; x=1786810762;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Y0gF5oGHF0UQdPj6dqbrkLYBECvB2Jhoe5X7/lC6leI=;
  b=jXeNSx8t8Xrj8vod+JBiZsdHADkV9WLp08fHI8nJxoWc6sSOKlACuSAn
   Up92MCfcVgZbW7YIX6dtbAl/8w2HQOeTxvwx6fVrcznDpSeV2pGoQoebn
   hRsi5JgmudBhUAmYwgJeGov2/LGnim56rWQyjfXfjJ/D6DHjPwNn1lnbj
   jWtWxxiLOrMdqeHdeC4oBEGNs9P78iX9TOJBsND4A6RMOfYKzqUgpIhAz
   l3oKOm8GfQt2H3bTUDFjJWqzXBdf3c8OILIg5DcHLzHAOH4yqzt73b3TR
   rAZtX6OshliICJABOKoDHpcpYxJYV03aGqXtvGICbyg9Z/OQRHg01Ancw
   w==;
X-CSE-ConnectionGUID: FnG+IxcmS3KVOOYKodYUZg==
X-CSE-MsgGUID: X4q1ln6PSha9N4FfELJhOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="69045628"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="69045628"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 09:19:21 -0700
X-CSE-ConnectionGUID: MwLOBoqqTEmYUrxiEhW5rg==
X-CSE-MsgGUID: PgOG8iiRS+2V8RGEJi5/RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="171294676"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 09:19:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 09:19:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 15 Aug 2025 09:19:20 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.40)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 09:19:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5hxN/i/rXqBRyuZIv4xSPbocl1Fooy/2uiMP4K9pqfF9iORrx/v4AmDyLWKkGFKX14Ff17ZDt1kjl3yFN7YokJq050wX7DAPfkA4+LhxlOLq27shMNyQiBM3kQF2GVrkERaUYQe2E+zDGZj0PDELYgd9SUVuacNqR8W9ivHmpO68GG5jvrMZO75lqLvuv24370rK4fxLZnvlO7q+7VMXSRbJHTpKSMg4EgVfjZJQjcNx1R8F5KOIKVPd7/7y5902q7s2C3tET+YtG1Np5xJnGNFimXR508irT8b0CH/7eKFqRJ5XBGLuGmnqEEGf87B4MtJ39rV3h1L2mBYkx5S3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0gF5oGHF0UQdPj6dqbrkLYBECvB2Jhoe5X7/lC6leI=;
 b=PIiobtPqwDlQ0oabYmt1ML/3d5wvupF6YyPJLR3qsGlpv74TRl+qdH7H/oziOhOztNkutGdoFJZnM2jQzYoh1B8Gv5GyA4K3pFz2kHyiZYMtXL1it5sdvflm7Tab2QrRey0h1JgNS/jjG7OXSu1Eo3PAj3ag5oF26UTwgi6+2TUZa49WZtXRiurVSpRa5GISBJG/f1fiSN/E1HaYErIkR2oz1hgKCXp1voJsQHFf1NLMJ/yX2kG8AZm5OKzdPqTrXC2F+s+r7FKYMzY6wRYyqw2y53rczFzYwnWMf7yqAZLZNf1G9gfp8E8ljrQLTd5Wxm60Y3zN63DWI3MASGT7hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SN7PR11MB6921.namprd11.prod.outlook.com (2603:10b6:806:2a8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Fri, 15 Aug
 2025 16:19:18 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 16:19:18 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "oleg@redhat.com" <oleg@redhat.com>
CC: "debug@rivosinc.com" <debug@rivosinc.com>, "mingo@kernel.org"
	<mingo@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"peterz@infradead.org" <peterz@infradead.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 5/6] x86/shstk: don't create the shadow stack for
 PF_USER_WORKERs
Thread-Topic: [PATCH 5/6] x86/shstk: don't create the shadow stack for
 PF_USER_WORKERs
Thread-Index: AQHcDQSAsgd3KMgRVUK3LV4xePzdnLRiYLSAgAFCR4CAAEOtgA==
Date: Fri, 15 Aug 2025 16:19:18 +0000
Message-ID: <cf6441dca8fe5d7c568d01e43adf715e9a35a9ba.camel@intel.com>
References: <20250814101435.GA17362@redhat.com>
	 <8818b456954644ce609e07d77a65714788ef9098.camel@intel.com>
	 <20250815121702.GB11549@redhat.com>
In-Reply-To: <20250815121702.GB11549@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SN7PR11MB6921:EE_
x-ms-office365-filtering-correlation-id: a898c280-129a-49cc-e668-08dddc177c27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?b21hQzdDUStUeWxSVzRxUGc4QTdSc2xmTEJIQkowTVVXOThqWGlCR3YwK01V?=
 =?utf-8?B?dUdKSUNYV1Y2SDRQZmUzV2VLcnJDTmZoOGxqZmdNQnNJakFHb3Q1aXlxaUdE?=
 =?utf-8?B?V2ZobXBSQ3BRU3VSbm1LMjA5RHpWWk5RczZzRHRHQjAySXNHYXVFTmVqeSs0?=
 =?utf-8?B?bWVHaDU0eVlQWXRpclBwdGdiNFBObjlRNWpJNGF1LzFzUUJpaVJDdnpxR3BB?=
 =?utf-8?B?QjhybW5kS2U1UWdJV25yWnBIZ1ZsWjBXVk1UdENQb0s0Z1BXRlVTeXZNajda?=
 =?utf-8?B?cXh1WE5iMHc2QWZTajNiQkYzbHVFaU1PdjFRbVF0L0lqTlNMZGhtaUJoY2FO?=
 =?utf-8?B?RDB1ZGRsQk1lUk1jR3Vwd2ZCaUdZd0VqemRsL1VYQzl4TDZrVEovM0NiS0dm?=
 =?utf-8?B?SFl2MlJocnpMU3psdE9BclgyYTZPMUpWSXRyaXdpQVJMb0tHV0pWdkhkVStS?=
 =?utf-8?B?blkvMXlpT3RpSnVhazdEM2ZlYjY4WXloMUpURkNNTU9pS3JyNDlZVHdNUjNl?=
 =?utf-8?B?Nm5zTFlIMkFCb25MWGtPYVZlTEs2WEYwWEU0Mks2WC9JK241Vjl5SS95dis3?=
 =?utf-8?B?Y1hsYldLMy8rTS9GVURrLzRXNkUzMzV0QndtZHVsSS9yNlRhaVpNaHJrRzhM?=
 =?utf-8?B?ZFk1dFZhYXlMMGEwUVBNMHpMVnhQdVhtOVpDZzhaTkZFRUROTE1uRDlSTE1H?=
 =?utf-8?B?Um5mN2tqanVWUkhjZVJDYkFoWGY5V1VIY3ZCcDJXUGNaalBFMThMSHBLV0JJ?=
 =?utf-8?B?MjFtOVRqeWU4Sm5pNmg0QjIyOVJEOEZHRkR4b2FPSTEyeVZBclpTOWF3YXA5?=
 =?utf-8?B?OXBWT2dKME41K3V0aG5ZZjgrakZNMFJQamxaMnJhRFR4WG1LRVFZRGRPczV1?=
 =?utf-8?B?elZiMWVuMnBOa2dGUVAwdXdDcGM4Y1RLZkQ4bmlhb0JwZ1hjVUs2eVQyNXNm?=
 =?utf-8?B?ZzhWaVFReDkrenNDK1ZPNlVSYkxOTFJSa3lJUkowYVhSLzZnVENRN3ZyNDE0?=
 =?utf-8?B?WEpxcGFiSVFDWDcvN1dkb3lDWjR4aEUzb01oWnR6aHR1ckJLSmhjVFV2dlg3?=
 =?utf-8?B?OG9hM3VjRHNZS3FwR0tMbFd3VzJSYVhjVURIVnNPZmZ6NjAwUXdMaEFEVXhm?=
 =?utf-8?B?MFNnZXE2dmJmZllVSzN3Q09yS0NqeXd2cFcvSG91RHhpRWk2NHEzSm5NcXky?=
 =?utf-8?B?UjIwamZ1dzgyZGNZcm9CRHhCUTU4dlJvWENFeWxPM0Y0aTJnckpKMFkrcHdk?=
 =?utf-8?B?NGRtQmd3NjlHd1h3bDFROWFCTFFkY2FyYUhweVRZMmJWTzQ1VmlpNWhEVnNR?=
 =?utf-8?B?TDlkYTdQckRSV0I3VUV1Vi9rOUwrZGMwZ2ZVRmhGRE5LTVdzNkpUZVhoU1Aw?=
 =?utf-8?B?MTQ0eWo3WjZ0YUdmaUVuMGVVZitRVUc3QllXSVd3UEE0T012SVJ4OTB0dmcw?=
 =?utf-8?B?TUpKUEJSYmpuZWl0b2dUVkhtVkwzelpZUTJkMzVFYlYrZ3hQcjZleDdRelNQ?=
 =?utf-8?B?K3RPQjBXak1ET3BmZ2hDK25oYWd2NnRscGE3eWEzOU5JVzhRNklGbldBek9Z?=
 =?utf-8?B?dkNhemlZbTJ6My84VE1OR1BwOG5Ea2VraXl1YVFLcDJvY01UQU9UdW55Qnpt?=
 =?utf-8?B?UHdINjJrK2kvcTlmTXlGRDJjZjBwU3ZVdllhNkJUMkVNbUJMNjVrbDJMYnFT?=
 =?utf-8?B?cjdiNGhPcTdRbzd4VUdUQkJTc0tEOUxJV3pab21xdjZ6RytFdERoK1Rqc0w2?=
 =?utf-8?B?L1Z4Y2tNTVpnekk2NVp6enByVmRmUVBQclVaT1czdlBwQUYvSzNJcm0ybmEw?=
 =?utf-8?B?TDg5dkZudVloZTl3RXlSQnFTN1U3UkFZckVYVksxOWR1d3NYNXZNNVNzWm0r?=
 =?utf-8?B?eXlhVzVoNkFuQXlUZDlhUGZuL01oSUczN3VmbEk1a1NsdnlkT0hxNGp1cnlh?=
 =?utf-8?B?ekpucmVwcHV0Q2pnUkREaWNUL2Z1RkJBb3gyM29BV3BpNGJWZjBHaFhud1o0?=
 =?utf-8?Q?Psios8QYKzk0jcrVwM/+AiaetkB2Zo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXpUbnZFeDEvVGk2RHpwQ2prUlM5R1l0SUVxd0dXYW5PNFQzYTZ5K0YzYll0?=
 =?utf-8?B?NTAxMVVxamdNaC9LaGRiSEZicTFKM3ZBV3Z0ZW9zNHNkWm5DdXZad3pJM1Fx?=
 =?utf-8?B?MHRBd2ZLOG9FSlIyQVZLWHluRTZoekZSeGN5bGJsNCtiR21YZm9kUjI2M1RG?=
 =?utf-8?B?WWoxZ1BMRWt3WUQ5MlZuVW5RaUxoVVh5VmlJN2J5djVNUWpEODd6ZHlMaERP?=
 =?utf-8?B?dFpmdHJFTUhLVXlmMmYySlBXalpwZ1N2M1B1ZzJWcHB3aklBcVhEK2NnTFd2?=
 =?utf-8?B?VjRUbnhyNC95Z3h5ZEpPOUFCeUdOcm9kN3gzNWlhUXYzekZzR0dFNElKQUFi?=
 =?utf-8?B?NWJOSk5RNDRwWDQ4c2gzOXV2UU83MFRySGxqTFFNTE1SRHQybUxudVNyUEox?=
 =?utf-8?B?dmJPUXNiS0VReFllaW40QkJPL1NTVUlZOUkwclArK0ZhaElnZkZpalJ0ZmZU?=
 =?utf-8?B?RjdMTE1MT25SSGpRUWFPVjNqdGdnOFVvdElyRTJtWWRHa3VSQ2dKNzB0Slds?=
 =?utf-8?B?Y0c5cjE0dmhlQUErdXRCOTd0Z3ZFb0sxL2FMcTM1Tlc5OEk4SVNiWHBlbWxF?=
 =?utf-8?B?ckI0SW9nalZuN3h6UkxlTWZmWDUrbzNSZUtTdHdLR1JyUGFjcjE5QXoxL2kw?=
 =?utf-8?B?Y3kvbTYwMzZNRUo3MXR4anNrV2Jxa0cxb0FZUW9KeWpQTitCTVVvbmIwRzh0?=
 =?utf-8?B?bWxTbi9nc2twYS81L3dZYzJzSWt6MGI3anJnYlRRUHFIZTh3U0pxZUFXRzhm?=
 =?utf-8?B?MkpkMk10SnAzSnJWTFZmZm1pMHpmNXhIUlpvM2FpMC8raW9iOGJMaXptZGc0?=
 =?utf-8?B?a1Npc0lLQmtQbHdsUlB5Zldlb0dZYXpES0dTSGl4cFRkUDl5MjBxU1A1M1dE?=
 =?utf-8?B?OVYwK2NvVnF3M0t0OUtWcVc0Ums3dWgwTEJ6THYxZlBjMDZFV29ZdlBLVnVS?=
 =?utf-8?B?S01KOVRSb3ZNTVJsVm5DSHhMcnYzWk1ieHNjYloydGpiWFpia2NVVlRjNHJU?=
 =?utf-8?B?cjZCMUEyRFJ5VndVOGk0b2Q4M2tQTUY1OWVyKzNjamFJdmFmSjNMQUZDY3F0?=
 =?utf-8?B?WmJNRFhVMnkyTDNxaHlLZHJ1Yk5PMVRzcDJGZjZoY296aXV2Ym0xdStna3g1?=
 =?utf-8?B?aVlqaXR0QlVGcjR1RUF1OGN5SE5tUlpnakt5RndDRlVUdTY3R2xtOExmMXlH?=
 =?utf-8?B?amFHV1U0UVF2NG1XWEx2UTdMVVdMMDAxOXpyOWVORkFDR3BpdUpxZXp0VUpy?=
 =?utf-8?B?MmQ2UG1lbHVyc05RV01rSDZJenhuVVBZMkFqTDBqUjJMSTR2Y1AvZkRjWmNm?=
 =?utf-8?B?aVU1d2M4d2MvVGtCYy9PLysxbXhqQ3NyU2ZvL1NFbHQ0bmZPRGkrNVB0ODdV?=
 =?utf-8?B?TDhObmU3bkxuK21TSzlFMmRaQThGdTFTdU5FejJQRUNRc3dXc05IR0c2bUls?=
 =?utf-8?B?czRHTHJPd1F2OUpPeUJSTHpiY0dVWXVrQXlxU2ZDb29LOVdIdUpYZ3RUVkYy?=
 =?utf-8?B?ZnkvekdHUE5jalpOQXYxd21EN3NlTC84dXkyYkthdTR1K0laci9LaUswTXB4?=
 =?utf-8?B?RHZyUkJXZ2xSVkZNMldKR090ZkpvY1A0dGRqREJndm00aWozUzZiaHh2blAx?=
 =?utf-8?B?NGYzTDVJanl4UTMxa3RablNHSlVQUVBkUjZOOS9tUUhqSGdpTmNHa3RhRmJq?=
 =?utf-8?B?dGd4UG11UUxJOXRwdkF2ZTdnbTlEaWlZZVZMRU9WMGZOMnF5MnUyTGN0cHlD?=
 =?utf-8?B?alZ6a1dMeldQZ1BkMnA1b1dEQ0cvM3pCcHk5OTlRb3k5bmhtM1JaNlNMYng4?=
 =?utf-8?B?YzU3a3pLKzEwak9IQ1Y3L2RtSVVmVmVQQlpvY01tcEV5Y016VGtQeUNzRWZP?=
 =?utf-8?B?QW1LZ2VaYkhiTFQxZWZxaU53WW1EYmF4cGVuT0Z6enZPYXlNYzNsRi9XRmhn?=
 =?utf-8?B?SkNQZ09TajU5M0lhSC82NGNrU1dMbjA5M3NYMndjRG4wQnVsSlYrMnl5RmRx?=
 =?utf-8?B?Uko1V09mblV5NVVzY0FHcXQ1VUo3LzI3bTF6L0FPYjQwMmJ0YjhTMVd4eC96?=
 =?utf-8?B?SFVmNWFENXBRS3MrNCszdE16ZDBZc3l6N01oVkpieXdpYmRZS3R5bS96dlFK?=
 =?utf-8?B?aU5jdlNBdlcvWDVqUFAyNmpBMjgvZlBEUHgrcmZlZGZmRkRLbjBpSFVseEpP?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB5A575AD47DEB408F549496D1D36BBB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a898c280-129a-49cc-e668-08dddc177c27
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 16:19:18.1264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oAXOPn5U52RDWBAzXAZaCgb84q9jXsBOZJf9xzDPpO8+XVWGYdbBRL/iUcmjj55c15FSTR0Vlk6U4rFaI3hV3N7ZJu73JbYqEiZ24WqErrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6921
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTA4LTE1IGF0IDE0OjE3ICswMjAwLCBPbGVnIE5lc3Rlcm92IHdyb3RlOg0K
PiA+IGJ1dCBJJ20gbm90IHN1cmUNCj4gPiBpdCBpcyByaWdodCB0byBmdWxseSBkaXNhYmxlIHNo
YWRvdyBzdGFjayBpbiB0aHJlYWQuZmVhdHVyZXMuDQo+IA0KPiBXaHk/DQoNClRoZSBiaXQgaW4g
dGhyZWFkLmZlYXR1cmVzIGlzIGxpa2UgYSBzdGlja3kgYml0IHRoYXQgaXMgaW5oZXJyaXRlZCB3
aGVudmVyIGENCnRocmVhZCBpcyBjbG9uZWQuIEhvdyBpdCB3b3JrcyBub3JtYWxseSBpcyB0aGF0
IHRoZSBmaXJzdCB0aHJlYWQgaW4gdGhlIGFwcA0KKHJlYWxseSBnbGliYyBsb2FkZXIpIGVuYWJs
ZXMgc2hhZG93IHN0YWNrcywgdGhlbiBuZXcgdGhyZWFkcyBhdXRvbWF0aWNhbGx5DQppbmhlcml0
IHRoYXQgc2hhZG93IHN0YWNrIGlzIGVuYWJsZWQuIFNvIGluIHByYWN0aWNlIGl0IGlzIGxpa2Ug
YSBwcm9jZXNzIHdpZGUNCnRoaW5nLCBidXQgc3RvcmVkIG9uIGVhY2ggdGhyZWFkLiBUaGlzIHBy
b2Nlc3Mtd2lkZSBiZWhhdmlvciBpcyB0byBhZGQgdG8gdGhlDQpzZWN1cml0eS4gWW91IGRvbid0
IHdhbnQgdG8gYWxsb3cgYSBwcm90ZWN0ZWQgYXBwIHRvIHNwYXduIGEgbmV3IHRocmVhZCB0aGF0
DQplc2NhcGVzIHRoZSBlbmZvcmNlbWVudC4gVGhlcmUgaXMgYSB3YXkgdG8gbWFudWFsbHkgZGlz
YWJsZSBzaGFkb3cgc3RhY2sgcGVyLQ0KdGhyZWFkLCBidXQgaXQgaXMgcHJvdGVjdGVkIGJ5IEFS
Q0hfU0hTVEtfTE9DSywgd2hpY2ggZ2V0cyBzZXQgYnkgZ2xpYmMgbG9hZGVyDQpiZWZvcmUganVt
cGluZyBpbnRvIHRoZSBhY3R1YWwgYXBwLg0KDQpXaGVuIHNoYWRvdyBzdGFjayBpcyBlbmFibGVk
LCBkZXBlbmRpbmcgb24gdGhlIGNpcmN1bXN0YW5jZXMgYSBuZXcgc2hhZG93IHN0YWNrDQp3aWxs
IGF1dG9tYXRpY2FsbHkgYmUgYWxsb2NhdGVkIGZvciBhIG5ldyB0aHJlYWQuIHNoc3RrLT5iYXNl
IGFuZCBzaHN0ay0+c2l6ZQ0KYXJlIGFib3V0IHRoYXQgYXV0b21hdGljYWxseSBlbmFibGVkIHNo
YWRvdyBzdGFjay4NCg0KU28gd2hhdCBhcmUgd2UgdHJ5aW5nIHRvIGRvIGZvciBQRl9VU0VSX1dP
UktFUj8gUHJldmVudCB0aGVtIGZyb20gd2FzdGluZyBhIFZNQQ0Kd2l0aCBhbiB1bnVzZWQgc2hh
ZG93IHN0YWNrPyBPciBzZXQgUEZfVVNFUl9XT1JLRVIncyBhc2lkZSBmcm9tIHRoZSBsb2dpYyB0
aGF0DQppcyBhYm91dCBtb3JlIHRoYW4gcHJvdGVjdGluZyB0aGUgaW5kaXZpZHVhbCB0aHJlYWQg
aW4gdGhlIHByb2Nlc3M/DQoNCj4gDQo+ID4gRmlyc3Qgb2YgYWxsLA0KPiA+IGRpc2FibGluZyBp
dCBmcm9tIHNoc3RrX2FsbG9jX3RocmVhZF9zdGFjaygpIHNlZW1zIHdlaXJkLiBJdCBqdXN0IGhh
bmRsZXMNCj4gPiBhbGxvY2F0aW5nIHNoYWRvdyBzdGFja3MuDQo+IA0KPiBJIGFncmVlIGluIGFk
dmFuY2Ugd2l0aCBhbnkgb3RoZXIgY2hhbmdlLg0KPiANCj4gPiBMYXN0bHksIGl0IGRvZXNuJ3Qg
c2VlbSB0aGVyZSBpcyBhbnkgd2F5IHRvIGNsb25lIGZyb20gSU8gdXJpbmcgdG9kYXksDQo+IA0K
PiBOb3Qgc3VyZSBJIHVuZGVyc3RhbmQuLi4gY3JlYXRlX2lvX3RocmVhZCgpID8NCg0KVGhlcmUg
d2FzIHNvbWUgZGlzY3Vzc2lvbiBpbiB0aGUgcGFzdCBhYm91dCBhZGRpbmcgYSBjbG9uZSwgYnV0
IHRoZSBjb21tZW50IHdhcw0KbW9yZSBhYm91dCB3aGV0aGVyIGl0IGZpdCB0aGUgY29uY2VwdHMg
aW4gaW52b2x2ZWQuDQoNCmh0dHBzOi8vbHduLm5ldC9BcnRpY2xlcy85MDgyNjgvDQoNCj4gDQo+
ID4gSG93IGFib3V0IGp1c3QgYWRkaW5nIHRoZSAnbWluaW1hbCcgY29uZGl0aW9uIHRvOg0KPiA+
IMKgCWlmIChjbG9uZV9mbGFncyAmIENMT05FX1ZGT1JLKSB7DQo+ID4gwqAJCXNoc3RrLT5iYXNl
ID0gMDsNCj4gPiDCoAkJc2hzdGstPnNpemUgPSAwOw0KPiA+IMKgCQlyZXR1cm4gMDsNCj4gPiDC
oAl9DQo+ID4gLi4udGhlbiB1cGRhdGUgYWxsIHRoZSBjb21tZW50cyB3aGVyZSB2Zm9yayBpcyBj
YWxsZWQgb3V0IGFzIHRoZSBvbmx5IGNhc2UNCj4gPiB0aGF0DQo+ID4gZG9lcyB0aGlzPw0KPiAN
Cj4gYnV0IGNyZWF0ZV9pb190aHJlYWQoKSBhbmQgdmhvc3RfdGFza19jcmVhdGUoKSBkbyBub3Qg
dXNlIENMT05FX1ZGT1JLPw0KDQpObywgdG8gbWFrZSBpdCBoYXZlIHRoZSBzYW1lIGxvZ2ljIGFz
IHRoZSB2Zm9yayBjYXNlICh3aGljaCBkb2Vzbid0IGFsbG9jYXRlIGENCm5ldyBzaGFkb3cgc3Rh
Y2spLg0KDQpMaWtlOg0KIAlpZiAoKGNsb25lX2ZsYWdzICYgQ0xPTkVfVkZPUkspIHx8IG1pbmlt
YWwpIHsNCiAJCXNoc3RrLT5iYXNlID0gMDsNCiAJCXNoc3RrLT5zaXplID0gMDsNCiAJCXJldHVy
biAwOw0KIAl9DQoNCk9yIGFzIE1hcmsgd2FzIHN1Z2dlc3RpbmcsIHJlcGxhY2UgaXQgd2l0aCBz
b21ldGhpbmcgbGlrZToNCiAJaWYgKG5lZWRzX25ld19zaHN0ayhjbG9uZV9hcmdzKSkgew0KIAkJ
c2hzdGstPmJhc2UgPSAwOw0KIAkJc2hzdGstPnNpemUgPSAwOw0KIAkJcmV0dXJuIDA7DQogCX0N
Cg0K

