Return-Path: <linux-kernel+bounces-751265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83686B16712
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E86F27A53FD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49B01E5711;
	Wed, 30 Jul 2025 19:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DCuEHtpK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EE442AA4;
	Wed, 30 Jul 2025 19:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753904884; cv=fail; b=LmcsZ7BjviTgWpQuUuMd/TcfqVNV/Lc0u9CUEo96zY860mP6+wH0fFhrHmnlE+G966anHC09Lb13ebD2UjRT5kK+xIIoy91xoG3GlXdKUEPEci8mcH28Ts+16KienIyaXQDVuFvX6uS+dWXQK62uq1IaPqrGOyR7UAytLI+zx+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753904884; c=relaxed/simple;
	bh=0PSI9iCY19UCKTOGgX3z6YHNoiFmowLGAlzfTE5uGCk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gwVTuPn0f+O8/GrZsSKr4O8kA/u2on1ZLBpGrGLJq02uut62r1CtrhvGxna66Mzz8oKb0vI+CvdjXRR154HuSYoobkjVWmOnIAvycjG1zO2E6NwxVfsNbydvEbh6aBtktiau1EIV+1N5lAvsqHZbFZp99tpCWUa+kx3qauGRI1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DCuEHtpK; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753904882; x=1785440882;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0PSI9iCY19UCKTOGgX3z6YHNoiFmowLGAlzfTE5uGCk=;
  b=DCuEHtpKKPbB83dVuIWGchsM5HqnPDf6ZppgJZq1gh+OO7TNBay7UmPU
   zYsuC65a9KdRpRbMu/pHgR+LSAPwA7zfON0U7UEmL+d1/NAzA3YdaE5y+
   DsBP7UziZfZdhWoBHMJotb74gJgmbgFA9bjRDyqwOuhtS60jr0q56qY7a
   2Q8UQCoGhMEd/b9wfdwpMKmz2nv7rL8tquIq677hl1auKPGwOC608tIbU
   GhJ9m/EysMt/kR5JFsGzcGjZuKKUGW8cYPZZpR8nnF4jSPe5SeueaOPcC
   zxwxl5DUP6nIpU2LWGc2jQx7uqnFsNETw9WE5dX6UwXSW3mREExTsX7di
   Q==;
X-CSE-ConnectionGUID: 5vLF2RB8T+CD83ubxc5acA==
X-CSE-MsgGUID: 15baInRkRXC5zIQE917VQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56150125"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="56150125"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 12:47:47 -0700
X-CSE-ConnectionGUID: Sa9wsoTsTi+M9YJ1OTZHYA==
X-CSE-MsgGUID: NPt3dscXTYm6jLJvTlpUhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="162334739"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 12:47:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 12:47:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 12:47:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.45)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 12:47:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/n/lpWnW7fvDjQmP9Hm949gSb3oUeIrx0ipIMaaOw4WjVSrpDsOtXkk+oQLGO4KbHXHsQlBzYaMY4Qsr/jVuJInq7pC5SeuGgL1VeB/xLT3A+cfJMUr+lLqPeT+RxrJum2kivAB3MjaDH13qp27P8ILMQVGQeCr9A9f81hJCN+lmH4zA6pLnMMrqnv6Uri374CY0p1u2N7BkAAQ754nHZHb8tthW+caT3VqtKoBhQRbikD0/p6nMp55FAY0OdKGknFTLFR3Go2Ph3XV1uvErBJ3AnHdwKiM0Zph+/buyKsa2CUbpckKfoOySxr98xjcs+5YYJqUrjmzeD5NWwWqZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8ru3Mui5brzzKuhZCGwljlNjp4R4yHWgdOM/XHhikI=;
 b=UgeD8PMHGv91AB5qb5But5YUU0MxHGNhLYLuUNpW7ijQC245l8GwWfW4SLEERt7DrlorxJ3v7yrcTcJk6BOUeicvAwTTreHCdH0Lc1jrrt6VBiCGX7dB6UromJ8iIp5lTZV2SUWLd2BGUD/jkWwqwY6leNIQOV/Kw+eqyZywqjTGRHtLoTYAkmnjk7xXNDgmp5MG2CvSra2wvWQJ/kkz4Hx4UMg9rJDpBMUgi7AJ+tpz6ijkn0XxRj7WLFbN0leHRTt2NzeRDTpkDjvBA5OUEl1DeAa33xlR1cyko92lqLlLDLLbjg8DuadVPCg38lLnO0rjLLDc4etZAsuLzrph/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB6422.namprd11.prod.outlook.com (2603:10b6:8:c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 19:47:43 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 19:47:43 +0000
Message-ID: <aa40fe11-b3a5-4b86-81ca-db8b997ef325@intel.com>
Date: Wed, 30 Jul 2025 12:47:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 01/34] x86,fs/resctrl: Consolidate monitor event
 descriptions
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
 <404b149d4e717fa7e7f93cbe85cd5abd990202ca.1753467772.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <404b149d4e717fa7e7f93cbe85cd5abd990202ca.1753467772.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0352.namprd04.prod.outlook.com
 (2603:10b6:303:8a::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: e61730ce-866a-4d40-128d-08ddcfa1f33a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZzJtOURjMDlFa3k1Q2lhWU12cTZOVXhKY0VXbWwrM1lxSjBHeThwa3NrTk4v?=
 =?utf-8?B?ZUZWR0FQZ2NmYi9vMGllVThBSkh1cGtaVjZyNmFmNXNKN0RmY3p1Zm5JVmpa?=
 =?utf-8?B?amoxS2sraGlMSHl5L2NIdU5FcGE0ZVl6SSs0bEVOQlRLRDIwdkplTDFwV3g4?=
 =?utf-8?B?U3ZrT0NxVEFnbEZ0bGVXZlJjMzlvYU16dGVNbGw0Zk1IdGd5Uk5kVjYzR0xX?=
 =?utf-8?B?c01VRTRRREQ1ZVpIalJSMytHODNFQWlsVEFjcjBYRndjMWl5NnpSaVd3ZHFO?=
 =?utf-8?B?UFZrNkhLRmxyLzVGVjdwYUJWNUdPbXpzT2ovU2RHcWRKNTc0NTlrTFpacU9V?=
 =?utf-8?B?bHQ4RW0rSnhUKy92RlE2K0hiQXgxTjl0MEN0VHJ3aUtsL1FyZm5JSzZ1UVo5?=
 =?utf-8?B?cmhVc0hONEI4eVlsK0J1M2I1YmgzOG5wQlJmdVNObFJ2NHBGb3NFMWwrNHp5?=
 =?utf-8?B?bmV3dDJBK0JkVlk1TGN6K2ZBd0ZkU21qMm5BaGVYRDROM08ySWpEbEUxVUh4?=
 =?utf-8?B?MDBLNkZhMkRLWXl5U1YvaUpDeFVWTnVVeGU4TXZMTmc1Q1dzbDlIWjJFUkZp?=
 =?utf-8?B?cDZCdmtON0dMRW44SXc0QUxhdTllc3c3K0FJS3hhSnhJZUNMbVFMNHdxVUFM?=
 =?utf-8?B?Mi9Bdkp3MnBHKzJFU2NsMitQREdDWWo4ZEVKUXhqdis0ZHV3NVVaSFM1eEtp?=
 =?utf-8?B?dFQ3NGZWc01WUG1BaDRoY0plLzU3MTdXRG5JZ2RVTlR4MVoyRUFwNFpDZVpl?=
 =?utf-8?B?RkdoOFJuZTBFUlJ1Y3hKcHF2YW5EZHRFS0tkbHh6akIxaE1UM2xCZVo1WENM?=
 =?utf-8?B?TURnRlFKRXpNN3FjVmwzYlZvVTVkODdPZ1VyZXJrSnhBeDlUQWZHZ1Q5TUVB?=
 =?utf-8?B?WkJyUHMxbFVLR3FWQWs5SG96UTdTT0s1dmlYTWJYUnI1ZEZyRExtTmxCWVdJ?=
 =?utf-8?B?WlhSTUw5UHBpa1lUNWJTSTJOMk9kcEdRRzNwTERSZWtkZVlaMFU3TTh4RWlE?=
 =?utf-8?B?TkJsV2l6MG96RXVENUhZRHd3VCtieExoRml6S2IrKzhvVUFtMzJHNHlUQVM0?=
 =?utf-8?B?RU10MWxCbmdhN3lXTkgzenJEWGpEdlRUNnlyQlNic2x5SjhCSWdzaWh2QjRN?=
 =?utf-8?B?R0U1dUFuZXVRRm1za0tDMzN3M1ZuUnppMG1MSW0wZUNZQ0ljcmNwUk9KN2tG?=
 =?utf-8?B?Rzl3aU1wK1AvbE1hZGZORnphYVpSTHpyUkQxanZVSlc4UUMxcXkySVdmWTZl?=
 =?utf-8?B?aHBPSEFOc2ZuaDJxellrKzFmRCtaTi90UUhCcHhkM2R3amFOTCs3WFJXTEpD?=
 =?utf-8?B?RmpYNkFtMGtRZ0NqZTcrTUl5UXF1NjJuTUhlYisyczBLTUNMYjU0WEZEKzVl?=
 =?utf-8?B?UmtUbU1OUXNncE1ZOEttWm91UzBpbU8rWlFtenZhRUtpaTR3YUxTSkJ1eTk0?=
 =?utf-8?B?bGlGUzRPc3hONmZXaENuWGNDSVRLckwxbHkzdHZsSTNBc3B3Nm41cW5tT1ls?=
 =?utf-8?B?OVJLVmJmcGpRTnI3YUcva3VwMUUwNm0rT1FmbnM5Qlh6KzdQY01PNVh5eEtn?=
 =?utf-8?B?ZzNiMWhGNEhqajJ3YUl5Q2thckRMMW9XWGdKS1hlZmhVendhTmdoUGowNUZk?=
 =?utf-8?B?VXg1U2dERDFvYy93VXJid0xuVDhTNG5GQ1J3QjVIeUU3SUw2OVowdmNSVys5?=
 =?utf-8?B?VHovVVdPUmxwY1hMRGs0aU00Z0lXR1FpRkdEak53eXphdWI4SkozN3Q3REts?=
 =?utf-8?B?azFoVDk3N1l4SFMzMFRCdXdNaHhMV2dDVFYvdWtwOXRzdzViTTVzY0t1SzN2?=
 =?utf-8?B?U2RQQUExSUZIMFUzdGJQK2xtNzJuRHBnMEF1OFBiaVpSQ1IwZHQ1Zm95dEtq?=
 =?utf-8?B?YWVTWWRPY2NoVVFrS0NWaUE1Q3ZnVDc3MmZnYkhpK3RFc0EzNE9uNUw0andi?=
 =?utf-8?Q?fhxbWDFNFb0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUo3U2E3TEVxc29uK1A0ejlDL2ZCS1Y3dXFtc3ZBMzZVdGhUOGFCQzA1TW9w?=
 =?utf-8?B?WXovWkdFdEl2V0l0QmJrR0JpMW90aVgvUGlid1d1a0h0Si9SSWZ1aTdqbWQ5?=
 =?utf-8?B?RFIvck5TZFUyd2hLak4yaGVLNjZkOUE4cEhPa0NaZFdCc1ZPeVhXclJLZ0xl?=
 =?utf-8?B?bFExSmV4OG5iTE9MNnNFWDdtek1IaEZNUDFTcGVRMTRPSG9YNS9OaGFpUnlR?=
 =?utf-8?B?YzhhUnQ0cVZybjd2NWhiVTNTa0JRWXdZZkVJOUF0bjlsK1VFUklCckhKSGNK?=
 =?utf-8?B?N245UHdnV2NyYWl5R1dDTEVLOXIxNE9HTGsrUEhHeVI5cUpWUGoyVlhoMGZm?=
 =?utf-8?B?cHczTmI1WlE0cy9lOXZyckZXSlFNdmdhZGRwb1ZNQ0NmM1lmYnQ2dHoyejZ5?=
 =?utf-8?B?MExSR2tkbGlIZWQvT0k2WFZzY0x4d1FhMFlIbVM3TUx4bGJEU3lLcDhDbEQ2?=
 =?utf-8?B?eWx3bTZ5bVFnOEpkUkFyeVJOUjh2bU5UbDNnYUhLTXd3ckxXYmhPL2txZHVY?=
 =?utf-8?B?Z0txZDFFYVFiMDQ0eVFQbmJaOUJIWHYwRFdsbFA5czl3UTZEL3NxaHV3Qkpq?=
 =?utf-8?B?NHlyK2pDa2Znejl3b3lLRXp2MEhlV2JPcVJLVFRlUXY2NEVJMVlKYU9BcGFY?=
 =?utf-8?B?bWYzdWtadUtxYk9IYlhUOUNMZ2FZUXlDLzZqcTcvZ29BdXh6VXdjNXE5ZHFH?=
 =?utf-8?B?MHNJUVVYMnZuNkdyRE04ejRySWVaQnoxeitUT0pDbnozWnZ1Q3pycC9ZNG12?=
 =?utf-8?B?VENEcFllZk4rVEZGQjF2cUVLVnJyTzNvQjNOamdxRlFaSHBUWWtMOGVlNFJL?=
 =?utf-8?B?QW5HaFYzR25VaDRRTlkvOTZJOFlHeHNLb1IraGR1MUQzaCsxaFdnU2FRVWJN?=
 =?utf-8?B?TGVidVM5Ni9ZYnEySnV4WVloZVRldS9qK29aZENEZEtjNlZCMVhXUzMxbldK?=
 =?utf-8?B?eEJvNGFxTUM5blY3a1ViY1poRFNEdjR3WFE3dXhLMGNtOTZsVnBkSWtSV29I?=
 =?utf-8?B?MllCM0JZLzg2TFR3TnA2M1dBMlJpUDd0L0xoOXRZTjM0S2E5SHpDMEFZdkpZ?=
 =?utf-8?B?bzVwTzBOd3NLOURMSWxlWDJmM2RleUNqV0NkWm4rd0QzZVFDZUJuallBZmI4?=
 =?utf-8?B?d1Vac1gyRnFMb3V4NTlZb1FOS1VpZlRGNGszSjJJQXVxOWRKamVTVHhQaUYv?=
 =?utf-8?B?bkhFTFlmemY2WitscmlRTURNcFpDVlFBcFVzYTdNNVVDMzVVVnhnWHZmOTVi?=
 =?utf-8?B?SzZJVnRzdmU3RUFUYjFjb2dmczVYSU5xd2h3S3BOYXFBUWR4MU4wWUdQOHRt?=
 =?utf-8?B?SW5WcFR3eEo5alQrdm05bHJSY0NhbHNPQjloODBmUGdJYVJJanNMMUI3MG85?=
 =?utf-8?B?WHB4V2VtM0hucTVkVUYxQjFWUk9jUWIxOE9UbUREazBBQUQ0YVNmWmFQeWh5?=
 =?utf-8?B?T0U4SUZWUXJydDV5anh3SXBHK3ljbDd5K2pyT1NjMHFpbWx4dDlhdmorbmtp?=
 =?utf-8?B?UzIwbXp4S05HL05ETE13Rit3K3hpMEhialVscUVmRzBnNTM0V2lqWkc1T0Nr?=
 =?utf-8?B?WUNqTjFObmNibTJqZHZ3dEZnWUpKME52TzUzMHNOaThTL204TndyVExKRnFR?=
 =?utf-8?B?ZmhJZ0FHdlJZb05xTkp3MCtxLzZaekc4REtYMWVzTE5JN3NqTXRpSmp1dnZh?=
 =?utf-8?B?bU1wZDhxTHhZV3ZMMEdOSE51bTlHM0VJNWlEcmc5K2psRlNTd3VKQ2JBaEk0?=
 =?utf-8?B?U1pPR21kenFzRVhuc0xsUHRSUTJYdWE1WkkyVW5lem5DZTllWUtpZHpWanM0?=
 =?utf-8?B?V0w3UHh5MWVjaEFDTmZianZqa1NvYTF6bWw5K216UlNHMDdscWZvTTdiTUlq?=
 =?utf-8?B?QmxhbHhSUXRMeDExdnRuR2VpR0tQREZwU0poZHpyQmxqb0t1c1pSTUQ1VGM4?=
 =?utf-8?B?VWJzVkluMjRYTDd3WHBETGZWSmhwV0dzWXFNQ0lpb1pEdGtXM1JKUitTWi9u?=
 =?utf-8?B?ZDZIdTRxYW9ZRlZCZnVjWTRJa1kvV3NHWWQxYTE1dHI3Zk5tNGVKSThTRzd5?=
 =?utf-8?B?ck5yYjZyRnhGdk1pRTM0cWxXbHU0R0VFMUUvY1hUZUdtMEFDNlo0NUhBYWRO?=
 =?utf-8?B?dUJwUE85Y2JvUTB1V2pNbitXYkNXTVhOQTg2akt3NXhzWTlHZERZRjF6MmpN?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e61730ce-866a-4d40-128d-08ddcfa1f33a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:47:43.6008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHboAxHVEqs0fh/vfalwg4tTWx6x4XSCmcCND6+pUwuB+irbOouU9QJohofXTVHOGNIIyJmGybPYD+gNZYHotTPFYEsctsOJ5WFCwOlwxoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6422
X-OriginatorOrg: intel.com

Hi Babu,

On 7/25/25 11:29 AM, Babu Moger wrote:
> From: Tony Luck <tony.luck@intel.com>
> 
> There are currently only three monitor events, all associated with
> the RDT_RESOURCE_L3 resource. Growing support for additional events
> will be easier with some restructuring to have a single point in
> file system code where all attributes of all events are defined.
> 
> Place all event descriptions into an array mon_event_all[]. Doing
> this has the beneficial side effect of removing the need for
> rdt_resource::evt_list.
> 
> Add resctrl_event_id::QOS_FIRST_EVENT for a lower bound on range
> checks for event ids and as the starting index to scan mon_event_all[].
> 
> Drop the code that builds evt_list and change the two places where
> the list is scanned to scan mon_event_all[] instead using a new
> helper macro for_each_mon_event().
> 
> Architecture code now informs file system code which events are
> available with resctrl_enable_mon_event().
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Please add your "Signed-off-by" to the commit tags of the first four patches.
When you do, ensure it follows the expected ordering
per "Ordering of commit tags" in Documentation/process/maintainer-tip.rst.

Reinette

