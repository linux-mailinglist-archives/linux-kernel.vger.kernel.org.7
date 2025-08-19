Return-Path: <linux-kernel+bounces-776152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C388BB2C947
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093D93A2A37
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D860D2C032C;
	Tue, 19 Aug 2025 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GOkAN73o"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FFF284B3F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755620015; cv=fail; b=u1hHdkJ7G3HZcmxbN5klwtbk/y31kzezRwgktMG6EjcbgjIqwqL/jBRhYMKgZ0eJiORPo7N6tj997n4G73Bn3Li0Xvah5OqXkwbWncftzo3YPUtWBtiZNRqD6K+eUfqiE8Wi76W0NzbzridIM+Avt7L47vUD9BRHevTR8wjPCE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755620015; c=relaxed/simple;
	bh=LFHuHSzDjsk6LGkGSnUO32qFIve8g3lvxxqAA6mTiR8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Szh7IhJ6K+57jlpp1v5vfBf3+9lnJX3KptWmrvz0vqXy7IUZL9LM7z1PVNvsYiy9rNpAB4fyND+C/ECITENEw6fibE/sRr39uVnjYvWmgC9YNOY92QiAYEJXr+luhW/nXdxQeLL74vtVgEowyQ5TquPT96SZWx3+G7JYLzVpD2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GOkAN73o; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755620014; x=1787156014;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LFHuHSzDjsk6LGkGSnUO32qFIve8g3lvxxqAA6mTiR8=;
  b=GOkAN73oBVmLQbsEinpfIkiWsKnMx1Csu0QruXIqzLL9WB5bfe0157un
   7rSUH+nmQD8AnEFTxjVkIHXSs3G/o/XU2F6bbaztAqcoT986BIYQcgDgt
   cHzpgQ8lusgtsGE7/6bt8hHZna0hebMr/wTZtTvsdlYlxuQZNzjYLNAIs
   ZpvL8oH5mZvZKA4LBfqp7DSxNbxcHPCWcKIl+q8KpQX5idcA16rs642/M
   bW9bTr/Icx9skWt6BCCk8ohmo1O3N3mN7iGXb4LBoWtCpTusKo7KC3FCe
   RyIU+iCPc04d4Huye+9Mr2AUQLKWYUgyyUsMSXXxBC/v1YyJdOC+1EUXe
   w==;
X-CSE-ConnectionGUID: /EhNznb5QpCcLYi0NFKQ5Q==
X-CSE-MsgGUID: FsRpy0uoR3K0y248YBOMoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="69322924"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="69322924"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 09:13:33 -0700
X-CSE-ConnectionGUID: 3/LedlA8SVOVscNOlm1Juw==
X-CSE-MsgGUID: 8blT9Ym+Q2S0OhUPHRIkfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167797611"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 09:13:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 09:13:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 19 Aug 2025 09:13:31 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.84) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 09:13:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqVV5hp/AAmnxdqHU1eJMVZjlFMCpetBmIicHk3gjNxC2kjCL5DdoU7l/uPrnUwFSTSmY0yCbN10S1jQbdOfk265N/G0X04LV9sO5eRyOQXowvu7yRjkxQ+6hKZIZeHxpoKsxRAkavhFjIZ9Yify+PvfOYjutLF5vzO6rJFlXkJfW9dv+D/kakijXlsb2GbX7y7q3t4z0Qer/L98UMZ6EuXORUs+Q0cJAy7f8X6MgUo+G4+nMflxgxU+zxATN03mpSDsFUoaZYxxr2QUF44ql1zUWEvwY5ZUsBJ+VIxgnv//+ufzCBHWWHDM92F9KfFt7jsaukx3txH+NYf5/5ABiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G24bhWjU+z+qb52BA6CQnfjFwgW0hFbY4uSE9hVDPsY=;
 b=QwW4FEUqn9TvVbARNy9nEb0QPoTgCCVeOojfPU5a40kcx3xwtcUUg1i9K6wy1rY3rKizRBJvL5qJtNQHt8O6SnXmpQNztWiPX0wjJElVqomZAIMr6qGiBi5BnY0nExL1TBO+VQdQ2YKG6iQAzaTrAtkRlT6v2e7sAeaCZwWgyLjZbhRG/XjOaMvewF3yOgmy/AQoy3l55yuYQT0ElPwTzm5hjg5Hi6lLq/cM1/zKKXlvklOulgeR+dGrS9x3QAE8c1KQaJ77vNxORDk8oz148g/QfEjZBME6aj3IvDIkGbhCF+c1i0MfX8KbCo0mgW/sSxoLU9bcR9cDdBYfFu9U9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by DS0PR11MB8687.namprd11.prod.outlook.com (2603:10b6:8:1be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 16:13:29 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%6]) with mapi id 15.20.9052.012; Tue, 19 Aug 2025
 16:13:29 +0000
Message-ID: <cbd74335-055d-46e5-9dc3-9197ff95cebf@intel.com>
Date: Tue, 19 Aug 2025 09:13:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/microcode/intel: Refresh the revisions that
 determine old_microcode
Content-Language: en-US
To: Andrew Cooper <andrew.cooper3@citrix.com>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>, "Borislav
 Petkov" <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra
	<peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Dave Hansen
	<dave.hansen@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
	<linux-kernel@vger.kernel.org>, <stable@kernel.org>
References: <20250818190137.3525414-1-sohil.mehta@intel.com>
 <20250818190137.3525414-2-sohil.mehta@intel.com>
 <20250819051940.sqdjdvwupvocuf7w@desk>
 <0bfc7329-e13b-4781-a331-9f8898110b5f@citrix.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <0bfc7329-e13b-4781-a331-9f8898110b5f@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0137.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::22) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|DS0PR11MB8687:EE_
X-MS-Office365-Filtering-Correlation-Id: 5faae114-7e1d-47ca-6642-08dddf3b55c3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NE9IMEJpWTF6MjhwZjNENWZ6QnpFRkVPQktZaTI1Ny9VTjFFU3Y3bVp2b2Zn?=
 =?utf-8?B?ajViVzE4blQzVzU5Zzhtc1BRWjJ0cmRLQjF1bFcwSmEwWmJIZVNiQVlYSEJL?=
 =?utf-8?B?YWZUWitIMlJDc2t0VG5XY1ZBYU5HbmZFNXJmMkIyazVvMERZZ05xdFlIenpC?=
 =?utf-8?B?UGJSdFFZa21sVUFBSmRVdGd3eFZiaXpkUDN4bEEwMHBnS2oySlN4MFMxNXBs?=
 =?utf-8?B?WkozN2VWWlBhZk5UaXp6YWlnVXUzd25aNFBRZW83VEpCT2JRc3p6S3BFdGZD?=
 =?utf-8?B?SDc2SnpTWENzMWVnOHd1czUxcllZM1RMQlR2Vy9iNDg4aGRvcWxjSFQ5Z04w?=
 =?utf-8?B?M1FrdzhFa2FpMUNheDN5bENPNGhsUHdpSkp5d011K2JIcHZyejhjQzhuTEp2?=
 =?utf-8?B?eTd3WFhlK1hvNWxDLzlKUWc3T2hIMEsyKzcrbDgzaUxnUEoyVEx5MEVYbDB5?=
 =?utf-8?B?WkkrT0pvaFA4L1k3UHA0ZWFEa0xpc0VFNkpwei9tZ1JUUmJZVit6RUdaSFo3?=
 =?utf-8?B?RjFFNlc1SExEOS8xampPSHZYTUc5UGt4emc1ZWdBVFJ0UVNEeENVNW9IWnVq?=
 =?utf-8?B?cVNUUk9yK1hrVXNqR1N4bjYvUFRJS0Q0S0crcmkxWDhGYXNCNWMwU3RwMFhX?=
 =?utf-8?B?eGl3bk1UdFcvbUR1MllVZkl0TnNzTzBqSWNOS3JiZFJkcjhFdlQ1eGFjQjg0?=
 =?utf-8?B?TE1sSmJvNk03SldjdGRtVkhsL1dYQUU0aGNJc2kzZWNvSXREM0pjdTdCNDBo?=
 =?utf-8?B?RitOWDVZK05oT3QwWHUvTWFNWHZyQnNlaFFoSjFoK3dSQjB0bDZLN3d3VmFN?=
 =?utf-8?B?T2FuSUhuU1E3Mlg4T2hIOW1BaWlEbEZWWUNROTNyWWVlVmhaRkZQeW5sV3pM?=
 =?utf-8?B?V05HSThRbnBnakpIam1ycnF2aUZocHlIRmd4dFpNM01VQ2VGTkYvTFNWSGtP?=
 =?utf-8?B?cUdUUkNMTzlIeUc4bUNJcExBcnNKQlVrNDRlRWh0VnhzTHZwNWFJOVpROU1I?=
 =?utf-8?B?cFJLdE9aUGo3bFZncHZzaWd4RXlMM1JoZTRtWTJsTjV6M1d0VzFEMzk0UmRl?=
 =?utf-8?B?MlFrMmh6akVpRXRNRG1KekY2Z1R6Z3RCV0FJU0ZETTBTdHFoeXh0aXg5S0RW?=
 =?utf-8?B?c1FRL29xME8wR01NQXJmckZDWXJpMGtCT1h4NTNlaDFoYkdJYkN0aFduOWMz?=
 =?utf-8?B?QmVEa1AyS1FUaXJVcWdIU0ZxYVdCSXN3TE9sd3Y2dGkwTmppSUdRRnJXMmZ2?=
 =?utf-8?B?U21EMlZNZEYvL1E2djBSR3BnYkpIOVRndmRjV3RkWGIxNm1SYjNGRUZzOVNG?=
 =?utf-8?B?UXhQMnlIb20vSjR4bXByVmUvbHdXelFuWnV2MHNzOWQ4U0ZFMzlLbDJvL3hj?=
 =?utf-8?B?R0JZYnNpUXhsdFZLaWRYYjdEQ3dodGVpaTRSaXFHRGh2bDVJQjZINWhJL3dy?=
 =?utf-8?B?N1JFRnFISitDbTlFUUN1T3ZRTE1FbEJ0Ymd1VDhsK1c1czMzVllCSmFBbm5T?=
 =?utf-8?B?dUlOTm1pSHl6Vzlla3RUQkpLdzlmaEdleXJYUUNybWxUT2pnY3BPcjhMMk0w?=
 =?utf-8?B?d3EwSXkyU2lnOEJITHNZaXB3b3dRQk92bVFXdjhWNlFid3J0ZHp0c1gxRmRp?=
 =?utf-8?B?ckNacUpDNkpKejhnOWhObnhjdlBoRlhkbHlzdERKbjVsQjBHYy8xN29mZzdH?=
 =?utf-8?B?ZCsrdDNIbG93ZXo2MjdIWWR6M2NBVDdqdWgrQkowakw5NC9zVFBaNEZVZ2ht?=
 =?utf-8?B?T2Y2bVJPZXFLT0Q1V1pydnNubFVUVGU2RHRWMEpSZzRVY3ZHQi9UMEtGVWh3?=
 =?utf-8?B?WFZ5cXpWMHgxTzAyMzlDYUMvSlZOeHV0V1crYlpmRHJJWG5ZUTZ5YTJWQWsw?=
 =?utf-8?B?Rkp4RVRGMGhIQ0xmbmZtK2NuSm5ZVm1MbThoZ29MekZ0MkllTjNDZVNyNnpX?=
 =?utf-8?Q?pvK72ihP4ws=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEZyeHNUYko3YlZvYis3amk1TndRSHhxTVJqTFhoUXIzTTZ4OG9XNWJMdks5?=
 =?utf-8?B?bUQrSk5ZWFlRMzFRVTlnMUd1WVMxZlgxR0FaenFYTy9KeEM5cllWZ2tteXpC?=
 =?utf-8?B?MU1ncDhkOElGc0dFU2RDMlh2R2ZjREZpQ1BMUEtXcEY5SkxiY3JEVW9QUVEw?=
 =?utf-8?B?T2pscEVZRnY3QzBBQ1J2S1o4NkZUUGtKL21CRWpaTFppbzNzYzlMbFNrWFpD?=
 =?utf-8?B?b3E5QlJaSzlxOURMeUdJaHRmUTY2RTVnTnk1bGttWmVhcDA1MlJYN0xWWmRX?=
 =?utf-8?B?UzcycWRsVWhWS2lVa3FqYTd2dHRHMnh0VUkzMnBqdDB6WlYrV3JuWk9CKytN?=
 =?utf-8?B?b0V2eG53cHpRa1p6ZGwrdGkreFA4UzNGcHhvUjQ3alV6TnZza2pIcDdGSHBq?=
 =?utf-8?B?ZmxxeXlhWU5iOFB3Yzk3VXpuOVQ0a3FxSU43c3lCVUEwZmpsbGJHNUJqSDVP?=
 =?utf-8?B?UkdZSFpEMFhxRVB1NHlHNlF3eTJnVXgwSmFCTTlJdGVDSGMwQ1VYVitmOWdk?=
 =?utf-8?B?ZlpqdUUxb3ltMmEzeFgxSWxYc3h0VGc3VWZEN2RwczJWTEhwbTUxdEZ0WHpC?=
 =?utf-8?B?b29jYTBZUjR4OWRYODlmRFlRa1RWUGhYTW1UWkRYbHJYb05ma1UyeVloWUFa?=
 =?utf-8?B?YmQxVUQ3M0FRTTJpUEdGN2VHMHFyVjFSSTBUOUhGMEVJTUcvcS9ETGhQWi9r?=
 =?utf-8?B?dDluYWxpeE9hTWxhWGhjeUdsTngweUlod0ZCT3o2dGtHc01KUW5uV1VKMFln?=
 =?utf-8?B?QUZOQVNBTW1oSWNZcjBpbEhZTVBEbTVrUnJlTk9jVUNYTjMveHQ3WVVwWXpU?=
 =?utf-8?B?bytNOFYxYXgrUUhvQjQ3czhOQ1lXbWJHWUN1U2EwazBCZlo2bURFQ2JQYTEx?=
 =?utf-8?B?aFFrRlplbDZQNVphdU1tODFyd2wzMWlqaFFJbDR3dW9Genh1MUhDdk93Y2kz?=
 =?utf-8?B?c1BlWXVkbk93L21WUHBGK0U3MVBpcTUvN3ZqUFRmSjgzTW5aU0NmYVVxNG9v?=
 =?utf-8?B?OGpmTnRJZXUwQVhpTks0QzBaUGdPNFI2UUFqbUdNRyswWmhWUjVPL01RSVc5?=
 =?utf-8?B?M2QxcEloSjNrWkdGaVpvYVMwR1RBUVA0d0RmSXZEckpBRFdPZTYvbGlnaHZ0?=
 =?utf-8?B?cGEwSFlRWE1sVVg4R2tzc2hZRjF2MnlLTnNqbzZ2MFNMZWVGeWtRRG5VeEkv?=
 =?utf-8?B?NjFXVEtNM2p4UEQ5Q1huVENRS0MxcmRQRmpwR2VTVDF5dG0rd3Y0ZXNHYXdE?=
 =?utf-8?B?emgwUnd3c3dXWS9VNU5rT3pKRUEraW80YkxZMFZNc0o3Z2ZMdkp2WUZvWDZF?=
 =?utf-8?B?b1pMOE16Zi8rTUhqUmY4TkljOVNXWGQyaDJYTm5aUUkxOWxPSTBZWFFmbm5U?=
 =?utf-8?B?aW1KZ0sxTC9sWTJZamxJOHJmU1B1SUdoMWpURTRGZXNOWGhCdVpoSVA1SUNN?=
 =?utf-8?B?cXNjdGpTdXBaUE1ZNGZSeW5yOHpzZzBTSFYyMmYxZ1FEL0prck9YTG5iQUZi?=
 =?utf-8?B?TVdUTVZsK25YYmg5N3lONWsyMDRJTWlTK05LU1ZLaXZQdmpuS0pHNHAvQ1ZE?=
 =?utf-8?B?ZTZtTHZhTVZUQlRZVEQzUlg2dzVBS1dTbmkxam5Rc1V5NllkS1RmaUM5ZEpN?=
 =?utf-8?B?SFloUXFBZWIyNHBxR1lYRitOZUNxcGwranlIblFuNmpyYTRacHc0ZThnVmdR?=
 =?utf-8?B?d1U3OHBnYUppOHRyeld4V3lnUXlDandkQzJvQzArN1puNjNnbERJVFBnejd3?=
 =?utf-8?B?V1F2a2lqbW4rSjBYbmpTOW5GNU1yWVZlUzA1WVNzSjN4VG5MaE5uUnIvQnVT?=
 =?utf-8?B?SXJjVEZuMzlRWXpRbEV3T0tsSUxMYVFQNThaSlI0b2UzVU8vVXJOcXFqVUVK?=
 =?utf-8?B?cHpESUVROSsxbXc1OWRxSWxNdEhKMVgrTDY2WE9OT0NjVzI1bWVTZ3lkUlhy?=
 =?utf-8?B?WDgxU0k1U0w0QVNTQWlVbmMwRG5OSDNwOFpwejluRFZwdDZPNU5SWStTeEJK?=
 =?utf-8?B?TEtBQmxGejJsak9mTnNSVFBKSGcvM0Jic0FrcnpEY2dvL2NzV2xNSjZFL3RD?=
 =?utf-8?B?UzlCOEc1RExEVy9Cc0tkak9MWmhRbDF4Q2s1VVhxNUx2Q2RJOUtsdkQ0NEFG?=
 =?utf-8?Q?JbNsbNrnQvvQOV4C8qCRtWuS1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5faae114-7e1d-47ca-6642-08dddf3b55c3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 16:13:29.2587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBlcIXF+TC3VZsEnlCm9DzT7syE9O5WXDb7jVlfeJgj6372gwukxCdfzzef3QBUT0L8eLedU6B4G/c8KfQnfzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8687
X-OriginatorOrg: intel.com

On 8/19/2025 4:18 AM, Andrew Cooper wrote:
> On 19/08/2025 6:19 am, Pawan Gupta wrote:
>> On Mon, Aug 18, 2025 at 12:01:36PM -0700, Sohil Mehta wrote:
>>> Update the minimum expected revisions of Intel microcode based on the
>>> microcode-20250512 (May 2025) release.
>>>
>>> Cc: <stable@kernel.org> # v6.15+
>>> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
>>> ---
>>>  .../kernel/cpu/microcode/intel-ucode-defs.h   | 86 +++++++++++--------
>>>  1 file changed, 48 insertions(+), 38 deletions(-)
>>>
>> ".model = 0x55, .steppings = 0x0040" is being removed? Total number of
>> entries in the table are being reduced by ~10.
> 

Based on the diff stat, aren't the total entries increasing by 10?

> That's because early in a CPUs lifecycle, microcode for the late
> pre-production steppings are still included in the public repo, but
> eventually dropped.
> 
> Alas, these deletions are documented as well as everything else is in
> the changelog...
> 

I sorted the file by FMS to make it easier to spot changes going
forward. Though, I don't think we can rely on the kernel history to
track the microcode changes. Because there isn't a direct 1:1 mapping
between the microcode releases and the kernel update. (Unless that's
what you are proposing)

Dave's initial commit used the Nov 2024 release, and this one is based
on May 2025. There could potentially be multiple releases in the middle
that added and removed stuff which would go unnoticed. Though, using the
script in patch 2 it should be easy to track that (outside the kernel)
if really needed.


> ~Andrew


