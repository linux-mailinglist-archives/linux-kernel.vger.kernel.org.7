Return-Path: <linux-kernel+bounces-739986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309C2B0CE3D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51AF43B5EE7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C095242D66;
	Mon, 21 Jul 2025 23:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nFzgp15y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A26D1DFE1;
	Mon, 21 Jul 2025 23:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140788; cv=fail; b=AszV/XBOWishBBBQEo9BlW17Wlej3dyr8T8viSKa/adfehSW5Pbol915BsU46QykmsHNxbm137LMVUv9LlJY7ozNtA7mw304YZw/+Y7IjLRjB0woAtYHI+01dvtxZkBf3z8jKxlMZaxHAPlr/CRMKK90Wzp0yIhPZcvRDEPJ3sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140788; c=relaxed/simple;
	bh=LTm4GrY1K1Eq17dGAz+DRJ92xYdmHQd2ImEsn5a6PZQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dsUm0Zq3MQPDP0uM+PRl/4V9Z4uxQBKUaaDTrdLTbeH3yIGeF7YHmj38pNv2gVfWqlf+4EU79num0gDf9amWy36fnY611725WtxC7OUBWwwumn3bv7wBkM8kH0YmD735Gu6wJ2QsgDNxPSGBRFUIe7+05S6prGqFmprY6U3TK70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nFzgp15y; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753140788; x=1784676788;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LTm4GrY1K1Eq17dGAz+DRJ92xYdmHQd2ImEsn5a6PZQ=;
  b=nFzgp15yP1hJ5i0MD7p0CwPKlpSQOhLxmT2XWb+Me8vQmrXtSLKC2QOj
   Ie928IlrHJELYrXGnZfA2HlMuy/aNYLg6PPhrb5pJyKwQcbtWnZeghJFZ
   MXXXGlGCjyOKdUMdcz+gwXwZmM3pvPPnuGoYnKmfHPmF4Bn8lojQUcTrH
   voUkppgectd+R7XKdjs5Nt3LKyrdTwm9N5APc93GUyfxLKbkIWlE0L/hK
   3veZJckyyQ5sZhd8dfTNPS6xfaIHJ9sQu2zg0qMaQKM2ORZo0C5GqSoMb
   cNvkcwS93H6eiMAi2U5bEvW7GI8nwzxxBGidJMeLwxt3tyjDuCYzKPDxR
   g==;
X-CSE-ConnectionGUID: EVh833TgRuaaOqGzYNNDug==
X-CSE-MsgGUID: g7WpJalpSkC0OhUAVeFfrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="59033662"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="59033662"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:33:07 -0700
X-CSE-ConnectionGUID: +DRBrapwQhy5WhZaSWwpVw==
X-CSE-MsgGUID: JheA/binSPWJKR36E/L6hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="164636878"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:33:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 16:33:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 16:33:05 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.53)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 16:33:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJPAZKL6p+jsxLIOcApRsru0cpa8kavdAdJrw6zZCpzdQttS0XyaCNKaPzQ3icJ9z8bq4TJN08Vq6iSnNdJx7gwAaVLfGjQKj4BOb6v/547PvjvQIpPre+q1LyDMrPTFC5VY64YRHf27MmmTffsfjVu12kacgtA64SjDJfX+IfzoSvBbKdt5yj5/pbp2oeYJn5MmVBVxrNaU+nyIY5q7lIthXGRbTF7BjGyE+G7/2A2SNUn4d21Yq/HfxClTBn/MmrPo/oE22/8QNG7/cAeR4qIl97fOc14lawtEjZHW86rfH7X/WOI/RHuqJfmvSUJSYFmQyin6GOZ0u4UTwO8vWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9meuSm2TsTXnO1J2nPzeDLtriaakc6oFWvOJfxztuWY=;
 b=wtNi/vKVwz0zp4EQ+Fx/zQghEwgp6mCX28GQAponVBGu3LqRAlval/G85/GpXL+2s0Ftz0rNTJB9PoIPUfJY/VM+xHRYjE/XWS5goiwKw/oGEeV8s21fiHgLfVcZyUz7fz1E3FnCIErcbRN8p+6Q4/yBAJvyEY4XLerEFqu4eDkshUTctwm0kUSi5AgrMVF5yxWx/qiApcpeNGEr2jkr4RIJ3AsyvfnObHtEzgeKVucRFXAw8cZRPuWBxxt9Yj6krLjw2uJHHEgAPJ1AAZhlAYYYePpuJTY5GJZq9ujZwYJHBp8Hxj3prKKjxmVD5DNLzLLvNlIBxQUk/2HuUYlSLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY5PR11MB6414.namprd11.prod.outlook.com (2603:10b6:930:36::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 23:32:23 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 23:32:23 +0000
Message-ID: <09d7e417-0482-4172-b110-417c12558481@intel.com>
Date: Mon, 21 Jul 2025 16:32:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/10] x86,fs/resctrl: Implement "io_alloc"
 enable/disable handlers
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
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <cover.1752167718.git.babu.moger@amd.com>
 <b7c61425e9da008add366958a26f7d8e75eef4a4.1752167718.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <b7c61425e9da008add366958a26f7d8e75eef4a4.1752167718.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0175.namprd03.prod.outlook.com
 (2603:10b6:303:8d::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY5PR11MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ac7622-9466-4fcc-252a-08ddc8aed80c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnNFNTk4TW9QOVhibWZIUXJPN0JMemZUWFljeWlxdmZBT2ZaM3A0T1FXZ1lU?=
 =?utf-8?B?UlFhS1ZRVGxQN2FaNTBiVFpJNTYvRWxxM3NTNUg1bis0bkRqb0MrL0NGbDlx?=
 =?utf-8?B?WUJLY2p4cTBlVzRxSGV1OG5ZTjBMeVEvTmRBM2FaVkdySFl1Q3hIcm44NkpZ?=
 =?utf-8?B?UklZd3dUcjYwYjI2SzZDMlE3SFpnM1I3eDNYUEJGa3lsOVdnOVVaYXhybmpL?=
 =?utf-8?B?MG9wVkNmdlB5T2Vyc3JCVjBSanB0Z0E0Z0YyU1BIR2RvNUcva2tjMFZhYkRI?=
 =?utf-8?B?dmJQeVB6VXRucWZkWjhTaU1xMXhXWE0yRmR4QWRHOHpJVHJsOTd0a3RPaHl0?=
 =?utf-8?B?V1gyN3hyc1I2YjNaZFY4RjV5UkpnY2VkcWF5amJVbHdLYk93YWFlaEFpQmZC?=
 =?utf-8?B?R0g2YWpHa2U1ckJaR3JiZ3JLOXY4VDBuc2VPTFJqRHRhUWZ6YTdGSzFIZCt5?=
 =?utf-8?B?SDFPM2IvazNUd0dHQ0l3a0JTZEljSEpyMlZuS0NVbEUxZWdxeEdNZnJOUzhL?=
 =?utf-8?B?WDRsMTNacW1oNStGM1l2V3l3bzRVazRPVUN1YTBaYzk4Q2t6Vnl4Q3RKeDhN?=
 =?utf-8?B?dWNXdy9Pc3B1MEh2VHVTUTYwaUQ0aXBNUHEwN0o1ZDNYZWR2QlljbjFqbVkw?=
 =?utf-8?B?dUF5V21TdmdkV2FOTmdiREdsUDFSS3pzSXhnMUN5RHc2eWNBbG5mU2dqSHhi?=
 =?utf-8?B?SEN2K2trVTRMV3FYdXhQaWZ6YVV4Q1VQYXlJVkVnRzRCTW9DTjIydFNtOFRW?=
 =?utf-8?B?LzVndHNhNkp0UE9MeUJZTFFkTjNWWXA3TTJUWVBmZGhJWUZkcGdmUmpJcVJk?=
 =?utf-8?B?QVJvM2JIeHYydDlkQUY5K0FKa09VMlM4a2NjR0VSODRRNzYzSC9qbVYyMy8v?=
 =?utf-8?B?dFh0clpQenhScCtpZVB4NVNCaEJRUnArVnRyb0REQmtQRnFTMzNPeERLclND?=
 =?utf-8?B?N01CaEpKQUdRY29KY0J0NEcxdGVYYmNVaEJXVmVlaXU5dWYwZkZkOW5NUXZr?=
 =?utf-8?B?SUZjTGpRV0NFTGtGTXptRFpJNzFJNGtxbFd5eWZEMVYwYkVaeE41eWYrUWZE?=
 =?utf-8?B?VEhsbVEySGhoUnphNEh0bG50enN5eForajVHQldHa2dsVTVNNU9zczZTa1A2?=
 =?utf-8?B?ZWsrRXdUb21ZcFFZN3kxV01rMS9vcVN1cjFXbGJlcGZFemQxYmF0clYvd3M1?=
 =?utf-8?B?QU5rblRqOEE0MGxzbUxuaWc3U01IcDJqWDNpcnREdFBxcGVDTXM5bGxHZjVp?=
 =?utf-8?B?Y2pCU1ZtbHdRTDVTR1owRko0Qk5sQk5OZ081TW1JZkFGbDJPN1daOGFCazZR?=
 =?utf-8?B?UTJHQWhjQzRXQThJc20wNXdORFFBZ0FKazNCaDQrMW1oWTAvUE52L3h6dGlW?=
 =?utf-8?B?MGNyNkJMQmFCYnlxUkIva3FOWFh4SjNJc25wVXpweUs2am4veHlaUWV5dHp0?=
 =?utf-8?B?emxnQ2UvUzN3a1AzMFNaNVNMK0tvNHFrZExOVGFOTEJUQ0UzNjhRYzZlQldU?=
 =?utf-8?B?dzF0c0RPT3VKaXB0T2FkdXRHazlkTi9hZExFMDRFNGxCVTdTVDJzSWExT0J4?=
 =?utf-8?B?bGEvdjAvQStjM1RDbnRtVEV3L2JiSDNWRjB4b202aWNRaGFvb05BZkZGTk9W?=
 =?utf-8?B?eGh2V0hKRUM1VjNXcWM2OUMxTDNnd3J2RHo5WldWQkNCQ3NQTWJsRlowTzlN?=
 =?utf-8?B?NlZXdU12ckUyQjlNWDg0Z2hoRGxXeXNXYloyM20vTmpnNU1QZ1k0QUpyMmY0?=
 =?utf-8?B?M2o5MWxnWEF5Mm9NMkhEUWF0Nzc4bEwweStxUm1md2JQbWI3aFN5akdNK1lq?=
 =?utf-8?B?UFYzNHkwbElCK3BCV094T01TMFdQT2R5cGw4L0NXa1JwNWJhMC9oVkwzYkEy?=
 =?utf-8?B?Y0NvYzJ4SDYvQUpadTBRRndKZ2xqdG56L3BDKzJNN2RPYVhLUCtBL2FyNlV6?=
 =?utf-8?Q?pYhOMUVaS7I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGNOMzNUMkR5WUZUVE9jdy9kSXoyM2V4STNDNk1Ud2xBSnNvdjdTTUMrbHRB?=
 =?utf-8?B?UkR6NUk5YW83Q3JSQTl1Q0w0K0xPblN1bVBXeHRHS3J3Kzh0M0NaelNqdC9B?=
 =?utf-8?B?YXpDeVlyeTNhUldpZkkwN3Rnc0gvL3V1U1NVUXR0dWFQREg1N0RHd1Z5WkRG?=
 =?utf-8?B?eVlTTmZHbmZkVEZMZzVwY3N1d01vOFk5UUZuQTNzSHliOXM1Mk9EVHJkaGVD?=
 =?utf-8?B?M1NhT3BPV3RXb0d4MHppejNvMDU4REJpVHBPVUMxR0xlR3MxemJROUNFdkxr?=
 =?utf-8?B?NDBzZG10Z0pOY21aS1ltYndET3owS2syK2phQ2RScEF1MkFCNGhKNUFwS0VD?=
 =?utf-8?B?Y0ZUQ2p4ZzlKeGtxeFAvbVJlMVExQjFWTk5SN0I1UFRzR1FaTEdQNTRQMkdV?=
 =?utf-8?B?RGV1MmM0Z1lqMEF0Q2VsZFFVMGhyaURYU1JUUHZIR0hBOVpyNEpvdFBOczNo?=
 =?utf-8?B?NVBGSlU4Vjl2b0JGT3NPR0RUSmIvQjRQbERoRm1QeFJIY2FRNnJqQ3lobTJD?=
 =?utf-8?B?aUJyZ24wMjRkQ1VsemhMZlZBb3JHZitFK2NDOFNCdUhYcHI2ejRTelZXamtO?=
 =?utf-8?B?VlZhdVdwc0lOWm11dE9uUXlOSVVyOW8zYlRIK3dkV0twOFJjSGptaDJxOEpx?=
 =?utf-8?B?U2NleFpLSzF6Sml1Z1JuS0NUcHRyeHlPRHFHYmE5NjJuSFI5VWVDQzhuaGxK?=
 =?utf-8?B?M3Q3UE1wUW1mbGthc2xDck84TmVlZ0hCcXVqSUxOYXVBYk1OcnlXRm1VUDMz?=
 =?utf-8?B?MEcxMkJEWm1KQWZ1cTZrTW5mU2xlWmVuL0sxZnJTeTNSNmcya28rSXBycWR5?=
 =?utf-8?B?OWx0SzlwRjZuckJxbHloK3JTNjFNRWtqd1FmZWxqVXA3U3lmMU1VdUxGOU9u?=
 =?utf-8?B?c0pvbG5HRHhCeWJxYlB6aGxqYUFjR3czSEVNOGloLytBMmgvNG5KVWg0VWZ6?=
 =?utf-8?B?SEFvQjdRVjBsbk53eGJuM2xDRjNnaTNOVGNmSGplQXhnUW9oQnZJTVJhbkcy?=
 =?utf-8?B?R2FIVlQyOXNJZTlBUEpxVWY3L3VGZHduaG1ZbUgyL0NRT2MrTExvd25GZVln?=
 =?utf-8?B?ZFQreHlpRk1uRkExM0FmYnVudjdIU1pKaWhZdHY1a1liWnJUM0x3aURLQkFJ?=
 =?utf-8?B?ZlI2ZlJRbUp3NWEyTllUWUs3YmxFUDVuVkpjMGJlbUdWRTRXR0ljYUhLclhW?=
 =?utf-8?B?V00rYWo5Mnl2ck55aWY1YUlobUdmTktDUHMzTjFlckZYK2lsMTFrczhjSzNu?=
 =?utf-8?B?MCtvc252OVhtNUE1WEI2YURpTXBNOEkxQUxRYXhzbnJCU3ROWXNhK2VUUG54?=
 =?utf-8?B?UjlwdmM3dkRKZlZFWDl6MEV5TDJwQ0l0dGwwaU5RY2Vta3pqZks4MUtJVWl4?=
 =?utf-8?B?VjAvV2RjbitxbFBBaEhKQ1dtU3JHRGZSVjQxcmdhZXVOMEx6OHE4c3ptUzMw?=
 =?utf-8?B?ckZBbWxMd3hoSXJ5OWdoTVBTNm9DeUF2MEJFNEV5bzNweER0WW1DOVJZTjdC?=
 =?utf-8?B?YWVEeG9KRUYvQVB3UXlqT0F2L0FaNlJIS29nVFBhUWFPZHJrS2hhVm5vblVN?=
 =?utf-8?B?alU5R3FlT1ZEdCtKblJkY1pXK1FjQXljUlFMb1BIVUZheHQvVG84NXRKeHl0?=
 =?utf-8?B?ZWpER0RaWXVJSFVSSEpwZ2lkU1ZLNXR6QXlTM1dvNkhJV0tvd3ZjaFJmeFdh?=
 =?utf-8?B?THlyUEZ1ZXZjTmsxUmQxR0UxQSsvaDQvWUR5L2QweWlYanU4aWhnd2pmazBM?=
 =?utf-8?B?SDBaeWsrSDl2OHIyQmJtSk11bkxSNmZic3NGdWN3RjIxWUVJenpxYy9wMUxQ?=
 =?utf-8?B?empmakoySHZtZWF1TkpROFZkT0V4ckcvM2FqRTJXZitGeXR1OW9XcENiSDBJ?=
 =?utf-8?B?bEp0ZE9teHU4eXlHM29OYzBMbkVvRUxZTUlmZk9LVEY5Zk81SEpOcWRORlh1?=
 =?utf-8?B?VFNBeHBaU2s4TmVTSHhIbFpGZXlyVitCRkhnNWlpREhxTjY2NUVGYjZYSWdX?=
 =?utf-8?B?Mm1vWEpmakhIS1hWc1ozdm9yS2JtRjJnUitNZ1hvZ3pVTkp4Q1IrYy9pRExz?=
 =?utf-8?B?QmpBanUvMlhnZ01SVDZZK0Q5OXR0MFNoTUdVTVRUenRDT3BoWWpWNFZtSkxM?=
 =?utf-8?B?KzQ1UmpFdWZJcHZrLzQ3L1AyLzFzZG5mZjNPQzhMUU1yZmdCaWFFQ2hYRlBm?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ac7622-9466-4fcc-252a-08ddc8aed80c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 23:32:23.2076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9cSnOnwWMZhiG1WWvX+f71c7dLLFnn2iy0uJ7uwMdaicKhA/8DMbKSicrJVpK3Eyv6OC0HsqklJXI7o3HBLZdiHvUD0Q6JJshiRdIrtm3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6414
X-OriginatorOrg: intel.com

Hi Babu,

On 7/10/25 10:16 AM, Babu Moger wrote:
> "io_alloc" enables direct insertion of data from I/O devices into the
> cache.
> 
> On AMD systems, "io_alloc" feature is backed by L3 Smart Data Cache
> Injection Allocation Enforcement (SDCIAE). Change SDCIAE state by setting
> (to enable) or clearing (to disable) bit 1 of MSR L3_QOS_EXT_CFG on all
> logical processors within the cache domain.
> 
> Introduce architecture-specific call to enable and disable the feature.
> 
> The SDCIAE feature details are available in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.4.7 L3 Smart Data Cache
> Injection Allocation Enforcement (SDCIAE)
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

>  
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 885026468440..c165ac333336 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c

The code looks good to me but rdtgroup.c is becoming bloated by being the default place for
any resctrl changes. While I do know there are counter examples (and I admit I do
not have a clear understanding of original intent) ctrlmondata.c is documented and supported
by its content as the place for cache allocation code. Could you please move these changes
to arch/x86/kernel/cpu/resctrl/ctrlmondata.c? I will try to highlight the other places where
I believe the either fs/resctrl/ctrlmondata.c or arch/x86/kernel/cpu/resctrl/ctrlmondata.c is
more appropriate but please as a high level consider where appropriate to move the IO alloc
code to be with the rest of the cache allocation code. Looking at the series it will help keep
a couple of existing static functions static and keep data structures local to cache allocation
code.

Reinette

