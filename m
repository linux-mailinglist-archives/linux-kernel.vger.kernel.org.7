Return-Path: <linux-kernel+bounces-721101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DF2AFC4BB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2833B3D62
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E712229B789;
	Tue,  8 Jul 2025 07:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gYdAAPeX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541F729B224
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 07:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961282; cv=fail; b=DDuV2BRvQljaKW0waWflumO7SXzXPidhJ5knQGCRo8jr5o/dNVB7zSU0ykr6hHkRGTfaa3G6nwnuR74LHHz3N0jO2FfM1cjzxaNuB1w4VJwr7ebPWxniL9DW4O/wTgO9abjmj4C8Q3Guc9o9KHXOxaZJdOcwlLgkMWC6+qS/tLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961282; c=relaxed/simple;
	bh=KGPqoquFZ2chs21uZdlGD6teZ557LnUF9l31nGPVdPY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PAjQzLek+6frYjxyHnH9T3MUpVCWb/YdMsL5DANo5XzjS+EA0Ys6IeUiZHGz8KtUhL0oNw4/ajBQAH7hfn+pFTvNmsxBUsBz3ayCLvVJHcCF472pjvnYHFC4oQ5kC6rk1m7Q4abKCrH3z6YeuNY3+CkzQe6mq4Z5KylRCNkUDG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gYdAAPeX; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751961280; x=1783497280;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KGPqoquFZ2chs21uZdlGD6teZ557LnUF9l31nGPVdPY=;
  b=gYdAAPeXkR/f3Rkp3HNyJfCrerm5OxkIIi7Q6NbV8fWF94oMu8SMMio6
   5fIzhLdh7/wpzrCZr23uyr1f/IMHVTAqoX1v0VXwqMnLA5BVWjX4iOzHq
   xVvYnWUTV3TM7gnRkoJEgAeM1MyiBBYubb9N4Yy7Dku2HA/dm54Jdnop2
   ehVW5AJAzeulivAfDkzYAzu4r5ogYe1sUxgXfByXUNtI5ngZRNzRaqiIT
   WxDNt9vXyXQuEO+eDiotSjkbCdpQYe/uKV70UTJNwXCLMrYQxz8D3AoSQ
   x1yn5smJb4jpGncyKLys2xw/Cy9y9aHm2DFp2LHdeEmHcGppWMflr61+0
   A==;
X-CSE-ConnectionGUID: Z4y1mccORJOZYo0ZijXlAA==
X-CSE-MsgGUID: anFHVfGxRFK8xm8P9SItVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="71771695"
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="71771695"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 00:54:39 -0700
X-CSE-ConnectionGUID: 2wh19RTNQLqgU9G7u/9lQQ==
X-CSE-MsgGUID: Q8iDUp+NRJqjU55F0q3b5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="155167974"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 00:54:40 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 00:54:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 00:54:38 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.41)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 00:54:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsV3BlZwloi9PRAdsAvQzHoTMZWoT3mrYEuOZJIflfVRyT7VsbQ5mAV17z4cQrgUdLFtZAV6aPtbk4V3k7YpEBvXVd5XN8ticfi4EAQwIL/+kH3FCNAuMYsBa7W4PWjUfOSAHy6WQLY+xUpgBmtEfzByPwwsU+Mo5dyASoTO89vxLxp8+1xUpCMejX/7QDiwO3l2ZJV5U9xZ+FrjCmaURk5vFGL9hYvUOUPxpJMDPS48p0zgJzjBg+Z6IJfaDLM1Xpm/YuLECFeHloXrI1kv2q5CesgvNocfVbJLRMuPhGkFVK6pJY1B5dktcXzgRZ1ckKBcqWkt+ZAjN+gONQE1PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFHJGP2iR1BucurfoBfhZ/RvjMiiPXGaAPHCd+z9EXk=;
 b=FhynmkG+VS/PFHr1dCaS07GwJ/jjxfhXRv5SxI7OdjjKVlWl2db+wUoqsF/oyK/ImZ6iz5HUfLQY8lUjD0QGVPZ+A4VcSZkc7PItuHilqhavOiWUCYHIej89kfQHLyQB3fOA7hn/w0uUK6A1OzfT7I3awV95SDbGWcXR2cxBwpdDJESkX1A1RqDc2nkt8vKAV4RuxxELI031bFSS1DmWjjnnQvUiBO9TQ6+bb8WNHyabwBACZNY8Ki73J6MSinV7uAGdxBYL2xX0q85V977ndFmkjuL8eOOq8bCvcOS5WO50PmaZs08IKNU9sO68EuwlPE01ICbWvIIv34GvSMqUxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH7PR11MB7003.namprd11.prod.outlook.com (2603:10b6:510:20a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 07:54:31 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.8857.026; Tue, 8 Jul 2025
 07:54:31 +0000
Message-ID: <4942856d-ad2f-4922-aad9-20a902dae41b@intel.com>
Date: Tue, 8 Jul 2025 15:54:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC patch v3 02/20] sched: Several fixes for cache aware
 scheduling
To: Libo Chen <libo.chen@oracle.com>
CC: Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, Tim Chen <tim.c.chen@intel.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Abel Wu <wuyun.abel@bytedance.com>, "Madadi
 Vineeth Reddy" <vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>,
	"Len Brown" <len.brown@intel.com>, <linux-kernel@vger.kernel.org>, Tim Chen
	<tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Peter Zijlstra <peterz@infradead.org>, "Gautham R .
 Shenoy" <gautham.shenoy@amd.com>
References: <cover.1750268218.git.tim.c.chen@linux.intel.com>
 <d73418022de76dab9f60c0c5432d783b3b2833dc.1750268218.git.tim.c.chen@linux.intel.com>
 <60a01353-c1f4-41ea-99b7-a300aee35bb1@oracle.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <60a01353-c1f4-41ea-99b7-a300aee35bb1@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:3:18::20) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH7PR11MB7003:EE_
X-MS-Office365-Filtering-Correlation-Id: f47b4884-eb19-4764-22b8-08ddbdf4abd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWIyejVmdlpORU53K1lnRlo0RWlyek14Rkwrd3lZRk9neFpyMUVWL0U0dEcy?=
 =?utf-8?B?dXVaRWJDR0JJZ0tkUGd5bHBULzBmKzVmUEtTWmRnWnlSZE45cUNIMFR0ZXNX?=
 =?utf-8?B?Tlg0NnAybTF5emttbDQ0dDJZYXlkQ2JRYkNqUnVqTENxMjhNVkN4bDdUTlUx?=
 =?utf-8?B?WDhSd0N6bmpRUjdxcnVVWFRnN1grODhRenRLWkNpVHZDanVJSlBqbmNuV2d3?=
 =?utf-8?B?WHNlaFJYTWMwb2xaWHRCa1lWdWFPTTFCbU1YMjBySTVNNVpqRTRUUGt1WmYx?=
 =?utf-8?B?Mk15S29aN1NhelBIa2c3RnpFUVdVQTVOSGg0NXhrRTJYeW9HSUdLRzFxSDhm?=
 =?utf-8?B?YmkvcW9lR1dPWGZWZ1haUXFEZGo4c25FaHZOSEVpZHNpUkRlaUpyN3NIWGR2?=
 =?utf-8?B?TTdIRE9GK3pTY0tNeWFjNXBoZ0J4am5TaFBXbEVQKy9RTVRMNjhQUHA0Zzk5?=
 =?utf-8?B?ZGVUVyt2UnJXbXRNaFp5aldsY3N1WkxqL0lLNmwrZHUyNkZkMXhCdnFIcFhI?=
 =?utf-8?B?NDRZZUJpTVNKL21KTUFBTG05dTIwdVVZelJnK1VmNm55SUZjTmoweVh2OXNt?=
 =?utf-8?B?U1hyQ3k0WHdseXR2WmY0LzlJSW1tWGpQNndndllCRlpCVmh3UnIwTjQ3VlFM?=
 =?utf-8?B?aXZ3SGY5blpKTGNkaHJSekIzL0VIcWFoTE9xMVNLazM4V0hEVXpTSmVoU0xU?=
 =?utf-8?B?ZG93MnhacTNOaXVKQUcwNDlHSkx1TmN6MnltbURCMzdJRDlJZDN0YUtpMjRV?=
 =?utf-8?B?a2FjS2hmcjY1blBDbXM3V2Vna1c2L3NJZlE4WjZCU3FmMDYzNmdscHdXMmo1?=
 =?utf-8?B?OEtUVEZXNU8wZS9OREJwQnMxbzM1SWNNWWtNTHdJZjRHZlpJM0Z3UVcrbTEy?=
 =?utf-8?B?ZnZxOUpDWHFZdGZsWG1HUVFJbzY0dHRISTlRS3VuU2tyL0EyWEx4Tk0xM21z?=
 =?utf-8?B?SmtyeDJXVE9iUWVmSjF4eW9iZDZ6RlVhQ01tbm5yQ3FIOTZSQjZKRks2Z3lu?=
 =?utf-8?B?TzVEcGp3RHBVb1VlZnhPUSsyVFZGZERaQjlQVXpZSHhLZTVmNEdpTEgwVFdo?=
 =?utf-8?B?Z05mT2ttdTdUcS9QQ0JSc2lSLytkMURCMFVVNHUzUXNEOTNaU1NnUG1qYXY1?=
 =?utf-8?B?SXh1V1BwQU1tSjJXMzkzd3RTMW0reU1nZUlHWXcyTm5lK01mTmNTODBKdWlM?=
 =?utf-8?B?TWJtR09Hb2xNbkY4Z3NkVVNTaG5mNWNMVDI2U3Z2UFQxUzFMTTBGZUtPdjl4?=
 =?utf-8?B?N0xlVzFUd2U4VmtoL3FhanRCd3p3WHpRNDBpdU1KTVQyY2l3bDhYb3RWK3pK?=
 =?utf-8?B?STFTRWtYNDhBSG1kZ09vbU1HNDFJYUhTblZlMWtmVmUrSmJwSmVzSXpPRlNi?=
 =?utf-8?B?ek16K1JwVFQrYzZTK0YvWGlWMDkyREtBclh5aS9qVzBjS1BWaHZHYkkvNzlC?=
 =?utf-8?B?dnhHamtwMmJmK3h6ZnEranZDbytuVEF0WmlkMDVzc0RCR0ZFazIwMXlJUHZN?=
 =?utf-8?B?dnFVZWQ0dUxKekRNOTFyQStCb1l6YUlDdmhZZkgvMEdiQXd2MkRwK3JURVAy?=
 =?utf-8?B?ZjI1N2xwWTdsdEsxdEw1UGc4YklkVVNaNjY2QTNsVHRBZDNFbzFrMDJ3eHFj?=
 =?utf-8?B?V0haVzJtZytEVk5DaDNDMFV3WWVIVlRFTVExdEZidHZRYUE1WThQUTlyNzJD?=
 =?utf-8?B?MTQ0S3lXeGVMM2V3WEVpSExnUEJYN1FDWmpjY0lBaWNkbHBtT2tNVmxLOFdy?=
 =?utf-8?B?elc5dUp3N1hHUnQrUzVRYUNQcmVCaXo0bHMyYjBMOUVsTWdBNjFGNjdBUEJy?=
 =?utf-8?B?cmYxcm1NYldXZmN5WjBnZVhScEtuNW1zNHFJS0ZjaHc3ZDRYYSt6ckxFSnRT?=
 =?utf-8?B?VU5WcTNTYWJCYm1VN2sxNmd3dExVb2V6blFtblhXMWh1RDdjNmNyVEo5a0lx?=
 =?utf-8?Q?zrz4PDwQ//c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk9ORXJWOVNUa0N4QXE4VXNYYmtDaHA3Z0xNU1RUUFhUZ2FKbDJVU1dLbzNN?=
 =?utf-8?B?ckRWZlZYZjFHU0VKakswTzNFRmh5MVlheUtQN2ZjRmM2ZDhOL0hGLzFaSnVS?=
 =?utf-8?B?cHpWZEg3eHlMTkQxWjNJT0lZUTNGK2laVlUrUzZwL3JHL1l4SjhCMHJudWhm?=
 =?utf-8?B?eVJqTDNpbjd4aXBVMnluRVQrc3AreDJLazh2UU1kVTgvYnBBdkFBN21YdzM2?=
 =?utf-8?B?S0p3dVVsWFFuYzhrbCtIWVFQWGRTZy9rclJsQmRVaDA0aG9IeVY2a3gyYlVY?=
 =?utf-8?B?YjBPZ0hxcWhYRDlwNzY2NEN1azZGS0V3Zlk4RFd5VkhkSW52cGVlck15WkJ3?=
 =?utf-8?B?OUtwTnJnV3A4QnRFb2Jyc0c1Z2wvMHpGMTFRZ2l2M2J1OTBWVGQ5YVRSVFZX?=
 =?utf-8?B?S250VWExWCs3M1A0a0FwK2FSTFlwYi9PSnJBWmdrMkxtR0FoRkFUQmFDcyto?=
 =?utf-8?B?Y1FqWTlQUnk3clh6ZytDZWQyNlRzeGhHYkIxWlBNU212OXlsK2t6cXVlNzdI?=
 =?utf-8?B?ci9USnRzcUc0U3dCVzhpVUVSZTVuOFlubXhlUjRJWTBmVllJS1BvQlRkM2JD?=
 =?utf-8?B?NDdCQ2FqdXI5R2c4UUxCckN4U0NZYmUzdFp2TE5EKy9Dd0YyYklYNE9MNSty?=
 =?utf-8?B?aHZFOElleDFLSGN5YjhtNE1CZWNDemZVU1grN0pxRUtJS0RqcTVPMldEQWVH?=
 =?utf-8?B?OGJXUVA2NXIya3BJdm42SGlnYUFRMGRIZnczeFFVTWg4OWxvK0xtUHUzcWtM?=
 =?utf-8?B?V1Z5T3FMY2hib3VtejJIMHl2clFNS0l0R3YvR09uemd6bHFtRDJKbU5OZHRa?=
 =?utf-8?B?K09LWHlRdDhtSXhheklGbUtFa29kTUJDd3k4S1oyMEJaVDRPOTZJR2lMWElK?=
 =?utf-8?B?WjU3OGFoMm5YU0NiOUxYTXJqbXpBa1BjNEhNS2dhQTBYNklmcEtTRkh4THZ4?=
 =?utf-8?B?SnZtT3dWb2s4Q0pwUUZDSTd0L3M4OVMrRWxOVlZGeVBzdHpadHVlalVncWFv?=
 =?utf-8?B?NnZUWW9mNVJacXc0ZWNRVXorTDd4bVFBdVJzT2RkdDIxeHVCSFhIZWJ6cE9s?=
 =?utf-8?B?N0Z0NXRlYkZqUTZ6WWJCVUNvc0hNZ1EyUzBqNE5wbDJ2QlRBY0h4djhNclI2?=
 =?utf-8?B?cXVPTEJObUpTVlk4L2pETEJjc2N4OEd0UWJ6UjhLTExPcE4rYzVXRERHTVVO?=
 =?utf-8?B?YXl3Ty91dktxeERPaDR2NTIya1BSazVsUVJtamt1elZXemdqVkNVRjVYaHZ2?=
 =?utf-8?B?MWhCeUJ5dHh1WXZhTU5CeDlTV3JBdFM0a05NeDNCQkxoUGp4bUtvY1lCd3FP?=
 =?utf-8?B?VmRFWXQ5KzZQSldld2FreGNVbi9qV0pITjc2cGNIbFhpbkdzT3V0ekkrdENH?=
 =?utf-8?B?QjU0VCtNQmdyR0FXSnB0cjJPL2lyREg1T1BMZGFQdHFJTVlqUHUwaEYzUkRl?=
 =?utf-8?B?eE5ZNE5xZFZ0bWsvNEJpN0sxWmhNbWpraExqcGk5OFZYZ0loVTY5RUkyK3lN?=
 =?utf-8?B?OUFrc2NldUh1Y2xyVnRWSDUwK1ViL3NOQU9CNy9kUXRhUXJKNU1LL1BNdVd3?=
 =?utf-8?B?by92eGMxVGFtQ0VNaEwyK3FDbENzd3h3TTREUGF1M08xbEkyNmF6YVhUQUFG?=
 =?utf-8?B?Y3ZoZlBleXAyWmtWM0tiRCsxeHU0UTF5TkhwK0hWRzZGUW9BQ1lHWEttWjNW?=
 =?utf-8?B?TWJGSzJqVi9OUmlML2RmUGdobTVnZ1hFWEJWS3BVTUpnUjZHc09tbXg1a1dV?=
 =?utf-8?B?Sy9NZWpHQnZaQkNRcVNvLzlLYjlCekNKQ1hTZjNEWFcwbWN2QWlCcUpHWGdk?=
 =?utf-8?B?QThpaUZVaTE0bnB3azN5VWZ6bkZnV1AwN2psZTArL2pmbnVSWTl5RzdhcnF4?=
 =?utf-8?B?N3NjelUxNVE3UTc3aHd4REtUTU5vY0F6ZnloUVROTCsxNGMzaHIwZzBHS0NB?=
 =?utf-8?B?QzZYdHllTDh1Yng5ZFhzYkZKTCtKU1BGRHhmRXVLMHBNL0l5Nm4zeG55aFly?=
 =?utf-8?B?NTBsK05BZ3N3Vk8wajl3eGxoL0pJTXExNUdnUTJSc1RlVC9oYk53TWowdUc3?=
 =?utf-8?B?SmpJM1gycjR0ekFUcGpYNi8ySEJwSkY1bXFNTHRBbFVncnVONTFsRms1Ukh3?=
 =?utf-8?Q?5UltzQ/tLOHhBtTXMiRFh0GM+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f47b4884-eb19-4764-22b8-08ddbdf4abd8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 07:54:31.1624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guPBiGmDRo/n9/Kr9qMJz/taLbwFPPwGN4PTdNsTv6wJDSjPYm6OFwNb0BBR3aCy7wRBWJTaNiUrxdzpLbd7YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7003
X-OriginatorOrg: intel.com

On 7/8/2025 9:15 AM, Libo Chen wrote:
> Hi Chenyu
> 
> On 6/18/25 11:27, Tim Chen wrote:
>> From: Chen Yu <yu.c.chen@intel.com>
>>
>> 1. Fix compile error on percpu allocation.
>> 2. Enqueue to the target CPU rather than the current CPU.
>> 3. NULL LLC sched domain check(Libo Chen).
> 
> Can I suggest we completely disable cache-aware scheduling
> for systems without any LLC in the next version? No more added
> fields, function code for them. This info should be easily
> determinable during bootup while building up the topology,
> and cannot be modified during runtime. Sometimes it's not
> possible for distros to disable it in kconfig just for one
> particular CPU, and SCHED_CACHE_LB isn't enough for removing
> the added fields and users can turn it back on anyway.
> 

Good point, my understanding is that we should introduce
a static key similar to sched_smt_present to get rid of the
cache-aware scheduling code path if either LLC is not present
or there is only 1 LLC within the Node.

Thanks,
Chenyu

> Thanks,
> Libo
> 
> 


