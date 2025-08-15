Return-Path: <linux-kernel+bounces-771175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DB9B283D3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75AFB1CE68A7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57479307AE7;
	Fri, 15 Aug 2025 16:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bZn59bC1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51C31F582A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755275528; cv=fail; b=qXmYUAvDa0wFS+fFAklyAcBtBJ/hidoxTQ7bKDteYzVkEPfadvBQXo9bJNYC18LN0Zs3a83KPMKbxD0I26fmuxq+DVmMxQUjV1NnhJ3r+SOrZuRQD5bDPLQs09lW0ylej9PDjYprPjPiwI55QWOLQ7Psgd8xToqF+ep0IYKJ4qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755275528; c=relaxed/simple;
	bh=vhL1vj7RLoXaC+mGE4a6cS+A4xHON0q8mG9o12R7t60=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e8iNDtrvsW8lfR51UXpZPl1tfnamcWWvt6naeFK/gRm2tmBifgSurnZ6BXtXMip49S41Zq/0sSuHOvHJnHKwe+ZR5H1zHOO/XDxHkL7ZZyu/f4kd3tLzro8WoFMFiLwsMeypDgFKiPxd7JGRuUscTPNQaMO6Npl5t74EMJDyHJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bZn59bC1; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755275528; x=1786811528;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vhL1vj7RLoXaC+mGE4a6cS+A4xHON0q8mG9o12R7t60=;
  b=bZn59bC18YoleZIdrjwgOc46qE/ZopNC2h3mfGxbTojkLIrScAmvGTgd
   xMkYk8YOgT5jl0jP95dbr6N1HIz3LUNVBhZmv2TKtt9uOHoNQ8B4pWiYA
   OrYX97FzOOIxpDTLyAQ/TL+9OBEmCMXVBukDH6eeCyjwmbVIW3nZAtFEC
   xQfvadURG1xkZFK8gGHMWS1U2qZYxiqWiew6kl2gCpTScX9hPIo57NR0K
   9Iij9lRzl8ZOiuofbVa8NrLEP0yxK/ylVR4kz7TbgZlP7pJ7jB+l5opJ/
   kRmiN2uynwhd2VfWb6sQk4aNhN7qBuVD9Si4rdunB/R5Iey7r8OxW0O4M
   A==;
X-CSE-ConnectionGUID: jR3zqCcOQAiKO4oknxWFYA==
X-CSE-MsgGUID: SjNmNISKSKulKw7Iw9ccGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="61231084"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="61231084"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 09:32:07 -0700
X-CSE-ConnectionGUID: 7pBX5Tq9Rcu9PxO+7r/tgg==
X-CSE-MsgGUID: 6FHrtUaeSIKbGYOpgtdFbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166231335"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 09:32:06 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 09:32:05 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 15 Aug 2025 09:32:05 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.52)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 09:32:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKGtNhs/Ccrz4LL2U5UJbXiPngHrIM0nFD7fjDzlNpTvNn82sDByMHRYZ8N2DqqOZVyQAW6Re6gfww0y2r1QAugYNoE7z9ggavRXQjzv5VJJ+0s3/Ac0NyL4NiIJydxa7d2rNlAsK7XikQ/kiGhLp5QZ4xJuQp1Ta/z7mmWttDXUnYDcTxifTWCTuF8y7hjBLx/9F5mfi4rU3UtZblLevWRtztsqiEU0MT/WaJEUCAleST9J+d3BJIif18rvH1gYFxT6wB76OMSLJxgX2Row8Krn7hbku+DBwqLWpV480ox/ZhefRe98uEz63wYU/Gv5bwIUq03L1u18qoQde6h7Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjof/ZfQ8LwM7bAyzmnWaT5iN5wq9i3R08WAyLHCnEk=;
 b=bWuj10qki+Evzjn4Z2gnGD0sA0feDsjRXxB9682wRc6P3u7LMImKXm9a353Tv8IDXfOhGOZj9NTkKkU9jsdaghUQJxQaB+Pq80mIUT3Ve8bRk5vCe4HBlsTMWTZiO36GCCU8Ljb+/RfVGuLrNjKHlwEWPGIn+PYxPytrzZuIYWGbMXR+sffJ7Of4EaO/+L83DVmOqHJDgkJx4t75az9d1M3/RoHBUySkfSVZS3J7MF6TeL1bLqmWlAfkuckbeY0R3WcCyCptlPkM9sD8aRoNrD2QDday1D+STjrxfyBXkhfE8wBDYxlHJ6GuQCZHD1u8igExTpk5w+WnfH4Cgdpktg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by DM3PPFEF920636F.namprd11.prod.outlook.com (2603:10b6:f:fc00::f5d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 16:32:03 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%6]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 16:32:03 +0000
Message-ID: <f8aaa8a3-e4aa-4958-a147-9a40385ebd8d@intel.com>
Date: Fri, 15 Aug 2025 09:32:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] x86/fpu: don't abuse x86_task_fpu(PF_USER_WORKER) in
 .regset_get() paths
Content-Language: en-US
To: Oleg Nesterov <oleg@redhat.com>, Dave Hansen <dave.hansen@intel.com>
CC: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>, Mark Brown
	<broonie@kernel.org>
References: <20250814101340.GA17288@redhat.com>
 <20250815155220.GA3702@redhat.com>
 <d74b6f8b-2662-47f4-8221-2d2e6e7fe580@intel.com>
 <20250815160244.GI11549@redhat.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250815160244.GI11549@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:a03:100::14) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|DM3PPFEF920636F:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b9d9203-c7d9-4275-1aa8-08dddc19440d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K01EazNrRHRVUUVuM1UzTjVHOGkwK2orSlArclFPaWUydTlMU092eHZLV0VX?=
 =?utf-8?B?eHU2MDFrM1p6cDVsOUhVQWZIc1ZDa09ic0p6Z2RWTlJ5WHdkQTNPNFpuTDVT?=
 =?utf-8?B?cmFKck1yRzFJUkV4UE9jWk45bXgxQzF3YVVNdGwvNWs1Y3hMOUkvQmNJSGJC?=
 =?utf-8?B?b0Y5bVlZUC9XSkMxajJIVW5ESG9mN3dLc2dqdHArNEdnZEZ3cWJaMnJlUlNF?=
 =?utf-8?B?UkZ2SDFVQlpQVjFDdDZMY2I0cFVZa3BOU0VNVWJBS0U1aCtZSDdjMHhvQ0dG?=
 =?utf-8?B?RHJ0UTRBMEtBL05ZQXU2VDdqSGx2RzYwZWhnZjUvM1gvQVJ2WGUvaTgyNWdt?=
 =?utf-8?B?MW5BeUpEYWFZZHlZN3E2UFZVelcvc0IrTzlLUTdWUFhFNzVDYlo4cERkQ2Za?=
 =?utf-8?B?bEpGSDdqWCtGT1ozM0RTYXVGUVVxSjBVTUJGYVpsU0I4WldzZEF3N1VORUZC?=
 =?utf-8?B?QmY2dlo0NkZEdVBkRjhwbjJpWFc5Nkp5WXV5UC9sY2t6czhTaTQ3SC9vc1BG?=
 =?utf-8?B?ZjdpTTYvZjdYSG84WnVYSVlWaEpQenhBYzRxaUtDVlZJN3pLK0JPa0ROTDEz?=
 =?utf-8?B?QnhRbHRHa0h3NWYwT2g0cGY4WDJjc0E5Mi8wMmJSbGZIZU84NzcvRCsxdlBm?=
 =?utf-8?B?UjhWaVB4Y3ZYT3Q1bkx4bk1ZaDFNMTMwdVlQdVY1TnA1bzd4TjBKYnJuMU5n?=
 =?utf-8?B?cHZkZDFCRlNEYjR6Si9yTWNaOG8zOHB1RkN6TThDQlVpQ3NFdHc4QWNsWW1n?=
 =?utf-8?B?aTVXWE4zVlUzaDdES28xSE0vUjQ0M0JoZkRJc0dBT1B0d0tDa1ZwSGFaaEZX?=
 =?utf-8?B?MU8xQlVwYnlrRkVuSGkvMVBQMnVvcEYwakZSUVptaktvTmZtZjR0MFAwK3h4?=
 =?utf-8?B?dk9YZmtQbG9zQWZrWFlCb0djWTNmWWcwZnZ4ZVdISENGejE3bisrWEx2b2lS?=
 =?utf-8?B?d0ZSUnlQcE9TY0NJSnJkdmV6Wll5eHIrenNJYVB3c2k1MS9NdytXWllhUHF4?=
 =?utf-8?B?MHdhMjg1QytCTFpVRkNMWW1HUjRzK3dJNVg4UzlobGY4K0RiNmxYd0xmdTB0?=
 =?utf-8?B?d1p5UHIyMEdOQTh6VUxaV01qWnd0dUVPYmJGVUkxS0ZMb28zdjZkRTJrdDA4?=
 =?utf-8?B?NzY1M0lVY2FFQW10cWdmTU00K0lvWjdhRXhiZ0ZkbStrUEYrRWp0K0xhdUha?=
 =?utf-8?B?allLL0hxN0NoWUhzL0s1VkpDekJBakJ4Y0lOSUJoc2FFK0JtQlBibWg2ZUUz?=
 =?utf-8?B?Wk5uUjlBc1c4QlJYMjBsVGM3UXU0WmowS2djSW9QRUdVSWhvaExNOEVlaDUv?=
 =?utf-8?B?bzhLdXJ2em1RSWg2SnEvSURoL2ZtSURDREtLTVJpYWdhQ0Y0RFdNNEp5Snpn?=
 =?utf-8?B?cEQvSG93bmowMWdSNGVna29qV3Y4V3hGbTQrNFpQN0tzaHJyZUUwSnkxd3JY?=
 =?utf-8?B?ckFwSldTV1pzNHNVa0VTYS96eEtMNnFjMHdiNlNjMG04ZkZFalNrcGh4Q3JB?=
 =?utf-8?B?WUhTVG5JRENqZEJwNC9MV2xvQnd1Z2NwRkNhbUdCdWlOdDBxSFBNUUg4dENQ?=
 =?utf-8?B?ZUQrQmdWU050emkrYnN3Snh2Nk0vSnVXWmIzM1hDNXJVdlg1TjR2aFJNTk9n?=
 =?utf-8?B?ZlptWS85TWkxdXEwUU5BVmk1a24vYm5Sdm9rTWpBMEVwZVorSW5ra1B5VWh0?=
 =?utf-8?B?UEhRaThhSGlsYUNzOUF2SjBORDF0YkNhbTFFWThOSVhyYmMyWmxIVEc0RlIz?=
 =?utf-8?B?YUdVWU91TndRaWcxbEdYTC9uU2kxK0RHbGpOdTIrZEpZMUVlemZtY1NaU2Fv?=
 =?utf-8?B?UVYxQlRTSHFMZDdkdVlKb0F1aW5YdGRZZ25rb2QyS0ZEeU50Tm96VmFrdTRH?=
 =?utf-8?B?RkxKWnFFckNlclNHOExlRDJRMVFJZXFEMVlXT2d1MWM5Nm5TajZxQWlSUzU0?=
 =?utf-8?Q?JMo8A9cuaAg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bThhdUFrWHlxdDhoS1lwa3J4dkp0M1owbkErRnlzTzkyeWxDR3FMV1NFaWEz?=
 =?utf-8?B?ZEFwaW5Zc3JaT0Q4em03YlVobjlnRVBoS3ZlMjZBQmtUV3dBU2xaSFVnMnl1?=
 =?utf-8?B?Qy9qS09xbmpYR0lLVGduOEZVTjhVbGI1OExhYTJQeE5GVjB3QnF6OC9PS3NN?=
 =?utf-8?B?MFRHWDd5cHBnaFlJa0dCSnc4TXhGLzZTWm5kMWhuam4rcDZvTTVjWDV1MFNP?=
 =?utf-8?B?c2FCTVp1QmVrZnIxUThEVUxjeUJ1UW5ORlMzeWRmTkRkL29URUc1aHN2Z0x2?=
 =?utf-8?B?R0M3bHJLK3RUbDVEcGVCamV1SEhkRmJMdXhKSzRtUU4yK2tlTnZzTURwY3oz?=
 =?utf-8?B?TTJEWjFlc3JKOVVMb1VyUHRxN0ROTXRpM09tSi92Tm8rMWg0ejBKclFVVjRT?=
 =?utf-8?B?NmJsaDdiNUZKZFgycDF5V0tySDhZN3h3VitKa3Z3WXY5eTROR0FEMXBwZTYz?=
 =?utf-8?B?UUlkdzRyVC90WXFaU3J6V1FaR1dGME9ZTk05U0dobVVOc3A0bW12YUw1UjJ3?=
 =?utf-8?B?WFVJVmdlRFNEc2lXdDQ3NVlQOU5zWWl5S0RIKzVHQ255RnFpdzIzY1R1Vmo0?=
 =?utf-8?B?QW9KTStFMGRmZWdwVXJLWlNIbHo3QVhhWUtnZTBjT05ONzZudXNqckVLcGp4?=
 =?utf-8?B?bk84dG1pQVFIR0k4UnhQVDhaOWFvZHZtNFhuc3JlTFJjNEFjZkpPMGszYzM0?=
 =?utf-8?B?ZzEyeWppaUovNFNQZFhtZ0s1eFRtTW1tbFR4MTFVWDNQeUVSdGJKUytSa2ly?=
 =?utf-8?B?cFFTL0huRXdLdHZIWllUZHEvSXpVQ2RiRTduc0krWlpPZFU3T2NIWFl1dnBj?=
 =?utf-8?B?Sk4yeWlNUTI5cUZaVUI0NFJOQldRN1oyY2NNUnVJRHM1UHprK2JMNUZOUzRk?=
 =?utf-8?B?STJ3bjFtaEs1am05Z1h3NTZnN1Z4dDUwN0diWjhtNk9meFdFTFAxZXNwOTIw?=
 =?utf-8?B?SHJ3Q1MvelVoUldLM1pkV2xYdmVBSG1mUGJpVVNIWlJIM0tJbktObXNyc1Y2?=
 =?utf-8?B?V2l4YWVBQytZVzN2MzFJNnYvMzRCcHpudUtibCt0VlVHRElpdjBJKzVpZmVz?=
 =?utf-8?B?SEcycFRaazZ1d3NhUGp1MC9nQnZPS2o4bStQRmVGUSsrdllLQVNoQzNXWmVn?=
 =?utf-8?B?VzgzUUtkYjlkK3I2WTBGUWo5NTJDazVFRHIxbWtoMEtaU2lvVFJsaktEVEN3?=
 =?utf-8?B?NGVHM0dTZW9SSGdjaThKbFNJTVVJRUJzcUh1RnpVQjB4a3RzRDZIQ0ZkR1hp?=
 =?utf-8?B?RnRRWkp4NnR3cGMvaXBpZnI1SUNPQlovb3NuYTJOb1dIQUl0VFp1UVdTYzRt?=
 =?utf-8?B?WTdJVlhTQU5IVGlTdVlqcHB4VGtZQXZURXk2Z3pwcGxwN1VzRStuZUZOMjUv?=
 =?utf-8?B?Yk9uUWhpUFgvMWRBZW9va1kvTnE4d0ExeVdPam1NaXgyU2s0NXN4ZTk4bnNG?=
 =?utf-8?B?d1ZybHllUGNiVVh5WVdFUHFETlZROGZ3d3Z3TFcyMngyS0xCOEpna3V1Vjgz?=
 =?utf-8?B?TEd0aDBSRFJKU0ZIb2ljcWVkNnV6YWM1TmxQZlZUaWN2T1hvdS9oSUE3d3kz?=
 =?utf-8?B?MlBzZzZRbXp2Mk93SjRhMXFhbC9JSm15UzFaVHVGMVdDbS8zWkJwSmNndVpN?=
 =?utf-8?B?ZElSYndmZWtsSkVnUXNzSjZrbmNGWXVVZUVmbjVIaEhJVHZKU0hvVVgwZ3h5?=
 =?utf-8?B?eUVWVkIzYnBYQTBBbXd3Y0ZWelgwcW41Z3ZxT3hGQ0xwOFVHMmxDUm1oUDB4?=
 =?utf-8?B?V1l5dXQzSklhVDBIdzdEQVArc1lCQys2c25pYW9YR2RiZGdpT1hvbWdkOXRs?=
 =?utf-8?B?MVdtQ0VaUE5zM05nZkhSZTNzRXhLSFRiYTE1dHUvMjNHbUZTVWdMdTlkM2RC?=
 =?utf-8?B?cjRCOC9CMmtqejU4RmdZQXc1aXpoeHN5YW11VU9GWUxBbk5nMkxYaW1lWkZX?=
 =?utf-8?B?NUIzU2VYSkpGamhuQ1JLaCt3eGRlVnQ1eVdoZ3VKR2F2dXhad0pQQVFCNmov?=
 =?utf-8?B?LzYwRldDWDl4Q1dZcG41Y1pDeFlGWU92VnhoZXJQaGtvZHZ1c0lOa1JJYnFq?=
 =?utf-8?B?TS9PUENuUW02QUtwNDkxcFA0c1BiMmpLUzQvbllHWENkNkx3eDNMSm1WVStH?=
 =?utf-8?Q?LXo1bpEKsPfRQLFz54cxH9Csi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9d9203-c7d9-4275-1aa8-08dddc19440d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 16:32:03.2380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BfqIncI1y/gkT2kDy8P5c6ZhyyyNYxOmVwGqdHaQvJCoEOb2gBlyBdJwWzKYLJWZuzRqj3+5MfuD8TOeNhQx4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFEF920636F
X-OriginatorOrg: intel.com

On 8/15/2025 9:02 AM, Oleg Nesterov wrote:
>>> Dave, Sohil, what do you think?

Thank you for doing this series.

I think it would be useful to categorize the impact of the "abuse" in
the cover letter. Is it going to cause kernel crashes, userspace crashes
or just incorrect reporting?

Are there any "must do" fixes that need to be backported in comparison
with the "good to have" optimizations? I am wondering if it might be
possible to structure the series that way to make the separation clear.


> I agree about the cover letter, but what else do you think the changelog
> in 1/6 could say? ;)
> 

For folks like me who are barely familiar with the FPU code, some
additional context or reasoning would be surely be useful.

For example, I don't know why PKRU needs to be passed separately. I know
there is some history there but a line or two in the changelog might help.



