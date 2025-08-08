Return-Path: <linux-kernel+bounces-759620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AACFB1E03B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 03:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA98C188CFBA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 01:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF0A85C5E;
	Fri,  8 Aug 2025 01:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I8660ai9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF44751022;
	Fri,  8 Aug 2025 01:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754617479; cv=fail; b=AlZlR22/GqThxypE1fvsS3LsXkneTcIempDbf3+bMQxn3vFSSs9yZsFnogOTOCb5jjDD4+95ksm75dMMsJ25raF7WAeuzSbuUykXXI5lQ44DGBdiMJE40BZod3U/UGPncfra5S1nsFcRoatCBgMkUaHK1xwhK5T6n2gY94kpdN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754617479; c=relaxed/simple;
	bh=01cqtQ0QLu139lXDSLyvWVrImAPyuNGD7w0ZYY03TGY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RI13yxbKpyMrwaPUZkGtOHfiUHMEpSFzjGa37QkS0GLsO8nRtbFY9qLBDOa/QJuqHklESMt1drm8GbzZXrNhcZUiYXFYlIBJOWQ7O1tVXrYYH1zGuCPTpvCPnwadCM3b0IZmWiA6iq2bFuhcMpykVgtZAc1Dka7zUGWOGHETQQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I8660ai9; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754617478; x=1786153478;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=01cqtQ0QLu139lXDSLyvWVrImAPyuNGD7w0ZYY03TGY=;
  b=I8660ai971wRkS0pO7NM1/weM0MnxYS+dUA6F1E0nREdQdJLchaPr81n
   d9QMWK3qVGOkbIc1S8dIsJzKQy0LSOVgpBywvwp2z0WzQ7eYkPtSLolA4
   6tH14hZf2V6k0q8HwNLu/BpNslazhUa73CyancbcznbDeKmW09qvK8FXA
   1/F1jm9qy5B0YlGlwbslxgRo0942xMGCbUFgk8TXEvjkuHdH4l/I9dB8E
   LTMTBCe014eY6dLsFDQntPbBiEAtxhMhNfmim8VVSlpd6cNazW8WC5FDN
   uACYBtUOp7RxqWyDtC4tobAN6IBSC/iYTU+nTjLlLY21GxAi3ycTfI9h6
   Q==;
X-CSE-ConnectionGUID: ydWBBhY1Qlu5+mRrd9XJdw==
X-CSE-MsgGUID: fbRId3LUTkiRQpq6XJbVUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="60771821"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="60771821"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 18:44:37 -0700
X-CSE-ConnectionGUID: tv++EWPhS9WSS97S2EvotQ==
X-CSE-MsgGUID: 67gHuR/6SX+DcZ0d5mxzpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="165545266"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 18:44:36 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 18:44:35 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 18:44:35 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.77)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 18:44:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fb3LlO3n9ZhWOeuOvjKVMkZpUeqM5jO/e49Id3SVkbCiPS5xtUdCfGU44wtVQZwbHNUOrYKJx/Kcme0YYRHjgAKPdO3BdkLCrp+uor+VxxVmB9knJ9VvFYItUOy5Y11qvT9eiHdPICIGEvZrtgPYJ2fXYty5uUE9N821EWV7rxywJq39Cplzr9ewXAR4Sw7vf/DBA4cMKnpdmCxQwJkG2Tn8Y+OTFWocTIysTFppXyP2CYzehwiJ2Tx1N/nmOyDEyYFYIZhyMqq9eQypXRA8Th980ElJVswXACYxWCHoA83eQfdUgUgavI8roNDNzQIwP8G2OABpsflaFx2L9ZZmNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0Za4oDqvQWC8PUP95rzXFtX/IMtENcq9oX/XXsVla8=;
 b=IzHh+P+kmprFjnD5u3DR9PI4rqk3kgFDTE5vx7LoGKbtc+/lXfrf+vd3BiJOJ827SZd2DLx3A51Tp7C0yYsbqTxS6d+RGe7MZqb85W5F/aLy2UNqU1zgSnCN4VhieighbATf3iK2hM4JjvEcy4h6XX7FZwZ8PQySJYR6AJKu1a20eah5eWOhGnRKkEkAyIYaxv/frHKA8N0DAik91OJdScqfTjmlMrno58OFXdKgvr4vdZk1u6aBHfxcNOo26LSK66LO9LWnioYgIyo+epm/BxPAhLurxe1q+VeBnAQGgast3d40adhJNpDyFpYwiWD0N8ei6q7+F4TFHeRP+fonag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH8PR11MB7992.namprd11.prod.outlook.com (2603:10b6:510:25b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 01:44:33 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 01:44:33 +0000
Message-ID: <195d8806-9a00-49d8-8891-f59bca97582e@intel.com>
Date: Thu, 7 Aug 2025 18:44:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/10] x86/resctrl: Add SDCIAE feature in the command
 line options
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <rostedt@goodmis.org>, <Neeraj.Upadhyay@amd.com>,
	<david@redhat.com>, <arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <pawan.kumar.gupta@linux.intel.com>,
	<yosry.ahmed@linux.dev>, <sohil.mehta@intel.com>, <xin@zytor.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<me@mixaill.net>, <mario.limonciello@amd.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <ak@linux.intel.com>, <chang.seok.bae@intel.com>,
	<andrew.cooper3@citrix.com>, <perry.yuan@amd.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<manali.shukla@amd.com>, <gautham.shenoy@amd.com>
References: <cover.1754436586.git.babu.moger@amd.com>
 <c6fb4ecdf3412fbfeb1c12dd0cee5d52b7306e01.1754436586.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <c6fb4ecdf3412fbfeb1c12dd0cee5d52b7306e01.1754436586.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:303:2b::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH8PR11MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dcc04aa-5022-4cdb-46e6-08ddd61d2000
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0pQWTlScWE3SG14bG9MWGVnLzVPL2YyWnlOeC9ZMS9LcUQ1bWZOWVJISFQ0?=
 =?utf-8?B?cFRxaWU2dVp0cFhrR2ViSjFFcHhUcVhFM3FjekdWLy9WZGxLNGRxK293RnRT?=
 =?utf-8?B?SmQzSmVOOFo2N3IwMWczc2NNU1hMb25MSDJtdDBOMEVsUVpKa2pXN0krZmk2?=
 =?utf-8?B?T0NRMnVXN0t0UVhISG9XZmtFZkN0dEJqSXlpTXcxdE5WdldiVVp5MHAxVHVi?=
 =?utf-8?B?TjV6aDBLKzlZTm5UcXJ3VDYydkR0bzNNZWFKbUY2czBFREUvSTJyVitEZFFa?=
 =?utf-8?B?cksyY1JmT0xQK3U0dzQ0V1NYRGVqbVlSMkNwTFhnRGJ2clZhZlU4Z2VqenlD?=
 =?utf-8?B?Z0NDbTBLSTNZbTlPbEQ5L0NjSUNWSDhQQ3pyUjhITlRLc1dvOU42YmQ3MzFx?=
 =?utf-8?B?eU9yRG5pUHhKUTBMM3ZPZzB4YXpFSkMwMTJRdU1EMVczeHpnc3dEMFE5enlk?=
 =?utf-8?B?T0s5N05INXVkMDd1V0kvUGtRNk5oOE5MbDMxQmRGNHpQTDEyb29ZRjNrQXp5?=
 =?utf-8?B?eExKUVU0SHpKTkpMT1JaRTNRQ3I5OVZnVUtPQWdvN0h0ZlAvY2RPKytnV2Ro?=
 =?utf-8?B?cVdIQk9oK3VUTHd3THcvZ2p1M3h1QmluN1BpRGlXdEh3VTBrZUgweGdNN3pt?=
 =?utf-8?B?SWg0enEyRlNwa3h4TXpIeFVoaDJCNk9aMnJOU3VsYXpjZGpOVGxETE4vRG9q?=
 =?utf-8?B?YWpYcTdRWE1TdStRVjFPWEJ0T3lOM3g4ZjNKS01pZU1vTnBRRWloNDNVaTBs?=
 =?utf-8?B?Q3JvM1JRbWJ3eVdCS0RNUXRrb25zMlFheWxFaVg0ZVFsOExaaEJpa0lTYmVk?=
 =?utf-8?B?U0FWNlYxaktaeXAvN3dCMTdpNSs1Z2NGRXUvV0lwZUMzZjVzMGw0T1Q4aVFH?=
 =?utf-8?B?ZFRKa2NGZTROZDlla3FzRWNXV2tnV25mNk1xVUt6NVh4MTRCbkZqOHczdVp5?=
 =?utf-8?B?N2tacjVUMmpWRFNBVFV5WjBrdzR3clBrR3QxU1lDMVRFMnpIZGp6TTJlNThZ?=
 =?utf-8?B?SnNFM0JLalQ0QVBkMFpWeCt0bjBhVzlZSkhQcWJBeFBsc3F6eExsMVhJbjdJ?=
 =?utf-8?B?VzFHR00yQVZsdHNQRGVUQXIvdVU4ZHJGOEVDOGc5UnFlcUNqUlh3RFlJbFRy?=
 =?utf-8?B?emNYenZ1em1Lcmcyb25pTVNzM0NaYTFVTWdOdm10RUNTZkR4Y3RscGFYN0I5?=
 =?utf-8?B?Ukc3SHd3ZVYwSFBTSjhjUEdoNjE4WmZScEpWcjZvTmV2WlBJZlJaNWRhUzRE?=
 =?utf-8?B?eElzRGNzbVhNanZPWEQ0UU00cENPa3ZJUWtiWWZib3p1TkF5QUQ5SnlYcU5F?=
 =?utf-8?B?ODZ6YlpwZzV3ekpkaDZ0MWlrWktLSFVtcER6aEVoSXRyelk1akhtWDRVTjQ1?=
 =?utf-8?B?cjd6OXUyZGN1MXdGQ0pob1c3c09LSEc0clhENHZWODQxcFZPZ0M5Qk5CVjA2?=
 =?utf-8?B?Q0hwS1FhR09HZGNSN01BUHhydXVVRWhLVVdvbDVJWFhCM2xEbzlPQmU1WWRK?=
 =?utf-8?B?SmQwS1o2cXpScEpIUU4xUW5Mbjdab29vUllMUzU3alhSVlRwS1RhdEJGRmpD?=
 =?utf-8?B?MUFHQzZDMHpGUGs4R1VyMG9LRlFFMVBDNndaQzNKdXlZaVhSaWdBaHl3bVNN?=
 =?utf-8?B?R2hycm5lUC9RVTY3Q1FFeXpsR3NBV09OT1gyQ01nVGpzWHE1OGNyMjlGd0Uy?=
 =?utf-8?B?L294cnkxQVFvWERDU0cxV0JpMXBhYzRtcTJKM3BrUTRGWEgxK1hEV0swSFBl?=
 =?utf-8?B?TnRkM2xLQkdLSHk2Sk8zTHNXTzFVbGNncEFZUGIzZVlyVHBNWUlrRndQWDlM?=
 =?utf-8?B?U2dwakNVR2NaVEVyZlpSazFiWEZtb0RWZ01VeXpKN2lmRUd0cWZINFpHMnZh?=
 =?utf-8?B?aTdtYzZqa1E0aFdhK2M2eWxZL2NSOG5kdFUwaEh1UlJiWHNrWTB1VkxTOTFF?=
 =?utf-8?Q?+YpXe3wOwG4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?My9pcU1DRzBzbVU0dzF6NUJ5UCtXYStLejk2NWFzc0Y1dUgxajlvZjF4THFC?=
 =?utf-8?B?QUtvM3ZIei9GbFUvblRMczdIdXpQNzQvY1QzeWFDS01NU21YSEY3YUt6Wllp?=
 =?utf-8?B?emF5cWJvUFVqK3QwSUozc0tVV0lIQ2JHbXBPVTNLTzB4TDJwUHlYaGFPbnhJ?=
 =?utf-8?B?bWhobTdtQUZCUm1TQ2JEcHlKbnNtK05YRTJja2k5a0dOSkNnK1lndG9PTE5I?=
 =?utf-8?B?bmxXbTZETS84UGNadVd2YmpqYjJxMGM1MUF4OFkwNW9TYTJQRThGam81Qlk1?=
 =?utf-8?B?OFhLTStPaWJzNHlCYVpOZ25kWWgxUkZrTisxRXNqUFZQbHc5Wkw4OTIzRzNQ?=
 =?utf-8?B?ZzZYR0xWWktqZk5wODdDNS8wSFdoTTdzeHZyUjZUOTAwNitZUEZhbzZYbEZC?=
 =?utf-8?B?Qnh5WFA5bTg4WUN6ZkkycW5XeWJTdkIwRXRrdEIvclVZelljQXNHL1doWUZB?=
 =?utf-8?B?c2F2SlRHTlQ5UlJyVkdidUJOdlhTNmltN3Q5QThFNkRVSTZ0MGVtMHZGUkFl?=
 =?utf-8?B?RmZacUlRZ3JzTTdXVDJnUm0ybXUwZEltOGh3dzNSTEtEcXNSVWZSRzRYZEZM?=
 =?utf-8?B?cThvcUJaZzIwYitLOVdzTmlpZ251OVRIQlVJWFU1WFFocDBWQzByb05PVmNs?=
 =?utf-8?B?MTlhNCsyaWNyU3ZYMllIRjJyaVR6NmJOQjYwdkd5R09ZS3M4SGN2WVducEpT?=
 =?utf-8?B?K1pQWm4vMURpUmJRNkl5L3ljam5aRmtHOGpQSnROY1pqNlZGcm8yNjdGaWwy?=
 =?utf-8?B?dHNzNnJrTHVhb05EZmRyV2RlNHdmUFYvdVdzbWdSVWxBODJDbVFxcEVHY0dw?=
 =?utf-8?B?R2dKWDZRMkJqY2xPVHB2Rnh1dk8vUjI3Kzk4b2ZXWVFqcEdxNjRPTnRuN3gv?=
 =?utf-8?B?SjVLSm8yWU1FbVVybi90TlpNVzc1enBKNUhYaVlrRW1QbUhqczNYQWVwck1C?=
 =?utf-8?B?d0IwT3pPWURsK041M2pFRnZFZDk5dmFTVWtMMXVoaXVMWmVIRnAyMFJLZDBG?=
 =?utf-8?B?MDg1VkU3djBqZFNLLzd4NnB4S0d1SUFCMENRZVlGNmd6bGlQUmk2SzB2TSsr?=
 =?utf-8?B?MnhBQ01QKzhjRVQweVNDd0dqdndJbno0R2dpMHZDYldXYTMxTlVwQzgyQmNI?=
 =?utf-8?B?RTBVekNkb01FVkI0aWh2cEhJMmtzRWp3SHZLc1JERCszNVFYK3Jka2tzWHVt?=
 =?utf-8?B?dmhoaUl2cVBrTkR5RXp6d3ZPYWkyOE45OENDTDZUQzV0blhnZEU4ZW1xNktR?=
 =?utf-8?B?WlpWWk1iWnRkR2NzNVVTZnBtV0tCMTBFM1pUamk3YUtEUjV5aHRNWG5ubFhm?=
 =?utf-8?B?VlFueWJ0MzFpekxNc3MxLzJGb3FwMUJlZGdPY1JyakV0THBFTUZndUZVNE1E?=
 =?utf-8?B?NWhJeC9XWWJ2TjhiRy93U1ZKMVpIaGgzY0gvckR5K0NOTjlJN2VvTEFMWTM0?=
 =?utf-8?B?YlFwQW5xUVpxNFl2b0hyYUFIaWl2MFdZeWVBZ0ZpT09WMGNGZ0k2UlpBZWtv?=
 =?utf-8?B?MSs2VnFsZFEwYnpNQzlJWnY5dVNxb3FaOUxSQ05ZZUpUaE92TXF3MzIrSVVs?=
 =?utf-8?B?a20rVjhJaDEzMU12NzBNbGF1MHh3cnZacm5adEdRUGovbVd1QUg1MkVteGNp?=
 =?utf-8?B?L1hnajFJVzU3VDRYVGVrMmpieU1lMFVsVlA5TEZleVNOY1dqRU44N29uRFk3?=
 =?utf-8?B?SUFWcjV2ZE9ZcWIvSlg0aU5iZ2pOQzh5UklIakZVRUdXbjdrK043UnBEc0ll?=
 =?utf-8?B?dmVlN2FhQU1Vc3VSNzdQNHF4cjFaUUhmU3ltbXVtYldYWXVxVjlKYTVneXJr?=
 =?utf-8?B?Qlc5OXltN3NUWVZ4R2NZTnZKelpvT0hJeC9ZWWMwMDg3NElNajJpZDN2akJP?=
 =?utf-8?B?bzN6MjFwRnJCRTh4S1pMUHhhVjJZN2NUa0NzVnJVTDRGTlZROXJ2WEl2bUww?=
 =?utf-8?B?QXJIaWZsd2txcmZWdTJkWGM0bS9rQ0xoY2hwTStDZ0t1Mi9FQlQ5RkwrMUFB?=
 =?utf-8?B?ZnlVVlliOEZhN0Y5d2pqK1hXaTNWSHJpQzA5Q0o4aWhHUVo2OVMyYUQwQ016?=
 =?utf-8?B?aTlzU3JoNENOdWZrWWdaVUcvc1pEYVc1dFUveVRyV0wzOXlDck5lQzNOb05U?=
 =?utf-8?B?dkFOTUdvWWRZRExOMFZ4d1BEd0JjdE04Rlk5NHdBOXRVZklFSlI2QWx2anhn?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dcc04aa-5022-4cdb-46e6-08ddd61d2000
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 01:44:33.6814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNNagPftFQE1pSAqFvfTrqRK7FOOmKUqydEhfpqlGMEl+/HOTREZ8ZiF5kR54ANtVW1AG9/MIaLNdVEZCBHRRkVokt/RbGpklFEb2qfQ09o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7992
X-OriginatorOrg: intel.com

Hi Babu,

On 8/5/25 4:30 PM, Babu Moger wrote:
> Add the command line options to enable or disable the new resctrl feature

options -> option?

> L3 Smart Data Cache Injection Allocation Enforcement (SDCIAE).
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

> ---
>  .../admin-guide/kernel-parameters.txt         |  2 +-
>  Documentation/filesystems/resctrl.rst         | 21 ++++++++++---------
>  arch/x86/kernel/cpu/resctrl/core.c            |  2 ++
>  3 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0d2ea9a60145..0170c0af03cc 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6089,7 +6089,7 @@
>  	rdt=		[HW,X86,RDT]
>  			Turn on/off individual RDT features. List is:
>  			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
> -			mba, smba, bmec.
> +			mba, smba, bmec, sdciae.
>  			E.g. to turn on cmt and turn off mba use:
>  				rdt=cmt,!mba
>  
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index c7949dd44f2f..f08699030312 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -17,16 +17,17 @@ AMD refers to this feature as AMD Platform Quality of Service(AMD QoS).
>  This feature is enabled by the CONFIG_X86_CPU_RESCTRL and the x86 /proc/cpuinfo
>  flag bits:
>  
> -===============================================	================================
> -RDT (Resource Director Technology) Allocation	"rdt_a"
> -CAT (Cache Allocation Technology)		"cat_l3", "cat_l2"
> -CDP (Code and Data Prioritization)		"cdp_l3", "cdp_l2"
> -CQM (Cache QoS Monitoring)			"cqm_llc", "cqm_occup_llc"
> -MBM (Memory Bandwidth Monitoring)		"cqm_mbm_total", "cqm_mbm_local"
> -MBA (Memory Bandwidth Allocation)		"mba"
> -SMBA (Slow Memory Bandwidth Allocation)         ""
> -BMEC (Bandwidth Monitoring Event Configuration) ""
> -===============================================	================================
> +=============================================================== ================================
> +RDT (Resource Director Technology) Allocation			"rdt_a"
> +CAT (Cache Allocation Technology)				"cat_l3", "cat_l2"
> +CDP (Code and Data Prioritization)				"cdp_l3", "cdp_l2"
> +CQM (Cache QoS Monitoring)					"cqm_llc", "cqm_occup_llc"
> +MBM (Memory Bandwidth Monitoring)				"cqm_mbm_total", "cqm_mbm_local"
> +MBA (Memory Bandwidth Allocation)				"mba"
> +SMBA (Slow Memory Bandwidth Allocation)         		""

With all these adjustments this looks like an ideal time to fix the missing TABs in the SMBA spacing?

> +BMEC (Bandwidth Monitoring Event Configuration) 		""
> +SDCIAE (Smart Data Cache Injection Allocation Enforcement)	""
> +=============================================================== ================================

Reinette

