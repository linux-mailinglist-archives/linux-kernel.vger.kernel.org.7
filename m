Return-Path: <linux-kernel+bounces-725171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4C5AFFB91
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBC78588692
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5B928C016;
	Thu, 10 Jul 2025 08:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nRFX1NAr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211EC28B7FF
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134479; cv=fail; b=KqSZd2qvlLgcYxLg61LagIUGRvnhFQXNEXM3g8dsiIUtz0bZT5w83NCtK/qK2mqGLvifWE9ZVoAZFGMo88RMgqf/ePlC0u5+vMqA20vhXEZlj2kwPb0ucrlo8A6JIjgADl9rZUSrZMyje6I1/49X+nNAoqAHeUZMw0TtOhn8giY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134479; c=relaxed/simple;
	bh=y45Gk658yZzQFe7xcdAtPPcguz5yhUmblXM83QI6H8k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q03GM32y80JpBtrCmSgVv+YclV5z5ifd21LisMYutF6rqjXTxVFRia+BlbMMKdWfi3kK4hmeOa6bVe2iKWQqE4oI+bDdyoErVmIKepxrIMrQN6ujnxoDJhs5JU6QNU4644gLkBRLAY+N85vW6tyWIkrHdxc/G+AbJIXzTvvxT20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nRFX1NAr; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752134478; x=1783670478;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y45Gk658yZzQFe7xcdAtPPcguz5yhUmblXM83QI6H8k=;
  b=nRFX1NArdQv39uor2/bZQbHZDtVi6G8OiGIFkfVnuLd7Y4Xxo+0PwlZN
   pf2K/cbas4Sq9zQdXRQCq7wT6LLHj4qFJR3Oll16mLrdGeh3nB13sO6Ee
   FeAiEabX+d3YVu1DfgNAGxQfpDKFuR2Soph4tGvN9CiTRLPg4VhB4soCl
   3sQHBg9a9bTy6zXD3g1ARhxPbhbBsHu3ZpzGo+KHwjc7Hrl/ULcG1rLuM
   YhuruTVNC8OTRYawgxyIY8EVLcNANG2EKPwVTYV6g3LSeJKvyMacA5NV5
   FHRloKg/dLP68sAXFmzxIoyJgn47KzJPoklO970XfsKPtT1HMxigmp3jt
   Q==;
X-CSE-ConnectionGUID: Mt9aEuF6QpWTd3sbAMZSSw==
X-CSE-MsgGUID: 5eioeRTdSzOWpQckyFs6lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="42034312"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="42034312"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 01:01:17 -0700
X-CSE-ConnectionGUID: jlKo7cLITSqZq7W3OxjLJg==
X-CSE-MsgGUID: 5YSdhqUaSceuxJ9lhodd1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="161668053"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 01:01:18 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 01:01:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 01:01:16 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.89) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 01:01:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QuWLWVQH9puUwbSzw3IthGOOamtcgTHTKAJe4oZv5RL+3Xdgf5QymtoFuWzxGoO4MrC0PFDqvQ1bgYK5RMzPS+UIIq+b0mpILJde86A+xAlYpxm2HYYX9IPZw41c+3sXFJtv3mHb/QLwLjjYp7VvCgn9bdFMaP5VMfaZTWzol5rQ27/hegaDTJUduhK6EKUjiUMLF0quzsOhR0ADxTAkaSCWONx1V+KWW9NC0lH3145HJXbOG+3LXI2iA07i8qqFF71g5SLperTOQ8nBAmfubeiypf8ol9echmpomw4X4A7I+EAI6Ek+hMor89yKkWCKOEeb4jFtkWaWSdFjKj14Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwShsqqVsQD/6DlHhk6ojXEqnrNCoGbAKJwh7f3DXw8=;
 b=d/DcK4RsSAo0uuN0IgvpgvCuMW+3us4clBgq3oU9YOQL4tXsF/Gky539KG3lp7fKlDgFujU+7/8w3B7eq9Pl5uec9D76z7KF761cnhklFa/pBxkoBHcYPYsaKM7XWQUAKCMrH4gpxEsOb0sWX4FebbpkeQ3Q/DBaoyikd+dcjgcINCuDV0seYvcOz5qEwyKyx3y+fogaxnc8RkW/q0HfhAAeRMVVoIGEoSFZH2E1BWdMyv96oeSxIlub8L4W1YnMqnfhAnydpui2F/OQWqVVaGVvWphBbRwQoVK7tSl4Infz9S5aPQiFDo7FQeixgnF3+X2t6ojAueclg/9HSELDtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 IA1PR11MB6289.namprd11.prod.outlook.com (2603:10b6:208:3e7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.25; Thu, 10 Jul 2025 08:00:59 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.8857.026; Thu, 10 Jul 2025
 08:00:59 +0000
Message-ID: <292e70ed-aae5-4f52-8f85-80cba7ff301d@intel.com>
Date: Thu, 10 Jul 2025 16:00:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [tip:sched/core] [sched/smp] 06ddd17521:
 BUG:using_smp_processor_id()in_preemptible
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: kernel test robot <oliver.sang@intel.com>, Ingo Molnar <mingo@kernel.org>,
	<oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@redhat.com>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
	Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Valentin Schneider <vschneid@redhat.com>, "Vincent
 Guittot" <vincent.guittot@linaro.org>, <aubrey.li@linux.intel.com>
References: <202507100448.6b88d6f1-lkp@intel.com>
 <6cf071f3-ff5b-4025-8ce7-2f2cceb03984@intel.com>
 <20250710062528.T-Obm39T@linutronix.de>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20250710062528.T-Obm39T@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0242.apcprd06.prod.outlook.com
 (2603:1096:4:ac::26) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|IA1PR11MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca5a193-67dc-43f2-20d8-08ddbf87e7c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUVtNHhtM3F4YW4xc01Tck4ybWNCY3BrQ0tsTnhaZEVnem1FdDFTamNra3Ux?=
 =?utf-8?B?REJtYkZPRExqLzBjMjlKUkJFZHZPMGZVRkFnc2dmQ2hmUE4vbjN1ZFB1STE4?=
 =?utf-8?B?aUd5THRDU1BFUk52Nmt6Q29YSlpiMWZiRWNYdEh2UU5abGtnd1hVTGFuSzIr?=
 =?utf-8?B?LzhhTGdhbzVieVN4SzlSZktpQzVzVVI1NnAyZ0JvbkFBVTl0SEFTTmZyTThh?=
 =?utf-8?B?aEN0NGpPdDREYWVuaXNoUjROZm9KSkRzN05SR2JaMExIbGNjU2lKanA0OTRW?=
 =?utf-8?B?M0xJMm1ZcG5nSTJab1FOQy9LcDZ0UFhvTmh4MDdRV3FRaWFKT3M0Rjl2VHpN?=
 =?utf-8?B?dDNNTnYveU5GQUxsZjIvL1RzMTRaSDlnMjJ5M2Ivd0lkMVJFMHJiVXdaVUps?=
 =?utf-8?B?aU1vVDNBNWhKa0VZUVkvUVdzRUlRc3V2K1pGV1FnKzF3YjRUb1RpRjJOOHRK?=
 =?utf-8?B?dTcxa2xEZVdISDFjczViV1U4bE81YWltKzkyMVJnSDlDREFQL0xwMEloZVIy?=
 =?utf-8?B?TDJZSFJwTVFDZ3ZtQ3FZd0hXcXh0UFBPMTZFMmRUa1grTTdLMlhjNUpZU3lm?=
 =?utf-8?B?WndSU2FPcGprczlOQ2hyNTJNOGYxRHBrSFFBSmFmOURRMXVhQ1d4MWNVZWVp?=
 =?utf-8?B?SmFHUitQNzBsVjI4a2NnMXFpdHBhVmxiak0rY0VFbjdJL2VXYTBsZ3RBS3c2?=
 =?utf-8?B?OWFCRjRnTXYwVmtyTWxHRnNIY3FhcEZtOGIwdDlsWGUybnJXeHh2ZW8rMm00?=
 =?utf-8?B?Qk5zQ28zdEJ6WGZNdTF2ZTliMWk5UnprdDF3K1FDaWViZTFsNXlLSlRqOFNI?=
 =?utf-8?B?VUlXd0hTcUpydzFGQU9ZcHdoOE1ML3VtVm91WTRyc01VVlRISW16Z3BKajVI?=
 =?utf-8?B?dlphME5sUDM2UCtpQS9kUHJOTHMrdmMyQzQ2aVlERFZZdXdMa2doWHZpMmVH?=
 =?utf-8?B?RlVtUExleVRSNEZEQ3pHQTg0Z1JhZm8vQVVMMlRjUW02d01YY0hvdnF3VnZw?=
 =?utf-8?B?TGVISkJvODQ1R2ZFSkV0d3FvcS9uVjFSUUxTWUl4SFlMTzVCMDBvQ1RLcEpD?=
 =?utf-8?B?UEEyUDR5M3lFMlhiODEvM281QU5zZ043K1pXdG5QOFRQTmpwQmQ2dStWdVlh?=
 =?utf-8?B?d2YvUG8vRDFuM1cxbHdEV2czNUkxMDNQMkhpbDM5ZG04dk82RmVRSkx3ZEZ3?=
 =?utf-8?B?Y3hWWHNSTlp5S2cwSldQbnErOW1NTWdtbXRyVzVYWnVEanpoR0ZDNnNQWFFH?=
 =?utf-8?B?SSt2cHl6OEd0SGU4d25pN0hVZllFMmpLTVRQUlN4S0NZM243MEtYYWlNZ3VN?=
 =?utf-8?B?aU8yU01nTUNaY3ZEK1UxS1c3djJRV3ljMThlOUlsd1BmeVN3dDgvR1J4R1Mr?=
 =?utf-8?B?WENDU2V1dlNScnQ5KzFsc1Y4bmROVUxlMEFsMXQwa25LcVVKV3dVSzNqNmEr?=
 =?utf-8?B?amF5dGt5cW9Gbmh0cUZObmJ4ejJ2eWtqNGVHSE1OaUpmaUhVbkw1aDJvUm5V?=
 =?utf-8?B?VDF0MXowcGN4V3Ewalk5TklhTVI2Z0EvbVlWcnI2ZE1vaEUzMU5LOUdVazE2?=
 =?utf-8?B?R2EzMTJhV00xcUFSTE02OHRacndldndxMUFDek92ckhiNVF0a1VPbHNTclhT?=
 =?utf-8?B?ekJBZXpsSWMyb2FiaG9nL0w0Q2NtblRWMDlDNWVqZktwWXdUVlFySVhZekxN?=
 =?utf-8?B?VWNtbC95YXMrMVlSN2cvTHVCNGNUTW41NitOblRrMEFYVitVQW5ncWZId3Bv?=
 =?utf-8?B?MGlPT2sxZFVjVzY3M242bHlsNThBQk9rSzdrcXdRUmp2cGFFM2NnS1lyaWNO?=
 =?utf-8?B?ejhxWGo2QWxjOFBZb2FOTlVpVS8vcDdBaUQ0TDRhNEtnT1ZHQU0wQ2RIUjhS?=
 =?utf-8?B?VUV4YnZqU2dkZmdOSlVpNXJQU2NkMU5JZzFubzBLU211NWt4Z1BaRzFuL0Z6?=
 =?utf-8?Q?fpuYvonocQ0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0EyaThvc2k1R2pwQTM5Skt4aEdwQTlsazRUOENETjBySnZvSC9TUzdxSVJC?=
 =?utf-8?B?TWo2ejdWa1pZYnc5TDhRK0hUaFZLVHIyZ0lZYnNTVzRpeEZSVkhsYysrTlBP?=
 =?utf-8?B?SHduUFBRakJPMjNTSkJndXY3d01kb0VsNndGMER5anEyREVzaHQvVzhiVE1Y?=
 =?utf-8?B?bW1UMTgzNWtmRlBEdDh2WkluckF1Y3A5eWU2U0RyWTBkLzNCVGhKUTV6cnFD?=
 =?utf-8?B?K1haL29hY21DdC9YcHIxZWVRZm1rSXE0ODFaWUxvemRYd1Z5VUVaeExkMUVw?=
 =?utf-8?B?WEFIQmREOFpEbEhzT0RzM3ZjcmRGUVdmN3hELytRNUdQUlBRbHNyemh6M01R?=
 =?utf-8?B?YVh4OEorWEZZR0xrUXNGTzh4ajQxVUd5WmU5YkVKYXNzc3hEeTV4VjlybXpY?=
 =?utf-8?B?S0I1SUNpaGZPdTdEVkJ4NnNDQUI4cDRPVXpUUEdCSlJtS29kVHRwY0RWYzNk?=
 =?utf-8?B?VzJreDh0cTFiYlk0ejhUODN5bW5qWkZFRlc2SFZ1RnIzY0N3dFdqNzJkNVNT?=
 =?utf-8?B?TmFqcm4yY2ZJNXZhL2w2WWhuQWg2Zmt1RHp2S0k2ZWJERXIzVE1uTjcrdjNW?=
 =?utf-8?B?R2ZnMmg4WlpUbkZqU2o1MGw4eDFTUm8xdmd5NjYydVMzcWl2aU5CbUtOVVZq?=
 =?utf-8?B?NVNDMXNlRUg0UlFGdC9hWW5wNjZvWmtJVnpnM3FKQU8rQzRWUkZ5WTFWZ0cx?=
 =?utf-8?B?NkpkY293WUVtbFh0eXo2aDZKWTE4ZnREelhIR3UybUZJL1dlMlNML2laczQ3?=
 =?utf-8?B?T1VXN2tsekFzbitLSllhWEdJMWlNdGlGUUQ5Z1pHbmJxdVhCRmUzZ2RDcFVF?=
 =?utf-8?B?UGxXUjBuUGJ0dklSUFN2TTNjdjB1aHEzSkpod0VjNlJXazBTNDB4c1IxbGd3?=
 =?utf-8?B?RllZQzhhY3gyTXNxZ3UwT0tRSXExaXg0Vno1K3IvM3pRN0FkNkc4Y1R4N29R?=
 =?utf-8?B?c2dyWFRNS2w4TWxyd0VXN3EyMFp1M2cwbkRKWVVWK1JGWFIxKzNxaStNYVBP?=
 =?utf-8?B?azl1cTljWTk5OXprTGNkdTdTRGk5NFNHY2tjRXdkZU04SmRyeHdRTlR1SGFm?=
 =?utf-8?B?K0RJL0V1VTBNT0Q5OTdBSEhwNzdDTmZwcHByRE5ETy9ELzBnWVNrR1E1MWhJ?=
 =?utf-8?B?dCtmenVLMm0xSUdzLzJ3MVJkRytwOS9KcTZZWGEvUkFMOThLbmt0bUpoTWU3?=
 =?utf-8?B?RHZ3VXV6TVdFUDFYT0d0RzVnajdjdVBOQVBVbjlhakZWenB1N2pRRFhnZDlG?=
 =?utf-8?B?NmZ0aWJSRFU4YTBvbHUyclgrM3JzNWgrNDVBNkhUdXU2cVYyMDRIZUtCV0NE?=
 =?utf-8?B?ekRPT3pySEhwMnBMUmtyNUlpRGw1Z2RPUEZCZUJIeTd1M2hHTnFSRmFrL0M3?=
 =?utf-8?B?NkgzQ29BSStwMmdLZmRDa29jNERVY2duT0NYS3psZDVkOVhQZGNxeHJOK3dQ?=
 =?utf-8?B?TTlrbHdFSEllcmJ0VVFsVjlqNHJhMFkwaHRiK2kyaFJoYXBsdzlSTUJxZ08v?=
 =?utf-8?B?Q1dpYWtWc1lDUHBGQlVMUDQ2RGxJTXpyc2J0dnBpK08zM01QcWp6U204TU00?=
 =?utf-8?B?MGM4Y0JRTzR0SjhiN0ZHSG9rdWw4ZE9DRU5yNmJqZXVQak9nYXZGRFVNOFpT?=
 =?utf-8?B?Vm9RdkNSaHYrb21PQ1BneFVQY29xY09veHMzOXJnTG1uRFVmUDNJR3hDWStJ?=
 =?utf-8?B?K2Yxb0U1bzU5WndQRldZOUxNdjIyQzUvNTlrWTZKZEFFVW9ORGIrYTNGUjlh?=
 =?utf-8?B?bUlGeThnNm9OczM3b3dxTHZVcHBPV3lFM0dzSGo0OU4yYTdPNjUxZVB6ZkF1?=
 =?utf-8?B?dWQ0a1lzMEVNV3VRUE0rSlNwZ3JpYnpoVlFjUEROTUlrUUFFQXBaY0tUck15?=
 =?utf-8?B?N1BtRGZ1L20zUTFNeEpBaEoxOUcxZjVnOGhEenZ0SlphTlBhaHVNeGdxd1lF?=
 =?utf-8?B?aHppcnoyZU9DcXorcEN6RnNFMXdmai94Y1JRUFplTVp2TDZ1SmczZW4yN2s5?=
 =?utf-8?B?dVVSNW8wQWo2R0tySStJcFd5OXFGb0ZUUXJvUE02Yy9kQ3FlMWxLTDlVQmJa?=
 =?utf-8?B?aHJEVWN0VlFNaDZYeFpMTTUyWDBMaks2akRHQm9Ea0tPOFlySG40NWtMTlA0?=
 =?utf-8?Q?GqSDEtaWlw4towkQXLOY8uiXm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca5a193-67dc-43f2-20d8-08ddbf87e7c7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:00:59.0438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRlq6dKCJUD24UAbAe0XRCkjavn5GwNu8QowVyQSH0GBpMrnBZgNiKBbOq8UXmu3avxbLjni4GSZRuA38Y0fLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6289
X-OriginatorOrg: intel.com

Hi Sebastian,

On 7/10/2025 2:25 PM, Sebastian Andrzej Siewior wrote:
> On 2025-07-10 11:18:29 [+0800], Chen, Yu C wrote:
>>> [ 25.235357][ T1] dump_stack_lvl (lib/dump_stack.c:123 (discriminator 1))
>>> [ 25.235357][ T1] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53)
>>> [ 25.235357][ T1] __kvm_is_vmx_supported (arch/x86/include/asm/cpuid/api.h:74 arch/x86/include/asm/cpuid/api.h:113 arch/x86/kvm/vmx/vmx.c:2789)
>>> [ 25.235357][ T1] vmx_init (arch/x86/kvm/vmx/vmx.c:2808 arch/x86/kvm/vmx/vmx.c:8653)
>>> [ 25.235357][ T1] vt_init (arch/x86/kvm/vmx/main.c:1072)
> …
>> I took a glance at the warning, before this patch,
>> is_percpu_thread() always return true when CONFIG_SMP is not set.
>> After this patch,
>> is_percpu_thread() checks the current task's CPU affinity.
>> So debug_smp_processor_id() -> check_preemption_disabled() ->
>> is_percpu_thread() might not always return true anymore, which caused
>> the warning.
>>
>> Actually the issue is in __kvm_is_vmx_supported(), should
>> we use something like this below:
> 
> No, it should not. If you look closely you will see that the call chains
> is
>     vmx_init() -> kvm_is_vmx_supported() -> __kvm_is_vmx_supported()
> 
> There is a migrate_disable() around __kvm_is_vmx_supported(). So why
> does this warning trigger then?
> 

migrate_disable() disables the task migration between CPUs by restricting
the task's affinity, but it does not disable the preemption on single
CPUs IMO. The scope of guard(preempt)() in migrate_disable() is just
within the migrate_disable(). debug_smp_processor_id() warns when the
preemption is enabled.

Thanks,
Chenyu


