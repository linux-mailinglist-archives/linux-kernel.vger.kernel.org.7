Return-Path: <linux-kernel+bounces-751281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB53CB16734
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8D96228AF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD6C217F3D;
	Wed, 30 Jul 2025 19:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ed0drQf8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27EB1F4607;
	Wed, 30 Jul 2025 19:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753905265; cv=fail; b=f2bG1C7/+8mLripf3DdeEBIRdMrtqU2fOB0d+200YNdGllvf/uwNk8Noh+fwnzTsN2f/y6TyWWqdrS9tdWX5WQxKTc4Tu2pF6c1dZJaTDJzqSj97RGa/8IngrxqLxnP6Ub0IlIBPtvT36pHsFvtNn3UKE66XZglKjUUkrnwGBEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753905265; c=relaxed/simple;
	bh=AcEfL6cKQZxpoa6iN3w2x7moepSU8ulfIqRKJshhu7I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lfiqKKdZvvy72QvsHtZ4tsTXnCqsl0ZffwUrVTkIhMN3NY2G/Vz37jbB4MIE8EcPl0h+om8zxUlwmouTxSpBUxmG3P5UxInnQPOU6RbxOcel72anq1Pi1JBgFb5Xp+8bZociey2csLrW55CqzTWIS3scOpW707JL/7h57xFvXek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ed0drQf8; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753905263; x=1785441263;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AcEfL6cKQZxpoa6iN3w2x7moepSU8ulfIqRKJshhu7I=;
  b=ed0drQf8UPrjNj881uNnEFzjWuPEAVevGbxGbz3qHsaZjl85VMte/J9L
   iX4Y0p7SnSXTGcZbgg0LvTUiC1AibNdRdIa9jSRwZGkFs1FUnZoyvhFzR
   vkiin2I/0+B8SGhr5xRyVO53SBvKZxLp4IRR6UWNoFWvTnLIkhNJv1tiY
   +FgysCohFvk+QzCPe/HS/bHET0AbFss+neY3pRacofryiVuqYSv1gcE42
   gl5sKkngo9lr9/i4MguYEr96mIXF5hIh9K1w26BXivnnEn2qT6KpAVjBJ
   W5AqFt7Zsa/tTj/tuBfZrTiyF0y15RbiDiY5ODgElY7TMeXazHp5HJLUt
   Q==;
X-CSE-ConnectionGUID: m33ttyTZQHOtuDzeqWRBIg==
X-CSE-MsgGUID: rtCUgcOPRfyuo1Jk6TBcLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="55919303"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="55919303"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 12:54:23 -0700
X-CSE-ConnectionGUID: +hRi3U+9QNa4xG8Rh2B8Dw==
X-CSE-MsgGUID: vdyDV1NvR0OCrc80LDpExg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="162354155"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 12:54:24 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 12:54:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 12:54:22 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.61)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 12:54:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NC1BQwK99X7YZL9xbC6n/rLr0WsT6lngE621nBV9kAuBMTrseipU++1sdtmqB5GwCO/gpeRK8hMt0bMVWeirpCZ75vbDGZIKWzfnXObWFroyDrjyoPxVn+BtLJnxgL4f93isncIUXaAXGdeDXGfFTkwMwbDVtxYAWihHVP+erEi4HUfSzAZq+v71Obco0bowU9pERGt3t5cXb8m1FU0/N4My5NQLTRs3eyeAHfltxceDFdBOeyO+fYJpWauyg0S3IF6+OdT3o8hoSUAojTQcx9nJrWdyfHu+EHrDsDxn5AU04hZnKs40A470TOuu7dOlqY7Rnkxd+dKqNIfPFHKhNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfEh/H7kvuSxxOiy1azwCA6/NaSLHXURFvX+SF/scyE=;
 b=CgGo5Q+7pvRrzVc7w25J8K89RRdBcInL6kaZX+Q3vkikCjW4CG/9VvDjPFUtPttO6GCYP2TBCbrZF4sJesDoFiPcHVxL9oAbSDWnvi5fN4He2Hh68SaOIZEbuMbOEaeRpzYBRRsvmOYm2R1Och8nq0xoW5y4v8NljtnqSOAIAbct0sH4HjOcsN9BOiva0VdSosVuU4S/KvIgdFstXDVsS8hITqZ62b71vq0qZ7GmJxQWAIdr7rE9b65OOiyZMH9ZW0vUS966Nf7ev7lLN4eJCjEwbxkGdC17940Wmh7XeVU3pk3uvo5Pc8G7VTnGtV9iyJ30iRj0LUU84T1uJ0dTbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL4PR11MB8824.namprd11.prod.outlook.com (2603:10b6:208:5a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Wed, 30 Jul
 2025 19:54:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 19:54:07 +0000
Message-ID: <5c624683-e091-4a62-b240-c4535cd45393@intel.com>
Date: Wed, 30 Jul 2025 12:54:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 19/34] fs/resctrl: Pass struct rdtgroup instead of
 individual members
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
 <69f3501ba0851befc47063b593c3d180a7f2fb87.1753467772.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <69f3501ba0851befc47063b593c3d180a7f2fb87.1753467772.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0180.namprd03.prod.outlook.com
 (2603:10b6:303:8d::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL4PR11MB8824:EE_
X-MS-Office365-Filtering-Correlation-Id: a873c228-27e9-4fd4-9198-08ddcfa2d7c4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnBsak9HdExRbVRsOE9iTHlKQmJQSi9MS0FCUmg2MlFsVTdoaXI3c3FSYW12?=
 =?utf-8?B?TzlReUtiTzA2aEl1TGF2NWhQUnVnV0tsTGFkWjROaW1JY3BWZmdpTTJSZzEw?=
 =?utf-8?B?Q0xCZ1Zvam4rbmdoRkFzL1dVUjRiQU85Q2tBYUlwb0ExQXVtVDBMSlVpaThr?=
 =?utf-8?B?UjkyQmVTRGxwc2NUZTRFY1NjNHdrd1hzT00xVDBMWlhES2xmWFVUbzZNVGc5?=
 =?utf-8?B?c0dZQzRmaWRhZlplM3FLR1M5d08wdEN6L1JJWUUyUTAvTkJqN1ZCTVVTbWxN?=
 =?utf-8?B?MjRKcjlmUi9zWTB0K0hQejlLOFJvOTN6dzNCem1EaDRLY2Z5MEdxZmRXRzdo?=
 =?utf-8?B?NXFLTUZYWDJUS2VNakNqcFg1UnpWRmpkQ2h2THJnaVZpaEtvZ01mU0FzMVFM?=
 =?utf-8?B?RkRZZnY2U1ZvekZITTdTZWF2T0plKzcrZHB3cnlTWUowSjV6dnNQSXZyaDlz?=
 =?utf-8?B?VS9hRTR5MmtJZjZZcTZsVGtSa2dCNmkyeWh3QVBpUWZnSWRhVm5XMUdmTFhI?=
 =?utf-8?B?QnpTazdKSDl3bms3NTFOTTZvZ21pSDRYUEZXQ2dlc1FUSFZrTGNRYWl3L1Rs?=
 =?utf-8?B?OHM0N1pPMkpKUDY4cjg0anIwd1lwYitwZ3JueDdRUm1zSU1BdEtKbE03VTd0?=
 =?utf-8?B?TkEwV2NKYXJZY0pkb0Zabm5JOTIxZFpPenprK0VrbE9SZWlSbHJvS2NydjVK?=
 =?utf-8?B?UjM0NVBkUUxtYmlaMHQ3dE4xcVlFeUJJNzJPZ212QUdVeHNUVTB0K2ZCWXBC?=
 =?utf-8?B?Q2V0Y0xhcjIvOHhPY21aNXlteHRoTlhvdSs4WENmV2FKK1lLQklFckU3bi9h?=
 =?utf-8?B?L2RQdXFNUkxZSktXL21xYU9KdzZGQlVuc0VHays2OVZsTVJaTDhPK3V0RzNa?=
 =?utf-8?B?cjVJWE1MMHBBRS9DR2MxNUc5Q0dtMEhTc2p0czhpcUpnd09LOXFjMERoZmI2?=
 =?utf-8?B?b2U1NDRmbU5LeXpkdmhxWnRvL1V6UGR1a3N0UWY4WTFGNlh6MkRlSDNDK0l4?=
 =?utf-8?B?TStLcEF6dHlYNUtqZitBZzFFMHU2SFpPVit6SktBeDV5Y3BSaWt1bDh1Vmln?=
 =?utf-8?B?MmlUa09ZMjQ3T1lka2FKS2lZMVoyamtXVFdPUnpBbk9sWm9CYWtEUCtVc1hF?=
 =?utf-8?B?Z0cvQU4wVTV1T3ZzWnNoWWpFZ0hhZ241VEtJUTlZandKdVlBU0I1emNHQWhK?=
 =?utf-8?B?bE5mR1NLN3V5QzhLRnBSRVg5TkJwMEhPd3Q1ZWRTSThFL3lSa2pmSlcyRzlj?=
 =?utf-8?B?ZUx6UWc1eEV0TEhBOHNRQVkzQzRZM3Qxai94bnNpL09yelpNUTI0dFVIaXI2?=
 =?utf-8?B?ZUxpazJHczFyVldXclpEZ3g4SktaZjhoUjcrdEhIMWEyUE1WbFg0bmxVNHdP?=
 =?utf-8?B?SW5FaEwrbkFIdkY4YnkwZGltaS9pUGxqNis5TGFnTXFIeXc4MkhmOFYwOUdp?=
 =?utf-8?B?dVhUYUR5NW96UVlSMjEwS0hISTlsNXI5Qzg1blBwVHZFNDdRZ21Yd3c0ZzhX?=
 =?utf-8?B?WlJBZ1cyWkx6M28wcHQ0bEV5Mzlnc3ZTVWRhRS9wUVU3NFl5dmphbkJkQnJB?=
 =?utf-8?B?cVRyZmx3T1lYVlNBUEMyWk5QS3lMWXU4aGt2TlNJaDlEQmpKZjJVWERWc2ta?=
 =?utf-8?B?YmU2SXprZTBidmdaZ3BoSm1pTzNmbVQzb0YrSk1XUlJaM2N5Ti9wVmdLZkN2?=
 =?utf-8?B?c2tLaVNjazlNMkVrcVN2UXlxZWUvTkt6ZHZJRWtxVUxIYTlaTUlWeFRNaEcv?=
 =?utf-8?B?eTdORktrdHRscVpDdUZreFl1djU3UXdqSm45OVZkMDhBQldnVVV3aE5LMFNL?=
 =?utf-8?B?bWE0SWdXZlU3YWhLeDNTUlRwQjRHUyswUEJ0M2pSR2c3RW0wODFTL3VBQ0lZ?=
 =?utf-8?B?Skw1OFNPM1RwMVdzTDdHdnlETzZ4N1JEaXV3RlczT3d4NFlhZkt3Z2duTzlu?=
 =?utf-8?Q?x/IAWf3u5t4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXZYL01PVmlOM2pDNkIwdk1GYkhDb09wYWxnWmZ5aVZ2OTZsanZXeFVJTFg0?=
 =?utf-8?B?Q1hKZ2JQNk5BRHBoSUxBYUQwTXRXQjNoOW9Lb2dmZGVBcExGcHd0c2t1bUc4?=
 =?utf-8?B?REJ5TXl4dHhFZHlZdGZMV1NabnkvQTlMdUc5dFBPblloZ3VJWHQ1aTJ4cjd2?=
 =?utf-8?B?a2VmUHgwYkdpdzJIeElqaldjZ3lFQ3JJdnRYc2FORnMzeENJS3VTd1dkbU9N?=
 =?utf-8?B?NkF4aTRLckpXYUVmajhuaGJndUxyT3ZNNXRoWmNJS3Q2N3BTRWx3eVdySTJz?=
 =?utf-8?B?SHI1a3V3bHRsTmxsRHlFVVZKeEx4Q1Z3VU1Oa1lvUE5rQTcwQTFGU2huK2tI?=
 =?utf-8?B?eHFwNTUwaWRQQVdPQzFzNmYxN2RMKzM5bWZDbFRTY2s3bWRRSXdhaklzQlh2?=
 =?utf-8?B?dStsSTRHTlRMRXNNSW1GWkVMY1NvdUo5eldFTlZtdHJqMnNnUWFlSXpGK0ZU?=
 =?utf-8?B?UENxNTlOejZhZWNvSlNNZTU5eGdJT3B1MEV2VDhUeHBWOEk1eXZ2V3IzY3Iz?=
 =?utf-8?B?MnVpZ3FZeW1JOFpQY1o1TkVYM0RBeHBJbm82MFBlZFdvS2FDY3hiLytjaHVh?=
 =?utf-8?B?dmdFZWdqS1BnVVRuc0pGSEtHSEhmVlRYUzhHbUVVai9RNUR5cVA3UlpldkE3?=
 =?utf-8?B?QTI1UUxYNFk4VW9iS0NkdDQ4a2Z5NU5GUFFzTitac1hvOGRZL2FuVC90cFhJ?=
 =?utf-8?B?cGZyQ09VdGx6RGdLdk1KNzdOOVhRNWR1aU44cVFUcjZTU2RlYkhEZGpidlZB?=
 =?utf-8?B?YzltRnZ4MXRFSm03dVlkbXFnaVJTVktWZm0vejE0QlVBNUNaZjFxNHRNckV0?=
 =?utf-8?B?M1gvTHdpTUhqSjlFcDZDc0FGN3RSQ1JkRzZTc1RoZ3BRT0R3VjB4VWt3UEJF?=
 =?utf-8?B?WGNjdFhSK0dFV1pmWTNQMEZkOUhCNGdFVFFiczJIQnNXSFlpdndTd1ZFeTMw?=
 =?utf-8?B?ZnZMM0dpeWg4RnFtZXVWMlNQYk9wU0RoN25VK0ZYN3RLemFJMWR1RlRjQUNH?=
 =?utf-8?B?U2ZlTHZHYS9qbDcybHBtaHU0V0dsaXRMREE1dVYwRzA0YzhXbEJ2VWdrSmxZ?=
 =?utf-8?B?OFBrUVppUnJBb1RxOVRvT2FGVVE3YWN1SDdJTUFQVlNDQ3Y5YVhMVlRaa2Fl?=
 =?utf-8?B?NUVsSUZac25hYk5hSGp5YVd1MmszOU5XZ0hzNU1STmhHTGxuVmhDUncvSWxx?=
 =?utf-8?B?OGNJZXlocGdUeVMzcUhnRUoyU1QxSUFiQWtydloxQmZlRlowQmxDUzc1cytF?=
 =?utf-8?B?MEtrRS9Wb0VlcWQ4Mm5hU000YlpBS3lRZlpKUTkrdnlKRjFDSVkxclFyNU5u?=
 =?utf-8?B?eE0vN0hRMXc4c2RNQjNQM2JmRUJBczJnREpXSzgyUEoxdkh4bzZQdDMyQUtv?=
 =?utf-8?B?aFRSaEJVMm82bnNqY2NYR3V1QW1xZmM1QVdscjZNV1hsaEdjWFJYeUt2T0lh?=
 =?utf-8?B?OG1OdHAzYkVRTzRsUVpKcWVML1FJRGpiZ3crc1NLTWJ1cDJRUHp0VldtV1Jz?=
 =?utf-8?B?TC8vNSs5OW9PcXFWTVNnQWVEaDk1aGlxbENUN0pERmFyakV5QzcvcnZFNzlm?=
 =?utf-8?B?LzdOcENGOE1LVnRSanQ4eWxKZ0UyNHczZzhxblUwNUduNzJJRDNqYzdCU2lm?=
 =?utf-8?B?Qytpd2ZiSXFFSDJaZXlwWHd5SnpyTVpjb2pBVTFFV0ZsdGtteFNjYlRiRUVD?=
 =?utf-8?B?N2ErLzI4SWRqVUZuc3hhTDdZLzNjV2hRNG1KMTNKM0orWVdQcXMydXBlZDFU?=
 =?utf-8?B?bThUQWVaVTZXYk1tT2JZK2pyaytsQXNFRHpZSm5wS1lRMVNHNHF1M0xWdnBM?=
 =?utf-8?B?WDRQTUJDQWpNcGppYzZhRk84bUlTUkF4aFZuMGZ6b210NGhFd3RITmQvYVM4?=
 =?utf-8?B?WVpqN2h1YUk3U3dtTWJHYTJrbnNweUJra2k1anhraGZuTFVCYnE1MzQreE4z?=
 =?utf-8?B?SkkzSkQwYjNXcy9IWnBWKzl1K0VvelRFR0NYY0lSU3hGSTlrcG5ROFdDTXFz?=
 =?utf-8?B?THpuaFBvbWZsRDJ4VElwdWJKMi9tOFMwbkJwcXRHMmM4SGJrNC9IYWNaWEMw?=
 =?utf-8?B?Z0dNNzBuK2c3UHpDUTNKUzczTDRVMmF2akk0UjQwUko0TWZSZ2hUR3ZhZ3g4?=
 =?utf-8?B?d1VYdzhBTk9YVno4bmtqZTIyUnFhR2dBblpJbVJaRVZMN21MYlA1R2wyd2g5?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a873c228-27e9-4fd4-9198-08ddcfa2d7c4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:54:06.9636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nyvwo+8Bo26qCcdYM9GG/6+IucdLUJp3LfcsLJG8uvNiQEP6VTzmVLc2yded/GyIXtcd3VBSsFuKxw4/RWGGYsTi8XfKfDcvxekWgX6DCAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8824
X-OriginatorOrg: intel.com

Hi Babu,

On 7/25/25 11:29 AM, Babu Moger wrote:
> Reading monitoring data for a monitoring group requires both the RMID and
> CLOSID. The RMID and CLOSID are members of struct rdtgroup but passed
> separately to several functions involved in retrieving event data.
> 
> When "mbm_event" counter assignment mode is enabled, a counter ID is
> required to read event data. The counter ID is obtained through
> mbm_cntr_get(), which expects a struct rdtgroup pointer.
> 
> Provide a pointer to the struct rdtgroup as parameter to functions involved
> in retrieving event data to simplify access to RMID, CLOSID, and counter
> ID.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

