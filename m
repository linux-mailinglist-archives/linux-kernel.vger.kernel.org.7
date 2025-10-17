Return-Path: <linux-kernel+bounces-857256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D092BE6568
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA3C402F2B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 04:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD12123EAAC;
	Fri, 17 Oct 2025 04:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C2NKi8sG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395701F418D
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760676672; cv=fail; b=iRYBTnLUS5P4A6ywLEn7hWutFxrNYAGW7PCTX3z0wZLe7ZYZVF0uJZx1pFxZldaFVfFdjCGeT+LIIxI86x7Aem5l5Nq3gUdvM4dP48Mw7qJybDEz08j3PKQM63lByvVSHH4qW9hSNzVa7YDjNLIRCWVh/BPrpw4aEi8ritg1pZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760676672; c=relaxed/simple;
	bh=P2utiQlSZjVAZJGdSs/+3gFPvt2KTEVDPg60DLoyZ7U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eVUQMmkBAGsJt+wjXMvvAHhHmVg89mNiyvLJANfBRpl/7YwWJbjSCmwcznnf2VLVCMMgPp3oIdKXWwvxZA/EhV46Ms7UbBUDCCj9/iFDfjeYQ+Srd53QBtbdaHtCcaVTsCYGOvAEZNbuKtklNe//hwM3c962ZF8Dmw93OxJGEsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C2NKi8sG; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760676671; x=1792212671;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P2utiQlSZjVAZJGdSs/+3gFPvt2KTEVDPg60DLoyZ7U=;
  b=C2NKi8sGVlYl+kcKcORZJa4/v02rshAiHiBMB01PycXKKj6xbF3E1x0K
   QHObvzZ4bpt9V3pmxkybWCsN2swq8RQ1dycKgwOuv+GKao3Vdr6YHG68p
   nZtWoWjNBBl+L9+IjMGQq9kyp1FhE4FYqehmu/Km0zQGzal7tXguu6kRs
   1qrMkTyC3YZnnZqsXB4iNPVfCiBScZDYYwWkJPtNek52vbmkB3UE/8K9g
   Q51AOdFelJVBZLuW2+a2tHXfw91FgH5rNAa5PhuLh9uf5qkEVGsM7+xcX
   jXbfwvYM76fY1oVy0GQSHj74RfR7MbGezbZR6511lt42Q4xCQ1DfauZFB
   w==;
X-CSE-ConnectionGUID: Z1sj5Wx8RquJtgkDi1g8Yw==
X-CSE-MsgGUID: luqGS8joTsqxqmY2GdiGpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="74323860"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="74323860"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 21:51:07 -0700
X-CSE-ConnectionGUID: NBQjz5WJSXSF2OWQnya42w==
X-CSE-MsgGUID: 1OJ2qUpPQT6Z1u7WRqRQnA==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 21:51:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 21:51:06 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 21:51:06 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.10) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 21:51:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8WzpDZ5YUIyN8r+UVlqOgIEBSVH72vOm4efxdetQ9CmBDG/8Ymo+a8l7RZCTDNCCXT4rqJrh2wP9U2bGT0+7btWw8zt5e7H83oxEC1SLG/zY0j9/2HXDnJpih3NpbqwNm3ub5n5tTu0QlmbQBwdSeBqqkSqWy0dcRocK//3LvGryKqNaO88FdjuZVDEzVMdgmgw/2MsOeK2UVGNy6n1mPYGgux/kljgwBwXKNmXUrkIv0kC/Z2t4X53RIZU72AcStpE2ZXUD2RyCm3sQqme05kihpxKdKysKq8DIj74Ws4EYX4r66fTeOHoth32TtiBYYtojvn9f3aFmACiEkVzLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLSMELxog49Kk1oJet9EJl4XxR7YWBqTOloIM7W8s3o=;
 b=X/GREJ9Mor05NlaS5lasxXV9/1gmWBOTXq631YrG5Ey3or69ENbE9f7bxWVgMpPzZbFPWG3yQQXMVoYxU906mssRd0EJrvYmZtuc2GZ7VOEWxxaCGpZJo4MCy0Vp6UTFRPRowEyHMrk7xiuJ5jAwpfPDaJ2SEWLamtvI0hOCIge6pNHUt8JxqfZpeI1FCi8HRafY5oD3sP3nTR8Zqab8VOItO/KiGPOenridaOuLw4x3sji1wr7gJlrkCLUtaj033GxNB3K1hXvUMnkM9Dc0YA6v4Ff9aN/6gWR2nTO0HVtVaZXoV7nxOo2kGzUygUQfUVxbzzOkgsS5WL3ENHm4Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SA2PR11MB4986.namprd11.prod.outlook.com (2603:10b6:806:114::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 04:51:04 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 04:51:04 +0000
Message-ID: <4ec19969-831c-4d9e-b585-fc02db31b343@intel.com>
Date: Fri, 17 Oct 2025 12:50:47 +0800
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
	<zhao1.liu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, Adam Li
	<adamli@os.amperecomputing.com>, Tim Chen <tim.c.chen@intel.com>,
	<linux-kernel@vger.kernel.org>, <haoxing990@gmail.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <cfa266cd6ea6fa30cbf7b07573992f18f786955e.1760206683.git.tim.c.chen@linux.intel.com>
 <3df5a8c1-7074-4fcf-adf8-d39137314fd6@intel.com>
 <20251015111542.GQ3289052@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20251015111542.GQ3289052@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU0P306CA0036.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::11) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SA2PR11MB4986:EE_
X-MS-Office365-Filtering-Correlation-Id: 0356cb33-7fd0-4462-9840-08de0d38c6f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUh0T0RzSC9tUC9jbUJsbnFpK3pZRDRlQ1I2TEFxS0NEQWgyWEpwd005WHp5?=
 =?utf-8?B?TlNqQmVVbEExVVN0V2FtYmNVK1BjYWZGbnNUSmd4RnZoc09TWTAveWNNZ0hh?=
 =?utf-8?B?QjVhSm5aa0RxM2tVWEVrblFMNFlFNnY0bVlGODBveDJQNEdsK0ZmaEpEVEYv?=
 =?utf-8?B?a2RiMlNzQTg5NlBHamFqWks0ZnZ1Q0lFQW9MK0Z5Znp1b1V4aXVqbHZLR3Vs?=
 =?utf-8?B?cFlZWVNZWUpjUHlZMjFoMlp1THRXYnJtQm1CWTZVSlhQSFczYnpZTG83YTdn?=
 =?utf-8?B?MkVRdjZVaC9GSXNaMUIzWi9SNVFVVE5DT1VNWUs3Y055TWNvVTdPZ05kdXpD?=
 =?utf-8?B?eHNRaktteGFuMktPRXVoSmlDaE1YTm9Vb1d4SXpFODYrSDcvVElSZFBuNFFO?=
 =?utf-8?B?V1UzNjdEN1dsNnZCMDJ3R1JIZ1NFRU5KbXhpNE1qWkduVDl1V0g5d0tHMUQx?=
 =?utf-8?B?cE8vZTZrbTQrNjg1QnkxZ2J5SnNUU3FDd1V1bVR0OE1SRUlVNXlERE9JMEdU?=
 =?utf-8?B?dlVaalkrTFR5TmYzYkJlS3NkMGF6Y1V3MUYxcURIUUNOWEVBbkpWejkvcUNG?=
 =?utf-8?B?K0pNU3JXRm9FdTlVeDlEclNtSlV6MWVGemw5QkYwNk1MT1lNVE04RkxWNVBF?=
 =?utf-8?B?NWJ2K0pOZ01DN3ArdmxzR3pwaTY4R3JsUEdYRFI4T0hOcnZUTTh1elNOVE0w?=
 =?utf-8?B?K2NsbStqOTF1Q25JcndRdStvVVFLOGdiUXB0QWRBZ1RwUEZQd2FpRFV5WUI0?=
 =?utf-8?B?UmhkdXJ1d3NrR1crSDRlR2Iya2sxbXgwTWhrRlY1V1hkRWFoYkZSYVB0Nlp6?=
 =?utf-8?B?MTliN3Y1clhiVnVKSjV2MDVidEZvcHFqYmZYa0F2TCtsSkRtdTc2eU1lVWdS?=
 =?utf-8?B?SzJjM2ZhdU0raVpFTGNSck5ISmowZHVpMkFQZmdpYVh1UzRFSlZEazRXNXJ5?=
 =?utf-8?B?Y3hXam9YbHAzeXc1c1RMWk5kMzNiTU4rYWdHazZvQTEzeGtyNnlGOERmeFVn?=
 =?utf-8?B?Z1hMak0vZXVEcGJRaCt3a0lBTllJaW1lODNRbEN0amorbGhtbFNiRkNwcS9v?=
 =?utf-8?B?NFV4cUs4em0wUC9ZSjFpQUNRZk95eEl5Um9nZHF3cGNDRitLb0VBTUp3enFM?=
 =?utf-8?B?eXFheDhnWUdEMEZ3VTBiVlpXYTRzOHlJRFNqcXc4by9lU0NGTXl2OC9PeVNQ?=
 =?utf-8?B?TmtiY3hweHdHcVNHdTNlY0VIeHdFYjBHUS9LVFV6N3dSQkZrQlRlMXpZOTB2?=
 =?utf-8?B?WXlGTzdKNEhDZW1uV2M1elpUYnM3UVN6eUlqZElYZGVZeHlrTmdYSG9XRzZG?=
 =?utf-8?B?cXZwOXZmaFc5MmpzRWs2clVTN1VuZkdCakhRUEZ3bDFLeXE1S2VmUytpYWds?=
 =?utf-8?B?aU1XSkdkRGxUeENmNHNwNEpWYzJXYytoVkg3SHJ1M1hoZE5tdW0rcVVPQlZm?=
 =?utf-8?B?SUhuT1c1YytzeUY3N0txRWh1QjVmTW9hUUFqTWdTckUvb1hMczQ3VWtuWDVi?=
 =?utf-8?B?MVV5YVdvZ1VsUXhPS1dmdW1TUTFBd3BqRmpycjd2MHU4MXhLbDJJWEF4QmNn?=
 =?utf-8?B?cEFHcmMvZ3gycU1yVmpVWHQxRmpGcEZEalpkQVQzdkxVSUNSRzdmQUtMK2NY?=
 =?utf-8?B?cnprbSt5eURJR1RoVmdIQzJuOUNpNW1pWFpsQWRNcmtjaWJoWTl4UnRJWTEx?=
 =?utf-8?B?SXdjaUk4UWMvVE5SMUFQYkVMMWR1eWs5Um1VdFlqVkI0TDh5M0hmanlnTkcr?=
 =?utf-8?B?Mk1DU0lvSVF4N05rT2ZZM1BIUks0VXA1UEVlL05OZ3dBb2pENzNKZG9sS0dN?=
 =?utf-8?B?WFhTNGJSUmdYNzZpcVZJbVFKd2w1VDFhc2dVYmdDaHNmcnA0YXpVT3hIL2pP?=
 =?utf-8?B?OWtwN0c5RzNCN1V6SHRDRmM0VDdPZ0RDOTNwVVhhQ0hTaHhGVlYyNHNtcTkz?=
 =?utf-8?Q?HNKdcC2nZd7f688I91lRhyZYAVUAyqd0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWtJaUswMzRnQ3p0ZS9MS3Nybk80aXE1T0pQUFlzb0xqcnVyWFl6N2pVbXFP?=
 =?utf-8?B?aG91N2JVR0tRSVJubEE1YVV6RFpnQVkrKzlNQStEelQvL2RzK21kMDQyUzdk?=
 =?utf-8?B?YVV5a2s1V0R0aldUNC82azY0NWJLM2tGQVg1bGo3eXc2Y1N4R01Bd3IrUXlK?=
 =?utf-8?B?dXRvcG5YVEpWUFFlakt6WC9FY3FYWmplNWhyM0NObWhQRHNwMUw4RlA1dG42?=
 =?utf-8?B?UHFtaElWOHVsbFZaYkRBOGlXUDlneVZtcTNzTGV6YnFNUk9DQU5PaEN1MVdH?=
 =?utf-8?B?eUlpOG4yOWMvdG9kYTg0eXZUZ2oxVG53MlRFb0hBNlpRWjlyUEJibEc5QzE3?=
 =?utf-8?B?a1Z4SkNNOUluWVNNZitpdDVkWEdGQndnZm54Tit6RHRCR253L2xvdHI4akRu?=
 =?utf-8?B?WFpOTVZiNmhHbnBWRGk1V0prTnJGdUVMVWp0NkNlZkc0VUhsdnZYSm9HVk9M?=
 =?utf-8?B?eHY5d0tOQVR6RVlZYk5QRXV0aVh5TGhrVnZ3RXJwQTNEdk9tT2VpcTU3a3pO?=
 =?utf-8?B?cnU1aDJzSFdKR0hWOHJHRXFrT2ZJQnM0alJTTHFiNDVWWisxRFpJclpHTVZy?=
 =?utf-8?B?UFdzNzd1Ky9tdkJWTDhNZDZsYzVMazk3WWFQeUFiRGhsbWplVy9NbW5jY0pE?=
 =?utf-8?B?dWp1bWZXN081YzFrUFNKY3NNL3J2RmVQYnBtcGVobm5ZV1dDN1MyNGJiTE5v?=
 =?utf-8?B?SFU5M2RsWHpQNU9GKzQydFQ1a3N4WW9LN2NlbzFPdFdJSlcxMHdYQWVyaGZm?=
 =?utf-8?B?QmZ1dkxNUnVTRmxxWFA5NHFXQmM4cVZNaFdtMmRDQmZxS1lrdjJiM0ExaTVK?=
 =?utf-8?B?L3F0VzVRYm1LR3U1aHdPUmluRGhZN2NEZG9BLzlLdGZubzB2eE4rYXJhdHE3?=
 =?utf-8?B?K3k3aG92c2g4MSs3dENsdnpsQmZSVjE2d1ZZSEFhUE1YZ01RTmZURk9uUFJY?=
 =?utf-8?B?QlBsa2U0b0dwdnZPemNlZ0R3aE5iY2diaG82allSK0luT3pXZ1M2TzlNSzM1?=
 =?utf-8?B?WFJBNFR2QTQzSkdsZG1aOGtkbllaVEF4Z2dyTVFhVlE0TDR5VVVtcHFFMCt5?=
 =?utf-8?B?U05RS3o1QmtIUEdGSXRwWko5aVQyazIwSUZNemdyQWJUWm5IVWI3RCttK05Q?=
 =?utf-8?B?ME0zQ3VWOUhMQUY2aVZtN0doREZKSHU1SlZJeFprWkZxOXBxYTlkT0NyOVhI?=
 =?utf-8?B?TVpSKzF5ZU1HMHRUOWxMVUhLY1BVWEF6dkpxS2czK29DanRsQktSUXdsam43?=
 =?utf-8?B?S3hOeVR2TEdzMm1ZN2E3OC9oRnBpK3N5bkVLWDE1UDNid3VuZEhZQWZmcFlC?=
 =?utf-8?B?OUtKL0hUYW9wMGk0WGhRQWhldW0wclRXOXNzL0Q1VDBCRWdMQkxZRk4raEox?=
 =?utf-8?B?S0hjTUhqRWRqamFKWlg2Um81U1JKQ3BOVDJZVDdwTU9UZm5nN29JTE4xNWhz?=
 =?utf-8?B?dGsrVjV5U25vdEZLRVZmdjZyV1JuTFpESjZXNklGU3diZW9rYTB5cjRQRU5G?=
 =?utf-8?B?Q1FxOHZDdUc2cnpCNFJBenpGOUN6ZW8yUTd5ZGlkLzVMQ2Ftc0ZQOEt3cjYw?=
 =?utf-8?B?eTBEMHNmVEZkM1UxSGlPa1JRNnUrSDBLSDVYcmV3RTRJc1BBSlE3UVV5Qmt6?=
 =?utf-8?B?dU9pYy9wenhHZmhEUSt0TmRndC9TZDhnUThkSFN5eGo0U2d6YnhGN2VrQUl1?=
 =?utf-8?B?ZWR2THlYeUw4T3VobkdmZUtDeVN1YVdtSDkrRC9FdTBFaXQzYzd5Qlh1ZVg5?=
 =?utf-8?B?NTVKOERaT3JuNUw0NkFXNk9hcjF6RzhkbjNreTg3bHMxQ3FJQU5ISHY0N05B?=
 =?utf-8?B?a3VCT05FVHIvL0RPNmQrVlo1Wm1kdEZaY0diNHZPenlPUmZhSytTK1o3K1lS?=
 =?utf-8?B?dFFNMXVaNWtpa0NsejV4VzdHYkxRZzcza0l1eDNITVRXNHh5cUkyOXhXSlBT?=
 =?utf-8?B?SEhGc1RhVVhuVkRyVzlYVHd4UDkzUUthVko1L3doZ0Z1Nkd2K1hWSlFYeURu?=
 =?utf-8?B?TWlBRCtzK1YzcWxJcWF4TVByRzVlb2l6NlBrL0l5eThYaG1SajVrNTcrMy9W?=
 =?utf-8?B?OEtLTmgvbU52UVRZM2pnK2dYZ2EyRXJTME5jdlppNFg5dmZsMFdEWmg2TzA0?=
 =?utf-8?Q?kR6biHg78HwRhExnMMwoHwjf6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0356cb33-7fd0-4462-9840-08de0d38c6f4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 04:51:04.1868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIz2icBFFDtESFo9RnUgqyrNnsAFkZroYZFGZXhFG9O/EgJa8ZiHhltgliTRcsgoyW7zVRsL63mYl0DmmvKJAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4986
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

I did not intend to digress too far, but since this issue has been brought
up, a wild guess came to me - could the "interface to create thread groups"
here refer to something like the filesystem for memory cgroup
v2 thread mode? I just heard that some cloud users might split the threads
of a single process into different thread groups, where threads within each
group share data with one another (for example, when performing K-V hashing
operations). Using cgroup for this purpose might be a bit overkill, though,
considering that cgroup itself is designed for resource partitioning rather
than identifying tasks sharing data. Meanwhile, the hierarchy of cgroup
could also cause some overhead. If there were a single-layer thread 
partitioning
mechanism - similar to the resctrl filesystem - wouldn’t that allow us 
to avoid
modifying too much user business code while minimizing coupling with 
existing
kernel components?

thanks,
Chenyu

