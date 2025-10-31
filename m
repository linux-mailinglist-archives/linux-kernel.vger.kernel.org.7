Return-Path: <linux-kernel+bounces-880465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC8FC25CF9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C5784F6F5D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E400288C2D;
	Fri, 31 Oct 2025 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RIuMjoku"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AFF28466C
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761923853; cv=fail; b=mR/8f8e4+k51d3ITCH+lFzvQvYw+R8CRR9wdQCxFz4hCpVd6Kem/CAn7ZQgujKNLWk+iLaFfeeYwrI8rr6J39GyueRNFlk3jCdVP1RTBWCIl8/vN5VrpSU8DBJVo9SsYA607rkE3Fco5DJJ8Fe8OXeDTiiXsF6kovazb0u8fvNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761923853; c=relaxed/simple;
	bh=H6CoG0XJDtbWH7dw3EGdch3zXkNt7875N1d4kwop4jw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mrwJ2ktO7bhBlOLhrhp56nAZT4klOYFSB/7UplfY4tTGY4XchRskt6GtKrCi+Rx0bat8GBqQ1S1+xNPq9x6/SlkFLluA84wetRTaKHNkbgimlUsXFz8LmXo7qGz8LuysuePTnReyQiO7Y/HPV+4KtkGOS/mezF1sni1kz4bmL9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RIuMjoku; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761923852; x=1793459852;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H6CoG0XJDtbWH7dw3EGdch3zXkNt7875N1d4kwop4jw=;
  b=RIuMjokucR2wcgjD9FTdHbchl9v8Gr7YGb3ffOoknLS5DgVKtId8gjS+
   kL6Hk8zIommxWw6d27mD3VijYxkc7E7+a7oeP1Xg/Zq29vUjr2BBMh3uM
   8iOD+9RjLhmcWgV4x6/aMUsAn33UxwV9NZfZs10yQdHIbtCO81F/+0G8D
   jXz0JuYYrI50QuNi6frrPsf7ZOEfVPqGhrTVBzXBEMcP3MEoj+5nvKib/
   yCMgxtGVbN/kb49JAumi4QvGSzV4E5BrFzBVlsXf5oFmVfq8FQAuuKbVG
   BRYagmyEdWjg4i1x7+nQ+n3GAE5zOz80jwnUJgYzUgvHSyeR/NFPTy8dB
   g==;
X-CSE-ConnectionGUID: 0rL9lg28R6+jaluvPuf7UA==
X-CSE-MsgGUID: U+5+KlwOTbWk25Jr6EjeUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="66700323"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="66700323"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 08:17:29 -0700
X-CSE-ConnectionGUID: cXYLdb0ZTJm2HkXlFLWcgw==
X-CSE-MsgGUID: Lj650PouQKaM+f4x/PL2hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="185920040"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 08:17:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 08:17:27 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 31 Oct 2025 08:17:27 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.35)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 08:17:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8S36lrB3ZAHRkr/enW0LGbsZfMM5lBOgDXpzpnCY/zWIA1mHSdRNgmbpqhHow/lCm4j4EXu2vEiSrKaImr5Qn0xKtQX6bStxrpn8ApHV7o1oSPEH7XrdjdSgEKrxsz8zl27iCE/t0x3AP3wvxztgPbF7KbiBJBLI7i0y3z61/6YD+s+UFnNRx5tRzBhWmVYdyiEwzDVgqtF8Z8ah5Ag8o+jPNtSygxkDkBr/5txDO23g/6k4HsBABv38AC/7uy43zAvDT1v11zB9ddjYXOXmVwj7v9UHyD3mESeuGig/a/wxIc/PSNLgrq0FtGUtp/+Y8wF8DVQewTZUEX4VbI+XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOOwoS1C8OXfGpR+Wo35zk19vV4DZXlCwdgpEsYFdR4=;
 b=oDYQO/2n8Z4kA+TOhty61vWodKMRAzpw5GFSILP1DxI3QsuzCTs8QISoK9ae0LBkNFgf7UUvHf/fY8mm7Uy1gcbbcVK/rMV0f3jByWc5k1qMdE8ZoV/ysuPtx7b2FYsbr1sOLtIl/W35BZ9GgJcBol2WcEc3yRcRZb54gHYcDzRq+c13DTYOdt2NkUFBxvMdE4Ba8FDJzysAK5+4jadq13YcgnzNlrf6xY6FYFAat3r6cqQeTP4LKBWvouCC0RTkN/Jmo1u+Es5tmEeHmJj81Cmmn9aVStzGT7PilJhMfd3GEanU4jcb8IzTfMOygTfMtaEsWpZhYVf0iUpstORC2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6005.namprd11.prod.outlook.com (2603:10b6:510:1e0::19)
 by DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 15:17:25 +0000
Received: from PH7PR11MB6005.namprd11.prod.outlook.com
 ([fe80::4f64:b0b5:4ed2:39ae]) by PH7PR11MB6005.namprd11.prod.outlook.com
 ([fe80::4f64:b0b5:4ed2:39ae%2]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 15:17:25 +0000
Message-ID: <76d1fe33-da20-47b3-9403-f3d6e664ad96@intel.com>
Date: Fri, 31 Oct 2025 23:17:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/19] sched/fair: Respect LLC preference in task
 migration and detach
To: K Prateek Nayak <kprateek.nayak@amd.com>, Tim Chen
	<tim.c.chen@linux.intel.com>
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
 Molnar" <mingo@redhat.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <d3afcff5622222523c843f5c1b023bfe43f9c67c.1760206683.git.tim.c.chen@linux.intel.com>
 <5cdf379c-b663-424d-8505-d91046e63c20@amd.com>
 <0a81b5be-6edd-4231-859b-0c6d06c61595@intel.com>
 <2c57d76f-fb31-4e1b-a3ce-ca13713e1b86@amd.com>
 <ebe994addb5624089db71df8fee402a664f8800a.camel@linux.intel.com>
 <53f9a8dc-c215-405b-958b-9cdd326dbfe3@amd.com>
 <c85e242d55da1f12419e2c2dc2bfa3fc942a848e.camel@linux.intel.com>
 <c67f70c5-1082-47e7-8270-f4b8ae05eace@amd.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <c67f70c5-1082-47e7-8270-f4b8ae05eace@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To PH7PR11MB6005.namprd11.prod.outlook.com
 (2603:10b6:510:1e0::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6005:EE_|DM6PR11MB4657:EE_
X-MS-Office365-Filtering-Correlation-Id: d5ee5990-d162-431e-bfef-08de18909882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NEFRdzBiQS9RSC84QjBvT0tnY3lmdzVGQXBNQjZ2YmR2VFcyNG9sdHhpb0Ri?=
 =?utf-8?B?VHNCV2lDY0g4YStoeHFydVBzNmthNmpZMDVrMG5Wd01KcmpQcFBCbGtmRks5?=
 =?utf-8?B?dUc3U2d1azRjUndxR1kyUitSSnJIRzV1UTZSbVVZSC9XSU13QVdKUDViMExi?=
 =?utf-8?B?eGtlOEpEZ1F0c1FCM2ZhMVRPRjZwbHE5SmcyalZKN2MreXFLeDVsbWdndkJy?=
 =?utf-8?B?SHR4MXpGQUxPcnZWUk5yRGRxU2g3ODl3UGtvNFdvVDczMWg4MGlpUG1KcUM4?=
 =?utf-8?B?L3c2VGk0QnBYR2t3RVlIZXhEV2pRbUlIOXUrRzFWcTQwSThKZThzaVZHMmFY?=
 =?utf-8?B?UVJLdGdlUVJjUHlaWlBkZHU3bnpWY1lRajA5VG9NNTBZWElsSjZQTmdVM3VC?=
 =?utf-8?B?VWdTRGFTMy9vSVdROVU1NDJENnk2Mm1wcXNPMGZ1aTFCQkpuNlZCTTBGUmgw?=
 =?utf-8?B?QVhmSlAwSXloOG5EcldnZCtmY1BLNGxLYVRpd0NQcjMxRGFJeFRyNkU3anBP?=
 =?utf-8?B?U0RSbnJYdURiM1l2K1JOVktkL2dRV2w1cm9UbHNXOEtPcVpBa3YyOEx5M0lO?=
 =?utf-8?B?Q3htNSsrcmNMck9pc0xhTHJPSkVtbzdtM1Y1ZzlhbzQzeWdUTEVkN0xtWmEz?=
 =?utf-8?B?OWRKU0NQdGs0NG8zanF3dG55a3RWUGU5SU5NRHpHZ0ZlOU1IZGNqR0NRbkFq?=
 =?utf-8?B?TTlJZHEybVBGMVh3SUZsVm1ySzlBbVQ1U0xldUN1SE5xWG9IYjc1SDN4eEVj?=
 =?utf-8?B?SlFPejVtbm52M1BWUzgvUWgxblE3blZyWnpUNkloSFJpeW41REZIN29NRUpY?=
 =?utf-8?B?QVlpZ0Zpa3ZGcHlIdk5UM0NHVElNbnZpTHF3ZmYreHhDUkxjMTB0RkNSeklJ?=
 =?utf-8?B?L0FqcXRaSVFXVnZKSlFncmh1RGdxWjhTOXFGZy9yN2FNNUw0cEFmb3hxdE9t?=
 =?utf-8?B?MnR3c2dhTEtaZStodnNqTzAzdVpjMWxCZGFGNkZiam5WNkhEUENXcXVHaGRC?=
 =?utf-8?B?d2lWK3M5ODJ5Tmg0Z3B3NWxjcFZUOVRmbTNqL00rTGtaQVUzZlVvdGhUbHVs?=
 =?utf-8?B?WWFWQmZFZi9XcFQrZzZQOUszUU5yUUpmNDlBRnR2SEQ4V1IrN3o1ZzZYYklr?=
 =?utf-8?B?UVA0UTduZjRGSXhPdXYyQngzejA0RStGYjRZOE95Q1J1dHhFaE5ZOXp6Q1h6?=
 =?utf-8?B?Wlp3eXJzSjU3bElycVB1LzZFeVRIWXRhRk8rZFRJZG9ZZ1hjS3VkK2pGS0tN?=
 =?utf-8?B?VGp3VVJUUnp0OFU3UnRXNDlKR0NHd3VKNlpoRzRtYWhRaGk2eG1reFJtaVlH?=
 =?utf-8?B?S01zUlE5U1loZWdld09udzZmSE1mL3hTZVM4eWx6eFJtelNnNnczK1NSMjZR?=
 =?utf-8?B?UE13MGRicUpRWnFHVW9UbWZQRDAvRmFvM3FtS2tiNzJyRWZmQlJQZnNOemxl?=
 =?utf-8?B?MmRsYXZTY2xyT203MTE5dnMwMlMwSHhhTGZMdTNJZVEybkx3NXhJU3A0czNz?=
 =?utf-8?B?ZFRWbXBabVpEclhrekcrS0dMNDhyOC9JeW1UVFZmUHc4MnBpNWRvNVJMRWdY?=
 =?utf-8?B?SEg5MW03Tk4vMVptNGRqeTBrdDI4WjAvRFovTWl0SFhGQjhxUnhxL1UyYVpx?=
 =?utf-8?B?ZXljNWE5dTA4eUhiMDFoYXZIaXBkeHpURkhKcnY3QXF1TGs3ajdZSGlYcVVo?=
 =?utf-8?B?SE1tQzRUZ1RrSUNvVVJvS0JNWkVIU3F5MHlPejN5RktGMENnVjBXcVZmWm9Z?=
 =?utf-8?B?N1gwM2hHUUROOUNlbHV3SjcvWVZ4bk5hbEV1cS9TV1RILys5MXJjY2R5Y3V5?=
 =?utf-8?B?amZUbklKQ3FuSGl2N2tkeXpVQmNkdXFvSEoxbWpxUXV5dE4vYUZrUkxpRGJH?=
 =?utf-8?B?QlB5elF1RkF5aStBTzNhbVF3OExHbm5ISGlGOTg0NHJUdDlVaU5SR3I3Wmg1?=
 =?utf-8?Q?yyvfXZb5JrepuT5xbMijN7eLm1z1NL/p?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6005.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGxOSno1RU9ON0sxY1B3KzAyL2dwZ09CVy9pb1kwQldMUkRLUnM5V1VSUllr?=
 =?utf-8?B?MGxBMFMxNUh5YjVqbGo5SzlPOElNL1N0T0pydHVlSmxnZmJQNFZ0QkhuVnkr?=
 =?utf-8?B?Z2lYTzdEVXlQZ3B0eVpqaGJNN1hyRFQrcUZDbEQ2em96VzNuZWs4UWd4cVUz?=
 =?utf-8?B?bXU3SG9VZzZaZC9EY0V0Qkpuazh2bEhOK0NSRXp5RzZqc1ZUZUsrLzR6VmZj?=
 =?utf-8?B?WFhQSUhuTC80WkcxOEhvSUNFS2J0YlRDL0VaUCt6WUY4MzVSWS9ZdGd1ZVZN?=
 =?utf-8?B?YnZuZ0tkV2ZkT0lhTWo2NGVWUXdBL3dYWHFUSGFyU05xdE9TT3Z6Zis4dlRQ?=
 =?utf-8?B?a09kYVZwa0pybDBkL0RpcXhrU0VKSXZoZENRNFppS2QzdTNMOWhvTDJoVkRH?=
 =?utf-8?B?dThocGRGeW1jOFlrWWFDQk9ja3FoemxaK2V6bWNwUWx3NDFzeGpNblg1bUdV?=
 =?utf-8?B?aDAyZGxKOUFSVW03WEJBRHBWQUtYMkV4ZG1YdFI2NmFqTlhrNTZVYnhMWUJk?=
 =?utf-8?B?VlNiODlFYlRxcTF6dnd3aDg4SEx6S3BFN280cmRyS2RiQmlVS1ppKy9CbVU3?=
 =?utf-8?B?RXJ6cWRERUl4dWlyUjBJUWtiTjJuRm1GYmY5WnIrSFFHbGcxSno5S0krcDd5?=
 =?utf-8?B?VTB6UG1MK0xXRW50T0dNT1V6MEg4QU9vR1VvY2M1NExZNWJZRUJhZnd2V2cx?=
 =?utf-8?B?bC9UWjg3eG15a1V4QXpMcml6MnA1Vjdud1gwM25aMkZpcW00dlRRZGQrKzNv?=
 =?utf-8?B?QmJVeVl5eThqakpkSFUydStyQ1Vxc0NSc3p4RERiZlZBd21OSU1pTDF3NnZp?=
 =?utf-8?B?T09KK0UyWEFVWTU2amxnLytaUHNYT1Z0eXJMZytFR3NMTnFldkpaVUhXRnJa?=
 =?utf-8?B?TjAxSjVjck5mOUd5cVVVVS9sVi9UQ1Zib1ZKb0NZeHJNYUxnbnpBOHZvN09C?=
 =?utf-8?B?SlFLOHd6VGFDY2xnMWEvL2I4OUxmR3FralNRZkNhd05wN1BjUTVnMlFSeVIr?=
 =?utf-8?B?ZnY4aklIOWxqMjdEaHNSUDdFdjBCblp2d0E1R0Z2WWNhNThralh4VnpaandD?=
 =?utf-8?B?cnRWdXNTSHRHbVIzUzFmMHVKZ2tERVJLNnQ3U25IZmpvR1ZCN1hhMzY2L2Ry?=
 =?utf-8?B?ZUxrK0RkWDFXSFFOVFFzamhQUVJnUnQrWm1US2VTYlh1dkdtcWVNVEIxbjdi?=
 =?utf-8?B?SWRTbExqVE0wQSsyeExJMTVYcFdsSUpMTGpRN0tWVVFGTzV1YlZVc3ZHNFlH?=
 =?utf-8?B?WC8xaUlqMThKamRPempTRkZ3QzZlVVp0dGhReDRneG5FNXhtYk1ZTFdlVDdj?=
 =?utf-8?B?T2ViYVgza2RYTlBLNGUzNzJWNk00aWJFN0JVWXRkSk5JSGxCaFBKTHkzMkZC?=
 =?utf-8?B?dlE4ZTZjU2hjV3VMZTdHWUNpYno4RUFEVkNUc01TVW9udGM4TTVNN2JvU3RD?=
 =?utf-8?B?d2p3U3lrZ0FTbEJwNm9OR0dUU0g2bWpLQ00vSHR3TlV6ZVpZUU1rK2hLMUw5?=
 =?utf-8?B?SSt0dzlweThPT09RcjFtVG1NV2Y2RjlUbWxuVlFIQndNbGRnQTFqNzJydmpI?=
 =?utf-8?B?Z3hIM29UaWpoRW84MlhUalUvczVtdVVoZnVxK3h1Nm5rcVF0T0lOaGtTR0NJ?=
 =?utf-8?B?ZjR6K3ppOWZ5dGxNTEt1ZHlvNnR1dFk0RWNUTngzUXZsdnc0dE94d1BFdC9s?=
 =?utf-8?B?T01RNDJBbkFWRGJNNi9ZZ2VxdExZR3BLMVVsekszYU12ZTZtbVlzZVZIQjQ1?=
 =?utf-8?B?Nzc3b2lwYzdEN3FMSjFxa3VuNy9HbVh2SDFSZ3hmNzZPRzRwWk9veW9nRVE3?=
 =?utf-8?B?OFdyZWdFS1U5S2tESkMvNWZkNkxKT1ZMY2VnbG53cjQvc3E0QVJmSkNFb21Q?=
 =?utf-8?B?Q2xHYlhTd3prZWM0Ym5Zcys0OEpYRXRGZXhxZVhsc3gzUi9aNFpxN0dmR295?=
 =?utf-8?B?S05weE1rc1VNcjlSTVFrUHVIRThpd1hNYUlwbHB0VmNPazV4bTdyQ1M3Yzcv?=
 =?utf-8?B?WnU1Zjkvby92a2RGR1A3WlBjOWwrQUhaMjRkYnB5OEVBR0ZqWHNhK2x1elRw?=
 =?utf-8?B?OGhZSnp6cldFTGlqTHZqU08yVzBVNk1tQWpPeDBOOFg3aS9WZHR1VWdTVEVV?=
 =?utf-8?Q?EZnnQB8jL/NDoL9kZUgQ0ahXU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ee5990-d162-431e-bfef-08de18909882
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6005.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 15:17:24.9713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A5c6ErTEMf41yvoN97FseWX6QjxH5j30VM0Uom63Nd1jIIZh2g0scK8DD4fcAKfPY239Z5cmxdVBaQuHpQ5peQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4657
X-OriginatorOrg: intel.com

Hi Prateek,

On 10/31/2025 11:32 AM, K Prateek Nayak wrote:
> Hello Tim,
> 
> On 10/31/2025 1:37 AM, Tim Chen wrote:
>> On Thu, 2025-10-30 at 09:49 +0530, K Prateek Nayak wrote:
>>> Hello Tim,
>>>
>>> On 10/30/2025 2:39 AM, Tim Chen wrote:
>>>>>> I suppose you are suggesting that the threshold for stopping task detachment
>>>>>> should be higher. With the above can_migrate_llc() check, I suppose we have
>>>>>> raised the threshold for stopping "task detachment"?
>>>>>
>>>>> Say the LLC is under heavy load and we only have overloaded groups.
>>>>> can_migrate_llc() would return "mig_unrestricted" since
>>>>> fits_llc_capacity() would return false.
>>>>>
>>>>> Since we are under "migrate_load", sched_balance_find_src_rq() has
>>>>> returned the CPU with the highest load which could very well be the
>>>>> CPU with with a large number of preferred LLC tasks.
>>>>>
>>>>> sched_cache_enabled() is still true and when detach_tasks() reaches
>>>>> one of these preferred llc tasks (which comes at the very end of the
>>>>> tasks list),
>>>>> we break out even if env->imbalance > 0 leaving
>>>>
>>>> Yes, but at least one task has been removed to even the load (making forward progress) and
>>>> the remaining tasks all wish to stay in the current LLC and will
>>>> preferred not to be moved. My thought was to not even all the load out
>>>> in one shot and pull more tasks out of their preferred LLC.
>>>> If the imbalance still remain, we'll come to that in the next load balance.
>>>
>>> In that case, can we spoof a LBF_ALL_PINNED for the case where we start
>>
>> In the code chunk (with fix I mentioned in last reply):
>>
>> +#ifdef CONFIG_SCHED_CACHE
>> +		/*
>> +		 * Don't detach more tasks if the remaining tasks want
>> +		 * to stay. We know the remaining tasks all prefer the
>> +		 * current LLC, because after order_tasks_by_llc(), the
>> +		 * tasks that prefer the current LLC are at the tail of
>> +		 * the list. The inhibition of detachment is to avoid too
>> +		 * many tasks being migrated out of the preferred LLC.
>> +		 */
>> +		if (sched_cache_enabled() && detached && p->preferred_llc != -1 &&
>> +		    llc_id(env->src_cpu) == p->preferred_llc &&
>> 		    llc_id(env->dst_cpu) != p->preferred_llc)
>> +			break;
>>
>> We have already pulled at least one task when we stop detaching because we
>> know that all the remaining tasks want to stay in it current LLC.
>> "detached" is non zero when we break. So LBF_ALL_PINNED would be cleared.
>> We will only exit the detach_tasks loop when there are truly no tasks
>> that can be moved and it is truly a LBF_ALL_PINNED case.
> 
> So what I was suggesting is something like:
> 
> @@ -10251,6 +10252,7 @@ static int detach_tasks(struct lb_env *env)
>   	unsigned long util, load;
>   	struct task_struct *p;
>   	int detached = 0;
> +	bool preserve_preferred;
>   
>   	lockdep_assert_rq_held(env->src_rq);
>   
> @@ -10268,6 +10270,10 @@ static int detach_tasks(struct lb_env *env)
>   
>   	tasks = order_tasks_by_llc(env, &env->src_rq->cfs_tasks);
>   
> +	preserve_preferred = sched_cache_enabled() &&
> +			     !(env->sd->flags & SD_SHARE_LLC) &&

Maybe also check (env->sd->child->flag & SD_SHARE_LLC) because we only
care about the domain that is the parent of a LLC domain.

> +			     !sd->nr_balance_failed;
 > +
>   	while (!list_empty(tasks)) {
>   		/*
>   		 * We don't want to steal all, otherwise we may be treated likewise,
> @@ -10370,16 +10376,15 @@ static int detach_tasks(struct lb_env *env)
>   
>   #ifdef CONFIG_SCHED_CACHE
>   		/*
> -		 * Don't detach more tasks if the remaining tasks want
> -		 * to stay. We know the remaining tasks all prefer the
> -		 * current LLC, because after order_tasks_by_llc(), the
> -		 * tasks that prefer the current LLC are at the tail of
> -		 * the list. The inhibition of detachment is to avoid too
> -		 * many tasks being migrated out of the preferred LLC.
> +		 * We've hit tasks that prefer src LLC while balancing between LLCs.
> +		 * If previous balances have been successful, pretend the rest of the
> +		 * tasks on this CPU are pinned and let the main load balancing loop
> +		 * find another target CPU to pull from if imbalance exists.
>   		 */
> -		if (sched_cache_enabled() && detached && p->preferred_llc != -1 &&
> -		    llc_id(env->src_cpu) == p->preferred_llc)
> +		if (preserve_preferred && detached && llc_id(env->src_cpu) == p->preferred_llc) {
> +			env->flags |= LBF_ALL_PINNED;

Let me try to understand this strategy: if all previous migrations
on this sched_domain have succeeded, it means that even if we stop
migrating tasks out of this busiest CPU from now on, it won’t
matter because the imbalance has already been mitigated. If we stop
the migration, we should look for other busy CPUs to pull some tasks
from. One concern is that setting LBF_ALL_PINNED and only clearing
env->dst_cpu will trigger a full re-scan of the entire sched_domain,
which might be costly-especially on large LLCs. We can try this to
see if it has any impact on the benchmark.

thanks,
Chenyu

>   			break;
> +		}
>   #endif
>   
> 

