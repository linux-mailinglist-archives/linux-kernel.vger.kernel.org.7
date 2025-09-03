Return-Path: <linux-kernel+bounces-799173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B487AB42805
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428081BC03C8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7D62D46BD;
	Wed,  3 Sep 2025 17:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XWQlLlrj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061374C92
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756920862; cv=fail; b=E/SaLaqyjzKHd8UtdFdJnWb/r/06lXMBEkz8iSs941xKIleENoubCHEix7PcYg6lPbmlDlLuEFXWgykz39ysO4evbitoAhwTGgZw7ohOD1avYRFBoxdRfjpaoHwD43xbBaqtqDNU4BsYzPezwRIwaerEp+ASKQAtVnnEZympr6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756920862; c=relaxed/simple;
	bh=XS7LFifGquD0XCQb4i5qFkkDXJfD536f/Ym5kx94hNs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SqCftmxNk6lB7gETJRQyr51nhwRC0u7Tp2palTyzi4j+/zvMwalyDqmbNzh87BZC8RQsw9hN1MWzELW9VHNOUsb18kTv0lxpK2NDxBrXKWtaJSDrUamyGx3hERV7Gh9mhu7z5nYR/2vEikOl+fvLvfbxWY4CtUFNTcKSkJkc2/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XWQlLlrj; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756920860; x=1788456860;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XS7LFifGquD0XCQb4i5qFkkDXJfD536f/Ym5kx94hNs=;
  b=XWQlLlrjy5kHhzIsdVsnSEJWUaKLgAm3C17o0kQTlHcFSl/YHVBDL5iu
   uBS2WiBOVoZdOws3kGoiuVG/Y3Ia0AtDnjtHGm0UTrjIACN9nkIKtpjB4
   HSTsZugDcoV9L4dgEqbuJ5tqYKmHXVkWpEB7KkhLLzXRgsZie9h6VYJI5
   BuJRm4W3YEUupQ4x3YY4lQUmL9q7eIccBOV7bCa2e5v8Lo9kkIXZabVOs
   0R1paTlhKHV20LnCXjIQQPOdZoZFbw2UTNF3J4MYzqyF86sQ+GxlGQvvO
   tSSVLiZyqisKRsqsjs8++fpwHY2f4AiyIngDaCoksV+McBTQEPDAldYUS
   g==;
X-CSE-ConnectionGUID: fHJwabrpRTS5Dt12BSqhkw==
X-CSE-MsgGUID: BUiWeHP2T92Al14AOcADLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="70673787"
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="70673787"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 10:34:19 -0700
X-CSE-ConnectionGUID: vyaKOZg+S3yWfJVwCx1wmg==
X-CSE-MsgGUID: E9ENlPLeSkW2oseOsXbYjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="195300660"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 10:34:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 10:34:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 10:34:10 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.56)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 10:34:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M71IYw3QoQGdYH38E9ht/8ePtGHfaZnTv4pvZms4LAsqLuHIgLZa4vOtk1hGkignai2cfl5WOT31mleJTy0YwYGShdV7Iwm4YugjCku6TKUs+IvB31iBjscvDhw9uFZtcy022NPVnU+0rhFAGYfvgNS6lGGEucdDCwowfQ3WUd3lX9PN56bZ41c/yVfrTNj1jJW9yeDNMeQida99GU/Ruc8SNiaDJeIL00Wcv1ixRb00kgwuUpkYBVg2Rk8RDRSUyWdK5QCYpmkG52cVaizQXfr1z3iEr8wiTyf/L4++tNcl42Sj/74eTEB7+OFj5vVozcV0kQQiqJ4/Er6b6SXiUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWGZBJftGclvtWw7o5QQ58lOm86P7HGrBBgOS8Kq7Kw=;
 b=hBLlezvESVQsNA6a//IwmrIZrC9JVMuQE9rCafUiouxUECJ12GafcJNnX50e8YG+iDOLNddJo03CuLYf+qk+EO3AspVn/+7KvvdGwqJhd+N/X4x7KccJhYYNZ4VfDgmV9e1mIH+T1Tp9bhn3ir4+8+Gos9OHocfC3sWZb2RzpnX7X6OF9GEiSrFkU/rQ/DyNVShcKjhiStqAP3qk9yxMDo4d5krZAdTFiPi0m9XmXfuCeXbw5fxaFrVJVILQaeS1AVJPHmkIY7K5+SHbO6yTy0dNYjHwh4KrJ3akcCvKv98NhwSAYsLJUz3W9XW8+sD5wKdI4vn5el++o6a2cTcdRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ5PPF1170C8165.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::810) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Wed, 3 Sep
 2025 17:34:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 17:34:07 +0000
Message-ID: <e250561d-8553-46c1-a285-ddad10a15ee6@intel.com>
Date: Wed, 3 Sep 2025 10:34:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/resctrl: Convert lock to guard
To: Dave Martin <Dave.Martin@arm.com>, Erick Karanja
	<karanja99erick@gmail.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <tony.luck@intel.com>,
	<julia.lawall@inria.fr>, <james.morse@arm.com>,
	<linux-kernel@vger.kernel.org>
References: <20250903122017.1331877-1-karanja99erick@gmail.com>
 <aLhSlXbj+GNQzpJU@e133380.arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <aLhSlXbj+GNQzpJU@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:303:2b::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ5PPF1170C8165:EE_
X-MS-Office365-Filtering-Correlation-Id: acb2eeb7-ff02-496b-a047-08ddeb10158f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azR5eWtUbWpPbUtUTUI4bVRsZWxhT3JId1J5VS9VTUZyR3pHQ2NlbHl2TnEw?=
 =?utf-8?B?clBydVdZMXBNcTVNLzYrdGdYQ0pxMytEOHR3eWszZ2xhSHdsM0E2eGxScEFE?=
 =?utf-8?B?dHNVYUF0ZHI2b3NnMEJGWGREd214cU5Vd0Vib1dJdlRTMzM2MUQwNTlYM25y?=
 =?utf-8?B?TUhIakFzdElJOFE1c3E5enhhTGMxZnZTTncrQzJJL2hxUlRhUmFUQThPR3BS?=
 =?utf-8?B?VlZ5V2EwOHQyNWQzMTJYYk00TkNSZURVN1dBVVBQT01OV2ZCdDhzRnEzNXVC?=
 =?utf-8?B?TDUzaEU2NWE3azVUQTArWlBZbFdJd2pWM3JzUzl4WmptOWpybldHZ1FSa0VY?=
 =?utf-8?B?OG9LcWtXT004Y0JaUW1SUk9BWkMrWjdVa1QzTUt2T3Y5ODlBcE15d09zZ2Vn?=
 =?utf-8?B?QlZJd0c4RWZYZSs2ZVd0NDBsQVh5ZWJ6L3pFaDJ6MUF6UlAvQzF1RmFNQ0Yy?=
 =?utf-8?B?YjRHb2lqZklOcXpaalNwWExNMjEwR1crNHVKa211TjgrbHc1cCtLaXZJaDVw?=
 =?utf-8?B?YU04SUZSWEdOTSs3VzBhNXFlOGc4c0RJK3loc1FOdjJRT2dLVzVKTFByek9B?=
 =?utf-8?B?b0R0Zi9FSzJpazNkTFU0RW1Hd1Vxck1wWHVEaE5oNGkrMGFWejZ4WWVkNElu?=
 =?utf-8?B?cmQxelhmK1I5bEloME9xby92TDJrTHNzQ24vejZOR1d4RWJuSzFib0s3b2FB?=
 =?utf-8?B?UU1kZVNkZENjTXp0ZkZMc3pNeW5FVWMvWC8zUUJWUU9iUGdDYjExOWk4M0Zn?=
 =?utf-8?B?TFRKMitRWVRoQkFyZUtCTmxEUlZTQXljeENWYld5TXZYV0p4Z0FYdlVlS25H?=
 =?utf-8?B?WHBaOU01ZkJrM3RIb0NmVXdVeHppWFdrZ0RRb3J4Q3N0eEVxKy9DOHBoR3A1?=
 =?utf-8?B?YUdPRmNlaFBybHhCRG55TGxDblQ5T1BoUDNXUitLZitJMlFuZTJOQmYzdU4r?=
 =?utf-8?B?UVBXU051MTIxN1FUWkpKRjMxdXVFRHZlK0d3a3o1MTZjbmFkSHRURERRbmRi?=
 =?utf-8?B?QWMwYWhlYWVZYStLQXJ5Z1dvamg2VXJwYzZ1cWhxNzhQanViMHVuMnlDTCs3?=
 =?utf-8?B?b2c0TTVBZUNMc1FTTGdjWGlMcG1WMVBZTFMzTlQvNmZuWk5kVEh4d1VJQW9z?=
 =?utf-8?B?S25jNW5wRmZlR2FZNGtyQ05ONU1nbzM2ZWt2NlN1dGpzOGMyOWh5SmI1ZkMw?=
 =?utf-8?B?NjhueEkwdzMrY1lXcE4va3hlbWtNNmYram5Ha05hcGxPUU83MzFEdVRWMytK?=
 =?utf-8?B?WVlQZlgzaDN4YnFSenV1SFFLelU1RkFFaWw3ZlJ4L3c3TDdQYjEvRDBmZnE1?=
 =?utf-8?B?QVhPL1hsb1VpK1MzRno0T2R0bWpGcGJNK3lCdDE3SWNXdUx2bTJERVhiVE5R?=
 =?utf-8?B?ejE1ZFBXdGpvRlJoMEVwM2NySm4xeTYvTkp4ZXVCOU9nbzBpM1ZsM2JvLzBJ?=
 =?utf-8?B?YWZJSUFNaU0zRHFYRlR2ekNaYWJQNFo1aEd4bmNaaElZRUs0djc1Um5ZRWpF?=
 =?utf-8?B?dUw4RW9Fd3Rsd2FCbTBIdmRuVlQ1V1VhNllJQWJCOGR6eUxPTHY0WUdQMDlR?=
 =?utf-8?B?UFB3QXRZRWEvSVZKU3d1cVpMUkYrdmpMOWY0dFdpMGUyczYvb3NLQ2RReWVx?=
 =?utf-8?B?MDZsdmI0cDdCWVFtcTU3UE5oQzdENDZPSGU5VlJsckM5WGticW9MRTAwS1Zi?=
 =?utf-8?B?R01zL0xtc29ZaVhuYXA0WHltaDlQT1h5Z0tsVm9JNmxQZXJodlNhRkJEU0k0?=
 =?utf-8?B?Q3hkcklmV2s1WFZ6bjZIaFBJMXhSYk1MbTEwaVhqNHAreVpoVWNIQTFwU1Rq?=
 =?utf-8?B?ZFplVVJJNlNGMjJaK3ZhanRTcVVOMjZONzE3aWw3M3NmVWRoL1FYUFBiUkhO?=
 =?utf-8?B?V1g4NnFpUUpuSnZ3SGg1Z1FPcVQzd2EweGViMTd4WlJEbHAxUWd5SHF2N0xr?=
 =?utf-8?Q?iHOIQIXT9uY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmdlWFhkb2tOZmI1d1daSGtyWnZqRFl4VmxON1M3Vlk4R0RtYnVrRS9nRXBI?=
 =?utf-8?B?cWlQNk5TWHRRYmNZN3NNd2c0ZFJiWEViaEQrVmtKQ3BsRmNKNlVpeDY3c2Ev?=
 =?utf-8?B?ckdIQWx2bkM5TVdDcEtzYUFOR1NmUmhQYTJCTVRZR0pCMHc0L2xBZVlUeWhF?=
 =?utf-8?B?KzU5b0RkdWNQQXFnSHhoZVNad0EveVlpWWZwUWgyQzBkWnVDREE2eFFudC9Z?=
 =?utf-8?B?S3N3WGU2S3pwMXY1UUxVakVtdWFOMWJZc1Q0dmh0dG1tY0ZXMU4xcGtQbzZH?=
 =?utf-8?B?TVhFNzRzejNNSEVXMm1ObWVtVyttbWU1RUFVTU9wSVJWSS83QnlXS04zT1Q1?=
 =?utf-8?B?SHp3N3V2UVMxWEZIeERyMm9wOGcwc1J6b3FWei9Ha1lsWldJR1hSMjRpbVNr?=
 =?utf-8?B?VE5vM2lQajhaK1dwaFExWXFKanA4UmdSOCtiTCtJQ2Jpb1M0ZmJZWStNaWov?=
 =?utf-8?B?aVdQQklqZStHNmdxT3FmRFltYjBpZXpYem1WSW5IWFFGdTg1aDlqUSszSWZN?=
 =?utf-8?B?UHN2L1BSWGhoaDFLWUJsVWRWeHlaZGU5Y0N4YUo2c0FVOEwzSjBXaFNHSU5l?=
 =?utf-8?B?SjE1RVJ1RS9teXNYOVZnbHVEd201aTFpSnlyNmxkdVpVVmhZYmZ0VzM1aGFw?=
 =?utf-8?B?WENtSzlvTitWenVkVkVjTnJab1ZPa09hSzIxQnhoc2o0Qng0eG1lNXd1SURD?=
 =?utf-8?B?V2g5UWx4bFY2SHQybU5WMDNnUDNZR01sRnQveWVzUXBYQ1IrdWR1eW4rUURw?=
 =?utf-8?B?MTcweUwxSUpqc3V6ZCtTdXFXME1xMHdIellFbWl5dllsUDliRGJiSFQxdmVY?=
 =?utf-8?B?YU1zQTRTTTBwZjhmMzNweWl4M05KZ2NBckNVQWdPb1lZVytFZExnYmhXNGZW?=
 =?utf-8?B?dlhYZnNTbmU2aEcyOG12LzNjVkhPVDYrTEFJendzVnQramQ5cyswc0RETGti?=
 =?utf-8?B?WEx1SUdrRmorQUVMSUVCUjVyRmNMNENFbFpNdHFGdkpjaE51cWpFK0p5ZGFs?=
 =?utf-8?B?ZFI5Vjl3bnFtRU51Z0piQXNORU8xUlZyQzBkclliWjZCQjJ1R3NQd1lXaHAr?=
 =?utf-8?B?dmhNZXBndFJpZDQ0S3BaeDFOTmRoN3crUWtzTlgyc3RkSzRBMGwvQTM4aTh5?=
 =?utf-8?B?b0NTR216ajh3UlU4bXI5dzdjVGNJdGZPYlBXdlAzVDVpWVpOdHhyQkhRL3FT?=
 =?utf-8?B?L2ZkRG94TkJPVWRFRUU3NkNMR0s5Z1ZaRENQaktFNm9rdUxDOVgwZFN6YlZM?=
 =?utf-8?B?czRFYVYxU3hGR1MxZm5JSHYrYTYxZ0hkQzFEZitGdEkydldmcytzMlZoemda?=
 =?utf-8?B?MDl1ZkN1bUVwY01TMlBVTjRHa01xTTZJaUl3WW9LRGdxanZBajhiZVdPa3Ur?=
 =?utf-8?B?TDJ6bElQZHhRMGdMeXVtQ3F3UTUydFRZT3FRM1lhcWtMeWdlUDJVMThYSzNa?=
 =?utf-8?B?anZYTU5oVDk0OEs0UCtRMEFNS2VZK052em83c1RJV01oRXRvSWJ5QitzMmFH?=
 =?utf-8?B?VStKaW54Qzh5WlFqbHJvd01TQjh1ZW9sRjllWjJQNjZVRjJabXBYNGVwRWp2?=
 =?utf-8?B?M09XQW55QjNLZFpjcDliVXA0dTVUU285b29WZk5wQ1V5L0Z6bFV3dDNCMVcr?=
 =?utf-8?B?SElFMHpNRUdRdVh1V3N3VmtQQXgxem5EM20rSm1EVGRKSW1Ud0NjK0lKb3lT?=
 =?utf-8?B?U0JUR2cvRlpTZndhLytDbUh2ZHhaUWFQUUp2OVI3RjM2ZWh4TGxNVEVJT01E?=
 =?utf-8?B?YU01eGxSUmNMbXduTVQ1UUNwZUcxbUtOcERJMlhBcjVnNnQyUFY5MnRhSm1t?=
 =?utf-8?B?RkloWE9FVUpMcUF5akZ2YVpONENGa0NMOVZFQkdhem85UndaU2lHSHNic3R0?=
 =?utf-8?B?TjFrNHovM29weWQvRkVwNzlYbVRxRTFMbVE0TlZJT2R1VzNJOGRFQ01kcGJO?=
 =?utf-8?B?ekY1RU5oZFlrV2lWbU5yUUFZUngzYXFLamxuSEZ6dTJoYW1iYW40anRTUE5q?=
 =?utf-8?B?dnlwRVFiNnREVWkzaUhMelFmWWg4MnZVdzR0YlJvSmo3Rk9yK0srOGdrYlhx?=
 =?utf-8?B?K00rZHlIY0VnWElxNm5haitYeXg5cWpUTXhuMktuUTlLTWNmK0JyZG1oUmxi?=
 =?utf-8?B?bkF2dzRrWWgwZThEcmsvV2pMVmtlTUlaSUtDVnkzd0RTUWg4Nm9RSUJTS2Nx?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: acb2eeb7-ff02-496b-a047-08ddeb10158f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 17:34:07.1756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ONx+GW6WF4U3v134wFuxl6zPMacxJFsAID7cwN79SJseTVN+uO7CLdjd3wr616LIxY+oLvKDQETYFLzUVPcfzWHXrcBIPgnrIRrpu+eSe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1170C8165
X-OriginatorOrg: intel.com



On 9/3/25 7:37 AM, Dave Martin wrote:
> Hi,
> 
> You seem already to have been told that patches of this sort are
> unlikely to be helpful.  Greg summed it up pretty well, e.g. [1], [2].
> 
> 
> With regard to this specific patch:
> 
> On Wed, Sep 03, 2025 at 03:20:15PM +0300, Erick Karanja wrote:
>> Convert manual lock/unlock calls to guard and tidy up the code.
> 
> The very first sentence under "Describe your changes"
> in submitting-patches.rst is: "Describe your problem."
> 
> So, what problem is being addressed by this patch?
> 
>> Generated-by: Coccinelle SmPL
>> Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
> 
> Coccinelle is a powerful tool, but ultimately somebody has to take
> responsibility for the correctness of the output.  How have you
> verified that the result is correct?
> 
> Also, this is a lot of diffstat for what is really just a change of
> coding style that fixes nothing (or at least, you don't claim that it
> fixes anything).
> 
> While all contributions are welcome, they do need to deliver a net
> benefit.

Well said. Thanks Dave.

> 
> I can't speak for the maintainers, but given the pain that they would
> likely have fixing up all the merge conflicts that this patch would
> cause, I think that the benefit would need to be substantial.

There just happened to be a similar change suggested for SGX that provides
insight into x86 maintainers' view that I fully agree with:
https://lore.kernel.org/lkml/d9a76e90-7723-49ee-b3ec-85c7533d8023@intel.com/

> 
> 
> If you found actual bugs as part of this process, then that would
> definitely be worth looking at (?)

ack.

Reinette


