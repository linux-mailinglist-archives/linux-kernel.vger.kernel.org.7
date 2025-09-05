Return-Path: <linux-kernel+bounces-803365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FE7B45E2F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B78287BE0F2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC1919924D;
	Fri,  5 Sep 2025 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kTK9nk9j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A94202F7B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757089875; cv=fail; b=aT+2eV87BY4ugmWCW1jhhsSuXLxU2EweXHvXRYdR4yuD5Z6h2XG2nGzvQam5HEV7Ec6ttBqGqdK9CSMqc6s8OsEqysPgEcjLKJo3L7PzW1Lbgb54yJVQGTkxTojfgel4GzHan6LJhlODcXrSeXl9vPwaYRjHFo61DeSnaDjZKIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757089875; c=relaxed/simple;
	bh=eIjzKaG56fxzGrTPkV5OJ7VqH7wSw2liN7adEFUe9no=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s98t6SidnFIoGFSmY9z76r+5wHt+cVlWMNFC63xcXyYbsD6oAjtTDS8h23GEkkjwu9jBv9jC/oVGNFpZ2r7Wui72oT2LDcE/FqKWXzwMBksrVqXTgteznvtmvezzWoENj8bZV0RsyRvO9IX2wyXTBd4v601JlantcpoCVluZBD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kTK9nk9j; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757089874; x=1788625874;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eIjzKaG56fxzGrTPkV5OJ7VqH7wSw2liN7adEFUe9no=;
  b=kTK9nk9jGYZkBXxUt5jfTA1LtKWg4v2bib6r+K/pLKG0myxjqkobjavC
   hNjp4fnbn3laDfqBC9/Q6PItdP5LQUG/UBBTw7TKKlvyuWi4MlxafzPjq
   /PmVl8lBw3FfuOWDedGmEAIhVfUvgyKtmG0EaqVEgroZH2/I9Glj/61IJ
   oKBK0ApZ59aoo5ho8TTFMWsb/bOq8Sd1ARQ6ip8Fpop/mFtoegRtHip/Z
   mN1KGfzPp0C99pYM7/xNYc6UInC1hXWliJos1XPf3urF/b/vqQag9YTTS
   +I1a6x200IHnpWWLzrvDrkS+PP8Y+vt71MbhHCfYkYxQfJ4mTTBjG+7GU
   g==;
X-CSE-ConnectionGUID: dT6TNpNQRoKqFAEliwzAuA==
X-CSE-MsgGUID: XnlSj2SVRqeDSLROyhPvpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="70539843"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="70539843"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 09:31:14 -0700
X-CSE-ConnectionGUID: uupF4WeVSUuRC8qx3Pubbw==
X-CSE-MsgGUID: OqwRXfavTVu4mCiV39t/Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="171402376"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 09:31:13 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 09:31:12 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 09:31:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.89)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 09:31:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYZ9JpOYXRZ7U6xwWF2VroUFa/GXnKUxZv6Pzq3Snl/+ZE2g3OVBTH+UyAug+s2Gid1aI4HyMw7A15nOlcmAIQJ/khadosuQRVTpaVaIGZFb0SrNb3Wll+37W+HloeflETviKMEG1qjXhVMQXfbriawYv5Yem4c8d4Ws5pAmjgeTk87eEHONUHCHaCJMJmWKQYZ184j5f8PIUaIBQA5SrIhKrJlxgx09ThlQ6Xw9mMA7pPCPUGV+ZknyRY35KHJbb43DSF/9TMtZdQ/OcD5bfnMQJj+N1lWyWSQsG+Z2PopQe2Uxy2XVkdh6Rc1nMThxhDVSDjU74Ba3jHJMAFZLLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cC9GLtQqgsHWa2hflTCfna06LYdINRoIw3XLWU16Z74=;
 b=ub5RG9Rz5WZNj9jXtziXt2gZROjqim52Weo494OpPTvsMkMLD/Ldsvt/sLXsxfTEdMSAN1GKp3v3KCBH6c8QbkuvwlFXqCjIxH3waTVktHMFTsfuw0ZE5rjqgecmyU6GCnPK2EKalM3FzQOBdXGciTYG064aTneFZbOGV8wUavfH6AuMlWEL5+bghHjFwEAJOpg0vv79pIsdmLwGoa4NyMlzInLepoOZCWJ1yd2zzPNV+cSd6koguFSGZhaRhHlRArh4SmpT12YtQ1LSP2F2HWcghEiZkSVh9Dx9GOLmzeHbxIgnPCcfLWeuCGUvbCRwBU0DHc9b/IcevAmzw/5FtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7917.namprd11.prod.outlook.com (2603:10b6:208:3fe::19)
 by CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:95::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 16:31:04 +0000
Received: from IA1PR11MB7917.namprd11.prod.outlook.com
 ([fe80::c689:71de:da2e:2d3]) by IA1PR11MB7917.namprd11.prod.outlook.com
 ([fe80::c689:71de:da2e:2d3%7]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 16:31:04 +0000
Message-ID: <4a5c71f5-bb37-43c6-8aa4-2e4bd9098291@intel.com>
Date: Fri, 5 Sep 2025 09:31:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] x86/microcode/intel: Establish staging control
 logic
To: Borislav Petkov <bp@alien8.de>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>, <chao.gao@intel.com>,
	<abusse@amazon.de>
References: <20250813172649.15474-1-chang.seok.bae@intel.com>
 <20250823155214.17465-1-chang.seok.bae@intel.com>
 <20250823155214.17465-4-chang.seok.bae@intel.com>
 <20250904121318.GKaLmCXlU4kwhsxG9h@fat_crate.local>
 <641f321d-4266-46c0-9383-d06bcb909529@intel.com>
 <20250905111349.GAaLrF7eWikC8BpiDK@fat_crate.local>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20250905111349.GAaLrF7eWikC8BpiDK@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0175.namprd03.prod.outlook.com
 (2603:10b6:a03:338::30) To IA1PR11MB7917.namprd11.prod.outlook.com
 (2603:10b6:208:3fe::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7917:EE_|CO1PR11MB4769:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e647622-4f0a-4adb-d421-08ddec999b58
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3Z6V2ZwTWFxMDVoN2N0Mk9xdGZUYkhUSmhKT3lOM0djekVlNllZREV1a0g3?=
 =?utf-8?B?eTltcFgvZEl0OHBFOUwza3cySElBUVpnQkE2RUkzRGpuWURlSkhzVFZad0tx?=
 =?utf-8?B?WlM1aGxmdFRxRFpjbDdqdTF3ZUYzRXBFdGJFV2c5b0orN2VTQ1I3M0RxbFpD?=
 =?utf-8?B?QVpXZ2VHUHJyY0Z3K29iV3B3UTFSK2lQdTJ2eUFKak5UdkUraW50aHU1Skdh?=
 =?utf-8?B?ekJ6RkVIc29mRzR4YytaQ0dPREd2aStBZGZOZ2RVSE1UWjRKUExyOEUyR2ps?=
 =?utf-8?B?elZ6cCsrOFV6TS82eXVZTVh5OEhzTEJBalhGZzBzbXU2QXozOHVmNjh3YWN4?=
 =?utf-8?B?MUVEZGZWZkI2cWVBRndVZU8zRWdsY01PckYzMVIwTHpaN1cxVlpMRkd3Z1lB?=
 =?utf-8?B?NGZsdmJ4YTZOVzZIZlc3dkxlejRJVDVIZHVTOEZ3ZjkyQW1xZmRWQnFIc1kw?=
 =?utf-8?B?SjEzZERjU0xGWjN0em1Qb2p6cVZxOW1oZklTNTdRWjBSbFYzaFhwcWtzNFpZ?=
 =?utf-8?B?TUdiZURtdExzMHkxRksrdmhKL1pqQXJoNjNlZE5nbEpMcVVKQUJGc2NCY0Vq?=
 =?utf-8?B?c0Z2OGRHRkloRU5RWmlrYjFuSDYzeWFGVFNnT3lVcDlpMkRWZGthS0hGS0dl?=
 =?utf-8?B?N25KN1phYnFMUHpOelZzaGJhVmxaa2lyVi96S1VtRXdTbW5wUnc5SC9Ud0NE?=
 =?utf-8?B?OXZ6aG5VU1c0aGlYYjBNOFpnd1oyNUNDK3VWZDhQWW9ibjJKZmZIMUpuNVpH?=
 =?utf-8?B?RGpNb1dVeUpOeExUdnhFU3llVTF4MVczNjZtaWVuNDBtMnFUeHdJVHZUbVdS?=
 =?utf-8?B?bjF1S3JjVC84aHEvcHN6UnN6YVFYQkZMMXhkZjZNRTFnN1o5UHE4VFJtdEE1?=
 =?utf-8?B?K1JMTkUvUVNKZm8vMVdmSWNZMFQzcFo0REY0NzhiMDZUUHIzNy9tZ0VUYk5I?=
 =?utf-8?B?aytmNXdTNEQ1S1oyeC9OQTB4ZXVhK0ozQ2VRSEVtYTgvWVlnR3BaMS80UXBV?=
 =?utf-8?B?dkxUeXBOMlZFbXdFWUdGZ0FFVEdkTzc5d2RTcDByN1BqR2hNN2pQL3RqRHRN?=
 =?utf-8?B?U2ZQdTVSY0QrMHhvZDlVakU5SFZweEQzNTdTUGdzeVhXZzRxUmF4NWJabWtj?=
 =?utf-8?B?WWFMaFJ0c2FLZ1VnYTdpRzF4Yzg1em5ENlg1bStiWEJuV09RNm1RK3AvQzlx?=
 =?utf-8?B?ekFFWjRnb21jbS9zUzByZzVqTkhvTDhQWGNZZzZ3MTRiMWtpZkJydkFGbEo0?=
 =?utf-8?B?Wk1rbHowNzRLenRjY1ZHNTExcUpUcEpQRXVSbzllWHhGd2FLblY4bmJRb0ZB?=
 =?utf-8?B?d3A5WTYzWU9rbUNEQWhrbitvK3hzcjhVUDRUbXJuak9nZTcrK29PY2JCY2NK?=
 =?utf-8?B?Ulo0NUFQQWJmV2hRcmU1UlFiTVF3WGNvNFo0aXd3UjBnOFAxMGJzQngrKzF0?=
 =?utf-8?B?OWpkSi90Q1lQYlRlSGxCSU1hR0J2YXpYUURNN24rai9GNlM2TGNXZHpLSmJa?=
 =?utf-8?B?UFNnWnJpc21KU2dabTVCbVZadHk3czcwQ2xMdnJiakdqZUp3V2pHRFBGWkVQ?=
 =?utf-8?B?eTdhSkV6OENhSXI4K0wyenY2S2FmRWFnY1NwMU4yV3hsK1VCVU5VSHUxMHJ5?=
 =?utf-8?B?VUhKRkhVZDdsbTBqenJKYW90ZUl3dVkvSjNlOHNNSWh2c0k2RnJ1VXZZeXhO?=
 =?utf-8?B?SW9mSGkxaVVUTnhuQ0crV3N2NEVOWW1kbUdqRTdHcDdsZTJBdlQ4d0EvRjNj?=
 =?utf-8?B?ZXBPa3NwOVZyVjU3R0U4aDk2Ylh6eWVrVFo3NTRsekxnK25xN0kzcVhyb0tp?=
 =?utf-8?B?SllEdmtsV0tGZjJpVm1WMDlIM2FkOXRXTGJRcUlHa3NBeGNEQmRzbGJKVy9O?=
 =?utf-8?B?TmFVMWczMk4xUlhIRWJCajlnTmxaNGl1V0Zzd2tyYThwbGxiaE0raklMUmJy?=
 =?utf-8?Q?g1ilpe4HThY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7917.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXh0dEwySGNyM1RvN0tSMjN2OCtoTDBiZzNtbTBRNzQzMm1OLzl6S0N4WGdv?=
 =?utf-8?B?TDBCNEVBTGhGcDY5RnZ0ZXIwYXN1TlVBOU80U2h0QldON0tYZmRUWklZeDNV?=
 =?utf-8?B?NFZDcWZUbyt5MDlMUVZod0FrSm9abVFkbmgrenRmbU83MHgrYVlNOUl0dXVZ?=
 =?utf-8?B?elN4RlhtVkV4eWhTdis5MHRUU0s3T1ZmZFA3azl5bTN6RHllSVpZQ1pNcTV4?=
 =?utf-8?B?R0hSS0VXd0hvZmFKR1lEMnozYlduM2paSVZjQW9RRTY2dVREMmZqSGxVN21B?=
 =?utf-8?B?MTVoZ0dybjQrUTFWd1ZnY2RsUGdVM3d6VnZMelhOMllPREF1QkViWHB3QXRG?=
 =?utf-8?B?RlptVFlTYWZtNW52b2NsZWpZb2FYRkhmd2xZUkxrc2VqOEN6NUVaeDlMZDJM?=
 =?utf-8?B?RGRNOHg2VzBNc0tUNzk3dWFnM09WZFg2SWdGRmdsQWFrMzZwMWUyM1cyVWVP?=
 =?utf-8?B?Q2hVNWlmS1dJb1NzZkJNMXZJNVpnSnJwenRqblNzRkNiRi91YkQxcjVBa0Jy?=
 =?utf-8?B?dmFFSDY0TEZPVXVxWU5ZYUNWWFE3SU9sVTFDMU5XTGs0Skl6UGhWMmI3eFRT?=
 =?utf-8?B?WWJGZ29HaTdRVXFPNDhtbk5hUHN1dXNIRXNNSjQ3czFHVUYwN3BocTQ0eitM?=
 =?utf-8?B?VmYxR1VwMWxQUCs3OGxsZFBvRzJBdm5TWmZkZnhNUGhCNXEveFdpditRS2xo?=
 =?utf-8?B?dnl2MHdVUzBnOERYZjZGb3dHTkprcnFaYnpvcFR2aWlHdllmTlhFNitNUWpr?=
 =?utf-8?B?aHV4QUdISDFUV2FTZ1NOeGxCK1kxdUY1MU8ybk14UE1PTXh4a0ZQWjF1bVRw?=
 =?utf-8?B?VU1wS016LytReWt4RlhKTmlaNzBMNkk3ajJxTmFQb3kxUzhqWGErMkRpT0xh?=
 =?utf-8?B?Y1NWcTkwU1FReFRMaE1LTk8waFBrOFJPVFBpeThabmVvN1RkdmtCZzVEK3hK?=
 =?utf-8?B?ek9rajIwTlR2dkNIbzJJbFhuUGx6WkMwRWxzc1psT1lTT2JpUHV0Y003QUtR?=
 =?utf-8?B?TUdsQVpWS0ZYQzJ1L2JvYWFDaGNRN3A0RWc0cGFoNkRjcE1xc3RqN0ViclhQ?=
 =?utf-8?B?OHdHWk9CZFpSaUFsUHp0TWdKUHp6amJ1ajNpaEdGajFlSWRjbWZYa2ZNNUlI?=
 =?utf-8?B?aGRvSUxmajFXazBaSHB3NTBack1DT0phUk02SDlnVnRJM1FjcHk4YUtsVTk5?=
 =?utf-8?B?NjczdDEwZmFoYVYxMHZFTGdWOVUvUmdUa3ZCeVdmdkNZeThYamREVHNQSklD?=
 =?utf-8?B?R2M4eUdwZmxqcDVLM2YvVUFnN3BRU0E1RnlUZDh4Qmpqck1BV2w3b3dMMlM4?=
 =?utf-8?B?K2VSbUZzeEsxWXpQY0FGdXN2RGFrelhOQVBGTjhQczRRL0RFNDh6R2F0L29k?=
 =?utf-8?B?OVVnbnA2RTJ0UjZTZmRkaUpaa1p6S1pTVmFNNC9HTGdFVVdYVk1sYmk1SS9j?=
 =?utf-8?B?SUg0WkkzVXVzRFp0enZzcVpJZDFTMFlqdUp6UHpFNVpjMDhxVmsyWUljNlNH?=
 =?utf-8?B?ZnhwRytPeVE2NTIwL244cURrRitYNkdtWTNLY1BKaXIyc1Y4UXBKNldzNlRt?=
 =?utf-8?B?aGg3NVRJQ2Rack1QM3ZoTHdtNmNHRllnSXByMEJQWmU2QzJveVJNaXEzV3B2?=
 =?utf-8?B?aFgrREFpRWNsKy8zWHI1S0xGdkNTbHRDNldoeU9wSTdvbFY2NCtCZmw2bXlJ?=
 =?utf-8?B?cUgvVllxZ0RYYWpMMEJEYzd1dUVQZ0JhT3lRRUR3Rm9iaHg4SU1QWFh4Z29l?=
 =?utf-8?B?aWVNMHhvOVBNajVFRVpoZVZpQUtBS3pnME5xV1pXWUptT2QzWUpiUFJ5RlJo?=
 =?utf-8?B?RzJ3L01CZG5hSXh0cGl4UGxMUWRMV3NLUWNITWNSRXd3UXNYL3NPdzAzVUhG?=
 =?utf-8?B?Z1NVTmw5NnZ1TDhlTytWTURqN05RQjhBRm84WlB4YXIyekJ6dzZ3TDRrcWs0?=
 =?utf-8?B?c0dkUFNKM29ZTHZIcWJLZmRmR0VGSVNFVlZ1Z2hZdlVBakVuRVhoYkE0LzJp?=
 =?utf-8?B?QmJuWUNVN0t3VmVjMGdsR0pIQm40cGR1MlFFdExabDJtQWF1MGZGVkcwZkFE?=
 =?utf-8?B?ZkwwbkorcVAyWDBLd3BGekE3WVRTemFLakxSUjRZcGJDZ2lIRk9qS3Q1emJL?=
 =?utf-8?B?VG0zRWx4bUE2UFlNTG1ya084TFNKbDVpNjh1ZG5RcVBkWFhOZ0FZOXliYmlE?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e647622-4f0a-4adb-d421-08ddec999b58
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7917.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 16:31:04.6880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lo8HifKBmkauTU8OBFGfJAb8fMCueTgBFPp6C3S51BABQ6gpFDeq+muNwvQqP8Lj20Y79nGdxigtIWfFdX7VGnWugSb67R+99MgH39QYeUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4769
X-OriginatorOrg: intel.com

On 9/5/2025 4:13 AM, Borislav Petkov wrote:
> 
> So let's put new ones where they should be

I see.

> You don't need the strings decoding... yet. This stuff is going to be looked
> at only by us so there's no problem with simply dumping the errval and then
> going to consult the sources where that value comes from.

Makes sense. Then, it could be just like this:

   pr_err("Error: staging failed (code = %d) for CPU%d at package %u.\n",
          err, cpu, pkg_id);

Thanks,
Chang

