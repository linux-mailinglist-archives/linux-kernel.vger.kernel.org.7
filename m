Return-Path: <linux-kernel+bounces-736236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E35B09A54
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AAF83A7C75
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6071CEAC2;
	Fri, 18 Jul 2025 03:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f2kiJ89m"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F2F14E2E2;
	Fri, 18 Jul 2025 03:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752810932; cv=fail; b=m5NGB/JLN9s3H7lMzB2JADsx7ctiYsslZhOMN4AKJ7JUT1/udcF1Y+P7Rft0JjRNzvKKV+818PDXdkbtvi1dZVMWQ8a+FeOg/ihSprzsJctK4s/7NnH/kYx4onQkWSH07BiUowvqTZ1nwNggNu205p7psLd26G6lvWXkBwmgrTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752810932; c=relaxed/simple;
	bh=9BouYnmkklva0O0zmG8NMGfeNdhbqfY43ZsTylsqYTQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TABRwTDVrlhcl/w+1gqdwC5tas3hCBOdjjI4mdQgrNfr1m7a6LAxoZE5t3iv3cn8NHC7gEf/M96E5iLMHL9kKhD/mWOT0Duao3tU9awRg/+e6aYlEQWp8mOEv59pxLgGl42FQuxos/yYXp7wOsFWZmMUIMPESgzjLH+OSa5OlQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f2kiJ89m; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752810931; x=1784346931;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9BouYnmkklva0O0zmG8NMGfeNdhbqfY43ZsTylsqYTQ=;
  b=f2kiJ89mrqcePJ74lJat6ebMxvaXjiG0TFMCpJ9TecMJMRRWjMrA4p0j
   XzY/SgstofohMZbi2JUmtk/RbHFsSNaLIhOCrS6BCcRimLqEqaA/Pf6Mv
   E//Fm9H1s400Ti8INHJDPzr2Akm7zVYKthdAzi22IkX2NcL18Z57OS5G3
   W1TbWf7mdsxX08xx2R39ONE2mGjXvMLPvY0xMxEys6Aot8SbLvpCsCNlt
   cmaimzoPYTSAq1tmTORmCq8TChBZb4lm0rSELbIWL0BOALb72DeoYA9RP
   Fy9sVD5n/C+NoFNQqnK9havot/0+1bcA8u3UR1kqtwYAjJCnAlF59XOzx
   w==;
X-CSE-ConnectionGUID: T0BP1armQU6NAaIUmPLvTg==
X-CSE-MsgGUID: 7xIbPSFEQjSC75/K3NVbXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="55040760"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="55040760"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 20:55:30 -0700
X-CSE-ConnectionGUID: v8SJjqboRISyfuEwB5Bn7w==
X-CSE-MsgGUID: vB25/GLdQhmXt/xmPn7liQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="188941182"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 20:55:29 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 20:55:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 20:55:28 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.62)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 20:55:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGShrujtpNMZ4I3JljAob0GMkJMI/LLsCVMuJeHQHu1iZnTTgrb3oM3fSxHxRlQNDJCLVjjUMw6hOuozwiXgqu3lnZeyXPsZmHvRNV5lM+ESNsSK80Y3GLEwBsH83CXZ8mNHIQb7c36PhFYXjphzwWU9yE+6HXqf9A1dYX7xYJuiwUccYBstmzx9XwvV7/2KK03RlH/A/cpL98BjjxPmcS8XqtfonFnGJ+Njt2CyisjuItwLD7gZSdFcagkafx7LDQrC+j1inAMbiW5Qoh1nLyE07N3FeHlTnPdt/arDgsZclfcQ0N4W1At6kdQjFiYHi/eyXdXzqydBXUWQHEijwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knNWgASsm8AwtUg5FO2BbSit3qx0ctwzCG5PjF+96eo=;
 b=H31pZW60oJ2vTWf5tX6d5LGlBagiHyQme6XKkDm3DgBMlqIAGKlOqy4XPF0lFFoYn4XWpeYooU8aPFlxPosMiakTRhhYDbOx5S+wXjQerTEb3JISZFk8LA+SNceBq5gL8YQYxwJbLlhiEB1hBXWsQJaNc6cO7rOwoBqolO/9NZeiWjSz51lXfqS6HQa2nlSRROwfwbWt9pdVHpO9Opt4TY2jz7eRAy3x1BCTi3fkY0K1Fp8t/efR/boEuS1ocgYe3LXiC6//feWemSuMugszN/wYco8Ls9XXjkDL1CWCJycAc4rzjXvZ94KuaZAid71SGVACAX0nFmbUzrdJUY+JzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6757.namprd11.prod.outlook.com (2603:10b6:806:25c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 18 Jul
 2025 03:54:53 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 03:54:52 +0000
Message-ID: <2028b020-bb31-421c-b7d8-acb9ac7e9f77@intel.com>
Date: Thu, 17 Jul 2025 20:54:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 26/34] fs/resctrl: Add event configuration directory
 under info/L3_MON/
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
 <0fda2f958001dec07827f803f0e31158a2b77a8f.1752013061.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <0fda2f958001dec07827f803f0e31158a2b77a8f.1752013061.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0184.namprd04.prod.outlook.com
 (2603:10b6:303:86::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd26db0-f6b0-4d7f-202c-08ddc5aed9c8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmFkUk82c2RNUkZxdGhkTzl3TGlJenl3bUVUZXo1Zy92MyswanVXK3h4eU1j?=
 =?utf-8?B?elN2cVBpRmd5UERqMityVHVpSHQ0OHcvR1hBSU5OU2NGUWRIZ0V5ajQxc2hI?=
 =?utf-8?B?Zk5DbmxUR01SaEtlNXg1bWxGcDY4SzV2VloyS3hnM2I4SnJnM3FiWk5DZFNN?=
 =?utf-8?B?bmFHQWp0dEJDcUM0UzV6MkhwTWZsL01TQXJzR09JcE10RFk3eHpEOGlZZCsz?=
 =?utf-8?B?NkRUTzBXdWRrUmcrd2pCbWc2RklvdGFIZFpCTzVqSFgvVHhTUGxCeXJMT0F0?=
 =?utf-8?B?UzFoRmI0cGVXQWtiVXl3Z0M1VkxDVThGRk5uZ3loWW5MWjVib3M3S29QajJt?=
 =?utf-8?B?K293L1paU1REaFQ1TlpJM2dXSGNsZExZa3RDbUFyYUlzc1RLUU5ncWxibjFo?=
 =?utf-8?B?LzJuKzhWcXhzVFdTOU1Wa1R2anpNam1NQm9iUE1tTTJyQzhnN0NoWVh5NnEz?=
 =?utf-8?B?bGV6TlVoRVdJaDBieC9UQWJlSFdjSE1EcHpVZ1J6Ky9aSE1kcVFnZWNFWlVk?=
 =?utf-8?B?Sm9OVDA5YmlCd0o2Sk9FNWpZdGhmWFpyRjVYZldUOGlnaS9ScGtSazBPdEVx?=
 =?utf-8?B?M2Q4M1JML3BTeEZ4VDM2OW8vcVA5ZnU0dkM3QjdMSlluWXRFS0dOM2FHRUVt?=
 =?utf-8?B?OW1MMXRxc0Z3MVhXQzFjb2RqakhtN0J4WmRmMFRiajF1VGZjVkJ5TlpMMWJL?=
 =?utf-8?B?czNuVEJVL1ZPbi9EQ1ZWTENGL3VKTWRNdnY4dXZIbjNXVjJJYzZZT2lHa0t6?=
 =?utf-8?B?WWVyR3IwL3lLRjdycWdENnNPOC9DL2xIYVo1TEtZcUVOeXJ5VVcxQUFicktB?=
 =?utf-8?B?WXNEeFJnVW0rbnF0aTYxMWdFbGhWeHVKa01Ud3UwczAyWXJCV0pDaUpKemZ1?=
 =?utf-8?B?eGpkcUNxQldXNUd0MHRJc1lINHMvUDBRQ1hWZG1XMnlKV1BIWHdadWdBV2U1?=
 =?utf-8?B?c0FnWmtUUHYxbUJ2U2Q1UWQvZEtrb0tSUFkwMFFtVStuRGwrSHZUWjMydXYv?=
 =?utf-8?B?SkQ3czkwdjZwMmJvN1RXa3FOL1V2U2ZJS0lPS0NBM2c2VjFvWi9HQ2Qxek9h?=
 =?utf-8?B?bWpUbWszZ2FTQnN6V0ppNUdkNmJqeTFpUzVBS2tLK2lCVmVQLy9udy9MVFVq?=
 =?utf-8?B?Q1U1L3I1R2EzekJvTGJPOTVMaWhJeDFleCtJU0tXTm8zVHdmWGt4bno2NFFJ?=
 =?utf-8?B?b0dOTUlxM3NPSHRyb2VPVCsyWjRiK25FN0N2NWtxT3NuTHBzbVpOdU1xRk53?=
 =?utf-8?B?eTU5MnNhL1lhenFLbW5qMi9xdXRQQmhxLzBJYVRYb1hHREwvSnlVNngvT285?=
 =?utf-8?B?Y0JSb3ZTYmlVRDVBRDZFWWluMk9sV2FFWGtKVTcxeUFmZnp1cnlNaXh3SGlB?=
 =?utf-8?B?Q0dRVExrYnp3U1psOWVvWC9KdkZJc3pUaXd0YTl1QjJXVjdoTjRTZXRrcXBo?=
 =?utf-8?B?WFJjSTdOZHR4RTRuQmxSUklaQkxHWGlmcDg2TVdWWU5ob3NKUnlNZnZaNm14?=
 =?utf-8?B?bnVZVTBtUVJzdlFISUJyTWFkTGhObUxhWWFhQTNUOE1yaG9RK1c3ZEtCbGV6?=
 =?utf-8?B?TkcxRWV5T0pxRWI4U0trOXdQNVM3QjNrTmROK0NpTHl0Q01UMkFoOUJiN3BQ?=
 =?utf-8?B?WDBaMk1PTkFncmRiTWU1ZzJpanFDaWduTG5adjllVUdicGxmYWc1VEtIakdo?=
 =?utf-8?B?VnRkVW5iejhxMDFDQXMwTG8wTjg4Zkg5cjBGZU9wL0V2QUpKN1ZmMWNZNm5P?=
 =?utf-8?B?UUx3TEdpTWJJd1VOUDJKODhQZ2U1U2k2TGZnaU9sVGJOSzNxN0dWMHVRV0RX?=
 =?utf-8?B?bEoyd3JQNzIvZ2MwenArZ1JQRkZLMTFkMm5zRmV3OFBFSFE1VGVHVUs0TVdE?=
 =?utf-8?B?cjR4aHRDZFFuRUJBUkRhVWpaM0JFTjdRalJ3d0ZyWDU1OHFoSnVyV3hrYi9a?=
 =?utf-8?Q?MrSamLZVuwY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekFRSHBGa3h6WmFQdVJRRUJETE93YnJRZ0UzT1FsWnpOSy9IR2hqdXpBYTlw?=
 =?utf-8?B?SUkzWkJRVkVqUUladkgyeGErQ0hwUnNGbUxoajRQUkJxSzlKM2pWK1hIMVln?=
 =?utf-8?B?dlFjRTRpbzVQN0xxajdCc3BBaGtlLzNmY1pzZlBidWcybWtXVTFLK0Z0V2RV?=
 =?utf-8?B?ZVFqT0xNdkNlWFpXSFZiNS9lVmxHRDV6dHJ5K2N6ajZ4ZU1HZnNEYnJvNGky?=
 =?utf-8?B?dkJsaFkzc3dYU2FNOUR1RFlYMEdnMnFRZytCb0plRWE2OVJoQWs3SzlJWWJH?=
 =?utf-8?B?QlZFQ2lYQlNJeDJqbFE4My9RS0VvVzhHZ2todlJieEY3eEZJaDdkWHlnTytJ?=
 =?utf-8?B?RFJNbEVweUFPNjhaWmlXbG5YVVY0Q3EwOFZ2Z0x3UzVYUFBYYkM2Y1FyR0hD?=
 =?utf-8?B?RlFhR2pjUCtBc1dTWFdiek9XeGVSclFrUnFHMlR2YXhKK1M4TUFQZTZnL3Jl?=
 =?utf-8?B?bUpnMW1WeEFjWDdXOFpRbHBGZ2JqRm1KbGZMUVNYaDRSQkF3VGxiMWNmV1BB?=
 =?utf-8?B?NWNYVGdEUmhFSmovOXljOHRKajZjQTZaUHZIeGNkWmMrbVVFSUJkam91VWly?=
 =?utf-8?B?endLL2lqWFVxdUFFZlIwbDZXalZyb1JLOXZtdHJEWUF1K1BjMmRXOXl0bHpT?=
 =?utf-8?B?NmdpZklXSUs0QTRRUUFFbTFpSVZNNnphWjRUQmpYZkpqeEFva2tnSmM3U000?=
 =?utf-8?B?ekFsRXltNUY3dWphdW9uckZvM3JhaFpNY2xzclhlV0pScjFyS0d1Nk1pL3Jl?=
 =?utf-8?B?eVRqQ1Y2SHRJWDJyMnd1cWsyWGhUZ3FLV2puenJMYS9vTU5CRG9tV3FWOGl5?=
 =?utf-8?B?Zk44eDloWGw2UTRZSThnQ0ZzYzJ3NXN5Mno3anl0MjVnVEw5Ylh2cTh2cGNP?=
 =?utf-8?B?WUJnbmsvdUdPMTl1UmZWaG9ObUVmV0VOK1hhTm9Ia2FSS3Z4WWR4UHRkdXUw?=
 =?utf-8?B?MlpmNjdyN3pEVFQxdVpScGhnUkRPZ3FKcjZuWmkwMjRJQXY2K0diNGF4MW9i?=
 =?utf-8?B?OS9WblN4N21UaUtQNk8zZjZCVkExUWxOQ2NQT1Erd1RoalkrUVQvMkhGMHNm?=
 =?utf-8?B?cStETFJ2ZTFHVlREb3o4cVpwWE1sVVlDd0VoTWN1akZyaU9VVTVNWkk5QWty?=
 =?utf-8?B?c0d0TFk1dk10c0lYckd6bHFnL1hhNnR4NHphQmxSdmpBQjZ3cDd2RmNaZnlU?=
 =?utf-8?B?MXBVUFp4blV3anUrWFdIWXErbW4yOWNTM3g5czhFS0tFTm1RbUZRejZnd1pP?=
 =?utf-8?B?bTA4Mm41dmdGSWJwdW5EWnBtTXovbjhLWUM0WFdWNnFxK1VTKzR0NXprcEM1?=
 =?utf-8?B?ditXNTI4SnBLcEFRTXl3S0JFRE00aGNER3duMzlTR2lYVklaWVRTM1g5Zklz?=
 =?utf-8?B?MnozeTZQOTQ2WjhwODB3elFvOW5zaVFZeFVYcmFWTERUaHdOUmxuZm9MbWNr?=
 =?utf-8?B?djVVLzVHN3h3bXBRZURFT3J0cWlRSjlNYXcranlJLy9QU1ZTdUYxOXBpV2E1?=
 =?utf-8?B?SmNtWGF3QVVsVFZKbCt1Z1l6Y1NSRnl0MWNPRWsrVEJLT2NrUkIrLy9EdFMz?=
 =?utf-8?B?eE5FOUw0M0ljVjdDY2xNZE03YVA5U09jNHlzNHorK21CVUJYa2ZuL1NIY3Vh?=
 =?utf-8?B?Wldkd0FOZ0RzZkR6a3pnS1IxVWJFL2RXNERKUU9UV3dvMWttREYwdTRPak4y?=
 =?utf-8?B?NDRoWmhtMThYcVVaS1JVVFg3cjVqVHlvOGN0SVRXakNac0pydzU1ZWdVUW9a?=
 =?utf-8?B?WGlrUzRwazBCcW1sMTZtUXJhUXRuYU9uV2Y0bk5sT2N2Ky9pb0ZoS1hFTHBw?=
 =?utf-8?B?YnhVZitQcURiWnBRQWFZVUZpVHJLWW9KVkgyeFo2L2F4c2ZiUUFSakF0MkRB?=
 =?utf-8?B?QW1PSWVQcnB1Mm9yREh0NTd3VnRDeVBLSmgxb21YdlhCNHF6am56SnZSTTV4?=
 =?utf-8?B?dWdYazBQL0FYdkZDSFkweEdkQTM5bHhlY01nQkZUd3lEN1BkWGFFN28vQTNa?=
 =?utf-8?B?WWh6UGgwMmV5eU9LcUVpZW5XdnJXVVo5R0FFaWcySSsrY0VqVW5kUW5sNWxm?=
 =?utf-8?B?N09IZVFBbW1NQVBvM2FUSWUzMjBycUs2ZklackhzdktFamZhZlozUkJ1S1A1?=
 =?utf-8?B?dWdGSVl3WVNad095bnduSTdISEVvejBjRTB1UUpKa0VTZzVkaHVsdGtmK1p1?=
 =?utf-8?B?Nnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd26db0-f6b0-4d7f-202c-08ddc5aed9c8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 03:54:52.6784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRd7FlzNEf5bGHifCZC23okmNpK17/0JhAy0RMB7b7mbZjzuJS/BGIWUfPz5IzJaUbAUBqCAIivsCIBSOrc4Jw3tZqhyzuevSS9NWqeEA70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6757
X-OriginatorOrg: intel.com

Hi Babu,

On 7/8/25 3:17 PM, Babu Moger wrote:
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index 15d10c346307..bb28ef7e4600 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -86,6 +86,8 @@ enum resctrl_event_id mba_mbps_default_event;
>  
>  static bool resctrl_debug;
>  
> +extern struct mbm_transaction mbm_transactions[NUM_MBM_TRANSACTIONS];
> +

Please move this extern to fs/resctrl/internal.h.

>  void rdt_last_cmd_clear(void)
>  {
>  	lockdep_assert_held(&rdtgroup_mutex);
> @@ -1895,6 +1897,25 @@ static int resctrl_available_mbm_cntrs_show(struct kernfs_open_file *of,
>  	return ret;
>  }
>  
> +static int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, void *v)
> +{
> +	struct mon_evt *mevt = rdt_kn_parent_priv(of->kn);
> +	bool sep = false;
> +	int i;
> +
> +	for (i = 0; i < NUM_MBM_TRANSACTIONS; i++) {
> +		if (mevt->evt_cfg & mbm_transactions[i].val) {

mevt->evt_cfg could possibly be changed concurrently. This should
be protected with the rdtgroup_mutex.

> +			if (sep)
> +				seq_putc(seq, ',');
> +			seq_printf(seq, "%s", mbm_transactions[i].name);
> +			sep = true;
> +		}
> +	}
> +	seq_putc(seq, '\n');
> +
> +	return 0;
> +}
> +
>  /* rdtgroup information files for one cache resource. */
>  static struct rftype res_common_files[] = {
>  	{
> @@ -2019,6 +2040,12 @@ static struct rftype res_common_files[] = {
>  		.seq_show	= mbm_local_bytes_config_show,
>  		.write		= mbm_local_bytes_config_write,
>  	},
> +	{
> +		.name		= "event_filter",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= event_filter_show,
> +	},
>  	{
>  		.name		= "mbm_assign_mode",
>  		.mode		= 0444,
> @@ -2279,10 +2306,48 @@ int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
>  	return ret;
>  }
>  
> +static int resctrl_mkdir_event_configs(struct rdt_resource *r, struct kernfs_node *l3_mon_kn)
> +{
> +	struct kernfs_node *kn_subdir, *kn_subdir2;
> +	struct mon_evt *mevt;
> +	int ret;
> +
> +	kn_subdir = kernfs_create_dir(l3_mon_kn, "event_configs", l3_mon_kn->mode, NULL);
> +	if (IS_ERR(kn_subdir))
> +		return PTR_ERR(kn_subdir);
> +
> +	ret = rdtgroup_kn_set_ugid(kn_subdir);
> +	if (ret)
> +		return ret;
> +
> +	for_each_mon_event(mevt) {
> +		if (mevt->rid != r->rid || !mevt->enabled || !resctrl_is_mbm_event(mevt->evtid))
> +			continue;
> +
> +		kn_subdir2 = kernfs_create_dir(kn_subdir, mevt->name, kn_subdir->mode, mevt);
> +		if (IS_ERR(kn_subdir2)) {
> +			ret = PTR_ERR(kn_subdir2);
> +			goto out_config;
> +		}
> +
> +		ret = rdtgroup_kn_set_ugid(kn_subdir2);
> +		if (ret)
> +			goto out_config;
> +
> +		ret = rdtgroup_add_files(kn_subdir2, RFTYPE_ASSIGN_CONFIG);
> +		if (ret)
> +			break;
> +	}
> +
> +out_config:
> +	return ret;

No "config" is happening here so the goto label can just be "out".

> +}
> +
>  static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
>  				      unsigned long fflags)
>  {
>  	struct kernfs_node *kn_subdir;
> +	struct rdt_resource *r;
>  	int ret;
>  
>  	kn_subdir = kernfs_create_dir(kn_info, name,
  

Reinette

