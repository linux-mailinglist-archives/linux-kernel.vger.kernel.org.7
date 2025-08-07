Return-Path: <linux-kernel+bounces-758835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 490FFB1D463
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 10:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10E0B3B35BA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A6224BC07;
	Thu,  7 Aug 2025 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JNmz/KGq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF8D256C87;
	Thu,  7 Aug 2025 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754556161; cv=fail; b=tY6m+onpFhiSRNHF9l2edxu7Y+msxML9G1SUnStu0vemRR8yw05fiSumAEKUes6sceGo57kV3nXSfC1Gg8Flpdu8OLpqoZJvc1ZWf1SmPfbZB/ylbEMlrO/7R0pY4H2WiT9oNjZzBM+c/4L7avPH6YHxqZieHfu3WBBTc73XBhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754556161; c=relaxed/simple;
	bh=TTazOMRR5AKJyk8YnzZGyFuUkdmGOxUyihb8bviTZKo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tWWD4kK2pNxX1Nh8Ih4GikkB48QHu1JPRu1/a4Rf4LSOXz7iYolyXnEPChIm1kBJKF5VgX1QZd4XEG14h61bDQRvI5cef9L3YMHTS2ODYecN+RglBVeEOzqpsXxK7kCItjvzAtYlSxgqGG833EzUi36Nv6ZVHKlqQKVcvjIps4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JNmz/KGq; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754556161; x=1786092161;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=TTazOMRR5AKJyk8YnzZGyFuUkdmGOxUyihb8bviTZKo=;
  b=JNmz/KGqzHwJBaZXw0g/m6jeAmFt41sBLH0KikQVS2PCwiWCOzuzlpOe
   bq1hqK8t5uPV3+6d9ceZANkKz7HGxh6+StRKljpnaKGlH0HH/X+dMLHMS
   VENS+uVFkDOxKKHxtPi5/lplgCWDtiGwtFQRCFymleQsm5JSe+J6x6pLS
   u9t+/zUlfweurC99QFHPokrQimFje6u18uPGI1W7Op+a8zU+OKEDU1MOj
   EJEEf5+K51JpM6wytzZG8K6fEcMcDYl72EzKmwEGq+ksN/emxw1qrDQJf
   qRMT2smLymASLlT8znxAq8XwZ6bU3wa7O/Ri4iKM6+rtddhV+1oOmXSoI
   Q==;
X-CSE-ConnectionGUID: e8/gIls/Q6mOoaCKY1hGEQ==
X-CSE-MsgGUID: TXC9PtaQSteQiwvFiFD6Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56754638"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="56754638"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 01:42:40 -0700
X-CSE-ConnectionGUID: Oo02G2eDRsuz2LWrC3U0VQ==
X-CSE-MsgGUID: 0qsYX5YdT6OU3Pbh6z6+3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="165420207"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 01:42:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 01:42:38 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 01:42:38 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.44) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 7 Aug 2025 01:42:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HqWnkQ1C5Qd+O56l/09NGkNyGi7nmmgv011eBDX9rvtub2nWDdX8IKVEBsVg11pKAhgAM1VAAf61ROdSqtaJiVGq5Fo2y5paM4mrn2w886JAR9LW3eiFdHglJCcouXxVBygLyox/mWOcKmGi5C9Z4vNVO6fZT6/3G0qCuME6k5eIRaTsoKVemph4fGfgB8uVjqT7A+EC/j5CmIgVl9b/xdc68SS3J8vz/3Wmqw1gGX1Sp56UYFFxSz1bfv2oOGWEDrAXV3DIY6+E1dnq/79tjzjo2+ci6j40vv7yW/SOJNFVnrobfuq6Azz79NALxkHzCVtA8mem8xFqxcf30vmSBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eS2y2gURR9g1sEQBGVNG3uUvoB4bga3447uauP2Zr6E=;
 b=ao4uNHrvfVSFpBxWIdKL0+DsYZIRUaYPZ++ankq/JkbEDc/dBWXj5Rg1q9A8O/NUuU1Z9IJkiwbKvIp8uI4mUylJfxFUtUe5FjpiM5bv4PNvOkoi+pT4g0f3HDEPyiuSbCHlSE5hTsFXKqoOxC98ReEipMjZePnvOqwefHFGYfTrnHQqBy9YLphwCTeKN9goNLByoWaNrZWYdpgxAqxCvn/Y0G/DXsQTlNLtnhRCYexJs72YTM+mXngOBM94YTBiyUwygVFvUGontAkAE/YSQ5doyE3UbeuG/z5nQmnM+2tbIxml6e+FB3It3lVv9MmRQ3T6qwZjVIcnZGejjCL3GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY5PR11MB6258.namprd11.prod.outlook.com (2603:10b6:930:25::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Thu, 7 Aug
 2025 08:42:35 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 08:42:35 +0000
Date: Thu, 7 Aug 2025 16:42:23 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Igor Korotin <igor.korotin.linux@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, Miguel Ojeda <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
	<gary@garyguo.net>, =?iso-8859-1?Q?Bj=F6rn?= Roy Baron
	<bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v3 3/3] samples: rust: add Rust I2C sample driver
Message-ID: <202508071027.8981cbd4-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250801154506.14810-1-igor.korotin.linux@gmail.com>
X-ClientProxiedBy: SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY5PR11MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c907cd1-71a9-4579-aff8-08ddd58e5b31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jKhbHUqe+MDxZrQj74RdK033wXA1TGuNXjnNudjfIpD5KrDA5zCOXfIdh5OA?=
 =?us-ascii?Q?l9I/z+7BQbGQcMK319pqSruHRkvHdPQZokhnHZUVmcSiPhS/IzlSPAyjyp0H?=
 =?us-ascii?Q?4Ven9ut5yT8BcDVftFcZ0ffShQMmZP5GSMFeLoGOrfxz13a/30trFgUxQv5U?=
 =?us-ascii?Q?wFYunhpZ5p/Um+v0gxpVDTvy/Sy+jkXiKBANy/Qs545G4pD8W6drwhXfjKjJ?=
 =?us-ascii?Q?0ZXd44Xqd6hnbDiQsH35Xt8XIftATZI4SxdAAdU5zBQY0xFzrFNReDLfmoY9?=
 =?us-ascii?Q?QfIxt6i0Q5CXSeiGVFqtqlNPY/f8MHZd7vmH43boVWVMweHEePmCVfjzUkuG?=
 =?us-ascii?Q?+E5EQ+ou/fhk1KdTBV5hkWe0f4GEIE/Y2za1ZF0qCJdI1En6NGK+OVNU1R0K?=
 =?us-ascii?Q?4OyhH7t8YzzMbO9eYe3b78eVrXIH1vx6x4Fig4a3yuLbGs7gDiVSN0XgrLQr?=
 =?us-ascii?Q?p4n6VbUmplEy1r6hZPAu9aM7egm7YshQWgYZclOS/eRp7pMOkMigL0OuwkoB?=
 =?us-ascii?Q?A8Hqn5xsQOlqeOqlA6ANdX++W8IWQhr6Ri5/TOJlx5d4Ne5Ve4GnJq6aG6Rs?=
 =?us-ascii?Q?q1miIa0aM3jCvp2QitrsTqo4ukRNHlRbhFYL8bjDjTL8MCVscCXr/KWwsCnE?=
 =?us-ascii?Q?obMBmcssxJH+OpryHkPDZo0JML3DgoyWKIPXe7wfyiHQUHnJRcxMWVAy51uq?=
 =?us-ascii?Q?JS16Wtm1cdtqoxgc0VS6YlO9EVaN4iQaQ3btaAwHhBonIaClydvfyfdDdCWt?=
 =?us-ascii?Q?WsjH4UGnPX0LIW1lgzA7VWf6qxPZY23cSzpJ99z05A3tsSmKFB9udPKHaib9?=
 =?us-ascii?Q?A7PysC+57R160d4M3NJlTpTh0jSjiWenT+hEL92s1qwhoXjWiA95P+y3oIny?=
 =?us-ascii?Q?Xt3XhKmcmFyuzonStZvIwSb0ayUGoK2y4dppOsAqt8S+g3yDLLr2tZqB/mIJ?=
 =?us-ascii?Q?CtqdLhnejR+KicsvCuTqatdHBDcTe+KP8I4aoRnHhTDrTwCVMItWCaEoAZHY?=
 =?us-ascii?Q?PHrG6m19d9DdlDn2jSuCyVfBJmEU4ccu1K0Q4G5VWhv7U5LP+5AllO3nQUcw?=
 =?us-ascii?Q?i3YbD+SW8NPM+1PDRWeRb39TB2ARQcGL1NBLRxLX1qQvxkDx6khYY2Dq/sBV?=
 =?us-ascii?Q?BLN+k/pMVm/GItRFaO6WWe1jFKquWIxE+OosaF0ZW1FpEfTlxwcfV3ww0QoX?=
 =?us-ascii?Q?YpGzg9mSp1baFvAOB9ydBi0+rya8RqxCTwh0srbJ8COSOkIsyNZ0ntRMzILE?=
 =?us-ascii?Q?3bDdbVieOOybjwpOxcvkMt7IZVdQsJPqB1Ottwt/sPwaWi2oUoS++EIZaonL?=
 =?us-ascii?Q?2P3tbAlQRAzRe7puN8znNfjTff3KLR18+RpOJNMhrlWcsaLUe1tVbXzj6gjK?=
 =?us-ascii?Q?6ypW2VamqLM0cBGaj5vo9WgF98ac?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3M2Q+WdGT6IaRvVLE8ePGaLtMgL+bm3goS5EOydxI/Gd+P39D4oASpjpR4ch?=
 =?us-ascii?Q?iwne4kyDAx+jvJ2+oPmKyEeQvsLA8uMiKLFJ8JUtvEo+p7v3xpgVjzUpbrvr?=
 =?us-ascii?Q?F+KPEZnkFk99QYVtWxSS7ldxrGCsaCttLO+znQGQFh4wIrcJf/Q7HFHcPmZ4?=
 =?us-ascii?Q?EaEziRQkg1k85oaM+Mwiygttui2mUDNccylEDrjWiMeRm0VDuZLD9v87gGKF?=
 =?us-ascii?Q?7ASbM19Y+s5qRfrI2RbBJnHZupaK45v8hzgJ82tJ3Ro6jTuUZ64snOvqdBZK?=
 =?us-ascii?Q?LkOrlRiEYMckJ/9rtGdHTb7w35x1f7Ixmk3kmzbuTy24eumi1lkolWCkXT5y?=
 =?us-ascii?Q?5LxS8f1Q7UjG8ezUh/z/ClmE89eoWr6HPH3wtihIoPikXsZva0IZxpJLAThS?=
 =?us-ascii?Q?HWkclfpKVeeVkVNADNRgTHZ5qzsdu552sRsSohi8LVfeWRW71ego/LJHOVQ6?=
 =?us-ascii?Q?Lq2s+ytxnAjG75xuH7qlAqne6ahzGZLbSXbArzmRCJj6c0v9xgwBltls1uIl?=
 =?us-ascii?Q?XLGB2jv4hP20SnHJo1ajbPTXHqqM/7iDF7JsBnX6/YA7CKOVibNVK0U9RO8r?=
 =?us-ascii?Q?fUDBV1JzCgbp1ebAsdWGKtFsHH4BkkSAK3PPl+AvwrAwQTd4Aa9ucPGDwudh?=
 =?us-ascii?Q?DbfBB+Naqods/0m7xMYQcT7FfXXTLHTKzD5ikU/ap6qRkUajVTiO68/Fn6CX?=
 =?us-ascii?Q?0Ck1onEIjgpNoAkYQp4FNCdNeIhCfyf6znum7TsapbkEtNp9W6dVKiIgPOtY?=
 =?us-ascii?Q?2jx5EVot1iAUUxeWzmlSqgY+GHWOfLK2e05maAv9wJn2yd+tmJNnvq0eCUgE?=
 =?us-ascii?Q?xPS3dBra9kr7htbC/bZOKkOmqtTtB5FjpYzTj88KIrnmcGhPJSB8VbWjLrY3?=
 =?us-ascii?Q?9wNe5kmwmEfUro3FtP8b6jgkNbvR3Dsb2SS/H0VCBQKZIFZG30Y5Wh0gLaai?=
 =?us-ascii?Q?eUOWRKz2MsjWYWmjwW6CuQW0CeZaL0bk79AemlHVMgIyOVfEgvgxBssosLgh?=
 =?us-ascii?Q?RAiapbUg/g/cz9h11xeWh/nJoqlVFuYng1tbASYRfavaz61NzseIa6G2/X/5?=
 =?us-ascii?Q?r/qO4I7S91fZT5SdtzarDaFAWoWYI6r+0pLLYhw/gsjlCG6Sen/eWUsexWgO?=
 =?us-ascii?Q?GUT1J+c/nzVmRUyZjmRqsYYI0bu3rTGulcqKtOgIKW/6x01zoBRaL1ovaHTz?=
 =?us-ascii?Q?NDsI3lg90gxC2tKqO6C6vceCEQ6Y4mAAEq31FB96dCOr6K9tmdG7svK45PRN?=
 =?us-ascii?Q?Kx6gXdU5PlTc08byLO/aUAwZCtb6rqdRuzDp2KXa9twOdCTF4KYEghddJK90?=
 =?us-ascii?Q?z6QnBjEG4RUCXPRTi+0URmMInE25/0DuceImpFY8FvHrccv9BUpkbM/TkqKK?=
 =?us-ascii?Q?JZvip1wjVilefGgmhwL8kgqbeHQWr3I/VAJ31Q/PvQWWMQiAmGf5jtaR2GOe?=
 =?us-ascii?Q?LOXwhA/s2+xCPW9qmrDQwNQq86Q+a2ZB1I5OiWZOn+UNeTHQnpvuYOMsmljC?=
 =?us-ascii?Q?1N0klbE/EGRzHcvAlaPhLr4lpwKTr0vPweZnDOzlvXcIr5Lg2fBnXFJNUzcu?=
 =?us-ascii?Q?HhE1WW4xcfzDiK1ro7g56NBNTTeTybVsKxhagyZNf5v03XPXOmkgRiR+DP1I?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c907cd1-71a9-4579-aff8-08ddd58e5b31
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 08:42:35.0607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q8Z6JI7us/bxPFmyGLXk81eiQkSWl8DgziZZvy2rQyxgiafAs26ur27XDoOuPmrJQ97mWBNx8YHwnV/YGyyAOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6258
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_rust/helpers/bug.c" on:

commit: 65aee29875487338caa52e3a4ffc41165d4798ad ("[PATCH v3 3/3] samples: rust: add Rust I2C sample driver")
url: https://github.com/intel-lab-lkp/linux/commits/Igor-Korotin/rust-i2c-add-basic-I2C-device-and-driver-abstractions/20250801-234859
patch link: https://lore.kernel.org/all/20250801154506.14810-1-igor.korotin.linux@gmail.com/
patch subject: [PATCH v3 3/3] samples: rust: add Rust I2C sample driver

in testcase: boot

config: x86_64-rhel-9.4-rust
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------+------------+------------+
|                                          | 6c0f429b5b | 65aee29875 |
+------------------------------------------+------------+------------+
| boot_successes                           | 18         | 0          |
| boot_failures                            | 0          | 18         |
| kernel_BUG_at_rust/helpers/bug.c         | 0          | 18         |
| Oops:invalid_opcode:#[##]SMP_PTI         | 0          | 18         |
| RIP:rust_helper_BUG                      | 0          | 18         |
| Kernel_panic-not_syncing:Fatal_exception | 0          | 18         |
+------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508071027.8981cbd4-lkp@intel.com


[   17.294743][    T1] ------------[ cut here ]------------
[   17.295458][    T1] kernel BUG at rust/helpers/bug.c:7!
[   17.296172][    T1] Oops: invalid opcode: 0000 [#1] SMP PTI
[   17.296925][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.16.0-08688-g65aee2987548 #1 PREEMPT(voluntary)
[   17.296974][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 17.296974][ T1] RIP: 0010:rust_helper_BUG (rust/helpers/bug.c:7) 
[ 17.296974][ T1] Code: 00 00 00 00 00 0f 1f 44 00 00 48 8d 87 10 ff ff ff e9 cf 22 82 00 cc 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 <0f> 0b 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 e9 e6 00 0a 00 66
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	00 0f                	add    %cl,(%rdi)
   6:	1f                   	(bad)
   7:	44 00 00             	add    %r8b,(%rax)
   a:	48 8d 87 10 ff ff ff 	lea    -0xf0(%rdi),%rax
  11:	e9 cf 22 82 00       	jmp    0x8222e5
  16:	cc                   	int3
  17:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  1e:	1f 84 00 00 00 00 00 
  25:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  33:	00 00 
  35:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  3a:	e9 e6 00 0a 00       	jmp    0xa0125
  3f:	66                   	data16

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   9:	00 00 
   b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  10:	e9 e6 00 0a 00       	jmp    0xa00fb
  15:	66                   	data16
[   17.296974][    T1] RSP: 0000:ffffd25cc0013948 EFLAGS: 00010246
[   17.296974][    T1] RAX: 0000000000000080 RBX: ffffffffb55c2ea0 RCX: 0a0c9e9b2c6f9900
[   17.296974][    T1] RDX: 0000000000000002 RSI: 00000000ffff7fff RDI: ffffffffb651ce50
[   17.296974][    T1] RBP: ffffd25cc0013e28 R08: 0000000000007fff R09: ffffffffb645cdf0
[   17.296974][    T1] R10: 0000000000017ffd R11: 00000000ffff7fff R12: 0000000000000000
[   17.296974][    T1] R13: 0000000000000000 R14: ffffffffb7172dd4 R15: 0000000000000000
[   17.296974][    T1] FS:  0000000000000000(0000) GS:ffff8c5bb8b33000(0000) knlGS:0000000000000000
[   17.296974][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.296974][    T1] CR2: 0000000000000000 CR3: 0000000048420000 CR4: 00000000000406f0
[   17.296974][    T1] Call Trace:
[   17.296974][    T1]  <TASK>
[ 17.296974][ T1] __rustc::rust_begin_unwind (rust/kernel/lib.rs:213) 
[ 17.296974][ T1] ? <&kernel::str::CStr as core::fmt::Display>::fmt (opt/cross/rustc-1.88.0-bindgen-0.72.0/rustup/toolchains/1.88.0-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library/core/src/fmt/mod.rs:2636) 
[ 17.296974][ T1] ? work_grab_pending (kernel/workqueue.c:2064) 
[ 17.296974][ T1] core::panicking::panic_fmt (opt/cross/rustc-1.88.0-bindgen-0.72.0/rustup/toolchains/1.88.0-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library/core/src/panicking.rs:75) 
[ 17.296974][ T1] core::panicking::panic (opt/cross/rustc-1.88.0-bindgen-0.72.0/rustup/toolchains/1.88.0-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library/core/src/panicking.rs:145) 
[ 17.296974][ T1] core::option::unwrap_failed (opt/cross/rustc-1.88.0-bindgen-0.72.0/rustup/toolchains/1.88.0-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library/core/src/option.rs:2040) 
[ 17.296974][ T1] __rust_driver_i2c_init (samples/rust/rust_driver_i2c.rs:104) 
[ 17.296974][ T1] ? blake2s_update (lib/crypto/blake2s.c:45) 
[ 17.296974][ T1] ? add_device_randomness (drivers/char/random.c:952) 
[ 17.296974][ T1] ? <rust_dma::DmaSampleDriver as core::ops::drop::Drop>::drop (rust/kernel/driver.rs:127) 
[ 17.296974][ T1] ? <rust_driver_i2c::DriverModule as kernel::InPlaceModule>::init (samples/rust/rust_driver_i2c.rs:104 samples/rust/rust_driver_i2c.rs:104 samples/rust/rust_driver_i2c.rs:104) 
[ 17.296974][ T1] do_one_initcall (init/main.c:1269) 
[ 17.296974][ T1] ? crng_make_state (include/linux/spinlock.h:406 drivers/char/random.c:363) 
[ 17.296974][ T1] ? get_random_u32 (include/linux/string.h:366 include/crypto/chacha.h:119 drivers/char/random.c:425 drivers/char/random.c:554) 
[ 17.296974][ T1] ? __get_random_u32_below (drivers/char/random.c:568) 
[ 17.296974][ T1] ? allocate_slab (mm/slub.c:2578) 
[ 17.296974][ T1] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1050) 
[ 17.296974][ T1] ? asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
[ 17.296974][ T1] ? parameq (kernel/params.c:81 kernel/params.c:91 kernel/params.c:99) 
[ 17.296974][ T1] ? parameq (kernel/params.c:90 kernel/params.c:99) 
[ 17.296974][ T1] ? do_initcall_level (init/main.c:1315) 
[ 17.296974][ T1] ? parse_args (kernel/params.c:153) 
[ 17.296974][ T1] do_initcall_level (init/main.c:1330) 
[ 17.296974][ T1] do_initcalls (init/main.c:1344) 
[ 17.296974][ T1] kernel_init_freeable (init/main.c:1581) 
[ 17.296974][ T1] ? rest_init (init/main.c:1461) 
[ 17.296974][ T1] kernel_init (init/main.c:1471) 
[ 17.296974][ T1] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 17.296974][ T1] ? rest_init (init/main.c:1461) 
[ 17.296974][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:258) 
[   17.296974][    T1]  </TASK>
[   17.296974][    T1] Modules linked in:
[   17.339320][    T1] ---[ end trace 0000000000000000 ]---
[ 17.340041][ T1] RIP: 0010:rust_helper_BUG (rust/helpers/bug.c:7) 
[ 17.340745][ T1] Code: 00 00 00 00 00 0f 1f 44 00 00 48 8d 87 10 ff ff ff e9 cf 22 82 00 cc 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 <0f> 0b 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 e9 e6 00 0a 00 66
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	00 0f                	add    %cl,(%rdi)
   6:	1f                   	(bad)
   7:	44 00 00             	add    %r8b,(%rax)
   a:	48 8d 87 10 ff ff ff 	lea    -0xf0(%rdi),%rax
  11:	e9 cf 22 82 00       	jmp    0x8222e5
  16:	cc                   	int3
  17:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  1e:	1f 84 00 00 00 00 00 
  25:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  33:	00 00 
  35:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  3a:	e9 e6 00 0a 00       	jmp    0xa0125
  3f:	66                   	data16

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   9:	00 00 
   b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  10:	e9 e6 00 0a 00       	jmp    0xa00fb
  15:	66                   	data16


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250807/202508071027.8981cbd4-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


