Return-Path: <linux-kernel+bounces-871647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF0DC0DFAF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 544EA4F4EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E48625A2CF;
	Mon, 27 Oct 2025 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JlOFN/tJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C0825B1C7
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570866; cv=fail; b=YIQfMLBDL7sPCtTBsPf8yzxH5nc7j3FX/9VVYQu4DC8BAEZc/q846lcWexxkfLhe+74gyow+LoiWWJsUw7OytaKclPyHhT4939UbeYQ/QtQ92thG8QLDAQ3P55NO+3CDgXl6mVe/KkrUSSL3Qf+39g4TllynNXTyf1G8dNSbC+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570866; c=relaxed/simple;
	bh=jicHoCn+xJ2U+MFq2ktC8fL1vdBf/XBKqOZZCan3LbE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T/bAJ2Utjfk+QyyBiIdPk+wox68ciLt4p3MbPEEmNWuazkjul2vDpxYhteOVo/F9/htNrvK6qQV1GHQC16HX9TSfiIcOLkKNtroznVP/W+r4wvrrbqr3eMo10eGFV+govFZ22yO0ityuixSfdy+Nc/9JAPPpcX6LgeyZhCbxkI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JlOFN/tJ; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761570865; x=1793106865;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jicHoCn+xJ2U+MFq2ktC8fL1vdBf/XBKqOZZCan3LbE=;
  b=JlOFN/tJQTB6c6n4sjy9YLDoX9Hhc0mudij2WjkksDIaAkLE5ZOBmbHT
   zLmtUAU0rJ5u4lfwjQ5NfzVuVsUKUO9Fw1lIfwGcFU5z1nH4hszzgT5rQ
   2GFF02koa26kla8WbU8IzZ9qNawo6xB8fmZFJwh4lcM1cxPaBgenMwTS5
   IpAI89wUI/IAvqDNaoIJmF8SneBQvGge5AZS3OgxXhlG30aaZYO3UelR0
   ECi/zNXpLLfLiF1xDw6QGgLtjpkSac1GQle2Dig4YKufrs/SmjSMn/yrW
   /uJ8sfKFRBMMGD1ZlzOWX8wAVdLXXalGS9iUEy+u5ZbHKF+7S1GOKrwqA
   Q==;
X-CSE-ConnectionGUID: 9YB7ie7JQaSF2xZwRDDfQg==
X-CSE-MsgGUID: OWCZHcggRgOfeatGWCN9iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67482790"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67482790"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 06:14:24 -0700
X-CSE-ConnectionGUID: EgJWQqTNTXq0h7Dg3FUVaw==
X-CSE-MsgGUID: aNHd4sGdQ2iDF9keu0aUoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="185506966"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 06:14:24 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 06:14:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 06:14:23 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.43) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 06:14:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezybxji/AoI6Aps1xlL3lVV2LkB7IMHHufxZ1cnkRXsdsq2U/9ZP6aGdrJLkiOmzRFwGec6c9au0QNO47e3+L5of6Y7UQEdTy4dXM+W+1I2MHm4H31pM/W+Y4alqiwOHgTNRHiyyhFduWP7njir7VgwpOQSo9obljJ++K0f03bzzg8T4Ck0Dp3n6phdL+hCBaq/4GTUEp0P8zhG+KQtt9gA+oXMXZcLnpmNYUvGIXsmHsaS77MkpHEFgkymP1HOH095TT6oybMRZKrchKZUwchKV3lcMG4MCyXo6LMgbKIekmaQBLeuUmALKR4gJdaSRldihQi7c/RHwII3QV2bQAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jicHoCn+xJ2U+MFq2ktC8fL1vdBf/XBKqOZZCan3LbE=;
 b=XNWcTsWje9kxMwnQDbR4T/xcB8R3ImJv2oVGFiyc958WNDcm1EVFZbk9C5GCC2l/X9f6ez/H/jCSXRCiUcdEh+2bYYM8rTDUyHCarcB37wAwH/RudxCQQPk4NGNOJ1wZY/ygQtEoL0TVQifscapPrw5gnFkyC0Jad595EXnjtayUDQim4rhEMRtvqoAsM0DG7fcqsSHShixs6hcn5ulPl7w6kxxkUaQKitQyjm8rNc66CndoYhBxz3SYn2yhid67sVGRyim5at3sLozyMAgkVHcDFZu/E5HdGEzpb6Ib3I/vTJhClKG3kkn3rlSdMOZN74NcxHozfgRa1w4AZAJ+VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DM3PPF6A4412A55.namprd11.prod.outlook.com (2603:10b6:f:fc00::f2a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Mon, 27 Oct
 2025 13:14:19 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 13:14:19 +0000
Message-ID: <3b30e40b-f1fb-4145-b4d9-a9279b9602d8@intel.com>
Date: Mon, 27 Oct 2025 21:14:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [tip:sched/core] [sched/fair] 79104becf4:
 BUG:kernel_NULL_pointer_dereference,address
To: Peter Zijlstra <peterz@infradead.org>, kernel test robot
	<oliver.sang@intel.com>
CC: Fernand Sieber <sieberf@amazon.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<aubrey.li@linux.intel.com>, "Sang, Oliver" <oliver.sang@intel.com>
References: <202510211205.1e0f5223-lkp@intel.com>
 <20251021110449.GO3245006@noisy.programming.kicks-ass.net>
 <20251027125453.GY4067720@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20251027125453.GY4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: base64
X-ClientProxiedBy: PS2PR02CA0082.apcprd02.prod.outlook.com
 (2603:1096:300:5c::22) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DM3PPF6A4412A55:EE_
X-MS-Office365-Filtering-Correlation-Id: cc096d5b-6683-4d15-f713-08de155abcc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjlBUjY0bzFtTFNWcTcyZ0dqeStRbmRUMi82ekR1NCs0UWNoMldlNmlwajB5?=
 =?utf-8?B?SDRoZk8yRzNFWkJNeCt1SkhOWHpvSXdnWjArZGN5dFhkblFnNG9pTFBUaDcr?=
 =?utf-8?B?MS9LODRyZ0Q4SDYvNEE5RUo3UjFDY1VaeExHN2l2R0QrcXpBUzd5eiszU3pL?=
 =?utf-8?B?V3k2MXhXN1lhY1luc0JxOEFDbGxERmo1ZWYzcFVOL0k0NXFHK1dFbjhISkhX?=
 =?utf-8?B?MW4vSFVZei9CZDV1ekhTZGhuV0ppSExVSS9NMFNVZXRBNG1JY3Q2MGNrcEF1?=
 =?utf-8?B?WjQ0dEdVMnFpeURtQzFzcWwveEhsZjhBTWpxUFJGdS9PS3ordUJUYnJwVEp3?=
 =?utf-8?B?ek5paXB0Z2tUbXhySitLNzFZSEQ3alFIZDRFVWxrRTFnbkZXczd3bEFadWlt?=
 =?utf-8?B?QkV3dkhhcTV5ZmlzdUI0djJQUUs3bDNVclRtMlREN1lOUytOV1pEWEN1VEs5?=
 =?utf-8?B?bnNUNEVta0cyK25LRTVGNEtCdFhKU0hKKzJLcXA2Mlk4MzJwRkc2OXNqVUxl?=
 =?utf-8?B?VEY3d1o5bnJwa3A1SzJmUCtKY0NpUlR2TGpTYTRsK0pydm4yNExUcUt2amRF?=
 =?utf-8?B?aVlBUW5aYnBrZVdDZC9vY0dsVkg5NkxBRVJkMWRKWGQ3Rm9YclhESnRkRUUw?=
 =?utf-8?B?cUJYVUFZMVdVM2x6dlZJMklzZHNqRENQQmFWUmQ4UE1YdlNoZEVlemp1Y1hy?=
 =?utf-8?B?eHpua05kS1FnRFdUc2g4eXVmaHZZb1pYTUpNUTBTSDZSNXhUeEtIWHovMUJh?=
 =?utf-8?B?UU1taUs0SVVCNFRveU94N0dvQ2dBM3VoZFZFZ3pUa25ramRwTHQrRlFzNWJq?=
 =?utf-8?B?dDI0aG01c2dVV0NmdXE2QmdFWGpsdXVORHVwUjJrOEdLVVpwK0FRTGxiNzRj?=
 =?utf-8?B?djZuVUJCVGkxQ0xWcGR5MzRTK3U2U3hwZjQ0TFRRb2ZOR3F6cmFXcStBL3hS?=
 =?utf-8?B?RGhQdDI1VGwzNWN5NE5zTDJDa0JoS0ZPYVVDNmNtNFhUdlZjVFE5OUJwZTVq?=
 =?utf-8?B?TmZTT25rZ0JpNE8zVEJpZTRvM1NCc1VOWUxTNlIybzBsMWNjT0dmVjhUR0Rw?=
 =?utf-8?B?UWhUenhjd3ljZG9LODBISkFjcXZic2NVOGZvY3UrMzlvSGYvVEJlQ1BHc1B6?=
 =?utf-8?B?WmhrMlh3dGZFTkZwVU1QTG9GWHh5RC95cXlJYTJjUkVWVUN0cHFqVms1bExF?=
 =?utf-8?B?TldLVzJzYkYzVnY3OXdPaFllSWdzcnA0QWs4YVFDa1VEWXl6czBFVkV2UHR0?=
 =?utf-8?B?bTNVb2RTZUZ0VFFBQnY1c1dMNGtJT0RkRDY4a21nMVgvd0RoNU9IazhuZmhp?=
 =?utf-8?B?V3lHUFJWVVNNZVZVeXVHMmxuM2tiK3VoSmdZeG42N3FMU0pESmZlVmhqakVX?=
 =?utf-8?B?R3dHaHJFdXkvZ3lPTngwb2tKQVVvSzNRcGZxMDEyMUlhSkJLaE5xOU1YZklh?=
 =?utf-8?B?RGhZeEdLVWREajl6MTRSVTIzejdNSkZSM0FlTGQ3Q2hFbFVNcVFkZEJkL3hq?=
 =?utf-8?B?ZUlJMG42RHNNN015SVdGd1RSY2xYVTZjZ2xYS2NCSThkTzE2am5lZHEzclVh?=
 =?utf-8?B?YWh3c0NhaGw2TEdQRCsrSlJ3M2pwYlJTQmRiNmJYNy9tSTZ4dmkvUWk3b1Z1?=
 =?utf-8?B?T3JPbmJGRjEwNTY1UXlrcWZJVWpmdnh3SzhLcWdlVk1LR2VteUxNS1RMdWIr?=
 =?utf-8?B?dXlzbnk1TWluQzhRQVNZeHJkRmxrWU1mMmxUbEFtWjJyRVI3SUl0cUgxOExq?=
 =?utf-8?B?S3ErWW1CSkhmWGlyeHBwOEpjNGg5Z24xc3hUenV0STM5OFg4OG5yS3hWSlFz?=
 =?utf-8?B?K0lIRjlYV2RwblBiUlV1WkNCK0VkTFA5MGw5eEt6MGpLZ2FQYXpaR3Jic292?=
 =?utf-8?B?UUFDWTlUWlpKSmFabWlwbmRGTDhKbjNEQ1A0VFRXYXJNSXpRelNuY2FqaGY1?=
 =?utf-8?Q?D+/lCKmNHDg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkR0MWxUeURRZ1NzTVZ6VmRtMVArak50VHFMMmFaalM3V0gwWXN4WWp1VUR5?=
 =?utf-8?B?M3JxL0s0elIrMUZlMGpPc1BBSDQ5aTJEOXI5SWJhS3BMd2d5eXAyUWJxUU5N?=
 =?utf-8?B?RW5oeEo0bFJ5VkVWazNBWVNraStETklJNWt6NmsvKzlBN3locGZWcWpSakZX?=
 =?utf-8?B?ekRTMWczR0lSRXB5SHFzRGhXYmFkYkN0VGVwUGhnUWJ6SWlsVmxTaStzRnU4?=
 =?utf-8?B?M3pHNElYOEl3S3hoSUMyenZLZ0hjSkc5QlBUYmF1aU5CTTlTYlMzMjk5aDJG?=
 =?utf-8?B?QkQvM08vMTNmeHR6eFZVY2N0YlN2ZjZzem1veUZTeFN4ZjdKWmNwcnc2S2kw?=
 =?utf-8?B?VG5vMXdOa2M5dlBqazJGbHd3ZVgvT29odk8wdWRnNVU1RmxLZUVLZ0Zrdncw?=
 =?utf-8?B?emRTRDZmclJzVXB5U2lEeW9PTFFWbmdrTkkzZi90YURxbjI3dkxpS0VmNnVU?=
 =?utf-8?B?VmNJMnhVMWc4dHUvS3lJUkEwWlpENmRyRjJEazdTY0Z0b3UrdnZsTHRLQ1c3?=
 =?utf-8?B?VSs2TG96RVN5ejZhZlVHTFllVFhBVmVSbXI0ZXpEMndTNGtmdThFZlJRNjdW?=
 =?utf-8?B?dmVVVzlFZHRyNlRla1BYV2ZrWVZ1YWZ3VzNtajgrWTNXeXNmQVI4UmVSaDFG?=
 =?utf-8?B?SjZLSjQ1azJlZVVqczFWUWxpSGRpbmJzT0l1Zi9ja3gyQnNLanJjenhyVGpx?=
 =?utf-8?B?b0xhenR6ZUtSdHZNN2xHRmVDYWdMTnR5a0xobmM0VFBiUS93b2kyckJ5ZS8x?=
 =?utf-8?B?aldWZFl4Zjc2S28wcXR4UmUzSTRzSThuaUY1YjZrbHRqWGgwSzEwNER1Nk1W?=
 =?utf-8?B?bCsxSlJBS3FadGk4SENYTHhQRkxTekNlcW9COTRtVnpEODJYaGVXRHU3L3Bt?=
 =?utf-8?B?dTY3THZMY0ljMHI5YjNYeHVEWFJ6U2dYVHorOW5kYVdhTFNZUzNRakVCNFdi?=
 =?utf-8?B?RHU2S3pyeVZCaWhqWFhqdm5ZdytRczNGQ1prZ3MxSzJsMHdrMmtGbFBFRGVq?=
 =?utf-8?B?bVZNK1oxUEVVVFE2d2R0RjQvSndBdzZoeTMyRmFnVDBZR1QxN0JMWXVHWVlm?=
 =?utf-8?B?UjNKSFNwY1FRWWZsWGlZblBvLytZbWhxUWg2S3ZhY1k5MXY3VkZ5MVJxNVdQ?=
 =?utf-8?B?Z29yd2UxRTBwWXcvYUFYOE5EY09UTC9hVVNFOGdYM3hRR3grbThSQWcrVnpo?=
 =?utf-8?B?VVhtak4xQ3NjTHk4UGxLU3JnUFBETkNVK2NheXo5cmVKV1ZiU0VndEIrUWJn?=
 =?utf-8?B?Z2pvWnNBZjJZdy9HRHE3STNwakQ0MkRkbHlHbDc1T1NlNnk2aEtsWHFJTXFQ?=
 =?utf-8?B?bFJqczlQNU1qM0MzV0ZGS2IvbXFjWkVVTklVZUJVenZ1ZklWRExLWStsTEpC?=
 =?utf-8?B?c0ZkcHo1T0c4SGRNc3pkazhNNFRHM1BJc1VQTXNpNnJ5WjhSZmtvQk84Mk81?=
 =?utf-8?B?V0hNS042MUdvYUxqbHArZWhsY1Nza3dMNVQrZkFWcThKa1kybW8xRGJPV3po?=
 =?utf-8?B?NFVUMzMxUERsL3JXUlgyUzc1cFRFdFpVYm1CS2hCQ2dhUFc4UWl3SHVLbnVt?=
 =?utf-8?B?ZmswUmZqUW9RdGFUdUpoeXVrOGR5ZVArM0F0cmJDa2huTG0vN1pzMzhqYjlu?=
 =?utf-8?B?MEY4NmZGVk9SUTVqM2s0NDhkTnpFb2NXcDlTeWVYYk5wS2pyaDRCbjJmRUZR?=
 =?utf-8?B?cEwyV1ZxQmVWYlVvcHBicHlTd0tueHlGODdCQWNuVERLOEtZOEZadW9DdnE4?=
 =?utf-8?B?bXUzbFhpTzZMVDFCWURHYXlYZjREUExNeDRvODN5bFkwbEZmS2pHSnJ2bEl4?=
 =?utf-8?B?Ymx4N2dmQXZDSERTdDJvcWl3ZlM2elJjWDI1Qkc4SzA2Q2RIaWhuQ1VHdElT?=
 =?utf-8?B?R2hSTWJlRDdkcHg5SXo1dnhCYVcvdktWRE56Z2NUdE5WdU4yWG9qdFFjVjh3?=
 =?utf-8?B?eTBCVkpXV0VST3o4YUhaVFg0cmhwY3JkVVhJOHZzMG0rYmJCRllVMkhvL3pW?=
 =?utf-8?B?UVZrZ1JFQnk3S0RoKzJiMHFkb1krSTBkUXNzbUZZQXFWQlU2bHZYcWpPNDgv?=
 =?utf-8?B?cXBaT3VrNXdOM0xucW9lMFNjSy80V014dXNiMzIzQlN2Sk9odGRFMXlNZk9G?=
 =?utf-8?Q?8HqObFYjvzVibZdacCbaHsuW7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc096d5b-6683-4d15-f713-08de155abcc9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 13:14:19.5651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpg7SyHHuKqNhc8yklwtElFNFs02rZaO8Cf+oJdaahCenQjyhOSnQmgV0IzXyM9kexRGZmVgXY26QYMbNBA0zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF6A4412A55
X-OriginatorOrg: intel.com

T24gMTAvMjcvMjAyNSA4OjU0IFBNLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4gT24gVHVlLCBP
Y3QgMjEsIDIwMjUgYXQgMDE6MDQ6NDlQTSArMDIwMCwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+
PiBPbiBUdWUsIE9jdCAyMSwgMjAyNSBhdCAwMToxNDozNlBNICswODAwLCBrZXJuZWwgdGVzdCBy
b2JvdCB3cm90ZToNCj4+Pg0KPj4+DQo+Pj4gSGVsbG8sDQo+Pj4NCj4+PiBrZXJuZWwgdGVzdCBy
b2JvdCBub3RpY2VkICJCVUc6a2VybmVsX05VTExfcG9pbnRlcl9kZXJlZmVyZW5jZSxhZGRyZXNz
IiBvbjoNCj4+Pg0KPj4+IGNvbW1pdDogNzkxMDRiZWNmNDJiYWVlYjRhM2YyYjEwNmY5NTRiOWZj
N2MxMGEzYyAoInNjaGVkL2ZhaXI6IEZvcmZlaXQgdnJ1bnRpbWUgb24geWllbGQiKQ0KPj4+IGh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvY2dpdC9saW51eC9rZXJuZWwvZ2l0L3RpcC90aXAuZ2l0IHNj
aGVkL2NvcmUNCj4+Pg0KPj4+IFt0ZXN0IGZhaWxlZCBvbiBsaW51eC1uZXh0L21hc3RlciA2MDZk
YTViYjE2NTU5NGMwNTJlZTExZGU3OWJmMDViYzM4YmMxYWE2XQ0KPj4+DQo+Pj4gaW4gdGVzdGNh
c2U6IHRyaW5pdHkNCj4+PiB2ZXJzaW9uOg0KPj4+IHdpdGggZm9sbG93aW5nIHBhcmFtZXRlcnM6
DQo+Pj4NCj4+PiAJcnVudGltZTogMzAwcw0KPj4+IAlncm91cDogZ3JvdXAtMDQNCj4+PiAJbnJf
Z3JvdXBzOiA1DQo+Pj4NCj4+Pg0KPj4+DQo+Pj4gY29uZmlnOiB4ODZfNjQtcmFuZGNvbmZpZy0x
MjEtMjAyNTEwMjANCj4+PiBjb21waWxlcjogZ2NjLTEzDQo+Pj4gdGVzdCBtYWNoaW5lOiBxZW11
LXN5c3RlbS14ODZfNjQgLWVuYWJsZS1rdm0gLWNwdSBTYW5keUJyaWRnZSAtc21wIDIgLW0gMTZH
DQo+Pj4NCj4+DQo+Pj4gVGhlIGtlcm5lbCBjb25maWcgYW5kIG1hdGVyaWFscyB0byByZXByb2R1
Y2UgYXJlIGF2YWlsYWJsZSBhdDoNCj4+PiBodHRwczovL2Rvd25sb2FkLjAxLm9yZy8wZGF5LWNp
L2FyY2hpdmUvMjAyNTEwMjEvMjAyNTEwMjExMjA1LjFlMGY1MjIzLWxrcEBpbnRlbC5jb20NCj4+
DQo+Pg0KPj4gSSdtIGZhaWxpbmcgYXQgcnVubmluZyB0aGUga2VybmVsIGFzIGRlc2NyaWJlZCBp
bjoNCj4+DQo+PiAgICBodHRwczovL2Rvd25sb2FkLjAxLm9yZy8wZGF5LWNpL2FyY2hpdmUvMjAy
NTEwMjEvMjAyNTEwMjExMjA1LjFlMGY1MjIzLWxrcEBpbnRlbC5jb20vcmVwcm9kdWNlDQo+Pg0K
Pj4NCj4+IEkgdGhlbiBzdGFydCB0aGUgdGVzdCBhczoNCj4+DQo+PiByb290QHNwcjovdXNyL2xv
Y2FsL3NyYy9sa3AtdGVzdHMjIGJpbi9sa3AgcWVtdSAtayAvdXNyL3NyYy9saW51eC0yLjYvdG1w
LWJ1aWxkL2FyY2gveDg2L2Jvb3QvYnpJbWFnZSAtbSAvdXNyL3NyYy9saW51eC0yLjYvdG1wLWJ1
aWxkL21vZHVsZXMuY2d6IC91c3Ivc3JjL2xpbnV4LTIuNi90bXAtYnVpbGQvam9iLXNjcmlwdA0K
Pj4gcmVzdWx0X3Jvb3Q6IC9yb290Ly5sa3AvL3Jlc3VsdC90cmluaXR5L2dyb3VwLTA0LTUtMzAw
cy92bS1zbmIvcXVhbnRhbC1pMzg2LWNvcmUtMjAxOTA0MjYuY2d6L3g4Nl82NC1yYW5kY29uZmln
LTEyMS0yMDI1MTAyMC9nY2MtMTMvNzkxMDRiZWNmNDJiYWVlYjRhM2YyYjEwNmY5NTRiOWZjN2Mx
MGEzYy80DQo+PiBkb3dubG9hZGluZyBpbml0cmRzIC4uLg0KPj4gdXNlIGxvY2FsIG1vZHVsZXM6
IC9yb290Ly5sa3AvY2FjaGUvbW9kdWxlcy5jZ3oNCj4+IHNraXAgZG93bmxvYWRpbmcgL3Jvb3Qv
LmxrcC9jYWNoZS9vc2ltYWdlL3F1YW50YWwvcXVhbnRhbC1pMzg2LWNvcmUtMjAxOTA0MjYuY2d6
DQo+PiAxNTM2MzYgYmxvY2tzDQo+PiBza2lwIGRvd25sb2FkaW5nIC9yb290Ly5sa3AvY2FjaGUv
b3NpbWFnZS9wa2cvcXVhbnRhbC1pMzg2LWNvcmUuY2d6L3RyaW5pdHktc3RhdGljLWkzODYteDg2
XzY0LWY5MzI1NmZiXzIwMTktMDgtMjguY2d6DQo+PiA0ODEwMSBibG9ja3MNCj4+IGV4ZWMgY29t
bWFuZDogcWVtdS1zeXN0ZW0teDg2XzY0IC1lbmFibGUta3ZtIC1jcHUgU2FuZHlCcmlkZ2UgLWZz
ZGV2IGxvY2FsLGlkPXRlc3RfZGV2LHBhdGg9L3Jvb3QvLmxrcC8vcmVzdWx0L3RyaW5pdHkvZ3Jv
dXAtMDQtNS0zMDBzL3ZtLXNuYi9xdWFudGFsLWkzODYtY29yZS0yMDE5MDQyNi5jZ3oveDg2XzY0
LXJhbmRjb25maWctMTIxLTIwMjUxMDIwL2djYy0xMy83OTEwNGJlY2Y0MmJhZWViNGEzZjJiMTA2
Zjk1NGI5ZmM3YzEwYTNjLzQsc2VjdXJpdHlfbW9kZWw9bm9uZSAtZGV2aWNlIHZpcnRpby05cC1w
Y2ksZnNkZXY9dGVzdF9kZXYsbW91bnRfdGFnPTlwL3ZpcnRmc19tb3VudCAta2VybmVsIC91c3Iv
c3JjL2xpbnV4LTIuNi90bXAtYnVpbGQvYXJjaC94ODYvYm9vdC9iekltYWdlIC1hcHBlbmQgcm9v
dD0vZGV2L3JhbTAgUkVTVUxUX1JPT1Q9L3Jlc3VsdC90cmluaXR5L2dyb3VwLTA0LTUtMzAwcy92
bS1zbmIvcXVhbnRhbC1pMzg2LWNvcmUtMjAxOTA0MjYuY2d6L3g4Nl82NC1yYW5kY29uZmlnLTEy
MS0yMDI1MTAyMC9nY2MtMTMvNzkxMDRiZWNmNDJiYWVlYjRhM2YyYjEwNmY5NTRiOWZjN2MxMGEz
Yy8xIEJPT1RfSU1BR0U9L3BrZy9saW51eC94ODZfNjQtcmFuZGNvbmZpZy0xMjEtMjAyNTEwMjAv
Z2NjLTEzLzc5MTA0YmVjZjQyYmFlZWI0YTNmMmIxMDZmOTU0YjlmYzdjMTBhM2Mvdm1saW51ei02
LjE4LjAtcmMxLTAwMDAxLWc3OTEwNGJlY2Y0MmIgYnJhbmNoPWxpbnV4LWRldmVsL2RldmVsLWhv
dXJseS0yMDI1MTAxOS0xNTQ4NTUgam9iPS9sa3Avam9icy9zY2hlZHVsZWQvdm0tbWV0YS0yOTEv
dHJpbml0eS1ncm91cC0wNC01LTMwMHMtcXVhbnRhbC1pMzg2LWNvcmUtMjAxOTA0MjYuY2d6LXg4
Nl82NC1yYW5kY29uZmlnLTEyMS0yMDI1MTAyMC03OTEwNGJlY2Y0MmItMjAyNTEwMjAtMTI0OTA0
LTg1NDhodS0xLnlhbWwgdXNlcj1sa3AgQVJDSD14ODZfNjQga2NvbmZpZz14ODZfNjQtcmFuZGNv
bmZpZy0xMjEtMjAyNTEwMjAgY29tbWl0PTc5MTA0YmVjZjQyYmFlZWI0YTNmMmIxMDZmOTU0Yjlm
YzdjMTBhM2MgaW50cmVtYXA9cG9zdGVkX21zaSB2bWFsbG9jPTI1Nk0gaW5pdHJhbWZzX2FzeW5j
PTAgcGFnZV9vd25lcj1vbiBjYXJyaWVyX3RpbWVvdXQ9NjAgcmN1cGRhdGUucmN1X3NlbGZfdGVz
dD0wIG1heF91cHRpbWU9NzIwMCBMS1BfTE9DQUxfUlVOPTEgc2VsaW51eD0wIGRlYnVnIGFwaWM9
ZGVidWcgc3lzcnFfYWx3YXlzX2VuYWJsZWQgcmN1cGRhdGUucmN1X2NwdV9zdGFsbF90aW1lb3V0
PTEwMCBuZXQuaWZuYW1lcz0wIHByaW50ay5kZXZrbXNnPW9uIHBhbmljPS0xIHNvZnRsb2NrdXBf
cGFuaWM9MSBubWlfd2F0Y2hkb2c9cGFuaWMgb29wcz1wYW5pYyBsb2FkX3JhbWRpc2s9MiBwcm9t
cHRfcmFtZGlzaz0wIGRyYmQubWlub3JfY291bnQ9OCBzeXN0ZW1kLmxvZ19sZXZlbD1lcnIgaWdu
b3JlX2xvZ2xldmVsIGNvbnNvbGU9dHR5MCBlYXJseXByaW50az10dHlTMCwxMTUyMDAgY29uc29s
ZT10dHlTMCwxMTUyMDAgdmdhPW5vcm1hbCBydyAgaXA9ZGhjcCByZXN1bHRfc2VydmljZT05cC92
aXJ0ZnNfbW91bnQgLWluaXRyZCAvcm9vdC8ubGtwL2NhY2hlL2ZpbmFsX2luaXRyZCAtc21wIDIg
LW0gMTYzODRNIC1uby1yZWJvb3QgLWRldmljZSBpNjMwMGVzYiAtcnRjIGJhc2U9bG9jYWx0aW1l
IC1kZXZpY2UgZTEwMDAsbmV0ZGV2PW5ldDAgLW5ldGRldiB1c2VyLGlkPW5ldDAgLWRpc3BsYXkg
bm9uZSAtbW9uaXRvciBudWxsIC1zZXJpYWwgc3RkaW8NCj4gDQo+PiBbICAgIDUuNjUwODA3XVsg
ICAgVDFdIFN0YXJ0aW5nIGluaXQ6IC9iaW4vc2ggZXhpc3RzIGJ1dCBjb3VsZG4ndCBleGVjdXRl
IGl0IChlcnJvciAtOCkNCg0KTWF5IEkga25vdyBpZiB5b3UgYXJlIHVzaW5nIHRoZSBrZXJuZWwg
Y29uZmlnIDBkYXkgYXR0YWNoZWQ/DQpJIGZvdW5kIHRoYXQgdGhlIGNvbmZpZyAwZGF5IGF0dGFj
aGVkDQooaHR0cHM6Ly9kb3dubG9hZC4wMS5vcmcvMGRheS1jaS9hcmNoaXZlLzIwMjUxMDIxLzIw
MjUxMDIxMTIwNS4xZTBmNTIyMy1sa3BAaW50ZWwuY29tL2NvbmZpZy02LjE4LjAtcmMxLTAwMDAx
LWc3OTEwNGJlY2Y0MmIpDQpoYXMNCkNPTkZJR19JQTMyX0VNVUxBVElPTj15DQpDT05GSUdfSUEz
Ml9FTVVMQVRJT05fREVGQVVMVF9ESVNBQkxFRD15DQpDT05GSUdfQ09NUEFUXzMyPXkNCkNPTkZJ
R19DT01QQVQ9eQ0KDQpJdCBpcyBzdXNwZWN0ZWQgdGhhdCB0aGUgZmlsZXN5c3RlbSBwcm92aWRl
ZCBieSBsa3AgaXMgMzJiaXRzLCBtaWdodA0KbmVlZCBPbGl2ZXIncyBjb25maXJtLg0KDQoNCnRo
YW5rcywNCkNoZW55dQ0KPj4gWyAgICA1LjY1MTQ4MV1bICAgIFQxXSBLZXJuZWwgcGFuaWMgLSBu
b3Qgc3luY2luZzogTm8gd29ya2luZyBpbml0IGZvdW5kLiAgVHJ5IHBhc3NpbmcgaW5pdD0gb3B0
aW9uIHRvIGtlcm5lbC4gU2VlIExpbnV4IERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvaW5pdC5y
c3QgZm9yIGd1aWRhbmNlLg0KPj4gWyAgICA1LjY1Mjc4NF1bICAgIFQxXSBDUFU6IDAgVUlEOiAw
IFBJRDogMSBDb21tOiBzd2FwcGVyLzAgTm90IHRhaW50ZWQgNi4xOC4wLXJjMi0wMDE4Mi1nYmFi
OTllNThmOTFmICMzNSBQUkVFTVBUDQo+PiBbICAgIDUuNjUzNjY4XVsgICAgVDFdIEhhcmR3YXJl
IG5hbWU6IFFFTVUgU3RhbmRhcmQgUEMgKGk0NDBGWCArIFBJSVgsIDE5OTYpLCBCSU9TIDEuMTYu
My1kZWJpYW4tMS4xNi4zLTIgMDQvMDEvMjAxNA0KPj4gWyAgICA1LjY1NDU4Ml1bICAgIFQxXSBD
YWxsIFRyYWNlOg0KPj4gWyAgICA1LjY1NDg3M11bICAgIFQxXSAgPFRBU0s+DQo+PiBbICAgIDUu
NjU1MTM3XVsgICAgVDFdICBkdW1wX3N0YWNrX2x2bCsweDNhLzB4NzANCj4+IFsgICAgNS42NTU1
MzZdWyAgICBUMV0gIGR1bXBfc3RhY2srMHgxMC8weDIwDQo+PiBbICAgIDUuNjU1OTExXVsgICAg
VDFdICB2cGFuaWMrMHgxMDQvMHgyYzANCj4+IFsgICAgNS42NTYyNTZdWyAgICBUMV0gID8gcmVz
dF9pbml0KzB4MTQwLzB4MTQwDQo+PiBbICAgIDUuNjU2NjUyXVsgICAgVDFdICBwYW5pYysweDUx
LzB4NjANCj4+IFsgICAgNS42NTY5ODldWyAgICBUMV0gIGtlcm5lbF9pbml0KzB4MTExLzB4MTIw
DQo+PiBbICAgIDUuNjU3MzYwXVsgICAgVDFdICByZXRfZnJvbV9mb3JrKzB4MjUvMHgxNDANCj4+
IFsgICAgNS42NTc3NDFdWyAgICBUMV0gID8gcmVzdF9pbml0KzB4MTQwLzB4MTQwDQo+PiBbICAg
IDUuNjU4MTMwXVsgICAgVDFdICByZXRfZnJvbV9mb3JrX2FzbSsweDExLzB4MjANCj4+IFsgICAg
NS42NTg1NjNdWyAgICBUMV0gIDwvVEFTSz4NCj4+IFsgICAgNS42NTg4NDFdWyAgICBUMV0gS2Vy
bmVsIE9mZnNldDogZGlzYWJsZWQNCj4+DQo+IA0KPiBBbnkgY2x1ZXMgaG93IEkgY2FuIGdldCB0
aGlzIHRoaW5nIHRvIGFjdHVhbGx5IHJ1biB0aGUgdHJpbml0eSByZXF1aXJlZA0KPiB0byByZXBy
b2R1Y2UgaW5zdGVhZCBvZiBwYW5pYz8NCg==

