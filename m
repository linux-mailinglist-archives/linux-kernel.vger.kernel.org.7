Return-Path: <linux-kernel+bounces-797609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2E4B41272
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52D61B61B0C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8997C1E5B72;
	Wed,  3 Sep 2025 02:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqm+pvLb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DC9288D6;
	Wed,  3 Sep 2025 02:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756867296; cv=fail; b=FLftnW9QHxkeygCeZr+66TvqI5LvZoHTnNa63rINAXESjSkN+XAOnvQrQHCiO3fByaaPzmjRO8lEFR91nCM+EQRq6JsxSdr3k+eGRUsLOMejuxA6HUqFBwQ5ZISwyXxYVWfwiZchNFYTjVGFSQtLUE8U04qRNNa/226Hg0WIxEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756867296; c=relaxed/simple;
	bh=SsI+VXW+bDlXzC5a3ntEpqhBYKxyGFAXurU5e4YhKcQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WoHFkLput/KNLsNwGQfyaS5sn6LD/4fDEwwPdod6YeCSkaEH0kDwX6E1Ha0qd98yDdXyNHWw2Igri2xODwmxsb4fiyhLDkJ3wYo6a9UxsNkynFSRosAMtP1oRJmo+4saLzJCGkJuxmG/0pnWsn4Vhc0QfLjc8POInQjm4hzJ894=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqm+pvLb; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756867295; x=1788403295;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SsI+VXW+bDlXzC5a3ntEpqhBYKxyGFAXurU5e4YhKcQ=;
  b=lqm+pvLbaqKLDJ7LW+IaP9DswsjyqLNcQdct9YqyjM3LS3ibNGc7TStx
   oTMVYYLxftu17BBvQFbhq27rt2YIFT0tp25uI0FPN4/o5tpUVdj2bzwks
   xqORyk5G4etGDn9x3FskJgSqgATIGxtx9NUukHUye5GnrzefYDMQaul0T
   3OqsxFwUbG6PMCLEliDPX7dLJjO8CsjXn79/pgg/DBJWblFOg3JPgh4sd
   nVL7iPwQWfedzKJ/3vJDbI0NLFZ28ScjWDUf1hz7f02FbDkg7QGV7PIfB
   BuVff3q5GCrDtwExZ6/uCdQP/KV+ItBUozg/gQ9/jIDx0HiJLPiVyAVC2
   Q==;
X-CSE-ConnectionGUID: n0M8i9qrRYe5GHddpceHVQ==
X-CSE-MsgGUID: 9G32UTViRQ2LEgVErTI0uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="62812678"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="62812678"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:41:34 -0700
X-CSE-ConnectionGUID: hv6kCwrZSJ2ub5NEVMtOcw==
X-CSE-MsgGUID: bx0tXC8SRTKz+YHtKjC5DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="171426162"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:41:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:41:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 19:41:32 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.75)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:41:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hkyByn2iFCjpk319UM6CbJKp8Gq2qdBODTVJKn5hn6FRMFA83YjX3cmmKiLQ/hnicrUIqqO7mDJz8l/+rO4jSOsB8NUJ+mNtbFGEuiGxObyeHOUipl2dzhuu2dR7bYuH2hNH7Ky5+H0TRuKGhePO6zhlzSEE/APz2ihqtqlNgS8JJY8PKlVo2YsnrFF0Z9347qdrIADmUHFdB1ECcWkRrMT54ry3sRrQPexqoEIK8vcq30IS2dze3QIeRFy4M9Iy1FjEzvB7c2WLvphV2xUgv/yBS96FUGH2sWA4Ac8K5V+Bk5dOzebXEgJHACGRTvIx/u0WkFBDY//75FtsAld8rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B03esMWd1pV2mf6g265EHAbL9UzRbUrOyVqsuUfEcCE=;
 b=zSI2Jw2CuWm45hg56K2myHnA+4QX0dcM6hAdFZN/+bq+uzgo0U7ohoD1a/C7dSTExYeC7qebdc0vxyDHpIzJGW7Q67DyVzTqcO4QoyO40VLFQiFqS6Bm1QfdpeHhMSm4KHLfX9cvaGsltJ4anEu/HjTeE8BP654oDjpmA69CA6iwrdhD2TAuVRfR2IzmCNoC0Fs7e0TIXxct9Mafenlk4ZT8PVrtqPNey3EdmgNSSHO96KZgWsmqK5m/bfFQSZiKC92EYsYPKhD7mz8Fax8onYMxyJI1nmA2++uCjkq8tAN9v/c8c9zXpSr904+OOwmsv2rN8GN2XU63ohFr9AfahA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB5129.namprd11.prod.outlook.com (2603:10b6:806:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 02:41:29 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 02:41:29 +0000
Message-ID: <c5f97d82-bb87-47e8-bbf0-e9dfca332313@intel.com>
Date: Tue, 2 Sep 2025 19:41:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 25/33] fs/resctrl: Provide interface to update the
 event configurations
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
 <4d497589d3bb5389565676512c2116e5cfa6df7c.1755224735.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <4d497589d3bb5389565676512c2116e5cfa6df7c.1755224735.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0168.namprd03.prod.outlook.com
 (2603:10b6:303:8d::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB5129:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1e2d55-ec11-4679-2efb-08ddea93625b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ek13ZEJEQnBUcHpYUXhCVE5PSFVCS1hYemg1V01ua1FwM2xzZVhoUjNGQmFn?=
 =?utf-8?B?aitSRTkrdWwxQ3VNLzhJMFNqSmNlM2VJVm1TWnRpd2NhREVYakpaemVVNlZJ?=
 =?utf-8?B?Q2Z5cWt0bmNEelhnR0VTQlhhRy80V0EzMktzU3dCdEtNSlFaczJoQzYzeTVT?=
 =?utf-8?B?allCOEh3MGtkdXRaN3JMcnNMUzRBNjl4WnRnVDA5VzY1SjIyL0FQeXI0dHNP?=
 =?utf-8?B?eWQ0SWFJb3I3N0gvaHlwdXQ1MEp4Y3J4NkUvL3lNMi8rSmYzZEFXNTBmcDg3?=
 =?utf-8?B?endqTlBVUU43OGxjSm1kakZKRC9jbjBUTDdranFVZHRpUjVTaE5XSFdDcERB?=
 =?utf-8?B?MlY1TVRhZ1FsRHR6UTYrSkc0YmtvVjVLVTFMdkhvdFBMVGVFNDI4YVhnTG04?=
 =?utf-8?B?OUM2c1llbkZVcnlLVG5UY2Q3aVJubzJvdlFrRE9Sc2VhdFVwUmlWNTZtelNj?=
 =?utf-8?B?RFZkQnFMUXQ2dlR2eUhXMXJOVkpEZUlXWEJLQ0IrNVUxa2ZTOXZsUm9OUmtL?=
 =?utf-8?B?dFNGb0t0VnZJMjROWm9MQTlCa0ZJQXJPNHhlR0d0TmI3UFFXbXVyQStRR0s0?=
 =?utf-8?B?bm1PbkM5SGpxVHFHbytPTnB0alJpbCt5b0xUcnlSYVVXZEVUNUFzRUpLdC9P?=
 =?utf-8?B?b09IbUZ5RWdnNjRRVDkzWDR3ZmxDZng4RTkyQ1hkTUE2Q0preTFSMWNlSFoz?=
 =?utf-8?B?T0xCQkRReEhuTDdKanEyZFVCOTFGK3NnSWUwUGRteWNsSW15RG0xWjRaRW03?=
 =?utf-8?B?eXF6WkRxbStTOXVwbUMyc1lBNjI0YmNnQ2YvcmV4akVTRG0zdWtjZkJ1WWt4?=
 =?utf-8?B?bW1KT0ZNdkttOWRUSUwzVWxUcSt0c3ZjL1RDa0pWUkNsSTRkc2YvNnBJT0Jj?=
 =?utf-8?B?R1dUME01RGVxSUR6TllyZDk1NmRkcUdRNEw5TnRGQnVKMmFEVllUTUNNWm4x?=
 =?utf-8?B?cDhCa2V0R005WlBFY3ZJeCtNcjV1cC9iMU5EMDNkV0pLNzUxdU50dEF6cFRO?=
 =?utf-8?B?TWs1dm9YbkFGNWFNOWR1VDk2REgzMnFkTHRCSTNKL2xhazNDdUVmWkR5SXlU?=
 =?utf-8?B?TjJDTVBBZDNnemZkMHl2UDBmSU90aVMrTWF3SkpIS1g5emsvanJrZ0c0bHFJ?=
 =?utf-8?B?Ukw5dHk4bE04dDVnS3lqdGxOaEZ0U0lqOVVOY1NzMk5FV0ZDS2cwSkEyVEtx?=
 =?utf-8?B?YWM3NUdIeHpSVUFZQVhBTUJNQ3c5RUd0cFAwZEgwdGFPUk8wbXMzdUFCUUFG?=
 =?utf-8?B?T2pnMUJaTzRIZmszK2pOeU16TlMyZGRxY0g0OW9MNXE4NjZEdEtIaFJKTkdu?=
 =?utf-8?B?TFppRU9uelA4NmRMcmpFdW1nbWFzQ0Z2MjNLM1NpTzdSZmp0aktGWmZYNCsr?=
 =?utf-8?B?eExQc1lGa0F4WGptdXppa0dtV0xzay93WTlCdmFTWnBuQlNWdjArazBwRGdy?=
 =?utf-8?B?WUFpMmNYSnpROUxjWFh6M2lwK2dCRmc4TjJTbDJSclBBYmh1K0V2UWQ1a201?=
 =?utf-8?B?cGc5S1JCM0FDOXZDaUFHeitkSkNweWFzWHdVU0ZocnRMWGVVbXZhN2ZYdTBF?=
 =?utf-8?B?YnQ0QWp2Wm9FdCtDRkxHblBNeEcrZ29uWTM3VlBROEN4STNIcHcwUWxKSXZy?=
 =?utf-8?B?UkdCbm9YbG0rc2FNL2RpV0hyUldFSkx3S0VVSFNJczlMc2JCOTIrNVhoa0JH?=
 =?utf-8?B?NktVaVlEQ2EzNjRmelB0ekxyUUJ5c1ZIdHR6YmZmY0N1NGZ0eTJFVHV3Q3Vj?=
 =?utf-8?B?SDlTTXcrNjVPcmxEaVJmbnpNQS9DQ2RwTm5kZGpORjMwa2czZDlmcmxZclZH?=
 =?utf-8?B?TEhOYk9OdnQ3UjdtandOTU9hdDRzM1B2ZVU1QkZmWUoreWFFb0hwSmpBVE5Y?=
 =?utf-8?B?RklWOXhrS0tkMkRtSFAwZy83dkRzUGtUZTNMRE9kNHRoNWRjRUN5SHVWR2xn?=
 =?utf-8?Q?b6lIwf9g/oA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEt0OUdiejNwK2YxWXo5OHdqcUdhbjBFbk94WThDWEJpM1YvT2lzL1MyU0x4?=
 =?utf-8?B?aStsd0lFa0hpcVd1SlBFOGJUVGF3Q01NYS9BalhiMCtXTm5YeEJocUljdUpp?=
 =?utf-8?B?WFBobk5wYnozVlYwT1FZYnBDTXNHNG0vdis3ZWRDYURHL1lMRnU0RUFiZEpi?=
 =?utf-8?B?dnI1TlJEcGdQUjFiUHhlVDcvTzk3ZGpiWXFTYm9yRFJtRlFEc3QxaXJqcE9U?=
 =?utf-8?B?dHhwWHNWVFYyR3d5UDg1bEhOb3FSMWlBUE9YN1dpUWlocUROZWx4N2dvT3B3?=
 =?utf-8?B?UjRib0d5T1RKVVB2eDBEZ3pyazJ5anpvUmQ5bFNxSzlNeXJJbUtCRHlWa2Ra?=
 =?utf-8?B?OU1uL1BGa0Z1MEJlOGQ5TEd6dE82TWZ3TUJ5OUhuUVlzR01RdFhCSnVCWGw3?=
 =?utf-8?B?TUlNOUYzYXF0L2I2cGVhVG01QUgxeEUrOTFIcXFFZzNMK3NFbDA5YkdPZXFT?=
 =?utf-8?B?ejYzOWlFcWRiMnVTVWJWdm95N1lIRGRRc0NBSGJkdWJLTU9KT0xpdnMveGVv?=
 =?utf-8?B?RW5aOFhxdE5ienA1M0ROaVNLT3M0YkoyWCtZSGJuanROQnFHbjdwQ2pKcmlm?=
 =?utf-8?B?QkltbVhFNmEzcEZ2R0d4dHpsV3Q1SHEwVmk0TDU2VGRXYXBnUDY1UXlLSmt3?=
 =?utf-8?B?STJvNmJNNE9KejMrUVZqOE9hVko1SHB5ZVVTdU1SRGY0RGpQNTI2QjhDRzVm?=
 =?utf-8?B?eDN1bWxUWTRFL1BzSlp1WjNETGs4RWhvYkJxeG9tZ2xuRGhPRm9sSW9Ebnhq?=
 =?utf-8?B?UElNanpCQks4NS9keHhRY0pOYzNvZDJaTEg0REV6NXoydk1rMm5rK0ZrcE9y?=
 =?utf-8?B?S1hPMUF3UlFVTHVEQ1pOakl6cit6ekEyeldlbEU1VXZrZmRsb3FwQnAvaTNr?=
 =?utf-8?B?MWZPL1dwNG9UWExJTE9ndmppMk9Kd1JWaFIzRTFxYUNpbXBNQ2p0ay9xMUN3?=
 =?utf-8?B?WWxBaEtHcjJkcmhpdGVVUHROSE9FOW5BWXB3OVJkckZhUi85RnR4R0xYcXdz?=
 =?utf-8?B?R3Z3Nm5zQzluSHRRc0V1NGtDYlpXSlBBODJVZWxjYjBnM3kzMG5GTEtJbWtu?=
 =?utf-8?B?elQxcnBoYUVDK3U2Nmw3ejFKR0p0WTZMMWNGbUFUT3A4dXlhMFRyQmhXaitF?=
 =?utf-8?B?d0VHSWNiZXpyWFE2ODQ1dTRwMGx6WVA2TGF4SmVUZktId3pTTGp4THFxVllG?=
 =?utf-8?B?MTNJdWorRnVBUkVneVJMTUNKeGJWUGRsMXdoaUovUkJ1RCsvTnJqVjY5TTJo?=
 =?utf-8?B?cnVqanE3azRFL1BlNkRjWUZZdUJqeFFsUlEvRW5EY2V0S1VjYjJWa0w1MzMx?=
 =?utf-8?B?NjhkVlpWK2M4ZStsZGJSekJnZDVhNDFVMXUvNmg5RHhwS29sWk1wcGMreEpm?=
 =?utf-8?B?SWxLOE9jckovRXJjaDdkeXQzYnRMZUlXZ1Y2bWI1Z3FqYWtpWFRDa1kzbmlX?=
 =?utf-8?B?NVFFU3JRcDdrYUtnYTNCMmhvOWNrQys2OG5JTHVQc0ZzZ2tHamowSXZNYWxT?=
 =?utf-8?B?UytsNmJwSTFidHhRUG1PS0JIckFoS0Y4REhwRzMrUjFCVFR0RzN3V08wT0U1?=
 =?utf-8?B?TmJRYTY5elZZMkRPTS9XN2JWbUx5OGludDZaTVdIWDNDVHgwU1pkKzg2WWRw?=
 =?utf-8?B?L0xlRHA3TkV0RzNIZzFScHRnT0FSeCtpU3UvVXJKOGlvcUw1aE1GZEVWUTlZ?=
 =?utf-8?B?Y1RNa00vc1NqSGtVYTl5NEZOTmFOM0Q0Z0NIVHIyak5LWFdOR1YyZjNxdlph?=
 =?utf-8?B?cU1ERHB1K1VSRG8zOHB2aDdPU0hRSlBoclQxdG8yWXhGYU5ReFR6N2VZZFNx?=
 =?utf-8?B?UEFmcDBsZFJOQlNTam5WTHFoYmxlMEkwOG9Ha05XdWNpYnNJTDltRGg0YXlU?=
 =?utf-8?B?YnhleTNIbk9DV05aRDBsMVZ4QWpEMjUvYlNsYXFxT0VNQk9sTGcxRlVkaDVM?=
 =?utf-8?B?dFA4MmJxYmZtTjNEMjRkNTQyd1pDRWlhNGRpN3FqZHF3YUxzdnlUVGJONGlD?=
 =?utf-8?B?QUxqMEV6c1VpS0NUYlZGV2xFYlgrL21QM25GSWlhcmFuOGc4WWxHY1psWFRn?=
 =?utf-8?B?dG1nT3QwOERKZlZBV1dLbVU0bzdQaDJlZFVNVVZEUy9yaG1wcndrMlhnWjg3?=
 =?utf-8?B?dUhUY1VnaXh1V3hZODVqOFJTOEdWYUgxKzRHQUh2SkgvRGJETFpET2hHRFlV?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1e2d55-ec11-4679-2efb-08ddea93625b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 02:41:28.9339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ofOcQYSc6nD7BUQnoLoDVGrnSTgrWu4pkyqmZjJW6DNgGNShfum/OwfuOtQCMZAUuBUNycvOC9vc6R0DrkkIax4etMRtH0wHzzC7hOLTTv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5129
X-OriginatorOrg: intel.com

Hi Babu,

On 8/14/25 7:25 PM, Babu Moger wrote:

> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
> index 25fec9bf2d61..9201fedd2796 100644
> --- a/fs/resctrl/monitor.c
> +++ b/fs/resctrl/monitor.c
> @@ -1029,6 +1029,125 @@ int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, void *v
>  	return ret;
>  }
>  
> +static int resctrl_parse_mem_transactions(char *tok, u32 *val)
> +{
> +	u32 temp_val = 0;
> +	char *evt_str;
> +	bool found;
> +	int i;
> +
> +next_config:
> +	if (!tok || tok[0] == '\0') {
> +		*val = temp_val;
> +		return 0;
> +	}

Looks like resctrl_parse_mem_transactions() can return "success" with a parsed
return value of "0" (*val = 0) ... (follow-up comment in event_filter_write()).

> +
> +	/* Start processing the strings for each memory transaction type */
> +	evt_str = strim(strsep(&tok, ","));
> +	found = false;
> +	for (i = 0; i < NUM_MBM_TRANSACTIONS; i++) {
> +		if (!strcmp(mbm_transactions[i].name, evt_str)) {
> +			temp_val |= mbm_transactions[i].val;
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	if (!found) {
> +		rdt_last_cmd_printf("Invalid memory transaction type %s\n", evt_str);
> +		return -EINVAL;
> +	}
> +
> +	goto next_config;
> +}
> +
> +/*
> + * rdtgroup_update_cntr_event - Update the counter assignments for the event
> + *				in a group.
> + * @r:		Resource to which update needs to be done.
> + * @rdtgrp:	Resctrl group.
> + * @evtid:	MBM monitor event.
> + */
> +static void rdtgroup_update_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
> +				       enum resctrl_event_id evtid)
> +{
> +	struct rdt_mon_domain *d;
> +	struct mbm_state *m;
> +	int cntr_id;
> +
> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
> +		cntr_id = mbm_cntr_get(r, d, rdtgrp, evtid);
> +		if (cntr_id >= 0) {
> +			resctrl_arch_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
> +						 rdtgrp->closid, cntr_id, true);
> +			m = get_mbm_state(d, rdtgrp->closid, rdtgrp->mon.rmid, evtid);
> +			if (m)
> +				memset(m, 0, sizeof(*m));

This looks like open code of rdtgroup_assign_cntr()?

> +		}
> +	}
> +}
> +

...

> +
> +ssize_t event_filter_write(struct kernfs_open_file *of, char *buf, size_t nbytes,
> +			   loff_t off)
> +{
> +	struct mon_evt *mevt = rdt_kn_parent_priv(of->kn);
> +	struct rdt_resource *r;
> +	u32 evt_cfg = 0;
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
> +	rdt_last_cmd_clear();
> +
> +	r = resctrl_arch_get_resource(mevt->rid);
> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
> +		rdt_last_cmd_puts("mbm_event counter assignment mode is not enabled\n");
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	ret = resctrl_parse_mem_transactions(buf, &evt_cfg);
> +	if (!ret && mevt->evt_cfg != evt_cfg) {

... is evt_cfg of 0 (a) a valid value (that will not cause hardware to fault) and
(b) a reasonable value to allow? 

Reinette

