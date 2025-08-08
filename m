Return-Path: <linux-kernel+bounces-760660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32550B1EE54
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C91407A414F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 18:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99D22652B2;
	Fri,  8 Aug 2025 18:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gtXcraOY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CB3218EBF;
	Fri,  8 Aug 2025 18:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754677424; cv=fail; b=ibgEzpSaVFQLqw8NvMnKW2jbe4d/dmHjl4kEkwnRfxQpAySH6OsGVAlAat7FhfvYiAcIZnAOfavn9av7Id48W2Th5RBkKecs6Axl3+OiufA8KHcmDwoSkXdMLCbXxRtQSnUxcJQiRX47B5VEmcn60t0SOifcOBF6QzOHyCS1bVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754677424; c=relaxed/simple;
	bh=L1zkymSvvrLDTbSnJWuNlqn+9k5m8HXoNcCjrl7Jc9U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sX0razm+gVBFs+ZuD0gcWAl6VKJRsrjG++nn+0QLJFfVsxFyCMk43UDwZoc95r8m7y3gJh/MyhVgz+gn+wCIibRpOuFZuyXh/dIaU7nSDTppv3Bm8ZT8m9Ivhe4UAKmOoTKR23wxA5TZXCMrXv0T5LfXwDp5F6+M4oVgK9/J9So=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gtXcraOY; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754677423; x=1786213423;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L1zkymSvvrLDTbSnJWuNlqn+9k5m8HXoNcCjrl7Jc9U=;
  b=gtXcraOYYS3RZj/fltYsNwyPtr0TmhMbmGr1AI30Tt7cgf40q/PO8uH8
   GEfpVf0WBIORA3rTOkW4Z4HZSzH6731fIz0sNfw5OrjEYEIXgsm0yp4EY
   hsUnJN/FxGjrGGR9ZVrCVzA3cvb4CmlOQzlfe8ZNrrymIqwWT4gtErm0R
   nxxFBWn3Ae+LIVrCzlblJhbUJWnRZDAp/pZegZLGM+uuvixuNNNCQeVsV
   mVZ2ovprID49nVVu+bGG/eBXcjMXlQWzG8V5chhH+ERcR7Q7M2AMo+5wy
   We/AUbJOpuzA8SgYP4MsR1+HhGM9CMaL6O1rcF08QkZhusaMlIgsqLyEE
   Q==;
X-CSE-ConnectionGUID: /88STUkqQ3G4SV+zEOKlAA==
X-CSE-MsgGUID: C4SMMWnHR0u4f3v7ipDiMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="74613446"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="74613446"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 11:23:41 -0700
X-CSE-ConnectionGUID: sQH6UcgjT+uJVSPEWE7GIQ==
X-CSE-MsgGUID: Bb877iZ2Qjq+f5af+KR0XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="165395069"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 11:23:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 11:23:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 8 Aug 2025 11:23:40 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.42)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 11:23:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhQdASaJZhoYHvM5lhJYlOcD+pmzzMNE6FwZgJBXjTzfpye/tyqSonG9yFelj4jzj3neZUy6ZxWFet386LQqMVyhMXNELqbiRy+E6YRv1i8w7phYPc3On21lVyzKoNwrLrDwVKhMD1zlxSStW2Oi+QKTIuM6RCAIFWSeBTjH2Ilq2LBmFA8mBVEj/nGxh/8F6SOb5pV9DV6WMfFkVDHtL6aLDBAdQtfFHqj1I6WMco+3Sc7+31y23noA4FS2JZXU+F6gndhj5jbyFECwl8DCFGZJXTD9DKNgI2Ez49Inc2R2iuZdm0GEsPswcFOIaDh/8xLEwnBvelXfsVXLiMjMpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEEgB6efaP7ayBYolQr5Om/E3Knf0JwnutXGrCOM9io=;
 b=DKyqx3OR3fCigu1u0aSM4HKPX/MCfcmnHhZr5I1MNkx3L7h04mF6y5H5zibhU8LMqsZkrZj3/vM9fopt5LEREHYAZyaSkl38NgrkEHK1qyEBJNlGlTUJJmYnr9PrCK34IKR0M3wDTy3fDRez6426vSDTCf7cVdlPcl4zJK3k81M37tevbIROgeYQByVNc5T6t1QHlsZ0W55T6NnWZU1u2oeyu5IU1kcvqnq26aly3ARqFiCdmI6PJAJbk3zgRwRL4ALYaqLqzbHmWjDV1kruJO1XKoWzt5f7tMM4axWMClS1EGCQs01oyOqeM0Q2zJJveZD9WgpDG4I4RrVlsbeX3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB8320.namprd11.prod.outlook.com (2603:10b6:806:37c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 18:23:38 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 18:23:38 +0000
Message-ID: <c2245bbd-1bf8-4fad-9c1c-9f0848c7da39@intel.com>
Date: Fri, 8 Aug 2025 11:23:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 25/34] fs/resctrl: Add event configuration directory
 under info/L3_MON/
To: "Moger, Babu" <babu.moger@amd.com>, <corbet@lwn.net>,
	<tony.luck@intel.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
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
 <13467b9a56bccf960974741741b4960a8f02e333.1753467772.git.babu.moger@amd.com>
 <99614342-b6ce-47ec-baf9-f5cdf42f77be@intel.com>
 <40d722fc-e08c-4543-973a-3fb7ee29bf2a@amd.com>
 <1a19e3df-2915-46f9-9677-c369aa31adf7@intel.com>
 <0ce4f15c-40aa-49fe-82f1-3a30d3e56f35@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <0ce4f15c-40aa-49fe-82f1-3a30d3e56f35@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0336.namprd04.prod.outlook.com
 (2603:10b6:303:8a::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: c5427a39-6b89-4408-00ce-08ddd6a8b170
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlBWeUNFTS9pYmZwTm44NVIzRTFzN0ZvcVBBTW1qbVF6MVRDcjlKZVlleHZn?=
 =?utf-8?B?M1NEQnh5dUVwZlJldHNXZ3BxUVJRS3lFRUxUWE5tQ3c0V1JzTG0xdlF2aDha?=
 =?utf-8?B?K0hBeGxGcGpNRkw5bHc4STRreUw3SlRHMm5nOGk0M092anNaVS9ETHl6MGRa?=
 =?utf-8?B?b2tGMjJwS2xibjlqb1hoZHlKY2pldTJxUC9IMi9NcE1pZllGT0g1YUt4WHY2?=
 =?utf-8?B?QWFuVW43SnZMclZtbURmaUwxMHFIWWx1RjVXaGxaUHFHVlorQmFRZThOellG?=
 =?utf-8?B?ZDVjMjdQSUpmaEVIRFVuVnBCSnNvMVRGNGF2SDdKeEtzQWJ5dEpWY05mY1lW?=
 =?utf-8?B?eUpFWEdHYjF0dVovVzlrREl6bjhrSGIzSUVRVWoveXUzclFHRUdEUU9NdThj?=
 =?utf-8?B?TTFBc2lVczRkK05xN1ZTK2xaaHA3akM1SXVFSGtpUzF3VFJZMGt1NHIyWGsv?=
 =?utf-8?B?aTc4a3ZqTTFpaU9VaW1PN0tZOXVmeFZOT3R1d2ZSL0VvVmJqcFNXUE1xUDRs?=
 =?utf-8?B?ZEJ4WURkOTJDMmZ2a1dtclRIMWlpcjRkZmJINEtrODNUS2FPYlJ5VFhrVGRj?=
 =?utf-8?B?S2R1SnlGWEFLUUtncFdJTWZYelRpK2UrUEtqeGZ6YWM1bjVIK0dPLy8wL2gv?=
 =?utf-8?B?QmF3TFNlMEZOYnd4S083RUZkTmxxWlQvRnZEK1lPU201cFJGUjU3NDd5aW1o?=
 =?utf-8?B?NmNZZGJiLzl1cVZwTnFWM2NMdnMrcGIwOEh0K2FLbVRqWSszdSs0ZmNnWTJG?=
 =?utf-8?B?NWFhWjZ3NDF6dGtkWW9HSVpJSmRoam9hZURoTlN4MjFwc1FzMFZLTGdIdUdV?=
 =?utf-8?B?QmZtKzZhKzNUNFJaYWdwU1FrbUJaeHRrTEh3VFNMRXVSSnpqaVBXaUd1QlJN?=
 =?utf-8?B?NHpOUzZ0MktiVmdvWlZ4RFNQL0hSdEx2UnBYamlrWW1rSEpNS3owaGpiU1hp?=
 =?utf-8?B?cGxTeUtBVWdzUlMyelRNeUp5QjJkTHg5L2k1c1VyYmUvMHFTdCtFS0RESGdE?=
 =?utf-8?B?ck1JSVFiaDRoMTVLbmloMDNoTGgxa0NRcUlBdnVhWWYzamd5NC95U0FuUGRJ?=
 =?utf-8?B?WUQ1SlVXdEpzOGJRSS9DcElhaldCR0hKUWNaUzZ4eDJvSFAwRmNnVWJRTy8y?=
 =?utf-8?B?dTMzVDlwOU1EdTN0RzlTUGltZ1UyNnlkYUpnQ0REUUZMb09hbmZqOFVOSXBy?=
 =?utf-8?B?VFJGcHBCaDU3NnNSakNjNDdkKytNNmhrbHAxdVlqU3BsaWM5SThURUlTWlZl?=
 =?utf-8?B?SXdoWVNmdWcvRG55SUVyejFwVHBJcHpmMlFiQ0JkcWxkSmx0QnVIbEFGeldS?=
 =?utf-8?B?M0dDWkxCVHBIOXlPWDhyOEwxYTUvTXE5Q1doSjlNY3Z3bzcwVENiYWQvWEgy?=
 =?utf-8?B?S3hIeGdidWJ6WXZ3UnBPNW9Eb1FCaWRXSTVFbmZiSWtlVG9YRzZOUTh4aStj?=
 =?utf-8?B?ZDNDcy8rRm5EdEhIM2FWZFZNNHpUNHkvR0VuZFJjYzRxb3Q1dmRRQmFHdmRx?=
 =?utf-8?B?dll0L0ZuRjNmOWNQYnlSUG1hTktYblZGRGF5NkpUMkhyakdURmxKeWpWc3FW?=
 =?utf-8?B?VzEvcG40TDlZSFdmVEswOXZWMkRsODFPMVVYTzFNQWRFWEZWVHczZXRTSXBQ?=
 =?utf-8?B?dlIrRjVGMzRtcExGb212dHNML3dqTVlqMExCWVNrK2VKYmRmdlhKVldwQkdj?=
 =?utf-8?B?R3prWHVVRFhpeVRQYk9iYzZjb0syczVTdVNxKzVjQktzcXNnTjB3NDd3ekdm?=
 =?utf-8?B?ZjhNRmxyNnN0MkphZDRseWlGS1RaRG5nS2hGaG1NN05YWVdxUFdCa09neVc4?=
 =?utf-8?B?MC9SYnEvUXZsQi9tUzQxZWIxRDErUStPSExlempvZmRQNFlQS1V2cGowQUF3?=
 =?utf-8?B?VGxySTYwUlFEY3RKUTUrYlR0YjRqY1cvZ1JLdHJiaFpYVmNwSjJJMEppZDds?=
 =?utf-8?Q?1yFsLVoutvY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDNxVDk5empmemhHVloremJyUWhzelVyR3BOTHc1VW5POWljUHNVa1dhM0VC?=
 =?utf-8?B?TTRUNVhIeWlLNm9xeitqNzRvNlpydEsyK1BnQTJrblEzZUFsVGNrMWJqdmo0?=
 =?utf-8?B?VE1vZGhKWnRuYTNPOUk0K0hBWUFja1dKWjFhMHhER3hQUWxoZ2lseE1TV2p2?=
 =?utf-8?B?VFFCZlZQeTkzeXpGUit1S1NobnVPeGQ2a253U3pIdHlEQmRYU2xUK1J4Zzdu?=
 =?utf-8?B?UGdsZTRmR3JWSW9tUm1kbXdZZ1pMUVRPRjJjSEY1eWFRTjZ1MlpSNGN0aXhP?=
 =?utf-8?B?MlRRTURTWmZIa2pBYS9iZWFhU2xpSUljc0pYLzQ3MWRvcGpkbFRpTTJWdm90?=
 =?utf-8?B?TDMzaitSZjlKQmQwdDduMWhQNCtjcWlLamp0d1ZibzU0c3RmUUczbDJkM0Rj?=
 =?utf-8?B?VVdUeXg0aWpIQlllQzBhVzZOdG0rR0hnQ3YzZWFERzhZbWRFdmt3OWQ5TU1m?=
 =?utf-8?B?WGltMVgxWmRXa28zSzJTaUJ0NXV1dU1NSnZLbUV4VEFNVEhNTE9ueCtOQjdt?=
 =?utf-8?B?NkpQS080K0NDZUNGNnlITjJoOGFlZ0dKZlQyM0k1WStqaFBoY0dmaTB1bFR0?=
 =?utf-8?B?aDN4anFrNm9JLzJGUUY0QmF3bUlRYUdTQ2sza1Njbi9OYXB5dTE3Q0d5bmMw?=
 =?utf-8?B?eU9Vd0xUUms5YnZyVkdEdS9KL1hPZTBsVnU5T0NGSUpnbyt4MjdEdmdzSnZp?=
 =?utf-8?B?K3duWm9OeWpicE5GTU5GaGJTVXVFdjhRN3cwT3poaFdxK0Q4TFhHbE90b2V5?=
 =?utf-8?B?ZDlPcjJlY2x2VjhjMFErY2FiUStiRlBuVkt3NkZIbFdnUkNlNFBVYUEzWGNy?=
 =?utf-8?B?UDhJTmp5NXRqZVg1SHFQQ0JJditZZThycCs5UHFZd1ZidURYdWlBRnFYTVdB?=
 =?utf-8?B?enloRDhwK2ZaTllSa21UWEZ3dExzcXY5ZmIxSlZwSGl2aU9TNXUrS0FxeXVX?=
 =?utf-8?B?YklkM3FmSmZMbnZ2Q2FqNVh3RnNPQzVkUUdYcWdReEFJTHF0QjdIV1Vjcmpv?=
 =?utf-8?B?YkxMeW9tV1hhZFpFWkNkc29ZcUlUMDk0WVRoMGhjZ2x6b0hRUW1OZ2xWS050?=
 =?utf-8?B?Ym1Xek1BRE5HbjRaMmNJbnNHZkZRTURncGpxTVJGenVzeVhaR3l6d2ZOZ09C?=
 =?utf-8?B?Tm0vLzRma09NYy9DRm1KNFZkeEpQQ3FXK1RuMWtmeU4rci80NW5WYndVdEFR?=
 =?utf-8?B?ODdPbnBUN1hxNks5VHZFZVU2WE5aRTltZnZuNmlXWlpINGJmNkhkYkhyMytJ?=
 =?utf-8?B?dlExVll6cXUzRjhrdXNRZ3YvdE9wYWlieW8zaXM5bVc2YmpPaGJ3cE9hYmxt?=
 =?utf-8?B?Z29EaUdCQU8xNmJhT3JQREhOcUZmbmh6VHlsZDhaN2ZIQ2JDeWY1cUdORGw5?=
 =?utf-8?B?ZUxTZDE0b3JSbkhkbDFRYXZ5d1YyZVlRRDVLZzBPbXJaeVh5dW5NL3B6RFBa?=
 =?utf-8?B?a1p0N0xGLzlURHg4YzkwRVpxdnRHMWNSV0M2cTRNdlluYzNEbDN0ekJaNEYr?=
 =?utf-8?B?dUs4bnViWHpFZEVsNTZ2akdaUDdUc3FkYjJrZjdSLzllTC9xNlRsdEVSWk1E?=
 =?utf-8?B?MU9xeU45emVoSFpsYW91TDlpeDlpUFFPeHQwL3k4V1IrMW5VL05JUVBpOEZO?=
 =?utf-8?B?ZFl2ZEdpUHBaMHozcEIxa1ZKQlliekpxZElYZmJ2c0oxZEpma2hIdTJFY0Y4?=
 =?utf-8?B?cE5OUjhpejB2NFFuWFN6aFk5ZVlIRkdaaDd0Z295b2FpWng5aldLWk9IRzNU?=
 =?utf-8?B?Z1kwc2wyY1h3bjh4RSt4aDVUSDYwbFNna1g5eXBWMm1kY3hxdWhTUFpoTFV3?=
 =?utf-8?B?MDFYRmU5azlhR2VRRUhGTTlrMGgwQmhnclFXa2hpUVhGOEZidW1ZUDNiZTdj?=
 =?utf-8?B?RXRnTC9DSWQ4WGFRVnFYM1o2WXJYd2cwcUIrYnJVNjRNdm84QnNReGFuNjI2?=
 =?utf-8?B?cVdvZlhXZkhianJjVVVvTHNGL3FnVEVsK0lHYUpERDFUbEl2RTNjMVppVjZm?=
 =?utf-8?B?TEpLVlE1dDBKSVVnNWVVUzJDd0RSa3A5R2F6NlhHcWdLcEtsUGYwSWF6YVJr?=
 =?utf-8?B?bGZidWgzNlhEZnl1em5ka3RSaDdOVlF0Q1lzY0RGNmFaRFpDR29lUzJXOUxW?=
 =?utf-8?B?ck9lZTVvSEx2Q0ZGSzNFdEtXZTkzdHJkYlhtRE16ZDArQ2ZrWTBhV291R1VO?=
 =?utf-8?B?WXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5427a39-6b89-4408-00ce-08ddd6a8b170
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 18:23:37.8686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3LbxLmTH2MNjroP4LOHLRXONpKLUV/ztywWoyfnCOk50+EKV72d1gLvI3BRfps9mxKfnFD/c+7asmXhcS2roXDbRU9EvUvXqWHP2NmKrS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8320
X-OriginatorOrg: intel.com

Hi Babu,

On 8/8/25 10:47 AM, Moger, Babu wrote:
> On 8/8/2025 10:12 AM, Reinette Chatre wrote:
>> On 8/8/25 6:56 AM, Moger, Babu wrote:
>>> On 7/30/2025 3:04 PM, Reinette Chatre wrote:
>>>> On 7/25/25 11:29 AM, Babu Moger wrote:
>>>>> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
>>>>> index 16bcfeeb89e6..fa5f63126682 100644
>>>>> --- a/fs/resctrl/monitor.c
>>>>> +++ b/fs/resctrl/monitor.c
>>>>> @@ -929,6 +929,29 @@ struct mbm_transaction mbm_transactions[NUM_MBM_TRANSACTIONS] = {
>>>>>        {"dirty_victim_writes_all", DIRTY_VICTIMS_TO_ALL_MEM},
>>>>>    };
>>>>>    +int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, void *v)
>>>>> +{
>>>>> +    struct mon_evt *mevt = rdt_kn_parent_priv(of->kn);
>>>>> +    bool sep = false;
>>>>> +    int i;
>>>>> +
>>>>> +    mutex_lock(&rdtgroup_mutex);
>>>>> +
>>>> There is inconsistency among the files introduced on how
>>>> "mbm_event mode disabled" case is handled. Some files return failure
>>>> from their _show()/_write() when "mbm_event mode is disabled", some don't.
>>>>
>>>> The "event_filter" file always prints the MBM transactions monitored
>>>> when assignable counters are supported, whether mbm_event mode is enabled
>>>> or not. This means that the MBM event's configuration values are printed
>>>> when "default" mode is enabled.  I have two concerns about this
>>>> 1) This is potentially very confusing since switching to "default" will
>>>>      make the BMEC files visible that will enable the user to modify the
>>>>      event configurations per domain. Having this file print a global event
>>>>      configuration while there are potentially various different domain-specific
>>>>      configuration active will be confusing.
>>> Yes. I agree.
>> hmmm ... ok, you say that you agree but I cannot tell if you are going to
>> do anything about it.
>>
>> On a system with BMEC enabled the mbm_total_bytes_config and mbm_local_bytes_config
>> files should be the *only* source of MBM event configuration information, no?
> 
> That is correct.
> 
> 
>>
>> It may be ok to have event_filter print configuration when assignable counters are disabled
>> if BMEC is not supported but that would require that this information will always be
>> known for a "default" monitoring setup. While this may be true for AMD it is not obvious
>> to me that this is universally true. Once this file exists in this form resctrl will always
>> be required to provide data for the event configuration and it is not clear to me that
>> this can always be guaranteed.
> 
> Yea. It is not true universally true. I don't know what these values are for Intel and ARM.
> 
>>
>>>> 2) Can it be guaranteed that the MBM events will monitor the default
>>>>      assignable counter memory transactions when in "default" mode? It has
>>>>      never been possible to query which memory transactions are monitored by
>>>>      the default X86_FEATURE_CQM_MBM_TOTAL and X86_FEATURE_CQM_MBM_LOCAL features
>>>>      so this seems to use one feature to deduce capabilities or another?
>>> So, initialize both total and local event configuration to default values when switched to "default mode"?
>>>
>>> Something like this?
>>>
>>> mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].evt_cfg = r->mon.mbm_cfg_mask;
>>>
>>> mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID].evt_cfg = READS_TO_LOCAL_MEM | READS_TO_LOCAL_S_MEM | NON_TEMP_WRITE_TO_LOCAL_MEM;
>>>
>>> We are already doing that right (in patch 32)?
>> Yes, but it creates this strange dependency where the "default" monitoring mode
>> (that has been supported long before configurable events and assignable counters came
>> along) requires support of "assignable counter mode".
>>
>> Consider it from another view, if resctrl wants to make event configuration available
>> for the "default" mode then the "event_filter" file could always be visible when MBM
>> local/total is supported to give users insight into what is monitored, whether
>> assignable counters are supported or not. This is not possible on systems that do
>> not support ABMC though, right?
> 
> That is correct. With BMEC, each domain can have its own settings.  So, printing the default will not be accurate.
> 
> What options do we have here.
> 
> How about adding the check if (resctrl_arch_mbm_cntr_assign_enabled())?  Only print the values when ABMC is supported else print information in "last_cmd_status".
> 

Did you perhaps intend to write "Only print the values when ABMC is *enabled* else print
information in "last_cmd_status".? If this is what you actually meant then I agree. I think
doing so places clear boundary on this feature that gives us more options/flexibility for
future changes.

Reinette



