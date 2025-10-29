Return-Path: <linux-kernel+bounces-876039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D96DEC1A7C8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC03A1A24947
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753CB34AAE0;
	Wed, 29 Oct 2025 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cWQ20e0c"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9DF32D43D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761741423; cv=fail; b=N2QWhbTrMUPU5QaxbIlA575tDV8jheQYeGw0i0LNEyDvf+V05zhe479Sou56F5yRv0x8K86U0qr/QwM+Eojojfy4uUVvJ7FancjMnv+9PtWQ5N2M77uUfuS4UALAOLsm9XPHVo0Gd6/oJxjt9ZHi3nvAzmBJXMVaag83+NLbpV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761741423; c=relaxed/simple;
	bh=XiYHGciSSsVMIILnYI1MsnKNHGHOXribxUbkEvfhtqI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K23tjVoHU5eD80TZXbdYPWWzdF06AIpStC9LdjBtPMpr1IpST1MtTaNRHzso0Ss3vThI7/L7e5VG5KApucvNFuHGfje634O5UhfGIRok727eL8ulvCqS63PcnksFX881K4v0fUaiGcU5tTh4ZuY8xUiE4dSGyiW9ayELitQXNPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cWQ20e0c; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761741421; x=1793277421;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XiYHGciSSsVMIILnYI1MsnKNHGHOXribxUbkEvfhtqI=;
  b=cWQ20e0cDIn/XGZkUS5sw3sz//0T1QsdVq0LOt8CeJCP9F9ZKL1X+HE1
   /9mm/RM1eWZCSDQHDS9JfJ5Dy/ZCSXQHMDc/5oBeFUMN9UWPR5XdUOtKQ
   TOx9Z4utxYKrZ65iHEQsS7r4NPWqjZyVbbMnAQlcNWMCS9n/TBJgM4DDx
   aP0LwAfN+8UdqUftZQzNtnyzj85fuRhEiHzwUP0KPYx0gUIaUvAMd8J4I
   tvS+BqM977vR7ZcSb9IJX3aCf8s+eE7eqNamM1AgDJHSczXS3D+mRWl7m
   KaXdkrYYdXJHsLmE1kkAbWp6AQxumzUE2q35dIvT2ksN30JzKgUkK7SbF
   w==;
X-CSE-ConnectionGUID: 5h5rxnqDTEWKXKdbxXquZA==
X-CSE-MsgGUID: HIGU0l2dSTy26962loOYmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11596"; a="74536691"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="74536691"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 05:37:00 -0700
X-CSE-ConnectionGUID: l8Lo7/PPR1yS5WWiVbO/og==
X-CSE-MsgGUID: 9sg3Ip+SS9OsfJQvQtjHxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="186002976"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 05:36:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 05:36:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 05:36:58 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.61) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 05:36:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTh9GUT/2w+NLVzyXYhdWJ6kv+eRcWWPR6O6wdJYv07J1nGL/NPJ1QNnd9UniLt8n8gH/yCoepJ6sKI/j9SrJ5/g4sOxlyNYWWTB12L+5MVkT9RDuEHi1YuzY8Y6x8br8WkQPiXWmpM8JddvoutFGtO2S//H9Xv8t8gnTkKQotX/2ZoRnq7TvYRiZQFltTtiwOaoLy9LJn4PBQMVAka4TSCH0DgyO5wqdtrUD7Y83Hv/Z+xJbfLa3aQs2fMQPugD2TzfIsw+hsGcImSCH4a3r2GntclYSyuKaPIbTN5BEJ7MM5fzRAIb9y1xotsQpcDnqOqEToIuoMJZRXBlsxg2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnEGJjkuz9JoxX9s6Y/Q62PE47onTcfe153Ntde7iFs=;
 b=oAGUdj+BQCQZZ3PMFqLKibDeUEgl0oAQa/xVDWumwqHrWmMkEQbQMuVd22M3msyJTz8vB46uM8cQwvx4di1Pi6V82SBTTOFTdGZpOrx7F5OJgN6O5a1+nMJgp/gJnESmUGqaDvOi3+g6AIfVHYPTAi19o11cJpKsjO/uX6TkNt7g7+HlQpqhqOziTMzjDhnrYOSee3KeYql57e7/3jlVUjb0+g3dreYdZji7OqYFOcq79JSLXdR9umKsNTUT27h84a8rY925BhSQkwE8Z3kHsEyQSjIqwIkIsYkUCHVJ6ozuAe82SnPXFK8kg7BWwpe41u3KqSmp8dKxdxY2kGRfDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DS7PR11MB6271.namprd11.prod.outlook.com (2603:10b6:8:95::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.13; Wed, 29 Oct 2025 12:36:56 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 12:36:55 +0000
Message-ID: <1540b472-b5b4-4e10-af88-816cc256931b@intel.com>
Date: Wed, 29 Oct 2025 20:36:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/19] sched/fair: Introduce a static key to enable cache
 aware only for multi LLCs
To: Tim Chen <tim.c.chen@linux.intel.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Madadi Vineeth
 Reddy" <vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>, "Shrikanth
 Hegde" <sshegde@linux.ibm.com>, Jianyong Wu <jianyong.wu@outlook.com>,
	"Yangyu Chen" <cyy@cyyself.name>, Tingyin Duan <tingyin.duan@gmail.com>, Vern
 Hao <vernhao@tencent.com>, Len Brown <len.brown@intel.com>, Aubrey Li
	<aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Chen Yu
	<yu.chen.surf@gmail.com>, Adam Li <adamli@os.amperecomputing.com>, Tim Chen
	<tim.c.chen@intel.com>, <linux-kernel@vger.kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Ingo
 Molnar" <mingo@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <ef136e6a6f5a2ef840b1f9571c47411f04705b6a.1760206683.git.tim.c.chen@linux.intel.com>
 <7ff17661-05fe-4137-b7e1-c799fe318c9f@amd.com>
 <ebc82974-7fe5-4e9a-8dae-7964cfdff471@intel.com>
 <e0f2c144f6dd974a816784db676779c1a1a3c5ab.camel@linux.intel.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <e0f2c144f6dd974a816784db676779c1a1a3c5ab.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0171.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::27) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DS7PR11MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: ca27fba4-9e3f-4fb2-9363-08de16e7d83e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wkt1Q0duRklWKyt6Y3NhOUNoSnRzcHlORXN3Zyt2SWJLRkxGdHpoL0dpNFZH?=
 =?utf-8?B?TVFHMGdYL2pHSVlHWUFqM1doNStUSzYrSStndTdDNVZNd2I2T3hZMktDamVF?=
 =?utf-8?B?eDZGdE02VGJnT00ySjNaNC9rUVpDTkIrb1lpbzRrNW1EMnlER0VGamlJYStM?=
 =?utf-8?B?azN3RVppbDVwbSs2YzFrTkJ0ei90cmRWVzBXekFEZk5MWFQzdmZaWlljY25v?=
 =?utf-8?B?Sm1KRWZ6N0Y5cHVaeFdQZlhpRG5QMXNINFdyK2tITUo5cUdXT2w5dlJXNll6?=
 =?utf-8?B?RHl5bTlSOEJnYXI4VnB3aHEyQWNkbUVEMmFXRTlBd0NZeHNFZXcrL3BDN2J3?=
 =?utf-8?B?b0c0Vk5CVEdEVUpMSHlxNVhoRkJDUFUxL1gyYjc4bkUrSzJhS2cwcCtJMy9Y?=
 =?utf-8?B?T1FnMFp1c1pFeXhvbVlpV2N6K0ZhRmxpQ3F2LzhwRis2eXM2UDZTcWJOQmtv?=
 =?utf-8?B?cG9WMkVWUS9Gd3RYMEJhczBVS21yVURTNCtObFlNeHBTeXVDNkNjZjVmQjVM?=
 =?utf-8?B?OHV3ZFREd3NyeGI5czNrWCtQVUF4dkQ0VlZ2c3F4WGpUaVRVS3IrRXlwVXVM?=
 =?utf-8?B?S09NcHFPcDNlREcyd2ZtNTV2UHFKZnlpUndScEt3TDlkbzRzR2RJelRpQXNj?=
 =?utf-8?B?TkNLSzBadEZlaWRkMXJLdFlna21BNWJZbldaS05obldyMFNGWVc5bldCK2lH?=
 =?utf-8?B?SDY5bGFZd1cyQ1R4bWI4OUY2Wi9lRlFUTCsvbGxWOGV4SzdDTWM0UWU1eVVI?=
 =?utf-8?B?SngzWXMyWXl2NDZ5MDFQZmlqaThuZFFZRkx2NkpDTW1xUS93TE5JM2gyUTFu?=
 =?utf-8?B?T0ZMeHM2TTNaZW5BVGFWRHdTQXh0ZnNLZlIxTEhOK1BtdEdoWnAzZWVuR3dS?=
 =?utf-8?B?TG5iMktCMjVISVZLajZVMFloSXVyVUtrZzk5dDRYeDZESCs1STNoMTN0ZW82?=
 =?utf-8?B?SjhCSmozUVhnOTBWbWZYOUpWRG1adkNhOXZ1d0JmS1ZjcGIvNFNyMStITlpz?=
 =?utf-8?B?dWVoaVBmelg0VER6a28zNStZSTM5M2p0eEFFN0R2WW5BUjZDUUlSUzZTa0xi?=
 =?utf-8?B?VFA1M2dIRXdGM0t0eUJ3WkZQNkx1dGkvWEtTSFYzVFdSdGR2NXVGQ1dhSGNm?=
 =?utf-8?B?ZmFsMDRwYzFIS1hjOGFWQlUzazNSVk1KOUhuQTBkUDhzWjI1QnJEVE1XOTJE?=
 =?utf-8?B?Y240aTlYcUo0MVBsWC9oV2ZIOGFaOTZnR01UQ1J1K3F3NEZJZVIyejZ5RzVx?=
 =?utf-8?B?b1VDWHpxY0lULzZrckdBSHhUN0FEOW9udlAya0xCN21qUFQxL3cya3RtdVFa?=
 =?utf-8?B?bU5kanpYOGV2WDNNWjgybEI2amlZNjcrM2hFT2o5ZW05YS9ac0RMVHRtWWRu?=
 =?utf-8?B?N1BiS2NncUFxaFZ5amE3VG41RVhGUE5ocTVidjFmTW5sUWJlTndYcFB6RS9U?=
 =?utf-8?B?VFZoQWlleDlXbC9uaDhGOVFPdHFmd3BWYmgzb2FENG5MelRIZDVocmdGWkpw?=
 =?utf-8?B?NkFFa1Z0UDFVb01XUHVhNzAwa2hiSG83WE91S0o3SWdpN0phRktLLzgvVmFv?=
 =?utf-8?B?QWJaZnA0ZEEwSFg5UkFuenZvc09aQTBiVENveHN3QVlpZHFVSXMrUTFiUnRq?=
 =?utf-8?B?NWlWNloyWG94NVRUT1JKcTNleENVRnJ6U2hRMVpPeHhJMVdvTi9PcE44cFRM?=
 =?utf-8?B?VTlZL0FJTmx3UlJyMWFDMDdOTGpEM21iTXdJMklwRWVoN2V5L2RFRjU1UGJh?=
 =?utf-8?B?VTdseG1tc3BuV28xc04vZVFwbjVkTmpkbUtadzBrMGV4VXlaOHVyRlNsaEMx?=
 =?utf-8?B?M3ExenBMSk1mNzB5bWxYeWdYamYycUxzWlR6ZEgxSmJtYXhhK3M4Slg5cHRT?=
 =?utf-8?B?WkNUa1BuQ2lVSm1tUSs1RnpKbERSZVVKMWtvYXVwMHlVR0NGOExuS1J3NWNE?=
 =?utf-8?Q?2rbvGMp63dSPoh7zN73NI7iYcbPCTH6w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0F2cnA1cFNFckhMeUsva2ovQ0hyM1YyeE5iTXRMOHJmTEl3Vmo4QVQwYnJH?=
 =?utf-8?B?cUV0cmFNVFNQeWpUcmdvUDE3OWNqTk5uR2xKd0xlRkVESHIveXFpVlM5bDcx?=
 =?utf-8?B?M0RJcVp3REZ2VnM3dW1SQmkxZGlNQWgrZXRNNVpublg5THZpSlpOSHorWFpC?=
 =?utf-8?B?VUJMQ1BuUnNFUGQ0dlRsRnJYQ3RMY080c3RCRU9zUGl2TUNTSDZHNXJmcURy?=
 =?utf-8?B?NDY1T3NyYzdRMXVORHcxNFJmd25qbXUzekhvVFRXVEJOK3lUV216VC8yMDR3?=
 =?utf-8?B?KzR2RzRxNkd4SVhvSWpENTJmTi9MMkxpVW9LSWVBRytpVTY4dytCUzEyakpZ?=
 =?utf-8?B?aE14SkpjN1dxODVQRlBBOFVQVi8rdXdWcWMrTGpNbzVJazVyeUF0UHdTdHFh?=
 =?utf-8?B?TDVjQW1tdW96T2FLKzVDbytYMVlWYkRwc1UvUFVLcjNxMzZjR2RqTHFYNkNY?=
 =?utf-8?B?UkVwa0VrbXgyc0FHYlEvdXpGUjFYWkNLKzU4Qkw0VUtlQzhyS0FwOWJVemlN?=
 =?utf-8?B?bVhmZEVyZXgrc0RtNlEzZXo4djEzVjZnNGxvQmJXZlh0RmdrSlpvQWE2RXdi?=
 =?utf-8?B?cXJFaU9FalduSk5KQVFjTUpHQmV3ZGpQU1RwcVcxVEdQdmpydUJWSVl0bXZS?=
 =?utf-8?B?ajJuMGdJeVlBNUhySnJ0TG1rWkt6Kzh1YkR5UWtDOGxSYXlyZG9DazI2ZVZ1?=
 =?utf-8?B?cmhkSGdIWFdQYm9LM3RWRkNnWDFkVEdaSldDV0NXWUt1LytUbVZocysxTWRx?=
 =?utf-8?B?NkVCYi9jcWcycTlLUWhXUFpHRmpzQXcxbHJmRlpIUjNCcDNrR1N1VEVmaTN3?=
 =?utf-8?B?MXM4Rm4ySmh0Q1NJVGR5cEx0Q2tId0MvbGRKL3V1NEZZWWVZWlgwZXRDanNk?=
 =?utf-8?B?NnpENFRWWW1zRVJ3aDJrOXh0QVZkZUY0SHhvTWJaRlRaZ2pJTXA1UzNiQjYy?=
 =?utf-8?B?QVlPQVRnSkZHTkpTd3Z4VVFIMjZlcmsxMmRvc2xnWHc2SUswV0xvVDgzN09v?=
 =?utf-8?B?akFJVnFOcWxHeXFwS2VPckhrNnhjQ0hTOTFRNGZJREhVdS85T05YaThkcHA2?=
 =?utf-8?B?a3UwM0lQajYxbWVDRzV4Q0w2a2ZDRWF5VzRhK0s1QmIwa3BvdVZXS2wwT1ox?=
 =?utf-8?B?ZXkwcTFLVlRRNGFKb3E3NzQrU0VHQXlZNExNQXN6cHM0dTNvOWtGV1htVXNs?=
 =?utf-8?B?NGpVbGZDVGZYY1FXRWxPQmFJQmRWbmNBQmsxVlJxaVZkTFVoenBqMkxXNWhR?=
 =?utf-8?B?WHZrV2ZtdzFiSFFsSHFxZi9LQ0ZtbnJFbElrWmNNMnFzam1GNDNDa1FvQ2Zo?=
 =?utf-8?B?ZlJkWWVsOTFPei9HSnNSWklXbXBqdlBacTl6akMrc0gyUk0rQ0FlODN2VDFM?=
 =?utf-8?B?N1NJZmZIbytYTS81c1Q0RkJUSWxOVG9TZjhKdVEzUUUrNjJPWTJSMHd1ZXIz?=
 =?utf-8?B?NUNXdlE3MDBTd1hjUzJxZ0F4SXpCNjlFRmo4S2tnY0loQ3lHRVE2V0JrWXdO?=
 =?utf-8?B?Z1NpbUI5RDZwWlZCSXNuSnA0WlpYcW1Vd1ZUVnE1ZEQ3OXBYZU4zVjNHWDFt?=
 =?utf-8?B?cXNUWjByVVQ5aENKd1duMEhqcnFkdmF6eGRPTHFCcmYrZzJrTTFabnoxVWFs?=
 =?utf-8?B?eFV1YjB5aFBGMWZlWHFlUU1sY09KY3NvNGhPSStwWXRQWUlwcHNLM1c0N1Jz?=
 =?utf-8?B?dTJlUm5xa1JKN3JoTkJiVUVOL2cwdEZKcVBVb2hKNWcwRXcrZ3VuNUcrR3Bj?=
 =?utf-8?B?MUtlRlhXWkhzVFMvNk9JTWtuNG9XMDN4aXV0YUU4U29wOXdhd1dFbTM2OFda?=
 =?utf-8?B?YWpSWGd6QVFGSVp5K0xTa001eDAzZFdLcnJFTU02SEVYcXpLNHhiWnRaRXpQ?=
 =?utf-8?B?WVpDdDR3dTVkWmVhM0RDQVVOZVd5SElaNHRNdWpJb29sUDdaa3pjS3dqeGYv?=
 =?utf-8?B?M1VtSnBJTEUwOXkzWFNyL1V5RVdLRjBtQ2xKNk5ReEczeWNvMFdJWnRKa0pR?=
 =?utf-8?B?Y0RoSDdyNVhpbUNRcERvTlZKQWNjYjhwUDNvdUphbmU2bnE4bXgyQ0FKeWhi?=
 =?utf-8?B?TlhJZlhjTENQQnNNNDNadE9Sb0JHN0trbTVLaVVWazZGZ21SKy9oaHdBZEN5?=
 =?utf-8?Q?0NmiOG2k9FiuAzOtEBOulZo8j?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca27fba4-9e3f-4fb2-9363-08de16e7d83e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 12:36:55.8239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYlmVlEZ5DDr0ADxkvQXXjUp3BZkm3BSnAU3T/SjpjQAXFCA6aPQFSvq5qeUEiPVqqceK32PwsVOgRAkdCyeZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6271
X-OriginatorOrg: intel.com

On 10/28/2025 7:36 AM, Tim Chen wrote:
> On Mon, 2025-10-27 at 20:56 +0800, Chen, Yu C wrote:
>> Hi Prateek,
>>
>> On 10/27/2025 1:42 PM, K Prateek Nayak wrote:
>>> Hello Tim,
>>>
>>> On 10/11/2025 11:54 PM, Tim Chen wrote:
>>>> @@ -2530,10 +2531,12 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>>>>    				 * between LLCs and memory channels.
>>>>    				 */
>>>>    				nr_llcs = sd->span_weight / child->span_weight;
>>>> -				if (nr_llcs == 1)
>>>> +				if (nr_llcs == 1) {
>>>>    					imb = sd->span_weight >> 3;
>>>> -				else
>>>> +				} else {
>>>>    					imb = nr_llcs;
>>>> +					has_multi_llcs = true;
>>>
>>> One caution: this will not hold if all the CPUs aren't online during boot.
>>> One case I can think of is when the kernel is booted with "maxcpus" cmdline
>>> and CPUs are hotplugged later.
>>>
>>> Unfortunately, I don't think we even have the raw topology data from the
>>> arch/ side under such scenario to accurately make a call if the system
>>> contains single or multiple LLC :(
>>>
>>> I'm not sure if it is feasible but assuming the task_work() cannot run if
>>> &sched_cache_allowed is false, can the fist instance of the task work for
>>> sched_cache do the necessary setup?
>>>
>>
>> build_sched_domains() might get invoked to rebuild the corresponding sched
>> domains during CPU hotplug via cpuset subsystem. So if the CPU gets online
>> after bootup, we still have the chance to detect multiple LLCs I suppose?
> 
> The case Pratek brought up of adding CPUs and enabling SCHED_CACHE
> should be covered.
> 
> The trickier case is if we disable SCHED_CACHE when CPUs are
> offlined and multi_cpus becomes false.  We'll need to clear out rq->nr_pref_llcs
> data and tasks' preferred LLC would need to be cleared.  Or else the accounting
> could be skewed we bring CPU online later and again re-enable SCHED_CACHE.

To safely keep the data consistent, do we need to add hook when 
SCHED_CACHE is
disabled at runtime, to clear all the stale data? In that way, another
race condition between SCHED_CACHE enabling vs EQ/DQ might also be covered.

thanks,
Chenyu
> So far we haven't done that when we disable SCHED_CACHE from an enabled state.
> 

