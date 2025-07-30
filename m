Return-Path: <linux-kernel+bounces-751299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5CCB16769
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D4517A589
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87CD20E002;
	Wed, 30 Jul 2025 20:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Asx3+4qt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7C219C560;
	Wed, 30 Jul 2025 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753906176; cv=fail; b=ffwBv3J+/qgIQ1+hMg5qEpCk7/hmQDdQUh/i4VEuncjJqVYOtDGj7oHP3j6NuWrCS7Uds0SzfG9dDgz0uFkSWNI40t7LTffCy2K0jjEbrej0STVVIK6fx2rTSOQs1p292U38P5JohgCTaiXUMCfXOU9lMbhN+v4VuRLB0OohBPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753906176; c=relaxed/simple;
	bh=t3Od8dYYokWDe2vXz3wYAZc0R1qUJ9UUmTr09w9WHw0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TsGC1s86ioB7GD/BjQoVdYJYnsNL0JD+ENNRcz4yKmM/xb7uAdkqs9FH8d45m/+TRqeXFK4rp1JoNehr820YruZTKx6lrO6o6frOVCRE88OB/LCUnzzg3xiQM44Lz4SwBOIqX0DO6ab3L7rMwX1bbqyygiWci5BriMqmAQwt7t0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Asx3+4qt; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753906175; x=1785442175;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t3Od8dYYokWDe2vXz3wYAZc0R1qUJ9UUmTr09w9WHw0=;
  b=Asx3+4qtfuTBZ2DuvCsteHbskZ7t1Zj27ci22K9mAgIuJyWOAhtaa24h
   uCJwtHgJtoxOaiIVU7Q5uUXjh7mLe/RN1pSXeqlGFPsdV+Jfg2HEtnTvS
   gf4UbDj7bxPLAwESUINYXUNgTE38ZHDTdavhNWxJVswiL5ZMGb4Cn3QuD
   BtN1dKgwMLUXdhesHHpp2I8Lsp9prbOZGURwzhutz8NdkoXgP6UDXvM6I
   PO3WWe/04cmEeQUEVBBBD4JvwMAZFWRW5ltZUIlS9V80XxuE7ycEYO2Lx
   qeQy86UvdYV/HXWlQYLZ1d/5+3cduhq+SA0srd/13Iy/W0gAs0+mNfLFX
   g==;
X-CSE-ConnectionGUID: dpVyJn8sSh6sETgbNL6DGA==
X-CSE-MsgGUID: 2P4e88asTzmmctgYUS+uiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56185756"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="56185756"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:09:35 -0700
X-CSE-ConnectionGUID: O1DtCkpkQF+6T3aKM9YS8A==
X-CSE-MsgGUID: v3muW8BwQgizzo0LX9BFGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="200243655"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:09:35 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 13:09:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 13:09:34 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.58) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 13:09:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuW1n3/I0DDJKlpOjXUPmXrG8RZ2H4VceIdc7WKhx7xXNp1KKk/aQDo8GC48FzC7tcW14xA+wxxhp9hHkKhNtm1Q9bPlrJz53lmWgrVhMFNyZm2PKrAR/VnvVpLTTeHPTDGXNUUp5Nbb+WzgCFy8MUeA3j3gBMcqAcDS1gEgY7aCBjhgs4NFS7DNqJYFuVTRGHrhnF/ngRjg0spU5elJyrA35zb1eMMPay3aI5YMPwOD/1gLUJzGI6xOym+X8k/YsT2bKoDL0HoSW4i17Miz9ieP+yCCrbs8RCDbkhhXl/UaQe59EKp51O+oF6waoP84KoR+dekdKsWQ1Lp5bxy5gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9xz83cG621kZNC7WeFTBM8Z/VoxKrG9qLCz6sPv4Gg=;
 b=QdyiHTMGdkl2IMUbSz5YCwSQPFuUok1iRMGnX0SHi2Zo5HRKIs8L3P13ccN1WSFPnR2nIR6bbHhZ79EJLRfSqKwWkvtpC4oHXK9w/2DpymDwP+cFQ322McNpc/7oi4ClBiukAzEJiArLWQrqzC0EYeqpdiL3S7UxtI+8MrBXDdPCDuj8qHDOgtf8Q8uI0R3jk0ukydmx8GJ/dGvwDzrEUili+TesnHqod03TuQXx+/Zq2A7nAdAFN70ejjqGO35mKUklrVkG7S5lKSa7ohTxPbb4aDQ+WIHCm1TyA4SBQ7gag8FOoXFNblNNuENy2kxiHDIk91kc2J9CbslBhgCdFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB4993.namprd11.prod.outlook.com (2603:10b6:303:6c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 20:09:16 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 20:09:16 +0000
Message-ID: <68bd82ec-854f-4325-a892-5deae2fa7720@intel.com>
Date: Wed, 30 Jul 2025 13:09:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 29/34] fs/resctrl: Introduce mbm_L3_assignments to
 list assignments in a group
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
 <1a031e141affd6dfb8693de5a0bda83f3cf4a330.1753467772.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <1a031e141affd6dfb8693de5a0bda83f3cf4a330.1753467772.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0277.namprd03.prod.outlook.com
 (2603:10b6:303:b5::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB4993:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c69c58b-c090-41e6-d044-08ddcfa4f575
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnpKZnNiK0Q5WkUyT05RRWE2cFRic0FlZHBmbkR1RHBGT1hPMWNqbzRXeHNK?=
 =?utf-8?B?SW1vQk85Lzg4ZWJSMzBQUE5QOXNwWkpsRnBxaWY5cW9kN1NucVdMNHR5c1Vi?=
 =?utf-8?B?NEFNS3NYWFhjQnRJSHdVVUFXNnpQV2hKTlBia3ZMVTcvd1VTWGR6RXNhZ1hp?=
 =?utf-8?B?RTN1a3BEWldCS1dDOElTS3A2RVNtYW1zZ05nOWFnWnFHQ0ZoMEFJbWg1M1JV?=
 =?utf-8?B?YmdEV0NYcUtaRHJnVnhlTy9BSkhhamRtR2RlZ1V1VlZmR3V5eFV1U3BITk1v?=
 =?utf-8?B?UytOL0FhMnNmSUZxTHV2dGtFbDljQzZsVm1raTVhL0EvRFRTSDlyclZYSXhV?=
 =?utf-8?B?R0NMN09UZU9WTG1NMFVYUVpaU2w0Y1JVTndaRjF6Nko2RFZHN20wMUlCYjFs?=
 =?utf-8?B?MzQ5S01oL2pneUt4MjhvR1RDbWRJTlpxcFB1V3BxQXFOWVVGNTRDRngyQlJN?=
 =?utf-8?B?aWJzQXhRTXhZdDNyS2pUeFNWS2hYRjFYb0NlWmNHVVczbVh0U0kwMHorMzh3?=
 =?utf-8?B?Mkg2TWlOS2d0NWdabU12VC81SkJQdzBMVC9JczR0V0pNSWxGVE14NkNNaUxC?=
 =?utf-8?B?MStnMnkyWmFERHJHa2JNK2V3YzE5MG05Um1aQkVYY01oSUFwT2JoUXNwcmpH?=
 =?utf-8?B?U3hNYjB5UGo5aXRJb2RKVUtBeUdQTFBPaDVnME5iNEIwYjFGNjBuKzFZYU9B?=
 =?utf-8?B?SHdXTCtsQjVORG4xdEdmOStKREFvSUYwSVNUa2NkTG1vbTBYYm5McmVuV21o?=
 =?utf-8?B?SjFCWWUwVGR4VjZkdFU3Qktpb3ZwNS9kbU53c1ByRHVyNXlFbWxwa0NnVFkx?=
 =?utf-8?B?dmx0NTZONDd0bGlMSG9JOHJwdm8vdHRyVEFBVTV6Ni9ZQ3Ywd05FcEx2bkxm?=
 =?utf-8?B?ZmlBQU04Yk93a1E5d0VpbHZuREFRdDhhazM3bmhSWmJCR0pxTDBkb2lUU082?=
 =?utf-8?B?a3dVdWo3cDJIbmpBcm9LeURKMWNvVjQ2SEtDMFBjWldTS0FPbmpEaXNLS3d0?=
 =?utf-8?B?aXRDbnFSOVBuNWY3a2tQdnpidkFhcXE5Nm1GUjY5bUZBbDdSR3RGN25zdlhC?=
 =?utf-8?B?R3kwbXNMQVJxYXVoT094bUkxT0NiK3l5bFRwNnRteXh1YVZZVG1xanJhZlo0?=
 =?utf-8?B?SHE0aXR5by9pWUVVNG12aTQ3TlJHajBUYldxeERMYXpOcm1RMno0M0FQU003?=
 =?utf-8?B?NnJGNmtZQnJxRmlhbS9uSkN5L3c1Vzc1c3dFT3hoQXZqUWJMeVZvT0RRYWJx?=
 =?utf-8?B?SlhxMEp4QjE4TzJ5WHZWcm1zbTZHTEpBWTJacDZlc0dOWk80azZXRjlxNEpN?=
 =?utf-8?B?cUc2VXZmUDRjU011a015TFpwYksrQVZUSko5MTVjVFAxNDRZRE83QkpCaUxV?=
 =?utf-8?B?YjJjRlZzSzFyakxnQ2p4UHlKMDNUcVNWbE5SOW1aeEdocmwyMFIzU3FBR3pB?=
 =?utf-8?B?S2xwWURhc21PSENyUS8wWk1xZDZjeWh1bVhXZGRZTmJ2c0FKOVg2bE0xS3lU?=
 =?utf-8?B?OHB5ZlRhTCszVTVxREp3NlJVQkx4YlhQcHgzSzU5THhLQ2lIcDJ6ZnBQc1Zt?=
 =?utf-8?B?eDREaU9OSysxWUlDdjIwd1l4eXljVUZKTjRjM05jUE1kS1ExUi9TT3BDQ1ha?=
 =?utf-8?B?UTJucmFqdjlTK0lIYlkvaWRUdGZ0K0h6dDcyc2FWTHY1NStZNE1PKytjMDQ5?=
 =?utf-8?B?bmlRb1R0RW1uRmUxQjlybDlaZ0pSeG9GZlN0Yklid251cHFyWWw3T2ZBRUs0?=
 =?utf-8?B?Q2UxRWdqWUE4cTBFb0N1Y0pJV1R2U2VtdU56TitQenFqamQwOGowbGNJcmUw?=
 =?utf-8?B?dXNwcGpXVldlMG9FYTZ1TUl6YlF4RHhER1N6TklSbC9mVzlENjhoTlQxL3VX?=
 =?utf-8?B?TnF3NEJnelMyV0d2WkU2blQ0cFk4TXd2NTRGMldPbVNEUEUzQjNOZ0tXc3d0?=
 =?utf-8?Q?zLvI3gfw5mE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkJ6Tk55eEdYUjFpQUxRM1FSTHNJbnNHNmFvUkZuOVB2TFYxSTE2OHNuMEJy?=
 =?utf-8?B?V2NyMzJjbytaOVBiZGR6eUtTZ3hMQjZsNmFaVmVhYmd2dllzRkVrY05DV0tN?=
 =?utf-8?B?ZDc3bXZ5TjFENy9QZE5RV0lDRE02M1UwS3YreVZCZHJGMEVtS0h6d2pBelBa?=
 =?utf-8?B?L3R0UUZaeHhEWUFoSUpwTFhWamFkSzA5S3RIUnUzRjhBbE0xOEI0Ukp6dThv?=
 =?utf-8?B?Y3VmVmNJVmtnM3FrWEEwZHFiSGFIRWpqK0Y3d2NkL3RsTnFWMDhyZzJONjdt?=
 =?utf-8?B?M2Q2RVZJRDI2RE9Va0VZUlQ4K2F4b29ZSXFSeEU2cXRJYlpYUytRVk1BckFI?=
 =?utf-8?B?UHVSLzhBR1VZalRkeEdWdzE4Si82WkMzRnk0UXVWWGs3Q0xjTFJRMVhIYnUy?=
 =?utf-8?B?a1kwVFRpSzFsK2F0ZytUaUNIMVRDbjJFZ1VMYlFSRnpIeURqVTlYV3B2eTRh?=
 =?utf-8?B?SzhQb2wxZklOQ1ozWWNZSlRCOWFGSVE3ZnVZcWw5RFVWYm9PRG9uSnRFaDhP?=
 =?utf-8?B?citWbE9mbGN3aW9XNXc3UVJZanpvcVRubUE0Ym43NWtUTVo5NU5wWGdWSjF3?=
 =?utf-8?B?U2xHNmFjRGNpQ2lzbnpEcGNkQnFZWjdnL3g2UTNtMC94ajlKdXpuMnJFYUps?=
 =?utf-8?B?ZFBPZzJWU1lBMU9RVmx1WkdicjRzT0F4ZDJYM255MVJRTk1XbWgzY0puMVB0?=
 =?utf-8?B?YUdHYzhsa00vNXRYQml2QnV0NHVsVmxzb21leGdDNzJrdXpKU290UFZldFVa?=
 =?utf-8?B?TnlkbDJkWTNnSTJkRGl4MnYvclpVY0hTUHd3dUVSdDZqN2xkSTNyeExKa1JH?=
 =?utf-8?B?M3hLc1BLRmg0cCtMQ2psdEpDN2Z5ZGdobmpvZmozbE8xTlJuY1NJNkFKYVYy?=
 =?utf-8?B?ZjMrTmNRVERuN01jNGhNNW8xV3hlVnpob3F3L3NydnpGZU83bjBzTmREdDZl?=
 =?utf-8?B?S3d5b25KaGVkZ2QxZHh4YzVFVHVuWjR4VEdURDVEblc0NnNockFJMUhxVmVN?=
 =?utf-8?B?RDQrUFFTbDk1aTdTY3dUMlhEU0ZaN2Zpc3ZOQ2NmV1ZrM1BOYTRtQkcwYmg2?=
 =?utf-8?B?WkpLV0kzSlZ0WEhETGl3QUo5QnNXa3J4VDVoekkzaUZ3RWl6WEtnYUxwV2h4?=
 =?utf-8?B?bUtFN2RiOC9BbTdsMkNNSlA0T3NpdmlFeXFmU25oRmpYRmJ5Tk81L254Vloz?=
 =?utf-8?B?ZXArcldsVHNkTVIzK2l0dTZJUDRkbmZOM3ZiWWdhRjQ1L1AwaDJKdXU5NWdR?=
 =?utf-8?B?ODY5bWNRa1pqZkdNRFlWdThQNXdNQWdWckdhaE1yUkxQYXd0QVBUODZqaGdZ?=
 =?utf-8?B?U1MvT2ZLUGRUN0h3eExtckoxejJBWGQ0RVZxT1lZSmxGZm9PZXZTMDFqWXo3?=
 =?utf-8?B?bnBwT0xkTGUxd1k5V3ZzRXlCK0MvSTdLYkhzc2RrZ3BlMElOeUtzOVY3ckZV?=
 =?utf-8?B?MWljeGhZMS9CRnR0YlAveDVWRHRLWitQSVkwc05lRFgvZHNibndNeTVRVWFW?=
 =?utf-8?B?aHU2bGlXVjhFeFZCcVRHVVpIaFVPZ1FPQWF2YURobVV6bzVTVThnL3REdXAz?=
 =?utf-8?B?cldBY0EwMUN2NDJoazNWeUlBRmMzTjEwTDB4THBvZWUwdG5pSW1KeGI4TXR5?=
 =?utf-8?B?NVZGYTFnTVJsWUtyVmE3ano5cHphM3Yxb1U4Zk1EbG9VTUt1WnRFQ2pDNitT?=
 =?utf-8?B?d2VCOUlEVW4yOWZzZ1pHdkhab0tYU2c0VkVJTmdQMldaMlpKN0RXSkZHSHFi?=
 =?utf-8?B?U3BhQmpPdy9PUmx5L3BwSEE5TFZtMzBTbElZdWtYN2pFTGtBNU1peTVDTHBx?=
 =?utf-8?B?ZGJNNnltMmlsNWRLOUNXalhLYjd2eGZ3ZCtxOGRVQVFidHVPYmZ4RzNwcXhJ?=
 =?utf-8?B?bGlPeVFPdUFYakQwNXk1MW9IZDRtTlROMnFwMEQyV0JiYTFoS2Qwa3kydjBn?=
 =?utf-8?B?Mkd5aVNPMEFGbWV0STR1M3JKUHpDSVpDL3R2REwxUmowWmkvVHo2S0JZU09O?=
 =?utf-8?B?a2VsWUU4bkFFMGtWY0RqRlUxV3ljZ29KM1FGKzZES0hvd043c2d0V1kza2Rr?=
 =?utf-8?B?eG4zTkJsZ2NyUWRtK1c5ZVBCOWgrQUZuK0wxSG9GMGxMdTN1cno2YjhSQ1cz?=
 =?utf-8?B?QkZkU0pzSlI4RWViQlNwVTdoakZOY09RazlkeUhmdWJvMTBISEZZNFpZdHhu?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c69c58b-c090-41e6-d044-08ddcfa4f575
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 20:09:15.8787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: luQKpMWA1maYPmxg58PtL9FhstWASWzUi+3b6/yGawiu5F/RiOonqKZTpBRnCQrX70L6yxXPAc+Hxh+j2u92Vu40i0Y0M+dWqAFHYDwTQKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4993
X-OriginatorOrg: intel.com

Hi Babu,

On 7/25/25 11:29 AM, Babu Moger wrote:
> Introduce the mbm_L3_assignments resctrl file associated with CTRL_MON and
> MON resource groups to display the counter assignment states of the
> resource group when "mbm_event" counter assignment mode is enabled.
> 
> The list is displayed in the following format:

needs imperative:
 "Display the list ..."

> <Event>:<Domain id>=<Assignment state>;<Domain id>=<Assignment state>
> 
> Event: A valid MBM event listed in
>        /sys/fs/resctrl/info/L3_MON/event_configs directory.
> 
> Domain ID: A valid domain ID.
> 
> The assignment state can be one of the following:
> 
> _ : No counter assigned.
> 
> e : Counter assigned exclusively.
> 
> Example:
> To list the assignment states for the default group
> $ cd /sys/fs/resctrl
> $ cat /sys/fs/resctrl/mbm_L3_assignments
> mbm_total_bytes:0=e;1=e
> mbm_local_bytes:0=e;1=e
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...


> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
> index 5cf1b79c17f5..ebc049105949 100644
> --- a/fs/resctrl/monitor.c
> +++ b/fs/resctrl/monitor.c
> @@ -1080,6 +1080,7 @@ int resctrl_mon_resource_init(void)
>  		resctrl_file_fflags_init("event_filter", RFTYPE_ASSIGN_CONFIG);
>  		resctrl_file_fflags_init("mbm_assign_on_mkdir", RFTYPE_MON_INFO |
>  					 RFTYPE_RES_CACHE);
> +		resctrl_file_fflags_init("mbm_L3_assignments", RFTYPE_MON_BASE);
>  	}
>  
>  	return 0;
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index d087ba990cd3..47716e623a9c 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -1931,6 +1931,54 @@ static ssize_t resctrl_mbm_assign_on_mkdir_write(struct kernfs_open_file *of,
>  	return nbytes;
>  }
>  
> +static int mbm_L3_assignments_show(struct kernfs_open_file *of, struct seq_file *s, void *v)

Please move to monitor.c (then mbm_cntr_get() can be private to monitor.c also).

> +{
> +	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
> +	struct rdt_mon_domain *d;
> +	struct rdtgroup *rdtgrp;
> +	struct mon_evt *mevt;
> +	int ret = 0;
> +	bool sep;
> +
> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> +	if (!rdtgrp) {
> +		ret = -ENOENT;
> +		goto out_unlock;
> +	}
> +
> +	rdt_last_cmd_clear();
> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
> +		rdt_last_cmd_puts("mbm_event mode is not enabled\n");
> +		ret = -ENOENT;

The error returned by the files when "mbm_event" is disabled (but supported) is
inconsistent. All but this one return EINVAL. Please make return code consistent.

> +		goto out_unlock;
> +	}
> +
> +	for_each_mon_event(mevt) {
> +		if (mevt->rid != r->rid || !mevt->enabled || !resctrl_is_mbm_event(mevt->evtid))
> +			continue;
> +
> +		sep = false;
> +		seq_printf(s, "%s:", mevt->name);
> +		list_for_each_entry(d, &r->mon_domains, hdr.list) {
> +			if (sep)
> +				seq_putc(s, ';');
> +
> +			if (mbm_cntr_get(r, d, rdtgrp, mevt->evtid) < 0)
> +				seq_printf(s, "%d=_", d->hdr.id);
> +			else
> +				seq_printf(s, "%d=e", d->hdr.id);
> +
> +			sep = true;
> +		}
> +		seq_putc(s, '\n');
> +	}
> +
> +out_unlock:
> +	rdtgroup_kn_unlock(of->kn);
> +
> +	return ret;
> +}
> +
>  /* rdtgroup information files for one cache resource. */
>  static struct rftype res_common_files[] = {
>  	{

Reinette

