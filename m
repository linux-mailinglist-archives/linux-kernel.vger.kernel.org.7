Return-Path: <linux-kernel+bounces-851035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2513CBD55EA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F3894E468A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB752E92DD;
	Mon, 13 Oct 2025 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PSxWmp5W"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7082573451
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760373824; cv=fail; b=bQsuyvTLeeViqfBwG/ghWvXieRjg25QRHXDPNk4QwHtUiwN5843xmNiFEiGH9Ygq4QvW15XwlxFiVWvYAEKmnGElp5q+jDHmoNbta5AxLBW6Qe9yv5d9WdWCpVMbgPN0Xk/fpQvbNztd2KbIzw/mmQQcqGTRJz+HrFoevavyytI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760373824; c=relaxed/simple;
	bh=Gd3lhljm5xSBOOdHCezjRUe/gTjH07dAq7RnmSGnY/k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KriIvMq7ycMpj5YFfBSEdRxnxSvYhcKHnUPKNFhjf1BnjrInKMAPzgZzuve7RhKOyoC4CyvkpZg7yThmnEFOh2ASEBiYt85ByJCsv556E6r3GShmmtuuzPSfvM7JpFTtbaQ02sXjcQ5loATb7B5iN9BeaJi+Bbq2Z5IaN42r0kI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PSxWmp5W; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760373822; x=1791909822;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gd3lhljm5xSBOOdHCezjRUe/gTjH07dAq7RnmSGnY/k=;
  b=PSxWmp5WiCX6KwOvFdbnf4nO2IT36c4TOg0sXGE3YfJF3wP7Cclbb0Go
   JwiPP3eT8dLAQsfHeLmHtp2QbmcBVPh7/sk+Ta/3jIpLuqtTn8Y5azudF
   m4ZryY+DsrMy1X+AzNBhS9ojVbyyfctKeRY6lQ52qW1MtvoYdk0IhXXa3
   45N8pybKg8qJgSN6PhU5q68azWZzu3EVCmPUk3HtHjInXSV9ospAw8bVG
   jXsA1MIfnbVHrBqS57BJHj6wWwkb9TYeT1qkA+Xb3TZJ/sapaIdC30KbY
   rNQr1yrShF0bfeqWy6w+tqJvvPs+btXtr4mzVjPoYmBsy5ZnQNFNfIrKn
   A==;
X-CSE-ConnectionGUID: lp+bBr8zQUGYS+L+Gl1VEQ==
X-CSE-MsgGUID: g/r+jA+1TwqrHWFxMctuGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62556416"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="62556416"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 09:43:42 -0700
X-CSE-ConnectionGUID: ZUcvzSgoTwypxVLN3wdWjw==
X-CSE-MsgGUID: IK015UbHTCeCStCzvWXdTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="218763912"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 09:43:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 09:43:40 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 13 Oct 2025 09:43:40 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.54)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 09:43:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BK8nNlCY6N9x5qZokBI54tWTpsM9Lkm71/+T+Swuj+yvyAjxLCc6ak+OVzhoeJMzeNXm7s+anGEKYAsco9cOcBsM2jYXmjsBNx4VEDWNF6skd/3EFcvS+oP56oHyDOntccasXWXrvzFdvpiUE3XmACenmbr5/XK7dMSyrt8etjTzf/Onzr6VM7TcmeINZD9bTn0EzSKYwIBvTY3+nxh0VtLk8kCOA7wuZnacUUBkV+nZTyRYkjePJK1OwUV7tMTy/4EFGMNClb/IbRoR9LO/TX0mGvdNX8HBEi+RfR0ZFN8RfupZwL69rxO0qgXxCxztU+HU4VxNJzJ8Iuf3hvrZHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icgtVGLtUVhuYgAU6lamOX3Dl3V0ZY/9ORp7by7VVNs=;
 b=T9yo9sRQy3oH4TBRDZ/2ljs89QNvb/xpl25XasxF9yOsfx6wovQEE2FKSDyfvVUHhmLCMB2Z/bVkKjMdjFkueoiRLjJnmc8wU4JrSjO0xBycjsVNXkqaSXl3Qean7NQE2+Ew0dPSwR/N8c0I7BEOomW7J4tx+qOZV01SJPwGLnM895gGOyWuWjmxW3yFhke51zh09Do5FmvJTuU1dlciwIJIYTdRko4RpIJRQ3gD2JKNvHQ9xNHeFQDUb8BwbwGDdsNNiNzEX8EJT25ZdaMgZnw+/KGuaqLjgBgrxaaEpJND7Wv8rmT9Z6AaM3egJwSv/QBXy1bzd+A+U11ub2ZZKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CH3PR11MB8562.namprd11.prod.outlook.com (2603:10b6:610:1b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 16:43:36 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 16:43:36 +0000
Message-ID: <0c9ceccb-8f77-4777-a352-090d29421394@intel.com>
Date: Tue, 14 Oct 2025 00:43:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] sched/fair: Skip sched_balance_running cmpxchg
 when balance is not due
To: Shrikanth Hegde <sshegde@linux.ibm.com>, Peter Zijlstra
	<peterz@infradead.org>, Tim Chen <tim.c.chen@linux.intel.com>
CC: Ingo Molnar <mingo@kernel.org>, Doug Nelson <doug.nelson@intel.com>,
	Mohini Narkhede <mohini.narkhede@intel.com>, <linux-kernel@vger.kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
References: <e27d5dcb724fe46acc24ff44670bc4bb5be21d98.1759445926.git.tim.c.chen@linux.intel.com>
 <20251013142638.GM3245006@noisy.programming.kicks-ass.net>
 <49dba7ff-8be6-40cf-9aa7-b0a5cb2f77c3@intel.com>
 <e09fb1c2-cf74-47ff-af6c-671fe23c2e90@linux.ibm.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <e09fb1c2-cf74-47ff-af6c-671fe23c2e90@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0141.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::33) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CH3PR11MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d78e256-40ce-4254-3456-08de0a77a7c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3hxY1dPZzF6NVVZZWxBRGRwSzFMUkJ0Vm0vRkM3SEdCdjZsRXhxSWo3TUxp?=
 =?utf-8?B?SkJiZjgvOFQ4T2xIWkNiV1VjdkRMZDF3YmtYOFRHUjAvSWtyVVJhamJwWjB1?=
 =?utf-8?B?andsK1lIOGNDYS9ONERQRXhXd2hTZlF4MDdwTXJMaFBTT2J3QjZxUHlpaWd3?=
 =?utf-8?B?NFpNQmx0SEdrNThIM3A0WkMvZTVHM2MvdTdDOUhlaGozZGhWM0twcFNNTXFB?=
 =?utf-8?B?ZkRNSFAxTFFVSkpqN3pPRXR3aXU4ZndLM3ZJV0VTWGZMaHUwdXdSOHRwMC9o?=
 =?utf-8?B?ZHk5VFNWNXBBdjlWbWdKTzcrNE5aUTJHencvalZSZWdJd3JENDl5YzhnUEEw?=
 =?utf-8?B?RzdvUWtlSGJ0VUJ2Vi9wYmVBenZ6cWgwZXZxWkVld3lUV3Ixd0loOThwTmNF?=
 =?utf-8?B?YjJUN2lXSUJNckp6MmhoNkhTTHJXdTZLZ3g4Y0VKNURxQ25RbHdiSkJQNnRG?=
 =?utf-8?B?ZkNuM1hUTnU1OEErZThER085ZUJBV1VmWUgwNDcwRGJHczlzT2FKZjZXak1v?=
 =?utf-8?B?Q3YzMGxocDgvYTlUSXFQUlFGbXNIbFprSVFJdnUvbjdEOE81TjNsU0R2MkVC?=
 =?utf-8?B?cThvVFBhaXBvWGdVTkM2bk44ak0rSWFvUjhYVWhWM3hRZWhaZFUzOWlSVmpU?=
 =?utf-8?B?QkVOZXM0eG1EUVFncFEwalhXSjkvZWgyQmkzOWJscEhHTFlNeDFTZm9veStO?=
 =?utf-8?B?L292d2p0OXk5eEQ3N21pM1dKTWZjK3dVNUtHbTBjMFFWNENBd2xaV09JWm1o?=
 =?utf-8?B?WTRBMmRVVjBRWkpIUm96RVVpZUhaQzU0Yzh4dk1veEY4Y2ZuVEtDbTFYM0o4?=
 =?utf-8?B?VFlpdkNHQ3haTFJpZ3gybXNnKy8wUjBJUTN1NlVLUnVUSHJYUmxNKzF2cnBB?=
 =?utf-8?B?VFVOSjBrNHlzL3NPVGFrKzBML0F2TnNMV3JsNmJUYTFHdk9Kc1FYUDAwM0Rq?=
 =?utf-8?B?K0twVDFidjVLQnV0MnBnZDFZLzV2b0lPenR2U3FJeGtBMldod2VxWEFpeDQ4?=
 =?utf-8?B?VDF3MnU1ekdobUo4eW5zbTZHT1pGWis5VHpGeVFUMjV1YW9DMkZlU1JmTXph?=
 =?utf-8?B?U1pDZnlVOVNGaWp4SDMxKzA0ZytVdUxRd0hkd25Qcm50RS9vaGpOT2tkOEN5?=
 =?utf-8?B?OWlESURZRk0rWXA3WVJzb2hUTzV3aTRSeG5FanU2Tk8zNWhkby9NOSs2QVR2?=
 =?utf-8?B?eGV0UWgyNFVDT2s1ck43OGtOemhxN3JnbTl6VjFWT081SEh3d3lNQnlBNlln?=
 =?utf-8?B?WWdGYVBPanBveDNSL1RycmVWdG82UGVkeW5jd2VTWGxZZHlFZmVWME42bkRE?=
 =?utf-8?B?THBHVkt1K00wN0pHSUJjT09JR25lbkxqRWhyNmpkN2Zsbk1adG10ckVTRG0w?=
 =?utf-8?B?S3VCVU9kYm5NcThXL0pTdnY4VkwwcEtMZjVRRFRBR2NYZjhnQ3JRMnpNQWZ4?=
 =?utf-8?B?K0hJZlZBbzFFeGNSdmZmSElVKzNPbTRpMm1DMGxmYTQzekkrT0VRZlBiZjNK?=
 =?utf-8?B?VnNPRzUwQTVFRDZKTTN2d204bFI4aHlRbG81TWFDNUhDTkVPUW9HUDMrVmRk?=
 =?utf-8?B?NW8vcGVIUDRabDQ4QnZnZWs3ZTRUc2ZNNWs1cjVBTkl2TFFKTnBwZndORnJY?=
 =?utf-8?B?cmY5Rk16MHlKV2wrZE9KQ3VnaVdIekkrVWQ4ZFBHbDNhOWM3RS9OcS9hVjFN?=
 =?utf-8?B?cEpERmhOQnA1SU5zdGZIM0xYOENyM1dvdVF4cER4UFNOd3dYYmZVR1I2N1pi?=
 =?utf-8?B?amkrbEgwd1pPN2RzME55RUNkRFpOUkk0QlNJQ0swSDh6M1VwVjkxUHJsODhK?=
 =?utf-8?B?SlF3VENORitoRHAwSTdSY3JKRTl4dCtpRVl5T0FVYm1yY0YzVHJ4MmZiaURp?=
 =?utf-8?B?bloyODNQcEdlODhOa2NIVnVsME0wL0Y5V3hQQjN3dEM5UE1XUjFLcXdiUngy?=
 =?utf-8?Q?zWnrFUMAT1Wz8Gd3wX9AMeVDMZDIk3c6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2psOHE2QVhPcmEzZWRqRHVRait2eFUwNUMzdUVVZTYyTFBaVi9hOXh2bmk1?=
 =?utf-8?B?NDRTM1V6OTVIKzJ2Z2VvdFVCbHZkRGpVcGY4aTFjNGtPV1llVllYbmdsVGVG?=
 =?utf-8?B?b2pVSW1yRXRRY0NRWlE4SnlCb1RnV0Erc3E4NEJJU2ZsejUvUVlaWVVweEVh?=
 =?utf-8?B?SGNhN2orZUhhRVIvVlpQZTZ1K0x2eGhha0lTanB1NHF3a3RMY0E4MktVazlw?=
 =?utf-8?B?a1QwV3VwWU95amFqSGkyNHJEM3E5MGNKNUs0b3hmU1NKZU1IU2dud1V1NHVX?=
 =?utf-8?B?dHhLdGIrUXU3T0h5aHYwYWNoMUZkMFZ4MkN1Wnh3MWpXMk5rWmZza2trcHBL?=
 =?utf-8?B?RWs0VWloUUhBS0FKLzJBNTlOT3Fla0VMSFVoeHVuTjJ1dnBwUUlZclgxRXdR?=
 =?utf-8?B?aWsxZDZYM3h1c3JYRWJWUUkvRmlHZlVGTWI0WUhRVFBPdUdnVlBzUzk3MHBQ?=
 =?utf-8?B?YzU2SUVHSmlteFE5dTQySkpJRDNFN1drWWFtcVBSbEtGREFSR290aS9XREFj?=
 =?utf-8?B?V1JENmFKV3dEVEtjMDZhdkd5UHlvR2tCNnd4c2tRRW5lK2ZUQXNTVEVHbUZQ?=
 =?utf-8?B?UWh1UVZ2WEI2Y2xIdVpIZE8yeVhlRGNadEdlaTVYQ24yVzlNWW9nN2x6UEl1?=
 =?utf-8?B?M0VHNGJSekhySm13OWVrcnhYRm4rRUtQYitmWkIvRUJFT3ZOQ1dmejBNNUZT?=
 =?utf-8?B?ZXpiM0x6bmlaZlBNWU03bjlOYlViZ29wNXJaMTJHb3o5bVFEWGtWVzByZkFS?=
 =?utf-8?B?eFJJcUtzRzFVSFZMUElxUU5WQ1NubVFJK3oxTW53ZERPT2I4WU9VZkZ4b0pP?=
 =?utf-8?B?L3liRXhSV29ybjkvM252UGNrYXppTkJBRVBzV2NoYXVjU25nS2l6SmlKSVor?=
 =?utf-8?B?bFNEOElNTERtOFRheTZKY1NDd1BNZmV1UHNOSTFPSENzdjNHejJoc3R1SmFG?=
 =?utf-8?B?bXU0cU5QUFlLY3pib3BuaGdENXVTdGpVTFFPY21BZHBvV2N3QjhEZFhSdldz?=
 =?utf-8?B?V3FNZDVEbmNseDBpRjU3Q3k5Vk5uQUpwd1dlaFdIVVY3MWdsb1RJckdCTXYy?=
 =?utf-8?B?SFc1aGxSSlRCa1kwVmV4ZStmSXY1QzRDNjAxclViUjYvWE4yTDFXS2d5Y000?=
 =?utf-8?B?cU4yK2hXZDh6dnBKNm1IMFpteEhrbkc1a2ltMGRPajBzNzhta25XelhLcDN0?=
 =?utf-8?B?UGc2NlBEaTh3YUlhV2NqSyt0bUVxZjdzMnF6VUQyU252SjRPSC8yMDh1aEg4?=
 =?utf-8?B?d3cyRXpGZVJMQjFpMkN3ODV2TmhWbEwyYmZ4NGF2SnZrWHFTVHRoZDR6azZU?=
 =?utf-8?B?MkZDcnJUeDNmUkhkdnBKUFJ0MXhNZ1gxUzBJNzVXSEhUYjRtMlcwcm54M2Fx?=
 =?utf-8?B?b2FuK0dQZTljTk9zQUY2WlhIU3FLZFNHVUJva1I4cVp2Z2QwV0EyZG1iTWZq?=
 =?utf-8?B?a3piMklzWVlkV1JtZVg3WStrTmN4MG44R25IRUozdWNSVEpVRzZjQThRc0Ur?=
 =?utf-8?B?MFJWeTI4K0xwMFZGb3ZCZ2J5azQ1NXVadUVTYjlOZURzT1drMDUxa1ZSeTMy?=
 =?utf-8?B?T2VSbkl2WndsUm4veHZOR1Bkc01ndklNR3RGU0pzQXM3YWJWSEJuTFdicWJ2?=
 =?utf-8?B?eU00WUFwR2NBdEc4c3lZVVZ2allRaTlzV3RIbVVUYk5QLzRBMnVrUGFPRXhj?=
 =?utf-8?B?OXhnSHVuaVNjTmhaY1JuVHBkZngzcUQzNnM3M3l2eEh0WHd1RXdjaVd3M3pB?=
 =?utf-8?B?T2tLYTdVd1hCdXk2c0FPUXZHMStoR0ZQZmJRbXJrdi81MU80Ym5hUDRnY2VZ?=
 =?utf-8?B?Qlg1dXo0K0lPQXVxYk14by9nWDgrbDlCMVpNWGVpLzY2YjRkU0ZmWG93RmFR?=
 =?utf-8?B?QjNCSHYvQ3lVekxjdHpjeTZ0bjlFK2lkZjN6K290YWlFZEZnVmFiVlhQR2pu?=
 =?utf-8?B?UTdld1MwalJPTEJXWkZIUTI3Sm9yVTNYUFU0aFpERFJQblVzU0pDeFkyYTBO?=
 =?utf-8?B?ZjFjL2xDbWh1OVVyV3lEMHJWbzNCelgwa240cGhVNXhFTUJvK0k1cFR5WFNL?=
 =?utf-8?B?azY2UWxPOWNRc08zcHNDU1pqRnpNUkZXQmUyR0VERlppUTJvOVI1d3liYytx?=
 =?utf-8?Q?x7vGrRMlS8Y05Nh/e1Sh3DZTt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d78e256-40ce-4254-3456-08de0a77a7c2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 16:43:36.8122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZmYW5fKEE6hRRa0FDSDjeAu5HKmY5zo1e5ORqZot8cuf2VbPqdl4Pz1lww4Rzkp06ZlPiEw5AvxfuNb2xKF1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8562
X-OriginatorOrg: intel.com

On 10/14/2025 12:41 AM, Shrikanth Hegde wrote:
> 
> 
> On 10/13/25 10:02 PM, Chen, Yu C wrote:
>> On 10/13/2025 10:26 PM, Peter Zijlstra wrote:
>>> On Thu, Oct 02, 2025 at 04:00:12PM -0700, Tim Chen wrote:
>>>
>>>> During load balancing, balancing at the LLC level and above must be
>>>> serialized.
>>>
>>> I would argue the wording here, there is no *must*, they *are*. Per the
>>> current rules SD_NUMA and up get SD_SERIALIZE.
>>>
>>> This is a *very* old thing, done by Christoph Lameter back when he was
>>> at SGI. I'm not sure this default is still valid or not. Someone would
>>> have to investigate. An alternative would be moving it into
>>> node_reclaim_distance or somesuch.
>>>
>>
>> Do you mean the following:
>>
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index 444bdfdab731..436c899d8da2 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -1697,11 +1697,16 @@ sd_init(struct sched_domain_topology_level *tl,
>>                  sd->cache_nice_tries = 2;
>>
>>                  sd->flags &= ~SD_PREFER_SIBLING;
>> -               sd->flags |= SD_SERIALIZE;
>>                  if (sched_domains_numa_distance[tl->numa_level] > 
>> node_reclaim_distance) {
>>                          sd->flags &= ~(SD_BALANCE_EXEC |
>>                                         SD_BALANCE_FORK |
>>                                         SD_WAKE_AFFINE);
>> +                       /*
>> +                        * Nodes that are far away need to be 
>> serialized to
>> +                        * reduce the overhead of long-distance task 
>> migration
>> +                        * caused by load balancing.
>> +                        */
>> +                       sd->flags |= SD_SERIALIZE;
>>                  }
>>
>> We can launch some tests to see if removing SD_SERIALIZE would
>> bring any impact.
>>
>>>> On a 2-socket Granite Rapids system with sub-NUMA clustering enabled
>>>> and running OLTP workloads, 7.6% of CPU cycles were spent on cmpxchg
>>>> operations for `sched_balance_running`. In most cases, the attempt
>>>> aborts immediately after acquisition because the load balance time is
>>>> not yet due.
>>>
>>> So I'm not sure I understand the situation, @continue_balancing should
>>> limit this concurrency to however many groups are on this domain -- your
>>> granite thing with SNC on would have something like 6 groups?
>>>
>>
>> My understanding is that, continue_balancing is set to false after
>> atomic_cmpxhg(sched_balance_running), so if sched_balance_domains()
>> is invoked by many CPUs in parallel, the atomic operation still compete?
>>
> 
>  From what i could remember,
> 
> This mostly always happens at SMT after which continue_balancing = 0.
> Since multiple CPUs end up calling it (specially on busy system)
> it causes a lot cacheline bouncing. and ends up showing in perf profile.
> 

I see, when reaching NUMA domain, the continue_balancing  should already
be set to 0. Thanks for pointing it out.

thanks,
Chenyu

