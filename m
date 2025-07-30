Return-Path: <linux-kernel+bounces-751289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 914B4B1674B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8D21C20064
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6F0199FAB;
	Wed, 30 Jul 2025 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nNldZGmO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677C535953;
	Wed, 30 Jul 2025 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753905731; cv=fail; b=kCaVeH8HXbAcQRK2ijx0r44erN8DXloGb0BpfUJX1hj9OxJM/mJ57kIjFsUznjlBKkoZbl5FH9FgLhyMTFlmshmROWwldLNqf8GBIO2lItOP2ddkqPsREOvmKVQXCbs5/iz3lVecQZ+vxd8IUlJMIO6hF9zamjB3I1xlmD8z5M8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753905731; c=relaxed/simple;
	bh=4QqdqGBNgzIDEdx9kDG2VCR1mpyPYDdsOU8gdNMT5mI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qeApcrBYRjT2lRRJeOSYz4HsQWjjJ970j8SBq7pafBW/whc/1PkReyeQ/VJzbDi7OS3aq2HM5+39cAII4KMk4GDin1O8FfeN3fNQaqGQZCX2LLEU/Lupk2xaXxq1XLx5xFh/+8ppyEnbCn9CFCZr8sd5xOzLzrVr7ffw+IZpXEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nNldZGmO; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753905729; x=1785441729;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4QqdqGBNgzIDEdx9kDG2VCR1mpyPYDdsOU8gdNMT5mI=;
  b=nNldZGmOpqhWCR2tlNqVZ3lu50BPYgpfh3VU1h7FGSqQ2mjKGOnel6Xs
   deHb9SOzlBjtabzNtHM38XciG/ZQMBmtM6Rw+o8o/JBzlwOT6il1bxNjL
   NehPlYls58vyp2dd9ORPeNhmcS1dlb0Kc/0MpJzfuh0xTW0+t8kiwewe0
   UDP2wZkEVhEhHa8KxbQLRdgmRI2voNhf8SDtRMBbuACkTwZOkYuLVBJCl
   OZ83rdg4WOs4hzVrKqNsGSNvqaJJHYwGuLGYlGw24zxvV+1wisIf2+TF8
   +twgJtFzNG0bc+q4HwVDnlgB1W1wNCd7IGd7jgIO0jk4Z4Ib1KlGWpOE/
   Q==;
X-CSE-ConnectionGUID: QeYc2TkMS5+mRo39emxH+Q==
X-CSE-MsgGUID: LTfwPEy4SkGIZXNigoshgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="73808525"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="73808525"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:02:05 -0700
X-CSE-ConnectionGUID: yRsouUDoQ4mSJLLSvJ8Y+A==
X-CSE-MsgGUID: AAEbGmBORviEHhMpAsDT6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="162956951"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:02:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 13:02:04 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 13:02:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.61) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 13:02:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0/cBtNovdV6L94ZmC3EKHl5KjQnqAzSvLI27kgm2Ex9UGVakrVnX0Y3DuXjLdKlQdXORJ8XpAevcaKltkU5hJvqV0DpJX4PmyIxH/YM7//3H3Uvn/PlFKn9856O81fQdgtJk9o90mHMuBilCtac15/KNl7XDrsSqiw67PBsdj3U111r97g95bJDQapBa922Da0IS9ZAdm9Q1ZWdt+XctcDXtDqghhf0I9Qm8X6JF10ufB99tSXBMJDxH7g2cl2cWIfCk04QIw20myQ6lsKweYipVPgdv84BCPK1ZEQS5qaoE/Ugt8pYiE9JYQFeNjZUv3z5FLq1eL7vXy+2O4NheQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EyNQhKPsIvovOLHSDCSyTh8KVZdaOIZYcRQmGxtZL4=;
 b=jfq0asKenRuxqNMhvA1Yv/gyWKUAzu75gC9pKMHOu1T5avLBqYwAg9eQJ370IRGO3oZC9lKrwQjnwWfRj5CTJYUA8vCxvgOty28fR3zPp3wyGy54LV48uJ1visy6/54hPWHN4T0B5TiiU2RmivhBDkQfjQ4BjCkRc4b9lIvb/AFmM3ohk3nfFVim+Ni8aHFXjF9+ghDnbCNvKJiAT9PHhBhyuQRKgDKkSHOn55AY/lfhAwiYaIXOwOvtoQn1MyCNDXCjxonxaEc8HVJ7Fa4HlgTPhm6Baj97shFVWoDHowWgBj/zN/Bq+1xa+Mqh7YEPVpkgu66HEnt24D0hBMe+yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV8PR11MB8582.namprd11.prod.outlook.com (2603:10b6:408:1f7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Wed, 30 Jul
 2025 20:02:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 20:02:00 +0000
Message-ID: <8ed4970e-de37-419a-978f-8eb13c260e90@intel.com>
Date: Wed, 30 Jul 2025 13:01:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 22/34] x86/resctrl: Implement
 resctrl_arch_reset_cntr() and resctrl_arch_cntr_read()
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
 <c11095389417ce2dec319f20619b3b13bddd5973.1753467772.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <c11095389417ce2dec319f20619b3b13bddd5973.1753467772.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:303:8f::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV8PR11MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: de35647c-6afd-4f9b-3a58-08ddcfa3f1b4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1Y2b0syMzVrTXdIUWliOVVUMGVVQ3RkNFRUT2VNeXNwMW53UlZsNFJyTzJl?=
 =?utf-8?B?enNwM00wQ0NuMUJ3YnYrS1I4eTkvclZZdmFFc1FFOVpmTC9zbW5EN1g5dXpl?=
 =?utf-8?B?V0NIclVzQ1dsOFJNS2hGNXdFcHEyZnlQOHhTdnlNWWQyalNsUVJsQ0h5bG94?=
 =?utf-8?B?YXREdk1NWDNrMStBTEtodHpraG43c1p3UnNENFI1UkM2UVhGcUw4UmlOamF1?=
 =?utf-8?B?ZnduY2g5YlE1bUw4RkltU0F6bUNIV2hLRUFMUjR5enRhNk83WjEvaWpHS3A0?=
 =?utf-8?B?M0YxNHcxNDlTc3RoQm1yNHl6dy81eks0S1d0d1c4WG4wMXhIRmpzcFpybktK?=
 =?utf-8?B?MjJFb1FQcjBUU1RGc0ZhWWpicGpSLzBBUXBIR2EvQ0JBQXZoL1ZFYy8zWURt?=
 =?utf-8?B?L2E5ZFZCQ1JlTHk3bENSa25sVm01VklQUmNNTEhFdWtJV05QYTVHR1Q3MGkv?=
 =?utf-8?B?OVg1d0hSeDdDdWs3aVM2ZFBwUXdpZGRIVFZoVC83d3ZnMEI1bk5VTXd0MWtR?=
 =?utf-8?B?ZVNrUjhHa3RDME82MVI4YkcrRlNHRFNWUUlmSDhrNHMyTEwrSzU4NW8yYnZ2?=
 =?utf-8?B?b0JsdmRpTnRWbk1rRVVKVjN3cEp2R1l0Q3lnVW50REY4cGJGd0lwc0dGMHdF?=
 =?utf-8?B?SHRrYXVWREZsKzlrOWhnQWJFclV5d3VoS2ZuRWFRTXgwUlpaTDczdHJ0aWF6?=
 =?utf-8?B?anM3aWl4WCtTUnN5dXlTbXBad05IOC9CREdXb2F1Qk9XLzN5SUVnRkVOTEto?=
 =?utf-8?B?aDFjSDYwL3F3NjE0V0ZoVy83OW9zMVMvcmIxUHhLVjhkKzlXYVZpSVR0WjQw?=
 =?utf-8?B?SXNtUHpJYURGSzc0MVdQc2tqMmhqTEc5eWZwbStraGI0bjB4cXRuY25JR0ov?=
 =?utf-8?B?NStpY1grd2VDL3ZVOG1hQW9DNEZuZFNLVFFCZ00wUFRuV0djK0xoQndFY0Yx?=
 =?utf-8?B?eFRHeitQeWVGUjl6dWhvY3pZRlltRUVqYkx4WXlQL2tIc082NFc3MmlVOE5q?=
 =?utf-8?B?UHlhcU5GclRaeEhuRFF0YjJpdzJndE91Q0tyRWtiYTlwbzFWUyt5QUdMVm8z?=
 =?utf-8?B?U0FDTWJuc3h5aG9Cb25sSnAxeGloZWhhUzJTazBPSUw5ZDgyOXM1ck9EZU94?=
 =?utf-8?B?MnVHVEhWMmpHWWQ1VHNWRi9tMVBOcFU0a3JRQ0RKMGxpVlFWTlR1NlAvdnBP?=
 =?utf-8?B?b1IxczgvVUlqSDhNOTVVS1hqeHZZa1FjMVRaMEVJMlRqRVpEQjA3NG1BTjNB?=
 =?utf-8?B?QWl0K3FkclRPYVVnOEp4ODByRDRobzhUUjlOWUxlVWw4Yjg0Y2RYWVl1ZEdy?=
 =?utf-8?B?anlxd04rVzBxcFcxbFNqbEdCdU02WFRmeUhCT3hzQjM5RHdRY09MdjJqcjV0?=
 =?utf-8?B?c2xGWHRtc0tPVzA4cTQ3RFJodHMyRFduN0g4WUJKUEdpZ2Z4NGdBa1E0Tndt?=
 =?utf-8?B?eW8zNHI4UXJLVWpsbVJaQ0xKc2dUUVJtM05PQmtGY3ZuKzZVOCtISWF5MWxp?=
 =?utf-8?B?RmN5aUlYZUkvRGtDbWRWVGRyd2cyWHg5bUhYOXhKVFVRRXkwZ0Nmam44NXdy?=
 =?utf-8?B?RzZ3ZCthTkJZamtiUGRTK0dSZk5ockFzTSs5Nk5jVURiLys0RllIM0VaMWQy?=
 =?utf-8?B?S0NQai91V2RPeXp4d0NqZHU1dysxS1NSUWE5NGdIZ1ZUNkJIZ2dCdkhRT3dP?=
 =?utf-8?B?T2NvaGdMeHhlbEtESzUzT2dMc0ZNRXpzektYV293eFdSczRKaHgrVVpuR05s?=
 =?utf-8?B?czRNd0lmYjEyY2NLcnQvR1paOXhrNTdxdVhLNVZrTW1GcjlZY2R5ZzkrZklj?=
 =?utf-8?B?UHVBRGRUTDV5Q29pQS8zYnRMSitibWpEVXdzMVh0dHk5bEpFOWZQVjFNd1Z0?=
 =?utf-8?B?M1ZXVVB3aTI4cFBreDAvL0MrdWMwKzhLeG1LWEkwbk51ZnVMNE5DZVljSEQy?=
 =?utf-8?Q?ea6EZzGGnlk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkRvZWY0eEliRXhpaUpFQ0NaNDhjakxhS0NsZDB2Q3FpVHRuUk5MR2R0Y3dR?=
 =?utf-8?B?Sk50Yk81RWNVM3h4cU4vS01QK1JyZnJualQ0bGF5QjB2cDlJbitDQ1l0TTA2?=
 =?utf-8?B?OW1tTEdzVXcyZGpLRFBHejJMSzM4Q1BNRzBiVDhZVVhJQ1Bjc2tEc2phWkt5?=
 =?utf-8?B?ODhWSStRVkpjbzFOM3YrTlBnM2gyVEcwd0craVpGbHdjcVFNZXY2SmQ3bjgx?=
 =?utf-8?B?a2pMdzlFU09Hd1JLNjRZZDBJMTFpekhsZ05mUVVFVGoxSnpHSUNlMjIybkpD?=
 =?utf-8?B?TytMVmVXZWprUVJ5RHpkZG5HZWNDVVhEYnU3QmtXOWpMRHVKblZRTDZWOEc0?=
 =?utf-8?B?eUxiMldFbFplN2pWRXpUUXAxR0VnbFpLN0RpQ25QNGFQZ3d2Ky9RMDEzSlQ2?=
 =?utf-8?B?TmJLUWpZQ0V2ZlNsSkVoSXVYWExQQ1lERDRQbFlVZjl3VE1UV3JqU3piMXN4?=
 =?utf-8?B?bmtVTzYrcExIUXU5aktWMnBTQ09kTVo3b1N1RGJsd3lndTI2bWRzbGllazZ3?=
 =?utf-8?B?eEtGdk9xalJ5VThkQUw3ZjRTWnVlNEowbWgzQkNGWWUvYzN4M252aTNaMCtC?=
 =?utf-8?B?Sy84U25EMW9OaU45bFJkTzkvNnpBcm5tZVJpK0xHRFI3blZYdE55UU4yMXhU?=
 =?utf-8?B?WlpjTFFUb2tsRGRkdWF1R1ppSmtzNXFScEdKekdCK1dVd1FFblY0K2d3c0gx?=
 =?utf-8?B?azcwQ0ZuMjYvcEw1MkpLMnBmY2owWmlrc3BBZG9JK3ROWTdNa01uejlZR2FL?=
 =?utf-8?B?VzdRdkFIUDhvQVdid2l1ZjNIa0FIUTVhcGNRUUlRVGFJWDYxcWNSakFQbE9h?=
 =?utf-8?B?Uk1iZWpVbDBVOG9pLzZiMjU4MW9jNW0zOGo3NXRoM3dRd0ZOSnZGV1paRWlX?=
 =?utf-8?B?M3JRQS9pelIzZDlaSThIbmdKRHVhdStic3BpT2RkSHI1Q1h3R1l1YmpvS1VX?=
 =?utf-8?B?Zk53Y2pFYnAreWVTVWs3bytVcU5mNzhRcTRZMi9YVVNlVDlKTlZmeFIzSTJF?=
 =?utf-8?B?dUI2NEVDczZFSHRJQXBjdU9nd0tjeHhHZnprVjd0VnA4VTRKNER0a2s2eWk5?=
 =?utf-8?B?TTg4eEJvK2t1by93dnpGNU00WlllMDRjZzBzTldZeFJkeWNhUDdmRnNGcmR3?=
 =?utf-8?B?V0tSbmdvZ1pEdCtMS1NtUWYwd2ZpdXdjNUZZaE9tSGFCR3R0eHhQZFU2Skcy?=
 =?utf-8?B?bTZRa0pYTlhxVVE3NWVGUWI4VkQvdituVDIyVEIyRVBISHdxSGJUZHdMMGNt?=
 =?utf-8?B?Y1RMNmQxSTUrVlpxem04R29UdjUxZjRHd1FIZlR6Qm56aTJ3NFoxOTdwUmtB?=
 =?utf-8?B?QjlZdHBHbFdYb0pYZWd6Z255aUxuQTVCWkJUMUh6NkJIVlNYVUM1OFpmdXJB?=
 =?utf-8?B?Q3VKWlBBazdTVnd4OUZ6alhWWm5pcmdkc0ZrS3AxYk0wL2FoK3J3R1Y5TnBH?=
 =?utf-8?B?MHBDUWRrNXduWFdqTFBZMFM5UjhINzZ6SEJDUmhMM1ZMbVpKdm5IM3FnRnpa?=
 =?utf-8?B?bWc2RWF3MWlSdWRRUE5TMW5sT3pxb3NBY0pyZHFHeTJHNXZZeTBITmtWdjMx?=
 =?utf-8?B?OXZNMHpKemdyZHlzYm1hOTdScHFaazRna2J6RFc1eEFBNjhkeEJPQ1RweU5p?=
 =?utf-8?B?bVQ3OStMZkhSOTlUTk1scVNNUlp2ckZMeC93bm1PaEN4YmdvVDVzQ2dCU0Nw?=
 =?utf-8?B?ZEFPWk84cHk4TFk5VFd0N1RURUxsZG1vcUo0TU9ZVmdsVjFOR3Ezdyt2NnRO?=
 =?utf-8?B?QytyZURRckJqdGQrVW1qUWNTMGVwN1pxR0FpMEp5L3EvUnBOWWZmYXB4RFhB?=
 =?utf-8?B?Ynl3eEJRcWwvejZaa0RLZm11d2RQWEpta1BQZG1sQXhBTkpMNjBzSjlPUnZn?=
 =?utf-8?B?aGNTeGpMSEQ3bWtsRUJ6MWZKaUJVdHFlbUNZMUVuUjdZUDQ3NFBRL1hCQ2cy?=
 =?utf-8?B?N01pdk1TWXpPSWxjQkxiWjJLZDJneWg0elQzVTB4OXVqNW9XSUhuRkU2VnF1?=
 =?utf-8?B?RiswSVFvZ3RpcG1PNG1WWjZiSFFFQVlnRFlEUGFtQzZ0M1h6UUdxV0JPZnZL?=
 =?utf-8?B?c29xU2FJbW9TVUpFWk9NTzhzbWVyWVphQVBXVXpQRTZ4TU1UbllFTEFFUkZN?=
 =?utf-8?B?UldiVHFzbk9FZUw5ZWpFSC9LTkpUMnZDUmlkUnB4eWdDWHhHMnM3R0FCdHRJ?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de35647c-6afd-4f9b-3a58-08ddcfa3f1b4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 20:01:59.9986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XmVxDMFy50RQpjSxKNCLklP6eFteyKE95gI+qf/3X7J/mw4+0VlwDgvXThsqDJV8L6l869opsCQFB544d17+gXSAoKoL45ytoM7dwAprnkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8582
X-OriginatorOrg: intel.com

Hi Babu,

On 7/25/25 11:29 AM, Babu Moger wrote:
> System software can read resctrl event data for a particular resource by

"can read" -> "reads"

> writing the RMID and Event Identifier (EvtID) to the QM_EVTSEL register and
> then reading the event data from the QM_CTR register.
> 
> In ABMC mode, the event data of a specific counter ID can be read by

"can be read" -> "is read"

> setting the following fields: QM_EVTSEL.ExtendedEvtID = 1, QM_EVTSEL.EvtID
> = L3CacheABMC (=1) and setting [RMID] to the desired counter ID. Reading

"[RMID]" -> "QM_EVTSEL.RMID"

> QM_CTR will then return the contents of the specified counter ID. The

"will then return" -> "then returns"

> RMID_VAL_ERROR bit will be set if the counter configuration was invalid, or

"will be set" -> "is set"
"was invalid" -> "is invalid"

> if an invalid counter ID was set in the QM_EVTSEL[RMID] field. If the

"was set" -> "is set"

"in the QM_EVTSEL[RMID] field" -> "in QM_EVTSEL.RMID"


> counter data is currently unavailable, the RMID_VAL_UNAVAIL bit will be
> set.

"The RMID_VAL_UNAVAIL bit is set if the counter data is unavailable."

Please review after changes that all is coherent and in imperative tone and make
same adjustments to duplicate text in patch.

> 
> Introduce resctrl_arch_reset_cntr() and resctrl_arch_cntr_read() to reset
> and read event data for a specific counter.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |  6 +++
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 68 ++++++++++++++++++++++++++
>  2 files changed, 74 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 6bf6042f11b6..ae4003d44df4 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -40,6 +40,12 @@ struct arch_mbm_state {
>  /* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature. */
>  #define ABMC_ENABLE_BIT			0
>  
> +/*
> + * Qos Event Identifiers.
> + */
> +#define ABMC_EXTENDED_EVT_ID		BIT(31)
> +#define ABMC_EVT_ID			BIT(0)
> +
>  /**
>   * struct rdt_hw_ctrl_domain - Arch private attributes of a set of CPUs that share
>   *			       a resource for a control function
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 1f77fd58e707..57c8409a8247 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -259,6 +259,74 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
>  	return 0;
>  }
>  
> +static int __cntr_id_read(u32 cntr_id, u64 *val)
> +{
> +	u64 msr_val;
> +
> +	/*
> +	 * QM_EVTSEL Register definition:
> +	 * =======================================================
> +	 * Bits    Mnemonic        Description
> +	 * =======================================================
> +	 * 63:44   --              Reserved
> +	 * 43:32   RMID            Resource Monitoring Identifier
> +	 * 31      ExtEvtID        Extended Event Identifier
> +	 * 30:8    --              Reserved
> +	 * 7:0     EvtID           Event Identifier
> +	 * =======================================================
> +	 * The contents of a specific counter can be read by setting the
> +	 * following fields in QM_EVTSEL.ExtendedEvtID(=1) and

ExtEvtID vs ExtendedEvtID ... either the definition or the text should change to
use same names.
Can description of RMID be expanded to note that it may
contain RMID or counter ID?

> +	 * QM_EVTSEL.EvtID = L3CacheABMC (=1) and setting [RMID] to the
> +	 * desired counter ID. Reading QM_CTR will then return the
> +	 * contents of the specified counter. The RMID_VAL_ERROR bit will
> +	 * be set if the counter configuration was invalid, or if an invalid
> +	 * counter ID was set in the QM_EVTSEL[RMID] field. If the counter
> +	 * data is currently unavailable, the RMID_VAL_UNAVAIL bit will be set.
> +	 */
> +	wrmsr(MSR_IA32_QM_EVTSEL, ABMC_EXTENDED_EVT_ID | ABMC_EVT_ID, cntr_id);
> +	rdmsrl(MSR_IA32_QM_CTR, msr_val);
> +
> +	if (msr_val & RMID_VAL_ERROR)
> +		return -EIO;
> +	if (msr_val & RMID_VAL_UNAVAIL)
> +		return -EINVAL;
> +
> +	*val = msr_val;
> +	return 0;
> +}
> +
> +void resctrl_arch_reset_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
> +			     u32 unused, u32 rmid, int cntr_id,
> +			     enum resctrl_event_id eventid)
> +{
> +	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
> +	struct arch_mbm_state *am;
> +
> +	am = get_arch_mbm_state(hw_dom, rmid, eventid);
> +	if (am) {
> +		memset(am, 0, sizeof(*am));
> +
> +		/* Record any initial, non-zero count value. */
> +		__cntr_id_read(cntr_id, &am->prev_msr);
> +	}
> +}
> +
> +int resctrl_arch_cntr_read(struct rdt_resource *r, struct rdt_mon_domain *d,
> +			   u32 unused, u32 rmid, int cntr_id,
> +			   enum resctrl_event_id eventid, u64 *val)
> +{
> +	u64 msr_val;
> +	int ret;
> +
> +	ret = __cntr_id_read(cntr_id, &msr_val);
> +	if (ret)
> +		return ret;
> +
> +	*val = get_corrected_val(r, d, rmid, eventid, msr_val);
> +
> +	return 0;
> +}
> +
>  /*
>   * The power-on reset value of MSR_RMID_SNC_CONFIG is 0x1
>   * which indicates that RMIDs are configured in legacy mode.

code looks good.

Reinette

