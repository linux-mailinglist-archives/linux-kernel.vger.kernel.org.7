Return-Path: <linux-kernel+bounces-853793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A81CBDC9C2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 357984E9F81
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B98E303A18;
	Wed, 15 Oct 2025 05:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gC3uJKkN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98F63009D5
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760506704; cv=fail; b=R950/WALYIu/WwMWwRC7PROkROJp6lFo05V0IcE/d9/dKpAX/P+WrHZr/gUx3b92fDc3+VGxsaTrfDeIyKo3HZ8Xw5jL85hFyLOfxyFAEjg2ii6wS6FqbohmBGY5jIeHwtHOH3Bso3hJXNsi8mUrZFiRyaSL8QlH/XhRGBbSlu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760506704; c=relaxed/simple;
	bh=/FKz/2pF/A5a0CMKxhrTLAGt+cbH/bM69oZ/uemFaBs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ccnzCNwrREd+uyofR7FoQ85ws3eqOx86goRGWMj1kpc3hVZmZf/BCelCl/SSMhjkZ9Mhi7AJGKfQlxMNb9XBg0eTncrOQVgvvENd+Lw24rEheUVI75O7I9Vn5ywXXnR2bedt9Djr+UR2/Dkgj8DX0yxTN4LVAXET5mWikQU7XPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gC3uJKkN; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760506703; x=1792042703;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/FKz/2pF/A5a0CMKxhrTLAGt+cbH/bM69oZ/uemFaBs=;
  b=gC3uJKkNfUqOGTCWJYR/dCWbWh6MxIOT9uabGU+6CyvGRQBawdncAdz0
   75LnDFcdqol718GTL9dqjnqXIqn9rdc4+SoXb2XeKyVnldBmV4YqiJp6N
   Y62VT6Bi6fy0+PXwQoSHNak4jWSryhI/PAj8Yrip7SZ5r+/Heka/gcJqq
   pYUCWU7xWsAKtaaUduhQvjx3Nm1yalpQ6176UeWdhnxLUz7HDq+b7Z2FS
   WTu3v4vuTsggH5g1vMhSKamsBn9gCO2RJ3ZbrYTvK3IctNHqBd8ja7ZOa
   7wa2UuaIlQkPvM/mfQ4nx1xyvrMVEIrSgaopoxP6NLitdixNKGvQV9YlE
   w==;
X-CSE-ConnectionGUID: upQzkCnMTOmwkOV/Ep/AXQ==
X-CSE-MsgGUID: ChNK382jSuGpqI64i+Qw/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62769300"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="62769300"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 22:38:22 -0700
X-CSE-ConnectionGUID: yiZDmnowQ/K7/zyWULQBiQ==
X-CSE-MsgGUID: meIQjBfBRH2U5T/Hd7n3fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="181633825"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 22:38:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 22:38:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 22:38:21 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.13) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 22:38:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBOU0gc7jYHkJHT7KAouB8bPksvqy8qdeH/iK26nk+h9gfhbygy5uUXdq8uxzH0eWUdeRJGeJWHjYGJdQ8sZy3phn0hTP2WCPhYOBS4cfX21oQ7ZBHPhPwRw+7sc0kbOLDb0RKyktmMYJ/LGHxkkHchLqJJX9SC859X4TygzGTx39YpG27chAIPA63TQxxxmZ1Aiyzp7CegSkOGIbOYuJ/cqDZXlqHaSIW8B5uifaa3n0GAqmyaaltyfz1z5QR+iadyA4yiHMYyOqO2mHyy2ydJuvxc2/IKI5ZcW2rczfO/6BzEF3mw/54bx5aOVcgxgjxh9drzCPfiIrcO3kaTprw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppLRmqgzRbAqNTgF/BPJz7e0oTsoDDKYrI+DKlxhkFY=;
 b=W4BatA4vHsaR8RZjDj3pJe2KgfUCyRzNKjnd0QMl+AUSXy1hN6IlEwg8s1Hg7r1Qj27U8IwIX4GY1WKgiYgZd6Pe+MiXVVuIIHAWdJ/VpNOYYf7pxeLtNyYbW1Gv/WGWsBlUoUCXTid1Yegyh1aRFZdUWv74qyUeC9LvtzAFrENkGKcwPUn5lZVaydAVS1qbbLm7lyUB3eJ17IlhzD6Ktnav5E/FI0wCSe9EdCMZOigVzLNby0mPXYJIY0l4unrYZUeFEK2asnJJitchXSpIYrjwSyhJBngcEfkpyHwcUEUnidI/QRC2K/S8NoTQGXlIp3VQ2O9rVw2KvfbdXlv1yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH7PR11MB6330.namprd11.prod.outlook.com (2603:10b6:510:1fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 05:38:19 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 05:38:18 +0000
Message-ID: <a08e9fe6-c3be-4818-bff0-7ed350b3438a@intel.com>
Date: Wed, 15 Oct 2025 13:38:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] Cache Aware Scheduling
To: Tim Chen <tim.c.chen@linux.intel.com>, Madadi Vineeth Reddy
	<vineethr@linux.ibm.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>, Vincent Guittot <vincent.guittot@linaro.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Hillf
 Danton" <hdanton@sina.com>, Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Jianyong Wu" <jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>,
	Tingyin Duan <tingyin.duan@gmail.com>, Vern Hao <vernhao@tencent.com>, Len
 Brown <len.brown@intel.com>, Aubrey Li <aubrey.li@intel.com>, Zhao Liu
	<zhao1.liu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, Libo Chen
	<libo.chen@oracle.com>, Adam Li <adamli@os.amperecomputing.com>, Tim Chen
	<tim.c.chen@intel.com>, <linux-kernel@vger.kernel.org>, Yangyu Chen
	<cyy@cyyself.name>, <haoxing990@gmail.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <a54c33fd-504d-4eb4-9b0e-ad4a3e2156ad@linux.ibm.com>
 <5b82842ff20995cd50b422dad844664089dcd0c7.camel@linux.intel.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <5b82842ff20995cd50b422dad844664089dcd0c7.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::14)
 To DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH7PR11MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f50b2ff-21a4-41ea-e0a9-08de0bad0b8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RCsveWtDNFZZa3RXYXA5ejhHSGJhSGwwa25Sck9ST3VZUHRqVXFpZWxsa0Iz?=
 =?utf-8?B?SFo1RnpIVW8vUnpGV2hxZFlxNzBaWTF5Rmc2akYva2hkeEEvVXgwWE5IR0wr?=
 =?utf-8?B?NW9VdFNGNmpqT0VrTVN6R0R4NVR0U2gzTnlJVVdQdytzVE9Jd1ZCYkUvK0Q0?=
 =?utf-8?B?UW9XTzVpQVdaWDdDN3IxUkQ3SHZNbVdVMXp0bERZMytiWHVBd1ZTYmNLaXRO?=
 =?utf-8?B?NUJrZFFYNGcwV0JwWnBRSGpSVGhqdTBZdW9Xd1JkeTd3ZnhYSExNVWlyU3lV?=
 =?utf-8?B?QUprVzhkbVA0WGJ6ckcvV3JuREJlVzJoM090SXppaml1S1ZjSXdvMUpPcEEz?=
 =?utf-8?B?bC9mVWZNMXl5VnB2VGNvbU1JUFgxQkEydDhsaTdGSHk5NUNrdWJVai9wd0ty?=
 =?utf-8?B?bk5ZOEQ0RElQSDU3aHZaeEQ3MWN6eTNQSWF6djJEV3pXdkZVeHdFSEpDOWlD?=
 =?utf-8?B?aHZWOE5xUXIrV1hUQW5PcGVvMUZ2MXNXU1kwOFQrQW5Sb2Q5V0FtcnBvUEtW?=
 =?utf-8?B?cVBXTkpmRUMzdTlTZGYvTWYyMTNpM2k1S2VRZ21qY2ZoN3pRSnZXVERpMzRJ?=
 =?utf-8?B?a1pyT2RsN1J4YVF5QStDME5paVNxR3gxL0xqdDY2TDJPck1KckJLT1BScWto?=
 =?utf-8?B?b3hFaWZHcC80WE5SYnBselozTlhUVXB2Y1BPTThxTFNkZUdsL281UVVNclY1?=
 =?utf-8?B?L0FWcFAvR0lJbTlSTitDWktZSEdYR1NKNms5OVR5ZWZmL2syNUVqOTdqY3RP?=
 =?utf-8?B?Wm5TTXBZYmFyUFlnZXVMVzdZSlBvVWdhYTNiZEVodWVIcWF0VXc0cjVHWGJP?=
 =?utf-8?B?T2ZqN1ZJUUtadG5lWWttV1FLaklLUXFPQXZMYWNhZnkwTmttRXpKT2xwbENa?=
 =?utf-8?B?ZkplQmF5ejBMM21paWlmbUppRlFPckx1MjNGUVZuZEZZaGRybG9UcVNtNzc2?=
 =?utf-8?B?M2NVckJyV3hDUGg0dSsrVWZ3bTNCdTd6YUNPREdYTkF2K0YxYUltZ0RNZDlS?=
 =?utf-8?B?MEZhdnZ2RHhSQUNMcHlFVlNscFQ0anN2WUlhcWcySDNibTlaMlJVNTRmRDNo?=
 =?utf-8?B?QUdtcVZiYnRmc0k3amFNZ2lXc3lsOFRrM2F0Q3Jjam1lOXR1Vk50M3BHRE1O?=
 =?utf-8?B?N2diNWtKTE5yU3NQZ3hkOHhYOUVqazhpSG1RcFhjdkdhYXpBcXFDeWI3RFIx?=
 =?utf-8?B?K1JzVllsN2Mvb0N6eG82WHFDOUR2bGRTdWI0MTFIa2drUXZxcXVGR0hqdkdL?=
 =?utf-8?B?SDRnejNBOGJCMmdPcHNUcW5hUzJENDJJcGkwM3BtaXJ3WmlxemMwWmNqVmpx?=
 =?utf-8?B?OVl0bXRyL0k5aldqcGJoclhieTBqV0Zyek1oRVZCL3dUYU5SV3FmMlpNVFZv?=
 =?utf-8?B?QWIzekNZL3hwMWozM0NLZ2I1VmNiV0ZQS0RJMzJyQTRsMWVnYTB4UzdsU0Nm?=
 =?utf-8?B?cERCaFIzYWtJYWdTME1oOWlPcEdFTElHNmllMDVhNzBLVjl6cDVNdFZyY1Bj?=
 =?utf-8?B?aDB2VVBJdFZ3NzFGRmFkU3Y5Vk1GRDkxWGVDK1M0YTltWUhSQmxqUTZtUjlC?=
 =?utf-8?B?WVZZdDA3cXByQkprV3hzUUt6azg3b2wwcmxzUVBXaDdyeTJhdVMyRllmUjM5?=
 =?utf-8?B?TUlYVGVxRVJJcDBuSTlQNWJJTkwvNmtzWExNNFpyNzFaOERLbnpuVHhCcXly?=
 =?utf-8?B?dkh5bkF0R1oxc3F0Wnp4b04wRE5mRjVVVnlrWXRwM000c2xTcHNBd3JpWGd4?=
 =?utf-8?B?aStBbmQ0aC81Mkw1N1doNEM3MkhNS3dyaE93aFBZZlFIeHpkNDNEdDB4cG9E?=
 =?utf-8?B?R0lKbFQ4Q251T0hRc2cvb3NacDhWYlZ0SU5YaVVWeGpRQy9oaWNUNEFxcTR3?=
 =?utf-8?B?b2I5WGxTa3ozZHN3NmxSK2J6Z0o2cVFiSG45RCtIbDZyeUJSSjdNaWpUTkg3?=
 =?utf-8?Q?jt0g4YBlPTnw7FQ785WfL6JJPllMmliq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1FQSHlrYk9nN2llVjFLMzZlTlhKUnRoZkhhOVBIM1FmMFQ0Z05pQzBvTE1q?=
 =?utf-8?B?WjFwZytOTjNrYXdaK2YwNERrS0czRDMxa005M1loMitQSkIvZzNSdFk2aVFr?=
 =?utf-8?B?T29mRStHTVJ6VkVrTlRvTUxuV1pyRnRSVktGbE1FUlh6dkhWemlqU3lENERH?=
 =?utf-8?B?c1NBeXpFTXZCSVhCUStxOEFTTWJHdVZZM2tlckR0RWpSTXhyZUdPNFNhRExI?=
 =?utf-8?B?WGFPYWNjSXdmK1Q2Q05WaWNMUzNCVkRkbW12L0RyaCtucjdmQlFCcGJqSXZ2?=
 =?utf-8?B?NTh3a0J2K1VqZjFwbFA4K005NVJzb0E3TWY5dHVQblVPQ1l4Q3E3YXpCTG5C?=
 =?utf-8?B?bk51b2EvTFJ6T2Roc2prMWNKS1RhZGliR1hqTjNsWkJUblB2VmxybjlIck5x?=
 =?utf-8?B?TXc5b2d6NmN0SWNrTUJlMEQxU251UHVIWVczMU15aTNvZDBNMUVlZDNzSUFY?=
 =?utf-8?B?QW1SNEtLK2hNTnJINTc0dk5qMHVTRzgxTHhDZFdrd0xVb2xraThVWktXMnpV?=
 =?utf-8?B?Zkh4YlA3ZThRK1RLcFQ5WjdHUFUxcHRQM0U3WmJ3cGRPMHRQSEgxMU5OS1lt?=
 =?utf-8?B?WkRjUklDV0VpZWM3NlV4bGNhMndYVlBqSk5icjFWbzdhdUZ1aWROYzJoNUZH?=
 =?utf-8?B?UVRubHNLK1JtYWJxMUtZalIvMmc0WnYyMExndm84eFEwTGk0eTByYUh5LzdL?=
 =?utf-8?B?REprOGdjeWpqckNpRzBLNkJZc1pEY0lkNjRUTnFBRzhuVk0rME5KeTQ0ZTN2?=
 =?utf-8?B?eXpubXE3cjd0ckFzd29VL2g1ZGZCSk1oSzljRFowK0RRRHRIRTg3ZVNIdVFi?=
 =?utf-8?B?c1h4QmJBQm5qT0ttZ3JOa28xZldGOVZqR2xoMzhoYzRNMDQycXREMTYxNWVj?=
 =?utf-8?B?ZzNXaWtkei93QzBqUDJ2R2tXYUUvQzJRZTBaQTF4djVyZ2JZd3lmTlNrc05l?=
 =?utf-8?B?TzJxRFVQZG43eHRONVQ5VWRYZUlUc25qb0VFNWt3U09VeGZuNUFQNndobTR4?=
 =?utf-8?B?eUFCNTdhSzNWN3FFUVpkcHlPdGlCTHIybXVldVBUN0wweFoweWJMZjE2SHJM?=
 =?utf-8?B?VGpNQVhDaTdabDFmN2V6RkxCS2lrVm5HYVpIVnp4b1BYUnNEV0lwbWRJQnVH?=
 =?utf-8?B?azIrRUF6M1VkUUNRb2hFSlVCZFBIMmdmUGwrbHc0NVc2YmltbTNFV2p6clFz?=
 =?utf-8?B?YW9HYUdhN0Z5MjZVUjJkMW1LeTFOU0p0MGNrM2ZHb204OXVBZ3R6bW00a2Fn?=
 =?utf-8?B?NjRLcWQ2ZkdXNzhwaGtGU3M1KytKNDEwTkNmYkNreFk4SXJXUkRvTEZReHpE?=
 =?utf-8?B?aDQ1MTBLbE1XdW9PUjcxRCtIN3hGcW1oa3cyZk9FZlM1RjlMRUVJbFoyenp5?=
 =?utf-8?B?TWVJdFdOejVva2VkUTVxbHVhUWgvbXptU3pXTk9CQ1g1TlhOREdReUpOaW9P?=
 =?utf-8?B?RnMwVFN5VDN5NmVxZ2JucWdDS3lBYnJHS3dwR1VhRU4vQVpUdGJIQWEyclMv?=
 =?utf-8?B?YytpbWRNb09FaFFLb2NNczc5Z3hCNDZlckRNNHlNSnpYRGVhSFY3UFZMN1pP?=
 =?utf-8?B?Mk1ncHYza3JWemhweUJWTXFRNEZNT3FOWnhpc3hZSjdzSVNoMytxdTBIWnpR?=
 =?utf-8?B?UUhQNC9ReUoyK1FQbU93QmYxQmpOdHhZOTJ5OFhYSmt4SDNCVzUrVnUxQkZr?=
 =?utf-8?B?cThtbnl0MXI0SGVNVjEwRi9RWk5zRk9CMld5aWhRSXdrYmQ5eFo4ODdIZFYz?=
 =?utf-8?B?VC9ETG9GYjRzZnpFV3p3UHVROVZCbzR6NXNWZjYxS2dFcm9Mc1BsQ1E1T0Fm?=
 =?utf-8?B?bkVtK2RHZ080N1RCZU5LcXREVGw5d29LQmV0eisrS21DQ2tvZTlQc2VvTGtt?=
 =?utf-8?B?NmxuQ1d5ZDBHdUxoeGM2K3EwaGJWc0JpNGM0M3NTTXNKMUhPZTR6R3ZtVzJO?=
 =?utf-8?B?M0cwWDhqSUl0aGhHM0RQR3J1UWRMbmJ0VVF5U3lNTlpaamVOUXROR1dpQ0dl?=
 =?utf-8?B?cS9GdlllaDRNK2twdTA0Ly8yVGRvYlJXRTErZDFpU0d4cmZuVE4rUjJwVXdx?=
 =?utf-8?B?bkl3cUFNckJJNzA3ZFhLNW1hM25BTnk2TGtNUVk3ZDRtTTFYS2pDbXJ1OThH?=
 =?utf-8?Q?OrMz8QyemSJb/+S77gjx1jjUp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f50b2ff-21a4-41ea-e0a9-08de0bad0b8b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 05:38:18.8212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oo51YR21/fsu+lpi5rqc3JhNHFoifBrucgX/UpqKykRJsDVPaaoGIFq0UKXy4u/mNXTzZhIBgZ0BZJLNyBXofg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6330
X-OriginatorOrg: intel.com

On 10/15/2025 5:48 AM, Tim Chen wrote:
> On Tue, 2025-10-14 at 17:43 +0530, Madadi Vineeth Reddy wrote:
>> Hi Tim,
>> Thanks for the patch.
>>
>> On 11/10/25 23:54, Tim Chen wrote:

[snip]

>>> [Genoa details]
>>> [ChaCha20-xiangshan]
>>> ChaCha20-xiangshan is a simple benchmark using a static build of an
>>> 8-thread Verilator of XiangShan(RISC-V). The README file can be
>>> found here[2]. The score depends on how aggressive the user set the
>>> /sys/kernel/debug/sched/llc_aggr_tolerance. Using the default values,
>>> there is no much difference observed. While setting the
>>> /sys/kernel/debug/sched/llc_aggr_tolerance to 100, 44% improvment is
>>> observed.
>>>
>>> baseline:
>>> Host time spent: 50,868ms
>>>
>>> sched_cache:
>>> Host time spent: 28,349ms
>>>
>>> The time has been reduced by 44%.
>>
>> Milan showed no improvement across all benchmarks, which could be due to the
>> CCX topology (8 CCXs × 8 CPUs) where the LLC domain is too small for this
>> optimization to be effective. Moreover there could be overhead due to additional
>> computations.
>>
>> ChaCha20-xiangshan improvement in Genoa when llc_aggr_tolerance is set to 100 seems
>> due to having relatively lesser thread count. Please provide the numbers
>> with default values too. Would like to know numbers on varying loads.
> 
> I'll ask Chen Yu who did the Xiangshan experiments if he has those numbers.
> 

Madadi, do you mean the performance score number or active thread number
  when llc_aggr_tolerance is set to 1(default)?
The score is around with sched_cache and llc_aggr_tolerance set to 1.
The active number is 128 per process, and there are 8 processes when
launching the benchmark. I suppose the 128 comes from the number
of online CPUs. Please let me know if you need more data.

Cced Yangyu who's the author of this benchmark.

ls -l /proc/14460/task/ | grep -c '^d'
128

>>
>> In Power 10 and Power 11, the LLC size is 4 threads which is even smaller. Not
>> expecting improvements here but will run some workloads and share the data.
>>
>> Not gone through the entire series yet but are the situations like say in two
>> NUMA system, if a task's preferred LLC is on the wrong NUMA node for its memory,
>> which takes precedence?
> 
> We take preferred NUMA node in the consideration but we do not force task to
> go to the preferred node.
> 
> I remembered initially we limited the consideration to only LLCs in the
> preferred node. But we encountered regressions in hackbench and schbench,
> because when the preferred node don't have any occupancy resulting in preferred LLC
> to be set to -1 (no preference), and resulted in extra task migrations.
> And also the preferred node for hackbench and schbench was volatile
> as they have small memory footprint.  Chen Yu, please chime in if there
> were other reasons you remembered.
> 

Since the preferred NUMA node is per task, while the preferred LLC
is per process, scanning only the current task's preferred node
would lead to cross-node migration. This is because the process's
preferred LLC may not reside within the current task's preferred
node. Such a scenario could leave curr_m_a_occ at 0, and any LLC
with an occupancy > 0 would then trigger a preferred LLC switch.

> We'll need to revisit this part of the code to take care of such
> corner case. I think ideally we should move tasks to the least loaded LLC
> in the preferred node (even if no LLCs have occupancy in the preferred node),
> as long as preferred NUMA node don't changes too often.
> 
> 

Then we might need to introduce a new member in mm_struct to store the old
occupancy, curr_m_a_occ, so that we can reliably compare the old and new
occupancy - to avoid the 0 value of curr_m_a_occ.

>>
>> Also, what about the workloads that don't share data like stress-ng?
>>

The stream is single process stressing the memory without any share
data, we did not observe any difference on stream. We can launch more
tests on stress-ng.

thanks,
Chenyu>
> We can test those.  Ideally the controls to prevent over aggregation to preferred LLC
> would keep stress-ng happy.
> 
>> It will
>> be good to make sure that most other workloads don't suffer. As mentioned,
>> per process knob for llc_aggr_tolerance could help.
> 
> Agree. We are planning to add per process knob for the next version.  One thought is to use
> prctl. Any other suggestions are welcome.
> 


