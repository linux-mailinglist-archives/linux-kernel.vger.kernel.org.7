Return-Path: <linux-kernel+bounces-854840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8D3BDF89B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AABFB1A60581
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94412BDC13;
	Wed, 15 Oct 2025 16:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ep/LWV38"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F66186E40
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544258; cv=fail; b=f7U5VE5wuyqAVn7PRu83EZE+ycjmp8YIsVzzNYezPWCrQmWjCkkSD9uaWuqTVXEWwqPdxA1WGs8RL8ysyCvffLe4h1JvgpAO4d1Ely3o26v0bU7EEh01Ds3FxSKMEqGX7qvXefxlh1TIVqTDv99ugF7WBDZjGlItoSENqTXHiK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544258; c=relaxed/simple;
	bh=nkFLQlmWLTx+aMdrokYG/VEcoobgU1z++bV/5TZBHnU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KMWL8dOEHG2l+D6ncoWlS+mqRN0r2jhRPWsQscBExTb/J16vZCjPU3wE8syxEM07pjDFUBCNtpCxScEWzuDmrD0ad3q9wbegZcuTbjshhczGKO1AzyO5PBRlV4gHKIHzDtEHt3UzGkRC+uKLPfB4afIyl5JStI0XSyK+CigigbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ep/LWV38; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760544257; x=1792080257;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nkFLQlmWLTx+aMdrokYG/VEcoobgU1z++bV/5TZBHnU=;
  b=Ep/LWV38c3Ahwn3J0wKhsPsGsYjyeSADNYxGCy22OhE/VnL4uG1mxbvw
   NNSAilOmBROlIluHQg8BNYn1xks4EjQarp3Esq4GzcwVG5oDMHYNjY7ts
   xm/9PbwI3JOEpYYkCYysJpt/2PW9stjEUi3GNrE2dFg7JZHemQ9RJapOf
   /7i2am4p7k2Or8gbrG8vcOSeswrKbD8KcH/7OxoSMZgkon+vCyRt+blst
   CMkd8AOfMD9cfnI66H3Nly4/TCjRGDJ3+tdMcV6o7djSO7bkZPk2mJomT
   CUuZaySbwrnR0cMARzOFgVygMLZ8KXbAai3LT+GSLVriR0NOyT3G2NmEi
   g==;
X-CSE-ConnectionGUID: ZWePx/3rRSqXOokYiXfJBA==
X-CSE-MsgGUID: yrjg8SpjQZiYvczsnsmJfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62634067"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62634067"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 09:04:16 -0700
X-CSE-ConnectionGUID: PBJy2jkeTrGpELXfUabnUw==
X-CSE-MsgGUID: DYezG/PqRPWPOBwEmSc77A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="182167855"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 09:04:15 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 09:04:15 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 09:04:15 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.19) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 09:04:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJOmV+5a5O+JL/HbTVpzDmWe7eEJCGaEP79SlLVYwgNu2KZxz51C0BcrdG8OIg2S55C/rjNlUHLa5yz4HV+jijznChq+qQjX0c60fPZywj/WcRXykQ+Fqp37TTTmI5npw/FMDnODxjYngfoX2rgOhGgcEumjDBip+x+9B5uIAqFyoIyfAO2CKf9dQYzbJzWDRwfD/FhBVGs3Bob9CvRiFXBMMPtny7uT3YkFTliIhh3VueBolmGTGoaKLkHEiy8khLsA63Vcib4XHw5T/GQhPTNA/cEfc7qEi3FjhJ4R8U2ks/0aPuG+WFP0MQ15JLvQu+0OBTTMLzfBi7t4PPvOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjZ2sosrXvudNIe5dIlt+2uPaUEnFCvjDmtUiYpkeus=;
 b=DVaG8jaJ9aRBDIp8P5WJrfkjALyRPlJa0sTwgc5Kx7ge/RBrRFRmodwFulD8ILFgYYr3niI4iRjbiZb2b3/qwEg7MKRT4wEN+5ZFqx9Ej8s1vWqPoimBlwVtWsxIzhMDgTyq4BLsjCUeYTuMyNnRscp/snCW97W8FMJSR3oqDia3Jg7rhdr3Jd1FTRq2VEZxwq76kMrlgZgqKKQLt4BD3HvBhe7jnmZUKSspcDGkV03OMNxI2ReFEMxn88TZsxmqj9gND0Hd1FGFGeNUo7OyNoPUiWvNW87P0T0ztPLQFpO1CP/19JC5ieIJVSL6s7hXS4ftpZpsHtV88r6dys/a2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DS4PPF990BCE628.namprd11.prod.outlook.com (2603:10b6:f:fc02::3d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Wed, 15 Oct
 2025 16:04:10 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 16:04:10 +0000
Message-ID: <5badc525-f745-452d-b2ae-1f58d5271aae@intel.com>
Date: Thu, 16 Oct 2025 00:03:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/19] sched/fair: Prioritize tasks preferring destination
 LLC during balancing
To: Peter Zijlstra <peterz@infradead.org>, Tim Chen
	<tim.c.chen@linux.intel.com>
CC: Ingo Molnar <mingo@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Valentin
 Schneider" <vschneid@redhat.com>, Madadi Vineeth Reddy
	<vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, Jianyong Wu <jianyong.wu@outlook.com>, Yangyu Chen
	<cyy@cyyself.name>, Tingyin Duan <tingyin.duan@gmail.com>, Vern Hao
	<vernhao@tencent.com>, Len Brown <len.brown@intel.com>, Aubrey Li
	<aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Chen Yu
	<yu.chen.surf@gmail.com>, Libo Chen <libo.chen@oracle.com>, Adam Li
	<adamli@os.amperecomputing.com>, Tim Chen <tim.c.chen@intel.com>,
	<linux-kernel@vger.kernel.org>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <ca1946de63ad9f0ae99e079a74d70c55879cc0b6.1760206683.git.tim.c.chen@linux.intel.com>
 <20251015151005.GC3168635@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20251015151005.GC3168635@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU0P306CA0034.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::10) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DS4PPF990BCE628:EE_
X-MS-Office365-Filtering-Correlation-Id: ff05dc20-d17d-4473-3932-08de0c0479f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGVhRG15aEREeWszMlVLdTJLWG5XU3FjZ2pGbFNiZCs1ZzZNK3Rya0Y2VElL?=
 =?utf-8?B?WlNQVWw5VWFmUGJReEtKVGx1a3dCUlNVRW1FMTI5N3NCTHhWdlY4T2QyZFc1?=
 =?utf-8?B?ZWpFb2Y2K2hsTXRBOWNwWnJVa1ZzMk16NVlzaHF1MG1HL2RpSzBaVUk3eDZP?=
 =?utf-8?B?cGNXZGtWV3JoUWU3dDl1T2xwTlQ0WEVvZGVCS2JtT3B1bTZ4UEl6V2RzMjBO?=
 =?utf-8?B?OWQ1cVQrL0NyUVgvb0VmRXllWXlXV3NQZ3o2NW1BQVlyamFPV3lyU1FQMEpV?=
 =?utf-8?B?ekhZeVlTbjJYSVA4cmkzdEJad2JhODhPc3I5amU5ODF5NUtYNURRVmQ1cHdp?=
 =?utf-8?B?cFI2bkErUjJ4ZGJBZjQ3bzFYMnluY3pyNjJ2SGhhK2lKRDErbFh3OVN5dEsw?=
 =?utf-8?B?dHplSm15VkZOWmFRMlFjVDJISExhU1dJM2djRFZFaFdnQ1J5ZXRXYSt4MGFs?=
 =?utf-8?B?Rm10YWx6OHN4RWROVkhxQVl2WmJHQUVEN3JXc0tMZnFNZFQ3N240akNNdnc1?=
 =?utf-8?B?OWliNGNjaFp1YjVrLyt0Nzh0ZHpRRHJzRGxicTlnNXgvQXg5SklTcHpodnR4?=
 =?utf-8?B?dmdGNVpyb1NoZEZMaFBQUFk4bEJJNGNLaUpGc1U2MlpOSDVza2d2cmNySDI0?=
 =?utf-8?B?MXRzZXZOcVM1VXE5ODRFRVdXK25zRnkyOU5OSzIyMm5oNEpybDI3Q0RuYmdu?=
 =?utf-8?B?UUhWeUN0SllrVHY4cC8zL2lrdzRnK0VMZmxUTGdBdFNMN2F1U1QxVWFGWTRz?=
 =?utf-8?B?T3FxYnM0S2VRVENvNXd4V3pjQmVrVU81UFlpaWl1NzJ0bDN0TmY3SjdOQzBZ?=
 =?utf-8?B?b2pydEQ5VEE1NzdkWCtMV29vWTE3OHVSMVpkTm9nWU9LbnlBRVY3WThNL01E?=
 =?utf-8?B?SFBrQ1QySjcxQ2NEVEtxTm9ndHlmYlhFK21WZ2lHWjg0SkgrUGpwWjhKekhM?=
 =?utf-8?B?R29IaUJhMmJNdVc1RFlBSFdhN2lFTWhieCtBSU41ZFBIb3JTa2RVNkhVcFJn?=
 =?utf-8?B?Z2pBMXNVTHdBRElOZ3RtdVlQRmJld1U0STJKcisrNTM2MUxMSWFRRUhjS29y?=
 =?utf-8?B?SlJzQkRMOU16QnVxamNuNDh0RTBHU28xR1lHZDJ6b3lIN0lhZENTKzZ4NFNl?=
 =?utf-8?B?ekhRbkM2aWxZTTV3ejlLT255WFNwYnAzaFJUQnV5cnRSVHY2d2tWaDdLYTE1?=
 =?utf-8?B?bzBLVnpjN1FubmVsNUZBYmhOdTBFVTdlbDVnT01XMW5KTHM3OVVwUC9zWXJF?=
 =?utf-8?B?V0libXpNZkoxYWptaExlOWV1V1dacDlCTGNYSzBhSU56UzdKQU10QmVxNHhr?=
 =?utf-8?B?NlpjZHp1VDYvVXZHMFQycUtmRmw5S2prZ2ozaXl2bUFkcy9IMytHb1d0KzFH?=
 =?utf-8?B?QXdJSFlXaFZLcjRsa3N6eFlXdHVlQVdCUzhISG43WG5zdU1odW0vU1crVnk1?=
 =?utf-8?B?d1U4dXRXU2FzNHorVENnTXUzY1RkOGZnZVdCbXZ5VjVrYmdMYzRwWUZYT0o5?=
 =?utf-8?B?emxVSXNLQmFablVvTE16Rm9XcGJscEhXNG5KWktlZ2kwMUI0L01qbWxzaGVC?=
 =?utf-8?B?NjE0Nng2bm1wODAwbHFaSXg0dWhIN2NKSG5vQU9hRVMwaTl6a2dTVFp2Wk1L?=
 =?utf-8?B?TkNYbjBjc0ZwV3R6T3ZkR1Q4N0RhWngxWEo1V0w1R0dNcnUvMTlVUkF6OU5J?=
 =?utf-8?B?M2dpZWdyQVp4RGt0dVNwcHR1bElCMC9seURjM1dkTWQwY0w4YWowdjFzbUti?=
 =?utf-8?B?bVdxamUyS0ZqbmU5V3VIZUcycVlUbzdlcjFlcjdDUnVGZE1uRFRmTmVNZXFP?=
 =?utf-8?B?b1pZbW5KUDQ2R01ZNmdDWTJkMER1VVhuQm5xUVlaSXhxSnV4YmI4UFVqU1NE?=
 =?utf-8?B?bGFDUTBvb2JCdmlZNytjZXNsSkZBeXNHeXlab00vMUVKT1hOMmF1N0NPdHNL?=
 =?utf-8?Q?47BxKWm56G+OscBW1/+qNYcSSF1Z+nhC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yjc2bXlhUlV2bXgyQVA1V3JMbmNNUW1Oc1FOM0tjWTFNb2NSVXFGMzBsRVhS?=
 =?utf-8?B?cUtmRmhWOXpPQktJS2t1NkRLQWp5bDNYZXJ2ZW9UN1poenhBRkdIYURubUhV?=
 =?utf-8?B?Mk1mZ1RtRE4xTWZRaEI4TjZzaHJJcC9aQVR2UjdQdnVkV3p3YkR5MFRscVJ6?=
 =?utf-8?B?YTdKT0ZYdGlPZzZyNkRCK0didndkb3lkbjZCeWVuaDhuTWx6QzFRbExwTWd5?=
 =?utf-8?B?WmpIbUZ4WWM2VkxFVjdmUzJKS1ZmUURhRFRLem9rcU1ia2R3RDZJR1Q5RWNY?=
 =?utf-8?B?eW4rR05CZUxhMEF2eENDMTJnUi92QUlRKyt6aHlOYnEwTlVDZmpXcG10OEs0?=
 =?utf-8?B?VjhXM2RnWEZOVkl5Y2duTEJ5VGtuVXlqQmErOWdDQkFsOGpDbERBSTY2Slpp?=
 =?utf-8?B?UzdYakFZWC9odnk4c00vNWp1RmVTam1KbFhyQlc4ZEQyS3JMeFRhR05CSjAr?=
 =?utf-8?B?UFRnTGRiU002UWs0M1dBckxrYjZoTnRveGZmd0lVaDhRalFXNS9rREc0cWZt?=
 =?utf-8?B?TEFKVWpmYlVlS1Rmd0gzZEdVSTc1TE8yT3Rzd0FJekFVTEp5aGo0OU90ajJO?=
 =?utf-8?B?UTdVR1ZQUzJNTnBNb0dhTDFRM2xBdndhc1hqZzYrQW84eXNzOTY0RjJVOER3?=
 =?utf-8?B?VExpaWx4MHB4MFJiZlFlZTNVV29jV2wxeHJvQ0w4am43RTZTVGdhdXpWYVBu?=
 =?utf-8?B?dERCUVJvS0NtVmdkTWEveFRUL0ZUdG9LcDI0QUJEbHRoOEFPeVpJQUp3QzBo?=
 =?utf-8?B?alVLWUhqUW5aZyt6elU0RVo2di82Y1pZUEpqbkg2TkkwdWdHM0YyOHluMndZ?=
 =?utf-8?B?aHQwdnhManNPSHFMYVIvc3cvWFZmeU1tSGVwWnhpNWRWdjBYcTRvbTVhQi9T?=
 =?utf-8?B?T3lFbHFPK1RsWkZlVVVTek1iYkUrNkk0VG45aGdHYmh0MVNMUk9yZUx0UHdj?=
 =?utf-8?B?UXg5c1Mzd2piblYzUUpMdklpVktLdUhGU3Z0K3A5OGVmdGo5SllOT2pnSHB0?=
 =?utf-8?B?SVBWVWlQZVNVbTBPdE83cUJwcGU3M1BReUtZRk5WQzVkOTBMSDdub3JoU2ZQ?=
 =?utf-8?B?bStTOHpDejNKczA4UTdrMHByNFdxV2xzNDljWUMzWDRGSlpkOHIxenZMdjFs?=
 =?utf-8?B?ZWlGZ3hGMkRUaE5pNjcyQXkrNjFyTExMbUNjNHlHYXVBbXNabStyTU9mdlNr?=
 =?utf-8?B?dmN2TlJkaEc0YkJtVG5ScXg2TlhwQUFlb2tZcmgxYzVFa1ViTUdwdSttcUM1?=
 =?utf-8?B?TzBVOXlkUUp6VWJvQjlZYStJb1ZBaWpqdFVZTkJYbXNBZS8xekRqMWdjVEVi?=
 =?utf-8?B?Y1RVcGlZdGk1VGNqdUxvNWxYNER2c1E1U3Rsd2syb3MvaWtVaERCc1BJQ1o2?=
 =?utf-8?B?VkYvVkpaazZQc0lyMC9RNEJDY2tQR0d3RWNWVERQVklIb2VIRzg0NEJ1V0pE?=
 =?utf-8?B?dkxrWDMzTUZ4RkdPRXhWK1BwcXhUQ0NwdUNmQnhvU1p4VUFvTHhCM1QyWGd5?=
 =?utf-8?B?YTNtWHpZaFFqZGdhT0VSVm9OdmVXTHA5czVVUVUwbkpUWVJ1SUl3UVJtYWR6?=
 =?utf-8?B?MStuL3BSUCt2UTRTV2h4YjE5UXBHT2ZDcmliL0plZTJXSUd5WEdrUXFaTGZZ?=
 =?utf-8?B?NXlGekkwa0FMRTZDaWxPdG1JbXUvU280OUxqbWVLeUszd1ZXRE1RK3JTczJl?=
 =?utf-8?B?R2pLeW4rSS9rTlQwS21saDF5NkwwSmtISVJ1RjhLdG83WG5tdW4wMmQ1R3J6?=
 =?utf-8?B?Wkd4K2pJVW56NVZiYTltYlVjTnJXNXpZN251Y1FwbDllMkJMaTB5WnRIR1ox?=
 =?utf-8?B?M0pHVEQyOEhCYlJTcXc2Y0NVYjJVK1lJcmJHVnJobU9mcDRlRFhMQlBHc1Yx?=
 =?utf-8?B?YmpuN0pUa0k4azBDY1oxZHk5Qk5OZGc4dmRwa1NPWlpyckNBOGJwdEFNMUYw?=
 =?utf-8?B?YnRNUjNTMzJvSkNocWtuVnB5TEZKMjRTWTh4SC83TjFhQXh2bGl0RFc0WWFM?=
 =?utf-8?B?MlVDQ1RtdzZWRXM3K1Q3WWtQZ2pyNFowVWV1U25xWnJLK0p4RWJrOERnOVZX?=
 =?utf-8?B?QXE3dEsyQ2JidmU3TnFIRUFyS2JLaXVtOFcvY0FZNHdyUVplTm9zamtmL3o5?=
 =?utf-8?Q?F39LTyHImDVNegL+IDB4uW0NO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff05dc20-d17d-4473-3932-08de0c0479f3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 16:04:09.9821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGnxX2cHsz1zSIFPTg6EqOjrLBySXB8bQ2uJiVExdzBxoK7pqevWR0cb5cNxq07uF5Ko5Wzzou1Gbc5fizc8pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF990BCE628
X-OriginatorOrg: intel.com

On 10/15/2025 11:10 PM, Peter Zijlstra wrote:
> On Sat, Oct 11, 2025 at 11:24:47AM -0700, Tim Chen wrote:
> 
>> +static inline bool llc_balance(struct lb_env *env, struct sg_lb_stats *sgs,
>> +			       struct sched_group *group)
>> +{
>> +	struct sched_domain *child = env->sd->child;
>> +	int llc;
>> +
>> +	if (!sched_cache_enabled())
>> +		return false;
>> +
>> +	if (env->sd->flags & SD_SHARE_LLC)
>> +		return false;
>> +
>> +	/* only care about task migration among LLCs */
>> +	if (child && !(child->flags & SD_SHARE_LLC))
>> +		return false;
>> +
>> +	llc = llc_idx(env->dst_cpu);
>> +	if (sgs->nr_pref_llc[llc] > 0 &&
> 
> Robot says llc can be -1 here, and it don't like doing out of bound
> array access.
> 

Humm, there seems to be a race condition during bootup with 
build_sched_domains(),
where the per-cpu(sd_llc_idx) is reset to -1 at the beginning. We might
need to add a sanity check here.


thanks,
Chenyu
>> +	    can_migrate_llc(env->src_cpu, env->dst_cpu, 0, true) == mig_llc)
>> +		return true;
>> +
>> +	return false;
>> +}

