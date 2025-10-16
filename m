Return-Path: <linux-kernel+bounces-855465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B222EBE155E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 05:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28F219C66B7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 03:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7261DF970;
	Thu, 16 Oct 2025 03:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gnPyGYmq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6847B194137
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 03:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760584424; cv=fail; b=RGqhG87oXvYpO3kLVfX2J6dp7MM1+tlhVRyXruNyfwnUftCrgNLV0u/G/WD48K8N74YlMG4AkKa6dJm/Btk6OL2iih24inHqf4tHIsXOiPiPK6dO6PLo8qQ6NTuXww2sKCaFAYEFa8h8xuOlKG9RXCOiobgkWszvGQHR+kVl7kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760584424; c=relaxed/simple;
	bh=RtOVswzaU81HOkTaqmKlijNIkPfvLz42I/x7xFqBD38=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZDySA7SFUI0eqgA9O6atByCaKL8UC60WykakWbd4xw+CXakbskn09b3Bewi/RD1HkW//er8G5xs3Miws3JWMvHZzs/4/6mbo98+moRnVU9hAW6au3sSYJ92loXDa/04geVKuXA1mu2lhm93MCz+N1MiY7R15D7gPzhk1hL/Ce8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gnPyGYmq; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760584422; x=1792120422;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RtOVswzaU81HOkTaqmKlijNIkPfvLz42I/x7xFqBD38=;
  b=gnPyGYmqkfPNlzDIsUwgru4oMk6ywHUkGAQ+ZSO0wF51/EMpX8bIsjfw
   9zPOoGg+lyBdMeQ4KX2B+qZFNWaiOoP6V9j0MQeUVx6fMzN+s1cudVn0i
   QFaXyy1PirRiXPORA0NLcOUkgMgo9QXRbQontjfw+fSbdftujy6fDbPVT
   uHKbFO9cv/x5IAp/iiHZKBDCxd8GILJcVgRvnjvkr8P7xp9YhRU6yHgjG
   VnyoqS6lvhaKShTb1f/rdpe729gNYs/bJHm69Iv2PMwt2FfhA+J1iPmIp
   Eu/rWOTyLWwJdrAPsuXAupl5sduhOAu+B68VFa4/FCYfwXOEFmePncqBv
   Q==;
X-CSE-ConnectionGUID: 1SoSzQ8JRAGvPuitsUgjcg==
X-CSE-MsgGUID: HGSQ9/D9QIy4T6L3GW2oQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="73370840"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="73370840"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 20:13:41 -0700
X-CSE-ConnectionGUID: tTTaBSDURpGY3ZHV7dwIMw==
X-CSE-MsgGUID: dRsg5A2+Rj6VJfAEKGcDsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="182741777"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 20:13:41 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 20:13:41 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 20:13:41 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.18)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 20:13:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8pHqEfQU3EqWetDhi3LSn5y8/ZjLVInxtGnXZI+MJRtSiX3HDvxwH+xnYFyiJsHxnVufMw7798FYpViwpnKZREBu+NLvZAUxj5dgO7laJ+SfM40orw/6Y+WKIeevaP9ftZFJTB0AkY7euCqgKhU9Hh1cdeZW6/I+IaS0LlgeQeqekgaf3+6bDeSqxaAInNcD9qix0AcRG6QoETR5BDLA2VBWPOe+MWgQtnSnSmaYYkTwZE+c0IuFVTYzzrJgJPN8EXHoaGxMxcqD8K56OSXzXDPD9p5tkrgNi3NoAufCNku/DB0dTntCDTl0OQ9zi5hHGQbrxjh+auQ+00PtRgtOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EPISyRTK7anOdmPsyn417lnYVdYmwPDs1bo4OKs3Ck=;
 b=uu2FjdWV5wdjTLkC7uy0wQGYP1leunuV4qw7or46QqRBNJbEQl9a6WngjGm+4rD/0U5D8JOaP6qEihV8QAJ11RPif2LP/OXlAiAgJeEwRuX5B5HMyhBD2IoqOYXfPYXV9P7DOOA6rDjLeQSFCMs2Gn0T2ig6twjXJbLLMOTjwmc2XEpba891aHQAhORfuY33kwqBh5IxQLLhTEb3TW4MZx/WnkBbXb/Ye1R2dVKHnCD4DbETm0o/pkz2jm0awPs8xpkGdwkQvY6sTVTArh/cS2sQP/6BorSampKyM5c25DnJfjRfwzYrUbivUJvzgwgTP1Lh2ucPbL4vVZFtS5pGfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 03:13:39 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 03:13:38 +0000
Message-ID: <2e7efcfc-9a70-4e26-9559-e5a367ba8ef7@intel.com>
Date: Thu, 16 Oct 2025 11:13:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/19] sched/fair: Assign preferred LLC ID to processes
To: Peter Zijlstra <peterz@infradead.org>
CC: Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>, Vern Hao <vernhao@tencent.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Valentin
 Schneider" <vschneid@redhat.com>, Madadi Vineeth Reddy
	<vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, Jianyong Wu <jianyong.wu@outlook.com>, Yangyu Chen
	<cyy@cyyself.name>, Tingyin Duan <tingyin.duan@gmail.com>, Len Brown
	<len.brown@intel.com>, Aubrey Li <aubrey.li@intel.com>, Zhao Liu
	<zhao1.liu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, Libo Chen
	<libo.chen@oracle.com>, Adam Li <adamli@os.amperecomputing.com>, Tim Chen
	<tim.c.chen@intel.com>, <linux-kernel@vger.kernel.org>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <cfa266cd6ea6fa30cbf7b07573992f18f786955e.1760206683.git.tim.c.chen@linux.intel.com>
 <3df5a8c1-7074-4fcf-adf8-d39137314fd6@intel.com>
 <20251015111542.GQ3289052@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20251015111542.GQ3289052@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KUZPR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:34::17) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH7PR11MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: 445517a5-5de8-4bde-f85e-08de0c62007a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDNoYlNxV29POGJSdzc4ZWdWTjJIU0lsdExZY0lqb3BKZWZHZk1YU01nZ3pJ?=
 =?utf-8?B?RDR5MU1OMkhDWkpkUUpPaUhFWkdtR2MzMnZFaWNwVm9BWHEzbllJTWk1WUY4?=
 =?utf-8?B?UUs1MGRRZDh0aTZGelBBd1lxV1FDOWhqMi9kMmtQMFFzZmxGbEtpN2tIaXQ2?=
 =?utf-8?B?cVlMNWRBemdjV0JMZk5aS202VG54OWRLbDlQSGIwUW9TS1oyamN4WEtkekp3?=
 =?utf-8?B?RGFGcm5uSlFjSjBoNXRGVzdOWXdlUGNYYTdwNFdyVWIwTlNIa3RvaUoxdzQ1?=
 =?utf-8?B?TmZoMlV4aHFCTkJFMkk1QmJBVDRqRjlWeXZaSFN0M3psM1RLc2dSRDQrZkh6?=
 =?utf-8?B?M3d0MWJwaTRHREJPbHgreHQ5NmNZOFJmQW9wRUVvK1dzWlNIenRob2RuTDU2?=
 =?utf-8?B?R2o3Q0pmeHN4bFpkUUNObVZWUDRITVozQi96Z0Npc3dFb2d5czRLdGxFSHEw?=
 =?utf-8?B?bGhCWm01UU5UVmltVEUwdFhPb3EveTVNUHM5OXlFdXdzTFdQVDVYa0gwT29a?=
 =?utf-8?B?WWtFbWkwUjhlWDI2WU9IMVhXMnVtd25NZ1ZJbG1maHZzUStoQUpIaU1IdklN?=
 =?utf-8?B?NnpWN2Y5b0huZjFYRlNxOU9OcGoyWkk5b2lpZVhib0VjQjNZbHFEK1l3VTNx?=
 =?utf-8?B?SjBTekJSWEJZeG9veDZpLzFQWlNzUDRiWWhEdkREMzdSdnZGWGxGY2tnendU?=
 =?utf-8?B?UGdieEc5MktaT2dZQjliZ1lKM1FkbW5LU3VVU3A5RzEwblFUTGJoWUJYbnl5?=
 =?utf-8?B?dk5CMGxCTk5haHdFVkNQVjBjM1U1VlpUbE9XQ2pXelk0SERYTllnQzJ4RGxJ?=
 =?utf-8?B?cEhJNy9HRTV6cjdqNHo4VVlBYWhXSXgxbm9heXAyYzY2aG5rN1FkYnI1dXFB?=
 =?utf-8?B?L0pLRUpVdTBmTjNzVlJUYWxrK29raU1LVWs3NUtxQStoOHVWRTBWeHNqb3kx?=
 =?utf-8?B?ZEE2QWhoWU9OdHAxUWVYZGRDSzhZQ3g1RU45ZXl5RDUzYmI0c1ZsNjVWc3pw?=
 =?utf-8?B?YlNxRXRtYVRQcDkwNkRHUmRvZXJTUnpCZFFqTkgwNU1zMHdFeVVjZ0tVM3Np?=
 =?utf-8?B?NjlYc1ovaVZnMDl1ZkpRM0RMMDJYTW1kMTBMSXRwU2cyRUlHS2xCb3NxcE1S?=
 =?utf-8?B?dnpsMTA3akNFTTlwS0VpMC9TcERnaHpoNm5kNUptUk1qYUpGbnZMcjUyWGZj?=
 =?utf-8?B?VTdiUjhOWHNJUTVxL3U0aTJmOHhJVm0zQm1IRndmYXRsWHFHZFk4MWtVWm16?=
 =?utf-8?B?eGdOaGZjcHpkYnFjYnlRSjNXTVFHdmNqVUd3SkxPRHlaYXhHd0xNYzJZd3Bl?=
 =?utf-8?B?ejc3TFBQSExkdkNHM2NkblM4MTZtSnFTZ1JXdHlDZnFEOURUdDFibkJmbTB5?=
 =?utf-8?B?cC9tVjRrZEpmMGJOOFFaSnB5NnFCcW5MV1piSnhPOU5laGtVQUhqNEdMWTNU?=
 =?utf-8?B?Z2dTa0JneEhuWmpOSXZtajcwbHprSUlEY1RCWGpkaEh0MFRLaE5YenJIejAw?=
 =?utf-8?B?OGYxbklJb0FISWsxRGV6ZjdYUkF1enkvdDhDNVlSbG1YSE9UVGIyQS81TTVi?=
 =?utf-8?B?VzRzVHd2VXFIVDB6OHJVMTlpUmVyQW4yY0l1aVRJeDZEMUoyYVd0VWRrVmc1?=
 =?utf-8?B?bDgwVE1QYWx6MCtVdENDWGt1YytYb2g5eHIxQ29PYWMrcjgwWTdyaGJ6V3Ra?=
 =?utf-8?B?SDUwUk5ibmJSQ3NPV0dXYUxRYUJSY09ubXhJODUyaWwyMFQ5eEMydzRiMVJE?=
 =?utf-8?B?SEllTE9DWWpwTjZpS0JMWUNZUUpwaFdLdlRhNTJVTVIzSGpIVWdUZmE1MlNa?=
 =?utf-8?B?M25PRXVYUzU2dG1RZFNOQ2l4M2tMblJiTVFNK2VHdC9uRlRLUnFlZmNEU0Ir?=
 =?utf-8?B?UTM1VDNndEc5Um8weWRNdi9FVWs2VDdDTWEvUExwVGRDSlR4VmRRbm1KbzMx?=
 =?utf-8?Q?fuKV6K6q2O2XJgm2bwcZgyJ7GN3cmhS0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlYvUGprWHN4VnZ5aUlMUFVjTGt1UmxHdWwxeG1WMTFpSlZqbVpZOVVCcFlw?=
 =?utf-8?B?T2xCeGpZbDNxUkpoVE51ZzR5eC81S21tczFQbzBLV3pJa2ppejBocys1TVNM?=
 =?utf-8?B?eGFvWlJ4bFhhSkdYYlU5M0JONG14cEg5WkUxbmtCcWwwQjJEYjhMd291Q2tm?=
 =?utf-8?B?ZHBTMG44d01TSWM4NWdqcEg5VXJVZ2ZOUC9uWERjcUNxdlpiNFJwYnBIN3d0?=
 =?utf-8?B?SnphYm9vTHJlUmlqY3BmNGc5UFI5bnJhUG43Q3dMamd0bGZ1aWhMSDhvc1Jh?=
 =?utf-8?B?QllQbjVlV3hNUFRjWFpKTEJGcS9wVG9jeW94Zmw2NzBxMjEvUzBpZ3J5TjFW?=
 =?utf-8?B?Q3F6M0RicnBrTXJaWTYydDM5TkVJN29OUy9acFRDeXdzelo2TjF5WkpHenMr?=
 =?utf-8?B?N0hEVmM1RHk0QXlDQW40MmNLYnBkdWxOTmJ6RXdQV1J4akxrWkVQN0N0TnFN?=
 =?utf-8?B?UW9ueGlKUjdUMkxnanpKOUkyK3NMU25CdFZ0S0xBUzYzalN6a2lacnNpZ3Fp?=
 =?utf-8?B?c3kzRTdXcHJ5UE9ZNHd5WkdPd0JGU1lRSXpRZld2aGY4SDhBZFZnamRzTEYz?=
 =?utf-8?B?R0ViYXN2NzF2REJuWG9ZR2RaWEIvR0kwOWZzMDhVZm1IN2NRcnl3Sm03S053?=
 =?utf-8?B?L3BwWEdEVVBpNXcrRnNwTTJDQmJMeUtadkxDR09rU1hWbVV0Zk5CeFhPRjd1?=
 =?utf-8?B?eURHeHdzNVJjMGZ1cTBHdlFYZGl6UkJQak45K3BWb3RSK21SYmNBZzBWL1pa?=
 =?utf-8?B?SE1CeWZUUHdVU1gwZ1lLWEsvQU55eHY0Z0JGdUI2MDlEdkc3aEswb1dMdy9o?=
 =?utf-8?B?elZqTUd0aDFoWkczN2pwQnVXRWQydzhtLzllQkhqRXloTEwreDk4bnZEakJP?=
 =?utf-8?B?c2pERUl4R1dNZVNiSkFqUkUzcHR0T1NQVmozeUFaeEVQcXdxSFc4YkpwWDU1?=
 =?utf-8?B?Q1ljTlpFU0t3dG85QnoyMG9xd1J0SEVJQzVkREd3Q3JFUHIyZkVwclZSVXd3?=
 =?utf-8?B?a2JSOVFPSHZHejkzV3dsSi93MEFnbVJiYkFFMFVNT1FIUTlkN1RxVnpsWnZB?=
 =?utf-8?B?VmRjZHlHODlFYnp5YnplTjNEdndGUjV2S0tQZGs5bGpucFJqRUhVYUJpQkdC?=
 =?utf-8?B?b3NxN0ZOdHQ3OERwcXJxelBXS3lEOE5iYVNIdXdqNWVKcHBhVjVsRDNRSWRW?=
 =?utf-8?B?YzlXMHJQV0FnSEFJeXpoWkR6Si9qeExVM0I3RENEcHlLamx3VEFUcWlsN2k2?=
 =?utf-8?B?T093b1JRdTBxQkxJS2t0Tk5sMzdtWUFubyt2TGhEd0dKaE44bkhmQ0phQSt4?=
 =?utf-8?B?TndSRmxkRlQwZWM5N2UrK1YreDhoNysyc3FtOXhWdVRTR1I1TEluTjZqcmZD?=
 =?utf-8?B?dUZUK0xyUk5jemIrcTFZWXhSejQrVjAycHQzd3lHYVp6NlpxYXJEYmR3Y1lS?=
 =?utf-8?B?aWJGZlN6VHNRRVZuakV0UE9nUThRR1hBM085QVhpMmRCN3NnR2p0UU1PbnRz?=
 =?utf-8?B?cFdGRlNwOUg4REJUUmRjR1daZ3dDc1JsZ0NRZ3B0YjBmSzNOU3dZUU9pWHMw?=
 =?utf-8?B?eXlreUJGR3VXT1FZK3RIMm1JRVJpMTBaajE5ZWw2T08zZXJaWjFkV1dMUENm?=
 =?utf-8?B?bzNadzJmTzBGSnpMWFF4end4bEk0djRRQVhKQ0JnaS94Szk5L3pzdVJ3ckZF?=
 =?utf-8?B?MmRJSEk3TlhxUWxHU3ZiYW12OFdndEl6YVpjc01seUhXcEpjdVJ3K3djOHB2?=
 =?utf-8?B?dTdEeDdxckxqc2d5WHc4VFRsb1p4WTRWbVhLd29OMEdJek5BendFL1Bva0g1?=
 =?utf-8?B?Y0N0Si93NkNaNXo4d1dCN2NsSWRZZGc3aEd5Y3RkM3RnUFNhNnFRTmY1RzJW?=
 =?utf-8?B?ZWQzYXdhb1o3Z3dYbW1URGdxY3VmK0s5cDF5WVVtZGRaNVRLaVNya0llMFV1?=
 =?utf-8?B?ODlPS2JyRkJGN05tMDJjby92TmR4RzZ5RE1Rem1qTlB5NVM2dC9mSzBSU25Y?=
 =?utf-8?B?ZEx5dmNyQlVaY21WdHB6Q2gveDNNMkE5SkRwZlNHOGE1ckozTkVoRzRVZUIz?=
 =?utf-8?B?QXYrY25neFEvenNrZEM1S3Y1UkNLUExEMEhZeWU4SDdBY3IvMU9qc1lGMVI1?=
 =?utf-8?Q?8quxtnZ99TXmIUTfZYUv+JZ5O?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 445517a5-5de8-4bde-f85e-08de0c62007a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 03:13:38.9297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C7DDRk1TnLXBnQw5frMolKPVOQgvj+Ktbtf5pv5Rii6rstDqyO0TOQb+EVLN53Fa2XCyHIhTICKxBI0GgeSklw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5958
X-OriginatorOrg: intel.com

On 10/15/2025 7:15 PM, Peter Zijlstra wrote:
> On Tue, Oct 14, 2025 at 01:16:16PM +0800, Chen, Yu C wrote:
> 
>> The question becomes: how can we figure out the threads that share
>> data? Can the kernel detect this, or get the hint from user space?
> 
> This needs the PMU, then you can steer using cache-miss ratios. But then
> people will hate us for using counters.
> 
>> Yes, the numa_group in NUMA load balancing indicates
>> that several tasks manipulate the same page, which could be an
>> indicator. Besides, if task A frequently wakes up task B, does it
>> mean A and B have the potential to share data? Furthermore, if
>> task A wakes up B via a pipe, it might also indicate that A has
>> something to share with B. I just wonder if we can introduce a
>> structure to gather this information together.
> 
> The wakeup or pipe relation might be small relative to the working set.
> Consider a sharded in memory database, where the query comes in through
> the pipe/socket/wakeup. This query is small, but then it needs to go
> trawl through its memory to find the answer.
> 
> Something we *could* look at -- later -- is an interface to create
> thread groups, such that userspace that is clever enough can communicate
> this. But then there is the ago old question, will there be sufficient
> users to justify the maintenance of said interface.

OK, that could be an enhancement in the future if we encounter more
use cases.

thanks,
Chenyu

