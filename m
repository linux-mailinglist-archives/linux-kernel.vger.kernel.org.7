Return-Path: <linux-kernel+bounces-849224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C5FBCFA1E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 19:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8AEE4E6220
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 17:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B2A1DE4CE;
	Sat, 11 Oct 2025 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eoeJzCet"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C5A17C211;
	Sat, 11 Oct 2025 17:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760202926; cv=fail; b=M+27NlFTa6/sRU50vwRRiLkr+uo84kZjatmKVqOz46yO/V8DUaCAwRXrThcZP47d0aFjr1tRRwnXqXc4hibuYVHOGYg/fEK2SJMf3b1Xo9mf0RSaLpnS2OIgEDhWKHM3PgTJWGVqsF2jW9n/xYCq43OujPOamPsQaveaPT9z9aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760202926; c=relaxed/simple;
	bh=HLm0u7892ATNjPwQL2bwz0/IJ4EJci+Jr44kfuU6MbI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e6bC/Ne0fhICLReDaBZLcseMfruu1Zqkh9HjaaA8/1WqnVnAaKbaKjhkEDo61UxnTicwXFWpyDEuwSIlrG518yF007tAM/LswfmawqGBxqT7zZRCaU3+/sXl1VUOm1rEj4yuvGTNkTmSUuswtNQ+XxwBwZt70Q113MrUeiy8FTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eoeJzCet; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760202924; x=1791738924;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HLm0u7892ATNjPwQL2bwz0/IJ4EJci+Jr44kfuU6MbI=;
  b=eoeJzCetyAXOXrYdt8eC3GzhrS3ubsz92unFuiWlTL3ONA42KyiaH6YF
   kwgnE8cWwKzlqzBrgLKr5NOVCgStRhMR2bQXnMoreRd8Xr+aOL+qDWyql
   plbPvsJUxAY0uSYFPTej6pCOX+il4b1Uy80P2qkuKOehpbroFe/lwEqlB
   50J58pptVyLkVQVojWRTVxFoPKjanxc1yYhsvcun9ORZxIYWDK62fDcvP
   3jnoHIjnkh7JnUdSg01VY19LbPBwsXRAVbzWq+7tL9iWBK6+Wnof2k1zz
   oSiK1e9i0BfnPlU4dU2c/E8zJA+2iPYxwI3IfWZofxttNgPhvepTiFdIx
   Q==;
X-CSE-ConnectionGUID: HTyDHpV7TLiZXyZhnoS8nA==
X-CSE-MsgGUID: 22w3vr/ZTMuXfnkEYLKLDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62337928"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62337928"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 10:15:24 -0700
X-CSE-ConnectionGUID: WKm3mhYZSaCDnOb/zxOamw==
X-CSE-MsgGUID: Shyuo976Q6mYULGc7LGhKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="181991020"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 10:15:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 11 Oct 2025 10:15:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sat, 11 Oct 2025 10:15:21 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.32)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 11 Oct 2025 10:15:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWBXF9SPJvg4ym4gttNMVtHeIBOlT2GnPsiLe3dvIf8OwxGMSu/LUWWrDEUWHjzigHQbD2nAcffF7u2HVyo+FSx5oVBmrfFelKbV1lEirFjHOVhUFMxi35qTGzdO5rmsR6iE6yDAHxNJyQS5y7CYsvkxuPAF4bu5sMcDm6xKFId6UWvslr+SKyjgbfWZ1/IOVEh07JyFfoCMcNZwLt/IUuPEWiRJIrRcCs99rLtWJQ8MfD4QHWT+4djO8JekPduTfAmYmai/etWM4/m+1437PTwmKXy2kneQofQhcCHMB8VoviHx7eUVbBED3hfDQ1ywTu/mkD1/39B4UddQaxt0yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdrx0nQKxeUZtjwxXeGj4dFiILU1nwTm1xo+1RT0C0k=;
 b=C2q0IdIMtTdSvCvmHwVbiyR9DDGKt5/PMrFpvghMGUDiHz55Wza7oGvmL3xccMvmB7xnxaCL4I2L02vOxzc7AvJd/oycI732UnrZiEwJZ9dnFlc67EkAy+t4zeJRVBe+nOApo7M1xWT/D3TBv53AlYNzDaP7UVln6YAOlZ+9syFBJCTe4gXLc9rvqV4i38sLFfdAST3WhujaHTtlfPhQOu6gU23wYc4MVb27DGRpLlVYeLnQDSscb6ctEVevc99UXnj3H9CZ7SRKtc4xxvJwc/JqDVqaNDO18tWOvoXPg+mePH8CqJJVueKNsEMuSUqLfo26GnXO9kiJgcMZrbFcCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DS4PPF7A0031045.namprd11.prod.outlook.com (2603:10b6:f:fc02::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Sat, 11 Oct
 2025 17:15:18 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 17:15:18 +0000
Message-ID: <883591c4-6301-45f6-a671-ca55974aaac0@intel.com>
Date: Sun, 12 Oct 2025 01:15:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
To: Reinette Chatre <reinette.chatre@intel.com>, Dave Martin
	<Dave.Martin@arm.com>
CC: "Luck, Tony" <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>, "James
 Morse" <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <x86@kernel.org>, <linux-doc@vger.kernel.org>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <aNFliMZTTUiXyZzd@e133380.arm.com> <aNXJGw9r_k3BB4Xk@agluck-desk3>
 <aNqQAy8nOkLRYx4F@e133380.arm.com>
 <d15d97d1-286c-4857-8688-4d8369271c2c@intel.com>
 <aNv53UmFGDBL0z3O@e133380.arm.com>
 <1c4b6b46-16f9-4887-93f5-e0f5e7f30a6f@intel.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <1c4b6b46-16f9-4887-93f5-e0f5e7f30a6f@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:820:1::26) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DS4PPF7A0031045:EE_
X-MS-Office365-Filtering-Correlation-Id: 72dea5af-58a7-491b-4d2d-08de08e9c030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUtQc3B4Tms1eEJ4c0hBQ3BFNEVYektWK0lUT3hyRS9lbUhzelRZK0pLeU1l?=
 =?utf-8?B?V1hZazhmU05pNyt5VzR0VmZaNXlranpNTHpURDZIVFI3cFVKSGNTL2FqWU43?=
 =?utf-8?B?bEx3dDBmbW1FUytwQ0dpV3ZkcGRaN29GeEFKbjB3VWY1MGNxaE9QRXMxV09K?=
 =?utf-8?B?T3NEWXdSYVc0MDFzRWhFUEFFbTQzODEvL2IzbHBzdGMxWVVTemx0cjNGalJw?=
 =?utf-8?B?cWE1VGtoQzE2T3p5Qk56TnVTTm9IZC9sY3ZCcXIxc2RMcmJLNkdOcHZsRTlr?=
 =?utf-8?B?djc0dUN6SWJPM0lKNTRpS2NObG9SVk5qWWVSa3hMb1ROdDFCdXorUFJWOUlv?=
 =?utf-8?B?RHVVai9vNklsOUlQOHZUY1FFdDRuN2FIYXB3dXlQUFhYQnI4NWJmSTZOWVpu?=
 =?utf-8?B?NDVGaG1aanpDdUdjRll4Y01KK1Y4bXBxUG1Wc2JHbm9hNFU3bXFJdjNsVjBR?=
 =?utf-8?B?R3dVZmFFZUdiMWV0ZlpNbUtUWmFMeEwwZWxlKzB5VXRVNnRyWGRxR2RLTXpX?=
 =?utf-8?B?NkNCWHVIeXpyK1hEcDBvSnlaT2lWWk8wamluUDUxbVA2OGxtUHdkeXoydGdX?=
 =?utf-8?B?ME9OaTVRZGtWampIWWQ2cmNXYU90MGM3Z0ttYmdFUXAvZjRUVmdPUFFFNFh2?=
 =?utf-8?B?SFZ0UlJpREZRT0tHRjMrZ2F4dzRGck95OHZOLzBoZndjQ3lpUDQ0WU55R1JH?=
 =?utf-8?B?OGxyd1NUeDNUUk4wYXlsSXljMzhGbnd0YVBLUi9TY01GRnFodERZQWg4czRp?=
 =?utf-8?B?dERocWZsWnBRVXBnRkxaVk5id3hmUmNZOFVxL284cCszb3BJKzI4ZnVranNm?=
 =?utf-8?B?UlVTZjhXTGxsV21LdjRqVXJucHRadDNpN1ZkcUY5RUplOG5vZ0VMbzNpd0I3?=
 =?utf-8?B?ZVEwR1J4V0xnQVdXV09zVldIOWgzcFRPQUw1SThqZWRTSDhBR3l5bXJySnh3?=
 =?utf-8?B?QzQ5M0tHaVIxWm1KUEp3RXNBT2RlcXYxRzlNdktDQ21IWlgwK21tRExyS09k?=
 =?utf-8?B?N3V2Qm9WUFZzNlk0WEtnN0szTHp1VXl3Mk5XdkhwQzRJeUdPNE9BdnhIUm1Q?=
 =?utf-8?B?ODg4WVpqTUxvaC9RR2xwVGVIUnF2SU1wWmFIVGgya3BoQ25valdjdUEwMHBq?=
 =?utf-8?B?OUNkM1NXdTdKSTdkR0d5RDRYTWl3WXhVNm9wZ1RNMUE1WVpuSUJzT3VkbU96?=
 =?utf-8?B?TXc1aWZSMmdtTFRibE5YMzNKZG5qajhQSGgyNGZ1WUl2am5Vd08xWktab0hU?=
 =?utf-8?B?NDk3ZkhleTg5Mkg5aVp1dUg5amZQLzdSeXY2ZkNpODFjN3VCWSt5U3QxTlA4?=
 =?utf-8?B?Q2hKTUg1Zm56d3BvdG9rQ3VkbU1jR3hSVm00bnh1cHNzZENoYjZ1RHpmRU5a?=
 =?utf-8?B?c3RoUTRyR0drMld5TWNKc3ZaWXJ3eXNaK2J1WXJBc2ZxbG1CME0xNUptL1lx?=
 =?utf-8?B?QXNabFQ0T0QwSEpiblpkVWZ5K1ZSRkZDeWNhdlkyMlA2U1dLaTZQOGV3R3Fz?=
 =?utf-8?B?eC9nOUJoVjVDZ1daUXVLYWpFMVJKMUpnU0xKbnR3YXQ1RHViYTZPRkVCZDN4?=
 =?utf-8?B?SDZ4VWpORVp0OTV1TndxV1BYbmRrM2dyKzNGOXowUzd1S2g2N0ZhOU1TQ1Fy?=
 =?utf-8?B?R09qTUtaNyt1WG5JUkI5Mjk1eGZJaFlxSklFTFhIalV0UkZ5YjduOEFCWm91?=
 =?utf-8?B?YXpCMlVvbU50dFNDZ3VCWm1ud3VhOHhLVEJHOWVzUHl1b05vVFpvM3o1Mmpr?=
 =?utf-8?B?a1RoaWorUTcvZ09RY0dtR0R1d1NXeVo2dWdHLzlFSE0vakpxdEZKQUVVREps?=
 =?utf-8?B?MVZVaHZSRnBONXBmSlBvUDlDWnRxdmY3RkZUVlRHS25pV1JsU3BqQ09ja3BQ?=
 =?utf-8?B?eHNTdE1BMlBYQWN2c284T0krQmpwa2ZFQ3hHTFBIbEQvbDVPRE5VMkl1alhl?=
 =?utf-8?Q?YOM/C3UrCzwvptUpgtcb9ZpKMBhFQBbs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXY3c0JzL0dQYWZOdE1aTG41TTdiOVk0UGdRdXlzTG16NXNQL3FlMXZzVnZX?=
 =?utf-8?B?T1MrZTlCbkQxbzliSElMS2M5cFMzT3VOelNNUExNWjJoeUViUUZEU1JmWmVE?=
 =?utf-8?B?ajJPWGpGQ2gyT1l2VVp4VFFXclluRENqZ2FiZTlBb0dJSEhJQStqTHZDblA4?=
 =?utf-8?B?QmZwSmlhSXF6UUQ1bHFHT1BFV0hqa3ZUUDNEeHNDOGJLQ2Njdm81d3lsckVY?=
 =?utf-8?B?YU13N3NFVzdzTkNuR1ZmeUJZMGlDUmJUWFpGV2c1STN3aVI0TmZiK1FmMHVL?=
 =?utf-8?B?S1haMWxNV1d2MnFWdkV0cVRmREczQlRUQ3ZrbEVhamtmTThJUG4ra25hVmdJ?=
 =?utf-8?B?TkVSVXBSZ3ZJblF0NktlQ3dnWGZtcW5hSEgvb1F4N1hBbWtuSndrSTVkN1Z1?=
 =?utf-8?B?dStCWmJ2S00ycE9uUjN6STNRQ21QcFhFckZmb1g2NUx6K3lMVU9qWmE5MUcv?=
 =?utf-8?B?dDlxMkhoWEw1VUNwMEp3UjUrWlhPMnV6YXFZY05qa2xnaUZyZnlCWWxzNmxr?=
 =?utf-8?B?N0gxRzhIakNtdlZPOXlSQzN5N1ZDN1VGeks3K3dQR2xSUC9Mb1BtcE9PMnk3?=
 =?utf-8?B?UWh6bG04eEx0TVd4Z0Y2UEd6a0R4TnBIcGp4M2FzV0J3SEF2WXZUNGI2cWUv?=
 =?utf-8?B?SFMyWm5PZDRFc2lBSUg0UWgzRHZ2U3pWaXFObjh2cmUxUjdHWjB3S3NyOWU2?=
 =?utf-8?B?QStpTHVBNGllS3VwUnJKU3I1VXFSLzY5Zy9VU0pLUC9STEsyTHYrdlhlNW0z?=
 =?utf-8?B?c1NJWnBvY0tXMHdPc3d1TTJlbHlHMEszWjJQN2hxVnUyRGhxdUZqQkc4Slgr?=
 =?utf-8?B?UUdoTzlzNWtGbGxXTFJEaC9Pc3dTWVQzUVByUVNQSVQxR0RqbmhibVNkWHlU?=
 =?utf-8?B?OHBScHB0SVBMaC9jcW1DQ0V3dS9rWjlOSGNQbDBzRDR4YngzWkszaHdGdUla?=
 =?utf-8?B?Z0xMUDRTRmNUaUN4bnc2YUFQM1VZMzZ5UGFTT3RPRFFkWnFjV3FVTG5ON3I4?=
 =?utf-8?B?NEM5UGdqZDY5M0QvdUwvbkhabjlQcExBZHdrOXZuUnZHN253UmFhVFVGQmR0?=
 =?utf-8?B?SWF5eko4REhOOVhqcklDdk9wbXNMTmZEeDFVcTAwSEszZXM3WHg4MVdDenVF?=
 =?utf-8?B?QjRhVUZCMU5rbVQrTFFXWnZja1VZTjR3aU0rRjVQbEFaU29rVkZmQXFmQ01H?=
 =?utf-8?B?d1BXWHl2dWRXMGN2aHlPVG9mMnlDRytTQUQ2YXFHK0UwK3krdk91T3JSMnNq?=
 =?utf-8?B?Qld0OWpTWnQyZHV3bWtCdWZ3aHBWVzVObkFCLzF0aFB4MkwzYmpmWjFaeVhC?=
 =?utf-8?B?YXBNMDM3dVN5endFa1BVeS9Yb0xKWUlsUldwWGdVak0xSlJNWFl1WllnUklM?=
 =?utf-8?B?T2dMOEplbU1QZWtvQ0pMOEh2YldINzNmVS9FWWtkcHliOTFPU3dnU3JjT2RY?=
 =?utf-8?B?czZrUlFZUmtxSDVKb1NTclZZSG9neFhFNEZCUUhEOHhLTm50YmFVck0zYTlq?=
 =?utf-8?B?Y055QzdTU1JtMmJ1Tlk0ZEc3UVNZRldJb0IrUGxMdnp5MEZFSjNWeENGdHl5?=
 =?utf-8?B?d1BnOXBqbTV0TGwyY1A4SCtsa2N1V3VoR2hsUUtSSTUxdHorOS9PVVJBaXAz?=
 =?utf-8?B?M0FPblNrUTkyQ1IvY2Q0emFUdzM0Z0JpdEZBZExIaXM1Z0JnNDN4YnBHSHpT?=
 =?utf-8?B?WXl6SC94ZnUvRWRTVDhCTzlLWThtOUFvZzRqYXhvYlR5QVJ3ZmhSckswdFlm?=
 =?utf-8?B?TkVXK1RQRXFBVHNQZ1hCTTVqV0hRSDBablJJdmk5ZTJlZHZSVXZReWNpSXRF?=
 =?utf-8?B?enIzUThTRXNLcUNJbXJEN3Z1QkxMWmhLNFE5UnlBTTE4bG9PMDE3ZFptS2tm?=
 =?utf-8?B?NHQ5RDdaNEJMclJIOGJ0ZUk3dlhwd1A3MHp4N0RXKzhWVmF6TzkwSDBUeWhu?=
 =?utf-8?B?RVpUWHk3WjE2Nm9JUEk5cUgrbWFOQ0NZL3JGZ1hTbGNFUnNQcEgrZmR4T3NK?=
 =?utf-8?B?T2hMdFREVHRPdlIwelk4ampTSlE1dHd1UnpMNWIzalZDQ2dPaDZmOG5xVjUr?=
 =?utf-8?B?WVNBdXgwbHQ3bDBZMDRoQkxDQi8wTXhlSnd0YVd4N0pQZGVJdmNXbk9IRTUr?=
 =?utf-8?Q?nu0VDvKf9+In1a61flIFdKEAu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72dea5af-58a7-491b-4d2d-08de08e9c030
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 17:15:18.1294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/QiyXI4pmSNlk+1Y1ghTjxisbh4uxr1BKPpQC0TtqZIgjSIFdrIKHsHLqFbYC3VgAXW2oyXUfWiMqSailnXEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF7A0031045
X-OriginatorOrg: intel.com

On 10/11/2025 12:48 AM, Reinette Chatre wrote:
> Hi Dave,
> 
> On 9/30/25 8:40 AM, Dave Martin wrote:
>> On Mon, Sep 29, 2025 at 09:09:35AM -0700, Reinette Chatre wrote:
>>> On 9/29/25 6:56 AM, Dave Martin wrote:
>>>> On Thu, Sep 25, 2025 at 03:58:35PM -0700, Luck, Tony wrote:
>>>>> On Mon, Sep 22, 2025 at 04:04:40PM +0100, Dave Martin wrote:

[snip]

>> Anyway, going back to the "#" convention:
>>
>> If the initial read of schemata has the new entries "pre-commented",
>> then userspace wouldn't need to know about the new entries.  It could
>> just tweak the MB entry (which it knows about), and write the file back:
>>
>> 	MB: 0=43
>> 	# MB_HW: 0=2
>> 	# MB_MIN: 0=1
>> 	# MB_MAX: 0=2
>>
>> then resctrl knows to ignore the hashed lines, and so reading the file
>> back gives:
>>
>> 	MB: 0=43
>> 	# MB_HW: 0=3
>> 	# MB_MIN: 0=2
>> 	# MB_MAX: 0=3


May I ask if introducing the pre-commented lines is intended to prevent
control conflicts over the same MBA? If this is the case, I wonder if,
instead of exposing both MB and the pre-commented MB_HW_X in one file,
it would be  feasible to introduce a new mount option (such as "hw") to
  make the legacy MB and MB_HW_X mutually exclusive. If the user specifies
  "hw" in mount option, display MB_HW_X (if available); otherwise, display
only the legacy "MB". This is similar to the cpufreq governor, where only
one governor is allowed to adjust the CPU frequency at a time.

thanks,
Chenyu

