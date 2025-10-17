Return-Path: <linux-kernel+bounces-857172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C5CBE614E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 04:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B231A60A14
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 02:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA34212575;
	Fri, 17 Oct 2025 02:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oukz4IaZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A956816A395
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 02:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760667040; cv=fail; b=MuqxXeYcXb8rU3YAP8+ZGKsB1Pv/SNEYXGqlb1/JVfkIGVgkAaXi0ImDRNb5goOt99Zei19S+W3L974qbqp9IF4RYc9GzuGKZ2HyCIS9Gn4HWqEKSSrT28ONITmf4e/hIVTPLSHEMR9Ml48WJClr20vHL12qCWgEMkDGEF2L2lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760667040; c=relaxed/simple;
	bh=sIjl1TRtltQtgyBmZ2fxPznMTpQ/sSYEtWQ4dVUg4eY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OoBGB3v6QOCSjU4CwP7OqYOVU2hPrpfHME1zz1VbZ3KnXUS/Blomct/6Ul54U9qjPfHabLqQTz/UM+vyWYZsFqbTDB1s0xSQZaJZX5R38EAgcqBZTZIl19mpFiIykxPaQdyM1xZ4+Nz0+HxoRbDWgczdqR/2evavk/2qf6cV5cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oukz4IaZ; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760667039; x=1792203039;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sIjl1TRtltQtgyBmZ2fxPznMTpQ/sSYEtWQ4dVUg4eY=;
  b=Oukz4IaZjfSDiw/uo4GoLJOIjFpDQQ810GMnaHoeCWhYL16dRUQH6Xrz
   QxVG+7X+KaLLnwWsNMwiT13Ds3/VgKTv2SspLP40U9p8BwxSLwRivzfh6
   5LX88SdTagkNAv7xkm0Lzz3WDLolMf5JzDJOggvevwhnlhFSnmtwGyPz9
   ztE01lSpNbxUI0enBg5md3lqssUpEiX2jxflE2nEGwn7m8BuE7mhzVZnn
   N9cBbHRPnBfaislXN9KNKgzlFJTvXI/Xe6eaevOpLq+AE/9gY4YHc1E2k
   AL84xxsaDCFe6QSBBHQIsl3R0cNC/eL79tFrmqtBFKCrPVYf+2r+g/jSu
   Q==;
X-CSE-ConnectionGUID: iVXictxjRoGY3cHnasUS9A==
X-CSE-MsgGUID: L4MtiQ2+T9CmSoEOkVjj1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="66737699"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="66737699"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 19:09:04 -0700
X-CSE-ConnectionGUID: ZBqcwj7IQnmsD5X017u1fw==
X-CSE-MsgGUID: zkKYs/W0Sw+cxKjrnrcELA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="183087117"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 19:09:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 19:09:02 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 19:09:02 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.39) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 19:09:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8llWSjYlt+jfhAJ/cn9hA778AlRfMHEPBr8dV/6zu79VndNALHIO4cyytKA2Hxz+zV2JCp1aDIbb+qn/gnDEMm5JlsVC6O2V/HMGdZ9+5ueG6aPKmqpbs4uVvfckT0kpYfU45Pmk4O2Er9allDDvA+7GV5g6aEqsyc7piUP6YzuhB+P1L0G/MHe9BwL8rLAS9CjzX4pbeFN6YzTmHP09GLPRReIVjOt4hak4XYwDP4iAnjx0QMTkOI+Ad1fzzjBTa+JX2Sp8gvD+1MMJe7Ce4lYnye1F6apSZntiUQAsVQl2DwSJWjrtaaxX5+mEXzKI7+r6g5OVk2neGPHLOhD0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFZwJ/cpW7rKdE+U2FJASk38MI/R0wsKo87Gm8G8LQM=;
 b=aw7bshgLYMpO7s2+jUcCBIsIw+nA0ZvFsuAjzQH0PvPnNVob0YERlWtcwQNku5dNShStBayzrypHCosnTlW9gcXAA5NgUCyJiqpCsMLVg9hl/gTq22LCxNSec7z49HesJXug8yWXz1b4BrNq/mbrv9JG1E1RwB6tLYTUA5lJFVv3h5USnfYpAfttcnUSsHzQaPTEYdP80WalIASToZ8ROlhnBO/VDcse3QLqHF4LsQ9uuYZiWfY+psyYx184+HeGLpeBmaXgfGAXe1YNQwyauzQQkhUQyA76DAMHQclarcWKvQF9vuKPiXeXL3cW/ufZmYxrAK+hySWKU1LMzmVoQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6009.namprd11.prod.outlook.com (2603:10b6:208:370::19)
 by CH3PR11MB7345.namprd11.prod.outlook.com (2603:10b6:610:14a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 02:08:59 +0000
Received: from MN0PR11MB6009.namprd11.prod.outlook.com
 ([fe80::671c:f7ab:d7c7:3d14]) by MN0PR11MB6009.namprd11.prod.outlook.com
 ([fe80::671c:f7ab:d7c7:3d14%7]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 02:08:59 +0000
Message-ID: <a5571bff-1bf8-4685-86cd-962be61427ba@intel.com>
Date: Fri, 17 Oct 2025 10:08:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/19] sched/fair: Introduce a static key to enable cache
 aware only for multi LLCs
To: Peter Zijlstra <peterz@infradead.org>
CC: Shrikanth Hegde <sshegde@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	"K Prateek Nayak" <kprateek.nayak@amd.com>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>, Vincent Guittot <vincent.guittot@linaro.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Madadi
 Vineeth Reddy" <vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>,
	Jianyong Wu <jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>,
	Tingyin Duan <tingyin.duan@gmail.com>, Vern Hao <vernhao@tencent.com>, "Len
 Brown" <len.brown@intel.com>, Aubrey Li <aubrey.li@intel.com>, Zhao Liu
	<zhao1.liu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, Adam Li
	<adamli@os.amperecomputing.com>, Tim Chen <tim.c.chen@intel.com>,
	<linux-kernel@vger.kernel.org>, Tim Chen <tim.c.chen@linux.intel.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <ef136e6a6f5a2ef840b1f9571c47411f04705b6a.1760206683.git.tim.c.chen@linux.intel.com>
 <20251015110450.GO3289052@noisy.programming.kicks-ass.net>
 <15b871f2-49b8-4b62-926d-31f93ad49f51@intel.com>
 <6007f50a-7abd-46c8-8934-f1b09df57479@linux.ibm.com>
 <3d7b6b2c-7b48-4bd5-87bf-39f4c72fa741@intel.com>
 <20251016074227.GY3289052@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20251016074227.GY3289052@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU2P306CA0064.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:39::15) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6009:EE_|CH3PR11MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f97b9f-94d9-4006-2a6d-08de0d2221af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnRyUi9ndXFMZ2phZFVncEhMOWR5NXdyRXVpcmtCYnpCUStkOUFOcEoycXEy?=
 =?utf-8?B?WlhKTDZlUUg3WVR5cHpHRGlEWklJcG9SWnB1dkk5dXhoYjl5RVNjdU52b2JG?=
 =?utf-8?B?bDlqNHNGMGU2V2diOU5HNlp3dzY4ODg2RHNnc3ZvdXVBNENuWVF5WXFDT3BD?=
 =?utf-8?B?SjNBM1UydnUrbmF4RTR4NFhIU3ZBbEpWRW5JL0pXUFJOL3hXRzRGNUxTSnUz?=
 =?utf-8?B?MlVlREFzdmcyT3RlTmJSNmh6dlRQVjAzUnZDYnhrVVY4bm9haXNxZm96ZnJD?=
 =?utf-8?B?SHZMdFA4NUY1TXdSMlRYRzJacWpxK1o3RVlUc25NRFBWU3VLMWlxaEVzckh0?=
 =?utf-8?B?WjNtdXZuallWNENmN1FvVkExOTZXaTNOTzd1cGJtbERSODBHOUQ1RHB5N0M0?=
 =?utf-8?B?SndhamJDaTFHVDRlenE0WnRZM1phN2pTVko2VlRKU2NPVUhJTEZ1cnl5SnJ4?=
 =?utf-8?B?Mlp6aExOZVpDazFnNUZ2VmxvUnlkNVhLRUJnTEtZalFyR1E3V1ovb3NsSkJW?=
 =?utf-8?B?UkprQkhJVUp5L3c5VDcyUnFIQWZGV2hFWGlYV2J1Z1pHWC9haWU4b214WTZF?=
 =?utf-8?B?WWpzMktKNnpxNnI2WHpZbGRQakU5UDZzNVRNeWs4NVNtUVlqZnlSa1BMVlpp?=
 =?utf-8?B?TUUzS1RzYkxVYzZPcjdlOTBLLzludG1TRU81enVkUFQrNk84Tk1ELzJtTUNz?=
 =?utf-8?B?dVJWaDcrU2pxa3pmRVhtN3NVK1NlK09xWGpCV3FYSnFqK0NGM1VsUHRIeEky?=
 =?utf-8?B?SFp5RnlmY2Q1elNHcHFkUTdsK0ZEdkdIbjg3WmwweTdYUHE1UDVmV2U1Wkcv?=
 =?utf-8?B?WXA3b3plRzM1ZWx2ZzROMktleExzMkJtQ3A2b0RlMmo5OUkyVnJQUzZOaGts?=
 =?utf-8?B?TklVK3FVM2FMUW9ZUngzV1owWWZ6a3hmdzJ3K25qNFZwVHIxc0VLcGgwWUNE?=
 =?utf-8?B?RWhFWTg5TjhZOGMrM1RPMzdxODZidVNaM2xNRmNpVHJJbWE0OTZTbDlnVG1B?=
 =?utf-8?B?eGFXNHNpVXF3YW9VRDVIQ1VVUHRCRmFaZnNQejEwa1pGUStQRWlRbStXQWdR?=
 =?utf-8?B?YWI5NHJ6dXFlb05DSVVrTU8wQ2VLRm5DY0N6N0RoQ0VZaUJyeEdRRDFCeDIw?=
 =?utf-8?B?clY1SmFzMXBQNGxtdUFhSjlwc0g0aUVKRHMzSHRXWTNxTDBWU3FVaEtXQkFn?=
 =?utf-8?B?dWFDUkkxK2wyZVRLdEtncFM4TVNKU2pUOE15T2VZMUVSSGZGMW1NbmFQakll?=
 =?utf-8?B?VFRhM3BFd3JWblp5cmtaejN3SkZFMzRnamEwM3Q5WHF2Qkg2bjliWUZrb2NU?=
 =?utf-8?B?Q1JFM0hQV3VRU0Mxc2FOV0VlQnpNUTRsTGpzNHdyR0NtN0t6djBya3FDYlU2?=
 =?utf-8?B?TjEwUVBCd0MyclJxRU55NkNpUDdCakF2YUltb2d5cUYyUWNROGhIcU1FWFEy?=
 =?utf-8?B?dFladzE1MXNBTW9lYytITTlDWkt0dVZNZ29WSjQvRW0wRisvUHI1OFlydExa?=
 =?utf-8?B?a01BWXZ5NUhjSmdrOE9QTi9zME9VbjZqNkFCTFhOTUFKTHorOHFid3lJSEM3?=
 =?utf-8?B?VWl6Y2lTSnJFZUhBNHNVUnV0Y3NFSFh1MW1wNXc4VkRMTHRXVFBJbWlYYUN2?=
 =?utf-8?B?OXRpdWxlbVpvSXRZeFkwcTNndXR6VnJIcENWeXFVOFBWdEVCbkhGczlRb3Rh?=
 =?utf-8?B?YjFIN1BuZklIcGZJTXE0WWhwZllGaHNrYTljU2hDSFlUVlN4eGR1ZWxwQllW?=
 =?utf-8?B?OXBMSWwraW1qWjBBMEMzaHZLS0wyWlVCMGphamIvMVI1QVVZSVFWVWRuV1BX?=
 =?utf-8?B?ZlhBUjhwdExTT1gzVXMyTCthQ292NlQyNXJaT3lUaHltNmRCMnVYR3VRRnFR?=
 =?utf-8?B?Wjl6WVRUYWRsK095U2ZQQk5QTXRXYldkQUgwMmJWU2JsQ2U1VjBqc3RucVlZ?=
 =?utf-8?Q?GiqEujjMr8ITx+zb2HmFDpAj8ELiO/G3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6009.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzJwWnB5N3BQM0xtcXZ0N3BmMGRGV1RTWTV5QXJ5Um56KzJrS2VDTlRUdFEx?=
 =?utf-8?B?UTNIOWVYM09MTkhyTTdkRU55M1owTVVndHF4VEVFY0VkNkJ3M256RGowR1Ja?=
 =?utf-8?B?bUR2cUhvd0R2dkxhWmt1Q09hNm9MZ1pQKzYzcFJOMmlhcFhFd2tPc0NuWExQ?=
 =?utf-8?B?THZHWnRMUXFKRnRjUmVMOUhHNng5QXRPM0ptL3QwbEZHNko4dTNtVTBsenQ2?=
 =?utf-8?B?a1llTDFRNm5wUEx5endHY0dlZFlpUEZXYm0rZTNKMVAwVWcrVjR5OVR2UkVW?=
 =?utf-8?B?YVVqVmlvTGxKbEQ2ZGRzZytFZUJWVEJmV200YWlQUlFrcDVmeGs4WWF1SVBV?=
 =?utf-8?B?MHFMc3pVTGdmb2d6VGsyNVVjSVM3NytBMUtuZU1LQk0yT1U2RE5RTGprdElD?=
 =?utf-8?B?OGJvajFzMG81Qit0ZXFCNmw1dXhHN1lYTDZ5LzN1T2NaVjZ4d1JrcXhyaWlF?=
 =?utf-8?B?VkJHVUVsdmRFOFNIaC81RjFWNUVwbDU3TExCR1ZHZHV5cUtkUGFETWhnYjhC?=
 =?utf-8?B?VVJ1QXV4aWpIM1RrNTc0cERqdjMvRHZPUTF1M2FDclBVUFNKTGhQT3BiZnBB?=
 =?utf-8?B?ckFNUTk1dzJGZlVKZEV1TmFneXZqL0hpeUNqbXhYTElWa1lZdkJNdnVNbk93?=
 =?utf-8?B?STBJbDd2ZnJ3N1MrTzJVTFpLL2dqSzBFMVhaN21NRXc3SVdocy9SVE54RTRS?=
 =?utf-8?B?NER0dkdSWFdTakY3UjE1Tjc2c0RhUUdlWmEvSGpKRkJiKzBneDR0bDI0QjhR?=
 =?utf-8?B?L0NWOURxQUt2TWtYNTlFelJhOEZkQ2REaldnN3orK29vcFh3MlhuNXJTSjdI?=
 =?utf-8?B?NzkwVmw3NHZVenZ0ZkhOUDJQa2NEV0xmeHl1Q1NNRjdJcDFGaWJKTUZZdFRP?=
 =?utf-8?B?T2JHMndiU2tLU0xGelZGZWxJdWFkSmttZ0JaMmlZa1N3S2FoZWxkMWZ5alg2?=
 =?utf-8?B?dE1LUTFjKzNML1FBZkVweWhYWC96aFNZdVo0eXZFTGs2UzFLZGxSUW9Fdk93?=
 =?utf-8?B?dldYd0JDUnl6YXB5Y0tCNkZyNlNiOFAzQ0tYVUFUblZPMklZUDlaWGxYWUg0?=
 =?utf-8?B?U3UwbG9SeXlnT0pOVEwwQldVZGxaVHM4cm9hSEVHK2hwZFBzV09qcDYzVUlv?=
 =?utf-8?B?SzRudmtUR0FGcTR1c1dyM2xFcVVYdmFSWDNOVi9rTG03OFV4KzdCWVdxcVVq?=
 =?utf-8?B?MWpMNlVidTNtL2QrSTdjcmdiS3JvdTlWOHRBK25lU1dJZHY2bHNBY1VNMFZq?=
 =?utf-8?B?RENZbkpSU1Noakg0UGgrYWlXbGRJZTR0U1JQbUhmdWExWXhBVnJZdDBoc3pH?=
 =?utf-8?B?MEQ4MS9ZQmdJVFFrQ0wyeWRJcmgzdDNNWDdsZ0t2S1g4dnhwdVY0eXl0ZFZT?=
 =?utf-8?B?YlVnMEYra0JNamhFMGN6RmVOaGpnakE0c2FpUTRuYWJyclN5VDFWd2d2ekJ1?=
 =?utf-8?B?YTdLVDU5ZkdXNmc1YnVrdXNkVkNSZnB4di9OT3V1WUpobkUrTVkrMGJxUC9G?=
 =?utf-8?B?ZzI0dzcrTGFic2Z5ZjNhWnR6R05rSVBjY3hkaHl1TENUMXZScklob2xvTEpw?=
 =?utf-8?B?NWdGekhaeHVjQ3FtSVNPdk9VMmxsU05QdWhHdHRVVDNvWU9pV0E2cHcyU1Vh?=
 =?utf-8?B?ZlY2cHRyMWZUVVJYQlEya1NzSkFsanIxOVNvWmFxQ05HV3lvZlFaajUrYUN0?=
 =?utf-8?B?cGFYMjZJeFR4Ymd0cXhTY3N4UzZOdWxKaC91aGZJd3F3ZXVyZ2k3UlB3T1Ra?=
 =?utf-8?B?cC9TQktqOWNPSkRSTGJJWHFLL3kxV1NhbzdXcXNLSTUzT21Xa2lrV3BsUXZt?=
 =?utf-8?B?QlFwU2JSUXNZRURselFZcVhFV1Y0Q0orSnJ1NVpnSURmOVZTZUcvNklzL0pt?=
 =?utf-8?B?Sys2eUR6UUwwZGUyQm1CVnc5YTZjelNzanhoZ3VvQkxYTUkxaGtQRjV2VjQ1?=
 =?utf-8?B?TWk0bVNQS29kL2gza1BiTTZESW9aV29Jak5JKzNhRXN4WnZlUDI3MzBVUjZV?=
 =?utf-8?B?SXVhVksvcjl4UkNHNHRUcFFtY0lTZ0J2SVpPU01lU2NMd3BRUUMybFdjbHYz?=
 =?utf-8?B?cUQ1NDFQUktDd2lKMDljUFo0amhJVlN0NEljckhCMmczZm4zOGhQeE40TU0z?=
 =?utf-8?Q?wAlW4q1maxDwUZXtogNVY9fTX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f97b9f-94d9-4006-2a6d-08de0d2221af
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 02:08:59.1176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhVtYIGDfFtNBenbAHPQtFtnyBnQybH5dHdYvnh8/XkoYfsdkT5oZzFtnqycHazZj3oWUTD6UTebY0UTiOEIbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7345
X-OriginatorOrg: intel.com

On 10/16/2025 3:42 PM, Peter Zijlstra wrote:
> On Thu, Oct 16, 2025 at 01:01:05AM +0800, Chen, Yu C wrote:
> 
>> Oh, do you mean only using sched_cache_allowed in sched_cache_enabled()?
>> I misunderstood that Peter suggested introducing only one key. But I didn't
>> quite catch up - do you mean we should monitor the switch of FEAT, modify
>> sched_cache_allowed when needed, and that the OS only queries
>> sched_cache_allowed
>> at runtime?
> 
> Just don't use sched_feat(), add a debugfs file like numa_balancing and
> then combine the userspace and topology information when setting the one
> static_branch.

Got it, will do like this.

thanks,
Chenyu

