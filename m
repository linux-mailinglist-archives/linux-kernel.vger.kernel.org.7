Return-Path: <linux-kernel+bounces-797602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F0BB41260
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2B31B2836E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290731DE4CE;
	Wed,  3 Sep 2025 02:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E/Z0501k"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E395D12CD8B;
	Wed,  3 Sep 2025 02:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756866799; cv=fail; b=kkkXMZLN4jknt45gvWgMnx3LrnJRCc9xurQQDkUCKQIl2m2MmVTOKMxV1YYy3dLjxe3uJSFlBtht/yMrB0ykwALL2ZwlTeLpdKs/6WafNQPFYnUXlPZ3orzYolQN36f5VDjY0DDVnehHLtEhPNg1QKej1uJOhG1Id7zfGsCJodU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756866799; c=relaxed/simple;
	bh=6BTtrQ4tkp1KtMXzuVN1U870DM+i25E1CCaAHwTgCcU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mOV0JGu4m4rWoa3Fyi2HCh/Ofn4fbPw1dNsVoABnCwXRdEIFdZjSfh3eZjO9IkEc8n2wVL3V6q5bgB89+qviYH+SoalE1gpImYai3KZ8+BI0Balood+FXJuk6SMeyYv/oNwASh6xdz/g+/JLODWgqBi9+Y8tkEJnmdkVZpiUUOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E/Z0501k; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756866798; x=1788402798;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6BTtrQ4tkp1KtMXzuVN1U870DM+i25E1CCaAHwTgCcU=;
  b=E/Z0501k/sTZgtTy+0irht2PRkbDjViPdTbt8KHPWp4X2b3ibwyD4zkj
   mUNQcuWMp3QcI/bOe+J0JgwV18IWkjilrknlMlstXb4Dr95ab/RNmsE1s
   MeX8SHuU2BKp0MYU4dtcJn0IMK49zRbUdIy5YjOkAnAI8GnMMTYtTYPvx
   cAaBhzpZDqbCpdGSmO2Qv0DjDkV57RfPM1Se1IU4gtS7ZHyik1h4zseaA
   1/m5PVubEPMSjnyaXGLN/dlcCtwwHyhh/XLkMAB/iSjdr+gg+nfdQ2QBs
   Z6uNGuFbpyzbgmcJ7ClSXzDytP2IAUcghwvgDt8ik3k72WS83OT6rmtv0
   g==;
X-CSE-ConnectionGUID: s4XtxEr6RMmMaOjmZMsq+A==
X-CSE-MsgGUID: am4HmRyhTPiPzaFWxQNv8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59238239"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59238239"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:33:17 -0700
X-CSE-ConnectionGUID: 0LVGv5WcS2OVjevT5XZoNQ==
X-CSE-MsgGUID: GSJqFkvlQgCuveyZnBJACQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="208669428"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:33:16 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:33:14 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 19:33:14 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.85) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:33:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YuG4rg5n7wDdKu4tbu4hb4mPv+bhEwYSW7xE+AskpJKlZWnx7fj0coiN/EPdXqD9KtvLUOspSUGSQz06FuvPol5jdtpdKOhaoH7iO5KyiP0E4VSEXYGShUlc7YGKq25dX3v9E6QAciw9Oq959lC8wXvqZXPVgu/obM2DoBc4voOQAXIgCGDurM91htdLctse/nRVi9fxG0RBUAXYL1zF/lzdzDjh7VHfvtQ5PLRwkG38h20xBBuF19JeRpIb48DCC1nZvpNytDGYlRU/F4XWKojCEpFH3Pey5owaJZc35rNjVvxse/nlNBzBTIBqEDD85t/dUbY88nlsyPC5I7rFRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qh3AC4dF2FI6j6kOV2hpMzlTQsBlkaSBvav5viChfbo=;
 b=cpE6d2n4BotAO8FGOmt9zkaC42hNYK1waIaNk1uJ3ngn9tSuLQ6PvyuIzzZlawaTdVQfTq5/1xdC8pZ4wehm+YwBewdAYE06Fm85NyuH7Z9HStEdyc33Vo0oCIfm94lslxjU/0+2pS/abZrWhDXX/qDi5eLrqiVoLMOtxdQao9qTda39BjhgjFhf4jw5GHQJ1lZEjEFX4siIBXJNkbtkNjANvxdOw6HFG4CjNDkpLJDwuc90CQ29ur9+IsqG2uUJxUCigIoWaqLKK/zQVoC6l8JoM2nqEhCj8p0WjTY+Zn8L6HvNeJoCAwlZ0PLpYjZMBXuivRl1jYLrpB04Ka3ijw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8076.namprd11.prod.outlook.com (2603:10b6:806:2f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 02:33:05 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 02:33:05 +0000
Message-ID: <e3f49b51-b03c-4e6f-92b0-fbf7668c754d@intel.com>
Date: Tue, 2 Sep 2025 19:33:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 18/33] fs/resctrl: Add the functionality to unassign
 MBM events
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <james.morse@arm.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <akpm@linux-foundation.org>, <rostedt@goodmis.org>,
	<paulmck@kernel.org>, <pawan.kumar.gupta@linux.intel.com>, <kees@kernel.org>,
	<arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <yosry.ahmed@linux.dev>, <xin@zytor.com>,
	<sohil.mehta@intel.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterz@infradead.org>, <mario.limonciello@amd.com>, <xin3.li@intel.com>,
	<perry.yuan@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>, <gautham.shenoy@amd.com>
References: <cover.1755224735.git.babu.moger@amd.com>
 <4070eeb0525dc990fe56058714b107462c740b76.1755224735.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <4070eeb0525dc990fe56058714b107462c740b76.1755224735.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0117.namprd04.prod.outlook.com
 (2603:10b6:303:83::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 9868b85e-3294-4157-2a2b-08ddea923675
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkV5WmxuR2E5WFpLU0ZNUWUrazZTdHpKcHNFRWkwVlFJdlQ3UTcybGJzKzg0?=
 =?utf-8?B?cGdZY0N4WnlUekVDQmptZnVWaFRJbW5XVDE1UDFPbFZ1ZEtWd0tJeWdTUFpi?=
 =?utf-8?B?TUxkWlZBUEZLeVVRbUZvSWlneTRLSHprNml2ZzZtdnhLQ1JtOUFTNXEzbzM1?=
 =?utf-8?B?NHE3VzBUUlNvU2dXNUg1UFVEV3A1S2pnVXJwck9TT3M4MzRaaXVTVVkwZ0hw?=
 =?utf-8?B?cVVmL3NqcE1wc3Z0cXc0bXFMc2ZlY2NjUTVYdG9sbG9XVitqQ2x6ME5YTUlm?=
 =?utf-8?B?NE10bUdSTTEyaEtpazNIbVg5N0JHTjhuRjJlb0ZrZnl4RWZ4OUIzQlczZVha?=
 =?utf-8?B?MmU2UU5jUzdwam9nWWo3d0FNOUxlSE4vcGpCUEwrR243WjJTRjFFSk84YUNV?=
 =?utf-8?B?OXlGbk1pRmMwMUMzQ2l2YXdtK0Q1YzZOcEw5bFpTV3VYOVVaY0JDQm1aRWhB?=
 =?utf-8?B?RFFFRGFzSmJkMmxPZWU5T01GZ05OWGdTcThnblo0Rm56UzZpcHdneW9PSS96?=
 =?utf-8?B?NGg2bHYvT2tvL0pWMXZvUE1BTlNrOGw3YXRMWFdkbGRmRDJ4a3FWVmFXMmFL?=
 =?utf-8?B?SlVVend3ZktTQ0FaSW9mMXYxRk5ZUVVEclBiandVR3NlZjdBNmNXYkFGQnNS?=
 =?utf-8?B?cmg1NURETkhmcWNLWFUxc0c4UWpXS2lqQ2hEbGE0Q1NqQXFpeS9Ya0wxd1NZ?=
 =?utf-8?B?UEpHRldvMDBuOVg0OG9wMGpmVmxKdFF4WjZuVmF4Yk11anZHVjMzT1VTeVRI?=
 =?utf-8?B?SmE3UTJiRDkrWUFnSUlZSHdSS1o5bW5NNnU5SytFeFg1SjhXb0ZOMS9MVTAw?=
 =?utf-8?B?VXhreUFNdUgxOGRET2pBN3dkcG1XcElmQ2tUTnlRandnV1JEWm1PTEFoVWZv?=
 =?utf-8?B?STV4cjRSLzB1MHpsTGVJSFFlYTZuaHBQRVJyYTRLY09pM3ZLUnVxZ0UrRjlt?=
 =?utf-8?B?bXJWMzk3azJoZjRkSkkxS1ovYUU3UU0xNkd6ME4vRER6cUdpZ2xYTWdLbjA4?=
 =?utf-8?B?R0ZKdW14cERaL0tJQXNTczNncnZLM1ErMFFNQ3hISDBPRWFhOW1YbkxnOWVy?=
 =?utf-8?B?clZma09pa3dYV0I5bDVJVmRvMVRPMHlRZnpHQkhsM2FlRjNBZFZ0VU1IQ2hX?=
 =?utf-8?B?bFRnNTlPZ3ZxVnNMSVZYaUhkeWJJUmRFOFBkV3l3VFJvbHRKdWZTQUF3YldU?=
 =?utf-8?B?cEcrRmxQemdTcFFoUUJaeUhZZ1k5RDB6SGRkcXUrWnBWVmdUZkRaZmxSbFlm?=
 =?utf-8?B?Wm1vOU1QM0lUU2xsQ3QxZ296UjBXVXBwc1F2VVFReEEwSURvN2FxcWJIRTYw?=
 =?utf-8?B?L2Y4OG4xOUVER3poeFVsbWtlYlhiL2IrbXZkbXZ4SWtTY3FNRFBXZEg3L0w0?=
 =?utf-8?B?ejd5dHZwNmRHS3BsdDJWNnE1WXBHNy9DaUJSUjZ2ZzcyZmFvYThJd3F3bWpJ?=
 =?utf-8?B?TlN3ekJ3RGlHLzJIYlJnMlJ3QWlrOGx4NXVvWGVnRkxwazhodDgrenoxSlNi?=
 =?utf-8?B?R05MOEgrOWkyclBHQXBaNzNVdE5QZjZmT0pSOUhwTmF1bkZRYi9pRFEvWUp1?=
 =?utf-8?B?YWcyb2ZwUENqR0FmR1B6dHlaRmNhcEZ4amtoQmFnM2RSS2FIWEJaQUIxbGpH?=
 =?utf-8?B?UTdSalQ1dFN4YmVPUG9JSDM0bEdieHBpVG5XSzFURmM4ZXNmbWVlVlo2a3pT?=
 =?utf-8?B?ZWUyblFEWVBISUNCbjRRVWFSWTBNM0xrcHA0MlZVUjAvN2IwcElUTGdGOGRX?=
 =?utf-8?B?Tnkyb0puQmkxbzRRdCs1OS9laXVsZHJ0NUVrWmFoWHFwYjlKbEo0ZU5QcnhX?=
 =?utf-8?B?WkgwSnlVWi9oODE4KytEUkIxdlR4RU5tNGg0YW8xbUdYK0ZkVDNVZU1ZVFBl?=
 =?utf-8?B?cWNSV2dIM2xKeU5VSzdValp3TDNoc1JYZm1mQmVVNEN3QlJpV29YN3FvRC85?=
 =?utf-8?Q?89MTG9cQUhQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWpTNzY5RHc5REN5N0JxSk1yd2lpK0M3Ujcyd3p5TGkweUtGQ1lETHJnaFgr?=
 =?utf-8?B?dUZTdHVhcDhzRVY0TldnNnFrbW14VzgrTlpDbUw0bWhkVGw5TzQyTjloVXVF?=
 =?utf-8?B?VXFPKzdDOGxXd09wOXRHQmI5ekVocnpyMldLcVMwODc5ZlBjZ01PWHJxNTNR?=
 =?utf-8?B?T1hhVW1BKzlUU2tpVXpFZWJ6NnhIQnBpb2ZqRTFxS1hKU0NQRGtBN2xlUzZy?=
 =?utf-8?B?WUk3OE80SlJQNEVrQmIwMURhZkMyUWFLdTh0OTU2eWI4ZXhmL1ZiUTNkT1Ji?=
 =?utf-8?B?akFibWtCbExYRmRvdWFzYXNvY2t4RGI0K3FNSkxsZHVUYkJrU09DOTUrU0cv?=
 =?utf-8?B?VTMwQkxIUzdyOGpqdzUwanVuektGY0NqQTN4d3lnemRCMDJRd1hYQmZwMmI4?=
 =?utf-8?B?WVlUdmxmL3pwUWdVVmNoYVZxdnk3c0VvbTJtTG5wTk5iY2VlL1AyV2hVVmlU?=
 =?utf-8?B?b0pydFFCK0FUd3hIUUxjN0tGalNHT2I1SWdnUitWK2dFemVhYzhDV2t5WEd2?=
 =?utf-8?B?UTNLS3pDcmpyYlpGeUYwS01jUHFOZWhPeFNSRng4S2o5bjFOd090UHdQdTNp?=
 =?utf-8?B?dVdlOWo3Z1hWb2k4SlNzbWlsRFhCSGdaYjRiSWIyYVZWZ2NwQU1KaHp1c0Nz?=
 =?utf-8?B?ZnZNTlV5ZEVkTEkvRG1ueStneWVnOWJzc2lHaE94dHc0YVFtQzRjL0d0VmZY?=
 =?utf-8?B?U0h5ZkVIVE1Yb00rbGRnYXJJMnp0L2RHcTBITFVHbXJtTnhPdTlJdWE3dHoz?=
 =?utf-8?B?NjJLZkkxeGtienJaNG4wOVhuN25QN2Jmb2VFT01oMUZmRjlaSmorcEd5YTRq?=
 =?utf-8?B?RWk4eXpkNlAySEkyL29KZ0NsV2kwYVBVRlordlc1VzhVL2J1bEkvbVhPZjkx?=
 =?utf-8?B?RHJnajNFRkFrNG1rb3RPdVdwOTdoVzlLb3p4YmlvLzFMME16emorUHg0R0Vh?=
 =?utf-8?B?eUxCbUFHVFBHNjFhRjJ6aHFKSE9JWStaRXk2WnN1ZWxmQUROTlF0UGI2ZnZ0?=
 =?utf-8?B?T2s1ODFUbyttZE9odXEreDFDTWhlWlV4ai93WGttRTh0U3dEWHRYUW1tUlZm?=
 =?utf-8?B?ajRxR3pSS3lRQmc5Z2xhaWgwSFYwOUZrRDZMMGNEcG12em5ZdmUzUzE3NWZa?=
 =?utf-8?B?d252VFhPYm91cjR1Y292QTlIbUMzUWwyOU9pR29JUkc1djl0eFZJa3FCYStO?=
 =?utf-8?B?bmZFR1lJcWtOMzFnS0d1bG1SZWJZUWxySVZLRlNZNlJkYm90TjZWbFpaTWgx?=
 =?utf-8?B?ZVY3SDNMQ0hDREtISzhreFFZeVcrU3oxeWdpeHQ1Z2QrMm11anhsN3o0VXNJ?=
 =?utf-8?B?eTM4MWh6SGhNSTZ1SVRLRFViUldsT0EwSnh5UnllSXVNNmFkUlJRcENhc282?=
 =?utf-8?B?RXp3bGRobmR4cWdZMDR0cnlPSG9zRzJzS3ZVNWF3UEprOCtIdjFRZzNKQ1BX?=
 =?utf-8?B?dEhvZHMwRGN1N1hHZi9iVjBHS1psL0NUdUpNMWtRc0tHNlRCWWRueEl2dUhp?=
 =?utf-8?B?NkZCMWp6UkRicmxIN3Q0UGNhWUpFdGdpMGJmY1lCb1psWUVQREJqSWtYekhO?=
 =?utf-8?B?NlpvTWJnc3VPeVgwbDRVV0VyOGl0VHVTSk9lVzRRbHMyQnNJK2JQVUpGaHZI?=
 =?utf-8?B?bVFJc1JORnpzYUpndEhlck1xMm4zSDB3QkJjbmM3OVMrVlQwbU90QjBMNEZv?=
 =?utf-8?B?RkpSeGJuVnp0cXpsb2FzMXErTXpodXlOZ2IrTVNGdE9VWHQ1dUpWTXA0Z3Uz?=
 =?utf-8?B?b0dxSkEzWnAyQy9rOVNKRUMzaE9QcWRTMzdEL3g4MTlNVVYzVVJHUUtJQlk5?=
 =?utf-8?B?VEJCOFdqOUdMYjNPTDZEYXlndUtCMy85QnRTMVpIakFKeHF0VXBIYUI1Q1ZX?=
 =?utf-8?B?ZUp4MkJBUVAvRTVRVnhnQzR1RDN5OWtzZzlXMWdxRzQwSHpuMzMzenY5L2NK?=
 =?utf-8?B?Z2V0Rk1wWVhyb1hYY3Z5MHhBRTVxZzI4TjRPQjdVLzRrQS9IRStQMkZ0dGcy?=
 =?utf-8?B?emRwOXRscTNMeG9FMTlqajVWdlFyTzB4alZQWDkxWmZ6NDRYUFFyQmNsUldN?=
 =?utf-8?B?cUdTMHFXbjVaRTZnQis1ZkljSG9PbjVDNVUzUG9xNEE1L2x6dEFzQldTdFlV?=
 =?utf-8?B?UHVBUlVQS1dGa0Q2c3hOY0ZhOG56NXhiNTlNSDNJWWhxL2RBK0Y2VkZFVXpD?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9868b85e-3294-4157-2a2b-08ddea923675
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 02:33:05.7705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKyGIyxuF7CCyr8unyNWd7t1WC0kQ5Lql95VxGORb4KpPraR3cEqFKgR5bKmFx0uXI4E3yqNifE6KlXcrTaTUPk3IUOO/p4ksisW4vP6ySM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8076
X-OriginatorOrg: intel.com

Hi Babu,

On 8/14/25 7:25 PM, Babu Moger wrote:
> The "mbm_event" counter assignment mode offers "num_mbm_cntrs" number of
> counters that can be assigned to RMID, event pairs and monitor bandwidth
> usage as long as it is assigned. If all the counters are in use, the kernel
> logs the error message "Failed to allocate counter for <event> in domain
> <id>" in /sys/fs/resctrl/info/last_cmd_status when a new assignment is
> requested.
> 
> To make space for a new assignment, users must unassign an already
> assigned counter and retry the assignment again.
> 
> Add the functionality to unassign and free the counters in the domain.
> Also, add the helper rdtgroup_unassign_cntrs() to unassign counters in the
> group.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

