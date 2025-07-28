Return-Path: <linux-kernel+bounces-747346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB03B132CF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 03:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7967E18948BF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 01:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420D5145A05;
	Mon, 28 Jul 2025 01:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KkEGfW9b"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA1F2E3717;
	Mon, 28 Jul 2025 01:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753667254; cv=fail; b=ocObKLAFsHOzf/sghIBD78hQgtluCmr6AOB5Muxbs04u4hha+inR1kYzTZfusnyBjY47SURmk825Yek5AYyaHvhx8BCnbYJg3FHbjReASw4kJqpua1vRW5GmOs28Z8Qo1z5RgPKhw0mTjeQ/sKHtDJJcUnh1OrWkzmkn3P40lYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753667254; c=relaxed/simple;
	bh=Hd7CjLoOFfWNYxrMBG4KZ98TwNPWjgFslGffoNRdjdo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yw66uaYlWPuRL18H2mkrcW49RYFz5NWQL90TVnRjKaNfNCzPQjsPk0QL8pcYOI/eviY5gl96wQqTPhGf6X9SvVLXqiYlWIHtG0A/Yx4f6xU1SsPvQq79lpWxthpJISk7X9QspmT81D9xbEZSLjz1Ix/s1V1Tet8xj6yWZMclN6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KkEGfW9b; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753667252; x=1785203252;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hd7CjLoOFfWNYxrMBG4KZ98TwNPWjgFslGffoNRdjdo=;
  b=KkEGfW9bRsUhwZXZBm4fYqdLIHQbBfznnhdYsjIMWizolFvTkk2qkgXR
   GGE/1dyz2Zra1fy3Wr3zY5JBlekyoVRhfNGkThkzoQUL75/Us3HYJN7DB
   7zpen8a7NvZ1+OQzRIC8pvHgTNL7BcA4i51g4id7AOGay+Nl1Lo4xRQ+v
   eUX0nIIzHeRZer5K/3yubLRklnk98LupQwO4WWNdWB6Ubq4S/PVWhOgpX
   dhp+cljfV885i4wrpSm2JcuKfKrmaw1PvrMGd6InJIV728Xx2C81XikM1
   9QxmaMrHlDEhJ2GDjm+5QyYJ2jfE/mVGIdT4ZN7RzKUcvDSS60ZJ/dV0U
   g==;
X-CSE-ConnectionGUID: mLulXdJvRDSkF1sezppl1Q==
X-CSE-MsgGUID: 3FG08WEfSvC9cBIG78NeEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="59727190"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="59727190"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2025 18:47:31 -0700
X-CSE-ConnectionGUID: qV5Tl+MdSWWiHBP2r9S5HQ==
X-CSE-MsgGUID: +4bzGSbXSOqBWazI6AdANg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="162657895"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2025 18:47:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 27 Jul 2025 18:47:30 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Sun, 27 Jul 2025 18:47:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.68)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 27 Jul 2025 18:47:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osE7qrdggeHmcQDSSTvbkcFYTMuqSHAnZCACe2cRf7xNz/V6kUkWhj7UpipVWx2RJPlz6Ha7SbxDwTx5um9IioeRnXeEUdZKceS0+STNP9/5dWQ93UQ9zIDv0IkJaEpC+r+LyNa5O+a48kdzI9rIlKHRaUC0t1rp18cGV/Dyw993XBTnnHCwQ0yRE/xbZjCh8b7ultsyNFyWOm+yd4xoRnrHneOjglGBn4UpEGODahkxtsKgK/cuuGATw47pHWJCGJV6UeA1conctGwMrKA/p6foKB5B0TLxlD7F2Vb56A3b1XFxyFE3nXifqF69i3SWkZKiofz+MCoPyDrtds+bmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9xL3LMDMRIdOQkLGVJzHmrCqKyRRpGyebOsxGyGWnk=;
 b=KTmKaR//SsBExdpXVxIcmx7OUGtT6zVK42FVHkE0tna4EwqGXhdbSIlyZygMScmsIUnx/22KF9q7Uw0BFUBYiYUKMA9HO8KnvKGzdQhPQWQzLmaUKGiD0OpAx6htnKEt6HxxsLumlO3WGPJyLg5qkDo8L8oc5jWiYy3T2g7qaGAeF5iS7Gv9mID7C74TbTbVXlmssn3PMg+PgqKScNmm9PQ1PGmDq53CH9P70xKznVjk/jp3u2QHo23TNtQ7lP5XnaWacVLDEwZ+Q0GK0GfXEEy3TpK8JMqHdNeYeuOqqsjZ8IpN7cAFqO/vE17Uss5TCAdDoOdNWUg6YhtV83FdxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DS0PR11MB6470.namprd11.prod.outlook.com (2603:10b6:8:c2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.30; Mon, 28 Jul 2025 01:47:23 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 01:47:23 +0000
Message-ID: <bba2ead6-5c08-4319-b073-198d5a3dad79@intel.com>
Date: Mon, 28 Jul 2025 09:47:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: surfacepro3_button: replace deprecated
 strcpy() with strscpy()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?Q?Miguel_Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
CC: <platform-driver-x86@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <hansg@kernel.org>,
	<luzmaximilian@gmail.com>, <skhan@linuxfoundation.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
References: <20250724074539.37650-1-miguelgarciaroman8@gmail.com>
 <77116abd-289e-efc6-c358-e4a1a1fc0131@linux.intel.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <77116abd-289e-efc6-c358-e4a1a1fc0131@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:3:17::34) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DS0PR11MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c67d8b4-7e2f-424b-b141-08ddcd78b258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVlWNmFoSmFRcE9tQ3lTV1UxbTFzQjZpbC9IUS9oVk1YVThyejk2S0xvbnNu?=
 =?utf-8?B?K21Gd2YxM2tCV1RGVWFEd3laMEptdnRVaEdGMnVrU3JJOGhkVDIvR2VhakE3?=
 =?utf-8?B?a3h3L2dabmd0ZlVpdm5VSGx2aFVONkJFN0lEd01OZi9Td0FWbHhWV05XNFBH?=
 =?utf-8?B?cTdmTkVFek40c3RUOHorY0NxMlpDdDJHQUdudDg5SWV1RmZrdlR4RlIrYWln?=
 =?utf-8?B?ZmxEdEgyaXg2bUtEVUNoTWhuT2RlWHowOGl2WDJwVGdsM2F6RDBwUUcwb2xh?=
 =?utf-8?B?TnF2Rzd5TDVnaGptakdWcnNiN1I2cnZ0SlZsdVV4bk5uakZlb2NEcUwycy9p?=
 =?utf-8?B?VVBpdEVValpVQkZBM1craENwN0VaS2JKQy8xMklsdFlmWE9wWkd2U1o4bk85?=
 =?utf-8?B?STFXRmo0WnFPV2dkUkNnSm5ueGcrcjU1Wit4bGtiMFhMTUhxYlhCRUhFK1oy?=
 =?utf-8?B?YzBTZGgrV3piZHNNemlvQkNUTENXVEJtdFBYcjQwOEI0NTNEMnhQZHNzRGND?=
 =?utf-8?B?a3A1Y2tkd251Y3BrSFB3Zllyc09KS1QvdnhrSldLQ2s0L2ZvZExkNk1tbXUr?=
 =?utf-8?B?MVVETVUrdEZVb3ZveC81V3l4ZnlaamxnUHo5QTROeFpTN20yTmVtdVZoVmti?=
 =?utf-8?B?UkJlbHVBanZKZUNiQ0xGVDdyeVpwVmlVMGg2V3VxSkNnOC9xdTN5RndlWjFp?=
 =?utf-8?B?QTdZQVFJMldFYk1LbDRMbWZnTFE0ZnpoL0J4S3phcjc3WVNFV2c0M2pRQ0F3?=
 =?utf-8?B?ZEJ3aFJYb1l6TS9XUFdWU29YT0JHRUg3NUUzVzVYYUhQMEFnMXNsSDdlWnd2?=
 =?utf-8?B?eGxhaGtIYlRpdCsxMWtWdmplWG44R1NxclkvUlhrT2F3RzM4eS9qV1NIUzlk?=
 =?utf-8?B?ejAzcW10YVpzZVRNVGRnOVJFVEJQaSttTFFpN1ZUUXEzSVFNd2JWN2NCMnFX?=
 =?utf-8?B?UTduUXA4V0lUbDNkMVREa3lBTXZMRDNCcUNVbjV2SllHVHA2YUZKSmFudkt4?=
 =?utf-8?B?b3Q1ZnNXOENDRTlVQ0hweCtiSktBdkFUYzNMaVJ1WWZ1U2xQcVA0bTlDeUVv?=
 =?utf-8?B?MGNUZ1g5YXhPdXZDdDdRL3ozdG1IS3RhU0tYeE4wQUtBQUJ1OWJyQUhoM3lO?=
 =?utf-8?B?dkpvM3kxN3ZzU045UWkxVFk1dmw1UG5JQWU2RUZVQ1FDczM5eVVNM1VpZHE3?=
 =?utf-8?B?ZlM4QlV5ZHQ4S3JDYmx4dTJZNWw0TjRrcllkSGYxQlhSQUN3dVEvL3Z0K3NB?=
 =?utf-8?B?VHVYMmd1bHYzVFlGdWRCNVRDMDVRaGk1bVJsUis5Y2w2VU80Q1AybjRXR1Rh?=
 =?utf-8?B?MEFsVFVTNks2VU5RYSttTWQxUXpGTHZ2L1NSZ1BWK3NnU2lQOW9TcUZMZ3Ra?=
 =?utf-8?B?YjVYRVRJYkd3YXRvcHZuTWs1VWMyTHp2WVlaOFNUZ2dSK3NtUjlYcEl3WlNx?=
 =?utf-8?B?aDFtdzgrN3VKcWc3THY0L1VrTWVQUGxZMVRoY0tMTXZ3S3RDdjF3bjRHaFh6?=
 =?utf-8?B?VWNSMERWaHl5b2xuTjNxS1NLa3l5MmYwdkh1SEc1VUZaUlovR0FBaWl6enl1?=
 =?utf-8?B?KzlUMUNhVUZTcVlSRUN5MHlWNm5nQkhHbm9QVEVJdTkzMkpXeEVvalBOcWlX?=
 =?utf-8?B?TWZqeUV0TlVTWVNyRWRiMDZrUzdwb1dNRzRuL3VsdFo1cUx3SVdtYUNNaHpG?=
 =?utf-8?B?R2VTRGtNL1A1eUxIQXFpSGJEL2xGSFkxcEUvTmhSa0tZTGFFUERvSFAyOWp2?=
 =?utf-8?B?N2VXaWhnR1lpQ21kZmdhMjkzelpPNXVEYmJlL3A3clRmSEYvQnAwejloZFBh?=
 =?utf-8?B?bHp2d2U0REp4aGJXQm1CUlIwZGxVQ0RmbVZxa0F2djNvQTFpTG5UMnNyTlcv?=
 =?utf-8?B?QXVlaDJudldObWpsRWN1S1lKZ25CQXpoWGxFZjJmajIrOW1TZnVyY3ZGcUg2?=
 =?utf-8?Q?M6J2VutSutw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG1Va2VpeTZGWWpweHFEbk1xLzFCTUVkT1ZlUkxLb2txY05wUXRsSlNTc2tQ?=
 =?utf-8?B?dHpRQUxWMUU2UnpudWJQWFErZGNEUk90QnIrQjd1S2hXcmk3SE9MY2xLQVRF?=
 =?utf-8?B?SWJqT0lUUmxJdCtmSStKanhKa05CUjRUTGlDQUhJUjdZV1Mrb2JSMDdiNkhj?=
 =?utf-8?B?NHd2K0xsZWI2S2xUQnZMSm5xY0lHcDlmdGJlUGZ5cVZuRjFWSnFlTVRQR2pr?=
 =?utf-8?B?c1VBWklXWTg0UFhEMEJLb0p1Z0JFN1hYcUN1ZXRJRFRxRkZOZnRZWm9mN212?=
 =?utf-8?B?cCtiVlpEYTdZWENhdm1MTjFCcTloMHVTM1BqKzVjOGI1dU1hVngvNDNPdWxj?=
 =?utf-8?B?Zi8yY0xMTjllTWNBVEZEZjBPMDVLeG85S0UyVm0vS3JQOC9QV00yUm5oK05t?=
 =?utf-8?B?VUxzSTUzaFhYckVkVmhrS2Z3Vk9GYnZhcEpHMXdlM3JITjh1Rkl0eEN2VTBa?=
 =?utf-8?B?RGhvMGJySlhWM05zRUFRM014c1VSR0lsUTE1VGlBUHRLajV4SnFxRVV0ZlEw?=
 =?utf-8?B?aHRoOWlNbG03SXg2bGxoRUI2Z0h5dXRPaG1RSmJrTzVkZHFaSWg3V1FTZ0Fk?=
 =?utf-8?B?VUw0M0lUMkxVYUJBUDdndDg0RmZLZUxMYzF5VzBMbjcrZ29sMVJrd0VKcFM4?=
 =?utf-8?B?dFJtZjY5a1ZCNE1SeXNoaFVMM0YvTW9uOVJIc0x6Yi9yRWNwN1NtQVRyVks1?=
 =?utf-8?B?K2FNa0I0UGRKWjVqbktBWHZDV3gwWmJvbnNyMTE0dk1wSXdPMmpwNmQ0WUMr?=
 =?utf-8?B?YlZ1OUF2Z1B0ajA4N2tXb2YvZHRVZnE3eFZweUcrT0h1TVoyZkF6eklneG9o?=
 =?utf-8?B?NlFVb2hYR0xtK29BSzZ6TEtLOGphSTFqdURmdUU2L2pPbTdOTkxGWUdQR3B4?=
 =?utf-8?B?U096N01TUFdDZll6eVVSZFM4MGpRcFl3SFl5a3FzY0p3UEViZC9lWjIxT0FM?=
 =?utf-8?B?MUhNdXNpYjFxQlFXUTh4WTlKOTlPUmJkTFlMYUd0NWRJTUZ0QjJ0bC85Z0Ey?=
 =?utf-8?B?SDlzdGFkL2RxWHlGNUVSZVBzZmZpN284Ly9UdS9HczREcER6a00xZk9hWURW?=
 =?utf-8?B?M0gwN1EyS3pVVG52c2RUZ2t2YmlrYXVuS3p4RDlSS2ZwaE9pL3NtaVdiN0Zz?=
 =?utf-8?B?UkJEbWdlMW9CZEFxRlRyZ0FBbGFZcHBkQnlpRURGQ2FxNnpOcXhyNUIzSDFw?=
 =?utf-8?B?bjRkNWlQcFpnbzdlZVFPRGFJU1Mxd3ZFSVdUWEd2TkJ0OTIydzN5YU9pMlFW?=
 =?utf-8?B?N0szSG1RSHBrQlNYd0ZBMjljTk1FYVRaVEh4NHVIUlJoR1k4K0swUnpMbWRw?=
 =?utf-8?B?UE8ydkN3blp5T1lLRTliZlljcStDV1QzYlFqQk0xUFZjUHlDbE1SL1AzQW03?=
 =?utf-8?B?UnRsdERUa1dvK2JQVnJoUVFCalZmM29EanJoTitZdjA5MHlZU0VydjA1Q0dh?=
 =?utf-8?B?YzV3WTUvNmY1UDVYVmZJWW01RklxQ2lHc0NPZFI3QVY5RVVGUFVaY1FkRFJH?=
 =?utf-8?B?c2VzaHVXZ09kL3Ntb3NIand0WTNIVFRQT2RLTGNaMzZJS2xiTnlWbVkraFc3?=
 =?utf-8?B?UWdMZEpvODRnSXZrYjZhb3R2YytHbjVCUThqVUdnVSs2VFhJRlpOWFhwU1M2?=
 =?utf-8?B?Rk10U2JvWjYxNVJEeWJsaHlCanphV000SDlQTTNoNWQyWklhMFpTL2l2QS9u?=
 =?utf-8?B?TlNabk9zMWNmUlNFekxDakZheUYxRVVUMGRSeHIzWGpucTBQVURXMmhUQmZQ?=
 =?utf-8?B?eTFrdWJkSy8wa3ZGanM3UGdHd3ZaT0tJRUZUODZLS3N0K2VOZElZSWxxWXZG?=
 =?utf-8?B?RlhyYkUvdkh3L2cwRTlrVDN1VUlZbFN6ZnV2a1dBbElqQWpiSXEzNm1SUVcw?=
 =?utf-8?B?RCtRREhCSnlVNnFVRGpCMGFZVEhMWnJlaG5YVEpJc2lJemtZK3BCNTRaN0p3?=
 =?utf-8?B?YWEyZWNLWDdXaCsvaVJ4VkVxUHdGb1pFQzZwWlp5eDVpWHNjemw4dXZndmRw?=
 =?utf-8?B?SUF4Vk1BL2hGSG55bmNLaFBtNjlsbjBnQlA0Q2d6RmdSWGRKOVdCZUc0MmJp?=
 =?utf-8?B?dm82RTVtM3dqbHFyY21sYlNkaUJWOUtTKzM0SGxrU0RLSlBjbDFnTThYY01x?=
 =?utf-8?Q?/+9YM4bX+udNYlUeCw03bukHP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c67d8b4-7e2f-424b-b141-08ddcd78b258
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 01:47:23.1571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3da0Ef8y+HseRi1sXHyjmYj+DN6SrcwM6LxInkUIUnJZMQCuIuY+fi2ubQuJRiRe7wOWh1A932DG6XTNzuf6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6470
X-OriginatorOrg: intel.com

On 7/28/2025 4:32 AM, Ilpo Järvinen wrote:
> On Thu, 24 Jul 2025, Miguel García wrote:
> 
>> strcpy() is deprecated for NUL-terminated strings. Replace it with
>> strscpy() to guarantee NUL-termination. 'name' is a fixed-size local
>> buffer.
>>
>> Signed-off-by: Miguel García <miguelgarciaroman8@gmail.com>
>> ---
>>   drivers/platform/surface/surfacepro3_button.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/surface/surfacepro3_button.c b/drivers/platform/surface/surfacepro3_button.c
>> index 2755601f979c..9616548283a1 100644
>> --- a/drivers/platform/surface/surfacepro3_button.c
>> +++ b/drivers/platform/surface/surfacepro3_button.c
>> @@ -211,7 +211,7 @@ static int surface_button_add(struct acpi_device *device)
>>   	}
>>   
>>   	name = acpi_device_name(device);
>> -	strcpy(name, SURFACE_BUTTON_DEVICE_NAME);
>> +	strscpy(name, SURFACE_BUTTON_DEVICE_NAME, sizeof(name));
> 
> strscpy() should nowadays support 2 args variant through clever macro
> trickery.
> 

Yup,  something like
strscpy(name, SURFACE_BUTTON_DEVICE_NAME);
should be fine, because
name is a array, and SURFACE_BUTTON_DEVICE_NAME is smaller than
the size of name.

thanks,
Chenyu

