Return-Path: <linux-kernel+bounces-801847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4457B44AA8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33C4EA01729
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E524C98;
	Fri,  5 Sep 2025 00:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPozzTfR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CD010E3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 00:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757030676; cv=fail; b=LZeudGRwoknYoWJYKbISNy/HmH0dUgY5fNBJw8UUdOJr/f2F9Ur0aTQdom2ZpE4hXtNW9NzKxhjaqfGi1/+nAHDQdQrK0S85U571bxL4xdhz1EkiNIXuv2nzaCxJOIvRd5nz4v2705HQmZR5SudlJyTBK0Yl1ls6SG3dkeQqoIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757030676; c=relaxed/simple;
	bh=NyOKXXU6AgILs3XFcDINvYBCvX4mDoNyCJ6wrj6jYIY=;
	h=Content-Type:Message-ID:Date:Subject:To:CC:References:From:
	 In-Reply-To:MIME-Version; b=CIdKodELoqHNIyHC0xJrj+Q5FKPSK6fgDj8XQTu6Tq4Ulk7XHrLFPuldw0Fm/aqrMJDUcEj738b20b1mPSSKDDB9yP6Ofv828KjcE1ULndlSKqvMe8wORIfkMCSfsxopQlyAR4cneWsFFSsJEYma9fOmZSMGjk/lxxtc4KH0JyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPozzTfR; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757030676; x=1788566676;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=NyOKXXU6AgILs3XFcDINvYBCvX4mDoNyCJ6wrj6jYIY=;
  b=hPozzTfRcuuOE/jmws/6QP9I0oiTwg9Vx/F8saSpJhQSmkN4q8IN9Ksu
   6b62DSANIjsxrTfBFrzjJYHA9JTaC2wdpEn7yLCeuqogyQ5bQv/+6iaGb
   BbYYy+LQHNY3cX6a+pFT1OUZhbYb6uU6ArwChkWnCF2r5KdMs48W6AmzF
   39jRyChv8bDQGkPKI9JHlvwj5zSvNFG/5r2oEmeim9SktIyf+pB/Be689
   UpCUYrdDoXPYj3Y28KlxkVcFGs6N0zrtqoWzbEmVQK5lGsdGTQ8Vf6heo
   kvboPjV/3bWIdY1vI9tbeCaxunimOKaBuRCysLGVQ99u0myyMrtAhK/V6
   Q==;
X-CSE-ConnectionGUID: PMUDesB6SsGFv7UFkeKnqw==
X-CSE-MsgGUID: F2K6EArOQUGNsGfaSlgyjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="81976279"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="diff'?scan'208";a="81976279"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 17:04:35 -0700
X-CSE-ConnectionGUID: bE20+IPNQZSoyZRnyJbupg==
X-CSE-MsgGUID: ZZZgsPlzS9S64SAUqRhmow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="diff'?scan'208";a="172842027"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 17:04:34 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 17:04:32 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 17:04:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.52)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 17:04:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMVbJWuc/60K3KpvhtpaZBEXjH7i0hh/890Qvh5Bo1rQpMnftwRYQbwfjmiDevkrz0pDodhWUmLmqnVt5jpBYu7IY0Mm9CWwE68Qn5lT7yw9iAwQED80fkCTmelvQiya9pjEhKfuEPuCG7TvQxaO3jdO3BzehAif7yDnR+nxft3Z/IzUVGlqwM1iIO3pkAMtl/rHLRJvr103SN9zCPYmInVrqihYNN2J6jsGGU06AT5AE0TRba863QT0Rwpx7cF728mZEn7ruVKFfHwQDhjS3kpyvx8WGWIpcoULRwHdOUaJnUNLBzeF7dTm9Kd8PRwQcnRwND8+KQ9C52ChYWfMPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEDNMJ+DWc/4DATHIH7GAQbZ/c+FXXipk0UxzLzXv7Y=;
 b=Yr+x8AFqfqFjtJBKjJVQpe2f8Ahd31rGCww1wTa6TK0iWMa2V1c1a/TnBuqo0VOJe2dl5kja5bkz6lSC+qL91AfXheS+w9avXAFFAHdUPVFL3CpkJQYoYSM9SSeP8MoOxjbSphMgkicwQ6pYKebDVLFafTDG1gNzoxDH9YO8IPn7oFg7gCHDkGzgmRpBSztCc9vVS52HvwoUPpwUmCEv5mln5kjbyM29lvOx7PiR9h7vEc2XhiZZkhsLET2YDJUnd2BQ4lPuqvk1ydbKcffNUz5c6Je1N0jJy58LVaiyj1+qcYMMOLNEF1TlqLbfRR0P45WoGTIRn3QiMSPzq4kleA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 MW4PR11MB7030.namprd11.prod.outlook.com (2603:10b6:303:22f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 00:04:27 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%6]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 00:04:26 +0000
Content-Type: multipart/mixed;
	boundary="------------fEM4W0MZ1unYEI65sbuR44oO"
Message-ID: <641f321d-4266-46c0-9383-d06bcb909529@intel.com>
Date: Thu, 4 Sep 2025 17:04:24 -0700
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
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20250904121318.GKaLmCXlU4kwhsxG9h@fat_crate.local>
X-ClientProxiedBy: BY5PR17CA0017.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::30) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|MW4PR11MB7030:EE_
X-MS-Office365-Filtering-Correlation-Id: 16bde5bb-ec64-46c6-e18d-08ddec0fc706
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|4053099003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?enUzU3ROVE8yWUZPOEZrYUZyZGwwRTNCV0RLOEQ0dUh2bDRKdS85dFpjSDFZ?=
 =?utf-8?B?b2JHOUxRN1NzWmpCaGl2SytkZ1lpbkdPSDAvUFN4ZGE0Ui9zWGRmdzFZNk8v?=
 =?utf-8?B?Q1hyVjB5YTgzTGpETEhYY1V2Z0IzQkRXVm5NOFFuZTJhdnRUcllManRML2Va?=
 =?utf-8?B?N01nUldiU01OU2VMMFJvdXAvZU1sZkczci9OdkZENktQM0pwam5EYU5XdE1Y?=
 =?utf-8?B?NkVOajRzUjFlcFFwUUtpbFRxTlJFK2JuYWJVNG5lNmduNDd6UlNjTVhIdmpp?=
 =?utf-8?B?QktTYWNrMWNEbWtLNXBNbm1vbzFQZi9MYnhoNDNKdGc0dExQNDdJbVhlaU9x?=
 =?utf-8?B?cnB6VHlHL0t2aFArei9TWm9hckNBeWVRcElGaXlkZnJnb3ExdXNUb0k0TWZ0?=
 =?utf-8?B?cTltQTRtRGxPQUkxZDJOdlJ4MEFGWEFsbHBLZVJEUGNiajlJazZaVmg3WG1w?=
 =?utf-8?B?VyszQlJWcEFMOTdLSk5sRHNmRmd2em4wL0tYOFJFd0NtMFk4VFVkU1V0OG9J?=
 =?utf-8?B?c2RvMTdMemwvcDNHcmtSVU1IS1dCWmMrNHZEbzBlRnBVNllJUG93ZUVXU1Ro?=
 =?utf-8?B?QXN2SDhjM1NNeloyZlk0S3VhbkllUWZoNmpHOWFPbzhreVkvUXZsRkp6clA4?=
 =?utf-8?B?ck5NZDNMdXhJdDJOOGk1UlZsZjJrajhRYTUxOEEwSmJxODhaSlFWdUd3eHRE?=
 =?utf-8?B?WU1oMGJxSGUyRDRFRGdFK1VudEYvd2FjQWJ0M080bGVKZ2tQZUlWRTRTanRv?=
 =?utf-8?B?aXErY2dFVVJFNHZMWEtTMU1XR3g4WmNmSlVNSXh5L2U1ZEpUbFZ1SndobEZi?=
 =?utf-8?B?aWxXcC82c3dzUUlQVE55dlYxWHBjS2EvNGNKdWNuWTZEaFN5ZnNnS3JXcFFy?=
 =?utf-8?B?bm55V25xdmFZd2poZlJZcFhabkF6Zk9pWnYwVXQzRHZVcXVHUzlTWEo2RkRT?=
 =?utf-8?B?cFVBdzJqTjJGcWcrdDZIUnF0azZhR1o1TlJNMHNNOHRTcWd6Wm1ZWDVyeG9r?=
 =?utf-8?B?Tk9hTHBoSGZheGNIblFkSnp5eDcvUFAwS3JlR3UzZHpBcVhXMmVjck04NHc5?=
 =?utf-8?B?WGdpdUh0Z0QxV2pvVnhmOUNFeUp5Qm1KZUIrTDFrNHF2WHNka0dKc1FHZ0ZR?=
 =?utf-8?B?SHllNkFqS2h5MkVYNnZ0MkV0L0hqeXpiUEZPMXgxWFdEenByeTJWbEdvanZ0?=
 =?utf-8?B?d0FJNnNzb0Z3dHFlYXlFY1FBNzV4VFgxWWNtZmdLbG15d0xhNVRKMTlhVSt0?=
 =?utf-8?B?cmZnRjR4L0t1aGF3aDFFTS8wRi9NeFVRM3RRT3lyZnU5bzA4QU5KY1p3Y1h3?=
 =?utf-8?B?V3piOGl2cmMrdVg4SjJ2RGNtREJIYWY2TXBlelEwWHd2bHE0bVJJd2ZMWXZj?=
 =?utf-8?B?Y0czcStMUFYyOUlXRzNteHBzMWpneU9qWitxclNSRFlUamppeXFVUndFVDFO?=
 =?utf-8?B?ZndTUnhNWW12MXJoUk50YWdUNEZCOEdTNFdQQ2tQVXk2UnFqZWJTOVZMc1NF?=
 =?utf-8?B?WTQ5V0YvYnY0cGRrYVdwc000UFZiMUVLV0tTb0J2dmE0SEU2WHd1K0s5Sk5y?=
 =?utf-8?B?N1BmQTgzWUdCbWkxTFVHbkRMT2t3NUc3SmQzVVp0NlMxcnpqMzBnZWxWM3pr?=
 =?utf-8?B?cmE0VFFILy90dDhhcjVvU2tzc2lHUjIyTjVaTW1IelZONUpGd1Uza0Y3eHlR?=
 =?utf-8?B?WUVnVlVGaUI0ZmplcEJqVGtNYXorQkZqV0JCNW5KY2tTSHpYdmR6Y0txTnVn?=
 =?utf-8?B?azF3ZWVIdUx6TTlBMHFzK2ZPcms1MmZyRFJ0OEtLT25veklPd2FQWWMrZWx5?=
 =?utf-8?B?VC8xaWtQTzFNM3ZkSjAwdWdqcnZQZGV4VVg5d0ticDcxdEQ2SGdpNzNlNnJo?=
 =?utf-8?B?T3BaeFdGVU1jalpucnpNSXhhM01jL3dxdXBuV3BDdVo1bjBMbExRajRIZmYr?=
 =?utf-8?Q?z8vPlkbVdYQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0NYUlBDZE5qaHNHdlZ1RnY3Z3hUK2VLcnFRWE9wRElrQzk1NnBmTVpYTXp5?=
 =?utf-8?B?UElBUGNzUjA1bWIxT09aakJNOGg3YktNb2l5RXJKdmhlRU5wVWNZLy95V29H?=
 =?utf-8?B?Vk41SzdHYjR6NjNwd2RVeDhORFN2dXpmTEIweTRhRStTZy9IbFhmdFpHS3l0?=
 =?utf-8?B?ejBWZDVqZWNWclZxUDdyZnBPc1BHVEo2RS9UbXBXOTlQT2lCY01hUEhsZHpk?=
 =?utf-8?B?djZrVGdKNjZFaUxSQ0NOZ2Nra2xlMzdxdEdYaSttWVFPYWVONDMvWVBGVTNC?=
 =?utf-8?B?eTlhOVZwRGw3YzBOTGRKNlc2V1gwYVJaOTAxd29pZ3NUd04rSDdza0xEczJS?=
 =?utf-8?B?azNaL2l3cWxpY2pKNngyOXJkMnBRT255Ull5MkFlL3ZJdTVuQkJSbTI3R1JR?=
 =?utf-8?B?MWtPQStvUTVXV2JxbXV0ZkprM1cwMVNtL3lLTHo3TWI1cCtsTHcwZTdmRHFB?=
 =?utf-8?B?cWpnWjZSVkUxeXN2Z2JVM1cvZE9LTHQrdEUvOEFRV2EwU1BYOGZJNTFNYnMx?=
 =?utf-8?B?RkdHVEpuYThUSkMvS2JYYWNlVmdwRytTaVFuMlpNOXFDSXhWRDA0M2Ewb2xJ?=
 =?utf-8?B?bFNXWXBJejhTYldiZU5xajFteFp5MnNtUE91VUpnTkN4ckpSdjZnZW9rQTBE?=
 =?utf-8?B?bkUrZUdGcnQ3U0ZCYXFJdmNtZ0VuUThQelN5UnB6VTR0Z1BSUFJBcVk2M0Np?=
 =?utf-8?B?OXM2MEdvRThlZk1mZ0lKbjYzSld0dGNlZWdMNlR5bkt4Q0k4aGJXREZyaFdt?=
 =?utf-8?B?S3I4OU44RUVsa3N3c2xqWnBrNGc3TWtHZVBWQ1dBQ2NEaW1vMmt6ZVRiNGp6?=
 =?utf-8?B?WVhGbkRxOTY1bC9UaTVNYTkyK0wxWHAydGk1T3VCcFYrTlpBa1ZSam9GYlhq?=
 =?utf-8?B?YUZZdmJLZFdxUVo5aXByaHZnT29xLzNtVG1xL0VGanRpZFRTbTZiZmpyWFhQ?=
 =?utf-8?B?L1RLYzV3Z2p0cER4RWwyK0g1N1BIeHFoUEM2b3p1TEp4UTNWcVNuU0VqSWNN?=
 =?utf-8?B?S081UnVLUk1HMDQybTZZQis3cGdwcUl1cTNoRVFnTWptN0FHNmtHeldzVFc3?=
 =?utf-8?B?dzVYMFZvUUtRcWg3cUNVcFBvOG43bEJlcHRzOFYyR1l0ZTRldXgwNnhmNzFj?=
 =?utf-8?B?dXBvZ0V1VkNiSVZMV1FxTk13S1llaGU2OGZoUWk4ZXlmZklRekhFZTkwY3o3?=
 =?utf-8?B?VDd6Q1RrSUV6ZnRuVGROWFlqZURCelhNSUlSWGlHcVlJN0srLy9nN1NBbEtC?=
 =?utf-8?B?L2hrSE9Obi81WFd1RUlyVEFtME5hZzYyT0lNOE5PNXJyaGNQMjJWdm9TbEJr?=
 =?utf-8?B?aSttNWhqOW5XYkh1U0hkbVRzZnlBN1hnSmRuQVVZblF3alB2cnJ1Z3FEaER3?=
 =?utf-8?B?WDBtNW11R25NT09jOVZ1c3FUbURqdHMvNlRva0FkSURiMGl4WHdKUnVJUDRu?=
 =?utf-8?B?L3ArdFF6ejk2aTFrdXlMZmlwUWxkWmdwQ1JaZEcraDRqWVMxY1craUJoWTRw?=
 =?utf-8?B?QmxtU2t4T3FIQklHUnpuN2dHMkNOSXhSYksrVEVPTi93aHNWdWUrTVRtaXJ5?=
 =?utf-8?B?YXNIR3dWdU5CYmNXM1VsWkJRV3NGS0EvdU0zY0pQZlBJc1BRazkwR2lmK1JN?=
 =?utf-8?B?Uy9kelRKVGV1SG9UQ0c0MTE2VHpDc2cyS2RRRzJZZnYrcSs1RVhuTUJ5K1p2?=
 =?utf-8?B?NElhOHd4YWVxRUg3RmwweWN0UnIwNjBRTjlZS0phWUQyWlNRbEJ2RVNwN2sv?=
 =?utf-8?B?N1hWekN5TzZ4RTJjdWs4QzF5ZkxZaVZCc2FUaWtRbHJrektvN01rZWdKUlRB?=
 =?utf-8?B?WUV1S3BkemF5dlZDTDRQNUNMcEp0SHhSWXF4aWhBR2VhbmtBcWFmUW9obi9V?=
 =?utf-8?B?cjV0VzFXRVdZU1NoOWEwa2NDMElxMFN4UlExcndZLzd0Q0FDSy9wVGhuWUN6?=
 =?utf-8?B?YUZOaS93c0gwTjlzZUZ6STlrd0lNSnVuTVQ5V1ZaVzhJQzJ4UVVERWU1MkZn?=
 =?utf-8?B?M1A3M2sxTGk0eUVVd3owQlU1eGo1Y3l4VTUraW1WQ1RSU00zcUQ0YWU0UlRi?=
 =?utf-8?B?REFzd0pBMVdmY2F4SGVKVEgwZUlRWXFFMkNhVjI1a2ZBS1E3V0lBVFFNdXh6?=
 =?utf-8?B?MWxQS0MzQkg2WElweW4zUS90elA0dTF0cDlobVRCK21LamRxdEVtMEFjU3V5?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16bde5bb-ec64-46c6-e18d-08ddec0fc706
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 00:04:26.8168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7IGGBDzcFKL2QxDaDaHsPJduOIzhNW1zZMndbVMO8iV52Yp82lSaARAiYUxyZYXElO+iiZ29qC3muw9e61KEM6WDUyiADJILM8sPVLCCLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7030
X-OriginatorOrg: intel.com

--------------fEM4W0MZ1unYEI65sbuR44oO
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/2025 5:13 AM, Borislav Petkov wrote:
> On Sat, Aug 23, 2025 at 08:52:06AM -0700, Chang S. Bae wrote:
>>
>> Also, define cpu_primary_thread_mask for the CONFIG_SMP=n case, allowing
>> consistent use when narrowing down primary threads to locate the
>> per-package interface.
> 
> This paragraph is stale now and can go.

Ah, right. Sorry, I had to chop it out.

>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>> index b65c3ba5fa14..0356155f9264 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -913,6 +913,8 @@
>>   #define MSR_IA32_UCODE_WRITE		0x00000079
>>   #define MSR_IA32_UCODE_REV		0x0000008b
>>   
>> +#define MSR_IA32_MCU_STAGING_MBOX_ADDR	0x000007a5
> 
> Doesn't look sorted to me.

Okay, I think this 'MCU' looks a bit fuzzy. Intel folks already use this 
acronym elsewhere (e.g. MSR_IA32_MCU_OPT_CTRL). It might be clearer to 
consolidate them under one section, like:

/* Intel microcode update MSRs */
#define MSR_IA32_MCU_OPT_CTRL           0x00000123
#define MSR_IA32_MCU_ENUMERATION        0x0000007b  <- patch7 adds this
#define MSR_IA32_MCU_STAGING_MBOX_ADDR  0x000007a5
...

>> +	/*
>> +	 * The MMIO address is unique per package, and all the SMT
>> +	 * primary threads are online here. Find each MMIO space by
>> +	 * their package ids to avoid duplicate staging.
>> +	 */
>> +	for_each_cpu(cpu, cpu_primary_thread_mask) {
>> +		if (topology_logical_package_id(cpu) == pkg_id)
>> +			continue;
> 
> <---- newline here.

Fixed. Thanks.

>> +		ret = do_stage(mmio_pa);
>> +		if (ret != UCODE_OK) {
>> +			pr_err("Error: staging failed with %s for CPU%d at package %u.\n",
>> +			       ret == UCODE_TIMEOUT ? "timeout" : "error state",
> 
> What does "error state" mean?
> 
> Are we going to dump additional error state so that it is clear why it failed?

Yeah, right. The wording "error state" is vague.

The next two patches in this series introduce helpers that return an 
error code and *also* update this ucode_state. The latter could go away. 
Instead, the error code could be just down through here and decoded like:

static const char *staging_errstr(int code)
{
   switch (code) {
   case -ETIMEDOUT:	return "timeout";
   ...
   default:		return "unknown error";
   }
}

static void stage_microcode(void)
{
   ...

   err = do_stage(mmio_pa);
   if (err) {
     pr_err("Error: staging failed with %s for CPU%d at package %u.\n",
            staging_errstr(err), cpu, pkg_id);
     return;
   }
}

I've attached a diff on top of V5 to picture what it will look like.

--------------fEM4W0MZ1unYEI65sbuR44oO
Content-Type: text/plain; charset="UTF-8"; name="tmp.diff"
Content-Disposition: attachment; filename="tmp.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWljcm9jb2RlL2ludGVsLmMgYi9hcmNo
L3g4Ni9rZXJuZWwvY3B1L21pY3JvY29kZS9pbnRlbC5jCmluZGV4IDQ1NWI1MDUxNGQ4Ny4uYWU0
YjA4ZTcxZTIwIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21pY3JvY29kZS9pbnRl
bC5jCisrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWljcm9jb2RlL2ludGVsLmMKQEAgLTk4LDcg
Kzk4LDYgQEAgc3RydWN0IGV4dGVuZGVkX3NpZ3RhYmxlIHsKICAqIEBjaHVua19zaXplOgkJU2l6
ZSBvZiBlYWNoIGRhdGEgcGllY2UKICAqIEBieXRlc19zZW50OgkJVG90YWwgYnl0ZXMgdHJhbnNt
aXR0ZWQgc28gZmFyCiAgKiBAb2Zmc2V0OgkJQ3VycmVudCBvZmZzZXQgaW4gdGhlIG1pY3JvY29k
ZSBpbWFnZQotICogQHN0YXRlOgkJQ3VycmVudCBzdGF0ZSBvZiB0aGUgc3RhZ2luZyBwcm9jZXNz
CiAgKi8KIHN0cnVjdCBzdGFnaW5nX3N0YXRlIHsKIAl2b2lkIF9faW9tZW0JCSptbWlvX2Jhc2U7
CkBAIC0xMDYsNyArMTA1LDYgQEAgc3RydWN0IHN0YWdpbmdfc3RhdGUgewogCXVuc2lnbmVkIGlu
dAkJY2h1bmtfc2l6ZTsKIAl1bnNpZ25lZCBpbnQJCWJ5dGVzX3NlbnQ7CiAJdW5zaWduZWQgaW50
CQlvZmZzZXQ7Ci0JZW51bSB1Y29kZV9zdGF0ZQlzdGF0ZTsKIH07CiAKICNkZWZpbmUgREVGQVVM
VF9VQ09ERV9UT1RBTFNJWkUgKERFRkFVTFRfVUNPREVfREFUQVNJWkUgKyBNQ19IRUFERVJfU0la
RSkKQEAgLTQyNSw3ICs0MjMsNyBAQCBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCBjYWxjX25l
eHRfY2h1bmtfc2l6ZSh1bnNpZ25lZCBpbnQgdWNvZGVfbGVuLCB1bnNpZ25lZAogICogVXBkYXRl
IHRoZSBjaHVuayBzaXplIGFuZCBkZWNpZGUgd2hldGhlciBhbm90aGVyIGNodW5rIGNhbiBiZSBz
ZW50LgogICogVGhpcyBhY2NvdW50cyBmb3IgcmVtYWluaW5nIGRhdGEgYW5kIHJldHJ5IGxpbWl0
cy4KICAqLwotc3RhdGljIGJvb2wgY2FuX3NlbmRfbmV4dF9jaHVuayhzdHJ1Y3Qgc3RhZ2luZ19z
dGF0ZSAqc3MpCitzdGF0aWMgYm9vbCBjYW5fc2VuZF9uZXh0X2NodW5rKHN0cnVjdCBzdGFnaW5n
X3N0YXRlICpzcywgaW50ICplcnIpCiB7CiAJc3MtPmNodW5rX3NpemUgPSBjYWxjX25leHRfY2h1
bmtfc2l6ZShzcy0+dWNvZGVfbGVuLCBzcy0+b2Zmc2V0KTsKIAkvKgpAQCAtNDQ1LDEwICs0NDMs
MTEgQEAgc3RhdGljIGJvb2wgY2FuX3NlbmRfbmV4dF9jaHVuayhzdHJ1Y3Qgc3RhZ2luZ19zdGF0
ZSAqc3MpCiAJICogbGlrZWx5IHN0dWNrIGFuZCBtYXJrIHRoZSBzdGF0ZSBhcyB0aW1lb3V0Lgog
CSAqLwogCWlmIChzcy0+Ynl0ZXNfc2VudCArIHNzLT5jaHVua19zaXplID4gc3MtPnVjb2RlX2xl
biAqIDIpIHsKLQkJc3MtPnN0YXRlID0gVUNPREVfVElNRU9VVDsKKwkJKmVyciA9IC1FVElNRURP
VVQ7CiAJCXJldHVybiBmYWxzZTsKIAl9CiAKKwkqZXJyID0gMDsKIAlyZXR1cm4gdHJ1ZTsKIH0K
IApAQCAtNDY1LDkgKzQ2NCw5IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBpc19lbmRfb2Zmc2V0KHUz
MiBvZmZzZXQpCiAgKiB0aGUgZW5kIG9mZnNldCwgb3Igbm8gbW9yZSB0cmFuc2FjdGlvbnMgYXJl
IHBlcm1pdHRlZCAocmV0cnkgbGltaXQKICAqIHJlYWNoZWQpLgogICovCi1zdGF0aWMgaW5saW5l
IGJvb2wgc3RhZ2luZ19pc19jb21wbGV0ZShzdHJ1Y3Qgc3RhZ2luZ19zdGF0ZSAqc3MpCitzdGF0
aWMgaW5saW5lIGJvb2wgc3RhZ2luZ19pc19jb21wbGV0ZShzdHJ1Y3Qgc3RhZ2luZ19zdGF0ZSAq
c3MsIGludCAqZXJyKQogewotCXJldHVybiBpc19lbmRfb2Zmc2V0KHNzLT5vZmZzZXQpIHx8ICFj
YW5fc2VuZF9uZXh0X2NodW5rKHNzKTsKKwlyZXR1cm4gaXNfZW5kX29mZnNldChzcy0+b2Zmc2V0
KSB8fCAhY2FuX3NlbmRfbmV4dF9jaHVuayhzcywgZXJyKTsKIH0KIAogLyoKQEAgLTQ4OSwyMSAr
NDg4LDE2IEBAIHN0YXRpYyBpbnQgd2FpdF9mb3JfdHJhbnNhY3Rpb24oc3RydWN0IHN0YWdpbmdf
c3RhdGUgKnNzKQogCX0KIAogCS8qIENoZWNrIGZvciBleHBsaWNpdCBlcnJvciByZXNwb25zZSAq
LwotCWlmIChzdGF0dXMgJiBNQVNLX01CT1hfU1RBVFVTX0VSUk9SKSB7Ci0JCXNzLT5zdGF0ZSA9
IFVDT0RFX0VSUk9SOwotCQlyZXR1cm4gLUVQUk9UTzsKLQl9CisJaWYgKHN0YXR1cyAmIE1BU0tf
TUJPWF9TVEFUVVNfRVJST1IpCisJCXJldHVybiAtRUlPOwogCiAJLyoKIAkgKiBIYXJkd2FyZSBp
cyBuZWl0aGVyIHJlc3BvbmRlZCB0byB0aGUgYWN0aW9uIG5vciBzaWduYWxlZCBhbnkKIAkgKiBl
cnJvci4gVHJlYXQgdGhpcyBhcyB0aW1lb3V0LgogCSAqLwotCWlmICghKHN0YXR1cyAmIE1BU0tf
TUJPWF9TVEFUVVNfUkVBRFkpKSB7Ci0JCXNzLT5zdGF0ZSA9IFVDT0RFX1RJTUVPVVQ7CisJaWYg
KCEoc3RhdHVzICYgTUFTS19NQk9YX1NUQVRVU19SRUFEWSkpCiAJCXJldHVybiAtRVRJTUVET1VU
OwotCX0KIAotCXNzLT5zdGF0ZSA9IFVDT0RFX09LOwogCXJldHVybiAwOwogfQogCkBAIC01NDUs
NyArNTM5LDYgQEAgc3RhdGljIGludCBmZXRjaF9uZXh0X29mZnNldChzdHJ1Y3Qgc3RhZ2luZ19z
dGF0ZSAqc3MpCiAJY29uc3QgdTY0IGV4cGVjdGVkX2hlYWRlciA9IE1CT1hfSEVBREVSKE1CT1hf
SEVBREVSX1NJWkUgKyBNQk9YX1JFU1BPTlNFX1NJWkUpOwogCXUzMiBvZmZzZXQsIHN0YXR1czsK
IAl1NjQgaGVhZGVyOwotCWludCBlcnI7CiAKIAkvKgogCSAqIFRoZSAncmVzcG9uc2UnIG1haWxi
b3ggcmV0dXJucyB0aHJlZSBmaWVsZHMsIGluIG9yZGVyOgpAQCAtNTU4LDU1ICs1NTEsNDIgQEAg
c3RhdGljIGludCBmZXRjaF9uZXh0X29mZnNldChzdHJ1Y3Qgc3RhZ2luZ19zdGF0ZSAqc3MpCiAJ
c3RhdHVzID0gcmVhZF9tYm94X2R3b3JkKHNzLT5tbWlvX2Jhc2UpOwogCiAJLyogQWxsIHZhbGlk
IHJlc3BvbnNlcyBtdXN0IHN0YXJ0IHdpdGggdGhlIGV4cGVjdGVkIGhlYWRlci4gKi8KLQlpZiAo
aGVhZGVyICE9IGV4cGVjdGVkX2hlYWRlcikgewotCQlwcl9lcnJfb25jZSgic3RhZ2luZzogaW52
YWxpZCByZXNwb25zZSBoZWFkZXJcbiIpOwotCQllcnIgPSAtRUlOVkFMOwotCQlnb3RvIGVycl9v
dXQ7Ci0JfQorCWlmIChoZWFkZXIgIT0gZXhwZWN0ZWRfaGVhZGVyKQorCQlyZXR1cm4gLUVCQURS
OwogCiAJLyoKIAkgKiBWZXJpZnkgdGhlIG9mZnNldDogSWYgbm90IGF0IHRoZSBlbmQgbWFya2Vy
LCBpdCBtdXN0IG5vdAogCSAqIGV4Y2VlZCB0aGUgbWljcm9jb2RlIGltYWdlIGxlbmd0aAogCSAq
LwotCWlmICghaXNfZW5kX29mZnNldChvZmZzZXQpICYmIG9mZnNldCA+IHNzLT51Y29kZV9sZW4p
IHsKLQkJcHJfZXJyX29uY2UoInN0YWdpbmc6IGludmFsaWQgcmVzcG9uc2Ugb2Zmc2V0XG4iKTsK
LQkJZXJyID0gLUVJTlZBTDsKLQkJZ290byBlcnJfb3V0OwotCX0KKwlpZiAoIWlzX2VuZF9vZmZz
ZXQob2Zmc2V0KSAmJiBvZmZzZXQgPiBzcy0+dWNvZGVfbGVuKQorCQlyZXR1cm4gLUVJTlZBTDsK
IAogCS8qIEhhcmR3YXJlIG1heSByZXBvcnQgZXJyb3JzIGV4cGxpY2l0bHkgaW4gdGhlIHN0YXR1
cyBmaWVsZCAqLwotCWlmIChzdGF0dXMgJiBNQVNLX01CT1hfUkVTUF9FUlJPUikgewotCQllcnIg
PSAtRVBST1RPOwotCQlnb3RvIGVycl9vdXQ7Ci0JfQorCWlmIChzdGF0dXMgJiBNQVNLX01CT1hf
UkVTUF9FUlJPUikKKwkJcmV0dXJuIC1FUFJPVE87CiAKIAlzcy0+b2Zmc2V0ID0gb2Zmc2V0Owot
CXNzLT5zdGF0ZSAgPSBVQ09ERV9PSzsKIAlyZXR1cm4gMDsKLQotZXJyX291dDoKLQlzcy0+c3Rh
dGUgPSBVQ09ERV9FUlJPUjsKLQlyZXR1cm4gZXJyOwogfQogCiAvKgogICogSGFuZGxlIHRoZSBz
dGFnaW5nIHByb2Nlc3MgdXNpbmcgdGhlIG1haWxib3ggTU1JTyBpbnRlcmZhY2UuIFRoZQogICog
bWljcm9jb2RlIGltYWdlIGlzIHRyYW5zZmVycmVkIGluIGNodW5rcyB1bnRpbCBjb21wbGV0aW9u
LiBSZXR1cm4gdGhlCi0gKiByZXN1bHQgc3RhdGUuCisgKiBlcnJvciBjb2RlLgogICovCi1zdGF0
aWMgZW51bSB1Y29kZV9zdGF0ZSBkb19zdGFnZSh1NjQgbW1pb19wYSkKK3N0YXRpYyBpbnQgZG9f
c3RhZ2UodTY0IG1taW9fcGEpCiB7CiAJc3RydWN0IHN0YWdpbmdfc3RhdGUgc3MgPSB7fTsKIAlp
bnQgZXJyOwogCiAJc3MubW1pb19iYXNlID0gaW9yZW1hcChtbWlvX3BhLCBNQk9YX1JFR19OVU0g
KiBNQk9YX1JFR19TSVpFKTsKIAlpZiAoV0FSTl9PTl9PTkNFKCFzcy5tbWlvX2Jhc2UpKQotCQly
ZXR1cm4gVUNPREVfRVJST1I7CisJCXJldHVybiAtRUFERFJOT1RBVkFJTDsKIAogCWluaXRfc3Rh
Z2UoJnNzKTsKIAogCS8qIFBlcmZvcm0gdGhlIHN0YWdpbmcgcHJvY2VzcyB3aGlsZSB3aXRoaW4g
dGhlIHJldHJ5IGxpbWl0ICovCi0Jd2hpbGUgKCFzdGFnaW5nX2lzX2NvbXBsZXRlKCZzcykpIHsK
Kwl3aGlsZSAoIXN0YWdpbmdfaXNfY29tcGxldGUoJnNzLCAmZXJyKSkgewogCQkvKiBTZW5kIGEg
Y2h1bmsgb2YgbWljcm9jb2RlIGVhY2ggdGltZTogKi8KIAkJZXJyID0gc2VuZF9kYXRhX2NodW5r
KCZzcywgdWNvZGVfcGF0Y2hfbGF0ZSk7CiAJCWlmIChlcnIpCkBAIC02MjIsMTcgKzYwMiwyNSBA
QCBzdGF0aWMgZW51bSB1Y29kZV9zdGF0ZSBkb19zdGFnZSh1NjQgbW1pb19wYSkKIAogCWlvdW5t
YXAoc3MubW1pb19iYXNlKTsKIAotCS8qCi0JICogVGhlIGhlbHBlcnMgdXBkYXRlIHNzLnN0YXRl
IG9uIGVycm9yLiBUaGUgZmluYWwgc3RhdGUgaXMKLQkgKiByZXR1cm5lZCB0byB0aGUgY2FsbGVy
LgotCSAqLwotCXJldHVybiBzcy5zdGF0ZTsKKwlyZXR1cm4gZXJyOworfQorCitzdGF0aWMgY29u
c3QgY2hhciAqc3RhZ2luZ19lcnJzdHIoaW50IGNvZGUpCit7CisJc3dpdGNoIChjb2RlKSB7CisJ
Y2FzZSAtRUJBRFI6CQlyZXR1cm4gImludmFsaWQgcmVzcG9uc2UgaGVhZGVyIjsKKwljYXNlIC1F
SU5WQUw6CQlyZXR1cm4gImludmFsaWQgbmV4dCBvZmZzZXQiOworCWNhc2UgLUVJTzoJCXJldHVy
biAidHJhbnNhY3Rpb24gZXJyb3IiOworCWNhc2UgLUVUSU1FRE9VVDoJcmV0dXJuICJ0aW1lb3V0
IjsKKwljYXNlIC1FUFJPVE86CQlyZXR1cm4gInJlc3BvbnNlIGVycm9yIjsKKwljYXNlIC1FQURE
Uk5PVEFWQUlMOglyZXR1cm4gImlvcmVtYXAoKSBmYWlsdXJlIjsKKwlkZWZhdWx0OgkJcmV0dXJu
ICJ1bmtub3duIGVycm9yIjsKKwl9OwogfQogCiBzdGF0aWMgdm9pZCBzdGFnZV9taWNyb2NvZGUo
dm9pZCkKIHsKIAl1bnNpZ25lZCBpbnQgcGtnX2lkID0gVUlOVF9NQVg7Ci0JZW51bSB1Y29kZV9z
dGF0ZSByZXQ7CiAJaW50IGNwdSwgZXJyOwogCXU2NCBtbWlvX3BhOwogCkBAIC02NTYsMTEgKzY0
NCwxMCBAQCBzdGF0aWMgdm9pZCBzdGFnZV9taWNyb2NvZGUodm9pZCkKIAkJaWYgKFdBUk5fT05f
T05DRShlcnIpKQogCQkJcmV0dXJuOwogCi0JCXJldCA9IGRvX3N0YWdlKG1taW9fcGEpOwotCQlp
ZiAocmV0ICE9IFVDT0RFX09LKSB7CisJCWVyciA9IGRvX3N0YWdlKG1taW9fcGEpOworCQlpZiAo
ZXJyKSB7CiAJCQlwcl9lcnIoIkVycm9yOiBzdGFnaW5nIGZhaWxlZCB3aXRoICVzIGZvciBDUFUl
ZCBhdCBwYWNrYWdlICV1LlxuIiwKLQkJCSAgICAgICByZXQgPT0gVUNPREVfVElNRU9VVCA/ICJ0
aW1lb3V0IiA6ICJlcnJvciBzdGF0ZSIsCi0JCQkgICAgICAgY3B1LCBwa2dfaWQpOworCQkJICAg
ICAgIHN0YWdpbmdfZXJyc3RyKGVyciksIGNwdSwgcGtnX2lkKTsKIAkJCXJldHVybjsKIAkJfQog
CX0K

--------------fEM4W0MZ1unYEI65sbuR44oO--

