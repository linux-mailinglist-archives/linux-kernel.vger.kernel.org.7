Return-Path: <linux-kernel+bounces-725244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FAAAFFC64
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216361C8687B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CE828F95E;
	Thu, 10 Jul 2025 08:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OGfSM6+r"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4715B28DF4A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136238; cv=fail; b=nUpg0bOmrkkCc5UUD2hLyj+Txwo9RShpMcC8G0+MBVaQn2Ig9EGvQi2Zsv26MxGKqVstcpyja3qzE6YfFXBEUbxx5MgkEg03KSGhgxmCzJrCU8PuJA7Lk6FGRecbS7sbHsbkQaBGoHEURFjB5/DO0kmKXCgETYRM4hJAK5XO2mI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136238; c=relaxed/simple;
	bh=QEk3Wm9j+2niEvj9Zqx+IdG+2n39mhvNXupnvaH6Bx0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uokGtwC4G8SimyrHXIToFkdVzO8xoQS9wnzCqJBeV0IMOf3DDyvSuXosJqjl7f4rjZcBri/QY0jVVXuYYgDUyO4JQS3DcQGD35i8AUDIEw0sn12wEAeo5bwd2WNF3eGdPfnb212cO8HWIq3DR8r3y1lHlZctFTQJ3vhagQ0bMqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OGfSM6+r; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752136237; x=1783672237;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QEk3Wm9j+2niEvj9Zqx+IdG+2n39mhvNXupnvaH6Bx0=;
  b=OGfSM6+r4/TpKJ+WYKCDluyIdXxWUfQ9XuCU6wcnGdjiUbEeDxv6LulX
   iKWybcO7/ng7f1Rcjq5hnDo3cB1RrsLvbhbDsjNFWZ1dC436yZhI4MSE6
   MFF41AE+wwIf0vA8ZUO3/bOpe146wQ9VzypTS14uDXeQm993j5bOxTM+S
   6HUPOhSewjgCnFwoxRRHH6OTND8+fXt4ku1jalVIrMuQkxFAtQcEeAhYa
   J5Zr5m2DJqo5Ic8ly/IADP73Ak5YnFXmZnfk7zMM1+BWxv3HmQUEna6on
   MObRi944XyEhbQkQdciz3PHQ9gXNyWYJsYlNqIF27v8v5BcgpOOB183TA
   w==;
X-CSE-ConnectionGUID: Zlb/IaFuRh+x8pU0ZmaHuw==
X-CSE-MsgGUID: +ODM34WWSzCSAfDaRvCbTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="58215907"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="58215907"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 01:30:36 -0700
X-CSE-ConnectionGUID: jNV4qy2JQuaJFIGB445YRQ==
X-CSE-MsgGUID: IhWJ4CvvRrezoTeJpcdTqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="155431535"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 01:30:36 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 01:30:35 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 01:30:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.51)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 01:30:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXpOYh3iZf67kuwwvmzCcr77K0bThOUfNhTayKExZqngp83Vwv9xpVCPwCC7ssK2ZL0AJnz7vFtUfhFQmhEpSo+df6umxZ++18iliC4bBWSnIyUtAPeBq+DgBTw0UEVtT7x7OF4iBSAYOvy8SaibvV3in7IMtaNGzpkLD3aVrxAA+TjRufhxXi9pV91QCZAGlGJzSttkLLzdk1Vpn8l3ZfDYr2ALV1AdhaL7GKlJswh+6XKWo15YtjNT78S8LnxS7Jk0yTDAtTqEYsKtSJeAL5PrQMqMoL4F9TVJxUxb9+3hHjWNOKNd1RuL+bJWR7Iro4XRFRYskx/MBC7tGl40Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umnUwJVfZRj/J3UcJQ5hnCs25icEG95pRFJiZHxMkLE=;
 b=jZl4U55EWaxJsWoMb7BFq+R0XpUDInFJcgep4S9LPXWDL3KCMUYuLcyMDGYTNCv07o43x07fqYda01E+Eo7lXuVBXxxHDJ0nSeWq2Ytfrj2hRzOKj9Qbu2oQJr7wFxohPFVcBM14dUYTjjv+spHUAtN2V4szo2F3Dz6tcCmZH2MFMFQaJLdMgMCgAscnp2r5rs8iNbgI6VA1cuWsi+o7VhuyW8mu3Gluse/KgnA5EEKBON8L+4qnKcxj6kaIJxfDUXwWDJoaYVmT4FHB2z5o/2uVhltz5NbB9XbJpln6l4YkZQgQ0waqw8FfcX9mLHULajMZF9iNedilMyRdGmCRhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SA1PR11MB6565.namprd11.prod.outlook.com (2603:10b6:806:250::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.23; Thu, 10 Jul
 2025 08:30:04 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.8857.026; Thu, 10 Jul 2025
 08:30:04 +0000
Message-ID: <99573578-95e8-4b97-b2c8-d8229e4816e5@intel.com>
Date: Thu, 10 Jul 2025 16:29:51 +0800
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
 <292e70ed-aae5-4f52-8f85-80cba7ff301d@intel.com>
 <20250710081114.5wnABNG7@linutronix.de>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20250710081114.5wnABNG7@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SA1PR11MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: cf7ada58-18b4-4a6f-cc53-08ddbf8bf82d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?em1RRmdHS1hqZDBKZlVhWWw5ZE9XTUhwU1JPcUU4Z0ZFTWp6bG0wM1psRXRu?=
 =?utf-8?B?SCtmV0FLRSs0SVVvWE1MVzhkcDJKUjF3cll0TlB5TlhjSWdsWkgreWlVejli?=
 =?utf-8?B?b2F3UXBNZ01xa1djN0prOVk5bkx0YnF6L1M3Y2RXdEhNbG9EeWgyazdLUUU2?=
 =?utf-8?B?MGNTUHMxMWxxVXZKNXNxU1JyQ0JoeVlveUJ1dGxNNVlsTUwyNkpqMllpdkpJ?=
 =?utf-8?B?cGpTMUVMYnF2eGVVM1prUG9DcXB4OTJjaFlCUlc0ZDZzZ0tSbG5UdmtjcnlQ?=
 =?utf-8?B?K01xNXRpNVRqWDdIS2JYT0s2L3JiQWRNblVONmZMUHN4WXNFSDl0cDdybHMz?=
 =?utf-8?B?YVhEY3RmLzBOa29ob1Q2VURQN2E4N21qYmwvSitrbm9PNXRRUDRvc2k4UXFD?=
 =?utf-8?B?ejdOYXNjeDd0WnRoVGFEM1BPSENaY1NiT2VRS3ZkNEhlVndHbXJnSVo0KzBz?=
 =?utf-8?B?WGxWN2VaT0l3Zm9iL2NKQ0lKcVpDZzhKdXBXWkxqWklaZXlyU3BjTkk2elcw?=
 =?utf-8?B?S0wrNE5OQUlLM3ZtV3A0dTlsemswQXIrRnlKVVpKbk1yMEhUVW1MbUNVRXJW?=
 =?utf-8?B?QjA1NTQzRk1SaUdQSHArQ3FtZmZrSFkyK3c3V2NWM3owclVHbXVacG1rK3dE?=
 =?utf-8?B?cG1LaVdvaENQb0ZmT3pqcTlCaXZTQ2tEWDB4WERYblp3Q2lUYzJZQW4zcVJm?=
 =?utf-8?B?cld0Z0lzNDE4dWt3K0xtbjRCM2ZYRkVIL3QyWFRXVjVDVFE0cVRFZERZTjJ4?=
 =?utf-8?B?RWZSem5ybFhlbWdhbnp1eC9uZU5wc3kzSWRWWGhRUmJNbXUrVGY5Rk9wallU?=
 =?utf-8?B?blhYYVh1YVFzdlltMXRONUgzcE9LY3hxVEt1K1B5MlNEY2JjMm0wVDFSSFZD?=
 =?utf-8?B?ZGJ3dkJMRkVaVXQ0QzZPNEhaT1g1Y1VyUkxvSDJQbDBqRmlMc2FEcHZXb0xE?=
 =?utf-8?B?aHJPVTk1Y3IrRHAxdHlNOHV4cUhIaW1vSHgwL1ZEanhWTkJIN3BrVDRSRi8x?=
 =?utf-8?B?MVIvWDFsQ3dieFB3NW1FbHZqZ3hwaG40VC8wU2h5OUh6NWJnU0R3YWVyQmZG?=
 =?utf-8?B?L0lMK1loRnlZTVpFL1YvcUt6Z0VpTVJyUzZsQXhOSzhpR0p6SWc2RUVQTzEw?=
 =?utf-8?B?Wmt0bDJ1SVZEZEdlbmgrRzJzS1BOTlhxL2l3Rm9WMHhONDJNOWtIaXBTMmpq?=
 =?utf-8?B?RHlFRVppajRZYXY0OWlHYTFNTExYZ2psMEhtTC9xSFJMM2MrVWcrbjFxSHFM?=
 =?utf-8?B?a1Frc3JJU0dPRmFaV0EyeDM2T1VlWlI2dU00ZG9Ya1VGWG12TXpONE5rSER0?=
 =?utf-8?B?bWlWbCtRMDZWMG1lWldiWW5iZ2lNUGZZbmZROG1oaVJYL2g2UVJpNGwvZFhG?=
 =?utf-8?B?THpQeEkzQm1SK0RzRXpUQVY0ZmliUGg3dklIRUtwaEFLa2ZXZ1J4WktWdDNL?=
 =?utf-8?B?a3o4S1g1V0N1Nnh6RmcwYUtmYjd5a2NFVHA1eXVoOGJsK1BxeEZIZEt2b3Zq?=
 =?utf-8?B?bDFGc24zQWNoUks4RkVCQlNncXdLeGtnV0ViSFhQbjV6aU9LakNBc2I5QW1m?=
 =?utf-8?B?bWhFdGNTTlM0ck1MM3VXWTZlNVczOWVFa2t4ejhIQlBOVUIxNTRNTUd3dDI4?=
 =?utf-8?B?R3NVcHFKbVpKU0NCNGZrOGVpa2JHeXBxMlZETDFUK01JU0pUQlh4UW5uMHF5?=
 =?utf-8?B?RFNJN0srU0k3QlhJMkhiamVrdWtVYkIrYysza0k0R2pIRlNEaHU4WDIvLzNa?=
 =?utf-8?B?b05uTEFXYzJNSUxlY0ZLMEJBUWRtd3c2aFRuSW9VajZXK1NIOG9iZ2RDOHlu?=
 =?utf-8?B?bFpPUld0WWNDQmRpK2hMOExYbi9pTXZwUk1lMlN4N1NIQ21Ob2lBMkZ0RkZT?=
 =?utf-8?B?TVg1TUtXS0kxbk5yenBxZEw1L1ptMkNkblY0Tkdkd3lON0Y1UTllTjBobHJW?=
 =?utf-8?Q?3To/Eil4sWo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WStBMTBXMkFPK3lOeXFJeTNEbVJ3eGtUaUIzbTZVYkVFT2VsaWVBY1FTUTIr?=
 =?utf-8?B?MHpKSHdNdmpIY2VoQmcxalhheTc5RVFDc2R6S0x3d0J0VVV6bzBEWGVQNlZu?=
 =?utf-8?B?ZXJ4UTJxMjB1SEw3T1JCWUtFWmk5UFZueEJNOThwSHBrYWsyWmpBUEhEeTMx?=
 =?utf-8?B?WisvZGtoWDdRSnVaQ0pVVFhSSS8yM204VllqcGl1clI4VDk5WlVadFdPRmJQ?=
 =?utf-8?B?WXNSUUNyZCs5TmxhQ0xNM0MrSzhRUW5MTEdNSWNTYUw1eU1oWVJ2bnNPSTRN?=
 =?utf-8?B?b3VURHhiYmdPb1hRZmlXZXVhVEpaRllLd3BueVpYQnBMWWJDdkg1SmovbkFq?=
 =?utf-8?B?T1dnUytra0h3Z1RCZ1ltNmRxd0F2ZXkzZU0wNmdNbXBsMEdiNUlhN0F6emhZ?=
 =?utf-8?B?OGJuelM3S29QWnd2Yi9qaCs1UGs2c09kSkdjMHBTdkJsM2FpY1NrbkRCNjNq?=
 =?utf-8?B?NjE3Tlg0a0N2MFNYeDJOODhSMWF1eTgzMG5yZTM2Yk5uSFhoOUw5aXZMSmZ6?=
 =?utf-8?B?aUNvUjNleE0wTTF6N1VIWVJud2x3b0QwVFBYUi9nVC9nQm9vUTVVNlpTSDF4?=
 =?utf-8?B?cHJMSEtjUHlYck9TRmpXeXFwV0wxWFVKeFVIUDBJRkE2cU9QdVFEKzlTMDdQ?=
 =?utf-8?B?T0RFSXBTQzdIeElWL2JnZ2NFb1RGdENUaHAvOXY2MXBaUHAvV3FvdHhtcGky?=
 =?utf-8?B?K0J3ZFU5WGQrVTFPeDl5dy9Na3NBSVlwMktHbGs4R1dzNGdmY3pueHhDSFBn?=
 =?utf-8?B?YjFZRUE0UEpXcWJJNmNxUVVOWVlQU2lFODlhZmlVZ0pmZ1RiUVNyT21CK0Q2?=
 =?utf-8?B?SEMvK0dNTnF2RXNNcmZzWUV5dURsVkJ3dTluZXE0SlBiSlZhdWRqb25rcmpR?=
 =?utf-8?B?VEtaeW91bmVob2ZoYmcrYUpXeW5HWS9MQ3kvUjlLQ0djNzMydlpSaGhRZElD?=
 =?utf-8?B?TkorcUV2UFhXMzJra3FVUXdDQlhtRkdBZ2dLa01ydk5oS05Lcy83R21iU3BM?=
 =?utf-8?B?N1VMK041d2xaUEVKclVvMzBIcktoamZjWHRPK2RuaHYxTk1jbzRsUlgwdDU4?=
 =?utf-8?B?eTJETEpNRE95VDY1NzR1NHV0Ryt6RVBpVUJ5Wm8vWWIxb0dmbXAvTFpaRzhk?=
 =?utf-8?B?cXZVUUFXMlAzUXB6ZE1MOExIc0cxd09manJiMmhkenk4Y1kyRFdoMmhUTlNw?=
 =?utf-8?B?UWJkRW44N3pEdlJzWk1BdTZLSWNUaFZQUmtKQlErTGJDOExPN0lTZkpLN0xo?=
 =?utf-8?B?UHpkUytZeVBFQTNxQWloOXNXZlB5K2RWUmhyVmNXdUNlZ2p3SHFIVStodVFC?=
 =?utf-8?B?RTdUdEI1czVDVGs0RFM2NUF2c2VEdHN4TjMzaUFmOHRBVWpqMzZVQ1FPZnFL?=
 =?utf-8?B?RnF3cExYUjBaeGVQSi9xU3ZsNDM2V1ZHekI4TUNjc3Fza09HNzRLVjBRalQ5?=
 =?utf-8?B?aW5aaTl2MEZTUjNnZlZmMFRYd3FteHJzcjQ3bUsyWmtTd2lyOGs5TzdTSlVk?=
 =?utf-8?B?d3VqeVA0RWZnak8yMGdYSENzSmlYVS9MSllldEZQcXBNZGd2elI4dFlhYmNx?=
 =?utf-8?B?UWZ6SkRHVldETFF0SFg3RWFULzFkMjkyM2NSZCtobDBZNjJqOHpBV1IvVVJ4?=
 =?utf-8?B?YnhabU1qUVFZd0ZmVGt0ZGMxc00ySjczUFZEZDM4YUhCdFYxek43ekEwRHZD?=
 =?utf-8?B?NU5hVCsxRFljd1htdERIVUZOWm5pc3h3Yi8zaUhRRm1yRFFZY1F0Sk1ZZE5Q?=
 =?utf-8?B?UVFkMlR4QnZsK0Y5ZnIrNXdNYXFKMWNpVmI4V0htMkNHQ2JLNGE4QWVWMGwv?=
 =?utf-8?B?aDRqeGFycXFVcndlOUVjMVJtdWViMnZKWERXb1dUVEFjQkJQK0UxVmRwcEwz?=
 =?utf-8?B?aHJJdDM1YlR3QUFXTlVJSEY0V2tWZXhwb1RlWDFyY2FESmlsdm9hQy9IT1ha?=
 =?utf-8?B?eXVCZlcrdXlMZE0zZitIZnp3WVJWaDVaRE54SU0wSDcrN1FhMW5CeU95YXhD?=
 =?utf-8?B?T3pmNDJjMlZDUExhWUlvd3A4c3FRUXRLNzVIdC9BbEE0MUFLU01JNDJoa2Qw?=
 =?utf-8?B?d0NPRmNzd00wZ2tXYmo1bUQwSWFxWEJ5SHFpQ0l4eWFGS0IzSEE4TzY3UWxU?=
 =?utf-8?Q?Cys7f1uRBS6gLQjGBOtiP4tfC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7ada58-18b4-4a6f-cc53-08ddbf8bf82d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:30:04.6402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHq0dsonng2em+72eFeRLB1eda4wMExIk3YNnKGdA2CtCLYZ2mg+QdPY3hHoCHzHcaAHSps//Fk+skvBwjJ1zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6565
X-OriginatorOrg: intel.com

On 7/10/2025 4:11 PM, Sebastian Andrzej Siewior wrote:
> On 2025-07-10 16:00:46 [+0800], Chen, Yu C wrote:
>> migrate_disable() disables the task migration between CPUs by restricting
>> the task's affinity, but it does not disable the preemption on single
>> CPUs IMO. The scope of guard(preempt)() in migrate_disable() is just
>> within the migrate_disable(). debug_smp_processor_id() warns when the
>> preemption is enabled.
> 
> does migrate_disable() really have no effect on
> debug_smp_processor_id()?
> 

I see. So there is still a CONFIG_SMP to check migrate_disbled
in debug_smp_processor_id(), and that was skipped if we do not
have CONFIG_SMP set.


thanks,
Chenyu>> Thanks,
>> Chenyu
> Sebastian

