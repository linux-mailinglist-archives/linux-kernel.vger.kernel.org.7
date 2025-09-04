Return-Path: <linux-kernel+bounces-801392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49038B44486
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2836178D41
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D803D3126B5;
	Thu,  4 Sep 2025 17:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FNgLTJJJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2CE3126A8;
	Thu,  4 Sep 2025 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757007372; cv=fail; b=Vwod6B/AEvvpudf5YyGrggMeeLu/1XPDlLb1fftXvvByD9A3F7HWx1NDZM+AUTF3ibj50ErQwLyrKa+OkKRVWwdp4LE5eATZaSZVyKwbEKyocnaVLmm/QvJjMzK6gvroO8VlG8yV/RNWs4vKFtAtwogxw69FG65FVvtbPcFAbXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757007372; c=relaxed/simple;
	bh=4GR0Eyu/4gNiJYYgH/ptVqdXV+KISQZ7buIMLWChQmY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r2cmm15XmTs2zkEMVMVoamoY7MLxU4hVNd6edV5bXy+H2vUCIQPmbUFbRYcrAbuT6/roCyVfP8U/lyRsGQmFEeuQqR1M4KY4q82kMSCL7n5p29cicXobXuvzLqu1Ehj7T2BGaXue0CZtybwr2AM7JaSjw1aVEVbcWhkr7LyjlOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FNgLTJJJ; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757007371; x=1788543371;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4GR0Eyu/4gNiJYYgH/ptVqdXV+KISQZ7buIMLWChQmY=;
  b=FNgLTJJJOGRA+zxhzcYn0HFsKGzdTWcUPGL8t4uW/q51SYBAaypd6RjH
   c6bKUsxO+h+z+WuHbhk6+4a/pJYds9Y0N+cMHY/xWNhkmr7WVHb0RE4sE
   MqgNMebV8TSLwhLIKvjea+ukiQ/l1HUnXuxGrOhO5MHa2wI2E6VvTfph2
   4spA46WgBEvijisc9mp4KZsBVNKKFyw7MtL9pKiY4S4MGG5g1iIY0Vzk0
   gsLopL8LDK8mKHXgpfGTyboAvkZRpUL6wiLg6gFbAbNVjyCU2KYLrEVj6
   VYElKJallCv4NaqRht5FUrra/ViWCTROnb3aSEDQPjkVphSH16JeLDw3A
   A==;
X-CSE-ConnectionGUID: Nd2aoWw1RcGmiPP+YjbYdQ==
X-CSE-MsgGUID: tdVtEKV3SV2B75GeNBBtSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="63182234"
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="63182234"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 10:36:08 -0700
X-CSE-ConnectionGUID: VOXmzGZbQ361b5KNdhjJQQ==
X-CSE-MsgGUID: L7tbn9n/SLOQhSDLeMNZcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="171509425"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 10:36:07 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 10:36:05 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 10:36:05 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.89)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 10:36:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cI22OC6JtByQTi/ONZW1axinV901QUBbiBMTGScejOafkWilycHtrjULAlGipy1Rv1NFgUFM3kmIw5ioUoeBfTGh4I+BjlMQCVDRNhlmZBF/dYwcrMxgKWWRu8liR23CgPKmHhxa+9xNXt8dIjXywP9OXtMv7kkhYDZx8AOHs3v2ftl9WkC+IjdXhiFufpY1bIrg+mC5mDlcimFSCTQQpJfOk6cqJiqfvS07ROhi6Br8v/FDWpqyADPUuEMU6zDH77gKcYfXmkv105/277XqBGglDunt4o3RUSKpj5HX9Cs7sdWGy12azT5O7OMEDO/UTT6NpF58UYxqBIrvF7wZ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kS0idhtM/u8OtpRVuYbvE1NV+zg8Ad434/YAiDOG7rc=;
 b=CsVbSRNEDkQy0MSd3UCFAN8/IM2s/+mmjF65XMmJZO4HeuYUcmPs7u6g83ezQKqHftH0JaQpPgMgpFAKKVRbNbP4nFrREpqTjUImL2Kd/kZ8p58iCc6t3gEMvvzhwDj7TOqfxnx8XVPjFVF3MuW8aNFGRecklj/yf2teg9tnCxRPFdyd5+2oHVkOT7gDfoHPsq/XI7XM/BVLm5q4lSFUTOFe6FVLBzlOQ+wvSdXOOL8zT+sijjqjQJQM3Xl/tkXT3i7b0DKhAiJyVzR/Qn5AN8ys84N6sDr/b/Q3RtpVn8etcIhhZfC/AstoktYk9I8Ira8FXgKIqqbcePaN5oa8AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB8808.namprd11.prod.outlook.com (2603:10b6:8:257::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 17:35:54 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 17:35:54 +0000
Message-ID: <11949172-e319-4d2e-b977-67aedeac5c1b@intel.com>
Date: Thu, 4 Sep 2025 10:35:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 05/33] x86/cpufeatures: Add support for Assignable
 Bandwidth Monitoring Counters (ABMC)
To: <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
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
 <8f2c506c2e0bdc4ab3e4736435d683ceb5322839.1755224735.git.babu.moger@amd.com>
 <55dbe7ee-8e4a-4f09-b00e-8e879d8f6ad6@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <55dbe7ee-8e4a-4f09-b00e-8e879d8f6ad6@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0149.namprd04.prod.outlook.com
 (2603:10b6:303:84::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB8808:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad1e391-6a09-49d0-444f-08ddebd97e96
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzFTTHhUdS90dUFVZ2k5UWVRazZsRlF1YlRwNW0wa285TnJ6bkhWNTV1MVZW?=
 =?utf-8?B?bGlDU2tETkpNUjFFcUdDMmVLeTF4c1NoRVhNNWRnY2RUeDNmdjNNMmRoOFU2?=
 =?utf-8?B?c1NMV1NCcjZ2RllpRzNkNzBORlB4ZFNMNXRRRlBJVFdTSk1TYnYxSk0wM3ZE?=
 =?utf-8?B?VVJMcEtyS1pZcnBwTFljY1M0SnZya0tRbzZnUTdzelR5VTNXbmNKNXJEVW9i?=
 =?utf-8?B?ajJYcEFKRmVQSmhBRzBLbUk0d0p0UHBkcWdBNldPdTB3M0JMbTExTzQvUmx5?=
 =?utf-8?B?Zlk1K2NrN1BMU2kxWmgvcFB1NnlTN2duV1h3U2tTN3VTQ2dtY2ZFQnU5bkpO?=
 =?utf-8?B?OFFVYU15L0xyUUlrL2hoSmw2TnlIUFNjY2dQTmZuQmVFdXJvWTNBZFVGOHd3?=
 =?utf-8?B?VHRXT3habDhJT3lXc2xlZkZjRmNCOHdZUmJCYzVJZXBKYWdtNUhITjVvZGVI?=
 =?utf-8?B?OTVxblZPbTlkektzUlhzMDVjZ2cwcHVBRnlJd3hsRWsxQTJWeWhMRHZUTVRU?=
 =?utf-8?B?cEJ0YWJkUGsxd3ZlQlZxcURHZnFMOWwzUnRmN2FMRzFJV3BVeEd1eVZYRFlH?=
 =?utf-8?B?U3dKNWVpU2l3SWlneVd5Q1Q1eVpodWNNaDg1TWZkeGNrcU1ndS9uSzBudDlr?=
 =?utf-8?B?eTFjNXpac2pVbGdQRzhOQVJyeVk1amlESytDc2s1am1yWXM5ZGtTYTdnek9U?=
 =?utf-8?B?Z2x4L1FlQXBnNXV0S1VBenl0ZTl4SlpaWGM4ejdGK1YwVzBCSTNZaktLVG5v?=
 =?utf-8?B?dnpucDUxb2lJb3IwZjQ5dE9YMklzQjJmTzlZV1dLamJKZmRXSTI5Yk9qR29G?=
 =?utf-8?B?WUFyejFSMEZxaGFZOXFkaU1EUzFSYzIxd0ZkbXpNR1cyZW45d2FlOC9TU2Vs?=
 =?utf-8?B?K2NKMFhraFkxam0zelUyNDVXV0hxRnJudVVPR0U2WE5qa3kzT1RpVGJLUEdo?=
 =?utf-8?B?bnJmV2lpUDdpTUkwVzMyY0hrMFdlQnkxc042S1JZWlBhUk1tN2Zqd1AwQjVu?=
 =?utf-8?B?Nm9STFJXK2ZOVFdHSTdUU056Wkl4N1ZrR0tLeXFOS0lKcEl4SkpGVkVIMHB3?=
 =?utf-8?B?VENQeDdUUFAyRmJmUnl6OHVodFpxRXQ4Y1J5cWxZejZWeTh4azBHY0FiOXhj?=
 =?utf-8?B?Qlp3UWk1WnU3YmNuUmZHaHlxd3UxQ2hMYStTUkVaQUVoblRxZGszM2dCcThN?=
 =?utf-8?B?OFphVm1STWZtclpVaTlCQndTSHBsNURvcFArT2JYdkFoelFqRXVHd2JtZlZ6?=
 =?utf-8?B?RmRUQmY2Vm5kakttOG8wQ1hBMFNVeVNnK1dHQ3hoSjRVSTJrY1lIMnYrcXdk?=
 =?utf-8?B?N2hhejRIdTNhRGpZSjUxZ1dNVE8yd0kyT25BVE5sNmhhclI2akdJTk0xRm9o?=
 =?utf-8?B?Q0RDUFFidndxeERldmRWcUgyUk1hSjEyMGcwVE93bTRnN0pKc0ExUzEyNDM3?=
 =?utf-8?B?aWQxYmI1b0VSeUxSR05xNjVSUjdGNWFuVi85ajVaMm00TU90MTRySHlaSkJN?=
 =?utf-8?B?UzJ5Q3NKQXlLc1dkeFN3UVJkWFVKRXQzRnNTSjJyeWJpS1BLWTdzdWdNcEJZ?=
 =?utf-8?B?MVgrR0lvUFdRL0tKbkw1VlhzRFJING84NElXbU53NGJMRDFma3JhOVpZbEc3?=
 =?utf-8?B?SzBhQmQ0VXM2KzcxWHN0RjhteFhLY3kxTklONVZ0Tnp1ZE05dERMbnFYMEZw?=
 =?utf-8?B?WmN4NlpzeWZYemZleWNscjVONjZCRUk3dGtYOGZ3V1RtSld5bXdFRWZUL3pa?=
 =?utf-8?B?cHpiVzI5eHpsS0pVMjV1Z3ZKZHYxNG1aaDVLSjI1UExYelhkWlBpRjJ6OUVR?=
 =?utf-8?B?YjB6RitOWWkyU2FkQnJWcm1qdkVaaS9rYXFCNTByRGJGTWQvNUw1SmpxOGRU?=
 =?utf-8?Q?ioRGucf4Lf6YQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2hYRVJiSEQ1c1B6Z1JwL0RDYzF0MGdQeUJ6UklKZ0ZIK05oNGdZYTB1bkE4?=
 =?utf-8?B?SUkvR2NrQXY0ZytTTnJ3aEorQlUzR1BrK2crd2RlSXpNU3AyWTQ0bDkySWhU?=
 =?utf-8?B?RTNQQ1pVT1dCdlpaV2F2S1ZuR0tqZnF2SDlKSU95MHE4NVc5U1hsQnFRYml2?=
 =?utf-8?B?TzJlK1RZOHAzbHM0WTFtQ0ZZejVpTDI0V2lpMTN3eFhpNGg0QTVCYmd5NTgr?=
 =?utf-8?B?UGFGdlYzcnFiWFlyM242TjZINnZzdFFTZGg5L2RsS3ZTaWI3Tm5zSDZUNG5D?=
 =?utf-8?B?V3JiZngxUzgzRUdqVGNSTUdWQVp5YVo5Wkx1M0YvTU53ckNORFVqa2Q3cW0v?=
 =?utf-8?B?OXZpWGRESEVUWGJqTEtCYTdsMDRsUXZUQnY4a1dJY0pUQ3VaRlgwU0d2T2t6?=
 =?utf-8?B?R3A5U1FsTGJIdEZkMngzWkw0YTYrb2lvOEgzMGdoNXZTUFEyVitxOWJpKzFT?=
 =?utf-8?B?Nnd4S0dqMGJJSDcwQTIxVFJBY090d1BUaHBIM0lDckQyNVJFNkgzL2dBZ2dh?=
 =?utf-8?B?YW9wMHJwclRzbnRlV0M0U2FET0FHU2RyelltU3FFY1ByMm1LckNLdVhuaWxI?=
 =?utf-8?B?b2VsOEY3WGhJNlRTaEtCTmZ5cVhLczBCSWZGVHNLenR3amtjU2Z2cHJqRGdO?=
 =?utf-8?B?QUlnOTdkakNGWFQ3ajBta0xzZGhjbWkxaWpMZnRLbzRzSTJyMFJOODR3MlFM?=
 =?utf-8?B?aEZvdXN6VFlkeThJTE55ZnpYWGVOUU1qUiswdHU2M3VBVlpaazN4MWNacTRV?=
 =?utf-8?B?bllNSmZEWG9uRHkxSUYwM1VKOExST1hDR2o0WXcxdGd2a0lraHpDZFZPOEdv?=
 =?utf-8?B?K1NvejlOejd2eXdIQlAzcnJaUXI2VHhkQ2hzWmxhN0pqWVJ5L0FXVWd5enBP?=
 =?utf-8?B?V3VaQzl5R0srdS83RnpPVk1uYTB2dFRJZC8yU2tkVkkrRmpoWTF0VDFkcmFE?=
 =?utf-8?B?dURCRDdLMFlNbUcvclpvM1c0KzJEd1g1WUtWVjFWUUZZQVgvbjdiSTNFVDdM?=
 =?utf-8?B?WVd1alZHcDAvaWcyMEQ3c3FydlFIMDVoS1NVdys1T1dkaWJvZWhrRWdTYUJT?=
 =?utf-8?B?RU5Sby9FVExRV3pPZ2NKb2k4QUE3dUF0NnMxQ1RLN2pXTFFpSS92SlhDZGs5?=
 =?utf-8?B?bHQrNWZWejZiekZ2NFZaQ1Y5ZVdpMmh1bCtSVTJ5USt5cHVsODBERk1OTFEr?=
 =?utf-8?B?bFZvMGdkWDEvL294RzdadU9GdGtjalZGTWozdHVMWElWRkJ0d0x6VW9LbTF3?=
 =?utf-8?B?Wkc2c2FMcEdIRVJuY25MMDhJdkFENVBWRU5QUkZka1NpRlExdFkvWFIwY3ds?=
 =?utf-8?B?M3IzNGlJQzNTZUozZ2JucUpBSmRKWjhqWUVaNTlEQjYxZkI0Sy9ZR1JVRnk5?=
 =?utf-8?B?TThNcy9hNlExYW9vRTdxTWtiaWFXRUNhajBxZW9HTTk2K3AyMDJRUGRaZUpw?=
 =?utf-8?B?aWdOTzFOZzZjOS9aam9HNTNVSWZYTzRXQzNYc1BDVCtRYVFIWHljK1dFTTVy?=
 =?utf-8?B?dDNsR3V5dVBRclJsUDdEenRjcHlOUVVzQmlIL1ZOdytLYTI2NWdGRVNHbUxp?=
 =?utf-8?B?ODdyNXU5UThCOTM1NHlrNTErUkYvMmJheE9FWFhCNzZpT1VLeGszRVEycmVz?=
 =?utf-8?B?QkpNZ3JoMTZ6VzBIU211OXpBcjUxTFZLYTJYUHRsQkxpdDJoYSt1dStGZmlG?=
 =?utf-8?B?N3p1NlZZN1ZSMTdNYU9JN0V0OVVBQ1J3RWFFTWx5bllTdDhFZmkwN2paZktm?=
 =?utf-8?B?M01udzdEZzJPbVlKNzFKTk5zOURLU1kva1F2TEVvUXpvYjk4Wk1zQy8yK1lQ?=
 =?utf-8?B?Q0d1UG94dU5xMFBIdi9TeU5PTmhGRUljd0JXMGd5QWp4Wmp3QUc0SHRBQWxm?=
 =?utf-8?B?Uml5NFhNV2lYc0FESGNMUFM5eDBRL2tWcnFTejVnRUh4YTErWmFXa1hleFJi?=
 =?utf-8?B?Vit0Q2IyNlBrQTVUbzFnZjA2dGRIMExMOFE2eU45bnpMMTZ4dDdVT1JGNGhY?=
 =?utf-8?B?VUVvS1cxV3J6cVVyRXBmaGRrek05bzRoeHFtcy9KcE1vZlR3VXpneFcxWmFG?=
 =?utf-8?B?RmVRM0lEQy9aV2VsbUJsWkF4eFFic1d5Wklpc2k0NnkyNVo2RlFVbmNHVTVa?=
 =?utf-8?B?MzYxZVpWRXF4MkN4SVB4dUcvL0R0dlgxUDlDSEpuWUdraitCSUMvRUt3clZi?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad1e391-6a09-49d0-444f-08ddebd97e96
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 17:35:53.1089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWdSgPvJZ45bhRd7ETpa1Zn4d7rX580s9TGI+vH8RHxhiRp8oaqym7JgAGlId5GFWIhuF/kwtOblGMSgHJchkQ13/870gvLIINw6UzwC0XY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8808
X-OriginatorOrg: intel.com

Hi Babu,

On 9/4/25 10:21 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 8/14/25 21:25, Babu Moger wrote:
>> Users can create as many monitor groups as RMIDs supported by the hardware.
>> However, bandwidth monitoring feature on AMD system only guarantees that
>> RMIDs currently assigned to a processor will be tracked by hardware. The
>> counters of any other RMIDs which are no longer being tracked will be reset
>> to zero. The MBM event counters return "Unavailable" for the RMIDs that are
>> not tracked by hardware. So, there can be only limited number of groups
>> that can give guaranteed monitoring numbers. With ever changing
>> configurations there is no way to definitely know which of these groups are
>> being tracked during a particular time. Users do not have the option to
>> monitor a group or set of groups for a certain period of time without
>> worrying about RMID being reset in between.
>>
>> The ABMC feature allows users to assign a hardware counter to an RMID,
>> event pair and monitor bandwidth usage as long as it is assigned. The
>> hardware continues to track the assigned counter until it is explicitly
>> unassigned by the user. There is no need to worry about counters being
>> reset during this period. Additionally, the user can specify the type of
>> memory transactions (e.g., reads, writes) for the counter to track.
>>
>> Without ABMC enabled, monitoring will work in current mode without
>> assignment option.
>>
>> The Linux resctrl subsystem provides an interface that allows monitoring of
>> up to two memory bandwidth events per group, selected from a combination of
>> available total and local events. When ABMC is enabled, two events will be
>> assigned to each group by default, in line with the current interface
>> design. Users will also have the option to configure which types of memory
>> transactions are counted by these events.
>>
>> Due to the limited number of available counters (32), users may quickly
>> exhaust the available counters. If the system runs out of assignable ABMC
>> counters, the kernel will report an error. In such cases, users will need
>> to unassign one or more active counters to free up counters for new
>> assignments. resctrl will provide options to assign or unassign events
>> through the group-specific interface file.
>>
>> The feature is detected via CPUID_Fn80000020_EBX_x00 bit 5.
>> Bits Description
>> 5    ABMC (Assignable Bandwidth Monitoring Counters)
>>
>> The feature details are documented in APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>> Monitoring (ABMC).
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> 
> This is an FYI. I am updating the text about the documentation to address
> your comment.
> https://lore.kernel.org/lkml/53387aa7-0e72-4bf9-a188-43c0f78c2d6f@intel.com/
> 
> 
> The ABMC feature details are documented in APM [1] available from [2].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>    Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>    Monitoring (ABMC).
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]
> 
> 
> 
> Hope it is fine.

Yes, thank you. I think this is a helpful addition. I assume this change
will be applied to all patches in this series that contain this pattern?

Reinette


