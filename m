Return-Path: <linux-kernel+bounces-740146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38198B0D09E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FBFC1886D89
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190CC1A29A;
	Tue, 22 Jul 2025 03:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SiXXbxoM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408471581F8;
	Tue, 22 Jul 2025 03:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753156142; cv=fail; b=Ijar26doOak1CPPwl4p1mus+zd4SrXnLp8xEwlJnFjMjAQe5T6XZHuJv0yFsjRo51EZKdSv1ML4s28Ria76qG2GICMHFTc2P69zBt/EccHGt52mo5ZtDpkqOWjAuswugUTbSGQX3GbvzbQxnMFn82N90WI1JCezEy006b1QOa5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753156142; c=relaxed/simple;
	bh=xydyFnA1T3e4AT432cIV4RRxjbvRk1wUPBrEOju3Ax4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bzgQDXqhHtBnNB8HPbINVn5eQ1Zqsr34K3OFJbBA0RAtSkE6DkaQmXSzWrxZrroeqeQpaTKGlPGvjjbKbfKYkoNarHNnQUTHGT5sZYZiby4sci9ap5x4h7q/015DbT+ZceNOj+glWDIJw21F4sdV8oYV7lci0hWzWbW8OiZnjt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SiXXbxoM; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753156140; x=1784692140;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xydyFnA1T3e4AT432cIV4RRxjbvRk1wUPBrEOju3Ax4=;
  b=SiXXbxoM/z1SAhpwjACiSZFVh2UhQgeV84kZSGldfUuesa1iA0Bn/H9M
   D/ZyUzWAWVttm89mCVGiDjqeNcrAackycqkAfUkYWmbiyc1Qd4a2FSVIf
   /6zHQX98Z4HqgV/yve0nQxrdxwUwozslqtEZ1uJSb7qKrUdZAVLyjdzi5
   mashcGpRhFgWxxcJO/u5oZ2B6daNxI5PSmgA7KCdId+H5pKi0GAyYKqmi
   UcBPIe6700+vsKbChAWhyuT+1Qg5J45CGCnjRE4LrHPJ+LFRINfmgKSwY
   AjoS/GnMN4wD4/wiFwjGdMuiixaGd/QAintvhQxEOODJ68z6jfXg6iO5E
   g==;
X-CSE-ConnectionGUID: SC9iT6RpQPm9+B1/SCVaeg==
X-CSE-MsgGUID: qiP1o/eSQoOttGXiCIQq4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="65954335"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="65954335"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:48:59 -0700
X-CSE-ConnectionGUID: yL+mL7eBRlSHzu1DTvt0aQ==
X-CSE-MsgGUID: ZQmJPEdGT5uEP5VJBffT1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="159740282"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:48:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 20:48:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 20:48:57 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.81)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 20:48:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FK9nK1nvV3dh08OgO1/lDPX1i8Iw/jxOGG9af8ThTLBYEOJB0CbU+CtNthlGDmLzbBw0FHRhHYeTVGgUIqAzncHkH4RblYQ1fqgSSA79D1t7q8pQeHAc+bXbggXL53RwHx1RO0Q6SUJ+zPsm+DivXSsqgXQT270NU3+xCXXAElT2xKQ1mKWmqLKXUsx92ab1S+Gt4SU3ST1cpMt0syFYJM7fBvxI2s0MRlLoMBMDtw3ms2wcuol5KP3KcdQJzF2R7oUSrjohpjfmr92losm16ZkcUr7SkuNcotF15udpMCtGd0cVFT3FFVCf5sSjLRPzc/iRotanTpULMn2aZbYM2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYkd01jpb8yqKBddW721khxUlU9EuV/FpU9sCJexl8c=;
 b=LWrzLJLZLM/1XXWP2E8djyXpnN5CLTvEYauhzqvX2rk3zDu36/DpP8tePV1RRkutcDfrqu1ZCNXQ671Z+H/3x89llN/w9To/13PxdtkKHCXYVKMk1u9ci1jEfPmFTv1P6wbU+p/UvkGdoRkr7oyTcS8kmozzetCWTa0YIt0csNqKk+j0r6az8BxiioOL9QY8fEpMd4gSos9YpEFEsoC0i5D0B4Jq5mq5PmtDNG5DpvrBEHdwhLPDDYdeZFN5DN8MfNGRJHnkh5L/sCgPkaO/mab8fxYcWXmcj54B2bP2/YCKXJ/7mPx4g8EdxpoCSib5n+XWpDSa7kej+pCOO21Qzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7903.namprd11.prod.outlook.com (2603:10b6:8:f7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 03:32:58 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 03:32:58 +0000
Message-ID: <82045638-2b26-4682-9374-1c3e400a580a@intel.com>
Date: Mon, 21 Jul 2025 20:32:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/10] fs/resctrl: Introduce interface to modify
 io_alloc Capacity Bit Masks
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
 <a6f4ae3a709185e2c0904d53267e99e395a492ed.1752167718.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <a6f4ae3a709185e2c0904d53267e99e395a492ed.1752167718.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:303:8f::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: f2e5dddc-ffbe-4de9-f5ef-08ddc8d0742a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmc2K1pGTzNKNmZjWVRHYkxpVk1tdDlFUVE2MXpFZW5DTmJWZDlCeEhSeUo3?=
 =?utf-8?B?bnNUVEZlN1NzOVBpbzBDWEliWmNvRXdNSituQ2tOdlIxZk0zekN3OWExdTN3?=
 =?utf-8?B?L2hpUWdwSmtqdTRZSkprazcwNDU2U2JJSjNJd1pUTWtBUm9DVUgrQ01NQ0VZ?=
 =?utf-8?B?K1d6dHlCQXJ0cEpEQ0M3SVI2TE14SzcvUm5IVCtZRmZGQ0xhR1d1cDFrTTZK?=
 =?utf-8?B?b1JVWlhXZFZkSkFtay9mTmxoOXV0amdCNmJqWVhwVzVsUnJyTkV1UndSbldC?=
 =?utf-8?B?ZXU4eU11YmhuYjlvd2hCZHFjOGxjUDEzS2MwSjFuZnZSNTBqZGxtbFloanV6?=
 =?utf-8?B?V2kwZHBaOWl3NlBCcC9YVHJIeXRKMTk0R1dXY2xVR0JLblFZOCthZVVlK29R?=
 =?utf-8?B?T1ZWWVJiMVJOUnU3K1RpQ0JIaUJqcGRBUjBCbnEvWkNxckM5NWdiTld4SXUr?=
 =?utf-8?B?bHo0VkZyVEM5eWdUSVl2bXVuSTZWa09oaUVvMEwzdjlyb2NVdEhZbFU2T1JC?=
 =?utf-8?B?YVlzRnNWSXZNU01Vekdsay9tUnVLSWxCVHRvclk4bFVzdjRSaStRTUdFZVA3?=
 =?utf-8?B?d3ZydkowL2thUXFZZlhoK0FzRk9LeHQ5bnRjb09pV1NCdnNzSVFLaGJ5bXh0?=
 =?utf-8?B?blFLVVQ2SllXUTVodlpKU3IzcU9uM3JLaGorSnlvYjBYSzhHSVVoY3BCY1R1?=
 =?utf-8?B?VitiYWRiNDJhdklzOVZJeXFNeXdNREVYS25SazNpdU1NS2x0WllJV01wbFY4?=
 =?utf-8?B?Zk01M25idVNWcXZnSlcvNlpSb0dXWWx1dGYvUnlKN0lONGVBb3FRc3I0Nmhm?=
 =?utf-8?B?QndNUHZPVFhvaWhkSzNTUi9PRWhiUkdLdXFGQ3p6R3c5c3hRY0JBOFlVTUFj?=
 =?utf-8?B?OGExWFRveEtOZnEwWXE2SUVyb2pxamwzSGVtVTlzT0Vja2VUd2tkS2NhSjhj?=
 =?utf-8?B?S0tvdFgrcFBLNVo5NG4wMWVFRjhESVkyTVV5bnN5TS9JNzZSOFJWT0tJOXNI?=
 =?utf-8?B?SlhlQ1dKU0FyRGdTYmNVNUpKNitwK0V3dFB2MTZ0Rk9KTVFOTkNYRldRV255?=
 =?utf-8?B?dVZSYnBVYUtjRnpqYnhsZFVpcEhhOHd4aFdiVTF3WXBlT1hYZ3pCNHgyb3Mz?=
 =?utf-8?B?UG8xVmc1V2pPSFAwbEIyTzZWV2lJdHViblRVS0p5TEcwKzZUY1A1YnVzZGZp?=
 =?utf-8?B?VWtWeU5lRVIraDhqT1BMdG85MGZJSzdubWhRMWVhcGVRNWZOazBjM3ZhcHpQ?=
 =?utf-8?B?Qm5OMkFiL3dyYVF2Z2UzL0pqT1l4ZzFGczc4WVM2dXFhenFiaHZ4QXloRHdB?=
 =?utf-8?B?VEhXZm5UUHh0OFNGOVZTN1hXVWg0QXZiRFZUZnFSRjVrSzZGOFJXM2NEWm9C?=
 =?utf-8?B?dlEwNVRCVHVaTHY4VUFlMTJRTThpbjNZSFRramlvR0ozTFVsOE9sRnJJOFNC?=
 =?utf-8?B?VWNVOUJLUGhIN3ZKY3NnRmU1SVpiR2xLdGhQN2pZVjJSQkV3VzMvcVZTL1pP?=
 =?utf-8?B?WnNWZGxYOXlBT2haVW5oaUp0OHhVRFlQWUJUczJJVkkxNnUzK2E5UTNndEpo?=
 =?utf-8?B?YldmSk1IbzlnQ3JGaTg0WHNkdS9JZVAwNitDS0pwTHZpd0hlSjA0cDVMdVkr?=
 =?utf-8?B?RmdJdi96TXRXZW1HSkQvM3FDTVROSnArc1dGSHpuUTZLTmVKOExzSWhkSGNk?=
 =?utf-8?B?Q0xjblppMFRwclNNZ3pNV040bzAzcnh6MFhVMVVkdnFPOTVtTnk0UFRta3dy?=
 =?utf-8?B?SlA4NzgrcDJSUkNRdGd2dE4vcVJVT2ZzL1pGOFovUkZKRWMvOVBvODNISVFI?=
 =?utf-8?B?OWxNUEJUTGVadGxKNDV6clVZRmcvY05kcTZpc2VSZ0p1eWo1Z3BUZWc2OVht?=
 =?utf-8?B?YXZ5WmpjV2NtZ0V2UStSSHJDdDFPMHpHM1JYZjl4a1duWTNUK0tuaFdmc25a?=
 =?utf-8?Q?oCKVqUOsq1Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1FDU1g1TlMzMFpsa2daYk03dGlvYWQ4NXloWXN6MVRlZjE4Wmx4TGZvVjNh?=
 =?utf-8?B?ak13UHk4UG16ZzJuN1VTNkdvSnYvR1JuMHZzVHZkUzY5SkFDSWZmajFQOVZC?=
 =?utf-8?B?UThLQUl2aGZvT20wNHlvUnp3VkVEUHBhQU1GVzFrRDBaTytucjl2eXp6UkFj?=
 =?utf-8?B?bFBZcGdUR2NSZzNPcFpHMnZVWFkwb0xNSkRlM20vME5PYTN0L2w3Wjh0eUIw?=
 =?utf-8?B?ZjRpbmFQNTh6VW5KdllKMWl1blRqaHVmUjJqa0JYZCt3K0lzSXAvZVNWNU56?=
 =?utf-8?B?c0xldGViSnY2WXM3SUNycm1hajV0b1pEaHczOTR4dmFiZVk5QVJtWFdtYzFh?=
 =?utf-8?B?d1QrUjFlcjlaOTdjZU9wS2FzeVVzVWJYRHVXNG5Zd3BnU01lL2FhYzRjUXZt?=
 =?utf-8?B?cjlNT2ZrNlRtak83eHZpM3pkNG1RSVJlbmwyaFVpY1U2T2RJMGpIclZKRUlP?=
 =?utf-8?B?N3V2V3ZHQU5qSU9ncXJOTkcxMEY3RVkwVDV6VzNMOCszUlk0N2c3V2h4ZnBo?=
 =?utf-8?B?RWFGTkY1Qk1lK0xmZzZ3R0wrMnFMZDE5enJuR1FRVEJHZXJVelUxTnA1VGJ4?=
 =?utf-8?B?VVROVnhTOWdrY0lzSzRBK2ZINERscytzbXZ4V0szd0xOb2ZycGlQZ2U4S1Mv?=
 =?utf-8?B?L2VXZVlIRHhPaUE5QWh3SmpDa3NkZTZrZGZMOG1hOFZWSlpINmkzWjRQdnZW?=
 =?utf-8?B?UDBWSTN3bmRnR1lzR3RVYndOYnR1UVpTaXhsQ0lCdi9HNk5wYXJ3MnZlTmtP?=
 =?utf-8?B?SEFzS3RHcnJ6ZkdSbzhPYlFwblhsRjZDaWZkczlrQmRiNWVaR3MzV0hXZWYv?=
 =?utf-8?B?RGxNeWQzcVlCTzkrd1YvdGN6TlMwR2lyMVJKVWdqMDhlb1FRbEhSYyt5dVVF?=
 =?utf-8?B?NVlveXNxVkM3bGl4V09PZ2JZT3lSR3VOS3BhMVdDbSt2eFVrS0g1VmJXYnBQ?=
 =?utf-8?B?ZVBTQ1NxNlZGN2psQm9TOFYycFdHeGx3clNFV1EzM3RvWEVxSVFSeVpKekY5?=
 =?utf-8?B?L085RHJUQWszNnhGWEtUbzVtaitwQ2FnK1pBTTBEZXRUV3JMM1hGZUlHdzJH?=
 =?utf-8?B?c3RzTW1DZmdyaFhySnZLaFI1Ly9mM2FTQ2RGRjk5eWlHd0lOb202MEtQM1Yy?=
 =?utf-8?B?Z1pLZXZ1MktnSk54MVhhK2tQT0tySEFPdmwzNUJYeU9aRkd3OE1TMnRlb1NN?=
 =?utf-8?B?WElsY0xxZFZHLzFIT3UrUFNhYWlPSnl0dXA3WGc5TjNScDdOVmRVWnVUbzlL?=
 =?utf-8?B?YXhLRm5DaHN5Z2F2elZhdzlPRnBZTUFpbndoOU1KUlYrNjZ5R3hRUXF2bWlu?=
 =?utf-8?B?SjdhS3lER1F0em1VL3RmWnoyb3RiT2FkTFJSRng3NkpYcmdlZmVYZ1NmdTdH?=
 =?utf-8?B?U2N6WUdDSGdiczFac0ltTmQ5YXV4RzBkSkFrWmY0eHNUR0thbDVGcjZVbUE4?=
 =?utf-8?B?MXFkY2cvQWV6S0daTXI2VklGcUYzTFFTdzR1STUwVElsbjlUM24xeHRVNld2?=
 =?utf-8?B?aFh2c3JJZWRMMXIyL2pldmYrRDZremowREJZRS95SUpKRDROUWFyOFBuWEwx?=
 =?utf-8?B?dVZFOFBuSlcwbmFsZHpBTmUzcjhoRzFrOTBiRlJXQWtpRFZVd3Voc1VYZjhu?=
 =?utf-8?B?ZWovZ2ZYTFZTajFab0VWcEN2T0xweEY2WGRjK0tqVGFvU0xKTDY0MHdSd3Nu?=
 =?utf-8?B?TzFpWER4Wi92NDhOQmI4bUVLTGRzTzlSSThkd1c1WE5oaDQyUTN2ZW1RUlBa?=
 =?utf-8?B?djVPREdsdXd1U0pRa0VGTUpOZFVHYUU1RWoyVkh5R1lsd2k1eUZXMGV0bXhi?=
 =?utf-8?B?V2l4K2JkdFJsUGtSWTloZythZkZoWWJLbGtwWjlYdS96UWw2Q0luQS85RjBR?=
 =?utf-8?B?N1l1SWZMa21EUDJFWEZlbHYvaHk4RWo4cHFCYVQrd2VHK0xsSEs5NEpTV2JQ?=
 =?utf-8?B?MllWVHJuRGVLYW00cFc1SDFKd0pBa1ZtbnhEOFhMOTA3OHlTTmFCMytUNnU0?=
 =?utf-8?B?Wnp0L1ZXblVkbjN2N1RtVnhjQlpWckxoL24zSWZSZWhxaUJZc3N2WmxqK3Qx?=
 =?utf-8?B?NmszcHVCckIwV2x0bkdWZ3pJR0taUm8wN09nWXkxRklROTVrU3VHN283NEc5?=
 =?utf-8?B?MUtqTnBubWNkeFRDRXl3Z3pGTEtRMGRiV3ZNSWlXbElZVTZsTWtmZ016Nlgz?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e5dddc-ffbe-4de9-f5ef-08ddc8d0742a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 03:32:58.6174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+dXOPRGXiojPPtU1OVhxIvL4JRUawTDnybAdvPEx6uhTdJGg+2ifzDxsRntb77htfdDgmPQTQgf8i0q3BmqRgwYitaWLBcHP/IA1/Yfdvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7903
X-OriginatorOrg: intel.com

Hi Babu,

On 7/10/25 10:16 AM, Babu Moger wrote:
> "io_alloc" feature enables direct insertion of data from I/O devices into
> the cache. By directly caching data from I/O devices rather than first
> storing the I/O data in DRAM, it reduces the demands on DRAM bandwidth and
> reduces latency to the processor consuming the I/O data.
> 
> Provide the interface to modify io_alloc CBMs (Capacity Bit Mask) when

"Provide the interface to modify io_alloc CBMs (Capacity Bit Mask) when feature is
enabled." ->
"Enable users to modify io_alloc CBMs (Capacity Bit Masks) via the io_alloc_cbm
resctrl file when io_alloc is enabled."?

> feature is enabled. Update the CBMs for both CDP_DATA and CDP_CODE when CDP
> is enabled.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> ---
>  Documentation/filesystems/resctrl.rst |   8 ++
>  fs/resctrl/ctrlmondata.c              |   4 +-
>  fs/resctrl/internal.h                 |   2 +
>  fs/resctrl/rdtgroup.c                 | 112 +++++++++++++++++++++++++-
>  4 files changed, 123 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index c22a9dd667cd..b9c3ffdec27f 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -189,6 +189,14 @@ related to allocation:
>  			# cat /sys/fs/resctrl/info/L3/io_alloc_cbm
>  			0=ffff;1=ffff
>  
> +		CBMs can be configured by writing to the interface.
> +
> +		Example::
> +
> +			# echo 1=FF > /sys/fs/resctrl/info/L3/io_alloc_cbm
> +			# cat /sys/fs/resctrl/info/L3/io_alloc_cbm
> +			0=ffff;1=00ff
> +
>  		When CDP is enabled "io_alloc_cbm" associated with the DATA and CODE
>  		resources may reflect the same values. For example, values read from and
>  		written to /sys/fs/resctrl/info/L3DATA/io_alloc_cbm may be reflected by
> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
> index 5c16557fb7a8..23c72a5ac043 100644
> --- a/fs/resctrl/ctrlmondata.c
> +++ b/fs/resctrl/ctrlmondata.c
> @@ -148,8 +148,8 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>   * Read one cache bit mask (hex). Check that it is valid for the current
>   * resource type.
>   */
> -static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
> -		     struct rdt_ctrl_domain *d)
> +int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
> +	      struct rdt_ctrl_domain *d)

This can remain static by moving caller to ctrlmondata.c

>  {
>  	enum rdtgrp_mode mode = data->mode;
>  	struct resctrl_staged_config *cfg;
> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
> index ab76a1e2e679..011564e69ed5 100644
> --- a/fs/resctrl/internal.h
> +++ b/fs/resctrl/internal.h
> @@ -382,6 +382,8 @@ bool closid_allocated(unsigned int closid);
>  int resctrl_find_cleanest_closid(void);
>  void show_doms(struct seq_file *s, struct resctrl_schema *schema,
>  	       char *name, int closid);
> +int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
> +	      struct rdt_ctrl_domain *d);
>  
>  #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
>  int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index 008657e43656..1093ec5e385b 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -2036,6 +2036,115 @@ static int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of,
>  	return ret;
>  }
>  
> +static int resctrl_io_alloc_parse_line(char *line,  struct rdt_resource *r,
> +				       struct resctrl_schema *s, u32 closid)

Please move to ctrlmondata.c

> +{
> +	struct rdt_parse_data data;
> +	struct rdt_ctrl_domain *d;
> +	char *dom = NULL, *id;
> +	unsigned long dom_id;
> +
> +next:
> +	if (!line || line[0] == '\0')
> +		return 0;
> +
> +	dom = strsep(&line, ";");
> +	id = strsep(&dom, "=");
> +	if (!dom || kstrtoul(id, 10, &dom_id)) {
> +		rdt_last_cmd_puts("Missing '=' or non-numeric domain\n");
> +		return -EINVAL;
> +	}
> +
> +	dom = strim(dom);
> +	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
> +		if (d->hdr.id == dom_id) {
> +			data.buf = dom;
> +			data.mode = RDT_MODE_SHAREABLE;
> +			data.closid = closid;
> +			if (parse_cbm(&data, s, d))
> +				return -EINVAL;
> +			goto next;
> +		}
> +	}
> +	return -EINVAL;
> +}
> +
> +static ssize_t resctrl_io_alloc_cbm_write(struct kernfs_open_file *of,
> +					  char *buf, size_t nbytes, loff_t off)

Please move to ctrlmondata.c

> +{
> +	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
> +	enum resctrl_conf_type peer_type;
> +	struct rdt_resource *r = s->res;
> +	struct resctrl_schema *peer_s;
> +	u32 io_alloc_closid;
> +	char *peer_buf;
> +	int ret = 0;
> +
> +	/* Valid input requires a trailing newline */
> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> +		return -EINVAL;
> +
> +	buf[nbytes - 1] = '\0';
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	if (!r->cache.io_alloc_capable) {
> +		rdt_last_cmd_printf("io_alloc is not supported on %s\n", s->name);

rdt_last_cmd_clear() is required before any write to the buffer.

> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	rdt_last_cmd_clear();
> +	rdt_staged_configs_clear();
> +
> +	if (!resctrl_arch_get_io_alloc_enabled(r)) {
> +		rdt_last_cmd_printf("io_alloc is not enabled on %s\n", s->name);
> +		ret = -EINVAL;

Inconsistent error codes when io_alloc is not enabled.  resctrl_io_alloc_write()
and resctrl_io_alloc_cbm_show() returns -ENODEV.

> +		goto out_unlock;
> +	}
> +
> +	io_alloc_closid = resctrl_io_alloc_closid(r);
> +
> +	/*
> +	 * When CDP is enabled, update the schema for both CDP_DATA and CDP_CODE.
> +	 * Since the buffer is altered during parsing, create a copy to handle
> +	 * peer schemata separately.
> +	 */
> +	if (resctrl_arch_get_cdp_enabled(r->rid)) {
> +		peer_type = resctrl_peer_type(s->conf_type);
> +		peer_s = resctrl_get_schema(peer_type);
> +		peer_buf = kmalloc(nbytes, GFP_KERNEL);
> +		if (!peer_buf) {
> +			rdt_last_cmd_puts("Out of Memory - io_alloc update failed\n");
> +			ret = -ENOMEM;
> +			goto out_unlock;
> +		}
> +
> +		memcpy(peer_buf, buf, nbytes);
> +
> +		if (peer_s)
> +			ret = resctrl_io_alloc_parse_line(peer_buf, r, peer_s, io_alloc_closid);

Similar to resctrl_io_alloc_write() this looks unnecessary. I think this can be simplified
by moving the CDP check to resctrl_io_alloc_parse_line() where the provided CBM can be parsed
*once* and the staged config of a CDP type just copied to the staged config of its peer type.

> +
> +		kfree(peer_buf);
> +	}
> +
> +	if (!ret)
> +		ret = resctrl_io_alloc_parse_line(buf, r, s, io_alloc_closid);
> +
> +	if (ret)
> +		goto out_unlock;
> +
> +	ret = resctrl_arch_update_domains(r, io_alloc_closid);
> +
> +out_unlock:
> +	rdt_staged_configs_clear();
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +
> +	return ret ?: nbytes;
> +}
> +
>  /* rdtgroup information files for one cache resource. */
>  static struct rftype res_common_files[] = {
>  	{
> @@ -2135,9 +2244,10 @@ static struct rftype res_common_files[] = {
>  	},
>  	{
>  		.name		= "io_alloc_cbm",
> -		.mode		= 0444,
> +		.mode		= 0644,
>  		.kf_ops		= &rdtgroup_kf_single_ops,
>  		.seq_show	= resctrl_io_alloc_cbm_show,
> +		.write		= resctrl_io_alloc_cbm_write,
>  	},
>  	{
>  		.name		= "max_threshold_occupancy",

Reinette

