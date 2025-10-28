Return-Path: <linux-kernel+bounces-874043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5BFC1565D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57191506926
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3788033DEFF;
	Tue, 28 Oct 2025 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hwkpS8Gd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA6E3090CE
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664574; cv=fail; b=h+C1poee/5GS4PEUJpCERyhzaPxpHc+WuC1kyDpnXxArgifdoL/OhfZLHH4qnqNXeN/hkz0anQCfj66rZkWPA0yQxADmSB6mxnAC0JlwPKShCxdfRDjDoXdyAoPEOeF7VEzELAfZ/X5ZBnARQFAF1CWAhnU7uVmfaoJVtNYY4v0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664574; c=relaxed/simple;
	bh=fUVZnIJi3A4uCUHU+Zzv5WhQMUZs5VJZeZ0a4hJNLNY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K6/vBeCdTubTccCFm9brUFhqlUvLc2ssLSqXSm4O4VyFf4tBUGwXTUFEFZi3oknUyC+HbaAyzUxv2hZafakZ30ktFW6U3ee8wGZ3OlKQD2lPEEOT/YAmM+RgR7p/BRA7s5QqMet1qBEZXrEslzuSeVST+OU5AvyCQuyK7vQzrEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hwkpS8Gd; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761664573; x=1793200573;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fUVZnIJi3A4uCUHU+Zzv5WhQMUZs5VJZeZ0a4hJNLNY=;
  b=hwkpS8GdyNZeLvIMfXU2yEfB+K62fJz8e1JOHay3YeSlgN5uuZa67ulh
   M9pFKDXbd85P4DUHZgDfe1NnLVydIoQ2JJ4VGfZEBAa0HmOCzeJ3X/yF6
   vPaOj93bMU/Y9/JFqcCHvw2+Cjm0tcVesmKbwfT6cfa6mv2t0+0VLGB8Q
   8pWIBh0cY3XgFEx7RPQdQ9TyLpk1F7uaz9J0d0LtbH8z0u7k8qkIFs0Mt
   Bph+dhMODfz1WV599Xy8RYBxJJSqkgjjPAbCOeDoLjmq3t1nP+LcN5tly
   wv6PyZfoSrxqoupeIWkuz8EZMSH5XtOxgu6lelWO3Ty4zotA6Uzuzazh6
   w==;
X-CSE-ConnectionGUID: lV9AYJHuR2G9jBSQwbdqXA==
X-CSE-MsgGUID: EiwZgcX3SJ23UnFgbZNgKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="75214621"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="75214621"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 08:16:11 -0700
X-CSE-ConnectionGUID: ocJkwiIzS16m1NjgG/Bdgg==
X-CSE-MsgGUID: +2mEsfa4RRGOrvRuhd/waQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="184999487"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 08:16:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 08:16:10 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 08:16:10 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.44) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 08:16:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YgsmTFR4lc9mAi+9UOV08Qhe2oMlP9ovPk8+rpi+3eXWzc0rwOwTcb7BqGdMq1c1gi9hiyQXZEwSy4PLnMk7NivKxDTmZFS1h7i8tgncz0HAAx/OvXPzmRPHw3Q2b3HAjf/HCU8Xk8q30PDK3mYo15IY0z8wCQ+LaG7YDJrgAUcEFsaLGjCXqLRmZwV273tU9CGcXmy2ckGOEm+y1EH68Cuq//qeedWsKqsJAl7n4BchtxkPe5AHY4/8fbxxibMl+rn43bADg6uNTCWeT4qO4JOJNw7AFcsr6gtA/CEooLGE6kezpLAXLJ/r2JOMNedSFSAUhHw6Dkbw/sXXESfYfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlW+4teZ2ViEknrlIDbjZ+jgvlszmc6mVQOm9KDVPTU=;
 b=QhEXcEtc/gbITgHlQ7BHmhlQyYTG3C5zZyqX1ypJgcpJ9cTG++codDBrs9wHcHc/gT4VX086nWrsjZLkJcMjVQdznTp5GxAd/5/UMdQRDb+a++lqU3au7sq5nA+G2H4DWJAkwI+uANKyjMmxbuGaCTcayLvHIECxTK2/nbE83zgQNf0iasEBJx7ww6a4LYS2byw8R20OCNdMB2Sth4WrJJnBV9FQVSgBDbMGfmBZiP+EuI4orUTa9R0tdslaSJfePswPi7zfcikuEK2QUZyTNG6AZGooMqz9S687nxFUFrP9QqtHFOmL0gGgyflUnVak3z20FEWEm+RnDi79wA49Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CH0PR11MB5283.namprd11.prod.outlook.com (2603:10b6:610:be::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.12; Tue, 28 Oct 2025 15:16:07 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 15:16:07 +0000
Message-ID: <ab01cb87-71f6-4893-833e-136e7acd777d@intel.com>
Date: Tue, 28 Oct 2025 23:15:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/19] sched/fair: Track LLC-preferred tasks per runqueue
To: K Prateek Nayak <kprateek.nayak@amd.com>
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
	<tim.c.chen@intel.com>, <linux-kernel@vger.kernel.org>, Tim Chen
	<tim.c.chen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <ccbfda37200b66177a1c1add4715a49b863ac84d.1760206683.git.tim.c.chen@linux.intel.com>
 <fe5eeffc-ff8f-4bfb-b0a1-5b25731afb88@amd.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <fe5eeffc-ff8f-4bfb-b0a1-5b25731afb88@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CH0PR11MB5283:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bbb67d6-0342-4e82-a5f5-08de1634eb53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OTN6NXpIelpLU1VXK1l0VEdmVEt4ckNRUzJyOE9BakQ4UU4rNE10Qk5ZUldQ?=
 =?utf-8?B?MnhTNzkzczcrTURZWisrSXpyTDkvTkNVamtIbFA0RjF1c09zaWpIV0NIenU3?=
 =?utf-8?B?ZE02TytwbitYWG92b1Ivbjh4ZE9nZFV3bmlTb2RTUVBnUHNYR0xub3hZeU1J?=
 =?utf-8?B?QVRqVnE1SUFORUt5UjZUVTJGc0lhQllnOTNNZk9DWW1kMFZPTTNaRDVJS09R?=
 =?utf-8?B?dGx5eHBRNktQRWlEQWk3R3M0bVFIZS91WGZtejB4azY0cXFGd3VFdW9ZRzJh?=
 =?utf-8?B?NnBJVU5ac1pVNE1sNDdLbTJpaGU0L3o2dEM1bGx2Y2duOUkrL0FiQXdxcEIy?=
 =?utf-8?B?WmtIZnFUQTVvbU5ISWRNbENUU3ZVdGtDS1Y0bmxiT3g3TzI0cmd4Z0JWNVhj?=
 =?utf-8?B?K0xtaXEveDduRzZ3Y3BFeTJ5NjhqNnB1bWZoMWhTdzVnM3R5bWF6TER2SWxJ?=
 =?utf-8?B?NFJjQnZkVnJRajBsSGIyaFdrRS9IbmFlckdzTWNrSTBXTEgrZFJUSUo1cjRD?=
 =?utf-8?B?S21WZ1c2ZmhPVWtXQjdmM2IzVEV1RE9rU2ErVWNJR1JzYjFVWm5PSkxsOEsw?=
 =?utf-8?B?akJIeVZ4bjl6Z2xxZmRaM0w2c3ZBbkNwSkJSSmx4N3NUODFoczBNc2NSbGlK?=
 =?utf-8?B?eC9tYnU3NEtyODAxWnhhOUVGZVVudzNJdHh1UEZzdWl4Z0tKKy9lblpBeG02?=
 =?utf-8?B?dHFwcXFzUkxOazdyUVg0cG1uN1ZDOXk2dlRpNzdKK0tSU0RsK05NaHZ2Nlpv?=
 =?utf-8?B?cWlUVVdWbU1kbkxuUndON0ZuOFZYNXZLSndNZkhRbGl2U2hLbVYzQ3NwS3dR?=
 =?utf-8?B?OFJOM3FHYnYzU2lrZUVpeXRFTSs1RmhxeXB1M2FlcWc3MGh6dHdmYlRjNkRu?=
 =?utf-8?B?S3ZFQStaVnZaazJrbjJDUy9QWTdSc3V2bEdtU3lJZGNzUVVOdUNUYng2Mzh2?=
 =?utf-8?B?eFNaNHFON24wUmxRS3VhSlphYlk4L3laT0FVSittMEI1TTlMYTlsUkx3Y3pG?=
 =?utf-8?B?bE1GaWFicDd1cllKbEo2NndVakpFbDlPWFlzOWQrT3U0VTZlMVE3NE1idDNk?=
 =?utf-8?B?SWF5WW5oWFdXT21oVnEvdUs2L1ZxMHVhOGE1ZXpHVENXSHRNeHhjMFlkdVZQ?=
 =?utf-8?B?VHpEUzIyaGZ0UjUrTU1OR0dEYlpCenBzYzRhNWpHVXMwZmRQUGRYbEFRVnQx?=
 =?utf-8?B?RXFDR29ZbU9NbXlSZmdQcEVtWk5haUFtVFlYWEtzMjlQTjA1YTVIT2FjOVdT?=
 =?utf-8?B?OWNvNzg0SVZTdFJLWFBsTW9peEpZYmQ2ZFlIbXdES09jeVk3MklEY08raHJM?=
 =?utf-8?B?cmtabEF6ajd1cWdrQVlzYUVPZXo3NTBPdWVoSmlMb1FRczl0ajQ4bEVMeVBV?=
 =?utf-8?B?djE2TXFFa2t3dG4xOERZaXBwcmRyVUVNUGtpc0R1UTRManpBWXVhaUE3alhS?=
 =?utf-8?B?a00rZjA4TUxkU1BnZjBHbFhiVVladVdkR1E1R0RYRFR3cWNoRFErUitRZGFD?=
 =?utf-8?B?UE5zNG1IVVdZcDNEVldQbzdRcU1qcTFOYnhDV3RPK3JiT2RYbHRtZjc4aGds?=
 =?utf-8?B?ZVJrYlg5MXhiU1AzVkRROURZUzBXQkF6OHZ2Z29zbzhLRTBIWm5NM3FnMUtp?=
 =?utf-8?B?Vk5HbmFCeEg0RDg4M0ZGVXBqamVYVDlkaVZWb3NhbUFZZHEvV1FSdlgrVlMx?=
 =?utf-8?B?UEJKVzQ4aVFiWVFzMDRpQUE4dHhJMytaVWRBNVNBOEV1eXBJSG1xTDBBcGJk?=
 =?utf-8?B?M1lCL1pKbWp2WEgxeGtZbzdFZzZhaTYwYURCNUNZYzFTaFh0a0Z0YldiTTNX?=
 =?utf-8?B?ZzYvQ1FMaEsvYndmUnVkZEVKbDhnZjF0QUh1dE0wQmt1UWFjajdBL2ZiQm1G?=
 =?utf-8?B?RDF3UVRCcGowbXNhajZrMENiTnpCTzlpZElhZ0pta0ttb0c5b25vTWt4SnlT?=
 =?utf-8?Q?WFb8B/AILsLwi5LX9N6RM+KKcfzGkF8L?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M05CclgyQ3J3RUhNQkNLeE9DT2RlemxCUTUzT09BQWVJdGRSbnVRdkZwc2dQ?=
 =?utf-8?B?NDZtSkl4QjUzTlVEWW4vVUhiRENodklyS2c2aTNrNXlYOG5zNGlrbzRzRC9R?=
 =?utf-8?B?WXoxRC9MVEF4c3luYlBjNDdRL1BMcHZJKzhSNEdmMEpKdFhvK2dQeTlWdHlk?=
 =?utf-8?B?eVhSNU95NTcvZVZ5Q05EYmNlWEpZcEN1RTZiQ3YyODE2VmlHR3RIWS9RYXRI?=
 =?utf-8?B?cDlEc2Q0NnFTNUFNWS9RNllQK2VRZzF0ZnhGMWpGNGFEYWNUTFpMOFFvN3NI?=
 =?utf-8?B?MXNNS0h1UFp0ajBjenhUZ2tDWk1Ma0RKOXlMYi84SVFJYzVkQUJJaU1nRXYv?=
 =?utf-8?B?TzRUZmwyZEdHbkV1T1lVV2lwYUZIZE5KcGJqaFk4TlV2ZXdOSWQ1U08yeDIy?=
 =?utf-8?B?Z3FpVzJsYTZoaUdjaWFUZ21KTGs2Rk1JUlMrUDVFbVU5S24wQUR2K2V3S3Bu?=
 =?utf-8?B?NGwrb3ZsRktCNWtlMERGMEZKMml1SDN5VTBGTmxqRkFpTjNvM3hiQTF0QStx?=
 =?utf-8?B?R2hEcVI1NHgrdldRTkZoZmMrd3VPSVNrRWtDc25TNVluTnFkaEtqcXQ1Tmg1?=
 =?utf-8?B?YmRxYVBmblR4dGI3L0VtUmpJdnZvcFFIR2F5ckZ3TGhuaXB1a3BMYkR1MUdC?=
 =?utf-8?B?Qk1CQ09uc2NqSW90cjl4ZmtHNExtZ2VlY3BYb3hRY3F4Rk5ydDVCbkE4cVZL?=
 =?utf-8?B?V0NRWDdhZ3F3dDA4TC9QSnViRzBJdTU4OGxYWWF5TXA0WDR1Tzl0Q3FLMTBS?=
 =?utf-8?B?SHZzOTlFQ3IrUndlNlBQTFhzenFrUkF4ZjRNbjZhMCtMS0c2aUJNK3hzZUlq?=
 =?utf-8?B?c282WnZKNTRsTFVnWmsrcHRMQitRTTIweFU2RnhPbXRpcGZZaVYxWXpzQkNL?=
 =?utf-8?B?aUlVODluNDQ2cVFpZzdCa3YvVmxhSTlhMWNLcXpUOE5rbHkxYXkvejB5Ym9D?=
 =?utf-8?B?Zm10dXBMNlBYTnNsK01zTWMrVEhKRWdoMFBxTHc0NHpmanl0RndsTHpvRHB2?=
 =?utf-8?B?SVlGbFQxcG1qZVdqZEFmUzJZK0UzOUJ4RzdTcldmZ21ETmlrcUY5Sm9HZEhY?=
 =?utf-8?B?NTJyaSs3RURDK2ZBUE92OFhvZkJoSWVPTFpoeldxRUZodXNXeFg1Qk45SDd1?=
 =?utf-8?B?Ris2YXZFbVBYOUxUZ3c4OXQ3MDBCS1RGdU13eExLVWdVcmlPYjAxbWZUUVZZ?=
 =?utf-8?B?MHRPNnplRzlmS1BGM1pVYjJsUTdjK1FRcEN3SWFneFgybVF4QVh1ZHduVVRk?=
 =?utf-8?B?YVNad1ZobFFOVVhyU2tnRFRUOEZxZUZtcGU1cmpiQWQwbW8rMFh2S1kzWVFa?=
 =?utf-8?B?VXhrbmFhNm14YjhmL2Z4Qk93RFBObGF5Tm9mVjdlQmRUbDYvTUNkOFFxTW9i?=
 =?utf-8?B?YVowdG82SjlzV3ZzdldSdS9DSk9zYmJyVlFZcHUwVlpuNDBjUEtGTDQ5a1Vt?=
 =?utf-8?B?emFSRUNhNW1yOWFXQ2pzWlBtUHhJN3VNSU9ERmlTVFUycHNudG56VFYzWmlW?=
 =?utf-8?B?aU5yd0R0SVpTaWtPcVA4TERGUzNiZFFHRWM1N1cvSTdMQlNBaGxTenI5Sms4?=
 =?utf-8?B?aEpFTjVFLy9HTlNiUkovSVBSUlVIMUVuZEhMMUtFTkl6aWNsNWRZVEltTi9B?=
 =?utf-8?B?ZjUwWWZTd3lkbVZMUmY4TXJUN3VVUFdrUWlIQTBHanMwTlBTNTVTQ2VKZi9i?=
 =?utf-8?B?YTRIVWxSOWh5WEZYUnc4QkEwZ0Rna1dRUURNa3hDWittMHRPajJTMklWb0ds?=
 =?utf-8?B?K2xyOU1RNUhLSDBjL1lRZHlQb0RmTWlxWGZxblRURkJTeHNjQVlqQTR1R0x4?=
 =?utf-8?B?ZkdoYUZpd2tvNy9CRDJJbWtQOFZaNW1ZcmM3UWZhZWpWcXJBRGh1YU53akZj?=
 =?utf-8?B?OFJrT2NEWHVLTzFQaHhqdjI5OVdoenFrcG1Ea1dQbkNxaTMrTU00aTdKMGVm?=
 =?utf-8?B?emlsU3hBMUQxZXZ0LzRBUTU2MjlqYVhkMTdGQ1BXZEIwRVRFYTJrR1MzTkdk?=
 =?utf-8?B?bGQrVUF1cmxWaXJmL05Va2dzK1BidkJZZUl1cWZHL0N5R241dHVoQ2pwWnRq?=
 =?utf-8?B?ZWlla1BZajEycnRUamR0VmdlUGpPN3RHZnZmQmNCdGF3QUFUU0xPeVFyOWhI?=
 =?utf-8?Q?XUP9GsvGGM0Qnpw5H/Ic7RPRm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bbb67d6-0342-4e82-a5f5-08de1634eb53
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:16:07.7363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7IiUVRBEbUw7KMmMvNoUPIjr4Cv6HQtdXJFBsuuu9ySpH7PJT4RZFHcjYXTXV3Z9WeYPtCnt5qnnnyUhNUKJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5283
X-OriginatorOrg: intel.com

On 10/27/2025 2:04 PM, K Prateek Nayak wrote:
> Hello Tim,
> 
> On 10/11/2025 11:54 PM, Tim Chen wrote:
>> @@ -3999,6 +4038,7 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>>   		struct rq *rq = rq_of(cfs_rq);
>>   
>>   		account_numa_enqueue(rq, task_of(se));
>> +		account_llc_enqueue(rq, task_of(se));
>>   		list_add(&se->group_node, &rq->cfs_tasks);
>>   	}
>>   	cfs_rq->nr_queued++;
>> @@ -4010,9 +4050,14 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>>   	update_load_sub(&cfs_rq->load, se->load.weight);
>>   	if (entity_is_task(se)) {
>>   		account_numa_dequeue(rq_of(cfs_rq), task_of(se));
>> +		account_llc_dequeue(rq_of(cfs_rq), task_of(se));
>>   		list_del_init(&se->group_node);
>>   	}
>>   	cfs_rq->nr_queued--;
>> +
>> +	/* safeguard to clear the cache aware data */
>> +	if (!parent_entity(se) && !cfs_rq->nr_queued)
>> +		reset_llc_stats(rq_of(cfs_rq));
> 
> Instead of relying on reset_llc_stats() hack, I think a better approach
> would be to have a "p->se.llc_sched_active" flag similar to how uclamp
> has "uc_se->active" and we set this in account_llc_enqueue() which will
> still check for sched_cache_enabled() but account_llc_dequeue() would
> only check for "p->se.llc_sched_active" to decrement the stats and then
> unset the flag.
> 
> That way, we cannot have an imbalanced accounting. Thoughts?
> 

I suppose what you mean is to avoid the race condition between
enabling sched_cache and EQ/DE_LLC, similar to uclamp:

         enqueue(taskA)
         // sched_cache gets enabled
         enqueue(taskB)
         dequeue(taskA)
         // Must not decrement rq->llc_pref for taskA
         dequeue(taskB)

We'll think more about this.

thanks,
Chenyu

