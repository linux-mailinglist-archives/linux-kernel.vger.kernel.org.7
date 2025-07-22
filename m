Return-Path: <linux-kernel+bounces-741349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C4AB0E312
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4872C3BDD23
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EBB27D780;
	Tue, 22 Jul 2025 17:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JyMKcW69"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440871422DD;
	Tue, 22 Jul 2025 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206816; cv=fail; b=tKvHTxz4MBIiAkv8n3II+f8/t2kDW64nZcMjzaDQ5BU2LyFUxfbPHzjlsZ72w64BNaiR5AWAAwXpi6k/ATCMuYbYHQg1FHMGYrwbOlzyePtf9cAuX1Jj9sflqjp0VxFTyxbD8yXIwpgg7UvGwExigruvEnDlkmVlcaKoGXtsD7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206816; c=relaxed/simple;
	bh=6K/19rqkEfJypLpueWcbhicfuXuKNovNktDsDJ9W5F8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oHlQqsLdxsp9TWRQiHDhzZVDeeh3X7mRJD+s5sBuTRCLKGCxWbZ3TJ+V6Axg5R1gfGGkA9pmwmA2HR/h5KAPJtAeV0ctl+m2f/YQIe31fJqTkYDKMY3L94nhaWPT2zqrrUkQ1N8cTJ2Ld1S7hhbTCDkan/TFCPtDESjMsQB8nag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JyMKcW69; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQ/TfJvLpMo61CbBjiKgtIaJ9QWGHZ2cgOAkoSrKhPSSQCkTTA8A3EhujfbjRiijkFIOkstRb95XbYmlGTtzgjvoD/naC/cXnDiPenTYL6FFPzfoR3zBVzmgdAaO2OBr56fgHfzBxfJboURKMfXQSkQnRVwAH7sjSMxaS6DphAvY4D6jGUKw+Yz8i32GRERtJ6nxULcFFEVbI60oFh1U6gtxmlUFRET0x+ZldNR0v0j4ZWpPLkiNDddu9SSlQo1O0roE2xoZUnoyUkNJIwdnjNwg9U+Pwstqc9WaHQITTo74+0F5V0ZnNHKbWSjb8JOsPoGCAXvf1qHVeyjXF6tpdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oWrwWz+e6lJuOPyMOxcM/jvGgKTv9esL6yMpdlzXOo=;
 b=KlAy0ogR3YubcoFm1e//VEdbDiTSIk2gVwsqb+t5bp0lZon0n+Ij2py/xosHvH5uYn8NOhF+8V5oj9HbubT0IQO8Dkjceb7Xfi208OpC6EfnoI2b7mmjT2atPa2fGsurVRG4fmNODr9taXi5T+rtUFNwIJG2z/ABUlcEOLquSLg3EbFdJR2V5Tph9obXrtBnOOo4DyTPBF2oEQDdkL8AuW4F0EC/YBDUS+eYots4wslx2rspFeblZxCCRt77dCB0ynU28Ap/j3zBsFsT7qGlepwegjGf8sOX03FYGRrbFWdG81ahFAqp8POrGaEA2PLqLpnYo9pCrX9ERfGL2ax9zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oWrwWz+e6lJuOPyMOxcM/jvGgKTv9esL6yMpdlzXOo=;
 b=JyMKcW69ueDmn0FT2+lPA5uhIpoVozyAMwswWf6pIF3mTX6SpA+j+uyRbeCGI5tseFTC7YC7aehXHoQRJdjwWHbwyth5W+9R4u8uwD/YiIZFMOy9iVxGGtO5v2n0J8P3pbQNdhT+GLKrX+Wd+MP87sMR/P+o7UBmB/I0Tbd8ucg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB6437.namprd12.prod.outlook.com (2603:10b6:8:cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Tue, 22 Jul
 2025 17:53:31 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 17:53:31 +0000
Message-ID: <df7cee69-7873-4b6c-9401-74a7d74d672c@amd.com>
Date: Tue, 22 Jul 2025 12:53:25 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v15 23/34] fs/resctrl: Support counter read/reset with
 mbm_event assignment mode
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, james.morse@arm.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Cc: Dave.Martin@arm.com, x86@kernel.org, hpa@zytor.com,
 akpm@linux-foundation.org, paulmck@kernel.org, rostedt@goodmis.org,
 Neeraj.Upadhyay@amd.com, david@redhat.com, arnd@arndb.de, fvdl@google.com,
 seanjc@google.com, jpoimboe@kernel.org, pawan.kumar.gupta@linux.intel.com,
 xin@zytor.com, manali.shukla@amd.com, tao1.su@linux.intel.com,
 sohil.mehta@intel.com, kai.huang@intel.com, xiaoyao.li@intel.com,
 peterz@infradead.org, xin3.li@intel.com, kan.liang@linux.intel.com,
 mario.limonciello@amd.com, thomas.lendacky@amd.com, perry.yuan@amd.com,
 gautham.shenoy@amd.com, chang.seok.bae@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com
References: <cover.1752013061.git.babu.moger@amd.com>
 <df215f02db88cad714755cd5275f20cf0ee4ae26.1752013061.git.babu.moger@amd.com>
 <9a4410c5-c72f-4a8b-ab64-9737e082c5b1@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <9a4410c5-c72f-4a8b-ab64-9737e082c5b1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0009.namprd11.prod.outlook.com
 (2603:10b6:806:d3::14) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB6437:EE_
X-MS-Office365-Filtering-Correlation-Id: 535dc9be-5829-44bc-1490-08ddc948abaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXk1TjBDZGhUNm5YVTc1Y1NSTEgyOXlyTmpzSitrWU00N05lcERXbjZRM28w?=
 =?utf-8?B?dXN6ek44MkRwSStMOGV1aEJpdEJVOUtlQ1lMaThuVGhNaU4wSzcyNWZZSDZQ?=
 =?utf-8?B?UXJDNlIyT2hNWFJwME94NUt5bW9IT3owMFN6SSs2VEJXOG5UVUxiU1E2VXMw?=
 =?utf-8?B?MFhWRThTRGxkVXpZRDluRGpLMmQ0R2FrTFl3b1NOQllQV3l0Sk9BKyt0aDR3?=
 =?utf-8?B?dGZ1WERoYzMvSU93NjVMVW93QjNyeXkzeWZ4WlljN3RNUDhuQkE4ODV3bEpV?=
 =?utf-8?B?dGpBKzhYQ2VQdzZlVktSSmVyNlJCRmRCbjRxZUNQeGRQWHV4Ym9PWDlHQzZF?=
 =?utf-8?B?NXNBZ3pJc2xxUU9oU0V5cVJyY1hURXJneUpFSGNLeHpPdUUrc3pXWUlBVnFZ?=
 =?utf-8?B?VVB0Zm9WWlRtaVBQMTZZZWVVdVUxVW1CbkZmUlhuQmw2ekdhNE1MRWVBV2I0?=
 =?utf-8?B?N3pYTFRETTFmSE1nQTZEckNwdkJrUGVrNUFVMmt4WDhCZk9pTFZKalFwV2oz?=
 =?utf-8?B?S0xaTkltWm5sd2JYNFZEbU16Yi9DeXdEcWRDemM4UE50WHM3ZjBkcEEyRXlT?=
 =?utf-8?B?clhjV1BWS3F2a0lKSk80WUtaVEhwK2pJL0xROXYzL04xTzF2ZTJoWDBmbEpX?=
 =?utf-8?B?UEE0cXJKTk5MaXVJcHZyUyt1N1R4U2ZYS0J2R3IyeTUwQ25XR3RRaGsrdUFG?=
 =?utf-8?B?S04yWkZCaUx3WVFOMkVpSzUwTkdjTTBIcllnTkI4ZHUxYm50OEJWb0ZvUHpE?=
 =?utf-8?B?b21TMFBEdnFaTUhPQW9NeUgwckNod2Z3T2JVTmtvaUZHK3VMWXBLRTI5OXNp?=
 =?utf-8?B?ckVFTEM5UUU1NjMyRW5hSG4yOGVTVUh0OTQyMW9qWGVZeTcwOFpsSXVNY2tl?=
 =?utf-8?B?TERTaUgvZUlLRjB6c3NscGh5VE11czVXdEZ3aWVmSS9pUVhaei8yZHpIcVZ1?=
 =?utf-8?B?N0cySEw1UnJNVkNGc25UMk5TRVNQQUZPWTdsK2FKS042WG1iTjdDTEhwUE5T?=
 =?utf-8?B?b0pFUDJkNk9uMzYwUklFeHRncFNHWG1xcWoxd1oxZlNrcncwb0srS1BhdGlr?=
 =?utf-8?B?d2tQQXBSS0pwV1ZDQkVQclBXTStHcXA0QUtoK3pnTkQ5cy9adUNFaEZzMWMw?=
 =?utf-8?B?QWpGYlMvZTRGR3hZMkcxeTUraEhWYTUzbFNrbnFDcXA1VTRobXA0ZzVsdW5D?=
 =?utf-8?B?ZW1DYjlDeWk4R0FiRGZVRk9CUUFiYUZiQldaMVFmWnZ6V0F1dlY2elE0djZ6?=
 =?utf-8?B?bFRUbHp6UG9zV1lyV0x0bWZKVEs0ME93TzBwQ0FNc3dUbTFUV2JTSlV0RXZV?=
 =?utf-8?B?QysrczQ2UGkxbVlPWU0yZ1ZScGNzbXhYK1NZNU1oam5tWFQwa3BNbkw4Nktz?=
 =?utf-8?B?bjgzcDJabUpOYVJDOHkrWGZkOFRTYTNjY21kcHZUMmZocWJmNVBtZms4TzRE?=
 =?utf-8?B?MW8vUFg5VUJPb3ExZGhaYm5Na2ptWjJkOS9WQXZock5Kb3dJd2lZNWZyOVB6?=
 =?utf-8?B?d2o5RHJkV1JNTC9SL1lERWppQXlNcmgzWHRuMVMzbUthbjl3QjRnVFBtQWpr?=
 =?utf-8?B?NEFyMmpMeFVkZXE5TG9NVTZlOUdwMmlrLzNwaW9kM3Z1d0o2N1hXSjZSZ3Jz?=
 =?utf-8?B?ZlRqRUV5UjlxcmVMNmZ3MWxMcjBPQVhPUmI2Y1VxSE5GMThYdnN2V25KblNK?=
 =?utf-8?B?RTNZWXpyV0N0WDNWb2tVV0lqSDVqNUxGSjFpTHNNVitEOTlPOGF4QzI0TnhV?=
 =?utf-8?B?UG5jQU9BeTBGcXZzV2JHS0lidDNqeStxYU1LY1hrSnFqQ2VnSGF5ZTJIVDR1?=
 =?utf-8?B?SXV6bFRGSENPaEtvOGx5V2VsOXJHd0RQZnZFMG5MSmJiaHVxQ3M2SCsvSkhI?=
 =?utf-8?B?WGF5Ynl3N2xYTTNIMXNSU1MzaWY0MDRvQndRYWhzUU5YZDVtdmd4UEpwVzNv?=
 =?utf-8?Q?Mgf7vpQYTvE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3luVHFVd1hoZy9KL1ZnQXRwRzdzOVRQYVd6SVNRVVpBTDhsM3dCTWptZ3ZJ?=
 =?utf-8?B?ZW5KbTBWZUMwa1JhQjFiaEhaczFIWm1SeXUyZFhxUVpxRVI3OU03SGozcnlq?=
 =?utf-8?B?OUppOGg2a0VONFdWYTZnNWRlMU84RDdLU2N2ZzhVUUdUM3UrU0lDS3BTUGpy?=
 =?utf-8?B?bkplbkt4M0JnSFQzTDNaVFZvK0hGVU5SRTdwUG9ONUl1TzJBQW4zRjUzM0pJ?=
 =?utf-8?B?MlRObUxkcVNDblNwRk55Zm1odEJZS211VzA4MWhxaDlxbENUTHF2VmxINkNS?=
 =?utf-8?B?NzNzajJhaSttQUZ6Z2xtUnp3b2VpVlJCb3E3VllHbmhCdGl5SDEwNDF3YXpZ?=
 =?utf-8?B?SlVGYVdwOW5oKzZBK0pMUWJRUnJjQWJTYWZhS05yeWF0R25jOC83WC9GZ3VT?=
 =?utf-8?B?WHZFbjhWY1BaUEVaN29JQU45M1N0a1lTbHh6OE94b1k2NFJjQTRGRjk0WkNa?=
 =?utf-8?B?YVFZN2lXU0RTaldkYnVsaWNnKzFKdXM1S3A2YnRnQXlGbHFIMUFwZWRsMlJj?=
 =?utf-8?B?NFBhcWZXNTlaZjZMY2xrNUt3VVB1N0ZUTjBJOVR4OXhuWFpvNVhybGxmRmIy?=
 =?utf-8?B?QzRDcUUzaGpYK2RjaUQ0bmw5SDRkdmdlb3VscnZUMjVueUJwLzZxNzRia2k4?=
 =?utf-8?B?K3M3b0VjNkNkcGs2Vlh4YW9md2RVcTQ2a1o3V1l4aHd5Nnp2KzJnTnhXa3l6?=
 =?utf-8?B?LzN5NWRZNGRMaWRlSlhXcVVwK0FieEFCU2trczA2R1FRbG11YjlSYzFjVHlC?=
 =?utf-8?B?L2g3NlVqaTNvblB6UTI2QjFBY3F0RjY2NVlEZ0tzWnFkSnlOenNzbUZrREFN?=
 =?utf-8?B?VGJyUnhiTWN0NHgzRkUxVDIra3VJQ05kYmEzdFE1NmxESFNNejZNU2NzSnho?=
 =?utf-8?B?N0RBWFpkZWlDa3M1VWNMeEM1UG5GUVBHOWcrdEVFbHQ4a2V5dzRPVWFxV053?=
 =?utf-8?B?dW9sblFSRWNyWFR3R1FZejlTdWlMRmFVenE3cDlwMDVZbCt0NElpYmtFaHlv?=
 =?utf-8?B?bndjWGJjeTNncFVtYTZnWFZHYVBNUENxZTVyWFhLbXpYbDBsT0lOcTFzR3U2?=
 =?utf-8?B?cGRLUmtjUXNFaUFxcCtvaUY2OWE2OWZuMm5TQVhCdVF3cWxKUklBRFpyRThl?=
 =?utf-8?B?TVNuKzRsWUwxRXFUTkgyOE5IMDBDR2NsVEZGRDdkdnBwUXpRRWgvb0lnbnN1?=
 =?utf-8?B?OEMxNXEwQ2s5UjlmSzRpVnlPaWhNcUhmUUFYR3FTazE2dXR6Qmo3NUVvS1NJ?=
 =?utf-8?B?UWlJbHpieHp5ZjFkZ0V6WHk1elRtN0xubTZmSGVNSURab2d6c2pVcFlERm9R?=
 =?utf-8?B?VStBakJGSEpEbnVBaENUbWdFUnpEeXZvbUFZRGFBaW9iUk5GTGl3UElDRTU1?=
 =?utf-8?B?L1p3WSt4Mk5uR2FQcG1hd1VuWUJxU3dmWUp3YTZaU1ZTcUlHRWhXeWNSWk1x?=
 =?utf-8?B?NmNCWFdzcWJZakF4NjgrL21NT3p3VzV6dDJ6cTVsd2c1aHczNE90MzJlKzl5?=
 =?utf-8?B?dWMvQys0NmxUbzhRQXZlaDltQUdmK1g0NFFkdStwV3hEZldIZXhRbW8xTFpk?=
 =?utf-8?B?MG44cWdKcGtJUlNDdG82ajhzaHp2L0R2SWlGbWxvRFVMUkFHWm0zV1oyeHla?=
 =?utf-8?B?WjE0RnJhSTJVK1BPVHJEZzdnVGZwdUttNk9zY011NDM5Rkh1L0hOczg4YkFS?=
 =?utf-8?B?NE1WODE5cTlsdFZsUEtlZjR3RHVHa3plQVR6S2ZTY3pnaEh6eWl1c1JBMmdx?=
 =?utf-8?B?LzQ1b0RZbE1ZbVRFaTVPVlpyeGZPY3d1Z002SUF3bGpBWGQ3eDBvVTFFSXVJ?=
 =?utf-8?B?RWEwMjJpNytSb2dLL09oOXdnenBVREpDU3kxR3laWXNBNWcwampkSzVQaFVi?=
 =?utf-8?B?YlpRcVQrR3BMb0taeHNhZExsQmhHamxrYUJyOEpwSHcyZlU3QWlJWHRBSG9u?=
 =?utf-8?B?d1loN3JQdkVZWEg2K2FzOXBmbmlwbHowRDQ1d0ZxdThVaVBaUE5EVnNhaVVv?=
 =?utf-8?B?dHpOU0VJZ2tEdCtWeTA4OEdaSkxXV0V5bm1HeW5jSFZCbXpIL3FQeHF5L21m?=
 =?utf-8?B?aHVSYXZqNlNKQysxdjVrQm9TMkgvYUcwT3hMWi9sV0hISkdyOGlvR2Z5UC9j?=
 =?utf-8?Q?cn14=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 535dc9be-5829-44bc-1490-08ddc948abaa
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 17:53:31.3164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wre4iCnstC/5xE1PbXPOkXfMT0AJKxq5/4dY/o33hXGB4WyyYJolPJTrPFDKEiLt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6437

Hi Reinette,

On 7/17/25 22:53, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/8/25 3:17 PM, Babu Moger wrote:
>> When "mbm_event" counter assignment mode is enabled, the architecture
>> requires a counter ID to read the event data.
>>
>> Introduce an is_cntr field in struct rmid_read to indicate whether counter
>> assignment mode is in use.
>>
>> Update the logic to call resctrl_arch_cntr_read() and
>> resctrl_arch_reset_cntr() when the assignment mode is active.
>>
>> Declare mbm_cntr_get() in fs/resctrl/internal.h to make it accessible to
>> other functions within fs/resctrl.
>>
>> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v15: New patch to add is_cntr in rmid_read as discussed in
>>      https://lore.kernel.org/lkml/b4b14670-9cb0-4f65-abd5-39db996e8da9@intel.com/
>> ---
>>  fs/resctrl/ctrlmondata.c |  8 ++++++++
>>  fs/resctrl/internal.h    |  5 +++++
>>  fs/resctrl/monitor.c     | 42 +++++++++++++++++++++++++++++++++-------
>>  3 files changed, 48 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
>> index ad7ffc6acf13..ce766b2cdfc1 100644
>> --- a/fs/resctrl/ctrlmondata.c
>> +++ b/fs/resctrl/ctrlmondata.c
>> @@ -569,6 +569,14 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>>  		return;
>>  	}
>>  
>> +	if (resctrl_arch_mbm_cntr_assign_enabled(r) && resctrl_is_mbm_event(evtid)) {
>> +		if (mbm_cntr_get(r, d, rdtgrp, evtid) < 0) {
>> +			rr->err = -ENOENT;
> 
> This introduces the new -ENOENT error code but rdtgroup_mondata_show() is not enabled to
> handle it. Looks like the next patch needs to be squashed into this one.

Sure.

> 
>> +			return;
> 
> Looking at this closer this does not seem the right place for this check. This is the
> top level mon_event_read() when the user reads an event file. If this is an event
> associated with a CTRL_MON group then resctrl should sum the data of the CTRL_MON group
> and all of its MON groups.
> It may be that the CTRL_MON group's event does not have a counter assigned, but one
> or more of the MON groups do. In this case I do not think resctrl should fail reading
> the CTRL_MON's event early as is done above but still provide the sum of the events that
> can be counted in the MON groups that do have counters assigned. With that, only return
> "Unassigned" if no counter is assigned in any CTRL_MON or MON group?

Yes. Very good point. Thanks

Changed the code to just set is_mbm_cntr here.
> 
> 
> There also appears to be potential for a leak here with the early exit without calling
> resctrl_arch_mon_ctx_free(). As mentioned earlier in series I do not think that
> arch_mon_ctx is relevant to this counter assignment so I think mbm_update_one_event()
> as well as mon_event_read() should make calling resctrl_arch_mon_ctx_alloc()
> conditional on is_cntr/is_mbm_cntr. 

Sure.

> 
> 
>> +		}
>> +		rr->is_cntr = true;
>> +	}
>> +
>>  	cpu = cpumask_any_housekeeping(cpumask, RESCTRL_PICK_ANY_CPU);
>>  
>>  	/*
>> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
>> index 647a0466ffa0..fb4fec4a4cdc 100644
>> --- a/fs/resctrl/internal.h
>> +++ b/fs/resctrl/internal.h
>> @@ -110,6 +110,8 @@ struct mon_data {
>>   *	   domains in @r sharing L3 @ci.id
>>   * @evtid: Which monitor event to read.
>>   * @first: Initialize MBM counter when true.
>> + * @is_cntr: Is the counter valid? true if "mbm_event" counter assignment mode is
>> + *	   enabled and it is an MBM event.
>>   * @ci_id: Cacheinfo id for L3. Only set when @d is NULL. Used when summing domains.
>>   * @err:   Error encountered when reading counter.
>>   * @val:   Returned value of event counter. If @rgrp is a parent resource group,
>> @@ -124,6 +126,7 @@ struct rmid_read {
>>  	struct rdt_mon_domain	*d;
>>  	enum resctrl_event_id	evtid;
>>  	bool			first;
>> +	bool			is_cntr;
> 
> After seeing how this all comes together the "is_cntr" is very generic and not
> matching the often used "mbm_cntr". What do you think of "is_mbm_cntr"?

Sure.

> 
>>  	unsigned int		ci_id;
>>  	int			err;
>>  	u64			val;
>> @@ -391,6 +394,8 @@ int rdtgroup_assign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp
>>  			       struct mon_evt *mevt);
>>  void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
>>  				  struct mon_evt *mevt);
>> +int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
>> +		 struct rdtgroup *rdtgrp, enum resctrl_event_id evtid);
>>  
>>  #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
>>  int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
>> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
>> index 73f507942b6d..35faca7ff3b1 100644
>> --- a/fs/resctrl/monitor.c
>> +++ b/fs/resctrl/monitor.c
>> @@ -366,9 +366,21 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
>>  	struct mbm_state *m;
>>  	int err, ret;
>>  	u64 tval = 0;
>> +	int cntr_id;
> 
> I've tried a couple of checkers and not all can pick up that cntr_id is always
> assigned when it is used below. While it is not necessary it will be helpful to
> initialize cntr_id here (-ENOENT?) just to avoid needing to prove that hypothetical
> reports from these checkers are false positives.

Yes.

> 
>> +
>> +	if (rr->is_cntr) {
>> +		cntr_id = mbm_cntr_get(rr->r, rr->d, rdtgrp, rr->evtid);
>> +		if (cntr_id < 0) {
>> +			rr->err = -ENOENT;
>> +			return -EINVAL;
>> +		}
> 
> This looks to be the right place for the mbm_cntr_get() check. Just keeping this one
> avoids the duplication while also makeing the code match existing user ABI.
> What do you think?

That is perfect actually.

> 
>> +	}
>>  
>>  	if (rr->first) {
>> -		resctrl_arch_reset_rmid(rr->r, rr->d, closid, rmid, rr->evtid);
>> +		if (rr->is_cntr)
>> +			resctrl_arch_reset_cntr(rr->r, rr->d, closid, rmid, cntr_id, rr->evtid);
>> +		else
>> +			resctrl_arch_reset_rmid(rr->r, rr->d, closid, rmid, rr->evtid);
>>  		m = get_mbm_state(rr->d, closid, rmid, rr->evtid);
>>  		if (m)
>>  			memset(m, 0, sizeof(struct mbm_state));
>> @@ -379,8 +391,12 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
>>  		/* Reading a single domain, must be on a CPU in that domain. */
>>  		if (!cpumask_test_cpu(cpu, &rr->d->hdr.cpu_mask))
>>  			return -EINVAL;
>> -		rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid,
>> -						 rr->evtid, &tval, rr->arch_mon_ctx);
>> +		if (rr->is_cntr)
>> +			rr->err = resctrl_arch_cntr_read(rr->r, rr->d, closid, rmid, cntr_id,
>> +							 rr->evtid, &tval, rr->arch_mon_ctx);
>> +		else
>> +			rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid,
>> +							 rr->evtid, &tval, rr->arch_mon_ctx);
>>  		if (rr->err)
>>  			return rr->err;
>>  
>> @@ -405,8 +421,12 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
>>  	list_for_each_entry(d, &rr->r->mon_domains, hdr.list) {
>>  		if (d->ci_id != rr->ci_id)
>>  			continue;
>> -		err = resctrl_arch_rmid_read(rr->r, d, closid, rmid,
>> -					     rr->evtid, &tval, rr->arch_mon_ctx);
>> +		if (rr->is_cntr)
>> +			err = resctrl_arch_cntr_read(rr->r, d, closid, rmid, cntr_id,
>> +						     rr->evtid, &tval, rr->arch_mon_ctx);
>> +		else
>> +			err = resctrl_arch_rmid_read(rr->r, d, closid, rmid,
>> +						     rr->evtid, &tval, rr->arch_mon_ctx);
>>  		if (!err) {
>>  			rr->val += tval;
>>  			ret = 0;
>> @@ -620,6 +640,14 @@ static void mbm_update_one_event(struct rdt_resource *r, struct rdt_mon_domain *
>>  		return;
>>  	}
>>  
>> +	if (resctrl_arch_mbm_cntr_assign_enabled(r) && resctrl_is_mbm_event(evtid)) {
>> +		if (mbm_cntr_get(r, d, rdtgrp, evtid) < 0) {
>> +			rr.err = -ENOENT;
>> +			return;
>> +		}
> 
> This can be dropped also? Only is_cntr/is_mbm_cntr needs to be set here, __mon_event_count()
> called below duplicates above snippet and will set rr->err

Sure.

> 
> Same comment here about missing call to resctrl_arch_mon_ctx_free().

Sure.

> 
> 
>> +		rr.is_cntr = true;
>> +	}
>> +
>>  	__mon_event_count(rdtgrp, &rr);
>>  
>>  	/*
>> @@ -982,8 +1010,8 @@ static void resctrl_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d
>>   * Return:
>>   * Valid counter ID on success, or -ENOENT on failure.
>>   */
>> -static int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
>> -			struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
>> +int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
>> +		 struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
>>  {
>>  	int cntr_id;
>>  
> 
> Reinette
> 

-- 
Thanks
Babu Moger

