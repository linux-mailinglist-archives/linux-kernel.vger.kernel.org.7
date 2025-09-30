Return-Path: <linux-kernel+bounces-837565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97125BAC9FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BCFD3A6449
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565C41DD9AD;
	Tue, 30 Sep 2025 11:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VQ5OuPNK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9C111CAF;
	Tue, 30 Sep 2025 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759230152; cv=fail; b=WY7eKNrGiVovo2BQ+zIGMD3s9cU1cjpAW7T1vhX32mnxbx2Yhqal7CmmthwMHOhrvgb9VZzX0rW5BF6MquqR+7hjd55oZ8dta6cZoue4JMFTmIpVHZ47DUiOUFsCcxvO+AO1Qn8sQCj5hLIKdFMNyA7gVcnbYAcACUss7bl3VVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759230152; c=relaxed/simple;
	bh=g6j3gdo0y5iI9wbWU/P4THfrPHd2WHYJoKMAMPS5mJ8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MDVD3CPJNiZkzRvaKVRUIKYI3DalWoU9aNj0r7LmcG8o9MN+bB5akI/Pihtgp0riCt7pAOC+2dEzPFa3LkfqG/04rvboYEkppmb4o2irfo3aTHYQpBN1jB1gMa9/UV2MNWnbBEkOFe7WqG4kL8N2eNtN28daQ7/1Dtu+BWRPaWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VQ5OuPNK; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759230150; x=1790766150;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g6j3gdo0y5iI9wbWU/P4THfrPHd2WHYJoKMAMPS5mJ8=;
  b=VQ5OuPNK3QzSI1oWY7ihZJAqQeFBRPi0uGLXvz0prbs2bS6t0N2vwF/s
   ne06R8YF3y/yEKAFuFjDkPmH/6+5mrr5R6T5fGGb0/QHLDYhy1HBwYa/1
   qZ911Hgy2eIjnOEn7jmt8Mv9d2IM2kprclJuBFa2tFDvn2hu6qyIiWFai
   upe6ZpuK67nrqmeNMzyLC0cp+4dYzvIDj8vkHa8CaI+UedWBTGbNPBt+8
   6ULqPQ1a1ERmEdt9Po4jAgjwCYQfXamn1pthpDl7QDNmBs9YKU4fbrLeK
   RnjBUowRq091zVw1iZHv2NhZbqxXPMgAATP0eQtyjp0dv2htkIPNGZJQg
   w==;
X-CSE-ConnectionGUID: QRZJbAqkR4WCGXt0qHYieA==
X-CSE-MsgGUID: PYVIOfNbSkitJGh/P4oipA==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="61399616"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="61399616"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 04:02:30 -0700
X-CSE-ConnectionGUID: cUrrY1bHQHuowS0bQfRtKA==
X-CSE-MsgGUID: 3ZZoxJwRTfSvYMPuT+UZQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="178287074"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 04:02:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 04:02:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 30 Sep 2025 04:02:28 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.16) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 04:02:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYgZ7zKTo83tChBq1FG2xXtrZakx0afSLxf8CNpy8DMRWSj/e5PALl5QgDw5oF9Ylp8PE1ADbjFXXNo1x0M39/oiCW+68/s9SPCO02/NhASm6ABkSqgI89rl/cmjBOKQZOXdLvtatstl0JLtJjFKukWrZDVVmxAydDIaDtlcKF/yXQX0wU5fnQDq5wfV2PVcj5g2d22v7dgt5if6Go9X6eav4UqOuk+s6o20Yw81MBj4wt0oTbzddG0RoqkVPEmIGupFQN0kWRgFkbtNYDHeOVpy6X0tPtD/lfBcgOQpz+aKx9DY0iSvbLgxMx8443WQheUi4/fLLaIQ3aBOdC/s+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZ9bPhbnv1tdGLPmqUcBMMRcUvMSiz5S2AoK0qQ1QK4=;
 b=hWm9NNoWBpKdOBucuP3Y+UwcZFd9xd2LC4HsE/Y2MXDHY5q7OvIbUy9fL6khWnH63WQKabBZhyY2oizNTNWctBqmSHpXuauOekKfekpXyeJShPVtaqLgRTcE00SU83XaHMMwGxDfxM8hPVjAw0Y3md0/Jw1NT6xoz4OzvySZtUWvRRyVRmWR8Fnl7qEqZ9kgLEhoGCFtzoEEvws0Lj0GComeZrafr3N9CBDKYffV8Dh55N5Sd3KirYxiqbZeUaYBbuEjtwgIMZnu4MiGF7gE7tcPlCgmcXmwzCpFIUofpB+U8I7Zlbu6RXfPPchJv9LenRFr4PxxobPakRibMO7j0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CH0PR11MB5251.namprd11.prod.outlook.com (2603:10b6:610:e2::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.17; Tue, 30 Sep 2025 11:02:17 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9160.017; Tue, 30 Sep 2025
 11:02:17 +0000
Message-ID: <4ffceb95-0e5e-42d6-bbc3-a2cb8a3fd65a@intel.com>
Date: Tue, 30 Sep 2025 19:02:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
To: "Luck, Tony" <tony.luck@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, James Morse <james.morse@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	"x86@kernel.org" <x86@kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, Dave Martin <Dave.Martin@arm.com>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <aNFliMZTTUiXyZzd@e133380.arm.com> <aNXJGw9r_k3BB4Xk@agluck-desk3>
 <02647276-dea2-47b5-a271-7f02666e0492@intel.com>
 <aNqUACFbXHjURWir@e133380.arm.com>
 <SJ1PR11MB60838E8CBD68B962380BBA60FC1BA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <SJ1PR11MB60838E8CBD68B962380BBA60FC1BA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0028.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:5::8)
 To PH7PR11MB6005.namprd11.prod.outlook.com (2603:10b6:510:1e0::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CH0PR11MB5251:EE_
X-MS-Office365-Filtering-Correlation-Id: 0112b296-2d4b-4562-57f3-08de0010d12d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1I0WGxkMDYrOTh5SVVsRUMvVmZrU2p4bDV4U05FLzFaZHAzNWZVcE9GYncr?=
 =?utf-8?B?OUh0dTVHQ3doMnovdVFDTytyY0xJUGM4M2ZtWUhCRzkzbERhbEd4d0ljZFQy?=
 =?utf-8?B?WnBwZnJGZVpLbHVhUnZLMXRpN3NQd2VvUDR5a21KdVlGSGJVd0MzVEtTM0NO?=
 =?utf-8?B?V2REaXhRS2xid2ZsekJ6eXhZdFZyL3pPc1E2NisyTExkbG9rMUU3UG52bTda?=
 =?utf-8?B?UjhSTlFjY0k5QkFyRXJPdFN2dzhvckVlTzZaQWw5T0p2ZGpIY2tvNVlwMkl3?=
 =?utf-8?B?RTFPTEVXajUzZHJpdm5Za0dXS2d2T0dya2tzdDR6aU91eVNKUjhubjVGRVB4?=
 =?utf-8?B?VWJtbWlZcDFUb3UvazM1Yy9RVjJLMTErNTA5SHJ6UUw1dlp4M00rU09scDlR?=
 =?utf-8?B?Vzl3RGx6bDBVekRuZEFBSDlLM3RQbnlRUXpJSmtGK2RaT2YwMTlHM1FJbFpy?=
 =?utf-8?B?VFRTKzQ3d3BWc1FoZWhqTFFJR3Bka1BoYmdKaFdsRnJXR1lEeU9UZy93MnhV?=
 =?utf-8?B?dnpNVlUxaThEUlMyTGIvZW1XYmFqQlIxeDJOMG5qNnN6Uk5DQmRzaGpxaGMr?=
 =?utf-8?B?eGdLUmMvcHkzbzVRWE1JUk9oaHg4OVY3ZWFscTViRXdrc1ZBZ09wZ2piNDlw?=
 =?utf-8?B?U2o5aUt2T2t6bHNZRlZxNStzS2RhZnJSbUxOT3Y4RVk1R2pkWENsY0dySVgr?=
 =?utf-8?B?ck5HVXdhRDhiY3ZiVXhhUWM3L0xiZmtoS2NnbUpuS2hoY1l3VnlaK0dheHpL?=
 =?utf-8?B?RUc5Vmh1NjVaZzRqTWxQMFBXTlNSdktwbmU2WDg1SFBnd3JuMWpEczNnaWpF?=
 =?utf-8?B?Z2krY2V0MnQ2L0wvWW1JOEZqQmtHeENVUHlnT0lpMys2Skk0aUVReUhCSzg3?=
 =?utf-8?B?d3NBSmpmeGJ4bFJPRG16OTdDZUlxU2Z5aGFsbEtwbDJQN1gwT0duemxUUVcx?=
 =?utf-8?B?YWJIc1R3UzB5bnhnSWMyVGN4YjE0VnBva3FjL1dPQjNjUklKWlh6azAyMExG?=
 =?utf-8?B?d2VRU3drUkY2WHJMaUN3MERBVkhMRFRBQVhvV3pJbUZmbXdQb09PWmJZWXV6?=
 =?utf-8?B?c1B0QlAyVmZSR2Nld1laaEM4NHQ0UGRydElhaUdCNkFqS1VUOGJPZGRqZmZo?=
 =?utf-8?B?bWxVUVNwMHVBNFBoVXI2UHlwTlVaQ1hJYXYyMG9icGRrbUNGMTdMaVNGMlo4?=
 =?utf-8?B?VGdNT1NGbXk1aWxmamh2Z2ZzY3JVeWEyS3I3cC9kcElXOGVOSzhaMUlBdjkw?=
 =?utf-8?B?RFgvTEpOUlBJSmRsMmx2bWhsbGQ1aEhtbXVJbVI4aXFxWDVzODJhTmFPeUJB?=
 =?utf-8?B?WHU0Sks2Y09QMWpwMXpxdEtCcUYrYUFnQ25yTSs1aEd5RW4vSUt4YlFQNk00?=
 =?utf-8?B?Zlp0QjBndmRXWXh5MDZpVE1JMEpzM3RRRk9PelFBWXZFRi9VelNnZFJlU2I1?=
 =?utf-8?B?ZDNUdFRST2tHRnJldjZvL2Fac0ZKdVQzTk1JL1FEclpKaTBaUmV0Z3BYbG81?=
 =?utf-8?B?ZHNtWEVxZFZpQWRxYmo2R0ZGbmRCbUxZYUtZUWljQlE1RjRuaGVPNFEzMkg5?=
 =?utf-8?B?TzMzYy9qTENsbGRaY1I0cTkxamk1cTJnKzlhZ3NBbjRuWnZOdUlOV2FGSjZT?=
 =?utf-8?B?ZlpyTmQ2ZzZCYnJZNTNZeFlCTVg5K1RUeWMwUkNmSUxUUWhsSDd0aG1HL3RW?=
 =?utf-8?B?Nk1PZDRPUytOMit1N2hTTkRIeWtpSUppWGpuM2FDNVQ2VWFmYjhJaE5WWXcr?=
 =?utf-8?B?c0w2SUhocXpzL3R2Vk9wamhRajhtOTJlQlo1WXQvdjZsbU04YW9SclJtZVp2?=
 =?utf-8?B?ZW9yS0FQenduUGh6cGowN1RySFdEUTJEY1IyRndkaFJCNXExVnAzUXlMTEVJ?=
 =?utf-8?B?SnYwcnJNbEdTdE9QcjJBbE9wM2hRRWF3WTNQVXAwVEdnYS81ZFdJenp1L2hS?=
 =?utf-8?Q?5+F2ldt1me0S/vfDI0D8+mdigas3MpvC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3V3RXJ4SlFzbVExRWF5YlFkeWFtazdDeHpzMDM5cTI1LzhBZEVWdkdacHBi?=
 =?utf-8?B?V2JJY0gyTjBCaEg1b00xV01pRXVIbzZsVE8vZmtqNzZPMldHZldMZ2dXdWFm?=
 =?utf-8?B?WEFJcldQZ2VjRjhUSlE1cjRjMmRPVnRRMm5xUDROODlOWTVLMFJ6SWxXS0s1?=
 =?utf-8?B?MWk4VUM1OTdrWjlWRmxqQjZTazNoQUdCSGh4UzlBQWJIQmNSOE94YkxtU0sz?=
 =?utf-8?B?eE4yTGVTTXFpQWRaemdnS3d3S1gyKzlHcFZUZGdCQWVpeGtKWDkwMzNNVitK?=
 =?utf-8?B?aTRCbWR4NXJkNW9RSVdwTElFd09HK1lvZkJLL0JVbE91R0FGZU8rOUl3UjU0?=
 =?utf-8?B?WVA4N1VoODJPM2pOdDFCUkhWbzVmcXI5K1oxL0RnaEJUTEJTemZ1WmxHclFP?=
 =?utf-8?B?ajE3WFlKejA1VTBpeDdRRGVINXBJY2p5UGdaWkZNWlBnZHA5QkcxKzJjaGdO?=
 =?utf-8?B?N3hBdEx3a1RrclE2REdGVStmNXZjR1BFZnZwYVlsQjl3UEdRdU10RUVhbmc2?=
 =?utf-8?B?NXZKTm1PdStSNkZpUklMUlRlZ3JocGpjSmFubHozTURTMmRyS3Raa0R4UWdy?=
 =?utf-8?B?WmlpYWw1anBVdmFnUlVPTlJNVG8veW1OOVdWQ2pCeFpBS1N6d24zd1I2Ukxz?=
 =?utf-8?B?VFRUQVpxN1MrZkZXNFJzU1NwNWszckF3UTRpSFhMeUVod0p5S2hiQkJWMkU4?=
 =?utf-8?B?cnlJcnZKS3M4b1ZzR296bVlhOVh3LzFtNFlBeWw3R1BTVDdLQmtVVC9HVkRv?=
 =?utf-8?B?amxXRmJaR0pmRmNBRmtkMnBETkFWcXo4WmlYZjVaQURiQml1NEIydmtndm5C?=
 =?utf-8?B?N2Iwem1VSFZNNC9rMUowNEl3NWhzN3daVmk1UDE5OGdoYi9hdFVaSmd0MGli?=
 =?utf-8?B?Q2R4MzdGN0NaZmQ2SUVhNWoxZ0QwTGxud2VvcDdMQkVOZk5PSXpUVTFKV2tw?=
 =?utf-8?B?S3h1TldnWFhoSlljb3FNcnJuRGZ2bzFuQ2I0ek9ITjMvbHBmK1V6QjBXVGV3?=
 =?utf-8?B?ZXdVTHI0bGV4R05qNlB1RDUvVDJObWRWaFlqcEpNSHkxZmhMQ21nSFdmRGxP?=
 =?utf-8?B?QjhKekVPMDQraGZ4ajNhVEM1YXU5eFFDdHV5blpwdm9BWkJ1NEFOOTExOHhU?=
 =?utf-8?B?NUVHUW1DZlM3TjFxN1g1Z2kzaTNXdVNBc1ErWU5ma04yUjVYN3lld25YRU4z?=
 =?utf-8?B?ZHJzUXZWNTBkM1RKbnFxTFJyUlBvV1huNTJMbU5aWXNXUmMrdXd1MWN6cGww?=
 =?utf-8?B?ZDBHU2o1RW44VDRLSUlTRTZoOTlBUVg2bnhmaGVIbTVIeTNxdHpEaTRWMENi?=
 =?utf-8?B?TVdxTDlVRW1mc1NoQXp4MTc2VTR6VVBPQTdlNVhTYk9lNUloWFZWL21sbjcv?=
 =?utf-8?B?NUltZnppb25ieE11TzVZSE5zZStwRGl2RjY5RUc0MG1PVC90SmlXcjRzYm42?=
 =?utf-8?B?clhsSHAxenYvdU1kSHd5TWh5SW9rbnJFcGZtRTFlZ3Z4YXQ2SGNjZVNaT3NY?=
 =?utf-8?B?REp6cHhOSU9CSDVBTjFEd045VW9yc2x1a1ZjaGlCZ2lZdWtVMm11aS9FZU4z?=
 =?utf-8?B?WURZalp3NEZ0UGRWbXpUVUd5ZnFnenlhUVhxdWREcktFQWFzZHZVVURlVDdO?=
 =?utf-8?B?RStCUU1tcXlpNDZ5SVUxaWx6RDdYcVIrRE1NK1A4VzRwRFpKWHZmdWpJNm9u?=
 =?utf-8?B?RjVKSk83bUJIN2FOUFFBanFWL05yU3FtY25PU1VYeVgrb3RRVE0vcGJzWExE?=
 =?utf-8?B?ZzIzZWN1S3UxR2NrVmJMVk02ejZERkkxMlNESVNoZjRKd2FxdHBRSk41Q3Zu?=
 =?utf-8?B?SldaVjE5NXRmMlpNZDNYV2tpWkxWVlk1S2U1b0VFZUhNS3VNR3JPdWh3RHNP?=
 =?utf-8?B?czlOM3ltV21GWTNxbjhrMllLM0gxNGFDMFdwckdoYzd1TW5LVG00WUhNWUJU?=
 =?utf-8?B?L2FJQW9CaEcwcVRUb2k2WkR2T3Y5bjdaK0pBWmZ3Z0xWOWVPUE8ybHcvSVoz?=
 =?utf-8?B?eEU5ajdRSmgxL0tiZHJ2alFnWG1DMGNVRFVIV0Q2cHQ5TnpqSk84elZIVEhK?=
 =?utf-8?B?T090aXFQblh6YTJJVVAxN2N0ejAyUnVPVDRicGJlRWdab2cyWkw3N1hRMy8v?=
 =?utf-8?Q?fGFgoKCtU959P175DYS/LIAL8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0112b296-2d4b-4562-57f3-08de0010d12d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6005.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 11:02:17.3197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWxz60ioySFCqbT0vhV0AVEOQ1ECZ1LXQOr37GgSdoAjSXQkPx4/GfZGLhTriYtrteHOSIAmLcLh/xcc1LJxMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5251
X-OriginatorOrg: intel.com

On 9/30/2025 12:23 AM, Luck, Tony wrote:
>>> This seems to be applicable as it introduces the new interface
>>> while preserving forward compatibility.
>>>
>>> One minor question is that, according to "Figure 6-5. MBA Optimal
>>> Bandwidth Register" in the latest RDT specification, the maximum
>>> value ranges from 1 to 511.
>>> Additionally, this bandwidth field is located at bits 48 to 56 in
>>> the MBA Optimal Bandwidth Register, and the range for
>>> this segment could be 1 to 8191. Just wonder if it would be
> 
> 48..56 is still 9 bits, so max value is 511.
> 

Ah I see, I overlooked this.

>>> possible that the current maximum value of 512 may be extended
>>> in the future? Perhaps we could explore a method to query the maximum upper
>>> limit from the ACPI table or register, or use CPUID to distinguish between
>>> platforms rather than hardcoding it. Reinette also mentioned this in another
>>> thread.
> 
> I think 511 was chosen as "bigger than we expect to ever need" and 9-bits
> allocated in the registers based on that.
> 

OK, got it.

> Initial implementation may use 255 as the maximum - though I'm pushing on
> that a bit as the throttle graph at the early stage is fairly linear from "1" to some
> value < 255,
> when bandwidth hits maximum, then flat up to 255.
> If things stay that way, I'm arguing that the "Q" value enumerated in the ACPI
> table should be the value where peak bandwidth is hit

I see. If I understand correctly, the BIOS needs to pre-train the system to
find this Q. However, if the BIOS cannot provide this Q, would it be 
feasible
for the user to provide it? For example, the user could saturate the memory
bandwidth, gradually increase MB_MAX, and finally find the Q_max where the
memory bandwidth no longer increases. The user could then adjust the max
field in the info file.

> (though this is complicated
> because workloads with different mixes of read/write access have different
> throttle graphs).
>

Does this mean read and write operations have different Q values to saturate
the memory bandwidth? For example, if the workload is all reads, there 
is a Q_r;
if the workload is all writes, there is another Q_w. In that case, maybe we
could choose the maximum of Q_r and Q_w (max(Q_r, Q_w)).

thanks,
Chenyu


