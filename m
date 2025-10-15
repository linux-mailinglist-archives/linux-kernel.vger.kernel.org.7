Return-Path: <linux-kernel+bounces-854940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A48BDFCB0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EF0F4E810F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F02733A02B;
	Wed, 15 Oct 2025 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S+9UztE7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636CA26AA94
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760547689; cv=fail; b=KnPc42MNgameShH1CaFkDYGS68ZHYh93o4Hw7kynfLfMICJYRPcbs8J1TK0rjCijCYFIhwWu7/6z9CELVGaMsLeTK3UBTmWHYY2gLIJKNEBrqsSjIhGjl74lCtCWSnYaa9x0gjdOD7/gXTVmfXb5K9juRMBKN3ff7dcNDYV+2JM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760547689; c=relaxed/simple;
	bh=tjOeJxlO97c3MjrMpUopypMUy3Br/Hg9IhuMv7hpFxE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AiLNU4K1HdMDDIay9pLEAowjH7LFPDJ/kR836iiAzmn2apyjaDun/ORLTrzsbb1gKLLi4vURVBjnBdbUWr+xgLgDqRUTqOiNb1sgryHIBsog6fkJyhB3xQKHjJ/E9UStj2lKt2wa7HO55a5RVHKPnpFiXuCwi4dHoen2SIts6n0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S+9UztE7; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760547687; x=1792083687;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tjOeJxlO97c3MjrMpUopypMUy3Br/Hg9IhuMv7hpFxE=;
  b=S+9UztE7XAOIn9LnPsTC8Skvsg5gisG8bnqdxeJf0swb2sonNuwSxPLB
   lr9KCqqBLXikmfhdZl1zvw9j+ZFbnaWS6uZscSLl1urNSLoy17gkoi0Fa
   A00HB7pss0qNfanR+lxrtsqBn6M8VbvjmtLcWZxpF4qkvaz7U78i3MHaJ
   BTu6ZGj5lSRDWX0arngsgrfpbr6KlUbrcUC9gr+KHTAL6P31gXSC/EWZ7
   T0JuYmmrslycsXxUp6RGWf1cDEWz6FwY10fNiJi+k9XifPlV/2YnzRhfg
   wJbVXJEaGbx5qYcNNpe13k2abkxqVo8u+OIPMYn1udnWWJnBKwYqFAZqX
   Q==;
X-CSE-ConnectionGUID: sjC5VNlBTE+rhS9os/WJCw==
X-CSE-MsgGUID: xa1FDfYpT+m961ey4byIUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="66593750"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="66593750"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 10:01:26 -0700
X-CSE-ConnectionGUID: ZDUam/1hQMu+N4icAUyqBg==
X-CSE-MsgGUID: HmeuCTV0T7eQIvMTAk/TdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="181780459"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 10:01:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 10:01:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 10:01:25 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.24) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 10:01:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbAgq7H4dnVZmIwyPDtetERSAMwm4hnqqJhfnfBHNKVsPIWdfeETOmMyW6wpK6ugiCO5qCICrpWsaFgUeTuKizWwNl1v6OUwp4gQgnFIm277S582sknxHQv+QpiiPZlFCBuXGKKTsWSI+NViZ+98Rifg0Twt6JTohc2w4WmEwOeo/1QWFhWwN/NXq9fY0iCiyIbRJAgYmYE9auZyfPWm7XY8RDHtrx8scAa1odilFZ45PnQeHsVnkjfy6Wg8fIhW6ZsQO/Li69uSmujPC/S/eqEo4weUHwE/eSFdPqDmdJH7t/yZnSjMFo9oWIPenEOjTQ1rQdBV6M6slyjeN8625Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BexaB7fW4h9QR7V4tAJPuYzAnhaIAMw1EATitwm0rNI=;
 b=fEi1ESKL3vGIC1zwFbEPojwHf+4c5jXUfRnRk2P6LOyvOyLyoVbL+325d5h4Qfz6STvfB9BmdmYiNsRlDu6PcAknbINt8HeiPAOuQEiRlaVb1tyF/p8z/YD1hlv4RiOdLgKDPA1LymR2OeK73sUP/FnfwixMqYn2caX+++UdhmI7Y20YGLlfkDsZ/WAvhvxmoOsZdCZ/K8Xdvjp3cvty9UtVd/CNwiKLOUcRBp16rj5B58wn6UYKwyrIqbHxXiMWcWNQtbeQS3bqYZ1WDhrOn1HwQHXpWEsTypXxArmbRnJGqpri6smzf8izqbeQf4dd4jOdxwXzqfBgFPjlOo8WLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CYXPR11MB8712.namprd11.prod.outlook.com (2603:10b6:930:df::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.13; Wed, 15 Oct 2025 17:01:21 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 17:01:21 +0000
Message-ID: <3d7b6b2c-7b48-4bd5-87bf-39f4c72fa741@intel.com>
Date: Thu, 16 Oct 2025 01:01:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/19] sched/fair: Introduce a static key to enable cache
 aware only for multi LLCs
To: Shrikanth Hegde <sshegde@linux.ibm.com>
CC: Ingo Molnar <mingo@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Valentin
 Schneider" <vschneid@redhat.com>, Madadi Vineeth Reddy
	<vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>, Jianyong Wu
	<jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>, Tingyin Duan
	<tingyin.duan@gmail.com>, Vern Hao <vernhao@tencent.com>, Len Brown
	<len.brown@intel.com>, Aubrey Li <aubrey.li@intel.com>, Zhao Liu
	<zhao1.liu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, Adam Li
	<adamli@os.amperecomputing.com>, Tim Chen <tim.c.chen@intel.com>,
	<linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Tim
 Chen" <tim.c.chen@linux.intel.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <ef136e6a6f5a2ef840b1f9571c47411f04705b6a.1760206683.git.tim.c.chen@linux.intel.com>
 <20251015110450.GO3289052@noisy.programming.kicks-ass.net>
 <15b871f2-49b8-4b62-926d-31f93ad49f51@intel.com>
 <6007f50a-7abd-46c8-8934-f1b09df57479@linux.ibm.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <6007f50a-7abd-46c8-8934-f1b09df57479@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0073.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::13) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CYXPR11MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: a87b1b5f-428c-4963-b29a-08de0c0c7714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tnh3akhsSmcveXRNeWlHMVBEbjNMK2UwUFZ6cDkxLzVZOW82MWVGemlCdWhX?=
 =?utf-8?B?TXBFT053SldMc3YwNkhacHczS0xHYTlINy9YbStJSWxRWnViM0tSU20rNzEy?=
 =?utf-8?B?QUdPOFpNSzlNV1dFVEltWEtVMlB2SUpGTnhsZEVmRTRGaFV4WnBwdnZnZkl3?=
 =?utf-8?B?elU4d0NKbHVsWWd4STI1NDFid3RGQUl0aCtHazRNZHczLzBsNEVJVmhxanJZ?=
 =?utf-8?B?MmgyN1BzV1dwNWZLeUVyNkJlTGhRLzdIa0VVbUVxNGxHeFd2MnpKSjhJRTdN?=
 =?utf-8?B?a2txSFEwODhta1AzZ0kvSXFTdnNQQy9EdHc3dVYzMDhxRUEwVUQrdi9SeUN4?=
 =?utf-8?B?Umg3VElERWdhMUg1R2s3cDZKSlZTNkozY09ya0pEMWRQZ3NKNi9VN21JbGtN?=
 =?utf-8?B?eXRpdmhDQzg4UGJsYStrd1J5S0N5SGJJVUdzc1hOeVg0THUyekpnWDRoMXNm?=
 =?utf-8?B?b1U1YzJVRkk2ejdUeDAzaW1DY1NYR2ZmaVRtOUhBKzhFSjYxYktUU2Rmdy9n?=
 =?utf-8?B?OHZrQTlyRTlCUW4xWDRUTGtmOWFFcCtIWVN6aDdwTHM0ZnJLaVk0bVg5a0Qx?=
 =?utf-8?B?THo2eDQ2Sy9qbnlLUWJQTk5ndE1IcmxJVzBGckJJVW00b01aSWh3ZVhIQlU3?=
 =?utf-8?B?ZFpES1ZuYmIyV1VEbzRIZlcrVUJIa1gyVFNtR1ErVlZoOHkvZXBDNkI1L3RQ?=
 =?utf-8?B?TTgwQjNqMzJEOTBEdWNBc3o2ZFJXMVY1SjVJa3BRYk00YVJGNGJISEYvUUFB?=
 =?utf-8?B?a0tNMW5PT3RJbUM2UU5jcHJCZ1FScjJsaUp0QmhDaFVhWFVML2RZWGU5M3lt?=
 =?utf-8?B?dGRRK3lCTHNsVUJsS0F2cGFDdTk4cDl6YVNIMWIwMmlGVWFTU2JwNW1CcXJN?=
 =?utf-8?B?ZzU5Mks5UHRtSi9CUWlWemxyNVQzQjJZU0xqZkxremtJYlRmbTBmYS9tcEYy?=
 =?utf-8?B?TzFyU21aU011MzlBaUh5QUJsODVuVWJnSjV3UmVacE0yRkFVVGh6MXdIK3Jk?=
 =?utf-8?B?VHZIeVpKL0d1VUNTWm1uT3FkTGkxZkRmcC93TW10cThramsxbUFlcHUyOTlk?=
 =?utf-8?B?TnRtOXBiMG03ODRGOHJoU0tsQ2E5Y0lmWTZYWWNNUTJTRGhlQUFGUm94SlJY?=
 =?utf-8?B?U0NaQVRTeTFMZzlQb3htWXlFUUFqWi9FaHpaQWhxUTJTSzZwVFJIUnZLb05K?=
 =?utf-8?B?MmpJQ0lxMTVKKzNMd05GbldWS0F4WjRlRHY0dmFHTFlGR0YwSW1xeVczUGFR?=
 =?utf-8?B?Rm03cGlIenhiVjBzaU9XUm5CZ0NWZ2Z6SEhFNUprb2I0UFZKVkpXazc5TEg3?=
 =?utf-8?B?aGRBbXFjem9UR2d3T1Vzb3p0THZlT3VxODROT3FyZlJvTjRUeDV2ekFwMTZS?=
 =?utf-8?B?U2RWdG5uZGpPb1hiZ2EzOEpJaGtyeDc3ay95T01WdFlpaDBDRm9QVjZQdWVU?=
 =?utf-8?B?RkpzTVlKVzRWSHkrZ3psMnEvYUJHY3k4TVZDYkx0UCsxUzhSOE1JakwwaXpG?=
 =?utf-8?B?NUlFWFNkc3FKRGlFRnZzUUN3aFNTZ1dMMmh5NUxkV2dEek9neE5yL1UvZWtM?=
 =?utf-8?B?bXlsYS9JQkcvR2d5YStRVGFuUWZMVThmQlRRK2U3b0RjKzVseEZaWUlLMnNW?=
 =?utf-8?B?NHpUbWR0blNQOXRaN21pTkhhczUvTnFUSXlpeDJVZzZvc1c3Sk9YcnZQcWxB?=
 =?utf-8?B?WjBaQ0MzUXo1cmJyeStnMG5oS1NyMFpkOXN1NjI5RXg3TUpyYTJpN1U0Q013?=
 =?utf-8?B?S2hXRkNJWjViNHVDZ2FaWEErb1h2MnBkd2V2cXFWU0U1eXhaZndvSzVrNXA1?=
 =?utf-8?B?bVlnL2l3RzRCcWNDZjlnMVVQd2U3Um9mdlY0bGVhNzB4VlhKVUZGTWh2SzdK?=
 =?utf-8?B?ODM5UlVCbndwNmNleFhSc1puYk5rWFpIVmRRVjVydHNYeXFYQW9uQVRLM3NI?=
 =?utf-8?Q?VNm9vRBJXlywi/1R1AqcyMOUcW2p3vbs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejdkTHB3d3QrbXJyd1hOaTYwV1NMc3NqTjFUbUFYU3k0SURlM281RFFsU0pq?=
 =?utf-8?B?d0lNN0IzTTNlTXFqUUs1RHBkMmZGZUQxMXFONmtTTFZmWExXNndLSERhMndQ?=
 =?utf-8?B?Ym9CRGJkN1dMSWVqdjVjSXNEZTN2c2xiU21QTlZzeE1nbHNBalptd3ZVNit2?=
 =?utf-8?B?ZUk4ZllRWnh4Rll2UnhOemE1ZndybWV5QnllZzdnb2RvWkdXaHFGK2swSlJJ?=
 =?utf-8?B?NXM0dUhjOVRvcVJFUksxaEJnYzFJbXY2ekJ5ZlZPZHN3RUFnTEhQcm94TXVz?=
 =?utf-8?B?Z2QyVm8ybWJoNDJ3UTVCMXlMaVByNjhqVEppMFcxL2MyQk50QXFzMC9jbjUv?=
 =?utf-8?B?WEtubFZtTk5PMy9NdW9NelU3OTNHVHpCN1BtdlRDYkFtYy81NVc5S09oaU5K?=
 =?utf-8?B?dmQ3Mjlhbm9xM3k3R09BQUFsZFZBU1l0c2VqbFFBc2UvckNFVndZcENiRmtl?=
 =?utf-8?B?MkJ4OTJrOUZ6VFR2dUw5bjFqdWtEWXlLWTRaN2ZNa2lNdE5mSEk1ZkJoTFlu?=
 =?utf-8?B?ZkhQSXdSUkpDVnBqTDNaNFdLc1VWT3g1T3NuS3J6bW56N1VqdlZNaFVUT2xM?=
 =?utf-8?B?NjJZeE5jNlN4eGJzUllCWWtQY0hhWmV2M1Y2bHk2WlZ0dWZmUDlZQlJWUmFr?=
 =?utf-8?B?ZHJDci9xc2JENUVlTFREeEk0Sm9XUmlpd0xHYkVoSHY2cmZEb1lwQktnd1JU?=
 =?utf-8?B?d3hYdXhOYk9IZ1poREtJd2pnTTVtd2xJME1KcDVWVEdNaFlDRXVCbksrYnNB?=
 =?utf-8?B?NFgzL3E4RTl6MlhBN2NpaXJIYjhoeTBxRmkrdThOems5VnFxaGtTcDh5YXBD?=
 =?utf-8?B?d04rWUIrNXNoMXdvN1J3TUZPd2tCTURnS0xKUm1CMlFiaVVPQ1pXdnZ4dzMr?=
 =?utf-8?B?SU9WcUNGK21RbHhGQkQwWklQYTFsQ0FpaFZOblR3WTV1T2VzdDdtMmdtVXVh?=
 =?utf-8?B?SXZqZWYySC8vOWJ6UmFvM3JTQ0tPZ00zVWk0WnNIdFR0aW5TSG51TGkrZXZp?=
 =?utf-8?B?Q2lYOXdQVWNWT0p4eXRwUGNqM29jMGdSZEQ4QTcxZ2hZaFZ6VTVmZTlEQmlt?=
 =?utf-8?B?ODZDVW51SUlBcUVJSkJyWmU1Y0cxcisvNUpoZ3o3YjE4M1FTbEs4Uk82UzlB?=
 =?utf-8?B?TGF0OTZtOE10RVNadEpKMEp3Q2xvZ2VtSnVtYXMvQ3gwRjNrS1lxaGJBVHFs?=
 =?utf-8?B?ZE40NUJRclFwTUhTWkpxSFZxNlJiTXNjQlREVkJaQ0N6VmRhRXhBdFFQZWN5?=
 =?utf-8?B?UkpDemNJSk1remhnTHhoZ1hQWXA3K1pYN3Z1YmU0bjFaRXhveVNGK3dOS0tF?=
 =?utf-8?B?Mk9VWkNadTIvYmx4WDhhQWFJV0c0NEw0RFYrNE9RTWxENGMyQU4vU0ZBODdn?=
 =?utf-8?B?aEVpV0JQckVPQU02UXV5eERYa0RvZ1BFWVMxclpTMVl1bklnS05kalRodGJm?=
 =?utf-8?B?bXJlWGd0UXdjMm5uVzZJdEJxbFVWRTYrMlo4bkR3bzJNM0JESGJITStzanNY?=
 =?utf-8?B?ZW0xRTNKRldObTl6WW5pM0RBUm1kdjdLQ25aVUt0VDRScGRZTGVuUVV3aTBq?=
 =?utf-8?B?QjJpejRLWENVV0t5MHZjc2RGdWY2cTEwRm1kOFhORHhvZTJYa3lOcDZnUU1v?=
 =?utf-8?B?QVBSRlB4QS9YV1ZieWVDQ1pkZWdaRU15U25hWXlWS1UxVnRZVlBSckJNckJa?=
 =?utf-8?B?blgvZGlySmNqUXV6UzJTV1dRbTJQSThqTVJjbjRzK1Rubi9rNDAvU2NKQkpx?=
 =?utf-8?B?b0syNVQrYmpZc1dxMWZaaEQ1U29IUDY0RjA4aTk4VVJvRk1XSFV5d2hzSWl4?=
 =?utf-8?B?RWRudUQwSFJmR2x5eTRWMmVtU1lFWWpDdkVrM3dBakxWcWtBblRwZnQ3ODFJ?=
 =?utf-8?B?NHJvWTdjckwyOVkwaWVaejB6QzEwQWp4ZXdRUWJScGNQOStIbnhLbERvMjRU?=
 =?utf-8?B?YjRHcG5JZHhYYndjMzZBc2lGRnR5NDNSaEs5VHdiS1Y3NHQrQlBZV094b3Ev?=
 =?utf-8?B?cExDYUUwQW4ya2lWRU0yOUhERnZta2F4QmxOUHpiR29iZFhWd3JSbENSYm9V?=
 =?utf-8?B?d3FhQnFWYkJRNmRjcjEzT2hybUJaNzgwMUZzWk9lcmhQUFZ6bUhiZnpZVjgv?=
 =?utf-8?Q?eCYRJ1Kp8FSbC3OjdaH7gMXJo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a87b1b5f-428c-4963-b29a-08de0c0c7714
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 17:01:21.3222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSo+yYrQ/WqRcMetjVNx3soWfqXB1ACd/1sa2r3cbCr5u/FkZdY7zM6wnwMYh6lABYmx/W3RDpAvnl0MNnwp7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8712
X-OriginatorOrg: intel.com

On 10/16/2025 12:36 AM, Shrikanth Hegde wrote:
> 
> 
> On 10/15/25 9:55 PM, Chen, Yu C wrote:
>> On 10/15/2025 7:04 PM, Peter Zijlstra wrote:
>>> On Sat, Oct 11, 2025 at 11:24:41AM -0700, Tim Chen wrote:
>>>> From: Chen Yu <yu.c.chen@intel.com>
>>>>
>>>> Enable cache-aware load balancing only if at least 1 NUMA node has
>>>> more than one LLC.
>>>>
>>>> Suggested-by: Libo Chen <libo.chen@oracle.com>
>>>> Suggested-by: Adam Li <adamli@os.amperecomputing.com>
>>>> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>>>> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
>>>> ---
>>>>   kernel/sched/fair.c     | 15 ++++++++++++---
>>>>   kernel/sched/sched.h    |  1 +
>>>>   kernel/sched/topology.c | 14 ++++++++++++--
>>>>   3 files changed, 25 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index cd080468ddc9..3d643449c48c 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -1208,6 +1208,14 @@ static s64 update_se(struct rq *rq, struct 
>>>> sched_entity *se)
>>>>   __read_mostly unsigned int llc_overload_pct       = 50;
>>>>   __read_mostly unsigned int llc_imb_pct            = 20;
>>>> +DEFINE_STATIC_KEY_FALSE(sched_cache_allowed);
>>>> +
>>>> +static inline bool sched_cache_enabled(void)
>>>> +{
>>>> +    return sched_feat(SCHED_CACHE) &&
>>>> +        static_branch_likely(&sched_cache_allowed);
>>>> +}
>>>
>>> Urgh; do we really need _2_ static keys stacked for this? I'm thinking
>>> one should be well enough.
>>
>> SCHED_CACHE allows user space to turn on/off the feature at runtime,
>> while sched_cache_allow is a hardware capability. This capability is
> 
> isn't it possible use only static_branch_likely(&sched_cache_allowed) at 
> runtime?
> 
> Enable that key only if FEAT is set. Disable when unset.
> That way you could use only one static branch at runtime.
> 

Oh, do you mean only using sched_cache_allowed in sched_cache_enabled()?
I misunderstood that Peter suggested introducing only one key. I did
not quite catch up,  do you mean, we should monitor the switch of FEAT
and modify sched_cache_allowed when needed, and the OS only queries
the sched_cache_allowed  at runtime? I'll take a deeper look tomorrow.

Oh, do you mean only using sched_cache_allowed in sched_cache_enabled()?
I misunderstood that Peter suggested introducing only one key. But I didn't
quite catch up - do you mean we should monitor the switch of FEAT, modify
sched_cache_allowed when needed, and that the OS only queries 
sched_cache_allowed
at runtime?

> Also, I am not sure if the FEATURE should be true by default. I know it 
> maybe unused but
> IMO it should be true by default only when its proven there are no 
> regression.

Yes we tried very hard to not bring regressions during the past.

> One should be aware of their topology to enable it.
>>   disabled if there are no multiple LLCs within one node. I’m not sure
>> if using one key could support the above two scenarios.
>> It is possible to have multiple NUMA nodes. One node may have multiple 
>> LLC while other
> one may have only 1 LLC. what happens in that case?
> 

In this case, it will be enabled, and the cache-aware load balancing
will occur on that node with multiple LLCs. (Only a domain with
SD_SHARE_LLC set, and whose parent domain does not have SD_SHARE_LLC
set, will initiate the cache-aware load balancing.)


thanks,
Chenyu

> I am yet to go through the series(hopefully this week). Maybe its 
> handled already.

