Return-Path: <linux-kernel+bounces-828638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7795FB95119
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 237313BCE0A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E202131DD9B;
	Tue, 23 Sep 2025 08:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GUEAXbJq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F764A0C;
	Tue, 23 Sep 2025 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617441; cv=fail; b=awHhWyq0lKo7zYD/mauU+6LG2NB3HqWxv+KDnSktdiumPmigS2OgamIb7/rE5227og88Yw0sBgnqjDTL37dlK5AuR7Au/LNhnDye5mRW/dEhlwMQ9TCPERegkPVK69vHQVJ2gA8jfgSdtzGlMspsiP8bh3J1FN2wjZx+q4Ah528=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617441; c=relaxed/simple;
	bh=wgXzP2Ix1s+efRACSdUbZJ1Pdto3Pk5894LKpXSUgZM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nfRfuRhkw+mKQw4/d+zOLB8Xw2anFciAo9PM19gWvgT5yadvKclNWdxGrFI5OmtnCIuTZM2vEzrNwhU7bhNRdnpPtT0gUdudZHxjZUPZ4DHxIyUOgqrbDp1MwhndEXuhhsQUYGXiGWY240QOPB5DhHIImWlDhxdP41m26xHVU+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GUEAXbJq; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758617438; x=1790153438;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wgXzP2Ix1s+efRACSdUbZJ1Pdto3Pk5894LKpXSUgZM=;
  b=GUEAXbJqmUKB6k5wtqZWgOCtPmpxRXliQhlGDs+oqUHTgVTUlKYlSrAu
   ay0YbecxVX0tXAXUUS3laXOdmePcqqKn4O4kfTxsU7z543ujElQxVscv/
   c6v/t83zjad0HxNXFTVtTxjegYTo/shEnJG5YmBW3a20ah7X7j8rw3Jjm
   OIcxN5HuCqr+2gEtgK6k7pcGVCDPfGWMvIQP1esG7fwFBgIy+Zv6ZZqfO
   H/xKqzw9ql3GjH/bsIgdEDL2hmB483qgKHX6q2a/TfgdAEBrhFM8wkcUC
   dr3nM10LMFlS0EyF90pvpYjJl1AB8r/eBkf6hajq/7zrGZpAJG0nybO4i
   A==;
X-CSE-ConnectionGUID: BToHggcXRpy02lJ76Xd8fw==
X-CSE-MsgGUID: SWiASb9/Q8esEsYtSzqLlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="83495189"
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="83495189"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 01:50:37 -0700
X-CSE-ConnectionGUID: TEvMe2ltQpKl+OmarBJt6Q==
X-CSE-MsgGUID: 3SsH6ewDTZGv6DPXKdHwGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="181878114"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 01:50:36 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 01:50:35 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 23 Sep 2025 01:50:35 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.29) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 01:50:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRU/choZUlNVUEkYei4tmmyaCWbtZhEcsy6jzSQUnHrX2KEW87T/3vPel6DV+Q+t1ggEm/L8QGObxg1018dWptvAp33fZkzTR0Akw7HF2TK9XXyHxUQvpByNI6aMml7Z+uIhP4uwGI5VxNkAzxna5mjwYdCN3OnEHE+UMVDqKtUgzGV+d1cpFMX8ZCAGZoKMX458naFx2BCE/tnU8POQJWHWIyAGKZ64DtynYiu/3uEH7grnpjeQl0KJZ8aLGiZUZ5ybogETmeAmVRum5L/BWxYuQG65wnhcCJXe5SK6LWmickQTbrEmDJXuDRYS02sNtu6l4mAFZY6/3ZV0AKULQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgXzP2Ix1s+efRACSdUbZJ1Pdto3Pk5894LKpXSUgZM=;
 b=SiYs4e+oEuLR6KpH+rHuVEislmxzcXsKrRo0QVk90YC9kARxJQ+9hoq0AXTB3H07xCfwg3QobFjkL8GmGnrsbSKQcz8i1PTo6Mb/xIR09OLkiVU5cDdkGchltsdUUhEHQcZGuyeV+wWKkoZXVGyxV61B+YhRWotDY3H2mj4lQ/3wOiIFTXFt5K8GjiLsH8LxtCwFy/42OiM4EA8WhAzPn1aUlQ27siUrQgX+4D1pFBlZBR6sxlpDq7VZCB0ldwdwM7Zm1ybjB/rcnvAmUcmMzJ9b4pqXCO0PGXbk0rQAw+auBGdCLpoJqTBWijOsZKRYERPI6MPsowKLNDvAdOLnzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by IA1PR11MB7245.namprd11.prod.outlook.com (2603:10b6:208:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 08:50:33 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%6]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 08:50:32 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>
Subject: RE: [PATCH] arch_topology: Fix incorrect error check in
 topology_parse_cpu_capacity()
Thread-Topic: [PATCH] arch_topology: Fix incorrect error check in
 topology_parse_cpu_capacity()
Thread-Index: AQHcLF5NxuZf5vIRSUeXa7ewnJ8/c7SgdOVA
Date: Tue, 23 Sep 2025 08:50:32 +0000
Message-ID: <LV3PR11MB87683FDAF790D779C8E91FBCF51DA@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20250923072520.3964688-1-kaushlendra.kumar@intel.com>
 <520bab83-191e-4907-8d47-3d9ef8c7c269@web.de>
In-Reply-To: <520bab83-191e-4907-8d47-3d9ef8c7c269@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|IA1PR11MB7245:EE_
x-ms-office365-filtering-correlation-id: 560fcf29-a3e4-42a0-94cf-08ddfa7e4190
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TVRzRDVyTDFBZzdVWkc1SUlSeVBsbTJoUHdKazIvMFkwa1hSMjVTY3d5UWt1?=
 =?utf-8?B?TkkrV3ZBRWcrNWFORW1kNGYrbG5mSCtSb1ZzcXBxNHdWMi9va1Z3YWMwRDFU?=
 =?utf-8?B?NnlWQTYwazVjVkZNQjdqb2VHSkh1WE9qMHlodHZFcHBWN3k4TDJuTGYrNHYw?=
 =?utf-8?B?MjhyWnJ3TEo5aTRkR2NhakE3OXhXd05IL2t4T0Nzdmw4aGp0Z1pzUDhvZnEy?=
 =?utf-8?B?YUFOajZnenBpR0pTNkJEc2FYZ2lZU2JPY0FYMktnNDdveTZMOTdRVzFWY012?=
 =?utf-8?B?WThqY09uVXdNbnAzNFFCU3NkTDNOVThoWFlGTjhLUHR5RzRyV3ZOWEkzQXNE?=
 =?utf-8?B?Mzd6TVpIdHpxNFRlM0hNNUY2SEFKK1JyOXFnYUtKZSticjFRVTBoQU9qL0ZR?=
 =?utf-8?B?NkpXWis4ZFNRVWpML0kxOWY5alVYMGk3aHVWM05vUjZjc3h5MEN0RkhjNzNz?=
 =?utf-8?B?NzIyQTlFUUlrVTNnbmJQb1Nucnd1RVI0Wk81QU9WSGg2U0hmZVNPU0VtNWsw?=
 =?utf-8?B?WGRya3VoejgxU2ozQmo5ajlvMWJ5MEJtZ0ZQazVaYzV3NE5ZSW5uci9nZlov?=
 =?utf-8?B?Qk1PVzBKT29Eam1OU1llS3QrTTIwSjY0djVwTlE2QjJCOFlVTG5XQ0NFRFNX?=
 =?utf-8?B?NDN0ejlkaGVwcnBjWS9qd204c3FyMmhKZjgyeG9QRXBtZGcySDR4bkRNMWZx?=
 =?utf-8?B?VWdIa3RTZnFkVFF3b0JkVXhUUjdQNnZ2MlBTY2JiRG8xOWJtTnR5T0lINVdI?=
 =?utf-8?B?NDVmbkNwRTJXY05YeFNpc3A1WVV4U3cybXowa1lxclo5WEFzMmlrRU9Ea0I2?=
 =?utf-8?B?Rmx2NXM2L2E4enAxSHA0VmJRMHpsNVhPWG1MV1RHZmt4eXJyZnRYejlnMDNm?=
 =?utf-8?B?cjUzN1VMVEpta3BJNFp2VGpNSU1yeXR2M0hoa2Q4Yld0cGdtOXVWMFdEZkpt?=
 =?utf-8?B?TjdQbXBSSkFUWWxya090andEeTgyRjF6dkFjY3B1NE9SVUZvYVl4V3JJdGwr?=
 =?utf-8?B?ditkcXlZL2pTSXFzNk1OaE9vblZXZXp2dmpOdFk1LzlqcldBbXNjUkp4b0hL?=
 =?utf-8?B?VnZ2bTk0Y3BZb1hjcFlSSGxvUzJ2QlhTRUtIZElIejJFM3NlVXlocFFSaGlS?=
 =?utf-8?B?N2JrTm40bW1ROXozOXRIenBnUWNwK3QvaWpOMWhaU1pnNGlWRlQ1aitTZ0t5?=
 =?utf-8?B?aGVzSUU1bmJDWEVqZUNiYTcxVlcyMGd5WEtYbWJEbkpYSUFZY0EwMWRsU2pD?=
 =?utf-8?B?eCt0Qjl3UmIrTU0zMDUwS3VqbjFFOU5lT2RJUWppMkV5UGNkYzVNb0E3SjZM?=
 =?utf-8?B?cUFJekNpNWNnditSc0VWd2hFaXZlcTlyeDVNVDBnNWlZdU1wZ0dMVllkZFd0?=
 =?utf-8?B?N3U0emVzdTFMR2V4NlNxeWVLN1pOMTMwSW4vWUsxbzdjak56TXJ2Y1NUVUF6?=
 =?utf-8?B?NVN6a09LRzUzSDN2L1RSNzRudG81ZXpua1NHN3M3V3hMTHdiYVlvNi9WRHF1?=
 =?utf-8?B?OHc2ZVp5WHZlckE4Q0VocHdPQjBlYXo5V1RNTllNdXA2dzFiUVNkZkdwNXhK?=
 =?utf-8?B?QkRlMUJuSE5RaUxaTk1SV0M5cW8zREgxbGF2MjJJTWZOY2FOblZkbW1pZTRo?=
 =?utf-8?B?cHduRkw4cWlMamZCQzA4NnV4Z2RUcjZZajk4aU1JRzdyNHdFR3g0TXhJeWRV?=
 =?utf-8?B?VXZobklENGxaakFTL3hLaVN0RWhITGZ1SmJJSDV5MlZnVGN3aDVWL25ydjVY?=
 =?utf-8?B?eXcwb0pEZnZqNTVreFEzSGFKZ0tUN3J2ZmJuUXhMUjJRTTVjRklTOVVIYWR4?=
 =?utf-8?B?K2IvOHVZMStvYjVCVkVIZVlEZUdScXFJKyswWTFYaDk5akYxVDA2MFpxaUsy?=
 =?utf-8?B?Smo4Q2x6WkRtSUlJdlNlbHNxU2NoeThvUWFVc2V5NDdiUGdQSEc4aHd1Ly9y?=
 =?utf-8?Q?cP0Igr6k2no=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejdKTmJQbWM2ZXd6NkNleUVTZUhONnhCZzk1UllpcUxmYktKaFdwSWhudDhV?=
 =?utf-8?B?RExVcVBVYURIMW44NFB6V3ZlQ0RTTkhDS0J0L205cVB3Q1ZSUmlmZmJBaWlI?=
 =?utf-8?B?ZmNtUUI3NDg1VFNpS1VQSEhhYkZ1RDU1N2lmMWRqV3RLS1JFS0tGMGcxcUwy?=
 =?utf-8?B?RVZWek42K241SWZrRXV2akJ0ajlzUjZrUHlDVWhiSmRxUEpPdTFxTTEyTXl3?=
 =?utf-8?B?aEdQZXlxZnNrd2dLU3RHQlBYQm1RT3FYeHk4YTEzS1dKcytSTFo4TGwrYWta?=
 =?utf-8?B?TnNHcVlkN2tCWGNqVElDbUorV3lnZDZmSlFjaXNkK0pEZlVvOURXcXFXRXV5?=
 =?utf-8?B?dXl3czJGTDlhY3NJalVKN3JrOFZDYWhaVjJ1N2JMK1k2UnpvSldlMUN4MmY2?=
 =?utf-8?B?MExnYlVoeUQ0eW5aUlBxVlNvZS9zRjY2M1lFMlQzK3VTYlBHTkdkQlZndGdU?=
 =?utf-8?B?a1dTazNtSVVpNGw5YWw4L3drbkROQ1ZiMUJYVHRmQnowanNpeXNQWGs1M3Vo?=
 =?utf-8?B?ek5EOFcyTlorR1p4ajBMWSsyNnFEOW1JYnFnb2lZdktsNVNmMlgyTkN6dFlp?=
 =?utf-8?B?Vnh5dU84b1dMcGxGeTVjQ2ZwM2kvdElYQUdFU1RLWS9RTVFoaTF2cXJhb3N3?=
 =?utf-8?B?dlh0L3UwNmxweVlpZ1dBcStVSzVxUGUwMnZPc3VZZkZsYnFOR3V0aTFaNFE2?=
 =?utf-8?B?YWZpRlB3KzFEeitROTQ4U0lJaStDWE82U0hkQ21INWpibU53clJodE9qamRD?=
 =?utf-8?B?SmQ0UllPSTEvSS84TXNEaVQrMEwwQWc1T1A1bHBzUXZlZ3Z6RVVXaGdiRVBr?=
 =?utf-8?B?RzdWRTRVa2V6VTdnRVRFZ0gzNnZsSThJWUtGQU4ybmI0OVpPQ2wwTU16TmFO?=
 =?utf-8?B?SnFTdkppdXJ2M3JicEFpL241TTZCUEplNG1mem80K3BpaHU5R1ZaNzRWZEcw?=
 =?utf-8?B?VjRnWlRXTENkdERpR2dsVkl0MVBvQURzWnhWVEhRWGUybWFZbmFuZGNCV2lF?=
 =?utf-8?B?Z2ttWm8xWHpJTFNwWUhMMElsYWZ4M1hTRWpkdGlVMlRFdmtKTkJudXNGNWZ5?=
 =?utf-8?B?SGdwbm15Y3lXbDVLWHV3TXg5dXBLUVl5ekpnYmlGazVBZjZLcVNhT0pTQUdx?=
 =?utf-8?B?VUFxU2pZWUt0SmJjRUlNSHNySWxsWVpYY3ZMRGdJdUE0Z1Btc1BlWVJObjlI?=
 =?utf-8?B?T2REUFVrY1hkOFBPWkdCWE15dmtiQjg1N05WeCt2cFFKaVJ0Qm1TWVJxVk1j?=
 =?utf-8?B?SkJiS3FTdmQvUXZVR2pWdGhSWWNJd2FROW5GeUwxS0gxR0ZmRzZiZXpEM2pH?=
 =?utf-8?B?UWJGd2JCM0hmTWVUcWJmOFBaU1hpRGZsd3haTDhtbVpUd09tOGlTL1JBdzN6?=
 =?utf-8?B?V2cyb1djR1RtMFF1cU8rQlZLdVlJTFpUamttU05WN0Zxb01Lckd5cWhnempL?=
 =?utf-8?B?OUhvUGdwZzYxeS9jdmxIbHZZUGloajh0NEg5M1VaNmorVUVpL3diUHgwbVZh?=
 =?utf-8?B?b3J6ZW0yMllMaytHUTd6ZC96d3VOVzFrMVpYcWRzS2tHRWxUUlRiTlJVMytT?=
 =?utf-8?B?akdqWlZmejBvNk1GVUJzVmk2aG0wOW90Z21KcnorRUFad1JIbnV1ZDQwN3dW?=
 =?utf-8?B?S2ZxcjFDSkpFdlZueWVNZkRGUkxnaS94dytqdlJhemJ1VzM4Wmh0NHIwb0sr?=
 =?utf-8?B?bmhXNXBIckVPSUduSjZYOEcyVkdTTlRjeG54S25UYjBqajEvVW05a3BYOXBt?=
 =?utf-8?B?Nm9uYmNjbTEvN0Y5WXVyd1hxcm1rRDFka1V3QVZNWWhSd2N3RDhNUGs4M0Zs?=
 =?utf-8?B?ZE9KVk9oazVPNjhySTl3RE1OR3l3QW9TTjJwdGFBOU9uQzVITmVPejAvbXJS?=
 =?utf-8?B?cWlzVzRqWWNscFdpTGFsSXBRTmZGZGpGSzBHcmJDZm5SRDNkV2lzRTNMTFox?=
 =?utf-8?B?K2k4VWRYTGVuWURWT2ZRcFFZaVVRYjRWTkZYYUcvbkVYY1dzT0cwT3JYM2JQ?=
 =?utf-8?B?Y0tkaDhxYWQzaVBkR1BKN3YxTW1yRjU2SWwyK0JjQTkyZmdYRGh2ZmZnQTl4?=
 =?utf-8?B?Z05yRXZtbFQ5Y2gyc1pWamtaRWhyZVpBZi9DWnhsV01Ga2pGR01jSHhsbVBJ?=
 =?utf-8?Q?ykzX+o6OyWBNxiI/YYOjhvkXo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 560fcf29-a3e4-42a0-94cf-08ddfa7e4190
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 08:50:32.9108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: avTp0z+sPpWPhm4qN4dtm95XDw5GIGv4re8bN+EdjL2ujbQSLOh5hsdUxWWymkHsUJPW9APQUwtYZpCTszlPkyrfKtH+mtx+Gu8bmOQ2Q5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7245
X-OriginatorOrg: intel.com

T24gW0RhdGVdLCBNYXJrdXMgRWxmcmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPiB3cm90ZToN
Cj4gPiByZXR1cm5zIE5VTEwuIFJlcGxhY2Ugd2l0aCBJU19FUlJfT1JfTlVMTCgpIHdoaWNoIGNv
cnJlY3RseSBpZGVudGlmaWVzIA0KPiA+IG9ubHkgdmFsaWQgcG9pbnRlcnMsIGVuc3VyaW5nIGNs
a19nZXRfcmF0ZSgpIGlzIGNhbGxlZCBvbmx5IHdpdGggdmFsaWQgDQo+ID4gY2xvY2sgb2JqZWN0
cy4NCj4gDQo+ICogQ2FuIHRoZSBjaGFuZ2UgZGVzY3JpcHRpb24gYmUgcmVmaW5lZCBiYXNlZCBv
biBkb2N1bWVudGVkIG1hY3JvIGNhbGwgcHJvcGVydGllcz8NCj4gICBodHRwczovL2VsaXhpci5i
b290bGluLmNvbS9saW51eC92Ni4xNy1yYzcvc291cmNlL2luY2x1ZGUvbGludXgvZXJyLmgjTDEw
MS1MMTIzDQo+IA0KPiAqIEhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgdG8gYWRkIGFueSB0YWdzIChs
aWtlICJGaXhlcyIgYW5kICJDYyIpIGFjY29yZGluZ2x5Pw0KDQpIaSBNYXJrdXMsDQoNClRoYW5r
IHlvdSBmb3IgdGhlIHZhbHVhYmxlIGZlZWRiYWNrIGFuZCB0aGUgZG9jdW1lbnRhdGlvbiByZWZl
cmVuY2UuDQoNCkNyZWF0ZWQgYSB2MiBwYXRjaCB3aXRoIHRoZSBjb3JyZWN0ZWQgZGVzY3JpcHRp
b24gYmFzZWQgb24gdGhlIGRvY3VtZW50ZWQgDQpiZWhhdmlvci4NCg0KQmVzdCByZWdhcmRzLA0K
S2F1c2hsZW5kcmENCg==

