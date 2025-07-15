Return-Path: <linux-kernel+bounces-732269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0962B06453
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C37C163691
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C2C26B76D;
	Tue, 15 Jul 2025 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FPYhA+dw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBC223909F;
	Tue, 15 Jul 2025 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752596824; cv=fail; b=FVahiv/9b8vF8NVZY3Z1SAErNMffSFrwYhj09vm4HrFA9/sKsoi0TimOb4FonkGhQu7Ds2A+6N/yWzE8WaQ5qXrZJmSVidE36cqtEqXyiIDaiv93u5CHN/t7FDp4FAW9U8NkzxCi+04se9h59kcjiZmt9CFYYeSbkssfPx5MIzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752596824; c=relaxed/simple;
	bh=o/+k2G0r4qUMTXeS0mJaN0q59f381CFj4SaLMJgdw74=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gSuLxkemVcCDlWGbbLBqrM7QokvzJIOzkPvBtHwMqCjOQzt2coB4mf6FZCUqKXEeUepH//8Qcf2A+M53tB8VmCKFthvnTo8D5ecSBJDoBEJXtyxMGPh8NDs3BaLbNTsq09ApXHMlXWbnIGahCdOwflcglFLrA4eRG8lTCW48+VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FPYhA+dw; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752596824; x=1784132824;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o/+k2G0r4qUMTXeS0mJaN0q59f381CFj4SaLMJgdw74=;
  b=FPYhA+dwVV3srHk6Mv7Dp/p/RCd8VNH+scaaohvAG0wgkKsQRAjh/kzr
   D3KCY0vTpQtQ6WRpc9xfi/GM1yP3WobuDI0hf6IB+VclQCOM99kcVK54U
   MmlwvdKyrFqDSvAjXjlM47cAf2qc170XCv8UqReALFihNVuK7q4AKITWr
   du3NKNUh0cM5ctZm8Yba/4ciHADwOi+p8IFo+tSlhYL5VD42uFKD2kkt1
   KVAK1QM+tRCwoVcyvmZshUtG8xAfHLa8fvlhPbf5DaFoGKEY4mVW6ksbp
   TZO3COCYdrlKNdC0X8Qikkf+mITsmd8fgSxL0mQElI99OrJ0Akorpfi/4
   A==;
X-CSE-ConnectionGUID: 1XVYyTFhRJiNm12yHUq8ZA==
X-CSE-MsgGUID: 6H5IWQKmTIqHF/suti3ojw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58479847"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="58479847"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 09:27:03 -0700
X-CSE-ConnectionGUID: cXUBQmxiQGKOuwKwc4CyLQ==
X-CSE-MsgGUID: k741XGzxRdCVcPptN4T+Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="157771370"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 09:27:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 09:27:02 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 09:27:02 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.88)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 15 Jul 2025 09:27:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZ/vmQ1z5b2HyCnUClGlBskSXivde6B8wMlRkLkm5sWVMyiMND9oQ2ThymBlhwu4DTn3eHkVgwVe6yGXI4IroZKuWYtwu7ipRiQ5ztP/sarQFAz48bZl4G4OxYqBaBBPpTFcMb/hnWyjw6MCfsSyafnSluz+d7OVZ/XbwlHLiKMnca6KdVg2fQlydG6HoLdhGPT1j5HjrR2k/QwT4ZUB3CyjHmZABbc1jgzqcwq/9C2UswLHSXi/VpMhZDJyzxUXOsp6HK1bfxJnOdw+yIwzrV60gQFz21a5y7kX5+ZpGAH3g2whXXDeRkuv781z+bVWJ7Xi8W+ka6MKKqsRT6+zwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EI/q5sL4o7RcGTPmdAZ21C63UdkLNUjZGVjI8lSajYw=;
 b=o74HZYnQJhwJLtk0ZTevBzjTsizY0J+V2oEBpX8DXSpIbPNGkc2XX7NS9F4eIhsRTTCWcmuiscozmKW6HTXubub1IUk7zWBaW5hg9fWkQEiIbVzirjAEotTZfdy2Bp+5a2X0fn5bpj5WY8tnpsH0O9H9afh/ozRxfmTapInumlBhMl3jwvvPAWsbrAD6vfRG0Paif1LGrWkrhBsrh4riBkZTZMWMUSpVvu7ghwIOk5H2o2gEue61iM3xduGTyWyo3zy0Wf5ARGbbRDrk/mYZ2HG8Bwdaig4Agodmjs7V6BptRNGP3dzYSwAzVhEUDNUmdw5IFN7+sEj8Zqn9SDD47g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY8PR11MB7948.namprd11.prod.outlook.com (2603:10b6:930:7f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Tue, 15 Jul
 2025 16:26:58 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 16:26:58 +0000
Message-ID: <8e4aa815-e08b-4513-ad41-9fa542fb4243@intel.com>
Date: Tue, 15 Jul 2025 09:26:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 08/34] x86,fs/resctrl: Detect Assignable Bandwidth
 Monitoring feature details
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<Neeraj.Upadhyay@amd.com>, <david@redhat.com>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<manali.shukla@amd.com>, <tao1.su@linux.intel.com>, <sohil.mehta@intel.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<xin3.li@intel.com>, <kan.liang@linux.intel.com>,
	<mario.limonciello@amd.com>, <thomas.lendacky@amd.com>, <perry.yuan@amd.com>,
	<gautham.shenoy@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>
References: <cover.1752013061.git.babu.moger@amd.com>
 <e48edcbf4fe2c258ab8d38d9ff78fdb8849c353b.1752013061.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <e48edcbf4fe2c258ab8d38d9ff78fdb8849c353b.1752013061.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY8PR11MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: e4deab17-1c60-4bb1-1838-08ddc3bc6b55
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0RENmRGOU1RdEN6b1MxWW5jTUxiYmY5Z3ZEbURWSVp0ZGJUazZub0p0Y2tS?=
 =?utf-8?B?MlRiV3VqRmJMTVhKUU9oOUxaK0JEK2wvbHRCN09qQjdtWDRRbjl6OWw3Q2I3?=
 =?utf-8?B?cFNMdzM3RmJLUnNZa3BIbWM0Y24xeGNiN3huSzdGR3ZpZlZmRTVIZ3NMVWNW?=
 =?utf-8?B?c3UyaEZHWDc2YkNZVVpUTTVNL0xHT2F2NEg2R2Z3TzJWVEpYR2ZVM21jKzZG?=
 =?utf-8?B?dzdBK0Y1TjVzY05GMmZCT1VsRmlBbEJPeVRad0xaV25HTUIxSTN0TERSTU1J?=
 =?utf-8?B?ZDFpcmRDWFBEODhlcUpXS1pJcGErSjdZY3pZU3cva1laeTJyYVgzT2oyaER3?=
 =?utf-8?B?ejBlYk1xOFNuYXVTNWtkbXU3dHBmZkllYWR5eFRLUG50S1JGWkxmQ1dHU3RF?=
 =?utf-8?B?N2dMbFNUMUNrenkvMWNLc2NzQVVmUmc4TDZ1MmxPTGQ0K1c1RVRjd2FHWkVT?=
 =?utf-8?B?WDJsQnBHbzhVeTJGcTl6UGRUZnhrN3g3L0Fsd1U4TVNqQXlKQ092YklkeHha?=
 =?utf-8?B?VE4vWWF2VHZFWWpLUWMrVjd2ZzRQOUlUQlM5ajU2YzRFS1dHZmR6MEpyNDh3?=
 =?utf-8?B?aDJiU3QrcFVFZEI5S2k0VVlRNFNpUDBBNkdYS29TdDFvQXJSSUlwc21aZ3FT?=
 =?utf-8?B?Qzg1RXVIY25qeGozNWVORDNqT2lmOUV5QVp5SXArczNsajRnQitRVnJRaGQ2?=
 =?utf-8?B?VnROVCtUei94bythQzlJOXVManY0cWxTZ3Rzc3BsK2RXNlIrbndlSlNmY2t6?=
 =?utf-8?B?WkRBQnhXMHZjMnVTRFdYNlRUcVk3bTBHbm52cURBMVJIb05CeHVabUgxTWgz?=
 =?utf-8?B?NGo1VWdnSDMrNkhpWFVNZWZvZ054QUliNmJmSkhRaEhSTlU1bUFoOG04YnMw?=
 =?utf-8?B?VHRFcFhuc2tXWmJmazgvV3RxaGRqNXFUK2xNRk1OT2F1dmdNQ1JIRk5BTnZJ?=
 =?utf-8?B?dXV4R2R2NTE0K3cyK1p5KzYvdU8wK0h5MFVkVHp5NUZacitzRkZWKzNLTklq?=
 =?utf-8?B?MnNzYmJoS2J6b0ozcGxzMGd2QnBCSzZmV1FOM2lqU1lIQ1VMR01RYktKZkpZ?=
 =?utf-8?B?emlZY1ZzeGhsUURlMlVaVzRhU3VDWnBUY3NmOUhpaFdsSi9yU0tYdnV0NmVt?=
 =?utf-8?B?YzVqQ2JHb0xYUUl2THIxM1J2T3RTdzBmSjBQdXFiaXkxem5xUjB3U0lwdnVo?=
 =?utf-8?B?emFESTJSMms1TmxLVUV3TlZRYUhvR2dINlRNYlJoUzdoK3lNVzdBblM3Y1pV?=
 =?utf-8?B?bFQ0VXE3L3QzY042cVhzWTN6QzY4aXlOWUQ5MVVOSCsrZDErOVMwKzdYKzh2?=
 =?utf-8?B?aUk0bDI2aXowdXF3VmNtVFdzL2VQaFhVRkMvWFlDbWFFMHdFejVNa2V3NXZE?=
 =?utf-8?B?VzZoSy9MZjlyVS9BWUR1OXl1QWhuVzVRTGtGVGJjcWVtQVlibUluUzBBVzVq?=
 =?utf-8?B?cFhwV2JHeUh3K0JWUERCOXVlU1ltZmp4MHBDZEoyQkdrN0JMbXdiQVYxSEV6?=
 =?utf-8?B?ZW84K1B4YkxFaFVkNGZnSE5oZ1RLbzMvMTFzc1k2b0d3cHg0U1hoZ1JidW5U?=
 =?utf-8?B?akwySzFqd2l4MjZFNXJWTmM1MjNNdEE5NU9kdEg4WWZKQjRxV3luNk5DbjNL?=
 =?utf-8?B?cUpxcld4bWNEbi9ldVdSYTF4UXpaQ2ptdnYvUkNHbDdMSXRrYXZRV0J6K0pF?=
 =?utf-8?B?b2hUdUJWWXovS0lhRzBic29jQ3I4UHd3d2E0eEkzTDJqZlZ1cUREWUV4R2hl?=
 =?utf-8?B?REJYak9zVEwzVDk4bFVyRkpLbjF2elRQOHRnTHF0YWxNbUw1YVFEMWRRWnlO?=
 =?utf-8?B?RDdJNlpmOHJNQ3hxRnNUbng3N3JybDBFQ1NGN2c5dEhUcDB0VkloNWg3WDdE?=
 =?utf-8?B?QnZPdldNUFNDSWR2dnl0LytqZDJ5VDZhbi95SlVNZWl1K2o3UEJ2RGdYbUhW?=
 =?utf-8?Q?FxXtvGEMxr8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFM0Y1A2ZE84eXZTNysrcU1pdHlwMWo2ZHd5N0JxdUt2UXZwc1hLTk94OGha?=
 =?utf-8?B?U0N3Y2VNNUtpT1NxMzVhcjE2dzkwaUo5QzBQQjdWMUJuNkxNK09RSUxVTHJD?=
 =?utf-8?B?NE0vYk1ORUNXYktGZ1poaFNrSmZKdTZuQ29tbWNHdVE5VlZnd2RqSXAvQ0Zi?=
 =?utf-8?B?S2tQYmNWTDhoOFE5MXB1Q1NpWkg0MkpENHVzWUdqSUE5M3RoaE5QMExNUXdR?=
 =?utf-8?B?c3d2WU5JalFCRmR5NTNSaTdLU0llU2tvS2dYZUVwdWp6ejNHMUl6OFYxSXQ4?=
 =?utf-8?B?Ri9WaVlaelhyQkhJVDR6MlYvRGc1YkxUbW1Sd0lhL2lSMnJvOGpVYTFnSmE5?=
 =?utf-8?B?UnZIUERyODNuMFhVM2tKd1FsQ3lCNWpYaUZTQVZnL3ZicnN5RHlLRHEwY2dW?=
 =?utf-8?B?TTNPc1J3VlNnaTBYcFZPQ2l5dGF1WXJFZ0x0NWZQVm9DeGRLZWRxN2lOai8w?=
 =?utf-8?B?aDAwK1JMcDBKN1IzdFJEV2FpUWtSUU5xUVZBSmorajk0YWpIbjNxWEJraFNM?=
 =?utf-8?B?TjhKL1FudDlYSHo2cVVWL2hEVGY3L2hUcWNNY2tNbDJFc0F5dzExaE9MeDBx?=
 =?utf-8?B?TnBwaDlxSlV2RXRnNEN6S0o5dXBWTndHcXZFNHJrWHBHUEtBK1dPS081Z2o3?=
 =?utf-8?B?ZVQ4VEhCS0FNcTV0Yis2QnRTK2lleWxpQTB0c2xEVDNGYXhkTE52MEowMDls?=
 =?utf-8?B?clIvMlY1R3k2VXBkMVJaSE5ickhqSkZBdVFRUzU5Z3MyZ3BUTzMzd0tQN2Zu?=
 =?utf-8?B?TGh1UFBETGY2QVlKQlN6M042TUpQNTBiL3pUemNXam5OOUEybk1RblF5NnJY?=
 =?utf-8?B?Y3lUUzdLODNDZStuMTVwdUZJMVJUcURibC9zVWVzRi9PeWFoQzZzWTc3TTNk?=
 =?utf-8?B?SFJPZFJ5aHFpVE0zWVUrWklhWTRXWmxGSHBTMXhoVmlKUWsrci92UG1KZTdR?=
 =?utf-8?B?NnVzMjVtZXpRVmptNzRDUVBUaXlJUzJXcFVrRUpaZlgvRHRCWXpsbjVSN0w0?=
 =?utf-8?B?NDdpeFFKem9XaHVVRG9xeitsS1hjNHZOVkhmV00zN1VNeW1NS3lWc3R3eXEw?=
 =?utf-8?B?ZXJGRElkbUU2bGk4K3p2eDJZYkVqa3NpM2Z4RXY0ckszdW5Gam5EMUx5dmdh?=
 =?utf-8?B?cUFHOHhuT2F2M2Y4UnVQUHAzLzN6bkNFVEppb1lNY2E1ZGJQT1JRL2hVYzc4?=
 =?utf-8?B?V3N6SU82emZUV0M5TG1oVFlpWmVJWXcyei9sZDEveGQ3TnNDV0RKRUtLVHhC?=
 =?utf-8?B?WFd6dHYxWU0wVzZZVWlUK2taMXQ3NDJOWkNOcElKODBCTkNIQVIvMXFXcWpO?=
 =?utf-8?B?Wm1uYVZWajVXNFlUa0Eyb3lsWVFMbmk4eXBjaUtKY2QweW51Q2NMUkVCcjZD?=
 =?utf-8?B?OUVvMy9ic3lqSW9lZVp0WnlhcjZ2WVMxK20xU0xyTVlwR1NNVUhpeWFlZUNs?=
 =?utf-8?B?OHNBTmdhY1AwbDlmbzdoQjlsSXE1MVpRemZwZlY5MzhPZXhiMDQ3a1NPRVNE?=
 =?utf-8?B?R0RYWVBSQUVXRUpzeXZzN09DZGd4RHYwaDFJdWdEcE1Sejg3Rmd1Q1IyQ3Zn?=
 =?utf-8?B?STlHQVdUVktrblhVaWR5bkFGVUZBZ2pTMnlGeElLU2lHQnlWM04yWlFqNGdR?=
 =?utf-8?B?eFAyditOOVB3bS94M1d3Rk9jekdYYlp1RS85U0hONll2UnNnb2FTWUVmTmFT?=
 =?utf-8?B?eDBuVlQ5VDZyQTBab2o1T0hYZGxEendEL2dRa0F3MkZtUlE5R0FDbVhSc0pm?=
 =?utf-8?B?N1RoWU45L3RBdFhneGZwUE9QcXkzZ3U1czB6ZktZblNJbDNiZHEwVk5UOHBZ?=
 =?utf-8?B?ZHNDM093VFdIV3F2V0sxOTQ2cE9KbDVta0NXbFRoN2wzcWVGb0poOHd4WTVG?=
 =?utf-8?B?RkI0UEFIeVRBeXR4UjhCYVMzNFZZcmVMeDUvamtLdCtDNXNLQ0paVkZLU3Zp?=
 =?utf-8?B?c2ZmR08xZzcycDZmVWIzY2pCTkVRWnBQc3pHVElWaTVhSXRybVVscWtEMkkx?=
 =?utf-8?B?dVdzb2FhQ2wyRU1MeUJZUk8xeXcxanJkWWFWTTE3dmVrdlcrVG84MjljR3B6?=
 =?utf-8?B?YUJXQjBPZkhReGJpVktnTlpKSEtZNUhmUlhVeUZxc2RBcDJTQlZzNkNBWlJz?=
 =?utf-8?B?TkV3eWRsTVNVUmhjM2oyQ25vTWVrQmMxWlRWN2NnclRrN05UeHJyZGhRMXdO?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4deab17-1c60-4bb1-1838-08ddc3bc6b55
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 16:26:58.0449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTYxgBXGqwYqVYHMbI4wXsNjqRHRDd/UPktG3YUWR8QWYzUEzSVhAjhDLBAQArZ3yVtmqRJrN1p6rJ/QgSkbxogjJP/Jcy87FlBOtI0T0bQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7948
X-OriginatorOrg: intel.com

Hi Babu,

On 7/8/25 3:17 PM, Babu Moger wrote:
> ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
> Bits Description
> 15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
>      Monitoring Counter ID + 1
> 
> The feature details are documented in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC).
> 
> Detect the feature and number of assignable counters supported. Also,
> enable QOS_L3_MBM_TOTAL_EVENT_ID and QOS_L3_MBM_LOCAL_EVENT_ID upon
> detecting the ABMC feature. The current expectation is to support
> these two events by default when ABMC is enabled.
> 

Did the right patches make it out as part of this submission? The above
changelog contains text that was removed per
https://lore.kernel.org/lkml/aca368e0-0936-4852-9cf6-688931e0c65d@amd.com/

Reinette



