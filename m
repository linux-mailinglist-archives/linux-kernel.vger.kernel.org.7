Return-Path: <linux-kernel+bounces-855495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2554FBE1721
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 06:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B3448683D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 04:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB80216E1B;
	Thu, 16 Oct 2025 04:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EPVfNYeB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369FDDDD2
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 04:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760589871; cv=fail; b=s+Co6VsgFCFlrlSRndN3aYNPWZeXbzv6vYZw8NOH+RQHceMK+jBvuf2+wFDguYkW24BHXkkK7AZs2ac1KvOuF8Ud6XMEmwXPn3ycTvj0AkthAuuf+R6aBetxK+cmYnEB4BjpbbAvBKfy5wf/LoUE0v1OGDsShGHK40+sQiNZEyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760589871; c=relaxed/simple;
	bh=CNCbmP6GeWbyxFHhDl0k7+Q9lA6sLFLhIoGddUdXKcc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HSyQo68J0JHIvjmR6a7mcKu0oT3yepcFe0FfzMjwZvlZjrzJIhnlNc9HlN+f6/CentBvvLUr4A4cUgDYte/4DkLL2iR5sipWVO6iiomBsnpeVtaPhjt1jFBG9aVLMiOXjZeKnnmpb+z7TmaeP18IGv1InRf4teL6V0MRjpv0lmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EPVfNYeB; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760589870; x=1792125870;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CNCbmP6GeWbyxFHhDl0k7+Q9lA6sLFLhIoGddUdXKcc=;
  b=EPVfNYeBgdWBSUAnJboMEzp7oTesx6uB4Qle3qPENiEZmpe7SwjTu9vm
   03jF9iCLN7YDKWM+kGKggiT1paa3FzUK0pliyaYMUAuwfd7LSHMX2hY4y
   EOsKf6P/plUxLrFZsrvSqNPhJZnZB5yOlv2tl3FoUV5oP/5UmVBZp/H2j
   LOw+NTqmXkNRfqRL0iD49IeW7zjXbThVX35u0f0t76ocVKhXccAaTpYE2
   LCHE+l9Pdp2akht80+WLVO/iNkY9KNoPRUPbnXFilyjxyHN/E1z7bItuV
   9Jcl0PrRcYZseSYX4etS0LspmJa77EgnxOzXQgHdfChIT+s5/qP3PcfNz
   Q==;
X-CSE-ConnectionGUID: 0JpsjeC2TLufd++ZW2mFnQ==
X-CSE-MsgGUID: g8Cjq6swTpOtNCGykCPlVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="88241902"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="88241902"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 21:44:29 -0700
X-CSE-ConnectionGUID: UBO+pxXDTu6Au4td90O8DA==
X-CSE-MsgGUID: +dsvBT9zSyOZtixtO3001Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="212947999"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 21:44:28 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 21:44:27 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 21:44:27 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.22) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 21:44:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWDP1+6PXzmD66ep6KUAaiPQx+xriOGUfQkvmSKzUq5AygQPO157cqodUyMRV4Ktz4pmYj9yRgOuOvyg67F2ybLbjBU0n4GPMa6od0TzFYXHcg5wY26bpaiqd1YMDcPKVHpnOhHU4yXg1Bcq2jywoYFI0H7i/WiXC+6nvrsOxW/lI2rYOyyL1EMjJzYke8cJicdUinavwEhb2qnCDq4dLA8fP2b0cSIy/dZiZvTCuJaLX05KGjmWhRiO/RQg7K6r8PYiK5qPwyt0Lto5J/V1VyKsSNd7QIILDmxrlEvx9WHUsn3JbSjgvSabd7sIsK04XJ2L2i0X78c8tHUPt8R0og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAPvgzU7l+lbaJaAq7Hn9izTs/tS7Mx8Tp7dleH9BYg=;
 b=qIupIjLHCDlk+jUhuXuZFAQSThj3RgPvbtBovfvUwFFqQ/SECIQVbsm1AVFrM6vij8zGT/bA0kt+F/jXZtOr75VgbOJotswdmWyvskYOV+4+sVsU5mDxna/C6WGjJBm8dglaI/a0GdxoGC0tHFpbgjRQHGVXDRIImX3L8BII8t3lsLDCDRXHfN1iN22gjTZ9AiB0OpuNbsHYRLajDXzvWala+ze2U0MClFVJAxlHSUi9yGfih+P+Pjs+Ra8enZRBD7eYSQKMNMYmtr+1UOOPz3w8ggbXFgsRcRZs6ge2v6FP8/Q+pqxcaes/Wegln1PoZQmixZmToQV312Cq1lhi5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH0PR11MB5128.namprd11.prod.outlook.com (2603:10b6:510:39::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.12; Thu, 16 Oct 2025 04:44:24 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 04:44:24 +0000
Message-ID: <a097ea5b-a4cf-4b47-91c2-6ba4b159a7e5@intel.com>
Date: Thu, 16 Oct 2025 12:44:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/19] sched/fair: Avoid cache-aware scheduling for
 memory-heavy processes
To: kernel test robot <oliver.sang@intel.com>, Tim Chen
	<tim.c.chen@linux.intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<aubrey.li@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
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
	<adamli@os.amperecomputing.com>, Tim Chen <tim.c.chen@intel.com>
References: <202510151429.2c3f3413-lkp@intel.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <202510151429.2c3f3413-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0029.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::16) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH0PR11MB5128:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b11d0d-b9f3-4e74-f1b4-08de0c6eae47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUR1RmtzT211a0pVK0FiM1VEZHBYaE5YYUZWQXlBcUVac0FmZUp4T3RBYXdo?=
 =?utf-8?B?MjNlTk54Uklhby83VGU3M0ZDZ3VCTmpRR1lsL0FiV24vb3pIREpMWlJJaFlP?=
 =?utf-8?B?WmJtQ24rL1NxSzl1NW5qMmpUaURuQWxSdlpJalBpcHYwU0NiSzZ4K0o2M1d0?=
 =?utf-8?B?eUNyWW1NOUhPL1cvMFZsVXF1TXl3WlBhOE5NM20rSWFTQTNjWkEvSUR6dDNm?=
 =?utf-8?B?QzVnaWxXdlZQemxDT056WnRtb3dHT095bVRqWjVEakhMNVJacFUwTmpXSW9L?=
 =?utf-8?B?TkYwckcxaDBINTNQTldvUS9RcGdZN2ZCT01XV2VxWjB3R1hUbFVvNUpVYUpE?=
 =?utf-8?B?S3JoMnlNR1ZSM1ozdFpvWE5XOHJCeldJekhiekwzTUtrV2RYM0dnRU52TTV6?=
 =?utf-8?B?SlFDY2VxSTRTK29wbHAxZk9XK3kxd1J2TTZHR2xwRXZJWVFGR0Z0VnRjcVU5?=
 =?utf-8?B?MmgvTnFCeEM2cXIzR1BhVnduNHkzRU5VUW1hZFdxS24vaTJLSkJ0bEtkQ0ly?=
 =?utf-8?B?NGMzRDVLSkpGeHR4bEg1SkFPTzExQmVJUUNzZUxQMnE5YytsdmQ3bzE5eDlO?=
 =?utf-8?B?ZGZMbFgxMjBxVFZCNm92Vy93S0JieEFXU1BieDFIa1VOOFRtdzNLVFNWT05O?=
 =?utf-8?B?NWlES2xMWVA2UUpGT0NGSDBjaVVvVGljMUpaN3VHajRPSWxDSmZsQ01yVGxJ?=
 =?utf-8?B?TldyQUFJZEM5QmR5VzJscjVHNWY1c1ZMVU1zekNOM0RlMlN4b01ROTk0cGYx?=
 =?utf-8?B?U01LVjV5WDNJWk9oNW53K3VWSy9JQmcrcWc3ZU90NHI2b3Z6YWtYTHJMdi9l?=
 =?utf-8?B?OFN6eDZpSXdvelVsUHZyZTUzaUt2ZTZpL3pZc1pHVU5ZRkU2cDRycTI5RnAx?=
 =?utf-8?B?bXZZVDA4aDBsWUt1NGdiZHlTZk42ZmRieXJyQVEyaW4zazFUeFBTbUw4Z1ht?=
 =?utf-8?B?ZlByUXk5VVVZcU1TeEZUZG5VT3FSSktVWGI1ZUxIeUVXN3dWcnhOZTRyYnp0?=
 =?utf-8?B?SERucUJNU29laDlvczRENDNHbW9kVWw4ME16TlhPK0t0VDExak1kR0orN1N3?=
 =?utf-8?B?Rm51QWI4VWw2eTN3Z0hic0NMVWorYUJXWEFkamUrdGVDMnc4YkVDR1cvNjJw?=
 =?utf-8?B?RzJaNUFrY3Vnd3V2aVlwMzE0TG1FVXVhK1o1SlhPMk0wZlgveGR1RG4vc3Rw?=
 =?utf-8?B?c08rYmhKaEJvOFB2endpUWhRSlArYUJVYTcranZubHFPakx5YkhHU3RNYWxq?=
 =?utf-8?B?NXArcEhuQ2lVNlRtOXJWU2RKTUVCQ1ZuK0NXcmRTMFo2aHA0azJCVnQvbFNw?=
 =?utf-8?B?N0dzb043MFdWRTVnUmtjdFBWdlhsNi85c1B0ZEo5eDNCUDJyY1EwSnp6dmhk?=
 =?utf-8?B?NEZ6cXRjWnZMazlKLzZUczFhNzh4N25jVWxGay8wS0NabzZHT2c3cTdYL3kw?=
 =?utf-8?B?ajQxelhVVFkzN0w2dThHbnJNdG9tL09ZWW11MkdJWWN2Ri9jak93cFF2akYv?=
 =?utf-8?B?NG13cjhKUSt2Y3AxSXlON2lzaWR1TjBRc2ptQVdsRDJWdVkva2Y2b2p2SHhC?=
 =?utf-8?B?ZHpyMXcxT2pscVRPTmlDdDNFZnc2NkhpcnNFTi9qc2p0U3k0bktMUmcwSXFy?=
 =?utf-8?B?WnZpQTdoM25aWnpicmpLbDE5NjdQM3RuY3krd1dSTnZFQ0xnVHRhUExLc3ht?=
 =?utf-8?B?bUxoNENhWjlFZFozdHdQVzQ2b3BwTytUK2pTQTRrT2pBVE9RYWorSjFIZjJU?=
 =?utf-8?B?bENFa1lhT3dpRllGZCtob1AxN0VYUVNZYW9tWjV4Nlh3NVRndzJiUFhLaEVE?=
 =?utf-8?B?SU4yRjBROUFheFBEVnZ4ZEZCYjVzRUR1dGpyZ2JmcEEzcm1DSUMyVWRyeE9Z?=
 =?utf-8?B?akZ6emp5emMyTGFLU3NMUzZxNzBuMW00TVgrL3F3V2VqOHMxOS9aWkxIWXNU?=
 =?utf-8?Q?Q0yZxVh9qlvNmcLKL3tPQnqpTqdxXeZB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3NqaGxxTk5jUjRBemhHL1NQZ2ZjSDFteEpmc3A2MjYzZE9GQjVqdjc5WFIr?=
 =?utf-8?B?WnhwRFVweEZNRk9OTzNxVk1TT2ZJOW1oekJiUk1oWW90VTBqaVR3c1ByNXJJ?=
 =?utf-8?B?cUJHMDczeXdUV2hPZ3JadnBlNTQ2R3dCNUxXVkJITUhaVjRZdW5ydk5rZC9O?=
 =?utf-8?B?bzN2Zk9kNHBLem5FNXAxVHhiODIxdDJQS3I1eEhjeFdNM1pKWXh4NzRCbjlC?=
 =?utf-8?B?Vnl3bEtkanVpWEZkRU0zUDdCYVhjVUpPSEVpZTVLV3ZYdWZMdTh0c01kQ2JM?=
 =?utf-8?B?Z2RsV2Q0SElFVGRYdm4vMU4rUlppd2tiOEVPb0pkeCsyMFE5Uy9hQXIvQTlZ?=
 =?utf-8?B?SzBzR0FUVmd2VlkwcjVwa09LWW9mZ3lyd3RnME5LQ0N3My8wR3BKeGFKUWYy?=
 =?utf-8?B?R0tYYzJRTjhLU0RyczVBRnFSM0ZGVENTaitROWhwOSt2Ymg1MDAraEtSUUxp?=
 =?utf-8?B?MklEM3Q2YmlaK1ZrcExudkJabFpxVEVBaG80aXVpMGxTemZ6eFRkTzVEdStU?=
 =?utf-8?B?VWV3WUs0K01oSDR6VXNHbERJTllDcUlYb2R2Rk9tMkpCL0tpUzkrQWNCZC9I?=
 =?utf-8?B?citmbzNZNzg2ZXcza0l6N0NDSllrSlRRRkVqLzRlSWxQNDdqMzVrbGFYUG8v?=
 =?utf-8?B?MVVTQUFZZ0lTQXlHMURqYmcvOTFtRTFHaEtGcjZRWGxXdHNHUTBJTEdCeVJ4?=
 =?utf-8?B?SzlWTEhXMWs4Z2Iwc200VElKVzNKcHVod2dzUzd3TzZwRDBUUUdocG53OTEw?=
 =?utf-8?B?TC9EbTQxenlyT3hPL3VoTTIvRGorSGw3cUpQV0xxdCtQR21KZWdtcGMrZTBD?=
 =?utf-8?B?QUdadExRNUs4Q1FadjA1dE9YTzhJZWRqSlpCZVcvRm5FRkZoM0VVOW9CeUpV?=
 =?utf-8?B?VFVESmIvVlJzdTdoaXMxSjlQQ09LcnV4bTlVYlBpblVKTUphSGpCZWFJNG9H?=
 =?utf-8?B?ZGpBUzFVc2VaOGpEOENXRVorQW5BWEVzSmU3VjhYM3lUNlZQeWxmWTFhcmNw?=
 =?utf-8?B?RXBENDBoMnBtWnZ2eTdBOXNVSG1vMVcvSjAvUDUzbFEySXRTelhUaUdvTHBI?=
 =?utf-8?B?aUxZMjAwMFJJWHBnZ3JpQTFyTnI4US9mbWo1TmhHQWdwVUtnQWtJSDYrVE40?=
 =?utf-8?B?Qm0xcG1uYjd0QWtIbTQ2SlJYUlFRcGVhbFg4UzU3d0dIOFVuWjhlQ1d4OFUz?=
 =?utf-8?B?ZG5aMzFGQ1BHd3kwcDVGdGdlZnR1Q21JQTdmVzlHMVpEWnRaVDEvOFhQU1N5?=
 =?utf-8?B?SkJaMWUyc0VQZENzbHhKR2ZJekxpM1pTQ3hqRmt2MEd1a20zdmtKT0YvdEg5?=
 =?utf-8?B?V3hORUVmejdWa0pvWktHVFg3SmhIOWhCSlNqY3NkZCtLc3AxUzc5TVk5SGhx?=
 =?utf-8?B?ZUJvandJWVZwNWFNMUt4d0JyTGZHZW9Rd3hDTit6MUNXMDRLcUNtWndIZFYr?=
 =?utf-8?B?ZkJ4SkppM2F0Y0Vqbm5ES2lDRTVWd2lSV0o4T1hGR0tOM2JDN2V5ZWF5M0p1?=
 =?utf-8?B?QnJ2eW4rdHNjZlR2bXQ0RGg3Ry9QL0E1Z2R5UnBWR1dXRmtYZjlRcmpicTJE?=
 =?utf-8?B?RWQ0OVNJdnBvOERkTkg4ekFCYWhSOHl6cE5sTzlkZTNJbXRzdC9yckRaN1JY?=
 =?utf-8?B?M0FmWnZwdlhGbXpHVUFvSElNTXhMeU44WnJqeFg3T2FoVWwvdEYrTnVodW5U?=
 =?utf-8?B?c1pwaENwK0szZVoycVdDQVZRN1ljOHNJSlBCY2ZtZ0xHbGt0dDV0MVJ4L3hF?=
 =?utf-8?B?WG5qZjBqdGRReDQ1NExGRGdXdGtqT1E0UDRrNmdGL0tRZ01ndFJGalZOUC9m?=
 =?utf-8?B?UDhyU3RZQVROOHdGVmZ1ekY2SjUxOUJVMG03VCtMWEVhK25NZUpNZlpJeUNF?=
 =?utf-8?B?UzZQOTZyUFhFWWNTa1B0MW5kYVFmUHdYRzNiOTB6REMwaUM5NkN1K0FPbVdu?=
 =?utf-8?B?Z1Y0Z0VsdXZlUDNscmRibVdWMG8wT3VWNnQ4ZFg4NlZ6M1ZLSTVjbHNvdGx5?=
 =?utf-8?B?ZE1HRkxULzU5MU1aOFRTaHY0bUQwcUVtdnR0Y2VzZ0pSQ2tpV2JIUndzYm5u?=
 =?utf-8?B?bzJacnZWZUVZRWxpV0IrblorUkI1WFJVMktRczlZSnMrUk5zeVg5T1BEMkpp?=
 =?utf-8?Q?7nxOioYOhrlEgoyFlGjKDPl2d?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b11d0d-b9f3-4e74-f1b4-08de0c6eae47
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 04:44:24.6851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZ/WcwRy1DJGxPBDF8s595yoi4at6D0/tjfm53cAdKTuSsDFCzuR82DRklEY7ogj3jcT3+4pR7xdnYqIcX/W4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5128
X-OriginatorOrg: intel.com

On 10/15/2025 2:57 PM, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "UBSAN:array-index-out-of-bounds_in_drivers/base/cacheinfo.c" on:

[snip]

> [   12.549731][   T83] ------------[ cut here ]------------
> [   12.550388][   T83] UBSAN: array-index-out-of-bounds in drivers/base/cacheinfo.c:37:9
> [   12.551060][   T83] index 4294967295 is out of range for type 'unsigned long[8]'
> [   12.551580][   T83] CPU: 0 UID: 0 PID: 83 Comm: systemd-journal Not tainted 6.17.0-rc4-00035-ge8b871200f11 #1 PREEMPTLAZY
> [   12.551585][   T83] Call Trace:
> [   12.551588][   T83]  __dump_stack (lib/dump_stack.c:95)
> [   12.551594][   T83]  dump_stack_lvl (lib/dump_stack.c:123)
> [   12.551601][   T83]  ubsan_epilogue.llvm.16751680356772289369 (lib/dump_stack.c:129 lib/ubsan.c:233)
> [   12.551607][   T83]  __ubsan_handle_out_of_bounds (lib/ubsan.c:?)
> [   12.551621][   T83]  get_cpu_cacheinfo (drivers/base/cacheinfo.c:?)
> [   12.551625][   T83]  exceed_llc_capacity (include/linux/cacheinfo.h:? kernel/sched/fair.c:1256)

Thanks 0day! It seems that for some reason the assignment of curr_cpu = 
task_cpu(p);
was after the check exceed_llc_capacity(), will fix this.

thanks,
Chenyu

