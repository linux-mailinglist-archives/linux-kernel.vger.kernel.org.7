Return-Path: <linux-kernel+bounces-854844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DA9BDF8E0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166C019C30B6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DE02FE59F;
	Wed, 15 Oct 2025 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ScmeHUY1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BA22BDC13
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544484; cv=fail; b=gYs94h0CqqjmrOLoXR0kl2hVI/kKGQ/1mf8ezmxOsM2z67Kk05+wJPxUfi9N9c8FVpEK23PsIvGE01hV8yW/DOJRaeVkUMEEiQWwlHZCwdBl3NuB+81fdNjziIdxf6zIA0kP5fmk6jA/OXEThWWhLgsk2Slnxo+OynttE1Igee4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544484; c=relaxed/simple;
	bh=vPbi5Ftt8pv3xkPJwRsfaktA9vKQbjSYz9jJjYMM+/E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hLRPHlAjeSevlxDli+9vMf4e9Is0vF+RBQDwyyf+O7NjuNor91xFMvF5SqJvEU/UboUCvTEL3kMQIqaRHanK//Q4/iOjv/EQXg9uGU/MwappofkZ+cDce82HAqgxwwDel78Xaedrtl3/G0KK1cckMuQuOfR7rAWRrKf7xchhEsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ScmeHUY1; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760544483; x=1792080483;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vPbi5Ftt8pv3xkPJwRsfaktA9vKQbjSYz9jJjYMM+/E=;
  b=ScmeHUY1lDvtyKSMImmDxeWKuJ9oLQAi7T1EcgCJZCHh+uS2qWjBvJX7
   W8Y1KFnqR5whX45KgQl4NdFQrKei/FCTVEcKWw2raqX6h7XEQPe1YyUEE
   Dulf4qBun9G3KqHk3tC1GPoI8e7nSYBLrm9gGuDKbSp2gfBgc+PalK9Yj
   UX5zoftKudXyNlbBrp5zdeads0V8/t25ZrQiHe1ZKtK7N3M9Fmm7+s5mn
   0RSpZoI3mIZVGf5pmGtLomz8AZswbz3RpPaeAGPGMp2ChHSDih76EJPj3
   YU3m3Wrr064mvInwXpl6C6s3RKMgBgKbp8uz3t1NvIqd7Krzi88J1Ryvh
   g==;
X-CSE-ConnectionGUID: Uk7eznZ1TZCcnmyTbZ5vWw==
X-CSE-MsgGUID: iFjQHTelRcah32SbAEkNBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="73001306"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="73001306"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 09:07:57 -0700
X-CSE-ConnectionGUID: OuFauTgDTkeZbj8db/lOXg==
X-CSE-MsgGUID: H2zxB4zqRNyNhtUoYCCvAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="182672133"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 09:07:56 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 09:07:55 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 09:07:55 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.61) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 09:07:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QmajRbM65HVeoRtssPERLHksod7jUo/4ARCkr0XUzkRJY/pAsP4+1cCeq46Lh4AvmRnt9dpPTXbLDWvoL6zCE3XZzVMzX7N7jnBEjA7tvdFx0MeQU5ChbgFkoMPDvR65AnhosNaRx1gLU4OtlUD9eW3JQjVCUHYRiTNHOCUlxqSvpch/uQ1jsHj8FDmOFNX1yr4tnkK7PkR55Zvjr0sRqdpoiW3ZuDBgv+8/OQHabmltQpslmn7fmD6AvEy+oOIktS+elGkbHuwy5Tsr4R7amEiidRYOkBt8/C4+a3qkE/fpiW1jSWF28BxUU0DSicuLDlpueD6LAhhj31Ko5yz0tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4okDiCGKpt0ushTEXYDV5FkaZ6UoL8A/VJukUZj0Txs=;
 b=k1oXLUO9WG4jmis7QosYXuou98M6vMleREg2l4P6azJDE2S5HLFpl2naBvHyLCpiyDaQxY6cmoM4yo4Rwwz9AHFSJ3hW3xrLgp6lWeGcwdu92p93T+xKnFSKKau/JCAnDg9X6sIDau8SHuCb0cUGDNMBGF4PpSjmHzl5ryf5LS6/A+t9Yj5IxcaVeBYfpFsVGp1l0PtTHU9ATU4DerMd8kmfV0blb8nXpwXG2OUKoNbmwQTUxapQb47f7fxrnq9ximRwQozCYUOkoE6qATKE8Hzrmq9IKfu++IP4GeyJggmkMYt+aHjb6vgdIpmegRP2MeUNHLEOzDitsF0op6QwvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DS4PPF990BCE628.namprd11.prod.outlook.com (2603:10b6:f:fc02::3d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Wed, 15 Oct
 2025 16:07:53 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 16:07:53 +0000
Message-ID: <8fab615c-1d78-432b-9acc-01cafe393040@intel.com>
Date: Thu, 16 Oct 2025 00:07:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/19] sched/fair: Add infrastructure for cache-aware load
 balancing
To: Peter Zijlstra <peterz@infradead.org>, Madadi Vineeth Reddy
	<vineethr@linux.ibm.com>
CC: Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>, Vincent Guittot <vincent.guittot@linaro.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Hillf
 Danton" <hdanton@sina.com>, Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Jianyong Wu" <jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>,
	Tingyin Duan <tingyin.duan@gmail.com>, Vern Hao <vernhao@tencent.com>, Len
 Brown <len.brown@intel.com>, Aubrey Li <aubrey.li@intel.com>, Zhao Liu
	<zhao1.liu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, Adam Li
	<adamli@os.amperecomputing.com>, Tim Chen <tim.c.chen@intel.com>,
	<linux-kernel@vger.kernel.org>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <865b852e3fdef6561c9e0a5be9a94aec8a68cdea.1760206683.git.tim.c.chen@linux.intel.com>
 <22750d4a-fdd6-48ad-a2ca-aa0c12af329c@linux.ibm.com>
 <20251015115445.GR3289052@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20251015115445.GR3289052@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU0P306CA0043.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::17) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DS4PPF990BCE628:EE_
X-MS-Office365-Filtering-Correlation-Id: 38edb303-317d-48c4-6c0d-08de0c04feef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0JwQTdkSHdhL3dub0phNEdZVFl3TnliZWpJQmxYaHlnWTZvZlluQnJNckgv?=
 =?utf-8?B?dFJ6Qi9aZTN5c2Fid0lHWnJEYVU0Q2Q0OEpMWlNJTkQ2TTI2b2JobUpDYUNN?=
 =?utf-8?B?My84b3BCOVYrYzVkNW5yMFpveEdNMHcwanBFWGpvYTIxMUdNTXhoSXgwUmJK?=
 =?utf-8?B?STUxZ1FuczNTR1FiRGRQQ3BDak1mRlZ5V09OSkJwNk5nb1FSWWpEQTQrV0lj?=
 =?utf-8?B?TGlTc3M2LzZiMXlnd2I4RmVSdVZNT0xJZEFVdTRZUXN5VFdZUzZqWGNORWgr?=
 =?utf-8?B?eFg1NTVTdDBETE8wb1Nrb1EwZWRBTmpPOTZiUnIxRGQzMHRPNmRQV3E3b1JK?=
 =?utf-8?B?Z01tRWlZNFVYN2VGS0hJd3FZNlZ0U2Y5NXY4Q09qS2NIOTUwdllnUE1xK1Zy?=
 =?utf-8?B?Sm1za2p1Rm12ZW1OeWUyTnBRVjFoTVkvSXFRY3NGRTk1cE1hN3E0eTh0ZHRP?=
 =?utf-8?B?a1Y0WWM5REJYRnhvV1YwSkxSdHUvdXJiK2VjY3BEZlBFMGl5WWZZb2JiRUNG?=
 =?utf-8?B?cUNrTmlDbDRaRFFwTEhzL0NEclpyYUdYY1VEbTlPbkhVWmtqOWM5RDJpU0h3?=
 =?utf-8?B?RERHKzc2TDlwWVo2RXZQK29RSFZPUDBkdVFzSG9UWFREQlMxMS80Q3ArRGo0?=
 =?utf-8?B?eUNXUTNFblQ0LzcyNzVicTRGaDVqb2ZaWm1NWno0R0ZRTENQWWVLUDNoNzlv?=
 =?utf-8?B?ZkFqbUdlaDZ2TjRuT1Q2dVJIYnBxUDFGaFNLVW1rN0lBbFRpZEcwRHV0dG5n?=
 =?utf-8?B?UFk3MkQ4a3VKVFJvTzNPMnR3S1ZDZlFwQ0I0cVNWVG5wRnlFaW5JNzd6cVZy?=
 =?utf-8?B?cEQ2UkJWQ29oNXZ4YU53OENDRkNEQkxDSHZuRzNHN1dVMzNqLzJJNnZ5ZzFa?=
 =?utf-8?B?WEtjVkc4VnY5OTZuNUN6ZVdoUEJSa29KV2d2N3BZcVpiTWY1bGRyWUl2TVlt?=
 =?utf-8?B?Wk5pTCtEekMxTHVvVzdFSlRCQmVCa2lRZlNiUFY3ak1lOXVEWW5GUnNXaWpU?=
 =?utf-8?B?S3IzKzhnQ01hSmJRQVQyM2IzSzkxTHVZOTFmODBiRndLb05QcElUTGtSanJh?=
 =?utf-8?B?SkpNNWFYVXJsQUZBditvdHZ5b2lyRHRjTE9DMzRJT1l1UzdRMHMxbGM0bVYv?=
 =?utf-8?B?aWRLRFhQNWJYTFJ5UC9mQVZ2SnpsZm40dUNBY1pwWGtOV1VvUWhTYmlXQU5k?=
 =?utf-8?B?amRZcHVpbnhyVWw0ZENZRjhqK2RNWGtuelJyVFZLNXh6bjQwRXAwU1BrNGc2?=
 =?utf-8?B?bFN2b2tVOTZaNkVGemtqTVBzZlpzcmJYa3FUK2lzUFRBbmgyUTl6N0VFclZY?=
 =?utf-8?B?M04zSFNRTDV5MndlK2JsVzhnNjRkUmMweVczckI5Mi8yQ2tjR2twa2lQUjlm?=
 =?utf-8?B?WGpFdjBNMEljNzJ0S2NTaWhzUkd3ZGt1Sk52Z29GeTFWb1oxT3FycW1xQTdt?=
 =?utf-8?B?OXg0L0pZd05pbU9aMUtlcWVqNzIwWFRrTnhOYjdubXcvY3c1OVFxdWEzb3Vj?=
 =?utf-8?B?cmMxaEFna2ViRERzVG1hN0NoUVRSRXJncWNDNDlFL21GK0tlalNWOWUwZ1Jv?=
 =?utf-8?B?Z2xpU2YxZWZjMHBLRHBUQ2VjSGIzUTk5NGh1SFIzWktiL3h3Z2tSZVYzS2NY?=
 =?utf-8?B?bVBrYmhCUkQwNXVHZjNRN1B3TEpDQm9ycTc0MXZnVXV0VU1uWVpLbTdqQnhv?=
 =?utf-8?B?RDZUM05lTWFrVUJSZ0Yrcm1ydGYvN2hIdG16Z05MU0N3UDdFU3RqdFR3cmhv?=
 =?utf-8?B?S09IaXRFZ0ZMUkFScjZ0UkRpSk5pdTgzenJvbHp4dXBsamh2bEtXVGpnN2t4?=
 =?utf-8?B?OTczNlFFTVF6N1dneWVjS01uZFJVb1YvMm9EelRNQ1JYRTZCcTlJNURla2Ns?=
 =?utf-8?B?UGZmcFZCZmVwdlQ3ZE5WYUsvOWZCY0FKNVU5Rnp3aVVLTGxwaGt4QnpZTDRI?=
 =?utf-8?Q?l+jAmbvQ46Gzp9W2tipzDWTLj4wd2fJe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cExCd29GRUtnNTAvRHMzKytEMHhwMW1ha1pEdEpMZndmVVRxRzR3dGhHRFhj?=
 =?utf-8?B?aGo1MjZaN1hQMVU4WmRvekVMTHNjbzBRNEdJRUxuTjZ6cGxyMU44TnZESkpZ?=
 =?utf-8?B?cUxDT0tDbStsMW95aW94WHllbVRERkNuVVoyMmNDY1MvTGxhYUxCVEhCTjNK?=
 =?utf-8?B?dkhxckR6WDBFNkpWZVY5c0FGV1ZTL29hOW9LVmdhNlIyNytKZCsyMXp3clpW?=
 =?utf-8?B?Z2ZjTSswWHlxK1cxUjRsdzNtRG91V1ZmMUNWRDJYdUx0bUt1dWYwejFIOW5l?=
 =?utf-8?B?bDlCcFdLQzUyOEdnWkk3QkdHNkhPMGtiMTRrc3VyTjBFZUlvTzZlQ2tUTml6?=
 =?utf-8?B?UXp4Rlh2NnlXLytOd2lpTFBwcGo2K2d1S3hjeWJkZkViZWpMNTl6RzVYcFV4?=
 =?utf-8?B?RTVhNnhSaUcxbW9maDVoT0NZUjZLbGlNNTBLZmNQZ1E2QjVlcWRSdmRDa3dy?=
 =?utf-8?B?VVUvT1BlRkhJbERlbU95djdoeDFXZW11aEtWWG9KTnh6akdCMzI2bGZXSzFI?=
 =?utf-8?B?V2NWaytpTVM3bjJlcWlyeGJ4WFdLWEJFM0d1TWp1Y2JiNXJlL1VEd04xQW5F?=
 =?utf-8?B?UXg3T2UzKzFjd0dkRHEwTmxTNSsvLzdURG1pSDdqaGl5SVNLQ0w5YXZ5blQz?=
 =?utf-8?B?bXh6andkTFR3RmN6eFBBeUtsckxjcTlpNmlBVUxZaUFTeXhVRGIxYzBGOE1G?=
 =?utf-8?B?UmdRc2ZnRE1vcERjNXRxcXdFQ0NLMkxILzc3RVpEZll5aE5kbjJSL0gwYk5H?=
 =?utf-8?B?Z0pnYWJYbWV3K1VmVG9od0ljeHc2ZVQ2amw0TWxOWEN0RHZqSzZuNWlVY3A2?=
 =?utf-8?B?eS9yU1ZObG8xVUxKQ1c3ME5mTzBnWDF6QzB3YnNueHozeXB3MlpPbVNqTHdU?=
 =?utf-8?B?TSt5OGVZbS83ZUtnUlVIY04yeFUzaDdJQmk1cE1hb2MySmJFaUk3T2xEVjhm?=
 =?utf-8?B?UWxFYjdZQlV1U1J6cVB4SmdzT254MHR1am5TSjZVN1lYdk4xa0dGN2ZZYTQ2?=
 =?utf-8?B?Yy9rbjQ5U3J5VlUxLzZoZ2o4eTQvMWQvSklJRFRTYUc2K3YwR3FMcTFPQ0Nu?=
 =?utf-8?B?OTBaMFJMZm9ZKzB4Rzk5YXZ5MC90Y3d3Z2ZTZHB3ZUVBVm52VTkxV2JXTjJD?=
 =?utf-8?B?cHJxRTRUbkd2dWRoSkVrK2xyaTVTdS9rUEMyTUd4REhYS3VYbzNzb3h6Z0g2?=
 =?utf-8?B?Z1IwZUFMY3JTdWZrYnhzb2RualdMOGx2cEp3Vk5iM2o5clJvYmtxZGorRlU4?=
 =?utf-8?B?WmE0dTFKSUM5d2ZjbjNqWHVLek4ybXFIOEFnNURIc1V6MXowbitQUDNSQzVm?=
 =?utf-8?B?SmJiSmdSWjNSNWJiNWtONnJRRVVQOFdGaUZMbUV0MUUwK0xIS0NKdEsydFNu?=
 =?utf-8?B?cldSWGlpdG9TZDYzOEdibXNqdzdRdVdEN2VBNDhoVXI5eWY2NFdyMUozWExQ?=
 =?utf-8?B?ZlRnckpCWVhNOVVZdit1dmpZd25vU1ZUekc4Q0VOY3lJVUsvb2ZGbmQvNElY?=
 =?utf-8?B?bmduUGU5eWsyVG54UmJ3a2RFNHNISlovQXczMDBjcWdIU216QUFOVFZNN2kr?=
 =?utf-8?B?dFRmQmdGeVRWRWR1MUYrVXFaMUllWE5tMGltb3NzRm9TRmk3R0wxbnByWjZk?=
 =?utf-8?B?d003emd4Q29yVE1rMW5Fbm41ZFI2ajVzaUVyZlhFbHR2S1ZxYUc2b3V4a0FF?=
 =?utf-8?B?Y3FhQXF2T2wrOWdianVJYk1yQ2JKTGRMQzNveXZlOW1kK3pkbmVRVEcrSTJ1?=
 =?utf-8?B?UC8rcVdWNUlqM05EVkhhNjkrMDZyV2Y4ZkNoMXpHcHRiN3dvMzJUSVVtQUdU?=
 =?utf-8?B?clhSclg3M3lkYXVQYmdHZ1RLYmFKcHRpTlBkTkNRNFJaY091SjAxMHRJbXN3?=
 =?utf-8?B?dXZ4RzZkU2dJTUdUYTdVd0ZQTitIRzVnQVJTRGVzRUl1ZzlnRDJQMGdJRmFr?=
 =?utf-8?B?aHd0OEZTZTBaNXUvOVcxNGwxUWExRmpLRHlJWE92eWNaeGJCY0xoSEgwMkhJ?=
 =?utf-8?B?cm1WYy9OVWNmM0FMeXpHelAvZE5yNUVZUjh1U0hoUWFsSTFiZzdSUjVHdnQz?=
 =?utf-8?B?dE5EVTRjSEFyUnA2QlF5VTRGTmxkQlRVL3hOY09HaHJWU2kwM2xIZFF4alZZ?=
 =?utf-8?Q?ZlDasX4ahTXLtyQpIU6QHswes?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38edb303-317d-48c4-6c0d-08de0c04feef
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 16:07:53.1420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lt0BeAcHf54iYvuxAmusmbRi5p3Yei5l81xnVH4p2hxFVP3TMxOxMEhBpqT8R6/8WwU2wmfWurGbXHwMeBtyvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF990BCE628
X-OriginatorOrg: intel.com

On 10/15/2025 7:54 PM, Peter Zijlstra wrote:
> On Wed, Oct 15, 2025 at 12:42:48AM +0530, Madadi Vineeth Reddy wrote:
>>> +static void get_scan_cpumasks(cpumask_var_t cpus, int cache_cpu,
>>> +			      int pref_nid, int curr_cpu)
>>> +{
>>> +#ifdef CONFIG_NUMA_BALANCING
>>> +	/* First honor the task's preferred node. */
>>> +	if (pref_nid != NUMA_NO_NODE)
>>> +		cpumask_or(cpus, cpus, cpumask_of_node(pref_nid));
>>> +#endif
>>> +
>>> +	/* Next honor the task's cache CPU if it is not included. */
>>> +	if (cache_cpu != -1 && !cpumask_test_cpu(cache_cpu, cpus))
>>> +		cpumask_or(cpus, cpus,
>>> +			   cpumask_of_node(cpu_to_node(cache_cpu)));
>>> +
>>> +	/*
>>> +	 * Lastly make sure that the task's current running node is
>>> +	 * considered.
>>> +	 */
>>> +	if (!cpumask_test_cpu(curr_cpu, cpus))
>>> +		cpumask_or(cpus, cpus, cpumask_of_node(cpu_to_node(curr_cpu)));
>>> +}
>>> +
>>> +static void __no_profile task_cache_work(struct callback_head *work)
>>> +{
>>> +	struct task_struct *p = current;
>>> +	struct mm_struct *mm = p->mm;
>>> +	unsigned long m_a_occ = 0;
>>> +	unsigned long curr_m_a_occ = 0;
>>> +	int cpu, m_a_cpu = -1, cache_cpu,
>>> +	    pref_nid = NUMA_NO_NODE, curr_cpu;
>>> +	cpumask_var_t cpus;
>>> +
>>> +	WARN_ON_ONCE(work != &p->cache_work);
>>> +
>>> +	work->next = work;
>>> +
>>> +	if (p->flags & PF_EXITING)
>>> +		return;
>>> +
>>> +	if (!zalloc_cpumask_var(&cpus, GFP_KERNEL))
>>> +		return;
>>> +
>>> +	curr_cpu = task_cpu(p);
>>> +	cache_cpu = mm->mm_sched_cpu;
>>> +#ifdef CONFIG_NUMA_BALANCING
>>> +	if (static_branch_likely(&sched_numa_balancing))
>>> +		pref_nid = p->numa_preferred_nid;
>>> +#endif
>>> +
>>> +	scoped_guard (cpus_read_lock) {
>>> +		get_scan_cpumasks(cpus, cache_cpu,
>>> +				  pref_nid, curr_cpu);
>>> +
>>
>> IIUC, `get_scan_cpumasks` ORs together the preferred NUMA node, cache CPU's node,
>> and current CPU's node. This could result in scanning multiple nodes, not preferring
>> the NUMA preferred node.
> 
> So this used to be online_mask, and is now magically changed to this
> more limited mask.
> 
> Could you split this change out and have it have a justification?

OK, we will do this and provide an explanation.

thanks,
Chenyu

