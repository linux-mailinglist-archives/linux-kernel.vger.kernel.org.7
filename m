Return-Path: <linux-kernel+bounces-837099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 108BABAB609
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 06:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07893C6B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F77A2472BD;
	Tue, 30 Sep 2025 04:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EBw5BdHe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B1D21C16A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 04:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759206862; cv=fail; b=RgjALxpEUJiq10kFmfQwQFORH7K8uKjvKLhPV5q9vi/Atlm+B5+yFWnteCWR2rcpI/iETTWrKWZIbSZ/ZdyktrexDYkp1Qd6A7i5/BI3RSCJ2ATg3GbB3Hrd32uauG5oyjOhE+Lmtv4BDMYlxlE4OZTP0rxfxdfvDL2v9GrLjdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759206862; c=relaxed/simple;
	bh=qUXi7n3Y7Ei7U0/U0+/MeM/UcILqwBWeSssoKjG7oYE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jueuMG5/yovf8YVkge8hFF5AiNPltrjCx55LlQxsAOEMyAy7yPDdbQQCwf0g0DZQNNxqWOlMJYjgHHooXMWIjUYQqOBJQ9U+CkeoanVk1lJNDMbuj/4HKsPQOpj7RVoaxlDBkKnfR5HT7wcQpB6XOFztTz6KnZx6K+I9GEGkJeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EBw5BdHe; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759206861; x=1790742861;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qUXi7n3Y7Ei7U0/U0+/MeM/UcILqwBWeSssoKjG7oYE=;
  b=EBw5BdHeZqnggix8UC7nRNMWczV/A0IbIUdOVS96yuDG2yPndU+oaGyu
   KCsBpu9ikufk96mZGtprpM3jvv7wg85dejy8yNbOFH5wATbjue7HaxVEw
   YeBeNNwIlrROKz6q/oZmMs5/cr4I/lZOkGM/LH9405TqJ4Ftnn5QOPxe9
   FcM9AxWQ/L67uklcOcsDX9SHclkum9J0qOYetqLvTSdJB2lsgkgAY1Tpw
   3gZh/prIeiWmcmn0RobwNIHHymr43yYuQx5gpNZCQk4+kN+pPDwLPNaS9
   ogG5iMy8OG5lPtL+Vk0yq3BNMfhyXUpfOioEt60moU0nG3OycC9MdN8L4
   w==;
X-CSE-ConnectionGUID: Pild/4exQv6E4DP7U9Clqw==
X-CSE-MsgGUID: TjGP0+Y5R9OnbmD/HKt1UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="60667967"
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="60667967"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 21:34:20 -0700
X-CSE-ConnectionGUID: T4uBiic3TCGtRySDt8Cf7w==
X-CSE-MsgGUID: K3Njv7u8SUiCUmvraBWK3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="209125467"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 21:34:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 21:34:18 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 21:34:18 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.36) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 21:34:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgIZ6l1yk4Xd/3x2HveieFF+370x4lNLHZFWzPLlSJOYw9R5p3FZ9eGdrJxif92Kipda9cNkCz7DfYE7KUMTWmLWOEEB8ywRCnCSnzEtp3gWVEKtyqmH01guPBtAhggN2iOXTFH1Xi/2cccM+eVIQ/cUN0ISQLIlnjs5pfchmgCxXKzWCmpcy+uzFugBxZtWINv34ku3bmB3u4OAZT6RW+0AYDb3KjIACNhBmMoLrCjRRAclyvXmlK+Uu52+eEOQTxBPsGdr0NnKs16cGegOuCJgTGMT7635cKqm/1FuCjOy7kIMaLrxaDbxDgCEVjYhHKc7TbcfERapg2fZBYJIgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/muGG+6xqRnFvVVZyoutcQ5kOuFfg8jqTjmnExHwIJE=;
 b=NF13mOQCX9swwPknbEpx7V9VgNEiaiMpdf/9bTXqSRX3D31CWHus/ZwiHZaZO+V8S65DjKt8CGo4T7+kQ2h5wFL4LNn6OyWoZQNYjcxYZdZEx4mgUNE5YaVtNi5yiJkwOE1fxzRuSxk7hhvPwMH6Yaeef35kE6tyE+5SQo1s6lRa3XAx+5b7ZL/VRweNzmYy7ectXMcoBO36ocZzQHJHDnYpTW01GT4t10x7VoQY4v8GEU1aTn+c7SUHANhnium46ZndXd8wrCoqaH8ZJbFZf/M9gGdYbs36O/HBVznRihp30MS+HeoCSd6xHYJUtIhB9L8/8Ln97aREZ8Uk3UxhVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SJ0PR11MB5152.namprd11.prod.outlook.com (2603:10b6:a03:2ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 04:34:15 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 04:34:15 +0000
Message-ID: <c7af901f-e2d5-4544-8acc-600645655b5c@intel.com>
Date: Tue, 30 Sep 2025 12:34:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 06/28] sched: Save the per LLC utilization for
 better cache aware scheduling
To: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Valentin
 Schneider" <vschneid@redhat.com>, Libo Chen <libo.chen@oracle.com>, "Madadi
 Vineeth Reddy" <vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>, Jianyong Wu
	<jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>, Tingyin Duan
	<tingyin.duan@gmail.com>, Vern Hao <vernhao@tencent.com>, Len Brown
	<len.brown@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, Aubrey Li
	<aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Chen Yu
	<yu.chen.surf@gmail.com>, <linux-kernel@vger.kernel.org>
References: <cover.1754712565.git.tim.c.chen@linux.intel.com>
 <d77d4db175adc09cd01fdee097c16bc3e52c8be2.1754712565.git.tim.c.chen@linux.intel.com>
 <20250929140920.GN3419281@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20250929140920.GN3419281@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KUZPR04CA0023.apcprd04.prod.outlook.com
 (2603:1096:d10:25::13) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SJ0PR11MB5152:EE_
X-MS-Office365-Filtering-Correlation-Id: 83672bd3-95a3-4932-74c6-08ddffda9c47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TE9vbGZRZ3JkVXVkNWVLVFgrQi9NMkUrQnd3RWhZQ092RXBaKzBhOVNJclJS?=
 =?utf-8?B?MUNwVktyVmVrMHJGcm5DRndTS2RHd2d3b3NZekNhNEE4c2cvck9PSG1lcS9V?=
 =?utf-8?B?bmdKclExektYcHp0WFd5RGZNZHVkY2pXYjBVUitaM3VrNEpUb3RKcFRRSE5C?=
 =?utf-8?B?aGt0K2VzZThKcnNoYW5SNy92bFdHTE43ZXNQRDFTRWgzeFFKcW8vazBLUXJF?=
 =?utf-8?B?eGt1TXIrSGNjeDZmNURyVG9XN3BNdUs1eTZoS0E5Y2t5UjkzOGl5OXlQWjBq?=
 =?utf-8?B?aTRmNis2blNZMkw3QXRjaWQ0Q1liR0tDU2pqWGx6Y2Q0NWZCYS9TN1VKTk9n?=
 =?utf-8?B?eHRWUWs4U3BkcGZET0NFMUhPYndIV1hFTTd4K0hKQ3hDVDF2NlVlWGdaOEhR?=
 =?utf-8?B?OHJIeS9nMXBNN1Nacmo0KzlwZW5CZi85VXprM2FlMThKbzIyWXNuNGpQVndT?=
 =?utf-8?B?Y1lGYm1MUHhxam9HdWN4VUsrUlJRTUUvS0crbld4N2dvY05Xbm83b1AxQWJF?=
 =?utf-8?B?ZElpdDQ2SVZaaHdYNWhpd2VuenFBdUVDeUtHS1BFZ1lTNU4xazJPRTRnaWZB?=
 =?utf-8?B?cHNmTkdMczMyQ0NZSUozK3VMRS9YTmpNODlaWHRBUFZyY3ZBQnhScjZxM3pT?=
 =?utf-8?B?RjdXUjZTVVBEd0xlSW03VzM4OHRteStrOE5ucXJHaFB4Q0krdHNCeDZrWVd2?=
 =?utf-8?B?Uy82ZmdnZUJRSUpQSFRzVHFwcHpFK2toQmszMFE5N1d1M3RuS0VoWnJ6Z1Mx?=
 =?utf-8?B?RDlOZUtIb2l3M1lENVZZcERuUVdzMnFHcHVGRUZBSHJ1Vm5PNFU1QmZNa2VZ?=
 =?utf-8?B?Sm4wVVh0YzdRWWVITXpyZVE2Ni83Sm9samNaYW5QdVFYTVhRVGMzcjdlaGx6?=
 =?utf-8?B?cDV1akZPZ0FIM3N0c3BtV2UwRmZ1Q29VTDhrYU9IMGtxNVBJMWQ0NFkvSFJv?=
 =?utf-8?B?Z3hzV1JleTBNTXBCdU55T1FqZnVic2tmQ0Fwd3UvODRiMWRwL1Z5Z0ZxRks3?=
 =?utf-8?B?UUE1cXFPS284M2xnSmk4L3pWK3g5R0JDcy9qMWJOWUpMQXhmSkRKNWNpOFBP?=
 =?utf-8?B?TlVnZFAyc29OWmNTT2s5QUhwRGtWcVV0Nlk2Qm1WUkR4VXZpVlJ2bUc4S1hl?=
 =?utf-8?B?MHU3allGRTl1cEFJbTBhNXhObTl3Y3FkT2dkbXhBam5YQ0tzY2NJOUVXeGk3?=
 =?utf-8?B?am92OHlmbHhXT1J1UDF5TjgwaFl6dGFreEludUNVMWJSL2wyVVpLYm05eWN2?=
 =?utf-8?B?c1BoaWV0UWdsNzZtSHBjeTVaZlVrTXk1Y2lZYjVPWFppTVJuWUdjSEpmN2hr?=
 =?utf-8?B?Yjd5ZG52S1Z3R3UwTjJrSDNMTGdFcWtmaUc1OVJiNVJUbkwyVU1HSTdtUlZP?=
 =?utf-8?B?eUt2ZTBXY1haS3FPLy9aa3lMVGlVeEhaTDI3cHB0S3d5VVlSUVZrd2VuM2xU?=
 =?utf-8?B?ZytjVjVQSFRmMHV5ZG5ESXQybjVDNk5ERjg3TVlEMktDUHdPaGx5cVorcmVa?=
 =?utf-8?B?bE15RFpZNUpmWkVjOHNHTjVEWlFkM3YzY1pKekNzWjdBQ1RwdnBodFhLMTFG?=
 =?utf-8?B?NWFZNFdpcW1xaitSN290OXlJcEd3MGFDVGNuVDhBYitJV1c5T2djZUwzNlRo?=
 =?utf-8?B?OGhpcm5OdmxIL1FjVzVKQzhQRnRPZEYxczExT3dUVjJqR3RNdVkrNHJKYVFN?=
 =?utf-8?B?Nlppd2llMjZvK3RWdCtDcThicTdFQlREcU5kdUptYmVBcFZXZUk1TjlLVDhh?=
 =?utf-8?B?WGgvU0toWmtmdUk4TGYrYjRhY3lLTjZoRHlMc0dYcnlXV0FlRkNQY3VsaDhE?=
 =?utf-8?B?M2FVdm9Vd1J4d2dsLzdoNWEyRE5Fa0FaalZLMXNzeUtOdDU1b0FnclRwcFVE?=
 =?utf-8?B?TDhWYjVRdWUvSWVDWktWWFltQUFPcEExZXlvdDVvOFpKOFRzYkY4N3FXSyth?=
 =?utf-8?Q?rJ4sbB5FKwo0uTb8wu1P4n+8qUyImxJl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFRsVmtNQ0VkWVJYd1ZnM1F5S0dYWHhHcUZiL2RENk9aa3dCenhkY28rbFph?=
 =?utf-8?B?UEVPSE4wV1BzL3A1dFJtSXpBbXdCZ1J2d3JJT0I2bjBpbnJJcXlrNm05Zy81?=
 =?utf-8?B?U2tYZDNCSGNhS0FhcXVLazRPOFdHcUJodFhBWU53SzA0eEduUG85Q1ZtbTAy?=
 =?utf-8?B?L1FqWHFSa1RwNHowUXFlaCt4VHVtU2haT2QySzZXTWNWZjRSSU8vMWdUQzZB?=
 =?utf-8?B?Z2grV0V5RDFFdkhWQm1tYVBHR2JlOHBvOFBZTTJhdDFIV3BTclRKcWtCYVA1?=
 =?utf-8?B?R25DTHE3MGlXdE9KUTVSL2d2Tld3YnVsZkJIKzJHM1FXZ1pnU1B3U3RObnhC?=
 =?utf-8?B?cmZSb0VjUE4wUG1rSnZjdlZaRHMwd253MmFaVmY5d05zckE1Y0JSdngzeE9r?=
 =?utf-8?B?UWJlVngvNi9hSkI3b2V1clc5NlBCQzdQc20zdm80dmw4K3plWjZNZEd1M0NZ?=
 =?utf-8?B?YzVSZHBZL2J1azRTVFlHNy85MHdta1hpTWhBL1J5cERuejdSNjIrRFNVbEVP?=
 =?utf-8?B?R0hEdk9QMFpqYW95V2VtWDdYSVM3SndHcVNvSHYvdmNqZzNBcnFnb25XRWtr?=
 =?utf-8?B?b3dBa00vV0R0TWcxMWxmeXdmRVo0NHVxMklCTUt4RVJaMi9qRmVyOW1hL1Bl?=
 =?utf-8?B?Uk9nM29ya0pBUHJvSTE2b0o0cDdCajYwV3Y2R0ZoOXRjQVRaeFVUdnA0UHY4?=
 =?utf-8?B?aGxlVk1uVmZ1cWVuRkRHcCtXdkJ1UDZTZlUvZzJwTWhXL0NXT1dMcDNWR09T?=
 =?utf-8?B?aWtGMno3WGd1THFpc3poMGNwdzBDT0xQSWVoQm1ST25vbkxqV1RBaGVtbVFF?=
 =?utf-8?B?NHE1SmRLQ2lCalZoejNFd3Z0aWcvZE1lQmFTa3ZDbWVWUjRrMGxvdlJyL0h4?=
 =?utf-8?B?QmdNSCtZZmlJNmdjMjVCekNJcHZGOUcvbGF6b3QyNWZvSGFSMXVqeFpSQWky?=
 =?utf-8?B?bjVVYUNrZlg3SEVOaEhEQjhaQm9HMXRQbVc5c2N1eHNNWlZsSWdPUVdUMlgr?=
 =?utf-8?B?L2VzQWRVdW92VC9BS1ZrdFI3aVpxcjN3SVN1enBzWkNNMDN1djV2MHAvc3Bh?=
 =?utf-8?B?a1J2SThPME1WSEwzeUFBS0FGNzNSaktIQW1CeGZmeUcwS2h0MFY0ekJIWDk5?=
 =?utf-8?B?SmQvV2xwUzEvQWNkM05JbUNTUXZHemlFL0JQU1paSDNmUWhqc3BVd0Z1YUVO?=
 =?utf-8?B?cnBRZ1Q4RnhJUGVxQmNvSlhBZ0dnM1VTTFphOVczdG1DcGtxODVjUzdhN2Vw?=
 =?utf-8?B?Q2xyazhramphSDBKNXVRRUJORk0zM1o1d011TzhDSXVSQ0hlSkpONlJOL0c5?=
 =?utf-8?B?OWgyWlRHZjVVSExyN3pla3BvaHVUT2hhaUVRQm5hNDdRWWZrZk9hTmtjK3Jz?=
 =?utf-8?B?SFpOYndOSlRwbnlDelY4SkdkQXZ6VG8yZ1RIVWNZbnlLMzZHZEhOZzM5cytn?=
 =?utf-8?B?Rm1vdDZyMndrTzZ0NnB6RE4wZEhQVm11Yyt6RlF1LzVUWS9YNVU2Q3ByeVRZ?=
 =?utf-8?B?dlhxdnFpWXpWS1R2a0V6K3ZQUWNZK3I4c0NXREwvWXNocUFmWmdsRUpLZU5w?=
 =?utf-8?B?UitRVkY2TzVDSHRFSFBpaWl5QWJybG43TmhpK1VPdlRNcDh0dUVqL1NOVC9y?=
 =?utf-8?B?TXY4Nk54WXBPbzVQN2FvcG5Ec3dzdk1XVTQ4RU9DU0ZzUlVHdERtVWFWN1lV?=
 =?utf-8?B?ZjV1SEhDYWRuTnB6RE44czY1ZzBOU2tSL2htbTA3WmtLWkxKQWowN0JRZGJ2?=
 =?utf-8?B?TUg0ZGFkUkdTTG4zZmlvTm05UXhXVGViOWhOOHQ0NkRIU1plRkxPWlczc1F5?=
 =?utf-8?B?RDhrQzV6V2huUmk2N2lsQURNUm5xTHpCa1g1NDNTR2lITk9zU2tlYWh4K2hx?=
 =?utf-8?B?QzZpU3YwUnF0b1R0RXJ0NDFBK2owUWFUNTZEelJRcWt5aDU3VWlIZ1orK0pQ?=
 =?utf-8?B?NE42cGlGVHllZDZ2ek90aWRBT3UybHJFK3dHTDVvdSt1RFB3TjlQcURLZUhG?=
 =?utf-8?B?TXhPQkNYYm1HQkZXNVd2RlM2YzNuVVdZUUZtL0llTTFkWUZ5Qzk4K2FjOStK?=
 =?utf-8?B?NFhOQzBTTnFUNnNMcDVhdFo1WURyeEo1MVpEbzZNODRQZzc3bTRlODhkc1Jj?=
 =?utf-8?Q?QImaHEkgc4GDXrGgCe6xzS400?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 83672bd3-95a3-4932-74c6-08ddffda9c47
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 04:34:15.0581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYoH6s3dDItB7ZNXhgBOhtYxfkc/rjnPYItTAuOzaLY4P1BYZcKbYO8z2EPS1Qj9PRfTgzkxNfdbycbduMX0Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5152
X-OriginatorOrg: intel.com

On 9/29/2025 10:09 PM, Peter Zijlstra wrote:
> On Sat, Aug 09, 2025 at 01:02:54PM +0800, Chen Yu wrote:
> 
>> +#ifdef CONFIG_SCHED_CACHE
>> +/*
>> + * Save this sched group's statistic for later use:
>> + * The task wakeup and load balance can make better
>> + * decision based on these statistics.
>> + */
>> +static void update_sg_if_llc(struct lb_env *env, struct sg_lb_stats *sgs,
>> +			     struct sched_group *group)
>> +{
>> +	/* Find the sched domain that spans this group. */
>> +	struct sched_domain *sd = env->sd->child;
>> +	struct sched_domain_shared *sd_share;
>> +
>> +	if (!sched_feat(SCHED_CACHE) || env->idle == CPU_NEWLY_IDLE)
>> +		return;
>> +
>> +	/* only care the sched domain that spans 1 LLC */
>> +	if (!sd || !(sd->flags & SD_SHARE_LLC) ||
>> +	    !sd->parent || (sd->parent->flags & SD_SHARE_LLC))
>> +		return;
> 
> Did you want to write:
> 
> 	if (sd != per_cpu(sd_llc))
> 		return;
> 
> Or something?
> 

Ah right, will do it.

>> +	sd_share = rcu_dereference(per_cpu(sd_llc_shared,
>> +				  cpumask_first(sched_group_span(group))));
>> +	if (!sd_share)
>> +		return;
>> +
>> +	if (likely(READ_ONCE(sd_share->util_avg) != sgs->group_util))
>> +		WRITE_ONCE(sd_share->util_avg, sgs->group_util);
> 
> If you expect it to be different, does that whole load and compare still
> matter?
> 

OK, will write to it directly.

thanks,
Chenyu>> +}

