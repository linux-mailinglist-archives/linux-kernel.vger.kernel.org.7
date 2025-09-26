Return-Path: <linux-kernel+bounces-834129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 581D8BA3F32
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83968188F5E4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900E11A3A80;
	Fri, 26 Sep 2025 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UWcMMctf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6040134AB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894692; cv=fail; b=Y1vlKjOAIo3QoT8NT3UhQpdHDc+71BhdvmaWoh/tEbkhJ+10SM3CE+xFSHjZjbf+tzYvgZud7LwPk5O72xtUVTfHxj8W/gy4ZG4nfXAKxbvncZXfAHgHR61PmVv2opqA8qUfX5wymlhu36GgPDnONJMABh0OgJAT/84ZzhrWXic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894692; c=relaxed/simple;
	bh=JX+ZnMhOMDQNmtcljkVlkLTsPm+0WsRbeIZ/S3nfycA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CZD7FBKk4oEszh7YgK3lUfiiOqCqTDOIHYofxCxbiN+jxw/Y5hBNMLkvKMs9hZl4RlcKa+40e71/to5Dk2KGcm5n01K/i8ucnNS34Pp7Nh2EVV0IknY4QmLmnEefLhESdsJm46KtWUMYR5ZMflccoIr38IcDc5/7M9C9uILLj7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UWcMMctf; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758894691; x=1790430691;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JX+ZnMhOMDQNmtcljkVlkLTsPm+0WsRbeIZ/S3nfycA=;
  b=UWcMMctf/4vjrJ2DrDZDjqO6hyI6OcSJR2v3BLL4c62vOoFdMAXlV8Zz
   bhjq9SjduRFAJNnr/fMFe0SSnOo3G2Q8cEiA4zVdWiKTPpBT3ZOqrHWXa
   4xG0bEmO0MCjpycc3R9OvnqH+D6yp0WSQ+tiiRW99OVz1MI7ey+o92Prj
   iP60sz+KTnXmk+KNOJE4gm2GAixTi0uhFN8zQBBWrrEpA6UZ0eiLUhuzq
   rPyMLEowERxPNDHVuFx0gyYDR/VYCKB0aVzdA4qDSTVv0SnXFoZZgRY8L
   XivnommV77DV6WaEv9uiCCdl0LxnHBLRfjOn5IF0RC8beNck30DiK4Chw
   g==;
X-CSE-ConnectionGUID: JHwD8FqPSlWsm2Yi2oVXZA==
X-CSE-MsgGUID: YPQtj18gT3COXyhXh45vGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="60928579"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="60928579"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 06:51:30 -0700
X-CSE-ConnectionGUID: 0l66EVtoQc2zWuwsVahpaw==
X-CSE-MsgGUID: KeIPHROlS9WH2zHBFgKvjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="182785870"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 06:51:29 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 06:51:27 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 26 Sep 2025 06:51:27 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.3) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 06:51:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezePJJLsP2BDrE9u+5qXAbAb4qmMN5PZnYkaeWSBkQLf0dRB0OYQN8Bi6uJ2hB4R0JP8vzAeLxY7/s7ljWZtF+FcRSNeLR8sCyoUqKRsVqHRuWwHAT7wyvGJTb0lly0cho9lvT56uG4SiRebZWjfauq9VU22EdUp0h70dSdw7ODeoWrk9NFg0ENoAPozq4iIr5fqujz0z5l1T7SeJbwXB3qCAU/Z30zC4bWMxyX67EEcIsWbW/1epnREcf+C3DgMU1KiWCIwdz5hABdzUZ22mj3ZJzbv13lSCeREoasplMCwdtNu/TRjjcrwnC7UsuQbRMiFF79S4njfZTmZFGFtFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvGjap6m2qslZ4S78vKIg1t4I/5sft7FwhHlqHPGysU=;
 b=W/TwfBc29FabotGG4mxdsg7ZwKGxEGHPXEUoCGbgL4gbaQ4F/oYvJvbCia1EXiHIPKvv1AlfRa65hvojev4X7RAj6FDBYka9DL5v1r/ZDggZ7JQkMmXGWtAiw538ZFsEzvJFO5nbLM86AbX6ZCSmaZs6Ld/mV6+fwDXrsZoFBscWusVsD21zGbwPzvBiIBS+J2yDZEjdsWetoEApt1M3L3/3V/eio987VT5UhQO3oRu3uIoJmUNpJy4V526wOLIlzyTihBO82fG2+Xt0azaJakeoT08Q8Dq3vqQF9QosOLbldJ7EqkztITC2KonuGfEpbM4kW44mPoRX4yV4YIk/hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CY5PR11MB6341.namprd11.prod.outlook.com (2603:10b6:930:3e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.13; Fri, 26 Sep 2025 13:51:24 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 13:51:24 +0000
Message-ID: <1ec61212-24d5-4147-898a-f93c03c6ac94@intel.com>
Date: Fri, 26 Sep 2025 21:51:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 08/28] sched: Set up LLC indexing
To: Adam Li <adamli@os.amperecomputing.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Libo Chen
	<libo.chen@oracle.com>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>, "Hillf
 Danton" <hdanton@sina.com>, Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Jianyong Wu" <jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>,
	Tingyin Duan <tingyin.duan@gmail.com>, Vern Hao <vernhao@tencent.com>, Len
 Brown <len.brown@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, Aubrey Li
	<aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Chen Yu
	<yu.chen.surf@gmail.com>, <linux-kernel@vger.kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>
References: <cover.1754712565.git.tim.c.chen@linux.intel.com>
 <959d897daadc28b8115c97df04eec2af0fd79c5d.1754712565.git.tim.c.chen@linux.intel.com>
 <baa45b9a-d8ef-4652-a3c2-83596216fcb6@os.amperecomputing.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <baa45b9a-d8ef-4652-a3c2-83596216fcb6@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0059.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::20) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CY5PR11MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: 9606557d-b999-4af2-bc39-08ddfd03c7e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alpJYkpBaVBiUW14cm82cnZtZGZJeXBTMFVsNXJSaUYrSEMxOWMzMWhUNVl1?=
 =?utf-8?B?Z2NuYkdsaS9rRjMwQXhybW0xRVdZdFo0WHA5aWFyRmlwUnhNS2NoRkh2dzIv?=
 =?utf-8?B?UnRTdWZ3UGtPQUpFUWlyUXVlZmtSVkxYQWpjajlKTndISjVZN0RabDBWUmFk?=
 =?utf-8?B?ZVNXUk9uNmpIbnN4Sy8xd2JPbjRnNDdlQWhoZjVqWk9hbUZmeEtCZ3NPOUhS?=
 =?utf-8?B?QXNSYmpUVGNwMGpqbW00aTNVZDlQQ2RJaDVOUXFyNzZ4RDBnbHBlaGh5Z2h0?=
 =?utf-8?B?c2NWVmU4UFZpZEhNWVEzT2plN0tGbXZHWjVYUTBwSkRMMzJRY3ZtL1E0RGJE?=
 =?utf-8?B?OGxnSWNVNmZVeDhTbXBJd2NCOGU2NEtoNGV1b2NydlBrWHViL21zOEtqQ21Q?=
 =?utf-8?B?d0xwSnptTkZ6eHNUY0lMcExQRys5RWg5NEZKL3JLeXZwWmNiYktKbytSclhv?=
 =?utf-8?B?MzJEM25MNjZDRDNEbUswZzR6NGpMUE1oeXo3TWZ6aW9Ick5ycXZjdG95TW0v?=
 =?utf-8?B?M1BWMU5Pa3NKVkNlVzdJa25rM0tpaC9qMDdBNnE0RkMxSnlVRGhRTzhiUXNI?=
 =?utf-8?B?NHpxMFZ5MFFNeUhwQTVrWDdULzI2dEtET3Z4cEtEcFhmUlljZk8vU09hdzV0?=
 =?utf-8?B?Sk0yVUJkSHVsTmErQXExQllFdE41VXNDaFB1Y2JsUVYwNitsQ2daRno3K0pi?=
 =?utf-8?B?Z1VvYWgzeUxKaTNqVDNKMFFqZEk5d21iRHcrUmwvV0drYWl1NkYzci9NZzk1?=
 =?utf-8?B?M1FlKzJpbEZlVktZUnBoZ1EyNnBsRmRjSHQ5ajRxaE15bE9MRkRPaEtuNkEw?=
 =?utf-8?B?bGV4bXNNRG1sNHd2UG9YZExOSVR4RWs2RXlEems2cUlmU1Z0UVBvMUc2Ritz?=
 =?utf-8?B?NmpXV3NPOHFGUWErZEtIbmgrdzNMSmJMYUVORURMd295eVAxdndaQ3BOM0Vi?=
 =?utf-8?B?QzB3aTREdWRUNG9lQ1loM1NITk5VUThoYTNmWVA2dkIrQ1hNRzdVQzE1WmVS?=
 =?utf-8?B?NUZURGhFRDdqUTJWeFhoajRpcEdEN01VT0NkVHZ1aE1SN2U4STNZSTFmMDZT?=
 =?utf-8?B?M1U1czBYeWJXV1pzWnQvNUVpQytmQ05KKzRwd0trYy9OdkdsMXdFRFNVakpN?=
 =?utf-8?B?THU0dXN6aU9UUHRzaHpDZHZoRkhLeTFaOWRXdDVHR1c5NmVYN0RwVWZEaEJa?=
 =?utf-8?B?SWsxb1hqOFhwemMrMG9Rd0JxaDZYbUF0MVM4UWIyTjRXeFF2bzlvTHNSWE9Q?=
 =?utf-8?B?QzkzR1NwcDl0c0xVMXZkM2R3b2cwVzU2UEpjQWFEcUlCZGQ1bDA4dXFqVS9x?=
 =?utf-8?B?ZmNIOGVnN0ppWnhQSktJWEFoM0JQS0lyVkhIZWJNVDJaa3I3bzdKMWpWMDNk?=
 =?utf-8?B?MWJxN1BMQnAzME5YUUk1QVp4c2diU3VEMGpyWDM2QlN3bW9xZnA0NXdZL0pN?=
 =?utf-8?B?NXIzd0NmNDBmRWwrclFtbERQbGtRNDlHTmtVblIxSGRaZXdoVzVpQXVtL1lN?=
 =?utf-8?B?cWtLN2NPdHRXV1FmMzJwazMzN0tTT1F3WjM4NFlhN3NsOENSdWQ5L0I5SzJz?=
 =?utf-8?B?bk1senloYXh2VlVJb0IyK2xKbHRCNDdWbWc3cVZEMnQvSkk1OWRtMTE0TTVW?=
 =?utf-8?B?V1YyUXNkbi9BYlZxeXl2dVY3WEc3eUtXWXFCMGk1NEhocWxiMjdSNVhLZmd4?=
 =?utf-8?B?SndPNXhlV2dEVWtBbHBBZDJkMzdudWExd2NkZjBrL3NqNGZsT1JEQTRTNmJh?=
 =?utf-8?B?YlgzRnNTdllncWoxdjhLellvODZpWVRtQkZhL1E0bzZubDJ0cnF1YWFoaVM5?=
 =?utf-8?B?S0dPWnRBSW13c3c4bGYwYU9GMUR0OVRQQXQ3bndGSzNYVWFRbUJJQk9INUM4?=
 =?utf-8?B?RVhDZ1lqM3F5dE9HTk5vN2JzeVc3UEVCWC8yYzMxdlFmNXZXS0pRSnhPc3Uy?=
 =?utf-8?Q?CNALTfLN9yo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVJUSU5vVEhiQWdBNXc0K2pjM04zVE5lMTVrOXpmN1FxODl4ZlFwbmdCTGxp?=
 =?utf-8?B?akIvOURkZUp5K3hQNHU3Rm9ZYnFadlZMMkJ0S3VNcnN6UndFTU9oQmRiVm8z?=
 =?utf-8?B?UzlleTdDZDNKRDQzUklSREVpeU92MFZ5SGRTZWtWV2VCakI5aE44Um9NazJN?=
 =?utf-8?B?WWNaUU9FWXJ0N3pDdEtNeGZLM3lwQVR4b2Q1TnV6MTJMT2VBTDlER2szQ0xa?=
 =?utf-8?B?MnIzbW8xTmJGb2wrTVhOeEVlWCtpUmhSdGZ3K2JDSkF5KzdHMks1d0lWVVZ0?=
 =?utf-8?B?UEJSU1ZYS0NvMXY3OFVub2pWMms2MVZtMU1aTytocU9hZjBwV1NwNjdkZzdE?=
 =?utf-8?B?SzB3VFJFTUp3OVZtWDltaEI0OG9aNXFtUVpUY21IQzBGV0xRWGlwNWQ2OVMy?=
 =?utf-8?B?bmQyME1ZOVdyeFNFc2hIRlU2ekNvdjJCdHByanNUMzI4M3paSEhydEJrL2h6?=
 =?utf-8?B?b3JjWi9mLzhaMU5rQlRMSTRGRndQVmhSNzZCM05YK2xqT0EwSUV4OUZ1dWxD?=
 =?utf-8?B?a1Q4M1p6aU1wSUswell6MTZ5VDczSC9pZW1BUWdZQlVYRVVIZ0x3di9Cckd6?=
 =?utf-8?B?TmM5YzZ6Z2c2WWRwNm5ha0EwWmpHVFpSbnQ2RjRJcmtLVDVVWUV3N1E4eDBS?=
 =?utf-8?B?ZDBGLzJFWEk2ZSs0N1dPTUwzanVFQWE3V1UvNFZyTk9ielB5L21BNWE1aUg3?=
 =?utf-8?B?WkRHYkhHeU1xSE1JdHJSMjRLS01qK2VZWGRtcllxM0pQOVQyNHN6d2crZTlj?=
 =?utf-8?B?NnU5RDRrNzR4M2VBYjd0bmkvR2h0c3d1TmNnWXIzRjE5RElaQ2pzOWVSODlX?=
 =?utf-8?B?d2hGeU9Xc2FLbkYvZGU3ZFVlTWZBUHB3ak1LdzlEckwvSU9iSjRYMXlOVGx0?=
 =?utf-8?B?a3JkYm5tWDRMRnEzM0lzZ1Z5MytVaTM0SllQREdoQXFXU2tmU0toWm9QeTBo?=
 =?utf-8?B?L1RRMk1SV2VTb3pnYlpFRkFqa293T2V1QmhBOERzdWJ1UGVBZ2JCd0JiNkJv?=
 =?utf-8?B?clVQR1BMYkNXdGtha0g3eW85Y3lidmx2WGdBOGRTWTN1NmdTY1BqVEl2K045?=
 =?utf-8?B?ZEt0cjNoTXZKK1JackpnaXMvTGxMOVU1OFAreE52RmRzWTFRS0hEaVF6YjRu?=
 =?utf-8?B?VEVyalZrSmlvVmNvYm11SlNTV2ZtL05CN2FwWGNRNGF0Nm1iY0p6VHAxaXo1?=
 =?utf-8?B?cVJLTHZtUzFXMm14YkY5dW96RDlaWUtKOVZYSm9jVmF6MEpxVzVteDkvVlhZ?=
 =?utf-8?B?THJJRUF1cGxuVkQrNklJU2N1YUJhR3ZWc1lvRFRnT2ZrNmk1aFg0SXRiRC8v?=
 =?utf-8?B?Zm8ybDQzNVM4eU96UmhybXJVMXFLcEFFOGwvM3BJNmJadklQcUxyZCt3L1ZI?=
 =?utf-8?B?aWJJMlVXRlN0OExXYjA3REtROGVxejBmdjNFTy8wQWpvczAxR1ZlWUVxSEhL?=
 =?utf-8?B?a280eHpxczBYSXMzNTBwcDl6Y2xrejFSUWRXMnhiNDBoRVJJVWVsRHY4OTk1?=
 =?utf-8?B?TW9DcGxmVWtYTHYxZmR4bUd3M0d2MkdERnNqNE1ZSE1iVmdkNU1wUWc3QUM4?=
 =?utf-8?B?dktxKzZHNFBIc2RjUFZ3b081L0QxNk9GWTN1YmFybVo4Nm1VWnZzZ1Judmxl?=
 =?utf-8?B?TnBMcmlzRzQzeGNSb0F4SU51YXRnOU5sNml5NS9yREJyRnc3SURVektIQlZs?=
 =?utf-8?B?dElDb0ZkMEtPVnV4aEEreEwwTVIycjl4cXR0Zjdmdzhuc2ZUR1p5MXUwQTdG?=
 =?utf-8?B?MWsrOUg3aDBTSzlyd25xNjhZR1NiOGJYYmk3LzhDU3JkejB2ZlhPNzh5MzNO?=
 =?utf-8?B?OEJyYTE3aDdJVXpBZ3BXQVFiZDVORmNiblhzTE15Z1JCelVMWHRlRXAyZUdB?=
 =?utf-8?B?dW9iNmxxUFV1d0xYc29uR0hDV3gyS1FHTEZjQ1FIWkcrWjhmV2Y3SXJNbUV4?=
 =?utf-8?B?SGVNVThnU3ZJVlB3NitMeWpZY250eTBvVmVrTTlzQy9NRWZvS1dVelNPbWtr?=
 =?utf-8?B?cTVnbHErZ2Z6cnZOYkFuVTVQSU5rcUNRc1ZXWDFKWUNzMjFoRjZZMlZyUVZz?=
 =?utf-8?B?UmJ6by9aaFBEZExydGRXSGN3S2t6MHlVNUN3Y0drTGpUYkhxdFFJZGZzN2ZN?=
 =?utf-8?Q?UVNPvUIDNDVf9iEyRb+kNRTRV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9606557d-b999-4af2-bc39-08ddfd03c7e5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 13:51:24.0052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x4xdahxuaY+HUhVATOQ1oOpqn59Nf7Ioq60+4aJCcpF/lVc9irqRPbA34Cw8cD1E9YKLruMTmeek5/0IM2Wudw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6341
X-OriginatorOrg: intel.com

Hi Adam,

On 9/26/2025 2:14 PM, Adam Li wrote:
> Hi Chen Yu,
> 
> I tested the patch set on AmpereOne CPU with 192 cores.
> With certain firmware setting, each core has its own L1/L2 cache.
> But *no* cores share LLC (L3). So *no* schedule domain
> has flag 'SD_SHARE_LLC'.
> 

Good catch! And many thanks for your detailed testing and
analysis.

Is this issue triggered with CONFIG_SCHED_CLUSTER disabled?

> With this topology:
> per_cpu(sd_llc_id, cpu) is actually the cpu id (0-191).
> 
> And kernel bug will be triggered at:
> 'BUG_ON(idx > MAX_LLC)'
> 

Yes, the sd_llc_idx thing is a bit tricky - we want to use it to
index into the static array struct sg_lb_stat.nr_pref_llc, and
we have to limit its range. A better approach would be to
dynamically allocate the buffer, so we could get rid of the
'idx > MAX_LLC' check, but that might complicate the code.

> Please see details bellow.
> 
> The bug will disappear if setting 'MAX_LLC' to 192.
> But I think we might disable CAS(cache aware scheduling)
> if no domain has 'SD_SHARE_LLC'.
>

I agree with you. Simply disabling cache-aware scheduling
if there is no SD_SHARE_LLC would be simpler.

> On 8/9/2025 1:03 PM, Chen Yu wrote:
> A draft patch like bellow can fix the kernel BUG:
> 1) Do not call update_llc_idx() if domain has no SD_SHARE_LLC
> 2) Disable CAS if domain has no SD_SHARE_LLC
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 8483c02b4d28..cde9b6cdb1de 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -704,7 +704,8 @@ static void update_top_cache_domain(int cpu)
>          per_cpu(sd_llc_size, cpu) = size;
>          per_cpu(sd_llc_id, cpu) = id;
>          rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
> -       update_llc_idx(cpu);
> +       if (sd)
> +               update_llc_idx(cpu);
> 

OK, that make sense.

>          sd = lowest_flag_domain(cpu, SD_CLUSTER);
>          if (sd)
> @@ -2476,6 +2477,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>          int i, ret = -ENOMEM;
>          bool has_asym = false;
>          bool has_cluster = false;
> +       bool has_llc = false;
>          bool llc_has_parent_sd = false;
>          unsigned int multi_llcs_node = 1;
> 
> @@ -2621,6 +2623,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
> 
>                  if (lowest_flag_domain(i, SD_CLUSTER))
>                          has_cluster = true;
> +
> +               if (highest_flag_domain(i, SD_SHARE_LLC))
> +                       has_llc = true;
>          }
>          rcu_read_unlock();
> 
> @@ -2631,7 +2636,8 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>                  static_branch_inc_cpuslocked(&sched_cluster_active);
> 
>   #ifdef CONFIG_SCHED_CACHE
> -       if (llc_has_parent_sd && multi_llcs_node && !sched_asym_cpucap_active())
> +       if (has_llc && llc_has_parent_sd && multi_llcs_node &&

multi_llcs_node will be false if there is no SD_SHARE_LLC domain on the
platform, so I suppose we don’t have to introduce has_llc?
multi_llcs is set to true iff there are more than 1 SD_SHARE_LLC domains 
under its
SD_SHARE_LLC parent domain.

thanks,
Chenyu

> +           !sched_asym_cpucap_active())
>                  static_branch_inc_cpuslocked(&sched_cache_present);
>   #endif
> 
> 
> Thanks,
> -adam

