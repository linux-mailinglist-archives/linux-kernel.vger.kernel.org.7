Return-Path: <linux-kernel+bounces-846031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F9DBC6D22
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 00:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07DA24E3FAE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 22:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1882C08C2;
	Wed,  8 Oct 2025 22:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UiudEdsR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C3284039
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 22:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759963809; cv=fail; b=Z+NcM+zhFH1wCs5iYdlSwVP+foWo8CRpwfBJnJLFBV2GbbfNwcymN16RjKUktQUoQbMZfgSxuaKMUXXV/V4WHuvpw2NS9hHrktIp6Dbd7/4mK+0JZf3xhsyRIWYC40bgScRmL7WwNHyoNy0gc3E/g84KObmDtYfEJ6bOglIuVr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759963809; c=relaxed/simple;
	bh=ocrkx410AMUNyXAy0WOqTMMIX5miCVv+dkhg64SoyJg=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=FjwfJ2og35GgIXe8h4ZDUaTP+3UdI+e5lYfvkmOMYfbnDgpu1VuA0seTzwxMSdbulZLTUljmXwMOwEz2KRKIoOuS7iLdca7G2wcS5lRUkZWoIJeCH9EhkJ5JNrbxKQ/TpFgneK3hFppoF6AL58vfB6k404RqgT8NQ5CerqM4K30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UiudEdsR; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759963808; x=1791499808;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=ocrkx410AMUNyXAy0WOqTMMIX5miCVv+dkhg64SoyJg=;
  b=UiudEdsR4FBOUokj8Npad2Sj0JgxAIzWn87JzvihLgn7oPXmSrA4qFnH
   ywUDrSgbIyF1I3TnezWim3yRtWyU71E/IKs6KKcOMLJIwO3Ij6T1ldGsX
   HFFPdVxn/DW65A20VpxKxcQbd/M+ius0VGgNpSha6ut+AcYm4Z5CP3Fcb
   2A1C1jkM3C3sy5TBrxg8B1gS+DCZ0dMshRmFExRTiZHXH7hn9tEq84DQN
   hHRkaQ6/16eHJTLgNvdu/+1gLH5NGSKMjiB8cZBXoCrYWhXzebjOWShjy
   ItLGzQdb8AULDc901hzJn+kusWFCoXnSMZMItHtp23gM3xojghsQpbZV9
   g==;
X-CSE-ConnectionGUID: Snl5FpQkST6RLspm2uNPng==
X-CSE-MsgGUID: kcdb9u4XQHWZXcdHAgC3yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65994812"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65994812"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 15:50:06 -0700
X-CSE-ConnectionGUID: YBVSI64sSveo6VkaBX6hOw==
X-CSE-MsgGUID: fh7fMsT7TkS5idODsq0/EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="scan'208";a="211502017"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 15:50:05 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 15:50:04 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 15:50:04 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.41) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 15:50:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TyEQI8gsKUc/jm7J32jhP2xqIDDaPLRhWPki5tAMp6KLl0N8DjhsidkZaBxTNnj/TYAz5db9iVdYP+e+/9lEs0yfu56bBTC4lTDZO3IZqmXMkYzA+i1P80sPXdL2poLVO3asYVVnauZF+qcEb7rnAFxoT5ms9yGNanGK/0o0lH2elbz4jO3dRbGDYA+labqfs2FR0Wo1WQoA9hBKoOdCI1BeVLSVtaoA7gqC5WuQoQCxRZFwMf8f61SVy+gIT5emHXWnxyNq0nVd8zCocJyBc1M1w16Cz8tPIn24kIDbRlbZjYyomHM3kRAkCjxfUECqg5ydX5TBdCU3KkXloBulnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItYkmLdruA7A/yUrZUp54IYcb1w+Wqs6gbnwFvQnJE4=;
 b=JPyYj12Vp2vwDz7c68y4kJhs//IBL73DaoeGpBAWyonmhWrXAevAzmMG1xMLhcGcToIYkT07tDLTyRuWHtwd8bYfANFn/tSOTnFtjQ/PHPzHb2AOZfYxLkxVw3iJmol5R8hCEbOiO4y9TxXwzgjLaRg2qijs0jVKSd86jSFrV01BaTcQSpifOk3lljmeseiey/lradROZ4cYixAqdxEHFdUlPjNQsOREgKam7w0BWTvYcKobLPzw0NALEiXcHxq+W6c9jtZIsM+n78wuePjel6+QblAjNBKgRgGdvVtLhy07n5/ZEN/DqAhmS7f5mKsOg9njNJRYxYEZlmM3PX9XMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB6694.namprd11.prod.outlook.com (2603:10b6:a03:44d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 22:50:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 22:50:00 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 8 Oct 2025 15:49:59 -0700
To: Kent Overstreet <kent.overstreet@linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <akpm@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>,
	Eric Biggers <ebiggers@kernel.org>
Message-ID: <68e6ea973d318_2f89910066@dwillia2-mobl4.notmuch>
In-Reply-To: <20251004020049.918665-7-kent.overstreet@linux.dev>
References: <20251004020049.918665-1-kent.overstreet@linux.dev>
 <20251004020049.918665-7-kent.overstreet@linux.dev>
Subject: Re: [PATCH 6/7] lib: Give XOR_BLOCKS, RAID6_PQ config opts names
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0076.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ee53740-46e1-4261-fbad-08de06bd0345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXJNNzh1cWowSjRpcUoveldiRk51YzhVYkFNR0N0ZS9OajNoTmxSMi9vNEVU?=
 =?utf-8?B?MU9GS0hJMmhXeEZWa1V5S0lFdENnUDlOYWZzTkNOUDhtMzlORC9HbnoyWUxk?=
 =?utf-8?B?UFVNcm5qamlnUXBpZGRyLzBEMnBKdWRadXJEYnJJM3E5TDBnWDZnbzRBbXYx?=
 =?utf-8?B?MGJyT1ZrWkZQVk53UEtENkMzbUt2cG1UWDhPa21RbGl2emlHaW9rcGNKRVBD?=
 =?utf-8?B?U0k3UGZWUUR5aDA3dFNoOXlKb2tjRFJOaTVWWlBQdVd6UUxmUTFzSXJQeTBZ?=
 =?utf-8?B?L1RVT0lBSHkzRGpLTzM4ZStqNVN4T0JkSm9NZmFUdys2VXowa2VQbGFFclhJ?=
 =?utf-8?B?RUdHbmwyR1N6OURmc0YxL3MrUm84d1lOdEFnNGltTXBzcmk5cUxta0FSVExU?=
 =?utf-8?B?NXQvcFZHT1pDbGIxbG1NN2ExSmd2cXNva0dncnM5Um1sMmRNbHJBZWtUN2cy?=
 =?utf-8?B?aFZuUEFJNFNyV0ltVjcwZGYyREJoK3o3MlpIV2RCeDFjd0Rqc3U2cDJVbkUx?=
 =?utf-8?B?UUQrSG1GWjVKV1F4bk1LZlBsbExNQ1VQQWh5NXp1azFVSTBzUnJFbUxVcTV1?=
 =?utf-8?B?SVN0Q1R0Z0tjUElyd2RQRU9iRVJxRmhrREVqbUpJcXZ5VysrQnNxdkVCNWcx?=
 =?utf-8?B?dXhzYXpXemVOQTZnOVYyck1oREZwSjVkenY4TVZQUytFQVhkc1p5Rk9BRnVM?=
 =?utf-8?B?MHdwZ3ZDWm9Ha0dacTFybDBmblczN0NWZlBwdHlqRFhlNlBBS3ZXWXpGZ2tQ?=
 =?utf-8?B?VUN6QUVFbzR2eldwSE5TbjB0Ny9QZitzSy90cktFMlU0OWZ5eG4rNEU4eTJ1?=
 =?utf-8?B?Mk9RbG1RQ2FlalFqN2I5Uy9heUtZMEVpRDJldUIyTWt0QjVndEd5UzZSRXVN?=
 =?utf-8?B?cXA3TSs5Ty9tb1BoQ1ZnSjF3RzhuREpiRlhFQUR6Rmc3ME5mKzExNGFqOTFL?=
 =?utf-8?B?MkVtNHZLa2JhZWxlYi8rcGhlZ2hLeFRyTGs3TER6cUpXSGNQcnhqVHRiY1Nk?=
 =?utf-8?B?Sk9VSXAxQmt2d0dFT2N0WTJYUzJObjh4MXNKaVhOREFqTXJndXl5TDhMMmNj?=
 =?utf-8?B?Q2VPMWhhVlByYnZWaGZBSTVrL25yR3ZCS3gxdHVpM0huNU5ZL2wvTkpqY3Bu?=
 =?utf-8?B?VzUzbnhPdjFzTmxNSnhyNVhoTU1KSFZ0Zlo3Q3BvajJ6MnJnY0tXZE01Vnd6?=
 =?utf-8?B?Q3k4eDdFUWVRNEFmVHZyT21mYXVJdmQ2Y2dQRDJaTHc1UFAvSTUzdERFN0xL?=
 =?utf-8?B?blBBOTFUcm01Z3JTTGNpMVdXR3I3M3pKOUMyaGpaRzRnMjRYdVlieDNDZ3kr?=
 =?utf-8?B?dkxFaVlqVC9xR2RzanhCSTVpTVRWSGZRZ3hjQU9GODU0b3oyL1k3MTdGQ2cx?=
 =?utf-8?B?TFhPTkNWMFVuL3Z1WVVJTm5VWnQ5T1krL04xZ000dlhlUlVGbHU5VHZVSXRS?=
 =?utf-8?B?VkhoK2lpSkx5ZVh0KzNZS3BCZGI4VExUYjhvVmdxQm5udkFZQ0hXQnoxY2o1?=
 =?utf-8?B?S25kRWt3OU85K1diVTZpOUg0MW5hYjdQUEdkK3BUMGFoL0Q3Wkl4UmpMZ2ZK?=
 =?utf-8?B?SG1DNmJPV3lScVFCdjRIQk9qUnN2akIxeWpNQU9SQ1JzT0dGL1YvRmp0Sm5h?=
 =?utf-8?B?QWIyRW42M2ZYMEYwL3hFNjA4Wk1PSG4ya25sVUZPR2h0Y0x4N2Zyb2Jsdkh2?=
 =?utf-8?B?MUlBM0RXQnFxMENBSzdocEZ4WDlpT0l5TDFBS1djR0xuR2E5TlZJUFMxanIv?=
 =?utf-8?B?aCtjYzZNSFFZUFYwaEN4MVVYbjhqei9hL09yajNwYlFsSVNJRGxUS2dNYndx?=
 =?utf-8?B?OWtCYWFza3MwdTh6Z2ZvOW9JQlgrVnYrMC8wdGlhR0tyL0tWbG4yMG5rZTYw?=
 =?utf-8?B?d203ZTVpUHRGOHh5YnhIandlRnpmMk1aNk5rU1d3YTVpeWhUYU9Cc0VYY3g5?=
 =?utf-8?Q?Gi0BChOk1C7a8Ub9Gv6qJZPW3HHzGjiA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmQ0MXNNeW9xM2s3ZHBFY1JSbFBjWmczd3pyaDYxL0h5ME9Sdk0yOVMxMG1B?=
 =?utf-8?B?TXBLWGdCQkZoL1dkNWFSWnhzWE5wbTFScWxsVTRMYW5FejB2RVV4Y1dQY0N3?=
 =?utf-8?B?OFBZNkVjZUhEbnlzVE96cTd4c3gxRERkOWdpcTJKQUdGTkxOdk5ObSt3citk?=
 =?utf-8?B?Q3JSSWdnVDNOM3VGUHQvNis2MnpsWDhjckNLNVE0djd3Q2JqU25pT1J2LzhJ?=
 =?utf-8?B?TzMxUXo1MmZZNzByRnRHL3NHaWdSSWUrSFRJWnpSeHV4eS9xNTV0dTZYbEF3?=
 =?utf-8?B?L3F6dHhMeVBNb3k3VkREN3gycVZqQ3lyVU5zOWpZOWlPQ0U3cG51YThkOXNj?=
 =?utf-8?B?eEZ1Mmw1WFBta1czNDEwaE9kSGpRNExKQjRKck5xeFF0aVU3bzUvYk1VV2Vm?=
 =?utf-8?B?bXZ4RXZqTTMxYVlDSlJ5MDVyVWJHTnZ0ejhxOUhNdWZEN2lleWtnWHBkQUtm?=
 =?utf-8?B?YWNBeEg2RW55elFlWVByVm45aS82RmNzV1pQajZQTWdOaDZSRmJrM3U4M1JY?=
 =?utf-8?B?WGNIbDR4TjZSdGI3T2g0eGJraHF3M2JtYlFTZ3hvOGoxVXJRNFhseENkVmVV?=
 =?utf-8?B?RERXSjJ5NlpqRTZFVVc1NmVGeDVmeGlrUFdFc01Odk9VaFU2dlM4WXpnaVFx?=
 =?utf-8?B?QVhKMk5BdkxncDFOeFBFQkxYWHh6a0lLbDMwSTlBVnl4anF2a1FiaWJpenNL?=
 =?utf-8?B?TmxKb0pyTHdEeWIrcnRjZ21XZ3VuZFhBOTFrUGMrZHRoeHZFb08xMktqZTF3?=
 =?utf-8?B?cktLWjZ5Tm5pU2FnSDdTR29DaXppUFovc2NkL0d1RjNaMm90OHVVR3ZsbFJU?=
 =?utf-8?B?djQwYVVsTXpmRFNMa1V6L093MkJrdVFtVjRFVGpTZjkxcTBmM2VEb21iRUpM?=
 =?utf-8?B?aE54RjNrMHJwVmhubVR2enNRVkp1K1lGVS9qcjJ2V21iRlpEcDRJTnF3TTFH?=
 =?utf-8?B?RTVDNENnSWkya216cVI3RU1tbCt0b0gxTzdKWEIxczA0L3dFOVl6c1hEQXV3?=
 =?utf-8?B?eUpDdWVwQVRkeXd6dm5aTjRhd3dKMENNdXk0am5iTFA5UkZJdnRXcUpueGNo?=
 =?utf-8?B?YjVoeEoydGhiSmNOVEZNNDZpejVjS2xMdjcyRk9SbzdCVXdqcTJXREY1US9L?=
 =?utf-8?B?WU1TY2tCSFNvSjk3Y3lrVkV5NVh3OWdoZHZ3UlIrQWZLZHZLM0l6eENicTlZ?=
 =?utf-8?B?TlV3M3AxdUxCQjRGVUVhMlkybSs1NXVmNkxsWm0zU1REeUpVYjIxc2RzU21l?=
 =?utf-8?B?VGdqdGhWbG1udUIzZTI4MDlNNmRVZDZDeXdvNlJLVERSd2k1VEhOU3ZEOEZk?=
 =?utf-8?B?dXpBM1hPaHI3MVh2WjlNTzNiYUJ0L29aUkZ6TGxvd2ZWTlhQaFE4M29tVE1w?=
 =?utf-8?B?ZVBRV281WHZmclZmaHF0Y1NVdit0bmZtajAwMzA3RTI3c21XSm1XVHl4eXB6?=
 =?utf-8?B?bWVLcURTOVgxUkVpVWpGOEcvZkJlMU5kUTBEL25kckRXaDVhbXZ3VGdMVXlu?=
 =?utf-8?B?VFNjY3RSN2hQN0ZsS244YWR1Uk9GSTExcHA0dFlYbVErQi9FMmw3dlZsSDh1?=
 =?utf-8?B?NmUxVTJHL3JmYjhYdFdCT3lRU0NmOG1hQ2ZFdEhwM2dlb2E3OG1RZ3VPUU1F?=
 =?utf-8?B?aDBHaWpzckdUWWVRMlJUMittUStUNmFrRWE5c241aXlGVytlY0JmdGdCYmVn?=
 =?utf-8?B?MEVYRHlhQk5Eei9MUXpNMGRtWGZMOVBzdFEvUzBRMmlPejJEdXdtdHdjVU1h?=
 =?utf-8?B?WWcxb1JGRzl4ZmlJMTFHeG56WFg5L0NjcHViTFM3SFlqOG5xS0ttT0srd0lR?=
 =?utf-8?B?V1k3Q256V2VYcjBOSTJSYmNOZDlBcG50UnR5NHh4d1BWQi9VZE0rTFR2aHVW?=
 =?utf-8?B?ZHpMVkp6MFF5ajFwdVBPbW5EVFdRNktzQTlQOC9WNFIzUFV2eUljWXZySUFa?=
 =?utf-8?B?dzhIR2IrME9mSnFFRHc3azBOaHA0ditsK0JpczZva0lKeGtTazE5ejQ3eUl0?=
 =?utf-8?B?WFltcmNrdzlyUUN0cStKbUdVS1pSNDZUYkJxYm05MmdlOGs3YzBmN3F5RzVH?=
 =?utf-8?B?dFkzYkEwMkE3WlRydGlISXJjVlltSVM2VkM3NUFNZnlVV2l4MkdFV1h4U2c5?=
 =?utf-8?B?ZmlEakEzN09Qall3UVl6WTFqMk5hbFJGY0p4c0k1OXlYMW9zSFVpbi9tckJy?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee53740-46e1-4261-fbad-08de06bd0345
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 22:50:00.8566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTc+mvnPE7XDE1CBi05GYw5pb7b6rqKTSjOga/WN987hHM75oJzHNxg8Lu6j+G/h59TenThRDvmDRn8m5ALunwDncMAKIUSjjdlbRSYby9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6694
X-OriginatorOrg: intel.com

Kent Overstreet wrote:
> Give these config options names so that they show up under the "Library
> routes" kernel configuration menu, and can be enabled by distributions.

A distribution specifies a kernel configuration. A distribution that
ships a given out-of-tree module can arrange for all its dependencies to
be met.

> These are needed for bcachefs to be built out of tree.
> 
> These libraries are both for RAID5/6.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  crypto/Kconfig | 2 +-
>  lib/Kconfig    | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/crypto/Kconfig b/crypto/Kconfig
> index 23bd98981ae8..da4f072abae0 100644
> --- a/crypto/Kconfig
> +++ b/crypto/Kconfig
> @@ -3,7 +3,7 @@
>  # Generic algorithms support
>  #
>  config XOR_BLOCKS
> -	tristate
> +	tristate "Accelerated block xor algorithm"

For example, the approach taken with the CXL unit test modules in
tools/testing/ is to have them assert all their dependencies.
Specifically, tools/testing/cxl/config_check.c validates the test
environment rather than giving the out-of-tree module the ability to
select symbols.

Now in this specific case of XOR_BLOCKS, if a distribution really wants
CONFIG_XOR_BLOCKS=n in its main config *and* wants to ship an
out-of-tree module that depends on CONFIG_XOR_BLOCKS=m, then that
distribution needs to provide an xor.ko to meet that dependency. Not
make upstream carry a patch to make that symbol configurable with no
upstream consumer.

tools/testing/cxl/Kbuild is an example of building a set of in-tree
modules as out-of-tree modules.

