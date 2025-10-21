Return-Path: <linux-kernel+bounces-862229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B948BF4B96
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 806404EF060
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 06:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7842673B0;
	Tue, 21 Oct 2025 06:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O8ggewi2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79AC23EA9B
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761028812; cv=fail; b=DPf9nlruU4IS67sm79dT60pWSpD1HgPFLb+dYDNHHwQCnU7695tpFrYNZ3/puK0NWQKLFypZQM/iZKnU9PrWhfto6Epyua5uS/waUF11lUrNWY4PnfVyMsO/v4XM4/eCUtdUawORt1qf8sHAwiaMxg4TPmLFIlfzUkcoBOzQfAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761028812; c=relaxed/simple;
	bh=eyH+PrYyE1cJUvQiKkVrFlFrML/tQ9FwUrG+3OC9CJE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e9pSOk0jzxfx+Ml4e2D+p5n7zAYB6PMUCiK5NCJVTSR6aHhlcELZz5lFso51Qmwn9DIXwkF71nsRkoqTlROBH8X2o4uFSWpss7NzBIDnx9JV3SQyJfFPLfJIyY7ydlIl0lL4uufb68kv+D620Sxg+da32YB7YIi2a9/AtBtp6m4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O8ggewi2; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761028811; x=1792564811;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eyH+PrYyE1cJUvQiKkVrFlFrML/tQ9FwUrG+3OC9CJE=;
  b=O8ggewi2D+qNbYSQbaxcBk4IT8Z6+2SSypKXsUzPtq6owsAYkzUxnUsH
   UqDim/CJMycrYApOiSox0CyCj9PEfGJ+1HJ0jIwc7TyCbae2H1nnGwC3b
   fJCkFLLyu8sqPaS8lFG84imqGl2P9hr/ZLQCo4OSsghw0Fgr4vDyDUmgs
   0qG3nD27uriNwU6QTD52AQ/xY9D2LRd5xS/MTmhG4mF++XMaNwD331tq9
   wOMQkXZdwVbE28qjZCBr82fUvdND0jhaj8EQv/wN0jEp9VQ8Rh6otRUI2
   kPi1GeejXFORDPXruBr/bSX4wUpf/kH0t1zwAUpWWwpdI/8N0Qu2XrjIo
   g==;
X-CSE-ConnectionGUID: JjF1ZpaAQoCfRyc/0cd7yQ==
X-CSE-MsgGUID: 0aqV3nFbSZ6ztX4JK0+ktw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74491580"
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="74491580"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 23:40:10 -0700
X-CSE-ConnectionGUID: EjmxkVayTxajF9ioMwlneQ==
X-CSE-MsgGUID: IoyrwpVFR7KEVMu/L3Vufg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="182663256"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 23:40:10 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 23:40:09 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 23:40:09 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.50) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 23:40:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIKYoSPi4BmBBGUd4X3l89vq4JcLgx5e6rohsA080T6wafUF3rBFUQJnwyzNCujJadr2voxBrmnwSoCRsJcyzejxOLxFigzK2CdyBibRY8E8kXgW8hNMlJRStI/j63oOCM0NS204wOb+SlIWoFtMy+k1B8y6GqW7BqSL0/PQMSfyz6s7m0dc5+02qHdJNDIdOKuSa72rOY+HsHW7fxe/YXSuO/ASd9Shl6skSklTsj4X/5kX4vtoabocqR7eppmm7VNHd5/hdiZby4IQaJhB/2CGmopwivmh941WdicPqngaRIY7WnSv5hLDgSivwiL2S2JqrlARnSHNbhmaa3DlWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2oyB3oJDz7B6y1ZeVWBnoM8duR7OZbahqPQQ6WeC94=;
 b=NjMNAuwFWIcizmMTFzSGa/SwjZUFNp0dPfgF4Dj7tRPosNIFHGROzLChxAbFFuuV9zc2sVLxmjndqOQ8iU+l8IsZmjHYnGcu7qa6TiFuaup02rjFSkdXRfAJ43N1LLZI790NsMhRhfUe9+Fc4+d0VIrqqy+y4I7/tJ3f600F4p5dwLCdrJmKQsGxE4Knuamk+sjyRN2ifYaZNHKmT7UXg6T4iRNbYmVJKm1A8J1y+159zS/xCydW9eWn4512D5Zrsbn3NxNx7JdZXYfm2wLhUh/VxfHBe6ln/fpr+YM6FTYvbN3Z2VsKhlQfdzgPkxPSA9ZFayeW5gBWn2cnBMtW3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CH3PR11MB7769.namprd11.prod.outlook.com (2603:10b6:610:123::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 06:40:06 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 06:40:06 +0000
Message-ID: <37ebc412-5924-42ba-8919-af72deb98086@intel.com>
Date: Tue, 21 Oct 2025 14:39:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [tip:sched/core] [sched/fair] 79104becf4:
 BUG:kernel_NULL_pointer_dereference,address
To: Fernand Sieber <sieberf@amazon.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	<aubrey.li@linux.intel.com>, kernel test robot <oliver.sang@intel.com>
References: <202510211205.1e0f5223-lkp@intel.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <202510211205.1e0f5223-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0143.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::35) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CH3PR11MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: 729d8722-a86f-4e1c-d754-08de106cabfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnl4cytLa3FQdkQyUUgzcG11MkF0QngzZGpBaW8wZzN2emV0bFNNNnAvd3l0?=
 =?utf-8?B?bk5RVGdXNUhPTlQvVWQyYW5LRUkwSHlxSjlQeXp3anBJYnRxalhWWDhPNGZZ?=
 =?utf-8?B?TjFJTUsybFc5TUdDYjN2WnJmK3ZCTEM1bFF2enM1c1dKQy9UbE5rM0w1cllK?=
 =?utf-8?B?Q0VwaU5PSERCdHFDK3RoR09IK1VIMTJBRzh2UXdMQVltMGxJUGxhTnIyZ1hZ?=
 =?utf-8?B?MTdYM0dYRnF2Z0NreWE5OEJUWWdHWDhqV01jNWZhWk81NUJpeXFuMEtucW9E?=
 =?utf-8?B?b3d4eDJ1cUxYczBScWQzN2pYcGtleURqbm96MzNCaW9EUmZ0OUpuK3hMc0Vi?=
 =?utf-8?B?VFZlcUNobk5KUHJoUFp5cTdNejFCc0gwcFVJUXF6bTY0ZHFyQnJjQXE1SFVo?=
 =?utf-8?B?WHBkUGlDcjc2ZUNsc3IwZnFwU09vRmJDcGFyL2NaeWhhcVM0b3kwbW5selhM?=
 =?utf-8?B?SDdIc0pkYklJVnM5Ny9ERmdlU2ZreWJPWDNtVUt5SmdBblEwd0JVWWRPdzF2?=
 =?utf-8?B?RlRERWQyV0V1SHRYWm1xTUVmQ1FaYWxHbHNoSlN0WG0zMDMyUmNpelh4cmhZ?=
 =?utf-8?B?TjVpYWVrWXBpaHplVkxDbzJiNy9GdEJRbDFWRDVvMkJDdXd2RW1WUUZ6M3ZH?=
 =?utf-8?B?TFN6UDc3VHo2T3NvTm5ob2N5TmlHRDc5N0RpMTM1SGREdkJmeGpaMlM3Mmx3?=
 =?utf-8?B?YmY2dmVtNEN6SURWSWRnbDBFR1dKcWdteFhKWlRicFkyNXJWRVdMTkxENzYv?=
 =?utf-8?B?a3NVVDNKMnpVZExXSzFtT1crZzArNnFLbXpjd3ZGQ2RqZktFeUlINFFHbHlu?=
 =?utf-8?B?clJPbW5jSXJCdjRXSCs0RURkWmFQUmtoVDRpaEk1cnFITDhyRHpncFFtSWl0?=
 =?utf-8?B?dFJOMVlwOG9pdHFKOVdWeGFnM1BJdURGRFQrOXhkNGxhaTN1akR4UDZSZXRE?=
 =?utf-8?B?eTMxTlpNMHd6bGlyUHgyZktZZkI2Zzdhb2p6Z2wwOEdTYVIrWWR0UzZldVNp?=
 =?utf-8?B?ZlFsUE95dk1Hck4waWN0TkFIVG14c3RuVUlIS3F2NnhOcWtTMFJuRTNDV2VJ?=
 =?utf-8?B?UktRK1dLWXlHUXE5ZnlRZTMveWRldVRyT21sZGZiT1p4TzJlQ0FDUGZQaWpM?=
 =?utf-8?B?bisxZklxZkJQKzJvNytjbzZ1SHlPeCtxSENPVUNhM0VwUHBtSjJCUTErT3Rl?=
 =?utf-8?B?NFRDcURlbVBad0Z1S0hJWkFKNkQvdmJwT0daWEhXVGJLeU9XcGlJZ05iRTZt?=
 =?utf-8?B?QlF3bm9UdW55M2QrcGhvb1E1eHlCZGlYNklYbkxWNGpMckNaN0Y5ZXFLMEVk?=
 =?utf-8?B?U0h4RUVCY3g2ekdCNXlGN1NCck5GMlpOZlJsRjRxRUJvdU4remx3Z29hVmZW?=
 =?utf-8?B?YTJqcDYyQ0JtcDc5dzlhRTdFUzZtalA2QWhLbWlhcDdra1IrRmJjbGM1K3RQ?=
 =?utf-8?B?NmZmRXFnU245RFBSZDdXYW42cVVuaUNqSjVtRUZtZGJWbEJ3LzRkYUxqbzZJ?=
 =?utf-8?B?N0R1S3ByMFlrR1p5UXdkbytFU1hSTFNwRGY0VEJLWHZMVnJibXFVV2RoVFFx?=
 =?utf-8?B?bmliNXRRNktNKzBNbnRBcGhnVUc5dGo1ZEV0SGRIRzNraXF3K2FZT3RBTHAz?=
 =?utf-8?B?cXFwblFDVzhIcDh3TGxxL3dWc24zN3VEZVNyZGVqSXR0dnVhOUNXalcvbUpI?=
 =?utf-8?B?bWxWaVVKQkxkUGVlZFJOamF2TGU2a0R0S1NoV2dUVnpESGYva1d2S0JuZEU2?=
 =?utf-8?B?LzRkdVhBQmFGY3JjTTRlS3JPWnZaMS80MFRaNGJwOU00eFRmSWVzWFhOMGJo?=
 =?utf-8?B?NmlEaHZvcmJmcXRIQkZGZm55cmpOQ3plSU44Q3VORVJkWUVUeGR1dDk1K2RF?=
 =?utf-8?B?cW9KVGQwY3BjMkJqRTlOOGZGcVZBaGlINFlYa2dpRUdPVEpMNVRqTEJyUStu?=
 =?utf-8?Q?e8DYFn7fTxQ/m2LmIh5uZoZnIpOiLKEc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K08zbTdhUXVQcHFha09jWG5mditxbmJJM2REL1AwN09pNzQyQnZwVklVeUZx?=
 =?utf-8?B?ZWJxSWpvNkcyUXg4dSs0d3Z4VkZvZzZMM25MSzE1bTJ4M2hZQjBMaGNwWXZk?=
 =?utf-8?B?aDdWSDk4UFhJRXNaVldHSGxiY05VS093MUd6ZXRST29VS1JzZkFkYzBUeEV6?=
 =?utf-8?B?ZkpvbHRWSzhjaFhKdU9GWU5zYVRZa2hRSGJaT3l3NUM0aUxLL2xTaTk2MlU0?=
 =?utf-8?B?dGltdklZaUs2cTd2M3UrY0NweWlYMHRwaUl0RHVlbkgvOUtmcm9hUFozRlJl?=
 =?utf-8?B?N0lJNnpzZkhyYngrSkxxeGR0RmwwVzlVbjZBYm14eEluSlFQcno1a3lZeVVI?=
 =?utf-8?B?UFcvcFlrbk5PMS9DNkk0Sks0ZnQ0bXI2N1ZIaE9xeTdpMmtENFdzVjlBTDRL?=
 =?utf-8?B?bE5tVDNLSXlRNHREQTJ0T1RhMzRyMGFmTUdnSGlFTy9GeXdLdlMvanhUMlJF?=
 =?utf-8?B?M244SUtTQXhGcUE0ZEdseUU4Q0FmRXFJQzlQOFpBUW1hOXYyU0ZGeGRBMmhm?=
 =?utf-8?B?T1VscmxUYmgwTkdxMXkxNGxBeis3RlI3dGlhTmtRK2UyYlZqSHFObm1RczhV?=
 =?utf-8?B?ZmxBWUswRFJObWJzdUNZWVFjVzAyaVZFbjFwZ1pacjIramlHSXZpQ2tWcjZV?=
 =?utf-8?B?V3NFZUE4eXhwMzNKempVMzdWd1ZqR2xwbVNEak5XS3J6SUMwRzNqZkhLR3h3?=
 =?utf-8?B?bzgxZmJkb0tWOTRpaHpsRFNtdGtOSkhQN2xUUmtVYzNMYVltKzlQSCtRekJs?=
 =?utf-8?B?TlhueENuUzdJMG1tWFJNSE9iK3NjZkpDYk92U2ZOUVQ5TGVLSDVDaG94Y3o5?=
 =?utf-8?B?L2REc3hPZ244NFhnS2czSmRsK2Y1OXNCZDFvc083K1dPWi9uRURaMXJoV1VT?=
 =?utf-8?B?UkxtOFdVOURTNGZIWlZmVTVCY2F6UXF3dDBrRGRiTzkyYjFnTHRhT0diRk1j?=
 =?utf-8?B?YnIyRXZmTlpmVmFFb0xER2dSWFVpNUFxNmppVW80OUtwVkdZT1lLUXFmV1Ux?=
 =?utf-8?B?b2F4Zjl5bkg5UEpPenl4cEhsK3RIcDNRNzVsTlV1dHdScnBTLzh2cGMvMHpt?=
 =?utf-8?B?U093T29sU2EzbWpHeXN0eU9ZdzI1cGRITWU4alpJVFBUTnIvNWhDM2VHZzRZ?=
 =?utf-8?B?ME96UXRZV3paejBrYXZ5VmtLaExGUDdob0U0Wm1oTDRlZ0lNSmdsRG5GTTc0?=
 =?utf-8?B?UkkyczZVYWcwZmcwVGJRMXRCbEhudWRIWEdjV2JkWTFXdEE3bHd6aWViVTZn?=
 =?utf-8?B?MjRMTkFhcjR2RzhqWXVsQ01hVGY2Y0Zlamt6T1dwSy9NMVk2bTg2ZFJNS1FC?=
 =?utf-8?B?SFdBMnJLK3NLK1VHbkpJa1c5UWZhR0JWNWhCanIrRldoWkl4ZDhISUI4L09I?=
 =?utf-8?B?NFhTdjZUM3NaQjBuQ0RqRFhZS3g2V0dPMThwNDJkaUI4V1ZBUEdFcXN4Qmpp?=
 =?utf-8?B?ZDZ3VWw2Nk85cnAxa0hIUnE4OEZhSVZpNEhzbzd1Tm9DRm8rRm1GVCtwZzJW?=
 =?utf-8?B?bTFidWY5czJOajVYeEdUY2g1RVFYZXdDS0czaHI5YTJsa1JtdE5VMHdDNmtB?=
 =?utf-8?B?bG5pTGMwc2JzTGZzTkFRNEZEU0pvSTc0cXVabmlhWUtwSUhqc3BqYU4vOVZT?=
 =?utf-8?B?d0t1TjRsNVB0VDZGMWRnbTkrciswNTRMb0NSeHZqZWEyNGp5Q2pJMkYyTlVM?=
 =?utf-8?B?UUxuUEhkemdzcTBaejhyTlJhbDFWbzZnV2pKNEh6L2NPMVViMnpKQ1ROaVJq?=
 =?utf-8?B?SmR6NWhheGZ2UDB0MXFzanN6M1lRbmRDWlBpWjNaOFFaSjQ2MUNqSkNPQW10?=
 =?utf-8?B?Yi9GeUlnaktNQVZ6UWk3WnhjT1pVV0FQNEVCQ2pHOGVQSzdjbyt6L2xXV2Fo?=
 =?utf-8?B?YlRaa0dJMUl4cFpGVDRMSWdGZkVER2Y4SWJwWUxHaXF6WUQyZFRIdkxkaUtv?=
 =?utf-8?B?dllMajh6ZHBDdXQ3RnUzTFZNTHBRbXlNZ0ZHQ1hQT3dZS1N6cXRVck1KZ1V0?=
 =?utf-8?B?aGNnSmhLRVVZQU5kblQzOUl1UlloQnpLR3BMMEVLRVFkQnpiY0FjbW8wZ1Rw?=
 =?utf-8?B?Q1J5bWZvbmhEdzJIOTdmSVF0MTFCV0VBNTFsamNwVmppYk44V3R3bkNKQkFX?=
 =?utf-8?Q?Ff6FbMkix4zp+F0lMZCPfq2bE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 729d8722-a86f-4e1c-d754-08de106cabfa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 06:40:06.4368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: br5coM3THc1CqBRSiYOsgrzhs8XgWhMpvTnjZvBgIECAqzkUip2eWmYZ8VnI+nRMvYJo0NMbUikb7AbvmZZhow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7769
X-OriginatorOrg: intel.com

On 10/21/2025 1:14 PM, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:
> 
> commit: 79104becf42baeeb4a3f2b106f954b9fc7c10a3c ("sched/fair: Forfeit vruntime on yield")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core
> 
> [   23.486344][ T3682] BUG: kernel NULL pointer dereference, address: 0000000000000051
> [   23.486846][ T3682] #PF: supervisor read access in kernel mode
> [   23.487189][ T3682] #PF: error_code(0x0000) - not-present page
> [   23.487532][ T3682] PGD 12b0a5067 P4D 12b0a5067 PUD 12b0b0067 PMD 0
> [   23.487905][ T3682] Oops: Oops: 0000 [#1]
> [   23.488147][ T3682] CPU: 0 UID: 65534 PID: 3682 Comm: trinity-c1 Not tainted 6.18.0-rc1-00001-g79104becf42b #1 PREEMPT
> [   23.488817][ T3682] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   23.489401][ T3682] RIP: 0010:pick_task_fair (kernel/sched/fair.c:5526 kernel/sched/fair.c:8846)

Take a glance at the context, it seems to break here:
pick_next_entity(rq, cfs_rq)
   se = pick_eevdf(cfs_rq);
     se->sched_delayed   <=== se is NULL

In the original change, we force the current running
  se's vruntime moving forward and I guess for some
reason the corresponding cfs_rq->min_vruntime moves
forward too. Thus the rest se in the cfs_rq become
ineligible, and pick_eevdf() return NULL.

thanks,
Chenyu



