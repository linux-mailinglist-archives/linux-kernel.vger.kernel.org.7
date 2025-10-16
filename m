Return-Path: <linux-kernel+bounces-856609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD64DBE49A4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1A35E2429
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4093242D78;
	Thu, 16 Oct 2025 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3k+qEJz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8A432D0CA;
	Thu, 16 Oct 2025 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632320; cv=fail; b=k2la0QIwXUCg3GB4qK3qZqUsd3GN+rCVRCNmxcYBMHQTGiXoDstM3NZaDuKpDzHToIGqYVLPHljwpDpN0jT1mXJcGH1/EazZ/42luaLJXpZ7yoQ64tPqPRiTyebx027MN2djPm9TeOvrkDCs3fXoIdUWjEWf0j+80ZAZHLc3eXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632320; c=relaxed/simple;
	bh=d46FA8V6Ec2PH0Eqxt8bj2kZgdCr4cHyJGk4zu4pCmw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xs8FCMGD6EXJXopvKf6wYwwBlwk8VUdkscoklrJEU8+0C5SxNK2ODRubB1h0+qFvOvm2NboUjN/EB/PyAUSb4yaemvzfKZAwCH9V6hAKtgkt+JOn6X/GRW4emXuv853lrSi/lZ/hKy5+jB9GyIc+MxREdrNLugySGNIoqVAk68c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3k+qEJz; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760632318; x=1792168318;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d46FA8V6Ec2PH0Eqxt8bj2kZgdCr4cHyJGk4zu4pCmw=;
  b=h3k+qEJzwn6PH2OBFy4TuIoEgKoKb5INp6uqXbV/h+KBTwmH5fCy5wz1
   aLyd6gk2vWq4hMsw0rxrYoy4zLba8iRHojmBz78XbCgEIIStWEEaNl3TN
   BQqOl3RVYaEI7RVdNOaJQQlGPs2gdeN6OQPJLUs+KirX3iEM3jDjOKQbR
   p/fa2urdB228K2wKiQME28naWGoXUA5gsIlUDIMu41sCC8hrZeFLsJlSJ
   P9r2U6SoRrDqQNK5cSveZrunH0WIuOqGU5EN+hixSuLr1zCAmtce5VEMq
   E8Lw3JwWZkKHFqLqRkgJXSHUgiWzE9yM9vx2uigmYA4lp6gDtPbQ6QgJj
   Q==;
X-CSE-ConnectionGUID: WuEh7paqSJKuvkBDsieBvw==
X-CSE-MsgGUID: DKcWvZtmSUapWJw4QmUooQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="80469153"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="80469153"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 09:31:51 -0700
X-CSE-ConnectionGUID: Zwpo6oAMS4ax0badWRJd9A==
X-CSE-MsgGUID: L/XF4lTqSp6yccbQTCMTSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="182430101"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 09:31:50 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 09:31:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 09:31:50 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.28)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 09:31:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ifzb3F3IQbuyUuCfMiZa+ADOGJVNPnL8qJx2VBj1fa3zXNE3Y2Hq5KuDXdcWagby3AfxpsvU8CLQLm9xix3cpszUMLvMd/X5SOF69I4ghoHr2G+WUyTUG/Fpl6CFFIdo8ypb5VGyy/bEsQwkm0sAUR+gxa6xn3BPMrnZYrlag4KaiTG72Bx9/OPduxX6iSVcnK0Dw54vpcOgzo0ZVYjJHfnhkHCKFPW0Yo4EFNB9YSdGgB50VfvZSRk2pQdE8T2hySFvcJzsxWoZ38rjdf4+a7PHPeRBBHDjo3sZ13Xua84Koti/0bqKUfAEBH3ZKCfMVgeUz42NaE1EboLntBsxEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMvczwki9xEtw8vz+ZJXlQxoNTQ5gVV1wb2VrcqAuHg=;
 b=Cz0GR2INsEtg6NezAYE6qbe/FIwYuXhbDSGHqOpj4RfElrv8+aOtqqjhuCsNLp8/U36rriEHhL7UrCt5RonbIswoAaVqN/qfDbl3Z15XX4KLUIR/WTXWfi6ROxbZqsbyoS5O1ool+6yTFxRIbngDo49im6xfsrjqUzJYtwGhIhGPLsFXHd55136e1v9rEXVIhAiZSVrHeQ4fiHlN8UzFU+cJU4PARBbs9N27o6dK+gzvV1Fox2QetVNUmA82koc4maW82rnGfQucOAEpz5PyDtEp5mW4rLXI8vuKBm7RIACcUPRe2OPSA3rjB1Q5Hq+8FI6LDbwp5xyK9LweFuK4Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:95::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 16:31:47 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9228.009; Thu, 16 Oct 2025
 16:31:47 +0000
Message-ID: <dd5ba9e5-9809-4792-966a-e35368ab89f0@intel.com>
Date: Thu, 16 Oct 2025 09:31:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
To: Dave Martin <Dave.Martin@arm.com>
CC: "Luck, Tony" <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>, "James
 Morse" <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <x86@kernel.org>, <linux-doc@vger.kernel.org>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <aNFliMZTTUiXyZzd@e133380.arm.com> <aNXJGw9r_k3BB4Xk@agluck-desk3>
 <aNqQAy8nOkLRYx4F@e133380.arm.com>
 <d15d97d1-286c-4857-8688-4d8369271c2c@intel.com>
 <aNv53UmFGDBL0z3O@e133380.arm.com>
 <1c4b6b46-16f9-4887-93f5-e0f5e7f30a6f@intel.com>
 <aO0Oazuxt54hQFbx@e133380.arm.com>
 <bf18c704-66d0-40cb-8696-435ac1c928b5@intel.com>
 <aO/CEuyaIyZ5L28d@e133380.arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <aO/CEuyaIyZ5L28d@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0162.namprd03.prod.outlook.com
 (2603:10b6:303:8d::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB4769:EE_
X-MS-Office365-Filtering-Correlation-Id: baf13e87-aa95-4e42-cdbd-08de0cd18017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUNlSGJVL3NSaFg3OEYxcGtSSDNhV0w3dVR3WWFHOVhEeUh1SkNOeHlGZ2RV?=
 =?utf-8?B?YWRLMWlwdFpTTXRPVUkwUHcyVVd4TzdCQytHYks4NDMyaDdPczNxR2ttM3VJ?=
 =?utf-8?B?NElnTkVWM1ZDdituTis3ajdoZU5NYk84MURYZURqWk9qUDlPUE5kRnFkODZL?=
 =?utf-8?B?WCs1NUNBN3R3U2U1dUt2cWhKOHdyWXIwd25yZmRSQmtiakRGV2ttNXhMVUUw?=
 =?utf-8?B?b2pWN0xpUTRvTmNUT0VRRkF4S3YzdmJOKzJzczR2MUFSRmY2V0RGemxVTXhX?=
 =?utf-8?B?OUtXcERWeGhITzc0MEZadDdIQVJJVnYyalJ4VEJXaWRMMTRyM3VGREdHWTJa?=
 =?utf-8?B?YzdBNkx4bVYxbmZMeU5nandZMHVtRm94LzhTa0dVRHo2LzlVallOc3BPeEdH?=
 =?utf-8?B?M29BM0RCLytKcWxOVytVL1ZxSlNVbmdWaDhlVDI1amZkak1nOGFxREx2c2x2?=
 =?utf-8?B?Y0N1cHpHZmpoRmdqUmJZTWJzRVlNSDJIKzdIdHR2ZXR5VVhwdEhiOXlFSnlx?=
 =?utf-8?B?K0ZxVVpaRUZaS1FrUHhraUc3YnlsUXBXdGdFdHZ3WEhpcTZid3VuNnpUek9M?=
 =?utf-8?B?Y1FsOU40cG9uaGtoQ01pcUFDK2JjMERNNGtETGNxeTBJZFlUYUlUbzBkdVhD?=
 =?utf-8?B?cEJGSHJqTnZDWmRBU09Gd1R6WjIwZURKTmY3SCtwejZVTXowbTkxMnhFTjdH?=
 =?utf-8?B?aG1LaGpwbzN0bmRYUEVMWW9nRjFwaFRjbDc2ektoMmU4Mkd6Y3BSaWswNEFD?=
 =?utf-8?B?VVNjeDl2RzFuMmc4SHRscFFua1VjYUk5bUdoUkU3bmppNzZ6L1Q0NHJydEpX?=
 =?utf-8?B?UTYwWHNPd0RJdlYrOWN2MjJOa0NmbFFXQ0JJM2t4U1lWMlBkWFJLY0Y1Y01p?=
 =?utf-8?B?Y2tHaXlBUmc0UFZiZU83Q0t6dUlMNEVNNUgrRlh3WUIyZjRGWjNTYWhmb3JZ?=
 =?utf-8?B?L1NwVVJ5SFlwMDl2bHZUc2NmWWtWeUpMMWJhMVJEMEZkTVQ1Qko2Tk9jKzZ2?=
 =?utf-8?B?cGs1V3UyMFF6WVF3SE1oVDZTQmM3Y0hibWRBQktPMmwzT3FFcmhHcUFOckUv?=
 =?utf-8?B?bXFyM1c0RzYzZWprRjhiYXg5UXZ0NnMxODUzd0pBaEpURHVyUkZiaUYwY1Iw?=
 =?utf-8?B?TzhzMEVLdmpGUjdKNTdJaUE1M2NyMlNSODI0UlduMCtBdHFZQ0sza0huQStH?=
 =?utf-8?B?a2orVVRKelp0blFic05UbnRSMjIyZkh5bFloS2ZYWkx4WW43ZWM5YnZkbHdz?=
 =?utf-8?B?eTZCak9XVzZhWEo1aDZKaGZ5VmpQRlY4c2V4NnRiOU9VbnU5dzc1NUh0YTdU?=
 =?utf-8?B?YnZtR0FLNDJlcWpabVRkdHRmQUp6bmFNbmdGaSt4ME55c1QzZ3hXcU4xUXFh?=
 =?utf-8?B?L29tdEJqMUoxamo0RkQrdG9Qb3dCYXBoSmNCcHV1ZWk2WDZpWUNYNXQzUFpl?=
 =?utf-8?B?OSt2S2VDRDJ0eG51ci9oWnFXSzE1S21HR0R3NExLZWVjNDg0QVNmcTQ0TjZZ?=
 =?utf-8?B?T09yaWtMMmNnQnpvVEQwUmJYanpxdk5IUzZFZkkxemUwNHdZNHNjWVp3Yk9N?=
 =?utf-8?B?bDNmUlc2RzlRWFROcVBsY1hGdk9lSzg1Q21GakN0RmI5ZnpLZ2JSZk4xdjFq?=
 =?utf-8?B?Z0o3MlVoUGdMc1VEalM1TmF0Ry9PRkNTZ0RUbXdXMWRNTEsyeExXbTNFVzRG?=
 =?utf-8?B?SndrY1lHdXJsbDdmdDQwajROdDc2R0JHajhmbXU4U094YkY4ejZEVFFwV1BV?=
 =?utf-8?B?OHpnek40TFZ3dGZ3dmlCVWFMcU1jWk1yMHh6Z2dFZWU5V3lGWitpTDFNYWx6?=
 =?utf-8?B?aUJuRHFIVm1obWJITWxXbEY0WTlkOG9GME9ReXdZMDNTa0E2UkRIeTZxbW5P?=
 =?utf-8?B?NWw3MUVHZXMxQUxCQ21iU2JqSlIrRGxab3lVVFp6YzhTNEN6M2syUTNGUG5k?=
 =?utf-8?Q?dFxs/mVfZeU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0pJQjMrbjZyR3ZiNjd1VFZVWk5ZalE4SWcrdkhMNlljMzFJTkZIa0E3dzQ5?=
 =?utf-8?B?aTZRQlQxc1VXNCtCT2hMc2tpekYzMHNwVXBqV3ZCdmUyVHZicHVaRTBWUVBE?=
 =?utf-8?B?RDNCb1JqRGQxSWp2dWlBS3dGYUtCRWpvWEtXOVlwNWpoR3pxQ1VRbWNsVmJn?=
 =?utf-8?B?ZXFRTGxjVEF2cXJVYjhIMWdHSStLb0h5NDRvaWVhbHpZOXNaT0lEU3ZaMS9E?=
 =?utf-8?B?VTNGTCtlVHphMnIzM2lBOFpNUTRQb2VGd05KcWc1WDR6bCtnT0NKMUVDelE4?=
 =?utf-8?B?MkNhODRyR2dvN2lhWWtJZlNyaHhvQnNyb29SbW5PVVB6b2JhWEhZcnFVRlI5?=
 =?utf-8?B?UW9FRmZJZmJJaUdEOXhMbWpydFN1Yy9HSllCcnQ4ZzUzVzlqcjgwOXRVWW1n?=
 =?utf-8?B?VU15NmZqNG9ISjl0cmwrdktkNkwraG51OXJSUGp5NG1uT1FLcHdkcHd0L1Ux?=
 =?utf-8?B?OHNTdGs2U0lzM3Q3MEFaRmZCRW5vOU1xbjZpdCtESjF0RDFWMk5aT2hwUVBD?=
 =?utf-8?B?TFZ5WHFVNVhjYjBjaUVxWFd4N3Y2ZnNTSHc4SHFwS3JQMkx1Q3A2WTV3N3po?=
 =?utf-8?B?QUtFRVhWYndFdDJpQW1BZUNrM0hFRHZOVWQ5OU03MlVTcXV4QWRVaytuWTZV?=
 =?utf-8?B?UWtJN1dlR2w2U0FrSjdqZzFZRThmR2w0UCtvOUNvNjlkQVpPYVNqcDJDdGJj?=
 =?utf-8?B?Q0NJYUFiUnhEc2RrUFlPYlMwRTVtR1l1Z2JyR0pJS2ZQU1I1MWt1TjNGUXBN?=
 =?utf-8?B?OElQL0RyK2QxTjA3RHRNU2Y0Z3U0R2tmQzN2aW5FekVxSEdEOTBoOUNxdHlL?=
 =?utf-8?B?ck1xWVN1V0oxKzdhSDFDbzNZcVA5aUpoY0R1THhHYjZ1aGtWc2tOdXBHTlVO?=
 =?utf-8?B?SVVQTXpWSk50d2ZEVGRCSGZ0aGRDcVg1NHNJSVlKcFdHT1lHVG9wYnBpTEtJ?=
 =?utf-8?B?R0FpTXdTSWJWbGlXazlwRldBSkxnRWxPMFlUSVpPZTBnNHlqT3RPN3grSTh4?=
 =?utf-8?B?MzRWcW1RamRlcnRUTmxIM1RocFRrOWhmZmcxNXdUcWdMNmlENEc4MWdGSzJF?=
 =?utf-8?B?VGpUMWZIWStWQ29BR203dnVXbmwwQnRKYmRyL1dkRGNGajBRbmpYd0Qxam9R?=
 =?utf-8?B?THkyT2RSbytrY3MzRzZPekU1eFp6NGFFTEJTMWFQV1NBMkQySHRpVkdjUlY4?=
 =?utf-8?B?M2VtaGVuc1dYeWhqcU9mdDBvczQ5VkFwMzkzOWdYN1lEZDZRbHVyNmhWZlBk?=
 =?utf-8?B?dkVQc0JNZ2lMNEpKYUZEY2NMZWl0RHp1b1hLUWU1K2dGS0xaVnBCblVRZ0pC?=
 =?utf-8?B?N2Fudm91NmlrZVlqMjliWlhHQ0RSTkdSbkRJWGlYMHNNN1NkcEJhYmpYcGN3?=
 =?utf-8?B?WGpWVEVreWdHNnBtcDZwL0lLUEMwSVlUUTJGVEl6SHM2ZE9VZ05WSE8vZ1N4?=
 =?utf-8?B?MHRRSGlDMWExci9CM3ROTERKK3FXcXlqSHpHQm1vRFZFb3F4dE8vVktROFlF?=
 =?utf-8?B?T01LRUp1b3ltbWlFWHNWTUFtQjZNenZMNVU2Y05mYjhDbVQySE5pVHlKM2xH?=
 =?utf-8?B?TWhSWHpXSVUwd2xSNURqWVpYMmZ3MzJHNWhBUlF4ZSs2TEUrbHozblgyR3Ja?=
 =?utf-8?B?cTJ2aVYrSTNsMlF6Nm1LL3N0dHZ1M0djMUtkc0VrSTQzeTM2WExSbHdzSE90?=
 =?utf-8?B?TnVacXVkUVpTcmxLVG43YlU2TGtKNThzdVdmTEpqbFpMeGRmc2ZEUjBXemk1?=
 =?utf-8?B?RjU3U2Y4UnhFQUU4Y3JXUFNlMDg3cXVnMDZmWWJDVTY1S3RabmZKSGV2N1ZX?=
 =?utf-8?B?aEpsUW1hTmw1eUhUdzRIVmZPc2g0YjI5NmpoVFYwTUpkcmZUaUM3MWJuVURa?=
 =?utf-8?B?VngxdVJVdjg4MkRtZ2RUQmlYbzc1aWNJdFBNOXdmSG9ELy9VeFVWNzlhQkpL?=
 =?utf-8?B?WTJpL1Y2MUExUy9XRTBZVmNmOXFmV0dhbmxua2JmZG9JeDd3VkpoWlZ4WDNh?=
 =?utf-8?B?SkxWQ1FCQmo1MnFGdzJ0WUd0WmpQTzloL3FFNWVyWGU5QnZKQXVCS0hjOXN5?=
 =?utf-8?B?QkVnVmNWZjVFRFpiZHZoaWUyN2h4V0dQK2UxZFNDR3JXT3ZVblZ0T25aNzBv?=
 =?utf-8?B?RWl6U1Y2Qlhlc1dQeWI1a1R5T0dKTjJEVGJLZkh2aHh2T2VSOE1vcEdNOTVl?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: baf13e87-aa95-4e42-cdbd-08de0cd18017
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:31:47.2430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5i6WeAdM32JeznqmlVG5PHg7PAK8YKv1lSaPzV0Hwl3SXQh6dxUO5ndOkzTyrMxVbRYuOE7xscCp9lqAY49KX+TVd98FNU2mG1BAaGP4pg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4769
X-OriginatorOrg: intel.com

Hi Dave,

On 10/15/25 8:47 AM, Dave Martin wrote:
> Hi Reinette,
> 
> On Tue, Oct 14, 2025 at 03:55:40PM -0700, Reinette Chatre wrote:
>> Hi Dave,
>>
>> On 10/13/25 7:36 AM, Dave Martin wrote:
>>> Hi Reinette,
>>>
>>> On Fri, Oct 10, 2025 at 09:48:21AM -0700, Reinette Chatre wrote:
>>>> Hi Dave,
>>>>
>>>> On 9/30/25 8:40 AM, Dave Martin wrote:
>>>>> On Mon, Sep 29, 2025 at 09:09:35AM -0700, Reinette Chatre wrote:
>>>>>> On 9/29/25 6:56 AM, Dave Martin wrote:
>>>
>>> [...]
>>>
>>>>>> 1) Commented schema are "inactive"
>>>>>> This is unclear to me. In the MB example the commented lines show the 
>>>>>> finer grained controls. Since the original MB resource is an approximation
>>>>>> and the hardware must already be configured to support it, would the #-prefixed
>>>>>> lines not show the actual "active" configuration?
>>>>>
>>>>> They would show the active configuration (possibly more precisely than
>>>>> "MB" does).
>>>>
>>>> That is how I see it also. This is specific to MB as we try to maintain
>>>> backward compatibility.
>>>>
>>>> If we are going to make user interface changes to resource allocation then
>>>> ideally it should consider all known future usage. I am trying to navigate
>>>> and understand the discussion on how resctrl can support MPAM and this
>>>> RDT region aware requirements. 
>>>>
>>>> I scanned the MPAM spec and from what I understand a resource may support
>>>> multiple controls at the same time, each with its own properties, and then
>>>> there was this:
>>>>
>>>> 	When multiple partitioning controls are active, each affects the partition’s
>>>> 	bandwidth usage. However, some combinations of controls may not make sense,
>>>> 	because the regulation of that pair of controls cannot be made to work in concert.
>>>>
>>>> resctrl may thus present an "active configuration" that is not a configuration
>>>> that "makes sense" ... this may be ok as resctrl would present what hardware
>>>> supports combined with what user requested.
>>>
>>> This is analogous to what the MPAM spec says, though if resctrl offers
>>> two different schemata for the same hardware control, the control cannot be
>>> configured with both values simultaneously.
>>>
>>> For the MPAM hardware controls affecting the same hardware resource,
>>> they can be programmed to combinations of values that have no sensible
>>> interpretation, and the values can be read back just fine.  The
>>> performance effects may not be what the user expected / wanted, but
>>> this is not directly visible to resctrl.
>>>
>>> So, if we offer independent schemata for MBW_MIN and MBW_MAX, the user
>>> can program MBW_MIN=75% and MBW_MAX=25% for the same PARTID, and that
>>> will read back just as programmed.  The architecture does not promise
>>> what the performance effect of this will be, but resctrl does not need
>>> to care.
>>
>> The same appears to be true for Intel RDT where the spec warns ("Undesirable
>> and undefined performance effects may result if cap programming guidelines
>> are not followed.") but does not seem to prevent such configurations. 
> 
> Right.  We _could_ block such a configuration from reaching the hardware,
> if the arch backend overrides the MIN limit when the MAX limit is
> written and vice-versa, when not doing to would result in crossed-over
> bounds.
> 
> If software wants to program both bounds, then that would be fine: in:
> 
> # cat <<-EOF >/sys/fs/resctrl/schemata
> 	MB_MAX: 0=128
> EOF
> 
> # cat <<-EOF >/sys/fs/resctrl/schemata
> 	MB_MIN: 0=256
> 	MB_MAX: 0=1024
> EOF
> 
> ... internally programming some value >=256 before programming the
> hardware with the new min bound would not stop the final requested
> change to MB_MAX from working as userspace expected.
> 
> (There will be inevitable regulation glitches unless the hardware
> provides a way to program both bounds atomically.  MPAM doesn't; I
> don't think RDT does either?)
> 
> 
> But we only _need_ to do this if the hardware architecture forbids
> programming cross bounds or says that it is unsafe to do so.  So, I am
> thinking that the generic code doesn't need to handle this.
> 
> [...]

Sounds reasonable to me.



...

>>>>> MB: 0=50, 1=50
>>>>> # MB_HW: 0=32, 1=32
>>>>> # MB_MIN: 0=16, 1=16
>>>>> # MB_MAX: 0=32, 1=32
>>>>
>>>> Could/should resctrl uncomment the lines after userspace modified them?
>>>
>>> The '#' wasn't meant to be a state that gets turned on and off.
>>
>> Thank you for clarifying. 
>>
>>> Rather, userspace would use this to indicate which entries are
>>> intentionally being modified.
>>
>> I see. I assume that we should not see many of these '#' entries and expect
>> the ones we do see to shadow the legacy schemata entries. New schemata entries
>> (that do not shadow legacy ones) should not have the '#' prefix even if
>> their initial support does not include all controls.
>>> So long as the entries affecting a single resource are ordered so that
>>> each entry is strictly more specific than the previous entries (as
>>> illustrated above), then reading schemata and stripping all the hashes
>>> would allow a previous configuration to be restored; to change just one
>>> entry, userspace can uncomment just that one, or write only that entry
>>> (which is what I think we should recommend for new software).
>>
>> This is a good rule of thumb.
> 
> To avoid printing entries in the wrong order, do we want to track some
> parent/child relationship between schemata.
> 
> In the above example,
> 
> 	* MB is the parent of MB_HW;
> 
> 	* MB_HW is the parent of MB_MIN and MB_MAX.
> 
> (for MPAM, at least).

Could you please elaborate this relationship? I envisioned the MB_HW to be
something similar to Intel RDT's "optimal" bandwidth setting ... something
that is expected to be somewhere between the "min" and the "max".

But, now I think I'm a bit lost in MPAM since it is not clear to me what
MB_HW represents ... would this be the "memory bandwidth portion
partitioning"? Although, that uses a completely different format from
"min" and "max".

> 
> When schemata is read, parents should always be printed before their
> child schemata.  But really, we just need to make sure that the
> rdt_schema_all list is correctly ordered.
> 
> 
> Do you think that this relationship needs to be reported to userspace?

You brought up the topic of relationships in
https://lore.kernel.org/lkml/aNv53UmFGDBL0z3O@e133380.arm.com/ that prompted me
to learn more from the MPAM spec where I learned and went on tangent about all
the other possible namespaces without circling back.

I was hoping that the namespace prefix would make the relationships clear,
something like <resource>_<control>, but I did not expect another layer in
the hierarchy like your example above. The idea of "parent" and "child" is
also not obvious to me at this point. resctrl gives us a "resource" to start
with and we are now discussing multiple controls per resource. Could you please
elaborate what you see as "parent" and "child"?

We do have the info directory available to express relationships and a
hierarchy is already starting to taking shape there.

> 
> Since the "#" convention is for backward compatibility, maybe we should
> not use this for new schemata, and place the burden of managing
> conflicts onto userspace going forward.  What do you think?

I agree. The way I understand this is that the '#' will only be used for
new controls that shadow the default/current controls of the legacy resources.
I do not expect that the prefix will be needed for new resources, even if
the initial support of a new resource does not include all possible controls.


>>>>> (For hardware-specific reasons, the MPAM driver currently internally
>>>>> programs the MIN bound to be a bit less than the MAX bound, when
>>>>> userspace writes an "MB" entry into schemata.  The key thing is that
>>>>> writing MB may cause the MB_MIN/MB_MAX entries to change -- at the
>>>>> resctrl level, I don't that that we necessarily need to make promises
>>>>> about what they can change _to_.  The exact effect of MIN and MAX
>>>>> bounds is likely to be hardware-dependent anyway.)
>>>>
>>>> MPAM has the "HARDLIM" distinction associated with these MAX values
>>>> and from what I can tell this is per PARTID. Is this something that needs
>>>> to be supported? To do this resctrl will need to support modifying
>>>> control properties per resource group.
>>>
>>> Possibly.  Since this is a boolean control that determines how the
>>> MBW_MAX control is applied, we could perhaps present it as an
>>> additional schema -- if so, it's basically orthogonal.
>>>
>>>  | MB_HARDMAX: 0=0, 1=1, 2=1, 3=0 [...]
>>>
>>> or
>>>
>>>  | MB_HARDMAX: 0=off, 1=on, 2=on, 3=off [...]
>>>
>>> Does this look reasonable?
>>
>> It does.
> 
> OK -- note, I don't think we have any immediate plan to support this in
> the MPAM driver, but it may land eventually in some form.
> 

ack.

...

>>>> MPAM allows per-PARTID configurations for secure/non-secure, physical/virtual,
>>>> ... ? Is it expected that MPAM's support of these should be exposed via resctrl?
>>>
>>> Probably not.  These are best regarded as entirely separate instances
>>> of MPAM; the PARTID spaces are separate.  The Non-secure physical
>>> address space is the only physical address space directly accessible to
>>> Linux -- for the others, we can't address the MMIO registers anyway.
>>>
>>> For now, the other address spaces are the firmware's problem.
>>
>> Thank you.
> 
> No worries -- it's not too obvious from the spec!
> 
>>>> Have you considered how to express if user wants hardware to have different
>>>> allocations for, for example, same PARTID at different execution levels?
>>>>
>>>> Reinette
>>>>
>>>> [1] https://lore.kernel.org/lkml/aNFliMZTTUiXyZzd@e133380.arm.com/
>>>
>>> MPAM doesn't allow different controls for a PARTID depending on the
>>> exception level, but it is possible to program different PARTIDs for
>>> hypervisor/kernel and userspace (i.e., EL2/EL1 and EL0).
>>
>> I misunderstood this from the spec. Thank you for clarifying.
>>
>>>
>>> I think that if we wanted to go down that road, we would want to expose
>>> additional "task IDs" in resctrlfs that can be placed into groups
>>> independently, say
>>>
>>> 	echo 14161:kernel >>.../some_group/tasks
>>> 	echo 14161:user >>.../other_group/tasks
>>>
>>> However, inside the kernel, the boundary between work done on behalf of
>>> a specific userspace task, work done on behalf of userspace in general,
>>> and autonomous work inside the kernel is fuzzy and not well defined.
>>>
>>> For this reason, we currently only configure the PARTID for EL0.  For
>>> EL1 (and EL2 if the kernel uses it), we just use the default PARTID (0).
>>>
>>> Hopefully this is orthogonal to the discussion of schema descriptions,
>>> though ...?
>>
>> Yes.
> 
> OK; I suggest that we put this on one side, for now, then.
> 
> There is a discussion to be had on this, but it feels like a separate
> thing.

agreed.

> 
> 
> I'll try to pull the state of this discussion together -- maybe as a
> draft update to the documentation, describing the interface as proposed
> so far.  Does that work for you?

It does. Thank you very much for taking this on.

Reinette



