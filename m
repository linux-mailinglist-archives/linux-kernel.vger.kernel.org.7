Return-Path: <linux-kernel+bounces-751297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF5FB16760
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CECA918864E8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5B22153CB;
	Wed, 30 Jul 2025 20:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gNKj2T2r"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CCB1EA7FF;
	Wed, 30 Jul 2025 20:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753906146; cv=fail; b=PhxVBOylATT47dG5Xi1XYSQnh55d3sZmWo7rTkVRof4EQOcfs9f7lpSjU+0sgzzgFMYfJ/As7NdMw7A5KJmVFe30PiD69/g6vo6JXgv7MdZbgUDF6w3II4CWgllyPiUmRrfs/TQioIKSpdTFwBAEhYRs2M4rQffU9uM4p+g/QMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753906146; c=relaxed/simple;
	bh=E4G54TdG3gOg2gDhAVQ5R7Jo4BKI+/uPByAxOVBrwmA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z7oofhC8csY51vTkpSmFe0sUs8JCQWv+P1d1p8IlIV1gIRGYEKToXIJY5OgviasY4CUN+0ysZj7ZdCmHyFOz3BowdAVR6UezjY2L8C87UpOKH4jg5gSTQFngFQFq7SoLhDCEsTrUCjyL+AbmtFXMqaDUbJUFWv6ag2k1Hg9pWTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gNKj2T2r; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753906145; x=1785442145;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E4G54TdG3gOg2gDhAVQ5R7Jo4BKI+/uPByAxOVBrwmA=;
  b=gNKj2T2rg+Ak2pPL06VdAT8oc10QwsU7QUjI1E06Bf6xf2N55fGMjTYN
   mYzJ/Gf88PcXeQ+iL5O6YnAka630NQu9ZyI6cZToKF5PrMJvF166AyB4f
   mTMW1JuO56Ka1Y/5bqywv0lGnZRMYKiSjFAeAVT0o7np0TazX558ksSMg
   PqFTom/TLPiYiJvzdeJfcmAfy6gTtGZauAxs798nf9bE7br2GeR9WZsyf
   GaWA8CIGV7rjASdmfwkppxgTsjVe2AV0wY/Urn1/sYaS0IL2kQLa7XBQi
   UEfeynujv1+79YQQ1xC9YwRgJ2cF2ed2KrPVY4NrMVn0I2zARE5Ldg+/x
   Q==;
X-CSE-ConnectionGUID: aQeIyKJ/RfOXWGgC1lWk/Q==
X-CSE-MsgGUID: 4z1sH3wTTyCZ1jXVhlHcDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="67300158"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="67300158"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:09:04 -0700
X-CSE-ConnectionGUID: YF2/t/nzRWSSmK5fcFrlgA==
X-CSE-MsgGUID: lDpHiFstS66tcXPlIorPTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="163863827"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:09:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 13:08:52 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 13:08:52 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.74) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 13:08:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rahxiHgVozeEpwWROa1i0pKATgTiuR3BOCFSy9fVren4Z0eMLNq1Un7i5VvqfWK+z+JYKSHKdhxnq+fjm2JMhW9+P9kD4INOxKYPQysGRkyp7KAZpJ8dHRvxIngkOjuxnEjQW/doeRFPrUIsypjikOVeeC2AF/nrcMBHZlijw+b5qnjwu+hSA1687Ltrm3xLMg1y7Jq2JdO8HzGuEM8yJaiQAGJk50G8imLF+96O2tLzEfI0/nzV5dDEymOgQOwbwAyEs6Pf0rfQuTj7xv0VEdKwHBfCH4KZf4rQmw5PVBzqTgwAix/nn/Zb2ZMKGILYpKuoBa1K0in4K7B/RdSBmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KFV/du9yMlCxr+jDsW/CnHNSs3XH1ZzApIn3UQlFdo=;
 b=EnG7M5Gla64NOmDGTxnq/XX1HSYUGVDWgzL3OzZ9nobJwz5AIt58paV2Z7KQ+2rYpxqyWt3ovr8N2ZGZLn1iIk4NCvJUREDufxRzgT0alqoqYQ7F4tNqNatkhb8K+zofBmsU1QMpQAzpAZCQFJ5q3MrVJQZcS1maed+TgKcU2cJNo/UHJd6YsYPFvWHnNGmf+c6RyfK2F7PnEmf1bTqpYSDV48s55JymQaqdwuf3i3ftMGmHex1hl3Dr36OtvIBH6CpR7P+L2WPhxUrWefQUAOvAKRF7pRA1Js21B3FFooYw0MsE13QXi2ZeVfsL1JY9YrcHBV3pG0RcjPP9JQloeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB4993.namprd11.prod.outlook.com (2603:10b6:303:6c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 20:08:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 20:08:21 +0000
Message-ID: <f653a942-b2e7-45d2-b5fb-458b022a25bd@intel.com>
Date: Wed, 30 Jul 2025 13:08:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 27/34] fs/resctrl: Introduce mbm_assign_on_mkdir to
 enable assignments on mkdir
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
References: <cover.1753467772.git.babu.moger@amd.com>
 <dd92bf598bf7c922b212100ea668f3241f6417c0.1753467772.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <dd92bf598bf7c922b212100ea668f3241f6417c0.1753467772.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0283.namprd03.prod.outlook.com
 (2603:10b6:303:b5::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB4993:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f38ad02-6e93-42d9-7554-08ddcfa4d506
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHpyd3luL2p5ek8xcDN5Qll1U1M1MElSb0c4b3hPcjZPbFV2RHNMdVFESXZs?=
 =?utf-8?B?dGhuU0Q1L0FMaDBLdU95UHlPeFdmTUFjWDVvaE4rYmdLK0ltblRLcndxV2N2?=
 =?utf-8?B?bVVNbXB4cnEvWUdZY0p6R2NJeVZjcjVLa2pvcVNabUN4S2NiK1BRbEpZT1pY?=
 =?utf-8?B?T3kzeTNyVEdPZFJ5YWVKWCtJWkpFWm5SVGdKV2tYWVI3ZmhOaXY0THo0cEJM?=
 =?utf-8?B?RS9ocFcvU3pocEdyeVFtZkhLdGhIcDczcGdQRmFzeHRYVU5icDM0NGFBK096?=
 =?utf-8?B?b29JaUpiMEgrL1cwbTRsS2hjK0ZZQVllekp5Vit4dzhRSmdja3RwL2MxbnZq?=
 =?utf-8?B?Mjh3VEUxTDhsZ0VRcjZTQlhCQTVaR3FFYTVKbEpFVkRPa2haSC9HTTJkYm5K?=
 =?utf-8?B?aVk0U0xYNGZXWmJTbDFrTHRuL3RXSW50ZllQajV4N3R2T1J0SlJtY0VHUEg3?=
 =?utf-8?B?ZDlLNzU4Q0RwNFBhS0NjZmF1cmo1eng0OVZ3cnltdkdtSjNNY2tjOUZSQ3Yz?=
 =?utf-8?B?RjZVWTdVbldkeTVXQmp6TGdaeFFHV3dZd0hJMUNoaGwwWWY2WmV0dVN2NWVt?=
 =?utf-8?B?WnB3VkppWHlGMWFhQ283b3p1a2p0Vm9GNXFQeW5zZUU3Z1lxYW15aU5GTTZL?=
 =?utf-8?B?bWUzNyttTjZMNTZ3Z0FqNkRwNng0QW8vc3NrZWRyZm5uZEtmTXdaeVVmMEFO?=
 =?utf-8?B?dnZ5MjBHMWtpVGdBTS9hVldqK3h5dm9rdjlOeU1qK2VtdEVGV3ZDRUgraUNr?=
 =?utf-8?B?RWpSOEhRREJHWmFrOEViYnhyclpheGZpWHQxSXFTNFJEcDhYSFQ5MEtmOGdG?=
 =?utf-8?B?ZWZjeGE2YU8zVjBHUDNvTTdTZ3FZSmtYMHFtTDV2MFlvaVg1TXIrTFpaNDFa?=
 =?utf-8?B?ZEJMRFBKZVpWN3RqQlBoVXJaZlFKQWthL0hBU0R6K01wV3QvQ2VZenRSZ3F3?=
 =?utf-8?B?V1Vla1pRYnlSeDJCQk5SUXZERVJlbnFPL3o2Vk1RVC8rdVdJQzhqZ2xyWUQ3?=
 =?utf-8?B?aFFBSXRCMHM0RHRYbGR5bU94Vll3L05tQTlEajREWEMxR09QcFpQb2dBeVVT?=
 =?utf-8?B?cHNaUC9yV0R6M0k2aTZzdW9PUEtnM3JKZDZGRHRDUlNzSWZ4eTNxa3R4SGZt?=
 =?utf-8?B?Y2pyV3FSZnBEbjhlakY2bGpDaUZ4VTVqd0kwQ2ZCOFlHWGt2M0xYR1hnOUhL?=
 =?utf-8?B?U2lnekxnTFRJSS9JaWJETFFlcWNPRVVmSkVocFpBMkRjNFk3clRXbjFtNzlW?=
 =?utf-8?B?WUJSQkgvTHp4UmNJVWlGVENNUWF0aUZuT1M4azBQU0pvOGs0WTFuVnE2SWo0?=
 =?utf-8?B?c3RNOEFQSDRDSUVhWksxTmgzUWZZM1J4MnJEcjJTQ3JpL0Evblg4ZzJLdURq?=
 =?utf-8?B?aHNVbEpIWDI2d2VaTEhRbUM1NEx2cWVIUkg0YmdhajVFZmlIb3h4UjdzY1ND?=
 =?utf-8?B?bEVCN084R3ZHZlpjdFlpNjVvWEF1b284bDZCOGdMa3grSHhsczdnNDI2WWdE?=
 =?utf-8?B?aEhnK29IN3lBRUtjNEFGL0gwNi9zaSt6OHI3MktrRmNrVFpVTi9sQ05nVU9W?=
 =?utf-8?B?Tk5yQXhmdlliaTA0dHBVQVdoY2JibXlZSjhadTBFUUxlYnBESUxjaXplYk5U?=
 =?utf-8?B?OXl6MWt5UHRwMTlsY3ltUUI3QjZxbkpSa2pJV05oY0FzN1lPTSttT2VYci8y?=
 =?utf-8?B?UGt3Y2N3NUVSeDlrUmdQcGZCU0UvZmFINU9VYjkyd3hiSnhtbUZoVCtjN2ZK?=
 =?utf-8?B?d2FUMjN2aXl5cnpoT3hEak9yOHNRMno3ckJHZllFSnRveUpSQUk4cmdkSW5m?=
 =?utf-8?B?MVpoREhBdnpXaExtaTIvaWw3aDAwRzQzcExkT2F0QURCeHMwSGg1Y0x3d0VO?=
 =?utf-8?B?REpLaCsyVEQ1cW1MRzJDSENBRkhrTTFJSW1ocGl0SkxLWlVMclpESlRoR1Vu?=
 =?utf-8?Q?XFYW6UnYt2Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0oyYTdveEo0Mk8xZGtPMEh5eDZ3NUdjbVhVV2tOWnNQR1ZTeUJteUJRMkxI?=
 =?utf-8?B?N0Z4ZU1EaTVxbWtJTUdTYnlIRytXRzdsYU9FaGthMDZmNXBHM0Y5bXd1d3Y4?=
 =?utf-8?B?cFMxK0o1VFp6MnVsNzZZWVlBZEdyMHZIR1dxWjBpRkVGTko0SjBhTkVaTUJ2?=
 =?utf-8?B?NVBpU1VkTzBMeWdYTDlYaDZBSm4xcHh1SDNjYnUvWGlROSthMmlHUFU4U0pM?=
 =?utf-8?B?SHhjbXJ6ZHdydTZXd0JQM2FQeEU4RSs5WlJvcDB1akV5MU9QTmdhNUFaRDda?=
 =?utf-8?B?aWtnWnVqbHlrVUVYdGZlWS8zVVljNm9oTWo4Tis5a2RPWENXRnRSa3hhKy9w?=
 =?utf-8?B?TFFSYnlpOHBybndkbm5XRHFrS0c3Q2sxNFdoNERXRDJWaFQxUGhDZ1l6TW4x?=
 =?utf-8?B?Qkk2WWo3OWY0Wk9jL00wSnQyUGRNOEtQMjc4a3pIVXdzRDZoWktTWXBJTmc3?=
 =?utf-8?B?cGNmUlJzem55ZlphNHNJYmEvKzNoUzBsdHphWEpDdmwxR01sVFYwVmd4R1F6?=
 =?utf-8?B?RnBhanJBL1g2b3NLU2hoUUMzNDFtZUl6dkVZNnRLd1F5UUlmQWJ2a2svSVYr?=
 =?utf-8?B?cUt5aTYxeFZLZEJESUZ3SXR3Z1NXa1A4KzhSdFZESHUzQm5qS1RxcVV5SFlO?=
 =?utf-8?B?UTJpU3puZ2tucFJrNWpEaXFleUdGanJtQ3VHWGozU0U0Q3g1eWtZVmZINS9a?=
 =?utf-8?B?SGdTUjZHcHlQWTFqVWtNTjRKaFB1QXJ5UjExL0V4T3NjM0JwWDBvZVVwRVFq?=
 =?utf-8?B?bmxqRzhPbDhMME5SVUlKdUFsZXQ1UnlvQUlwUi9rK1pSdmxMVHJqMUloQVox?=
 =?utf-8?B?N29rT2ZpTmJFa3pxMzExMm5rNVlXQWc0emE4T1FBYUxQMUVJV3BMVzBpWFJE?=
 =?utf-8?B?eG5GSkl0RXpvL0tzVk50Um9XeVA5NWxSQlE3SCtvb2dXU2kxc0ZubGpUb1Zt?=
 =?utf-8?B?Zk9MZ0hSd05JemNMYkwvcGVBTVEwK2Q3dk9NYzd5QjlKenhPb1hGWDM1Tjc2?=
 =?utf-8?B?ZHJ3RmlmcVFCWUo3QVBCQlFPaHEzNUpsSGo0L0FXZGo2QlV6bzdXMWp2Q0RH?=
 =?utf-8?B?SG5xbTZzN2RhVk85NjZZRmhtSTNUUC9qQXpCWjdZbkQzTlE4b2Z6ZUNHaDN1?=
 =?utf-8?B?MmNrNHNNY29GVUVSb1JXRk5JbExQSXU3dXdHdVc2Tm5oTGxhWjJuSERDdnJL?=
 =?utf-8?B?YTRObXZocHJKdTlLZWRqQ21RcGlJMTBGdlVYRiswMndJVktITi9hT3FobGpr?=
 =?utf-8?B?QlFEZ2NLQ0RKQXo4Z3Juak1RS3ZUMmJKSkptZ21ReTUxOFlONGt3MWNvS2FM?=
 =?utf-8?B?Yy9HRUR2bkNDMFlBSkdLYWFMUDA3NGh6dHZIelRjOTJ6dDlRWURxSzUxQ2V6?=
 =?utf-8?B?M2N2YUNVYTNMM1V0RE9VQzUyZ1FtM2EzNkZVOHRSZmdxQlE2SVB2MnQ5WnIv?=
 =?utf-8?B?U284dFY5cVVNdmRueVh3b1p4SElrL0svUmI4SVJuUWJ2M0VZeldKVnNYLzRa?=
 =?utf-8?B?SHN6WWtiZ0FxS3E1V2dNVCtST0VlS1JuZVc4ZFdrN2tnMWJVME9yZ2s4K09n?=
 =?utf-8?B?R28yYUNGd09aS2xnQVdrVEFVUE55bjl1MFhlaXljdFlnTGdtcEx1Z3RLZ0Er?=
 =?utf-8?B?MmRrdGtRdUdLaThsTWJtUW5oWE91N2hYTUhFcWd0WmswclB1YzVNWmE4ZDZD?=
 =?utf-8?B?c3I3TVdIdUdHMm94ZXZqaW80OWp6TFVqSGNmYzQwRG5CY3hmTnJhR2VpamFl?=
 =?utf-8?B?SXR2cWtCU2FESXdPcWZId2NaUmpEVVNrNTM1Vkx6b1k2Zkt6QXBEbWtJZEhB?=
 =?utf-8?B?Z3UvdkdOd0FYUnlRVDJiOFNPelExbmVFSE5MdSsxaktqeWlnb21Vd0t1bEpC?=
 =?utf-8?B?blRkbW5RMkluVmRUS05tcVpyaHA2ejNrdDQ4bmkvYVpLbS8wcE1QLy9uYi9h?=
 =?utf-8?B?eEsyOWZRdU0zeGZGeEErUGlJNGphRitkc2xac2VrMjlDMnJzejIxSGFTL2pB?=
 =?utf-8?B?bkIyR3J0b0crNllyZkt2Y1dISHZHcmxTUVpuOGNJKzRGYzAwcXVSTUdrd0J2?=
 =?utf-8?B?enJBZHB2YStrcFRvdjJ1RG5pdTVnd0c1TnNTeG8ybURJK0tPUnk2MU9mcHh0?=
 =?utf-8?B?bEpZdTRCT0VtUmtaZFNNdmgvU01DemtzUS9pM1BMYzVqWXdlTW41UHRQRTB3?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f38ad02-6e93-42d9-7554-08ddcfa4d506
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 20:08:21.3196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lnraZkD6AsfXyQjZvmHhw1MjeywXBquwAwgKeBTITTA0cyktilR7szGuhp1wqmr6CbuS9ghnwfgki1iodvH80llaxYTWIVDa7fnC9/lwR+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4993
X-OriginatorOrg: intel.com

Hi Babu,

On 7/25/25 11:29 AM, Babu Moger wrote:
> The "mbm_event" counter assignment mode allows users to assign a hardware
> counter to an RMID, event pair and monitor the bandwidth as long as it is
> assigned.

Above implies this addition is in support of "mbm_event" mode while the
implementation applies to any and all assignable counter modes, including
the "default" and for example the upcoming "soft-ABMC". It is clear to me
how this is used and interpreted when "mbm_event" mode is enabled, but not
for the others (more below).

> 
> Introduce a user-configurable option that determines if a counter will
> automatically be assigned to an RMID, event pair when its associated
> monitor group is created via mkdir.
> 
> Suggested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> ---
>  Documentation/filesystems/resctrl.rst | 16 ++++++++++
>  fs/resctrl/monitor.c                  |  2 ++
>  fs/resctrl/rdtgroup.c                 | 43 +++++++++++++++++++++++++++
>  include/linux/resctrl.h               |  3 ++
>  4 files changed, 64 insertions(+)
> 
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index 37dbad4d50f7..165e0d315af7 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -354,6 +354,22 @@ with the following files:
>  	  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
>  	   local_reads,local_non_temporal_writes
>  
> +"mbm_assign_on_mkdir":

Needs a "Exists when "mbm_event" counter assignment mode is supported."?
Also needs clarification on on behavior when "mbm_event" is enabled vs. disabled.

> +	Determines if a counter will automatically be assigned to an RMID, event pair

"will automatically be" -> "is automatically"
"RMID, event" -> "RMID, MBM event"

> +	when its associated monitor group is created via mkdir. It is enabled by default
> +	on boot and users can disable by writing to the interface.

"users can disable" -> "users can disable this capability" or "can be disabled"?

This implementation enables user to read/write this file/property when "mbm_event" mode is
disabled. Considering this explanation I do not think it is clear how this file reflects
system behavior when in "default" mode. There is no difference between mbm_assign_on_mkdir
enabled/disabled when in "default" mode, no? 
Should interactions with "mbm_assign_on_mkdir" be restricted to when
"mbm_event" mode is enabled? If so, the next question would likely be whether value
should change during "mbm_event" enable->disable or "disable->enable". Above states
clearly that it is enabled on boot and it may be reasonable to have it keep (but not always
expose) user's setting when switching between modes.

Restricting it to "mbm_event" mode now gives us some flexibility when soft-ABMC follows
on if/how it can/should support this. What do you think?

> +
> +	"0":
> +		Auto assignment is disabled.
> +	"1":
> +		Auto assignment is enabled.
> +
> +	Example::
> +
> +	  # echo 0 > /sys/fs/resctrl/info/L3_MON/mbm_assign_on_mkdir
> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_on_mkdir
> +	  0
> +
>  "max_threshold_occupancy":
>  		Read/write file provides the largest value (in
>  		bytes) at which a previously used LLC_occupancy
> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
> index 8efbeb910f77..6205bbfe08fb 100644
> --- a/fs/resctrl/monitor.c
> +++ b/fs/resctrl/monitor.c
> @@ -1077,6 +1077,8 @@ int resctrl_mon_resource_init(void)
>  		resctrl_file_fflags_init("available_mbm_cntrs",
>  					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
>  		resctrl_file_fflags_init("event_filter", RFTYPE_ASSIGN_CONFIG);
> +		resctrl_file_fflags_init("mbm_assign_on_mkdir", RFTYPE_MON_INFO |
> +					 RFTYPE_RES_CACHE);
>  	}
>  
>  	return 0;
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index c3d6540c3280..bf04235d2603 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c

Please move resctrl_mbm_assign_on_mkdir_show() and resctrl_mbm_assign_on_mkdir_write() to monitor.c

Reinette

